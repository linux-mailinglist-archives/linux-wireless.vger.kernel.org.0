Return-Path: <linux-wireless+bounces-23269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F368AC040C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB6A9E3DF8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9964D;
	Thu, 22 May 2025 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YX0WLMvP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D001A5B99
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892051; cv=none; b=MlQxAU450G85GoljPSCNkzX6HPrBlMqFhu30Yfc4u/7u3jz6kCr9iUnYRPtpsLotpw5qm5igqCrkMtv1Itm8Z/wcFJpao9hIVwrk+PQbEkYk+7B+Gb/kNd951w2fH0rDMoxEMNsVMN8EqMY6LskbAJqln6k/ZsBRPU4g/8xFBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892051; c=relaxed/simple;
	bh=y3mSnXTIhTx1+TctNBIRcJdRx2XDFyiQ6oXlU90KTnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbCAdjBOmemup7ragedJabi5Kf+H/EwpEJ4n6seEuvQBw9oFoB4EXqfaGFuAKB1MuaG17toQdiIGaIoyx5qprBgZG2Rr1gFgPn7q+mca/cBQd0wkQXusSKQ3In8WFbHgGjPtZFyXPp/yHTVR/S/Op2C2C+QNVrFS93/EfHmbSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YX0WLMvP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LI4r7K024821;
	Thu, 22 May 2025 05:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7MuDrhD7aTSoXOeK/iuOHebqmS9f7PFEx604T/o2g+w=; b=YX0WLMvPrKF5cHsI
	FvSDfwLeXLZr4QJ0e4lB8N+ID/Zg0id/31/f4nr7Pxlo8uiQzaOqXwVsdvxlsgOo
	InCtsBVxjgVKc39EbB6kt+D+ObCyjB5UAzt/prYhZmJGDc3t21Nk/HS9nBElF0b+
	GFB6H7UmX4dmGu4BcJ4mVadK8zIenoAYjsgyb1ydYUMF7xDiJkjlpms03XbF2o+/
	o2ubup2QSbSkingy2IgIptAaWwvd87wFG9qo1NyRsU125bKOdjL0rVROKfnpaJ/D
	/keCFtpAEVS48jC07cTQ4XdCO7njR7+S7gQbwmN9jumpX4CLJwmwZxqFtrN2kbSH
	Pnr94w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4w2ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:34:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M5Y2w7008090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:34:02 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 May 2025 22:34:00 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v11 3/3] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Thu, 22 May 2025 11:03:26 +0530
Message-ID: <20250522053326.4139256-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D8rA_VhXRuzuYOhdWEsUjraZ35i9Y1hr
X-Proofpoint-ORIG-GUID: D8rA_VhXRuzuYOhdWEsUjraZ35i9Y1hr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA1MyBTYWx0ZWRfX8d5DdVX5duAX
 Rg1kQuts3hq3M6qIOglRQVKgLjr/5vqoww07IA02xYhb7ZTe6bHk3AE+hJP5DBPtVSQPrHcPXje
 rv4JSySTSpZajC59GB6exXvqk4eIeuNxxleaa16X3Qt29c7eObvAMO9emt0wlq2d801fSjT7553
 oQTNbCeqoovkLZoMs3Kv+W8kQxYhu+/eyXfhSxfk7h2C8bwJ1p3XFXtKAeexpvkvaDX27yFyfZS
 cdAR5YVHtaayWVgXA2YyplBZUw0v0tV9qPU912dvkmJrT+Fe06fQb6VQZYxQP3kdyggx27UxowK
 ELbFK/Fu3ilb27FRhWb5hpq9LQeMV8qTsdioqVdjjt4Pouo5okR2q8zddtK1ueBNs/+7dacy/g9
 Fnvit7VTtcWFvR+SZHdfWg1XEgvPotWz0irCZpNACKWzD5dYIfhfLko0bmGUhhugy8kKFKCH
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682eb74b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=W6LhtnMH47lynLIhlzIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220053

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.

A value of -1 indicates radio index is not mentioned and that the
configuration applies to all radio(s) of the wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c      |  3 ++-
 drivers/net/wireless/ath/ath10k/mac.c         |  5 ++--
 drivers/net/wireless/ath/ath11k/mac.c         |  4 +++-
 drivers/net/wireless/ath/ath12k/mac.c         |  4 +++-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 ++-
 drivers/net/wireless/ath/wcn36xx/main.c       |  3 ++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++-
 drivers/net/wireless/marvell/mwl8k.c          |  3 ++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 ++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 ++-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 ++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  3 ++-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  3 ++-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  3 ++-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  3 ++-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 ++
 drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
 drivers/net/wireless/st/cw1200/sta.c          |  2 +-
 drivers/net/wireless/st/cw1200/sta.h          |  2 +-
 drivers/net/wireless/ti/wl1251/main.c         |  3 ++-
 drivers/net/wireless/ti/wlcore/main.c         |  3 ++-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +++-
 include/net/mac80211.h                        |  3 ++-
 net/mac80211/cfg.c                            |  9 ++++++-
 net/mac80211/driver-ops.h                     |  7 +++---
 net/mac80211/trace.h                          | 24 ++++++++++++++++---
 net/mac80211/util.c                           |  7 +++++-
 37 files changed, 101 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 96dc2778022a..c767ed77effe 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1083,7 +1083,8 @@ static void ar5523_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->mutex);
 }
 
-static int ar5523_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ar5523_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 value)
 {
 	struct ar5523 *ar = hw->priv;
 	int ret;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 8c7ffea0fa44..93f788eb94f2 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "mac.h"
@@ -8018,7 +8018,8 @@ static int ath10k_cancel_remain_on_channel(struct ieee80211_hw *hw,
  * in ath10k, but device-specific in mac80211.
  */
 
-static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 value)
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8191ee14a1fd..eb8c1232843c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8182,7 +8182,9 @@ ath11k_set_vdev_param_to_all_vifs(struct ath11k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath11k driver
  */
-static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
+					   int radio_id,
+					   u32 value)
 {
 	struct ath11k *ar = hw->priv;
 	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4dae941c9615..aaf36469924a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9915,7 +9915,9 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath12k driver
  */
-static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
+					   int radio_id,
+					   u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 19600018e562..2eb8b8136ccb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1737,7 +1737,8 @@ static void ath9k_htc_sw_scan_complete(struct ieee80211_hw *hw,
 	mutex_unlock(&priv->mutex);
 }
 
-static int ath9k_htc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath9k_htc_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				       u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 94d08d6ae1a3..012e887ea87e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -965,7 +965,8 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 /* this is required when using IEEE80211_HW_HAS_RATE_CONTROL */
-static int wcn36xx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wcn36xx_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				     u32 value)
 {
 	struct wcn36xx *wcn = hw->priv;
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac set RTS threshold %d\n", value);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4ba050397632..14c1b3bad4f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1102,7 +1102,8 @@ void iwl_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 }
 
 static
-int iwl_mld_mac80211_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mld_mac80211_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				       u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f056a6641bd..3799750ec44d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4249,7 +4249,8 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	return ret;
 }
 
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				  u32 value)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a4f412e750d0..72629cada3d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2905,7 +2905,8 @@ iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
 				    int num_frames,
 				    enum ieee80211_frame_release_type reason,
 				    bool more_data);
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				  u32 value);
 void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_link_sta *link_sta, u32 changed);
 void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index bab9ef37a1ab..dadc0b1e3cfd 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5321,7 +5321,8 @@ static void mwl8k_configure_filter(struct ieee80211_hw *hw,
 	mwl8k_fw_unlock(hw);
 }
 
-static int mwl8k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mwl8k_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				   u32 value)
 {
 	return mwl8k_cmd_set_rts_threshold(hw, value);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c54005df08ca..562fd165398d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -784,7 +784,8 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
 }
 
-static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 val)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4cd63bacd742..e1f7fb0082bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -184,7 +184,7 @@ void mt76x02_tx_set_txpwr_auto(struct mt76x02_dev *dev, s8 txpwr);
 void mt76x02_set_tx_ackto(struct mt76x02_dev *dev);
 void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 				s16 coverage_class);
-int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val);
+int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 val);
 void mt76x02_remove_hdr_pad(struct sk_buff *skb, int len);
 bool mt76x02_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 4fb30589fa7a..d659607f5142 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -559,7 +559,7 @@ void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(mt76x02_set_coverage_class);
 
-int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 val)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6..14c4efcb25aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -906,7 +906,8 @@ static void mt7915_tx(struct ieee80211_hw *hw,
 	mt76_tx(mphy, control->sta, wcid, skb);
 }
 
-static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 val)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 826c48a2ee69..a78703dd2bed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -902,7 +902,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
-static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 66f327781947..1f07619702e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1262,7 +1262,8 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
-static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..166a7edb7a47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1241,7 +1241,8 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	rcu_read_unlock();
 }
 
-static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 val)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	int i, ret;
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 7570c6ceecea..15e68666dacb 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -334,7 +334,8 @@ mt7601u_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return mt76_mac_wcid_set_key(dev, msta->wcid.idx, key);
 }
 
-static int mt7601u_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mt7601u_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				     u32 value)
 {
 	struct mt7601u_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 82d1bf7edba2..8bbd09498014 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -677,7 +677,8 @@ static void plfxlc_get_et_stats(struct ieee80211_hw *hw,
 	data[1] = mac->crc_errors;
 }
 
-static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				    u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b7ea606bda08..c3183230b682 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -12100,7 +12100,7 @@ void rt2800_get_key_seq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(rt2800_get_key_seq);
 
-int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int rt2800_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 value)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	u32 reg;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 194de676df8f..5797ba0ee92d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -253,7 +253,7 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev);
 void rt2800_get_key_seq(struct ieee80211_hw *hw,
 			struct ieee80211_key_conf *key,
 			struct ieee80211_key_seq *seq);
-int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int rt2800_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 value);
 int rt2800_conf_tx(struct ieee80211_hw *hw,
 		   struct ieee80211_vif *vif,
 		   unsigned int link_id, u16 queue_idx,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..59a9d7ea10bf 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6988,7 +6988,8 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 			 FIF_PROBE_REQ);
 }
 
-static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
+static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				      u32 rts)
 {
 	if (rts > 2347 && rts != (u32)-1)
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 77f9fbe1870c..d57eb65eb827 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -708,7 +708,8 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				     u32 value)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a47971003bd4..a0d315d521e8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1007,7 +1007,8 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				       u32 value)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 9db08200f4fa..77109b539811 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1201,11 +1201,13 @@ static int rsi_mac80211_ampdu_action(struct ieee80211_hw *hw,
 /**
  * rsi_mac80211_set_rts_threshold() - This function sets rts threshold value.
  * @hw: Pointer to the ieee80211_hw structure.
+ * @radio_id: Index of the radio whose RTS threshold needs to be changed.
  * @value: Rts threshold value.
  *
  * Return: 0 on success.
  */
 static int rsi_mac80211_set_rts_threshold(struct ieee80211_hw *hw,
+					  int radio_id,
 					  u32 value)
 {
 	struct rsi_hw *adapter = hw->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index e95b9ded17d9..ae86129fde21 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -220,7 +220,7 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 value)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = NULL;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index 8702eed5267f..fdab70720213 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -22,7 +22,7 @@ struct wfx_sta_priv {
 int wfx_start(struct ieee80211_hw *hw);
 void wfx_stop(struct ieee80211_hw *hw, bool suspend);
 int wfx_config(struct ieee80211_hw *hw, u32 changed);
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 value);
 void wfx_set_default_unicast_key(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int idx);
 void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 			  unsigned int *total_flags, u64 unused);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 444272caf124..98a10ffc6d77 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -857,7 +857,7 @@ void cw1200_wep_key_work(struct work_struct *work)
 	wsm_unlock_tx(priv);
 }
 
-int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int cw1200_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 value)
 {
 	int ret = 0;
 	__le32 val32;
diff --git a/drivers/net/wireless/st/cw1200/sta.h b/drivers/net/wireless/st/cw1200/sta.h
index b955b92cfd73..c1a6bf77e1df 100644
--- a/drivers/net/wireless/st/cw1200/sta.h
+++ b/drivers/net/wireless/st/cw1200/sta.h
@@ -36,7 +36,7 @@ int cw1200_set_key(struct ieee80211_hw *dev, enum set_key_cmd cmd,
 		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 		   struct ieee80211_key_conf *key);
 
-int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int cw1200_set_rts_threshold(struct ieee80211_hw *hw, int radio_id, u32 value);
 
 void cw1200_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop);
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index bb53d681c11b..ae1de2c1078d 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1051,7 +1051,8 @@ static int wl1251_op_hw_scan(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				       u32 value)
 {
 	struct wl1251 *wl = hw->priv;
 	int ret;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ea9bc4717a85..a716508a7bff 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3923,7 +3923,8 @@ static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return ret;
 }
 
-static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, int radio_id,
+				       u32 value)
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f6add19d1da1..354cb6fdb798 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3338,7 +3338,9 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	return 1;
 }
 
-static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw,
+					    int radio_id,
+					    u32 value)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 82617579d910..553bcfebe8cc 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4572,7 +4572,8 @@ struct ieee80211_ops {
 			    struct ieee80211_key_conf *key,
 			    struct ieee80211_key_seq *seq);
 	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
-	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
+	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_id,
+				 u32 value);
 	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 459b4861af02..3c0d04fffc09 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3058,7 +3058,14 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_id,
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
-		err = drv_set_rts_threshold(local, wiphy->rts_threshold);
+		u32 rts_threshold;
+
+		if (radio_id >= wiphy->n_radio)
+			rts_threshold = wiphy->rts_threshold;
+		else
+			rts_threshold =
+				wiphy->radio_cfg[radio_id].rts_threshold;
+		err = drv_set_rts_threshold(local, radio_id, rts_threshold);
 
 		if (err)
 			return err;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a003..9710b4b26207 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -402,16 +402,17 @@ static inline int drv_set_frag_threshold(struct ieee80211_local *local,
 }
 
 static inline int drv_set_rts_threshold(struct ieee80211_local *local,
-					u32 value)
+					int radio_id, u32 value)
 {
 	int ret = 0;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_set_rts_threshold(local, value);
+	trace_drv_set_rts_threshold(local, radio_id, value);
 	if (local->ops->set_rts_threshold)
-		ret = local->ops->set_rts_threshold(&local->hw, value);
+		ret = local->ops->set_rts_threshold(&local->hw, radio_id,
+						    value);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..12011ed6b13c 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -823,9 +823,27 @@ DEFINE_EVENT(local_u32_evt, drv_set_frag_threshold,
 	TP_ARGS(local, value)
 );
 
-DEFINE_EVENT(local_u32_evt, drv_set_rts_threshold,
-	TP_PROTO(struct ieee80211_local *local, u32 value),
-	TP_ARGS(local, value)
+TRACE_EVENT(drv_set_rts_threshold,
+	TP_PROTO(struct ieee80211_local *local, int radio_id, u32 value),
+
+	TP_ARGS(local, radio_id, value),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(int, radio_id)
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
+		LOCAL_PR_FMT " radio_id:%d, value:%d",
+		LOCAL_PR_ARG, __entry->radio_id, __entry->value
+	)
 );
 
 TRACE_EVENT(drv_set_coverage_class,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..1063d4a1365b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1829,7 +1829,12 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio > 0)
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			drv_set_rts_threshold(local, i,
+					      hw->wiphy->radio_cfg[i].rts_threshold);
+	else
+		drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, hw->wiphy->coverage_class);
-- 
2.25.1


