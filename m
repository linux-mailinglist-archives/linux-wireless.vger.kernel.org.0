Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209241AC033
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506679AbgDPLvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 07:51:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50244 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506671AbgDPLvO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 07:51:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587037873; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cwwmQHr1vil7VSpsie/zJOQ8eZHvJ3DcsUDqo13IaCA=; b=nZh526vfKqR4RgNjGaBGB3KomXUEE5OG3f9OBIzCBmOtJLxNG6YbUbxhP7M2hGAFlcVeQqUn
 HmKd1KCgmJJ2YbhIe5sW8bN/A2gnTjZXYTO2rdwOyG5HHaIHuP4FdasBX5LccV8SI/0w7IHx
 HaHw7cjTUdvE/CaKaqSAWLGGRsA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9846a8.7f7cccebe068-smtp-out-n02;
 Thu, 16 Apr 2020 11:51:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29154C433BA; Thu, 16 Apr 2020 11:51:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25A3EC433CB;
        Thu, 16 Apr 2020 11:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25A3EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/4] ath10k: sdio: improve power consumption
Date:   Thu, 16 Apr 2020 14:50:55 +0300
Message-Id: <1587037859-28873-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here's a patchset for improving power consumption on SDIO with some refactoring
and some small cleanups afterwards.

v2:

* rename ath10k_hif_swap_mailbox() to make it usable for this

* small cleanups found while doing the refactoring

* compile tested only

Kalle Valo (3):
  ath10k: rename ath10k_hif_swap_mailbox() to ath10k_hif_start_post()
  ath10k: sdio: remove _hif_ prefix from functions not part of hif
    interface
  ath10k: hif: make send_complete_check op optional

Wen Gong (1):
  ath10k: improve power save performance for sdio

 drivers/net/wireless/ath/ath10k/core.c |   2 +-
 drivers/net/wireless/ath/ath10k/hif.h  |  11 ++-
 drivers/net/wireless/ath/ath10k/sdio.c | 168 +++++++++++++++++++++++----------
 drivers/net/wireless/ath/ath10k/sdio.h |  16 ++++
 drivers/net/wireless/ath/ath10k/usb.c  |  12 ---
 5 files changed, 139 insertions(+), 70 deletions(-)

-- 
2.7.4
