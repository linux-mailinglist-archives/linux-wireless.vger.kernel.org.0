Return-Path: <linux-wireless+bounces-5961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548D89B6AF
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35391F21310
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11917494;
	Mon,  8 Apr 2024 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oCySiLRo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA90747F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549171; cv=none; b=EWe6Lcqi8Dt4lC0qsU0hilaJbh3yUIhATN9c0YMEuMUgs3k4R028oCp666SO6ooWmoJLqqQJwSdjIxDzqhonsTgrQLsY9MxgoPrKYNc8xIEBJ2gLdFPKcRqIqn9F9bBh3GKL36PfHxx18sX5x1wOncK36/J3g75TBgyEjhbMY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549171; c=relaxed/simple;
	bh=L9GaWS3/4P1XTOfIR5rMqb5ZhNOpFtHJa6kVdERJVIw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i83rUga0zYxkORYy3HDrMNw7MQEUzEe2xcTMo4N2W7qtp3ShRJ6qLTnd29VrPsNAP6x/vpv48VFDYWJijuj2aqOX13+67g+u+ZIy9L9yQwwAayH5zR21zd8uOixq8yClVvY21mAmn2oMEQBPkNEISq8qY4jTtUTMZ7YrQHpYOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oCySiLRo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43841ECN022096;
	Mon, 8 Apr 2024 04:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=xXGeYFr
	AQ7N8NZ0T//i7nfEaH73ufHjBytqhp+VTURo=; b=oCySiLRoLXubglE+ZW0mTu8
	oeDGyILqiT8CCm3Ws4e58+tSXSl1C1U1E+dMGXltt2oE/1CJ1kTdYpHrBIznftR5
	6fZnUdoexCwruW/u0aK4EGJ49RDCYxPp8yprMH4jpq1LfmFbRdPLaNNdnRPpDi86
	+fBRESrG/jzeV9uUk5XK0ophBuHQxi9dZdb8yCGdj/Fn/epKNnpCZ6KyGmaJkLY5
	rUvUtJHaCMJYQ77fw/Qy1D9EdQKLu1Dt8J2F0NIN3xnIyKCe0ro4bmaVWCpbmqhy
	XeHtsaVpEETpDQlmS0x6p6n9nvbOg2IyEQmJcTxZItp2N0ix6l9ks3j9KaF7Djw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xc8jmr225-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 04:06:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438463n6025043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 04:06:03 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 21:06:01 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Refactor hardware cookie conversion
Date: Mon, 8 Apr 2024 09:35:43 +0530
Message-ID: <20240408040547.837639-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: w_XgLq-BYVFsoxmtzYnicKj46nsBqVhq
X-Proofpoint-ORIG-GUID: w_XgLq-BYVFsoxmtzYnicKj46nsBqVhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=714
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080029

Refactor the hardware cokie conversion initialization procedure to
support multi-device MLO.

Note: This patchset rebased on top of the patch "wifi: ath12k: correct the capital word typo"

Karthikeyan Periyasamy (4):
  wifi: ath12k: avoid redundant code in Rx cookie conversion init
  wifi: ath12k: Refactor the hardware cookie conversion init
  wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion
    table
  wifi: ath12k: Refactor data path cmem init

 drivers/net/wireless/ath/ath12k/dp.c | 70 ++++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/dp.h |  3 ++
 2 files changed, 58 insertions(+), 15 deletions(-)


base-commit: 007c5443ab7bba338f81bf6ebc64375257c6af41
prerequisite-patch-id: fcb51c7a2119a4453ec00f6ec726020f4104a1be
-- 
2.34.1


