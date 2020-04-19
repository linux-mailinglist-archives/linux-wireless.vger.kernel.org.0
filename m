Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775F1AF98E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 13:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDSLU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725841AbgDSLU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 07:20:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834AC061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 04:20:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t63so6640295wmt.3
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oqIZa3zYdSKtfEDW9ORxtSFvOk9NL3nLKI1j4QeSOmQ=;
        b=Bi0/GvMW65TgGIUxdL7xdk4vUKiw75Y3eeIbhx/Hf8Ct93Lh3J9p2G7NAdrwrRJTZ4
         u/sYbkMNGWcyMu+n9L7PpzSe8it37ZEqkXaoy8csZlthHAv51yHP8Bk56SJaV9BOXybI
         VkC0PosRPTZ5Jwg5SE2KlUgUs3JKc5/8RwK/wLKs9w7STzfDsVw8cZqdjuHKQdxR0Wsz
         qvpcwE+xPiqkd0KAKzOvSEev/uSuw6mh8ZVx4L10+Uvj/GlLvhFek+nvwVw0TdxspHns
         5Zxf3N34FfJxK/tugrNxVLGfjiYvRwSAxNhnyEd75Ec+RogEg+CG1gWBxc3uTK2k8lxg
         8rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oqIZa3zYdSKtfEDW9ORxtSFvOk9NL3nLKI1j4QeSOmQ=;
        b=f8aqdFgpFbGvrWpgW/LzRvgFGQRnjEejWI477wu697KG4JDXIaq2oCUwPHAG97rBAI
         UCDX8JpT2NOT77TZrBoxHVgUq8BkiYzFRLCrQFKrePGLnhAHuAlMn391yUIcM27qNUah
         jWLRUZA1tTZQyuruCmuNCNTvbyHX9sYexH1GctaDg/edosMitqbc7gHBqGWhn0yXZn7R
         1vhhf4TfHemIF0112p+YhgJDIJk/QzxYmuwsqrZrR6Ek+9obIuJiWFpTzt0vmnAyf40P
         P6VulamESCilyJrVSdol9sSJZOW0rJJDRIhVlTb6o5n6H5udYV7bBUfWaI1WFQHwliVR
         NW4w==
X-Gm-Message-State: AGi0Pubp7kR/tyjDcHzyLZMzeA/F9wr1SQdX8g5jtEjjvkm9EfK99FI7
        +1trq+EoHo19ymDOGS/9mMKDsIQq
X-Google-Smtp-Source: APiQypITdwLs5sm4fkLQ+Cc9wBCnJAbhHoWvcC9iP4kttxUEj+2b/aAk0pp922KwhaduX4klj4gh6A==
X-Received: by 2002:a1c:ba56:: with SMTP id k83mr12141163wmf.1.1587295255163;
        Sun, 19 Apr 2020 04:20:55 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.57.threembb.co.uk. [188.29.165.57])
        by smtp.gmail.com with ESMTPSA id h2sm14536720wmb.16.2020.04.19.04.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 04:20:54 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH] staging: vt6656: call vnt_update_pre_ed_threshold from
 vnt_config.
Message-ID: <1b00c112-347c-b0bb-61ed-a874ee448ff8@gmail.com>
Date:   Sun, 19 Apr 2020 12:20:52 +0100
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

vnt_update_pre_ed_threshold needs to be updated more often so
call from vnt_config where it updated on any of config changes.

It must have maximum sensitivity when the device is off channel
or idle.

Remove all the other calls in scanning and bss.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/main_usb.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 3268d86fe93b..4bca0b99cf45 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -763,6 +763,12 @@ static int vnt_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_POWER)
 		vnt_rf_setpower(priv, conf->chandef.chan);
 
+	if (conf->flags & (IEEE80211_CONF_OFFCHANNEL | IEEE80211_CONF_IDLE))
+		/* Set max sensitivity*/
+		vnt_update_pre_ed_threshold(priv, true);
+	else
+		vnt_update_pre_ed_threshold(priv, false);
+
 	return 0;
 }
 
@@ -810,7 +816,6 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 		vnt_set_short_slot_time(priv);
 		vnt_set_vga_gain_offset(priv, priv->bb_vga[0]);
-		vnt_update_pre_ed_threshold(priv, false);
 	}
 
 	if (changed & (BSS_CHANGED_BASIC_RATES | BSS_CHANGED_ERP_PREAMBLE |
@@ -937,25 +942,6 @@ static int vnt_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return 0;
 }
 
-static void vnt_sw_scan_start(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif,
-			      const u8 *addr)
-{
-	struct vnt_private *priv = hw->priv;
-
-	/* Set max sensitivity*/
-	vnt_update_pre_ed_threshold(priv, true);
-}
-
-static void vnt_sw_scan_complete(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif)
-{
-	struct vnt_private *priv = hw->priv;
-
-	/* Return sensitivity to channel level*/
-	vnt_update_pre_ed_threshold(priv, false);
-}
-
 static int vnt_get_stats(struct ieee80211_hw *hw,
 			 struct ieee80211_low_level_stats *stats)
 {
@@ -1001,8 +987,6 @@ static const struct ieee80211_ops vnt_mac_ops = {
 	.prepare_multicast	= vnt_prepare_multicast,
 	.configure_filter	= vnt_configure,
 	.set_key		= vnt_set_key,
-	.sw_scan_start		= vnt_sw_scan_start,
-	.sw_scan_complete	= vnt_sw_scan_complete,
 	.get_stats		= vnt_get_stats,
 	.get_tsf		= vnt_get_tsf,
 	.set_tsf		= vnt_set_tsf,
-- 
2.25.1
