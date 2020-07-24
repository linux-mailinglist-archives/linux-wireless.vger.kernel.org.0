Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA80922BE94
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGXHFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 03:05:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11656 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXHFk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 03:05:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595574339; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=N3Yzy01IyuEZ2gSZWxIuEh5vzA7NuBS5hy/OdYXg7s4=; b=OIPKl9u/tm3oC6ic24b68FmqxfTavw9N+XHKVX9McQBAeh5hfBWrR19YNJBW4r5Js+JnG1nc
 eiKKZtAOMMNO8W7OglMl803pUNo1913UZnQpmsBPyvbdx4fF2CFvPRCj7YTP2DSdGn2mKA95
 REslylEVLWGr5CFCjgPT7WNfmus=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f1a8840cf983e60a83b7e25 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 07:05:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7D59C43391; Fri, 24 Jul 2020 07:05:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C362C433C6;
        Fri, 24 Jul 2020 07:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C362C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        akolli@codeaurora.org
Subject: [PATCH v5 0/3] ath11k: Add IPQ6018 support
Date:   Fri, 24 Jul 2020 12:35:22 +0530
Message-Id: <1595574325-16300-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 has a 5G radio and 2G radio with 2x2
and shares IPQ8074 configuration.

Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 

Anilkumar Kolli (3):
  dt: bindings: net: update compatible for ath11k
  ath11k: copy ce service configs to hw_params
  ath11k: add IPQ6018 support

V2:
 - Added devicetree reviewers 
V3:
 - addressed dt bindinds comments
 - Reworked on Kalles patches
 - copied ce svc configs to hw_params
V4:
 - updated dt patch (Rob)
V5:
 - Fixes errors in 'make dt_binding_check' (Rob)

 .../bindings/net/wireless/qcom,ath11k.yaml         |   4 +-
 drivers/net/wireless/ath/ath11k/ahb.c              | 131 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.c             |  20 ++--
 drivers/net/wireless/ath/ath11k/core.h             |   2 +
 drivers/net/wireless/ath/ath11k/hw.h               |   2 +
 5 files changed, 146 insertions(+), 13 deletions(-)

-- 
2.7.4

