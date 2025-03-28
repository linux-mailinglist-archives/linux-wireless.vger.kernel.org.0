Return-Path: <linux-wireless+bounces-20910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06382A74362
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD9B17B2AE
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404D211476;
	Fri, 28 Mar 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P+atRluH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF91ACEBE;
	Fri, 28 Mar 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139982; cv=none; b=HcmbzVxiVXxajWeH2dnvmhJEsHIXZevLf3IvAwWHcVYMbtwg0wFhXKezcMhxtgr36MOt++wk7gubhk6kXzKwR8LSqGuodzX7MlVYVLjFrJ+FNX0FZotYzKxHjqf7V1z9mb8egUrk7yqzhFrukVb7rXbssVisR5Jqn6NodgqQmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139982; c=relaxed/simple;
	bh=ZPpTsV73VkECF2VZt9XIWhyH/Qi+9aP2/lp8+EZ62sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q07aiWMktQQGyxt+kiZJ/5kH4VMJpKCZSm6Z9Ob8DpAWxAooDlsDJRzM+hv7+HwtJRQ+ZZR/AVomN/coR4TeXbS30QAnsfq1g/A4497eKsXGIGI/NMdGLA34g0cdFdiWXnJ5C5XZoI6sUYH+8SHE8ruIiRqp0RgyjGtkMCfA6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P+atRluH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S1UOXX016998;
	Fri, 28 Mar 2025 05:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqspCfbi5cqx/9t3ZdvY+F42EWOUYsJVP2UH7om/nCY=; b=P+atRluHEIenY6QD
	G8+WgwNo6UYN2Sl7fxFu+QRXSMqJ9zom6EabN1e/xERPPuxWM/U7vFD9BTUgWw+g
	CAZpTPuKbm2NtSDMUvDa8LcPW8SqowJFh+hDYZpgk+x8/zswm+4hijzqAXUbuCGN
	b0JuPLT2NebmxteqqaFXELYAckO6cRCTPBgapIAR8NdYp2j+Swpb0KmCD5ETKaEU
	/hmOFrgzX/w36BWx/BNeIWpQbnJBTAQRm62/KGFSwgZfQcNVjZ8VIKz5ue2oFpnS
	hWXruPHIAOiblkz9bLQbYYfy5G25ropgbB4m7BTzfjMcsItoa7EwIoVou3KBg1o6
	leRaXw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45nj5q8fv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52S5WXNc031535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:33 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 22:32:30 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 28 Mar 2025 13:32:24 +0800
Subject: [PATCH ath-next v3 1/6] wifi: ath11k: determine PM policy based on
 machine model
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250328-ath11k-bring-hibernation-back-v3-1-23405ae23431@quicinc.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
In-Reply-To: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Takashi Iwai
	<tiwai@suse.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UotrCJ6emFBMb1FfJlwu0GfwndKlG2JY
X-Proofpoint-ORIG-GUID: UotrCJ6emFBMb1FfJlwu0GfwndKlG2JY
X-Authority-Analysis: v=2.4 cv=Gr9C+l1C c=1 sm=1 tr=0 ts=67e63472 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8
 a=HZsBSmdTCqOkkQ6QzrAA:9 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280036

To handle the Lenovo unexpected wakeup issue [1], previously we revert
commit 166a490f59ac ("wifi: ath11k: support hibernation"). So currently
WLAN target is put into WoWLAN mode during suspend. This is a temporary
solution as it does not work on machines where WLAN power is cut off.

The thought here is that we do WoWLAN suspend on Lenovo machines while
do non-WoWLAN suspend (which is done in the reverted commit) on other
machines. This requires us to identify Lenovo machines from others.
For that purpose, read board vendor and product name from DMI interface,
match it against all known affected machines. If there is a match, choose
WoWLAN suspend mode, else choose non-WoWLAN mode. Save the mode in ab
for later reference.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 55 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  7 +++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3d39ff85ba94ad7229764045e7e6dcab99dd51d5..f3a29f5d2381b53be895a2687bc7ccc81ec1afbf 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -907,6 +907,52 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	},
 };
 
+static const struct dmi_system_id ath11k_pm_quirk_table[] = {
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
+		},
+	},
+	{}
+};
+
 static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
 {
 	WARN_ON(!ab->hw_params.single_pdev_only);
@@ -2327,8 +2373,17 @@ EXPORT_SYMBOL(ath11k_core_pre_init);
 
 int ath11k_core_init(struct ath11k_base *ab)
 {
+	const struct dmi_system_id *dmi_id;
 	int ret;
 
+	dmi_id = dmi_first_match(ath11k_pm_quirk_table);
+	if (dmi_id)
+		ab->pm_policy = (kernel_ulong_t)dmi_id->driver_data;
+	else
+		ab->pm_policy = ATH11K_PM_DEFAULT;
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
+
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 1a3d0de4afde833ec1ce4e3bcef3b7c8955a9c3d..df2b0cb2f0b5a700806cd261ffeb31f5da0741f5 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -892,6 +892,11 @@ struct ath11k_msi_config {
 	u16 hw_rev;
 };
 
+enum ath11k_pm_policy {
+	ATH11K_PM_DEFAULT,
+	ATH11K_PM_WOW,
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath11k_base {
 	enum ath11k_hw_rev hw_rev;
@@ -1058,6 +1063,8 @@ struct ath11k_base {
 	} testmode;
 #endif
 
+	enum ath11k_pm_policy pm_policy;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };

-- 
2.34.1


