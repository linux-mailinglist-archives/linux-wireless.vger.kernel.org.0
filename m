Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84946D04CD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjC3Me7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3Me7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 08:34:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245D273C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 05:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78B83B828A2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DB8C433EF;
        Thu, 30 Mar 2023 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680179695;
        bh=qyRF5+v/FjfORD4SlJNbZAh1Lo52k14InkPCIMhlLiw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NuKlfwmltkmJ1+nimOEm9iUkB81VLmSEP94HqH98fJnrvEFsGp8BS6sbRgQ/4Gl5W
         +2XSnqOVTeViGVK0b7cvYqcWdeJ5+9S6u6QLNW//Y370aDvYoLUTaq53MRzkXYNqXX
         nqDcKYfddpnno1DJHa32XDZWkk8c/9ZPCTHHZN0EBX0YxlTiCv/qm4jaYbEbvgAyYi
         6iOq5JAK3k7aWcnP1VHLvuozHYLoV9bqKqBpNnWQVHXJkjk/224O04rwY81IyIwGnz
         YVSbxBkZkKlq62qgKN0hLeeLA09p0q9muP/y/jsLzgXxod6APFv9i98gT/MLzrB0W+
         qQd0hdWFRESgw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 35198A22CD9; Thu, 30 Mar 2023 14:34:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Thomas =?utf-8?Q?H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>,
        Felix Fietkau <nbd@nbd.name>, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org
Subject: Re: [PATCH] ath9k: fix per-packet TX-power cap for TPC
In-Reply-To: <86B6FAF2-49B4-4993-A22D-FE102756AFD1@gmail.com>
References: <20230330071854.757154-1-jelonek.jonas@gmail.com>
 <87wn2ymvph.fsf@toke.dk> <86B6FAF2-49B4-4993-A22D-FE102756AFD1@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 30 Mar 2023 14:34:52 +0200
Message-ID: <87tty2mn83.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

>> On 30. Mar 2023, at 11:31, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel=
.org> wrote:
>>=20
>> Jonas Jelonek <jelonek.jonas@gmail.com> writes:
>>=20
>>> Fix incorrect usage of plain rate_idx as index into the max (power) per
>>> rate lookup table.
>>>=20
>>> For transmit power control (TPC), the ath9k driver maintains internal
>>> tables (in struct ath_hw) to store the max allowed power level per rate.
>>> They are used to limit a given TX-power according to regulatory and user
>>> limits in the TX-path per packet. The tables are filled in a predefined
>>> order, starting with values for CCK + OFDM rates and followed by the
>>> values for MCS rates. Thus, the maximum power levels for MCS do not
>>> start at index 0 in the table but are shifted by a fixed value.
>>>=20
>>> The TX-power limiting in ath_get_rate_txpower did not apply this shift,
>>> thus retrieved the incorrect maximum power level. For example, the
>>> maximum power for OFDM rate 0 was used for MCS rate 0. If STBC was used,
>>> the power was mostly limited to 0 because the STBC table is zeroed for
>>> legacy CCK/OFDM rates. This patch fixes this table lookup.
>>>=20
>>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>>=20
>> So what effect does this bug have in practice? Also, how did you test
>> the patch? :)
>>=20
>
> It actually may not have an effect in most of current practical applicati=
ons. The
> member =E2=80=98tpc_enabled' in struct ath_hw is by default set to false =
and thus, TPC
> in ath9k is usually disabled. The code path will be skipped in that case.=
=20
> But it has an effect as I am still working on TPC per packet in ath9k as =
part of
> research. Looking at my traces I saw that the TX-power is capped at 0 for
> MCS rates 0-7 in case the STBC flag is set in struct ieee80211_tx_info. T=
hus,
> transmission was significantly worse as usual, and I also was not able to=
=20
> manually set a proper TX-power via my testing API. With other rates it is=
 working
> fine. I also double-checked that it isn=E2=80=99t a problem of how TX-pow=
er is set and
> reported with our upcoming API.
>
> I tested this with my OpenWrt-based AP-STA desk setup using two different
> ath9k wifi chips (AR9280, AR9580), Kernel 5.15.98. I guess that should be
> sufficient as ath9k hasn=E2=80=99t changed that significantly since that =
and several
> changes are already backported. I compile-tested it with latest 6.3 kernel
> (+allyesconfig), the patch applied flawlessly and encountered no problems=
.=20
> After applying my patch, I could see that everything was working as expec=
ted.
> Transmission performs equally as if TPC was disabled, and setting + repor=
ting
> TX-power was working again. Also verified this with some verbose debugging
> in ath_get_rate_txpower to see which index + max power is used.

Alright, cool! Could you please add all this to the commit message and
resubmit?

-Toke
