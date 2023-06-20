Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37BA737131
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjFTQIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTQIe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 12:08:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548A1AC
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 09:08:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e6541c98so4024927b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687277313; x=1689869313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UugMBbrXbpNr6FVTWuQghLjlVmb0aWMjn3jdyW7ePjo=;
        b=WMjAvrao4hgRMU34vzwb2970KqX5vIyTpUo+S+xXY4Z2Qpy87ncjWyEU+YJRHWd0hd
         IQk0Z5AHZIvNcEU6dfCfUQDcbBTU4Q8wobx5uq4id0xhbLs9ffGEYf+UFdvqaSSgGprq
         pRuSikgFbvbpRJR8S2JoUZDXAIsF7Nymdeoqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687277313; x=1689869313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UugMBbrXbpNr6FVTWuQghLjlVmb0aWMjn3jdyW7ePjo=;
        b=QRPai8X4MPMukMPKDiMhiGMUq57JPGAOAfNZ9eK1BIUjJeGQUGopSx4raJNtOPUlf4
         1w2KSDFzqODetMWGfBXPKisiEltVgje8uTXS8EDgRrkimCt0Zzr/44ihbHRK0FO+JSXA
         V5Gb1OScvkkc6hj/BplFfAnwHLy+waniEzRzC3EEJGgSsX4zD0XTgU6+AldZ0lFv9QmG
         cOnMk2ZGNCqBhMjqGsatQ3k/tO9K53pJWXzou3cR4/LJW5aUljKM9c4s/Zy8sU+sINP9
         x26l6kg6Ot+FEfv7uUiN/0fJLxeocufChE2kSWMouCxS3dnONuErSjfkzQCILQFqLDVn
         7TsQ==
X-Gm-Message-State: AC+VfDztCq4aI/pAaWykmKNVZYzFJp8VYe3YVa+OotyHnbhgBgL3cqj8
        lwlK89riczA2BljP+JtzoBqEurC9a72+9sIDDK4=
X-Google-Smtp-Source: ACHHUZ6mi8F7FWDY7IM9gn8O+AgLQ7ydOQG7OZv28ca4Vx6VFW18aW+f0EnWxCDhJ/IN5g9HOX1mSg==
X-Received: by 2002:a05:6a00:a86:b0:666:7ec0:22d7 with SMTP id b6-20020a056a000a8600b006667ec022d7mr19176336pfl.24.1687277312794;
        Tue, 20 Jun 2023 09:08:32 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:64b6:fe8c:2779:6abf])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b0066a2e8431a0sm391127pfn.183.2023.06.20.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:08:32 -0700 (PDT)
Date:   Tue, 20 Jun 2023 09:08:30 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] wifi: mwifiex: avoid strlcpy() and use
 strscpy() where appropriate
Message-ID: <ZJHO/pa7JB49j3rN@google.com>
References: <20230620100803.519926-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620100803.519926-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 20, 2023 at 01:07:36PM +0300, Dmitry Antipov wrote:
> Prefer 'strscpy()' over unsafe 'strlcpy()' and 'strcpy()' in
> 'mwifiex_init_hw_fw()' and 'mwifiex_register_dev()', respectively.
> All other calls to 'strcpy(adapter->name, ...)' should be safe
> because the firmware name is a compile-time constant of known
> length and so guaranteed to fit into a destination buffer.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.c | 11 +++--------
>  drivers/net/wireless/marvell/mwifiex/sdio.c |  4 +++-
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index ea22a08e6c08..64512b00e8b5 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -724,14 +724,9 @@ static int mwifiex_init_hw_fw(struct mwifiex_adapter *adapter,
>  	/* Override default firmware with manufacturing one if
>  	 * manufacturing mode is enabled
>  	 */
> -	if (mfg_mode) {
> -		if (strlcpy(adapter->fw_name, MFG_FIRMWARE,
> -			    sizeof(adapter->fw_name)) >=
> -			    sizeof(adapter->fw_name)) {
> -			pr_err("%s: fw_name too long!\n", __func__);
> -			return -1;
> -		}
> -	}
> +	if (mfg_mode)
> +		strscpy(adapter->fw_name, MFG_FIRMWARE,
> +			sizeof(adapter->fw_name));

I'm not sure how a compile-time constant makes this "unsafe" at all, but
if you feel the need to change this, then sure, this works too.

>  
>  	if (req_fw_nowait) {
>  		ret = request_firmware_nowait(THIS_MODULE, 1, adapter->fw_name,
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index a24bd40dd41a..a5d3128d7922 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -2483,7 +2483,9 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
>  		if ((val & card->reg->host_strap_mask) == card->reg->host_strap_value)
>  			firmware = card->firmware_sdiouart;
>  	}
> -	strcpy(adapter->fw_name, firmware);
> +	ret = strscpy(adapter->fw_name, firmware, sizeof(adapter->fw_name));

FWIW, this 'firmware' pointer is all derived from compile-time constants
too. So the commit messages seems misleading ("all other calls [...]
should be safe" --> well, *all* calls are safe). But the changes are all
fine, so:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> +	if (ret < 0)
> +		return ret;
>  
>  	if (card->fw_dump_enh) {
>  		adapter->mem_type_mapping_tbl = generic_mem_type_map;
> -- 
> 2.41.0
> 
