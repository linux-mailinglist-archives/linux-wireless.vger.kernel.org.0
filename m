Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCA65F3E34
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJDIXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJDIXo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:23:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C2B1E732
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C65EB8160C
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9EDC433C1;
        Tue,  4 Oct 2022 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664871817;
        bh=AWX23dQLU/NQWe9ndmOvdYGa7PWn84Gl/qmmJnYx7Q0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aoFQcDU4R/y20gyb1NSaUnOpzdfxfx7mLJpHiWQztFkDuXG45ENoUz5wo2bMGeIG5
         lTTgKJgtyBWHsbnarjlv9C0s4TB0BB78fxsP4Ew7v1TOOgBr0WR+GitdeptFNtAvkA
         ycAV9YI3RpDc/+0SfcfyAd67+u6niu1hffNThSnI2I+rNwR+BIbHbMR99xeSKDQC1M
         FOJUGfHnL6o2muOlUUe1oYCsatVkRR/hKVaeUl2nvNt17SThZWz3R/iXc1j1mZ3eeN
         yfyVhhXQcDfjVdcMH4y43bCYhCsJWXv1FsOUS3oicLTtJkv+LLNK+UTNseF3wvqIVs
         xObaEaeTInKDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: gen2: Turn on the rate control
References: <43200afc-0c65-ee72-48f8-231edd1df493@gmail.com>
        <166487149459.9318.3375191834985088151.kvalo@kernel.org>
Date:   Tue, 04 Oct 2022 11:23:33 +0300
In-Reply-To: <166487149459.9318.3375191834985088151.kvalo@kernel.org> (Kalle
        Valo's message of "Tue, 4 Oct 2022 08:18:17 +0000 (UTC)")
Message-ID: <87lepw575m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>
>> Re-enable the function rtl8xxxu_gen2_report_connect.
>>=20
>> It informs the firmware when connecting to a network. This makes the
>> firmware enable the rate control, which makes the upload faster.
>>=20
>> It also informs the firmware when disconnecting from a network. In the
>> past this made reconnecting impossible because it was sending the
>> auth on queue 0x7 (TXDESC_QUEUE_VO) instead of queue 0x12
>> (TXDESC_QUEUE_MGNT):
>>=20
>> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 1/3)
>> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 2/3)
>> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 3/3)
>> wlp0s20f0u3: authentication with 90:55:de:__:__:__ timed out
>>=20
>> Probably the firmware disables the unnecessary TX queues when it
>> knows it's disconnected.
>>=20
>> However, this was fixed in commit edd5747aa12e ("wifi: rtl8xxxu: Fix
>> skb misuse in TX queue selection").
>>=20
>> Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and 8723bu=
 devices not reconn=E2=80=A6")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>
> Patch applied to wireless-next.git, thanks.
>
> c5ef1cee5745 wifi: rtl8xxxu: gen2: Turn on the rate control

Please disregard the commit id, the fixes tag is incorrect so I need to
apply it again to fix it.

In commit

  c5ef1cee5745 ("wifi: rtl8xxxu: gen2: Turn on the rate control")

Fixes tag

  Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and
  8723bu devices not reconn=E2=80=A6")

has these problem(s):

  - Subject does not match target commit subject
      Just use
           git log -1 --format=3D'Fixes: %h ("%s")'
=20=20=20=20=20=20=20=20=20=20=20

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
