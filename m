Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A736258149
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaSpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgHaSpu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 14:45:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A6C061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 11:45:50 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d189so1837452oig.12
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRZTfMUNoTfqMIHstBB6IDHNONtkF33XnbARN6sgI9o=;
        b=Q17aMNhwa6+ONjXaAAqxeA356SybblBE4XQH5zNF62zk95XmqcBUfTL141UHegsVTz
         1pA8u53YAGiTfSPezYINLJsylQOnUIYz6rvm5EXqTPKmcVJz6BOD8YT1VGpEoHuebobx
         4p224BRARoHyMThrvgQH7e3mdIbehmIOmI7urjWS6VglPL27UGlgB96c+G9pGl0fyTde
         KbrwjbH/Js+BSVqWPP+H0pplsGqU7R6KzJURAYD4hcB7DhSIZUyXiq/x9X4+hhPPdbYO
         OUsIYrskFAuGbQN/mvJcWxQ76Q7rpaSSnyBLz/vfatNcxHs6PB/pez2SJTQCapiKRv/+
         7wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lRZTfMUNoTfqMIHstBB6IDHNONtkF33XnbARN6sgI9o=;
        b=t2VDnPLOfKagdDQPPxlDfNXJusv65l6X1UrSwZTpKcWkb5Je/m1M2fmeZTIqiD4X3v
         LCt0mwXtFUvJRSgcj/HoT6FYcn5iX4wHNEW4YvMaL6gAsY4a/Do62ZpaFbJLbJMA0c2W
         +AbN8mhuPWrPPkBbR5pOJCDyA+b0Exl5Ch6aHb5DLpu7WBsztSa86w+Hh6GQN7B77lmU
         mLoaxTSJEhWmTVJZ+UXClVxJ12HrgvKJjgaHsBM20VxidfIYX0XVDAVd/zw36m28oDoO
         LOECmzi1rBqHJgV3d128FKmSWiVWApasGrv5dh2gm42okoCwML1P4ZGzmZjdvKZg/dsB
         vT5g==
X-Gm-Message-State: AOAM533W1CvPPhlsh6quwY6fzF6tfYxzltqvpiQrXa2xbwbgKvdE4iBt
        aoNQXXhNJslHg6Y3LTzpz4DYK60TVz0=
X-Google-Smtp-Source: ABdhPJyTjCaCAL7NrtPnapqi+Hk5/QvJ4yC1CArWRV47qWpth++AffaTbbTFbXJPA65lzRnmp9d2hg==
X-Received: by 2002:aca:4b0b:: with SMTP id y11mr423050oia.147.1598899550119;
        Mon, 31 Aug 2020 11:45:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i23sm1784349oii.53.2020.08.31.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:45:49 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] rtlwifi: Remove temporary definition of RT_TRACE
Date:   Mon, 31 Aug 2020 13:45:36 -0500
Message-Id: <20200831184536.29950-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831184536.29950-1-Larry.Finger@lwfinger.net>
References: <20200831184536.29950-1-Larry.Finger@lwfinger.net>
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

