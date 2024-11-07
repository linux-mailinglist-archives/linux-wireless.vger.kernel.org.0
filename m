Return-Path: <linux-wireless+bounces-15027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28D9BFC02
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90FC28412F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC51392;
	Thu,  7 Nov 2024 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CbFOR+LC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360411361
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944433; cv=none; b=V4mnRXHRgyxZJjgwmDLhGKyd8TcF5E++4wz0q81vtOGjVlrJcr/WNtNmf093Wvtu+yWhG0YCEGdcTAGoeWW4feoa1PZ6ynoFpZNGs/byhvUuwMdVrp5Z2C1QqZDbbx2UMTYnGCzBredcl1zav7sAFtt4ekDGj4oGGGJVC+GLctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944433; c=relaxed/simple;
	bh=ziCAAWGLPQmPvlUixjAWPpWuNu5vC0aayR5nXF2yEQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q15thq5JWi9dpoyfVOQ8duECzBxoL+G2Voeh/VjBjOtLZq0U3ZoAgmklbv0izfayJRrfUCCqTh6sO5HZVK6hWSzy97bvPXjKsBG8HdlxTqkT3usMiY0jNdF0F3weEa9coD85ElwDde2P6zKjQjj1n/L0j5KS717UFbwhmzGe+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CbFOR+LC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A71rddM73686587, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730944419; bh=ziCAAWGLPQmPvlUixjAWPpWuNu5vC0aayR5nXF2yEQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CbFOR+LC75WSa38Pr874IRxd99Xen5OaYHpzqrMQthgIdECBuVL1dV47fqAukkOCA
	 1GxbhzYar3PvGleQePWchVMH7ES0h0632yfek52vMnVnhPeo/KpJWI+oeAVrOgcI9q
	 lEY2dtmS6fuSJndxomZYXMXjwB+Nhgv5VgsTH3sgz2d4khnATYwF6zQZMoYoFF7gVu
	 HBCRkulP9zJDASlamz4wQhksXx+39NKFxMM61KsiDQiOj8fcwXT6IgrL/+wuzaRBo0
	 sKibcb44OUaXNXUrG+lDgnvhDSJvsYWEQBEWgRy/o67585oPR14MyakKrTpXtiO3ZL
	 UDQgwl8slg2aw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A71rddM73686587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 09:53:39 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 09:53:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Nov 2024 09:53:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 7 Nov 2024 09:53:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "usbwifi2024@gmail.com"
	<usbwifi2024@gmail.com>
Subject: RE: [PATCH] rtw88: Add firmware v52.14.0 for RTL8812AU
Thread-Topic: [PATCH] rtw88: Add firmware v52.14.0 for RTL8812AU
Thread-Index: AQHbMK7JUEuVfeHls02tmolgZA5uerKrDgew
Date: Thu, 7 Nov 2024 01:53:39 +0000
Message-ID: <c9dd95ae55bd4f368f3486d2411571fe@realtek.com>
References: <20241107004830.14261-1-zenmchen@gmail.com>
In-Reply-To: <20241107004830.14261-1-zenmchen@gmail.com>
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

Zenm Chen <zenmchen@gmail.com> wrote:
> This file contains the firmware for RTL8812AU and was was extracted from
> the vendor driver v5.13.6-23-g232107d9b.20210820 from
> https://github.com/morrownr/8812au-20210820
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Compared and identical with official release.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



