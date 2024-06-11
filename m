Return-Path: <linux-wireless+bounces-8772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E7902E48
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 04:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF321C21B51
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0F6156F39;
	Tue, 11 Jun 2024 02:23:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3E15688D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072583; cv=none; b=aXfOYSK34BtqbcgcDbh/gKFtnpUn16mrwWwjk5iXi9ioXdvUMwVXfcBcfOPCfzyWl+6noYs62eOeyeEGLjIYgqYFVqe2xQrq7WUrLxTMQ+9m0cODBD9+LY8rD8U3k4lqtD7Nv18sC6qh4pkGjpWPwc824BaRK6tL3bC92JJVHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072583; c=relaxed/simple;
	bh=rtK2flblxGk0wA9ej0L94tTpI6drJwD1dWg2s2BfeYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VxOsi+o1LdStG0vGECOe7i+5XpvOcuv1T7eMUlIyJEXrC22ep2yCHVHXoZ+b3RTld+MwkHdNeibuISPpdVSuUq8b0UnzqxY9Ezze/iaF+VAtCEjh+0JhqwE4BKmDm3jxxcvWyGtv87NE5nn6t5xTwMrhwk9IZ75dn2rvB0GqbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45B2MnAV23651853, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45B2MnAV23651853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 10:22:49 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 10:22:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Jun 2024 10:22:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 11 Jun 2024 10:22:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw89: pci: support 36-bit PCI DMA address
Thread-Topic: [PATCH 1/2] wifi: rtw89: pci: support 36-bit PCI DMA address
Thread-Index: AQHauONTsMAyIpaEFk2ubDUOWmFzPrHA2HROgAECJmA=
Date: Tue, 11 Jun 2024 02:22:48 +0000
Message-ID: <3a2529fe5c4b487fa36cc5badb9689dd@realtek.com>
References: <20240607140145.8180-1-pkshih@realtek.com>
 <87sexlkqt3.fsf@kernel.org>
In-Reply-To: <87sexlkqt3.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Modem platforms can install more than 4GB memory, so DMA address can
>=20
> s/Modem/Modern/?
>=20
> > +     option |=3D le16_encode_bits((u64)dma >> 32, RTW89_PCI_ADDR_HIGH_=
MASK);
>=20
> upper_32_bits()?
>=20

Fixed by v2. Thanks!

Ping-Ke


