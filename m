Return-Path: <linux-wireless+bounces-26336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDDB22EB6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2355628FB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3E2FE565;
	Tue, 12 Aug 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aOBZNjug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AD2FDC5F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018773; cv=none; b=I2iTjH1wZyshkxwS0UZnopg3V6vafKIhZx0pXOXokEYppl0pLnqIkOqbejOScH2DRprSHn7R+nVDx8AX6K6SoQDlwna1LubBc0fSSiRFiifw3QimNffPF9Vydk166mvKMvwj9QIyvtoCxx+t8+dgj1OTgNBijL1VojFv9HpqOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018773; c=relaxed/simple;
	bh=Ypgf+uMRd8DXsRIYxpj7INO0jI2VHmyokCmPuYV3dio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rH38+VwrN2lf2TVQDbKdIzkrlQdBlSa6fi49j5gcCGhOXOJkSafHpulMgNWBTRpyaGpCm/mWp70uziESFQvSRwE5D9OL5XGWeAjoQXFOHK2JyZ0OOCbMzx6UfK0KeD0fi500sIO/unyo1XchYV2MP9uMDriDa/gSy/xOKt1xmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aOBZNjug; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH6JTB010558;
	Tue, 12 Aug 2025 17:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QC+Flkoer2KfOBhzty/eBeqUx6MsLUAcQFRAufy+ct8=; b=aOBZNjugWNFTEMHQ
	5MwY1j6AlqCsY26KwBSi9yDpDdPg7d7fiL1mAQUdafjr2lFBHShDhgLr4lPdhzjN
	+QQVG8bh04mgBZe8zKCNScJXaM7hYBj+dKgzaznSp2xN27N197HWS4OiCvFpYqPS
	Vl+NZTOorwlZz7EoZW0sl1cD6PSBJO3T1kYooQseWvq033XEbw91adMJzPAGf773
	Lm3tx0+6+7HG+xJcjH3TtsEcEOHWC4nBnC+h9SFrUf9lug/LiOv0gTuQM3WXWm4m
	YbLy/wfBTyVMMRWw3ZLM0iZmDIBti++yl2i6KjHrJ3Yve4j0VNraI6zFGx2Ya/Od
	gS1BOA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9r0hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCm5Z026418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:48 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:47 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:37 +0530
Subject: [PATCH ath12k-ng 11/13] wifi: ath12k: Rename ath12k_* symbols to
 ath12k_wifi7_* for clarity
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-11-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689b7611 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=YnfiWfyS9VFsbo2eCNMA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rhC4T7lNwwG3IGBsYJESGByL8i9GuhDZ
X-Proofpoint-ORIG-GUID: rhC4T7lNwwG3IGBsYJESGByL8i9GuhDZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX9IYLh+MUGFpW
 Ypm1pBdmWrAwQNSm1ufYr6/EWLRUjJYctHfaWxcbRRp/LpWv1NE2mLloMbeOi3V1mPFFjmTzCTS
 upbI4lj8IxMOpZL4KR0SxNEojRFB+6XLyo2OACPR1/grbZhaWX5scsvMDSeHwkemGELtqyD6ulE
 XupXybI70npuVgFlBqmhKmr577MIWGfXZmtsbV8C1UtjUPr9a/fjoclNYWmt14pjo2YKx69+mKD
 dg8Zz+Kagg89K/oODKrRYtQy3x2XI+vz9Nsdb8FTnn1cc+XM/19qmhV5yubNnOELLCd5Ag0hfvC
 0+LXMu58UCH0rssOAYrtJMzVNkHkXIbQoWpxuJF/d0tr38nn6cEbKC6u6Gm2NNj2IWD54ARTCuX
 Y3QhvKem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Rename functions and global definitions from ath12k_* to ath12k_wifi7_*
to reflect their association with the Wi-Fi 7 specific module.
Align symbol naming with recent relocation of components into the
ath12k/wifi7 directory.

This change improves code clarity and supports the modularization effort
that separates common and hardware-specific logic into distinct modules.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/ce.c  |  21 ++--
 drivers/net/wireless/ath/ath12k/wifi7/ce.h  |  18 ++--
 drivers/net/wireless/ath/ath12k/wifi7/hw.c  | 150 +++++++++++++++-------------
 drivers/net/wireless/ath/ath12k/wifi7/mhi.c |  28 +++---
 drivers/net/wireless/ath/ath12k/wifi7/mhi.h |   4 +-
 drivers/net/wireless/ath/ath12k/wifi7/pci.c |  13 +--
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c |   8 +-
 drivers/net/wireless/ath/ath12k/wifi7/wmi.h |   8 +-
 8 files changed, 132 insertions(+), 118 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/ce.c b/drivers/net/wireless/ath/ath12k/wifi7/ce.c
index b4bd1136c25650f559d83242543edf571969059c..952d6c39c333493ce9d341becc7cdba18337f891 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/ce.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/ce.c
@@ -15,7 +15,7 @@
 
 /* Copy Engine (CE) configs for QCN9274 */
 /* Target firmware's Copy Engine configuration. */
-const struct ce_pipe_config ath12k_target_ce_config_wlan_qcn9274[] = {
+const struct ce_pipe_config ath12k_wifi7_target_ce_config_wlan_qcn9274[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.pipenum = __cpu_to_le32(0),
@@ -148,7 +148,8 @@ const struct ce_pipe_config ath12k_target_ce_config_wlan_qcn9274[] = {
  *      PIPEDIR_OUT = UL = host -> target
  *      PIPEDIR_IN = DL = target -> host
  */
-const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_qcn9274[] = {
+const struct service_to_pipe
+ath12k_wifi7_target_service_to_ce_map_wlan_qcn9274[] = {
 	{
 		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VO),
 		__cpu_to_le32(PIPEDIR_OUT),
@@ -259,7 +260,7 @@ const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_qcn9274[] = {
 	},
 };
 
-const struct ce_attr ath12k_host_ce_config_qcn9274[] = {
+const struct ce_attr ath12k_wifi7_host_ce_config_qcn9274[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.flags = CE_ATTR_FLAGS,
@@ -395,7 +396,7 @@ const struct ce_attr ath12k_host_ce_config_qcn9274[] = {
 
 /* Copy Engine (CE) configs for WCN7850 */
 /* Target firmware's Copy Engine configuration. */
-const struct ce_pipe_config ath12k_target_ce_config_wlan_wcn7850[] = {
+const struct ce_pipe_config ath12k_wifi7_target_ce_config_wlan_wcn7850[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.pipenum = __cpu_to_le32(0),
@@ -488,7 +489,8 @@ const struct ce_pipe_config ath12k_target_ce_config_wlan_wcn7850[] = {
 	/* CE 9, 10, 11 are used by MHI driver */
 };
 
-const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_wcn7850[] = {
+const struct service_to_pipe
+ath12k_wifi7_target_service_to_ce_map_wlan_wcn7850[] = {
 	{
 		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VO),
 		__cpu_to_le32(PIPEDIR_OUT),
@@ -569,7 +571,7 @@ const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_wcn7850[] = {
 	},
 };
 
-const struct ce_attr ath12k_host_ce_config_wcn7850[] = {
+const struct ce_attr ath12k_wifi7_host_ce_config_wcn7850[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.flags = CE_ATTR_FLAGS,
@@ -647,7 +649,7 @@ const struct ce_attr ath12k_host_ce_config_wcn7850[] = {
 
 /* Copy Engine (CE) configs for IPQ5332 */
 /* Target firmware's Copy Engine configuration. */
-const struct ce_pipe_config ath12k_target_ce_config_wlan_ipq5332[] = {
+const struct ce_pipe_config ath12k_wifi7_target_ce_config_wlan_ipq5332[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.pipenum = __cpu_to_le32(0),
@@ -768,7 +770,8 @@ const struct ce_pipe_config ath12k_target_ce_config_wlan_ipq5332[] = {
 	},
 };
 
-const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_ipq5332[] = {
+const struct service_to_pipe
+ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332[] = {
 	{
 		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VO),
 		__cpu_to_le32(PIPEDIR_OUT),
@@ -868,7 +871,7 @@ const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_ipq5332[] = {
 	},
 };
 
-const struct ce_attr ath12k_host_ce_config_ipq5332[] = {
+const struct ce_attr ath12k_wifi7_host_ce_config_ipq5332[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.flags = CE_ATTR_FLAGS,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/ce.h b/drivers/net/wireless/ath/ath12k/wifi7/ce.h
index 1e211e8c246729897f66c3e468e96ff7dd15e6fd..369a14472913b06bebc3a03574095c3959def8c9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/ce.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/ce.h
@@ -7,16 +7,16 @@
 #ifndef ATH12K_WIFI7_CE_H
 #define ATH12K_WIFI7_CE_H
 
-extern const struct ce_pipe_config ath12k_target_ce_config_wlan_qcn9274[];
-extern const struct ce_pipe_config ath12k_target_ce_config_wlan_wcn7850[];
-extern const struct ce_pipe_config ath12k_target_ce_config_wlan_ipq5332[];
+extern const struct ce_pipe_config ath12k_wifi7_target_ce_config_wlan_qcn9274[];
+extern const struct ce_pipe_config ath12k_wifi7_target_ce_config_wlan_wcn7850[];
+extern const struct ce_pipe_config ath12k_wifi7_target_ce_config_wlan_ipq5332[];
 
-extern const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_qcn9274[];
-extern const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_wcn7850[];
-extern const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_ipq5332[];
+extern const struct service_to_pipe ath12k_wifi7_target_service_to_ce_map_wlan_qcn9274[];
+extern const struct service_to_pipe ath12k_wifi7_target_service_to_ce_map_wlan_wcn7850[];
+extern const struct service_to_pipe ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332[];
 
-extern const struct ce_attr ath12k_host_ce_config_qcn9274[];
-extern const struct ce_attr ath12k_host_ce_config_wcn7850[];
-extern const struct ce_attr ath12k_host_ce_config_ipq5332[];
+extern const struct ce_attr ath12k_wifi7_host_ce_config_qcn9274[];
+extern const struct ce_attr ath12k_wifi7_host_ce_config_wcn7850[];
+extern const struct ce_attr ath12k_wifi7_host_ce_config_ipq5332[];
 
 #endif /* ATH12K_WIFI7_CE_H */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 93f558847baed6e318f64191cb34f84d7f7586eb..9995eccd32d39f69191f0308b67d35ed3501ebf9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -24,29 +24,31 @@ static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
 					     0xac, 0x12, 0x00, 0x03);
 
-static u8 ath12k_hw_qcn9274_mac_from_pdev_id(int pdev_idx)
+static u8 ath12k_wifi7_hw_qcn9274_mac_from_pdev_id(int pdev_idx)
 {
 	return pdev_idx;
 }
 
-static int ath12k_hw_mac_id_to_pdev_id_qcn9274(const struct ath12k_hw_params *hw,
-					       int mac_id)
+static int
+ath12k_wifi7_hw_mac_id_to_pdev_id_qcn9274(const struct ath12k_hw_params *hw,
+					  int mac_id)
 {
 	return mac_id;
 }
 
-static int ath12k_hw_mac_id_to_srng_id_qcn9274(const struct ath12k_hw_params *hw,
-					       int mac_id)
+static int
+ath12k_wifi7_hw_mac_id_to_srng_id_qcn9274(const struct ath12k_hw_params *hw,
+					  int mac_id)
 {
 	return 0;
 }
 
-static u8 ath12k_hw_get_ring_selector_qcn9274(struct sk_buff *skb)
+static u8 ath12k_wifi7_hw_get_ring_selector_qcn9274(struct sk_buff *skb)
 {
 	return smp_processor_id();
 }
 
-static bool ath12k_dp_srng_is_comp_ring_qcn9274(int ring_num)
+static bool ath12k_wifi7_dp_srng_is_comp_ring_qcn9274(int ring_num)
 {
 	if (ring_num < 3 || ring_num == 4)
 		return true;
@@ -54,30 +56,33 @@ static bool ath12k_dp_srng_is_comp_ring_qcn9274(int ring_num)
 	return false;
 }
 
-static bool ath12k_is_frame_link_agnostic_qcn9274(struct ath12k_link_vif *arvif,
-						  struct ieee80211_mgmt *mgmt)
+static bool
+ath12k_wifi7_is_frame_link_agnostic_qcn9274(struct ath12k_link_vif *arvif,
+					    struct ieee80211_mgmt *mgmt)
 {
 	return ieee80211_is_action(mgmt->frame_control);
 }
 
-static int ath12k_hw_mac_id_to_pdev_id_wcn7850(const struct ath12k_hw_params *hw,
-					       int mac_id)
+static int
+ath12k_wifi7_hw_mac_id_to_pdev_id_wcn7850(const struct ath12k_hw_params *hw,
+					  int mac_id)
 {
 	return 0;
 }
 
-static int ath12k_hw_mac_id_to_srng_id_wcn7850(const struct ath12k_hw_params *hw,
-					       int mac_id)
+static int
+ath12k_wifi7_hw_mac_id_to_srng_id_wcn7850(const struct ath12k_hw_params *hw,
+					  int mac_id)
 {
 	return mac_id;
 }
 
-static u8 ath12k_hw_get_ring_selector_wcn7850(struct sk_buff *skb)
+static u8 ath12k_wifi7_hw_get_ring_selector_wcn7850(struct sk_buff *skb)
 {
 	return skb_get_queue_mapping(skb);
 }
 
-static bool ath12k_dp_srng_is_comp_ring_wcn7850(int ring_num)
+static bool ath12k_wifi7_dp_srng_is_comp_ring_wcn7850(int ring_num)
 {
 	if (ring_num == 0 || ring_num == 2 || ring_num == 4)
 		return true;
@@ -99,8 +104,9 @@ static bool ath12k_is_addba_resp_action_code(struct ieee80211_mgmt *mgmt)
 	return true;
 }
 
-static bool ath12k_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
-						  struct ieee80211_mgmt *mgmt)
+static bool
+ath12k_wifi7_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
+					    struct ieee80211_mgmt *mgmt)
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ath12k_hw *ah = ath12k_ar_to_ah(arvif->ar);
@@ -132,23 +138,23 @@ static bool ath12k_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
 }
 
 static const struct ath12k_hw_ops qcn9274_ops = {
-	.get_hw_mac_from_pdev_id = ath12k_hw_qcn9274_mac_from_pdev_id,
-	.mac_id_to_pdev_id = ath12k_hw_mac_id_to_pdev_id_qcn9274,
-	.mac_id_to_srng_id = ath12k_hw_mac_id_to_srng_id_qcn9274,
+	.get_hw_mac_from_pdev_id = ath12k_wifi7_hw_qcn9274_mac_from_pdev_id,
+	.mac_id_to_pdev_id = ath12k_wifi7_hw_mac_id_to_pdev_id_qcn9274,
+	.mac_id_to_srng_id = ath12k_wifi7_hw_mac_id_to_srng_id_qcn9274,
 	.rxdma_ring_sel_config = ath12k_dp_rxdma_ring_sel_config_qcn9274,
-	.get_ring_selector = ath12k_hw_get_ring_selector_qcn9274,
-	.dp_srng_is_tx_comp_ring = ath12k_dp_srng_is_comp_ring_qcn9274,
-	.is_frame_link_agnostic = ath12k_is_frame_link_agnostic_qcn9274,
+	.get_ring_selector = ath12k_wifi7_hw_get_ring_selector_qcn9274,
+	.dp_srng_is_tx_comp_ring = ath12k_wifi7_dp_srng_is_comp_ring_qcn9274,
+	.is_frame_link_agnostic = ath12k_wifi7_is_frame_link_agnostic_qcn9274,
 };
 
 static const struct ath12k_hw_ops wcn7850_ops = {
-	.get_hw_mac_from_pdev_id = ath12k_hw_qcn9274_mac_from_pdev_id,
-	.mac_id_to_pdev_id = ath12k_hw_mac_id_to_pdev_id_wcn7850,
-	.mac_id_to_srng_id = ath12k_hw_mac_id_to_srng_id_wcn7850,
+	.get_hw_mac_from_pdev_id = ath12k_wifi7_hw_qcn9274_mac_from_pdev_id,
+	.mac_id_to_pdev_id = ath12k_wifi7_hw_mac_id_to_pdev_id_wcn7850,
+	.mac_id_to_srng_id = ath12k_wifi7_hw_mac_id_to_srng_id_wcn7850,
 	.rxdma_ring_sel_config = ath12k_dp_rxdma_ring_sel_config_wcn7850,
-	.get_ring_selector = ath12k_hw_get_ring_selector_wcn7850,
-	.dp_srng_is_tx_comp_ring = ath12k_dp_srng_is_comp_ring_wcn7850,
-	.is_frame_link_agnostic = ath12k_is_frame_link_agnostic_wcn7850,
+	.get_ring_selector = ath12k_wifi7_hw_get_ring_selector_wcn7850,
+	.dp_srng_is_tx_comp_ring = ath12k_wifi7_dp_srng_is_comp_ring_wcn7850,
+	.is_frame_link_agnostic = ath12k_wifi7_is_frame_link_agnostic_wcn7850,
 };
 
 #define ATH12K_TX_RING_MASK_0 0x1
@@ -181,7 +187,7 @@ static const struct ath12k_hw_ops wcn7850_ops = {
 #define ATH12K_RX_MON_STATUS_RING_MASK_1 0x2
 #define ATH12K_RX_MON_STATUS_RING_MASK_2 0x4
 
-static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
+static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_qcn9274 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
 		ATH12K_TX_RING_MASK_1,
@@ -223,7 +229,7 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 	},
 };
 
-static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_ipq5332 = {
+static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_ipq5332 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
 		ATH12K_TX_RING_MASK_1,
@@ -263,7 +269,7 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_ipq5332 = {
 	},
 };
 
-static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_wcn7850 = {
+static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_wcn7850 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
 		ATH12K_TX_RING_MASK_1,
@@ -654,7 +660,7 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 	.gcc_gcc_pcie_hot_rst = 0x1e40304,
 };
 
-static const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
+static const struct ath12k_hw_hal_params ath12k_wifi7_hw_hal_params_qcn9274 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
 	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
@@ -663,7 +669,7 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
-static const struct ath12k_hw_hal_params ath12k_hw_hal_params_wcn7850 = {
+static const struct ath12k_hw_hal_params ath12k_wifi7_hw_hal_params_wcn7850 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
 	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
@@ -671,7 +677,7 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_wcn7850 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
-static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
+static const struct ath12k_hw_hal_params ath12k_wifi7_hw_hal_params_ipq5332 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
 	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
@@ -680,18 +686,18 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
-static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5332 = {
+static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5332 = {
 	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
 	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
 	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
 };
 
-static const struct ce_remap ath12k_ce_remap_ipq5332 = {
+static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
 	.base = HAL_IPQ5332_CE_WFSS_REG_BASE,
 	.size = HAL_IPQ5332_CE_SIZE,
 };
 
-static const struct ath12k_hw_params ath12k_hw_params[] = {
+static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
 		.hw_rev = ATH12K_HW_QCN9274_HW10,
@@ -707,17 +713,18 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.internal_sleep_clock = false,
 
 		.hw_ops = &qcn9274_ops,
-		.ring_mask = &ath12k_hw_ring_mask_qcn9274,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_qcn9274,
 		.regs = &qcn9274_v1_regs,
 
-		.host_ce_config = ath12k_host_ce_config_qcn9274,
+		.host_ce_config = ath12k_wifi7_host_ce_config_qcn9274,
 		.ce_count = 16,
-		.target_ce_config = ath12k_target_ce_config_wlan_qcn9274,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_qcn9274,
 		.target_ce_count = 12,
-		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_qcn9274,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_qcn9274,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = &ath12k_hw_hal_params_qcn9274,
+		.hal_params = &ath12k_wifi7_hw_hal_params_qcn9274,
 
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 1,
@@ -741,9 +748,9 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
-		.mhi_config = &ath12k_mhi_config_qcn9274,
+		.mhi_config = &ath12k_wifi7_mhi_config_qcn9274,
 
-		.wmi_init = ath12k_wmi_init_qcn9274,
+		.wmi_init = ath12k_wifi7_wmi_init_qcn9274,
 
 		.hal_ops = &hal_qcn9274_ops,
 
@@ -794,17 +801,18 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.internal_sleep_clock = true,
 
 		.hw_ops = &wcn7850_ops,
-		.ring_mask = &ath12k_hw_ring_mask_wcn7850,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_wcn7850,
 		.regs = &wcn7850_regs,
 
-		.host_ce_config = ath12k_host_ce_config_wcn7850,
+		.host_ce_config = ath12k_wifi7_host_ce_config_wcn7850,
 		.ce_count = 9,
-		.target_ce_config = ath12k_target_ce_config_wlan_wcn7850,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_wcn7850,
 		.target_ce_count = 9,
-		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_wcn7850,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_wcn7850,
 		.svc_to_ce_map_len = 14,
 
-		.hal_params = &ath12k_hw_hal_params_wcn7850,
+		.hal_params = &ath12k_wifi7_hw_hal_params_wcn7850,
 
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 2,
@@ -829,9 +837,9 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.num_tcl_banks = 7,
 		.max_tx_ring = 3,
 
-		.mhi_config = &ath12k_mhi_config_wcn7850,
+		.mhi_config = &ath12k_wifi7_mhi_config_wcn7850,
 
-		.wmi_init = ath12k_wmi_init_wcn7850,
+		.wmi_init = ath12k_wifi7_wmi_init_wcn7850,
 
 		.hal_ops = &hal_wcn7850_ops,
 
@@ -881,17 +889,18 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.internal_sleep_clock = false,
 
 		.hw_ops = &qcn9274_ops,
-		.ring_mask = &ath12k_hw_ring_mask_qcn9274,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_qcn9274,
 		.regs = &qcn9274_v2_regs,
 
-		.host_ce_config = ath12k_host_ce_config_qcn9274,
+		.host_ce_config = ath12k_wifi7_host_ce_config_qcn9274,
 		.ce_count = 16,
-		.target_ce_config = ath12k_target_ce_config_wlan_qcn9274,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_qcn9274,
 		.target_ce_count = 12,
-		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_qcn9274,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_qcn9274,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = &ath12k_hw_hal_params_qcn9274,
+		.hal_params = &ath12k_wifi7_hw_hal_params_qcn9274,
 
 		.rxdma1_enable = true,
 		.num_rxdma_per_pdev = 1,
@@ -915,9 +924,9 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
-		.mhi_config = &ath12k_mhi_config_qcn9274,
+		.mhi_config = &ath12k_wifi7_mhi_config_qcn9274,
 
-		.wmi_init = ath12k_wmi_init_qcn9274,
+		.wmi_init = ath12k_wifi7_wmi_init_qcn9274,
 
 		.hal_ops = &hal_qcn9274_ops,
 
@@ -967,16 +976,17 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.hw_ops = &qcn9274_ops,
 		.regs = &ipq5332_regs,
-		.ring_mask = &ath12k_hw_ring_mask_ipq5332,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
 
-		.host_ce_config = ath12k_host_ce_config_ipq5332,
+		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
 		.ce_count = 12,
-		.target_ce_config = ath12k_target_ce_config_wlan_ipq5332,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_ipq5332,
 		.target_ce_count = 12,
-		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_ipq5332,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = &ath12k_hw_hal_params_ipq5332,
+		.hal_params = &ath12k_wifi7_hw_hal_params_ipq5332,
 
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 1,
@@ -999,7 +1009,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
-		.wmi_init = &ath12k_wmi_init_qcn9274,
+		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
 
 		.hal_ops = &hal_qcn9274_ops,
 
@@ -1023,8 +1033,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = 0,
 		.supports_aspm = false,
 
-		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
-		.ce_remap = &ath12k_ce_remap_ipq5332,
+		.ce_ie_addr = &ath12k_wifi7_ce_ie_addr_ipq5332,
+		.ce_remap = &ath12k_wifi7_ce_remap_ipq5332,
 		.bdf_addr_offset = 0xC00000,
 
 		.dp_primary_link_only = true,
@@ -1036,14 +1046,14 @@ int ath12k_wifi7_hw_init(struct ath12k_base *ab)
 	const struct ath12k_hw_params *hw_params = NULL;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ath12k_hw_params); i++) {
-		hw_params = &ath12k_hw_params[i];
+	for (i = 0; i < ARRAY_SIZE(ath12k_wifi7_hw_params); i++) {
+		hw_params = &ath12k_wifi7_hw_params[i];
 
 		if (hw_params->hw_rev == ab->hw_rev)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(ath12k_hw_params)) {
+	if (i == ARRAY_SIZE(ath12k_wifi7_hw_params)) {
 		ath12k_err(ab, "Unsupported Wi-Fi 7 hardware version: 0x%x\n",
 			   ab->hw_rev);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/mhi.c b/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
index 74d5f096453118a864ec254150b417bdba5a1d64..b8d972659314b4052fe7d33713f2ff35ed032636 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
@@ -7,7 +7,7 @@
 #include "../mhi.h"
 #include "mhi.h"
 
-static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
+static const struct mhi_channel_config ath12k_wifi7_mhi_channels_qcn9274[] = {
 	{
 		.num = 20,
 		.name = "IPCR",
@@ -38,7 +38,7 @@ static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 	},
 };
 
-static struct mhi_event_config ath12k_mhi_events_qcn9274[] = {
+static struct mhi_event_config ath12k_wifi7_mhi_events_qcn9274[] = {
 	{
 		.num_elements = 32,
 		.irq_moderation_ms = 0,
@@ -61,18 +61,18 @@ static struct mhi_event_config ath12k_mhi_events_qcn9274[] = {
 	},
 };
 
-const struct mhi_controller_config ath12k_mhi_config_qcn9274 = {
+const struct mhi_controller_config ath12k_wifi7_mhi_config_qcn9274 = {
 	.max_channels = 30,
 	.timeout_ms = 10000,
 	.use_bounce_buf = false,
 	.buf_len = 0,
-	.num_channels = ARRAY_SIZE(ath12k_mhi_channels_qcn9274),
-	.ch_cfg = ath12k_mhi_channels_qcn9274,
-	.num_events = ARRAY_SIZE(ath12k_mhi_events_qcn9274),
-	.event_cfg = ath12k_mhi_events_qcn9274,
+	.num_channels = ARRAY_SIZE(ath12k_wifi7_mhi_channels_qcn9274),
+	.ch_cfg = ath12k_wifi7_mhi_channels_qcn9274,
+	.num_events = ARRAY_SIZE(ath12k_wifi7_mhi_events_qcn9274),
+	.event_cfg = ath12k_wifi7_mhi_events_qcn9274,
 };
 
-static const struct mhi_channel_config ath12k_mhi_channels_wcn7850[] = {
+static const struct mhi_channel_config ath12k_wifi7_mhi_channels_wcn7850[] = {
 	{
 		.num = 20,
 		.name = "IPCR",
@@ -103,7 +103,7 @@ static const struct mhi_channel_config ath12k_mhi_channels_wcn7850[] = {
 	},
 };
 
-static struct mhi_event_config ath12k_mhi_events_wcn7850[] = {
+static struct mhi_event_config ath12k_wifi7_mhi_events_wcn7850[] = {
 	{
 		.num_elements = 32,
 		.irq_moderation_ms = 0,
@@ -126,13 +126,13 @@ static struct mhi_event_config ath12k_mhi_events_wcn7850[] = {
 	},
 };
 
-const struct mhi_controller_config ath12k_mhi_config_wcn7850 = {
+const struct mhi_controller_config ath12k_wifi7_mhi_config_wcn7850 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
 	.buf_len = 8192,
-	.num_channels = ARRAY_SIZE(ath12k_mhi_channels_wcn7850),
-	.ch_cfg = ath12k_mhi_channels_wcn7850,
-	.num_events = ARRAY_SIZE(ath12k_mhi_events_wcn7850),
-	.event_cfg = ath12k_mhi_events_wcn7850,
+	.num_channels = ARRAY_SIZE(ath12k_wifi7_mhi_channels_wcn7850),
+	.ch_cfg = ath12k_wifi7_mhi_channels_wcn7850,
+	.num_events = ARRAY_SIZE(ath12k_wifi7_mhi_events_wcn7850),
+	.event_cfg = ath12k_wifi7_mhi_events_wcn7850,
 };
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/mhi.h b/drivers/net/wireless/ath/ath12k/wifi7/mhi.h
index 8417a2bde0877d9a377c8dd4befc24a042f3b629..2e2dd3503d830ae0e63a7d78b17bee2ac908e039 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/mhi.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/mhi.h
@@ -6,6 +6,6 @@
 
 #ifndef _ATH12K_WIFI7_MHI_H
 #define _ATH12K_WIFI7_MHI_H
-extern const struct mhi_controller_config ath12k_mhi_config_qcn9274;
-extern const struct mhi_controller_config ath12k_mhi_config_wcn7850;
+extern const struct mhi_controller_config ath12k_wifi7_mhi_config_qcn9274;
+extern const struct mhi_controller_config ath12k_wifi7_mhi_config_wcn7850;
 #endif /* _ATH12K_WIFI7_MHI_H */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index 01a0b42f0e808a7aab656b88816f2f93a8d4da5e..608669a83ea7561b9a464f44b8dae14500d0a1d9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -12,6 +12,7 @@
 #include "../hif.h"
 #include "../mhi.h"
 #include "hw.h"
+#include "../hal.h"
 
 #define QCN9274_DEVICE_ID		0x1109
 #define WCN7850_DEVICE_ID		0x1107
@@ -44,7 +45,7 @@ static const struct ath12k_msi_config ath12k_wifi7_msi_config[] = {
 	},
 };
 
-static const struct ath12k_pci_ops ath12k_pci_ops_qcn9274 = {
+static const struct ath12k_pci_ops ath12k_wifi7_pci_ops_qcn9274 = {
 	.wakeup = NULL,
 	.release = NULL,
 };
@@ -63,7 +64,7 @@ static void ath12k_wifi7_pci_bus_release(struct ath12k_base *ab)
 	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
-static const struct ath12k_pci_ops ath12k_pci_ops_wcn7850 = {
+static const struct ath12k_pci_ops ath12k_wifi7_pci_ops_wcn7850 = {
 	.wakeup = ath12k_wifi7_pci_bus_wake_up,
 	.release = ath12k_wifi7_pci_bus_release,
 };
@@ -99,7 +100,7 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 	case QCN9274_DEVICE_ID:
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = true;
-		ab_pci->pci_ops = &ath12k_pci_ops_qcn9274;
+		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_qcn9274;
 		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
@@ -122,7 +123,7 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 		ab->id.bdf_search = ATH12K_BDF_SEARCH_BUS_AND_BOARD;
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = false;
-		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
+		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_wcn7850;
 		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
@@ -154,7 +155,7 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 	return 0;
 }
 
-static struct ath12k_pci_driver ath12k_pci_wifi7_driver = {
+static struct ath12k_pci_driver ath12k_wifi7_pci_driver = {
 	.name = "ath12k_wifi7_pci",
 	.id_table = ath12k_wifi7_pci_id_table,
 	.ops.probe = ath12k_wifi7_pci_probe,
@@ -165,7 +166,7 @@ int ath12k_wifi7_pci_init(void)
 	int ret;
 
 	ret = ath12k_pci_register_driver(ATH12K_DEVICE_FAMILY_WIFI7,
-					 &ath12k_pci_wifi7_driver);
+					 &ath12k_wifi7_pci_driver);
 	if (ret) {
 		pr_err("Failed to register ath12k Wi-Fi 7 driver: %d\n",
 		       ret);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/wmi.c b/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
index 652c353f9fc586ae05fa276ebbb99b9a65a5a7c1..c575b44a33f3b7931eb7109ce18954a3e3382dc2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
@@ -7,8 +7,8 @@
 #include "../core.h"
 #include "wmi.h"
 
-void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config)
+void ath12k_wifi7_wmi_init_qcn9274(struct ath12k_base *ab,
+				   struct ath12k_wmi_resource_config_arg *config)
 {
 	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS(ab);
 	config->num_peers = ab->num_radios *
@@ -58,8 +58,8 @@ void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 		config->peer_metadata_ver = ATH12K_PEER_METADATA_V1B;
 }
 
-void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config)
+void ath12k_wifi7_wmi_init_wcn7850(struct ath12k_base *ab,
+				   struct ath12k_wmi_resource_config_arg *config)
 {
 	config->num_vdevs = 4;
 	config->num_peers = 16;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/wmi.h b/drivers/net/wireless/ath/ath12k/wifi7/wmi.h
index 1514e3e8d4cb65d3d95d95a1c1593a7b66abcf58..ae74e176fa2d3f670970a2f3a661c3b6a34242aa 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/wmi.h
@@ -7,9 +7,9 @@
 #ifndef ATH12K_WMI_WIFI7_H
 #define ATH12K_WMI_WIFI7_H
 
-void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config);
-void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
-			     struct ath12k_wmi_resource_config_arg *config);
+void ath12k_wifi7_wmi_init_qcn9274(struct ath12k_base *ab,
+				   struct ath12k_wmi_resource_config_arg *config);
+void ath12k_wifi7_wmi_init_wcn7850(struct ath12k_base *ab,
+				   struct ath12k_wmi_resource_config_arg *config);
 
 #endif

-- 
2.34.1


