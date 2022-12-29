Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEE659008
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiL2Rzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Dec 2022 12:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2Rzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Dec 2022 12:55:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EAA1112
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 09:55:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so46595670ejm.8
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LYh2NJvWZas8YI4a4QyIuQl5Ayz1JsLDPfcZD8+PXLs=;
        b=MBHGJH1/ixTYpAHbR/CCk9je2PaztiCDJ20MA1CDaO0YOZ/yEa+DJ7h0bhMKPr89wY
         NNsHFBRGLBsSB5C7zczmcFLe/0rVsEzzF0rT2PvG6cGQn94DWec0q9xDWaLNUaobVNXh
         rdOFNEin9pS2Wr8WNVM78+ke7W5GDJLr45hz92Oru0QrGq+JeuTAd+jM8vA79Gw2Xqqs
         8mTGrpEih0VVy5pNdPQYoHQxKCLtMBZSw3sjHXMQTp1H87kO+X8IJFvcC7eI45oYfFfk
         ttrwBGKUCE+7OUHB19q39XlmvHENkH2oLK6D8NFJkTYuR5fQR8UTNLcw1nTLFVbmUgNe
         CP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYh2NJvWZas8YI4a4QyIuQl5Ayz1JsLDPfcZD8+PXLs=;
        b=hriWgmop6puy/cYP0TuSnPx4l9ydGwr91LgS/5R7uStpg7gflKQBZIKfRD9jf1KH+A
         bSjdaZlsStHZN7U/r5Do4DN77hJi8sogd9kcY7+0J5owJ4PrY0SiuBJjHw4O7nwhlaEA
         LLaFOsA61HkGScZmlRLRm3zgG8DkOZzaZn86fE+Qyl81NGUdBUSbgXZGnP4Hi9IM08j7
         uHnvNyJ1w7MF4/XH6H49YP5HqR5kUOvfizLv+jIh/7Y1oC3NJz+jg3AgQf86W9mOLvQ8
         ef0R6ivFaJna3bJ0G6NTuJlXiTKHgcJ5LKHlfU94vRBYie6NMrxqTl06spwSjz6Yjc9l
         SoKQ==
X-Gm-Message-State: AFqh2krwR9gZVUGdgFLEYVIXa7ocfH26AW5N4mcJSDuByaUY4sPJTCJl
        rB3HYN1Nt9dneXSBwxjonWagVls16wPsWKPiWw==
X-Google-Smtp-Source: AMrXdXu6dRS3u/srGDYhPBnVsq7v/UC7iXVwcN+ZqAsRxsBxkwewgFIXTHo9cBn1W4PhAdmycaMh+6lzKzADQSQrzXU=
X-Received: by 2002:a17:906:4894:b0:7a6:fc0f:6fe6 with SMTP id
 v20-20020a170906489400b007a6fc0f6fe6mr1734540ejq.694.1672336534454; Thu, 29
 Dec 2022 09:55:34 -0800 (PST)
MIME-Version: 1.0
References: <CAMWtyy1sSHc_DYQ3kq+FWMJKK5Wo3QEgO1yd6wQXx3x0Lp4Uog@mail.gmail.com>
 <Y6isrKS7zgMrNe3S@makrotopia.org>
In-Reply-To: <Y6isrKS7zgMrNe3S@makrotopia.org>
From:   Vishal Rao <vishalrao@gmail.com>
Date:   Thu, 29 Dec 2022 23:25:23 +0530
Message-ID: <CAMWtyy2EhZMd7Yf6CWXpM7f6EbzbYDu+ifpAnwpDiAP8zPoP0g@mail.gmail.com>
Subject: Re: Wifi 6E 6ghz not working on MediaTek MT7922 (AMD RZ616)
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vishal Rao <vishalrao@gmail.com>
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

Hello Daniel !

Thank you for your response - apologies for being slow to follow up -
I will post the info you asked for soon [tm] but I note there appears
to be some new firmware for the mt7922 (a few hours ago) which I will
also try when gathering the info.

Off the top of my head the regulatory info/region is set to US while I
am located in India and I have tried the latest firmware off git
master as well as another (?) location suggested by Nick Morrow with
no luck (same results) but allow me some time (likely this weekend) to
re-check and get back to you.

Regards,
Vishal

On Mon, 26 Dec 2022 at 01:34, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi!
>
> On Sun, Dec 25, 2022 at 08:19:15PM +0530, Vishal Rao wrote:
> > Hello!
> >
> > Using Ubuntu 22.04 LTS based distro elementary OS 7 with the latest
> > available Ubuntu mainline kernel 6.1 RC5 build the wifi does not
> > connect to the 6GHZ band (Wifi 6E) and it only even shows the 6ghz
> > SSID name *after* I have connected to the 5ghz wifi band.
> >
> > This is on a new ASUS ZenBook laptop model UM5302TA with the AMD Ryzen
> > 6800U CPU platform which includes the AMD-Mediatek co-developed RZ616
> > wifi chip I believe.
> >
> > Pastebin of lspci -vvnn output: https://pastebin.ubuntu.com/p/QwM58ZkptG
> >
> > Let me know what further information I should provide - happy to do so!
>
>
> Please also share the output of `iw list` which will tell if we are
> dealing with a driver problem or a regulatory/configuration problem.
> Did you configure the wireless regulatory domain the device is located
> in?
>
> To have access to 6 GHz bands the regulatory region needs to be known,
> I read that on Ubuntu it works like this:
>
> https://askubuntu.com/questions/701709/how-can-i-change-my-wireless-cards-regulatory-domain-dbm-higher-than-30



-- 
"The World is a book, and those who do not travel read only a page." -
St. Augustine.
