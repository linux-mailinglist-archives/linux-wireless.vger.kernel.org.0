Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E918136C10
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgAJLjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 06:39:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36913 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgAJLjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 06:39:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so1644993otn.4
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2020 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N5q315f9LjOiYAZl8Osbhhg/nIGipOca4U1i12aQxzg=;
        b=j+dYtAD7VSmuHXSKuI074QT6Q74r/OEJBeXmrI/wL8hQxkIo67if/LXhfTEH5899sZ
         I5bglopMnHe+dU/0ZSEsg3PzbIEouzrePgkYSMX66SWenJcFeO+ACrMLSRFnqffm83Mz
         tyM1Emseujcpl6wzSqT9Ie097arY/q2G++tr7w/LT3ZYowfXkQ1xgpnhQ3ADHslfHSr+
         Zmc3XjY8NYD9y3DQzIpyd+IJ0qPaBOBrsKWvxnH9ofGxtx4bO4Nr2f9vEq/FHYL0Zjtd
         C8Of7sIRWulJqQePqmMn5TE6cRg0M75niotcVidxZRbuiaC+mgF3+K/e03GjRx0DLLgr
         lZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N5q315f9LjOiYAZl8Osbhhg/nIGipOca4U1i12aQxzg=;
        b=iqoEHnELYzL022ZaHhT0byfZWRSYGJLXT6HFNlInQU1Heb/EJveZ3Yf1J/6k4DEqj1
         kOE5SJjFHIjtioEvHHbHlHapDb6kvkR9yewdZKZnAuNObiCAnYLgBuybZj1o7VfRgvm/
         TkB0YNaOaC+xGl3M1addXRIqpZLuO3F2wZqovm1nbrbNx5/fj1ae+Q+eVdpIg84kr3Yu
         onQ9YCpozb1L3C8dDd74YHObi0vfYybqCT710l/w9zBIJHcoRKrUkHtr0F5KQDTkLOZ+
         gtk5UOl00rQ8Ue2ZATpptOhEO8wlpdLPnsvt0uCGC+JUlBFAxUOKCXLY8br8KhSAgo3m
         c35Q==
X-Gm-Message-State: APjAAAVXJLq0LI9AAFrKQwcV3n5aLYGI3OChj8UGw1arRzAhdt0Ne5AX
        y8nd8U5nt+JKHgqpnwfVm4Jy4znuKIVX9XVQ+oe+zw==
X-Google-Smtp-Source: APXvYqx7/Xicuqkr3xFcewvf0l1V57IutpgM/5oHx85hOJJ9Acnu00CD6cuJnfEFEIVcEH6X5LcaIWyN04cnLjrgVf0=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr2100394oto.289.1578656350008;
 Fri, 10 Jan 2020 03:39:10 -0800 (PST)
MIME-Version: 1.0
References: <CAKoLU8M+QU-96vnfet-759nnXyxxJmsf1Csba4FgNas8ZVOnOQ@mail.gmail.com>
 <87v9pjsom7.fsf@codeaurora.org>
In-Reply-To: <87v9pjsom7.fsf@codeaurora.org>
From:   Denis Kalashnikov <denis281089@gmail.com>
Date:   Fri, 10 Jan 2020 14:37:23 +0300
Message-ID: <CAKoLU8Oft1Lu1fQx2wRyO8nfOuynu6Ns5=xdq+j2X-wyyzYV9w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ath9k: fix firmware bug in some of Mikrotik
 R11e-2HPnD cards
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

You are right, it is possible. I will fix my patch and resend. Thank you.

=D0=BF=D1=82, 10 =D1=8F=D0=BD=D0=B2. 2020 =D0=B3. =D0=B2 11:27, Kalle Valo =
<kvalo@codeaurora.org>:
>
> Denis Kalashnikov <denis281089@gmail.com> writes:
>
> > Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
> > flashed that a card has 3 chains, but actually all this cards
> > have only 2. This leads ath9k to write periodically into the logs:
> > 'ath: phy0: Unable to reset channel, reset status -5' and
> > stations don't see that AP.
> >
> > Mikrotik R11e-2HPnD is based on AR9582 chip.
> >
> > Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > index b4885a700296..554a81400648 100644
> > --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > @@ -3373,6 +3373,15 @@ static int
> > ar9300_eeprom_restore_internal(struct ath_hw *ah,
> >                 cptr -=3D (COMP_HDR_LEN + osize + COMP_CKSUM_LEN);
> >         }
> >
> > +       /**
> > +        * Fix firmware bug of some Mikrotik R11e-2HPnD cards (based on=
 AR9582)
> > +        * that claim that they have 3 chains, but actually have only 2=
.
> > +        */
> > +       if (AR_SREV_9580(ah)) {
> > +               eep =3D (struct ar9300_eeprom *)mptr;
> > +               eep->baseEepHeader.txrxMask &=3D 0x33;
> > +       }
>
> What about 9580 devices which really have 3 chains, doesn't this broke
> those? Or is such setup impossible?
>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
