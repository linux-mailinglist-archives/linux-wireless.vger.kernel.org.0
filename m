Return-Path: <linux-wireless+bounces-27267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9B8B54FE5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFD167F74
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87562FD1C3;
	Fri, 12 Sep 2025 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="TNMp5hEV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018E1F872D;
	Fri, 12 Sep 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684682; cv=none; b=EGcunhKLtLTRmjYLgUIsNOc4xL/rIgD1lEdokpehyeacYzyvikE7J4+5HiMK6ONbE0NfF0JmPOiO6dE8Ox0HQF4+nmC7narHlLV86rHFSseXBtwwEb2OfkLhiwhB94VkJLt8cWUafZfMP6piMJ7nslpe3bUZ0VkWBgPCiRQlUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684682; c=relaxed/simple;
	bh=Z0AoKpkc0fJA3nJvzIAGtyg7Egr+rKkvpFqJ7nwmzNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TxhBEj7lkBP7Z87WLuyHqR+hvOuCQJc83eeBx0ykaRdZzuI3V0MQOAHazSuQR+QZ5gK/AYXlIsyZEtYkb4HNoZxr7AJGbIEjCl0Tgp5Hk6Pq5mQvu8rpHtsr2TE6zhx7WnhHxNSlQz+3cpCGmS+ltYuFshFRbC/cwT4aYE+7Hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=TNMp5hEV reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fn0AcCThmky4/tdg5r/iJhWkSOOpbV6urVsfWz/qpxA=; b=T
	NMp5hEVLrzPlrjV/VzSN9Afm3adXlZhQdSrIReWBXdvyDq+2SEXVAHsvPVfExTJW
	EGgwxQ3BIs3b1I3bnFX463qFs81RciZXnQuwxj9J1JyF1MkYvowR3KYF6gmexZI4
	32jCFHqqp1r8lfl82Mco9fh2/M5p6lWf6o/W8zilKo=
Received: from 00107082$163.com ( [111.35.190.173] ) by
 ajax-webmail-wmsvr-40-130 (Coremail) ; Fri, 12 Sep 2025 21:44:21 +0800
 (CST)
Date: Fri, 12 Sep 2025 21:44:21 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: IWL Error Log Dump since 6.17.0-rc5
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <285c7cd9935d5c245ad478c5692faa927bcda245.camel@sipsolutions.net>
References: <20250909165811.10729-1-00107082@163.com>
 <487c99e0.6ed4.19932979ca5.Coremail.00107082@163.com>
 <285c7cd9935d5c245ad478c5692faa927bcda245.camel@sipsolutions.net>
X-NTES-SC: AL_Qu2eBfqTu04t5ySeYOkXn0oTju85XMCzuv8j3YJeN500mCXz2Cw8U1F4PFfV+fqkMhGjigm+VyZp4fxdephZYaytbZEat5SyfEZd582A9JWa
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <35b1fd7b.aa06.1993e2b7ce5.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgDXf3u2I8RoyuEBAA--.18346W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxnGqmjD9J7QQAADsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDktMTAgMTY6MzE6MzMsICJKb2hhbm5lcyBCZXJnIiA8am9oYW5uZXNAc2lwc29s
dXRpb25zLm5ldD4gd3JvdGU6Cj5PbiBXZWQsIDIwMjUtMDktMTAgYXQgMTU6NDcgKzA4MDAsIERh
dmlkIFdhbmcgd3JvdGU6Cj4+IEhpLCAKPj4gCj4+IEkgdGhpbmsgdGhvc2UgZXJyb3IgZHVtcCBp
cyBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCA1ODZlM2NiMzNiYTY4OTAwNTRiOTVhYTBhZGUwYTE2NTg5
MGVmYWJkKCJ3aWZpOiBpd2x3aWZpOiBmaXggYnl0ZSBjb3VudCB0YWJsZSBmb3Igb2xkIGRldmlj
ZXMiKQo+PiAKPj4gTXkgd2lyZWxlc3MgcGNpZSBjYXJkIGhhcyBkZXZpY2VfZmFtaWx5IDE1IHdo
aWNoIGlzIGxlc3MgdGhhbiBJV0xfREVWSUNFX0ZBTUlMWV85MDAwLCBhbmQgdGhlIGNoYW5nZXMg
aW4gdGhlIGNvbW1pdCBoYXZlIGNoYW5nZWQgdGhlIGJlaGF2aW9yIGZvciBteSBkZXZpY2VzLgo+
PiAKPj4gLSAgICAgICBpZiAodHJhbnMtPm1hY19jZmctPmRldmljZV9mYW1pbHkgPCBJV0xfREVW
SUNFX0ZBTUlMWV9BWDIxMCkKPj4gKyAgICAgICBpZiAodHJhbnMtPm1hY19jZmctPmRldmljZV9m
YW1pbHkgPj0gSVdMX0RFVklDRV9GQU1JTFlfOTAwMCAmJgo+PiArICAgICAgICAgICB0cmFucy0+
bWFjX2NmZy0+ZGV2aWNlX2ZhbWlseSA8IElXTF9ERVZJQ0VfRkFNSUxZX0FYMjEwKQo+PiAgICAg
ICAgICAgICAgICAgbGVuID0gRElWX1JPVU5EX1VQKGxlbiwgNCk7Cj4KPkkgdGhpbmsgSSBqdXN0
IGdvdCBjb25mdXNlZCwgYW5kIHRoYXQgOTAwMCBzaG91bGQgYmUgNzAwMC4gUHJlc3VtYWJseQo+
dGhhdCdkIHdvcmsgZm9yIHlvdSwgSSdsbCBzZW5kIGEgcGF0Y2guCj4KPmpvaGFubmVzCgoKSGks
IAoKTXkgc3lzdGVtIGhhcyBiZWVuIHJ1biBmb3IgZGF5cyBhbmQgbm8gSVdMIGVycm9yIGR1bXBz
ICYgcmVzZXQgaGFwcGVuZWQuCkkgdGhpbmsgSSBjYW4gY29uZmlybSB0aGF0IG15IHdpcmVsZXNz
IGNhcmQgbmVlZHMgdGhlIGxlbmd0aCBhZGp1c3RtZW50LgoKU29tZSBpbmZvcm1hdGlvbiBhYm91
dCBteSBjYXJkczoKClsgICAgNS4wNjcyNjVdIGl3bHdpZmkgMDAwMDoyMTowMC4wOiBlbmFibGlu
ZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICA1LjA2ODc5OF0gaXdsd2lmaSAwMDAwOjIxOjAw
LjA6IERldGVjdGVkIGNyZi1pZCAweDAsIGNudi1pZCAweDAgd2ZwbSBpZCAweDAKWyAgICA1LjA2
ODgwOV0gaXdsd2lmaSAwMDAwOjIxOjAwLjA6IFBDSSBkZXYgMDhiMS9jMDcwLCByZXY9MHgxNDQs
IHJmaWQ9MHhkNTU1NTVkNQpbICAgIDUuMDY4ODEzXSBpd2x3aWZpIDAwMDA6MjE6MDAuMDogZGV2
aWNlIGZhbWlseTogMTUgIDwtLSAKWyAgICA1LjA2ODgxNl0gaXdsd2lmaSAwMDAwOjIxOjAwLjA6
IERldGVjdGVkIEludGVsKFIpIER1YWwgQmFuZCBXaXJlbGVzcyBBQyA3MjYwClsgICAgNS4wNzU1
OTNdIGl3bHdpZmkgMDAwMDoyMTowMC4wOiBsb2FkZWQgZmlybXdhcmUgdmVyc2lvbiAxNy5iZmI1
ODUzOC4wIDcyNjAtMTcudWNvZGUgb3BfbW9kZSBpd2xtdm0KCiQgbHNwY2kKLi4uCjIxOjAwLjAg
TmV0d29yayBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBXaXJlbGVzcyA3MjYwIChyZXYg
YmIpCi4uLgoKCk15IGRldmljZSBtYXRjaCB0aGUgY29uZmlnIGluIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYzoKCjI2MyAgICAgICAgIHtJV0xfUENJX0RFVklD
RSgweDA4QjEsIDB4QzA3MCwgaXdsNzAwMF9tYWNfY2ZnKX0sCgppd2w3MDAwX21hY19jZmcgaXMg
ZGVmaW5lZCBhczoKCiA4OCBjb25zdCBzdHJ1Y3QgaXdsX21hY19jZmcgaXdsNzAwMF9tYWNfY2Zn
ID0geyAKIDg5ICAgICAgICAgLmRldmljZV9mYW1pbHkgPSBJV0xfREVWSUNFX0ZBTUlMWV83MDAw
LCAKIDkwICAgICAgICAgLmJhc2UgPSAmaXdsNzAwMF9iYXNlLAogOTEgfTsKCkFuZCBpbmRlZWQs
IGl0IGlzIElXTF9ERVZJQ0VfRkFNSUxZXzcwMDAKCkZZSQpEYXZpZA==

