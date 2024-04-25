Return-Path: <linux-wireless+bounces-6894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B98B2D02
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E22B24F6C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC66155A2B;
	Thu, 25 Apr 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D6awGZ5l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA1631
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083560; cv=none; b=rnQ+8v1VXXIfeByeiAxvgTaC9KK1fcjJZRdkbs+pZB3ubxENqCJzVEU2FmNA79VHkdggU4XhFNdCdzjNi1j/M+7Yfule5A68PtJAYqxI73+T4+qEzHVkohPQE37KqMhPg5ldj5hhKs5/uQprzkh4zfrgvMETaSWN9hUd9Akryn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083560; c=relaxed/simple;
	bh=GC7niiTU0GKR5ngKoRR7B8swErDBvVvXQ2mchq1kXh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Au91K6bMRrLy2cdRpYtp3vpzhSq2x/fSpxorUzqa/CQPbAz/eAXqZAYfTCndnoIRMHsbOtq6dQ1gnfY6RcVbKhYllsyV1/Iu3uI5WZ1q2OMj1H5fsYzn3QZrdYA6nCL47R3ybSAFs9ZAmNbTdEo1L46uTj3M4Sc3R/HS03W7slY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D6awGZ5l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLfUD1029834;
	Thu, 25 Apr 2024 22:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=3nBWnaVp8yS3J+faBPPx0KR6yw4DJa45lCgsv9/QSSw=; b=D6
	awGZ5l6T7gYCnCh7reGqcvL7+djZWyuct2HEy1UATsE5v2BGo6ETBGBvHRmi8XFx
	MViikYTX6tK0LSD2nX06UqJ67P2IX8Zxf63dnizfGhWkvNjkr0by05WbNdzOtxhI
	JxMV1VPfUzf2vCKabBxYMQxJ11pvXSPuX65GtV9vpI0T92XsJEL3Ma+MdKJ8fHB7
	nzCAgTPbBVoFFbauGyZFeqFiBFgEoJZFgz0pJMFt5/bTV5SxO9uJGCwSvzVtydH6
	gMOLH25Rd5Ah5pQg3qK2/YDabbJP20YSzjeREp7g8ydLgZsnUA/FjMCqERas7pAT
	A8CrSGYO48Zip/7xY33A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengkv19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMJCEL017333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:12 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 15:19:12 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 0/6] bug fixes and enhancements to 6 GHz band support
Date: Thu, 25 Apr 2024 15:18:56 -0700
Message-ID: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KjUZj2cW6xMMcBKMTzwc9IznZxRheA14
X-Proofpoint-ORIG-GUID: KjUZj2cW6xMMcBKMTzwc9IznZxRheA14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250163

In 6 GHz band, add support for
1. channel 2.
2. Fix packet drop issues.
3. AMPDU aggregation
4. SMPS configuration

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in V4:
 - add back missed changes between V2 and V3 - details below
 - add acked-by tag for patches 1/6, 2/6, 3/6, 4/6
 - add back missed tested-by tags per patch in V3
 - Add back missed patch portion to handle disabling SMPS
   configuration in 6GHz for WCN7850 in 6 GHz band in 6/6.
 - capitilize smps to SMPS in patch 5/6

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Disable smps for WCN7850 after review comment from Boachen
 - Added Tested-on tag for WCN7850

Pradeep Kumar Chitrapu (6):
  wifi: ath12k: add channel 2 into 6 GHz channel list
  wifi: ath12k: Correct 6 GHz frequency value in rx status
  wifi: ath12k: fix survey dump collection in 6 GHz
  wifi: ath12k: add 6 GHz params in peer assoc command
  wifi: ath12k: refactor SMPS configuration
  wifi: ath12k: support SMPS configuration for 6 GHz

 drivers/net/wireless/ath/ath12k/core.h  |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |   9 +-
 drivers/net/wireless/ath/ath12k/hw.c    |   3 +
 drivers/net/wireless/ath/ath12k/hw.h    |   1 +
 drivers/net/wireless/ath/ath12k/mac.c   | 122 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.c   |  10 +-
 6 files changed, 122 insertions(+), 25 deletions(-)


base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
-- 
2.17.1


