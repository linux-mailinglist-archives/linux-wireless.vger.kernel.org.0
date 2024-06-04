Return-Path: <linux-wireless+bounces-8477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846AD8FAE28
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F1C1C20F19
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E29F142E66;
	Tue,  4 Jun 2024 08:58:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F10BA39;
	Tue,  4 Jun 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491484; cv=none; b=SJ9JnBaP2YDOrMCsnzOlKqy/mguvDMn9iBSa33QV4fdlMim/o7uw9FPVr96Db8egl+v3sbdEdGEhRrrdbr4aum3aLIjTgSDJ+UIzxZ3GcwkAH8IXR42Xm2trn7ZBZRKhTH0MscTC5cGHTvXDUSMrbPkL2GL53l06WRAo72wQJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491484; c=relaxed/simple;
	bh=HOrh0/k/GY955ho0OI2VQWz2TWDiJCI6TBfaMD79sLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TZ8I2z92as9yovgKKMECiN2Z9XhNxpV9rAQKS3WBBA/8dM5gOzcf9HXP3pcypyaY4xuXtrsGd5oc6K3g7RXcNWSBXvsPQjb/swA/FUezGUtvxpfAx7+tMXfGBMZZeCQgkxRsohByPGWE9MUQij6MbRqpm+I3hPljaU4WY3y9R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4548viVjB4136756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4548viVjB4136756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 16:57:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 16:57:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Jun 2024 16:57:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 4 Jun 2024 16:57:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()
Thread-Topic: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with
 wait_for_completion_timeout()
Thread-Index: AQHatZbao81hPkddpUyWjWsMJ9aM8rG2wuZAgACAOVeAAAvlsA==
Date: Tue, 4 Jun 2024 08:57:44 +0000
Message-ID: <1483c59d26174defb6fb0886a7375ef0@realtek.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
	<20240603091541.8367-6-wsa+renesas@sang-engineering.com>
	<1fca9d83960442b0b637d4e9586766bf@realtek.com> <878qzlt9aa.fsf@kernel.org>
In-Reply-To: <878qzlt9aa.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> >> There is a confusing pattern in the kernel to use a variable named 'ti=
meout' to
> >> store the result of wait_for_completion_timeout() causing patterns lik=
e:
> >>
> >>         timeout =3D wait_for_completion_timeout(...)
> >>         if (!timeout) return -ETIMEDOUT;
> >>
> >> with all kinds of permutations. Use 'time_left' as a variable to make =
the code
> >> self explaining.
> >>
> >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> BTW Ping, you can also take it directly to your tree if you want. But if =
you
> want me to take the patch, then please assign it to me on patchwork (ie.
> change 'Delegate to' to 'kvalo'). My preference is to take it to your
> tree, smaller risk of concflicts that way, but up to you.

I will take it to my tree.=20

Ping-Ke


