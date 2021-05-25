Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9393902A7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhEYNls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhEYNlr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 09:41:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B7C061574;
        Tue, 25 May 2021 06:40:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f18so17226570ejq.10;
        Tue, 25 May 2021 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jlENx1EUSYg2mhGQYXQf9fdBS8Rp4vM0nDeH1Mk0huw=;
        b=UY7Ipm3WZUSMdWRTQk07U4vEMi+/hb4REu4V7zIPNcZXwWk35Tbr3yS+Ydx9c/SUJG
         0OyKPNbw4u3DXR6OAMO/RAf0tejTo/3G2xg2b67a5rM4HD8oZdBTLtmqV/TeZf5/MjEF
         WJHYyEcQSSBICnsk5KfQqx++krHuNHEu2W3WO0UN+fAWVfnjIDzhhdEAqxHdCOflf7tS
         LDdCWuJkhzgk0d4o+lp2+XKG7pbRFKX462H3UX5QsT1TmZTasdWrUGOmMUUVLye90AxX
         41HtpBi8A4iBCoa87c3pIGHJZOKmYoymgX1tJhOTlJ2lEJfdM9D/kLgLyBKSQR6uig9v
         ZAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlENx1EUSYg2mhGQYXQf9fdBS8Rp4vM0nDeH1Mk0huw=;
        b=sQlcNCucaJwAwvSgagfFx/OcmcyvjAsMfgiXnfHalpVWaFEoSK4p5J+BhgALn78g2M
         VE8/3N+oiCmkDjmFh0XY25BxxtUeCqtD9U4rCjcIlr8tdPtf+i8TW7WFbWtOGPZXo68s
         3U9YqsZQEkQZnYO1Pe7keWNYyJpf18ft2n0glyNc9F9Av/KIPWbSDamx6ihFUqUU3iE1
         Kf/AjXENw+0gJ8hyvOSbdSm46LDpWFwnHBcIu3dFPnsIl49oa8S9poI4tPX+FayWgd9V
         Qdoce+tzuVprsgAK6AAcbIwJoz2Dv4UX3vTaTmuyPpnwIN9OyFaafO27RblFNqarUvmR
         HTxw==
X-Gm-Message-State: AOAM531gK7aei018Jt+3V0ZUl4fcJx34jTvmIT2zaR1hQslJKM7jSruC
        jDHPqNAODq33Bfv+A7H0GAWRC1ddXoM=
X-Google-Smtp-Source: ABdhPJwJc43EAKHwI4Rbl/7ZfZFDhiNA72w3pFMCrtT3avr9XL+2kr7Nu/f/hmJBThUvHxDdVV9DSQ==
X-Received: by 2002:a17:906:5388:: with SMTP id g8mr29912310ejo.413.1621950016246;
        Tue, 25 May 2021 06:40:16 -0700 (PDT)
Received: from agape.jhs ([5.171.81.186])
        by smtp.gmail.com with ESMTPSA id j4sm8024155edq.13.2021.05.25.06.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:40:16 -0700 (PDT)
Date:   Tue, 25 May 2021 15:40:13 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: staging: rtl8723bs: removal of 5G code
Message-ID: <20210525134012.GA1387@agape.jhs>
References: <20210520092946.GA1404@agape.jhs>
 <8c0c1806-f818-cff0-6925-22ef2b164f77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0c1806-f818-cff0-6925-22ef2b164f77@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Hans and everyone,

On Tue, May 25, 2021 at 12:07:55PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/20/21 11:29 AM, Fabio Aiuto wrote:
> > Hi all,
> > 
> > I'm stick with removal of 5Ghz code from rtl8723bs wireless card driver
> > (in staging subsystem).
> > 
> > I think that this task comprehend deletion of all code managing
> > 80Mhz bandwidth and upper bandwidth (160 and 80+80). For the latter
> > it's simple, there's quite no code (unused enums and obsolete comments).
> > 
> > The former seems to be trickier, there are handlers like this:
> > 
> >         /* 3 Set Reg483 */
> >         SubChnlNum = phy_GetSecondaryChnl_8723B(Adapter);
> >         rtw_write8(Adapter, REG_DATA_SC_8723B, SubChnlNum);
> > 
> > phy_GetSecondaryChnl_8723B() contains code like:
> > 
> >         } else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
> >                 if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
> >                         SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
> >                 else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
> >                         SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
> >         }
> > 
> > so if we are on a 40M channel some settings involving 80M are made and
> > the whole is then written on card registers.
> 
> I'm no wifi expert, so I was hoping someone else would respond...
> 
> With that said I believe you should keep this else block, this part of the
> function seems to select the order of the bonded channels when bonding
> multiple 20MHz channels together.
> 
> The "if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {}" part can be
> removed because on 2.4G only devices 80 MHz width is not supported, but
> the 40MHz bit should stay, the constants for the register bits may be named
> after the 80MHz option, but I believe these same register bits will impact
> the 40Mhz case too.

agreed, just remove the CHANNEL_WIDTH_80 branch is good

> 
> It might be a good idea to rename the constants to VHT_DATA_SC_20_*_OF_40MHZ
> in a separate patch.

good idea, I was misguided by the trailing *_80MHZ in constant name

> 
> Regards,
> 
> Hans
> 

thank you Hans,

fabio
