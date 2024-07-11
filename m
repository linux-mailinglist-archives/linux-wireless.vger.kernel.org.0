Return-Path: <linux-wireless+bounces-10190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9292ED24
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313312825EF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC116B74F;
	Thu, 11 Jul 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ky8dxd9g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203C16CD39
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716937; cv=none; b=R3jwtulx5yQFu7oVF9gCpZ2Guugg47U1SjQ0NKyoAkoqmuBCOcqAscHUvCeYK3wTmnyy32QSMTXRkmL9le7Ugv+hKqQmHCyaIr6e14AH9eWE6kkazBFBsRPsxpTi5o9A83ONEgXdHuvNwp7kysTkaRX1brMon/UNhTAxf6IQ1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716937; c=relaxed/simple;
	bh=DzM2RyjST8kCAWh8HHMyhChGhcm2I2H3gu9btCdHVbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5BmCy0jltnNx8k5Qa0s0+cW32ZvTcg1gQhTJsLbVb0r1kDQPvEzOGqBb0fbrvHjx3LwbLFxAvKQVtjQdYuwMiI0SMdp1GfKYptPZ75lHyq4G9akoz2Rdfsf2ayyS/QhndKrtkYpGwHzwkUf0K0MAK8hzI2ngDOqMfpSjz0+a78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ky8dxd9g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BClLx8014592;
	Thu, 11 Jul 2024 16:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LQueKXRoK3LwhqD68Op/iF
	tC4pK54uHYfxhWg0J95Fo=; b=ky8dxd9gE+mSIutsH6PD+jlhduPxoD4yAFjlGI
	K8zB72ALb9TukkdGkdZosc7CdJrBE1GCl/j4usTiMr3wPHsiTw7M/DwtiILE4+YE
	1bzOyngO/djLTF4TLu4E6cz5V5gCwKHj1PsfIL6ngO4axORaVyEt+ggCgwY1Bv6N
	hutZgS5R3HSttB7G5fRJGoFl21KnCf08AAqPaIUYMt+mQ4t0J0u8S4ouopo05hBo
	Qkk/wShlCbhP86MDMBvxuVRr7eKWrKnUdnMFrv5yojJkPdYbj0htsRDnEcJllIKT
	ik4hw3Ge9SSBtm6KnA+yUDzRzfkbXMWU84D47XhFwCt5tvmQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtmu31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 16:55:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BGtUxx010576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 16:55:30 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 09:55:28 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH v6 0/3] wifi: ath12k: prepare vif and sta datastructure
Date: Thu, 11 Jul 2024 22:25:08 +0530
Message-ID: <20240711165511.3100433-1-quic_ramess@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rnK_ecPLrst2MGG3qU8MN3DnNMy1aJqd
X-Proofpoint-GUID: rnK_ecPLrst2MGG3qU8MN3DnNMy1aJqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=811 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110118

To prepare the driver for MLO support, split the driver vif and sta
data structure to scale for multiple links. This requires changing
the use of arvif and arsta to per link and not per hw which can now
comprise of multiple links.
Also since most configurations from mac80211 are done per link,
do refactoring of the driver functions to apply these configurations
at link level.
Add the required locking changes to synchronize the usage of these
per link objects.

---
v6:
 - In PATCH 1/3
      - Updated comments about lock usage in ath12k_mac_op_sta_state()
      - on return cases released ah->conf_mutex() before WARN_ON()s
        and error prints in multiple places
v5:
 - Rebased PATCH 1/3 on ToT as few more instances of arvif were introduced.
 - Changed ath12k_vif_to_vif() -> ath12k_ahvif_to_vif() and
   ath12k_sta_to_sta() -> ath12k_ahsta_to_sta()
 - Used ahvif->link[0] instead of deflink as preparation for MLD in
   ath12k_mac_op_sta_rc_update()

v4:
 - Extensive rebase on PATCH 1/3 on ToT as MBSSID changes are
   introduced since v3.
v3:
 - Rebased on ToT

v2:
 - Rebased PATCH 1/3 on ToT as b0afabc4d7e0 (wifi: ath12k: add support to
   handle beacon miss for WCN7850) has introduced few APIs that use
   arvif.

Sriram R (3):
  wifi: ath12k: prepare vif data structure for MLO handling
  wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
  wifi: ath12k: prepare sta data structure for MLO handling

 drivers/net/wireless/ath/ath12k/core.h   |  91 ++-
 drivers/net/wireless/ath/ath12k/dp.c     |  21 +-
 drivers/net/wireless/ath/ath12k/dp.h     |   3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  14 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h  |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 962 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h    |  11 +-
 drivers/net/wireless/ath/ath12k/p2p.c    |  17 +-
 drivers/net/wireless/ath/ath12k/p2p.h    |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c   |   7 +-
 drivers/net/wireless/ath/ath12k/peer.h   |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  22 +-
 drivers/net/wireless/ath/ath12k/wmi.h    |   8 +-
 drivers/net/wireless/ath/ath12k/wow.c    |  59 +-
 17 files changed, 801 insertions(+), 449 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


