Return-Path: <linux-wireless+bounces-14580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8DC9B220B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 02:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487DD2814E9
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA514EC7E;
	Mon, 28 Oct 2024 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BAUsl/LK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23596224CF;
	Mon, 28 Oct 2024 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730079901; cv=none; b=hra3eDOoKMQSJh4m+wFdmb/uPFrihAIqE1iS78lwuvvT3yOWrp6Pe92jokR3qdmHd4UJAGB01KZKNiIdbBqGIQ53umH+HCbo6DLWPtAzh0YkEJcKxuvn02xUo0h0+pnM37SMtdhi3eR9CmwonaDJWn6afR72pmpEa8gVe6hBYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730079901; c=relaxed/simple;
	bh=FvZcDZNhMe294VRG0IpsZ++lQGSd7cySgjpfIlhDjRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAyw7CSg6wh0nshjP+IOG8rGxl+94KLXK3W4GHoIop+cwrGNqnUExW6c07Kd/dTOT+gjlSN4rdnVOJqbUPOJG3UAv4vxNk0PgzGwS8cCVLZYENYbl9mVQx+vNWRAbb8zxJFIVXabQSdO3Mo1ZqnWaeQQCEmxlPIkv20+UFggOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BAUsl/LK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49S1iLa15018425, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730079862; bh=FvZcDZNhMe294VRG0IpsZ++lQGSd7cySgjpfIlhDjRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BAUsl/LKo216wHatYtQtvpCC8Rh8xARGn9vQNRHV9tigb04UJ4mDlIGu3syUpulri
	 CQpguU+lf1XGJsFOmGxG4YP0l5qdEgwvGc6F6pS1577NLBhNJMvkM0hzGzh4h1H1Z1
	 4QmzOM4tgnNZ4R+2JgLT+dMX+sycCgk3jSj8TART5AyPFoFgFomI3L/aR/OakvVbAp
	 YQukyEYoL9AAvJ4rT5JEjTtgE9eTntmWSJZ4/DtMp5JWEL5SKW182Z2xqNesfEwGSD
	 ttVBs5I6GI0vYxyF/ZS3UWPc+Gim1UduQTxro8uE6N+J87fAUIr90FkUpi0iuBPdIM
	 lSKB6dBizCJbQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49S1iLa15018425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 09:44:21 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 09:44:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 28 Oct 2024 09:44:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 28 Oct 2024 09:44:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
	<syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
Subject: RE: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read efuse bytes in case of failures
Thread-Topic: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
Thread-Index: AQHbJu7zUNmA/HJ3BESmyQL846u6pbKbY+Mg
Date: Mon, 28 Oct 2024 01:44:21 +0000
Message-ID: <ed8114c231d1423893d3c90c458f35f3@realtek.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
In-Reply-To: <20241025150226.896613-1-gpiccoli@igalia.com>
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

Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>=20
> This procedure for reading efuse bytes relies in a loop that performs an
> I/O read up to *10k* times in case of failures. We measured the time of
> the loop inside read_efuse_byte() alone, and in this reproducer (which
> involves the dummy_hcd emulation layer), it takes 15 seconds each.

The I/O read of 10k times is to polling if efuse is ready, and then followi=
ng
statement is to actually read efuse content back. For USB devices, I/O is
slow, so it might be fine to reduce retry times. But For PCIE devices,
I think this will be risky without testing with real hardware.

Possible way is to use "rtlhal->interface =3D=3D INTF_PCI" to keep original=
 times
for PCIE devices, and only reduce retry times for USB devices. But USB can
operate on USB-2/-3 modes, so maybe still need experiments with real hardwa=
re=20
to get reasonable retry times.=20



