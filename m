Return-Path: <linux-wireless+bounces-31434-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CVYIWwDgGkh1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-31434-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 02:52:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF9C7CE3
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 02:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6E7300421C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408F26ADC;
	Mon,  2 Feb 2026 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qcpJR0VT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83D1C01
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769997161; cv=none; b=ne9Nfy7PFMOod6pQVoBjG/FkH1PpbPkfOautVkvD/n1bwAwoeL/PLKVxm0glRQqTFG1+xrR3swhvZjcitZW+5EzK5URdbxVTyIDRYmt3Iqv9CWw7ktOzgld30FkRJkgbgbKVOV1Ki/47EQuEHBX0+WuBPXQR6I5PbOzRlb8MUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769997161; c=relaxed/simple;
	bh=6kVeYK5aLo13YM9ZRttSI1KsCWbVFegRcCLcoF/mKMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KY+9WKeQDQm7VN+TYnn9a7q9IIMgojIhnQClPkJ7eqjYoa7mxmgs3BzjAvil8uI4nrScf/Jf5FqfyLvP1u8ZH6Ghq/oedEz6cX+FaLb7omzWnA1EJNrkU+mxJpyyx8TQF4okhleYHb7wrli84MIAvrzEo2yxzTmA9avqqGHjhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qcpJR0VT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6121qaaH71881526, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769997156; bh=6kVeYK5aLo13YM9ZRttSI1KsCWbVFegRcCLcoF/mKMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qcpJR0VTH4yttRiJDf1Lx0MTidjoOyfEn+Esi4fyTY+u14BHnTvNVQm6wvQ74CLVy
	 roH5fw8GsU+FxRazaoLZPAfeaNg9XhXPeZ2bZrvZF8udYmRwZHdx4h8NhfafceuAHE
	 Fva8Rdl2tp8V5K2ff1UPiByODCsdap7C9R2/qHhmbjv/tF2lKRVTXA9csk2HbUvvaz
	 tl5r69vjGFeWvWDO72IyNPK3mRh68ZPwbPaVHAIy8nLoGER/YSeO6+0p28STlmPQS9
	 7X9oLKEliWZqvITIegmkk/9Dm2vTcb5NqOrZYyJmFVXul8r4ReNL8+3BIFpgHkQYOx
	 Q0jhL8YIhNqnw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6121qaaH71881526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 09:52:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Feb 2026 09:52:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Feb 2026 09:52:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 2 Feb 2026 09:52:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Iohann Tachy <iohann.tachy@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Problems building rtw89
Thread-Topic: Problems building rtw89
Thread-Index: AQHckRigK2YBsPmWJU23l7X48l+K4rVp3ZDwgACNW4CAAJzOgIADoBRw
Date: Mon, 2 Feb 2026 01:52:35 +0000
Message-ID: <b7830d69ee2645fb9e4a3c371dcdf6eb@realtek.com>
References: <CAPVS0eKn3zEyRekrQP_K3W5n5iVZ44nXkUAAE2=KkNcpq+LeYg@mail.gmail.com>
 <f730f3ca7b1d4fd08795831e13cc8f2f@realtek.com>
 <CAPVS0eKLicu1Y+MUpLcuwqTU0agEn9m7zyOO_5rgB3vA+gM9Bg@mail.gmail.com>
 <CAPVS0eLR5KCmBEkGHnSxwKQM0hwCSaL0TSaTMNT_GJQK1sT8hg@mail.gmail.com>
In-Reply-To: <CAPVS0eLR5KCmBEkGHnSxwKQM0hwCSaL0TSaTMNT_GJQK1sT8hg@mail.gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-31434-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F0FF9C7CE3
X-Rspamd-Action: no action

Ly8gc29ydCBwb3N0aW5nIGFzIGV4cGVjdGVkIChhdm9pZCB0b3AgcG9zdGluZykNCg0KSW9oYW5u
IFRhY2h5IDxpb2hhbm4udGFjaHlAZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAy
OSwgMjAyNiBhdCA5OjM24oCvUE0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdy
b3RlOg0KPiA+ID4NCj4gPiA+IElvaGFubiBUYWNoeSA8aW9oYW5uLnRhY2h5QGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4gPiA+IEdvb2QgbW9ybmluZywNCj4gPiA+ID4NCj4gPiA+ID4gQ3VycmVudGx5
IHRoZXJlJ3MgYW4gaXNzdWUgd2hlcmUgaXQncyBub3QgcG9zc2libGUgdG8gYnVpbGQgdGhlIHJ0
dzg5IGRyaXZlci4NCj4gPiA+ID4gVGhlIFJUTDg4NTJCRSBjYXJkIGhhcyBhIGNvbXBhdGliaWxp
dHkgcHJvYmxlbSB3aXRoIEludGVsIFg5OSBjaGlwc2V0DQo+ID4gPiA+IGFuZCBhIGhhY2tlZCBy
dHc4OSBkcml2ZXIgaXMgbmVlZGVkIHRvIG1ha2UgaXQgd29yay4NCj4gPiA+ID4NCj4gPiA+ID4g
SSBraW5kbHkgcmVxdWVzdCB0byByZWFkIHRoZSBHaXRodWIgaXNzdWU6DQo+ID4gPiA+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OS9pc3N1ZXMvMzk2DQo+ID4gPg0KPiA+ID4gQSBm
aXggaW4gR2l0aHViIGlzIHRvIGRpc2FibGUgMzYtYml0IERNQSBbMV0uIEknZCBsaWtlIHRvIGNv
bGxlY3QgcGxhdGZvcm0NCj4gPiA+IGluZm8gdG8gYWRkIGEgcXVpcmsuIFBsZWFzZSBzaGFyZSBv
dXRwdXRzIG9mIGJlbG93IGNvbW1hbmRzDQo+ID4gPiAgLSBkbWlkZWNvZGUNCj4gPiA+ICAtIGxz
cGNpIC12dA0KPiA+ID4gIC0gbHNwY2kgLXgNCj4gPiA+DQo+ID4gPiBbMV0gaHR0cHM6Ly9naXRo
dWIuY29tL2E1YTVhYTU1NW9vL3J0dzg5LTEvY29tbWl0LzYyOTc1NmVlMDIzMjA4OWQyOThiYjM5
ODc5MGQ0YTc0NWI5NTAwNTgNCj4gPiA+DQo+ID4gPg0KPiBPbiBGcmksIEphbiAzMCwgMjAyNiBh
dCAxOjU44oCvUE0gSW9oYW5uIFRhY2h5IDxpb2hhbm4udGFjaHlAZ21haWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEdvb2QgYWZ0ZXJub29uIQ0KPiA+IEknbGwgcnVuIHRoZSAiIC0gZG1pZGVjb2Rl
DQo+ID4gIC0gbHNwY2kgLXZ0DQo+ID4gIC0gbHNwY2kgLXgiDQo+ID4gY29tbWFuZHMgdG9kYXkg
ZXZlbmluZy4NCj4gPiBhbmQgSSdsbCBsZXQgeW91IGtub3cgd2hhdCdzIHRoZSBvdXRwdXQgcmVz
dWx0cy4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gSW9oYW5uDQo+ID4NCj4gR29vZCBldmVuaW5n
LA0KPiANCj4gSSBhdHRhY2hlZCB0aGUgcmVzdWx0cyBvZiB0aGUgY29tbWFuZHMgeW91IHJlcXVl
c3RlZC4NCj4gDQoNCkkgc2VudCBhIHBhdGNoIHRvIGF2b2lkIDM2LWJpdCBETUEgYXMgZ2l0aHVi
IGRpZCBpZiB0aGUgZHJpdmVyIGlzIHJ1bm5pbmcgb24NCnlvdXIgbW90aGVyYm9hcmQgWDk5LiBQ
bGVhc2UgcmV2ZXJ0IHRoZSBwYXRjaCB5b3UgbWVudGlvbmVkIGZyb20gZ2l0aHViLCBhbmQNCmFw
cGx5IHRoaXMgb25lIHRvIHNlZSBpZiBpdCBjYW4gd29yayB0byB5b3UuDQoNCkkgZGVjaWRlIHRv
IG5vdCBjaG9vc2UgUENJIGJyaWRnZSBhcyBhIHF1aXJrIHJ1bGUsIGJlY2F1c2UgdGhlIFBDSSBi
cmlkZ2UNCiJJbnRlbCBDb3Jwb3JhdGlvbiA4IFNlcmllcy9DMjIwIFNlcmllcyBDaGlwc2V0IEZh
bWlseSBQQ0kgRXhwcmVzcyBSb290IFBvcnQiDQppcyBpbiBjb21tb24gdXNlLCBhbmQgSSBiZWxp
ZXZlIG90aGVyIGJvYXJkcyB1c2luZyB0aGlzIGJyaWRnZSBjYW4gd29yayB3aXRoDQpSVEw4ODUy
QkUuDQoNCkFub3RoZXIsIEkgYXNzdW1lIHlvdSBpbnN0YWxsZWQgUlRMODg1MkJFIG9uIFg5OSBw
ZXJzb25hbGx5LCBub3QgcHJlLWluc3RhbGxlZA0Kb24gdGhlIGJvYXJkIHdoZW4geW91IHB1cmNo
YXNlZCwgcmlnaHQ/DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVz
cy8yMDI2MDIwMjAxNDA0OS4xMTc4My0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNCg0K

