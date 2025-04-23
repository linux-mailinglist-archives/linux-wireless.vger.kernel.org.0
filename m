Return-Path: <linux-wireless+bounces-21857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0166A97E35
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03123ACAB6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626220B80E;
	Wed, 23 Apr 2025 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A+6GC/5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C326389D
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386942; cv=none; b=GLZb0xEJ8Yo2FNxT2Sc/tlYm9FEkVD0ntgmywWuZvF4TPSubfNUo2RL1oQYSo+w6oXyKESdAUPNtpOWsVrjC4VgMWohGfDfbGiK7TiF8fVPENBEkdgncmsvM/St9Oib9pfVZRV08+L8ZWDhXhktYc9Y/OaLNt8NSgCquGQQCr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386942; c=relaxed/simple;
	bh=ntxvOmTafrimB7NrL0Cy269+qYWL5fNA82nUeRpWmNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snKkrnuFsLWavdqmOVuqmFUJt5O+U7cAXqk8nLkx5VOst+3XE+7XAk9ZpkqkS8EJbJyQ9mCrc7pzfGkVNkHlZIV6p2Nv0BhOAfGxlNpIN02R+zU+IaeejE7U5cb4Kw5EuVVsrgiD8Twd49FZ2RIjfbJmqoLyGyyl/iZ+a9THWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A+6GC/5i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0i9dE022002;
	Wed, 23 Apr 2025 05:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SXMIGtezfeZB7Q6mxP/uAi
	nxio0dQh/TLPpfREKxASs=; b=A+6GC/5ihetrUn+R5WU8GFzfhZ1U8RS8xCfW9h
	p4nnBzxnqwFUGpqqKU6WP/dUJ4T2XB1eVZB9t1AbYwz6sQeG1+e0EohVRsMzAfWk
	TwRVUHnZg8mfnRQtwnl8Ni2azBeMxaAqtFwGC7ZDwgyXzI936pFFChPFI1r1yIFg
	csyH5PsYdRkAU2NbNRZNtxQ/7vvnevK2sJvix1on+CodR7LS/AKejoKu10dfXiJM
	0BnReIoVYOjP4oDTJ36Oi4RzddMpJCUbd0Ta7fkShViNYxevGSevO15IhrHMjD7M
	3/Payn27v0pHjSHbekaJCyOqw5yJQ4n1sxAkEL1STzH7KKCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh10yfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 05:42:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N5gEfe019702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 05:42:14 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 22:42:12 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <jeff.johnson@oss.qualcomm.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Miaoqing
 Pan" <quic_miaoqing@quicinc.com>
Subject: [ath-next 0/2] wifi: ath12k: support usercase-specific firmware overrides
Date: Wed, 23 Apr 2025 13:41:50 +0800
Message-ID: <20250423054152.2471568-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -1CIP2AHVmCWs6DFqiGPolnJddAlbW-o
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=68087db7 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=5mkN5bLxXfCjVL2fFVgA:9
X-Proofpoint-ORIG-GUID: -1CIP2AHVmCWs6DFqiGPolnJddAlbW-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAzNiBTYWx0ZWRfXxtEUxXbrhsw5 4SYqRP0Lkr890USb8MKMkn9rIrxWYBeHyu9dYwMQTv9ynLqdDxWRzsfjqMoCrJEQsi78Pqx6PnX kQ+ryG+1+LTdq7/cxLaXDM3ldZln/3iT6eQomlcFMl+jMfWqjxiapJd7C0LredVEWT/n6MeBNE5
 Og6ooISVHehovb7xXdEhv7gtfMhbDLp6keYk7T2vf5uM9TEuyeH4qMovTSnf11F1w7MKVU7mPld 65Wqepq44u0hwb+Zb9341678TZrBGW4jly5zhqj3E41MTsgvDkaE4FblWHBy0/1RN1gW0Im/JTs t360Fwa1ni7Rfw6/ILingC1dbcrw8IteBYi7hcCi6Qvj/kI99MexcN8SLvf1/oKLinvdn1WVt5q
 wThzZ0PQYFpk48lO1Iy1pBJe3atJn6W8X7HZfkPIdpLpfUxSA3IEBqBmkBjeAT9klfBlo3PM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_02,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=908 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230036

Introduce 'firmware-name' property to allow end-users and/or integrators to
decide which usecase-specific firmware to run on the WCN7850 platform.

Miaoqing Pan (2):
  dt-bindings: net: wireless: ath12k: describe firmware-name property
  wifi: ath12k: support usercase-specific firmware overrides

 .../bindings/net/wireless/qcom,ath12k.yaml          |  6 ++++++
 drivers/net/wireless/ath/ath12k/core.h              | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)


base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
-- 
2.25.1


