Return-Path: <linux-wireless+bounces-23250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A95EABFFF2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 00:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A66B9E1E06
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD101EA65;
	Wed, 21 May 2025 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NyTpefuP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2A2376E4
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867559; cv=none; b=Ot8CO3frGPdzULDxkXn0IOgpH6oIMC2FI7qFRbRyq79av6j3ajDrAQ66HpA3uDsh6B1r93u7mpL1EtwJsdumMTZmaXcS2dCJxQggqK/GrUYrIwqCLs0QzO9TQjhAfYBTsfKPRlzOCJl+qcC1lA9zEx4+9Y6SL6eWPxQQov8DGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867559; c=relaxed/simple;
	bh=XTUWrdzEJym/rTnjr46c//5p58Mu5Y/AWdbpj65e/oI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KMDo5eStsqksHnrxmYyf60Wg4O8cjZDkEti98rsapwj8En/539lghW8duqLaYg/coo4N0IUq2bux4dVcQhqSdVHkxeOYraeWQG+tBALopeZaQ11iGwfYr1EWqQ+yTEtT6Yk+Z+eqSDD4sM9+UoRWQfFYKkyBlpLdMCSgHxiZx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NyTpefuP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LJ0GR3011336;
	Wed, 21 May 2025 22:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SkBtOb6ERC41NqMKxpZepS
	28MVVqnTvaZ4PXI3QW3VI=; b=NyTpefuPmvEqLmP056Lm9bVVYPiH4mQgxN5Kgg
	BjBV7xTG7VFq9t/Zn5j0XQzxuqcBa5w+KTlHzSB6C1kXzIpjVAvQ48GG3W/VNmkS
	22Wl82TL2JeizAP7J42ruhQQmnKKeG0tfvR3DyRmiqU8ohjH1qlmVBfhMrVr2NdU
	3W1WxwCVsDrmLjzUkapPiwEz4hbaREJH2V9lj1Sg6xxP1OjxuyERIWTGiEpNw1q/
	cVfJf3tcg/RQTusbbLrE0oVO09k6o/IScocMTJP2A3NGuZSNq3MHBl456/Nb6Ql5
	JjE9hovWbD3CFBqNg+el2RwVsZLEH+ygUGLMrRTxshc/2qmg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb4b3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 22:45:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LMjqqk027086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 22:45:52 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 May 2025 15:45:51 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH ath-next V14 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Wed, 21 May 2025 15:45:30 -0700
Message-ID: <20250521224539.355985-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: 1Ed1cKzVoXEGqLcj5Djrm3eREqLkLlE5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNiBTYWx0ZWRfX9Y8kVJABjWWu
 knFNdsV/Bx6CBLh4keYMI+ddVkPEzdf8O/8UNqINuJMhyMEh7gADFuSP6DnY9GF3aGNdEX0JN6n
 n/np7kwdazOqQf4YX0DUohsPTGW3cev6Xaby0j4xHYct2SSFXHu/jhj2J0WOKmOWYMSRa8j2hDx
 Q9Yy98PSUOTnOfSbvmDYj6Z96oA9sTCIzNRMh062GCYkeL0MHe9GSOHPe/ai8Joz8254hlyvhwV
 c6IFtMzTPP+xoiUEq0S+Wzjorysgk1KkcjplhmY/dYCDhJIoUsJdQI/alh2GE3AdeL9Akqws1z/
 rUfCJvO4W7RV2J4TJjmleVI5woxcBPoW2ngq8nCwKSkNRe4qKdIKvnU/fLyNuFXUTIYKqC08Fuw
 NLhCqarcFnXjPcL/3u/5UfIJJHdLqbjZ384JI/W6C62HYq0n5sQFm/cPTL9KgnSZ6WU5eLOn
X-Proofpoint-GUID: 1Ed1cKzVoXEGqLcj5Djrm3eREqLkLlE5
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=682e57a1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=QCY7fwImu4SyahzicskA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210226

 Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v14:
 patch 6/9:
 - cap max_nss using ar->num_tx_chains to fix interop issue caused due
   to sending nss value 4 when firmware only supports nss value 2.
 patch 8/9:
 - Set the default return value to MODE_11AC_VHT160 for 160 MHz
   to allow STA to connect to the AP even if it does not
   explicitly indicate 160 MHz bandwidth support.

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
 drivers/net/wireless/ath/ath12k/mac.c  | 1144 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   13 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
 5 files changed, 1061 insertions(+), 222 deletions(-)


base-commit: 0d777aa2ca77584b339ce195db86fe0ee7dda5d5
-- 
2.43.0


