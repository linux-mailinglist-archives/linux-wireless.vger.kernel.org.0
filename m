Return-Path: <linux-wireless+bounces-6030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2889DE9E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF331C20A68
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25713C917;
	Tue,  9 Apr 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FEBzemoF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BEF13C8E4
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675678; cv=none; b=pnoy71iEu4DjvpyAmEvLWGRLqioTzu9rVR45IHVS8j+x1xGzKuvpdlIBU4x2dpjJNS+sFOjYXxOUP4bk+hzKFZH6u3OLc1ASD/6SktTlsu1MyqMYCrlsujYP8hN5Caobhwppk3zEnyF9X8/fYAL0OKZdA8B5eGXkAPiok63LXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675678; c=relaxed/simple;
	bh=nf+cbSS9VdLxLc4FbGrrD2+QfgfW5f0H5QV9rbrt1vk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bX2t/POOTnX80pvIoJSt9jKcsmipWkAZxTwwsRhe3wgWgRbLXrQkrxf2mhIaHAWA9BBu/RSLZSZBhgCAn7g6VGYX8e/TlAao8lmZZ5aAGxWYNyLT56OJgXlWw+B7n4esk3583pXU9E09agbWqTvW9onDF1aiP8hP3mbO7YBljlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FEBzemoF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439ClPPl017090;
	Tue, 9 Apr 2024 15:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=pZFMvaV
	RGWB4vjflW7fMsGoUjf+JLzocJTgx9Muxa40=; b=FEBzemoFiFcnEGE7BPLpFpd
	FyLuQQqv8CppWZVlduk1CKWh59Uqlb3c5if/Gc4yn8g/YGL7ygZyxfGBlRrq/q2Q
	yI09dTtySfd6RikV3V6oUZFX+bwL+/BjgS6jGYWXwUw9OSAzWFQPLh+fpMB260Ou
	h4bF+lDzOsD76wDftfoCzn9PI11qmsbsA6wiSj6HVa4HlesOyxlMQvHIKp4xWWmG
	kCkMhQ76MAtIMzbaD5R/w6XhlxJHeEzIRYiozZzQL74f+zU0gCt68QjCZ4I4HRXx
	RZHbcvo8OF7Z2vxHX9yLgySITb94iIGNwpbMwHq56kprYVJnyfhm3+4MTLELauQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd4tjrg81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:14:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439FEUCU002778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 15:14:30 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 08:14:28 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: Refactor hardware cookie conversion
Date: Tue, 9 Apr 2024 20:44:11 +0530
Message-ID: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rCCzY8aEIdTHqJJdwdlcV5SFIFdENwC0
X-Proofpoint-GUID: rCCzY8aEIdTHqJJdwdlcV5SFIFdENwC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxlogscore=721 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090100

Refactor the hardware cokie conversion initialization procedure to
support multi-device MLO.

This change is applicable to all platforms.

v2:
 - Updated the cover letter message
 - Updated the tested tag for WCN7850

Karthikeyan Periyasamy (4):
  wifi: ath12k: avoid redundant code in Rx cookie conversion init
  wifi: ath12k: Refactor the hardware cookie conversion init
  wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion
    table
  wifi: ath12k: Refactor data path cmem init

 drivers/net/wireless/ath/ath12k/dp.c | 70 ++++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/dp.h |  3 ++
 2 files changed, 58 insertions(+), 15 deletions(-)


base-commit: dc410c4accd2fe64479a1f4ebc47ec9cd3928f4a
-- 
2.34.1


