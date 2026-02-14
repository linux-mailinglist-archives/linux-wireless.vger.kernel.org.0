Return-Path: <linux-wireless+bounces-31830-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMAZApBykGncZgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31830-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:03:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654213C061
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72FB73017BDB
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7F2DA75A;
	Sat, 14 Feb 2026 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="vsz9KkeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F518AE2;
	Sat, 14 Feb 2026 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074180; cv=none; b=F2aSDKOdAH9c2f464uL2sEa+f0eyBRf958jwvICQ4zwKdLYoAtZ3k7pkpUCj1dVo8NJKe+V6xAxUNhuv/DwwQA7MnBruxaiK2ZhdeyKGtOOsC7T9HEWg2HhSwJBNzJZWDnVSrnoD/2uG7U47yenx21rpCnhnCIdL8uIiiYCOY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074180; c=relaxed/simple;
	bh=Fo23NwXf9l1mHPj3B0OBY2OKo37r2x58LnTxELIh8z0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=hkhR0jAZwfojMVXJSkdeX0hIZ4q5ZwHx2+elepnWHq+ksrBNU5JzdwFWa4yDbw6jSf1yEbaNa9T0cQF5sltD2JmdT51tcK13XIkOCfkWz3yKpex0P7EIuM5w3dPPQ7qbKdfu0pIu4bYy4bOAmAyS4jo0dVjw02HqHo4Uv+vehSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=vsz9KkeH; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771074137;
	bh=Fo23NwXf9l1mHPj3B0OBY2OKo37r2x58LnTxELIh8z0=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=vsz9KkeH7OC6Eg7bcyzSHo5Eo4gnvJWQUxhPLx9Q8endwdzjLP8H9uxDoVRx7zRUF
	 h11/Q/sGqwrFpGpNjx6IIrni+ogBvebRUSzvC+xvYL32nUf8UBZSY3b8566H8c+WLL
	 AF8mEJEq+rFVyy72vzIo1ggjqedUok5ShVzE0dZs=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqR3BzPw6xF2yYOMzhADaK1k6/GpcrrpT/I=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: QtXU8YvEw8gsWYlG+yur+tXggv/qRYtz1pqAwwfFA30=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771074135t00edb90d
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?am9oYW5uZXM=?=" <johannes@sipsolutions.net>
Cc: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bGludXgtd2lyZWxlc3M=?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in ieee80211_process_neg_ttlm_req Function
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 21:02:14 +0800
X-Priority: 3
Message-ID: <tencent_50235033396E84610251D7C1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 2886952497958345387
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 21:02:16 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Me3hdGK5nWP4sYmRELciLf6OPc9jSf6SR7JlY6gwf2LG9cM7UdP9Uz8S
	kMsAmm86auMex+8LkpVaCMld9rvG/NgGTU7XXn0RVGIgLXN250eC0AeTEGQ7ey1WgMx5k6W
	YNEgdojPetNA8dWYvuU6ZORBZ3HuUQEheOt18edRWL/z3fRZhhU+lCqbgo5j9ebFYA84iIM
	nfIeqJUMUT88X7QyQwNd++RMfs6o1ApqQl1UEGzly8LJQOlH3AXyJ2Of4jz+LeQsHyE3uF9
	hzYFoTzD/6Kw9z9FTIokdf8/CLuF8JVyj1WaHG/wt6Hngpr38RxeCsXNLEFJCYVymbuXLa6
	fV9vQ46+oX37Cx9rwBKExjKAlFVQ0Mi9VBHLD6/8zC2mH7tz31yiB5CKg9QuANMBq8I5+aL
	7p4eE8XsuQTiUrESjSfL7sGIAVbkj2spRddc5rlOFHrRRFdXEVoQm+IDBLuX1aJ6miuJ3Cu
	3KMUBwkZnoy5J1WRZNr9Q0s2/8GRN/niKyQQxa21HSqHqka9Xl060ftAP+bxWr7T32Ide+4
	gGKDBV/UFK4GFnGIpu+PRZiNO/2ue3f4Wuq1+/PRxv+EOnS2BiOXqGzGfz76Aj0JRtBtafV
	S03FAjM2cNB95xveJTysFk0vYxit8bAsZSdA0ksbTkh9WdqawRTWrVGGPvEAidnXpizKMth
	7O9efEhShp9t5/338c1W2zX9UUS9yVjE570rpTrLWa7ZDpPWpeBU9gpMoCr1wqJFcp7r1Vc
	W95IcpUsrkLk1WGAIGGzKDztgrLyDdz4qxgi4MxyeYBKxXdqVUTp/y2BbAmJchSN93H1gzU
	mYT9NQKOMa4/ICC5OOzNd9urWa6SepMXGcOpv93VnlGHfHZQV4eY/mo8r8iaOYfm5xx+cU2
	paeV0kzaCkWLl9n5vkBI/J0svKIe3k/8djW3OrrqWGmSbA4yWRRG7AuLJ45P0997E0uJ5dv
	r+OG/v+2p842nB5UbBirk0THskQO0aG4iRhQygKZLva78WhEGnb0s/eVkluTdNRoPIX0Bmj
	wk9GbPuDP4dt6dyEQQDfgUzHAht+Zae5i4AslFDzhIohAaeQjJTQoqxLn0iLterCf0gk9sJ
	A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[m.fudan.edu.cn:s=sorc2401];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31830-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,linux-wireless@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,m.fudan.edu.cn:dkim]
X-Rspamd-Queue-Id: 7654213C061
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9tYWM4MDIxMS9tbG1lLmMNCkluIHRoZSBmdW5jdGlvbiBp
ZWVlODAyMTFfcHJvY2Vzc19uZWdfdHRsbV9yZXEsIHdlIGZvdW5kIHRoZSBmb2xsb3dpbmcg
bGluZSBvZiBjb2RlOg0KDQpCVUlMRF9CVUdfT04oQVJSQVlfU0laRShkaXJlY3Rpb24pICE9
IEFSUkFZX1NJWkUoZWxlbXMtPnR0bG0pKTsNCg0KVGhlIGlzc3VlIGFyaXNlcyBiZWNhdXNl
IHRoZSBlbGVtcyBwb2ludGVyIG1heSBiZSBwYXNzZWQgYXMgTlVMTCBpbiBjZXJ0YWluIHNp
dHVhdGlvbnMuIFNpbmNlIGVsZW1zIGlzIE5VTEwsIGFjY2Vzc2luZyBlbGVtcy0+dHRsbSBp
biB0aGUgc3RhdGVtZW50IGNvdWxkIHJlc3VsdCBpbiBhIG51bGwtcG9pbnRlciBkZXJlZmVy
ZW5jZS4NCg0KUHJvcG9zZWQgRml4Og0KVG8gcHJldmVudCB0aGUgcG90ZW50aWFsIG51bGwt
cG9pbnRlciBkZXJlZmVyZW5jZSwgd2Ugc3VnZ2VzdCBhZGRpbmcgYSBOVUxMIGNoZWNrIGZv
ciB0aGUgZWxlbXMgcG9pbnRlciBiZWZvcmUgYXR0ZW1wdGluZyB0byBkZXJlZmVyZW5jZSBl
bGVtcy0+dHRsbSBpbiB0aGUgbGluZS4NCg0KUmVxdWVzdCBmb3IgUmV2aWV3Og0KV2Ugd291
bGQgYXBwcmVjaWF0ZSB5b3VyIGV4cGVydCBpbnNpZ2h0IHRvIGNvbmZpcm0gd2hldGhlciB0
aGlzIHZ1bG5lcmFiaWxpdHkgaW5kZWVkIHBvc2VzIGEgcmlzayB0byB0aGUgc3lzdGVtLCBh
bmQgaWYgdGhlIHByb3Bvc2VkIGZpeCBpcyBhcHByb3ByaWF0ZS4gSWYgdGhlcmUgYXJlIHJl
YXNvbnMgd2h5IHRoaXMgaXNzdWUgZG9lcyBub3QgcHJlc2VudCBhIHJlYWwgcmlzayAoZS5n
LiwgdGhlIE5VTEwgY2hlY2sgaXMgcmVkdW5kYW50IG9yIHVubmVjZXNzYXJ5KSwgd2Ugd291
bGQgYmUgZ3JhdGVmdWwgZm9yIGNsYXJpZmljYXRpb24uDQoNClRoYW5rIHlvdSBmb3IgeW91
ciB0aW1lIGFuZCBjb25zaWRlcmF0aW9uLg==


