Return-Path: <linux-wireless+bounces-5235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B50A88B5EF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 01:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A80B24602
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168A44C86;
	Mon, 25 Mar 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jxKgdywf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CA4085A
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397455; cv=none; b=i2pI/gmVouKGfdxp6c4tZsbGfAPxGNYwQLFh8uvPA3VW85VwB/r6rfOHrVnScGyipJ2hEsnr1mFqFYxb16rqo/jOFmjOYnNiQlCtEg4+ARkiaIevJ2nhJBNgA6fVz5jpl1wpvr85Dyk6oT2dRVgBSXLpSdg64Et0/9eMGwnbhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397455; c=relaxed/simple;
	bh=2dnOs5Fc2UIa8VsSEQw64+OoDkvTPvIh1OE0FDAWgFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzi9XqQexFbFo1/s8t+o2Nm17XtOGXmHRVt3DffKqcylNYPxc3t/iNlerq04QImnSeSnlGHI3KTdBQqwMyX1qoSqgCzEZqxXCtk/J85Jp+aZ23Ss+eJR3oBTUmfbUfw8gBfSHucWSYOVWLxNiu9pf3UsqplVL4wquzO66QNPdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jxKgdywf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PJbFJU010701;
	Mon, 25 Mar 2024 20:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=unWQubRctMGmSYwgWsZJ
	eqWfvdthz0IrIuSp1R7DB0E=; b=jxKgdywfSXxwms4oaLlNMG5l3Ydk3Y/n4hCT
	XuySzTPsCk8dNVFMjUkVq+aB7ZpPsAQbDen90rz7oLH4sEIOtIjN/GGZ/ckd8rxA
	ssC3qmA8nrygXloRaReUDyMUGZgsCZq2iBwyOf4VqcbVh+agzC/njFmJCXXL1lPD
	Z4wEXR9CO8l8y2BBR2nCRUz9+irehz79aselYaMtBTtNRD60EObSiFCq3H1LCnS2
	f8Cdu0Hb56+jLCPNfUXBuURz0PmnFzy0WuK8YYqsbywIobD/nB0cEy1rhBvbabOP
	Ksc8kd+sz3ar9vcqBALxK8u5xrwNjyUtLQAzCd/Q7ZhnFuM5mQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x31wst32y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PKAo2m009637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:50 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 13:10:49 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
Date: Mon, 25 Mar 2024 13:10:22 -0700
Message-ID: <20240325201031.10837-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: Lp32h0Ifdn8skt3hCO-_Ww65vDfkpMtl
X-Proofpoint-ORIG-GUID: Lp32h0Ifdn8skt3hCO-_Ww65vDfkpMtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250123

Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
to pass EHT MU-MIMO configurations from user space to driver in
AP mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/cfg.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..54bd2a988d91 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -701,6 +701,9 @@ struct ieee80211_fils_discovery {
  *	beamformee
  * @eht_mu_beamformer: in AP-mode, does this BSS enable operation as an EHT MU
  *	beamformer
+ * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP) or transmission
+ *	(non-AP STA) of an EHT TB PPDU on an RU that spans the entire PPDU
+ *	bandwidth
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -793,6 +796,7 @@ struct ieee80211_bss_conf {
 	bool eht_su_beamformer;
 	bool eht_su_beamformee;
 	bool eht_mu_beamformer;
+	bool eht_80mhz_full_bw_ul_mumimo;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f03452dc716d..894c7b6ddb0a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1379,6 +1379,11 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				(IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
 				 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
 				 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ);
+		link_conf->eht_80mhz_full_bw_ul_mumimo =
+			params->eht_cap->fixed.phy_cap_info[7] &
+				(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
 	} else {
 		link_conf->eht_su_beamformer = false;
 		link_conf->eht_su_beamformee = false;
-- 
2.17.1


