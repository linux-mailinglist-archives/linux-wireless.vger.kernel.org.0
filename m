Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11CC7B2EFE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjI2JOM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjI2JOJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 05:14:09 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D01A8
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 02:14:05 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id C0EC7600C1;
        Fri, 29 Sep 2023 12:14:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1EOR8n1Dea60-78LhitUX;
        Fri, 29 Sep 2023 12:14:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695978842; bh=up1bkoZxYuknmNRNiNY+fB6Z2qt0RPcBeq4V7zP4unw=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=JgXe/xD8fM9nJ5yoqgSETqkGhZ5qHwI03HeSqFrQW6V9DPjrHJPBAfvJP1rSbMYNQ
         /rf6JMAiPR+BRVacZYj6ArIjFkag7bpBZrI55WM9bv9lWOsRKpckO0WICT8L93eKGc
         6EY16oevs0tFzGbh7gVNFuvNL4X3VnOXwuXFPK/Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()
Date:   Fri, 29 Sep 2023 12:12:22 +0300
Message-ID: <20230929091229.13129-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since '!(0x5ea42b & 0xffff0000)' is always zero, remove unreachable
block in 'rtl92d_dm_check_edca_turbo()' and convert EDCA limits to
constant variables. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c    | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index 6cc9c7649eda..87798d7f5407 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -596,28 +596,14 @@ static void rtl92d_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	static u64 last_rxok_cnt;
 	u64 cur_txok_cnt;
 	u64 cur_rxok_cnt;
-	u32 edca_be_ul = 0x5ea42b;
-	u32 edca_be_dl = 0x5ea42b;
+	const u32 edca_be_ul = 0x5ea42b;
+	const u32 edca_be_dl = 0x5ea42b;
 
 	if (mac->link_state != MAC80211_LINKED) {
 		rtlpriv->dm.current_turbo_edca = false;
 		goto exit;
 	}
 
-	/* Enable BEQ TxOP limit configuration in wireless G-mode. */
-	/* To check whether we shall force turn on TXOP configuration. */
-	if ((!rtlpriv->dm.disable_framebursting) &&
-	    (rtlpriv->sec.pairwise_enc_algorithm == WEP40_ENCRYPTION ||
-	    rtlpriv->sec.pairwise_enc_algorithm == WEP104_ENCRYPTION ||
-	    rtlpriv->sec.pairwise_enc_algorithm == TKIP_ENCRYPTION)) {
-		/* Force TxOP limit to 0x005e for UL. */
-		if (!(edca_be_ul & 0xffff0000))
-			edca_be_ul |= 0x005e0000;
-		/* Force TxOP limit to 0x005e for DL. */
-		if (!(edca_be_dl & 0xffff0000))
-			edca_be_dl |= 0x005e0000;
-	}
-
 	if ((!rtlpriv->dm.is_any_nonbepkts) &&
 	    (!rtlpriv->dm.disable_framebursting)) {
 		cur_txok_cnt = rtlpriv->stats.txbytesunicast - last_txok_cnt;
-- 
2.41.0

