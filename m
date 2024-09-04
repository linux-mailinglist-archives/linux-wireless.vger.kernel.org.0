Return-Path: <linux-wireless+bounces-12467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4596B57B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DF8286A76
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5981CCEC8;
	Wed,  4 Sep 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s0lh+k25";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="R0BP5gus"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205341CCEC7
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439861; cv=fail; b=dJM+c7wy2qjdpDxZAqFsBbhSX0X+AhiMuX0VNez747XVf8W/RTFWmp49ibM8sli7lTIWIHYzwsxbBWuYS9R6QFH82CGIYQAdPCjAL4b8DaY3anCfMkp/18HbOdM4ukHaQF9dDj7wW4eXhc4LeApicBuBUJFuvrNM6z8JI3bhU4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439861; c=relaxed/simple;
	bh=L0FiaKpnRvaZM53MsdCGPtBwHmfqeqUVU9b13D3xLOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0Z341IrdLedzvNW7itxDB8PoAUJIjFgHOTFR4vQN93AiKlBX0bXCkYkACa/F7/8JPS5RAuF00AqEj3mL2ezy3lLG9fSONR7bviJqev02zYZW1CSeaXQeAZJrOyWl+d28cTvjjX6+KpWkVKTIo32NFN+iAaVXb6vAhCaJuDbXW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s0lh+k25; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=R0BP5gus; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: caa5b37c6a9a11ef8b96093e013ec31c-20240904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=L0FiaKpnRvaZM53MsdCGPtBwHmfqeqUVU9b13D3xLOE=;
	b=s0lh+k258l1WQvR3TMz2fAw1w1OTvZfFuq8ozGVcwbenAJ03+ySZQgbm89AapxGKYbFFlLtHOnQbfRCcnUEobLtGGf62S+WEV+KAwLXOWI+EIa1wTTQWarotO5n9PiraolN2kfoSa646lOSr/3UwbQCdNuKNERY1j2+oeXtMNso=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:40474d82-efb1-405f-803d-8529e0cb273e,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:6dc6a47,CLOUDID:8a70accf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: caa5b37c6a9a11ef8b96093e013ec31c-20240904
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 892120464; Wed, 04 Sep 2024 16:50:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Sep 2024 16:50:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Sep 2024 16:50:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWbxiPXMzkeS/p9W6vshxCothtEMXZGoiYQ1uFrJU+7YPR94Qla8dC+/HVtBgVrV8rDJfd3QUUsoI/98YZvoGcbQ7JeM46IS64Sr5hCvEo1WV6iKr17BzwUoWqwDEXSJldN6hun4b3tcE8L36X18WLUMTqYETQMyJS4qGod4rRrM+1jH8VkVX5Wz+FUCE9buKJ3HVQRWe3ke5SotixYloAZSvPWcndaRubr++XqlzZyWXZifBnn2GOmKuzTHSRiReqaVCWA5Bzh6TNVZfhB+4yDCSWQS/9MApQRplT1wKxdGtODPDgiOyAv/tY6/UJr3OTmbK43Pui4oBynTw9aLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0FiaKpnRvaZM53MsdCGPtBwHmfqeqUVU9b13D3xLOE=;
 b=jknOlozYZr5sfA+f66Zvy34mhMTFpARTOoE3IW0agKKsGrMcA9/hasO/9G8P6Yycer62XweMwk6YlgNCadA33rMv7HHGobQdW6zBqb2leObA2xMRqVDl3TWDbEBTewgLldWtwwqANW1V9MBINSfTkiGU21+q4HfSrN9sZdgceJJXJZHSG1YzJDMZr6dCWiKiOuwStbtU59UOOTfJpHjgRYM8FgiCGZmaxoNZNitxJn6zwZUVJqVnjil9paVAdiTzVKwiAd7OIn6bssBcWBFSbIJmc5PZ5fCbZVTWzB64H4HX6RTkh+8f7TDlStZdMrt2a9XSL1rfZhPumGlil4LhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0FiaKpnRvaZM53MsdCGPtBwHmfqeqUVU9b13D3xLOE=;
 b=R0BP5gus5Rt+J23YktfyKWqjMxdeW9VIWFh2FNjElN+lx9ICcF/rqZt7qRzJFLDgVzDgT6LIpuvUAaWrmF5Bak78RWNNs1MNzAyi8N9yiQDMaA4ssuyGNUa6McabgK1Owg0uFebaCVeIeFb7SZ7XnF2hih/bO1kmHw+A9IWApAE=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEZPR03MB7958.apcprd03.prod.outlook.com (2603:1096:101:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 4 Sep
 2024 08:50:50 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:50:50 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	=?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>, =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>, =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] wifi: mac80211: introduce EHT rate support in AQL
 airtime
Thread-Topic: [PATCH v3] wifi: mac80211: introduce EHT rate support in AQL
 airtime
Thread-Index: AQHa/qNzOcdYZfZxiUOShYDAKeFIzLJHS3YAgAAGV4A=
Date: Wed, 4 Sep 2024 08:50:50 +0000
Message-ID: <214205b9b317d4de29f77699cdfd690a69a61cf4.camel@mediatek.com>
References: <20240904082109.4339-1-mingyen.hsieh@mediatek.com>
	 <be8d3a5a20a2c77490d78ca05e6ece7651c57caa.camel@sipsolutions.net>
In-Reply-To: <be8d3a5a20a2c77490d78ca05e6ece7651c57caa.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEZPR03MB7958:EE_
x-ms-office365-filtering-correlation-id: 77a76215-e8cb-4469-ca07-08dcccbead59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U3daeTh0NG9JUWRCajZ0aFp4d3BlVmNkQ2UxM3hZOXc3dFA5Y0FhMW85bTB6?=
 =?utf-8?B?a05INzM4R3MxWFZ5d0xyUjIycGQyU0h2eXRRbXpTeWJRUjEreG1VbEw0Z0cr?=
 =?utf-8?B?d3pCb1ZGYjFSQk5mci94dzJxNm4raGRWemFIWVp1QXI2T1F1YUVsT0tBcTBt?=
 =?utf-8?B?RjQvNVNxMWl5K1F4L2ZuaS9BYStSN1N5dDlnUEpCOVd6ZHNDM3hqZkdTSjMw?=
 =?utf-8?B?ZHV2TnJIQjBvNHorYUh2NVNpcVdWUUpsVktTS0UzREltbHgzdFc3VXA3WURr?=
 =?utf-8?B?Zk5mNnd2Q21JQ0x6aSs5eFZFVENkZGdXaFg5Q3UrMWlRd0xxVXpDWExZVktD?=
 =?utf-8?B?OVByc1JiblhsaWhKM1dwVVY4aHZncWsyb0FVQnZGZlVJbjlva0szL1FpVTlO?=
 =?utf-8?B?SHRRVHRKY09NdHdmMGlhU0VWblVGaGMvcjcySWNadkx5YlJka1FvdDBZVUJu?=
 =?utf-8?B?RkVxcnYzWUtHZ1BYU253dzg4Y1ZLTkZDRlNEbjcrUVpjaVV6d2k4VzhJaFZY?=
 =?utf-8?B?b3ZWK3dFTldLKzYzOFNzZlIveWlUZXNOaW9YTnZEeEE4N3RpakVKYlVoNk1S?=
 =?utf-8?B?UnN2c3lRd3lHbjMzNzdzZHFqaEVmUmI1Z3FZbWRDK2JoTDRMdzUwdmU4MzJI?=
 =?utf-8?B?UUVCcEErS0pkYWJtYXUzMTY5anc1OGNJM2ZMZllmNCtHY0Z5SnZaQmlJUWx3?=
 =?utf-8?B?UER5TDdsR1hQTE9ZaWJsVXdYVTh4UEtVZjZlRnVLWGQrZVlEbDZkQWxEWHNY?=
 =?utf-8?B?c0FTYzVnQzZMdFFrTXY4TjJHYXpCR3J5TG96aWNrMDNHdDNSSTZxeDlpaWRZ?=
 =?utf-8?B?OTJmRFdBNEsyN0lSTmZLR3hWdTJKTTdMc2JEMm9LOWxaYXE2NzNrWFBhS2ZW?=
 =?utf-8?B?NDJMK1V5elNHRzRhNENBUEZFVDJ3QXFhK0h3K3NXd0NITGJMRnRvdWpTU2Nx?=
 =?utf-8?B?K3JmRVRUREkvL05wSUtxY1d3MEtjaUV6dEg4M2Z3VzlDUzVQNXRuVmFlMWRP?=
 =?utf-8?B?N1p5KzJxVVFBRzdIa200VDV6WGRmdXZxOVp2U3Y4VStxancrMktGdjBlK0s5?=
 =?utf-8?B?dmhmLzY5WG9TV1hlS1VEWW1NTWZSTUhlckV6M3JxMEpjdUNVSVdZSnpQcTVG?=
 =?utf-8?B?S0RqSzlJcVMvSm9IbGVUUkhhbjRjbjVNdXlPL0VHRitjQkIxRExYTVQvNkVW?=
 =?utf-8?B?SmJ3Z0JvZmEvYld2T3VTRUFwNFV1bDhKbzFBenJGTjBPTUJNSlp5ekFmT282?=
 =?utf-8?B?MjlXelZsTnp3SWpMaDJsaXl0Ty9pMHRiNk52aG53aVZEZGFmUk9Ob09lREE2?=
 =?utf-8?B?VnVJcmRpdmV2bVNoWXllOGlmdmJZNGFMWHRoK3d1UUh2d2xFRnFLOWVvZUVQ?=
 =?utf-8?B?TEZkaHQ3M1FuNzRFVENOaEhBK0loNzd2QXNpcEFIU1RzYjRRTktNbUtDWDFv?=
 =?utf-8?B?bFR4OVdyNmIxMnYvZFFNeDltRVlMdmFCM0I0Qyt3K0VqOWlQWlhDR3NuaW5P?=
 =?utf-8?B?WS8xTFUvTUFJUm0zSmtrOTBaRkUwUDJrdmV3emkzV2dVOGRPMG1tLy9ZTkFu?=
 =?utf-8?B?aS9VcWhxT0M1aWNMS1liQVArem1iSERZMGpWK2Nxd25jYTNaYWxicDVwZWFo?=
 =?utf-8?B?OVZqeUdxc0JGaFFGalo0djVDTUVuNE1nRmVkWm5zKzNJbmFDRjlwdmxjSG9m?=
 =?utf-8?B?c1R0bFNpd1VZdVZVTWVreWFFVGxuNldlV2JqMUUxbWc5NHp5bGZJdloxWHJk?=
 =?utf-8?B?cnpmQ01jYmdWQTZaWDlXN1ovaVNDL2lnTGVzcXVrLzJjM3BPSSsrTU8yMmJC?=
 =?utf-8?B?Ti9rT3lQL2xDZTJVek8yNkNiMG5wMlptd0p1eEYzeU5ObGkzdkZMR1dNUDEz?=
 =?utf-8?B?aGNHTXh1R3B0cGhlSmFYMGs0QzcrR2tWREJidmg3dFBXaWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukh5L3FIcWVnNDgzQlhtUFppWjJva2huTjUxZS9DNEREVzVrZHlWOXQrSkc1?=
 =?utf-8?B?TzYxVm9yZHVVRXIzN29rdmxyMnFudG0zamkrK3dRNGVHdXVERXcwdE1jQlpu?=
 =?utf-8?B?R1g1ODR6ZWtOaHZYSDgzK2thUWRXa1NaREx1bVRlOSsxN3FmRzMrSk5rTDFj?=
 =?utf-8?B?aG9tZ2xqN3ROWVZkRzRjY1JMQ0psVEVBQWt6TnpQbWxvR3VsSVRzUldUUUNZ?=
 =?utf-8?B?OFlrYS85QWI0bVcwajlURkdyaTMwK1NUYWJSSUxwTTE5TmhUQ0oraHdiRnE5?=
 =?utf-8?B?bktiSzNxREtWU1gvU21wdHo4UmRDVU5FemVBVE5ZbWx6dzEyd2hLbk1OYUFB?=
 =?utf-8?B?dkh6UzF4elJXcEZ3K2pCSjJ3KzlIOFFJRktoYzNHUUVjeWQ1d2R1WkdpZEdV?=
 =?utf-8?B?VkJick5OTGxrNnZOVkk5a1RrTkpsVVlzV0xNRGhJTkVDS3hGTWppTEs4MElW?=
 =?utf-8?B?REVSc09aSFhYQkxRK3gzYUcvc0ZwZFk2anl6U3pxZlhNWER1aHZzcnovYzNC?=
 =?utf-8?B?NFFLSWdEWFh4eVBScFFvdXA1RVQ5Y1diUUhzSU50bnVGL29MS0t6VFp6cFk0?=
 =?utf-8?B?VGRkUERIOUk0SVZaT05BTkU0WGE4eFNFYjdNSE5RdXhPeEhKMncrcnVweTB1?=
 =?utf-8?B?NDhJYXF0djlPRFJxcGFjZHZWU2xGMkd0aW84MXpSWlNTOHhrRXhEL1hKell4?=
 =?utf-8?B?c3E5ek9lak5WSXRZUkRkOVFzYUQ1Qkw4dWdVZ29RNlBVMVpPUExrMFVValZx?=
 =?utf-8?B?ZktzYWc0RkV6dUsrMnVFREFPQ2JtMU5wbUo3Vmd3RUhWY0owNlBOam1aSklx?=
 =?utf-8?B?WEdDNjh6OGY5Sm1QZjdENElRZURxOTladDZ0WEJIakJ4cnZzNk9wZ09zUitU?=
 =?utf-8?B?b3FTMzUyeDZrRFNTQlgxUzNxaFd5Tytaek16aXd4SGQ1YVBQRzF0enpLMmlL?=
 =?utf-8?B?RmEwdGRERTQrVzlyRXFyejkrWlljenNQR2RiTzFyMXNzUU5ZRStRT1hQcUdB?=
 =?utf-8?B?bGliMGluU2swUEJpZVpGYU1aOFF4Vy80NEJCSk1KYldNWWRrN3ZJazN1VUo3?=
 =?utf-8?B?WkNYRjBZVEl2OWg5UXFWQTJWZCtwQmluK2cxcDJ4czVjKzVuYU81MU1pRnpR?=
 =?utf-8?B?MFduMk5BaDY4YitJQlEzWXBJbCtWaWJhV0dpa2JwNzNWQ3pucVUyZUs2aHpj?=
 =?utf-8?B?TExtWENRZnJmYXZaMGd1R3NReU92bkx6TEdiWHdLZ0lLRitwazlFMERnQ1Fv?=
 =?utf-8?B?OXJqamZDd2hHR1pnakxPT0NFYy95K0pBM1BIYWRGZ0tYcmtHVFVtOXBuU1Vh?=
 =?utf-8?B?bjhMb3FBSEVwYXdiNzI1TU9mT3BEM2xqeGxpUFFZYzFZUCtTcmkycXd5ZVZP?=
 =?utf-8?B?LzFRL0ZWQWhoRmx5NHVaSHQ5Q2JxRWNsU2M4R2hyNnNoMkY3TGNCWi9vMTNI?=
 =?utf-8?B?RE5sdVRXa29MNldyLyt5MDVjZGhqZmFRRTlGcGY3RUtCc0hzdjk1aFFSWnVj?=
 =?utf-8?B?MU5mZ3V3alYzN2ppQnhUK21SZWR0dVFxWkxHbXc2eDQ0YmZQa09mVEZRR3pz?=
 =?utf-8?B?d3ZRUEpGK3U4bXVidXRvZm1NTWpLVFJNZXJRY3owL2tZeCs0cTVidVhMU3pj?=
 =?utf-8?B?U3E3WWNvMGxLZlQyaG5SZ25XZjlTNk5LWExyUDk5T041bE5RVVladU5kRzRM?=
 =?utf-8?B?N3JLSmFaakJ2K21iMDNnSjBMWFVlMEdFMGNkYVhtL0k3OFkzNDFINnp0N3ox?=
 =?utf-8?B?OUxUSTBHcUZOKzZ4NUJMM1BnWGk1bFRrMGJySWVSZStFSmYwTCsvTEhTdGtZ?=
 =?utf-8?B?c1EzeTZKOEw2TE9qUVBFMlo1L2lhSDNESG1HU2dwT3gzdnAwTVF2RWEwZnV6?=
 =?utf-8?B?dHBxbGF0VUpsaWdrRmgwM0FBQkxJU3ZFa3hvdDEwekVjSy95eGMrVmNMK1o0?=
 =?utf-8?B?MzJLcTR1RmpnYUcrYUV0WHBoYUZXSDlmMjNLWlBmYVpKemNiQTdtb04vcGVR?=
 =?utf-8?B?MENETGFlQkdYMUFocTlHVTBPbitORk1yWnV0UXU4L3JlNjc1SEx4Zmx0bzBi?=
 =?utf-8?B?UDl4VWRTdUtiT0k2cnRzcElCU3RUVFViamFYSHU0T1BDek5OclhGZzR1UEpn?=
 =?utf-8?B?ek5hRkRSOXdaVHI3TUNVMURVaEJiaE1UL0NENFhCYVo0NHBaT3VQakNDdmt2?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41362D3AA0A2A4BB39DF057204D08AD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a76215-e8cb-4469-ca07-08dcccbead59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 08:50:50.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8YBMOlam9UA6N10KkheoyxrvFvcIlq3CFob3XUE8BL542dNGZ9RH4bRplllxU6DAF/icT9/dL5YaKanpI3PBGSky3S3oN4TSmiZITEer7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7958

T24gV2VkLCAyMDI0LTA5LTA0IGF0IDEwOjI4ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIFdlZCwgMjAyNC0wOS0wNCBhdCAxNjoyMSArMDgwMCwgTWluZ3ll
biBIc2llaCB3cm90ZToNCj4gPiANCj4gPiArI2RlZmluZSBJRUVFODAyMTFfRUhUX01BWF9TVFJF
QU1TMTYNCj4gDQo+IFN0aWxsIG5vdCBzdXJlIHdoeSB5b3UgdGhpbmsgMTYgc3RyZWFtcyBhcmUg
bGVnYWwgaW4gRUhUPw0KPiANCj4gam9oYW5uZXMNCj4gDQoNCkhpIGpvaGFubmVzLA0KDQpNYXli
ZSBJIG1pc3VuZGVyc3Rvb2QgdGhlIG1lYW5pbmcgb2Ygc3BlYywgSSB3aWxsIG1vZGlmeSBpdC4N
Cg0KbWluZ3llbi4NCg==

