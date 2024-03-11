Return-Path: <linux-wireless+bounces-4529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C105F877A36
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 04:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E51F21DFE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 03:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D397469;
	Mon, 11 Mar 2024 03:54:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF587462;
	Mon, 11 Mar 2024 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129290; cv=none; b=mDz4Ct5/OdLiRhBx4zAWUnzdz8R42gERGgC8rU+XfkXq5b4DbnD9ch1oRXmOk1pxqfD7FvxdbDDd9/Qq/Z8dD3X3tx4DEj96JZ8YmAVH9HcQZbq8kma4fKJxkbJEw3BBIzj978NNhF1nIfRFs8eLVY5nosi1koL7fsO7nbZlDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129290; c=relaxed/simple;
	bh=LNshONkP02+schyxBTByqTg+B69rZTCaUr5Lq3Jh3WA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6TTpuPJLbHwRMssRITF2NLicYqUr2Uvws+dsyvTdV1ykfwA/7n9ayj+1MqOsSELicNniP2NcOKi8lkeVH2mc5cp2++inAy4THtyrRe0OMUY3LuqlceEYxi/bwpOqDbjzvW/RXZzGGcR2cAlRYPQCSRPriXAAvl64utmSTaWyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42B3s0GC13378382, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42B3s0GC13378382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 11:54:01 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 11:54:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 11:54:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 11 Mar 2024 11:54:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH v3 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Topic: [PATCH v3 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Index: AQHachknEm+A4Fo7TUmXxfCF5rkBBrEx6jIA
Date: Mon, 11 Mar 2024 03:54:00 +0000
Message-ID: <20680fc647dc446aab7742d48b8a0a32@realtek.com>
References: <20240309115650.367204-1-fiona.klute@gmx.de>
 <20240309115650.367204-6-fiona.klute@gmx.de>
In-Reply-To: <20240309115650.367204-6-fiona.klute@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Saturday, March 9, 2024 7:57 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Fiona Klute <fiona.klute@gmx.de>; Kalle Valo <kvalo@kernel.org>; Ulf =
Hansson <ulf.hansson@linaro.org>;
> linux-mmc@vger.kernel.org; Pavel Machek <pavel@ucw.cz>; Ond=F8ej Jirman <=
megi@xff.cz>
> Subject: [PATCH v3 5/9] wifi: rtw88: Add rtw8703b.c
>=20

[...]

> +#define GET_RX_DESC_BW(rxdesc)                                          =
    \
> +       (le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))

Move this to rx.h beside GET_RX_DESC_xxx. Then, we don't miss it when doing
conversion later.=20



