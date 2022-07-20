Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A645657B7E4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiGTNuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiGTNuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:50:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBB0286FE
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658325015; x=1689861015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ftguVMJAWyYJiJRPBZGQ4qYMCrlO8PUR6mv9NbZ5GPg=;
  b=IsIK8IXFvAn68kt4RWoZaUdPZbQeLKgLnVDtIzfzcX6dhc02xn6H03MZ
   Ag+yJIbjdYdO0LGpzzrHxKV/ka4NHU56Dnwz4s4C7jiyOBu8KqPHuD/JI
   PKV2mgYuGLUidRCeodr8vrxWLId8MThn5m3r2QWofwcCcL8Btfe/GwTiG
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jul 2022 06:50:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:50:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:50:14 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:50:12 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
Date:   Wed, 20 Jul 2022 19:19:55 +0530
Message-ID: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, WLAN chip is powered once during driver probe and is kept
ON (powered) always even when WLAN is not active; keeping the chip
powered ON all the time will consume extra power which is not
desirable on a battery operated device. Same is the case with non-WoW
suspend, chip will not be put into low power mode when the system is
suspended resulting in higher battery drain.

Send QMI MODE OFF command to firmware during WiFi OFF to put device
into low power mode.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Manikanta Pubbisetty (4):
  ath11k: Fix double free issue during SRNG deinit
  ath11k: Move hardware initialization logic to start()
  ath11k: Enable low power mode when WLAN is not active
  ath11k: Fix failed to parse regulatory event print

 drivers/net/wireless/ath/ath11k/core.c | 237 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/core.h |   8 +-
 drivers/net/wireless/ath/ath11k/hal.c  |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  33 ++--
 drivers/net/wireless/ath/ath11k/reg.c  |   2 +
 5 files changed, 189 insertions(+), 92 deletions(-)

-- 
2.35.1

