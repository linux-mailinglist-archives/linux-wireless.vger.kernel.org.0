Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618057B5FEA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 06:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjJCEeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 00:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjJCEeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 00:34:09 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E49B
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 21:34:02 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c20c:0:640:6c41:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 0824F60044;
        Tue,  3 Oct 2023 07:33:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vXNvfL8DdqM0-JHCcjAZX;
        Tue, 03 Oct 2023 07:33:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696307638; bh=dSVdFNLQTwP64r7aY1IHz8pBXm61fRRswk5wUEnkA48=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=H36ig/EOHbECQ1XJj7cYIhZv8DxsAnp1AgkiUcsri12ezlKJhyKirUWsyFHDjSKgB
         ZUnKhoOywI2eKSQDmnaDsI84g/gcq6KU75HuH8FWXW4yAItFX80u6aTd+eevunjipl
         MSVbcL86x4Tqv8JacsHQ1hIcDBH6j34Baajf38Tc=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()
Date:   Tue,  3 Oct 2023 07:33:16 +0300
Message-ID: <20231003043318.11370-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ce2f5b6b051748db84b8d4234d758ef7@realtek.com>
References: <ce2f5b6b051748db84b8d4234d758ef7@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since '!(0x5ea42b & 0xffff0000)' is always false, remove unreachable
block in 'rtl92d_dm_check_edca_turbo()' and convert EDCA limits to
constant variables. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: ensure reverse X'mas decls and adjust commit message (Ping-Ke Shih)
---
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c    | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index 6cc9c7649eda..cf4aca83bd05 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -592,32 +592,18 @@ static void rtl92d_dm_check_edca_turbo(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	const u32 edca_be_ul = 0x5ea42b;
+	const u32 edca_be_dl = 0x5ea42b;
 	static u64 last_txok_cnt;
 	static u64 last_rxok_cnt;
 	u64 cur_txok_cnt;
 	u64 cur_rxok_cnt;
-	u32 edca_be_ul = 0x5ea42b;
-	u32 edca_be_dl = 0x5ea42b;
 
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

