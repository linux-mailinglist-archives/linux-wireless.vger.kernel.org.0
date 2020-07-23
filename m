Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2B22B7F1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGWUmu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWUmt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E57C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so5371344oty.11
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4SKueEcn9l/qfoXDUncnVtgrYCYelfmY5D0g8panqI=;
        b=tEeD571rvBGjC7WedD39dE4xogBSHz9kuuuimfj4Z36IdRRo1dEPprQDf1YBgCZGFR
         MTkuT+o7OIlsCAvdOZAIoLzWP6Mue2I9x6ai5VjxaPb99qNnt9YZFL3nnOAP/D85qpFX
         kRTlxxxfkfUUcRX+3w0Wl+quY960MDR5dmuevT0zx2yMalaWb9+IZfvzHSdG9JRujZ3U
         BImYftGlYuY1S9e6e3lD8kwPzOnc5tzKVPZk3wWel2bZX3EWdM0s1Pkt7ptso9vYoPoK
         JvBF2JAHV0bmUpyYR/gVKLg+gnhjqsqA3DbHtVhSQ3x8ViRX7vStqnwgiW713IZ5tORM
         Y1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=j4SKueEcn9l/qfoXDUncnVtgrYCYelfmY5D0g8panqI=;
        b=LOQeVbUHkJWhq5OpYSbidff+XwVe3WOX8vkviwASdWAElhUCPaH6madeHpdmynsYyK
         zIzwpa9G/jjqxSL8m0Gm6fEA9RcJWfAKueU7SXpsqcgfrmj+9mNtGlndsDufWOteL0wg
         fwcFXLB1vQvtFy+8JwD9j42o1KjaX6CQ4i5fCyKPd25ilmfPWqHwkOztLzGXOQEiE2zJ
         g3IH40jXS0TuG18atW5IngEQD9+cX9MxWfvxGO9EKZLq7qEWQj/pVg+VQFosCEwabgfc
         eAvx0PeHaiiSvKVdFnZHABZcT5u3JJn8qS7tMBG+wMmwAe1asrYRtYMW+oeaYM4yuywt
         /Gog==
X-Gm-Message-State: AOAM532EZurhjiC5IyiuIBpN8hitXBFSnhbGi36cMaIq5ZGVdH8PY1QI
        dRRkowlM8BQhOrIFdMcR/ss=
X-Google-Smtp-Source: ABdhPJxohsk2Dqwq1xx/YRV/yP7Qe/+3LC5mD9AQNV42cf93Iz+seYyGN3FhogQ/vl4BxTB7xus5/Q==
X-Received: by 2002:a9d:5781:: with SMTP id q1mr5666614oth.53.1595536969269;
        Thu, 23 Jul 2020 13:42:49 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:48 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 01/15] rtlwifi: Start changing RT_TRACE into rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:30 -0500
Message-Id: <20200723204244.24457-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
References: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The macro name RT_TRACE makes it seem that it is used for tracing, when
is actually used for debugging. Change the name to RT_DEBUG.

This step creates the new macro while keeping the old RT_TRACE to allow
building. It will be removed at the end of the patch series.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - This patch only defines rtl_dbg as suggested by Joe Perches
---
 drivers/net/wireless/realtek/rtlwifi/debug.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.h b/drivers/net/wireless/realtek/rtlwifi/debug.h
index 69f169d4d4ae..dbfb4d67ca31 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -160,6 +160,10 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 			 const char *titlestring,
 			 const void *hexdata, int hexdatalen);
 
+#define rtl_dbg(rtlpriv, comp, level, fmt, ...)			\
+	_rtl_dbg_trace(rtlpriv, comp, level,				\
+		       fmt, ##__VA_ARGS__)
+
 #define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
 	_rtl_dbg_trace(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
@@ -176,6 +180,13 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 
 struct rtl_priv;
 
+__printf(4, 5)
+static inline void rtl_dbg(struct rtl_priv *rtlpriv,
+			   u64 comp, int level,
+			   const char *fmt, ...)
+{
+}
+
 __printf(4, 5)
 static inline void RT_TRACE(struct rtl_priv *rtlpriv,
 			    u64 comp, int level,
-- 
2.27.0

