Return-Path: <linux-wireless+bounces-35995-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BFyOfP7+mnjUwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35995-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:29:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 458BD4D7DF7
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B7B3090DA5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9593E3174;
	Wed,  6 May 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZiwPI7t6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E93E3166;
	Wed,  6 May 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055872; cv=none; b=KyU8/OMVm59TfhiNsSA+2wHGuJtjQNR82j2pOKg+YibrglpqKsseyJ6y1utiCXXUzPCK+gf3r1ZIBWYilna0eSQI2DGOG67n4mN4/AsZLarWvJ8zlI7ds8LtKhpItMA4TUqtq8hVvnZLXn0VsqCKxk3n7O10mK/cLHfSn1TFkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055872; c=relaxed/simple;
	bh=BBuRcbYSha1EQU7vIMWC0glgbxxjv4UsO/uSUMLisIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omtdcosRUTxd93oDV+5XxGsivOStOWi8NBY15CNgpj7llquJLXtElt377kRWcnBIdopfYjiuaJh1bDFUUsvwCTsKF5AdqQdgmSb/Ad2IHMcOrgtjmHE2lbjdjtBTqnaBnRKzJn8vPyzchKM2atTLhT9yQBeP+8Y2oRKrTyFM400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZiwPI7t6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468NIK101857213, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778055798; bh=BBuRcbYSha1EQU7vIMWC0glgbxxjv4UsO/uSUMLisIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZiwPI7t6WL+6c1z+0gYihIH5atl8+L27Z/uE056orAEH9OLo+suabwewLb60D8Z2+
	 fL/W9JGTjUlljaranIC08zxQQawfrmJKk0gtdJbodh+C1sTch/tQxLP7WWZQN4V4nu
	 H//iSLRG2L+KA2/5jtNusJhOBR5STfw2emQITIttEWWEb8ZW5A/vob+edvttcRNMcX
	 aXdxP55DRN+tMEWbh+uRnG4Yj3ts9MSCMDYF/AHwWWG/medFBGkf9cgnzlDXUFYU9i
	 kazdTUzAUeedyyKr1+PekeHwNoit94ANGGVeRaOBI6AxWpP8T4hNCKSj1ocV3yIOMw
	 TwWhfui5slkkA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468NIK101857213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 16:23:18 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 16:23:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:23:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 6 May 2026 16:23:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
CC: Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris
	<briannorris@chromium.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: increase TX report timeout to fix race
 condition
Thread-Topic: [PATCH] wifi: rtw88: increase TX report timeout to fix race
 condition
Thread-Index: AQHc2Xvnc+E0zgdQQUaGpSfkl/+czbX5B74AgAAWc4CAAAutAIAAAVGAgAeEJlA=
Date: Wed, 6 May 2026 08:23:17 +0000
Message-ID: <6fec8d91bf174dc99babbdf6d71767e5@realtek.com>
References: <20260501150402.227788-1-luka.gejak@linux.dev>
 <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com>
 <6CD170FE-CAED-4B91-AEED-A1AFB98FFE8A@linux.dev>
 <bc0a9969-b386-42d1-ada2-99ac39e394f3@gmail.com>
 <39E7B292-F03C-4307-B0BE-62DEC191FED8@linux.dev>
In-Reply-To: <39E7B292-F03C-4307-B0BE-62DEC191FED8@linux.dev>
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
X-Rspamd-Queue-Id: 458BD4D7DF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35995-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

PiA+PiBJIGFsc28gcmVhbGl6ZSBub3cgdGhhdCBnbG9iYWxseSBjaGFuZ2luZyBSVFdfVFhfUFJP
QkVfVElNRU9VVCB0bw0KPiA+PiAyNTAwbXMgaXMgdG9vIGhlYXZ5LWhhbmRlZC4gU2luY2UgdGhp
cyBpbXBhY3RzIGFsbCBydHc4OCBjaGlwcywNCj4gPj4gaW5jbHVkaW5nIFBDSWUgdmFyaWFudHMg
d2hlcmUgNTAwbXMgbWlnaHQgYmUgZXhhY3RseSB3aGF0IGlzIG5lZWRlZCB0bw0KPiA+PiBjYXRj
aCBhIHJlYWwgZmlybXdhcmUgbG9ja3VwLCB0aGUgYmxhc3QgcmFkaXVzIGlzIHRvbyBsYXJnZS4g
SG93IHdvdWxkDQo+ID4+IHlvdSBwcmVmZXIgSSBoYW5kbGUgdGhpcyBmb3IgdGhlIHYyIHBhdGNo
PyBJIGNhbiBlaXRoZXIgaW1wbGVtZW50IGENCj4gPj4gbW9yZSBjb25zZXJ2YXRpdmUgZ2xvYmFs
IGJ1bXAsIG9yIG1ha2UgdGhlIHRpbWVvdXQgZHluYW1pYyBiYXNlZCBvbg0KPiA+PiB0aGUgSENJ
IGludGVyZmFjZSBzbyBVU0IgZGV2aWNlcyBnZXQgYSBsb25nZXIgdGltZW91dCB0byBhY2NvbW1v
ZGF0ZQ0KPiA+PiB0aGUgYnVzIGxhdGVuY3kgZHVyaW5nIHNjYW5zLg0KDQpJJ2QgbGltaXQgdGhp
cyBjaGFuZ2UgdG8gVVNCIGRldmljZXMsIGV2ZW4gbGltaXQgdG8gUlRMODcyM0RVIHlvdSB0ZXN0
ZWQuIA0KQXMgUlRMODgyMkNVIHN1cHBvcnRzIGh3X3NjYW4sIHRoZSBzeW1wdG9tIG1pZ2h0IGJl
IGRpZmZlcmVudC4gDQoNClBpbmctS2UNCg0K

