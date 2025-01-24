Return-Path: <linux-wireless+bounces-17910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E6A1BB50
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55A93AEBF7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5F29A5;
	Fri, 24 Jan 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/BBn3Zj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A021922F9
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739132; cv=none; b=Oh9+1Alf3A93A5b8Eih2jJwBRolTdTK7CxHdbd7M/oHJaQNwf7hWSs27Y0MICsfKtMwAxfqAcyZqSNBaLZHFiGUEXddlaHvQOIWn6k0Sj6LRASKCY+VZz/bM+abiqt2T05namhM0CD/ANZSS9uVuil/BvDpuZ+2nt9SVP8HUqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739132; c=relaxed/simple;
	bh=LmzEh/Axv8E0OCmfnY/jvTtS8M+pJ55k95XyxTFXG4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHYtKRZPh2SJRGqBw3VCbDcHflKX9phf1PYObctW5WX0rLYQUvhf73Td7nsGtUc86Q1yY/3bdQVSE7KbzfFUcnS5IckYV3zKLcj8rUhYhCIQtP7wrZWGTkcERqpaQ4TB7FXWTohCq3ymDSxc1lY2BKdeIRZhnRQwtEDAoz+RDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g/BBn3Zj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OAkq1L008024;
	Fri, 24 Jan 2025 17:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J0ITIxKt21nluw0FpOL1TFwuZ6W2KWKr9y9cGArU0gY=; b=g/BBn3Zj+FwvvRZ3
	xxB9+zFIytErCXospA0eOmUWl7tQywFqXRt47N4uFFHSQm38TvmCkEJTjsokS53k
	t7x59DcnFgXr4C/fZmv9dQ/KhhFLKPTyaX8ZZ2Yn92GyoQvdXFKCnTma1vvEfbu1
	ZLPLAhr8Q40mG331tKtlf7X58RiqjWxm8BWTV259Y6sY8Ffz/pnmYU8M7s1nccVU
	Vg2mjsgLZ9kYSLT4MBo6OjHkrk/1C+Ol9g2TyOmjcts3O48SHUwN4MvETCtgT7oc
	t2ra4XTDXLHvSjBPikj5a3ME8zxK1QefwqOo2tvgbx1TGsziWjmQ/mEeYLK2MrPa
	CXduSw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c9djh0rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 17:18:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50OHIj12027879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 17:18:45 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 09:18:43 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 3/5] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Fri, 24 Jan 2025 22:47:54 +0530
Message-ID: <20250124171756.3418663-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124171756.3418663-1-quic_rdevanat@quicinc.com>
References: <20250124171756.3418663-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xjmAG2qF3L1PewdBPptTXncPsIKUzAJk
X-Proofpoint-ORIG-GUID: xjmAG2qF3L1PewdBPptTXncPsIKUzAJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240119

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.

A value of NL80211_WIPHY_RADIO_ID_MAX(255) indicates radio index is not
mentioned and the configuration applies to all radio(s) of the wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c      |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/marvell/mwl8k.c          |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  1 +
 drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
 drivers/net/wireless/st/cw1200/sta.c          |  2 +-
 drivers/net/wireless/st/cw1200/sta.h          |  2 +-
 drivers/net/wireless/ti/wl1251/main.c         |  2 +-
 drivers/net/wireless/ti/wlcore/main.c         |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 ++-
 include/net/mac80211.h                        |  2 +-
 net/mac80211/cfg.c                            |  8 ++++++-
 net/mac80211/driver-ops.h                     |  6 ++---
 net/mac80211/trace.h                          | 24 ++++++++++++++++---
 net/mac80211/util.c                           |  7 +++++-
 36 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 156f3650c006..ad5dcc703370 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1083,7 +1083,7 @@ static void ar5523_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->mutex);
 }
 
-static int ar5523_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ar5523_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct ar5523 *ar = hw->priv;
 	int ret;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c61b95a928da..4aac40ade257 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8018,7 +8018,7 @@ static int ath10k_cancel_remain_on_channel(struct ieee80211_hw *hw,
  * in ath10k, but device-specific in mac80211.
  */
 
-static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1556392f7ad4..225f32211b84 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8122,7 +8122,7 @@ ath11k_set_vdev_param_to_all_vifs(struct ath11k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath11k driver
  */
-static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct ath11k *ar = hw->priv;
 	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2d062b5904a8..fa6f0e6555bf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9380,7 +9380,7 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath12k driver
  */
-static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 57094bd45d98..88bbb2fec837 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1737,7 +1737,7 @@ static void ath9k_htc_sw_scan_complete(struct ieee80211_hw *hw,
 	mutex_unlock(&priv->mutex);
 }
 
-static int ath9k_htc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath9k_htc_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 94d08d6ae1a3..d7925d070e34 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -965,7 +965,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 /* this is required when using IEEE80211_HW_HAS_RATE_CONTROL */
-static int wcn36xx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wcn36xx_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct wcn36xx *wcn = hw->priv;
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac set RTS threshold %d\n", value);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index af6644b7e95f..c7923412e843 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4241,7 +4241,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	return ret;
 }
 
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ee769da72e68..ffb233a8a6cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2919,7 +2919,7 @@ iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
 				    int num_frames,
 				    enum ieee80211_frame_release_type reason,
 				    bool more_data);
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_link_sta *link_sta, u32 changed);
 void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index bab9ef37a1ab..57cad1a104c8 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5321,7 +5321,7 @@ static void mwl8k_configure_filter(struct ieee80211_hw *hw,
 	mwl8k_fw_unlock(hw);
 }
 
-static int mwl8k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mwl8k_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	return mwl8k_cmd_set_rts_threshold(hw, value);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2e7b05eeef7a..697623d96a62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -784,7 +784,7 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
 }
 
-static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4cd63bacd742..1b8af4b704f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -184,7 +184,7 @@ void mt76x02_tx_set_txpwr_auto(struct mt76x02_dev *dev, s8 txpwr);
 void mt76x02_set_tx_ackto(struct mt76x02_dev *dev);
 void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 				s16 coverage_class);
-int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val);
+int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val);
 void mt76x02_remove_hdr_pad(struct sk_buff *skb, int len);
 bool mt76x02_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 4fb30589fa7a..314d13eb3785 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -559,7 +559,7 @@ void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(mt76x02_set_coverage_class);
 
-int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6..3b43eb380681 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -906,7 +906,7 @@ static void mt7915_tx(struct ieee80211_hw *hw,
 	mt76_tx(mphy, control->sta, wcid, skb);
 }
 
-static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 13e58c328aff..99bf04723c07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -901,7 +901,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
-static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 98daf80ac131..8d72fc8ebd87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1254,7 +1254,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
-static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 69dd565d8319..1f42a35e3cf9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -887,7 +887,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	mt76_tx(mphy, control->sta, wcid, skb);
 }
 
-static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	int i, ret;
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 7570c6ceecea..118eb52c3150 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -334,7 +334,7 @@ mt7601u_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return mt76_mac_wcid_set_key(dev, msta->wcid.idx, key);
 }
 
-static int mt7601u_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mt7601u_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct mt7601u_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index eae93efa6150..13e04cd6d5e6 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -678,7 +678,7 @@ static void plfxlc_get_et_stats(struct ieee80211_hw *hw,
 	data[1] = mac->crc_errors;
 }
 
-static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e5f553a1ea24..deec98c7ff5d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -12100,7 +12100,7 @@ void rt2800_get_key_seq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(rt2800_get_key_seq);
 
-int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	u32 reg;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 194de676df8f..c3c4590aaaf2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -253,7 +253,7 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev);
 void rt2800_get_key_seq(struct ieee80211_hw *hw,
 			struct ieee80211_key_conf *key,
 			struct ieee80211_key_seq *seq);
-int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 int rt2800_conf_tx(struct ieee80211_hw *hw,
 		   struct ieee80211_vif *vif,
 		   unsigned int link_id, u16 queue_idx,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 4ce0c05c5129..8e7a3014c3ec 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6981,7 +6981,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 			 FIF_PROBE_REQ);
 }
 
-static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
+static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 rts)
 {
 	if (rts > 2347 && rts != (u32)-1)
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 026fbf4ad9cc..b44e5b50664b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -706,7 +706,7 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b3669e0074df..d984794c8c29 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1038,7 +1038,7 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 3425a473b9a1..4f0f54d591dd 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1206,6 +1206,7 @@ static int rsi_mac80211_ampdu_action(struct ieee80211_hw *hw,
  * Return: 0 on success.
  */
 static int rsi_mac80211_set_rts_threshold(struct ieee80211_hw *hw,
+					  u8 radio_id,
 					  u32 value)
 {
 	struct rsi_hw *adapter = hw->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 7c04810dbf3d..2d3c2bc1064b 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -219,7 +219,7 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = NULL;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index 7817c7c6f3dd..629a579354a6 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -22,7 +22,7 @@ struct wfx_sta_priv {
 int wfx_start(struct ieee80211_hw *hw);
 void wfx_stop(struct ieee80211_hw *hw, bool suspend);
 int wfx_config(struct ieee80211_hw *hw, u32 changed);
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 void wfx_set_default_unicast_key(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int idx);
 void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 			  unsigned int *total_flags, u64 unused);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index c259da8161e4..4732e74ddbca 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -857,7 +857,7 @@ void cw1200_wep_key_work(struct work_struct *work)
 	wsm_unlock_tx(priv);
 }
 
-int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	int ret = 0;
 	__le32 val32;
diff --git a/drivers/net/wireless/st/cw1200/sta.h b/drivers/net/wireless/st/cw1200/sta.h
index b955b92cfd73..3f28bb9ec5ec 100644
--- a/drivers/net/wireless/st/cw1200/sta.h
+++ b/drivers/net/wireless/st/cw1200/sta.h
@@ -36,7 +36,7 @@ int cw1200_set_key(struct ieee80211_hw *dev, enum set_key_cmd cmd,
 		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 		   struct ieee80211_key_conf *key);
 
-int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 
 void cw1200_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop);
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index bb53d681c11b..5fcc26e7ed3b 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1051,7 +1051,7 @@ static int wl1251_op_hw_scan(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct wl1251 *wl = hw->priv;
 	int ret;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 8fb58a5d911c..ebb30b836a64 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3923,7 +3923,7 @@ static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return ret;
 }
 
-static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331d4042..0c02e7f8a2e0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3330,7 +3330,8 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	return 1;
 }
 
-static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id,
+					    u32 value)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c3ed2fcff8b7..977ec1a86e60 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4559,7 +4559,7 @@ struct ieee80211_ops {
 			    struct ieee80211_key_conf *key,
 			    struct ieee80211_key_seq *seq);
 	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
-	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
+	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ac28800fcaee..bd121815bd93 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3038,7 +3038,13 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 chan
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
-		err = drv_set_rts_threshold(local, wiphy->rts_threshold);
+		u32 rts_threshold;
+
+		if (radio_id >= wiphy->n_radio)
+			rts_threshold = wiphy->rts_threshold;
+		else
+			rts_threshold = wiphy->radio_cfg[radio_id].rts_threshold;
+		err = drv_set_rts_threshold(local, radio_id, rts_threshold);
 
 		if (err)
 			return err;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5acecc7bd4a9..a47d0b7c2fe7 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -402,16 +402,16 @@ static inline int drv_set_frag_threshold(struct ieee80211_local *local,
 }
 
 static inline int drv_set_rts_threshold(struct ieee80211_local *local,
-					u32 value)
+					u8 radio_id, u32 value)
 {
 	int ret = 0;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_set_rts_threshold(local, value);
+	trace_drv_set_rts_threshold(local, radio_id, value);
 	if (local->ops->set_rts_threshold)
-		ret = local->ops->set_rts_threshold(&local->hw, value);
+		ret = local->ops->set_rts_threshold(&local->hw, radio_id, value);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..eb7f9c766da1 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -823,9 +823,27 @@ DEFINE_EVENT(local_u32_evt, drv_set_frag_threshold,
 	TP_ARGS(local, value)
 );
 
-DEFINE_EVENT(local_u32_evt, drv_set_rts_threshold,
-	TP_PROTO(struct ieee80211_local *local, u32 value),
-	TP_ARGS(local, value)
+TRACE_EVENT(drv_set_rts_threshold,
+	TP_PROTO(struct ieee80211_local *local, u8 radio_id, u32 value),
+
+	TP_ARGS(local, radio_id, value),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(u8, radio_id)
+		__field(u32, value)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->radio_id = radio_id;
+		__entry->value = value;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " value:%d",
+		LOCAL_PR_ARG, __entry->value
+	)
 );
 
 TRACE_EVENT(drv_set_coverage_class,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f6b631faf4f7..bc8727dd3824 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1839,7 +1839,12 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio)
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			drv_set_rts_threshold(local, i, hw->wiphy->radio_cfg[i].rts_threshold);
+
+	else
+		drv_set_rts_threshold(local, NL80211_WIPHY_RADIO_ID_MAX, hw->wiphy->rts_threshold);
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, hw->wiphy->coverage_class);
-- 
2.17.1


