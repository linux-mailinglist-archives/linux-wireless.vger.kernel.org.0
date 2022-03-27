Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25D4E8914
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Mar 2022 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiC0RPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Mar 2022 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbiC0RPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Mar 2022 13:15:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACF11C2D
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 10:14:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so24325383ejb.0
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O4s6ak/A5yinAv1VSo+xOscSi9+hU2/upvm8fRSKuM=;
        b=JSAYRtdM5YAkvcZnvrRyg7U/vqwjYG5lGK6c+tkEc3eL2fPCbrkPQ/TXdnf9ec3Tan
         ThPstqd4cZLmx9vgrgqH90IkWO8P7PiaJzpx/Ys5PRot23YqHx7c24YIulpHS7Fdbup6
         rB6JdDKIpgP2IpMZJkB5sZ9VcSCx1XbPPW61aeWlId8RDlZy//0ztLmrEd1N3XaTY3Rx
         tHgw0s47LXGzBD2mnpG1rNFmnRuM/bM4Y4u5cH436wbOFiHQm7aefVEhVbxhXTt28SBz
         smXUcDmL5V0MPK8uOLmJNFO2mADDHuuuaS4OFLlFT3QZjf5dEVAJM48wRVlRH4hqmeBQ
         Wm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+O4s6ak/A5yinAv1VSo+xOscSi9+hU2/upvm8fRSKuM=;
        b=SkxVh51Nb8kNh9LtZ8/kyCFglg7Ilty0hD6mVUlJQ/vmdxf9DvVxk8kOpUTtv9PgDk
         Nsd0cX87bWFBISjTcitsEc9DsNxVndbmu5AlTFgyOORMS3BtzqIb19pDnK7vMPdvmY1T
         Ti8kTbSI7bzJNhrCwENdfFGT/zUuPYgoEADtBblvJATIIs36/fjTJAEck1Xrt/8yAwDo
         bQf3kmkBvfKvHkzd9IUKoaUFdX+X0+ikFQTBJRpe0XuLG/zgqteb3aUUv1KZmhuYD5Xe
         aR/kjMxeI7Kwlsz2ZXK/aEvgBh9CXurHZ+VctMzjpInjtOoz0c6gSWKCzeeuSkXvzRdd
         prAA==
X-Gm-Message-State: AOAM532nq1iEle4znI2g6an0q+ed7NJ/w2zPOAKcZv9OUIPhAJgyOhXg
        RVWBOf3klGG7ILqua8V4+5U=
X-Google-Smtp-Source: ABdhPJz1yaBSXEbXGTItoOO5HcREi+w4C4NYq6bkDOjQ5jxqQAa9DHqXULxKBntzwXKnUUUEGMa9Yw==
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id cr21-20020a170906d55500b006db148e05ccmr22393408ejc.63.1648401242061;
        Sun, 27 Mar 2022 10:14:02 -0700 (PDT)
Received: from localhost.localdomain (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm4866769ejy.37.2022.03.27.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 10:14:01 -0700 (PDT)
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, davem@davemloft.net, kuba@kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH 2/2] ath10k: enable napi on RX path for usb
Date:   Sun, 27 Mar 2022 19:13:40 +0200
Message-Id: <20220327171340.7893-2-erik.stromdahl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327171340.7893-1-erik.stromdahl@gmail.com>
References: <20220327171340.7893-1-erik.stromdahl@gmail.com>
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

commit cfee8793a74dc3afabb08fc9 ("ath10k: enable napi on RX path for
sdio") introduced napi for SDIO and updated the htt interface for high
latency devices.

These changes breaks USB, so USB code must be updated to use napi as
well in order to have a working RX path.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
---
 drivers/net/wireless/ath/ath10k/usb.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 7ed2022ac3c2..10df6ca303a1 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -345,6 +345,12 @@ static void ath10k_usb_rx_complete(struct ath10k *ar, struct sk_buff *skb)
 	ep->ep_ops.ep_rx_complete(ar, skb);
 	/* The RX complete handler now owns the skb... */
 
+	if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags)) {
+		local_bh_disable();
+		napi_schedule(&ar->napi);
+		local_bh_enable();
+	}
+
 	return;
 
 out_free_skb:
@@ -387,6 +393,7 @@ static int ath10k_usb_hif_start(struct ath10k *ar)
 	int i;
 	struct ath10k_usb *ar_usb = ath10k_usb_priv(ar);
 
+	ath10k_core_napi_enable(ar);
 	ath10k_usb_start_recv_pipes(ar);
 
 	/* set the TX resource avail threshold for each TX pipe */
@@ -462,6 +469,7 @@ static int ath10k_usb_hif_tx_sg(struct ath10k *ar, u8 pipe_id,
 static void ath10k_usb_hif_stop(struct ath10k *ar)
 {
 	ath10k_usb_flush_all(ar);
+	ath10k_core_napi_sync_disable(ar);
 }
 
 static u16 ath10k_usb_hif_get_free_queue_number(struct ath10k *ar, u8 pipe_id)
@@ -966,6 +974,20 @@ static int ath10k_usb_create(struct ath10k *ar,
 	return ret;
 }
 
+static int ath10k_usb_napi_poll(struct napi_struct *ctx, int budget)
+{
+	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
+	int done;
+
+	done = ath10k_htt_rx_hl_indication(ar, budget);
+	ath10k_dbg(ar, ATH10K_DBG_USB, "napi poll: done: %d, budget:%d\n", done, budget);
+
+	if (done < budget)
+		napi_complete_done(ctx, done);
+
+	return done;
+}
+
 /* ath10k usb driver registered functions */
 static int ath10k_usb_probe(struct usb_interface *interface,
 			    const struct usb_device_id *id)
@@ -992,6 +1014,9 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 		return -ENOMEM;
 	}
 
+	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_usb_napi_poll,
+		       ATH10K_NAPI_BUDGET);
+
 	usb_get_dev(dev);
 	vendor_id = le16_to_cpu(dev->descriptor.idVendor);
 	product_id = le16_to_cpu(dev->descriptor.idProduct);
@@ -1045,6 +1070,7 @@ static void ath10k_usb_remove(struct usb_interface *interface)
 		return;
 
 	ath10k_core_unregister(ar_usb->ar);
+	netif_napi_del(&ar_usb->ar->napi);
 	ath10k_usb_destroy(ar_usb->ar);
 	usb_put_dev(interface_to_usbdev(interface));
 	ath10k_core_destroy(ar_usb->ar);
-- 
2.35.1

