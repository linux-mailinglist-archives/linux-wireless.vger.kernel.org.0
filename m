Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEECA12D76B
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 10:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLaJ2U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 04:28:20 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:54863 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfLaJ2U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 04:28:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577784499; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=mTKUhHpyv9XUGAY6i6Cjq9PtpIfhaGISeeYfVIOr/QE=; b=gvQAye9qDZV6+TBzmVwNuM7lOBfrSFNWqqRF94SHkVUthPTRgtj0pr6iqJ657a0UKTWPvzsA
 PdVd0feKJrcoGLsqtfIB3RbBhwrYFs9WD9sFaIgyr1KE/RR+++/Q3icCP99toab9p82sP4ir
 2cVKWDIKd3Lp7/dOJrKiijeGwl8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b14af.7fb7254fe928-smtp-out-n02;
 Tue, 31 Dec 2019 09:28:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3557EC433A2; Tue, 31 Dec 2019 09:28:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AAA6C433CB;
        Tue, 31 Dec 2019 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AAA6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/2] start recovery process when payload length overflow for sdio
Date:   Tue, 31 Dec 2019 17:28:04 +0800
Message-Id: <20191231092806.6247-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

when it happened payload length exceeds max htc length, start recovery process

v3: change atomic_inc_and_test to atomic_add_return, remove check of ATH10K_STATE_ON

v2: add "add refcount for ath10k_core_restart" and remove ar_sdio->can_recovery

Wen Gong (2):
  ath10k: add refcount for ath10k_core_restart
  ath10k: start recovery process when payload length exceeds max htc
    length for sdio

 drivers/net/wireless/ath/ath10k/core.c | 8 ++++++++
 drivers/net/wireless/ath/ath10k/core.h | 2 ++
 drivers/net/wireless/ath/ath10k/mac.c  | 1 +
 drivers/net/wireless/ath/ath10k/sdio.c | 4 ++++
 4 files changed, 15 insertions(+)

-- 
2.23.0
