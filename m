Return-Path: <linux-wireless+bounces-21026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B0A77C27
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D6F7A2DA6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EEE2E630;
	Tue,  1 Apr 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uqRpMQTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (mailgw01.mediatek.com [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE271F930
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514367; cv=none; b=pMPMb9JOYPlCOxxEyV1mM7FbOS7RZvnC0jaxUQp2V1JDZX05kK1ge5EeROTGbT8+NQMmrRYqEXUbfGab3NFbxiQh+DaJqbMc+9zxf/6MG5CCjtUgd/1VBnAW+2oObrWovnZ24Amgdw+JKakezPHQoFpKDjiaROAyWjqY049N3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514367; c=relaxed/simple;
	bh=WbI2Sl+AnnJwcp7yBNVtQ6ux8v9W3NtusM9HJJh1DXs=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/0kL9+vUlD3J0oGDER40BQ45w06QKvt0nlB0shp7L91hSwaI06rr+YuPsNZBVs0qqp1xZ7QT74OiQx4RAnmc9E++x/X4m1+F+8SLR+w9/0zkpZPxzwnJjHabYW3hrOl9TtJwhNG8eV9QZedV8woGK9m4fEnbSJec7tab8D32eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uqRpMQTT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c807d7f00efd11f0aae1fd9735fae912-20250401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WbI2Sl+AnnJwcp7yBNVtQ6ux8v9W3NtusM9HJJh1DXs=;
	b=uqRpMQTTnIMDq/RVmF5XldtMGkfKTaCumGOlx32f6sNEwtJ3OFRoYozdVQyPDHffopRAavI1dbdkq6bnBdMwLugd2JnMRCSHWJ2Jlf+LKTciCIJGIPsjnnhB9Nd3wUGMAkbipzf/40aAcIg/mhRLCWEoYNzpec+oltWoBgmcjgk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1e9233c1-1b8b-4442-9cc4-32c049e218be,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:9deb188d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c807d7f00efd11f0aae1fd9735fae912-20250401
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1624629043; Tue, 01 Apr 2025 21:32:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 1 Apr 2025 21:32:38 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Tue, 1 Apr 2025 21:32:38 +0800
Message-ID: <66ad12add768fe0ee6936a8fff19c1dea76508cd.camel@mediatek.com>
Subject: Re: [PATCH 04/10] wifi: mt76: mt7996: rework DMA configuration for
 mt7990
From: Shayne Chen <shayne.chen@mediatek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Date: Tue, 1 Apr 2025 21:32:38 +0800
In-Reply-To: <2f4874d10d86432693c73bfcb76e56dc@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
	 <20250328055058.1648755-5-shayne.chen@mediatek.com>
	 <2f4874d10d86432693c73bfcb76e56dc@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTAzLTMxIGF0IDA1OjQ3ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6Cj4g
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lgo+IAo+IAo+IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+IHdyb3Rl
Ogo+IAo+IFsuLi5dCj4gCj4gPiAtwqDCoMKgwqDCoMKgIGlmIChpc19tdDc5OTYoJmRldi0+bXQ3
NikpIHsKPiA+ICvCoMKgwqDCoMKgwqAgc3dpdGNoIChtdDc2X2NoaXAoJmRldi0+bXQ3NikpIHsK
PiA+ICvCoMKgwqDCoMKgwqAgY2FzZSBNVDc5OTJfREVWSUNFX0lEOgo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUlhRX0NPTkZJRyhNVF9SWFFfQkFORDFfV0EsIFdGRE1BMCwKPiA+
IE1UX0lOVF9SWF9ET05FX1dBX0VYVCwgTVQ3OTk2X1JYUV9NQ1VfV0FfRVhUKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJYUV9DT05GSUcoTVRfUlhRX0JBTkQxLCBXRkRNQTAs
Cj4gPiBNVF9JTlRfUlhfRE9ORV9CQU5EMSwgTVQ3OTk2X1JYUV9CQU5EMSk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqAgY2FzZSBNVDc5
OTBfREVWSUNFX0lEOgo+IAo+IERvZXMgaXQgbWVhbiBNVDc5OTBfREVWSUNFX0lEXzIvTVQ3OTky
X0RFVklDRV9JRF8yIChzdWZmaXggd2l0aCBfMikKPiBoYXMgZGlmZmVyZW50Cj4gYmVoYXZpb3Ig
ZnJvbSBNVDc5OTBfREVWSUNFX0lEL01UNzk5Ml9ERVZJQ0VfSUQgPwo+IApUaG9zZSB3aXRoICJf
MiIgYXJlIG1haW5seSB1c2VkIGZvciB0aGUgcmVnaXN0cmF0aW9uIG9mIHNlY29uZGFyeSBQQ0ll
LgoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJYUV9DT05GSUcoTVRfUlhRX0JB
TkQxLCBXRkRNQTAsCj4gPiBNVF9JTlRfUlhfRE9ORV9CQU5EMSwgTVQ3OTk2X1JYUV9CQU5EMSk7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSWFFfQ09ORklHKE1UX1JYUV9UWEZS
RUVfQkFORDAsIFdGRE1BMCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBNVF9JTlRfUlhfVFhGUkVFX0JBTkQwX01UNzk5MCwKPiA+IE1UNzk5
MF9SWFFfVFhGUkVFMCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGV2
LT5oaWYyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFJYUV9DT05GSUcoTVRfUlhRX1RYRlJFRV9CQU5EMSwgV0ZETUEwLAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
VF9JTlRfUlhfVFhGUkVFX0JBTkQxX01UNzk5MCwKPiA+IE1UNzk5MF9SWFFfVFhGUkVFMSk7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqAg
Y2FzZSBNVDc5OTZfREVWSUNFX0lEOgo+ID4gK8KgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIG10Nzk5NiBiYW5kMiAqLwo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUlhRX0NPTkZJRyhNVF9SWFFfQkFORDIsIFdGRE1BMCwK
PiA+IE1UX0lOVF9SWF9ET05FX0JBTkQyLCBNVDc5OTZfUlhRX0JBTkQyKTsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSWFFfQ09ORklHKE1UX1JYUV9CQU5EMl9XQSwgV0ZETUEw
LAo+ID4gTVRfSU5UX1JYX0RPTkVfV0FfVFJJLCBNVDc5OTZfUlhRX01DVV9XQV9UUkkpOwo+ID4g
LcKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogbXQ3OTkyIGJhbmQxICovCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSWFFf
Q09ORklHKE1UX1JYUV9CQU5EMSwgV0ZETUEwLAo+ID4gTVRfSU5UX1JYX0RPTkVfQkFORDEsIE1U
Nzk5Nl9SWFFfQkFORDEpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUlhRX0NP
TkZJRyhNVF9SWFFfQkFORDFfV0EsIFdGRE1BMCwKPiA+IE1UX0lOVF9SWF9ET05FX1dBX0VYVCwg
TVQ3OTk2X1JYUV9NQ1VfV0FfRVhUKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFJYUV9DT05GSUcoTVRfUlhRX0JBTkQyLCBXRkRNQTAsCj4gPiBNVF9JTlRfUlhfRE9ORV9CQU5E
MiwgTVQ3OTk2X1JYUV9CQU5EMik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGRl
di0+aGFzX3Jybykgewo+IAo+IAo+IAoK


