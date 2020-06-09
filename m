Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DF1F3CA6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgFINdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 09:33:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37229 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728601AbgFINdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 09:33:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591709617; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GcwBlAhLI0Vg9FQwsJ7T79mX+9+KXvm84ygiu7T6nE8=; b=Htq1TY70xYE2Eme4Zz8Oj4q+e4PrLLvKcYvU15gXU+F3ZXZ7+EOsjY4q7E3C+R1WmMbAWb7f
 b3x6sFhWBeBtwCGcgZDHpvmfuYUvL00fwTF6b+BQl2rIdEKZgj313xKDCk0WmqJMPN7qrL/O
 Nc7Eer3fuI2hX8qsGtFmhjYxEdI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5edf8fa03a8a8b20b8b1c4de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 13:33:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15087C43387; Tue,  9 Jun 2020 13:33:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BAC4C433B2;
        Tue,  9 Jun 2020 13:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BAC4C433B2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 0/8] ath11k: Add IPQ6018 support
Date:   Tue,  9 Jun 2020 19:02:53 +0530
Message-Id: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
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
  dt: bindings: net: update compatible for ath11k
  ath11k: update firmware files read path
  ath11k: rename default board file
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

V2:
 - Added devicetree reviewers 
-- 
2.7.4

