Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC4B55FA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfIQTMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 15:12:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35228 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfIQTMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 15:12:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so5837992qtq.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z7u3kn780gnzjPkY1bCi6ixrTOrZl0102athKHT0lqc=;
        b=AQGQLKP36N6e63kHbizkN8kzKAo3zzuCqNEAwzW9YJDFZAJlUHIgtBZ/jf3aR6C0qH
         lP9e7DnaI63mlcegvNl8YG83Cf5KG3q+83CoJz7naFWXdtRFgKI9fnYTDwlWjx2a6Slc
         qSMIM8MGYX9dPNT2ET0bzw+II9xUkXFGMa2gIYfsHPfYtbh2sO/mfpBZXew7X42KYbja
         x1Tlmmxmf9gxjagZ+xRk9NBBCIAP63eRVNqlUAhu2oUAwhXYibRckrOGYdz1/b4oMZXW
         SUOB6diJQ3EH4We4VWvHhcJflf/N5mqUfNxv0O8SLE/68lrhpyIrinWMsvYTeZl70Dlc
         4CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z7u3kn780gnzjPkY1bCi6ixrTOrZl0102athKHT0lqc=;
        b=nQVDHHktGox8QBM5Uq0sxlEaSljD93hIxWaotveuDcTGG+eTqbr32Nme/pCQp+dKAm
         H9RWghUb3giDCfwwa+leRkJtzGhfWqdaQe/Ul13bJVSUfzfCV0iuHylPww71xU5Q5LJV
         fO87H/gPpyZzPSf8lpyuvhSGseiKdObzEjgW4mAPhF0N6CnOURS9PloUvD/YqhjEM4oD
         mn8lTZGL6fz3ag4ujcTEeJ7Ci6DYb/zy2/YqIxx1vkmyXK5+ukbu3fiCWUlu9O1KXmEf
         CrGCvub7brdi38JNK2gzbA4GF1FeZ16O6L2YyjAkteituv7ejockb4A0UiK7NQKyq14w
         IW0g==
X-Gm-Message-State: APjAAAXpNEwT9JiW6P5DF+RW4AM1t5CGrX7xWRbP0Q1MGZKTla6bYVYZ
        HkcbPRh6cvH/ihfa0MCOh0xO3XEkI8jzF5yfPZg=
X-Google-Smtp-Source: APXvYqxwjAEOLRHYTDo5jR9oJ5RBRqGCAJ/75brntZFC2muwV4T+O+JPUHgmyJz7HpYXQm1W80v8O4v/hEDZUmvR8MY=
X-Received: by 2002:ac8:5152:: with SMTP id h18mr370430qtn.210.1568747531321;
 Tue, 17 Sep 2019 12:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190904191155.28056-1-prestwoj@gmail.com> <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
 <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
 <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
 <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
 <87a7b8lciz.fsf@tynnyri.adurom.net> <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
 <87imprbc0j.fsf@kamboji.qca.qualcomm.com> <763f4560-ba78-b0e7-6855-fd4bc048ec13@gmail.com>
 <20190917204419.41235404@smicro.local.lan>
In-Reply-To: <20190917204419.41235404@smicro.local.lan>
From:   Steve deRosier <derosier@gmail.com>
Date:   Tue, 17 Sep 2019 12:11:35 -0700
Message-ID: <CALLGbR+1Pryv2z6m3caP9LuvGpY5BSFM8i+kyC2DX2vNpmQGNQ@mail.gmail.com>
Subject: Re: [RFC 0/4] Allow live MAC address change
To:     Bob Marcan <bob.marcan@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 17, 2019 at 11:44 AM Bob Marcan <bob.marcan@gmail.com> wrote:
>
> On Tue, 17 Sep 2019 10:40:49 -0500
> Denis Kenzior <denkenz@gmail.com> wrote:
>
> > Hi Kalle,
> >
> > > For user experience scanning and DHCP are also important, what kind o=
f > numbers you get when those are included? No need to have anything> prec=
ise, I would like just to get an understanding where we are> nowadays.
> >
> > Scanning heavily depends on the RF environment and the hardware.  In ou=
r testing ath9k takes stupid long to scan for example.
> >
> > But in a sort of best case scenario, using limited scan and no mac chan=
ge, iwd connects in ~300ms.  People have reported that they have not finish=
ed opening their laptop screen and they're connected, so at that level of l=
atency, every millisecond is important and totally worth fighting for.  Ran=
domizing the MAC would penalize our connection times by 2X (300 ms at least=
).  And Android folks have reported the penalty to be as high as 3 seconds.=
  So this needs to be fixed.  And do note that this is a feature every mode=
rn OS implements by default.
>
> Randomizing the MAC is a stupid decision.
> Do you realy expect that this will add something to the security?
>

Hi Bob,

Thank you for your post, but this is an opinion and adds nothing to
the technical discussion underway. Let's discuss the patches please.

Thanks,
- Steve
