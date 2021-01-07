Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03592ECA95
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 07:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbhAGGji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jan 2021 01:39:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60106 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbhAGGjh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jan 2021 01:39:37 -0500
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxOwh-0000up-5R
        for linux-wireless@vger.kernel.org; Thu, 07 Jan 2021 06:38:55 +0000
Received: by mail-oo1-f72.google.com with SMTP id l191so3573490ooc.15
        for <linux-wireless@vger.kernel.org>; Wed, 06 Jan 2021 22:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gc+fC2uzrPTIv/OjMkzLquFL5H8Wh/2Rm6W4yaQ752c=;
        b=l0x5jY/szezaw7kGSYEZYNMzSrdoSY7qfxHKV70/NmX6HM/1gtbxxaMjIo8u8gQAGL
         lKDFRQyCO4U2ep7ZThhKcNBAH63bOgF6FvfgFck34Cxrwa6lTuDwjo8MZgJOH+FRgGSJ
         BHB0bUwjNP0DnTiihQcasbUa/6RzdT58qXca1bqAg24xSKuQo71cPCfd+C33LM1SR182
         H1xD3tdRsQbEgmdEWh0bbdizQfAV3v0tZe9E5F7jh1zmVkTJqAFRsRjdjTB7O8Y83tY4
         fkwLFQowxTLXML4lsQyfu2b5B5Uzui/rC6CQ21RspegOPrKG8eQc1VgHD40BfnIYjM60
         jJpw==
X-Gm-Message-State: AOAM531ddf4BhOsEIkE0nqnF5eAqSfHTnTUSf4RHPD7h0k1/Y54WLaWF
        ejmhbAxA6OoWdNEUPTDRIcc5IUEsa69+4IA4qO9IaEMEnXGO9yv+iBHHP1L1wHZaHc0WW1DRDeA
        HpyoGm41+ILAbWF3jz5037pb35RZ6qMeaAOxR4e5o3TNoJ0RpIlnGyIigUKKK
X-Received: by 2002:a9d:4816:: with SMTP id c22mr5539016otf.358.1610001534167;
        Wed, 06 Jan 2021 22:38:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIfDhiYPhS3S5PaeEdW+dFoXwmfFeAUrAJeItJZ9WP8HUWgmpU0R8GvY6EhnjGOtDrahFqtDToLumrSeZxMyQ=
X-Received: by 2002:a9d:4816:: with SMTP id c22mr5539001otf.358.1610001533893;
 Wed, 06 Jan 2021 22:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20200805084559.30092-1-kai.heng.feng@canonical.com>
 <c0c336d806584361992d4b52665fbb82@realtek.com> <9330BBA5-158B-49F1-8B7C-C2733F358AC1@canonical.com>
In-Reply-To: <9330BBA5-158B-49F1-8B7C-C2733F358AC1@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 7 Jan 2021 14:38:42 +0800
Message-ID: <CAAd53p6SA5gG8V27eD1Kh1ik932Kt8KzmYjLy33pOkw=QPKgpA@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8821c: Add RFE 2 support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 5, 2020 at 7:24 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Tony,
>
> > On Aug 5, 2020, at 19:18, Tony Chuang <yhchuang@realtek.com> wrote:
> >
> >> 8821CE with RFE 2 isn't supported:
> >> [   12.404834] rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
> >> [   12.404937] rtw_8821ce 0000:02:00.0: failed to setup chip efuse info
> >> [   12.404939] rtw_8821ce 0000:02:00.0: failed to setup chip information
> >>
> >
> > NACK
> >
> > The RFE type 2 should be working with some additional fixes.
> > Did you tested connecting to AP with BT paired?
>
> No, I only tested WiFi.
>
> > The antenna configuration is different with RFE type 0.
> > I will ask someone else to fix them.
> > Then the RFE type 2 modules can be supported.
>
> Good to know that, I'll be patient and wait for a real fix.

It's been quite some time, is support for RFE type 2 ready now?

Kai-Heng

>
> Kai-Heng
>
> >
> > Yen-Hsuan
>
