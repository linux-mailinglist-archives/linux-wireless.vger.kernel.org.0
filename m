Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37431FD91
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBSRGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:06:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36186 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSRGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:06:53 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id EBBA220B6C40
        for <linux-wireless@vger.kernel.org>; Fri, 19 Feb 2021 09:06:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EBBA220B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613754373;
        bh=OtU7GBrzoVc0NR5F7By0yrToS8WQrkEylVA+eGhnfd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jKNnRKDvmsKCF0g5gHNyzKzryn3Ni5mNfm8erItRrPC7u8DEaJUMKhbBjErBAqR6v
         C1Hbk8W9mt+ngIOs/C4FFfSsfzoHJ9dBPwGXk5/6hgwcUnYZy13ePQc3dj1gA6oYc+
         NedPB1fFmvMVwFZsz16LuTd4/sLpuwyDPXJL/958=
Received: by mail-pg1-f177.google.com with SMTP id b21so4952590pgk.7
        for <linux-wireless@vger.kernel.org>; Fri, 19 Feb 2021 09:06:12 -0800 (PST)
X-Gm-Message-State: AOAM531tMPn8UdFvJs+VXakbX23hrxCqvSnqZbL8znBwtCMGl0d9uV1P
        ouK5EunRgSzYUcYEBpvgrQjt+xSI8fL9BC0Yqlg=
X-Google-Smtp-Source: ABdhPJzyCx7Y7oMRtjDVDWohBfY94+gQ9glk9kirBoT87xTPWaJJ03MOIk/qgQ5qre8LxWyZZAYwfqqRu7nqMjv8wzI=
X-Received: by 2002:a63:686:: with SMTP id 128mr9258486pgg.421.1613754372505;
 Fri, 19 Feb 2021 09:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20210208113356.4105-1-mcroce@linux.microsoft.com> <CAFnufp0ypkeR65sRCPUo-08aHxift9siw5+kd1=s0xFfdi2L2w@mail.gmail.com>
In-Reply-To: <CAFnufp0ypkeR65sRCPUo-08aHxift9siw5+kd1=s0xFfdi2L2w@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 19 Feb 2021 18:05:36 +0100
X-Gmail-Original-Message-ID: <CAFnufp0dk8NYKzzN0XueE=TT-kv_QaQ973Ahs1g+JdN6EP-GNg@mail.gmail.com>
Message-ID: <CAFnufp0dk8NYKzzN0XueE=TT-kv_QaQ973Ahs1g+JdN6EP-GNg@mail.gmail.com>
Subject: Re: [PATCH RESEND mac80211-next] cfg80211: remove unused callback
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 19, 2021 at 5:54 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Mon, Feb 8, 2021 at 12:34 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > The ieee80211 class registers a callback which actually does nothing.
> > Given that the callback is optional, and all its accesses are protected
> > by a NULL check, remove it entirely.
> >
> > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> > ---
>
> Hi,
>
> Quick follow up, did anybody look at this?
>
> Cheers,
> --
> per aspera ad upstream

Oops, I see it was merged in 258afa78661178d16288537ffe8ef863c7e5918a,
never mind!

Thanks,
-- 
per aspera ad upstream
