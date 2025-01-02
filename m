Return-Path: <linux-wireless+bounces-17003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D09FFBDE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D0E3A2CB7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FC18787F;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Ux2P4Wuo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D114D2BB
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835724; cv=none; b=FSDravOmqFjUC9bcF2R24ca8K405KAh5/WNXQLaHPwKtjDaw3CqLwn/0aP+RxtfjDHMo/VXwzBcW3K5JfLLX1uwnQIXo6i5MzHbEsWA7TsbZ8kdgHkrAV1/0Hjb8blT0FxE1lySzezODwhQuHEmmnqZWrcEVmUtujfR7GdEIcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835724; c=relaxed/simple;
	bh=b174JxKdOZaMvBNRSelZHrMYWHzY1Ktai/TkwIW+HF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt+QDr0VbYYTUTP/NOvcDOJvQhnImrceKyU/IEChNLADC5dahCrCtlMOG9mwPk29y9+OGD6yHXh6RHCQxkdJZplpV1WqY55XFLp+xz9bEvZdJYU7ATJQpCFz4p4cLuPccURYepR1kIqJ/EnzerDsiRoZvyZRZNnwHBNAh6U5EN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Ux2P4Wuo; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PmMMWeq4imuIF/io2ESY1Y3O3Tos4ka/UhYuIKoOQ9I=; b=Ux2P4Wuo/pFIFu2aOnKC4x+y3H
	9MD+gxVNtp8lV2amZ1L6YlWsgPva0ZvEKuviYFesXut21n+QelHTeK6zF7bWqpb1x+8cXwx2eKxeA
	TgBVgFJRnjMJL/TRWe+SwaZmP98y6xBt3wsgLP5k5cbUht/cmfKUPuyW6j60VG/QvvNI=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAB-0008GS-2u
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 03/24] wifi: mt76: rename struct mt76_vif to mt76_vif_link
Date: Thu,  2 Jan 2025 17:34:47 +0100
Message-ID: <20250102163508.52945-3-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation to use it for private bss link data instead of the full vif
on MLO capable devices.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 54 +++++++++----------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 14 ++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 26 ++++-----
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 12 ++---
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/scan.c     |  2 +-
 20 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index aac8ca7265c2..1782ebc7085e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -754,7 +754,7 @@ struct mt76_testmode_data {
 	} rx_stats;
 };
 
-struct mt76_vif {
+struct mt76_vif_link {
 	u8 idx;
 	u8 omac_idx;
 	u8 band_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 27c3857bcd7b..3ca4fae7c4b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -730,7 +730,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	u16 seqno = 0;
 
 	if (vif) {
-		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+		struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 
 		omac_idx = mvif->omac_idx;
 		wmm_idx = mvif->wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 646474aa828d..e883cf4e1095 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -464,7 +464,7 @@ mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	int err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 530da48ce3ea..9bdd29e8d25e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -139,7 +139,7 @@ struct mt7615_sta {
 };
 
 struct mt7615_vif {
-	struct mt76_vif mt76; /* must be first */
+	struct mt76_vif_link mt76; /* must be first */
 	struct mt7615_sta sta;
 	bool sta_added;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index fbb1181c58ff..a0ca3bbdfcaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -48,7 +48,7 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
 	if (vif) {
-		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+		struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 
 		txp->bss_idx = mvif->idx;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index f719457e39b2..5170af3e3428 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -294,7 +294,7 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 				 struct ieee80211_vif *vif,
 				 bool beacon, bool mcast)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = mvif->ctx ?
 					    &mvif->ctx->def : &mphy->chandef;
 	u8 nss = 0, mode = 0, band = chandef->chan->band;
@@ -505,7 +505,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	bool amsdu_en = wcid->amsdu;
 
 	if (vif) {
-		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+		struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 
 		omac_idx = mvif->omac_idx;
 		wmm_idx = mvif->wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4171710d645c..5c76a0885278 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -189,7 +189,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_mac_enable);
 
 int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		u8 bss_idx;
 		u8 ps_state; /* 0: device awake
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rts_thresh);
 void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_connac_beacon_loss_event *event = priv;
 
 	if (mvif->idx != event->bss_idx)
@@ -273,7 +273,7 @@ mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_nested_tlv);
 
 struct sk_buff *
-__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 				struct mt76_wcid *wcid, int len)
 {
 	struct sta_req_hdr hdr = {
@@ -329,7 +329,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_wtbl_req);
 void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 				  struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	u8 omac_idx = mvif->omac_idx;
 	struct bss_info_omac *omac;
 	struct tlv *tlv;
@@ -497,7 +497,7 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 					 struct ieee80211_vif *vif,
 					 struct mt76_wcid *wcid, int cmd)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
@@ -545,7 +545,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 				      struct ieee80211_sta *sta,
 				      void *sta_wtbl, void *wtbl_tlv)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct wtbl_generic *generic;
 	struct wtbl_rx *rx;
 	struct wtbl_spe *spe;
@@ -849,7 +849,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
 			     u8 rcpi, u8 sta_state)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = mvif->ctx ?
 					    &mvif->ctx->def : &mphy->chandef;
 	enum nl80211_band band = chandef->chan->band;
@@ -1041,7 +1041,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
 int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 			    struct mt76_sta_cmd_info *info)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)info->vif->drv_priv;
 	struct ieee80211_link_sta *link_sta;
 	struct mt76_dev *dev = phy->dev;
 	struct wtbl_req_hdr *wtbl_hdr;
@@ -1137,7 +1137,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ba_tlv);
 
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct ieee80211_bss_conf *bss_conf,
-				struct mt76_vif *mvif,
+				struct mt76_vif_link *mvif,
 				struct mt76_wcid *wcid,
 				bool enable)
 {
@@ -1266,7 +1266,7 @@ int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_wed_update);
 
-int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 			   struct ieee80211_ampdu_params *params,
 			   int cmd, bool enable, bool tx)
 {
@@ -1404,7 +1404,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode_ext);
 const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = mvif->ctx ?
 					    &mvif->ctx->def : &phy->chandef;
 	enum nl80211_band band = chandef->chan->band;
@@ -1453,7 +1453,7 @@ mt76_connac_mcu_uni_bss_he_tlv(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
 }
 
-int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy, struct mt76_vif_link *mvif,
 				  struct ieee80211_chanctx_conf *ctx)
 {
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
@@ -1541,7 +1541,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				bool enable,
 				struct ieee80211_chanctx_conf *ctx)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_dev *mdev = phy->dev;
@@ -1667,7 +1667,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
 int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_scan_request *scan_req)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_scan_request *sreq = &scan_req->req;
 	int n_ssids = 0, err, i, duration;
 	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
@@ -1773,7 +1773,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_hw_scan);
 int mt76_connac_mcu_cancel_hw_scan(struct mt76_phy *phy,
 				   struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		u8 seq_num;
 		u8 is_ext_channel;
@@ -1799,7 +1799,7 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 				   struct ieee80211_vif *vif,
 				   struct cfg80211_sched_scan_request *sreq)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct ieee80211_channel **scan_list = sreq->channels;
 	struct mt76_connac_mcu_scan_channel *chan;
 	struct mt76_connac_sched_scan_req *req;
@@ -2211,7 +2211,7 @@ int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
 
 int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
-				      struct mt76_vif *vif,
+				      struct mt76_vif_link *vif,
 				      struct ieee80211_bss_conf *info)
 {
 	struct ieee80211_vif *mvif = container_of(info, struct ieee80211_vif,
@@ -2254,7 +2254,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
 int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	int ct_window = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
 	struct mt76_phy *phy = hw->priv;
 	struct {
@@ -2321,7 +2321,7 @@ int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct cfg80211_gtk_rekey_data *key)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_connac_gtk_rekey_tlv *gtk_tlv;
 	struct mt76_phy *phy = hw->priv;
 	struct sk_buff *skb;
@@ -2362,7 +2362,7 @@ static int
 mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			       bool suspend)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -2388,7 +2388,7 @@ int
 mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			      bool suspend)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -2417,7 +2417,7 @@ mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
 				 bool enable, u8 mdtim,
 				 bool wow_suspend)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -2448,7 +2448,7 @@ mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
 				u8 index, bool enable,
 				struct cfg80211_pkt_pattern *pattern)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_connac_wow_pattern_tlv *ptlv;
 	struct sk_buff *skb;
 	struct req_hdr {
@@ -2480,7 +2480,7 @@ int
 mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			     bool suspend, struct cfg80211_wowlan *wowlan)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
@@ -2689,7 +2689,7 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			    struct ieee80211_key_conf *key, int mcu_cmd,
 			    struct mt76_wcid *wcid, enum set_key_cmd cmd)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct sk_buff *skb;
 	int ret;
 
@@ -2711,7 +2711,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_key);
 
 /* SIFS 20us + 512 byte beacon transmitted by 1Mbps (3906us) */
 #define BCN_TX_ESTIMATE_TIME (4096 + 20)
-void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif *mvif)
+void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif_link *mvif)
 {
 	struct bss_info_ext_bss *ext;
 	int ext_bss_idx, tsf_offset;
@@ -2735,7 +2735,7 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 				  struct mt76_phy *phy, u16 wlan_idx,
 				  bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	u32 type = vif->p2p ? NETWORK_P2P : NETWORK_INFRA;
 	struct bss_info_basic *bss;
 	struct tlv *tlv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 919194ab6265..8f23b9e58d2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1878,10 +1878,10 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 }
 
 struct sk_buff *
-__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 				struct mt76_wcid *wcid, int len);
 static inline struct sk_buff *
-mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 			      struct mt76_wcid *wcid)
 {
 	return __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
@@ -1940,14 +1940,14 @@ void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
 				bool enable, bool tx);
 int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct ieee80211_bss_conf *bss_conf,
-				struct mt76_vif *mvif,
+				struct mt76_vif_link *mvif,
 				struct mt76_wcid *wcid,
 				bool enable);
-int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 			   struct ieee80211_ampdu_params *params,
 			   int cmd, bool enable, bool tx);
 int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy,
-				  struct mt76_vif *vif,
+				  struct mt76_vif_link *vif,
 				  struct ieee80211_chanctx_conf *ctx);
 int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
@@ -1978,7 +1978,7 @@ int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 				      struct ieee80211_vif *vif,
 				      bool enable);
 int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
-				      struct mt76_vif *vif,
+				      struct mt76_vif_link *vif,
 				      struct ieee80211_bss_conf *info);
 int mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 				  bool suspend);
@@ -2025,7 +2025,7 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			    struct ieee80211_key_conf *key, int mcu_cmd,
 			    struct mt76_wcid *wcid, enum set_key_cmd cmd);
 
-void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif *mvif);
+void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif_link *mvif);
 void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 				  struct ieee80211_vif *vif);
 int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 5fe872ef2e93..533939f2b7ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -166,7 +166,7 @@ struct mt7915_vif_cap {
 };
 
 struct mt7915_vif {
-	struct mt76_vif mt76; /* must be first */
+	struct mt76_vif_link mt76; /* must be first */
 
 	struct mt7915_vif_cap cap;
 	struct mt7915_sta sta;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 3f45221d00e8..86bd33b916a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -180,7 +180,7 @@ static void
 mt7921_mcu_connection_loss_iter(void *priv, u8 *mac,
 				struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_connac_beacon_loss_event *event = priv;
 
 	if (mvif->idx != event->bss_idx)
@@ -1131,7 +1131,7 @@ int mt7921_get_txpwr_info(struct mt792x_dev *dev, struct mt7921_txpwr *txpwr)
 int mt7921_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		struct {
 			u8 band_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 187770537a1a..91e854e3d0e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -730,7 +730,7 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0, band_idx = 0;
 	u32 val, sz_txd = mt76_is_mmio(dev) ? MT_TXD_SIZE : MT_SDIO_TXD_SIZE;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt76_vif *mvif;
+	struct mt76_vif_link *mvif;
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
 				    BSS_CHANGED_BEACON_ENABLED));
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -739,7 +739,7 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 	mconf = vif ? mt792x_vif_to_link((struct mt792x_vif *)vif->drv_priv,
 					 wcid->link_id) : NULL;
-	mvif = mconf ? (struct mt76_vif *)&mconf->mt76 : NULL;
+	mvif = mconf ? (struct mt76_vif_link *)&mconf->mt76 : NULL;
 
 	if (mvif) {
 		omac_idx = mvif->omac_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a6944de712cc..a4a673637fa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -803,7 +803,7 @@ static u8
 mt7925_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       bool beacon, bool mcast)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
 	u8 i, idx, ht;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d4d3ecf863c4..6bd5322bcf14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -164,7 +164,7 @@ static int
 mt7925_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			       bool suspend, struct cfg80211_wowlan *wowlan)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
@@ -219,7 +219,7 @@ mt7925_mcu_set_wow_pattern(struct mt76_dev *dev,
 			   u8 index, bool enable,
 			   struct cfg80211_pkt_pattern *pattern)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7925_wow_pattern_tlv *tlv;
 	struct sk_buff *skb;
 	struct {
@@ -274,7 +274,7 @@ static void
 mt7925_mcu_connection_loss_iter(void *priv, u8 *mac,
 				struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7925_uni_beacon_loss_event *event = priv;
 
 	if (mvif->idx != event->hdr.bss_idx)
@@ -304,7 +304,7 @@ mt7925_mcu_connection_loss_event(struct mt792x_dev *dev, struct sk_buff *skb)
 static void
 mt7925_mcu_roc_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7925_roc_grant_tlv *grant = priv;
 
 	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION)
@@ -528,7 +528,7 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 }
 
 static int
-mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 		  struct mt76_wcid *wcid,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
@@ -1807,7 +1807,7 @@ static int
 mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		   struct mt76_sta_cmd_info *info)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct sk_buff *skb;
 	int conn_state;
@@ -2264,7 +2264,7 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 }
 
 static struct sk_buff *
-__mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
+__mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif_link *mvif, int len)
 {
 	struct bss_req_hdr hdr = {
 		.bss_idx = mvif->idx,
@@ -2280,7 +2280,7 @@ __mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
 	return skb;
 }
 
-int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif_link *mvif,
 			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx)
 {
@@ -2433,7 +2433,7 @@ mt7925_mcu_bss_sec_tlv(struct sk_buff *skb,
 		       struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	struct mt76_vif *mvif = &mconf->mt76;
+	struct mt76_vif_link *mvif = &mconf->mt76;
 	struct bss_sec_tlv {
 		__le16 tag;
 		__le16 len;
@@ -2484,7 +2484,7 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 						  &link_conf->chanreq.oper;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	enum nl80211_band band = chandef->chan->band;
-	struct mt76_vif *mvif = &mconf->mt76;
+	struct mt76_vif_link *mvif = &mconf->mt76;
 	struct bss_rate_tlv *bmc;
 	struct tlv *tlv;
 	u8 idx = mvif->mcast_rates_idx ?
@@ -2692,7 +2692,7 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_scan_request *sreq = &scan_req->req;
 	int n_ssids = 0, err, i;
 	struct ieee80211_channel **scan_list = sreq->channels;
@@ -2801,7 +2801,7 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 			      struct ieee80211_vif *vif,
 			      struct cfg80211_sched_scan_request *sreq)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct ieee80211_channel **scan_list = sreq->channels;
 	struct mt76_connac_mcu_scan_channel *chan;
 	struct mt76_dev *mdev = phy->dev;
@@ -2937,7 +2937,7 @@ mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
 			      struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct {
 		struct scan_hdr {
 			u8 seq_num;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index fe6a613ba008..1e47d2c61b54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -637,7 +637,7 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
 int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
-int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif_link *mvif,
 			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx);
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 3f989e83f252..e331a056950f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -117,7 +117,7 @@ struct mt792x_chanctx {
 };
 
 struct mt792x_bss_conf {
-	struct mt76_vif mt76; /* must be first */
+	struct mt76_vif_link mt76; /* must be first */
 	struct mt792x_vif *vif;
 	struct ewma_rssi rssi;
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 8e3620d8a7c8..fb6ab96cdeab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -831,7 +831,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt76_vif *mvif;
+	struct mt76_vif_link *mvif;
 	u16 tx_count = 15;
 	u32 val;
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -839,7 +839,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
 				    BSS_CHANGED_BEACON_ENABLED)) && (!inband_disc);
 
-	mvif = vif ? (struct mt76_vif *)vif->drv_priv : NULL;
+	mvif = vif ? (struct mt76_vif_link *)vif->drv_priv : NULL;
 	if (mvif) {
 		omac_idx = mvif->omac_idx;
 		wmm_idx = mvif->wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f3ca01899503..e0589b029167 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -532,7 +532,7 @@ static u8
 mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       bool beacon, bool mcast)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
 	u8 i, idx;
@@ -583,7 +583,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index b3c7f4196ab4..d25afd1f67fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -852,7 +852,7 @@ static void
 mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		       struct mt7996_phy *phy)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct bss_rate_tlv *bmc;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
@@ -899,7 +899,7 @@ mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 static void
 mt7996_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct bss_sec_tlv *sec;
 	struct tlv *tlv;
 
@@ -988,7 +988,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 			 struct mt76_phy *phy, u16 wlan_idx,
 			 bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &phy->chandef;
 	struct mt76_connac_bss_basic_tlv *bss;
 	u32 type = CONNECTION_INFRA_AP;
@@ -1060,7 +1060,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 }
 
 static struct sk_buff *
-__mt7996_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
+__mt7996_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif_link *mvif, int len)
 {
 	struct bss_req_hdr hdr = {
 		.bss_idx = mvif->idx,
@@ -1140,7 +1140,7 @@ int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif)
 }
 
 static int
-mt7996_mcu_sta_ba(struct mt7996_dev *dev, struct mt76_vif *mvif,
+mt7996_mcu_sta_ba(struct mt7996_dev *dev, struct mt76_vif_link *mvif,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
@@ -2283,7 +2283,7 @@ int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
 		       struct mt76_wcid *wcid, enum set_key_cmd cmd)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct sk_buff *skb;
 	int ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d2bc96877797..465e3d9fd26d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -200,7 +200,7 @@ struct mt7996_sta {
 };
 
 struct mt7996_vif {
-	struct mt76_vif mt76; /* must be first */
+	struct mt76_vif_link mt76; /* must be first */
 
 	struct mt7996_sta sta;
 	struct mt7996_phy *phy;
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 79172ad3fa6e..70884faab905 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -33,7 +33,7 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 {
 	struct cfg80211_scan_request *req = dev->scan.req;
 	struct ieee80211_vif *vif = dev->scan.vif;
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	enum nl80211_band band = dev->scan.chan->band;
 	struct mt76_phy *phy = dev->scan.phy;
 	struct ieee80211_tx_info *info;
-- 
2.47.1


