Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795F3F219B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhHSU3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhHSU3H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 16:29:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F85C061575
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 13:28:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so6990085pgf.5
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AY970ncUJAZ3XFO8vIsQqriyIPN/r8JHpDac7fWieeM=;
        b=JiOahg/ViaSpfKrqajDr+bPpqkkEMMCWmqS0witZ52yCvG4QyGsLrR3/8WxzDtCmSC
         atLuuIlKBtncWTHLnU6dYw3k06uNjVq5FIUqXbeTbRD2/VMkRX+jusQN97pMMp3igHfu
         mjXawcyOL9Dj3+dwR+llvL4Y10vH+ykAj1szs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AY970ncUJAZ3XFO8vIsQqriyIPN/r8JHpDac7fWieeM=;
        b=ID1C7BcC9GN6f6pLETjay2EtMsbnrBLwCVHAISt7GSHApMUi+7t5mJzIBetB+z3bGl
         GHF1tZ+NyqZO2R5N8zwsEaVviJt8UOr2EHS/kCtneuH09QEF8T8ylc3Vn+uCDanl/4eh
         tvpoVOZR0bmAeMWYX9QGwBq/hVsaPObDlT1ipgF1Du93Ljopxzy3Ajwh+qEhoho30w7+
         GuTk0UPfmTzE+Zce/Sht8mkfzOgoEFjFi7VoOvv6CKSX4B6TltX8iqEoHfbhNyGHRF2t
         Y6AmV2Ih873joo8e6wdV6MZ+VttWRG+k/FYarnKP4pJKyJ66wrYm3eGfZ2fz2OqNfOS0
         zsJw==
X-Gm-Message-State: AOAM530bL0oYiHrCwqXbPXHx2OaFwyaBcmQwliLjHSweJdp+s5frx1vo
        qZeer31pMoIMh+lvAHwU2ktfNw==
X-Google-Smtp-Source: ABdhPJwjCCBMHmC0qQ12oG7q1UHwdleaKPunhS+7aNFDWE0hCV8jZut4eNWP2lM4oZLxr864oa3cbg==
X-Received: by 2002:aa7:8f14:0:b0:3e1:3bdf:e4d3 with SMTP id x20-20020aa78f14000000b003e13bdfe4d3mr16062461pfr.39.1629404910503;
        Thu, 19 Aug 2021 13:28:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm4175490pfu.109.2021.08.19.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:28:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     netdev@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] pcmcia: ray_cs: Split memcpy() to avoid bounds check warning
Date:   Thu, 19 Aug 2021 13:28:25 -0700
Message-Id: <20210819202825.3545692-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819202825.3545692-1-keescook@chromium.org>
References: <20210819202825.3545692-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; h=from:subject; bh=MoN9sZmmdDw0lR5vW36Fdr39zzqTtcOilmLJ144gA30=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHr7peJZHHO3+hbAJbiz+YaA05/E7kfaAlhhB+qwX bgM8lUWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR6+6QAKCRCJcvTf3G3AJi9QD/ 0QaLkaLVu3CB4Vqu8bN+qfuYpSMm6PxxQE8R5z6qCSKxIky/DHNca51HSawGz9H4bITJ1lu1VIFFif d87Or2FO7mpgrMwleO6RsmJmhInSfipAHOogtwZxSNikyS9XRH0fSg+OUaRARtx/6Ke9I154y7CFZP Vpzk6Pdr0D1A5uXYPZDlLMR1NmhL1MRXCJUA9GYr0ubFTwlJbMeljLfa/x+fIKXfrUSnzgh87ozL0m 0tTs7s9OmQFme/7kQp0B/aCtCybQjQixIGw7o04juRL026PYmJVzL0ddvl3Dp0yYNcuyQwgzyQ/wif aE8vrB4oIVXoTbXEeXhX+4XRUQOH/Fnfgx/a+ZsGaicm2kSqhAP0m9U9gcuTaR0y8HsP+OudoSTYog qRdqqAjhMVSi5erX8V9CyDYxEAfUAcbOuVHUFVDaU03Yt5rRjfN1BO+7trWH000k2Lvb39wNz2LN+W BgOuuAoHVIahN3VYvlNXNrTvx2H/r35t1a3SDaKWcTegKdEW+3DvaGtcTsxOD1AOVrADJwDhiMMXt4 P3RdipOMARGalw0WLktYJF5w8DuvrKyH+SkC3AbjVf391u2ttjtbUn6KZzotbvoUWrci7LyXxxytjl I/of6t8C9xadVL3opjJZc0cLYsYbkxo0UlHk4gs3tOZmnXPux7dx+r7yDVag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Split memcpy() for each address range to help memcpy() correctly reason
about the bounds checking. Avoids the future warning:

In function 'fortify_memcpy_chk',
    inlined from 'memcpy_toio' at ./include/asm-generic/io.h:1204:2,
    inlined from 'ray_build_header.constprop' at drivers/net/wireless/ray_cs.c:984:3:
./include/linux/fortify-string.h:285:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  285 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ray_cs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 590bd974d94f..d57bbe551630 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -982,7 +982,9 @@ AP to AP	1	1	dest AP		src AP		dest	source
 	if (local->net_type == ADHOC) {
 		writeb(0, &ptx->mac.frame_ctl_2);
 		memcpy_toio(ptx->mac.addr_1, ((struct ethhdr *)data)->h_dest,
-			    2 * ADDRLEN);
+			    ADDRLEN);
+		memcpy_toio(ptx->mac.addr_2, ((struct ethhdr *)data)->h_source,
+			    ADDRLEN);
 		memcpy_toio(ptx->mac.addr_3, local->bss_id, ADDRLEN);
 	} else { /* infrastructure */
 
-- 
2.30.2

