Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574E01B52A7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgDWCm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 22:42:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:59375 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgDWCm2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 22:42:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587609748; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=tbRyexWXSxZmHkkyvkQyQ6qIGrWlODsLIlrE1ItUoRo=; b=LgBeeGKEJj4kqkR71VTSTN5Qd8023Qioy3iMUMmQZAX3unJ/MLOzbBtLl9hDyAszgC7JMx4D
 1q4D5eMygAiRT4gEp1FVNR7DgxhbHT/tqMuwgA9/Df6rn3rpOPQUuaQfSZnPf+C9skSrMN4P
 IMRPywZ7rMIZu9qjNCyyQM5AoB8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea10083.7f9bd0500fb8-smtp-out-n03;
 Thu, 23 Apr 2020 02:42:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D3B9C433D2; Thu, 23 Apr 2020 02:42:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64345C433CB;
        Thu, 23 Apr 2020 02:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64345C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: add statistics of tx retries and tx failed when tx complete disable
Date:   Thu, 23 Apr 2020 10:41:34 +0800
Message-Id: <20200423024134.10601-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When tx complete is disabled, all tx status will be set with status
HTT_TX_COMPL_STATE_ACK and indicate to mac80211 by ieee80211_tx_status,
then it does not have the statistics for retries and failed packets.
count of tx retries and tx failed of command "iw wlan0 station dump"
are both 0. If tx complete is not disabled, then firmware report the
tx status and ath10k indicate the status to mac80211, then mac80211
save the statistics and command "iw wlan0 station dump" show them.

for example:
localhost ~ # iw dev wlan0 station dump
Station 3c:28:6d:96:fd:69 (on wlan0)
	inactive time:	5 ms
	rx bytes:	1325012
	rx packets:	6477
	tx bytes:	85264
	tx packets:	518
	tx retries:	0
	tx failed:	0

This patch only effect chips with tx complete disabled, e.g. SDIO.

with this patch, output of command "iw dev wlan0 station dump":
Station c4:04:15:5d:97:22 (on wlan0)
        inactive time:  608 ms
        rx bytes:       180366
        rx packets:     991
        tx bytes:       98765577
        tx packets:     64624
        tx retries:     14682
        tx failed:      47086

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h   | 2 ++
 drivers/net/wireless/ath/ath10k/htt_rx.c | 7 +++++++
 drivers/net/wireless/ath/ath10k/mac.c    | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index d6adcbaf9616..07935d39d6d6 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -500,6 +500,8 @@ struct ath10k_sta {
 	u16 peer_id;
 	struct rate_info txrate;
 	struct ieee80211_tx_info tx_info;
+	u32 tx_retries;
+	u32 tx_failed;
 	u32 last_tx_bitrate;
 
 	struct work_struct update_wk;
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 816af1a8ad69..d787cbead56a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3574,6 +3574,13 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 		ieee80211_tx_rate_update(ar->hw, sta, &arsta->tx_info);
 	}
 
+	if (ar->htt.disable_tx_comp) {
+		arsta->tx_retries += peer_stats->retry_pkts;
+		arsta->tx_failed += peer_stats->failed_pkts;
+		ath10k_dbg(ar, ATH10K_DBG_HTT, "htt tx retries %d tx failed %d\n",
+			   arsta->tx_retries, arsta->tx_failed);
+	}
+
 	if (ath10k_debug_is_extd_tx_stats_enabled(ar))
 		ath10k_accumulate_per_peer_tx_stats(ar, arsta, peer_stats,
 						    rate_idx);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 6791c0035be0..842ae5a529ad 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8321,6 +8321,13 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	}
 	sinfo->txrate.flags = arsta->txrate.flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+	if (ar->htt.disable_tx_comp) {
+		sinfo->tx_retries = arsta->tx_retries;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+		sinfo->tx_failed = arsta->tx_failed;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	}
 }
 
 static const struct ieee80211_ops ath10k_ops = {
-- 
2.23.0
