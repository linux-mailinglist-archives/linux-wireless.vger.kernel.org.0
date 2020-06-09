Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32F1F3341
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 07:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFIFDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 01:03:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31427 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgFIFDr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 01:03:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591679027; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RFqTmIO5/UL7d7NoPYx71YDb2hu0MuOYeEcoosndsR0=; b=jADGAC/S/GkokGKx5JXVHoJ4DI1z4YZAWD/XiVkJcW5SZlEMNuFN1D2mUQ7V0vXuReOE+Oxe
 AN6a4WHrGMu/9K2JcHr9KI5n+Sr6Lg63559g35XuYspsfI5MsF9+L8Qc569SbGQ7y73z+hkf
 dXo0aaM2rN6vIsqa6HYBbvLH71s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5edf18269545e9541f2a0149 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 05:03:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83CC7C433CB; Tue,  9 Jun 2020 05:03:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE04BC433CA;
        Tue,  9 Jun 2020 05:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE04BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 0/8] ath11k: Add IPQ6018 support
Date:   Tue,  9 Jun 2020 10:33:05 +0530
Message-Id: <1591678993-11016-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 has a 5G radio and 2G radio with 2x2
and shares IPQ8074 configuration.

Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 

Anilkumar Kolli (8):
  ath11k: update firmware files read path
  ath11k: rename default board file
  dt: bindings: net: update compatible for ath11k
  ath11k: add IPQ6018 support
  ath11k: define max_radios in hw_params
  ath11k: add hw_ops for pdev id to hw_mac mapping
  ath11k: add ce services for IPQ6018
  ath11k: Add bdf-addr in hw_params

 .../bindings/net/wireless/qcom,ath11k.yaml         |   4 +-
 drivers/net/wireless/ath/ath11k/Makefile           |   3 +-
 drivers/net/wireless/ath/ath11k/ahb.c              | 151 ++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.c             |  78 +++++++----
 drivers/net/wireless/ath/ath11k/core.h             |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/htc.c              |   2 +-
 drivers/net/wireless/ath/ath11k/hw.c               |  34 +++++
 drivers/net/wireless/ath/ath11k/hw.h               |  31 ++++-
 drivers/net/wireless/ath/ath11k/mac.c              |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   6 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   1 -
 drivers/net/wireless/ath/ath11k/reg.c              |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   4 +-
 14 files changed, 266 insertions(+), 56 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/hw.c

-- 
2.7.4

