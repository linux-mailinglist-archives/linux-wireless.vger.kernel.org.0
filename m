Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289213C3623
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhGJSkl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhGJSkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 14:40:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14FC0613DD
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 11:37:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p16so31216487lfc.5
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/d2UqXNEzZAyrtMEZJp6J9FVYgXAmwnZ3PIIDGxOnlY=;
        b=SenJyju6YE4p5XLCliWQg+/bYrDCqmOepa7gmiQhODtzhNSTgW4xnjjxSF4DKbndvb
         ruArUZ/hhVRU3DFmWzP4w5oBDkGM3TzAoA+vwNq5ETjxK2Sl6pHQh91B5pLXZzrTSo+t
         QEfWzg08zXQBLTdcKJMjYZNOjNvWu/FEgbHcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/d2UqXNEzZAyrtMEZJp6J9FVYgXAmwnZ3PIIDGxOnlY=;
        b=fXAuKLErgcM/D6T1w1Yq8AY7QFAoGPl+D9tDBpYF8F9Y/h7/bsjyE++CNv1eZWc+iB
         tZaymOnQj5a1m2JiUIjpIdHk1OiSk8ADK4KpGKOy9Q7Vhy5RvUkdeOWSMcAvFi+DfktC
         amBmDXaVsmegk+k8rcFsXECmpKl8SXfuoMRGI0W+b3EOEnqLBr74dl4fVR4DSgJhky70
         ju8S2zbW9Xncx7crHRnYk8fKpafehXGTjyL+uP1h3QOAERRSSBguf0JYsztAfKpGoYAw
         xspLfHfkpFVPIs2eHibnBF9gCa43BVo4bJ+ftsnXPTxAiXfFPpjc4P3it94WCuQdoouR
         PcqA==
X-Gm-Message-State: AOAM530PSwvQPomzbjphvLQ2GjeBxUJacDJyncN9xKYfNtsOwwWCMEJk
        +D1R1XrsalOs8NCLEs/UtjUOIg==
X-Google-Smtp-Source: ABdhPJyLw0rKoFAgWBuCgRfnzA18ELh1n9SjPeJM0h/l0u9HMYmTn8hO/1CdnqNJva3oBj3k9tORzw==
X-Received: by 2002:ac2:4c92:: with SMTP id d18mr7676525lfl.628.1625942273521;
        Sat, 10 Jul 2021 11:37:53 -0700 (PDT)
Received: from ubuntu.ciemini.majas.lan (balticom-135-235.balticom.lv. [83.99.135.235])
        by smtp.gmail.com with ESMTPSA id f1sm130914ljj.39.2021.07.10.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 11:37:53 -0700 (PDT)
From:   Davis Mosenkovs <davis@mosenkovs.lv>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, stable@vger.kernel.org,
        Davis Mosenkovs <davis@mosenkovs.lv>
Subject: [PATCH 4.9] mac80211: fix memory corruption in EAPOL handling
Date:   Sat, 10 Jul 2021 21:37:45 +0300
Message-Id: <20210710183745.5740-1-davis@mosenkovs.lv>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 5551cb1c68d4 ("mac80211: do not accept/forward invalid EAPOL
frames") uses skb_mac_header() before eth_type_trans() is called
leading to incorrect pointer, the pointer gets written to. This issue
has appeared during backporting to 4.4, 4.9 and 4.14.

Fixes: 5551cb1c68d4 ("mac80211: do not accept/forward invalid EAPOL frames")
Link: https://lore.kernel.org/r/CAHQn7pKcyC_jYmGyTcPCdk9xxATwW5QPNph=bsZV8d-HPwNsyA@mail.gmail.com
Cc: <stable@vger.kernel.org> # 4.9.x
Signed-off-by: Davis Mosenkovs <davis@mosenkovs.lv>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3a069cb188b7..b40e71a5d795 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2380,7 +2380,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 #endif
 
 	if (skb) {
-		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
+		struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 
 		/* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, dev);
-- 
2.25.1

