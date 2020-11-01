Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726AF2A21D0
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKAVRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgKAVRU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D202C0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 13:17:20 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7awEtJFUN8Qqezsp1s+wh6Wj0pYybb8lUU0KF9hZZw=;
        b=eopSm6N8RaPaZvEby91TB84/YQVaezUgNRFKMFt6K5rBgo5eKlOxT8TEMjEvBOSKAFLOVR
        S29xLG0l0bPltaL9KxoVJBoq56a6BZMPcrtanaAS/WzcykDJLmrGmg5O8Y4B52VTfhpjdD
        Tg9WJt0pBJ5OwGkKAhXyS7wvmza9jBF8a1PGgApKVwWYe+tdPKh0gUlpD+vDEoEyGOtjZF
        D6utR70VkW+a2ENlcDMZOyEbICKg88RvB0yg4JTn7Rvi3KvYj8Ud9TcZjtlYi995Fiqswh
        uoy3QnChCXxaHlyEx/8jFdZu1UsifD1s6y4kBllJFi0iFd6RoyibX4s9zzCdyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7awEtJFUN8Qqezsp1s+wh6Wj0pYybb8lUU0KF9hZZw=;
        b=joObuY7HORKKcO1+IYu3r5NA8UNSoimNQTLS7704UQ2MUIyjN/E247z3G3dRXa8VD/MWg1
        nFaAJBVRYRAP25CA==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 7/8] rtlwifi: Remove in_interrupt() usage in is_any_client_connect_to_ap().
Date:   Sun,  1 Nov 2020 22:15:35 +0100
Message-Id: <20201101211536.2966644-8-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

is_any_client_connect_to_ap() is using in_interrupt() to determine whether
it should acquire the lock prior accessing the list.

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

The function is called from:

    - halbtc_get()

    - halbtc_get()
        halbtc_get_wifi_link_status()

    - halbtc_display_dbg_msg()
	halbtc_display_wifi_status()
          halbtc_get_wifi_link_status()

All top level callers are part of the btc_coexist callback inferface and
are never invoked from a context which can hold the lock already.

The contexts which hold the lock are either protecting list add/del
operations or list walks which never call into any of the btc_coexist
interfaces.

In fact the conditional is outright dangerous because if this function
would be invoked from a BH disabled context the check would avoid taking
the lock while on another CPU the list could be manipulated under the lock.

Remove the in_interrupt() check and always acquire the lock.

To simplify the code further use list_empty() instead of walking the list
and counting the entries just to check the count for > 0 at the end.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  | 25 +++++--------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c =
b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index 2c05369b79e4d..2155a6699ef8d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -47,30 +47,17 @@ static bool is_any_client_connect_to_ap(struct btc_coex=
ist *btcoexist)
 {
 	struct rtl_priv *rtlpriv =3D btcoexist->adapter;
 	struct rtl_mac *mac =3D rtl_mac(rtlpriv);
-	struct rtl_sta_info *drv_priv;
-	u8 cnt =3D 0;
+	bool ret =3D false;
=20
 	if (mac->opmode =3D=3D NL80211_IFTYPE_ADHOC ||
 	    mac->opmode =3D=3D NL80211_IFTYPE_MESH_POINT ||
 	    mac->opmode =3D=3D NL80211_IFTYPE_AP) {
-		if (in_interrupt() > 0) {
-			list_for_each_entry(drv_priv, &rtlpriv->entry_list,
-					    list) {
-				cnt++;
-			}
-		} else {
-			spin_lock_bh(&rtlpriv->locks.entry_list_lock);
-			list_for_each_entry(drv_priv, &rtlpriv->entry_list,
-					    list) {
-				cnt++;
-			}
-			spin_unlock_bh(&rtlpriv->locks.entry_list_lock);
-		}
+		spin_lock_bh(&rtlpriv->locks.entry_list_lock);
+		if (!list_empty(&rtlpriv->entry_list))
+			ret =3D true;
+		spin_unlock_bh(&rtlpriv->locks.entry_list_lock);
 	}
-	if (cnt > 0)
-		return true;
-	else
-		return false;
+	return ret;
 }
=20
 static bool halbtc_legacy(struct rtl_priv *adapter)
--=20
2.29.1

