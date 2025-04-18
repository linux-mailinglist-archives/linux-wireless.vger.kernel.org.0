Return-Path: <linux-wireless+bounces-21699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1124A93035
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474947B3EE4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F182690D6;
	Fri, 18 Apr 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="azpv64jm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519F268C69;
	Fri, 18 Apr 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944974; cv=none; b=RSf6vvYWwFgjtaSBfRarJE6xcWPveVY9l98e5CRPeD4sTq2d8xm0neyuOqa68BQyzxBDhPEOjOOpkv72xF/bHKPD7kJdsuyElOM/mIHKXquLwkeSUsQueJih35GUHiyaT1Ywot8nPuhIickG37QVrUCh1V6uXocsvQ2tl9EGUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944974; c=relaxed/simple;
	bh=2HFYnnvqaDoUAmQgWHwV0M1YzDGoD9yFKOGMNWVpCGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IFpRGQtEaLWIuVpOA6/eBYYpH6e/zB4z3uBLn4p9T/TNyrMQKUC9t46U7wHmVf1qjjKiDK5Sfu00Id6Op96KTrmJf/GKvACVMCkUffjSsBLou+55KQhSye40pWye6T4Nw4Xjan00yH1QKVlXqoTQzlUsiA3YjcLx7ChFAZXyE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=azpv64jm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1opKF005236;
	Fri, 18 Apr 2025 02:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MeoZLSV+6ly7syYJI1foAWhV2FKz0J8jELGJeX3JEhc=; b=azpv64jm2nn0sSLL
	oPtGwxvj0aABH951XSvSHHWcFVfseJjdD5YKbGrJ84BBa9jgARrLt0DjCUfntBgw
	Scvne4tHIeQQEVQMi6/LCWhU4migv0A02Z/1DVmf59in8QkivxbwVhNQHBbxE09V
	oVbcdo5tjaOOp0DdPUSikOoBpyuKvEkZr6sZ1NzELdetaOZkOzr/nL6SozH1jRMS
	ch206bYAeiNXAKkStjVQal9PuHYVn4NT/FdeEV9sijSJHu7HqP2oDdgkb3yI3ITG
	Uidw7BQLMttbSOHuIfSTiYCthq+YADx1NIg1A9KCca4fRiCDMXOa2oFh+rBnKBag
	GPZIWA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf6a0tpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2u2qU020919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:02 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:01 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:37 +0800
Subject: [PATCH ath-next 04/15] wifi: ath12k: add support to select 6 GHz
 regulatory type
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-4-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S8LsWdC5088dKy8oXz94-zKO28Y-NGJQ
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6801bf43 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=AeXTdPjlgbe-xUNOcy0A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: S8LsWdC5088dKy8oXz94-zKO28Y-NGJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

For 6 GHz band, firmware offers 3 types of regulatory rules for AP
mode and 6 for station mode in WMI_REG_CHAN_LIST_CC_EXT_EVENTID event.
In ath12k_reg_build_regd() current code by default chooses
WMI_REG_INDOOR_AP type rules from AP mode reg list to build regdomain,
regardless of the interface mode and power type, hence is not correct.

Pass interface mode (wmi_vdev_type) and AP power type
(ieee80211_ap_reg_power) as new arguments to ath12k_reg_build_regd()
such that we can choose correct rules based on them. Currently
ath12k_reg_build_regd() is called only by ath12k_reg_chan_list_event()
when driver boots, at that time these two arguments are not determined
yet, hence by default pass WMI_VDEV_TYPE_UNSPEC and
IEEE80211_REG_UNSET_AP, this results in WMI_REG_INDOOR_AP being chosen
at last. In upcoming patches the rules would be updated when these two
arguments could be determined.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 75 +++++++++++++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.h | 10 ++++-
 drivers/net/wireless/ath/ath12k/wmi.c |  3 +-
 drivers/net/wireless/ath/ath12k/wmi.h |  1 +
 4 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 86e3b426d5f9de525a22850140cbc8acac0b6fcf..3bed5f68cd6b583fff52e9fce5227353e5e5a766 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -716,26 +716,67 @@ static bool ath12k_reg_is_world_alpha(char *alpha)
 	       (alpha[0] == 'n' && alpha[1] == 'a');
 }
 
+enum wmi_reg_6g_ap_type
+ath12k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type)
+{
+	switch (power_type) {
+	case IEEE80211_REG_LPI_AP:
+		return WMI_REG_INDOOR_AP;
+	case IEEE80211_REG_SP_AP:
+		return WMI_REG_STD_POWER_AP;
+	case IEEE80211_REG_VLP_AP:
+		return WMI_REG_VLP_AP;
+	default:
+		return WMI_REG_MAX_AP_TYPE;
+	}
+}
+
 struct ieee80211_regdomain *
 ath12k_reg_build_regd(struct ath12k_base *ab,
-		      struct ath12k_reg_info *reg_info)
+		      struct ath12k_reg_info *reg_info,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type)
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
-	struct ath12k_reg_rule *reg_rule;
+	struct ath12k_reg_rule *reg_rule, *reg_rule_6ghz;
+	u32 flags, reg_6ghz_number, max_bw_6ghz;
 	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
-	u32 flags;
 	char alpha2[3];
 
 	num_rules = reg_info->num_5g_reg_rules + reg_info->num_2g_reg_rules;
 
-	/* FIXME: Currently taking reg rules for 6G only from Indoor AP mode list.
-	 * This can be updated to choose the combination dynamically based on AP
-	 * type and client type, after complete 6G regulatory support is added.
-	 */
-	if (reg_info->is_ext_reg_event)
-		num_rules += reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP];
+	if (reg_info->is_ext_reg_event) {
+		if (vdev_type == WMI_VDEV_TYPE_STA) {
+			enum wmi_reg_6g_ap_type ap_type;
+
+			ap_type = ath12k_reg_ap_pwr_convert(power_type);
+			if (ap_type == WMI_REG_MAX_AP_TYPE)
+				ap_type = WMI_REG_INDOOR_AP;
+
+			reg_6ghz_number = reg_info->num_6g_reg_rules_cl
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			if (reg_6ghz_number == 0) {
+				ap_type = WMI_REG_INDOOR_AP;
+				reg_6ghz_number = reg_info->num_6g_reg_rules_cl
+						[ap_type][WMI_REG_DEFAULT_CLIENT];
+			}
+
+			reg_rule_6ghz = reg_info->reg_rules_6g_client_ptr
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			max_bw_6ghz = reg_info->max_bw_6g_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+		} else {
+			reg_6ghz_number = reg_info->num_6g_reg_rules_ap
+						[WMI_REG_INDOOR_AP];
+			reg_rule_6ghz =
+				reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP];
+			max_bw_6ghz = reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP];
+		}
+
+		num_rules += reg_6ghz_number;
+	}
 
 	if (!num_rules)
 		goto ret;
@@ -794,12 +835,10 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			 */
 			flags = NL80211_RRF_AUTO_BW;
 			ath12k_reg_update_freq_range(&ab->reg_freq_5ghz, reg_rule);
-		} else if (reg_info->is_ext_reg_event &&
-			   reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] &&
-			(k < reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP])) {
-			reg_rule = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP] + k++;
-			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP]);
+		} else if (reg_info->is_ext_reg_event && reg_6ghz_number &&
+			   (k < reg_6ghz_number)) {
+			reg_rule = reg_rule_6ghz + k++;
+			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6ghz);
 			flags = NL80211_RRF_AUTO_BW;
 			ath12k_reg_update_freq_range(&ab->reg_freq_6ghz, reg_rule);
 		} else {
@@ -911,7 +950,9 @@ void ath12k_reg_reset_reg_info(struct ath12k_reg_info *reg_info)
 }
 
 int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
-				struct ath12k_reg_info *reg_info)
+				struct ath12k_reg_info *reg_info,
+				enum wmi_vdev_type vdev_type,
+				enum ieee80211_ap_reg_power power_type)
 {
 	struct ieee80211_regdomain *regd = NULL;
 	struct ath12k *ar;
@@ -947,7 +988,7 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 		    reg_info->alpha2, 2))
 		return 0;
 
-	regd = ath12k_reg_build_regd(ab, reg_info);
+	regd = ath12k_reg_build_regd(ab, reg_info, vdev_type, power_type);
 	if (!regd)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 41230092f77bc9f133313dd334825409f0599fd2..9868daf3f1e56a4e112751b971d92fdad241427e 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -96,11 +96,17 @@ void ath12k_reg_init(struct ieee80211_hw *hw);
 void ath12k_reg_free(struct ath12k_base *ab);
 void ath12k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
-						  struct ath12k_reg_info *reg_info);
+						  struct ath12k_reg_info *reg_info,
+						  enum wmi_vdev_type vdev_type,
+						  enum ieee80211_ap_reg_power power_type);
 int ath12k_regd_update(struct ath12k *ar, bool init);
 int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait);
 
 void ath12k_reg_reset_reg_info(struct ath12k_reg_info *reg_info);
 int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
-				struct ath12k_reg_info *reg_info);
+				struct ath12k_reg_info *reg_info,
+				enum wmi_vdev_type vdev_type,
+				enum ieee80211_ap_reg_power power_type);
+enum wmi_reg_6g_ap_type
+ath12k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9bb6d99e7c16f327f5cb73777af9c545803420be..be66e88fb65a92f943f86c5fa597f13953aa02b2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6132,7 +6132,8 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		goto fallback;
 	}
 
-	ret = ath12k_reg_handle_chan_list(ab, reg_info);
+	ret = ath12k_reg_handle_chan_list(ab, reg_info, WMI_VDEV_TYPE_UNSPEC,
+					  IEEE80211_REG_UNSET_AP);
 	if (ret) {
 		ath12k_warn(ab, "failed to handle chan list %d\n", ret);
 		goto fallback;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 80fdbc5665181d77d1ec9590a5e87d8924494fed..3eb57cc8509de3de8ebf6fc7a3d2f68dd7a6f369 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4507,6 +4507,7 @@ struct ath12k_wmi_target_cap_arg {
 };
 
 enum wmi_vdev_type {
+	WMI_VDEV_TYPE_UNSPEC  = 0,
 	WMI_VDEV_TYPE_AP      = 1,
 	WMI_VDEV_TYPE_STA     = 2,
 	WMI_VDEV_TYPE_IBSS    = 3,

-- 
2.34.1


