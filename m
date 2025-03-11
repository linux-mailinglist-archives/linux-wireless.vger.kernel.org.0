Return-Path: <linux-wireless+bounces-20149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA87A5BAD5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 09:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5350B169583
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7501DEFFC;
	Tue, 11 Mar 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EoA8z5rT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471E1DE2A4;
	Tue, 11 Mar 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681819; cv=none; b=JHiRLNlp3XNHOEUbUqbpf/NNdyJNF4OvLqzaVOU+Zaj8iSIcy8X9FXXFSYyEju5eRjYln8Q6bo59QBcZ6qKceylsgKOsnpRERf6uLfswdYcBher9AB8o+pXe8LflbRXooL5/On6MrzaCpRz48yOjJAM/IZuQGhVGySUXe1cD3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681819; c=relaxed/simple;
	bh=UUA0Y37FSi7aV58TqFjojhMJfCMHNIsS4hu80pn/VPw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iAac7C1c+YGxL3tddG9v2Ng+IGPaT0TTT11RFxlQS3OpIqvrilBgR5A1g/iQD5UlRdCh+53iJHAZxvlm8LY2WERD7C91685hIFwrpsX9yOEZeK2EtBur1c+mcTkoEmf/4MKVoh+a2DWTDnoBYP/jCfE0KncDda8flHYLKTj5Anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EoA8z5rT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52B8T1bnC585486, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741681741; bh=UUA0Y37FSi7aV58TqFjojhMJfCMHNIsS4hu80pn/VPw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EoA8z5rTuAXJASTTGSxNh9SHAEH3QXtFeCF9QqMbnysHDFNvrA8L64F0ZBuaq0fiF
	 2bLF3n1VxAQWVt4zO1b0gtlxOT7YWPMTvjUx/XnThIEPjbVVs7Sy8TUg7CXHbLQW/S
	 qTBg11cP+QqQZsUW8d+bhI+SrCMhwQ76hK6gUE8l3atuW2EvYbLooTFg4R80QPR3qQ
	 u2p8NeENIaE0Et5R7Z1LRxMlYxQu7s1UVZgHkTggPUpnbgI5W74csBaKVJs/dWSD6A
	 hQIdeGFnVupszM3O8CuxUbaJB4naolNXYZCFBpogguatfFBzvd6qARUGHoVZv37gJT
	 04dHdIU/+QpXA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52B8T1bnC585486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 16:29:01 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 16:29:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Mar 2025 16:29:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 11 Mar 2025 16:29:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>, Felix Fietkau <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
        "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
        "greearb@candelatech.com" <greearb@candelatech.com>,
        "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
        "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
        "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
        "sujuan.chen@mediatek.com"
	<sujuan.chen@mediatek.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Topic: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed
 is enabled
Thread-Index: AQHbkD+97GjFG0DhG0q+h/KT1ZUhfbNrhPNAgAAkR4CAAAIEAIAAIakAgADK8rCAAEqHgIAANknA
Date: Tue, 11 Mar 2025 08:29:00 +0000
Message-ID: <f25427774f1147d995d9fd86da071ef3@realtek.com>
References: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <b6b52bfcdb614137ac63fddfdaf9cb97@realtek.com>
 <OSZPR01MB843481965BA47B030566DF2698D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <71ed8398-4619-4793-804d-77cad36e7402@nbd.name>
 <OSZPR01MB84345D44294ACA75A863ED6B98D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <349d0fbe197a40068377e889a2311cb2@realtek.com>
 <TYCPR01MB84379512D874F722A0466D0A98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB84379512D874F722A0466D0A98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
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

PiA+Pg0KPiA+PiAgICAJbXQ3Nl9jb25uYWNfbWN1X2RlbF93dGJsX2FsbCgmZGV2LT5tdDc2KTsN
Cj4gPj4NCj4gPj4gLQlpZiAoKG10a193ZWRfZGV2aWNlX2FjdGl2ZSgmZGV2LT5tdDc2Lm1taW8u
d2VkKSAmJg0KPiA+PiAtCSAgICAgaXNfbXQ3OTE1KCZkZXYtPm10NzYpKSB8fA0KPiA+PiAtCSAg
ICAhbXRrX3dlZF9nZXRfcnhfY2FwYSgmZGV2LT5tdDc2Lm1taW8ud2VkKSkNCj4gPj4gLQkJbXQ3
OTE1X21jdV93YV9jbWQoZGV2LCBNQ1VfV0FfUEFSQU1fQ01EKENBUEFCSUxJVFkpLCAwLCAwLCAw
KTsNCj4gPj4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19ORVRfTUVESUFURUtfU09DX1dFRCkNCj4g
Pg0KPiA+IEluIE1UNzYsIHRoZXJlIGFyZSB0d28gc3R5bGVzOg0KPiA+ICAgICNpZiBJU19FTkFC
TEVEKENPTkZJR19ORVRfTUVESUFURUtfU09DX1dFRCkNCj4gPiAgICAjaWZkZWYgQ09ORklHX05F
VF9NRURJQVRFS19TT0NfV0VEDQo+ID4NCj4gPiBJIHRoaW5rIGJvdGggYXJlIGNvcnJlY3QuIEp1
c3Qgd29uZGVyIHdoeSBub3QgbWFraW5nIHRoZW0gY29uc2lzdGVudC4NCj4gU2VlbXMgeW91IGRp
ZG4ndCByZWNlaXZlIEZlbGl4J3MgZW1haWwsIGNoZWNrIHRoaXM6DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzcxZWQ4Mzk4LTQ2MTktNDc5My04MDRkLTc3Y2FkMzZl
NzQwMkBuYmQubmFtZS8NCj4gDQoNCkkgd2FzIGF3YXJlIG9mIHRoaXMuIEZlbGl4IHBvaW50ZWQg
b3V0ICdpZiAoSVNfRU5BQkxFRChDT05GSUdfTkVUX01FRElBVEVLX1NPQ19XRUQpKScNCndpbGwg
bGVhZCBidWlsZCBlcnJvci4gQnV0IHdoYXQgSSBtZW50aW9uZWQgaGVyZSB3ZXJlICcjaWYnIGFu
ZA0KJyNpZmRlZicgKHByZXByb2Nlc3MgZGlyZWN0aXZlKS4NCg0KQW55d2F5LCBpZ25vcmUgdGhp
cy4NCg0K

