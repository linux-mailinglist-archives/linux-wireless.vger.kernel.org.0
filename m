Return-Path: <linux-wireless+bounces-6896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A48B2CF6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF71F25079
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A915622F;
	Thu, 25 Apr 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K228KcHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DE14E2F9
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083560; cv=none; b=iRYE+Mij3kizAjQ1gzTL0eKoCMJU3g5XpQkYCHPhP1WdqDdRo/NMqtEIrWRnrpsbn1CnLrpPxT/FEmHRwTNiGV05qZLpoZtn69Bb5QIQ5mBiN8Op98YhuNKY79nBlncD8IWTh3IvBhj0VUK81VOlVEE/JkEI/zlCqBcXU70A6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083560; c=relaxed/simple;
	bh=Gn78c/+nx7gt2BDBdl7Nh70qxbxJMKUIhtmS7e6GQvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VreVSHkDXk9X/lYwy0oCDlSTiur345y7Mw3AGlzCpZEkDm0hIj3Hgo3VEphuh153UFfuSggcFIyAK1xAbCMD/AmYQJzDPMErzTRbbE0QXYhOLHYvGhQQi6o+NuFqxCJuhzBjCVXICYc/IEXtjRf3UPqF/4FHsUK3nHZQG5hhuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K228KcHm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLQgac028375;
	Thu, 25 Apr 2024 22:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IQmhcot4nJJtfBphKCe9
	Hf+NF1jje4b0EYqMdqTjSWU=; b=K228KcHm4iEydC1KbjqGoD3LdnDfIpRIT8/m
	RA1Bdj4G225KJm/JO+AdCeSLhlDrBsuxnuzkExeW6/PDJTdsHUtuqF0pmYZqj8Nz
	XwOHYig5fCteJdCEbxRReRmwZVDj/gRAtG+lvc5Fu5ViXGvLbnMRfvu5xFCos1dy
	nEmzE41+aDDxiAfr26rUxgBm8H0o5E03ifWD5tvYSWJHA4cXiTrGMbCMUXq2jDGq
	Z6RvN65sm062uoz56aa4MxtpcKcZi1cm2kaGnoQXeGflDO5o5w2soq7yux1BKLgb
	8YAsh1yI9jcuMtnWU8OHGwa10QHPb0jgV9dDyF7roIeLIbvl8A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhuv53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMJCRt017339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:12 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 15:19:12 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 1/6] wifi: ath12k: add channel 2 into 6 GHz channel list
Date: Thu, 25 Apr 2024 15:18:57 -0700
Message-ID: <20240425221902.11553-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
References: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gdbFt_MQVzfrIBBg3dh0OkjrXELHG3CC
X-Proofpoint-GUID: gdbFt_MQVzfrIBBg3dh0OkjrXELHG3CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250163

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
index 47dde4401210..5113b630ffee 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -454,7 +454,7 @@ struct ath12k_sta {
 #define ATH12K_MIN_5G_FREQ 4150
 #define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
-#define ATH12K_NUM_CHANS 100
+#define ATH12K_NUM_CHANS 101
 #define ATH12K_MAX_5G_CHAN 173
 
 enum ath12k_state {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 56b1f8b6844e..b471b27d6594 100644
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


