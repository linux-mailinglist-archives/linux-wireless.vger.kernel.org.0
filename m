Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8C60A86
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2019 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfGEQm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jul 2019 12:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbfGEQmz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5AA613AAE;
        Fri,  5 Jul 2019 16:42:54 +0000 (UTC)
Received: from ovpn-112-42.rdu2.redhat.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3A5884774;
        Fri,  5 Jul 2019 16:42:50 +0000 (UTC)
Message-ID: <ee4472e4728becc9713962ba264742cb1f337098.camel@redhat.com>
Subject: [PATCH v2] libertas: Fix a double free in if_spi_c2h_data()
From:   Dan Williams <dcbw@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Philip Rakity <prakity@yahoo.com>,
        libertas-dev@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Allison Randal <allison@lohutok.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Fri, 05 Jul 2019 11:42:48 -0500
In-Reply-To: <e679c9f99d6952f82924c71f036e4a196d0e72d4.camel@redhat.com>
References: <20190626100926.GD3242@mwanda>
         <be491ab35ba46111a1c90cc12b6d5ff6ea3f57e8.camel@redhat.com>
         <20190626132340.GE28859@kadam>
         <e679c9f99d6952f82924c71f036e4a196d0e72d4.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 05 Jul 2019 16:42:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The lbs_process_rxed_packet() frees the skb.  It didn't originally, but
we fixed it in commit f54930f36311 ("libertas: don't leak skb on receive
error").

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dan Williams <dcbw@redhat.com>
---
 drivers/net/wireless/marvell/libertas/if_spi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index 27067e79e83fe..072da89c4986f 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -766,19 +766,15 @@ static int if_spi_c2h_data(struct if_spi_card *card)
 
 	/* Read the data from the WLAN module into our skb... */
 	err = spu_read(card, IF_SPI_DATA_RDWRPORT_REG, data, ALIGN(len, 4));
-	if (err)
-		goto free_skb;
+	if (err) {
+		dev_kfree_skb(skb);
+		goto out
+	}
 
 	/* pass the SKB to libertas */
 	err = lbs_process_rxed_packet(card->priv, skb);
-	if (err)
-		goto free_skb;
+	/* lbs_process_rxed_packet() consumes the skb */
 
-	/* success */
-	goto out;
-
-free_skb:
-	dev_kfree_skb(skb);
 out:
 	if (err)
 		netdev_err(priv->dev, "%s: err=%d\n", __func__, err);
-- 
2.20.1

