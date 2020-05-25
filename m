Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFDB1E0E7E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbgEYMdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 08:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbgEYMdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 08:33:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04825C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 05:33:13 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o26so9794386vsr.10
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGh01TS0xN6UscNK5aus10oFdjms16LerpfIkpNzPMw=;
        b=NtZc3ihDlo2T82QQ4B+E4LXSajeb7/RtTxdTGxRwwFIg1D6mf+1pondGFCsPRm7I/n
         MzHVo8egSDWTIyg60ABaDq7qJ32UcgPBvOLkqSwJUmwUNMIVWaxwAp6kQ6VWv+NSaiDp
         2JXdvizX0ECW8GA9bvMOplxujPfIMWmra6PiXInFDNkDB7Ruuzq0a0YzeNzkVYmZxI8h
         3MMwXt6fDnGp5j3FZnfS6I8Yc6KTT7/vHhYAyT0Zl+UBmf9Xim8R0FplTcf4jBtR+Lkz
         AGjZNUZXkAil3Lbktda+6fEilJRPYxkDENn41jlQZeDnXnw78EHdyWchwjBpLeaAXmGL
         aVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGh01TS0xN6UscNK5aus10oFdjms16LerpfIkpNzPMw=;
        b=QgQWMvrPtDSHv8PmubGJ9tdt52VR5NIicVdJatkJCh/uOPx/0wNdlrKnI/wHi6RGgS
         eJaSGDIauaoZe+ffJws0Ph6JK7v1KDFYRioxvxTn/9fb/zpUezmgBcYZTWabIGD6n7kk
         hzfDu6LRFKdfSTEyMYUI6B1FE8l6K1DjgLWkpPGdnr1qItjhRsAU42PS8lkm7+TVv/rK
         G9NeoOc9uPj0ppJCjP7Co3BI537uFdjclfK/r0//g3V0v+uGq/pxAww9KRjlBk+K2vHi
         y0OruRKYRcrSutoh8wGwJQIuz/MGF5MmqUKF2Q3bCJ7nkUY6TQ3IFy4LHf5l8gtmH/Tp
         G4SQ==
X-Gm-Message-State: AOAM532mgrMgCYIf9LQHXjaiZf2I+XQZXCuLgNWxcrBiz0zWAMIG8jIe
        zKYQaQh4QoFMrKkwAxQvygv9Ke2kCbCgcg4wAQ==
X-Google-Smtp-Source: ABdhPJxXu7K1nEmlNdRtNQ5Da0APPOm3rVW2mWDq7hwHqgDjsFjTEFHGhXg2tZAdk1oLwc6R6+xdwyTiyjlJj8b/qZI=
X-Received: by 2002:a05:6102:22f7:: with SMTP id b23mr16933401vsh.172.1590409992119;
 Mon, 25 May 2020 05:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200524094730.2684-1-rsalvaterra@gmail.com> <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl> <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
 <20200525093142.GA926004@wp.pl> <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
 <20200525105814.GA926693@wp.pl> <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
 <20200525122535.GA927343@wp.pl>
In-Reply-To: <20200525122535.GA927343@wp.pl>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 25 May 2020 13:33:00 +0100
Message-ID: <CALjTZvYo6Pkq-LnaYvUTAMkixMsC0CwpaG8m43P6t5ir42J7nQ@mail.gmail.com>
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

On Mon, 25 May 2020 at 13:25, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>
> If we talk about x86, we have AES-NI instructions since 2008:
> https://en.wikipedia.org/wiki/AES_instruction_set
> Which make CPU crypto quite fast. Though it can be a bottleneck,
> I think, if wifi encryption is performed together with other encryption
> applications like SSL .

Hah, AES-NI would be great, but the best this CPU can do is SSSE3. ;)
