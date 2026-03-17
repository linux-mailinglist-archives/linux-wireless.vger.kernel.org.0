Return-Path: <linux-wireless+bounces-33320-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAx7BAOvuGmHhgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33320-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:31:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45B2A28FB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B33230156FE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15D3358B1;
	Tue, 17 Mar 2026 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s78qJ1KV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF749433AD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711104; cv=none; b=FMwUiFv6QpwhN5jDEs51vMVdv0Savw8oAYh+Ux/u3pP1RDJ2vUBEfCUmBT8gF4JrizNyCAmOvGQFH9EXZGJUE6eUCjnvoQxPX2ZgrxxHJ33Q3N6UiPz0a5P5V23x+22ecKmQuo4RCgXxSoc9p+UXO7f3rNHjgS+UDZu3yRjru/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711104; c=relaxed/simple;
	bh=i5Zm76no40njfDsvZX51W+eLA1JI2CHJshjLCa1Lyuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YUip9PqRskZct4ykUYJJjd8sOX8In1ravO0+oE7k0P7kHKUx/J+UxzDqCwqex6FI913sZaOCJK8ghqHF4L4D2UDUqwVQikDSOOZr0Io/HAvbjR7tjUli1gjRptnsjAZURd73UX2jHXGc55vg0iHYP7pQp7+zEQi5PsDbZ+FW/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s78qJ1KV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H1VdwqE2989230, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773711099; bh=i5Zm76no40njfDsvZX51W+eLA1JI2CHJshjLCa1Lyuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=s78qJ1KVjhPN3CviodXTc+IsetFRof3El76fMujj1eK1cZjkP52kXLJZllXt54yh0
	 8HmP2cVybLyQuO+YVkZQLBQQffKFkQy41RfTl6NmKcT1XD2qrHVtxFfZZwEns7EH+8
	 jOwWOxqloJVSndv4v1n5bJGSeXQQKFiU/mkEG4drYGiXJN45wZ1TN3riW2iVhJMwvD
	 x6MelrE43hTMA0qHFHp7W3nu+yyZ/3nTZxpTHXhMdAXb9A9P5FI+4gDR5hXAXtV1w3
	 XTZ7oLJnvrewy+Zr1EOAfH4lBqdqenKa7zdGPihsaTUM7Jo4H2VT29DswOTUFswNKY
	 3i09+U/MoswSQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H1VdwqE2989230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 09:31:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 09:31:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 09:31:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 17 Mar 2026 09:31:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: add quirks to disable PCI ASPM and
 deep LPS for HP P3S95EA#ACB
Thread-Topic: [PATCH rtw-next] wifi: rtw88: add quirks to disable PCI ASPM and
 deep LPS for HP P3S95EA#ACB
Thread-Index: AQHctPkQS7NABCdNL02knReuSyI7S7WxX4WAgACRZmA=
Date: Tue, 17 Mar 2026 01:31:37 +0000
Message-ID: <c4b1b177a7a04e11b89c6f67166ef409@realtek.com>
References: <20260316035635.16550-1-pkshih@realtek.com>
 <CALdGYqTbH1NVW7HT8JaUJ2xay5190WmpOm1TH7YJP9LfoHoFLw@mail.gmail.com>
In-Reply-To: <CALdGYqTbH1NVW7HT8JaUJ2xay5190WmpOm1TH7YJP9LfoHoFLw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-33320-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F45B2A28FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+IE9uIGFuIEhQIGxhcHRvcCAoUDNTOTVFQSNBQ0Ip
IGVxdWlwcGVkIHdpdGggYSBSZWFsdGVrIFJUTDg4MjFDRSA4MDIuMTFhYw0KPiA+IFBDSWUgYWRh
cHRlciAoUENJIElEOiAxMGVjOmM4MjEpLCB0aGUgc3lzdGVtIGV4cGVyaWVuY2VzIGEgaGFyZCBs
b2NrdXANCj4gPiAoY29tcGxldGUgZnJlZXplIG9mIHRoZSBVSSBhbmQga2VybmVsLCBzeXNycSBk
b2Vzbid0IHdvcmssIHJlcXVpcmVzDQo+ID4gaG9sZGluZyB0aGUgcG93ZXIgYnV0dG9uKSB3aGVu
IHRoZSBXaUZpIGFkYXB0ZXIgZW50ZXJzIHRoZSBwb3dlcg0KPiA+IHNhdmluZyBzdGF0ZS4gRGlz
YWJsZSBQQ0kgQVNQTSB0byBhdm9pZCBzeXN0ZW0gZnJlZXplLg0KPiA+IEluIGFkZGl0aW9uLCBk
cml2ZXIgdGhyb3dzIG1lc3NhZ2VzIHBlcmlvZGljYWxseS4gVGhvdWdoIHRoaXMgZG9lc24ndA0K
PiA+IGFsd2F5cyBjYXVzZSB1bnN0YWJsZSBjb25uZWN0aW9uLCBtaXNzaW5nIEgyQyBjb21tYW5k
cyBtaWdodCBjYXVzZQ0KPiA+IHVucHJlZGljdGFibGUgcmVzdWx0cy4gRGlzYWJsZSBkZWVwIExQ
UyB0byBhdm9pZCB0aGlzIGFzIHdlbGwuDQo+IA0KPiBUZXN0ZWQgb24gSFAgTm90ZWJvb2sgUDNT
OTVFQSNBQ0IgKGtlcm5lbCA2LjE5LjctMS1jYWNoeW9zKToNCj4gDQo+ICAgLSBObyBoYXJkIGZy
ZWV6ZSBvYnNlcnZlZCBkdXJpbmcgaWRsZSBvciBhY3RpdmUgdXNhZ2UuDQo+ICAgLSBaZXJvIGgy
YyBvciBscHMgZXJyb3JzIGluIGRtZXNnIGFjcm9zcyBpZGxlICgxMCBtaW4pLA0KPiAgICAgbG9h
ZCBzdHJlc3MgKDEwME1CIGRvd25sb2FkKSwgYW5kIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLg0KPiAg
IC0gQm90aCBxdWlyayBmbGFncyBjb25maXJtZWQgYWN0aXZlIHZpYSBzeXNmcyB3aXRob3V0IGFu
eQ0KPiAgICAgbWFudWFsIG1vZHByb2JlIHBhcmFtZXRlcnMuDQoNClRoYW5rcyBmb3IgeW91ciB0
ZXN0LiBJJ2QgYWRkIHRoaXMgaW5mb3JtYXRpb24gdG8gY29tbWl0IG1lc3NhZ2UNCmR1cmluZyBn
ZXR0aW5nIG1lcmdlZC4gDQoNCj4gDQo+IFRlc3RlZC1ieTogT2xla3NhbmRyIEhhdnJ5bG92IDxn
b2FpbndvQGdtYWlsLmNvbT4NCj4gDQoNCkFzIHdlbGwgYXMgeW91ciBUZXN0ZWQtYnkuDQoNClBp
bmctS2UNCg0K

