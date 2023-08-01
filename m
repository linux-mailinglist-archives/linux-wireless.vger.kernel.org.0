Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361E376BA2E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjHARBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjHARBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:01:14 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2732139
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:01:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a74d759be4so567998b6e.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909271; x=1691514071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/rScz+xouK4F5ZHbnUXms2EvElxwjziP3/QLiH6ABI=;
        b=S1yVH9XDE6x2JPwoELeXXzpn3lpytRMjfzVdjc6+ZyxCZTdEYylY5UsoJqvmEz7lh5
         ZqrV1PYxuJ9lAteJDuaQwXqQ6MwzJt+KYA89bEAGY66rbRBXc42a6fAwkPhV0NmmVX/I
         1DeoNbDsXDgO9ecswuUYfSaIFBxd4quVNY8X7szTTBbhbYCO4swthvl/wdUAe7y81j9d
         y+yo3jBylk5Trpe0AqenQwtZkm0DKGm1hVIHWSYPlDwHif4QWOOoyJOI19Rjq7rrnssA
         T0fGQkDi9hoZQa1z0h95MCuJYfcdzA+BsUa85GqQv3rW69gu5KWLwXi5xSzjx3R+2Onz
         piSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909271; x=1691514071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/rScz+xouK4F5ZHbnUXms2EvElxwjziP3/QLiH6ABI=;
        b=Z2Ly8m5cBPEtXlToD/GPtXFaK1PQsgmPDMUHInw+4LS9fQqh1btL3yUT4B1HAeq2+Y
         fm6QoJmmZuCFHMLjHvyga4WWWXiOogrDttB6sbgpFLEABXQp0EpmmshdeRkMWthP/mUm
         oLMGAJxh/w0mQa/DLiftJuv6QU/tiCXjSUKKYTwqa55N+JEF/BG5nB1orc81HOFZEfgW
         fPCWRzPIkxTpcAFEOndgl+0p9EGZqLQnAEwy1UZcSlL+CW45iRLkbK1vn5AmRoE9iPxh
         I9SsQtQaCuG36SuIto5l89PMNyHgD7Ef2wAaEkG2o1nzI9O+hTBpl9G4vZ7WIBT8ZCnW
         sL/Q==
X-Gm-Message-State: ABy/qLYBP0NhX2ypIfW/4W1DhX+ncNVr0ItD+VEjfnQDMTc01lJzO8+F
        /IIZYnAKfUJjesYWITp75l0=
X-Google-Smtp-Source: APBJJlEsy8afDa65UyM0rwP7RD4iXpL7IB71n1ucy3fip0PnTEWZPQEiYiTvSDNZvTIkOmNUxW5dkQ==
X-Received: by 2002:a54:4e81:0:b0:3a7:470e:5209 with SMTP id c1-20020a544e81000000b003a7470e5209mr3581409oiy.15.1690909271409;
        Tue, 01 Aug 2023 10:01:11 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bd16-20020a056808221000b003a1f444307esm5302506oib.58.2023.08.01.10.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:01:10 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/2] MAINTAINERS: Update entry for rtl8187
Date:   Tue,  1 Aug 2023 12:00:51 -0500
Message-ID: <20230801170052.6432-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170052.6432-1-Larry.Finger@lwfinger.net>
References: <20230801170052.6432-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As Herton Ronaldo Krzesinski and Hin-Tak Leung are no longer active,
remove them as maintainers for rtl8187.

The git tree entry is also updated.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0553ad37865..432818a1f9ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18523,13 +18523,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.g
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
 RTL8187 WIRELESS DRIVER
-M:	Herton Ronaldo Krzesinski <herton@canonical.com>
-M:	Hin-Tak Leung <htl10@users.sourceforge.net>
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
 W:	https://wireless.wiki.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 
 RTL8XXXU WIRELESS DRIVER (rtl8xxxu)
-- 
2.41.0

