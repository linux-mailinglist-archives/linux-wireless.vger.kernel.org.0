Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391BB5AC621
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiIDT3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDT3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4CD302
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=H3TVLDVNZQr0RQ9LVIulr4oOuxYblE+Bh++oeCm9M2A=; t=1662319761; x=1663529361; 
        b=pbwqs71vv+TEe2OhY0Pw5H0Ff5MOfKWTcjahPlI2whBrzhZCjWd/3qMgwmCEt5DdGiNznquuL+n
        lAU06hBtWia9qXRRuxhce6Rgo1t/D4O28xfJ9ElCNOb9UNR/6jDcILUvDfdXGCqft/kGE8btmLUFY
        MmPpCYfFllhYzhhic5NB93Y3FCNKBt4iv6PMFDnzODL5ljZDIYphpFCvOL+T7YMXbw3oA8BQhYw78
        hdyxHIQUWyreP83F6Vvg9WBxLQ42+9qUBO440ZuLQzRlarpSlcTj8jel0X9DUF2ngBehIVIsH0wGl
        HRc98RL7n+KrDZflJm/aGhGpSjbS+Rej1Cpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvIz-007pTZ-0Q;
        Sun, 04 Sep 2022 21:29:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/12] wifi: ipw2100: fix warnings about non-kernel-doc
Date:   Sun,  4 Sep 2022 21:29:01 +0200
Message-Id: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
X-Mailer: git-send-email 2.37.2
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

Just remove the extra asterisk to make it not be
kernel-doc formatted.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index ac36c899134e..b0f23cf1a621 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6529,7 +6529,7 @@ static struct pci_driver ipw2100_pci_driver = {
 	.shutdown = ipw2100_shutdown,
 };
 
-/**
+/*
  * Initialize the ipw2100 driver/module
  *
  * @returns 0 if ok, < 0 errno node con error.
@@ -6561,7 +6561,7 @@ static int __init ipw2100_init(void)
 	return ret;
 }
 
-/**
+/*
  * Cleanup ipw2100 driver registration
  */
 static void __exit ipw2100_exit(void)
-- 
2.37.2

