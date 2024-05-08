Return-Path: <linux-wireless+bounces-7353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F68C0346
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E98E1F22711
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E812B143;
	Wed,  8 May 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B2tE+2wz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6C20309
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189844; cv=none; b=di/TzQLPgtN0aQCjWPDk7hhna8kAvDSEujqIVy6IzTP58LhqvmRvDGBGnmy3ZEl6ltYqXUc+5nt/S4GY6qP3B4uk+3WFp9p6SoPTrxemdspKKwEmAhwUbRFxqtujOK2rh+o/hDmRUVRFToVrQ5J9BydsipTJFMcC2f1eIl4Vbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189844; c=relaxed/simple;
	bh=CqmS8AArbMo63VQXxjvu7F+fmVim+if67UnbeCe2/eU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdo59ZYj2NFtSHp5NP2k/xqZ8b3J5MpIpa4dGlf4eyhfaxYrTOTZgdvgsv0VAj1lZbWGTSlGTQLGGWFWpqXHQzF7BhUpIkTu98SDgStIWI9L1wZOQiFLV1hHxO8pHTivfxI6vJ4T4S8Dv1BjSq50L6+vgZzH+OARdJLFb55kVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B2tE+2wz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448FEDSw002378;
	Wed, 8 May 2024 17:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=v437SRpFXTG8An2e2fEX
	ByzUV+VVPxzUsB/uKSJEE1s=; b=B2tE+2wzctSewFZoUsNDF+rtvkBsjeURF9oG
	m297aYDNlBTdfh3/MnXXDolrWhs4NUDyTW1FHQtxOrH+hppRMml48TU8xkPqZzXx
	Z4KyE+CLjnWYEIx3WC+U8uGLWYSKSP2QRbqDHlBjsTrPa+hjN9zavYYocf015sGp
	hdba7RflwBt+EQOHIf+Fn0sXS8z0SXXZGqK4pR8oA1uGzB1y8gJ+cVQhIVgWuaI6
	yYxchM2wEMm52ezJ1q173T9ckAnx7Ilxwr6jeeevECGqsEO2wBD87/gwHaj7Wv/a
	Nf6M9n1l3yIIrhCZNQjZcal9jq532w7LQOieNY6VfIPPjKChNg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07u8ryyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:37:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448Hb78N009054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 17:37:07 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 10:37:06 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V5 1/6] wifi: ath12k: add channel 2 into 6 GHz channel list
Date: Wed, 8 May 2024 10:36:50 -0700
Message-ID: <20240508173655.22191-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4qNpTfHiZHU9xwp6TLPYOgC0_6of1AOB
X-Proofpoint-ORIG-GUID: 4qNpTfHiZHU9xwp6TLPYOgC0_6of1AOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080128

Add support for the 6 GHz channel 2 with center frequency
5935 MHz and operating class 136 per IEEE Std 802.11ax-2021,
Table E-4.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bb6c1b562baf..50aa9048fd34 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -450,7 +450,7 @@ struct ath12k_sta {
 #define ATH12K_MIN_5G_FREQ 4150
 #define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
-#define ATH12K_NUM_CHANS 100
+#define ATH12K_NUM_CHANS 101
 #define ATH12K_MAX_5G_CHAN 173
 
 enum ath12k_hw_state {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 96dc5c2e096f..ae9f41a17b4f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -91,6 +91,10 @@ static const struct ieee80211_channel ath12k_5ghz_channels[] = {
 };
 
 static const struct ieee80211_channel ath12k_6ghz_channels[] = {
+	/* Operating Class 136 */
+	CHAN6G(2, 5935, 0),
+
+	/* Operating Classes 131-135 */
 	CHAN6G(1, 5955, 0),
 	CHAN6G(5, 5975, 0),
 	CHAN6G(9, 5995, 0),
-- 
2.17.1


