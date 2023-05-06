Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2D6F8EB2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 07:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEFF00 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 01:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFF0Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 01:26:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479396A6A
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 22:26:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1ab267e3528so18208565ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 May 2023 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683350783; x=1685942783;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70LT6X61LbeB8ikxqnFrMNCv/hLH4+7EVZySi5yDQso=;
        b=SUkY5m3hbHfAT8bMlrFZU+GdnWFQPImSdH6P2HXruAtpiob35zpokOqpYfWV/tstib
         FdvXBoxnORq9jFgn+FofCS0aYr/I0fbRdgEXLAQn9CMGmrHeS7gkJeluwzb40GxFEhlc
         bXETYbXMwZFeqDp/NtwWxLzyP/WVblsPzAradDsXabtIKV/rq3UEPJDjfLPIT/JZW7Wv
         q+dTKKcMWx3FoTMn+eM9Lmlq/pGhNvzS11slV5KYAjUumZP1S9eCEUV4HpngFZYUqvNK
         k0zavoDQfWD2GEYX9X/tWvsgdSG7zxazc+6XOT9QrVWfR7kVLEucKDbuTTawqZWRy21s
         PRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683350783; x=1685942783;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70LT6X61LbeB8ikxqnFrMNCv/hLH4+7EVZySi5yDQso=;
        b=CXBH8MauMhPVMnuRcMFc+ZupY6w5hP7SW4wNO8/lV81PnYXMEBWBd1SnU3oghrU3d2
         B9xXsUG5NZSIaRj2UyW9kNQhjmyUgL1j6xtrVxodhMIrLeHzOFuIH8eQvGyPblxz0UpM
         rUllBSe/qpSoXvm5nX6LYdetLda34gk+XFjJoIEYdrmoCUkLMcbpdNcVx1ACmLnEIGPs
         ivGHzvg5aMISHqAE564MFvfo04o09MQntjE59NATlLbWc0RGeLckFy3ptUqk5fPLYZuf
         oJv8x+msNhYT4bxsvXMRWsxUjVPyHSKCc3FknK1dRjJuaPZx6qjS17KH3UfiZb1mkfNc
         fE5w==
X-Gm-Message-State: AC+VfDxo7utVn0/UX4LPePXK/o6jAjb4IWETchxclMg9rT9fxrubexeE
        7TCCzheNuiGRe28BIiF8+9pmJLiqPKDKiZHQ3s0=
X-Google-Smtp-Source: ACHHUZ4recD9ewKa20bdg8SsQmWDp9keBAMMe2rkt6KvLgntqHttIzaZATne9AKrC2bs0713fEPXWg==
X-Received: by 2002:a17:903:32c7:b0:1ab:32f:96e9 with SMTP id i7-20020a17090332c700b001ab032f96e9mr4309117plr.39.1683350783504;
        Fri, 05 May 2023 22:26:23 -0700 (PDT)
Received: from DESKTOP (softbank060144221083.bbtec.net. [60.144.221.83])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b0019ef86c2574sm2621829plb.270.2023.05.05.22.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 22:26:23 -0700 (PDT)
Date:   Sat, 6 May 2023 14:26:20 +0900
From:   Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Sujith <Sujith.Manoharan@atheros.com>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH] wifi: ath9k: Fix memory leak in htc_connect_service
Message-ID: <ZFXk/AIKeapT72Pj@DESKTOP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Timeout occurs in htc_connect_service(), then this function returns
without freeing skb.

Fix this by going to err path.

syzbot report:
BUG: memory leak
unreferenced object 0xffff88810a980800 (size 240):
  comm "kworker/1:1", pid 24, jiffies 4294947427 (age 16.220s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83b971c6>] __alloc_skb+0x206/0x270 net/core/skbuff.c:552
    [<ffffffff82eb3731>] alloc_skb include/linux/skbuff.h:1270 [inline]
    [<ffffffff82eb3731>] htc_connect_service+0x121/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:259
    [<ffffffff82ec03a5>] ath9k_htc_connect_svc drivers/net/wireless/ath/ath9k/htc_drv_init.c:137 [inline]
    [<ffffffff82ec03a5>] ath9k_init_htc_services.constprop.0+0xe5/0x390 drivers/net/wireless/ath/ath9k/htc_drv_init.c:157
    [<ffffffff82ec0747>] ath9k_htc_probe_device+0xf7/0x8a0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
    [<ffffffff82eb3ef5>] ath9k_htc_hw_init+0x35/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:521
    [<ffffffff82eb68dd>] ath9k_hif_usb_firmware_cb+0xcd/0x1f0 drivers/net/wireless/ath/ath9k/hif_usb.c:1243
    [<ffffffff82aa835b>] request_firmware_work_func+0x4b/0x90 drivers/base/firmware_loader/main.c:1107
    [<ffffffff8129a35a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:2289
    [<ffffffff8129ac7d>] worker_thread+0x5d/0x5b0 kernel/workqueue.c:2436
    [<ffffffff812a4fa9>] kthread+0x129/0x170 kernel/kthread.c:376
    [<ffffffff81002dcf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Link: https://syzkaller.appspot.com/bug?id=fbf138952d6c1115ba7d797cf7d56f6935184e3f
Reported-and-tested-by: syzbot+b68fbebe56d8362907e8@syzkaller.appspotmail.com
Signed-off-by: Takeshi Misawa <jeantsuru.cumc.mandola@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index ca05b07a45e6..6878da6d15b4 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -285,7 +285,8 @@ int htc_connect_service(struct htc_target *target,
 	if (!time_left) {
 		dev_err(target->dev, "Service connection timeout for: %d\n",
 			service_connreq->service_id);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto err;
 	}
 
 	*conn_rsp_epid = target->conn_rsp_epid;
-- 
2.39.2

