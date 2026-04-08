Return-Path: <linux-wireless+bounces-34494-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bvEyIHGl1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34494-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:46:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51393B5C00
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA845301A907
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC4C2A1BF;
	Wed,  8 Apr 2026 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BzU9SSYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05412DDCD
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609198; cv=none; b=PHI6YLshmvOWZIMLGDYW78x2Wj8kaPTkaTSSEg9ai1ACnEE84uCfTSb6IFqNpd4thp37cheH+PpxJ+Dr/GEGc0UzNxFaaEW9M+seYBPgr66lttO6TC8FR+AfXamAAhqEIEvPE+hdz0PmrArpM5iNkh8NgzkdE1FpisuCxpL24Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609198; c=relaxed/simple;
	bh=sBcOIkwyfY1VjHqjC1s/lJFOJX6inz7o2ijw8mNH210=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HmYYej7+QLPkdeB8d+8jpuxHd/r1/a3QjsybdIPMlXZiLkgTf6wT2IUU0LCf4I/yd9IaLM6rguFy+9iHvszZh9TaPJIS0mNIpLvKGm+wKh07JGF9c2x1W71fx+Z3F+K2XJOMJLBmCzgGYVJRGeHEsL+9OFqPB3/gj+pqYnT5Dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BzU9SSYi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6380kVyR52132419, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775609191; bh=sBcOIkwyfY1VjHqjC1s/lJFOJX6inz7o2ijw8mNH210=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BzU9SSYinFEnVaG3j+Ic329NOwTV+qDC9veconSNKtP5Qbs0JQ8ap88H4qlgwls5u
	 lxC7DibVEt556ozf6mVlVrLCG+tWLnyj2p2mxXOgCYdSK2JrxY7zzN/W/Tn40AvERJ
	 sHweAZTymSDxfaOcR/FxpScWb7yxUy2fp9K13sA5gLYuXJrbc3dQV762NTv7V6N8EA
	 iNQVdK41IxxfuOKvi/L7EeqaDKe6goD3xDrucgRHoS4Pz81mqsoQD4R7nTHpC7xErO
	 oXRKG2iGpS1UDWx5vYZrPabmoWgX5STIcU8uVHZ0sgDU5hCavYxmkCLK+acaY/+BEL
	 QQJp9dQ9fdqZg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6380kVyR52132419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 08:46:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 8 Apr 2026 08:46:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Wed, 8 Apr 2026 08:46:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
Thread-Topic: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
Thread-Index: AQHcvUJaf1EFq86SyU2PseRbtxmFrLXGZTQggAOYQoCAAPmSUIAIpkQAgADI+yA=
Date: Wed, 8 Apr 2026 00:46:31 +0000
Message-ID: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <25781f4aa6cc427caf396374ca46d380@realtek.com>
 <a90f22d6-bac0-4c76-86fb-517e7e7bf441@gmail.com>
 <0cbfd38ffd0b46e899885c83889d060b@realtek.com>
 <e8d10b96-f305-46f4-a473-2592f237f871@gmail.com>
In-Reply-To: <e8d10b96-f305-46f4-a473-2592f237f871@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34494-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C51393B5C00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0K
PiBPbiAwMi8wNC8yMDI2IDAzOjQ4LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAzMC8wMy8y
MDI2IDA1OjUzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4gT2Z0ZW4gb25lIG9yIG1vcmUg
b2YgdGhlc2UgbWVzc2FnZXMgYXBwZWFycyB3aGVuIHRoZSBjaGlwIHBvd2VycyBvbjoNCj4gPj4+
Pg0KPiA+Pj4+IFsgICsyLjE2NzAzN10gcnR3ODlfODkyMmF1IDEtMjoxLjA6IGZhaWxlZCB0byB3
YWl0IFJGIERBQ0sNCj4gPj4+Pg0KPiA+Pj4+IFsgICsyLjk0Mjc0OV0gcnR3ODlfODkyMmF1IDEt
MjoxLjA6IGZhaWxlZCB0byB3YWl0IFJGIFRTU0kNCj4gPj4+Pg0KPiA+Pj4+IFsgICswLjAxOTAw
Nl0gcnR3ODlfODkyMmF1IDItNDoxLjA6IGZhaWxlZCB0byB3YWl0IFJGIFBSRV9OVEZZDQo+ID4+
Pj4NCj4gPj4+PiBbICArNS45ODU5MDBdIHJ0dzg5Xzg5MjJhdSAyLTQ6MS4wOiBmYWlsZWQgdG8g
d2FpdCBSRiBEUEsNCj4gPj4+Pg0KPiA+Pj4+IEl0J3MgdW5jbGVhciB3aHkuDQo+ID4+Pg0KPiA+
Pj4gUlRMODkyMkQgZG9uZSBSRiBjYWxpYnJhdGlvbnMgYnkgZmlybXdhcmUgb25lIGJ5IG9uZSwg
c28gZHJpdmVyIHNob3VsZA0KPiA+Pj4gd2FpdCBmb3IgcHJldmlvdXMgb25lIGRvbmUsIGFuZCB0
cmlnZ2VyIG5leHQgb25lLiBIb3dldmVyLCBpdCdkIGJlDQo+ID4+PiB3ZWxsIHRvIGp1c3QgZG8g
d2FpdGluZyBhdCB0aGUgbGFzdCB0byB3YWl0IGZvciBhbGwgY2FsaWJyYXRpb25zLg0KPiA+Pj4N
Cj4gPj4+IFRyeSB0byBlbmxhcmdlIHdhaXRpbmcgdGltZSBpbiBydHc4OTIyYV9yZmtfY2hhbm5l
bCgpLg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSB3YXMgY29udmluY2VkIEkgdHJpZWQgdGhhdCBhbHJl
YWR5LCBidXQgbm8uDQo+ID4+DQo+ID4+IEFmdGVyIGluY3JlYXNpbmcgYWxsIGRlbGF5cyBhIGJp
dCB0aGUgd2FybmluZ3MgYXJlIG11Y2ggbW9yZSByYXJlLg0KPiA+DQo+ID4gVHVybiBvZiBkZWJ1
ZyBtYXNrIFJUVzg5X0RCR19SRksgYW5kIHNldCBhIHZlcnkgbGFyZ2UgdGltZW91dCB0aW1lLCBh
bmQNCj4gPiBkbyBjb25uZWN0aW9uID4yMCB0aW1lcyBhbmQgdGhlbiBjaGVjayAiUkYgJXMgdGFr
ZXMgJWxsZCBtcyB0byBjb21wbGV0ZSINCj4gPiB0byBzZWUgdGhlIG1heGltdW0gdmFsdWUgaW4g
eW91ciBlbnZpcm9ubWVudC4NCj4gPg0KPiA+IFBsZWFzZSBzaGFyZSB0aGUgbnVtYmVyIGZvciBl
YWNoIFJGIGNhbGlicmF0aW9uIGFmdGVyIHlvdXIgZXhwZXJpbWVudHMuDQo+ID4NCj4gDQo+IEkg
Y2hhbmdlZCBldmVyeSBkZWxheSB0byA1MDAsIHRoZW4gcmFuIHRoaXMsIG9uY2Ugd2l0aCB0aGUg
YWRhcHRlciBpbg0KPiBVU0IgMiwgb25jZSBpbiBVU0IgMzoNCj4gDQo+IGZvciBpIGluIHswMS4u
MjB9OyBkbyBubWNsaSBjb25uZWN0aW9uIHVwICI8Mi40IEdIeiBTU0lEPiI7IHNsZWVwIDEwOyBu
bWNsaSBjb25uZWN0aW9uIHVwICI8NSBHSHogU1NJRD4iOw0KPiBzbGVlcCAxMDsgZG9uZQ0KPiAN
Cj4gVGhlcmUgd2VyZSBubyAiZmFpbGVkIHRvIHdhaXQgUkYiIHdhcm5pbmdzLg0KPiANCj4gVGhl
c2UgYXJlIHRoZSByZXN1bHRzIGFmdGVyIHByb2Nlc3Npbmcgd2l0aCAic29ydCAtLXVuaXF1ZSI6
DQo+IA0KPiBSRiBEQUNLIHRha2VzIDE1IG1zIHRvIGNvbXBsZXRlDQo+IFJGIERBQ0sgdGFrZXMg
MTYgbXMgdG8gY29tcGxldGUNCj4gUkYgREFDSyB0YWtlcyA0NCBtcyB0byBjb21wbGV0ZQ0KPiBS
RiBEQUNLIHRha2VzIDcyIG1zIHRvIGNvbXBsZXRlDQo+IA0KPiBSRiBEUEsgdGFrZXMgMjMgbXMg
dG8gY29tcGxldGUNCj4gUkYgRFBLIHRha2VzIDI0IG1zIHRvIGNvbXBsZXRlDQo+IFJGIERQSyB0
YWtlcyAyNyBtcyB0byBjb21wbGV0ZQ0KPiBSRiBEUEsgdGFrZXMgMzAgbXMgdG8gY29tcGxldGUN
Cj4gDQo+IFJGIElRSyB0YWtlcyA0OCBtcyB0byBjb21wbGV0ZQ0KPiBSRiBJUUsgdGFrZXMgNDkg
bXMgdG8gY29tcGxldGUNCj4gUkYgSVFLIHRha2VzIDUwIG1zIHRvIGNvbXBsZXRlDQo+IA0KPiBS
RiBQUkVfTlRGWSB0YWtlcyAwIG1zIHRvIGNvbXBsZXRlDQo+IFJGIFBSRV9OVEZZIHRha2VzIDEg
bXMgdG8gY29tcGxldGUNCj4gDQo+IFJGIFJYX0RDSyB0YWtlcyA4IG1zIHRvIGNvbXBsZXRlDQo+
IFJGIFJYX0RDSyB0YWtlcyA5IG1zIHRvIGNvbXBsZXRlDQo+IFJGIFJYX0RDSyB0YWtlcyAxMSBt
cyB0byBjb21wbGV0ZQ0KPiBSRiBSWF9EQ0sgdGFrZXMgMjMgbXMgdG8gY29tcGxldGUNCj4gUkYg
UlhfRENLIHRha2VzIDI0IG1zIHRvIGNvbXBsZXRlDQo+IFJGIFJYX0RDSyB0YWtlcyAyNyBtcyB0
byBjb21wbGV0ZQ0KPiBSRiBSWF9EQ0sgdGFrZXMgMzggbXMgdG8gY29tcGxldGUNCj4gUkYgUlhf
RENLIHRha2VzIDM5IG1zIHRvIGNvbXBsZXRlDQo+IFJGIFJYX0RDSyB0YWtlcyA1MyBtcyB0byBj
b21wbGV0ZQ0KPiBSRiBSWF9EQ0sgdGFrZXMgNTQgbXMgdG8gY29tcGxldGUNCj4gUkYgUlhfRENL
IHRha2VzIDU4IG1zIHRvIGNvbXBsZXRlDQo+IFJGIFJYX0RDSyB0YWtlcyA3MCBtcyB0byBjb21w
bGV0ZQ0KPiBSRiBSWF9EQ0sgdGFrZXMgMTEwIG1zIHRvIGNvbXBsZXRlDQo+IA0KPiBSRiBUU1NJ
IHRha2VzIDEgbXMgdG8gY29tcGxldGUNCj4gUkYgVFNTSSB0YWtlcyAyIG1zIHRvIGNvbXBsZXRl
DQo+IFJGIFRTU0kgdGFrZXMgMjMgbXMgdG8gY29tcGxldGUNCj4gUkYgVFNTSSB0YWtlcyAyNCBt
cyB0byBjb21wbGV0ZQ0KPiANCj4gUkYgVFhHQVBLIHRha2VzIDkgbXMgdG8gY29tcGxldGUNCj4g
UkYgVFhHQVBLIHRha2VzIDEwIG1zIHRvIGNvbXBsZXRlDQo+IFJGIFRYR0FQSyB0YWtlcyAxNyBt
cyB0byBjb21wbGV0ZQ0KPiBSRiBUWEdBUEsgdGFrZXMgMTggbXMgdG8gY29tcGxldGUNCj4gDQo+
IEkgYWxzbyBsZWZ0IGl0IHVuY29ubmVjdGVkIGFuZCBjb25zdGFudGx5IHNjYW5uaW5nIGZvciBh
IGZldyBtaW51dGVzLg0KPiBSVFc4OV9UU1NJX1NDQU4gYWx3YXlzIHRha2VzIDEtMiBtcy4NCj4g
DQoNCllvdSBjYW4gbWFrZSBhIHNldCBvZiBudW1iZXIgb3IgYSBjb25zdGFudCBtdWx0aXBsZSBm
b3IgVVNCIGRldmljZXMuDQpBcyB3ZSB3YW50IGhhcmR3YXJlIHJlc3RhcnQgZmxvdyBpbmNsdWRp
bmcgUkYgY2FsaWJyYXRpb24gd2l0aGluIGENCmxpbWl0ZWQgdGltZSwgSSdkIG5vdCBlbmxhcmdl
IHRoZXNlIG51bWJlcnMgZm9yIFBDSUUgZGV2aWNlcy4gDQoNClBpbmctS2UNCg0K

