Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD310EE28
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 18:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfLBR1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 12:27:48 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46115 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBR1r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 12:27:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so5617870pjq.13
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2019 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orVQek45hbQSbuzOUHFucR+P4QAfww5RSJYpTiz6kMk=;
        b=E1ZDHCEdlSiRs2pgt0MJ9z0hc0NMboqKJ6DAxfZKh3xlL0N+t0EaKMJXUj/mUCzz2g
         GmK9qcWj11B1Z7c5zJmuLKI0cJjAFsuqBcW0d3RxcM1PJm1JRwfZEyUxJ+mmVjGyKEwh
         pQvQ+fC84S/SL0QYkOX8HPS1JX4qDJoT+pkeGWwg0fDrfS1LHqyBMFb/OCo1Qxld1CXD
         EJbeWQdrJqyq69KCpU4HwRBqXoT9roo3uRe0I2/zbVSGMZvjRRps3nrBqOJSWOQBRzqM
         dan9oMXAEn29Kbgea+qTVrDcOl0olI/gJ5STJYPmDwjsonGIt5S1RrZrGEj5kgnkUjVs
         0CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orVQek45hbQSbuzOUHFucR+P4QAfww5RSJYpTiz6kMk=;
        b=cXnjE1Lv32/iXwft8b4BVAvOuiPkMtw8RNgPyZBu8gGT7GxtJ/KFMfBYsbCxs5IrKX
         d52QDZk4QQZtmxmFgolYdFOYT2PEDRlXZ5FeGKCnXntFvtzqokJj3/56dYKrb52Kd6D/
         AhEJ8B+wn3a+nOlbSvDafbWy6RUl2gXHzb/4Hehznrh2Ty8ac1OiZh0mOZ28CQkUiBzk
         pAfO8T8/QCESPQMSdtkWFiNOgAQ8tAx3f8GZrOFHombQzFHPGflqnZ9FyYBJIqzQRJw3
         amOKCDQXL0OwoDhxJITA00Kqysav6m5iHE390ZxwkVAb387Un3d2gHo1C9W8+TWkhbaR
         K45g==
X-Gm-Message-State: APjAAAXivJcwMOd4OYVayIhkVsGnULN+pmGSGZs9Lw/AChQxIzESIMU9
        BAKwz2/EVDO0tZgjbbXG+d8Bs67GT/YZOPQLbj37vD8MuPM=
X-Google-Smtp-Source: APXvYqzaTKvhv+BQ331cpJ2A58psUjQ8mIb0ogedjAL9QEa7CqlVb1qtoPwOztva/oBIQC9ZAversWAN2WW/C5IN2g4=
X-Received: by 2002:a17:90a:1505:: with SMTP id l5mr122297pja.73.1575307666825;
 Mon, 02 Dec 2019 09:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20191128033959.87715-1-pihsun@chromium.org> <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
 <CANdKZ0eYSdPC2y5QxN1B7FshewXumrETQohbXrnvbovXMkSe9Q@mail.gmail.com>
In-Reply-To: <CANdKZ0eYSdPC2y5QxN1B7FshewXumrETQohbXrnvbovXMkSe9Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Dec 2019 09:27:35 -0800
Message-ID: <CAKwvOd=g36hxdU-pspCf78JhLTtxTk2dvStR3SQLhTPeCrELVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] wireless: Use offsetof instead of custom macro.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Joe Perches <joe@perches.com>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 28, 2019 at 8:05 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> On Thu, Nov 28, 2019 at 11:54 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Thu, 2019-11-28 at 11:39 +0800, Pi-Hsun Shih wrote:
> > > Use offsetof to calculate offset of a field to take advantage of
> > > compiler built-in version when possible, and avoid UBSAN warning when
> > > compiling with Clang:
> > []
> > > diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> > []
> > > @@ -1090,8 +1090,7 @@ struct iw_event {
> > >  /* iw_point events are special. First, the payload (extra data) come at
> > >   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
> > >   * we omit the pointer, so start at an offset. */
> > > -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> > > -                       (char *) NULL)
> > > +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
> > >  #define IW_EV_POINT_LEN      (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
> > >                        IW_EV_POINT_OFF)
> >
> > This is uapi.  Is offsetof guaranteed to be available?
>
> offsetof is already used in other uapi headers
> (include/uapi/linux/fuse.h FUSE_NAME_OFFSET).
>
> Also offsetof is also defined back in C89 standard (in stddef.h), so
> it should be widely available and should be fine to use here?
> (Should I add a #ifndef __KERNEL__ #include <stddef.h> to the file?)

Yes, please, otherwise userspace could have a
-Wimplicit-function-definition warning from including this header,
since it would look like a function call to a previously undeclared
function.

Actually, it looks like include/uapi/linux/posix_types.h includes it
unconditionally, and many other headers under include/uapi/ include
include/uapi/linux/posix_types.h (unconditionally).  So it may be ok
to just include stddef.h unconditionally, but please do so in addition
to the current diff you have.

-- 
Thanks,
~Nick Desaulniers
