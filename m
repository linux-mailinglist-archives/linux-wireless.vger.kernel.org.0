Return-Path: <linux-wireless+bounces-6162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D98A0F52
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877111C21609
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504213FD94;
	Thu, 11 Apr 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fmNTrwCD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DD145FF0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830974; cv=none; b=SIt0hXxdhjXGB03rZe3NiovHA3r5EmQlrJ3GAnqgw9Q6ubsDYoBt5TE0QWSCE+4fde2fUa2nV2Ak5z3BVlFr+iHM1IqeZPOANB9nyunmdWL39r5kVKo70aw+h6gcwRO5SgIARwNRNn34wWHAkDzb5byOtx6NibUCIuMRNUpeFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830974; c=relaxed/simple;
	bh=O+G6dN7K+FIh1CxdvE5uNnLtYUMIrClwchy+Fk8IBoY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omSaPDGAWxIi8u21JTWXEt+2ezNygGSqpwYtdhpInprSk8DCST7haN3pyjSpRg8uBSArmdwHd1fHoLqOPrcHg/fSKN7B5fV5f+IjD+l1kiLfCGxxVh6Owh48P7BKG5zwvj/2uujGUOBMyFvAjCvALQkmK0guU5w/AYmyIGRHVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fmNTrwCD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B8McI5019832;
	Thu, 11 Apr 2024 10:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=SEQ2sDv
	h6L2llsMV474uXxQqBZoTB+5NKfjQfUZLgpU=; b=fmNTrwCDTg5/vek4FVAxoPx
	t6WD1rIeEUgmGuiukljhA9hVOvEjxjScGoMLulHK3CJQoz3/ZJlM124FLZTj7tTF
	auQVzwZ8gYW9ON79yeWoVxAGCRL1I/EUwtAUykQ2nMEXJGGYTKo67IGBXfwRaUTT
	UtLPXAclHBDdLEsqKWiOH3MF9LUxviY5CVD1MLBaGs1TDGIO3zoEmA3R8UtxZYu7
	7xIB/dDdzFolEs8I1hxYW6ZxYlp5UYkdzOb3w8x77T8Mtr3Bxg4/flUG3b3k3iot
	6OO2MU3v+OOmkkJnX6HuJoxDZe2i14pO/SlD5w7FzXGHwT9yAnJy8+O2B9pyajA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeb628usk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:22:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BAMfau019654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:22:41 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 03:22:39 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/4] wifi: ath12k: Refactor hardware cookie conversion
Date: Thu, 11 Apr 2024 15:52:22 +0530
Message-ID: <20240411102226.4045323-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 0ZrYmMO7qn87kp6FbcJnWn9rKGvEvvPF
X-Proofpoint-GUID: 0ZrYmMO7qn87kp6FbcJnWn9rKGvEvvPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=795
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110074

Refactor the hardware cokie conversion initialization procedure to
support multi-device MLO.

This change is applicable to all platforms.

v3:
 - Modify the return type of ath12k_dp_cmem_init() to throw error
   and handle the error case in ath12k_dp_cc_init()
v2:
 - Updated the cover letter message
 - Updated the tested tag for WCN7850

Karthikeyan Periyasamy (4):
  wifi: ath12k: avoid redundant code in Rx cookie conversion init
  wifi: ath12k: Refactor the hardware cookie conversion init
  wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion
    table
  wifi: ath12k: Refactor data path cmem init

 drivers/net/wireless/ath/ath12k/dp.c | 79 +++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/dp.h |  3 ++
 2 files changed, 68 insertions(+), 14 deletions(-)


base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.34.1


