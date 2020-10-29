Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7229F412
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 19:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgJ2S0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgJ2S0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 14:26:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C95C0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 11:26:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a7so4528844lfk.9
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qrar9dmRm4zwdoSrcFwY/wHsTikC9FDxVpd6kfA/rMU=;
        b=nC2+zmQ8BbqhTLDDWr43qkKPAGZIIiM2rE/6dNa6mi0K1d6OQl1UMc7FfPoJwxy6ps
         x6jtM8eI+8jRP2aq0Xv4xlQhGD5c3KvTJS3AkuzG/MBnjWIK7DrpieObKzkmYp5W8vby
         DspwpJHFYhIGvSsF6tpHBWFC3HDR93XfkClwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qrar9dmRm4zwdoSrcFwY/wHsTikC9FDxVpd6kfA/rMU=;
        b=kBAawq+iNAchOkaeHSm55BNgDKQBO1HAdjZqMEc9LKJyQdaaIWRoCS8b905+EWoZx7
         rmOjTqQiePosxAcdquVAy8CNCMMHGcUYM7vmTmiddqrl04VIV4NIXoqDFNDX3MDnMmsh
         5SkJyPWTFOIlkkNpKWXmsGWxivSYgf9qPtqRdI+cm0VRkXam4yT7Gmx7KEIwju3eC45s
         DWGDm1u+dOVds4wjAyUXg+1CNocS/FKdUcSu2w8i3Ksu8edAj0pq215KB97Gy7s9GRy7
         B+Y7h7EMlp6akMlqxSGmrq2t1yGdi6YQZB+GkwuWPDF8H1Su4IlbGAnD+mJFWBVcROcx
         VgpQ==
X-Gm-Message-State: AOAM533vFUIkk+YOZTzgPogebtVhOB1Jf0gBjCSMhKwreugCFgilbPrp
        We1y9OFTqghsv4bDQexNuUn4f3Rj4LXDSQ==
X-Google-Smtp-Source: ABdhPJzApXWhkTX+oLLJc8SkbQXAhjv+N+bZmx5/h37cEljHlXFnT3SfiVIcoTqSDb3IEB2ERaCsPw==
X-Received: by 2002:ac2:4846:: with SMTP id 6mr779073lfy.79.1603995968322;
        Thu, 29 Oct 2020 11:26:08 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w9sm413094ljh.95.2020.10.29.11.26.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:26:08 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i6so4587586lfd.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 11:26:08 -0700 (PDT)
X-Received: by 2002:a19:41d7:: with SMTP id o206mr645895lfa.396.1603995967726;
 Thu, 29 Oct 2020 11:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-2-kitakar@gmail.com>
In-Reply-To: <20201028142433.18501-2-kitakar@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 29 Oct 2020 11:25:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMfuqy=kCECktP_mYm9cAapXukeLhe=1i3uPbTu9wS2Qw@mail.gmail.com>
Message-ID: <CA+ASDXMfuqy=kCECktP_mYm9cAapXukeLhe=1i3uPbTu9wS2Qw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mwifiex: disable ps_mode explicitly by default instead
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

On Wed, Oct 28, 2020 at 7:04 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> On Microsoft Surface devices (PCIe-88W8897), the ps_mode causes
> connection unstable, especially with 5GHz APs. Then, it eventually causes
> fw crash.
>
> This commit disables ps_mode by default instead of enabling it.
>
> Required code is extracted from mwifiex_drv_set_power().
>
> Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>

You should read up on WIPHY_FLAG_PS_ON_BY_DEFAULT and
CONFIG_CFG80211_DEFAULT_PS, and set/respect those appropriately (hint:
mwifiex sets WIPHY_FLAG_PS_ON_BY_DEFAULT, and your patch makes this a
lie). Also, this seems like a quirk that you haven't properly worked
out -- if you're working on a quirk framework in your other series,
you should just key into that.

For the record, Chrome OS supports plenty of mwifiex systems with 8897
(SDIO only) and 8997 (PCIe), with PS enabled, and you're hurting
those. Your problem sounds to be exclusively a problem with the PCIe
8897 firmware.

As-is, NAK.

Brian
