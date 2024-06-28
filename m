Return-Path: <linux-wireless+bounces-9688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17A91BBE3
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C771FB213BD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14E115278C;
	Fri, 28 Jun 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zte6nZUo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A32139A8
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568317; cv=none; b=UU2xEedSazXn30pbonEOeykabTqdlQq1hT+t/Z4XpOZLDbYfoEGzht06CWdeHQ6FWssEQO4xhqu8rwZpoPMKwCFFdXD3XHrx2os3dKHLzUtAuMGluORFICZ7Caj1XVL1kylsjI5QuDN8FT1tYTtl7+V+U0CocLyp0NHWi/XEU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568317; c=relaxed/simple;
	bh=48iMHrflEPcJt7YNV3PWFanhopBL6C43vtSOlGoQBiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tncfaCAUuJBgW/Ic/InLzc27DcjZGaDPNBPRADttdqS7GQLIA79KQZw3yWZKJ43hTJTbWJLVsa6untosTJGgleRwHVR6qqsQWwfnG9ViixaETFi32jqo4gHHiN73A4bKULGgQ/vUcVY6OjBuEJdE6PN62o4IwJ+9KZAB5GES7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zte6nZUo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S4w2D2031405;
	Fri, 28 Jun 2024 09:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ktCaV5V2YBeoIP82uh0uG6Ji7o/7RRoVeNq
	nAwLkpGo=; b=Zte6nZUosYpp3jM3qSZTN1Y4Ta5JdCiQIslviklMqHNTIljnSBH
	l5S9hWa7HMqaXJhiHROsSU67X66ZKT/VN8CiknwqEocum0v9vOwcV3oDgBZSX+km
	y6cIRNQdRMP1quPXEKO2e5T3U/Db4a2Av5ZvFYBY932Kk1YIfxNeN3paE8yMuKMG
	ovuiC3V5V0CrWy2swXuE7rwoFVJsMBU1Vz+y2FUE22G1u6AoFDCa4SNZ3uFwuIWL
	QD/wpqC8j+rRxitH9pEFzMASZdHNck4uIRd41iVAsjwQnJIz3PU8EQufE7wgJqCR
	u/0fkLeeKYH3sUJlvSth9C8wLZBg6tpNb0g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm58ust-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:51:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S9pkOp017403;
	Fri, 28 Jun 2024 09:51:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ywqpmmm14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:51:46 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45S9pkxi017397;
	Fri, 28 Jun 2024 09:51:46 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45S9pjF2017396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:51:46 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 4EC4E410E0; Fri, 28 Jun 2024 15:21:45 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v9 0/8] wifi: ath12k: Introduce device group abstraction
Date: Fri, 28 Jun 2024 15:21:31 +0530
Message-Id: <20240628095139.292952-1-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: TA0IB9UdC0BdjrfS9kErUsJYHokG-VaO
X-Proofpoint-ORIG-GUID: TA0IB9UdC0BdjrfS9kErUsJYHokG-VaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=539 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280072

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

v9:
   - Renamed ath12k_hw_lock as ath12k_ag_list_lock to avoid ambiguity with the
     lock used for ath12k_hw
   - Added documentation for ath12k_ag_list_lock and ag->mutex_lock.
   - Removed the following dev flags which was helping to prevent following
     issues in negative scenario:
        - ATH12K_FLAG_HW_GROUP_ATTACHED - to avoid crash in qmi_deinit service.
        - ATH12K_FLAG_PDEV_CREATED - warn on seen for monitor timer
        - ATH12K_FLAG_CORE_STARTED - to avoid crash in dp free and pci stop
        - ATH12K_FLAG_CORE_HIF_IRQ_ENABLED - to avoid crash seen in hif_irq
                                             enable.
     and now, these are addressed in the respective modules.

v8:
  - Addressed firmware assert issue seen during hibernation scenario in
    "[PATCH v7 7/8] wifi: ath12k: refactor core start based on hardware group"

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

 drivers/net/wireless/ath/ath12k/core.c | 436 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/core.h |  91 +++++-
 drivers/net/wireless/ath/ath12k/dp.c   |  26 +-
 drivers/net/wireless/ath/ath12k/dp.h   |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 119 ++++---
 drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
 drivers/net/wireless/ath/ath12k/pci.c  |  10 +
 drivers/net/wireless/ath/ath12k/qmi.c  |  18 +-
 8 files changed, 569 insertions(+), 142 deletions(-)


base-commit: a2faca6591c2865712b68d76fd65ce017b815070
-- 
2.34.1


