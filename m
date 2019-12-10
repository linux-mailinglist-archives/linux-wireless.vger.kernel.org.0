Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D4118EC4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 18:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLJRTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 12:19:32 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:40053 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfLJRTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 12:19:31 -0500
Received: by mail-qt1-f175.google.com with SMTP id t17so3457260qtr.7
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2019 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IVrotsx1YBPveLTsbNS8819hoTM6uUWmk0jV45c+Dcs=;
        b=jpauirytvZFwSZPwOrG0eo9Iiznuco2p1dJEWkDX5sUUz5AlxeR1ejzLETzR5px0mR
         eur47Xnaw6NSJWXuZpYVWh5eEmXGOwPJ2NrNgvGk+AT4LaAS4SPY+ryb7yyC1q7zcAEL
         3qUHj1Ht2JUbMsjmV0NQMmEm560z+Ue1ipEcGk/cLjzHSAwmpgtgj+I2qURnNbkSjXTd
         PhtyflZbIst4e/E0qhFetpWMXQqtbmpK7SoJbZvvvotvnjCy5SgXZ4JIhD5XSpcORrVV
         lwhqgOxV1GkrO3E5iu1cD+xsGYkbxaGVNJLqHbTyqBS9YzE5kqSeB8j1f9mSdy4Mj/VW
         bnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IVrotsx1YBPveLTsbNS8819hoTM6uUWmk0jV45c+Dcs=;
        b=YBaumSKloN98H1ddsrWVIg7xBzu3Ba/qHa7aI9r6WEEcyBK2KD/eVwXCR1XrZpG6LK
         xYtXMwcqDnvBmLpHKEKAs53HsjvzazN52dnyY2s1hXTWL1q/iERAWL0ruKUkKk9DHvH4
         snbDp7pK/teflvQuuhzS15EhxnT9HAnoLnl85XtCTJZh6eCexBlTyDyJNOUKwxPaSr5p
         L30cdzEBlwSCp75EH1rEN8o9UoIHMxuPJeR6as6vSZkpH7U5hZZObhsTn2lfIyIbvRSP
         N+BAoUCxyLLBuyziIprcOSCHX1qXSc36tP+OgjhAwjz2GGVyjHxqAcbmKUZN8KcvQDsY
         1mdQ==
X-Gm-Message-State: APjAAAWIkwEsHt4y5XEsF8cu/ZLCrbDpG3DU12BBU2G7Sq6eJb2GhfIb
        2V1KHPCRb8HYBwiTV5NaF/JT+LNZ3JSQGa1qqSqvNQ==
X-Google-Smtp-Source: APXvYqwdX81vOQMBGh9s09VF0mg5+bENQz36VVJpEh6+LZhJEfDbaABcLw7kMzdRVxspgHNQxRNIJdtXNE4ATA+XLaE=
X-Received: by 2002:ac8:5156:: with SMTP id h22mr1762273qtn.233.1575998370410;
 Tue, 10 Dec 2019 09:19:30 -0800 (PST)
MIME-Version: 1.0
References: <CAFED-jmt5BjTNQ=oQsSpTZRY115BsukCdhXTz-f-bBtin1PP7Q@mail.gmail.com>
 <283f52f854eb895b7da9d68a665b9679ba006d47.camel@sipsolutions.net>
In-Reply-To: <283f52f854eb895b7da9d68a665b9679ba006d47.camel@sipsolutions.net>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Tue, 10 Dec 2019 18:19:19 +0100
Message-ID: <CAFED-j=QDEwi1Y4LqCPHuVavGssGQ7ha=Bk6S+9E9DPVYHLWPQ@mail.gmail.com>
Subject: Re: iw - set freq regression
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

pon., 9 gru 2019 o 20:49 Johannes Berg <johannes@sipsolutions.net> napisa=
=C5=82(a):
>
> On Mon, 2019-12-09 at 20:43 +0100, Janusz Dziedzic wrote:
> > Hello,
> >
> > For v4.9 this command works correctly:
> > ./iw wlp1s0 set freq 5220 20 5220 0
> > ./iw wlp1s0 set freq 5180 40 5190 0
> >
> > With latest master this fail with err msg:
> > Usage:    ./iw [options] dev <devname> set freq <freq> [NOHT|HT20|HT40+=
|HT40-|5MHz|10MHz|80MHz]
> >     dev <devname> set freq <control freq> [5|10|20|40|80|80+80|160] [<c=
enter1_freq> [<center2_freq>]]
> > Options:
> >     --debug        enable netlink debugging
> >
> > After bisection and revert this one, works as before:
> > 4871fcf iw: parse_freqs: check how many center frequencies to expect
> >
> > I know we don't need to set this all arguments and finally I can change=
 my script (don't set cf1/cf2).
> > Anyway report this.
>
> Thanks. Hmm. So ... dunno. It seems a bit more user-friendly to not have
> the center_freq2, but OTOH having it as 0 at least won't really matter?
>
> I think we needed this for e.g. handle_start_ap() to not be (quite as)
> ambiguous since the chandef is followed by the beacon interval. If the
> center2_freq is _always_ consumed by the chandef, then a beacon interval
> of 200 would be like 200 MHz, and the result would fail here ...
>
> So not really sure. I guess we could add another argument or check if
> the last arg ('parsed') is non-NULL to change the behaviour, but is it
> worth it?
>
I think, no. Lets leave this as is.

BR
Janusz
> johannes
>


--=20
Janusz Dziedzic
