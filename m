Return-Path: <linux-wireless+bounces-22129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7AA9EE7E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB747ACE2D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718018C31;
	Mon, 28 Apr 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FHejM/KK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="E4fEO32X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264419047A;
	Mon, 28 Apr 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838054; cv=fail; b=kEITp7cJV6OmbTpEZlcXhn+a0+kjVXEaUM7Dy4YLCbYViiyHpQ4pBNKZH/yA2rGmm2FX4sbmSaQiRMY6TleN2DckemzJZ/BucyboS1qixS9PTDIYyBeyGnF8CZEMcfAuT+Alu+Vhsw3uYhc2Bt/l1fZJ82Q3tNRa2dsjC35+MA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838054; c=relaxed/simple;
	bh=tHK9xwlilRj9AHy/rvT8PP5esf2jDH9Z0u6OTFm4Wv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JRR784dmkv9gGCTvRIgeUgjVQkELSg4FZ12g6Bf8xGWx0Ep7H2Zcovoy3eRkpdKIAf3E8zabhTwQ/tFuFO/wOOV1UlNQQg5IEyg/IXaOsVWAVy5kIArc8KJXmXVZQwb0Sy+uTcfO62ol2lXkaAiqgeQCti7vZWpEc4uI6d7NIMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FHejM/KK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=E4fEO32X; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a95fb38242011f0980a8d1746092496-20250428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tHK9xwlilRj9AHy/rvT8PP5esf2jDH9Z0u6OTFm4Wv8=;
	b=FHejM/KKjY/f1xk0HOZGOUnAwFwvJ6FI43/wL9BIXGSCG/T5Bqk6X6N8tuGv+2mPmyOYFQqSSc/Mbj+jp1sR5ddLCnMmloPgqhnW4QlKElWqj0nV84b8mkFRdb79eXn2mg9G/CIulmYbUxjCbWL9OEm+Vci8evLmdU9NvOc3Lt4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6284f26b-1f97-4c5f-98c5-ee1ad5d7df9e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:5e962107-829c-41bc-b3dd-83387f72f90e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a95fb38242011f0980a8d1746092496-20250428
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1677531569; Mon, 28 Apr 2025 19:00:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 28 Apr 2025 19:00:47 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 28 Apr 2025 19:00:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llHHEO9wotQ2xBxlS9IYOzzYYKN6divPne+KnbXp5Ejlu9Ls4gbxn1X5KBcj/h6LWXrYGZPi3KbZXaxw8YYw33/LwYHaW/Y5DyabYuBCLu08kpV9fJh8TRyAvesZb+YPUbvltDeXJnGkPu7r2h1v4zzTl8Sw7VLIJpDlbdPmscSHsbgYKhqphrTpy103xxDRc1eO5jHXUsA/MIfX/5ZBu8D+hmFlqfvG8Q3OV8Dotzx9KsD0QDTWNq77yIHplQ54MKYx2QGqoqOg2GVUUSoQq2PRNsvS+ye6r3YSF+eyRHQuVZ4eZMVxsB2SX4EzIcDuQEFIlDnqGyYXBgpTBrZVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHK9xwlilRj9AHy/rvT8PP5esf2jDH9Z0u6OTFm4Wv8=;
 b=a0ug1hhzk+eJsksEjoENBJ1YpQDTMkRM+Ss9yJJ/66ZPEvY2sjMdrkYa4XIqqBFJMfwg8eWmGs7vQrZplPAdr84sgOHb6PGHqnhscDT1YwXbNai7eNjgykzZFMHaalKIW2zYCtlO/zPGxJxrDRlLRZvWNqsOhEJ1nIdyHHKuSnAt6nz9TXGx1saoklhapRzX1GJsNW7IQU/+j+LTqUkl5x52KnhrbLTmqY8xBGETp9uz3TVZwVBPcy1+v4075GJOU1nO9uPJwAXy8uHX61OPII/jTdpr6Ix4KFOW5hlKW3NB3yUVYC84pxh1s31LSypdlQQljcu1hj4gQuWo80UATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHK9xwlilRj9AHy/rvT8PP5esf2jDH9Z0u6OTFm4Wv8=;
 b=E4fEO32Xj+reT8a8A8ZwKRnZp/YYqvsq5wKa5P6YiHsOwn70Uelpo20K5yLh2pR7sDKWk2Ve9/yQhIHJcFBnKPauTGbTcPg9IKCgZ7LBWLhAQsLxi4meaHVvj/Um5UFdqvr6YurhBW1gWdKbR0jyYMP+3Y2eXyVEd4pqq/WO4Mk=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TY0PR03MB6775.apcprd03.prod.outlook.com (2603:1096:400:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 11:00:43 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 11:00:43 +0000
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
Thread-Index: AQHblqQadGui0SAXfUel1Gkp/pMv6rN2hWjwgAARTwCAPEAEAIAADdqAgAAEAgCABkOxAA==
Date: Mon, 28 Apr 2025 11:00:43 +0000
Message-ID: <bc09e1613e1dd31489d1d2290a67da987481f03d.camel@mediatek.com>
References: <CACr2tqu10_mXiXw-Q3VSqYBJhQU1s_m77_uhvjpe0j3H3jhbgA@mail.gmail.com>
	 <TYZPR03MB61644B8F34946A73E2C16E27F4DF2@TYZPR03MB6164.apcprd03.prod.outlook.com>
	 <5a07aea2090532682c8cd4df3ab1b9026f2e1cd5.camel@mediatek.com>
	 <04dca014-881c-46b4-a084-2001c62b466e@gmail.com>
	 <6cebf6265f5f981dd951851d0832633292a60a46.camel@mediatek.com>
	 <28ff58dc-72f3-4b71-817c-ccb4ff5f777d@gmail.com>
In-Reply-To: <28ff58dc-72f3-4b71-817c-ccb4ff5f777d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TY0PR03MB6775:EE_
x-ms-office365-filtering-correlation-id: b41e1b84-85d5-45e9-eb03-08dd8643ebbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?czIvQXUrRTVzT2xjVzdibW42LzdkYStWVFY5YzRNL01tNmlxN3A0UDI5c2M2?=
 =?utf-8?B?Qm1SbUMzVzNIM3lKRmlQcmY4WW1sd2ZoeG40RUJLNmh6RTMwbS9oaDhUVTJx?=
 =?utf-8?B?TTlLNzJRMzVVdjNjMVIyZnJsTUJEbmQyNmp5R0l2V3ZqOFdsTjc4bHNrSmhr?=
 =?utf-8?B?ZldDMVRqckhGeHh5aURlU3ZSYUd6SVpZRjltUVBzNDd0Q1NpRHdCQ1BZQXNY?=
 =?utf-8?B?TkpoSVQzUE9jUHNIbGN6VDNLRlZLajV4bHVOdzYwTmEyL1RhSWY2TzdLQWlw?=
 =?utf-8?B?VkthUXNaZUt2WE5ocG82S1lnMFQ4aEI4dlNWUWsrUEpPMWVDaldha1lvSFZq?=
 =?utf-8?B?TlRWd2VTN3JIYm9TMWhsS01RTVh6dzgvUys3QkNWS2t4K05FTFp3ZnRHem03?=
 =?utf-8?B?Z2d4ZmFMQktxUlJVakczeWZGMzUvMU1qQ2VLTjlvdFRQYnVWMTg5dTFIdk9w?=
 =?utf-8?B?bUtUeEFyZzErNzA1V1B6VThadWtWdHViK0dlMzg5d1pxbU9qZUdKVDhWb1Y5?=
 =?utf-8?B?bGlSYnQ3ZnVUKzdOcEtTUTVRcWU5SFh5THMrVkFJU0FPejRIYzZQN2RSVGxN?=
 =?utf-8?B?WncrK2tVejBRR2Vab2w4ZnlSUGN5N0F6MUFYRkFacmt0WVZnQnVNNUIzVFJu?=
 =?utf-8?B?b24wTURGdE1jRmR1K2hUbVZRaWxNYm9sNFdkbEM4NjBIdDkvSmJHaU9tVXF0?=
 =?utf-8?B?ZzRMbVphRy9BMFlJVDNSb2dwRldkT3QrTUU1Q0ptdjNzVVYySEwxK1crQ0lt?=
 =?utf-8?B?WUlNY016cjJsVU4zZDVxRFZad0RrN3VXVTN2M0xnMlZhYlZoVHJPOWYyK2RI?=
 =?utf-8?B?amtVK3l0U1BxdjArU0NoRVRXYi9RdkF3b2FMbGNudmxIa1ZLYVFhcW8wVGlR?=
 =?utf-8?B?WHFTR2hmVXBJd2ZTeHl4M2JyS2JndmVzaHJHVUlmNVN0UHNObjdDVnBJdFVh?=
 =?utf-8?B?emFqM3cwTFYwNU10bVpsQnJWK3FzQ3NVMSt3SGVsNGVBeCtxK3g0WExiN3dS?=
 =?utf-8?B?WWV0MW0yb21MNjlwWS92bjZlZkJQYkZMSXlpbTBvbHBWSmtNSEdHRjRNZ3dX?=
 =?utf-8?B?aUR5VjZVYzJrOUc2aXlkeTZHZ0E0azBnSjJTOXdkckxhMGttTkRpYVYyUGFY?=
 =?utf-8?B?UEhha2daZzczMG10dlFNVmtrZ1pYY1hkYW14MkQrVW5wdDNrVE9pdmgvUWJY?=
 =?utf-8?B?c2RWQTBCKzAxZjVteEErdDZnMDVYdFVudUVLSWpuSmlCMGdEUTJsbHRZODFC?=
 =?utf-8?B?LzArWVZkYTlob1RkZHVoSFJ6ZmJjb2ErdFNzVUFpL3BNK1RMWi9Fc2NxVEpT?=
 =?utf-8?B?aG1sVVF2VGhWK096WHkrZUpGa21GSEprdUgzNFA4eVVKNEkzWkZpUjQ3Ukcx?=
 =?utf-8?B?cVBtZy9OWHRlYWNnbmkwbU9vd29IeVkrYXljdHdqczN2NWplcTQ5cmYzVnRP?=
 =?utf-8?B?VzU4Y0FHbU9wSGVhaHd3bEtOYXR6YWxLbFRhN0llcDVHQThJOHBCbzJGQ2tD?=
 =?utf-8?B?U1REdDdpNXltRGhtTG5LRjAvWVN6V1J5eU5HdFVVQ2FTZGVseDluR0U3MTQ3?=
 =?utf-8?B?ZUNralNpNmZxR2hqWlM1Vm9QcmZmTHMrdlZnNmw3WXM2T2ZpRGZrdmd0SkNO?=
 =?utf-8?B?SVV1UlZYaE9kaXFTRFpDalRicFpMOVpTSm1sVG1aWUdxZUQ4bWlrMHRvS0pW?=
 =?utf-8?B?WVJoY1o4T2Vsb1Y0eTZid0xQYnpKMi9qOHNtSGhLVkF3VW9wNWlkMU5EOXpK?=
 =?utf-8?B?UXV4MWtGL0U5aE51VkwvWERhd2I1WkkvK3BjMnN5cGpKeE9jbGRoT0k0Wmt5?=
 =?utf-8?B?Z2w4Mmt4czdiM3ZxcHRtYzN0UmU0ZE5Vbk00TkN6SVBPZDgvdk5xUEI3K05a?=
 =?utf-8?B?d29mb2hWeWJEU0pkSWl1KzliSThNZ2VBTzFNeG1QRm9MQUx2aDdia3ovVmY5?=
 =?utf-8?B?YllWaWRjUHlvcGdObC9mQzRBeG5vamkzckFIV1JRRU5la1dqcnpLcUVZcEM3?=
 =?utf-8?Q?ToU2B/2yGWDIja4dLP/baY1NpDPa9k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGVVZHU4U0FPbDVCSnpnNEp6K3dsQm0yUFMyVDVpeWhzeG9GdEZsTW82RFNC?=
 =?utf-8?B?N25oNk85Q0toWDhFMVFjNkhFZUsvWTUxODZFM0ZkcUg5Q0NLcTk2R3Y0cHpE?=
 =?utf-8?B?MncrL2pZZ25QSXkrRTFraVhRc3hzajFwZXQ1NHFpWERKcnhNMEpwakd4OGVj?=
 =?utf-8?B?OG4zVzVNRjBXd3JuY0J0VmdMRDdmYUxLR2h0RHZ2cFJiRmVtSDRlRGM0RkJ5?=
 =?utf-8?B?ZG1qQS9DMWl0YTI0dCtTUXVZdVZXdGJiektHbVI4VEZoam5naldFR1g3WlQw?=
 =?utf-8?B?SUlSZWdxRkJyaHFFMWJSZTJJbExHN1NuNU55djRqYmVqc2tXRFMraHRoRVFj?=
 =?utf-8?B?V0k2UWs3eXFSNGJzVlhCWTZtZG9yM0RoSTdoYmNoQUxoQlJGUEVHVU1xRkQ2?=
 =?utf-8?B?emNhYnpLYXlKVmlpMWNJckJWaVBLOXN6bTh6SDROYTg4c2Z2TFM5V1BuSTNi?=
 =?utf-8?B?UnBWSEo2cmNNVVFlNjhRRC9tUkMzWXJlM3daUnNlN3BOai9xOCszcWFIbDk1?=
 =?utf-8?B?QklRU3EyWGxzakRKWUVVc2prUWJYUkVmVUc0TzZIVWJCdVBFSGR1MFNub2hw?=
 =?utf-8?B?NWpYVmFyR0N5dFBDa2VoZ1lXYUVjTmloTGxuek1iL0dvcDR2dzM1Z21acURo?=
 =?utf-8?B?ejZnOS9NTXBuRm13T2E4VW1Pa2Z6Q1ExcXZYRGJiTTJmeEZlc2g4M3EwNG1C?=
 =?utf-8?B?NldpNVNRcnFjc1pZcHhiOFFBZ1hKdW4wU1ZGTG0yVHlHejhFYllVcFM0ZVZp?=
 =?utf-8?B?VzBYMTM0dVVoUDRubVdpN1NlZm12VEliN2tJVjliemdmbmZ2NUZNOXhoS3ZZ?=
 =?utf-8?B?Yi9hSGFndWYwYUNtU1o3cTdVR2huaHFFUVBVWmZwV3ZvcDhTSUwwMnNIaC9C?=
 =?utf-8?B?Q2RkdjFkZDdVdXN3TGk4RHlaY3NhaEYvTG9sZEVTRG9RcDJ5dmN1eU93bzU2?=
 =?utf-8?B?eXgwdWNKS1pTYTJFSDQ5YmIzMTdRVllUSWRWekwzamIwYW5XSFVVSjYyaURz?=
 =?utf-8?B?UmFRamhZeFQzckZIZ2JWQWd3UU91T3dITGJMd09VbVF1U1ljQVFNQk84ek84?=
 =?utf-8?B?Z084OENRV1M0dHpQTThrVmZQVkEzVUMxMWRiWGZxWEZoRWowSzBYMlZUZ2R1?=
 =?utf-8?B?c1VYa2FjMUt1MmVHeXQ0MjFuWVlMWlB4bVIzK3BDMGo3cmpKbUk0aVExd01l?=
 =?utf-8?B?Z01VOHUyaTdXVWRZWVU2SzREd01YUzZqam8yNm9KSy9oTTNIRng3OEU1OFZq?=
 =?utf-8?B?ZnpScnBKVllYbnVLSXU1bXpGc3UyeUR0MlJvTFJXdE44NTNSdzd5c1pxQVVC?=
 =?utf-8?B?dmlsbWM2akdDQVJueFZFU201WmVzNktZNVhYeUNaQ3dIa3l0bHpRbEtMOUxw?=
 =?utf-8?B?cFczNWFlZVBUbEF6V2dTOThDVGpjbFlzODZDVEM2TG5CNFIyT2tLZlA1SGNH?=
 =?utf-8?B?bnBBOTQrdG5aVDA4YmhOdExONVlPbmpqZmN0QXZ5KzBxK0daazJrMkhiNVpa?=
 =?utf-8?B?UTJaWnA2cTRHaExLSDdGWjNYYkY2YndZZWd3b2xWM1I1c0pNck5NeEZnMmVL?=
 =?utf-8?B?Q1ZwMEgyTUcrNDRLcVZGVTBWazBQZi9GN1dEZEloRDk5WlpUMEU0WHQvOEI0?=
 =?utf-8?B?d1BzRUxxVTF6ZzE5VWFlbW9GYm5xaHBVMXRNa2VCZHRsb2svSXZ0SWtWVkZO?=
 =?utf-8?B?bkZSM0FIQnFUdllCM01TNkxaeEZlS0J3TVBEOGIxbWtSMjZrd3pQVzB3enlW?=
 =?utf-8?B?SG1vK3kxRkQxNTFEOWhYR1JlWjNPZ3grYmZkVWs2SVJON1pFcXQvTWV2UHox?=
 =?utf-8?B?WTdqQkIrSE5rVTc0TWlaVXRVcXoyN3NkeENlUWh6czZzUlBuSTJYM3ZXdVpB?=
 =?utf-8?B?T1llMWU1YUVVR0VMRlJMd0dCZEhIMEpydHJVMDNUVkdqdXdpYVRLUlRKWDhq?=
 =?utf-8?B?WHJaa0VLVURWemZEcEo2WDg5WEs2akpkSnY4TWJmOTgrbC9hMnpNZWhMVWll?=
 =?utf-8?B?aVB1c3V2Q3N1NGRtcW1yS0NNSmRjY3hCYUlkYlhNMEZuK3RVbUR3Z2YrUmpB?=
 =?utf-8?B?ZmZHRTZpQTRrVndSOW5panNpMFZLWkN3RDhDbnVHa3pYNk9uRWl2RVF0MkVM?=
 =?utf-8?B?S2JRSnZub0IzeldlcE1kY0tUMTN2Yy9mWERESmFnRkxpS2Nxd3FqZVR6eE5T?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0262153B19185F499CAADB6B17C2F063@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41e1b84-85d5-45e9-eb03-08dd8643ebbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 11:00:43.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKFC5Sd/Ng69Z/vn9mx9HTDCERbjS6rXBGRwHcUEY9ZaIMTyj3Ga4Cd7uJS/PcIPsnmRJV5lqAZkHdoN2cAyfoiJ4UIDyt2gz1h7J+MYAQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6775

T24gVGh1LCAyMDI1LTA0LTI0IGF0IDEzOjIwICswMjAwLCBKZWFuLUZyYW7Dp29pcyBJbmdlbGFl
cmUgd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IEhlbGxvLA0KPiANCj4gSSBob3BlZCB5b3Ug
aGFkIHByZXZpb3VzIG1lc3NhZ2VzLiBGaXJtd2FyZSBpcyB0aGUgcmVsZWFzZWQgZnJvbSBteQ0K
PiBkaXN0cm8gKEdlbnRvbyBMaW51eCkgMjAyNDA0MTAsIGJ1dCB5ZXMgeW91J3JlIHJpZ2h0LCB0
aGUgZmlybXdhcmUNCj4gdXNlZA0KPiBpbiB0aGlzIGNhc2UgZm9yIG10NzYgaXMgMjAyNDAzMDUs
IHNvcnJ5Lg0KPiANCj4gWzc0NzM0LjQ1OTQ1MV0gTG9hZGluZyBmaXJtd2FyZToNCj4gbWVkaWF0
ZWsvbXQ3OTI1L1dJRklfUkFNX0NPREVfTVQ3OTI1XzFfMS5iaW4NCj4gWzc0NzM0LjQ2MzQ0OV0g
bXQ3OTI1ZSAwMDAwOjczOjAwLjA6IEFTSUMgcmV2aXNpb246IDc5MjUwMDAwDQo+IFs3NDczNC41
Mzk2OTJdIExvYWRpbmcgZmlybXdhcmU6DQo+IG1lZGlhdGVrL210NzkyNS9XSUZJX01UNzkyNV9Q
QVRDSF9NQ1VfMV8xX2hkci5iaW4NCj4gWzc0NzM0LjUzOTc2MF0gbXQ3OTI1ZSAwMDAwOjczOjAw
LjA6IEhXL1NXIFZlcnNpb246IDB4OGExMDhhMTAsIEJ1aWxkDQo+IFRpbWU6IDIwMjUwMzA1MTMy
OTA4YQ0KPiANCj4gWzc0NzM0Ljg3ODg5Ml0gTG9hZGluZyBmaXJtd2FyZToNCj4gbWVkaWF0ZWsv
bXQ3OTI1L1dJRklfUkFNX0NPREVfTVQ3OTI1XzFfMS5iaW4NCj4gWzc0NzM0Ljg3OTA2OV0gbXQ3
OTI1ZSAwMDAwOjczOjAwLjA6IFdNIEZpcm13YXJlIFZlcnNpb246IF9fX18wMDAwMDAsDQo+IEJ1
aWxkIFRpbWU6IDIwMjUwMzA1MTMzMDEzDQo+IFs3NDczNC45NzQyNTVdIExvYWRpbmcgZmlybXdh
cmU6DQo+IG1lZGlhdGVrL210NzkyNS9XSUZJX1JBTV9DT0RFX01UNzkyNV8xXzEuYmluDQo+IA0K
PiANCj4gVGhlIEFQIHVzZWQgaXMgYSBDaXNjbyBDOTEyMEFYSS1FLg0KPiANCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gDQoNCkhpLA0KDQpJIGhhZCB0ZXN0ZWQgd2l0aCB0aGlzIEFQICg1RyBIRTgw
ICYgV1BBMiksIGFuZCBteSBzZXR0aW5nIGlzIHY2LjE0LjMgKw0KbGF0ZXN0IGZpcm13YXJlLiBJ
dCBsb29rZWQgZ29vZCBmb3IgbWUuDQoNCkNvdWxkIHlvdSBnaXZlIG1lIHlvdXIgQVAgc2V0dGlu
ZyBhbmQgY291bGQgeW91IHRlc3Qgd2l0aCBhbm90aGVyIEFQPw0KDQpCZXN0IFJlZ2FyZHMsDQpZ
ZW4uDQoNCg==

