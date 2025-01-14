Return-Path: <linux-wireless+bounces-17454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CA9A0FD72
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 01:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4891888072
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 00:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF58171BB;
	Tue, 14 Jan 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dXvVNWxm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931D1B960
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815111; cv=none; b=tovRNaMCK92D8kJNk616JOgJJOUMjNjwwnLWxn4qDTjn9AbymRV/QbhicCJwuVLUxrJoEyZbhnwTDoPXuUKPqxcS5A/J4NP2O9C6TDckvEL9971mSfRYl1sr7L8U52EfI+BbDYkVQS4zStr7gpGcPTqLwq5rPBCGfmHcyFs0420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815111; c=relaxed/simple;
	bh=8eacHhrokzRMeZt1jTwShFq1wlxtVuxSiC8Db4Gawf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8A8ioiNym2TiyZiPNxHZOttD3s+VCSSaJW1Bf7gncfD23jaFgq8AoXg0vQ/ekq6ZMt3CijVSIOkX21oFgaHCyKEf+l3sJZSIsMZZyC3P1145rB6bictSEJ0AexzJG4EuK9TMOrDZRzI55mpyXRQR7OdCpef/owdwrYNXsy3tYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dXvVNWxm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIixY0007956;
	Tue, 14 Jan 2025 00:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ch5E/kO6NH3YdKrrUefLHg
	0sSCmYwjzd2xQhjp65ZKc=; b=dXvVNWxm7NM+4jSKsBcy5cbSIoX0mDvv+b8T9h
	L4rpvLL8f/b0cbWEPuxaCA9tkCEQeCo2p043gfU7v1XZLULdy7Bdu+J+B7TMmBaZ
	m6L+NdlOby+WClZN82BDqo++NTgDWu6tcpieDFryGmhBBzSgwEi0cDC1/khWnhvQ
	oVdnhn5fICYD1DUzMvbg6+WwJ5QzoVN3FIbGaF40cRX8XdD9UsffT/fjj3Cyj2Bz
	EeYpmXPNsLbMvXSy0NbrZgMeG+bo9xH+SV/z84IQkPYFKu46I6mH8i7ifpWY8kJH
	FkY1h8RPWp6Ttc4a57KlPi6vSvwYQAIv6/9g+bASTNdmxLLg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4458cn0npq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 00:38:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50E0cN8q009609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 00:38:23 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 Jan 2025 16:38:22 -0800
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v9 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Mon, 13 Jan 2025 16:38:04 -0800
Message-ID: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e_ldCzejKKkyZd2sBAQIyzA4sAun7qb8
X-Proofpoint-GUID: e_ldCzejKKkyZd2sBAQIyzA4sAun7qb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140002

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

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

changes in v7:
 - rebase and remove patch 01/10 which was merged already.

changes in v6:
 - Change comment in patch 01/10 to represent only AP mode
   implementation.

changes in v5:
 - Fix column length to 80 in patch 01/10
 - Fix advertises spelling in patch 09/10
 - Fix choosing spelling in patch 10/10

changes in v4:
 - Fix ath12k-check warnings in patch 2/10 and 7/10
 - remove "hostapd" reference in patches 2/10 and 3/10
 - remove redundant prerequisite-patch-id's in cover letter

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Amend mac80211 patch description as the patch is not specific
   to AP mode.
 - Amend EHT MU-MIMO patch description to specify future support
   for STA mode.

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
 drivers/net/wireless/ath/ath12k/mac.c  | 1117 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
 5 files changed, 1041 insertions(+), 217 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.34.1


