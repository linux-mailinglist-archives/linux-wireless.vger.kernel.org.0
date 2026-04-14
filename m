Return-Path: <linux-wireless+bounces-34733-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C33Kdni3WnrkgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34733-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:46:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3123F638F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C9D3045021
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D536DA02;
	Tue, 14 Apr 2026 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IUa6yE9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376A36E470;
	Tue, 14 Apr 2026 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148786; cv=none; b=dUyAuCNAaVBe3hSXp+Nt7h24TcnQLvVSN51BSg2+nAWTHOCDv3MQFAhZOzs1bXRqim+xYWjGz3cgG2dPc23+xPRfEXM/ye5JVPMO+a+JqEtcjDissLMej37Ucssa8dsponcw8VKFbeBo2EF09dbQJ20p1wb/F1SYq63GpbUMlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148786; c=relaxed/simple;
	bh=EK7YcE/UJiRyiKcXayNfpBQ2HHqWE1vqxyXV6iQLqo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NwxPv7VeYEDugcbgpREUuOaPcwGO2hItgrtteg0128xl2ExUDY7MTwDb/JyIsshEU7u9Cx8ADtVOb0hPEZCaFfJo7znJYK2jaVVLsTw4sfWYOrTadplDeaGL4/MNIUS1s6UndlbOJwhUeFsJi6ZQe9KNjqlMV24FmDrDHwLvI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IUa6yE9s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E6ddVK31527856, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776148780; bh=EK7YcE/UJiRyiKcXayNfpBQ2HHqWE1vqxyXV6iQLqo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IUa6yE9sFNjKP+zrciic4951ZPNGnPKiNQbGePWCvKeCNX6bUA3DhMlpMy272Vrq/
	 qebI19reuJrGmSuvGq0/FPxmwBTG5hESqITNUKzWHFArgxu5/xcylWg1HVjYmteWXM
	 0ZwoFfKVEqnz0o2VHbTU6gJNcy9Xwmr8i1rmegyNbEleu0p4RDmzh4WQgjaHS9IKh2
	 YK2Hx0mv1JgtST5ajpyQB88NOXptar3e1N30L6iVMAXcm5jS9KF9yxBb1tjWoTX0tp
	 i3drhWfOCQf69l14ieqla3jXd4Y982wxvmhlmsXdBquJ2N7ZljulLSOnAKMhmofh/N
	 jkOE22mlungEg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E6ddVK31527856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:39:40 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 14:39:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 14:39:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 14:39:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Louis Kotze <loukot@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw89: phy: make RF calibration timeouts
 non-fatal on USB
Thread-Topic: [PATCH 2/2] wifi: rtw89: phy: make RF calibration timeouts
 non-fatal on USB
Thread-Index: AQHcyMAhG1LiiAN970ee8IFvSS24r7XeIEYA
Date: Tue, 14 Apr 2026 06:39:39 +0000
Message-ID: <9f43a228419b44b1a55ee3d8c31abcbd@realtek.com>
References: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
 <20260410080017.82946-1-loukot@gmail.com>
 <20260410080017.82946-3-loukot@gmail.com>
In-Reply-To: <20260410080017.82946-3-loukot@gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34733-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0B3123F638F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TG91aXMgS290emUgPGxvdWtvdEBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiBVU0IgYWRhcHRlcnMs
IFJGIGNhbGlicmF0aW9uIHRpbWVvdXRzIGNhbiBzdGlsbCBvY2Nhc2lvbmFsbHkgb2NjdXINCj4g
ZGVzcGl0ZSB0aGUgaW5jcmVhc2VkIHRpbWVvdXQgdmFsdWVzLCBwYXJ0aWN1bGFybHkgdW5kZXIg
c3lzdGVtIGxvYWQNCj4gb3IgVVNCIGJ1cyBjb250ZW50aW9uLiBIb3dldmVyLCB0aGUgcmFkaW8g
dHlwaWNhbGx5IGNvbnRpbnVlcyB0bw0KPiBvcGVyYXRlIGNvcnJlY3RseSBkZXNwaXRlIGFuIGlu
Y29tcGxldGUgY2FsaWJyYXRpb24g4oCUIHRoZSB0aW1lb3V0DQo+IGRvZXMgbm90IGluZGljYXRl
IGEgaGFyZHdhcmUgZmFpbHVyZS4NCj4gDQo+IE1ha2UgY2FsaWJyYXRpb24gdGltZW91dHMgYW5k
IGJhZCBzdGF0ZSByZXR1cm5zIG5vbi1mYXRhbCBvbiBVU0IgYnkNCj4gbG9nZ2luZyBhdCBkZWJ1
ZyBsZXZlbCBhbmQgY29udGludWluZywgcmF0aGVyIHRoYW4gDQoNCklmIGNhbGlicmF0aW9uIHRp
bWVvdXRzLCB0aGUgcGVyZm9ybWFuY2UgbWlnaHQgYmUgYmFkLiBIb3cgYWJvdXQganVzdA0KdG8g
ZW5sYXJnZSB0aW1lb3V0IHRpbWUgaW4gMS8yIHBhdGNoPw0KDQo+IHJldHVybmluZw0KPiAtRVRJ
TUVET1VULy1FRkFVTFQgd2hpY2ggY2FuIGNhc2NhZGUgaW50byBhIGNvbm5lY3Rpb24gZmFpbHVy
ZSBvcg0KPiBkaXNjb25uZWN0Lg0KDQpJdCBzZWVtcyBsaWtlIHdlIGRvbid0IGFjdHVhbGx5IGhh
bmRsZSB0aGUgcmV0dXJuIGNvZGUgZm9yIG5vdy4NCkNvdWxkIHlvdSBwb2ludCBvdXQgdGhlIHBh
dGggeW91IGVuY291bnRlcmVkPw0KDQo+IA0KPiBQQ0llIGVycm9yIGhhbmRsaW5nIGlzIHVuY2hh
bmdlZCDigJQgdGltZW91dHMgcmVtYWluIGZhdGFsIG9uIFBDSWUNCj4gd2hlcmUgdGhleSBpbmRp
Y2F0ZSBhIHJlYWwgcHJvYmxlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvdWlzIEtvdHplIDxs
b3Vrb3RAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvcGh5LmMgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OS9waHkuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGh5LmMN
Cj4gaW5kZXggNGQ4MDlkZjhiLi5hMDZiZWE4OGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGh5LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9waHkuYw0KPiBAQCAtMzk3Miw5ICszOTcyLDIxIEBAIGludCBydHc4
OV9waHlfcmZrX3JlcG9ydF93YWl0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgY29uc3QgY2hh
ciAqcmZrX25hbWUsDQo+ICAgICAgICAgdGltZV9sZWZ0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90
aW1lb3V0KCZ3YWl0LT5jb21wbGV0aW9uLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKG1zKSk7DQo+ICAgICAgICAgaWYg
KHRpbWVfbGVmdCA9PSAwKSB7DQo+ICsgICAgICAgICAgICAgICBpZiAocnR3ZGV2LT5oY2kudHlw
ZSA9PSBSVFc4OV9IQ0lfVFlQRV9VU0IpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcnR3
ODlfZGVidWcocnR3ZGV2LCBSVFc4OV9EQkdfUkZLLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiUkYgJXMgdGltZW91dCAobm9uLWZhdGFsIG9uIFVTQilcbiIsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJma19uYW1lKTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAg
ICAgICAgICBydHc4OV93YXJuKHJ0d2RldiwgImZhaWxlZCB0byB3YWl0IFJGICVzXG4iLCByZmtf
bmFtZSk7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVUSU1FRE9VVDsNCj4gICAgICAgICB9
IGVsc2UgaWYgKHdhaXQtPnN0YXRlICE9IFJUVzg5X1JGS19TVEFURV9PSykgew0KPiArICAgICAg
ICAgICAgICAgaWYgKHJ0d2Rldi0+aGNpLnR5cGUgPT0gUlRXODlfSENJX1RZUEVfVVNCKSB7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0dzg5X2RlYnVnKHJ0d2RldiwgUlRXODlfREJHX1JG
SywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlJGICVzIHN0YXRlICVk
IChub24tZmF0YWwgb24gVVNCKVxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmZrX25hbWUsIHdhaXQtPnN0YXRlKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z290byBvdXQ7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBydHc4OV93
YXJuKHJ0d2RldiwgImZhaWxlZCB0byBkbyBSRiAlcyByZXN1bHQgZnJvbSBzdGF0ZSAlZFxuIiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcmZrX25hbWUsIHdhaXQtPnN0YXRlKTsNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiAtLQ0KPiAyLjUzLjANCg0K

