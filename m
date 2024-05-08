Return-Path: <linux-wireless+bounces-7316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3F8BF388
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 02:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC51284E85
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5A4C6E;
	Wed,  8 May 2024 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lJOm/OTD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258304C69
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127673; cv=none; b=ntTI9E0B2mfM3+CX13j0JPeEEuGs69me1xVagtnLwtKkcpAdKRA9neGss/JA2dg7ImphofOWEEskGJzWgvSkL1xNjDP1u8PURkd0P0awAIFK83cZs9zsbXwMkpxwhWhlvFiYFBIRm35X+ovk5Pjl+KF5Dp+0AOHYhj8Ds1xp38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127673; c=relaxed/simple;
	bh=UlrAsBLyb1dX/l45CH+B9YNm8OA4SNsGNRYluW9G4u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFTo/mDQ7xzDJYi/7obUSDRg7szyjTXVRlsqyRnaR1tvuVSgan5YmU7/qeUqCvQuE809c0OlI63LB2Ijq+grrchjwbvq9X39nMj/6+F93IEMWrL4IM73YVLvkCp3qZLpWiDZcxPTe+Khgt8IywVIBEtE09dVbm6b+v/Gd+bApDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lJOm/OTD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447NvYSc018332;
	Wed, 8 May 2024 00:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=bG3sTq8SrX5HPqWXA803
	bWTYmu/m6PjvsR+yYULmeqo=; b=lJOm/OTDUoHWbPSr4Oc5KKkEftZ5pXV/plDJ
	8MRpwidjms9kNCQOhK8zCZlqouOA8pVELwxTiopp0z6L6hXg31baHceudAR6LDtJ
	A4ZrBgr1wqFuzjYy0JSzodfp9lA/PqK6FwSTG8owDXXKATdjPCeAznexC0nRQYCv
	1tAokOZA9jJHUAapZaZBQ06+RijF9TAUBkwnTlhfA6UL5kkVPoS0EqtAOaOjd9Aq
	UtCHtMGi2RL/ls9C4SF0TOXHCQhfAcNF5KaiazZmlzl6uwLvyvkLepSFv0/853MY
	lobFa8oF4hKsC0DnHmDgx3KOs9xhgim45uVxQI/D0BCI5nCcfQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysg9gkxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 00:21:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4480L5LK021159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 00:21:05 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 May 2024 17:21:05 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
Date: Tue, 7 May 2024 17:20:46 -0700
Message-ID: <20240508002055.17705-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: yBG1aYieLpnofD-Z426WKG90OVQs508-
X-Proofpoint-ORIG-GUID: yBG1aYieLpnofD-Z426WKG90OVQs508-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080001

Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
to pass EHT MU-MIMO configurations from user space to driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/cfg.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index cafc664ee531..d7b6f75bc920 100644
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
index b08e5d7687e3..96b2f31f0c8a 100644
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


