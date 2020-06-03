Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACB1ED941
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgFCXcf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgFCXc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 19:32:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286DDC008635
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 16:32:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so1370970plv.9
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AV3zPGZvUQ01fJNeRdN9RcESkWzhMr4mEDUODLN9pLA=;
        b=BLpfxw/6wXWpxKYLlCAZ21WRkm9IiS+h8QcGOpAouQszh1iMLWmw9T4KLc9TZj8hYc
         dx6tovtKtkGDVrQF1aoFfpozdX8eHpFDTKu0YVHCTw220bEnL7QHVusBdzlPQyI7mtxq
         CBiuNg7P/T3Joe2o1yRIOs+RMoUmvb0p/GaJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AV3zPGZvUQ01fJNeRdN9RcESkWzhMr4mEDUODLN9pLA=;
        b=c2G8cVbU7ednuipLmakqNcDYdwxBZ8W2abEc56CI3m/9L6oHSbRx6ZUKY/FtA9fmh3
         nHbVOnns/BvTt2VUn5yKawHomPT268dp9flv0VOFcKEENiCnpa4sDMEZoRyIV531FmJI
         FhNU0DgZcgU0DVgWDGnvrKqcKqIUfH73S9U8/8Q7PVbGPMy/B6c0oH2CCtxhwI9faFBz
         cNak13jAljMfJ5gwTFssMFJbzyVNBX4beUSyA4Nw1tVyc72QErV+ZJCvhqxks7/UfmNP
         OTwAWn6tJkXU+aBwaVva9mD1Do2XrDmQHFp1aKSr8eBOdQstJobkLCD//WCU3aGIEdaE
         IYtg==
X-Gm-Message-State: AOAM533xkiS0Sko8rki3B4j8C6KQ1BBzyDSyx75lupIJtsgkO88jr0t0
        UdvNz0rOXGRoNQQ3rB2a370UHg==
X-Google-Smtp-Source: ABdhPJwKQWXIp6h2GXr8CdJrjHWBz+VhwNoB6SucfRbGarsMlcrgSptDV/HFlzDMl3tG4M3PfRVvsQ==
X-Received: by 2002:a17:90a:36aa:: with SMTP id t39mr2389819pjb.185.1591227140733;
        Wed, 03 Jun 2020 16:32:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c123sm2738945pfb.102.2020.06.03.16.32.15
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
Subject: [PATCH 07/10] spi: davinci: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:32:00 -0700
Message-Id: <20200603233203.1695403-8-keescook@chromium.org>
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

drivers/spi/spi-davinci.c: In function ‘davinci_spi_bufs’:
drivers/spi/spi-davinci.c:579:11: warning: unused variable ‘rx_buf_count’ [-Wunused-variable]
  579 |  unsigned rx_buf_count;
      |           ^~~~~~~~~~~~

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/spi/spi-davinci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f71c497393a6..f50c0c79cbdf 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -576,7 +576,6 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	u32 errors = 0;
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
-	unsigned uninitialized_var(rx_buf_count);
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
-- 
2.25.1

