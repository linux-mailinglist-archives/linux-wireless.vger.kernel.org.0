Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6270A316157
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhBJIq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:46:29 -0500
Received: from so15.mailgun.net ([198.61.254.15]:59720 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhBJIn0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946573; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=57YeHv8/zQvHMUpWce2DbhHXY78KxvzKmChd4fODxqc=; b=xSsa7YWRnHjOKCMvc5MHzqrpTc97+Ye6JXFymScJYvmusKroFp8IKLWgBv6QuX/CCXVOZ14l
 WpZKM0lwWbXG97142g8tRjP1yoOVDOC5cSpUyK64FvVc/HQuptS7IwTQfno2PPGpe6RIDNgy
 3xbexm/dIxNglZm93DJXYrR1FmI=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60239c6f4bd23a05ae5c0146 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:23
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6EF0DC433CA; Wed, 10 Feb 2021 08:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB3DC433C6;
        Wed, 10 Feb 2021 08:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB3DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 00/11] ath11k: Add support for QCN9074
Date:   Wed, 10 Feb 2021 14:11:59 +0530
Message-Id: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN9074 has PCI bus interface and shares QCA6390
configuration.

QCN9074 uses 45MB of host ddr memory.
FW requests the memory in segments of 2MB size and
each 2MB segment should be physically contiguous.

FW boot over MHI is verified.
BDF/M3 download over QMI is verified.
 
Below QMI issues are seen with QCN9074,
Issue 1:
 ath11k_pci 0000:06:00.0: qmi failed memory request, err = -110
 ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-110
Issue 2:
 ath11k_pci 0000:06:00.0: firmware crashed: MHI_CB_SYS_ERROR
 ath11k_pci 0000:06:00.0: qmi failed set mode request, mode: 0, err = -110
 ath11k_pci 0000:06:00.0: qmi failed to send wlan fw mode:-110

QCN9074 uses,
 - 16-MSI interrupts, 3 for MHI, 5 for CE and 8 for DP
 - CE count is six
 - CE register address, WBM idle link ring address,
   WBM release ring address are different
 - TCL ring  descriptors,  HAL Rx descriptors are different, 
   so introduced platform specific hal rx descriptor access ops
   in ath11k_hw_ops

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Anilkumar Kolli (6):
  ath11k: Refactor ath11k_msi_config
  ath11k: Move qmi service_ins_id to hw_params
  ath11k: qmi: increase the number of fw segments
  ath11k: Update memory segment count for qcn9074
  ath11k: Add qcn9074 mhi controller config
  ath11k: add qcn9074 pci device support

Karthikeyan Periyasamy (5):
  ath11k: add static window support for register access
  ath11k: add hal support for QCN9074
  ath11k: add data path support for QCN9074
  ath11k: add CE interrupt support for QCN9074
  ath11k: add extended interrupt support for QCN9074

 drivers/net/wireless/ath/ath11k/ahb.c      |   2 +-
 drivers/net/wireless/ath/ath11k/ce.c       |  58 ++-
 drivers/net/wireless/ath/ath11k/ce.h       |   1 +
 drivers/net/wireless/ath/ath11k/core.c     |  43 ++
 drivers/net/wireless/ath/ath11k/core.h     |   4 +
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 476 +++++++++--------
 drivers/net/wireless/ath/ath11k/dp_tx.c    |   6 +-
 drivers/net/wireless/ath/ath11k/hal.c      |  88 ++--
 drivers/net/wireless/ath/ath11k/hal.h      |  33 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h |  13 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c   |   3 +
 drivers/net/wireless/ath/ath11k/hal_tx.h   |   1 +
 drivers/net/wireless/ath/ath11k/hif.h      |  10 +
 drivers/net/wireless/ath/ath11k/hw.c       | 796 +++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h       |  53 ++
 drivers/net/wireless/ath/ath11k/mhi.c      | 116 ++++-
 drivers/net/wireless/ath/ath11k/pci.c      | 196 +++++--
 drivers/net/wireless/ath/ath11k/pci.h      |  21 +-
 drivers/net/wireless/ath/ath11k/qmi.c      |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.h      |   9 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h  | 212 +++++++-
 21 files changed, 1765 insertions(+), 378 deletions(-)

-- 
2.7.4

