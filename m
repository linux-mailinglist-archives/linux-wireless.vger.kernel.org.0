Return-Path: <linux-wireless+bounces-91-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA777F97DE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E843D280CED
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 03:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FB20E0;
	Mon, 27 Nov 2023 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rLECmpSL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="s77PxyJc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F553D9
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 19:15:56 -0800 (PST)
X-UUID: 4201c3128cd311ee8051498923ad61e6-20231127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YUvsRzyw1KL6WXbbBtAkMwh5IT4WzeuX/mOAgygBdPw=;
	b=rLECmpSLf1/SOdiTvzbnT+oi3/+5e4jJlD+h7ovZQdoDI9c+rXqmfReTD7+g1XDE8/zCO7CezaFdMjgJA/vsF821h4S65myLw/WD6CNSTJSIUtN9nNb049aWTB4QegF2u5K2+T936V0BJIoo5oRIUnyhR5hDq4akX+WA1/OnAJM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:edf57c2b-dd62-4964-ab9a-ee84cc2afe51,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:cac48160-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4201c3128cd311ee8051498923ad61e6-20231127
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2121169660; Mon, 27 Nov 2023 11:15:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 27 Nov 2023 11:15:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 27 Nov 2023 11:15:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vkchiy+S4YpFPBu1cisRoh0+1VYFuirMS7KrQNaobbMn+tAvnFt7Tuy2vrgf+0+gZLQVxL2NRx6kDFXOfQnNlx1SaZmchTshbd7RRwtXaPFsSlvZPAeCrFNl53t10wPw+t+BphFW9xlhtaDwFFDpmwkd1nJ2LqfHLzwP0/GfmPsyQNqg+sXsA2/i9V1c6TdUP3Sdn+zYqOPpFWjJVxRAyQYO81rCoB9AAsWjxDN3/jqd+dNay21E6UZFji0hzbaIzi7diRKpjRPnD8SQRsCbbkKjIikoFNeH94aQjC6+mfFlPdXkpe+VlcseL1+qt4SOX/LdsrlWQhNNFGj7mkWaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUvsRzyw1KL6WXbbBtAkMwh5IT4WzeuX/mOAgygBdPw=;
 b=PTOsQttszv3XgPjN0lpKMA3CrXLF/b6RFt1qS2TugFqPtLZggZK3d8TcZcnn56zpfguayW393RbMVZjlTBvu8WjNuqY0WrSvEJIWdg2PNClrgAduKdjdTh3W+fyMBLzR7zWyGRyQHvv0FGkb4wwxP1P5qQlZSUFjKPlDrIalhEhOIE8hLhjmJOClehvOl8P3JTFlgJSf19qAfedqGHTgQmraUtWU09NFlpqNBcITsteuE1W3JcJ0JaE0dh0Z5YjApUIhxuJABvZU/kO1dAWTSZSavUbSooHddfa0Jp7YniWNIL3i+yhdmj4prM5gkvrbbrzAtbfXJSQIpkUb533nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUvsRzyw1KL6WXbbBtAkMwh5IT4WzeuX/mOAgygBdPw=;
 b=s77PxyJcsTamtwDr8wmdxNbxzzodpom1FPnHslFz3j4uWGSrx5GaZkp/asGdLCC0tSzl/aNsZgvKlMQaFNPfi4w0BKbAatCSfFMfAz8mB6xHpQ6GT/DpX5Nh+jkGYIDzdYILQ9BCxYkHat8hjfSe+6msCUQITRsJGZCIDElwsnQ=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by TYZPR03MB5775.apcprd03.prod.outlook.com (2603:1096:400:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 03:15:43 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::30b1:4c15:efa0:b4b5]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::30b1:4c15:efa0:b4b5%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 03:15:42 +0000
From: =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"nbd@nbd.name" <nbd@nbd.name>, =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?=
	<Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	=?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= <Money.Wang@mediatek.com>
Subject: Re: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
Thread-Topic: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
Thread-Index: AQHaFda3G7NT7MxiRkyvQdmOTr3mLLCJ7hAAgAOmQ4A=
Date: Mon, 27 Nov 2023 03:15:42 +0000
Message-ID: <b4b3a5b0e6cf03564c6d09f01688dd41df5fe137.camel@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
	 <20231113021107.13110-2-michael-cy.lee@mediatek.com>
	 <9dd37c008572bb0938bd0d0a0fa207dd70aa8b98.camel@sipsolutions.net>
In-Reply-To: <9dd37c008572bb0938bd0d0a0fa207dd70aa8b98.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|TYZPR03MB5775:EE_
x-ms-office365-filtering-correlation-id: adc0d92a-11d6-4645-8503-08dbeef723b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBU9c3gJmbxCQgiSfWGG33KsnA+t7wP9qsYIUraTEcNH1IHiqujCNnsRGcF1RvZZBnfTaXV+hm0PLZpgmb5vO7GBTDRZHPqsRNFzbotp1HydoJ8Xrvqyto0CHZU/v60sRXHHFE5xxXvMKEgNq9BTa1VHdE+iodoP2F9VJrZ/M8A0Gjy472doeFocmLE8sjyAPxr5X7pIWRRRKyFliEIVx/lth5wEify3IX6QZmYiuR3SGKjtOiY3l5GtaZCVNgDlDZ7on+dckZVz/ZeNeI+TqQqDavzRVBe+frHYx4TCtQITt6W3ZUps5xq+mO2WvVaGtJSZ0yLpvZb+3X5DbHjNBNi6dpO5Ik3KeHRx7v4/GTcJaTusSCA8nK3eR0JG1g8/l5z2KtN8qkCtAmfV/bnBjtRJ3Rrj2FHLfOIavzJQKIcXQ5gl+9aZZEMeqNwColvWlPrQH7uu0mIwLDEE7MOmkRRdYXIkLfSoqr5ie4nzoJPrxRiVyLkQReVxE3PRwjZux3EJTUM8FazYU3xY2QzrNtdnnBjjymnWA7OWWn+95FSKqMvw4BXtE6XZ4k/UNWvE/DWJRci2cOYflgomYitUZUeg61cQqbaOfs3lw9Xj/HxdhCDNi8SCOdL0L3bkOcFul9aequjUxgWs+ZwjoV23fVlahTWBt3+vaiRm10lBA8x+7yiILumW1mQyvGVL6zXBmfn9Doa9zzNeAvdFUJrE/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(2616005)(6512007)(478600001)(71200400001)(107886003)(26005)(122000001)(85182001)(36756003)(86362001)(38100700002)(38070700009)(2906002)(5660300002)(83380400001)(4001150100001)(6506007)(8676002)(4326008)(66946007)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(8936002)(41300700001)(76116006)(110136005)(91956017)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWxlTnJOcVhzeWFQejNVdGZOWHJEWDgxTjZoSllIcDBYZmw2U0lHL3FMVkpw?=
 =?utf-8?B?M2IwaWkydFYvc2YrT1lUQjRjai9ncllQYitwQ1ZBODRPeklacG9NYUFwcE0r?=
 =?utf-8?B?RWpUK1hKMkEzT1VqM2FsbHdoWURxblFMT09mWThrVWVJWG1lekV3N29KR08z?=
 =?utf-8?B?VnkzazVka0ZsYUNDaDY3bHRNNnJ4RU5HQndCbEF0ZitiZ0lIcGRlLzB3RUdP?=
 =?utf-8?B?bWtKVjNzZFBaNTluMDljdzV4S2dyK0Z1WHVJTi94MzBacHdVa3kxSitmNmx2?=
 =?utf-8?B?NjFzWGNaN2JweDhlWlVORTh2QWlUZzJEVDZnVzRQQi9ZdXJYQzlHME8ycFQ3?=
 =?utf-8?B?NDY5eEl0MnhlWU5BOWlCMFZRUnpMM2Q0bkNnUFV3QXRFY1Z1VlhTd1J5QURW?=
 =?utf-8?B?bjI2eUJJNjJEYjFTeUVYOUNZOHNCcVZPZTBtdHFsZGM3UUVDWFV2clpKK2Vq?=
 =?utf-8?B?L0I5TXlTNkJnWjVtSDNXaEtwdkMvUDczYUYwVkRpN1Vobm9kOWpMRDVHWDlX?=
 =?utf-8?B?d3dmdkZTanBKSHdBb21MRmhPZFVYclBTZzI3N0IwN2k4UlVPS0FsbkZtempM?=
 =?utf-8?B?YnFJMzlKdDVoTFk3MnE2WWhiVW9sMkJodGZXSWZ2V2x5bFl6dmVBckZ5aHBv?=
 =?utf-8?B?Ry8vODBpV1BJTXFCdW1NTEhxcXdhRTdtZ3Y3d2d5VkVDUzdBR2p5MUxSZERB?=
 =?utf-8?B?d3ZaZmJMSkdpTktRWFdUQXBCVGRheUFkdFpIbkc0U1N0eklab0EyMmJ1Sndj?=
 =?utf-8?B?MGtLamtoS2hBamhGcEIycUtIZWM5ZUZWSzVFMDNjQkx3SzN2cWQrNGdMaHIy?=
 =?utf-8?B?Qnp6YjBGM2NpRUJnL1hjSTQrcVovRlc2ZE96U1o5eUZ5RUpDWUs1cmVRT2FG?=
 =?utf-8?B?aVJzbHNOSmdOaHNZZkFBVkRmc3B5TkluQ0hYQm5lZnVEMjNXR0dTaFN1Sncz?=
 =?utf-8?B?Rm83anpwdHVUcHNNOWJ3V3NEWmxOcFZuK2NyeldzWUpOSW4vL25aL0FmMyt4?=
 =?utf-8?B?Q0tXcDBHd3ovQ3luVk9jR2t6MS9jZTVST2cvcG9GM1FzYzI1OUF1RXJEUk5K?=
 =?utf-8?B?UVRqSHBOaHk0MG04a1l0Wk9RdVlZV0dhdGo1Uy9WYUdRckZYMk9hZ1dmaXhp?=
 =?utf-8?B?WEZYMEQwTStwblhLbEVBODF4dkJTRVZKd3R6V252cHhqcStlY3VCLzdDZDdn?=
 =?utf-8?B?NHVHbkZxaG5QSkhJT2kyNUhtZUw3L3BkQ2duaDNEcTZqWVJUSGJKSVROcUMv?=
 =?utf-8?B?ME1BdTFwdGNMOEI2dkJseUNwaEJ0aUpQZjNJM2VXYmdPbnR6b3phN3UxOTMr?=
 =?utf-8?B?N1FWbGdWMlR0R0N6NGN1Y09nNG1Gd2lPWXZyRzBEdFZpbWk4dFQ5dlk0Q1gx?=
 =?utf-8?B?RVo5VW1IbVE5Ti9QS2lXSmtqN0owODc2L2tRQlVBWmZmZUZHdE10R3JKS1Bh?=
 =?utf-8?B?d0NLWFFjRndScnJ1Z090MUl0RlNjWWxGV1dTR3ZLMkVLQjQ5eUF6eVA2OUJi?=
 =?utf-8?B?ZW9zbWV1UGtIRjB6RDdFaFRCTnIyM1c5dE1yanZkSWRtZGloMlQ2Q005U2FV?=
 =?utf-8?B?c1FOMjZBS1ZOT2FWKzIzWVhrU1gwUVBpT25HMXZqSWVIRWxTS2RxZVp2b1VG?=
 =?utf-8?B?bE9Nc1lqUXdRcGcvNnFHOFQwQWM3L0lMZ1l3WGxsT0JJMlVDQkVyaG96aHZF?=
 =?utf-8?B?bzI2YkoraEFHK0pWVEhacVNxOHA1OXVtT0xCSXdDZTFQbkpyc2NUelZnT1Rj?=
 =?utf-8?B?R1NKeHRHWHFQUFQxOTcwWnJkTjUvR3RtV3NYeFl1RUMxaTE0bjRDYjdoZ2Vi?=
 =?utf-8?B?elUwaHdyTzZSck5vQmYvRFJyTlpzWHp0OWx6cEZmSFdLcVl0aU5QcG5LMmxY?=
 =?utf-8?B?SDIwSkpYdnhYcUpMK0YvK2s1WldSNmVhcm1kdzVjc0tVeXBUQ3hhRnpXUmFy?=
 =?utf-8?B?cUZ0MTJ1UHdHZW1XR0M2ejhOSXJlZmVGa1loQitXSDJ4eTJwQ1pQcXBqNWNs?=
 =?utf-8?B?aEk2TG1UK1hsQUs1OGxaQnh1dnY2RUZtU2tWM0ZhZ0dNVTdib3lhTEQ5MDBr?=
 =?utf-8?B?MUV2QU83Zm1id1ROaUxmT2RtRC9DZkJVSTNCR2dGK1FwWEJCc21LWTdnN2lF?=
 =?utf-8?B?cWhVSlZVL1pLRkdENFYzVHdxWWpsQTY5Z204NWdhV3A1bk1aYkVHMlJjUDlG?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2861E0E18329B747952BDB7A1507CCD9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc0d92a-11d6-4645-8503-08dbeef723b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 03:15:42.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo3Qt/bCtfeo+0KvEcDc+vwJvVKY497P/ZcPDd5ACDqO1ooOuNi80GqAFbkXwdIpBaojRHzTv19rwUrQyY90X+Fb7H0ARgmwvqcShDIUXMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5775

SGkgSm9oYW5uZXMsDQoNCk9uIEZyaSwgMjAyMy0xMS0yNCBhdCAyMDozMSArMDEwMCwgSm9oYW5u
ZXMgQmVyZyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBNb24sIDIwMjMtMTEtMTMgYXQgMTA6
MTEgKzA4MDAsIE1pY2hhZWwtQ1kgTGVlIHdyb3RlOg0KPiA+IA0KPiA+ICtuZXdfY2hhbl93aWR0
aCA9DQo+IGllZWU4MDIxMV9vcGVyYXRpbmdfY2xhc3NfdG9fY2hhbl93aWR0aChvcF9jbGFzcyk7
DQo+ID4gK2lmICghaWVlZTgwMjExX29wZXJhdGluZ19jbGFzc190b19jZW50ZXJfZnJlcShvcF9j
bGFzcywgY2hhbiwNCj4gPiArICAgICAgJmNlbnRlcl9mcmVxMSwNCj4gPiArICAgICAgJmNlbnRl
cl9mcmVxMikpIHsNCj4gDQo+IFVubGVzcyBJIG1pc3NlZCBpdCwgSSBzZWUgdHdvIHBsYWNlcyBo
ZXJlIGNhbGxpbmcgaXQgdG9nZXRoZXIsIHNvDQo+IHNlZW1zDQo+IHJlYXNvbmFibGUgdG8gZmls
bCBpbiBhIGNoYW5kZWYgaGVyZSBpbnN0ZWFkPw0KPiANCj4gPiArbmV3X2NoYW5fd2lkdGggPQ0K
PiBpZWVlODAyMTFfb3BlcmF0aW5nX2NsYXNzX3RvX2NoYW5fd2lkdGgob3BfY2xhc3MpOw0KPiA+
ICtpZiAoIWllZWU4MDIxMV9vcGVyYXRpbmdfY2xhc3NfdG9fY2VudGVyX2ZyZXEob3BfY2xhc3Ms
IGNoYW4sDQo+ID4gKyAgICAgICZjZW50ZXJfZnJlcTEsDQo+ID4gKyAgICAgICZjZW50ZXJfZnJl
cTIpKSB7DQo+IA0KPiANCj4gSGVyZSB5b3UgaGF2ZSBpdCB0b28uDQo+IA0KPiANCj4gPiArbmV3
X2NoYW5fd2lkdGggPSBOTDgwMjExX0NIQU5fV0lEVEhfMjA7DQo+ID4gK2NlbnRlcl9mcmVxMSA9
IGNoYW4tPmNlbnRlcl9mcmVxOw0KPiANCj4gQW5kIGFjdHVhbGx5IHlvdSBjb3VsZCBqdXN0IGhh
dmUgYSBjaGFuZGVmIGNyZWF0ZWQgd2l0aA0KPiANCj4gICAgIGNmZzgwMjExX2NoYW5kZWZfY3Jl
YXRlKCZjaGFuZGVmLCBjaGFuLCBOTDgwMjExX0NIQU5fV0lEVEhfMjApDQo+IA0KPiB3aGljaCBt
aXJyb3JzIHRoZSBmYWlsdXJlIGNhc2UgaGVyZSwgYW5kIGp1c3Qgbm90IHVwZGF0ZSBpdCB3aGVu
DQo+IHNvbWV0aGluZyBsaWtlDQo+IA0KPiAgICAgaWVlZTgwMjExX3VwZGF0ZV9jaGFuZGVmX2Zy
b21fb3BfY2xhc3Mob3BfY2xhc3MsICZjaGFuZGVmKQ0KPiANCj4gcmV0dXJuZWQgZmFsc2UgKG5v
dCB0aGF0IEkgbmVjZXNzYXJpbHkgdGhpbmsgdGhhdCBuYW1lIHNob3VsZCBiZQ0KPiB1c2VkLikN
Cj4gDQo+IE9yIGp1c3QgcGFzcyB0aGUgY2hhbm5lbCwgYW5kIG1ha2UgaXQgY3JlYXRlIG9uZSB3
aXRoIFdJRFRIXzIwIGluIHRoZQ0KPiBmYWlsdXJlIGNhc2U/DQo+IA0KPiAgICAgaWVlZTgwMjEx
X2NyZWF0ZV9jaGFuZGVmX2Zyb21fb3BjbGFzcyhjaGFuLCBvcF9jbGFzcywgJmNoYW5kZWYpOw0K
PiANCj4gd2hpY2ggaXMgaXMgbWF5YmUgZXZlbiBuaWNlcj8NCg0KR29vZCBzdWdnZXN0aW9uIQ0K
V2UnbGwgZGVjaWRlIHdoaWNoIG9uZSBpcyBiZXR0ZXIuDQoNCj4gDQo+IEknbSBhbHNvIG5vdCBx
dWl0ZSBzdXJlIHdoeSB5b3UncmUgY29udmVydGluZyB0byBvcGVyYXRpb24gZWxlbWVudHMNCj4g
Zmlyc3Q/DQoNClRoZSBvbGQgZmxvdyBhbHNvIGNvbnZlcnRlZCB0aGUgRWxlbWVudCB0byBvcGVy
YXRpb24gZWxlbWVudHMgZmlyc3QsDQp0aGVuIGl0IHVzZWQgaWVlZTgwMjExX2NoYW5kZWZfdmh0
X29wZXIoKSB0byBidWlsZCB0aGUgbmV3IGNoYW5kZWYgZnJvbQ0Kb3BlcmF0aW9uIGVsZW1lbnRz
Lg0KDQpXZSB0aGluayBpdCdzIG5lY2Vzc2FyeSBmb3IgdGhlIGNhc2UgdGhhdCBBUCBpcyB0cnlp
bmcgdG8gc3dpdGNoIHRvIGENCjE2MCBNSHogYmFuZHdpZHRoLCB3aGlsZSB0aGUgU1RBIGRvZXNu
J3Qgc3VwcG9ydCB0aGUgMTYwIE1IeiBiYW5kd2lkdGguDQoNCkp1c3QgbGlrZSB3aGF0IGhhZCBi
ZWVuIGRvbmUgZHVyaW5nIHRoZSBhc3NvY2lhdGlvbiwNCmllZWU4MDIxMV9jaGFuZGVmX3ZodF9v
cGVyKCkgY2hlY2tzIHRoZSBTVEEncyBjYXBhYmlsaXRpZXMgYW5kIGJ1aWxkcyBhDQp2YWxpZCBj
aGFuZGVmIGZvciB0aGUgU1RBLiBIb3dldmVyLCBldmVuIGlmIHRoZSBTVEEgZG9lc24ndCBzdXBw
b3J0IHRoZQ0KMTYwIE1IeiBiYW5kd2lkdGgsIGllZWU4MDIxMV9jaGFuZGVmX3ZodF9vcGVyKCkg
ZG9lc24ndCBtYXJrIHRoZQ0KY29ubl9mbGFncyBhcyBJRUVFODAyMTFfQ09OTl9ESVNBQkxFXzE2
ME1IWiwgc28gdGhlIHNhbWUgY2hlY2sgaXMNCm5lY2Vzc2FyeSB3aGVuIGhhbmRsaW5nIENTQS4N
Cg0KTGlrZSB3ZSBoYWQgZGlzY3Vzc2VkIGluIHByZXZpb3VzIG1haWwsIHdlIGV4cGVjdGVkIHRo
ZSBwYXRjaCB3aWxsIGJlDQpzaW1wbGlmaWVkLg0KSW4gc3VtbWFyeSwgdGhlIHN0ZXBzIGZvciBT
VEEgdG8gaGFuZGxpbmcgQ1NBIGFyZSwgDQoxLiBwYXJzZSB0aGUgbmV3IGNoYW5uZWwgaW5mb3Jt
YXRpb24gZnJvbSBlaXRoZXIgb3BlcmF0aW5nIGNsYXNzIG9yDQpXQkNTIEVsZW1lbnQuDQoyLiBj
b252ZXJ0IHRoZSBjaGFubmVsIGluZm9ybWF0aW9uIGludG8gY29ycmVzcG9uZGluZyBvcGVyYXRp
b24gRWxlbWVudA0KKEhUL1ZIVCBpbiA1IEdIeiBiYW5kIGFuZCBIRS9FSFQgaW4gNiBHSHogYmFu
ZCkNCjMuIEJ1aWxkIGEgdmFsaWQgY2hhbmRlZiBmcm9tIHRoZSBvcGVyYXRpb24gRWxlbWVudC4N
Cg0KPiANCj4gam9oYW5uZXMNCg0KQmVzdCwgDQpNaWNhaGVsDQo+IA0K

