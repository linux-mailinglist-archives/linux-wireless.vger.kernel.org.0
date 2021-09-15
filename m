Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798FE40BD46
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhIOBpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:45:31 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:48718 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhIOBp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:45:29 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 11AFF20D74
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 10:44:10 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id c10-20020a170902aa4a00b0013b8ac279deso192090plr.9
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 18:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ikqYOA8GQPCE7Q6OihdZpTAPd4IpVkHTbUht2zv8p34=;
        b=nPggRcXdjwVQCwuGYQClKY57wwNKLbUXAcxO+Ea2JBML5dNPGiQ8fDPH+FrGouhjic
         7KTYBmmNtdEsmDD3rTBB0sK062BjuhyigGf2uUl/zfu4mXuZw8laXTTkjZaWdymoQn3f
         RmeI0cS8U4ZVjiIujTKVwv6qy7fvH8O51L7Lxa0XVK2Hrygp8uMFYPissIcHCTBD8Fhd
         gPKP9mO0y8sGtIsU+gmZkMj9WmmDGsjfS1CCgL6Ayb8RJDs+tPNF0lXiZi/r2DbmrhC5
         wtMIOuRHNax1VjPwB344mAIcMXV77P/jFoxAvzFhxpXsLhTGp7dWL58IfXnGg+3zAOeB
         w3jg==
X-Gm-Message-State: AOAM5325l0S7/yqh3yepcLZ1sY4DaL+xBfT/x0lJAoUiA9IwrE01XxvH
        re6V9gDqmuXGEBdtJRWXQs0bxejODShzJ2FWtbLvRft84TRIRB6CeNrLEl0lHDg8J2x9zWjkuGQ
        vPcSOgPAy/ztK5ZsipwhNFbzjjFBu
X-Received: by 2002:a63:371c:: with SMTP id e28mr17486851pga.302.1631670249034;
        Tue, 14 Sep 2021 18:44:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeeyZiOwYhBYtypmYFF//c25IeBM86pjvqLlh7T8Q2BgBl54uVqmUrgfqez04HMUNyhJ4r3g==
X-Received: by 2002:a63:371c:: with SMTP id e28mr17486837pga.302.1631670248751;
        Tue, 14 Sep 2021 18:44:08 -0700 (PDT)
Received: from pc-0115 (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id k3sm2759637pjg.43.2021.09.14.18.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 18:44:08 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mQJy2-000mPg-Un; Wed, 15 Sep 2021 10:44:06 +0900
Date:   Wed, 15 Sep 2021 10:43:56 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Subject: Re: [EXT] Re: mwifiex cmd timeout on one pci variant
Message-ID: <YUFP3InQ+NYLpqRB@atmark-techno.com>
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
 <YThLznrMQ4EYUDEl@atmark-techno.com>
 <AM0PR04MB4529E0C28F43288E189D8F50FCD49@AM0PR04MB4529.eurprd04.prod.outlook.com>
 <YThQiMn7YHzPRwnJ@atmark-techno.com>
 <af5cff45-da9d-26b7-fd00-c4e91344cfc1@v0yd.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af5cff45-da9d-26b7-fd00-c4e91344cfc1@v0yd.nl>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jonas,

Jonas Dreßler wrote on Tue, Sep 14, 2021 at 12:11:46PM +0200:
> regarding the firmware version, as you can see in the commit updating the
> firmware binaries (https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/mrvl/pcie8897_uapsta.bin?id=1a5773c0c89ee44cee51a285d5c7c1063cdb0891),
> indeed the version numbering differs between the different versions of the
> card (usb/usb, pcie/usb, pcie/uart(?)).

Right. The update frequency is also quite different, so I'm assuming the
pcie/uart version I'm using has a lot of vulnerabilities left open as
well...


> Anyway, if you manage to find newer firmware for any of those versions, I'd
> be happy if you could point me to that, apparently they just fixed a
> critical vulnerability in the Windows firmware again (see https://support.microsoft.com/en-us/surface/surface-pro-5th-gen-update-history-5203144a-90c1-63df-ce0b-7ec7ff32ff10),
> I wouldn't be surprised if our firmware is also affected by that.

That sounds like a safe bet..
I assume the firmwares are not compatible and we can't just load these?


> About the command timeout, I have no idea why the fix isn't working for you,
> but well, my analysis of the issue is also just a (not exactly educated)
> guess, so it might as well be a completely different problem and my fix is
> just a lucky hack.

Right, it really depends on why the firmware crashed, but we have no way
of investigating that at the moment.

> I'd kinda hope though that my proposed patches finally wake up some people
> at NXP and motivate them to take a look at that firmware repo again.

If it works well enough it could be a reason not to bother :D
Alternatively if they can't spend time on it maybe open the firmware
code (under NDA? my company probably already has one with NXP..), but
my problem will need more time to reach them through regular channels.

-- 
Dominique
