Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F483BF172
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jul 2021 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhGGVlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jul 2021 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGGVlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jul 2021 17:41:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B714C061574
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jul 2021 14:38:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p16so8126967lfc.5
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jul 2021 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4mz/Ib9W6zQh/e/sTU1bjqMZRpzyHCfefdc3duozuE=;
        b=JLgxKI+tXas0LmZoyQ56u7DTmReTKWFO0e96YN3rIepuSZvuQbm5Dqeq1Q2cRDJ2sD
         +sIeJCxgspu2GFDfzyMtsacYUzhLz1TGQ+Ybjcxdd6cGrydJvXYy2CvpDKtixVczgqOS
         /dqDv0Uue7EfhINKqaXl42bCS/gynZ9XnqxC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4mz/Ib9W6zQh/e/sTU1bjqMZRpzyHCfefdc3duozuE=;
        b=H2JZK3uSa7iSOlbTvsVtYGsroCQaBQ3ZinpNgXoZHcptn1mmBxFV/0OuS+Kw4DY/wh
         dVDe2cAZMmDHSevLjO45mvvSH45R8314tuunFKTfNGNTn1iGVa+ykSDDmwdb4ycsu9fH
         IBeWn52l4bSti4AmvuaP6sgZ6ZoPVg5BGznXqshOb1JXG3M/B6x3Nj/R51S6YENGnWq2
         IhaBNkzn/pOekpgcRtyQCENB3Fgl8G00tEKJHFXoGmHNIGYt/cZyPrtR7nFdalAf7m9P
         +hvNrnrHWyEgSgT4xa/dvHxNa+1adMSsx9Oqfy7wA3GEqJCBmYZw14e9uEpEKwU4w+fU
         G3Zg==
X-Gm-Message-State: AOAM5332EL2CzhJgsPuavlK6K2WHVXQpm2r1jingtM7ia4wwuNBd6rhW
        T8Kxhe6gLcwQeoZ2zPGzEQeK3A==
X-Google-Smtp-Source: ABdhPJz/tXbAyDWIcG9MvXf3f6ASC05CixBt2qf14ASgaygF9RH9/DWFLu7nGxLjjAbeF/nf+q5xgw==
X-Received: by 2002:ac2:5203:: with SMTP id a3mr21618043lfl.115.1625693919044;
        Wed, 07 Jul 2021 14:38:39 -0700 (PDT)
Received: from ubuntu.ciemini.majas.lan (balticom-135-235.balticom.lv. [83.99.135.235])
        by smtp.gmail.com with ESMTPSA id w23sm21250ljj.134.2021.07.07.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:38:38 -0700 (PDT)
From:   Davis Mosenkovs <davis@mosenkovs.lv>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Davis Mosenkovs <davis@mosenkovs.lv>
Subject: [PATCH 4.14] mac80211: fix memory corruption in EAPOL handling
Date:   Thu,  8 Jul 2021 00:38:34 +0300
Message-Id: <20210707213834.1088078-1-davis@mosenkovs.lv>
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

