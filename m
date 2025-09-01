Return-Path: <linux-wireless+bounces-26882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B183B3D6C6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 04:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DCB18969BE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 02:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D827450;
	Mon,  1 Sep 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jBszrOlI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871511C84DC
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694763; cv=none; b=QE4ScXzKtRQEMCik8QcpmPQyX59dmiETHnnM+Pe39dnLNugyMib0kFSdUvUu5iMFz2HCTYNBGzI8SvN/EnS9+mf8u0oadk9uGWCCvgyvQ1BUcpy8jIq1Itggj0143R6DuD+6aO0a3AQUHZOUZTCuEXcNRw+J/7cb0LebUykZEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694763; c=relaxed/simple;
	bh=5QEutvkqtQx57Kmx3bQY3RMJRrPVbxufXKYg4PIGO6A=;
	h=From:To:Subject:In-Reply-To:References:Content-Type:MIME-Version:
	 Message-ID:Date; b=dKymZP166UVpkhrCRBSutXZ18VKiwGAN/6eIo2OYhSKjEWK4dLrmFFJQQ4wpbsl1ZVWGTlvVehRtiyvoREl6ogCLCDN6L7QYw3PA7G0b3BtPN4g4BEJs4L4Wd4ACaeYto6LiQ9IN6JirBMZRlQriFBR6MsB4WRKuJT3Pm2TlO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jBszrOlI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5812ju9V3166587, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756694756; bh=5QEutvkqtQx57Kmx3bQY3RMJRrPVbxufXKYg4PIGO6A=;
	h=From:To:Subject:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Message-ID:Date;
	b=jBszrOlI2meCCuGGjz4EuZRUn+po/dyEr61O1dFVfEqp/848Bk5YgNDH/gBuiusUZ
	 tJbGt5Eiqf1GlpiRgpFsncCJ94cLHfVJMrlT3mRz6+4h8l4OaxuX+Z6/VpJfAOs7NB
	 Vd3/sxIrJvmsiJ9+YLjp7aa1jg7nwI7fJu97WliofWN/fBPMPVHchYvDmk03E0vjEw
	 IhxiNusFwbiIzg2LFmA8ckBm+lo4UxylA4JHsLNByig0KgDicuSnSj2PAntFYMTFqz
	 Tc8c5iLNKkdaMboHty4XMhsXvB/nlZeDYI3TVm8wVmGqziQUnIemYMqCEY3wqapWFP
	 aE9JBh8B1HGZA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5812ju9V3166587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 10:45:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 10:45:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 1 Sep
 2025 10:45:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?b?0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LI=?=
	<debugger94@gmail.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: Remove TL-WN722N V2 from untested devices
In-Reply-To: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
References: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <ef9da479-5bcc-4b9b-b98e-0a17f15b7570@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 1 Sep 2025 10:45:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

PT91dGYtOD9iPzBKRFF1OUMxMExyUmdkQzEwTGtnMEtIUXZOQzQwWURRdmRDKzBMST0/PSA8ZGVi
dWdnZXI5NEBnbWFpbC5jb20+IHdyb3RlOgoKPiBJIGhhdmUgYmVlbiB1c2luZyB0aGlzIFdpLUZp
IGRvbmdsZSBmb3IgbWFueSB5ZWFycyBub3cgYW5kIGhhdmUgaGFkIG5vCj4gcHJvYmxlbXMgd2l0
aCBpdC4gVGhlIGRldmljZSBpcyBxdWl0ZSBvbGQgYW5kIGtub3duLCBkdW1waW5nIGl0cyBlZnVz
ZSB0bwo+IHRoZSBsb2cgYW5kIGFza2luZyB0aGUgdXNlciB0byBzZW5kIHRoZSByZXN1bHRzIHRv
IEplcy5Tb3JlbnNlbkBnbWFpbC5jb20KPiBvbiBldmVyeSBib290IG1ha2VzIGxpdHRsZSBzZW5z
ZS4gUGxlYXNlIGFwcGx5Ogo+IAo+ICAgICAgICAgY2FzZSAweDBiMDU6Cj4gU2lnbmVkLW9mZi1i
eTog0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LIgPGRlYnVnZ2VyOTRAZ21haWwuY29tPgo+
IFJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4KPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMKPiBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jCj4gaW5kZXggODMx
YjUwMjVjNjM0Li4xMTNlMDFkZjA5MDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMKPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L2NvcmUuYwo+IEBAIC03ODE1LDcgKzc4MTUsNyBAQCBzdGF0aWMgaW50
IHJ0bDh4eHh1X3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRlcmZhY2UsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgdW50ZXN0ZWQgPSAwOwo+ICAgICAgICAgICAgICAgICBicmVhazsK
PiAgICAgICAgIGNhc2UgMHgyMzU3Ogo+IC0gICAgICAgICAgICAgICBpZiAoaWQtPmlkUHJvZHVj
dCA9PSAweDAxMDkgfHwgaWQtPmlkUHJvZHVjdCA9PSAweDAxMzUpCj4gKyAgICAgICAgICAgICAg
IGlmIChpZC0+aWRQcm9kdWN0ID09IDB4MDEwOSB8fCBpZC0+aWRQcm9kdWN0ID09IDB4MDEwYwo+
IHx8IGlkLT5pZFByb2R1Y3QgPT0gMHgwMTM1KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHVu
dGVzdGVkID0gMDsKPiAgICAgICAgICAgICAgICAgYnJlYWs7CgpBcHBsaWVkIDEgcGF0Y2ggdG8g
cnR3LW5leHQsIHRoYW5rcy4KCmY0NmVkZDkyMDQwZiB3aWZpOiBydGw4eHh4dTogUmVtb3ZlIFRM
LVdONzIyTiBWMiAoMHgyMzU3OiAweDAxMGMpIGZyb20gdW50ZXN0ZWQgZGV2aWNlcwoKLS0tCmh0
dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvcnR3LmdpdAoK

