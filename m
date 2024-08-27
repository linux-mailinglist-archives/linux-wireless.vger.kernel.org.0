Return-Path: <linux-wireless+bounces-12067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F4960CEB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7483CB27B76
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257E1C2DD8;
	Tue, 27 Aug 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBk6IEpl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0801E487;
	Tue, 27 Aug 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767430; cv=none; b=ezMiqSAbrlvc+BOvOOs8lwGAhlwlLj5+nVSShLeKw7iu2kUM9FegLjYWhlgpd4jrsS0Zfk5XA24xiuvLAgE9l/xn/OvViaCdr5N39l4rHV8EovZaj8qYMwP1XlXNAUBMEO7LP2ENgh320qbx63li6i/XI078ucNmIlrQ5BwoEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767430; c=relaxed/simple;
	bh=HSil7PMrXBywMPhgEu6QpS5TfQeHIBuVv32WKKd7Cok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErkHSfSBsBxJJn/MQ1jlm84zSxSbKBVmw0dIBzz+ET8GFveTzDk5irnCy9heohkb2DqBC+aoUPZ+ozTsS3/aRG9Sv331BRhOPYidP9l6VxtnrPaSa/0InUo/vOvacTrHdyCdYnMSvg0i/x2cLfxA1FD95DbV44Hxp5qN71Rhqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBk6IEpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1997C61050;
	Tue, 27 Aug 2024 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724767429;
	bh=HSil7PMrXBywMPhgEu6QpS5TfQeHIBuVv32WKKd7Cok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cBk6IEplgFuwFiriIePAGg0qudmq7Ghn7Ib/5m0z1lEQO67hohck2AkLE0Nc0fONh
	 5j8mOQuqDEhalBzP8+HHj2QzTbJCsxoGqTMdMM8l65SUxcIk6eIDvOJr4QgG4AriYu
	 t7QpeB6f20Mrced5ouDCRNGQCrO0XkDmZ7QBwqoPeii3w8zlI5K5Q38kUYaPbn/grt
	 5ooUy5hU0R30QiU1KOIDXSnz9FmYTB+WG0BOinRC04fq7++1W8t6J9gWRnkMC1QBZK
	 gWTdvVSxBQAsgmbNmIKQNmH7AdxmHhnIhWb+NFKyxL+aTZZou9iom6GNQdNX5M3OfI
	 jw+zEXg5p8WsA==
Date: Tue, 27 Aug 2024 07:03:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, <johannes@sipsolutions.net>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <allison.henderson@oracle.com>, <dsahern@kernel.org>, <pshelar@ovn.org>,
 <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
 <rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>, <dev@openvswitch.org>,
 <linux-afs@lists.infradead.org>
Subject: Re: [PATCH net-next 0/8] Use max/min to simplify the code
Message-ID: <20240827070347.4bf3a284@kernel.org>
In-Reply-To: <878qwifub5.fsf@kernel.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	<20240826144404.03fce39c@kernel.org>
	<4a92bb68-7fe7-4bf2-885f-e07b06ea82aa@huawei.com>
	<878qwifub5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 07:45:02 +0300 Kalle Valo wrote:
> > Do you mean some patches will go to other branches (such as mac80211)? =
=20
>=20
> Jakub means that your patchset had compilation errors, see the red on
> patchwork:
>=20
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D882901&stat=
e=3D*&order=3Ddate

FWIW I prefer not to point noobs to the patchwork checks, lest they
think it's a public CI and they can fling broken code at the list :(
But yes, in case "code doesn't build" needs a further explanation:

net/core/pktgen.c: In function =E2=80=98pktgen_finalize_skb=E2=80=99:
./../include/linux/compiler_types.h:510:45: error: call to =E2=80=98__compi=
letime_assert_928=E2=80=99 declared with attribute error: min(datalen/frags=
, ((1UL) << 12)) signedness error
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:491:25: note: in definition of macro =
=E2=80=98__compiletime_assert=E2=80=99
  491 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
./../include/linux/compiler_types.h:510:9: note: in expansion of macro =E2=
=80=98_compiletime_assert=E2=80=99
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=98co=
mpiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:100:9: note: in expansion of macro =E2=80=98BUILD=
_BUG_ON_MSG=E2=80=99
  100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:105:9: note: in expansion of macro =E2=80=98__car=
eful_cmp_once=E2=80=99
  105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y=
_))
      |         ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:129:25: note: in expansion of macro =E2=80=98__ca=
reful_cmp=E2=80=99
  129 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
../net/core/pktgen.c:2796:28: note: in expansion of macro =E2=80=98min=E2=
=80=99
 2796 |                 frag_len =3D min(datalen/frags, PAGE_SIZE);
      |                            ^~~
make[5]: *** [../scripts/Makefile.build:244: net/core/pktgen.o] Error 1

