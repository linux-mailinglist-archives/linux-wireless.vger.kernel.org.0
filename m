Return-Path: <linux-wireless+bounces-22696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07572AAD2CA
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 03:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F095E1BA85DF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CDE13C914;
	Wed,  7 May 2025 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fHPC4/mA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KmEBD+tc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BC156CA;
	Wed,  7 May 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581244; cv=fail; b=cDNJML7PAY/+1o2LAc8kB71Z+XUFdN7SNjoPW16L5oLU2o+asCta9NKmYLJpYgY3UZdx1XUTrHf7q19zTpVK1/LoTrsAG9qSqgGvf7FojLwHXbQ1P2Cki96l8GRDKT9bgCELyD6aZUOkKDkqMqKe3JH8qR63ppNFvi3w9Xk7PCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581244; c=relaxed/simple;
	bh=VNEsCiPYN8vEqAkoie0/USExFbqoWsf0828cS63I8es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ml9GeloOKLdXWAHdnMRm76NpHDgsN4BEnGX810oZ05Kgp0dnTbQ3+yoDiYWt15uEe1s0Va1fdqa/N0HdA8NSOsrlx0g0QDpIcp3tbMbkAXa7MEobvqFXOgVu70uNbStW4rYZRCU2sIS+kjgKq7EyTNq3DafXJPZ+tccPbCWXmw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fHPC4/mA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KmEBD+tc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6570374e2ae211f0813e4fe1310efc19-20250507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VNEsCiPYN8vEqAkoie0/USExFbqoWsf0828cS63I8es=;
	b=fHPC4/mA0IcQJN4LBo0+bib0Hlsfb0JIjTjFPmwxrshcF8cXOLMbf4Pv9OrNsRppF0G+ZgWoiWlDCYX2ciEilbxKo7nbSgrRUyJhFAD+HgGumnQgwaCcS4/KcVMr8cTg1Rnm05r6hgN27jKuL7ZP/EFcYlUW2bwc8yORTmJEP10=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:dcf1013e-6cb9-4fa7-b6b7-28737853c0f2,IP:0,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:2
X-CID-META: VersionHash:0ef645f,CLOUDID:8f490196-efc9-47bf-92a2-b4a9ca59362d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:4|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6570374e2ae211f0813e4fe1310efc19-20250507
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 977810284; Wed, 07 May 2025 09:27:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 7 May 2025 09:27:08 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 7 May 2025 09:27:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8CCe1nk0PyO/00VyK8rikY/AJp076vEq4qGDc47dL4rfBLGny0KNi5TeMt/vm3TdZcjOeDbdA8l1NcGCUXsDvmGxx/N+2KxTYQCrGXp2vK2Vd4dSIhnEGlX06TAAlZQZwqSBV46ERhKUg2vrAR2G0HNPobIBDPhbLTeknuvsOH5JKdPmYwOdHBoUNXEObBpU21U3Bd5xYPWqA3IC/Xr3FjtUjTumutVo/6eXckvsjtPnMYCC/nx5Lpm/y5P1wmE8aE0EjirTJxV8MCd2JF8sVL4Jv4syJAKqtbuxaqaay2dIuJ8cLtovYthrxqCK00BKvwcgiONxI3JGo6RvueB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNEsCiPYN8vEqAkoie0/USExFbqoWsf0828cS63I8es=;
 b=hWqA2RCAw2DnRsWgU8ccjc9bRunsCLEPHH8NACa0fiR9UM7IITekkpiBDUif1oATrqMqsMr5M8NTFaqt5MF20E4Yi9g4ZnqtzUgHMMSBFNTxRm2c6sXZVSjvVKkSwUzAZB144Cjaa4bGFrdISTb2VPGiHdm23AbnibnVPZ0tEaRRQxhLabCNmrNfEueqUxQ/KdLNac9m8xo0/a5DiXc3rOZLds8MwJo+nRPWYfmrkiDYpvNMAf+OzOo1HaLXAmce3LQBmOIh01qeJInslZBdzsI2FzlGDr/Nw/DLz7fqIuExxL96nBuc6/Y5g+t9RsecbNrdp2wQywzMCLTwpAXHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNEsCiPYN8vEqAkoie0/USExFbqoWsf0828cS63I8es=;
 b=KmEBD+tcb+yDLEaoEXK/VwQgj9oqEfZFv0o9oPcZ9eEnfTbb2IDoQiZMDgw9hhpTaIjSu11TiAxd8XwEu0eab1ew/CLZZ2zBTReT8XHNQwJ0r8tMngO8/eU8s744dmxti+9xgNCuAvBPNgwYSGWJPWyEjl5pYkzRpmvTGUSnCVA=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 KU2PPF01B6965E3.apcprd03.prod.outlook.com (2603:1096:d18::404) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Wed, 7 May 2025 01:27:06 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 01:27:06 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "niks@kernel.org"
	<niks@kernel.org>, "fossben@pm.me" <fossben@pm.me>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Topic: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Index: AQHbuW1RnEt/GbhWjUulnPHycX5tgbO7xLGAgAXBBQCAAgoWgIAAwMmAgAIa1wA=
Date: Wed, 7 May 2025 01:27:05 +0000
Message-ID: <d077736aff75bb534e3d6981fd579d8df84fa99d.camel@mediatek.com>
References: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me>
	 <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
	 <5ae1ef34c9844d6d0f5fb167dd596a4c43321367.camel@kernel.org>
	 <28ef2cc608d071d1530902d7b5df045555ab5651.camel@mediatek.com>
	 <0736898d8d53e6249d5be637c9b7e7c81398218a.camel@kernel.org>
In-Reply-To: <0736898d8d53e6249d5be637c9b7e7c81398218a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|KU2PPF01B6965E3:EE_
x-ms-office365-filtering-correlation-id: 59b2d110-1552-49ab-b402-08dd8d064730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmxaSEsxdmt5LzNHQ1kyVVN2cUZPdVFyTlNwUXQ1MWFZVFV1bnFHZDJpTURC?=
 =?utf-8?B?ODIxY3ZJeE9WRHBYTkR5OUZqVnhLMkRFcEdDT1BYeE5Bc2ZScjRiOW9DTlRr?=
 =?utf-8?B?cWhwN2g5T2lRVWZFc1NzYWFMWGhhMHRETFplUEdDL0RyVHY2ZHJUS2tQT1dS?=
 =?utf-8?B?MWhmazhyU0d1QnFZYVpRRDZLR2IyUzNCQ2VaMWtNOU9IVnJ4aUhEMDk0VTBk?=
 =?utf-8?B?MXF4alJKbHRmVWlxWWRqbm0rM25ldUl1T3Z4V1hyOW5Mb21taGNWOVkzR29i?=
 =?utf-8?B?K2hiaWMyTXM3eDBmTGF4SVB0NlBGckZScE0xdVNiQk1FNXNYSnVTWERqdFZw?=
 =?utf-8?B?N1FDNlpCdHBIUTdTdU1VSS9ocGltd0xBYVpSU08zNDBaZnNNSGxWUFpmbkRv?=
 =?utf-8?B?SDZoRW0zUlBOYkxMR1A3cTZPd1ZjVVJrVVBRcXZRYU9LN3MvVW9FVmJid1dN?=
 =?utf-8?B?RVlNZ2h4SU80RVZoLzUrZ2VManF2dXBlM1pkQ3g4bnBGTE5WUTdJVkNNZlBC?=
 =?utf-8?B?RnpOcWJsQjFqMzEzTW9sUEpoeHltZ3VEeGd2SHJBU1NRazVKL1cwQ1I3emow?=
 =?utf-8?B?aGlTTnpTTkNJK21sWG1NTWdZdUVDR2VGWWxGSVZ6cWtvbjVLMUNKMUplelNZ?=
 =?utf-8?B?dzJpVHlxYURKUUNib1ZTWU1WR0huOXNUZGc3SUpEY1d0YUY1U1JrL0FhQU85?=
 =?utf-8?B?dno0cnVVZlZja1FJT010NUpuWGttd0tjWFh5c21IU25wSDRkd201bWpBZzhP?=
 =?utf-8?B?b2Izc2I4MC9Lb1l4SGt3R0JsdHA1ZUZ0L2lvWGgxUDBEYXB4aDFvblUyK2dN?=
 =?utf-8?B?Z0xjOU5FMEtSRVlpZS83VVp5Ni9CbTROcUdiMUVXN1JFQlQ4d0NMa2RmeitB?=
 =?utf-8?B?TnJVb20xUFIwZklEVXdXSmtYbmN4d2UyZVAxdXQ4aGpRMzl2czZMMDZLdVFK?=
 =?utf-8?B?dTBtc2ZtQ20zZDJSOW03d0xOV3E5S0FPOU85Q29MbWFjVStZaG9RTHBacE5i?=
 =?utf-8?B?cDdlN1pLOXB5cFlqeEdwMDBqamtYTnRSaFlZQ3d4QlNnb1RkN0pKZmVUSkFF?=
 =?utf-8?B?dW1OS2JyYjhQam5iOFBBV2E5MjB0aUlSUlJyM0ZHcDZXUVA0YUtiamtRVlBq?=
 =?utf-8?B?TXRlOFp0bzdHN083SlVGcFNGTmpKa2pIQzY2b1hWQlcveTdJQldlSDBYRjZQ?=
 =?utf-8?B?RDFwUFBRMjB2c3VSK2x0eDd6NVQwcmZ1d3lYaFloRlZJeGZhaSs1V0ExOXE0?=
 =?utf-8?B?Sm1UTWMyMlVkMDdHcG4yM25nQll6SGVpMlJQK2JjbGJjWTNEYmU2QUlXbWNw?=
 =?utf-8?B?NG5Fc1VzVEdUa1hVd2xzV1FUM1JFN2l3Ym1LYVJVZzN1OVZSQmp2Wml5ODEv?=
 =?utf-8?B?UkFDZkhIV2lIMm90SDlwd0dBUkVCTzU0L0xBTXFXRXlQNElVeXJ5NDZUN3BK?=
 =?utf-8?B?alRrYVdhb3VrK2NPaHBQcWRwWEh1ZWhTUmc1M1pXYXRnZkN5bUR4bnk4ZVdX?=
 =?utf-8?B?aU4yL3Qzc2NEdjl4QXBnbnJNZHpkTEFJdXZVSHh5ZEpXdFZEUU5oVnFGQkVH?=
 =?utf-8?B?MnFYZElaZnlHSFRCanZncDN1SWNoeVFONVdzb2xJNFdEZi90enZsWTVnZHR6?=
 =?utf-8?B?Zi9hWFp0elZ2Q0RLa3FSSVRPdzBDN1ZMUHY1RVRSd0pNdEh4bnZETWdnL0l3?=
 =?utf-8?B?alBhMVg3QUhZb2NwYzhueTNBZTdYKzN0MEkxL1NFanNJMjhZcy9idDZwOFor?=
 =?utf-8?B?Q1IraCt6ZXhZbVcyekFwc3hXaW9xZWhaRTFwZVdmbGR5L1lSeXZUTzlVRVo2?=
 =?utf-8?B?WlEvYkNGYXBEWEQ2M2U2VlpXdWhzWU1uRW1qVlNWcU83aGhkM3pEVW1iWWwy?=
 =?utf-8?B?SFlJbXVQQ1RBSzZKT3VkMXY4ZmxHcU5yc0k0TG1pUUhBN2YrbG42K2Jadlpk?=
 =?utf-8?B?MVM0bGlLUHJIRHE2VnlMaTVkL3o5T3VSc0V5Q3RzL0YvYnJkUWZ4VlFMUG9X?=
 =?utf-8?Q?heCoAAQeunrtVoLv2wQV1b9gh57/Vs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vnk1ZUg2cWR1eDAyR3E0aDNZMDZRMFJQTzlhRGUyTTR5Tktjb2dCSjFFckxY?=
 =?utf-8?B?KytkcG9NaTNudStFL1Y5OEJoMWNQWGYzRTFEUk9VeUkxZHVNeHd5RnN1QzRz?=
 =?utf-8?B?bHZJbUxRaThVNElaeVNCenNCMFpEK3hxMllaL0ZNMG13aWRlb0lacWZDTnFr?=
 =?utf-8?B?WTNaTjBsWmFqVFlOSjVGSjRJOE1GN3N0MXZaUzJmL3hMdlJKL1RZUkgzVFVs?=
 =?utf-8?B?OUdUZTZaOXFOT0Z1LzlaQ3ArUzFaRHVHMzIxQ1FmMTJYSTFUV3NwUjdlL1Ru?=
 =?utf-8?B?bWtGQTRMQUl2WlJDMU1OdWx6QXQ3eUYwdnpWVzNpcHBjTVgwanNiazFTL1h4?=
 =?utf-8?B?ZFd0WjZwcEsvY1FIUkFFQWE4WFBSNmtYelRoczh4c05xTkc0TUVNY3U1WllV?=
 =?utf-8?B?VWluSnBVQ3I3ZDdJMFhsWVh4VG9pd2doZmhIdG9rMktrMjk1MGYwQmlWK3Jw?=
 =?utf-8?B?cmlmNU4wek1nekJDOFRQNThJL0h4MDFRWDg0M0xieURmUVJNejR5N0tubzl0?=
 =?utf-8?B?UEs4STVZQzY2Z29MckJMUmg1ZEpjUVV2UTFCbTExWnFOR0wxcmhqSDFWMy9F?=
 =?utf-8?B?WGd6Z3NJMWVPeThhWGpSME1TdzZURjJ5Zy8yRExlSUwyREpsYUFKUEd5Y1Yr?=
 =?utf-8?B?dGtVZWFGWU4vcVM1cjcxN1N4MElEYWMzZ25hUW4vQTMxbUcyK0VxdWpsTnh0?=
 =?utf-8?B?Tzczc3VqT3dwN3crZmxZUUN2UTM3eGtQcnR4cHRQVHgvczlNYlA1MjZEbjQ3?=
 =?utf-8?B?M2t5Z3NNVUhwVy9VRGZMMzBDOU13QWtFOHFlSC9id2RZZ0tpNmYwMXNjZG1u?=
 =?utf-8?B?c242TllyOVFKNjNuaUcvRjJxbTNDQ09nOFhTUXZVUXhRSVNZU3A2VVRjWUd1?=
 =?utf-8?B?blNYNU1jZmlEWXUrVTIycGJ4bmxLUjB0THh4K1VCdkxaSGlibWdMeXVkRnJF?=
 =?utf-8?B?V2xWbDdoTHNrSUh1YzhRcEZTaEtLbzV4TURlZUxIa3VSTFVlUzdGN1pYbFdL?=
 =?utf-8?B?L1N2enNjUzljUC9KWHlEWUhML0RISHhHampXZXlweE9PSlBOdElWcFFmZDVo?=
 =?utf-8?B?REZKRmZoTzZzYkVpYjdpckNUOFp2VUU4Qll5OUZLLzBaQXlHVjlEWG1WSlRj?=
 =?utf-8?B?YzljN0tva0FUMzhtWDB3Qlltb3Q0dTR3SkdPZm0yS210elRrS1A1R1E1MW9m?=
 =?utf-8?B?bnNHRFc3aFUyeklVb2crd3haWkFEem9pME9vcHhHMXJpd1RXU280NTllN1I0?=
 =?utf-8?B?ZWY2WkFBMUkrWkpkOE05aUtEbjQrc1VVZWdPamcyMmxGRTZJQ25yekVpaFRW?=
 =?utf-8?B?NUNvV3FnNTVNWDRDOGQrdmFJdFd5b0hlMmlRZXI0YlVLYTdGVmhCSExaNHNM?=
 =?utf-8?B?UFVEaUt5MGRLelpnZTJpc3BUUW9mczRjVGJUSHg5dEx1aU9jZVFSNlhRQkZW?=
 =?utf-8?B?L0wzNVJlN2FTekpNZ1BqTTMwd0kyTW01bzUrTk1tc2M4RDFTQ0F0dTc4Mmdj?=
 =?utf-8?B?bVV1emljVE5aazlXZS9oVFhLdVBuQTgrOTI4cUl5UXFuZ29wS3hBMHE3UXFU?=
 =?utf-8?B?aXdtazBjdGlYM0NiTklnVUgxV0NIMVBEdUkwMXRSK1YzL3JsUjdrM090eXdl?=
 =?utf-8?B?T2pnTy9xUkowSFFFU21qcHZZZVBqdHplQXdPSHdlN1Z5YjE1TlRmaHRIRXdt?=
 =?utf-8?B?SU5keUZJdmsyb1lFTkRnTmJiKzZFY1pwMUwwek5kS0Q2YXFzODltU3c1RUxM?=
 =?utf-8?B?YTlkdFVTaHZoNkYwcE81RUtlcnlGL21rR0pVcXFKUUNabjVoOTdsR0pYd0lO?=
 =?utf-8?B?TWhzNjBHcnUvL3padDFTa0pITUZTOHVhVHBnNXVwa2t3LzZ5eEw2ZUJETlRC?=
 =?utf-8?B?K3lpNUFsRE9sU01XSHR2aXFQYzcza0VPVnZnNXVQdmQ4S25NdHA0bGpBWUNj?=
 =?utf-8?B?K3ZRL2ZDUVBnRWhWNkdLVE5OanN1UDlDcVhpaDJheWJOdWVHTzM0bW1lTGJY?=
 =?utf-8?B?d2ZCc0JVY1A2NU5pYmg0RVNPUUQwekdLc2tIU3J1a1FEcENNVmRJeGo4OGtJ?=
 =?utf-8?B?RmFWOS8xN29ncEUzdVdWd2VMbDNGM2gyR2JrKzhDNzBMSlExTmN2blJJM2hG?=
 =?utf-8?B?OE1Kai85VWNmYnJKUGlzajVlWGxZd0RRL1pRRnRhRDFZeEtsVUJpMHU0TmJF?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75F53E416A3E074D8FEB1496769A29FC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b2d110-1552-49ab-b402-08dd8d064730
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 01:27:05.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WL1VbuG3cJ5zbECw2qye7cX6GJfyDSrYPfKzmVqhAVL1hXQOXzpnBfUqje7YFcbckFNSJuscoSkitNbOWhZl3bdAkchGFf9yEerq+1jNe2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF01B6965E3

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDE5OjE4ICswMjAwLCBOaWtsYXMgU2NobmVsbGUgd3JvdGU6
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIE1vbiwgMjAyNS0wNS0wNSBhdCAwNTo0OCArMDAwMCwg
TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KSB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMjUtMDUtMDQg
YXQgMDA6MzkgKzAyMDAsIE5pa2xhcyBTY2huZWxsZSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gRXh0
ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIFdlZCwgMjAyNS0wNC0zMCBhdCAw
Njo0NyArMDAwMCwgTWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KSB3cm90ZToNCj4gPiA+ID4gT24g
V2VkLCAyMDI1LTA0LTMwIGF0IDAxOjE0ICswMDAwLCBmb3NzYmVuQHBtLm1lwqB3cm90ZToNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3Blbg0KPiA+ID4gPiA+IGF0dGFjaG1lbnRzDQo+ID4gPiA+ID4gdW50aWwNCj4g
PiA+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhlbGxvIGFsbCwNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBBZnRlciB1cGdyYWRpbmcgdG8gNi4xNC4zIG9uIG15IFBDIHdpdGggYSBNVDc5MjUg
Y2hpcCwgSQ0KPiA+ID4gPiA+IG5vdGljZWQNCj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gSSBj
b3VsZCBubyBsb25nZXIgcGluZyAqLmxvY2FsIGFkZHJlc3NlcyBwcm92aWRlZCBieSBBdmFoaS4N
Cj4gPiA+ID4gPiBJbg0KPiA+ID4gPiA+IGFkZGl0aW9uLCBJIGFsc28gbm90aWNlZCB0aGF0IEkg
d2FzIG5vdCBhYmxlIHRvIGdldCBhIERIQ1ANCj4gPiA+ID4gPiBJUHY2DQo+ID4gPiA+ID4gYWRk
cmVzcyBmcm9tIG15IHJvdXRlciwgbm8gbWF0dGVyIGhvdyBtYW55IHRpbWVzIEkgcmVib290ZWQN
Cj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiByb3V0ZXIgb3IgcmVjb25uZWN0ZWQgd2l0aCBOZXR3
b3JrTWFuYWdlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBSZXZlcnRpbmcgdG8gNi4xNC4yIGZp
eGVzIGJvdGggbUROUyBhbmQgSVB2NiBhZGRyZXNzZXMNCj4gPiA+ID4gPiBpbW1lZGlhdGVseS4N
Cj4gPiA+ID4gPiBHb2luZyBiYWNrIHRvIDYuMTQuMyBpbW1lZGlhdGVseSBicmVha3MgbUROUyBh
Z2FpbiwgYnV0IHRoZQ0KPiA+ID4gPiA+IElQdjYNCj4gPiA+ID4gPiBhZGRyZXNzIHdpbGwgc3Rh
eSB0aGVyZSBmb3IgYSB3aGlsZSBiZWZvcmUgZGlzYXBwZWFyaW5nDQo+ID4gPiA+ID4gbGF0ZXIs
DQo+ID4gPiA+ID4gcG9zc2libHkgYmVjYXVzZSB0aGUgREhDUCBsZWFzZSBleHBpcmVkPyBJIGFt
IG5vdCBzdXJlDQo+ID4gPiA+ID4gZXhhY3RseQ0KPiA+ID4gPiA+IHdoZW4NCj4gPiA+ID4gPiBp
dCBzdG9wcyB3b3JraW5nLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkndmUgZG9uZSBhIGtlcm5l
bCBiaXNlY3QgYmV0d2VlbiA2LjE0LjIgYW5kIDYuMTQuMyBhbmQgZm91bmQNCj4gPiA+ID4gPiB0
aGUNCj4gPiA+ID4gPiBvZmZlbmRpbmcgY29tbWl0IHRoYXQgY2F1c2VzIG1ETlMgdG8gZmFpbDoN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBjb21taXQgODAwMDdkM2Y5MmZkMDE4ZDBhMDUyYTcwNjQw
MGU5NzZiMzZlM2M4Nw0KPiA+ID4gPiA+IEF1dGhvcjogTWluZyBZZW4gSHNpZWggPG1pbmd5ZW4u
aHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+IERhdGU6wqDCoCBUdWUgTWFyIDQgMTY6MDg6
NTAgMjAyNSAtMDgwMA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoCB3aWZpOiBtdDc2OiBt
dDc5MjU6IGludGVncmF0ZSAqbWxvX3N0YV9jbWQgYW5kICpzdGFfY21kDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gwqDCoMKgIGNvbW1pdCBjYjEzNTNlZjM0NzM1ZWMxZTVkOWVmYTFmZTk2NmYwNWZm
MWRjMWUxIHVwc3RyZWFtLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoCBJbnRlZ3JhdGUg
Km1sb19zdGFfY21kIGFuZCAqc3RhX2NtZCBmb3IgdGhlIE1MTyBmaXJtd2FyZS4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiDCoMKgwqAgRml4ZXM6IDg2YzA1MWYyYzQxOCAoIndpZmk6IG10NzY6IG10
NzkyNTogZW5hYmxpbmcgTUxPDQo+ID4gPiA+ID4gd2hlbg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4g
PiA+IGZpcm13YXJlIHN1cHBvcnRzIGl0IikNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiDCoGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21jdS5jIHwgNTkgKysrKy0tLQ0K
PiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiAtLS0tDQo+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IEkgZG8gbm90IGtub3cgaWYgdGhpcyBzYW1lIGNvbW1pdCBpcyBhbHNvIGNhdXNpbmcgdGhlIElQ
djYNCj4gPiA+ID4gPiBpc3N1ZXMNCj4gPiA+ID4gPiBhcw0KPiA+ID4gPiA+IHRlc3RpbmcgdGhh
dCByZXF1aXJlcyBxdWl0ZSBhIGJpdCBvZiB0aW1lIHRvIHJlcHJvZHVjZS4gV2hhdA0KPiA+ID4g
PiA+IEkgZG8NCj4gPiA+ID4gPiBrbm93IHdpdGggY2VydGFpbnR5IGFzIG9mIHRoaXMgbW9tZW50
IGlzIHRoYXQgaXQgZGVmaW5pdGVseQ0KPiA+ID4gPiA+IGJyZWFrcyBpbg0KPiA+ID4gPiA+IGtl
cm5lbCA2LjE0LjMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSd2ZSBhdHRhY2hlZCBteSBoYXJk
d2FyZSBpbmZvIGFzIHdlbGwgYXMgZG1lc2cgbG9ncyBmcm9tIHRoZQ0KPiA+ID4gPiA+IGxhc3QN
Cj4gPiA+ID4gPiB3b3JraW5nIGtlcm5lbCBmcm9tIHRoZSBiaXNlY3QgYW5kIDYuMTQuNCB3aGlj
aCBleGhpYml0cyB0aGUNCj4gPiA+ID4gPiBpc3N1ZS4NCj4gPiA+ID4gPiBQbGVhc2UgbGV0IG1l
IGtub3cgaWYgdGhlcmUncyBhbnkgb3RoZXIgaW5mbyB5b3UgbmVlZC4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBUaGFua3MhDQo+ID4gPiA+ID4gQmVuamFtaW4gWGlhbw0KPiA+ID4gPiANCj4gPiA+
ID4gSGksDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MgZm9yIHJlcG9ydGluZyB0aGlzIGlzc3Vl
LCB3ZSB3aWxsIGFpbSBpbnRvIHRoaXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4geW91IHByb3Zp
ZGUgbWUgd2l0aCB5b3VyIHRlc3Rpbmcgc3RlcHM/DQo+ID4gPiA+IA0KPiA+ID4gPiBCZXN0IFJl
Z2FyZHMsDQo+ID4gPiA+IFllbi4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEhpIFlhbiwNCj4g
PiA+IA0KPiA+ID4gSSBzZWUgdGhlIHNhbWUgSVB2NiBpc3N1ZSBvbiBteSBGcmFtZXdvcmsgMTMg
KFJ5emVuIDUgQUkgMzQwKQ0KPiA+ID4gd2l0aCBhbg0KPiA+ID4gbXQ3OTI1ZSBXaUZJIG1vZHVs
ZS4gTXkgc2V0dXAgaXMganVzdCBhIGhvbWUgcm91dGVyIHdpdGggbmF0aXZlDQo+ID4gPiBJUHY2
DQo+ID4gPiBib3RoIGZvciBteSB1cGxpbmsgYW5kIGluIHRoZSBMQU4uIFRoZSBwcm9ibGVtcyB3
aXRoIElQdjYgY2FuDQo+ID4gPiBhbHJlYWR5DQo+ID4gPiBiZSBzZWVuIGp1c3QgaW4gdGhlIExB
TiBmb3IgZXhhbXBsZSBieSBjaGVja2luZyB3aGljaCBJUCB3YXMgdXNlZA0KPiA+ID4gZm9yDQo+
ID4gPiBTU0gsIGluIG15IHNldHVwIGl0IHNob3VsZCBhbHdheXMgYmUgSVB2NiBidXQgZmFsbHMg
YmFjayB0byBJUHY0DQo+ID4gPiBpbg0KPiA+ID4gdGhlDQo+ID4gPiBicm9rZW4gc3RhdGUuDQo+
ID4gPiANCj4gPiA+IEFzIGFub3RoZXIgZGF0YSBwb2ludCwgSSB0cmllZCByZXZlcnRpbmcgY2Ix
MzUzZWYzNDczICgid2lmaToNCj4gPiA+IG10NzY6DQo+ID4gPiBtdDc5MjU6IGludGVncmF0ZSAq
bWxvX3N0YV9jbWQgYW5kICpzdGFfY21kIikgb24gdG9wIG9mIDYuMTUuLQ0KPiA+ID4gcmM0Lg0K
PiA+ID4gVGhpcw0KPiA+ID4gZnVsbHkgcmVzdG9yZXMgSVB2NiBmb3IgbWUuIEFsc28gbm90ZSBJ
J20gcnVubmluZyB0aGlzIHdpdGggdGhlDQo+ID4gPiBtdDc5MjUNCj4gPiA+IGZpcm13YXJlIHZl
cnNpb24gMjAyNTA0MjUwNzMzMzAgZnJvbSBsaW51eC1maXJtd2FyZSdzIG1hc3Rlcg0KPiA+ID4g
YnJhbmNoDQo+ID4gPiBhcw0KPiA+ID4gSSBoYWQgc29tZSBkcm9wcGVkIGNvbm5lY3Rpb25zIHdp
dGggZWFybGllciBmaXJtd2FyZS4NCj4gPiA+IA0KPiA+ID4gU28gaXQgZGVmaW5pdGVseSBsb29r
cyBsaWtlIHRoYXQgY29tbWl0IGFsc28gYnJva2UgSVB2NiBhbmQgbm90DQo+ID4gPiBqdXN0DQo+
ID4gPiBtRE5TLiBOb3RlIHRoYXQgaWYgaWYgSSB1c2UgREhDUHY2IGluc3RlYWQgb2Ygcm91dGVy
DQo+ID4gPiBhZHZlcnRpc2VtZW50cywNCj4gPiA+IG9uDQo+ID4gPiB0aGUgbGF0ZXN0IGZpcm13
YXJlLCBidXQgd2l0aG91dCB0aGUgcmV2ZXJ0LCBJIGdldCBhIGdsb2JhbCBJUHY2DQo+ID4gPiBh
ZGRyZXNzIGFkZGVkIHRvIHRoZSBpbnRlcmZhY2UgYnV0IHRoZW4gbmF0aXZlIElQdjYgYWRkcmVz
c2VzIGFyZQ0KPiA+ID4gc3RpbGwNCj4gPiA+IHVuY3JlYWNoYWJsZS4gV2l0aCB0aGUgb2ZmZW5k
aW5nIHBhdGNoIHJldmVydGVkIG15IFNTSCBzZXNzaW9uIHRvDQo+ID4gPiBhbg0KPiA+ID4gSVB2
NiBvbmx5IGhvc3Qgd29ya3MgZmluZSBhbmQgaXMgc3RhYmxlLiBBbHNvIEknZCBiZSB3aWxsaW5n
IHRvDQo+ID4gPiB0ZXN0DQo+ID4gPiBhDQo+ID4gPiBwcm9wZXIgZml4IGFzIEkgcmVseSBvbiBJ
UHY2IGhlYXZpbHkgZHVlIHRvIGhhdmluZyB0byB1c2UgQ0dOQVQNCj4gPiA+IGZvcg0KPiA+ID4g
SVB2NCBidXQgbm90IGZvciBJUHY2Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4g
PiA+IE5pa2xhcw0KPiA+IA0KPiA+IEhpIEJlbmphbWluICYgTmlrbGFzLA0KPiA+IA0KPiA+IENh
biB5b3UgaGVscCB0byB0cnkgdGhpcyBwYXRjaD8gSSBjYW4gZ2V0IElQdjYgYWRkcmVzcyB0aHJv
dWdoIHRoaXMNCj4gPiBwYXRjaC4NCj4gPiANCj4gPiBJZiBpdCBjYW4gd29yayBhdCB5b3VyIGVu
dmlyb25tZW50IGFzIHdlbGwsIGkgd2lsbCB1cHN0cmVhbSBpdCBhbmQNCj4gPiBhZGQNCj4gPiB0
ZXN0IHRhZyB3aXRoIHlvdS4NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21jdS5jDQo+ID4gaW5kZXggYTQyYjU4NDYzNGFiLi5m
ZDc1NmYwZDE4ZjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkyNS9tY3UuYw0KPiA+IEBAIC0yMTgzLDE0ICsyMTgzLDE0IEBAIG10Nzky
NV9tY3Vfc3RhX2NtZChzdHJ1Y3QgbXQ3Nl9waHkgKnBoeSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG10NzkyNV9tY3Vfc3RhX21sZF90bHYoc2ti
LCBpbmZvLT52aWYsDQo+ID4gaW5mby0NCj4gPiA+IGxpbmtfc3RhLT5zdGEpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXQ3OTI1X21jdV9zdGFf
ZWh0X21sZF90bHYoc2tiLCBpbmZvLT52aWYsDQo+ID4gaW5mby0+bGlua19zdGEtPnN0YSk7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiAtDQo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbXQ3OTI1X21jdV9zdGFfaGRyX3RyYW5zX3Rsdihza2IsIGlu
Zm8tPnZpZiwgaW5mby0NCj4gPiA+IGxpbmtfc3RhKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+
ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKCFpbmZvLT5lbmFibGUpIHsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXQ3OTI1X21jdV9zdGFfcmVtb3ZlX3Rsdihza2IpOw0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdDc2X2Nvbm5hY19tY3VfYWRkX3Rs
dihza2IsIFNUQV9SRUNfTUxEX09GRiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9m
KHN0cnVjdCB0bHYpKTsNCj4gPiArwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbXQ3OTI1X21jdV9zdGFfaGRyX3RyYW5zX3Rsdihza2IsIGlu
Zm8tPnZpZiwgaW5mby0NCj4gPiA+IGxpbmtfc3RhKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+
ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG10NzZfbWN1X3NrYl9zZW5kX21zZyhkZXYs
IHNrYiwgaW5mby0+Y21kLCB0cnVlKTsNCj4gPiANCj4gPiANCj4gPiBUaGFua3N+DQo+ID4gWWVu
Lg0KPiA+IA0KPiANCj4gSGkgWWVuLA0KPiANCj4gQXMgdGhlIHBhdGNoIGRpZG4ndCBhcHBseSwg
SSBlZGl0ZWQgbXQ3OTI1X21jdV9zdGFfY21kKCkgbWFudWFsbHkgb24NCj4gdG9wIG9mIHY2LjE1
LXJjNSBhY2NvcmRpbmcgdG8gdGhlIGRpZmYuIFdpdGggdGhhdCBJUHY2IHdvcmtzIGZpbmUgZm9y
DQo+IG1lLg0KPiANCg0KSGkgTmlrbGFzLA0KDQpUaGFua3MgZm9yIHRlc3RpbmcuDQoNCj4gSWYg
aXQgd2VyZSBtZSwgSSdkIHByb2JhYmx5IHN0cnVjdHVyZSB0aGUgaWYgZGlmZmVyZW50LiBJJ2Qg
bGVhdmUNCj4gdGhlIG10NzkyNV9tY3Vfc3RhX2hkcl90cmFuc190bHYoKSB3aGVyZSBpdCBpcyBi
dXQgaGF2ZSBhbiBpbm5lciBpZg0KPiAoaW5mby0+bGlua19zdGEpIGluc2lkZSBqdXN0IGlmICgh
aW5mby0+ZW5hYmxlKSwgdGhlbiB0aGUgIWluZm8tDQo+ID5lbmFibGUNCj4gY2FzZSBiZWNvbWVz
IGp1c3QgYW4gZWxzZS4gSSdkIG1heWJlIGV2ZW4gcHV0IHRoZSBpZiAoaW5mby0+bGlua19zdGEp
DQo+IGJvZHkgaW4gaXRzIG93biBzdGF0aWMgZnVuY3Rpb24gaWYgdGhhdCBtYWtlcyBzZW5zZSBz
ZW1hbnRpY2FsbHksIGJ1dA0KPiBJDQo+IGRvbid0IGtub3cgZW5vdWdoIChhbnl0aGluZykgYWJv
dXQgdGhlIGRyaXZlciB0byBrbm93LiBBbnl3YXksIHRoYXQncw0KPiBhbGwgYSBtYXR0ZXIgb2Yg
dGFzdGUgYW5kIGFjdHVhbGx5IG1ha2VzIHRoZSBwYXRjaCBxdWl0ZSBhIGJpdA0KPiBsYXJnZXIu
DQo+IA0KDQpJIHdpbGwgY29uc2lkZXIgYWJvdXQgdGhpcyBhcHByb2FjaCBhbmQgdHJ5IHRvIHJl
bGVhc2UgdGhlIHBhdGNoIHdpdGhpbg0KdGhlIG5leHQgZmV3IGRheXMuDQoNCj4gU28gd2hpY2hl
dmVyIHdheSB5b3UgZGVjaWRlIG9uIGZlZWwgZnJlZSB0byBhZGQ6DQo+IA0KPiBUZXN0ZWQtYnk6
IE5pa2xhcyBTY2huZWxsZSA8bmlrc0BrZXJuZWwub3JnPg0KPiANCj4gVGhhbmtzLA0KPiBOaWts
YXMNCg0KDQoNCg0K

