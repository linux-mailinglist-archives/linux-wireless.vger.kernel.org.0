Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC84566AEF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGLKca (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 06:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfGLKca (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 06:32:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFE8F58E23;
        Fri, 12 Jul 2019 10:32:29 +0000 (UTC)
Received: from localhost (ovpn-204-58.brq.redhat.com [10.40.204.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 936816019C;
        Fri, 12 Jul 2019 10:32:29 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT v2] rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK on tx status
Date:   Fri, 12 Jul 2019 12:32:28 +0200
Message-Id: <20190712103228.17658-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 12 Jul 2019 10:32:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to documentation IEEE80211_TX_STAT_AMPDU_NO_BACK is suppose
to be used when we do not receive BA (BlockAck). However on rt2x00 we
use it when remote station fail to decode one or more subframes within
AMPDU (some bits are not set in BlockAck bitmap). Setting the flag result
in sent of BAR (BlockAck Request) frame and this might result of abuse
of BA session, since remote station can sent BA with incorrect
sequence numbers after receiving BAR. This problem is visible especially
when connecting two rt2800 devices.

Previously I observed some performance benefits when using the flag
when connecting with iwlwifi devices. But currently possibly due
to recent changes in rt2x00 removing the flag has no effect on
those test cases.

So remove the IEEE80211_TX_STAT_AMPDU_NO_BACK.

Additionally partially mimic mt76 behaviour: send BAR when
starting/stopping BA session to workaround problems with some buggy
clients. Do not sent BAR on PS wakeup since we lack all PS handling
code what mt76 has.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  4 ++++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c |  3 ---
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 18 ++++++++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index c9b957ac5733..4a996550288e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10481,14 +10481,18 @@ int rt2800_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 */
 		break;
 	case IEEE80211_AMPDU_TX_START:
+		sta_priv->agg_ssn[tid] = IEEE80211_SN_TO_SEQ(params->ssn);
 		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+		ieee80211_send_bar(vif, sta->addr, tid, sta_priv->agg_ssn[tid]);
+		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		ieee80211_send_bar(vif, sta->addr, tid, sta_priv->agg_ssn[tid]);
 		break;
 	default:
 		rt2x00_warn((struct rt2x00_dev *)hw->priv,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 7e43690a861c..d35ef06c5c7a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -500,6 +500,7 @@ struct rt2x00intf_conf {
  */
 struct rt2x00_sta {
 	int wcid;
+	u16 agg_ssn[IEEE80211_NUM_TIDS];
 };
 
 static inline struct rt2x00_sta* sta_to_rt2x00_sta(struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 35414f97a978..ad063c920323 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -371,9 +371,6 @@ static void rt2x00lib_fill_tx_status(struct rt2x00_dev *rt2x00dev,
 				  IEEE80211_TX_CTL_AMPDU;
 		tx_info->status.ampdu_len = 1;
 		tx_info->status.ampdu_ack_len = success ? 1 : 0;
-
-		if (!success)
-			tx_info->flags |= IEEE80211_TX_STAT_AMPDU_NO_BACK;
 	}
 
 	if (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index beb20c5faf5f..14896d37f0cc 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -86,6 +86,21 @@ static int rt2x00mac_tx_rts_cts(struct rt2x00_dev *rt2x00dev,
 	return retval;
 }
 
+static void rt2x00mac_save_agg_seqno(struct sk_buff *skb,
+				     struct ieee80211_sta *sta)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct rt2x00_sta *sta_priv = sta_to_rt2x00_sta(sta);
+	u8 tid;
+
+	if (!ieee80211_is_data_qos(hdr->frame_control) ||
+	    !ieee80211_is_data_present(hdr->frame_control))
+		return;
+
+	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	sta_priv->agg_ssn[tid] = le16_to_cpu(hdr->seq_ctrl) + 0x10;
+}
+
 void rt2x00mac_tx(struct ieee80211_hw *hw,
 		  struct ieee80211_tx_control *control,
 		  struct sk_buff *skb)
@@ -119,6 +134,9 @@ void rt2x00mac_tx(struct ieee80211_hw *hw,
 		goto exit_free_skb;
 	}
 
+	if (control->sta)
+		rt2x00mac_save_agg_seqno(skb, control->sta);
+
 	/*
 	 * If CTS/RTS is required. create and queue that frame first.
 	 * Make sure we have at least enough entries available to send
-- 
2.20.1

