Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C170F396462
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhEaP5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 11:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234538AbhEaPzS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 11:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0625C6128A;
        Mon, 31 May 2021 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622476415;
        bh=+7AgTrJ4S/ai5sFmRtGO3/etKkgraUw3+5cXKWsTz/s=;
        h=From:To:Cc:Subject:Date:From;
        b=qoP91tKuLlCYO4iWjW8XMPatZkZjaL/AFeydff3r0JARA2JYInWP8DO7sLZdpri4p
         I7MBHfdQEMLiZpMrLGMOCpZlfgFV6akFG789VtHZEgKS9ZI3eSNv66xSRmWTVbfpeV
         XyCD8DLEblnLyAqA6c9vhKtMJ6V+EW6qDbojDpoUBHUAPDe7Y38gWNvnilV2Acbc1Z
         B/fqslsq2SBQsGyr0xNKd2wo6uUrB1FWupLO86KX8s/NvtyU/sdLGvgyR0oPDzMj1G
         ocWDi+c8fzWdO1QXCYo05ODmYJNqsh6oBlVbF0L1eTFKUjYAEsEQ1IVv+Cdq09U44X
         icvw+AuA0PcSQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: remove mt7921_get_wtbl_info routine
Date:   Mon, 31 May 2021 17:53:29 +0200
Message-Id: <587728b3284116e05fd04fcddd8f5ebe38b83414.1622476356.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since now the fw reports tx rate events without polling,
mt7921_get_wtbl_info and related structures are no longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  57 ---------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 115 ------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 -
 3 files changed, 173 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 7b366df4a8ea..ffc83717fd0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -398,43 +398,6 @@ mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy,
 	}
 }
 
-static void
-mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
-			  u16 wlan_idx)
-{
-	struct mt7921_mcu_wlan_info_event *wtbl_info;
-	struct mt76_phy *mphy = &dev->mphy;
-	struct mt7921_sta_stats *stats;
-	struct rate_info rate = {};
-	struct mt7921_sta *msta;
-	struct mt76_wcid *wcid;
-	u8 idx;
-
-	if (wlan_idx >= MT76_N_WCIDS)
-		return;
-
-	wtbl_info = (struct mt7921_mcu_wlan_info_event *)skb->data;
-	idx = wtbl_info->rate_info.rate_idx;
-	if (idx >= ARRAY_SIZE(wtbl_info->rate_info.rate))
-		return;
-
-	rcu_read_lock();
-
-	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
-	if (!wcid)
-		goto out;
-
-	msta = container_of(wcid, struct mt7921_sta, wcid);
-	stats = &msta->stats;
-
-	/* current rate */
-	mt7921_mcu_tx_rate_parse(mphy, &wtbl_info->peer_cap, &rate,
-				 le16_to_cpu(wtbl_info->rate_info.rate[idx]));
-	stats->tx_rate = rate;
-out:
-	rcu_read_unlock();
-}
-
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -1192,26 +1155,6 @@ int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
 	return 0;
 }
 
-u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u32 wlan_idx)
-{
-	struct mt7921_mcu_wlan_info wtbl_info = {
-		.wlan_idx = cpu_to_le32(wlan_idx),
-	};
-	struct sk_buff *skb;
-	int ret;
-
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_GET_WTBL,
-					&wtbl_info, sizeof(wtbl_info), true,
-					&skb);
-	if (ret)
-		return ret;
-
-	mt7921_mcu_tx_rate_report(dev, skb, wlan_idx);
-	dev_kfree_skb(skb);
-
-	return 0;
-}
-
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 22ebef4add00..89fed2f71161 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -255,86 +255,6 @@ struct mt7921_mcu_reg_event {
 	__le32 val;
 } __packed;
 
-struct mt7921_mcu_tx_config {
-	u8 peer_addr[ETH_ALEN];
-	u8 sw;
-	u8 dis_rx_hdr_tran;
-
-	u8 aad_om;
-	u8 pfmu_idx;
-	__le16 partial_aid;
-
-	u8 ibf;
-	u8 ebf;
-	u8 is_ht;
-	u8 is_vht;
-
-	u8 mesh;
-	u8 baf_en;
-	u8 cf_ack;
-	u8 rdg_ba;
-
-	u8 rdg;
-	u8 pm;
-	u8 rts;
-	u8 smps;
-
-	u8 txop_ps;
-	u8 not_update_ipsm;
-	u8 skip_tx;
-	u8 ldpc;
-
-	u8 qos;
-	u8 from_ds;
-	u8 to_ds;
-	u8 dyn_bw;
-
-	u8 amdsu_cross_lg;
-	u8 check_per;
-	u8 gid_63;
-	u8 he;
-
-	u8 vht_ibf;
-	u8 vht_ebf;
-	u8 vht_ldpc;
-	u8 he_ldpc;
-} __packed;
-
-struct mt7921_mcu_sec_config {
-	u8 wpi_flag;
-	u8 rv;
-	u8 ikv;
-	u8 rkv;
-
-	u8 rcid;
-	u8 rca1;
-	u8 rca2;
-	u8 even_pn;
-
-	u8 key_id;
-	u8 muar_idx;
-	u8 cipher_suit;
-	u8 rsv[1];
-} __packed;
-
-struct mt7921_mcu_key_config {
-	u8 key[32];
-} __packed;
-
-struct mt7921_mcu_rate_info {
-	u8 mpdu_fail;
-	u8 mpdu_tx;
-	u8 rate_idx;
-	u8 rsv[1];
-	__le16 rate[8];
-} __packed;
-
-struct mt7921_mcu_ba_config {
-	u8 ba_en;
-	u8 rsv[3];
-	__le32 ba_winsize;
-} __packed;
-
 struct mt7921_mcu_ant_id_config {
 	u8 ant_id[4];
 } __packed;
@@ -358,41 +278,6 @@ struct mt7921_mcu_peer_cap {
 	u8 rsv[1];
 } __packed;
 
-struct mt7921_mcu_rx_cnt {
-	u8 rx_rcpi[4];
-	u8 rx_cc[4];
-	u8 rx_cc_sel;
-	u8 ce_rmsd;
-	u8 rsv[2];
-} __packed;
-
-struct mt7921_mcu_tx_cnt {
-	__le16 rate1_cnt;
-	__le16 rate1_fail_cnt;
-	__le16 rate2_cnt;
-	__le16 rate3_cnt;
-	__le16 cur_bw_tx_cnt;
-	__le16 cur_bw_tx_fail_cnt;
-	__le16 other_bw_tx_cnt;
-	__le16 other_bw_tx_fail_cnt;
-} __packed;
-
-struct mt7921_mcu_wlan_info_event {
-	struct mt7921_mcu_tx_config tx_config;
-	struct mt7921_mcu_sec_config sec_config;
-	struct mt7921_mcu_key_config key_config;
-	struct mt7921_mcu_rate_info rate_info;
-	struct mt7921_mcu_ba_config ba_config;
-	struct mt7921_mcu_peer_cap peer_cap;
-	struct mt7921_mcu_rx_cnt rx_cnt;
-	struct mt7921_mcu_tx_cnt tx_cnt;
-} __packed;
-
-struct mt7921_mcu_wlan_info {
-	__le32 wlan_idx;
-	struct mt7921_mcu_wlan_info_event event;
-} __packed;
-
 struct mt7921_txpwr_req {
 	u8 ver;
 	u8 action;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 30902231a4bf..8aa8d2ecdffa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -367,7 +367,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
-u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u32 wlan_idx);
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			     bool enable);
-- 
2.31.1

