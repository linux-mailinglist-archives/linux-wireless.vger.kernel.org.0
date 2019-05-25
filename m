Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44B2A2B0
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2019 06:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfEYEQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 May 2019 00:16:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41959 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEYEQ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 May 2019 00:16:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so4905947plt.8
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2019 21:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VdDQH+QybpJuQuwob6y4AAaL3QBAr+372aK8MmZ7O3c=;
        b=Yhv1YHJeSa2rVx3RxNjoi7Gj/Knj/WAD+KiLlaRKcKldFBQ5L3gHvHVSaDN6NKA4Am
         RadWzBUWODwpFhfDomQvJb5o6tIKPRk0y1U5VjupoW0536exU09AM6uyHobDJ/sD6nO/
         EJAK8lmW6gvz5GK401IKkvMTxFGZSA/CzTXww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VdDQH+QybpJuQuwob6y4AAaL3QBAr+372aK8MmZ7O3c=;
        b=f3oiGsm2BTzrl+yYUGO8p3yRfrkVRy2eflS637iPYLBDImoCvqJ3g8l82FJYSm6TB0
         tTFQXvN50bdOIxODKpdVaxzhwaV9HkqW3EmCvRDsLYzEIRouA/ydatUXIHY7VsVPF9Va
         A5RqU4PiK+jPTh+HPU7abLA50nmYuOKxdrJWNq8Cd+qL3XKlzsd8n5h3Y8PdgS1s1bGH
         jMy9/rsAzAEvczY2V16WXVBnaG/l9V+WD8rO1smPwH4EJWUafB+9QcjmZKCOsdsA7np+
         zm2VtXmFrcW4ez9TjO+Y7NBnkpVX1o+kS/EVarrfz7zizVu6zkjhYhB/Z0I+WzbMEinn
         bIXQ==
X-Gm-Message-State: APjAAAVlpi8XnkmYkoqa9YqVEONvf0UYL8gjUYJNezfJsVsKUfbCYvzZ
        gJOlAPQyjlCxyr0iezIX1cCJdg==
X-Google-Smtp-Source: APXvYqxk7cbIvomWGFWxcrCA4sIDn0X+FSQSY0mYo184t35gJazAbmxtBZAxUX0zZT+uccyxskDa+A==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10mr113298356plb.18.1558757785576;
        Fri, 24 May 2019 21:16:25 -0700 (PDT)
Received: from uf8ac7dbfedf154.ant.amazon.com (c-73-158-126-35.hsd1.ca.comcast.net. [73.158.126.35])
        by smtp.gmail.com with ESMTPSA id z11sm5086742pfg.187.2019.05.24.21.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 21:16:25 -0700 (PDT)
From:   Thomas Pedersen <thomas@eero.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Thomas Pedersen <thomas@eero.com>
Subject: [PATCH v2] mac80211: mesh: fix RCU warning
Date:   Fri, 24 May 2019 21:16:24 -0700
Message-Id: <1558757784-23179-1-git-send-email-thomas@eero.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ifmsh->csa is an RCU-protected pointer. The writer context
in ieee80211_mesh_finish_csa() is already mutually
exclusive with wdev->sdata.mtx, but the RCU checker did
not know this. Use rcu_dereference_protected() to avoid a
warning.

fixes the following warning:

[   12.519089] =============================
[   12.520042] WARNING: suspicious RCU usage
[   12.520652] 5.1.0-rc7-wt+ #16 Tainted: G        W
[   12.521409] -----------------------------
[   12.521972] net/mac80211/mesh.c:1223 suspicious rcu_dereference_check() usage!
[   12.522928] other info that might help us debug this:
[   12.523984] rcu_scheduler_active = 2, debug_locks = 1
[   12.524855] 5 locks held by kworker/u8:2/152:
[   12.525438]  #0: 00000000057be08c ((wq_completion)phy0){+.+.}, at: process_one_work+0x1a2/0x620
[   12.526607]  #1: 0000000059c6b07a ((work_completion)(&sdata->csa_finalize_work)){+.+.}, at: process_one_work+0x1a2/0x620
[   12.528001]  #2: 00000000f184ba7d (&wdev->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x2f/0x90
[   12.529116]  #3: 00000000831a1f54 (&local->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x47/0x90
[   12.530233]  #4: 00000000fd06f988 (&local->chanctx_mtx){+.+.}, at: ieee80211_csa_finalize_work+0x51/0x90

Signed-off-by: Thomas Pedersen <thomas@eero.com>
---
v2: rcu_read_lock() doesn't make sense. Use rcu_dereference_protected() (Johannes)
---
 net/mac80211/mesh.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 766e5e5..d5aba50 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1220,7 +1220,8 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
 	ifmsh->chsw_ttl = 0;
 
 	/* Remove the CSA and MCSP elements from the beacon */
-	tmp_csa_settings = rcu_dereference(ifmsh->csa);
+	tmp_csa_settings = rcu_dereference_protected(ifmsh->csa,
+					    lockdep_is_held(&sdata->wdev.mtx));
 	RCU_INIT_POINTER(ifmsh->csa, NULL);
 	if (tmp_csa_settings)
 		kfree_rcu(tmp_csa_settings, rcu_head);
@@ -1242,6 +1243,8 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	struct mesh_csa_settings *tmp_csa_settings;
 	int ret = 0;
 
+	lockdep_assert_held(&sdata->wdev.mtx);
+
 	tmp_csa_settings = kmalloc(sizeof(*tmp_csa_settings),
 				   GFP_ATOMIC);
 	if (!tmp_csa_settings)
-- 
2.7.4

