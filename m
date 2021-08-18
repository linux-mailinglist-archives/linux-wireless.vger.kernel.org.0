Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BB3EFC2A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 08:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhHRGTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 02:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbhHRGPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 02:15:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2EC0363ED
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:14:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e15so1134191plh.8
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0i1or1K/1dFEzNVxMTz6RhSxVOT4OJeaz+0eeqAwhFA=;
        b=Oe49+j/0UXJ7D4hLbrrauzW6DPsuwO4bSYSpu3MHYIR3JnaLRxc45VZexykTP0KNTs
         TmDL4PviB0QbN/Io75LJ7Tfje5mipp/v9WFQqOm9o9gyYM1cBdhUbgEaldWedaWT60xS
         qb7hM0nBEEpQtMj92w3cx9+esvngBsY/a4Otg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0i1or1K/1dFEzNVxMTz6RhSxVOT4OJeaz+0eeqAwhFA=;
        b=PwRpeWddOgdBcshrBte4NjZ1nzWwK3LQdtrq3ZbMKm5xwKGgf1CWycfOg9Jh4NpcLr
         stLFpDeJHdjvQicXhfuxLLiMoYbqSOBTM6zJvqpy9oINTrHeksLDI03bQb1A1+k4ex8a
         Z3uKGGpG8q2BbHRIU6KBDOYIfQYZcqaqIykh0X6isLbFJaCAgsRlakVG3+IvsaOWOGBx
         CyjgZrNIQk3Ici0pBuKeeurXhVXbiMR9lP06apfM6M+YwknBM/Kizvx8k0U/81ivv505
         y11SLBR8QnMvPLnvblqoVgnEd/pJkDQ9PqXAePDzx/2jOavBEeDIei8h2eTI6iECa8AK
         tUMw==
X-Gm-Message-State: AOAM533sNYWjah8tZrUMVPtqG8hiRMHufv5HLJZCOKQZ7XlYpXPpMYzm
        D1GbcP1/shUg6qf0eOaSpQt4QA==
X-Google-Smtp-Source: ABdhPJywwox1i7+sQwgOh5pOCbo+BOlEsPJIaFcHvRCzFKyYrKK09UqZit7+ggVQZGAHkMaYk9KLlg==
X-Received: by 2002:a17:90a:17cc:: with SMTP id q70mr7609797pja.1.1629267256623;
        Tue, 17 Aug 2021 23:14:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h17sm4603571pfh.192.2021.08.17.23.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:14:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Jes Sorensen <jes@trained-monkey.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-hippi@sunsite.dk,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 41/63] net: 802: Use memset_startat() to clear struct fields
Date:   Tue, 17 Aug 2021 23:05:11 -0700
Message-Id: <20210818060533.3569517-42-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; h=from:subject; bh=C+6KD7t/6fG5hDgRQb4fosYJ4WHPortotbK235WcI2o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMn5oDen6ROCRtoOkoprqxOZyis1cM1QgeAkzRs Z+Yu9WKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjJwAKCRCJcvTf3G3AJoehD/ 9r6K6SUsL5lVEdFegLY8K/qjemzJ8Qx2dDCwnIGOnbcI770wVd2gUkq+8bMIiGTpuHm8KLfXED/VPo XEYrAiSzdYDynkSQ5uT93DAcDJecWMvkl5cUZenRJ9e335MwzPk46WbpMY5lsvDG4LBrEYQUe3GB15 fZ8nYwjw5Q+FqdH31kVwt/2NSANrGxWmVtnNghwDYLKm0CqhmEc4kK70cmiOpl45EDBUWHjcVcHhtk +PEcSI8yUja1AxKpyhVTXYsFHlVN/kEk65BL8+8npbvCk63MR9WStzKhTbrb23jLFEg5yu8WATqERe o8xICyKNkMqYX8hCFs5pnjdeEKWUc2/FYepf6KI7RGfKkvKyE2n/BKKsZFKeZ181uCBiO/JcP0Pipn OHApybTpw2p4YCgPfp4IRYVXIyQaygaAotgvJzqZQbLI8E7vsFhH+rcgXzUijzLTAFpUblDhEwLI6b cBzYe+DkWVZ6Glc4eJvXZCjr/W7SxC+nlNR+56QP4XtDM7sC1Yi5QeYqjWqQLKsSmiJ1twc3nx9dtJ qai0woqnGDGFUMcP9v95DEMFbrsh44dGCjOIVocZ3STFgPzYzmTzvVvmCwlMPH+NaZaZZI/NgHQYpw aSEEIjABnuJlCZR3/gTlppRk49XP0ANcu3hytZpYQh0SZTdqnExuxHJTAJ6g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Cc: Jes Sorensen <jes@trained-monkey.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hippi@sunsite.dk
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/802/hippi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/802/hippi.c b/net/802/hippi.c
index f80b33a8f7e0..6f71ffc8bdd1 100644
--- a/net/802/hippi.c
+++ b/net/802/hippi.c
@@ -65,7 +65,7 @@ static int hippi_header(struct sk_buff *skb, struct net_device *dev,
 	hip->le.src_addr_type	= 2;	/* 12 bit SC address */
 
 	memcpy(hip->le.src_switch_addr, dev->dev_addr + 3, 3);
-	memset(&hip->le.reserved, 0, 16);
+	memset_startat(&hip->le, 0, reserved);
 
 	hip->snap.dsap		= HIPPI_EXTENDED_SAP;
 	hip->snap.ssap		= HIPPI_EXTENDED_SAP;
-- 
2.30.2

