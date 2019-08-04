Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F6480CEE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfHDWZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Aug 2019 18:25:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35613 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfHDWZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Aug 2019 18:25:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so60658821oii.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 Aug 2019 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1RJzfD21FcNmExKA2F6wfZ/f2LfI7+zplQTnTQ8R2w=;
        b=XCU9/Ww2kMfbTco37ahw6FDpiTto0qjILMIRm5YW67eKmvlcEADPdGDNt9n65UpWb+
         KCgHxn9mQPwjwiujYmSMWjB1XgjXGr8F2b4cPA1UPyVPQ3bpiSEa1EbBVwDmswSJyuy8
         85mm7f7qqWw5FpLOffTemwKKxveiAcIMUeUSmLFD3uiTAeyi2nWWXzRUZJL1rm5yke+w
         8cSTwYk9dYQZU8paFuaUsxqOkHvce+M/ycospsr4Vi7CCJQDHY04YtxsyS4+JsLj1OA4
         R9zr9mNfkPY2TAoLno4fMxnVrwlKDP8simNIoQpV01y0QZQzaIYpmLhMKyJFbffIDt0R
         MDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1RJzfD21FcNmExKA2F6wfZ/f2LfI7+zplQTnTQ8R2w=;
        b=Rv7QfLHWigU5a9NKhxQJ3FYYQQ0O4nGgzLqJ8EWzCdCTKvbOhpZZ9oestRyehZbucd
         yw8rfJAA0fEvhZ0RXxN6jz2LYcY2TVQJplrgBvOTEUyLgnmfqW7P0WE2caMo6Wc1PS99
         NHJUQz9Q+8XNC2QSh7amTrl3DcOUak6N7/8SR29DT8i89DLAw7z9InoDDo2X8ozgSx5v
         tDU1V8HUC/i/0x+SuSihubdKVRXN6IJ03wZ8qqVC7akt47R5euxtKi2TCyb2qw0BOuzH
         AeaZdvEAuFLxFRLVU/iuxFIbo6SNTqmAhEZ2GknJhIO/Iscw9kFcCoANlkKesx751Z4a
         E6LQ==
X-Gm-Message-State: APjAAAX9wDtowoR83TuFbiDkQMnQB3j9nkSdcd+IFZhG/pSeN0u7ac9w
        0dScb5+fDtsKB57aSciVoNXjacYNSR8XqTJ8UKeZ4A==
X-Google-Smtp-Source: APXvYqwYa9pqTns9ZUFNGH+p3Njs7Q8EQhBAMelAJrWfwbG8QH5hXMDMDsQMG+tdrxZEkgrpgNW7JU+vzM8CJvpWjJM=
X-Received: by 2002:aca:fd04:: with SMTP id b4mr8824624oii.53.1564957528486;
 Sun, 04 Aug 2019 15:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ASDXMVAP4CsE=vaomOn5mu_uAM0jc3jvWGzaVPFFif4kTX+Q@mail.gmail.com>
 <2d274e00c3e15e9786ccc865215d9853a5ab30f0.camel@sipsolutions.net>
 <3282a26ab610c1590742c0d50632c35ae4bb82c8.camel@sipsolutions.net>
 <CA+ASDXMNu2Jv1nFCWMtg6bcks-XKv1fTGr6j2f0TdgtAhkQK3w@mail.gmail.com>
 <d4715a263661f442e1d610c63981a256fcba82e6.camel@sipsolutions.net> <7179602b12fbcdad6e3c8d71150e647b32b9425b.camel@sipsolutions.net>
In-Reply-To: <7179602b12fbcdad6e3c8d71150e647b32b9425b.camel@sipsolutions.net>
From:   Kirtika Ruchandani <kirtika@google.com>
Date:   Sun, 4 Aug 2019 15:25:15 -0700
Message-ID: <CAOXD1ieAXJnHqHCsVKWt+cyBkttnpgS8dKMCixbyW0hvRyB2Vg@mail.gmail.com>
Subject: Re: iw release cadence?
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, npoojary@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 1, 2019 at 2:23 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2019-02-01 at 23:18 +0100, Johannes Berg wrote:
> > On Fri, 2019-02-01 at 14:17 -0800, Brian Norris wrote:
> > > On Fri, Feb 1, 2019 at 2:09 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > > On Fri, 2019-02-01 at 22:54 +0100, Johannes Berg wrote:
> > > > >
> > > > > I'll just tag one now :-)
> > > >
> > > > Done. I updated a few things and pulled in our FTM support code too, now
> > > > that all the nl80211.h api is upstream.
> > >
> > > Awesome, thanks! Presumably a tarball is on its way?
> >
> > Need to figure out how to use kup again ...
>
> Ok I think I figured it out, but it takes a little while to sync and be
> visible on the public frontend.
>

One more 'I can haz release plz' nag.
Support for 11ax MCS rates and HE stuff came after 5.0.1, and
preferably we should take that with an upstream uprev not local
patches applied on top of 5.0.1?
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/log/
Thanks in advance!

> johannes
>
