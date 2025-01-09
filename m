Return-Path: <linux-wireless+bounces-17251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231DA07FD8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F62188B9E2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B2199239;
	Thu,  9 Jan 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FF9VTgZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284391925B3
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447774; cv=none; b=lRsAVig55N1X6nrX7CFHTPhlub8Ga0J8tZJSbqfFGcISSnLynJztCVWedv7DFjnCYRNAkHA8mfaxfY+r7GCUwurnLcWEVyjV7AgX+1Iauo8xdIwYV6fHTr+3DOpSurCvXL9Fu1OK07p/XA/FOzaOrEyquj5p1GsLDoP8CtHzE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447774; c=relaxed/simple;
	bh=fK0nVKS40EpuW535Wc7JVlfoQknuEnQUi7Qb85+SfiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=anUnDv28MTOX8s1hrg+NZ6wzyCU+FrEBgpSheuNnjB9rbjSrag+OJ7OhNs48jVozM6ebDha5jEF+RUKclazVdeAU3mnQ78EOqTW+nANO0rHi9xwx59OPoHnGJ60yLpe6diu/NTd3PhsSciDReFaEUUizgUv3R91DSIGeeLWjC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FF9VTgZM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509ChPnq005368;
	Thu, 9 Jan 2025 18:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/Et1IsCtzzZvlBD9OpZHfk
	g1WgpYWpG4YSVPfrjuKNs=; b=FF9VTgZMMfNYKrFzUyJfhDkfy0F7pgXm23Mg/9
	03aKgFPTjTBCPPNfVlALjEvI6H7Pwuzqu+mLo2u14p1q1vjSaUVooZ14mWHjNM9H
	/5kTe58rcBuB2UjdiPhQgSFiu9rWohy0aoOs0H8VfF5V+Ow7XIaGCDmXqDYBvx4g
	vBCi7HqdPxmr13bQEJtBP2fytSt2lDHnRGLetDuR/biA9YEXRw7V3CcObBW8m00m
	aaMozcrayygjQMYlUId9F261HSuvwTP1o2q4sxRst9Uik632KaUW1s7+/HFgcGKp
	Sg0/bITkj4Yk1Am/ZZYmUOub1SAz+2Vg/evr7XXwcnwwNbTw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442epxgv84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:36:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509Ia8jQ025415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:36:08 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:36:06 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v6 0/5] wifi: ath12k: Factory test mode support
Date: Fri, 10 Jan 2025 00:05:46 +0530
Message-ID: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: splc9lkr1eH1HgUjX-zImDTojZQJWatw
X-Proofpoint-GUID: splc9lkr1eH1HgUjX-zImDTojZQJWatw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090147

Device is booted in factory test mode for calibration.
The commands are sent from userspace application, which
is sent to firmware using wmi commands. Firmware sends
the response to driver as wmi events and driver sends
these events to the application via netlink message.

Also added changes related to correct pdev id access for
fw test cmd.

Aaradhana Sahu (5):
  wifi: ath: create common testmode_i.h file for ath drivers
  wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
  wifi: ath12k: add factory test mode support
  wifi: ath12k: Fill pdev id for fw test cmd
  wifi: ath12k: Disable MLO in Factory Test Mode

---
v6:
  -Rebased on ToT
  -Updated copyright
  -Added patch[5/5]
v5:
  -Updated copyright
  -Fixed line length within 90 char
v4:
  -Rebased on latest ToT
v3:
  -Rebased on latest ToT
  -Updated Tested-on Tag
  -Removed second parameter of ath12k_core_start()
  -Updated copyright
v2:
  -Rebased on latest ath ToT
---

 drivers/net/wireless/ath/ath11k/testmode.c    |  80 ++--
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  29 +-
 drivers/net/wireless/ath/ath12k/core.h        |  13 +-
 drivers/net/wireless/ath/ath12k/debug.h       |   3 +-
 drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  17 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
 drivers/net/wireless/ath/ath12k/qmi.c         |   4 +-
 drivers/net/wireless/ath/ath12k/testmode.c    | 395 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
 drivers/net/wireless/ath/ath12k/wmi.c         |  41 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
 drivers/net/wireless/ath/ath12k/wow.c         |   3 +-
 .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
 15 files changed, 621 insertions(+), 90 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)


base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
-- 
2.34.1


