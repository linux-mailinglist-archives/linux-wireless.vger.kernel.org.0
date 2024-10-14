Return-Path: <linux-wireless+bounces-13932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0592799C0B0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369941C2283F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B5F136353;
	Mon, 14 Oct 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i/C3jewr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030F1304AB
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889591; cv=none; b=kZOPD9cUwGEEOR7htvYezR/bRfRJzTpRKHyN/9COC6S1BRHs9i0oyHMbFmIugUYFP99IbUSPlGxSzDyeG3UwY5j0d3dVT7VpRWEgtDEjCWz/pHpe96GlUgynrBAC5E6otx7J/+Ju+BVtBWb1YWuk4j8gzqVk91ZXeavL4cNCgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889591; c=relaxed/simple;
	bh=DFNf9Okbd5m7HblERY1dzw6uyyh3U5U5qhrYyDHEdac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1kZ5ekBuklsJBEYn4WxM0qUtzDu+uyWrHDxqFAGac1Wnmnd+ujkHUCQjV2okRZLOPUiFipmLQl90H+LFLHsW8JJNah3bzMFstor77PZlWogXyEncmprTuwZH6sLc7PMfzqfotnVEgEWk7QaWraYeEbice7eBduJQQAVxT5H8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i/C3jewr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DLtM5Q021584;
	Mon, 14 Oct 2024 07:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LzW88KYx2rh7K3pnmAzuaD
	kXKoqhopS82U/nY4MyhM8=; b=i/C3jewrO2JFNb+1wMw9y6Y2JBeaIDR5Q0Xix/
	TOZ4RVchMFegI/DXuXHdy4lYdHizWoLGvF+cki14lR4t7gCiEfu6ZiZcajK6Nwjm
	9Jl5S9jhM1kqy7VdswoCyllKr+rzL8IyQGS3RvwoXf4XVNz9oRtaKCMwWrQ8QPAD
	UDfy+1vxgtO7SGwuYwiv961/zOXVyIO8NR6E5dD0XOqyq39E9SDrfkhId4LlY8rO
	7aNxcU9xBkVYdkBsStqemikODgTmjNbE/4StUUMUqPLrwDH6YZGOcbmuwcSaIay4
	1DJMdzwxAT+iNTGGnBEsjnyNSBdCKtDiLusGS9QRo42znz0w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hb33hx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:06:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49E76QqQ006187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:06:26 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 00:06:25 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Date: Mon, 14 Oct 2024 12:36:08 +0530
Message-ID: <20241014070610.3982173-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4VkFB6R8j3Pa11O5TtzmPOLDkohybj9V
X-Proofpoint-GUID: 4VkFB6R8j3Pa11O5TtzmPOLDkohybj9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=790 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140051

Add support to request HTT stats type 49 and 51 from firmware. These
stats give scheduled algorithm stats and BE OFDMA rate of pdev, respectively.

v3:
 - Updated dependencies.
v2:
 - Modified the API print_array_to_buf_v2() to print_array_to_buf_index().
 - Updated dependencies.

Depends-on:
[PATCH v3] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/ath12k/20241014065259.3968727-1-quic_rdevanat@quicinc.com/

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: Support BE OFDMA Pdev Rate Stats

Sidhanta Sahu (1):
  wifi: ath12k: Support Pdev Scheduled Algorithm Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 162 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  59 +++++++
 2 files changed, 221 insertions(+)


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
prerequisite-patch-id: d2dd6093ab264e75918406abce52bb9ee8199b7e
-- 
2.25.1


