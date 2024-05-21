Return-Path: <linux-wireless+bounces-7859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D08CA65F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B311F214DB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F931BC46;
	Tue, 21 May 2024 02:49:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCA1B970
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259775; cv=none; b=uKSa7ccbcGAQxniqGImvPFqCJghxdp2nBW7zpWg9olzVKzRuYPYQ5FWtl2sbWJEAXl7zQKHdDvq6U/5d7eEmjb33hcCMw31WnPcWcUvkeS8CjRrIA1LYv2rF6uUDYNQbPftkQuMb3LfTt6eecJH7gMHtVyuN/wwgZac5pBNz8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259775; c=relaxed/simple;
	bh=rZ7s+Lmkr5Od1EIN0LbOu/2KtaeqlFGdHHoNMkdxrWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KEET6MY5ys03zcplLA882sD3V/9J+bEIqmIh2hoAhceMqQ5lqroXPgHJcQd0loOCaAHGVRntGCSwfXaHoIGFtu4sUKUgOoTLxDY5otXIKmyU3kdsLZhjPyUB2pnlgWwzMRksaojcuMuW7Q4NFnwtTh3afYf9eWZOnwzYsPz8CYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44L2n3Xo92093380, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44L2n3Xo92093380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 10:49:03 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 10:49:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 21 May 2024 10:49:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 21 May 2024 10:49:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry
 Finger" <Larry.Finger@lwfinger.net>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 00/11] wifi: rtlwifi: Add new rtl8192du driver
Thread-Topic: [PATCH v6 00/11] wifi: rtlwifi: Add new rtl8192du driver
Thread-Index: AQHaqJ8SlSyGOjdcWUWc1LEooVWii7Gb5NMAgAUb70A=
Date: Tue, 21 May 2024 02:49:03 +0000
Message-ID: <ea5068c3e0c94d52912d7f4edf524bdb@realtek.com>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
 <20240518064438.0edf5c07@mir>
In-Reply-To: <20240518064438.0edf5c07@mir>
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

Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
> On 2024-05-18, Bitterblue Smith wrote:
> > These patches add a driver for the RTL8192DU chip.
> >
> > Power saving is disabled by default because it's not working.
> >
> > Dual MAC chips are not tested.
>=20
> Just a quick functionality check with v6 (based on top of v7 of the
> common code preparatory patch series), all fine at ~162 MBit/s
> thoughput (5 GHz/ ch52, WPA3SAE, QCN5054 AP, ~3m distance). Steady
> performance, working really well on my Delock 88540 (0bda:8194,
> single-mac).
>=20
> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
>=20

Thanks for your test and report. Could you please add your Tested-by tag
to the patch "wifi: rtlwifi: Enable the new rtl8192du driver" next time?
Then patchwork can help me to take your tag.


