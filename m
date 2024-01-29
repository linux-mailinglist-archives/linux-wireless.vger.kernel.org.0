Return-Path: <linux-wireless+bounces-2650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38F840295
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 11:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE7328308D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078D55E6D;
	Mon, 29 Jan 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ST+W8TvA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3755784
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523318; cv=none; b=jKidroJevTcwkME2J2U8qcOS0mTbp0lky2tdWwXAlu10d1peJDdTvTYy+w3X633AciKJ6oqJlXVzlS7vZJUfY6sDa2tbY0cFzzXhb/TWG/InPFPYF5SIZ85m5Lri5FZlyDOPcTBZiiuRj7Wg3U97eA2BgH/jJ5vmcr7XNNErkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523318; c=relaxed/simple;
	bh=cYkPJSbLRvh2FTkIwARJZGkiy8CG83t8+hnN6fYPprA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZ+0tXh88fN9UEZRImVmCo1/Z8bLlX/CsYFWluaTwZePMtwi3jSP50xSPcCdUtEy3108yo2Wr8jzInHe/vsCH+nGGZeFhM23HVuKoroRr6mwB7Qb4EJa6TdyP2qzmH4srLE9KtXhwWZ6uCD0o/OCyiwFCcuZGM+KiaQFTtuEDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ST+W8TvA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7hnkw023511;
	Mon, 29 Jan 2024 10:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=V5oW0df
	Bics7ms/Y5IONfngAaUN92MIpwh8Y6XfpcCU=; b=ST+W8TvAalqJasksb5cuw1w
	qN01fW5OHX2hyEjoPc7hTSRh1cg1iQNhO5SaiDgoSxY2RMCpDf2CLQD0h2kvt9rF
	5q6TDc1JP8T5ZmVy8U1vfvadK3K/yhPHuTSvqojW2Qzi/aDz91fP0j82I1vqD17f
	8xyTxHOuXfT13SkMSpqtbg2hAB3oG0Glxp9ArHca3ydNc1kIP3MGIAOkMKpxD0S6
	SHqtCqe69GA3LbY0W02Y3uDHv1yqBmwmZ1T06pkMvXRbI3x0460bJkfMZZZWplhB
	tVzy/AjPehtd/WmuaOq6/T7eKoRqhefOY6EEorNaKmHsf5af6IgDKFfnZfh9A6g=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvtkmb9xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TAFCOp015690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:12 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 02:15:11 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 00/11] wifi: ath12k: P2P support for WCN7850
Date: Mon, 29 Jan 2024 18:14:42 +0800
Message-ID: <20240129101453.368494-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Rnv7L94ms42DWjzKCi9il-_T-YNfpcNM
X-Proofpoint-GUID: Rnv7L94ms42DWjzKCi9il-_T-YNfpcNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290073

Add P2P support for WCN7850.

Kang Yang (11):
  wifi: ath12k: change interface combination for P2P mode
  wifi: ath12k: add P2P IE in beacon template
  wifi: ath12k: implement handling of P2P NoA event
  wifi: ath12k: implement remain on channel for P2P mode
  wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
  wifi: ath12k: allow specific mgmt frame tx while vdev is not up
  wifi: ath12k: fix broken structure wmi_vdev_create_cmd
  wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
  wifi: ath12k: move peer delete after vdev stop of station for WCN7850
  wifi: ath12k: designating channel frequency for ROC scan
  wifi: ath12k: advertise P2P dev support for WCN7850

v5: 
    1. move patch #10 to patch #8.
    2. change commit log for patch #6 and patch #8.
    3. simplify assignment logic for patch #7(Jeff).
v4: add a new patch #10 to fix warning(Kalle).
v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright in patch #1, #2, #4 and #10.

 drivers/net/wireless/ath/ath12k/Makefile |   3 +-
 drivers/net/wireless/ath/ath12k/core.c   |   1 +
 drivers/net/wireless/ath/ath12k/hw.c     |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 368 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/p2p.c    | 142 +++++++++
 drivers/net/wireless/ath/ath12k/p2p.h    |  23 ++
 drivers/net/wireless/ath/ath12k/wmi.c    | 114 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  50 ++-
 8 files changed, 642 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h


base-commit: 17f4b952f067b1f87d14e6df4c8c216fe7a245d1
-- 
2.34.1


