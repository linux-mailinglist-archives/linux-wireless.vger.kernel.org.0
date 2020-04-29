Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC31BE67F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD2Sod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgD2Sod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 14:44:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D7C03C1AE
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 11:44:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so3187984wmc.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RZJHwCxCbQeMsgn1IlnEFNBZsOdeAV4P2O5iQG5bMuA=;
        b=PhQvfhhTBuit2cIQdfBfbUwmb2yIAEX01Nl1CF2WtZtE7F6DpcAqHC2JUiADu/IbfB
         1WOTJvvvu2srdgC2chlKxfWPRkDQai8wvPZ2j1To64FGhxXlcRXe0Itu8Ey8aWVhk3h4
         7pGCkK7NScZQOJlO+I//lZXsLQ2Mkpz2A9PGAXCgXAwAo9b1rFegiNnuskILeKHlYZaR
         os73e3nPDBzzPR0qZPRjfIa9yG2iorGr1xQJh+dOG5r4oPRvMVKJicy1w0Vn5VCC3uJA
         6F5faCGkuMAScXlLXnRciPMrcBCmC7YjcLMEn0M/UwPrAB6FOGn7t0g8XY0r6MvxhwFM
         Q0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RZJHwCxCbQeMsgn1IlnEFNBZsOdeAV4P2O5iQG5bMuA=;
        b=f60D6Ezna9MNYRiKjawo0921RJQ0M/FbMzEDg2Eh/65zAqOWXIw0Y7tIvDpZ6nl9av
         6TjmPqWqKs4tiRIwfhGrMnYl/d72Ryn3oIsq9KxkXsmcVkmbdDWuCTtpGRBXPkKs3SfB
         qg0yEgoG+vmISkwCCUHHM2w3FcquJFuNelMCCwpFttpM2+BNAEykymYuFvOJ6y5SU2Zk
         l9s32LVogVteaK31KoYVyNk2SuZgCacWzmb94fZpNBV//lFYKJxAlcSJp6WrqLzevTdA
         DJ5d0ve1cIMc81RoSpV6vcxKBEEBp2L+pZb9iy8WIRONes36aSxwcrYWCG4BTxdCmnv6
         GxxA==
X-Gm-Message-State: AGi0PubA3XUgraiv7aUe0vudXlQM379DiipExwe+tYW4gBYhsNnB4Rb2
        xTr0cSdmzqM5r8dEo4dP0GDhvGMc
X-Google-Smtp-Source: APiQypLtoA222rR5uHfba83rSlpFAPFw/B8xJCaNydBniOGwkm0yOBCrIqi0rt3r/IO6u3ptXpLqVA==
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr4393934wmf.143.1588185871738;
        Wed, 29 Apr 2020 11:44:31 -0700 (PDT)
Received: from [192.168.43.18] (188.29.164.11.threembb.co.uk. [188.29.164.11])
        by smtp.gmail.com with ESMTPSA id p7sm183561wrf.31.2020.04.29.11.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 11:44:31 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/3] staging: vt6656 remove vnt_mac_disable_keyentry calls
Message-ID: <844df68d-08e2-7672-524f-42b918e300c1@gmail.com>
Date:   Wed, 29 Apr 2020 19:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not necessary to disable all the keys mac80211 will
have removed any existing keys that were used.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/key.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/vt6656/key.c b/drivers/staging/vt6656/key.c
index 47338077c033..de54cc3ff95a 100644
--- a/drivers/staging/vt6656/key.c
+++ b/drivers/staging/vt6656/key.c
@@ -102,22 +102,14 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	struct vnt_private *priv = hw->priv;
 	u8 *mac_addr = NULL;
 	u8 key_dec_mode = 0;
-	int ret = 0, u;
+	int ret = 0;
 
 	if (sta)
 		mac_addr = &sta->addr[0];
 
 	switch (key->cipher) {
-	case 0:
-		for (u = 0 ; u < MAX_KEY_TABLE; u++)
-			vnt_mac_disable_keyentry(priv, u);
-		return ret;
-
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
-		for (u = 0; u < MAX_KEY_TABLE; u++)
-			vnt_mac_disable_keyentry(priv, u);
-
 		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
 				KEY_CTL_WEP);
 
-- 
2.25.1
