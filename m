Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE29E2BB7F4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 21:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgKTUxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 15:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgKTUxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 15:53:39 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B9C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 12:53:39 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q206so11893350oif.13
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm5oQGDIWj52Bp56wXe66Os4mWl35FpTbKVQbQHjiA0=;
        b=Q/ayshPw7MqVSNseI330O4AYlTJ4Xssc3g4VnY0j0IDdzFMEowMylO8koqPB01IYI9
         t6ZFW87UdnQlfA0XS8AhgxB6uQ4CUOIKV+qklIG+JulBiVk0DopsABcifPjKvwZEFQyd
         pMDL9hBMf8V10ABQl6nxC7VrDcQcLsUU+xZeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm5oQGDIWj52Bp56wXe66Os4mWl35FpTbKVQbQHjiA0=;
        b=ijdDWyjyOb3oyxjGKj4EfAJevQUiocnMlggooZFD2cYRXi6H/a4S7kNpLNrPLQ243x
         M6GWLjC8zMKRwIzvjMx+ujDnl3vfFO5Id85Ygg61gOKTVRVHzbIULPKVdqbnT3JCy3AM
         I2qpb4JKuHV3ps7VCCfTp5jtVE793detS1kqq5aFmxMdFjMAdr3Nd5A33n5M1pQyDd/h
         79a2Mq2qtDUCnvRQigcelzrwImOKyewJqKcYAS5LAAU+czUIevLreZ9TO0k2rsU5iEyw
         5xJTs0kLPki6Oc5CAh7rJ+7YORwPJ4V67rknqIL0tFOWS89/Gba6Zn6HKLJawLDW5PW5
         uXjQ==
X-Gm-Message-State: AOAM531rElZ+YNuWXMdYz57ZQofSeO7ZdrQz04X+v2M68Dg0ui7U2PTA
        Q1PbQ6mAkO4Ma+kOoZLdpN4yWRuXa/6Bxg==
X-Google-Smtp-Source: ABdhPJxvewt9gDgNfCKamokC2QStADT4vcWhbSKrUr8QQWqIkewoHpKvEJwrHiiYtmR0vdQD6cSHww==
X-Received: by 2002:aca:df83:: with SMTP id w125mr7233885oig.165.1605905617525;
        Fri, 20 Nov 2020 12:53:37 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id j8sm2278497oif.55.2020.11.20.12.53.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:53:36 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id n12so6484979otk.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 12:53:35 -0800 (PST)
X-Received: by 2002:a05:6830:1291:: with SMTP id z17mr15586229otp.229.1605905615285;
 Fri, 20 Nov 2020 12:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20201028142625.18642-1-kitakar@gmail.com> <CA+ASDXPX+fadTKLnxNVZQ0CehsHNwvWHXEdLqZVDoQ6hf6Wp8Q@mail.gmail.com>
 <7db5b6cba1548308a63855ec1dda836b6d6d9757.camel@gmail.com>
In-Reply-To: <7db5b6cba1548308a63855ec1dda836b6d6d9757.camel@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Nov 2020 12:53:23 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNPcXtTWS8pOjfoxiYOAcRMmsqZwXe3mnxOw388MCEu9g@mail.gmail.com>
Message-ID: <CA+ASDXNPcXtTWS8pOjfoxiYOAcRMmsqZwXe3mnxOw388MCEu9g@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: pcie: add enable_device_dump module parameter
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

(Sorry if anything's a bit slow here. I don't really have time to
write out full proposals myself.)

On Fri, Oct 30, 2020 at 3:30 AM Tsuchiya Yuto <kitakar@gmail.com> wrote:
> Let me know if splitting this patch like this works. 1) The first patch
> is to add this module parameter but don't change the default behavior.

That *could* be OK with me, although it's already been said that there
are many people who dislike extra module parameters. I also don't see
why this needs to be a module parameter at all. If you do #2 right,
you don't really need this, as there are already several standard ways
of doing this (e.g., via Kconfig, or via nl80211 on a per-device
basis).

> 2) The second patch is to change the parameter value depending on the
> DMI matching or something so that it doesn't break the existing users.

Point 2 sounds good, and this is the key point. Note that you can do
point 2 without making it a module parameter. Just keep a flag in the
driver-private structures.

> But what I want to say here as well is that, if the firmware can be fixed,
> we don't need a patch like this.

Sure. That's also where we don't necessarily need more ways to control
this from user space (e.g., module parameters), but just better
detection of currently broken systems (in the driver). And if firmware
ever gets fixed, we can undo the "broken device" detection.

Brian
