Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1116AB677
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbfIFKzn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 06:55:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391691AbfIFKzm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 06:55:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0A0B6115A; Fri,  6 Sep 2019 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567767341;
        bh=cCX/dbHZsdqP02XD6v5aEiK2L+Ll9aWqxJ4VRhY2PUA=;
        h=From:To:Cc:Subject:Date:From;
        b=IFjZPPQbI1+h7wyIAnjX0YT9AjJJy0ukOXgqrWMTKvFnlaMZXmUBc8S4RLRqrVOVc
         ZMLy32gKMTHhCH9DhkVAhcDT+lzymRctaQ19vvZ8QWJtsoRImx7Bl9MsvABW8Nv2Qw
         ssIGBvTDxzzSbnQsDA2FKDiEVOhpv1bH3B6YKp0Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB3E760770;
        Fri,  6 Sep 2019 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567767341;
        bh=cCX/dbHZsdqP02XD6v5aEiK2L+Ll9aWqxJ4VRhY2PUA=;
        h=From:To:Cc:Subject:Date:From;
        b=IFjZPPQbI1+h7wyIAnjX0YT9AjJJy0ukOXgqrWMTKvFnlaMZXmUBc8S4RLRqrVOVc
         ZMLy32gKMTHhCH9DhkVAhcDT+lzymRctaQ19vvZ8QWJtsoRImx7Bl9MsvABW8Nv2Qw
         ssIGBvTDxzzSbnQsDA2FKDiEVOhpv1bH3B6YKp0Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB3E760770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: remove the warning of sdio not full support
Date:   Fri,  6 Sep 2019 18:55:01 +0800
Message-Id: <1567767301-22940-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Recently, it has the basic feature of sdio tested success, so remove
it.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 8ed4fbd..0801215 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2073,9 +2073,6 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		goto err_free_wq;
 	}
 
-	/* TODO: remove this once SDIO support is fully implemented */
-	ath10k_warn(ar, "WARNING: ath10k SDIO support is work-in-progress, problems may arise!\n");
-
 	return 0;
 
 err_free_wq:
-- 
1.9.1

