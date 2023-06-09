Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8BE729719
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbjFIKjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbjFIKii (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 06:38:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD654201
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 03:37:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b24b34b59fso6474035ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jun 2023 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686307021; x=1688899021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/mMvigJL/P3XLjW5mZdClcY+WmwFZZzzoiJhKTDQkc=;
        b=DkNUuTXB0JIT0AXio19/Jo3070HAKtDbCtYGrpkRTrTxcGxe0IBqINmdRq7ZK6co1y
         iiCh++Uonsk7uWIL2TzvKebJ0+FSry8nq63iz7LAFNScMsbd88E64wizfp5Mbh+EEVn0
         4TVj+Z94mfLDGGqOrDQZ4T6lYKa3ADJONQHmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686307021; x=1688899021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/mMvigJL/P3XLjW5mZdClcY+WmwFZZzzoiJhKTDQkc=;
        b=LeKu1xQ7awEeZS/rgVp9pZ7YIS2F9BXWz6NRDNcYwGvBZTpcFobYx0Y1hmZoJ4DYeJ
         gnhxg5Dc8/WIdhiA+tObT3vcHH0b25Ne9dERRqFK9HvdSAOA4hP8uVmmko9xgpcPn/ep
         xmT7kb7ZKfsDYrq5JMpDb10f47Or50bdu9koA33wxTrPtuZV7t1ZK6kAoAeOCEYjYCwm
         s48ZyJblIV2cgEUGdPzoPHQauO60QpRa4XLxwNhR5Vn6JcRAgiCRardzojfce3ECrxBV
         7s/q0IKafrAHbvW8w0DQe1t/pSNgv7pqG6ZgePFExFHxPUyHCooX3xrgG5wzifqIBlsq
         153g==
X-Gm-Message-State: AC+VfDz5as4l6q3A83iPybgIfQQ5xb/7QaldPaf78yXNtOEK9j4fcWdC
        XXW9o+rThRGVT8SPMdWpEBxgNw==
X-Google-Smtp-Source: ACHHUZ4/tjNrUSzT1tnZZD6sxOJEB9j+rcJeEl5E91K3jwKxL+7t9skx3rdOFvvC+tUnYjjRfdQotA==
X-Received: by 2002:a17:902:f547:b0:1af:fbb6:23b7 with SMTP id h7-20020a170902f54700b001affbb623b7mr914456plf.3.1686307020776;
        Fri, 09 Jun 2023 03:37:00 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:6df7:6572:8bac:cbd6])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ebd200b001acaf7e26bbsm2949733plg.53.2023.06.09.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:37:00 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] wifi: mwifiex: Replace RX workqueues with kthreads
Date:   Fri,  9 Jun 2023 18:35:01 +0800
Message-ID: <20230609103651.313194-1-treapking@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This improves the RX throughput likely by better locality for the work
loads.

We tested this patch on Mediatek MT8173 Chromebooks, and it shows ~80%
Rx throughput improvement on high data rate test cases.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 .../wireless/marvell/mwifiex/11n_rxreorder.c  |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 drivers/net/wireless/marvell/mwifiex/main.c   | 29 ++++++++-----------
 drivers/net/wireless/marvell/mwifiex/main.h   |  5 ++--
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 391793a16adc..431f6dc61f5b 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -198,7 +198,7 @@ mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
 	priv->adapter->rx_locked = true;
 	if (priv->adapter->rx_processing) {
 		spin_unlock_bh(&priv->adapter->rx_proc_lock);
-		flush_workqueue(priv->adapter->rx_workqueue);
+		kthread_flush_worker(priv->adapter->rx_thread);
 	} else {
 		spin_unlock_bh(&priv->adapter->rx_proc_lock);
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index bcd564dc3554..f985bff4e52c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -872,7 +872,7 @@ static int mwifiex_deinit_priv_params(struct mwifiex_private *priv)
 	adapter->rx_locked = true;
 	if (adapter->rx_processing) {
 		spin_unlock_bh(&adapter->rx_proc_lock);
-		flush_workqueue(adapter->rx_workqueue);
+		kthread_flush_worker(adapter->rx_thread);
 	} else {
 	spin_unlock_bh(&adapter->rx_proc_lock);
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index ea22a08e6c08..bab963f3db83 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -168,7 +168,7 @@ static void mwifiex_queue_rx_work(struct mwifiex_adapter *adapter)
 		spin_unlock_bh(&adapter->rx_proc_lock);
 	} else {
 		spin_unlock_bh(&adapter->rx_proc_lock);
-		queue_work(adapter->rx_workqueue, &adapter->rx_work);
+		kthread_queue_work(adapter->rx_thread, &adapter->rx_work);
 	}
 }
 
@@ -526,9 +526,10 @@ static void mwifiex_terminate_workqueue(struct mwifiex_adapter *adapter)
 		adapter->workqueue = NULL;
 	}
 
-	if (adapter->rx_workqueue) {
-		destroy_workqueue(adapter->rx_workqueue);
-		adapter->rx_workqueue = NULL;
+	if (adapter->rx_thread) {
+		kthread_flush_worker(adapter->rx_thread);
+		kthread_destroy_worker(adapter->rx_thread);
+		adapter->rx_thread = NULL;
 	}
 }
 
@@ -1394,7 +1395,7 @@ int is_command_pending(struct mwifiex_adapter *adapter)
  *
  * It handles the RX operations.
  */
-static void mwifiex_rx_work_queue(struct work_struct *work)
+static void mwifiex_rx_work_queue(struct kthread_work *work)
 {
 	struct mwifiex_adapter *adapter =
 		container_of(work, struct mwifiex_adapter, rx_work);
@@ -1554,13 +1555,10 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 	INIT_WORK(&adapter->main_work, mwifiex_main_work_queue);
 
 	if (adapter->rx_work_enabled) {
-		adapter->rx_workqueue = alloc_workqueue("MWIFIEX_RX_WORK_QUEUE",
-							WQ_HIGHPRI |
-							WQ_MEM_RECLAIM |
-							WQ_UNBOUND, 1);
-		if (!adapter->rx_workqueue)
+		adapter->rx_thread = kthread_create_worker(0, "MWIFIEX_RX");
+		if (IS_ERR(adapter->rx_thread))
 			goto err_kmalloc;
-		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
+		kthread_init_work(&adapter->rx_work, mwifiex_rx_work_queue);
 	}
 
 	/* Register the device. Fill up the private data structure with
@@ -1709,14 +1707,11 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 	INIT_WORK(&adapter->main_work, mwifiex_main_work_queue);
 
 	if (adapter->rx_work_enabled) {
-		adapter->rx_workqueue = alloc_workqueue("MWIFIEX_RX_WORK_QUEUE",
-							WQ_HIGHPRI |
-							WQ_MEM_RECLAIM |
-							WQ_UNBOUND, 1);
-		if (!adapter->rx_workqueue)
+		adapter->rx_thread = kthread_create_worker(0, "MWIFIEX_RX");
+		if (!adapter->rx_thread)
 			goto err_kmalloc;
 
-		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
+		kthread_init_work(&adapter->rx_work, mwifiex_rx_work_queue);
 	}
 
 	/* Register the device. Fill up the private data structure with relevant
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index b95886e1413e..3255f9a5c2d4 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -32,6 +32,7 @@
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kthread.h>
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -886,8 +887,8 @@ struct mwifiex_adapter {
 	atomic_t tx_hw_pending;
 	struct workqueue_struct *workqueue;
 	struct work_struct main_work;
-	struct workqueue_struct *rx_workqueue;
-	struct work_struct rx_work;
+	struct kthread_worker *rx_thread;
+	struct kthread_work rx_work;
 	struct workqueue_struct *dfs_workqueue;
 	struct work_struct dfs_work;
 	bool rx_work_enabled;
-- 
2.41.0.162.gfafddb0af9-goog

