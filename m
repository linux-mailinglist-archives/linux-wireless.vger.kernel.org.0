Return-Path: <linux-wireless+bounces-17861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24641A1A30F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA84188246B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5A20CCC3;
	Thu, 23 Jan 2025 11:36:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F6381AF
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632160; cv=none; b=QAmoZAjzu6sD9hNVlVP73bhd88Ywvilmk6SwLZXwJ58EI8ICJKqWwHSjMTFP2e+0/m5Safh6NevMFgjODAq/DoCyOvqyu5pBFhKtDZhG1VHyVS4TCfdQZD6vsuuv/2g6CUNUahxVHzMYZLYf5lmb0c+WaofUvvdGnQtyUuk971U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632160; c=relaxed/simple;
	bh=pfLLiiHoqdrsC/WZjkpRlG6mbVSuzitipeozNWTDfMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bm0Be9dt2lPjVnFHtPHbu93SpMAiuPFfaccnWQ2kfbKlWxPXXbWcw8Ni4YDw6VdGXU/WL5FMkIvzpbiugljbXx0ruPdyaBLLVsRROVtGXYjWIapGy2B6Bn/UUqw7JUxZubFEVqnyVqnKTSd2/jWp+SnKacPkjJ9REhdO7s9TYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 6395F200F2;
	Thu, 23 Jan 2025 12:35:54 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 54B282008A;
	Thu, 23 Jan 2025 12:35:54 +0100 (CET)
Message-ID: <600e45a74fc3ca1bedc12c273a84966fdfa3d908.camel@freebox.fr>
Subject: Re: [PATCH V5 4/6] wifi: ath12k: add 6 GHz params in peer assoc
 command
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Avula Sri Charan
 <quic_asrichar@quicinc.com>
Date: Thu, 23 Jan 2025 12:35:54 +0100
In-Reply-To: <20240508173655.22191-5-quic_pradeepc@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
	 <20240508173655.22191-5-quic_pradeepc@quicinc.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ck9uIFdlZCwgMjAyNC0wNS0wOCBhdCAxMDozNiAtMDcwMCwgUHJhZGVlcCBLdW1hciBDaGl0cmFw
dSB3cm90ZToKCkhlbGxvLAoKVGhpcyBwYXRjaCBoYXMgYmVlbiBtZXJnZWQsIGJ1dCB0aGVyZSBt
YXkgYmUgYSBidWcgaGVyZToKCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHN0YS0+ZGVmbGluay5iYW5k
d2lkdGggPT0gSUVFRTgwMjExX1NUQV9SWF9CV180MCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYXJnLT5id180MCA9IHRydWU7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChzdGEt
PmRlZmxpbmsuYmFuZHdpZHRoID09IElFRUU4MDIxMV9TVEFfUlhfQldfODApCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFyZy0+YndfODAgPSB0cnVlOwo+ICsKPiArwqDCoMKgwqDC
oMKgwqBpZiAoc3RhLT5kZWZsaW5rLmJhbmR3aWR0aCA9PSBJRUVFODAyMTFfU1RBX1JYX0JXXzE2
MCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXJnLT5id18xNjAgPSB0cnVlOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoc3RhLT5kZWZsaW5rLmJhbmR3aWR0aCA9PSBJRUVFODAy
MTFfU1RBX1JYX0JXXzMyMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXJnLT5i
d18zMjAgPSB0cnVlOwo+ICsKCgpEb3duc3RyZWFtIGRyaXZlciBkb2VzIHRoaXMgaW5zdGVhZDoK
CmlmIChzdGEtPmRlZmxpbmsuYmFuZHdpZHRoID49IElFRUU4MDIxMV9TVEFfUlhfQldfNDApCglh
cmctPmJ3XzQwICA9IHRydWUKWy4uLl0KCgpTbyBmb3IgYSAzMjBNaHogU1RBLCBid180MC84MC8x
NjAvMzIwIGFyZSBzZXQsIHJlc3VsdGluZyBpbiBtdWx0aXBsZQpiaXRzIFdNSV9QRUVSX3h4eE1I
WiBzZXQgdGhlIGFzc29jaWF0ZWQgV01JIGNvbW1hbmQuCgpXaGljaCBvbmUgaXMgY29ycmVjdCA/
CgooVGhpcyBpcyBmb3IgRUhULCBidXQgdGhlIHNhbWUgYXBwbGllcyBmb3IgVkhUL0hFIGNvZGUp
CgotLSAKTWF4aW1lCgoKCg==


