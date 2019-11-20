Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9110437A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKTScP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 13:32:15 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36373 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTScP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 13:32:15 -0500
Received: by mail-ot1-f48.google.com with SMTP id f10so493086oto.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2019 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTIdHp6dlpMGaskgZiCPLXPinyi/0CX4k+rvt+5+ras=;
        b=Npa6zD9injmFt65NPLxPIsU/qcKhWt8ZHNCM+deRJwYmvjWEuHrA7NL1mEybZn3v30
         w/qo2/KWNPCcjAZ8Qc3GQXmz4X9nDsX1phJaM1Th2CvN4nvgYpocMtiVEzb0TChL0bFT
         4oxnkw/A+q/hM9PlXrih1p6wBlhkd5yITfSrFUwo5wVrtK9nBBV3TCJ7UzxwH9SEfJOn
         Ture662yDpkIJDrH66rPvpl+7EVD5/r4Qc7IzKp9DVJFN7ZF2MdxFb7bTzZ+LEcl8N4N
         nrJFLnEaJTJsdPn8aN1PlXeBjxXGeIP7sRrlWsqO4KpBVNP/Uv64drRdRPTv3jxssTYc
         n8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTIdHp6dlpMGaskgZiCPLXPinyi/0CX4k+rvt+5+ras=;
        b=I51b/hVJFO7tyKr1YtDMljIvPyA9y5YYEZxdi6huzXBXVZME5kU01WXJyzMg7sr3e4
         X2Qj53yzwbl9CAqwNIAK0LUcRhNRLawQotMv6U7DWdDofio+3v09aYC7k0LFkhBMWH2f
         aUmZyrQmLS9/QWgAjyLhOqlWk5oGd58wxTljMKvxkmmntn/XxGWXzhVcVO8cEKOPDuVz
         4eA0CkZrYsIsSwHGB/RYTs7u4kR6RRXVKNHxIDMuHS6Ai+SDJkH8V0acHYnCpL9bA0fv
         kq8+DC6dJ6rU0I0pZB6RbiEvpfCWpB7qJtxtJ7xS0X1LM8mwCgidDEYd7JRxl8t7SwFB
         TNxw==
X-Gm-Message-State: APjAAAVQpEMyXvFzySnr05Bo0vNstp5/Yl4UIG1rsZ/UjMj0Jy+QPBHm
        AieEiwHgWD1fgHk3Te6DzhxxvaQ1Rxg6h4ykJT4=
X-Google-Smtp-Source: APXvYqzlktP+HjBnShL+vnfbfBe02VjccXWeo+i+NkojUlSCiasWakFDEfvC3klHLauKK6zIBUiq5EV9ucu9OMDEf1A=
X-Received: by 2002:a9d:30d2:: with SMTP id r18mr3061388otg.6.1574274734064;
 Wed, 20 Nov 2019 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <CAFBinCAbmvUJym2KD5Y4DcF_iGUwB6SrQSGd7qU6qmuctJ06Cg@mail.gmail.com>
 <CAFBinCD8TXZD6q662kFm_ZNe+kUi74q=SaEz_PHUev=AnWZSBw@mail.gmail.com>
 <CAFBinCCY=9Acen_YSkCxrwgx0txCGym_qVax9GfaVL7WC6MKWg@mail.gmail.com>
 <8c5c682c-da4b-0fb4-2173-8c3082614a56@broadcom.com> <f8351761-b5b4-734d-7fc8-aae37023d222@cypress.com>
In-Reply-To: <f8351761-b5b4-734d-7fc8-aae37023d222@cypress.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 20 Nov 2019 19:32:03 +0100
Message-ID: <CAFBinCAuEcWcHk3S-z9GgFpB7cxO81HXUjKxTCRDKWRBcYH+Vw@mail.gmail.com>
Subject: Re: BCM4335 SDIO firmware crash/problem
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

On Tue, Nov 19, 2019 at 3:35 PM Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com> wrote:
>
>
>
> On 11/19/2019 4:53, Arend Van Spriel wrote:
> > On 11/18/2019 9:47 PM, Martin Blumenstingl wrote:
> >> Hi Arend and linux-wireless supporters,
> >>
> >> On Sat, Nov 9, 2019 at 3:55 PM Martin Blumenstingl
> >> <martin.blumenstingl@googlemail.com> wrote:
> >>>
> >>> On Sun, Nov 3, 2019 at 12:49 PM Martin Blumenstingl
> >>> <martin.blumenstingl@googlemail.com> wrote:
> >>> [...]
> >>>> The Android installation that my device came with ships a newer
> >>>> firmware version: "BCM4335/1 wl0: May 18 2014 16:56:54 version
> >>>> 6.34.171.58.2". This is also available in CoreELEC's repository: [2].
> >>>> I went ahead and used this newer on my Arch Linux ARM installation and
> >>>> it seems to have fixed my problem
> >>> I am now at 12 days of uptime and wifi is still working with that
> >>> firmware
> >> gentle ping on this
> >> I can send a patch against linux-firmware if you want but I'm not sure
> >> about the license or any internals of that firmware
> >
> > Hi Martin,
> >
> > Sorry I did not chime in earlier. I have not looked at the CoreELEC
> > repository for license files. Without such info I am inclined to say you
> > are not licensed to redistribute the firmware. The BCM4335 is
> > end-of-life for us although maybe Cypress is still selling the device
> > and may want to provide a firmware update.
>
> Hi Martin/Arend,
>
> 4335 is not in our supported chip list, either.
thank you for the update!

I am not familiar with the firmware details or your support process so
I still have some questions.
Can you still share the "last supported firmware" for BCM4335 so it
can be included in the linux-firmware repo?
"Last supported firmware" in my words is the latest binary that you
shipped to the customers back when BCM4335 was still a "supported"
product.


Regards
Martin
