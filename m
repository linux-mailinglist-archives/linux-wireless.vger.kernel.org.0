Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F61210F74
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2020 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbgGAPid (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 11:38:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731399AbgGAPid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 11:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593617912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Py/4SXH4WezveNFYu/+AP+Bhfed8tqRk59vhVofy0v8=;
        b=gPfMYxOdWd+kcLFbxQ9rQOQZnbmnVR718N15fPaM4ZX46KTnlvbo5mhVcYBPT24IWb2PaG
        ylsYmDowN6M6jqXYUwPYojQlOARxeHolh9jqT4ukOn3xV1KyAy0EtuAFDYQCk5MWDP7EVM
        LddlNMkOGxzvx400xm1xO++Lh8oTtjI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-M-D71wD9Mcq0YGfAQLRZMw-1; Wed, 01 Jul 2020 11:38:29 -0400
X-MC-Unique: M-D71wD9Mcq0YGfAQLRZMw-1
Received: by mail-ed1-f71.google.com with SMTP id 92so21278947edl.8
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2020 08:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Py/4SXH4WezveNFYu/+AP+Bhfed8tqRk59vhVofy0v8=;
        b=F11bAg29phN09Gj9Mf8NUke4e2vEwBRdmr7cQAxQ8nSvAssqV4VJO0OYgx8aoaA4zq
         OD9RURvN64KJ2DF7zTyJyqoS8xq55meO9cz9FLMjx6YPERLzKBOorZ+KixUbIHa397kY
         Q/MIPudJYjUdATe40rNdDbMU59PMvK3Bujfn1a54NnANKiBGEDLXiAySBXcWGSKPOwBL
         ZslLcG7uYCB5CTGrfZp5xOWlJ6VyALRZALS2CDd9FXXLikF1/5sZLqt0g0VPNIIVdpb+
         wwXSAHLWdvdGX89ah9s+m2idNWFFz6avjT+6AxT3KFvuRzDvON2r9fD/yCaV//UPIdmV
         /zsQ==
X-Gm-Message-State: AOAM5328b2r8pLMRC8QLC9CKMfndVB6+Gg+YCbDfeChjMg0nwJGPyUmn
        uCSEa5+0Su7mP6t6o5H2FCQJ5XbvFRP6+2FCSaGaiq/QeT6EJoLNVNRI8aigjP3JTLBpwdKNgmW
        EMj3+eJAROgdnDXWhDDnK2sLHBmg=
X-Received: by 2002:a17:906:a081:: with SMTP id q1mr18682459ejy.499.1593617908043;
        Wed, 01 Jul 2020 08:38:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy54o6ziuAtiZt1wxVzc00dbD4erN4UwBHRUGEg3DjhuOuIzpxwfUP54vl+2dn0vnK85F/E9Q==
X-Received: by 2002:a17:906:a081:: with SMTP id q1mr18682427ejy.499.1593617907763;
        Wed, 01 Jul 2020 08:38:27 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id d12sm6806675edx.80.2020.07.01.08.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:38:27 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: expose firmware config files through modinfo
To:     matthias.bgg@kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Double Lo <double.lo@cypress.com>,
        Frank Kao <frank.kao@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Saravanan Shanmugham <saravanan.shanmugham@cypress.com>,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Soeren Moch <smoch@web.de>
References: <20200701153123.25602-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <338e3cff-dfa0-c588-cf53-a160d75af2ee@redhat.com>
Date:   Wed, 1 Jul 2020 17:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701153123.25602-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 7/1/20 5:31 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Apart from a firmware binary the chip needs a config file used by the
> FW. Add the config files to modinfo so that they can be read by
> userspace.

The configfile firmware filename is dynamically generated, just adding the list
of all currently shipped ones is not really helpful and this is going to get
out of sync with what we actually have in linux-firmware.

I must honestly say that I'm not a fan of this, I guess you are trying to
get some tool which builds a minimal image, such as an initrd generator
to add these files to the image ?

I do not immediately have a better idea, but IMHO the solution
this patch proposes is not a good one, so nack from me for this change.

Regards,

Hans



> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 310d8075f5d7..ba18df6d8d94 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -624,6 +624,22 @@ BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
>   BRCMF_FW_DEF(4373, "brcmfmac4373-sdio");
>   BRCMF_FW_DEF(43012, "brcmfmac43012-sdio");
>   
> +/* firmware config files */
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac4330-sdio.Prowise-PT301.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43340-sdio.meegopad-t08.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43340-sdio.pov-tab-p1006w-data.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43362-sdio.cubietech,cubietruck.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430a0-sdio.jumper-ezpad-mini3.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.AP6212.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.MUR1DX.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.MINIX-NEO Z83-4.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac4356-pcie.gpd-win-pocket.txt");
> +
>   static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>   	BRCMF_FW_ENTRY(BRCM_CC_43143_CHIP_ID, 0xFFFFFFFF, 43143),
>   	BRCMF_FW_ENTRY(BRCM_CC_43241_CHIP_ID, 0x0000001F, 43241B0),
> 

