Return-Path: <linux-wireless+bounces-5632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F58927D5
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 00:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616841C21099
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385F13E05E;
	Fri, 29 Mar 2024 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZxDVxbYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA1347B6;
	Fri, 29 Mar 2024 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755058; cv=none; b=e49wQnZGJlZa+Cuq5Nvt3Jd2LSohXL9m96jy8uAJlQq022NnvYaH0EBTsmO9DbC/2O3M2D6LcfqXxBV0tcv717H5ou/dOhH6eF6qsRMMnBXO1V7b0ydLBkX9Fz+AF0rwkeQN4dEzyN8g1vVMsPwAYr9xSgWPAzRqLdWhRAd+1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755058; c=relaxed/simple;
	bh=J5LIx5QO4UTpoH00UmARxJQQGAw/SK3Fu40quzpO/5s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=c2rPKQ8zufKizKK2o73OJc4xC60J3ehsmJicpA+L8jxDkLmMpavXmMT/mDbwqBHm17wMVsIwtvOsyasOqaoB5ClWQJJdCk2xHxteT07noDh2slUcHqVH0rF4Wq/L1Ev4mKXvuLjykNGV2mF9AhnvaONNI2xKpOnyl9XKyIx6ke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZxDVxbYE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TNTe54004354;
	Fri, 29 Mar 2024 23:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=jExMj2ePWMn70U
	E/9PCuqtzjYyxnKvP7hV6+ozEGZqY=; b=ZxDVxbYEqyBO+mIbAo7UlIhNmGL7p0
	XtffhcJumVtU9bDlOrHb9WTBjMV+r/wRP/YSmdq709z83asxxFIM2J6XL+Bf9fAP
	AKTOhh5nLRffvCcRrnRGQIvYv5aY/MYRvix59c9MDQ0dtc8p7kcCLD6LY+FB6+3J
	igNIyJ/B3BoNbuTJIbpEDAmTnNSzgeElDiWUF6N3+fTMr+Ay5Iube1R/gkECi4Iq
	mC6nzc16XZSkvNBf2atAfEfxnTfTHaERP1xQZWPAIR6jZkyhcM+ilr65dhntK+mX
	ylwdDAuQKtaVN9awo4E07h8D5/nVXrji+uNgQYjnYnlW6+QnwePGoEcg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89htey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 23:30:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TNUo8B014427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 23:30:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 16:30:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath: fix hal_rx_buf_return_buf_manager
 documentation
Date: Fri, 29 Mar 2024 16:30:49 -0700
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClPB2YC/x3MQQrCMBBA0auUWRuIMcXqVUTCpJ00AR1lkkqg9
 O6m3f23+StkkkQZ7t0KQr+U04cbzqcOxog8k0pTMxhtrL6Ym4r4clKdX4ITKovwkW9knEmUnUK
 vBxMGb6/QHl+hkOrxfzybPWZSXpDHuF+xRMVUC2zbH4Xh01OKAAAA
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YJ4gGW3Du894zrdNRYlDsqs9kfuJQ_yL
X-Proofpoint-ORIG-GUID: YJ4gGW3Du894zrdNRYlDsqs9kfuJQ_yL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=473 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290209

Found two instances of the same issue once I added the -Wall switch to
my kernel-doc command, so fix them.

---
Jeff Johnson (2):
      wifi: ath11k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: fix hal_rx_buf_return_buf_manager documentation

 drivers/net/wireless/ath/ath11k/hal.h | 2 +-
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: f09e3b774fe806ee0b1f2bb69771e8c29961e40a
change-id: 20240329-hal_rx_buf_return_buf_manager-4df5082f8b47


