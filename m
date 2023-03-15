Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8266BAA2F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 08:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCOH6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCOH6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 03:58:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681E24134
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 00:58:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so8164489wrm.10
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1678867123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0+FVVbgQfQey9ag+rXoOsS1/p+YXI/B5OtF4Uzr6tU=;
        b=aQAUtAA7NhuQxrZMgRbR5rnZ8qlnqWUaojVy0+xEvTPZ8Tz4oEPcLNuK80ZEqaaPqv
         COlCKMyPilumJiicbHSCRjs6dBhHl52xnjaMQxM8pQCgthcxkpP19NzjXQpn8di3bF70
         l99C9joduCH4pTDQ17AITUqNkLPhTsBH9e5Xnj3JMRpFCYzgs3rweMz0FWYxb6xSYpyT
         xuWfdussIIcaWbpmiMW5IXQgzDCLvuAJH9wyDbM/9pU46oG6KpH8p6qDISfVq0XUq3Fj
         zcp3uXpGgiG82WZpe5LJ7+jnpgcgeRvU5cRBKgQSZvXB7FNOU35DcN/Qgt/MIwVI2xQ9
         TbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0+FVVbgQfQey9ag+rXoOsS1/p+YXI/B5OtF4Uzr6tU=;
        b=OgdbZpze4/EZan9Wjl0nVYg6x+dt1UAlrdTjDo2Tg/QovSz7d+SD5P9SzYk3acljDg
         sw+Ao9+BdgFj7P6s/ZBiZhrfKu5MyYASQKsBu+5Up0LmRJati3Tj+au3oyXw3XZn5LYK
         6VDBiPLms7Ggstv1pG49bQzrbbYGC1SF7+GSIUg4XnemK/bBaKFgEgANzKfWElfSdgRo
         52oreoRDs/FAUtSiPMErcsiCsB+frXqo4IWuclszsXJynHNW36syddO/fPjhH5qt9fp9
         2dnVhdw4f4aBqM1fu8SC+FVovexlhTIAOIOxNXnFVqHI+HTlWAxjx3xMJSYnx60N1BVm
         W/Aw==
X-Gm-Message-State: AO0yUKUW/0C9GF/P/gzM6KR+sWXZ0cmEHt2UXMOKdysfWvFaibmzEzhQ
        YNbkl/EYfRLlBpzpWeHQdEtP7yYN1f63v4ecsCdKng==
X-Google-Smtp-Source: AK7set8iAZBOu+pwS8xMDRfn1TPdFp3nNMuunVUxiSal6OXRL7ydaCwNiScprmX0OBH8a3/pObI5zpUMZeXts3UGY/A=
X-Received: by 2002:a5d:4e83:0:b0:2ca:3013:9466 with SMTP id
 e3-20020a5d4e83000000b002ca30139466mr308573wru.0.1678867122798; Wed, 15 Mar
 2023 00:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com> <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Wed, 15 Mar 2023 08:58:26 +0100
Message-ID: <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey Arend

Thanks for taking a look.

The brcmfmac-wcc module is present on my installation, but I=E2=80=99m not
currently loading it.
(I only load brcmutil, then brcmfmac.)

But, even if I load it, the wlan0 interface still doesn=E2=80=99t show up.

In the modules.dep, I see that brcmfmac-wcc should be loaded after
brcmutil and brcmfmac.
Is that accurate?

My installation is somewhat unusual in that I use a custom userland
(see https://gokrazy.org/).

Thanks
Best regards
Michael


On Wed, 15 Mar 2023 at 00:21, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On March 14, 2023 11:49:05 PM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
>
> > Of course, find it attached. Thanks.
>
> Strange. Could it be there is some build config needed to install the
> additional kernel modules (brcmfmac-wcc.ko, etc.) on RPi image?
>
> Regards,
> Arend
>
> >
> > On Tue, 14 Mar 2023 at 23:26, Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On March 14, 2023 8:39:05 PM Michael Stapelberg
> >> <michael+lkml@stapelberg.ch> wrote:
> >>
> >>> Hey Arend
> >>>
> >>> I recently bisected a user-reported WiFi breakage on the Raspberry Pi
> >>> 3B+ to your commit
> >>> https://github.com/torvalds/linux/commit/d6a5c562214f26e442c8ec3ff1e2=
8e16675d1bcf
> >>> https://lore.kernel.org/r/20221129135446.151065-4-arend.vanspriel@bro=
adcom.com
> >>>
> >>> On our end, the issue was reported here:
> >>> https://github.com/gokrazy/wifi/issues/3
> >>>
> >>> As of Linux 6.2.6, this seems to still be unfixed, so I wanted to
> >>> check in and see if you could take a look please?
> >>
> >> I have a suspicion, but can you provide the kernel .config file so I c=
an
> >> see if I am on the right track.
> >>
> >>> + brcmfmac: brcmf_fwvid_request_module: mod=3Dwcc: failed -2
> >>> + ieee80211 phy0: brcmf_attach: brcmf_fwvid_attach failed
> >>> + brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> >>
> >> Regards,
> >> Arend
>
>
>
