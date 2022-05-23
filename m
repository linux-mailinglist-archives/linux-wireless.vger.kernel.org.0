Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64D8530AB4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiEWHqg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiEWHqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD218387
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291991; x=1684827991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yx/YJ4ASp9/nXbmV4N3Xn+b1NeN8cDGwqAeA2j4FbPc=;
  b=bY3cAC9BFDY3/t9WPOW8UWhpGVeyi2WXpYcdNcQRBldQSAYomsInvck/
   iBCMhnjYBrfmdkSOt/ZIXiaBDdX+7df/l87Oe6phP91d0mLD6e1dRP9qd
   f6CfW2xqYs6REq+cSMCHvX9GhXaKFWjlQ94VmCy2S2kyY7UdCbi80cEIE
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2022 23:01:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:25 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:25 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 0/9] MBSSID and EMA support in AP mode
Date:   Sun, 22 May 2022 23:00:59 -0700
Message-ID: <20220523060108.23982-1-quic_alokad@quicinc.com>
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

- Changes in MAC80211 add support for enhanced multiple BSSID (EMA AP).
This patch is the next version for the following series:
https://patchwork.kernel.org/project/linux-wireless/list/?series=558285&state=%2A&archive=both
The changes are now rebased on top of wireless-testing tree which
includes this series:
https://patchwork.kernel.org/project/linux-wireless/list/?series=617531&state=%2A&archive=both

- Patches for ath11k split the changes from following patch in
logical separate patches:
https://patchwork.kernel.org/project/linux-wireless/patch/20210120003221.21984-1-alokad@codeaurora.org/
And also use the latest API changes in MAC80211 which were different
at the time of V6.

Aloka Dixit (9):
  mac80211: generate EMA beacons in AP mode
  ath11k: add WMI resource config for EMA
  ath11k: set MBSSID and EMA driver capabilities
  ath11k: MBSSID configuration during vdev create/start
  ath11k: create a structure for WMI vdev up parameters
  ath11k: configure MBSSID device parameters
  ath11k: move vif parameter setting in a different function
  ath11k: EMA beacon support
  ath11k: configure WPA and RSNE parameters for nontransmitting
    interface

 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c   |   3 +
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 361 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c  |  27 +-
 drivers/net/wireless/ath/ath11k/wmi.h  |  66 ++++-
 include/net/mac80211.h                 |  77 ++++++
 net/mac80211/cfg.c                     |   9 +-
 net/mac80211/ieee80211_i.h             |   9 +-
 net/mac80211/tx.c                      | 110 +++++++-
 10 files changed, 603 insertions(+), 62 deletions(-)


base-commit: 9335156ac0e174721921c404bd173526c8509124
-- 
2.31.1

