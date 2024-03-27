Return-Path: <linux-wireless+bounces-5378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087988EC28
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3191F2D0A2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DE014E2C1;
	Wed, 27 Mar 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZQScx6Em"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848014D28E
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559371; cv=none; b=FgvfPKXEIyoFO1HTbFsSVYZTI3meXztrkfb6EGDDdlnlFYlbBEe/fsLbpPIZ0aLhKYwrd/IowX06LJqPVmzrh4Zt9/0Nh9gOIBQSreteTr0F0bXO1/zoIsSkXv/lf2uyWfxMg+ft0MoaIGYBiNqoKXuwoHyliythqD9rASoznL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559371; c=relaxed/simple;
	bh=p7i3B4vHoE0FNv8YEXoNma/v7BgNQMC+enu+itWWgek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UiQ7T3XCdwEbbKWClwS5BlQtphsxG42Li41kUGkcHdSbkH/7H3cYiwWicYhzUZObacbkfGJubci8IaG+n/+jmzTEUD7hmKDAB4bY9jpdEcTBn6NeiXFomfCVpB/+LTBgpgWl8X5AYDNF1RvLwEbWAFsL3klX8EAkqWDz90OK1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZQScx6Em; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42REdXhN003229;
	Wed, 27 Mar 2024 17:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=FawkAbIxT+3ngMD9eccRtezfG3ECnOItCMe7RoJmES8=; b=ZQ
	Scx6Em7MAHU43QkDJfNWR6NQJKuJMEaN15O5amWs+qU92+spz5M8l9bkX5BxPGmd
	gb3KCPytNbZtoc6qjmgP2v/4zT2kzJtnnm9SE65mo+U5y7OPN3UjqHDQdsy2pn8A
	Zz2Jm+q1i5XgGupZNq5Yk9Mj3HcqBcrIpkPtpbk0vxNny6yZa8rAI5KCD16vL1Lq
	fXQqX0EvnE5249Ykk5FeSnhcjRxMhJXOylvraae8FmI90L+l5P4460W0hSA7t9dx
	JdIONelaSk/jiYTdl52SwlGSmGQVrEI/z+04FHmQn3YR9Gxd766hbek8h82DGF5C
	THR2PDKFWtTcBJSEcuew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4ndprcag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 17:09:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RH9Krc030136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 17:09:20 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Mar 2024 10:09:20 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v2 00/10] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Wed, 27 Mar 2024 10:09:00 -0700
Message-ID: <20240327170910.23975-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-ORIG-GUID: wCCo1-pzCRisM9FR8K2Fvevd3RvUFvLn
X-Proofpoint-GUID: wCCo1-pzCRisM9FR8K2Fvevd3RvUFvLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_13,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270119

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v2:
 - Amend mac80211 patch description as the patch is not specific
   to AP mode.
 - Amend EHT MU-MIMO patch description to specify future support
   for STA mode.

Pradeep Kumar Chitrapu (10):
  wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
  wifi: ath12k: push HE MU-MIMO params from hostapd to hardware
  wifi: ath12k: push EHT MU-MIMO params from hostapd to hardware
  wifi: ath12k: move HE MCS mapper to a separate function
  wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
  wifi: ath12k: add support for setting fixed HE rate/GI/LTF
  wifi: ath12k: clean up 80P80 support
  wifi: ath12k: add support for 160 MHz bandwidth
  wifi: ath12k: add extended NSS bandwidth support for 160 MHz

 drivers/net/wireless/ath/ath12k/core.h |    2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 1035 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
 include/net/mac80211.h                 |    4 +
 net/mac80211/cfg.c                     |    5 +
 7 files changed, 981 insertions(+), 204 deletions(-)


base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
-- 
2.17.1


