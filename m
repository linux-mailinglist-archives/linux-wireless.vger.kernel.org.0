Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97465AF08
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 10:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjABJsO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 04:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjABJry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:54 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9F60DD
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 01:47:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m18so65474331eji.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jan 2023 01:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=798mLQgjXe76IQIl0wr8ZA1qTc0lXDNEYGL1jdAHpGk=;
        b=NJYpMwRPyko6aCe368eAIO7/g+4UO4uk5POV4brMKD4XZrzurcTUCbhngGOJ2WwhYU
         7/6R7WMWMmgaQEv+arP/A4wcXTV+q5VSH8h3CIWShHzND4sWQcwl0aaBhzMS8TYcuiEU
         YeBv792gROYLskzFGF65ti3whrRNQaLc7lJn3xhzo/VkjpmX/T4oHTBsP6SoiAofo5lZ
         cqFHdW8FJXPol0achK/uxp2oHohFM4bKniyLW1wr6WR3ilEdzDPEWJ7/OapW4SzRKK5c
         0pdhdkTimsguFKH+8zkhccLhzG2GUI/ONYRjYLYSH/4APdzYK2O1FqgSOaoGoGrcDXjZ
         X1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=798mLQgjXe76IQIl0wr8ZA1qTc0lXDNEYGL1jdAHpGk=;
        b=gnSeKmCPqrQPwPJbsD5fW4YT7kYtLNmnHGqhGKpp7bGqTVlr/Oqzjxt1i2ecquHfJ/
         d996OAGq8di51+5SlTbl7lfCcj4dmr3aZMf0V6Q+JYsRHJKcvP8bVJCzwCx8IylyfvZ7
         zcpWk+m1IYyt93DOOvr6RHZt4iefxe8/GZD+BKn7DuacQdhjqtocsTpXXcwV4A3bo3y3
         nxC+8LMNiB8h/5mcsYQyDCKYEPSgYQqS7nwhnfOohT2mWprkcHy0bvMFv9Igl2urXIUd
         CxD1ku59HclY5Dgo9T8AI/xytYqj4jsw9K12m9jpZ9/ZuiUmrxaCgyCUa4rWmjbUpX6D
         Bvvw==
X-Gm-Message-State: AFqh2kqFXklux6B+91GfAd/UAkjM0tNAN5jaOREFB5FcYj9oz8w6YhJ9
        ciKLo5BeAOQOtkTIWrWBcKnJPa1B9LzL0vZh0pir8juVekMl
X-Google-Smtp-Source: AMrXdXsEqTDWE84pn5CWDM7F1VXEJwEbwLqkyP06zh2dhnPk+dBCWaB4caIGgpEh7HZmSdy7ldvk0RuzKgrGbr4DZ0k=
X-Received: by 2002:a17:906:4894:b0:7a6:fc0f:6fe6 with SMTP id
 v20-20020a170906489400b007a6fc0f6fe6mr2296433ejq.694.1672652870858; Mon, 02
 Jan 2023 01:47:50 -0800 (PST)
MIME-Version: 1.0
References: <CAMWtyy1sSHc_DYQ3kq+FWMJKK5Wo3QEgO1yd6wQXx3x0Lp4Uog@mail.gmail.com>
 <Y6isrKS7zgMrNe3S@makrotopia.org> <CAMWtyy2EhZMd7Yf6CWXpM7f6EbzbYDu+ifpAnwpDiAP8zPoP0g@mail.gmail.com>
In-Reply-To: <CAMWtyy2EhZMd7Yf6CWXpM7f6EbzbYDu+ifpAnwpDiAP8zPoP0g@mail.gmail.com>
From:   Vishal Rao <vishalrao@gmail.com>
Date:   Mon, 2 Jan 2023 15:17:39 +0530
Message-ID: <CAMWtyy21YoW=okaw=rL2OAn49NCT2KzvFGCJLM+1vJg+NpcaMA@mail.gmail.com>
Subject: Re: Wifi 6E 6ghz not working on MediaTek MT7922 (AMD RZ616)
To:     Daniel Golle <daniel@makrotopia.org>,
        Nick Morrow <morrownr@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Daniel/Nick,

Here's the output you asked for: https://pastebin.ubuntu.com/p/kZGS227rdr

From my rudimentary/casual reading of the mediatek mt76/mt7921e driver
code it appears it's loading the 7921 variant (filename 7961) of
firmware and not 7922 so I tried to patch those few lines to no luck.

Also just tried copying over the 7922 files to the 7961 names and
tried with unmodified kernel (both 6.2rc2 and 6.1.2-xanmod).

I'm sure I don't know what I'm doing here, so if you have further
suggestions/info you need let me know?

Regards!
Vishal

On Thu, 29 Dec 2022 at 23:25, Vishal Rao <vishalrao@gmail.com> wrote:
>
> Hello Daniel !
>
> Thank you for your response - apologies for being slow to follow up -
> I will post the info you asked for soon [tm] but I note there appears
> to be some new firmware for the mt7922 (a few hours ago) which I will
> also try when gathering the info.
>
> Off the top of my head the regulatory info/region is set to US while I
> am located in India and I have tried the latest firmware off git
> master as well as another (?) location suggested by Nick Morrow with
> no luck (same results) but allow me some time (likely this weekend) to
> re-check and get back to you.
>
> Regards,
> Vishal
>
> On Mon, 26 Dec 2022 at 01:34, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Hi!
> >
> > On Sun, Dec 25, 2022 at 08:19:15PM +0530, Vishal Rao wrote:
> > > Hello!
> > >
> > > Using Ubuntu 22.04 LTS based distro elementary OS 7 with the latest
> > > available Ubuntu mainline kernel 6.1 RC5 build the wifi does not
> > > connect to the 6GHZ band (Wifi 6E) and it only even shows the 6ghz
> > > SSID name *after* I have connected to the 5ghz wifi band.
> > >
> > > This is on a new ASUS ZenBook laptop model UM5302TA with the AMD Ryzen
> > > 6800U CPU platform which includes the AMD-Mediatek co-developed RZ616
> > > wifi chip I believe.
> > >
> > > Pastebin of lspci -vvnn output: https://pastebin.ubuntu.com/p/QwM58ZkptG
> > >
> > > Let me know what further information I should provide - happy to do so!
> >
> >
> > Please also share the output of `iw list` which will tell if we are
> > dealing with a driver problem or a regulatory/configuration problem.
> > Did you configure the wireless regulatory domain the device is located
> > in?
> >
> > To have access to 6 GHz bands the regulatory region needs to be known,
> > I read that on Ubuntu it works like this:
> >
> > https://askubuntu.com/questions/701709/how-can-i-change-my-wireless-cards-regulatory-domain-dbm-higher-than-30
>
>
>
> --
> "The World is a book, and those who do not travel read only a page." -
> St. Augustine.



-- 
"The World is a book, and those who do not travel read only a page." -
St. Augustine.
