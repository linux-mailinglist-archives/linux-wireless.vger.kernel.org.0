Return-Path: <linux-wireless+bounces-29112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF16C6C261
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 42F8F29277
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2A19F115;
	Wed, 19 Nov 2025 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o6vcvKYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F6256D
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513063; cv=none; b=VTu6ePowU0Q4BJQYy2ZXls/3JuGpULn4+FhYs8hTrB5J2XkIIaai4LF0oNApGkjJABCp4X454oNA27EvktLOP6+CMWt06hqLpU5FQTOD7XKOa7Tbsc8Rzibo+oVCdW4RErCp1+kYVm0ZWnctXfg4d3f2uVb0OVsLtWu+JVN+yRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513063; c=relaxed/simple;
	bh=jndVqJf/UJ5qg1IH6sqgZyirIv6Nw3AEWKSDxl756MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WljiUptgivMYy6t38YMZY88Fcpqh3LqjF4PGbs82geqWoUNzi4fA/h3TB+hLFcJXiVWSeQdJEEjwPapvJ3ZhuQvAcwBnqbJ87phDafQlmEvS/5LzXZjzJtNakmuQXXRoiWHoUiQVn1dC/N6trsPmGInyTBsVhM/Xni4DaBpbF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o6vcvKYR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AJ0iAbfD2508472, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763513050; bh=jndVqJf/UJ5qg1IH6sqgZyirIv6Nw3AEWKSDxl756MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o6vcvKYR6b+cHzrJjvXlnp/qV4d3PqWqP4X5I/h+vc9oI2v5RocLGUEMI78xJ72cU
	 pW4uULonrjjrppcuLUt5g6OrsH+nbw20rxG6BSVDI+eG/h4tZFDFi9D+4jTRBg+JAj
	 /Z6TTaLkksi3x5HXry4nMN513m7HU/KjYIeuE6In12aAK9guBLTHIk+xrPqSJ6wuJv
	 0LWBzfCyjUtfDb99TefNRkRLkWqmFHVwIlMrVhZZAI3y99K3RgDtCUp9bal//kjHGG
	 kInkV1Lcq9U9edlD/0gwnQYPY/waym0xmfQRRMid6+Mg14qM5+0aNbFPLUqpeUunWr
	 +Nws9amVn9q7w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AJ0iAbfD2508472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:44:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 08:44:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 19 Nov 2025 08:44:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of
 reset DAC/ADC FIFO
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of
 reset DAC/ADC FIFO
Thread-Index: AQHcV3J9Ra7Q+nIfkE+v5eYr01BDIbT3th+AgAF16CA=
Date: Wed, 19 Nov 2025 00:44:11 +0000
Message-ID: <6268b32ba19b4a1690a944d6093b01e9@realtek.com>
References: <20251117032910.11224-1-pkshih@realtek.com>
 <20251117032910.11224-2-pkshih@realtek.com>
 <CAMuHMdVuThcAyVuAU=N0FM+vd1xNyk9p4bcDWJUEpsYcmh2J7A@mail.gmail.com>
In-Reply-To: <CAMuHMdVuThcAyVuAU=N0FM+vd1xNyk9p4bcDWJUEpsYcmh2J7A@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IE9uIE1v
biwgMTcgTm92IDIwMjUgYXQgMDQ6MjksIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
PiB3cm90ZToNCj4gPiBUaGUgZmllbGQgbWFzayBzaG91bGQgYmUgYml0cyAxNi0zMSwgYnV0IHN1
ZGRlbmx5IHVzZSB3cm9uZyBiaXRzIDI0LTMxLA0KPiA+IHJhcmVseSBjYXVzaW5nIGEgbGl0dGxl
IHBlcmZvcm1hbmNlIGRlZ3JhZGVkIGlmIERBQy9EQUMgRklGTyBzdGF5cyBvbg0KPiA+IGFuIHVu
ZXhwZWN0ZWQgc3RhdGUuDQo+ID4NCj4gPiBGb3VuZCB0aGlzIGJ5IEdlZXJ0IHdobyB3b3JrcyBv
biBiaXQgZmllbGQgZnVuY3Rpb25zLg0KPiA+DQo+ID4gQ2M6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBSZXBvcnRlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVu
IDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gDQoNCkkgc3VwcG9zZSB5b3UgbWVhbnQgUmV2aWV3
ZWQtYnksIGJ1dCB5b3UgYWxzbyB0aGUgcmVwb3J0ZXIuIEkgd2lsbCBhZGQNCnRoZXNlIHRhZ3Mg
YnkgdjIuDQoNCg==

