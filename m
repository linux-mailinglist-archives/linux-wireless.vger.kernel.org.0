Return-Path: <linux-wireless+bounces-555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6A808E6E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 18:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619D4B20974
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3A48CC0;
	Thu,  7 Dec 2023 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aOgRgmXo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uxKKy5s/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4881727
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 09:15:35 -0800 (PST)
X-UUID: 38addaa4952411eeba30773df0976c77-20231208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Wz6IUMM/zMjz7XitIwv/dRZKDEXotLifayrZwn5OJIQ=;
	b=aOgRgmXoA4CSVvgej/uRiIaT5glVBM1d8VOLVVZ98ZC0v7bamUNBzie/USQm8skCHIdFno3+jNxPgq2dTaV2Q35SUwkmX3E1T9LMISX85GFp0SWoWQGHDonJwoLYbbrBq/HoHWXu2B7v+yKyT2F8NH4YcwCU0lU4q7TRHSVR2oU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:86d7af07-ffa6-4b63-8b2a-74a267041d86,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:9b6a8773-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 38addaa4952411eeba30773df0976c77-20231208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 510831445; Fri, 08 Dec 2023 01:15:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Dec 2023 01:15:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Dec 2023 01:15:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfGcn9EaSe/E0WqVGZl31E35VPRWC7bcrxf3OysEduOOOG56tbxcA8TMpSfgkke8/SbgBxBfS0K49dwFvqF/AM5HkqiUSz0EyDJX0FW1RWg0Ho3jthOAE0nA+nl8IIwHshSnfWxNsmYv5gDI9R9Zv06qXj4OZsjxv0l2f60+cjApMWWN+7NuSlupaXn4cr1F+wi4AGZK12yOSDi7+x6Xhj6YzwpLoiw2w+GQ0qKMkhNlmS8fIsGOiOPYUWBGmq3MGrEqDdNhOZqgaS6IAT7ULQs+aHzw9lEFIEy3I5axqM43tqOzHIIsFCP6kwn6Lxg76ELMMoJsGagGwbo57A6sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wz6IUMM/zMjz7XitIwv/dRZKDEXotLifayrZwn5OJIQ=;
 b=jgzXuCiqEst8w+EzTl2f9i/ggjdmtM2MY03EuN2xmqDAbDAt/x/SrGqo2HW9HVarGGmig/aawzmRnI7BwgEsCfKiOunpYIHsVVSfNXECaHa6uzCCMte1NE/YCAZPP1VHBAYjVnJWhQOecW46x68x0dcEpcAdEgTERG6TL2pv3Ohu8f6xB3RZ3Jnd2W6H9x4FmnYXrHCkgFbOxOFfyh23I15bkC+D5ZKkb2Tpr6GjZ4at0wtHLx1OZdxHbyB4a17L4BFac83h0WLyf1awLyuD97V8NLPExTmEi9TvscLXvwEzHbtbVmtIJkf5cXXdYaNq9htoxAkqfkXSiYIQ87Jweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz6IUMM/zMjz7XitIwv/dRZKDEXotLifayrZwn5OJIQ=;
 b=uxKKy5s/dEbtS+czYaFj+NRxB3v8+24AeAC990SAAJInJJqeaU5U1KJbsDHOy2jhCo7unm4KMHel+uBHetfnaUfQfwQNN4H6uZZyqTDtqoYSiAxDqKy4ngmAb0UTvD5eChbe/oCci4XmCmVKxghHkrWTcuI3m7jsmgqf8y0uwfQ=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by SEYPR03MB7011.apcprd03.prod.outlook.com (2603:1096:101:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Thu, 7 Dec
 2023 17:15:24 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::2910:7865:df61:6161]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::2910:7865:df61:6161%7]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 17:15:24 +0000
From: shayne.chen@mediatek.com
To: "greearb@candelatech.com" <greearb@candelatech.com>, "nbd@nbd.name"
	<nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, =?utf-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?=
	<StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH 2/8] wifi: mt76: mt7996: add txpower setting support
Thread-Topic: [PATCH 2/8] wifi: mt76: mt7996: add txpower setting support
Thread-Index: AQHaDXPYa72IazhFFEyR0fHMRe/gprCVRKCAgAkCZYA=
Date: Thu, 7 Dec 2023 17:15:24 +0000
Message-ID: <8c5fbe88bcc5b55e6d80247144e4f890fd68ef27.camel@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
	 <20231102100302.22160-2-shayne.chen@mediatek.com>
	 <bbf8fe7e-1098-5b33-8ed6-dee38329edf6@candelatech.com>
In-Reply-To: <bbf8fe7e-1098-5b33-8ed6-dee38329edf6@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|SEYPR03MB7011:EE_
x-ms-office365-filtering-correlation-id: a53450b2-ebd4-46b2-3a92-08dbf7481991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rb1uy/gstPW1iStdWDK3+gp/ODzBvoGk4MZZzTBca12ABQW0qJ6r7TMbn/IFp2/jjb7MgVZrfWtKFq8L970otkZdIeTKNkHDtIn67QXxBx9sibUgnc3ZcO9CPg/o2EV8255NEcbAZOABQ3qtihOOGZf5epD3Jr7ongcX9iXA4utjnJfMDmpnHtRYn4XmCCp6NTb/1Edd9mEcagtW6FvULDdbMBY5mC0BxSxqBSPUdoUbP9ViQUCgCuv7iAlhelAqnjppJ60GcZKK9yfN6RcXRwH873R+jI/9FLEro71/mq3RmjnZlTYX73WiGBrl7oz1LRW4mS9tnf/uiJB7XDyKKizWjqU6Rt0XbO0Vqx5IX7aXuowutcG961GPtgTp3Pygtl8JMx9FRASchIDZIGut+ru2Mnhh+fFxdQU0HZBspFwKiZmWD4VqvJm9awYC8yFWRsjzoMTYXxLP8gM5L7U8q7S/u3Loyt8HXURe+u5jFFV4H6nqwXNGhkPEuv4a+yg/dpAmlj28Z9JI4ZIaMjB2KxNIvpTONl1vCDOiAgzzhZ/GJA+kpLziwxWu4RBc48x4lP4AIkhCKd1ZhWqB4TE9zKm+hslL7oQa1vUtZnnm4pHWRYBIrgfw7/07qbODnkCJh9NOQ0BFw184na7SSPX7AyBkmRuZoYkCfki0b0FcCy5QkpBxE047lOgBr9G75BRrlS5ANd7fPBKrqSo8PtXKxy+mYktCK26DeBdDNHEVBlQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(6512007)(83380400001)(2616005)(107886003)(86362001)(85182001)(122000001)(26005)(6506007)(53546011)(71200400001)(6486002)(478600001)(91956017)(64756008)(54906003)(66556008)(4326008)(66476007)(66446008)(8676002)(76116006)(66946007)(316002)(8936002)(110136005)(2906002)(36756003)(41300700001)(38070700009)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkF4Z2VjTU1QKzJ2ai94aTRWbEVacjNPOWVoakM3WW80WWRkL0VLa2xzaDlv?=
 =?utf-8?B?WGUzSE1SK1g5bkpVVFJib3lFMVZaUzgySzhRM2Q3aktOSG1KY1gxam1neFFR?=
 =?utf-8?B?OGhWVURpbzUwM25QUE9LSDY3TDhCV2VSMVFYQlNNeGtVcGh3ZXBYcTJ6czVD?=
 =?utf-8?B?eEsvQ1lCUUJUOVhaZXlKbzMzYnZiR0FLeDI0M1VOdkxTTTBEUUswcmhQTE1u?=
 =?utf-8?B?K2NOUVp5cCtLWW5KRVhLUWVMTkphVEsydDFVR1NXVDA1dE52QmZISEEzQytI?=
 =?utf-8?B?VkNYdlp0Tlk1U29jbStneXJmZVh3WXNBU1FERTVPQzlnOW15d0l6NSsrM1Nn?=
 =?utf-8?B?a3hLQmZEZXNSdVZvVE9QRS83bHA0N0pJVVMxd2hCVXZmdUZQUXI2aFJnNTk1?=
 =?utf-8?B?aGNEdGc3VGpoYTF0dzJ1WCtqWldRa1lJN2NJM2tmOTQ2MGdzZ1RJV21sVTRN?=
 =?utf-8?B?N0Vwd01HQ2I2YU43bVFYb1FaclBoVWYwemQyYnNZdzBwMXNwTi9sTG1heVM0?=
 =?utf-8?B?YnBVTDI3dFZITit1ajk4UG1DajVmZVNyK0c2RFN0YnhmZXIrZjNGY3pVT05j?=
 =?utf-8?B?ZFFNMktNMW4rLzFwS09QUjhNSFF6SWZ6eDZJV0pHZ1g4aU8yc010OGtiRlBR?=
 =?utf-8?B?Mm1wd1F2QVVkK0thcE01WWU4cVlqcmhVSUx1V1gxTDJWWHVuQ29aYzlqaWR3?=
 =?utf-8?B?SWJjUUxoWWlRVUlFeXErZlJ2YXh1bXJ1K1Q0eXpDemFjMDk2NE1keGh6SzVC?=
 =?utf-8?B?a1BGYW1nUFdPNU1uam4vNGpISHBjZnFyU1d4cjBGZE1rVUN6OTVpdHFWQ3Ar?=
 =?utf-8?B?bEg2Q3VuYnNZR1l0ekxFbjB0dzhseEJORWNPN0hwN0VYWTJHL3NmVHhLenVE?=
 =?utf-8?B?akY0Nm9lUnhRS1RjQlpyMk9WeWpiNGFUN0Y2d0JKZFFvVjEwL0JBeklSSWFL?=
 =?utf-8?B?TTY3ajliN0lhSHBSVi9OdW0yMitoVXphKzZZK1NUU0E2bS9TdTNUalZiSjNO?=
 =?utf-8?B?aVFJZjlkM3diejdhQmVEWDZublZXbHAvd3dDKzk4cGJWK0htRWFvMnFnUjBz?=
 =?utf-8?B?QTEyL0UvOGxMOFArYkJ3VFQ0WGJWd3djL2NTTEM0Mnh1d1JnV1h5WGw2SUxa?=
 =?utf-8?B?aGI4UVZKUm9PR3gzWWZjSnZjOFUwQjRqZE1GZlNIN0hZSGdlK1RDYm43c252?=
 =?utf-8?B?TVo2SHRvdzNlNVdRQ3lNV241d1RTQ2xSQlVHM1BnQXlnOVBkdWtjQXhYM1Vy?=
 =?utf-8?B?ang3aGV6MUlBRy9oYSsxemU2ekpENXNyMWZGZUlVVU0rYWt5Skhid2VDTUc5?=
 =?utf-8?B?TEFtdnZRRVluQVdldnZFeTJseXZKVmxna0xwazkzY3MvQ3FkNW4zNkVDU0pk?=
 =?utf-8?B?UjluQkNaQlpjMHlIc0x1K2NHMlJFTGlGaTZNR3BaUDUwU3F1NHlQbHpkMTdJ?=
 =?utf-8?B?RkdOM2dqTVhqVnhuKzdmSGdVUy8xS1NGdW9tZEVhblVRbWpCUklEeU1nL05H?=
 =?utf-8?B?bUw4SmZRVEJhM3hjc09wbjk5U1VicXZXZ1d2S29KWVB4b0phb2prZXlQRDc3?=
 =?utf-8?B?eDVnUU56YkJDUmtFK2tubGU1MGRHVnM4YjNaSGxrbVlHNG1tQU5HUzBIOVda?=
 =?utf-8?B?UmEyOHVzUUY2bGNvSGZYM2VGcVNPcFlIdEF2NEdmZlR0NW1TR1UxSjZFK1BW?=
 =?utf-8?B?b1pQamdJRTlCckhKb2pIdzBQaFoxOEorVGdRNG8yK0FsV3cvdms5Ujlhek5x?=
 =?utf-8?B?TWUreXBKcSs3Y1UvRmhnbXVhMEhNU2V2V3ViNWIxcGdZczRBZjc2Z2V2eHhT?=
 =?utf-8?B?Ny9iR1lEUU94QVhpUG9XbFpkYnp1M1Z3K0VzZDFpU0hZcWF2T01lcEFMdkdL?=
 =?utf-8?B?eUx4OUY2Wm5MbGE1MjNMSHZkeU1DRnpPeGkzVTBTUVVwVTFnMGx6aVdWRWJH?=
 =?utf-8?B?SGUvWXhGL2dUWm5VSWpHeFVwTXhvRVR2NTNPb29VRGtxOFBtMTJPK3Q0dStI?=
 =?utf-8?B?SU9uNXgrWFJOTEZVMHEzT1JuTnNsTkVhTVJDeng5ZHhUNzh0NkwwLzNhUndr?=
 =?utf-8?B?TTE0SVkvTmtwYTFZczFmN3pjOGhyVFdTVG80bDZuNGQxS2U2M3dkeVJkajFX?=
 =?utf-8?B?bC85WGNmK2orWTZUeHluVENXY2lYazl3NzUralFteGlxL1p5OEhKKzdOMXFp?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5B2110F224B0543AE0FA385F5DD3AB9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53450b2-ebd4-46b2-3a92-08dbf7481991
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 17:15:24.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXezKExSkIhrRTh3h13SYLNOmHS/Z91oaOnPPcLvzRLlOh+F6kpF85mmbafly6EqEB0/j0qt9OSNDKoL+ZQ9mizhpG1YrkeqBi9oVBBLyaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7011
X-MTK: N

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDE1OjQwIC0wODAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIDExLzIvMjMgMDM6MDIsIFNoYXluZSBDaGVuIHdyb3RlOg0KPiA+IEFk
ZCBzdXBwb3J0IGZvciBzZXR0aW5nIHR4cG93ZXIgZnJvbSB1cHBlciBsYXllciBhbmQgY29uZmln
dXJpbmcNCj4gcGVyLXJhdGUNCj4gPiB0eHBvd2VyIGxpbWl0IHRhYmxlLg0KPiANCj4gSGVsbG8g
U2hheW5lLA0KDQpIaSBCZW4sDQo+IA0KPiAgRnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRoaXMgcGF0
Y2ggY2F1c2VzIFNUQSB2ZGV2cyB0byBubyBsb25nZXIgc2VuZA0KPiBwcm9iZQ0KPiByZXF1ZXN0
cyB3aGVuIHRyeWluZyB0byBhc3NvY2lhdGUuICBJIGJpc2VjdGVkIHRvIHRoaXMgaW4gRmVsaXgn
cw0KPiB0cmVlIHRoYXQgaG9sZHMNCj4gdGhpcyBwYXRjaC4NCj4gDQo+IFRlc3RlZCBvbiB4ODYt
NjQsIG10azc5OTYgcmFkaW8uICBTcGVjaWZpY2FsbHkNCj4gZGVidWdnZWQgb24gMi40R2h6IHJh
ZGlvLCBidXQgSSB0aGluayBpdCBhZmZlY3RzIDVHaHogdG9vLg0KPiANCkkgaGF2ZSBkb25lIHNv
bWUgdGVzdHMgYnV0IGRpZG4ndCBmYWNlIHRoaXMgaXNzdWUuIENvdWxkIHlvdSBhbHNvIHVzZQ0K
dGhlIG5ld2VyIGZpcm13YXJlIHRvIHRlc3QgaWYgaXQgc3RpbGwgaGFwcGVucz8NCg0KVGhhbmtz
LA0KU2hheW5lDQoNCj4gVGhhbmtzLA0KPiBCZW4NCj4gDQo+ID4gDQo+ID4gQ28tZGV2ZWxvcGVk
LWJ5OiBBbGxlbiBZZSA8YWxsZW4ueWVAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFsbGVuIFllIDxhbGxlbi55ZUBtZWRpYXRlay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBT
dGFubGV5WVAgV2FuZyA8U3RhbmxleVlQLldhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFN0YW5sZXlZUCBXYW5nIDxTdGFubGV5WVAuV2FuZ0BtZWRpYXRlay5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWFpbi5j
ICB8ICA4ICsrKw0KPiA+ICAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9t
Y3UuYyAgIHwgNTgNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgLi4uL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuaCAgIHwgMTYgKysrKysNCj4gPiAgIC4uLi93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaCAgICB8ICAzICsNCj4gPiAgIDQgZmls
ZXMgY2hhbmdlZCwgODUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWluLmMNCj4gYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWluLmMNCj4gPiBpbmRleCA5ZjEy
YjQ3ZWIyYmYuLjczMzZlYWE3YjlhZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWluLmMNCj4gPiBAQCAtMzk2LDYgKzM5Niwx
MyBAQCBzdGF0aWMgaW50IG10Nzk5Nl9jb25maWcoc3RydWN0IGllZWU4MDIxMV9odw0KPiAqaHcs
IHUzMiBjaGFuZ2VkKQ0KPiA+ICAgaWVlZTgwMjExX3dha2VfcXVldWVzKGh3KTsNCj4gPiAgIH0N
Cj4gPiAgIA0KPiA+ICtpZiAoY2hhbmdlZCAmIChJRUVFODAyMTFfQ09ORl9DSEFOR0VfUE9XRVIg
fA0KPiA+ICsgICAgICAgSUVFRTgwMjExX0NPTkZfQ0hBTkdFX0NIQU5ORUwpKSB7DQo+ID4gK3Jl
dCA9IG10Nzk5Nl9tY3Vfc2V0X3R4cG93ZXJfc2t1KHBoeSk7DQo+ID4gK2lmIChyZXQpDQo+ID4g
K3JldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gICBtdXRleF9sb2NrKCZkZXYtPm10NzYu
bXV0ZXgpOw0KPiA+ICAgDQo+ID4gICBpZiAoY2hhbmdlZCAmIElFRUU4MDIxMV9DT05GX0NIQU5H
RV9NT05JVE9SKSB7DQo+ID4gQEAgLTk2NSw2ICs5NzIsNyBAQCBtdDc5OTZfc2V0X2FudGVubmEo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHUzMg0KPiB0eF9hbnQsIHUzMiByeF9hbnQpDQo+ID4g
ICBtdDc2X3NldF9zdHJlYW1fY2FwcyhwaHktPm10NzYsIHRydWUpOw0KPiA+ICAgbXQ3OTk2X3Nl
dF9zdHJlYW1fdmh0X3R4YmZfY2FwcyhwaHkpOw0KPiA+ICAgbXQ3OTk2X3NldF9zdHJlYW1faGVf
ZWh0X2NhcHMocGh5KTsNCj4gPiArbXQ3OTk2X21jdV9zZXRfdHhwb3dlcl9za3UocGh5KTsNCj4g
PiAgIA0KPiA+ICAgbXV0ZXhfdW5sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KPiA+ICAgDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21j
dS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMN
Cj4gPiBpbmRleCA4MDk3OTI0ZDQ2MGIuLjgxNDFjMjRhZGU1MCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jDQo+ID4gQEAg
LTQzNTMsMyArNDM1Myw2MSBAQCBpbnQgbXQ3OTk2X21jdV93ZWRfcnJvX3Jlc2V0X3Nlc3Npb25z
KHN0cnVjdA0KPiBtdDc5OTZfZGV2ICpkZXYsIHUxNiBpZCkNCj4gPiAgIHJldHVybiBtdDc2X21j
dV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfV01fVU5JX0NNRChSUk8pLCAmcmVxLA0KPiA+ICAg
IHNpemVvZihyZXEpLCB0cnVlKTsNCj4gPiAgIH0NCj4gPiArDQo+ID4gK2ludCBtdDc5OTZfbWN1
X3NldF90eHBvd2VyX3NrdShzdHJ1Y3QgbXQ3OTk2X3BoeSAqcGh5KQ0KPiA+ICt7DQo+ID4gKyNk
ZWZpbmUgVFhfUE9XRVJfTElNSVRfVEFCTEVfUkFURTANCj4gPiArc3RydWN0IG10Nzk5Nl9kZXYg
KmRldiA9IHBoeS0+ZGV2Ow0KPiA+ICtzdHJ1Y3QgbXQ3Nl9waHkgKm1waHkgPSBwaHktPm10NzY7
DQo+ID4gK3N0cnVjdCBpZWVlODAyMTFfaHcgKmh3ID0gbXBoeS0+aHc7DQo+ID4gK3N0cnVjdCB0
eF9wb3dlcl9saW1pdF90YWJsZV9jdHJsIHsNCj4gPiArdTggX19yc3YxWzRdOw0KPiA+ICsNCj4g
PiArX19sZTE2IHRhZzsNCj4gPiArX19sZTE2IGxlbjsNCj4gPiArdTggcG93ZXJfY3RybF9pZDsN
Cj4gPiArdTggcG93ZXJfbGltaXRfdHlwZTsNCj4gPiArdTggYmFuZF9pZHg7DQo+ID4gK30gX19w
YWNrZWQgcmVxID0gew0KPiA+ICsudGFnID0gY3B1X3RvX2xlMTYoVU5JX1RYUE9XRVJfUE9XRVJf
TElNSVRfVEFCTEVfQ1RSTCksDQo+ID4gKy5sZW4gPSBjcHVfdG9fbGUxNihzaXplb2YocmVxKSAr
IE1UNzk5Nl9TS1VfUkFURV9OVU0gLSA0KSwNCj4gPiArLnBvd2VyX2N0cmxfaWQgPSBVTklfVFhQ
T1dFUl9QT1dFUl9MSU1JVF9UQUJMRV9DVFJMLA0KPiA+ICsucG93ZXJfbGltaXRfdHlwZSA9IFRY
X1BPV0VSX0xJTUlUX1RBQkxFX1JBVEUsDQo+ID4gKy5iYW5kX2lkeCA9IHBoeS0+bXQ3Ni0+YmFu
ZF9pZHgsDQo+ID4gK307DQo+ID4gK3N0cnVjdCBtdDc2X3Bvd2VyX2xpbWl0cyBsYSA9IHt9Ow0K
PiA+ICtzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+ICtpbnQgaSwgdHhfcG93ZXI7DQo+ID4gKw0K
PiA+ICt0eF9wb3dlciA9IG10Nzk5Nl9nZXRfcG93ZXJfYm91bmQocGh5LCBody0+Y29uZi5wb3dl
cl9sZXZlbCk7DQo+ID4gK3R4X3Bvd2VyID0gbXQ3Nl9nZXRfcmF0ZV9wb3dlcl9saW1pdHMobXBo
eSwgbXBoeS0+Y2hhbmRlZi5jaGFuLA0KPiA+ICsgICAgICAmbGEsIHR4X3Bvd2VyKTsNCj4gPiAr
bXBoeS0+dHhwb3dlcl9jdXIgPSB0eF9wb3dlcjsNCj4gPiArDQo+ID4gK3NrYiA9IG10NzZfbWN1
X21zZ19hbGxvYygmZGV2LT5tdDc2LCBOVUxMLA0KPiA+ICsgc2l6ZW9mKHJlcSkgKyBNVDc5OTZf
U0tVX1JBVEVfTlVNKTsNCj4gPiAraWYgKCFza2IpDQo+ID4gK3JldHVybiAtRU5PTUVNOw0KPiA+
ICsNCj4gPiArc2tiX3B1dF9kYXRhKHNrYiwgJnJlcSwgc2l6ZW9mKHJlcSkpOw0KPiA+ICsvKiBj
Y2sgYW5kIG9mZG0gKi8NCj4gPiArc2tiX3B1dF9kYXRhKHNrYiwgJmxhLmNjaywgc2l6ZW9mKGxh
LmNjaykgKyBzaXplb2YobGEub2ZkbSkpOw0KPiA+ICsvKiBodDIwICovDQo+ID4gK3NrYl9wdXRf
ZGF0YShza2IsICZsYS5tY3NbMF0sIDgpOw0KPiA+ICsvKiBodDQwICovDQo+ID4gK3NrYl9wdXRf
ZGF0YShza2IsICZsYS5tY3NbMV0sIDkpOw0KPiA+ICsNCj4gPiArLyogdmh0ICovDQo+ID4gK2Zv
ciAoaSA9IDA7IGkgPCA0OyBpKyspIHsNCj4gPiArc2tiX3B1dF9kYXRhKHNrYiwgJmxhLm1jc1tp
XSwgc2l6ZW9mKGxhLm1jc1tpXSkpOw0KPiA+ICtza2JfcHV0X3plcm8oc2tiLCAyKTsgIC8qIHBh
ZGRpbmcgKi8NCj4gPiArfQ0KPiA+ICsNCj4gPiArLyogaGUgKi8NCj4gPiArc2tiX3B1dF9kYXRh
KHNrYiwgJmxhLnJ1WzBdLCBzaXplb2YobGEucnUpKTsNCj4gPiArLyogZWh0ICovDQo+ID4gK3Nr
Yl9wdXRfZGF0YShza2IsICZsYS5laHRbMF0sIHNpemVvZihsYS5laHQpKTsNCj4gPiArDQo+ID4g
K3JldHVybiBtdDc2X21jdV9za2Jfc2VuZF9tc2coJmRldi0+bXQ3Niwgc2tiLA0KPiA+ICsgICAg
IE1DVV9XTV9VTklfQ01EKFRYUE9XRVIpLCB0cnVlKTsNCj4gPiArfQ0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuaA0KPiBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5oDQo+ID4gaW5kZXgg
YTNlYWUzMmM4ZjEwLi4xNTYyYzhhNmE4MjEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmgNCj4gPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuaA0KPiA+IEBAIC03NjIsNiArNzYy
LDE4IEBAIGVudW0gew0KPiA+ICAgI2RlZmluZSBNVDc5OTZfTUFYX0JTU19PRkZMT0FEX1NJWkUo
TVQ3OTk2X01BWF9CRUFDT05fU0laRSArXA0KPiA+ICAgIE1UNzk5Nl9CRUFDT05fVVBEQVRFX1NJ
WkUpDQo+ID4gICANCj4gPiArc3RhdGljIGlubGluZSBzOA0KPiA+ICttdDc5OTZfZ2V0X3Bvd2Vy
X2JvdW5kKHN0cnVjdCBtdDc5OTZfcGh5ICpwaHksIHM4IHR4cG93ZXIpDQo+ID4gK3sNCj4gPiAr
c3RydWN0IG10NzZfcGh5ICptcGh5ID0gcGh5LT5tdDc2Ow0KPiA+ICtpbnQgbl9jaGFpbnMgPSBo
d2VpZ2h0MTYobXBoeS0+Y2hhaW5tYXNrKTsNCj4gPiArDQo+ID4gK3R4cG93ZXIgPSBtdDc2X2dl
dF9zYXJfcG93ZXIobXBoeSwgbXBoeS0+Y2hhbmRlZi5jaGFuLCB0eHBvd2VyICoNCj4gMik7DQo+
ID4gK3R4cG93ZXIgLT0gbXQ3Nl90eF9wb3dlcl9uc3NfZGVsdGEobl9jaGFpbnMpOw0KPiA+ICsN
Cj4gPiArcmV0dXJuIHR4cG93ZXI7DQo+ID4gK30NCj4gPiArDQo+ID4gICBlbnVtIHsNCj4gPiAg
IFVOSV9CQU5EX0NPTkZJR19SQURJT19FTkFCTEUsDQo+ID4gICBVTklfQkFORF9DT05GSUdfUlRT
X1RIUkVTSE9MRCA9IDB4MDgsDQo+ID4gQEAgLTgzMCw2ICs4NDIsMTAgQEAgZW51bSB7DQo+ID4g
ICBVTklfQ01EX1RIRVJNQUxfUFJPVEVDVF9EVVRZX0NPTkZJRywNCj4gPiAgIH07DQo+ID4gICAN
Cj4gPiArZW51bSB7DQo+ID4gK1VOSV9UWFBPV0VSX1BPV0VSX0xJTUlUX1RBQkxFX0NUUkwgPSA0
LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIGVudW0gew0KPiA+ICAgVU5JX0NNRF9BQ0NFU1NfUkVH
X0JBU0lDID0gMHgwLA0KPiA+ICAgVU5JX0NNRF9BQ0NFU1NfUkZfUkVHX0JBU0lDLA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5
OTYuaA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L210Nzk5
Ni5oDQo+ID4gaW5kZXggZDNlYjU2NDYyM2FlLi5jNjJhNDI1MTJiZDYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYu
aA0KPiA+IEBAIC00Miw2ICs0Miw4IEBADQo+ID4gICAjZGVmaW5lIE1UNzk5Nl9DRkVORF9SQVRF
X0RFRkFVTFQweDQ5LyogT0ZETSAyNE0gKi8NCj4gPiAgICNkZWZpbmUgTVQ3OTk2X0NGRU5EX1JB
VEVfMTFCMHgwMy8qIDExQiBMUCwgMTFNICovDQo+ID4gICANCj4gPiArI2RlZmluZSBNVDc5OTZf
U0tVX1JBVEVfTlVNNDE3DQo+ID4gKw0KPiA+ICAgI2RlZmluZSBNVDc5OTZfTUFYX1RXVF9BR1JU
MTYNCj4gPiAgICNkZWZpbmUgTVQ3OTk2X01BWF9TVEFfVFdUX0FHUlQ4DQo+ID4gICAjZGVmaW5l
IE1UNzk5Nl9NQVhfUVVFVUUoX19NVF9SWFFfTUFYICtfX01UX01DVVFfTUFYICsgMykNCj4gPiBA
QCAtNDcxLDYgKzQ3Myw3IEBAIGludCBtdDc5OTZfbWN1X2dldF9jaGFuX21pYl9pbmZvKHN0cnVj
dA0KPiBtdDc5OTZfcGh5ICpwaHksIGJvb2wgY2hhbl9zd2l0Y2gpOw0KPiA+ICAgaW50IG10Nzk5
Nl9tY3VfZ2V0X3RlbXBlcmF0dXJlKHN0cnVjdCBtdDc5OTZfcGh5ICpwaHkpOw0KPiA+ICAgaW50
IG10Nzk5Nl9tY3Vfc2V0X3RoZXJtYWxfdGhyb3R0bGluZyhzdHJ1Y3QgbXQ3OTk2X3BoeSAqcGh5
LCB1OA0KPiBzdGF0ZSk7DQo+ID4gICBpbnQgbXQ3OTk2X21jdV9zZXRfdGhlcm1hbF9wcm90ZWN0
KHN0cnVjdCBtdDc5OTZfcGh5ICpwaHksIGJvb2wNCj4gZW5hYmxlKTsNCj4gPiAraW50IG10Nzk5
Nl9tY3Vfc2V0X3R4cG93ZXJfc2t1KHN0cnVjdCBtdDc5OTZfcGh5ICpwaHkpOw0KPiA+ICAgaW50
IG10Nzk5Nl9tY3VfcmRkX2NtZChzdHJ1Y3QgbXQ3OTk2X2RldiAqZGV2LCBpbnQgY21kLCB1OCBp
bmRleCwNCj4gPiAgICAgICAgICB1OCByeF9zZWwsIHU4IHZhbCk7DQo+ID4gICBpbnQgbXQ3OTk2
X21jdV9yZGRfYmFja2dyb3VuZF9lbmFibGUoc3RydWN0IG10Nzk5Nl9waHkgKnBoeSwNCj4gDQo=


