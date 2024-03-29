Return-Path: <linux-wireless+bounces-5607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3538922E3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7D6288F9B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838753E28;
	Fri, 29 Mar 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BrB+zohV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7F130E2D
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734015; cv=none; b=mmhA0018BSYTlAykm9TuN1HUFIQU+930tPPk8z2pztM8raJoYtlPlMwSGTpercEc8Lq4F+x1ZEOonAJV5zwLP2H96n4H9KskjVwt0wgDSXB0NfxdocjPKVfEGNYiCCpZ93q+nTGdmWwO9n+DpjgGam4yByBR17dSSdCS6F1E1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734015; c=relaxed/simple;
	bh=enzbxf5nhJTKWZ/9bAfnBAYHcIdluAoLNrUfu5q7FgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx1Lf1j/p8TmiGxdPixY0dpMRpqractJL51zIto5c+dtDZAd2U0p1NW2QsXAbw9D252qgscIQHuOMUT1NgXZM5tw92+Cudyg5RGLQgfzCDDvxcKl5iYvFWJmSgAcShyV/+3F216dsQR4VKm8XwyGNT7RUODUbMmnTdS2Pjv98DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BrB+zohV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THVN85021944;
	Fri, 29 Mar 2024 17:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=1tBRvBwOGJBADcjAsEXj
	/T5ylMJxcWkLND6Vn10ZXEE=; b=BrB+zohV2l3Wpg9pU33nCBkvbokcUnl5lGlC
	sepV6nWYgx4XkNFp2Y4eR51I9NhbetETic/w9hWqxQ739ZrW2RGbEaL8A/5HEkhI
	FAYGMz3UDFQZG9ekX0w97wG74yAlrfuFpEDrx0nMsOml48f+kDeraixk4uCESKI7
	KOoVVT3Ip3Rr98i1+Zv+xh6C7GIfJemRB0eqdLN1CafQl2HFg9qr04afBaZ0Khoi
	gNKBUQiFKwyb7ZykwXZpqouvmamNppYRWQANsm+KZp7xnlNfWWz5IwA+sr+SVIF8
	lDJ6Aesc++67cPVqKGBbCYGEXudZ1mKWHJ/ZoLARtdOLtJko2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5np2a0jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:39:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THdbms008129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:39:37 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 10:39:37 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v2 1/6] wifi: ath12k: add channel 2 into 6 GHz channel list
Date: Fri, 29 Mar 2024 10:39:21 -0700
Message-ID: <20240329173926.17741-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: vBKDoRx0dTYsqdouLgeZdR4t9BbgjJE5
X-Proofpoint-GUID: vBKDoRx0dTYsqdouLgeZdR4t9BbgjJE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290157

Add support for the 6 GHz channel 2 with center frequency
5935 MHz and operating class 136 per IEEE Std 802.11ax-2021,
Table E-4.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..ea5d0d9b54e4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -430,7 +430,7 @@ struct ath12k_sta {
 #define ATH12K_MIN_5G_FREQ 4150
 #define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
-#define ATH12K_NUM_CHANS 100
+#define ATH12K_NUM_CHANS 101
 #define ATH12K_MAX_5G_CHAN 173
 
 enum ath12k_state {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 52a5fb8b03e9..b91d34b602dd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -90,6 +90,10 @@ static const struct ieee80211_channel ath12k_5ghz_channels[] = {
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


