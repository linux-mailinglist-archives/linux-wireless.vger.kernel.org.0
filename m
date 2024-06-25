Return-Path: <linux-wireless+bounces-9518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C923915D91
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999761C2116E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 04:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535A1849;
	Tue, 25 Jun 2024 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e+pIfDnJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98413848A
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 04:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289375; cv=none; b=Z/h34XUdE5B8FJfMa9Ra9q9YoqOyd68CqERLz8fzEYKrVFji6M9v0lHvvGvMxhJe0uEsGHG+wjq+yexjYeT1bRYil080O3CHNK3J7Xdk+qZunp3PoZHRhNNM2S4gKVJHtWHKkYbcsIie64+4qaRctx2bOBh/SofJteU6InDxOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289375; c=relaxed/simple;
	bh=Wyrmrm7Sj5WeQj3vieIJsUusWjq7wMC8NrtQCfVTfZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=esvDS24TDhzvykYUWApCEwv8sApyLudn5Dn/FhgS/Scer0sRBXRcnjtpyhboSpOJs8NrXhgOJnlGvN1ZKHDYD3vh6c0Q5p5kCz5Nlq3Y1aWKGOcHoWILxd0Pt1hXrsK3pknEYU2kxhwPodALJZZeq+UT0RxX+6rlZ45/vnHPxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e+pIfDnJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OK6fFo018298;
	Tue, 25 Jun 2024 04:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=17qCQygTB5XebJ81M8MgHa
	dcSDIwRymvolV5Eux9huY=; b=e+pIfDnJTJ0qcxr23PpZ87bbhFxmUQnUNOnoau
	prEHjTrv8p+K7prbWaFxDOC1CRycEzBOw7Q24uK8h61llTORUrh8U0fTvDus6y4C
	9VkFupGbn3PqbzwWYGOMBLnGEvulU2XGFTjq9Kgq+3m/jIJjPRSl9/UjDrZA+GMA
	GrqSy47Q28fKV48bNlLRlbb1ikB+d+PU+WSHITwTiW697y62MHfsajjVS4sgkdEe
	lfVqjzeOr4V/iLebiw0E2esXg1PPpsm/G9if+leCq651U+cLg/Wzp151XxhZ/bgp
	60ScgzcxLmsrzsyvjTqIN2g8y65e37YlwToFbJqg+3qe8kYw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6nb9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P4MlZn002288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:47 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 21:22:45 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Support transmit scheduler, pdev error and TQM htt_stats
Date: Tue, 25 Jun 2024 09:52:14 +0530
Message-ID: <20240625042217.1303332-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: erX51HGCxNyhJ3sKKKhEIj7UNouNJz-N
X-Proofpoint-ORIG-GUID: erX51HGCxNyhJ3sKKKhEIj7UNouNJz-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=472 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250031

Add support to request HTT stats type 4, 5 and 6 from firmware. These
stats give transmit scheduler information, pdev error information and
TQM information respectively.

Depends-on: [PATCH v6 0/4] wifi: ath12k: Add support to enable debugfs_htt_stats
Link: https://lore.kernel.org/linux-wireless/20240624043845.3502520-4-quic_rgnanase@quicinc.com/T/

Dinesh Karthikeyan (3):
  wifi: ath12k: Support Transmit Scheduler stats
  wifi: ath12k: Support pdev error stats
  wifi: ath12k: Support TQM stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 784 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 267 ++++++
 2 files changed, 1051 insertions(+)


base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
prerequisite-patch-id: d01c8ec08d1c98d95876ca5eaca12993138536f3
prerequisite-patch-id: ca00fe5681f8f3a5e485700f3e8d32daa91f529b
prerequisite-patch-id: aa1475d182cf5cd996093ecf7645695decf9cf8b
prerequisite-patch-id: 7a864608c715dec904ed804a8df58e4674e30f21
prerequisite-patch-id: e60fe6bc8f57eba3d1461c74f659602912d820d5
-- 
2.34.1


