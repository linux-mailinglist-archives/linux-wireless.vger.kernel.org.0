Return-Path: <linux-wireless+bounces-28810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F5C484F8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57438188B006
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96726E6F7;
	Mon, 10 Nov 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xilix.ch header.i=@xilix.ch header.b="VDdL4CNb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52528466F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795578; cv=none; b=UJ9mHuk6SbaybcMZwckEzIR+o0e+RCSOoildyFm1vIJVd8Vu40DjPA92xn38APUE5Bx8NUf7qenafiD4crr/lg8MVNMNtGRgR0Oryh3Bj+UgVE2K8EfcZrdWj4mKUDED5c/f7f8Zfl7UQyrJ62rs9KJ8nWrCmYhEpeKy8nh3ikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795578; c=relaxed/simple;
	bh=iVi9MjT91s/2+8fbdbVe9SHhnMsE1mTsCW1q+tbrWuU=;
	h=Message-ID:Date:From:To:MIME-Version:Content-Type; b=lfl5CYBuThK4x7ank0zF/yxdfB1lkkpEKx8bkwLdyfKLWRd8/2cO+GX4Er4QoFyMyD2vCWb422DP/zD+H5drQwkwsA5NEAxf7dWOj+kTj3Ki3qbbkhf2z5oqQ1sbmYuPH3a2ZUrbKawMT0J1+6QjO6lD2ellvIt/R9TfJ42uNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xilix.ch; spf=pass smtp.mailfrom=xilix.ch; dkim=pass (2048-bit key) header.d=xilix.ch header.i=@xilix.ch header.b=VDdL4CNb; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xilix.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xilix.ch
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d4xQp2Zzwz4lq
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 18:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xilix.ch;
	s=20230710; t=1762795570;
	bh=iVi9MjT91s/2+8fbdbVe9SHhnMsE1mTsCW1q+tbrWuU=;
	h=Date:From:To:Reply-To:From;
	b=VDdL4CNbKhPqUZb5SjQY0vmJIg8HKG174D9AMb5y6MV4+CpFIPLCCWWqMe5mfaMig
	 8+I29Jw9IbN1ysKnhWfOucBQrqReIkaiBqTzAyHZi5iw+q/Qp+SIRjXkdz4mQ4Z2Wy
	 lmU+6oeSP4du3EQBsTuc+yfwYIlLlTfYzETFlHKpQfwGpnZ5FGEaDfdzkt5PH2QJQL
	 BcgcMF2hHeHKLkNN/6nIa7fPkaOI2I7KkHvLsq33xKAvsrW7VONpCmisnOxsD9qhQo
	 i4FtfDN0NJtps8nvbxJtXvOZcO9AKvAnp+hB7KBBGRAtxz7IkrjSzrmIOSGO1PKn3S
	 D07r8yzDQMIlQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4d4xQn6Rb0zhRV
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 18:26:09 +0100 (CET)
Message-ID: <d4cf5341-75e4-4788-bc98-4be4c4c1f0af@mail.infomaniak.com>
Date: Mon, 10 Nov 2025 18:26:09 +0100
From: Dominique Schaefer <dschaefer2025@xilix.ch>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: Dominique Schaefer <dschaefer2025@xilix.ch>
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.1076)
X-WS-User-Origin: eyJpdiI6ImhxSFFrUjNwUHZ6d0tLUmhEUmZERVE9PSIsInZhbHVlIjoiU2EweXhYblhSUGlUdVJrZnFGbm9kdz09IiwibWFjIjoiYmNiZDYyM2FmNDhkNWI0MDc1MDk2NjM3MTI3OTE5OTlmNzBkNjc2ZGE0ZjEyMmMwNWVjYWMwNTlkNmQ1OTY0YiIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6InlVdUtGTml2S09pSG1hTEhOcEVYZWc9PSIsInZhbHVlIjoiNm9JNjVuTmZWMU5IQXB2a3hNMmxhZz09IiwibWFjIjoiNTVjOGMzYzc2OWQ0MzU1OGU5NTIyMjA1MTMwYzhmNGEzZTg0OGMxZWI4YTdhMWM4MGNhOTk5NjNhNDI2ZWY5MiIsInRhZyI6IiJ9
X-WS-LOCALE: en_GB
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Infomaniak-Routing: alpha

Hi,

Here additional Info about my setup.

[root@cachyos ~]# uname -a=20
Linux cachyos 6.17.7-3-cachyos #1 SMP PREEMPT_DYNAMIC Tue, 04 Nov 2025 16:3=
9:03 +0000 x86_64 GNU/Linux

[root@cachyos ~]# journalctl -b -0 -k | grep -i -e mt76 -e mt7925 -e nl8021=
1=20
Nov 10 06:00:57 cachyos kernel: mt7925e 0000:03:00.0: ASIC revision: 792500=
00=20
Nov 10 06:00:57 cachyos kernel: mt7925e 0000:03:00.0: HW/SW Version: 0x8a10=
8a10, Build Time: 20250825215832a=20
Nov 10 06:00:58 cachyos kernel: mt7925e 0000:03:00.0: WM Firmware Version: =
____000000, Build Time: 20250825215925=20
Nov 10 06:01:40 cachyos kernel: warning: `kdeconnectd' uses wireless extens=
ions which will stop working for Wi-Fi 7 hardware; use nl80211

[root@cachyos ~]# lspci -nnk -s 03:00.0=20
03:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7925]=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Subsystem: Lenovo Device [17aa:e=
0ff]=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Kernel driver in use: mt7925e=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Kernel modules: mt7925e

Thanks,

Dominique,

---------------------------------------------------------
Dominique Schaefer
Wabersackerstrasse 78
3097 Liebefeld
Mobile : +41 79 839 19 86
Home : +41 31 971 19 86
dschaefer2025@xilix.ch

