Return-Path: <linux-wireless+bounces-6300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120D8A47B7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 07:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384B0283085
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4018E1E;
	Mon, 15 Apr 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tLEM+qvX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ke+o5DFi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7B18E02
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713160443; cv=fail; b=q0bu1GLgNmFjqi2pPmAL0SS2HDlJBspVPvS4qLcboMelybjPzf2ls2zH7PDzfsaMHtuxJGugMbDxCnC80jdMkD3TqDQNdt2sCs2XTRdNMC0xW4lSk8usmZeQlUuw9q0JCZA0ZpCtA9fpzDG00Qs4u80rM986gfxDajcoD0xOR5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713160443; c=relaxed/simple;
	bh=jq5u97dQOvazjnv+VTWNI8MRQT3KOiAdA8DDXkbA0rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fPB8kBqhgkkVhL+GOht8Cdc7xd9hZNT6oC5mH8gWvBa9hfhCKVHBHzbjzSDhT7QZFvS/o6MeGOqHzakT0zq9V48Dc/ApkGtR6U/5Yo+rtZ4v2/FGqeXBduRzXizw6cAkeMXgLEVhIEQkTjEr6rY9tYyCI/daQxKoGWVY5GHvCHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tLEM+qvX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ke+o5DFi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 86a41eacfaec11ee935d6952f98a51a9-20240415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jq5u97dQOvazjnv+VTWNI8MRQT3KOiAdA8DDXkbA0rc=;
	b=tLEM+qvXy1Jz8OISGgrJVH7UbXF9PZq6VaMuv0NCo1mTdAt33XTEWQy2mtekN1XL5BdDTTTCo7euWoPSLR5bpUPqd21hDFa014KlIJ2CMORTVm9DnKZ4dDJ3+vM6iI8QZb7Co3S3nDbygMvogwLe/zy4IhWvQgaCTYl25lzbp9Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:611bdce0-9303-4d31-9c6a-c65d8dcc5512,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:6750eafa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 86a41eacfaec11ee935d6952f98a51a9-20240415
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1708368007; Mon, 15 Apr 2024 13:53:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Apr 2024 13:53:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Apr 2024 13:53:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQTwmXd/6dijPmR+nFnUQt4jqTO6ghD22xxUjho2phXRz8rQ6vBNRcJwfU7fqO02hA114a3NhYbaLVf+xG4rgwAV0kjbOsRhfq4ZbvkPcFZfue5ullaofC15pv/3DOJF+EyBdjjpWYAiFPdfP0DigQraA2zTpif0JA2ccZXeL1oC5Xp4aZYJkVGmLz00dM1WRc41qbwcToqJ+zOflOS3JbTlujaqGjmTZsfl67eYxFGAZDR4f+Nq0CzOxW4/atk/LeRxkPMvCMI7Vae5H3KLf5e2fPthCILfNRBGwCobcQmSfqnVDX6IWWjmDgLXjHylcbRzH1MrteeM5kORk6yVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq5u97dQOvazjnv+VTWNI8MRQT3KOiAdA8DDXkbA0rc=;
 b=GFaY2cjoR8mSSBUdHAQU4ojx0UvKSMokWBnbQ5pu5K3oH50j5MqOnWDSAoUYw4HnAnomJtOSGbZnBdWgis+h99niF7AilpVmwTR8dcuSgmj9oqTtVPGggul2inrWQgUpsAvTROzXssLHFotElG3DLtuE8MWbojqeyzP99dfqXqdyY9rj/Gi3DFjx/mgWqpnbVE41PdJlnwSpjIFBsIlD5lKnm3W1IylReRm3i1uFJLlTkVDO4z4o3aLIRGmv6OWoWHPQMaGeXZnypOx8bse6RUKKyxlaJz4Y+JwxQu5GvHBy5r7YH1+2Qm18a5a2Jld6YEt/LBpSVHNp8E4zirOe8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq5u97dQOvazjnv+VTWNI8MRQT3KOiAdA8DDXkbA0rc=;
 b=Ke+o5DFie3x8X8xawpu6wZMJYTT/7uY7Jkhw4OIY7l7d6ErtyvpJ0uxsJK+mERaaGlbDeCvIb7ccfIm2Rd3JIuRHynSdaDtjpENvwABw8tOSQGbGNC+NKMQn3ufaThPPWncPpsdqtHNpIeIxdxNhC5x8TD0AeyrgVlLJfxtMlZM=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 KL1PR03MB8515.apcprd03.prod.outlook.com (2603:1096:820:138::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Mon, 15 Apr 2024 05:53:43 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::cea4:9fee:cc06:34f4]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::cea4:9fee:cc06:34f4%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 05:53:43 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "nico.escande@gmail.com"
	<nico.escande@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>, =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>, =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the preset
 regulatory domain
Thread-Topic: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the
 preset regulatory domain
Thread-Index: AQHajLb8HqlgPkc/cUSZ/xmt6p185LFkXfYAgAR7JgA=
Date: Mon, 15 Apr 2024 05:53:43 +0000
Message-ID: <3e2eb7ab155cbc4819096e32b914d220166a9adb.camel@mediatek.com>
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
	 <D0I1D2J8EB1L.2DPV9W79YKN2C@gmail.com>
In-Reply-To: <D0I1D2J8EB1L.2DPV9W79YKN2C@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|KL1PR03MB8515:EE_
x-ms-office365-filtering-correlation-id: dc6a9ce1-f4eb-4be2-833b-08dc5d106878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?RHVXWSsyTHZPQ0lxa1Z1ajNnbGcrYVhSQXlBb0JOZ2UzMkw2aGVHTzBmRWVJ?=
 =?utf-8?B?bWNuc2VoaUM0dllwMUNGKzczSHpQTUFhVUt1clU0ZmhLU2VMYm1BWTNIcUdS?=
 =?utf-8?B?YUdtSkYxWnNjWUlTa3h5eVNwaitZZ3pBRFhLNERaNEx2YmVBaWdKRnA1TG1o?=
 =?utf-8?B?a2Rwbmp4aWc0TVZaQUxLWk5PdE1BdnZFUzdnTVV3bStBQlU1OXNyckpaZmNk?=
 =?utf-8?B?UE5PbGV1Zy9KRzdJaXlHY2xsMmFRblByRFJ3YlBteVJad2xPQk1WTlZnYkZQ?=
 =?utf-8?B?cnRyZmNHbDNOdjV2QlozUnp2SHcyR0w5ODZLakJ1RlBiVVNsSm85ZlhxUzZk?=
 =?utf-8?B?Y0NidzZxOFJKaW9EOTJudmx5OXVDRTI3djQ4SUZnamxLWktNcTM5NlV2eFl3?=
 =?utf-8?B?ek1KMzBKQXJLOTg2bzZlZkZEUllQYXBpWGRveE9xQzhRaHEzUjhEcWNWNXhk?=
 =?utf-8?B?eHNyejN6Zzg0NGJUdXplQzczcHlTRmg4N1FBMThnc3pHQzZ4eW5JMTd3akdC?=
 =?utf-8?B?RWNaeVI5cmhGdmxvSURGbURTSW5BQTlaQzUrVWQwdFpJM1h0d1d5S2hBMnlz?=
 =?utf-8?B?V0ZENFVscFVncTdrSWVLYjVuRFFyYURWVWNsZDh4djB4K1FXcUxXVmZaSGov?=
 =?utf-8?B?RmVpSnNHdjUrM1h5SythYXRkemFXeVAvOENxeE9GVmhtbTJPOGtoVW9zTVB1?=
 =?utf-8?B?MnBFaExVWnFIZk43ZUt5ZWJCd3JqbWdPN25KaDZaRUxDNXlsVHpZcDVXVTV5?=
 =?utf-8?B?U2RKTlZRSmZhMTlicjh0TGN3N1MyZnNvdFNxbzRUL1VWTkIvOGliT3RESWMy?=
 =?utf-8?B?eDNrNFY5NTI4WWEzTlB3U2VvbGhhcnlXSTJoWnBzSnZPbTduNFpJV3FjR3NC?=
 =?utf-8?B?UmE1dkFPbFdCQlFST0o1WWs4UFhaTmFDYm0rb1J1YklEUTB0d1J3bzhGWUxp?=
 =?utf-8?B?MXVDb0dLK1MvNVFKSGhUVEJabDdFREhlZE1kNmhKM3FhYlk4eExGSWNDL2o0?=
 =?utf-8?B?dFcxb2VaMCsvVDZqeFlaNjRaLzdjK0xMa1FTdW0vR09WTjlaNnN1T3NJeGxT?=
 =?utf-8?B?djJMT2pkRW50bWxCV3p3cGZRajBSZEdEV1NUOWxCOWZMcGNHd2RFWFoza2Ix?=
 =?utf-8?B?VGxEUCtSbkhDRFNBOFlNeTR4Vkw0dHgwb2ZnQlh1SGJiWURiVDFhWXQ0TzRM?=
 =?utf-8?B?ejVxdnB6WXNOZk41UXMveSthSHJvckRuUjE0T1JCWFg2UGtIV2hVeEFKTHoz?=
 =?utf-8?B?d1cycm96M3o0UkJyNUpTK2lPNndjd0JlNk1KT0t1anlZU0VTNlNqdWl1aEtE?=
 =?utf-8?B?M0lPa1dSUFhjQU5PeFBrUFU4QzhWNHNDMWlTREwzNXc5SkZiZHpUSmNrTWZn?=
 =?utf-8?B?QnFrZFVxWUhOb2lrcEdua0M1ZlV5Z1U5ZHdJYVV4TFY3Mis2NVpReHlpTzFo?=
 =?utf-8?B?YjZNNUFxWTZxM25vQzVscmxCZFFHVXFBVkxhTkd4dzkyTWhBeU4yTDZkcm9G?=
 =?utf-8?B?YW1nY3BCTit1MWxpOFNxUk1yemRIZGkreTR2MW9ZQlRzQnZVWjdhY0Ftb1Y3?=
 =?utf-8?B?WURnMFJmbWw3WkF6c0JGSmZFVytwcUUxejZ2bXRUVjZvRnkxa3ZnWUZGRzlY?=
 =?utf-8?B?QjdJc0Y1cnZGQzJ5SzJGa2thTzhaa0NreVlMSmxVSmsrQTVmSEFabGduU01v?=
 =?utf-8?B?VFRqbTVoTiszTXVCODNJUVFHRlZoMXZHcm1kZHlIV1NOR1lrczFlT3J2UWFp?=
 =?utf-8?B?RU9PQzlUaVpsYWdvbXJqRnhsanpEbGR5ZmJ2RldpMWpWaVFsZjB6dFMvbkM5?=
 =?utf-8?B?VnYwSEJBblRBb3BpWFNaQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d21QY3hMb0dZcWozZ3VzQlFuSlJyMENWeklacm0wRDVOWjNhdmF2MG1MN2xs?=
 =?utf-8?B?N1UwL0pNTUh1ZnROUXFCeXRBazg2bDZIdlJiQ3JiRVlTVlAxTjNnc3BOMVZt?=
 =?utf-8?B?bmo1b0d3WU90QUZFUE1DT05JVXVGekZnTHU0bW5iSXREV3JRVitWdHZhS3k5?=
 =?utf-8?B?Mis4VE43cjRheXg2L1NXME5IYi92U21WcDlrbnM0Q0kvWjVIK0ZpdzlFeUlC?=
 =?utf-8?B?aFVhK1FLSlRpSjFjZTdOZ0FQKzcyVjN4OS9VcFZaYVJkcUYzMkthMks1MmRK?=
 =?utf-8?B?dDBiMk04M1JKeFBhM1hYclJaNFh4UStHNUJ4QURHZTgxM1F6MVU1R0lIdmNB?=
 =?utf-8?B?U0xRVExsbU5WbU5mcm5iVVVrU3BhNmNsMmxTcVhGVitDTmhFaHk2bVowZUJ1?=
 =?utf-8?B?WTkvUWZCd3FjMlQ4b0tHcDJkWGcrWWM1eFBreFhDdHdTZVhTZnlwc3UwaldY?=
 =?utf-8?B?SmhCM2dmOUZvUWpIVmZNNnRNd0Jrd1p5R1A3ci9uZllKSFQ5L2RLUmhyTWpp?=
 =?utf-8?B?eFlPbEVaai9sQ0xCLzZiYmNVMURlSkQzVm4zTERsak9WdEpCSldwQzljK1lR?=
 =?utf-8?B?a0s4OUlzQlVwaUxRZmtnenpkcThGOEx5MGxoa3VmNm43MjFZTElEaWpVcHIw?=
 =?utf-8?B?WlF4VDhEZS96dy93L1NWc21HVks0eG1SazhuREcvN3N2SHFmbzNRejRqSWZQ?=
 =?utf-8?B?N2RCUEdOYjdiN1NYUzdwRDlpTzhkNTRMKzB4MW0weGtzM1BMZnZYTnZFdTZp?=
 =?utf-8?B?VnM5czN6a3hTcC9sd3hkaW1qOW1BMFNOVlU2TkdSb0I2OERhOW9CR2prb0tS?=
 =?utf-8?B?WEx4bUN0U1U1b2h2V09hcHhwVHVhdThUZUdDVFN2UDRXR201MlBobjhNOGsy?=
 =?utf-8?B?eEtmNlhnZ25HYVdYVGNkR1pRYkpoT2psZFcyQlg1dVNTU0t3eTJJYVUvUVhP?=
 =?utf-8?B?Mzdkck1uV1h6OW9JWVArUmJYMlViTVJ5eHYvY050UThFLzVud2o5Q2NrazlC?=
 =?utf-8?B?cVUzTlIvMm4vN29ESXhaREdPUEtPZnphS0NNSUhkcGE3TThrWFdKU0F2ZGIx?=
 =?utf-8?B?NzZRUzB2Ukx3K0NrQUIyc3hLcHU4SlhTK042TjBNNTFYNSt6dDU1bEFNVENm?=
 =?utf-8?B?VEpGVFZHSTRnd2JWdDhMY1RtV3gzRWNzRC9VSmM2VUkrbUF5OGE0Vncweklo?=
 =?utf-8?B?Z0JWSFBUQW1PU2NjSFl2Q2RFNW5BeCtwdDE0cWU5UEtqSHdmYktGTmdqWmRT?=
 =?utf-8?B?RE05YzEzZ3ptWXFMcmREbVlWbXhzYkhaUGJiZWMrZjhveStOQURrTUpCVW54?=
 =?utf-8?B?Z0dkaCtEWEVrM2g3YXZHMlNUeHRHOTRTTGFiOFZkMUNWMkY0bksvUUlOcTZQ?=
 =?utf-8?B?UXo3NWRkTjA4dG5FUUxGOHJ2dnB5RG5ja3VRb016bVZhd0JmYkNnTE1La2oz?=
 =?utf-8?B?dFJjTzhMc2tTSlYxVXlPOWRlR1dtRkVob0EzZi9WR0Q2M2lJTWowRlRJNkRs?=
 =?utf-8?B?RWtHM0VOMWpvc3VOeXhOQVhXMnMvdHhLWVFNQ0I5Rks1RWo1Nk1XQTBaUGVy?=
 =?utf-8?B?UE1xNXNWK2NXdlRDMGZvTi9Vdmp4ampoNUpHQUxxLzNyRnlwQ2ZkTGRGc2dp?=
 =?utf-8?B?UitKcjlTS01zdkcwaXYxTGsvUGRQUjVtUkNMcWVxVUw5WitiUzM2dEViYVpL?=
 =?utf-8?B?VUlMajNWdTdtRE1CdjZMdjh4dWhpMUpLakMzMERRS1NCZzFjRE1McXYvK1lV?=
 =?utf-8?B?ZmE4SmU3NEpYQm5lYVZiRnBMN1lRV0lIZEhYTG1ucngweVhrdGRGYm9NdkVW?=
 =?utf-8?B?SThad1VUQmJObGhDNXJ6ekZZRGpOUVVBYzRydHlpZlFkVFBUcitqQmFlRkF3?=
 =?utf-8?B?aHMzVWZtVnlsUXlQeWM0YllQR1VKTHk4VHRBUjk0anpSbXIweGJBOXhpV2Uv?=
 =?utf-8?B?cWloa3E0QzZwSS9KZDh3TUlLenlweUhtWEY4S1dUS0V4UDQxOWFOWEN6SDR2?=
 =?utf-8?B?NkFnaDRCM1hoT1RvUTdqTUVSQzZHRk9YeVZzSGJMaWw4VDlyNUpBM0ZCbGRT?=
 =?utf-8?B?ZTRBTEVjUDdhK2hJalM0T0hGZVlHU25IR1Q0WVpoUWx3SktjRDhXZXFScU9w?=
 =?utf-8?B?NFZMQkpBQXhmVjlPbHpvamtQS05BVnlWMHJCYStlKy8vTnJkYUhNVHEzcXJx?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5572464BBA45704594254D7827D9E8E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6a9ce1-f4eb-4be2-833b-08dc5d106878
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 05:53:43.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYoGBTNpIrwAB5TnPUBcpC766ki9qNikO3lYp4o8YxnILZr8vU7gJyUI/zNBkcOc4wPHerMLwyDgegNK89mJohxrAIilVStOUD4+23szbAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8515
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.126900-8.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCnTuQS0bGE47mlaAItiONP2Zf5btvM85AXJX1yO9Qft/y0w
	DNJ4wCZk6lNHl8VwK1a3jvb8YvpYk3GEIy0YVWjb6daZahG7qsYBmvqGKeYuqVfOB6z8Qn2yTOa
	zwMQeqdQQiP6el0D13Ka63aTNKP5lPciQIsk29CyjX0ag3hagYfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDU980qe9xzB3A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.126900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4B8E2FB4A9B1A8B170213312AC791C49623108BB463B70E355BB3B48152D0CA12000:8

T24gRnJpLCAyMDI0LTA0LTEyIGF0IDExOjI3ICswMjAwLCBOaWNvbGFzIEVzY2FuZGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gRnJpIEFwciAxMiwgMjAyNCBhdCAxMDo1MyBBTSBDRVNULCBN
aW5neWVuIEhzaWVoIHdyb3RlOg0KPiA+IEZyb206IExlb24gWWVuIDxsZW9uLnllbkBtZWRpYXRl
ay5jb20+DQo+ID4NCj4gPiBTb21lIGNvdW50cmllcyBoYXZlIHN0cmljdCBSRiByZXN0cmljdGlv
bnMgd2hlcmUgY2hhbmdpbmcgdGhlDQo+IHJlZ3VsYXRvcnkNCj4gPiBkb21haW4gZHluYW1pY2Fs
bHkgYmFzZWQgb24gdGhlIGNvbm5lY3RlZCBBUCBpcyBub3QgYWNjZXB0YWJsZS4NCj4gPiBUaGlz
IHBhdGNoIGRpc2FibGVzIEJlYWNvbiBjb3VudHJ5IElFIGhpbnRpbmcgd2hlbiBhIHZhbGlkIGNv
dW50cnkNCj4gY29kZQ0KPiA+IGlzIHNldCBmcm9tIHVzZXJzbGFuZCAoZS5nLiwgYnkgc3lzdGVt
IHVzaW5nIGl3IG9yIENSREEpLg0KPiANCj4gSSBhbHdheXMgaGFkIHRyb3VibGUgZnVsbHkgdW5k
ZXJzdGFuZGluZyB0aGUgcmVndWxhdGlvbiBidXQgaXNuJ3QgdGhlDQo+IGNvdW50cnkNCj4gY29k
ZSBJRSBzb2xlIHB1cnBvc2UgdG8gYWRhcHQgdGhlIHJlZ3VsYXRvcnkgb2YgdGhlIGNsaWVudCA/
IA0KPiANCkhpIE5pY29sYXMsDQoNClllcywgaXQgaXMuIEhvd2V2ZXIsIGlmIHRoZSB1c2VycyBo
YXZlIHNldCB0aGUgc3BlY2lmaWMgY291bnRyeSBjb2RlDQpiYXNlZCBvbiB0aGVpciByZWdpb24g
dG8gdGhlIGRyaXZlciwgdGhleSBkbyBub3QgZXhwZWN0IHRoZSBjb3VudHJ5DQpzZXR0aW5nIHRv
IGJlIGNoYW5nZWQgYnkgdGhlIGNvdW50cnkgY29kZSBJRSBhcyB0aGUgQVAgY2Fubm90IGJlDQpl
bnRpcmVseSB0cnVzdGVkLg0KDQpCZXN0IFJlZ2FyZHMsDQpZZW4uDQoNCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IExlb24gWWVuIDxsZW9uLnllbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWluZyBZZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMg
fCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIx
L2luaXQuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2lu
aXQuYw0KPiA+IGluZGV4IGVmMGM3MjFkMjZlMy4uM2M5YTVmY2Q2OTI0IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQuYw0K
PiA+IEBAIC0xMzUsNiArMTM1LDEzIEBAIG10NzkyMV9yZWdkX25vdGlmaWVyKHN0cnVjdCB3aXBo
eSAqd2lwaHksDQo+ID4gIGRldi0+bXQ3Ni5yZWdpb24gPSByZXF1ZXN0LT5kZnNfcmVnaW9uOw0K
PiA+ICBkZXYtPmNvdW50cnlfaWVfZW52ID0gcmVxdWVzdC0+Y291bnRyeV9pZV9lbnY7DQo+ID4g
IA0KPiA+ICtpZiAocmVxdWVzdC0+aW5pdGlhdG9yID09IE5MODAyMTFfUkVHRE9NX1NFVF9CWV9V
U0VSKSB7DQo+ID4gK2lmIChkZXYtPm10NzYuYWxwaGEyWzBdID09ICcwJyAmJiBkZXYtPm10NzYu
YWxwaGEyWzFdID09ICcwJykNCj4gPiArd2lwaHktPnJlZ3VsYXRvcnlfZmxhZ3MgJj0gflJFR1VM
QVRPUllfQ09VTlRSWV9JRV9JR05PUkU7DQo+ID4gK2Vsc2UNCj4gPiArd2lwaHktPnJlZ3VsYXRv
cnlfZmxhZ3MgfD0gUkVHVUxBVE9SWV9DT1VOVFJZX0lFX0lHTk9SRTsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgaWYgKHBtLT5zdXNwZW5kZWQpDQo+ID4gIHJldHVybjsNCj4gPiAgDQo+IA0KDQo=

