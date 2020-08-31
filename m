Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E825815B
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHaSuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgHaSuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 14:50:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CB7C061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 11:50:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t7so6286875otp.0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRZTfMUNoTfqMIHstBB6IDHNONtkF33XnbARN6sgI9o=;
        b=OGgIkMrfcuOv6d9yBPidwQSSQuhWrNFK6tDzicaA83HkIhRMkPSYTeNY4Yy+s4FuTk
         8tBnc68dgkT5N6c9C8oYDOYqsEHSYthjJc3ABNR7z/+EyJ69q8obwuhWPOW995W+NMOi
         oD3wscqM+w5w1yJR+xq+QSW9rftRYpZFnCd2zo1rcNV331PNbOfXz+/qM36uupoDRneN
         qkOWwm2Cp41/6StjwEk3xmDR1OPU6eO/iwJaHmT0v+Gk1lwwps73YZmEw6OlhAFnXpiR
         XZPy5m8zTB2rcrFTm7c0lq7LcYVjr2m+BELy4gEKINgw80B+e5vp4rWXQ752mJBQeV6T
         5XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lRZTfMUNoTfqMIHstBB6IDHNONtkF33XnbARN6sgI9o=;
        b=LZN0wEpmNYb4H0Ha3fdL+d+82IW/WvDE6OTQRxYaRELZ5W0bEG7Nq6DOXAq6/I0g1n
         fVMt8XYwpNy1xQQYmFWrGn6wZGRVdtC1MbRt73uSK+9hJFaQmNnGHe8Np9yW/h8WSipN
         g/BaaJKfxdVnKqdIGtwthfOn15ZwKDNUp71afeYNBt69WHCBhi4HGnGjfBQo/6JQ9kdi
         XF7qScBlOTjSaomHpwFmP6J9InXT92ztFUyoclrIm0PZmAYaKFJb6c3PHYxzjPOHP2lq
         VIqU72yjyNWZT2RdEn5Dse8kUtDfK/c7oY4/RQCCezYOJZaz4thSGZKGIH3e2ar/v7QY
         FDjQ==
X-Gm-Message-State: AOAM532gyZxAgis18cqT6fi+710Nza0uCLjcPTpgT8ZT/TxZtGnjdcGF
        Pj9NNSVJam0xSnmh63xYHJ4=
X-Google-Smtp-Source: ABdhPJyYY+pRtd0pxD6+d1F4l8Sekw2rQVRM8ctZ2pIitlj771LAf9aC/vOUfENBSwa5mvin+fzLOA==
X-Received: by 2002:a9d:3d74:: with SMTP id a107mr1784087otc.360.1598899854642;
        Mon, 31 Aug 2020 11:50:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 98sm1911952otd.71.2020.08.31.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:50:53 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v4 15/15] rtlwifi: Remove temporary definition of RT_TRACE
Date:   Mon, 31 Aug 2020 13:50:46 -0500
Message-Id: <20200831185046.30307-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.28.0
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
v2 - rtl_dbg is used rather than RTL_DEBUG
v3 - the problems with the original submission are fixed.
v4 - Change to debug.c was missed.
---

 drivers/net/wireless/realtek/rtlwifi/debug.c |  6 +++---
 drivers/net/wireless/realtek/rtlwifi/debug.h | 17 +++--------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index de15d42c7b3c..455b87e7548b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -8,8 +8,8 @@
 #include <linux/vmalloc.h>
 
 #ifdef CONFIG_RTLWIFI_DEBUG
-void _rtl_dbg_trace(struct rtl_priv *rtlpriv, u64 comp, int level,
-		    const char *fmt, ...)
+void _rtl_dbg_out(struct rtl_priv *rtlpriv, u64 comp, int level,
+		  const char *fmt, ...)
 {
 	if (unlikely((comp & rtlpriv->cfg->mod_params->debug_mask) &&
 		     level <= rtlpriv->cfg->mod_params->debug_level)) {
@@ -26,7 +26,7 @@ void _rtl_dbg_trace(struct rtl_priv *rtlpriv, u64 comp, int level,
 		va_end(args);
 	}
 }
-EXPORT_SYMBOL_GPL(_rtl_dbg_trace);
+EXPORT_SYMBOL_GPL(_rtl_dbg_out);
 
 void _rtl_dbg_print(struct rtl_priv *rtlpriv, u64 comp, int level,
 		    const char *fmt, ...)
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
2.28.0

