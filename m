Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196FB729CB7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbjFIOYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjFIOYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675430F2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3455A616E0
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A02C433EF;
        Fri,  9 Jun 2023 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320683;
        bh=GNcaM5RE6Sq/mNvgioG2yaYjxqAFOAEAMgRlZ6mH+B4=;
        h=From:To:Cc:Subject:Date:From;
        b=nSbMatYc+NKak8m3BJ4LvkSNWqUhCq2j+WuzWAMMLRaAyWliP/d3WZrQk+kU3cT+k
         GNIfR3kPcDM815gBXWHl7uPbbSwnBcXuRtO+atSoPrbwpbKh48OCUkcGXilcfGSU2l
         ha3kVv2uXv5tqkVJX+e9i1sEPri5YaWQTVYWvzRCyIDlU15oL2uhyETTmflPtyy/bM
         yU+XRq64W83q0baR5SBTBxpx7iRaLj5Yhe0TpY8bnhsWthyUq3B/6TOZY0jtfAfvpF
         qJauQogVPb0/RRypGFVskihfWXiZkuzYzHXpslXeI4o+NrjfpWLbel9vqxGG7AeiWy
         MNxXGaznzxykg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: ath11k: debug message improvements
Date:   Fri,  9 Jun 2023 17:24:25 +0300
Message-Id: <20230609142440.24643-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Some improvements and cleanup to ath11k debug messages. Print debug
level automatically in kernel log messages.

Kalle Valo (15):
  wifi: ath11k: debug: remove unused ATH11K_DBG_ANY
  wifi: ath11k: print debug level in debug messages
  wifi: ath11k: remove manual mask names from debug messages
  wifi: ath11k: add WMI event debug messages
  wifi: ath11k: remove unsupported event handlers
  wifi: ath11k: wmi: cleanup error handling in
    ath11k_wmi_send_init_country_cmd()
  wifi: ath11k: wmi: use common error handling style
  wifi: ath11k: wmi: add unified command debug messages
  wifi: ath11k: pci: cleanup debug logging
  wifi: ath11k: dp: cleanup debug message
  wifi: ath11k: debug: use all upper case in ATH11k_DBG_HAL
  wifi: ath11k: hal: cleanup debug message
  wifi: ath11k: don't use %pK
  wifi: ath11k: htc: cleanup debug messages
  wifi: ath11k: debug: add ATH11K_DBG_CE

 drivers/net/wireless/ath/ath11k/ahb.c    |   4 +-
 drivers/net/wireless/ath/ath11k/ce.c     |   4 +-
 drivers/net/wireless/ath/ath11k/core.c   |  14 +-
 drivers/net/wireless/ath/ath11k/debug.c  |   2 +-
 drivers/net/wireless/ath/ath11k/debug.h  |  48 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  |   8 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  |  12 +-
 drivers/net/wireless/ath/ath11k/hal.c    |  10 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |  24 +-
 drivers/net/wireless/ath/ath11k/htc.c    |  42 +-
 drivers/net/wireless/ath/ath11k/mac.c    | 110 ++---
 drivers/net/wireless/ath/ath11k/mhi.c    |   6 +-
 drivers/net/wireless/ath/ath11k/pci.c    |  22 +-
 drivers/net/wireless/ath/ath11k/pcic.c   |   6 +-
 drivers/net/wireless/ath/ath11k/peer.c   |   4 +-
 drivers/net/wireless/ath/ath11k/qmi.c    |  58 +--
 drivers/net/wireless/ath/ath11k/reg.c    |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c    | 562 +++++++++++++----------
 18 files changed, 544 insertions(+), 396 deletions(-)


base-commit: 3b3d60fff1f7ecd2966a2f4f9b20a80630b93682
-- 
2.30.2

