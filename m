Return-Path: <linux-wireless+bounces-34200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bd1L6IWy2lrDwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 02:34:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC04362AF0
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 02:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E3830078F3
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB461A6807;
	Tue, 31 Mar 2026 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MR34RIfk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669840DFD9;
	Tue, 31 Mar 2026 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917138; cv=none; b=WEPO3rDhlxvr0aaZlYw9r2/mgK905dtfHZDWPyu4hsqBRcpBapb+5wA6Pw4gkW04uflcwJFU2s2Kuj7N8j5BZpJhEprqSbZNS0/RiMbYVF7Ft0RI8DyLqr9JbhDs4tWCcMAIPXXAnCY45zdT+Rh+cKg2mH5zKlqjj9BNU6V8pMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917138; c=relaxed/simple;
	bh=spma5CpagR8KwNwm+En41q48T4p7+Fg5XEfAtUXJ0FI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgV0RNkQE8xHbhkZ0HPqjWde984f4i0LDt5Fu6HNiqhqqfax5yaZEBXrQUTtxH1ioBsXnZYC+CChRUeubHfzhM3hsSMWe5FoK4qHErGEl8vVDVRldeHwH1DhuETDn3Is5oI5MiJnVpPDhQpEon9P1KJIXtO/gkiQeAtF3vZGSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MR34RIfk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62V0WC0x82155336, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774917132; bh=spma5CpagR8KwNwm+En41q48T4p7+Fg5XEfAtUXJ0FI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MR34RIfkNjQG9xZRF3qXnIjqumRRD7it/llt/BJzmXOUEiTYW5Lgl0YIbV7eGyTsU
	 aCHIBhFBMYV/g4/OCOu5ArcnKG0vOhXLrtS7rHJTSOfzl9r/c5E8A30PRRLVPsuY2l
	 tRBpTh3hZz3Qpwx18GT5dq/Jad0N4ydF+rjJh+W+IRQfYZfeRFeLYaPy+HaEQ+0zqc
	 LvhWfBVN8t6NEi2G28gQnhe0eMl22b/uL9XRCBwzw2THjWaUM4bJQd3zXLKBqcW8nJ
	 ai0L4xi0QOUFonGvEQTsc7I+4+KoQ+dKUW12C+uZAp/uYU4BugtUoUQ9HNW5OURMUp
	 7v+l4mfdA+H3w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62V0WC0x82155336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:32:12 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 08:32:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 31 Mar 2026 08:32:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Tue, 31 Mar 2026 08:32:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgACVvSCAAP1VgIAAC/kAgACJQ/D//4GPAIAAkThggAG2LgCAAwD/wIAD1wcAgAHIjgCAALhtgIABn92AgAAYAQCAAAl0AIAAVvuAgAKDYMCAACbbgIABXNkQ
Date: Tue, 31 Mar 2026 00:32:10 +0000
Message-ID: <5fb2f699626b483b8a0a537960b274f0@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
 <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
 <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
In-Reply-To: <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34200-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 1DC04362AF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpMQiBGIDxnb2FpbndvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBDb3VsZCB5b3UgYWR2aXNl
IG9uIGhvdyB0byBpbnZlc3RpZ2F0ZSB0aGlzIGZ1cnRoZXI/IEZvciBleGFtcGxlOg0KPiANCj4g
ICAtIElzIHRoZXJlIGEgZGVidWcgZmxhZyBvciByZWdpc3RlciBkdW1wIHdlIGNvdWxkIGNhcHR1
cmUgcmlnaHQNCj4gICAgIGJlZm9yZSB0aGUgZmlyc3QgY29ycnVwdGVkIGZyYW1lIGluIGEgYnVy
c3Q/DQo+ICAgLSBXb3VsZCBpdCBoZWxwIHRvIGxvZyBDMkggKGNoaXAtdG8taG9zdCkgdHJhZmZp
YyBhcm91bmQgdGhlDQo+ICAgICB0aW1lIG9mIHRoZXNlIGV2ZW50cz8NCg0KSSBoYXZlIG5ldmVy
IGhlYXJkIGFib3V0IHRoaXMgc3ltcHRvbSBmcm9tIGludGVybmFsLCBzbyBubyBjbGVhcg0KaWRl
YSBmb3IgdGhhdC4gU29ycnkuDQoNCj4gDQo+IEkgYW0gcmVhZHkgdG8gcnVuIGFueSBzcGVjaWZp
YyB0ZXN0cyB5b3UgbmVlZC4gSW4gdGhlIG1lYW50aW1lLA0KPiBJIGFncmVlIHRoYXQgZmlsdGVy
aW5nIGJ5IERSVl9JTkZPX1NJWkUgaXMgdGhlIHJpZ2h0IHByYWN0aWNhbA0KPiBzb2x1dGlvbiwg
YW5kIEknbSB3YWl0aW5nIGZvciB5b3VyIG9mZmljaWFsIHBhdGNoIHRvIHRlc3QgbG9jYWxseS4N
Cg0KQXMgbWFsZm9ybWVkIGZyYW1lcyBoYXBwZW4gcmFuZG9tbHksIG1vcmUgdmFsaWRhdGlvbnMg
bGlrZQ0KRFJWX0lORk9fU0laRSBhcmUgbmVlZGVkLiBJIHRoaW5rIEJpdHRlcmJsdWUgaXMgd29y
a2luZyBvbiB0aGUNCnRlc3QgcGF0Y2guIDopDQoNClBpbmctS2UNCg0K

