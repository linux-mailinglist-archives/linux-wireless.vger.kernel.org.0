Return-Path: <linux-wireless+bounces-13558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD599165C
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D402835FD
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D4136331;
	Sat,  5 Oct 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PSMpDt7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEAF9FE
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127376; cv=none; b=msIa3pDtsaNcZdLk30smA4uh9Xn1Y51HPxEbo5mw0+gRKXDMWfY0E90Rr86Ud3ANNQjO2cOLWy4CNkjExIAJDrgiSzfJhogAFe7XlX+ILdI1fxK9vAQAfey0ab8rckp8m1r26fz/lWoUE91BgVex9Dx5OrHP6TlozPTkpIWKsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127376; c=relaxed/simple;
	bh=M5p0zKVMVBAqZ4fWJelyjUnvwyLsrgnuMLtXoApGkLc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y3qzdkWnm2ouhTdeqWxPQqu1amR7Qcq1y/Wzpj2URziw4noi3IcX4/d7iZPDmV2UpoJL7COVGQM0WSYAv3g07gO6lRF5OPUGwQ8kpxYpdophdKDrVKLZTCHjSoxdHCmArbEtdl//GfVi48NLaXnMmSrBJMqz/8Cdk4YtFu2Nj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PSMpDt7k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495AfNj1020926;
	Sat, 5 Oct 2024 11:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YWD7kSkm3gxhUh0GGU7VF+
	JPsewywvG++qF30umrp3M=; b=PSMpDt7kepUa9G5/6v7fxxvvdAq0Gc8fj5fxK5
	KJmOcbX9Z+3sV/v5Ct0J78sv291ZgA+4H/UD2KSAsG3PKP5pLMwLhjZzkX7wR1j7
	OXGEge9unPJFt1SF4C5S5N+CDDecbVdFC27+v/9TCe7A1fUOwbv20R32PqVpAUy5
	siX4qxbrRWC0e5j0oQ777Dm3w8SguVVf6szX6rJdkWvMUFZvgew49eddUdW4q2V8
	kzRbczIKQ++MuI4BCoqDip/aHXHprD3G5grl8KiTKYgVdr9EOcOhY5a8gO7dQFsd
	ck7LccQpNeJdJW7PG2MgkWCCDnbwmoqvl6uKzA6K9kRXROGA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs80f5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 11:22:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495BMpVT025177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 11:22:51 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 04:22:49 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Support AST and Puncture Stats
Date: Sat, 5 Oct 2024 16:52:32 +0530
Message-ID: <20241005112234.3379043-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: OiUuYqiJD7SNoOJsBkh_wwDPL8FguF0v
X-Proofpoint-ORIG-GUID: OiUuYqiJD7SNoOJsBkh_wwDPL8FguF0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=608 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050083

Add support to request HTT stats type 41 and 46 from firmware. These
stats give Address Search Table(AST) entries stats and pdev puncture
stats, respectively.

Depends-on:
[PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/

[PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
Link: https://lore.kernel.org/ath12k/20241005104206.3327143-1-quic_rdevanat@quicinc.com/

[PATCH v2] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/ath12k/20241005105207.3350790-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Link: https://lore.kernel.org/ath12k/20241005111506.3361688-1-quic_rdevanat@quicinc.com/

Dinesh Karthikeyan (1):
  wifi: ath12k: Support AST Entry Stats

Rajat Soni (1):
  wifi: ath12k: Support pdev Puncture Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 194 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  56 +++++
 drivers/net/wireless/ath/ath12k/dp.h          |  12 ++
 3 files changed, 262 insertions(+)


base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
prerequisite-patch-id: faf46024c8b5c094e201d392109e7f94dcecdd49
prerequisite-patch-id: c4662f64bc7be141322b7e37145e52ea4ab4e182
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 5959fd18b497d29cad98d36dcce59a876ffe8ca2
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
prerequisite-patch-id: da5a4e5cc3097994bfcba4b37680c90b0675ccf9
prerequisite-patch-id: fcd0ce1adcc63e80c95e4636bd4614bd5b732ffa
prerequisite-patch-id: a6303524834f6e01b2ae1469ee437d586dd5d522
-- 
2.25.1


