Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A77B0634
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjI0OHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjI0OHa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 10:07:30 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD6191
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 07:07:25 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2c18:0:640:83ff:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 6F94B60085;
        Wed, 27 Sep 2023 17:06:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id q6RDDjHDZuQ0-ZHoFYZGb;
        Wed, 27 Sep 2023 17:06:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695823613; bh=V5jL38z7vqGxcdpfnDCGfimOFFf/AbIGRB3gnQLlMI4=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=o2VcdNDTSvfeTXzHnI03TO7rls45cKwyHBC+SL62gmuCtQ3DbdgoIxFI9jxGTBebe
         owdg/5LmAhpYFH/48dbgXEZuzTwEO7rKf7LebUts9cNH+lkSSDGWIqON39/S1/ckAg
         HuvChrBxWqfCu4+GPL2mzgCIcD03pZEVym5Gcvo8=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: fix EDCA limit to set
Date:   Wed, 27 Sep 2023 17:04:59 +0300
Message-ID: <20230927140513.16065-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
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

In 'rtl92c_dm_check_edca_turbo()', most likely the DL limit should
be set from the corresponding field of 'rtlpriv->btcoexist' rather
than UL. Compile tested only.

Fixes: beb5bc402043 ("rtlwifi: rtl8192c-common: Convert common dynamic management routines for addition of rtl8192se and rtl8192de")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index 0b6a15c2e5cc..d92aad60edfe 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -640,7 +640,7 @@ static void rtl92c_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
-- 
2.41.0

