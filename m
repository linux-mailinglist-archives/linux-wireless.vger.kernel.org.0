Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4165A59D
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiLaP6e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Dec 2022 10:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaP6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Dec 2022 10:58:32 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F836469
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 07:58:31 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x37so18088376ljq.1
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WUy8MlumuFBuUds4X4Alc2yUEpAudih0uPqgxXZ31yY=;
        b=VmCLsdHp5FVGa4aMOpf+2xOpkH03HW5kZZX7Aldr2S/CIMz37t70E8yxgY8JQQMVKe
         QcC1/N63Epb4uy3mm75BdEeIWBMJkr8l2hlzPeOd9L3bNtuzCUUNLhvOlunqLCi1Hyq+
         xA5L22TmOSYhSMho4tS+cKjX0JUQTFoU5mXKKRQFnqcrQn2C0VDuc5dpXxRR03LDBd5T
         MrB2kS2I/SlOOUbL1CncblEcynHXLAwapi6Cr7yIE/KXM74EP4nUR0sL2j9bXDbzz9Fw
         RQemzIrce+c68JzGQGf1JeGQQ3buYy6VwXghCvLe/m43wLBAPxha4SEis+YrL1cSdcAf
         gZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUy8MlumuFBuUds4X4Alc2yUEpAudih0uPqgxXZ31yY=;
        b=GLimOHgUjt2iMu+OupcuwClKEyF8YYPDZjcUuK08AtayEZZyhOkRCGzpsI9JCea4Ys
         edndCF6EH+jnTRKMa9ssLKJjBCxmPDz5XFdhjMhaa4yPZ3QML9ZtZT6MerJEmo9mMCCX
         yCDLi+sMECwEBgbWNKnaZBTxO5PnbyII5JCCb1lhh4bp30QZEgoSqbjHIZej6Q+0xRrm
         SI2JwBHpKQvgqCi2rBA4c+H1Qr7aEpX6eYNLahjwB4NcVJp5QX45TA1bpV+21YYCxMWL
         mgYGiBoXaC4S+VEtj/kwCNG108DkvBJH11i2RJ6fTvdAZQjfNDaFUiuVR9+mT8EnE8UC
         Y+Og==
X-Gm-Message-State: AFqh2krNg02YXm5UTp/JnZXVwRgiwejGz3W5DgnSttBdKmuZDwTeMhqT
        w6EtfICY/kmhWMOAKv/Vq5jDf6kJFCoyCvKrcxE9moRin9g+clsc
X-Google-Smtp-Source: AMrXdXvLq28zMEy6QOelvnWOvV7pfsSm6FYI7meVVzRh3fwbKe7bx0MoNjzfBNr9vQDH0qEllDLWAE77h7N3nkPbYG0=
X-Received: by 2002:a05:651c:49c:b0:27f:e6b3:7775 with SMTP id
 s28-20020a05651c049c00b0027fe6b37775mr130651ljc.512.1672502310180; Sat, 31
 Dec 2022 07:58:30 -0800 (PST)
MIME-Version: 1.0
References: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
 <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com> <CALeDE9O_qX_Gu1vwCLW_PbMdgnSoHTA5LhxYQrsUqwGHRwv-Eg@mail.gmail.com>
 <9229905f-e7a5-aa86-c3f6-887046b8e663@i2se.com>
In-Reply-To: <9229905f-e7a5-aa86-c3f6-887046b8e663@i2se.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 31 Dec 2022 15:58:18 +0000
Message-ID: <CALeDE9OFbrf5x-3CRecXkYxb-2Z1YgH7d4Yk4RPv4Wn+zinhbw@mail.gmail.com>
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
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

Hi Stefan,

> >> could you please provide a "bad case" file list of all firmware files
> >> for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can
> >> reproduce it?
> > What do you mean by the file list?
>
> if you look into the firmware directory which files for
> brcmfmac43455-sdio do you have? Just the bin file?
>
> I'm using the rootfs of Raspberry Pi OS which contains:
>
> $ ls brcmfmac43455-sdio*
> brcmfmac43455-sdio.bin  brcmfmac43455-sdio.clm_blob brcmfmac43455-sdio.txt

As shipped in https://mirrors.edge.kernel.org/pub/linux/kernel/firmware/
either the Nov or Dec releases

The kernel supports compressing firmware with: xz -C crc32 "$f"

Regards,
Peter

> I didn't say please add some files, i only need a test scenario :-)
>
> >   We're running the latest upstream
> > firmware, we do used compressed firmware but that hasn't regressed
> > with any of the other firmware, this is very much brcmfmac. With the
> > same firmware it was working on 6.0.x and reboot into a 6.1+ kernel
> > and it stops with nothing else changed.
>
> Yes, i agree this is a regression and yes it's definitely brcmfmac, but
> based on your bug report i wasn't able to reproduce.
>
> Regards
>
> >
> >> Also OpenSuSE seems to be affected [1].
> >>
> >> [1] - https://bugzilla.suse.com/show_bug.cgi?id=1206697
> >>
> >> Regards
> >> Stefan
> >>
