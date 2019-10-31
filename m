Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAFEA8EB
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 02:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJaBm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 21:42:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfJaBm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 21:42:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 471E560A1B; Thu, 31 Oct 2019 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572486148;
        bh=LLgVPWAvJ0j/e4W6FJaFc0K1XmCnlrNL8yNz7PYkoH0=;
        h=From:To:Cc:Subject:Date:From;
        b=m1r8iGB//ZbDYdDiqene8EhixiRn55a2NgFPXb7SZ8WFj2tlm8CnzY8zdCOxaT7M7
         tfQpGoARheuZJE/Re+06i5N2l67zm7Le5NmxNk05rVlQakiCG8XB108sXe9/9leelG
         xirw7CvWTMiUIA3i2E9sOsIJatpOB9zlYoJSYQwQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from zhichen.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhichen@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE95F6081E;
        Thu, 31 Oct 2019 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572486147;
        bh=LLgVPWAvJ0j/e4W6FJaFc0K1XmCnlrNL8yNz7PYkoH0=;
        h=From:To:Cc:Subject:Date:From;
        b=Dsxgcx9CB7jbKow3axzb1xYKwUUIim4cB5+AJA5/cdeQyyv0zVZ38wK1WLeKgQ+HX
         cTXI1qPkYIUWeSTQca59gBUTuF7lSkk/4txM66DBN7rammfKS5TcF7bcGMsvo/JYAm
         ZWLfaV15sB3F4hNXVxUdw6Ko871TZBbKjLzQ7ZKE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE95F6081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=zhichen@codeaurora.org
From:   Zhi Chen <zhichen@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>
Subject: [PATCH] ath10k: fix potential issue of peer stats allocation
Date:   Thu, 31 Oct 2019 09:42:13 +0800
Message-Id: <1572486133-23516-1-git-send-email-zhichen@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

STA number was not restored if OOM happened.

Tested: QCA9984 with firmware ver 10.4-3.9.0.1-00018
Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b73c23d..61efc00 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6419,6 +6419,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats),
 						  GFP_KERNEL);
 			if (!arsta->tx_stats) {
+				ath10k_mac_dec_num_stations(arvif, sta);
 				ret = -ENOMEM;
 				goto exit;
 			}
-- 
2.7.4

