Return-Path: <linux-wireless+bounces-15033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B89BFD88
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 06:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15F61F2241A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09727F9;
	Thu,  7 Nov 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BtCFxf07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58517548
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956545; cv=none; b=Dng8WffrMBLURz02re5NlV0wvrgNc4n8EIouZYV0ySXPaBn3o0jvjXzUHcu/Cl5pi3abjaq/TvTb2PCmpjaITLc87PfbGGhBNg8Z3biGoUxtDLjKQtDgl3MxWJemtbMuO9lb0JXJf46qNNZnjp5Vkagkk4zElSHgBtJdTl2YCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956545; c=relaxed/simple;
	bh=6H3gIp81UHfuAGkxsbij2cjkX13fLbtFz9NevkpqtXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLc4//XGLY8LxSSlqJj0f/5ohGiMTAQKUYfVuHQv9MYZnQOpw8UNsYY0gSKY75cyMuqKbmOv+euxalG5FnxpDzW/G/2/CaD0UKBOhNa77UI4m3+5XzREDxtOREcr+owk/VOpg9+YdSw5ILVS+ABAeS3/tmKFpX3sk4Ry8GYi6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BtCFxf07; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A75FGkM43923485, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730956516; bh=6H3gIp81UHfuAGkxsbij2cjkX13fLbtFz9NevkpqtXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BtCFxf07g6tWKaqTW2e5sbAjhmod6iH7cuvlQWplp+Mj4rga5NTQFWb5Ap4glc0ug
	 NYhbJ0vA+xdqjUTCK121pz8Pg2BOL8/Fs01O0d9VJEKcfHc0uDBjt6WBH2BvEVV1ww
	 JnbFmwsnd4iuYrBwQR2XbhHpmv70Kh+8MruXbs5WHA0GrnW5JD3/KlFmV7JKEE+Wqb
	 WNAZdEVXMFNw4rWfs6vtmlFliY4//oNTIzcbsPoJ9XOxAf9oh9VDiooYsvw3GWnuNY
	 tu/oekssuOlxB5zY0joP1iimkV+J55XPWhgVCtkxYTGaln1XozWRAJnsZ53H3sA+NN
	 Yjt/jYki/Cs8A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A75FGkM43923485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 13:15:16 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:15:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Nov 2024 13:15:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 7 Nov 2024 13:15:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Issam Hamdi
	<ih@simonwunderlich.de>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "sw@simonwunderlich.de" <sw@simonwunderlich.de>,
        Kretschmer Mathias
	<mathias.kretschmer@fit.fraunhofer.de>
Subject: RE: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32 bit systems
Thread-Topic: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32
 bit systems
Thread-Index: AQHbLt5qmjJckGzEukCkGnLWXXtSI7KrJfuw//+IJACAAJuzAA==
Date: Thu, 7 Nov 2024 05:15:15 +0000
Message-ID: <0e4d1faeb9f7420789ee1c958d65c101@realtek.com>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
 <453ad4cc0ba24c07a02210f6a8acbd47@realtek.com>
 <1ac0dcb7311e4851abdd15f3dd55cb6a@realtek.com>
In-Reply-To: <1ac0dcb7311e4851abdd15f3dd55cb6a@realtek.com>
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

Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
> >
> > Issam Hamdi <ih@simonwunderlich.de> wrote:
> > > diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c index
> > > cb5f16366b9c..39cdbc11f540 100644
> > > --- a/net/mac80211/mesh.c
> > > +++ b/net/mac80211/mesh.c
> > > @@ -1164,7 +1164,7 @@ void ieee80211_mbss_info_change_notify(struct
> > ieee80211_sub_if_data *sdata,
> > >                 return;
> > >
> > >         /* if we race with running work, worst case this work becomes=
 a noop */
> > > -       for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
> > > +       for_each_set_bit(bit, &bits, sizeof(bits) * BITS_PER_BYTE)
> > >                 set_bit(bit, ifmsh->mbss_changed);
> > >         set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
> > >         wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
> >
> > The ifmsh->mbss_changed is defined as:
> > 	unsigned long mbss_changed[64 / BITS_PER_LONG];
> >
> > It seems like loop of for_each_set_bit() want to copy each bit of chang=
ed (u64).
> > When shrink traversal size of for_each_set_bit() from sizeof(changed) t=
o sizeof(bits), upper 32
> > bits of changed will not be copied to ifmsh->mbss_changed.
> > Will it be a problem?
> >
>=20
> On 32-bit system, the upper 32 bits seem already lost when "unsigned long=
 bits =3D changed". (no matter what
> the traversal size it is)
> IIUC, this patch is going to prevent traversal of "bits" from getting out=
-of-bound.
>=20
> But perhaps, "unsigned long bits[] =3D { BITMAP_FROM_U64(changed) }" woul=
d be better.
> Then, traversal size can keep as before.

BITMAP_FROM_U64() looks like a good idea.=20


