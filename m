Return-Path: <linux-wireless+bounces-16765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E059FBF1D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 15:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024181632AF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878D1E4AD;
	Tue, 24 Dec 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KP0boG/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B34689
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735049999; cv=none; b=BvtYL92NL1ZQDFohujLRD+C6DRbFXyXcNebBJ+gc1qDdkHxrOVuLD3/2QkEQxFOZPOvz/lpoIMJrWYJlqFtV6+BOPg8g+K5dksPseRT2rOPHT3MxDKKfPzfX+KizfqGD6L6zNeYQfx5fFcBgseo8cehz01yxY4FZGFWBZOhYwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735049999; c=relaxed/simple;
	bh=D5+1N++Lq+AtEK5BO7DTl5lgyyOPBr+oGTZChmV/3/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WHB4yrBtUpLfkx9Kti4g/QnV3+4k732rfiyODrIRUtFwNPrUAAV4XuDFTCMvUjQIYgernB63NN1X/bSM6n6xuiqywf0Ld57wBS3NHdm7kY9To5MaYA3qgmAS/KQAq4hqXOWambNg4NWEKXky0H7aECa8JuTOWGTST3jEDFka3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KP0boG/G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCG5bL019778;
	Tue, 24 Dec 2024 14:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VcbSq8SZXZrRBbVqyXVy47
	Yz+wSKBL9cXCv0nJ3m1tM=; b=KP0boG/GaetV+Wo+gEzY5ge7bwaTq0Uur1iceY
	sGxsVIQyE/k5T4FX9XVSwdJ0k2ISQObom7bHpbX/bbpHzrMDylBUag+d5zWqtE1+
	nmaRJhT7udxovf33qIIXnpZGLoL5wZo7kBOy8tTDkEUitrURluo9x559LqXRRys4
	FHeApWHbGlgpeyKB28oWURA4ttusgm1f73v4PlhAKiNb02nJqe39X9WwQoNJ0Mna
	5648swSpynNEMony1w8sLuuur8bJI28TgXBIZIuVWS9JrO4+OoKw5Nc7AMBNtQ08
	JuQTl5uY7Y7Pxm5PVvxxBUMdUmY9ujDG++8Kg/HHqg5i+1qA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qvt80m9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:19:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOEJqCo008291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:19:52 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 06:19:50 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath12k: Refactor monitor Rx handler
Date: Tue, 24 Dec 2024 19:49:17 +0530
Message-ID: <20241224141920.129339-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 8f73seP44no2edu0cHWpUPJ64sgcm5Th
X-Proofpoint-ORIG-GUID: 8f73seP44no2edu0cHWpUPJ64sgcm5Th
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=572
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412240124

Currently, monitor support is not added. However, in the future, the
monitor will be enabled. Therefore, refactor the monitor handler, which
help to add monitor support in the future.

v2:
 wifi: ath12k: Refactor Rx status TLV parsing procedure argument
  - Updated more details in the commit message

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor the monitor Rx parser handler argument
  wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
  wifi: ath12k: Refactor Rx status TLV parsing procedure argument

 drivers/net/wireless/ath/ath12k/dp_mon.c | 60 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |  7 ++-
 2 files changed, 33 insertions(+), 34 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.34.1


