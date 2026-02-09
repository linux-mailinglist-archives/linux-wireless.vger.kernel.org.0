Return-Path: <linux-wireless+bounces-31656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCw6HsqUiWlj/AQAu9opvQ
	(envelope-from <linux-wireless+bounces-31656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:03:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB410CB68
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0145B301B937
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21B1FBEA6;
	Mon,  9 Feb 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jVt/X9QJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F9301701
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624099; cv=none; b=U+kSmyrUEy9TfvKTfRyEkA+TyjXXgxFe2wK1r0BQaKEdfuG7mWEJqKDfrAAYmCQ+qfUjZLkIndiDgwQYnXDeFQTNeT7WbGGljaU0lROKA2WPnGu9HffJV2dvbCIPehRBPspUifAT6oRL6F5YCkiUsvj93KodE9r9cZXirfiXfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624099; c=relaxed/simple;
	bh=XKEg8gUZbNBoZdV0rwvgxMEC9+lz2KVpnAwJJnZU0TY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=djDmwy+xM+/ow0FYG+ubVHGWofRzq2+vfmbkCtHVnrWNptFlWq6Bpc6ejK1f+wvNdVtzFvdnSi5a5PTcx1FBMRl9/q+pQyIi1PRgXmGfMQZTJaYHmVzAaUzeIP5VDRiccCnG98BBydhwICD6MxAWm50dc71tiET2IMHkl/HEkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jVt/X9QJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61981Z4Y01033141, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770624095; bh=XKEg8gUZbNBoZdV0rwvgxMEC9+lz2KVpnAwJJnZU0TY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jVt/X9QJgOiuQFS6P2CG+BzsEZEj/G0/hVBjgnE3hJKPdTQ7Sj+7WFGvwoVg0Haaq
	 WaiZG6TBYHQJqqJw2WQaAkP8LkW2vR11Wyr+GSQr6BJHfX7t5XwbVRb3JigT/9cPV8
	 SWoCa1y22bXnsbeWUbPIRYTcbiGtL9XtFt0A9My8FwGn8o7OYQoz/JMvKeB5dvNks1
	 aN8gL+5ocbMK25eKHafvcOUpRA/AlE9rXYR7MLAHAfFBHiIEuSs4tH4btK2hK6m1da
	 K4RViRoycWSb91QvhCXEqjJN8GGLjIAPbhPmefpNpBqYUWXOK0WNrQoYm2IwpUz5Fs
	 G4YVp9pikE0EQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61981Z4Y01033141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 16:01:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Feb 2026 16:01:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Feb 2026 16:01:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 9 Feb 2026 16:01:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: WARN only once in
 rtw_phy_get_tx_power_limit()
Thread-Topic: [PATCH rtw-next] wifi: rtw88: WARN only once in
 rtw_phy_get_tx_power_limit()
Thread-Index: AQHcl5KLHCE4H4O1KEKTrTKhNQ84N7V6Ax0w
Date: Mon, 9 Feb 2026 08:01:28 +0000
Message-ID: <946684847bb0463aa794828d3e1a3e83@realtek.com>
References: <98129317-7e88-4654-910b-630aa992bfa3@gmail.com>
In-Reply-To: <98129317-7e88-4654-910b-630aa992bfa3@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31656-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 2FFB410CB68
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGZ1bmN0aW9uIFdBUk5zIHdoZW4gdGhlIHdpZmkgYmFuZCwgY2hhbm5lbCBudW1iZXIsIGNoYW5u
ZWwgd2lkdGgsDQo+IHJhdGUsIG9yIFJGIHBhdGggYXJlIGludmFsaWQuIFR3byBvciB0aHJlZSBw
ZW9wbGUgaGF2ZSByZXBvcnRlZCB0aGF0IGl0DQo+IGZsb29kcyB0aGUga2VybmVsIGxvZyB3aXRo
IHdhcm5pbmdzIGJlY2F1c2UgdGhleSB0cnkgdG8gc3dpdGNoIHRvDQo+IGludmFsaWQgY2hhbm5l
bCBudW1iZXJzLCBsaWtlIDEzMC4NCj4gDQo+IE9uZSB3YXJuaW5nIGlzIHByb2JhYmx5IGVub3Vn
aCwgc28gdHVybiBXQVJOIGludG8gV0FSTl9PTkNFLg0KPiANCj4gQ2xvc2VzOiBodHRwczovL2dp
dGh1Yi5jb20vbHdmaW5nZXIvcnR3ODgvaXNzdWVzLzQyOA0KDQpBcyB0aGUgaXNzdWUgc2F5cyAi
aW52YWxpZCBhcmd1bWVudHMsIGJhbmQ9MSwgYnc9MiwgcGF0aD0xLCByYXRlPTgzLCBjaD0xMzAi
LA0KSSB0aGluayBpdCBvcGVyYXRlcyBvbiBiYW5kd2lkdGggODBNSHogYW5kIHByaW1hcnkgY2hh
bm5lbCAxMzAuIA0KQnV0IEkgZG9uJ3Qgc2VlIDIwTUh6IHByaW1hcnkgY2hhbm5lbCwgZm9yIGV4
YW1wbGUgWzFdLiANCg0KQ2FuIHdlIHN0b3AgdXNpbmcgdGhpcyBjaGFubmVsIGF0IHNldF9jaGFu
bmVsKCkgYWhlYWQgdG8gYXZvaWQgdGhpcyBlcnJvcj8NCg0KWzFdIGh0dHBzOi8vZW4ud2lraXBl
ZGlhLm9yZy93aWtpL0xpc3Rfb2ZfV0xBTl9jaGFubmVscw0KDQoNCj4gU2lnbmVkLW9mZi1ieTog
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYyB8IDQgKystLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYw0KPiBpbmRleCBlMmFjNWM2ZmQ1MDAuLjJh
MzkyOTU2MTY2NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9waHkuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3Bo
eS5jDQo+IEBAIC0yMjEwLDggKzIyMTAsOCBAQCBzdGF0aWMgczggcnR3X3BoeV9nZXRfdHhfcG93
ZXJfbGltaXQoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgdTggYmFuZCwNCj4gICAgICAgICByZXR1
cm4gcG93ZXJfbGltaXQ7DQo+IA0KPiAgZXJyOg0KPiAtICAgICAgIFdBUk4oMSwgImludmFsaWQg
YXJndW1lbnRzLCBiYW5kPSVkLCBidz0lZCwgcGF0aD0lZCwgcmF0ZT0lZCwgY2g9JWRcbiIsDQo+
IC0gICAgICAgICAgICBiYW5kLCBidywgcmZfcGF0aCwgcmF0ZSwgY2hhbm5lbCk7DQo+ICsgICAg
ICAgV0FSTl9PTkNFKDEsICJpbnZhbGlkIGFyZ3VtZW50cywgYmFuZD0lZCwgYnc9JWQsIHBhdGg9
JWQsIHJhdGU9JWQsIGNoPSVkXG4iLA0KPiArICAgICAgICAgICAgICAgICBiYW5kLCBidywgcmZf
cGF0aCwgcmF0ZSwgY2hhbm5lbCk7DQo+ICAgICAgICAgcmV0dXJuIChzOClydHdkZXYtPmNoaXAt
Pm1heF9wb3dlcl9pbmRleDsNCg0KSSBmZWVsIHRoaXMgd2lsbCBiZSBhIHByb2JsZW0gaWYgbWF4
X3Bvd2VyX2luZGV4IGlzIGFkb3B0ZWQuDQpUaGUgcG93ZXIgaXMgdG9vIGhpZ2guIA0KDQo+ICB9
DQo+IA0KPiAtLQ0KPiAyLjUyLjANCg0K

