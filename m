Return-Path: <linux-wireless+bounces-11660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486B9958459
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF7C1F26CDE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C318E05D;
	Tue, 20 Aug 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lnEfaVRm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OnfvYfBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2918E74E
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149446; cv=fail; b=O7EbHkFcYvruvxNCOs8L7Unr9NtutuzDMycWSSBYbU3HSM8q8sURrT/MHmg+4F3OKdYKlwJgZiMByWmAw3R+A6K5FXf0GVH3xzra60Ou5RIhz/ZMO3qEbWWbkG+HPPGlnj+I0qfyRN+qh+OeMjLF8T6k2ntvy1HJdbNp4u84K94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149446; c=relaxed/simple;
	bh=DCwsrooLzbYnDkffITuvgoSKfvv8gn7avc+z5+Rq72M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhJM68KQHJfGIkYBpUh6DECpgHnyKE1PD8peWGeeXGQZbxGpYlCUZW8/Pmck2feD3k7+kmUBBvmvzxIyMafmhCuOML24qFbLT7DQmdRi2CUkUV0k528iEZF36tiXZCBde6Sld3GOIgKOB0fKwvndSb6j6zCN5VbFUICt/ub7pxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lnEfaVRm; dkim=fail (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OnfvYfBs reason="signature verification failed"; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4d593a6e5ede11ef8593d301e5c8a9c0-20240820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DCwsrooLzbYnDkffITuvgoSKfvv8gn7avc+z5+Rq72M=;
	b=lnEfaVRmBrMnwlJvHnXAaTJk3OT3ABs5DPfbu+QT5F1TcDEAuBQA1kMsaT5WFWwfbE37k1DXZvkSAx5ytKSeJmbS65onINOEVzt4Ra7AiOHQtqkESqAy+ZWlioP+ryjDBNGcrvUgPG0wHdykULVrvtFKFjM2FXMr7YtuLIfdi14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:aacdbce2-9479-48e0-9a30-12d91b787c1a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9e23bd5b-248b-45cb-bde8-d789f49f4e1e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4d593a6e5ede11ef8593d301e5c8a9c0-20240820
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1483212115; Tue, 20 Aug 2024 18:23:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Aug 2024 18:23:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Aug 2024 18:23:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIcQLbOgySc7TcS/et3EsePxe9V+pIflFitDha2BP47pix/Cyjyysl/x4eFUO3kRhvd70Uff6QkCNl0wVgy7MgCShP4dAEG1OWuN9P5+lAjBMEcT+5WgIAIxNuSHKPrUndRSdE9xHGG38o34BFI9g5fmpTggHUc14qCBUdbaE6woh/W78vz/4XT/68w0ZsYazGRpZ2dKoCodrZfUCMT6FfZ+qBAL8EkJq2C8nLkRgJMeRjZ/mIevUjrNfXgBcjzcvTZWjYqskTNi88ZowVwnXXplvLOjCrJRLZyZgELf9RbrHVZv4m5zCVb5pLYAXLCn2EG/R5+X0EQjXMGujplBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCwsrooLzbYnDkffITuvgoSKfvv8gn7avc+z5+Rq72M=;
 b=HV+RT5VKf4U2csVaqaIF/owDj/bPPEjfzc7hhq4EHvUekZlDSiV9SF4JFGka4OEJ3rYLX9bl0ojybM1CaH2EN7isuK3eQKj/d22zlYRo0jL5am/IAVGkDtRcnCdqMJ4DHZoL8VXkJeVWXBCKOzh6exEvjCn/0CffiGPEcWvj1ej4StKQ41HeJOiVWdkjTxXzo1Fe+qPHDqiH557375WQk5jhXT6su9gE5W1Fm3nx2FeJatYsVE8KEtp8uqrpbPtn6OEtyZevuoCO/MkL5mxxjkC3iQucNqC1G3pTde2tpjbiitrCEf1MuqKIwJ8lk1PGPTvg5McaU0AV7lH3Zl2Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCwsrooLzbYnDkffITuvgoSKfvv8gn7avc+z5+Rq72M=;
 b=OnfvYfBszHi3VSYBTGgP9Wq/CXE6VI22BrkesDxOK9MdxNLH5ugS2gIyGZSMJJlJDrni/GSyAEXrI80SyyigkaUMWUFqMNNqV6Z8tsPYwD2nSzcYDIAJ1iWL+Ck+CuE3u8RTs11EuoUXWXjYzQpZcP7LF83usNX2xYy/qsXj6KY=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by SG2PR03MB6503.apcprd03.prod.outlook.com (2603:1096:4:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 20 Aug
 2024 10:23:53 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::8dd9:7dc2:9bac:818a]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::8dd9:7dc2:9bac:818a%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:23:52 +0000
From: shayne.chen@mediatek.com
To: "greearb@candelatech.com" <greearb@candelatech.com>, "nbd@nbd.name"
	<nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, =?utf-8?B?SG93YXJkLVlIIEhzdSAo6Kix6IKy6LGqKQ==?=
	<Howard-YH.Hsu@mediatek.com>
Subject: Re: [PATCH 07/12] wifi: mt76: mt7996: set correct beamformee SS
 capability
Thread-Topic: [PATCH 07/12] wifi: mt76: mt7996: set correct beamformee SS
 capability
Thread-Index: AQHa78G2JzMvEngnSkGepf6EsgLnhrIupw4AgAFPiIA=
Date: Tue, 20 Aug 2024 10:23:52 +0000
Message-ID: <8f1b465a51fc66a13fd01c49266a4b5cc934f5eb.camel@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
	 <20240816094635.2391-6-shayne.chen@mediatek.com>
	 <9e60638a-d85f-4c35-9370-8b42e96d1526@candelatech.com>
In-Reply-To: <9e60638a-d85f-4c35-9370-8b42e96d1526@candelatech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|SG2PR03MB6503:EE_
x-ms-office365-filtering-correlation-id: 08ffa900-4de6-4bbf-747e-08dcc1023092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R2hheHprK1RzRmprcUxiQXBScUtwZEhBYTRiYTdNdWFsT3BZSkxDOGJRZVVp?=
 =?utf-8?B?RDduSUoyY01ZZ0xaMXo0WElHMUxsREY5elFSQ295TDlnblJMcFBTaW5pbDdC?=
 =?utf-8?B?cEFpa3BPQnU2Wk42WXlueHBWa1BFWUFIK3FTclMrNjh6U21LWlVhdHVNT3VU?=
 =?utf-8?B?OXRoalE3SmJhUUc0Q2hsdTd0aFkwOFA2VkI1akdtUU04RGdNOWVVS0tYQkhs?=
 =?utf-8?B?T3dQV0RWY2Rid3dOWS96UTJQVnZDTHNueWlKVkV0YVJTeVNEUExPZHZ1NmVo?=
 =?utf-8?B?UXJPVisvVWsyalhvZ2ZRRHNCQk5nUGJtd1JuQllrY1NkOTY0bTlhWkFLSVZ1?=
 =?utf-8?B?dHptZm96NWk5WE93OU02dlNEVElndnNZRkY1amp2dkZaVFFoVW0yS3B6VkYx?=
 =?utf-8?B?c0FVclNtR2hPQVErQUo5NXk4dElpcjlKblF5Mzh0dnEvcjhKcnJGWTY1cTBr?=
 =?utf-8?B?OW5HWHR1RkNBTnFXL1dzeTIvMjI0b3BldVNhRzJObmJ6WEV5UFNxL3BIWjVI?=
 =?utf-8?B?WldnbDVRYjdaN2VubjVhVG1sNkxkMmJMUkpsbnNlb0R0dXk2a2xqY1NiMjhM?=
 =?utf-8?B?Qyt3dWMvZlhVU0RrNVZPVEh0N1ZENktPVVB1UnVoTU1zeTl1b25Wc0hOcm1r?=
 =?utf-8?B?aXBwUXM3MDFzUkd5Y3JlYzN4NTBkeGt3NnQxVjhOUHZRYVY2ZU5YbXlIZWx5?=
 =?utf-8?B?MW9oQkdpMGdFbHpsWFBneGhXNEpleUVMSldhcGNvTXhVQ0U3M0dwbFk3VUdm?=
 =?utf-8?B?bzhsZ2lvUyt5dStaaEEzTDNOMWU2dnJZZkpEYTFPRGE2c3JOUEI2cFF0SEUw?=
 =?utf-8?B?ZXplcUdlZjRseEJTUTU3dUo2NHZsTGRHc1NoTURQWlR2T01Wck83bTVQSTdm?=
 =?utf-8?B?dDgxZDFxOWlQVDUrMnVqWTRkVjNxbXFmbmRabG5pL0R5VzJnTDcrY202T0k2?=
 =?utf-8?B?UXlld2YxUC9vK2txODRQVHBUTUZwRmtQbUNtQUZONWVoaXM4UFFrVnZGTGps?=
 =?utf-8?B?ZFdIK3RDUm5xdmV0Z01kZUFFdmR1YWUrYmdVN25lazk5ellVanRhZ0NOMEhG?=
 =?utf-8?B?OXl3c2lOVGFRR1A4UmZKUUkzKzAxQng5Z1FWR2xJMjA2YUVlV3JMTmc5TXAy?=
 =?utf-8?B?NTllWUp2YTlOcklvRVhtd1JGcEVPK2dtZ20rUERkcFhLcmtCUUY1VFhmVTZ2?=
 =?utf-8?B?UUwzUlI3T1J3TGVWcjFYZ2tRZ0NDaXlLMDh0enhpN0hNQlZHK1hZM0dQcUsz?=
 =?utf-8?B?YVV5OVFoTElYYWVtd01mcHlpcWRNNkM2WVduL3l4NDY0RlFXVGZpVHVtUmlL?=
 =?utf-8?B?UzhKODNzekExUllsZGwzMWxUN1dnT1hKeU9aakNOazhvOFBTZlJSWGRtMUJB?=
 =?utf-8?B?TkZEaWdEVm1RaGcrdkQxUFNPVE5Vd0JLZUo2UEZmN2hRY2F1cW8yRWlQRWlu?=
 =?utf-8?B?cHhjb1VtcWFUR1M1d3VFQnZQWjBzL1JCMVg4emphMzJ5RGlmOVB0aTBEbHov?=
 =?utf-8?B?cEo4R3pWS0pwWVVFYjZZTVhwdHpyemxKRjlSODJneDB0Y1JaYVArQkFKRS9C?=
 =?utf-8?B?VTBoSDJ3NGErNFhOeG43R0ZMaFpZMUFHMmE4U1NldXkzL294WVhRSVV4VU4x?=
 =?utf-8?B?OGpmaHIxa0JZb0tOUTRZL0l3M1FISzZNRGNxVHpZYTFOejdZRUpjT1NCa3dX?=
 =?utf-8?B?N0lrVjVUVVBzNmN1QkZNcHZMaTNJVFdIYnh0U2FSRDBpNnZDci95bjY2YVpN?=
 =?utf-8?B?NEhlYld1Yk54S05DOHZ3TUhDUUhhY0dPeWY4ZW5uZUZhQ0tBdC9jU1ZiUVhR?=
 =?utf-8?B?VGlIVW9sUk1CaFFqc0czckFLN2ppYWg2dFFLMHlMbUxpZHErdzVPT2JlVWlB?=
 =?utf-8?B?WEhaYk5WbktWZXBZUDlpSUo2NEMySUVxcWFYN09yV1p1cHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RiUjJJSnZaT3RMNXd4c3lyU2pUTnNsYVQ2c3lTN3RZWWU4djRsSHozNHpC?=
 =?utf-8?B?VWVmWmlnaFdZajcyc1FLR3BSNDVQRWNtL0tpaVJiTkM3NXJDM082RXBwOElq?=
 =?utf-8?B?ZmtmR1dqUm8zSGtWS3lkSEZlaFF3Q3g4ejhlQWtvVjRLYkExWTZLbTc4RTFK?=
 =?utf-8?B?bCtGNTJkSkZVUG56RlJHTk5taE5RWEpQZVJidWVMRkx2RVFiMWx1NUNDRW9R?=
 =?utf-8?B?UFpxRmJvTkYxSGxaNzgzNmpzbnJYaXhGTE96Tk5zY25ZMG9ycm5NMWVuSTg2?=
 =?utf-8?B?OTNXSm5sWXIvbjBDa05xTVQ2RjhCSUxNaTlSclF5T1lrSWlMdlRaVVpEd1RU?=
 =?utf-8?B?UENZcVlXeVpudlU1eXhxYStYbTBFOURUYmhERWdXNUtBS1lWTFJVL0ZkMkRU?=
 =?utf-8?B?VzFMRWMzUUY2TERMQ1lLYUJvbU1uY3dWMisrMHp3SVkxTlA2OW5QR21yZzhv?=
 =?utf-8?B?M0cwallqeE5ZdEtvNGNqU2grelN2MjhxdWZ1b3NSNUxJRXNtTGVZYUEvTTZJ?=
 =?utf-8?B?M0Z3WDlMM3llSkEzdkZLOG5sRTAvTlR3TjV4Ly9DaXNCTGVTQU41SE1pYzBL?=
 =?utf-8?B?N2ZqOHZGUFoyRDRkTWRvUUdrVUxTQU80by8wVkhOVGFkbmc0NkREYUJ2cWk5?=
 =?utf-8?B?OHFTZ1kvdS83MHNoeHE1TVN6UHhYdm1HVlZWc3FSZ0tJeDBDSGVSOXAvZ3h1?=
 =?utf-8?B?RVd5SlBzYStrdDBsS2RlbVMvUXZsTmZuWlEzalRveTRNVDhHVXE5VjRHNnpx?=
 =?utf-8?B?bmNLUG1IU21zTTdKbnUwUHc0K3BmRkxiclk3Ymx1bkV5QlVIQTgrcEFidDlo?=
 =?utf-8?B?d2RMR3JPUm5iOExzZ2dPcnduZVhlWWRLU2RyYjVFbzVqWWxLbFJISGo5ZFha?=
 =?utf-8?B?Rk0vOHdWRDEybzlxdzZzclE3ZGVxdnBTYWpUb2w3dSsrS0JnL0xPa3F2R20v?=
 =?utf-8?B?Zjh6RzVUSExURG5pSkRGR3JuQnJqd1QwdncrR2NDcGh4WkVHY2dYT0NuVUh1?=
 =?utf-8?B?MW5kYVMwc2FQb0xCWWNOSTBPQ1lmUnRCL3VHTERlOVdidlRUZmczRENrczcv?=
 =?utf-8?B?NXJUa2RIN3NSTC9pc0JmUHo1UzlZRk9pQVE1Z1Z2Q3pMbTFiNVhDN3R3OFNY?=
 =?utf-8?B?TGRrVWNzQXRQU2oyWkJhdEZydDhJMVFpM0pJeCtSZ1dSOXJLWlRuM0xPVHRx?=
 =?utf-8?B?Z3YyWVdGSDArMGcxaHFnOFVtVGlPU1pwYnU0Y1FoZjhldzdHOFQ1SnZDVVUr?=
 =?utf-8?B?YlJOcHJJRFh4Q21ZU1J6QXVXOEFpVlB1c2xxMWcraGs0RGhRMi8zK01ZTUVM?=
 =?utf-8?B?MExWT091eExKSzZGOWZtYjFyaTM0UndMek9PK3IvdVI2clZjcUFRNW5xV2d2?=
 =?utf-8?B?bmpMa1l2WnNOR096bGsvU3dWa2t0aFhBSCtibk0rVGExVjVsTXFQTWpSSFl6?=
 =?utf-8?B?eVpsTjB3bGswdCsvM1BwUE9jZkNsU1ljQTN6anNlSnR5VHZvSmVBRmJqTXBm?=
 =?utf-8?B?TGFZQSs1QmVvRG5DamhQQWIxQWc0RXRNZ0JiemZWeU1vbnVWTGNnU0JrTHJE?=
 =?utf-8?B?RGxxeHY1b1ZqbmY2SUI3SGtzS3VLNlhMUTF3MCtEUlRyemNiVTFHZjB3VEph?=
 =?utf-8?B?cTVkcytQeWczUlB0NHNOVHppSGlVcTdDNS9uM1RQeWxqQnFzUDdPK3Q0QUI2?=
 =?utf-8?B?MEdxOUkvd0JhdStQUkU0aDByRXorMEw3TDYwbUpXcDNKMTVvRjV4NDdOWXNW?=
 =?utf-8?B?WGQ2WG9YUVVlM0VUWEI1czE3UURKVFZzdGpzUWE5NThwNytUeXJPSXlaTnJZ?=
 =?utf-8?B?RTI4a05pc3ExYVQvaExON21Jemd0bllyOTlzUDNtVDE5SHdiQXpPUUoweFNm?=
 =?utf-8?B?N0d6Tll2OExzbGlUdHorTVdsNlNJT3BUN29LSm8xWlRzSXB4UWR3VnhURTBU?=
 =?utf-8?B?bWp2WCtJTE0wTWMzN204YjV0Q3o1M2VlWjd1YzFaNGgvVGM0Y3VrdTQvYU51?=
 =?utf-8?B?T09HcVVOSElyTVZ2ZnpQVmZKZkM1ZWwrV09KbS8vQWtxS2RGNkdLVjVyNUow?=
 =?utf-8?B?bU4yUTJ4TWNBcnZLTEd3OFNnWkdtb0w1RUk1b0pPdWtQSUZQaS8yWmF4RERi?=
 =?utf-8?B?ME9OcGlWYnVlVi8rUkZyN0pjZVBtM1pMOVE5N3lKWnkrRDI0b2ZNZFUzb3NC?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2744D28E8C2C1148BB032159F2C98BBB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ffa900-4de6-4bbf-747e-08dcc1023092
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 10:23:52.8129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjtYL61xamHwzWzr0fvP5TkF/WiH1efBkB3daQhQDoiS0/sxiyOqrljRA18gyQV1rUYd4ZmXvYtCMoBFMt7yRdOmHMRWqY97FLLSX5V/pF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6503
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.498300-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2drnuu4cCcfF+Mk6ACsw4JiifyPcCvG3TPMA
	rurUD4iIv91sk+WpIXXLjeUJjImc4hsiwtTFTO4bAJnGRMfFxyZE+3DCX3uibAOrNpiFyN5DvH2
	neBQK1q83WN4NNppkR4gEgi0p+wtcrYPqmZqtV/86RKnOYsI58vtVce6w5+K+CsBeCv8CM/b/fk
	bxklHWAgkXrwSgutx8fZdczzDm/ukL9tcyTZdAsgxsfzkNRlfLdB/CxWTRRu4BQLWahPl6cftwZ
	3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.498300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 
	7C434EF06C792AD68751217FAA3E21DB09669EFBBB9627113D09E2EE2E0651F62000:8
X-MTK: N

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDA3OjIyIC0wNzAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIDgvMTYvMjQgMDI6NDYsIFNoYXluZSBDaGVuIHdyb3RlOg0KPiA+IEZy
b206IEhvd2FyZCBIc3UgPGhvd2FyZC15aC5oc3VAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFj
Y29yZGluZyB0byBJRUVFIFA4MDIuMTFiZS9ENi4wIFRhYmxlIDktNDE3biwgYmVhbWZvcm1lZSBT
UyBmaWVsZA0KPiBzdGFuZHMNCj4gPiBmb3IgdGhlIG1heGltdW0gbnVtYmVyIG9mIHNwYXRpYWwg
c3RyZWFtcyB0aGF0IHRoZSBTVEEgY2FuIHJlY2VpdmUNCj4gaW4gYW4NCj4gPiBFSFQgc291bmRp
bmcgTkRQIG1pbnVzIDEsIGFuZCB0aGUgbWluaW11bSB2YWx1ZSBvZiB0aGlzIGZpZWxkIGlzIDMu
DQo+ID4gDQo+ID4gVGhpcyB2YWx1ZSBpbmRpY2F0ZXMgdGhlIGRlY29kaW5nIGNhcGFiaWxpdHkg
b2YgYSBiZWFtZm9ybWVlLCB3aGljaA0KPiBpcw0KPiA+IGluZGVwZW5kZW50IG9mIGN1cnJlbnQg
YW50ZW5uYSBzZXR0aW5ncy4gQ29ycmVjdCB0aGUgdmFsdWUgZm9yDQo+IG10Nzk5Ng0KPiA+IGFu
ZCBtdDc5OTIgY2hpcHNldHMgYmFzZWQgb24gdGhlaXIgSFcgY2FwYWJpbGl0eS4NCj4gDQo+IEkg
dGhvdWdodCB0aGF0IGlmIHVzZXIgc2V0cyBhIHNwZWNpZmljIG51bWJlciBvZiBhbnRlbm5hcywg
dGhlIGNvZGUNCj4gc2hvdWxkDQo+IGFjdCBhcyBpZiB0aGF0IHdlcmUgdGhlIG51bWJlciBvZiBw
aHlzaWNhbCBhbnRlbm5hcywgc28gdGhpcyBjaGFuZ2UNCj4gc2VlbXMNCj4gd3JvbmcgdG8gbWUu
DQo+IA0KV2UgdXNlZCB0byB0aGluayB0aGF0IHRoaXMgZmllbGQgZGVwZW5kcyBvbiB0aGUgYW50
ZW5uYXMuIEhvd2V2ZXIsIHdlDQpzZWUgdGhhdCBJRUVFIHNwZWMgZGVmaW5lcyB0aGUgbWluaW11
bSB2YWx1ZSBvZiB0aGlzIGZpZWxkIGlzIDMsIHNvIHdlDQp0aGluayB3aGF0IHRoZSBmaWVsZCBt
ZWFucyBpcyB0aGUgIk1BWCBIVyBkZWNvZGluZyBjYXBhYmlsaXR5Iiwgbm8NCm1hdHRlciBob3cg
bWFueSBhbnRlbm5hcyB0aGF0IHVzZXIgY3VycmVudGx5IGNvbmZpZ3VyZWQuDQoNCkZvciBleGFt
cGxlLCBpZiB1c2VyIGNvbmZpZ3VyZXMgYSBiZWFtZm9ybWVlIHdpdGggb25seSAxIGFudGVubmEs
IGl0IGlzDQpzdGlsbCBhYmxlZCB0byBkZWNvZGUgYSAiKFJYKS0xeDQtKFRYKSIgbWF0cml4IGZy
b20gYSBiZWFtZm9ybWVyLiANCg0KPiBXaGF0IHVzZS1jYXNlIGlzIHRoaXMgcGF0Y2ggYXR0ZW1w
dGluZyB0byBmaXg/DQo+IA0KV2UgZmFjZWQgaXNzdWVzIHdoZW4gZG9pbmcgc29tZSBCRiBwZXJm
b3JtYW5jZSBhbmQgY2VydCB0ZXN0cy4NCg0KVGhhbmtzLA0KU2hheW5lDQoNCj4gVGhhbmtzLA0K
PiBCZW4NCj4gDQo=


