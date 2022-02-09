Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B72C4AEA03
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 07:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiBIGGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 01:06:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiBIGAn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 01:00:43 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208EE019D22
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 22:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644386447; x=1675922447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByrhfU1w8cUviJV+Xsi3eZDVQVoAKiqYdGH2gesod1A=;
  b=G8hRXxfxMW7MmQFMiGr+EE2d94g08Ho2jwmK73kUX85sLNaBv4u7szkc
   ImsHJEvnFIetui/4SA8U6vM4eOvSUxxT+4ga6eY/uksX9bi0NVIML9LHE
   pLTjPGjo6jNKZKbdsDxUCfM1iyGA14wxZGWPc5z6ziKPMjMPorDBo8lx7
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 22:00:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:00:28 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:00:28 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:00:27 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 0/6] ath11k: add feature for device recovery
Date:   Wed, 9 Feb 2022 01:00:06 -0500
Message-ID: <20220209060012.32478-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently recovery is work success for QCA6390/WCN6855 without the RDDM dump feature,
because patch "ath11k: configure RDDM size to mhi for recovery by firmware"
added in v5.

v6: add patch "ath11k: Add hw-restart option to simulate_fw_crash"

v5:
    1. rebased to ath.git ath-202202030905
    2. change a few commit message
    3. fix count set sequence of ath11k_core_reset in "ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base"
    4. add patch "ath11k: configure RDDM size to mhi for recovery by firmware" to support RDDM
    5. move destroy_workqueue(ab->workqueue_aux) from ath11k_pci_remove() to ath11k_core_free()

v4: add patch "ath11k: fix invalid m3 buffer address"
    recovery will fail when download firmware without this patch

v3: remove time_left set but not used in
    "ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base"

v2: s/initilized/initialized in commit log of patch
    "ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base"

Add support for device recovery.

Carl Huang (1):
  ath11k: fix invalid m3 buffer address

Wen Gong (5):
  ath11k: add ath11k_qmi_free_resource() for recovery
  ath11k: configure RDDM size to mhi for recovery by firmware
  ath11k: add support for device recovery for QCA6390/WCN6855
  ath11k: add synchronization operation between reconfigure of mac80211
    and ath11k_base
  ath11k: Add hw-restart option to simulate_fw_crash

 drivers/net/wireless/ath/ath11k/core.c    | 121 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h    |  18 ++++
 drivers/net/wireless/ath/ath11k/debugfs.c |   4 +
 drivers/net/wireless/ath/ath11k/mac.c     |  40 +++++++
 drivers/net/wireless/ath/ath11k/mhi.c     |  35 +++++++
 drivers/net/wireless/ath/ath11k/qmi.c     |   6 ++
 drivers/net/wireless/ath/ath11k/qmi.h     |   1 +
 7 files changed, 217 insertions(+), 8 deletions(-)


base-commit: 76680d49b5e0e661bc4abcdaf13fb7e124b4ca08
-- 
2.31.1

