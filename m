Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7D1ED968
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 01:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFCXdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgFCXcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 19:32:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10DC08C5C5
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 16:32:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 23so1600169pfw.10
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Hqe0fSnXDR9BQhToHGwDvWeXmOn6wXlTM1ZNtQBNo0=;
        b=YTEneSOLG0G03VL7npO7bUdyovAOz/rWIhWyhFR63irmezy8TdYcAkK240HUiwVQWE
         l1+wS3Zsf9sMrntm2h4pD25VpYQ6IwLesvsppd1RMdvcr3jcMToX3FgASNyJIcm+17M+
         RgKR5xqROZSaXLSFW/JQA7YcOaR/t1jFVii4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Hqe0fSnXDR9BQhToHGwDvWeXmOn6wXlTM1ZNtQBNo0=;
        b=Y0bj+lvpttRFnTslGa0mg0U3lSHD0/qwyCyY/5E/w5Uuq0khJxLWnOFrXDEGVYfWhV
         yb8Jn9FN4xCcY8kHEIjBO9AAv6WnYkZJJRpQbnYuSDl8Phn0q5EIFjesmSWaZnD14hpC
         fSgmjcKM3mAKXm27aHCdYR5Ie1wIX+b3YlWgKl2aPKELy55ufKJayDVPxX0vwD0rJW5g
         QTreeMxmQthFn2d3dYkzjISsCXj7mUkqZKASodgJqn8HAHxszULJig/WQq9eOU+088wg
         IQ1ixwpCfHQP4iLyfm9dbo3mqTFkSY03k3dWI+BWTSajIORz4TQ03TqOzvbDfjXFgQ9D
         IW2w==
X-Gm-Message-State: AOAM530b3D9S1EO7ZxwmYeX7QfIEgWOFLBDYhBKi0Zy9IkGsmOUpGjNg
        JCheZU2x3ICb4fzDVI+J3S+zgA==
X-Google-Smtp-Source: ABdhPJyfJH3U7PUxTmeWYwI+KnsyVJ3CXtEz238mctrUyUOZNrrAJx63byFxfj5FXVnOwJj3WTFGgg==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr1632114pgq.265.1591227138290;
        Wed, 03 Jun 2020 16:32:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3sm3402369pju.43.2020.06.03.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 05/10] ide: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:58 -0700
Message-Id: <20200603233203.1695403-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just remove this variable since it was
actually unused:

drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
        unsigned long uninitialized_var(flags);
                                        ^

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ide/ide-taskfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index aab6a10435b6..a26f85ab58a9 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -229,7 +229,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
 	struct scatterlist *cursg = cmd->cursg;
-	unsigned long uninitialized_var(flags);
 	struct page *page;
 	unsigned int offset;
 	u8 *buf;
-- 
2.25.1

