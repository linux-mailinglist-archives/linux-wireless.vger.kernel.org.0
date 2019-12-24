Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E077129EEA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 09:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLXIQQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 03:16:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33069 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXIQQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 03:16:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so3661251otp.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2019 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65owg5tS9EjyjBHFZZMLtS7eIG4lkQn3GdrTFT0y6GY=;
        b=queP6YwX7qd1b62fWy5ua6Etvp5mKgYeuMifv0Ya7LA/JQXEf4eIS41ZGTKZsRPcH+
         RFyq1V/aNBAjvxkcqC6Jl+Lngi9Cq9KflXs2/X1/qTgBPe6b3ZZJSf5bqZYHOVSyc3pv
         HIwLHiRKX9UL2fOFoSlSmP3W7HFkU4byhvEO+KU0ISrO3Ic1arSuYdFjkBfyvirYJ3Pe
         8XNYiHTnd88kcyxA76AAro3WOTaGpjiTSVI5MrCkFZrrhE61OQw0hDTZTXlMwf5PHO9X
         hem1QrRUg8rrLLtbBxL04yA57zNggCTJCyjGUHKeMz3V98YWwpVJBUfUhtBmv+W6aICm
         Y+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65owg5tS9EjyjBHFZZMLtS7eIG4lkQn3GdrTFT0y6GY=;
        b=ZZKHevyRueHwM9Q4oWOWiSG4btkeiNq0i+20lf8y/xEXzafdNPhh7hPfLEZ16bK20A
         lTeMvGCbhsY1A2BPC2/7Qy4meKYJzGhHFPEuWeyY1/DAYXnu+nVZtUtaILCTzbxiR5wH
         fyO14ozJLcHT4i3X5FhM/rpJfrsF2PmJAaHWpu2uqkr95otfMXOFLzCNnpxmeMkONdoy
         8HS44WX7nDrSKtg8KatWzCUU+ToJIn9bUfUCZSRU6hT5j80tlVfG42O8usvEGwCu1BVt
         zREkYto1IGssR4Wpf1dJBKydknZ5jjcTrT6ee4pIMed0eMDNLmynbHp8bldMTeD7cZ/k
         B34A==
X-Gm-Message-State: APjAAAXutvGVqnWnBocdj+GVIaX4aMRjSIqRj3jHGbRybLNyNvTpKOKG
        UnD9/oKYrB3Sl4yGyBI0zOEeC07RESj3Nep1gyuleQ==
X-Google-Smtp-Source: APXvYqw5+2kFSXTAIDKeZvCoQ07RQQKuMIrKm0y+AUsemA0hX68SAnirj69aO7Y29+whhEWAZfFHTHOaNuKTEWMGwsQ=
X-Received: by 2002:a9d:774e:: with SMTP id t14mr36664193otl.358.1577175375116;
 Tue, 24 Dec 2019 00:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20191220092156.13443-1-yhchuang@realtek.com> <20191220092156.13443-6-yhchuang@realtek.com>
 <CAB4CAwfhn10dWO8Fr5Bk1PMOAYTC-RVK2fVsh92kUDxdsr3+ZA@mail.gmail.com> <2fefc26a026f47f1a34b2592040da1ec@realtek.com>
In-Reply-To: <2fefc26a026f47f1a34b2592040da1ec@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 24 Dec 2019 16:17:47 +0800
Message-ID: <CAB4CAwcHj+AZgXNz6Ytu2rGJ1fMNigiAx22NJOGVYx49j-sa-A@mail.gmail.com>
Subject: Re: [PATCH 05/11] rtw88: 8822c: modify rf protection setting
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 24, 2019 at 3:50 PM Tony Chuang <yhchuang@realtek.com> wrote:
>
> > On Fri, Dec 20, 2019 at 5:22 PM <yhchuang@realtek.com> wrote:
> > >
> > > From: Chien-Hsun Liao <ben.liao@realtek.com>
> > >
> > > According to some experiments, the original rf protection
> > > setting can not perfectly make sure that there is no hardware
> > > pi write during the direct write. So, modify the setting so
> > > that the hardware block of pi would be turned off during the
> > > direct write.
> > >
> >
> > Sorry, I don't really understand this part. Does it mean rtw8822c_rstb_3wire()
> > is to disable/enable the hardware block of PI? In this patch, I can only
> > see the code block of ENABLE_PI/DISABLE_PI been removed and some
> > rtw_write_rf()s been protected by new rtw8822c_rstb_3wire(). If the new
> > function is to replace the ENABLE_PI/DISABLE_PI, maybe they should be
> > removed in the reg.h. And It seems rtw8822c_rstb_3wire() is only for 8822c,
> > means there's no such problem for 8822b?
> >
>
> Yes, rtw8822c_rstb_3wire() is to disable/enable PI. Only 8822c uses mix mode.
> That means, 8822c uses direct write for RF registers except for register 0x0.
> And 8822b uses sipi write (indirect). So 8822b doesn't have such problem.
>
> Yan-Hsuan

Got it. Could you also explain this in the commit message so that we
won't misread
the code? Thanks.

Chris
