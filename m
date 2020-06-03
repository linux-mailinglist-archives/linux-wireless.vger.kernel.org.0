Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5C1ED970
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFCXd3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 19:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgFCXcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 19:32:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F54C00863F
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 16:32:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so258133pjb.5
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlsGh/2A3yd9dyMlCDYBd0p4l1T5Oo7IaL6NTs2MBUk=;
        b=TU9flWAg9FMH+Npku3SFev/YYK6vvYYCp6jsnIW2uRPdSGDM2UMjhH0to/RSt2mcu+
         +tEJTAZqQ0UV4spAC//nbMEU4YZmc6CW1cgHcGYV50zllOcjZjx+9n/jCEKcVaB/68HX
         WckrYbpJZIVMmdggrVZUzoJLKS1NezuTTfatg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlsGh/2A3yd9dyMlCDYBd0p4l1T5Oo7IaL6NTs2MBUk=;
        b=J8CRm8y2g9XpR4uiZMv3Gu4CDpQ3yQrbhhYqMPcSeCG91LGrLSGhvMRygvzymODoKv
         reS4lbcL9oemfqlP+yr7QLcx4Q8iefO4gvxkNVARD7da9aIq1sQ3RgPvtIKRwmq3VSkM
         1DHJMDeUgyn0J4GQS2ML7aaW+zfAz6Oq9K5QlExrz+r8B4IH8Wdbsofi9JF3Ssw7H30z
         6gXl5NeZSwgcqZC92slUk1WjkIWQeFQ4YQ/Ubx+YMBGYvqsu65WKCKDdP2VAPc590sy6
         6iu+la1lJ+LruY5pSRlPguTghDc9BiC3ecoPybl6MwQe0YckrL4GYGPtqDFUSMpTq/nj
         GSGw==
X-Gm-Message-State: AOAM530OV37UWxxn+DmdvWGtuRxr7AAUMsOpoXdjgfC3lszBcz4uZ1Ye
        JNkT1+iezNRdJYDawPUy5KkDVA==
X-Google-Smtp-Source: ABdhPJyBu+lQtrGYhp3WZ7ZyvY1X8s9WoOeJvHWXF5Ulh61p00d2PYdWCaVGKn3LkWqTOEtrYGlBGw==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr2119692plb.241.1591227137753;
        Wed, 03 Jun 2020 16:32:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1sm3836817pjc.33.2020.06.03.16.32.14
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
Subject: [PATCH 06/10] clk: st: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:59 -0700
Message-Id: <20200603233203.1695403-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drivers/clk/st/clkgen-fsyn.c: In function ‘quadfs_set_rate’:
drivers/clk/st/clkgen-fsyn.c:793:6: warning: unused variable ‘i’ [-Wunused-variable]
  793 |  int i;
      |      ^

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/clk/st/clkgen-fsyn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index a156bd0c6af7..f1adc858b590 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -790,7 +790,6 @@ static int quadfs_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct st_clk_quadfs_fsynth *fs = to_quadfs_fsynth(hw);
 	struct stm_fs params;
 	long hwrate;
-	int uninitialized_var(i);
 
 	if (!rate || !parent_rate)
 		return -EINVAL;
-- 
2.25.1

