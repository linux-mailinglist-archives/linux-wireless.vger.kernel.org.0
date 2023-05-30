Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08C7163B7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjE3OUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjE3OTM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 10:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615EE50
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 07:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4FAB63107
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 14:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD6C433AA;
        Tue, 30 May 2023 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456298;
        bh=YTR5umqFyzBEGCvS9LW8/0sc38qNreh5rcxNd8kpAzw=;
        h=From:To:Cc:Subject:Date:From;
        b=KUQsCVQASidWlAYzA+avxVn7jotV9kkIA309j8KkTdyf0Jh+CS/m32+eNRD8KIh2R
         MACu2HG0kueWbwehXT2bvRvVPBCcC1DQj/fkBc9WDwBtorS/uVU3cGb9Sq9LKT8VpG
         UuESg0dk6PRzL9PTYDKdULvsGJ9jMg/5/Ten3GHQlRAPjX/6MlwiF5++ohBEqQ/SKP
         ztyJxODj/yn+QVu3ONK1eLwqscjVnzKEjCLIxP6H2KDGRxgaR1t6NvyZ9aIVc59mSG
         ipnWB1mDrr6cWcJVFKMIVfkbKql+gjk/AZhhUQxAef8pYfyw0pjHciHsbGRZ1qmHaP
         xcvYHsqJfSCGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/3] wifi: ath11k: support firmware-2.bin
Date:   Tue, 30 May 2023 17:18:10 +0300
Message-Id: <20230530141813.29333-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v3:

* patch 1: add "bus: mhi: host: ..." to title

* patch 1: add a comment to mhi_fw_load_handler()

* patch 1: check sbl_size

* patch 3: for smooth backwards compatibility don't print an error "failed to
  load firmware-2.bin: -2"

v2:

https://patchwork.kernel.org/project/linux-wireless/list/?series=727935&state=*&order=date

* mhi_fw_load_handler(): fold two lines into one

* struct mhi_controller_config: document that fbc_download needs to be set

* run pahole struct mhi_controller_config

Anilkumar Kolli (1):
  wifi: ath11k: add firmware-2.bin support

Kalle Valo (2):
  bus: mhi: host: allow MHI client drivers to provide the firmware via a
    pointer
  wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()

 drivers/bus/mhi/host/boot.c              |  34 +++--
 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.c   |   8 ++
 drivers/net/wireless/ath/ath11k/core.h   |  15 +++
 drivers/net/wireless/ath/ath11k/fw.c     | 157 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/fw.h     |  27 ++++
 drivers/net/wireless/ath/ath11k/mhi.c    |  18 ++-
 drivers/net/wireless/ath/ath11k/qmi.c    |  54 +++++---
 include/linux/mhi.h                      |   6 +
 9 files changed, 289 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.h


base-commit: 4ab7f08db5310ded48a5c1f3ec3f2e177ba6b1c2
-- 
2.30.2

