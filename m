Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC21CA6A9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHI7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 04:59:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38739 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgEHI7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 04:59:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588928354; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=9OGdHWwIepKK4bzY5ZRlcX5ldlaC94P2Py63FyGsZjo=; b=jK/JGkemMSVFMzKwULIkXNrbEuCItHf9laGt5TkPLZyhZ9NQBUw/8oX0Vdkn1qoZaPgC/32H
 a9gg0ix0DSmnHWq03wJrQ3JSYWulAJ3Yf8TDnG4V4DSYjRoRFHerG3b83nE49huZ0U9HdBjd
 CLr4y3QM8A06oJfCR/99B8wITQs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb51f50.7f0f91e287a0-smtp-out-n01;
 Fri, 08 May 2020 08:58:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9AE81C433BA; Fri,  8 May 2020 08:58:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D780EC433F2;
        Fri,  8 May 2020 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D780EC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 0/4] Add PCI client driver for QCA6390 chipset
Date:   Fri,  8 May 2020 14:28:46 +0530
Message-Id: <20200508085850.23363-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCA6390 chipsets is PCI based 11ax chipset to be supported in ath11k.

Add PCI client driver for QCA6390 chipset with enumeration/resource initialization/msi vector mapping.
With these changes driver is splitted in two modules(bus layer module/ common core module).
This is required due to following reasons.

 1) PCI based transport layer for QCA6390 chipsets.
 2) FW loading based on MHI protocol unlike rproc in IPQ8074A.
 3) MSI based data path/CE/fw RAM dump interrupt.
 4) CE assignments is different.
 5) Different boot up sequence due to requirement of voltage regulators/bootstrap
    pinctrls for QCA6390.
 6) Clear separation in bus level operation.


For AHB based devices:
ath11k_ahb.ko
ath11k_ko

For PCI based devices:
ath11k_pci.ko
ath11k.ko

Tested HW:
	IPQ8074A
	X86 + QCA6390: pci probe/resource setup

Govind Singh (4):
  ath11k: Add PCI client driver for QCA6390 chipset
  ath11k: setup pci resource for QCA6390 target
  ath11k: Add msi config init for QCA6390
  ath11k: Register mhi controller device for qca6390

 drivers/net/wireless/ath/ath11k/Kconfig  |  13 +-
 drivers/net/wireless/ath/ath11k/Makefile |   7 +-
 drivers/net/wireless/ath/ath11k/ahb.c    |  71 -----
 drivers/net/wireless/ath/ath11k/ce.c     |   2 +
 drivers/net/wireless/ath/ath11k/core.c   |   7 +
 drivers/net/wireless/ath/ath11k/core.h   |  11 +-
 drivers/net/wireless/ath/ath11k/debug.c  |   6 +-
 drivers/net/wireless/ath/ath11k/debug.h  |   1 +
 drivers/net/wireless/ath/ath11k/dp.c     |   1 +
 drivers/net/wireless/ath/ath11k/hal.c    |   1 +
 drivers/net/wireless/ath/ath11k/hif.h    |  77 ++++-
 drivers/net/wireless/ath/ath11k/mhi.c    | 379 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.h    |  28 ++
 drivers/net/wireless/ath/ath11k/pci.c    | 385 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h    |  49 +++
 15 files changed, 954 insertions(+), 84 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.h
 create mode 100644 drivers/net/wireless/ath/ath11k/pci.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pci.h

-- 
2.22.0
