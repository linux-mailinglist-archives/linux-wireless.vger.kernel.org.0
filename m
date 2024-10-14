Return-Path: <linux-wireless+bounces-13936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC04499C113
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B122E2831D5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 07:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D98145B26;
	Mon, 14 Oct 2024 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iI6HeI2q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A814037F
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890263; cv=none; b=HaZkga3fynpqnav7pCP74eDKCaxWYIWVhkuN3Rf7f88YXLvhGG+yAqXntqMPIWqmEtoWd/lkftsRH9AvB+tNVuGjRgavVRMW9P0Q10EIPRt3w8MqS8E1tdD+7HxwZcERN3ZacL5yqmzmdkieWKggaYqJ8wLEgP+7l2GqnDPn7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890263; c=relaxed/simple;
	bh=Ff6M6lheRh6jwzAsCEOYbdOib9rCBy/E4q9XN6QwsOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRalwMkX5VbN2hYfXPooj394LPjTZP43HCcpqI2CNcqqQ/Fa5xmYN/JQDi710jKjwNJV/h1QC8ieztriOjk+FrlKX+xz54M52MyWQCdCB2C/wPHwxiade8YJbeqWiGLisl7yRafXeRxY/saxyQCSXRg9CkWdo/T0O25KXiqZp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iI6HeI2q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DMkpdI005635;
	Mon, 14 Oct 2024 07:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u86Occ3O9UOpS4sfPQ3f0y
	m4cxorKIi5aElt7drH5oU=; b=iI6HeI2qxDXUM/sBdwcFLG6QfO7pHrukzqtDIG
	XRwFVS8joRViwZTIE1l+P4PqnVe3u1kETN4Qh8dfJEPKrW+GzTXcf7JbquHHcSyI
	qrjP1d9OnHJrCYVk39k+uKY2zod9xpGFzvqUWyX3O2ywvlgU8/ONlcOvYMO5uFyH
	Kow/AyAZ0++N+c0LmS5rmxpdX4bzKush7kXaaM3qzSU3UnmDFNnk54LCtOQyUqUa
	S4eGz1LuXPAAbo+2lPZF/pPX6Ggh4tC8w+fXhvfyLvcHA3k63iHN6UTild83pL8L
	4PvBrsG1JBbID9lfP4pXwz/wVBYccm1bbkLtOMbJWzBjMQfw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427h6tum1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:17:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49E7HapA006991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:17:36 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 00:17:34 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath12k: Support AST and Puncture Stats
Date: Mon, 14 Oct 2024 12:47:18 +0530
Message-ID: <20241014071720.3991199-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 4JJ9CCZyHxVlJLNepLnlGIG3CoL12dWI
X-Proofpoint-ORIG-GUID: 4JJ9CCZyHxVlJLNepLnlGIG3CoL12dWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=712 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140052

Add support to request HTT stats type 41 and 46 from firmware. These
stats give Address Search Table(AST) entries stats and pdev puncture
stats, respectively.

Depends-on:
[PATCH v3] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/ath12k/20241014065259.3968727-1-quic_rdevanat@quicinc.com/

[PATCH v3 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Link: https://lore.kernel.org/ath12k/20241014070610.3982173-1-quic_rdevanat@quicinc.com/

Rajat Soni (1):
  wifi: ath12k: Support pdev Puncture Stats

Roopni Devanathan (1):
  wifi: ath12k: Support AST Entry Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 194 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  56 +++++
 drivers/net/wireless/ath/ath12k/dp.h          |  12 ++
 3 files changed, 262 insertions(+)


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
prerequisite-patch-id: d2dd6093ab264e75918406abce52bb9ee8199b7e
prerequisite-patch-id: fcd0ce1adcc63e80c95e4636bd4614bd5b732ffa
prerequisite-patch-id: a6303524834f6e01b2ae1469ee437d586dd5d522
-- 
2.25.1

