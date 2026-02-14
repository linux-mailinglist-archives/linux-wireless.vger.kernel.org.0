Return-Path: <linux-wireless+bounces-31832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H6hjMH9zkGn9ZwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:07:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D413C0E0
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2992301FD77
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F51DF987;
	Sat, 14 Feb 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="F6Bef3DF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48839FD4;
	Sat, 14 Feb 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074428; cv=none; b=TAYOgkwZWk6oI0izC+nStVa8rpLExLtiMBYXUCC+niZhz7snjWbmUW+V61OkMNkIftqA5S57NpeoXMw5Wvz02q5OQEJ2GZkpLF1YwOYywEUFwhvQn17KsJ4bGR8yaCTdspVWsSKK6Umh6HanrF0SwrKAH7ZShyBGp6s+43mgw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074428; c=relaxed/simple;
	bh=LysN47RSRpPs781druq0SNM9QWsqWiYy4Q+66tIMa08=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=qILoVS2q0SykZgzpQ/iNg0EkByuPyxTeBx4x+ZJW9fShzUE2l37z/iaA4nsArd+TFdIGnV8gzf8CIBpf6AQxemEIoLqFm32u3LNKE+JxwxA0bprWpEiQRsGPCHdpbf333T7XAOD6YFBgqv5gFI/LuhA6iD/EfT8tO2cJmWy0UUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=F6Bef3DF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771074385;
	bh=LysN47RSRpPs781druq0SNM9QWsqWiYy4Q+66tIMa08=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=F6Bef3DFHn5ROOgTMue18Lsw0hZLygPvqioyGkT5aTu9DvffXdbf6yYd+IKpK8mLo
	 EjGFCCAa8MHnz0FA8GEUA3hls8feeWaMHH5Ti51NqVSt5hzYE8sS1hjh6zzfhpjqrV
	 Bpl6E6PLj09tCmcsdkpm9A48IIwNL1GiiMsK8tS8=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTSbRBBHHBOigT3F8z0EASk8HWvVOrK8f0=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: oQL4pp2qCUrSZ0RCIHjAgwKw2IYbrSGRGsHcBh//AFs=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771074383t0c27b6ba
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?am9oYW5uZXM=?=" <johannes@sipsolutions.net>
Cc: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bGludXgtd2lyZWxlc3M=?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in ieee80211_rx_mgmt_beacon Function
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 21:06:23 +0800
X-Priority: 3
Message-ID: <tencent_4786AF1168F658A13B06D0BE@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 14382499685940241657
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 21:06:24 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MVocNrGTvdghGq0pOAJt3UoAsSiVzE8WwF6laecgG6Gj+drH1vyEVIOu
	VAa1PGnbChjyGoxJ0UOAW2aqnXKC3yimJbUsD+FBoEMoLethyDlX3dZ0x6J/UkinxXb+J5k
	H1VmaczNpQ2DE0Q4UvjSolRJ+RrYBn8o6Wm8KTGR/ON7yWgP8ri/r4Vz4zOPhaqwfq4cvhV
	CwBgbv9/2fG+iNdz+qy74VZmuCcSKUTq1bDl9utUhVayxdIDTDKlcWknBGBp80E1BGAWm5I
	pSnGvjZoz+sKai+rpzKTnUkkyiIOMGrLVAXMyvDDrKt1jCqZdmohdnpLAXkc/iT2cyD3WhG
	FhF93H1T8nVbF1J3RE19smxKtGhgjCpN9PQ1J0ffhVULjdfMw93NFfUmQss/zpSXbce3hgg
	FPXbv5oySfazMRgKBKIXtGKmVi4yt77SuxH4cuQKFxbgWJe4UcfSTfJQEaJE9OAHIJN35xv
	J6oUMPyUkGK77DXsvSnlEKnwecWDnDwh6rFeB84H1TDvub/kzGBH5iM7nsb9Xmb87ojrOwS
	yaEVYfI48BNfoST6I2oiudJ/NvQf0xeYKa2TRCIW3yS6M0nvvYhKhdGcj0KcgcPvRVRjZr9
	OaXpzPgpWPJyeb4Fjtk1QaVSAppT/OKT3ve/63eJ/GNEyzI6If4Y9+oTrjYcicyKgzbdA5m
	nv8QHWvQz1N959R5tp4Ys5GVPETw0+HBGuEiBv4RPUUM9gxVFUR2AjwcIlE0u1wl1CyJtbY
	v0NTTz8xl3vaBNgkTNIklI99IG989PSqoyloWJchvZNjyKoovPZpXk5uCLLioJJgM0o7H3s
	ESmF+TAz5fGGaqwDG3RrM0V1odriHudtznydYeB0hRUHO9JJh12q+TT/JLkKjUMlsT0GC5/
	IQupD4PuLKHuc+MESGxxRdzTt+E6NFVY/glmq/VZSQmHsKkM7855TgRhJYHDrlRrB15Dmsr
	id6wYMWvqYXQdtQQ1EYRd1ZwHhCzRs9Ifl0vKzZCSMUU/I/ZGTlAzRKvJEOz99yYxHqOHzg
	ixNpSh2Go9oIeuAFYybWSEuIMErLL3z/YlZQPSbs7ymRoIWiGikU0R9GqEurs=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-31832-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,linux-wireless@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,m.fudan.edu.cn:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 3E1D413C0E0
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
ZWVlODAyMTFfcnhfbWdtdF9iZWFjb24sIHdlIGZvdW5kIHRoZSBmb2xsb3dpbmcgbGluZSBv
ZiBjb2RlOg0KDQohaWVlZTgwMjExX3J4X291cl9iZWFjb24oYnNzaWQsIGxpbmstPmNvbmYt
PmJzcykpDQoNClRoZSBpc3N1ZSBhcmlzZXMgYmVjYXVzZSB0aGUgYnNzaWQgcG9pbnRlciBt
YXkgYmUgcGFzc2VkIGFzIE5VTEwgaW4gY2VydGFpbiBzaXR1YXRpb25zLiBUaGUgc3RhdGVt
ZW50IHBhc3NlcyB0aGUgYnNzaWQgcG9pbnRlciB0byBpZWVlODAyMTFfcnhfb3VyX2JlYWNv
biB3aXRob3V0IGFueSBjaGVjaywgYnV0IGllZWU4MDIxMV9yeF9vdXJfYmVhY29uIG1pZ2h0
IGNvbnRhaW4gYSBkZXJlZmVyZW5jZSBvcGVyYXRpb24gb24gdGhlIGJzc2lkIHBvaW50ZXIs
IHdoaWNoIGNvdWxkIHJlc3VsdCBpbiBhIG51bGwtcG9pbnRlciBkZXJlZmVyZW5jZS4NCg0K
UHJvcG9zZWQgRml4Og0KVG8gcHJldmVudCB0aGUgcG90ZW50aWFsIG51bGwtcG9pbnRlciBk
ZXJlZmVyZW5jZSwgd2Ugc3VnZ2VzdCBhZGRpbmcgYSBOVUxMIGNoZWNrIGZvciB0aGUgYnNz
aWQgcG9pbnRlciBiZWZvcmUgYXR0ZW1wdGluZyB0byBwYXNzIHRoZSBwb2ludGVyIHRvIGll
ZWU4MDIxMV9yeF9vdXJfYmVhY29uLg0KDQpSZXF1ZXN0IGZvciBSZXZpZXc6DQpXZSB3b3Vs
ZCBhcHByZWNpYXRlIHlvdXIgZXhwZXJ0IGluc2lnaHQgdG8gY29uZmlybSB3aGV0aGVyIHRo
aXMgdnVsbmVyYWJpbGl0eSBpbmRlZWQgcG9zZXMgYSByaXNrIHRvIHRoZSBzeXN0ZW0sIGFu
ZCBpZiB0aGUgcHJvcG9zZWQgZml4IGlzIGFwcHJvcHJpYXRlLiBJZiB0aGVyZSBhcmUgcmVh
c29ucyB3aHkgdGhpcyBpc3N1ZSBkb2VzIG5vdCBwcmVzZW50IGEgcmVhbCByaXNrIChlLmcu
LCB0aGUgTlVMTCBjaGVjayBpcyByZWR1bmRhbnQgb3IgdW5uZWNlc3NhcnkpLCB3ZSB3b3Vs
ZCBiZSBncmF0ZWZ1bCBmb3IgY2xhcmlmaWNhdGlvbi4NCg0KVGhhbmsgeW91IGZvciB5b3Vy
IHRpbWUgYW5kIGNvbnNpZGVyYXRpb24u


