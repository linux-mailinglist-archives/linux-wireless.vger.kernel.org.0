Return-Path: <linux-wireless+bounces-30074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94482CD7FD7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FF093013EB9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB8245019;
	Tue, 23 Dec 2025 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MI5yJh15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB0186E58;
	Tue, 23 Dec 2025 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461712; cv=none; b=UOPIfj6z+x3ZPOjOFaD771qyW8bAQdjLIQwYcRKRkHIrSTy7s5QsI5LDNq0BH8hxD4IMxCdkT9k14GP7penrOAMT7rXr2/h0Yma4w0KXta4maKIchTnSkezd4bSUcwk2Jhdz0KloJNZHeB2wAaCRvXyyOCLfiiHGqK3sPzJzAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461712; c=relaxed/simple;
	bh=otZYa13wW5DvAr7q3jzwWxwkld7QcWnX+MSJy74Lnyg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=LGUGmpxitFzwOjsQLwub+t5TvduLdvowHayy60+/4h5IqMJ2w9LR7ei3brKvCxFlZLVklXAGnhPYsVB+U2IwNKytO0hoqu1Mj6MS+25yvxCyvYlZPoLSDH7UYIwhaKQZ8GedzkorryFNvyuXMee7THaYQ3M8n1xrorrnLU1nMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MI5yJh15; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN3lt0eB630097, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766461675; bh=otZYa13wW5DvAr7q3jzwWxwkld7QcWnX+MSJy74Lnyg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=MI5yJh15GfrC/OP7hh10sSnx+3rhwLhIUbtZW5TTjI+mipHIu5ZsWBiob3AslYvYp
	 RTjbH0RZug7GnHlCzpfKWm9giOosjyp6tGIB3tfjN4rKZR69jQudq0475sW2B5CfFB
	 0o+JpCUYjTgt8Rhdg0+wUV3xBV6Bfgw7nZisVX4ywKi8jtq+wuIuqyAsq5DxsRmdub
	 ADNLWIL+hCz02hNFAZTHiG+6zrUweaNqo5zKbET3TMc/Q4QbE36iGE8IIpciOIl+tp
	 bifEPoVpZRf6WD4eVs1TGLZ5GS9jFnSs3PQkNJr6Z42s8FWfqcJP7eBQGbb+zj8Dvy
	 EABI92pGrVR4A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN3lt0eB630097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:47:55 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:47:55 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:47:50 +0800
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
Subject: Re: [PATCH] wifi: rtw89: add WQ_PERCPU to alloc_workqueue users
In-Reply-To: <20251210101209.47176-1-marco.crivellari@suse.com>
References: <20251210101209.47176-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <5fdf75e3-ac2d-44fa-9da2-54f844366dc8@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 23 Dec 2025 11:47:50 +0800

TWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4gd3JvdGU6Cgo+IFRo
aXMgY29udGludWVzIHRoZSBlZmZvcnQgdG8gcmVmYWN0b3Igd29ya3F1ZXVlIEFQSXMsIHdoaWNo
IGJlZ2FuIHdpdGgKPiB0aGUgaW50cm9kdWN0aW9uIG9mIG5ldyB3b3JrcXVldWVzIGFuZCBhIG5l
dyBhbGxvY193b3JrcXVldWUgZmxhZyBpbjoKPiAKPiAgICBjb21taXQgMTI4ZWE5ZjZjY2ZiICgi
d29ya3F1ZXVlOiBBZGQgc3lzdGVtX3BlcmNwdV93cSBhbmQgc3lzdGVtX2RmbF93cSIpCj4gICAg
Y29tbWl0IDkzMGMyZWE1NjZhZiAoIndvcmtxdWV1ZTogQWRkIG5ldyBXUV9QRVJDUFUgZmxhZyIp
Cj4gCj4gVGhlIHJlZmFjdG9yaW5nIGlzIGdvaW5nIHRvIGFsdGVyIHRoZSBkZWZhdWx0IGJlaGF2
aW9yIG9mCj4gYWxsb2Nfd29ya3F1ZXVlKCkgdG8gYmUgdW5ib3VuZCBieSBkZWZhdWx0Lgo+IAo+
IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgV1FfUEVSQ1BVIGZsYWcgKGVxdWl2YWxlbnQg
dG8gIVdRX1VOQk9VTkQpLAo+IGFueSBhbGxvY193b3JrcXVldWUoKSBjYWxsZXIgdGhhdCBkb2Vz
buKAmXQgZXhwbGljaXRseSBzcGVjaWZ5IFdRX1VOQk9VTkQKPiBtdXN0IG5vdyB1c2UgV1FfUEVS
Q1BVLiBGb3IgbW9yZSBkZXRhaWxzIHNlZSB0aGUgTGluayB0YWcgYmVsb3cuCj4gCj4gSW4gb3Jk
ZXIgdG8ga2VlcCBhbGxvY193b3JrcXVldWUoKSBiZWhhdmlvciBpZGVudGljYWwsIGV4cGxpY2l0
bHkgcmVxdWVzdAo+IFdRX1BFUkNQVS4KPiAKPiBTdWdnZXN0ZWQtYnk6IFRlanVuIEhlbyA8dGpA
a2VybmVsLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjbyBDcml2ZWxsYXJpIDxtYXJjby5jcml2
ZWxsYXJpQHN1c2UuY29tPgo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1
MDIyMTExMjAwMy4xZFN1b0d5Y0BsaW51dHJvbml4LmRlLwoKMSBwYXRjaChlcykgYXBwbGllZCB0
byBydHctbmV4dCBicmFuY2ggb2YgcnR3LmdpdCwgdGhhbmtzLgoKMzZmMmRlYjJmNTVmIHdpZmk6
IHJ0dzg5OiBhZGQgV1FfUEVSQ1BVIHRvIGFsbG9jX3dvcmtxdWV1ZSB1c2VycwoKLS0tCmh0dHBz
Oi8vZ2l0aHViLmNvbS9wa3NoaWgvcnR3LmdpdAoK

