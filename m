Return-Path: <linux-wireless+bounces-31707-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LLnMDV1i2nZUQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31707-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 19:13:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E411E41B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D834A300BC8F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220A38A9B1;
	Tue, 10 Feb 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H/ERWPUX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dQ/ouY4h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5481F1534;
	Tue, 10 Feb 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747184; cv=fail; b=ZdPtnoik4lqvD66WWkgnvaNzPEVeXP+A5D9VNedkrE9tFPNgEME2ibB0UqTY4G+EC8v9uyWJmNN4gp9o05/O0LekVVxcPgm7xv0AecdPFHFHG0Tlz3sUsKUsR0oPb8FqStIutESLuzT7XUpeDNt1/9F84VZTWHSVY48fDyzadaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747184; c=relaxed/simple;
	bh=scmXy6a+I4cjQtFRUzc9dLZ4qqim8nbn+rJhwz8R02U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQn5pr8lPU1ag/XCOzenSDNxsoosYHwEHUMFKDFhukU+sEJJiUDe29lWBwhEydTW4U2SRK1UoHg/TTpveydM8Eer5aVPJFsyDOwZWMj6tGnpQeo4HhIhmW5aYDgLx5G7syQeFtmARAmF4oSwHtqYa36LnS28wIiC2dU588VNI2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H/ERWPUX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dQ/ouY4h; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1e6bc9b606ac11f185319dbc3099e8fb-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=scmXy6a+I4cjQtFRUzc9dLZ4qqim8nbn+rJhwz8R02U=;
	b=H/ERWPUXmSdkY6Zmt77AzrL+METtUYT/OggH2zUI7P6AF2b5NLV2YizGsL0TRxQtcBgKgTUm7Mnfsy42iwgoiyFISRtn/0bFY1XCc6iALDL2senXEapmzkxB9oBgtfk+1Q1rAg40wq5GHdZTrGtB217ROlAz6pxUOlBgZe4oGlU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:2331c4f4-7b99-4cee-ac90-ed91c7c5abd9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:a36488e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1e6bc9b606ac11f185319dbc3099e8fb-20260211
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 159963363; Wed, 11 Feb 2026 02:12:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 02:12:52 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 02:12:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSMQ4ybfREEc7R8WOiHDxqJaVU8jNTfbAm1zsHw54hfmic9qbyBMciinatOP5ELdzB1djqM/71nRW7jJAuuKUyoNYyiqDNdC4T3YL5gV7jaZvPM5qClD6l8gzH38eXdjTfPt3/Z40er4ayOg6NKQO5JG0MCoGbZpUvvd9NJ3OAq+TgGzbWrHZlwkaSXA3gonnCEtK5KDjs/wnMlfzhBmnRh4zDxzeQAUNi4GwS38maUReSeHIlupPrU2xgu9BEl92xJ2Z5IycNIHooUHh4FMFz9pD3McogHwT5NQk9v2TdZV+3N998+qk5fIT4N3SqfgaZaKoAvUfkjE7MgXifEOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scmXy6a+I4cjQtFRUzc9dLZ4qqim8nbn+rJhwz8R02U=;
 b=GnA04e3OS0rzE4blFSOa95kqITj9Z3NZpLQjd3CmCRXPc+s3aG98qKcwpOC72gjPRU+DcB40xDX+eU7UF+LdTabdVBbaPVNPGdQoaxNa7YbJOvp583Fx/bK3zotM42/Ozj8Pi4sHboUdnERp64c3Q2RaXV8ZIzYrkv5LzD4O7mZ33+7XQ7BW2vrqgl12f6YRswQh3Xv9Y4RPvtEIlTQ82n1sq9Z4l2AO3tN0S0TohZoqcMGyPD9zSWKl8NDxGqAcldbCJS3DvQAKPmA54p/NLkqBAfuy5Jc7kosfSs8kjWUOLRi/tq2BqdbzIJtwiIaomU3AA10kdHGFCfiPsY2gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scmXy6a+I4cjQtFRUzc9dLZ4qqim8nbn+rJhwz8R02U=;
 b=dQ/ouY4hQZiYOE768C1HCPlyYez1eQS4z2kVGLzHKX5WE0T2YQbEEjw2hUtnwh5qZiDSL+Y/ho4wHxqEuNCih/G2dgImPdtd7qiBbVZauyUb46fCVGEPZI8LCy7859FxrWyIhdoqWWlIai9EjRwf+h+KqY6iwEUODCwT1EHtlDY=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KUZPR03MB9442.apcprd03.prod.outlook.com (2603:1096:d10:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 18:12:49 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 18:12:48 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V8PESA
Date: Tue, 10 Feb 2026 18:12:48 +0000
Message-ID: <52244d9cbd63ff6b660074d0f44724896d1e88e3.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
In-Reply-To: <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KUZPR03MB9442:EE_
x-ms-office365-filtering-correlation-id: 7271ad75-4d3a-448e-62ba-08de68cfff58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K2NMRStxL0NTRWNvV25ZNmJFNkk4dDl4MmxkUU9QUUV3d1RhS0FxNDlqazNu?=
 =?utf-8?B?ZUlJS2NRYko2emlmNU1aTmF3bjZuOWNFek9BVndTM2kyTWhqam96SHRDbTd4?=
 =?utf-8?B?OGFqVndqYXF5RnVXK2d5MkhhVmVObjlyamtBSE1tMWUxR2oyK1R6VnE3WHN3?=
 =?utf-8?B?ZTRBQjJ2M2F4WGZFZzdWRUtkeXFwaGJ3dTJ6RklUZ2V5U3p6QzhkUDFiS3Jo?=
 =?utf-8?B?VVlaMmxVUkJyZDB1MjAwaW41U255Nzhiem9lWDlKY0I0WE9CM1hRN21ET20r?=
 =?utf-8?B?SS9rUU1tRGJ6R1pyWXppbzBoNUZXZ2ppSjdnWGFiVVNtc2s3S2xiM1BuS2Uw?=
 =?utf-8?B?YVk4NlpKNklqZWVyd1RMMmlrblFZem4ybmFQcWFCcHU2UWQvT1QvV1JrTUdQ?=
 =?utf-8?B?eHd6aDZ3aHRveVA5UVAvRzRuTTh5Qmg3RmNsMVlRN0grdzdhTU5TS2hOOWF1?=
 =?utf-8?B?bmF2WVM2dzJjZk03dHByRExmUWswb05mekFuSlo3Wk5Jdk5yYXdSTkExQ0Qx?=
 =?utf-8?B?T29USEZkYU9abVV4NUQwdjJtaDZ4NXVLaDlMa1RZc2xxczNJVm54aVhvNXcv?=
 =?utf-8?B?VGoraTYwZnJRSHY3UnJDeWtvTlY0cjhjQmh5Y0d3MTEyamJzOHZRK2JTdGlG?=
 =?utf-8?B?TUtvcEQweXVUczZPTkRiRGlwN0gyQTZiM1pkbzVHUUxSbjVnaFdzaWVsSkNX?=
 =?utf-8?B?ZENZVDNaU1E0RkZjNE85eFRKV2d1WS9ZeVMyS3BSWTlnR1FqdUZFa1BabC9L?=
 =?utf-8?B?WHhpUVAxWW5PaUd1QVlwbDJjNW4zV2dla0w0dEcwRFV0Qnlnck9IaE1IRmxH?=
 =?utf-8?B?Y2YxekJEcjdicjdwemprMWtBT3l1SitpMGhEa2xFNkVhQjZEenJvcGZuRW5Z?=
 =?utf-8?B?V3lRWlQ1NFk4dCt5V3VDVm03Y25uRjBKSjZJaFdJL2pQMmt1d0hxRWVQRWxW?=
 =?utf-8?B?cTh5ck83Y2liTHZMU2NUYnU1VC9nV2xQSDFpd3JKN1IrZUd3UDFJcXNkNk02?=
 =?utf-8?B?VGtlSkMzK09vRWorWXRTSEpHUWs3SEFIbURHQkEzUmRZeEZqWURSaFFBd3kz?=
 =?utf-8?B?SGtBR2hTaE1ibzFZSm5MVEdvbHZ5QWMvbldDYnpaNCtjZ1B4c00zYWdraURD?=
 =?utf-8?B?cFFVQXorSEFFb1dNOTNyK1NxZ1BVZDFuYmg4UG1HMnFkN0ZVWXB6cWVCNXdX?=
 =?utf-8?B?WXdKOEgzeGtzZjRpak1tMGx5b3R3Ry9BbkQ5eDVETUVrWkdLSTJ3SWhJSUtr?=
 =?utf-8?B?MmlKRjVTdDdLVlB2WFZ5d283SW9XN2ZNMmFXaVBJTWdtQlk1bldYazBkS3p4?=
 =?utf-8?B?eE9RSHdaTVNqS0xja0hNN1huZ0lqMk1QRjY5aXZVcjVuNnNzTUFoL3JYTmpB?=
 =?utf-8?B?TmtjVCtCOGpKc0FpYnNGU3VTNDkxNjFwUUdOZVdSQUU0R3RWQzg3Z0lqRllU?=
 =?utf-8?B?cWg0K0oyZnNJNTg1Sk5ZSmlOeGtjYmhrRFp3Q2hrMk5NOWNlUFdHYVBXeG5h?=
 =?utf-8?B?eWtPZFpwTmd0R0tQQmJyL3N0dDQ4Yy9HQXZJUHowaGRQaXR0cTgrQ0pLejhG?=
 =?utf-8?B?VkVOSUVjdDVVQ21XNFF3VVl1RzE0K09sM2VMZTJ3bXR1MGwzeFZ6Sm9kRzF1?=
 =?utf-8?B?NjAwUThjZUU3ZzI4NzllTDlHaU43UTdUdnU3WkVORmFMamF4OXJ5bVlLeXh5?=
 =?utf-8?B?OEtwS0pkd09VcG5iY3FNM2VSUHd6RVYzWFpkcmg4aGhLQ3Y4U2NrZW96UHZJ?=
 =?utf-8?B?SGdtdWRLckg3UmFrNFpPSGdDYUh3WkV3QlBhOHkzSytMS3NoZmFBN0JML3Jq?=
 =?utf-8?B?eWNwRGNJQUJnYk1UUlRmOWc4UVZSVTBaZ29vZk1hMzlqVy9iTWs4MEYvcnhW?=
 =?utf-8?B?cWNSV0YwT1RZc2xPbUZtZVpjdnl6cTBLSTVTSHZGUU9wUUdQbFM0L2lSaUdU?=
 =?utf-8?B?bVJ5VjlSeFpjN3lnTE5SMXRSN0Z6Y1IzTTM5cW5WcFlkQXVkTjFiY3VIY2Zz?=
 =?utf-8?B?RDJ2V3YxM1ZDbzFTRzdxQjlaRFFGUkRFTUdZUXpjMjJvMmJKK0ZrcEp5TWh3?=
 =?utf-8?B?NDJ1b0p6d1VmTGpmaHhtbjdFdjlhdk8vRzZTOVRWa09SMkNUSk53dElyNFVo?=
 =?utf-8?B?NUtIS2E0d0V0S01neVlJT01KMGsvYWRjYUpSZ3dJcHlyMXRGb253aCtCMmQ0?=
 =?utf-8?Q?Ks+clOrKW9agWpXBgoz2zBo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGZqNnBySCtHY2pEUVdyd0hqNnRMaTVXSW12NHA1QmNtQkJoOHR2YVZLT1oy?=
 =?utf-8?B?MnZzRkw5WCtESWpRcmxuWXZsdCtQeDZJV3R0VHpMaUZKR2xYM2s0WWw0Z2Rx?=
 =?utf-8?B?U2huV2hwbnZLWml1SlRHb29KVmZpVWVBeWpPUXdsQ0o0Qjh4b3BZNnlSVG82?=
 =?utf-8?B?K1Rpb2lXRUNQc0twTU5saVJPM2NwYi9TTGszY1pXNnRFamhPSGJTTWpzYWVF?=
 =?utf-8?B?S1lkSDI5WXhVS1pDNFB5c1Rtenk0aTRJaDZtUFl5ZmVFUmk3UThTUFVQaXkw?=
 =?utf-8?B?dHlLdXZhU1dneSswKzIrNUgzemZHMEdEYmdIY3E3VWg4NURuY0pSZjUzd2g3?=
 =?utf-8?B?SHA2UDdpRE1VMXdGZ2NMaU40TmE1NHMwbjl6QVNaMXBFRm8vbkFBUGJOTlBx?=
 =?utf-8?B?UENWZ0pmYVp0c0xmVlkxZ1VySUFxQ250bUg2SHFEOTJqSFZMUmdnbEEvcmlk?=
 =?utf-8?B?YVBIMUVBcllJTDFxR2svUCtMd2kyT21FblVOQlJON2pXSStaN3ZidkQrUmt3?=
 =?utf-8?B?OUtOV0xPMlg2QUo2K1lVVnZ1UWk0RVpwbG1FRUJ4MDluM0Y1Mnl6RlFUcVVv?=
 =?utf-8?B?QVVrMlNlY05mL3U3T3FRSzJWdjROWmJyQTlmV3dWSlIvWllFMndsSGptbm42?=
 =?utf-8?B?a0FkckxPUGNOamREVzNuR051U1k5OVBoMkJid1ZkMUxKYkdvalVkMUhJazBF?=
 =?utf-8?B?amc1NUhKRmMzbmdtNjJYYm5yWnkzaGNSMWJkMUdHZWEyeWNsSk9hbE9sb3l4?=
 =?utf-8?B?N29EcmVVVFZRRlo4LzRueXBvSExmbVp5bVU0NmlpMFR0TVRUS2lFb3Zjbmg1?=
 =?utf-8?B?ckdNT0JpdDBpWGdQL2Z2eTYySWlWSHR1SHFaK0xKcUJJK2tvSmIyQ21IWDRU?=
 =?utf-8?B?YmJ0S1BkYyt5MEVJbUYrZThERFh2ZWk4eFc4V2xlRUdJejArU0FuOFgrNTFu?=
 =?utf-8?B?SU8zYXBkcURnY0wwSDF5ZW1ac0s3M0RNZVZTWk14NEpiQjJQK2FWaGVVckVq?=
 =?utf-8?B?WTlWaThjblpONWY2N2ZIbU5ReGUvSjdTZlFpdldaV045WlVRL3QwYktLTk0x?=
 =?utf-8?B?L3F5clFxbWR4ZTB6UUNYVlNyZnJhYU9DRWlTQXgyQVphRU5WbW9BUTdRZnFG?=
 =?utf-8?B?bEhqeFc3ZzFWUzFubkFENGNXc2tCSWFvYVJsWHBmSVA4VVJhR0lYSzFFWGMx?=
 =?utf-8?B?eTd1dmNoZGxCejMwZ21RQTVMNnZ4cXJEajRuajRYWXNsN0FzVUJIYmREUHNs?=
 =?utf-8?B?MlRFZEdoT0EwTVBDVlFYMUZCNzNXMHBZbnE4Q21Fbno0c2JmQkJGQjNXVHB2?=
 =?utf-8?B?cjJKc3docFFsK3NzcTByTVJXYnltdWNtU3dIbm94UkQ5YVpsN0VSaEczTXE3?=
 =?utf-8?B?dXVDbG1RTCtJaW1qRWxrRlowbGRxWnFDYUU1QndnN0EydHZSSE54VHRSSlF6?=
 =?utf-8?B?S0Z0UHNwd0xxN0h4YVJXV0gxQVMreFowalluNUVvcnB6NVk1eXBlTVVWWTA0?=
 =?utf-8?B?MHFiWFNuMktrNGx2ZUNoOEc0QWFOaGN0eGJoSmN6QlBJRmdPR3hhUVgzRUNF?=
 =?utf-8?B?OXcvVVNRQnRhQ0JYaDFndlpNa3RhdjAvVTdzUEJWeWRXOVBBOWFxaTNYZ0RJ?=
 =?utf-8?B?R0U1b2ZBUmZ5UnUxT1FQeldadC9KMVRodTIrd0hwSmtwSEtUNWR5aGI4Y0NY?=
 =?utf-8?B?Z29MaU8vTS90LzJMa3dqZGNxUkczTmswU1V0K2x2VEJDY3dIMVRmR0RUV2dv?=
 =?utf-8?B?MWp3R0pmTlh4eTBYQmhMUGIvUDBwTWFLN2lCMy9ienVYWXNsd3RXeWFuUVBU?=
 =?utf-8?B?Vm5PZ3dTcHcyRGlBNEQ3WHdwUndUYzlpdEdPUndkNjRDS0xuWEhmR3VjQkU5?=
 =?utf-8?B?Q3RWaVg5OW1XSEkwSVFUdlhOQkJvbTZyMG5DYmt5cjVkb2ZTVzFyb09zQ1g4?=
 =?utf-8?B?R0xBeTJFbDVXbklzYW8vMG1zbzNSY3pveDUvTVJiZm9qaktvdlhvdm02eWtM?=
 =?utf-8?B?c0hwZkFaNkhGclRvRUs2bDZSY0hCdE1FRytvNHNzNWRyeG9OSE1wcU9IcFFI?=
 =?utf-8?B?ZUZwZXd0T0dDWWUzc0RYeHRldnNNdm56RTc3Yk5yZEZ4V1doU0FUR1dhNlFl?=
 =?utf-8?B?d21QTkJqU1FCWC9SaUpkZ3I1alcxQjdJcmhDa3ErdGd0dmliYlV5LzBPRUty?=
 =?utf-8?B?dXRWL3N5SDRrS0pFL0FEaUUvTk9PZldPY01RdVlybSt2aVBwbHQ0djY2R3lh?=
 =?utf-8?B?YkZkM0VDclFIRmx3RUdBMVEyUmpuN200SDJEaUUyMkcrbll5bEJURXdYaFRR?=
 =?utf-8?B?cldBK2tTdmFkR3Z2T2VHUmZyOXU4ZzV2TW5aU3ZjZ2ZTeFd2MS9ybk0wdGs2?=
 =?utf-8?Q?n3WQTIkfDJP/eoFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CE5CE305FAAEA4082A715D44D9F6032@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7271ad75-4d3a-448e-62ba-08de68cfff58
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:12:48.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV9fM7c7RvqAi1p7dIoALhJsEenYqlVArjL4UOcMBbvnRK8hd2XG9rfq1cr9IiODXaX+drAu1nmyfIfyXqqMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9442
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31707-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediateko365.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 727E411E41B
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDEwOjA4IC0wODAwLCBSeWRlciBMZWUgd3JvdGU6Cj4gQ2xh
cmlmeSB0aGUgZm9ybWF0IG9mIHBhdGggYmFja29mZiBsaW1pdCBwcm9wZXJ0aWVzIGluIG10NzYg
YmluZGluZy4KPiBBZGQgZXhwbGljaXQgZG9jdW1lbnRhdGlvbiBmb3IgY29ubmFjMiAobXQ3OTE1
LCBtdDc5ODEsIG10Nzk4NikgYW5kCj4gY29ubmFjMyAobXQ3OTkwLCBtdDc5OTIsIG10Nzk5Ni4u
LikgZGV2aWNlcywgaW5jbHVkaW5nIHRoZSBkaWZmZXJlbmNlCj4gaW4gYmVhbWZvcm1pbmcgYW5k
IG5vbi1iZWFtZm9ybWluZyBlbnRyaWVzLgo+IAo+IEFsc28gcmVmb3JtYXQgdGhlIGRlc2NyaXB0
aW9uIHRvIG1ha2UgaXMgbW9yZSBwcmVjaXNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsbGVuIFll
IDxhbGxlbi55ZUBtZWRpYXRlay5jb20+Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBBbGxlbiBZZSA8YWxs
ZW4ueWVAbWVkaWF0ZWsuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVl
QG1lZGlhdGVrLmNvbT4KPiAtLS0KPiDCoC4uLi9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWssbXQ3Ni55YW1swqAgfCAyMAo+ICsrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyMCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdAo+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2LnlhbWwKPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWssbXQ3
Ni55YW1sCj4gaW5kZXggYWU2Yjk3Y2RjLi40MTU2ZTFjOTcgMTAwNjQ0Cj4gLS0tCj4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYu
eWFtbAo+ICsrKwo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJl
bGVzcy9tZWRpYXRlayxtdDc2LnlhbWwKPiBAQCAtMjUyLDYgKzI1MiwxNiBAQCBwcm9wZXJ0aWVz
Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvbGxvd2Vk
IGJ5IDEwIHBvd2VyIGxpbWl0IHZhbHVlcy4gVGhlIG9yZGVyCj4gb2YgdGhlCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhbm5lbCByZXNvdXJjZSB1bml0
IHNldHRpbmdzIGlzIFJVMjYsIFJVNTIsCj4gUlUxMDYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUlUyNDIvU1UyMCwgUlU0ODQvU1U0MCwgUlU5OTYvU1U4
MCBhbmQKPiBSVTJ4OTk2L1NVMTYwLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLSBGb3IgY29ubmFjMgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC0gQmVhbWZvcm1pbmcgZW50cmllcyBmb3IgQlcyMH5CVzE2MCBh
bmQKPiBPRkRNIGRvIG5vdAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpbmNsdWRlIDFUMXNzLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gV2hlbiAxVDFzcyBpcyBub3QgdXNlZCwgaXQgc2hvdWxk
IGJlCj4gZmlsbGVkIHdpdGggMC4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC0gRm9yIGNvbm5hYzMKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIEJlYW1mb3JtaW5nIGVudHJpZXMgZm9yIEJXMjB+QlcxNjAgYW5k
IFJVCj4gaW5jbHVkZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAxVDFzcywgYnV0IE9GRE0gZG9lcyBub3QgaW5jbHVkZSAxVDFzcy4KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIDFUMXNzIGlzIHRh
a2VuIGludG8gYWNjb3VudCwgc28gbm8gbmVlZCB0bwo+IGZpbGwgd2l0aCAwLgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTm9uLWJlYW1mb3JtaW5nIGFuZCBS
VSBlbnRyaWVzIGZvciBib3RoCj4gY29ubmFjMiBhbmQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbm5hYzMgaW5jbHVkZSAxVDFzcy4KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pbkl0ZW1zOiAxCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogNwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRlbXM6Cj4gQEAgLTI3MCw2ICsyODAsMTYgQEAg
cHJvcGVydGllczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmb2xsb3dlZCBieSAxMCBwb3dlciBsaW1pdCB2YWx1ZXMuIFRoZSBvcmRlcgo+IG9mIHRoZQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYW5uZWwgcmVz
b3VyY2UgdW5pdCBzZXR0aW5ncyBpcyBSVTI2LCBSVTUyLAo+IFJVMTA2LAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJVMjQyL1NVMjAsIFJVNDg0L1NVNDAs
IFJVOTk2L1NVODAgYW5kCj4gUlUyeDk5Ni9TVTE2MC4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gRm9yIGNvbm5hYzIKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEJlYW1mb3JtaW5nIGVudHJpZXMgZm9yIEJX
MjB+QlcxNjAgYW5kCj4gT0ZETSBkbyBub3QKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5jbHVkZSAxVDFzcy4KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIFdoZW4gMVQxc3MgaXMgbm90IHVzZWQs
IGl0IHNob3VsZCBiZQo+IGZpbGxlZCB3aXRoIDAuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAtIEZvciBjb25uYWMzCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBCZWFtZm9ybWluZyBlbnRyaWVzIGZvciBCVzIw
fkJXMTYwIGFuZCBSVQo+IGluY2x1ZGUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMVQxc3MsIGJ1dCBPRkRNIGRvZXMgbm90IGluY2x1ZGUgMVQx
c3MuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSAx
VDFzcyBpcyB0YWtlbiBpbnRvIGFjY291bnQsIHNvIG5vIG5lZWQgdG8KPiBmaWxsIHdpdGggMC4K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vbi1iZWFtZm9y
bWluZyBhbmQgUlUgZW50cmllcyBmb3IgYm90aAo+IGNvbm5hYzIgYW5kCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25uYWMzIGluY2x1ZGUgMVQxc3MuCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaW5JdGVtczogMQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4SXRlbXM6IDcKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGl0ZW1zOgoKT29wcy4gUGxlYXNl
IGlnbm9yZSB0aGlzIHBhdGNoLCBJIG1pc3Rha2VubHkgYWRkZWQgdGhlIHdyb25nIGVudHJpZXMu
CgpSeWRlcgo=

