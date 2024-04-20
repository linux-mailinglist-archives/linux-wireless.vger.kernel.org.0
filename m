Return-Path: <linux-wireless+bounces-6592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F258ABA52
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1E1C21228
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA41D524;
	Sat, 20 Apr 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DuHUStxl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69513FE7
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713602285; cv=none; b=XgJ7VWUQ8EwmmhMuTozIiF9qNj3bCGJo8jmNAxQW2EXT/PbjffS8+76j2OUe/Z5FF33QOp/9M22xLgRKwFH7fMZ2bbfYYeBy97UOW+nc1/s/27G39nfJMsVNWZEt1I+zQwPpG8EkgJIffS+YN5cLsO4Zfxnbx93kQ7nSeXuG5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713602285; c=relaxed/simple;
	bh=14m7mitYGSP3q1wSHOaRFLjwAZXsOGkBMGwop92QpN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rgmpa1E6SFwXWTBEKV40LP2RuLpuS7eAwac3cKEURVo51QeshnIEqBeIb75Yjdvd1ujecKhoWHRkSpoYfOAWNJO9i6JYNLX5y35DbJqLqf5PJoCx4nIynXkQO3V3dGHtGmBXoI0izWAtnMF5MvU96iNM7AgTeKXmoxoDkAWYm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DuHUStxl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K85vBV025115;
	Sat, 20 Apr 2024 08:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=bkQ106tqrmq3U9lHE8+t
	Sb5wUbvfkkNs49M8DlOen94=; b=DuHUStxlVy+zA2Uc3qVrGRUHJ3s1JsQYimGl
	J34ugTkh1c/l0OETHH1VaRnIPeeR8t4/c83zPQAIn9blImGNRDvcQhX0w/G6znzW
	Id/3Fs+yybKa2GqIet8bXQtkvWLFC/yji7munDay5WXZaRQoHcpabp7GjbVmZLRy
	0Vved1cJlZ4zGHCe4fkaiuF2QZLBsDqB2rj2v6hSJiBZFl44EeahOYt2odZNkOoP
	iI9NNXpLsbx8R+QmDhDD8s3eYqyKr2TpR1XfHEHV64OtU3vXmAqFPuyHp5ak6mns
	rrmvoGa7zmAbBnB9lkS9P3/0zZVWydYOwSn2nniKMhvPM2q/AA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm70cgagh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 08:37:57 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43K8ZpIj028229;
	Sat, 20 Apr 2024 08:37:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6sk95he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 08:37:53 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43K8ZpaX028222;
	Sat, 20 Apr 2024 08:37:53 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43K8brAA030172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 08:37:53 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id D4D4441171; Sat, 20 Apr 2024 14:07:52 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH 0/8] wifi: ath12k: Introduce device group abstraction
Date: Sat, 20 Apr 2024 14:07:42 +0530
Message-Id: <20240420083750.1545670-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HDGRTJ9A6pgEXKEvLkr72PdUlJBxE7bn
X-Proofpoint-ORIG-GUID: HDGRTJ9A6pgEXKEvLkr72PdUlJBxE7bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_07,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=702 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200062

To support multi-link operation, multiple devices with different bands say
2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
an abstraction to mac80211.

Device group abstraction - when there are multiple devices that are
connected by any means of communication interface between them, then these
devices can be combined together as a single group using a group id to form
a group abstraction. In ath12k driver, this abstraction would be named as
ath12k_hw_group (ag).

Please find below illustration of device group abstraction with two
devices.

                 Grouping of multiple devices (in future)
+------------------------------------------------------------------------+
|  +-------------------------------------+       +-------------------+   |
|  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
|  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
|  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
|  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
|  |         (Dual band device)          |       |                   |   |
|  +-------------------------------------+       +-------------------+   |
|                 ath12k_hw_group (ag) based on group id                 |
+------------------------------------------------------------------------+

Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
device 2 has one radio (6 GHz).

In existing code -
        device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
        (5 GHz) will be registered separately to mac80211 as phy0 and phy1
        respectively. Similarly, device 2 will register its hw (6GHz) as
        phy2 to mac80211.

In future, with multi-link abstraction

        combination 1 - Different group id for device1 and device 2
                Device 1 will create a single hardware abstraction hw1
                (2 GHz and  5 GHz) and will be registered to mac80211 as
                phy0. similarly, device 2 will register its hardware
                (6 GHz) to mac80211 as phy1.

        combination 2 - Same group id for device1 and device 2
                Both device details are combined together as a group, say
                group1, with single hardware abstraction of radios 2 GHz,
                5 GHz and 6 GHz band details and will be registered to
                mac80211 as phy0.

Add base infrastructure changes to add device grouping abstraction with
a single device.

This patch series brings the base code changes with following order:
        1. Refactor existing code which would facilitate in introducing
           device group abstraction.
        2. Create a device group abstraction during device probe.
        3. Start the device group only after QMI firmware ready event is
           received for all the devices that are combined in the group.
        4. Move the hardware abstractions (ath12k_hw - ah) from device
           (ath12k_base - ab) to device group abstraction (ag) as it would
           ease in having different combinations of group abstraction that
           can be registered to mac80211.


Depends-on:
        [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery
procedures


Karthikeyan Periyasamy (8):
  wifi: ath12k: Refactor core start api
  wifi: ath12k: Add helpers to get or set ath12k_hw
  wifi: ath12k: Add ath12k_get_num_hw api
  wifi: ath12k: Introduce QMI firmware ready flag
  wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
  wifi: ath12k: Introduce device group abstraction
  wifi: ath12k: refactor core start based on hardware group
  wifi: ath12k: move ath12k_hw from per soc to group

 drivers/net/wireless/ath/ath12k/core.c | 428 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/core.h |  88 ++++-
 drivers/net/wireless/ath/ath12k/mac.c  | 111 +++++--
 drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
 drivers/net/wireless/ath/ath12k/pci.c  |   1 +
 drivers/net/wireless/ath/ath12k/qmi.c  |  11 +-
 6 files changed, 530 insertions(+), 118 deletions(-)


base-commit: c416602943dd36fbd13af7496430723935c867a3
prerequisite-patch-id: a4d62344b11368fb7e549c03b6a31f7ba4c9e2bb
prerequisite-patch-id: b4a1e18a85d8c1e337fa133c2bd2956c33b11046
prerequisite-patch-id: b16edd310baa35e2500267e338f60c9a2e6594e1
-- 
2.34.1


