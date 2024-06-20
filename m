Return-Path: <linux-wireless+bounces-9279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE690FFE4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28F0281D3D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5B176221;
	Thu, 20 Jun 2024 09:06:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C550288;
	Thu, 20 Jun 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874403; cv=none; b=FD1Nj7WItVkAXr8iKD4199hIYR5lGXSgftTmJfu0DheNTz8X/+l50VyA21M0JOQlJz++ae5m1j4qCo7K8dx5CqnDFO8MboPt1j/AOBhkWBE7v97lkWhZDhiQDPdQfU/gfVn2GuyyP97op09JOj5HCs8/2Iy8nbYnmoKRSu521sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874403; c=relaxed/simple;
	bh=g2rUdbasf5D/aGDstZYAtLrJknBHEBysTJUtRN4Q71Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYww8VmmySFEDysB+6meSZv+ub3DPPJTMV8NDYHycOC4LWyKNtXa5yTiaw3WLPxynvgcTuPwe9kbAE8N6s/yC4azWVeYgaEWZiTcxAszz/LnD77vEyPr12GJaiPqXdfR81eNlLd7cZ6YQAgygge1g+0KVkyFccmaEIduK7oTt28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K96VAK02738787, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K96VAK02738787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 17:06:31 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:06:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Jun 2024 17:06:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 20 Jun 2024 17:06:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Forty Five <mathewegeorge@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHawgusbA+C/SyMRES67Y/3y6K7kbHOmQDAgAALtgCAAakyAIAADYKIgAACfrA=
Date: Thu, 20 Jun 2024 09:06:30 +0000
Message-ID: <3914d056277d47e89dce6b059cadfa85@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
	<2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com>	<87sex93s63.fsf@gmail.com>
	<6970398610c546b1b62e599902c67572@realtek.com> <87v824j8lg.fsf@kernel.org>
In-Reply-To: <87v824j8lg.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Kalle Valo <kvalo@kernel.org> worte:
>=20
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Forty Five <mathewegeorge@gmail.com> wrote:
> >> > Please try [1] that fixed "wifi: rtw89: add wait/completion for abor=
t" for
> >> > certain cases.
> >> >
> >> > [1]
> >> > https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshih=
@realtek.com/
> >>
> >> Doesn't fix the issue. I get a freeze on the first suspend+resume.
> >> I've attached the crash log.
> >
> > I tried 4.10-rc4 + the patch on ubuntu. Never reproduce the symptom.
>=20
> I guess you mean v6.10-rc4?

Right. Sorry for the typo.



