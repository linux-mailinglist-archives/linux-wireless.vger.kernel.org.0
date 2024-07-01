Return-Path: <linux-wireless+bounces-9747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3DC91D777
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 07:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D24B20A1D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 05:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7362F34;
	Mon,  1 Jul 2024 05:36:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D618622;
	Mon,  1 Jul 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812214; cv=none; b=a9s80o6vpHwNt2hQOMDiWmUeQ8SuT87x6Vb/xfdrIVXlaoTsMXzWzWmu8jZH8REYxfATjbXrBOsIaVv/+vboxLwQw+Qj9RHZ8v6TdpurEOY4o189SBzzcbXGKLODgPnh2Q1xwmxkTaoDUcF7M7TGkPiA0hy0gxvFD4hO/zEG+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812214; c=relaxed/simple;
	bh=GuQf7TfBkCRJA2hBO+RSxsU6GtFO7TmAZo2ViDhCMzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=nkE5dBdXNXjzQxX/1Och285gai0g++WUn28WEHYvqwhdzNfGqis76Bv9OAlCUVvhtSP9mXHWEi/Wj93t5wCfobDekYUxxAkoNTD+Q7+Y/PT/q5qGZYLevsD2Jw32iBhOGBvorN/RvH8dTpiCPf24jVCsz9r+3dER8r/SKfdYieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4615ae7733440549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4615ae7733440549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:36:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 13:36:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jul 2024 13:36:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 1 Jul 2024 13:36:39 +0800
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
Thread-Index: AQHayyKWbA+C/SyMRES67Y/3y6K7kbHhKj7wgAAv2IA=
Date: Mon, 1 Jul 2024 05:36:39 +0000
Message-ID: <21ef26fea9b84ce3bd537301664931d1@realtek.com>
References: <875xtqjli4.fsf@gmail.com> <87a5j2s0e2.fsf@gmail.com> 
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

Ping-Ke Shih wrote:
> Forty Five <mathewegeorge@gmail.com> wrote:
> > Forty Five <mathewegeorge@gmail.com> writes:
> >
> > > I applied both patches on the latest master; here are the crash logs.
> >
> > Just realized I forgot to run the commands to get debug messages for al=
l
> > except the first crash log (kdumpst-202406301756.zip). I'll send more
> > logs later.
>=20
> It looks like you forgot to apply my attached debug patch. With debug mas=
k,
> many messages output to kernel log but I can't see things before suspendi=
ng,
> is it possible to enlarge buffer size of kdump?

Sorry. I misread what you meant. I have seen logs after kdumpst-20240630180=
0.zip.



