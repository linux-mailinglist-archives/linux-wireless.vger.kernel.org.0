Return-Path: <linux-wireless+bounces-19121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327BA3B18E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 07:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE2917005D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5717BB21;
	Wed, 19 Feb 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WQNv9HkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574071BBBDD
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946059; cv=none; b=d3h/kWhND2bG95IeUbQsFVS1WTJ3BJgx6S0GLzIyCvSGuyij5QKC11s5ytmTPoBAb1VhkMr5N0PAUtpdvjthKI8jot+VZk/VWKZxyvI0NXN6ASAOyLuTTtssFujv6hBZZP+WVqE4WHu8GeQmfvUSjXi51dhtHpyhuPpIBl64S80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946059; c=relaxed/simple;
	bh=vFXNC/pDl6h9A/JPzeOyrZkjEiKghtBr6D2Tt9Ifd4Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRVOktwRt5UlsssqQhu/GOJiCRrP1vlmiGbGPz/ufJwO9/7BzN5QHnjz780/UR9x3ZH9tzUoU/bklebFJgxutClfxHimo82lfXNJKKIs6IOPYg3s36gVKF72EQw4Cg6hPp0gy8MWR2nexB4hok2vuM1MMoDW7nB2aEc35hFqQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WQNv9HkE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51J6KqtpE2920402, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739946052; bh=vFXNC/pDl6h9A/JPzeOyrZkjEiKghtBr6D2Tt9Ifd4Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WQNv9HkE6v9Ipv8La99xFatP6pnj4YTN4AcdmFrN2R0nPN1uZjTAGXzai27H7udZf
	 jX4VxETvzJZm97kkPIfKqegTVbBAzhqBKSQx29AUwNWVO2qTcq7Qj3kZsya+LB9h5P
	 sYHuxdeM5MmPKtqoVx81tvzd+tE9HJL/FSH2pZjmVZQS2ig97XzdI6JJz34oYeeb1m
	 APr9rtqvb4/hOpXEuH/5BDbTUqPBtAfp0vhxTqICjpdNQop+5G6uAiYauD3EYeYBxi
	 w5tY1uOMbA0oM0OG3qQfAHYWrc57/0d23Bdl7rWEB/wsiTsBsmllIvTWHnW8M/0WXM
	 ppu1BVBpHwTMw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51J6KqtpE2920402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:20:52 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 14:20:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Feb 2025 14:20:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Wed, 19 Feb 2025 14:20:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Thread-Topic: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Thread-Index: AQHbgk4F7yF1CrP6lkuUlCsBtIqcQLNOJM3g
Date: Wed, 19 Feb 2025 06:20:51 +0000
Message-ID: <1a11b3b765404ab0b64b0e0614e44ac9@realtek.com>
References: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
In-Reply-To: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
VFggcXVldWVzIHNob3VsZCBiZSB3b2tlbiB3aGVuIHRoZXJlIGFyZSBhdCBsZWFzdCA0IGF2YWls
YWJsZQ0KPiBlbnRyaWVzLCBub3Qgd2hlbiB0aGVyZSBhcmUgYXQgbW9zdCA0Lg0KPiANCj4gVGVz
dGVkIHdpdGggUlRMODgyMUFFLg0KPiANCj4gRml4ZXM6IGQwMzExMzE0ZDAwMiAoInJ0bHdpZmk6
IHJ0bDgxOTJlZTogRml4IGhhbmRsaW5nIG9mIG5ldyBzdHlsZSBkZXNjcmlwdG9ycyIpDQoNCkkg
YWdyZWUgeW91ciBjaGFuZ2UgbG9va3MgbW9yZSByZWFzb25hYmxlLiBEaWQgeW91IHJlYWxseSBt
ZWV0IHRoZSBjYXNlDQphbmQgdGhpcyBwYXRjaCBzb2x2ZXMgaXQ/DQoNCkJ5IHRoZSBjaGFuZ2Vz
IG9mIGQwMzExMzE0ZDAwMiwgSSBjYW4ndCByZWFsbHkgdW5kZXJzdGFuZCB3aHkgdGhlIGluaXRp
YWwNCnZlcnNpb24gYW5kIHRoZSBjb21taXQgZG8uIENvbnNpZGVyaW5nIHRoZSBjb21taXQgImZp
eCIgc29tZSBzaXR1YXRpb25zLA0KSSBkb24ndCBrbm93IGlmIHRoaXMgcGF0Y2ggd291bGQgYnJl
YWsgdGhlbSBhZ2Fpbi4gQ291bGQgeW91IGxvb2sgaW50bw0KcnRsd2lmaSBQQ0kgZmxvdyBkZWVw
ZXIgYW5kIHNoYXJlIHlvdXIgaWRlYXM/IA0KDQo=

