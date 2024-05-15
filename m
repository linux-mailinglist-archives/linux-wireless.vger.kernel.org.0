Return-Path: <linux-wireless+bounces-7667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08A8C6039
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7712628230E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DF3BBD2;
	Wed, 15 May 2024 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dac0hrJ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AA3BBCF
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751620; cv=none; b=QbnsOZ+FTPNmSD1PmjofSUrzGHC3Ak615yuhx9fatJSUeQdgoIxMNBHE2g+d3gEfcMqG8/wkLRT7gqM3WaXPgBAp1hvZQIs5mCybn5YS8lZAa5lwi3RIUqbK9cFMhjxSGq0DeLbIO+MEn94CN0BNA0VWWUnd551Sv/zje+C2NEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751620; c=relaxed/simple;
	bh=fzRhkdEOMajDQotB+lfdKv6JPj6r9hVAug/W85FMnpI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RUrSmv5NIt1bLFSY6Rf3ekd6yc+aoT15yQHK06THv5jMOYbELaJXjzvIoennHDg1/S473hbK8E8DwBK1IBScSjjhU+mm9j+1mOqlPPv2ta3pQ4P7MCJJLaXpH77yOIHMRBFHzUiAEl23QS4PyBoUtnuyPFcfHbJxos6GL1x8VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dac0hrJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1178C32781;
	Wed, 15 May 2024 05:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715751617;
	bh=fzRhkdEOMajDQotB+lfdKv6JPj6r9hVAug/W85FMnpI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dac0hrJ3iQ01qxbmYchJO4HwNhn/1GOr1ZMrMEAZa/pkB/1gWErYOlyAuJvw5EWsf
	 gFRWYVJHBmq+H62IWTUIef+JzXSPxy/wuWIBV4hhiNIcPwSj7T1vVern78807zddLa
	 DfhQU17AXoPsWlt537LCs8vfanuSZO11v5pI+I0uUr77NWmbDF2Q75B8sgKA1s7zhW
	 ml+knMH9+Fk34IQDsAaBlCTcJeX/Y40yJGDWiGM7fXIBpVfFYUmox/D3BY2qjKwDox
	 qJaOfUcKNcOcP1Yvv4OgkeUDGupiqBo7XV30sSFhsdFwd2/BF7KU07/tuA+1smWu3R
	 6JzPO+DU2nSQA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Plamen Dimitrov <plamen.dimitrov@pevogam.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network
 Controller and Linux kernel 6.7.7-100.fc38.x86_64
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
	<2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
	<f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
	<efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
	<94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
	<8fa0fcfccfe14377ba053130f95b8917@realtek.com>
	<89fccaa8-af18-4192-8186-f76577694b97@pevogam.com>
	<4e6da84a3a274fcebaae86c42f80458f@realtek.com>
	<c26272e9-069a-44b0-aee5-49530c084365@pevogam.com>
	<d69ab1ccd3fd456a82ae954d25d056ba@realtek.com>
	<25c629d5-f356-4eeb-a2e2-e184f024fad0@pevogam.com>
	<23d3e142-125a-4b3f-99f6-1f85d47541f7@pevogam.com>
	<1be6ea15441542719b573cdad1ccf008@realtek.com>
Date: Wed, 15 May 2024 08:40:13 +0300
In-Reply-To: <1be6ea15441542719b573cdad1ccf008@realtek.com> (Ping-Ke Shih's
	message of "Wed, 15 May 2024 03:47:53 +0000")
Message-ID: <874jazeipu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping-Ke Shih <pkshih@realtek.com> writes:

> Plamen Dimitrov <plamen.dimitrov@pevogam.com> wrote:
>
>> With the newest Fedora kernel and firmware version I see different error=
s:
>>=20
>> =E2=94=8CMay 14 10:20:28 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: loaded firmware
>> rtw89/rtw8852b_fw-1.bin
>> =E2=94=82
>> =E2=94=82May 14 10:20:28 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: enabling device (0000 -> 0003)
>> =E2=94=82
>> =E2=94=82May 14 10:20:28 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: Firmware version 0.29.29.5
>> (da87cccd), cmd version 0, type 5
>> =E2=94=82
>> =E2=94=82May 14 10:20:28 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: Firmware version 0.29.29.5
>> (da87cccd), cmd version 0, type 3
>> =E2=94=82
>> =E2=94=82May 14 10:20:28 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: chip rfe_type is 1
>> =E2=94=82
>> =E2=94=82May 14 10:20:28 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0 wlp2s0: renamed from wlan0
>> =E2=94=82
>> =E2=94=82May 14 10:22:42 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: failed to pre-release fwcmd
>> =E2=94=82
>> =E2=94=82May 14 10:22:42 vagrant.whitetree kernel: rtw89_8852be 0000:02:=
00.0: timed out to flush pci txch: 0
>> =E2=94=82
>>=20
>> Any idea what could go wrong here? I have tried disabling via all before=
-mentioned methods and the network
>> card crashes on both older
>> and newer kernels despite all my efforts.
>
> What is the kernel version of the newest Fedora? I can try it in my side.
>
> It looks like firmware enters abnormal state, so my suggestion is to disa=
ble
> all power save functions to clarify the problems, but it seems like you
> have done all of them.=20
>
> Is it possible to remove modules from /lib/modules/ ? Then insmod manually
> with module parameters to disable power save functions one-by-one?=20

BTW it should be also possible to blacklist modules to avoid them being
loaded automatically. At least in Debian I do this:

$ cat /etc/modprobe.d/kvalo.conf=20
blacklist ath11k_pci

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

