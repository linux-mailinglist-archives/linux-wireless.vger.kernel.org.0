Return-Path: <linux-wireless+bounces-22115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA8A9E72C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 06:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EFD18972DD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 04:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F74199943;
	Mon, 28 Apr 2025 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dABSSBIZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF919F424
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745815139; cv=none; b=N0Fc+muALNw8U6O3Ua2nbGLvJhcSjGO+5TLzs+bbPtF1pgmTJ+yQEfqeKd/mJY3yznwjFWPc83z3a5ic2j2k9fTZXDSep2aQVBWIUubIkzaITbwr3EZgsbl0gtATYWfYpII8Vvgt2KZ09tehj5XgkHjXGMA13KbpyPEpVzFKle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745815139; c=relaxed/simple;
	bh=TO2695ERxjmCwrDvy+Sp3Gb8fDm6hF+Ex2UyldlVlqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hA2Ih06OqZ2r/Dw3Cd5XBDiYQiTrvuE8c7cD7DdjlDWE1TmAs/Yay1lqRRsnw4s3haGRhoy52DqzoCjZHB5YKs3bFwKqhYaJU8ygKs6C7YhjVh3TFB6y+adPOVISU6DfB6wk3xccXpzwSM19emkCtBK3caB19QMotdPYeA5KauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dABSSBIZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S3XqRA014200;
	Mon, 28 Apr 2025 04:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	peZToCeV1+to51iVi/U3qr+t4fNHIRYXtyMa48UYyFw=; b=dABSSBIZl8QVf8MV
	OG0MsyIlLWxjRzK/rBUymMTMoSEE9/VF6WfOkDHazLV5JBHGUaUWq/pKUKlKZAAX
	gl7VoZRl3BaMZX8AgLHh0SyazteZOHFvhauIiJMtySWQ7zGcs/RpboouLrCcefr2
	C9ttZXi97tLPhXvioEz+Sw6scmM9eal+Feriv935uCJDl3pdvSZkId2xHHD+ckue
	/wmvKYjXRbbvzAIs591wWpG6Bj829dNrsk9Q1Gbe1w7y4k5TtHJkyNkJYzxPOf72
	7fVZG6sDYPaJxRW7SLgQdT4N6TmrmhC8EGQkMUDCnl/INP2uISgtQ+mLsgoA4rq9
	YrTByg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qq5dvv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 04:38:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53S4cq0e023995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 04:38:52 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 27 Apr 2025 21:38:50 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v8 3/3] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Mon, 28 Apr 2025 10:08:28 +0530
Message-ID: <20250428043828.1931147-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
References: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3AUShMlNBLTIrevS1VL7spBxMwfG6T9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDAzNyBTYWx0ZWRfXz/8aDtyL8r6+ rpgVLu9WbeugIa/fd+9m2keKyimm+gAOYxJwcMlBT8hN9LEbg4p4vEyu0HJcS2ilszWAmMi3HNX QsaSOSIcJIKlpYf/32FObiFSyHISzP2hdKbZZ8dL9RyQ3nGu83NuN/brL3izefmAh8IPeuigLXD
 dNOiZF3Jvtnudu7zXvHIwU4Z1ba3rX/vfkOzWr3uFCvUkCnvKi8OB8LMMiBEZybMCj4kFyhWVkU 81C0t3bicMdHCFS/z3EHZf5Youm44QoizQEvZcyFPASK+0VXFXel373v5Ygv4fUp9P6yCBjEWBp 6MMUQAH6VWXPwwxAyTXM1jtLvZNLikcnS3qcNG16C1Vrlz1Ee8andLyoeVpa7gg5agwDWk84IMT
 uhqbKcvQhO7+k9EIsXoQhoqzh/0jFrpctX8BDZ29nbdnBNoC8ONXLl69gDdcR68xW+O7sV10
X-Authority-Analysis: v=2.4 cv=QP1oRhLL c=1 sm=1 tr=0 ts=680f065c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=-En92J_SqdoYkblu01YA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3AUShMlNBLTIrevS1VL7spBxMwfG6T9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280037

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.

A value of NL80211_WIPHY_RADIO_ID_INVALID(-1) indicates radio index is not
mentioned and the configuration applies to all radio(s) of the wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c      |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  4 ++--
 drivers/net/wireless/ath/ath11k/mac.c         |  3 ++-
 drivers/net/wireless/ath/ath12k/mac.c         |  3 ++-
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
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 ++
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
 net/mac80211/util.c                           |  8 ++++++-
 36 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 96dc2778022a..8a873e90f4e1 100644
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
index c61b95a928da..2a16c902d1ec 100644
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
@@ -8018,7 +8018,7 @@ static int ath10k_cancel_remain_on_channel(struct ieee80211_hw *hw,
  * in ath10k, but device-specific in mac80211.
  */
 
-static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8191ee14a1fd..72e8430052db 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8182,7 +8182,8 @@ ath11k_set_vdev_param_to_all_vifs(struct ath11k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath11k driver
  */
-static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id,
+					   u32 value)
 {
 	struct ath11k *ar = hw->priv;
 	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 84da77bf245b..34c8eeb5bf88 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9644,7 +9644,8 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath12k driver
  */
-static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id,
+					   u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 19600018e562..f9cf5efdd0aa 100644
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
index 5d8f50a455d7..5a6ceb631c33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4257,7 +4257,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	return ret;
 }
 
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f6391c7a3e29..7a5939fc88e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2907,7 +2907,7 @@ iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
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
index c54005df08ca..28bcaea12f18 100644
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
index 826c48a2ee69..9898307587e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -902,7 +902,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
-static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 66f327781947..2bbd2f764c83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1262,7 +1262,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
-static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..6112b0f0a7c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1241,7 +1241,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	rcu_read_unlock();
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
index b7ea606bda08..15c35746a042 100644
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
index 569856ca677f..81639cdfe44b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6988,7 +6988,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
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
index 4fded07d0bee..34d7958fce31 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -997,7 +997,7 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 9db08200f4fa..c320b6464bda 100644
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
+					  u8 radio_id,
 					  u32 value)
 {
 	struct rsi_hw *adapter = hw->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index e95b9ded17d9..b2ca43e63917 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -220,7 +220,7 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id, u32 value)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = NULL;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index 8702eed5267f..f1288efee527 100644
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
index 444272caf124..2d26154ade3e 100644
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
index ea9bc4717a85..3a0061cbc8a7 100644
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
index 74d037cfccca..8ff02475968e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3333,7 +3333,8 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	return 1;
 }
 
-static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u8 radio_id,
+					    u32 value)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fdafc37d17cc..5f7adc8897ea 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4569,7 +4569,7 @@ struct ieee80211_ops {
 			    struct ieee80211_key_conf *key,
 			    struct ieee80211_key_seq *seq);
 	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
-	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
+	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id, u32 value);
 	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 725d90cbc17f..d84024b31541 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3054,7 +3054,13 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 chan
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
index 307587c8a003..362cb2f4b45f 100644
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
index 72fad8ea8bb9..b3797aca26bc 100644
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
+		LOCAL_PR_FMT " radio_id:%d, value:%d",
+		LOCAL_PR_ARG, __entry->radio_id, __entry->value
+	)
 );
 
 TRACE_EVENT(drv_set_coverage_class,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..da999b405809 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1829,7 +1829,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio > 0)
+		for (i = 0; i < hw->wiphy->n_radio; i++)
+			drv_set_rts_threshold(local, i,
+					      hw->wiphy->radio_cfg[i].rts_threshold);
+	else
+		drv_set_rts_threshold(local, NL80211_WIPHY_RADIO_ID_DEFAULT,
+				      hw->wiphy->rts_threshold);
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, hw->wiphy->coverage_class);
-- 
2.25.1


