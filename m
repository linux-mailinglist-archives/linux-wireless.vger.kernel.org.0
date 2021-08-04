Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA313E0176
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhHDMxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 08:53:18 -0400
Received: from lpdvsmtp11.broadcom.com ([192.19.166.231]:34104 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237536AbhHDMxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 08:53:16 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id ACB452476F;
        Wed,  4 Aug 2021 05:53:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com ACB452476F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1628081583;
        bh=z4s64varXqPrB/Ah1GYt031f9jlBpcvMwZyS8AqsYoE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G1Sr5s30DDofwX/qt8U0gnPYGcxck1ZkdZYjNB2m8lgOeTQkudarVlE8vxL/ieFu+
         H6PtH1yhyfjBXPUAsGNtHsupj1TVuA00dEk8/1vNVLnVPbQ4+HteFzX6hrufcAqJVb
         7TQTC5rkoDt2CJnczZfh0YTdLup0Hi0kVN18b6x8=
Received: from [10.230.42.155] (unknown [10.230.42.155])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id F42191874BD;
        Wed,  4 Aug 2021 05:52:59 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Hansson <newbyte@disroot.org>
References: <20210803232746.3389570-1-linus.walleij@linaro.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <f9fd6e70-783c-8d53-036a-a876ca8c0237@broadcom.com>
Date:   Wed, 4 Aug 2021 14:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210803232746.3389570-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04-08-2021 01:27, Linus Walleij wrote:
> The patch that would first try the board-specific firmware
> had a bug because the fallback would not be called: the
> asynchronous interface is used meaning request_firmware_nowait()
> returns 0 immediately.
> 
> Harden the firmware loading like this:
> 
> - If we cannot build an alt_path (like if no board_type is
>    specified) just request the first firmware without any
>    suffix, like in the past.
> 
> - If the lookup of a board specific firmware fails, we get
>    a NULL fw in the async callback, so just try again without
>    the alt_path. Use a static variable to check that we do not
>    try this indefinitely.
> 
> - Rename the brcm_fw_request_done to brcm_fw_request_done_first
>    reflecting the fact that this callback is only used for the
>    first (main) firmware file, and drop the unnecessary
>    prototype.
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Stefan Hansson <newbyte@disroot.org>

One remark below, but you may add...

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   .../broadcom/brcm80211/brcmfmac/firmware.c    | 29 +++++++++++++------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index adfdfc654b10..71ca4a517e42 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -431,8 +431,6 @@ struct brcmf_fw {
>   	void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
>   };
>   
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
> -
>   #ifdef CONFIG_EFI
>   /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
>    * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
> @@ -638,11 +636,26 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
>   	return request_firmware(fw, cur->path, fwctx->dev);
>   }
>   
> -static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
> +static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
>   {
>   	struct brcmf_fw *fwctx = ctx;
> +	struct brcmf_fw_item *first = &fwctx->req->items[0];
> +	static bool retry = true;

using a static seems tricky to me when there are multiple supported 
devices in a system (like in mine ;-)). Probably better to add the flag 
in struct brcmf_fw.

Regards,
Arend
