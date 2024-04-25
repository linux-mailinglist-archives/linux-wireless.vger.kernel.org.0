Return-Path: <linux-wireless+bounces-6822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B78B1D51
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC141C22CE6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4E84D06;
	Thu, 25 Apr 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S+FS2ImN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27D84DF8
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035808; cv=none; b=RaLtrR+VXkWJE5dLQL1YIxwhVYFipoJx4rFUtlKHGFtw6a2uEbmzyNT2zD2dl/yhaO4g9LIY5QdGQRje/nOhVAUyhVm7uv+sAZcfRSWuwl5A9QlEagda3+1v/5S4sQbT48xD3Ap2khyeenRG8yzPzfsSU0UpqpMVSI51lkvtNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035808; c=relaxed/simple;
	bh=yRejAN+3Lk9hOZrKYFfVdOwQkR/nLbKAhHuR3k71mRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dyeyfs6P98qYiyPt8eXT7T0v6d8Bi3K9JJ7cFCwRT0a08Z6NnronwrX9y20Fm6TBE48ZwT00F1w0Q2SfzQ8ywjbxz5R4f5tCsWTx/kU1NJn95O7tpsFKo0XAwbtkA+OcWqhn9eiwaAHnB/z4L3jsU2/oNGAVDXgfdF8ECzNF4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S+FS2ImN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P8h0Mf004350;
	Thu, 25 Apr 2024 09:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=FzLMLRf
	0/Oul5pTj7sI17DYOoOnFuUynrgQFhLmmW1w=; b=S+FS2ImNV+lEUpgaoqFHpNp
	yqQPHcSGe0+wNLsOM3/XT8QIfDm+TBvoiQpz4++lPqBVZwxIb4li/o97dV2A5vZG
	NzA0qRckyMaZKTzoyJyLXDzXcAgYug3VClTkRS51G7+jBlznoEO6dPTrY1i6HMN3
	72KyJcJMQI5AdXl0BujC6zZmVEJf3EXmXe0oxgWpz1H+T6cZXC+xyjOAPTVc9Glv
	3eCRuIqrPA+PJp73iW4Iwn4qPYG7A5lb23tfc6aVadjLlo1oJb1dD9ZispF8Zphr
	/uOBGlzrgLjgoK9WMR+vPMAJxYveU/BL7xXjI8dx5IGGJVJkkCIV8jj9Ge0hPwA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenk9fac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:03:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P93LmE012593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:03:21 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 02:03:19 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/3] wifi: ath12k: Refactor the hardware recovery procedures
Date: Thu, 25 Apr 2024 14:33:04 +0530
Message-ID: <20240425090307.3233434-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CxI3AEWU6KX0lvQ0PrsHcj5BJKmlqcia
X-Proofpoint-GUID: CxI3AEWU6KX0lvQ0PrsHcj5BJKmlqcia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=527
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250063

Currently, hardware recovery procedure supports multi wiphy model. However,
to support single wiphy model, we need to refactor the hardware recovery
procedure. This patchset allows the logic to work both multi wiphy models
and future single wiphy models.

v3:
 wifi: ath12k: Refactor the hardware recovery procedure
	* Removed unnecessary conditional check
 wifi: ath12k: Add lock to protect the hardware state
	* Introduce auto guard mutex 
v2:
 - Rebased to ToT
 - Renamed the lock name as per the kalle comments

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor the hardware recovery procedure
  wifi: ath12k: Refactor the hardware state
  wifi: ath12k: Add lock to protect the hardware state

 drivers/net/wireless/ath/ath12k/core.c | 98 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/core.h | 28 +++++---
 drivers/net/wireless/ath/ath12k/mac.c  | 88 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.c  | 19 ++---
 4 files changed, 141 insertions(+), 92 deletions(-)


base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717
-- 
2.34.1


