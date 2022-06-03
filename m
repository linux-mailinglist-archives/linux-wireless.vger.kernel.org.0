Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2F53C6EE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbiFCI2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiFCI2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:28:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30B1D0C3
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654244920; x=1685780920;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=avJpal9naLF92RUkm26se4++uNEjib8i82kLVB/GrqI=;
  b=RqgbGEpSPXYQTkKqyetBinJFuKHWYTQqJ4r5UPzl01xta90kcFp6IpJm
   WKbCKJD1QTMzrARklbD0hxD2i5AE/WGliOOb71hyT+i+VNYQ5buuI6NSH
   bnOxMW0kwxCIr527YGLufp9zl1OD34ONBJvRa03aFXADdK3wgbaH1Yw6G
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jun 2022 01:28:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 01:28:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 01:28:38 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 01:28:36 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 0/2] ath11k: add support for get_txpower mac ops
Date:   Fri, 3 Jun 2022 13:58:12 +0530
Message-ID: <20220603082814.31466-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Currently, driver does not support get_txpower mac ops because of which
cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
gets its value from ieee80211_channel->max_reg_power. However, the final
txpower is dependent on few other parameters apart from max regulatory
supported power. It is the firmware which knows about all these parameters
and considers the minimum for each packet transmission.

Firmware reports the final tx power in firmware pdev stats which falls
under fw_stats. But currently, fw_stats is under debugfs.

Add support for get_txpower mac ops to get the tx power from firmware
leveraging fw_stats and return it accordingly.

Also, move fw_stats out of debugfs so that get_txpower mac ops can
function properly even when debugfs is disabled.

Aditya Kumar Singh (2):
  ath11k: move firmware stats out of debugfs
  ath11k: add get_txpower mac ops

---
v3: fixed warnings related to blank lines

v2: removed unnecessary line breaks and made debug logs more clear

---
 drivers/net/wireless/ath/ath11k/core.c    |  46 +++++++
 drivers/net/wireless/ath/ath11k/core.h    |  12 +-
 drivers/net/wireless/ath/ath11k/debugfs.c | 139 +++++-----------------
 drivers/net/wireless/ath/ath11k/debugfs.h |   6 +-
 drivers/net/wireless/ath/ath11k/mac.c     |  92 ++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     |  48 +++++++-
 6 files changed, 229 insertions(+), 114 deletions(-)

-- 
2.17.1

