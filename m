Return-Path: <linux-wireless+bounces-16841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B09FDA27
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 12:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C71619E5
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB24D70801;
	Sat, 28 Dec 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b="lk8gAtHu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.vapourmail.eu (mail.vapourmail.eu [5.75.183.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406441C7F;
	Sat, 28 Dec 2024 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.183.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735385457; cv=none; b=t+TD4hI7zkk5prfHvbXifUugpRm0bTN3L9OcUfn+A2ciVzOFJWOuDaZ3IIMHw/0l+axehKKD2w5TTwnLq/EAlkdBBhc6ddR1GNlB8cdoUU5LwyWzhiHmocT3AGpAWoEOCvA/DcoxNfw+J2rYztJvNUuowvsdyNnjPzKoYb7k2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735385457; c=relaxed/simple;
	bh=MPnsZkEMIEgTUjya2LEgJESQrwnn0Ude09R3MVOIwLs=;
	h=MIME-Version:From:To:Cc:Subject:Message-ID:Date:Content-Type; b=eqbMq/V1jr5mgIIWsuOQjdq9BafZ2Lzm2wWUDQ/7NHK9sdwO8zD3UgkOPPNslbdoZ5q+vk040EVXnbYeUquhyrNPM1xYxovLhOptIeVSh74wPKfkhAbgI/7URT1Wj5WzbarD3epTJTKPt8ZctdsEPN9C3GYVy7pxM7OqWh3JJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=johnrowley.me; spf=pass smtp.mailfrom=johnrowley.me; dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b=lk8gAtHu; arc=none smtp.client-ip=5.75.183.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=johnrowley.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnrowley.me
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 864F4C38A1;
	Sat, 28 Dec 2024 11:21:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
	s=dkim; t=1735384888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jlYla/Bco2UqXlERzs8y9C8soBwyQ6mVQEUumxBUGxg=;
	b=lk8gAtHuwEORQp/vq/s6veYdG2Q7O70WoMXN8ExK/WFoek/04e7+CB8q7L3h8u/c2jpXwb
	2MEjHvvMTqbH7i1iE5pOdOn7Uv+HMK95ZNE2cXYX53rnx5CDt30ktozV+DMpGSAvsvngWz
	xodrNByppjWgjEteaZzLBV2dp1B3ssGT1idLxJ80FU4hAaU1XnWvUJ8qXT545/bpf43ZrI
	5heaWOMhmzWzYn1Egi7yOdI628cajvWCD5JFR0Bq1QY7I5JQl0GtFMzKVmP7Yb+OQUDIP/
	BJ/nqLQ7nytUhq+RWtHWKOY0baU6YkD1QsZFb5mspml4UgdbxWd+/czVvz5hGQ==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "John Rowley" <lkml@johnrowley.me>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Subject: UBSAN array-index-out-of-bounds: cfg80211_scan_6ghz
Message-ID: <1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain>
Date: Sat, 28 Dec 2024 11:21:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi, I'm experiencing UBSAN array-index-out-of-bounds errors while using
my Framework 13" AMD laptop with its Mediatek MT7922 wifi adapter
(mt7921e).

It seems to happen only once on boot, and occurs with both kernel
versions 6.12.7 and 6.13-rc4, both compiled from vanilla upstream kernel=20
sources on Fedora 41 using the kernel.org LLVM toolchain (19.1.6).

I can try some other kernel series if necessary, and also a bisect if I
find a working version, but that may take me a while.

I wasn't sure if I should mark this as a regression, as I'm not sure
which/if there is a working kernel version at this point.

Thanks.

----

[   17.754417] UBSAN: array-index-out-of-bounds in /data/linux/net/wireless/=
scan.c:766:2
[   17.754423] index 0 is out of range for type 'struct ieee80211_channel *[=
] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')
[   17.754427] CPU: 13 UID: 0 PID: 620 Comm: kworker/u64:10 Tainted: G      =
          T  6.13.0-rc4 #9
[   17.754433] Tainted: [T]=3DRANDSTRUCT
[   17.754435] Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRA=
NMDCP07, BIOS 03.05 03/29/2024
[   17.754438] Workqueue: events_unbound cfg80211_wiphy_work
[   17.754446] Call Trace:
[   17.754449]  <TASK>
[   17.754452]  dump_stack_lvl+0x82/0xc0
[   17.754459]  __ubsan_handle_out_of_bounds+0xe7/0x110
[   17.754464]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.754470]  ? __kmalloc_noprof+0x1a7/0x280
[   17.754477]  cfg80211_scan_6ghz+0x3bb/0xfd0
[   17.754482]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.754486]  ? try_to_wake_up+0x368/0x4c0
[   17.754491]  ? try_to_wake_up+0x1a9/0x4c0
[   17.754496]  ___cfg80211_scan_done+0xa9/0x1e0
[   17.754500]  cfg80211_wiphy_work+0xb7/0xe0
[   17.754504]  process_scheduled_works+0x205/0x3a0
[   17.754509]  worker_thread+0x24a/0x300
[   17.754514]  ? __cfi_worker_thread+0x10/0x10
[   17.754519]  kthread+0x158/0x180
[   17.754524]  ? __cfi_kthread+0x10/0x10
[   17.754528]  ret_from_fork+0x40/0x50
[   17.754534]  ? __cfi_kthread+0x10/0x10
[   17.754538]  ret_from_fork_asm+0x11/0x30
[   17.754544]  </TASK>


