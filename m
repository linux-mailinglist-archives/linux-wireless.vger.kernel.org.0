Return-Path: <linux-wireless+bounces-9274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7D90FE9C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4439283FA1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AB19EEBC;
	Thu, 20 Jun 2024 08:16:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2D19E824;
	Thu, 20 Jun 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871402; cv=none; b=kmAWKpvUeKrUILbxz2yPWGyD3csEGaDcTRitxkCPvYIBrmLt4QgZ5ItYHu8OH0mGE9z1+lofuekR0bxxO+GF+0vyA58UN8dM+WSsIzq9VGx+j9Egs4AaxTFwZd10s1poxgZ0t+LJnRKy005D+O9NOR2A4QNiCDEcV7TdYUWx5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871402; c=relaxed/simple;
	bh=zwI14SDizKdaiQThe84O4NuoQKswc/qIBOQ4049ezys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kFqbReK42rraLU/7XsTTn+84p3wbRNtaMG+lv7ELmid0A/MA07bU/CYgf7/kWXnHRJAHNa5IXhBEohzkxI9kJIHFi+4w/35t+NfCPECyTsKtV+i5HeY5KQfiJa/1qZqvnkh3yVKXNGBDHk5BskANo5VckourqP72xiLg4uMQoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K8GLVb82689660, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K8GLVb82689660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 16:16:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 16:16:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Jun 2024 16:16:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 20 Jun 2024 16:16:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Forty Five <mathewegeorge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHawgusbA+C/SyMRES67Y/3y6K7kbHOmQDAgAALtgCAAakyAA==
Date: Thu, 20 Jun 2024 08:16:21 +0000
Message-ID: <6970398610c546b1b62e599902c67572@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
 <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com>
In-Reply-To: <87sex93s63.fsf@gmail.com>
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

Forty Five <mathewegeorge@gmail.com> wrote:
> > Please try [1] that fixed "wifi: rtw89: add wait/completion for abort" =
for
> > certain cases.
> >
> > [1] https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshi=
h@realtek.com/
>=20
> Doesn't fix the issue. I get a freeze on the first suspend+resume. I've a=
ttached the crash log.

I tried 4.10-rc4 + the patch on ubuntu. Never reproduce the symptom.
Please share Arch Linux image you are using.

Could you please help to collect 2 or more crash log? So I can check if the=
re are
more than one crash cases.=20



