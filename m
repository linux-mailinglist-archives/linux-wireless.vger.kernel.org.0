Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3D76BA2F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjHARBQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjHARBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:01:14 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4BA268D
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:01:13 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a5abb5e2aeso4604744b6e.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909273; x=1691514073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkfLLvwnUcQgcOZYNdt8TtqnotawGrbSRiCzuwxk4qU=;
        b=fUXNpLEWIJ4Lrll/OaOe8FLA5UMObz67n78Sp0PkVwnDMdHu/AkIPLsQ2YRz2UgAM1
         cW5Zx3t4e9G5ZfXoMBrR5AVW2G0Ua5CCVL+9zR3II3oHatlZdu6tGUANDBLLJnVfTgSf
         P5KfypQnfZga0ljDEDUsBI6ZO3rEpR0tVfT4YUYZ/d6KTx+8G8hcsbmTxKxf4mDXvG2g
         MAaQXb8OLmH6EBOZNIDTSsKtCTOerz59NctuOVt2F7UoXAxL8eUWQj/AGpz9W2QuW7bf
         QozH90g3pjxpWHC+bfAo/nqCh0ZXXeqMmrywKch2tUD5kXiYXyHu5gu+JQaro9ix6J4X
         0e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909273; x=1691514073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nkfLLvwnUcQgcOZYNdt8TtqnotawGrbSRiCzuwxk4qU=;
        b=bH9rJ7Qjby+LrLxkCV2wpBz9hZW1VPZi9VEYL68tkUCmf4U0S34xVjhV4SemnFS8Zy
         Q5DGhybEMfGYaom4LkPxyDumqig+ErSiZGm/ton0tlvljnG+UyEhzqMFyhWxVa/oKiJx
         Y2+1kn2v/vuUZbJxjNQB9jjnCZsOVsAtKHogwfYvwesE1pauLxhEHz9g97UJYrZDEo4L
         k4OwVoYnmDYJEOyRCFZPZ6KUGERNw7VoRawx6V34AjFe8D2kS+Ix0JBWHXnNBNWqoEOv
         u//hI0ICXeTKMozC1J60o/kVlzRnp1xDB9keeEArl/QhDFBnF1dnTNf3pKHG1pAhJoWU
         /U6A==
X-Gm-Message-State: ABy/qLa4yfUl+rLKEUDHzwROnjwSI540jOiB7IwOX3bGVk/NBN8v7N7k
        /VMEZu4qPfwdjlEMOqZhG3Q=
X-Google-Smtp-Source: APBJJlFjTnGLwZCL+YWyiX/7fkP8Hhg4IGUfesz+F61G6PWpWtIkMlPLFQ00CQntduH63mqgsUIGgA==
X-Received: by 2002:a05:6808:238f:b0:3a4:3072:e597 with SMTP id bp15-20020a056808238f00b003a43072e597mr19520426oib.54.1690909272415;
        Tue, 01 Aug 2023 10:01:12 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bd16-20020a056808221000b003a1f444307esm5302506oib.58.2023.08.01.10.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:01:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] MAINTAINERS: Update tree entry for rtl8180
Date:   Tue,  1 Aug 2023 12:00:52 -0500
Message-ID: <20230801170052.6432-3-Larry.Finger@lwfinger.net>
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

This entry is obsolete. Update to current location.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 432818a1f9ad..9b5f24070fd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18519,7 +18519,7 @@ RTL8180 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	https://wireless.wiki.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
 RTL8187 WIRELESS DRIVER
-- 
2.41.0

