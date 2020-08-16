Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05AE24575A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgHPLbV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:31:21 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28233 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728169AbgHPL3W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:29:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577362; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7wPJ68Ed5zoN5Ac10ycYYWKySJNL99AJ7zXMLlivc0E=; b=rqljs28jQqpGNUOV+y5DhNCLIh7l2R+rJdXYCrhyHLshTtx6PuSLdxZJF0f5suceL9E5RVop
 aFgiJMhWXZiXb+3QT05pI7kUKqUty+EVNbsg6ydrvcRNE+tl+367z/qOkNnElLL94TTh44Tm
 Y4pm0ZQEhQ9eetUXHQ/hKOkDGMA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f39159d3f2ce110204497e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4734C433CA; Sun, 16 Aug 2020 11:16:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72B8BC433CA;
        Sun, 16 Aug 2020 11:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72B8BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 00/12] ath11k: CE and HAL support for QCA6390
Date:   Sun, 16 Aug 2020 14:16:27 +0300
Message-Id: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here we are adding QCA6390 support to CE and HAL as well as some
changes to WMI.

For QCA6390 support there will be one more patchset after this. Please
review.

This patchset depends on the patchset:

ath11k: firmware and board file support for PCI devices

Kalle

v2:

* resend because it seems linux-wireless lost v1

Carl Huang (9):
  ath11k: hal: create register values dynamically
  ath11k: ce: support different CE configurations
  ath11k: hal: assign msi_addr and msi_data to srng
  ath11k: ce: get msi_addr and msi_data before srng setup
  ath11k: disable CE interrupt before hif start
  ath11k: force single pdev only for QCA6390
  ath11k: initialize wmi config based on hw_params
  ath11k: wmi: put hardware to DBS mode
  ath11k: dp: redefine peer_map and peer_unmap

Kalle Valo (3):
  ath11k: hal: cleanup dynamic register macros
  ath11k: ce: remove host_ce_config_wlan macro
  ath11k: ce: remove CE_COUNT() macro

 drivers/net/wireless/ath/ath11k/ahb.c    |  24 ++--
 drivers/net/wireless/ath/ath11k/ce.c     | 114 ++++++++++++++---
 drivers/net/wireless/ath/ath11k/ce.h     |  10 +-
 drivers/net/wireless/ath/ath11k/core.c   |  10 ++
 drivers/net/wireless/ath/ath11k/core.h   |   1 +
 drivers/net/wireless/ath/ath11k/dp.h     |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  |   2 +
 drivers/net/wireless/ath/ath11k/hal.c    |  72 +++++------
 drivers/net/wireless/ath/ath11k/hal.h    | 171 ++++++++++++++------------
 drivers/net/wireless/ath/ath11k/hal_rx.c |   8 +-
 drivers/net/wireless/ath/ath11k/htc.c    |   2 +-
 drivers/net/wireless/ath/ath11k/hw.c     | 204 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h     |  63 ++++++++++
 drivers/net/wireless/ath/ath11k/mac.c    |  33 +++++
 drivers/net/wireless/ath/ath11k/pci.c    |  25 ++--
 drivers/net/wireless/ath/ath11k/wmi.c    |  94 +++++++++-----
 16 files changed, 648 insertions(+), 191 deletions(-)

-- 
2.7.4

