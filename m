Return-Path: <linux-wireless+bounces-32943-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPiYDvXRsGmLnQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32943-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:22:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6925AE6E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDCF3055424
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11F28B4E2;
	Wed, 11 Mar 2026 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="J1chSZYk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4881B86C7;
	Wed, 11 Mar 2026 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195664; cv=none; b=Ke3dzlvBjmMf7f91tqhGkCdE37CaDShfINrU5Ct64DHK4ydKfiP4P+B1C65XxNyoWtnMcWxvV+eg0kEJU1inXbxAeFJNKFb9XBK9HmnXp8/utvtH4VMjjgTkwMn+VtJjhS/gFY2uWScz/EqkYVOQpH1aeLixcJiF+RgFvuQNqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195664; c=relaxed/simple;
	bh=ajH94EuOPM+/QHVAooU7sW4YuYSNMBs/6UvKcIuad70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lRoKj2M/pa7gQ49Noj36CSt1LQNJTWkXVB5hgoGIPfMwZs2fTfoRWtwLuXJc8MikAxv19XsV2uChO1gk4/On7OaXHdLm0iJoJdQ52pgF7RpFbNXubUdSWyXm3E/wC95qMTKOftugIHBVI0d//DpM407W0IleUu5wq8GD1SzilW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=J1chSZYk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62B2KxPrA3717405, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773195659; bh=ajH94EuOPM+/QHVAooU7sW4YuYSNMBs/6UvKcIuad70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=J1chSZYkcUHlVs0AaNLCCp9Fj5vYIbUEfYp9ZlckdzxyWTL/eJC0NdMdx0AqUTI4Q
	 hujJ9i4+NKE82vl4Yah07bv/LO4jmM/UU+MoecSFgjYSEt44t87ksRmkBDjs29dJav
	 cKesWkQ/3zzZKOby8w2EZJ0S+b+elh+AmnasiQVMVE4mI5EfyRbpOPwHqwogEmMOI9
	 t/cLIV2hgD9IO0bdewupM+GxoFAkwaYmAlZZ+/tetZ/lxrBj4CsqKoOuXwCRh/hBTt
	 JP3+ime3HWmqPn/q4fi7bdFM0Ep+WFll12KddGWfW5aig5p1wXbkdE10ttZ7hlbuLc
	 Hvu8x1e5Ao6mw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62B2KxPrA3717405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 10:20:59 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Mar 2026 10:20:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 11 Mar 2026 10:20:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Mar 2026 10:20:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAEYMgIABP2wQ
Date: Wed, 11 Mar 2026 02:20:58 +0000
Message-ID: <81bd047d223a41169e4526b5c7c19976@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <CALdGYqSz3SNzoSjUQvK6FgTc2Xkac52=T5A7Lt=d+nxAXGgJVw@mail.gmail.com>
In-Reply-To: <CALdGYqSz3SNzoSjUQvK6FgTc2Xkac52=T5A7Lt=d+nxAXGgJVw@mail.gmail.com>
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
X-Rspamd-Queue-Id: AFC6925AE6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32943-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid];
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
X-Rspamd-Action: no action

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGkgUGluZy1LZSwNCj4gDQo+
IFRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZS4gVG8gcHJvdmlkZSB5b3Ugd2l0aCB0aGUgY2xl
YW5lc3QgcG9zc2libGUNCj4gZGlhZ25vc3RpYyBkYXRhLCB3ZSBkZXZpc2VkIGEgc3RyaWN0IHRl
c3RpbmcgZW52aXJvbm1lbnQ6DQo+IA0KPiAxLiAqKkxpdmUgVVNCIEVudmlyb25tZW50OioqIFdl
IGJvb3RlZCBhIGNvbXBsZXRlbHkgZnJlc2ggTGl2ZSBVU0Igb2YNCj4gQ2FjaHlPUyAoS2VybmVs
IDYuMTkuNikgdG8gZWxpbWluYXRlIGFueSBwb3RlbnRpYWwgaW50ZXJmZXJlbmNlIGZyb20NCj4g
aW5zdGFsbGVkIHNvZnR3YXJlLCBUTFAgcHJvZmlsZXMsIG9yIGN1c3RvbSBOZXR3b3JrTWFuYWdl
cg0KPiBjb25maWd1cmF0aW9ucy4NCj4gMi4gKipBZ2dyZXNzaXZlIExvY2FsIExvZ2dpbmc6Kiog
QmVjYXVzZSB0aGUgc3lzdGVtIGZyZWV6ZSBwaHlzaWNhbGx5DQo+IGxvY2tzIHRoZSBQQ0llIGJ1
cyBhbmQgZGlzYWJsZXMgdGhlIFdpLUZpIGFkYXB0ZXIgaW5zdGFudGx5LCB1c2luZw0KPiBgbmV0
Y29uc29sZWAgd2FzIGltcG9zc2libGUgKHRoZSBuZXR3b3JrIGRyb3BzIG1pY3Jvc2Vjb25kcyBi
ZWZvcmUgdGhlDQo+IGZyZWV6ZSkuDQo+IA0KPiBUbyBvdmVyY29tZSB0aGlzLCB3ZSB3cm90ZSBh
biAiYWdncmVzc2l2ZSBsb2dnZXIiIHNjcmlwdCB0aGF0IHBpcGVzDQo+IGBkbWVzZyAtd2AgZGly
ZWN0bHkgdG8gYW4gaW5kZXBlbmRlbnQgRkFUMzIgVVNCIGRyaXZlIHdoaWxlIGlzc3VpbmcgYQ0K
PiBgc3luY2AgY29tbWFuZCB0d2ljZSBhIHNlY29uZC4gVGhpcyBieXBhc3NlZCBSQU0gY2FjaGlu
ZyBhbmQNCj4gcGh5c2ljYWxseSBidXJuZWQgdGhlIGxvZ3MgdG8gdGhlIGRyaXZlIHJpZ2h0IHVw
IHRvIHRoZSBtb21lbnQgb2YgdGhlDQo+IGhhcmQgZnJlZXplLiBUaGUgc2NyaXB0IHdlIHVzZWQg
d2FzOg0KPiANCj4gYGBgYmFzaA0KPiAjIS9iaW4vYmFzaA0KPiBMT0dfRklMRT0iL3J1bi9tZWRp
YS9saXZldXNlci9MT0dTL2tlcm5lbF9mcmVlemUubG9nIg0KPiBkbWVzZyAtdyA+ICIkTE9HX0ZJ
TEUiICYNCj4gd2hpbGUgdHJ1ZTsgZG8NCj4gICAgIHN5bmMNCj4gICAgIHNsZWVwIDAuNQ0KPiBk
b25lDQo+IGBgYA0KPiANCj4gMy4gTm8gd29ya2Fyb3VuZHMgKGBkaXNhYmxlX2FzcG09bmAsIGBk
aXNhYmxlX2xwc19kZWVwPW5gKSB3ZXJlIGFjdGl2ZQ0KPiBpbiB0aGlzIHRlc3QuIFdlIG1hbnVh
bGx5IGVuYWJsZWQgcG93ZXIgc2F2aW5nIChgaXcgZGV2IHdsYW4wIHNldA0KPiBwb3dlcl9zYXZl
IG9uYCkgYW5kIHRyaWdnZXJlZCB0aGUgZnJlZXplIHZpYSB0eXBpY2FsIHdlYiBicm93c2luZy4N
Cj4gDQo+IEhlcmUgYXJlIHRoZSBwcmVjaXNlLCB1bmFkdWx0ZXJhdGVkIGxvZ3Mgc2hvd2luZyB0
aGUgYWRhcHRlcg0KPiBzdWNjZXNzZnVsbHkgY29ubmVjdGluZyB0byB0aGUgbmV0d29yaywgc2l0
dGluZyBpZGxlIGZvciBhYm91dCAxMA0KPiBzZWNvbmRzIChwcmVzdW1hYmx5IGVudGVyaW5nIHBv
d2VyLXNhdmluZyBzdGF0ZXMpLCBhbmQgdGhlbiBzdWZmZXJpbmcNCj4gYSBmYXRhbCBmaXJtd2Fy
ZSBsb2NrdXAgcmlnaHQgYmVmb3JlIHRoZSBQQ0llIGJ1cyBmcm96ZToNCj4gDQo+IGBgYA0KPiBb
ICAzMDQuNzA5MjAxXSBhdWRpdDogdHlwZT0xMTExIC4uLiBvcD1jb25uZWN0aW9uLWFkZC1hY3Rp
dmF0ZSAuLi4NCj4gbmFtZT0iQW5kcmV5XzVHIiAuLi4NCj4gWyAgMzA1LjYxNzc4NV0gd2xhbjA6
IGF1dGhlbnRpY2F0ZSB3aXRoIDZjOjY4OmE0OjFjOjk3OjViIC4uLg0KPiBbICAzMDUuNjYwMzMz
XSB3bGFuMDogYXV0aGVudGljYXRlZA0KPiBbICAzMDUuNjYxNjYxXSB3bGFuMDogYXNzb2NpYXRl
IHdpdGggNmM6Njg6YTQ6MWM6OTc6NWIgKHRyeSAxLzMpDQo+IFsgIDMwNS42NjM0MDRdIHdsYW4w
OiBhc3NvY2lhdGVkDQo+IFsgIDMwNS43MTk5OTddIHdsYW4wOiBMaW1pdGluZyBUWCBwb3dlciB0
byAzMCAoMzAgLSAwKSBkQm0gYXMNCj4gYWR2ZXJ0aXNlZCBieSA2Yzo2ODphNDoxYzo5Nzo1Yg0K
PiAuLi4gKH4xMCBzZWNvbmRzIG9mIGlkbGUgbmV0d29yayB0aW1lKSAuLi4NCj4gWyAgMzE2Ljkw
NzExNF0gcnR3ODhfODgyMWNlIDAwMDA6MTM6MDAuMDogZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1h
bmQNCj4gWyAgMzE2LjkxMTE5MF0gcnR3ODhfODgyMWNlIDAwMDA6MTM6MDAuMDogZmFpbGVkIHRv
IHNlbmQgaDJjIGNvbW1hbmQNCj4gWyAgMzE2LjkyMTUwNF0gcnR3ODhfODgyMWNlIDAwMDA6MTM6
MDAuMDogY29leCByZXF1ZXN0IHRpbWUgb3V0DQo+IC4uLg0KPiBbICAzNDkuNjMwOTUyXSBydHc4
OF84ODIxY2UgMDAwMDoxMzowMC4wOiBmYWlsZWQgdG8gc2VuZCBoMmMgY29tbWFuZA0KPiBbICAz
NDkuNjM1MDIzXSBydHc4OF84ODIxY2UgMDAwMDoxMzowMC4wOiBmYWlsZWQgdG8gc2VuZCBoMmMg
Y29tbWFuZA0KPiBbICAzNTcuODExMjM1XSBydHc4OF84ODIxY2UgMDAwMDoxMzowMC4wOiBmaXJt
d2FyZSBmYWlsZWQgdG8gbGVhdmUgbHBzIHN0YXRlDQo+IFsgIDM1OS43OTcyMzhdIHJ0dzg4Xzg4
MjFjZSAwMDAwOjEzOjAwLjA6IGZpcm13YXJlIGZhaWxlZCB0byBsZWF2ZSBscHMgc3RhdGUNCj4g
Li4uIChyZXBlYXRzIGluZGVmaW5pdGVseSB1bnRpbCBoYXJkIHJlc2V0KSAuLi4NCj4gYGBgDQoN
Ckp1c3Qgd2FudCB0byBjbGFyaWZ5IHRoYXQgdGhlc2UgbG9ncyBvbmx5IGFwcGVhciBpbiB0ZXN0
IDMsIHJpZ2h0Pw0KTm8gdGhlc2UgbG9ncyBpbiB0ZXN0IDEvMi4gDQoNCj4gDQo+IEFzIHRoZSBs
b2dzIGNsZWFybHkgZGVtb25zdHJhdGUsIHRoZSBhZGFwdGVyIGF1dGhlbnRpY2F0ZXMgcGVyZmVj
dGx5DQo+IGJ1dCB0aGUgZmlybXdhcmUgZXhwbGljaXRseSBmYWlscyB0byBsZWF2ZSB0aGUgTFBT
IHN0YXRlIGFmdGVyIGEgYnJpZWYNCj4gaWRsZSBwZXJpb2QsIGRyb3BwaW5nIGFsbCBIMkMgY29t
bWFuZHMgaW1tZWRpYXRlbHkgYmVmb3JlIHRoZQ0KPiBzeXN0ZW0td2lkZSBoYXJkIGZyZWV6ZSBi
ZWdpbnMuDQo+IA0KPiBXZSB3aWxsIHVwbG9hZCB0aGUgZnVsbCwgdW5hYnJpZGdlZCBgLmxvZ2Ag
ZmlsZSB0byBvdXIgQnVnemlsbGEgdGhyZWFkDQo+IChCdWcgMjIxMTk1KSBtb21lbnRhcmlseSwg
YnV0IHdlIHdhbnRlZCB0byBwcm92aWRlIHlvdSB3aXRoIHRoaXMgZXhhY3QNCj4gJ3Ntb2tpbmcg
Z3VuJyB0cmFjZSByaWdodCBhd2F5IHRvIGhlbHAgaWRlbnRpZnkgdGhlIHJvb3QgY2F1c2UuDQo+
IA0KPiBQbGVhc2UgbGV0IHVzIGtub3cgaWYgdGhpcyBpbmZvcm1hdGlvbiBpcyBoZWxwZnVsIG9y
IGlmIHRoZXJlIGFyZSBhbnkNCj4gc3BlY2lmaWMgbW9kdWxlIHBhdGNoZXMgb3IgZnVydGhlciB0
ZXN0cyB5b3Ugd291bGQgbGlrZSB1cyB0byBwZXJmb3JtDQo+IHRvIGFzc2lzdCB3aXRoIGRlYnVn
Z2luZy4NCg0KVGhhbmtzIGZvciB5b3VyIGRldGFpbCB0ZXN0cyBhbmQgbG9ncy4gV2l0aCB0aGlz
IGtpbmQgb2YgaGFyZHdhcmUgcHJvYmxlbSwNCnRvIGRpZyB0aGUgY2F1c2UsIHdlIG5lZWQgcmVh
bCBoYXJkd2FyZSBhbmQgaGFyZHdhcmUgc2NvcGUgdG8gbWVhc3VyZQ0Kc2lnbmFscy4gSSdkIGFw
cGx5IHF1aXJrIG9yIHNvbWUgdmFsaWRhdGlvbnMgb24gUlggcGF0aC4gVGhhdCdkIGJlIGENCmJl
dHRlciB3YXkuDQoNClBpbmctS2UNCg0K

