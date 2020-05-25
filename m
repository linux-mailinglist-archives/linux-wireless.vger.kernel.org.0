Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A711E0F2C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbgEYNNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390674AbgEYNNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:13:40 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A01C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:13:40 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b28so7840233vsa.5
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS4Nr4R/2lo7q2s6YLSnM3hjDkSQMKvaPLu4IlIqnDI=;
        b=HGfoqZcZRD0UpcvpRGHxpTFw15Y/ttMmN1aoGHAdaHfC/al+K6yoZf6pnUjFAFfwnV
         4i09+Xt4u8jloLUrVehltESui1LA4PQVLA6a3a8eguUgLEhFFZsbVYtN3P2OCR9WfMIc
         3hkTIb6DLDdoV066B/iSytj/a522y090WLFwMCDGKYDLCi+V9NVbCiJEVHDzqYscbi1+
         SzSp6auUGZ5/zsRFQ0s3yYfsW5yiVqBFmu4HXwWNgA4+fQlEeqbQ+nRJFIB0ZA2+EGO3
         3J+u3E+ovK+mBIz1RIz40bL/SQVxs2cR7QxOMqSmWvlqazPD18tobpc5OKDWwNrmEIrZ
         OxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS4Nr4R/2lo7q2s6YLSnM3hjDkSQMKvaPLu4IlIqnDI=;
        b=CIXx+gdmuaXUup8osMuLpuKMIkWhNvCGtHFNnm3e9synfV5C8xotoFPTX39p1srmJ5
         ZSbFzMXFDOm2yb6C9DAQnesBhQYRzEDAX5jCxbWEheavNcpxCU1a3WiNG5WOpiX09ecP
         mex/vVo6YUUFkWrAmrV1mSm7cPb/adUc5qIaGiwJ5qUO+D4g6Gd4VsuvwBtT61wQi2dK
         Fe6nA2/PV0ahl0TMaWwbqWkMH4y+KiJafAShu8039si/OT+YRQ6LuYuMkj7RP4ll9N3l
         QLdPFt4J2VI6Z6fGv8tmIxh5CfOB2ZWPfE+qWRZQz1aa68zC0YPqwUbSrbGtHfK91X8o
         /0zg==
X-Gm-Message-State: AOAM532NEYEadcbZ177nd2Hk+eCcPVzLRVRBIYN449NZXZ8Nvwg0FFt9
        +tApLw/A2hLPRWGFntc/+cylj8piAJ2AGPOaBA==
X-Google-Smtp-Source: ABdhPJwZEkgsDcloA3m43+pEeAPQJB7mOwe/kHwdYeOGgg6YUHj/Niq/UZ4CcdLcSvRrnwfYPMS6WsHLBuIGoCewbU0=
X-Received: by 2002:a67:f313:: with SMTP id p19mr14439438vsf.63.1590412419928;
 Mon, 25 May 2020 06:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200524094730.2684-1-rsalvaterra@gmail.com> <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl> <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
 <20200525093142.GA926004@wp.pl> <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
 <20200525105814.GA926693@wp.pl> <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
In-Reply-To: <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 25 May 2020 14:13:28 +0100
Message-ID: <CALjTZvbNdQw4uj+n231d9R39F_MNn=nrj9_aL71am4Wy7jnh1A@mail.gmail.com>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Julian Calaby <julian.calaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 25 May 2020 at 12:14, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Hi, Stanislaw,
>
> On Mon, 25 May 2020 at 11:58, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > Yeah, and at least without nohwcrypt=y we can still use HW encryption
> > for non-MFP stations.
> >
> > Rui, feel free to repost your patch with additional sta->mfp check.
>
> Sure, will do. :)

Wait, scratch that. The additional sta->mfp check causes a NPE, sta is
probably null at that point.

Rui
