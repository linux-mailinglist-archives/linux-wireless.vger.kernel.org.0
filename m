Return-Path: <linux-wireless+bounces-29878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56605CCA05A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D05B306F4B9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339826E6F0;
	Thu, 18 Dec 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+EY05+S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dVAdM19Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E02737F2
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022941; cv=none; b=pFYZwIBFK15LsXFMJonc0Xns8JOUsxgQ4Yneqh+7eAM3jq6g9C5RaoGJAbGHhphBKcY6IbcduuptpUIth8GVL8ulE8ItmNNP26rTgWMOv/cI65WYteFUQA6elTyVtRvc6uHlSetQdwaersSIoBrOwHl6sCgDggJSeQYch6IBGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022941; c=relaxed/simple;
	bh=WaI5nTTcEGFA6xuvrlCx0N5WNhdqEAyLE4zeaAWBRYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVHx1u4y3uhS7G0VMsBGkd6W8d4HnscDaD3MbpqEXZSlbc9VNodsDVo8ZyUU1nXzU1ZphloUURXg3p6KSrkKeoM22m59ULqQhUGgsxuOdZZYSBIFmu0iavcUmQmfO9JoInAV9SQlJOp+vQtJx71jo2MBP32iVB19/P3O4wY2Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+EY05+S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dVAdM19Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YwLV3717306
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X0c0byoprbygggccCZGmfKLOHam2B4psNJuvEQj3fpE=; b=i+EY05+SfXlxeFmL
	cUrGhPgJ7ZFZOssCgvbLxP3hTQ7IdnW5hnTh8+1D9Ixcoxx3h5DMJBGPvCH5nlik
	QwXg+NGYUfWW5gjbcryxXWd8AimhVAT1H3kvd7fNPaS04WynQQ3uFiiJUMT196s/
	Fpb/3CY/ziJQd8u+ZC2LFt4q5qQ/PU9ryM3LlLeLlFq+mrFMwF4flQ3SsX6Kc7Mg
	fKCJQFNBi4L6axSOCe1M+6hdvJk3famxR0+CUUlJoZLsmMlN8d2DjwxQallERP8D
	ZyYOrqcRFDzmmuJ6CMR9YdA1lgzLp8KAHvrf+O6afPFh+CQAOcT957SSXRuF4Z0o
	6haaBg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79av0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0dabc192eso2869475ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022938; x=1766627738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0c0byoprbygggccCZGmfKLOHam2B4psNJuvEQj3fpE=;
        b=dVAdM19Y/z8nOOfmpASwUYIWV/ReCBGq7ndQo3pAZqkmAFYMvqGUqlXatlbeqwCgb2
         2H8h5GOgC85G/PVKJx+aDMpQR5IRAJF0+X07ZD66CPaUxXUIuBPmS1BsAQJ5xpaDN05g
         S1hB2YB5Dzst6yWTyhnAIEQ4mflDajrNbaRKReUqx2LfceRTRP5t+WgixxRt9/oowxZ7
         8GXkzcnoG9yYqJYwzMzTEDMJfDuDrLu5K6XUCFrjGBHFyNn51pZjXs5JDVXF+PFxyVOR
         5K/t1wFA8wTLJ47kL/7MrIxSKIZyCRvKEZN4yFYV42VX3rxM5KAyQJLzvKqSc1MzLKoT
         YABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022938; x=1766627738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0c0byoprbygggccCZGmfKLOHam2B4psNJuvEQj3fpE=;
        b=AnRCueVHNJidJxJyT43Uo06SRaVPCSbwZUgjzcAfEJsyfs6h8ZrGx+OaJo3hEzcLhp
         8u9PIS6GW1boTpvAa6tn7zKuLWMr+0pwC5RQJQ2JdKHB6MRrUBE9eqJg56hl8zLRBUnC
         Vi2YOALlSd0Mzm5XzoqBHb5vSpzDesLV8OWsg/9FhHyLRdZpS64jkKVTQeY1pWyAHCy/
         Ydd00fjv7qXB2CZ0Ag7a3F7IvJYh6KsCCX8yaT0BwOb8VHhF5kFggih4BAFmyV7007Bm
         4u+9P5xR/TebZDlsf2a2lv+g7ubCd7ZR6Glhn/nGjwNqwyc+5GpbtD5Q0AvvMjMYri2d
         k1NA==
X-Gm-Message-State: AOJu0YxPXeydMcGKkcF2qCGmT3W+ZgzwkJz9cxx6mfIDLjWwbgvyi2mP
	Rj3xOUGx3CTeB92AJoeeKx8xkijSKD19VXdFaEDEYMfiWeqGssTuojemKluxFf6TE8/8CUSwaFQ
	RMf7+gbrL66kXWlksqhzsgASlb9JL1SVHE2QH+7K9eP40omLvJ2RHQJgRTCre35grnODNGA==
X-Gm-Gg: AY/fxX7O2eleODF4tz98G+r5u2CA5rHg2wP0oK4KOczMLEMZ5xQ++iIioaHWuFlNBLP
	k1KmpDEVEv36eXvtYLIMcGoqm5UgKK42paHyAG9FURXPRWkrZTGjQjVkq58eacvK4dTr8GBXryc
	kwHajFFgZoSKhUZXERFkUhQirtFg54HbnGPj7lywu3Jwwe0hWjLBRMDwxGyJMt6j6l03z0r1Pt/
	EZQ5SGb98ixUrxylzhphNeAv2kSzR6+zfefyFwYPYb7oN3SjDvzyyyK/MLLC83iE3FfTDBIgVUw
	wQV+rDT9KYAHZOGVBygrCiMo81dIkpN+n94f7J/cVYwKZUFm7x3IzEaG85wE9wBx4WIrl7Bs7tT
	R9TmRKg5Fe6Gp6h/BmW+NiIRep6ibB6+u+rrOe669NRSP2sKdU0ISJlZ6l6bavXI=
X-Received: by 2002:a17:903:3d0f:b0:2a0:993b:d72a with SMTP id d9443c01a7336-2a0993bde77mr136643655ad.4.1766022938490;
        Wed, 17 Dec 2025 17:55:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5l2irzvxLxgTh3qm66e2OsOjrdhZilRqtx5c+ZNk26BjGvqdjrirvnYsZi0fUSWfE05IHZA==
X-Received: by 2002:a17:903:3d0f:b0:2a0:993b:d72a with SMTP id d9443c01a7336-2a0993bde77mr136643465ad.4.1766022937987;
        Wed, 17 Dec 2025 17:55:37 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:37 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:31 +0800
Subject: [PATCH ath-next 17/19] wifi: ath12k: send peer meta data version
 to firmware
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-17-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: v-RZc8I8mmgxUURhsf_4Yq9me2fmcqMg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX2R+3JXFuHG4H
 lMyZ+pQ7McD644Kc0+GoCnC3Qlxx/J3Zr+HcmjUfvcQTMdxaWJg6LvZZvcB99TBh9jxX7K7+ngu
 lqjI2j/cE2bCUcISt+j3vFhNrFEUEtaUZFL/sB3FelYkQiYsu8N+/9Keid+Lo+oLRCrWe3nEpAO
 b/fcr01By22lyc1LDspBXKCo0D3dui5CBudCvm5+h0SDZsqQF9CCiUV9lvvIKEbNpjijKNX5P8c
 3SHzZec8Tyse7AZZt6lRlyaMZBsmJR2+qpGrfRcU1Ylk3IX/osC1KRZTBwhrrCoImCRRLtEokUx
 WX3YEjj6JDHzbH0igSmmdPrW6Wp91iOV0/8m41F1YiQcA3TjB6C+suInZeIygYRXAB8Ac/Sx7lR
 pyFJCIq8/ddeOANq6VAfiAWCZOUOkQ==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=69435f1b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=irMkNu71nIbfwbNoXCgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: v-RZc8I8mmgxUURhsf_4Yq9me2fmcqMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Peer meta data version is currently not delivered to firmware, resulting
in QCC2072 data path issues.

Parse it from service ready ext2 event and send to firmware in WMI init
command.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c | 5 +++++
 drivers/net/wireless/ath/ath12k/wmi.c       | 4 ++++
 drivers/net/wireless/ath/ath12k/wmi.h       | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/wmi.c b/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
index c575b44a33f3..ed538d20d324 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
@@ -102,4 +102,9 @@ void ath12k_wifi7_wmi_init_wcn7850(struct ath12k_base *ab,
 	config->num_multicast_filter_entries = 0x20;
 	config->num_wow_filters = 0x16;
 	config->num_keep_alive_pattern = 0;
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT, ab->wmi_ab.svc_map))
+		config->peer_metadata_ver = ATH12K_PEER_METADATA_V1A;
+	else
+		config->peer_metadata_ver = ab->wmi_ab.dp_peer_meta_data_ver;
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ed2374c4aac0..84c29e4896a4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5477,6 +5477,10 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 				    ret);
 			return ret;
 		}
+
+		ab->wmi_ab.dp_peer_meta_data_ver =
+			u32_get_bits(parse->arg.target_cap_flags,
+				     WMI_TARGET_CAP_FLAGS_RX_PEER_METADATA_VERSION);
 		break;
 
 	case WMI_TAG_ARRAY_STRUCT:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index daee2787cdfd..fdc203fdba0a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2783,6 +2783,8 @@ enum wmi_channel_width {
 #define WMI_EHT_MCS_NSS_10_11  GENMASK(11, 8)
 #define WMI_EHT_MCS_NSS_12_13  GENMASK(15, 12)
 
+#define WMI_TARGET_CAP_FLAGS_RX_PEER_METADATA_VERSION	GENMASK(1, 0)
+
 struct wmi_service_ready_ext2_event {
 	__le32 reg_db_version;
 	__le32 hw_min_max_tx_power_2ghz;
@@ -5230,6 +5232,8 @@ struct ath12k_wmi_base {
 	struct ath12k_svc_ext_info svc_ext_info;
 	u32 sbs_lower_band_end_freq;
 	struct ath12k_hw_mode_info hw_mode_info;
+
+	u8 dp_peer_meta_data_ver;
 };
 
 struct wmi_pdev_set_bios_interface_cmd {

-- 
2.25.1


