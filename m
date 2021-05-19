Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65038953F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhESSZT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhESSZS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 14:25:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E9C06175F
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 11:23:58 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so12572671oth.8
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYOOje/Q2qRGd6n8BqEkhmcCtu27g3jFDHNzv1YTwQo=;
        b=H7OwLL/JKFtsNCseAfz+e1qYcH1xiTCmKnBrF7quhLNp4zmp3EpHTCnyt6XbeFiwXR
         O5/E6OZyevBpBi2/NvBP+/clg6hd7bN1T+j0iCV9Wb0o8fhNf58Hj+Y8sNlGrSP8UVn8
         PPva9CBchHVg3J7Q5ZZVrkn7IrYc3vJWVc9dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYOOje/Q2qRGd6n8BqEkhmcCtu27g3jFDHNzv1YTwQo=;
        b=q2vdHTSuVxOhoz2G9DDVx0rRrFC8Q+UpcNts36y+Bu/xs/B5oXjUsXr6mHIpj/KYCD
         YnL+GgRKDKoWVVhoOTnaC1LcsORxujhpi07KvInc1Etd0pxrc7Km12xY9I/HoWIZrkzC
         t4cjrn05Obn1MoisbwO/fqxqiTSqrG5wQj/6PtlJhbiR5JOQPZSpFsIOKyY0Svu/Dzz2
         uusXLY6skYEG88VdFgWpxI3aolSGLahWtarhFIIRa3Udkngt6yp4yM6jaayNhwEKWmSM
         8pBSUKFROz4j6u7SvX8C0RCQtv7pHluxhSfaus6ZVLdH4MQBin3ecYUFckShSicmRX9e
         JL+g==
X-Gm-Message-State: AOAM5312a1YIaeewWb5ByMISWLVEyMuxQDX4Najko0+Zttr6g4pIRMgM
        9UhiK/l5BPsoX8D81EqiOj5F52nfKpjxpA==
X-Google-Smtp-Source: ABdhPJw17Z9GkSHMR/gOY+a9+xoUd8nsaO7HHGUyxyMAn5LGgkTR/RL4LJFhJSML+jWT0RvK+HEv8w==
X-Received: by 2002:a05:6830:19ef:: with SMTP id t15mr679873ott.112.1621448637224;
        Wed, 19 May 2021 11:23:57 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id r124sm72316oig.38.2021.05.19.11.23.56
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 11:23:56 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id y76so4702022oia.6
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 11:23:56 -0700 (PDT)
X-Received: by 2002:aca:d68a:: with SMTP id n132mr457745oig.105.1621448635646;
 Wed, 19 May 2021 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <DB7PR04MB45387F399B5963BD92C57CA3FC2B9@DB7PR04MB4538.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB45387F399B5963BD92C57CA3FC2B9@DB7PR04MB4538.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 19 May 2021 11:23:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM4u=98XmyAH9=iXQGT8mP-z3WKs9vN=Ms20xXmJyKnWw@mail.gmail.com>
Message-ID: <CA+ASDXM4u=98XmyAH9=iXQGT8mP-z3WKs9vN=Ms20xXmJyKnWw@mail.gmail.com>
Subject: Re: pull-request mwifiex-firmware 2021-05-19
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Mayur Arakere <mayur.arakere@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 19, 2021 at 7:45 AM Sharvari Harisangam
<sharvari.harisangam@nxp.com> wrote:
>
> The following changes since commit 2a0a062e79b5fe9007e57c0fcd285e683e22373e:
>
>   linux-firmware: update NXP SDSD-8997 firmware image (2020-08-03 06:51:36 +0530)
>
> are available in the git repository at:
>
>   https://github.com/NXP/mwifiex-firmware.git
>
> for you to fetch changes up to db190ade4569c542cd257a9334f8f8956372f7b3:
>
>   linux-firmware: update NXP PCIE-USB-8997 firmware image (2021-05-19 12:57:21 -0700)
>
> ----------------------------------------------------------------
> Sharvari Harisangam (1):
>       linux-firmware: update NXP PCIE-USB-8997 firmware image
>
>  WHENCE                       |   2 ++
>  nxp/pcieusb8997_combo_v4.bin | Bin 0 -> 638992 bytes
>  2 files changed, 2 insertions(+)
>  create mode 100644 nxp/pcieusb8997_combo_v4.bin

I appreciate that NXP now owns what was formerly known as Marvell
WiFi, but the driver still only recognizes "mrvl/" naming, not "nxp/".
Did you actually test that this does anything useful? Or are you
planning on submitting driver patches to use the new path? That seems
like unnecessary churn to me, and you should just use the old path.

Brian
