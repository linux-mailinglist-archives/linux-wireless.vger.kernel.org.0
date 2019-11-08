Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A2F58A4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbfKHUhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 15:37:09 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:35756 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbfKHUhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 15:37:09 -0500
Received: by mail-qt1-f169.google.com with SMTP id n4so3313278qte.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2019 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITB9n3KLIAIIJWm3VoZPLz2RZUXAft0cWvIidkqxlxo=;
        b=kDJXapmNzzKKPljb3qe1Rd6L78eEvB+7QU24qiq5Pmk17TdtOPl3sGRGj3uhieMwmf
         3SsGw1oHu9hzQvxSailVX+HV0oRgTWxveG4K30zU2l9bvW7X8zpIYJPsxmR/uRa2+kya
         HBwWLojekwzW57WJxxnN9xz38Ef7fLPp/TAUAY3Emyaq4ZTmQSvRLFGItoIbsPGlxMVm
         10CbExDXRqFprnJq61BD61BCW2ovzn6ItNCVhTV6/9Ph9yvzZWXx1r2QfC95Xpqdast7
         silD6Q9D0MgIfTjXPCnuTNDbgZUzJ6xl/2fgJCY1MKCPZZSOIr3LaF1zSimeTOmSblQy
         O8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITB9n3KLIAIIJWm3VoZPLz2RZUXAft0cWvIidkqxlxo=;
        b=mtgwmjnEwezsfNSRu20590jhAHmx+l3vnvZowXFg3sVwx2Y3S+OS54LYOeI9XJDSAy
         egEBRrxyt61S7WPhsvCjsy2k4YqxkJyv1Hh95isJKUHq6CYPvJuyjYpitzqF0FlA09Ie
         mSFTjqmCJiWHxueHhKy3CzRN9GMft71rdLwu775Hlf/mUvrw7B7aVoFVyteVR8DjoY1o
         E27BcEz8zAMW2MU4chVOxMLGAEHuglHPhuRV/sF8dzGagfQpp4uLTJkmP+5a/XdA/Oo3
         2uNjxFZ8jQ6+Ihuh2yukRdlWfYaJ5KQ6wN1PGgx5jYNulUz+WhSR70tFoKejXU0g8Gmf
         6BSQ==
X-Gm-Message-State: APjAAAXmmCHicTN8HSZBKIKl63AK9qKARcd56aL2vlRQMhug+U6zjuwh
        5UPXYw+FYcke5NXdnGCpSt5kiNM/spm8BOztk5Q=
X-Google-Smtp-Source: APXvYqyr70axILVrzeOI7oejGNE3T7d5qeepISMnFBnL0nWhDsq0vCVBWSWqph6GZWor4k/+mBAA/XC7lLv9mUEHbac=
X-Received: by 2002:ac8:6a0a:: with SMTP id t10mr13214520qtr.62.1573245427877;
 Fri, 08 Nov 2019 12:37:07 -0800 (PST)
MIME-Version: 1.0
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
 <20191108093207.uv4j44xpm2qvtsv5@bars> <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
 <20191108120504.ptl25hacxcftb7tw@bars> <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
 <20191108160121.tbatmqwx64aoqqai@bars> <c95e9e9f5539150459f97f811b784a6e9af163cf.camel@sipsolutions.net>
In-Reply-To: <c95e9e9f5539150459f97f811b784a6e9af163cf.camel@sipsolutions.net>
From:   Sergey Matyukevich <geomatsi@gmail.com>
Date:   Fri, 8 Nov 2019 23:39:50 +0300
Message-ID: <CAFGfvX444gsRvbtTecJyQgYHRF3ATajUA21NkVah8AV-WxkoWg@mail.gmail.com>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific configuration
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Tamizh chelvam <tamizhr@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > > I think we still need NL80211_TID_CONFIG_ATTR_OVERRIDE in some way
> > > (maybe only as a flag attribute), since you could have
> > >
> > >  * change all stations (some subset of TIDs) *including* already
> > >    configured stations
> > >  * or *excluding* already configured stations
> >
> > Hmmm... Logic is straightforwad without this flag:
> > - settings are applied to bitmasked TIDs of a single peer if address is specifed
> > - settings are applied to bitmasked TIDs of all the peers if no address is specified
>
> Sure, this is obvious, but what exactly does "all the peers" mean?
>
> Say I do
>
> set_tid_config(tids=0x1, peer=02:11:22:33:44:55, noack=yes)
> set_tid_config(tids=0x1, peer=NULL, noack=no)
>
> Does that reset peer 02:11:22:33:44:55, or not? This is not documented
> right now, and one could argue both ways - the override for that
> particular peer should stick, or should be removed. Which one is it?

Ok, I got the point. My understanding was that any further command would rewrite
the previous settings. But now I agree that this is not obvious and should be
explicitly documented.

Sergey
