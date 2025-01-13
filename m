Return-Path: <linux-wireless+bounces-17395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7BA0AFEB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825FE3A5A6F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57691BD9CB;
	Mon, 13 Jan 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gARnDFqZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38628FD
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752700; cv=none; b=P8yEE0Rc44TkQxymc0ylwhvmjmUbz4TZo5xa4vZ2Ma6CRlD9y7JbdP8AW+0ZWlaSz6EkI274+C2Z+VriacQHhzpJWOlxLqSN7c5Ipj8wzCBQX3OV2V7h7h1lYUfB/5QVdUNG739bjPnNTwFYAPoOxKwj4BG0WDnQ8Gdf3Jji8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752700; c=relaxed/simple;
	bh=ZmxPy5jDDj4+2ACGqmB47sbfRhCZnhG9OLeA25F+NXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ToPAB94rn2O6tcj082IDSvWL1vT8DYq10iO8QvLIcv+QLxsjoGZydsA9GPVZY8HzXr46bDIRrmfj3HJ+JEA99iLNj6TKxMs2Xre/dqYHOtwCtBLTEFyw2KYpHjNSlJ6bIQtllMeXj5h/stxo6zWEaw84PQnnQUxkIcZvyJSApLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gARnDFqZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D3rZbn023616;
	Mon, 13 Jan 2025 07:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AF73mtu5ZyVzqLk8Wa1hbL
	3EOf94Nk1s1HJHQn8rKyQ=; b=gARnDFqZ2WfxhmOzOfsxZdiBxb60PdcvbfaUn7
	EUY7AO3lAW1HGT4d40WW5ACzb68SL4F2YHwHOSWcY6qT3hpdepSVi5x0KzfFt14Q
	GlMnRVkIE88ulVcjzJg5ZukxsVAoEutQJLocUcZDAUkbKnFEyk2bdSTVp9WYgjB0
	fMxnlPQbQezAub2qZpkJ8TRyhfi99IosaJVldGPkhjfal0SzSSMuJTbFwFoQbmyD
	arrXwBUCwq9rmCBQ6wa31B/DnOMNoV0RSImQFnESGSWngl/XM0y4Uvv3OC4zq5G8
	GaiiOQW2N8gj4WUQw5jr4goOrH5BBjae5BQjmHF8T0R4T+yw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444uaxgcgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:18:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7ID8p032414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:18:13 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:18:11 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and receive rate HTT stats
Date: Mon, 13 Jan 2025 15:17:55 +0800
Message-ID: <20250113071758.19589-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7QRTNr0EuHi7IqExRJOJVrpA4NLU4sQL
X-Proofpoint-GUID: 7QRTNr0EuHi7IqExRJOJVrpA4NLU4sQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=582
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130061

Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.

v4:
1.used tab(s) to align the = to match the existing code

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


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.34.1


