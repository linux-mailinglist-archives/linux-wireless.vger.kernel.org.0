Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DA294E4C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Oct 2020 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443312AbgJUOMh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442654AbgJUOMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 10:12:36 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217DC0613CE
        for <linux-wireless@vger.kernel.org>; Wed, 21 Oct 2020 07:12:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 33so2696143edq.13
        for <linux-wireless@vger.kernel.org>; Wed, 21 Oct 2020 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7nt1N35OyhUe0ZizjlwSIWiCKo67Zjf8DchrnWxEdz4=;
        b=EW/Nq0YyuPrFk+K1AkbEsMTzsC8p9MZ/6tlow10eND3oX209d0jlO3olwaTEGtLZrj
         QqKjKaTzAmrH8VIPls1F2Ll27Wd3vO/q0dWeldjmG1LKaZ415r8+hNzg4QJQE7GjLLLW
         i3sZdmYJVdVWvlhrSywHa95FjZ8ATlcz8uwtPHHSuC1Owm1C0ThLRYYvU7l9i5MGBfIj
         MHoRytUBywrl/CSqM07Mg1fwxez331QMEa8uk8v0TC7mPlNfmS4nPIVF1tN8ig7aMchf
         fMizP1qb/yBbBPTSr/E1h3VoYLJs++f3FNShUrRNqMq3oo0ZlUHQWKGZpg6cas1UfiOk
         eA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7nt1N35OyhUe0ZizjlwSIWiCKo67Zjf8DchrnWxEdz4=;
        b=lTnUkqdIqKf0WmGtAFfqNq/aI2inPhxCSR6lfZcDO6kKHIg0rKHZ+2JTq3CU7tpX77
         0/qj2S5DceMviCkyAucyyn3lRKWalWZKiaBwmnTQyu9TbZk5JKAbjnClnLfxZPMNONdB
         xTEhO92GLOsCoX2CpwDkAb8KXbTjiyISB2qpjNdXRMf95+qyAxGKfc5QPLaPl9u4xfK2
         n7ZZRZLiaW7vG67ZI16IcVcAjX3w+ZC/0IKweEzx08Du2lLCwPeehenkLVTxIoguHFRg
         qHyx/j2xXdmFLhPfnTMk1365QORvYbMObwOA4glgeUe8QluX6sDCsHp0rWHNX7ODjj8p
         g2jQ==
X-Gm-Message-State: AOAM531L7VktSn4airCprhcbq3tvVcqmDS0dWC7BVQXZs0cu18NmerFG
        fM8N87AspZGrrqTLsISqjh18qUytI8qLs5edsJQ=
X-Google-Smtp-Source: ABdhPJwnxW0UYsEt4kdzRB0IZdxqjrBY3aV4rkzMki8YwuvSMYL2bK4HfKrq8BJXpFNE2cl3fhPOLohHbwMHdvLOaEw=
X-Received: by 2002:aa7:c586:: with SMTP id g6mr3304547edq.343.1603289555167;
 Wed, 21 Oct 2020 07:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com> <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
 <87h7qrq4p5.fsf@tynnyri.adurom.net> <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
 <CAO6ttS=U=UXLEByJVDQgXdBbtgKm=WgGUjOVZCXuOnjyajUTFA@mail.gmail.com> <50fda979cb584ea898681282926fcfef@realtek.com>
In-Reply-To: <50fda979cb584ea898681282926fcfef@realtek.com>
From:   David Rubio <david.alejandro.rubio@gmail.com>
Date:   Wed, 21 Oct 2020 11:12:24 -0300
Message-ID: <CAO6ttSkPFjOnTYtfzRmKfT2cL-S7=6-R-WzNOBb7yZXW22-HEw@mail.gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Andy Huang <tehuang@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

5GHz. Haven't really tried 2.4GHz.

So basically with that patch, 5GHz works ok-ish, and 2.4GHz is broken?

- Kodehawa

El mi=C3=A9., 21 oct. 2020 a las 0:41, Andy Huang (<tehuang@realtek.com>) e=
scribi=C3=B3:
>
>
> David Rubio <david.alejandro.rubio@gmail.com> writes,
> >
> > Makes sense I guess. My room is 7m^2 so can't test beyond that.
> > Small room issues, or well, not issues, I guess.
> >
> > - Kodehawa
> >
> > El lun., 19 oct. 2020 a las 14:10, Larry Finger
> > (<Larry.Finger@lwfinger.net>) escribi=C3=B3:
> > >
> > > On 10/18/20 4:11 AM, Kalle Valo wrote:
> > > > David Rubio <david.alejandro.rubio@gmail.com> writes:
> > > >
> > > >>>
> > https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82=
@r
> > ealtek.com/
> > > >>
> > > >> I tested that patch. Works fine for me for wifi, but I can't test =
BT
> > > >> to be sure it works 100%. Most people will be fine with just wifi
> > > >> though, I guess, considering the objections were mostly about BT (=
I
> > > >> understood -from the objection- that connecting to a AP when havin=
g a
> > > >> BT device paired breaks?)
> > > >
> > > > If the patch helps people to get wifi working we should take it, BT=
 coex
> > > > issues can be fixed in followup patches. IIRC there has been multip=
le
> > > > reports about this so I'm leaning towards taking the patch to v5.11=
.
> > > >
> > > > I changed the patch to New state and my plan is to take it to
> > > > wireless-drivers-next once the tree opens:
> > > >
> > > >
> > https://patchwork.kernel.org/project/linux-wireless/patch/2020080508455=
9.30
> > 092-1-kai.heng.feng@canonical.com/
> > >
> > > Kalle,
> > >
> > > I had generated and applied that trivial patch to my GitHub repo with=
 the
> > rtw88
> > > drivers a couple of months ago. Yes, it does get the user past the
> > > initialization check; however, wifi performance is abysmal according =
the the
> > > users of the repo. It seems that the antenna selection of rfe 2 model=
s affects
> > > wifi as well as BT. Applying this patch will get wifi running; howeve=
r, the
> > > users will need to be within 1 m of the AP for it to work! I do not h=
ave an
> > > RTL8821CE chip, thus I have not tested myself.
> > >
> > > Larry
> > >
> >
> David,
>
> What is the band for the test, 2.4GHz or 5GHz?
> Without setting to a correct rf module for RFE type 2, you might encounte=
r some
> problems on 2.4GHz band.
> In my test, on 2.4GHz band, with the wrong setting, it could not connect =
to an AP.
>
> Tzu-En
