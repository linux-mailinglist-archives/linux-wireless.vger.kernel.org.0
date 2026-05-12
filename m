Return-Path: <linux-wireless+bounces-36272-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOnNNQx4AmpotQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36272-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:45:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD4517EDC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CDB3017275
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01E223DCE;
	Tue, 12 May 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hNHYECdW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C751448D5;
	Tue, 12 May 2026 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546697; cv=none; b=Qshy2cEz4riQKvlcX9MarxG0501uPaWq56kEORfwuLLfs/Ftr16d+MjcY1hdVOgYvlPKfjqgyQV6XqnApyC/mv4E3CUA8zw5O5HR7dfbKdw0p295GjRVjF+LbhPl5xt9YsbXTLEno9jUNbeq+KLc7RIRoiZhnLKvLT05dLVzuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546697; c=relaxed/simple;
	bh=sseY+/jo8EDcFzjLtSuyFmopibhtbUEYPlr0n3PPu5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNsowRUZz7dQMEYJ8XhZlMoIk5nvHlTYHUgdEKXIEWfihHh2eb/mBkzEbkW79t46QImj5H08l18tro/MOeF83n0nqndtnlnGrlmyU3jqLCQnM56RtZLKdg2xbJYdhhUb5+2oKqi6pMTAw0s/JW16N7H/utfBwXdmT0yuqiXXmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hNHYECdW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C0ieEeB3412887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778546680; bh=sseY+/jo8EDcFzjLtSuyFmopibhtbUEYPlr0n3PPu5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hNHYECdW3RN3+I1jYu+xQePdx2j/Znh/v+hEl+OBfqqNRT1caw0A/4ly7UMxo/5H7
	 LTSSG9Cs/gOkJVLcF/CA4Vyu+mGImzdfRTypd+K8sRS5BiUKoW/EjZ93axTsRTsnuI
	 +APgeY3SF9AfCNi4yJafoZUs0w4569jVUVEHuBIYhwmFgHOJVZHZdLRpbATfvx2ijM
	 dBE0M6YU/GkfPmLSduH61ReZRh3CSktYEiRIGmWoXjzfvsnNJPH/6XIO48iJaLzq0X
	 CQnZU0rI0tdvZ0ZOxKP9cEFqoU38GKocTVQAl9NM/K92aQ3Y0XyUaGo4q3KMDowv8j
	 3rp0veFTvoRhQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C0ieEeB3412887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 08:44:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 08:44:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 08:44:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 12 May 2026 08:44:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "art1310@proton.me" <art1310@proton.me>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: RE: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum supported
 channel width
Thread-Topic: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum supported
 channel width
Thread-Index: AQHc19AdbF1YRPFzdU66bhcRCp5GbrYAJkIAgAgQNgCAAWlB8A==
Date: Tue, 12 May 2026 00:44:40 +0000
Message-ID: <f26992e669744e6f87084e017f897275@realtek.com>
References: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
 <ee88b3a2-2cc9-4370-b782-189a603a7fa1@RTKEXHMBS04.realtek.com.tw>
 <41693ffc-926c-4e67-9a48-b6e1b1d150bd@leemhuis.info>
In-Reply-To: <41693ffc-926c-4e67-9a48-b6e1b1d150bd@leemhuis.info>
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
X-Rspamd-Queue-Id: 27AD4517EDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36272-lists,linux-wireless=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,proton.me,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

VGhvcnN0ZW4gTGVlbWh1aXMgPGxpbnV4QGxlZW1odWlzLmluZm8+IHdyb3RlOg0KPiBPbiA1LzYv
MjYgMDk6NTcsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gU29tZSBkZXZpY2VzIG1hbGZ1
bmN0aW9uIHdoZW4gY29ubmVjdGVkIHRvIGEgbmV0d29yayB3aXRoIDQwIE1IeiBjaGFubmVsDQo+
ID4+IHdpZHRoLCBiZWNhdXNlIHRoZXkgZG9uJ3Qgc3VwcG9ydCB0aGF0Lg0KPiA+Pg0KPiA+PiBS
VEw4MTg4RlUsIFJUTDgxOTJGVSwgYW5kIFJUTDg3MTBCVSAoUlRMODE4OEdVKSBoYXZlIGEgd2F5
IHRvIHNpZ25hbA0KPiA+PiB0aGlzIChhbmQgc29tZSBvdGhlciBjYXBhYmlsaXRpZXMpIHRvIHRo
ZSBkcml2ZXIuIEdldCB0aGlzIGluZm9ybWF0aW9uDQo+ID4+IGZyb20gdGhlIGhhcmR3YXJlIGFu
ZCBhZHZlcnRpc2UgNDAgTUh6IHN1cHBvcnQgb25seSB3aGVuIHRoZSBoYXJkd2FyZQ0KPiA+PiBj
YW4gaGFuZGxlIGl0LiBXZSBhc3N1bWUgdGhlIG90aGVyIGNoaXBzIGNhbiBhbHdheXMgaGFuZGxl
IGl0Lg0KPiA+Pg0KPiA+PiBSVEw4NzEwQlUgbmVlZHMgYSBkaWZmZXJlbnQgd2F5IHRvIHJldHJp
ZXZlIHRoaXMgaW5mb3JtYXRpb24sIHdoaWNoIHdpbGwNCj4gPj4gYmUgaW1wbGVtZW50ZWQgc29t
ZSBvdGhlciB0aW1lLg0KPiA+Pg0KPiA+PiBGaXhlczogZGJmOWI3YmIwZWRmICgid2lmaTogcnRs
OHh4eHU6IEVuYWJsZSA0MCBNSHogd2lkdGggYnkgZGVmYXVsdCIpDQo+ID4+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4+IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0yMjEzOTQNCj4gPj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBT
bWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQo+IFRoeCBmb3IgZml4aW5nIHRoaXMhDQo+
IA0KPiA+IDEgcGF0Y2goZXMpIGFwcGxpZWQgdG8gcnR3LW5leHQgYnJhbmNoIG9mIHJ0dy5naXQs
IHRoYW5rcy4NCj4gPiBlZjc3MWVhYmM3OWQgd2lmaTogcnRsOHh4eHU6IERldGVjdCB0aGUgbWF4
aW11bSBzdXBwb3J0ZWQgY2hhbm5lbCB3aWR0aA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9wa3No
aWgvcnR3LmdpdA0KPiANCj4gcnR3LW5leHQgc291bmRzIGxpa2UgaXQgYWltcyBmb3IgdGhlIG5l
eHQgbWVyZ2Ugd2luZG93OyBhbmQgaXQgc2VlbXMgdGhlDQo+IGZpeCBoYXNuJ3QgZXZlbiBoaXQg
LW5leHQgeWV0LiBUaGlzIGlzIHNsaWdodGx5IHVuZm9ydHVuYXRlLCBhcyB0aGlzDQo+IGFmYWlj
cyBpcyBhIGZpeCBmb3IgYSByZWNlbnQgcmVncmVzc2lvbiAtLSBzbyBpdCBpZGVhbGx5IHNob3Vs
ZCBoZWFkDQo+IHRvd2FyZHMgbWFpbmxpbmUgYnkgbm93WzFdLCBhcyBMaW51cycgdGhlIHJ1bGUg
b2YgdGh1bWIgaXMgdG8gImdlbmVyYWxseQ0KPiBmaXggcmVncmVzc2lvbnMgIndpdGhpbiBhIHdl
ZWsiLCBwcmVmZXJhYmx5IGJlZm9yZSB0aGUgbmV4dCByYyJbMV0uDQo+IA0KPiBPciBhbSBJIG1p
c3Npbmcgc29tZXRoaW5nPyBUaGF0IG1pZ2h0IHZlcnkgd2VsbCBiZSB0aGUgY2FzZSwgc28gZG8g
bm90DQo+IGhlc2l0YXRlIHRvIHRlbGwgbWUhDQoNCkFzIHRoaXMgcGF0Y2ggYXBwbGllZCB0byBw
dWJsaWMgcnR3IHRyZWUsIGFuZCBwZW9wbGUgd2hvIGVuY291bnRlcmVkIHRoZQ0KcHJvYmxlbSBp
biBidWd6aWxsYSBjYW4gd29yayBhZ2Fpbi4gVG8gcHJldmVudCBicmVha2luZyB0aGUgcHVibGlj
IHRyZWUsDQpJJ2Qga2VlcCBpdCBhcyB3YXMuDQoNCkkgd2lsbCBiZSBjYXJlZnVsbHkgdG8gaGFu
ZGxlIHRoaXMga2luZCBvZiBwYXRjaGVzIGxhdGVyLiANCg0KUGluZy1LZQ0KDQo=

