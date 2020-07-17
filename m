Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA212230FA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGQCC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgGQCCp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747AC08C5F3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e90so5814421ote.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hqFP2xjGpaUtvMh1ysanRgFrG2ay6fCG97KxZMUpMg=;
        b=LCEiKv5mnFkfkmaHkgo6VF7laeVFMBXe3VW1Xj5Rh+sn5s3gpUp4KNDDS9zvyaOD2o
         mXkFGG9RLV/N4EplAfJG3SltYk41nGzgNNH2Cbq/1Jv1HZvh9Rb3QORTGm5wz9sqLxDa
         PeGys/zvSGOnDIFR7r0n5W3c8LePRcLeWZ+uPSxqu0lSc4zVBcXDaeVrNU2CIt8S2to0
         ss+FtFycmAf/2cCsKiYPRRYvrnwspcZ2ElNyYVyUFoAUTlY/GLiQmG0r9prAgDw3G8oP
         PiEqu3gyJjRkdxoFO0EAZ+Gt2RARQR2zglCChY0isooBc4/hwKmLtYfSPEF72fZSxzNl
         0Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8hqFP2xjGpaUtvMh1ysanRgFrG2ay6fCG97KxZMUpMg=;
        b=J+c8qfqvyOSS7zYU8XNrJoBWGN241IwTlEO91m13/gNLRPyh6c8sGTP1EDw3iPr0wU
         H3KXtNKO9nE3xtfURbHrjmpZdT+leVWs3LRYyIfs2TezFodABg0cpoxm4T1PB0YwguiU
         Cql0yda09qN0eMIA5KDUMRoa4sgThpjU+0O4xuDPnED4ldP4nP6qZ5DGq5FQxzIWsUR/
         /tg4JtHsWeglMVEPVccIfG3h2EP2zNU3XBorLUA0TF16G5jDJozgR/hSoIC4nAAh0Bjj
         DhKBt8+trslhSX6VPk9gitCHmfUPJfjbZT7euE29Fx1z4UlxSfpedwDZhnfdtdOGQ7o0
         nnCA==
X-Gm-Message-State: AOAM533QRdxugTrTsAcEhjyebpDUWaJdyyY6ShIvv9U3i8H1tl3tUpdr
        R2AB8RiTmI79hfoJf1ADT+o=
X-Google-Smtp-Source: ABdhPJx6RIsAWPT8zh5LUNdtA1W+CWuL/gbe3dpI6sBvcRy+94BuI5aTse0AXFOT1vvJCJOFWZWM3g==
X-Received: by 2002:a9d:7551:: with SMTP id b17mr6527928otl.71.1594951353798;
        Thu, 16 Jul 2020 19:02:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:33 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 14/14] rtlwifi: Remove final instances of RT_TRACE macros
Date:   Thu, 16 Jul 2020 21:02:01 -0500
Message-Id: <20200717020201.18209-15-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These macro definitions were kept to allow building of intermediate
steps. They can now be deleted.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/debug.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.h b/drivers/net/wireless/realtek/rtlwifi/debug.h
index 7cb38644a4e7..fc1cd64a7541 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -164,10 +164,6 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 	_rtl_dbg_trace(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
 
-#define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
-	_rtl_dbg_trace(rtlpriv, comp, level,				\
-		       fmt, ##__VA_ARGS__)
-
 #define RTPRINT(rtlpriv, dbgtype, dbgflag, fmt, ...)			\
 	_rtl_dbg_print(rtlpriv, dbgtype, dbgflag, fmt, ##__VA_ARGS__)
 
@@ -187,13 +183,6 @@ static inline void RT_DEBUG(struct rtl_priv *rtlpriv,
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

