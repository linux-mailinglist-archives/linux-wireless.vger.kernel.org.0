Return-Path: <linux-wireless+bounces-21240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F428A7F497
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3258F7A6F0A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6C25FA2F;
	Tue,  8 Apr 2025 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ABiyXUcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82625FA11
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092412; cv=none; b=UrCtwRk3bwWUxpw5Zke/i8/9DoKLiPzPw/pUkGtBmMRbjEHtZbUrLvm+SGbQZstTYO2D/Vs3MmkJ0xSsJDIrZgYIftQWSwywMeEQpPPPoLN7KFI/NAeZbXzn9EBMPDnWdt8obT/Bw5Yy9T06vXer0A/c2C2as1XzJJ8A4mVrAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092412; c=relaxed/simple;
	bh=xEj5Kb2MB3HDyXSvN3wvDUPq7daHgQbTj1SE/1fqDsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpYrSTbuKhgYAf/eK7xxbLJck/4oH5mgwArpIWy4PaTyB2yMnRNn9amD3zDkcCJ0DX4NHYZQig/h6n1BrQLg5yDX2zLuVIq1t3Ur3/leWJ38vZ4VoJyzOkxi6nUN4VLiY0vShBu9RjUCUmlTcdvh0F7wfnRO0YPH5OW88gbfMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ABiyXUcn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382JKj0014111
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5ujiX5TN5af/Xz2nXtG8TY2vWPEQMb7zUFnh+HQG/4=; b=ABiyXUcnVozxCzRN
	ilaS22toGlAQCHZOvqc4gpBzy08p0nwqiAw9ANTcGb0Fi3QVO0UDM2ak6z7Zq5T8
	eXdNEGV5fywsdYiEZhP79GLA7jFoLgSBQhZYYY2zEfcVsogKFkU9ps6AAQb3l9cR
	Hz6LSwuRn85DY283HvU+gjzqpIVPEwEBn2a/gT4r3Vp/oCAiOWL1sXY55QAdtFCp
	rE7gEwh80AflKT5uiFU9/DUB8eZ+qRDOfGD7Jeig6arQPH9/xAjatnR5kP+PEfSU
	w1e6r/5b95aSUg4uh6epbcFRdCDxnk0JuvpM8iMpYP93AXnLLdt9duwcZw9usYoL
	5l17UA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm6ngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:06:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7394792f83cso3888513b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092409; x=1744697209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5ujiX5TN5af/Xz2nXtG8TY2vWPEQMb7zUFnh+HQG/4=;
        b=QBlXf/+hLbP2KOybaHE+ZJn5aXl5R8UCpe5LpXZHCCKSjz+dz6nbB0zwQcEE1BrGJg
         hmXuzk63OGfyr04moJ1LoqmqRO5URzhmmc9MnIgx7/LY2/yT78kKNZWyWyiY8DCvC9Ll
         4kiEqEhm1da9qtwyAaMpPkpTQuRuY7484ZA7RNW6H2WwjX41r+qu+YwifqXNQBQGVn2U
         ZJkfG8dhIxDX/1N+LwDTYluVZR70DHui+1tyNfFgHzVvfY7/5zpUjoLKngQVRDN5FRxJ
         A+mlEHzZ5ouqg1/F1yHfaOo5EasIG6DFDIcK43GnZ9/wiEC0oEfZ/lEq68cu/cpp6J2v
         7G9w==
X-Forwarded-Encrypted: i=1; AJvYcCUh5+XUNfTq3QYnVGumbIbNhgjPgUcjXQqBwYaJtA19x+g++r4ClCga/vYaRsNG+E8qJqU8gDiR2wLm0/Wu9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkvFu2zHIfLzTy3hjM84FpwWSWnwt4MlhBGVZ89OHACwncq7a
	gDw1gwZn5NgT+AJFFMXwPzlr6OCwDX/KdQn2vaBtDUPgNSeJN2SCXIUoAge7/QoS38XaU3SvDMM
	m6iiEVdtdDC9hA5lXPqz/Ab4pdESCQwMQZY+uHLwMTGUgnggEUb0K0Ysfhb+8pD+HdQ==
X-Gm-Gg: ASbGncueRSOhOfbyQuEjp+Qm7OpyNrj1Ar1PjaM6SiUNSroeEsRSPHhwt0lcXZKDK1g
	7mj+hM5RRdxAt5m1U0MKBGS2CgTBPPxhnZN+cadiav1awOjPdWcWrtqrd2BIeq3HusCx5fQCK/v
	PIsT8IKyo2ZELLIGZr87s363c9y7o5245dl5lnYJ8kpfo52Vf692Ln/umcVMvy8LflpVyI0z6Iv
	LkEwX7zAVNHIsWZvSEQFMgnwqkEz67/3QcAxj1TDEDAAElTLAOF1DUstbL3NqjYl6NLC+mWEuQp
	+JJtIcrs7TSwt3x166NarVfJQc3mVXvFI6BE2jeyU6LQ09io75l44Qas7umAHweD4d/D/4FnJOy
	CtJETqTt2TzjaaJlkfB8BpblYwUQ8vTYzUfrpqnDz
X-Received: by 2002:a05:6a20:9f8e:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-20113c73e57mr17364081637.25.1744092408639;
        Mon, 07 Apr 2025 23:06:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadxRg+Aatc3BVZKnOOTHXj5Tb2ipywTu5R8ckJegG5HqK4rmz9F5E/4Lt9SmzvAPVlzUrng==
X-Received: by 2002:a05:6a20:9f8e:b0:1f5:8c05:e8f8 with SMTP id adf61e73a8af0-20113c73e57mr17364052637.25.1744092408234;
        Mon, 07 Apr 2025 23:06:48 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:47 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:30 +0530
Subject: [PATCH ath-next v4 2/9] wifi: ath12k: add reference counting for
 core attachment to hardware group
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-2-95e7bf048595@oss.qualcomm.com>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: C5oVmJddjqst0K7_p3JmmLj3N7o0tf5g
X-Proofpoint-ORIG-GUID: C5oVmJddjqst0K7_p3JmmLj3N7o0tf5g
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f4bcf9 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=PROE_fPfuV2Hua9vZMcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

Currently, driver does not manage reference counting for attaching and
detaching cores to/from hardware groups. This can lead to issues when
multiple cores are involved. Or with same core, attach/detach is called
multiple times back to back.

Fix this issue by using reference counting.

With that, it is now ensured that the core is properly attached or detached
from the hardware group and even back to back calls will not alter the
count.

Additionally, add some debug logs during the attachment and detachment
events for better debugging and tracking.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 47 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h | 15 +----------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0e71935b272033c5322e76a01e931087ced875ca..8a571a615313d2f1190fe9afae02dfd385ede7a3 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -640,9 +640,49 @@ struct reserved_mem *ath12k_core_get_reserved_mem(struct ath12k_base *ab,
 	return rmem;
 }
 
+static inline
+void ath12k_core_to_group_ref_get(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (ab->hw_group_ref) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "core already attached to group %d\n",
+			   ag->id);
+		return;
+	}
+
+	ab->hw_group_ref = true;
+	ag->num_started++;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "core attached to group %d, num_started %d\n",
+		   ag->id, ag->num_started);
+}
+
+static inline
+void ath12k_core_to_group_ref_put(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (!ab->hw_group_ref) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "core already de-attached from group %d\n",
+			   ag->id);
+		return;
+	}
+
+	ab->hw_group_ref = false;
+	ag->num_started--;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "core de-attached from group %d, num_started %d\n",
+		   ag->id, ag->num_started);
+}
+
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
-	ath12k_core_stopped(ab);
+	ath12k_core_to_group_ref_put(ab);
 
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath12k_qmi_firmware_stop(ab);
@@ -879,9 +919,8 @@ static int ath12k_core_start(struct ath12k_base *ab)
 
 	ath12k_acpi_set_dsm_func(ab);
 
-	if (!test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
-		/* Indicate the core start in the appropriate group */
-		ath12k_core_started(ab);
+	/* Indicate the core start in the appropriate group */
+	ath12k_core_to_group_ref_get(ab);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e8d2a0c859f6260d48c4c636793cf3a24c1c61b6..75fb4a99af9442e3c3f042602cc5b26842aa5231 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1121,6 +1121,7 @@ struct ath12k_base {
 	struct ath12k_wsi_info wsi_info;
 	enum ath12k_firmware_mode fw_mode;
 	struct ath12k_ftm_event_obj ftm_event_obj;
+	bool hw_group_ref;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -1375,20 +1376,6 @@ static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
 	return ab->ag;
 }
 
-static inline void ath12k_core_started(struct ath12k_base *ab)
-{
-	lockdep_assert_held(&ab->ag->mutex);
-
-	ab->ag->num_started++;
-}
-
-static inline void ath12k_core_stopped(struct ath12k_base *ab)
-{
-	lockdep_assert_held(&ab->ag->mutex);
-
-	ab->ag->num_started--;
-}
-
 static inline struct ath12k_base *ath12k_ag_to_ab(struct ath12k_hw_group *ag,
 						  u8 device_id)
 {

-- 
2.34.1


