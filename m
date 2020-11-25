Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F542C46E0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 18:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgKYRev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 12:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgKYRev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 12:34:51 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C415C061A51
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 09:34:51 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id cu18so2977886qvb.17
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=K7k20R0lnhz68i2HIZxX0s22aPKx+LMM7GFJ9tvlIjc=;
        b=vdR9GifL3hQTkcfJ1FFE918sa3YXXR6ooyED/fdgmlWBC7ugf8qUyt0myBTMWvtBGH
         uztf9VdHFsQ0r8V+hTwQ+Kr24RmVCMZvBf2RhpI8NpxUjFXYurG8jDkG4hi5v0TQrw3r
         kWU197AsXlVUEz+u+9yZqSCJnomy6vOY2iwAdTeQxf5la2wEbw299JckjbMJwOsUf8ZH
         qKYbwZ+D4j4XjrUR5hvUM6XDqHJPUjSTlwAMIEpTZYaJbwA3h9tE7czB2mOQbs30L3tN
         rCinW5dYyTTMxgHmxvOH9ikXvIhY3Ryugb4At8R7GVh9DE4KwV06S5Tjv8qQ6haezxdu
         0JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=K7k20R0lnhz68i2HIZxX0s22aPKx+LMM7GFJ9tvlIjc=;
        b=KnfOHF97tK1avNhflX1EjFv8MSzc9344V0vwfRqmY8xByaZdrufXFp/D+accX6pKRd
         saYDwQl/Z+Gd9oSUBvFzV15rBQErbIOp7KBlz30Px4kf6dRZjE10PLZR6EZvZLDD0HX+
         4C6rSvhD3iYMCBlu2rWPeI10hRHuyvB0ziwAy8UDAMMwAaX6U6XdXmqVEk5+OF2fEnqv
         e/onrB1u3EecqJ6GDBaf798H+iwbzN9cyvTNCELMMF9fAZjPGTFWwh1JbUTixL6DNSSr
         eCdcI7Xtm/RDK5wA8Ft0oqYZYHbcfExft3Rf9VynZFYVJyw9bQ3yYDCiYZCKgd0xJPgM
         t5rA==
X-Gm-Message-State: AOAM531bcERR7lI85fagxvig6Z75r5611y0Mv8ZyfmMoiHQtJS1rJGac
        HxPDs+cx9OITUmoD/HNl7n9S9ja+Zw==
X-Google-Smtp-Source: ABdhPJy2FeQNFhtN4W83T3gNPR88Jl1wwy7z0LkxjggKG27FXx85OpSWy+xm1c455Nx/l9V3TW8tktq6tg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:fa4f:: with SMTP id k15mr4267615qvo.62.1606325689848;
 Wed, 25 Nov 2020 09:34:49 -0800 (PST)
Date:   Wed, 25 Nov 2020 18:34:36 +0100
Message-Id: <20201125173436.1894624-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH net-next] net: switch to storing KCOV handle directly in sk_buff
From:   Marco Elver <elver@google.com>
To:     elver@google.com, kuba@kernel.org, davem@davemloft.net
Cc:     johannes@sipsolutions.net, a.nogikh@gmail.com,
        andreyknvl@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, idosch@idosch.org, fw@strlen.de,
        willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It turns out that usage of skb extensions can cause memory leaks. Ido
Schimmel reported: "[...] there are instances that blindly overwrite
'skb->extensions' by invoking skb_copy_header() after __alloc_skb()."

Therefore, give up on using skb extensions for KCOV handle, and instead
directly store kcov_handle in sk_buff.

Fixes: 6370cc3bbd8a ("net: add kcov handle to skb extensions")
Fixes: 85ce50d337d1 ("net: kcov: don't select SKB_EXTENSIONS when there is no NET")
Fixes: 97f53a08cba1 ("net: linux/skbuff.h: combine SKB_EXTENSIONS + KCOV handling")
Link: https://lore.kernel.org/linux-wireless/20201121160941.GA485907@shredder.lan/
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/skbuff.h | 37 +++++++++++++------------------------
 lib/Kconfig.debug      |  1 -
 net/core/skbuff.c      | 12 +-----------
 3 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0a1239819fd2..333bcdc39635 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -701,6 +701,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@transport_header: Transport layer header
  *	@network_header: Network layer header
  *	@mac_header: Link layer header
+ *	@kcov_handle: KCOV remote handle for remote coverage collection
  *	@tail: Tail pointer
  *	@end: End pointer
  *	@head: Head of buffer
@@ -904,6 +905,10 @@ struct sk_buff {
 	__u16			network_header;
 	__u16			mac_header;
 
+#ifdef CONFIG_KCOV
+	u64			kcov_handle;
+#endif
+
 	/* private: */
 	__u32			headers_end[0];
 	/* public: */
@@ -4150,9 +4155,6 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MPTCP)
 	SKB_EXT_MPTCP,
-#endif
-#if IS_ENABLED(CONFIG_KCOV)
-	SKB_EXT_KCOV_HANDLE,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
@@ -4608,35 +4610,22 @@ static inline void skb_reset_redirect(struct sk_buff *skb)
 #endif
 }
 
-#if IS_ENABLED(CONFIG_KCOV) && IS_ENABLED(CONFIG_SKB_EXTENSIONS)
 static inline void skb_set_kcov_handle(struct sk_buff *skb,
 				       const u64 kcov_handle)
 {
-	/* Do not allocate skb extensions only to set kcov_handle to zero
-	 * (as it is zero by default). However, if the extensions are
-	 * already allocated, update kcov_handle anyway since
-	 * skb_set_kcov_handle can be called to zero a previously set
-	 * value.
-	 */
-	if (skb_has_extensions(skb) || kcov_handle) {
-		u64 *kcov_handle_ptr = skb_ext_add(skb, SKB_EXT_KCOV_HANDLE);
-
-		if (kcov_handle_ptr)
-			*kcov_handle_ptr = kcov_handle;
-	}
+#ifdef CONFIG_KCOV
+	skb->kcov_handle = kcov_handle;
+#endif
 }
 
 static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
 {
-	u64 *kcov_handle = skb_ext_find(skb, SKB_EXT_KCOV_HANDLE);
-
-	return kcov_handle ? *kcov_handle : 0;
-}
+#ifdef CONFIG_KCOV
+	return skb->kcov_handle;
 #else
-static inline void skb_set_kcov_handle(struct sk_buff *skb,
-				       const u64 kcov_handle) { }
-static inline u64 skb_get_kcov_handle(struct sk_buff *skb) { return 0; }
-#endif /* CONFIG_KCOV && CONFIG_SKB_EXTENSIONS */
+	return 0;
+#endif
+}
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 826a205ffd1c..1d15cdaf1b89 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1879,7 +1879,6 @@ config KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
-	select SKB_EXTENSIONS if NET
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ffe3dcc0ebea..070b1077d976 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -233,6 +233,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	skb->end = skb->tail + size;
 	skb->mac_header = (typeof(skb->mac_header))~0U;
 	skb->transport_header = (typeof(skb->transport_header))~0U;
+	skb_set_kcov_handle(skb, kcov_common_handle());
 
 	/* make sure we initialize shinfo sequentially */
 	shinfo = skb_shinfo(skb);
@@ -249,9 +250,6 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 
 		fclones->skb2.fclone = SKB_FCLONE_CLONE;
 	}
-
-	skb_set_kcov_handle(skb, kcov_common_handle());
-
 out:
 	return skb;
 nodata:
@@ -285,8 +283,6 @@ static struct sk_buff *__build_skb_around(struct sk_buff *skb,
 	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
 	atomic_set(&shinfo->dataref, 1);
 
-	skb_set_kcov_handle(skb, kcov_common_handle());
-
 	return skb;
 }
 
@@ -4208,9 +4204,6 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MPTCP)
 	[SKB_EXT_MPTCP] = SKB_EXT_CHUNKSIZEOF(struct mptcp_ext),
 #endif
-#if IS_ENABLED(CONFIG_KCOV)
-	[SKB_EXT_KCOV_HANDLE] = SKB_EXT_CHUNKSIZEOF(u64),
-#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
@@ -4227,9 +4220,6 @@ static __always_inline unsigned int skb_ext_total_length(void)
 #endif
 #if IS_ENABLED(CONFIG_MPTCP)
 		skb_ext_type_len[SKB_EXT_MPTCP] +
-#endif
-#if IS_ENABLED(CONFIG_KCOV)
-		skb_ext_type_len[SKB_EXT_KCOV_HANDLE] +
 #endif
 		0;
 }

base-commit: 470dfd808ac4135f313967f9d3e107b87fc6a0b3
-- 
2.29.2.454.gaff20da3a2-goog

