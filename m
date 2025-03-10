Return-Path: <linux-wireless+bounces-20113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27945A59B82
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73F4188972C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ADE235354;
	Mon, 10 Mar 2025 16:42:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BF233737
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624950; cv=none; b=UDORlDJ7xnc0MaMTfIkXEreBatVq3gvZoB/+Uxwa+Jw5Kwb590FYv2XSuIXZEpNfFQsAdClR39gSxREc8LzthzSQisamcHXEsX++Cq/tJTi3JIWCirbicIvwUjIMGMEb0opmWjOtGbRA2x/F3Zkf3kGbHP8ncb4JaBR/5B7vyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624950; c=relaxed/simple;
	bh=pP+YMvGRhxfQENT/cGVaoRvDcwFAxFOdAiyUFxX5dxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZ7IfOGjbXRIUbV+fBmISXGton+eGXW6dwsreHXfRMTlU6zYNvolhY9Ni157E08JRHpT+lYzpF8OzLU+dwU0hYNlpquXA5UafujuX4ZbY8BVCEmuZupFuCQSFmYGB+MxfGQR8vHxpJwGUMqwu21dBdjqZ/3In6VAzi08Lr7Tocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id AFD7A206E7;
	Mon, 10 Mar 2025 17:33:29 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id A17392004B;
	Mon, 10 Mar 2025 17:33:29 +0100 (CET)
Message-ID: <edcaf289872243a7a5a794ebccdc39094e130d3e.camel@freebox.fr>
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Date: Mon, 10 Mar 2025 17:33:29 +0100
In-Reply-To: <20250129155246.155587-2-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
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

Ck9uIFdlZCwgMjAyNS0wMS0yOSBhdCAyMToyMiArMDUzMCwgUm9vcG5pIERldmFuYXRoYW4gd3Jv
dGU6CgpIZWxsbywKCj4gZGlmZiAtLWdpdCBhL25ldC93aXJlbGVzcy9jb3JlLmMgYi9uZXQvd2ly
ZWxlc3MvY29yZS5jCj4gaW5kZXggNzA4NTcwMThmMDIwLi4zZjRjOWVkYzJiYzggMTAwNjQ0Cj4g
LS0tIGEvbmV0L3dpcmVsZXNzL2NvcmUuYwo+ICsrKyBiL25ldC93aXJlbGVzcy9jb3JlLmMKPiBA
QCAtMTA3Nyw2ICsxMDc3LDIzIEBAIGludCB3aXBoeV9yZWdpc3RlcihzdHJ1Y3Qgd2lwaHkgKndp
cGh5KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJlczsKPiDCoMKg
wqDCoMKgwqDCoMKgfQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgLyogQWxsb2NhdGUgcmFkaW8gY29u
ZmlndXJhdGlvbiBzcGFjZSBmb3IgbXVsdGktcmFkaW8gd2lwaHkuCj4gK8KgwqDCoMKgwqDCoMKg
ICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHdpcGh5LT5uX3JhZGlvKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGludCBpZHg7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB3aXBoeS0+cmFkaW9fY2ZnID0ga2NhbGxvYyh3aXBoeS0+bl9yYWRpbywgc2l6ZW9m
KCp3aXBoeS0+cmFkaW9fY2ZnKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRlBfS0VS
TkVMKTsKPiAKCndpcGh5IGlzIGFscmVhZHkgcmVnaXN0ZXJlZCBhdCB0aGlzIHBvaW50LCBzbyBp
dCBjYW4gYmUgZHVtcGVkIGZyb20gdXNlcmxhbmQuCgpBbmQgeW91ciBwYXRjaCAyLzUgZGVyZWZl
cmVuY2VzIHJjZmctPnJ0c190aHJlc2hvbGQgaW4gd2lwaHlfZHVtcCgpLCBzbwp0aGVyZSBpcyBh
IHJhY2UgZm9yIGEgTlVMTCBkZXJlZiAoS0FTQU4gY2F1Z2h0IGl0KS4KCi0tIApNYXhpbWUKCgoK



