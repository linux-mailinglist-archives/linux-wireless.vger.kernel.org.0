Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1757B7EA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiGTNvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTNva (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:51:30 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DB31935
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658325088; x=1689861088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=248ZfeN56jR2hneRPQlauiUdkN7AJeUIKxC5kACWV6g=;
  b=VpuZT18gm6LsGpKQ1JkCl+RHoBDduR4J1CFfgDEZsgDI8krRHQO84jGg
   NsFyYbcTKF8EjFRjjiPc3oz7bSiAMEtUOM5gkiHd27R09Xi6YJ7lxdbnH
   9L22nibggOHRV2u9JvDKsqzTC5iRzRHL7QQ8vuEZO8uT24H3mptWL1DN7
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 06:51:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:51:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:51:27 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:51:26 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 0/3] Throughput fixes for WCN6750
Date:   Wed, 20 Jul 2022 19:21:10 +0530
Message-ID: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
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

Fix throughput issues on WCN6750. This includes 160 MHz
throughput fixes in both TX & RX directions.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Manikanta Pubbisetty (3):
  ath11k: Enable threaded NAPI on WCN6750
  ath11k: Add multi TX ring support for WCN6750
  ath11k: Increase TCL data ring size for WCN6750

 drivers/net/wireless/ath/ath11k/ahb.c    |   1 +
 drivers/net/wireless/ath/ath11k/core.c   |  20 +++-
 drivers/net/wireless/ath/ath11k/dp.c     |  26 ++---
 drivers/net/wireless/ath/ath11k/dp.h     |   4 +
 drivers/net/wireless/ath/ath11k/dp_tx.c  |  19 ++--
 drivers/net/wireless/ath/ath11k/hal.c    |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h    |   2 +
 drivers/net/wireless/ath/ath11k/hal_tx.c |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c     | 117 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.h     |  12 +++
 drivers/net/wireless/ath/ath11k/pcic.c   |   1 +
 12 files changed, 179 insertions(+), 31 deletions(-)

-- 
2.35.1

