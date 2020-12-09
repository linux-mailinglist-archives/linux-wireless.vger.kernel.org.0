Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88E32D4B5F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgLIUP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgLIUPU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:15:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F4CC0613D6;
        Wed,  9 Dec 2020 12:14:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t8so1794061pfg.8;
        Wed, 09 Dec 2020 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/SB75FrytVaR1GPHJwL1aWxWJHgR7n/gB7N5XHVzZs=;
        b=nFHwZpS17ASDY3IDfmVDOBjTnpDOZVm8vIhqlIMBdw+A3vZP9iyFeW2V7FAoijK+iP
         LEmnyJzhH6X2DWFEjeFnCFgoAVB3GlwRu66NFkJx6gzSVrZXjJj6uM40de0JjKhAspIf
         kYZn3M2Y76C/EIaeYTvDsVlIASjN7WLFXhXajD5b+mKOZcWL5WkaEKe04qFKcy03w2Nk
         1sMdmj5X9hRahBrdjtX8I4N1BGSMDGKAZJk5WHbiu5TkduE+du0BnYLSVZ0rNrrAihi+
         +n9Ylvi+N/pXrJn4B2coXgnBMTxB+0UZvQNk8OnDGr94cFdpmUZQB2l6swF3wAKEGCcI
         pIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/SB75FrytVaR1GPHJwL1aWxWJHgR7n/gB7N5XHVzZs=;
        b=FeArSS8cK8Tt1VfseQFZvAYC50/5hcrl7MewkXiQZ9DNuQ78VwVpETJiaZHlsoPyYI
         GbMEPbJo7pI2gtBkSqDwxsEQEabfrsiA6zLF6+UPIC5mVTb735MFJwBqkdpCyMAlOZ26
         jIxOCeIwWaHVlw7P5y6/SZ1ORQIyMwHtk4rLCw5XUMfumUqLLyPoCQtadIDox67reKEB
         ezLa0csXU8T5ImLfPrVDytrCD+Cg8c5nOV4LjBQsJLW/YwloSIc1wRXuXvLHJk70tFPJ
         PXvi5WuRRGeGjjNSAr+w9IGQvdFnWBephoGNv2zFNlEqIJsd62rEgKccPgAAK5Sj4WiS
         j0zw==
X-Gm-Message-State: AOAM531GJnBmrEPtm8HT3Hgk3GGFz1G0uc3jPnEhblnc+4KCtsSYpENz
        jvTH2lakGgnp/jwIQjRQiDS2go4rUndaiq65Bg==
X-Google-Smtp-Source: ABdhPJzU1Dfwb1zgY1Qu6vWMDkDTCKsLd/N9aSQfQiQFMb9tNPMERYrSIPfZ8PjLrUVbBbu3LZKQqL+mhsiwSar8GGk=
X-Received: by 2002:aa7:9738:0:b029:19d:dce0:d8e7 with SMTP id
 k24-20020aa797380000b029019ddce0d8e7mr3564485pfg.14.1607544879848; Wed, 09
 Dec 2020 12:14:39 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com> <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 9 Dec 2020 20:14:28 +0000
Message-ID: <CALjTZvYfdMDLGZ8SebXT_W9Asa0fmMVhs47HVLvyDm7ao_Pbjg@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, guys,

On Wed, 9 Dec 2020 at 17:13, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Any luck figuring this out, Luca? If this is a 5.10 regression we need
> to let Linus know tomorrow, so the time is ticking :(

I don't have the possibility to test other kernels at the moment, but
I will do so in a few days (at least to find a working version to
bisect). Meanwhile, I don't know if this is relevant or not, but I'm
using WPA3 PSK.

Thanks,
Rui
