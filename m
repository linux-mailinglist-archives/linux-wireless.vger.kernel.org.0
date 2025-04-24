Return-Path: <linux-wireless+bounces-21967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD67A9AB64
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182707A8629
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BA1F418D;
	Thu, 24 Apr 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="az14droN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="snkOy+wB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C651C5D55;
	Thu, 24 Apr 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492812; cv=fail; b=nEwQ0qnmun5cOfD0TnHxiaylRixMQqazNyVqh16bCi38Gx87cwmRvQSkrT4NHuEZGKHPQ2jjhNXOVA62urIxL8n7QFik6+gBFIakgu7ocp6EICnRIoMepyvd2QVrWMLlCilHq/fQ6bsPFecPluNLIaoXaQB9fbrtORInoPMsQCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492812; c=relaxed/simple;
	bh=rujbR+OobdBNYnI+AzzxG91Hhhp/8vZeXVFjBYLSpsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZYz1PsBZMYawT5qenrMbF0fIaTko16mtraeUL0eSe/ktYCSr/Kb9QEU7x3SV6qpeb8WgCCczfmm9ybFDUOtDPn53ODMTWMaN0IKKaeQ6ZzhbmQIG+FbIfMsUIq1vY5M+7Pho0BXYFgdcPhnVEdh//eNxUhDuz7ZXPBcEnkyOYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=az14droN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=snkOy+wB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 32292c6e20fc11f0980a8d1746092496-20250424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rujbR+OobdBNYnI+AzzxG91Hhhp/8vZeXVFjBYLSpsI=;
	b=az14droNxIrF6Uvr1+KUSqkxyys+FVoVi8LsLaQAaSfKBTmD0PS7Lv4l7CJhnXAAT6L3Ev7N5xghGo2q7AWbjDQQ+X0tbZNr90c/onlXzsXbASS0TneMlIuILFCN2EL7qIWf631mnjFMiKsAQR1xJ8sqKGU+64PK8eDmnHiub1k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ecb92c86-d1ec-41a4-88e8-e2b9400a4f47,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:28530007-829c-41bc-b3dd-83387f72f90e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 32292c6e20fc11f0980a8d1746092496-20250424
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 260476540; Thu, 24 Apr 2025 19:06:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Apr 2025 19:06:38 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Apr 2025 19:06:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o83Xh9CX0C/ZLZwFGLAlZm4nH/84UdFY36D3DQFOW9u8Hb5gh9H5t51Osq5nV/YdBFOMFdkOTyFgokbB+inuUUKC29piINGIZ0jrTyKRK0D0rwImblKT4DUQw/LpsnUR+/GfSk4yRkq3vcavJq7YvuO5NhWgUD17eFSFdHinzmArUolQoa5cX9ykxjQkd6B0ssaLUzMtheKuUxKIK7EhlKtrl1hmF5COPK/kdjsDAmkeDSmgRkuh0uNV/5fDQ1wUwWmjxQZ0XCVqY+wQVXQR5PPVfK4ocfbEBPvjlKqo2BpNGnqQsjq6xABlnxj1O5Qx/rf63YHxYokXNDTgqVoYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rujbR+OobdBNYnI+AzzxG91Hhhp/8vZeXVFjBYLSpsI=;
 b=rJ+UjCLg1k2U2s0ItDt9mknfb4qTMxi3zO/2zN+lljAJPB62jEZdhgeDEJb27a6PciSO8WN6SRyIoTUeTSVLkDeUGnqFe30OH7z2Fds4lpC94aYdOKYrkh+fniDBujATc/qfEijWPP0ey3Z8yckXVIGRK22D/6SRMzkouOPjQ3+OdQwgZei5Oh2vRdRjgyxcb1Mo1liRfzYq/BkUzeC6RFpBxwkcEV91ZyQNFJQTI/Zl3KJWjdphfV22FdHXiy8Ysh3gf2d6WiVUTZwkhzFBCiQRJxtAQdExWqoZybfpGm/5CArB0SmuNJ+MgFduOQ5yhSikJCVFqszswqcIGYpi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rujbR+OobdBNYnI+AzzxG91Hhhp/8vZeXVFjBYLSpsI=;
 b=snkOy+wByOBEUTrBPWSSFiOPgHcWFWTiv4M0gipi80xN7IKNXBrYEnh9aFjT7yjA0a0XkYhzthQTslcM1gYrdJm75I2pNVEzKgTqYjmWsQfQSEyyo1/ZN6BPpkSbNKfWtEesy5x0VgADN8V2TK5pUcOjnFA0lWqziuTNd9jOU8E=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEZPR03MB7754.apcprd03.prod.outlook.com (2603:1096:101:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 11:06:34 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 11:06:33 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"masterprenium@gmail.com" <masterprenium@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	=?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: FW: Wireless speed regression issue with >6.12.12/6.13.x +
 firmware update for mediatek MT7925
Thread-Topic: FW: Wireless speed regression issue with >6.12.12/6.13.x +
 firmware update for mediatek MT7925
Thread-Index: AQHblqQadGui0SAXfUel1Gkp/pMv6rN2hWjwgAARTwCAPEAEAIAADdqA
Date: Thu, 24 Apr 2025 11:06:33 +0000
Message-ID: <6cebf6265f5f981dd951851d0832633292a60a46.camel@mediatek.com>
References: <CACr2tqu10_mXiXw-Q3VSqYBJhQU1s_m77_uhvjpe0j3H3jhbgA@mail.gmail.com>
	 <TYZPR03MB61644B8F34946A73E2C16E27F4DF2@TYZPR03MB6164.apcprd03.prod.outlook.com>
	 <5a07aea2090532682c8cd4df3ab1b9026f2e1cd5.camel@mediatek.com>
	 <04dca014-881c-46b4-a084-2001c62b466e@gmail.com>
In-Reply-To: <04dca014-881c-46b4-a084-2001c62b466e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEZPR03MB7754:EE_
x-ms-office365-filtering-correlation-id: 07130fb7-9c10-437c-3597-08dd832012c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUd1emhGTTdqdk0zWVBlbnZ6eTJiTWxQYTI1REJpeDFBM2IyMUhSM01PaDMy?=
 =?utf-8?B?ZnR0NFRTQzQwQXh1M2RiQTVmMzZaN2FxMldpUytOcnYxaGFsdVMycFN5V3Bi?=
 =?utf-8?B?SU93RFdKZ094SXlJK0NkRmFnUWd5ZElLSFp1QXFpM2lSNWdOWEwxZjRTMjd4?=
 =?utf-8?B?RDVneUdzdmV4NzRmN1hGVzlrRkl5Z0RiU1l6bTdyYVg2TzZJRVg0eFlzSkt2?=
 =?utf-8?B?Qi8wNVhXdVBxSXJLaVJUb1QxTXNsZ2xRbEVleHNoY0Z4S3k4M25DT3lFL1E4?=
 =?utf-8?B?ZndDOGs5UEkxRWJEN1hkK0xUTTMzb284cTdpSkdOcDMzSVo3UXFMSVU1L1Iz?=
 =?utf-8?B?eGxUMTlrczM3Y05DcEhuV05VenZrNG9KS3U3QUd5aEg3WExDc3VMMFJDWlVT?=
 =?utf-8?B?TzdFQi91ZzV4MDQ3cGZvVGlSZStwcEFSV3JicWxXS0p6eVFzeEF4UGZMcVFy?=
 =?utf-8?B?cnBKN2VyY2JINEtybmF2cjBGN2pmRjJlejROdk16eUgwQ0I0djlZYmtEaVZr?=
 =?utf-8?B?a1plbXNlRG04THhkQUd1cDZZOVpHa0cyUU5FNTBHSzFOWmlaQXJScnVJYmgr?=
 =?utf-8?B?TFFlQmtUMVRRcVV5Tm1JbTZXQVVvVGJvWnlSd25ab1E0QUtsaHhLTnd1ZFdy?=
 =?utf-8?B?NjB3TVVyRHU2eStmR0VmR1NkSEhwaTFwOTdWVzBWU3FRbnBrTW1CNlRiWGdM?=
 =?utf-8?B?U0x4ZDk3Z09yc2JMQ0VhY1F4UzAvRmd1MWR4NzBUNXZwZUpSWnZxNDhHSXZi?=
 =?utf-8?B?VHJSV1FWelJNRUdqdWN1bHlxVjBTSi9KWCtpTllpTUhpamlsb3g5d2JJZlhU?=
 =?utf-8?B?SFQrNDNYZExnWGUvalRWQkZEVmRQbnF3ejVQZlpQU25PQ0JneXE5blRRZzV5?=
 =?utf-8?B?YWNtZG5UNy9zdFVKc2lVYzhtaW5jckJpMC8veWhrWTJyZlVxc05rMms4bjNL?=
 =?utf-8?B?NkdPOUNMS0tpVm52U2c0V0hxVExrVEZuYTJwa0tiaGl0enZ5NWtUL1UzemtK?=
 =?utf-8?B?NGNVTTJBOTFyZldncmlqN3B3dDFDWERuZHJGaWlHSjhFeWR1ZEpoR2hKR0xN?=
 =?utf-8?B?MG4vbVkxcytYcHpIVWZEemtYVW1pc1dxbnEvNUdFQXBoZGZ4L1I3MXR5MGpC?=
 =?utf-8?B?OHpxank1NWRNcytUbFRDSFVpRytEWlRnYUNBRzJsMm5ISDh2TnREdThKYVVn?=
 =?utf-8?B?aDZwWTJML1VJemJBdUwycjhJUERXQTBGOW1aQzlOdEhna1pWSjA3eW5Rc1J2?=
 =?utf-8?B?UlJvZjltelhnS2VTQlJBYVFHanlYaERxc3NPOUhzMHkvZ1ZqWXBTZmFzWFQw?=
 =?utf-8?B?OHBIM2FZRHppVkNyYjh4REVyVm5uR3VzbnUzdGExMUh2d242aXhzb3pUMGNY?=
 =?utf-8?B?ekFRK28zbmpnek1FN2M4MUpZWDFBcm5pMFZVQmk0NUFZL2NzYmxSUTh2YlNT?=
 =?utf-8?B?dWhFU0xwczdMM2hERVVTQ3ZpK1hOMzBWcWJWcmw0Yjh5RXYyUlhQZ2xKYXA3?=
 =?utf-8?B?TzcyRGl0VG9NOXJYdEUyaUFpNEc2R2kyU2VhWkpwNFZCY1hLNXUwSms4ejE1?=
 =?utf-8?B?MjZnK084YUNtYVIwSlJhOWhoczFCd2RibHVrMERJQWFJZjl5RTdOTXlNSzVZ?=
 =?utf-8?B?dzZWNzNhSEszTzkxbGpTSkR2dEVwcW9OVmpIY1lDOEhmZFBYL01Id3ZlQ3ha?=
 =?utf-8?B?cEF1amdyY3Z1NWtHanc3bm9EYW1WTkVxbUNGS3AzWXo1S1NQK016MndIYUhz?=
 =?utf-8?B?QWxqREhBcm1qUEUwL0t1MWlpZUc1T2IyamZHMzBkZVBsL3JrSVZVZkFneEUy?=
 =?utf-8?B?YUs2eUZoZW1uektzUE5CdzNrK0xJVnl2Z0h2MHU4bTdhOHhqdEdZS0FnZFNS?=
 =?utf-8?B?SEdrVFU2QTU0Q0ZwbjZiWHNvY01XanowUURWVzFkQnFaSHVhWjBjalh3N3d3?=
 =?utf-8?B?R2NIZXZodE1STDRHREM3ejJoSE9pQU5BZmNOUmZvbWtlMWh5MllBelZ4Umlh?=
 =?utf-8?B?em1IUWVMNkZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejluWExwQUxuUGkydHpocThmVkFkT3VEYmZnZU9mWFFHM2FhK3Z0M1JBZzA0?=
 =?utf-8?B?SU0ySys1NDFKb2I2TmpJSXZ2cEhvNjJyV08xUEJHK09QTjFqeVJVM1dYQVQ2?=
 =?utf-8?B?a0VpcG5yVFg5azlQbUVyM3dtTC9XN0kvcFJPS3N1aGhrVzlWbk9EWEtmZkpU?=
 =?utf-8?B?U2NZQ21yelZyMHFESE90SkNDa3RrTE8xN2Jia1M2UVg3cnFzV2VsM3hIejRv?=
 =?utf-8?B?OEI2V3JHeElUK3diVzY3RzJlMVJJL0Z0THBnU1VUNGFpNkZndGJ1c052QjJs?=
 =?utf-8?B?L0srUEVGNmtyL1NWY29qeFl2bS9UbGtkclNqS0RJa3pNVVZvRTRkUVFLNGtR?=
 =?utf-8?B?REJ1WGVBWk9xbFNINlFTUldoTWVOaFBra3NiVytvQWdvR0ptUm5oUnBiVzhV?=
 =?utf-8?B?c1pCZ3JyQ1Y3Z1RURWwzUXZ6dk5jbDBnNDVCcDBXaXlWenY0QTQ0eGo4TC9k?=
 =?utf-8?B?VGVsQTZ2T3haSEhTZkpHTXdUeHZNK0JYWVdudDBGMG5EU3pOOEd4RFJtR2tS?=
 =?utf-8?B?L3lCNVRsV1MxQ052U3M1VkJxMmFjWUx1dTZ6MW1CWGkrK3YxZVZvUXZtdUc5?=
 =?utf-8?B?NXhYWTlMQ29IN0krdExZd2FJZzR6b3FhOUpBdkJpSFpXU1FRbGZBUXV1RzVh?=
 =?utf-8?B?R0RCY0NZUXpWRDZLSkhPaTBPY0pJWVdUL2tvRWxsVDBTQzhxVkRPck1GRGtX?=
 =?utf-8?B?dkdyT3hqL2NPc1cyOXR1eElzNG5HaVVSTENSUFQyRi9XaUIvZzVrcEVITDhx?=
 =?utf-8?B?djR1UWRCSjY4T3o4UjdLMFl6QU0rNklEeU5rSjBGcE1udmRSU2QrTERqa2VG?=
 =?utf-8?B?ZU1kd0JnRFczbmxmWDR3TFl0enpCek1LeFpuQk92UVp3aDAwZGNTNmVwRmpJ?=
 =?utf-8?B?elJjR2M4MWl5bnkvKzIwN05vZ3AwdHE2MlBlR1g0NzhmVmpQUHlvT2NBN1h0?=
 =?utf-8?B?cmFOdlcwYlpEOUt1TXZzNlA5ZE5sUkF3VXNMVFJGbUFTL3NqMmpJaU5CSmlY?=
 =?utf-8?B?UStrOU53REZXUUtTb1RMeDdOa1h2NDVUREtxMHNNd21QZVhvdzFFNXpsVzh3?=
 =?utf-8?B?a3ljQ0hxQVp4S0ZTTTFWWmxEanVXaUJnT0pwcTlPRU5NMk9hNW5rejRQTTda?=
 =?utf-8?B?TXlaSS9GcExzM1pCekZTMVBIQ0dxMGpVWFhRc1dOaWRiUG1iTWRKekpyZG55?=
 =?utf-8?B?RDh4SE5tUDFjdS9XTVRnYTFLUjZBNGswQW1EUkQ5UGRSVTJTSnFRS29KV1F0?=
 =?utf-8?B?dEp4RHduRnhkSXREWWxIeWgrMmVkVzFYQkh1OVlySThmcERHMVp3OEUyZXQy?=
 =?utf-8?B?czRQMU1RWDU1ZHpoZzl2cmM3Y2c0UmFMS2l1RkVlZHhXR1hqeG9ta24ydjFQ?=
 =?utf-8?B?ek1GejV3bnZKVjNoOHloT2swaXhVYkxPbS9RbnRycElkNEZhSlNKUHVmZE5M?=
 =?utf-8?B?VUdlUEN4a3RFSDJuOEo0M2JMakthSzJiaHRINDNWTXRwVHYzSit0VFZlenAx?=
 =?utf-8?B?UXpGZFc3OXdTaU5VdVdRd2VVZzdXeWs1NmdZL1Bzd3czbGF5SnZHSFdCdFpo?=
 =?utf-8?B?UnMwTCt6U1gwLzRTeFNLU0Z5dXZzRHRrV3BQNHo5REo5V0NaUFNUY25DVXpv?=
 =?utf-8?B?T0R4TWgwclQ4bjRVRFpkR2NwMmw2cklaSHRyL2hNU2NoaFh5S2RtZHV6a0x0?=
 =?utf-8?B?cDZLRXZZeFZIK2VUNjBLZlV3WS8reVk0bEgxUCs4bklXRE5oS1JDZG02TThx?=
 =?utf-8?B?VDVxZWROVDlvZFNOWXpSMWs3ODV4N0F2NnN0Q2dDNFFoUWQyVzVtY3ZYbnZL?=
 =?utf-8?B?Q2svemNROTVCdWhLUlhZRWFRMGtuZjBHd1pmZTVWaTZqMitYcmI1RHlIVU1G?=
 =?utf-8?B?OEVBUDMxd2tyc3ZTZ2UzTS9ZUERGMXlrWFh6bzZhNzBLcVE1V3lWNTE1NzEv?=
 =?utf-8?B?bnZkYXpRK3oxMUlBRkM5MERhelkzZU5aNksyQm5WSW1nbE5xcjZ5OTg2VFNj?=
 =?utf-8?B?ZnpEQlVYa3hNWGNmMk82a1FYN0dQbldjb21WeUVJc1kvUkVjZU94Zy9sQ1JB?=
 =?utf-8?B?N2NZN0Z5RXFidEFwdlNJUkY1Wkl0V3FLRGVzb013eU5QVUIwOWZFOU5TV29F?=
 =?utf-8?B?ekJYVEZwUHVleWVvT0N0V0FqZWdLQjB1K3JpZkx5amFqZ2JHRkNjNEZrcEpr?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A61CE0FBE7ABA440AD57F5ECBC730445@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07130fb7-9c10-437c-3597-08dd832012c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 11:06:33.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAXrq6OiLD1GHFi4l1QMczl3vB71ZkUPYz+YsIOwYOgdYc1LtnHhJpm+DxgTq7KMUxL943GZCMNgSTN+b4QBNQ630bgjpMJGiKBWkdyVzG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7754

T24gVGh1LCAyMDI1LTA0LTI0IGF0IDEyOjE2ICswMjAwLCBKZWFuLUZyYW7Dp29pcyBJbmdlbGFl
cmUgd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IEhlbGxvIGd1eXMsDQo+IA0KPiBJJ3ZlIGp1
c3QgdGVzdGVkIDYuMTQuMyBrZXJuZWwgd2hpY2ggc2VlbXMgdG8gaW5jbHVkZSB0aGUgcGF0Y2hl
ZA0KPiBkcml2ZXIuIElzc3VlIGlzIHN0aWxsIHByZXNlbnQsIGluIFdpLUZJIDYuDQo+IA0KPiBI
ZXJlIGFyZSBzb21lIG1vcmUgdGVzdGluZ3MgOg0KPiANCj4gNi4xNC4zICsgZmlybXdhcmUtMjAy
NDEyeCBzcGVlZCBpcyBOT1QgY29ycmVjdCBpbiBkb3dubG9hZCBidXQNCj4gY29ycmVjdA0KPiBp
biB1cGxvYWQgKDIwTWJwcy83NTBNYnBzKQ0KPiA2LjE0LjMgKyBmaXJtd2FyZS0yMDI1MDR4IHNw
ZWVkIGlzIE5PVCBjb3JyZWN0IGluIGRvd25sb2FkIGFuZCBpbg0KPiB1cGxvYWQNCj4gKDwxME1i
cHMvPDEwTWJwcykgOTglIG9mIHRpbWUNCj4gNi4xNC4zICsgZmlybXdhcmUtMjAyNTA0eCBzcGVl
ZCBpcyBtb3JlIG9yIGxlc3MgY29ycmVjdCBpbiBkb3dubG9hZA0KPiBhbmQNCj4gaW4gTk9UIGNv
cnJlY3QgdXBsb2FkICg0MDBNYnBzLzwxME1icHMpIDIlIG9mIHRpbWUNCj4gDQo+IFdpdGggb2xk
ZXIgZmlybXdhcmUsIHNwZWVkIHJlc3VsdHMgYXJlIGludmVydGVkIGFzIGluIDYuMTIuMTIga2Vy
bmVsDQo+IChETA0KPiAvIFVQKSwgd2l0aCBuZXdlciBmaXJtd2FyZSwgdXBsb2FkIG5ldmVyIHdv
cmsgY29ycmVjdGx5Lg0KPiANCj4gUGxlYXNlIG5vdGUgdGhlIHNwZWVkIGlzIG1vbm8tdGhyZWFk
L21vbm8tc3RyZWFtIChleCA6IGlwZXJmIC1QIDEpLA0KPiB3aGlsZSBydW5uaW5nIG11bHRpcGxl
IHNpbXVsdGFuZW91cyBjb25uZWN0aW9ucywgdGhlIERMIHNwZWVkIHdpdGgNCj4gbmV3ZXINCj4g
ZmlybXdhcmUgc2VlbXMgcXVpdGUgT0suIFdoaWxlIEknbSBub3QgaGF2aW5nIGFueSBpc3N1ZSBp
biA8PTYuMTIuMTINCj4gd2l0aCBtb25vIHN0cmVhbS4NCj4gUmVtYXJrcyByZWdhcmRpbmcgdXBs
b2FkIHNwZWVkIGRvZXNuJ3QgY2hhbmdlLg0KPiANCj4gQW55IGlkZWEgPw0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiANCg0KSXQncyBhIGJpdCBzdHJhbmdlLCB0aGUgbGF0ZXN0IGZpcm13YXJlIHNo
b3VsZCBiZSAyMDI1MDMwNSwgdGhlcmUNCnNob3VsZG4ndCBiZSAyMDI1MDQuIE1heSBJIGFzayB3
aGVyZSB5b3VyIGZpcm13YXJlIGNhbWUgZnJvbT8NCg0KQW5kIHdoaWNoIEFQIGFyZSB5b3UgdXNp
bmc/IEkgd2lsbCB0ZXN0IHRoZXJlIGNvbWJpbmF0aW9ucyBhcyB3ZWxsLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpZZW4uDQo=

