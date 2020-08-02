Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195E123585D
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 18:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHBQSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 12:18:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59340 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727035AbgHBQSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 12:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596385093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=DC5t+PmpRFhs8Bz6/gHStakurAIrA6SZBjJ4584VI1M=;
        b=XpjA2ki34xM75zaB4U7iXkHh+pusQh9P1cxUsjRSICmKmpOXvuoyGEzYKlCrfeD7zzJTlr
        R7wsfwYwvpsO2n1MalNBEgV0eyxHBTsz4VYRYDIX98HGvLigUXAQOEXU36rzOF2lBQam8F
        0YIteQdsspDbBseW5E6ujIxAB06QFkc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Mdl0CNGKNsygQpsgMQyBMQ-1; Sun, 02 Aug 2020 12:18:11 -0400
X-MC-Unique: Mdl0CNGKNsygQpsgMQyBMQ-1
Received: by mail-qt1-f199.google.com with SMTP id n12so7216260qtr.6
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 09:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DC5t+PmpRFhs8Bz6/gHStakurAIrA6SZBjJ4584VI1M=;
        b=Zu5tAbi26+lCtXadkR6M7KXv7s46jLluSkhRXE8zqdrAFHmP9Iul+syZqMxXMbsogW
         jy1aWSSKKbzsrxHvCZ7vP+BlZPIt4aDhDnMIVI5HZcIrSGjsENJmKQHu5TbKhU3JmDMN
         +gCj8vcDB6CI11PueoHPGe06Gl5OMkvVfDEqLzQjKkKuy5+Mno2vhNeQKC+SWQTRQvaO
         f+JR8iRaoxhVQhEdcMEzB7WcSBH9Z2ulKn3HLxhp7weTGTnrOyLCY/MYfJTIgd/G2XLo
         E09dPczlx4Oq9BgWDF36hmRHlM7dmYfNRKXP3ccQ7u1JBsHMEcumRWm2bAQpqkObH0tB
         +FXg==
X-Gm-Message-State: AOAM531+WfrYCuDJSSDagdlQXEQ2BfijISWJVqRXaMxBliCyAkf4Vv+q
        wTxWlUF2o4ysYH1BREDPbA1hIfXDLuboKo/WacSiRXyOJNpv7Z+8RWbHS6AtZoRe12Za/PXVZrh
        uEkSezlfdlLaMasKSs0ZYTuATrkM=
X-Received: by 2002:a37:7245:: with SMTP id n66mr1708751qkc.83.1596385090923;
        Sun, 02 Aug 2020 09:18:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyJG+khVAE61twpw/2VDMswy7YJJ9z/qUZwBj75oPhJFWqmgB2x/V/ktTRJ09btbojwttjIg==
X-Received: by 2002:a37:7245:: with SMTP id n66mr1708726qkc.83.1596385090658;
        Sun, 02 Aug 2020 09:18:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x3sm16790666qkx.3.2020.08.02.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 09:18:10 -0700 (PDT)
From:   trix@redhat.com
To:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, rafal@milecki.pl, tklauser@distanz.ch
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] brcmfmac: check ndev pointer
Date:   Sun,  2 Aug 2020 09:18:04 -0700
Message-Id: <20200802161804.6126-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

brcmfmac/core.c:490:4: warning: Dereference of null pointer
        (*ifp)->ndev->stats.rx_errors++;
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this block of code

	if (ret || !(*ifp) || !(*ifp)->ndev) {
		if (ret != -ENODATA && *ifp)
			(*ifp)->ndev->stats.rx_errors++;
		brcmu_pkt_buf_free_skb(skb);
		return -ENODATA;
	}

(*ifp)->ndev being NULL is caught as an error
But then it is used to report the error.

So add a check before using it.

Fixes: 91b632803ee4 ("brcmfmac: Use net_device_stats from struct net_device")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index f89010a81ffb..aa9ced3c86fb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -486,7 +486,7 @@ static int brcmf_rx_hdrpull(struct brcmf_pub *drvr, struct sk_buff *skb,
 	ret = brcmf_proto_hdrpull(drvr, true, skb, ifp);
 
 	if (ret || !(*ifp) || !(*ifp)->ndev) {
-		if (ret != -ENODATA && *ifp)
+		if (ret != -ENODATA && *ifp && (*ifp)->ndev)
 			(*ifp)->ndev->stats.rx_errors++;
 		brcmu_pkt_buf_free_skb(skb);
 		return -ENODATA;
-- 
2.18.1

