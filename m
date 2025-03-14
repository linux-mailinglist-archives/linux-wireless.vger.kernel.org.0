Return-Path: <linux-wireless+bounces-20370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79BA6092C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 07:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DBD19C08EF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 06:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884BB13D8B2;
	Fri, 14 Mar 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oyILwuRC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962613541B;
	Fri, 14 Mar 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741933457; cv=none; b=kCYFjiVk6FL1yvoT2++aueI4qKClxFTNob9V6pxpMscwCuDgrTJXniHd/XUkwyihEB/2VDwaJGtP/kKlTrGzahCk8x+xWY+/TvxT+mZyQMF19SYNZ2wI9B08/Ek98CKoYkXbGzojcA3z5desIjdnPWu/pk0HzDgagHflzj+7Pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741933457; c=relaxed/simple;
	bh=ya0SH5JkE73YAbolQjb8lvIYw7c+jueDq6m/+VfZa/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kqZOqzCGZCgSbT9GCghQYAAFuuk1EWvW9fSe6V1REms9av7+ZTx16Y6lnOCb3DignzCuUAZ+ln0qc+vgDQ7XTyA3bD8xYQFcvtYZ5ulj9c20xm1Supaf93RjT8vJwAH8aOZqJ8CKBT0kO/yD9Cn6yApzIiTWnXTqgO9KhcvovLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oyILwuRC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E6NTrR42599211, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741933409; bh=ya0SH5JkE73YAbolQjb8lvIYw7c+jueDq6m/+VfZa/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=oyILwuRC0cWATv6ymcl8VitFUIWHSLvDKfc5kzj+HpxhN1oiTdyODC0ej/ZrjMlEv
	 6dKlXHPqaWZ4xr6aJUMr9LllsuviUksmFChB2PYzWGBOZm2YvBHKVC28ZAk6vH3Y58
	 9876+6bFl4I8xSx8YfDYg9XkgvJX21trt009tvEnaWmf91GqlvFZjICxcYBxkFtxiK
	 1AiECSXYI50TO+D15a38ATdUsEq26gD2GRNtpUG1HA+GupHi5uy1iXUI5X5WdO2L2/
	 ajbSdyojv6GKejmzfs4sVbFLMyhBDhuaFEGPktI6d7IOje6WMHhmgVloa7xPn9UlCg
	 j8kvzFUA+f0tQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E6NTrR42599211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 14:23:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 14:23:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 14 Mar 2025 14:23:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 14 Mar 2025 14:23:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "allan.wang@mediatek.com" <allan.wang@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: mt76: mt7925: fix the incomplete revert
Thread-Topic: [PATCH] wifi: mt76: mt7925: fix the incomplete revert
Thread-Index: AQHblJVLA58AbZ/uukOTsr80EaU7ybNyKX7Q
Date: Fri, 14 Mar 2025 06:23:28 +0000
Message-ID: <619f3ca5dd71408f9b247d945dfde228@realtek.com>
References: <20250314035741.2808863-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20250314035741.2808863-1-mingyen.hsieh@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Since the `Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba f=
or MLO"`
> was not completely clean, submit this patch to fully clean it up.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 73915469c55a ("Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[=
tx,rx]_ba for MLO"")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

To be unique subject, such as " wifi: mt76: mt7925: fix the incomplete reve=
rt of [tx,rx]_ba"



