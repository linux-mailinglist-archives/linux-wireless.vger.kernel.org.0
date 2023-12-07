Return-Path: <linux-wireless+bounces-554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B22808E34
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583551C20921
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1844C73;
	Thu,  7 Dec 2023 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SeUJ1hN4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QO6w1Y+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D11703
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 09:07:44 -0800 (PST)
X-UUID: 1f1095c4952311eeba30773df0976c77-20231208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JvQt/+EIa0VppwK058l2w2JIpPY1ZiowOW96QjvaMI4=;
	b=SeUJ1hN45M3PAoXj9Oh1eJIpByWjMZQEzdtk7rISSX9Sd+fY0xyaj+FGEBrEBST7xp4ZHWC6VvmKAg974IKBN3oeC1gwszpvF9zWkockR4aDBew1um6gudnaiqIu2imcG350Ba64LPfXo5NViFM2TNo5cu1Fwfq5A+WzdlNUxac=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9bc53cb4-fa12-4eb5-9b5d-8df61955c2cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:e75d8773-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1f1095c4952311eeba30773df0976c77-20231208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1383164589; Fri, 08 Dec 2023 01:07:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Dec 2023 01:07:36 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Dec 2023 01:07:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcUnraIfGL6wkhT3+EuYc6Zuhw9gO0mgNnIqhdxKDJREV2jqMy03LffINScJxcKQs+oelWPEebxcbsWqgfoGWEWZGkC7jBG5kQhnuBv361/Gq1+LSzYnjh9KDBBsRr9Ovz+xn3dyL1QRMAsVrN1dW6Jn/G+/pttJOImPz7UHoOgkXP/TDPAv+eGayShtu9LgwNk3JqyK3/t+ZPI20/LTxVr3uux69OoQSGEbHWcwWd9Vi9A1v2dhSWbMtJGd5zkDtZb6qV8TYLHuDcsVUvPAaEnNEbCHnV9PqysIFvyuWXPOfXjz6JYtWMldyy+fPxYfQHQ8L7oE5YnjF0c4TauTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvQt/+EIa0VppwK058l2w2JIpPY1ZiowOW96QjvaMI4=;
 b=W4iSvuVIF736iJDGtqSNnwTBQIwRLor+kT54o6upZTRjsWB0E1ayTcZS/D5JHqKCTak8qMYlqmVYM9Nf5QuZh/LKZiKtsTw3rp6BHfzmx+3uWcbFyQORmeNM7vxapgFqBxkxyums4eOzp50cq9ehkEfHlVW6oA3GXZn+jYlQeK9X3p05FdcbMmHddckmHvYmp9dDlV2WtUaRwtF/axccK0RriadoSH2pPvvNwLiE7BEiqCsUN03ru9qQ/XmXMZ6wFYU90UuvLleYnbb0WLwL/M1nHlpVbU/8VZcSeWvfDxvpN2bL46vBoacjxtqZjKIehmB0c/8D6IRWR3GlBjrFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvQt/+EIa0VppwK058l2w2JIpPY1ZiowOW96QjvaMI4=;
 b=QO6w1Y+3bCB2wx4EwUN+qE5fyW3Fga737YkPY11xa0GrxN3mfTSPIwcpiigVvTvnqAks4yfoWSPmlfxinTtc8YNwpwDD9BBYuR30d9u+A55XdyAaEaMKXoSegR5pkQLqyhmKS1uTPHm9jec6SXqGWhNU5LfYLgJq5dNqpEv8Xtk=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by TY0PR03MB6728.apcprd03.prod.outlook.com (2603:1096:400:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Thu, 7 Dec
 2023 17:07:32 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::2910:7865:df61:6161]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::2910:7865:df61:6161%7]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 17:07:31 +0000
From: shayne.chen@mediatek.com
To: "greearb@candelatech.com" <greearb@candelatech.com>, "nbd@nbd.name"
	<nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	=?utf-8?B?QmVuamFtaW4tancgTGluICjmnpfmtKXnt68p?=
	<Benjamin-jw.Lin@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 4/8] wifi: mt76: mt7996: switch to mcu command for TX GI
 report
Thread-Topic: [PATCH 4/8] wifi: mt76: mt7996: switch to mcu command for TX GI
 report
Thread-Index: AQHaDXQKhS0h+m3xak2KbhkRPW7FSrCZ3tyAgARl9AA=
Date: Thu, 7 Dec 2023 17:07:31 +0000
Message-ID: <38bc4fd457247edeea18e4eacfed89d74264be58.camel@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
	 <20231102100302.22160-4-shayne.chen@mediatek.com>
	 <ae3f3bdb-0de3-e15c-f447-6d1d33478051@candelatech.com>
In-Reply-To: <ae3f3bdb-0de3-e15c-f447-6d1d33478051@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|TY0PR03MB6728:EE_
x-ms-office365-filtering-correlation-id: 906138fc-3415-40da-0f82-08dbf7470004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9PoOHtx1KTO8xegRchKwRsTsw0XxaLmYwStOl7RbPo+Ny/lyqmSwm4W1xOnI4CtwYM0SFYcAQhOPOe/9JaIzX3X4gXmcKndwLVpuuG+axRhmg40Fqdups8fAw3tmSwOfLOXYdYbQb24DJQbadM4yOPdYjxW1WlrmhPISLSYKREzHR9oslBy9KIXsuIEt40K/zBtZCnKoVpiDHk1I2XzhoNmqHz2NZkFP7h0s8wSRjC5y4KPEbqe61BMC2YIOtUJtOB61PPia+XRAoQscIC8Cic53m86QFxImkXRTvAc1ZDnfmtY5p1YMSni8RbwIRBkFC2ImH7iEPgSFzQW2Atk+LFh7PdphY3fBLPl4q4bGlkNEDi9Nt/pMzydE5yjj2EzTkFYZNr0CXMO0ahn+x+qAntqCXRvPQp9pGhlpfwnNHBZrMmSRZYw7FeNovbDdNIiWbFoCHyZQUxRKa+e0ofX8he/eNaNL4MbtlCZK7IMc5xqeyyrcveNSQ8NC8QcazHbyq3eql1hDqRAF8vBelD+BRLOLT+ohyGYn8439HqO6OWjZ2Kavmma48IjrYbMGZCK53fGuwD05iOkNey7mTviSYa7P7p2+e3AquWsyWjYOAfwCKrifVKUneMVwE5Eyvp5jgrW1wmbVKUCqi0lX8hnHSWs+Y7FfR4fzF+6e6r2XiFHEUY4+KHLEofVMIP05+bP8d+w/Fd5bH19OH6B2T+/mNj0wo0q59kVpvcPYedK+ew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(110136005)(8676002)(316002)(54906003)(4326008)(86362001)(64756008)(66476007)(6486002)(966005)(478600001)(66446008)(91956017)(76116006)(66946007)(66556008)(36756003)(41300700001)(85182001)(4744005)(2906002)(5660300002)(38070700009)(122000001)(38100700002)(2616005)(26005)(6512007)(107886003)(71200400001)(53546011)(6506007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBRUUQ3YzM3R3RNTmJOdituc1hQSmMyMGpvZE04N09rMVhSZkdyTzVjMENa?=
 =?utf-8?B?MGxWQVBGSTJSODlzTDZJWmRNRmZXQ1NzU29JS29Bc2JyNnZQSVZUM0hMSHNV?=
 =?utf-8?B?UWZxVWJlbnlnSFJ4d1diYjdmZnFWa29CeVB4SHNXWmFtalJKSXkvTG9rM2pa?=
 =?utf-8?B?Rkxxbzd6eVVneUUrc0hxcG1VUFN1dW9CRS9sbDZVcGlzK3dCeU94TFNMaTRy?=
 =?utf-8?B?WWlSUmVDdlljZVNvSWdsSWt6a2VDTVp3ZDlnUU9wdGlIYWhDUzFzdTB3K1pV?=
 =?utf-8?B?amdSOGpWRVJvNi82STRWWnNnQVZzdU41aXd4U1Urc01WY2M3Y2dWRnJXR3k1?=
 =?utf-8?B?L0hLQm5WellXSlNaKy9OZmRMM282bDFaVEU2K3NRZEtONkJJUUZtbkw5NG9D?=
 =?utf-8?B?YWZNa3dVcUtWRjI0L0hjemZLejcrd2NCVEN0enZmVU1VTjN5UnVJR3Q0K0ky?=
 =?utf-8?B?anBSZzRSOXpBRi9wYUJhNitEU0VoQUdBL1hxMlZLS1hMbS9FcmdlS0FzK0Fl?=
 =?utf-8?B?cmhnUmRsZUdpWllQaXI2QTlrU1NqRWNkc1ZsalR0SHlPR2xXQUVXMmhkRE82?=
 =?utf-8?B?OFZiUkNJQmpVNGhjS01tcG9VblNicyt2SitGNGgwR2xKM2x2ZlJ4ZEJOa3Ri?=
 =?utf-8?B?MTNBV3VIM1AvSVc2QTZkM1FPT0trekVpUXh1UUFhNXlPSmwvQUFaazMvcTYy?=
 =?utf-8?B?VWZsUUZQaTdHTW1QUjFZeXpUdndsZTFNMWt2WW9OdXdlZHpseGFxeGpJYmJv?=
 =?utf-8?B?cXNIUjFlaHFEM1U2WEZITXU2b2hQSzJzcDdDWEJzbnVvN3JXM1ROaDQ5bDVL?=
 =?utf-8?B?dFRsVFFEZEhpNVJ2NG1JK3RaWVF1RGo4aFFIUC9VWlZzZkRJbnk5NWFTSjFY?=
 =?utf-8?B?cXduakVNdkRxS0x1SGZ0aTcyUjlxOURkZm5VdjFFVUtsUmRoMzMvUnZZVmR0?=
 =?utf-8?B?RUtGK0pQT0Fpd3MwWUhGUkh1RE1pdzl6dGt5dVdRWUtDV1Nrcml6SnM5aWdP?=
 =?utf-8?B?Njl2N2VqT3pRUjYyRVpmeWdpT2NCNWUyVDRWZ1NETzhLZFh4WXZXRHZNZWFZ?=
 =?utf-8?B?TkVUekw3ZlNBZ2xpejdnTjZwT0JLR2VQRkpSU2tiR29XTEY2UmNUYVNuWmtl?=
 =?utf-8?B?TWs0aTRSeUNaMXZzT0I1KzZROTZzdnhVVmFBZS9qN2ZQbzh6ZjRIT3NYLzBE?=
 =?utf-8?B?SHFOMG1lalJBcjl1YUFTOHlHUzJKUGZkQmIvWkx4VTFmM3YzUEpBbEVyZ3ow?=
 =?utf-8?B?bFUxelZxTVZMejVualZDME8zRndOdlJsR2w0R3VMNnNVVmZQRC9vM3hYMFlQ?=
 =?utf-8?B?eWNMcmZMc1F4aXpKTnNMNW4vaGttMmd1OG5xWG5LVWJDY2dTeHFEWFRHenN4?=
 =?utf-8?B?RHd6NkpoTENOVGxYVnlsT0tpL0ZBRklTTWd2Rm9lT05VeUd1bWRXK2hqODFj?=
 =?utf-8?B?RWY3M1pjZDYwK0o0aThNVEp6TVR2bEQwRW9KaVNreUE5RHR6T1FRcSthRStW?=
 =?utf-8?B?SzdMNDIvT3U2OTlVUjAyR1dHY2J2KzRudTZTYlMySG42Y2ZmYXRqZ0lZN2JF?=
 =?utf-8?B?SC80U1BOdnlvaFIraEVJY2lZYm9OUWVlRU01SmNxUTl0QXR2a2ZCb1I5bCs3?=
 =?utf-8?B?OTljbkpXU0NWWm5XczQ0RzJxMVJLM0xPemNKZVlYWFpwMnRCS294d0p0Wkgw?=
 =?utf-8?B?RHl5dk10NGw0SHQzeVExcHF1OXk4eG8wNk5LZ2dQZ2N4ZGJXL05JT1gyL0sz?=
 =?utf-8?B?T01Ka0M1Y3o4ZmhEY1VFMC80cmhQYWJtRGR3UnZ3SDJESStzeU5JSUFuZlBM?=
 =?utf-8?B?U0pVcnVGYmRHdkRGN2RaSlN6c3k4N2RJRnM1Y0FMUHBjazFwVng3MkpEVi9q?=
 =?utf-8?B?b3JpSktSTUpGVTdKajRnN1pFTW9jeGRmMHBSTUZqRlEvcGt5TmJOR3ltZ2kv?=
 =?utf-8?B?V3B5dEc1M21acmlNcWNZdi94SzFGcm9pT051QkFkejZZdEt4eUhBMSs4K2VZ?=
 =?utf-8?B?VUZQczNwaW52RFB6MzdReWFTT2paRG0xR2JDMmZCUWFHRWdxNTFSMW5rdis4?=
 =?utf-8?B?V1Nad091bjF5dXcwY1ViMGdTM1lrS2hoNWMveVJHZUc5cHA5b0orTFdCSk9I?=
 =?utf-8?B?aCtmdFEwZWpQZGZhelNXVWJkcUYwQnI5MHpXcUo5QTZpRmY3azNtRHArazJY?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7125AA3E14B2AF4AA5E10885D6D6BE7E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906138fc-3415-40da-0f82-08dbf7470004
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 17:07:31.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVZzEhj7hC2++LuA++P/QX0n7BFz1jVudFCS3tU5FW6ltPl1PiXFziGt0pg38GC+VzG2ZpFeROlPysVTJnHMfItsvGx0qXQf66gnpJwf3oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6728
X-MTK: N

T24gTW9uLCAyMDIzLTEyLTA0IGF0IDEzOjU3IC0wODAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIDExLzIvMjMgMDM6MDIsIFNoYXluZSBDaGVuIHdyb3RlOg0KPiA+IEZy
b206IEJlbmphbWluIExpbiA8YmVuamFtaW4tancubGluQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBEdXJpbmcgcnVudGltZSwgdGhlIEdJIHZhbHVlIGluIHRoZSBXVEJMIGlzIG5vdCB1cGRhdGVk
IGluIHJlYWwtDQo+IHRpbWUuIFRvDQo+ID4gb2J0YWluIHRoZSBsYXRlc3QgcmVzdWx0cyBmb3Ig
dGhlIFRYIEdJLCBzd2l0Y2ggdG8gdXNlIGFuIE1DVQ0KPiBjb21tYW5kLg0KPiANCj4gSGVsbG8s
DQoNCkhpIEJlbiwNCj4gDQo+IEkgZG8gbm90IHNlZSB0aGlzIGNhbGxiYWNrIGhhcHBlbmluZyBv
biBteSBzeXN0ZW0uICBXaGF0IGZpcm13YXJlDQo+IHZlcnNpb24NCj4gaXMgbmVlZGVkIGZvciB0
aGlzIHRvIHdvcms/DQo+IA0KPiBBbmQgd2hlcmUgdG8gZmluZCBpdC4uLg0KPiANCg0KUGxlYXNl
IGdldCB0ZXN0aW5nIGZpcm13YXJlIGZpbGVzIGZyb20gdGhlIGZvbGxvd2luZyBsaW5rIHRvIHNl
ZSBpZiBpdA0Kd29ya3Mgb24geW91ciBlbnZpcm9ubWVudDoNCmh0dHBzOi8vZ2l0aHViLmNvbS9j
c3l1YW5jL2xpbnV4LWZpcm13YXJlDQoNClRoYW5rcywNClNoYXluZSANCg0KPiBUaGFua3MsDQo+
IEJlbg0KPiANCg==


