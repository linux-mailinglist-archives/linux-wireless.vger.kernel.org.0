Return-Path: <linux-wireless+bounces-12227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3D9655B6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 05:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314E71F23CFB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08B54278;
	Fri, 30 Aug 2024 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ofdzGRxz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230B36B0D
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989041; cv=none; b=pmfy7WyKwL1hJcXYRO7IjFkR0ukAjwm4Y4ks3iWuIz9m17mHT4qBJJzKHr9L2yUxegJzv49ZSj4fi8EAeNtRiXevVpsqaRqn/3HLNdHkBXpclAATUgGvh7HCGBLu/tMc7oarFDEjOeWpDqHSP6EWJVQ+xvCPkptQvpyycAwHGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989041; c=relaxed/simple;
	bh=vZxbwwKWmCi4ArlEP1ILaQyNPO6rMZDhQBpMrJZ+kg4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTbN76TUqtVvQJltUlT3Ks0KZZ5crTYOEY44jbeqCGEjIQurQ1QyfGHxmKWYlVbA0mM7T6b9CkNn0R5hHf5HaicNU0sm1ou9V0GLEX511H56j5gLh3TaVcvQQGHtQ4/YpcfM1MhRG2p1H2zh4n00LpGxM+DO7l2brMNZpMGKOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ofdzGRxz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47U3bDUa9243715, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724989033; bh=vZxbwwKWmCi4ArlEP1ILaQyNPO6rMZDhQBpMrJZ+kg4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ofdzGRxzgxKND2u8OAf26Svxd1EdfaqR2BwIb87Ei2L85jOJMMg9pUKViyAda/JS7
	 v/aBV7v5ZWvfw4qdPwwn2YjRMv+/GuhcPh5gluLxVk4EyYUC4+ZFrinzPs7B2F4pNv
	 QOtbkOnnboPt+nxN/pXwlYcwP+OI6uEDzpQndWIC9C72blpprLyiCibUcGSwoWAf0b
	 TW6TK1Pwqzkoq4G1e0OVF8OmK3kmqiQQR/2TJVGvmnjCHHoJk7UYGmcpeA9ExYY/fP
	 P0Mgo8llljBgIagoI8//+WLv3+q2MVwPCMLWCU7XTAsk08DftgHkZ71VtGsfRygciT
	 wOAlkWJJZctdA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47U3bDUa9243715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 11:37:13 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 11:37:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 30 Aug 2024 11:37:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 30 Aug 2024 11:37:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linasvepstas@gmail.com" <linasvepstas@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw88_8821ce (sometimes) fails to wake from sleep
Thread-Topic: rtw88_8821ce (sometimes) fails to wake from sleep
Thread-Index: AQHa+nN/2z5lHL5D/kKC5QjRu7LszrI/H7Hw
Date: Fri, 30 Aug 2024 03:37:13 +0000
Message-ID: <e67b169cd27445fdbeb627c5ab6165d1@realtek.com>
References: <CAHrUA36mW-M-5jaqnFguM+3_kc9Uki1b++v4nQOeQ11iba84yQ@mail.gmail.com>
In-Reply-To: <CAHrUA36mW-M-5jaqnFguM+3_kc9Uki1b++v4nQOeQ11iba84yQ@mail.gmail.com>
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

TGluYXMgVmVwc3RhcyA8bGluYXN2ZXBzdGFzQGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gWyAgMzY0
LjAwMTU3OV0gcnR3Xzg4MjFjZSAwMDAwOjAxOjAwLjA6IFVuYWJsZSB0byBjaGFuZ2UgcG93ZXIg
c3RhdGUNCj4gZnJvbSBEM2hvdCB0byBEMCwgZGV2aWNlIGluYWNjZXNzaWJsZQ0KDQpCeSB0aGUg
Y2x1ZSwgSSBzdWdnZXN0IHRvIHR1cm4gb2ZmIGFzcG0gYnk6DQoNCkFkZCBhIGNvbmZpZ3VyYXRp
b24gZmlsZSBhdDogL2V0Yy9tb2Rwcm9iZS5kLzcwLXJ0dzg4LmNvbmYNCndpdGggY29udGVudDoN
Cm9wdGlvbnMgcnR3ODhfcGNpIGRpc2FibGVfYXNwbT0xDQoNClBsZWFzZSBzaHV0ZG93biB5b3Vy
IHN5c3RlbSB0byBlbnN1cmUgcmVzZXR0aW5nIGhhcmR3YXJlIHN0YXRlcy4NCkFmdGVyIGJvb3Rp
bmcgdXAsIGRvaW5nICdjYXQgL3N5cy9tb2R1bGVzL3J0dzg4X3BjaS9wYXJhbWV0ZXJzL2Rpc2Fi
bGVfYXNwbScgdG8NCmVuc3VyZSB0aGF0IGFib3ZlIHNldHRpbmcgdGFrZXMgZWZmZWN0Lg0KDQoN
Cg==

