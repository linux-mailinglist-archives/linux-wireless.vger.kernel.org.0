Return-Path: <linux-wireless+bounces-10243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA6931EF3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 04:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF431F217D5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3C79D1;
	Tue, 16 Jul 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fQ4+b6DB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E904A2F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097964; cv=none; b=GiF6Ao6ZawglB1czzklA2dtfGJ3wbihs0FO9GRmkbSmC3Ry/osrqf+I1p8pxukkc8yd3Hgff8NQ90//+ES4bBRYXyyRy3maEhCULjuMjqr8LiJBGnZNC1m/oXXNx/WbU0zOWruUm8TLXqWYE8ahjmjIQl8mQScOgzeUOPJT7N5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097964; c=relaxed/simple;
	bh=rRbLzCXJJKx/W9qqWfnMbVkilPtH6ma4jYYfMT3LZnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGG4oqp1bjfFtcTZc8O9KQGM0a2m+VouAfeUUqhKVq9RuCz9E9RfVV4M+Gjbez1gDOkfa1VRtNoxOkoy7+Dq6AE2tKhRBkPfV53T7jA7OR1gBsEryDXnORYSIvjS/YmRA2JrTO1u3n9lshClETm6mQgnlVZE2x9A/Q4uPf/uGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fQ4+b6DB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH97Bq015665;
	Tue, 16 Jul 2024 02:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HlrV/8Y+FygII4Yt4prBFD
	MaBpV8EmhROCNCe5CMc+Y=; b=fQ4+b6DBC4wYog55MTnCjzMYqOTc7h85fm3U0O
	pGB5YAiYAMRsViDnGFGA07K+5Nojyj3Vckm/vyuJ8f1w/l8M8C6dHRXX80MDFfwO
	XPCW14Lfcel2VTs5ighBn8DsA2wmcJHS4DzIreKesNq8shIiLG42NpDmdz2UlDy6
	eio3HxeiUA1ts5zexdG2b/pUmFuwmHkY6kQC8j0+LlBPLUXKbD9QZZyr+YleDZmu
	sCmOFAZ+OZim566wuHHX7yS71m+EMPDy9IshNNTsC1tG8zSRgy9Rs1vtUa3spPRu
	2qT1+NoLHp4i1NhufkImOYwlSt3T2orcltUCeERn5nr8kmlw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhnunux7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 02:45:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G2jscj027593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 02:45:54 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 19:45:52 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Support dump PDEV transmit and receive rate HTT stats
Date: Tue, 16 Jul 2024 10:45:39 +0800
Message-ID: <20240716024542.30339-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G9swQc6K0iJB_NKP1QFmGRGTRoY3fkDt
X-Proofpoint-GUID: G9swQc6K0iJB_NKP1QFmGRGTRoY3fkDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=595
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160021

Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.

Lingbo Kong (3):
  wifi: ath12k: Dump PDEV transmit rate HTT stats
  wifi: ath12k: Dump PDEV receive rate HTT stats
  wifi: ath12k: Dump additional PDEV receive rate HTT stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
 2 files changed, 682 insertions(+)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


