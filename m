Return-Path: <linux-wireless+bounces-9233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0390E30F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 08:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D2C1C2151D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FB5B1F8;
	Wed, 19 Jun 2024 06:07:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5159147;
	Wed, 19 Jun 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777247; cv=none; b=XmRlsc6UX8T/aqt9kASL6fJaZDCavqKP7MEPNIcLSrrPWAlYnRDSg2nnuaMrvb46WWWY02OIww1eQ/LwvLUN+/1k9rMRJp2qS6x8mXw1apZRKQs4u84fBZW2MqZdUfmclDdGNUNOc14dBno3ZgdgNc6sE/K/TsdaGXgGRA/J1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777247; c=relaxed/simple;
	bh=+P6dmFC4FbU41a9t+5uZ+SLhBH2vrK1uXjqcBeAq8KU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HvxBrAv2LqFRsvK+efyHIuAKOE65okRFHGdJ0/ma5eQ03oTKahSv3ok4xV5j6reDeWwCp5S7vFUf9I3TwyN473/ytIUvWQIf08x3c2alohoPw97y3ygokm/3uUwpKofoiPQ0FKGsBJIbQW8XUafzgG3vu9r9P2k8n8K3C5OSrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45J67FxK41374906, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45J67FxK41374906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 14:07:15 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 14:07:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Jun 2024 14:07:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 19 Jun 2024 14:07:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Forty Five <mathewegeorge@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHawgusbA+C/SyMRES67Y/3y6K7kbHOmQDA
Date: Wed, 19 Jun 2024 06:07:15 +0000
Message-ID: <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
In-Reply-To: <87tthpwkqf.fsf@gmail.com>
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

> # first bad commit: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw8=
9: add wait/completion for abort
> scan
>=20

Please try [1] that fixed "wifi: rtw89: add wait/completion for abort" for=
=20
certain cases.=20

[1] https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshih@re=
altek.com/


