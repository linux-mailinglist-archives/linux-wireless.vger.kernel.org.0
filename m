Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E2770BE8
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHDWZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjHDWZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 18:25:00 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59281BD5
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 15:24:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bce24bfd72so150202a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Aug 2023 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691187890; x=1691792690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTzfiVLlbcDi1mKeDSq6GzQOKbdgBxp4MIk47a7neV4=;
        b=Do/xtA6Rmp96E1dArB/5CtEE6jxtb57EN/egRA8B9qv+WnR7aFhDFJ6WmUkNiuOir6
         sCWhInunNR29e7VkzjVmMU0vHdVdbxSySzCCdtvmLPJR1DNxlkGtc1gycb6F+XVmzK1t
         S5Z5QLr0JFBUyaP4KPH2GtzY3+aCXaeMAumCXAuuMkujZqB6cA3k2pUgvrWY4Dn7JivT
         AkIzMIahffzijdqCkrx5/qWTUhZ9a7+ccVvd5v73AQxT4PFVI0Vrjdv9/tKpU7doyIvd
         bsQwhP5MMJinmAELYOm3AIvA8GsPohvzXdRHqzwLpqAtHLWXMlc6DX13KGHeH1pXOmkE
         hDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187890; x=1691792690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTzfiVLlbcDi1mKeDSq6GzQOKbdgBxp4MIk47a7neV4=;
        b=UUvgwZ607/onVjOF3msoai5WVa7T+swxzhrTkVo9gbJpmmeZoCNwYlpn9q7itsYGAU
         T3kAXwo9em0RNKKJUYU+ITbJMtzAcXBy9aAT7H0rQsCEkWVAg5+BgaLMz/h/bTrLDy4r
         4U1qm0dMFNqaD2g52vry/gQ/NQSFwOtwhigOKsQ1i902vcV/pT4Lb7V+rG20MZIReAQW
         P/OowHTh0K9yfzC43YhSfPOUtSrdwCgnXLvIotL4Y66GfcwxEqu7XpOQDco6rnBRev1A
         q3OVjZfxyMZvA2vuKUZ8gOgOCpkALy8Zhz6MCTTpxy7CUVxdNx7+qhSkTZWK/EUtJrkX
         yOAQ==
X-Gm-Message-State: AOJu0YyVm0LAdSpyawtVGdtgpiUP8Q8+50kG15iiYVWu76wOTvyoMXCd
        IWHEWleQxQMge0WPte0J3twRWRZwbrc=
X-Google-Smtp-Source: AGHT+IE7iFLRsipB0Vgr9FTnmGVzRXlMPtueR3R+dMVLvdTAVvgNvZgsKhZXg0CWl0zLphr45ErdJw==
X-Received: by 2002:a05:6830:164c:b0:6b5:8a98:f593 with SMTP id h12-20020a056830164c00b006b58a98f593mr2972366otr.8.1691187890115;
        Fri, 04 Aug 2023 15:24:50 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id x24-20020a05683000d800b006b8bf76174fsm1728379oto.21.2023.08.04.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:24:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/2] MAINTAINERS: Update entry for rtl8187
Date:   Fri,  4 Aug 2023 17:24:37 -0500
Message-ID: <20230804222438.16076-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804222438.16076-1-Larry.Finger@lwfinger.net>
References: <20230804222438.16076-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As Herton Ronaldo Krzesinski is no longer active, remove him as maintainer
for rtl8187.

The git tree entry is also removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0553ad37865..78fcede50979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18523,13 +18523,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.g
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
 RTL8187 WIRELESS DRIVER
-M:	Herton Ronaldo Krzesinski <herton@canonical.com>
-M:	Hin-Tak Leung <htl10@users.sourceforge.net>
+M:	Hin-Tak Leung <hintak.leung@gmail.com>
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 
 RTL8XXXU WIRELESS DRIVER (rtl8xxxu)
-- 
2.41.0

