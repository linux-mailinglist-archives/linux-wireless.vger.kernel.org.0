Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96B51E0652
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 07:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgEYFJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 01:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEYFJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 01:09:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C9C061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 22:09:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so10515187wrp.2
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B7WmPqSxKkGHLwOXcalhC8FQYCxg3ob4TqLkSNgE3ME=;
        b=MDvMHnHWHRB6j+QHZqtEPXcD9WLeCDcRxBf2nbzu3eDcInxRON5LbVL4t0vdRMxWtf
         CnmRbsX8kycSD/l6HbtXB1vTKX9hhEUHfoFMZvb1xiw2zol7DR/gpgVjbmaUfvruvZvT
         CUfISFF2rBD/yNfHc74aOYhUokJ5z1BZtnecDGAwqLt++pV6Z6NpRC4uMpUgCBZbgSfG
         7xNEEyJIYDCwrJFE/c1gQFXpyvWV3jdHyaMejM/Jop9z+8zLw95LeAnnBY9HSj6Da3zY
         q37t1x07J3vsvS+uM8j/zVUrQW6B6fUB3DzYt+ibDpZ+t1YW2+a9C1P4KmKPC0Lq7afb
         cdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B7WmPqSxKkGHLwOXcalhC8FQYCxg3ob4TqLkSNgE3ME=;
        b=rLehW3OsP7vWwPPPnaC4AUAdiV6gpOC+vpY58v+l4mgPKbOF1fnkNV46shJb7aTx/E
         X422AebeB8hybIlSrfrc25t4NgA7GBRjgGMAKt/9UFc7Ci6L8ThOt8OJGqTmJMEUQszB
         7pJPTBjwDWEc+tJNJHct88O71r0Fbp5Il0n6V3i/F8tJ6jR7kUPP1AGUmRv53cyiiacV
         /00IctFpGYF1ESGPhFBdostuXu7EfjlyRFVBUdp/TfexNngWFBuTNHsnLLUOCAyU4Y2W
         EAt3rYZsD7l4miOau3VmEcgIxgxvFspIfEPznrRP1Z7O0+aJSzM5J7x0l9p8GM1n/rcw
         TqNA==
X-Gm-Message-State: AOAM533MOF+jQXnaShoTUlbV40Wtm7SogKXmw8j1sdFwLQ/0BfpjBfQs
        bzY/Isq+MB2fRC0FIz2k0mVvMm9q
X-Google-Smtp-Source: ABdhPJyOQH+I+lUOwRriQmpOTtG3236uelfyjcB3kUnnKDiaBAWJ48ynwdAd+AmGoJ3RoGZhUnLYug==
X-Received: by 2002:adf:ab1b:: with SMTP id q27mr6297475wrc.268.1590383379745;
        Sun, 24 May 2020 22:09:39 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a10sm17221451wmf.46.2020.05.24.22.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 22:09:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] ath10k: add SDIO firmware for QCA9377 WiFi
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CA+5PVA5K0naJRhBvmDmArkBWQBCuA6p2yP+pYPMr3dZ47q53aQ@mail.gmail.com>
Date:   Mon, 25 May 2020 09:09:35 +0400
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37BB0344-C9EB-41F5-87E7-D66DA45A488E@gmail.com>
References: <20200524135933.1623-1-christianshewitt@gmail.com>
 <CA+5PVA5K0naJRhBvmDmArkBWQBCuA6p2yP+pYPMr3dZ47q53aQ@mail.gmail.com>
To:     Josh Boyer <jwboyer@kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 24 May 2020, at 8:34 pm, Josh Boyer <jwboyer@kernel.org> wrote:
>=20
> On Sun, May 24, 2020 at 9:59 AM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
>>=20
>> This commit adds the SDIO firmware for ath10k/QCA9377 cards. The file
>> is from the Boundary Devices repo [1] and has the same license as the
>> existing firmware-5.bin file. Support for QCA9377 WiFi was merged for
>> Linux 5.7 [2].
>>=20
>> [1] =
https://github.com/boundarydevices/qca-firmware/tree/bd-sdmac-ath10k
>> [2] =
https://github.com/torvalds/linux/commit/6e51b0e4913ca2c93059f73ca477ca30e=
a95b6a0
>=20
> That repo got it from Kalle's untested repo, and didn't carry over the
> Signed-off-by.  You didn't carry over the Signed-off-by from the repo
> you got it from.  3 levels of indirection to include a file with a
> giant notice from an untested sources is a bit too much for me to feel
> comfortable with.

Apologies Josh, I have been using my own repack of the Boundary Devices
repo and had completely forgotten Kalle=E2=80=99s repo existed and was =
the
original source of the file.

> Kalle, is there a reason you didn't send this upstream 3 years ago?

SDIO support is a relatively recent addition to the ath10k driver and
the commit message in this RFT [1] probably explains why his repo has
it described as untested.

I=E2=80=99m happy to submit v2 with corrected references or let Kalle =
handle
the submission, whichever is best or easiest is fine with me.

Christian

[1] https://patchwork.kernel.org/patch/11162833/=
