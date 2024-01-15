Return-Path: <linux-wireless+bounces-1921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE48C82D8CF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC891C20DEA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228272C699;
	Mon, 15 Jan 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DKmutMCK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PomDwsLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F42C695
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 28f13a6cb3a011ee9e680517dc993faa-20240115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+FQlJl4uaiWuOXE0OeowVT80YfNbmLZ6FIgQh01eWNE=;
	b=DKmutMCKUXwmurZMvCcfuDF6o51TghVvCnIoSKQrFZeJTTDZ+FUEz3+fphxuPD3axNTeZIrVvqlu/dHQiIGB/T5rDqsaiamQKIpS16upE0o2uBSwr32+c+wBv6i290ADXv9TiTop75uVf7rlBfcwnaGwx0vQbhC4oBXZ49iv2hU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6a2ae54a-948a-4f50-b21e-e2089edea5fb,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:e6222f2f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 28f13a6cb3a011ee9e680517dc993faa-20240115
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 192766665; Mon, 15 Jan 2024 20:18:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Jan 2024 20:18:14 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Jan 2024 20:18:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIq6u00hx+wMht/qGsz9lA0HnXgmsPOw+oNU1wkDY68YMsCBlYAiXGsJl9yj/TrPvvyH1c8CCvF6zhmksFhJPx58sg+jmvfu3vBUr+uq1Er/Czbk2gqCr+azdvjxZA2FcjT3RW0wEOdnGdZmGNF0sc1tuX6Y69QPwyB4X7C8Fhm15xj4kYm/oMZ52eaHbvGX9NK2v2bYXhLhNxNPOZFDVd/OWTm6HCgHenS4fZGG4uboPKJclt0YxSeDFKVANhOkz9Lvv+5zifAjlFTHkYFQfzLHOIk//zWY25mSQdLhEN3rU7LH60pI0qMZR2VS1T2puH1rMmkzWyv2HJu72ASpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FQlJl4uaiWuOXE0OeowVT80YfNbmLZ6FIgQh01eWNE=;
 b=H2F9jayDVOgyol+U4UmPO8G/siVJ/CmEjRudg7V4dtQ17ij7F4SJ//d7YVK25R431sdUI+9s9Fy0uhU4QLl940LY66bsDVKUJw5/EMr086G0gsp2vPz4Gdy2MtnNOkw+Yd8w2WOKXBSCIcS5VUXE0xjHot2+w9Eyq2dtY/JQFqA5lEyJal83AORv48+L6aJT/BoNDFrLjLgMOkSXY5VB3EPDw9AdREl3EKCiHZUd9wIaQmW/kVpFKYD6fpg2oLTZKhG8CsJnn8bQV6ucxmpgFWkPwuNMZ2CD4NxUHUamg/kgBEH1AU5i8bctu5T7vHKliH7dTmyEVurn57h9UZDXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FQlJl4uaiWuOXE0OeowVT80YfNbmLZ6FIgQh01eWNE=;
 b=PomDwsLle6zMIO9bD5RQttrzYL15oTNVKU/U/cv0yATLXZ3GF2/7jZifetxxt/GhWuuO3Uq/M/LIWtO9jFTs7thsccqNadciu+5YFDGIXYQuE73B5BcOKvwr8O/ZUNtdNYvQ+1E/ya7JtmsIuHuctFZRUrGLtrIQgT1t5EQedRE=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 JH0PR03MB7302.apcprd03.prod.outlook.com (2603:1096:990:e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.23; Mon, 15 Jan 2024 12:18:12 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::fb6f:5270:c66b:79b7]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::fb6f:5270:c66b:79b7%6]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 12:18:12 +0000
From: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "pkshih@realtek.com" <pkshih@realtek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>, =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>, =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in free_irq()
Thread-Topic: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in
 free_irq()
Thread-Index: AQHaRf7/gBSM1FlFxUyIYfeRf4LqTrDaIjAAgACroYA=
Date: Mon, 15 Jan 2024 12:18:12 +0000
Message-ID: <d02b15d0f76a842970f241db5a557cd37d894562.camel@mediatek.com>
References: <572d6af305a09fc8bdd96a8ee57399039803a2bb.1705135817.git.deren.wu@mediatek.com>
	 <3a3fc58206ec436e8cdfd97d71350795@realtek.com>
In-Reply-To: <3a3fc58206ec436e8cdfd97d71350795@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|JH0PR03MB7302:EE_
x-ms-office365-filtering-correlation-id: d240d1b2-6086-4ffa-e828-08dc15c40b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C85aGhuzUf0bbBtDLLWZO0h2gzIyzVYCtm2RtNmg3edEdxMMbLWdYHHyqG7SmlSeuFEmIHbzxxmGIeu6mn32RmKvurY0veA81tEbzXypu4ggbmEPuD7/d/g6pRTF3k1JSd8KNDD7AmyBVqP9hbAMLUAqqtNVqA+uCPNTgc+JKWpgsVSIphst5TagDDKYNm8bFpBT2O6HqXh8S63rlCFnJklBkDDmco3TjkhdCFoTG4KGCZk4yCzysqq3W2TIJWvxCQRaltgX8pzp0jRyZwu0aqhydS4mkOz0MTOohzUhVO2aQTVOuBmgMfbXNan2L3RRnpQ1mQ+qgwKdPlt8sEPtoOmz4+6ye1eRRbVKNn03+WfeQpUSq1++MCi1q7ue1L+acqNNF5Z/MlNt+oH5KdA7bH5A+n1j6JmUEvuUr01Rdv5741sBbCiTcuAS7PiQTXjfT39ZNaRlgoeXn9APiZZnhUfl7hiPGYUI3X1CqrD7YtOW0V57VviRm+4UFKFC0bwKfaGHytUeIkBAYLnE5Wq/8/CCDBvwB61ijFfQNzCSf2H86uKKxN44SSJsGhBqSEi50QgDrOtkf5XtqL60oJ0CVvhTtw++ho+VZo7anDD31LPtdmNu0+HFd5fpT/W9E1jhpinqvRLjEMNaywDusFJaOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(6506007)(71200400001)(8936002)(6512007)(53546011)(8676002)(76116006)(66446008)(66946007)(66556008)(316002)(64756008)(54906003)(966005)(91956017)(6486002)(110136005)(66476007)(26005)(2616005)(83380400001)(2906002)(4326008)(5660300002)(41300700001)(38070700009)(85182001)(36756003)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXRieW5BSHQ4aXo4dkJPbnRXVTdLM2xEVklDZGt1b2dBOE9vZmpMeDBLc1hu?=
 =?utf-8?B?dXNqcUl1OTJSdlR4WlIrdUsyaElKOFl3RWMrRWUyVUtLclV3dElKczRRWTZD?=
 =?utf-8?B?ci9yMmpZQmlIZW41K0FzbXRqZEJMeGxYdUliY0RSY1ErRlc5ZGh2N1FxbEpt?=
 =?utf-8?B?disrUzNiMDZiZlpxZThhU1V1MlFaYTFQUFViM3NZcTFDdWd1TFZDc3I3KzJ1?=
 =?utf-8?B?TnBFZFU5YVlNZ2Z5b1JVVFZTOWRQdUpvMmxaMFlUaTVmbTFGM2lKM0g4Yit2?=
 =?utf-8?B?MkVpbjcvekdZb1BSRnF3c0J2M2c2dHFyTlRyWmtwcW5KUEk0VlVNU2JwYUdY?=
 =?utf-8?B?bXU2WEg4dDJBWG1pOWNaZ25JTjNzQUQ5RjJVTWlaL2xQWDNJR1ZpRUJob2lm?=
 =?utf-8?B?eElOS1ZmUGdVbndicEN1cVdZKzVjWThzZTBRWC9ML3BQNldTT2hSdHZQNUxw?=
 =?utf-8?B?NjZHOSt1SFlYRmJMN0M4aDJZeWVXU004dFJ4ajVncTF3aTcxNkZkZFcxc0Ry?=
 =?utf-8?B?dEpNREM3U3Jab2puTWZDRGZGTVp1YWkxSmszWndJMFljS3BQTWg2WnhORVhq?=
 =?utf-8?B?ZDFKZzZxU1IzOFlQY2dxYjRQcVkrTGtmdjI3L283bWJ2QVQ0bW15Zm5VZmMw?=
 =?utf-8?B?OWgyYmpBWjdhMzVLUmEwaFVrdGhsTVliNWxXSDl6cUwxMGNHandhamp4cklX?=
 =?utf-8?B?Um9hekFvelFxWklDKzZzenA2M01FaUpIcWtQZ3VwU1dOd1poQ21pZDNiYmFI?=
 =?utf-8?B?VXM5RDBIYkZNajFUU1dYV1h4MGNIUFdmQVFZTEpCUExZWnBNckMzZCtLenNH?=
 =?utf-8?B?Z3F6TmV3bFZidk9UMmFVYmJ6L1NSd0lHT21RMUxoZUtKWTZpVjZRSnVOZjV2?=
 =?utf-8?B?bVdaZnAvUXgvZUZPVFdDb1pVRUFXaGFIcWlTMU9DaFFuYmRNaDhFUWl1bDFK?=
 =?utf-8?B?TE5CY2VHQWJIeWd3bFVGUHF5QWtVTmNrMVI4cWNkZG5QeG5VdFNCaHNVaUlZ?=
 =?utf-8?B?b2tEWUhHaFYzakFwdkhuOUFSNHdwSit2dFBlQXdLTjdlcUdDYmRUcGxqZkQr?=
 =?utf-8?B?Q1NoeU1IZ1AvZGxRNTMrcHlDcG95MWtLdFYrZnZUQmR0OFhkM05iMVZ0WTBK?=
 =?utf-8?B?blFMVEF6ek56Y0pzM0xvSkpzVlhHSEkwZHZNMUpFdGNneWxwY2VaQ1BwYUlP?=
 =?utf-8?B?TGtJdlZNYkdDUEhiSzBjZWIyblRjdjIvbDMrRHIwcjJMRGh4T3dpbUFLRHdl?=
 =?utf-8?B?SldMM1VsWVlTVHdVSVRYcVlBYjRiZGtRYkM0a0lMeSt0UVkyRGp2bGtHQWsx?=
 =?utf-8?B?c05Bdlkwd2NrWExHSGxPQ1RPbGVRaGRmM1lLWlZTelZXMXBKU2xJV0FwOE9O?=
 =?utf-8?B?eW5adEhYRjdnSDQyakVFQ2VjdCt5Vmt3aXN5b0NQUytGcHhVdDI3eGI3eXNx?=
 =?utf-8?B?ZVRrcnl5b01lY2xrZkpPMWFJWXE3Qy9FcC9tcFEyYXBHK3ROZjVhZkFKNXpB?=
 =?utf-8?B?dlJBVGtjQmJLc25yalArNkROUm0zL2xBNkJOWFc0dHV4aUhVc2VLdmdPYjlz?=
 =?utf-8?B?RHlQYUdpbm1FMXRZT0ZDeHd5L05jL1VMVWZCTk92RGpvNE52eXVWeHdNejdF?=
 =?utf-8?B?NmZxVklCUWlPOW43Uk1UZG01M3lWL0NQclNYMFhpM2tqbDkzS0Z3SWovYll3?=
 =?utf-8?B?TW1MVnVMd1Y0VkdXTGVxSjhGeE05NTlBVWNUN1BYRk5kVkV2SVZYajdGS2xU?=
 =?utf-8?B?bzU4aVZJejBRWG91dWZDL1dVbnRtUm9pUlhWc0Q2dEY5ZFpmY1dRdTdxMzJ5?=
 =?utf-8?B?Q0I1aEtrOFdHcjNjTm84bjBQN1lDME5KQkhtUUY4R1Y2alVUWkM0M0x2Mm1l?=
 =?utf-8?B?SENaeXRkUGhzRXZhL2xQT1NqUXpqUE5Fd01JR0tMelZZYTlPeUgxZm5SdXBP?=
 =?utf-8?B?ZTZoZTcrbDFaYjByWXM3a2VSR1FwUzZuSVFaSDJsemJNSXVSVW8xUmd6Zmxw?=
 =?utf-8?B?WmY4NnlNYVUyYThLSEVSeWhzR3hxeHdwOUV2OWxzZDUzMGVYRFVxcEMrUUNz?=
 =?utf-8?B?ajY4ZHRNOEQrZUhmekpEeFBhbDF4RUdXT2JKYkhHT0puTElWN25VUmxBT1cx?=
 =?utf-8?B?dW1CeSsvNW5wV1AxZTF2THpBSFNUSGNna2ZKWi9hdXRyRkRmUnBFNXhncFpj?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F04DDDEB540E4C40A0513E319CFFAA86@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d240d1b2-6086-4ffa-e828-08dc15c40b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 12:18:12.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnIdPN9dgUrsNYmZSaj6wwRm0jCVaNk7gGSTagbeT1oTOk6sNlNvXn9v1leAnl7DA2yiQv9yv9BOxbTeZn4JBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7302
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.636000-8.000000
X-TMASE-MatchedRID: petDSPmI9ITUL3YCMmnG4v01ZuXoOacd+WzVGPiSY8gNcckEPxfz2D6h
	VXnKDh9XhIxgTFT6sNUQIIqVNQDiwWsS7dJUh+kDGfRQPgZTkiry118CCumToQalXeZRxrUDxQc
	VXobqD8ItAHg74P6fo0WkTYdcN3jkx9ssvA0UfV6XXOyNnX/prCTbbsi+pqSFzdATtc2zn0BPH2
	OEh/+ebJTC7dh8KHcpo0trwO9JCQx8Lz9nbQURYh3EEAbn+GRbewkrNztQZRpUjspoiX02F4GZ0
	/+B73YgTHT2+pRTeRLOveDpu7C6KEWA+S/79tmldXu122+iJtqH7D1bP/FcOuebt/8o+APP9NWL
	TaM7D7GamLLN0blsI2RdaS26EKBCupptyy2mu+7Kl4yJoI+fG0yNDX2PfTDJ6TxAl8JJnZHSKUt
	bL1AAi3AF2KeEQ8wcQODN26Ym9swaprr0Zo5XTJ1U1lojafr/ylIdsC5UWr5D9iPiuXvzgXB44I
	kzjfYyThbvLLI8RvP6govUb/AlcajC6/MNUxOo9Ib/6w+1lWRzd7C7BtJobiNGK7UC7ElMar5fY
	xfTOGP3rGfbstODI05TqqstLWlHwp/mM9QGaq2VSBCoZUyqbB852jgffnmIwIizbmTBX9kiAqUq
	Kxe/izEM+i49fHJL+ANTNmF7Y+ftCZWNSJWZaodlc1JaOB1Ts4sYR7FSefKbKItl61J/yfmS+aP
	r0Ve8oTCA5Efyn8C5G5ZK4Ai7+N0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.636000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B893E8DC59588430C10BE003D15926EAA4A5B0E760F6459712E221CE61AB83032000:8

T24gTW9uLCAyMDI0LTAxLTE1IGF0IDAyOjAzICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IERlcmVuIFd1
IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ID4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgMTMs
IDIwMjQgNTowMCBQTQ0KPiA+IFRvOiBGZWxpeCBGaWV0a2F1IDxuYmRAbmJkLm5hbWU+OyBMb3Jl
bnpvIEJpYW5jb25pIDwNCj4gbG9yZW56b0BrZXJuZWwub3JnPg0KPiA+IENjOiBTZWFuIFdhbmcg
PHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+OyBTb3VsIEh1YW5nIDwNCj4gU291bC5IdWFuZ0BtZWRp
YXRlay5jb20+OyBNaW5nIFllbiBIc2llaA0KPiA+IDxtaW5neWVuLmhzaWVoQG1lZGlhdGVrLmNv
bT47IExlb24gWWVuIDxMZW9uLlllbkBtZWRpYXRlay5jb20+Ow0KPiBFcmljLVNZIENoYW5nDQo+
ID4gPEVyaWMtU1kuQ2hhbmdAbWVkaWF0ZWsuY29tPjsgS00gTGluIDxrbS5saW5AbWVkaWF0ZWsu
Y29tPjsgUm9iaW4NCj4gQ2hpdSA8cm9iaW4uY2hpdUBtZWRpYXRlay5jb20+OyBDSCBZZWgNCj4g
PiA8Y2gueWVoQG1lZGlhdGVrLmNvbT47IFBvc2ggU3VuIDxwb3NoLnN1bkBtZWRpYXRlay5jb20+
OyBRdWFuIFpob3UNCj4gPHF1YW4uemhvdUBtZWRpYXRlay5jb20+OyBSeWRlciBMZWUNCj4gPiA8
cnlkZXIubGVlQG1lZGlhdGVrLmNvbT47IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRl
ay5jb20+Ow0KPiBsaW51eC13aXJlbGVzcw0KPiA+IDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmc+OyBsaW51eC1tZWRpYXRlayA8DQo+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVh
ZC5vcmc+OyBEZXJlbiBXdQ0KPiA+IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ID4gU3ViamVj
dDogW1BBVENIIDEvMl0gd2lmaTogbXQ3NjogbXQ3OTIxZTogZml4IHVzZS1hZnRlci1mcmVlIGlu
DQo+IGZyZWVfaXJxKCkNCj4gPiANCj4gPiBGcm9tIGNvbW1pdCBhMzA0ZTFiODI4MDggKCJbUEFU
Q0hdIERlYnVnIHNoYXJlZCBpcnFzIiksIHRoZXJlIGlzIGENCj4gdGVzdA0KPiA+IHRvIG1ha2Ug
c3VyZSB0aGUgc2hhcmVkIGlycSBoYW5kbGVyIHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSB0aGUN
Cj4gdW5leHBlY3RlZA0KPiA+IGV2ZW50IGFmdGVyIGRlcmVnaXN0cmF0aW9uLiBGb3IgdGhpcyBj
YXNlLCBsZXQncyBhcHBseSBNVDc2X1JFTU9WRUQNCj4gZmxhZyB0bw0KPiA+IGluZGljYXRlIHRo
ZSBkZXZpY2Ugd2FzIHJlbW92ZWQgYW5kIGRvIG5vdCBydW4gaW50byB0aGUgcmVzb3VyY2UNCj4g
YWNjZXNzDQo+ID4gYW55bW9yZS4NCj4gPiANCj4gPiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJl
ZSBpbiBtdDc5MjFfaXJxX2hhbmRsZXIrMHhkOC8weDEwMA0KPiBbbXQ3OTIxZV0NCj4gPiBSZWFk
IG9mIHNpemUgOCBhdCBhZGRyIGZmZmY4ODgyNGE3ZDNiNzggYnkgdGFzayBybW1vZC8xMTExNQ0K
PiA+IENQVTogMjggUElEOiAxMTExNSBDb21tOiBybW1vZCBUYWludGVkOiBHICAgICAgICBXICAg
IEwgICAgNS4xNy4wDQo+ICMxMA0KPiA+IEhhcmR3YXJlIG5hbWU6IE1pY3JvLVN0YXIgSW50ZXJu
YXRpb25hbCBDby4sIEx0ZC4gTVMtN0Q3My9NUEcgQjY1MEkNCj4gPiBFREdFIFdJRkkgKE1TLTdE
NzMpLCBCSU9TIDEuODEgMDEvMDUvMjAyNA0KPiA+IENhbGwgVHJhY2U6DQo+ID4gIDxUQVNLPg0K
PiA+ICBkdW1wX3N0YWNrX2x2bCsweDZmLzB4YTANCj4gPiAgcHJpbnRfYWRkcmVzc19kZXNjcmlw
dGlvbi5jb25zdHByb3AuMCsweDFmLzB4MTkwDQo+ID4gID8gbXQ3OTIxX2lycV9oYW5kbGVyKzB4
ZDgvMHgxMDAgW210NzkyMWVdDQo+ID4gID8gbXQ3OTIxX2lycV9oYW5kbGVyKzB4ZDgvMHgxMDAg
W210NzkyMWVdDQo+ID4gIGthc2FuX3JlcG9ydC5jb2xkKzB4N2YvMHgxMWINCj4gPiAgPyBtdDc5
MjFfaXJxX2hhbmRsZXIrMHhkOC8weDEwMCBbbXQ3OTIxZV0NCj4gPiAgbXQ3OTIxX2lycV9oYW5k
bGVyKzB4ZDgvMHgxMDAgW210NzkyMWVdDQo+ID4gIGZyZWVfaXJxKzB4NjI3LzB4YWEwDQo+ID4g
IGRldm1fZnJlZV9pcnErMHg5NC8weGQwDQo+ID4gID8gZGV2bV9yZXF1ZXN0X2FueV9jb250ZXh0
X2lycSsweDE2MC8weDE2MA0KPiA+ICA/IGtvYmplY3RfcHV0KzB4MThkLzB4NGEwDQo+ID4gIG10
NzkyMV9wY2lfcmVtb3ZlKzB4MTUzLzB4MTkwIFttdDc5MjFlXQ0KPiA+ICBwY2lfZGV2aWNlX3Jl
bW92ZSsweGEyLzB4MWQwDQo+ID4gIF9fZGV2aWNlX3JlbGVhc2VfZHJpdmVyKzB4MzQ2LzB4NmUw
DQo+ID4gIGRyaXZlcl9kZXRhY2grMHgxZWYvMHgyYzANCj4gPiAgYnVzX3JlbW92ZV9kcml2ZXIr
MHhlNy8weDJkMA0KPiA+ICA/IF9fY2hlY2tfb2JqZWN0X3NpemUrMHg1Ny8weDMxMA0KPiA+ICBw
Y2lfdW5yZWdpc3Rlcl9kcml2ZXIrMHgyNi8weDI1MA0KPiA+ICBfX2RvX3N5c19kZWxldGVfbW9k
dWxlKzB4MzA3LzB4NTEwDQo+ID4gID8gZnJlZV9tb2R1bGUrMHg2YTAvMHg2YTANCj4gPiAgPyBm
cHJlZ3NfYXNzZXJ0X3N0YXRlX2NvbnNpc3RlbnQrMHg0Yi8weGIwDQo+ID4gID8gcmN1X3JlYWRf
bG9ja19zY2hlZF9oZWxkKzB4MTAvMHg3MA0KPiA+ICA/IHN5c2NhbGxfZW50ZXJfZnJvbV91c2Vy
X21vZGUrMHgyMC8weDcwDQo+ID4gID8gdHJhY2VfaGFyZGlycXNfb24rMHgxYy8weDEzMA0KPiA+
ICBkb19zeXNjYWxsXzY0KzB4NWMvMHg4MA0KPiA+ICA/IHRyYWNlX2hhcmRpcnFzX29uX3ByZXBh
cmUrMHg3Mi8weDE2MA0KPiA+ICA/IGRvX3N5c2NhbGxfNjQrMHg2OC8weDgwDQo+ID4gID8gdHJh
Y2VfaGFyZGlycXNfb25fcHJlcGFyZSsweDcyLzB4MTYwDQo+ID4gIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YWUNCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogTWlraGFpbCBH
YXZyaWxvdiA8bWlraGFpbC52LmdhdnJpbG92QGdtYWlsLmNvbT4NCj4gPiBDbG9zZXM6DQo+ID4g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL0NBQlhHQ3NPZHZWd2RM
bVNzQzhUWjFqRjBVT2dfRl9XM3dxTEVDV1g2MjBQVWt2Tms9QUBtYWlsLmdtYWlsDQo+IC4NCj4g
PiBjb20vDQo+ID4gRml4ZXM6IDkyNzAyNzBkNjIxOSAoIndpZmk6IG10NzY6IG10NzkyMTogZml4
IFBDSSBETUEgaGFuZyBhZnRlcg0KPiByZWJvb3QiKQ0KPiA+IFRlc3RlZC1ieTogTWlraGFpbCBH
YXZyaWxvdiA8bWlraGFpbC52LmdhdnJpbG92QGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEZXJlbiBXdSA8ZGVyZW4ud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYyB8IDEgKw0KPiA+ICBkcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyeF9kbWEuYyB8IDIgKysNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvcGNpLmMNCj4gPiBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL3BjaS5jDQo+ID4gaW5kZXgg
NTc5MDNjNmU0ZjExLi4yZjA0ZDY2NThiNmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvcGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYw0KPiA+IEBAIC0zODcsNiArMzg3
LDcgQEAgc3RhdGljIHZvaWQgbXQ3OTIxX3BjaV9yZW1vdmUoc3RydWN0IHBjaV9kZXYNCj4gKnBk
ZXYpDQo+ID4gICAgICAgICBzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2ID0gY29udGFpbmVyX29mKG1k
ZXYsIHN0cnVjdA0KPiBtdDc5MnhfZGV2LCBtdDc2KTsNCj4gPiANCj4gPiAgICAgICAgIG10Nzky
MWVfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2KTsNCj4gPiArICAgICAgIHNldF9iaXQoTVQ3Nl9SRU1P
VkVELCAmbWRldi0+cGh5LnN0YXRlKTsNCj4gDQo+IENhbiBpdCBkbyBiZWxvdyBsaWtlIG10Nzky
MV9wY2lfc3VzcGVuZCgpIHRvIHNhZmVseSBzdG9wIGludGVycnVwdA0KPiBoYW5kbGVyPw0KPiBJ
bnN0ZWFkIG9mIHNldHRpbmcgYSBmbGFnLiANCj4gDQo+ICAgICAgICAgc3luY2hyb25pemVfaXJx
KHBkZXYtPmlycSk7DQo+ICAgICAgICAgdGFza2xldF9raWxsKCZtZGV2LT5pcnFfdGFza2xldCk7
DQo+IA0KDQpIZXJlIGlzIHRoZSBzbmFwc2hvdC4gVGhlIGNvZGUgaXMgdHJ5aW5nIHRvIGRpcmVj
dCBhY2Nlc3MgdGhpcyBpcnENCmhhbmRsZXIgYWZ0ZXIgZGVyZWdpc2VyaW5nLCBmb3IgSVJRRl9T
SEFSRUQgY2FzZS4gc3luY2hyb25pemVfaXJxKCkgYW5kDQp0YXNrbGV0X2tpbGwoKSBhcmUgYWxs
IGRvbmUgaW4gcHJldmlvdXMgc3RlcHMuIFdlIG5lZWQgdG8gc3RvcCB0aGUNCmV4dHJhIGNhbGwg
aGVyZS4gSWYgdGhlcmUgYXJlIGFueSBhbHRlcm5hdGl2ZSwgdGhhdCB3b3VsZCBiZQ0KYXBwcmVj
aWF0ZWQuDQoNCi8qDQogKiBJdCdzIGEgc2hhcmVkIElSUSAtLSB0aGUgZHJpdmVyIG91Z2h0IHRv
IGJlIHByZXBhcmVkIGZvciBhbiBJUlENCiAqIGV2ZW50IHRvIGhhcHBlbiBldmVuIG5vdyBpdCdz
IGJlaW5nIGZyZWVkLCBzbyBsZXQncyBtYWtlIHN1cmUgdGhhdA0KICogaXMgc28gYnkgZG9pbmcg
YW4gZXh0cmEgY2FsbCB0byB0aGUgaGFuZGxlciAuLi4uDQogKg0KICogKCBXZSBkbyB0aGlzIGFm
dGVyIGFjdHVhbGx5IGRlcmVnaXN0ZXJpbmcgaXQsIHRvIG1ha2Ugc3VyZSB0aGF0IGENCiAqICAg
J3JlYWwnIElSUSBkb2Vzbid0IHJ1biBpbiBwYXJhbGxlbCB3aXRoIG91ciBmYWtlLiApDQogKi8N
CmlmIChhY3Rpb24tPmZsYWdzICYgSVJRRl9TSEFSRUQpIHsNCiAgICAgICAgbG9jYWxfaXJxX3Nh
dmUoZmxhZ3MpOw0KICAgICAgICBhY3Rpb24tPmhhbmRsZXIoaXJxLCBkZXZfaWQpOw0KICAgICAg
ICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQp9DQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y2Ljcvc291cmNlL2tlcm5lbC9pcnEvbWFuYWdlLmMjTDE5NDkNCg0KPiANCj4g
PiAgICAgICAgIGRldm1fZnJlZV9pcnEoJnBkZXYtPmRldiwgcGRldi0+aXJxLCBkZXYpOw0KPiA+
ICAgICAgICAgbXQ3Nl9mcmVlX2RldmljZSgmZGV2LT5tdDc2KTsNCj4gPiAgICAgICAgIHBjaV9m
cmVlX2lycV92ZWN0b3JzKHBkZXYpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkyeF9kbWEuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MnhfZG1hLmMNCj4gPiBpbmRleCA0ODgzMjZjZTVlZDQuLjM4
OTNkYmU4NjZmZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkyeF9kbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTJ4X2RtYS5jDQo+ID4gQEAgLTEyLDYgKzEyLDggQEAgaXJxcmV0dXJuX3Qg
bXQ3OTJ4X2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQNCj4gKmRldl9pbnN0YW5jZSkNCj4gPiAg
ew0KPiA+ICAgICAgICAgc3RydWN0IG10NzkyeF9kZXYgKmRldiA9IGRldl9pbnN0YW5jZTsNCj4g
PiANCj4gDQo+IElmIFBDSSBpcyByZW1vdmVkLCBpcyBpdCBzdGlsbCBzYWZlIHRvIGFjY2VzcyAn
ZGV2X2luc3RhbmNlJz8NCj4gDQoNCkZvciB0aGlzIGNhc2UsIHdlIGFyZSBydW5uaW5nIGludG8g
ZGV2bV9mcmVlX2lycSgpIGFuZCB0aGUgaW5zdGFuY2UgaXMNCnN0aWxsIGFsaXZlLiBUaGUgaXJx
IGhhbmRsZXIgc2hvdWxkIGJlIGRlc3Ryb3llZCBiZWZvcmUgdGhlIFBDSSBpcw0KcmVtb3ZlZC4N
Cg0KPiA+ICsgICAgICAgaWYgKHRlc3RfYml0KE1UNzZfUkVNT1ZFRCwgJmRldi0+bXQ3Ni5waHku
c3RhdGUpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gSVJRX05PTkU7DQo+ID4gICAgICAg
ICBtdDc2X3dyKGRldiwgZGV2LT5pcnFfbWFwLT5ob3N0X2lycV9lbmFibGUsIDApOw0KPiA+IA0K
PiA+ICAgICAgICAgaWYgKCF0ZXN0X2JpdChNVDc2X1NUQVRFX0lOSVRJQUxJWkVELCAmZGV2LT5t
cGh5LnN0YXRlKSkNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+IA0KPiANCg==

