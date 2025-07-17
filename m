Return-Path: <linux-wireless+bounces-25568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59451B0853F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 08:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2475830CC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACCB21770A;
	Thu, 17 Jul 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AgAS/Yxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AF215F7C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734758; cv=none; b=V4GqgcFLkiN07MmO2I09OjFfOX3e6YvfT8BqVLLRfkcqFhEDAHEEvocYt88sLk+S1ahjGKGL9QgXDL0P181VJ2IGdaXyCCEEK+5P2mJ6t95Gr4R2zXsDccB9sR1351gI/XloOTXGOrWpjqkVJKCkS+Qd0Hsye0t6T1VV0ZaZ/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734758; c=relaxed/simple;
	bh=C8gChGFYP63lgf8h6mxG9BUaC+cfJJshJuSBO7qtey0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow8C3qPEbznB9rwhXgiattTOqYm/Il1BJ41DCZcNTnI0CpIFEC/nCw4z8K7tv5PKABlLhbTp/g4mKmMj4wPxg9daNxRWaj15FAPqVqMFMUCB1gQnNvqojCGc1dOUn0qyNTAsgtPP3AYzvaXbGVghUiqovVVJusx6EnKQLzJJm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AgAS/Yxt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H5Nu9u032390;
	Thu, 17 Jul 2025 06:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fAmqNcdUlts
	6+yIAnzQ+osjh1QXPy/yhPbkwdiEyCWg=; b=AgAS/YxtO2Sxvww60WmJrvAv+M3
	HTBprjA19nbKbG87xz+YUdhsqCYlqgm/BGqoe0gRAvvQX/u9c4B2w3mHxUWYjivI
	/5ZO5bsose8AsPx2DLMwqGTAbRNAQ//zetGQF0+vRxEVrICKEcY3Lgwy2cnP/f/w
	1MJqqssO6BTWeZGqtEH02PPiNlIHkQfaqicL7JYiIkdpgufM2Rc7YPZItoIvc4J6
	rX1DarRCqnZBwYIOL2dukf1941DhwHH0ElBAqYpRgAMWqVRhw4E2Orqwie0xwQi0
	M8MH/KjOxsTGwrxusS/AvKfaSFtHG9CM8CWgWEvQAOoKoCvj7zpU/0S7Akw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug386phg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H6jb08010445;
	Thu, 17 Jul 2025 06:45:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 47xuvs03kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56H6jooX010926;
	Thu, 17 Jul 2025 06:45:50 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 56H6jnV5010925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:50 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id C741B411A5; Thu, 17 Jul 2025 12:15:48 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: Add support to parse max ext2 wmi service bit
Date: Thu, 17 Jul 2025 12:15:27 +0530
Message-Id: <20250717064527.1829660-3-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717064527.1829660-1-tamizh.raja@oss.qualcomm.com>
References: <20250717064527.1829660-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA1NyBTYWx0ZWRfX/WMiAuBL5M79
 F94zYwibf/JKB4gxiWy33t3BRE5+nqOQw3bRugvf5PuicMLiTgkCyqCj2LmcT2KU7gvzNEjL6uv
 od+a1F3dxkN27qPk5Zu5pduJ9GrbfNMyQwHyOMdm1ZMQ/1tJyun4zYVDUoQKFMopZUPPLCYu0oG
 kLJ1I/tlWnef10Po4/hBRW1OFpjSSAFp2ay6EsUwkNw0/AQ/6NCgnPCIc3Qere5vEPgLDBZLVBx
 UjXmL48ozFxfAswyG8d23mwJnYbaXfm28no2ubYWXDngujU/UrGV2SaRmVv3dI2gFhRDLL118bn
 zwmOAMwMmemhDt0pIDrnCKmvyCz5a9RApBgTYF0yQJwAOrS7xFl43y/mjqSI7M0l9M6O8menaiA
 AGHElzzaTRBDSWeo86i9/xtiK5bMqXuSaVkxo0I+lq16yuvSUtQ2f5gxpe6yuNOTPT9D2DGT
X-Proofpoint-GUID: TghpVUKxki9l2gL2uXWXGCix59iD1cj-
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68789c21 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Krp1D7qZmnOvLDOHkbYA:9
X-Proofpoint-ORIG-GUID: TghpVUKxki9l2gL2uXWXGCix59iD1cj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170057

Update the host logic to dynamically parse WMI extended service
bits beyond the current fixed size of 4 * 32 (i.e., 384 bits)
after WMI_MAX_EXT_SERVICE (256).
The current implementation misses service bits advertised beyond this
range, leading to not enabling some of the features supported by firmware.

Implement dynamic length parsing to iterate up to the maximum
service bit index advertised by the firmware.
This ensures all supported features are correctly recognized and enabled.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Depends-On:
[PATCH ath-next v5] wifi: ath12k: Fix using __le32_to_cpu() conversion while parsing wmi service bit

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 535c9849b98c..a2a493928d08 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7581,6 +7581,7 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 					  void *data)
 {
 	const struct wmi_service_available_event *ev;
+	u16 wmi_ext2_service_words;
 	__le32 *wmi_ext2_service_bitmap;
 	int i, j;
 	u16 expected_len;
@@ -7614,22 +7615,20 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 		break;
 	case WMI_TAG_ARRAY_UINT32:
 		wmi_ext2_service_bitmap = (__le32 *)ptr;
+		wmi_ext2_service_words = len / sizeof(u32);
 		for (i = 0, j = WMI_MAX_EXT_SERVICE;
-		     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT2_SERVICE;
+		     i < wmi_ext2_service_words && j < WMI_MAX_EXT2_SERVICE;
 		     i++) {
 			do {
 				if (__le32_to_cpu(wmi_ext2_service_bitmap[i]) &
 				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
 					set_bit(j, ab->wmi_ab.svc_map);
 			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+			ath12k_dbg(ab, ATH12K_DBG_WMI,
+				   "wmi_ext2_service bitmap 0x%08x\n",
+				   __le32_to_cpu(wmi_ext2_service_bitmap[i]));
 		}
 
-		ath12k_dbg(ab, ATH12K_DBG_WMI,
-			   "wmi_ext2_service_bitmap 0x%04x 0x%04x 0x%04x 0x%04x",
-			   __le32_to_cpu(wmi_ext2_service_bitmap[0]),
-			   __le32_to_cpu(wmi_ext2_service_bitmap[1]),
-			   __le32_to_cpu(wmi_ext2_service_bitmap[2]),
-			   __le32_to_cpu(wmi_ext2_service_bitmap[3]));
 		break;
 	}
 	return 0;
-- 
2.34.1


