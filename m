Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801C09B700
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391480AbfHWTVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 15:21:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55989 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391410AbfHWTVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 15:21:48 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1i1F85-0004T5-W1
        for linux-wireless@vger.kernel.org; Fri, 23 Aug 2019 19:21:46 +0000
Received: by mail-io1-f71.google.com with SMTP id m7so3565899ioc.4
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 12:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=laLz0wZ4oQqskuw64PVcdC99yqfRU/QVVwICJDNdh9c=;
        b=qlAjjXOHmla1848eyOPqf0EjUEZR8XbP3rIEZCodsbzUUpVJGXR+kv6rWnhfAywx9O
         fckkdkvwzkpPZUD3TrgrnONT/uofvfWv2zbIDfvwp47PonEej1xAuDRo8KKl/mxaQypU
         U49nfuXC3O/8eB5Qs5F+O2kf500Jw2qo6yAlU/HAYYm1aD9KBGRRne66QkUDPkHxxIh6
         fRD5honQEMd4xl7ZHKX9WOlFg33b/eqdpJqoLr7834QS7D1oiJLIqWmxJBSzzZM4NsSW
         Z65Ji1Td4ozhqyyYfcZjkiSW59R32Q+Fj2nh91p6L+klqc8muP7svAuvZeOL3Obb9eVM
         FtQg==
X-Gm-Message-State: APjAAAXoBec+66CctkHkpB2FO1Nq851YC4XpUmK/zXbAkDFTllK3i5Al
        ssQYGRyKOEGRy/P/9O8lGeJyH3W3sEwaHvGPHN3CasZ/KahZqvzT5wqyLYl8FxjRIPCZHjYZC2K
        zhlz/CZ/+LHrMY3zTNMG7YIMFyb7g4puSKpwEDCvQbuor
X-Received: by 2002:a05:6638:2aa:: with SMTP id d10mr3183582jaq.89.1566588104943;
        Fri, 23 Aug 2019 12:21:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYnsjyEu0usaqIqxJLzq5wInHcaLoH3t6tSdI0WzzXbG1BaydkidQSLVPySZlzDkCPPWj8Zg==
X-Received: by 2002:a05:6638:2aa:: with SMTP id d10mr3183543jaq.89.1566588104325;
        Fri, 23 Aug 2019 12:21:44 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:284b:e6e0:ec2a:c9ef])
        by smtp.gmail.com with ESMTPSA id z3sm2311135ioi.54.2019.08.23.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 12:21:43 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:21:43 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for Russia
 (RU) on 5GHz
Message-ID: <20190823192143.GA3071@ubuntu-xps13>
References: <1564427246-25592-1-git-send-email-hanipouspilot@gmail.com>
 <20190823190019.GZ3071@ubuntu-xps13>
 <CANoib0F5U7suFoHdKYuqQvjB+XN5bkqzNtBd6RkUi_Rnt7_OrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANoib0F5U7suFoHdKYuqQvjB+XN5bkqzNtBd6RkUi_Rnt7_OrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 23, 2019 at 10:08:39PM +0300, Dmitry Tunin wrote:
> пт, 23 авг. 2019 г. в 22:00, Seth Forshee <seth.forshee@canonical.com>:
> >
> > On Mon, Jul 29, 2019 at 10:07:26PM +0300, Dmitry Tunin wrote:
> > > Russian entry is incorrect. According to the last regulations document of Feb 29, 2016,
> > > 160 MHz channels and 802.11ad are allowed.
> > >
> > > http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf
> > >
> > > Note that there was never a DFS requirement in Russia, but always was
> > > NO-OUTDOOR on 5GHz.
> > > Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> > > Also Russia has never been regulated by ETSI.
> > >
> > > Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> > > ---
> > >  db.txt | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index 37393e6..d95ed5e 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -1097,14 +1097,12 @@ country RS: DFS-ETSI
> > >       # 60 GHz band channels 1-4, ref: Etsi En 302 567
> > >       (57000 - 66000 @ 2160), (40)
> > >
> > > -country RU: DFS-ETSI
> > > +country RU:
> > >       (2402 - 2482 @ 40), (20)
> > > -     (5170 - 5250 @ 80), (20), AUTO-BW
> > > -     (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> > > -     (5650 - 5730 @ 80), (30), DFS
> > > -     (5735 - 5835 @ 80), (30)
> > > +     (5170 - 5350 @ 160), (23), NO-OUTDOOR
> > > +     (5650 - 5850 @ 160), (23), NO-OUTDOOR
> >
> > Based on the translation I've read of the document you've linked to as
> > well as a couple of others, it sounds like the use of these ranges
> > requires TPC. Since TPC is not supported in Linux, we need to reduce the
> > max EIRP for these ranges to 20 dBm.
> >
> > While modifying them, let's also update the 5170-5350 range to 5150-5350
> > to match the regulations.
> 
> 
> It is not very clearly stated, but I agree that it looks like TPC.
> Where is it stated that we need 20 dBm on these ranges if they require
> TPC?
> Unfortunately I don't have devices with OEM software certified in
> Russia to see what is the limit.

It's not specifically 20 dBm, it's halving the power limit (i.e.
reducing it by 3 dBm).

Seth
