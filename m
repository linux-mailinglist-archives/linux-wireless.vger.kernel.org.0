Return-Path: <linux-wireless+bounces-7377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A998C0C2E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674BC1F22E89
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACDE149C50;
	Thu,  9 May 2024 07:59:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B11A2C37;
	Thu,  9 May 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715241567; cv=none; b=hq1A+yMUGq4iuAS1yshQeG7ovE1XJeFtXqsV3x0hUAhpnyS1aljgUS8HIwnzPAOlJAwwjHBcF5AZoDgh4lMTrBnoCQNGWfYn/Ta9lo9092Hh0FUJf2nZAdLA78lZj3dwqG9jT7oFNQat0Ywf7TxsInVNsBIv7aUclm9LyWp87eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715241567; c=relaxed/simple;
	bh=j1fYyZ9BekfWCAvIhL5f+MAVLok5fQykKrvz7StbT4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pqzjrIpdw01iie//yW/HVj7KDeV3YMkNHNB5Ki0jcLXXaCW5zTHLi++r2VwKaDi4YtCxmlB1io2y6/HYZH8T4aJt63MxLReRsOgt7qriIV7NFRgdN4FJ4P3q4Z9JuLVw597IODqVG69KW7NeqLe78mO/TYSn/Uw/Uz5f+3tiItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4497x2Ax91364205, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4497x2Ax91364205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 15:59:02 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 15:59:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 15:59:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 9 May 2024 15:59:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Breno Leitao <leitao@debian.org>
CC: Kalle Valo <kvalo@kernel.org>, "leit@meta.com" <leit@meta.com>,
        "open
 list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>,
        "open
 list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Thread-Topic: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Thread-Index: AQHalnSYD4Tb/iMnEk2tnRSMUSm6/rF4e3YAgAACc82AAAD0RYAAAhhAgBWWcwCAAIefEA==
Date: Thu, 9 May 2024 07:59:01 +0000
Message-ID: <acf2f82e7f424776835ffbc1f52ba996@realtek.com>
References: <20240424182351.3936556-1-leitao@debian.org>
 <f46ae94488d1468e9a9a669320e4cfb9@realtek.com> <87ttjqgf2r.fsf@kernel.org>
 <87mspigex0.fsf@kernel.org> <acda4194c8d44690b05b83adccb3aa22@realtek.com>
 <Zjx/sKB++v8FJMXx@gmail.com>
In-Reply-To: <Zjx/sKB++v8FJMXx@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Breno Leitao <leitao@debian.org> wrote:
>=20
> On Thu, Apr 25, 2024 at 06:15:21AM +0000, Ping-Ke Shih wrote:
> > Kalle Valo <kvalo@kernel.org> wrote:
> > > Kalle Valo <kvalo@kernel.org> writes:
> > >
> > > > Ping-Ke Shih <pkshih@realtek.com> writes:
> > > >
> > > >> Breno Leitao <leitao@debian.org> wrote:
> > > >>> Embedding net_device into structures prohibits the usage of flexi=
ble
> > > >>> arrays in the net_device structure. For more details, see the dis=
cussion
> > > >>> at [1].
> > > >>>
> > > >>> Un-embed the net_device from the private struct by converting it
> > > >>> into a pointer. Then use the leverage the new alloc_netdev_dummy(=
)
> > > >>> helper to allocate and initialize dummy devices.
> > > >>>
> > > >>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.or=
g/
> > > >>>
> > > >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> > > >>
> > > >> I think this patch should go via net-next tree, because wireless-n=
ext tree
> > > >> doesn't have patch of dummy devices yet.
> > > >>
> > > >> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> > > >
> > > > FWIW I sent the wireless-next pull request yesterday and once it pu=
lled
> > > > we will fast forward wireless-next to latest net-next.
> > >
> > > Oh, I just realised that this is not CCed to netdev so their patchwor=
k
> > > won't even see the patch. Ping, I recommend that you wait for the
> > > dependency commits to trickle down to your tree and then apply the
> > > patch. That's the simplest approach and no need to resend anything.
> >
> > Okay. If we don't hurry to get this patch merged, I will apply this pat=
ch
> > to my tree.
>=20
> There is no hurry to get this patch merged.

I merged this patch today.=20

>=20
> Out of curiosity, why don't you rebase your tree to net-next/linux-next
> frequently?

My tree goes to wireless-next, so I think it should be always based on
wireless-next. Once wirelss-next rebase (ff-merge) net-next, my tree will
have them also.=20



