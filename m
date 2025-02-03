Return-Path: <linux-wireless+bounces-18298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C2A256F6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 11:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EC7167C86
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7D200BBF;
	Mon,  3 Feb 2025 10:28:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B4201039
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578533; cv=none; b=B/+N6MQRdi5AVUhAf7LURJHOW08vPjJ5fWghyxMuVeh7EI0ElYVYugeF6gGVmdhXj93nrbAg4HsgM2BEelQH/zEZDNjjVdRJRClF4IOaJs1AM3fqN6ewwfyeuFasRJt9OoOSK8nbxXisJNqnPgB24uF2GD/doOTFK2TgJ7LkdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578533; c=relaxed/simple;
	bh=NXtro45yHa54yGSeJZVdFjFxpeMWIXKzW3cPWwq1Msc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmGiokm92i9RnKM5xs6fY/g8EqXTfor2lu6M4TJYJWYG/vAFetn2s1dTFWD8gKOiektSCQHm6r/swR3rtxnsiVmBXVwZ4gM2TYdJB10tOK7ykzGcYxjgF2u5uylcn0KX/jKWhkLWkL6XH0/8lK3Udb3yRgZSxXU0GDeIXHN+f+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id D665F2061E;
	Mon,  3 Feb 2025 11:28:40 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id C84AE200C7;
	Mon,  3 Feb 2025 11:28:40 +0100 (CET)
Message-ID: <bddeb2c0867139e801845c65a78fd415460bd398.camel@freebox.fr>
Subject: Re: [PATCH v9 7/9] wifi: ath12k: clean up 80P80 support
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 03 Feb 2025 11:28:40 +0100
In-Reply-To: <20250114003813.2783550-8-quic_pradeepc@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
	 <20250114003813.2783550-8-quic_pradeepc@quicinc.com>
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
dSB3cm90ZToKCkhlbGxvLAoKPiBAQCAtMjg1OSwxNiArMjg0OCwxMSBAQCBzdGF0aWMgZW51bSB3
bWlfcGh5X21vZGUgYXRoMTJrX21hY19nZXRfcGh5bW9kZV92aHQoc3RydWN0IGF0aDEyayAqYXIs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBp
ZWVlODAyMTFfbGlua19zdGEgKmxpbmtfc3RhKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
bGlua19zdGEtPmJhbmR3aWR0aCA9PSBJRUVFODAyMTFfU1RBX1JYX0JXXzE2MCkgewo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGxpbmtfc3RhLT52aHRfY2FwLmNhcCAm
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJRUVFODAy
MTFfVkhUX0NBUF9TVVBQX0NIQU5fV0lEVEhfTUFTSykgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjYXNlIElFRUU4MDIxMV9WSFRfQ0FQX1NVUFBfQ0hBTl9XSURUSF8xNjBNSFo6
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
TU9ERV8xMUFDX1ZIVDE2MDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSBJ
RUVFODAyMTFfVkhUX0NBUF9TVVBQX0NIQU5fV0lEVEhfMTYwXzgwUExVUzgwTUhaOgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE1PREVfMTFB
Q19WSFQ4MF84MDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIG5vdCBzdXJl
IGlmIHRoaXMgaXMgYSB2YWxpZCBjYXNlPyAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAobGlua19zdGEtPnZodF9jYXAuY2FwICYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIElFRUU4MDIxMV9WSFRfQ0FQX1NVUFBfQ0hBTl9XSURUSF8xNjBNSFop
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IE1PREVfMTFBQ19WSFQxNjA7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBNT0RFX1VOS05PV047CgoK
VGhpcyBicmVha3MgVkhUIDE2ME1oeiBmb3IgU1RBIHdpdGggTlNTIHJlc3RyaWN0aW9uLgoKVGhv
c2UgZG9uJ3Qgc2V0IFZIVF9DQVBfU1VQUF9DSEFOX1dJRFRIXzE2ME1IWiAoc2VlCklFRUU4MDIx
MV9WSFRfRVhUX05TU19CV19DQVBBQkxFKQoKLS0gCk1heGltZQoKCgo=


