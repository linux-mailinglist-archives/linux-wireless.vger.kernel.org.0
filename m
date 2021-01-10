Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94E2F09C1
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Jan 2021 21:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbhAJU6I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jan 2021 15:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJU6H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jan 2021 15:58:07 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC43C061786
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jan 2021 12:57:27 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id x26so8693402vsq.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jan 2021 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI1dyqszMvncQd81wZke0E6VLoCiKKnOGwF/VN5SClY=;
        b=UBkappg2aa+dBt4O7h/ywUpC8ll8u0HTPqS3uQ9zlBuyMrWzd0OjXEiYTtNnafVVW9
         gj/fx1PUfsH9p4nZnk0XE3deh54XN5ZsyxEnqD5NEIAQz7zhVS67/lo2mgQNdWqny8Dx
         3D6XwFd+U+QYa2BvP25p4jxm2WMT5Yv9ATLejs8/ITnZYueayqTT8x3HFPJ6PDdh7SDO
         3lABPHpLbaTTsc5kTG7GX/hzIIQDFjAs3nSqfBJ/Hh58Oc7t9FF0qg+wUcFSrVpOanPo
         vCirC7Lcjz2jafpyDaF+bg4IDAfh7pSsnfUpHXvrzefvg557167HLKrtP9hrlszqol4V
         WOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bI1dyqszMvncQd81wZke0E6VLoCiKKnOGwF/VN5SClY=;
        b=KTHJwZwhPkxgfNZNKAcCF0sH1SUjd3rrjSTdhw9M8we5ZIaaU2T9Bj19/LZS3y5yfA
         Aky1sqpwDeuL/aqajRSsAJNd4VLIbEfAmZFrU7eurttoTEtg1KYkUpDyH4S9htBm7AZ2
         on/SghQbsJ7v0vuYgtogs2GNlddfDIbf7RLLa4in9s7joi6nCRNFzIxFZVy6M+AZ9wya
         MSfjKaAI/r9Q5V8gwOZpQcZl68e8F8b43jeeIqBlWOB038kUxr+hxpn1dhLWBkKWTsnK
         oza3QKjC+NBjSs4BwhXUYsLDMt7Lcw2wGFO4C7MR8YnorAV0j0yqVLEe3qMjcg02XK86
         2MRQ==
X-Gm-Message-State: AOAM530FVQ5jIuXiq6UPxVN2LLvnC+GCBHvBOFhT7yM8MYiZIaFD13tM
        JpInJm94EarrHXiM8weilgac0ELLlqx39gMtyGA=
X-Google-Smtp-Source: ABdhPJy2Hdpoct9cPuou6NfVpk4UVoEXbQXro4s4Pv0+OqMFpiH6KHKwqNm5bbqG6pZjVrHmgFxo5sQRkeDkRPTKAZU=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr10333337vsy.4.1610312246029;
 Sun, 10 Jan 2021 12:57:26 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
 <CA+icZUWcuka-6j139+89pSV5Z-r1fYVriz+wJE0gma4RO_PL9Q@mail.gmail.com>
 <CAM+r-Rj3y6DGonMPQ_V7qCwWH7v1bgh5x7YmAzMh5-cY68jJiw@mail.gmail.com>
 <CA+icZUXkwN=WT+hOop2WjwdVOp8UB93XKd07KB_EdCP5U_znsg@mail.gmail.com> <CAM+r-RgHsVSOjH8+2jaw6xJAm=ykcJa8Mw65jOma=w_yDyt5hA@mail.gmail.com>
In-Reply-To: <CAM+r-RgHsVSOjH8+2jaw6xJAm=ykcJa8Mw65jOma=w_yDyt5hA@mail.gmail.com>
From:   Luca Versari <veluca93@gmail.com>
Date:   Sun, 10 Jan 2021 21:57:00 +0100
Message-ID: <CAM+r-Rh-YmJhbDNEPGDa+=Fntp1ruEf3B6OxUWECXudsi8z04w@mail.gmail.com>
Subject: Re: [BUG] Stacktrace in ath11k_pci
To:     sedat.dilek@gmail.com
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FYI, the same problem is still happening with linux 5.10.6 and latest firmware.

On Sun, 3 Jan 2021 at 02:31, Luca Versari <veluca93@gmail.com> wrote:
>
> I can confirm I have the latest firmware installed (same sha256sum).
>
> On Sun, 3 Jan 2021 at 01:34, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sun, Jan 3, 2021 at 1:18 AM Luca Versari <veluca93@gmail.com> wrote:
> > >
> > > Thanks for the quick reply!
> > > Unfortunately, this didn't seem to work - I'm still getting the same
> > > stack trace:
> > >
> >
> > Latest ath11k firmware?
> >
> > - Sedat -
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k
