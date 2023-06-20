Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB5736514
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjFTHpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjFTHpH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 03:45:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8A10CF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oNnV1MiiDDFuLWlZDlpXSft3CWnn2/St88x0rqrk/cU=;
        t=1687247105; x=1688456705; b=PnbzCIT3uXJ22bXFNKlengJd3fzz7RVwzqnuLdt/kFFKs36
        NwzXxtIEER2rLfWHIc3aeZX98SgOCfe+dUww+xnXBFRhn14GKUeZEKA/CGwr8kPdUOW9Y7KEW3g0z
        wN567jCVfQgwSGMlsBoilk54qGXE/jGq8ysKqPCdKYof8kETGMeBtlyZHYhXysF5fxg2Y48pE0J/3
        GET6pKxAONEzckyHm627t2veVqX7xc3b08f+Z+NZcKPd1zu3oIIDv1z/+xUFhkzpkBjazOq5MAXgh
        tPjsK5vQcWXsd1u9Jp6XuJY4P0RUf2ukaF6+p65oFbaZMUV4WeG63rQD70WVFSBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBW2u-00CGdO-0u;
        Tue, 20 Jun 2023 09:45:00 +0200
Message-ID: <02e2ad88adfc46976803c2c0be7dce38a4d8b660.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: ath9k: fix fortify warnings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Tue, 20 Jun 2023 09:44:59 +0200
In-Reply-To: <20230620073228.363207-2-dmantipov@yandex.ru>
References: <20230620073228.363207-1-dmantipov@yandex.ru>
         <20230620073228.363207-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-06-20 at 10:31 +0300, Dmitry Antipov wrote:
> When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=3Dy,
> I've noticed the following:
>=20
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
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>=20
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
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>=20
> In both cases, the compiler complains on:
>=20
> memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
>=20
> which is the legal way to copy both 'ba_low' and following 'ba_high'
> members of 'struct ath_tx_status' at once (that is, issue one 8-byte
> 'memcpy()' for two 4-byte fields). Since the fortification logic
> seems interprets this trick as an attempt to overread 4-byte 'ba_low',
> relevant warnings may be silenced by specifying source buffer with
> 'offsetof()' of the 'ba_low' instead of using an address of the latter.
>=20

I think other places have typically fixed that with a struct_group, say
e.g. commit bfcc8ba45eb8 ("wifi: ath: Silence memcpy run-time false
positive warning"). To me, that seems slightly better since it still
ensures you're actually in the fields you wanted? But dunno.

johannes
