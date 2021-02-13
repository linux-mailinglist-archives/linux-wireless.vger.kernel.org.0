Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5931AD71
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBMRwE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 12:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBMRwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 12:52:01 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F9C061788
        for <linux-wireless@vger.kernel.org>; Sat, 13 Feb 2021 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R6WYCisuAOFut1fzL8MmjMli42cY62Lum5I5tkIQK/Q=; b=LlVUp6Ea6lBbFS2K25RSlq4/AU
        5LhVSeu6HnmlM/vUe+bttX7vFShaLQY/ChQ3h4zEyTXgZkEwJ85nDdowIYPllzFCOH1eUwRHoPZtH
        oFdRvgTBXo1MF5cned5eNQhKUqeRd8GZG1SaXz6x/txRPYG5szRE/MlJgYGIwj1N+2jw=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lAz4P-0007si-Vg
        for linux-wireless@vger.kernel.org; Sat, 13 Feb 2021 18:51:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] mt76: add support for 802.3 rx frames
Date:   Sat, 13 Feb 2021 18:50:54 +0100
Message-Id: <20210213175100.22608-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not try to access the header when receiving them

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 13 ++++++-----
 drivers/net/wireless/mediatek/mt76/mac80211.c | 23 ++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  4 +++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 8 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index df25c00d9e06..144e8a8910ba 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -122,6 +122,7 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 	struct ieee80211_bar *bar = mt76_skb_get_hdr(skb);
 	struct mt76_wcid *wcid = status->wcid;
 	struct mt76_rx_tid *tid;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 	u16 seqno;
 
 	if (!ieee80211_is_ctl(bar->frame_control))
@@ -130,9 +131,9 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 	if (!ieee80211_is_back_req(bar->frame_control))
 		return;
 
-	status->tid = le16_to_cpu(bar->control) >> 12;
+	status->qos_ctl = tidno = le16_to_cpu(bar->control) >> 12;
 	seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(bar->start_seq_num));
-	tid = rcu_dereference(wcid->aggr[status->tid]);
+	tid = rcu_dereference(wcid->aggr[tidno]);
 	if (!tid)
 		return;
 
@@ -147,12 +148,12 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
 	struct mt76_wcid *wcid = status->wcid;
 	struct ieee80211_sta *sta;
 	struct mt76_rx_tid *tid;
 	bool sn_less;
 	u16 seqno, head, size, idx;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 	u8 ackp;
 
 	__skb_queue_tail(frames, skb);
@@ -161,18 +162,18 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 	if (!sta)
 		return;
 
-	if (!status->aggr) {
+	if (!status->aggr && !(status->flag & RX_FLAG_8023)) {
 		mt76_rx_aggr_check_ctl(skb, frames);
 		return;
 	}
 
 	/* not part of a BA session */
-	ackp = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_ACK_POLICY_MASK;
+	ackp = status->qos_ctl & IEEE80211_QOS_CTL_ACK_POLICY_MASK;
 	if (ackp != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
 	    ackp != IEEE80211_QOS_CTL_ACK_POLICY_NORMAL)
 		return;
 
-	tid = rcu_dereference(wcid->aggr[status->tid]);
+	tid = rcu_dereference(wcid->aggr[tidno]);
 	if (!tid)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 696d00d1976c..f9381bd96244 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -737,6 +737,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_wcid *wcid = status->wcid;
 	struct ieee80211_hdr *hdr;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 	int ret;
 
 	if (!(status->flag & RX_FLAG_DECRYPTED))
@@ -757,12 +758,12 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	}
 
 	BUILD_BUG_ON(sizeof(status->iv) != sizeof(wcid->rx_key_pn[0]));
-	ret = memcmp(status->iv, wcid->rx_key_pn[status->tid],
+	ret = memcmp(status->iv, wcid->rx_key_pn[tidno],
 		     sizeof(status->iv));
 	if (ret <= 0)
 		return -EINVAL; /* replay */
 
-	memcpy(wcid->rx_key_pn[status->tid], status->iv, sizeof(status->iv));
+	memcpy(wcid->rx_key_pn[tidno], status->iv, sizeof(status->iv));
 
 	if (status->flag & RX_FLAG_IV_STRIPPED)
 		status->flag |= RX_FLAG_PN_VALIDATED;
@@ -785,6 +786,7 @@ mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
 	};
 	struct ieee80211_sta *sta;
 	u32 airtime;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 
 	airtime = ieee80211_calc_rx_airtime(dev->hw, &info, len);
 	spin_lock(&dev->cc_lock);
@@ -795,7 +797,7 @@ mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
 		return;
 
 	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
-	ieee80211_sta_register_airtime(sta, status->tid, 0, airtime);
+	ieee80211_sta_register_airtime(sta, tidno, 0, airtime);
 }
 
 static void
@@ -823,7 +825,6 @@ mt76_airtime_flush_ampdu(struct mt76_dev *dev)
 static void
 mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)
 {
-	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_wcid *wcid = status->wcid;
 
@@ -831,6 +832,11 @@ mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)
 		return;
 
 	if (!wcid || !wcid->sta) {
+		struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+		if (status->flag & RX_FLAG_8023)
+			return;
+
 		if (!ether_addr_equal(hdr->addr1, dev->phy.macaddr))
 			return;
 
@@ -864,10 +870,12 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct ieee80211_hw *hw;
 	struct mt76_wcid *wcid = status->wcid;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 	bool ps;
 
 	hw = mt76_phy_hw(dev, status->ext_phy);
-	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid) {
+	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid &&
+	    !(status->flag & RX_FLAG_8023)) {
 		sta = ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL);
 		if (sta)
 			wcid = status->wcid = (struct mt76_wcid *)sta->drv_priv;
@@ -885,6 +893,9 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 
 	wcid->inactive_count = 0;
 
+	if (status->flag & RX_FLAG_8023)
+		return;
+
 	if (!test_bit(MT_WCID_FLAG_CHECK_PS, &wcid->flags))
 		return;
 
@@ -902,7 +913,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 
 	if (ps && (ieee80211_is_data_qos(hdr->frame_control) ||
 		   ieee80211_is_qos_nullfunc(hdr->frame_control)))
-		ieee80211_sta_uapsd_trigger(sta, status->tid);
+		ieee80211_sta_uapsd_trigger(sta, tidno);
 
 	if (!!test_bit(MT_WCID_FLAG_PS, &wcid->flags) == ps)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8bf45497cfca..a3455e2e1545 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -499,7 +499,7 @@ struct mt76_rx_status {
 
 	u8 ext_phy:1;
 	u8 aggr:1;
-	u8 tid;
+	u8 qos_ctl;
 	u16 seqno;
 
 	u16 freq;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index cc4e7bc48294..c29b60a87819 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -651,7 +651,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 
 	status->aggr = unicast &&
 		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
 	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 59fdd0fc2ad4..6a835568f4a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -458,7 +458,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	status->aggr = unicast &&
 		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
 	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 771bad60e1bc..0da37867cb64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -770,6 +770,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 			   void *rxi)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_hdr *hdr;
 	struct mt76x02_rxwi *rxwi = rxi;
 	struct mt76x02_sta *sta;
 	u32 rxinfo = le32_to_cpu(rxwi->rxinfo);
@@ -864,7 +865,8 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 	status->freq = dev->mphy.chandef.chan->center_freq;
 	status->band = dev->mphy.chandef.chan->band;
 
-	status->tid = FIELD_GET(MT_RXWI_TID, tid_sn);
+	hdr = (struct ieee80211_hdr *)skb->data;
+	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
 	status->seqno = FIELD_GET(MT_RXWI_SN, tid_sn);
 
 	return mt76x02_mac_process_rate(dev, status, rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index eb889f8d6fea..2f2023ded8cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -556,7 +556,7 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	status->aggr = unicast &&
 		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
 	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 3f9097481a5e..9468c9c3b9cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -530,7 +530,7 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	status->aggr = unicast &&
 		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
 	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	return 0;
-- 
2.28.0

