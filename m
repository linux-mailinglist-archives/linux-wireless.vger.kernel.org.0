Return-Path: <linux-wireless+bounces-7631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F38C4C5B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 08:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4531C20C54
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A8F9CC;
	Tue, 14 May 2024 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OkdtwIEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3FD2FA
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668487; cv=none; b=KrJeH0Y96tObHV1Ovp5COv7atSVX1fXBCcpC4wHUKyqOQlu8iG+BmGUEHjHlSpMrhXTLHCAdXwgSN+hSOQSeq5D8U3RLTPPXOLHIJ2kcy1rdj8vUuudYcja7VgfYWGdZVZ9J8SuIKH5WrE2mgfi28y6iHHhpAI+C/0ga6UILFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668487; c=relaxed/simple;
	bh=HLnxb2+sTfYRApc2m9zJvRT2VYUJbhzl9w3AqwLBg+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJUYzEcfeRkvmvJOSP7/cqrXRQDiU7c+0r38mZWrKHy9ERijpkuwu/7CRp0+KTXJjO+tIMJaUeRcf8B3/SGMwzEGK9gtAceZJkeaoEz+/JclYgWVf4mdD7LDRQ9JIewzM7elwIGnO+qK79Lp03ApNJN/Cndn1mygLBpijp9Fd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OkdtwIEB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8d4W028172;
	Tue, 14 May 2024 06:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=6p7T2aF
	az5WsyP8sgTfL4t1EQoKqf/w+ySFzF0roSbU=; b=OkdtwIEBkv+RF8kA09wpt00
	gCwxsXahqXLGnWlk1owS2xOLsD2qlL1BlB+i9MPzSzi2fIa29PEZ0obRWfvSt458
	EC2rSTTqY5Sd2kuuTANQa0Q3CFo5nNFXOuxBqKS6028NAHd4+s8ne3mGw+8+neiJ
	Q0mNHMqv2dPOZJN/6x1WJD2B4u6nDrPuzS0fsIRwt/Wy4iIJgg1XIYviNY4yQWIu
	/2yrAG9CITXSP3Lx5lmh8akX2FoEmDFVnGxcJibkrQWDTKNXogCLDWVe0D/ViKfz
	B/eFIHAzy07j7MVGcaXBrRZqSTBNMZxE5+q5TYdLTD2tb9IT5NEn1JaGQaVDgAA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1yp5dg74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 06:34:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E6YZ18032275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 06:34:35 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 May 2024 23:34:33 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Refactor MAX_RADIOS definition
Date: Tue, 14 May 2024 12:04:10 +0530
Message-ID: <20240514063412.3483723-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: DtBVEIhLThSeXy0nksGl7wnv27YR32y0
X-Proofpoint-ORIG-GUID: DtBVEIhLThSeXy0nksGl7wnv27YR32y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_02,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=516 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140044

Remove the duplicate definition and use the correct max value.

v2:
 wifi: ath12k: use correct MAX_RADIOS
	- Updated the detail information in the commit message

Karthikeyan Periyasamy (2):
  wifi: ath12k: remove duplicate definition of MAX_RADIOS
  wifi: ath12k: use correct MAX_RADIOS

 drivers/net/wireless/ath/ath12k/core.h | 2 --
 drivers/net/wireless/ath/ath12k/wmi.h  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)


base-commit: 0ef7606c6012f05a1f5398e3a1964c35eb9c08a4
-- 
2.34.1


