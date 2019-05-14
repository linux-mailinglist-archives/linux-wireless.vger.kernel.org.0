Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1131C590
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfENJCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 05:02:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJCh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 05:02:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4929F60F3D; Tue, 14 May 2019 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557824557;
        bh=bD3iKG3E35Kj0ikXVqdS2I0jjn4uY5AlrqsINgImqeU=;
        h=From:To:Cc:Subject:Date:From;
        b=lQGrLec8asJb4BP/irX+jFiOofqivLmx+wcxp3BADRsbEWl2loplL/KMJrdJL1zBD
         NCLBTgwqHs1D70BafF4qNkMqwBsktCQEphNSQmHc5J/G5SA62zS6mCwkdwBQnOu8N0
         2yknDrZ/GdhlGsm76pkdjobscd4kxc+q0HG+2Cos=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from ybzhao-Latitude-E5440.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 290BB60AD1;
        Tue, 14 May 2019 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557824556;
        bh=bD3iKG3E35Kj0ikXVqdS2I0jjn4uY5AlrqsINgImqeU=;
        h=From:To:Cc:Subject:Date:From;
        b=CeUahC1aV4y4hbSR9/geqZ7Tpi16izgANknnRruL0xNyjdw1TLeKIfY+T8AtZQ9gV
         tRKiHe6c7GfUZuMVovuFRTV6usdvC1diqKknmOw8TgBBPh1ssTIhiCGQ7kUSg3jogo
         kMmg6OnFc5q/9sRNsnwX8w39tyUBUEauEXI5r2Nw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 290BB60AD1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>,
        Zhi Chen <zhichen@codeaurora.org>
Subject: [PATCH v2] mac80211: remove warning message
Date:   Tue, 14 May 2019 17:01:47 +0800
Message-Id: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In multiple SSID cases, it takes time to prepare every AP interface
to be ready in initializing phase. If a sta already knows everything it
needs to join one of the APs and sends authentication to the AP which
is not fully prepared at this point of time, AP's channel context
could be NULL. As a result, warning message occurs.

Even worse, if the AP is under attack via tools such as MDK3 and massive
authentication requests are received in a very short time, console will
be hung due to kernel warning messages.

If this case can be hit during normal functionality, there should be no
WARN_ON(). Those should be reserved to cases that are not supposed to be
hit at all or some other more specific cases like indicating obsolete
interface.

Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
---
 net/mac80211/ieee80211_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 073a823..f39c289 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1435,7 +1435,7 @@ struct ieee80211_local {
 	rcu_read_lock();
 	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 
-	if (WARN_ON(!chanctx_conf)) {
+	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return NULL;
 	}
-- 
1.9.1

