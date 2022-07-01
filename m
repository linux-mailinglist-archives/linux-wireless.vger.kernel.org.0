Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E36B562FA5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiGAJQQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiGAJQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35354457A2
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA84622C7
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 09:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5753CC3411E;
        Fri,  1 Jul 2022 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656666971;
        bh=apETo14tlbZEL/Lbm1wxq4d9lskoxEMBJbYVms5dzRI=;
        h=From:To:Cc:Subject:Date:From;
        b=i4Z8uc21bs6LQV1t8pWHFFCKRtqYV4Adpk58RLQCuc+q3xYJtDOtQ81mE6dOkfjAo
         YFooAGr2VYH9aZovTim4kcttimqyaseWUYyfc0aI5hxzBW+ha0IHLd3hwQHO+eIjDa
         V5ZdOe4U7+Z2N9pPAYnlfPwTaW5EDIUkJsrkRM6aI1w+qL7ZyTotQ0t5tYwFkWeUum
         MJ/qik5wREBDGEWwaR6C+fCbtPMpO2HcsynEsPb9+Slj9MTLbCLWGNo9SCJR7fH7ya
         h3kykGf1iHvupegCxuCtgzOQDGsQaOd4mZMCSaVgppIazfnEJyHaIEgijE6R1dym0A
         zSkgzDtorCtaQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH] mt76: connac: move connac2 shared mcu commands in mt76-connac module
Date:   Fri,  1 Jul 2022 11:15:57 +0200
Message-Id: <705ae0f0b933bc59c50dfd0f01a5ce128acf66d1.1656666893.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move connac2 shared commands in mt76-connac module. THis is a
preliminary patch to add mt7990e driver support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  88 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 712 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  33 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  16 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  17 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   8 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 797 +-----------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  41 -
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  25 +-
 .../wireless/mediatek/mt76/mt7915/testmode.c  |   3 +-
 12 files changed, 903 insertions(+), 847 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index a46379bdd74b..7fcfe6c02054 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -17,6 +17,9 @@
 #define MT76_CONNAC_COREDUMP_TIMEOUT		(HZ / 20)
 #define MT76_CONNAC_COREDUMP_SZ			(1300 * 1024)
 
+#define MT76_CONNAC_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT76_CONNAC_CFEND_RATE_11B	0x03	/* 11B LP, 11M */
+
 #define MT_TXD_SIZE				(8 * 4)
 
 #define MT_USB_TXD_SIZE				(MT_TXD_SIZE + 8 * 4)
@@ -155,6 +158,35 @@ struct mt76_connac_tx_free {
 	__le32 txd;
 } __packed __aligned(4);
 
+struct mt76_connac2_vif_cap {
+	bool ht_ldpc:1;
+	bool vht_ldpc:1;
+	bool he_ldpc:1;
+	bool vht_su_ebfer:1;
+	bool vht_su_ebfee:1;
+	bool vht_mu_ebfer:1;
+	bool vht_mu_ebfee:1;
+	bool he_su_ebfer:1;
+	bool he_su_ebfee:1;
+	bool he_mu_ebfer:1;
+};
+
+enum mt76_conanc2_mmps_mode {
+	MCU_MMPS_STATIC,
+	MCU_MMPS_DYNAMIC,
+	MCU_MMPS_RSV,
+	MCU_MMPS_DISABLE,
+};
+
+enum {
+	RATE_PARAM_FIXED = 3,
+	RATE_PARAM_MMPS_UPDATE = 5,
+	RATE_PARAM_FIXED_HE_LTF = 7,
+	RATE_PARAM_FIXED_MCS,
+	RATE_PARAM_FIXED_GI = 11,
+	RATE_PARAM_AUTO = 20,
+};
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7922(struct mt76_dev *dev)
@@ -335,6 +367,35 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	mutex_unlock(&dev->mutex);
 }
 
+static inline u8 mt76_connac_get_sta_nss(u16 mcs_map)
+{
+	u8 nss;
+
+	for (nss = 8; nss > 0; nss--) {
+		u8 nss_mcs = (mcs_map >> (2 * (nss - 1))) & 3;
+
+		if (nss_mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			break;
+	}
+
+	return nss - 1;
+}
+
+static inline enum mt76_conanc2_mmps_mode
+mt76_connac2_get_mmps_mode(enum ieee80211_smps_mode smps)
+{
+	switch (smps) {
+	case IEEE80211_SMPS_OFF:
+		return MCU_MMPS_DISABLE;
+	case IEEE80211_SMPS_STATIC:
+		return MCU_MMPS_STATIC;
+	case IEEE80211_SMPS_DYNAMIC:
+		return MCU_MMPS_DYNAMIC;
+	default:
+		return MCU_MMPS_DISABLE;
+	}
+}
+
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 			       int ring_base, u32 flags);
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
@@ -366,5 +427,30 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
 				  __le32 *rxv, u8 *mode);
-
+int mt76_connac2_mcu_muar_config(struct mt76_phy *phy,
+				 struct ieee80211_vif *vif,
+				 u8 band, bool bssid, u64 omac_mask,
+				 bool enable);
+void mt76_connac2_mcu_sta_bfer_tlv(struct sk_buff *skb,
+				   struct ieee80211_vif *vif,
+				   struct mt76_phy *phy,
+				   struct mt76_connac2_vif_cap *cap,
+				   struct ieee80211_sta *sta, bool ibf);
+void mt76_connac2_mcu_sta_bfee_tlv(struct sk_buff *skb,
+				   struct ieee80211_vif *vif,
+				   struct mt76_phy *phy,
+				   struct mt76_connac2_vif_cap *cap,
+				   struct ieee80211_sta *sta);
+int mt76_connac2_mcu_add_obss_spr(struct mt76_dev *dev,
+				  struct ieee80211_vif *vif, bool enable);
+void mt76_connac2_mcu_sta_rate_ctrl_tlv(struct mt76_phy *phy,
+					struct sk_buff *skb,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct mt76_connac2_vif_cap *vif_cap,
+					struct cfg80211_bitrate_mask *mask);
+int mt76_connac2_mcu_set_fixed_rate_ctrl(struct mt76_dev *dev,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 void *data, u32 field, int cmd);
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 3c84850ab9fd..539fa33e42f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3111,5 +3111,717 @@ int mt76_connac2_mcu_fill_message(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mcu_fill_message);
 
+int mt76_connac2_mcu_set_mwds(struct mt76_dev *dev, bool enabled)
+{
+	struct {
+		u8 enable;
+		u8 rsv[3];
+	} __packed req = {
+		.enable = enabled
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_WA_EXT_CMD(MWDS_SUPPORT), &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_set_mwds);
+
+int mt76_connac2_mcu_set_muru_ctrl(struct mt76_dev *dev, u32 cmd, u32 val)
+{
+	struct {
+		__le32 cmd;
+		u8 val[4];
+	} __packed req = {
+		.cmd = cpu_to_le32(cmd),
+	};
+
+	put_unaligned_le32(val, req.val);
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(MURU_CTRL), &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_set_muru_ctrl);
+
+int mt76_connac2_mcu_init_rx_airtime(struct mt76_dev *dev)
+{
+#define RX_AIRTIME_FEATURE_CTRL		1
+#define RX_AIRTIME_BITWISE_CTRL		2
+#define RX_AIRTIME_CLEAR_EN	1
+	struct {
+		__le16 field;
+		__le16 sub_field;
+		__le32 set_status;
+		__le32 get_status;
+		u8 rsv[12];
+
+		bool airtime_en;
+		bool mibtime_en;
+		bool earlyend_en;
+		u8 rsv1[9];
+
+		bool airtime_clear;
+		bool mibtime_clear;
+		u8 rsv2[98];
+	} __packed req = {
+		.field = cpu_to_le16(RX_AIRTIME_BITWISE_CTRL),
+		.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN),
+		.airtime_clear = true,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_msg(dev, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
+				sizeof(req), true);
+	if (ret)
+		return ret;
+
+	req.field = cpu_to_le16(RX_AIRTIME_FEATURE_CTRL);
+	req.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN);
+	req.airtime_en = true;
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_init_rx_airtime);
+
+int mt76_connac2_mcu_wa_cmd(struct mt76_dev *dev, int cmd,
+			    u32 a1, u32 a2, u32 a3)
+{
+	struct {
+		__le32 args[3];
+	} req = {
+		.args = {
+			cpu_to_le32(a1),
+			cpu_to_le32(a2),
+			cpu_to_le32(a3),
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, cmd, &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_wa_cmd);
+
+int mt76_connac2_mcu_get_eeprom_free_block(struct mt76_dev *dev, u8 *block_num)
+{
+	struct {
+		u8 rsv;
+		u8 version;
+		u8 die_idx;
+		u8 rsv1;
+	} __packed req = {
+		.version = 1,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(dev, MCU_EXT_QUERY(EFUSE_FREE_BLOCK),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	*block_num = skb->data[0];
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_get_eeprom_free_block);
+
+int mt76_connac2_mcu_get_eeprom(struct mt76_dev *dev, u32 offset,
+				u32 block_size)
+{
+	u32 addr = round_down(offset, block_size);
+	struct mt76_connac2_mcu_eeprom_info *res, req = {
+		.addr = cpu_to_le32(addr),
+	};
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf;
+
+	ret = mt76_mcu_send_and_get_msg(dev, MCU_EXT_QUERY(EFUSE_ACCESS), &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt76_connac2_mcu_eeprom_info *)skb->data;
+	buf = dev->eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, block_size);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_get_eeprom);
+
+#define MT_BF_PROCESSING	4
+int mt76_connac2_mcu_set_txbf(struct mt76_dev *dev, u8 action, bool ibf)
+{
+	struct {
+		u8 action;
+		union {
+			struct {
+				u8 snd_mode;
+				u8 sta_num;
+				u8 rsv;
+				u8 wlan_idx[4];
+				__le32 snd_period;	/* ms */
+			} __packed snd;
+			struct {
+				bool ebf;
+				bool ibf;
+				u8 rsv;
+			} __packed type;
+			struct {
+				u8 bf_num;
+				u8 bf_bitmap;
+				u8 bf_sel[8];
+				u8 rsv[5];
+			} __packed mod;
+		};
+	} __packed req = {
+		.action = action,
+	};
+
+	switch (action) {
+	case MT_BF_SOUNDING_ON:
+		req.snd.snd_mode = MT_BF_PROCESSING;
+		break;
+	case MT_BF_TYPE_UPDATE:
+		req.type.ebf = true;
+		req.type.ibf = ibf;
+		break;
+	case MT_BF_MODULE_UPDATE:
+		req.mod.bf_num = 2;
+		req.mod.bf_bitmap = GENMASK(1, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(TXBF_ACTION), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_set_txbf);
+
+int mt76_connac2_mcu_muar_config(struct mt76_phy *phy,
+				 struct ieee80211_vif *vif,
+				 u8 band, bool bssid, u64 omac_mask,
+				 bool enable)
+{
+	const u8 *addr = bssid ? vif->bss_conf.bssid : vif->addr;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	u32 idx = mvif->omac_idx - REPEATER_BSSID_START;
+	u32 mask = omac_mask >> 32 & ~BIT(idx);
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		u8 mode;
+		u8 force_clear;
+		u8 clear_bitmap[8];
+		u8 entry_count;
+		u8 write;
+		u8 band;
+		u8 index;
+		u8 bssid;
+		u8 addr[ETH_ALEN];
+	} __packed req = {
+		.mode = !!mask || enable,
+		.entry_count = 1,
+		.write = 1,
+		.band = band,
+		.index = idx * 2 + bssid,
+	};
+
+	if (enable)
+		ether_addr_copy(req.addr, addr);
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(MUAR_UPDATE), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_muar_config);
+
+static bool mt76_connac2_is_ebf_supported(struct mt76_phy *phy,
+					  struct ieee80211_vif *vif,
+					  struct mt76_connac2_vif_cap *cap,
+					  struct ieee80211_sta *sta, bool bfee)
+{
+	int tx_ant = hweight8(phy->chainmask) - 1;
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return false;
+
+	if (!bfee && tx_ant < 2)
+		return false;
+
+	if (sta->deflink.he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
+
+		if (bfee)
+			return cap->he_su_ebfee &&
+			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
+		else
+			return cap->he_su_ebfer &&
+			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
+	}
+
+	if (sta->deflink.vht_cap.vht_supported) {
+		u32 sta_cap = sta->deflink.vht_cap.cap;
+
+		if (bfee)
+			return cap->vht_su_ebfee &&
+			       (sta_cap &
+				IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
+		else
+			return cap->vht_su_ebfer &&
+			       (sta_cap &
+				IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+	}
+
+	return false;
+}
+
+static void mt76_connac2_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
+{
+	bf->sounding_phy = MT_PHY_TYPE_OFDM;
+	bf->ndp_rate = 0;					/* mcs0 */
+	bf->ndpa_rate = MT76_CONNAC_CFEND_RATE_DEFAULT;		/* ofdm 24m */
+	bf->rept_poll_rate = MT76_CONNAC_CFEND_RATE_DEFAULT;	/* ofdm 24m */
+}
+
+static void mt76_connac2_mcu_sta_bfer_ht(struct ieee80211_sta *sta,
+					 struct mt76_phy *phy,
+					 struct sta_rec_bf *bf)
+{
+	struct ieee80211_mcs_info *mcs = &sta->deflink.ht_cap.mcs;
+	u8 n = 0;
+
+	bf->tx_mode = MT_PHY_TYPE_HT;
+
+	if ((mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF) &&
+	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
+		n = FIELD_GET(IEEE80211_HT_MCS_TX_MAX_STREAMS_MASK,
+			      mcs->tx_params);
+	else if (mcs->rx_mask[3])
+		n = 3;
+	else if (mcs->rx_mask[2])
+		n = 2;
+	else if (mcs->rx_mask[1])
+		n = 1;
+
+	bf->nrow = hweight8(phy->chainmask) - 1;
+	bf->ncol = min_t(u8, bf->nrow, n);
+	bf->ibf_ncol = n;
+}
+
+static void mt76_connac2_mcu_sta_bfer_vht(struct ieee80211_sta *sta,
+					  struct mt76_phy *phy,
+					  struct sta_rec_bf *bf, bool explicit)
+{
+	struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
+	struct ieee80211_sta_vht_cap *vc = &phy->sband_5g.sband.vht_cap;
+	u16 mcs_map = le16_to_cpu(pc->vht_mcs.rx_mcs_map);
+	u8 nss_mcs = mt76_connac_get_sta_nss(mcs_map);
+	u8 tx_ant = hweight8(phy->chainmask) - 1;
+
+	bf->tx_mode = MT_PHY_TYPE_VHT;
+	if (explicit) {
+		u8 sts, snd_dim;
+
+		mt76_connac2_mcu_sta_sounding_rate(bf);
+		sts = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
+				pc->cap);
+		snd_dim = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+				    vc->cap);
+		bf->nrow = min_t(u8, min_t(u8, snd_dim, sts), tx_ant);
+		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+		bf->ibf_ncol = bf->ncol;
+
+		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+			bf->nrow = 1;
+	} else {
+		bf->nrow = tx_ant;
+		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+		bf->ibf_ncol = nss_mcs;
+
+		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+			bf->ibf_nrow = 1;
+	}
+}
+
+static void mt76_connac2_mcu_sta_bfer_he(struct ieee80211_sta *sta,
+					 struct ieee80211_vif *vif,
+					 struct mt76_phy *phy,
+					 struct sta_rec_bf *bf)
+{
+	struct ieee80211_sta_he_cap *pc = &sta->deflink.he_cap;
+	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
+	const struct ieee80211_sta_he_cap *vc =
+		mt76_connac_get_he_phy_cap(phy, vif);
+	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
+	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
+	u8 nss_mcs = mt76_connac_get_sta_nss(mcs_map);
+	u8 snd_dim, sts;
+
+	bf->tx_mode = MT_PHY_TYPE_HE_SU;
+
+	mt76_connac2_mcu_sta_sounding_rate(bf);
+	bf->trigger_su = HE_PHY(CAP6_TRIG_SU_BEAMFORMING_FB,
+				pe->phy_cap_info[6]);
+	bf->trigger_mu = HE_PHY(CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB,
+				pe->phy_cap_info[6]);
+	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+			 ve->phy_cap_info[5]);
+	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
+		     pe->phy_cap_info[4]);
+	bf->nrow = min_t(u8, snd_dim, sts);
+	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+	bf->ibf_ncol = bf->ncol;
+
+	if (sta->deflink.bandwidth != IEEE80211_STA_RX_BW_160)
+		return;
+
+	/* go over for 160MHz and 80p80 */
+	if (pe->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G) {
+		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_160);
+		nss_mcs = mt76_connac_get_sta_nss(mcs_map);
+		bf->ncol_bw160 = nss_mcs;
+	}
+
+	if (pe->phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
+		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80p80);
+		nss_mcs = mt76_connac_get_sta_nss(mcs_map);
+
+		if (bf->ncol_bw160)
+			bf->ncol_bw160 = min_t(u8, bf->ncol_bw160, nss_mcs);
+		else
+			bf->ncol_bw160 = nss_mcs;
+	}
+
+	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+			 ve->phy_cap_info[5]);
+	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK,
+		     pe->phy_cap_info[4]);
+	bf->nrow_bw160 = min_t(int, snd_dim, sts);
+}
+
+void mt76_connac2_mcu_sta_bfer_tlv(struct sk_buff *skb,
+				   struct ieee80211_vif *vif,
+				   struct mt76_phy *phy,
+				   struct mt76_connac2_vif_cap *cap,
+				   struct ieee80211_sta *sta, bool ibf)
+{
+	int tx_ant = hweight8(phy->chainmask) - 1;
+	const u8 matrix[4][4] = {
+		{ 0, 0, 0, 0 },
+		{ 1, 1, 0, 0 },	/* 2x1, 2x2, 2x3, 2x4 */
+		{ 2, 4, 4, 0 },	/* 3x1, 3x2, 3x3, 3x4 */
+		{ 3, 5, 6, 0 }	/* 4x1, 4x2, 4x3, 4x4 */
+	};
+	struct sta_rec_bf *bf;
+	struct tlv *tlv;
+	bool ebf;
+
+	if (!(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	ebf = mt76_connac2_is_ebf_supported(phy, vif, cap, sta, false);
+	if (!ebf && !ibf)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
+	bf = (struct sta_rec_bf *)tlv;
+
+	/* he: eBF only, in accordance with spec
+	 * vht: support eBF and iBF
+	 * ht: iBF only, since mac80211 lacks of eBF support
+	 */
+	if (sta->deflink.he_cap.has_he && ebf)
+		mt76_connac2_mcu_sta_bfer_he(sta, vif, phy, bf);
+	else if (sta->deflink.vht_cap.vht_supported)
+		mt76_connac2_mcu_sta_bfer_vht(sta, phy, bf, ebf);
+	else if (sta->deflink.ht_cap.ht_supported)
+		mt76_connac2_mcu_sta_bfer_ht(sta, phy, bf);
+	else
+		return;
+
+	bf->bf_cap = ebf ? ebf : ibf << 1;
+	bf->bw = sta->deflink.bandwidth;
+	bf->ibf_dbw = sta->deflink.bandwidth;
+	bf->ibf_nrow = tx_ant;
+
+	if (!ebf && sta->deflink.bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
+		bf->ibf_timeout = 0x48;
+	else
+		bf->ibf_timeout = 0x18;
+
+	if (ebf && bf->nrow != tx_ant)
+		bf->mem_20m = matrix[tx_ant][bf->ncol];
+	else
+		bf->mem_20m = matrix[bf->nrow][bf->ncol];
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+	case IEEE80211_STA_RX_BW_80:
+		bf->mem_total = bf->mem_20m * 2;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		bf->mem_total = bf->mem_20m;
+		break;
+	case IEEE80211_STA_RX_BW_20:
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_sta_bfer_tlv);
+
+void mt76_connac2_mcu_sta_bfee_tlv(struct sk_buff *skb,
+				   struct ieee80211_vif *vif,
+				   struct mt76_phy *phy,
+				   struct mt76_connac2_vif_cap *cap,
+				   struct ieee80211_sta *sta)
+{
+	int tx_ant = hweight8(phy->chainmask) - 1;
+	struct sta_rec_bfee *bfee;
+	struct tlv *tlv;
+	u8 nrow = 0;
+
+	if (!(sta->deflink.vht_cap.vht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	if (!mt76_connac2_is_ebf_supported(phy, vif, cap, sta, true))
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
+	bfee = (struct sta_rec_bfee *)tlv;
+
+	if (sta->deflink.he_cap.has_he) {
+		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
+
+		nrow = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+			      pe->phy_cap_info[5]);
+	} else if (sta->deflink.vht_cap.vht_supported) {
+		struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
+
+		nrow = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+				 pc->cap);
+	}
+	/* reply with identity matrix to avoid 2x2 BF negative gain */
+	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_sta_bfee_tlv);
+
+#define MT_SPR_ENABLE		1
+int mt76_connac2_mcu_add_obss_spr(struct mt76_dev *dev,
+				  struct ieee80211_vif *vif,
+				  bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		u8 action;
+		u8 arg_num;
+		u8 band_idx;
+		u8 status;
+		u8 drop_tx_idx;
+		u8 sta_idx;	/* 256 sta */
+		u8 rsv[2];
+		__le32 val;
+	} __packed req = {
+		.action = MT_SPR_ENABLE,
+		.arg_num = 1,
+		.band_idx = mvif->band_idx,
+		.val = cpu_to_le32(enable),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(SET_SPR), &req, sizeof(req),
+				 true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_add_obss_spr);
+
+static void mt76_connac2_mcu_set_sta_vht_mcs(struct mt76_dev *dev,
+					     struct ieee80211_sta *sta,
+					     __le16 *vht_mcs, const u16 *mask)
+{
+	u16 mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
+	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+	u16 mcs;
+
+	for (nss = 0; nss < max_nss; nss++, mcs_map >>= 2) {
+		switch (mcs_map & 0x3) {
+		case IEEE80211_VHT_MCS_SUPPORT_0_9:
+			mcs = GENMASK(9, 0);
+			break;
+		case IEEE80211_VHT_MCS_SUPPORT_0_8:
+			mcs = GENMASK(8, 0);
+			break;
+		case IEEE80211_VHT_MCS_SUPPORT_0_7:
+			mcs = GENMASK(7, 0);
+			break;
+		default:
+			mcs = 0;
+		}
+
+		vht_mcs[nss] = cpu_to_le16(mcs & mask[nss]);
+
+		/* only support 2ss on 160MHz for mt7915 */
+		if (is_mt7915(dev) && nss > 1 &&
+		    sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+			break;
+	}
+}
+
+static void mt76_connac2_mcu_set_sta_ht_mcs(struct ieee80211_sta *sta,
+					    u8 *ht_mcs, const u8 *mask)
+{
+	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
+
+	for (nss = 0; nss < max_nss; nss++)
+		ht_mcs[nss] = sta->deflink.ht_cap.mcs.rx_mask[nss] & mask[nss];
+}
+
+void mt76_connac2_mcu_sta_rate_ctrl_tlv(struct mt76_phy *phy,
+					struct sk_buff *skb,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct mt76_connac2_vif_cap *vif_cap,
+					struct cfg80211_bitrate_mask *mask)
+{
+	struct cfg80211_chan_def *chandef = &phy->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct sta_rec_ra *ra;
+	u32 supp_rate = sta->deflink.supp_rates[band];
+	u32 cap = sta->wme ? STA_CAP_WMM : 0;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
+	ra = (struct sta_rec_ra *)tlv;
+
+	ra->valid = true;
+	ra->auto_rate = true;
+	ra->phy_mode = mt76_connac_get_phy_mode(phy, vif, band, sta);
+	ra->channel = chandef->chan->hw_value;
+	ra->bw = sta->deflink.bandwidth;
+	ra->phy.bw = sta->deflink.bandwidth;
+	ra->mmps_mode = mt76_connac2_get_mmps_mode(sta->smps_mode);
+
+	if (supp_rate) {
+		supp_rate &= mask->control[band].legacy;
+		ra->rate_len = hweight32(supp_rate);
+
+		if (band == NL80211_BAND_2GHZ) {
+			ra->supp_mode = MODE_CCK;
+			ra->supp_cck_rate = supp_rate & GENMASK(3, 0);
+
+			if (ra->rate_len > 4) {
+				ra->supp_mode |= MODE_OFDM;
+				ra->supp_ofdm_rate = supp_rate >> 4;
+			}
+		} else {
+			ra->supp_mode = MODE_OFDM;
+			ra->supp_ofdm_rate = supp_rate;
+		}
+	}
+
+	if (sta->deflink.ht_cap.ht_supported) {
+		ra->supp_mode |= MODE_HT;
+		ra->af = sta->deflink.ht_cap.ampdu_factor;
+		ra->ht_gf = !!(sta->deflink.ht_cap.cap &
+			       IEEE80211_HT_CAP_GRN_FLD);
+
+		cap |= STA_CAP_HT;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
+			cap |= STA_CAP_SGI_20;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
+			cap |= STA_CAP_SGI_40;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_TX_STBC)
+			cap |= STA_CAP_TX_STBC;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
+			cap |= STA_CAP_RX_STBC;
+		if (vif_cap->ht_ldpc &&
+		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
+			cap |= STA_CAP_LDPC;
+
+		mt76_connac2_mcu_set_sta_ht_mcs(sta, ra->ht_mcs,
+						mask->control[band].ht_mcs);
+		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
+	}
+
+	if (sta->deflink.vht_cap.vht_supported) {
+		u8 af;
+
+		ra->supp_mode |= MODE_VHT;
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->deflink.vht_cap.cap);
+		ra->af = max_t(u8, ra->af, af);
+
+		cap |= STA_CAP_VHT;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
+			cap |= STA_CAP_VHT_SGI_80;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
+			cap |= STA_CAP_VHT_SGI_160;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_TXSTBC)
+			cap |= STA_CAP_VHT_TX_STBC;
+		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
+			cap |= STA_CAP_VHT_RX_STBC;
+		if (vif_cap->vht_ldpc &&
+		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
+			cap |= STA_CAP_VHT_LDPC;
+
+		mt76_connac2_mcu_set_sta_vht_mcs(phy->dev, sta,
+						 ra->supp_vht_mcs,
+						 mask->control[band].vht_mcs);
+	}
+
+	if (sta->deflink.he_cap.has_he) {
+		ra->supp_mode |= MODE_HE;
+		cap |= STA_CAP_HE;
+
+		if (sta->deflink.he_6ghz_capa.capa)
+			ra->af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+	}
+
+	ra->sta_cap = cpu_to_le32(cap);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_sta_rate_ctrl_tlv);
+
+int mt76_connac2_mcu_set_fixed_rate_ctrl(struct mt76_dev *dev,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 void *data, u32 field, int cmd)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct sta_phy *phy = data;
+	struct sta_rec_ra_fixed *ra;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
+	ra = (struct sta_rec_ra_fixed *)tlv;
+
+	switch (field) {
+	case RATE_PARAM_AUTO:
+		break;
+	case RATE_PARAM_FIXED:
+	case RATE_PARAM_FIXED_MCS:
+	case RATE_PARAM_FIXED_GI:
+	case RATE_PARAM_FIXED_HE_LTF:
+		if (phy)
+			ra->phy = *phy;
+		break;
+	case RATE_PARAM_MMPS_UPDATE:
+		ra->mmps_mode = mt76_connac2_get_mmps_mode(sta->smps_mode);
+		break;
+	default:
+		break;
+	}
+	ra->field = cpu_to_le32(field);
+
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_set_fixed_rate_ctrl);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f1d7c05bd794..90ca63e29ffb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -938,6 +938,12 @@ enum {
 	DEV_INFO_MAX_NUM
 };
 
+enum {
+	MT_BF_SOUNDING_ON	= 1,
+	MT_BF_TYPE_UPDATE	= 20,
+	MT_BF_MODULE_UPDATE	= 25
+};
+
 /* event table */
 enum {
 	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
@@ -1253,6 +1259,25 @@ enum {
 	WOW_GPIO = 3,
 };
 
+enum {
+	MCU_WA_PARAM_CMD_QUERY,
+	MCU_WA_PARAM_CMD_SET,
+	MCU_WA_PARAM_CMD_CAPABILITY,
+	MCU_WA_PARAM_CMD_DEBUG,
+};
+
+enum {
+	MCU_WA_PARAM_PDMA_RX =	0x04,
+	MCU_WA_PARAM_CPU_UTIL =	0x0b,
+	MCU_WA_PARAM_RED =	0x0e,
+};
+
+struct mt76_connac2_mcu_eeprom_info {
+	__le32 addr;
+	__le32 valid;
+	u8 data[16];
+} __packed;
+
 struct mt76_connac_bss_basic_tlv {
 	__le16 tag;
 	__le16 len;
@@ -1809,4 +1834,12 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name);
 int mt76_connac2_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 				  int cmd, int *wait_seq);
+int mt76_connac2_mcu_set_mwds(struct mt76_dev *dev, bool enabled);
+int mt76_connac2_mcu_set_muru_ctrl(struct mt76_dev *dev, u32 cmd, u32 val);
+int mt76_connac2_mcu_init_rx_airtime(struct mt76_dev *dev);
+int mt76_connac2_mcu_wa_cmd(struct mt76_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
+int mt76_connac2_mcu_get_eeprom_free_block(struct mt76_dev *dev, u8 *block_num);
+int mt76_connac2_mcu_get_eeprom(struct mt76_dev *dev, u32 offset,
+				u32 block_size);
+int mt76_connac2_mcu_set_txbf(struct mt76_dev *dev, u8 action, bool ibf);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index fd76db8f5269..9b71507173d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -28,7 +28,8 @@ mt7915_implicit_txbf_set(void *data, u64 val)
 
 	dev->ibf = !!val;
 
-	return mt7915_mcu_set_txbf(dev, MT_BF_TYPE_UPDATE);
+	return mt76_connac2_mcu_set_txbf(&dev->mt76, MT_BF_TYPE_UPDATE,
+					 dev->ibf);
 }
 
 static int
@@ -511,8 +512,9 @@ mt7915_fw_debug_wa_set(void *data, u64 val)
 	if (ret)
 		goto out;
 
-	ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
-				MCU_WA_PARAM_PDMA_RX, !!dev->fw.debug_wa, 0);
+	ret = mt76_connac2_mcu_wa_cmd(&dev->mt76, MCU_WA_PARAM_CMD(SET),
+				      MCU_WA_PARAM_PDMA_RX,
+				      !!dev->fw.debug_wa, 0);
 out:
 	if (ret)
 		dev->fw.debug_wa = 0;
@@ -625,9 +627,8 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 	seq_printf(file, "Program counter: 0x%x\n", mt76_rr(dev, MT_WA_MCU_PC));
 
 	if (dev->fw.debug_wa)
-		return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
-					 MCU_WA_PARAM_CPU_UTIL, 0, 0);
-
+		return mt76_connac2_mcu_wa_cmd(&dev->mt76, MCU_WA_PARAM_CMD(QUERY),
+					       MCU_WA_PARAM_CPU_UTIL, 0, 0);
 	return 0;
 }
 
@@ -1152,7 +1153,8 @@ static ssize_t mt7915_sta_fixed_rate_set(struct file *file,
 
 out:
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
-	ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy, field);
+	ret = mt76_connac2_mcu_set_fixed_rate_ctrl(&dev->mt76, vif, sta, &phy, field,
+						   MCU_EXT_CMD(STA_REC_UPDATE));
 	if (ret)
 		return -EFAULT;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 4b1a9811646f..3e6bbd2b2a00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -4,6 +4,7 @@
 #include <linux/firmware.h>
 #include "mt7915.h"
 #include "eeprom.h"
+#include "../mt76_connac_mcu.h"
 
 static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 {
@@ -98,10 +99,11 @@ mt7915_eeprom_load_default(struct mt7915_dev *dev)
 
 static int mt7915_eeprom_load(struct mt7915_dev *dev)
 {
-	int ret;
 	u16 eeprom_size = mt7915_eeprom_size(dev);
+	struct mt76_dev *mdev = &dev->mt76;
+	int ret;
 
-	ret = mt76_eeprom_init(&dev->mt76, eeprom_size);
+	ret = mt76_eeprom_init(mdev, eeprom_size);
 	if (ret < 0)
 		return ret;
 
@@ -111,7 +113,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 		u8 free_block_num;
 		u32 block_num, i;
 
-		mt7915_mcu_get_eeprom_free_block(dev, &free_block_num);
+		mt76_connac2_mcu_get_eeprom_free_block(mdev, &free_block_num);
 		/* efuse info not enough */
 		if (free_block_num >= 29)
 			return -EINVAL;
@@ -119,9 +121,12 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 		/* read eeprom data from efuse */
 		block_num = DIV_ROUND_UP(eeprom_size,
 					 MT7915_EEPROM_BLOCK_SIZE);
-		for (i = 0; i < block_num; i++)
-			mt7915_mcu_get_eeprom(dev,
-					      i * MT7915_EEPROM_BLOCK_SIZE);
+		for (i = 0; i < block_num; i++) {
+			u32 addr = i * MT7915_EEPROM_BLOCK_SIZE;
+
+			mt76_connac2_mcu_get_eeprom(mdev, addr,
+						    MT7915_EEPROM_BLOCK_SIZE);
+		}
 	}
 
 	return mt7915_check_eeprom(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5e6b4da2455c..83157cee4910 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -473,21 +473,23 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 
 static int mt7915_txbf_init(struct mt7915_dev *dev)
 {
+	struct mt76_dev *mdev = &dev->mt76;
 	int ret;
 
 	if (dev->dbdc_support) {
-		ret = mt7915_mcu_set_txbf(dev, MT_BF_MODULE_UPDATE);
+		ret = mt76_connac2_mcu_set_txbf(mdev, MT_BF_MODULE_UPDATE,
+						false);
 		if (ret)
 			return ret;
 	}
 
 	/* trigger sounding packets */
-	ret = mt7915_mcu_set_txbf(dev, MT_BF_SOUNDING_ON);
+	ret = mt76_connac2_mcu_set_txbf(mdev, MT_BF_SOUNDING_ON, false);
 	if (ret)
 		return ret;
 
 	/* enable eBF */
-	return mt7915_mcu_set_txbf(dev, MT_BF_TYPE_UPDATE);
+	return mt76_connac2_mcu_set_txbf(mdev, MT_BF_TYPE_UPDATE, dev->ibf);
 }
 
 static struct mt7915_phy *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 72e31089cf4c..67635905ca43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1174,9 +1174,9 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 		FIELD_PREP(MT_IFS_EIFS_CCK, 314));
 
 	if (phy->slottime < 20 || a_band)
-		val = MT7915_CFEND_RATE_DEFAULT;
+		val = MT76_CONNAC_CFEND_RATE_DEFAULT;
 	else
-		val = MT7915_CFEND_RATE_11B;
+		val = MT76_CONNAC_CFEND_RATE_11B;
 
 	mt76_rmw_field(dev, MT_AGG_ACR0(phy->band_idx), MT_AGG_ACR_CFEND_RATE, val);
 	mt76_clear(dev, MT_ARB_SCR(phy->band_idx),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index dbd5b29309d8..c159aa2062ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -594,7 +594,8 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7915_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
-		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
+		mt76_connac2_mcu_add_obss_spr(&dev->mt76, vif,
+					      info->he_obss_pd.enable);
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
@@ -616,7 +617,8 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		mt7915_mcu_set_tx(dev, vif);
 
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
-		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
+		mt76_connac2_mcu_add_obss_spr(&dev->mt76, vif,
+					      info->he_obss_pd.enable);
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR)
 		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 53da2bc5f8bb..a207e9ccc38e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -32,21 +32,6 @@
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
-static u8
-mt7915_mcu_get_sta_nss(u16 mcs_map)
-{
-	u8 nss;
-
-	for (nss = 8; nss > 0; nss--) {
-		u8 nss_mcs = (mcs_map >> (2 * (nss - 1))) & 3;
-
-		if (nss_mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED)
-			break;
-	}
-
-	return nss - 1;
-}
-
 static void
 mt7915_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
 			  u16 mcs_map)
@@ -102,50 +87,6 @@ mt7915_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
 	*he_mcs = cpu_to_le16(mcs_map);
 }
 
-static void
-mt7915_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta, __le16 *vht_mcs,
-			   const u16 *mask)
-{
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_dev *dev = msta->vif->phy->dev;
-	u16 mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
-	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
-	u16 mcs;
-
-	for (nss = 0; nss < max_nss; nss++, mcs_map >>= 2) {
-		switch (mcs_map & 0x3) {
-		case IEEE80211_VHT_MCS_SUPPORT_0_9:
-			mcs = GENMASK(9, 0);
-			break;
-		case IEEE80211_VHT_MCS_SUPPORT_0_8:
-			mcs = GENMASK(8, 0);
-			break;
-		case IEEE80211_VHT_MCS_SUPPORT_0_7:
-			mcs = GENMASK(7, 0);
-			break;
-		default:
-			mcs = 0;
-		}
-
-		vht_mcs[nss] = cpu_to_le16(mcs & mask[nss]);
-
-		/* only support 2ss on 160MHz for mt7915 */
-		if (is_mt7915(&dev->mt76) && nss > 1 &&
-		    sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
-			break;
-	}
-}
-
-static void
-mt7915_mcu_set_sta_ht_mcs(struct ieee80211_sta *sta, u8 *ht_mcs,
-			  const u8 *mask)
-{
-	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
-
-	for (nss = 0; nss < max_nss; nss++)
-		ht_mcs[nss] = sta->deflink.ht_cap.mcs.rx_mask[nss] & mask[nss];
-}
-
 static int
 mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
@@ -198,21 +139,6 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[qid], skb, 0);
 }
 
-int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
-{
-	struct {
-		__le32 args[3];
-	} req = {
-		.args = {
-			cpu_to_le32(a1),
-			cpu_to_le32(a2),
-			cpu_to_le32(a3),
-		},
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), false);
-}
-
 static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -571,44 +497,6 @@ mt7915_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt7915_phy *phy)
 	}
 }
 
-static int
-mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
-		       bool bssid, bool enable)
-{
-	struct mt7915_dev *dev = phy->dev;
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	u32 idx = mvif->mt76.omac_idx - REPEATER_BSSID_START;
-	u32 mask = phy->omac_mask >> 32 & ~BIT(idx);
-	const u8 *addr = vif->addr;
-	struct {
-		u8 mode;
-		u8 force_clear;
-		u8 clear_bitmap[8];
-		u8 entry_count;
-		u8 write;
-		u8 band;
-
-		u8 index;
-		u8 bssid;
-		u8 addr[ETH_ALEN];
-	} __packed req = {
-		.mode = !!mask || enable,
-		.entry_count = 1,
-		.write = 1,
-		.band = phy != &dev->phy,
-		.index = idx * 2 + bssid,
-	};
-
-	if (bssid)
-		addr = vif->bss_conf.bssid;
-
-	if (enable)
-		ether_addr_copy(req.addr, addr);
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MUAR_UPDATE), &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable)
 {
@@ -617,8 +505,12 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 	struct sk_buff *skb;
 
 	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START) {
-		mt7915_mcu_muar_config(phy, vif, false, enable);
-		mt7915_mcu_muar_config(phy, vif, true, enable);
+		u8 band = phy != &dev->phy;
+
+		mt76_connac2_mcu_muar_config(phy->mt76, vif, band, false,
+					     phy->omac_mask, enable);
+		mt76_connac2_mcu_muar_config(phy->mt76, vif, band, true,
+					     phy->omac_mask, enable);
 	}
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, NULL,
@@ -983,338 +875,6 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static inline bool
-mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta, bool bfee)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
-
-	if (vif->type != NL80211_IFTYPE_STATION &&
-	    vif->type != NL80211_IFTYPE_AP)
-		return false;
-
-	if (!bfee && tx_ant < 2)
-		return false;
-
-	if (sta->deflink.he_cap.has_he) {
-		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
-
-		if (bfee)
-			return mvif->cap.he_su_ebfee &&
-			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
-		else
-			return mvif->cap.he_su_ebfer &&
-			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
-	}
-
-	if (sta->deflink.vht_cap.vht_supported) {
-		u32 cap = sta->deflink.vht_cap.cap;
-
-		if (bfee)
-			return mvif->cap.vht_su_ebfee &&
-			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
-		else
-			return mvif->cap.vht_su_ebfer &&
-			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
-	}
-
-	return false;
-}
-
-static void
-mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
-{
-	bf->sounding_phy = MT_PHY_TYPE_OFDM;
-	bf->ndp_rate = 0;				/* mcs0 */
-	bf->ndpa_rate = MT7915_CFEND_RATE_DEFAULT;	/* ofdm 24m */
-	bf->rept_poll_rate = MT7915_CFEND_RATE_DEFAULT;	/* ofdm 24m */
-}
-
-static void
-mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
-		       struct sta_rec_bf *bf)
-{
-	struct ieee80211_mcs_info *mcs = &sta->deflink.ht_cap.mcs;
-	u8 n = 0;
-
-	bf->tx_mode = MT_PHY_TYPE_HT;
-
-	if ((mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF) &&
-	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
-		n = FIELD_GET(IEEE80211_HT_MCS_TX_MAX_STREAMS_MASK,
-			      mcs->tx_params);
-	else if (mcs->rx_mask[3])
-		n = 3;
-	else if (mcs->rx_mask[2])
-		n = 2;
-	else if (mcs->rx_mask[1])
-		n = 1;
-
-	bf->nrow = hweight8(phy->mt76->chainmask) - 1;
-	bf->ncol = min_t(u8, bf->nrow, n);
-	bf->ibf_ncol = n;
-}
-
-static void
-mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
-			struct sta_rec_bf *bf, bool explicit)
-{
-	struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
-	struct ieee80211_sta_vht_cap *vc = &phy->mt76->sband_5g.sband.vht_cap;
-	u16 mcs_map = le16_to_cpu(pc->vht_mcs.rx_mcs_map);
-	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
-	u8 tx_ant = hweight8(phy->mt76->chainmask) - 1;
-
-	bf->tx_mode = MT_PHY_TYPE_VHT;
-
-	if (explicit) {
-		u8 sts, snd_dim;
-
-		mt7915_mcu_sta_sounding_rate(bf);
-
-		sts = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
-				pc->cap);
-		snd_dim = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
-				    vc->cap);
-		bf->nrow = min_t(u8, min_t(u8, snd_dim, sts), tx_ant);
-		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-		bf->ibf_ncol = bf->ncol;
-
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
-			bf->nrow = 1;
-	} else {
-		bf->nrow = tx_ant;
-		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-		bf->ibf_ncol = nss_mcs;
-
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
-			bf->ibf_nrow = 1;
-	}
-}
-
-static void
-mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
-		       struct mt7915_phy *phy, struct sta_rec_bf *bf)
-{
-	struct ieee80211_sta_he_cap *pc = &sta->deflink.he_cap;
-	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
-	const struct ieee80211_sta_he_cap *vc =
-		mt76_connac_get_he_phy_cap(phy->mt76, vif);
-	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
-	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
-	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
-	u8 snd_dim, sts;
-
-	bf->tx_mode = MT_PHY_TYPE_HE_SU;
-
-	mt7915_mcu_sta_sounding_rate(bf);
-
-	bf->trigger_su = HE_PHY(CAP6_TRIG_SU_BEAMFORMING_FB,
-				pe->phy_cap_info[6]);
-	bf->trigger_mu = HE_PHY(CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB,
-				pe->phy_cap_info[6]);
-	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
-			 ve->phy_cap_info[5]);
-	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
-		     pe->phy_cap_info[4]);
-	bf->nrow = min_t(u8, snd_dim, sts);
-	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-	bf->ibf_ncol = bf->ncol;
-
-	if (sta->deflink.bandwidth != IEEE80211_STA_RX_BW_160)
-		return;
-
-	/* go over for 160MHz and 80p80 */
-	if (pe->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G) {
-		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_160);
-		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
-
-		bf->ncol_bw160 = nss_mcs;
-	}
-
-	if (pe->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
-		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80p80);
-		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
-
-		if (bf->ncol_bw160)
-			bf->ncol_bw160 = min_t(u8, bf->ncol_bw160, nss_mcs);
-		else
-			bf->ncol_bw160 = nss_mcs;
-	}
-
-	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
-			 ve->phy_cap_info[5]);
-	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK,
-		     pe->phy_cap_info[4]);
-
-	bf->nrow_bw160 = min_t(int, snd_dim, sts);
-}
-
-static void
-mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
-			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_phy *phy = mvif->phy;
-	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
-	struct sta_rec_bf *bf;
-	struct tlv *tlv;
-	const u8 matrix[4][4] = {
-		{0, 0, 0, 0},
-		{1, 1, 0, 0},	/* 2x1, 2x2, 2x3, 2x4 */
-		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
-		{3, 5, 6, 0}	/* 4x1, 4x2, 4x3, 4x4 */
-	};
-	bool ebf;
-
-	if (!(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
-		return;
-
-	ebf = mt7915_is_ebf_supported(phy, vif, sta, false);
-	if (!ebf && !dev->ibf)
-		return;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
-	bf = (struct sta_rec_bf *)tlv;
-
-	/* he: eBF only, in accordance with spec
-	 * vht: support eBF and iBF
-	 * ht: iBF only, since mac80211 lacks of eBF support
-	 */
-	if (sta->deflink.he_cap.has_he && ebf)
-		mt7915_mcu_sta_bfer_he(sta, vif, phy, bf);
-	else if (sta->deflink.vht_cap.vht_supported)
-		mt7915_mcu_sta_bfer_vht(sta, phy, bf, ebf);
-	else if (sta->deflink.ht_cap.ht_supported)
-		mt7915_mcu_sta_bfer_ht(sta, phy, bf);
-	else
-		return;
-
-	bf->bf_cap = ebf ? ebf : dev->ibf << 1;
-	bf->bw = sta->deflink.bandwidth;
-	bf->ibf_dbw = sta->deflink.bandwidth;
-	bf->ibf_nrow = tx_ant;
-
-	if (!ebf && sta->deflink.bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
-		bf->ibf_timeout = 0x48;
-	else
-		bf->ibf_timeout = 0x18;
-
-	if (ebf && bf->nrow != tx_ant)
-		bf->mem_20m = matrix[tx_ant][bf->ncol];
-	else
-		bf->mem_20m = matrix[bf->nrow][bf->ncol];
-
-	switch (sta->deflink.bandwidth) {
-	case IEEE80211_STA_RX_BW_160:
-	case IEEE80211_STA_RX_BW_80:
-		bf->mem_total = bf->mem_20m * 2;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		bf->mem_total = bf->mem_20m;
-		break;
-	case IEEE80211_STA_RX_BW_20:
-	default:
-		break;
-	}
-}
-
-static void
-mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
-			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_phy *phy = mvif->phy;
-	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
-	struct sta_rec_bfee *bfee;
-	struct tlv *tlv;
-	u8 nrow = 0;
-
-	if (!(sta->deflink.vht_cap.vht_supported || sta->deflink.he_cap.has_he))
-		return;
-
-	if (!mt7915_is_ebf_supported(phy, vif, sta, true))
-		return;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BFEE, sizeof(*bfee));
-	bfee = (struct sta_rec_bfee *)tlv;
-
-	if (sta->deflink.he_cap.has_he) {
-		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
-
-		nrow = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
-			      pe->phy_cap_info[5]);
-	} else if (sta->deflink.vht_cap.vht_supported) {
-		struct ieee80211_sta_vht_cap *pc = &sta->deflink.vht_cap;
-
-		nrow = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
-				 pc->cap);
-	}
-
-	/* reply with identity matrix to avoid 2x2 BF negative gain */
-	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
-}
-
-static enum mcu_mmps_mode
-mt7915_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
-{
-	switch (smps) {
-	case IEEE80211_SMPS_OFF:
-		return MCU_MMPS_DISABLE;
-	case IEEE80211_SMPS_STATIC:
-		return MCU_MMPS_STATIC;
-	case IEEE80211_SMPS_DYNAMIC:
-		return MCU_MMPS_DYNAMIC;
-	default:
-		return MCU_MMPS_DISABLE;
-	}
-}
-
-int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta,
-				   void *data, u32 field)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct sta_phy *phy = data;
-	struct sta_rec_ra_fixed *ra;
-	struct sk_buff *skb;
-	struct tlv *tlv;
-
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
-	ra = (struct sta_rec_ra_fixed *)tlv;
-
-	switch (field) {
-	case RATE_PARAM_AUTO:
-		break;
-	case RATE_PARAM_FIXED:
-	case RATE_PARAM_FIXED_MCS:
-	case RATE_PARAM_FIXED_GI:
-	case RATE_PARAM_FIXED_HE_LTF:
-		if (phy)
-			ra->phy = *phy;
-		break;
-	case RATE_PARAM_MMPS_UPDATE:
-		ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->smps_mode);
-		break;
-	default:
-		break;
-	}
-	ra->field = cpu_to_le32(field);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta)
 {
@@ -1344,8 +904,9 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, NULL,
-					      RATE_PARAM_MMPS_UPDATE);
+	return mt76_connac2_mcu_set_fixed_rate_ctrl(&dev->mt76, vif, sta, NULL,
+						    RATE_PARAM_MMPS_UPDATE,
+						    MCU_EXT_CMD(STA_REC_UPDATE));
 }
 
 static int
@@ -1397,8 +958,9 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 
 	/* fixed single rate */
 	if (nrates == 1) {
-		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
-						     RATE_PARAM_FIXED_MCS);
+		ret = mt76_connac2_mcu_set_fixed_rate_ctrl(&dev->mt76, vif, sta, &phy,
+							   RATE_PARAM_FIXED_MCS,
+							   MCU_EXT_CMD(STA_REC_UPDATE));
 		if (ret)
 			return ret;
 	}
@@ -1419,16 +981,18 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 		else
 			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
 
-		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
-						     RATE_PARAM_FIXED_GI);
+		ret = mt76_connac2_mcu_set_fixed_rate_ctrl(&dev->mt76, vif, sta, &phy,
+							   RATE_PARAM_FIXED_GI,
+							   MCU_EXT_CMD(STA_REC_UPDATE));
 		if (ret)
 			return ret;
 	}
 
 	/* fixed HE_LTF */
 	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
-		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
-						     RATE_PARAM_FIXED_HE_LTF);
+		ret = mt76_connac2_mcu_set_fixed_rate_ctrl(&dev->mt76, vif, sta, &phy,
+							   RATE_PARAM_FIXED_HE_LTF,
+							   MCU_EXT_CMD(STA_REC_UPDATE));
 		if (ret)
 			return ret;
 	}
@@ -1436,109 +1000,6 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 	return 0;
 }
 
-static void
-mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
-			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt76_phy *mphy = mvif->phy->mt76;
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
-	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
-	enum nl80211_band band = chandef->chan->band;
-	struct sta_rec_ra *ra;
-	struct tlv *tlv;
-	u32 supp_rate = sta->deflink.supp_rates[band];
-	u32 cap = sta->wme ? STA_CAP_WMM : 0;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
-	ra = (struct sta_rec_ra *)tlv;
-
-	ra->valid = true;
-	ra->auto_rate = true;
-	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, sta);
-	ra->channel = chandef->chan->hw_value;
-	ra->bw = sta->deflink.bandwidth;
-	ra->phy.bw = sta->deflink.bandwidth;
-	ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->smps_mode);
-
-	if (supp_rate) {
-		supp_rate &= mask->control[band].legacy;
-		ra->rate_len = hweight32(supp_rate);
-
-		if (band == NL80211_BAND_2GHZ) {
-			ra->supp_mode = MODE_CCK;
-			ra->supp_cck_rate = supp_rate & GENMASK(3, 0);
-
-			if (ra->rate_len > 4) {
-				ra->supp_mode |= MODE_OFDM;
-				ra->supp_ofdm_rate = supp_rate >> 4;
-			}
-		} else {
-			ra->supp_mode = MODE_OFDM;
-			ra->supp_ofdm_rate = supp_rate;
-		}
-	}
-
-	if (sta->deflink.ht_cap.ht_supported) {
-		ra->supp_mode |= MODE_HT;
-		ra->af = sta->deflink.ht_cap.ampdu_factor;
-		ra->ht_gf = !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
-
-		cap |= STA_CAP_HT;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
-			cap |= STA_CAP_SGI_20;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
-			cap |= STA_CAP_SGI_40;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_TX_STBC)
-			cap |= STA_CAP_TX_STBC;
-		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
-			cap |= STA_CAP_RX_STBC;
-		if (mvif->cap.ht_ldpc &&
-		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
-			cap |= STA_CAP_LDPC;
-
-		mt7915_mcu_set_sta_ht_mcs(sta, ra->ht_mcs,
-					  mask->control[band].ht_mcs);
-		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
-	}
-
-	if (sta->deflink.vht_cap.vht_supported) {
-		u8 af;
-
-		ra->supp_mode |= MODE_VHT;
-		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
-			       sta->deflink.vht_cap.cap);
-		ra->af = max_t(u8, ra->af, af);
-
-		cap |= STA_CAP_VHT;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
-			cap |= STA_CAP_VHT_SGI_80;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
-			cap |= STA_CAP_VHT_SGI_160;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_TXSTBC)
-			cap |= STA_CAP_VHT_TX_STBC;
-		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
-			cap |= STA_CAP_VHT_RX_STBC;
-		if (mvif->cap.vht_ldpc &&
-		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
-			cap |= STA_CAP_VHT_LDPC;
-
-		mt7915_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs,
-					   mask->control[band].vht_mcs);
-	}
-
-	if (sta->deflink.he_cap.has_he) {
-		ra->supp_mode |= MODE_HE;
-		cap |= STA_CAP_HE;
-
-		if (sta->deflink.he_6ghz_capa.capa)
-			ra->af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
-					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
-	}
-
-	ra->sta_cap = cpu_to_le32(cap);
-}
-
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed)
 {
@@ -1562,7 +1023,8 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	/* sta_rec_ra accommodates BW, NSS and only MCS range format
 	 * i.e 0-{7,8,9} for VHT.
 	 */
-	mt7915_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
+	mt76_connac2_mcu_sta_rate_ctrl_tlv(mvif->phy->mt76, skb, vif, sta,
+					   &mvif->cap, &mvif->bitrate_mask);
 
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_EXT_CMD(STA_REC_UPDATE), true);
@@ -1628,7 +1090,8 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	/* tag order is in accordance with firmware dependency. */
 	if (sta) {
 		/* starec bfer */
-		mt7915_mcu_sta_bfer_tlv(dev, skb, vif, sta);
+		mt76_connac2_mcu_sta_bfer_tlv(skb, vif, mvif->phy->mt76,
+					      &mvif->cap, sta, dev->ibf);
 		/* starec ht */
 		mt7915_mcu_sta_ht_tlv(skb, sta);
 		/* starec vht */
@@ -1651,7 +1114,8 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		/* starec muru */
 		mt7915_mcu_sta_muru_tlv(dev, skb, sta, vif);
 		/* starec bfee */
-		mt7915_mcu_sta_bfee_tlv(dev, skb, vif, sta);
+		mt76_connac2_mcu_sta_bfee_tlv(skb, vif, mvif->phy->mt76,
+					      &mvif->cap, sta);
 	}
 
 	ret = mt7915_mcu_add_group(dev, vif, sta);
@@ -1700,7 +1164,9 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 	};
 
 	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
-		return mt7915_mcu_muar_config(phy, vif, false, enable);
+		return mt76_connac2_mcu_muar_config(phy->mt76, vif,
+						    phy != &dev->phy, false,
+						    phy->omac_mask, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(DEV_INFO_UPDATE),
@@ -1821,7 +1287,7 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			     struct sk_buff *skb)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_vif_cap *vc = &mvif->cap;
+	struct mt76_connac2_vif_cap *vc = &mvif->cap;
 	const struct ieee80211_he_cap_elem *he;
 	const struct ieee80211_vht_cap *vht;
 	const struct ieee80211_ht_cap *ht;
@@ -2163,75 +1629,6 @@ int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
 	return 0;
 }
 
-static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
-{
-	struct {
-		u8 enable;
-		u8 _rsv[3];
-	} __packed req = {
-		.enable = enabled
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_EXT_CMD(MWDS_SUPPORT), &req,
-				 sizeof(req), false);
-}
-
-int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u32 val)
-{
-	struct {
-		__le32 cmd;
-		u8 val[4];
-	} __packed req = {
-		.cmd = cpu_to_le32(cmd),
-	};
-
-	put_unaligned_le32(val, req.val);
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &req,
-				 sizeof(req), false);
-}
-
-static int
-mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
-{
-#define RX_AIRTIME_FEATURE_CTRL		1
-#define RX_AIRTIME_BITWISE_CTRL		2
-#define RX_AIRTIME_CLEAR_EN	1
-	struct {
-		__le16 field;
-		__le16 sub_field;
-		__le32 set_status;
-		__le32 get_status;
-		u8 _rsv[12];
-
-		bool airtime_en;
-		bool mibtime_en;
-		bool earlyend_en;
-		u8 _rsv1[9];
-
-		bool airtime_clear;
-		bool mibtime_clear;
-		u8 _rsv2[98];
-	} __packed req = {
-		.field = cpu_to_le16(RX_AIRTIME_BITWISE_CTRL),
-		.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN),
-		.airtime_clear = true,
-	};
-	int ret;
-
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
-				sizeof(req), true);
-	if (ret)
-		return ret;
-
-	req.field = cpu_to_le16(RX_AIRTIME_FEATURE_CTRL);
-	req.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN);
-	req.airtime_en = true;
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
@@ -2273,23 +1670,25 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		return ret;
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+		mt76_connac2_mcu_wa_cmd(&dev->mt76,
+					MCU_WA_PARAM_CMD(CAPABILITY),
+					0, 0, 0);
 
-	ret = mt7915_mcu_set_mwds(dev, 1);
+	ret = mt76_connac2_mcu_set_mwds(&dev->mt76, 1);
 	if (ret)
 		return ret;
 
-	ret = mt7915_mcu_set_muru_ctrl(dev, MURU_SET_PLATFORM_TYPE,
-				       MURU_PLATFORM_TYPE_PERF_LEVEL_2);
+	ret = mt76_connac2_mcu_set_muru_ctrl(&dev->mt76, MURU_SET_PLATFORM_TYPE,
+					     MURU_PLATFORM_TYPE_PERF_LEVEL_2);
 	if (ret)
 		return ret;
 
-	ret = mt7915_mcu_init_rx_airtime(dev);
+	ret = mt76_connac2_mcu_init_rx_airtime(&dev->mt76);
 	if (ret)
 		return ret;
 
-	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
-				 MCU_WA_PARAM_RED, 0, 0);
+	return mt76_connac2_mcu_wa_cmd(&dev->mt76, MCU_WA_PARAM_CMD(SET),
+				       MCU_WA_PARAM_RED, 0, 0);
 }
 
 void mt7915_mcu_exit(struct mt7915_dev *dev)
@@ -2730,54 +2129,6 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 				 &req, sizeof(req), true);
 }
 
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
-{
-	struct mt7915_mcu_eeprom_info req = {
-		.addr = cpu_to_le32(round_down(offset,
-				    MT7915_EEPROM_BLOCK_SIZE)),
-	};
-	struct mt7915_mcu_eeprom_info *res;
-	struct sk_buff *skb;
-	int ret;
-	u8 *buf;
-
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_ACCESS), &req,
-				sizeof(req), true, &skb);
-	if (ret)
-		return ret;
-
-	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, MT7915_EEPROM_BLOCK_SIZE);
-	dev_kfree_skb(skb);
-
-	return 0;
-}
-
-int mt7915_mcu_get_eeprom_free_block(struct mt7915_dev *dev, u8 *block_num)
-{
-	struct {
-		u8 _rsv;
-		u8 version;
-		u8 die_idx;
-		u8 _rsv2;
-	} __packed req = {
-		.version = 1,
-	};
-	struct sk_buff *skb;
-	int ret;
-
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_FREE_BLOCK), &req,
-					sizeof(req), true, &skb);
-	if (ret)
-		return ret;
-
-	*block_num = *(u8 *)skb->data;
-	dev_kfree_skb(skb);
-
-	return 0;
-}
-
 static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
 				  u8 *data, u32 len, int cmd)
 {
@@ -3185,80 +2536,6 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band)
 				 &req, sizeof(req), false);
 }
 
-int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action)
-{
-	struct {
-		u8 action;
-		union {
-			struct {
-				u8 snd_mode;
-				u8 sta_num;
-				u8 rsv;
-				u8 wlan_idx[4];
-				__le32 snd_period;	/* ms */
-			} __packed snd;
-			struct {
-				bool ebf;
-				bool ibf;
-				u8 rsv;
-			} __packed type;
-			struct {
-				u8 bf_num;
-				u8 bf_bitmap;
-				u8 bf_sel[8];
-				u8 rsv[5];
-			} __packed mod;
-		};
-	} __packed req = {
-		.action = action,
-	};
-
-#define MT_BF_PROCESSING	4
-	switch (action) {
-	case MT_BF_SOUNDING_ON:
-		req.snd.snd_mode = MT_BF_PROCESSING;
-		break;
-	case MT_BF_TYPE_UPDATE:
-		req.type.ebf = true;
-		req.type.ibf = dev->ibf;
-		break;
-	case MT_BF_MODULE_UPDATE:
-		req.mod.bf_num = 2;
-		req.mod.bf_bitmap = GENMASK(1, 0);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXBF_ACTION), &req,
-				 sizeof(req), true);
-}
-
-int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			    bool enable)
-{
-#define MT_SPR_ENABLE		1
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct {
-		u8 action;
-		u8 arg_num;
-		u8 band_idx;
-		u8 status;
-		u8 drop_tx_idx;
-		u8 sta_idx;	/* 256 sta */
-		u8 rsv[2];
-		__le32 val;
-	} __packed req = {
-		.action = MT_SPR_ENABLE,
-		.arg_num = 1,
-		.band_idx = mvif->mt76.band_idx,
-		.val = cpu_to_le32(enable),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SPR), &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index cd1edf553fc1..8fe9ffd4e1c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -135,12 +135,6 @@ struct mt7915_mcu_eeprom {
 	__le16 len;
 } __packed;
 
-struct mt7915_mcu_eeprom_info {
-	__le32 addr;
-	__le32 valid;
-	u8 data[16];
-} __packed;
-
 struct mt7915_mcu_phy_rx_info {
 	u8 category;
 	u8 rate;
@@ -247,26 +241,6 @@ enum {
 	MCU_TWT_AGRT_GET_TSF,
 };
 
-enum {
-	MCU_WA_PARAM_CMD_QUERY,
-	MCU_WA_PARAM_CMD_SET,
-	MCU_WA_PARAM_CMD_CAPABILITY,
-	MCU_WA_PARAM_CMD_DEBUG,
-};
-
-enum {
-	MCU_WA_PARAM_PDMA_RX = 0x04,
-	MCU_WA_PARAM_CPU_UTIL = 0x0b,
-	MCU_WA_PARAM_RED = 0x0e,
-};
-
-enum mcu_mmps_mode {
-	MCU_MMPS_STATIC,
-	MCU_MMPS_DYNAMIC,
-	MCU_MMPS_RSV,
-	MCU_MMPS_DISABLE,
-};
-
 struct bss_info_bmc_rate {
 	__le16 tag;
 	__le16 len;
@@ -387,15 +361,6 @@ enum {
 	BSS_INFO_BCN_MAX
 };
 
-enum {
-	RATE_PARAM_FIXED = 3,
-	RATE_PARAM_MMPS_UPDATE = 5,
-	RATE_PARAM_FIXED_HE_LTF = 7,
-	RATE_PARAM_FIXED_MCS,
-	RATE_PARAM_FIXED_GI = 11,
-	RATE_PARAM_AUTO = 20,
-};
-
 #define RATE_CFG_MCS			GENMASK(3, 0)
 #define RATE_CFG_NSS			GENMASK(7, 4)
 #define RATE_CFG_GI			GENMASK(11, 8)
@@ -416,12 +381,6 @@ enum {
 	THERMAL_PROTECT_STATE_ACT,
 };
 
-enum {
-	MT_BF_SOUNDING_ON = 1,
-	MT_BF_TYPE_UPDATE = 20,
-	MT_BF_MODULE_UPDATE = 25
-};
-
 enum {
 	MURU_SET_ARB_OP_MODE = 14,
 	MURU_SET_PLATFORM_TYPE = 25,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 620d89283545..685bcc979f5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -55,9 +55,6 @@
 #define MT7915_EEPROM_BLOCK_SIZE	16
 #define MT7915_TOKEN_SIZE		8192
 
-#define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
-#define MT7915_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
-
 #define MT7915_THERMAL_THROTTLE_MAX	100
 #define MT7915_CDEV_THROTTLE_MAX	99
 
@@ -137,23 +134,10 @@ struct mt7915_sta {
 	} twt;
 };
 
-struct mt7915_vif_cap {
-	bool ht_ldpc:1;
-	bool vht_ldpc:1;
-	bool he_ldpc:1;
-	bool vht_su_ebfer:1;
-	bool vht_su_ebfee:1;
-	bool vht_mu_ebfer:1;
-	bool vht_mu_ebfee:1;
-	bool he_su_ebfer:1;
-	bool he_su_ebfee:1;
-	bool he_mu_ebfer:1;
-};
-
 struct mt7915_vif {
 	struct mt76_vif mt76; /* must be first */
 
-	struct mt7915_vif_cap cap;
+	struct mt76_connac2_vif_cap cap;
 	struct mt7915_sta sta;
 	struct mt7915_phy *phy;
 
@@ -465,8 +449,6 @@ int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vi
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable, u32 changed);
-int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-                            bool enable);
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed);
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -480,8 +462,6 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 				   struct ieee80211_sta *sta,
 				   void *data, u32 field);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
-int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset);
-int mt7915_mcu_get_eeprom_free_block(struct mt7915_dev *dev, u8 *block_num);
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 		       bool hdr_trans);
 int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
@@ -490,13 +470,11 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
 int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
-int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action);
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val);
 int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 			    const struct mt7915_dfs_pulse *pulse);
 int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern);
-int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u32 val);
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
 int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch);
@@ -507,7 +485,6 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
 				     struct cfg80211_chan_def *chandef);
 int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u32 regidx, u32 *val, bool set);
-int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index efb9bb8231e2..7fdbb475c51c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -164,7 +164,8 @@ mt7915_tm_set_tam_arb(struct mt7915_phy *phy, bool enable, bool mu)
 	else
 		op_mode = TAM_ARB_OP_MODE_FORCE_SU;
 
-	return mt7915_mcu_set_muru_ctrl(dev, MURU_SET_ARB_OP_MODE, op_mode);
+	return mt76_connac2_mcu_set_muru_ctrl(&dev->mt76, MURU_SET_ARB_OP_MODE,
+					      op_mode);
 }
 
 static int
-- 
2.36.1

