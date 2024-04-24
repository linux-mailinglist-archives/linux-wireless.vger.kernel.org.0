Return-Path: <linux-wireless+bounces-6784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA08B1469
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03E61C21539
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946613C9DE;
	Wed, 24 Apr 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gXCUzo6r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449B13BC19
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990018; cv=none; b=IH51SiM9W0ffCqG41LxwxCwsaLlyRHnlr6EHXsuGJlFVaJEI7TQZKyVnIzdTRdSfTiZSdCepynamgvWTxxnHUIzPwHLcA7AcBk+9ytlKYWVohhY6KcZ9tsll1bK/qL0pBLmifUuAqORHRSc9Ij+T2YAHvQR9G8uZkcBweI0V8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990018; c=relaxed/simple;
	bh=cMZwhkZ9i36g8LCkI0wBudpgVoht9Scd643JYJsz3dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeYetlumc/cuJ4WvixAMEg7mwwOrXtjQDTi/qlSiNAY7dhbXAf5nd2eGhAO+KoYJcWKwkmXFxkXAnIXNXyoP0EjmIvo1+1le+spyIwhhyRdagPK7IFwh3HvIjajpKnaoYF9uEGc5H3WYM70hr6lrvGKNR9Z12Vg5PH04ypKBGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gXCUzo6r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OKKB1a019452;
	Wed, 24 Apr 2024 20:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=mW66lHn3LA60n5dlEiSx
	L4Bgql2ZQaLftjxyfn90nGs=; b=gXCUzo6rJpjJPmRLoEG3rdwR+UAFES/fFaIq
	AyhJ1JRtP75V41SLKueFN2NLkE8Ybma8vXumCBmuod2P4hORJkvXNuz/LDp8gssN
	VN5jD1iA6gsWnozHWiL0xs5OChf5zvuQFFkOwAQPZ6wo/XmLOBQKlYTt6IJy30Br
	dwGZeSLASsSofuqrrg+T6G191W4xXiMtoWTMSlkutxHlsWTBu4VITNsJ8pCIGfcF
	gK3Jbg9jRGmQgdRqZqqCh7ixB8o13OZvJeovD3guwIRhwqvhLYgboHeoZTqz68hy
	ZU6csKTy7nwpS2GEGJqdc/FdSj3uGSTT0UkdYHQ86r9tHqg4Ow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gj277-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OKKA2d002680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:10 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:20:10 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v3 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
Date: Wed, 24 Apr 2024 13:19:50 -0700
Message-ID: <20240424201959.935-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424201959.935-1-quic_pradeepc@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: A4T4XYRWv8bd0OxePBzMqfta0pQWhdD6
X-Proofpoint-GUID: A4T4XYRWv8bd0OxePBzMqfta0pQWhdD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240101

Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
to pass EHT MU-MIMO configurations from user space to driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/cfg.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5be28b45049b..2c12fd9a3029 100644
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
index f67c1d021812..f3a919896216 100644
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


