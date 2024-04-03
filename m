Return-Path: <linux-wireless+bounces-5782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C728896357
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 06:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00711F24454
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489B1C280;
	Wed,  3 Apr 2024 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PNCmpAGH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848225235
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 04:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712117074; cv=none; b=cq1Pl8Y44/v6rGQL6CxVmXnIPJUhloycEC6pxN7VB+yS2VaoGZ7d+dJ+NXAJNmEBDaNXJEYYUV34g9foSm9EqEQNKTOKdGHQ29ddPr2OClYtFAlGr4WZfJzy5NjBUsDA4y4XnfNaFlP4/KiUaxGBTLKLjUtqHQg3gsD8JL8FmYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712117074; c=relaxed/simple;
	bh=119GENvBxg3NpbZuvY6VyyWj5H5JiGk2ZBr15Iuzi6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dzyMA6LFI19gGWtpD9g0IIU7+DUFZCFX0E2TiSo3TyDpHUn1T98wJRkCPCrZCY2phOrOJUYESDd284VaIHMlkJUEISoKA2eq6YRZXCMCy0pLIzZROdUF3RU+FZUzlVHl72ugql7EydaKdn/sTZCUqQlQVTITt+D/4zB+S5ao3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PNCmpAGH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4330e8LG021471;
	Wed, 3 Apr 2024 04:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=xbf39Cb
	wInbk5sessCKl3ze+tveoelgISHqsY3taBHw=; b=PNCmpAGHe70cYgKP7xg/jsi
	SPAe9WZpAXXVVTAapMApmKrWEmslMAYQTNHXdy4XJQ68W7m66gxSr5TceQI2sXBN
	ijoV9ScFIn/mIrqUPEdQBog+j9OHVpCmgkUPOA33Tq6splk1jpVZftIsjmC9ic46
	joAvdHMS0F34e30IJWB+WCm6GVA+2Zi92Z5kLwUOFupXWniu82GjU+7xQ4LK/1jj
	RAQXRmrY4Ie2ubVEXFmzmcXeWkTVU+qwbutgeqBF1yUCCALKHh8Sp23nwNwE9ZdJ
	X2ocm+iOXTRyOgM6Mtwk+DKXO41KItjYJUzc9OE7KJw6BteWqdrXf8Eq6AdUoXQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ex7tn3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 04:04:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43344RSs014139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 04:04:27 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 21:04:25 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: refactor the link capable flag
Date: Wed, 3 Apr 2024 09:34:10 +0530
Message-ID: <20240403040412.1488095-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 5xZXU95etA9n06Bm94Sl5dO1Lnbb5gpR
X-Proofpoint-ORIG-GUID: 5xZXU95etA9n06Bm94Sl5dO1Lnbb5gpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=624 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030025

extend the link capable flag to accommodate inter-device capability.

Karthikeyan Periyasamy (2):
  wifi: ath12k: extend the link capable flag
  wifi: ath12k: fix link capable flags

 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h | 23 ++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mhi.c  |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 +++-
 4 files changed, 25 insertions(+), 6 deletions(-)


base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
-- 
2.34.1


