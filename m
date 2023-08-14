Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41A77BB95
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHNO1g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjHNO1a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 10:27:30 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87152B2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 07:27:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-565f2567422so3061350eaf.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692023249; x=1692628049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvyQe/err11e1rejQfucRFO7BT3KbNdDiTv3CtcP2fQ=;
        b=gD5Z0kjBf/Ib+wC8ZbMPA+DivxSyE74GmILDkA8nm4wCtMGrx1mUL0RrjQPbuBFweL
         mK368Xchomn+7zS07D+yQw6oPIbT8o77VS+K2rsIdinsBYv8VptHYhfrX42Q8PrTNHMl
         l3UTQvsaf6BrNPCalUOB2KX+6HvExX/HKfJNr+l3AEoHXhHzIrDBIhvWivFtgVTulzJZ
         eZq7fgXqaAl3rP8hK1ZHoNoKKia7saYaCvI3gIm2gUNNNwo5Hvm8E2aezwsaQPnGrVm7
         rG2enMo6DJioSMO709MNmqFJgbrV8vN8qeiPlD3NQWghqbAZJaL9blespeacU5Wu1kTN
         uzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023249; x=1692628049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvyQe/err11e1rejQfucRFO7BT3KbNdDiTv3CtcP2fQ=;
        b=E9v1rC9C5UnpKT59aZ8/UiXRe57GdxundfNU2AJxK9R8w2U0PyNsZFxUiV6LgKXeXs
         159Q9FALzcuQMM9LKskJBvqJd65MElbY6B8yCOx1Pr8ek6xLSyM9YYFqn+NSBV6uHNQV
         gNO/RHMhgjmqT/ezqbRWQkjqlsTrisRhUZDX8JctRqwbA/zCbXuJ+x0iccFfwIYBrVdY
         kcSKPfnTCDLElAqsViPtHRA/1shpjm8Ltam44DcXzCD6tPkg/auioL37rNHKhTQ6jjIs
         J1EeDyiN6A0VwpUzl1eMtAOAUDL+9oEdx7uAGmSeMXu0+9ZgTuXkDiHqmNNNX1H411rg
         Tm8w==
X-Gm-Message-State: AOJu0Yy0lSu/x25M/tcS3ByLcTY+7i90uys/VeEi/5yoG4SBRho2DonT
        JKtr3ZzRMaIOB0lgJV1SrdGYS3F8pqh0RigfTKw=
X-Google-Smtp-Source: AGHT+IEYtNHgHTeh8FAcQXyMcT9svYRKXHHYW7wpWyPoHAjGMZQ4T7YXH5n2KFWgCGTPeWU+ysKYHHXURzRNecKG4kA=
X-Received: by 2002:a05:6820:56:b0:567:4e58:6aaf with SMTP id
 v22-20020a056820005600b005674e586aafmr7627406oob.6.1692023248767; Mon, 14 Aug
 2023 07:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
 <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
In-Reply-To: <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
From:   Emmanuel Mazurier <emmanuel.mazurier@gmail.com>
Date:   Mon, 14 Aug 2023 16:27:17 +0200
Message-ID: <CAOc87an-E=zmZcMhkaKTV7hmr4PagFq0weR=n3hzjJ9wENaPwg@mail.gmail.com>
Subject: Re: rtw89_8852ae : failed to recognize firmware elements
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you for replying so quickly.
The update to latest version with your "rtw8852a_fw.bin" file is
working perfectly: the wifi driver is loaded now.

Here are the other infomations (before the update) :

> Please provide below information to diagnose this problem.
>
> 1. kernel version you are using
> $ uname -a

Linux manu-debian 5.10.0-24-amd64 #1 SMP Debian 5.10.179-5
(2023-08-08) x86_64 GNU/Linux
>
> 2. firmware you are using
> $ ls -al /lib/firmware/rtw89/rtw8852a_fw.bin
> $ md5sum /lib/firmware/rtw89/rtw8852a_fw.bin

No file was found

And i could not log other elements that these dmesg entries:

[lun. ao=C3=BBt 14 15:39:19 2023] rtw89core: loading out-of-tree module
taints kernel.
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: firmware:
failed to load rtw89/rtw8852a_fw.bin (-2)
[lun. ao=C3=BBt 14 15:39:19 2023] firmware_class: See
https://wiki.debian.org/Firmware for information about missing
firmware
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: Direct
firmware load for rtw89/rtw8852a_fw.bin failed with error -2
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: failed to
early request firmware: -2
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: firmware:
failed to load rtw89/rtw8852a_fw.bin (-2)
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: Direct
firmware load for rtw89/rtw8852a_fw.bin failed with error -2
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: failed to wait
firmware completion
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae 0000:09:00.0: failed to
setup chip information
[lun. ao=C3=BBt 14 15:39:19 2023] rtw89_8852ae: probe of 0000:09:00.0
failed with error -22

So, for the next kernel upgrade, does the process described here
remain https://github.com/lwfinger/rtw89 the same, or should the
latest firmware be used?

Regards,
Emmanuel


rtw89_8852ae 0000:09:00.0: failed to setup chip information
rtw89_8852ae: probe of 0000:09:00.0 failed with error -22

>
>
>
>
>
>
