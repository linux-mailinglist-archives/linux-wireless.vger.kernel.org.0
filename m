Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE26BAB39
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 09:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjCOIyH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjCOIyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 04:54:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88D166DA
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 01:54:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j42-20020a05600c1c2a00b003ed363619ddso187830wms.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1678870439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc0p6Luoz31dQklXPM5EWdLDT++leXPVtqTAl7O7trg=;
        b=bYjhSRwQLT78S+zM6UUR24zz7QOMzuoqhJexogW2Tc+ZHe4NY2V7oDNzaeAOAksy3x
         gx3W4SBHD/Qomho1rqvhKUnDHeMWYAptDpahxcThytByhANV8tCC/m7Ocp/AEz+ukS5M
         IyxuRqlCWLOrCE+wo089Smh84Jv8+Ldr29crDBIAkDpGoi63gpPyv/AG+KPELoh3NXfa
         cA6wTsXn396eGexh5BnBNYjHKLmEdf4gN2BPXMSVuLB2nenQKN6YbNODn+EIIYuNavRL
         806GNgzdeR02Jx1jpSH2V9Jq7CVxOKsdqFS31W2ua7P7d8oQosjTf087y+zYNIVDB55K
         8KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yc0p6Luoz31dQklXPM5EWdLDT++leXPVtqTAl7O7trg=;
        b=pMS5tdN6yiGASYCQg22RYg/PtwXwBkFOxpsribTTqZDj659Z0LK5bOWAsGTfZo14Es
         rHltv7NHMJ+7qtPgmAPi+ea5oxEd4jZDPFsl8wHKi1POSh9KagPrHCFOWHUPtpgkp9+H
         jeSyEb16ogShUbLpyUADS3xNfLnbifrHqjr53M+XbIpn07oJgRYKIqcf8jiqitnu0tOu
         OTf854L3w0X6m7k5ywFNCF/x/O9OxhL1wfQCTFsKcqyVCDWYlNau9Wme+sHfQ1ZyJmkq
         qrkKPCXhDx3zjkONfabH3CJfEbxqSlX59FjlAd3AwNlPS7iW8lbgLn61xFEp00NXx251
         JPYQ==
X-Gm-Message-State: AO0yUKUULgh9qzlinapInreDT+rZlneXR0+JoucCrRILMZr9Ed0fJ8z4
        vShCgMUZLzkaoYLXkXXcP4oThL9TvSDLtu6P53DHR+lTTwwtGlOmoo0=
X-Google-Smtp-Source: AK7set+fNua/yFNsNAyiMPeT6gLQbneIm8LViYV1Q+OSmzqK2WhMdDEOGiFEDmuSzGZJJfB8A3Z7QRYwSdBBZZQQIBE=
X-Received: by 2002:a7b:c2a1:0:b0:3e1:787:d706 with SMTP id
 c1-20020a7bc2a1000000b003e10787d706mr5118651wmk.2.1678870439394; Wed, 15 Mar
 2023 01:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
 <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com> <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Wed, 15 Mar 2023 09:53:43 +0100
Message-ID: <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
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

On Wed, 15 Mar 2023 at 09:33, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On March 15, 2023 8:58:43 AM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
>
> > Hey Arend
> >
> > Thanks for taking a look.
> >
> > The brcmfmac-wcc module is present on my installation, but I=E2=80=99m =
not
> > currently loading it.
> > (I only load brcmutil, then brcmfmac.)
> >
> > But, even if I load it, the wlan0 interface still doesn=E2=80=99t show =
up.
> >
> > In the modules.dep, I see that brcmfmac-wcc should be loaded after
> > brcmutil and brcmfmac.
> > Is that accurate?
>
> Yes. Actually brcmfmac loads brcmfmac-wcc by itself.

Hmm, when I run lsmod after booting, I don=E2=80=99t see it:

/tmp/breakglass1452371198 # lsmod
hci_uart 61440 0 - Live 0xffffba314a2cd000
btbcm 24576 1 hci_uart, Live 0xffffba314a2c6000
bluetooth 786432 3 hci_uart,btbcm, Live 0xffffba314a205000
brcmfmac 258048 0 - Live 0xffffba314a1c5000
brcmutil 20480 1 brcmfmac, Live 0xffffba314a1bf000
ecdh_generic 16384 1 bluetooth, Live 0xffffba314a1ba000
ecc 36864 1 ecdh_generic, Live 0xffffba314a1b0000
/tmp/breakglass1452371198 #

How does the =E2=80=9Cload by itself=E2=80=9D mechanism work?
Maybe I=E2=80=99m missing a userspace component for it.

Thanks

>
>
> > My installation is somewhat unusual in that I use a custom userland
> > (see https://gokrazy.org/).
>
> Bit tricky choice of name :-p I will check it out.
>
> Regards,
> Arend
>
> >
> > Thanks
> > Best regards
> > Michael
> >
> >
> > On Wed, 15 Mar 2023 at 00:21, Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On March 14, 2023 11:49:05 PM Michael Stapelberg
> >> <michael+lkml@stapelberg.ch> wrote:
> >>
> >>> Of course, find it attached. Thanks.
> >>
> >> Strange. Could it be there is some build config needed to install the
> >> additional kernel modules (brcmfmac-wcc.ko, etc.) on RPi image?
> >>
> >> Regards,
> >> Arend
> >>
> >>>
> >>> On Tue, 14 Mar 2023 at 23:26, Arend Van Spriel
> >>> <arend.vanspriel@broadcom.com> wrote:
> >>>>
> >>>> On March 14, 2023 8:39:05 PM Michael Stapelberg
> >>>> <michael+lkml@stapelberg.ch> wrote:
> >>>>
> >>>>> Hey Arend
> >>>>>
> >>>>> I recently bisected a user-reported WiFi breakage on the Raspberry =
Pi
> >>>>> 3B+ to your commit
> >>>>> https://github.com/torvalds/linux/commit/d6a5c562214f26e442c8ec3ff1=
e28e16675d1bcf
> >>>>> https://lore.kernel.org/r/20221129135446.151065-4-arend.vanspriel@b=
roadcom.com
> >>>>>
> >>>>> On our end, the issue was reported here:
> >>>>> https://github.com/gokrazy/wifi/issues/3
> >>>>>
> >>>>> As of Linux 6.2.6, this seems to still be unfixed, so I wanted to
> >>>>> check in and see if you could take a look please?
> >>>>
> >>>> I have a suspicion, but can you provide the kernel .config file so I=
 can
> >>>> see if I am on the right track.
> >>>>
> >>>>> + brcmfmac: brcmf_fwvid_request_module: mod=3Dwcc: failed -2
> >>>>> + ieee80211 phy0: brcmf_attach: brcmf_fwvid_attach failed
> >>>>> + brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> >>>>
> >>>> Regards,
> >>>> Arend
>
>
>
