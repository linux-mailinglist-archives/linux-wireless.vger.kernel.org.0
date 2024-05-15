Return-Path: <linux-wireless+bounces-7694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E2B8C6AFD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C0B22483
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8743AD5;
	Wed, 15 May 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h7yFja+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB46123776
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791973; cv=none; b=lVG2BRNaV8ZbJGorqnzitKnRJriZh8DRaTH9IV3QL93ck6ifcQ+0SchYy+HEwvtXjA6+yzUWeNceJ5s+rLGnhIDoGrH4MG0wqJn8p7EKPth9kMTC/X2KPSEshspaQU1kTzwZttjOIzDqR03GsMr5I4fJlCEF2uHWQEpDCj+zYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791973; c=relaxed/simple;
	bh=1pqIjXWqKsgU3fvpuJGm+kZL5uzTNSVOFFoDFfI7rwM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gAPJILRG0F4WQ5fx5s1AMC+hmKR0B9BGWClbepxFEuKGpehhPREY9jQ8H234N78+Hot3AICiNpnmxIggW9RlDM9pvvL+Xi0Td0V9CDwfy7hFNL7loUGWJezP2lOJMq6HZD9hcyQ0agX67kOGFBjHuO01sQL/lGiVgmUikZIbQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h7yFja+N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F90YMx009195;
	Wed, 15 May 2024 16:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=msxd3JhhziMeG/wYGRd3LUEIA7vFC+p/2TlQDNFsZfI=; b=h7
	yFja+NK/u/hITEGXYAvG6orPF0pBQuVGqePrqHXXHw/6QYTeiDpb4S+E2NDE8FEm
	APvzph4p1qDWa7ntIwQUGEQjQuw4kfivZfqn44Rj0rNS1eRhYEaUMlVOkt5V/3e6
	sOmSBQ4wDtAQpnhuuXnTYHUTcxS7dGCLEQaCkkArZodopmnw2j9FEnE+Gj4ay5N0
	YkIB4GhQzzkjqFgfWhbBylvDL9aIoMR3MdB4o9ToNe+TWsVEn1wtH3V2xixEWMgB
	0+NZqEwaEUzqgdzIlMvG1xG0hsiTlhYfKjmfLQDee4pMbocnzg8krYCohAWrZ9nR
	TDgzGbkl894TmBB8PN1A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3x51mjkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:52:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FGqeNb009056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:52:41 GMT
Received: from pradeepc-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 09:52:40 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V5 00/10] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Wed, 15 May 2024 09:52:21 -0700
Message-ID: <20240515165231.12114-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8Qbb1XbMeg-GpYoEn2bUnQw377GXIehE
X-Proofpoint-ORIG-GUID: 8Qbb1XbMeg-GpYoEn2bUnQw377GXIehE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150119

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

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

Pradeep Kumar Chitrapu (10):
  wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
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
 drivers/net/wireless/ath/ath12k/mac.c  | 1052 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
 include/net/mac80211.h                 |    4 +
 net/mac80211/cfg.c                     |    5 +
 7 files changed, 994 insertions(+), 208 deletions(-)


base-commit: 5b501f801ab443046d5c31881bba21350396e5c5
-- 
2.17.1


