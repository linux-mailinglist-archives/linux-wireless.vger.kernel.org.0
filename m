Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B882A38FE6E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhEYKJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 06:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhEYKJy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 06:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621937305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neRDn1W0/FRhGmHT4pnXFQhxRlIRY6WFH9hbwXAhzss=;
        b=L+YlILYuC/CZcjCkgD0vQn5rc1Zljl9TSh6NHnQCsgAJ58aGVBR62Ax0rT4Ncx3rtUbxYQ
        dDDFEibEwk0LS/GNDsAm9G7ZFv0UoARoNC4zvgveSrwz7x7H3OfjDs7Ibr3zy9vpQD4Kam
        L2IuflVougt3nOF/6CKDAA/Lrpon+vU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-O0-gKMeeOlKz8CQiQVG7WA-1; Tue, 25 May 2021 06:07:58 -0400
X-MC-Unique: O0-gKMeeOlKz8CQiQVG7WA-1
Received: by mail-ej1-f69.google.com with SMTP id jz28-20020a17090775fcb02903dc26615f46so3935783ejc.8
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 03:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=neRDn1W0/FRhGmHT4pnXFQhxRlIRY6WFH9hbwXAhzss=;
        b=jfBJAhTboMFON43xMyzAErH7YxvfvkzpSqiW7pFW2LE1BVLbWSnuN+z7hk5OvDRujB
         g4e8bLrpNT08NYbThrj+Y1IeWyBYWq2zdT3ogN/jn+t2v5/ENzaacRX1+A5Uxxw5k9UF
         qMhGIOoKpD1lX6l+BugYomRqOj7ibcnVeaGua0mPJ0wbbV4VVZVvDySnDINt9MVebNUL
         5tpjIksbL6TfsUuFZHJbczhSCOC8OpIBQWYR+A3t+w9FtebdvptjYSmsYhwu2JoNqvwW
         xOQAJvStIuvPHgGeb6hG2/QBEFYVftxv9cKTxRKORIBZf4ypJQrCA3Db8SIRGEPYfhok
         6A/w==
X-Gm-Message-State: AOAM532hbcv/DNgBhLF3I7H6SFGY/V3hOsjwr0H461f1180ljEneKcWC
        0ojGAsDsjtNnLpTDYwGCCx4aVufVCAsWZtbrodau7IVlGMz6meScm4I4Tc/m0jlSMt9O1/yojDe
        KwaSV6oG/bPo/gjxo/wJKO68cXBv/Aun4eOTiqacijcrSibmjNAEYo9AKvQzsof4vNfB6kP3P1C
        DCFp0=
X-Received: by 2002:a50:ab52:: with SMTP id t18mr31734306edc.188.1621937276443;
        Tue, 25 May 2021 03:07:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHrL4elARHpBvwVzdshA75SWQXVu0rEVfjkR+v6KsApWjCXJcDV4xGaGp2LgtUiPaViaGk2A==
X-Received: by 2002:a50:ab52:: with SMTP id t18mr31734281edc.188.1621937276198;
        Tue, 25 May 2021 03:07:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y27sm8875899ejf.104.2021.05.25.03.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:07:55 -0700 (PDT)
Subject: Re: staging: rtl8723bs: removal of 5G code
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20210520092946.GA1404@agape.jhs>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8c0c1806-f818-cff0-6925-22ef2b164f77@redhat.com>
Date:   Tue, 25 May 2021 12:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520092946.GA1404@agape.jhs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 5/20/21 11:29 AM, Fabio Aiuto wrote:
> Hi all,
> 
> I'm stick with removal of 5Ghz code from rtl8723bs wireless card driver
> (in staging subsystem).
> 
> I think that this task comprehend deletion of all code managing
> 80Mhz bandwidth and upper bandwidth (160 and 80+80). For the latter
> it's simple, there's quite no code (unused enums and obsolete comments).
> 
> The former seems to be trickier, there are handlers like this:
> 
>         /* 3 Set Reg483 */
>         SubChnlNum = phy_GetSecondaryChnl_8723B(Adapter);
>         rtw_write8(Adapter, REG_DATA_SC_8723B, SubChnlNum);
> 
> phy_GetSecondaryChnl_8723B() contains code like:
> 
>         } else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
>                 if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
>                         SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
>                 else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
>                         SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
>         }
> 
> so if we are on a 40M channel some settings involving 80M are made and
> the whole is then written on card registers.

I'm no wifi expert, so I was hoping someone else would respond...

With that said I believe you should keep this else block, this part of the
function seems to select the order of the bonded channels when bonding
multiple 20MHz channels together.

The "if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {}" part can be
removed because on 2.4G only devices 80 MHz width is not supported, but
the 40MHz bit should stay, the constants for the register bits may be named
after the 80MHz option, but I believe these same register bits will impact
the 40Mhz case too.

It might be a good idea to rename the constants to VHT_DATA_SC_20_*_OF_40MHZ
in a separate patch.

Regards,

Hans

