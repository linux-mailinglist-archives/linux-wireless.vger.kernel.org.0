Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE26F8C90
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 00:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjEEWxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 18:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEEWxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 18:53:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686305FF2;
        Fri,  5 May 2023 15:53:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24df161f84bso1676113a91.3;
        Fri, 05 May 2023 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683327199; x=1685919199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FApjzzhqhojssFso/inw2w0ZDVDPm9jgi/AAIV7/rHk=;
        b=jywK+RwxMhV9iU84grVOw5jKidLLptFFcS6tQe6Lbck8ZgygASbHzN1r7/+F6L5tuY
         1Ldbo1BJ12GAvqxp6OIifiY6s2N5rO8h6M+GjVBO6/zL0P2RhmY6SnFIWz8pahXVcHlR
         YTM/qBIdToM+ioIeJQcSbN95/A7WHL1GKEMaaV2GH9twEct5nwQOrKx/wCoTiWP9Iiwv
         xNxDhI1UivAAeqXEqm0riKycXu3cRtCHfDskwQBmNlK38CIhwiguoOLS0iKq7mn1yuBO
         SakwQLqjSXfC8l/H7Upuko6KJmwFh7lXRH7i5FJpaGHnT15O9gYzTcPmMbiBNXvEo5+r
         qHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683327199; x=1685919199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FApjzzhqhojssFso/inw2w0ZDVDPm9jgi/AAIV7/rHk=;
        b=VervEDR4x2us2b79hAHiEPRGMI6FtgfEzfFiul9pHMB3NYNnmcj3k5N//53byirN2m
         bEufCx1YpPB/F49ck25CR3tPnCtUPsJPmD/arJj6JeGBZLg5Wiy0nrQJzAHfXhbm9/L7
         kqvwaZxGshq4YSR/Jn7tC+O0zQYQDefqL/mgOEIT5IH+CMqpxjJPcoGu+m+JxGX+yXNV
         P3YaHxjJZ39la47HpRuK7/t2+/wZKYnscOl1vykWUfwAD6CSgV5eDQJpVKgO3lf+N+1g
         uLFxviDihXgLNDLEu8rmIyJNIqYaInHD3VI5aBH1QNOMqtCFWeW5zz6Ib8od0tTqSXt4
         PibA==
X-Gm-Message-State: AC+VfDwMlNr0iJu3ICJox4LXDCx2qVnXtBYOaX1tdWQ74kDFlqXJvxxG
        1+mS1Lw7g+2KD//3lF/815I=
X-Google-Smtp-Source: ACHHUZ7GPfmQCtflKFFEL+ZyFNN/RWwDQGdENQkLprgqzZssOiM7GWZUjtMN100dQEr3nO2HUAsoJw==
X-Received: by 2002:a17:90b:390c:b0:24f:52ec:da17 with SMTP id ob12-20020a17090b390c00b0024f52ecda17mr2948988pjb.35.1683327198555;
        Fri, 05 May 2023 15:53:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a94c600b0024de0de6ec8sm11654600pjw.17.2023.05.05.15.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:53:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 12:53:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Use default @max_active for workqueues
Message-ID: <ZFWI3PpJXeXXnHzi@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-11-tj@kernel.org>
 <ZEgYdSOYaojJBoPP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEgYdSOYaojJBoPP@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These workqueues only host a single work item and thus doen't need explicit
concurrency limit. Let's use the default @max_active. This doesn't cost
anything and clearly expresses that @max_active doesn't matter.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Ganapathi Bhat <ganapathi017@gmail.com>
Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Hello, Brian.

Do you mind acking this patch instead?

Thanks.

 drivers/net/wireless/marvell/mwifiex/cfg80211.c |    4 ++--
 drivers/net/wireless/marvell/mwifiex/main.c     |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3127,7 +3127,7 @@ struct wireless_dev *mwifiex_add_virtual
 	priv->dfs_cac_workqueue = alloc_workqueue("MWIFIEX_DFS_CAC%s",
 						  WQ_HIGHPRI |
 						  WQ_MEM_RECLAIM |
-						  WQ_UNBOUND, 1, name);
+						  WQ_UNBOUND, 0, name);
 	if (!priv->dfs_cac_workqueue) {
 		mwifiex_dbg(adapter, ERROR, "cannot alloc DFS CAC queue\n");
 		ret = -ENOMEM;
@@ -3138,7 +3138,7 @@ struct wireless_dev *mwifiex_add_virtual
 
 	priv->dfs_chan_sw_workqueue = alloc_workqueue("MWIFIEX_DFS_CHSW%s",
 						      WQ_HIGHPRI | WQ_UNBOUND |
-						      WQ_MEM_RECLAIM, 1, name);
+						      WQ_MEM_RECLAIM, 0, name);
 	if (!priv->dfs_chan_sw_workqueue) {
 		mwifiex_dbg(adapter, ERROR, "cannot alloc DFS channel sw queue\n");
 		ret = -ENOMEM;
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1547,7 +1547,7 @@ mwifiex_reinit_sw(struct mwifiex_adapter
 
 	adapter->workqueue =
 		alloc_workqueue("MWIFIEX_WORK_QUEUE",
-				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!adapter->workqueue)
 		goto err_kmalloc;
 
@@ -1557,7 +1557,7 @@ mwifiex_reinit_sw(struct mwifiex_adapter
 		adapter->rx_workqueue = alloc_workqueue("MWIFIEX_RX_WORK_QUEUE",
 							WQ_HIGHPRI |
 							WQ_MEM_RECLAIM |
-							WQ_UNBOUND, 1);
+							WQ_UNBOUND, 0);
 		if (!adapter->rx_workqueue)
 			goto err_kmalloc;
 		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
@@ -1702,7 +1702,7 @@ mwifiex_add_card(void *card, struct comp
 
 	adapter->workqueue =
 		alloc_workqueue("MWIFIEX_WORK_QUEUE",
-				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!adapter->workqueue)
 		goto err_kmalloc;
 
@@ -1712,7 +1712,7 @@ mwifiex_add_card(void *card, struct comp
 		adapter->rx_workqueue = alloc_workqueue("MWIFIEX_RX_WORK_QUEUE",
 							WQ_HIGHPRI |
 							WQ_MEM_RECLAIM |
-							WQ_UNBOUND, 1);
+							WQ_UNBOUND, 0);
 		if (!adapter->rx_workqueue)
 			goto err_kmalloc;
 
