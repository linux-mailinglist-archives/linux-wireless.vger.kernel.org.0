Return-Path: <linux-wireless+bounces-21709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0FA93049
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361837B4E8E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7826B97F;
	Fri, 18 Apr 2025 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NBgevNYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333F26B2B0;
	Fri, 18 Apr 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944992; cv=none; b=PcIBm1uBM/SqmNX5z01yrZDsiOWDDJSF981uVE8QovdLhzK7pHbHTQCx9454YYlKdXkAY5o/zs7gKSXtTxXm4VB3P9TUH8jL38lL3GPdESO38QTfuKPr7ELHZV0KgqlsF19meA59+njSHNDSnq2jwiDJh31OjAgDypXWUUgkxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944992; c=relaxed/simple;
	bh=3bhF/ZlNiq0f7+kGr+ha3SHEJ1NWFtDQrRyJoJWQX4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bg4yjGFMCEp1DqXX3z4d2qC+7pZ4qNuKDaftdBqC5XUJwfVCYsxw0vaxcqEvv2VcffIZcGVjRf00LRPzGKwEOjaMSdjZFiYvMAJtfGZRRuJDH0HevsApxd6K+QYiHANcBFWXc2eQWCv+BMDIEUmXTzX92qRTAUudQf9YfoW/CdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NBgevNYw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2cLDY005239;
	Fri, 18 Apr 2025 02:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6q+KVc/+rhJjnVbQsQtWC7AwbUoA91VgMjOAhsGG4f0=; b=NBgevNYwdgwouddc
	T0zQDYFNzQ/8/wvBrSPc/2Mm7lBFoPK8YWNfWiaOCNVy3lFvj14gk52EmOjyzEiy
	i06hXTxiwYsZCeCp9yvpAWZjni/T2oG5i/roC2NKADkOGjrGEzn5pdXoWi5Z8VcR
	SI4mVJkSB0kCEyj78wgZ/qXWMWlXcqln8Y+8Dgh4byFmEidXcKOKoyZozckyKFW0
	YeYlVJF5IuMGGbXsaMnlNkakdmNYXBNiPO37JynbYAZk22lmN6qVlg0KVwaM15vk
	RaJxTwLac6t1OO6hLSm5Xaj/QJpef3mcBD9rQnepKPk1151UKzDoss9259tefpuO
	VaBy6g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf6a0tqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2uMus001611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:22 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:21 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:48 +0800
Subject: [PATCH ath-next 15/15] wifi: ath12k: use
 WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-15-c869c86cad60@quicinc.com>
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
X-Proofpoint-GUID: fP3YFMUjg6wSTIvvgRLi5sHuOwQnL4DW
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6801bf57 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=M5L6X800NHTnsvtFUu4A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fP3YFMUjg6wSTIvvgRLi5sHuOwQnL4DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

When station is connected to a 6 GHz AP, there are 2 ways to configure the
power limit to firmware. The first way is to send 2 WMI commands
WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to firmware,
the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to firmware which
includes more parameters for power control.

When firmware advertises WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, it supports
WMI_VDEV_SET_TPC_POWER_CMDID, ath12k uses it to send more parameters to
firmware. As chanctx is needed to extract necessary info for this command,
save it beforehand in ath12k_mac_op_assign_vif_chanctx().

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 21 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 54495a88c6ee0ba15e58964428d4c5851f3d7404..2f69f12af36013dc0a2b8448736026190560077a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3732,6 +3732,18 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
 			    psmode, arvif->vdev_id, ret);
 }
 
+static bool ath12k_mac_supports_station_tpc(struct ath12k *ar,
+					    struct ath12k_vif *ahvif,
+					    const struct cfg80211_chan_def *chandef)
+{
+	return ath12k_wmi_supports_6ghz_cc_ext(ar) &&
+		test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map) &&
+		ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+		ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE &&
+		chandef->chan &&
+		chandef->chan->band == NL80211_BAND_6GHZ;
+}
+
 static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 					struct ath12k_link_vif *arvif,
 					struct ieee80211_bss_conf *info,
@@ -9350,6 +9362,15 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 		return ret;
 	}
 
+	/* TODO: For now we only set TPC power here. However when
+	 * channel changes, say CSA, it should be updated again.
+	 */
+	if (ath12k_mac_supports_station_tpc(ar, ahvif, chandef)) {
+		ath12k_mac_fill_reg_tpc_info(ar, arvif, ctx);
+		ath12k_wmi_send_vdev_set_tpc_power(ar, arvif->vdev_id,
+						   &arvif->reg_tpc_info);
+	}
+
 	ar->num_started_vdevs++;
 	ath12k_dbg(ab, ATH12K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
 		   ahvif->vif->addr, arvif->vdev_id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 9d4ea4f359a7b12f80701baf422183fae6a55efe..d0a79a907dc752e65e3da852b66e1eda17b705c6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2220,6 +2220,8 @@ enum wmi_tlv_service {
 
 	WMI_MAX_EXT_SERVICE = 256,
 
+	WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT = 280,
+
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 
 	WMI_TLV_SERVICE_11BE = 289,

-- 
2.34.1


