Return-Path: <linux-wireless+bounces-17998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83916A1D143
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 08:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61307A12AC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D9158D8B;
	Mon, 27 Jan 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MJbyCB7Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAE1FBEAE
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962052; cv=none; b=b9wVhbs+6L6/nf+OkUviSlkAGgDyxPXP8FxCWya+T6FXx4NDSovdeuMnoehUXF782OE8XR7auQFVYx/1Ol034+n/nOZho3rNFVh+bthMJ/ckpJzO5k7lxvPe+LWH/UpRfpM8GbJYydYfwigjCoDSxpWW5Q2hdCNoW2fWMICk/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962052; c=relaxed/simple;
	bh=E+8ZnV6GvHmI+6ks6qL2TJ5CH0+Txa/8L+DjQcOEP0I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqzByhQpImhT1LucsPY3XbaR+l23n8OO5VxZzD3cDQK+l+hlR35C9oN5127v0/rxbP8OltseoVg8CUz+mbvHrWYzJ3Z+4R98nPaa3bFEKRkTmBd4momm8cPhuSoH/+9qIREWpPknuXmokpElEm2Sl0QZ9fMNMAE/eRsh/pi/QWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MJbyCB7Z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R7E4Sc82643419, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737962044; bh=E+8ZnV6GvHmI+6ks6qL2TJ5CH0+Txa/8L+DjQcOEP0I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MJbyCB7ZhTj6wSBRpSGljwLNKEBJIY1eBQ/Nnsbcp2f/pLTTKn3/zKbTtGob6mROP
	 oYXu81kcu7MNn/30zQLURTbQkGqiCw2/6lgh5+C2j3kyfTSSpH4MeRGwwWOPRXpaiH
	 JRXCg16n1vocGa9r7x+t4URl8lM7q6NR6LxJ1tKylFojiEOVO5koP8xMG+RTvZAx8T
	 Ujgf5af6YUPoGXuP8I7lVamQLATb8jODv+cJ1Ax7xFkYt69mnNZHijBqtIxwwt8zmV
	 WDX9IH6BAxmObYMrDTxJChuVYFiyuogMXdSLEzt59yDst+/nJVm7cuEOeXtp5QQTCw
	 vicSt2ywxd/vQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R7E4Sc82643419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 15:14:04 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 15:14:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 15:14:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 15:14:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 7/7] wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
Thread-Topic: [PATCH 7/7] wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
Thread-Index: AQHbcEZaMD+iYke1PEWfdvZwcYqymrMqNUmj
Date: Mon, 27 Jan 2025 07:14:05 +0000
Message-ID: <3cab88606e1248a49fb5d43e71cfa7d5@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<2a7c21bd-e78c-4792-99c7-fc73ce209930@gmail.com>
In-Reply-To: <2a7c21bd-e78c-4792-99c7-fc73ce209930@gmail.com>
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

> This function tells the firmware what rates it can use.
>=20
> Put the 3SS and 4SS HT rates supported by the other station into the
> rate mask.
>=20
> Remove the 3SS and 4SS rates from the rate mask if the hardware only has
> 2 spatial streams.
>=20
> And finally, select the right rate ID (a parameter for the firmware)
> when the hardware has 3 spatial streams.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


