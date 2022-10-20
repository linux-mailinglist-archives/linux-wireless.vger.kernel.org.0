Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69F4605A09
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJTIjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 04:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJTIjT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 04:39:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E818C96B
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 01:39:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b4so33133227wrs.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYiaRsw3d498ajPipBA6kI+35MHXcbys3QG+Erur9Ew=;
        b=LUK6bvoalZarG4/10cYHOZVvkyeNt2lEqUWhowXbLcD+qkR3buH7JhF5yXgOoCVdBp
         O7OXVaFRdd4eOy/68sUTshux6qDWvyS/aGhCNkl/WOh4rmEr5KUVje9avyZkK125rG+V
         9Z8Gg27p8EeCJWVHvOfGNHxCqvRTKbPJvx+jT1y1f5nFBiw0s8vHuw+cS+2jturqdUpq
         qcA5aUtiWY/6Mv67KNy8Xnxo27MpcB5VavrSk0QmUPf3LiWtAng66627xFQD9+lDAZVu
         s7TsegWqJoTM17tKQ1enaiBmypeI52CwuresDKCbQBbTv/NyLCzn3CzLtV+QUJnl03oB
         pfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYiaRsw3d498ajPipBA6kI+35MHXcbys3QG+Erur9Ew=;
        b=bLRhTsjRUae82mZtuag4D64XwI9b9AVUFbIyA6pTihMN3AzojBUd8QydRLAjwWuqxs
         FOZBI3cUs8eTaCTEcMhq1kImCj4mLCXbwu6cHDNei+pI+TpqPuTQTwT4bxvi5xJ6/5Ef
         URJpqZfA5lwNLPQb3Ge1O9bKzwE7vspEUnvlNEQ6wUsT6rXKD9WcHrW9rPz5T+ZFS4hF
         sMSOYJXyG1+axJg5t1OVBvQLDXzSF+pNXftcpwr9t7G7fNW/zh+Ue1c9k0lyi+52qrF3
         jRx2aYFnal16iTxJ//lRpzU+OT5uhOcTJueEK4r2rE85Fqm+t5Z9sPSdNB2p5YKCzSKN
         906A==
X-Gm-Message-State: ACrzQf13dyeK5KQWfMVcjIPNr2JF/yVRp9eZIIGTHW5c6fKGXugoZZhl
        ivEj6weQvA6kLpH+xIn4D4XkbfXWfyqAoUXb
X-Google-Smtp-Source: AMsMyM7jZWw7vWX/+/eoA9x8P2bxtDrEuqS7UMYLzznoyZoJS7iPnhqACqXDq+aEm8Hrq04fjOECIw==
X-Received: by 2002:adf:c601:0:b0:230:7cfa:b3fe with SMTP id n1-20020adfc601000000b002307cfab3femr7725303wrg.344.1666255155871;
        Thu, 20 Oct 2022 01:39:15 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b00225307f43fbsm15987886wrr.44.2022.10.20.01.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:39:15 -0700 (PDT)
Message-ID: <649de84e-6f9a-5c6b-9a94-a7c6462abd1f@gmail.com>
Date:   Thu, 20 Oct 2022 10:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] brcmfmac: Fixes potential buffer overflow in
 'brcmf_fweh_event_worker'
Content-Language: en-US
To:     Dokyung Song <dokyung.song@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
References: <20221020014907.GA338234@laguna>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20221020014907.GA338234@laguna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/20/2022 3:49 AM, Dokyung Song wrote:
> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
> when the device provides a 'bsscfgidx' equal to or greater than the
> buffer size. The patch adds a check that leads to a safe failure if that
> is the case.
> 
> Found by a modified version of syzkaller.
> 
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> index 52 is out of range for type 'brcmf_if *[16]'
> CPU: 0 PID: 1898 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132

[...]

> Kernel panic - not syncing: Fatal exception
> 
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>

Not sure what the rules are for using 'Reported-by' tag, but it looks a 
bit odd. I leave it to the wireless maintainer.

Reviewed-by: Arend van Spriel <aspriel@gmail.com>
> Signed-off-by: Dokyung Song <dokyung.song@gmail.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> index bc3f4e4edcdf..e035e9c5a1fa 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> @@ -255,10 +255,15 @@ static void brcmf_fweh_event_worker(struct work_struct *work)
>   			goto event_free;
>   		}
>   
> -		if (event->code == BRCMF_E_TDLS_PEER_EVENT)
> +		if (event->code == BRCMF_E_TDLS_PEER_EVENT) {
>   			ifp = drvr->iflist[0];
> -		else
> +		} else {
> +			if (emsg.bsscfgidx >= BRCMF_MAX_IFS) {
> +				bphy_err(drvr, "invalid bsscfg index: %u\n", emsg.bsscfgidx);
> +				goto event_free;
> +			}

probably better to do the validation before any other handling. So right 
after converting the event message at line 245

https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c#L245

>   			ifp = drvr->iflist[emsg.bsscfgidx];
> +		}
>   		err = brcmf_fweh_call_event_handler(drvr, ifp, event->code,
>   						    &emsg, event->data);
>   		if (err) {
