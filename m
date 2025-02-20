Return-Path: <linux-wireless+bounces-19169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D5A3D163
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC43E7A8C0D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5711E3DE8;
	Thu, 20 Feb 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="le0vitOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C31E25EB
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032797; cv=none; b=eg2+9jWEGdwGqiwhpjAy7vDtBzP/ZkqvSlmnekFIwBzs2j+dxUs84/5LdSbQuodV8lZZ32tAEnQ2EKRtkKGnDugHJwt9t1MFFnerdUHWLkigAPQGt3ibeptdZ2kvTSYaHjwcTZ3eJTIu74nMbnVzAZIyLiLZq3tuWxZ3ULAh1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032797; c=relaxed/simple;
	bh=x0Ex3MrQ7DAFFXp3l/zv621Gzo+XaHHSvbA5hWEQ1rE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cEyjTXcDUT4ufx+aX0gxUtp0rqEbBhbN0e4YWTKj2IeNgE1ElFG0XaNSjh6IBV9ZO0/KKDZJUGlgchGv/XxoIoPxIoaqILv03cRZtft9zvY5AFDNjJkmxkciW8HSQELkyF7jpnipP+sdalTrMyDrYk4iMNM0Rrix7Jq0wTyP/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=le0vitOK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5vdrj001823;
	Thu, 20 Feb 2025 06:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZN02vA5wrClz74b0lSkMNj
	pSSaLmOreN/dVo8caRP3o=; b=le0vitOKLNu0Ia+XSrg3RxLz3cvLqvhjfyO5t+
	O65T4QxDveCVheIpWyZNVMumZEzyoKGKdENQCc2bpk4HAh2o0wBBQ3LhffHCBdBt
	TN5c35CYT+k8ewUtJOwPZq2Ex3LmGqSTTdZqBDE7EzdY/yiELbD1tWNQYKrO4e3I
	WdWFEhSAbr+k5QDQohBr8IsGjEPXc2N92HlY8rHJBsZLJiCQfFGLG6NmepFMxFo/
	0TDmgRPTpG9zu/UiCKIhQkzMbXWQzMpRzH7sHe21+dPxERJSbRIwJrThwUMARrZw
	KXiSKa2K26BdfLknjhh9KLtO90XS/i4mtfr+NcErR0Wp5Ziw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2d342-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 06:26:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K6QVqc005597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 06:26:31 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 22:26:29 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: read country code from SMBIOS for WCN7850
Date: Thu, 20 Feb 2025 14:26:07 +0800
Message-ID: <20250220062607.334-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2qg0V7eQinovthJCYR2UCxUmZF2fmFIJ
X-Proofpoint-GUID: 2qg0V7eQinovthJCYR2UCxUmZF2fmFIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200044

Read the country code from SMBIOS and send it to the firmware. The 
firmware will then indicate the regulatory domain information for 
the country code, which ath12k will use.

dmesg:
[ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
[ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
[ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
[ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-02582-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

Depends-On:
        [PATCH v11 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
        https://lore.kernel.org/linux-wireless/20250220031056.216-1-quic_kangyang@quicinc.com/

v2: 
    1. rebase on tag: ath/main(ath-202502181756).
	2. rewrite commit message.

---
 drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 8eaf9dd95a6b..0bdd0cd4f071 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -629,7 +629,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 	/* De-Init of components as needed */
 }
 
-static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
+static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
 {
 	struct ath12k_base *ab = data;
 	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
@@ -651,6 +651,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
 		return;
 	}
 
+	spin_lock_bh(&ab->base_lock);
+
+	switch (smbios->country_code_flag) {
+	case ATH12K_SMBIOS_CC_ISO:
+		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code, 0xff);
+		ab->new_alpha2[1] = u16_get_bits(smbios->cc_code, 0xff);
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c\n",
+			   ab->new_alpha2[0], ab->new_alpha2[1]);
+		break;
+	case ATH12K_SMBIOS_CC_WW:
+		ab->new_alpha2[0] = '0';
+		ab->new_alpha2[1] = '0';
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide regdomain\n");
+		break;
+	default:
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios country code setting %d\n",
+			   smbios->country_code_flag);
+		break;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+
 	if (!smbios->bdf_enabled) {
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
 		return;
@@ -690,7 +712,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
 int ath12k_core_check_smbios(struct ath12k_base *ab)
 {
 	ab->qmi.target.bdf_ext[0] = '\0';
-	dmi_walk(ath12k_core_check_bdfext, ab);
+	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
 
 	if (ab->qmi.target.bdf_ext[0] == '\0')
 		return -ENODATA;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 569ff02de09a..bd0c106b5098 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -172,9 +172,34 @@ struct ath12k_ext_irq_grp {
 	struct net_device *napi_ndev;
 };
 
+enum ath12k_smbios_cc_type {
+	/* disable country code setting from SMBIOS */
+	ATH12K_SMBIOS_CC_DISABLE = 0,
+
+	/* set country code by ANSI country name, based on ISO3166-1 alpha2 */
+	ATH12K_SMBIOS_CC_ISO = 1,
+
+	/* worldwide regdomain */
+	ATH12K_SMBIOS_CC_WW = 2,
+};
+
 struct ath12k_smbios_bdf {
 	struct dmi_header hdr;
-	u32 padding;
+	u8 features_disabled;
+
+	/* enum ath12k_smbios_cc_type */
+	u8 country_code_flag;
+
+	/* To set specific country, you need to set country code
+	 * flag=ATH12K_SMBIOS_CC_ISO first, then if country is United
+	 * States, then country code value = 0x5553 ("US",'U' = 0x55, 'S'=
+	 * 0x53). To set country to INDONESIA, then country code value =
+	 * 0x4944 ("IN", 'I'=0x49, 'D'=0x44). If country code flag =
+	 * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
+	 * setting.
+	 */
+	u16 cc_code;
+
 	u8 bdf_enabled;
 	u8 bdf_ext[];
 } __packed;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3b60534fb0f4..e17a35759456 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11502,6 +11502,17 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 			goto err_unregister_hw;
 		}
 
+		if (ar->ab->hw_params->current_cc_support && ab->new_alpha2[0]) {
+			struct wmi_set_current_country_arg current_cc = {};
+
+			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
+			memcpy(&ar->alpha2, ab->new_alpha2, 2);
+			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
+			if (ret)
+				ath12k_warn(ar->ab,
+					    "failed set cc code for mac register: %d\n", ret);
+		}
+
 		ath12k_debugfs_register(ar);
 	}
 

base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
prerequisite-patch-id: 4d98208c1659b01545c48494f7a84c5ba4888da0
prerequisite-patch-id: dc095f4a1f0d9f6c4f6f850fa1dfe3d804f41e47
prerequisite-patch-id: 7bffae693031c27eadd2b3452a059bb224070e0b
prerequisite-patch-id: 3711a8bb24847dd69c5805d7425416b239144898
-- 
2.34.1


