Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3298F3B5E20
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhF1Mjz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 08:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhF1Mjy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 08:39:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD342C061574
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 05:37:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id v20so11155466eji.10
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/trCErFqs5VU2Iwy3KnkqrXbDKP4vXx6DpOx/YSUUw=;
        b=oB19948EhQOYNy1PD9J13qa7W/wDT9AZ8gAJAuBkC3iLGTX8LXr+q8CEhsJxDljDQ8
         XXRFoLmSvnwIeilka1HoYk3PHZbcFkFYd9JeS/UcMhj9/xPiT/j35F8Q1Bf2gvlpw7pi
         b82fWcn2gwZjIxmtsRkN6RU7uTLbV2UMdBWJnOgDiw7v7hfFZo3Hi9wqTQsugswAK/pq
         jNrqfkwkWl5F7UsUDRcgJUHkBqyyKvYXoklWkGOvOlPkR8tnW/zzW/9TCwVCaG92HOUZ
         gN6KaQq/r23SPNGCdmrMIoAV8d+1uS0j0PS9qI4HlyNf5fiVnySv40ARiWgyzdgE67IB
         bp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/trCErFqs5VU2Iwy3KnkqrXbDKP4vXx6DpOx/YSUUw=;
        b=G5RlwrOGRbb+aRWT1XF39cOQhOWpmhBHoo/Jw0OA+Qhrmg13Lc2bxw3WzQqdtEBWPO
         snokJoV8L1QI4lpz2y5A33vB2L7B/5XE+XmwU5cEH06OsB+l+HNfClkULpZGQAd2qYz6
         gPvpvLe286RSVD98KE5szpDKiQB1WUF5O6nmXXkR8E7eZ+WagPVnmpfUB62i609yyeer
         FAHxROUq+EvBf9X6nK56f+Ux6hT1wft4N5eKgg4oQYa7OqAIYhfrFrxcXE8Ebd2J+SRR
         D5jfKteNGGgfYFkMXE/UXdMJX7fcLteYMJ/6v1E614hiu/yPcMOdJlC0oMYqLum7lVA9
         XAqw==
X-Gm-Message-State: AOAM530bLq0Q97oAQMYEDscwS/3P8Jq86bCl3TzUz2S/p/pVIgLGDk5e
        XFGhvke+19Pa7gZmIaBQvv0D4A==
X-Google-Smtp-Source: ABdhPJwZZq1G8zqfODWmsV0vvtrbKGEeZ28JbDQy/koUf8JqOLQUC7K7CRmSQslcLfkEXRP6pNh1fw==
X-Received: by 2002:a17:906:eda9:: with SMTP id sa9mr24606232ejb.501.1624883847533;
        Mon, 28 Jun 2021 05:37:27 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id j19sm4876240edr.64.2021.06.28.05.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:37:27 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH] mac80211: Do not strip skb headroom on monitor frames
Date:   Mon, 28 Jun 2021 14:37:13 +0200
Message-Id: <20210628123713.2070753-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a monitor interface is present together with other interfaces, a
received skb is copied and received on the monitor netdev. Before, the
copied skb was allocated with exactly the amount of space needed for
the radiotap header, resulting in an skb without any headroom at all
being received on the monitor netdev. With the introduction of eBPF
and XDP in the kernel, skbs may be processed by custom eBPF programs.
However, since the skb cannot be reallocated in the eBPF program, no
more data or headers can be pushed. The old code made sure the final
headroom was zero regardless of the value of NET_SKB_PAD, so increasing
that constant would have no effect.

Now we allocate monitor skb copies with a headroom of NET_SKB_PAD bytes
before the radiotap header. Monitor interfaces now behave in the same
way as other netdev interfaces that honor the NET_SKB_PAD constant.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 net/mac80211/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 771921c057e8..2563473b5cf1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -730,7 +730,8 @@ ieee80211_make_monitor_skb(struct ieee80211_local *local,
 		 * Need to make a copy and possibly remove radiotap header
 		 * and FCS from the original.
 		 */
-		skb = skb_copy_expand(*origskb, needed_headroom, 0, GFP_ATOMIC);
+		skb = skb_copy_expand(*origskb, needed_headroom + NET_SKB_PAD,
+				      0, GFP_ATOMIC);
 
 		if (!skb)
 			return NULL;
-- 
2.25.1

