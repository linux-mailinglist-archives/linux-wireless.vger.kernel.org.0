Return-Path: <linux-wireless+bounces-6427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AE8A7EA2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 10:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6709F1F21842
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB280127E17;
	Wed, 17 Apr 2024 08:48:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA87F470
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343694; cv=none; b=rsJRXZmmi4i+0C+7yHVsY3sG1uGJOg1Qh2CF2FLkD4vdoou5m7p2//v/Zty3LADHFZzhS2Ljc78ibNB7X5JdZMsMw4Z9IJW7IAjiRLMc280IkqzDSXwyKMqNdtKKGwoqio1eqpdBGBzK9bX3WBgI6EiLZk9ZlHSBQP9sgsLCCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343694; c=relaxed/simple;
	bh=zjwL7SYS2h/fc8P2sSyWE6zFC+qIUDI4KQK0gLRW82U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nv87c/YCBXYlWabYYSTN1VaQtVRHNnS3viPN9XJ3W5KmKg8FSJhhof8/zkDyr3XI+Boxx7y8m+UNJNrV2UXCYNc0c5RkwZbMrfUdARhOa6/6FW9iuL12aTQgvnO3mq3kwwF39RjnkHMvSamY33buOSuxymDdHZna82QqB0mHVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H8lvprF3183628, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H8lvprF3183628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:47:57 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:47:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:47:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 17 Apr 2024 16:47:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra
	<martin.kaistra@linutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes
 Sorensen" <Jes.Sorensen@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: enable MFP support
Thread-Topic: [PATCH] wifi: rtl8xxxu: enable MFP support
Thread-Index: AQHadi+EaQT0NSwYfk2FMY1mPLyqGrFnTGAAgAFDQoCAANBHAIACUp6AgACPcHCAABQHi4AAAzrg
Date: Wed, 17 Apr 2024 08:47:57 +0000
Message-ID: <eefdf5e598eb4e758130d416793ad9d7@realtek.com>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
	<fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
	<5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
	<1cbb57c2-3d8f-4932-9132-d46a871c944b@gmail.com>
	<1e600703-1208-4adb-a486-2a770cff55ed@linutronix.de>
	<55d21b23c729465a9c5116cb2a9dc9f5@realtek.com> <87v84gwfzh.fsf@kernel.org>
In-Reply-To: <87v84gwfzh.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Kalle Valo <kvalo@kernel.org> wrote:

>=20
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Hi Kalle,
> >
> > Martin Kaistra <martin.kaistra@linutronix.de> wrote:
> >
> >> Hi Ping-Ke,
> >>
> >> Am 15.04.24 um 21:14 schrieb Bitterblue Smith:
> >> > On 15/04/2024 09:49, Martin Kaistra wrote:
> >> >> Am 14.04.24 um 13:32 schrieb Bitterblue Smith:
> >> >>> On 14/03/2024 18:48, Martin Kaistra wrote:
> >> >>>
> >> >>> Also, won't you send the patch to the stable tree?
> >> >>
> >> >> The rtl8xxxu driver previously did not have the MFP_CAPABLE flag
> >> >> set. As I am adding new functionality
> >> (support for WPA3), I don't think this should go to stable.
> >> >
> >> > Without your patch I can't connect to my phone's hotspot
> >> > when it uses WPA3:
> >> >
> >> > Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: nl80211: kernel
> >> > reports: key setting validation failed
> >> > Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: WPA:
> >> > Failed to configure IGTK to the driver
> >> > Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: RSN:
> >> > Failed to configure IGTK
> >> >
> >> > It doesn't say anything about WPA3 or management frame
> >> > protection, just prints those unhelpful errors and tries
> >> > to connect over and over again. To me that looks more like
> >> > fixing a bug than adding new functionality. It's just sad
> >> > that people need to install kernel 6.10+ in order to support
> >> > WPA3, when the patch is so small.
> >>
> >> I would like to know your opinion on this. imho this patch should not =
go to
> >> stable and I would therefore propose to just send a patch to improve t=
he checks.
> >> If you as a maintainer however say, you would like to see this in stab=
le, then I
> >> will send a revert and a new patch.
> >>
> >
> > We have a question about MFP support to stable tree. rtl8xxxu never sup=
ports MFP,
> > and recently we have a small patch (10+ LOC) to enable that. I feel we =
should
> > treat it as new feature, not add to stable tree. But as Bitterblue ment=
ioned,
> > it looks like a bug. Need your opinion.
>=20
> I assume you are talking about this patch:
>=20
> https://lore.kernel.org/all/20240314164850.86432-1-martin.kaistra@linutro=
nix.de/
>=20
> I have no strong opinion here. To me it also looks like a new feature
> but it might fall within "Serious issues as reported by a user of a
> distribution kernel may also be considered if they fix a notable
> performance or interactivity issue" stable kernel rule:
>=20
> https://docs.kernel.org/process/stable-kernel-rules.html
>=20
> Maybe go with 'Option 2'? That is, wait for the commit to go to Linus'
> tree, send a mail to stable maintainers explaining the situation and let
> them decide. But I would be fine with 'Option 1' as well, your call :)
>=20

Thanks for your inputs, Kalle. :)

Hi Martin,

Bitterblue had a simple way [1] to support MFP, if that also works to you, =
I
think we can revert your original patch [2], and add an new one with Cc sta=
ble.
If that doesn't work to you, let's keep your patch and go via 'Option 2'.

[1] https://lore.kernel.org/linux-wireless/ed12ec17-ae6e-45fa-a72f-23e0a346=
54da@gmail.com/
[2] https://lore.kernel.org/all/20240314164850.86432-1-martin.kaistra@linut=
ronix.de/



