Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013574647C6
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbhLAHVX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 02:21:23 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39612 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLAHVX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 02:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638343083; x=1669879083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=snIlwV+sxLCzduq92Ek2HVU6p8hvG/M08L5C2725WSs=;
  b=xTM1m7/s2ZW+qFIbby1076DB/o5+Kptm2809AAQ+Pacp/haU/k52XlDY
   O0FauzzE8tBxEEIjEyqIUj6P8xD64SBvPCX+mI5y+wKALkTRzcm6HawWE
   C1117utD5lL5SNOVeK9Yy+his1aZulda5SoRFLGM7HoR6vp+aAY0nhYWd
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 23:18:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 23:18:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 23:18:02 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 23:18:01 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 0/3] ath11k: add 11d scan offload support for QCA6390/WCN6855
Date:   Wed, 1 Dec 2021 02:17:42 -0500
Message-ID: <20211201071745.17746-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v3:
   1. rebased to latest ath.git master ath-202111221436
   2. add "ath11k: avoid deadlock by change ieee80211_queue_work for regd_update_work",
      it is to fix deadlock warning
   3. move "cancel_work_sync(&ab->update_11d_work)" out from pci.c to mac.c/core.c

v2:
   1. rebased to latest ath.git master ath-202111170737
   2. add "ath11k: add configure country code for QCA6390 and WCN6855", it is needed for
      patch "ath11k: add 11d scan offload support"

Wen Gong (3):
  ath11k: avoid deadlock by change ieee80211_queue_work for
    regd_update_work
  ath11k: add configure country code for QCA6390 and WCN6855
  ath11k: add 11d scan offload support

 drivers/net/wireless/ath/ath11k/core.c |  31 +++++
 drivers/net/wireless/ath/ath11k/core.h |   9 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 163 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath11k/reg.c  |  15 +++
 drivers/net/wireless/ath/ath11k/wmi.c  | 147 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  39 ++++++
 7 files changed, 409 insertions(+), 2 deletions(-)


base-commit: e5118670f6edde897ab17c3467efd24ad334fe7b
-- 
2.31.1

