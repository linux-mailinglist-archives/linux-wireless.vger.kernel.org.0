Return-Path: <linux-wireless+bounces-19108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E3A3AF63
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 03:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B7C170FE3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 02:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F322AE74;
	Wed, 19 Feb 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qQEMCmHQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MR0OezRl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FD2862BE;
	Wed, 19 Feb 2025 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931327; cv=fail; b=Ms1s/ix29fUucyT+K9VlfqpaFKkHzsWFreSZRLtEk4+73kBaxa2pnVNAVu8uLpGCmbM0gfUUoCWW6z66I53fehXtOQL0927SlFZQlZlVwY030Pgx8mvdBXLfMHmxQY3SqlpFnyS7Mdv9fBhwS+Jvhq+SnGHc6z4xzIuWwEusplA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931327; c=relaxed/simple;
	bh=OgqioXge7BKU5HCi8emtZQSq4m0xd+/YumtfW9gB6po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYTVVV9W3NRIsBaMlirGR6Tr37tp5VOu3Z+Nvux4K3sIUM0+yTre55lk0Akzdx58rdRu0VldlQ1gjj7IE+Li+PPxOrlyNqirj7fUjrSUEHp0lEWp0ACvd3q8q6EWnjSDFn6ZB4ULg+QJmU1ZhYJVerPvgdseW7N4NgY3ET/QQ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qQEMCmHQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MR0OezRl; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5ad0ffceee6711efaae1fd9735fae912-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OgqioXge7BKU5HCi8emtZQSq4m0xd+/YumtfW9gB6po=;
	b=qQEMCmHQ2NmmhOh+BwJGXu27T2aZ1B+65FommD6fKkFUCW3hbmcWdJaW4UDzMYai35gWYCPbwhwucylARjNThsZSc8slWRSSv6Wl/MNDaVeqdYY5UNmW8XBba2qGh5h5lWvOKKCyg5Bqd8mXFwr7XuFTFQBh0UNjO6NPtuk556U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:d3e4ebcd-e1a4-4166-80b0-5875bd1d6db0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:5b200edc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 5ad0ffceee6711efaae1fd9735fae912-20250219
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1511517642; Wed, 19 Feb 2025 10:15:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 10:15:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 10:15:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlHHetkP/j22INWOJCr4Crz4V1E5RZueYzY5puxD+38V+2O1zE0ZRPr7oT7ijXmwLo5VJ1sCb3V7oJ72UJ4olZldyA36bN7URu6GlXQYPO0JchiQYlnYeTz4ALB7zo78L+TPYkkkm0VwUb3Tiug343g4y2Yjh+fTbgLh6CTmrARqo8ajKYlR9Nv7P169ErkdoKqRBnsxYaMepvryyD49OSrrcH1Rz9OB9oEJSSXXpjt1RFH30gP6DKUFRrvM3AuwWusOvbf6URury8ti7RThWsGtdGFVez+/GTuOCxbpn+8kDHjFznExTwPiuoD26nkrEWeO/TbuhRvMu9APFS8dMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgqioXge7BKU5HCi8emtZQSq4m0xd+/YumtfW9gB6po=;
 b=sHfjVVXUR6l6q43OXnNdY8SljdeiB7/6r3AooDG0rGsVuuotXNMioPI3OC7/FzuJ4DFfDmRpabJIV/l9OyVyZfY5DTjMemToMPBQUl2SJjmIq7z0P/h8GbI3mNTWWaz3K21v+aBvt9YHfRmrSRj2qHGDRFkapzj4ciwx+hcH8tdjBLpj0RMFfgcNL6/ErAXrC1TQoK6jrjA23nRNKb0as8nnDDJaLJ7LptOIvOLRgq+mIK2akIAcf5Kse3wS9mGI4LCukmAGt+wQs1jC45wP+2y3oDuv5lLQqaQPRuLweXWdyKMmaeZJNSjye6XUVcyQw4VrKkEcYGwSfv0qSmDL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgqioXge7BKU5HCi8emtZQSq4m0xd+/YumtfW9gB6po=;
 b=MR0OezRlepxSyp/DYzLXsel/Pr06odLSZF113jZH1l+BwDLMW779ebbKUpyPud6SfbCDWiUKFtTFYkhN49iLDQc6uslkbPS2EHwj60Ihr9lxvdhStb8pxa4sqg+VASEdKaG3NngMCS/1D/s63LEsgSrUHDUfQciFZ4YA7VSJyjw=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TYZPR03MB6790.apcprd03.prod.outlook.com (2603:1096:400:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 02:15:10 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%3]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 02:15:10 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "nbd@nbd.name" <nbd@nbd.name>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH next] wifi: mt76: mt7925: fix error checking in
 mt7925_mcu_uni_rx/tx_ba()
Thread-Topic: [PATCH next] wifi: mt76: mt7925: fix error checking in
 mt7925_mcu_uni_rx/tx_ba()
Thread-Index: AQHbayByXcPRIdrRhEObbX2gRW0BCbNNOCWAgADZzQA=
Date: Wed, 19 Feb 2025 02:15:10 +0000
Message-ID: <463219aca5acb30ac0f383b00639ea3ee0ae408c.camel@mediatek.com>
References: <063aafdf-3234-42ac-a4ea-3ff98e2835b6@stanley.mountain>
	 <5e7bc52b-332d-475e-94ca-571864cb1a6a@stanley.mountain>
In-Reply-To: <5e7bc52b-332d-475e-94ca-571864cb1a6a@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TYZPR03MB6790:EE_
x-ms-office365-filtering-correlation-id: cffce879-0d64-49fe-440f-08dd508b3cda
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlFOTU1mSDQ0dkQ0bVZoak1wbGxYc0h4UExBV1dtMkVVS0QyTkx2Wm80MitG?=
 =?utf-8?B?aHpuWkcreE90VXBYRWZ5SkJ4ZXZIQzRiSEo1cy9pVmM0OU9uazJ5OGxRYXFr?=
 =?utf-8?B?MHFSWFdWZFRIaGxsRDRFZ3NJbSsvdmFaUEo5YVVwYldUWXRFdU5XRXczbkVT?=
 =?utf-8?B?NkJUSnQ0RlBvTlY1d0NZVmExNkNyV1RuN3hRUmFtOGlPdlIvalZHNmg0NSt5?=
 =?utf-8?B?NjRtcDJGdERRaVUzN21saXViVTdpenAwNWtGWklkaGl1QWU2ZEpaTUhWNkFp?=
 =?utf-8?B?YktpdmMzdjA4QmduRi9nV2x1c2ZXVmd4SjdmYzV5NktHaXNmdGtkdGlIek93?=
 =?utf-8?B?cVkrbGpUQnRTNVAxUE9xSXNJeTkyYjJBWXFVUUFrbnV4eUc0ZG1RbVl4a0xH?=
 =?utf-8?B?TVhEeCtWNFVtWE9UUzAxcDd4NXMzMC95RlJBdVN4eUpvMnl5OStFY0JrQ29Z?=
 =?utf-8?B?QllURDl1WXNxQ24xclk5aUtXcUMvYTlsUWRPeWJCdVRQbndPMm1HQjdFREto?=
 =?utf-8?B?OEp4OW1JeEROMjZCc3l2R1YwMnc0TlluUEhBSFNObkpOd2FwMmVjUDhucVE5?=
 =?utf-8?B?NDJtUnlDRWw1UUlBcXRpSjI4TlBGNTIwOWxSNGtGQ2phdXMvU3d1aHFIQ1Bj?=
 =?utf-8?B?Q0NQcVdJNWV0Nmp1bW0wbUJYNGd6TUlmb21UL3pEYzBRR1diY0F5bDBSY3BW?=
 =?utf-8?B?NWEwVjJKMlJSVTR4cHdINUs1d1pVdU9EQ0JXeUYvajlEdldTRkIvd09RSVFM?=
 =?utf-8?B?UXVqVHFYUFJJRU1wNmh2dGQzQ1UvVkdFL29La01ZNEk5WGdwQVE4ZlgvMmY5?=
 =?utf-8?B?a2phcG1KUFlVNW9YK0dPZVM4MHpuTnRsbXJJZlk4S25VcVROMkZUWnkvN3hv?=
 =?utf-8?B?enJ1ZkZCRm1KRFZtMHRDSWNySVNlRm5mZXdIclA3VTMzekJ2TENsSWxKOHk4?=
 =?utf-8?B?OGJWdDE5RTkxUk5GTlVMb2VpUkorRDNhcGt1UUQ4VGdyT0wwRWFXak0vN1U5?=
 =?utf-8?B?ZVkvZEZKTkNWRmdUdUhBc2lKNjE1eW9ZVGJLQkU1Y3ZEU3NwVmFNUFQ1aEta?=
 =?utf-8?B?dTRKL3pVYjV0LzcvUU1LOEc2dVJUa0Z3djhwdkU4VkZIcDlvdndsWHZodTVh?=
 =?utf-8?B?WTVxd1VWenlSWWhqVk85eXN0RG9nY3VqQlA5bHRUQ2pNbnRiUG5aZGpCMkYx?=
 =?utf-8?B?WTBvb2cybStScjFGZVFHZ1ZEMzJtUUhTYnNTQ2lmTElyV3Z2NncrTHhUS1lm?=
 =?utf-8?B?RkdFVTl2OW14NXdUK29KZC9PNE42Vzk2eW1idU5WTXphRXZScG1uWmZheEpD?=
 =?utf-8?B?c21hQ3lVNDRYa3cyYnV4SDJVVWR4WVhpQytCM1g2V0NMM1VqYWFtbU8vUVpp?=
 =?utf-8?B?b2xqeHdiRUlkOSt5TGV3UDM4TGdqQTZpakhkYTNzMVVhZmFCTnl2VEQ0dlho?=
 =?utf-8?B?UWREWHJFSXk1YzkrcUQzUEM3b2grYnEzTXh2NHJJdVVlRnBoRFBtUXkrQVVJ?=
 =?utf-8?B?R0ZOck1tRXNEZjJ4SmpySTNSbjNvZHZNSnNXYWdycE1rWkhzTTlvV1VMOG1k?=
 =?utf-8?B?ZUtHR2FPRURNNXBZU3locTRMeGFqQUpwRG0zNXJUT2pXdUZSZTl6YWF6VWlZ?=
 =?utf-8?B?WkhrRFJHbGw1c216blY5UE1EUWU0VXMweFFnL0lSclJmdnVJcVlFaTZuMTdR?=
 =?utf-8?B?ZXpCb1pZQ2ZrYngxNXBqRVVCQW9hOTAzOXVPY0RDTnlxMnZuQy92ME04d3F5?=
 =?utf-8?B?ZVNJdFpIVkVXK3VNZS9LTmsrcEhrWnlrb1pUUGlOVFhnRVRLcDBEb3dWZjFN?=
 =?utf-8?B?NDRkWGQyTXA0bWhzMDlFS2NEMUFHUEc4RGN2MjFLaFVQMzB6bHFMc21QZzNO?=
 =?utf-8?B?V2hhUlQvdFFWblc1bWg4TUd0dGRaZnI4TUpJSWhUMWRMRTlsUzFETG4ycEY4?=
 =?utf-8?Q?HoHrNqtkA2DIpW/SapwdBpDX81d4qwZT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHZCdmxkQ0xJcW5WMFlyZkF0bmNBdGpveVRnc21HMXYvbWdrSlJsbkZCWFAv?=
 =?utf-8?B?YXIrRkRMNFg3WWJ0TnV0eWNvdVhvdEUraERqdmh2TFQ1VFkrbTJibVgvekFE?=
 =?utf-8?B?L0ZsKzhpbFhCZFR6VzZCV3owemtrMXc4SWNmVjdJQm1vcE5VK0pBekVzU2pu?=
 =?utf-8?B?M3ZCQ0NFazlqdXpSWW12YVR0b0tBQklYSUVhcmd6eHprMUFTaWNrSWF5N1do?=
 =?utf-8?B?WmZWWVU4OW5nMHJldVpmY2pXWTl5bEMxUy9SQjJKNWJ0ZVh3R2Z0c2h0UTNj?=
 =?utf-8?B?VWNqSnByMndEWVMramdpUjhKcllFYkFCOGhka2YxV2lkaEZIM1VvaU5IRVE5?=
 =?utf-8?B?TnFhbUdHVmlYaHpUTmNHR2tkbmRJQ3RIb3lyRkQ1YlFaeXFCVWpEK2x1MHFz?=
 =?utf-8?B?L1hmRlFSTk9LRnVNdnBYZVNVUkxWc1hGa0E0UXVmMGdSeFVlS0szcE5mbnBv?=
 =?utf-8?B?Mi9hNFIwNWlEVzlwUEE4Tks5UmF2RE43RUxFSU9FSG02UUhIK2ZLTmZQS0JZ?=
 =?utf-8?B?ZWl3VTVnWm8xeDdzYzk1dXdHdElSYmdCZklnZXZBM0VHN0l5ZDU0RERtRE5T?=
 =?utf-8?B?VTY1TlRpTGh5dE1nTkkvN3FWaDlvVHBjMXJUYmJVSStUblhDNlVwTXozdnJr?=
 =?utf-8?B?bDJDeXN4V2w3VEJHOWdzUFptQmtpQVBKSFVOcE9LMmMzbS84Y2FNanZHT1J2?=
 =?utf-8?B?RGwzekpwWFNzYmtJSW4wbWdIS2FiYUo3S3owbm5aVHhuY0hiaDVKOTRVa0Qr?=
 =?utf-8?B?UTEwd2dML0d4VElGMUVjbG51blpXREpEc1Z3WWRXL0NZMmtEdmlvanU3VGZF?=
 =?utf-8?B?TlBzUjhFTkQxZGV1ZGdBcy9iZjNsSjltWU1JdzBVZndKMGxDbEZRMnBsRkRs?=
 =?utf-8?B?OXN1NWFCL1F2TkpNN3g4bkdDOW95UHl5dTFzVlVWb1BkR0tQOWhKdWNQSG4y?=
 =?utf-8?B?RTZrMnoyemVOQkI2VktrL1N1citiR2ZWSmpZYlNoRGVMVmIxSnJuQk13eVpz?=
 =?utf-8?B?Nm9YRVoxaUJQRWNQUFFsdTFMWnJHMVdmS3FGeEdqYllXSjdPZTEzSW5Ld2ty?=
 =?utf-8?B?Z0IxWnllbitqaUw1a21RRzhGdUNVWnJvdGVRam9UVTJTTFFabWlBZmZUWjlz?=
 =?utf-8?B?aFRTZkNVZXpYS2RFemtjWTN5d2dCMXN4a3VTNEVOTm5GTmV1N1ZXSWw3NmNy?=
 =?utf-8?B?QlJPSnNUV29TVFhFUnlzZEY4czFMMXNKZFhrNmtxNmdScHlhUndzZllwZnZP?=
 =?utf-8?B?VEFXMFo3VTBJSjRncEpOZkFLTnpadm12RDFraHlFblUrOUFzZEVCdTZVV20z?=
 =?utf-8?B?TW9BRVhScVhKLzhueTlIOTlnaUZ4NUFYaUxZUXltVDBiUmpBS01LVEh5Q1Zv?=
 =?utf-8?B?RlV4a1JUd3EvMDl3U1h6aFNKVk5DMmJ2QkJKVjZxdW5MTnRxalV1Tnd0ZmhH?=
 =?utf-8?B?Q0xxSVIzbTFuTEIvd0JLKzZha2JIazQ4UHJFSllFT0hpdGNlK0prN3pTUXhp?=
 =?utf-8?B?TDdqRi96M282NlVWMzlxVGxTLzlEZkdJUDAwZzJrMjh1cG56RWw4WmVTSzla?=
 =?utf-8?B?SlJDRmlPSUhMUmVrMWFkZThhbHhJb2N3aUZ6Yk9aem13Q1lpLzhGRml6c3hV?=
 =?utf-8?B?ZHlIUDQ0VW1PR2dBaHI4UjVTb1g5WjU5L2x6UDBQZUZDVVd6cmJrcHI3RzBm?=
 =?utf-8?B?cnQxd0FKdHErT25IYUtPZ1dONk1GbW54VkMzNzQrbE9yNXlaRm1kMDYxRFRI?=
 =?utf-8?B?Y3ltMXFsVkxqSUhlVW9kMVRFV3R3cTJReThMZFFwWGJwSEVSVVMzOFFCWlYx?=
 =?utf-8?B?WGUxcHJxOTAzdml6Zk4wSStURHRCSmxBQytuZzBCSlJjQklxQ0d3M2x1ZEph?=
 =?utf-8?B?aXpPcHJGZklQREovQVQzNitpaCtudzFhVENaVTBweSswWm5YR3gxSDlJaEJ2?=
 =?utf-8?B?TzI1RUUydmpJNkpOeCtaa2ZReXFYa0pUOWJqWWZ1MnpjM3M5MDdSdTFQTTRY?=
 =?utf-8?B?aEtXdEZIV1NrbGJhdW1DaGc5NmEydkpMZ2dZcjhDNWNzd3ltN3RHUnQ2eVVr?=
 =?utf-8?B?ZEc0VnNzZ2VTckFra1h4VlpKTXJoYmhIMXBSQWFSQWFnR1pZck1qZ2VnWThl?=
 =?utf-8?B?ZlV2c2lXT2tQU2dSdlk0Mkp6QWx1ZGtJQVZ4SGRtK0ZzM3ZXZW8zTTdUYmRI?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EA99D8F1C458240A058F84E7330E4F4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffce879-0d64-49fe-440f-08dd508b3cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 02:15:10.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+JjCr+OeoeVxOFLRhP0dWOcik60n0n08W06McysT+qe98fV/DVYUBVt+nGBLJxFCLIBP8VizR/ZLeYHt6qwqfqMKu7ZewTrT5Qi2pzyOow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6790

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDE2OjE1ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+
IAo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4KPiAKPiAKPiBQaW5nLgo+IAo+IHJlZ2FyZHMsCj4gZGFuIGNhcnBlbnRlcgo+IAo+IE9u
IE1vbiwgSmFuIDIwLCAyMDI1IGF0IDEyOjQ2OjU4UE0gKzAzMDAsIERhbiBDYXJwZW50ZXIgd3Jv
dGU6Cj4gPiBUaGUgInJldCIgdmFyaWFibGUgaW4gbXQ3OTI1X21jdV91bmlfW3J4L3R4XV9iYSgp
IG5lZWRzIHRvIGJlCj4gPiBzaWduZWQgZm9yCj4gPiB0aGUgaWYgKHJldCA8IDApIGNvbmRpdGlv
biB0byBiZSB0cnVlLgo+ID4gCj4gPiBBbHNvIHRoZSBtdDc5MjVfbWN1X3N0YV9iYSgpIGZ1bmN0
aW9uIHJldHVybnMgcG9zaXRpdmUgdmFsdWVzIG9uCj4gPiBzdWNjZXNzLgo+ID4gVGhlIGNvZGUg
Y3VycmVudGx5IHJldHVybnMgd2hhdGV2ZXIgbm9uLW5lZ2F0aXZlIHZhbHVlIHdhcyByZXR1cm5l
ZAo+ID4gb24KPiA+IHRoZSBsYXN0IGl0ZXJhdGlvbi7CoCBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
cmV0dXJuIHplcm8gb24gc3VjY2Vzcy7CoAo+ID4gVGhpcwo+ID4gZnVuY3Rpb24gaXMgY2FsbGVk
IGZyb20gbXQ3OTI1X2FtcGR1X2FjdGlvbigpIHdoaWNoIGRvZXMgbm90IGNoZWNrCj4gPiB0aGUK
PiA+IHJldHVybiB2YWx1ZSBzbyB0aGUgcmV0dXJuIHZhbHVlIGRvZXNuJ3QgYWZmZWN0IHJ1bnRp
bWUuwqAgSG93ZXZlciwKPiA+IGl0Cj4gPiBzdGlsbCBtYWtlcyBzZW5zZSB0byByZXR1cm4gemVy
byBldmVuIHRob3VnaCBub3RoaW5nIGlzIGFmZmVjdGVkIGluCj4gPiB0aGUKPiA+IGN1cnJlbnQg
Y29kZS4KPiA+IAo+ID4gRml4ZXM6IGViMmE5YTEyYzYwOSAoIndpZmk6IG10NzY6IG10NzkyNTog
VXBkYXRlCj4gPiBtdDc5MjVfbWN1X3VuaV9bdHgscnhdX2JhIGZvciBNTE8iKQo+ID4gU2lnbmVk
LW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPgo+ID4gLS0t
Cj4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21jdS5jIHwg
MTQgKysrKysrKystLS0tLQo+ID4gLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMKPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMKPiA+IGluZGV4IDE1ODE1YWQ4NDcxMy4uYjNh
MDA5NjRlODAyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MjUvbWN1LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTI1L21jdS5jCj4gPiBAQCAtNjE3LDcgKzYxNyw4IEBAIGludCBtdDc5MjVfbWN1
X3VuaV90eF9iYShzdHJ1Y3QgbXQ3OTJ4X2Rldgo+ID4gKmRldiwKPiA+IMKgwqDCoMKgwqAgc3Ry
dWN0IG10NzkyeF9ic3NfY29uZiAqbWNvbmY7Cj4gPiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcg
dXNhYmxlX2xpbmtzID0gaWVlZTgwMjExX3ZpZl91c2FibGVfbGlua3ModmlmKTsKPiA+IMKgwqDC
oMKgwqAgc3RydWN0IG10NzZfd2NpZCAqd2NpZDsKPiA+IC3CoMKgwqDCoCB1OCBsaW5rX2lkLCBy
ZXQ7Cj4gPiArwqDCoMKgwqAgdTggbGlua19pZDsKPiA+ICvCoMKgwqDCoCBpbnQgcmV0Owo+ID4g
Cj4gPiDCoMKgwqDCoMKgIGZvcl9lYWNoX3NldF9iaXQobGlua19pZCwgJnVzYWJsZV9saW5rcywK
PiA+IElFRUU4MDIxMV9NTERfTUFYX05VTV9MSU5LUykgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbWNvbmYgPSBtdDc5MnhfdmlmX3RvX2xpbmsobXZpZiwgbGlua19pZCk7Cj4gPiBA
QCAtNjMwLDEwICs2MzEsMTAgQEAgaW50IG10NzkyNV9tY3VfdW5pX3R4X2JhKHN0cnVjdCBtdDc5
MnhfZGV2Cj4gPiAqZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gbXQ3
OTI1X21jdV9zdGFfYmEoJmRldi0+bXQ3NiwgJm1jb25mLT5tdDc2LAo+ID4gd2NpZCwgcGFyYW1z
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5hYmxlLCB0cnVlKTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gwqDCoMKgwqDCoCB9Cj4gPiAKPiA+IC3CoMKgwqDC
oCByZXR1cm4gcmV0Owo+ID4gK8KgwqDCoMKgIHJldHVybiAwOwo+ID4gwqB9Cj4gPiAKPiA+IMKg
aW50IG10NzkyNV9tY3VfdW5pX3J4X2JhKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYsCj4gPiBAQCAt
NjQ3LDcgKzY0OCw4IEBAIGludCBtdDc5MjVfbWN1X3VuaV9yeF9iYShzdHJ1Y3QgbXQ3OTJ4X2Rl
dgo+ID4gKmRldiwKPiA+IMKgwqDCoMKgwqAgc3RydWN0IG10NzkyeF9ic3NfY29uZiAqbWNvbmY7
Cj4gPiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdXNhYmxlX2xpbmtzID0gaWVlZTgwMjExX3Zp
Zl91c2FibGVfbGlua3ModmlmKTsKPiA+IMKgwqDCoMKgwqAgc3RydWN0IG10NzZfd2NpZCAqd2Np
ZDsKPiA+IC3CoMKgwqDCoCB1OCBsaW5rX2lkLCByZXQ7Cj4gPiArwqDCoMKgwqAgdTggbGlua19p
ZDsKPiA+ICvCoMKgwqDCoCBpbnQgcmV0Owo+ID4gCj4gPiDCoMKgwqDCoMKgIGZvcl9lYWNoX3Nl
dF9iaXQobGlua19pZCwgJnVzYWJsZV9saW5rcywKPiA+IElFRUU4MDIxMV9NTERfTUFYX05VTV9M
SU5LUykgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWNvbmYgPSBtdDc5Mnhfdmlm
X3RvX2xpbmsobXZpZiwgbGlua19pZCk7Cj4gPiBAQCAtNjU3LDEwICs2NTksMTAgQEAgaW50IG10
NzkyNV9tY3VfdW5pX3J4X2JhKHN0cnVjdCBtdDc5MnhfZGV2Cj4gPiAqZGV2LAo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gbXQ3OTI1X21jdV9zdGFfYmEoJmRldi0+bXQ3Niwg
Jm1jb25mLT5tdDc2LAo+ID4gd2NpZCwgcGFyYW1zLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5h
YmxlLCBmYWxzZSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+
IMKgwqDCoMKgwqAgfQo+ID4gCj4gPiAtwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+ICvCoMKgwqDC
oCByZXR1cm4gMDsKPiA+IMKgfQo+ID4gCj4gPiDCoHN0YXRpYyBpbnQgbXQ3OTI1X2xvYWRfY2xj
KHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYsIGNvbnN0IGNoYXIKPiA+ICpmd19uYW1lKQo+ID4gLS0K
PiA+IDIuNDUuMgo+ID4gCgpIaSBEYW4sCgpXZSBwbGFuIHRvIHJldmVydCB0aGlzIHBhdGNoLCBh
bmQgdGhlIHBhdGNoIGlzIGFscmVhZHkgb25nb2luZyBhcyB3ZWxsLgogCmh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDI1MDExNDAyMDcx
Mi43MDQyNTQtMS1zZWFuLndhbmdAa2VybmVsLm9yZy8KCkJlc3QgUmVnYXJkcywKWWVuLgoK

