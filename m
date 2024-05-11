Return-Path: <linux-wireless+bounces-7496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D28C2E77
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 03:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F271B2215E
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43B11718;
	Sat, 11 May 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WIW53QC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0F101E6
	for <linux-wireless@vger.kernel.org>; Sat, 11 May 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391427; cv=none; b=JyRVDScOn1C6ihw9NVOpaxykOloiLpNh5NooXme+UTGnEB9lq7fbQtpM40XYqSOzqjQXoMQHDzQt96aDmlLiEXqBI43dUb9kN+fWHbVS28H9v5wg2ol4a3sLkacp6dnZb3bsLaXAGdAwEDr+mXDGPQP4XVp9i2fPvwZP1FOYByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391427; c=relaxed/simple;
	bh=QhjOLNGquWcXpaq45dWYPSUKn8mxV+kmYIfSuZeKSKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1+OMAs8w4thSrWhA3r+NLkwPP50zybsII6Axi08G+jYtbm9ohL5AIEgqLqs8nnT6sd0Kq/5i7sYFk/x6iZlrePdvtJEXh+92U/iAV5ngK9ZLpraRfzM9TYw5Q1faOeFH/koFeo9UWedLezeg102nO3Ii2TNqMvBXNdwHyQq2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WIW53QC7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ALsILY018902;
	Sat, 11 May 2024 01:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=4QtdRZ4
	8kh2nRo8TQmxAbqGkLu+jDq30v95XB2ZMrsM=; b=WIW53QC75JWb/OY7xZ+PZ7v
	96z71PDbf1KNidN6Fk9cBRJdMnr55UMpASt0hDi20P2yLuM/k2DDk9FHafPzE5PF
	wSxMjnedcVqpUDPmeJM2L2hOALmz/L5DoFEwKPao3VN3/ym927tzOQgw+01RyrpR
	BX2ibXvaA0i+8RknHwAORjVsZue+BDoHAZNfeJhR5AFY5bZ4KEbFXWvpZRhK7vVU
	QUjsTJXFgJFLth5qY6RQ0+HnE3fo49NbKYNTG1SRtpDJCpZngsWPEm9kyGi0AP6X
	I+ARlasluT020SQrWNDnDHarp+9jN4pOv1uh8kU81X6+s6Qf/Picd0tS/vYbnDw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w12uu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 01:37:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B1axwo032566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 01:36:59 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 May 2024 18:36:57 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Refactor MAX_RADIOS definition
Date: Sat, 11 May 2024 07:06:42 +0530
Message-ID: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 4tvsXXVXD7DoHzpSKy-SG3DyVqMA1_J1
X-Proofpoint-ORIG-GUID: 4tvsXXVXD7DoHzpSKy-SG3DyVqMA1_J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=496 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405110010

Remove the duplicate definition and use the correct max value.

Karthikeyan Periyasamy (2):
  wifi: ath12k: remove duplicate definition of MAX_RADIOS
  wifi: ath12k: use correct MAX_RADIOS

 drivers/net/wireless/ath/ath12k/core.h | 2 --
 drivers/net/wireless/ath/ath12k/wmi.h  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)


base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.34.1


