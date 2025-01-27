Return-Path: <linux-wireless+bounces-17988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B3A1D0C4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9CD1657E8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662780B;
	Mon, 27 Jan 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TTSSE0yp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C812623
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737957792; cv=none; b=lzlm/vut8NQH4TdAIy/qTHdP8QJlqi9kJ0YDCnDJHve01jDUcLy/gSlpxB+Bg9huLBMuXibgLGOZT2lktNGg6joxV6KOCiZ7uofzE4vEC7ea70JFXno72WKjG0i420FdglfGfXhtbsxFpm6rUoXUcjzy2Ux5iHjlsjAVWbhd9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737957792; c=relaxed/simple;
	bh=yPNiUmCkQW0LpKqqAju8Q9TONwO0FlpetXkMAcYSxB0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLAhjzNVLCF33XwOs+2rpJmcx4Zrx/2dVc6LH+t4eqi7AaE75rUIhIVoVom/uhV1t89wNaFnf7Ntgl4+kIUuIsYYkqyz/xa4kD+xNs9DcCRfPFsHskBPLwNCNiIwozTSApFbs5RzYJcYsqQncr8cLeGxKj9vCNyDUQBU8kBd6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TTSSE0yp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R6333u82571126, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737957783; bh=yPNiUmCkQW0LpKqqAju8Q9TONwO0FlpetXkMAcYSxB0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TTSSE0ypU8locrMwZw4x3uDQSDw6xszwZ4ssOcDfkkzcYq473SNhYkXKVB5MAvmJY
	 OXl20voBY2KlUsvfKb7gItbjr8oPx1fIPsX0tFFT7y4ysRKwvOnKAlCYQcOuzplQia
	 WYT8Dw6EjKv5vvl8G2I6ymvsk6kR0zAgQaYHPJnHLATb51CL6e4j54qUo+Q/9ekQnu
	 Ha/SrWdBDVKaCpKzFvXfmbfkaVKpXetqUaA257TTPpChQB0mA0tYpohgBYcwlx2Mki
	 iXKaLgXO+eGLkJS3IJMEu8eFC7Na8b8OxH5x+OT8GKPO8Yy8Xb1x/SpN+KbhA+Oa9F
	 uxowrfBBzAxcw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R6333u82571126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:03:03 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:03:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:03:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:03:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate
Thread-Topic: [PATCH 1/2] wifi: rtw88: Don't use static local variable in
 rtw8822b_set_tx_power_index_by_rate
Thread-Index: AQHbb/sNod0AYlZhFUCz6HMBWU6cXrMqIT7q
Date: Mon, 27 Jan 2025 06:03:03 +0000
Message-ID: <11853ea27d7b4789b18557e44ef3e62a@realtek.com>
References: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
In-Reply-To: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>=20
> Some users want to plug two identical USB devices at the same time.
> This static variable could theoretically cause them to use incorrect
> TX power values.
>=20
> Move the variable to the caller and pass a pointer to it to
> rtw8822b_set_tx_power_index_by_rate().
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

By the way, if you interest to cleanup rtw88 and avoid this kind of limits,
we can check symbols of output of "objdump -t *.o | grep "\.data".=20
Patches are welcome.=20


