Return-Path: <linux-wireless+bounces-1417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570F8227BC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 05:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878DEB2239A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94717984;
	Wed,  3 Jan 2024 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G7PjCH6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AC17980
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40344GXX024022;
	Wed, 3 Jan 2024 04:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=NajBJAs
	BO8+UgBqH8ORa1new2evUUg6pY80SaUiA3xs=; b=G7PjCH6giTT0OiQFpbfwpA8
	m9JPYjEMorGx/1kp219K18LC12/I/YVCzsdikwaB6Fy7TzHVqHoLooEuD1bpvL1F
	oCJqdNVzYaUP2ezNqOQ8MSv0cJbdN9cX+xN8gT7uo2lOHU9g1sIYnffZXx1MlSUc
	8quazEnfbgRtRjOQkYQykifrKO23s/rJd9qTSQMMTuY6uLQe+ursEL2vwfLj10Sb
	swqI6+HbKIKSwM0unR0zbK98y9jDLXkZ/D6KpeQ9XGjN1VAK4qJHQ0gi0XpReFka
	5ZTU7jcYwYDZtFqF+lnXTH6e8IXXa/SKOXM5zv7JFmwYIiEy0Vy6Q0HPB9oTamw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcum10h7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 04:12:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4034Cagv021857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 04:12:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 20:12:33 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/3] wifi: ath: replace ENOTSUPP with EOPNOTSUPP
Date: Wed, 3 Jan 2024 09:42:17 +0530
Message-ID: <20240103041220.3082014-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dLedypDPTHGIHTaWZjCv2Q20hUEFb6D2
X-Proofpoint-GUID: dLedypDPTHGIHTaWZjCv2Q20hUEFb6D2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=433 clxscore=1011 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030032

ENOTSUPP is not a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

No functional changes, compile tested only.

Karthikeyan Periyasamy (3):
  wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
  wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
  wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP

 drivers/net/wireless/ath/ath10k/core.c    |  4 ++--
 drivers/net/wireless/ath/ath10k/htt.c     |  4 +++-
 drivers/net/wireless/ath/ath10k/mac.c     |  6 +++---
 drivers/net/wireless/ath/ath10k/pci.c     | 10 +++++-----
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  7 ++++---
 drivers/net/wireless/ath/ath10k/wmi.c     | 12 ++++++------
 drivers/net/wireless/ath/ath11k/dp_tx.c   |  6 +++---
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  4 ++--
 drivers/net/wireless/ath/ath12k/dp_tx.c   |  6 +++---
 drivers/net/wireless/ath/ath12k/hal_rx.c  |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c     | 10 +++++-----
 11 files changed, 38 insertions(+), 35 deletions(-)


base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
-- 
2.34.1


