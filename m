Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40C19267A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYLB6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 07:01:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45807 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgCYLB6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 07:01:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585134117; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xjzz/UC4Hu0F5/jPhf6DHUwG3bGeaoviFfwKA8FSoMo=; b=JaTqzHlL940rC6f1jPNhBhAkYE4PqZIErN9C1CzzMeIyCDAgQJ8K0y7ZdGWnIiCAR0VAWkD2
 TC70bcjSlRnU9drvQ/OWNJNO78B7UGByrHfQdXnXaroKYoj89NmQsS8dnOeKcIAM5AHzmxFU
 a53P0iR5gqyZ0E3ayOpVN4Nk+Zo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7b3a1f.7fa59315d0a0-smtp-out-n02;
 Wed, 25 Mar 2020 11:01:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D741FC43637; Wed, 25 Mar 2020 11:01:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91456C433D2;
        Wed, 25 Mar 2020 11:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91456C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2 0/3] Add support to handle targets without TrustZone
Date:   Wed, 25 Mar 2020 16:31:37 +0530
Message-Id: <1585134100-5944-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The iommu mapping for S2 SIDs are taken care by TrustZone.
For the targets which does not have the support of TrustZone,
these mappings need to be created in the driver using an
iommu domain.

Leaving these SIDs unconfigured will result in a global
smmu fault. Hence configuring them for Non-TrustZone targets
is mandatory.

Changes from v1:
- Rebase and fix compilation errors on latest ath10k tree tip

Rakesh Pillai (3):
  dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
  ath10k: Setup the msa resources before qmi init
  ath10k: Add support for targets without trustzone

 .../bindings/net/wireless/qcom,ath10k.txt          |  14 ++
 drivers/net/wireless/ath/ath10k/core.h             |   5 +
 drivers/net/wireless/ath/ath10k/qmi.c              |  61 +------
 drivers/net/wireless/ath/ath10k/qmi.h              |   3 -
 drivers/net/wireless/ath/ath10k/snoc.c             | 182 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/snoc.h             |   7 +
 6 files changed, 208 insertions(+), 64 deletions(-)

-- 
2.7.4
