Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD373C3625
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGJSlB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhGJSlB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 14:41:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29026C0613DD
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 11:38:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b40so14385618ljf.12
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIJv2deqhOMpOnP04N17ikHc3lWENGrZFchXndtdyJ4=;
        b=SSFInKfE8pQCBXT4LJFKvlEqplepLSNjo0WUysDiXvurJFca5QccTeF/4oAGpC0uUH
         F+ncze4HV3HfJBmfbWn5I+PGhSA2wxdIdy253eLArLU7jR4DS6dqI6BYcc6Uqxur0HDp
         9NKCjpVxT56Xz3lQugX7lWVcFz1kOW7w9uc2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIJv2deqhOMpOnP04N17ikHc3lWENGrZFchXndtdyJ4=;
        b=EbzsHjQKjYmYdfLwufdBOGvoA90Ifl3MpLINKv7O98gaeVsbCpw3XrEvi4aHDGbK6m
         4dd5mi4MJHdtUaWGIL1yOKJEfOQcgbU3SElgnmgTpnoLEd0v6HvTUT/Lphcp//9Fnoe1
         G8ksqV/4ZngeCyOcZklZkAFX8CK4h31zOlPb1joZlZ5pZ38/UsC+e4Selh29zDx8EalZ
         ncrwDnatWcgO7oIT/HMZv1UpHsfKO1RIqWZ8map22+0FoKeTa9sG2mP0/Q/VtlbRPz7M
         iwKUlfU3bh89SW85On+uzpop95b76WDryQByLAx+t7sYmsgonLndAA2P9M2RZDqyY0Zt
         sQvA==
X-Gm-Message-State: AOAM531us9/1Hz+Gwrt4CAbn2pT1Orp22gtcPZ7kfItOxbayKtSWAdmh
        kvtsJZQURxP+vGam+kK4r7OjGA==
X-Google-Smtp-Source: ABdhPJxV1jEs6WYYOOMSw381R0XJ01l7QPKwJpwLabzHhSvl8tgWkMotaQl8+c2dZ5Qlb85VrzPm0w==
X-Received: by 2002:a05:651c:1ac:: with SMTP id c12mr20569765ljn.179.1625942293578;
        Sat, 10 Jul 2021 11:38:13 -0700 (PDT)
Received: from ubuntu.ciemini.majas.lan (balticom-135-235.balticom.lv. [83.99.135.235])
        by smtp.gmail.com with ESMTPSA id n9sm763814lfu.49.2021.07.10.11.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 11:38:13 -0700 (PDT)
From:   Davis Mosenkovs <davis@mosenkovs.lv>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, stable@vger.kernel.org,
        Davis Mosenkovs <davis@mosenkovs.lv>
Subject: [PATCH 4.14] mac80211: fix memory corruption in EAPOL handling
Date:   Sat, 10 Jul 2021 21:38:07 +0300
Message-Id: <20210710183807.5792-1-davis@mosenkovs.lv>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 557bb37533a3 ("mac80211: do not accept/forward invalid EAPOL
frames") uses skb_mac_header() before eth_type_trans() is called
leading to incorrect pointer, the pointer gets written to. This issue
has appeared during backporting to 4.4, 4.9 and 4.14.

Fixes: 557bb37533a3 ("mac80211: do not accept/forward invalid EAPOL frames")
Link: https://lore.kernel.org/r/CAHQn7pKcyC_jYmGyTcPCdk9xxATwW5QPNph=bsZV8d-HPwNsyA@mail.gmail.com
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Davis Mosenkovs <davis@mosenkovs.lv>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ac2c52709e1c..87926c6fe0bf 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2404,7 +2404,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 #endif
 
 	if (skb) {
-		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
+		struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 
 		/* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, dev);
-- 
2.25.1

