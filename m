Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7754AD72F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 12:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiBHLcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 06:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356586AbiBHKwG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 05:52:06 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 02:52:05 PST
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32BAC03FEC3
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644317526; x=1675853526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H1M7GiEBG1472fgEdXp4cPGZllRAqGb5pgJL+uEjrjU=;
  b=Q/fs7dV6FyUH5Yw09tEI0MfylcdUyj5tRAmYMeg6tQWOEuXkl+rweeQc
   ASt++OQ7eBPKq0naNN1N/4W+aphPDsNUDyqeolQkukYNFsF1+Nm3Wjt2G
   oSwIMYlG8ZUSv88QBGOu35n0+HWVoPkXj2Iu9Sq12krNigX0wInpBX5U5
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 02:50:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 02:50:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 02:50:02 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 02:50:01 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v5 0/5] ath11k: add feature for device recovery
Date:   Tue, 8 Feb 2022 05:49:42 -0500
Message-ID: <20220208104947.25791-1-quic_wgong@quicinc.com>
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

Wen Gong (4):
  ath11k: add ath11k_qmi_free_resource() for recovery
  ath11k: configure RDDM size to mhi for recovery by firmware
  ath11k: add support for device recovery for QCA6390/WCN6855
  ath11k: add synchronization operation between reconfigure of mac80211
    and ath11k_base

 drivers/net/wireless/ath/ath11k/core.c | 121 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  18 ++++
 drivers/net/wireless/ath/ath11k/mac.c  |  40 ++++++++
 drivers/net/wireless/ath/ath11k/mhi.c  |  35 +++++++
 drivers/net/wireless/ath/ath11k/qmi.c  |   6 ++
 drivers/net/wireless/ath/ath11k/qmi.h  |   1 +
 6 files changed, 213 insertions(+), 8 deletions(-)


base-commit: 76680d49b5e0e661bc4abcdaf13fb7e124b4ca08
-- 
2.31.1

