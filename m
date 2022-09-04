Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642345AC628
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiIDT3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiIDT3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D5E42
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XyxHCooCm+t5LNvHPmlhJbF1ldSkAYz9mT1MhyfDdao=;
        t=1662319763; x=1663529363; b=Xv/xhS456ntEqiGMDDQW5zSBTj/ct2xZun1isu88WkGBaIh
        rb4e2Zwa7gF0b3ZDngzAaux+HuCHaJvqXjcHRmKkZtrfH3OycVYst3TeZk+jz8DYKAnOUqz+78FIR
        rvXZ9Wkr8Hog2ibi9I+16zrCcBbtl9zWEMZZghNCMXCwBN9Plw8utq9eR0xicL15Hxs8ofAyyyFnT
        6d+1p03vstFZojJyCdUcZyqUUPhj/HsO+mGz7yijUoNlymIJ9wQJ/IeAumcSMDP7LizThPShAI7Wh
        PZo2tH8EdcEsU/sF5Os8rso0zeiZ5jMcpol9aW1BWLL+k3j+3/Qt//6DsPnbLUgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ2-007pTZ-10;
        Sun, 04 Sep 2022 21:29:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/12] wifi: b43: remove empty switch statement
Date:   Sun,  4 Sep 2022 21:29:12 +0200
Message-Id: <20220904212910.ea00a892e41b.I709217fc307125f8670c7f6a9093111b46194131@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a TODO here, just move the dependency on phy->rev
into the comment. Not that this driver is likely to get
any updates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/broadcom/b43/phy_n.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index aa5c99465674..2c0c019a815d 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -2479,11 +2479,7 @@ static void b43_nphy_gain_ctl_workarounds_rev19(struct b43_wldev *dev)
 
 static void b43_nphy_gain_ctl_workarounds_rev7(struct b43_wldev *dev)
 {
-	struct b43_phy *phy = &dev->phy;
-
-	switch (phy->rev) {
-	/* TODO */
-	}
+	/* TODO - should depend on phy->rev */
 }
 
 static void b43_nphy_gain_ctl_workarounds_rev3(struct b43_wldev *dev)
-- 
2.37.2

