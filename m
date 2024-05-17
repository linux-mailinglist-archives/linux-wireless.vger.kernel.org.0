Return-Path: <linux-wireless+bounces-7760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF58C8018
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D4CB218AD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C069454;
	Fri, 17 May 2024 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b="dTT3lYyZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from argon.superhosting.bg (argon.superhosting.bg [91.196.125.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB689441
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.196.125.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715915025; cv=none; b=Mbuk6SJ4Ig+Tf65iEtiwLr3zEW2PtTqsfiPwYvozTKWV8vjVGNYZU8Ht6UHdntlyjJrlPria09KhS/SvsLwqx0JWV0bAb0TixTLiWPJP91qfy9kzxO34oV+YrE+5KWj+PtZS5DiylhZnlwKH1aJ+LbNw3OHx6j4HYmAvomEsx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715915025; c=relaxed/simple;
	bh=nEOWZxqcmhW5FSJ2LiIKX+GneVAOgnwtV62O+iizoQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bD5ROJdlYuGoasL7xhxMzVa2Omv/LVRarJKF4saJYlBto8JebIO38zDcTbAXAqv2lHKvctPMi9ML/IuxAdp/xZqiK9gLIVAayXEs2ehOdKYhrgQq/jWdx09C16biQ00tlDzDPcH7gGW2jlI2Dl/3h/+YxyoLHSc+C2OYbcN0Ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com; spf=pass smtp.mailfrom=pevogam.com; dkim=pass (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b=dTT3lYyZ; arc=none smtp.client-ip=91.196.125.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pevogam.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pevogam.com
	; s=default; h=Content-Type:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nEOWZxqcmhW5FSJ2LiIKX+GneVAOgnwtV62O+iizoQk=; b=dTT3lYyZdTKLENu5WpW6r6zLac
	Yoga0yWAJ9d8jWVSrfnY0kSG3yvpmC6Qhb0M+qFNCVzfyLiu+ulTK8tIXmaJ3JQfxfaWyAB+z7/kA
	uu+zGAtaqei9kDgBwZqppYLg/+ivq/hc82y8juMHsXhMSYZHKU16Exkbcj6zw7Ijf6q80jFbPPhdu
	AU7xUKf/HavDFHKSlAuZgdXAa8PqIhDFYLQez3HyO2UDG1h56yP7xeyWL4KyupjrtDYCs7KfJ3DVm
	dVFGQ+yioYONlnZaSYWAVRwKlpzII8OC+j5LOg3BuYoqvPbEKo19GB2Jv2Bt93p02BFGmIRdcA4bU
	hYAIwgcQ==;
Received: from [213.91.128.111] (port=58852 helo=mark.whitetree)
	by argon.superhosting.bg with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <plamen.dimitrov@pevogam.com>)
	id 1s7nsW-0007da-2u;
	Fri, 17 May 2024 06:03:31 +0300
Received: from localhost (mark.whitetree [127.0.0.1])
	by localhost (Postfix) with ESMTP id 12F901F47B;
	Fri, 17 May 2024 06:03:28 +0300 (EEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.70.2,VDF=8.20.25.110)
X-Spam-Level: 0
Received: from [192.168.40.1] (unknown [192.168.40.1])
	by mark.whitetree (Postfix) with ESMTP id 074741F477;
	Fri, 17 May 2024 06:03:21 +0300 (EEST)
Message-ID: <34010026-aa12-426d-ac8a-a61fdfefbdfd@pevogam.com>
Date: Fri, 17 May 2024 11:01:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
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
Content-Language: en-US
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
Autocrypt: addr=plamen.dimitrov@pevogam.com; keydata=
 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
 dv5WNw==
Disposition-Notification-To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
In-Reply-To: <1be6ea15441542719b573cdad1ccf008@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jEQIHsSZvIaNd81gMRhWN7Vk"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - argon.superhosting.bg
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - pevogam.com
X-Get-Message-Sender-Via: argon.superhosting.bg: authenticated_id: plamen.dimitrov@pevogam.com
X-Authenticated-Sender: argon.superhosting.bg: plamen.dimitrov@pevogam.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jEQIHsSZvIaNd81gMRhWN7Vk
Content-Type: multipart/mixed; boundary="------------6lLq0roNVjdWtwT9dSx1OI4U";
 protected-headers="v1"
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <34010026-aa12-426d-ac8a-a61fdfefbdfd@pevogam.com>
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
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
In-Reply-To: <1be6ea15441542719b573cdad1ccf008@realtek.com>

--------------6lLq0roNVjdWtwT9dSx1OI4U
Content-Type: multipart/mixed; boundary="------------7Q28rlMCc0F2j0FJf5MmsIZq"

--------------7Q28rlMCc0F2j0FJf5MmsIZq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8xNS8yNCAxMTo0NyBBTSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPj4gQW55IGlkZWEg
d2hhdCBjb3VsZCBnbyB3cm9uZyBoZXJlPyBJIGhhdmUgdHJpZWQgZGlzYWJsaW5nIHZpYSBh
bGwgYmVmb3JlLW1lbnRpb25lZCBtZXRob2RzIGFuZCB0aGUgbmV0d29yaw0KPj4gY2FyZCBj
cmFzaGVzIG9uIGJvdGggb2xkZXINCj4+IGFuZCBuZXdlciBrZXJuZWxzIGRlc3BpdGUgYWxs
IG15IGVmZm9ydHMuDQo+IFdoYXQgaXMgdGhlIGtlcm5lbCB2ZXJzaW9uIG9mIHRoZSBuZXdl
c3QgRmVkb3JhPyBJIGNhbiB0cnkgaXQgaW4gbXkgc2lkZS4NCg0KNi44LjktMzAwLmZjNDAu
eDg2XzY0DQoNCj4gSXQgbG9va3MgbGlrZSBmaXJtd2FyZSBlbnRlcnMgYWJub3JtYWwgc3Rh
dGUsIHNvIG15IHN1Z2dlc3Rpb24gaXMgdG8gZGlzYWJsZQ0KPiBhbGwgcG93ZXIgc2F2ZSBm
dW5jdGlvbnMgdG8gY2xhcmlmeSB0aGUgcHJvYmxlbXMsIGJ1dCBpdCBzZWVtcyBsaWtlIHlv
dQ0KPiBoYXZlIGRvbmUgYWxsIG9mIHRoZW0uDQo+IA0KPiBJcyBpdCBwb3NzaWJsZSB0byBy
ZW1vdmUgbW9kdWxlcyBmcm9tL2xpYi9tb2R1bGVzLyAgPyBUaGVuIGluc21vZCBtYW51YWxs
eQ0KPiB3aXRoIG1vZHVsZSBwYXJhbWV0ZXJzIHRvIGRpc2FibGUgcG93ZXIgc2F2ZSBmdW5j
dGlvbnMgb25lLWJ5LW9uZT8NCg0KTm90IHN1cmUsIHdoaWNoIG1vZHVsZXMgaW4gcGFydGlj
dWxhciBhcmUgeW91IHJlZmVycmluZyB0byBzbyBJIGNhbiBpc29sYXRlIHRoaXMgZnVydGhl
cjoNCg0KJCBsbCAvbGliL21vZHVsZXMvJCh1bmFtZSAtcikva2VybmVsL25ldA0KdG90YWwg
MjAwDQpkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSA2bG93cGFu
DQpkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSA4MDINCmRyd3hy
LXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IDgwMjFxDQpkcnd4ci14ci14
LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSA5cA0KZHJ3eHIteHIteC4gMiByb290
IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDcgYXBwbGV0YWxrDQpkcnd4ci14ci14LiAyIHJvb3Qg
cm9vdCA0MDk2IE1heSAxMyAxNTowNyBhdG0NCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQw
OTYgTWF5IDEzIDE1OjA3IGF4MjUNCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5
IDEzIDE1OjA3IGJhdG1hbi1hZHYNCmRyd3hyLXhyLXguIDUgcm9vdCByb290IDQwOTYgTWF5
IDEzIDE1OjA1IGJsdWV0b290aA0KZHJ3eHIteHIteC4gMyByb290IHJvb3QgNDA5NiBNYXkg
MTMgMTU6MDUgYnJpZGdlDQpkcnd4ci14ci14LiAzIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAx
NTowNSBjYW4NCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IGNl
cGgNCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IGNvcmUNCmRy
d3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IGRuc19yZXNvbHZlcg0K
ZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgZHNhDQpkcnd4ci14
ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAgMiAwODowMCBoYW5kc2hha2UNCmRyd3hyLXhy
LXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IGhzcg0KZHJ3eHIteHIteC4gMyBy
b290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgaWVlZTgwMjE1NA0KZHJ3eHIteHIteC4gMiBy
b290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgaWZlDQpkcnd4ci14ci14LiAzIHJvb3Qgcm9v
dCA0MDk2IE1heSAxMyAxNTowNyBpcHY0DQpkcnd4ci14ci14LiA0IHJvb3Qgcm9vdCA0MDk2
IE1heSAxMyAxNTowNSBpcHY2DQpkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAx
MyAxNTowNSBrY20NCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1
IGtleQ0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDcgbDJ0cA0K
ZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgbGxjDQpkcnd4ci14
ci14LiAzIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSBtYWM4MDIxMQ0KZHJ3eHIteHIt
eC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgbWFjODAyMTU0DQpkcnd4ci14ci14
LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSBtcGxzDQpkcnd4ci14ci14LiAyIHJv
b3Qgcm9vdCA0MDk2IE1heSAgMiAwODowMCBtcHRjcA0KZHJ3eHIteHIteC4gNCByb290IHJv
b3QgNDA5NiBNYXkgMTMgMTU6MDUgbmV0ZmlsdGVyDQpkcnd4ci14ci14LiAyIHJvb3Qgcm9v
dCA0MDk2IE1heSAxMyAxNTowNyBuZXRyb20NCmRyd3hyLXhyLXguIDQgcm9vdCByb290IDQw
OTYgTWF5IDEzIDE1OjA1IG5mYw0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkg
MTMgMTU6MDUgbnNoDQpkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTow
NSBvcGVudnN3aXRjaA0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6
MDUgcHNhbXBsZQ0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUg
cXJ0cg0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDcgcmRzDQpk
cnd4ci14ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSByZmtpbGwNCmRyd3hy
LXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA3IHJvc2UNCmRyd3hyLXhyLXgu
IDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IHJ4cnBjDQpkcnd4ci14ci14LiAyIHJv
b3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNyBzY2hlZA0KZHJ3eHIteHIteC4gMiByb290IHJv
b3QgNDA5NiBNYXkgMTMgMTU6MDUgc2N0cA0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5
NiBNYXkgMTMgMTU6MDUgc21jDQpkcnd4ci14ci14LiA0IHJvb3Qgcm9vdCA0MDk2IE1heSAx
MyAxNTowNSBzdW5ycGMNCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1
OjA1IHRpcGMNCmRyd3hyLXhyLXguIDIgcm9vdCByb290IDQwOTYgTWF5IDEzIDE1OjA1IHRs
cw0KZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgdm13X3Zzb2Nr
DQpkcnd4ci14ci14LiAzIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSB3aXJlbGVzcw0K
ZHJ3eHIteHIteC4gMiByb290IHJvb3QgNDA5NiBNYXkgMTMgMTU6MDUgeGRwDQpkcnd4ci14
ci14LiAyIHJvb3Qgcm9vdCA0MDk2IE1heSAxMyAxNTowNSB4ZnJtDQoNCk9uIDUvMTUvMjQg
MTo0MCBQTSwgS2FsbGUgVmFsbyB3cm90ZToNCiA+PiBJcyBpdCBwb3NzaWJsZSB0byByZW1v
dmUgbW9kdWxlcyBmcm9tL2xpYi9tb2R1bGVzLyAgPyBUaGVuIGluc21vZCBtYW51YWxseQ0K
ID4+IHdpdGggbW9kdWxlIHBhcmFtZXRlcnMgdG8gZGlzYWJsZSBwb3dlciBzYXZlIGZ1bmN0
aW9ucyBvbmUtYnktb25lPw0KID4gQlRXIGl0IHNob3VsZCBiZSBhbHNvIHBvc3NpYmxlIHRv
IGJsYWNrbGlzdCBtb2R1bGVzIHRvIGF2b2lkIHRoZW0gYmVpbmcNCiA+IGxvYWRlZCBhdXRv
bWF0aWNhbGx5LiBBdCBsZWFzdCBpbiBEZWJpYW4gSSBkbyB0aGlzOg0KID4NCiA+ICQgY2F0
IC9ldGMvbW9kcHJvYmUuZC9rdmFsby5jb25mDQogPiBibGFja2xpc3QgYXRoMTFrX3BjaQ0K
DQpJbmRlZWQsIEkgZ3Vlc3MgbWF5YmUgb25lIHdheSB0byByZW1vdmUgbW9kdWxlcyBvbiBy
ZWJvb3QsIHRoYW5rcyBmb3IgdGhlIGhpbnRzIQ0KDQpSZWdhcmRzLA0KUGxhbWVuDQoNCg==

--------------7Q28rlMCc0F2j0FJf5MmsIZq
Content-Type: application/pgp-keys; name="OpenPGP_0xA4696276CE5A052D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA4696276CE5A052D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
E7mQtLry8AiDLf8hdv5WNw=3D=3D
=3Dvn6v
-----END PGP PUBLIC KEY BLOCK-----

--------------7Q28rlMCc0F2j0FJf5MmsIZq--

--------------6lLq0roNVjdWtwT9dSx1OI4U--

--------------jEQIHsSZvIaNd81gMRhWN7Vk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+tW4fXzXuCI2oFHbpGlids5aBS0FAmZGyKAFAwAAAAAACgkQpGlids5aBS0c
ew//ZNj5r4ShsXAmdhIVv1On6HYXOLqFVA7wKtU+UTgGi+m2ZLDPM/sW/kKmod45mPtmW1YSCI67
ESI2MfIJrjlVuzhvuJFsy/OsxMZXfeS3/OLdSrXP3iuQ+quu5P4DhRxKNSX8iUk8rBeE+gj/b2Oq
T9Vz/AP0VTfGh7NqMT1EXhsvNdSz2qC1wSS1uiwnA6vHly138lgXlUUGf7jZdt7JdHs2N7QQdH0F
5togq7avaL9wJYVP1JKLszcf3eOjJEi2Hpx+e30FTmvv7KU6oIhFvATkYFIHwE21pGCYSyKv87s8
gaInXzz3uVWtV+PKulNzdD0Y8rtObQgyeWhSKO0hiuYC4UY6KEgaRUmezZqoF9ynXA5gelQu5G8d
2odTY7IHqJ/Cfg2Pio7W5OtLxsYFgyHnbhAY9qDks32a+aEPhpCMD/JQE5kmfpaGwVmwWWtbbHlC
Z3JjsqX14+xLISN47TdlHzp7zUeB/L6Ryqwzv/Kw8F1gyJGNIi1yangkRWJM1v4VY91wVZqQeuPe
rT1eEuRvRsRbllZHR4egyKdtFrW5PE9zduBorT4Xxy1Zo/rk66iBjkyyjZlS/FrZ0ddWRl/P25ld
7uTXo8MApLcox533Np+hXq8aAECfsOvGkBePNoYpiwzKpdH0sEl5JOdhvxiWOxn6vHGGeJz0NNEX
/Rc=
=F3R2
-----END PGP SIGNATURE-----

--------------jEQIHsSZvIaNd81gMRhWN7Vk--

