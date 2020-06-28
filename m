Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F320C99E
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgF1Scm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1Scm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 14:32:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCB1C03E979;
        Sun, 28 Jun 2020 11:32:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so14378640ejn.10;
        Sun, 28 Jun 2020 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/AWghi0ggAWezCdD0yzAwGjS2bjfVCfdqGQLJ4bXU8=;
        b=nx+0kA+ECOlB14AL7pgiSQnrsiMxEe8HCxwIzpw2ZGRZowJfqoNOtpp4pqy2G/GB6j
         deCGnBoDWpT4ikeuzV7fKfcpkUEp8TkaA2Y3TXvFf67w5CVhsD5dEZhkWCsjjLBxDXRL
         z6+l3hUPdMtICfRpl+DLSCiKu4qCwytIdgzaU9mz1RMzLYFGh7acjLXtsqG0S4gSh9wp
         EwXV8YyDfU6vbcvK+YxLVvx/UmGy0VeY8kwKXVrLDHzTUMNpzEVKmoge2UrFuTTQmJMv
         b6oKji/Su81LhtZgzkiY3ax25ipANws3bsyOPolbymdqYSHBdM67i4mSsRKxju0eqTtx
         4m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/AWghi0ggAWezCdD0yzAwGjS2bjfVCfdqGQLJ4bXU8=;
        b=DX4I/BLnP9vcMPOgKc0jVHBAS8kUFmQZfmJPIJOQONdSp9/074RbRjIyjeMsOfx45P
         3o4v/tOQtzNZfi/Cu/xK3XsOh54v2kuct6uxsdKC6uBP1/y/6Y0ibM8V6pGtbSpKfH49
         CBh8xhWoDn1ugcC5Wj/s9jC8+k5ApohleuCcBGRSwk8fOQMIUQegiUUIwG3sXxbSj0dS
         LbR3gBXZrLcrc6zbIRz+joeqPT/lfO63gLptcqzitsv157HK+xfJ8c8A5o01CeUz0TCI
         SnTJYACnzBegfUXJQWJJ18jTDfE1INVthgeX8+QwxXYTsPPxCsr2VM6mc27pDu2DZc/1
         /6Hg==
X-Gm-Message-State: AOAM533TSGiwFJFk+sRMkPzLzWyAVZO4t3z5qtbyleTEE97voffqMdUK
        EHPeYF02pZHSTA3pjcGqK40=
X-Google-Smtp-Source: ABdhPJyvwPcq95vvTuR+o/TTUFOP15mBB7xzZmq1WM82o9xgVvgxv4b43wqxyszfzIqe0nboQmjAdw==
X-Received: by 2002:a17:906:2b0e:: with SMTP id a14mr10659475ejg.459.1593369160913;
        Sun, 28 Jun 2020 11:32:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:f145:9a83:6418:5a5c])
        by smtp.gmail.com with ESMTPSA id v5sm7349888ejj.61.2020.06.28.11.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:32:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] staging/wilc1000: let wilc_mac_xmit() to NETDEV_TX_OK
Date:   Sun, 28 Jun 2020 20:32:37 +0200
Message-Id: <20200628183237.74749-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type defining 'NETDEV_TX_OK' but this
driver returns '0' instead of 'NETDEV_TX_OK'.

Fix this by returning ''NETDEV_TX_OK' instead of 0.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/staging/wilc1000/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/netdev.c
index fda0ab97b02c..be3ae5486f44 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -678,14 +678,14 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	if (skb->dev != ndev) {
 		netdev_err(ndev, "Packet not destined to this device\n");
-		return 0;
+		return NETDEV_TX_OK;
 	}
 
 	tx_data = kmalloc(sizeof(*tx_data), GFP_ATOMIC);
 	if (!tx_data) {
 		dev_kfree_skb(skb);
 		netif_wake_queue(ndev);
-		return 0;
+		return NETDEV_TX_OK;
 	}
 
 	tx_data->buff = skb->data;
@@ -710,7 +710,7 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 		srcu_read_unlock(&wilc->srcu, srcu_idx);
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 static int wilc_mac_close(struct net_device *ndev)
-- 
2.27.0

