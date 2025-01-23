Return-Path: <linux-wireless+bounces-17860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE60A1A2AE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819C1188E94C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8E1FDA90;
	Thu, 23 Jan 2025 11:11:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CD20DD7F
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630704; cv=none; b=CvU382m3KmlkIUBkLcTrqkAQU6JZRbzVlMk4ov63Eyulae+iQaZ4ppAouNhgBDRkqScTXLS92MKHu8V0MIYOWMXLkO4/7nfEmggrcf5VvBoB4OnC4/dzjhzJfFNCiaI8gpPyf9BxjBxPGMMlXxpUd3cWCvFPgNyTXdtIgjYN+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630704; c=relaxed/simple;
	bh=0vD6ev/Q9izmh4qjUpLovgYp568RmpGoOLa3bA8TX4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZVYOMUhbEC3yBPKygxKkyxnInyCEYGeFZ1QBQ3uOjMz9JlEsw1XTngLT2oiZGVrEWeTU3CfW7IJTbBKAJIkAfjHeWdsBSCPPitif7rgOtuVthEHf+bs/F1v1mwIbTOFtKt5kJCRWOhu8qHmww5fBXPDJzuO6sXEMHezdOt9ajmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id EA60720172;
	Thu, 23 Jan 2025 12:06:28 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id DB2FF2012E;
	Thu, 23 Jan 2025 12:06:28 +0100 (CET)
Message-ID: <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 23 Jan 2025 12:06:28 +0100
In-Reply-To: <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
	 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
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

Ck9uIE1vbiwgMjAyNS0wMS0xMyBhdCAxNjozOCAtMDgwMCwgUHJhZGVlcCBLdW1hciBDaGl0cmFw
dSB3cm90ZToKCkhlbGxvLArCoAo+IEBAIC04Mzc2LDEwICs4NjM3LDEzIEBAIHN0YXRpYyBpbnQg
YXRoMTJrX21hY19vcF9hZGRfaW50ZXJmYWNlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LAo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGFydmlmLT5iaXRy
YXRlX21hc2suY29udHJvbCk7IGkrKykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYXJ2aWYtPmJpdHJhdGVfbWFzay5jb250cm9sW2ldLmxlZ2FjeSA9IDB4ZmZmZmZmZmY7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFydmlmLT5iaXRyYXRlX21hc2suY29udHJv
bFtpXS5naSA9IE5MODAyMTFfVFhSQVRFX0ZPUkNFX1NHSTsKCmNhbiB5b3UgZXhwbGFpbiB3aHkg
aXQncyBub3QgTkw4MDIxMV9UWFJBVEVfREVGQVVMVF9HSSA/Cgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbWVtc2V0KGFydmlmLT5iaXRyYXRlX21hc2suY29udHJvbFtpXS5odF9t
Y3MsIDB4ZmYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2l6ZW9mKGFydmlmLT5iaXRyYXRlX21hc2suY29udHJvbFtpXS5odF9tY3MpKTsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbXNldChhcnZpZi0+Yml0cmF0ZV9tYXNrLmNvbnRy
b2xbaV0udmh0X21jcywgMHhmZiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzaXplb2YoYXJ2aWYtPmJpdHJhdGVfbWFzay5jb250cm9sW2ldLnZodF9tY3Mp
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtc2V0KGFydmlmLT5iaXRyYXRl
X21hc2suY29udHJvbFtpXS5oZV9tY3MsIDB4ZmYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoYXJ2aWYtPmJpdHJhdGVfbWFzay5jb250cm9sW2ld
LmhlX21jcykpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKCgpUaGUgc2FtZSBpbml0aWFsaXph
dGlvbiBvZiBoZV9tY3MgaXMgbWlzc2luZyBpbiB0aGUgYXRoMTJrX21hY19hc3NpZ25fbGlua192
aWYoKQoKLS0gCk1heGltZQoKCgo=


