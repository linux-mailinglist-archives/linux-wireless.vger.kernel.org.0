Return-Path: <linux-wireless+bounces-30115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B702CDE52A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 05:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 024483000E9D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546D1D63C7;
	Fri, 26 Dec 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M/1KTWUz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED734800
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766723964; cv=none; b=LTpldt65hc6YY7oZBFxTmrpisK3fV2Z4LKhf1LNN9RRVFyKK8blXUTiv2Ds+6o55b/BDDtiUQr61PpyeCALHqwaedUO75OoX1b0S1mM3jxAdxmJ3lY6CR/esoza/bmDzhjr1kwTRX2jVXHHx2TaXx9i1H8aN4H61l7sY2YuB63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766723964; c=relaxed/simple;
	bh=xi+oN0znUXxonOVgNTZtyryeyFVuTiA/9U+mPgxOC5I=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=H5AJ72zhBKapKmwUpP96YeOn1ld9cggOCnGRhnCfyYQconv8Azyrcxxg+4Wqh6aYPjvKHab9+snaKz2TsFHvJdegEm9MUtDuHTeRnDF9meHhp1yJKIvN8oWtvZUMjrGnSUYrxXpmSwxaoSCJuTDugFYzJmo83ZWi4TNicvG6VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M/1KTWUz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ4dJwE52955568, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766723959; bh=xi+oN0znUXxonOVgNTZtyryeyFVuTiA/9U+mPgxOC5I=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=M/1KTWUz4s0ZMy2XBNHLSg17Pa5vK2GDg3tDl6H99VJ5wBw5Z6DePymzEVPFf7RG5
	 FSlsbfiASHYUMeAtaWT6PmLK07s8RNZNYRvzFG63y+dLJudLYLLyYs3qIZFSYblT5P
	 ze3moQvb9QokDbXoQo4GTXmgbnozlReLPGlkQQ0aSsMRYPVNDZsZnVb6dPEhRUW5JD
	 UI3+0wHIpV4nmsWnyqxhhA+LLmaFRWhJIrnbHmwrn/2rrDF7swq1lQmboFZPezAYpR
	 Qn60T1pICMOog2kjVtY0MOqWCC4NpF6DMpsvetv2DXhFLjBB4jJ/IIk3RzgPACLBu/
	 o/wh498U+Dktw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ4dJwE52955568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 12:39:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 12:39:19 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 12:39:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 12:39:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Increase the RX gain before scanning
In-Reply-To: <c2e72aff-190d-4f59-9914-2588de756385@gmail.com>
References: <c2e72aff-190d-4f59-9914-2588de756385@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <4d11a915-17d4-4d79-aa6c-f4795c324666@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 26 Dec 2025 12:39:18 +0800

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOgoKPiBGcm9t
OiBNYXJ0aW4gSHLFr3phIDxtYXJ0aW4uaHJ1emExMjNAZ21haWwuY29tPgo+IAo+IFRoZSBkcml2
ZXIgcmVkdWNlcyB0aGUgUlggZ2FpbiB3aGlsZSBjb25uZWN0ZWQgdG8gYSBuZXR3b3JrIGxvY2F0
ZWQKPiBjbG9zZSBieS4gSW4gdGhpcyBjb25kaXRpb24gc2NhbnMgcmV0dXJuIGZldyByZXN1bHRz
IGJlY2F1c2UgdGhlIG1vcmUKPiBkaXN0YW50IG5ldHdvcmtzIGNhbid0IGJlIGhlYXJkLgo+IAo+
IFRlbXBvcmFyaWx5IGluY3JlYXNlIHRoZSBSWCBnYWluIGJlZm9yZSBzY2FubmluZyBpbiBvcmRl
ciB0byBkZXRlY3QKPiBhbGwgYXZhaWxhYmxlIG5ldHdvcmtzLiBSZXNldCB0aGUgUlggZ2FpbiBi
YWNrIHRvIHRoZSBsYXN0IHJlY29yZGVkCj4gdmFsdWUgb25jZSB0aGUgc2NhbiBmaW5pc2hlcy4K
PiAKPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vbHdmaW5nZXIvcnR3ODgvaXNzdWVzLzMzNwo+
IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBIcsWvemEgPG1hcnRpbi5ocnV6YTEyM0BnbWFpbC5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+Cj4gQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPgoKMSBwYXRj
aChlcykgYXBwbGllZCB0byBydHctbmV4dCBicmFuY2ggb2YgcnR3LmdpdCwgdGhhbmtzLgoKM2Y5
MDk0MjQ3M2QyIHdpZmk6IHJ0dzg4OiBJbmNyZWFzZSB0aGUgUlggZ2FpbiBiZWZvcmUgc2Nhbm5p
bmcKCi0tLQpodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL3J0dy5naXQKCg==

