Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3722B7FF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGWUnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgGWUnB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:43:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E07C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:43:01 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w17so5404945otl.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tC6DQ+0Q52tkMZUGhpdr0KiSqE/z3zfCJfqHxGpnFt4=;
        b=j5zWnvU0j3PlsmMGY+5UbJSzAuN//a+tvt1EomKcupqbGy75xvpQ6HlNQh4nIUQCoV
         cz8slWIBuGlB3MEVsW420OUKoaWtP+uoULcSvxJHVty/phIR7N4G/+QZC5+eOpQU1kkd
         0Hh8Zi6bjiCXQliHBdqfq6dDnEdhLEjmDfEbjzD6BT3j8i4+y2zGcwq9l6dykkHEdBSZ
         72frKGoiMHxr0iRCpXfGQftUI6i2Sm3c5W53Ud9mNfeXeDgQjZ2gV38QHZO20j/da+ab
         apxzGk7r3Bkb8YpHV6sryulyfoNRtFVt5yUE/V6zrH45Rqo0SMqBLn0btxcwbd77GGN1
         4JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tC6DQ+0Q52tkMZUGhpdr0KiSqE/z3zfCJfqHxGpnFt4=;
        b=TbnIB5KgPjV3hzZrPokbo4ObKjiE4sb9Xs34WuqpeZWWJaNp5Zm6RvAFPXNdMAmcx4
         sdmReaCuj3NCTd7rI3ubZHpvSBiPts684QKD8UUe3K4gKukhsiLGXlbn1Y/AyF51Ssz/
         IypEpFSmaOlDNnqHZYFp4XqB6Sxbv++GjKmIRQJRGyE1mFRuBf/Wf0NhehKHcFgEXsBV
         5OYkQdUzdKyGHReIwmlhH2iy+9nkL1GW7MwlIB78jaKF0R56ow6oACpLmuzhizgTVytK
         PrAiGS4SCDO4a0X0RijITBg8QfUFNL4GXLpJKafBXd+s5UOyeeOMKGxnhFvtIMXs/pgn
         ODNQ==
X-Gm-Message-State: AOAM533gw9HmDghu3UrPW4x9WNyirdSdRvnRHNnvRP6dMGjrWr/yYwDu
        d0weLeNaJ+CcrKOSrz3iv+I=
X-Google-Smtp-Source: ABdhPJxdjd0dPK9EKQB00gAnULpDXWUEDfMl4mVe5EEERuzp9ShE+p/jNGteUUgX4BkBkWCt4dtA5Q==
X-Received: by 2002:a9d:66ca:: with SMTP id t10mr5628061otm.358.1595536981072;
        Thu, 23 Jul 2020 13:43:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:43:00 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 15/15] rtlwifi: Remove temporary definition of RT_TRACE
Date:   Thu, 23 Jul 2020 15:42:44 -0500
Message-Id: <20200723204244.24457-16-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
References: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A definition of this macro was kept until all drivers had been converted.
It can now be deleted.

This change also renames _rtl_dbg_trace() to _rtl_dbg_out().

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - the renaming of _rtl_dbg_trace was added
---
 drivers/net/wireless/realtek/rtlwifi/debug.h | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.h b/drivers/net/wireless/realtek/rtlwifi/debug.h
index dbfb4d67ca31..6028f1ffa5da 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -149,8 +149,8 @@ enum dbgp_flag_e {
 struct rtl_priv;
 
 __printf(4, 5)
-void _rtl_dbg_trace(struct rtl_priv *rtlpriv, u64 comp, int level,
-		    const char *fmt, ...);
+void _rtl_dbg_out(struct rtl_priv *rtlpriv, u64 comp, int level,
+		  const char *fmt, ...);
 
 __printf(4, 5)
 void _rtl_dbg_print(struct rtl_priv *rtlpriv, u64 comp, int level,
@@ -161,11 +161,7 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 			 const void *hexdata, int hexdatalen);
 
 #define rtl_dbg(rtlpriv, comp, level, fmt, ...)			\
-	_rtl_dbg_trace(rtlpriv, comp, level,				\
-		       fmt, ##__VA_ARGS__)
-
-#define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
-	_rtl_dbg_trace(rtlpriv, comp, level,				\
+	_rtl_dbg_out(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
 
 #define RTPRINT(rtlpriv, dbgtype, dbgflag, fmt, ...)			\
@@ -187,13 +183,6 @@ static inline void rtl_dbg(struct rtl_priv *rtlpriv,
 {
 }
 
-__printf(4, 5)
-static inline void RT_TRACE(struct rtl_priv *rtlpriv,
-			    u64 comp, int level,
-			    const char *fmt, ...)
-{
-}
-
 __printf(4, 5)
 static inline void RTPRINT(struct rtl_priv *rtlpriv,
 			   int dbgtype, int dbgflag,
-- 
2.27.0

