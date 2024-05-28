Return-Path: <linux-wireless+bounces-8160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089F8D147E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48399283AA3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8876BFD2;
	Tue, 28 May 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pWusYMWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780254276
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878174; cv=none; b=AYW102lm12eALutTmF+eoP0iJfCxsTTRyeO7VDsZo8U2C3BbrQq8VOCNN9PaWAJ7jsFoe0T0zd62oWe92c5qLJgHJEZoYyGGuGPlfA4W345PgLXzm+nwd2Lss3yVm+YeNjED1ISBGup16KLWmThJjWtWxk2tdvv77eXKwz1nMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878174; c=relaxed/simple;
	bh=mhjxcVoTy9iNVFYxkg0IzftnYiV885lRAjkrZem8Scc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9wvEXrf7g7CDybpraoFHHFLLwnSI3CVkqWyZ6zP2yeq19/IK2qTOq9xxMzZ7HytDHBkC/6S9gwKFPeAv6xD1kdz8qShqSMqjnMHl0jYIMYyqxhaLWRn+9HJl6QsLQ+F33AFknmyVSyE0sg3/c5O2e8M30JfubXE3NwTXJETnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pWusYMWT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S0TIT9019859;
	Tue, 28 May 2024 06:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Mo/Z46WTuECJsHblq9BFHsnx7t0Todcz7Nu
	7ObxuXXs=; b=pWusYMWTKkXQ7ykHKq6NmC2Winz2WLctMtz492b8faw9DVPCNSd
	r/vShFOkIjDu7XWiSLekzaya9czsSKY1xMUolTJzaxm+tuykokHU9/HobQqgyLhP
	Ku5SVUnaEAvf+LIrbvOYo/VaxZlI6wQ58zOnd+hwAn2mn33l+R6ra/nQh4uLXs7z
	dy13ItcMeRIGbCZRNWNWKXLvkbXrvtfON0Cx8D7xb8D++VaL9WiEPnqOLCeabv4Y
	f5dwfYW+2RT+YytzOW+cYa3ZI9miNFfRq0LLGrHPB0M9DbHN38HncpWnLuaLkDne
	F3JdDjBebC1OtskW20QzNV7MZqVwzUxT4AQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qd8wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:36:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44S6ZvJi012665;
	Tue, 28 May 2024 06:35:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yb92kd5wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:35:57 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S6ZvwB012660;
	Tue, 28 May 2024 06:35:57 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44S6ZvTf012658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:35:57 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 5438C4114D; Tue, 28 May 2024 12:05:56 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v7 0/8] wifi: ath12k: Introduce device group abstraction
Date: Tue, 28 May 2024 12:05:39 +0530
Message-Id: <20240528063547.1400700-1-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: 6A3fk-FqxcEX-tE_WKO9fg80dQBckdZD
X-Proofpoint-ORIG-GUID: 6A3fk-FqxcEX-tE_WKO9fg80dQBckdZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=635 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280047

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

v7:
   - Added linux-wireless mailer to cc.
   - Removed Acked-by tag from "[PATCH v6 8/8]" as it has minor change.

v6:
  - Addressed smatch error seen on "[PATCH v5 8/8] wifi: ath12k: move
    ath12k_hw from per soc to group"
  - Rebased to ToT
v5:
  - on "[PATCH 8/8] wifi: ath12k: move ath12k_hw from per soc to
    group", refactor the ath12k_mac_hw_allocate() api based on ag rather
    than ab and update hardware abstraction array size in ath12k_hw_group
    as ATH12K_GROUP_MAX_RADIO.
  - Rebased to ToT
v4:
  - Modified the cover letter
v3:
  - Removed depends-on tag of "wifi: ath12k: Refactor the hardware recovery
    procedures" as it is merged to ToT
  - Addressed the deadlock warning seen during rmmod.

v2:
 - Rebased to ToT

Karthikeyan Periyasamy (8):
  wifi: ath12k: Refactor core start api
  wifi: ath12k: Add helpers to get or set ath12k_hw
  wifi: ath12k: Add ath12k_get_num_hw api
  wifi: ath12k: Introduce QMI firmware ready flag
  wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
  wifi: ath12k: Introduce device group abstraction
  wifi: ath12k: refactor core start based on hardware group
  wifi: ath12k: move ath12k_hw from per device to group

 drivers/net/wireless/ath/ath12k/core.c | 431 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/core.h |  87 ++++-
 drivers/net/wireless/ath/ath12k/dp.c   |  19 +-
 drivers/net/wireless/ath/ath12k/dp.h   |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 117 ++++---
 drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
 drivers/net/wireless/ath/ath12k/pci.c  |   2 +
 drivers/net/wireless/ath/ath12k/qmi.c  |  10 +-
 8 files changed, 544 insertions(+), 133 deletions(-)


base-commit: f8320064a28242448eeb9fece08abd865ea8a226
-- 
2.34.1


