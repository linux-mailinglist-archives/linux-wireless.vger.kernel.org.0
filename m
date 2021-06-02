Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB4398D84
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFBO62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 10:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231222AbhFBO61 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 10:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622645804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TMcD5cH8Gq97lrhqQCtDsFyiGiLKX1rySB5M/G3UShE=;
        b=YZ7mnP8zT55k8RQDTHuUIHpY4ix65F62WA5beEjKyJ8AY7wl5sMI/asqNX4sf6Bqn8UDiz
        LAFPd1lYvRd6Q8DPUNW7KIUysdwTJUsst6qOuurW/Wc3PxRerRUpLr4DIVWfoDJzPkgHDl
        yQ+Pp8YO4XyIBPlLqhNiv9H8GLH9cBA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-etku91f3PSW39vFUNDYFpg-1; Wed, 02 Jun 2021 10:56:40 -0400
X-MC-Unique: etku91f3PSW39vFUNDYFpg-1
Received: by mail-ed1-f70.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so1581913edu.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jun 2021 07:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TMcD5cH8Gq97lrhqQCtDsFyiGiLKX1rySB5M/G3UShE=;
        b=fDLT6u6HoEpLTciut2zwBGN4Q+TTFwsqOkNa0tyglCsHi2cKX0RsWsgs26AriucGg6
         hJfGCQ8ThL5LdEAc2PNz0MpSvATRWxffmW7jG4tjmt50/g5CbMAfZVlrRTvbcISx8ViJ
         1iwgL7IXTbWoOSzxwELY0EpDt/fLLyoshOhU7W4+q5gGDj44J5l0Oq3M+8dv1l45AuIv
         1tIUbJ6CK0x7xv/1AlxzMprUPfq1vAKs6lKtQ1E2YRxpZnmCRZupk7ORa3YZ9zje5BOd
         /BGIJq27LI6SGtw6HJ23Yw/BGmI9fJ3q4MIwbnoDfUxkH+TNdXcGIVfdS9rpSiMkYCCF
         Pb6g==
X-Gm-Message-State: AOAM53190AsIta6aMIiuoV7fttd1gG+yrgOAy7J2h0oz96T5sHqhkZxB
        jal2TvByAupGYp6MNPMR3cpIr+OIb7PTMy1ml6NC4OyXbsy9JV3Tz4+mvxlWr5MvkU6itlNGEZy
        A4HpUVZWEfc6CMdv4xKYjGrAOICI=
X-Received: by 2002:aa7:cd19:: with SMTP id b25mr37414291edw.84.1622645799648;
        Wed, 02 Jun 2021 07:56:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxETIGO2DZMJnum6q9KmB/yfISXhRFopOOUID+RlpBdT/IOOqIC9wTBVDUx7nYRfzZeiS6/GA==
X-Received: by 2002:aa7:cd19:: with SMTP id b25mr37414281edw.84.1622645799426;
        Wed, 02 Jun 2021 07:56:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w14sm115661edj.6.2021.06.02.07.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 07:56:39 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: Delete second brcm folder hierarchy
To:     matthias.bgg@kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        netdev@vger.kernel.org,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org, Amar Shankar <amsr@cypress.com>,
        ivan.ivanov@suse.com, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        SHA-cyfmac-dev-list@infineon.com,
        Wright Feng <wright.feng@infineon.com>,
        Remi Depommier <rde@setrix.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>, dmueller@suse.de,
        Matthias Brugger <mbrugger@suse.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20210602144305.4481-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <be57da0c-bb2a-787b-caa2-843f7110c109@redhat.com>
Date:   Wed, 2 Jun 2021 16:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602144305.4481-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 6/2/21 4:43 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> BRCMF_FW_DEFAULT_PATH already defines the brcm folder, delete the second
> folder to match with Linux firmware repository layout.
> 
> Fixes: 75729e110e68 ("brcmfmac: expose firmware config files through modinfo")
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> ---
> 
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 16ed325795a8..b8788d7090a4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -626,8 +626,8 @@ BRCMF_FW_DEF(4373, "brcmfmac4373-sdio");
>  BRCMF_FW_DEF(43012, "brcmfmac43012-sdio");
>  
>  /* firmware config files */
> -MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac*-sdio.*.txt");
> -MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac*-pcie.*.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.*.txt");
>  
>  static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>  	BRCMF_FW_ENTRY(BRCM_CC_43143_CHIP_ID, 0xFFFFFFFF, 43143),
> 

