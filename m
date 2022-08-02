Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A96588107
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiHBR3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiHBR3G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 13:29:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DA4AD4F
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 10:29:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 206so9415604pgb.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Aug 2022 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rFx9PAptbdyB41mYU0GhOYU9820TciHP31GrmlGpiTE=;
        b=qFtY1acQ8OdbI3cKY7CHTkYdeB8qC4mmC6i7WpQq59D5cTAr8fKqHCJE910vK9YpkB
         BducnnIExS7FtRuKxNXCxngu58umwXslLONJxkXPEQXuoM5xktUutPtotw0rUfwdKfiC
         Y6WsIgJP1YXphNGXQZVFyISX/xExC9lnvLQwTxXkRHN0CquI0WdryJ6tW/qdCF3/eQlt
         Sp6cCGtE565TRm5x1/YVc7QaUl0E3taNdVow68bC+JW0QR09MBk8okmPjTqPIS4HzBXc
         vjh5ChRjRdID7/nX9ETHdteC/9r11CS4lb19zQ4ob/Syu4KUUVLxr7pGPLfv37wXYMs0
         tTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rFx9PAptbdyB41mYU0GhOYU9820TciHP31GrmlGpiTE=;
        b=ndq1x6gO/TDhJbesIDH3uaZqCkyKiuo0u+7fxpLfHvooK+2ngCu1+G3PLjLJI1jVXK
         7JRB7+l4dgUqA7iW8AhmZTQ8gYz0OgMll39FC+O0iW8kR4pK/VXZXkT4hK8IBZqR3Pq+
         rBLdQ6MTHMCn2MZ+8bQpkVvLcNpsD5RrNgowt2iLf3FoGvguJTaKlkP91HXQIxY0M6T0
         HEuMZmoEqWvEUqArtPybEliK6qhmLoo/Iip1NC/0kwSvRMfrTju8Wo7yRBHgoqVjI0Dz
         db0yz7yHLs7DmmkgFC6NDL+ddxILtY1xVfmzg+OqRRGWs6+/MmikEziNbwRBudXZfkHq
         aM1g==
X-Gm-Message-State: ACgBeo0/EFUtjiCXz6bhfsVbSfZErocJrMpdwhUwwLGVq3hHqKdaAiva
        XORvSi08a51wJUlI3num20rxig==
X-Google-Smtp-Source: AA6agR6bBVaWgCDaV7MHuRHcPbOMIIdsYEF0rSxNmsep83mo4Z9kU70NyKvh15lvVKNddsNPOf4xNQ==
X-Received: by 2002:a63:8242:0:b0:41b:e465:81dd with SMTP id w63-20020a638242000000b0041be46581ddmr11825673pgd.217.1659461345148;
        Tue, 02 Aug 2022 10:29:05 -0700 (PDT)
Received: from coffindebian.corp.matician.com (64-71-25-152.static.wiline.com. [64.71.25.152])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b0016c3affe60esm12339056plg.46.2022.08.02.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:29:04 -0700 (PDT)
From:   Alexander Coffin <alex.coffin@matician.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Alexander Coffin <alex.coffin@matician.com>
Subject: [PATCH] brcmfmac: fix use-after-free bug
Date:   Tue,  2 Aug 2022 10:28:23 -0700
Message-Id: <20220802172823.1696680-2-alex.coffin@matician.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802172823.1696680-1-alex.coffin@matician.com>
References: <20220802172823.1696680-1-alex.coffin@matician.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Alexander Coffin <alex.coffin@matician.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 87aef211b35f..12ee8b7163fd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -296,6 +296,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct ethhdr *eh;
 	int head_delta;
+	unsigned int tx_bytes = skb->len;
 
 	brcmf_dbg(DATA, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
 
@@ -370,7 +371,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 		ndev->stats.tx_dropped++;
 	} else {
 		ndev->stats.tx_packets++;
-		ndev->stats.tx_bytes += skb->len;
+		ndev->stats.tx_bytes += tx_bytes;
 	}
 
 	/* Return ok: we always eat the packet */
-- 
2.30.2

