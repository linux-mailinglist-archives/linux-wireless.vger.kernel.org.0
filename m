Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC23326BE7
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 06:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhB0F7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 00:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhB0F7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 00:59:11 -0500
Received: from mail-vs1-xe64.google.com (mail-vs1-xe64.google.com [IPv6:2607:f8b0:4864:20::e64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D08C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 21:58:31 -0800 (PST)
Received: by mail-vs1-xe64.google.com with SMTP id b6so5899667vsf.8
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 21:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NGi/66p31sIEdoj6s6Pv9ccJ5vtDCnjdabQba4LwrRI=;
        b=Y3AjkSTz4x+s+L64fwrLnD/s3RD73DHJCiT7eXEz+myqbjv/dbE9hUh0irJx0R93cN
         m6TqMxs1fQW5d6rJZZerjW2D+/sKnmBlZxwcGmtx8ww9sj0SPTDJ2HbRpvOGfbvv138/
         52b+IGSKu71rhjKbPt4sDEQE4wxpRZJNxlBK+93ddok2fE24DI4F3x8Xhflc+kQEDzSI
         RvwEDbG5pnpwMQzNtus6MhU5LkkxCjxIuUJu5kP6yW4nE5pdZgvVIyTaHX01nbM0Wpph
         lILZvs/plWXEGOWn8WPAGjDZOLlvkFveBJMZpYVVVHq7EFqG4DoCVcMaBvtPACTUvcUF
         iLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NGi/66p31sIEdoj6s6Pv9ccJ5vtDCnjdabQba4LwrRI=;
        b=h+rhaFgN9uDa+LvhQjIiid6XakyCUyY8Tb7Pn1u09ha761ks/Krgx1tZAm2b8qQQo2
         8AmYzbjo6REWkJ1PD5vnFEifku6QZf28tVoxG29aZxzOZwRFtvaW/9/UptgU+6Jrdhas
         f6u1CnBv1jOYvotRCC8gidrv90bVFP5l7MCAenVuPQpxb5/n9+kZUQhEFEea6W00GWPK
         pCSWrfVvhy2XatmOUNPU+WDJx7kzay+n9Xv96/qLz+wiOIiP0Os2aDVKSSDPzYhO/OKa
         Hv5JSRiJDPb1NxS0ADl+omb6aMOKz2d773Oa9FbGlSK02tSrGd8VnJZWadIVTSYL+xSl
         0Alw==
X-Gm-Message-State: AOAM533WkuUo1JP32U1toCfapO59J0SfMuZxY3nBrn+dyGhjycgTBK7k
        zlvbtt/hpnEgVxuwtztjwvNCjhdZU4ilaWr7Va5J3f2vig3PjpY7RZ11hd+MNupf6A==
X-Google-Smtp-Source: ABdhPJwAEt6yI1disXW/dKYWAb2e0thGlG8IIs5XkuL4Yy7qR+OIWJsmB4l5oLGBqvgMCFrvR73rjmc8kvz3
X-Received: by 2002:a67:cb87:: with SMTP id h7mr3303884vsl.33.1614405510411;
        Fri, 26 Feb 2021 21:58:30 -0800 (PST)
Received: from bdawood.hub ([2405:6e00:1023:7100:7de3:6a0:678b:f1cd])
        by smtp-relay.gmail.com with ESMTPS id s189sm2505730vkh.12.2021.02.26.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 21:58:30 -0800 (PST)
X-Relaying-Domain: morsemicro.com
From:   Bassem Dawood <bassem@morsemicro.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH] mac80211: Enable power save after receiving NULL packet ACK
Date:   Sat, 27 Feb 2021 16:58:15 +1100
Message-Id: <20210227055815.14838-1-bassem@morsemicro.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Trigger dynamic_ps_timer to re-evaluate power saving once a null function
packet (with PM = 1) is ACKed.

Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/mac80211/status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3485610755ef..c106f81478df 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1013,9 +1013,9 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (info->flags & IEEE80211_TX_STAT_ACK) {
 			local->ps_sdata->u.mgd.flags |=
 					IEEE80211_STA_NULLFUNC_ACKED;
-		} else
-			mod_timer(&local->dynamic_ps_timer, jiffies +
-					msecs_to_jiffies(10));
+		}
+		mod_timer(&local->dynamic_ps_timer, jiffies +
+				msecs_to_jiffies(10));
 	}
 
 	ieee80211_report_used_skb(local, skb, false);
-- 
2.17.1

