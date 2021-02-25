Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C9324E82
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBYKqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhBYKoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 05:44:07 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4FC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 02:43:22 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n14so5367461iog.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=o+66sYmJGbUJGKVGmOUbFs+HLj6jQvunqDlN34SUE7Y=;
        b=o6KqRFNsUw8u3eABvt2sx2K1TxYbNlr7Ze8z71OHJtTJS2epy3zSmMz6Lyt2+Vp/gh
         2ueIQj8DibFLgfFJJjzmfA+65rUA3SqdR3JJ8v5qRbNWYDafXXdPmlVe89oOi05H631v
         gRbTXsxaHMupAJzl3f4erMttU6uQEA04ccYJNKPsLTkNIuAIrOq6v4iDyPZyYWyXkxIW
         Ooz/G7BlZsHEZf6bp1McIpgb0vWhfk1+doHo5pYBStaUtEjd+cW4fL4MpApLoPnSbSNz
         VQova9yFNuqj3XNtzHYFIoDn6q/6Mne18Cafz0cZSu1C1D68pvsJ4D+AJGa+s3FsoNah
         sGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=o+66sYmJGbUJGKVGmOUbFs+HLj6jQvunqDlN34SUE7Y=;
        b=kgEP439C4mHsMi6XT+efAigFqALjnS/MKbKAyjps3p5lTdOr9U1Jcwda5ckUDeGx5Z
         KzGvm7puMel5MpP95irG9wUgBnRjpgY3Y1IFclW50+2pAxmGje25ht6kVgfHu4x3UCfj
         +ji6HzzepyMWvGsPKoFmv8Z1r+rs7H/D4g6Fce4tX4exdUez+ZSrT2AWduXCZJ/iDv63
         j4Ezzm3floUo8oUBrh4ELP/UUdWi5UuJ+CHJAhJ4K/ue9fDg/rsqTStxcHDkedwn4xfw
         TI9OIQFQ1sc5qYGGOMqrh4SHbYdzbwgytoRbG2oUJ7KLCTS8nkUKjX/FQ617b54Hwnzo
         XTQQ==
X-Gm-Message-State: AOAM530KAI1iDRuB8K1KxckYjPOVtCT84H+5LtyKkID24OPFcZObC4Cy
        KwNxcZ4cCZhuT/qDkNF+24bzwplYq1mKEK/3NpSBSfwAwfvR9A==
X-Google-Smtp-Source: ABdhPJzh+3USgHAYwJxd8Are4TpJejdGef449YtIambCYzY4zo4FjM3BSEbFuNjwSEiuCusduycyCxc2ZsUH6KbNedY=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr2070870iof.57.1614249801643;
 Thu, 25 Feb 2021 02:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid>
 <20210222072314.5E796C433C6@smtp.codeaurora.org>
In-Reply-To: <20210222072314.5E796C433C6@smtp.codeaurora.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 25 Feb 2021 11:43:09 +0100
Message-ID: <CA+icZUXAd=oKcUGRUZSQwmBSXT6fJ_q_H26+WGvXZspS-CEftw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: avoid crash on unsupported debug collection
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Andy Lavr <andy.lavr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 22, 2021 at 8:24 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Johannes Berg <johannes@sipsolutions.net> wrote:
>
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > If the opmode doesn't support debug collection (DVM) then don't
> > crash, but just skip the callback.
> >
> > Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
> > Reported-by: Andy Lavr <andy.lavr@gmail.com>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>
> Patch applied to wireless-drivers.git, thanks.
>
> 4538c5ed0f7e iwlwifi: avoid crash on unsupported debug collection
>

Thanks for the patch.

I have seen a call-trace with my first build of Linux v5.11-10201-gc03c21ba6f4e.

After application - all good.

[ dmesg ]

[   44.744486] iwlwifi 0000:01:00.0: Detected Intel(R) Centrino(R)
Advanced-N 6230 AGN, REV=0xB0

[ lsmod ]

$ sudo lsmod | grep iwl | sort
cfg80211             1200128  3 iwldvm,iwlwifi,mac80211
iwldvm                176128  0
iwlwifi               348160  1 iwldvm
mac80211             1167360  1 iwldvm

- Sedat -
