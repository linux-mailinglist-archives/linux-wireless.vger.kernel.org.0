Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE02146D6
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2020 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGDPO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jul 2020 11:14:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13484 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgGDPO2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jul 2020 11:14:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593875668; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MLKMTZNyc3QFHJy/rR1+1Qc+DtRKuBB4ufkkcfobh0E=; b=KsLZClGUIqQItHghHqUNhKWFteNCVhtyM00aAthjfAmCJdKlj/DNUMx+07yk+tMsj3vC4xsN
 WzUuqvm+B+GNqnYya/KJFIuMgnfH70qOuAdqoR5oEjcsUiN7GpzhtmXv7XXJzMNlVWIrmtfV
 5kmODLxvBUFsrJ5ggcX8aTfq3ZE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f009cc34c9690533adc4c63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 04 Jul 2020 15:14:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F624C433CA; Sat,  4 Jul 2020 15:14:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tamizhr-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF3C2C433C6;
        Sat,  4 Jul 2020 15:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF3C2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv2 0/4] ath10k: Add support for TID specific configuration
Date:   Sat,  4 Jul 2020 20:43:30 +0530
Message-Id: <1593875614-5683-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add TID specific configuration for noack, retry count, aggregation, Tx rate
and RTS_CTS control. Here if noack is enabled for the TID then aggregation
should be disabled and Tx rate should be and retry count will be 0.
Also add support for reset TID configuration.


Tamizh Chelvam (4):
  ath10k: Add wmi command support for station specific TID config
  ath10k: Move rate mask validation function up in the file
  ath10k: Add new api to support TID specific configuration
  ath10k: Add new api to support reset TID config

v2:

 * Fixed warnings reported by kernel test robot <lkp@intel.com>

 drivers/net/wireless/ath/ath10k/core.c    |   4 +
 drivers/net/wireless/ath/ath10k/core.h    |  20 +
 drivers/net/wireless/ath/ath10k/mac.c     | 837 ++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/txrx.c    |  11 +-
 drivers/net/wireless/ath/ath10k/wmi-ops.h |  19 +
 drivers/net/wireless/ath/ath10k/wmi.c     |  35 ++
 drivers/net/wireless/ath/ath10k/wmi.h     |  72 +++
 7 files changed, 905 insertions(+), 93 deletions(-)

-- 
1.9.1

