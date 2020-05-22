Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF41DF051
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgEVUEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 16:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgEVUE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 16:04:29 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F45C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 13:04:28 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 1so6733780vsl.9
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2j/2zVr3Y5MsRPnNj6wzL4hndd2iqr5mTiIwqASoAFw=;
        b=vVws4061OjMe6FdcHEsMVjvZ1Xk9IDu6m0brw3U+OG7p+bH6eN9VyYQjRhIG7uw4iX
         ILXDishHNbELZNvsC0Xgj25FcFuX/x8IoM8G80dypaOWGyRAM0MgXV16lYZZgej7z4MV
         VbyLdf/AzywlrZzOUIjroUFns4QFmzi8fi/CdW3LD+V+xAlRggCPTnfvUvBc9Tv0xQYD
         u+DJ5BGj7wpb8akIXkJOCT6bi2+UftMlCeebkkNxjNFC2ynuexCSGPprMW62nqEEWdeL
         8dW478aGvM2+klWLcCCvTl23QTalnMP5d1NMv0heTF0wWOMa3W6Dnt/577KFVl+cBRaC
         wIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2j/2zVr3Y5MsRPnNj6wzL4hndd2iqr5mTiIwqASoAFw=;
        b=l1LuLEeaAynNkBOxU5zStOPxcufWayrMr/nSsH7vLE8vxPxw/y/XUj+X4orup+TUlP
         ni3wKCWvx8X5ETpqG/Q2orutJ7f3u82B+lmwKZm95WyblTTA0Ejrpvusmiigaa7pIM8m
         Gf2+CELZUFam1blCiTIHoNtMRrSWGnaavJAMXSDauNNWzXgNEA0XuWJptX77oqvFOzRD
         r/cgctZ5s2Ei9nH/vOc0Ps5qcKDvn0V1v3q0D38h7kcAEiYoiG2hw6b/FcPMZepl3wwp
         W04y02R/E8NUwIfiv5IqsJaVxk93/hxdctDzWA+RNwb5qgDmftkTZ/M0vuqZt+uxKenh
         SnxQ==
X-Gm-Message-State: AOAM533gesVq1WsvVtNsunjdzTWY9ZL66JLTmeXL926UuH4YF8D8uYIG
        5vUVq4/j/iHHUqi40BH8kiJvv4kWsFs1B8G9Lg==
X-Google-Smtp-Source: ABdhPJyfYTVpaGTnajqYIrwJCW/hUvYVLvHG73X8BDHxBe+38JDMl1iVBQyevtFO4/yt05dFAR82murtRC636v0B9SM=
X-Received: by 2002:a05:6102:1171:: with SMTP id k17mr11816269vsg.45.1590177867757;
 Fri, 22 May 2020 13:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net> <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net> <20200522121910.254aefc1@wiggum>
 <87a720gpfb.fsf@tynnyri.adurom.net> <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
 <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
In-Reply-To: <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 22 May 2020 21:04:16 +0100
Message-ID: <CALjTZvY7yuw4Hy9timfF4HnAMPFoFHP7O-MbwZ35BUwOPDh-LA@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi again, Larry,

On Fri, 22 May 2020 at 19:02, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> Rui,
>
> Does this one-line
> patch work for WPA3 without setting the nohwcrypt option?
>

Interesting. I'm skeptical that it could, yet intrigued that it may
(I'm pretty sure CMAC is a requirement). The patch was mangled, so I
just edited the file manually. Compiling.

Thanks,
Rui
