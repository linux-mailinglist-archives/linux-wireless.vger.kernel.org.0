Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF20589D72
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiHDOZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 10:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHDOZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 10:25:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B8BC7
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 07:25:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 89FA322247;
        Thu,  4 Aug 2022 16:25:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659623110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yfuFViu5HFr/eP33MvXMlLxNptspuGEzwWameXix/o=;
        b=NRnqIo9o+hLOZasJhGdr2NQKgYoiy5OdL8L7nfkWIN9TN/x8Zzvz7Sy4NH3dg3oBmi0FJM
        1dlGQCdjXYC5Qr0Y18KJCOzSw0I27rasHpdoWbpvbUwBXi42eqpxCD0Z590/u0VZEq/8Qd
        MKYM/ziGt0nTCOmqgK87Xa3b0ZnEVyA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Aug 2022 16:25:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, mwalle@kernel.org
Subject: Re: [PATCH] wifi: wilc1000: fix DMA on stack objects
In-Reply-To: <20220804131837.336769-1-ajay.kathat@microchip.com>
References: <20220804131837.336769-1-ajay.kathat@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f25d53c4fe90b2ef153a721bd225f8db@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

thanks for the patch!

Am 2022-08-04 15:18, schrieb Ajay.Kathat@microchip.com:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Sometimes 'wilc_sdio_cmd53' is called with addresses pointing to an
> object on the stack. Use dynamically allocated memory for cmd53 instead
> of stack address which is not DMA'able.
> 
> Fixes: 5625f965d764 ("wilc1000: move wilc driver out of staging")
> Reported-by: Michael Walle <mwalle@kernel.org>
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
> 
> This patch is created based on [1] and changes are done as discussed in
> the same thread.
> 
> [1].
> https://patchwork.kernel.org/project/linux-wireless/patch/20220728152037.386543-1-michael@walle.cc/
> 
>  .../net/wireless/microchip/wilc1000/netdev.h  |  1 +
>  .../net/wireless/microchip/wilc1000/sdio.c    | 23 +++++++++++++++----
>  .../net/wireless/microchip/wilc1000/wlan.c    |  2 +-
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h
> b/drivers/net/wireless/microchip/wilc1000/netdev.h
> index 43c085c74b7a..2137ef294953 100644
> --- a/drivers/net/wireless/microchip/wilc1000/netdev.h
> +++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
> @@ -245,6 +245,7 @@ struct wilc {
>  	u8 *rx_buffer;
>  	u32 rx_buffer_offset;
>  	u8 *tx_buffer;
> +	u32 vmm_table[WILC_VMM_TBL_SIZE];

Shouldn't this be "u32 *vmm_table" judging by the
other members of this structure.

>  	struct txq_handle txq[NQUEUES];
>  	int txq_entries;
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c
> b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 600cc57e9da2..8bb0b8e189af 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -28,6 +28,7 @@ struct wilc_sdio {
>  	u32 block_size;
>  	bool isinit;
>  	int has_thrpt_enh3;
> +	u8 *cmd53_buf;
>  };
> 
>  struct sdio_cmd52 {
> @@ -128,10 +129,16 @@ static int wilc_sdio_probe(struct sdio_func 
> *func,
>  	if (!sdio_priv)
>  		return -ENOMEM;
> 
> +	sdio_priv->cmd53_buf = kzalloc(sizeof(u32), GFP_KERNEL);
> +	if (!sdio_priv->cmd53_buf) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
>  	ret = wilc_cfg80211_init(&wilc, &func->dev, WILC_HIF_SDIO,
>  				 &wilc_hif_sdio);
>  	if (ret)
> -		goto free;

just use "goto free;". kfree(NULL) is a noop.

> +		goto free_buffer;
> 
>  	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
>  		struct device_node *np = func->card->dev.of_node;
> @@ -160,6 +167,8 @@ static int wilc_sdio_probe(struct sdio_func *func,
>  dispose_irq:
>  	irq_dispose_mapping(wilc->dev_irq_num);
>  	wilc_netdev_cleanup(wilc);
> +free_buffer:
> +	kfree(sdio_priv->cmd53_buf);
>  free:
>  	kfree(sdio_priv);
>  	return ret;
> @@ -172,6 +181,7 @@ static void wilc_sdio_remove(struct sdio_func 
> *func)
> 
>  	clk_disable_unprepare(wilc->rtc_clk);
>  	wilc_netdev_cleanup(wilc);
> +	kfree(sdio_priv->cmd53_buf);
>  	kfree(sdio_priv);
>  }
> 
> @@ -375,8 +385,10 @@ static int wilc_sdio_write_reg(struct wilc *wilc,
> u32 addr, u32 data)
>  		cmd.address = WILC_SDIO_FBR_DATA_REG;
>  		cmd.block_mode = 0;
>  		cmd.increment = 1;
> -		cmd.count = 4;
> -		cmd.buffer = (u8 *)&data;
> +		cmd.count = sizeof(u32);
> +		/* copy to a bounce buffer to avoid use of stack variable */
> +		memcpy(sdio_priv->cmd53_buf, &data, sizeof(u32));

Locking seems to be missing, no? How is sdio_priv->cmd53_buf
protected from parallel access?

-michael

> +		cmd.buffer = sdio_priv->cmd53_buf;
>  		cmd.block_size = sdio_priv->block_size;
>  		ret = wilc_sdio_cmd53(wilc, &cmd);
>  		if (ret)
> @@ -492,8 +504,8 @@ static int wilc_sdio_read_reg(struct wilc *wilc,
> u32 addr, u32 *data)
>  		cmd.address = WILC_SDIO_FBR_DATA_REG;
>  		cmd.block_mode = 0;
>  		cmd.increment = 1;
> -		cmd.count = 4;
> -		cmd.buffer = (u8 *)data;
> +		cmd.count = sizeof(u32);
> +		cmd.buffer = sdio_priv->cmd53_buf;
> 
>  		cmd.block_size = sdio_priv->block_size;
>  		ret = wilc_sdio_cmd53(wilc, &cmd);
> @@ -502,6 +514,7 @@ static int wilc_sdio_read_reg(struct wilc *wilc,
> u32 addr, u32 *data)
>  				"Failed cmd53, read reg (%08x)...\n", addr);
>  			return ret;
>  		}
> +		memcpy(data, sdio_priv->cmd53_buf, sizeof(u32));
>  	}
> 
>  	le32_to_cpus(data);
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c
> b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 947d9a0a494e..0576d865c603 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -714,7 +714,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 
> *txq_count)
>  	int ret = 0;
>  	int counter;
>  	int timeout;
> -	u32 vmm_table[WILC_VMM_TBL_SIZE];
> +	u32 *vmm_table = wilc->vmm_table;
>  	u8 ac_pkt_num_to_chip[NQUEUES] = {0, 0, 0, 0};
>  	const struct wilc_hif_func *func;
>  	int srcu_idx;
