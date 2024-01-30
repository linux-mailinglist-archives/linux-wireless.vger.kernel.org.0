Return-Path: <linux-wireless+bounces-2767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64C841B00
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBD81C23AD7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB98376F4;
	Tue, 30 Jan 2024 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nMFgmKsB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A3376EA
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589178; cv=none; b=M6yOwkNXXZ0OWVgb5tiB258nI/UYu+me2Z1q9Edz1oU7AgLhcCeE4+v2i+m5VQXjnbiih1w+k/I8GIUNbZslg30z7vdJ2nwB1T6n22Ft4XcdlGfU8U8Sj2UjbvARtMBo8/UIXYH4lsjfEYKd1158oCAhItELLGUmMP0TJsLOdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589178; c=relaxed/simple;
	bh=WRpqnOjO/Lpr8/Q/y1kvjaibzD1zCTUeV7Vndukzc2o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FtMuzfxS/pAffFY+B1EdnhebSnevhfjJxus5Y9OO4n1t8lTnRteaW08G1Oqiuq2rGhjoAhJqQr+VlFhPNYn0IAOqL83ouSYvXXMSM/a7QRv+7Y9pE1Pd0SHL65UX9UscLxfeYfHgXsbRmNbFTvuemWaoBgV6G6EYWViSfc6cpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nMFgmKsB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U4G9Ge015661;
	Tue, 30 Jan 2024 04:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=9zXELG2
	sIhHzLYVRhjTqV/1tJ9rTnRUMqoMiEmYwNR8=; b=nMFgmKsBKYm0xXjalt9kEyy
	8q9QWS4XWhLzOCY0LBAKWtXxF0klDvNOUnpoPy4Kq5nd6uGUntZHDhGElrttOpmh
	xHmq0iMOiZag6vpLzt+fcmw7CqkzaJK4lKd9YXWyO4XjtYnA4jQiLECZ9fMZY4hz
	u1GuhYc31tA9cxRPFn1kdXAHMx43+LaY5krHQWf/nzV5dDHzk+Uw1O+MH9LFFy6w
	xkMnEUP5S2W8WPNwy7GTPMk9B++4xWiRHADnkI0dAG+FDzZDrHskcaAqpbTtfGTn
	2khhQIQEPNWbl6/9cyP1eD6C8eceT1USjeCadajjyBcaT/MP4UYjuswwJ28M7sA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86htmq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:32:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U4WpRi031047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:32:51 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:32:49 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v7 0/5] wifi: cfg80211/mac80211: add link_id handling in AP channel switch during Multi-Link Operation
Date: Tue, 30 Jan 2024 10:02:20 +0530
Message-ID: <20240130043225.942202-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: Saq0lXzEPu5F6AUxz_rBA7MbMlrShvr4
X-Proofpoint-GUID: Saq0lXzEPu5F6AUxz_rBA7MbMlrShvr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_01,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=798
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300029

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


