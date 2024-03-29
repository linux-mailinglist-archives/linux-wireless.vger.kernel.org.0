Return-Path: <linux-wireless+bounces-5510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F4891050
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FD11C24D3A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DFC11C92;
	Fri, 29 Mar 2024 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WJSMkoHw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD77CA7A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675460; cv=none; b=kEk9LTX1lE7Sdn64VxsCSP9uBdCiTRqRdNJddjYogrx4PjN0HKJZ4laP7rmYl9CvdXftLIqoZ5QiRtILVDP3fk6cMmI1nWO2HNhHJ5y68bLIuHCtAVWU7q87OnNT8f77eEOqAWEVwotY7zpcMgni9b7KR1NLTRvOOiWwcqiiU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675460; c=relaxed/simple;
	bh=Zf+HXsC6UMW3rqTCCGYReYAn1hke5w15iRI81/27jwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QNiD52uOV1xnq3WfssBlTliUDXjG6om87TAY2NsZynJICA92ZGJEZpsumas8alpedvnDKDZjId/Ui1NdTBQnAiufYEY2eNuId0uMn6J25CSBtfIXjsYdBfXbQ+/5cs+8/e8XVxuH52D91QuNwYG01/Xhu8N+ImFV87OrGdJonUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WJSMkoHw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T1DH9N013784;
	Fri, 29 Mar 2024 01:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=tZs1IwN
	SXUf9sxvx7RxwQOKT9KS83SAOymYigY3H/p0=; b=WJSMkoHwoWOmxucwT2oVTaC
	e954vm7uFyh94op4rPHD1M9m6vbdaW/vwmLyh/KAvk8YW122oUvJr2+rVF2bQorW
	koEPMQ91fCMggo/TewYg44rYkCxi0xA5gDT3WY7T4QmXaLpJNePyyO/e4Wj6qCh9
	SpkkeDfRFq9dvWyiGNpKz73GyASf9AzjREIUrAyiVzZPs/e2DQop6ANXShLvwImJ
	tAz79vFyknBeMIlAZeii7jxcLECQ/whc56zEpABYZBZgz6BnEjOSyqFzGpstWZAr
	E9ZhDYoxNvu/PVbphFFh2ASP8SRBldMWJs9qaBv/uComxc6oFWWBWGJkPWojx0Q=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aeg9djc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:24:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T1ODqp006784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:24:13 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 18:24:12 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: refactor the link capable flag
Date: Fri, 29 Mar 2024 06:53:56 +0530
Message-ID: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: sQs-2xfUKbUGASetaq1O7k8tstFT4A-A
X-Proofpoint-GUID: sQs-2xfUKbUGASetaq1O7k8tstFT4A-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=667 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290010

extend the link capable flag to accommodate inter-chip capability.

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


