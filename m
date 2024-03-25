Return-Path: <linux-wireless+bounces-5250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12888B29E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 22:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532731FA2F34
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECE6D1CC;
	Mon, 25 Mar 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cQ6FnD6N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C06CDBA
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401805; cv=none; b=EcO600KsNspYDi3vIGiKFnP0lF03+JEWGGYR0v5peeXIIjZ/RcGCARXL9abmMiew23swo5pguXd3ehRGbbG0n7THcUNWFCpsDomCTtZj5HjnHjamkm54exRz5ictYE3hlS7zI5tqLJibfm/w5Lh4Teq6sulXGly/WjLldPbHkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401805; c=relaxed/simple;
	bh=nPvLj7qD+535NCferRgrgIU+ELfr0Efb/fYKyMH50Hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOiis1RQXSlocYjRJNiz7HqKV/ITG4EXMBoz5gIcJoDTMbpqJWnqTFGuP68aMsI8GGHRsX+rU5ndkrnRseGD17N/DPFDoEBJOKog8sZt5QPPw7TzmONPFuDIedgAZxeFOK/jO7tE05GJEe9S3HJcZpiiQSolhPdg6Z9UhxT4lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cQ6FnD6N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PKU6GZ005904;
	Mon, 25 Mar 2024 21:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=sxET2FS+KYKMC/BDlH1o
	F4lG1tavRQGIOVk28GXdDn8=; b=cQ6FnD6NswIpKufAGqFhLzuJo5fzfqrv2eb3
	EbSfCa9z1LT/YC+E0A2lid0LTkQSmIMLrDCMhOQ4cHblZoYBpWWMv+7N4EgBUZ81
	3B1dQx+wYuDqu2YN3lVc9isEnj1lBpLghDd080Gl9NPUyIFay4FTzS4jPvQkECW/
	8lFA5Gll3Jvff0cSb9Z/tFfMW2vlBxcBAu3wNJDAmMXJkP77MxQBw3iMt3KZyEE+
	JW2Mt3ybGnyhV2enh2ftXVaw3nLbhcQEVzpV1VQzNEd3+GOTIDatsAaJEMfegZtu
	dbPORnIcURDBbCsuKTph3nHxU2tblLUSEQ/ggRZPq2hI0wBKEQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x319ja5t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 21:23:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PLNHpb001587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 21:23:17 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 14:23:17 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH 1/6] wifi: ath12k: add channel 2 into 6 GHz channel list
Date: Mon, 25 Mar 2024 14:22:59 -0700
Message-ID: <20240325212304.28241-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lwd6GBsnfePREWwxQ6lo4_UoUam-i2dG
X-Proofpoint-GUID: lwd6GBsnfePREWwxQ6lo4_UoUam-i2dG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_21,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250132

Add support for the 6 GHz channel 2 with center frequency
5935 MHz and operating class 136 per IEEE Std 802.11ax-2021,
Table E-4.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

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


