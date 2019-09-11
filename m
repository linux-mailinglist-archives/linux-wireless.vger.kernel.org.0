Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43EAFE70
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIKOOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 10:14:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39535 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfIKOOi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 10:14:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id u6so20774473edq.6
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+cIXqEJuYpA0+Q8sRtzqfZF30sEabB61l9AAF9nu7w8=;
        b=1w4BZWxgJw5sYsf/oizvm5Y1vZsVCuO6CczfYzJmOcFZVOrDWaqS6jCUj31CX2g/vo
         M0RNlo39TaZQuv5AS6JZGfhJDORORN+HHb+ccywhzGtqE73gdsEKg7zXAZPOtCYk1+er
         1w0SyS5bEmy5QatqCQm1smp/wO/JmDQ3afjXezPjwRZxdqg48uAyMTW+0Gq4yGS8yhfz
         M1RNFyh4/OqzVXVmTtKd7oTrLeRcvpOjtM6zsstXQ3drTDF/J5UyXOdyfZgbs0KK3hbJ
         T/RdEGapuKajCekomdr2i5HnYT9FlR5Avd4+QhQB7wNquQTaZi+KyGtbYk+CfwQc+Flp
         WS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+cIXqEJuYpA0+Q8sRtzqfZF30sEabB61l9AAF9nu7w8=;
        b=qKinzh2vT/juvAbk8XfVFFmeqkBOIZvfd1sZnAqYAlujd7qYQTqWX65A/sc2ZUu/35
         FF6igNiiHdg4F40elRg5lOG/L99ryL8V7V04u8Kj2fenFvJ2pIZeCwaWjNWhJZetU9A6
         7IjTGNJJghk4ntG1uh8x3ltEafKUTBDPWwIY5rTsu5yf2vvbhg3DSf0uzIioMFfyQE2B
         Fj+x3Wt/boQ+5Q8uW0C7Mbj1zCoJM/MioAaS4Ls0lMWZT9ZtQLnLwWFG0i9tts8TKLBt
         iixJFHhJ623D3Zac66bATUgAZAmoQjvEXtN/3nudAKi6P8lACdlBAEjeQj1rAOKOq8W+
         dYeQ==
X-Gm-Message-State: APjAAAWpBAfUEW8i+kLxT/h7sZ3HWq0bsorIEMJk7jYUTRhy3jD7hKvC
        5PalaGjqmX91eUz0aTp2+8SbSXNQmv4=
X-Google-Smtp-Source: APXvYqydsRCRcwEEyTT3hW+df5ueJfCqumb3KQ1ikA/4kdRwuRb/3FqmeJT+UULfDHbqueX/KjBqVg==
X-Received: by 2002:a05:6402:2d0:: with SMTP id b16mr38007788edx.147.1568211276171;
        Wed, 11 Sep 2019 07:14:36 -0700 (PDT)
Received: from kvdp-BRIX.cmb.citymesh.com (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id g20sm1156821ejs.15.2019.09.11.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 07:14:35 -0700 (PDT)
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: [PATCH] mac80211: IBSS: avoid unneeded return value processing
Date:   Wed, 11 Sep 2019 16:14:31 +0200
Message-Id: <20190911141431.12498-1-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

when ieee80211_ibss_csa_beacon() fails, we return it's value.
When it succeeds, we basically copy it's value and also .. return it.

Just return it immediately, simplifying the code.

Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
---
 net/mac80211/ibss.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 0a6ff01c68a9..d40744903fa9 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -538,7 +538,6 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	struct cfg80211_bss *cbss;
-	int err, changed = 0;
 
 	sdata_assert_lock(sdata);
 
@@ -560,13 +559,7 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata)
 	ifibss->chandef = sdata->csa_chandef;
 
 	/* generate the beacon */
-	err = ieee80211_ibss_csa_beacon(sdata, NULL);
-	if (err < 0)
-		return err;
-
-	changed |= err;
-
-	return changed;
+	return ieee80211_ibss_csa_beacon(sdata, NULL);
 }
 
 void ieee80211_ibss_stop(struct ieee80211_sub_if_data *sdata)
-- 
2.17.1

