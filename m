Return-Path: <linux-wireless+bounces-6525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBE8A9A74
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E915A1F2217D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF56143C4B;
	Thu, 18 Apr 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="atcht9PE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547B143C4A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444997; cv=none; b=d7XMwoJUlMIJqiPPWCEr4mKv76S1ThXIeSM18Q604A7fYZEC4bNzksiNKQR0uPoScYjPPwINRKBwRzEWW8mY+FbrlVtz6wIPwQLBND3ij4X5mquY20B6+ZS6zGmV/5uOMI1X+RKolaxmQDoi2q/ldpPUhv3YmtiFnXnpyv5Famg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444997; c=relaxed/simple;
	bh=rdVxpv5K2zDXZGiIrndxY6BxqMkwi1kz62OyFZuBvf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RSPNHlB7eQh5mktdT7VZh6tg9HXomc7wOOtd4cBUnU90QAWPuoX3BnKhejmCQfqYDNILGevtyeTrU57p9upI5Q+mqcxnqLNS7mVPJTi5oEh6WJlHEYg14zrtyY3eC/wxTwEb9o8Qiw74s/GVrdo6vRBM8QTfo7y1aDD986C54rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=atcht9PE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I9059C026889;
	Thu, 18 Apr 2024 12:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=pNTX1g+
	H1x0NYEeOCz14mXhfnnVR9dJL2viKrmO5tuM=; b=atcht9PEFIKokqmGyxWi+A9
	QIWmZ9mfHG2YYPwL+2Ri2H2myMJkPcYuGMk/Zf+8g9W2ObbV5wWCaEWcXXXqcUes
	j/qIfP1Pv+A2TwaP2JJ+6mkZFBrjgUomEqB6CqQYUIcgga6evA6KUZwBTwO4fgMA
	lU2o1H9g+PHhk5cFbUJMlO7knB1gS05C37YlNJtlF6ePDS1j9PXgFMFFybTCOnTv
	5HcYgmCAPvihdaNkyWje0uqFmxXhr1Va/fodvf+eDbJ3ttwyjAO7cIn/5AUAt3XN
	AEOV8ersRLpEMZsa6NT3LFpaDsepv084AgZXGJMCiytKZ68sJHzE7kb64F5Hrfw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk0gm0fb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 12:56:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ICuSD1019413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 12:56:28 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 05:56:26 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Add support to set mlo_capable_flags from QMI PHY capability
Date: Thu, 18 Apr 2024 18:26:07 +0530
Message-ID: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F2f9GXA0lnRRZWP2ji102WrH7nvmn0dJ
X-Proofpoint-GUID: F2f9GXA0lnRRZWP2ji102WrH7nvmn0dJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_11,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 mlxlogscore=684 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180092

Currently, mlo_capable_flags is set to zero if dualmac device is
detected based on One Time Programmable (OTP) register value.
This is not generic and in future dualmac devices may support
Single Link Operation (SLO) and Multi Link Operation (MLO).

Hence, add support to read 'single_chip_mlo_support' parameter from
the QMI PHY capability response message. Also set mlo_capable_flags
based on 'single_chip_mlo_support'

Raj Kumar Bhagat (2):
  wifi: ath12k: read single_chip_mlo_support parameter from QMI PHY
    capability
  wifi: ath12k: set mlo_capable_flags based on QMI PHY capability

 drivers/net/wireless/ath/ath12k/mhi.c |  1 -
 drivers/net/wireless/ath/ath12k/qmi.c | 40 +++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/qmi.h |  2 ++
 3 files changed, 37 insertions(+), 6 deletions(-)


base-commit: 448ef71a317cc00e2ec0c1edcefbdf6df4b3e46b
-- 
2.34.1


