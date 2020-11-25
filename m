Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0C2C450B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgKYQZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 11:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbgKYQZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:38 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E03AC061A51
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 08:25:37 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id l7so2901042qkl.16
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8MW/chtXMDHQuBOgmTsYPh05am1GlhIQ+niX5dI50VM=;
        b=eFXlKdUKA/vjcLYDGy2YZypDYWN0dgy0Y6A4XyQsPrfX2awkMNy6GC8/qz5jXr/RbX
         4kqY5wdBcTbby7EUyLssjlseLlDvWoKqNKmiG+aWlJuXxI2wl766v2coEgAXLXjUe8zX
         hXiOK99HBJ5eZ86ZpKO3jfPctTPDEvs/A6A703q2lrIHr07lxW2FjZu/Vw7h8XC57xf7
         ddI9JaRsPJv8Cbq7LGVe3VJr7VELWBfEIpHoHbtbKnGQNv/jWnykRYWNU0fIE8+hRc9e
         jzby0pb9dy041+Iirv35fTN+OzEJUrfhUgAlJ1S9rOldcWisemLLaDBOuH8km1jO2DMj
         vFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8MW/chtXMDHQuBOgmTsYPh05am1GlhIQ+niX5dI50VM=;
        b=h0n6FtaSOXnumW2Rr9dI5PVh24tlYcRtE8xeBq12RzQkPketlFgIhSuh29Cuu/HuAT
         FFpM1dWqxiitWiP+i1yVy/8l1u2FC5MIVUtWrbdI0NBSUA6Fkyefer+GbB86nGLpY5fV
         2fZlJ0sYvJ/l5JKsf7qOchTUrmpiVXsRIPTggZYWGS3S6nccMGjSniJ2p6n5PZO3Gx8N
         BlyiJVUuFdzalVdnqmF8mSNWvJxjdTUPYralD1kY22EvkHXhQVoaLu4WNTQ8/6h1IZO4
         PQ8DJtbesehwLU7GnKX/6DlEBdeq+4ZyQMptCWbwV6Y12M+Mf+TJrTQUwGi5IxF0n+WT
         EeCA==
X-Gm-Message-State: AOAM533+Hb1ud00kSp8Js8QGh7Pa0we9nmg2UScai9rTbN/E3Bmewt5c
        /NeRgIWSlISWm1+k0TMMKombKGdX4Q==
X-Google-Smtp-Source: ABdhPJyWrXROveE+lnqlHl3GFcXbQJSvpc7FKf4l7NOn3ehvhx7hWLp+tK0+s/HDN4S905d6iVLYWcLHOw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:a802:: with SMTP id w2mr2490859qva.9.1606321536477;
 Wed, 25 Nov 2020 08:25:36 -0800 (PST)
Date:   Wed, 25 Nov 2020 17:24:54 +0100
In-Reply-To: <20201125162455.1690502-1-elver@google.com>
Message-Id: <20201125162455.1690502-3-elver@google.com>
Mime-Version: 1.0
References: <20201125162455.1690502-1-elver@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 2/3] net: store KCOV remote handle in sk_buff
From:   Marco Elver <elver@google.com>
To:     elver@google.com, davem@davemloft.net, kuba@kernel.org,
        johannes@sipsolutions.net
Cc:     akpm@linux-foundation.org, a.nogikh@gmail.com, edumazet@google.com,
        andreyknvl@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, idosch@idosch.org, fw@strlen.de,
        willemb@google.com, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aleksandr Nogikh <nogikh@google.com>

Remote KCOV coverage collection enables coverage-guided fuzzing of the
code that is not reachable during normal system call execution. It is
especially helpful for fuzzing networking subsystems, where it is
common to perform packet handling in separate work queues even for the
packets that originated directly from the user space. More details can
be found in Documentation/dev-tools/kcov.rst.

Enable coverage-guided frame injection by adding a kcov_handle
parameter to sk_buff structure. Initializate this field in __alloc_skb
to kcov_common_handle() so that no socket buffer that was generated
during a system call is missed. For sk_buffs that were allocated in an
interrupt context, kcov_handle will be initialized to 0.

Code that is of interest and that performs packet processing should be
annotated with kcov_remote_start()/kcov_remote_stop().

An alternative approach is to determine kcov_handle solely on the
basis of the device/interface that received the specific socket
buffer. However, in this case it would be impossible to distinguish
between packets that originated from normal background network
processes and those that were intentionally injected from the user
space.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v6:
* Revert usage of skb extensions in favour of directly storing the
  kcov_handle in in sk_buff.  skb extensions were leading to a memory
  leak as reported by Ido Schimmel:
  https://lore.kernel.org/linux-wireless/20201121160941.GA485907@shredder.lan/
---
 include/linux/skbuff.h | 21 +++++++++++++++++++++
 net/core/skbuff.c      |  1 +
 2 files changed, 22 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a828cf99c521..5639f27e05ef 100644
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
@@ -4605,5 +4610,21 @@ static inline void skb_reset_redirect(struct sk_buff *skb)
 #endif
 }
 
+static inline void skb_set_kcov_handle(struct sk_buff *skb, const u64 kcov_handle)
+{
+#ifdef CONFIG_KCOV
+	skb->kcov_handle = kcov_handle;
+#endif
+}
+
+static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
+{
+#ifdef CONFIG_KCOV
+	return skb->kcov_handle;
+#else
+	return 0;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1ba8f0163744..2f27635c3e97 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -233,6 +233,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	skb->end = skb->tail + size;
 	skb->mac_header = (typeof(skb->mac_header))~0U;
 	skb->transport_header = (typeof(skb->transport_header))~0U;
+	skb_set_kcov_handle(skb, kcov_common_handle());
 
 	/* make sure we initialize shinfo sequentially */
 	shinfo = skb_shinfo(skb);
-- 
2.29.2.454.gaff20da3a2-goog

