Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3A13398D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 04:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAHDUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 22:20:10 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:25850 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgAHDUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 22:20:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578453609; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=F7JyZ/oMEmFgVBHR7Mu5PKIJmLDZQX7TveUow6wRTL4=; b=VCRJ7Agy7+SpJnDoizu4KAyx/gvjvAr9kZxZkBqJU8EFWNfZfpwOpeQVBMk/IPyHo0Do8g24
 Jo+7aTpRgpeJ6up6YCqK/jkIbknDJTZeJihWA2tsX3ie+6lz4ifbBP6rsGl5IJnRQ7ufSPyX
 jM5i2Na+DeS9qEfgcUhZLG2whNU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e154a69.7faf27d8b500-smtp-out-n01;
 Wed, 08 Jan 2020 03:20:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D734C433A2; Wed,  8 Jan 2020 03:20:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA437C433CB;
        Wed,  8 Jan 2020 03:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA437C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4 0/2] start recovery process when payload length overflow for sdio
Date:   Wed,  8 Jan 2020 11:19:55 +0800
Message-Id: <20200108031957.22308-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

when it happened payload length exceeds max htc length, start recovery process

v4: add atomic_dec(&ar->restart_count) if state is not on

v3: change atomic_inc_and_test to atomic_add_return, remove check of ATH10K_STATE_ON

v2: add "add refcount for ath10k_core_restart" and remove ar_sdio->can_recovery

Wen Gong (2):
  ath10k: add refcount for ath10k_core_restart
  ath10k: start recovery process when payload length exceeds max htc
    length for sdio

 drivers/net/wireless/ath/ath10k/core.c | 13 +++++++++++++
 drivers/net/wireless/ath/ath10k/core.h |  2 ++
 drivers/net/wireless/ath/ath10k/mac.c  |  1 +
 drivers/net/wireless/ath/ath10k/sdio.c |  4 ++++
 4 files changed, 20 insertions(+)

-- 
2.23.0
