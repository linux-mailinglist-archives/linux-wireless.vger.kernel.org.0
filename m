Return-Path: <linux-wireless+bounces-7977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEE8CCB29
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615181F22BCF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59496339A0;
	Thu, 23 May 2024 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GAFn4oxh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23239FEB
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435134; cv=none; b=nFGAbBdPxklRWLnuE9pTCrsCqCezgEAyvy6QVwtWIniwk7I9/2ONbTfT/jzcoL2wlmrWfqLHOZqSruyhpi1RZd9f0wi/1Nj1pOmh7EsqgRpNvTlyDMpsH937B/UYkskN52ZRXFGKFrrKEPLjlAaLUEqf/Llr9AgVk8GQ5pANvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435134; c=relaxed/simple;
	bh=g9PvuIf66dPt1CMkDXLO0+4i6bFg/5DymiNv2GUGUpo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KzLiG/NNpPSlUmIGMAYLW9q09mZjQSj5dI62TxUC0tojkGgk3BJKhC5qW8kx+CwTAabUM8uU7xB0dVTczu2WycoDcr7xro12FIU6ejLZ5b3+rEZJ0W1HjZbLXG31jYRsAO7eE64H2StnPlhrpfiBUW/VCdXNBh077d0gK35OwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GAFn4oxh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N3O4a6016423;
	Thu, 23 May 2024 03:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=WxXak//
	OqqxTiQnA8bN0kAUMoYOaSwTOo0wZa7TqtTY=; b=GAFn4oxhmsdZSTa/BGzN6hU
	ojDhL5Q9mOsbvvrScGgRE9gHAQYZKSHcDQAIUsZg7XCo7eZ92UUKWKeaXsTwMnWQ
	l0isIZNm4+Dap8vU3MlNI/O4RR7BA1Wfpvm6sdyFQ7SnqAhEed0FsyHqHxY5digc
	b16YM5OnF+muOsO7prDkbE9eRNpCgoA7EBV7J+i0OyF/4AYZaZ1uKVs3uzQTJypA
	7HyGCMHg0nEYaL6TTU5tai2RLWlZs2NwBv/M7Inc/ulBzi868oKPdLGPCo7+TNU7
	e1ED9dWGDGWKnhKLTyBPtaf5LPD9LsL4zokc8kEg55VkxlShC2Gp9aUzeIKRRhg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gjmf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N3Vx0G011776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:31:59 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 20:31:57 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 0/7] wifi: ath12k: add support for WoW
Date: Thu, 23 May 2024 11:31:36 +0800
Message-ID: <20240523033143.21677-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: sRz82Z0qk_RtXyNloLrVa2MtThv1B1Ek
X-Proofpoint-ORIG-GUID: sRz82Z0qk_RtXyNloLrVa2MtThv1B1Ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=573
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230023

Add support for WoW (Wakeup on Wireless) funtionalities, this including
magic-pattern, net-detect, disconnect and patterns, HW data filter, ARP
and NS offload, GTK rekey offload.

Also enable keepalive before suspend to avoid unexpected kick out by AP.

v2:
 - [2/7] wifi: ath12k: add basic WoW functionalities
	1. In ath12k_wow_convert_8023_to_80211(), change to use 'size_t'
	   instead of 'int' to make GCC happy
 - [5/7] wifi: ath12k: support ARP and NS offload
	1. In ath12k_mac_arvif_get_arp_ns_offload(), change to use
	   GFP_ATOMIC to fix kernel crash due to sleep in invalid context
 - rebased on ToT
	
Baochen Qiang (7):
  wifi: ath12k: implement WoW enable and wakeup commands
  wifi: ath12k: add basic WoW functionalities
  wifi: ath12k: add WoW net-detect functionality
  wifi: ath12k: implement hardware data filter
  wifi: ath12k: support ARP and NS offload
  wifi: ath12k: support GTK rekey offload
  wifi: ath12k: handle keepalive during WoWLAN suspend and resume

 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/core.c   |  48 +-
 drivers/net/wireless/ath/ath12k/core.h   |  37 +
 drivers/net/wireless/ath/ath12k/htc.c    |   6 +
 drivers/net/wireless/ath/ath12k/mac.c    | 252 ++++++-
 drivers/net/wireless/ath/ath12k/mac.h    |   4 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 719 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    | 559 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    | 878 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |  62 ++
 10 files changed, 2557 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h


base-commit: 429eeef2ed089af1b3aa1983ec00a7591166be27
-- 
2.25.1


