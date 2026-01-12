Return-Path: <linux-wireless+bounces-30689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE001D10E9A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01DEA3009951
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905D32E154;
	Mon, 12 Jan 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwhnIF6h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1n6iRSt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107102652B0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203445; cv=none; b=Pm1SYyTAZ+s0o0rUEvsH+9qSURSYAV8Kw1jlZk40wQYuqWRV+i9oRhKH43ZJ7pxkN8L17f0NnF4ktpgHlT2tePM5RxmlWFxrzfCrj3De0iWzxxO2BQpsziHzfn1ZhtXDAzeHehIqxuv6OSQBYHgvd0mtCyuo7TOTMbUXUYqeVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203445; c=relaxed/simple;
	bh=j8V7dUY+GX/SoHlYwNvpaoDJncAYnwn5lnKN8RBkcVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=me428mihVCieyjoHm6EE+xUbtOWFHGF7Za236QPIpdymOYB0M08QvYfQvYcb0mDmN/RbP4E62Gx43i1ydirsQZ7do56tclo0Z5iHx5bshZVI8PqiPJCZzwpNkU6vtkATBYAUffKWT3z+10FXwuY3upxtLIPyAvVh/0SFE88VGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwhnIF6h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1n6iRSt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNFbuQ4097398
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	monwikUG1hDRn94CK5aNYv0OLnIwDFS3CHYmhGLSnsA=; b=AwhnIF6h9++xzFEd
	ZhEqboKjj9Y/r+rVI7ytPOdNCAXySit6Tz0gjffcuGNy5lPLOpg8+3jgZxJv3Sjd
	RogNm/YjYdFiLM2Jw05qa6abq8WGi86E6NqHbV3GFXAx2r1mvzDUzHZyPWcBzD03
	s9QEI07j4W9r3D54jdeaUukVcjp61GPpihx6WPunxvqq02L+bVXDvPpsZNRAZV9A
	Mq+/A+SoxkdhFavh7XKnoHLKHgJf5RKk/vInvIQ9K8uFO0sJSJgY5l/Pbn9WvUnI
	jqmTkfA2138ey2k5bVsYR07kA43g0Llzp7HlPTxZ/D/l/FcFmccwaK3qEy2nT5/3
	DB9Hxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfhakxe1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c5659f40515so4333263a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203442; x=1768808242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=monwikUG1hDRn94CK5aNYv0OLnIwDFS3CHYmhGLSnsA=;
        b=f1n6iRStf7kOlP4n6Y8zUND/RWG6jOfV9p4wymEAP3onTk/FKUjlvt78EmLiezxYmQ
         QeB7yCZhzmLBJYa/+a6IeQbKoafyMMqE1acDiE0U1jBDJlufyccn273Z/1uwQuiEAt5m
         DTYS9e1I6qE+0sFr36kXIr+WzWYq7YXEAc3kzgCjunvTvmfeXYez75r6/3M3GqrdKRuK
         8WTMNNOI4pZEKmVmQ6SEGGxIajgZ/SXBbfFWQbDSWefAxTMIiGlmdUYxcw+30J825iB3
         Ah1BBX/GiiygI7VArG8NiR5hJB1J8Z/NrpdHodeH6P5GJxQdhF8JHaqorf02HBESyfRZ
         buqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203442; x=1768808242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=monwikUG1hDRn94CK5aNYv0OLnIwDFS3CHYmhGLSnsA=;
        b=ohpsUnqVDU2yLf3VZZAkw03ED7wHhyKHJFe7FY2f8CNnPlBsi3EjUJq2lA7jEs/d8j
         h2dC2yWWCPiadcOhrXCQ3Wu8BtCTzqZZOo4j8SjvEMcWsm7/Qys9ie9F2SbCpb+A46+C
         S0WVLwZ0Y52UzvSe2HVC51aDcJPv/9VFPhbma7LWbinAzjcyFdzZArWDugYlWLir2H08
         T5o0s4FNX8tl56VdjlOmktKsrHS2e/B8/WFI3IXpl286SFmXZ2UgJxHk7JW5hQKGqUhG
         8voo4rJWYMzDRQ2I8WKWw5UeT5SNRrW35gpI/1/Kh4AGa91H1YvukEKg2Zg+gmDRfSos
         Bz0A==
X-Gm-Message-State: AOJu0YxUtzUQg3Z7SewGLuMkh6VazokZvJ1QiliWY0csmAwxSGskUmev
	f37J+q3IyZMC3SSZzuv7l8rXDgequx5D4EaxfOmPQ8J+4kSsqGq92irGkimjYqMHiprrxse6tHb
	bcJsnAHw7MxWqqRmche3hDb6Ki62u4HGTChr5ut2NwS+NGzePXQOHhLhxS9BSOEJyYuZ+cu9r4u
	CLPl6I
X-Gm-Gg: AY/fxX6AMz3CZQ30EgVcifZMcvwgZRtDUBQjBG9uotEWFtm+AxKCwjpA7CkyrRY4yJH
	nz8PUgCjt5ETL7RxtbIph/xcdje5BSY9lWeJFMV0k4Of1wkymELDrj7qc9ODW6T2s7ZcMDFxs1H
	Q4GTiV2bvOgiHKkLVTI0iwePaIRzPjTQLUohq845X2viMEd0z2yiNpj8vFa7mxD0Ws5N7zBpl9f
	It089CBnbUwgsbINYXnZ0rbtCrutgMiiN7d5/8xDz1JVKZuMkzC42Z7yKrzy1w5DvuqPAp2jgr1
	sgCtJzXaUQ04H3538cjGbTSagvirwdIvcn3N+loAxPij1uADvstEv1gp/o2chgAcHH0iKI4nmD7
	MZxutvp/3svriwEZ1ggHbp/umZUP0nbSM/epqwlDfWrANWqLef88jwWTMbAiu1e0=
X-Received: by 2002:a05:6a20:3d95:b0:344:f9e5:e9a9 with SMTP id adf61e73a8af0-3898f8fdc5emr15097177637.18.1768203442527;
        Sun, 11 Jan 2026 23:37:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkFO1Tn+UDkYM32rwPDmpEaxzO9FIoM8IvFuKP8S6K4XWbq5Q+4Q6b31LZwUSRkuqClUAgmw==
X-Received: by 2002:a05:6a20:3d95:b0:344:f9e5:e9a9 with SMTP id adf61e73a8af0-3898f8fdc5emr15097154637.18.1768203442089;
        Sun, 11 Jan 2026 23:37:22 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:21 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:36 +0800
Subject: [PATCH ath-next v2 16/18] wifi: ath12k: send peer meta data
 version to firmware
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-16-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 2nZO8tTYpqapkNQmq3AViBu8ir0XPCAa
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6964a4b3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=irMkNu71nIbfwbNoXCgA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 2nZO8tTYpqapkNQmq3AViBu8ir0XPCAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX/Pjpgby/9Cr4
 EwbmIgzoD3naz84iYoF7GKSKrIL5fPPQiY88UAp+lzPm/NZSr/ifHemjidrCDVcCbPESrJxqPCO
 MxX4KRdnXdAG9rRhOL3FTMKsHKdNM0uSGgH5437JBNNcQPxDdVLj2GsdYnfvx+sxkU0455n+cjR
 imbGYZYSM2ahQR+tAkDCIejzqYbvD1mGdATCsvmInVC2QbrxGvij+lXhKjEcKfcGEHnbDu9lw3u
 r7/PLwLoA8GAseYHVYvabuCclBA3dz7kVz1LG564wDkZgnCPWUlvynRJdyV4JOkiTjeyqWEBuXP
 o+gnB6K5PFnBjWQ5izK+9ITaIKgcmJ/4VnBRwssLUq9/ZcbNDJzMDJThMxtpYmVpx4+K4H3QLrd
 5T7TzkLOIh5VKRtT0OY1CQfNPVY4LTBao05QOrUSMc2O5psibUMI9thyxiZhuJatGPWl9+kqiZe
 +fv2kI+ZVGqmmm1iikA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

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
index 0e1e6853ab85..cce3d699112d 100644
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


