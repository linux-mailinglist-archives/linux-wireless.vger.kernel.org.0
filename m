Return-Path: <linux-wireless+bounces-21242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E7A7F49C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCD6169885
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0302620FC;
	Tue,  8 Apr 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DbmQXOy0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8D2620C1
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092419; cv=none; b=ebJNSYt7+WTNxFrkfu/3Z0fsbDCb7BgZgVmq2+f5zbfrVTUsd0ZsAwM1ML4tcmhAm8eUvuzYIy0FczCJAvzdQXfJVwgaI3iucvLW2HHyE2QmQXnIzLDxtc0ZatA9bmYJ9ksa9CpIfWsD3S5ANfnLJxt6xbK8o15VTZGzD0rgc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092419; c=relaxed/simple;
	bh=370njgXLQlbYRp5dbJwp/vCqAvoxCiM7iy2NC3LtsHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESt3qRrUafG+7vORUK6XUWB+nv5r3IkYZ3X2att4Hg9D7eLwYTV2fhk1SyvPpeg/Z88naygYwjrqLlc3d0/SvB1rx6uEIPtlWZ1lkpzzIBIYB/qRd299oHILRsTK2Id43/fq0f6vl9wa7Qkls3Vxbs+cQentdgUAQdClvHZKInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DbmQXOy0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GVP0019761
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hmNs+Dli57VD9IZqVjh4DV7yH/D+861TzD/ZVcimqfs=; b=DbmQXOy0CSvJiPBt
	Tdm+P6p9sps1/NEvXsK9bGHZguauFuqPvd8z0wxyxNVkEOCEVPfdKsqbJ5YopUqA
	tV/nLZke/caYirmLtK6NX9p286O/KZ2nAzW9uM3Cto6THK5Ww433KYpg170A4Ldv
	E2xQQtVQjvniR/8I+C3LfNkn/M84iLF4KEhGk87cQocOg+psp5h4BLxVncObMwmj
	f93oQm6xtRl/XucrdoPJ3vYkNGwNPzQgA36ZSK8p7kzlpECMCqwXaAxHVnTwPhJ8
	lwrmJy0iljTbfXDhuMqB1BFINGTAJaTnUbuQmhABqWlhiwHTpQszZqE8mtfws1oH
	rpSkBw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3emum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:06:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so5839650a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092415; x=1744697215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmNs+Dli57VD9IZqVjh4DV7yH/D+861TzD/ZVcimqfs=;
        b=WMe4cIwaby5KyzDSQkzo6DOrwicj0Q8Fns721dBTtyV8qF2oXsYL4RHGUvBWXtaxp0
         9chSlSTPkF684AOC/eXgg6R+hAJixwLibakYpHL499lcdSqEx7kW0UA8Eq8q7jwq4CnJ
         Ziuft8yk9S0BuE5gUQEeEEd2edP1X3zG9jor6moJoJjHHoLzAbaN0OvQRsau8w4YX+l+
         miEqX9w3a0f2D7Wp5Iv0ho3njqu3MwwK/0TMleYu+zTQTAO1pYM8ezLaLk1e0mHpLnkx
         MSVZ4VukrkZ1SiQB/dygcC2hgMmO0BfKugJUl/n1IkbaC657t9QhXX2Sx5m2FLDQE7EL
         bovg==
X-Forwarded-Encrypted: i=1; AJvYcCUtnlkpQIrAbFVGuwnlA6eoWs4k2ypVrwKZ9l5XzRzIl4uZrh06iLroZp65xJcPU0Jwm7ITEPfoAviG6rYX9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67XcqAVCzbqvYlvG0r0byLeO+WoXSpmQMLMeLDS20/6HPY2Ki
	jfu/b8MYlhiXFA25Epckn7igFoUsXXVi5IAktUCcfACvJK/pMCpjFyVmScKkdgzqw3DY4A0Pf1T
	sw/lF9opAAQ+CxIaflp+/sC68qdaAQtBHkmBQooKovvfQrp3ATwzqfgmvX5jWr78Hag==
X-Gm-Gg: ASbGncvNgX+vp0aT2+Agb/hrIxaj6suRnMy9IVXdmIxHfvxK/225w4LC9+YUYtoks0/
	j5vbv/KuCeLbv0ylf8xK18c9UeKOuurZyWaSQRcVer/e2duMspLLw6KogJEndoaRwWcmVirHFSm
	oGvU44rs2Xgg+4ya+VW0UHJ6FRO1DXiORfJzpvyUtA3D8ylx/DUD3DoTy1O5eaAKuKmYhgkGwti
	F/2GcmT44+CeUHtXTiSw7c5tQsLnwI5QKGFiKH5WFH2owi+Rm3YUpxKB6EYu8LOWpsAiYs32lsT
	HB46bUmbxTD5vQapss+YtyT3BcXz5vp30QLlAouEZIvOV+hiXGJnu/I68E2m5gWKua20e/zNDk9
	SUzIlAUsIu0nZUicmEobSfRhYSthubEE46/CNfdFC
X-Received: by 2002:a05:6a20:2d14:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-201047a3028mr20649701637.42.1744092414740;
        Mon, 07 Apr 2025 23:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWTZekfKLMCAEMlcaqVGQtNPhQy8cuaqM2WzkcJnwPiRfIo5wEm7mrFmj0K0CA+mBi9nPVIg==
X-Received: by 2002:a05:6a20:2d14:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-201047a3028mr20649669637.42.1744092414362;
        Mon, 07 Apr 2025 23:06:54 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:54 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:32 +0530
Subject: [PATCH ath-next v4 4/9] wifi: ath12k: fix ATH12K_FLAG_REGISTERED
 flag handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-4-95e7bf048595@oss.qualcomm.com>
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
X-Proofpoint-GUID: NjVULsjxys13OqX-zXUvW6uUA8diEI-6
X-Proofpoint-ORIG-GUID: NjVULsjxys13OqX-zXUvW6uUA8diEI-6
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f4bd00 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=FkGa1SFpmQEPtfWTPJ4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

Commit a5686ae820fa ("wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to
ath12k_mac_register()") relocated the setting of the ATH12K_FLAG_REGISTERED
flag to the ath12k_mac_register() function. However, this function only
accesses the first device (ab) via ag->ab[0], resulting in the flag being
set only for the first device in the group. Similarly,
ath12k_mac_unregister() only unsets the flag for the first device. The flag
should actually be set for all devices in the group to avoid issues during
recovery.

Hence, move setting and clearing of this flag in the function
ath12k_core_hw_group_start() and ath12k_core_hw_group_stop() respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: a5686ae820fa ("wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 5 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 8a571a615313d2f1190fe9afae02dfd385ede7a3..cb2a99d110d5c9ec2c092fe1a2b776b6265c4126 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -958,6 +958,9 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 		ab = ag->ab[i];
 		if (!ab)
 			continue;
+
+		clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+
 		ath12k_core_device_cleanup(ab);
 	}
 
@@ -1093,6 +1096,8 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 
 		mutex_lock(&ab->core_lock);
 
+		set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+
 		ret = ath12k_core_pdev_create(ab);
 		if (ret) {
 			ath12k_err(ab, "failed to create pdev core %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b6bdc3d2b11a8a5f5733352826c724c671fd49a..5c3c9267e937484cc5f5a7d8032fb3911b4e921c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11773,7 +11773,6 @@ void ath12k_mac_mlo_teardown(struct ath12k_hw_group *ag)
 
 int ath12k_mac_register(struct ath12k_hw_group *ag)
 {
-	struct ath12k_base *ab = ag->ab[0];
 	struct ath12k_hw *ah;
 	int i;
 	int ret;
@@ -11786,8 +11785,6 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 			goto err;
 	}
 
-	set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
-
 	return 0;
 
 err:
@@ -11804,12 +11801,9 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 
 void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 {
-	struct ath12k_base *ab = ag->ab[0];
 	struct ath12k_hw *ah;
 	int i;
 
-	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
-
 	for (i = ag->num_hw - 1; i >= 0; i--) {
 		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)

-- 
2.34.1


