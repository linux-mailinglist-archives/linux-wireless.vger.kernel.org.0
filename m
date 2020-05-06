Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84511C6D69
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgEFJoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:44:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57770 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728663AbgEFJoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:44:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588758261; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=VlCMhkEaB47oUJoEc87OPDq5RegeNxpOKgqcK6gTPaw=; b=cUy1zFQrXyyI8TBZcjT8v19yNBcltbsD5oq9gCasu96IAFz6Rm7s7QoioOtxpI93ivxA8rk5
 hbVTUD/D/UChIGlLh3hkKUASj/l0/ZxQUUkdNlXGwPdXObwc4fVbuJRnxzyPbavnBFXZF5nt
 eArqJEGtLN6ybMAUyUEMjbqPlTI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb286e7.7feb289014c8-smtp-out-n02;
 Wed, 06 May 2020 09:44:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72CE0C433D2; Wed,  6 May 2020 09:44:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1000C433F2;
        Wed,  6 May 2020 09:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1000C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 0/3] Add infra support for discrete chipset in ath11k
Date:   Wed,  6 May 2020 15:13:57 +0530
Message-Id: <20200506094400.4740-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCA6390 is PCI based 11ax chipset to be supported in ath11k.
Current design supports only AHB interface for 11ax chipset.
Refactor the code by adding hif layer for bus level abstraction to support PCI based device.

Tested HW: IPQ8074A

Govind Singh (3):
  ath11k: Add support for multibus support
  ath11k: Add drv private for bus opaque struct
  ath11k: Remove bus layer includes from upper layer

 drivers/net/wireless/ath/ath11k/ahb.c      | 47 +++++++++---
 drivers/net/wireless/ath/ath11k/ahb.h      | 22 ------
 drivers/net/wireless/ath/ath11k/core.c     | 47 ++++--------
 drivers/net/wireless/ath/ath11k/core.h     | 10 ++-
 drivers/net/wireless/ath/ath11k/dp.c       |  1 +
 drivers/net/wireless/ath/ath11k/hal.c      | 87 +++++++++++-----------
 drivers/net/wireless/ath/ath11k/hal_desc.h |  2 +
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 22 +++---
 drivers/net/wireless/ath/ath11k/hal_tx.c   | 13 ++--
 drivers/net/wireless/ath/ath11k/hal_tx.h   |  1 +
 drivers/net/wireless/ath/ath11k/hif.h      | 65 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/htc.c      |  4 +-
 drivers/net/wireless/ath/ath11k/hw.h       |  5 ++
 13 files changed, 198 insertions(+), 128 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/hif.h

-- 
2.22.0
