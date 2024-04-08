Return-Path: <linux-wireless+bounces-5967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACB89B778
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 08:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBB6B212FC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830A79E0;
	Mon,  8 Apr 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C2F3oDpa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TO2N65t2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C696FBF
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556489; cv=fail; b=l1av8RyryY1z7xGak1VrlBNtI+mOghGoo2oFAQFxxl49w4PDNsaGRzHRh8bK5BL74YsYKf7VbQBS9QKD5wGRwwquHLCh3V0HogyIFZ9IKNYeBrEow3lQ3krwK7c2m9zWy94lWCGpwH05KXiA8EDPWTO3xTUGH/vP2v+DuB/5vl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556489; c=relaxed/simple;
	bh=9c490QJVG9FZefM64BGfL/p37X7SCJuC8IfP6unmScI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kz3V1STjC/Lr/7dLGEdIOxQzfAvwkCmOgeHlysCCr/JrxsHvCJ7Vxgj34tPYIMEt8qkyqP6WiytLyqnTkN9ZBBT0EQ0FvkNeu4Kv4LpJkgQa6+r1hWyRCxlBeEb3EpYdXbgNzsR9CFzgNJKun3p9xCeKJaxBY4rZwZtHvGzJnhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=C2F3oDpa; dkim=fail (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TO2N65t2 reason="signature verification failed"; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56539ee0f56e11eeb8927bc1f75efef4-20240408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9c490QJVG9FZefM64BGfL/p37X7SCJuC8IfP6unmScI=;
	b=C2F3oDpaNpmPwRGA7nOwTuu7xvDzEGHJxob+a1eisWXCqJKGVFdCSAelLF+BXNIZcbZxBTzjv6E5pWlN1jps5UnZpH+RLEpjxmkVVVGU6UlyRHqJlRF/9Km59AZgq0ju37c2Q471UiHhDK6fnWyFSIFKUHUKyxbzT+82e2okh6k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:75310235-3ccc-4701-b482-71fb3494348a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0cf36782-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 56539ee0f56e11eeb8927bc1f75efef4-20240408
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1916326194; Mon, 08 Apr 2024 14:07:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Apr 2024 14:07:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Apr 2024 14:07:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+5eP6x1LT/ZhSJ5cE3sdh1VIva+yJbCoX+XhQsxRRmkx029tNrHlNGPX4puh7QfnIEiHZn0vGlEpubWk7ElLTBY3UgM2NB5Em9vz6IFgFTA0nwrdI9gNFfQJchUbjHcjmx4hEGI0tXPdOUnUGSR31061TrbphWu2QOLmlBCnD850ZxeAWyP1YexkTwYSUIozlfkrVjivozMDV24nyMbYEgwLdvLoQjQ8CJcx7JS3FqZOfMNcgnyGcpE7ZOEdtKwCiPgGz0Q6Zng+scuqvIr/8pmRm6PyA6BYAA/jILynzLNlCHPLrwBFNE8lG497DGeE96aN6+iwD2g0P5S+A4qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c490QJVG9FZefM64BGfL/p37X7SCJuC8IfP6unmScI=;
 b=CgL7Iwftfmaebd5Op+TM6XqPEzp+fdcY3wkcXouODVnBOgnjc+/hEM6WKGndCVt3tBuJX0K83kIBNKSoSQmz1X1Xz4rty/umTmoa/utVOGwj11BUtovGcphstfMz3ydDdSMtGovtogMD+1mHtS7OYDlvBnks5un0dUiakw8hW6FJSFScDFNrDzmekhdH2SW9gwIxdvKN52o4UQmNiwKrMtLrQZH9mQmNy09yGveBQ1yXYSzZkEkQvbkwJynfAZol0ndnICHqtvD4ljnAu6yL6YQznzlsyFn9A2cXkGH5SkHaI6VSe7Bkr50QkrCC/sKgGNK5y1ZnPmEHW0xBzHyZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c490QJVG9FZefM64BGfL/p37X7SCJuC8IfP6unmScI=;
 b=TO2N65t2zTs2lgDBpo5RvusWS+xcexu7lOvYCbZasDjjwP7vzsQzFAZnV/DZ/3Qo1ItKZW7M/wpjiL7S3afKVRFOrbmKIqSfkKwE0rpl3dsRXlmcihJmXscyw7USRayr3reCDXJdGc/+ZdpW6LqLCJKhhsFrKudLVog8fMq86Xw=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by SI2PR03MB6461.apcprd03.prod.outlook.com (2603:1096:4:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 06:07:48 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::21b8:5774:e736:3a26]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::21b8:5774:e736:3a26%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 06:07:48 +0000
From: shayne.chen@mediatek.com
To: "nbd@nbd.name" <nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	=?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
Subject: Re: [PATCH 09/10] wifi: mt76: mt7996: let upper layer handle MGMT
 frame protection
Thread-Topic: [PATCH 09/10] wifi: mt76: mt7996: let upper layer handle MGMT
 frame protection
Thread-Index: AQHaerc5dWNKPqDQIkOFShIkTmgFGbFWdaEAgAeLFwA=
Date: Mon, 8 Apr 2024 06:07:48 +0000
Message-ID: <24b95b1054909af15a7dee5a478850d5a2aeaf08.camel@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
	 <20240320110918.3488-9-shayne.chen@mediatek.com>
	 <c3758211-1849-454b-88cc-bb91e040c486@nbd.name>
In-Reply-To: <c3758211-1849-454b-88cc-bb91e040c486@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|SI2PR03MB6461:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hnuMxFtU5NSwQZgbsE08xYbsDSQXxKyB4sk9TlTRHRcyv0PaYToOYdTcYwRQ7HYoB+nBwL8Ob+9wEA38FR8/04k6YmQMUPqmCmPs7HXq/B7974qfq3ywit1ecqg7K7lIwb0eUAXdQdBQmP2i7SYepRF1J0puOvclphDTXliyIIhWXGWShlOPhHmupUttgp8JfNqKMP2EK+PmPV88ckKz+73hF+FBSEmBd+2xCTKoqdSA9fTGdlY2+/BV0rM13Gs9Cb5Y0+qQtspc8QZMpOy7UD02k72GfmI/PIlwZ3iTTdB7x4Q7Nr10iw1Sw7Zl7xZxdlXxGbg6k8LkHg5MtU4nX1uOFI2ZBLnq32OTbq5Kfps50SiNq3djRaStPYRKN4z2O5wJ/XemTkMevPSSIMy4kXyGwrYlR9T6pe25RpMp8EfV8AzljBfLonJbmmk1HBVly5gb/1O0Cxq1zywg+8P8e4ULFC3ctqOq1l1Ybp/7Bj1MyktFDpGDOZDj07cohUw5seyH584dMV0eyDCJcMEYDtEHoPrCS6KS3utB6juUlq5SVhKPg2D56cT1IVtoDYn47huQvrj27oDa8ylKpPcqw9RAseFyYFCJYAd64+Z7kMd7FxWnA36XkzXIre2lYa4JFwpTbjCpD/xZcj8pztzI8lhP6wrVWq/dTuZTptz8Uw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3VMdUcrRkJwUVZMQ2tLNFlQSmNRMDdrYnA2TjlXK01qT2cyN0hXK1FiT2V0?=
 =?utf-8?B?NnY1d1BNTkUwUXBVZjNuN05xalovWUxtNFpkNGZpcEFzeWRYTzQvcHZuS1ha?=
 =?utf-8?B?Sm9aWGlYbVVBVWthdTQ3ZkdZUW1ONTIyS0NRaDZkYlhzSFl5NmVYZmd4dmxG?=
 =?utf-8?B?bThXQURpcXZ5SGlseXFOZmhYc2pXbkZsUXdvY2E0WWF0V0dYVTFOdWZjbkN0?=
 =?utf-8?B?aTZWNFRvZ0RhT3ZOTkF3cG5IQTRHaER4ckRUN3dvZWtyVEZZbkc0amUzbzlR?=
 =?utf-8?B?RE1ZdUd4a3JJajBWSFNqa0tML2xQREU4Zmd0NVdvN1hvajJiN21QTGxleVd0?=
 =?utf-8?B?c21wNFJ4OVR4Tkc0TXl2c2FkeXhTQWthMTdENUZkRUNVZThNSW5zUEtiZXU5?=
 =?utf-8?B?a2JSWGpMaGF0TEp6cVFRWFY2RVp5WTAyTS9NcWk0NzNHc2lDNlpCc1Vta1dk?=
 =?utf-8?B?WmlLUUdQRFV3L2cxUkhWcEVTUGFUeGkvK1pEbzc3eUJrTUZia2JIbmdMc2g1?=
 =?utf-8?B?NTVBRGMxcEQ5RHFZV09PRmNIZTV6QzRGMFZFRkhDZ0YvQ0ZaL0JmQVRKaU51?=
 =?utf-8?B?M3p1WUNjaHFWRTFYM0VzaHFrZXRJSDhpK1ZsRHBtdE5wTHlubVZGdGpna2J4?=
 =?utf-8?B?emR0ZmlCNXZteVZCMUk5Qlo4UGhYQVFGWGs0S2xTRVBOc29RaFBqWGphTUcz?=
 =?utf-8?B?aUlIY3JSbGR4OGlUc1lhcTQzRGJOTGloVlRUSDJHNUtPeURhWEpTN3ZJUkVX?=
 =?utf-8?B?ZWZWUWRqdUY1SkdkakVjRVBYNmRMRFBvT0hkV1BqRzVpc3RONExNaWZtZG93?=
 =?utf-8?B?RU50bXAwQTBJMlFnaXArNHdsZTl3dVoyM0VEZ2xzMnFFUEpZN3FFbXF1NnRy?=
 =?utf-8?B?am0xeGJvTUYxU3lSZm5qRGs0NFoxOStyQTFBWVB1aVgrNGJYcmtIdkVtMVht?=
 =?utf-8?B?UHBxcDkvR3FQakg1VDg3RmFLdXNVa3h6Z1FYeHNmbUR2SERRbUhBcklmeXcr?=
 =?utf-8?B?NTBKaG16bThxN2MwRURvOXFJMmVzajI3WXFlQ05KNEE3NExTY1ZQZ2NqOFRS?=
 =?utf-8?B?VzVrdkVFU3VSTGZlbVFpQnl0NE5HYUtTRHlDOThicUZVQStZd3QzMnhTbkZP?=
 =?utf-8?B?S3BhM296cytPMUg1UlRZZHYxTHY0N2RDYW0zeVowWDBGNUxIZUVidWltWVVW?=
 =?utf-8?B?RjI5eGpJdFl2d0dtWXIrREM0OU1RM0x0TXBpWGNjNUowSmlleS9CTFN4aFho?=
 =?utf-8?B?cWh5RFhPd243VXNTRDE0NHpBODFRL2tnSUppM1pIQTNGUEp3NWxpQUdkMEFu?=
 =?utf-8?B?ZGdLVWJYakpXV1RVRkZLYlQ4bFVZaTdJNStBeFE3RWxteEZ3bUI2MXNNMkVt?=
 =?utf-8?B?dU5BZUVDVDl1VkV4dXNTaGcvM3VkR2lMeCs2RjJ0U0kxWTBObEU0cGhueDN3?=
 =?utf-8?B?emw2VGZ4UmV3K25oczBoSVpGSjJncWNtbWJ6TXNiMWMySGFDUGVXNGQyOU1G?=
 =?utf-8?B?QnNVRmtwUXFzUUg3dUp4bnlUWFc1NExsS2pONXlNOXRjS2Zwem1iLysrUDRk?=
 =?utf-8?B?Wkk2UnpiT0R3T3k0enR5YkM2U2UyTVJpcXpQaWZMelVRVXJOU1lmZGJyWXNx?=
 =?utf-8?B?UEt5ZndZL2lvSkRuKzVyUTZRMWNReUUzMXQ0NnhqcmtSYnh4cmh0QzBLQ3hC?=
 =?utf-8?B?OXZNTFo1SjRKV01ISXVzS0FRMEpkeWxHb0U4Y0s3Uk1HcnNXQ0xNMUJDaS9N?=
 =?utf-8?B?VE1xNTlCQ1pBNEdGZDM1UW5zWGFtdWhJV0plM2RHYWRFVHY1VXI5dlI3N0s3?=
 =?utf-8?B?QXJOMmtBZnFrWFpDR3hCWlR4cUltcDk3aUVLNXp5UFRKRnBmSjVLaXQ1M0FX?=
 =?utf-8?B?RDlDd2FBQTl5cktOUEhGR1NldXFBTDNvbjVVSDNlVzhoWVlVOVpRNmVXYWJE?=
 =?utf-8?B?dk0waFJSUnVLVjZSUVpFYUhMVUZ4WHJoa3hzSHNSNUw3Q3B2Y3Fkcm9ZTGlt?=
 =?utf-8?B?djF0TkhFVGViWTZFc3NDVndZdWRTU2pyb1FLM0IwZW5ub2YzV1dEU3RuSVk0?=
 =?utf-8?B?c0FQQlFXTi9xYU1hUERxN1pobm95QWtKUk1HTVhLT3Z1cDdUWUQyWlJUK21N?=
 =?utf-8?B?YjArRFhKZ0hMMmVNRzFaSi9ZUU1DS1pOcnZLUVZySWJpTzM3ektNZGJwUVI4?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <711A41C6709AB142AAE7334D55B6E3A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5b833a-a7e4-4eba-3959-08dc5792371b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:07:48.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir3empUzpSODGFAuT3Yv4lf46V55M3vod+MnU/DXCzgHfuC/LgpyHtDYEfsCSpr7LpMR27d+xbHu6NGbO1gGhv+S+vJYVT06Uup42HsZ4hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6461
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.416300-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCmNvKIW9g24omlaAItiONP2OJZyIAulM0wKCOvtvTK0ZfPK
	DFqvAnG5vW4oU3XnAkAG2ORx9Eyaph9pkVp8w2GHRfDQgu+j+5SlayzmQ9QV0tSDwx9xpYpY3uf
	kyVLUl7cjtTXMl1Dj7R3+ZK4zL1D2PLG+A0qvEpp4CIKY/Hg3AwWulRtvvYxTWRN8STJpl3PoLR
	4+zsDTtEU1sg5GpXeU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.416300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 
	35838CC4C80CCD20359AE7A18A0CE8D62B5FE54319F17638E5C77EADB52A772B2000:8
X-MTK: N

T24gV2VkLCAyMDI0LTA0LTAzIGF0IDEyOjU2ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIDIwLjAzLjI0IDEyOjA5LCBTaGF5bmUgQ2hlbiB3cm90ZToNCj4g
PiBGcm9tOiBNaWNoYWVsLUNZIExlZSA8bWljaGFlbC1jeS5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IFRoZSBmaXJtd2FyZSBzdXBwb3J0IGZvciBtYW5hZ2VtZW50IGZyYW1lIHByb3RlY3Rp
b24gaGFzDQo+IGxpbWl0YXRpb25zOg0KPiA+IC0gZG8gbm90IHN1cHBvcnQgY2lwaGVyIEJJUC1H
TUFDLTEyOCBhbmQgQklQLUdNQUMtMjU2DQo+ID4gLSBzdXBwb3J0IGNpcGhlciBCSVAtQ01BQy0x
MjggYW5kIEJJUC1DTUFDLTI1NiwgZXhjZXB0IGFjdGlvbiBmcmFtZQ0KPiB3aXRoDQo+ID4gICAg
YWN0aW9uIHR5cGUgJ25vdCByb2J1c3QnLg0KPiA+IA0KPiA+IFRoZXJlZm9yZSwgdG8gc2ltcGxp
ZnkgdGhlIGxvZ2ljLCBkbyBub3Qgc2V0IHRoZSBJR1RLIHRvIGZpcm13YXJlDQo+IGFuZA0KPiA+
IGxldCB0aGUgZW5jcnlwdGlvbiBvZiBtYW5hZ2VtZW50IGZyYW1lcyBiZSBoYW5kbGVkIGJ5IHVw
cGVyIGxheWVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwtQ1kgTGVlIDxtaWNo
YWVsLWN5LmxlZUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4g
PHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21haW4uYyB8IDggKysrKy0tLS0NCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21h
aW4uYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21haW4u
Yw0KPiA+IGluZGV4IDMzOGZmMTBiMTIxZC4uNGFiNGQyYmNiZWRjIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21haW4uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21haW4uYw0KPiA+
IEBAIC0zNTIsMTAgKzM1Miw2IEBAIHN0YXRpYyBpbnQgbXQ3OTk2X3NldF9rZXkoc3RydWN0IGll
ZWU4MDIxMV9odw0KPiAqaHcsIGVudW0gc2V0X2tleV9jbWQgY21kLA0KPiA+ICAgDQo+ID4gICAv
KiBmYWxsIGJhY2sgdG8gc3cgZW5jcnlwdGlvbiBmb3IgdW5zdXBwb3J0ZWQgY2lwaGVycyAqLw0K
PiA+ICAgc3dpdGNoIChrZXktPmNpcGhlcikgew0KPiA+IC1jYXNlIFdMQU5fQ0lQSEVSX1NVSVRF
X0FFU19DTUFDOg0KPiA+IC13Y2lkX2tleWlkeCA9ICZ3Y2lkLT5od19rZXlfaWR4MjsNCj4gDQo+
IERpZCB5b3UgaW50ZW5kIHRvIGRyb3AgdGhlIHdjaWRfa2V5aWR4IGxpbmU/IElmIHNvLCBJIGRv
bid0IHNlZQ0KPiBhbnl0aGluZyANCj4gcmVsYXRlZCB0byB0aGF0IGluIHRoZSBwYXRjaCBkZXNj
cmlwdGlvbi4NCj4gDQpIaSBGZWxpeCwNCg0KSSBtaXNzZWQgdGhhdCBsaW5lLCB3aWxsIHNlbmQg
djIgdG8gZml4IGl0Lg0KDQpUaGFua3MsDQpTaGF5bmUNCj4gLSBGZWxpeA0K


