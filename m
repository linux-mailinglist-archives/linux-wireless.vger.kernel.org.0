Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877EE3ABA57
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhFQRP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQRP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 13:15:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0AC061760
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 10:13:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so1419361pji.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwrF+pnbkNf/qjoCdMQCOFlfbqT0rVKgXWLbQyXYamg=;
        b=P/WRkHUBfJdT59+t0H+g3ZYXtCV76z76WRyN1S196khpyBZkajbdGWnbVcz86fJgMt
         dWMpwlJJ/T8JnuQfAcZnc50FkBvJ9VhpPwk6d4eMM3mxiIlUNfFBFzXavq7NJLkRx41b
         GoiX8WP7XeMZbFcvKz6QNUqyHrqZo8ORWWZ4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwrF+pnbkNf/qjoCdMQCOFlfbqT0rVKgXWLbQyXYamg=;
        b=q5VEGPNgLrltJLHbuGcfj7nG8SsDxqF4QryHSbCNPhuo1O2PZrE22yXwpiy6Ifo7IN
         +0RogqcmX9BTIoW8FQfSWD9fX4GJrPZY4yd2G+Qxs98SFR4rUMZGxmmE53XHYV4nDCv6
         Qh0Svhsa6hYt/LioQeykgu7NsqWk9HAG/Py39G+uhvtkGpJC4EAxXDSlke9oGYhfhR8C
         wGw9JxfvuXZ+lPzjAQua7OO7KlIUQHTYF9qNG45EmW69ByYj9XzCBl+6xRwvMYUOKYmt
         wEtqwlepPykWFLyPU5LQbDP3cpb607jCTmE1XUFwHtoIAM5nQ/FY09/ti5xNtmn/WUm/
         w6xQ==
X-Gm-Message-State: AOAM5335eQ80vrqYMb1uCy4mYYJ6TtreMS3iE8LMthSxbEUGrfxbv4Sk
        OD5lQZmii672kFEDCFV4g1VEUQ==
X-Google-Smtp-Source: ABdhPJxw4pWvq9M9vSGmYbe4PQOcVW8uzQA2U2vP4ifPT9snrMW2XJ+40Gz+YfUBpaA9aacy/sSIzQ==
X-Received: by 2002:a17:90a:a607:: with SMTP id c7mr6485761pjq.199.1623949999827;
        Thu, 17 Jun 2021 10:13:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm2580236pjj.6.2021.06.17.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:13:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8192de: Fully initialize curvecount_val
Date:   Thu, 17 Jun 2021 10:13:17 -0700
Message-Id: <20210617171317.3410722-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=ad19d92695e58ee1a3610c1c93b1215aa0b454ab; i=8Mjgo7nwZa2B1T2pbFU78xkknAoUC7gygPgmoHcS04s=; m=Q+QcMAuMZQjhqnPxtv9+5wQ0q2weIg7NstC3dFeLQcw=; p=k6vO4+RMbTJEd7/3zKfAdx4+Y+A7g9G5Bir9iEa2vSY=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDLgqwACgkQiXL039xtwCaHwg//RkP 6Vu5YljWonyECSbJPtdj5WIHHyZq6nBqsa9wOtb1WPJVjyfJ/p3RI+y8fLo7SCMeDLaJ3bNDWrDf9 AacrqhLgalwDP/A3PcBviaAbGlsW8OdtW0LSU0sqOZ5Vv9fMUlS4rVxk5/YcfGkS8JzwB9q+gSRi0 MsrXYuOGDq9DsbpIntRHzKmgKZdgDULimtw/fQyrnL+tPslnKUX/KTYaZRZGuZaWcA+WrmCN+ERu5 XsKRaTnLNBpFubJRUfnnOgUixWks1Hd7Rr2SjgmoqQS1RXQ6tqAUx31EnJOwSijrGulXqiTiN8hA0 7BqKM8nk+XlzS0YthRAutxkrtTUuFGDez28JzvAOiDPs/S/U7lLiItSFZgp1ufk68tLIjaop3h2/W uQdA1lJh2A22I8q0+lWiUhMNnnEqhDJcquGCqAaJxuoVdaoCxOL/5er5jn+lPb8hi+DN0Syx1aA0Z EbHuoFS+77OcePhHe0qR6VFKVJeGsoJEmkjuNh//2nQwflUHabvYztHvEmgVtXYYPc8GWEFeI/mHR ADcHdxwVlRzSLo/TImkzQiu7YwvHbWibnQLSQkkMTJlz8/rUxkORUv3Pbc2ctYHqzUH1oyuExYqsD 4pzqWdAFQXQiYXDP7qzMb5SNCSgUyA6BCbU7YphrTitfep7zkuC2R78tCX5x/YLs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring array fields.

The size argument to memset() is bytes, but the array element size
of curvecount_val is u32, so "CV_CURVE_CNT * 2" was only 1/4th of the
contents of curvecount_val. Adjust memset() to wipe full buffer size.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index 68ec009ea157..76dd881ef9bb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2574,7 +2574,7 @@ static void _rtl92d_phy_lc_calibrate_sw(struct ieee80211_hw *hw, bool is2t)
 			RTPRINT(rtlpriv, FINIT, INIT_IQK,
 				"path-B / 2.4G LCK\n");
 		}
-		memset(&curvecount_val[0], 0, CV_CURVE_CNT * 2);
+		memset(curvecount_val, 0, sizeof(curvecount_val));
 		/* Set LC calibration off */
 		rtl_set_rfreg(hw, (enum radio_path)index, RF_CHNLBW,
 			      0x08000, 0x0);
-- 
2.25.1

