Return-Path: <linux-wireless+bounces-3755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA45859CB5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 08:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF01C20B82
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943820DC3;
	Mon, 19 Feb 2024 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YEThkYcW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Nn6+ICrF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12420DC1
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327174; cv=fail; b=R9vkaXnI8pmR5isQOb20FHIdEzNvdKG4TGj/vnnWO8xzE8HU2XjUWoGl1a828FomtNB1gXL4hHx0p8yG6NVDYG7A0UlFXhgPMt7J3KivXByBQ2rwXZzc7UtG5mqY6TcI+e8zcBmZ0KYsoelEYwdmuTOmhIA5YyyMmBnw0yBnTfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327174; c=relaxed/simple;
	bh=PHnXDjQvQgY9V8GCYhGq7XnWb0luO+ewdm5bGz0qNOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjq1U11gX5M3rMLHFzBtCugiDM2dsIBE6eHuovdjs0cM9tlWqvGRLhhDbhCsV/AHhZvgpkoWqOLsaARDKA+WR+xYzY9ucs8X7GVtphXmRUOFo8pQK3ZxYYF43qsxFAnQC+G9Rn0RSUAYYn1SrDfppTvlveEoNycjc9DVjn7Q1jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YEThkYcW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Nn6+ICrF; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 32cad814cef711eea2298b7352fd921d-20240219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PHnXDjQvQgY9V8GCYhGq7XnWb0luO+ewdm5bGz0qNOs=;
	b=YEThkYcWxg6te7Y39CMjp6hso5IoG2yqH/FcJ9J17W9fgawOJ85nzy58/mMkVv+34VmAlEkWqEtujJDGF9V9RTh3HM/bBlYmgJTxMdsjIhxRUQYaL05vX6yruJR+38JbvZMNRaK9Vvk3ASf3IrtKrQ96cvf3VjHCD1elWXJj6rs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:87fe1fda-11da-49db-b12b-cef6ed56e217,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e271f1fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 32cad814cef711eea2298b7352fd921d-20240219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 972217084; Mon, 19 Feb 2024 15:19:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Feb 2024 15:19:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Feb 2024 15:19:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHvllXoE3LKeAnNhtl1A4vm6Ku6KJmNC6zHSYUBVjn7ewHlGLdv50AF3ObOPLwYTl3NtsVLRvUcDcYHePG+zhKi+gPPY4G6r7dbgbE4jjiIinQ9MTjy8YCOASDHssubH3JGJhVqurUkCm7VWBTQrcnTmjhRJ/X2pj+etKiwvlPYOd2+ihesr11UtwW2jo0FIelFbq6wMBbQ0IiloLkOR0ThPZY+1T+LtsS0cM6yYDfqYGQ00PvExnacdlUiY26K2Ig5jqVXKaDuEvm/AsEEGDXUzdxj2dZ3EUXOSM0yTEl5aS0cXO43SY4U7wI6tnDfUGBfCMijAXosl12o24dG39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHnXDjQvQgY9V8GCYhGq7XnWb0luO+ewdm5bGz0qNOs=;
 b=h+fK1T78gwAhtQMzoMT3tD3URzWJjPgrhFvT8cSt6EyhB2GDeIyABoRPo20zEiTAciUSI0MuCfe8QnfzIUTkxTdEkUg9J/Xka+SAjRuESkCI/BMCmQnQpW1dsjWbeV5++FOGIxPgaCNhdgo22ieyryCbu9l7C9nVVPPLEot4t2GMg9IXSOBl6gHhqvPSpxT0IPkCsFDFHNjG0AlROeGS2fe9nXr67kcV3xjvDgGcnI3dpN3B4fkgB64e7e6psP9tPDcgraWIGLjYP3mkx+yRdwB+CQ9omNHOV4VzItaB1WDDJ/uz4IL5QacJ81kz82MYuEii5iXtLE5M9+KEWvudRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHnXDjQvQgY9V8GCYhGq7XnWb0luO+ewdm5bGz0qNOs=;
 b=Nn6+ICrFi9wplHbPCVqeZKLTqN7IzbNojZqTLJbxjpUohd6x57NrVNKgHgD4ihPBifmMVUZ3kjpPlBhlzk2tB7fTP/LoQMh0Low5xxSCGT0VgVEzBTQRqBg+nKY7fjX86Tewi4vCzQVcdHh4MYxXM2SL4VYtPHvwpfpeidW+zkI=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by OSQPR03MB8435.apcprd03.prod.outlook.com (2603:1096:604:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 07:19:15 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::da97:d05:3eb2:bdf]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::da97:d05:3eb2:bdf%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 07:19:15 +0000
From: =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"nbd@nbd.name" <nbd@nbd.name>, =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?=
	<Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	=?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= <Money.Wang@mediatek.com>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
Thread-Topic: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
Thread-Index: AQHaNHOIabKmvUadb0SHw+79jt7SV7EAvocAgBDgcwA=
Date: Mon, 19 Feb 2024 07:19:15 +0000
Message-ID: <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
	 <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
In-Reply-To: <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|OSQPR03MB8435:EE_
x-ms-office365-filtering-correlation-id: 06fe47f1-f596-45e3-c7f3-08dc311b1432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSDb5yo9tLIvwPy0JW+bgGNvCI19M8rYGBw4gB3TKLJxV3nA0T7tkeQvv+13nDD7PtgyoTXSOf7clNFq+Rw+cRo5D5J2c2K2HcOmr40Go190uG6iCg6YzA0deTb3Fzvb7SMwa4M+vJfTsgZXDaaqaRHTVshr7Bx7zZudh5ik2Kg0agJhvmDeAKm+t9zblCZ6I5SePoKR+fYn3dtMyqo2pQ8iEM7OtZ5VKnS6f2q5OjJL6Bnnv1e3Ft7B+N19OPvBtoxikPMykG4TB3uA2X91sUjWXcsN6TCDjmHA6uc5FleaznfbeVV7Aoh1xKQ7zu6pUQbG55s4Z39qGz3WUHBlY0jbzVFwnnCoEq5Iy+hmCJjke+YIDGmrNypQD0kDj1/YbJ5mLXItwCyHw0kr3aCE6XdrCdLqjG6V0MsKZSVzMIcTl/VjpdDAxIzYVgGHICrXUkHswVY3v4P6gvPtbksC3SamU706ZzGGSn5VioD3g2iXdY5epxfDqBbARlufTWMmC/eDWElR8OpaBPUIN3uzejNdh2kI2UtMJeryGtWPxtNeIGJ8huvEyqzL8sUL9skZ/ZkYn3b48BHQkFcQcRCEt9pWC1NPVY/USPqd1DlinMwB8Hyg/eUm+aPi93qkHyUi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(2906002)(41300700001)(38070700009)(36756003)(2616005)(85182001)(26005)(107886003)(478600001)(6512007)(6506007)(6486002)(38100700002)(83380400001)(122000001)(8936002)(66946007)(86362001)(76116006)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(110136005)(71200400001)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZLcy9DbFAvOWg2MFYvaFdOeU9hSGxNSVRmM05kMWphS1grUnoyVmFKcEt6?=
 =?utf-8?B?emlkc2pmNzR0dDFuSXp2cCtYVHlzREMrVXpDR2wrQVBxZm1kd1JZMW9HTHNQ?=
 =?utf-8?B?WUVKY0I2VEliUlI1L1hwakVBei9aNkJBbnAwVTYxd1Ywd2NxcW5GM1pETmFJ?=
 =?utf-8?B?ZDJWV3hwK0hiSFpNZTFGaFpybmFJZEx4d29iSmNZYnB2aHI4L1g0OXVvcUpT?=
 =?utf-8?B?c2VIRHIyV2U4cWQvNUlJTWdyb1lnMVhJQ0ErK2k2TTJnT0dpd2lGL3NHMXdE?=
 =?utf-8?B?aWExSkg0bVBoRlJyZ29GSzNrT0txQWNUakx4OEMzZ3dyaGhrZFBuTWZieXlM?=
 =?utf-8?B?bzhGMC9KS2tOKzJ2NGI0TVRlZWFRVE45WWc2eGlxTDVqa0hISEZIVEVHa1U3?=
 =?utf-8?B?c0w3WXlBNUFrTjlMS1JVRW55TGtWOXFzbmhHd1B2dG1leE13WWpLMzFkN1NK?=
 =?utf-8?B?MXRVSGU4REdWM2xZZGRpVHBsQzNSdzgyWG9GRlFtQ0xEMlpRNElKOWdmWHdq?=
 =?utf-8?B?QmpiWkdFSHBNT2JDc0tNSHlVSFRvK1ZZV0dxazBZeWlKVVVPaWNpNDBQeitr?=
 =?utf-8?B?Z2RTd1VCVEhkM1FoNnJYbEFOdlNXMXpRK2pWYU1JRmRrczBwMTg0dGdtS09D?=
 =?utf-8?B?UnpGbzJ6clIwbnh6b1EyVGNRTFdTZUR5N24xRTZmWDdoeUs3K3l6TzkxOGxX?=
 =?utf-8?B?R2hCRW9EaXA4NUJ0Q245UmJEYmJ2MzZHakdIb0swZkVoU3ZIYitCWi9hT05P?=
 =?utf-8?B?VGp4MGdyeURzdGNwRG5rV0VaR01ydWFlbHZ6U1JvOXpONEhNZWc1ZG50dzBV?=
 =?utf-8?B?YVh2Y0RBSzU2cmRVTkVtRjduNE1MMCtGbDV5c1Bqc2pZYWRzc2RoS2VyT05Q?=
 =?utf-8?B?Q0puQXIyUE9YVWxKbXBTdGN0eTBzQWdLTjRpY0g3eCt2VnVQbC9zUkZGRzVK?=
 =?utf-8?B?TVNhNE5zV1R0ekw2cHJVSll2TTRNeEFRR1pud1VncmpvcW9UaXE1R2x6akNY?=
 =?utf-8?B?TzNVNUMzOHB0YXMvaU5ETndoMytNbExLSDJaRitRT0NmTWtRODdVNVNyMHEw?=
 =?utf-8?B?M1FPNVNDemlSdWZBQUJiRXNhRG0wMk9SRzFtQ3k1TTlTUWRqMFkwTUM5VVln?=
 =?utf-8?B?NkUvbFhHTElVYk1GSTVlRitaTmYzOUZEdWpobUYvSEIrN1J2MWhXdnRWaFBR?=
 =?utf-8?B?ejl2ODZhM3NSV01ncVE1bzhxOGF3VkZhKzN1WWlXcytKendneDJRcmZWOWtN?=
 =?utf-8?B?QWMzL2IvVzliM3h1NGl3YnJkWVBqZjZPQTJIemk4U1IyZFhzV0t5bFJ4aFNL?=
 =?utf-8?B?am9OcjZaK1hxV0VTL0VVRzhlVHR3NEluVjhoMk1MUnpjeU00SFRlcXNPUitI?=
 =?utf-8?B?ZS9NeWVzbHMyVnBFYys3NzRjalEvZXJxL0pRbEpHcm0ydGc2a2puM3puUEQ5?=
 =?utf-8?B?NjRkNy9CbUZkU0ZabERXK2d0dTBJNHQ2blRGQS9uczNWNXVQZnczUUtMTDE1?=
 =?utf-8?B?R29RcTNEV1ZlcCtWa2xaMHF0bUh0Mm1vZzB0a1NuUFFyTmMxWCtwS1lKdGdP?=
 =?utf-8?B?dTdJTGRpRk5tcmxlM0xvZHQrQU03eVhPUU9IOWk3YmtDTDFrNFdBYm9wL1pi?=
 =?utf-8?B?WG9HUWFBNjhVMEUveE04TjVoK1dBWkRVTmlhcjU4MUpvTkxVVGxCMzVyS0xr?=
 =?utf-8?B?Z0RvNXYzN0tUcGQ4OEtRV0RUUnVnN1JaSmJubVFra3hXdWpsRzFVbXdYZ21o?=
 =?utf-8?B?SUpmUTB0ZEJpY0NxTlVuc0tEZTF0MXFPTXp4bG9xT2swV3lPNzZmajRuZEFv?=
 =?utf-8?B?cVB0NTQ2NDM4akphRHM2RTFLdzRKTVpmbURGR3pjYlpCZUxrRk82R0pBTWNW?=
 =?utf-8?B?R1N1VEZEYlE4QnVDR3BucGNnKzlEZmUzYzhDNEhoUlpLcGNmcW9ic3NTRjhj?=
 =?utf-8?B?YmFWS3BUR1gxek9JTU1HU2xlZmJvdlBTd2doYmlCSW1IRW1kbTNqdUpXcUdL?=
 =?utf-8?B?bkV6amJYdkRLMXdwVllvdFUrbFVCSEtqaXdLZ2JDeXBNREcva1AvZzlkL0dM?=
 =?utf-8?B?ei9CWlRvaVE1SVNWUHAzbFljaFRUTTRQQlN3Y3h5cmtlVU5ZSmV1RnNXeFhX?=
 =?utf-8?B?dkE0OUpLUk1MODFQSnZMQWdEcWxXdjNhNWZTUUZPTjRNQzhoMUhOQlRraFRH?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85A7E3A4099B734DA9D7EF9DC2E0902B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe47f1-f596-45e3-c7f3-08dc311b1432
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 07:19:15.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gx0IGUNe+StcZaoyGlyI+6liW1dcchbNhmgC5r+9d8OeRh2l3LyQ1iVEBYBfXFn3vbCMZvLEfW6vuSq88jFnVZ+Ft01H0Ua4lPQNtZrcHDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8435

SGkgSm9oYW5uZXMsDQoNClBsZWFzZSBzZWUgdGhlIGlubGluZXMuDQoNCk9uIFRodSwgMjAyNC0w
Mi0wOCBhdCAxNDozNSArMDEwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4gIAkgDQo+IFNvIC4u
LiBJIGZvb2xpc2hseSBhcHBsaWVkIG15IG90aGVyIGNoYW5nZXMgZmlyc3QsIHNvIEkgaGFkIHRv
IHJlYmFzZQ0KPiB0aGlzIC0gcGxlYXNlIGRvIGNoZWNrLg0KPiANCj4gQ291cGxlIG9mIHF1ZXN0
aW9ucy9ub3RlcywgaWYgYW55dGhpbmcgbmVlZHMgY2hhbmdpbmcgcGxlYXNlIHNlbmQNCj4gYW5v
dGhlciBwYXRjaC4NCg0KVGhlIHJlYmFzZSBzZWVtcyBnb29kLiBXZSB3aWxsIGNvbmR1Y3QgYSBm
dWxsIGNoYW5uZWwtc3dpdGNoIHRlc3QsDQppbmNsdWRpbmcgaHdzaW0gdGVzdHMgaW4gaG9zdGFw
LiBJZiB0aGVyZSBhcmUgYW55IHByb2JsZW1zLCB3ZSB3aWxsDQpzZW5kIGFub3RoZXIgcGF0Y2gg
dG8gZml4IHRoZW0uDQoNCj4gDQo+ID4gK2hlLl9vcGVyLmhlX29wZXJfcGFyYW1zID0gY3B1X3Rv
X2xlMzIodTMyX2VuY29kZV9iaXRzKDEsDQo+ID4gK0lFRUU4MDIxMV9IRV9PUEVSQVRJT05fNkdI
Wl9PUF9JTkZPKSk7DQo+IA0KPiAoSSBjaGFuZ2VkIHRoaXMgdG8gbGUzMl9lbmNvZGVfYml0cywg
RldJVykNCj4gDQo+ID4gKy8qIGlmIGRhdGEgaXMgdGhlcmUgdmFsaWRhdGUgdGhlIGJhbmR3aWR0
aCAmIHVzZSBpdCAqLw0KPiA+ICtpZiAobmV3X2NoYW5kZWYuY2hhbikgew0KPiA+ICtpZiAoY29u
bl9mbGFncyAmIElFRUU4MDIxMV9DT05OX0RJU0FCTEVfMzIwTUhaICYmDQo+ID4gKyAgICBuZXdf
Y2hhbmRlZi53aWR0aCA9PSBOTDgwMjExX0NIQU5fV0lEVEhfMzIwKQ0KPiA+ICtpZWVlODAyMTFf
Y2hhbmRlZl9kb3duZ3JhZGUoJm5ld19jaGFuZGVmKTsNCj4gPiAgDQo+ID4gIGlmIChjb25uX2Zs
YWdzICYgSUVFRTgwMjExX0NPTk5fRElTQUJMRV84MFA4ME1IWiAmJg0KPiA+IC0gICAgbmV3X3Zo
dF9jaGFuZGVmLndpZHRoID09IE5MODAyMTFfQ0hBTl9XSURUSF84MFA4MCkNCj4gPiAtaWVlZTgw
MjExX2NoYW5kZWZfZG93bmdyYWRlKCZuZXdfdmh0X2NoYW5kZWYpOw0KPiA+ICsgICAgbmV3X2No
YW5kZWYud2lkdGggPT0gTkw4MDIxMV9DSEFOX1dJRFRIXzgwUDgwKQ0KPiA+ICtpZWVlODAyMTFf
Y2hhbmRlZl9kb3duZ3JhZGUoJm5ld19jaGFuZGVmKTsNCj4gPiArDQo+ID4gIGlmIChjb25uX2Zs
YWdzICYgSUVFRTgwMjExX0NPTk5fRElTQUJMRV8xNjBNSFogJiYNCj4gPiAtICAgIG5ld192aHRf
Y2hhbmRlZi53aWR0aCA9PSBOTDgwMjExX0NIQU5fV0lEVEhfMTYwKQ0KPiA+IC1pZWVlODAyMTFf
Y2hhbmRlZl9kb3duZ3JhZGUoJm5ld192aHRfY2hhbmRlZik7DQo+ID4gLX0NCj4gPiArICAgIG5l
d19jaGFuZGVmLndpZHRoID09IE5MODAyMTFfQ0hBTl9XSURUSF8xNjApDQo+ID4gK2llZWU4MDIx
MV9jaGFuZGVmX2Rvd25ncmFkZSgmbmV3X2NoYW5kZWYpOw0KPiA+ICANCj4gDQo+IA0KPiBTaG91
bGRuJ3QgdGhhdCBoYXZlIChoYWQhKSBhbiA4MCBNSHogaGFuZGxpbmcgY2FzZT8gT3IgbWF5YmUg
YSBsb29wIGENCj4gbGENCj4gdGhlIG9uZSBpbiBpZWVlODAyMTFfY29uZmlnX2J3KCk6DQo+IA0K
PiAgICAgICAgIC8qDQo+ICAgICAgICAgICogRG93bmdyYWRlIHRoZSBuZXcgY2hhbm5lbCBpZiB3
ZSBhc3NvY2lhdGVkIHdpdGggcmVzdHJpY3RlZA0KPiAgICAgICAgICAqIGJhbmR3aWR0aCBjYXBh
YmlsaXRpZXMuIEZvciBleGFtcGxlLCBpZiB3ZSBhc3NvY2lhdGVkIGFzIGENCj4gICAgICAgICAg
KiAyMCBNSHogU1RBIHRvIGEgNDAgTUh6IEFQIChkdWUgdG8gcmVndWxhdG9yeSwgY2FwYWJpbGl0
aWVzDQo+ICAgICAgICAgICogb3IgY29uZmlnIHJlYXNvbnMpIHRoZW4gc3dpdGNoaW5nIHRvIGEg
NDAgTUh6IGNoYW5uZWwgbm93DQo+ICAgICAgICAgICogd29uJ3QgZG8gdXMgYW55IGdvb2QgLS0g
d2UgY291bGRuJ3QgdXNlIGl0IHdpdGggdGhlIEFQLg0KPiAgICAgICAgICAqLw0KPiAgICAgICAg
IHdoaWxlIChsaW5rLT51Lm1nZC5jb25uLmJ3X2xpbWl0IDwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgaWVlZTgwMjExX21pbl9id19saW1pdF9mcm9tX2NoYW5kZWYoJmNoYW5yZXEuDQo+IG9w
ZXIpKQ0KPiAgICAgICAgICAgICAgICAgaWVlZTgwMjExX2NoYW5kZWZfZG93bmdyYWRlKCZjaGFu
cmVxLm9wZXIsIE5VTEwpOw0KPiANCj4gDQo+IEZlZWxzIGxpa2UgdGhpcyBzaG91bGQgYmUgdGhl
IHNhbWUgaGVyZS4NCg0KWWVzLCBhIGxvb3AgdG8gdmFsaWRhdGUgdGhlIG9wZXJhdGluZyBiYW5k
d2lkdGggaXMgbmVjZXNzYXJ5LiBXZSdsbA0Kc2VuZCBhbm90aGVyIHBhdGNoIHRoYXQgbWFrZXMg
dGhpcyBjaGFuZ2UuDQoNCj4gDQo+IEFsc28gbm90ZSBob3cgdGhpcyB1c2VzIGllZWU4MDIxMV9j
aGFuZGVmX2Rvd25ncmFkZSgpIC0gd2UgcmVhbGx5DQo+IG5lZWQNCj4gdG8gdHJhY2sgdGhlICJj
aGFucmVxLm9wZXIiIHZzLiAiY2hhbnJlcS5hcCIgaW4gdGhpcyBjb2RlIGFzIHdlbGwgZm9yDQo+
IHB1bmN0dXJpbmcgLSBjYW4gSSBhc2sgeW91IHRvIHRha2UgYSBicmllZiBsb29rIGF0IHRoYXQ/
IEknbGwgYW55d2F5DQo+IHByb2JhYmx5IGhhdmUgdG8gbG9vayBhdCB0aGF0IHNvb24gdGhvdWdo
Lg0KDQpPZiBjb3Vyc2UuDQpJbiBmYWN0LCB3ZSBoYXZlIHBsYW5zIHRvIHN0dWR5IGFuZCBpbXBs
ZW1lbnQgcHVuY3R1cmluZyBvbiBvdXIgTVQ3Ng0KZHJpdmVyLiBXZSdyZSBjdXJyZW50bHkgd29y
a2luZyBvbiB0aGUgQVAgc2lkZSwgYW5kIHdlIGV4cGVjdCB0byBzdGFydA0KdGhlIFNUQSBzaWRl
IG1heWJlIHRocmVlIG1vbnRocyBsYXRlci4NCg0KPiANCj4gam9oYW5uZXMNCg0KQmVzdCwgDQpN
aWNoYWVsDQo=

