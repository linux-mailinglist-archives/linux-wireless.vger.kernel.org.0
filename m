Return-Path: <linux-wireless+bounces-10097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FA92AF11
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 06:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A79A1C21CFC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 04:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712A487A5;
	Tue,  9 Jul 2024 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fQQSJx3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D928DB3;
	Tue,  9 Jul 2024 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499135; cv=none; b=kaqWwoHpcjj+sfryztqbleh0auTWUReg1I/BgeDc4I2cN94nnG0uFyfVpLtFGpI+HYddnMBZX/qVM35t0vhwi3LLsIM+lmHwqC35lu/VsdQenLBBvIgBZyPz5taWq/qMu1Jca1pg7QF2xS93+cStR4LH7OPWyNl3WHs6KwyW6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499135; c=relaxed/simple;
	bh=xlUZK+6sDB8jq8BTErl0bTqYq7TYFfrIpzBCtDc5mrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHcluzaQKc7wOM4d1tie6tnaC0IGc1clpPZaqVdQXQNesG6pok6WMxvS+iTm7TQsBRGFaW487AuRazJgm0UXfbGhefkAcSr6rjFFmB+5N8XlAEl5f/Vr4Q1JSRwXeWgFhWjpgBwAOYz+f37Z0Ht3PrZ9hvz/y8BJWsgLDXUk/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fQQSJx3s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4694PJwX4303240, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720499119; bh=xlUZK+6sDB8jq8BTErl0bTqYq7TYFfrIpzBCtDc5mrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fQQSJx3stDnp5lbVEdFUaCYZVeiOTC/L7/JrX6WYPyB3nja81NY5GC6sbbKrACl0A
	 E5DaMvqVko/2Kfn8zgEpUtpxAJO+GymPNr0prli8zMVsN+Ui5sRlBekd0m+x1Jn4nm
	 jNKSItWcKj8I2wOD4EIIBDgmQ147inLzpU6RxqOd+RCGzTND4/roLBxOulmG2INqgD
	 LVRwMHejPT/+4+cUdQo29gHZlpypypIjX+wI+z2uDx0XO/cQpx81S3118WguDG5DWu
	 bFjL0cNJ4YqtagpBtYwOQivHGvgrAU0Sp28fkMXlh0af4RFv6YsnmGMmNO9DuITLS4
	 LWreQLazICTHg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4694PJwX4303240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:25:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 12:25:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jul 2024 12:25:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 9 Jul 2024 12:25:19 +0800
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
Thread-Index: AQHa0VQl1ZM9p1UVPU2+rvQ8T/H4+rHtmRKw//+qGICAAIjSQA==
Date: Tue, 9 Jul 2024 04:25:19 +0000
Message-ID: <e9c35b3d72a34c8e8ac607590917681a@realtek.com>
References: <draft-87msmrdgkb.fsf@gmail.com> <87h6czdexm.fsf@gmail.com>
 <6673a2dc01a941f5900da7393d160005@realtek.com> <87o777tdbw.fsf@gmail.com>
In-Reply-To: <87o777tdbw.fsf@gmail.com>
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

Forty Five <mathewegeorge@gmail.com> wrote:
>=20
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Right. Only apply [1] in every bisection step.
>=20
> Patch fails on 57f22c8dab6b266ae. Could you send a version that succeeds?
>=20
> Bisection log so far:
>=20
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [5bbd9b249880dba032bffa002dd9cd12cd5af09c] Merge tag 'v6.10-p4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad 5bbd9b249880dba032bffa002dd9cd12cd5af09c
> # status: waiting for good commit(s), bad commit known
> # good: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw89: add wait/=
completion for abort scan
> git bisect good bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23
> # bad: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-202=
4-03-13' of
> https://gitlab.freedesktop.org/drm/kernel
> git bisect bad 480e035fc4c714fb5536e64ab9db04fedc89e910

The commit date of culprit bcbefbd032d ("wifi: rtw89: add wait/completion f=
or abort scan") is
     CommitDate: Tue Jan 23 13:38:15 2024 +0200

But, you want to apply to the top of 57f22c8dab6b whose date is=20
     CommitDate: Fri Jan 19 13:49:16 2024 -0800
and doesn't contain commit bcbefbd032d, so no need to apply [1] at this poi=
nt.



