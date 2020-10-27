Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF0F29C082
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782033AbgJ0O42 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 10:56:28 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33583 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781948AbgJ0O40 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 10:56:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id s15so1024138vsm.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Oct 2020 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7N00e/7kH+Yp4R4pJtyvMuHgjNguf39k60HnAyywGr8=;
        b=PQOocXuwqLG6zyH9ezZA5L3BQzRzKnf1PKdM5xRszjG+LdFclmTjocdF9krB81vSEX
         ZJQJM2sFs45Sa32cGCyMAM8zbKOkMr3ZxXgUyj+juEpeST4u4KaXWFbNH++rsL5f/L+T
         mhcW+1g3hVqdF21+mAcfNEk8TdYhBdUU034Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7N00e/7kH+Yp4R4pJtyvMuHgjNguf39k60HnAyywGr8=;
        b=qblkQd4z+u6sQvaI/1W2Gz3APrJFl3lnHijD/JkAyPuxdGuGdl65sUP/X0wytqSsjU
         b3e/Ke+YTc7F2insmtU18vJM4IRB7g3AsRe36DJ1JhbQ3MvmYKXJinxixcvtskS8XucQ
         fRmFbxvP4tad9A7BIIDYD6cPdf6KS9j2lvqXXWZC5uJwdmalPmcx6Bmq+nRQI3r/ZaGS
         rteqHLAn0chzRdc+zOZXHWGUWIWKw5UP1i2+tShR1DjHNNFK2ayAj99/PXNPLGWDXlUz
         mDhW0CsXOPfnS6J8beArFcR3t9T8csEPlMGPC54ccCFi4+u/3LJKRIUeGa0hsQryNusT
         iz7g==
X-Gm-Message-State: AOAM53059ez2YhMolDers1AlsBd4kewQMt2cWgYFeujGP36thIfccHXP
        7fQJaiRGlHzTdyXj9owF9RRHVd82cjl4ig==
X-Google-Smtp-Source: ABdhPJwlhKHa3Oi4uZMN8WEiECIAM+kb3//fSS9ragL3i39UFkrIVlQjZFb3R0pg1Gp85Z6UOsOzxQ==
X-Received: by 2002:a67:f587:: with SMTP id i7mr1702740vso.29.1603810584694;
        Tue, 27 Oct 2020 07:56:24 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 123sm161288vsr.6.2020.10.27.07.56.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:56:23 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id s6so998096vss.13
        for <linux-wireless@vger.kernel.org>; Tue, 27 Oct 2020 07:56:23 -0700 (PDT)
X-Received: by 2002:a67:5d46:: with SMTP id r67mr1691192vsb.34.1603810583251;
 Tue, 27 Oct 2020 07:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
 <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com>
 <CACTWRwtqcMxZKhDR-Q+3CyOw0Ju=iR+ZMg2pVrHEuzbOUebjOg@mail.gmail.com>
 <001a01d6aa24$6ceaf390$46c0dab0$@codeaurora.org> <CAD=FV=X5cVdMq9H+cABHmscZvJpswqGZONjqv7FL8kqRNvuHnQ@mail.gmail.com>
 <002801d6ac20$89ac4df0$9d04e9d0$@codeaurora.org>
In-Reply-To: <002801d6ac20$89ac4df0$9d04e9d0$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Oct 2020 07:56:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W1FiHRHeX-sATY_9x33n6P2n3KaoxfiGjvn2mwAm_-BA@mail.gmail.com>
Message-ID: <CAD=FV=W1FiHRHeX-sATY_9x33n6P2n3KaoxfiGjvn2mwAm_-BA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Oct 26, 2020 at 10:18 PM Rakesh Pillai <pillair@codeaurora.org> wro=
te:
>
>
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Tuesday, October 27, 2020 4:21 AM
> > To: Rakesh Pillai <pillair@codeaurora.org>
> > Cc: Abhishek Kumar <kuabhs@chromium.org>; Kalle Valo
> > <kvalo@codeaurora.org>; ath10k <ath10k@lists.infradead.org>; LKML
> > <linux-kernel@vger.kernel.org>; linux-wireless <linux-
> > wireless@vger.kernel.org>; Brian Norris <briannorris@chromium.org>
> > Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
> >
> > Hi,
> >
> > On Sat, Oct 24, 2020 at 9:40 AM Rakesh Pillai <pillair@codeaurora.org> =
wrote:
> > >
> > > >         if (bd_ie_type =3D=3D ATH10K_BD_IE_BOARD) {
> > > > +               /* With variant and chip id */
> > > >                 ret =3D ath10k_core_create_board_name(ar, boardname=
,
> > > > -                                                   sizeof(boardnam=
e), true);
> > > > +                                               sizeof(boardname), =
true, true);
> > >
> > > Instead of adding a lot of code to generate a second fallback name, i=
ts
> > better to just modify the condition inside the function
> > =E2=80=9Cath10k_core_create_board_name=E2=80=9D to allow the generation=
 of BDF tag using
> > chip id, even =E2=80=9Cif ar->id.bdf_ext[0] =3D=3D '\0 =E2=80=9C.
> > >
> > > This will make sure that the variant string is NULL, and just board-i=
d and
> > chip-id is used. This will help avoid most of the code changes.
> > > The code would look as shown below
> > >
> > > @@ -1493,7 +1493,7 @@ static int ath10k_core_create_board_name(struct
> > ath10k *ar, char *name,
> > >         }
> > >
> > >         if (ar->id.qmi_ids_valid) {
> > > -               if (with_variant && ar->id.bdf_ext[0] !=3D '\0')
> > > +               if (with_variant)
> >
> > Wouldn't the above just be "if (with_chip_id)" instead?  ...but yeah,
> > that would be a cleaner way to do this.  Abhishek: do you want to post
> > a v2?
>
>
> The parameter name passed to this function is "with_variant", since other=
 non-qmi targets (eg QCA6174) use this as a flag to just add the variant fi=
eld.
> This can be renamed to something meaningful for both qmi and non-qmi targ=
ets.

I think we still need Abhishek's change to have two booleans passed to
this function, though, right?  Thus, it'll be called 3 times:

* with_chip_id =3D false, with_variant =3D false
* with_chip_id =3D true, with_variant =3D true
* with_chip_id =3D true, with_variant =3D false

The two cases you want to combine are both with "with_chip_id =3D true",
right?  The "with_variant" variable being false will make the variant
string empty.

-Doug
