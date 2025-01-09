Return-Path: <linux-wireless+bounces-17207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BBDA06A78
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F386F3A4610
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4622339;
	Thu,  9 Jan 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vY+FBpr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA71AAC9;
	Thu,  9 Jan 2025 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387761; cv=none; b=JSaTWQfQTQB0/1HxmNCe8tcYYNHE8bzqj6SKBRe/l63ImEd4jM7T+HGog38FRoFW2Cuov4gIfKLDJa0cdGgTJfLcMGfBkLt74NH799/Fr88WgARCyf09r/w8YXNmvquZoXH2IGJTNFVrjRDf4MrPCVQusCFqEzjZpDmTIMWCw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387761; c=relaxed/simple;
	bh=PbG+6qqi0tA/6xoykiyi7rxOpMKdH0ytwX+xKKvaXLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZBGX/9x5a1v+qTBJS+mNooT4/45l84IbWkOOX3sOBdSLfDwy2J/shlTkDFDSa5MrDtSILU0OdgUxu94UtBoNvyxxjs2uyUZiDZwzZqMKnzEBnTd83EPklesjjwUmgIjxo6DAGjVXKx3RgvDvdfm/w+V1prhZSBk4791U+sJWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vY+FBpr4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5091tNJU12295004, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736387723; bh=PbG+6qqi0tA/6xoykiyi7rxOpMKdH0ytwX+xKKvaXLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vY+FBpr4ZjvAuotntLVBX+2ciOt7qtM2wV4lqkbawO5K1MeOq/BDw6H8GyLHr5cFV
	 /7yUeDU4YvOcBi47s+C+WLxb7bFv1Ll/Tfxj0GCheYXQdv9kH5XG/XSk7eVMZFwCA7
	 yCTlRFHjA5QAwOjp9hy2GvR40Oul+nAJzmGVGq+ckG7goYhowU2L0a1opvyLOXJGqU
	 B3COyoukKFRwXltKVpRVatRXbFkIUbGehL6nYIjHqMf53v0hi8Lj5DJfdgnhlnXGl7
	 LeOiP5ApGDeEqfYJgITJ4qnfUjy4R+Yg6dTgM72/aF7i+MhNYVx+IJ80lEP06wyDtk
	 EUgoA82BuIQCQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5091tNJU12295004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 09:55:23 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 9 Jan 2025 09:55:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 Jan 2025 09:55:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 9 Jan 2025 09:55:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liang Jie <buaajxlj@163.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>,
        "fanggeng@lixiang.com" <fanggeng@lixiang.com>,
        "yangchen11@lixiang.com"
	<yangchen11@lixiang.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Liang Jie <liangjie@lixiang.com>
Subject: RE: [PATCH v2] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Thread-Topic: [PATCH v2] wifi: rtw89: Correct immediate cfg_len calculation
 for scan_offload_be
Thread-Index: AQHbYjj27zfrwP0u6kWxiDr6u+CftLMNrh8A
Date: Thu, 9 Jan 2025 01:55:23 +0000
Message-ID: <752e62938a254fef863eebdf4d85e759@realtek.com>
References: <20250109015032.1070045-1-buaajxlj@163.com>
In-Reply-To: <20250109015032.1070045-1-buaajxlj@163.com>
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

Liang Jie <buaajxlj@163.com> wrote:=20
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wirele=
ss/realtek/rtw89/fw.c
> index 2191c037d72e..2be1bee724ca 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -5170,6 +5170,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *=
rtwdev,
>         u8 opch_size =3D sizeof(*opch) * option->num_opch;
>         u8 probe_id[NUM_NL80211_BANDS];
>         u8 cfg_len =3D sizeof(*h2c);
> +       u8 ver =3D U8_MAX;
>         unsigned int cond;
>         void *ptr;
>         int ret;

In reverse X'mas tree. Otherwise, looks good to me.=20



