Return-Path: <linux-wireless+bounces-33267-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKenNvFvt2nnRAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33267-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:50:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B672943D4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7B9300FC4C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3431A549;
	Mon, 16 Mar 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y1JL1SqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1621578D;
	Mon, 16 Mar 2026 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773629423; cv=none; b=mxk/OP4+/yEoYBQJYCNmMI8czfFXrdkZi5XmoxkIJa+yXwHTjAj7SOq8xK9Z6o3nyE8cjFZuFO1DxhMe4NK5rq9QyacxVR2c+y5TpwmrDgqe519PXHP9p8/vfRXku73XEdgysExWqqvbzitOi0WkHnE3BByk8RYWQKtPyl6afiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773629423; c=relaxed/simple;
	bh=S4SmkpRr3dRmGKvJFna1mW6vYDKUnGYw7O6aZEFN7to=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXLTm4bCxVlVk5EPNEzp0NPauB/EvPfoTnSLpXNBHSMp6FQccEe4IOd59el/QOa7CX80gnPJKFFrlHD2XjLwxqT5iXkn4zipJ/rruO0xJmUO928kYo9flqnq6zdrhcUyKIgliKDSox20W6GL7mLBDwPlATtOaHfEiOSofOOGT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y1JL1SqJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G2oHHx91049527, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773629417; bh=S4SmkpRr3dRmGKvJFna1mW6vYDKUnGYw7O6aZEFN7to=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Y1JL1SqJJnZwiAaYWNe9kkwtrh6w7g8RN/QRFM3Bk+SxY1cjQCPxO1wjvJjve0cuB
	 QdQQE6iBiWAcor3V/vP3awmZyDdMM0PoKUxtLvRtS6+WGApEsioltaVqObcOUyj86A
	 CILiAjezKHU1L/+Mq196orelJJUSZ1Hr5ckAb31mpRh2t2RQ4P8G80rAEczh4g8EZP
	 nqdnYGnLWw4oX+rVcKthjwSwXeiGYGaKctPYa8qc1EWGkj+fHo0/0xLDwr/fbYZ+ln
	 8C7jnI0K8SQG0Ai0jMMv3xy1sKWixgm76o7R5UgU670o/B0e7WFwmXAP+XC3FMFYsP
	 mGtIWz6lYs1sw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G2oHHx91049527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 10:50:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 10:50:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 10:50:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 16 Mar 2026 10:50:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIADBSKA
Date: Mon, 16 Mar 2026 02:50:15 +0000
Message-ID: <74569e958a5d4f3b9c857c1ecc8ec274@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com>
 <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com>
 <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
In-Reply-To: <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33267-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 42B672943D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gSSdkIGFkb3B0IHlvdXIgc3VnZ2VzdGlvbiAoZHluYW1p
YyBMUFNfREVFUF9NT0RFX05PTkUpIGlmIHRoZSB0ZXN0DQo+ID4gaXMgcG9zaXRpdmUuDQo+IA0K
PiBIaSBQaW5nLUtlLA0KPiANCj4gRm9sbG93aW5nIHlvdXIgc3VnZ2VzdGlvbiwgSSBwZXJmb3Jt
ZWQgYW4gYWRkaXRpb25hbCBleHBlcmltZW50IHRvDQo+IHZhbGlkYXRlIHRoZSBkeW5hbWljIExQ
U19ERUVQX01PREVfTk9ORSBpZGVhLiBQbGVhc2UgdHJlYXQgdGhpcw0KPiBwdXJlbHkgYXMgYSBm
aWVsZCB0ZXN0IHJlcG9ydCAtLSBJIGFtIG5vdCBhIGtlcm5lbCBkZXZlbG9wZXIsIGFuZCB0aGUN
Cj4gaW1wbGVtZW50YXRpb24gYmVsb3cgaXMgY2VydGFpbmx5IG5vdCB1cHN0cmVhbS1xdWFsaXR5
LiBJIGFtIHNoYXJpbmcNCj4gaXQgb25seSBpbiB0aGUgaG9wZSB0aGF0IGl0IGhlbHBzIHlvdSBk
ZXNpZ24gYSBwcm9wZXIgc29sdXRpb24uDQo+IA0KPiBXaGF0IEkgZGlkOg0KPiANCj4gSSBleHRl
bmRlZCB5b3VyIERNSSBxdWlyayBpbiBwY2kuYyB3aXRoIGFuIGFkZGl0aW9uYWwgY2FwYWJpbGl0
eSBmbGFnDQo+IGZvciBMUFMgRGVlcCBtb2RlLiBUaGUgb25seSBmaWxlIHRvdWNoZWQgd2FzIHBj
aS5jICh5b3VyIHBhdGNoKSAtLQ0KPiBtYWluLmMgd2FzIGxlZnQgY29tcGxldGVseSB1bm1vZGlm
aWVkLg0KPiANCj4gVGhlIGNoYW5nZXMgdG8geW91ciBwYXRjaCBhcmUgYXMgZm9sbG93czoNCj4g
DQo+ICAgLyogMS4gRXh0ZW5kZWQgdGhlIGNhcGFiaWxpdGllcyBlbnVtICovDQo+ICAgZW51bSBy
dHc4OF9xdWlya19kaXNfcGNpX2NhcHMgew0KPiAgICAgICAgICAgUVVJUktfRElTX1BDSV9DQVBf
QVNQTSwNCj4gICAgICAgICAgIFFVSVJLX0RJU19QQ0lfQ0FQX0xQU19ERUVQLCAgLyogdGVzdCBh
ZGRpdGlvbiAqLw0KPiAgIH07DQo+IA0KPiAgIC8qIDIuIEV4dGVuZGVkIGRpc2FibGVfcGNpX2Nh
cHMoKSBjYWxsYmFjayAqLw0KPiAgIHN0YXRpYyBpbnQgZGlzYWJsZV9wY2lfY2Fwcyhjb25zdCBz
dHJ1Y3QgZG1pX3N5c3RlbV9pZCAqZG1pKQ0KPiAgIHsNCj4gICAgICAgICAgIHVpbnRwdHJfdCBk
aXNfY2FwcyA9ICh1aW50cHRyX3QpZG1pLT5kcml2ZXJfZGF0YTsNCj4gDQo+ICAgICAgICAgICBp
ZiAoZGlzX2NhcHMgJiBCSVQoUVVJUktfRElTX1BDSV9DQVBfQVNQTSkpDQo+ICAgICAgICAgICAg
ICAgICAgIHJ0d19wY2lfZGlzYWJsZV9hc3BtID0gdHJ1ZTsNCj4gDQo+ICAgICAgICAgICBpZiAo
ZGlzX2NhcHMgJiBCSVQoUVVJUktfRElTX1BDSV9DQVBfTFBTX0RFRVApKQ0KPiAgICAgICAgICAg
ICAgICAgICBydHdfZGlzYWJsZV9scHNfZGVlcF9tb2RlID0gdHJ1ZTsNCj4gDQo+ICAgICAgICAg
ICByZXR1cm4gMTsNCj4gICB9DQo+IA0KPiAgIC8qIDMuIEJvdGggZmxhZ3Mgc2V0IGZvciB0aGUg
SFAgUDNTOTVFQSNBQ0IgZW50cnkgKi8NCj4gICAuZHJpdmVyX2RhdGEgPSAodm9pZCAqKShCSVQo
UVVJUktfRElTX1BDSV9DQVBfQVNQTSkgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJ
VChRVUlSS19ESVNfUENJX0NBUF9MUFNfREVFUCkpLA0KPiANCj4gSSBhbSBhd2FyZSB0aGF0IHNl
dHRpbmcgcnR3X2Rpc2FibGVfbHBzX2RlZXBfbW9kZSBmcm9tIHBjaS5jIGlzDQo+IGFyY2hpdGVj
dHVyYWxseSBpbXB1cmUgLS0gaXQgaXMgYSBnbG9iYWwgZmxhZyB0aGF0IHdvdWxkIGFmZmVjdCBh
bGwNCj4gcnR3ODggZGV2aWNlcyBpbiBhIGh5cG90aGV0aWNhbCBtdWx0aS1hZGFwdGVyIHN5c3Rl
bS4gQSBwcm9wZXINCj4gcGVyLWRldmljZSBzb2x1dGlvbiAoZS5nLiBhIGZsYWcgaW5zaWRlIHN0
cnVjdCBydHdfZGV2IHNldCBkdXJpbmcNCj4gcHJvYmUpIHdvdWxkIGJlIGNsZWFuZXIuIEkgc2lt
cGx5IHVzZWQgdGhlIGV4aXN0aW5nIGdsb2JhbCBhcyB0aGUNCj4gbW9zdCBzdHJhaWdodGZvcndh
cmQgd2F5IHRvIHZhbGlkYXRlIHRoZSBjb25jZXB0Lg0KPiANCj4gVmVyaWZpY2F0aW9uOg0KPiAN
Cj4gQ29uZmlybWVkIG5vIHJ0dzg4LXJlbGF0ZWQgZW50cmllcyBleGlzdCBpbiAvZXRjL21vZHBy
b2JlLmQvLA0KPiAvbGliL21vZHByb2JlLmQvLCBvciAvcnVuL21vZHByb2JlLmQvLCBydWxpbmcg
b3V0IGFueSBleHRlcm5hbA0KPiBwYXJhbWV0ZXIgaW5qZWN0aW9uLg0KPiANCj4gQWZ0ZXIgbG9h
ZGluZyB0aGUgcGF0Y2hlZCBtb2R1bGVzLCB0aGUgZm9sbG93aW5nIHdhcyBjb25maXJtZWQgdmlh
DQo+IHN5c2ZzOg0KPiANCj4gICAvc3lzL21vZHVsZS9ydHc4OF9jb3JlL3BhcmFtZXRlcnMvZGlz
YWJsZV9scHNfZGVlcF9tb2RlID0gWQ0KPiAgIC9zeXMvbW9kdWxlL3J0dzg4X3BjaS9wYXJhbWV0
ZXJzL2Rpc2FibGVfYXNwbSA9IFkNCj4gDQo+IFRoaXMgY29uZmlybXMgdGhlIERNSSBxdWlyayBp
cyB0aGUgc29sZSBzb3VyY2Ugb2YgYm90aCB2YWx1ZXMuDQo+IA0KPiBSZXN1bHRzICgxMC1taW51
dGUgaWRsZSBvYnNlcnZhdGlvbiwgYmF0dGVyeSBwb3dlciwgd2lmaS5wb3dlcnNhdmU9Myk6DQo+
IA0KPiAgIFdpdGggeW91ciBBU1BNIHBhdGNoIGFsb25lIChMUFMgRGVlcCBzdGlsbCBhY3RpdmUp
Og0KPiAgICAgLSBwZXJpb2RpYyAiZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQiIGJ1cnN0cyBv
YnNlcnZlZA0KPiAgICAgLSBvY2Nhc2lvbmFsIFdpRmkgdGhyb3VnaHB1dCBkcm9wcyBhbmQgQmx1
ZXRvb3RoIGF1ZGlvIHN0dXR0ZXJpbmcNCj4gDQo+ICAgV2l0aCBBU1BNIHBhdGNoICsgTFBTIERl
ZXAgZGlzYWJsZWQgdmlhIHRoZSBxdWlyazoNCj4gICAgIC0gaDJjPTAsIGxwcz0wIGFjcm9zcyB0
aGUgZW50aXJlIG9ic2VydmF0aW9uIHdpbmRvdw0KPiAgICAgLSBXaUZpIHRocm91Z2hwdXQgc3Rh
YmxlLCBCbHVldG9vdGggYXVkaW8gdW5pbnRlcnJ1cHRlZA0KPiANCj4gVGhlIHJlc3VsdCBjb25m
aXJtcyB0aGF0IGRpc2FibGluZyBMUFMgRGVlcCBNb2RlIGluIGFkZGl0aW9uIHRvIEFTUE0NCj4g
Y29tcGxldGVseSBlbGltaW5hdGVzIHRoZSByZW1haW5pbmcgZmlybXdhcmUgdGltZW91dCBsb29w
IG9uIHRoaXMNCj4gcGxhdGZvcm0uDQo+IA0KPiBJIGhvcGUgdGhpcyBleHBlcmltZW50IGlzIHVz
ZWZ1bCBhcyBhIGRhdGEgcG9pbnQuIFBsZWFzZSBmZWVsIGZyZWUgdG8NCj4gZGlzY2FyZCB0aGUg
aW1wbGVtZW50YXRpb24gYW5kIGRlc2lnbiBhIHByb3BlciBzb2x1dGlvbiAtLSBJIGFtIHJlYWR5
DQo+IHRvIHRlc3QgYW55IHVwZGF0ZWQgcGF0Y2ggeW91IHNlbmQuDQoNClRoYW5rcyBmb3IgeW91
ciBhbmFseXNpcyBvZiBUWC9SWCBwYXRocywgYW5kIHRoZSBjaGFuZ2VzIGFib3ZlIGFuZA0KdmVy
aWZpY2F0aW9ucy4gOikNCg0KSSdkIHVwZGF0ZSB0aGUgcGF0Y2ggYXMgeW91ciBwcm9wb3NhbCBh
bmQgc2VuZCBhIHBhdGNoLiBGb3Igc3VnZ2VzdGlvbnMgb2YNClRYL1JYIHBhdGhzLCBJIG9ubHkg
cmVhZCB0aGVtIGEgbGl0dGxlIGJpdCwgYW5kIEkgd2lsbCBzdHVkeSB0aGVtIGVudGlyZWx5DQp3
aGVuIEkgaGF2ZSBtb3JlIGZyZWUgdGltZS4gDQoNClBpbmctS2UNCg0K

