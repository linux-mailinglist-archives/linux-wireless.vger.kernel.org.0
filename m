Return-Path: <linux-wireless+bounces-90-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232E77F979F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 03:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C294280D3C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CD15CF;
	Mon, 27 Nov 2023 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oUolaLCk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="j0Vlk42h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF4111
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 18:49:49 -0800 (PST)
X-UUID: 9fab9e108ccf11eea33bb35ae8d461a2-20231127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J7Tfys8sv19fI5NiFWo82JU3aRM2Ye+FLeIlVw27EZ8=;
	b=oUolaLCkZUsFDNfZVwB9gO4kWpmIs7RMkK7jrhndaqptK3CUQYG4AE2o0+xVH3VW8EL12NgKIGrWabD8kLkmVuhl8P1a2XYSdsX5cXm3yp2RdpAHJZp/fFaJhvfBNXGEXp+f3++5jBvsEGQPCWIzXpau/dQUdSMf2j5JJ2DMU9o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:73568dce-c702-42ee-85b3-a041c6843fd1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:a180d695-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9fab9e108ccf11eea33bb35ae8d461a2-20231127
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1510524192; Mon, 27 Nov 2023 10:49:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 27 Nov 2023 10:49:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 27 Nov 2023 10:49:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRhadypjmXf56plcpprVtoNqz0/Ra/fqfPXXxewRSzVrTCW7CsAjLac3+VVgO3U10+dZsTrov/+C2/X2PboSbl4+DORuPAUypz982QDFGa97YDbln/j+q+pTLClhFBvxhSHAh29ADHZ6TIdN/qc+7XUcjOjJsm0e2HushTWQshnt5zb0EOT4f/vwBN5InigXcVzHKQtFV9KTjk5jJl1nkRi6q675qWMThAiX/lZVZ6u3QZA7OJ8ELJZ8PoncCDxcot9cd4Fu8MMEyZLJ4sBR+5Eo4VYbiG/jd4ZBqc79DG6/ANaRA2lHbQRtih32wKljnhUp2t/+P8qrDIP5DQ7MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7Tfys8sv19fI5NiFWo82JU3aRM2Ye+FLeIlVw27EZ8=;
 b=fRx+4DZ/oKjhDowBW8Y42/KrCFVBQeUaa+/A7HYuLHrLl/Khnwc3RIzFhU8Wv+sdgLsJ3FVLsEAtUUg601yxtmJQOHbOsKcd4A8yi4BIyKR77cPn9Yv8Trwv5ab54ewnNthco6acMf54rpVQq757atHop/RXBBrdLgIt4V0lMlacj58tAFlRWn5ezVCLPCL4bI8KdsCimYx4gXKBGViQR1Pv6jrOOImkH8FX3NFt2a80tin57+MbUqcoOeskr17o7cL3SyXXB2+flY/xHrYgGGsIUELr5CzGWQMsAidyDjXYrkH8l2DahuN15pehnwNrwFj6N4Mn+xQKULk7aN4VUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7Tfys8sv19fI5NiFWo82JU3aRM2Ye+FLeIlVw27EZ8=;
 b=j0Vlk42huf+dt1W9qDJwE7l6AA5Zdbe9lZ13rX5/nbqXrT2rFo+YWmUlpZBukC0W5DXJ1H54rU11cCgcIYuc+DXuNIGpLbJpTef7Yl/7f1s/99ijtvefk0aORNhFhypE7pRpk92Mn/qVyfqaN5+IRC0nvImQ+eAkRNaI0plNZeY=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by TYUPR03MB7161.apcprd03.prod.outlook.com (2603:1096:400:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 02:49:41 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::30b1:4c15:efa0:b4b5]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::30b1:4c15:efa0:b4b5%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 02:49:41 +0000
From: =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"nbd@nbd.name" <nbd@nbd.name>, =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?=
	<Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	=?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= <Money.Wang@mediatek.com>
Subject: Re: [PATCH v2,1/2] wifi: mac80211: Add utilities for converting
 op_class
Thread-Topic: [PATCH v2,1/2] wifi: mac80211: Add utilities for converting
 op_class
Thread-Index: AQHaFdazOV9CqZlW+0Wl4KapVQTYYbCJ7GwAgAOgoYA=
Date: Mon, 27 Nov 2023 02:49:40 +0000
Message-ID: <5bab90c7b52c48ec9229814bb5519dd389e8cceb.camel@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
	 <ff991106e2b09e296725be4d1fe02de1911a2a2c.camel@sipsolutions.net>
In-Reply-To: <ff991106e2b09e296725be4d1fe02de1911a2a2c.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|TYUPR03MB7161:EE_
x-ms-office365-filtering-correlation-id: a646b961-aaeb-439e-b701-08dbeef380e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdoEDSTLcC73GrnNEJzI7C2QRSoB7LcGfODKq3RDCRbXt81jsMzkVOdxOaDO9b9Ih2A7lAZzdBsJKm6HyHwUZU2nzpo1aLxkTzXFkpyfsbVUVj0/s/xT0dhSoqPQUuUV2gaqDb6WHc3z/f/bc3W6tyKej363mFFj/0iLBqRQRUchlifjCQW487nEi97zevaj7+kXE32wv7yY09Ttt3XjwHbX6aUepozaDzfad6TqaKTfiM2mFS3mjaQye+099C1DKUmXPg41Wo/gTseDerCqiDwEUNstYWg9yWxLwCZb43LG9PYT+1jNvOlGLRc5iadu+rGQmNupRoXhQzEUbxbDqZjPNiVOhCUHkcXplZsWT67Kf6GiYcB5pgBrXZSnTes049ALAL5sW2h8B55GWxKCI6Rcr2L8O3pc0KsMBACcBP8ywz+xIyBchpX0RCnBlDihOOkgr3RrtJMGHsGZVyklxrnpnTNlQ8ngu/nx1BrWuC0Mpi4tMoYWeU6NxrZItuYx+0+CNgfBr9bquLv1f8JUJHDJU6JBudEumlyu+n3oLB61FHHvKhw4THt8S9dlihai9jgYVIGxzOGkA5SRhqt/9GSYL/Qqm8qAoe2Aaw5YEZKjSb23FhIRDPYOdjkoWI7M7g1MI/J6VXwC4ktHsvHDrwN0O4vfoZMtQERj1zlsYFQtG+JlW8XwC7QH2lkVmLk9xcbG+Ey3R9uHRTUMzmJtUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(71200400001)(26005)(6512007)(6506007)(478600001)(122000001)(38100700002)(38070700009)(86362001)(85182001)(36756003)(4326008)(5660300002)(2906002)(4001150100001)(41300700001)(83380400001)(107886003)(110136005)(6486002)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlgzTzVUQlpjM0FHOEZRYStSejZpcjQ5aUZQcGNrTjZnRDdBQ1YvREZpRnRL?=
 =?utf-8?B?WFJNdVpRWFRQTGNEVkhXck5PS05CMFlNdWtRQWhXRFJyOFU3enJrV2ZaUmRr?=
 =?utf-8?B?aTlTaVljRThFZElkU2VHMUJ4Wm5EWTFFSFdyL3RxN2VpVG5xQ1JXK2JGR1lz?=
 =?utf-8?B?Ni9KZFM2WWUxRXBrY3BzTUk1TVNvazRJcGFCSjBJTVFVL2NOcEgwbGxoeDBk?=
 =?utf-8?B?S3VFQjJwQS8zSG1UbXJxM3NyenZzMjZmVVpjOGh3ZHVlQVUveDVZT0d0UkUz?=
 =?utf-8?B?U2FmMTBUSUUwdkdHa3hGR3M0MVBIczZMQWVUNm13Smh3Nk1IWjFhOHBIZ2Q0?=
 =?utf-8?B?LzFaSVoreWVubk1xWXpNN2YrcVMySXByWEh1S2ZqdU9TclhoQzg0V3ROdkpG?=
 =?utf-8?B?WmRDMDc5R0xqWDlGeDlQSFc3c2R0aE11Z0hNRklWU3Z1ZllRVVVXTENZZGVW?=
 =?utf-8?B?SjVHeXhtNmVabnRKYmY1Y2F0RmpMVVBrbEtlcDJOT05rVkFlSUhndi9CRmg1?=
 =?utf-8?B?RTI2TXVWTXlxMEx3anFBSm1Ycmh1M2Y4MFR3N3BwNjREREZEbkNvbU1PUXdq?=
 =?utf-8?B?RGUvNHhQakV2a1hDdXVyczByOThVNEl5Wmlma2g0dWVzNXlnRnl0SjNIOXNz?=
 =?utf-8?B?dTMwcWUrWERxalpXbzFKTC95M3dnNHJRYXl6SVdMY0pYVEpISms3K3d0Mlhw?=
 =?utf-8?B?dnhyWjBFalBOdjVua05STS9Bb1JydTM5RnhldXBZZ1JnUzdRWktmTGE3Z25h?=
 =?utf-8?B?eU5RZ3k1RWFSRnc1OGU1bElaRjFIMjBkZHJ1MVRhRkhFc01HR3NPanZrT3Fw?=
 =?utf-8?B?a1k2ZFNtSCs2Y0VpdjMrSHlTeFJWeEFkUFAxUy94TDJCYnpZUk84N2hNeWhH?=
 =?utf-8?B?ZnpDSHJkenNPa2Q0U1B5YVc5OE9JNFdQU1hsVHg2SHFkZ1NpVUFhSjRUVzQ2?=
 =?utf-8?B?V0p6dXYrai9RK2I0Ymx3WWQyaUhiL0NtRGllYXovS2tuOEt5RHAvSEhtMXZz?=
 =?utf-8?B?dGJhZER1VFRNdEFQUUhkcjRKU1dnVzZvMFA5dGdvdFd6Z1NLdk9BNUllckNL?=
 =?utf-8?B?SkhQU2d4NlZjWEV2T1NIdGl4eWxiSVhMeGN3cXBaWXBwTGtPaDA1T3BoRG9x?=
 =?utf-8?B?aER3ZklURjlRcE5XUlpkYUxrVGZMdUl2Ymd5RHRjMzV0UUU3NUtEL0hWczk5?=
 =?utf-8?B?ZTJ6SGwwTVowT21NUnkxQnRUN3Q4Mlg4d0wrNzJSOGZ4VDIzaUZobTd6Yy84?=
 =?utf-8?B?U2tHTy96R2N3dTRJVnFNanRSUWpLWUNlZk9Qa1VyVi90azg5WnRuVFR3QWt2?=
 =?utf-8?B?K29vbEhwaE9LSUNEdGpNeFNDQ0I2MmhVQVJ1UUhsZDl5TGlDZGhEcDNuNGdX?=
 =?utf-8?B?TkppQ09MK0xxbDN2T1d5UERmemxnM2MrVUpzWUxEUlpNQkpGNDZ2ZmFRMEtr?=
 =?utf-8?B?bHFHcUUxcVB4Y0gvL1I0UXE2NWdIa2lXbEsxWlVLSmZOeU1vOG9SazNFbFRG?=
 =?utf-8?B?Z2FMSXVKSHM4Z1NzWnp4NEVPRjhhVit3K0pVQTN6OXlidG5TcGEzUkhoL09T?=
 =?utf-8?B?czl2SWoxNFVlNUp1VFczRlNRK25yM1l0N3BkL2lsNlNKVUFiN3lNK1JQQm1h?=
 =?utf-8?B?Mk9Uc0ZlRE4wWkdsV3NVWnB6K01nV3FFcDVrNVc3d1RCekdzUXBzSFJ1OWxH?=
 =?utf-8?B?blpjOWplQ2FiWWxEUGxyYzFMRnM4ekoxazBhWUxaSEVvbytOQ0RRQnVuY1NP?=
 =?utf-8?B?QVZnMlpjM3BRdGNCazlrVFBqdjh5VUIzZzVuZ29zWXMyaGRndzdEQlQ4QStZ?=
 =?utf-8?B?Q1FpdnluZkJGai82SENWdnQzWjhKVmFYOGhXem5WQ0VFcEFhNzF3OVkzNjVQ?=
 =?utf-8?B?OHpKZjBLVFd5eSswYjk5ZDBGREdRTUdZbFJkOVUyWEJPR3dsSS9pOHBwbk5Q?=
 =?utf-8?B?OWNSZXh0YUpYNVlpeGpCa2pPeGhyTS8zbTQwUTd1Q3NiMnRkbzJsZnVkRGFE?=
 =?utf-8?B?b04vWGwwczVEVG12WkUrNzNXZnN4eVNkRGRQL3p2YjNpWHFkdHBkeVJXZWJ0?=
 =?utf-8?B?czE1QUJ3Q1JLZnpLTGZWWTNVT3MvVmtoTVRoR0pSc1ovaGZmSzljVGdlcStv?=
 =?utf-8?B?eTRSMDRuMVNoMUg0bHdHd2o0Wmt6bVRpUFV6UkJqeFpIMHZaeEpYUDZFL2ZL?=
 =?utf-8?Q?YfnT3+Yg7SgjeaIeMCgKOf4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C907548037E48D48AFA22A198C8ED8D8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a646b961-aaeb-439e-b701-08dbeef380e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 02:49:40.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cq+PolarB9dybwZmhgMITpOqgIGDffVj5v/MG9RYKbS12bG7lRvHCEtP98CvH28ChKAZ+T5psILFYQdcKIC6+fFF0GTbEQhyxXbpk7QkedY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7161
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.460200-8.000000
X-TMASE-MatchedRID: 1GZI+iG+MtenykMun0J1wh47EGkpGeA9gRykyfrH1xkNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CzMkdpJzbMUEd9RlPzeVuQQnKG
	VXD8wLQe5PLviRCQQgpWQoeJveB9Hmllju3jrF/cWny127IX6IMnlJe2gk8vIOYfO6E6iMvOgUU
	3sEcWomJQpmtzOkgccJ7F183Z7RE7yo11e4g8WXMOvQCMFyZ9G6Pzo2DwBrIpPCuo2vnnNcmXFJ
	gb8rLoP9LIWHDGCFs9VmNrvsGRXOlduF1CypBDQnbUZkYTzXIYqfmQMBL+Jkpsoi2XrUn/J+ZL5
	o+vRV7yhMIDkR/KfwI2j49Ftap9Eymsk/wUE4hoD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.460200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4FE8FB8F42C7D644FED6FCAD33083853BF5318B9F166C3448AC46D03553383FE2000:8

SGkgSm9oYW5uZXMsIA0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJdCdzIHRydWVseSBt
b3JlIHJlYXNvbmFibGUgdG8gZG8gdGhlDQpjb252ZXJzaW9uIGluIG9uZSBzaW5nbGUgZnVuY3Rp
b24uDQoNCndlJ2xsIG1vZGlmeSBpdCBhbG9uZyB3aXRoIHRoZSB0eXBvIGluIG5leHQgdmVyc2lv
bi4NCg0KQmVzdCwNCk1pY2hhZWwNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDIwOjI1ICswMTAw
LCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUg
dmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEJ0dywgSSBlbmRlZCBsb29r
aW5nIGF0IHRoaXMgYWdhaW4uLi4NCj4gDQo+IE9uIE1vbiwgMjAyMy0xMS0xMyBhdCAxMDoxMSAr
MDgwMCwgTWljaGFlbC1DWSBMZWUgd3JvdGU6IA0KPiA+ICsvKioNCj4gPiArICogaWVlZTgwMjEx
X29wZXJhdGluZ19jbGFzc190b19jZW50ZXJfZnJlcSAtIGNvbnZlcnQgb3BlcmF0aW5nDQo+IGNs
YXNzIHRvDQo+ID4gKyAqIGNlbnRlciBmcmVxdWVuY3kNCj4gPiArICoNCj4gPiArICogQG9wZXJh
dGluZ19jbGFzczogdGhlIG9wZXJhdGluZyBjbGFzcyB0byBjb252ZXJ0DQo+ID4gKyAqIEBjaGFu
OiB0aGUgaWVlZTgwMjExX2NoYW5uZWwgdG8gY29udmVydA0KPiA+ICsgKiBAY2VudGVyX2ZyZXEx
OiBjbmV0ZXIgZnJlcXVlbmN5IDEgcG9pbnRlciB0byBmaWxsDQo+ID4gKyAqIEBjZW50ZXJfZnJl
cTI6IGNuZXRlciBmcmVxdWVuY3kgMiBwb2ludGVyIHRvIGZpbGwNCj4gDQo+IHR5cG9zIGhlcmUg
KCJjZW50ZXIiKQ0KPiANCj4gQnV0IG1heWJlIGl0J2QgYmUgYmV0dGVyIHRvIGZpbGwgKG9yIHVw
ZGF0ZSwgd2UgY291bGQgcGFzcyB0aGUNCj4gY2hhbm5lbA0KPiBwb2ludGVyIGluIGl0KSBhIGNo
YW5kZWYgc3RydWN0PyBUaGVuIGl0IGNvdWxkIGFsc28gYmUgbW9yZSBlYXNpbHkNCj4gZXh0ZW5k
ZWQgdG8gdW5kZXJzdGFuZCBtb3JlIG9wY2xhc3NlcyBpbiB0aGUgZnV0dXJlLCBwZXJoYXBzIFMx
RyBvcg0KPiBETUc/DQo+IA0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm5zICV0cnVlIGlmIHRoZSBj
b252ZXJzaW9uIHdhcyBzdWNjZXNzZnVsLCAlZmFsc2UNCj4gb3RoZXJ3aXNlLg0KPiA+ICsgKi8N
Cj4gPiArYm9vbCBpZWVlODAyMTFfb3BlcmF0aW5nX2NsYXNzX3RvX2NlbnRlcl9mcmVxKHU4IG9w
ZXJhdGluZ19jbGFzcywNCj4gPiArICAgICAgc3RydWN0IGllZWU4MDIxMV9jaGFubmVsICpjaGFu
LA0KPiA+ICsgICAgICB1MzIgKmNlbnRlcl9mcmVxMSwNCj4gPiArICAgICAgdTMyICpjZW50ZXJf
ZnJlcTIpOw0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGllZWU4MDIxMV9vcGVyYXRpbmdfY2xh
c3NfdG9fY2hhbl93aWR0aCAtIGNvbnZlcnQgb3BlcmF0aW5nDQo+IGNsYXNzIHRvDQo+ID4gKyAq
IG5sODAyMTEgY2hhbm5lbCB3aWR0aA0KPiA+ICsgKg0KPiA+ICsgKiBAb3BlcmF0aW5nX2NsYXNz
OiB0aGUgb3BlcmF0aW5nIGNsYXNzIHRvIGNvbnZlcnQNCj4gPiArICovDQo+ID4gK2VudW0gbmw4
MDIxMV9jaGFuX3dpZHRoDQo+ID4gK2llZWU4MDIxMV9vcGVyYXRpbmdfY2xhc3NfdG9fY2hhbl93
aWR0aCh1OCBvcGVyYXRpbmdfY2xhc3MpOw0KPiANCj4gQW5kIHlvdSdkIGFjdHVhbGx5IGdldCBi
b3RoIGluIG9uZSBmdW5jdGlvbiBjYWxsPyBUaGUgY2hhbiAtPg0KPiBjZW50ZXJfZnJlcSBhbnl3
YXkgaW1wbGllcyB5b3Uga25vdyB0aGUgd2lkdGgsIG5vPyBJcyB0aGlzIHJlYWxseQ0KPiBuZWVk
ZWQNCj4gc2VwYXJhdGVseT8NCj4gDQo+ID4gIC8qKg0KPiA+ICAgKiBpZWVlOCAwMjExX2NoYW5k
ZWZfdG9fb3BlcmF0aW5nX2NsYXNzIC0gY29udmVydCBjaGFuZGVmIHRvDQo+IG9wZXJhdGlvbiBj
bGFzcw0KPiANCj4gVGhpcyBhbHNvIGNvbnZlcnRzIHRoZSBvdGhlciB3YXkgYXJvdW5kLCBidHcu
DQo+IA0KPiA+ICtjYXNlIDEzNTogLyogNiBHSHogYmFuZDsgODArODAgTUh6OyBjaGFubmVscyAx
LDUsLi4sMjI5ICovDQo+ID4gKy8qIFRPRE8gSG93IHRvIGtub3cgdGhlIGNlbnRlcl9mcmVxMiBv
ZiA4MCs4MCBNSHo/Ki8NCj4gPiArKmNlbnRlcl9mcmVxMSA9IDA7DQo+IA0KPiBXZWxsLCB5b3Ug
ZG9uJ3QsIGZyb20gdGhpcy4gSSdtIGFjdHVhbGx5IGEgYml0IHN1cnByaXNlZCA4MCs4MCBleGlz
dHMNCj4gaW4NCj4gNiBHSHosIEkgdGhvdWdodCBpdCB3YXMgdHJlYXRlZCBtb3JlIG9yIGxlc3Mg
YXMgYSBkZWFkIGVuZC4NCg0KDQo+IA0KPiBqb2hhbm5lcw0K

