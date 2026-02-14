Return-Path: <linux-wireless+bounces-31829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM/pLvlxkGncZgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:00:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291413C014
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6916301E220
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC530DD3F;
	Sat, 14 Feb 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="j5q8zfVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD326738B;
	Sat, 14 Feb 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074038; cv=none; b=Ug7SltKwdYM5NsnGbUzhFcSDIHul4E+IGhcPHGIgq4/0ALKvgsnZ1oRQ2f4bzCVXavCIUFK4imyIIrYbCZ3BA6lU5UcHYcxYJbbxNiUh4vgIqTnyZLx+4PDZ3X07evGA9LuVa5ddTL4uAPApr1kDMNnAaa0xUBH+a7qlSjTmvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074038; c=relaxed/simple;
	bh=pNvexjIuqpmlLdXfCBQXD5Ifwo3YWZBNi/E4nC1nCxo=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=R6QtAXp8ognmcjDm0+STl471EqjQP7VdzkxV7gfd0Mn6t/osXpD+yqUr4GmTWC3og7eyOfgL7K4NmSKdBGQA6fToflraeTtg13NJfkPL6iWMjjQ5x1lSsx250qevbdU2pDtNy8FWdU/KSUCa0cc1FFJkmEHB1ttKRSQ/IRVVA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=j5q8zfVT; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771073994;
	bh=pNvexjIuqpmlLdXfCBQXD5Ifwo3YWZBNi/E4nC1nCxo=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=j5q8zfVTn/2laYpQbB3PBZbZDFHa7lNOTUugccvAWWpJ7Xr8wehM1PD4Ss/R8NAlO
	 PPXZW33f6Rn2djRGw+SCP2sRC6SzxP6ytv3DsyLlnEGo9wga5c1yh2pd20bt1g1quO
	 xQuVof96ZAOLQyj0ATNJsvIcWuEYXIMtGcbWDY5g=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqR3BzPw6xF2yYOMzhADaK1k6/GpcrrpT/I=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: kU7AokcdNe554ObggHRXXi0bgXC2wNiJqK1AyFQlnfk=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771073992t7dba57da
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?am9oYW5uZXM=?=" <johannes@sipsolutions.net>
Cc: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bGludXgtd2lyZWxlc3M=?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in ieee80211_chsw_switch_vifs Function
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 20:59:52 +0800
X-Priority: 3
Message-ID: <tencent_2A81A52D105C785C7911A7A1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 12896927006149255231
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 20:59:53 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MYNcaOm1VPp0kXi7BUiq2FDMv48ENvQKwEGpIAOHaxEGBAI/7yTqI7Ev
	Ighlm5T6Df5V6V8pPNUiDu8DtbQ4uevKe7ZzG6jmMniUrp7BL22argOsuaLKaWyScWzjqhH
	+SA5ge/QaW69E65pegF0bi6hP3QYuEJ6isEbAWaKmBjoqD9WkqTY/IAQdZPFWsca/nuVT4S
	q/LuGQis7d3b1FRKkfov92q8PnLSH8wsMpBUWkqwzxCyIQ4nhhht6+eUAYSfo1f9sb8IIOD
	O/8bgQYTRsvzNbQRrwBI419ciCUymw8tT6JBxHjYkvBeAMmcEnYwWx+19mUwKLZ2nTwFNr8
	7cSmxmpcf9sz9Y/XxHPoBtg9FFBD0nxj0plDW8vpyfdfjD97MPkDBLj0XvKmmNb2NLTGTue
	Xh1QErHVKzpTNOt4Rfij8sQn8EExZTkVFrgfAeXitNTW45wU/gYntffMYvCxjQKB9OPxBj0
	7lCm2ZdcUuQc76sihWUjPAli561Gtb88tClFr0KKNDAmb/XUBbcgr7+pcX5menbfQdVzzg/
	vK21h4fGhpc2INuZGd5iEzY4/R5o2LYCQ0Heit5cE0cpdgyB0Tl5szoc7Zi2YA5ndUReXln
	t0JwhpbncHjuFbkJ3PdgIzkUMAW5svteu01t+W+QwwkgvAX5ZxnoagsylovES26m2HGy8v+
	Hn2hHOBf7ruhVIPz4Q1EPUSr1y6q4Js1yVk8WLusvar0Srx+EQMKFlpO8XyHrO/cPAZIxun
	KoBYzYFafFt+LltZvxpnGECezncNnMmzMYlMHxGFKOyu0dUk/Mbs2uW3aC+fe8CEj12deY+
	7teZFYW3PPovZA04zR0CrRydQaH+oh1eLbSzu/rcQ2dHAsAczx3v+cMn7pY4fEySBtXEbvY
	cyTft7VobgUoP0IqOeolmj+lMapM4vmatwjMEPLIvNTvU9IVI8iCJWVPMJBK2A+rTngGPHL
	6Y07jFYua7vPSrYQ9B2xRAeR4zlD+DBGvEK5DejQuI+Q6zlSY34Mw+c8RTDBRjHpM0M1zNm
	v7vJ3vU/mBD6/tBSfka4l3oTN3VtvTCsmb+KePSgSOWOer8ozLxCg/QUto/T8JnA4dSpoeQ
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[m.fudan.edu.cn:s=sorc2401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31829-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,linux-wireless@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[m.fudan.edu.cn:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:mid]
X-Rspamd-Queue-Id: 2291413C014
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9tYWM4MDIxMS9jaGFuLmMNCkluIHRoZSBmdW5jdGlvbiBp
ZWVlODAyMTFfY2hzd19zd2l0Y2hfdmlmcywgd2UgZm91bmQgdGhlIGZvbGxvd2luZyBsaW5l
IG9mIGNvZGU6DQoNCnZpZl9jaHN3W2ldLm9sZF9jdHggPSAmb2xkX2N0eC0+Y29uZjsNCg0K
VGhlIGlzc3VlIGFyaXNlcyBiZWNhdXNlIHRoZSBvbGRfY3R4IHBvaW50ZXIgbWF5IGJlIHBh
c3NlZCBhcyBOVUxMIGluIGNlcnRhaW4gc2l0dWF0aW9ucy4gU2luY2Ugb2xkX2N0eCBpcyBO
VUxMLCBhY2Nlc3NpbmcgJm9sZF9jdHgtPmNvbmYgaW4gdGhlIHN0YXRlbWVudCBjb3VsZCBy
ZXN1bHQgaW4gYSBudWxsLXBvaW50ZXIgZGVyZWZlcmVuY2UuDQoNClByb3Bvc2VkIEZpeDoN
ClRvIHByZXZlbnQgdGhlIHBvdGVudGlhbCBudWxsLXBvaW50ZXIgZGVyZWZlcmVuY2UsIHdl
IHN1Z2dlc3QgYWRkaW5nIGEgTlVMTCBjaGVjayBmb3IgdGhlIG9sZF9jdHggcG9pbnRlciBi
ZWZvcmUgYXR0ZW1wdGluZyB0byBkZXJlZmVyZW5jZSAmb2xkX2N0eC0+Y29uZiBpbiB0aGUg
bGluZS4NCg0KUmVxdWVzdCBmb3IgUmV2aWV3Og0KV2Ugd291bGQgYXBwcmVjaWF0ZSB5b3Vy
IGV4cGVydCBpbnNpZ2h0IHRvIGNvbmZpcm0gd2hldGhlciB0aGlzIHZ1bG5lcmFiaWxpdHkg
aW5kZWVkIHBvc2VzIGEgcmlzayB0byB0aGUgc3lzdGVtLCBhbmQgaWYgdGhlIHByb3Bvc2Vk
IGZpeCBpcyBhcHByb3ByaWF0ZS4gSWYgdGhlcmUgYXJlIHJlYXNvbnMgd2h5IHRoaXMgaXNz
dWUgZG9lcyBub3QgcHJlc2VudCBhIHJlYWwgcmlzayAoZS5nLiwgdGhlIE5VTEwgY2hlY2sg
aXMgcmVkdW5kYW50IG9yIHVubmVjZXNzYXJ5KSwgd2Ugd291bGQgYmUgZ3JhdGVmdWwgZm9y
IGNsYXJpZmljYXRpb24uDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBjb25zaWRl
cmF0aW9uLg==


