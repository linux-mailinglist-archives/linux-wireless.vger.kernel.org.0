Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D76D066D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjC3NVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC3NVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:21:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7891721
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:21:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so76245448edd.12
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680182511;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCKE3lhBB97bjhXyotal3XJaRJddzpiDpnWFyJWJufQ=;
        b=O2jX3Pu7gCyD73GhH9IZfIhqqvvhBeT1S5dGDDph2ABEDOO8mZzPvKfm7F7fkzIpX3
         zvnTF/pWgpvRGNPuiHFkDQFSiZhJUa+ZfIKURZ60DjWUrMwF3OgBcOFV914QS0BB4aK0
         YMr+oYoeXQgfd2anS+MDAj+F+CQwHXSZUUxMWczPffuPbh3D0x0SXDYPPuu5aRzr3Kb/
         MlibwlOYbBap3VpeQqlxNKA98HsoXdN5qIVPNrD2+bJPInhyOtziw0S+cs5Llqs5UVCN
         VD0JJPzMHjWQ5c5e/mShVt2QwC2/1iB70p8wuLcNYwUvN3HIjYpAsa0I7tm75jffbIcP
         JaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182511;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCKE3lhBB97bjhXyotal3XJaRJddzpiDpnWFyJWJufQ=;
        b=KAUsaKgegX4hqmOepx90zkH9LnOVZ/yM3RlTFUoFoBwdeJDclUZisOrCIOYUizxYVe
         gcDlkmn7sC0tFRMy42o+ZLpJJE+ZJ/OMRNb3Gc47PrTUPyM+NX43BievkAoFb3wxVlqs
         SqKcYSmoaw8LUavpdRP/kOe20vAC/Mx2Qt7DS6vi9zT3s6Z9orlZOVFXjLOXS9BqsCAZ
         RPNiMsrkbTAnpe0S72kdZNPHI6JRYRCltTp0DTKIFSQkWG1Zzq/pFGg9pJmLCWkfkeTj
         N473yEe+h4S6BEHB6an473RDvo+7hTbprCAgPpJmet91RSUeuDohX8+v5qrXcKRdohKr
         h1WA==
X-Gm-Message-State: AAQBX9dmT1rza24dZ2y+bCR1IZEKlI3DUsqHxCjIOW5RtfLUwVq8QvQM
        DPaZBgTpaQFMiXc1iTz9kXs=
X-Google-Smtp-Source: AKy350Y4xDVrBqpwpOwEgu+oZLx2aVzaxTSYQXp2MBe3SZpxAZbGd48xYiSZdU/0gvsZzxSj3jnegA==
X-Received: by 2002:a17:906:6a10:b0:947:3bfc:4c84 with SMTP id qw16-20020a1709066a1000b009473bfc4c84mr4263416ejc.23.1680182511420;
        Thu, 30 Mar 2023 06:21:51 -0700 (PDT)
Received: from smtpclient.apple ([2001:9e8:f129:3400:b9e7:c0a7:b96:6fe9])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906774200b009273859a9bdsm17573526ejn.122.2023.03.30.06.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:21:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] ath9k: fix per-packet TX-power cap for TPC
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <87tty2mn83.fsf@toke.dk>
Date:   Thu, 30 Mar 2023 15:21:20 +0200
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>,
        Felix Fietkau <nbd@nbd.name>, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C4031B3-5DBB-48A9-8799-BE58FC0148A3@gmail.com>
References: <20230330071854.757154-1-jelonek.jonas@gmail.com>
 <87wn2ymvph.fsf@toke.dk> <86B6FAF2-49B4-4993-A22D-FE102756AFD1@gmail.com>
 <87tty2mn83.fsf@toke.dk>
To:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 30. Mar 2023, at 14:34, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>=20
> Jonas Jelonek <jelonek.jonas@gmail.com> writes:
>=20
>>> On 30. Mar 2023, at 11:31, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>>=20
>>> Jonas Jelonek <jelonek.jonas@gmail.com> writes:
>>>=20
>>>> Fix incorrect usage of plain rate_idx as index into the max (power) =
per
>>>> rate lookup table.
>>>>=20
>>>> For transmit power control (TPC), the ath9k driver maintains =
internal
>>>> tables (in struct ath_hw) to store the max allowed power level per =
rate.
>>>> They are used to limit a given TX-power according to regulatory and =
user
>>>> limits in the TX-path per packet. The tables are filled in a =
predefined
>>>> order, starting with values for CCK + OFDM rates and followed by =
the
>>>> values for MCS rates. Thus, the maximum power levels for MCS do not
>>>> start at index 0 in the table but are shifted by a fixed value.
>>>>=20
>>>> The TX-power limiting in ath_get_rate_txpower did not apply this =
shift,
>>>> thus retrieved the incorrect maximum power level. For example, the
>>>> maximum power for OFDM rate 0 was used for MCS rate 0. If STBC was =
used,
>>>> the power was mostly limited to 0 because the STBC table is zeroed =
for
>>>> legacy CCK/OFDM rates. This patch fixes this table lookup.
>>>>=20
>>>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>>>=20
>>> So what effect does this bug have in practice? Also, how did you =
test
>>> the patch? :)
>>>=20
>>=20
>> It actually may not have an effect in most of current practical =
applications. The
>> member =E2=80=98tpc_enabled' in struct ath_hw is by default set to =
false and thus, TPC
>> in ath9k is usually disabled. The code path will be skipped in that =
case.=20
>> But it has an effect as I am still working on TPC per packet in ath9k =
as part of
>> research. Looking at my traces I saw that the TX-power is capped at 0 =
for
>> MCS rates 0-7 in case the STBC flag is set in struct =
ieee80211_tx_info. Thus,
>> transmission was significantly worse as usual, and I also was not =
able to=20
>> manually set a proper TX-power via my testing API. With other rates =
it is working
>> fine. I also double-checked that it isn=E2=80=99t a problem of how =
TX-power is set and
>> reported with our upcoming API.
>>=20
>> I tested this with my OpenWrt-based AP-STA desk setup using two =
different
>> ath9k wifi chips (AR9280, AR9580), Kernel 5.15.98. I guess that =
should be
>> sufficient as ath9k hasn=E2=80=99t changed that significantly since =
that and several
>> changes are already backported. I compile-tested it with latest 6.3 =
kernel
>> (+allyesconfig), the patch applied flawlessly and encountered no =
problems.=20
>> After applying my patch, I could see that everything was working as =
expected.
>> Transmission performs equally as if TPC was disabled, and setting + =
reporting
>> TX-power was working again. Also verified this with some verbose =
debugging
>> in ath_get_rate_txpower to see which index + max power is used.
>=20
> Alright, cool! Could you please add all this to the commit message and
> resubmit?
>=20
> -Toke

Sure, please have a look at it again if I missed something :)

Jonas

