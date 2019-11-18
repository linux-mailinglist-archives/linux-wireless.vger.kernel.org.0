Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE0100D45
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKRUrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 15:47:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32933 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKRUrj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 15:47:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id m193so16682210oig.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aJEcUG2238v9LncOn9RHyMR7e/nMXw5DzhZQQCIUhQ=;
        b=kpbF4FYt0PjZBlirriEm2AVXkPyNVaSrPrlZGx48bYbyzZpsgeQqa9ULm1Lzk96X+O
         /p6cPRzB7cK2MN7pfD/htKZTdDHw214Vn06bbLpFzdM6HEbRmOMLzgaNLwDWTl59ClAW
         0SMwkE/sCcQSmkFzpPUZsmTNkQ8fOZ7C04jt5NfXxVT7EhnMEGruFnrH+SxxIsfaIlJg
         iPw5fpqpkX99zx38U/gYYTvEDpgELB6hjZNTJ48ZsjvGqYgqCYaOUJP/fe4coQQeTUSb
         L0VK5gA36mihgDUMkAH/Vy+PPnorm+3n8RmKD3pd6cyOvCFd+VuPJmNRmrjRzn9GDrXq
         RaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aJEcUG2238v9LncOn9RHyMR7e/nMXw5DzhZQQCIUhQ=;
        b=hIAvvQO4QvZdgSJ/C7fAbagyffqXaE3YzmAxXH1RaYP9q0ycgPDZQSoP3E5TfuN8wO
         jgZMEGj38LaArs7za8KUUGiXRJwvsg61woOalZjVsi031UcGWcfB3zlbAYneLDwC/yXn
         LNDXvbzEpOINT7w8uFZ53oVOscyfODdbQLLjwOQhUmeEoaqNQUbnKFk4o5aBGMmPGUOH
         7YdlEDFfHtRmiE13RSf3ZkG7S/RdYdIfCICZnRmNgYhUB5e6z8gCbPAtLFdzOB6cLs/+
         rVcUx5PKo7uRXWmqU2vz7TSj5yVaxoj2Zs2FxdJK9JdvWVCC2iZ3YV2T7W+iJFMludQv
         tRog==
X-Gm-Message-State: APjAAAWiZ1ePulDsFSjeOjA9WJzNFXBa3Qke4c6OtzefSAq2tkFvXIPI
        a50z/jVOUYMzB4dJXnFKNX/bk3CxPW/6+NoKPkw=
X-Google-Smtp-Source: APXvYqwr9eaEVlI2DISu5+aXpG0ftTJRQZx1l82B0cqHX7STIn+y2SQLveNjPQ3P2bGU+z6UD/AYo0CLcEonMornjU0=
X-Received: by 2002:aca:504d:: with SMTP id e74mr830482oib.140.1574110058528;
 Mon, 18 Nov 2019 12:47:38 -0800 (PST)
MIME-Version: 1.0
References: <CAFBinCAbmvUJym2KD5Y4DcF_iGUwB6SrQSGd7qU6qmuctJ06Cg@mail.gmail.com>
 <CAFBinCD8TXZD6q662kFm_ZNe+kUi74q=SaEz_PHUev=AnWZSBw@mail.gmail.com>
In-Reply-To: <CAFBinCD8TXZD6q662kFm_ZNe+kUi74q=SaEz_PHUev=AnWZSBw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Nov 2019 21:47:27 +0100
Message-ID: <CAFBinCCY=9Acen_YSkCxrwgx0txCGym_qVax9GfaVL7WC6MKWg@mail.gmail.com>
Subject: Re: BCM4335 SDIO firmware crash/problem
To:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend and linux-wireless supporters,

On Sat, Nov 9, 2019 at 3:55 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Sun, Nov 3, 2019 at 12:49 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > The Android installation that my device came with ships a newer
> > firmware version: "BCM4335/1 wl0: May 18 2014 16:56:54 version
> > 6.34.171.58.2". This is also available in CoreELEC's repository: [2].
> > I went ahead and used this newer on my Arch Linux ARM installation and
> > it seems to have fixed my problem
> I am now at 12 days of uptime and wifi is still working with that firmware
gentle ping on this
I can send a patch against linux-firmware if you want but I'm not sure
about the license or any internals of that firmware


Thank you for your help in advance!
Martin
