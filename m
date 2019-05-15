Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED21FC8A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEOWVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 18:21:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38888 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfEOWVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 18:21:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so694200pfb.5
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zcZ3ggbgfQbaOnVig4gm0LxY5eiiFJcANdrqgqqUV4k=;
        b=bXBZK0q1Clk8dHb5IeU4aTk2ykSu9CPrwHFtp6v53UsUyAMjaDRKlr6HlUZpsMB68z
         SgQHWaB5iW0jrALkbrDx9JY3r6ca2zMUvyCIVWxDroy06URIMUXZNaQ+qmKxo7kOGHVx
         2hMGJx4zj57o+GvbHw7nJi0EQk7TuhMONsfKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zcZ3ggbgfQbaOnVig4gm0LxY5eiiFJcANdrqgqqUV4k=;
        b=Sidre0UyrpcFW/5z+YaNr/gr1JsBe2YGCXwF2eoMrNMdPNSBQL/p6jCS3WyUyLkjkC
         hVJpK32VAejj5ao9rp+LAr1F2Hc41PpdhT9xP6/9SNK+nesUx79qH545FDAnTasQVsOS
         EbaTvqOjVuWYAGi/OY6SGf674HYlH0Qzav5oaC8wMLcwbVfeYnUkRz7yzRlmK6Vwk8Kh
         6rLyX5p0I8MKOlGp0ofkkHJwJcR8DXIZvp5Xkvu3AxEn+50r2F3fQasSO5EbGdnpFkEk
         3XzvbUeh4gez6Qz6Cuoe2pBCARQ7KdSUNsUjpfWYSm+2YrPL895oga9oDGiJvhIRKZqs
         428Q==
X-Gm-Message-State: APjAAAW2LzhrzGR+oL4YJT+tVyQw7WoF0TwxErWg8hnT1gwah3BroG9Y
        7Rx1ofhOq+rsnXeEMWAvudBeWwZgcHyytQ==
X-Google-Smtp-Source: APXvYqwJNCjYsBiXvcnn1J2zaqvjje8c2q9uuF8j+PuFVnRdaVPMYxPKgkFkMmIeRL/KhF3Bk5+3iw==
X-Received: by 2002:aa7:860a:: with SMTP id p10mr32373018pfn.214.1557958908624;
        Wed, 15 May 2019 15:21:48 -0700 (PDT)
Received: from uf8ac7dbfedf154.ant.amazon.com (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id w194sm8683298pfd.56.2019.05.15.15.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 May 2019 15:21:48 -0700 (PDT)
From:   Thomas Pedersen <thomas@eero.com>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        peter.oh@bowerswilkins.com, Thomas Pedersen <thomas@eero.com>
Subject: [PATCH] mac80211: mesh: fix RCU warning
Date:   Wed, 15 May 2019 15:21:46 -0700
Message-Id: <1557958906-1432-1-git-send-email-thomas@eero.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ifmsh->csa was being dereferenced without the RCU read
lock held.

fixes the following warning:

[   74.930435] =============================
[   74.932066] WARNING: suspicious RCU usage
[   74.933671] 4.20.13 #5 Tainted: G        W
[   74.935804] -----------------------------
[   74.937427] net/mac80211/mesh.c:1218 suspicious rcu_dereference_check() usage!
[   74.940473] other info that might help us debug this:
[   74.943654] rcu_scheduler_active = 2, debug_locks = 1
[   74.946311] 5 locks held by kworker/u8:3/107:
[   74.948087]  #0: 000000007623c1f0 ((wq_completion)"%s"wiphy_name(local->hw.wiphy)){+.+.}, at: process_one_work+0x1a2/0x610
[   74.952464]  #1: 00000000077b4215 ((work_completion)(&sdata->csa_finalize_work)){+.+.}, at: process_one_work+0x1a2/0x610
[   74.957228]  #2: 00000000e02b12da (&wdev->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x2f/0x90
[   74.959870]  #3: 00000000e6855095 (&local->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x47/0x90
[   74.962937]  #4: 00000000bb5e3bca (&local->chanctx_mtx){+.+.}, at: ieee80211_csa_finalize_work+0x51/0x90

Signed-off-by: Thomas Pedersen <thomas@eero.com>
---
 net/mac80211/mesh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 766e5e5..70aeb34 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1220,10 +1220,12 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
 	ifmsh->chsw_ttl = 0;
 
 	/* Remove the CSA and MCSP elements from the beacon */
+	rcu_read_lock();
 	tmp_csa_settings = rcu_dereference(ifmsh->csa);
 	RCU_INIT_POINTER(ifmsh->csa, NULL);
 	if (tmp_csa_settings)
 		kfree_rcu(tmp_csa_settings, rcu_head);
+	rcu_read_unlock();
 	ret = ieee80211_mesh_rebuild_beacon(sdata);
 	if (ret)
 		return -EINVAL;
-- 
2.7.4

