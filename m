Return-Path: <linux-wireless+bounces-31831-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFvwADJzkGmxZwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31831-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:05:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585F13C089
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 14:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AA9B300A26E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CC2868A7;
	Sat, 14 Feb 2026 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="ZaIah105"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3030ACE6;
	Sat, 14 Feb 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074338; cv=none; b=TZvB+OS5CIVf7H8wQs592k5K3bFIbUyXfXseS2IrzOO0gIgtYLUSHtsxETkohncdkWKYZAwOvYuft5YhTOF78syZzFc/0GzXsKDhDW0ozAbh9uithSCNQcS9ge00B4cDTRX8NMzI4ZyQ+nHCUXitRVvmnnkMzVqIyx/T7mxHovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074338; c=relaxed/simple;
	bh=zhfORHZFDvjDSdW4p0Tc+gkL7R7oLNLoyg8RQlHmjIE=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=pp9C99bFPmwPDnatW+E6rEy75E2dL6z2gOnq73XIXzP4o1Ipw5QZNWjg8A22q6EtA/B2CwMuoR1csFfxSJFNl7P6xtuhzFF2bvhDPFfKt4T68IgLXSGu6SymjVxHeZ5wWIW9utYzh4n5DT+thDO4b2mFtIG1AHnQ79NzNGtNUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=ZaIah105; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771074291;
	bh=zhfORHZFDvjDSdW4p0Tc+gkL7R7oLNLoyg8RQlHmjIE=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=ZaIah105qxOc4t6BncD3ekrG4ODNPr+i/QAhlL0gc2zbLNgRMbzMIEHupZzyZ2f8o
	 eCMttqlFDfaLMYbYj7S3XlLZhZ0PxGkvrFP3WROt+GplZ5YoY7ZjGujBtX015AQucy
	 0S+o0V48dCtZkU7BqUjAsE/a4oYnniXv6Nh5l1M4=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqROnkNu+5xqqIMcoYWkXi5KcV9Vqzi9AzQ=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 62j5T2Mrbm7JefDssbtDaOR8VL9Hh0OHiYL4yzw4qco=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771074290t53af9321
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
Date: Sat, 14 Feb 2026 21:04:49 +0800
X-Priority: 3
Message-ID: <tencent_683B00445075C24353AE7A9B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 4807375162308606760
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 21:04:50 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MdoRYM9mYrydkv3AQQKyht5/pzlXAsH5/serK1R5pX0mXLFyuCwVorZa
	drSRwkyNG7HkRkTzrZ15H7Seew6Mkelmg7+FJlc28otdnnvc0b8yUrNbAytbhfaDCJXV4Uo
	MkjRXTerBzZRsllg+bZTB4nbYxHXW/hoNKEqhFq2A0HxTVqDZmBPg2PJrf8QlUWoDfZX6+1
	/WLN/TA2wzQlk6kRYc6kWG7FUdHP89mJnCV82uI0o9m+YFdtscn3i7bN2jeHKjuLxlAoPSC
	0IMTK+pUtRerzBODY+Cv7/iycihhYfN4D2bXLuminuwh4EYD9xaIKSf5kAUFC+iK1ZGyRd/
	O2Ms/tbmN7fZvmL7TIDFnpW4mIMP2hOnlmH3j9vcavL4l8XWzC/x6M34+4whAIt74ocJEPG
	905awBoHVQgqjUR8vA+KEzOkhFrg3txzPJ00SGhTGYBW9TJfeIDVEOBqISN3817ZULYWjx3
	uSW4MXaCq/pxzWj044PBWWMHUMei7zVMEXR1D6u0H9YmBLrnGAiYNKjfnyrEL6SXv4clQLA
	Ys4hZpdMb9jkXEhAGJ1glpoqbWgoWv/S/KNZhuqYeePYnCz6mU3meAm7IG5ZQzJOFPN2vux
	WEJ6zcHDS/obSINndAqFcIJjqv6zXTZzwSDG3Xa1fNv97VDAtGzqGFl2VGccGi1wp1X4/mi
	iR5tqzSB8F/Qt3KpYEcQZGYtkLX+4nybfsh9s8OkMEloE+nMaUsuTaW+6817GS+PovN+PxI
	U6LoZ7A21QlJb8/zYUinoshVs4cjk0Nkv501xDeShZ6crnbQpBbjgMKqduCezz5WUakEjh/
	hSFmHdi9Dl2qvT1n9ZRZdCsKOKhTYIS3LlNiterAxdtnPFDllGxWkhw1gEKqnXPGx/I8+lU
	pCRZhhjJDJwQ4jk9hazjG855N2Cx0TgOY0rKzp6Ef2APaIGjRCB8PmD5GBj6uyndKXowwVn
	0Hnd9qYTi8+dIGNEvSKJ6+Jcr4rPYfxJo476KWZGapR+vHUyi0j1k2NXxEJhfkHtQ0GbEn8
	t0/N15wvitfIutLhXv
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-31831-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,linux-wireless@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,m.fudan.edu.cn:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2585F13C089
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
ZiBjb2RlOg0KDQppZWVlODAyMTFfcnhfb3VyX2JlYWNvbihic3NpZCwgaWZtZ2QtPmFzc29j
X2RhdGEtPmxpbmtbMF0uYnNzKSkgew0KDQpUaGUgaXNzdWUgYXJpc2VzIGJlY2F1c2UgdGhl
IGJzc2lkIHBvaW50ZXIgbWF5IGJlIHBhc3NlZCBhcyBOVUxMIGluIGNlcnRhaW4gc2l0dWF0
aW9ucy4gVGhlIHN0YXRlbWVudCBwYXNzZXMgdGhlIGJzc2lkIHBvaW50ZXIgdG8gaWVlZTgw
MjExX3J4X291cl9iZWFjb24gd2l0aG91dCBhbnkgY2hlY2ssIGJ1dCBpZWVlODAyMTFfcnhf
b3VyX2JlYWNvbiBtaWdodCBjb250YWluIGEgZGVyZWZlcmVuY2Ugb3BlcmF0aW9uIG9uIHRo
ZSBic3NpZCBwb2ludGVyLCB3aGljaCBjb3VsZCByZXN1bHQgaW4gYSBudWxsLXBvaW50ZXIg
ZGVyZWZlcmVuY2UuDQoNClByb3Bvc2VkIEZpeDoNClRvIHByZXZlbnQgdGhlIHBvdGVudGlh
bCBudWxsLXBvaW50ZXIgZGVyZWZlcmVuY2UsIHdlIHN1Z2dlc3QgYWRkaW5nIGEgTlVMTCBj
aGVjayBmb3IgdGhlIGJzc2lkIHBvaW50ZXIgYmVmb3JlIGF0dGVtcHRpbmcgdG8gcGFzcyB0
aGUgcG9pbnRlciB0byBpZWVlODAyMTFfcnhfb3VyX2JlYWNvbi4NCg0KUmVxdWVzdCBmb3Ig
UmV2aWV3Og0KV2Ugd291bGQgYXBwcmVjaWF0ZSB5b3VyIGV4cGVydCBpbnNpZ2h0IHRvIGNv
bmZpcm0gd2hldGhlciB0aGlzIHZ1bG5lcmFiaWxpdHkgaW5kZWVkIHBvc2VzIGEgcmlzayB0
byB0aGUgc3lzdGVtLCBhbmQgaWYgdGhlIHByb3Bvc2VkIGZpeCBpcyBhcHByb3ByaWF0ZS4g
SWYgdGhlcmUgYXJlIHJlYXNvbnMgd2h5IHRoaXMgaXNzdWUgZG9lcyBub3QgcHJlc2VudCBh
IHJlYWwgcmlzayAoZS5nLiwgdGhlIE5VTEwgY2hlY2sgaXMgcmVkdW5kYW50IG9yIHVubmVj
ZXNzYXJ5KSwgd2Ugd291bGQgYmUgZ3JhdGVmdWwgZm9yIGNsYXJpZmljYXRpb24uDQoNClRo
YW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBjb25zaWRlcmF0aW9uLg==


