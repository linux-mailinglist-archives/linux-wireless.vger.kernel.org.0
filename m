Return-Path: <linux-wireless+bounces-21734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00803A93C33
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A6D8A44F6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848F21CFEC;
	Fri, 18 Apr 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B72VkqY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365D13B590
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998530; cv=none; b=sQbTkVHHK3foFR/JWL7gRcM0h17XvDCVyMihoeoowQeZ/m+wAFWKMt43FkURNB/f/VMiFsKjl70ZbzvtCbJsyvFgbnUdIiMZouVI/q6UdGTkj48zyfZW8Gyaq+ZcC6XKrh3FgNPOb9p1t9Xn1b4qgbwtHaAGhLeioI1xE/D5tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998530; c=relaxed/simple;
	bh=J3thacSH200oSBmf8x/Mxx+fAcxmjQ9sjM02m6DJ/98=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqNG8eIEceUcjv+RRsoNEmULfCI6DCZFr53fMFUQv9lStT7SC62ZGQ+MyUMKnYJK6bDJxgWlQ49FleAiOMr3EQLMGSS6Qdv+s0q0KBifI8e6oncdB1eJBcil6mqACCOd7myTZNPGfxnpPYlVtFqoov5P7F2h32bia3RKk30Mrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B72VkqY7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IFcZY4015286;
	Fri, 18 Apr 2025 17:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yTwWoDi74zqWAkvWexk9Pe
	eVQgQPXyK8g9OXw0lDQms=; b=B72VkqY7NEAij4rjWDuD099pR27yL2+b/ExzbM
	cHGXr/Pac9DDPcs//WXB7ErqIgCSwS9bbkt6LxnMc+BOD89WRNOWJn1qO2YN41Ey
	CXhuoFLD8Trfuu1MNOHbtERPhuKuV6asSY+g1UgLhNIxd+q8OilqzbEZ7iNhHsOf
	Gzh46/bVUwtTQauKeiN6mPJVi6Jhz/zSJjykLF3VlIJbRyY3nMgp6kjHgPSg9gw6
	IGhFzxhxLb0U4ddPCUPVGrwylHJYKlFs9AxT9t9PzWxM7SrHNB5/plcy9i5A9PjQ
	LIgSZ4v9zQmNjN0pzssERTfebxVyjFP7bWVHXqkiuZPHgBjw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6tnuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IHmgA8028376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:42 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 10:48:42 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V13 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Fri, 18 Apr 2025 10:48:09 -0700
Message-ID: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YEWkn83XPF8MJ3EkpCOkbeOGJI-xVxLe
X-Proofpoint-GUID: YEWkn83XPF8MJ3EkpCOkbeOGJI-xVxLe
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=6802907b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=ir8cDDC8oFjxVUU6xG4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180133

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v13:
 - rebase

changes in v12:
 - rebase

changes in v11:
 patch 1/9:
  - fix return values in ath12k_mac_set_he_txbf_conf() and
    ath12k_mac_vif_recalc_sta_he_txbf()
 patch 6/9:
  - fix missing he_mcs initialization in ath12k_mac_init_arvif()

changes in v10:
 patch 6/9:
  - use ath12k_ahsta_to_sta()
  - fix rcu_dereference warning in ath12k_mac_set_bitrate_mask_iter()
  - change return type for ath12k_mac_validate_fixed_rate_settings()
  - improve readability by adhering to nl80211 definitions of GI
    NL80211_TXRATE_DEFAULT_GI. Introduce ath12k_mac_nlgi_to_wmigi()
    for conversion.
 patch 7/9:
  - do not change default MODE_11AC_VHT160 in
    ath12k_mac_get_phymode_vht() as it breaks clients which do not
    set VHT_CAP_SUPP_CHAN_WIDTH_160MHZ.
 patch 8/9:
  - Use IEEE80211_VHT_CAP_EXT_NSS_BW_MASK along with
    IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ for determining VHT160
    phymode.

changes in v9: rebase on top of master branch with mlo changes
 patch 1/9 and 2/9:
  - fetch link_conf using ath12k_mac_get_link_bss_conf()
    instead of arvif->vif->bss_conf before mlo
 patch 6/9
  - fetch mcs/nss values from sta->link[] instead of sta->deflink
  - fix spelling of 'incompatibility'
 patch 8/9
  - replace sta->deflink.addr with arsta->addr in
    ath12k_peer_assoc_h_vht
 patch 9/9
  - replace sta->deflink.rx_nss with link_sta->rx_nss

changes in v8:
 - rebase and resolve KASAN warnings reported by Jeff in v7, in patch 6/9.

Pradeep Kumar Chitrapu (9):
  wifi: ath12k: push HE MU-MIMO params to hardware
  wifi: ath12k: push EHT MU-MIMO params to hardware
  wifi: ath12k: move HE MCS mapper to a separate function
  wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
  wifi: ath12k: add support for setting fixed HE rate/GI/LTF
  wifi: ath12k: clean up 80P80 support
  wifi: ath12k: add support for 160 MHz bandwidth
  wifi: ath12k: add extended NSS bandwidth support for 160 MHz

 drivers/net/wireless/ath/ath12k/core.h |    2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 1141 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   13 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
 5 files changed, 1058 insertions(+), 222 deletions(-)


base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
-- 
2.34.1


