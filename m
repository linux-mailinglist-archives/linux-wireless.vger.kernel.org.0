Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA01B7108
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDXJgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:36:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:59904 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXJgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:36:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587720976; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=aoAS6ApzQFk7uFN0fnYDhXBLah67fvrMuksSM4OETu8=; b=opbZ4hIQNZwLGX89YGB1XjCZMLSehIhiqQ5SdR2K0duQU+idmnnHhoIjh7wVczOHOOQIJsra
 cPo7JgSUK16esv/ZbDXVNei8ZS9EDAF2XN/m8FS1nWuZ+OTxZYLIDwxSwJhcuBuUq9WeSB+G
 QIS3qyx/TCRxDpptYK1jE8Mv0Pw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea2b305.7f79a8bec5a8-smtp-out-n05;
 Fri, 24 Apr 2020 09:36:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D657C433CB; Fri, 24 Apr 2020 09:36:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C89E6C433D2;
        Fri, 24 Apr 2020 09:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C89E6C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH 0/2] mac80211: enable TKIP when using encapsulation offloading
Date:   Fri, 24 Apr 2020 15:05:49 +0530
Message-Id: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TKIP was disabled on encap offload mode since if TKIP MIC error
reporting is not capable by the driver using encap offload mode,
then TKIP countermeasures wont work.

Enabling back TKIP bring-up in encap offload mode to leave the
control with the driver to disable hw encap when it is not capable
of TKIP MIC error reporting.

Sathishkumar Muruganandam (2):
  mac80211: enable TKIP when using encapsulation offloading
  ath11k: add 802.3 undecap support to fix TKIP MIC error reporting

 drivers/net/wireless/ath/ath11k/dp_rx.c | 39 ++++++++++++++++++++++++++++++++-
 net/mac80211/iface.c                    |  7 ------
 net/mac80211/key.c                      |  7 ------
 3 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.7.4
