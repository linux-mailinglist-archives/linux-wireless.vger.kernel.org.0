Return-Path: <linux-wireless+bounces-7933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C663B8CBBA4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824C8281EFD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949DB79950;
	Wed, 22 May 2024 06:59:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AE78C9D
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361190; cv=none; b=J9+eyfWmyS/inbRUI5h12ZHvV/E/ddF9GKXMpb2tdvi2hkMWr/2lLz8uaZNHZebIf0/0R38URWwyXr9b2Y0F9lzjEB4yG93+utk4k8tKsVno5d8tfdpVIIZ9q7AYRjQHmLnIzTidJ37fDusWpzXzreT+k9ITPI2KOnrEFKbNmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361190; c=relaxed/simple;
	bh=wsxSGloW+BGPb6c9GBu5U6/llzMI9fY/zmDXZeHukBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQjj1pmUg4nzsNw0iLuME6obLWghsy3Au8zQ0FFnax7Gyk7jD3YsTMxMyvT0XsR/3D7G6pgPRaiSNE5lfbwZFiI2MCQMyPd4jkzjsEy/YLQpPYZ0oVrU8du4PN7SUR9cC3oxMhLDWd40KcCAb7kCKO094Rv+wwAdRMVLuaAfI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M6xHMa93600619, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M6xHMa93600619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:59:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 14:59:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 22 May 2024 14:59:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 22 May 2024 14:59:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nicolas Escande <nico.escande@gmail.com>,
        P Praneesh
	<quic_ppranees@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo reinject
Thread-Topic: [PATCH 3/3] wifi: ath12k: fix firmware crash during reo reinject
Thread-Index: AQHaqoOMAZpcKtnhVEezJfeoyqWDRrGg3MgAgAH5BxA=
Date: Wed, 22 May 2024 06:59:17 +0000
Message-ID: <d276dbb98e1d4b82ada054e1e54f48e8@realtek.com>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
 <20240520070045.631029-4-quic_ppranees@quicinc.com>
 <D1F6ZU89YWPF.X1SZ9JNQNPFC@gmail.com>
In-Reply-To: <D1F6ZU89YWPF.X1SZ9JNQNPFC@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Tmljb2xhcyBFc2NhbmRlIDxuaWNvLmVzY2FuZGVAZ21haWwuY29tPiB3cm90ZToNCg0KWy4uLl0N
Cg0KPiA+IC0gICAgIHJlb19lbnRfcmluZy0+cXVldWVfYWRkcl9sbyA9IHJlb19kZXN0X3Jpbmct
PnJ4X21wZHVfaW5mby5wZWVyX21ldGFfZGF0YTsNCj4gPiAtICAgICByZW9fZW50X3JpbmctPmlu
Zm8wID0gbGUzMl9lbmNvZGVfYml0cyhkc3RfaW5kLA0KPiA+ICsgICAgIHJlb19lbnRfcmluZy0+
cXVldWVfYWRkcl9sbyA9IGNwdV90b19sZTMyKGxvd2VyXzMyX2JpdHMocnhfdGlkLT5wYWRkcikp
Ow0KPiA+ICsgICAgIHF1ZXVlX2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHJ4X3RpZC0+cGFkZHIp
Ow0KPiBTaG91bGRuJ3QgdGhlcmUgYmUgYSBjcHVfdG9fbGUzMiBzb21ld2hlcmUgaGVyZSA/IEl0
IGp1c3Qgc2VlbXMgYXN5bWV0cmljYWwNCj4gYmV0d2VlbiB0aGUgdHdvIHZhbHVlcyBleHRyYWN0
ZWQgZnJvbSByeF90aWQtPnBhZGRyDQo+ID4gKyAgICAgcmVvX2VudF9yaW5nLT5pbmZvMCA9IGxl
MzJfZW5jb2RlX2JpdHMocXVldWVfYWRkcl9oaSwNCg0KbGUzMl9lbmNvZGVfYml0cygpIHdpbGwg
Y29udmVydCBxdWV1ZV9hZGRyX2hpIGZyb20gY3B1LW9yZGVyIHRvIGxlLW9yZGVyLg0KDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSEFMX1JFT19FTlRS
X1JJTkdfSU5GTzBfUVVFVUVfQUREUl9ISSkgfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICBsZTMyX2VuY29kZV9iaXRzKGRzdF9pbmQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSEFMX1JFT19FTlRSX1JJTkdfSU5GTzBfREVTVF9JTkQp
Ow0KPiA+DQo+ID4gICAgICAgcmVvX2VudF9yaW5nLT5pbmZvMSA9IGxlMzJfZW5jb2RlX2JpdHMo
cnhfdGlkLT5jdXJfc24sDQo+IA0KDQo=

