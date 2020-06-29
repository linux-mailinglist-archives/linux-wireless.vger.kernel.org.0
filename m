Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694BA20E13E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 23:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbgF2Uxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgF2TNV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B96C00861F;
        Mon, 29 Jun 2020 03:40:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so12390218edr.9;
        Mon, 29 Jun 2020 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FW5uuzpZIcFHloIfRx2mV3Q4O9gtnLF6GA6PBU0vnk8=;
        b=iqGHhWSblMuDs6IMzv34bSi1zEjJ+bzX0WJoEVJdZL4cCExAUrdJjmtPtPjfoCRhO+
         r4WLmmBS6fP4qQMezE4KKoQGS1BCY08B+N4uAKG0wt0+obJAlOiH7XkWYl74x3/se2dN
         j1IHtoex6TmCkFXVORpDTrZNKYq7FaT+Bn8CtE2ZJrf08o4PXmCF6i9Trb9zlGY4EQdQ
         beq9WOFKSogv7rPW2Vbv5qVwPDadUzb4xojHrRZ1pFPrSAF2ZEIP99a/q5VnR4JdUBw2
         qFp8+l24efMen96u3viwb+IkkbLw1hEirYZmLCugHle5XZOb80DHb4JbOmLlv/RQ+ycF
         c8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FW5uuzpZIcFHloIfRx2mV3Q4O9gtnLF6GA6PBU0vnk8=;
        b=t5fxUeHHGT5x5pBkrmiSjKdPPxePhiID9SFTtZ5SGWTVpS2qYmMsr1NB8GkOVWo6/i
         MRs4QIoXmcif1jvAilHdsHBqOrjDIg19Yv9T5g+mEfgtbP+LQnlGLyBo9zM03Kd1R3IA
         8AWSvFW64n1Tz8v/kDCoW9ygbS07os77WgYkChTdFEc5R3cdCXGN3cBUw44s3+XrQlI+
         zNt2o4DV++dMJ7eTeCH+OWYbk7J4pvqeezsxP4mxuQxmb+h8L/B+j1K+jbZW/Q6iT6qs
         R9p9b+W5v68GOAZnKHdMruCU4DIlkHwwHLSKG0GXxD2gkACvVEwmzT7CMGNRRGxPC6j4
         0Kvw==
X-Gm-Message-State: AOAM533eLOEMCHnIH99mFq3ZWnktCCgnsExn7QmjiHQU1W+uRZpPUjzA
        cqN8t+cCTjyzmW4jNXysHbk=
X-Google-Smtp-Source: ABdhPJx8yG3u2DN7M9KoPEgDVF3CYbC6iiicJVoUyynOlTfr2a28mbHZ6/emmMLVQyv6VCGIT8aO0w==
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr1292645edt.193.1593427213599;
        Mon, 29 Jun 2020 03:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:cb8:1ada:8c2d:413])
        by smtp.gmail.com with ESMTPSA id l4sm7443503edw.10.2020.06.29.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 03:40:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] wilc1000: let wilc_mac_xmit() return NETDEV_TX_OK
Date:   Mon, 29 Jun 2020 12:40:09 +0200
Message-Id: <20200629104009.84077-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <8a2f50dc-2cbe-64e4-438c-4320bb574f4f@microchip.com>
References: <8a2f50dc-2cbe-64e4-438c-4320bb574f4f@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type defining 'NETDEV_TX_OK' but this
driver returns '0' instead of 'NETDEV_TX_OK'.

Fix this by returning 'NETDEV_TX_OK' instead of '0'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index fda0ab97b02c..be3ae5486f44 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
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

