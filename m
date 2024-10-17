Return-Path: <linux-wireless+bounces-14135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBD9A1B54
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFDF283F38
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D411BFE18;
	Thu, 17 Oct 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JRhWuOb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DD19306C;
	Thu, 17 Oct 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148795; cv=none; b=Lj/5ZLA+AUzBvVPUyfxQN+Qw2HYvIV/j3rbCq8HznQpvu7HCFvB/p+9vK7V66bKsASq6il1L6Dj2V26hOFnWwkNteSTZbWeENSFkcqcpVoZ3Q3vZK7MJH+9irk6AS26EFhvTrI9ygKtqNtVAid8OuFTGGyJkEnHUT86loPwwLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148795; c=relaxed/simple;
	bh=5PmxHLGPRAQmvS0X+WcMDhQ2VwBm3erGoq+fv7JCD/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gsTbLtxASXWcflZU08HBkYcMkhnPsY4wDXkEMZ0eCj6ohP9NZ6xWgErjwcTJ3ownhw2/Z2Hsf4qwKTmCGhnbkjQdrzh0qQYfjT/RmxW+l1KHA3DHLYvANVOP5evvlwPVEf59yoZzfLDyz0KIqd9Fj32mqUEj/jsEi6dx6RsYOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JRhWuOb8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49H76NVg8025163, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729148783; bh=5PmxHLGPRAQmvS0X+WcMDhQ2VwBm3erGoq+fv7JCD/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JRhWuOb80WI4swpTzwmmWRLidwRGR8clDEHfn8NAXpkzDmJJ4KlpZ1Pl6wRiAlPNY
	 IZB3JV7PsCCfsaGh7f//lDBdaRiMUkp2xdL4jQmT8hP+m6xpmZb6kMKFJ6dSecSpN5
	 oSboHLFhXq/j83p2qQ5YizuF9FJGHXvaYoFCd5dndHaqcyIhG/H2nh5XUkyr0onEBe
	 b39LFb4uNKUkzpVjocGuRyjsZtDfX6tJPiqZ/dFzwPnpdtcYM34ENB+a0A9RxGujRh
	 ibDjt5Jx2DLloa300x1ZPJi1avK06St0x5I8RhTMAkI/8VNSVIt8mzPG59dVe2oIfO
	 4PPeAHhFl6ubg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49H76NVg8025163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:06:23 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 15:06:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Oct 2024 15:06:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 17 Oct 2024 15:06:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Thread-Topic: [PATCH] wifi: rtw88: Refactor looping in
 rtw_phy_store_tx_power_by_rate
Thread-Index: AQHbH5G7zMXB5WLj7UST4uYO5eihKrKKJAjA///aLYCAAIcFwA==
Date: Thu, 17 Oct 2024 07:06:23 +0000
Message-ID: <e25e1e06fbe549dc9e9b48719f66653b@realtek.com>
References: <c0f6c6c3b87c4d048ad9f42dc1dfaed9@realtek.com>
 <20241017065645.5409-1-pvmohammedanees2003@gmail.com>
In-Reply-To: <20241017065645.5409-1-pvmohammedanees2003@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:
> Oops, I sent over the wrong patch with typo,
> I'll make sure to fix that in the next version.
>=20
> > I feel compilers can optimize the check for the band, and we can just r=
emove
> > the else condition. Or
> >   if (2ghz)
> >      foo_2g();
> >   else
> >      foo_5g();
>=20
> I do agree with that but I feel, it would be
> better to make it independent of compiler
> optimization, thoughts?
>=20
> Let me know what you think is better, that is
> whether letting it be if - else, or using a
> pointer.

Using a pointer looks delicate and optimized. The if-else code is simple to
read. Since this chunk is small, I don't bias one of them. If I must choose
one, I vote if-else.


