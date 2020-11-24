Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AB2C2529
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgKXMBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 07:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732615AbgKXMBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 07:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606219290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFWhLFtfwd2p3lUKJ8drhblrE5r73sVZPJsFgL8VlxM=;
        b=WKnNoTu8i12M+Dx2lwrYJD07jDGkuE2YbwytEX14J8yugubn2P/wcHpzs/7p0c9BB2ett7
        B/S4/+yR0hGjTUB54PaOE+I/6hvLS+TnCKLGecCfCYO3u2eS3XM8IT4MhS4Vyyg1WhtnM9
        VKnuUqJi8c/9A5FhPn7cTTiqKgSEcqs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-Aidhxa-BNVudK02gqqTtPg-1; Tue, 24 Nov 2020 07:01:25 -0500
X-MC-Unique: Aidhxa-BNVudK02gqqTtPg-1
Received: by mail-ed1-f69.google.com with SMTP id c24so7928935edx.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Nov 2020 04:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFWhLFtfwd2p3lUKJ8drhblrE5r73sVZPJsFgL8VlxM=;
        b=jB2OSZz9VmHycVAAV4FFLwE1NXCjeaceUSA0KT+dCmTq2fZ4yxNYoTbUDABbtmRJoZ
         6vCDqlxewLv6BPkC9zpP4FflGvFbJp4hx5u23qIAsRqT5VQzmWiA6Bz3400Zrojg5mW4
         /0u0MOJXI90k7ID0ixTvY7XweOKKzKp4yPg/MFJ8xNaDlA/LzJc3fpnB/TrUNVSysKpo
         vfHvhGyrchZia0QYO8V1NPKkIyhv1bFZWMdevZtGgX/Gwv5PV0AQs6JuDosUzowJYQN/
         kG1e8Ed/OygBTKvcXha2Wq4hCfJje7OlGpxuLif/5DpiQA/yKVoWmkEMri++Htjxr9AN
         AQtQ==
X-Gm-Message-State: AOAM533OMX2GP6J9Akse/Zlwo+G/gWk4xJs/K2gRykES58MP0vA9/P6Z
        RzlmagOMwbNNLjW9+z33UgW8jWdQC7mmiBFlWFuH5gx9468HTPdigjNNwn7PPgpqesMCMQwqMVl
        Log37CR2MHhgSJj/Ev3bzxY6Enro=
X-Received: by 2002:a17:906:ce41:: with SMTP id se1mr4122821ejb.155.1606219284621;
        Tue, 24 Nov 2020 04:01:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPxYpjkY9DnFSI+JjDHn1CBMwNDM8Ugsx2KlZwnL8pg+jjxVjOWB3NL4jvgFnDJm7qNiaSUQ==
X-Received: by 2002:a17:906:ce41:: with SMTP id se1mr4122772ejb.155.1606219284409;
        Tue, 24 Nov 2020 04:01:24 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id c30sm6748650edd.68.2020.11.24.04.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:01:23 -0800 (PST)
Subject: Re: [PATCH v3] brcmfmac: expose firmware config files through modinfo
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
        Matthias Brugger <mbrugger@suse.com>, digetx@gmail.com,
        Saravanan Shanmugham <saravanan.shanmugham@cypress.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Amar Shankar <amsr@cypress.com>, brcm80211-dev-list@cypress.com
References: <20201124120018.31358-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <83cdf5c7-bc07-f5c9-1165-821aa3b11ba2@redhat.com>
Date:   Tue, 24 Nov 2020 13:01:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124120018.31358-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 11/24/20 1:00 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Apart from a firmware binary the chip needs a config file used by the
> FW. Add the config files to modinfo so that they can be read by
> userspace.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
> Changes in v3:
> Use only two more generic wildcards.

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
> Changes in v2:
> In comparison to first version [0] we use wildcards to enumerate the
> firmware configuration files. Wildcard support was added to dracut
> recently [1].
> [0] https://lore.kernel.org/linux-wireless/20200701153123.25602-1-matthias.bgg@kernel.org/
> [1] https://github.com/dracutdevs/dracut/pull/860
> 
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 99987a789e7e..6fe91c537adf 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -625,6 +625,10 @@ BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
>  BRCMF_FW_DEF(4373, "brcmfmac4373-sdio");
>  BRCMF_FW_DEF(43012, "brcmfmac43012-sdio");
>  
> +/* firmware config files */
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac*-sdio.*.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac*-pcie.*.txt");
> +
>  static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>  	BRCMF_FW_ENTRY(BRCM_CC_43143_CHIP_ID, 0xFFFFFFFF, 43143),
>  	BRCMF_FW_ENTRY(BRCM_CC_43241_CHIP_ID, 0x0000001F, 43241B0),
> 

