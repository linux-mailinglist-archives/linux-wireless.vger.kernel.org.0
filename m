Return-Path: <linux-wireless+bounces-8294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846438D4614
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267C21F213E4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 07:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891157406C;
	Thu, 30 May 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RDVQ81jk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC474066
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054059; cv=none; b=O1KYQOnLh14CHNOHtA8xsrloduBNuK/mKMZz4gsDuHgHc9Iymh7wKL3nTxFk6NhFLmpKBLgntCgy+8TogLnNgYIEaaKOOlh33NWJ4t1b/CCjJsPjUX3eWsjzwj3RqI0oXTL2Jwqnt897K4OJLPhc0VNJweYR77SbyGN/cNXTboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054059; c=relaxed/simple;
	bh=OyhRPL1bKfTQY5knAxxYo81VVOAj4GHHBuA48pjRpbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vit4u25cWi16LdXjGH6d1UIcvUj9sTTg5+McG/sUcEPIHii1jnbdKAPLUu1yST8fKyUMP4Hh6b80njNydbE0bAI+rnjjWF2tr02CwRavHEx0WDk5IpZRn/huS2KA6JSQTWVk8pgbn0dIAkC+rYqtfp/sj3Hf6se0qwbABgda7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RDVQ81jk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TIHb8K011441;
	Thu, 30 May 2024 07:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=owPbnJd9BdWvTkZs8GqezH
	YP8b6CWxtcmvhMJpgrw5I=; b=RDVQ81jkCbKiJbwvEY/T70HHX7YJi0gz13d44D
	VCj+vzqTv/RXpPV5ABnY1do2ajfljeCsM/9O1lGeF0LIV7BFhQr9nlyh1MOA2OlF
	IBURmPuLtikm41hNVjVHBjWXvkIhLTOlYjzXM92OyN0R22PnLSqrKMWmN6+DhIcE
	Tj2fSqS1AOhFLbmBZqXR4r8SglHAy67cEoykLzay8+BUoG2Fjnajan8vuPi/2Zys
	luEYcp5hS7NjC4J0+DlS/EiXhbEAxXcosnQRZ86KRGHfGnpKCKmirsBRNHqnseUq
	6PnaWgGI0YO1kvzH/ytcMu/71O8A6bRQBfvzL4LUdQj84KOA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjbd9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 07:27:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44U7ROkH006757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 07:27:24 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 30 May 2024 00:27:23 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v3 0/8] wifi: ath12k: add support for WoW
Date: Thu, 30 May 2024 15:27:06 +0800
Message-ID: <20240530072714.25671-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: YuJM0Qaa2h7VP8nllKyhhtXccnznIARL
X-Proofpoint-ORIG-GUID: YuJM0Qaa2h7VP8nllKyhhtXccnznIARL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=769 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300054

Add support for WoW (Wakeup on Wireless) funtionalities, this including
magic-pattern, net-detect, disconnect and patterns, HW data filter, ARP
and NS offload, GTK rekey offload.

Also enable keepalive before suspend to avoid unexpected kick out by AP.

v3:
 - wifi: ath12k: add ATH12K_DBG_WOW log level
	1. new addition.
 - wifi: ath12k: support ARP and NS offload
	1. move ipv6 infomation parse to ath12k_wow_arp_ns_offload() to
	   avoid memory leak issue.
	2. move ARP/NS related definition from core.h to wmi.h
	3. rename ath12k_arp_ns_offlaod to wmi_arp_ns_offload_arg
	4. rename some macros
 - wifi: ath12k: support GTK rekey offload
	1. add rcu_read_lock/unlock in ath12k_wmi_gtk_offload_status_event()


v2:
 - [2/7] wifi: ath12k: add basic WoW functionalities
        1. In ath12k_wow_convert_8023_to_80211(), change to use 'size_t'
           instead of 'int' to make GCC happy
 - [5/7] wifi: ath12k: support ARP and NS offload
        1. In ath12k_mac_arvif_get_arp_ns_offload(), change to use
           GFP_ATOMIC to fix kernel crash due to sleep in invalid context
 - rebased on ToT

Baochen Qiang (8):
  wifi: ath12k: add ATH12K_DBG_WOW log level
  wifi: ath12k: implement WoW enable and wakeup commands
  wifi: ath12k: add basic WoW functionalities
  wifi: ath12k: add WoW net-detect functionality
  wifi: ath12k: implement hardware data filter
  wifi: ath12k: support ARP and NS offload
  wifi: ath12k: support GTK rekey offload
  wifi: ath12k: handle keepalive during WoWLAN suspend and resume

 drivers/net/wireless/ath/ath12k/Makefile |    1 +
 drivers/net/wireless/ath/ath12k/core.c   |   48 +-
 drivers/net/wireless/ath/ath12k/core.h   |   20 +
 drivers/net/wireless/ath/ath12k/debug.h  |    1 +
 drivers/net/wireless/ath/ath12k/htc.c    |    6 +
 drivers/net/wireless/ath/ath12k/mac.c    |  110 +++
 drivers/net/wireless/ath/ath12k/mac.h    |    4 +
 drivers/net/wireless/ath/ath12k/wmi.c    |  720 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  578 ++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    | 1012 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |   62 ++
 11 files changed, 2554 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h


base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
-- 
2.25.1


