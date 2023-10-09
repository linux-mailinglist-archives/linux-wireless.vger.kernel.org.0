Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F527BD500
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 10:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjJIISd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJIISb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 04:18:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77638F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=IjeNk0Y5JtGnrNEcA2qCKSSicZ1bcfGYnsYpvYCB90s=; t=1696839510; x=1698049110; 
        b=dWnbkFKYZKZGr0vjVU7KPEQBFJGNW9Avlys4Jz51iNYFW4p8Wspdhd8CBWWxMYSPeHNpNDvDyHU
        Mqvry8GBGyBFpqcSpiOXBx+O3gYaFBkBm1m+Bn6pDg/77aQySJEFceJyC0+Pcy3F/8aal0nIAu9Xu
        9kI8CE+PEWryIUod93IM/J6aksg7Wi92v9yvAEjQwG3oTPmcdyHcIzfjNp5idIyU6lO+K5OflSTgH
        3/FsoRtYh3IBqrclUcnzTEidoeWPvD4Z26OOJdkn3MSbcw+TgUdr9YM+QCjc654+D2T2f6W8AXsI+
        PsTe3wLxMVP3j5UveueZV0OhPZyVSvd/TwmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC0)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qplTA-0000000FAki-1PNR;
        Mon, 09 Oct 2023 10:18:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: cfg80211: use system_unbound_wq for wiphy work
Date:   Mon,  9 Oct 2023 10:18:01 +0200
Message-ID: <20231009101800.bb75408bf635.I6528d97e24b3da36cdf633b4738327d77c7276f2@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since wiphy work items can run pretty much arbitrary
code in the stack/driver, it can take longer to run
all of this, so we shouldn't be using system_wq via
schedule_work(). Also, we lock the wiphy (which is
the reason this exists), so use system_unbound_wq.

Reported-by: Kalle Valo <kvalo@kernel.org>
Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 7df8ffcfa0c4..758c9a2a12c0 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1613,7 +1613,7 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
-	schedule_work(&rdev->wiphy_work);
+	queue_work(system_unbound_wq, &rdev->wiphy_work);
 }
 EXPORT_SYMBOL_GPL(wiphy_work_queue);
 
-- 
2.41.0

