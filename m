Return-Path: <linux-wireless+bounces-5785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8189636B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 06:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11E1284EBA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AC44384;
	Wed,  3 Apr 2024 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IAn5eJ+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BB40BEE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118077; cv=none; b=DsPiQCslLm6Ki7+HrU5y1AeTe4GPTBYGf7bbomiiE8POGZXeLoOW1ZsjobcVu/qsii74tRtpCCME5MptU45rmbiv2cs6C3mEs4TeQQFCTx7X8latTp2v0EWe5ppSy+HCUpPV4S/sOeW4keOxh4zjI5BpcLHco9R7ZrZHCMAk2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118077; c=relaxed/simple;
	bh=6rj2fScOWOA08njn0VjCEJMZVYqyDwoFyJyVyuCwVLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R848gE9YZISx24dO3TEBLCEa7SkhhTJlsva38RfoEH2EY1ekUnGminmp20hI9UIy/m7upSacnO2PC8qsy1jCWcccQougJZ/sZJMVSNXAXb3DIoThYPSKNiIONCrxE98jjsAGPfjbcLlhx+lJM5XlHq/aseeTvREWKthCTq6z65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IAn5eJ+7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4334DDi8006345;
	Wed, 3 Apr 2024 04:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=c1Wh6AO
	WWSzunrNd2urSVns1955bw5YYsBFPeWuJIZ4=; b=IAn5eJ+7iMPdqtW1HYEvL4J
	cXw2rhSXetGVXGaAn+3HfsgodJ46GNBwbj4N5DwMXfxMGI2YksFkL0O1g3DOvhR1
	nSCaZt/782Iz3jNlTmZy7rB6QKh9Ejbe4uDD119nONd9b+D6YxzYustEU9POuK2P
	c+kwcKYF1JdF+8tJKGZe/MP0qVUP4kebovkDH63XNAMdoemEOrEJ6sWYvkuHywTr
	B4oBRoQhLwZo14UthjAu0tQGQr/DBq73N5gysk1zyJwB1MS6t/a/kb9Riaw2ct02
	EHFrq2liqUj6q9/G6UOeRLjh0ipBFI5dk+XbUi61dIlsZmFWBqnaIJrQLUfv5Pw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ua70fkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 04:21:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4334LAT2012246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 04:21:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 21:21:08 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/2] [RESEND] wifi: ath12k: refactor the link capable flag
Date: Wed, 3 Apr 2024 09:50:54 +0530
Message-ID: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3-nu7XYufsnDyaWW5JhyVlgBKaLoiZoo
X-Proofpoint-GUID: 3-nu7XYufsnDyaWW5JhyVlgBKaLoiZoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=705 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030027

extend the link capable flag to accommodate inter-device capability.

v2:
 - Rename the terminology from chip to device

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


