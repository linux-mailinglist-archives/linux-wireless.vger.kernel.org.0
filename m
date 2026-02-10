Return-Path: <linux-wireless+bounces-31687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a331CbnTimnWOAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 07:44:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F801176B1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 07:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A42733019048
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1732E696;
	Tue, 10 Feb 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="b/x206k4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD332E68F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705845; cv=none; b=MEeaOrNBSQQPNo7KibdSCd9ef9lz4un8XoV0EpFgxD5W9mIg2Da/rpkNHSGbZ+crUHsf9BPaAdSKdIG1aspykSep71uxuBqm13PQuBETVZpSYoY2pVS1w+Kast+rtYe+0TAX+E756hGUqoSZle0WrSO7iD1z9ONg0/Ow01TI5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705845; c=relaxed/simple;
	bh=+hMUpmOsga3s24yuSmx9UzxkRcROaeF08j655ezTfGQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQSTDVWIoZ03rseSMxcX8ArD0zVU5OKj5ItA68WtCVYGKa6XbtrM3YPZAiDKsWBzJOZaUWqxd3uenCOnxocYiS5MRkpaHpLH9E1Ikf8bmdPfU/NjrIHsdpsa8Zg7yE6YSR+Iqv7TNvBgqTaUf4Uc2E1fEcZCVKuoKQK0d35G0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=b/x206k4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61A6hxAjB3194448, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770705839; bh=+hMUpmOsga3s24yuSmx9UzxkRcROaeF08j655ezTfGQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=b/x206k4xxduM+hs+ERaOq/1ltla7Xq2GJ1rX+AWE3rU+t4O9hV8zCTqOiWl7W1pI
	 s0wV0hCTy4e/XyQBKHlGmN8Tf/BBY+FoB+/rbNMDzIL/M1fcZzdAQv0627hMeHkGZ9
	 TpfSYJm9RINbKOkuM3bW4P9+6OB2r2Y7wG3ETcyI7BWbz9+1X8RfGlTWumm1GBSv5O
	 V9/QYQvKnbrHmq1M3NlC7UK/bulG1560x5gbICNfo+yytQPzLXiXi+q3IZ+XyPX+Mh
	 +6o896y3Mv+pSKUsqjXIV5T6wHfZx4QtdRKli900Q0ZQrxPb8MubqBRWdzGAWK/iBZ
	 HIrJydoolP1Fw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61A6hxAjB3194448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 14:43:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Feb 2026 14:44:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 10 Feb 2026 14:44:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Index: AQHcmIFUmn8F5SE8tkKhCC9anOXjZ7V6Bk9QgABO9gCAASjwkA==
Date: Tue, 10 Feb 2026 06:44:00 +0000
Message-ID: <442b0555b369487b81ba96dcf410cf7d@realtek.com>
References: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
 <04799d469547468abe15eadb2ec74255@realtek.com>
 <a95d43dc-58c7-4c9c-9b42-204f2134f099@gmail.com>
In-Reply-To: <a95d43dc-58c7-4c9c-9b42-204f2134f099@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31687-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70F801176B1
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
OS8wMi8yMDI2IDEwOjE5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBXaGVuIGNvbm5lY3RlZCB0
byBhIG5ldHdvcmsgaW4gdGhlIDIuNCBHSHogYmFuZCwgd3BhX3N1cHBsaWNhbnQgKG9yDQo+ID4+
IE5ldHdvcmtNYW5hZ2VyPykgdHJpZ2dlcnMgYSBzY2FuIGV2ZXJ5IGZpdmUgbWludXRlcy4gRHVy
aW5nIHRoZXNlIHNjYW5zDQo+ID4+IG1hYzgwMjExIHRyYW5zbWl0cyBtYW55IFFvUyBOdWxsIGZy
YW1lcyBpbiBxdWljayBzdWNjZXNzaW9uLiBCZWNhdXNlDQo+ID4+IHRoZXNlIGZyYW1lcyBhcmUg
bWFya2VkIHdpdGggSUVFRTgwMjExX1RYX0NUTF9SRVFfVFhfU1RBVFVTLCBydHc4OA0KPiA+PiBh
c2tzIHRoZSBmaXJtd2FyZSB0byByZXBvcnQgdGhlIFRYIEFDSyBzdGF0dXMgZm9yIGVhY2ggb2Yg
dGhlc2UgZnJhbWVzLg0KPiA+PiBTb21ldGltZXMgdGhlIGZpcm13YXJlIGNhbid0IHByb2Nlc3Mg
dGhlIFRYIHN0YXR1cyByZXF1ZXN0cyBxdWlja2x5DQo+ID4+IGVub3VnaCwgdGhleSBhZGQgdXAs
IGl0IG9ubHkgcHJvY2Vzc2VzIHNvbWUgb2YgdGhlbSwgYW5kIHRoZW4gbWFya3MNCj4gPj4gZXZl
cnkgc3Vic2VxdWVudCBUWCBzdGF0dXMgcmVwb3J0IHdpdGggdGhlIHdyb25nIG51bWJlci4NCj4g
Pg0KPiA+IERvZXMgaXQgbWVhbiBudW1iZXIgb2YgcmVwb3J0cyBpcyBjb3JyZWN0PyBCdXQgd2l0
aCBpbmNvcnJlY3Qgc2VxdWVuY2UgbnVtYmVyPw0KPiA+IFRoZW4sIHlvdSBqdXN0IGlnbm9yZSBj
aGVja2luZyAnc24nIGJ1dCBhc3N1bWUgJ3N0JyBpcyBjb3JyZWN0Lg0KPiA+DQo+IA0KPiBUaGUg
bnVtYmVyIG9mIHJlcG9ydHMgaXMgY29ycmVjdCBtb3N0IG9mIHRoZSB0aW1lLiBPbmx5IHdoZW4g
dGhlIGZpcm13YXJlDQo+IGlzIG92ZXJ3aGVsbWVkICg/KSBpdCBkb2Vzbid0IHByb3ZpZGUgZXZl
cnkgcmVwb3J0LCBidXQgbGF0ZXIgaXQgcmVjb3ZlcnMuDQo+IA0KDQpJIHdhcyBub3QgYXdhcmUg
dGhhdCB0aGlzIGhhcHBlbmVkIHdoaWxlIHNjYW5uaW5nLCBzbyB3ZSBtaWdodCBhcHBseSB0aGlz
IGxvb3NlDQpjaGVja2luZyB1bmRlciBzY2FuIGNvbmRpdGlvbiAtLSB0ZXN0X2JpdChSVFdfRkxB
R19TQ0FOTklORywgcnR3ZGV2LT5mbGFncykiPw0KSWYgVFggcmVwb3J0IGlzIGJlY2F1c2Ugb2Yg
cmUta2V5LCBpdCBjYW4gc3RpbGwgdXNlIG9yaWdpbmFsIHJ1bGUuIA0KDQpbLi4uXQ0KDQo+IA0K
PiA+Pg0KPiA+PiBUaGUgc3ltcHRvbSBpcyB0aGF0IGFmdGVyIGEgd2hpbGUgdGhlIHdhcm5pbmcg
ImZhaWxlZCB0byBnZXQgdHggcmVwb3J0DQo+ID4+IGZyb20gZmlybXdhcmUiIGFwcGVhcnMgZXZl
cnkgZml2ZSBtaW51dGVzLg0KPiA+Pg0KPiA+PiBUaGlzIHByb2JsZW0gYXBwYXJlbnRseSBoYXBw
ZW5zIG9ubHkgd2l0aCB0aGUgb2xkZXIgUlRMODcyM0QsIFJUTDg4MjFBLA0KPiA+PiBSVEw4ODEy
QSwgYW5kIHByb2JhYmx5IFJUTDg3MDNCIGNoaXBzLiBJZ25vcmUgdGhlIFRYIHJlcG9ydCBzZXF1
ZW5jZQ0KPiA+PiBudW1iZXIgcmVwb3J0ZWQgYnkgdGhlc2UgY2hpcHMgYW5kIG1hdGNoIHRoZSBy
ZXBvcnRzIHdpdGggdGhlIHJlcXVlc3RzDQo+ID4+IGluIHRoZSBvcmRlciB0aGV5IGNvbWUgaW4u
DQo+ID4+DQo+ID4+IFRlc3RlZCB3aXRoIFJUTDg4MjFBVSBhbmQgUlRMODcyM0RVLg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3R4LmMgfCAyICstDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvdHguYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdHgu
Yw0KPiA+PiBpbmRleCBjMDRmZjMxZDBmMWUuLjk4MjE1ZWNjODg0YSAxMDA2NDQNCj4gPj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jDQo+ID4+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdHguYw0KPiA+PiBAQCAtMjQ4LDcgKzI0
OCw3IEBAIHZvaWQgcnR3X3R4X3JlcG9ydF9oYW5kbGUoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwg
c3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IHNyYykNCj4gPj4gICAgICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmdHhfcmVwb3J0LT5xX2xvY2ssIGZsYWdzKTsNCj4gPj4gICAgICAgICBza2JfcXVldWVf
d2Fsa19zYWZlKCZ0eF9yZXBvcnQtPnF1ZXVlLCBjdXIsIHRtcCkgew0KPiA+PiAgICAgICAgICAg
ICAgICAgbiA9ICh1OCAqKUlFRUU4MDIxMV9TS0JfQ0IoY3VyKS0+c3RhdHVzLnN0YXR1c19kcml2
ZXJfZGF0YTsNCj4gPj4gLSAgICAgICAgICAgICAgIGlmICgqbiA9PSBzbikgew0KPiA+PiArICAg
ICAgICAgICAgICAgaWYgKCpuID09IHNuIHx8IHJ0d19jaGlwX3djcHVfODA1MShydHdkZXYpKSB7
DQo+ID4NCj4gPiBDYW4gd2Ugb25seSBsaW1pdCB0byBVU0IgZGV2aWNlcyAob3Igbm9uLVBDSSBk
ZXZpY2VzKT8NCj4gPg0KPiANCj4gSSBkb24ndCB0aGluayBzby4gUlRMODgyMUFFIGFsc28gaGFz
IHRoaXMgcHJvYmxlbS4gSSBkaWRuJ3QgbWVudGlvbiBpdA0KPiBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UgYmVjYXVzZSBzdXBwb3J0IGZvciBSVEw4ODIxQUUgaW4gcnR3ODggaXMNCj4gdW5vZmZpY2lh
bC4gKEkgbW9kaWZpZWQgcnR3ODhfcGNpIHRvIGhhbmRsZSB0aGUgb2xkZXIgZ2VuZXJhdGlvbiwg
c2VlDQo+IHRoZSB1c2VfbmV3X3RyeF9mbG93PWZhbHNlIGNvZGUgcGF0aCBpbiBydGx3aWZpLikN
Cg0KSG93IGFib3V0IG9mZmljaWFsIFJUTDg3MjNERT8NCg0KPiANCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgX19za2JfdW5saW5rKGN1ciwgJnR4X3JlcG9ydC0+cXVldWUpOw0KPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICBydHdfdHhfcmVwb3J0X3R4X3N0YXR1cyhydHdkZXYsIGN1
ciwgc3QgPT0gMCk7DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiAt
LQ0KPiA+PiAyLjUyLjANCj4gPg0KDQo=

