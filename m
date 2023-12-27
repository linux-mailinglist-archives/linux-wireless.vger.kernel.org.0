Return-Path: <linux-wireless+bounces-1291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE4181EDD6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 10:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54500282A56
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692A4250F9;
	Wed, 27 Dec 2023 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="adHszQDG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="urSt8qaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97024B3C
	for <linux-wireless@vger.kernel.org>; Wed, 27 Dec 2023 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a63a12d2a49b11eea2298b7352fd921d-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C1i9fUUMgmsK1Y8SopaAXD8Ohh0vacspEwfGXfpF/d4=;
	b=adHszQDG4Ob9PH/AAYL1Wgt/pdLGZy7DgABQS1E2cB8i1XZicl+e1bFh9Q/AQvdn6GtGt0CChWAzhRYMvM+GMk1aJIeD2dIenzcmbXKTLdlptwGsknyq/lnhwp09urvFbSOlKDcMnqj1Qg1vEumSo0u8pi95Xxk80OoSdudwAgA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:aae12f9f-42ab-4a57-9548-af79114c74ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:14128a2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a63a12d2a49b11eea2298b7352fd921d-20231227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <allen.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 633698062; Wed, 27 Dec 2023 17:38:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 17:38:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 17:38:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow82ARNLMv9lU6RVABjQumHZwjN7iIQmu5F4CdMEs/4qrY6t0SUX1vWCOU8y0sfGVqbIBoXem4/sBzusBS3Rmp6ZbgXX0Kvld8V+eVu6vkUR5NEM/buHps9D3W8DQffTqee3fcKK4X0jzxQwInrn0k4wdlneb+3CbhFAZxBFKuoT9ZEhcG4Jv4bj/T3WsltoW6efa9hxeuteXsFLrRHwZu1e87AHqR+Bb8xm3IvMQGhdabXKWbyngDCOv0ESn8tagye/AZ/F04rB5CDkd8b3zPfACdFOBEvZNhD9FtNy1NMx0l2W54tkHF9/yc0/hJPE+sk/jJEACBTC9C7ezvasiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1i9fUUMgmsK1Y8SopaAXD8Ohh0vacspEwfGXfpF/d4=;
 b=Lgkw/JM87IjdJsT7tGueUM1GIes+GOVBi75ffaJvVOqn+PwgMGSPqAUumQokxhhaUjNg5Uds37cm5c8jgqCF9ulo8EYTHwnksqTGjlU8Bli0xrjv0GSeVshAN4cPOzw8D2UCexb4fEvzFNJjVmqB15Bmtef7+wa0LRKYM5eP+YKitNWbh5qQvPchuinygWsZpLhJOpFpwUfwdohxdwDFhQEorO0Uq1rjtv1LRzUKRNS7GnPcz/+FWG4UUwD5oj3qNFYmLa1POJWAOOuUAoGZlMCEaJfuSyd+BawLp8B2gsBDH2pCm8jn3hAkB9sGcF8Dz1lJWa9gbRPojdFGb4jPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1i9fUUMgmsK1Y8SopaAXD8Ohh0vacspEwfGXfpF/d4=;
 b=urSt8qaA+t9B1I21QXPtiSct5ywFl4HaZrcJc2qqlRI52Cgn5VqJR5bZFgeuKVcxKSxwIINOZEGZWv9Qd4xqEQyZ7i6wTY6iwYREwbDzNivYKR2CevKwcz4W0UyD8JfmWFmPM5D5NO4EqjFvENzzJ9grm/mz2Bc+wZorlnNrTOs=
Received: from SEYPR03MB7093.apcprd03.prod.outlook.com (2603:1096:101:da::5)
 by KL1PR0302MB5394.apcprd03.prod.outlook.com (2603:1096:820:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 09:38:07 +0000
Received: from SEYPR03MB7093.apcprd03.prod.outlook.com
 ([fe80::7b8a:f0d9:2e98:ca56]) by SEYPR03MB7093.apcprd03.prod.outlook.com
 ([fe80::7b8a:f0d9:2e98:ca56%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 09:38:07 +0000
From: =?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
	"nbd@nbd.name" <nbd@nbd.name>, =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?=
	<Evelyn.Tsai@mediatek.com>, =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?=
	<Money.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mac80211: Update bssid indicator with real BSS
 numbers
Thread-Topic: [PATCH v2] wifi: mac80211: Update bssid indicator with real BSS
 numbers
Thread-Index: AQHaKaEzFuCRDvP8rUS1zMbabugyRbCovyoAgBQ+XQA=
Date: Wed, 27 Dec 2023 09:38:07 +0000
Message-ID: <c23373d71eff81ea043783edff0345502bb2e299.camel@mediatek.com>
References: <20231208063820.25983-1-allen.ye@mediatek.com>
	 <65d21336e8f7e180352403a3e894aeaf27a22cab.camel@sipsolutions.net>
In-Reply-To: <65d21336e8f7e180352403a3e894aeaf27a22cab.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7093:EE_|KL1PR0302MB5394:EE_
x-ms-office365-filtering-correlation-id: 9e66a8bb-997b-4f3e-38e9-08dc06bf882b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCs4xI1XzLZQAbprjmbHeSQyWGYUzyDrHxQooStXLPLb7mesEBOXLEyBEYAWhv+X/PS/qYX2zIO+hrnem93PlRN8A8bYy7z/6x/Gzt8SsTEwZIPsaf04p+m/qkg90v6jauTLSGQYuSrQ2K77VXrX3aXVeSWxfU3HadnKhyBsRCqJVnUGHk/FTuiIyzxW9pNP0JCL+uXHM1HccpbLDrRwgDio7E0i/UUgaT+HvaIkCqbbTRsSMl/ugiOMCrkwHHZb1qujmFA5Cwy9TfaLBIDtUZvFe3sBhZe1zWmC0HDJsIBxELCOTAiqMoQltrcYWO/tjF2vd0HujwY++n8Oaw6xaQndB61UJOGhyin/vlQhGTBzn3LuiItCHrTh4cSpwjBs3ycMoB3SEvyW7HzWrzK64VdYaCdMiRNGQOKomCRazxiaK3GOYU5ZHESqOnvDwdezZ40s1gQ9EwcEYOFQ1Te7GVRiUh4O2FCiGJYR2bd4gBDEiLPuz5wQWPb3gM3naVutNU4zudQb06LjS02weNSRpOJz4KB34gvnlHf4gdzz5mecIcz1+gjHJe5XuBhgcfRBNSNAMH5CW3/0calkXNtIYuEQD3U85/ETX10P418j7gEurUytDuXeVyvpn2PzfsE6x7eMgEKTEq1QOwEIh9H8ORZbLSuiVfMMzjVpYw6SN+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7093.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(83380400001)(41300700001)(38100700002)(26005)(122000001)(8676002)(4326008)(110136005)(54906003)(316002)(8936002)(5660300002)(15650500001)(2906002)(4001150100001)(478600001)(71200400001)(6506007)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6486002)(38070700009)(6512007)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZVTmFmRnZ0MVdldzVobUxqbEdhUGVLQndCb0Q5UDhsK0haMEpMblhLRlBp?=
 =?utf-8?B?c1Z4OFRsUmttWU5zU1ZYWCtvczZiT0tTS3NVZFZOVkh6eTgzUTc3UDVtY1c2?=
 =?utf-8?B?eHRmM0MyQlFZV3Jyampsd2trbjN1c0xlNFdXTm96UXhNRk90VU1vT1ZSdkZ4?=
 =?utf-8?B?YzJtRWxmdSs4OFpEWXN6OGExVC9KaW9vMkRyVC94MWV5VER4OUltTkpsbHBR?=
 =?utf-8?B?MU5uMUZEdGdxd2dib2NSc3c2WmM1UWVkRGx4WWtGYUpZOGY4bDdvNHQ3VFZ6?=
 =?utf-8?B?V2hWaHZsUVF4b2dMd24reGhHUVdXQUE0L1J2MmQyMW50ZnFQLzBUbER3bVRv?=
 =?utf-8?B?YkQrbG1QRkdnV0NHMWRINTR3OTdsN09MSmZ3ZmpXek4vUVRsQllpMzl6ZDA5?=
 =?utf-8?B?cjZQeEVhUk1hQUZjWE44cmZuYTRPRWJHVWFldGFVSnVKUExyMWcxRVpNa01O?=
 =?utf-8?B?VWdmamdjWlRnOUpISWFzQjlmeHhXdFV3UTlCOHFpUHoveTRSc1U1d24wUzQw?=
 =?utf-8?B?Zk1pdzRQZzlGQk5RSXJxWU03REg0S2tsejZzTkF5WFRxdEM1MXdSaWY1REVU?=
 =?utf-8?B?US9KQTdtaHl1MGNpQVhZY0FIcncxUElmNzBwZUkrV2dydkZId3M1Vmg1Q0N4?=
 =?utf-8?B?MmZUOGFnSEN4WTVUYkhEVGM2QmsxT2ZpVVJjQytVSXdMdzUxcXdQcEl6Zmwx?=
 =?utf-8?B?N0xiUHdLYUw1emM2M1Fzd3FQeVNWL29ITmxXbk82SW96Uks1N2IvOVIvSjN5?=
 =?utf-8?B?Uk9iWHhQVXBTSzdmSDhOZVBGUEVYYzdtUXM0Wmp4dUFRY3dYbi9KK1owbkhV?=
 =?utf-8?B?S2IrT2YrT0E3dFpLYXZ5RHJsRUR2Lzg5bFVaNkloRlBrUkRNY1pLYkR4WWR3?=
 =?utf-8?B?d0RxSExtMGtZSUs0S2pBOVRwYngrbmhNWEt3Y2dRekhXQng5SlJnN25sQzJt?=
 =?utf-8?B?eDNEV3AyN05CZE9YalNGaFNUb2EwUm5UU0RnVE5oclJxNi9odVpXZWVXUEc1?=
 =?utf-8?B?RU5zdURtbzNPSElnNnpTWXR5dTkxM1lSNEgrY0pDVHVVVU9aeVJoOGNYbW1Q?=
 =?utf-8?B?V1JwVTlHNnI5VUsrZHprZXlrSzNoSTY5cFBZU0JJRkxqbTJUU1ZRc24xQXJZ?=
 =?utf-8?B?Q0MvUHBFTTlLU245UU9MUzNzdVBOVWptOUh2QlhJenI4SDk1UHo0QVE1OTc2?=
 =?utf-8?B?dWlMZjQ1eVNRbWF2RkVYTisxZjMxMS8zNWFETktHNGZnbldFbU9xUm9FaTF6?=
 =?utf-8?B?YW5GR3FENWZycSttZmRpa2tSd3JSZzkwOHpLWlR5dFVFWE82V203L3RPU1B1?=
 =?utf-8?B?WC9BcFdoZmczTm92UnhQdHNWUWl6OHNoazd3a0V5bVV5cm5XR2ZnVDV5bFlN?=
 =?utf-8?B?cG1iL2RlV2xlcXM4VGFxNHo5R2thTXJxNGNCMDJLdzYxK05CekhHMXdXK0Vu?=
 =?utf-8?B?OTRoWHVaNXl0dCtHZFBqU2FrY2srdzhBVjd2VENsZXFWZU0rL2lhNmVQWDI3?=
 =?utf-8?B?S1UvRXkwa2RVWmp1eHdZRWRmdmpsYUpFeEpSWDdTZWUyZmNidjUwc0RZYllL?=
 =?utf-8?B?OWdnYUxMVWVrQXRWN3BqSkxPem1FUS9vTUlLMUhhL0xOeFVJQmNPcjBudTRG?=
 =?utf-8?B?d09ENE80aTgrZ01jdWRWdDdBakZGVDJNclg2RWdNdzgwY3NHeDM2UVNSdHB2?=
 =?utf-8?B?OTlXQmpoZmtNdk9WSmQ3Um5GMEJHNVdlNWVuVUJYUjFONXdIMkx6bnV6SGRh?=
 =?utf-8?B?dU5NZVZtck9DR1pXeW9rM3A2MDZVUnFGblhpS0RkTm8rR2gxYnBobnVNUWJv?=
 =?utf-8?B?TXJVSnJ6T01iSkZhakJqYVgrNW40SFBkbHJudGlqMmprbFZBS3VnZFUvSVlK?=
 =?utf-8?B?V093cERTaGNJaHJaZURXU1BQZXhzR3VyR08xTXQycWthVE55Rk5oNnByRlIx?=
 =?utf-8?B?UDRhWkpueVZlV081ZEtVWHJjYTZERFdjeFVOcDZtUFlCYktmbXpFemV1Q1hq?=
 =?utf-8?B?RGJBdVNDR3FWOEJhNU1ZVjB6NWpMYXFkYWZ4eHRXOGFqMGozejVBNFA2S2Rr?=
 =?utf-8?B?dTdYRk9MWTFhQmVTOThGL2FzL2RuUklFcWFPRXRORmZPa1JJeVpFeDRKMDda?=
 =?utf-8?B?cC8xT2pSaUNmK0h5MXg0UVZMOGVuZGUydEJrR3FDZHhXVElkb1pLT1owUER2?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FD4DE9FA9D78940A14997FF6EA24485@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7093.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e66a8bb-997b-4f3e-38e9-08dc06bf882b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 09:38:07.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBEsFB2knUfTCEVtkI4IKDT4vUFwk9MZnxkBstok2KwUAZ1QXi525UZSksqptYez/cDSCP5/MCSg1XgJDSbwTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5394
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.700800-8.000000
X-TMASE-MatchedRID: +f/wAVSGjugOwH4pD14DsPHkpkyUphL9yeUl7aCTy8gVbhLMN/WkpWKp
	MJoimBcbGEhVHqaMPqyJPuhfLlICQrWwxIexQCPgTSPNp9e/u1OtO1W2zFTsGN9RlPzeVuQQ9v0
	xAroNAKVZvnjkTYzLjoLb6cBklJ+m6fDH/gt7bpYlN5NJ/EuSqYA0ZcHPsEenAIZpxx3hp73LTA
	M0njAJmXv+Pr9S/EMZq4tKr1fSkgSqeo/H3QKcFQwfhKwa9GwDYQXxsZnRwoLvPjzagmh01HZru
	QG5/1P7y2mqp6NLloqmrq1qKf9TfGBWumXLoe6N5gCHftmwEMJ9LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8cK21zBg2KlfAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.700800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0DB79F2C4660F4D19B023A3CCB1F6175595EC1C08BC8AAAAA56848A2F767661F2000:8

T24gVGh1LCAyMDIzLTEyLTE0IGF0IDEzOjI5ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiAgDQo+ICBIaSwNCj4gDQo+IFdlIHNob3VsZCBoYXZlIExvcmVuem8gaGVyZSwgaGUgd3JvdGUg
dGhlIG9yaWdpbmFsIGNvZGUuDQo+IA0KPiBPbiBGcmksIDIwMjMtMTItMDggYXQgMTQ6MzggKzA4
MDAsIEFsbGVuIFllIHdyb3RlOg0KPiA+IFRoZSBjbnQgbWVtYmVyIGluIG1ic3NpZCBpcyB0aGUg
Y291bnQgb2YgdG90YWwgbnVtYmVyIG9mIE1CU1NJRA0KPiBlbGVtZW50cw0KPiA+IGluc3RlYWQg
b2YgQlNTSUQuIFRoZXJlZm9yZSwgd2UgZml4IHRoaXMgYnkgcmVhZGluZyB0aGUgTWF4QlNTSUQN
Cj4gSW5kaWNhdG9yDQo+ID4gZmllbGQgZGlyZWN0bHkuDQo+IA0KPiBJJ2xsIHNheSBJIGRvbid0
IHVuZGVyc3RhbmQgdGhpcyBtdWNoIC4uLg0KPiANCj4gQXJlIHlvdSB0cnlpbmcgdG8gaGF2ZSBC
U1NJRHMgdGhhdCBhcmUgaGlkZGVuIGZyb20gdGhlIGtlcm5lbD8gT3Igbm90DQo+IGNvbnRpZ3Vv
dXMgaW4gdGhlIE1CU1NJRCBzZXQ/IE5vdCBzdXJlIGhvdyB0aGUgdHdvIGNhbiBiZSBub3QNCj4g
ZXF1aXZhbGVudD8NCj4gDQpIaSBKb2hhbm5lcywNCg0KVGhlIG51bWJlciBvZiBCU1MgaXMgbm90
IGVxdWFsIHRvIE1CU1NJRCBlbGVtZW50IGNvdW50IHBsdXMgMSBiZWNhdXNlDQp0aGVyZSBtaWdo
dCBiZSBtdWx0aXBsZSBub250cmFuc21pdHRlZCBCU1NJRCBwcm9maWxlIHN1YmVsZW1lbnRzIGlu
IG9uZQ0KTUJTU0lEIGVsZW1lbnQuIEFsc28sIG9uZSBub250cmFuc21pdHRlZCBCU1NJRCBwcm9m
aWxlIHN1YmVsZW1lbnQgbWlnaHQNCmJlIGZyYWdtZW50ZWQgYWNyb3NzIHR3byBNQlNTSUQgZWxl
bWVudHMgaWYgdGhlIGxlbmd0aCBvZiB0aGUNCnN1YmVsZW1lbnQgZXhjZWVkcyAyNTUgb2N0ZXRz
Lg0KDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2ZWx5biBUc2FpIDxldmVseW4udHNhaUBtZWRp
YXRlay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBNb25leSBXYW5nIDxtb25leS53YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNb25leSBXYW5nIDxtb25leS53YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbiBZZSA8YWxsZW4ueWVAbWVkaWF0
ZWsuY29tPg0KPiANCj4gSSBoYXZlIHRvIGFkbWl0IHRoYXQgSSBjaHVja2xlZCBhIGJpdCBhYm91
dCB0aGlzIGZvciBhIDUgbGluZSBwYXRjaA0KPiA6LSkNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL25l
dC9tYWM4MDIxMS9jZmcuYyBiL25ldC9tYWM4MDIxMS9jZmcuYw0KPiA+IGluZGV4IDYwNmIxYjJl
NDEyMy4uZjkwYmNkNTlmODVhIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9tYWM4MDIxMS9jZmcuYw0K
PiA+ICsrKyBiL25ldC9tYWM4MDIxMS9jZmcuYw0KPiA+IEBAIC0xMTY0LDkgKzExNjQsMTEgQEAg
aWVlZTgwMjExX2Fzc2lnbl9iZWFjb24oc3RydWN0DQo+IGllZWU4MDIxMV9zdWJfaWZfZGF0YSAq
c2RhdGEsDQo+ID4gIC8qIGNvcHkgaW4gb3B0aW9uYWwgbWJzc2lkX2llcyAqLw0KPiA+ICBpZiAo
bWJzc2lkKSB7DQo+ID4gIHU4ICpwb3MgPSBuZXctPnRhaWwgKyBuZXctPnRhaWxfbGVuOw0KPiA+
ICtjb25zdCBzdHJ1Y3QgZWxlbWVudCAqbWJzc2lkX2VsZW07DQo+ID4gIA0KPiA+ICBuZXctPm1i
c3NpZF9pZXMgPSAodm9pZCAqKXBvczsNCj4gPiAgcG9zICs9IHN0cnVjdF9zaXplKG5ldy0+bWJz
c2lkX2llcywgZWxlbSwgbWJzc2lkLT5jbnQpOw0KPiA+ICttYnNzaWRfZWxlbSA9IChjb25zdCBz
dHJ1Y3QgZWxlbWVudCAqKXBvczsNCj4gPiAgcG9zICs9IGllZWU4MDIxMV9jb3B5X21ic3NpZF9i
ZWFjb24ocG9zLCBuZXctPm1ic3NpZF9pZXMsDQo+ID4gICAgICBtYnNzaWQpOw0KPiA+ICBpZiAo
cm5yKSB7DQo+ID4gQEAgLTExNzUsOCArMTE3Nyw3IEBAIGllZWU4MDIxMV9hc3NpZ25fYmVhY29u
KHN0cnVjdA0KPiBpZWVlODAyMTFfc3ViX2lmX2RhdGEgKnNkYXRhLA0KPiA+ICBpZWVlODAyMTFf
Y29weV9ybnJfYmVhY29uKHBvcywgbmV3LT5ybnJfaWVzLCBybnIpOw0KPiA+ICB9DQo+ID4gIC8q
IHVwZGF0ZSBic3NpZF9pbmRpY2F0b3IgKi8NCj4gPiAtbGlua19jb25mLT5ic3NpZF9pbmRpY2F0
b3IgPQ0KPiA+IC1pbG9nMihfX3JvdW5kdXBfcG93X29mX3R3byhtYnNzaWQtPmNudCArIDEpKTsN
Cj4gPiArbGlua19jb25mLT5ic3NpZF9pbmRpY2F0b3IgPSBtYnNzaWRfZWxlbS0+ZGF0YVswXTsN
Cj4gDQo+IEJ1dCB0aGlzIHNlZW1zIGZpc2h5IHRvIG1lLCBpZiB5b3UgbG9vayBpbnRvIHRoZSBl
bGVtZW50IGl0c2VsZiwNCj4geW91J3JlDQo+IGdvaW5nIHRvIGhhdmUgdG8gZG8gc29tZSB2YWxp
ZGF0aW9uIG9uIGl0PyBBbmQgd2hhdCBhYm91dA0KPiBmcmFnbWVudGF0aW9uPw0KPiANCj4gam9o
YW5uZXMNCg0KV2hldGhlciB0aGUgc3ViZWxlbWVudCBpcyBhZ2dyZWdhdGVkIG9yIGZyYWdtZW50
ZWQsIHRoZSBNYXhCU1NJRA0KSW5kaWNhdG9yIGZpZWxkIHdvdWxkIGJlIHRoZSBzYW1lIGZvciB0
aGUgbXVsdGlwbGUgQlNTSUQgc2V0Lg0KVGhlcmVmb3JlLCB3ZSBkaXJlY3RseSByZXRyaWV2ZSB0
aGlzIGZpZWxkIGZyb20gdGhlIGVsZW1lbnQuDQpGb3IgZXhhbXBsZSwgdGhlcmUgYXJlIGZpdmUg
QlNTZXMgaW4gb25lIG11bHRpcGxlIEJTU0lEIHNldCwgb25lDQp0cmFuc21pdHRlZCBhbmQgZm91
ciBub24tdHJhbnNtaXR0ZWQgQlNTZXMuIFdlIG1pZ2h0IHVzZSBqdXN0IHR3bw0KTUJTU0lEIGVs
ZW1lbnRzIHRvIHN0b3JlIGFsbCB0aGUgbm9uLXRyYW5zbWl0dGVkIEJTUyBpbmZvcm1hdGlvbi4g
SGVyZQ0KdGhlIE1heEJTU0lEIEluZGljYXRvciBpcyAzIGluIGJvdGggTUJTU0lEIGVsZW1lbnRz
LiBIb3dldmVyLCB0aGUNCmVsZW1lbnQgY250IGlzIDIgYW5kIGlmIHdlIHVzZSB0aGUgb3JpZ2lu
YWwgbWV0aG9kIHRvIGNhbGN1bGF0ZSB0aGUNCkJTU0lEIEluZGljYXRvciB3ZSB3aWxsIGdldCAy
IHdoaWNoIGlzIHdyb25nLg0KDQpUaGFua3MsDQpBbGxlbg0K

