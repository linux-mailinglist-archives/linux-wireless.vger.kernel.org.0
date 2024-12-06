Return-Path: <linux-wireless+bounces-15973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA99E6F56
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DD028396B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F31EF09B;
	Fri,  6 Dec 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R+sW2Edv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CAB224EA
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492052; cv=none; b=JRcyfLEr76s5oLex90dPHXyNhzr5RNvYV8XSVzTkUmDE5JrdWqq4hkK1v8QB3flWcbhc12aXe7PVGqEhq51/cK39ayTwsPCC8jFlwE7TWwzNVo3iBREhY4vgHP0XfsgJcUpFuYkDv/CKLim+bnphtQCmj7N1bHzK19zftLYVc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492052; c=relaxed/simple;
	bh=e0X7PJtltyTiBUOeKIJj1523U/kSyuuHCmqani7zTmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q00ibx5WvwE/x8s3ZjmKmxjg2unvvyBZ9v2rgySvQR2QCB1PrCoPaHn1n55VR97NcldBN4JBOlxd73xOzBWgzy7BPg0iRtDkvyef0Id8oPqmB8xA9YOJYj313OU4ZYlgu9+a7Lw5XgJ2zJVSzm9IxEJ/wyehR6aYHBvqLnd7ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R+sW2Edv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67Pj5N003703;
	Fri, 6 Dec 2024 13:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Hn0HwqHrd9RV9F+5c/7IoZ
	Jrz3XpWrPTKPwWTUjAEjU=; b=R+sW2Edv7GFpxHpoHmcRh3qeurHCo7pbrOmpE1
	AHHqKW92yQ5xF8IMQH0B+eWRDv4mXJYrlbCTLBhxScxwF4rrSkQDzL0iA6j2/Zc9
	euBdTyq7qeRnYciC6ee0JEwezIj2fhk/Kj1/BQ4VKtP96eisgg1GugxreF3AmI0o
	iaeQ9ZwHOCpy4wQ/MV+lA8/e9QTO4cap0l38l1W4hOOao5YbgO7/rsA4TFNXI+Br
	hMxiTriOREuOKvYDzf9Q/gilT5IzqwS++XRQ/H4d79BoaZan9oio8bQNmSVrMsSY
	uDVXc91zycPybmCa9xcTaETpkrR5LTouU8Tv3/Fw+xGUzN/A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0km16p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:34:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6DY6tq022924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 13:34:06 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 05:34:05 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/3] wifi: ath12k: Support dump PDEV transmit and receive rate HTT stats
Date: Fri, 6 Dec 2024 21:33:52 +0800
Message-ID: <20241206133355.1990-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dmM6KHtO4LwSzBJO8mmcC7JUeu-mJqb7
X-Proofpoint-GUID: dmM6KHtO4LwSzBJO8mmcC7JUeu-mJqb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=597 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060102

Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.

v3:
1.Rebase again to 48322e474f04

v2:
1.use TAB to be consistent with existing code

Lingbo Kong (3):
  wifi: ath12k: Dump PDEV transmit rate HTT stats
  wifi: ath12k: Dump PDEV receive rate HTT stats
  wifi: ath12k: Dump additional PDEV receive rate HTT stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
 2 files changed, 682 insertions(+)


base-commit: 48322e474f04f671dc4a57fa2063e9402ecdc51e
-- 
2.34.1


