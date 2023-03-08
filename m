Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843206B0C96
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjCHPZd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjCHPZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 10:25:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA9CD651
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 07:25:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E787BB81D3A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA82C433EF;
        Wed,  8 Mar 2023 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678289125;
        bh=tzxT+qCmj2RHGT/ahZ/7xgh9qauM2zkewaeW0iGIDvY=;
        h=From:To:Cc:Subject:Date:From;
        b=E5pxg6JlB5Qq+xSu8tKT7+SP2Xm+UbSOcruM6b8P6gUqCOujgDi0zDbTF4fPhfoqr
         xBw/JbDH8l3wakppqlIsza75TeLo2nsMdoGm7F7GWdt79eGB8QS7LpQzpvfS5GrnO7
         4UvEIoZ9rUQOIrJWUWGrzegyg3Q+CTxhfHFmx1/AFguOzBvtk1s4ePo4RZguP25j58
         vf0JcTZ9S7s6rLYNdCOJbk4e7/XSrEjRQPb1+w+1D5fito/I635ZdUdRsXc6TJoDDx
         SuKyPfx9VsR+7wq/OcHYTWs2jM70L0cttcLEnWYgVH1kX8/lEQRFIosfHOHMzm1qeb
         5RKjJm4ZngJow==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: ath11k: support firmware-2.bin
Date:   Wed,  8 Mar 2023 17:25:19 +0200
Message-Id: <20230308152522.6728-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

We need firmware-2.bin support in ath11k so that we can add ath11k specific meta
data to firmware releases, for example feature flags so that ath11k can
automatically detect what features the firmware release supports.  Also makes
it easier and more reliable to update the firmware for PCI devices as it's not
possible to mix firmware files, everything will be in one file.

Please review and comment.

v2:

* mhi_fw_load_handler(): fold two lines into one

* struct mhi_controller_config: document that fbc_download needs to be set

* run pahole struct mhi_controller_config

Anilkumar Kolli (1):
  wifi: ath11k: add firmware-2.bin support

Kalle Valo (2):
  mhi: allow MHI client drivers to provide the firmware via a pointer
  wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()

 drivers/bus/mhi/host/boot.c              |  28 ++--
 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.c   |   8 ++
 drivers/net/wireless/ath/ath11k/core.h   |  15 +++
 drivers/net/wireless/ath/ath11k/fw.c     | 157 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/fw.h     |  27 ++++
 drivers/net/wireless/ath/ath11k/mhi.c    |  18 ++-
 drivers/net/wireless/ath/ath11k/qmi.c    |  54 +++++---
 include/linux/mhi.h                      |   6 +
 9 files changed, 283 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.h


base-commit: 1a304987a22c9f383f163f93beb47e89080d1cee
-- 
2.30.2

