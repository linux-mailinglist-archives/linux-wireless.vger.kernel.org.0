Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20723C3620
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhGJSkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhGJSkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 14:40:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FEC0613E5
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 11:37:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p16so31215204lfc.5
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbjLAPuy/4CQacoiTnOvqyxNeqOeWAbO6F6kFUZ/Sck=;
        b=kPTkJ30AQH8zNSCnBdAPAYsuUn15xM5pi413Bj4jeYd6kvPnPiCaeofJeE+rmTHOww
         iS2x4rNUolut0Zlz1vEVhLz6AcmLJs91OPOguQQGK/UMeiwzHndKqWwf+jbS2x/4yTtv
         ZKbyG3wVcny31W3NT9/RC/gr/K52+isuVCWVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbjLAPuy/4CQacoiTnOvqyxNeqOeWAbO6F6kFUZ/Sck=;
        b=l8/N8XX1DG/yhPrYVXWAVzee5eWOFk+ZrpkJkr+pMvCAQfunUELacSN3RDtxmhpf1G
         lyDZwJXc8iFNXqw0mJZzU4uLoEnROWFysRK0gCrVIwLwUFi5KyBz7oDB36DtrD98Y1Vg
         3TsDVSfE1vmAQsE7xFGCzBSPY7i2qpAmzrlBkV3kktCSx3+962g90eEDgH1VB9uoicqH
         /MDSwL5yIrjBQdZZuSUnOdTLAbO5LIChDnTEnW3cRXjUhiciJJak481W/0yTz6UpOyDZ
         PFYY9+2RLmn9OY/kiy6oj7TbrUJAqTfJc4mOj2mIg1Ch9DKy/wz8s/M/BUt5BgUGhC4u
         inQg==
X-Gm-Message-State: AOAM531bq+8/V77ie99HHsICmddmWkRQTJIy61s7tiftdF+aZ0B9Jmt9
        LIAuB2RH5uyXlhbYsUtQMYJMPiiMlALkhg==
X-Google-Smtp-Source: ABdhPJzWxZ+9SS3gKVip+Gfv+uNlEpo6CKHb2TP/kzqedU2xAAU3lWTKtt2igse0aSsSfvGyHLZ/yQ==
X-Received: by 2002:ac2:4118:: with SMTP id b24mr32893258lfi.643.1625942256754;
        Sat, 10 Jul 2021 11:37:36 -0700 (PDT)
Received: from ubuntu.ciemini.majas.lan (balticom-135-235.balticom.lv. [83.99.135.235])
        by smtp.gmail.com with ESMTPSA id 139sm973980ljf.125.2021.07.10.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 11:37:36 -0700 (PDT)
From:   Davis Mosenkovs <davis@mosenkovs.lv>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, stable@vger.kernel.org,
        Davis Mosenkovs <davis@mosenkovs.lv>
Subject: [PATCH 4.4] mac80211: fix memory corruption in EAPOL handling
Date:   Sat, 10 Jul 2021 21:37:10 +0300
Message-Id: <20210710183710.5687-1-davis@mosenkovs.lv>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit e3d4030498c3 ("mac80211: do not accept/forward invalid EAPOL
frames") uses skb_mac_header() before eth_type_trans() is called
leading to incorrect pointer, the pointer gets written to. This issue
has appeared during backporting to 4.4, 4.9 and 4.14.

Fixes: e3d4030498c3 ("mac80211: do not accept/forward invalid EAPOL frames")
Link: https://lore.kernel.org/r/CAHQn7pKcyC_jYmGyTcPCdk9xxATwW5QPNph=bsZV8d-HPwNsyA@mail.gmail.com
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Davis Mosenkovs <davis@mosenkovs.lv>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bde924968cd2..b5848bcc09eb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2234,7 +2234,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 #endif
 
 	if (skb) {
-		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
+		struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 
 		/* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, dev);
-- 
2.25.1

