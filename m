Return-Path: <linux-wireless+bounces-10700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162869423E0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 02:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CBC1C212BD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4044431;
	Wed, 31 Jul 2024 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DJDh6FMi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5976366
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386301; cv=none; b=BnXGFBw63oJeqUQ5BpypJjLYUOAi026TJ8jW6jiqn2K0TjfLken+kwLi4TuSKIHJ9mH2jS8nlBEB84AcYWjWReMXp8UAj/Yw25FlBIe2TSTcPWW9C0bI/cyLSF7pAFRV8GaRH903rCxKkkzzfklcZldVwHxuf8XY62WnwuuswQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386301; c=relaxed/simple;
	bh=kyT8gqU3sjVIeEqKXyAjQ1wUnRznY5TJ+Xz9v44I4Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxVtfXOdpK9x1sBJJL4yuopKONNvlCj/7dS+heaLHKJQ+dIlaxJjIZurSNz7FuUKpnyNRBsOAA9dOy6Fv2fHbxpmDDssKLV+G86elZow9RBTV3yoMaJbFZJ8cjm59hna9Ybsu2jVBhMeOoC6Ss+uBBwhwBTGXKl189aJeIofVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DJDh6FMi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V0c91z91729477, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722386289; bh=kyT8gqU3sjVIeEqKXyAjQ1wUnRznY5TJ+Xz9v44I4Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DJDh6FMi1MenXCmJBuIulDsDLpsM2Xai8EzFR7sCFKTustwqnezdoLKz+85b0XZKS
	 tHGPp5Fyyjj94AXo3ShmgZWvakqFhg7aBLRriYpOw9B4OdAHY+WCUOLKvc8EG/IpJB
	 8hHFZ45yO+BX4NMjnIQdALc/fqhtzPQ5lLtFZd7W6lRS6/qfbgMUWdm76lrPDg65m4
	 fxcQvyxlLLITcMlRcVKbgjz4cjdz36WgRn0dntb6V4gAvZLXq/G8BGRE0d6i5YuarT
	 Rkd6tB6iqE3xfgVolRPw/oWJBPNALh+lgJF4YusW9DNPlZ3H7Dyv6yra0aYlGiFG8j
	 2lXBQmjulHz/A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V0c91z91729477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 08:38:09 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 08:38:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jul 2024 08:38:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 31 Jul 2024 08:38:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 1/2] wifi: rtw88: select WANT_DEV_COREDUMP
Thread-Topic: [PATCH 1/2] wifi: rtw88: select WANT_DEV_COREDUMP
Thread-Index: AQHa2OEYiBMLCAHy6kiQe+iEku0He7IPUXAGgAC/8tA=
Date: Wed, 31 Jul 2024 00:38:09 +0000
Message-ID: <5db66445dbd1454ea6c2a6f8fc664725@realtek.com>
References: <20240718070616.42217-1-pkshih@realtek.com>
 <87sevrkoxb.fsf@kernel.org>
In-Reply-To: <87sevrkoxb.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Kalle Valo <kvalo@kernel.org> wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > We have invoked device coredump when fw crash.
> > Should select WANT_DEV_COREDUMP by ourselves.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> Should these two go to wireless tree? If yes, please assign the patches
> to me on patchwork. But rtw tree is fine for me as well, your call.

For most distro, other drivers select this flag, so not urgent to have thes=
e
two patches. Then they will go via rtw tree. Thanks.=20



