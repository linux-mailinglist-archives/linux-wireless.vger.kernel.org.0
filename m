Return-Path: <linux-wireless+bounces-2816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE88426A7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CBB1F263F2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C716D1DB;
	Tue, 30 Jan 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZeWk2g4P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355E6DCF9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623788; cv=none; b=EJXGhDSBVM2GXneG3j5cE72wr5Uy0ZAgZaw6V9jD7+rgs8C9HAzDbvN4h5YY0o26ac9liKUFiZ3tAW9kbDAaLyHloJJP7DRrY5LUuBlhIpDh+RobPtIalbqov6hi1MXz4wRXKuGabTTsBIRniOCKSmLW57z8pomm51KbhMFV9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623788; c=relaxed/simple;
	bh=Sx/bFi9/Rf8hTdCwlEEn+ha3n8AZMEZ2NSlEQyl4pDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GFE6U9iPb3RgWDg1VOwKxMnXE68sJoHgarREffvvgykyBOsGFwWDHfwUEoSOFyAhh8gOu+JFZTlkmq6kVB0wd6vpJ63F3dGZ6Fnc1TPxWGWriMP3geElHd3TjEsiCPQOYS/bgwhadQwRh9SQ43Cz+kU+K4/iwGoLGJIYUyUuCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZeWk2g4P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9Rf5j028636;
	Tue, 30 Jan 2024 14:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=XCbWVlf
	+H+uaEawIvNyPrfkdOOrLvhh2W3wovD7alQU=; b=ZeWk2g4PfMueHo0yqasZYTw
	/AhIp8rRe7XcmcwHMRZhJA8/1RFNdmqoOZjZn1J/AjuVtLs3Fx91LPJgOQTUPacW
	TubctfsW4WqmxLg5aWt5TzNEiHE/srUs1mtnNLtcX7LLeU2nYTcqPyCxoA2+soOq
	owgPaStRDb08Ga8eV74qDMCgnqRL20dZk6RuYyeJ9tZPsimMZ6CK7Mnq5hWBTcQV
	CBp0lX/Yt8+rNtfMi7MQchgtsqmmaU/rvcomZfpgMq2tff2tBZgnS2HdAWQF93kX
	PRZOss8RbmJ2usKSE3RzkuxOq/6gQ3C8lmaS7SdG4/qLumXGM8hAbPZyfqRVa0g=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvsr0uer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:09:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UE9fvw030316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:09:41 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 06:09:39 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v8 0/5] wifi: cfg80211/mac80211: add link_id handling in AP channel switch during Multi-Link Operation
Date: Tue, 30 Jan 2024 19:39:13 +0530
Message-ID: <20240130140918.1172387-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: u8IthednQK5TbuNLfuABWZNtS-1kHlon
X-Proofpoint-ORIG-GUID: u8IthednQK5TbuNLfuABWZNtS-1kHlon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=739 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300104

Currently, during channel switch, deflink (or link_id 0) is always
considered. However, with Multi-Link Operation (MLO), there is a
need to handle link specific data structures based on the actual
operational link_id during channel switch operation.

Hence, add support for the same. Non-MLO based operations will use
link_id as 0 or deflink member as applicable.

While at it, beacon count down now needs to be updated on proper
link_id's beacon, do that as well.

Aditya Kumar Singh (5):
  wifi: cfg80211: send link id in channel_switch ops
  wifi: mac80211: update beacon counters per link basis
  wifi: mac80211: handle set csa/after_csa beacon on per link basis
  wifi: mac80211: start and finalize channel switch on link basis
  wifi: mac80211: add support to call csa_finish on a link
---
v8: * fixed space error in documentation in 1/5
    * minor commit message rephrasing in 3/5 and 5/5.

v7: * fixed proper link id validation in 2/5 and 5/5. (>=)
    * added comma in trace print in 1/5

v6: * splitted v5 2/3 into v6 3/5, 4/5 and 5/5
    * rephrased commit mesage in 1/5

v5: * fixed compilation issue reported by kernel test robot.

v4: * fixed compilation issue reported by kernel test robot.
    * rebased on latest ToT.
    * moved link_id arguement into csa_params struct in [1/3]

v3: * splitted [v2 1/2] into [v3 1/3] and [v3 2/3] having simple cfg80211
      changes in 1/3 for easy review. Rest in 2/3 [Johannes]
    * used wiphy_dereference() instead of sdata_dereference() [Johannes]

v2: * reabsed on ToT
    * removed unwanted locking sequence during cancelling CSA work handler
      since now locking is moved to wiphy level, that part is uncessary now.
---
 drivers/net/wireless/ath/ath10k/mac.c         |   4 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |   2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   6 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   2 +-
 drivers/net/wireless/ti/wlcore/event.c        |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   2 +-
 include/net/cfg80211.h                        |   3 +
 include/net/mac80211.h                        |   7 +-
 net/mac80211/cfg.c                            | 108 +++++++++++-------
 net/mac80211/link.c                           |   2 +
 net/mac80211/tx.c                             |  14 ++-
 net/wireless/nl80211.c                        |   1 +
 net/wireless/trace.h                          |   7 +-
 23 files changed, 112 insertions(+), 68 deletions(-)


base-commit: 28b3df1fe6ba2cb439ba109f095aa841fef3a54f
-- 
2.25.1


