Return-Path: <linux-wireless+bounces-31658-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDw7KauYiWmk/QQAu9opvQ
	(envelope-from <linux-wireless+bounces-31658-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:19:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B010CDD1
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E551301B728
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D602E62AC;
	Mon,  9 Feb 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VjIFBPEA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96A1917ED
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625157; cv=none; b=VXP4bSSLRilw7uwCms8fOY7sNE2GbI8Gap2AQFWkUeL9ILhuXp0o9M4CIcSN3TgxvFiCyHMSKtipx64epioP9aStHDotXeKJLQs3+xxMS8e1lqGi60RmlziTAlfcChIla2eArEqz1uxOvvRvNGUk6AX5e8WIbJ0VdTRRwV0nKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625157; c=relaxed/simple;
	bh=zGArAT5YrZG3PldozT/AEYqfNbReQudK74jduEDc2Yk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGMN8b4AnhrNYLXIXp1LfQxyc83n/zzgI1NipBTDUaeRdGTfDFXyO6a2D31Deh2bHU9Zt9dUs5FPGI2hMq8+//J9UdBX3ZMFwYaf7xeLjf+BPIXKQar3vtMzlP8IO4CUI3SkEps+23tmtrs2dxDaszwZuWOVCPU2QsOMoWXJqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VjIFBPEA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6198JCRX01068490, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770625152; bh=zGArAT5YrZG3PldozT/AEYqfNbReQudK74jduEDc2Yk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VjIFBPEAWGpZWV7Ue0RDesgEdR+gmaZMPhS2prbIet2HYA5YlliC1LjZ7tvxC+d8v
	 cbk0YB8erun6WXg3qVABLK/Mp4zHynnXcawdykCdFLfeEjSaADFgJmx4MbWjzEGIs6
	 EsM9AuaAoaFsJQNSfZtr08McK7U34nbVb7+tUhHgf0MytUNJRi4dLeQfNMSeuatlzQ
	 BvXurWutpgNh0Kj8pLmrEtdM20r4xamRo3m+Cm1vNHk1Z1ILH+xfd14pfBbNgfr7MC
	 SrLAs/ON8yKzjCifaj3kdkYxLnz8gea6dNWaZDtoJoNp1EpoKaPrvhhz2lgvg3cQKA
	 /yaikM/zQezuA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6198JCRX01068490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 16:19:12 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Feb 2026 16:19:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Feb 2026 16:19:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 9 Feb 2026 16:19:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Index: AQHcmIFUmn8F5SE8tkKhCC9anOXjZ7V6Bk9Q
Date: Mon, 9 Feb 2026 08:19:00 +0000
Message-ID: <04799d469547468abe15eadb2ec74255@realtek.com>
References: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
In-Reply-To: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
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
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-31658-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D01B010CDD1
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBXaGVu
IGNvbm5lY3RlZCB0byBhIG5ldHdvcmsgaW4gdGhlIDIuNCBHSHogYmFuZCwgd3BhX3N1cHBsaWNh
bnQgKG9yDQo+IE5ldHdvcmtNYW5hZ2VyPykgdHJpZ2dlcnMgYSBzY2FuIGV2ZXJ5IGZpdmUgbWlu
dXRlcy4gRHVyaW5nIHRoZXNlIHNjYW5zDQo+IG1hYzgwMjExIHRyYW5zbWl0cyBtYW55IFFvUyBO
dWxsIGZyYW1lcyBpbiBxdWljayBzdWNjZXNzaW9uLiBCZWNhdXNlDQo+IHRoZXNlIGZyYW1lcyBh
cmUgbWFya2VkIHdpdGggSUVFRTgwMjExX1RYX0NUTF9SRVFfVFhfU1RBVFVTLCBydHc4OA0KPiBh
c2tzIHRoZSBmaXJtd2FyZSB0byByZXBvcnQgdGhlIFRYIEFDSyBzdGF0dXMgZm9yIGVhY2ggb2Yg
dGhlc2UgZnJhbWVzLg0KPiBTb21ldGltZXMgdGhlIGZpcm13YXJlIGNhbid0IHByb2Nlc3MgdGhl
IFRYIHN0YXR1cyByZXF1ZXN0cyBxdWlja2x5DQo+IGVub3VnaCwgdGhleSBhZGQgdXAsIGl0IG9u
bHkgcHJvY2Vzc2VzIHNvbWUgb2YgdGhlbSwgYW5kIHRoZW4gbWFya3MNCj4gZXZlcnkgc3Vic2Vx
dWVudCBUWCBzdGF0dXMgcmVwb3J0IHdpdGggdGhlIHdyb25nIG51bWJlci4NCg0KRG9lcyBpdCBt
ZWFuIG51bWJlciBvZiByZXBvcnRzIGlzIGNvcnJlY3Q/IEJ1dCB3aXRoIGluY29ycmVjdCBzZXF1
ZW5jZSBudW1iZXI/DQpUaGVuLCB5b3UganVzdCBpZ25vcmUgY2hlY2tpbmcgJ3NuJyBidXQgYXNz
dW1lICdzdCcgaXMgY29ycmVjdC4NCg0KPiANCj4gVGhlIHN5bXB0b20gaXMgdGhhdCBhZnRlciBh
IHdoaWxlIHRoZSB3YXJuaW5nICJmYWlsZWQgdG8gZ2V0IHR4IHJlcG9ydA0KPiBmcm9tIGZpcm13
YXJlIiBhcHBlYXJzIGV2ZXJ5IGZpdmUgbWludXRlcy4NCj4gDQo+IFRoaXMgcHJvYmxlbSBhcHBh
cmVudGx5IGhhcHBlbnMgb25seSB3aXRoIHRoZSBvbGRlciBSVEw4NzIzRCwgUlRMODgyMUEsDQo+
IFJUTDg4MTJBLCBhbmQgcHJvYmFibHkgUlRMODcwM0IgY2hpcHMuIElnbm9yZSB0aGUgVFggcmVw
b3J0IHNlcXVlbmNlDQo+IG51bWJlciByZXBvcnRlZCBieSB0aGVzZSBjaGlwcyBhbmQgbWF0Y2gg
dGhlIHJlcG9ydHMgd2l0aCB0aGUgcmVxdWVzdHMNCj4gaW4gdGhlIG9yZGVyIHRoZXkgY29tZSBp
bi4NCj4gDQo+IFRlc3RlZCB3aXRoIFJUTDg4MjFBVSBhbmQgUlRMODcyM0RVLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jDQo+IGluZGV4IGMwNGZmMzFkMGYx
ZS4uOTgyMTVlY2M4ODRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3R4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC90eC5jDQo+IEBAIC0yNDgsNyArMjQ4LDcgQEAgdm9pZCBydHdfdHhfcmVwb3J0X2hhbmRsZShz
dHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgc3JjKQ0KPiAg
ICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ0eF9yZXBvcnQtPnFfbG9jaywgZmxhZ3MpOw0KPiAg
ICAgICAgIHNrYl9xdWV1ZV93YWxrX3NhZmUoJnR4X3JlcG9ydC0+cXVldWUsIGN1ciwgdG1wKSB7
DQo+ICAgICAgICAgICAgICAgICBuID0gKHU4ICopSUVFRTgwMjExX1NLQl9DQihjdXIpLT5zdGF0
dXMuc3RhdHVzX2RyaXZlcl9kYXRhOw0KPiAtICAgICAgICAgICAgICAgaWYgKCpuID09IHNuKSB7
DQo+ICsgICAgICAgICAgICAgICBpZiAoKm4gPT0gc24gfHwgcnR3X2NoaXBfd2NwdV84MDUxKHJ0
d2RldikpIHsNCg0KQ2FuIHdlIG9ubHkgbGltaXQgdG8gVVNCIGRldmljZXMgKG9yIG5vbi1QQ0kg
ZGV2aWNlcyk/DQoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgX19za2JfdW5saW5rKGN1ciwg
JnR4X3JlcG9ydC0+cXVldWUpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBydHdfdHhfcmVw
b3J0X3R4X3N0YXR1cyhydHdkZXYsIGN1ciwgc3QgPT0gMCk7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiAtLQ0KPiAyLjUyLjANCg0K

