Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8E4C4062
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 09:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiBYIqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 03:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiBYIqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 03:46:39 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FC235318
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 00:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645778766; x=1677314766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8IMlfcAq27Ka0YnMzbwPQW1L2g8qqQgVqD9u0cyrUGk=;
  b=UGYkl7+DLAjAvmhxgcXNfmhcI0Uji4bA9sw043/vlh1gxD8UytHgHBi5
   L2+3riyGtcdBiTkayMUtXckcEnk+9ulK7Gkhre6+RobbNesrUTR20NSm/
   yckf7/k490Dj2VG+6i+vvJ/a8kUOEK1xJbKQ+7+4CkZEF/cFJA9AWQVON
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Feb 2022 00:46:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 00:46:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 00:46:05 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 00:46:04 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v7 0/4] ath11k: add feature for device recovery
Date:   Fri, 25 Feb 2022 03:45:44 -0500
Message-ID: <20220225084548.19534-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

v7: 
    1. rebased to ath.git ath-202202211030
    2. add patch "ath11k: fix the warning of dev_wake in mhi_pm_disable_transition()"
    3. remove below 3 patch which has upstream.
       ath11k: add ath11k_qmi_free_resource() for recovery
       ath11k: configure RDDM size to mhi for recovery by firmware
       ath11k: add support for device recovery for QCA6390/WCN6855
 
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

Wen Gong (4):
  ath11k: add support for device recovery for QCA6390/WCN6855
  ath11k: add synchronization operation between reconfigure of mac80211
    and ath11k_base
  ath11k: Add hw-restart option to simulate_fw_crash
  ath11k: fix the warning of dev_wake in mhi_pm_disable_transition()

 drivers/net/wireless/ath/ath11k/core.c    | 121 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h    |  18 ++++
 drivers/net/wireless/ath/ath11k/debugfs.c |   4 +
 drivers/net/wireless/ath/ath11k/mac.c     |  40 +++++++
 drivers/net/wireless/ath/ath11k/mhi.c     |  33 ++++++
 drivers/net/wireless/ath/ath11k/pci.c     |  12 ++-
 6 files changed, 216 insertions(+), 12 deletions(-)


base-commit: 193dc0446985372a9b06b7572e1b98e1963c23a9
-- 
2.31.1

