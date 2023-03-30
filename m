Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5617F6D0167
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjC3Kie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 06:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjC3Kid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 06:38:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A557A8B
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 03:38:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so74667354edo.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680172709;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhhWLWN+zY1w5c/ZA/z47pTy/bN3hJ0Z1ewB8zfJjVA=;
        b=GYVLnPtAORZCSfP7E2qIpcJ9R9uGmg7bVhX0fSjcZfeIIb0BmQAxVOXxCA+nSIRNGO
         8jE9xvE1lwf51J5aWsD8daw/5SZ8RPDCoPkGE9E0omVMh/a5H23eTJsvtAEfpYeLQTuh
         MtAGzjNHAl7l0LL1TB/pMDTPP3s1Caz9nYP2kwYMMk9OUR0QlU7xRnctT2TS8x76pdg8
         lQbywVULF2JUpenQgq0t6o6aORZ/nAVYuw6gDhtgdKkmHDqKxsBSsOuFLk+ByuoX5bsC
         qY3/lk5zFZ54hgtLzHm5GUBk2ioyP+t7991dowZBdQTqsZk12B45CJTsB1INZDvuMjNt
         vFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172709;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhhWLWN+zY1w5c/ZA/z47pTy/bN3hJ0Z1ewB8zfJjVA=;
        b=YQTaBPqx6lfuVKYdL9Kk72RhOJ7uO+hv1apsPzvO9b0kwJaEtdCLy2iD4J8JLyG17C
         JolB3K27Z9xO2E7Gpq2CgI44fTGzKn3487bhbE2Bf7t8Aae7sd2t2pW6k6slvP25BCsf
         0/oLNkeQZaHq1jgLuBilWK/1wwlUXKF7/qg7J4mQKlIFNp6j4g7fcFPMTf+oIl0GddA3
         ANTGfhU6m6Dj9mm+JIp1gvtn0QBy0taE/RldfkIzvS0vf4OYC6tuPZoqCJMmayqtH9QM
         BDxutnr4XQSL+EM9mO+ugsTM5D9tOUR84cqta9qSZfCErBNKCAueIH97ThOnE1tFjtZ2
         hS7A==
X-Gm-Message-State: AAQBX9eiLHC0zz+j34sTSokl5FVtNtCt3O5n+pUc99gWWBGq5e7iGE56
        TbC9li6ygDwrX3LOoPhQGqA=
X-Google-Smtp-Source: AKy350bgD3SL0mvBU6E5GGgpiJauyEwksWJZFafqbAWGdJjnZlrAZL66lNeL4MdK25YLJNpTtdnyxg==
X-Received: by 2002:a17:906:9498:b0:947:74fa:483e with SMTP id t24-20020a170906949800b0094774fa483emr722332ejx.31.1680172709464;
        Thu, 30 Mar 2023 03:38:29 -0700 (PDT)
Received: from smtpclient.apple ([2001:9e8:f129:3400:b9e7:c0a7:b96:6fe9])
        by smtp.gmail.com with ESMTPSA id k7-20020a1709062a4700b008b176df2899sm17417007eje.160.2023.03.30.03.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2023 03:38:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] ath9k: fix per-packet TX-power cap for TPC
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <87wn2ymvph.fsf@toke.dk>
Date:   Thu, 30 Mar 2023 12:37:58 +0200
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>,
        Felix Fietkau <nbd@nbd.name>, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86B6FAF2-49B4-4993-A22D-FE102756AFD1@gmail.com>
References: <20230330071854.757154-1-jelonek.jonas@gmail.com>
 <87wn2ymvph.fsf@toke.dk>
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


> On 30. Mar 2023, at 11:31, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>=20
> Jonas Jelonek <jelonek.jonas@gmail.com> writes:
>=20
>> Fix incorrect usage of plain rate_idx as index into the max (power) =
per
>> rate lookup table.
>>=20
>> For transmit power control (TPC), the ath9k driver maintains internal
>> tables (in struct ath_hw) to store the max allowed power level per =
rate.
>> They are used to limit a given TX-power according to regulatory and =
user
>> limits in the TX-path per packet. The tables are filled in a =
predefined
>> order, starting with values for CCK + OFDM rates and followed by the
>> values for MCS rates. Thus, the maximum power levels for MCS do not
>> start at index 0 in the table but are shifted by a fixed value.
>>=20
>> The TX-power limiting in ath_get_rate_txpower did not apply this =
shift,
>> thus retrieved the incorrect maximum power level. For example, the
>> maximum power for OFDM rate 0 was used for MCS rate 0. If STBC was =
used,
>> the power was mostly limited to 0 because the STBC table is zeroed =
for
>> legacy CCK/OFDM rates. This patch fixes this table lookup.
>>=20
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>=20
> So what effect does this bug have in practice? Also, how did you test
> the patch? :)
>=20

It actually may not have an effect in most of current practical =
applications. The
member =E2=80=98tpc_enabled' in struct ath_hw is by default set to false =
and thus, TPC
in ath9k is usually disabled. The code path will be skipped in that =
case.=20
But it has an effect as I am still working on TPC per packet in ath9k as =
part of
research. Looking at my traces I saw that the TX-power is capped at 0 =
for
MCS rates 0-7 in case the STBC flag is set in struct ieee80211_tx_info. =
Thus,
transmission was significantly worse as usual, and I also was not able =
to=20
manually set a proper TX-power via my testing API. With other rates it =
is working
fine. I also double-checked that it isn=E2=80=99t a problem of how =
TX-power is set and
reported with our upcoming API.

I tested this with my OpenWrt-based AP-STA desk setup using two =
different
ath9k wifi chips (AR9280, AR9580), Kernel 5.15.98. I guess that should =
be
sufficient as ath9k hasn=E2=80=99t changed that significantly since that =
and several
changes are already backported. I compile-tested it with latest 6.3 =
kernel
(+allyesconfig), the patch applied flawlessly and encountered no =
problems.=20
After applying my patch, I could see that everything was working as =
expected.
Transmission performs equally as if TPC was disabled, and setting + =
reporting
TX-power was working again. Also verified this with some verbose =
debugging
in ath_get_rate_txpower to see which index + max power is used.

Jonas=
