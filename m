Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349082E9C85
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 19:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbhADSCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 13:02:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727634AbhADSCR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 13:02:17 -0500
X-UUID: ff29ebb090f843ab8e0add7e14c390bb-20210105
X-UUID: ff29ebb090f843ab8e0add7e14c390bb-20210105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 85980531; Tue, 05 Jan 2021 02:00:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 02:00:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 02:00:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v5 04/15] mt76: mt7921: add MCU support
Date:   Tue, 5 Jan 2021 02:00:08 +0800
Message-ID: <54fc526ca124f2585b3e9b67955ddef7218f9158.1609781247.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609781247.git.objelf@gmail.com>
References: <cover.1609781247.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 088740370D511BC6B98ED00AAFA2DA9A136DF9E9887B1519CBC71519A08004712000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7921 contains a microprocessor with which the host can use command/event
to communicate to implement offload features such as establish connection,
hardware scan and so on. The host has to download the ROM patch, RAM
firmware and finally activate the MCU to complete the MT7921
initialization.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   28 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2446 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 1050 +++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |    2 +
 4 files changed, 3526 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 2a77fe6abc7d..853432d749ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1338,6 +1338,30 @@ mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	}
 }
 
+static void
+mt7921_mac_sta_stats_work(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_sta *msta;
+	LIST_HEAD(list);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&phy->stats_list, &list);
+
+	while (!list_empty(&list)) {
+		msta = list_first_entry(&list, struct mt7921_sta, stats_list);
+		list_del_init(&msta->stats_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		/* query wtbl info to report tx rate for further devices */
+		mt7921_get_wtbl_info(dev, msta->wcid.idx);
+
+		spin_lock_bh(&dev->sta_poll_lock);
+	}
+
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
 void mt7921_mac_work(struct work_struct *work)
 {
 	struct mt7921_phy *phy;
@@ -1355,6 +1379,10 @@ void mt7921_mac_work(struct work_struct *work)
 
 		mt7921_mac_update_mib_stats(phy);
 	}
+	if (++phy->sta_work_count == 10) {
+		phy->sta_work_count = 0;
+		mt7921_mac_sta_stats_work(phy);
+	};
 
 	mutex_unlock(&mphy->dev->mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
new file mode 100644
index 000000000000..797460d710ef
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -0,0 +1,2446 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include "mt7921.h"
+#include "mcu.h"
+#include "mac.h"
+
+struct mt7921_patch_hdr {
+	char build_date[16];
+	char platform[4];
+	__be32 hw_sw_ver;
+	__be32 patch_ver;
+	__be16 checksum;
+	u16 reserved;
+	struct {
+		__be32 patch_ver;
+		__be32 subsys;
+		__be32 feature;
+		__be32 n_region;
+		__be32 crc;
+		u32 reserved[11];
+	} desc;
+} __packed;
+
+struct mt7921_patch_sec {
+	__be32 type;
+	__be32 offs;
+	__be32 size;
+	union {
+		__be32 spec[13];
+		struct {
+			__be32 addr;
+			__be32 len;
+			__be32 sec_key_idx;
+			__be32 align_len;
+			u32 reserved[9];
+		} info;
+	};
+} __packed;
+
+struct mt7921_fw_trailer {
+	u8 chip_id;
+	u8 eco_code;
+	u8 n_region;
+	u8 format_ver;
+	u8 format_flag;
+	u8 reserved[2];
+	char fw_ver[10];
+	char build_date[15];
+	u32 crc;
+} __packed;
+
+struct mt7921_fw_region {
+	__le32 decomp_crc;
+	__le32 decomp_len;
+	__le32 decomp_blk_sz;
+	u8 reserved[4];
+	__le32 addr;
+	__le32 len;
+	u8 feature_set;
+	u8 reserved1[15];
+} __packed;
+
+#define MCU_PATCH_ADDRESS		0x200000
+
+#define MT_STA_BFER			BIT(0)
+#define MT_STA_BFEE			BIT(1)
+
+#define FW_FEATURE_SET_ENCRYPT		BIT(0)
+#define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
+#define FW_FEATURE_ENCRY_MODE		BIT(4)
+#define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
+
+#define DL_MODE_ENCRYPT			BIT(0)
+#define DL_MODE_KEY_IDX			GENMASK(2, 1)
+#define DL_MODE_RESET_SEC_IV		BIT(3)
+#define DL_MODE_WORKING_PDA_CR4		BIT(4)
+#define DL_CONFIG_ENCRY_MODE_SEL	BIT(6)
+#define DL_MODE_NEED_RSP		BIT(31)
+
+#define FW_START_OVERRIDE		BIT(0)
+#define FW_START_WORKING_PDA_CR4	BIT(2)
+
+#define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
+#define PATCH_SEC_TYPE_INFO		0x2
+
+#define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
+#define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
+
+#define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
+#define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
+
+static enum mt7921_cipher_type
+mt7921_mcu_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return MT_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return MT_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return MT_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MT_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return MT_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return MT_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return MT_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return MT_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return MT_CIPHER_WAPI;
+	default:
+		return MT_CIPHER_NONE;
+	}
+}
+
+static u8 mt7921_mcu_chan_bw(struct cfg80211_chan_def *chandef)
+{
+	static const u8 width_to_bw[] = {
+		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
+		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
+		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
+		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
+		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
+		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
+		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
+		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
+	};
+
+	if (chandef->width >= ARRAY_SIZE(width_to_bw))
+		return 0;
+
+	return width_to_bw[chandef->width];
+}
+
+static const struct ieee80211_sta_he_cap *
+mt7921_get_he_phy_cap(struct mt7921_phy *phy, struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband;
+	enum nl80211_band band;
+
+	band = phy->mt76->chandef.chan->band;
+	sband = phy->mt76->hw->wiphy->bands[band];
+
+	return ieee80211_get_he_iftype_cap(sband, vif->type);
+}
+
+static u8
+mt7921_get_phy_mode(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		    enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+		struct mt7921_phy *phy = &dev->phy;
+
+		sband = phy->mt76->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_MODE_B | PHY_MODE_G;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_GN;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_24G;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_MODE_A;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_AN;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_MODE_AC;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_5G;
+	}
+
+	return mode;
+}
+
+static u8
+mt7921_get_phy_mode_v2(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+		struct mt7921_phy *phy = &dev->phy;
+
+		sband = phy->mt76->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_TYPE_BIT_HR_DSSS | PHY_TYPE_BIT_ERP;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_TYPE_BIT_OFDM;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_TYPE_BIT_VHT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	}
+
+	return mode;
+}
+
+static int
+mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_eeprom_info *res;
+	u8 *buf;
+
+	if (!skb)
+		return -EINVAL;
+
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+
+	return 0;
+}
+
+static int
+mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			  struct sk_buff *skb, int seq)
+{
+	struct mt7921_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+			cmd, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7921_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	switch (cmd) {
+	case MCU_CMD_PATCH_SEM_CONTROL:
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+		break;
+	case MCU_EXT_CMD_THERMAL_CTRL:
+		skb_pull(skb, sizeof(*rxd) + 4);
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+		break;
+	case MCU_EXT_CMD_EFUSE_ACCESS:
+		ret = mt7921_mcu_parse_eeprom(mdev, skb);
+		break;
+	case MCU_UNI_CMD_DEV_INFO_UPDATE:
+	case MCU_UNI_CMD_BSS_INFO_UPDATE:
+	case MCU_UNI_CMD_STA_REC_UPDATE:
+	case MCU_UNI_CMD_HIF_CTRL:
+	case MCU_UNI_CMD_OFFLOAD:
+	case MCU_UNI_CMD_SUSPEND: {
+		struct mt7921_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		break;
+	}
+	case MCU_CMD_REG_READ: {
+		struct mt7921_mcu_reg_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_reg_event *)skb->data;
+		ret = (int)le32_to_cpu(event->val);
+		break;
+	}
+	default:
+		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *wait_seq)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
+	enum mt76_mcuq_id txq = MT_MCUQ_WM;
+	struct mt7921_uni_txd *uni_txd;
+	struct mt7921_mcu_txd *mcu_txd;
+	__le32 *txd;
+	u32 val;
+	u8 seq;
+
+	/* TODO: make dynamic based on msg type */
+	mdev->mcu.timeout = 20 * HZ;
+
+	seq = ++dev->mt76.mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++dev->mt76.mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD_FW_SCATTER) {
+		txq = MT_MCUQ_FWDL;
+		goto exit;
+	}
+
+	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
+	txd[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & MCU_UNI_PREFIX) {
+		uni_txd = (struct mt7921_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2N;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt7921_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
+					       MT_TX_MCU_PORT_RX_Q0));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+
+	switch (cmd & ~MCU_CMD_MASK) {
+	case MCU_FW_PREFIX:
+		mcu_txd->set_query = MCU_Q_NA;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	case MCU_CE_PREFIX:
+		if (cmd & MCU_QUERY_MASK)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	default:
+		mcu_txd->cid = MCU_CMD_EXT_CID;
+		if (cmd & MCU_QUERY_PREFIX || cmd == MCU_EXT_CMD_EFUSE_ACCESS)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid = mcu_cmd;
+		mcu_txd->ext_cid_ack = 1;
+		break;
+	}
+
+	mcu_txd->s2d_index = MCU_S2D_H2N;
+	WARN_ON(cmd == MCU_EXT_CMD_EFUSE_ACCESS &&
+		mcu_txd->set_query != MCU_Q_QUERY);
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
+}
+
+static void
+mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy,
+			 struct mt7921_mcu_peer_cap *peer,
+			 struct rate_info *rate, u16 r)
+{
+	struct ieee80211_supported_band *sband;
+	u16 flags = 0;
+	u8 txmode = FIELD_GET(MT_WTBL_RATE_TX_MODE, r);
+	u8 gi = 0;
+	u8 bw = 0;
+
+	rate->mcs = FIELD_GET(MT_WTBL_RATE_MCS, r);
+	rate->nss = FIELD_GET(MT_WTBL_RATE_NSS, r) + 1;
+
+	switch (peer->bw) {
+	case IEEE80211_STA_RX_BW_160:
+		gi = peer->g16;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		gi = peer->g8;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		gi = peer->g4;
+		break;
+	default:
+		gi = peer->g2;
+		break;
+	}
+
+	gi = txmode >= MT_PHY_TYPE_HE_SU ?
+		FIELD_GET(MT_WTBL_RATE_HE_GI, gi) :
+		FIELD_GET(MT_WTBL_RATE_GI, gi);
+
+	switch (txmode) {
+	case MT_PHY_TYPE_CCK:
+	case MT_PHY_TYPE_OFDM:
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate->legacy = sband->bitrates[rate->mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		flags |= RATE_INFO_FLAGS_MCS;
+
+		if (gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+		if (gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		rate->he_gi = gi;
+		rate->he_dcm = FIELD_GET(MT_RA_RATE_DCM_EN, r);
+
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		break;
+	}
+	rate->flags = flags;
+
+	bw = mt7921_mcu_chan_bw(&mphy->chandef) - FIELD_GET(MT_RA_RATE_BW, r);
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_160:
+		rate->bw = RATE_INFO_BW_160;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate->bw = RATE_INFO_BW_40;
+		break;
+	default:
+		rate->bw = RATE_INFO_BW_20;
+		break;
+	}
+}
+
+static void
+mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
+			  u16 wlan_idx)
+{
+	struct mt7921_mcu_wlan_info_event *wtbl_info =
+		(struct mt7921_mcu_wlan_info_event *)(skb->data);
+	struct rate_info rate = {};
+	u8 curr_idx = wtbl_info->rate_info.rate_idx;
+	u16 curr = le16_to_cpu(wtbl_info->rate_info.rate[curr_idx]);
+	struct mt7921_mcu_peer_cap peer = wtbl_info->peer_cap;
+	struct mt76_phy *mphy = &dev->mphy;
+	struct mt7921_sta_stats *stats;
+	struct mt7921_sta *msta;
+	struct mt76_wcid *wcid;
+
+	if (wlan_idx >= MT76_N_WCIDS)
+		return;
+	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+	if (!wcid) {
+		stats->tx_rate = rate;
+		return;
+	}
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+	stats = &msta->stats;
+
+	/* current rate */
+	mt7921_mcu_tx_rate_parse(mphy, &peer, &rate, curr);
+	stats->tx_rate = rate;
+}
+
+static void
+mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT7921_HW_SCAN_TIMEOUT);
+}
+
+static void
+mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_mcu_bss_event *event;
+
+	event = (struct mt7921_mcu_bss_event *)(skb->data +
+						sizeof(struct mt7921_mcu_rxd));
+	if (event->is_absent)
+		ieee80211_stop_queues(mphy->hw);
+	else
+		ieee80211_wake_queues(mphy->hw);
+}
+
+static void
+mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+	struct debug_msg {
+		__le16 id;
+		u8 type;
+		u8 flag;
+		__le32 value;
+		__le16 len;
+		u8 content[512];
+	} __packed * debug_msg;
+	u16 cur_len;
+	int i;
+
+	skb_pull(skb, sizeof(*rxd));
+	debug_msg = (struct debug_msg *)skb->data;
+
+	cur_len = min_t(u16, le16_to_cpu(debug_msg->len), 512);
+
+	if (debug_msg->type == 0x3) {
+		for (i = 0 ; i < cur_len; i++)
+			if (!debug_msg->content[i])
+				debug_msg->content[i] = ' ';
+
+		dev_dbg(dev->mt76.dev, "%s", debug_msg->content);
+	}
+}
+
+static void
+mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_EVENT_BSS_BEACON_LOSS:
+		break;
+	case MCU_EVENT_SCHED_SCAN_DONE:
+	case MCU_EVENT_SCAN_DONE:
+		mt7921_mcu_scan_event(dev, skb);
+		return;
+	case MCU_EVENT_BSS_ABSENCE:
+		mt7921_mcu_bss_event(dev, skb);
+		break;
+	case MCU_EVENT_DBG_MSG:
+		mt7921_mcu_debug_msg_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
+
+	if (rxd->eid == 0x6) {
+		mt76_mcu_rx_event(&dev->mt76, skb);
+		return;
+	}
+
+	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
+	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
+	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
+	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_DBG_MSG ||
+	    !rxd->seq)
+		mt7921_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+static struct sk_buff *
+mt7921_mcu_alloc_sta_req(struct mt7921_dev *dev, struct mt7921_vif *mvif,
+			 struct mt7921_sta *msta, int len)
+{
+	struct sta_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
+		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
+		.muar_idx = msta ? mvif->omac_idx : 0,
+		.is_tlv_append = 1,
+	};
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+
+static struct wtbl_req_hdr *
+mt7921_mcu_alloc_wtbl_req(struct mt7921_dev *dev, struct mt7921_sta *msta,
+			  int cmd, void *sta_wtbl, struct sk_buff **skb)
+{
+	struct tlv *sta_hdr = sta_wtbl;
+	struct wtbl_req_hdr hdr = {
+		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
+		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
+		.operation = cmd,
+	};
+	struct sk_buff *nskb = *skb;
+
+	if (!nskb) {
+		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+					  MT7921_WTBL_UPDATE_BA_SIZE);
+		if (!nskb)
+			return ERR_PTR(-ENOMEM);
+
+		*skb = nskb;
+	}
+
+	if (sta_hdr)
+		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+
+	return skb_put_data(nskb, &hdr, sizeof(hdr));
+}
+
+static struct tlv *
+mt7921_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
+			  void *sta_ntlv, void *sta_wtbl)
+{
+	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
+	struct tlv *sta_hdr = sta_wtbl;
+	struct tlv *ptlv, tlv = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(len),
+	};
+	u16 ntlv;
+
+	ptlv = skb_put(skb, len);
+	memcpy(ptlv, &tlv, sizeof(tlv));
+
+	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
+	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
+
+	if (sta_hdr) {
+		u16 size = le16_to_cpu(sta_hdr->len);
+
+		sta_hdr->len = cpu_to_le16(size + len);
+	}
+
+	return ptlv;
+}
+
+static struct tlv *
+mt7921_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
+{
+	return mt7921_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
+}
+
+static void
+mt7921_mcu_uni_bss_he_tlv(struct tlv *tlv, struct ieee80211_vif *vif,
+			  struct mt7921_phy *phy)
+{
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+
+	cap = mt7921_get_he_phy_cap(phy, vif);
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+/** starec & wtbl **/
+static int
+mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
+		       struct ieee80211_key_conf *key, enum set_key_cmd cmd)
+{
+	struct mt7921_sta_key_conf *bip = &msta->bip;
+	struct sta_rec_sec *sec;
+	struct tlv *tlv;
+	u32 len = sizeof(*sec);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+
+	sec = (struct sta_rec_sec *)tlv;
+	sec->add = cmd;
+
+	if (cmd == SET_KEY) {
+		struct sec_key *sec_key;
+		u8 cipher;
+
+		cipher = mt7921_mcu_get_cipher(key->cipher);
+		if (cipher == MT_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		sec_key = &sec->key[0];
+		sec_key->cipher_len = sizeof(*sec_key);
+
+		if (cipher == MT_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MT_CIPHER_AES_CCMP;
+			sec_key->key_id = bip->keyidx;
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, bip->key, 16);
+
+			sec_key = &sec->key[1];
+			sec_key->cipher_id = MT_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_len = sizeof(*sec_key);
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key, 16);
+
+			sec->n_cipher = 2;
+		} else {
+			sec_key->cipher_id = cipher;
+			sec_key->key_id = key->keyidx;
+			sec_key->key_len = key->keylen;
+			memcpy(sec_key->key, key->key, key->keylen);
+
+			if (cipher == MT_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec_key->key + 16, key->key + 24, 8);
+				memcpy(sec_key->key + 24, key->key + 16, 8);
+			}
+
+			/* store key_conf for BIP batch update */
+			if (cipher == MT_CIPHER_AES_CCMP) {
+				memcpy(bip->key, key->key, key->keylen);
+				bip->keyidx = key->keyidx;
+			}
+
+			len -= sizeof(*sec_key);
+			sec->n_cipher = 1;
+		}
+	} else {
+		len -= sizeof(sec->key);
+		sec->n_cipher = 0;
+	}
+	sec->len = cpu_to_le16(len);
+
+	return 0;
+}
+
+int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_sec);
+	int ret;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt7921_mcu_sta_key_tlv(msta, skb, key, cmd);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD_STA_REC_UPDATE, true);
+}
+
+static void
+mt7921_mcu_sta_ba_tlv(struct sk_buff *skb,
+		      struct ieee80211_ampdu_params *params,
+		      bool enable, bool tx)
+{
+	struct sta_rec_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT,
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+}
+
+static void
+mt7921_mcu_wtbl_ba_tlv(struct sk_buff *skb,
+		       struct ieee80211_ampdu_params *params,
+		       bool enable, bool tx, void *sta_wtbl,
+		       void *wtbl_tlv)
+{
+	struct wtbl_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
+					wtbl_tlv, sta_wtbl);
+
+	ba = (struct wtbl_ba *)tlv;
+	ba->tid = params->tid;
+
+	if (tx) {
+		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
+		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
+		ba->ba_en = enable;
+	} else {
+		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
+		ba->ba_type = MT_BA_TYPE_RECIPIENT;
+		ba->rst_ba_tid = params->tid;
+		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
+		ba->rst_ba_sb = 1;
+	}
+
+	if (enable && tx)
+		ba->ba_winsize = cpu_to_le16(params->buf_size);
+}
+
+static int
+mt7921_mcu_sta_ba(struct mt7921_dev *dev,
+		  struct ieee80211_ampdu_params *params,
+		  bool enable, bool tx, int cmd)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+	struct mt7921_vif *mvif = msta->vif;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int ret;
+
+	if (enable && tx && !params->amsdu)
+		msta->wcid.amsdu = false;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
+	mt7921_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
+
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	if (ret)
+		return ret;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7921_mcu_sta_ba_tlv(skb, params, enable, tx);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	return mt7921_mcu_sta_ba(dev, params, enable, true, MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	return mt7921_mcu_sta_ba(dev, params, enable, false, MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+static void
+mt7921_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, void *sta_wtbl,
+			    void *wtbl_tlv)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct wtbl_generic *generic;
+	struct wtbl_rx *rx;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
+					wtbl_tlv, sta_wtbl);
+
+	generic = (struct wtbl_generic *)tlv;
+
+	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
+		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
+		generic->muar_idx = mvif->omac_idx;
+		generic->qos = sta->wme;
+	} else {
+		/* use BSSID in station mode */
+		if (vif->type == NL80211_IFTYPE_STATION)
+			memcpy(generic->peer_addr, vif->bss_conf.bssid,
+			       ETH_ALEN);
+		else
+			eth_broadcast_addr(generic->peer_addr);
+
+		generic->muar_idx = 0xe;
+	}
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
+					wtbl_tlv, sta_wtbl);
+
+	rx = (struct wtbl_rx *)tlv;
+	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
+	rx->rca2 = 1;
+	rx->rv = 1;
+}
+
+static void
+mt7921_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, bool enable)
+{
+#define EXTRA_INFO_VER          BIT(0)
+#define EXTRA_INFO_NEW          BIT(1)
+	struct sta_rec_basic *basic;
+	struct tlv *tlv;
+	int conn_type;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
+
+	basic = (struct sta_rec_basic *)tlv;
+	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
+
+	if (enable) {
+		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+		basic->conn_state = CONN_STATE_PORT_SECURE;
+	} else {
+		basic->conn_state = CONN_STATE_DISCONNECT;
+	}
+
+	if (!sta) {
+		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
+		eth_broadcast_addr(basic->peer_addr);
+		return;
+	}
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(vif->bss_conf.aid);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic->aid = cpu_to_le16(sta->aid);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
+	basic->qos = sta->wme;
+}
+
+static void
+mt7921_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he *he;
+	struct tlv *tlv;
+	u32 cap = 0;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
+
+	he = (struct sta_rec_he *)tlv;
+
+	if (elem->mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		cap |= STA_REC_HE_CAP_HTC;
+
+	if (elem->mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		cap |= STA_REC_HE_CAP_BSR;
+
+	if (elem->mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		cap |= STA_REC_HE_CAP_OM;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU)
+		cap |= STA_REC_HE_CAP_AMSDU_IN_AMPDU;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		cap |= STA_REC_HE_CAP_BQR;
+
+	if (elem->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
+		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
+		cap |= STA_REC_HE_CAP_LDPC;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US)
+		cap |= STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US)
+		cap |= STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_TX_STBC;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
+
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
+		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_TX_STBC;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_RX_STBC;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242;
+
+	he->he_cap = cpu_to_le32(cap);
+
+	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->t_frame_dur =
+		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
+	he->max_ampdu_exp =
+		HE_MAC(CAP3_MAX_AMPDU_LEN_EXP_MASK, elem->mac_cap_info[3]);
+
+	he->bw_set =
+		HE_PHY(CAP0_CHANNEL_WIDTH_SET_MASK, elem->phy_cap_info[0]);
+	he->device_class =
+		HE_PHY(CAP1_DEVICE_CLASS_A, elem->phy_cap_info[1]);
+	he->punc_pream_rx =
+		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
+
+	he->dcm_tx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_TX_MASK, elem->phy_cap_info[3]);
+	he->dcm_tx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_TX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_RX_MASK, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_RX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP8_DCM_MAX_RU_MASK, elem->phy_cap_info[8]);
+
+	he->pkt_ext = 2;
+}
+
+static void
+mt7921_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			 struct ieee80211_vif *vif)
+{
+	struct sta_rec_uapsd *uapsd;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
+		return;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	uapsd = (struct sta_rec_uapsd *)tlv;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
+		uapsd->dac_map |= BIT(3);
+		uapsd->tac_map |= BIT(3);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
+		uapsd->dac_map |= BIT(2);
+		uapsd->tac_map |= BIT(2);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
+		uapsd->dac_map |= BIT(1);
+		uapsd->tac_map |= BIT(1);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
+		uapsd->dac_map |= BIT(0);
+		uapsd->tac_map |= BIT(0);
+	}
+	uapsd->max_sp = sta->max_sp;
+}
+
+static void
+mt7921_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (!sta->max_amsdu_len)
+		return;
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	amsdu->max_mpdu_size = sta->max_amsdu_len >=
+			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
+	msta->wcid.amsdu = true;
+}
+
+static bool
+mt7921_hw_amsdu_supported(struct ieee80211_vif *vif)
+{
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_STATION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void
+mt7921_mcu_sta_tlv(struct mt7921_dev *dev, struct sk_buff *skb,
+		   struct ieee80211_sta *sta, struct ieee80211_vif *vif)
+{
+	struct tlv *tlv;
+	struct sta_rec_state *state;
+	struct sta_rec_phy *phy;
+	struct sta_rec_ra_info *ra_info;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	enum nl80211_band band = chandef->chan->band;
+
+	/* starec ht */
+	if (sta->ht_cap.ht_supported) {
+		struct sta_rec_ht *ht;
+
+		tlv = mt7921_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+		ht = (struct sta_rec_ht *)tlv;
+		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+
+		if (mt7921_hw_amsdu_supported(vif))
+			mt7921_mcu_sta_amsdu_tlv(skb, sta);
+	}
+
+	/* starec vht */
+	if (sta->vht_cap.vht_supported) {
+		struct sta_rec_vht *vht;
+
+		tlv = mt7921_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
+		vht = (struct sta_rec_vht *)tlv;
+		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
+		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
+		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
+	}
+
+	/* starec he */
+	if (sta->he_cap.has_he)
+		mt7921_mcu_sta_he_tlv(skb, sta);
+
+	/* starec uapsd */
+	mt7921_mcu_sta_uapsd_tlv(skb, sta, vif);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+	phy = (struct sta_rec_phy *)tlv;
+	phy->phy_type = mt7921_get_phy_mode_v2(dev, vif, band, sta);
+	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
+	ra_info = (struct sta_rec_ra_info *)tlv;
+	ra_info->legacy = cpu_to_le16((u16)sta->supp_rates[band]);
+
+	if (sta->ht_cap.ht_supported) {
+		memcpy(ra_info->rx_mcs_bitmask, sta->ht_cap.mcs.rx_mask,
+		       HT_MCS_MASK_NUM);
+	}
+
+	tlv = mt7921_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
+	state = (struct sta_rec_state *)tlv;
+	state->state = 2;
+
+	if (sta->vht_cap.vht_supported) {
+		state->vht_opmode = sta->bandwidth;
+		state->vht_opmode |= (sta->rx_nss - 1) <<
+			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+	}
+}
+
+static void
+mt7921_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			 void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_smps *smps;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
+					wtbl_tlv, sta_wtbl);
+	smps = (struct wtbl_smps *)tlv;
+
+	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
+		smps->smps = true;
+}
+
+static void
+mt7921_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+		       void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_ht *ht = NULL;
+	struct tlv *tlv;
+
+	/* wtbl ht */
+	if (sta->ht_cap.ht_supported) {
+		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
+						wtbl_tlv, sta_wtbl);
+		ht = (struct wtbl_ht *)tlv;
+		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->af = sta->ht_cap.ampdu_factor;
+		ht->mm = sta->ht_cap.ampdu_density;
+		ht->ht = true;
+	}
+
+	/* wtbl vht */
+	if (sta->vht_cap.vht_supported) {
+		struct wtbl_vht *vht;
+		u8 af;
+
+		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
+						wtbl_tlv, sta_wtbl);
+		vht = (struct wtbl_vht *)tlv;
+		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->vht = true;
+
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->vht_cap.cap);
+		if (ht)
+			ht->af = max_t(u8, ht->af, af);
+	}
+
+	mt7921_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
+}
+
+static void
+mt7921_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct mt7921_sta *msta;
+	struct wtbl_hdr_trans *htr = NULL;
+	struct tlv *tlv;
+
+	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
+					wtbl_tlv, sta_wtbl);
+	htr = (struct wtbl_hdr_trans *)tlv;
+	htr->no_rx_trans = true;
+	if (vif->type == NL80211_IFTYPE_STATION)
+		htr->to_ds = true;
+	else
+		htr->from_ds = true;
+
+	if (!sta)
+		return;
+
+	msta = (struct mt7921_sta *)sta->drv_priv;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)) {
+		htr->to_ds = true;
+		htr->from_ds = true;
+	}
+}
+
+int mt7921_mcu_sta_update_hdr_trans(struct mt7921_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7921_WTBL_UPDATE_MAX_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	mt7921_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
+}
+
+static int mt7921_mcu_start_firmware(struct mt7921_dev *dev, u32 addr,
+				     u32 option)
+{
+	struct {
+		__le32 option;
+		__le32 addr;
+	} req = {
+		.option = cpu_to_le32(option),
+		.addr = cpu_to_le32(addr),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 power_mode;
+		u8 rsv[3];
+	} req = {
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_NIC_POWER_CTRL, &req,
+				 sizeof(req), false);
+}
+
+static int mt7921_mcu_patch_sem_ctrl(struct mt7921_dev *dev, bool get)
+{
+	struct {
+		__le32 op;
+	} req = {
+		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_mcu_start_patch(struct mt7921_dev *dev)
+{
+	struct {
+		u8 check_crc;
+		u8 reserved[3];
+	} req = {
+		.check_crc = 0,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ, &req,
+				 sizeof(req), true);
+}
+
+static int mt7921_driver_own(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
+			    0, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for driver own\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mt7921_mcu_init_download(struct mt7921_dev *dev, u32 addr,
+				    u32 len, u32 mode)
+{
+	struct {
+		__le32 addr;
+		__le32 len;
+		__le32 mode;
+	} req = {
+		.addr = cpu_to_le32(addr),
+		.len = cpu_to_le32(len),
+		.mode = cpu_to_le32(mode),
+	};
+	int attr;
+
+	if (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000)
+		attr = MCU_CMD_PATCH_START_REQ;
+	else
+		attr = MCU_CMD_TARGET_ADDRESS_LEN_REQ;
+
+	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
+}
+
+static int mt7921_load_patch(struct mt7921_dev *dev)
+{
+	const struct mt7921_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
+	int i, ret, sem;
+
+	sem = mt7921_mcu_patch_sem_ctrl(dev, 1);
+	switch (sem) {
+	case PATCH_IS_DL:
+		return 0;
+	case PATCH_NOT_DL_SEM_SUCCESS:
+		break;
+	default:
+		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, MT7921_ROM_PATCH, dev->mt76.dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7921_patch_hdr *)(fw->data);
+
+	dev_info(dev->mt76.dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+
+	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
+		struct mt7921_patch_sec *sec;
+		const u8 *dl;
+		u32 len, addr;
+
+		sec = (struct mt7921_patch_sec *)(fw->data + sizeof(*hdr) +
+						  i * sizeof(*sec));
+		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
+		    PATCH_SEC_TYPE_INFO) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = be32_to_cpu(sec->info.addr);
+		len = be32_to_cpu(sec->info.len);
+		dl = fw->data + be32_to_cpu(sec->offs);
+
+		ret = mt7921_mcu_init_download(dev, addr, len,
+					       DL_MODE_NEED_RSP);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     dl, len);
+		if (ret) {
+			dev_err(dev->mt76.dev, "Failed to send patch\n");
+			goto out;
+		}
+	}
+
+	ret = mt7921_mcu_start_patch(dev);
+	if (ret)
+		dev_err(dev->mt76.dev, "Failed to start patch\n");
+
+out:
+	sem = mt7921_mcu_patch_sem_ctrl(dev, 0);
+	switch (sem) {
+	case PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->mt76.dev, "Failed to release patch semaphore\n");
+		goto out;
+	}
+	release_firmware(fw);
+
+	return ret;
+}
+
+static u32 mt7921_mcu_gen_dl_mode(u8 feature_set, bool is_wa)
+{
+	u32 ret = 0;
+
+	ret |= (feature_set & FW_FEATURE_SET_ENCRYPT) ?
+	       (DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV) : 0;
+	ret |= (feature_set & FW_FEATURE_ENCRY_MODE) ?
+	       DL_CONFIG_ENCRY_MODE_SEL : 0;
+	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
+			  FIELD_GET(FW_FEATURE_SET_KEY_IDX, feature_set));
+	ret |= DL_MODE_NEED_RSP;
+	ret |= is_wa ? DL_MODE_WORKING_PDA_CR4 : 0;
+
+	return ret;
+}
+
+static int
+mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
+			     const struct mt7921_fw_trailer *hdr,
+			     const u8 *data, bool is_wa)
+{
+	int i, offset = 0;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt7921_fw_region *region;
+		int err;
+		u32 len, addr, mode;
+
+		region = (const struct mt7921_fw_region *)((const u8 *)hdr -
+			 (hdr->n_region - i) * sizeof(*region));
+		mode = mt7921_mcu_gen_dl_mode(region->feature_set, is_wa);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt7921_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->mt76.dev, "Download request failed\n");
+			return err;
+		}
+
+		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD_FW_SCATTER,
+					     data + offset, len);
+		if (err) {
+			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
+			return err;
+		}
+
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+
+	if (is_wa)
+		option |= FW_START_WORKING_PDA_CR4;
+
+	return mt7921_mcu_start_firmware(dev, override, option);
+}
+
+static int mt7921_load_ram(struct mt7921_dev *dev)
+{
+	const struct mt7921_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, MT7921_FIRMWARE_WM, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const struct mt7921_fw_trailer *)(fw->data + fw->size -
+					sizeof(*hdr));
+
+	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt7921_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret) {
+		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->mt76.hw->wiphy->fw_version,
+		 sizeof(dev->mt76.hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7921_load_firmware(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
+	if (ret) {
+		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
+		return -EIO;
+	}
+
+	ret = mt7921_load_patch(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_load_ram(dev);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+
+		return -EIO;
+	}
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
+
+	dev_err(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 ctrl_val;
+		u8 pad[3];
+	} data = {
+		.ctrl_val = ctrl
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FWLOG_2_HOST, &data,
+				 sizeof(data), false);
+}
+
+int mt7921_mcu_init(struct mt7921_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7921_mcu_ops = {
+		.headroom = sizeof(struct mt7921_mcu_txd),
+		.mcu_skb_send_msg = mt7921_mcu_send_message,
+		.mcu_parse_response = mt7921_mcu_parse_response,
+		.mcu_restart = mt7921_mcu_restart,
+	};
+	int ret;
+
+	dev->mt76.mcu_ops = &mt7921_mcu_ops;
+
+	ret = mt7921_driver_own(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	mt7921_mcu_fw_log_2_host(dev, 1);
+
+	return 0;
+}
+
+void mt7921_mcu_exit(struct mt7921_dev *dev)
+{
+	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_MISC);
+
+	__mt76_mcu_restart(&dev->mt76);
+	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
+			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
+				       FW_STATE_FW_DOWNLOAD), 1000)) {
+		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
+		return;
+	}
+
+	reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
+	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_FW_OWN);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+}
+
+int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band,
+		       bool enable, bool hdr_trans)
+{
+	struct {
+		u8 operation;
+		u8 enable;
+		u8 check_bssid;
+		u8 insert_vlan;
+		u8 remove_vlan;
+		u8 tid;
+		u8 mode;
+		u8 rsv;
+	} __packed req_trans = {
+		.enable = hdr_trans,
+	};
+	struct {
+		u8 enable;
+		u8 band;
+		u8 rsv[2];
+	} __packed req_mac = {
+		.enable = enable,
+		.band = band,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+				&req_trans, sizeof(req_trans), false);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
+				 &req_mac, sizeof(req_mac), true);
+}
+
+int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 prot_idx;
+		u8 band;
+		u8 rsv[2];
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.prot_idx = 1,
+		.band = phy != &dev->phy,
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+#define WMM_AIFS_SET		BIT(0)
+#define WMM_CW_MIN_SET		BIT(1)
+#define WMM_CW_MAX_SET		BIT(2)
+#define WMM_TXOP_SET		BIT(3)
+#define WMM_PARAM_SET		GENMASK(3, 0)
+#define TX_CMD_MODE		1
+	struct edca {
+		u8 queue;
+		u8 set;
+		u8 aifs;
+		u8 cw_min;
+		__le16 cw_max;
+		__le16 txop;
+	};
+	struct mt7921_mcu_tx {
+		u8 total;
+		u8 action;
+		u8 valid;
+		u8 mode;
+
+		struct edca edca[IEEE80211_NUM_ACS];
+	} __packed req = {
+		.valid = true,
+		.mode = TX_CMD_MODE,
+		.total = IEEE80211_NUM_ACS,
+	};
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct edca *e = &req.edca[ac];
+
+		e->set = WMM_PARAM_SET;
+		e->queue = ac + mvif->wmm_idx * MT7921_MAX_WMM_SETS;
+		e->aifs = q->aifs;
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = fls(q->cw_min);
+		else
+			e->cw_min = 5;
+
+		if (q->cw_max)
+			e->cw_max = cpu_to_le16(fls(q->cw_max));
+		else
+			e->cw_max = cpu_to_le16(10);
+	}
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
+				 sizeof(req), true);
+}
+
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1;
+	struct {
+		u8 control_ch;
+		u8 center_ch;
+		u8 bw;
+		u8 tx_streams_num;
+		u8 rx_streams;	/* mask or num */
+		u8 switch_reason;
+		u8 band_idx;
+		u8 center_ch2;	/* for 80+80 only */
+		__le16 cac_case;
+		u8 channel_band;
+		u8 rsv0;
+		__le32 outband_freq;
+		u8 txpower_drop;
+		u8 ap_bw;
+		u8 ap_center_ch;
+		u8 rsv1[57];
+	} __packed req = {
+		.control_ch = chandef->chan->hw_value,
+		.center_ch = ieee80211_frequency_to_channel(freq1),
+		.bw = mt7921_mcu_chan_bw(chandef),
+		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
+		.rx_streams = phy->mt76->antenna_mask,
+		.band_idx = phy != &dev->phy,
+		.channel_band = chandef->chan->band,
+	};
+
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
+	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
+
+	if (cmd == MCU_EXT_CMD_CHANNEL_SWITCH)
+		req.rx_streams = hweight8(req.rx_streams);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+}
+
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
+{
+	struct req_hdr {
+		u8 buffer_mode;
+		u8 format;
+		__le16 len;
+	} __packed req = {
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				 &req, sizeof(req), true);
+}
+
+int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
+{
+	struct mt7921_mcu_eeprom_info req = {
+		.addr = cpu_to_le32(round_down(offset, 16)),
+	};
+	struct mt7921_mcu_eeprom_info *res;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int
+mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
+		       struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 pad;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_bss_basic_tlv basic;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.conn_state = 1,
+		},
+	};
+	int err, idx, cmd, len;
+	void *data;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	case NL80211_IFTYPE_STATION:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+
+	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
+	data = enable ? (void *)&dev_req : (void *)&basic_req;
+	len = enable ? sizeof(dev_req) : sizeof(basic_req);
+
+	err = mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+	if (err < 0)
+		return err;
+
+	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
+	data = enable ? (void *)&basic_req : (void *)&dev_req;
+	len = enable ? sizeof(basic_req) : sizeof(dev_req);
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+}
+
+int
+mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	struct mt7921_dev *dev = phy->dev;
+	enum nl80211_band band = chandef->chan->band;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7921_bss_basic_tlv basic;
+		struct mt7921_bss_qos_tlv qos;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = true, /* keep bss deactivated */
+			.phymode = mt7921_get_phy_mode(phy->dev, vif, band, NULL),
+		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt7921_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
+	};
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bss_info_uni_he he;
+	} he_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.he = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
+			.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
+		},
+	};
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct rlm_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 control_channel;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw;
+			u8 tx_streams;
+			u8 rx_streams;
+			u8 short_st;
+			u8 ht_op_info;
+			u8 sco;
+			u8 pad[3];
+		} __packed rlm;
+	} __packed rlm_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.rlm = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
+			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
+			.control_channel = chandef->chan->hw_value,
+			.center_chan = ieee80211_frequency_to_channel(freq1),
+			.center_chan2 = ieee80211_frequency_to_channel(freq2),
+			.tx_streams = hweight8(phy->mt76->antenna_mask),
+			.rx_streams = phy->mt76->chainmask,
+			.short_st = true,
+		},
+	};
+	int err, conn_type;
+	u8 idx;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.conn_state = !enable;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				&basic_req, sizeof(basic_req), true);
+	if (err < 0)
+		return err;
+
+	if (vif->bss_conf.he_support) {
+		mt7921_mcu_uni_bss_he_tlv((struct tlv *)&he_req.he, vif, phy);
+
+		err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+					&he_req, sizeof(he_req), true);
+		if (err < 0)
+			return err;
+	}
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		rlm_req.rlm.bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rlm_req.rlm.bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		rlm_req.rlm.bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		rlm_req.rlm.bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		rlm_req.rlm.bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		break;
+	}
+
+	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 1; /* SCA */
+	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &rlm_req, sizeof(rlm_req), true);
+}
+
+static int
+mt7921_mcu_add_sta_cmd(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable, int cmd)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct mt7921_sta *msta;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+
+	msta = sta ? (struct mt7921_sta *)sta->drv_priv : &mvif->sta;
+
+	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7921_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7921_mcu_sta_basic_tlv(skb, vif, sta, enable);
+	if (enable && sta)
+		mt7921_mcu_sta_tlv(dev, skb, sta, vif);
+
+	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
+					     sta_wtbl, &skb);
+	if (enable) {
+		mt7921_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
+		if (sta)
+			mt7921_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+}
+
+int
+mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable)
+{
+	return mt7921_mcu_add_sta_cmd(dev, vif, sta, enable,
+				      MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
+int mt7921_mcu_set_channel_domain(struct mt7921_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_mcu_channel_domain {
+		__le32 country_code; /* regulatory_request.alpha2 */
+		u8 bw_2g; /* BW_20_40M		0
+			   * BW_20M		1
+			   * BW_20_40_80M	2
+			   * BW_20_40_80_160M	3
+			   * BW_20_40_80_8080M	4
+			   */
+		u8 bw_5g;
+		__le16 pad;
+		u8 n_2ch;
+		u8 n_5ch;
+		__le16 pad2;
+	} __packed hdr = {
+		.bw_2g = 0,
+		.bw_5g = 3,
+		.n_2ch = mphy->sband_2g.sband.n_channels,
+		.n_5ch = mphy->sband_5g.sband.n_channels,
+	};
+	struct mt7921_mcu_chan {
+		__le16 hw_value;
+		__le16 pad;
+		__le32 flags;
+	} __packed;
+	int i, n_channels = hdr.n_2ch + hdr.n_5ch;
+	int len = sizeof(hdr) + n_channels * sizeof(struct mt7921_mcu_chan);
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	for (i = 0; i < n_channels; i++) {
+		struct ieee80211_channel *chan;
+		struct mt7921_mcu_chan channel;
+
+		if (i < hdr.n_2ch)
+			chan = &mphy->sband_2g.sband.channels[i];
+		else
+			chan = &mphy->sband_5g.sband.channels[i - hdr.n_2ch];
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SET_CHAN_DOMAIN,
+				     false);
+}
+
+#define MT7921_SCAN_CHANNEL_TIME	60
+int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration = MT7921_SCAN_CHANNEL_TIME;
+	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_mcu_scan_channel *chan;
+	struct mt7921_hw_scan_req *req;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(*req));
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt7921_hw_scan_req *)skb_put(skb, sizeof(*req));
+
+	req->seq_num = mvif->scan_seq_num;
+	req->bss_idx = mvif->idx;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
+	req->version = 1;
+
+	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
+		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+		n_ssids++;
+	}
+	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
+	req->ssids_num = n_ssids;
+
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
+	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
+	req->channel_min_dwell_time = cpu_to_le16(duration);
+	req->channel_dwell_time = cpu_to_le16(duration);
+
+	req->channels_num = min_t(u8, sreq->n_channels, 32);
+	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
+		if (i >= 32)
+			chan = &req->ext_channels[i - 32];
+		else
+			chan = &req->channels[i];
+
+		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+	req->channel_type = sreq->n_channels ? 4 : 0;
+
+	if (sreq->ie_len > 0) {
+		memcpy(req->ies, sreq->ie, sreq->ie_len);
+		req->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func = 1;
+	}
+
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
+				    false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+
+	return err;
+}
+
+int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		u8 seq_num;
+		u8 is_ext_channel;
+		u8 rsv[2];
+	} __packed req = {
+		.seq_num = mvif->scan_seq_num,
+	};
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->mt76->hw, &info);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
+				 sizeof(req), false);
+}
+
+u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx)
+{
+	struct mt7921_mcu_wlan_info wtbl_info = {
+		.wlan_idx = cpu_to_le32(wlan_idx),
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_GET_WTBL,
+					&wtbl_info, sizeof(wtbl_info), true,
+					&skb);
+	if (ret)
+		return ret;
+
+	mt7921_mcu_tx_rate_report(dev, skb, wlan_idx);
+	dev_kfree_skb(skb);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
new file mode 100644
index 000000000000..96eecea22d94
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -0,0 +1,1050 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_MCU_H
+#define __MT7921_MCU_H
+
+struct mt7921_mcu_txd {
+	__le32 txd[8];
+
+	__le16 len;
+	__le16 pq_id;
+
+	u8 cid;
+	u8 pkt_type;
+	u8 set_query; /* FW don't care */
+	u8 seq;
+
+	u8 uc_d2b0_rev;
+	u8 ext_cid;
+	u8 s2d_index;
+	u8 ext_cid_ack;
+
+	u32 reserved[5];
+} __packed __aligned(4);
+
+/**
+ * struct mt7921_uni_txd - mcu command descriptor for firmware v3
+ * @txd: hardware descriptor
+ * @len: total length not including txd
+ * @cid: command identifier
+ * @pkt_type: must be 0xa0 (cmd packet by long format)
+ * @frag_n: fragment number
+ * @seq: sequence number
+ * @checksum: 0 mean there is no checksum
+ * @s2d_index: index for command source and destination
+ *  Definition              | value | note
+ *  CMD_S2D_IDX_H2N         | 0x00  | command from HOST to WM
+ *  CMD_S2D_IDX_C2N         | 0x01  | command from WA to WM
+ *  CMD_S2D_IDX_H2C         | 0x02  | command from HOST to WA
+ *  CMD_S2D_IDX_H2N_AND_H2C | 0x03  | command from HOST to WA and WM
+ *
+ * @option: command option
+ *  BIT[0]: UNI_CMD_OPT_BIT_ACK
+ *          set to 1 to request a fw reply
+ *          if UNI_CMD_OPT_BIT_0_ACK is set and UNI_CMD_OPT_BIT_2_SET_QUERY
+ *          is set, mcu firmware will send response event EID = 0x01
+ *          (UNI_EVENT_ID_CMD_RESULT) to the host.
+ *  BIT[1]: UNI_CMD_OPT_BIT_UNI_CMD
+ *          0: original command
+ *          1: unified command
+ *  BIT[2]: UNI_CMD_OPT_BIT_SET_QUERY
+ *          0: QUERY command
+ *          1: SET command
+ */
+struct mt7921_uni_txd {
+	__le32 txd[8];
+
+	/* DW1 */
+	__le16 len;
+	__le16 cid;
+
+	/* DW2 */
+	u8 reserved;
+	u8 pkt_type;
+	u8 frag_n;
+	u8 seq;
+
+	/* DW3 */
+	__le16 checksum;
+	u8 s2d_index;
+	u8 option;
+
+	/* DW4 */
+	u8 reserved2[4];
+} __packed __aligned(4);
+
+/* event table */
+enum {
+	MCU_EVENT_REG_ACCESS = 0x05,
+	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_BSS_ABSENCE  = 0x11,
+	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
+	MCU_EVENT_CH_PRIVILEGE = 0x18,
+	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
+	MCU_EVENT_DBG_MSG = 0x27,
+};
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_RATE_REPORT = 0x87,
+};
+
+struct mt7921_mcu_rxd {
+	__le32 rxd[6];
+
+	__le16 len;
+	__le16 pkt_type_id;
+
+	u8 eid;
+	u8 seq;
+	__le16 __rsv;
+
+	u8 ext_eid;
+	u8 __rsv1[2];
+	u8 s2d_index;
+};
+
+struct mt7921_mcu_eeprom_info {
+	__le32 addr;
+	__le32 valid;
+	u8 data[16];
+} __packed;
+
+#define MT_RA_RATE_NSS			GENMASK(8, 6)
+#define MT_RA_RATE_MCS			GENMASK(3, 0)
+#define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
+#define MT_RA_RATE_DCM_EN		BIT(4)
+#define MT_RA_RATE_BW			GENMASK(14, 13)
+
+#define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
+#define MCU_PKT_ID			0xa0
+
+enum {
+	MCU_Q_QUERY,
+	MCU_Q_SET,
+	MCU_Q_RESERVED,
+	MCU_Q_NA
+};
+
+enum {
+	MCU_S2D_H2N,
+	MCU_S2D_C2N,
+	MCU_S2D_H2C,
+	MCU_S2D_H2CN
+};
+
+#define MCU_FW_PREFIX		BIT(31)
+#define MCU_UNI_PREFIX		BIT(30)
+#define MCU_CE_PREFIX		BIT(29)
+#define MCU_QUERY_PREFIX	BIT(28)
+#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
+				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
+
+#define MCU_QUERY_MASK		BIT(16)
+
+enum {
+	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
+	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
+	MCU_CMD_NIC_POWER_CTRL = MCU_FW_PREFIX | 0x4,
+	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
+	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
+	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
+	MCU_CMD_EXT_CID = 0xED,
+	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xEE,
+};
+
+enum {
+	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
+	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
+	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
+	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
+	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
+	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
+	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
+	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
+	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
+	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+};
+
+enum {
+	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
+	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
+	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
+	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
+	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
+	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
+};
+
+struct mt7921_mcu_uni_event {
+	u8 cid;
+	u8 pad[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
+/* offload mcu commands */
+enum {
+	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
+	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
+	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
+	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
+	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
+	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
+	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
+	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
+	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
+};
+
+#define MCU_CMD_ACK		BIT(0)
+#define MCU_CMD_UNI		BIT(1)
+#define MCU_CMD_QUERY		BIT(2)
+
+#define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
+
+enum {
+	UNI_BSS_INFO_BASIC = 0,
+	UNI_BSS_INFO_RLM = 2,
+	UNI_BSS_INFO_HE_BASIC = 5,
+	UNI_BSS_INFO_BCN_CONTENT = 7,
+	UNI_BSS_INFO_QBSS = 15,
+	UNI_BSS_INFO_UAPSD = 19,
+};
+
+enum {
+	UNI_SUSPEND_MODE_SETTING,
+	UNI_SUSPEND_WOW_CTRL,
+	UNI_SUSPEND_WOW_GPIO_PARAM,
+	UNI_SUSPEND_WOW_WAKEUP_PORT,
+	UNI_SUSPEND_WOW_PATTERN,
+};
+
+enum {
+	UNI_OFFLOAD_OFFLOAD_ARP,
+	UNI_OFFLOAD_OFFLOAD_ND,
+	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
+	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
+};
+
+enum {
+	PATCH_SEM_RELEASE,
+	PATCH_SEM_GET
+};
+
+enum {
+	PATCH_NOT_DL_SEM_FAIL,
+	PATCH_IS_DL,
+	PATCH_NOT_DL_SEM_SUCCESS,
+	PATCH_REL_SEM_SUCCESS
+};
+
+enum {
+	FW_STATE_INITIAL,
+	FW_STATE_FW_DOWNLOAD,
+	FW_STATE_NORMAL_OPERATION,
+	FW_STATE_NORMAL_TRX,
+	FW_STATE_WACPU_RDY        = 7
+};
+
+enum {
+	EE_MODE_EFUSE,
+	EE_MODE_BUFFER,
+};
+
+enum {
+	EE_FORMAT_BIN,
+	EE_FORMAT_WHOLE,
+	EE_FORMAT_MULTIPLE,
+};
+
+enum {
+	MCU_PHY_STATE_TX_RATE,
+	MCU_PHY_STATE_RX_RATE,
+	MCU_PHY_STATE_RSSI,
+	MCU_PHY_STATE_CONTENTION_RX_RATE,
+	MCU_PHY_STATE_OFDMLQ_CNINFO,
+};
+
+#define STA_TYPE_STA			BIT(0)
+#define STA_TYPE_AP			BIT(1)
+#define STA_TYPE_ADHOC			BIT(2)
+#define STA_TYPE_WDS			BIT(4)
+#define STA_TYPE_BC			BIT(5)
+
+#define NETWORK_INFRA			BIT(16)
+#define NETWORK_P2P			BIT(17)
+#define NETWORK_IBSS			BIT(18)
+#define NETWORK_WDS			BIT(21)
+
+#define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
+#define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
+#define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
+#define CONNECTION_P2P_GO		(STA_TYPE_AP | NETWORK_P2P)
+#define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
+#define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
+#define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
+
+#define CONN_STATE_DISCONNECT		0
+#define CONN_STATE_CONNECT		1
+#define CONN_STATE_PORT_SECURE		2
+
+enum {
+	DEV_INFO_ACTIVE,
+	DEV_INFO_MAX_NUM
+};
+
+enum {
+	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
+	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
+	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
+	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
+	CMD_CBW_10MHZ,
+	CMD_CBW_5MHZ,
+	CMD_CBW_8080MHZ,
+
+	CMD_HE_MCS_BW80 = 0,
+	CMD_HE_MCS_BW160,
+	CMD_HE_MCS_BW8080,
+	CMD_HE_MCS_BW_NUM
+};
+
+struct tlv {
+	__le16 tag;
+	__le16 len;
+} __packed;
+
+struct bss_info_uni_he {
+	__le16 tag;
+	__le16 len;
+	__le16 he_rts_thres;
+	u8 he_pe_duration;
+	u8 su_disable;
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+	u8 rsv[2];
+} __packed;
+
+enum {
+	WTBL_RESET_AND_SET = 1,
+	WTBL_SET,
+	WTBL_QUERY,
+	WTBL_RESET_ALL
+};
+
+struct wtbl_req_hdr {
+	u8 wlan_idx_lo;
+	u8 operation;
+	__le16 tlv_num;
+	u8 wlan_idx_hi;
+	u8 rsv[3];
+} __packed;
+
+struct wtbl_generic {
+	__le16 tag;
+	__le16 len;
+	u8 peer_addr[ETH_ALEN];
+	u8 muar_idx;
+	u8 skip_tx;
+	u8 cf_ack;
+	u8 qos;
+	u8 mesh;
+	u8 adm;
+	__le16 partial_aid;
+	u8 baf_en;
+	u8 aad_om;
+} __packed;
+
+struct wtbl_rx {
+	__le16 tag;
+	__le16 len;
+	u8 rcid;
+	u8 rca1;
+	u8 rca2;
+	u8 rv;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_ht {
+	__le16 tag;
+	__le16 len;
+	u8 ht;
+	u8 ldpc;
+	u8 af;
+	u8 mm;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_vht {
+	__le16 tag;
+	__le16 len;
+	u8 ldpc;
+	u8 dyn_bw;
+	u8 vht;
+	u8 txop_ps;
+	u8 rsv[4];
+} __packed;
+
+struct wtbl_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 to_ds;
+	u8 from_ds;
+	u8 no_rx_trans;
+	u8 _rsv;
+};
+
+enum {
+	MT_BA_TYPE_INVALID,
+	MT_BA_TYPE_ORIGINATOR,
+	MT_BA_TYPE_RECIPIENT
+};
+
+enum {
+	RST_BA_MAC_TID_MATCH,
+	RST_BA_MAC_MATCH,
+	RST_BA_NO_MATCH
+};
+
+struct wtbl_ba {
+	__le16 tag;
+	__le16 len;
+	/* common */
+	u8 tid;
+	u8 ba_type;
+	u8 rsv0[2];
+	/* originator only */
+	__le16 sn;
+	u8 ba_en;
+	u8 ba_winsize_idx;
+	__le16 ba_winsize;
+	/* recipient only */
+	u8 peer_addr[ETH_ALEN];
+	u8 rst_ba_tid;
+	u8 rst_ba_sel;
+	u8 rst_ba_sb;
+	u8 band_idx;
+	u8 rsv1[4];
+} __packed;
+
+struct wtbl_smps {
+	__le16 tag;
+	__le16 len;
+	u8 smps;
+	u8 rsv[3];
+} __packed;
+
+enum {
+	WTBL_GENERIC,
+	WTBL_RX,
+	WTBL_HT,
+	WTBL_VHT,
+	WTBL_PEER_PS,		/* not used */
+	WTBL_TX_PS,
+	WTBL_HDR_TRANS,
+	WTBL_SEC_KEY,
+	WTBL_BA,
+	WTBL_RDG,		/* obsoleted */
+	WTBL_PROTECT,		/* not used */
+	WTBL_CLEAR,		/* not used */
+	WTBL_BF,
+	WTBL_SMPS,
+	WTBL_RAW_DATA,		/* debug only */
+	WTBL_PN,
+	WTBL_SPE,
+	WTBL_MAX_NUM
+};
+
+struct sta_ntlv_hdr {
+	u8 rsv[2];
+	__le16 tlv_num;
+} __packed;
+
+struct sta_req_hdr {
+	u8 bss_idx;
+	u8 wlan_idx_lo;
+	__le16 tlv_num;
+	u8 is_tlv_append;
+	u8 muar_idx;
+	u8 wlan_idx_hi;
+	u8 rsv;
+} __packed;
+
+struct sta_rec_basic {
+	__le16 tag;
+	__le16 len;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 qos;
+	__le16 aid;
+	u8 peer_addr[ETH_ALEN];
+	__le16 extra_info;
+} __packed;
+
+struct sta_rec_ht {
+	__le16 tag;
+	__le16 len;
+	__le16 ht_cap;
+	u16 rsv;
+} __packed;
+
+struct sta_rec_vht {
+	__le16 tag;
+	__le16 len;
+	__le32 vht_cap;
+	__le16 vht_rx_mcs_map;
+	__le16 vht_tx_mcs_map;
+	u8 rts_bw_sig;
+	u8 rsv[3];
+} __packed;
+
+struct sta_rec_uapsd {
+	__le16 tag;
+	__le16 len;
+	u8 dac_map;
+	u8 tac_map;
+	u8 max_sp;
+	u8 rsv0;
+	__le16 listen_interval;
+	u8 rsv1[2];
+} __packed;
+
+struct sta_rec_he {
+	__le16 tag;
+	__le16 len;
+
+	__le32 he_cap;
+
+	u8 t_frame_dur;
+	u8 max_ampdu_exp;
+	u8 bw_set;
+	u8 device_class;
+	u8 dcm_tx_mode;
+	u8 dcm_tx_max_nss;
+	u8 dcm_rx_mode;
+	u8 dcm_rx_max_nss;
+	u8 dcm_max_ru;
+	u8 punc_pream_rx;
+	u8 pkt_ext;
+	u8 rsv1;
+
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+
+	u8 rsv2[2];
+} __packed;
+
+struct sta_rec_ba {
+	__le16 tag;
+	__le16 len;
+	u8 tid;
+	u8 ba_type;
+	u8 amsdu;
+	u8 ba_en;
+	__le16 ssn;
+	__le16 winsize;
+} __packed;
+
+struct sta_rec_amsdu {
+	__le16 tag;
+	__le16 len;
+	u8 max_amsdu_num;
+	u8 max_mpdu_size;
+	u8 amsdu_en;
+	u8 rsv;
+} __packed;
+
+struct sec_key {
+	u8 cipher_id;
+	u8 cipher_len;
+	u8 key_id;
+	u8 key_len;
+	u8 key[32];
+} __packed;
+
+struct sta_rec_sec {
+	__le16 tag;
+	__le16 len;
+	u8 add;
+	u8 n_cipher;
+	u8 rsv[2];
+
+	struct sec_key key[2];
+} __packed;
+
+struct sta_rec_state {
+	__le16 tag;
+	__le16 len;
+	__le32 flags;
+	u8 state;
+	u8 vht_opmode;
+	u8 action;
+	u8 rsv[1];
+} __packed;
+
+#define HT_MCS_MASK_NUM 10
+
+struct sta_rec_ra_info {
+	__le16 tag;
+	__le16 len;
+	__le16 legacy;
+	u8 rx_mcs_bitmask[HT_MCS_MASK_NUM];
+} __packed;
+
+struct sta_rec_phy {
+	__le16 tag;
+	__le16 len;
+	__le16 basic_rate;
+	u8 phy_type;
+	u8 ampdu;
+	u8 rts_policy;
+	u8 rcpi;
+	u8 rsv[2];
+} __packed;
+
+enum {
+	STA_REC_BASIC,
+	STA_REC_RA,
+	STA_REC_RA_CMM_INFO,
+	STA_REC_RA_UPDATE,
+	STA_REC_BF,
+	STA_REC_AMSDU,
+	STA_REC_BA,
+	STA_REC_STATE,
+	STA_REC_TX_PROC,	/* for hdr trans and CSO in CR4 */
+	STA_REC_HT,
+	STA_REC_VHT,
+	STA_REC_APPS,
+	STA_REC_KEY,
+	STA_REC_WTBL,
+	STA_REC_HE,
+	STA_REC_HW_AMSDU,
+	STA_REC_WTBL_AADOM,
+	STA_REC_KEY_V2,
+	STA_REC_MURU,
+	STA_REC_MUEDCA,
+	STA_REC_BFEE,
+	STA_REC_PHY = 0x15,
+	STA_REC_MAX_NUM
+};
+
+enum mt7921_cipher_type {
+	MT_CIPHER_NONE,
+	MT_CIPHER_WEP40,
+	MT_CIPHER_WEP104,
+	MT_CIPHER_WEP128,
+	MT_CIPHER_TKIP,
+	MT_CIPHER_AES_CCMP,
+	MT_CIPHER_CCMP_256,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
+	MT_CIPHER_WAPI,
+	MT_CIPHER_BIP_CMAC_128,
+};
+
+enum {
+	CH_SWITCH_NORMAL = 0,
+	CH_SWITCH_SCAN = 3,
+	CH_SWITCH_MCC = 4,
+	CH_SWITCH_DFS = 5,
+	CH_SWITCH_BACKGROUND_SCAN_START = 6,
+	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
+	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
+	CH_SWITCH_SCAN_BYPASS_DPD = 9
+};
+
+enum {
+	THERMAL_SENSOR_TEMP_QUERY,
+	THERMAL_SENSOR_MANUAL_CTRL,
+	THERMAL_SENSOR_INFO_QUERY,
+	THERMAL_SENSOR_TASK_CTRL,
+};
+
+enum {
+	MT_EBF = BIT(0),	/* explicit beamforming */
+	MT_IBF = BIT(1)		/* implicit beamforming */
+};
+
+#define MT7921_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_generic) +	\
+					 sizeof(struct wtbl_rx) +	\
+					 sizeof(struct wtbl_ht) +	\
+					 sizeof(struct wtbl_vht) +	\
+					 sizeof(struct wtbl_hdr_trans) +\
+					 sizeof(struct wtbl_ba) +	\
+					 sizeof(struct wtbl_smps))
+
+#define MT7921_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
+					 sizeof(struct sta_rec_basic) +	\
+					 sizeof(struct sta_rec_ht) +	\
+					 sizeof(struct sta_rec_he) +	\
+					 sizeof(struct sta_rec_ba) +	\
+					 sizeof(struct sta_rec_vht) +	\
+					 sizeof(struct sta_rec_uapsd) + \
+					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct tlv) +		\
+					 MT7921_WTBL_UPDATE_MAX_SIZE)
+
+#define MT7921_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
+					 sizeof(struct wtbl_ba))
+
+#define PHY_MODE_A			BIT(0)
+#define PHY_MODE_B			BIT(1)
+#define PHY_MODE_G			BIT(2)
+#define PHY_MODE_GN			BIT(3)
+#define PHY_MODE_AN			BIT(4)
+#define PHY_MODE_AC			BIT(5)
+#define PHY_MODE_AX_24G			BIT(6)
+#define PHY_MODE_AX_5G			BIT(7)
+#define PHY_MODE_AX_6G			BIT(8)
+
+#define MODE_CCK			BIT(0)
+#define MODE_OFDM			BIT(1)
+#define MODE_HT				BIT(2)
+#define MODE_VHT			BIT(3)
+#define MODE_HE				BIT(4)
+
+#define STA_CAP_WMM			BIT(0)
+#define STA_CAP_SGI_20			BIT(4)
+#define STA_CAP_SGI_40			BIT(5)
+#define STA_CAP_TX_STBC			BIT(6)
+#define STA_CAP_RX_STBC			BIT(7)
+#define STA_CAP_VHT_SGI_80		BIT(16)
+#define STA_CAP_VHT_SGI_160		BIT(17)
+#define STA_CAP_VHT_TX_STBC		BIT(18)
+#define STA_CAP_VHT_RX_STBC		BIT(19)
+#define STA_CAP_VHT_LDPC		BIT(23)
+#define STA_CAP_LDPC			BIT(24)
+#define STA_CAP_HT			BIT(26)
+#define STA_CAP_VHT			BIT(27)
+#define STA_CAP_HE			BIT(28)
+
+/* HE MAC */
+#define STA_REC_HE_CAP_HTC			BIT(0)
+#define STA_REC_HE_CAP_BQR			BIT(1)
+#define STA_REC_HE_CAP_BSR			BIT(2)
+#define STA_REC_HE_CAP_OM			BIT(3)
+#define STA_REC_HE_CAP_AMSDU_IN_AMPDU		BIT(4)
+/* HE PHY */
+#define STA_REC_HE_CAP_DUAL_BAND		BIT(5)
+#define STA_REC_HE_CAP_LDPC			BIT(6)
+#define STA_REC_HE_CAP_TRIG_CQI_FK		BIT(7)
+#define STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE	BIT(8)
+/* STBC */
+#define STA_REC_HE_CAP_LE_EQ_80M_TX_STBC	BIT(9)
+#define STA_REC_HE_CAP_LE_EQ_80M_RX_STBC	BIT(10)
+#define STA_REC_HE_CAP_GT_80M_TX_STBC		BIT(11)
+#define STA_REC_HE_CAP_GT_80M_RX_STBC		BIT(12)
+/* GI */
+#define STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI	BIT(13)
+#define STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI	BIT(14)
+#define STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI	BIT(15)
+#define STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI	BIT(16)
+#define STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI	BIT(17)
+/* 242 TONE */
+#define STA_REC_HE_CAP_BW20_RU242_SUPPORT	BIT(18)
+#define STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242	BIT(19)
+#define STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242	BIT(20)
+
+struct mt7921_mcu_reg_event {
+	__le32 reg;
+	__le32 val;
+} __packed;
+
+struct mt7921_bss_basic_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 active;
+	u8 omac_idx;
+	u8 hw_bss_idx;
+	u8 band_idx;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 wmm_idx;
+	u8 bssid[ETH_ALEN];
+	__le16 bmc_tx_wlan_idx;
+	__le16 bcn_interval;
+	u8 dtim_period;
+	u8 phymode; /* bit(0): A
+		     * bit(1): B
+		     * bit(2): G
+		     * bit(3): GN
+		     * bit(4): AN
+		     * bit(5): AC
+		     */
+	__le16 sta_idx;
+	u8 nonht_basic_phy;
+	u8 pad[3];
+} __packed;
+
+struct mt7921_bss_qos_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 qos;
+	u8 pad[3];
+} __packed;
+
+struct mt7921_mcu_scan_ssid {
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+} __packed;
+
+struct mt7921_mcu_scan_channel {
+	u8 band; /* 1: 2.4GHz
+		  * 2: 5.0GHz
+		  * Others: Reserved
+		  */
+	u8 channel_num;
+} __packed;
+
+struct mt7921_mcu_scan_match {
+	__le32 rssi_th;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	u8 rsv[3];
+} __packed;
+
+struct mt7921_hw_scan_req {
+	u8 seq_num;
+	u8 bss_idx;
+	u8 scan_type; /* 0: PASSIVE SCAN
+		       * 1: ACTIVE SCAN
+		       */
+	u8 ssid_type; /* BIT(0) wildcard SSID
+		       * BIT(1) P2P wildcard SSID
+		       * BIT(2) specified SSID + wildcard SSID
+		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
+		       */
+	u8 ssids_num;
+	u8 probe_req_num; /* Number of probe request for each SSID */
+	u8 scan_func; /* BIT(0) Enable random MAC scan
+		       * BIT(1) Disable DBDC scan type 1~3.
+		       * BIT(2) Use DBDC scan type 3 (dedicated one RF to scan).
+		       */
+	u8 version; /* 0: Not support fields after ies.
+		     * 1: Support fields after ies.
+		     */
+	struct mt7921_mcu_scan_ssid ssids[4];
+	__le16 probe_delay_time;
+	__le16 channel_dwell_time; /* channel Dwell interval */
+	__le16 timeout_value;
+	u8 channel_type; /* 0: Full channels
+			  * 1: Only 2.4GHz channels
+			  * 2: Only 5GHz channels
+			  * 3: P2P social channel only (channel #1, #6 and #11)
+			  * 4: Specified channels
+			  * Others: Reserved
+			  */
+	u8 channels_num; /* valid when channel_type is 4 */
+	/* valid when channels_num is set */
+	struct mt7921_mcu_scan_channel channels[32];
+	__le16 ies_len;
+	u8 ies[MT7921_SCAN_IE_LEN];
+	/* following fields are valid if version > 0 */
+	u8 ext_channels_num;
+	u8 ext_ssids_num;
+	__le16 channel_min_dwell_time;
+	struct mt7921_mcu_scan_channel ext_channels[32];
+	struct mt7921_mcu_scan_ssid ext_ssids[6];
+	u8 bssid[ETH_ALEN];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
+	u8 pad[63];
+	u8 ssid_type_ext;
+} __packed;
+
+#define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
+struct mt7921_hw_scan_done {
+	u8 seq_num;
+	u8 sparse_channel_num;
+	struct mt7921_mcu_scan_channel sparse_channel;
+	u8 complete_channel_num;
+	u8 current_state;
+	u8 version;
+	u8 pad;
+	__le32 beacon_scan_num;
+	u8 pno_enabled;
+	u8 pad2[3];
+	u8 sparse_channel_valid_num;
+	u8 pad3[3];
+	u8 channel_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* idle format for channel_idle_time
+	 * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
+	 * 1: first bytes: idle time(8ms) 2nd byte: dwell time(8ms)
+	 * 2: dwell time (16us)
+	 */
+	__le16 channel_idle_time[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	/* beacon and probe response count */
+	u8 beacon_probe_num[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	u8 mdrdy_count[SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
+	__le32 beacon_2g_num;
+	__le32 beacon_5g_num;
+} __packed;
+
+struct mt7921_mcu_bss_event {
+	u8 bss_idx;
+	u8 is_absent;
+	u8 free_quota;
+	u8 pad;
+} __packed;
+
+enum {
+	PHY_TYPE_HR_DSSS_INDEX = 0,
+	PHY_TYPE_ERP_INDEX,
+	PHY_TYPE_ERP_P2P_INDEX,
+	PHY_TYPE_OFDM_INDEX,
+	PHY_TYPE_HT_INDEX,
+	PHY_TYPE_VHT_INDEX,
+	PHY_TYPE_HE_INDEX,
+	PHY_TYPE_INDEX_NUM
+};
+
+#define PHY_TYPE_BIT_HR_DSSS    BIT(PHY_TYPE_HR_DSSS_INDEX)
+#define PHY_TYPE_BIT_ERP        BIT(PHY_TYPE_ERP_INDEX)
+#define PHY_TYPE_BIT_OFDM       BIT(PHY_TYPE_OFDM_INDEX)
+#define PHY_TYPE_BIT_HT         BIT(PHY_TYPE_HT_INDEX)
+#define PHY_TYPE_BIT_VHT        BIT(PHY_TYPE_VHT_INDEX)
+#define PHY_TYPE_BIT_HE         BIT(PHY_TYPE_HE_INDEX)
+
+#define MT_WTBL_RATE_TX_MODE	GENMASK(9, 6)
+#define MT_WTBL_RATE_MCS	GENMASK(5, 0)
+#define MT_WTBL_RATE_NSS	GENMASK(12, 10)
+#define MT_WTBL_RATE_HE_GI	GENMASK(7, 4)
+#define MT_WTBL_RATE_GI		GENMASK(3, 0)
+
+struct mt7921_mcu_tx_config {
+	u8 peer_addr[ETH_ALEN];
+	u8 sw;
+	u8 dis_rx_hdr_tran;
+
+	u8 aad_om;
+	u8 pfmu_idx;
+	__le16 partial_aid;
+
+	u8 ibf;
+	u8 ebf;
+	u8 is_ht;
+	u8 is_vht;
+
+	u8 mesh;
+	u8 baf_en;
+	u8 cf_ack;
+	u8 rdg_ba;
+
+	u8 rdg;
+	u8 pm;
+	u8 rts;
+	u8 smps;
+
+	u8 txop_ps;
+	u8 not_update_ipsm;
+	u8 skip_tx;
+	u8 ldpc;
+
+	u8 qos;
+	u8 from_ds;
+	u8 to_ds;
+	u8 dyn_bw;
+
+	u8 amdsu_cross_lg;
+	u8 check_per;
+	u8 gid_63;
+	u8 he;
+
+	u8 vht_ibf;
+	u8 vht_ebf;
+	u8 vht_ldpc;
+	u8 he_ldpc;
+} __packed;
+
+struct mt7921_mcu_sec_config {
+	u8 wpi_flag;
+	u8 rv;
+	u8 ikv;
+	u8 rkv;
+
+	u8 rcid;
+	u8 rca1;
+	u8 rca2;
+	u8 even_pn;
+
+	u8 key_id;
+	u8 muar_idx;
+	u8 cipher_suit;
+	u8 rsv[1];
+} __packed;
+
+struct mt7921_mcu_key_config {
+	u8 key[32];
+} __packed;
+
+struct mt7921_mcu_rate_info {
+	u8 mpdu_fail;
+	u8 mpdu_tx;
+	u8 rate_idx;
+	u8 rsv[1];
+	__le16 rate[8];
+} __packed;
+
+struct mt7921_mcu_ba_config {
+	u8 ba_en;
+	u8 rsv[3];
+	__le32 ba_winsize;
+} __packed;
+
+struct mt7921_mcu_ant_id_config {
+	u8 ant_id[4];
+} __packed;
+
+struct mt7921_mcu_peer_cap {
+	struct mt7921_mcu_ant_id_config ant_id_config;
+
+	u8 power_offset;
+	u8 bw_selector;
+	u8 change_bw_rate_n;
+	u8 bw;
+	u8 spe_idx;
+
+	u8 g2;
+	u8 g4;
+	u8 g8;
+	u8 g16;
+
+	u8 mmss;
+	u8 ampdu_factor;
+	u8 rsv[1];
+} __packed;
+
+struct mt7921_mcu_rx_cnt {
+	u8 rx_rcpi[4];
+	u8 rx_cc[4];
+	u8 rx_cc_sel;
+	u8 ce_rmsd;
+	u8 rsv[2];
+} __packed;
+
+struct mt7921_mcu_tx_cnt {
+	__le16 rate1_cnt;
+	__le16 rate1_fail_cnt;
+	__le16 rate2_cnt;
+	__le16 rate3_cnt;
+	__le16 cur_bw_tx_cnt;
+	__le16 cur_bw_tx_fail_cnt;
+	__le16 other_bw_tx_cnt;
+	__le16 other_bw_tx_fail_cnt;
+} __packed;
+
+struct mt7921_mcu_wlan_info_event {
+	struct mt7921_mcu_tx_config tx_config;
+	struct mt7921_mcu_sec_config sec_config;
+	struct mt7921_mcu_key_config key_config;
+	struct mt7921_mcu_rate_info rate_info;
+	struct mt7921_mcu_ba_config ba_config;
+	struct mt7921_mcu_peer_cap peer_cap;
+	struct mt7921_mcu_rx_cnt rx_cnt;
+	struct mt7921_mcu_tx_cnt tx_cnt;
+} __packed;
+
+struct mt7921_mcu_wlan_info {
+	__le32 wlan_idx;
+	struct mt7921_mcu_wlan_info_event event;
+} __packed;
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index d339ee12cb7d..5e4df00b1129 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -134,6 +134,8 @@ struct mt7921_phy {
 	struct mib_stats mib;
 	struct list_head stats_list;
 
+	u8 sta_work_count;
+
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 };
-- 
2.25.1

