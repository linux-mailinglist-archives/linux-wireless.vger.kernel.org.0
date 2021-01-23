Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34D3013FE
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbhAWIhj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:37:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54858 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbhAWIhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:37:25 -0500
X-UUID: 6cf083f9948e4540a2b8246e85d227b5-20210123
X-UUID: 6cf083f9948e4540a2b8246e85d227b5-20210123
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1225121830; Sat, 23 Jan 2021 16:35:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:15 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v7 05/22] mt76: mt7921: add ieee80211_ops
Date:   Sat, 23 Jan 2021 16:34:56 +0800
Message-ID: <a3e6c4b5eb0c3b1c07f1d077ee70193dd4fc943c.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Filling ieee80211_ops with the mt7921 operations.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 934 ++++++++++++++++++
 1 file changed, 934 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
new file mode 100644
index 000000000000..1138650d83ff
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -0,0 +1,934 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include "mt7921.h"
+#include "mcu.h"
+
+static void
+mt7921_gen_ppe_thresh(u8 *he_ppet, int nss)
+{
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+	u8 ppet16_ppet8_ru3_ru0[] = {0x1c, 0xc7, 0x71};
+
+	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
+		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
+				ru_bit_mask);
+
+	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
+		    nss * hweight8(ru_bit_mask) * 2;
+	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
+
+	for (i = 0; i < ppet_size - 1; i++)
+		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
+
+	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
+			 (0xff >> (8 - (ppet_bits - 1) % 8));
+}
+
+static int
+mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data)
+{
+	int i, idx = 0;
+	int nss = hweight8(phy->mt76->chainmask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+		struct ieee80211_he_mcs_nss_supp *he_mcs =
+				&he_cap->he_mcs_nss_supp;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+			break;
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+
+		he_cap_elem->mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE;
+		he_cap_elem->mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_RESERVED;
+		he_cap_elem->mac_cap_info[4] =
+			IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else if (band == NL80211_BAND_5GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_REQ;
+			he_cap_elem->mac_cap_info[1] |=
+				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+			if (band == NL80211_BAND_2GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+			else if (band == NL80211_BAND_5GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+			he_cap_elem->phy_cap_info[1] |=
+				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
+				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			he_cap_elem->phy_cap_info[8] |=
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+			break;
+		}
+
+		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map);
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			mt7921_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		} else {
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
+		}
+		idx++;
+	}
+
+	return idx;
+}
+
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
+{
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_supported_band *band;
+	int n;
+
+	if (phy->mt76->cap.has_2ghz) {
+		data = phy->iftype[NL80211_BAND_2GHZ];
+		n = mt7921_init_he_caps(phy, NL80211_BAND_2GHZ, data);
+
+		band = &phy->mt76->sband_2g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_5ghz) {
+		data = phy->iftype[NL80211_BAND_5GHZ];
+		n = mt7921_init_he_caps(phy, NL80211_BAND_5GHZ, data);
+
+		band = &phy->mt76->sband_5g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+}
+
+static int mt7921_start(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7921_mcu_set_mac(dev, 0, true, false);
+	mt7921_mcu_set_channel_domain(phy);
+	mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	mt7921_mac_reset_counters(phy);
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT7921_WATCHDOG_TIME);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void mt7921_stop(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	mt7921_mcu_set_mac(dev, 0, false, false);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static inline int get_free_idx(u32 mask, u8 start, u8 end)
+{
+	return ffs(~mask & GENMASK(end, start));
+}
+
+static int get_omac_idx(enum nl80211_iftype type, u64 mask)
+{
+	int i;
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		/* prefer hw bssid slot 1-3 */
+		i = get_free_idx(mask, HW_BSSID_1, HW_BSSID_3);
+		if (i)
+			return i - 1;
+
+		if (type != NL80211_IFTYPE_STATION)
+			break;
+
+		/* next, try to find a free repeater entry for the sta */
+		i = get_free_idx(mask >> REPEATER_BSSID_START, 0,
+				 REPEATER_BSSID_MAX - REPEATER_BSSID_START);
+		if (i)
+			return i + 32 - 1;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		/* ap uses hw bssid 0 and ext bssid */
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	return -1;
+}
+
+static int mt7921_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt76_txq *mtxq;
+	int idx, ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR &&
+	    is_zero_ether_addr(vif->addr))
+		phy->monitor_vif = vif;
+
+	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
+	if (mvif->mt76.idx >= MT7921_MAX_INTERFACES) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	idx = get_omac_idx(vif->type, phy->omac_mask);
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	mvif->mt76.omac_idx = idx;
+	mvif->phy = phy;
+	mvif->mt76.band_idx = 0;
+	mvif->mt76.wmm_idx = mvif->mt76.idx % MT7921_MAX_WMM_SETS;
+
+	ret = mt7921_mcu_uni_add_dev(dev, vif, true);
+	if (ret)
+		goto out;
+
+	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+
+	idx = MT7921_WTBL_RESERVED - mvif->mt76.idx;
+
+	INIT_LIST_HEAD(&mvif->sta.stats_list);
+	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	mvif->sta.wcid.idx = idx;
+	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
+	mvif->sta.wcid.hw_key_idx = -1;
+	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt7921_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = &mvif->sta.wcid;
+	}
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    (!mvif->mt76.omac_idx || mvif->mt76.omac_idx > 3))
+		vif->offload_flags = 0;
+
+	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static void mt7921_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = &mvif->sta;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int idx = msta->wcid.idx;
+
+	if (vif == phy->monitor_vif)
+		phy->monitor_vif = NULL;
+
+	mt7921_mcu_uni_add_dev(dev, vif, false);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+
+	mutex_lock(&dev->mt76.mutex);
+	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	mutex_unlock(&dev->mt76.mutex);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+int mt7921_set_channel(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	int ret;
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	set_bit(MT76_RESET, &phy->mt76->state);
+
+	mt76_set_channel(phy->mt76);
+
+	ret = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
+	if (ret)
+		goto out;
+
+	mt7921_mac_set_timing(phy);
+
+	mt7921_mac_reset_counters(phy);
+	phy->noise = 0;
+
+out:
+	clear_bit(MT76_RESET, &phy->mt76->state);
+	mutex_unlock(&dev->mt76.mutex);
+
+	mt76_txq_schedule_all(phy->mt76);
+
+	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mt76->mac_work,
+				     MT7921_WATCHDOG_TIME);
+
+	return ret;
+}
+
+static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = sta ? (struct mt7921_sta *)sta->drv_priv :
+				  &mvif->sta;
+	struct mt76_wcid *wcid = &msta->wcid;
+	int idx = key->keyidx;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (cmd == SET_KEY) {
+		key->hw_key_idx = wcid->idx;
+		wcid->hw_key_idx = idx;
+	} else if (idx == wcid->hw_key_idx) {
+		wcid->hw_key_idx = -1;
+	}
+	mt76_wcid_key_setup(&dev->mt76, wcid,
+			    cmd == SET_KEY ? key : NULL);
+
+	return mt7921_mcu_add_key(dev, vif, msta, key, cmd);
+}
+
+static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool band = phy != &dev->phy;
+	int ret;
+
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ieee80211_stop_queues(hw);
+		ret = mt7921_set_channel(phy);
+		if (ret)
+			return ret;
+		ieee80211_wake_queues(hw);
+	}
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+		if (!enabled)
+			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+		else
+			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+
+		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+			       enabled);
+		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+	/* no need to update right away, we'll get BSS_CHANGED_QOS */
+	queue = mt7921_lmac_mapping(dev, queue);
+	mvif->queue_params[queue] = *params;
+
+	return 0;
+}
+
+static void mt7921_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	bool band = phy != &dev->phy;
+	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
+			MT_WF_RFCR1_DROP_BF_POLL |
+			MT_WF_RFCR1_DROP_BA |
+			MT_WF_RFCR1_DROP_CFEND |
+			MT_WF_RFCR1_DROP_CFACK;
+	u32 flags = 0;
+
+#define MT76_FILTER(_flag, _hw) do {					\
+		flags |= *total_flags & FIF_##_flag;			\
+		phy->rxfilter &= ~(_hw);				\
+		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+	} while (0)
+
+	mutex_lock(&dev->mt76.mutex);
+
+	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
+			   MT_WF_RFCR_DROP_OTHER_BEACON |
+			   MT_WF_RFCR_DROP_FRAME_REPORT |
+			   MT_WF_RFCR_DROP_PROBEREQ |
+			   MT_WF_RFCR_DROP_MCAST_FILTERED |
+			   MT_WF_RFCR_DROP_MCAST |
+			   MT_WF_RFCR_DROP_BCAST |
+			   MT_WF_RFCR_DROP_DUPLICATE |
+			   MT_WF_RFCR_DROP_A2_BSSID |
+			   MT_WF_RFCR_DROP_UNWANTED_CTL |
+			   MT_WF_RFCR_DROP_STBC_MULTI);
+
+	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
+			       MT_WF_RFCR_DROP_A3_MAC |
+			       MT_WF_RFCR_DROP_A3_BSSID);
+
+	MT76_FILTER(FCSFAIL, MT_WF_RFCR_DROP_FCSFAIL);
+
+	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
+			     MT_WF_RFCR_DROP_RTS |
+			     MT_WF_RFCR_DROP_CTL_RSV |
+			     MT_WF_RFCR_DROP_NDPA);
+
+	*total_flags = flags;
+	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+
+	if (*total_flags & FIF_CONTROL)
+		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
+	else
+		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *info,
+				    u32 changed)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7921_mac_set_timing(phy);
+		}
+	}
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7921_mcu_set_tx(dev, vif);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int ret, idx;
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
+	INIT_LIST_HEAD(&msta->stats_list);
+	INIT_LIST_HEAD(&msta->poll_list);
+	msta->vif = mvif;
+	msta->wcid.sta = 1;
+	msta->wcid.idx = idx;
+	msta->wcid.ext_phy = mvif->mt76.band_idx;
+	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->stats.jiffies = jiffies;
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mt7921_mcu_uni_add_bss(&dev->phy, vif, true);
+	mt7921_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ret = mt7921_mcu_uni_add_sta(dev, vif, sta, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+	mt7921_mcu_uni_add_sta(dev, vif, sta, false);
+	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mt7921_mcu_uni_add_bss(&dev->phy, vif, false);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->stats_list))
+		list_del_init(&msta->stats_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+static void mt7921_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
+		      struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+
+	if (control->sta) {
+		struct mt7921_sta *sta;
+
+		sta = (struct mt7921_sta *)control->sta->drv_priv;
+		wcid = &sta->wcid;
+	}
+
+	if (vif && !control->sta) {
+		struct mt7921_vif *mvif;
+
+		mvif = (struct mt7921_vif *)vif->drv_priv;
+		wcid = &mvif->sta.wcid;
+	}
+
+	mt76_tx(mphy, control->sta, wcid, skb);
+}
+
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7921_mcu_set_rts_thresh(phy, val);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_ampdu_params *params)
+{
+	enum ieee80211_ampdu_mlme_action action = params->action;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct ieee80211_sta *sta = params->sta;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	u16 tid = params->tid;
+	u16 ssn = params->ssn;
+	struct mt76_txq *mtxq;
+	int ret = 0;
+
+	if (!txq)
+		return -EINVAL;
+
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+
+	mutex_lock(&dev->mt76.mutex);
+	switch (action) {
+	case IEEE80211_AMPDU_RX_START:
+		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+				   params->buf_size);
+		mt7921_mcu_uni_rx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		mt7921_mcu_uni_rx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mtxq->aggr = true;
+		mtxq->send_bar = false;
+		mt7921_mcu_uni_tx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->ampdu_state);
+		mt7921_mcu_uni_tx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		set_bit(tid, &msta->ampdu_state);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->ampdu_state);
+		mt7921_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	}
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7921_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta)
+{
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
+			      IEEE80211_STA_NONE);
+}
+
+static int
+mt7921_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  struct ieee80211_sta *sta)
+{
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
+			      IEEE80211_STA_NOTEXIST);
+}
+
+static int
+mt7921_get_stats(struct ieee80211_hw *hw,
+		 struct ieee80211_low_level_stats *stats)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mib_stats *mib = &phy->mib;
+
+	stats->dot11RTSSuccessCount = mib->rts_cnt;
+	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
+	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
+	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
+
+	return 0;
+}
+
+static u64
+mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	u8 omac_idx = mvif->mt76.omac_idx;
+	bool band = phy != &dev->phy;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf;
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
+	/* TSF software read */
+	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE);
+	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
+	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return tsf.t64;
+}
+
+static void
+mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       u64 timestamp)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	u8 omac_idx = mvif->mt76.omac_idx;
+	bool band = phy != &dev->phy;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
+	/* TSF software overwrite */
+	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_WRITE);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
+
+	mutex_lock(&dev->mt76.mutex);
+	phy->coverage_class = max_t(s16, coverage_class, 0);
+	mt7921_mac_set_timing(phy);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+void mt7921_scan_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						scan_work.work);
+
+	while (true) {
+		struct mt7921_mcu_rxd *rxd;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&phy->dev->mt76.lock);
+		skb = __skb_dequeue(&phy->scan_event_list);
+		spin_unlock_bh(&phy->dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		rxd = (struct mt7921_mcu_rxd *)skb->data;
+		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
+			ieee80211_sched_scan_results(phy->mt76->hw);
+		} else if (test_and_clear_bit(MT76_HW_SCANNING,
+					      &phy->mt76->state)) {
+			struct cfg80211_scan_info info = {
+				.aborted = false,
+			};
+
+			ieee80211_scan_completed(phy->mt76->hw, &info);
+		}
+		dev_kfree_skb(skb);
+	}
+}
+
+static int
+mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_scan_request *req)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+	err = mt7921_mcu_hw_scan(mphy->priv, vif, req);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static void
+mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7921_mcu_cancel_hw_scan(mphy->priv, vif);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static int
+mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
+
+	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+		return -EINVAL;
+
+	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
+		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	phy->mt76->antenna_mask = tx_ant;
+	phy->mt76->chainmask = tx_ant;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7921_set_stream_he_caps(phy);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void
+mt7921_sta_rc_update(struct ieee80211_hw *hw,
+		     struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta,
+		     u32 changed)
+{
+}
+
+const struct ieee80211_ops mt7921_ops = {
+	.tx = mt7921_tx,
+	.start = mt7921_start,
+	.stop = mt7921_stop,
+	.add_interface = mt7921_add_interface,
+	.remove_interface = mt7921_remove_interface,
+	.config = mt7921_config,
+	.conf_tx = mt7921_conf_tx,
+	.configure_filter = mt7921_configure_filter,
+	.bss_info_changed = mt7921_bss_info_changed,
+	.sta_add = mt7921_sta_add,
+	.sta_remove = mt7921_sta_remove,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.sta_rc_update = mt7921_sta_rc_update,
+	.set_key = mt7921_set_key,
+	.ampdu_action = mt7921_ampdu_action,
+	.set_rts_threshold = mt7921_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.get_txpower = mt76_get_txpower,
+	.get_stats = mt7921_get_stats,
+	.get_tsf = mt7921_get_tsf,
+	.set_tsf = mt7921_set_tsf,
+	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
+	.set_antenna = mt7921_set_antenna,
+	.set_coverage_class = mt7921_set_coverage_class,
+	.hw_scan = mt7921_hw_scan,
+	.cancel_hw_scan = mt7921_cancel_hw_scan,
+};
-- 
2.25.1

