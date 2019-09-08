Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E577EACB3B
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfIHGch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 02:32:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33048 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfIHGch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 02:32:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id e12so7938980oie.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 23:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dLtjxvefmPsTqwguHpJKZUk+b0qbK0gCwrT3RQ5TPGM=;
        b=ZK30FGYPn3DhY9EPZnYFl4udlxLNfjIbrUAKV9kOguKF3EJMxA4yjKnn9rAZQ7Yg1F
         RnrdtZtuQiORmENPCgWaEnnjDH+i/VGIqpnTDUbvgqTNEab8Yt2KBngTUCWpyAbCt/RY
         QKZylmaPaTpzmou+Z8AGW3PNvAuUJh9u77aJvrhMxj9lhkdSyhi21km4YX3boFHvOpuc
         mQTLdaAaPYYLxfMegV3/2nSuo5+sZvO0nayWc43OHOKEPwBU7oky2Udk9yqdQxe7Pq6Z
         HiEK06nh/NCopBTtkj5dlAWnF74LOJuw5WsLRE+f8NOIogP8wtTJ+yDtxEPPuNcUX0VJ
         6+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dLtjxvefmPsTqwguHpJKZUk+b0qbK0gCwrT3RQ5TPGM=;
        b=PoaEz1wNqRKkKwHENtEbvO3zh37eqqFO5tSNudqnZXXUpQdtbXdK32QRO1fh19c+lR
         F+V90ccj/DXHJ5sbpnxHQ3CZBLMezGeQm5mVHBxcFsHbAgFfNtvAfiRguEeLCOegcdww
         12oz1eOF6fwbcSpXho1l+HmzIHuwTI2algu8lkHqAvjXBoBQAmy13s/QjxZ1wt/N6AXo
         R3Rn8+dQj6q0nCwO852GYsv/j4oYMywI8VIFvnqRCV+Nep5Bd4IXyVXZeb5dQchqObp3
         Wr4qg63Wg1xFzV3gi+tHcKHRbSIg821XDrDVyDVwT+MY9T8lXZ/JhizWQpN6/mHxTdrb
         Eoog==
X-Gm-Message-State: APjAAAVt+Ctan7AGlN7tSRF559QClYK4DIV+pT2xV6NIesHLClumWybx
        FHaIuqvpO7/OzTjXVqg+YmCgtvXyeCy7U2zY7g8=
X-Google-Smtp-Source: APXvYqz2lgth8Eoypm7N796eC0TY7gK5P0AlQD5/piLA1dX+q7sQ8Yzn3oSizx8asZXvVp7w916dY5CIFMCe2DupVP4=
X-Received: by 2002:aca:fdc9:: with SMTP id b192mr12478978oii.50.1567924356321;
 Sat, 07 Sep 2019 23:32:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Sat, 7 Sep 2019 23:32:35 -0700 (PDT)
In-Reply-To: <20190906215423.23589-1-chunkeey@gmail.com>
References: <20190906215423.23589-1-chunkeey@gmail.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Sun, 8 Sep 2019 08:32:35 +0200
Message-ID: <CAKR_QV+y9u_gP_+dZ=bFYJgANeq+W19v9Xx_SwydB5fe4ozhtg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/09/2019, Christian Lamparter <chunkeey@gmail.com> wrote:
> This patch restores the old behavior that read
> the chip_id on the QCA988x before resetting the
> chip. This needs to be done in this order since
> the unsupported QCA988x AR1A chips fall off the
> bus when resetted. Otherwise the next MMIO Op
> after the reset causes a BUS ERROR and panic.
>
> Cc: stable@vger.kernel.org
> Fixes: 1a7fecb766c8 ("ath10k: reset chip before reading chip_id in probe")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/pci.c | 36 +++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c
> b/drivers/net/wireless/ath/ath10k/pci.c
> index a0b4d265c6eb..347bb92e4130 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -3490,7 +3490,7 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
>  	struct ath10k_pci *ar_pci;
>  	enum ath10k_hw_rev hw_rev;
>  	struct ath10k_bus_params bus_params = {};
> -	bool pci_ps;
> +	bool pci_ps, is_qca988x = false;
>  	int (*pci_soft_reset)(struct ath10k *ar);
>  	int (*pci_hard_reset)(struct ath10k *ar);
>  	u32 (*targ_cpu_to_ce_addr)(struct ath10k *ar, u32 addr);
> @@ -3500,6 +3500,7 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
>  	case QCA988X_2_0_DEVICE_ID:
>  		hw_rev = ATH10K_HW_QCA988X;
>  		pci_ps = false;
> +		is_qca988x = true;
>  		pci_soft_reset = ath10k_pci_warm_reset;
>  		pci_hard_reset = ath10k_pci_qca988x_chip_reset;
>  		targ_cpu_to_ce_addr = ath10k_pci_qca988x_targ_cpu_to_ce_addr;
> @@ -3619,25 +3620,34 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
>  		goto err_deinit_irq;
>  	}
>
> +	bus_params.dev_type = ATH10K_DEV_TYPE_LL;
> +	bus_params.link_can_suspend = true;
> +	/* Read CHIP_ID before reset to catch QCA9880-AR1A v1 devices that
> +	 * fall off the bus during chip_reset. These chips have the same pci
> +	 * device id as the QCA9880 BR4A or 2R4E. So that's why the check.
> +	 */
> +	if (is_qca988x) {
> +		bus_params.chip_id =
> +			ath10k_pci_soc_read32(ar, SOC_CHIP_ID_ADDRESS);
> +		if (bus_params.chip_id != 0xffffffff) {
> +			if (!ath10k_pci_chip_is_supported(pdev->device,
> +							  bus_params.chip_id))
> +				goto err_unsupported;
> +		}
> +	}
> +
>  	ret = ath10k_pci_chip_reset(ar);
>  	if (ret) {
>  		ath10k_err(ar, "failed to reset chip: %d\n", ret);
>  		goto err_free_irq;
>  	}
>
> -	bus_params.dev_type = ATH10K_DEV_TYPE_LL;
> -	bus_params.link_can_suspend = true;
>  	bus_params.chip_id = ath10k_pci_soc_read32(ar, SOC_CHIP_ID_ADDRESS);
> -	if (bus_params.chip_id == 0xffffffff) {
> -		ath10k_err(ar, "failed to get chip id\n");
> -		goto err_free_irq;
> -	}
> +	if (bus_params.chip_id == 0xffffffff)
> +		goto err_unsupported;
>
> -	if (!ath10k_pci_chip_is_supported(pdev->device, bus_params.chip_id)) {
> -		ath10k_err(ar, "device %04x with chip_id %08x isn't supported\n",
> -			   pdev->device, bus_params.chip_id);
> +	if (!ath10k_pci_chip_is_supported(pdev->device, bus_params.chip_id))
>  		goto err_free_irq;
> -	}
>
>  	ret = ath10k_core_register(ar, &bus_params);
>  	if (ret) {
> @@ -3647,6 +3657,10 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
>
>  	return 0;
>
> +err_unsupported:
> +	ath10k_err(ar, "device %04x with chip_id %08x isn't supported\n",
> +		   pdev->device, bus_params.chip_id);
> +
>  err_free_irq:
>  	ath10k_pci_free_irq(ar);
>  	ath10k_pci_rx_retry_sync(ar);
> --
> 2.23.0
>
>

Looks fine. For the time being. Have you looked any further to
actually support this chip? It seems warm reset is causing bus errors,
and cold reset goes through without crash.
Firmware gets loaded but is stuck at receiving control response, most
likely because of htc packet length or response message length.
