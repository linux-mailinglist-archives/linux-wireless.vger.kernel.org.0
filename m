Return-Path: <linux-wireless+bounces-21027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B38DA77C84
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C9916AB17
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7462AF00;
	Tue,  1 Apr 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WWZOM436"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE61E4A4
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515249; cv=none; b=KpEuRtBNR1Cvv7uNgFxJbE2g6xxGRKmjHhIGy+H/r/1TMwX/w8bSsXccsRCnSph2JErczRIKN0quXbUSxwNGGlrO0qwnHn2xAvHaOys/zsDsfoAJos4+vCj1dsReUjQgZpidQQ1YQ7kii+CMfd5VF3sgcCfhFe4mf85AxCCtvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515249; c=relaxed/simple;
	bh=UKmdIz9yEkQAJPVrxeQ/9aE+lgCEA+KwLvSHeCD3Kzs=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJyuewbnOFPq8gtASqiEoJrkPMy6jJ8NWkNGYgusahnh0H4sc/GQki78Abij8l399ANZg33vhchKsNKV9V/T+IcpCgWk9NNlT81wwK2OgLpvrqaxLtzGbRwWNBOVvXfKFLufVVpgea7/ablAO3vR6fuEIu6n4xaw5RiKFhDquMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WWZOM436; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d1e4eb6c0eff11f08eb9c36241bbb6fb-20250401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UKmdIz9yEkQAJPVrxeQ/9aE+lgCEA+KwLvSHeCD3Kzs=;
	b=WWZOM436Jk6Q9dmxySBQIakhw6B5B8pDFYyFaKlUtGSS8Z4138/iQ/NiBdd73A+EbKZDL5pX7QveuHwHML4eGVpFhc2FGhora6toGcrNCKbryx8w4j0Yrnbs8mulY2h8RiUpbo7YZ/l769AbJbHW4MmUSWmrK0RNHuIwScabrqI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0efddb23-3b8c-4e02-b4c3-2f992e2d1a5e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:4b02198d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d1e4eb6c0eff11f08eb9c36241bbb6fb-20250401
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1237931697; Tue, 01 Apr 2025 21:47:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 1 Apr 2025 21:47:13 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Tue, 1 Apr 2025 21:47:13 +0800
Message-ID: <29344a3f054368ae948415d6183365a09d1fe6d5.camel@mediatek.com>
Subject: Re: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check
 for mt7990
From: Shayne Chen <shayne.chen@mediatek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Date: Tue, 1 Apr 2025 21:47:13 +0800
In-Reply-To: <59abf964667144b0ab10220e41b6b821@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
	 <20250328055058.1648755-10-shayne.chen@mediatek.com>
	 <59abf964667144b0ab10220e41b6b821@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTAzLTMxIGF0IDA1OjU1ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6Cj4g
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lgo+IAo+IAo+IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+IHdyb3Rl
Ogo+IAo+IFsuLi5dCj4gCj4gPiArCj4gPiArYm9vbCBtdDc5OTZfZWVwcm9tX2hhc19iYWNrZ3Jv
dW5kX3JhZGFyKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDC
oCBzd2l0Y2ggKG10NzZfY2hpcCgmZGV2LT5tdDc2KSkgewo+ID4gK8KgwqDCoMKgwqDCoCBjYXNl
IE1UNzk5Nl9ERVZJQ0VfSUQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
ZGV2LT52YXIudHlwZSA9PSBNVDc5OTZfVkFSX1RZUEVfMjMzKQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoCBjYXNlIE1UNzk5
Ml9ERVZJQ0VfSUQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGV2LT52
YXIudHlwZSA9PSBNVDc5OTJfVkFSX1RZUEVfMjMpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgIGNhc2UgTVQ3OTkwX0RFVklD
RV9JRDogewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggcGF0aCwgcnhfcGF0
aCwgbnNzLCAqZWVwcm9tID0gZGV2LQo+ID4gPm10NzYuZWVwcm9tLmRhdGE7Cj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdDc5OTZfZWVwcm9tX3BhcnNlX3N0cmVhbShl
ZXByb20sIE1UX0JBTkQxLCAmcGF0aCwKPiA+ICZyeF9wYXRoLCAmbnNzKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIERpc2FibGUgYmFja2dyb3VuZCByYWRhciBjYXBhYmls
aXR5IGluIDNUM1IgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwYXRo
ID09IDMgfHwgcnhfcGF0aCA9PSAzKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gCj4gVGhlIGluZGVudGF0aW9uIG9m
IGNsb3NlIGJyYWNlIGxvb2tzIHdlaXJkLgoKV2lsbCBmaXggaXQsIHRoYW5rcy4KPiAKPiBTaW5j
ZSAtV2RlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudCBpcyBkcm9wcGVkLCBJIHRoaW5rIGNvbXBp
bGVycwo+IHdpbGwgbm90Cj4gd2FybiB3aXRob3V0IHRoZSBicmFjZXMuIEJ1dCBub3RlIHRoYXQg
aXQgaXMgc3RpbGwgbm90IHJlY29tbWVuZGVkIHRvCj4gcHV0IGRlY2xhcmF0aW9ucyBpbiB0aGUg
bWlkZGxlLgo+IApTaW5jZSB0aG9zZSB2YXJpYWJsZXMgYXJlIGN1cnJlbnRseSBvbmx5IHVzZWQg
YnkgbXQ3OTkwIGNhc2UsIEkgdGhpbmsKdGhleSBjYW4gYmUgcHV0dGluZyB0aGVyZSBmb3IgdGhl
IG1vbWVudC4KCj4gPiArwqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4gPiArfQo+IAo+IAo+IAoK


