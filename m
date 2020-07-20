Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3018B2258A1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGTHbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 03:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTHbs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 03:31:48 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BD62073A;
        Mon, 20 Jul 2020 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595230308;
        bh=8tNqHuq/YTE6AuI4A6xYiMIsgdqAFlhpTpxa1XaFIPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/y6UUY9EaMj9ZG6LyfK4YvFpSaaBJoKTWr/vNq+oATx4um0coFnZmcptX3IGoiDD
         6RUmyWvMKYOj2Eokd+Ikjh38ZD2o5m11mCSt3jB0xkkkkBGKtP6AV4qrDxbwDIMx8Y
         KTNk0X7UpiI/upU0wGSj/QE7O4JdQTjsypMezdJ4=
Received: by pali.im (Postfix)
        id E831F778; Mon, 20 Jul 2020 09:31:45 +0200 (CEST)
Date:   Mon, 20 Jul 2020 09:31:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, ulf.hansson@linaro.org
Subject: Re: [PATCH] wilc1000: Move wilc1000 SDIO ID's from driver source to
 common header file
Message-ID: <20200720073145.3poujatb562cyoig@pali>
References: <20200717051134.19160-1-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717051134.19160-1-ajay.kathat@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 17 July 2020 05:11:38 Ajay.Kathat@microchip.com wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Moved macros used for Vendor/Device ID from wilc1000 driver to common
> header file and changed macro name for consistency with other macros.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/net/wireless/microchip/wilc1000/sdio.c | 6 ++----
>  include/linux/mmc/sdio_ids.h                   | 3 +++
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 36eb589263bf..3ece7b0b0392 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/mmc/sdio_func.h>
> +#include <linux/mmc/sdio_ids.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/of_irq.h>
> @@ -15,11 +16,8 @@
>  
>  #define SDIO_MODALIAS "wilc1000_sdio"
>  
> -#define SDIO_VENDOR_ID_WILC 0x0296
> -#define SDIO_DEVICE_ID_WILC 0x5347
> -
>  static const struct sdio_device_id wilc_sdio_ids[] = {
> -	{ SDIO_DEVICE(SDIO_VENDOR_ID_WILC, SDIO_DEVICE_ID_WILC) },
> +	{ SDIO_DEVICE(SDIO_VENDOR_ID_MICROCHIP_WILC, SDIO_DEVICE_ID_MICROCHIP_WILC1000) },
>  	{ },
>  };
>  
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 15ed8ce9d394..519820d18e62 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -105,6 +105,9 @@
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
>  
> +#define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
> +#define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
> +
>  #define SDIO_VENDOR_ID_SIANO			0x039a
>  #define SDIO_DEVICE_ID_SIANO_NOVA_B0		0x0201
>  #define SDIO_DEVICE_ID_SIANO_NICE		0x0202
> -- 
> 2.24.0
