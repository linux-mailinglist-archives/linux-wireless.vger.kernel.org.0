Return-Path: <linux-wireless+bounces-13327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204C98AB43
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAAD1F23505
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8C1990C2;
	Mon, 30 Sep 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TJy3hHL+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D44198E9E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718039; cv=none; b=NfgG5/ouUQVBwPmzAecapWjARir5u/oI3WePdTiowyOOn1iYn2T9RnRker8fWxEkuOzIkYqqXmfc+af42/Px3r8nbBhiIUMjwq0aI6ilN7ulvQjNA1eYIeDuMgJq0MX4LSzjhlqNIVgwrScbuozpgf924yPYI9f4IqU25X9y4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718039; c=relaxed/simple;
	bh=HpOO7cwUvfM3msQNR0DKOpDfa4iJGBZR1VX4E7ZyK7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qIUl+SkGQjX62c6HTnbWnh8rY0d/rfubct6Y6Mn/W7FJ2NdkJjAV1P7PJgwDd8AFYSqYFbys3XIzJWlER7not/cXmIejKP6/mqxYgDuUh7Tailzxd+0IvuToL50v4u8g9HkYH+QUqnd4zpvgEPohnY/6OJn1ADMPjYoXGQ6DiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TJy3hHL+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCDmEA018454;
	Mon, 30 Sep 2024 17:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a8lhSik6RlyktlYZWW5NJU
	0ZqJr01P+wjiX7IUh/yvk=; b=TJy3hHL+MD0QyjFxgacapRXb88PJoS5Qzfwbkb
	sVLilHc405RIVt/JLvJPtuxa8Br8I14Y3CBIC+K3LU3OTvTIbSmhaiLGPjvAAGu8
	KJtbZC9NTKkypZu2WGlpu6S8xL0e3c1TLiAC43JkkZRxrEdiW/TVALOVRk8rYCL2
	SVw3dP5FYjZCS1+YEW5sMu7ZjvkiubS6FGkr7JuMi1d6cGf4+T3m5ojSO+0jgEz0
	jzfY3F2TLIPa4YNs1DWEvmcJ0ede3/Rgfs6T3KbZAWZPYHh3p/WAlUunUbIp9i9s
	i2YrybiPoavP8kmLKn3IsbMoQHIauLfn/mQBPmQH7sNIgklw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12nkrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:40:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UHeXbi026288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:40:33 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 10:40:31 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Support AST and Puncture Stats
Date: Mon, 30 Sep 2024 23:10:08 +0530
Message-ID: <20240930174010.617123-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eUqKVDv0v1eIwzZ0hev91MclX48K2blI
X-Proofpoint-GUID: eUqKVDv0v1eIwzZ0hev91MclX48K2blI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=563
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300127

Add support to request HTT stats type 41 and 46 from firmware. These
stats give Address Search Table(AST) entries stats and pdev puncture
stats, respectively.

Depends-on:
[PATCH] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/linux-wireless/20240730035154.3723773-1-quic_rdevanat@quicinc.com/

[PATCH 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/linux-wireless/20240913082949.573482-4-quic_rdevanat@quicinc.com/T/

[PATCH] wifi: ath12k: Support Pdev OBSS Stats
Link: https://lore.kernel.org/linux-wireless/20240919101812.941145-1-quic_rdevanat@quicinc.com/

[PATCH] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/linux-wireless/20240926051110.2477814-1-quic_rdevanat@quicinc.com/

[PATCH 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Link: https://lore.kernel.org/linux-wireless/20240930171705.596703-1-quic_rdevanat@quicinc.com/

Dinesh Karthikeyan (1):
  wifi: ath12k: Support AST Entry Stats

Rajat Soni (1):
  wifi: ath12k: Support pdev Puncture Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 194 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  56 +++++
 drivers/net/wireless/ath/ath12k/dp.h          |  12 ++
 3 files changed, 262 insertions(+)


base-commit: ced1f8bd64cda4e0c1df0890d1041cc6b18d5c77
prerequisite-patch-id: 970109034faa25a7630720c0da29c875e821f9ec
prerequisite-patch-id: 0bda913781a634c055869a033aa9b34d10825a20
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 121409543edef60c5f6144dd7ae3a615a78520f7
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
prerequisite-patch-id: da5a4e5cc3097994bfcba4b37680c90b0675ccf9
prerequisite-patch-id: fcd0ce1adcc63e80c95e4636bd4614bd5b732ffa
prerequisite-patch-id: 13cdebd7e2d7d35eb1da839c5b94edb9c83f868f
-- 
2.25.1


