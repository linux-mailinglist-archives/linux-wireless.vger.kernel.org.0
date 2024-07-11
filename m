Return-Path: <linux-wireless+bounces-10169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF492DE36
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 04:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE201C2116F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343954436;
	Thu, 11 Jul 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bEs2F9av"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5E3201
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663442; cv=none; b=hojSrbmUgbHsk0SYkKstDFwBxwU7aGpFItk+daf2QsfNsKN9yTrpV/G/X2m50LriUh6sv7wrKydEnwFgZaIHBPygaUfUl1odHbhsaHe75vVwBROqgtCwKZTSZOGIEN7qfTyAMSD9hHFdQkeRH0pKbu9BSpBsiTaHDjOKaPfgQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663442; c=relaxed/simple;
	bh=n6VyzK4Nzn1VLyCFSYTqanNKkUp6tA71Q9AX4CYy+G8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNlRZ+k0DINvSLSM8NSRELhNE+tcNAEjfS7YW5mK5PNBPk7a7ar9hfCF9Y4uqtt4JrfeFlVbdB6U/MLqEErkTcAJHL6h1FCfVtGrQKuVNfmt+TxLyL7XuArUvXyXPv9NdDok5FvWhL4Bklndrso489SSt5pMpQ+/sjgBKYUUqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bEs2F9av; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AKvp4Y024099;
	Thu, 11 Jul 2024 02:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yjJYdCqpfHav+VyOOUwBQN
	wQQoaukTopIsHU5xpJzzU=; b=bEs2F9av1S/yhiZt2hN03oQBZ6r0dB4oa2AzqG
	6Kq7A5Z/mdx8AdQc3Y0FIjaZ+B7fU5afYJygc8EIipU+dF2kK0E0xGD7fRajyEyc
	4ATHz+xPmXoywRjiudbQx5SQh3agsJeJqQzo/tg0ElYbzrSgNEw02u81z6g5cF4i
	+Bru2SAS9h9pQD552UVDsvT8oYjRjWCjMCoCz4BxeDMCXGayz/GUkfcKU+au4vEM
	0rlf0xF/tpqBl6czjBofvGMvzV6pKQfFHzYn7fYE9m0gDswucKl+GMWXvLKY5TVf
	g5jNrzAkaX7E4WodbltvUDJmBzPHTIW4+wpoKHB6dioXyfDQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hjje6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 02:03:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B23uIa028042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 02:03:56 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 19:03:55 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/2] wifi: ath10k: fix invalid VHT parameters
Date: Thu, 11 Jul 2024 10:03:42 +0800
Message-ID: <20240711020344.98040-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: FhsEVbkxKeBDKWEHhuZF08YQFpR1hcIF
X-Proofpoint-GUID: FhsEVbkxKeBDKWEHhuZF08YQFpR1hcIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=673 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110012

supported_vht_mcs_rate_nss1 and supported_vht_mcs_rate_nss2 in host do not
align with firmware's definitions, resulting in some warnings. Fix them.

Baochen Qiang (2):
  wifi: ath10k: fix invalid VHT parameters in
    supported_vht_mcs_rate_nss1
  wifi: ath10k: fix invalid VHT parameters in
    supported_vht_mcs_rate_nss2

 drivers/net/wireless/ath/ath10k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.25.1


