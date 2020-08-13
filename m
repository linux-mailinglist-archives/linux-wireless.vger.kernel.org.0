Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D46243718
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMJEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:04:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62235 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMJEd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:04:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597309472; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=dLJu3ZxpbqReGvAb7i/N/CpC9QNTzpm27NJ7Rr9yTSY=; b=KPAtgnPhVVh+Vk+etxwOgCR15yO/JYSzVugZsKjK+DWcvJ7VQ6nCvySYWKtndSvRP8shQGix
 gtlcvDrtn108jZsLqC4L11xczD5kswt39EOQ59MIMWgFtjUj8W+xBW30C2mJ0maU888OFxad
 tD7Z76EL2G5ZvILIc46KtAwIShM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f35021f247ccc308c06ea26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:04:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE5E0C433C9; Thu, 13 Aug 2020 09:04:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B88B8C433C6;
        Thu, 13 Aug 2020 09:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B88B8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/10] ath11k: initial PCI support
Date:   Thu, 13 Aug 2020 12:04:16 +0300
Message-Id: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k: initial PCI support

QCA6390 is a Wi-Fi 6 device using PCI bus but which accessed using
Modem Host Interface (MHI) protocol. As the first step to get QCA6390
working in ath11k add basic support for PCI and MHI.

With this patchset only the simple PCI initialisation works with
QCA6390. More patches will follow to get more features working with
QCA6390.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Please review.

Kalle

Carl Huang (2):
  ath11k: do not depend on ARCH_QCOM for ath11k
  ath11k: add hw_params entry for QCA6390

Govind Singh (6):
  ath11k: add simple PCI client driver for QCA6390 chipset
  ath11k: pci: setup resources
  ath11k: pci: add MSI config initialisation
  ath11k: register MHI controller device for QCA6390
  ath11k: pci: add HAL, CE and core initialisation
  ath11k: use remoteproc only with AHB devices

Kalle Valo (2):
  ath11k: move ring mask definitions to hw_params
  ath11k: implement ath11k_core_pre_init()

 drivers/net/wireless/ath/ath11k/Kconfig  |  18 +-
 drivers/net/wireless/ath/ath11k/Makefile |   7 +-
 drivers/net/wireless/ath/ath11k/ahb.c    | 100 +----
 drivers/net/wireless/ath/ath11k/ce.c     |   4 +
 drivers/net/wireless/ath/ath11k/core.c   |  59 ++-
 drivers/net/wireless/ath/ath11k/core.h   |  22 +-
 drivers/net/wireless/ath/ath11k/debug.c  |   5 +
 drivers/net/wireless/ath/ath11k/debug.h  |   1 +
 drivers/net/wireless/ath/ath11k/dp.c     |  23 +-
 drivers/net/wireless/ath/ath11k/hal.c    |   2 +
 drivers/net/wireless/ath/ath11k/hif.h    |   4 +
 drivers/net/wireless/ath/ath11k/hw.c     |  72 +++
 drivers/net/wireless/ath/ath11k/hw.h     |  19 +
 drivers/net/wireless/ath/ath11k/mhi.c    | 423 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.h    |  28 ++
 drivers/net/wireless/ath/ath11k/pci.c    | 738 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h    |  44 ++
 17 files changed, 1459 insertions(+), 110 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.h
 create mode 100644 drivers/net/wireless/ath/ath11k/pci.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pci.h

-- 
2.7.4

