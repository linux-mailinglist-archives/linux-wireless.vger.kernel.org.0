Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC56D736B8B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjFTMFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjFTMFe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 08:05:34 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFE10FE
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 05:05:33 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1687262731; bh=iEvcG1hfUI3EmH+FYz733tQLDNTMqJ93GoyIPa5mB+0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XZDpRP7wol6lCFJpBufe1nO0Dz2XaZVjWOOs96K96tjrPbZixyMn0gWnhTeAIy07A
         DOfCHegiQsR7JNecu0A6KZx3Qu8LT3ekxwDiKiRO1788d5V72gUcookkd0js/jMb0l
         3SAL+w8WnwuuDTKJ2CbE7dVXv6g21kh8RHIaVu938n35jSQM7hEVbw1MkrtxKi9EgC
         rCALm/kNMH8jdR3Q4NG/yu9dlnqW5VIJpguFKr4LOxOuNsl4rENZ40nBChYtD6SiAn
         THfiKOvClblybReIJPZ3v/DW4RbJVIHf2nrKaQvoCdBgD+4D6HHK4hdMvLJ4tCzYVx
         i9qqwhdgrFNPQ==
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 2/2] [v2] wifi: ath9k: fix fortify warnings
In-Reply-To: <20230620080855.396851-2-dmantipov@yandex.ru>
References: <20230620080855.396851-1-dmantipov@yandex.ru>
 <20230620080855.396851-2-dmantipov@yandex.ru>
Date:   Tue, 20 Jun 2023 14:05:31 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877crye3uc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=3Dy,
> I've noticed the following:
>
> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>     inlined from =E2=80=98ath_tx_complete_aggr=E2=80=99 at drivers/net/wi=
reless/ath/ath9k/xmit.c:556:4,
>     inlined from =E2=80=98ath_tx_process_buffer=E2=80=99 at drivers/net/w=
ireless/ath/ath9k/xmit.c:773:3:
> ./include/linux/fortify-string.h:529:25: warning: call to =E2=80=98__read=
_overflow2_field=E2=80=99
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>     inlined from =E2=80=98ath_tx_count_frames=E2=80=99 at drivers/net/wir=
eless/ath/ath9k/xmit.c:473:3,
>     inlined from =E2=80=98ath_tx_complete_aggr=E2=80=99 at drivers/net/wi=
reless/ath/ath9k/xmit.c:572:2,
>     inlined from =E2=80=98ath_tx_process_buffer=E2=80=99 at drivers/net/w=
ireless/ath/ath9k/xmit.c:773:3:
> ./include/linux/fortify-string.h:529:25: warning: call to =E2=80=98__read=
_overflow2_field=E2=80=99
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> In both cases, the compiler complains on:
>
> memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
>
> which is the legal way to copy both 'ba_low' and following 'ba_high'
> members of 'struct ath_tx_status' at once (that is, issue one 8-byte
> 'memcpy()' for two 4-byte fields). Since the fortification logic seems
> interprets this trick as an attempt to overread 4-byte 'ba_low', silence
> relevant warnings by using the convenient 'struct_group()' quirk.
>
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
