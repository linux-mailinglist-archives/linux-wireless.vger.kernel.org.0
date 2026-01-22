Return-Path: <linux-wireless+bounces-31051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPqEBQh+cWk1IAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 02:31:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2660597
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 02:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 104E73CA2AF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386431771B;
	Thu, 22 Jan 2026 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="inZSBfQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD330F930;
	Thu, 22 Jan 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045404; cv=none; b=ELiVltgaDJvd6iYOeNCAHb8gbLhD8zc91wOw7aKOlqX88bfjqd/79eggCsXufOFJMjZJ2BGsmzhO9KF26QlluXRd6n7zlW9cxG/Ui1CuMhX+XwCjEncfp/iJLMHdZwQvxKPgOKAfz5EO48xOpwtJbKHAs+3dAbDWX04jds4AWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045404; c=relaxed/simple;
	bh=wzyKCsJHlaZwuRkTmVxum1ZVSLoLfjyrxj3pe+s+Ano=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=VAU9TG6wjPiJ6ypxHUISog8tYgDqlI5FHILiNNVNEsnT8nY8/2P69aKQe0an01iyotdeJmZKiOZWBWgsQCMCxZAephHSA4LQViVO/XiOmmmyj7SytVWg7owrMdoQbF4dDi+tjtAkbzcEs0S4kcgl//Hu2y19YAW4HfNevle9xf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=inZSBfQz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60M1TWU00042897, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769045372; bh=wzyKCsJHlaZwuRkTmVxum1ZVSLoLfjyrxj3pe+s+Ano=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=inZSBfQzycxfZr2lx46WLvctrWmAvW6reAEGF46/tVBvZNpdKAoLGNkjTTo6020cl
	 LqirHs5WFXa2yYEhBQdqqA+T6HIFDE4pzMxY9SQ1W/PH7Uc4Ruox43degktjRypOsX
	 zq6JRdky/D+Txws7C8G0yYHrXeEG3y9unnvDAcwFIYg+uuSe6lx5JVxMvuw8zSx46i
	 MZ27JtHYT4qrjFXTIIEXF4A4BqimWlFMljB1gIXdzR2MNUAQl9k/4yWOLU1uddnuSw
	 aVyGRHRwikUJw4zRQzeauMT4J6I5uJ7Q4HPMUQC7NjuL8n9p/zYhtFnFcH4Khxppep
	 iVKHVM0TtrAag==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60M1TWU00042897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 09:29:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 09:29:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 09:29:31 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 22 Jan 2026 09:29:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Marco Crivellari <marco.crivellari@suse.com>,
        "Michal Hocko" <mhocko@suse.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 2/2] wifi: rtw88: add WQ_PERCPU to alloc_workqueue users
In-Reply-To: <20251113160605.381777-3-marco.crivellari@suse.com>
References: <20251113160605.381777-1-marco.crivellari@suse.com> <20251113160605.381777-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <03d9df21-039c-4aa2-b227-9da4f8076388@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 22 Jan 2026 09:29:26 +0800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[realtek.com,none];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,realtek.com];
	TAGGED_FROM(0.00)[bounces-31051-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,realtek.com:dkim,suse.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BBC2660597
X-Rspamd-Action: no action

TWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4gd3JvdGU6Cgo+IEN1
cnJlbnRseSBpZiBhIHVzZXIgZW5xdWV1ZXMgYSB3b3JrIGl0ZW0gdXNpbmcgc2NoZWR1bGVfZGVs
YXllZF93b3JrKCkgdGhlCj4gdXNlZCB3cSBpcyAic3lzdGVtX3dxIiAocGVyLWNwdSB3cSkgd2hp
bGUgcXVldWVfZGVsYXllZF93b3JrKCkgdXNlCj4gV09SS19DUFVfVU5CT1VORCAodXNlZCB3aGVu
IGEgY3B1IGlzIG5vdCBzcGVjaWZpZWQpLiBUaGUgc2FtZSBhcHBsaWVzIHRvCj4gc2NoZWR1bGVf
d29yaygpIHRoYXQgaXMgdXNpbmcgc3lzdGVtX3dxIGFuZCBxdWV1ZV93b3JrKCksIHRoYXQgbWFr
ZXMgdXNlCj4gYWdhaW4gb2YgV09SS19DUFVfVU5CT1VORC4KPiAKPiBUaGlzIGxhY2sgb2YgY29u
c2lzdGVuY3kgY2Fubm90IGJlIGFkZHJlc3NlZCB3aXRob3V0IHJlZmFjdG9yaW5nIHRoZSBBUEku
Cj4gRm9yIG1vcmUgZGV0YWlscyBzZWUgdGhlIExpbmsgdGFnIGJlbG93Lgo+IAo+IGFsbG9jX3dv
cmtxdWV1ZSgpIHRyZWF0cyBhbGwgcXVldWVzIGFzIHBlci1DUFUgYnkgZGVmYXVsdCwgd2hpbGUg
dW5ib3VuZAo+IHdvcmtxdWV1ZXMgbXVzdCBvcHQtaW4gdmlhIFdRX1VOQk9VTkQuCj4gCj4gVGhp
cyBkZWZhdWx0IGlzIHN1Ym9wdGltYWw6IG1vc3Qgd29ya2xvYWRzIGJlbmVmaXQgZnJvbSB1bmJv
dW5kIHF1ZXVlcywKPiBhbGxvd2luZyB0aGUgc2NoZWR1bGVyIHRvIHBsYWNlIHdvcmtlciB0aHJl
YWRzIHdoZXJlIHRoZXnigJlyZSBuZWVkZWQgYW5kCj4gcmVkdWNpbmcgbm9pc2Ugd2hlbiBDUFVz
IGFyZSBpc29sYXRlZC4KPiAKPiBUaGlzIGNvbnRpbnVlcyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9y
IHdvcmtxdWV1ZSBBUElzLCB3aGljaCBiZWdhbiB3aXRoCj4gdGhlIGludHJvZHVjdGlvbiBvZiBu
ZXcgd29ya3F1ZXVlcyBhbmQgYSBuZXcgYWxsb2Nfd29ya3F1ZXVlIGZsYWcgaW46Cj4gCj4gY29t
bWl0IDEyOGVhOWY2Y2NmYiAoIndvcmtxdWV1ZTogQWRkIHN5c3RlbV9wZXJjcHVfd3EgYW5kIHN5
c3RlbV9kZmxfd3EiKQo+IGNvbW1pdCA5MzBjMmVhNTY2YWYgKCJ3b3JrcXVldWU6IEFkZCBuZXcg
V1FfUEVSQ1BVIGZsYWciKQo+IAo+IFRoaXMgY2hhbmdlIGFkZHMgYSBuZXcgV1FfUEVSQ1BVIGZs
YWcgdG8gZXhwbGljaXRseSByZXF1ZXN0Cj4gYWxsb2Nfd29ya3F1ZXVlKCkgdG8gYmUgcGVyLWNw
dSB3aGVuIFdRX1VOQk9VTkQgaGFzIG5vdCBiZWVuIHNwZWNpZmllZC4KPiAKPiBXaXRoIHRoZSBp
bnRyb2R1Y3Rpb24gb2YgdGhlIFdRX1BFUkNQVSBmbGFnIChlcXVpdmFsZW50IHRvICFXUV9VTkJP
VU5EKSwKPiBhbnkgYWxsb2Nfd29ya3F1ZXVlKCkgY2FsbGVyIHRoYXQgZG9lc27igJl0IGV4cGxp
Y2l0bHkgc3BlY2lmeSBXUV9VTkJPVU5ECj4gbXVzdCBub3cgdXNlIFdRX1BFUkNQVS4KPiAKPiBP
bmNlIG1pZ3JhdGlvbiBpcyBjb21wbGV0ZSwgV1FfVU5CT1VORCBjYW4gYmUgcmVtb3ZlZCBhbmQg
dW5ib3VuZCB3aWxsCj4gYmVjb21lIHRoZSBpbXBsaWNpdCBkZWZhdWx0Lgo+IAo+IFN1Z2dlc3Rl
ZC1ieTogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPgo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENy
aXZlbGxhcmkgPG1hcmNvLmNyaXZlbGxhcmlAc3VzZS5jb20+Cj4gTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjUwMjIxMTEyMDAzLjFkU3VvR3ljQGxpbnV0cm9uaXguZGUvCgox
IHBhdGNoKGVzKSBhcHBsaWVkIHRvIHJ0dy1uZXh0IGJyYW5jaCBvZiBydHcuZ2l0LCB0aGFua3Mu
CgpmNjVjYTZjNTExNzkgd2lmaTogcnR3ODg6IGFkZCBXUV9QRVJDUFUgdG8gYWxsb2Nfd29ya3F1
ZXVlIHVzZXJzCgotLS0KaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9ydHcuZ2l0Cgo=

