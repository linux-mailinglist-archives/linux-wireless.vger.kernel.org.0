Return-Path: <linux-wireless+bounces-10691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F67941CE9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FA128A12A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF418A6B1;
	Tue, 30 Jul 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPaT4VpB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF218454A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359404; cv=none; b=CL/pLBVPucoPVZwE5KXPxiYZvGg25zXn1V6FDvpX4YiAP0IBVC7ogs1/E4oMo6ZP28YhORFwktHvIL1qHgPzFRBWUZb+bFDi+Odlr5reO4ZC11e7SKWMBTBqgtXPViX+KT22XDkGefUbvfgJnoyGjvYKFUrR4CfGCDOHhCB4JcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359404; c=relaxed/simple;
	bh=wa2CB2T3t7zAJKTcen67GciCCZCHQ0Hp8alWzMg0u8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/NJypbrvVOOmbgTmvaTmSaY9b6cKnDbrXs4BZis+ZfHza864h5k6GLINVuN4ala6wKe38U/1PD2ctmOlqz+p19IPgNB3E9q5UDshB7dKSqid8/0g0epY0RtTy0SZ76NVdh6fXKar5nmPPW5J4frGCbDFvcPPy9OY6+iLBYtZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPaT4VpB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UEZvdc027549;
	Tue, 30 Jul 2024 17:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZFHLLtB2Yc9A6GQTG33ZMm
	q7qds9zHREQ1yGfwC4g2A=; b=gPaT4VpBwYcX3r3/ooRXS+wo/YyUF3gH1jukCB
	pGsiRS5mlJ5y+9I4wmU1w9YoAC8VAo9H8QN/FeYX1RYxXlOP/5dfEZ7qPyApkdso
	LFnulO5w0F0JQ5l+g9GofH3s9iNYId0fGdAZEjFf5zP6zsUnSwTZ0Aj51LHDQ3kV
	T4x4z5f8DwpddDGBTq9qEWN9StQnGMuyGS37f13jSBB4r7Zfu81q2KCULzieE/94
	n8hMOkMBt/sQvidETHcguRw5zeWJ+9SzodS2fnA2/xZcd8ylHpXVUenBkUEO4/pg
	DKUnvB9Z9gqWUytkJKqc5qCiVwlzGbXTMAcGomxPlwwVIjCQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q232rhat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 17:09:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UH9fAa011485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 17:09:41 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 10:09:40 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Add support to allocate MLO global memory region
Date: Tue, 30 Jul 2024 22:39:08 +0530
Message-ID: <20240730170910.3281816-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: mza_Js91wqfnvEpiStntdvYcgeRQaaTp
X-Proofpoint-ORIG-GUID: mza_Js91wqfnvEpiStntdvYcgeRQaaTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=585 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407300117

To enable Multi Link Operation (MLO), QCN9274 firmware requests MLO
global memory (MLO_GLOBAL_MEM_REGION_TYPE). This memory region is
shared across all the firmware (SoC) that are participation in the
MLO.

Hence, add support to allocate and free MLO global memory region.
WCN7850 firmware doesn't request for this memory type, therefore this
change will have no impact on WCN7850 device.

Depends-On: [v9] wifi: ath12k: Introduce device group abstraction
Link: https://lore.kernel.org/linux-wireless/20240628095139.292952-1-quic_hprem@quicinc.com/

Karthikeyan Periyasamy (2):
  wifi: ath12k: Refactor ath12k_qmi_alloc_target_mem_chunk function
  wifi: ath12k: Add support to allocate MLO global memory region

 drivers/net/wireless/ath/ath12k/core.h |   7 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 190 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/qmi.h  |   1 +
 3 files changed, 155 insertions(+), 43 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
prerequisite-patch-id: 9f11ba698b740286374ae7baaa0d40d3b3efa7ba
prerequisite-patch-id: 8bf59833c98c85c6aebb52378ff8b323dc082811
prerequisite-patch-id: f8075a6e30a91260aaa31d0b6b115f9243568d62
prerequisite-patch-id: 68ac72de019bf6c8485daa086daef7aef301bd84
prerequisite-patch-id: 06244ca08d9bed3834dc5315470a19d096d749ee
prerequisite-patch-id: 843ba59a8b315ddac081ad0c8ea9bdabce054373
prerequisite-patch-id: 47b63476fd4d8f34e8bc64c73a04f8a7c294416a
prerequisite-patch-id: 6bfca81d9f8674838d11a2987bff8bf039fca55e
-- 
2.34.1


