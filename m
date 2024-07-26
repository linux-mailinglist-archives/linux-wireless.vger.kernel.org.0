Return-Path: <linux-wireless+bounces-10543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDDE93CCFB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 05:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3862AB20805
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD580210EC;
	Fri, 26 Jul 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jml3XhKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76944D299;
	Fri, 26 Jul 2024 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964451; cv=none; b=qLafVAeCoMar7urUuP0ZcNkqhS9fR/fUpz25hcn6DQhfCu99x0dUOzG90sSQ605vO7et2jZliE59090hEwwe+0Ot6cUvl3tITNCpCjCR72ycXzPBhveo5V8mKzx3M1f8QSFU7uiy92QglJ5QiL4z9SNPD89Z6r+QItByLIPZ7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964451; c=relaxed/simple;
	bh=87lvqZGx1ddg3kiAFcaM/B4GCaBLdsnwkTGBUe8+qaY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DW00Zpafkq3l1bzKJfB30DHwrrsA1F/MNtt2K5nAKUlLspk22so0CD+evyTsMtNjtqkxukcR3JwX7ilw7xFW8xkOrZg5vAeuDEBYwcTe5mi74Le7sK54rAGwKeBetSmqT0/S1ZFkbLpmkajGDSURSK/Y/tKuqYzVnayZ53Gk+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jml3XhKW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46Q3QlNW2031537, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721964407; bh=87lvqZGx1ddg3kiAFcaM/B4GCaBLdsnwkTGBUe8+qaY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jml3XhKWAxs+f7QgxoJpbe3EWUCuUsDocEmkds8tgi24m4XlZ8Rt8A9RUREyMcmiC
	 GMLsUGmOfruh5UJZPXXY88uD3iGlxdhVRVLoGuUv5l7WtUzoA8X5XcM70RTShuuEI6
	 XNL07urq/rRMpiMU0OV+loUIoqVM3wyQ58EfvuK+hjjviFpUJ2iWuKamlhUzBHmzM6
	 DLAsuFZeQPEbkemcOAfvTd0WyJRwTNOGj6X1MPtCarLCJdGaJ4zO1SWkTW3WX6LekA
	 itqp5xb/SLHJ+7Y0P7vcAjnw8F+fRG124+NuOqBRZsOw24TMxI16lM6Lyzs0LW50Wm
	 XTu+28VA0Fajg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46Q3QlNW2031537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 11:26:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 11:26:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jul 2024 11:26:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Jul 2024 11:26:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>,
        "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
Thread-Topic: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
Thread-Index: AQHa3CIb46s02EiOlEu+9T1Wemoj4rIIXHzg
Date: Fri, 26 Jul 2024 03:26:47 +0000
Message-ID: <c06f8308cc84412a93b81418aaa32fa8@realtek.com>
References: <000000000000fdef8706191a3f7b@google.com>
 <00000000000011de5f061dd387f0@google.com>
In-Reply-To: <00000000000011de5f061dd387f0@google.com>
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

PHN5emJvdCs4ZGQ5OGE5ZTk4ZWUyOGRjNDg0YUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tPiB3
cm90ZToNCj4gc3l6Ym90IGhhcyBiaXNlY3RlZCB0aGlzIGlzc3VlIHRvOg0KPiANCj4gY29tbWl0
IDlkZjY2ZDViOWY0NWMzOWIzOTI1ZDE2ZTg5NDdjYzEwMDA5YjE4NmQNCj4gQXV0aG9yOiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gRGF0ZTogICBXZWQgSnVuIDkgMDc6NTk6
NDQgMjAyMSArMDAwMA0KPiANCj4gICAgIGNmZzgwMjExOiBmaXggZGVmYXVsdCBIRSB0eCBiaXRy
YXRlIG1hc2sgaW4gMkcgYmFuZA0KPiANCj4gYmlzZWN0aW9uIGxvZzogIGh0dHBzOi8vc3l6a2Fs
bGVyLmFwcHNwb3QuY29tL3gvYmlzZWN0LnR4dD94PTEzZTIzM2ZkOTgwMDAwDQo+IHN0YXJ0IGNv
bW1pdDogICA1MTgzNTk0OWRkYTMgTWVyZ2UgdGFnICduZXQtbmV4dC02LjExJyBvZiBnaXQ6Ly9n
aXQua2VybmVsLi4NCj4gZ2l0IHRyZWU6ICAgICAgIG5ldC1uZXh0DQo+IGZpbmFsIG9vcHM6ICAg
ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcG9ydC50eHQ/eD0xMDEyMzNmZDk4
MDAwMA0KPiBjb25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9s
b2cudHh0P3g9MTdlMjMzZmQ5ODAwMDANCj4ga2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2Fs
bGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PWQzYmRkMDllYTIzNzFjODkNCj4gZGFzaGJvYXJk
IGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD04ZGQ5OGE5ZTk4
ZWUyOGRjNDg0YQ0KPiBzeXogcmVwcm86ICAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20veC9yZXByby5zeXo/eD0xNDYwODc0OTk4MDAwMA0KPiBDIHJlcHJvZHVjZXI6ICAgaHR0cHM6
Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5jP3g9MTc4YjkxOTU5ODAwMDANCj4gDQo+
IFJlcG9ydGVkLWJ5OiBzeXpib3QrOGRkOThhOWU5OGVlMjhkYzQ4NGFAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbQ0KPiBGaXhlczogOWRmNjZkNWI5ZjQ1ICgiY2ZnODAyMTE6IGZpeCBkZWZhdWx0
IEhFIHR4IGJpdHJhdGUgbWFzayBpbiAyRyBiYW5kIikNCj4gDQo+IEZvciBpbmZvcm1hdGlvbiBh
Ym91dCBiaXNlY3Rpb24gcHJvY2VzcyBzZWU6IGh0dHBzOi8vZ29vLmdsL3Rwc21FSiNiaXNlY3Rp
b24NCg0KSSBzZW50IGEgcGF0Y2ggWzFdIHRvIGF2b2lkIHRoZSB3YXJuaW5nIG9mDQoNCiAgIG5v
IHN1cHBvcnRlZCByYXRlcyBmb3Igc3RhIChudWxsKSAoMHhmZmZmZmZmZiwgYmFuZCAwKSBpbiBy
YXRlX21hc2sgMHgwIHdpdGggZmxhZ3MgMHgwDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC13aXJlbGVzcy8yMDI0MDcyNjAzMTUyMC43NjE2LTEtcGtzaGloQHJlYWx0ZWsuY29t
L1QvI3UNCg0K

