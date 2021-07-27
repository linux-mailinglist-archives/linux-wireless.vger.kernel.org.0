Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A33D7FC5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 22:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhG0U7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhG0U7F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F6DC0613C1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 13:59:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q2so1799085plr.11
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HpqGAKzdyVBA/Xfwi2YIWzNMC8MxbuJr9wu4OHi5PCI=;
        b=b9n3PLWe+yZgButmI22wyxu+eeyOUhPxCDUEfynBqPyMnsrnYQiVExI+J4v3rxE5/o
         G8J1IXNU0m0vNz/8YTkfJoaVZZj0wRBYaQuAJPoofDusamLFunZmfD45sWLn68LLU6JA
         BeETDRJ6OBfY6C94RhaCenx0bdi00zda2HbHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpqGAKzdyVBA/Xfwi2YIWzNMC8MxbuJr9wu4OHi5PCI=;
        b=p86XBSqfFjgK/GHPhvvpX0rArfWbxkoITLWEgeb0EE008SIiB5YFrgFpyQRJEf3iIE
         GKSAauW0O1cLM8KQ2sq/HuMxEmCIoevUHhm44s+9io+l+szX1N99cLL8anwrOn+x7DLh
         caKCjPw109gO/ybAHMoYfjYkqvMxoUPnOQizJaVx773nBAHiT5ucoajhamx3M0bDUWUv
         iQtblr65xTSHk1UFRwOftGqM65a+QHI6Jcq3ycvknhTBbpdW7L5g6MaT0jdbgJzp6nLY
         AxGl4YOLJVsu0QiII6eTOMChYIFSq3xjpXk+B/QE0Ht+z0JYFrpmldmMdg5LXAGPtLih
         FbWA==
X-Gm-Message-State: AOAM530r85M9w7QvA6uAHlNfd37AZ/URLYr/GAACIkb320c+pswtZcDW
        TrkiTP7v06SlIgVPo7iLxd4Zsw==
X-Google-Smtp-Source: ABdhPJwDSoBnYuvYRba1s+KLi8H28OXxuTeCqk1M8Bi6vVkOBrXn2p1i6DPX5y3V6fg7nYwJU2Ltsg==
X-Received: by 2002:a05:6a00:1391:b029:347:168f:1be7 with SMTP id t17-20020a056a001391b0290347168f1be7mr25305700pfg.70.1627419544638;
        Tue, 27 Jul 2021 13:59:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm547955pjq.13.2021.07.27.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 02/64] mac80211: Use flex-array for radiotap header bitmap
Date:   Tue, 27 Jul 2021 13:57:53 -0700
Message-Id: <20210727205855.411487-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3134; h=from:subject; bh=5kQsK42FaWrxRPo6tG17S0vU5dwTXkF5YJ2Hl+bjQYs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOASZA2wSHJdmV0oArAVWb1HVe/NAsbCB3ibAr6 bxRmCeCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzgAAKCRCJcvTf3G3AJucAD/ 9WI40Y8DsttY+40HaEXLlcd6Xryj8yJoVYK9d3gFpDvBSXYBI3VB3m525SOa2sCJC28jHTFRiHhMP6 huqw/nIdms4tjuS8pOZ+DGwzggPQcPgixq4hWdvWbXbeWvQ8mzb3g3NqUh7MCUUYaHd0XZHxeZEa68 KBhKJTR1IzAMdGAY+67PouIo4YzyBaBznnCQb+NLdIUlfT6t8W4CZN8+AQx4EbaO/u03il9VH+AfXK zdL7aZ+v+6RlA8EstG3CnlY/VnSeo0q9XrTH0Q56zymAeoXPIKieJGMZFa6iM2gjIrRUcDFGpVhu7C FZJrEnBqWU+ZIq8c+Zv+XxxBR1dgFsXNeW0wYvt3oXMHiOFT6xXQ9AnpctZU8KlMtct/hdjCaZw4oR 6asBqobuZZVyim88vDBe4PCm0P2lmf5t8CRqSL58iOkzZjRIH+nNwtC8icwiMHZbEOgdBWJYI4n844 m7nJHNp9t3NKdyBYEy6/4q2ExNfaSeCS36fcueGEcPaVGU6/xc4bbPtOCUCt/ocW7/1gVWfDLaGod7 erVQcNz7hMISnSKfJsI54OZh2ah7BqVzDbpCwCewNsGxodKlGatSWB6nfpU2DxvtQKgn0q2ExYIS5K sH5r2wLmmPf369ln2Cl1YKvhBYGnsOEMQkCSbYctGbRwD2e8tiHtSiSMTzJw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

The it_present member of struct ieee80211_radiotap_header is treated as a
flexible array (multiple u32s can be conditionally present). In order for
memcpy() to reason (or really, not reason) about the size of operations
against this struct, use of bytes beyond it_present need to be treated
as part of the flexible array. Add a union/struct to contain the new
"bitmap" member, for use with trailing presence bitmaps and arguments.

Additionally improve readability in the iterator code which walks
through the bitmaps and arguments.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/ieee80211_radiotap.h | 24 ++++++++++++++++++++----
 net/mac80211/rx.c                |  2 +-
 net/wireless/radiotap.c          |  5 ++---
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index c0854933e24f..101c1e961032 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -39,10 +39,26 @@ struct ieee80211_radiotap_header {
 	 */
 	__le16 it_len;
 
-	/**
-	 * @it_present: (first) present word
-	 */
-	__le32 it_present;
+	union {
+		/**
+		 * @it_present: (first) present word
+		 */
+		__le32 it_present;
+
+		struct {
+			/* The compiler makes it difficult to overlap
+			 * a flex-array with an existing singleton,
+			 * so we're forced to add an empty named
+			 * variable here.
+			 */
+			struct { } __unused;
+
+			/**
+			 * @bitmap: all presence bitmaps
+			 */
+			__le32 bitmap[];
+		};
+	};
 } __packed;
 
 /* version is always 0 */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2563473b5cf1..0d959a98e908 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -328,7 +328,7 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 
 	rthdr = skb_push(skb, rtap_len);
 	memset(rthdr, 0, rtap_len - rtap.len - rtap.pad);
-	it_present = &rthdr->it_present;
+	it_present = rthdr->bitmap;
 
 	/* radiotap header, set always present flags */
 	rthdr->it_len = cpu_to_le16(rtap_len);
diff --git a/net/wireless/radiotap.c b/net/wireless/radiotap.c
index 36f1b59a78bf..9f4f1a772964 100644
--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -115,10 +115,9 @@ int ieee80211_radiotap_iterator_init(
 	iterator->_max_length = get_unaligned_le16(&radiotap_header->it_len);
 	iterator->_arg_index = 0;
 	iterator->_bitmap_shifter = get_unaligned_le32(&radiotap_header->it_present);
-	iterator->_arg = (uint8_t *)radiotap_header + sizeof(*radiotap_header);
+	iterator->_arg = (uint8_t *)&radiotap_header->bitmap[1];
 	iterator->_reset_on_ext = 0;
-	iterator->_next_bitmap = &radiotap_header->it_present;
-	iterator->_next_bitmap++;
+	iterator->_next_bitmap = &radiotap_header->bitmap[1];
 	iterator->_vns = vns;
 	iterator->current_namespace = &radiotap_ns;
 	iterator->is_radiotap_ns = 1;
-- 
2.30.2

