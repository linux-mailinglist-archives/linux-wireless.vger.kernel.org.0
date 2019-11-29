Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF13E10D0B8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 05:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK2EFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 23:05:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37233 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfK2EFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 23:05:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so17018237edb.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2019 20:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSUVC3ggQB4xLQjsKBDHLkM4F4fy4M5PEtTRPWySnj4=;
        b=Z8aADKxYdIrSSCBHE0WebFG2Y8sksQBDe+gJGDwWDNLDZLLWgUw0NbN/otBEPsWrCB
         ksbD/tyyRmIBAgkLWB/wwjaPhT4CJ4PJdimwooAy6EAGK6ZSqrHsQRBG1+zHdrTLXX0l
         Zo9jhdd2/cn0njSg1cj82rO5mz0+0Ujp8BCCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSUVC3ggQB4xLQjsKBDHLkM4F4fy4M5PEtTRPWySnj4=;
        b=AJUVEqMNWQ1/m+0+GYEYSaRLzypYj0Gd7iTs7UMEwBvECK7wXy3MfEj7PbAvA5w6B8
         /M/l3VTHOd8QX22cnhDDh4tpPuLDdD9oFn2pA7gPRCH82KbrcyzPJlFC1NRqfwkAOwXS
         TmswHBdbhFVB75p8ekVvXh2cxPNTV/Ewz7VaUWuDmHqShT9kUfQuPuasbCiPladjhckN
         D09KZUz3jk82HnyoyLIvBM6jJJkum1V/tDupxeTzJIlfdq1nJDty2C3r738ajb7pE5KE
         UGu+s2UJvH1zsGdtNGoUr4nPkXUOzU3OAO0RYCbOb/5J0B61djvmUIgCM4rsn51qAoz8
         QgDw==
X-Gm-Message-State: APjAAAV1gi0ZmZ+IFGal5DJdTXnAzdkbS3uNiGfyZHmcFuPykdDdVZgH
        +LGNxGlAfX8NYCY5gh5+ESca6qaS5awI+8GJMRgh4w==
X-Google-Smtp-Source: APXvYqzJA0oarVNbcMx254Rxgm0ocDOJdIJTZOA0fppCRnNb/55GHaFez2T3pW6EU1cmssT3oMFxhwU7MDDuZHKDUmY=
X-Received: by 2002:a17:906:57c3:: with SMTP id u3mr59264192ejr.254.1575000323169;
 Thu, 28 Nov 2019 20:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20191128033959.87715-1-pihsun@chromium.org> <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
In-Reply-To: <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Fri, 29 Nov 2019 12:04:47 +0800
Message-ID: <CANdKZ0eYSdPC2y5QxN1B7FshewXumrETQohbXrnvbovXMkSe9Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] wireless: Use offsetof instead of custom macro.
To:     Joe Perches <joe@perches.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 28, 2019 at 11:54 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-11-28 at 11:39 +0800, Pi-Hsun Shih wrote:
> > Use offsetof to calculate offset of a field to take advantage of
> > compiler built-in version when possible, and avoid UBSAN warning when
> > compiling with Clang:
> []
> > diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> []
> > @@ -1090,8 +1090,7 @@ struct iw_event {
> >  /* iw_point events are special. First, the payload (extra data) come at
> >   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
> >   * we omit the pointer, so start at an offset. */
> > -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> > -                       (char *) NULL)
> > +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
> >  #define IW_EV_POINT_LEN      (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
> >                        IW_EV_POINT_OFF)
>
> This is uapi.  Is offsetof guaranteed to be available?

offsetof is already used in other uapi headers
(include/uapi/linux/fuse.h FUSE_NAME_OFFSET).

Also offsetof is also defined back in C89 standard (in stddef.h), so
it should be widely available and should be fine to use here?
(Should I add a #ifndef __KERNEL__ #include <stddef.h> to the file?)

>
> Perhaps this is better without using another macro
>
> #define IW_EV_POINT_OFF ((size_t)&((struct iw_point *)NULL)->length)

Clang UBSAN would still complain about this, since it's the same
pattern as the original one.

>
