Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269ED24454E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHNHLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29707 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgHNHLL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:11:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389071; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rxsMtmo16C4gfdZpqWRQed/fOJduuPexfInZqHXC8PA=; b=YbgXKN3BQw1DA1b+k9AfCZznKYDh+X6OaC8Bodmz5dMn3jZ5Xr9LxKmTdFjYtsjgHeIwFTcz
 vUAoRbmF+yIOFi4SI8r8nb2UoQWLyO21ghWhnat1OjuZtiM/Wzlz02OablXgjR5sAln3nbsP
 qMhmuFToag37vELhpWdO4FKu2OE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f3638eac85a1092b0606f4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D772C433C6; Fri, 14 Aug 2020 07:10:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18B3CC433C9;
        Fri, 14 Aug 2020 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18B3CC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/11] ath11k: firmware and board file support for PCI devices
Date:   Fri, 14 Aug 2020 10:10:19 +0300
Message-Id: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here's a second set of patches adding QCA6390 PCI support to ath11k.
Now m3 firmware and board file support is added as well various
smaller tweaks and fixes needed QCA6390 support.

There will be two more patchsets for QCA6390 after this. Please
review.

This patchset depends on the patchset:

ath11k: initial PCI support

Kalle

Carl Huang (4):
  ath11k: allocate smaller chunks of memory for firmware
  ath11k: fix memory OOB access in qmi_decode
  ath11k: fix KASAN warning of ath11k_qmi_wlanfw_wlan_cfg_send
  ath11k: enable internal sleep clock

Govind Singh (6):
  ath11k: add support for m3 firmware
  ath11k: add board file support for PCI devices
  ath11k: fill appropriate QMI service instance id for QCA6390
  ath11k: pci: add read32() and write32() hif operations
  ath11k: configure copy engine msi address in CE srng
  ath11k: setup ce tasklet for control path

Kalle Valo (1):
  ath11k: hal: create hw_srng_config dynamically

 drivers/net/wireless/ath/ath11k/ahb.c    |   4 +
 drivers/net/wireless/ath/ath11k/ce.c     |  32 ++++
 drivers/net/wireless/ath/ath11k/ce.h     |   2 +
 drivers/net/wireless/ath/ath11k/core.c   |   9 +-
 drivers/net/wireless/ath/ath11k/core.h   |  16 ++
 drivers/net/wireless/ath/ath11k/dbring.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp.c     |   8 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  |   4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  |   2 +-
 drivers/net/wireless/ath/ath11k/hal.c    | 119 +++++++------
 drivers/net/wireless/ath/ath11k/hal.h    |   8 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |   2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c |   2 +-
 drivers/net/wireless/ath/ath11k/hif.h    |  26 +++
 drivers/net/wireless/ath/ath11k/hw.h     |   3 +
 drivers/net/wireless/ath/ath11k/pci.c    | 200 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/pci.h    |   4 +
 drivers/net/wireless/ath/ath11k/qmi.c    | 293 ++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/qmi.h    |  25 ++-
 19 files changed, 654 insertions(+), 107 deletions(-)

-- 
2.7.4

