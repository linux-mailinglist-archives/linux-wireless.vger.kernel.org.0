Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7454E18DD
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244304AbiCSWtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Mar 2022 18:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiCSWth (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Mar 2022 18:49:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797603D1F2
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 15:48:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d10so23283900eje.10
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCqBpccjcNXkw8O9oNUVFQJT/haogygOhyRJMS2AB2E=;
        b=N3CWSeh/NWG8EuFwVWQYxoMS4aRFPjr2bFPKL175b+2knlUAgeeNcl/yP9PpbSdHEK
         +7RuT16xi3r0qkiqCNKw5XGFRermvxjJkwy/MqbqJnuuObPrhp4gcwwGdiiIe96DP4BK
         BHD51lK0B1vN6gdnkyUmn+VOuCJuEkc1W+f9SAVwS7YWL1bqBOQql+ZT/ktp5wKdqATK
         +rf3kfFke6413I9nDwYfJbP/u+DFt+vp29DZeUsqnTt4wFBoXRUDnzLoBlykRpm9I8Yl
         M0Bw6HFrnDAIBziDz6IfXhyN6ZsT+r5xvpm0YWXQ7mBhagvr2yaiPUMfqjN78Bdzd869
         lJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCqBpccjcNXkw8O9oNUVFQJT/haogygOhyRJMS2AB2E=;
        b=1nfqEJaxH4g96eghq69I1xN7dbqdCioNXwVPbQUbeENZK4UUUi1t5DBNz+kuvqiXcq
         LvG6BUq9iobPGXDG8TKOk058ykjqIwuI3TZV41cwoxixTuOOAkekxD8MiWhKjQgGcHmp
         19PWz5iu9BlcRKnFohFYzRYCMw7HtfCGvxR7LPVPur6sNwOkf8UKDAHJ5k+QYRytRpwH
         gifTyz8za9uOvBxs0Qt/Cb2ItnUi7oihEBVo8LFnrI/XuzVER2hubmGyGE1Aq8pEpVlF
         mdC7XlBBmkdQSXyADNI9vMX7oBU6/GlaEZ9o8YCb5cB06PQ1MnXff5R3p8QwIDF3Kb3C
         hxXw==
X-Gm-Message-State: AOAM531xipGh3Vj3L9/xkxOX+FBBp4vXyfmdeZZ8BTWGP4V8wMDYdClP
        pglBkTOCh3QEH8WP9349Gxi+dpnPIiI=
X-Google-Smtp-Source: ABdhPJzu8px8EW3fkckcs/HKuogafm66o3eSF+9Qti10PakF90oiMSUNguxNfZ2Gnr2UMF0M9qo16Q==
X-Received: by 2002:a17:906:58c7:b0:6da:955b:d300 with SMTP id e7-20020a17090658c700b006da955bd300mr14544930ejs.481.1647730093110;
        Sat, 19 Mar 2022 15:48:13 -0700 (PDT)
Received: from nlaptop.localdomain (178-117-137-225.access.telenet.be. [178.117.137.225])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090630c200b006d58f94acecsm5301292ejb.210.2022.03.19.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 15:48:12 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH RFT] mwifiex: add mutex lock for call in mwifiex_dfs_chan_sw_work_queue
Date:   Sat, 19 Mar 2022 23:47:52 +0100
Message-Id: <20220319224751.72241-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211_ch_switch_notify uses ASSERT_WDEV_LOCK to assert that
net_device->ieee80211_ptr->mtx is held during the function's execution.
mwifiex_dfs_chan_sw_work_queue is one of its callers, which does not
hold that lock, therefore violating the assertion.
Add a lock around the call.

Disclaimer:
I am currently working on a static analyser to detect missing locks.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch.
However, as I do not in fact have this particular hardware,
I was unable to test it.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/11h.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index d2ee6469e67b..f2cba764024e 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -285,6 +285,7 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	struct mwifiex_private *priv =
 			container_of(delayed_work, struct mwifiex_private,
 				     dfs_chan_sw_work);
+	struct net_device *netdev;
 
 	bss_cfg = &priv->bss_cfg;
 	if (!bss_cfg->beacon_period) {
@@ -301,7 +302,11 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 		return;
 	}
 
+	netdev = priv->netdev;
+
 	mwifiex_dbg(priv->adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
-	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef);
+	mutex_lock(&netdev->ieee80211_ptr->mtx);
+	cfg80211_ch_switch_notify(netdev, &priv->dfs_chandef);
+	mutex_unlock(&netdev->ieee80211_ptr->mtx);
 }
-- 
2.35.1

