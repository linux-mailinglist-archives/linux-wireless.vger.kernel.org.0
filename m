Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35D3732CB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 01:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhEDXjE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 19:39:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62240 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhEDXjD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 19:39:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620171487; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=38TiQyyKps9JXnzJlaf2DPTrGl1O6bLoBL9k01Yhxmk=; b=Qya33n4C0WW9YQJ2MT6KfWqP1V+vNxu9NrW0WE1m6ARY1khMC5S5djPtMHwd8D1JDXIkSkp+
 1VyUEgYcdd7C3Ch4IqL0icjcB1SmRcdRY++6Yz/BisIZbjAIp0BDz8zvwZ5+X8WdYkqXevhb
 ZnpGBi8MMT6jpMkdhcr2Q/N+1P0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6091dade8807bcde1d9ade20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 23:38:06
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4ACC8C4360C; Tue,  4 May 2021 23:38:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B21BC43460;
        Tue,  4 May 2021 23:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B21BC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 0/6] BHI/BHIe improvements for MHI power purposes
Date:   Tue,  4 May 2021 16:37:52 -0700
Message-Id: <1620171478-35679-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series improves the power up behavior by allowing MHI host driver to
set BHI and/or BHIe offsets early on in the preparation phase and fail pre-power
up if offsets are not found or not within a limited MMIO region. This also
allows MHI host to clean up the offsets in the unprepare after power down phase.

Going forward, controllers will be required to specify a reg_len field which
will be used to check whether the BHI/BHIe offsets are in range or not.

This series has been tested on X86_64 architecture with the PCI generic driver
as controller and an SDX55 device.

v2:
-Added reviewed-by tags
-Moved reg_len entry in mhi_controller structure to allow for a packed struct

Bhaumik Bhatt (6):
  bus: mhi: core: Set BHI/BHIe offsets on power up preparation
  bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
  bus: mhi: Add MMIO region length to controller structure
  ath11k: set register access length for MHI driver
  bus: mhi: pci_generic: Set register access length for MHI driver
  bus: mhi: core: Add range checks for BHI and BHIe

 drivers/bus/mhi/core/init.c           | 58 +++++++++++++++++++++++------------
 drivers/bus/mhi/core/pm.c             | 28 +++--------------
 drivers/bus/mhi/pci_generic.c         |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c |  1 +
 include/linux/mhi.h                   |  2 ++
 5 files changed, 47 insertions(+), 43 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

