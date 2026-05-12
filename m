Return-Path: <linux-wireless+bounces-36312-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFwwNtzmAmpEyQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36312-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:37:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCB51CD0F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CAE43088DBE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62003492505;
	Tue, 12 May 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="t8u2cEa/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A9492514;
	Tue, 12 May 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574747; cv=none; b=kyORYYTKFWCK/G2Kev06PNXf+ncyv2cZajq/mWwxbHu8R9O0Agpt+KL40nYLJ0EH/AmX8yUljgWcMjCrSdjvUgJGwaJy4IdxrAVAGPw1ve+Rx4ICftljJZZsmlDRMmEjMmiwMCXG5jxq0x4zQNVtuyQQPWk8C9e73Ys1hA6l35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574747; c=relaxed/simple;
	bh=lhC6FGHVTldczQBnXN69+M2T0emEbfSX+YIiX7+rU+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7CgzMdjmKIdAs7Eou+qoZ+xgRPPgaF7KL+lFXl9fBWUJfcK8ZNziwpHUxC/0PLsrSs+CgnR7nDmCN4CMdSVf37q75/P1kQMcJf4oAndgvsoS8Ie+FCiu2/o2k0iDJISSflCHhkDFVwJNntkWUtELONQyXac6zrHXMgF2F3vwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=t8u2cEa/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C8WBJp83817931, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778574731; bh=lhC6FGHVTldczQBnXN69+M2T0emEbfSX+YIiX7+rU+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=t8u2cEa/Yt9JAtKwdBlgVe4L8yhbcf4oHmHIcn5dv8RjqfoEdVauCQ2/amdgzVJEx
	 WHT9SiSx7oLKOC1Mjs2tjjNbOi02voaIUWM4CE0hB1Cc6swpO8J7UPiw6GKToU8QIr
	 jtZwtcrBO2HZ+FdIVXKAhCNug4yQw/4oOczZRGiAoBO3sfIkY/Hv0aIAmz3rMssXZe
	 6kXt//AxwRAK0AMCu+kLXZWPiw/EVIssh69ktiVCHbtv3BxPff1Z0Ok0LRIl8P3sI4
	 FjxDIoliySzGZVMRdQm1yrftyUCj4gQ2gFRdjO7V0SRfWDcNkQ1nvs475wqxE+8lWi
	 4wglzzo4ggF/w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C8WBJp83817931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 16:32:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 16:32:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 16:32:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 12 May 2026 16:32:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
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
Thread-Index: AQHc19AdbF1YRPFzdU66bhcRCp5GbrYAJkIAgAgQNgCAAWlB8P//6UKAgACZGmA=
Date: Tue, 12 May 2026 08:32:11 +0000
Message-ID: <29a93dc3d9d24b3a809310694ffc5d34@realtek.com>
References: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
 <ee88b3a2-2cc9-4370-b782-189a603a7fa1@RTKEXHMBS04.realtek.com.tw>
 <41693ffc-926c-4e67-9a48-b6e1b1d150bd@leemhuis.info>
 <f26992e669744e6f87084e017f897275@realtek.com>
 <1cf071e9-5d3c-4d55-ac75-49eb4c461422@leemhuis.info>
In-Reply-To: <1cf071e9-5d3c-4d55-ac75-49eb4c461422@leemhuis.info>
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
X-Rspamd-Queue-Id: 3DBCB51CD0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36312-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,proton.me,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
X-Rspamd-Action: no action

VGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+IHdyb3RlOg0KPiBP
biA1LzEyLzI2IDAyOjQ0LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVGhvcnN0ZW4gTGVlbWh1
aXMgPGxpbnV4QGxlZW1odWlzLmluZm8+IHdyb3RlOg0KPiA+PiBPbiA1LzYvMjYgMDk6NTcsIFBp
bmctS2UgU2hpaCB3cm90ZToNCj4gPj4+IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJA
Z21haWwuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+Pj4gU29tZSBkZXZpY2VzIG1hbGZ1bmN0aW9u
IHdoZW4gY29ubmVjdGVkIHRvIGEgbmV0d29yayB3aXRoIDQwIE1IeiBjaGFubmVsDQo+ID4+Pj4g
d2lkdGgsIGJlY2F1c2UgdGhleSBkb24ndCBzdXBwb3J0IHRoYXQuDQo+ID4+Pj4NCj4gPj4+PiBS
VEw4MTg4RlUsIFJUTDgxOTJGVSwgYW5kIFJUTDg3MTBCVSAoUlRMODE4OEdVKSBoYXZlIGEgd2F5
IHRvIHNpZ25hbA0KPiA+Pj4+IHRoaXMgKGFuZCBzb21lIG90aGVyIGNhcGFiaWxpdGllcykgdG8g
dGhlIGRyaXZlci4gR2V0IHRoaXMgaW5mb3JtYXRpb24NCj4gPj4+PiBmcm9tIHRoZSBoYXJkd2Fy
ZSBhbmQgYWR2ZXJ0aXNlIDQwIE1IeiBzdXBwb3J0IG9ubHkgd2hlbiB0aGUgaGFyZHdhcmUNCj4g
Pj4+PiBjYW4gaGFuZGxlIGl0LiBXZSBhc3N1bWUgdGhlIG90aGVyIGNoaXBzIGNhbiBhbHdheXMg
aGFuZGxlIGl0Lg0KPiA+Pj4+DQo+ID4+Pj4gUlRMODcxMEJVIG5lZWRzIGEgZGlmZmVyZW50IHdh
eSB0byByZXRyaWV2ZSB0aGlzIGluZm9ybWF0aW9uLCB3aGljaCB3aWxsDQo+ID4+Pj4gYmUgaW1w
bGVtZW50ZWQgc29tZSBvdGhlciB0aW1lLg0KPiA+Pj4+DQo+ID4+Pj4gRml4ZXM6IGRiZjliN2Ji
MGVkZiAoIndpZmk6IHJ0bDh4eHh1OiBFbmFibGUgNDAgTUh6IHdpZHRoIGJ5IGRlZmF1bHQiKQ0K
PiA+Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+Pj4gQ2xvc2VzOiBodHRwczov
L2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIyMTM5NA0KPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+
Pj4+IFJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPj4N
Cj4gPj4gVGh4IGZvciBmaXhpbmcgdGhpcyENCj4gPj4NCj4gPj4+IDEgcGF0Y2goZXMpIGFwcGxp
ZWQgdG8gcnR3LW5leHQgYnJhbmNoIG9mIHJ0dy5naXQsIHRoYW5rcy4NCj4gPj4+IGVmNzcxZWFi
Yzc5ZCB3aWZpOiBydGw4eHh4dTogRGV0ZWN0IHRoZSBtYXhpbXVtIHN1cHBvcnRlZCBjaGFubmVs
IHdpZHRoDQo+ID4+PiBodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL3J0dy5naXQNCj4gPj4NCj4g
Pj4gcnR3LW5leHQgc291bmRzIGxpa2UgaXQgYWltcyBmb3IgdGhlIG5leHQgbWVyZ2Ugd2luZG93
OyBhbmQgaXQgc2VlbXMgdGhlDQo+ID4+IGZpeCBoYXNuJ3QgZXZlbiBoaXQgLW5leHQgeWV0LiBU
aGlzIGlzIHNsaWdodGx5IHVuZm9ydHVuYXRlLCBhcyB0aGlzDQo+ID4+IGFmYWljcyBpcyBhIGZp
eCBmb3IgYSByZWNlbnQgcmVncmVzc2lvbiAtLSBzbyBpdCBpZGVhbGx5IHNob3VsZCBoZWFkDQo+
ID4+IHRvd2FyZHMgbWFpbmxpbmUgYnkgbm93WzFdLCBhcyBMaW51cycgdGhlIHJ1bGUgb2YgdGh1
bWIgaXMgdG8gImdlbmVyYWxseQ0KPiA+PiBmaXggcmVncmVzc2lvbnMgIndpdGhpbiBhIHdlZWsi
LCBwcmVmZXJhYmx5IGJlZm9yZSB0aGUgbmV4dCByYyJbMV0uDQo+ID4+DQo+ID4+IE9yIGFtIEkg
bWlzc2luZyBzb21ldGhpbmc/IFRoYXQgbWlnaHQgdmVyeSB3ZWxsIGJlIHRoZSBjYXNlLCBzbyBk
byBub3QNCj4gPj4gaGVzaXRhdGUgdG8gdGVsbCBtZSENCj4gPg0KPiA+IEFzIHRoaXMgcGF0Y2gg
YXBwbGllZCB0byBwdWJsaWMgcnR3IHRyZWUsIGFuZCBwZW9wbGUgd2hvIGVuY291bnRlcmVkIHRo
ZQ0KPiA+IHByb2JsZW0gaW4gYnVnemlsbGEgY2FuIHdvcmsgYWdhaW4uIFRvIHByZXZlbnQgYnJl
YWtpbmcgdGhlIHB1YmxpYyB0cmVlLA0KPiA+IEknZCBrZWVwIGl0IGFzIHdhcy4NCj4gDQo+IEkn
bSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHkuDQo+IA0KPiBEbyB5b3UgbWVh
biBzb21ldGhpbmcgbGlrZSAidGhlIGZpeCBpcyBub3cgaW4gdGhlIHJ0dy1uZXh0IHRyZWUsIHNv
IEkNCj4gY2FuJ3QgbWFpbmxpbmUgaXQgbm93LCBhcyB0aGlzIHdvdWxkIGJyZWFrIHRoZSBydHct
bmV4dCI/IEJ1dCB3aHk/DQoNClllcy4gKEkgbWVhbnQgcnR3LW5leHQgdHJlZSkNCg0KPiBZb3UN
Cj4gY2FuIGNoZXJyeS1waWNrIG9yIGRpcmVjdGx5IGFwcGx5IHRoZSBmaXggdG8gYSBwZW5kaW5n
IGJyYW5jaCAob3IgZXZlbg0KPiBhc2sgTGludXMgdG8gbWVyZ2UgaXQgZGlyZWN0bHkgZnJvbSB0
aGUgbGlzdCwgYnV0IHRoYXQgaXMgbGlrZWx5IG5vdA0KPiB3b3J0aCBpdCBoZXJlKSBhbmQgZ2l0
IHdpbGwgbm9ybWFsbHkgbGF0ZXIgbm90aWNlIHRoaXMgYW5kIGZ1bGx5DQo+IGF1dG9tYXRpY2Fs
bHkgaGFuZGxlIGV2ZXJ5dGhpbmcgd2hlbiB0aGUgZml4IGNvbWVzIGluIGFnYWluIGR1cmluZyB0
aGUNCj4gbmV4dCBtZXJnZSB3aW5kb3cuDQoNCkkga25vdyBnaXQgY2FuIGhhbmRsZSB0aGF0LCBi
dXQgaXMgaXQgYW4gYWNjZXB0YWJsZSBwcmFjdGljZSBmb3Igc2luZ2xlIG9uZQ0KY29tbWl0IHRv
IGFwcGVhciB0d2ljZT8NCg0KQXMgdGhlIHJlcG9ydGVyIGhhcyBmaXhlZCBoaXMgcHJvYmxlbSwg
Y2FuIHdlIGtlZXAgdGhpcyBjb21taXQgYXMgaXQgd2FzPw0KDQpQaW5nLUtlDQoNCg==

