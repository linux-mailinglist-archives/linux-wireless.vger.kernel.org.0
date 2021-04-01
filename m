Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2590B351864
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Apr 2021 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhDARpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Apr 2021 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhDARiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817E1C031152
        for <linux-wireless@vger.kernel.org>; Thu,  1 Apr 2021 09:46:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jy13so3865698ejc.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Apr 2021 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IegQPSAk9oXFRXPOMIzk5UhKPfT0chufZFUCPfQ5Ikg=;
        b=StKCmrhSP+pX054Ch5yGPgTvfNy10V3G2dl/UH983jHlql2LKdrw5WHKWLrjxDOF9p
         97mBATT+6eInLf7AKxVORLnPsfnfsh+hoefHHQp/KE6MIGNLenaMNFeNye/o0KWATA6w
         2im8udd0aB9Qlhb2EKHudPOy3+69Gu3xVza7StG9KRu2AVgE9N4tmHNglgWxYJsw/xw+
         q5lnZpT386KPXeZFH1sZwbXfNtR6ZarjSxGcAI4IxGOUg3A4diHzwQnttdFdH1TQoiqM
         pK1H7gkW8ngKDE8sw6Yvdkg7O1t/Nwdz8QFcGMdSkYvSlspy26ofV+NgXM+Df8I29XxG
         /V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IegQPSAk9oXFRXPOMIzk5UhKPfT0chufZFUCPfQ5Ikg=;
        b=NMKWA5yv0wQJOUukqfgsOfTCVBXNp0RrnQkA6l/LRUFAjjuA6+2YyB59XFAULpB3/Z
         fCZ9OpAJW6RyNB2JWCp0Kz5hDn78WwfXXRqGntBw1TMyNovO9HNaYm7o/p8ODIXTf37j
         5a+KDKz2uCNB2biMvMIRCuhs6Ccb8VoA8qR2IK4/mo/0trEfIgV5ltwWH00p/nBuW6jC
         bpbofrXle7oGGQQy9NppPYNJXkjE/g+CXbj8GEJfmt19Yw3Gg9Ub7log/0j+fDjfNZiC
         kHsZ8LWdG9UXc99fH5koKdT5Rl0Anz9cMui0GnkBRUNNeQN3HElYEkeuzyWYfc4Gxcsh
         2amg==
X-Gm-Message-State: AOAM531WKQhLI8k8BplIbylwKuz7VSLgflq5Ndn1jOKPQoJz/cJTujeo
        Aa6wju4KqL0gI4+sCPMzEYBdRQ==
X-Google-Smtp-Source: ABdhPJyX9sFjoRIFEqUfHvfvUBdnAVzvWz7HT189amWnbM5kx11wuiuSFOSxUaYTCoAXBMkyBS2M6w==
X-Received: by 2002:a17:906:f953:: with SMTP id ld19mr9695049ejb.164.1617295600276;
        Thu, 01 Apr 2021 09:46:40 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id hy13sm2973116ejc.32.2021.04.01.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:46:39 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     johannes@sipsolutions.net
Cc:     Mathy.Vanhoef@kuleuven.be, fredrik.olofsson@anyfinetworks.com,
        linux-wireless@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH] mac80211: Set priority and queue mapping for injected frames
Date:   Thu,  1 Apr 2021 18:44:55 +0200
Message-Id: <20210401164455.978245-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some drivers, for example mt76, use the skb priority field, and
expects that to be consistent with the skb queue mapping. On some
frame injection code paths that was not true, and it broke frame
injection. Now the skb queue mapping is set according to the skb
priority value when the frame is injected. The skb priority value
is also derived from the frame data for all frame types, as it
was done prior to dbd50a851c50bb95e457 (only allocate one queue
when using iTXQs). Fixes frame injection with the mt76 driver on
MT7610E chipset.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 net/mac80211/tx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 5d06de61047a..3b0ac4952cdf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2267,17 +2267,6 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 						    payload[7]);
 	}
 
-	/* Initialize skb->priority for QoS frames. If the DONT_REORDER flag
-	 * is set, stick to the default value for skb->priority to assure
-	 * frames injected with this flag are not reordered relative to each
-	 * other.
-	 */
-	if (ieee80211_is_data_qos(hdr->frame_control) &&
-	    !(info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER)) {
-		u8 *p = ieee80211_get_qos_ctl(hdr);
-		skb->priority = *p & IEEE80211_QOS_CTL_TAG1D_MASK;
-	}
-
 	rcu_read_lock();
 
 	/*
@@ -2341,6 +2330,15 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 
 	info->band = chandef->chan->band;
 
+	/* Initialize skb->priority according to frame type and TID class,
+	 * with respect to the sub interface that the frame will actually
+	 * be transmitted on. If the DONT_REORDER flag is set, the original
+	 * skb-priority is preserved to assure frames injected with this
+	 * flag are not reordered relative to each other.
+	 */
+	ieee80211_select_queue_80211(sdata, skb, hdr);
+	skb_set_queue_mapping(skb, ieee80211_ac_from_tid(skb->priority));
+
 	/* remove the injection radiotap header */
 	skb_pull(skb, len_rthdr);
 
-- 
2.25.1

