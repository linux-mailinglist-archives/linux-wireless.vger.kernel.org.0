Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28A9B6A4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 21:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405043AbfHWTIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 15:08:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43680 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbfHWTIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 15:08:52 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so22441673ioe.10
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=czgP4V1cO/oJg7814sELaFE/yV2PR7tij5ikMic5KJ4=;
        b=h8seX5Kv6x8M0SWw7jDo4QDiVIoeaaJzESotdunqLXWfh0oXFoqee4neU6VXaRQAyr
         Zsg4uAevw6tl2XHY9wpR4xfSICsa1Sc37H4gObZFRiyvMib6+pvdX2MTDqRI2Wq7ReJ7
         OGJzoVG8g3+6wHxyUS0nbduhY3EQEw8Zem3sXLPm/C+58BdcZTzWJtDUcKYfAqebd/pO
         HRx5j0mcqAkjMdbgZJ8cV7ULNnA2wFGkn0o4/uc3nccIfwxEwISvxcecMjrLRCB9j/uh
         9EOvOAR4v6XvdoiieHYq1VJR48IFlIbx+cTmHwXLXundyzXxNGBAW1rvvryRD9i+I0Pv
         5iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=czgP4V1cO/oJg7814sELaFE/yV2PR7tij5ikMic5KJ4=;
        b=lU6GAp4380WLWTCWjS3bYW/pDJcWXM8jXw+h4+H9n6QVNowKV1xWEgmwCUS7+7iXVc
         ntSZlSOtfqx1A+f5ZWVxTwJQ/uuEGU0XHtbOP9fEWcrlEtdLMwjv3LIk5cJKOwU/xxUJ
         HxkgrlGVHigVbYAiI//1ESgJqjDHBEcmnUPdjuUJBO1ms1JFp5oPF85xNIlrm3W8oEJ1
         clKdommDLkFumhFbjNB/FwDzt6L/A8+H9ASFR23HGSoIe1mBrj87CuZk3XgLNpeaUGi6
         GMEgqt1BqE27kJYMnoxJlikHFKBfmfdnNCaVtPlke9qWZwbUuc+ZSKSwRpbqDhaI8C/u
         s0uQ==
X-Gm-Message-State: APjAAAXfhNug7TRz+dS0M4r/LiCnqhJU2hsrU2agyQ3PBxgkaMahUmFJ
        kcnUNSZm4clt9TgqHbd5rjGyU800jDQI4IdYhr/r+sav
X-Google-Smtp-Source: APXvYqyBbjKL/UrkVe2G4Pc2Fuh6wg4gki7XY/ajHsJju68hvo7WGVYx0RxPXIXaux+pE12XAxDV3R0W3eqU9hawTvQ=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr8851000ion.237.1566587330898;
 Fri, 23 Aug 2019 12:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <1564427246-25592-1-git-send-email-hanipouspilot@gmail.com> <20190823190019.GZ3071@ubuntu-xps13>
In-Reply-To: <20190823190019.GZ3071@ubuntu-xps13>
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Fri, 23 Aug 2019 22:08:39 +0300
Message-ID: <CANoib0F5U7suFoHdKYuqQvjB+XN5bkqzNtBd6RkUi_Rnt7_OrA@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for Russia
 (RU) on 5GHz
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=D0=BF=D1=82, 23 =D0=B0=D0=B2=D0=B3. 2019 =D0=B3. =D0=B2 22:00, Seth Forshe=
e <seth.forshee@canonical.com>:
>
> On Mon, Jul 29, 2019 at 10:07:26PM +0300, Dmitry Tunin wrote:
> > Russian entry is incorrect. According to the last regulations document =
of Feb 29, 2016,
> > 160 MHz channels and 802.11ad are allowed.
> >
> > http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrc=
h-_-16_36_03.pdf
> >
> > Note that there was never a DFS requirement in Russia, but always was
> > NO-OUTDOOR on 5GHz.
> > Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> > Also Russia has never been regulated by ETSI.
> >
> > Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> > ---
> >  db.txt | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index 37393e6..d95ed5e 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1097,14 +1097,12 @@ country RS: DFS-ETSI
> >       # 60 GHz band channels 1-4, ref: Etsi En 302 567
> >       (57000 - 66000 @ 2160), (40)
> >
> > -country RU: DFS-ETSI
> > +country RU:
> >       (2402 - 2482 @ 40), (20)
> > -     (5170 - 5250 @ 80), (20), AUTO-BW
> > -     (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> > -     (5650 - 5730 @ 80), (30), DFS
> > -     (5735 - 5835 @ 80), (30)
> > +     (5170 - 5350 @ 160), (23), NO-OUTDOOR
> > +     (5650 - 5850 @ 160), (23), NO-OUTDOOR
>
> Based on the translation I've read of the document you've linked to as
> well as a couple of others, it sounds like the use of these ranges
> requires TPC. Since TPC is not supported in Linux, we need to reduce the
> max EIRP for these ranges to 20 dBm.
>
> While modifying them, let's also update the 5170-5350 range to 5150-5350
> to match the regulations.


It is not very clearly stated, but I agree that it looks like TPC.
Where is it stated that we need 20 dBm on these ranges if they require
TPC?
Unfortunately I don't have devices with OEM software certified in
Russia to see what is the limit.
