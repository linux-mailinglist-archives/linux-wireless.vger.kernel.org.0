Return-Path: <linux-wireless+bounces-12574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F396E847
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 05:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A812863A2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785218B04;
	Fri,  6 Sep 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nYl0NaBM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F01EB35
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593551; cv=none; b=a6PofQmpHtGIdwZ6fNhbN+oowLErfO6ct2CiSrrpW+yIu3xj63s4NMJ4unDPxnqRsiI3/gKm9caNnTSDVNORtiydKgVWcCNI5PQfxbb/AZehA0woy9OGmcvJ0ZLLllzRC+glrNCU30Oedqs2d/d/iaS4xF+Uk0xoUP9TjV+CNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593551; c=relaxed/simple;
	bh=dG1qzJWI3BL1vbGx9XugZoFyizPMA7V+qUNv+a3N/Ow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhM73CcNO+JGZaymzOWbamAV1uDupprRql5+CqYni7LQDF935JBAQ+njvjIkC5huijw6uPL/nN42b/g4PnDMShmfgPeOwabX/hLCF4gNR/GGAnpT8VsCWoTCigMoL+Umy835ZKrjZa5fJ9bf85Yn8Jj5/1PQCqCN9O/ACGCpkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nYl0NaBM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQMqp025411;
	Fri, 6 Sep 2024 03:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XPKri7lEj5CRrqPrCH97wE
	JjidS2hiqELyzOm/XoXKU=; b=nYl0NaBMGcNNxvmHuPnq90cU52xmw1t360QhTK
	QfWAj9KaP8CymegtpKkcFonUp45izVTVmscv5qIx2sASmehrzc66x4oOce5J6TD0
	nxx2QSM6IUKMDhPjI7q5mpy/4LdkWOOtjUhVhjVL8Ig7VyHSO0Lw1RoCTmnCK5Rr
	wqHeTD+KdDurL9J3OzgvRf44xtZhBEtnb3+oXPDuwIMy+DN8H+q6U4J4RMi82u4y
	Xti4/gtDxiBek31gN/CUJ89A9tOb3sIhlkEKScRdvWzIGFzjWJ0CXeGvnQhK1EGZ
	THXpGCjVQEBkpChqpa/eBSk3eC6DrkMnRzUTV+dGNpTIslzg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx08xyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 03:32:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4863WMoD016099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 03:32:22 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 20:32:21 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath11k: fix data out of sync for channel list for reg update
Date: Fri, 6 Sep 2024 11:31:58 +0800
Message-ID: <20240906033200.472-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gALGfGijOqk9QujFjxnDO8mwFVP7vyTN
X-Proofpoint-GUID: gALGfGijOqk9QujFjxnDO8mwFVP7vyTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 mlxlogscore=976 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060024

Currently there are two threads to updating/fetch data of channel
list, and there are no synchronization for the data, it leads data out
of sync for channel list when doing reg update.

So change the call flow to make sure the fetch data running after the
update data finished, then data of channel list become synchronization.

Note: This patch-set is an old patch-set in public review written by
Wen Gong. Just continue sending it for him.
Link: https://lore.kernel.org/linux-wireless/20230329091235.19500-1-quic_wgong@quicinc.com/

v2:
    1. rewrite commit message for patch #1 and #2.
    2. use a local list without the spinlock held for patch #2.

Wen Gong (2):
  wifi: ath11k: move update channel list from update reg worker to reg
    notifier
  wifi: ath11k: move update channel list to worker for wait flag

 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/core.h |   4 +
 drivers/net/wireless/ath/ath11k/mac.c  |  15 ++++
 drivers/net/wireless/ath/ath11k/reg.c  | 110 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/reg.h  |   1 +
 drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
 6 files changed, 98 insertions(+), 34 deletions(-)


base-commit: 8fb3b2b8d6d489416a7ff8a28cd4083340ad9e55
-- 
2.34.1


