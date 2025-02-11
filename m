Return-Path: <linux-wireless+bounces-18741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6BA3035E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 07:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8DD188A6A4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C526BD8B;
	Tue, 11 Feb 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LoameRNx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2026BDB9
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254822; cv=none; b=QFoRgTup70i50NUNvCoyhVIgPN5MJASrWKhF/1j8uuoNhkuWSzSfjzDl92mzjNYS/jTo2zhwqzoqntM0GI2XdEHAzA6zrXzOIZE11Wx6FY6ETetdQ7KxYl5Q0Q92pTIQk0xxRBQGBZLZABgTEXIlIB3PQHOly9kXVTmj1lLVBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254822; c=relaxed/simple;
	bh=vbte7hB2p8ay+3x/6C959Jj8NKTWjTL7I4UNnRRaTgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QTdmA0DDt9q/3vTAhYxQjsrj32WGw5LxLhouElHBYiZt5Y1D4f2daDUosGqt7zCd4eL4MLfTVYx1XEjR6xmvp3z7c89mhPqNJoSRmcIq2JbLc+//8UqpqxYL9YTOvu61jQaav8SvuB5h3NHA2xXhGgt8joJ81VQRF0eSmt9PhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LoameRNx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51B6KFgO44083164, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739254815; bh=vbte7hB2p8ay+3x/6C959Jj8NKTWjTL7I4UNnRRaTgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LoameRNxs3fPtfQ6/UeW7SGDutMKUuTceRE7WjlXZ5Nzn+Ve2PtltQQ/JTp5omAs4
	 ZdqLKCByPLS8Z/08iB7bHfzbB6gLCZJiKbqetgrbU8pHjtTgS5TpXR3zreo6rNkJod
	 5EPm1Hva1ye3Gwy06dxOK9SXwbrj0ElM7kHoPeY8cWloihPi4AZBHP5P0CWwIeZacU
	 KmlFoYxSFdjIVodcKzos7wqV9+t67Xu40sSl9dpQLEMuJyQv2ZpADyrYAdeV2QpXPr
	 FfavW1cMWJYXzpn1KKsNS/XeYdo8MdZeST7DnidC+QLu0HtIxkb0SeOKTrdCJQb7DH
	 EWxnPBAbESvOw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51B6KFgO44083164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 14:20:15 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 14:20:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Feb 2025 14:20:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 11 Feb 2025 14:20:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1
Thread-Topic: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link
 DWA-T185 rev. A1
Thread-Index: AQHbe455GovrMsKY002rA8aWeyvE1bNBm+8w//9/mICAAIa6QA==
Date: Tue, 11 Feb 2025 06:20:15 +0000
Message-ID: <b58fcb1185a24661a09d1eceeeda843a@realtek.com>
References: <1f46070899bf4ddaa7b668a1f96b85ed@realtek.com>
 <20250211061541.1730-1-zenmchen@gmail.com>
In-Reply-To: <20250211061541.1730-1-zenmchen@gmail.com>
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

> > By the way, these IDs aren't in increasing order, how did you pick IDs
> > from vendor driver?
>=20
> Mikhail Novosyolov taught me a good command [1] to find out the missing
> USB IDs. :)
>=20
> $ diff -u --color \
> <(modinfo a.ko | grep ^alias | sort -u) \
> <(modinfo b.ko | grep ^alias | sort -u)
>=20
> [1] https://github.com/morrownr/88x2bu-20210702/issues/224#issuecomment-2=
404823387
>=20

Cool. I thought you compared them with source code rather than binary code.=
=20
So maybe it is not necessary to align them in source code.=20


