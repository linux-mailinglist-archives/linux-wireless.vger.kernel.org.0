Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51556A2A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfFZNQm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 09:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfFZNQm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 09:16:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1D7F31628F4;
        Wed, 26 Jun 2019 13:16:25 +0000 (UTC)
Received: from ovpn-112-45.rdu2.redhat.com (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3FD55D71C;
        Wed, 26 Jun 2019 13:16:23 +0000 (UTC)
Message-ID: <be491ab35ba46111a1c90cc12b6d5ff6ea3f57e8.camel@redhat.com>
Subject: Re: [PATCH] libertas: Fix a double free in if_spi_c2h_data()
From:   Dan Williams <dcbw@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Philip Rakity <prakity@yahoo.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        libertas-dev@lists.infradead.org
Date:   Wed, 26 Jun 2019 08:16:22 -0500
In-Reply-To: <20190626100926.GD3242@mwanda>
References: <20190626100926.GD3242@mwanda>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 26 Jun 2019 13:16:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-26 at 13:09 +0300, Dan Carpenter wrote:
> The lbs_process_rxed_packet() frees the skb.  It didn't originally,
> but
> we fixed it in commit f54930f36311 ("libertas: don't leak skb on
> receive
> error").
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/marvell/libertas/if_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c
> b/drivers/net/wireless/marvell/libertas/if_spi.c
> index 27067e79e83f..e38f02d1f2e4 100644
> --- a/drivers/net/wireless/marvell/libertas/if_spi.c
> +++ b/drivers/net/wireless/marvell/libertas/if_spi.c
> @@ -772,7 +772,7 @@ static int if_spi_c2h_data(struct if_spi_card
> *card)
>  	/* pass the SKB to libertas */
>  	err = lbs_process_rxed_packet(card->priv, skb);
>  	if (err)
> -		goto free_skb;
> +		goto out;  /* lbs_process_rxed_packet() frees skb */
>  
>  	/* success */
>  	goto out;

It can be further simplified (not compile tested yet):

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

