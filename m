Return-Path: <linux-wireless+bounces-17486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368ADA106D8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37512164501
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316EB236A70;
	Tue, 14 Jan 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nu97r6Ru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C20236A6A
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858350; cv=none; b=o84IfUX//eiurETZcMQIeTvWD84A3zxlpf9myI4roR2qU4K07dPz0J4plxZL6lrN7WxKGTeUCzw58aQ8nPHStXP7xmjd7wDUL+9BvcENZQm8WmrMaMuuxemDWl0NS1vjHpy1BWUKXXyGQonEhB0BodCnTH/Yby29lHSBqBmo6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858350; c=relaxed/simple;
	bh=V+5OHhJ7uTxccJUx34iCK8Y77/bDlVRXTkZAZxLtgpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZClhDxTmaVYeAp+vIw2IbUYPAPDN5bJ/j1TwsSTBkkFGXDFqf//S+DK2Llg1/O9nfagKVkhNutrgIpp7kvsfXfx92U8sH6Uhkmxi7BzvHmQ69zi3TXr0TLlqpwI+KFdMCzN2uGiB5oNojJoLlg5a3Fll2InbWw6DQxGqyden6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nu97r6Ru; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E99Grh017465;
	Tue, 14 Jan 2025 12:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dFXykKR2iCChhSox2k80yN
	g20P864q10As0u6DjZjdM=; b=Nu97r6RucOt9Q7lJJO+Spw38tIVi2mBmC6MPyN
	GmlBRkUTmiDlWrXcTQhBv/reX/8B744GnJu/AExCD+f2syeubSaCHpWNvuOyAsnU
	WwgaHz672wScufZ4EHKbs0dqbkv5cP2wcAsGlySz8aXap4bRNqM6o+fpl6G1CLfD
	Tx8/tPgXB1aVE3MnJVwNZ3GvCLW0JfuAltysnE4AGKdtFQVoe2+oBrIPgKGqukkq
	Rmydm2hnnN5vnyD+LhqTROkr1W95V8S/caIJUQL3w71HnqSKfb5JT5Fw01BbgILn
	87jt7WGLqV1JGPLuvNJR+MuzWhcLRNW/tJsBaVZkCx/7f2Cw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445n1j0dtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:39:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ECd3dE029440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:39:03 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 04:39:01 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v4 0/5] wifi: ath12k: Support Sounding, Latency, Trigger, FSE stats
Date: Tue, 14 Jan 2025 18:08:30 +0530
Message-ID: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AzFF4Pk2tRtQtbRleVMhF4cOYfxyeg_H
X-Proofpoint-GUID: AzFF4Pk2tRtQtbRleVMhF4cOYfxyeg_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=857 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140105

Add support to request HTT stats type 22, 25, 26, 27 and 28 from
firmware. These stats give sounding stats, latency stats, trigger stats
for uplink OFDMA and MUMIMO and FSE stats, respectively.

v4:
 - Squashed patches to avoid build warning.
v3:
 - Rebased on ToT.
 - Removed patch dependencies.
v2:
 - Added line breaks where necessary, as pointed out by Kalle.
 - Modified the use of pointer arithmetic print_array_to_buf_s8().
 - Modified commit logs, as suggested by Kalle. 

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Sounding Stats
  wifi: ath12k: Support Latency Stats
  wifi: ath12k: Support Uplink OFDMA Trigger Stats
  wifi: ath12k: Support Received FSE Stats

Roopni Devanathan (1):
  wifi: ath12k: Support Uplink MUMIMO Trigger Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 269 ++++++-
 2 files changed, 970 insertions(+), 35 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.25.1


