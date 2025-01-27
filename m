Return-Path: <linux-wireless+bounces-17989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997FA1D0C5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D531661A2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0572080B;
	Mon, 27 Jan 2025 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o78UKW4K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3B623
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737957847; cv=none; b=VepJGwNuQuO4I+Tqm4MsNOZ2zmtczBNHDsHBzuj5VxutAVE2ZSUFJ4rmO6OmtnnB+yzWLPEVOTC+wO4o31HjDDyuI61cj7IsTdUYamiFxC3am9fe0OWcyP2C82sl5jyFP/1/FRd341zE4SeMJ9guLIpBL4VgQiXnYfOX5xn9r7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737957847; c=relaxed/simple;
	bh=Sttbbdjxb1eUlJi1YrmBbFkOX0gXyO8x3Yw/JRHF6ZQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Siz0729EbZ6aylnPMFohHhKJWIKSy8LiuyLppOc0iWBTz8zImTMHuKXkdltkqHSPbYwTeZMrIA+c1Q5vTwnuhAN9ReecBxD/Fsn8cPC2niZnW8aOGColCQhoaHcaA2o/dnregIhYMxXwbnavv12Ymkf9TPa0fvY6Kd/375xniTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o78UKW4K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R6406n82572776, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737957841; bh=Sttbbdjxb1eUlJi1YrmBbFkOX0gXyO8x3Yw/JRHF6ZQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o78UKW4KkEhIX2vmuDjnQtmhWYJEtewWZWi9csdz45ulYBReIJv7g5rOUSeBQYphb
	 Y/8mkj5+bSFp0u9cbZc+Au7A73aMQL+cFxTbmZ8MA2uqOo1eER6EKZVj6NJrNwr2h2
	 OmVVAPrI+BzIQzKGogtDLbOmk4pggg8pjgZlC0bdX7km+3i5v1j3rJvsgotmgo2Qtw
	 a+RnIVxIArJburgFwkWtIYPupaJTitvEm3i2vhFEZucQsazEVNOv738grEVe5MkBzT
	 vhW5Nhl2b78rkuRNtcEv5xK4c1P3G3F/KkaCyusY31crlb47crlMvezyxxk+KP+U0G
	 bNoL5oleFIABA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R6406n82572776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:04:01 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:04:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:04:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:04:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: rtw88: Don't use static local variable in rtw8821c_set_tx_power_index_by_rate
Thread-Topic: [PATCH 2/2] wifi: rtw88: Don't use static local variable in
 rtw8821c_set_tx_power_index_by_rate
Thread-Index: AQHbb/s2Z2q6Cpuo0U+D1bHfeySUsLMqIlLW
Date: Mon, 27 Jan 2025 06:04:00 +0000
Message-ID: <3ed7c4d0db124ab98f4c52863b7d77a4@realtek.com>
References: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>,<fe42858c-9b9f-4f03-9aaa-737472c2cd90@gmail.com>
In-Reply-To: <fe42858c-9b9f-4f03-9aaa-737472c2cd90@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Bitterblue Smith <rtl8821cerfe2@gmail.com> worte:
> Some users want to plug two identical USB devices at the same time.
> This static variable could theoretically cause them to use incorrect
> TX power values.
>=20
> Move the variable to the caller and pass a pointer to it to
> rtw8821c_set_tx_power_index_by_rate().
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

