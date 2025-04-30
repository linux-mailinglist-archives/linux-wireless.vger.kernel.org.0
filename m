Return-Path: <linux-wireless+bounces-22232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB9AA4348
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 08:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3665A3A69
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 06:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD041E5201;
	Wed, 30 Apr 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oxoQZq6a";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pixsw/jb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBF1D88D0;
	Wed, 30 Apr 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745995683; cv=fail; b=hEpcv1x0XEsvDd8D/EX5wL3TMpJOWa3nqMn1zcKILr3fUssnvYQme5ewVfvgqzqy23m+Zt1ChhZB5tIbYa9ERYZRgTrWKEWRqB9tT4VLv/YDqHXc2+fO+k3TupzF4Y2xfWQ97d3+9q8JLLpBCThmX7q8v9zLHBsItc3E5R6J0IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745995683; c=relaxed/simple;
	bh=4zeht5ofPnr34beCF4zjBIR8IOq641srUPucmS1Cfm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XCPPcGldxei0DVfSDZRPdkSxbrbiIfMQcqXDszO/46Pd79hsffFiAZVVvn/L/qKVk3we5y0KClSHcO+7rL5BqUW58PM1k0OX7vLtqILU4tLDvd7Q8FJmm/QtOb7mfvZ14iPlh2JA2USjPVrEehg7QSnp8gOyulftCNAl5iIeO7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oxoQZq6a; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pixsw/jb; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 070728c8258f11f082f7f7ac98dee637-20250430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4zeht5ofPnr34beCF4zjBIR8IOq641srUPucmS1Cfm4=;
	b=oxoQZq6a+fb39Fkc+iz+56386KQNj9ek/5ftpGtesAE+z3t+Tfxe6ZeJ7nBqf8DfvWGRCcFcvsLkLlNwAtdk1cmmHQ1A/qNtJwOWH+cvebjeIzp5Q11jH8fZfgZ3kfXn4uMXqZ+psiTH/tgwo7JbKAniMcYidy/yykOUIKDKEnY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4fdd0f54-9e7a-42a8-8982-f9d620812fa1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:bf3e0870-e08c-41ab-89e8-3ba0a33da853,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 070728c8258f11f082f7f7ac98dee637-20250430
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1686786415; Wed, 30 Apr 2025 14:47:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 30 Apr 2025 14:47:46 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 30 Apr 2025 14:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqA00nenMr4AqzmojB+GVFAcjYQfDB8YD52PwQvY9JkV2k6+myIGb1qCeVSMdwnrUwsJyVZbs8MEm5yNhixjCFoaR7vm7p61SjD4xK5HNmeqmRmmoLSd/k49lYjzsFqd3riY3HMriBpswpm0P9NzZ6MDLMh39/VLhm8QXv5m5IDhXfa3KnPm236AkgEC/OthWFHfNmlfr3kPq4MwxlZdNCZPmEq77lyKvRxBYu/aj40cVR6KmRmOyp0uVuC0SqFNWCQp7gomdH9IulotHW2Nu9PbM2XSEFfQbBf0j5nDeIwNkYEPvskSmJ1crCE/7YUjSYpmTYIouJH1DYvG2RGm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zeht5ofPnr34beCF4zjBIR8IOq641srUPucmS1Cfm4=;
 b=u9dX2mk0o+f9aZ384uDMZa9a4YwVZHU8zhjwAUbSNzQjnlUcrYQLkNlsZKNtAOx6+TvU4Wg32GV2/lBgtcjG3cHk7fwHbZLfroJw0WtEZ7oUzCGjNvkSax/cftZe5fMC7wT7BrKOAX9jHo7Mf8TKCh8NxoEll4VbBDyFyriKBj4OuZq8Etc6q9YkWIu4uZAd6CSdDnoUmnHi5qYx0BbYc2AoigBuDJCbTE0zTShEh/LJHBzKG7bb6GqHDPou7+/e+UBa/7s6XLoptvUmPMdyY0QiKO9iUIl9EGQ1hoYkUP/cXIehZdXCTd5a2x+0zFC/xp066zVf3BClhZ/WvuKrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zeht5ofPnr34beCF4zjBIR8IOq641srUPucmS1Cfm4=;
 b=pixsw/jbOm0VVSt82wsPxLtqvgJSJ4qZP5YDJTVtxTRPzyaTsSFKT8uBD+XxTVy0PnfaXnT+3ZQDVMjNokhnt8M9SakTmEgdWuLZULe6OvlEPJWz+in0+b4hvc3eBswz3IDWBmCg5bYVy5jZjRuTXoPwuuhMU908MmM1YZBGrAU=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 KL1PR03MB8413.apcprd03.prod.outlook.com (2603:1096:820:130::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Wed, 30 Apr 2025 06:47:44 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%3]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 06:47:44 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "fossben@pm.me"
	<fossben@pm.me>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Topic: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Index: AQHbuW1RnEt/GbhWjUulnPHycX5tgbO7xLGA
Date: Wed, 30 Apr 2025 06:47:44 +0000
Message-ID: <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
References: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me>
In-Reply-To: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|KL1PR03MB8413:EE_
x-ms-office365-filtering-correlation-id: 6707612f-46f5-494e-0621-08dd87b2e919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bHppeUd6c0xISlZFcG1DTW1CRnNHTFZrSTRyU1M1M3JFRXBFMjd0QUo1VUZM?=
 =?utf-8?B?ZmdFNlppbDBuRDNlY0k3aktHNG5QTVBZb09HdVc1bGh5dzhVajhkNkVBbkZO?=
 =?utf-8?B?b0lSWk9RME5SQ21tVHR6TGtTQmdnOHFKMHVFZTNxd1YwclF4aUJnTEtId2th?=
 =?utf-8?B?a0dxcmNzbU9FV2pqZ2NBVVRPMldOajBZZWd0S0xGNUZIcFJ5NlI4NFRGc2g4?=
 =?utf-8?B?UjRyN2JiVzFEOTczZk93YjY0UlhrOStOSlhmRzJ5d3BsTkx1UHR3Nmxzc3pF?=
 =?utf-8?B?SmRnZ3V5Y0ZDdWdLblk5YlhrMklVTnlkcUQ1R2xXSmxVUzRDYmpSVHFHQlNk?=
 =?utf-8?B?RUNsWEtqczdRRHJDT05FcGJ4QU8yWGFVZjZENUFHVytoemhJejZtSUp4VUZ4?=
 =?utf-8?B?VTdRdFFmMHBOb3ptWWtXY04vRmVEWVBKYjFmVUVoVjkxTHk3WXkzUmdWV2h1?=
 =?utf-8?B?SmtqVWN2TkxaRXlkd2FPMGxKWFJtREVYa1A4aTgyR0xsRkF1UHc0aVVENVJZ?=
 =?utf-8?B?bVArWE01SzEvS2pQNjJlYzBZSkRHSXl0ZU12cWg4TEhXRHNhbWVtb1hnM1pP?=
 =?utf-8?B?SGtXb2gvTjNKQ3VGV3Vla2xBY2gvblNWSDdQVnNsVytpNWVhZDIvMCtaaHN1?=
 =?utf-8?B?MlVQeC9LVXBFWjk4ZlNhbWNRQnVnTjkyK1BkS09IMkMwc0hsdnk2OHRjTEZi?=
 =?utf-8?B?dEh4Wm5kYnlRb0NEZ3lwd09kK2tMN2VCSUVxeWNqOUVmclV4aXhEeDZiZ2dk?=
 =?utf-8?B?Yzc0NllzZ1ViVm9YU1lRU1VxYXF5M2YraVRGVkc2Tzh4MW5jRStlc0l3T1Av?=
 =?utf-8?B?azR5K3ZyV1A5NUlQRmVqTDBkd1oxMG5rdmN0dG9WeEZ6TVFsd1pPcHlQMTZ0?=
 =?utf-8?B?ZHVkYjJzSk1vcGtvN2Y3TFFBKzVLbFBOVnpjUGkrYmR0dW9sMGc4VzVYL0h5?=
 =?utf-8?B?dWZ6UzhOS1N0YTFKZHhTM3BTemd0Q2poT3dNUmVOeVRNUXFGMDRKc2J3ZHNl?=
 =?utf-8?B?YVBkUi9ZeExOSmc5UjVCMGVSYUk1S1QyeXBpK01zZGV5Qmgyc0x6WW4wOE9z?=
 =?utf-8?B?Y0ZWMWhIUW5zaTZmcjBNaWZ5K0tBL2xWZmw2L211ZDE3VjJHVEpVaTdEZzdo?=
 =?utf-8?B?NG5ScFJaRFVnRUYra0dNS05xY3QzZUJtMDFsQm5oRk1SU3RLVElyV296ZTNH?=
 =?utf-8?B?ZHVMd0tDK2FsTGJ1STduM05VL0dmeUdlYXpXdUttb3lCS2tqNmZZV010ejlk?=
 =?utf-8?B?R2F0SElpUnNCb1psQzBVek5KVDBxQXUxUjBiZWs4L1BpeTl3QjRGek1zUTlM?=
 =?utf-8?B?TDVRa3ZJUmtLdit0dkgwTDRocDlPWFRCb1JocUEwaTlOSk13SFg2cUU2aDFn?=
 =?utf-8?B?WjUzWk85Z0xtNkNjQklGTTh4NlQrQ1phVDBFR3B0ckRWMHl0RzBCa3Vnemhi?=
 =?utf-8?B?UWpuVkUvR25WUlJzUGVQclFlUE0vcjhCZW5qRXVkTUFOc1A3ZVpkYXFCSGp3?=
 =?utf-8?B?SkdiRXY3ZW1wUC8zcm1XbFpCS3QrSDdYUzVYb0d0WXFSSUxnMklMMVlXZ0U5?=
 =?utf-8?B?NnN1RUZrTlJJYzN5RUdmMGpZTExTVmMzdGMxRHB3UE94T2lOa3V2N3VlODA1?=
 =?utf-8?B?RmEwQ1pFMDdHQWlSajVla3lqcENPOXpBK0M2eEc1RHpvQUdUNFY0NytCeVFN?=
 =?utf-8?B?QlZFQ2pCRENUMzRBSUg1RExrWDdPZUt5eWQvV0p4M3pqbTBYSFNuVkc3NGVJ?=
 =?utf-8?B?eVA2czhRTXhuWGpXVmw0M2syRzROMVQrSCt3NkJlMCtEOFUrVFUrSmllL29V?=
 =?utf-8?B?clg0YSt2Y2NoKzZiZEhBWjJKRnpyYU1zSi9SdCtMU3dCV2g0cVFBaUpDdmZP?=
 =?utf-8?B?ZUt2R1JtSDlJRWhXV0hXQ1haWjc1TGMvVVNmM1RDOU9sQTNYcEQ0YnZWNjVs?=
 =?utf-8?B?SDZmVHkvcDdKVkpXQ2x1MXNLYWpUOGtJU0tmYmdCZlcrM1pwVWVWcVB5RmFU?=
 =?utf-8?Q?j3l1Qav3At5Oan3GMr2D+cl2MDfE2k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2R5K0VrazF2S2ZNQVhkd0lIVXpqU2pwSUVwSFFIZHoyN0ZGMEFiL0ZQVEdh?=
 =?utf-8?B?YmRSUlZBNytOcDlETnAwdXpwaWZZaHRXRGcyMGYvOGk5Q1AyNkJDYW51UDhV?=
 =?utf-8?B?bW02U1dzQUg4dm5QaGJmeE5iR2hVVmhLdjhJditjQWNnMW8yQVlkTVJqbHVo?=
 =?utf-8?B?R09ORHd4YmhvYlVMVzkvbG5HUERMbGl3cWtsS2VldlVYVjIxTDN2N0U5MVJQ?=
 =?utf-8?B?dFJiWGYyNWJvMmdxNnpFV1JabldPRW9yM3ZpUnQ3eVJpWlA5aUEra2JXTyt0?=
 =?utf-8?B?YkRiQmk3WHlkS0V0V0pmcngvL2lJM2xvZW1Fc3dRLzl2VEtGNWlEdVFkZVFJ?=
 =?utf-8?B?TEJoNzN3bDcyd3NTdFRxMTFzbWt6RXJKTGpNQ0pwVnhjK2VmN1pIMnBHNHJF?=
 =?utf-8?B?Nm8vQk0xQU15Q2tEcDFpa0w4UDZlL3cwWjdvcmoxanNsZUYyRnhvalg3WFFt?=
 =?utf-8?B?enBLNjM3andpeXk3a3hDMWJwVGtxQ2lVdk1Td2k4cnZxYk1XWUg1UWZ0U2ZI?=
 =?utf-8?B?b1JJYU5CclhNWlpKbEFRMm83WTQzajlnbFEzT3dyUzVVTFVJMnlWN3IrcFlo?=
 =?utf-8?B?STlzckczVTFYSjdpWDFVSGNRMklVV1BzRXRZcEFhOWtqYlVWS2lQNy92L0dT?=
 =?utf-8?B?bEZGYjhDS0QySTNzMERmZlhpb0IxaW50YXBWWUR1SEh5dm1LczB0emR0NHFi?=
 =?utf-8?B?Zk9LQmN0REszNE9xL0JNWXh1N1g3QzBGZUFLcDk4Mm5mSERCVmw3YW1wUDRS?=
 =?utf-8?B?OXd3cTRoeUluWWIzN0QrbVJ5dDhsMERBOWk5c0cxVFZvV00vY1Zac2IvS1lH?=
 =?utf-8?B?OWcvYjhOVnhXVkpCUE1PN1YxSm1xUXM3czN2WnA1QUg1TGFPc3ZySFNxOVBZ?=
 =?utf-8?B?QVR1Vzh5V3F0TUd2a2V5QzBKaHY5anBwS1VUT2pDWVRvQW1SOVQzcFppTXpG?=
 =?utf-8?B?MHlrL2xMRDd5clJnT1U4bmc3U3YrZ0V0RU1mbHZBS2tjM3ZTSmNXUGk3NjIw?=
 =?utf-8?B?MUhibVg5YmVMSDkwK3dvUUUxbm1pcEFJRzl5MXYvOGcrZUNtZThhU0lKYm9p?=
 =?utf-8?B?WnRiNlJCRnJzL3VmalJReTRmSy9HR01YalJYN1hnaU51clVuRVMxb3drS1li?=
 =?utf-8?B?bHJpREZ3YlR0aERGUW9nbDU0bjVwTmtML0EwQ2djSWIxeDRKdFlHVC9oa09Q?=
 =?utf-8?B?UHR4akRQdUJQUlkwdjMyalNzbjNmdHJ1VWlQNVpnTUJ4ckxCWDMzb0RYdlRI?=
 =?utf-8?B?dm93eGNVcTB2TWp3eXVqbE8wR2hyTXBPYzBRN0pGN1BZcTJGRTM3TEVlS0dv?=
 =?utf-8?B?eGNJbVZ2M1laRjQrRFpQUXJacEJxaUVyR0thaEtmeDQraDlBLzFMNDNGUDNC?=
 =?utf-8?B?V0x3Y3BoSmM4YndKUTM2b3RIS2ZQdDVManVXMFZMR3crSXI2ekNtczNZZHlI?=
 =?utf-8?B?azdxQ1FJZHdHek1zS2p2aXFFSlB1Ym00Y0l2RnZ6T3hySjhUL1o1azRyNEpF?=
 =?utf-8?B?dGlIRmxxZUlyQVpzVDRRTkw0d2ZFRlZlNkhCeWN0S3NrSlMzOGYydVRsUEo2?=
 =?utf-8?B?RGtZWHUrTlZJL2RIUjFEYTE4OUtNTHlTcEU0eDQ4YVc3TFhHTUFUMGo2NURF?=
 =?utf-8?B?U0FUMlVJYVBaZE5HYlVLNnBQQ1gzeW1rT21lZ09oVTY3Z1dVbkdzYlRIbjJ1?=
 =?utf-8?B?UlhtcG9qa1JMRXRhaXJvQTJvWCtVYktFNlJwYWN6M1gxMWJZcmhrbTl1bWZx?=
 =?utf-8?B?M2grT1BPTWZ3QXhpa1hKOG43SmRVbkFpS0txMG9rdlhqclpFVzRuWlY3cVl1?=
 =?utf-8?B?UW90VnRTeXQ3djFIN29RUUVqQ0Yyc0VsWlRpZTkvTll2ci82c0RKNDhtNnJu?=
 =?utf-8?B?MTZpNVBhSURHQVMzb3NDdXdEYklLSzJBM1ZIYUpVSitXajdLQ1BzUG5zc0ly?=
 =?utf-8?B?Q052aHA4eWtNRnNxOURsd0o3TWRGeGYxQUhMYkh2RzdRRk5CeXQzWTlmS1Er?=
 =?utf-8?B?T2hNQkUyZEJlc3VLMXNISWx3QXJsdlFPT01rMmwrYUNiRStRMGw5N0hZNEg3?=
 =?utf-8?B?QUk3VGpkRy8wMjc0bGJtVmErdGRuMERJVm9wcWdSdzBBaGd1RlJMakxlYmVr?=
 =?utf-8?B?NERyM282UUdUaC9kRVFEVTZVMWt0M2o4WUU2ZFpwWndUU2pLVTZDZWxwRHI1?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9398BB8583289345B80ADE5CCCF29514@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6707612f-46f5-494e-0621-08dd87b2e919
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 06:47:44.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygVi+P0sTWGd7bXsmt6HHHNq/oh+gqL4RfmANZ3Xzs1gmh5C70leWZJABYke+z2Gf7wHrUPT5ZPtOgCup/UdJwnxnbSG8Oe6OjFhiB/1bbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8413

T24gV2VkLCAyMDI1LTA0LTMwIGF0IDAxOjE0ICswMDAwLCBmb3NzYmVuQHBtLm1lIHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBIZWxsbyBhbGwsDQo+IA0KPiBBZnRlciB1cGdyYWRpbmcgdG8g
Ni4xNC4zIG9uIG15IFBDIHdpdGggYSBNVDc5MjUgY2hpcCwgSSBub3RpY2VkIHRoYXQNCj4gSSBj
b3VsZCBubyBsb25nZXIgcGluZyAqLmxvY2FsIGFkZHJlc3NlcyBwcm92aWRlZCBieSBBdmFoaS4g
SW4NCj4gYWRkaXRpb24sIEkgYWxzbyBub3RpY2VkIHRoYXQgSSB3YXMgbm90IGFibGUgdG8gZ2V0
IGEgREhDUCBJUHY2DQo+IGFkZHJlc3MgZnJvbSBteSByb3V0ZXIsIG5vIG1hdHRlciBob3cgbWFu
eSB0aW1lcyBJIHJlYm9vdGVkIHRoZQ0KPiByb3V0ZXIgb3IgcmVjb25uZWN0ZWQgd2l0aCBOZXR3
b3JrTWFuYWdlci4NCj4gDQo+IFJldmVydGluZyB0byA2LjE0LjIgZml4ZXMgYm90aCBtRE5TIGFu
ZCBJUHY2IGFkZHJlc3NlcyBpbW1lZGlhdGVseS4NCj4gR29pbmcgYmFjayB0byA2LjE0LjMgaW1t
ZWRpYXRlbHkgYnJlYWtzIG1ETlMgYWdhaW4sIGJ1dCB0aGUgSVB2Ng0KPiBhZGRyZXNzIHdpbGwg
c3RheSB0aGVyZSBmb3IgYSB3aGlsZSBiZWZvcmUgZGlzYXBwZWFyaW5nIGxhdGVyLA0KPiBwb3Nz
aWJseSBiZWNhdXNlIHRoZSBESENQIGxlYXNlIGV4cGlyZWQ/IEkgYW0gbm90IHN1cmUgZXhhY3Rs
eSB3aGVuDQo+IGl0IHN0b3BzIHdvcmtpbmcuDQo+IA0KPiBJJ3ZlIGRvbmUgYSBrZXJuZWwgYmlz
ZWN0IGJldHdlZW4gNi4xNC4yIGFuZCA2LjE0LjMgYW5kIGZvdW5kIHRoZQ0KPiBvZmZlbmRpbmcg
Y29tbWl0IHRoYXQgY2F1c2VzIG1ETlMgdG8gZmFpbDoNCj4gDQo+IGNvbW1pdCA4MDAwN2QzZjky
ZmQwMThkMGEwNTJhNzA2NDAwZTk3NmIzNmUzYzg3DQo+IEF1dGhvcjogTWluZyBZZW4gSHNpZWgg
PG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiBEYXRlOsKgwqAgVHVlIE1hciA0IDE2OjA4
OjUwIDIwMjUgLTA4MDANCj4gDQo+IMKgwqDCoCB3aWZpOiBtdDc2OiBtdDc5MjU6IGludGVncmF0
ZSAqbWxvX3N0YV9jbWQgYW5kICpzdGFfY21kDQo+IA0KPiDCoMKgwqAgY29tbWl0IGNiMTM1M2Vm
MzQ3MzVlYzFlNWQ5ZWZhMWZlOTY2ZjA1ZmYxZGMxZTEgdXBzdHJlYW0uDQo+IA0KPiDCoMKgwqAg
SW50ZWdyYXRlICptbG9fc3RhX2NtZCBhbmQgKnN0YV9jbWQgZm9yIHRoZSBNTE8gZmlybXdhcmUu
DQo+IA0KPiDCoMKgwqAgRml4ZXM6IDg2YzA1MWYyYzQxOCAoIndpZmk6IG10NzY6IG10NzkyNTog
ZW5hYmxpbmcgTUxPIHdoZW4gdGhlDQo+IGZpcm13YXJlIHN1cHBvcnRzIGl0IikNCj4gDQo+IMKg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMgfCA1OSArKysr
LS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1NSBkZWxldGlvbnMoLSkN
Cj4gDQo+IEkgZG8gbm90IGtub3cgaWYgdGhpcyBzYW1lIGNvbW1pdCBpcyBhbHNvIGNhdXNpbmcg
dGhlIElQdjYgaXNzdWVzIGFzDQo+IHRlc3RpbmcgdGhhdCByZXF1aXJlcyBxdWl0ZSBhIGJpdCBv
ZiB0aW1lIHRvIHJlcHJvZHVjZS4gV2hhdCBJIGRvDQo+IGtub3cgd2l0aCBjZXJ0YWludHkgYXMg
b2YgdGhpcyBtb21lbnQgaXMgdGhhdCBpdCBkZWZpbml0ZWx5IGJyZWFrcyBpbg0KPiBrZXJuZWwg
Ni4xNC4zLg0KPiANCj4gSSd2ZSBhdHRhY2hlZCBteSBoYXJkd2FyZSBpbmZvIGFzIHdlbGwgYXMg
ZG1lc2cgbG9ncyBmcm9tIHRoZSBsYXN0DQo+IHdvcmtpbmcga2VybmVsIGZyb20gdGhlIGJpc2Vj
dCBhbmQgNi4xNC40IHdoaWNoIGV4aGliaXRzIHRoZSBpc3N1ZS4NCj4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIHRoZXJlJ3MgYW55IG90aGVyIGluZm8geW91IG5lZWQuDQo+IA0KPiBUaGFua3MhDQo+
IEJlbmphbWluIFhpYW8NCg0KSGksDQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMgaXNzdWUs
IHdlIHdpbGwgYWltIGludG8gdGhpcy4NCg0KQ2FuIHlvdSBwcm92aWRlIG1lIHdpdGggeW91ciB0
ZXN0aW5nIHN0ZXBzPw0KDQpCZXN0IFJlZ2FyZHMsDQpZZW4uDQoNCg0K

