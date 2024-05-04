Return-Path: <linux-wireless+bounces-7171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F138BBDC7
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 20:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12221F217D6
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31EB4122C;
	Sat,  4 May 2024 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iU6e4UdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B484DE9;
	Sat,  4 May 2024 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714848763; cv=none; b=ajmBqL7efnftNk1gZ+Y9xGP66gQ7xG4ZRuc5hc3fMRWdKWL8hVDULwq8z4zdOOlMJEvw0PjGPBP6N+Gvo9D1wQEWh7X2oM+n0/oiRQNoP33KwPg8nvu+NKV4MZiUaAeQ7v+D+6jdgZkCvCnV+BD4nLyAUJYkIs4kydXpjfE/7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714848763; c=relaxed/simple;
	bh=Y9ShJCWSRiiIleehqq5IVNWJ59XwZz6UePqlTxPeFYI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=l/pvL8KEmyN4x2JSu1X1KwkwjUXAH0JHXI/0PU6MmQCrBVzxlK+c4ShJambf+2w9C1uru86+ApIigr8ip+9p57jWfM/Qx17eG6oc7q19K54OSWUEBDWL7vslXiQhx/7E3s5Y4zteKWVgL6zg2XegkPLwKxCy4sOEfhhWpv8li+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iU6e4UdQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444Hpqct010093;
	Sat, 4 May 2024 18:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=y+Pu2WbaurNiZH
	tsN5yWF43RlTvIiy0IdncUgCZe1V4=; b=iU6e4UdQlkLK30XcwnZnegIhKfkieT
	/X+kexxW+pfs8qI85ahjp70cgnTl+fNlAjHlal+3DljT1Blt6nnhm4g2fVYHsn8j
	0xePjHW0ZCaD7BFBN5GpfvWJSfKjtm3SfSpnE7hGjxjVUQsn4f9nyinVBArigMfE
	HEleR8nFjXr5747smmQIdPqgyYilWCg0y6f8g023R83jvpOYECpACHbQz9hlfhIS
	KkOAKmhIT4bAfgQx6ApT5OKBBLExz8L4nZPLSAjzVlGSB7rJ1OoP2ZIGKuAbxdeb
	uNJMjrtZEcyUcO935iJVkzwR0Up3rvGH+2wCZDA17QOdedlAVPAyGa2g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c1080-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 18:52:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444Iq9Z4032308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 18:52:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 11:52:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath1*k: initialize 'ret' in
 ath1*k_qmi_load_file_target_mem()
Date: Sat, 4 May 2024 11:52:07 -0700
Message-ID: <20240504-qmi_load_file_target_mem-v1-0-069fc44c45eb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANeDNmYC/42OQQ6DIBREr2JYlwYJtE1XvUdjyBe++hPBCtS0M
 d696Am6fMnMm1lZwkiY2L1aWcSFEk2hQH2qmB0g9MjJFWZSSCW0UHz2ZMYJnOloRJMh9piNR8+
 1dVLpWw3grqzUXxE7+hzqZ1O4hYS8jRDssAs9pIxxDw6U8hS/x4VF7vE/1hbJBVcXaRGVUwL0Y
 36TpWDPdvKs2bbtB4HxdjTbAAAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KFSPXwTnkF6OWmngEcwBFT3AHE4BTtCS
X-Proofpoint-ORIG-GUID: KFSPXwTnkF6OWmngEcwBFT3AHE4BTtCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_15,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=484 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040127

smatch flagged the following issue in both ath11k and ath12k:
ath1*k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'

---
Jeff Johnson (2):
      wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
      wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()

 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
change-id: 20240504-qmi_load_file_target_mem-5cd24581aad7


