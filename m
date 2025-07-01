Return-Path: <linux-wireless+bounces-24690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D22AEEBC4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 03:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0084B1BC470B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 01:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92D1E4A4;
	Tue,  1 Jul 2025 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fq4CuiJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77318DF8D
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331867; cv=none; b=HNKBKNWWzDUU5eY1Kq1y8G8vgjhstyOMpG8cpesMCO3o8ZV39V0AQhde3ZysfcWrqSYgTrKX2XOkzRmD/cPrRUsA9o8MunIAxe2kqxBkPFdiZF8fZ3AWWR8A0U2uW9Csihry81UZOGfENSmZFiLXQtMQipB4DQddI+RSYPR7DoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331867; c=relaxed/simple;
	bh=6aeHJIQvQTv0iKFimqQ3FFJKsX6gnqSq1wkytp+ywyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MEDDw1b1kenBnlZRoVg35fwb08vYMKdE98JsawmXhnD5h3DUXzLb0RVGIMr94OxfMAFVj4IqaVnFtSZgBopKxvG+fmaRuAQIfcrIeRR4XNsivynyLMpWZVU+MmfNfGLeIxsAag1fEpTAwM/rF4sCRMCrHLH6DeGGIPUlp0jdoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fq4CuiJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFfPNB029431;
	Tue, 1 Jul 2025 01:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CS2HLU7KE0n+wupLdfJabk
	ZkefXDlbsviW5DMRfRvX0=; b=fq4CuiJn1BRGISjoGjik2hO5In8731TBG9kcAZ
	x8w5h2gZZT7bxPinLzpdWoZCAYK1FfS0yYA3JG7lXFYtVOiUEnrDnGq2Vq3q+jC+
	rG8jO+tsDq/jWcn1MBieKWKKZGwXKsAgDcfaEE2I59384RTEnN1P+94YfrnoKyIp
	bBcWFgeHUk6g3vuIAt/xSLGcDuiM6vUB15a374o0b9epvH+9h9wV5t/WEMi5yr7g
	yGv934UROiU23CSYdRcm2bSa7ECJn8s5v7WhhnIe2vRe9G+JEqqSsevkMhAClCJJ
	G7dWB+cuL5BqBZjYBNpLE+CsEHpKDk0EPE2Vmz7Z/TkizOjg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j95hxfe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 01:04:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56114LKd017219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 01:04:21 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:04:21 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH ath-next V15 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Mon, 30 Jun 2025 18:03:59 -0700
Message-ID: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwMyBTYWx0ZWRfX6/8mRrN9/D+V
 X5XNFSo3JuhTVOPSZJVcFEWN4KoM5mTTX7HaTT8PMoK9SUEVI6tpKARZWtA+foLcHK8ppiKTqvm
 dBGVVNtytxzch+qJRitmyKRfXHJJXzn0FI8ZlrIGTBzIctHyzRYMiEuT7/IsJzRNLt9ajdG2iwQ
 n/0VckYg74CiilixTexBc8kKyVeau+8WngRitCbiN4RAfiuG49yOFZroFlCskBDd4mlzvjSWpjk
 1ppbAcH0onl28vAygj4MzH1kFfC3OzuDcVh4vNb94C7wuomnXb80kDNDvrF0KTneg+K3lpyIZQY
 RcGYPWLPeG/Gg923chAsF+OOuWVuYYVy3ox/X8P1GkuTaDgQAFQRs2vXqGHgDcj1Wy9h/Nj+djW
 7gH0dQYL9rWv4Si2wYWtwYFe6dU4cZ/1wmI3SdDbgfggNbsvq4LPRU/u2ibWC3VLG+zXcO4a
X-Proofpoint-ORIG-GUID: vRcu1oB19-t1PBg4cfL1blaB1dMbZ0t0
X-Authority-Analysis: v=2.4 cv=EuHSrTcA c=1 sm=1 tr=0 ts=68633416 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=QCY7fwImu4SyahzicskA:9
X-Proofpoint-GUID: vRcu1oB19-t1PBg4cfL1blaB1dMbZ0t0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010003

  Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v15:
 - rebased the series after merge conflicts reported
 patch 4/9:
 - change the fix to apply for all modes except STA mode as
   WCN7850 expect it same as before.

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
 drivers/net/wireless/ath/ath12k/wmi.c  |   28 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |  100 ++-
 5 files changed, 1069 insertions(+), 222 deletions(-)


base-commit: c256a94d1b1b15109740306f7f2a7c2173e12072
-- 
2.43.0


