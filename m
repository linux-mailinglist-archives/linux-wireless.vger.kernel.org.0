Return-Path: <linux-wireless+bounces-17990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0CA1D0C6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B90188645B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C628E7;
	Mon, 27 Jan 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NHGincKs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAC623
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958023; cv=none; b=b4FFz7tgblS5WX73Ht9duVpAkaftmImo+nkNRwMdDABdEMuJn0r92hhjiqQf7+UQ3+B2/fq869/Zk2CDawpFLvjxDj2bCZ/ws8581tRGUNt/liGm+5LqIwOvJJIvLnxgXKwZdxO0JFo9PoXRxg1Q2kyuGSA3Wbt+iykWeVemXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958023; c=relaxed/simple;
	bh=dJv36ajhPaiFcUvs0Tcs9RxANq6Gd+4JEWpFkXAqpj8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0jSr2DpPg/C2p4v3de+ViSe4ci+y5t1U/w6YaCPUAVptrOQOVkK/mhD6FwabzVwi2dudHoOVuWZTyQaIYedhCuaU82VBIpdv6AUA8/qDzsLQ4P8zYSt17vgdYZW2EYg8VwNiPwsThqFfsnjR4DaFSyBA2YM3K+H0IO3BinHPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NHGincKs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R66vRfA2573934, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737958017; bh=dJv36ajhPaiFcUvs0Tcs9RxANq6Gd+4JEWpFkXAqpj8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NHGincKsi+IcAJC2aFJdlb1605m+wrOnOuujmh0KmceCrLWszGRrpmOAUNHMz6lCB
	 O9elYHiuJCOR4hMD8qaoEvVgtzxi+DoeObRu8slgHNgzVlK9DQXmkGrT5SQb91mtxF
	 7fs/fYqjeMzRd5Y5+YpB22un61JzVfV7dQKmEqxpN6caTvioUhSK8gpq58zn+H3JQY
	 dBnzTSTQRIBYKtl/JkMJji8ZH0e3P2MrtuelrN3PHHXeeg5q4FJIckqeH+HiTGu/x1
	 RZPo9bEOlb3fBVM+smO1o930aApCXIhT4U3QjblnZd1OpdBU5X22pyZJp+hojG8G9m
	 1LecD50sZNxog==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R66vRfA2573934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:06:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:06:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:06:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:06:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/7] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
Thread-Topic: [PATCH 1/7] wifi: rtw88: Fix __rtw_download_firmware() for
 RTL8814AU
Thread-Index: AQHbcEUtx6YhuDuE1EylZqdE16s/PLMqIp3x
Date: Mon, 27 Jan 2025 06:06:57 +0000
Message-ID: <9d3c00e3ca4b43a687030a3ad9607180@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<0e9b08ef-4719-4d37-8b5c-2d1a780499d7@gmail.com>
In-Reply-To: <0e9b08ef-4719-4d37-8b5c-2d1a780499d7@gmail.com>
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
> Don't call ltecoex_read_reg() and ltecoex_reg_write() when the
> ltecoex_addr member of struct rtw_chip_info is NULL. The RTL8814AU
> doesn't have this feature.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>=20

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

