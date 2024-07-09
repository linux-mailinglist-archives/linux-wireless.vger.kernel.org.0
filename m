Return-Path: <linux-wireless+bounces-10123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0492B904
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 14:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8881F2271F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2479156F57;
	Tue,  9 Jul 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UZiNXh48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8565156243
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526849; cv=none; b=ftla3EPIqhU2OIIdd7/Pn59RLFSQiXXyMf0yX7Ss4tkaBEXkR8UbQnD4WtgohvHkTHw2M9iJ++Skx+DaIWpeDU1PuSrcFqoizkKxI4/bEuh8sQFq6JB3Pix8hwZM54PT9rMxxbOfdWeWBWkG1CwQSZkF7j6LAEFgd2JgSVNfGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526849; c=relaxed/simple;
	bh=0vK8P8yTjWCoMz2pPAQefYc7hKOihyeAecjF5HptW9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LIF/rcGAbnn7LRkU4g8a1R5s03cyOnglqm40+y0FiZZGL5nrzg0mmXkdgVTVbX2wiDtQB7H5g4F88bZX8tyP0//xjTabpALeOUlROmM4hDokt6HWplWVChANTKSchSeiFbdUzMDatzdRLDx9h+BQhDUTWSpSmJ/PJaGiGJlDE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UZiNXh48; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46947dfs001325;
	Tue, 9 Jul 2024 12:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1nxtgf857iEugWwAopnSYC
	JEacEddrftkBPdG/ByHqo=; b=UZiNXh48GRZQSzLDkKqYgi9fwyAOzG1naWIOZr
	EFZaQ6NhFJCvihe0iPkGop2evM4n7Cna9nd+ZtiqHOFbGa4MuE43X880hxB1UTQl
	R0KbSyNmdrWlceofrzrX6oU5Mk+JlovQ1GK9hS0oZ3vzH/XInw5COvOMwXeQy5Ws
	dj3rYMfDCnbTpDvbJMuCQlGmpYz5RZnGxLv5ixDdsbIpeNHav+bAo/F/h7IkDeed
	F1JSon4LiYxBuPkvSVbZ/swdVpJRhwGyQFmX9t1sTwathQkTqmoOu0eeoLMxbyta
	UuHkTOIOP9cT3/sD+tYDI4Je2a2Hb8s1DBhqDjKWVpDPDbcA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8x91q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:07:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469C7LrL001581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 12:07:21 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 05:07:19 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v5 0/3] wifi: ath12k: prepare vif and sta datastructure
Date: Tue, 9 Jul 2024 17:36:56 +0530
Message-ID: <20240709120659.1564434-1-quic_ramess@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pgBsS0MK6aEycA43htAAMikzcFMK5qQz
X-Proofpoint-GUID: pgBsS0MK6aEycA43htAAMikzcFMK5qQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=683 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090080

From: Sriram R <quic_srirrama@quicinc.com>

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
 drivers/net/wireless/ath/ath12k/mac.c    | 960 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h    |  11 +-
 drivers/net/wireless/ath/ath12k/p2p.c    |  17 +-
 drivers/net/wireless/ath/ath12k/p2p.h    |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c   |   7 +-
 drivers/net/wireless/ath/ath12k/peer.h   |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  22 +-
 drivers/net/wireless/ath/ath12k/wmi.h    |   8 +-
 drivers/net/wireless/ath/ath12k/wow.c    |  59 +-
 17 files changed, 800 insertions(+), 448 deletions(-)


base-commit: 9fddbf081f2da3a20fecda0b58adacbf1379e304
-- 
2.25.1


