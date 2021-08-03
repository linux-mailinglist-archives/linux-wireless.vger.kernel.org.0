Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B23DF17A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Aug 2021 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbhHCPaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Aug 2021 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhHCP3E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Aug 2021 11:29:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE4C0617A3;
        Tue,  3 Aug 2021 08:28:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e5so28654560ljp.6;
        Tue, 03 Aug 2021 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TwOok6SlIe634veDmyX3LNd8Ph0M/AVZUIGx8OOoROY=;
        b=CXSo7UfyR03FyZWQU42JJ+dq9Q4vs27piUMRI2s01AcyLNbrsa0pYQoV8pUvXntkEZ
         dPix/VQnVHLeH+WxGWzq7VsVsBwqom8R+shDGis60a8ME9Q4mZezSGzH+5lj+fbHEPtN
         /GmeAKmC6j26DYMmnnrqruztDEfWtCWQL31jI88QJHzWgAPOazC0OADVeCmevIcXGt2k
         3K2C7KlowbpRbuCPK0GxyM5yyG+Fu2Ruosc/Mxv9DsBw2OMKnn+sAzDvs8VmO5sL7l37
         Y2nHO4lJZzVPtYJLh4e9hUPrEAX64+lPeqi1rw1bJARAsc6+57OYC1kJNbFbtfYqpsp/
         aygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwOok6SlIe634veDmyX3LNd8Ph0M/AVZUIGx8OOoROY=;
        b=YIc+myZsOtCwGhh6Smnvhe1FgDWHPOdEZH7KXDrVvCMMiv4qJa8UfV41R4YugkTBKk
         v3b7AyDb3NXqa/Tr9C562qjleXyAIVVMdWY6IWujFc611pd7O+2NaxoRJbPCvxXJueFE
         2szTjJXrcZyEBBbQuQQ+msl5QiNgwpIi+3sPViraIp+ivjQrL23rRVY/rdvJHqo6V8al
         fVEsS0FAAjgFQou++8XFlRRNkTX81ygMKq9PQcrj0CV1o8QrteSp/0/ncZDXArJMriXt
         iXtZyBD1/OO3cW+mijjJ2a8jan3u1geHpdLlz5Lf8BzVORDcNzkb3ofjm0bAIt6wuVko
         USDg==
X-Gm-Message-State: AOAM5326bs9IdpcyMS5g3uY0UcuX12dzwJweF7N/8n7+QXt4wYIhitwa
        fpO76DsWuHuVVLJhUuQ/LBs=
X-Google-Smtp-Source: ABdhPJwG//sZUJqo5xKnG4VDRIrHuwtfxCP2I4JAdh2v1Dj3LotkDPzM4SeKPFYbcsVzkyI38pBKOQ==
X-Received: by 2002:a2e:9954:: with SMTP id r20mr15076307ljj.305.1628004530071;
        Tue, 03 Aug 2021 08:28:50 -0700 (PDT)
Received: from [192.168.2.145] (46-138-51-120.dynamic.spd-mgts.ru. [46.138.51.120])
        by smtp.googlemail.com with ESMTPSA id y11sm213972lfh.185.2021.08.03.08.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 08:28:49 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        phone-devel@vger.kernel.org, newbyte@disroot.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20210711231659.255479-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fca09928-72a8-a573-a862-7c486a2094d6@gmail.com>
Date:   Tue, 3 Aug 2021 18:28:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711231659.255479-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

12.07.2021 02:16, Linus Walleij пишет:
> After some crashes in the 3D engine (!) on the Samsung GT-I8530
> it turns out that the main firmware file can be device dependent,
> something that was previously only handled for the NVRAM
> parameter file.
> 
> Rewrite the code a bit so we can a per-board suffixed firmware
> binary as well, if this does not exist we fall back to the
> canonical firmware name.
> 
> Example: a 4330 device with the OF board compatible is
> "samsung,gavini". We will first try
> "brcmfmac4330-sdio.samsung,gavini.bin" then "brcmfmac4330-sdio.bin"
> if that does not work.
> 
> Cc: phone-devel@vger.kernel.org
> Cc: newbyte@disroot.org
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../broadcom/brcm80211/brcmfmac/firmware.c    | 53 +++++++++++++++----
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index d40104b8df55..adfdfc654b10 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -594,28 +594,47 @@ static int brcmf_fw_complete_request(const struct firmware *fw,
>  	return (cur->flags & BRCMF_FW_REQF_OPTIONAL) ? 0 : ret;
>  }
>  
> +static char *brcm_alt_fw_path(const char *path, const char *board_type)
> +{
> +	char alt_path[BRCMF_FW_NAME_LEN];
> +	char suffix[5];
> +
> +	strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
> +	/* At least one character + suffix */
> +	if (strlen(alt_path) < 5)
> +		return NULL;
> +
> +	/* strip .txt or .bin at the end */
> +	strscpy(suffix, alt_path + strlen(alt_path) - 4, 5);
> +	alt_path[strlen(alt_path) - 4] = 0;
> +	strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
> +	strlcat(alt_path, board_type, BRCMF_FW_NAME_LEN);
> +	strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
> +
> +	return kstrdup(alt_path, GFP_KERNEL);
> +}
> +
>  static int brcmf_fw_request_firmware(const struct firmware **fw,
>  				     struct brcmf_fw *fwctx)
>  {
>  	struct brcmf_fw_item *cur = &fwctx->req->items[fwctx->curpos];
>  	int ret;
>  
> -	/* nvram files are board-specific, first try a board-specific path */
> +	/* Files can be board-specific, first try a board-specific path */
>  	if (cur->type == BRCMF_FW_TYPE_NVRAM && fwctx->req->board_type) {
> -		char alt_path[BRCMF_FW_NAME_LEN];
> +		char *alt_path;
>  
> -		strlcpy(alt_path, cur->path, BRCMF_FW_NAME_LEN);
> -		/* strip .txt at the end */
> -		alt_path[strlen(alt_path) - 4] = 0;
> -		strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
> -		strlcat(alt_path, fwctx->req->board_type, BRCMF_FW_NAME_LEN);
> -		strlcat(alt_path, ".txt", BRCMF_FW_NAME_LEN);
> +		alt_path = brcm_alt_fw_path(cur->path, fwctx->req->board_type);
> +		if (!alt_path)
> +			goto fallback;
>  
>  		ret = request_firmware(fw, alt_path, fwctx->dev);
> +		kfree(alt_path);
>  		if (ret == 0)
>  			return ret;
>  	}
>  
> +fallback:
>  	return request_firmware(fw, cur->path, fwctx->dev);
>  }
>  
> @@ -660,6 +679,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
>  {
>  	struct brcmf_fw_item *first = &req->items[0];
>  	struct brcmf_fw *fwctx;
> +	char *alt_path;
>  	int ret;
>  
>  	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
> @@ -677,9 +697,20 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
>  	fwctx->req = req;
>  	fwctx->done = fw_cb;
>  
> -	ret = request_firmware_nowait(THIS_MODULE, true, first->path,
> -				      fwctx->dev, GFP_KERNEL, fwctx,
> -				      brcmf_fw_request_done);
> +	/* First try alternative board-specific path if any */
> +	alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
> +	if (alt_path) {
> +		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
> +					      fwctx->dev, GFP_KERNEL, fwctx,
> +					      brcmf_fw_request_done);
> +		kfree(alt_path);
> +	}
> +	/* Else try canonical path */
> +	if (ret) {
> +		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
> +					      fwctx->dev, GFP_KERNEL, fwctx,
> +					      brcmf_fw_request_done);
> +	}
>  	if (ret < 0)
>  		brcmf_fw_request_done(NULL, fwctx);
>  
> 

Hi,

I'm getting this error on Nexus 7 (bcm4330) and Acer A500 (bcm4329)
using today's -next, WiFi doesn't work at all:

brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50

Reverting this patch helps, any ideas? Maybe the missing firmware
creates the offending delay somewhere. Adding the per-board FW file
makes WiFi to work, there is no error message.

Linus, have you tested this patch without the per-board file?

BTW, we also need the per-board FW for Nexus 7 because stock bcm4330
firmware doesn't work properly on Nexus. It sees networks, but can't
connect anywhere.

I'm also aware about Lenovo tablet with bcm4330 that doesn't work at all
until Bluetooth FW is loaded. So the FW support status is not ideal yet,
but the per-board FW is a step forward!
