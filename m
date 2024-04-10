Return-Path: <linux-wireless+bounces-6088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AE89F1EB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71DF1C23170
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139DA13D607;
	Wed, 10 Apr 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dIC4kJza";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vFti5hof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98315B136
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751646; cv=fail; b=fZlj3KiH32FLp6o0xIbXiQSsCeHKD3KRTiNdOf0mGGTWmOJyoBrCcm7poxIcZb+w2vE9JDYWko+ok+7ax5sAy9nkOWDVzhstTP2w5nAvNUtRbOrzjK6WaDbeMIDI0zoInLB6H9ifOW5dBCs9mN8KSjRqmTKu5Ji2XfPnmRFecX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751646; c=relaxed/simple;
	bh=gnAIvkIZEpMQ81ZUkqNXzgHemACIXp3pfakKUO3HWH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YSUYypfS9pJAbMV8o6szZhXu13lasxlwgWfiT4ZPCZANNighgXfyQ9ZmZ7DdT+X63S64YICQsspOuYgD+PGyRTedz+AHjyo35xEXK9Gh8ajFS4hME9eL4NKZrrcN8mCuDNg3FzyDTGtN00nYgGxJqZ1TC3Ul+GcIaXPfZqxExhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dIC4kJza; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vFti5hof; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bcf2a4eef73411ee935d6952f98a51a9-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gnAIvkIZEpMQ81ZUkqNXzgHemACIXp3pfakKUO3HWH0=;
	b=dIC4kJzar0mdEpCFTcOatXqgicI5qS75Ovtky8I6noF1nL/C7F0b6KmVaFwWweag+q/Tyj0AWQ+Yyi+gsxsDZ8qEiVHyHgJS4dGMs8Wk21oSAQK0YfTlLwEsLcoSIIGIJI0Kn7vjhoI1qOwFUXBPFx4GKqOdsWwSQaTBYAvIkKk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5b13b56b-f4ee-4584-a257-5e3cf4cc9212,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:afdd6a91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bcf2a4eef73411ee935d6952f98a51a9-20240410
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 964298743; Wed, 10 Apr 2024 20:20:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 20:20:35 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 20:20:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/MTMMsRwxAjX+e97S3G7byOnLTZtoPkL3aTk9IK9aB4t4dO45yf9naME5PcX/ee7FGR4KOnVkqJ+GXuBO0dScPA5CuNZjMOj61pNFQYj6baCsZh7/cNn3ZwCVj2o3ICQKMoj3rB1v8ELCLwb6WZM1soxhq/etZGYUXjqBaCxulyCObl6KVY1LswJBPsibYdIhv5IdaZQGlstdOXVAHHkkNMnMGoCZyoivx4GsZ3sxIFR3loiyhsf8iJfjWbY8NGJgDThqwX5MvxMJ2GJJjuYkjiRO7FJgGtkvezHEjdcFpHkQ2/j2moclj3W2HTCQhtaweGe88dWgeRDcFOwro0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnAIvkIZEpMQ81ZUkqNXzgHemACIXp3pfakKUO3HWH0=;
 b=j8JCMsXCb3fDyo7BfI47HGFDGG/YqevFcpoUBEu+BHDSD8rQpNPd3xmF25v7MojaJiyF/CVHvvNniB+zVS4Ktgi3EWl5tlJKx+cQdM1iyifpVdlFVkDRKfHf7Vmbqak2xtRsDHZK84jT1kJtvVlP5EJkD2jp7ErBT2u577qyd/MmAchJ6kVFRvXoLEsAZ3z/6S6P5JL9LpEHMxVow/YVuqZ/AvgLRnKGJAKkjBPl6NmwAp7PwnY0Oeg8xmeUnGWStttqZ6bQXaU1GdV9AlhYhi6ur59K+1bXE+/jaKAA4602OVWFIujHwmXDv9cV3Ag74lIc5hVEZvClP6hs0WDxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnAIvkIZEpMQ81ZUkqNXzgHemACIXp3pfakKUO3HWH0=;
 b=vFti5hofJHwibtfh6OkXJ4hWskYqjqL6jmpJrGZUSWtQ5TAnkPwmwFxVLBuXw5X77HFZPUThmY+k/PSuku1grXfqx0qBgr6YqbrNm1fNCjyy3l5W0puY50MT9SMlEjaouh5YE2Ea+NFpUWcM2vdViaO4IwuPh8qjV/1uh/ea3u4=
Received: from SEYPR03MB6458.apcprd03.prod.outlook.com (2603:1096:101:3f::8)
 by TY0PR03MB8222.apcprd03.prod.outlook.com (2603:1096:405:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Wed, 10 Apr
 2024 12:20:33 +0000
Received: from SEYPR03MB6458.apcprd03.prod.outlook.com
 ([fe80::190b:9e74:203a:455a]) by SEYPR03MB6458.apcprd03.prod.outlook.com
 ([fe80::190b:9e74:203a:455a%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 12:20:32 +0000
From: =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2hlbmd4aSBYdSAo5b6Q6IOc5ZacKQ==?= <shengxi.xu@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?SGFvIFpoYW5nICjlvKDmtakp?= <hao.zhang@mediatek.com>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921e: add LED control support
Thread-Topic: [PATCH] wifi: mt76: mt7921e: add LED control support
Thread-Index: AQHaiyQB7NgCHqSOGU+PTzbTmq4SRLFhTtGAgAAd3IA=
Date: Wed, 10 Apr 2024 12:20:32 +0000
Message-ID: <48ad87ce5300a8c1570c5ec244f5b5773386538c.camel@mediatek.com>
References: <b376f88ab9fd69a5e4ba4bbd2c9fff3ef53b8968.1712735769.git.quan.zhou@mediatek.com>
	 <ZhZrAyc84-VCdrdw@lore-desk>
In-Reply-To: <ZhZrAyc84-VCdrdw@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6458:EE_|TY0PR03MB8222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9fCe3wRmasAqi0S6RF9948PppwtM6pT2Di802CGZqUgamRYOtwT3VaGY+GDCmbRIGAkIv4BSj+iBozj9j52yjEbNjqT7Lm1fEevRSIZ2TCDXQaY/4UI/AaUZ2Z11NUnxp4eTSGqlgCPm/uomFHmV3MaCJH0OWlI+aCaYNHWRdToOKRn7Su7tcYV5VRm6OkwqdOwPN3GlWI9r/Hfy4c9LIM8/TfGFFOL9JYuCekr1xH1AgK76ayu/+pjnb7+O4QFsyA7K7e9X0VYUjCYtmh71hPG7teN5IQA0X4UWR2NlKfoqRdJK2fuNIFQT+6OAaYbjydYSJqtg16yGDuZ7VASEWhxoAYYBBnwTXBe1sUPFMqKRWJF9MQPl/EqRI03b22K4+F7HGyZZ/qo9GP6KGso+c+Y5bAIVP/tnK33wZFaMuv6CnojEPopIKkFSF76xBK7JeqqmVI7Zi9n7Wy8K8L9XY6owxeyFRvqZkK5tkzicB6zrkqPCC8N4IyuZsfwBAc0AqKwjoBitflFcZKC/OXC4p5S/ZE34kek2Tvn2e2lxDVdSCJ042bK4+HZOOyx/UejhtMWZtJywARX3EauXnorpIuxfW1FSAcNXWaDSOZi2n7EuJqxxAqdrYH8qCBAnzW4DPWhhN59WCAi1sHlKOsCGScIP4LDmieNTIIZ1zHGLiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6458.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1RiOTV0eHpPQW43N3BYZy9zTXR6L0JqclR2Q2VhZEF5U0RadmpHWkZPVjI4?=
 =?utf-8?B?V05WWXRRMHJnbjJDZFVjSVBlMGpYbktnU0VWMW5hbHZwdmJLdk56RWZDckVH?=
 =?utf-8?B?d0YvWFFRMGpuTUJsRXhTWHh3citHeHFpM2VZMGlSbVRjRzFPdUpNY2hwOS9T?=
 =?utf-8?B?ajBZZnI4TkNIcEVFMW5Oa0F5MDlKb1R3RnNvWW5BMnFTc2RKeVkwbElPTXg1?=
 =?utf-8?B?TGNNdEZKTmFrejEzYkZGTGtqYW9WRFVXMnV4YlNkTTFCSnAzMUdrMHVpdlg5?=
 =?utf-8?B?Q0JadHkxa2hlNVVqZm1uZ2VGNVVyTWYrbGQ1NHVmOW9IKytReVNEQW1yem9N?=
 =?utf-8?B?Nnc4UEQvbW5vMnBBTXZZcXlWMXRnSlZ4U2F6ZUQ1R2s3bVRjVEYyK1FUZ0lG?=
 =?utf-8?B?RDZsZ0N1NWNXaHE4YkFjeDJLK0NpZmVvMTdSNmkwbUNJcUVaK3Zna3ZGaENy?=
 =?utf-8?B?Zm5CTGtJdTNNNG1IRmtKc1lIQnpZeDllbERHcEdjQUs0VmR2clZoVC9ETm1I?=
 =?utf-8?B?b0ZKTzJlYXVRZmp4cG1uZit0VzZUaVI1dnkyMldRNWtlN3c0SkR3ekcydHNF?=
 =?utf-8?B?WGJHdE16UENsNjNOZlY5S1J6ODR0bndQRXo1dEJ0dHp6Tm5Dcm81ekZ1MEo3?=
 =?utf-8?B?N3pzSFJFUE15WEloZFNmc2xDWENOOTFuS2pLNDEyb3hyKzVCcml2U0hHeUh2?=
 =?utf-8?B?OU96UDljWEZpWE5hODkxSXAxK25PYnJOdTlKcDFtajNFMEg4eFVKQUNIRmhi?=
 =?utf-8?B?V0hNZXlkUzJKRWFvVFJuZTJqNk43cGYxRWJ5WkNKRGJxeFR4Ym91aHV6Y0ly?=
 =?utf-8?B?d05zVDVrK1I4eHZPai9kSE43R29vSHlCVnpaZzNOZ3JxdXhEWGd0aGJiMDRH?=
 =?utf-8?B?T01OMURvLy9QNzV1b0Fmd0xvbzNSVXJrckdQUHVSTGIvYkF2QW0wd1pRU2c2?=
 =?utf-8?B?aExheWRwaE9BMnhadUtELyt3UFpRemNFU2Y2WXZreXBhQXhreUxGdDc1UnIr?=
 =?utf-8?B?QW9lSXFXbjBpZ0NvUmlCdkNMUmVJTzRZRmdEY2ttVFlTQXZ3S2oyQVFoRm1U?=
 =?utf-8?B?YTZVZzZMYi9sV1JsU0JMcDd5SzJsUW9TZTBoZmU5UVM0dWNHN3BDNHgyRVZZ?=
 =?utf-8?B?VzBDZWNjSVhMQ0lQV1hkd0VCVjQxV3cyU0RzUHQwTGJTcitqdDFOK3lOMW9W?=
 =?utf-8?B?MXFzNWMxalVpVG40bWhRYmQ1bHpvTlQzY3poMzFkTHR3WUkrYlg1bHVtV3NM?=
 =?utf-8?B?Mzc2TGY5TWxJRXAzMlJ0TE1FZHVMTXZjU1llSjd4Vm5WWDlOd0pscXFBUWty?=
 =?utf-8?B?MXhkS1pYSjB6VlNBSXZNcHZodGJhQVV0TnZHcVJxRlhER3FlNENpeHBpWjc3?=
 =?utf-8?B?WUdnZkgzbHFjQktBRjJRQVV3N0VNZTZHUTkwYUdvZDdncXhDUzZ3a1NPckl3?=
 =?utf-8?B?YjByOWRadVZxT2ZEYldwZWJJTnBkdi9PSU0zeUI0MGc4OXRZbHFia1dUMTI5?=
 =?utf-8?B?WVFJN28wYWJFY1NwaG5xQ3pCS3ZjVHlIV1RkNDNvUUdmWVZlRWE5c3kyNy9N?=
 =?utf-8?B?cXBLQWo1Z05XUjBGSnZOZFBjNEw5S25JamFzKzRFUTJ3dW5jN0h3NHdTcFBk?=
 =?utf-8?B?aVdrbHluQUgzZUR4Yk1DM2w3WGpiWWZ1emJMZERra01QOVNtSi9zd3ZFcGxO?=
 =?utf-8?B?NENqODNvc0Jnem1hTmJYZ0xHU05SQlFDUlhkZWRDMTZITUJmS1ZYc0ZtNjZC?=
 =?utf-8?B?TThKUm5iN3R5REFzR1pOdlBpd0wyWTIvdjUydUV3dmJScmVPNUlyaVkrSG9E?=
 =?utf-8?B?OFozODdRd0lISUFHVE1aTmZNTWNIWStvRjV2aHlFdlFZMUppQ29SRnhPSFZV?=
 =?utf-8?B?OStXVHRucEI5emxIbEkwTkU1VHFSVHUwRTVBNENYSS9ZMXRQaXZxbmlrM2pS?=
 =?utf-8?B?ditPMnc1NGpjN1pvakNsa1BHNmRPVFVpbG5YRVdmS3YxTlZ1c2VCTTA0blBL?=
 =?utf-8?B?Qy8vYnZ1M1V2clpjUTJrVlZvcndibWFrMWdTZHlOU003bWZTYStIMmhHNVlW?=
 =?utf-8?B?OHhNTkFiWEw2Wmx5RXY0V1JZYWY5T1p3NHVKTVozd1VrUzBqSE95eXp1bys1?=
 =?utf-8?B?OEp4NFpnWjU3UmY3ZkxoL3N5MGsyN0NPVG56SDBtcVpOdnp0YmhFcmlJZk5I?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3F950DFA0C8D3429767EA03B998930D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6458.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6210c4e3-9ec7-4abc-3c06-08dc59589e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 12:20:32.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/Fvc7tRO3ZZ4QRrdvwKax1cdeWUWWjI1IsyJcKv7fsqrvmgr7cB9J4BHTkJN5F6XkMo4heMGuHiQWTz0wQCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8222
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.834500-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2oOwH4pD14DsPHkpkyUphL9VBDQSDMig9Ge9toQ6h6LE0FN
	G6vV64NpC3tMAbhhY4SfR2+W+tanuoGYvzkYfp6g9Ib/6w+1lWS+1Vx7rDn4r/ytJo0tuXDqh29
	kdZ+JxXdsNPKrZkKuML4tP830vR4AFf/x8BvK8guO0rt0LpQGeV67veYUroY0DpCUEeEFm7BXQY
	ER+P7Zakbn+FZ7ZFjV0z4+eHYBmhFc+NzN6CaS/uG5dRZCgxC3v5TUKBVkwSqbKItl61J/yfmS+
	aPr0Ve8SXhbxZVQ5H/3FLeZXNZS4KBkcgGnJ4Wm4ZMr7sRSd0wSsAUTh4cNG3YoVFUWNaJzuANS
	42AAe+5+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.834500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	18A446ED8C5E10AA8FB9F57B3428FCDFFCC9D8264785D82B8C203F64568254A32000:8
X-MTK: N

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDEyOjMzICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIHZvaWQgbXQ3OTIxX3N0b3Aoc3RydWN0IGllZWU4
MDIxMV9odyAqaHcpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdDc5MnhfZGV2ICpkZXYgPSBtdDc5
MnhfaHdfZGV2KGh3KTsNCj4gPiArCWludCBlcnIgPSAwOw0KPiA+ICsNCj4gPiArCW10NzkyeF9t
dXRleF9hY3F1aXJlKGRldik7DQo+ID4gKwlpZiAobXQ3Nl9pc19tbWlvKCZkZXYtPm10NzYpKQ0K
PiA+ICsJCWVyciA9IG10NzkyMV9tY3VfcmFkaW9fbGVkX2N0cmwoZGV2LA0KPiA+IEVYVF9DTURf
UkFESU9fT0ZGX0xFRCk7DQo+ID4gKwltdDc5MnhfbXV0ZXhfcmVsZWFzZShkZXYpOw0KPiANCj4g
eW91IGNhbiBhdm9pZCB3YWtpbmcgdGhlIGRldmljZSB1cCBoZXJlIGlmIGl0IGlzIG5vdCBhIHBj
aSBvbmUsDQo+IHJpZ2h0Pw0KPiANCj4gUmVnYXJkcywNCj4gTG9yZW56bw0KPiANCkhpIExvcmVu
em86DQoNClllcywgbm8gbmVlZCB3YWtlIGRldmljZSBpZiBpdCBub3QgcGNpZSBvbmUsDQpJIHdp
bGwgZml4ICYgcmVzZW5kLg0KDQpCLlINCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJcmV0dXJuOw0K
PiA+ICsNCj4gPiArCW10NzkyeF9zdG9wKGh3KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGlj
IGludA0KPiA+ICBtdDc5MjFfYWRkX2ludGVyZmFjZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywg
c3RydWN0IGllZWU4MDIxMV92aWYNCj4gPiAqdmlmKQ0KPiA+ICB7DQo+ID4gQEAgLTEzNzIsNyAr
MTM5Niw3IEBAIHN0YXRpYyB2b2lkIG10NzkyMV9tZ2RfY29tcGxldGVfdHgoc3RydWN0DQo+ID4g
aWVlZTgwMjExX2h3ICpodywNCj4gPiAgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9vcHMgbXQ3OTIx
X29wcyA9IHsNCj4gPiAgCS50eCA9IG10NzkyeF90eCwNCj4gPiAgCS5zdGFydCA9IG10NzkyMV9z
dGFydCwNCj4gPiAtCS5zdG9wID0gbXQ3OTJ4X3N0b3AsDQo+ID4gKwkuc3RvcCA9IG10NzkyMV9z
dG9wLA0KPiA+ICAJLmFkZF9pbnRlcmZhY2UgPSBtdDc5MjFfYWRkX2ludGVyZmFjZSwNCj4gPiAg
CS5yZW1vdmVfaW50ZXJmYWNlID0gbXQ3OTJ4X3JlbW92ZV9pbnRlcmZhY2UsDQo+ID4gIAkuY29u
ZmlnID0gbXQ3OTIxX2NvbmZpZywNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbWN1LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTIxL21jdS5jDQo+ID4gaW5kZXggOGI0Y2UzMmEyY2QxLi4yZWJm
MGZmZTc4ZDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MjEvbWN1LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkyMS9tY3UuYw0KPiA+IEBAIC02MDYsNiArNjA2LDIwIEBAIGludCBtdDc5MjFf
cnVuX2Zpcm13YXJlKHN0cnVjdCBtdDc5MnhfZGV2DQo+ID4gKmRldikNCj4gPiAgfQ0KPiA+ICBF
WFBPUlRfU1lNQk9MX0dQTChtdDc5MjFfcnVuX2Zpcm13YXJlKTsNCj4gPiAgDQo+ID4gK2ludCBt
dDc5MjFfbWN1X3JhZGlvX2xlZF9jdHJsKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYsIHU4IHZhbHVl
KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgew0KPiA+ICsJCXU4IGN0cmxpZDsNCj4gPiArCQl1OCBy
c3ZbM107DQo+ID4gKwl9IF9fcGFja2VkIHJlcSA9IHsNCj4gPiArCQkuY3RybGlkID0gdmFsdWUs
DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCXJldHVybiBtdDc2X21jdV9zZW5kX21zZygmZGV2LT5t
dDc2LA0KPiA+IE1DVV9FWFRfQ01EKElEX1JBRElPX09OX09GRl9DVFJMKSwNCj4gPiArCQkJCSZy
ZXEsIHNpemVvZihyZXEpLCBmYWxzZSk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwo
bXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybCk7DQo+ID4gKw0KPiA+ICBpbnQgbXQ3OTIxX21jdV9z
ZXRfdHgoc3RydWN0IG10NzkyeF9kZXYgKmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYNCj4gPiAq
dmlmKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbXQ3OTJ4X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3
OTJ4X3ZpZiAqKXZpZi0+ZHJ2X3ByaXY7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL210NzkyMS5oDQo+ID4gYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9tdDc5MjEuaA0KPiA+IGluZGV4IDMwMTY2MzZk
MThjNi4uMDcwMjNlYjllNWI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTIxL210NzkyMS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbXQ3OTIxLmgNCj4gPiBAQCAtMjcsNiArMjcsMTAg
QEANCj4gPiAgI2RlZmluZSBNQ1VfVU5JX0VWRU5UX1JPQyAgMHgyNw0KPiA+ICAjZGVmaW5lIE1D
VV9VTklfRVZFTlRfQ0xDICAweDgwDQo+ID4gIA0KPiA+ICsjZGVmaW5lIEVYVF9DTURfUkFESU9f
TEVEX0NUUkxfRU5BQkxFICAgMHgxDQo+ID4gKyNkZWZpbmUgRVhUX0NNRF9SQURJT19PTl9MRUQg
ICAgICAgICAgICAweDINCj4gPiArI2RlZmluZSBFWFRfQ01EX1JBRElPX09GRl9MRUQgICAgICAg
ICAgIDB4Mw0KPiA+ICsNCj4gPiAgZW51bSB7DQo+ID4gIAlVTklfUk9DX0FDUVVJUkUsDQo+ID4g
IAlVTklfUk9DX0FCT1JULA0KPiA+IEBAIC0xOTYsNiArMjAwLDcgQEAgaW50IG10NzkyMV9tY3Vf
ZndfbG9nXzJfaG9zdChzdHJ1Y3QgbXQ3OTJ4X2Rldg0KPiA+ICpkZXYsIHU4IGN0cmwpOw0KPiA+
ICB2b2lkIG10NzkyMV9tY3VfcnhfZXZlbnQoc3RydWN0IG10NzkyeF9kZXYgKmRldiwgc3RydWN0
IHNrX2J1ZmYNCj4gPiAqc2tiKTsNCj4gPiAgaW50IG10NzkyMV9tY3Vfc2V0X3J4ZmlsdGVyKHN0
cnVjdCBtdDc5MnhfZGV2ICpkZXYsIHUzMiBmaWYsDQo+ID4gIAkJCSAgICB1OCBiaXRfb3AsIHUz
MiBiaXRfbWFwKTsNCj4gPiAraW50IG10NzkyMV9tY3VfcmFkaW9fbGVkX2N0cmwoc3RydWN0IG10
NzkyeF9kZXYgKmRldiwgdTggdmFsdWUpOw0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSB1MzIN
Cj4gPiAgbXQ3OTIxX3JlZ19tYXBfbDEoc3RydWN0IG10NzkyeF9kZXYgKmRldiwgdTMyIGFkZHIp
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTIxL3BjaS5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzky
MS9wY2kuYw0KPiA+IGluZGV4IDBiNjliMjI1YmMxNi4uZjc2OGU5Mzg5YWM2IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL3BjaS5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvcGNpLmMN
Cj4gPiBAQCAtNDI3LDYgKzQyNywxMCBAQCBzdGF0aWMgaW50IG10NzkyMV9wY2lfc3VzcGVuZChz
dHJ1Y3QgZGV2aWNlDQo+ID4gKmRldmljZSkNCj4gPiAgCXdhaXRfZXZlbnRfdGltZW91dChkZXYt
PndhaXQsDQo+ID4gIAkJCSAgICFkZXYtPnJlZ2RfaW5fcHJvZ3Jlc3MsIDUgKiBIWik7DQo+ID4g
IA0KPiA+ICsJZXJyID0gbXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybChkZXYsIEVYVF9DTURfUkFE
SU9fT0ZGX0xFRCk7DQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiArCQlnb3RvIHJlc3RvcmVfc3Vz
cGVuZDsNCj4gPiArDQo+ID4gIAllcnIgPSBtdDc2X2Nvbm5hY19tY3Vfc2V0X2hpZl9zdXNwZW5k
KG1kZXYsIHRydWUpOw0KPiA+ICAJaWYgKGVycikNCj4gPiAgCQlnb3RvIHJlc3RvcmVfc3VzcGVu
ZDsNCj4gPiBAQCAtNTI1LDkgKzUyOSwxMSBAQCBzdGF0aWMgaW50IG10NzkyMV9wY2lfcmVzdW1l
KHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2aWNlKQ0KPiA+ICAJCW10NzZfY29ubmFjX21jdV9zZXRf
ZGVlcF9zbGVlcCgmZGV2LT5tdDc2LCBmYWxzZSk7DQo+ID4gIA0KPiA+ICAJZXJyID0gbXQ3Nl9j
b25uYWNfbWN1X3NldF9oaWZfc3VzcGVuZChtZGV2LCBmYWxzZSk7DQo+ID4gKwlpZiAoZXJyIDwg
MCkNCj4gPiArCQlnb3RvIGZhaWxlZDsNCj4gPiAgDQo+ID4gIAltdDc5MjFfcmVnZF91cGRhdGUo
ZGV2KTsNCj4gPiAtDQo+ID4gKwllcnIgPSBtdDc5MjFfbWN1X3JhZGlvX2xlZF9jdHJsKGRldiwg
RVhUX0NNRF9SQURJT19PTl9MRUQpOw0KPiA+ICBmYWlsZWQ6DQo+ID4gIAlwbS0+c3VzcGVuZGVk
ID0gZmFsc2U7DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0K

