Return-Path: <linux-wireless+bounces-6970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA108B52E6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D3A280F0F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AFA134BF;
	Mon, 29 Apr 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UEDr/0xD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B843171C8
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378552; cv=none; b=WBTI1GjwsvpI0hAoPQJM/hGZIBXFe1cjuaR2ycGPNN9n8FyF+TncIM1O0GBj/+iog97uC6reqJ3uBtKnoTuzgcEwJEmJHKy6aIUVaPiQDP2Fiy9UKpjZr30LhlIY8q6HCtwFsVUil8GgQHAkx9fF3Q5CUyHbHQiVHGbnsVe7p7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378552; c=relaxed/simple;
	bh=I2Pt7Hm0oZd61ubyz/EuMLLwYw7Tc+LzELNXgxRX9Q8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tl2UJRi07VLNkIFe9DWsEY4XsfAAGBHiRo4KdYoOIYRJgTaWcbCOPgIWicUkaPew3fwrdMklzTi84NI74fuqel002GwtEgGHJ8Z22QBkLoYJuH9FCHaeYs4RQoBG0jiLQlQRhIJ/GzDbtxgVCJ2qIOjdxMWhL5TVCacWY4H55c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UEDr/0xD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5RHtq007064;
	Mon, 29 Apr 2024 08:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=SE7H9mX
	aIhRytFS8h5izvWcM9wkUVPXPehHpmWqeXEk=; b=UEDr/0xD9onqYUQvHs7OEd4
	iKdQgW21x3+o1LuGrjmMfAW74id0p4yc5vcDpZHbgXNRrzWoBP4UfGaNJitYhQKT
	sx+vrw8uNhyxSISvSaWBauj5rAl/ilX9uzHBNjmOs0RzvoDEKdZZiPH9vSU5MLTl
	y6Jrbdrc8kIY35E1Mn/dU317eOX6AqrUDkRk7CypAHhH93wGhZJdcfLWlfNB8rft
	aifHCEMbDhl5wHha3CR1PH/pX3pICDeQTtRNn0CXSGmOGnnCgR8NGhuLyifoM+Ge
	8h7eD2RHWumjsDOOGM7LLQtteBsNjAQNtuOH/7MD9RoJsVrNBqQkEhphdrSmC5Q=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrthtb1gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T8Fjr8028813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:45 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 01:15:44 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 0/5] prepare work for monitor mode on WCN7850
Date: Mon, 29 Apr 2024 16:15:20 +0800
Message-ID: <20240429081525.983-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1UGnbStJvTRukz6ic6r7xl5nTlRD7O5B
X-Proofpoint-GUID: 1UGnbStJvTRukz6ic6r7xl5nTlRD7O5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=661 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290051

From: Kang Yang <quic_kangyang@quicinc.com>

Preliminary plan:
1. prepare work.
2. bring up monitor mode on WCN7850.
3. add handling of reported TLVs for monitor mode, such as
HAL_PHYRX_GENERIC_U_SIG, HAL_PHYRX_COMMON_USER_INFO. Then can support
parsing EHT information.

This patch-set is only to do some preparation work for monitor mode.

Kang Yang (5):
  wifi: ath12k: remove unused variable monitor_flags
  wifi: ath12k: avoid duplicated vdev stop
  wifi: ath12k: avoid duplicated vdev down
  wifi: ath12k: remove redundant peer delete
  wifi: ath12k: remove invalid peer create logic

 drivers/net/wireless/ath/ath12k/core.h |  5 ----
 drivers/net/wireless/ath/ath12k/mac.c  | 38 ++------------------------
 2 files changed, 3 insertions(+), 40 deletions(-)


base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
-- 
2.34.1


