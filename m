Return-Path: <linux-wireless+bounces-29218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A69C772FE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 56F102C173
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FF2701D1;
	Fri, 21 Nov 2025 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OXHneX2L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA51248878;
	Fri, 21 Nov 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763696980; cv=none; b=Djxa6Mc5z56yyduWqM/2GIah7i2DxVe4zw0akAjKfKc4YYO64AVA327NXfEDwsOJaVfBCXNoyeOgKUXtJdNqsjrn2cso6S6L4WolQ3kDpDjrcFd1z9L+UtgBAiMRu5Ctxvv4E2m4mDdqZlgYCpEFWLXbsdOn4LX7KvRgCVUivrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763696980; c=relaxed/simple;
	bh=Kg+lIDCWGPZ2oDhZQ4ewmFHQxZwt1NKIZaXygqEGSSM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=UipDibUZe+evaFFSB0OISz+la4CmEpicQBOOWnx8UaHvLw7nNOWIYjhjhF4TsUAFfSfBqMTDrGauZed32PAAtDAPmjQ/k5olW3lYmntaA0uUT7lVmtPoAukuYcuczELLKCz4mIc4Vd8zhcpDjgGlwMOA0MEF6ZwERiiqecFzn88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OXHneX2L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL3nCGn92860774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763696952; bh=Kg+lIDCWGPZ2oDhZQ4ewmFHQxZwt1NKIZaXygqEGSSM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=OXHneX2LlYw/wiPTjppJWzscaE4SSJrthCLZA1SI4LUetiQnIWATi/GU15CNNrjis
	 rlL8Ud40xu61AkQdG3m1eMOX+3otbpM9oS8pHUhrer6QVG/H30cuO97j3YGYq2uMYd
	 dpAl1ssP4+I23asA/a5jaLRc6tXHABhoQpxxHhRQl8W6Ip/FUZfxuIxQZQpSOni4DU
	 lfhycdQiVAydCmeMrdXv3cOIL4d0FvJt+7y08kymdM+z1dJLSoKZyfdFeAerlfp+uB
	 8CV9EABQKzJMtmKBy+FY3F6u3m7GZ93CQ0kafSWqIGBHBJmNk+gBwV5klt4kU81Z3b
	 fCEDOAvlK8ZGg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL3nCGn92860774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 11:49:12 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 11:49:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 21 Nov 2025 11:49:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Michal
 Hocko <mhocko@suse.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2 1/2] wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
In-Reply-To: <20251118102032.54375-2-marco.crivellari@suse.com>
References: <20251118102032.54375-1-marco.crivellari@suse.com> <20251118102032.54375-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <daecde81-29d9-43e9-89d4-f7aa2010db62@RTKEXHMBS04.realtek.com.tw>
Date: Fri, 21 Nov 2025 11:49:05 +0800

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
V1FfUEVSQ1BVIGZsYWciKQo+IAo+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIFdRX1VOQk9VTkQgZmxh
ZyB0byBleHBsaWNpdGx5IHJlcXVlc3QKPiBhbGxvY193b3JrcXVldWUoKSB0byBiZSB1bmJvdW5k
LCBiZWNhdXNlIHRoaXMgc3BlY2lmaWMgd29ya2xvYWQgaGFzIG5vCj4gYmVuZWZpdCBiZWluZyBw
ZXItY3B1Lgo+IAo+IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgV1FfUEVSQ1BVIGZsYWcg
KGVxdWl2YWxlbnQgdG8gIVdRX1VOQk9VTkQpLAo+IGFueSBhbGxvY193b3JrcXVldWUoKSBjYWxs
ZXIgdGhhdCBkb2VzbuKAmXQgZXhwbGljaXRseSBzcGVjaWZ5IFdRX1VOQk9VTkQKPiBtdXN0IG5v
dyB1c2UgV1FfUEVSQ1BVLgo+IAo+IE9uY2UgbWlncmF0aW9uIGlzIGNvbXBsZXRlLCBXUV9VTkJP
VU5EIGNhbiBiZSByZW1vdmVkIGFuZCB1bmJvdW5kIHdpbGwKPiBiZWNvbWUgdGhlIGltcGxpY2l0
IGRlZmF1bHQuCj4gCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+Cj4g
U2lnbmVkLW9mZi1ieTogTWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNv
bT4KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAyMjExMTIwMDMuMWRT
dW9HeWNAbGludXRyb25peC5kZS8KCjIgcGF0Y2goZXMpIGFwcGxpZWQgdG8gcnR3LW5leHQgYnJh
bmNoIG9mIHJ0dy5naXQsIHRoYW5rcy4KCjdjYmVjMDBkYzczMSB3aWZpOiBydGx3aWZpOiBhZGQg
V1FfVU5CT1VORCB0byBhbGxvY193b3JrcXVldWUgdXNlcnMKOWMxOTRmZTQ2MjVkIHdpZmk6IHJ0
dzg4OiBhZGQgV1FfVU5CT1VORCB0byBhbGxvY193b3JrcXVldWUgdXNlcnMKCi0tLQpodHRwczov
L2dpdGh1Yi5jb20vcGtzaGloL3J0dy5naXQKCg==

