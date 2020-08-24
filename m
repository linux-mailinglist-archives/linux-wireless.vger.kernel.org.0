Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27F24F408
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHXI3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHXI3M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 04:29:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D20C061573
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 01:29:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so1103811pgd.12
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2K6WTwIMAPjI/mFWjHAehqUSAvXRAhIwddvFBN/4ox0=;
        b=axj1fpmaqcL2Qqo0AMtAeS6B0LKBjq2tPBvFPljiQrgASaCnXDIbJ4z7d4VjuQiTzO
         +jGzyVIOL6Xo0Zl8tgRb/6ANQAREAa1p3nMY8l+/wfXMzuUzZS8WJ8K4RVFzdGAPSOLt
         Cu25OPgCOpOV48fmgSwCU9iMxRvkGZ1QAOz50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2K6WTwIMAPjI/mFWjHAehqUSAvXRAhIwddvFBN/4ox0=;
        b=TC0XjoX+i9kUddbzd8zDuy4uETM9igf9cfztqb8k/uMqJ+ZPvmWppo5PrdAGAxf6UD
         GEqWfqGwjI7IB8sOJRRHuumCpB+PRRi7svZxovFQgEPNFmOaDhTXJ3EIlhQbOaGg9ej8
         UvhqLwZeVEKvTi1iKysSvyCki5D2PgiobfZ31z1xBxgeGfZPDrmRi7FIn4X7IxmIRjaF
         BhiX6UtGrWShL/h+POwlSMBs2ym/843nVdeOKzGk28BOhnStKi26N7h+CI++GdZxspPu
         V8SR3TS0+LolYyDXL1Dg++1oTHKIGAHpTZSUChfHMci7h68Unz7Z7iT256uW5SxfX8eM
         fdMQ==
X-Gm-Message-State: AOAM530uANhcdC1GUITbYEbhhf+/oB1HOYsQIdUdgBIrAkFuNzeJCZ2l
        q0Z2SQdpWf74zN3V9+wNPENneQ==
X-Google-Smtp-Source: ABdhPJxJpp2dbQYy+c7xEPbxjJsA+XavJY3DvvaeIZvSws19WA21Xd666HyNd8XbMZp3ek05KWmEJw==
X-Received: by 2002:a63:2746:: with SMTP id n67mr2883670pgn.314.1598257748320;
        Mon, 24 Aug 2020 01:29:08 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id m22sm9074959pja.36.2020.08.24.01.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 01:29:07 -0700 (PDT)
Subject: Re: [PATCH v1] brcmfmac: increase F2 watermark for BCM4329
To:     Dmitry Osipenko <digetx@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823142004.21990-1-digetx@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <93536fd4-8abc-e167-a184-5a5e36d4205a@broadcom.com>
Date:   Mon, 24 Aug 2020 10:28:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823142004.21990-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/23/2020 4:20 PM, Dmitry Osipenko wrote:
> This patch fixes SDHCI CRC errors during of RX throughput testing on
> BCM4329 chip if SDIO BUS is clocked above 25MHz. In particular the
> checksum problem is observed on NVIDIA Tegra20 SoCs. The good watermark
> value is borrowed from downstream BCMDHD driver and it's the same as the
> value used for the BCM4339 chip, hence let's re-use it for BCM4329.

one comment, but when fixed you can add my....

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 3c07d1bbe1c6..ac3ee93a2378 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4278,6 +4278,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
>   			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
>   					   CY_43012_MESBUSYCTRL, &err);
>   			break;
> +		case SDIO_DEVICE_ID_BROADCOM_4329:
>   		case SDIO_DEVICE_ID_BROADCOM_4339:
>   			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes for 4339\n",

Maybe better to drop the chip id from the debug message. The chip id is 
printed elsewhere already so it does not add info here and could only 
cause confusion. Maybe you can also remove it from the 43455 message a 
bit below.
