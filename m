Return-Path: <linux-wireless+bounces-14902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B49BC447
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 05:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1492F1F21F7C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 04:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24716BE2A;
	Tue,  5 Nov 2024 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cnoj65eV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79646376E0
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780325; cv=none; b=clNANCDhnxH0XvV1pzsSSQghnyVwiDtgK4VbcdFY8V48jkKsA7qAUKAVZxCU4kxlvEwgnB1ugSZZooPIMsMNWXQhH9wTfyCIoVDrmBo/nNoxORJxXvsvxMBLFoB04LMsai3T8ajxFjYzp3jr55ve+57tl0FeS8493+s1ZKHc10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780325; c=relaxed/simple;
	bh=HemS6j1CcDIjI52HDF8mptggeEnrOP1UI5f//aY0Sh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qaXyAAmi0YqJLM4Vxu+xa7mVe8Bn+LT4Fk1a+CrUXBf+ho25ed7sfNCzWLb4lMh6LuY1i7VzHnG0IO/n3mnaJIMQvJoqHvX9i8Tmzt8b8O7SNq1RaJYJ0N8lLCLXjYP6UABY7IWKaYCxQNVFb7cdM6+0tYEEQHQNsBU++mRXgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cnoj65eV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIjTo012122;
	Tue, 5 Nov 2024 04:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ycUlWrOY/pHCrQ2QjBmK29
	HvigH7sdArj1aB3IQ58eI=; b=Cnoj65eV9d+V715Y4OtuBngvXOjyihTXOdIVp+
	yeK3GIjkebiiP7q1mUG7tLCt6oDP6aZ8kjteJdcgl8KBts5IvyFsxScjsBWM7Tcl
	xLKCmpZfx9/TtftmruQPZ7/Lo9wVJpwCyPT520HuYsDf+uY8+OW5O3dpy+dgtsR8
	Bdey5idc0l8hoa+czUdeU1CtAAToMwgkxxJiTTmBWJaLdjaElve4tETdrQ22nSlb
	oEbXjgnNkGEdEJ050WojzZWgv7wSedOrPAtqcW4Y2BokkJU9i1Ny2c5F3ucBLeEV
	vO2OXPQTRanBOf7asIhqG1xE3YpyDjw7w5PKfCN2mMFQGTpw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd11xa80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 04:18:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A54IbbB014446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 04:18:37 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 20:18:36 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Date: Tue, 5 Nov 2024 09:48:18 +0530
Message-ID: <20241105041822.2039214-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e9JDxh3Xby1uYNQvC-QXm57wKkXKSNsE
X-Proofpoint-ORIG-GUID: e9JDxh3Xby1uYNQvC-QXm57wKkXKSNsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=883
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050029

Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
These stat types give downlink pager stats, counter and TPC stats, SoC
common stats and Transmit PER rate stats, respectively.

-v2:
 - Removed dependencies. No change in code.

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Downlink Pager Stats
  wifi: ath12k: Support phy counter and TPC stats
  wifi: ath12k: Support SoC Common Stats
  wifi: ath12k: Support Transmit PER Rate Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 627 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 200 +++++-
 2 files changed, 824 insertions(+), 3 deletions(-)


base-commit: e7e2957f403ba4655199f2ba9920c1a015a7be44
-- 
2.25.1


