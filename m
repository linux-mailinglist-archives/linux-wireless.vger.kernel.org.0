Return-Path: <linux-wireless+bounces-25567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B93B08541
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 08:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC131C234E3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FC1FFC77;
	Thu, 17 Jul 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HyqffhhV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C6217F36
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734749; cv=none; b=fOUMpdYB/+Bo0p+Fyyc3fxW+G1oDE7wXrZY6bHCVWBkw3CFwYiJ61tCaGei3kLbIlCfUxGLjfencFvMzNsARlyVYvthrmF1MzgX0hlbK4Yh93VyIALhtKn+7H173XQXEHlL+uYjFxksjDpD4s4Hhg9kiMVt9620q9u27jR/lGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734749; c=relaxed/simple;
	bh=Z1TfGOJgvp+AXXNMqR2Hmwkw2Earaa6LgFD/GJxb1eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6dfHU95ukzC0FQFOCrtpxJwtXkPZfpv9D04NQTWjTy7wN9Xhbb3LM12H++3zXN7Gq9I74+g0D5ubrYynyyYDaP8BhVjsAH9Y3pvwvicLCpZRcZl6ZiOl5E+yMhmO13ybO0RCIaSo6hDnAxyCqZRzbI3BC+yVQN/C+iTNsyQlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HyqffhhV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4RAU4021258;
	Thu, 17 Jul 2025 06:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=H0moyXYEsrI
	UbYrBVHxe6uChMaAAlhJVgiTpy6uNs+Q=; b=HyqffhhVTBiZFSH4Qzf0hQQABGG
	kUva6UoixqgZELovCLg/yr475r86V1d+N91pEJ7gn/2aYFL2eyjLVdZpq9/0lCWG
	lRbP85srz7L4yjIKjo49UICDguPYfbsnOh1pnq5wJ8pwmYv0PObn/qcWsYAgRA3o
	0BXfuVlhfSZHQoKsuvKjFILxhPyVVPEAjwZgVMQsC8VpdDE9C0r7ULbV+iA8g3Cg
	uzAwtRaD1JehOWVLzvLOauAL0XLmmXlUadjy3rOi3CTkeVkaXpf63wrsVnz4EaQD
	5ztPHJr22oJSlRAnojH7EOjKzZ4o/zVAwWGTm7TxL4YeawThlwKJwProRvg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dphk6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:46 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H6jhZR010896;
	Thu, 17 Jul 2025 06:45:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 47xuvs03k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56H6jgZt010889;
	Thu, 17 Jul 2025 06:45:42 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 56H6jgLW010888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:42 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id D5396411A5; Thu, 17 Jul 2025 12:15:41 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: Use __le32_to_cpu() conversion while parsing wmi service bit
Date: Thu, 17 Jul 2025 12:15:26 +0530
Message-Id: <20250717064527.1829660-2-tamizh.raja@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA1NyBTYWx0ZWRfX/i/z4DoNy4wV
 gP0gEd2aGy/oqbmj8juSrs+oQFU9Z8X06l7qXJeZokdOJkElfb2OTY4jdbLVOAEaTVOYCsL32uj
 cqj24I+hXTWnnvvKsIo/xHLBK6sQmyya5gl3zqNmVw9JisDDStiv+/cjuDwgibps1FM1PxBDBYa
 oBEJZQTBkhW+dLNonCczgYn0MSp6IXqOgKgo7K+Hbe3i6DtmVC1RXhmGuTuzNOBW9oID82byLdH
 9nE/qMqgP8lv8cctJRRBJrrxRx/oZYvHr9baco2cUumBNB7rqasK/tD3l/G1C5fPlEUMA8vBXfo
 ricGiziP3pmqhNb+2t6NL0Hp2mkJTMldMF4A4Wyq6N5PKuVgBvmhDUek2Ox4/g3bMCzCPi/OmgM
 T++CizAlJPdmQkBK94xdgtfiN5m4x4Z9i2N/0ujYEPOfUvvmZRKSOQNB75S1tIg6hHMToNHT
X-Proofpoint-GUID: TYaK4aVLZdpxcOag-tK0hbQZ-sP4mXie
X-Proofpoint-ORIG-GUID: TYaK4aVLZdpxcOag-tK0hbQZ-sP4mXie
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68789c1a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_lmSwQ0K4W1q_jVrfeUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170057

Currently there is no endian conversion in ath12k_wmi_tlv_services_parser()
so the service bit parsing will be incorrect on a big endian platform and
to fix this by using appropriate endian conversion.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 342527f35338 ("wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory")
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ed3c08dbd899..535c9849b98c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7581,7 +7581,7 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 					  void *data)
 {
 	const struct wmi_service_available_event *ev;
-	u32 *wmi_ext2_service_bitmap;
+	__le32 *wmi_ext2_service_bitmap;
 	int i, j;
 	u16 expected_len;
 
@@ -7613,12 +7613,12 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 			   ev->wmi_service_segment_bitmap[3]);
 		break;
 	case WMI_TAG_ARRAY_UINT32:
-		wmi_ext2_service_bitmap = (u32 *)ptr;
+		wmi_ext2_service_bitmap = (__le32 *)ptr;
 		for (i = 0, j = WMI_MAX_EXT_SERVICE;
 		     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT2_SERVICE;
 		     i++) {
 			do {
-				if (wmi_ext2_service_bitmap[i] &
+				if (__le32_to_cpu(wmi_ext2_service_bitmap[i]) &
 				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
 					set_bit(j, ab->wmi_ab.svc_map);
 			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
@@ -7626,8 +7626,10 @@ static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
 
 		ath12k_dbg(ab, ATH12K_DBG_WMI,
 			   "wmi_ext2_service_bitmap 0x%04x 0x%04x 0x%04x 0x%04x",
-			   wmi_ext2_service_bitmap[0], wmi_ext2_service_bitmap[1],
-			   wmi_ext2_service_bitmap[2], wmi_ext2_service_bitmap[3]);
+			   __le32_to_cpu(wmi_ext2_service_bitmap[0]),
+			   __le32_to_cpu(wmi_ext2_service_bitmap[1]),
+			   __le32_to_cpu(wmi_ext2_service_bitmap[2]),
+			   __le32_to_cpu(wmi_ext2_service_bitmap[3]));
 		break;
 	}
 	return 0;
-- 
2.34.1


