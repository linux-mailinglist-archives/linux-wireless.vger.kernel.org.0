Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBA58A7C1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbiHEIHG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 04:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiHEIHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 04:07:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB54167FD
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 01:07:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4C7CB221D4;
        Fri,  5 Aug 2022 10:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659686819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmO2zInorR+Uw5TVmDdlc/UfQw8LWPfbiUhAbr5M1tI=;
        b=gEk4M4+kbB9ehsiyyFV5Xr+LR/FJXwgPZ/CaClAOe9QAQW5agErPx0Yv347iiv7Wj5V8UJ
        e2Wo4KEXaCZ/pPR0FOFKURCYK0hoiQ/rhj336YQrlLji26X6xfy58FfekLiWUJOUUNZx2/
        XCwJns1IQnr72LOOqEA6SrFU+kp45ug=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Aug 2022 10:06:58 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, mwalle@kernel.org
Subject: Re: [PATCH v2] wifi: wilc1000: fix DMA on stack objects
In-Reply-To: <20220804181340.365429-1-ajay.kathat@microchip.com>
References: <20220804181340.365429-1-ajay.kathat@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a80d8d050ba3bf873deceb73af5a377d@walle.cc>
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

Am 2022-08-04 20:13, schrieb Ajay.Kathat@microchip.com:
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
> This patch is created based on [1] and changes are done as discussed in
> the same thread.
> 
> [1].
> https://patchwork.kernel.org/project/linux-wireless/patch/20220728152037.386543-1-michael@walle.cc/
> 
> changes since v1:
>         - add 'use_global_buf' variable to know when to use bounce 
> buffer
>         - remove unnecessary goto label
> 	- dynamically allocate 'vmm_table'
> 
>  .../net/wireless/microchip/wilc1000/netdev.h  |  1 +
>  .../net/wireless/microchip/wilc1000/sdio.c    | 35 +++++++++++++++----
>  .../net/wireless/microchip/wilc1000/wlan.c    | 15 ++++++--
>  3 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h
> b/drivers/net/wireless/microchip/wilc1000/netdev.h
> index 43c085c74b7a..bb1a315a7b7e 100644
> --- a/drivers/net/wireless/microchip/wilc1000/netdev.h
> +++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
> @@ -245,6 +245,7 @@ struct wilc {
>  	u8 *rx_buffer;
>  	u32 rx_buffer_offset;
>  	u8 *tx_buffer;
> +	u32 *vmm_table;
> 
>  	struct txq_handle txq[NQUEUES];
>  	int txq_entries;
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c
> b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 600cc57e9da2..b12f411aec06 100644
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
> @@ -47,6 +48,7 @@ struct sdio_cmd53 {
>  	u32 count:		9;
>  	u8 *buffer;
>  	u32 block_size;
> +	u8 use_global_buf;

bool

>  };
> 
>  static const struct wilc_hif_func wilc_hif_sdio;
> @@ -91,6 +93,8 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct
> sdio_cmd53 *cmd)
>  {
>  	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, 
> dev);
>  	int size, ret;
> +	struct wilc_sdio *sdio_priv = wilc->bus_data;
> +	u8 *buf = cmd->buffer;
> 
>  	sdio_claim_host(func);
> 
> @@ -101,12 +105,19 @@ static int wilc_sdio_cmd53(struct wilc *wilc,
> struct sdio_cmd53 *cmd)
>  	else
>  		size = cmd->count;
> 
> +	if (cmd->use_global_buf)
> +		buf = sdio_priv->cmd53_buf;

There is no check if the size fits into the buffer. So maybe:

if (size > sizeof(u32))
   return -EINVAL;

> +
>  	if (cmd->read_write) {  /* write */
> -		ret = sdio_memcpy_toio(func, cmd->address,
> -				       (void *)cmd->buffer, size);
> +		if (cmd->use_global_buf)
> +			memcpy(buf, cmd->buffer, size);
> +
> +		ret = sdio_memcpy_toio(func, cmd->address, buf, size);
>  	} else {        /* read */
> -		ret = sdio_memcpy_fromio(func, (void *)cmd->buffer,
> -					 cmd->address,  size);
> +		ret = sdio_memcpy_fromio(func, buf, cmd->address, size);
> +
> +		if (cmd->use_global_buf)
> +			memcpy(cmd->buffer, buf, size);
>  	}
> 
>  	sdio_release_host(func);
> @@ -128,6 +139,12 @@ static int wilc_sdio_probe(struct sdio_func *func,
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
> @@ -161,6 +178,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
>  	irq_dispose_mapping(wilc->dev_irq_num);
>  	wilc_netdev_cleanup(wilc);
>  free:
> +	kfree(sdio_priv->cmd53_buf);
>  	kfree(sdio_priv);
>  	return ret;
>  }
> @@ -172,6 +190,7 @@ static void wilc_sdio_remove(struct sdio_func 
> *func)
> 
>  	clk_disable_unprepare(wilc->rtc_clk);
>  	wilc_netdev_cleanup(wilc);
> +	kfree(sdio_priv->cmd53_buf);
>  	kfree(sdio_priv);
>  }
> 
> @@ -375,8 +394,9 @@ static int wilc_sdio_write_reg(struct wilc *wilc,
> u32 addr, u32 data)
>  		cmd.address = WILC_SDIO_FBR_DATA_REG;
>  		cmd.block_mode = 0;
>  		cmd.increment = 1;
> -		cmd.count = 4;
> +		cmd.count = sizeof(u32);
>  		cmd.buffer = (u8 *)&data;
> +		cmd.use_global_buf = 1;

true

>  		cmd.block_size = sdio_priv->block_size;
>  		ret = wilc_sdio_cmd53(wilc, &cmd);
>  		if (ret)
> @@ -414,6 +434,7 @@ static int wilc_sdio_write(struct wilc *wilc, u32
> addr, u8 *buf, u32 size)
>  	nblk = size / block_size;
>  	nleft = size % block_size;
> 
> +	cmd.use_global_buf = 0;
>  	if (nblk > 0) {
>  		cmd.block_mode = 1;
>  		cmd.increment = 1;
> @@ -492,8 +513,9 @@ static int wilc_sdio_read_reg(struct wilc *wilc,
> u32 addr, u32 *data)
>  		cmd.address = WILC_SDIO_FBR_DATA_REG;
>  		cmd.block_mode = 0;
>  		cmd.increment = 1;
> -		cmd.count = 4;
> +		cmd.count = sizeof(u32);
>  		cmd.buffer = (u8 *)data;
> +		cmd.use_global_buf = 1;

true

> 
>  		cmd.block_size = sdio_priv->block_size;
>  		ret = wilc_sdio_cmd53(wilc, &cmd);
> @@ -535,6 +557,7 @@ static int wilc_sdio_read(struct wilc *wilc, u32
> addr, u8 *buf, u32 size)
>  	nblk = size / block_size;
>  	nleft = size % block_size;
> 
> +	cmd.use_global_buf = 0;

false

>  	if (nblk > 0) {
>  		cmd.block_mode = 1;
>  		cmd.increment = 1;
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c
> b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 947d9a0a494e..58bbf50081e4 100644
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
> @@ -1252,6 +1252,8 @@ void wilc_wlan_cleanup(struct net_device *dev)
>  	while ((rqe = wilc_wlan_rxq_remove(wilc)))
>  		kfree(rqe);
> 
> +	kfree(wilc->vmm_table);
> +	wilc->vmm_table = NULL;
>  	kfree(wilc->rx_buffer);
>  	wilc->rx_buffer = NULL;
>  	kfree(wilc->tx_buffer);
> @@ -1489,6 +1491,14 @@ int wilc_wlan_init(struct net_device *dev)
>  			goto fail;
>  	}
> 
> +	if (!wilc->vmm_table)
> +		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
> +
> +	if (!wilc->vmm_table) {
> +		ret = -ENOBUFS;
> +		goto fail;
> +	}
> +
>  	if (!wilc->tx_buffer)
>  		wilc->tx_buffer = kmalloc(WILC_TX_BUFF_SIZE, GFP_KERNEL);
> 
> @@ -1513,7 +1523,8 @@ int wilc_wlan_init(struct net_device *dev)
>  	return 0;
> 
>  fail:
> -
> +	kfree(wilc->vmm_table);
> +	wilc->vmm_table = NULL;
>  	kfree(wilc->rx_buffer);
>  	wilc->rx_buffer = NULL;
>  	kfree(wilc->tx_buffer);

-- 
-michael
