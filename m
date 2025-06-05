Return-Path: <linux-wireless+bounces-23743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D179EACECD8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422D23AB89F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737B21018A;
	Thu,  5 Jun 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AlKDHJ0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBA20DD52
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115884; cv=none; b=I/nHs0IuXdnw5HE/yVhfStlynKnP9xyrZBmUiYm3brxr7Oh3miiIavSu8XqqBXSGwT+BiMqvdfMyfN8b9iH3swZJSfmX8rRyyFuvxd7oPSo7R1qMW9LQbI6vY8lBpzFNvMlhkxHsj4v1dGTUX6RUyt06n6OOJdkVX3aU5WMsKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115884; c=relaxed/simple;
	bh=KSXzsw+ZxZ6rypNdgrZ5ahx5Uq8ePphXMpKZ35QwduQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1vPYOS9i3wZPRlI8DoJ9lWRxxOgX+CNFgDf9FSkFVswxA90Jf/Th3UkQHsb1n8RrrnRbMnOFMeDvqjQiedu6EN6lRpAlSmI65QPETokIFb6Fh8I7kBxLVnMqUR55EdVAbsZu1vvVB2wAtt5htS/38qiIWiYGVx9rt3wKYqofMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AlKDHJ0U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554LJd9b022442;
	Thu, 5 Jun 2025 09:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YyUQ3DiLNh/OoQw5f3cBxUhq4O6EevocT952Q/OHRk=; b=AlKDHJ0UhOOxttU3
	qpu1NPEWtPHZ+xQharIVK7tlEmMuL52k80opbKSc7rxd4JX/BAGXQdEMB63rK+9z
	zeVb2QhjwHlwWAeKefqy07OcBTpVAAfevOXWtqiXR3Fr6tzYuik9dVDMI+HulXk8
	9YxGBTn4nTEZBMks8WqLvJRB4/TsEC2mKI9gyImlokBoMv32nusHXrE7dEVQS4rd
	yipW9F6E7XtAr8K55g0WkoXcX4oVk/mxLXbyPbUTlbUYj8fDNPK0L+CRPnsG8PZM
	SI1hxRZoGHQyGewR4WGM0Dq57+onHLUxTwSDofuMo2+x/XJcEf8qwjwdENzojhFu
	419NIA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn033dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:31:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5559VCaR015079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 09:31:12 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 02:31:09 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v13 1/4] wifi: cfg80211/mac80211: Add support to get radio index
Date: Thu, 5 Jun 2025 15:00:49 +0530
Message-ID: <20250605093052.3351173-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605093052.3351173-1-quic_rdevanat@quicinc.com>
References: <20250605093052.3351173-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JggLvxGHzTS3xPgRP8fuM_6gcK7Zdg7h
X-Proofpoint-GUID: JggLvxGHzTS3xPgRP8fuM_6gcK7Zdg7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4MyBTYWx0ZWRfX6NXHkYB9DJ9q
 7D4tF9QKp478iON8ri1YjShposKycJv6QGqtAJe2ve8qzDzXCNq9FADkqUH9w+x0WE0K/42TxAi
 7+/93xcnTGAsrrRtp5edbjcKJoCO7SLTtubk7MKRnQwRg/JvNgivn9OAviglbMvDe6jYHFUB0Lo
 EQ4T1YAzLsXsleqm6pIx66my/ei3Ahiwx1T9hiuWG9L2h+Y4uPZrhgbZTnSbDGIFX3Lsp8kag0D
 vZmxtj+1I677sJP15FHxdEseON6lshymSj+8Stx31u/afucjkpU2wF1zKHtt9bxprbliOCqAOey
 Xty06JV+PlsGHwXDsa2xOxyVhoFBbZGCxQxlUe2XuvYXfPjNs2oHEhzOC3+uw8HWlHOnTh/B7oc
 3BVQwUFZNHqHvjta8AL0oSYNt5JTFdKsfW2T0+hVY9et5UnSnnaQbcgReqtfJU6ub7tQE8ry
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=684163e1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=qFQhFV4teq4ajHH9PNEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050083

Currently, per-radio attributes are set on per-phy basis, i.e., all the
radios present in a wiphy will take attributes values sent from user. But
each radio in a wiphy can get different values from userspace based on
its requirement.

To extend support to set per-radio attributes, add support to get radio
index from userspace. Add an NL attribute - NL80211_ATTR_WIPHY_RADIO_INDEX,
to get user specified radio index for which attributes should be changed.
Pass this to individual drivers, so that the drivers can use this radio
index to change per-radio attributes when necessary. Currently, per-radio
attributes identified are:
NL80211_ATTR_WIPHY_TX_POWER_LEVEL
NL80211_ATTR_WIPHY_ANTENNA_TX
NL80211_ATTR_WIPHY_ANTENNA_RX
NL80211_ATTR_WIPHY_RETRY_SHORT
NL80211_ATTR_WIPHY_RETRY_LONG
NL80211_ATTR_WIPHY_FRAG_THRESHOLD
NL80211_ATTR_WIPHY_RTS_THRESHOLD
NL80211_ATTR_WIPHY_COVERAGE_CLASS
NL80211_ATTR_TXQ_LIMIT
NL80211_ATTR_TXQ_MEMORY_LIMIT
NL80211_ATTR_TXQ_QUANTUM

By default, the radio index is set to -1. This means the attribute should
be treated as a global configuration. If the user has not specified any
index, then the radio index passed to individual drivers would be -1. This
would indicate that the attribute applies to all radios in that wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/admtek/adm8211.c         |  2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c      |  5 +-
 drivers/net/wireless/ath/ath10k/core.c        |  2 +-
 drivers/net/wireless/ath/ath10k/hw.c          |  1 +
 drivers/net/wireless/ath/ath10k/hw.h          |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         | 19 +++--
 drivers/net/wireless/ath/ath11k/mac.c         | 14 ++--
 drivers/net/wireless/ath/ath12k/mac.c         | 14 ++--
 drivers/net/wireless/ath/ath5k/mac80211-ops.c | 12 ++-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  7 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 10 ++-
 drivers/net/wireless/ath/ath9k/main.c         |  9 +-
 drivers/net/wireless/ath/carl9170/main.c      |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  5 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 drivers/net/wireless/atmel/at76c50x-usb.c     |  2 +-
 drivers/net/wireless/broadcom/b43/main.c      |  6 +-
 .../net/wireless/broadcom/b43legacy/main.c    |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  8 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  3 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |  2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 12 ++-
 drivers/net/wireless/intersil/p54/main.c      |  3 +-
 .../net/wireless/marvell/libertas_tf/main.c   |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 11 ++-
 drivers/net/wireless/marvell/mwl8k.c          | 12 +--
 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 11 ++-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  6 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 13 +--
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  8 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  3 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 11 ++-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  5 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  7 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  5 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  8 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  3 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  8 +-
 .../net/wireless/ralink/rt2x00/rt2x00mac.c    |  8 +-
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |  2 +-
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  8 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  9 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 10 ++-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  9 +-
 drivers/net/wireless/silabs/wfx/sta.c         |  4 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  4 +-
 drivers/net/wireless/st/cw1200/sta.c          |  5 +-
 drivers/net/wireless/st/cw1200/sta.h          |  5 +-
 drivers/net/wireless/ti/wl1251/main.c         |  5 +-
 drivers/net/wireless/ti/wlcore/main.c         |  8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  6 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c  |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 +-
 include/net/cfg80211.h                        | 12 ++-
 include/net/mac80211.h                        | 17 ++--
 include/uapi/linux/nl80211.h                  | 10 +++
 net/mac80211/cfg.c                            | 30 ++++---
 net/mac80211/chan.c                           |  2 +-
 net/mac80211/driver-ops.h                     | 36 ++++----
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/iface.c                          |  6 +-
 net/mac80211/main.c                           |  9 +-
 net/mac80211/mlme.c                           | 12 +--
 net/mac80211/offchannel.c                     |  2 +-
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/trace.h                          | 78 ++++++++++++++----
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 16 ++--
 net/wireless/nl80211.c                        | 26 ++++--
 net/wireless/rdev-ops.h                       | 39 +++++----
 net/wireless/trace.h                          | 82 +++++++++++++++----
 net/wireless/wext-compat.c                    | 10 +--
 93 files changed, 530 insertions(+), 284 deletions(-)

diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index a2d87c3ad196..e94a6b180314 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -1293,7 +1293,7 @@ static void adm8211_set_bssid(struct ieee80211_hw *dev, const u8 *bssid)
 	ADM8211_CSR_WRITE(ABDA1, reg);
 }
 
-static int adm8211_config(struct ieee80211_hw *dev, u32 changed)
+static int adm8211_config(struct ieee80211_hw *dev, int radio_idx, u32 changed)
 {
 	struct adm8211_priv *priv = dev->priv;
 	struct ieee80211_conf *conf = &dev->conf;
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 96dc2778022a..d931753c5899 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1083,7 +1083,8 @@ static void ar5523_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->mutex);
 }
 
-static int ar5523_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ar5523_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 value)
 {
 	struct ar5523 *ar = hw->priv;
 	int ret;
@@ -1137,7 +1138,7 @@ static void ar5523_remove_interface(struct ieee80211_hw *hw,
 	ar->vif = NULL;
 }
 
-static int ar5523_hwconfig(struct ieee80211_hw *hw, u32 changed)
+static int ar5523_hwconfig(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ar5523 *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index fe3a8f4a1cc1..52163c2bfe7a 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2606,7 +2606,7 @@ static void ath10k_core_set_coverage_class_work(struct work_struct *work)
 					 set_coverage_class_work);
 
 	if (ar->hw_params.hw_ops->set_coverage_class)
-		ar->hw_params.hw_ops->set_coverage_class(ar, -1);
+		ar->hw_params.hw_ops->set_coverage_class(ar, -1, -1);
 }
 
 static int ath10k_core_init_firmware_features(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index 84b35a22fc23..59b6cebfdd8f 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -590,6 +590,7 @@ void ath10k_hw_fill_survey_time(struct ath10k *ar, struct survey_info *survey,
  * function monitors and modifies the corresponding MAC registers.
  */
 static void ath10k_hw_qca988x_set_coverage_class(struct ath10k *ar,
+						 int radio_idx,
 						 s16 value)
 {
 	u32 slottime_reg;
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 7ffa1fbe2874..fec56b916497 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -646,7 +646,7 @@ struct htt_rx_ring_rx_desc_offsets;
 
 /* Defines needed for Rx descriptor abstraction */
 struct ath10k_hw_ops {
-	void (*set_coverage_class)(struct ath10k *ar, s16 value);
+	void (*set_coverage_class)(struct ath10k *ar, int radio_idx, s16 value);
 	int (*enable_pll_clk)(struct ath10k *ar);
 	int (*tx_data_rssi_pad_bytes)(struct htt_resp *htt);
 	int (*is_rssi_enable)(struct htt_resp *resp);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 8c7ffea0fa44..37d9d3619e32 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4799,7 +4799,8 @@ void ath10k_halt(struct ath10k *ar)
 	spin_unlock_bh(&ar->data_lock);
 }
 
-static int ath10k_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+static int ath10k_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath10k *ar = hw->priv;
 
@@ -5046,7 +5047,8 @@ static int __ath10k_set_antenna(struct ath10k *ar, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
-static int ath10k_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+static int ath10k_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 tx_ant, u32 rx_ant)
 {
 	struct ath10k *ar = hw->priv;
 	int ret;
@@ -5416,7 +5418,7 @@ static int ath10k_config_ps(struct ath10k *ar)
 	return ret;
 }
 
-static int ath10k_config(struct ieee80211_hw *hw, u32 changed)
+static int ath10k_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ath10k *ar = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
@@ -6319,7 +6321,8 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
-static void ath10k_mac_op_set_coverage_class(struct ieee80211_hw *hw, s16 value)
+static void ath10k_mac_op_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+					     s16 value)
 {
 	struct ath10k *ar = hw->priv;
 
@@ -6330,7 +6333,7 @@ static void ath10k_mac_op_set_coverage_class(struct ieee80211_hw *hw, s16 value)
 		WARN_ON_ONCE(1);
 		return;
 	}
-	ar->hw_params.hw_ops->set_coverage_class(ar, value);
+	ar->hw_params.hw_ops->set_coverage_class(ar, -1, value);
 }
 
 struct ath10k_mac_tdls_iter_data {
@@ -8018,7 +8021,8 @@ static int ath10k_cancel_remain_on_channel(struct ieee80211_hw *hw,
  * in ath10k, but device-specific in mac80211.
  */
 
-static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 value)
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif;
@@ -8041,7 +8045,8 @@ static int ath10k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	return ret;
 }
 
-static int ath10k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath10k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
+					    int radio_idx, u32 value)
 {
 	/* Even though there's a WMI enum for fragmentation threshold no known
 	 * firmware actually implements it. Moreover it is not possible to rely
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 08d7b136851f..544e50387575 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1283,7 +1283,7 @@ static int ath11k_mac_config_ps(struct ath11k *ar)
 	return ret;
 }
 
-static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
+static int ath11k_mac_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ath11k *ar = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
@@ -7044,7 +7044,8 @@ static void ath11k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
-static int ath11k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+static int ath11k_mac_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+				     u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath11k *ar = hw->priv;
 
@@ -7058,7 +7059,8 @@ static int ath11k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 	return 0;
 }
 
-static int ath11k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+static int ath11k_mac_op_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+				     u32 tx_ant, u32 rx_ant)
 {
 	struct ath11k *ar = hw->priv;
 	int ret;
@@ -8182,7 +8184,8 @@ ath11k_set_vdev_param_to_all_vifs(struct ath11k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath11k driver
  */
-static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
+					   int radio_idx, u32 value)
 {
 	struct ath11k *ar = hw->priv;
 	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
@@ -8190,7 +8193,8 @@ static int ath11k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	return ath11k_set_vdev_param_to_all_vifs(ar, param_id, value);
 }
 
-static int ath11k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath11k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
+					    int radio_idx, u32 value)
 {
 	/* Even though there's a WMI vdev param for fragmentation threshold no
 	 * known firmware actually implements it. Moreover it is not possible to
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..77f2b66b3a04 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1392,7 +1392,7 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 	return ret;
 }
 
-static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
+static int ath12k_mac_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	return 0;
 }
@@ -9008,7 +9008,8 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	ar->filter_flags = *total_flags;
 }
 
-static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+				     u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	int antennas_rx = 0, antennas_tx = 0;
@@ -9028,7 +9029,8 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 	return 0;
 }
 
-static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+				     u32 tx_ant, u32 rx_ant)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -10389,7 +10391,8 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 /* mac80211 stores device specific RTS/Fragmentation threshold value,
  * this is set interface specific to firmware from ath12k driver
  */
-static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw,
+					   int radio_idx, u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
@@ -10414,7 +10417,8 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	return ret;
 }
 
-static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw,
+					    int radio_idx, u32 value)
 {
 	/* Even though there's a WMI vdev param for fragmentation threshold no
 	 * known firmware actually implements it. Moreover it is not possible to
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index d81b2ad0b095..eca8145d3874 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -192,7 +192,7 @@ ath5k_remove_interface(struct ieee80211_hw *hw,
  * TODO: Phy disable/diversity etc
  */
 static int
-ath5k_config(struct ieee80211_hw *hw, u32 changed)
+ath5k_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ath5k_hw *ah = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
@@ -686,6 +686,7 @@ ath5k_get_survey(struct ieee80211_hw *hw, int idx, struct survey_info *survey)
  * ath5k_set_coverage_class - Set IEEE 802.11 coverage class
  *
  * @hw: struct ieee80211_hw pointer
+ * @radio_idx: Radio index
  * @coverage_class: IEEE 802.11 coverage class number
  *
  * Mac80211 callback. Sets slot time, ACK timeout and CTS timeout for given
@@ -693,7 +694,8 @@ ath5k_get_survey(struct ieee80211_hw *hw, int idx, struct survey_info *survey)
  * reset.
  */
 static void
-ath5k_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+ath5k_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			 s16 coverage_class)
 {
 	struct ath5k_hw *ah = hw->priv;
 
@@ -704,7 +706,8 @@ ath5k_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 
 
 static int
-ath5k_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+ath5k_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant,
+		  u32 rx_ant)
 {
 	struct ath5k_hw *ah = hw->priv;
 
@@ -721,7 +724,8 @@ ath5k_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 
 static int
-ath5k_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+ath5k_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+		  u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath5k_hw *ah = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 8c2e8081112e..88f0197fc041 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1376,7 +1376,8 @@ void ath6kl_cfg80211_tkip_micerr_event(struct ath6kl_vif *vif, u8 keyid,
 				     GFP_KERNEL);
 }
 
-static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+					    u32 changed)
 {
 	struct ath6kl *ar = (struct ath6kl *)wiphy_priv(wiphy);
 	struct ath6kl_vif *vif;
@@ -1405,6 +1406,7 @@ static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 
 static int ath6kl_cfg80211_set_txpower(struct wiphy *wiphy,
 				       struct wireless_dev *wdev,
+				       int radio_idx,
 				       enum nl80211_tx_power_setting type,
 				       int mbm)
 {
@@ -1441,6 +1443,7 @@ static int ath6kl_cfg80211_set_txpower(struct wiphy *wiphy,
 
 static int ath6kl_cfg80211_get_txpower(struct wiphy *wiphy,
 				       struct wireless_dev *wdev,
+				       int radio_idx,
 				       unsigned int link_id,
 				       int *dbm)
 {
@@ -3242,7 +3245,7 @@ static int ath6kl_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 					wait, buf, len, no_cck);
 }
 
-static int ath6kl_get_antenna(struct wiphy *wiphy,
+static int ath6kl_get_antenna(struct wiphy *wiphy, int radio_idx,
 			      u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath6kl *ar = wiphy_priv(wiphy);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 19600018e562..0d6272ac0dac 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1172,7 +1172,7 @@ static void ath9k_htc_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&priv->mutex);
 }
 
-static int ath9k_htc_config(struct ieee80211_hw *hw, u32 changed)
+static int ath9k_htc_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ath9k_htc_priv *priv = hw->priv;
 	struct ath_common *common = ath9k_hw_common(priv->ah);
@@ -1737,12 +1737,14 @@ static void ath9k_htc_sw_scan_complete(struct ieee80211_hw *hw,
 	mutex_unlock(&priv->mutex);
 }
 
-static int ath9k_htc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int ath9k_htc_set_rts_threshold(struct ieee80211_hw *hw,
+				       int radio_idx, u32 value)
 {
 	return 0;
 }
 
 static void ath9k_htc_set_coverage_class(struct ieee80211_hw *hw,
+					 int radio_idx,
 					 s16 coverage_class)
 {
 	struct ath9k_htc_priv *priv = hw->priv;
@@ -1841,8 +1843,8 @@ struct base_eep_header *ath9k_htc_get_eeprom_base(struct ath9k_htc_priv *priv)
 }
 
 
-static int ath9k_htc_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant,
-				 u32 *rx_ant)
+static int ath9k_htc_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+				 u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath9k_htc_priv *priv = hw->priv;
 	struct base_eep_header *pBase = ath9k_htc_get_eeprom_base(priv);
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 92fc5e3d756e..807d1a1229c6 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1484,7 +1484,7 @@ static void ath9k_disable_ps(struct ath_softc *sc)
 	ath_dbg(common, PS, "PowerSave disabled\n");
 }
 
-static int ath9k_config(struct ieee80211_hw *hw, u32 changed)
+static int ath9k_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_hw *ah = sc->sc_ah;
@@ -2114,6 +2114,7 @@ static void ath9k_enable_dynack(struct ath_softc *sc)
 }
 
 static void ath9k_set_coverage_class(struct ieee80211_hw *hw,
+				     int radio_idx,
 				     s16 coverage_class)
 {
 	struct ath_softc *sc = hw->priv;
@@ -2338,7 +2339,8 @@ static bool validate_antenna_mask(struct ath_hw *ah, u32 val)
 	}
 }
 
-static int ath9k_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+static int ath9k_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			     u32 tx_ant, u32 rx_ant)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_hw *ah = sc->sc_ah;
@@ -2367,7 +2369,8 @@ static int ath9k_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
-static int ath9k_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+static int ath9k_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			     u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath_softc *sc = hw->priv;
 
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 755c068e4197..a7a9345f3483 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -890,7 +890,7 @@ static void carl9170_stat_work(struct work_struct *work)
 		round_jiffies(msecs_to_jiffies(CARL9170_STAT_WORK)));
 }
 
-static int carl9170_op_config(struct ieee80211_hw *hw, u32 changed)
+static int carl9170_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ar9170 *ar = hw->priv;
 	int err = 0;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 94d08d6ae1a3..02a525645bfa 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -361,7 +361,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 	return;
 }
 
-static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
+static int wcn36xx_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct wcn36xx *wcn = hw->priv;
 	int ret;
@@ -965,7 +965,8 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 }
 
 /* this is required when using IEEE80211_HW_HAS_RATE_CONTROL */
-static int wcn36xx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wcn36xx_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				     u32 value)
 {
 	struct wcn36xx *wcn = hw->priv;
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac set RTS threshold %d\n", value);
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5473c01cbe66..7703a0933a14 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1408,7 +1408,8 @@ static int wil_cfg80211_disconnect(struct wiphy *wiphy,
 	return rc;
 }
 
-static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int wil_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+					 u32 changed)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	int rc;
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 6842c2b02b39..aa683eacaf38 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2002,7 +2002,7 @@ static int at76_hw_scan(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int at76_config(struct ieee80211_hw *hw, u32 changed)
+static int at76_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct at76_priv *priv = hw->priv;
 
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 7529afd24aed..f1a77c4c445f 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3975,7 +3975,7 @@ static void b43_set_retry_limits(struct b43_wldev *dev,
 			long_retry);
 }
 
-static int b43_op_config(struct ieee80211_hw *hw, u32 changed)
+static int b43_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
 	struct b43_wldev *dev = wl->current_dev;
@@ -5073,7 +5073,7 @@ static int b43_op_start(struct ieee80211_hw *hw)
 	 * may hang the system.
 	 */
 	if (!err)
-		b43_op_config(hw, ~0);
+		b43_op_config(hw, -1, ~0);
 
 	return err;
 }
@@ -5248,7 +5248,7 @@ static void b43_chip_reset(struct work_struct *work)
 	}
 
 	/* reload configuration */
-	b43_op_config(wl->hw, ~0);
+	b43_op_config(wl->hw, -1, ~0);
 	if (wl->vif)
 		b43_op_bss_info_changed(wl->hw, wl->vif, &wl->vif->bss_conf, ~0);
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 2370a2e6a2e3..aada342e0b80 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -2662,7 +2662,7 @@ static void b43legacy_set_retry_limits(struct b43legacy_wldev *dev,
 	b43legacy_shm_write16(dev, B43legacy_SHM_WIRELESS, 0x0007, long_retry);
 }
 
-static int b43legacy_op_dev_config(struct ieee80211_hw *hw,
+static int b43legacy_op_dev_config(struct ieee80211_hw *hw, int radio_idx,
 				   u32 changed)
 {
 	struct b43legacy_wl *wl = hw_to_b43legacy_wl(hw);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dc2383faddd1..7df3563b9a46 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1622,7 +1622,8 @@ static s32 brcmf_set_retry(struct net_device *ndev, u32 retry, bool l)
 	return err;
 }
 
-static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static s32 brcmf_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+					   u32 changed)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = cfg_to_ndev(cfg);
@@ -2630,7 +2631,8 @@ brcmf_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 
 static s32
 brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			    enum nl80211_tx_power_setting type, s32 mbm)
+			    int radio_idx, enum nl80211_tx_power_setting type,
+			    s32 mbm)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = cfg_to_ndev(cfg);
@@ -2681,7 +2683,7 @@ brcmf_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 static s32
 brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			    unsigned int link_id, s32 *dbm)
+			    int radio_idx, unsigned int link_id, s32 *dbm)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_cfg80211_vif *vif = wdev_to_vif(wdev);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 1c3d29dca424..8ab452cf48c4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -525,7 +525,8 @@ brcms_ops_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	spin_unlock_bh(&wl->lock);
 }
 
-static int brcms_ops_config(struct ieee80211_hw *hw, u32 changed)
+static int brcms_ops_config(struct ieee80211_hw *hw, int radio_idx,
+			    u32 changed)
 {
 	struct ieee80211_conf *conf = &hw->conf;
 	struct brcms_info *wl = hw->priv;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 09fb4b758704..045b616c8f65 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4990,7 +4990,7 @@ il_update_qos(struct il_priv *il)
  * il_mac_config - mac80211 config callback
  */
 int
-il_mac_config(struct ieee80211_hw *hw, u32 changed)
+il_mac_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct il_priv *il = hw->priv;
 	const struct il_channel_info *ch_info;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 52610f5e57a3..4c9836ab11dd 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -1956,7 +1956,7 @@ il_get_hw_mode(struct il_priv *il, enum nl80211_band band)
 }
 
 /* mac80211 handlers */
-int il_mac_config(struct ieee80211_hw *hw, u32 changed);
+int il_mac_config(struct ieee80211_hw *hw, int radio_idx, u32 changed);
 void il_mac_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf, u64 changes);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index 1ebc7effcc2a..b39bf401567f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -88,7 +88,7 @@ void iwl_connection_init_rx_config(struct iwl_priv *priv,
 int iwlagn_set_pan_params(struct iwl_priv *priv);
 int iwlagn_commit_rxon(struct iwl_priv *priv, struct iwl_rxon_context *ctx);
 void iwlagn_set_rxon_chain(struct iwl_priv *priv, struct iwl_rxon_context *ctx);
-int iwlagn_mac_config(struct ieee80211_hw *hw, u32 changed);
+int iwlagn_mac_config(struct ieee80211_hw *hw, int radio_idx, u32 changed);
 void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *bss_conf,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 2d3c1627f283..e08e44cae434 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1149,7 +1149,7 @@ void iwlagn_config_ht40(struct ieee80211_conf *conf,
 	}
 }
 
-int iwlagn_mac_config(struct ieee80211_hw *hw, u32 changed)
+int iwlagn_mac_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
 	struct iwl_rxon_context *ctx;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4ba050397632..76e7e3fa2d13 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -574,7 +574,8 @@ void iwl_mld_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 }
 
 static
-int iwl_mld_mac80211_config(struct ieee80211_hw *hw, u32 changed)
+int iwl_mld_mac80211_config(struct ieee80211_hw *hw, int radio_idx,
+			    u32 changed)
 {
 	return 0;
 }
@@ -1102,7 +1103,8 @@ void iwl_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 }
 
 static
-int iwl_mld_mac80211_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mld_mac80211_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				       u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f056a6641bd..cb153a133c9e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -298,7 +298,8 @@ static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 	},
 };
 
-int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			   u32 *tx_ant, u32 *rx_ant)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	*tx_ant = iwl_mvm_get_valid_tx_ant(mvm);
@@ -306,7 +307,8 @@ int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
-int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant,
+			   u32 rx_ant)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -4249,7 +4251,8 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	return ret;
 }
 
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				  u32 value)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a4f412e750d0..5c8eaf1eacff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2866,13 +2866,16 @@ void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
 int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_ampdu_params *params);
-int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
-int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
+int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, int radio_idx, u32 *tx_ant,
+			   u32 *rx_ant);
+int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant,
+			   u32 rx_ant);
 int iwl_mvm_mac_start(struct ieee80211_hw *hw);
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 				   enum ieee80211_reconfig_type reconfig_type);
 void iwl_mvm_mac_stop(struct ieee80211_hw *hw, bool suspend);
-static inline int iwl_mvm_mac_config(struct ieee80211_hw *hw, u32 changed)
+static inline int iwl_mvm_mac_config(struct ieee80211_hw *hw, int radio_idx,
+				     u32 changed)
 {
 	return 0;
 }
@@ -2905,7 +2908,8 @@ iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
 				    int num_frames,
 				    enum ieee80211_frame_release_type reason,
 				    bool more_data);
-int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				  u32 value);
 void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_link_sta *link_sta, u32 changed);
 void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 42111bb53f58..2ec3655f1a9c 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -313,7 +313,7 @@ static void p54_reset_stats(struct p54_common *priv)
 	priv->survey_raw.tx = 0;
 }
 
-static int p54_config(struct ieee80211_hw *dev, u32 changed)
+static int p54_config(struct ieee80211_hw *dev, int radio_idx, u32 changed)
 {
 	int ret = 0;
 	struct p54_common *priv = dev->priv;
@@ -692,6 +692,7 @@ static void p54_flush(struct ieee80211_hw *dev, struct ieee80211_vif *vif,
 }
 
 static void p54_set_coverage_class(struct ieee80211_hw *dev,
+				   int radio_idx,
 				   s16 coverage_class)
 {
 	struct p54_common *priv = dev->priv;
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index a57a11be57d8..8644bc1a7075 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -337,7 +337,7 @@ static void lbtf_op_remove_interface(struct ieee80211_hw *hw,
 	lbtf_deb_leave(LBTF_DEB_MACOPS);
 }
 
-static int lbtf_op_config(struct ieee80211_hw *hw, u32 changed)
+static int lbtf_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct lbtf_private *priv = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 60c12328c2f3..286378770e9e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -375,6 +375,7 @@ mwifiex_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
 static int
 mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
 			      struct wireless_dev *wdev,
+			      int radio_idx,
 			      enum nl80211_tx_power_setting type,
 			      int mbm)
 {
@@ -410,6 +411,7 @@ mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
 static int
 mwifiex_cfg80211_get_tx_power(struct wiphy *wiphy,
 			      struct wireless_dev *wdev,
+			      int radio_idx,
 			      unsigned int link_id, int *dbm)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
@@ -737,7 +739,8 @@ mwifiex_set_rts(struct mwifiex_private *priv, u32 rts_thr)
  * Fragmentation threshold of the driver.
  */
 static int
-mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+				  u32 changed)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv;
@@ -1939,7 +1942,8 @@ mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int
-mwifiex_cfg80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
+mwifiex_cfg80211_set_antenna(struct wiphy *wiphy, int radio_idx, u32 tx_ant,
+			     u32 rx_ant)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
@@ -2002,7 +2006,8 @@ mwifiex_cfg80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
 }
 
 static int
-mwifiex_cfg80211_get_antenna(struct wiphy *wiphy, u32 *tx_ant, u32 *rx_ant)
+mwifiex_cfg80211_get_antenna(struct wiphy *wiphy, int radio_idx, u32 *tx_ant,
+			     u32 *rx_ant)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index bab9ef37a1ab..bc34a025acd6 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -3369,7 +3369,8 @@ struct mwl8k_cmd_set_rts_threshold {
 } __packed;
 
 static int
-mwl8k_cmd_set_rts_threshold(struct ieee80211_hw *hw, int rts_thresh)
+mwl8k_cmd_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+			    int rts_thresh)
 {
 	struct mwl8k_cmd_set_rts_threshold *cmd;
 	int rc;
@@ -4955,7 +4956,7 @@ static void mwl8k_hw_restart_work(struct work_struct *work)
 	wiphy_err(hw->wiphy, "Firmware restart failed\n");
 }
 
-static int mwl8k_config(struct ieee80211_hw *hw, u32 changed)
+static int mwl8k_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct ieee80211_conf *conf = &hw->conf;
 	struct mwl8k_priv *priv = hw->priv;
@@ -5321,9 +5322,10 @@ static void mwl8k_configure_filter(struct ieee80211_hw *hw,
 	mwl8k_fw_unlock(hw);
 }
 
-static int mwl8k_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mwl8k_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				   u32 value)
 {
-	return mwl8k_cmd_set_rts_threshold(hw, value);
+	return mwl8k_cmd_set_rts_threshold(hw, radio_idx, value);
 }
 
 static int mwl8k_sta_remove(struct ieee80211_hw *hw,
@@ -6056,7 +6058,7 @@ static int mwl8k_reload_firmware(struct ieee80211_hw *hw, char *fw_image)
 	if (rc)
 		goto fail;
 
-	rc = mwl8k_config(hw, ~0);
+	rc = mwl8k_config(hw, -1, ~0);
 	if (rc)
 		goto fail;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 45c8db939d55..3afe4c4cd7bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1892,7 +1892,8 @@ void mt76_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL_GPL(mt76_sw_scan_complete);
 
-int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+int mt76_get_antenna(struct ieee80211_hw *hw, int radio_idx, u32 *tx_ant,
+		     u32 *rx_ant)
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5f8d81cda6cd..14927a92f9d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1513,7 +1513,8 @@ int mt76_get_sar_power(struct mt76_phy *phy,
 void mt76_csa_check(struct mt76_dev *dev);
 void mt76_csa_finish(struct mt76_dev *dev);
 
-int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+int mt76_get_antenna(struct ieee80211_hw *hw, int radio_idx, u32 *tx_ant,
+		     u32 *rx_ant);
 int mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set);
 void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
 int mt76_get_rate(struct mt76_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 3e8b1ec76169..0d7c84941cd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -216,7 +216,7 @@ static int mt7603_set_sar_specs(struct ieee80211_hw *hw,
 }
 
 static int
-mt7603_config(struct ieee80211_hw *hw, u32 changed)
+mt7603_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt7603_dev *dev = hw->priv;
 	int ret = 0;
@@ -657,7 +657,8 @@ mt7603_sta_rate_tbl_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 static void
-mt7603_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+mt7603_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			  s16 coverage_class)
 {
 	struct mt7603_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c54005df08ca..ae04cd66d9f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -420,7 +420,7 @@ static int mt7615_set_sar_specs(struct ieee80211_hw *hw,
 	return mt76_update_channel(phy->mt76);
 }
 
-static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
+static int mt7615_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -784,7 +784,8 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
 }
 
-static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 val)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -972,7 +973,8 @@ mt7615_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 static void
-mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+mt7615_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			  s16 coverage_class)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt7615_dev *dev = phy->dev;
@@ -984,7 +986,8 @@ mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 }
 
 static int
-mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+mt7615_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+		   u32 tx_ant, u32 rx_ant)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 4aa2dcedc874..a5c40d350612 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -57,7 +57,7 @@ int mt76x0_set_sar_specs(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(mt76x0_set_sar_specs);
 
-int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
+int mt76x0_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 50f755344968..e5bc14d4c712 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -48,7 +48,7 @@ void mt76x0_chip_onoff(struct mt76x02_dev *dev, bool enable, bool reset);
 
 void mt76x0_mac_stop(struct mt76x02_dev *dev);
 
-int mt76x0_config(struct ieee80211_hw *hw, u32 changed);
+int mt76x0_config(struct ieee80211_hw *hw, int radio_idx, u32 changed);
 int mt76x0_set_channel(struct mt76_phy *mphy);
 int mt76x0_set_sar_specs(struct ieee80211_hw *hw,
 			 const struct cfg80211_sar_specs *sar);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4cd63bacd742..2094c7d2af81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -183,8 +183,8 @@ void mt76x02_wdt_work(struct work_struct *work);
 void mt76x02_tx_set_txpwr_auto(struct mt76x02_dev *dev, s8 txpwr);
 void mt76x02_set_tx_ackto(struct mt76x02_dev *dev);
 void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
-				s16 coverage_class);
-int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val);
+				int radio_idx, s16 coverage_class);
+int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx, u32 val);
 void mt76x02_remove_hdr_pad(struct sk_buff *skb, int len);
 bool mt76x02_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 4fb30589fa7a..7dfcb20c692c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -548,7 +548,7 @@ void mt76x02_set_tx_ackto(struct mt76x02_dev *dev)
 EXPORT_SYMBOL_GPL(mt76x02_set_tx_ackto);
 
 void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
-				s16 coverage_class)
+				int radio_idx, s16 coverage_class)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
@@ -559,7 +559,7 @@ void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(mt76x02_set_coverage_class);
 
-int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx, u32 val)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index eb70130d2711..c5dfb06d81e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -54,7 +54,7 @@ int mt76x2e_set_channel(struct mt76_phy *phy)
 }
 
 static int
-mt76x2_config(struct ieee80211_hw *hw, u32 changed)
+mt76x2_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
@@ -99,8 +99,8 @@ mt76x2_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 }
 
-static int mt76x2_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
-			      u32 rx_ant)
+static int mt76x2_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			      u32 tx_ant, u32 rx_ant)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 83e7061b10e2..6671c53faf9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -50,7 +50,7 @@ int mt76x2u_set_channel(struct mt76_phy *mphy)
 }
 
 static int
-mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
+mt76x2u_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
 	int err = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6..fe0639c14bf9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -449,7 +449,8 @@ static int mt7915_set_sar_specs(struct ieee80211_hw *hw,
 	return err;
 }
 
-static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
+static int mt7915_config(struct ieee80211_hw *hw, int radio_idx,
+			 u32 changed)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
@@ -906,7 +907,8 @@ static void mt7915_tx(struct ieee80211_hw *hw,
 	mt76_tx(mphy, control->sta, wcid, skb);
 }
 
-static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 val)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
@@ -1102,7 +1104,8 @@ mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 static void
-mt7915_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+mt7915_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			  s16 coverage_class)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = phy->dev;
@@ -1114,7 +1117,7 @@ mt7915_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 }
 
 static int
-mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+mt7915_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant, u32 rx_ant)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
@@ -1655,7 +1658,7 @@ mt7915_twt_teardown_request(struct ieee80211_hw *hw,
 }
 
 static int
-mt7915_set_frag_threshold(struct ieee80211_hw *hw, u32 val)
+mt7915_set_frag_threshold(struct ieee80211_hw *hw, int radio_idx, u32 val)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1fffa43379b2..1678204296d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -624,7 +624,7 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 }
 
-static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
+static int mt7921_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
@@ -907,7 +907,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
-static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
@@ -1088,7 +1089,8 @@ mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static int
-mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+mt7921_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+		   u32 tx_ant, u32 rx_ant)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 94b0099dcd41..ed7cd75aa6bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -757,7 +757,7 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
 
-static int mt7925_config(struct ieee80211_hw *hw, u32 changed)
+static int mt7925_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int ret = 0;
@@ -1265,7 +1265,8 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
-static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
@@ -1507,7 +1508,8 @@ mt7925_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 }
 
 static int
-mt7925_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+mt7925_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+		   u32 tx_ant, u32 rx_ant)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index e0359d431eca..443d397d9961 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -412,7 +412,8 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta,
 			   struct station_info *sinfo);
-void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class);
+void mt792x_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			       s16 coverage_class);
 void mt792x_dma_cleanup(struct mt792x_dev *dev);
 int mt792x_dma_enable(struct mt792x_dev *dev);
 int mt792x_wpdma_reset(struct mt792x_dev *dev, bool force);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 38dd58f6e493..87f72f0a2038 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -579,7 +579,8 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(mt792x_sta_statistics);
 
-void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+void mt792x_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			       s16 coverage_class)
 {
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 78ae9f5cb176..5283aee619a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -591,7 +591,7 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return err;
 }
 
-static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
+static int mt7996_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	return 0;
 }
@@ -1251,7 +1251,8 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	rcu_read_unlock();
 }
 
-static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 val)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	int i, ret = 0;
@@ -1491,7 +1492,8 @@ mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+mt7996_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
+			  s16 coverage_class)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy;
@@ -1505,7 +1507,8 @@ mt7996_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 }
 
 static int
-mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+mt7996_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+		   u32 tx_ant, u32 rx_ant)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 7570c6ceecea..05ba43e1985c 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -78,7 +78,7 @@ static void mt7601u_remove_interface(struct ieee80211_hw *hw,
 	dev->wcid_mask[wcid / BITS_PER_LONG] &= ~BIT(wcid % BITS_PER_LONG);
 }
 
-static int mt7601u_config(struct ieee80211_hw *hw, u32 changed)
+static int mt7601u_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct mt7601u_dev *dev = hw->priv;
 	int ret = 0;
@@ -334,7 +334,8 @@ mt7601u_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return mt76_mac_wcid_set_key(dev, msta->wcid.idx, key);
 }
 
-static int mt7601u_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mt7601u_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				     u32 value)
 {
 	struct mt7601u_dev *dev = hw->priv;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..a395829ebadf 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -800,7 +800,7 @@ static int change_bss(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int set_wiphy_params(struct wiphy *wiphy, int radio_idx, u32 changed)
 {
 	int ret = -EINVAL;
 	struct cfg_param_attr cfg_param_val;
@@ -1637,7 +1637,8 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
 }
 
 static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			enum nl80211_tx_power_setting type, int mbm)
+			int radio_idx, enum nl80211_tx_power_setting type,
+			int mbm)
 {
 	int ret;
 	int srcu_idx;
@@ -1669,7 +1670,7 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			unsigned int link_id, int *dbm)
+			int radio_idx, unsigned int link_id, int *dbm)
 {
 	int ret;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 82d1bf7edba2..d375ad60167f 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -531,7 +531,7 @@ static void plfxlc_op_remove_interface(struct ieee80211_hw *hw,
 	mac->vif = NULL;
 }
 
-static int plfxlc_op_config(struct ieee80211_hw *hw, u32 changed)
+static int plfxlc_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	return 0;
 }
@@ -677,7 +677,8 @@ static void plfxlc_get_et_stats(struct ieee80211_hw *hw,
 	data[1] = mac->crc_errors;
 }
 
-static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int plfxlc_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				    u32 value)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 0b2282528342..f1188368e66b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -370,7 +370,8 @@ static int qtnf_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int qtnf_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+				 u32 changed)
 {
 	struct qtnf_wmac *mac = wiphy_priv(wiphy);
 	struct qtnf_vif *vif;
@@ -881,7 +882,7 @@ static int qtnf_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int qtnf_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			     unsigned int link_id, int *dbm)
+			     int radio_idx, unsigned int link_id, int *dbm)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
@@ -894,7 +895,8 @@ static int qtnf_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int qtnf_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			     enum nl80211_tx_power_setting type, int mbm)
+			     int radio_idx, enum nl80211_tx_power_setting type,
+			     int mbm)
 {
 	struct qtnf_vif *vif;
 	int ret;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b7ea606bda08..4b5a7c9b6499 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -12100,7 +12100,7 @@ void rt2800_get_key_seq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(rt2800_get_key_seq);
 
-int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int rt2800_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx, u32 value)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	u32 reg;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 194de676df8f..620a3d9872ce 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -253,7 +253,8 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev);
 void rt2800_get_key_seq(struct ieee80211_hw *hw,
 			struct ieee80211_key_conf *key,
 			struct ieee80211_key_seq *seq);
-int rt2800_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int rt2800_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+			     u32 value);
 int rt2800_conf_tx(struct ieee80211_hw *hw,
 		   struct ieee80211_vif *vif,
 		   unsigned int link_id, u16 queue_idx,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index dfb4bb370f01..09b9d1f9f793 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1457,7 +1457,7 @@ int rt2x00mac_add_interface(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif);
 void rt2x00mac_remove_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif);
-int rt2x00mac_config(struct ieee80211_hw *hw, u32 changed);
+int rt2x00mac_config(struct ieee80211_hw *hw, int radio_idx, u32 changed);
 void rt2x00mac_configure_filter(struct ieee80211_hw *hw,
 				unsigned int changed_flags,
 				unsigned int *total_flags,
@@ -1489,8 +1489,10 @@ int rt2x00mac_conf_tx(struct ieee80211_hw *hw,
 void rt2x00mac_rfkill_poll(struct ieee80211_hw *hw);
 void rt2x00mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     u32 queues, bool drop);
-int rt2x00mac_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
-int rt2x00mac_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+int rt2x00mac_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			  u32 tx_ant, u32 rx_ant);
+int rt2x00mac_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			  u32 *tx_ant, u32 *rx_ant);
 void rt2x00mac_get_ringparam(struct ieee80211_hw *hw,
 			     u32 *tx, u32 *tx_max, u32 *rx, u32 *rx_max);
 bool rt2x00mac_tx_frames_pending(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 451632488805..3bc0c1c906c9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -304,7 +304,7 @@ void rt2x00mac_remove_interface(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(rt2x00mac_remove_interface);
 
-int rt2x00mac_config(struct ieee80211_hw *hw, u32 changed)
+int rt2x00mac_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
@@ -740,7 +740,8 @@ void rt2x00mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(rt2x00mac_flush);
 
-int rt2x00mac_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+int rt2x00mac_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			  u32 tx_ant, u32 rx_ant)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	struct link_ant *ant = &rt2x00dev->link.ant;
@@ -785,7 +786,8 @@ int rt2x00mac_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 }
 EXPORT_SYMBOL_GPL(rt2x00mac_set_antenna);
 
-int rt2x00mac_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+int rt2x00mac_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			  u32 *tx_ant, u32 *rx_ant)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
 	struct link_ant *ant = &rt2x00dev->link.ant;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index ded8d4d59289..2905baea6239 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1370,7 +1370,7 @@ static void rtl8180_remove_interface(struct ieee80211_hw *dev,
 	priv->vif = NULL;
 }
 
-static int rtl8180_config(struct ieee80211_hw *dev, u32 changed)
+static int rtl8180_config(struct ieee80211_hw *dev, int radio_idx, u32 changed)
 {
 	struct rtl8180_priv *priv = dev->priv;
 	struct ieee80211_conf *conf = &dev->conf;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 220ac5bdf279..8857bb542c7f 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1151,7 +1151,7 @@ static void rtl8187_remove_interface(struct ieee80211_hw *dev,
 	mutex_unlock(&priv->conf_mutex);
 }
 
-static int rtl8187_config(struct ieee80211_hw *dev, u32 changed)
+static int rtl8187_config(struct ieee80211_hw *dev, int radio_idx, u32 changed)
 {
 	struct rtl8187_priv *priv = dev->priv;
 	struct ieee80211_conf *conf = &dev->conf;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 569856ca677f..496836f716aa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -4552,7 +4552,8 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
 }
 
 static
-int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, int radio_idx, u32 *tx_ant,
+			 u32 *rx_ant)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 
@@ -6839,7 +6840,7 @@ static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
 	priv->vifs[rtlvif->port_num] = NULL;
 }
 
-static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
+static int rtl8xxxu_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
@@ -6988,7 +6989,8 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 			 FIF_PROBE_REQ);
 }
 
-static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
+static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				      u32 rts)
 {
 	if (rts > 2347 && rts != (u32)-1)
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 819cf519e66e..22633c301564 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -566,7 +566,7 @@ static int rtl_op_resume(struct ieee80211_hw *hw)
 }
 #endif
 
-static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
+static int rtl_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 77f9fbe1870c..766f22d31079 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -71,7 +71,7 @@ static void rtw_ops_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
+static int rtw_ops_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	int ret = 0;
@@ -708,7 +708,8 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				     u32 value)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
@@ -797,6 +798,7 @@ static int rtw_ops_set_bitrate_mask(struct ieee80211_hw *hw,
 }
 
 static int rtw_ops_set_antenna(struct ieee80211_hw *hw,
+			       int radio_idx,
 			       u32 tx_antenna,
 			       u32 rx_antenna)
 {
@@ -808,13 +810,14 @@ static int rtw_ops_set_antenna(struct ieee80211_hw *hw,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&rtwdev->mutex);
-	ret = chip->ops->set_antenna(rtwdev, tx_antenna, rx_antenna);
+	ret = chip->ops->set_antenna(rtwdev, -1, tx_antenna, rx_antenna);
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
 
 static int rtw_ops_get_antenna(struct ieee80211_hw *hw,
+			       int radio_idx,
 			       u32 *tx_antenna,
 			       u32 *rx_antenna)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b0f1fabe9554..7ae67143e909 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -873,7 +873,7 @@ struct rtw_chip_ops {
 	void (*set_tx_power_index)(struct rtw_dev *rtwdev);
 	int (*rsvd_page_dump)(struct rtw_dev *rtwdev, u8 *buf, u32 offset,
 			      u32 size);
-	int (*set_antenna)(struct rtw_dev *rtwdev,
+	int (*set_antenna)(struct rtw_dev *rtwdev, int radio_idx,
 			   u32 antenna_tx,
 			   u32 antenna_rx);
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index ab199eaea3c7..710126379e77 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -983,6 +983,7 @@ static bool rtw8822b_check_rf_path(u8 antenna)
 }
 
 static int rtw8822b_set_antenna(struct rtw_dev *rtwdev,
+				int radio_idx,
 				u32 antenna_tx,
 				u32 antenna_rx)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 017d959de3ce..0ce6aa10493e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2767,6 +2767,7 @@ static void rtw8822c_set_tx_power_index(struct rtw_dev *rtwdev)
 }
 
 static int rtw8822c_set_antenna(struct rtw_dev *rtwdev,
+				int radio_idx,
 				u32 antenna_tx,
 				u32 antenna_rx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a47971003bd4..b9e046208424 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -72,7 +72,7 @@ static void rtw89_ops_stop(struct ieee80211_hw *hw, bool suspend)
 	rtw89_core_stop(rtwdev);
 }
 
-static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
+static int rtw89_ops_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
@@ -1007,7 +1007,8 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				       u32 value)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
@@ -1119,7 +1120,7 @@ static int rtw89_ops_set_bitrate_mask(struct ieee80211_hw *hw,
 }
 
 static
-int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+int rtw89_ops_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant, u32 rx_ant)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -1142,7 +1143,8 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 }
 
 static
-int rtw89_ops_get_antenna(struct ieee80211_hw *hw,  u32 *tx_ant, u32 *rx_ant)
+int rtw89_ops_get_antenna(struct ieee80211_hw *hw, int radio_idx, u32 *tx_ant,
+			  u32 *rx_ant)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 9db08200f4fa..ed0958a20aab 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -656,11 +656,13 @@ static int rsi_config_power(struct ieee80211_hw *hw)
  *			   requests. The stack calls this function to
  *			   change hardware configuration, e.g., channel.
  * @hw: Pointer to the ieee80211_hw structure.
+ * @radio_idx: Radio index.
  * @changed: Changed flags set.
  *
  * Return: 0 on success, negative error code on failure.
  */
 static int rsi_mac80211_config(struct ieee80211_hw *hw,
+			       int radio_idx,
 			       u32 changed)
 {
 	struct rsi_hw *adapter = hw->priv;
@@ -1201,12 +1203,13 @@ static int rsi_mac80211_ampdu_action(struct ieee80211_hw *hw,
 /**
  * rsi_mac80211_set_rts_threshold() - This function sets rts threshold value.
  * @hw: Pointer to the ieee80211_hw structure.
+ * @radio_idx: Radio index.
  * @value: Rts threshold value.
  *
  * Return: 0 on success.
  */
 static int rsi_mac80211_set_rts_threshold(struct ieee80211_hw *hw,
-					  u32 value)
+					  int radio_idx, u32 value)
 {
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
@@ -1583,12 +1586,14 @@ static int rsi_mac80211_sta_remove(struct ieee80211_hw *hw,
  * rsi_mac80211_set_antenna() - This function is used to configure
  *				tx and rx antennas.
  * @hw: Pointer to the ieee80211_hw structure.
+ * @radio_idx: Radio index
  * @tx_ant: Bitmap for tx antenna
  * @rx_ant: Bitmap for rx antenna
  *
  * Return: 0 on success, Negative error code on failure.
  */
 static int rsi_mac80211_set_antenna(struct ieee80211_hw *hw,
+				    int radio_idx,
 				    u32 tx_ant, u32 rx_ant)
 {
 	struct rsi_hw *adapter = hw->priv;
@@ -1634,12 +1639,14 @@ static int rsi_mac80211_set_antenna(struct ieee80211_hw *hw,
  * 				tx and rx antennas.
  *
  * @hw: Pointer to the ieee80211_hw structure.
+ * @radio_idx: Radio index
  * @tx_ant: Bitmap for tx antenna
  * @rx_ant: Bitmap for rx antenna
  * 
  * Return: 0 on success, negative error codes on failure.
  */
 static int rsi_mac80211_get_antenna(struct ieee80211_hw *hw,
+				    int radio_idx,
 				    u32 *tx_ant, u32 *rx_ant)
 {
 	struct rsi_hw *adapter = hw->priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index e95b9ded17d9..d12fcc755701 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -220,7 +220,7 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx, u32 value)
 {
 	struct wfx_dev *wdev = hw->priv;
 	struct wfx_vif *wvif = NULL;
@@ -706,7 +706,7 @@ void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif
 	wvif->channel = NULL;
 }
 
-int wfx_config(struct ieee80211_hw *hw, u32 changed)
+int wfx_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index 8702eed5267f..b4812b294f3c 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -21,8 +21,8 @@ struct wfx_sta_priv {
 /* mac80211 interface */
 int wfx_start(struct ieee80211_hw *hw);
 void wfx_stop(struct ieee80211_hw *hw, bool suspend);
-int wfx_config(struct ieee80211_hw *hw, u32 changed);
-int wfx_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int wfx_config(struct ieee80211_hw *hw, int radio_idx, u32 changed);
+int wfx_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx, u32 value);
 void wfx_set_default_unicast_key(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int idx);
 void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 			  unsigned int *total_flags, u64 unused);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 444272caf124..6356a8fe9aba 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -321,7 +321,7 @@ int cw1200_change_interface(struct ieee80211_hw *dev,
 	return ret;
 }
 
-int cw1200_config(struct ieee80211_hw *dev, u32 changed)
+int cw1200_config(struct ieee80211_hw *dev, int radio_idx, u32 changed)
 {
 	int ret = 0;
 	struct cw1200_common *priv = dev->priv;
@@ -857,7 +857,8 @@ void cw1200_wep_key_work(struct work_struct *work)
 	wsm_unlock_tx(priv);
 }
 
-int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int cw1200_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+			     u32 value)
 {
 	int ret = 0;
 	__le32 val32;
diff --git a/drivers/net/wireless/st/cw1200/sta.h b/drivers/net/wireless/st/cw1200/sta.h
index b955b92cfd73..b4f04371668d 100644
--- a/drivers/net/wireless/st/cw1200/sta.h
+++ b/drivers/net/wireless/st/cw1200/sta.h
@@ -22,7 +22,7 @@ int cw1200_change_interface(struct ieee80211_hw *dev,
 			    struct ieee80211_vif *vif,
 			    enum nl80211_iftype new_type,
 			    bool p2p);
-int cw1200_config(struct ieee80211_hw *dev, u32 changed);
+int cw1200_config(struct ieee80211_hw *dev, int radio_idx, u32 changed);
 void cw1200_configure_filter(struct ieee80211_hw *dev,
 			     unsigned int changed_flags,
 			     unsigned int *total_flags,
@@ -36,7 +36,8 @@ int cw1200_set_key(struct ieee80211_hw *dev, enum set_key_cmd cmd,
 		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 		   struct ieee80211_key_conf *key);
 
-int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+int cw1200_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+			     u32 value);
 
 void cw1200_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop);
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index bb53d681c11b..69fc51f183ad 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -589,7 +589,7 @@ static bool wl1251_can_do_pm(struct ieee80211_conf *conf, struct wl1251 *wl)
 	return (conf->flags & IEEE80211_CONF_PS) && !wl->monitor_present;
 }
 
-static int wl1251_op_config(struct ieee80211_hw *hw, u32 changed)
+static int wl1251_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct wl1251 *wl = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
@@ -1051,7 +1051,8 @@ static int wl1251_op_hw_scan(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1251_op_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				       u32 value)
 {
 	struct wl1251 *wl = hw->priv;
 	int ret;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ea9bc4717a85..7079bb853a0e 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3165,7 +3165,7 @@ static int wl12xx_config_vif(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	return 0;
 }
 
-static int wl1271_op_config(struct ieee80211_hw *hw, u32 changed)
+static int wl1271_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif;
@@ -3894,7 +3894,8 @@ static int wl1271_op_sched_scan_stop(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw,
+					int radio_idx, u32 value)
 {
 	struct wl1271 *wl = hw->priv;
 	int ret = 0;
@@ -3923,7 +3924,8 @@ static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return ret;
 }
 
-static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
+				       u32 value)
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f6add19d1da1..eefe8da3b14d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2381,7 +2381,8 @@ static const char * const hwsim_chanwidths[] = {
 	[NL80211_CHAN_WIDTH_320] = "eht320",
 };
 
-static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
+static int mac80211_hwsim_config(struct ieee80211_hw *hw, int radio_idx,
+				 u32 changed)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	struct ieee80211_conf *conf = &hw->conf;
@@ -3338,7 +3339,8 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	return 1;
 }
 
-static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw,
+					    int radio_idx, u32 value)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 9653dbaac3c0..f7c56174424d 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -1133,7 +1133,7 @@ static void zd_op_remove_interface(struct ieee80211_hw *hw,
 	zd_mac_free_cur_beacon(mac);
 }
 
-static int zd_op_config(struct ieee80211_hw *hw, u32 changed)
+static int zd_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
 	struct zd_mac *mac = zd_hw_mac(hw);
 	struct ieee80211_conf *conf = &hw->conf;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7fcc46a0bb48..4e29652f8ee7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1298,7 +1298,8 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	return ret;
 }
 
-static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+					 u32 changed)
 {
 	return 0;
 }
@@ -1795,7 +1796,7 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
-				    struct wireless_dev *wdev,
+				    struct wireless_dev *wdev, int radio_idx,
 				    enum nl80211_tx_power_setting type, int mbm)
 {
 	return 0;
@@ -1803,6 +1804,7 @@ static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
 
 static int cfg80211_rtw_get_txpower(struct wiphy *wiphy,
 				    struct wireless_dev *wdev,
+				    int radio_idx,
 				    unsigned int link_id, int *dbm)
 {
 	*dbm = (12);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..c14e4c2210b3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4752,12 +4752,14 @@ struct cfg80211_ops {
 	int	(*set_mcast_rate)(struct wiphy *wiphy, struct net_device *dev,
 				  int rate[NUM_NL80211_BANDS]);
 
-	int	(*set_wiphy_params)(struct wiphy *wiphy, u32 changed);
+	int	(*set_wiphy_params)(struct wiphy *wiphy, int radio_idx,
+				    u32 changed);
 
 	int	(*set_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
+				int radio_idx,
 				enum nl80211_tx_power_setting type, int mbm);
 	int	(*get_tx_power)(struct wiphy *wiphy, struct wireless_dev *wdev,
-				unsigned int link_id, int *dbm);
+				int radio_idx, unsigned int link_id, int *dbm);
 
 	void	(*rfkill_poll)(struct wiphy *wiphy);
 
@@ -4819,8 +4821,10 @@ struct cfg80211_ops {
 						   struct wireless_dev *wdev,
 						   struct mgmt_frame_regs *upd);
 
-	int	(*set_antenna)(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant);
-	int	(*get_antenna)(struct wiphy *wiphy, u32 *tx_ant, u32 *rx_ant);
+	int	(*set_antenna)(struct wiphy *wiphy, int radio_idx,
+			       u32 tx_ant, u32 rx_ant);
+	int	(*get_antenna)(struct wiphy *wiphy, int radio_idx,
+			       u32 *tx_ant, u32 *rx_ant);
 
 	int	(*sched_scan_start)(struct wiphy *wiphy,
 				struct net_device *dev,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 82617579d910..98f398aa7a1d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4508,7 +4508,7 @@ struct ieee80211_ops {
 				enum nl80211_iftype new_type, bool p2p);
 	void (*remove_interface)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif);
-	int (*config)(struct ieee80211_hw *hw, u32 changed);
+	int (*config)(struct ieee80211_hw *hw, int radio_idx, u32 changed);
 	void (*bss_info_changed)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info,
@@ -4571,8 +4571,10 @@ struct ieee80211_ops {
 	void (*get_key_seq)(struct ieee80211_hw *hw,
 			    struct ieee80211_key_conf *key,
 			    struct ieee80211_key_seq *seq);
-	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
-	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
+	int (*set_frag_threshold)(struct ieee80211_hw *hw, int radio_idx,
+				  u32 value);
+	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_idx,
+				 u32 value);
 	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -4665,7 +4667,8 @@ struct ieee80211_ops {
 	int (*get_survey)(struct ieee80211_hw *hw, int idx,
 		struct survey_info *survey);
 	void (*rfkill_poll)(struct ieee80211_hw *hw);
-	void (*set_coverage_class)(struct ieee80211_hw *hw, s16 coverage_class);
+	void (*set_coverage_class)(struct ieee80211_hw *hw, int radio_idx,
+				   s16 coverage_class);
 #ifdef CONFIG_NL80211_TESTMODE
 	int (*testmode_cmd)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    void *data, int len);
@@ -4680,8 +4683,10 @@ struct ieee80211_ops {
 	void (*channel_switch)(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       struct ieee80211_channel_switch *ch_switch);
-	int (*set_antenna)(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
-	int (*get_antenna)(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+	int (*set_antenna)(struct ieee80211_hw *hw, int radio_idx,
+			   u32 tx_ant, u32 rx_ant);
+	int (*get_antenna)(struct ieee80211_hw *hw, int radio_idx,
+			   u32 *tx_ant, u32 *rx_ant);
 
 	int (*remain_on_channel)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e9ccf43fe3c6..464240e1903f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2899,6 +2899,14 @@ enum nl80211_commands {
  *	APs Support". Drivers may set additional flags that they support
  *	in the kernel or device.
  *
+ * @NL80211_ATTR_WIPHY_RADIO_INDEX: (int) Integer attribute denoting the index
+ *	of the radio in interest. Internally a value of -1 is used to
+ *	indicate that the radio id is not given in user-space. This means
+ *	that all the attributes are applicable to all the radios. If there is
+ *	a radio index provided in user-space, the attributes will be
+ *	applicable to that specific radio only. If the radio id is greater
+ *	thank the number of radios, error denoting invalid value is returned.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3456,6 +3464,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
 
+	NL80211_ATTR_WIPHY_RADIO_INDEX,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..e2ed8401bd32 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3028,7 +3028,8 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+				      u32 changed)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	int err;
@@ -3036,7 +3037,8 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 	if (changed & WIPHY_PARAM_FRAG_THRESHOLD) {
 		ieee80211_check_fast_xmit_all(local);
 
-		err = drv_set_frag_threshold(local, wiphy->frag_threshold);
+		err = drv_set_frag_threshold(local, radio_idx,
+					     wiphy->frag_threshold);
 
 		if (err) {
 			ieee80211_check_fast_xmit_all(local);
@@ -3050,14 +3052,16 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 
 		coverage_class = changed & WIPHY_PARAM_COVERAGE_CLASS ?
 					wiphy->coverage_class : -1;
-		err = drv_set_coverage_class(local, coverage_class);
+		err = drv_set_coverage_class(local, radio_idx,
+					     coverage_class);
 
 		if (err)
 			return err;
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
-		err = drv_set_rts_threshold(local, wiphy->rts_threshold);
+		err = drv_set_rts_threshold(local, radio_idx,
+					    wiphy->rts_threshold);
 
 		if (err)
 			return err;
@@ -3075,18 +3079,19 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 	}
 	if (changed &
 	    (WIPHY_PARAM_RETRY_SHORT | WIPHY_PARAM_RETRY_LONG))
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_RETRY_LIMITS);
+		ieee80211_hw_config(local, radio_idx,
+				    IEEE80211_CONF_CHANGE_RETRY_LIMITS);
 
 	if (changed & (WIPHY_PARAM_TXQ_LIMIT |
 		       WIPHY_PARAM_TXQ_MEMORY_LIMIT |
 		       WIPHY_PARAM_TXQ_QUANTUM))
-		ieee80211_txq_set_params(local);
+		ieee80211_txq_set_params(local, radio_idx);
 
 	return 0;
 }
 
 static int ieee80211_set_tx_power(struct wiphy *wiphy,
-				  struct wireless_dev *wdev,
+				  struct wireless_dev *wdev, int radio_idx,
 				  enum nl80211_tx_power_setting type, int mbm)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
@@ -3214,6 +3219,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 
 static int ieee80211_get_tx_power(struct wiphy *wiphy,
 				  struct wireless_dev *wdev,
+				  int radio_idx,
 				  unsigned int link_id,
 				  int *dbm)
 {
@@ -3392,7 +3398,7 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS))
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 
 	ieee80211_recalc_ps(local);
 	ieee80211_recalc_ps_vif(sdata);
@@ -4238,7 +4244,8 @@ ieee80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 		ieee80211_configure_filter(local);
 }
 
-static int ieee80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
+static int ieee80211_set_antenna(struct wiphy *wiphy, int radio_idx,
+				 u32 tx_ant, u32 rx_ant)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	int ret;
@@ -4254,11 +4261,12 @@ static int ieee80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
-static int ieee80211_get_antenna(struct wiphy *wiphy, u32 *tx_ant, u32 *rx_ant)
+static int ieee80211_get_antenna(struct wiphy *wiphy, int radio_idx,
+				 u32 *tx_ant, u32 *rx_ant)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 
-	return drv_get_antenna(local, tx_ant, rx_ant);
+	return drv_get_antenna(local, radio_idx, tx_ant, rx_ant);
 }
 
 static int ieee80211_set_rekey_data(struct wiphy *wiphy,
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 3aaf5abf1acc..3a847be51f67 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -720,7 +720,7 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 	/* turn idle off *before* setting channel -- some drivers need that */
 	changed = ieee80211_idle_off(local);
 	if (changed)
-		ieee80211_hw_config(local, changed);
+		ieee80211_hw_config(local, -1, changed);
 
 	err = drv_add_chanctx(local, ctx);
 	if (err) {
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a003..01b8d013e23d 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -143,15 +143,16 @@ int drv_change_interface(struct ieee80211_local *local,
 void drv_remove_interface(struct ieee80211_local *local,
 			  struct ieee80211_sub_if_data *sdata);
 
-static inline int drv_config(struct ieee80211_local *local, u32 changed)
+static inline int drv_config(struct ieee80211_local *local, int radio_idx,
+			     u32 changed)
 {
 	int ret;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_config(local, changed);
-	ret = local->ops->config(&local->hw, changed);
+	trace_drv_config(local, radio_idx, changed);
+	ret = local->ops->config(&local->hw, radio_idx, changed);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
@@ -387,45 +388,47 @@ static inline void drv_get_key_seq(struct ieee80211_local *local,
 }
 
 static inline int drv_set_frag_threshold(struct ieee80211_local *local,
-					u32 value)
+					 int radio_idx, u32 value)
 {
 	int ret = 0;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_set_frag_threshold(local, value);
+	trace_drv_set_frag_threshold(local, radio_idx, value);
 	if (local->ops->set_frag_threshold)
-		ret = local->ops->set_frag_threshold(&local->hw, value);
+		ret = local->ops->set_frag_threshold(&local->hw, radio_idx,
+						     value);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
 
 static inline int drv_set_rts_threshold(struct ieee80211_local *local,
-					u32 value)
+					int radio_idx, u32 value)
 {
 	int ret = 0;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_set_rts_threshold(local, value);
+	trace_drv_set_rts_threshold(local, radio_idx, value);
 	if (local->ops->set_rts_threshold)
-		ret = local->ops->set_rts_threshold(&local->hw, value);
+		ret = local->ops->set_rts_threshold(&local->hw, radio_idx,
+						    value);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
 
 static inline int drv_set_coverage_class(struct ieee80211_local *local,
-					 s16 value)
+					 int radio_idx, s16 value)
 {
 	int ret = 0;
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	trace_drv_set_coverage_class(local, value);
+	trace_drv_set_coverage_class(local, radio_idx, value);
 	if (local->ops->set_coverage_class)
-		local->ops->set_coverage_class(&local->hw, value);
+		local->ops->set_coverage_class(&local->hw, radio_idx, value);
 	else
 		ret = -EOPNOTSUPP;
 
@@ -753,20 +756,21 @@ static inline int drv_set_antenna(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 	if (local->ops->set_antenna)
-		ret = local->ops->set_antenna(&local->hw, tx_ant, rx_ant);
+		ret = local->ops->set_antenna(&local->hw, -1, tx_ant, rx_ant);
 	trace_drv_set_antenna(local, tx_ant, rx_ant, ret);
 	return ret;
 }
 
-static inline int drv_get_antenna(struct ieee80211_local *local,
+static inline int drv_get_antenna(struct ieee80211_local *local, int radio_idx,
 				  u32 *tx_ant, u32 *rx_ant)
 {
 	int ret = -EOPNOTSUPP;
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 	if (local->ops->get_antenna)
-		ret = local->ops->get_antenna(&local->hw, tx_ant, rx_ant);
-	trace_drv_get_antenna(local, *tx_ant, *rx_ant, ret);
+		ret = local->ops->get_antenna(&local->hw, radio_idx,
+					      tx_ant, rx_ant);
+	trace_drv_get_antenna(local, radio_idx, *tx_ant, *rx_ant, ret);
 	return ret;
 }
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 30809f0b35f7..b43a47030b75 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1872,7 +1872,8 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 				     struct ieee80211_rx_status *status,
 				     unsigned int mpdu_len,
 				     unsigned int mpdu_offset);
-int ieee80211_hw_config(struct ieee80211_local *local, u32 changed);
+int ieee80211_hw_config(struct ieee80211_local *local, int radio_idx,
+			u32 changed);
 int ieee80211_hw_conf_chan(struct ieee80211_local *local);
 void ieee80211_hw_conf_init(struct ieee80211_local *local);
 void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx);
@@ -2542,7 +2543,7 @@ static inline bool ieee80211_can_run_worker(struct ieee80211_local *local)
 }
 
 int ieee80211_txq_setup_flows(struct ieee80211_local *local);
-void ieee80211_txq_set_params(struct ieee80211_local *local);
+void ieee80211_txq_set_params(struct ieee80211_local *local, int radio_idx);
 void ieee80211_txq_teardown_flows(struct ieee80211_local *local);
 void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 			struct sta_info *sta,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7c27f3cd841c..7b2baebb8644 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -146,7 +146,7 @@ void ieee80211_recalc_idle(struct ieee80211_local *local)
 {
 	u32 change = __ieee80211_recalc_idle(local, false);
 	if (change)
-		ieee80211_hw_config(local, change);
+		ieee80211_hw_config(local, -1, change);
 }
 
 static int ieee80211_verify_mac(struct ieee80211_sub_if_data *sdata, u8 *addr,
@@ -726,7 +726,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 	/* do after stop to avoid reconfiguring when we stop anyway */
 	ieee80211_configure_filter(local);
-	ieee80211_hw_config(local, hw_reconf_flags);
+	ieee80211_hw_config(local, -1, hw_reconf_flags);
 
 	if (local->virt_monitors == local->open_count)
 		ieee80211_add_virtual_monitor(local);
@@ -1491,7 +1491,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	if (local->open_count == 1)
 		ieee80211_hw_conf_init(local);
 	else if (hw_reconf_flags)
-		ieee80211_hw_config(local, hw_reconf_flags);
+		ieee80211_hw_config(local, -1, hw_reconf_flags);
 
 	ieee80211_recalc_ps(local);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6b6de43d9420..c1c758e76d2e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -190,7 +190,8 @@ static u32 ieee80211_calc_hw_conf_chan(struct ieee80211_local *local,
 	return changed;
 }
 
-int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
+int ieee80211_hw_config(struct ieee80211_local *local, int radio_idx,
+			u32 changed)
 {
 	int ret = 0;
 
@@ -201,7 +202,7 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 			   IEEE80211_CONF_CHANGE_SMPS));
 
 	if (changed && local->open_count) {
-		ret = drv_config(local, changed);
+		ret = drv_config(local, radio_idx, changed);
 		/*
 		 * Goal:
 		 * HW reconfiguration should never fail, the driver has told
@@ -235,7 +236,7 @@ static int _ieee80211_hw_conf_chan(struct ieee80211_local *local,
 	if (!changed)
 		return 0;
 
-	return drv_config(local, changed);
+	return drv_config(local, -1, changed);
 }
 
 int ieee80211_hw_conf_chan(struct ieee80211_local *local)
@@ -269,7 +270,7 @@ void ieee80211_hw_conf_init(struct ieee80211_local *local)
 						       ctx ? &ctx->conf : NULL);
 	}
 
-	WARN_ON(drv_config(local, changed));
+	WARN_ON(drv_config(local, -1, changed));
 }
 
 int ieee80211_emulate_add_chanctx(struct ieee80211_hw *hw,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b84150dbfe8c..1f4a852c236c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3181,7 +3181,7 @@ static void ieee80211_enable_ps(struct ieee80211_local *local,
 			return;
 
 		conf->flags |= IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 	}
 }
 
@@ -3193,7 +3193,7 @@ static void ieee80211_change_ps(struct ieee80211_local *local)
 		ieee80211_enable_ps(local, local->ps_sdata);
 	} else if (conf->flags & IEEE80211_CONF_PS) {
 		conf->flags &= ~IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 		timer_delete_sync(&local->dynamic_ps_timer);
 		wiphy_work_cancel(local->hw.wiphy,
 				  &local->dynamic_ps_enable_work);
@@ -3302,7 +3302,7 @@ void ieee80211_dynamic_ps_disable_work(struct wiphy *wiphy,
 
 	if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 		local->hw.conf.flags &= ~IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 	}
 
 	ieee80211_wake_queues_by_reason(&local->hw,
@@ -3377,7 +3377,7 @@ void ieee80211_dynamic_ps_enable_work(struct wiphy *wiphy,
 	    (ifmgd->flags & IEEE80211_STA_NULLFUNC_ACKED)) {
 		ifmgd->flags &= ~IEEE80211_STA_NULLFUNC_ACKED;
 		local->hw.conf.flags |= IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 	}
 }
 
@@ -3985,7 +3985,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 		local->hw.conf.flags &= ~IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 	}
 	local->ps_sdata = NULL;
 
@@ -7342,7 +7342,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		if (local->hw.conf.dynamic_ps_timeout > 0) {
 			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_PS;
-				ieee80211_hw_config(local,
+				ieee80211_hw_config(local, -1,
 						    IEEE80211_CONF_CHANGE_PS);
 			}
 			ieee80211_send_nullfunc(local, sdata, false);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 2b9abc27462e..39756f088b47 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -39,7 +39,7 @@ static void ieee80211_offchannel_ps_enable(struct ieee80211_sub_if_data *sdata)
 	if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 		offchannel_ps_enabled = true;
 		local->hw.conf.flags &= ~IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
+		ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
 	}
 
 	if (!offchannel_ps_enabled ||
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index a9cc832240a5..5a508d99e84f 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -108,7 +108,7 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 			    sdata->u.mgd.powersave &&
 			     !(local->hw.conf.flags & IEEE80211_CONF_PS)) {
 				local->hw.conf.flags |= IEEE80211_CONF_PS;
-				ieee80211_hw_config(local,
+				ieee80211_hw_config(local, -1,
 						    IEEE80211_CONF_CHANGE_PS);
 			}
 		}
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..63b66986f8ca 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -384,12 +384,14 @@ DEFINE_EVENT(local_sdata_addr_evt, drv_remove_interface,
 
 TRACE_EVENT(drv_config,
 	TP_PROTO(struct ieee80211_local *local,
+		 int radio_idx,
 		 u32 changed),
 
-	TP_ARGS(local, changed),
+	TP_ARGS(local, radio_idx, changed),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
+		__field(int, radio_idx)
 		__field(u32, changed)
 		__field(u32, flags)
 		__field(int, power_level)
@@ -403,6 +405,7 @@ TRACE_EVENT(drv_config,
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
+		__entry->radio_idx = radio_idx;
 		__entry->changed = changed;
 		__entry->flags = local->hw.conf.flags;
 		__entry->power_level = local->hw.conf.power_level;
@@ -417,8 +420,8 @@ TRACE_EVENT(drv_config,
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT " ch:%#x" CHANDEF_PR_FMT,
-		LOCAL_PR_ARG, __entry->changed, CHANDEF_PR_ARG
+		LOCAL_PR_FMT " radio_idx:%d ch:%#x" CHANDEF_PR_FMT,
+		LOCAL_PR_ARG, __entry->radio_idx, __entry->changed, CHANDEF_PR_ARG
 	)
 );
 
@@ -818,34 +821,71 @@ TRACE_EVENT(drv_get_key_seq,
 	)
 );
 
-DEFINE_EVENT(local_u32_evt, drv_set_frag_threshold,
-	TP_PROTO(struct ieee80211_local *local, u32 value),
-	TP_ARGS(local, value)
+TRACE_EVENT(drv_set_frag_threshold,
+	TP_PROTO(struct ieee80211_local *local, int radio_idx, u32 value),
+
+	TP_ARGS(local, radio_idx, value),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(int, radio_idx)
+		__field(u32, value)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->radio_idx = radio_idx;
+		__entry->value = value;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " radio_id:%d value:%u",
+		LOCAL_PR_ARG, __entry->radio_idx, __entry->value
+	)
 );
 
-DEFINE_EVENT(local_u32_evt, drv_set_rts_threshold,
-	TP_PROTO(struct ieee80211_local *local, u32 value),
-	TP_ARGS(local, value)
+TRACE_EVENT(drv_set_rts_threshold,
+	TP_PROTO(struct ieee80211_local *local, int radio_idx, u32 value),
+
+	TP_ARGS(local, radio_idx, value),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(int, radio_idx)
+		__field(u32, value)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->radio_idx = radio_idx;
+		__entry->value = value;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " radio_id:%d value:%u",
+		LOCAL_PR_ARG, __entry->radio_idx, __entry->value
+	)
 );
 
 TRACE_EVENT(drv_set_coverage_class,
-	TP_PROTO(struct ieee80211_local *local, s16 value),
+	TP_PROTO(struct ieee80211_local *local, int radio_idx, s16 value),
 
-	TP_ARGS(local, value),
+	TP_ARGS(local, radio_idx, value),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
+		__field(int, radio_idx)
 		__field(s16, value)
 	),
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
+		__entry->radio_idx = radio_idx;
 		__entry->value = value;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT " value:%d",
-		LOCAL_PR_ARG, __entry->value
+		LOCAL_PR_FMT " radio_id:%d value:%d",
+		LOCAL_PR_ARG, __entry->radio_idx, __entry->value
 	)
 );
 
@@ -1291,12 +1331,14 @@ TRACE_EVENT(drv_set_antenna,
 );
 
 TRACE_EVENT(drv_get_antenna,
-	TP_PROTO(struct ieee80211_local *local, u32 tx_ant, u32 rx_ant, int ret),
+	TP_PROTO(struct ieee80211_local *local, int radio_idx, u32 tx_ant,
+		 u32 rx_ant, int ret),
 
-	TP_ARGS(local, tx_ant, rx_ant, ret),
+	TP_ARGS(local, radio_idx, tx_ant, rx_ant, ret),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
+		__field(int, radio_idx)
 		__field(u32, tx_ant)
 		__field(u32, rx_ant)
 		__field(int, ret)
@@ -1304,14 +1346,16 @@ TRACE_EVENT(drv_get_antenna,
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
+		__entry->radio_idx = radio_idx;
 		__entry->tx_ant = tx_ant;
 		__entry->rx_ant = rx_ant;
 		__entry->ret = ret;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT " tx_ant:%d rx_ant:%d ret:%d",
-		LOCAL_PR_ARG, __entry->tx_ant, __entry->rx_ant, __entry->ret
+		LOCAL_PR_FMT " radio_idx:%d tx_ant:%d rx_ant:%d ret:%d",
+		LOCAL_PR_ARG, __entry->radio_idx, __entry->tx_ant,
+		__entry->rx_ant, __entry->ret
 	)
 );
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d8d4f3d7d7f2..26f930d2591f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1541,7 +1541,7 @@ void ieee80211_txq_purge(struct ieee80211_local *local,
 	spin_unlock_bh(&local->active_txq_lock[txqi->txq.ac]);
 }
 
-void ieee80211_txq_set_params(struct ieee80211_local *local)
+void ieee80211_txq_set_params(struct ieee80211_local *local, int radio_idx)
 {
 	if (local->hw.wiphy->txq_limit)
 		local->fq.limit = local->hw.wiphy->txq_limit;
@@ -1605,7 +1605,7 @@ int ieee80211_txq_setup_flows(struct ieee80211_local *local)
 	for (i = 0; i < fq->flows_cnt; i++)
 		codel_vars_init(&local->cvars[i]);
 
-	ieee80211_txq_set_params(local);
+	ieee80211_txq_set_params(local, -1);
 
 	return 0;
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..78cdce9d3993 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1826,13 +1826,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	}
 
 	/* setup fragmentation threshold */
-	drv_set_frag_threshold(local, hw->wiphy->frag_threshold);
+	drv_set_frag_threshold(local, -1, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, hw->wiphy->rts_threshold);
+	drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
 
 	/* reset coverage class */
-	drv_set_coverage_class(local, hw->wiphy->coverage_class);
+	drv_set_coverage_class(local, -1, hw->wiphy->coverage_class);
 
 	ieee80211_led_radio(local, true);
 	ieee80211_mod_tpt_led_trig(local,
@@ -1890,11 +1890,11 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		ieee80211_assign_chanctx(local, sdata, &sdata->deflink);
 
 	/* reconfigure hardware */
-	ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_LISTEN_INTERVAL |
-				   IEEE80211_CONF_CHANGE_MONITOR |
-				   IEEE80211_CONF_CHANGE_PS |
-				   IEEE80211_CONF_CHANGE_RETRY_LIMITS |
-				   IEEE80211_CONF_CHANGE_IDLE);
+	ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_LISTEN_INTERVAL |
+				       IEEE80211_CONF_CHANGE_MONITOR |
+				       IEEE80211_CONF_CHANGE_PS |
+				       IEEE80211_CONF_CHANGE_RETRY_LIMITS |
+				       IEEE80211_CONF_CHANGE_IDLE);
 
 	ieee80211_configure_filter(local);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..c1bc3662da8d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -854,6 +854,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
+	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
 };
 
 /* policy for the key attributes */
@@ -2639,7 +2640,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			u32 tx_ant = 0, rx_ant = 0;
 			int res;
 
-			res = rdev_get_antenna(rdev, &tx_ant, &rx_ant);
+			res = rdev_get_antenna(rdev, -1, &tx_ant, &rx_ant);
 			if (!res) {
 				if (nla_put_u32(msg,
 						NL80211_ATTR_WIPHY_ANTENNA_TX,
@@ -3620,6 +3621,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	u32 frag_threshold = 0, rts_threshold = 0;
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
+	int radio_idx = -1;
 
 	rtnl_lock();
 	/*
@@ -3670,6 +3672,17 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (result)
 		return result;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
+		/* Radio idx is not expected for non-multi radio wiphy */
+		if (rdev->wiphy.n_radio <= 0)
+			return -EINVAL;
+
+		radio_idx = nla_get_u8(
+				info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
+		if (radio_idx >= rdev->wiphy.n_radio)
+			return -EINVAL;
+	}
+
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
@@ -3759,7 +3772,8 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			mbm = nla_get_u32(info->attrs[idx]);
 		}
 
-		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
+		result = rdev_set_tx_power(rdev, txp_wdev, radio_idx, type,
+					   mbm);
 		if (result)
 			return result;
 	}
@@ -3785,7 +3799,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		tx_ant = tx_ant & rdev->wiphy.available_antennas_tx;
 		rx_ant = rx_ant & rdev->wiphy.available_antennas_rx;
 
-		result = rdev_set_antenna(rdev, tx_ant, rx_ant);
+		result = rdev_set_antenna(rdev, radio_idx, tx_ant, rx_ant);
 		if (result)
 			return result;
 	}
@@ -3911,7 +3925,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
 			rdev->wiphy.txq_quantum = txq_quantum;
 
-		result = rdev_set_wiphy_params(rdev, changed);
+		result = rdev_set_wiphy_params(rdev, radio_idx, changed);
 		if (result) {
 			rdev->wiphy.retry_short = old_retry_short;
 			rdev->wiphy.retry_long = old_retry_long;
@@ -4012,7 +4026,7 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	if (rdev->ops->get_tx_power && !wdev->valid_links) {
 		int dbm, ret;
 
-		ret = rdev_get_tx_power(rdev, wdev, 0, &dbm);
+		ret = rdev_get_tx_power(rdev, wdev, -1, 0, &dbm);
 		if (ret == 0 &&
 		    nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
 				DBM_TO_MBM(dbm)))
@@ -4084,7 +4098,7 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 			if (rdev->ops->get_tx_power) {
 				int dbm, ret;
 
-				ret = rdev_get_tx_power(rdev, wdev, link_id, &dbm);
+				ret = rdev_get_tx_power(rdev, wdev, -1, link_id, &dbm);
 				if (ret == 0 &&
 				    nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
 						DBM_TO_MBM(dbm)))
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 9f4783c2354c..803b39c26587 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -577,35 +577,40 @@ static inline int rdev_leave_ibss(struct cfg80211_registered_device *rdev,
 }
 
 static inline int
-rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
+rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, int radio_idx,
+		      u32 changed)
 {
 	int ret = -EOPNOTSUPP;
 
-	trace_rdev_set_wiphy_params(&rdev->wiphy, changed);
+	trace_rdev_set_wiphy_params(&rdev->wiphy, radio_idx, changed);
 	if (rdev->ops->set_wiphy_params)
-		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
+		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, radio_idx,
+						  changed);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_set_tx_power(struct cfg80211_registered_device *rdev,
-				    struct wireless_dev *wdev,
-				    enum nl80211_tx_power_setting type, int mbm)
+				    struct wireless_dev *wdev, int radio_idx,
+				    enum nl80211_tx_power_setting type,
+				    int mbm)
 {
 	int ret;
-	trace_rdev_set_tx_power(&rdev->wiphy, wdev, type, mbm);
-	ret = rdev->ops->set_tx_power(&rdev->wiphy, wdev, type, mbm);
+	trace_rdev_set_tx_power(&rdev->wiphy, wdev, radio_idx, type, mbm);
+	ret = rdev->ops->set_tx_power(&rdev->wiphy, wdev, radio_idx, type,
+				      mbm);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_get_tx_power(struct cfg80211_registered_device *rdev,
-				    struct wireless_dev *wdev, unsigned int link_id,
-				    int *dbm)
+				    struct wireless_dev *wdev, int radio_idx,
+				    unsigned int link_id, int *dbm)
 {
 	int ret;
-	trace_rdev_get_tx_power(&rdev->wiphy, wdev, link_id);
-	ret = rdev->ops->get_tx_power(&rdev->wiphy, wdev, link_id, dbm);
+	trace_rdev_get_tx_power(&rdev->wiphy, wdev, radio_idx, link_id);
+	ret = rdev->ops->get_tx_power(&rdev->wiphy, wdev, radio_idx, link_id,
+				      dbm);
 	trace_rdev_return_int_int(&rdev->wiphy, ret, *dbm);
 	return ret;
 }
@@ -857,21 +862,21 @@ rdev_update_mgmt_frame_registrations(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_set_antenna(struct cfg80211_registered_device *rdev,
-				   u32 tx_ant, u32 rx_ant)
+				   int radio_idx, u32 tx_ant, u32 rx_ant)
 {
 	int ret;
-	trace_rdev_set_antenna(&rdev->wiphy, tx_ant, rx_ant);
-	ret = rdev->ops->set_antenna(&rdev->wiphy, tx_ant, rx_ant);
+	trace_rdev_set_antenna(&rdev->wiphy, radio_idx, tx_ant, rx_ant);
+	ret = rdev->ops->set_antenna(&rdev->wiphy, -1, tx_ant, rx_ant);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_get_antenna(struct cfg80211_registered_device *rdev,
-				   u32 *tx_ant, u32 *rx_ant)
+				   int radio_idx, u32 *tx_ant, u32 *rx_ant)
 {
 	int ret;
-	trace_rdev_get_antenna(&rdev->wiphy);
-	ret = rdev->ops->get_antenna(&rdev->wiphy, tx_ant, rx_ant);
+	trace_rdev_get_antenna(&rdev->wiphy, radio_idx);
+	ret = rdev->ops->get_antenna(&rdev->wiphy, radio_idx, tx_ant, rx_ant);
 	if (ret)
 		trace_rdev_return_int(&rdev->wiphy, ret);
 	else
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4ed9fada4ec0..76d963b097b0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -406,9 +406,19 @@ DEFINE_EVENT(wiphy_only_evt, rdev_return_void,
 	TP_ARGS(wiphy)
 );
 
-DEFINE_EVENT(wiphy_only_evt, rdev_get_antenna,
-	TP_PROTO(struct wiphy *wiphy),
-	TP_ARGS(wiphy)
+TRACE_EVENT(rdev_get_antenna,
+	TP_PROTO(struct wiphy *wiphy, int radio_idx),
+	TP_ARGS(wiphy, radio_idx),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(int, radio_idx)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->radio_idx = radio_idx;
+	),
+	TP_printk(WIPHY_PR_FMT ", radio_idx: %d",
+		  WIPHY_PR_ARG, __entry->radio_idx)
 );
 
 DEFINE_EVENT(wiphy_only_evt, rdev_rfkill_poll,
@@ -1678,18 +1688,20 @@ TRACE_EVENT(rdev_join_ocb,
 );
 
 TRACE_EVENT(rdev_set_wiphy_params,
-	TP_PROTO(struct wiphy *wiphy, u32 changed),
-	TP_ARGS(wiphy, changed),
+	TP_PROTO(struct wiphy *wiphy, int radio_idx, u32 changed),
+	TP_ARGS(wiphy, radio_idx, changed),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
+		__field(int, radio_idx)
 		__field(u32, changed)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
+		__entry->radio_idx = radio_idx;
 		__entry->changed = changed;
 	),
-	TP_printk(WIPHY_PR_FMT ", changed: %u",
-		  WIPHY_PR_ARG, __entry->changed)
+	TP_printk(WIPHY_PR_FMT ", radio_idx: %d, changed: %u",
+		  WIPHY_PR_ARG, __entry->radio_idx, __entry->changed)
 );
 
 DECLARE_EVENT_CLASS(wiphy_wdev_link_evt,
@@ -1710,30 +1722,51 @@ DECLARE_EVENT_CLASS(wiphy_wdev_link_evt,
 		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id)
 );
 
-DEFINE_EVENT(wiphy_wdev_link_evt, rdev_get_tx_power,
+TRACE_EVENT(rdev_get_tx_power,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
-		 unsigned int link_id),
-	TP_ARGS(wiphy, wdev, link_id)
+		 int radio_idx, unsigned int link_id),
+	TP_ARGS(wiphy, wdev, radio_idx, link_id),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__field(int, radio_idx)
+		__field(unsigned int, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		__entry->radio_idx = radio_idx;
+		__entry->link_id = link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT
+		  ", radio_idx: %d, link_id: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG,
+		  __entry->radio_idx, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_tx_power,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
-		 enum nl80211_tx_power_setting type, int mbm),
-	TP_ARGS(wiphy, wdev, type, mbm),
+		 int radio_idx, enum nl80211_tx_power_setting type,
+		 int mbm),
+	TP_ARGS(wiphy, wdev, radio_idx, type, mbm),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
+		__field(int, radio_idx)
 		__field(enum nl80211_tx_power_setting, type)
 		__field(int, mbm)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
+		__entry->radio_idx = radio_idx;
 		__entry->type = type;
 		__entry->mbm = mbm;
 	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", type: %u, mbm: %d",
-		  WIPHY_PR_ARG, WDEV_PR_ARG,__entry->type, __entry->mbm)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT
+		  ", radio_idx: %d, type: %u, mbm: %d",
+		  WIPHY_PR_ARG, WDEV_PR_ARG,
+		  __entry->radio_idx, __entry->type, __entry->mbm)
 );
 
 TRACE_EVENT(rdev_return_int_int,
@@ -1883,9 +1916,24 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 		  WIPHY_PR_ARG, __entry->tx, __entry->rx)
 );
 
-DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
-	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, tx, rx)
+TRACE_EVENT(rdev_set_antenna,
+	TP_PROTO(struct wiphy *wiphy, int radio_idx, u32 tx, u32 rx),
+	TP_ARGS(wiphy, radio_idx, tx, rx),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(int, radio_idx)
+		__field(u32, tx)
+		__field(u32, rx)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->radio_idx = radio_idx;
+		__entry->tx = tx;
+		__entry->rx = rx;
+	),
+	TP_printk(WIPHY_PR_FMT ", radio_idx: %d, tx: %u, rx: %u ",
+		  WIPHY_PR_ARG, __entry->radio_idx,
+		  __entry->tx, __entry->rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..1241fda78a68 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -263,7 +263,7 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	else
 		wdev->wiphy->rts_threshold = rts->value;
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_RTS_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, -1, WIPHY_PARAM_RTS_THRESHOLD);
 	if (err)
 		wdev->wiphy->rts_threshold = orts;
 	return err;
@@ -304,7 +304,7 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 		wdev->wiphy->frag_threshold = frag->value & ~0x1;
 	}
 
-	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_FRAG_THRESHOLD);
+	err = rdev_set_wiphy_params(rdev, -1, WIPHY_PARAM_FRAG_THRESHOLD);
 	if (err)
 		wdev->wiphy->frag_threshold = ofrag;
 	return err;
@@ -355,7 +355,7 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 		changed |= WIPHY_PARAM_RETRY_SHORT;
 	}
 
-	err = rdev_set_wiphy_params(rdev, changed);
+	err = rdev_set_wiphy_params(rdev, -1, changed);
 	if (err) {
 		wdev->wiphy->retry_short = oshort;
 		wdev->wiphy->retry_long = olong;
@@ -890,7 +890,7 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 
 	guard(wiphy)(&rdev->wiphy);
 
-	return rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
+	return rdev_set_tx_power(rdev, wdev, -1, type, DBM_TO_MBM(dbm));
 }
 
 static int cfg80211_wext_giwtxpower(struct net_device *dev,
@@ -910,7 +910,7 @@ static int cfg80211_wext_giwtxpower(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	scoped_guard(wiphy, &rdev->wiphy) {
-		err = rdev_get_tx_power(rdev, wdev, 0, &val);
+		err = rdev_get_tx_power(rdev, wdev, -1, 0, &val);
 	}
 	if (err)
 		return err;
-- 
2.25.1


