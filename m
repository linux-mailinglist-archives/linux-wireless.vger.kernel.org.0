Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FCE5AC627
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiIDT3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiIDT33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F34E6F
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FaVm/KMr8KZJ4C2iMgCupxVWJ5k7WqrPwqGZksbYjzU=;
        t=1662319762; x=1663529362; b=xV7oDyzuLXKY26NVK1a8q/xrHX4TVNaJ8M4ffd56F3ED7xx
        ewSi5Lq3CtIbYhf/IHUhoxp7snnXrdnXYs+1rGJh8z1StbM1HvYz75J7y76xhGfs+5A4L4mXKlF85
        Wpjj+PB70Cm+29lR6cI87RkftaNMLM/DcW/QnuHMCLj/Hd1xUQGiM8XstlMh5QkpMHr6QcPCL8hcH
        R5aNq1IxqPpenY2rfr2oFhN+xvUKITVmEIF+yVscDw7w8k/cO92to9zwfDxb7uE4AGLCwM5rdZh3X
        CXiNaiI32I1qwRl/bZyuNQqcSNMCY55jr9t6SJWxfWeqbWy9JygdMeXmXzlm1fxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ0-007pTZ-2X;
        Sun, 04 Sep 2022 21:29:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/12] wifi: mwifiex: mark a variable unused
Date:   Sun,  4 Sep 2022 21:29:06 +0200
Message-Id: <20220904212910.5d67f55178a1.If0789ab326935896e5886fa06dbb9ef0da6c0b41@changeid>
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

We need to read a value from the device to wake it, but if it
succeeds we don't really care about it. Mark the variable to
avoid a compiler warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index f7f9277602a5..5dcf61761a16 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -644,7 +644,7 @@ static int mwifiex_pm_wakeup_card(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
-	int retval;
+	int retval __maybe_unused;
 
 	mwifiex_dbg(adapter, EVENT,
 		    "event: Wakeup device...\n");
-- 
2.37.2

