Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EEA3E03BD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbhHDO5z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDO5z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 10:57:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E61C0613D5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 07:57:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f42so4945826lfv.7
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYWGs8eU0z6/1DWlmjeGv+5E7wOWfIZstGb5/DSqj0g=;
        b=A/2LcYuJVE5qsoWtbJe/xJ9PHzCmwEJYO8L/hsVaR6PnazHFyRmElT9uEvi7CgpOYe
         iy2Q+glmmnOybz0Ju7H4wPT9H5fefc/GBaGs2FjyqnWQffUVY9AEZiNEBuLcLVgRugTL
         PiJDGCIhRN/4FPARqrJGYAF3AmsjzRGhBk+tPucX1RXnMz/VD3e0zgHACatwkJBAdrE1
         5Vqjm6fx+Vbjnh73SBSE2wwWolUEQYyXgJBK6i3f2MCaTD+Ce4tSGMo0KiVcQQfQ72HY
         0kllbwSxA/b3mGzgL/atM02ZtaK48AYSimbluyxgQf9B3zZYaBSkKb+LmNM+FhbpES5L
         uIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYWGs8eU0z6/1DWlmjeGv+5E7wOWfIZstGb5/DSqj0g=;
        b=jRkFGNStZ7kbReTFaBY5AzHFaVTw60FqJ64dT9z7O8pz9r0PHuYXlt/OGqpkQ1gBBV
         NrUbnO/7HTw2A+HO04NmbV4nr5ixuSATCeWwm/A5b2msbWrLBt9sk7jqlQnPnIAaM92M
         zbWQlULqMyg29UqEuveXA7o89kEjpASWyJ0byjMdTGiavVl6jmbhZwEnviSUthUcnHgm
         79yvGCutnxb6WnLGwAK168id3/adfDeQyX5qi+8tfYXDWNB2Q+8iw5Qvqsrf8nd8+R/z
         96DLZ2o4PETdA7Gb72HEoxw2PuWye/Yg+DYQhEgfaw65K9GvS9w66T9KgFlW4i7pnBsL
         aiKA==
X-Gm-Message-State: AOAM5302OJUx7C9T2XjXhr79UFDax+yCSBr9Cct9yS+QipG7HpE/4VL5
        sRXP0414nDd78qrBlY/Iv5s=
X-Google-Smtp-Source: ABdhPJxlhGcWr1T4z1xKaaCRbkL3waPIrIf1ffiby6N+HgO9/O0BLzQLF8nOLzjmSyNt2NuaipSxGQ==
X-Received: by 2002:ac2:5322:: with SMTP id f2mr8954295lfh.429.1628089060923;
        Wed, 04 Aug 2021 07:57:40 -0700 (PDT)
Received: from [192.168.2.145] (46-138-98-74.dynamic.spd-mgts.ru. [46.138.98.74])
        by smtp.googlemail.com with ESMTPSA id i5sm219758lfb.124.2021.08.04.07.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:57:40 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Stefan Hansson <newbyte@disroot.org>
References: <20210803232746.3389570-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <242b823b-627d-de3c-596d-0f13e28ccd47@gmail.com>
Date:   Wed, 4 Aug 2021 17:57:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803232746.3389570-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

04.08.2021 02:27, Linus Walleij пишет:
> The patch that would first try the board-specific firmware
> had a bug because the fallback would not be called: the
> asynchronous interface is used meaning request_firmware_nowait()
> returns 0 immediately.
> 
> Harden the firmware loading like this:
> 
> - If we cannot build an alt_path (like if no board_type is
>   specified) just request the first firmware without any
>   suffix, like in the past.
> 
> - If the lookup of a board specific firmware fails, we get
>   a NULL fw in the async callback, so just try again without
>   the alt_path. Use a static variable to check that we do not
>   try this indefinitely.
> 
> - Rename the brcm_fw_request_done to brcm_fw_request_done_first
>   reflecting the fact that this callback is only used for the
>   first (main) firmware file, and drop the unnecessary
>   prototype.
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Stefan Hansson <newbyte@disroot.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../broadcom/brcm80211/brcmfmac/firmware.c    | 29 +++++++++++++------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index adfdfc654b10..71ca4a517e42 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -431,8 +431,6 @@ struct brcmf_fw {
>  	void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
>  };
>  
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
> -
>  #ifdef CONFIG_EFI
>  /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
>   * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
> @@ -638,11 +636,26 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
>  	return request_firmware(fw, cur->path, fwctx->dev);
>  }
>  
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>  {
>  	struct brcmf_fw *fwctx = ctx;
> +	struct brcmf_fw_item *first = &fwctx->req->items[0];
> +	static bool retry = true;
>  	int ret;
>  
> +	/*Something failed with the first firmware request , such as not

There is a problem with whitespaces here.

> +	 * getting the per-board firmware. Retry this, now using the less
> +	 * specific path for the first firmware item, i.e. without the board
> +	 * suffix.
> +	 */
> +	if (!fw && retry) {
> +		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
> +					      fwctx->dev, GFP_KERNEL, fwctx,
> +					      brcmf_fw_request_done_first);
> +		retry = false;
> +		return;
> +	}
> +
>  	ret = brcmf_fw_complete_request(fw, fwctx);
>  
>  	while (ret == 0 && ++fwctx->curpos < fwctx->req->n_items) {
> @@ -702,17 +715,15 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
>  	if (alt_path) {
>  		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
>  					      fwctx->dev, GFP_KERNEL, fwctx,
> -					      brcmf_fw_request_done);
> +					      brcmf_fw_request_done_first);
>  		kfree(alt_path);
> -	}
> -	/* Else try canonical path */
> -	if (ret) {
> +	} else {
>  		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>  					      fwctx->dev, GFP_KERNEL, fwctx,
> -					      brcmf_fw_request_done);
> +					      brcmf_fw_request_done_first);
>  	}
>  	if (ret < 0)
> -		brcmf_fw_request_done(NULL, fwctx);
> +		brcmf_fw_request_done_first(NULL, fwctx);
>  
>  	return 0;
>  }
> 

Works, thanks!
