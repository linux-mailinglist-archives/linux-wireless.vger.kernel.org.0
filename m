Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C51AAFD0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411291AbgDORc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 13:32:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36947 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411184AbgDORcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 13:32:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586971923; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ocW1P/xBje/KUcO2hdCh72zNLVQhBCvlT1Qs7OrvvKU=; b=Go0AT7mWOUX7ksCQq6yAuFaGHoaeDkIbIt8mxKKWOOUhqU0tkhs/IxbHneSeO/GKDeQq8Kta
 AJJpt9pR674qdF6tyrNIMYzvycJ9elqZXGBnahZkAMbik5G78/01uLvSel9ZmctPSabgMwnl
 FhWG6dKBG7NdlUKyZgPO9Y1QlKs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e974509.7fe91348edc0-smtp-out-n01;
 Wed, 15 Apr 2020 17:31:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C627BC433BA; Wed, 15 Apr 2020 17:31:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A7B9C433CB;
        Wed, 15 Apr 2020 17:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A7B9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v3 0/3] Add support to handle targets without TrustZone
Date:   Wed, 15 Apr 2020 23:01:43 +0530
Message-Id: <1586971906-20985-1-git-send-email-pillair@codeaurora.org>
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

Changes from v2:
- Correct the name of the firmware structure added in ath10k

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
