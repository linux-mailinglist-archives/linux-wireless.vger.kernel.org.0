Return-Path: <linux-wireless+bounces-25846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A2B0D6AA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A68A562E20
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340B2E49B5;
	Tue, 22 Jul 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W8pVUBhf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA82E3B1A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178394; cv=none; b=JhzRLj8XODi6KFf4gcT8BwhZBLp4ACp9UtBeVMvQ1/+cM76z3vARts9k6Aesn4QnoD+eeD/L1tkW+Vq+PiMDBO5QAaDadp8n+PXGFCIKY8xkpP9v2MsVYN1KP8rzIWgwGVs1ryu4aiAaCH0g77gucRYomGz5O8onrYGDT6zD9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178394; c=relaxed/simple;
	bh=Lp+vf8okiRNCoE/TLBR8T/7NAqXjfMFZA0caP97fSUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en9nIXCnEq1EzIsbWeMh7XR+CpQ8oUeLPvaU/jPQVlxjXZxA4XFO3um6i9MwYzDnrJk8Hh90b5rCBUt3XfCq/dtgprcvp5XE0yNQNvH0LMHQa6yl/I06nvf3VtKWpt0gYn0dz8aYdOBfME1thW2tg4DbMFVLCU3gc/k7ukCVTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W8pVUBhf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7Tbek019401
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aj79PieGARi
	ZfwhDrQgy2cSZLlx8dhj+pl1ql5MnxsQ=; b=W8pVUBhfAL5Sgj+csK+dtMiLABD
	R0ydHDak8gOpB6JHzTM7irkxaa6UA80wYUhSenpHZZW/ltuPFiQSVEIhG/BgA4kJ
	0iwWiy1mQH+K9Jk0gSHNPRxKN+wz9pW6AJjD6umBl2ChLWOEYaWJvOERP/O3QF2N
	kFhWOsuueT7QUxBmLsfRfVgeX+kGUA6NgsrL0RMELTov24K3w7HnEeXq3yqVvUqe
	AXnLs2ielviFeNFeWGCPt81Rb8uP9Uuzl4uGft3S7wy68luC5O0zdE8shtZcflSS
	g09WHO5xk2SNqhhDI4aGA7/n9oaN92+5AyyR1S7bUOdUvBgZRZL2drd4GKg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9ycgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-756bb07b029so4890094b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178390; x=1753783190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj79PieGARiZfwhDrQgy2cSZLlx8dhj+pl1ql5MnxsQ=;
        b=dYl1MVSK4Dz7CsPC/Fvowj5gqREn4jaXphSHwwKvc2BazuK+57fB9+i2myf+IuYAPl
         S4N6nfmVBlH/C9i7IjH9FhFmJcT0Ne14r2lhRIuadUy/TxedY5+goqKOWfNoYG+LEqg+
         DfDGlU/iZ3tKgoTDoLDzDoLfVGvMgKJ5jAkUfl1hITTsQ16rTzWUU+WDWFLfsl4kgWr5
         az/im1B8dmCT/ZJeJU1hME1ctnsUkFvaO3xb3TKWwwfXObUA1ezDweMHpeEISrj69yIg
         8lcNXID94CSNZg/DO+9ZYlDTEoOx8jZ6I3U2+D3V+ykAvDHnFzYGWGzFy3wcEMTAAd/B
         +deQ==
X-Gm-Message-State: AOJu0Yy1JrIT5sQy+vPJqVS367PnN0Kg7Pt3aRSMd3CBNW0tTkN6S84w
	OVQ4QPNTjra/Uj95Jy/xsjrXYVt2plYwhHUsk6Yiod6sW+h2t/5x8Xq/E8fA47iVZ+6ubKPJ8EF
	PZEvL5u4PVD079ZhL/7uD7KZlrlumJyHGaopEJiulvv+45DNK9LRYF2u6HTYkBVQpEzs9BKLVuF
	dzuw==
X-Gm-Gg: ASbGncv2FZQkM4pIUdEpEbsbZ8xW/FSGQC7Bi5u7vzec2lcRNv8yQ0hGmZHpSk/Ej2g
	RiK+yGFVavtxD3xB8fIZdk07JTSRMmiRh1KTUr195tBev5ql0L3NfP/ZM5DRmfKgwRSzAgnV/Lt
	z41PRl6eEit4jM0sZubLtR0CPcieKZQTuC9Q7OCBvpGmMm8bPmiSI0Y61zxkRdZr0tgTE3qjPXw
	nRwk7cxwkA+L7h2G9syIsLuQ1VHBqpgjFeN+EBNYGFp92iu898r7NPBfrrcdtfCiQmFh9hnBOre
	6sMFk8nWyRiZeqSIMG6dvizcqSz/k3MnFMOxrgHQ5D+tr8PToPqeaFHP60s6Ogb2DJLLqnkKTO6
	6Y8bZoetSVmD05tBMziJa3aB4mYjMOnWwlokV5PF8FWIpGSp9XUb39g==
X-Received: by 2002:a05:6a00:1795:b0:74e:aba0:6dfd with SMTP id d2e1a72fcca58-75723165609mr27571460b3a.10.1753178389733;
        Tue, 22 Jul 2025 02:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyVQQrmdrLoL+4w72T4NauTszr8oWNCq1bc3lzC6QKz/ngrBTTIWf3c3XIh4tU5z3hGY5GEA==
X-Received: by 2002:a05:6a00:1795:b0:74e:aba0:6dfd with SMTP id d2e1a72fcca58-75723165609mr27571428b3a.10.1753178389147;
        Tue, 22 Jul 2025 02:59:49 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d6bf2sm6851065b3a.53.2025.07.22.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:59:48 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 3/3] wifi: ath12k: fix the fetching of combined rssi
Date: Tue, 22 Jul 2025 17:59:34 +0800
Message-ID: <20250722095934.67-4-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
References: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MU-wSJmyofk4d1HF5GNp6ux1xZTBguld
X-Proofpoint-ORIG-GUID: MU-wSJmyofk4d1HF5GNp6ux1xZTBguld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MiBTYWx0ZWRfX6yF0g4uOXV1J
 tA7NjsaYoNzZSk34XpawgQA7WOiP1McfqHAAOPsvMt/gEIbrvm/6UgMuNjuRQgWViaFquDDYqXo
 WuQ/nyZtJQlRMfZvKwhg5YGVB6koeG6oPioaKqbNJ+DhcLH9crDvsJtM1x8kmv9dShDQJZLJ0MG
 U5vdcxqCcVsYRHV3W/v1yYHq2yOXxla0ZGRMJmCTTzhLMRJtPjJpYAGBqqMGFSqAksRD7RutF0I
 WHD6IwGsCTfQX/p2KzMrdGS7YgTpoEE1uBJ2JgnM1Ni1BI59X1tYz7yXu/GJgiJ1gvIIX7QAvMv
 DmygAEBT4xEhkBTzbwINpO1SN+Tl16aCnnAbrJonXObHo+G9BAmmJlcEAqYjDRj8RYUaCs8B4w9
 10q4tA4IhO89Pr7jCf5p+3XWLg2FWLeckvP+ounQj1EGmYtPuhiJMhUwB9jXJUqTzNY3bXj4
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f6116 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=srnJkZWzPy4--ikV3L8A:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220082

Currently, host fetches combined rssi from rssi_comb in struct
hal_rx_phyrx_rssi_legacy_info.

rssi_comb is 8th to 15th bits of the second to last variable.
rssi_comb_ppdu is the 0th to 7th of the last variable.

When bandwidth = 20MHz, rssi_comb = rssi_comb_ppdu. But when bandwidth >
20MHz, rssi_comb < rssi_comb_ppdu because rssi_comb only includes power
of primary 20 MHz while rssi_comb_ppdu includes power of active
RUs/subchannels. So should fetch combined rssi from rssi_comb_ppdu.

Also related macro definitions are too long, rename them.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 ++++----
 drivers/net/wireless/ath/ath12k/hal_rx.h | 9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index e93ede5e6197..abd611ac37f0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1655,18 +1655,18 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 		const struct hal_rx_phyrx_rssi_legacy_info *rssi = tlv_data;
 
 		info[0] = __le32_to_cpu(rssi->info0);
-		info[1] = __le32_to_cpu(rssi->info1);
+		info[2] = __le32_to_cpu(rssi->info2);
 
 		/* TODO: Please note that the combined rssi will not be accurate
 		 * in MU case. Rssi in MU needs to be retrieved from
 		 * PHYRX_OTHER_RECEIVE_INFO TLV.
 		 */
 		ppdu_info->rssi_comb =
-			u32_get_bits(info[1],
-				     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB);
+			u32_get_bits(info[2],
+				     HAL_RX_RSSI_LEGACY_INFO_INFO2_RSSI_COMB_PPDU);
 
 		ppdu_info->bw = u32_get_bits(info[0],
-					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
+					     HAL_RX_RSSI_LEGACY_INFO_INFO0_RX_BW);
 		break;
 	}
 	case HAL_PHYRX_COMMON_USER_INFO: {
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 801a5f6d3458..d1ad7747b82c 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -483,15 +483,16 @@ enum hal_rx_ul_reception_type {
 	HAL_RECEPTION_TYPE_FRAMELESS
 };
 
-#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RECEPTION	GENMASK(3, 0)
-#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW	GENMASK(7, 5)
-#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB	GENMASK(15, 8)
+#define HAL_RX_RSSI_LEGACY_INFO_INFO0_RECEPTION		GENMASK(3, 0)
+#define HAL_RX_RSSI_LEGACY_INFO_INFO0_RX_BW		GENMASK(7, 5)
+#define HAL_RX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB		GENMASK(15, 8)
+#define HAL_RX_RSSI_LEGACY_INFO_INFO2_RSSI_COMB_PPDU	GENMASK(7, 0)
 
 struct hal_rx_phyrx_rssi_legacy_info {
 	__le32 info0;
 	__le32 rsvd0[39];
 	__le32 info1;
-	__le32 rsvd1;
+	__le32 info2;
 } __packed;
 
 #define HAL_RX_MPDU_START_INFO0_PPDU_ID			GENMASK(31, 16)
-- 
2.34.1


