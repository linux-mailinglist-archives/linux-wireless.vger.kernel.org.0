Return-Path: <linux-wireless+bounces-25619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C44B0934C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878E516BC66
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426EC28FFD2;
	Thu, 17 Jul 2025 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZOaIpl4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DC1F872D
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773766; cv=none; b=tb+mYCxMe8dY2UOWCsBzJDKXFms/TZjRmbFCZl7vNbbENMwvRnqAhbxhzGTUOsX69zqwZwT2YoDIFEzmIwEXejf11XdfKoKbU9WIjx2nhfYpiK3K5n53ewvfYxdDWp3wqtUW2i5f3qq9/DCyIiRSMdz+3vxp12Agi/MuJ4NRZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773766; c=relaxed/simple;
	bh=Z1TfGOJgvp+AXXNMqR2Hmwkw2Earaa6LgFD/GJxb1eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PA6ObQaL8ddyPXWdmH6hUNGA/QXLbhn9LFaa41vfeMmOiyPvkLXcLFIMwh3RW7ICTvoZHAFroG839nncJLVF2pjH/weSmtBT6uVvcCC1gtKmt0asr1sLGjHxIABd3KQKLaEsvJyIWRUVS0WY0tP2hwH2HFXx061RyF6/zRTNoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZOaIpl4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFQMkA016516;
	Thu, 17 Jul 2025 17:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=H0moyXYEsrI
	UbYrBVHxe6uChMaAAlhJVgiTpy6uNs+Q=; b=TZOaIpl43uCTfm4Vpk0cTz/pSmD
	3xO9ZgUkSE7IBcwuqTDOJ1udVNASMtvXRXrpEGsOk829dYchhhFqMB3dmy4lPWmJ
	da6Q/xpGrWIxRYchVKCis2MN9bwudlXbh3Eeq6nXNpE9AopMrAOj1RZ7YNJg2p0g
	FhPPvw0Be7+k80U4GowErKLzQty7GOXVN4LioedJFbGbW/4FkX7f8dTysidjdvBF
	rl3FqFkh4C0hPZaxWwXvz+B/D1804eoX23sH8kjlcKr7rdrLv8GdnFUOMV/eLi2E
	r7NvV+/nGHZrIf0EYcEY1D2DlwVjMNZnHHIbKaqHka4mFIY3IDju0fKaEvA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc0g8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:36:00 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HHZvhi004244;
	Thu, 17 Jul 2025 17:35:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 47xuvs3b9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:35:57 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HHZuAD004238;
	Thu, 17 Jul 2025 17:35:57 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 56HHZu6g004237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:35:56 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 0E68341566; Thu, 17 Jul 2025 23:05:56 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next v2 1/2] wifi: ath12k: fix endianness handling while accessing wmi service bit
Date: Thu, 17 Jul 2025 23:05:38 +0530
Message-Id: <20250717173539.2523396-2-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
References: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=68793480 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_lmSwQ0K4W1q_jVrfeUA:9
X-Proofpoint-ORIG-GUID: JU4I5NGxjXEy294XKUteAgvLFxHwGizE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1NSBTYWx0ZWRfX/pHtavwHPLe+
 dYeOVNph1nRjJ/LKhf8EfarRAIdrCZ0FjqpEPZVTex3SsPnbD9HaM1swYTv0GwIFDjHfi+4SGCN
 I3S7UQvZdz2VDf/GPN82REBOdbRC2SEIg2F56oVu/prTpAL6vy6iNZYdesDp5C7BdWSPYRY5KZB
 Aak2NsQskIkHJxAE4uGPtjwLy024To9kaYrHkQLErsxjcCv4A9F5r3EMWFTxBXbcSoy/9xc8QwK
 QZpH+009yXN6TPjMO8aI8PuRgUUeUPNKl9FVn8jcKfizXJuRtpu+foOl+T6x7cklqDCjYhye46V
 XSfj1hpFK41vb2ABV0vBq46ApTV39FGnNgeD/eAGEmZxaCz+Yc+HWMi2GdWFK817Ua2PQDPxSOG
 EJ2SmnbXPHKEEfRJ30iR+OsGMUsfiukgVmTMkJ6lo4zy5yrhgYPIegqqJXjIYGEbGrelFCzv
X-Proofpoint-GUID: JU4I5NGxjXEy294XKUteAgvLFxHwGizE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170155

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


