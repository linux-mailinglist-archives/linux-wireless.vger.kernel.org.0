Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08B3587875
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiHBH4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiHBHz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 03:55:58 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4B2E6BF
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659426957; x=1690962957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9iNWlELmFi/hRYacqy6gZg3+0cd1J8YXncbE1N6T1Q=;
  b=QG8TjZuEV/gB1EjAoDH4Tp16YX0v6QceOj6ND4WKjdL97ssbiadw7/9d
   yd/2ImhvvwYJyEDbi1mBqEqnQNcWN55a4Pz93J8Wn2yjMIvw3nltRr4Ej
   Mfk7ogL7Ucb2Jumr1e9HET8UYOzZEz0+JoSFdo3v2w/RfRvwut52qZXAj
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Aug 2022 00:55:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:55:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 00:55:56 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 00:55:55 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/2] wifi: ath11k: Add support for sram dump
Date:   Tue, 2 Aug 2022 15:55:31 +0800
Message-ID: <20220802075533.1744-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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

On-board sram contains valuable information for debug, this patch adds
a new interface named "sram" in debugfs with which we can dump sram
content using following cmd:

        cat /sys/kernel/debug/ath11k/<pdev name>/sram > sram.dump

v2:
 1: rebased on latest ath.git.
 2. drop the patch "ath11k: Move pdev debugfs creation ahead"
    per Kalle's comments.

Baochen Qiang (2):
  wifi: ath11k: Split PCI write/read functions
  wifi: ath11k: Implement sram dump interface

 drivers/net/wireless/ath/ath11k/core.c    |  7 ++
 drivers/net/wireless/ath/ath11k/debugfs.c | 62 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hif.h     | 10 +++
 drivers/net/wireless/ath/ath11k/hw.c      | 10 +++
 drivers/net/wireless/ath/ath11k/hw.h      |  9 +++
 drivers/net/wireless/ath/ath11k/pci.c     |  1 +
 drivers/net/wireless/ath/ath11k/pcic.c    | 79 +++++++++++++++++------
 drivers/net/wireless/ath/ath11k/pcic.h    |  1 +
 8 files changed, 161 insertions(+), 18 deletions(-)


base-commit: b93992f874a92c264a0d0bda3bbf44b84eff4321
-- 
2.25.1

