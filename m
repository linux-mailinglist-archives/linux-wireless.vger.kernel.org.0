Return-Path: <linux-wireless+bounces-17831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E0A192AC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 14:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F443A0845
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A5211A3B;
	Wed, 22 Jan 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rw1MsWcQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E11BDCF
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552921; cv=none; b=DXwghiyeiCp0+44Q8QTCDlkX5k6EBwFXOOf20OEvdySqqQ7SVA4KvVsUBAU7BL6NzB1c84ztmTGutj6avR+at206yhc8Uz4sbLUmYHL9gFyYw9P21MwpymZC7v6oRU95Zdsk+R5BqNPoREj8wKLnno0KrPHt2vUwQDR+vqn18/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552921; c=relaxed/simple;
	bh=E8HdG3UMi+llUtuDcpyrKJVYiif2oUvkmXmi2moecwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QiH6yvN6gqeYUKfsQA1CAYQ74iwQy+7+JtGgbZaGr+zhX+VZcTnpBR/bV7DT7IkTh5pI9zOg3zWvhK4zr6OEODpUfvrW6A2FjKKkoGB4D3//sJuBT975IW/UZ4n4BeFlirz9y7jAHSmOUuhYrpNAr9MXOiFgfjFerSBpGkrrJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rw1MsWcQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MB7xZb001072;
	Wed, 22 Jan 2025 13:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SqiTWOskZbsEZ8QHQTA1VE
	9PhEQn4j1Muoz+orz0waY=; b=Rw1MsWcQ+vQZXp8tJenWA/zLLxbLX1yoCuSlbv
	ZYqwDnNIWQEan9TCSC34QTe1zwllz3vF0RwTfQ+oztVFQreFj9ijyaAK0sSut2wJ
	kj6JasyzPlNRkkSsCnitXLq9433venw2ATSwbXWzB3wQ9aX0HypLfjqemd2Hzcd4
	UNjSvn7VglPAqBM0BcizitBRCwy5yYog/GrGaum05FddoUhrYDJ/dM8rgm8kKFfL
	GmVHzE+kGnTP9Pa699FiuzS3fdHdTsurpiY4ZDDPOv9BFfEBQBw27gyR76Uq/UMK
	xEfbSAlN0aDZBRluAXKDsirKEh18zl3Yg9vhz4mcjTkY5XNw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ayhcra9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 13:35:12 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50MDZBn5012180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 13:35:11 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 05:35:09 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH RFC 0/3] wifi: mac80211/ath12k: add support to fill link statistics of multi-link station
Date: Wed, 22 Jan 2025 19:04:21 +0530
Message-ID: <20250122133424.1226555-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ae8d90gSuJMGu4dDpkc0KIdxUfsd1DCm
X-Proofpoint-ORIG-GUID: Ae8d90gSuJMGu4dDpkc0KIdxUfsd1DCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=626 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220100

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

Depends-On: [RFC,v2,00/12] wifi: cfg80211/mac80211: add support to
            handle per link statistics of multi-link station
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20250117124554.3719808-1-quic_sarishar@quicinc.com/

Depends-On: [v10,0/3] wifi: ath12k: report station mode stats
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20250115063537.35797-1-quic_lingbok@quicinc.com/

Sarika Sharma (3):
  wifi: mac80211: correct RX stats packet increment for multi-link
  wifi: ath12k: add link support for multi-link in arsta
  wifi: ath12k: add EHT support for TX rate

 drivers/net/wireless/ath/ath12k/dp_mon.c | 25 +++++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 21 ++++++++++++++----
 drivers/net/wireless/ath/ath12k/peer.h   | 27 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  3 ++-
 net/mac80211/rx.c                        | 15 +++++++++++--
 5 files changed, 75 insertions(+), 16 deletions(-)


base-commit: e7ef944b3e2c31b608800925e784f67596375770
-- 
2.34.1


