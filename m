Return-Path: <linux-wireless+bounces-571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF4809C17
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 06:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEAE1C2082A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 05:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B786FD0;
	Fri,  8 Dec 2023 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CN6Un4G/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Nq8bDTE4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A4C171F
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 21:59:04 -0800 (PST)
X-UUID: e17a4f54958e11eea5db2bebc7c28f94-20231208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M0nWGT6cR6WkHWd66B9JKoGZkQAjPJKMvTLxXEfZjtQ=;
	b=CN6Un4G/hxU+nsM84YJJCcCXxO9QtkJIKGRUTX9upC5Z63TjozmTQJZ9xtosgk+1IOc++lVYb1D+SvFspf1mTPAQxbJENeBdNk+4EC9YOXMYWJE1TLBGV20y8UhM9+aUifdGULIID8KSjt3EwPeYPsxDSfoEUjNUalAWqnVuYps=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ee0d04e8-9868-495a-a8f0-fe2a528c4a25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:3e556efd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e17a4f54958e11eea5db2bebc7c28f94-20231208
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <allen.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1953529788; Fri, 08 Dec 2023 13:58:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Dec 2023 13:58:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Dec 2023 13:58:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHS1/MRRdBHPmvU3wIoQ6pVMkgOUmiMvIXTOYc5IxVPQZ9xYBJQ5HKVJY7Q0Plm0i3O+BCAbkdRn427lwxFll5N+8Mtoc3e9i0zY823AuAnSneGzCfC5GK9kiW77thEUjviG4ME4TA6nU21jO2o07sL4DZbAvFWm50Rb0+mRa2objLwUVJIjGalpKDhDsfSFXq6p+kw+BIutPNA739dO3s963tS4a/ZPbN74OkEKUFTO4yZL4BGpQypnI5adKKMvp1o1qudkk8d1Y7tcJ1pD3xzGXLi1Lsli4jLUYLmsdVhUBRo4gj8oD/bGG4S7+h4Un0OkiUduBDi4EG6TJxdpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0nWGT6cR6WkHWd66B9JKoGZkQAjPJKMvTLxXEfZjtQ=;
 b=FFWQnUvOEXSit9IgQsi+gOYbXP4Ca6O0CEZCXMDFJ6yQquUQffril2Pp2fP/m49O0qjnsQ8WLs6T7svzcTMPYNSDKl0R94g93QEMXbHSIFdno6MKkD5x+ab76/6vWlc+BJWw1LXJVAJrHOlLcPeM1GSOvuwhr9Inspojrb2LC3emZyZ6V+p8sWYrUOoglpyvR3GIKfYYcCgYJ1RU4RDQdvSk+wtxqZlfkujdFWL9CrR2snpVdP5Pa6ONjOBWq2XmAcV7229a/CsAvHU/IR4nmNEbC2P1lza3xrOfPs9Q7APxv79fbA8OxWZ2b4/Op1GFolWLlrH2EHvbsw2LrXJeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0nWGT6cR6WkHWd66B9JKoGZkQAjPJKMvTLxXEfZjtQ=;
 b=Nq8bDTE4URfDp7Wv20yqgmjUveAWljBfRvjMRV5Ug0qF+1Q3fZPGUV1FYIZRsQBgEwMIZcP6t/LFzbxEoYyzYcywXXyuR7IgVcjcR64qX4R5PEz0af9q1acb6ysajLHfxlRSRrDoKknx/dUnTBsnnSRNbrHTq3IlWA/k4sTMIt8=
Received: from SEYPR03MB7093.apcprd03.prod.outlook.com (2603:1096:101:da::5)
 by JH0PR03MB8722.apcprd03.prod.outlook.com (2603:1096:990:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 05:58:55 +0000
Received: from SEYPR03MB7093.apcprd03.prod.outlook.com
 ([fe80::7b8a:f0d9:2e98:ca56]) by SEYPR03MB7093.apcprd03.prod.outlook.com
 ([fe80::7b8a:f0d9:2e98:ca56%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:58:55 +0000
From: =?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>
CC: "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
	"quic_wthomas@quicinc.com" <quic_wthomas@quicinc.com>, "nbd@nbd.name"
	<nbd@nbd.name>, =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?=
	<Evelyn.Tsai@mediatek.com>, =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?=
	<Money.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "johannes.berg@intel.com"
	<johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: mac80211: Fix SMPS action frame ht cap check
Thread-Topic: [PATCH] wifi: mac80211: Fix SMPS action frame ht cap check
Thread-Index: AQHaJ+6wwYLB6+XNwUaXq0AruweFLbCc8r+AgAH0owA=
Date: Fri, 8 Dec 2023 05:58:55 +0000
Message-ID: <b36e63dd01ec0be9e8cc83e3a25ef2d103328324.camel@mediatek.com>
References: <20231206024708.24831-1-allen.ye@mediatek.com>
	 <50a6f31a-ef28-496c-acf4-0521034e43a1@quicinc.com>
In-Reply-To: <50a6f31a-ef28-496c-acf4-0521034e43a1@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7093:EE_|JH0PR03MB8722:EE_
x-ms-office365-filtering-correlation-id: 179c72a5-3ae2-4334-bf5f-08dbf7b2c32b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMNwi5zKH/l+LwY49vpDX5p50K5FyKgqilM4Z6DF8ufGzLI6Obkv1pIuvVV2xzVXXmjPazAFy121EautkoWR24NaqDKiKqPW/zxs+KuuMylLjftsNf5LW1dTPzxb8Rmkj5GkVFCCI40bfrVdjI44v3i3+s3DuACrOOYzWuIN5aGvC03zZcwj7cQF3ree8L1e/AVpqNkdnvcCRzLHn88fS1C6bKVPv08cGjX6sifOx9tqA/D3p5rxqcuMJrtRDnOS/XF06By82+5qPXhnzAvF0Q9g9VmTDTKgnpeSd783RHZAyGlqxdZSOwAjn5qCEyOK0oB5OVZKE5OaGIQos+GOhQdSpRGL+GmtQl8ZzAqkc3zjqUgQqQ1Ple8d8sS+RRWFUFNzxsOLyYD+n0sQEYccR+ycLMmzeyfzujvoOXAn1so+DW55JU9xPPnhmahcCqyMYGTAQ+ez/4sWgGJV2LVXF2BoL0RY4rtPrL02NoSs1u8Z1z9emg6Lu/s3eJSbA2OXUOwSx3udhvCF791jysU005yiYiqkmhQGdp19R+u+bq5TtiJVtxJTG5QDkDIjXcWuQO1R8Sub6AO4UeHqvATJR4FEJJ56KQZcZeClI7QjvvL9ipqEVLjNcIizLBg0cCGY9QvFJMEpbwQj9b9NxMseqvQ7kie5CZU5dfH0Xn0VDTyy6VK9NpJtTtaDknO3byUt6j/xEKNaiuBlnBKzT3tk4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7093.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(6506007)(6512007)(71200400001)(53546011)(478600001)(6486002)(41300700001)(38070700009)(2616005)(83380400001)(26005)(2906002)(66476007)(76116006)(110136005)(66946007)(8936002)(54906003)(316002)(91956017)(66446008)(64756008)(5660300002)(66556008)(8676002)(4326008)(122000001)(36756003)(85182001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3lRaXZRVzEzUnB1Z1JJYjlYRjZkVlE1b2gvaUgwZ1Yrd1lvbjI1WnFMMzhS?=
 =?utf-8?B?ZVl3ZmVXQmFkR0JiYVhHMm9rVjZUQncwV3VUcTlqYzRDbldpd3hUZytmM2xQ?=
 =?utf-8?B?MkY3b1BlQjd0bDJES01yYXJSSDZiR053YkVjWHM4NFVuU0pQamNERGlqTWM4?=
 =?utf-8?B?UVVFRkpPQWpNOTZUU0xoZnR6SUZ0Q3Z5RjBXaUcyVEQzM0xpeEpsdmlmUUI5?=
 =?utf-8?B?RWU3WU80TWdPL1JIQjFsWDI4UHM5VlVhbzY3Ujl6WEdEcjMwajhqTEhOalJ4?=
 =?utf-8?B?TytyRzBZb3RMN0M2Si9wZDRRM0FialppSWhseDRaS0l3QmlhaXJLQkw2aGd1?=
 =?utf-8?B?bEsyaU5nK3AvVkljdk9YYVFSUlBKbjdRd2VhVHhncHRManZCK2ZxRWVLZFVV?=
 =?utf-8?B?TEFyaUhmOHY4ZTFndWZSM05RTklBQ0Z3akdDajdOTTJtTzJKUlRoN2JaQkVZ?=
 =?utf-8?B?UDZnbGwrMjh3WWN0Y2dtR2p2Y0t4ajg4SWRwQlcxYkJ5VFBiamNraStDUk0v?=
 =?utf-8?B?WG4xbWdCdFNGV1ZybDlWRHlZYUlwVmdKNGM0NG1yQXIyVUFOcW1KZXByeVVt?=
 =?utf-8?B?TDRJOHZicFZpeXU1R2FJZVpTdG4xQWV0bE1Ud3kzMWx1WWcxY0F2ODIvN1h3?=
 =?utf-8?B?Tkg1MmpScms4dzBWamZ6VHJjSnZhYXMwWXBESkJQaHpHbTIrWENHbDZQZGsy?=
 =?utf-8?B?ODdJQWk5UWh1eUlxb3FydGtqSGd2TFpEbDhmS1ROdE5YN0Q5WkF5WEtIVndu?=
 =?utf-8?B?cFBseDRtcXBvK0dKeDN2M1BseEtMUTRNd2p2d0t0M0N6cmRlU0RjWWE2QWF0?=
 =?utf-8?B?eVNlRGZnL1ZGb1NrYjVuT1h6NkpqZ3JDc3dWWXl4NncxWk9yc2E0cXYvZDE0?=
 =?utf-8?B?M2V5RVJUZ1EvOFdOY3pEdCtoRzU5ZHBGYVRyVTJhRVNNYW5OSFlCeDNDVDl3?=
 =?utf-8?B?L2RzaHhWUDRnaTQ1aHNDYmRERkRTbU9SQWZ3b3Q3VGkzS1Qyc2NqSW9jMkFX?=
 =?utf-8?B?WFpYQUN6ZjloTjQwVVhtRUNOV2F4TE9nVVlmeE8ybUhVTjhVUitsMnFaWiti?=
 =?utf-8?B?V3BXOHVhaGhzeTdJUXp4UjFyV2ZoYk80OWsxNkFaRW4xV016Wkh1SjcycktR?=
 =?utf-8?B?NWM4bFlGTFlxalVMMStrMnRnUDlxRE0ydG4vbjI1dzRBaGhGQzNINENFZVc4?=
 =?utf-8?B?aHBYQVNyeTBtdHA0MmI0SkhYWUo1TDVZdGZVbXlBUzM1NFg2Sk9Lc2JuTGlG?=
 =?utf-8?B?dndxZVJsYkx0TnpYVkZIcVc4bGlmeDdLZUszc3h6dUxkdkNYcVhhL0dZN0NK?=
 =?utf-8?B?cmJGb1R4cSs3Z0xZRHFqbjd4STBTNmdiWTY4MmV5ZTF1blN3SGE4cEI2ZER5?=
 =?utf-8?B?RU84QWlFSVFGVFFsczg2dEo4S2MyQnVuQWJqSG1ZVmVhYTYxVlRCYXIxZ1c3?=
 =?utf-8?B?azdsKzhzM281a2tDNnFUOGVyeEMwb21QemlJd01Tb0pXK0VnSzBmdXlkZkxt?=
 =?utf-8?B?SkYzS3Y0VHVtczdPY1o3eWN3QjlmUkNKeFpxeXBHZE9aRnlFUGZObzlQaVZs?=
 =?utf-8?B?dWdjaXdiUUhoejBId2pMOVh2OCtmS09JWkQ2MGM4UzdBMXFrR2UvMHVPMGJr?=
 =?utf-8?B?WjNaMHNPN1FOcUg3U0xUTW0zTncrQUJydGEza1Mzb1A1R2xkc0tEQlR0R3Fy?=
 =?utf-8?B?NFVhSXRudEk2YlFvRURQdjlpMDY0WlNEcTlDUGpRRTdFMzQzcXNtM3FZV1lS?=
 =?utf-8?B?bFNHREpIa3ZoWlFxcndRK0cvajV5RVBaYXVOd3ZRdGZxWE9QcGlzaG5wV0hO?=
 =?utf-8?B?NDR4MW5FSjdnUTczcEdBSk5NRzFXN2R6Sk5oRkFXc0R3RWJqeU9IMkhVY2pl?=
 =?utf-8?B?T3NkSUtWUElkZUt3Tk1salAvZDB3NWQxeGM4cXRCNlpKNDhUeUZ5Z3dibmZD?=
 =?utf-8?B?TEhsa0MrVW0ySmZwNzhwcE03bzJiZEdNMjVEVGxVOFRvMUd3bjFkd1ZwTkF4?=
 =?utf-8?B?TUdqVWhPZDMvTlVvbUdQc2tSN1VZdUp4NmJwbHphMWhGd0pqVysxSmVseENH?=
 =?utf-8?B?RE9CTHBudjBJNHpDUjhwSnZWQmc2bmJYc1ZtSWtXdTVNMHdBd3ZjdWhBSjM0?=
 =?utf-8?B?TmN0eHhGYTl3NjhNQ2lXRDMybW9PZTZPQ0Y1eHBJWjBKMXRnMnVGWlh2T0FH?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69FAB034A2F864408BE3D1F70789483E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7093.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179c72a5-3ae2-4334-bf5f-08dbf7b2c32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 05:58:55.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfYn30K8iw6G5rXsKDdDTKQN96pwXhibmLOVIlL1j7cm7aq1AxqLL/18yRL5w46lUVgPOQLIcFzR8Rk1A6GeyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8722

T24gV2VkLCAyMDIzLTEyLTA2IGF0IDE2OjA3IC0wODAwLCBKZWZmIEpvaG5zb24gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gMTIvNS8yMDIzIDY6NDcgUE0sIEFsbGVuIFllIHdyb3RlOg0KPiA+
IEZyb206ICJBbGxlbi5ZZSIgPGFsbGVuLnllQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBTaW5j
ZSB0aGVyZSBpcyBubyBIVCBCU1MgaW4gNkdIeiwgdGhlIEhUIENhcCBjaGVjayB3b3VsZCBzdG9w
IDZHDQo+IEhFL0VIVA0KPiA+IEJTUyBmcm9tIHByb2Nlc3NpbmcgdGhlIEhUIGFjdGlvbiBmcmFt
ZSBmb3IgU00gUG93ZXIgU2F2ZSB3aGljaCBjYW4NCj4gYmUNCj4gPiBhbHNvIHVzZWQgaW4gYW4g
SEUgQlNTLiBUaGVyZWZvcmUsIHdlIHJlbW92ZSB0aGUgSFQgQ2FwIGNoZWNrIGluDQo+IDZHSHog
YW5kDQo+ID4gYWRkIHRoZSBIRSBjaGVjayBhY2NvcmRpbmdseS4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNb25leS5XYW5nIDxtb25leS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGxlbi5ZZSA8YWxsZW4ueWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBu
ZXQvbWFjODAyMTEvcnguYyB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L21h
YzgwMjExL3J4LmMgYi9uZXQvbWFjODAyMTEvcnguYw0KPiA+IGluZGV4IDY0MzUyZTRlNmQwMC4u
ZjhjZDE0ZGM1OGVjIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9tYWM4MDIxMS9yeC5jDQo+ID4gKysr
IGIvbmV0L21hYzgwMjExL3J4LmMNCj4gPiBAQCAtMzQ4Miw3ICszNDgyLDggQEAgaWVlZTgwMjEx
X3J4X2hfYWN0aW9uKHN0cnVjdA0KPiBpZWVlODAyMTFfcnhfZGF0YSAqcngpDQo+ID4gIHN3aXRj
aCAobWdtdC0+dS5hY3Rpb24uY2F0ZWdvcnkpIHsNCj4gPiAgY2FzZSBXTEFOX0NBVEVHT1JZX0hU
Og0KPiA+ICAvKiByZWplY3QgSFQgYWN0aW9uIGZyYW1lcyBmcm9tIHN0YXRpb25zIG5vdCBzdXBw
b3J0aW5nIEhUICovDQo+ID4gLWlmICghcngtPmxpbmtfc3RhLT5wdWItPmh0X2NhcC5odF9zdXBw
b3J0ZWQpDQo+ID4gK2lmIChzdGF0dXMtPmJhbmQgIT0gTkw4MDIxMV9CQU5EXzZHSFogJiYNCj4g
PiArICAgICFyeC0+bGlua19zdGEtPnB1Yi0+aHRfY2FwLmh0X3N1cHBvcnRlZCkNCj4gDQo+IHdl
IGhhZCBmb3VuZCB0aGUgc2FtZSBpc3N1ZSBhbmQgd2VyZSBwcmVwYXJpbmcgYSBwYXRjaCB0aGF0
IGNoYW5nZWQNCj4gdGhpcyB0bzoNCj4gK2lmICghcngtPmxpbmtfc3RhLT5wdWItPmh0X2NhcC5o
dF9zdXBwb3J0ZWQgJiYNCj4gKyAgICAhcngtPmxpbmtfc3RhLT5wdWItPmhlX2NhcC5oYXNfaGUp
DQo+IA0KPiBJIHNlZSB5b3UgYWRkZWQgdGhlIGhhc19oZSBjaGVjayBiZWxvdywgYnV0IGN1cmlv
dXMgaWYgaXQgaXMgYmV0dGVyDQo+IHRvDQo+IGRvIGl0IGhlcmUgdG8gc2hvcnQgY2lyY3VpdCB0
aGUgdGVzdHMgdGhhdCBmb2xsb3cNCkhpIEplZmYsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50
LiBZb3VyIHBhdGNoIGNhbiBmaXggdGhlIGlzc3VlLCBhbmQgaXMgYmV0dGVyIHRvDQpjaGVjayB0
aGUgYWN0aW9uIGZyYW1lIG1vcmUgcXVpY2tseS4gDQo+IA0KPiA+ICBnb3RvIGludmFsaWQ7DQo+
ID4gIA0KPiA+ICBpZiAoc2RhdGEtPnZpZi50eXBlICE9IE5MODAyMTFfSUZUWVBFX1NUQVRJT04g
JiYNCj4gPiBAQCAtMzUwMiw2ICszNTAzLDEyIEBAIGllZWU4MDIxMV9yeF9oX2FjdGlvbihzdHJ1
Y3QNCj4gaWVlZTgwMjExX3J4X2RhdGEgKnJ4KQ0KPiA+ICBlbnVtIGllZWU4MDIxMV9zbXBzX21v
ZGUgc21wc19tb2RlOw0KPiA+ICBzdHJ1Y3Qgc3RhX29wbW9kZV9pbmZvIHN0YV9vcG1vZGUgPSB7
fTsNCj4gPiAgDQo+ID4gK2lmIChzdGF0dXMtPmJhbmQgPT0gTkw4MDIxMV9CQU5EXzZHSFogJiYN
Cj4gPiArICAgIHJ4LT5saW5rX3N0YS0+cHViLT5oZV9jYXAuaGFzX2hlICYmDQo+ID4gKyAgICAh
KHJ4LT5saW5rX3N0YS0+cHViLT5oZV9jYXAuaGVfY2FwX2VsZW0ubWFjX2NhcF9pbmZvWzVdICYN
Cj4gPiArICAgIElFRUU4MDIxMV9IRV9NQUNfQ0FQNV9IRV9EWU5BTUlDX1NNX1BTKSkNCj4gPiAr
Z290byBpbnZhbGlkOw0KPiA+ICsNCj4gPiAgaWYgKHNkYXRhLT52aWYudHlwZSAhPSBOTDgwMjEx
X0lGVFlQRV9BUCAmJg0KPiA+ICAgICAgc2RhdGEtPnZpZi50eXBlICE9IE5MODAyMTFfSUZUWVBF
X0FQX1ZMQU4pDQo+ID4gIGdvdG8gaGFuZGxlZDsNCj4gDQoNCkFzIGZvciBvdXIgcGF0Y2gsIHdl
IHJlY2hlY2sgdGhlIEhFIGNhcGFiaWxpdGllcyBhbmQgY29uZmlybSB0aGF0IHRoZQ0KY2hlY2sg
b2YgdGhlIGR5bmFtaWMgU01QUyBjYXAgaXMgdW5uZWNlc3NhcnkuIFRoZSBkeW5hbWljIFNNUFMg
Y2FwIGlzDQp1c2VkIHRvIGFsbG93IEFQIHRvIHVzZSBhIHRyaWdnZXIgZnJhbWUgdG8gc3RhcnQg
YSBGRVMgbm90IHJlZmVyIHRvIHRoZQ0KU01QUyBjYXAuDQoNClRoYW5rcywNCkFsbGVuDQoNCg==

