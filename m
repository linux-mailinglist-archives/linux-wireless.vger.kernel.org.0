Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD54C29E034
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgJ2BLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 21:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgJ1WFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968E4C0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 15:05:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 184so758830lfd.6
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RgMxKcrxfWcCrPGpUNDV3hziCJkG59Qu7/5cCUuIBQ=;
        b=IyTD+Hke82m6aRlezzLOka0h4MepZinimVyEYyRZqSWlegMfn0lYc8H/2OUV8yMtSq
         tMzhUkYkKnHUX8dcuDZIbjXEUAObRpf/BEeMw+pgRYZiIMJ96queOmywsDyVJ5OxWOxr
         HEl8PS8ayrpRyfa9dqdJZlbekwaI2p8yDlWxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RgMxKcrxfWcCrPGpUNDV3hziCJkG59Qu7/5cCUuIBQ=;
        b=hL1aJXCt/HnElX8UpALWyMUUwAR5axCV2J/S68QXai4UIGWPZKPcSrX/WlxJYhnTe4
         Qt9r2Up9yTT3nbj+OKzi7SWnIqUq/j/b0GmI4kOaIpGKaZm/y+naQngFPV6oEZgdBrMn
         heu5zEA+ykkI8dI13ctfvlZaHr4WWLfZSx2KLEnKKlB3+l04W48EDSed15ei0ZOsXA5p
         47Xt0zkHqcRXhn4C170vaYv0zqEDJvhqTB2mKCI4ZKuP7QJKaUFVgcYStW7yXkwjEqC2
         +2UzSzUS930AZAWvla0F96gzgsemgT8JUlg4KZJ8yn4aR2JzADUfsEZa7uuQHvloefXx
         As9Q==
X-Gm-Message-State: AOAM532x4DsA639xKrL+GE5jvRPqSr8foU1brr0s9QmwZFaE5kRkc8y4
        d08s2dDnluQ6EN6JhovosqZSHomQGjGciQ==
X-Google-Smtp-Source: ABdhPJyBxfyk9mVhNf6ap5xJMi7K7UIpNMVN/KIIRQomsyaX8EEdSVh6PBojUdAE0rdIjigRxyJ+Wg==
X-Received: by 2002:a19:185:: with SMTP id 127mr441536lfb.356.1603922709744;
        Wed, 28 Oct 2020 15:05:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y19sm97548ljc.4.2020.10.28.15.05.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 15:05:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a7so731993lfk.9
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 15:05:07 -0700 (PDT)
X-Received: by 2002:ac2:4d03:: with SMTP id r3mr450997lfi.89.1603922707215;
 Wed, 28 Oct 2020 15:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-3-kitakar@gmail.com>
In-Reply-To: <20201028142433.18501-3-kitakar@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 28 Oct 2020 15:04:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMXoyOr9oHBjtXZ1w9XxDggv+=XS4nwn0qKWCHQ3kybdw@mail.gmail.com>
Message-ID: <CA+ASDXMXoyOr9oHBjtXZ1w9XxDggv+=XS4nwn0qKWCHQ3kybdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mwifiex: add allow_ps_mode module parameter
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 28, 2020 at 2:56 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> To make the ps_mode (power_save) control easier, this commit adds a new
> module parameter allow_ps_mode and set it false (disallowed) by default.

This sounds like a bad idea, as it breaks all the existing users who
expect this feature to be allowed. Seems like you should flip the
defaults. Without some better justification, NACK.

Also, I can't find the other 2 patches in this alleged series. Maybe
they're still making it through the mailing lists and archives.

Brian

> When this parameter is set to false, changing the power_save mode will
> be disallowed like the following:
>
>     $ sudo iw dev mlan0 set power_save on
>     command failed: Operation not permitted (-1)
>
> Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
