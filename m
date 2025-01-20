Return-Path: <linux-wireless+bounces-17723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D288A16559
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 03:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D73164E5E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFF46426;
	Mon, 20 Jan 2025 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gMxZLeFG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="athf5OMb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0397DA82
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737339880; cv=fail; b=f/sZA5+tPWszsCq5QeqBBXzFYimymMA/GavvmMbDZyGwXaF8M5sm6YYxjwPhuShR4wYQNbtkJBfWF8P7V/hrwHqQOjTMhqCzG0rBNV15yIaaZ8Wj5xXu9meXr9B/FhpiWCuQManNmf2/pObi0tJ4UOeKyi2k7DV8ULIAL7UqNwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737339880; c=relaxed/simple;
	bh=0NSaLohlhfFRmnqElsbmo6VKqiXsYWF2fL3ezcAp1g8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qiFqw9mf5rlyXi1m7Z6bc16jc58TdgD+h9XoQFwSowf+lXKl7PLicIzfQtBroYx9rUBYlhwxROpOA0vIG6bauHFg8zc1Xl5+bZygN8impquq+7uiI74v2t8j9u0cS4V6t7uKrVEaIbcUUyp3btdtAk17r6ZisxbKSM7gBUtTQ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gMxZLeFG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=athf5OMb; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90f967aed6d311ef99858b75a2457dd9-20250120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0NSaLohlhfFRmnqElsbmo6VKqiXsYWF2fL3ezcAp1g8=;
	b=gMxZLeFGTuhdBs0KvcH5WGzzF1u5XbC0OVXiJiHABAWkHZqoEnLcPmT6VSoZfS/h8+8LRplmhmrSQ9npsBANI+ZesnAVtAj8YM85Dy84Tp8NiNXUzHyQczbBClpjFoRytV5HL2jH5kiIURr8wgTgE7yGbHuiXHHP1qQ405CZ8DI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:77529dd1-f3ba-40d1-b991-a34ed57ef88a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:36712338-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 90f967aed6d311ef99858b75a2457dd9-20250120
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 101229595; Mon, 20 Jan 2025 10:09:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 20 Jan 2025 10:09:21 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 20 Jan 2025 10:09:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUPyTEsF848uqa5tFtVbe39rhlwALUkuKTxuaQM0S5gqmqMTbBWvdiLpVWhEkFQWb+hxEBFQmqFWn0v4vdH6O3GEXRDng57zmhNpAa+T6ZEBPVe7d9NWvDBPIqFBdSuIvZQVZmDtDvq5OxcGQM7gHzMxXlth9AqTpgrfLUiIOkOClnEvjpqoe4JqTOnxJSbvbHrh9iwdVsRKmW5aSvW09lG8wR69Ra97ga36QjII0aDipxooYQo9fcxL5+kTevffvPu8MzCGxqTUGugjfkQshMS7pEizbM2QIJguLYjn7zNyav+Cz7hE0oeTktDEOIYtmGGBkYNAbj7ofetmHzE3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NSaLohlhfFRmnqElsbmo6VKqiXsYWF2fL3ezcAp1g8=;
 b=xnDj7HKyfZTyozIkaB7cMTYhiH7EORGU8XUDIXYQ/PKfvAxXjXJy25Dsayv5hfa+5wGwGV+BJ9cKnCat61eml/QYuNQDmyN/tcUmOv3pnK6iKBre0ljEoJ2QDa5wscqWUxwUrKyy1MRtFtwecck+U5NfPHbDtYErwAxIshhhhY2Ca52BNjKX/r9fhBgk+5r9w4xW/MOgkwUNA/hBoC9jgVZgkpBsCrb7zm9vPdZ6eOK83o53s6EZYgcrL20Lj2TsEy4Hi0dRpAC+F58vdw97L5DTAJhWgGX6WSMiDUi30BrKp4fcOexMfXs6hKnL5aGr14qAR1Rj3tR1grW6eAa6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NSaLohlhfFRmnqElsbmo6VKqiXsYWF2fL3ezcAp1g8=;
 b=athf5OMbgzAlrjfE/49pPyy6U9pnaoZlULUm79eDQAxI4jxZbGGBeSQ1rZ4MK5ebe1c3LT80oItb3XwE/+/nCE/o5lNqCL8vxJhxG5kMRodn6h2lqsTBsABtUN1mVA2Ex6v0dJFXwzcsdmP3j1uEukroWBzUVWakxNzq5191Lyg=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEYPR03MB8453.apcprd03.prod.outlook.com (2603:1096:101:20c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.16; Mon, 20 Jan 2025 02:09:19 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 02:09:19 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
	"nbd@nbd.name" <nbd@nbd.name>, "sean.wang@kernel.org" <sean.wang@kernel.org>
CC: Sean Wang <Sean.Wang@mediatek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Subject: Re: [PATCH v2 2/6] wifi: mt76: mt7925: fix the wrong link_idx when
 has p2p_device
Thread-Topic: [PATCH v2 2/6] wifi: mt76: mt7925: fix the wrong link_idx when
 has p2p_device
Thread-Index: AQHbaY+5Mcr5VnxEUk+inPy/MgcnRrMe7X8A
Date: Mon, 20 Jan 2025 02:09:19 +0000
Message-ID: <e78657506ed20baf151989841a9719227445429e.camel@mediatek.com>
References: <20250114020712.704254-1-sean.wang@kernel.org>
	 <20250114020712.704254-2-sean.wang@kernel.org>
	 <a80fe450-ecd9-462b-af93-2a7ef9a0135e@nbd.name>
In-Reply-To: <a80fe450-ecd9-462b-af93-2a7ef9a0135e@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEYPR03MB8453:EE_
x-ms-office365-filtering-correlation-id: c0e1052f-0c8a-43bb-c03b-08dd38f772e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dy9SZTA4bXZGTGc4K1l6TUJLajNZYlM1QVpOenpTWGtQZVhkemhmQ1M5YmE5?=
 =?utf-8?B?elJpekw2d3c3eXQ5VThveUZUeEc2QU5kQW8rUHZpc2xrUEtEdExXQVZYcmxY?=
 =?utf-8?B?TEpMeFpiL21rM0FaT0VpSWU2YTAybW5mQmF4Yyt6SzQxU0JuZ2dBNi8rWG9U?=
 =?utf-8?B?NmVLNHZyWFZidUhPT0pjZkJFdTVTSi92WkY0M2dSVnR4WmwrSm0xOU5iUlcw?=
 =?utf-8?B?c09TdjE1QU9tb25INnY1VkdrK2tsMHRMK0IrenU4a0x4K2IyQi9SL1pBMzk4?=
 =?utf-8?B?SjdmWjIxa0I5am9Qa3M3a1MwcysxeXQ1VGtLTFdXMXYwc0FKeCtFYU5qM2gz?=
 =?utf-8?B?WkFMU2JiSVpOMldvdVdPeFNyeEVPaDE2NXQwNk5TUDZJdWJPYmJqM0VQekM2?=
 =?utf-8?B?TVlJRFF6OVI3aVJXQ3B1SXFyb0t2NVVOVlh5alE4WkdINHdjL2FzUi9DOWRS?=
 =?utf-8?B?aFNFUTdvWXJrcU1qSHBnVDFpZnNJanRSN29SN3hFeTN0U2M3bTlVYVFVOVFK?=
 =?utf-8?B?TTJIQXlTSzRpc2ZhNE4zWXo0ZVhIcWdtdUNad2ZmcTYwem5PamhGWjd5WTZr?=
 =?utf-8?B?aGJTbkxrNTN6UENReSttUXZmWFNzWnAwRVVBSEZjOVN3cENwY1BzY3M5elFH?=
 =?utf-8?B?aHhnQnlvRlJ2clZIUDNzSGhPbE1rQlhuV2VRbnVEbVp1MUp6bU1sa1Exd2lW?=
 =?utf-8?B?NU1sVkpTZVhQbE1YellzOTM3NnViWHVaaTNnUjJOektIbksrZGNUZ1ZZL2Ny?=
 =?utf-8?B?NjZyRFRBVFBmd0ovTVp5QmhIcTdVUzQ5MW5aeDhJZ0RidEtDWFRvRzhqRFZB?=
 =?utf-8?B?T3Y3UStmK3cvdUV1RGZ0UTVnNllaYVVBWlhLb1Bsc0U1cjdPWU00U3p3YzVY?=
 =?utf-8?B?NVQ3WUZFcmZtTVZ3M1VGVnpRMDF0SDZQYUNZbldxMjRKdmRQQXo2TmdwbEpu?=
 =?utf-8?B?cmVUZnRIZkxWNzRIZktwNmRHeDlna1c2bDNuZzNYOGVjL284ckpkT2krQjhW?=
 =?utf-8?B?b1JhRlRibHN1UmlKWVVHbFcvTE1jVEZreldDQjZjQjkycHloZ3hUM3hqb1Z4?=
 =?utf-8?B?OWJZblJRWHhLQjVxQ3ZTQXo4Y2ZETEZVNE9UYVcrcVBqdnNQYzViVVY2WnZZ?=
 =?utf-8?B?aVUrOVAwY043WFhrVktYMndpSktSbUZsR1BWUnRuWFZkL2IxNmRoTTJzSE5M?=
 =?utf-8?B?VzJkRzFWTXJCS2lKemM1bTFIak9tUkJ5Qmo1aW0vSkJDYmRZOUFqU1Fjam44?=
 =?utf-8?B?dmRqblpPSjBsUENDc3BOL3FhREtoTkpCanRsZE0rVmZWVW5tNENSNzF6S00r?=
 =?utf-8?B?WHBJYjA2bnkxK2Q5b2tXK2dOYjlPV1pnNkhVU0E0MWlFUVlWTy9wa2dna0Fw?=
 =?utf-8?B?cUYwTDlNL3ExTkxrcVA4WnJPYlhabjNrTmY4ZmFYTnZpUXRQNVRCS1E0UEwv?=
 =?utf-8?B?U2R3YW1lbWRZemUvR0F4eGNvMXhtQzg2dWkzNVNEU2pnS25nZ041ZUtsemsx?=
 =?utf-8?B?ajh3cEtqbllBMzJmMDYvZUdsY0pVSEp3anE0Ujh6ZjYxUXI1MXVsNnpPZC9x?=
 =?utf-8?B?QUFYZmsrQ29xbmRhMVNUdEp1VERISGpBYXlhTXlSd3dLUVY2SHY5MG9MRW9U?=
 =?utf-8?B?bk1hT2FjMlp1QlBGVndPWnFXVmZXSnhuK09XVm5pcStkSDF6eG8wQUZRQkNY?=
 =?utf-8?B?RzdGRjJqLzZOUFNVNEpQSzV4cWg0NmFrNlg1UGNGK1JXKzhWcnB4MFBxWTJy?=
 =?utf-8?B?M0JWTXJNTUpuZjZMQmtxd2NEd3VzRGFwMXlSZWZGUGlURVlKZTVuZ0lBRjB3?=
 =?utf-8?B?WWRRQ1VHVWduaFZ1SHltYTFnWmx6b3BUem8xVlROS2dDY3FwSWtSWjRvVjN0?=
 =?utf-8?B?a0JNNnRpQWtzWGYyaU5vVksvNXN2OWM5c3V1YnJyWE85cGplNHdPVUpSeWV4?=
 =?utf-8?Q?xZSGJmXWxvqla5g8772Lsf4Iy/ZjA9zM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkExUldEQkV3TUljSk51dGJkTlZ6Y3FWZTkxUm9KOW5ySFVjMkFhQzh4VkxW?=
 =?utf-8?B?SloyYUE2ZkxsbmRMbng2bGRxMTlGS1RpdnpxNkZDS3pwSnlQVDEwRnd5Ykx6?=
 =?utf-8?B?dEEyT3VwdUR3Q2plVCs0S1poNW5ZUk5DYmxONXN6MG1odTA3TnlYQnF4bkZW?=
 =?utf-8?B?YjhNeUJobDVnVm9YcmdqUGV6aWFvMjducXZlTE1wSzFtQzBUOUdkWWVWNnZH?=
 =?utf-8?B?YXFSTTRuTEN2bjNlNlp1WWQ0cG9EdGh4cGYwT0hKdVV5d1dpZGc2NjBEZm1H?=
 =?utf-8?B?VVVkMVQxRkJ1aU5xTi9TTk1QWFhGckFHYndYM0JLdTUyZjd3dHhvM1ZmeVBL?=
 =?utf-8?B?d2tLTUNHdUVlV1gwUlN1QnpUM0xvZi92VS9sWWkzNGM5WDloejRCYWcxbjVM?=
 =?utf-8?B?YlIrQ3pKN21ub3B1NnlLaDg2c2N6bTNDZzEyQmZhODhvVkZtSGpjM296TFdx?=
 =?utf-8?B?L2Uva1lvYjMxblVGYjZPZENqamFaR2o3Mzd5RHJHdE1rN040TXYvTnd0TG45?=
 =?utf-8?B?WFJhMC9hZWt4NG5FS3g1STZZQjhqd2R0MFNkdklPT3ZvR3M1ZFNscTJkdXc4?=
 =?utf-8?B?MUZoMkV1RjNNUTJoUDhRdXVHUjJxQmdqc2JEMDYvYkpoZ3dKZ2lDTUZSYU5Z?=
 =?utf-8?B?VjlxZVlBVHJjUUtEV1dkME0yVWJUbVA1NWpFUHRHZWRDVUVnalNzM3c3cTBU?=
 =?utf-8?B?RU1TYmNDci9GSTNZSThrQnVLWGEwOXVqZGhnb294M3RUWGZLUEcrVC9aVEhz?=
 =?utf-8?B?bHIyZVRMZUNNZGRqTDMwOEJNY2ZzUTNRYXk4d0ZMMFZ0SDRyc05CdnlGSFFF?=
 =?utf-8?B?b3YxdlE1MWtyamovYUFuVmVPcUhXYXNDeGJnQk5yTVFUaHlDYWtwZXBIcVhE?=
 =?utf-8?B?YmQ4OTNGNFpDN0tSSWIyMFAxN0ZGLzV6RzVVWnNjaEVteXErakhPY3RFTFVZ?=
 =?utf-8?B?NndodXNvZ2RYMDRaOW0rL1ZWZ2ZweEpYRnNlalQzTlZ0VGt3V2NTc1o1dXhD?=
 =?utf-8?B?UVR4KzhKbDRzbFcvaTdEaTAyUUhhMVpmcGxzYy9GNTZ4TFdCdnlWdm5TMVBy?=
 =?utf-8?B?akwrMmZwSjVmcnBMRGlhaEl3NDd1N1FpT3REUHc2WENrSllmQnQ5cnBxTytq?=
 =?utf-8?B?TmtzS1dqUnFiNWlpRUtNUjZuV2Q2OWRWd040UnhVS0N6aUJnOXhXMXdHTzlZ?=
 =?utf-8?B?RkNQdlJBTWd0dU9CZ0NMckJKOVZhYjZaY2dkTFZvNGNBSUhVbGlvR0t4UU5r?=
 =?utf-8?B?dXBJNWx6VElIQ1h4dEQvY2wvZFVvSUdFeGVoc3RKRzhJTE82MUFWSWozUHJT?=
 =?utf-8?B?cGFCbzgyVVdmTjMwd214OS9MbXpxM2JrUTN3aDJTNFRtdkhkTnMrc3VBaEFp?=
 =?utf-8?B?RkYxOUd1Nk9kcjNVYVhTanpTV3pkUmVVM091UXg0bXlNN1Z5M2dVNWF5ekU5?=
 =?utf-8?B?aEtMUCtrc0x2S2lzSHZtbURhbi9PaEVTWGZJb1RYRy83UFNsZUJoK3Y5c2gr?=
 =?utf-8?B?amhIYTV1VjNlWW5YNzFYVFRndDAvblhsd1g1QzhWbHJRU1JCRnhCd0RENDhr?=
 =?utf-8?B?YmtIVitNZTQxaDZRWGh0Z2UzYURSN3IzY1BwbDRVMzBVMXhISUVYSXJ0NmEz?=
 =?utf-8?B?M29oTVAzQ01PbHkrYjBLQ2t3T1ExNzlDUTkvbkQzdDhYODlWTGREUDBhQ0o1?=
 =?utf-8?B?T0dXYlRXQ1lMWkVXcDR6a1RoNEY0N0FwOWdQaTcwUjJ6M3hEZGVJWlhPcXhw?=
 =?utf-8?B?dll6cEo3NFZoYlUzSFNSZmhpeWU4OVRJMzkyMGM5UDhPbXFPSnJ2b0Nrd1Jt?=
 =?utf-8?B?TnRmZmV2UXNRd1c5OE1zM1dCbWtyVHBQOHhWUFFKWVRTVjl2ZnRaWHltNUZr?=
 =?utf-8?B?RExjK1lESDAxdENZQlRKQ1VUVWhGQWRiM1M3dmg0a2VPL0lGUnJrdFdpT28y?=
 =?utf-8?B?MFlLOTFmbzk1ZXBNbHpnK0RFb2E5MTdOd2RNUi9ZMHk4TEozNTV5V3orZUNY?=
 =?utf-8?B?eVlFNVZySm1FVnJ2YjdtQjZEZm1sMllYZVJudjk3YWFwaTRCeEVsM2s1dzNt?=
 =?utf-8?B?aWtpcVM4b3puQXVjdGxpSGt2M1pJMDFESHBVN3Vwb2tEaWdNeFhxVnJKNlM1?=
 =?utf-8?B?Rnp1UGxxbDRTcDR3MWRZallBREcrWTBUUGx1cVQ2am9VQjlpSE5vejRRQ0Q4?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE27E8ECA1CA7A47AE655C505843DF22@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1052f-0c8a-43bb-c03b-08dd38f772e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 02:09:19.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHPLElVwBE9O1U/cWcq9LKCZ+5OoClF2Ly2u0C2Yk2/Ir953vlQOU3/RiB0WYFI2iubtQDw/PdYZ5+IpnHzouJzEuw+3nBQFNmMpTckhcNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8453

T24gU2F0LCAyMDI1LTAxLTE4IGF0IDEwOjU3ICswMTAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAxNC4wMS4yNSAwMzowNywgc2Vhbi53YW5nQGtlcm5lbC5v
cmfCoHdyb3RlOg0KPiA+IEZyb206IE1pbmcgWWVuIEhzaWVoIDxtaW5neWVuLmhzaWVoQG1lZGlh
dGVrLmNvbT4NCj4gPiANCj4gPiBXaGVuIHRoZSBwMnAgZGV2aWNlIGFuZCBNTE8gc3RhdGlvbiBj
b25jdXJyZW50LCB0aGUgcDJwIGRldmljZQ0KPiA+IHdpbGwgb2NjdXB5IHRoZSB3cm9uZyBsaW5r
X2lkeCB3aGVuIHRoZSBNTE8gc2Vjb25kYXJ5IGxpbmsgaXMNCj4gPiBhZGRlZC4NCj4gPiANCj4g
PiBGaXhlczogZTM4YTgyZDI1YjA4ICgid2lmaTogbXQ3NjogY29ubmFjOiBFeHRlbmQNCj4gPiBt
dDc2X2Nvbm5hY19tY3VfdW5pX2FkZF9kZXYgZm9yIE1MTyIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
TWluZyBZZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2
MjogZ2VuZXJhdGUgdGhlIHBhdGNoIGJhc2VkIG9uIHRoZSBsYXRlc3QgbXQ3NiB0cmVlDQo+ID4g
LS0tDQo+ID4gwqAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmjCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKgIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc2X2Nvbm5hY19tY3UuY8KgwqAgfMKgIDQgKystLQ0KPiA+IMKgIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21haW4uY8KgwqAgfCAxNA0KPiA+ICsrKysr
KysrKystLS0tDQo+ID4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyNS9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTI1L21haW4uYw0KPiA+IGluZGV4IDIwODJlMzkwNGQ3Ni4uNTAyYjc2
YTQwY2E4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTI1L21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTI1L21haW4uYw0KPiA+IEBAIC0zNzEsNiArMzc2LDcgQEAgc3RhdGljIGludCBt
dDc5MjVfbWFjX2xpbmtfYnNzX2FkZChzdHJ1Y3QNCj4gPiBtdDc5MnhfZGV2ICpkZXYsDQo+ID4g
wqDCoMKgwqDCoCBtY29uZi0+bXQ3Ni5iYW5kX2lkeCA9IDB4ZmY7DQo+ID4gwqDCoMKgwqDCoCBt
Y29uZi0+bXQ3Ni53bW1faWR4ID0gaWVlZTgwMjExX3ZpZl9pc19tbGQodmlmKSA/DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAgOiBt
Y29uZi0+bXQ3Ni5pZHggJQ0KPiA+IE1UNzZfQ09OTkFDX01BWF9XTU1fU0VUUzsNCj4gPiArwqDC
oMKgwqAgbWNvbmYtPm10NzYubGlua19pZHggPSBod2VpZ2h0MTYobXZpZi0+dmFsaWRfbGlua3Mp
Ow0KPiA+IA0KPiA+IMKgwqDCoMKgwqAgaWYgKG12aWYtPnBoeS0+bXQ3Ni0+Y2hhbmRlZi5jaGFu
LT5iYW5kICE9IE5MODAyMTFfQkFORF8yR0haKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG1jb25mLT5tdDc2LmJhc2ljX3JhdGVzX2lkeCA9IE1UNzkyeF9CQVNJQ19SQVRFU19UQkwN
Cj4gPiArIDQ7DQo+IA0KPiBXaHkgYXJlIHlvdSB1c2luZyBod2VpZ2h0MTYgZm9yIHRoZSBsaW5r
IGlkeD8gVGhhdCBkb2Vzbid0IG1ha2UgbXVjaA0KPiBzZW5zZSB0byBtZS4gU2hvdWxkbid0IHRo
ZSBhY3R1YWwgbGluayBpZCBiZSBwYXNzZWQgaGVyZSwgb3IgaXMgdGhhdA0KPiBpbmRleCB1c2Vk
IGluIHNvbWUgb3RoZXIgd2F5Pw0KPiANCj4gLSBGZWxpeA0KDQpIaSBGZWxpeCwNCg0KVGhlIGxp
bmtfaWR4IHRlbGxzIGZpcm13YXJlIHdoaWNoIGxpbmsgaW5kZXggdGhpcyBpcyBmb3IgdGhlIE1M
RCwgYW5kDQppdCBkaWZmZXJlbnQgZnJvbSBsaW5rX2lkLiBUaGVyZWZvcmUsIGVhY2ggdGltZSBh
IGxpbmsgaXMgYWRkZWQsDQpyZWdhcmRsZXNzIG9mIGxpbmtfaWQsIGxpbmtfaWR4IG5lZWRzIHRv
IGJlIGluY3JlbWVudGVkIGJ5IDEuDQoNCi0gWWVuDQoNCg0K

