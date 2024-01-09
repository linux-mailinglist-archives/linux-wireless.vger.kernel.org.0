Return-Path: <linux-wireless+bounces-1612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FD827DFA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 05:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE73285838
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF999631;
	Tue,  9 Jan 2024 04:48:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4D39B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4094mAAZ1180274, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4094mAAZ1180274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 12:48:10 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 9 Jan 2024 12:48:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Jan 2024 12:48:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 9 Jan 2024 12:48:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, lilinmao <lilinmao@kylinos.cn>
CC: =?Windows-1252?Q?linux-wireless=40vger=2Ekern=85?=
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
Thread-Topic: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
Thread-Index: AQHaP8RbPkhvE92icEK7ZcmuR2v5v7DPfZEcgACQP2iAAN6l0A==
Date: Tue, 9 Jan 2024 04:48:10 +0000
Message-ID: <18e771f73c91428e8446f18319f316f5@realtek.com>
References: <20240105104542.463834-1-lilinmao@kylinos.cn>
	<1704693852309064.667.seg@mailgw>
	<077A3848-0696-4DCC-99C3-DB5389EA2EA2@kylinos.cn> <87jzojetms.fsf@kernel.org>
In-Reply-To: <87jzojetms.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, January 8, 2024 11:24 PM
> To: lilinmao <lilinmao@kylinos.cn>
> Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kern=85 <linux=
-wireless@vger.kernel.org>
> Subject: Re: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
>=20
> lilinmao <lilinmao@kylinos.cn> writes:
>=20
> > I'm very sorry for the various issues encountered during my first patch=
 submission.
> >
> > My patch didn't change the original logic of the code.Perhaps I just ch=
anged the way
> > of writing the code to avoid the cppcheck issue.

Yes. I think you didn't change the logic, so explain this and what you made
in commit message as Johannes mentioned.=20

> >
> >>The original logic looks like
> >>
> >>bool found =3D false;
> >>
> >>for (idx =3D 0; idx < RTW89_IQK_CHS_NR; idx++)
> >>if (expr) {
> >>found =3D true;
> >>break;
> >>}
> >>
> >>if (!found) {
> >>... [A]
> >>}
> >
> > After the 'for' loop ends, 'if (idx > RTW89_IQK_CHS_NR - 1)' is
> > equivalent to 'if (!found).=20

I prefer 'if (idx >=3D RTW89_IQK_CHS_NR)'

> > Cppcheck might not have detected the
> > changes to 'idx' within branch [A] which leads it to believe later
> > that 'idx' could be greater than or equal to 'RTW89_IQK_CHS_NR'.

So, can you refine cppcheck?=20

>=20
> Our lists drop all html mail, so please use text/plain format and don't
> top post. More info in the wiki link below.
>=20

Thank you, Kalle. With your reformatting, I can simply reply this. :-)



