Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236872563D3
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 02:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH2Azd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 20:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgH2AzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 20:55:09 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F8C06121B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 17:55:09 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y30so176501ooj.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 17:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8MzicFj1jv+pxym8l4TgMyZtDgsCGTy5+b11EcLk38=;
        b=L9jHnMj4mEo0D6Ot433N6masdbk44xShTA+E8sSGRTkbRHVhnUhEFYlZKTJRLodcgJ
         02txFnJAZPDdPa+mImhwctSjyDRCHFvmW53s46gAirODd6ZL8BmFg+suexHdOHueeIAn
         3EsGZP367T0BPi4qPTcHfZLItLxledcR08JxhB7N67A/6ZwVQlUhYB/sF9ir8ZwKB928
         //x1P0v8DO1CX4UROAuBVYyMyxwwk5+y7auX3T46IYCthMrSIL3F8M8RE413udG9Jq/K
         3UKj3r3uZJ1Zw6H/uHVlQepEyd7UGWtnDViM1nLd8ZcPap6Fyo1l6HOl1xpCpUGpg+m4
         Y6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=z8MzicFj1jv+pxym8l4TgMyZtDgsCGTy5+b11EcLk38=;
        b=NJVKdfXziL68v8MHycN0XONfKxOyrYq02DFF/bJL/xbZzx5jtC9uDv8ZHabDRETS1V
         +iDtHvHARJkh4brMpIx/48QeI0WMzsb7l2Y3If1OuVsNGaWyO4Qwz2V+JJhsZ3BRBa5r
         DN6+z+7sq209HOsSYOhCM4h3dmJzhs9y0v/gBks14R/bssYrG0vAwaSeCGNMV1ui5AiR
         otofB7o7YiUmwR5+6cD3KRUBEgcKaLXqzCKRbaSoO/qPuG+Q6Et/vQw7EER+X8QlDRhN
         4ai+U/jjSKGS318x9fsbH6b4iqbgunwSFaPF8nKCpCCXLob43EzuaEeXnQ8PZWhX1b6b
         W0Eg==
X-Gm-Message-State: AOAM5333S3lE7+ZQ4z5veV1LGXBvB3QskCwMPcDs8XwOZCXSOOM3qoLK
        PnvE18a/9ZDJZPYiND93WaN2TZEMrh0=
X-Google-Smtp-Source: ABdhPJweL101qpqS3+rg1vPlvlfrAg1TyEs1tjVGs0BX+fSl5Pu3JeDI7mEPpPYFDeij7Finfgnjyw==
X-Received: by 2002:a4a:8dd5:: with SMTP id a21mr854692ool.17.1598662506957;
        Fri, 28 Aug 2020 17:55:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id w136sm202253oif.14.2020.08.28.17.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 17:55:06 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v3 15/15] rtlwifi: Remove temporary definition of RT_TRACE
Date:   Fri, 28 Aug 2020 19:54:42 -0500
Message-Id: <20200829005442.32318-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829005442.32318-1-Larry.Finger@lwfinger.net>
References: <20200829005442.32318-1-Larry.Finger@lwfinger.net>
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
2.28.0

