Return-Path: <linux-wireless+bounces-17635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91CA14CBD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208E518853F5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68F1FA8EB;
	Fri, 17 Jan 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ugDBW7Hx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C751FA249;
	Fri, 17 Jan 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108232; cv=fail; b=fJ/P3IBfl2dIeQqla83katU3+AevXKDeeSjAjyX84TwPuo9qzbNxJ+qbJ/cHbVqSJ1mmXRuJNPJ4+Bs93rm/4td6/079X5H71ekLxXEG/TvaTE8XPrCtSu7p3SyR5FbUFAVK4K6DOh7w+vuwbuOC3kKy6q5zj/MN8FAdB790Ug4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108232; c=relaxed/simple;
	bh=jFV9vc2XVv4rBx5kkDWIZRJAYu5VRJDSOWK1/v2i4zI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0+rtfcMAIyF+Tvfj5GDXaaVkYADKSVANWcm8aCZkQvuqW1F46M+J69S1Z/LHa5fDTDiKup0XIUJjQqXdfXUNm2Owk7psNjlvx2c1u4FZOqzDHQM19F0uatNiL9lk/Gebaa4ayIeMgKXKyM6KAeXFZd53FkGPU7K7aM552F/WdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ugDBW7Hx; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js6BraS2XZfRbRzu/2A0PahCEMR1B0k+1atpB0kae7sD3UmQUsOh4xErbORP7gCarPkSClOWmvxhPiNUWOziG4eX22AXPYrFMsm0MC/Tumg+t35lx7Qa8yHMEQbQS1oqOp/b/r2NSfB7G6appOeOeW0T2DCqh+Mzfuv3ZgVEHeq8IOijHX7gX7DWS/khbbdxV/YGuChlhAvwv6Oq6Tn0SGxCJp8sofgEuhR0E2XOfi/GCNgzJXrSRQ4rTDwkP7zAS0IcxXny1uFN4gqKlcNN2dVSsERByoIU8P63Za6BIM9gZUfDRIBwr6QA3HVpBfmPf7XKKjkBf8OdztG0y0oK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFV9vc2XVv4rBx5kkDWIZRJAYu5VRJDSOWK1/v2i4zI=;
 b=RymfBY8VHGt1Yog0tZxAikMcko3CjJ64mcosGqjZj9i/1DH+TVRtPTL98mnKI4hywHdPuzCtRqw09MtHqFuPyougUlbIdL3xFQOA2sP9mCsNgKUs4qKDGIst5gqVUjF1ZfwyYFw2bKgpFGlypmEMkszATWxF2UUv2/zTuEpt6IctFdDTNdfcQCTD2mq+YJkGcJKxT/6M30gYz0F2OTCPwrdiRezFwbi1VKwc5cd2wJFelnEKqTo461YfrZCNWo2KZACvaWVhg/lzVzoPG1X/dtB36MKbyaXZRqNy/+/5wGYfr1LAtczHpP2giQzwKgDSmrax4Ekp2bjOFNNeqvuNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFV9vc2XVv4rBx5kkDWIZRJAYu5VRJDSOWK1/v2i4zI=;
 b=ugDBW7HxM+pQazadBsAZIZQ35TD5MXwwVM4YIWVYL0mn9tGuXr7M9T1ZjpkWxM8DkfTiL5u8030ujzyjpCbx8MSUoD2HjRaZzrWmbSw8lCRh9H1hQN1ftREQwHKaAorz5D1oyuhya/hYIxYhzyOlFD8d4pjefnFUOXNgg3pHb78=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by AS8PR06MB7733.eurprd06.prod.outlook.com (2603:10a6:20b:33a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 17 Jan
 2025 10:03:47 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 10:03:47 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
Thread-Topic: [PATCH net-next v2 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
Thread-Index: AQHbZ/ND6Q3HdWQzR0ykT0xMwNgnIrMaq38AgAASywA=
Date: Fri, 17 Jan 2025 10:03:47 +0000
Message-ID: <ba6e9717-00a2-464a-a174-e7364e7df9a7@leica-geosystems.com>
References: <20250116084702.3473176-1-catalin.popescu@leica-geosystems.com>
 <20250117-truthful-reindeer-of-perception-496bd4@krzk-bin>
In-Reply-To: <20250117-truthful-reindeer-of-perception-496bd4@krzk-bin>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|AS8PR06MB7733:EE_
x-ms-office365-filtering-correlation-id: 38cec8c6-bb70-4347-edfa-08dd36de3be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0JTUUp0eCtXZGZKVkgrWXl5YlE3dXdRUWVzUlh5dzFvSXc5M0VqWjNVUHEv?=
 =?utf-8?B?NzRLbFQ5ZmxCNXl1b3FKUHpzZmUvQmdmN0NBTnJLUFNOV1FtQnF4QnNZRW4x?=
 =?utf-8?B?VG1GNXhMYS95OTRVdzBWT0VrbzJPZHMyRU9kY3Vvd2liRzNTUithMDlWZXNl?=
 =?utf-8?B?RVo0dGxFNUx5SkNyQllkNkF4d0cyOHNJMlZHRkUrc2ZoM01uWVAyRmRPQWc2?=
 =?utf-8?B?bnNnQXkvSEhzTGNuVmNWRzdKWWxubDRFQkkyM21EZ3UyeDFLVU82UmdiNjJP?=
 =?utf-8?B?aTVVZVBvWjN6TWVWNnpHRjVEc2RaOVVHYzV1RVUxVG9UakRyWHVUMTFWTlAx?=
 =?utf-8?B?NEs5TVA0L0hDc2paeGMvM1g0c2ZHc2t0VExaN21UU2lxM3VJc2VzaytBRENz?=
 =?utf-8?B?Snd0Nm9HbVJ5Z1l1NldLTVkzN0pOZTdkeGVtRjVHTy9SakdsTGdiOEg0RmVL?=
 =?utf-8?B?OWlWai9RQVhRZ05GZUMxaFNrL2RlNlNqZFBOZDBhdnBDR0JhZ015OG95M2pZ?=
 =?utf-8?B?Qm95YUUzMllZM2w1eFNMbEVrdU8wSDk2YVpVaGtqVjEvNGdMR0RiUWlwbVFK?=
 =?utf-8?B?YnIwNHc1MWd6M3lGaWhacVdTenR0VUZSdnJLL1RGOTZHVDZTRVltQ2QzRjFD?=
 =?utf-8?B?b2phSjE0SmdsUit5UGtZTHZjbkk5QzliUEJKcDNHRWpXMmRIRUEyUjZnZzE0?=
 =?utf-8?B?ZmMrLzV2c1pvcEZGWGRmVTB4VmVtM2tEMmJNZno5NmRuTDFsREpCcUNZeE03?=
 =?utf-8?B?d3U4aS9OWU5xY1BRMUtWN2NhcHIrQVAvYUtKQWZvR1VaTXlqcWpDK3JvaGZL?=
 =?utf-8?B?bkxlSE0xWmJEYlV3cmdMT1F5MlVhTWp1czZ4YWdUa2RWU1NUVno2VGg3cjU3?=
 =?utf-8?B?Mng0N0Nwa3RjRVNnMU5sT3V5THlDNWxGQlgxQUpMcXNuSnF4TUZmME9XcVQ1?=
 =?utf-8?B?dnVjZC9UU3ZxSTRXUTd4S1cxV2lwQXg3bm90V2JwQUpBRXVFeDlDZjVhWnEr?=
 =?utf-8?B?OUlYRGhzNlRJOEJxRmRENklXYTRxdWxwSHJXVjdpazY1M2JRSk04bVFNbXRh?=
 =?utf-8?B?Y21pTVAwNzF4VS9xT29xL1hqaE10YVh6aGtDay9nbDc2NFB3RWp1THdHbmlj?=
 =?utf-8?B?S0doaFV3Ui85N1B3Y2tyTjk0cGljZjFCT3VHR1p2ZUU5QW5wMURPVUtUOUhF?=
 =?utf-8?B?NHhFZ2xqZUdvbVpuMVpWdFAvSGFHck5UL3FDRm1FUklsY3RXRHVlZFdEenhC?=
 =?utf-8?B?bWhGZkdVaFVPZGk0MmdKUllQeWJscXhaa0ZRQ0FuL2h6d255NkZ6TmJtai91?=
 =?utf-8?B?N2hCa0ZZT3VsaS9HWFZsR0k2Y2JPdHAwakNUUGt0b2FFZklrTGRpRHNmTEdT?=
 =?utf-8?B?aE91N2JFMTdmQ0FmSSt0YlVBRi9XRm84TlpMb0dnRWFNMVo4MWdjQTJGdnd1?=
 =?utf-8?B?VW5FVytVd3ErTjRYRCtHZDVYUjhnR09yVE8vYXI1dnZndndxZGlhc1dXc29z?=
 =?utf-8?B?eUM0QmNjN1orbWZCTThIaURCRk1EYTQrRVhJak8wWFArZUQ1cnpaOGFjREtJ?=
 =?utf-8?B?ZkRmeE44TDQwT2krd01WSWFrVmp1cE9jL3FjbUh0aTlBL3U1LzMwKzZ2Y2g4?=
 =?utf-8?B?SDJGZnRaNlFvUzFRbmZGcjFobEhIYm1RaUlWY0RqWG1COUEybHluZXBmSkpQ?=
 =?utf-8?B?RXF1RkxLeDlibTBQQjAvMEM0bmg1ZXYzL2tCMTdsdGQyM29zU054TjB2RDNw?=
 =?utf-8?B?bzU5Wk9hVkI4ekkvNEFlZlJydnB5b2NGQjB0OWt1S2pURmRqaTBCdGhrc3Vv?=
 =?utf-8?B?czRiL0lxa3NwRWhIMWk4UmY5QTNvcG9WQnA1Z3d1UTRZVEp4NjNsMVNYeHNL?=
 =?utf-8?B?bkdtTkwwbkFtYkRlNTh0WnlPenl1WlUzU0JJR0FBUFJRR2todFZpMFBvaCtv?=
 =?utf-8?Q?d2gIEaeZHwgk53nGsmY7NFRF+LUSRSpM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG02c0lOWGszaHNqMjB4dDdnb1ZncDdkRGYxTlc2d1pNUHpoQ0RSSjJsV0ds?=
 =?utf-8?B?SWZxdlFnMUc1VkJ1MmVpUzM2b1NxQzZSQUdXSFZXQjhSYUpKdGlUOGovV2Zr?=
 =?utf-8?B?SDJVeUJaeCtJaXJRMTc4Lytua1lVeDBzV2taaXBqVDJ2NmhwRy85Tno3emdY?=
 =?utf-8?B?eldOcFJvNDJGM2MwOTg4QUtET0tqem1wZWJ3MlExSXNMdEhOZ0laZ1YrZ0hn?=
 =?utf-8?B?dEY3MVVRcnFmSUJ1SXNpUmZkRHVnU0ZxMityYkIvSFRiOTJGSVJCVXBMVnoy?=
 =?utf-8?B?QmprQmc4MzltbGNVVzR5aHFjc3dxYmxDYlIzWTZxSkJUQVRDZE9lK0ZzMS9y?=
 =?utf-8?B?aFV1ZVBLSXVnQkZnOHhGek8yYU5ocGNkcmp6NkthQmcvUlYrODV2MGZMbExl?=
 =?utf-8?B?djF1aG5wWllnWmlRcUNrNHYyNWgwOWx4bTZWUy8zMWNYQXQ3ajFzNDhsRW9s?=
 =?utf-8?B?aGVrSm1GWkVLd0QvaWx1a1pSNWp3L0gva0F1cWh5cDQzclVRMC9IMlhKcTdO?=
 =?utf-8?B?L3RUcnFjVnVkdnhyRVFjTkhIaGNhbElpODFUK0dyYTBmMit2ZWFGSnhhVWdk?=
 =?utf-8?B?MkNtdmVGOUl6ck1xdmdUeFF2cG0xTnhUam5YNXJXdWlSRG5PZng0WTFva09V?=
 =?utf-8?B?Z0doaGpYQmw2VlMyeDZzQjMzbjJRaWRsSVpZellQNHB4RmFJMmpiN3BOTVpk?=
 =?utf-8?B?ZlY3b3ZtUlhwUnFJM0pNR2REUmY1Tlg2TFk5QmZQRGllV3BESFJ4RW1qbGpr?=
 =?utf-8?B?UWVvZit6R1RraGV5SkJ6SEdQWkhGYVhLb2g3OXg5VGtBTE5RTll5TzUwNHlt?=
 =?utf-8?B?RDdVUEduNVRPbUZyZGxha29IYWdlY29iZTFLUnQ5a2x4WU5lQU5XOENUQ2tq?=
 =?utf-8?B?TnhubDBwbCtjM3UrYko5dTBGd2hyRUc1L29xaE14Vy9OZTBYQWtwWWZxVHEv?=
 =?utf-8?B?QkNKVWNnMjNwU3RrT2pBOTh4Y1JvVXBnRGJQbnB6WENKcTBFSFpxckVSekVW?=
 =?utf-8?B?RnFHY0ppbmFEQ0V5UFNiUndiSWxvNUVRNUJTMVJvTEp3UHh0VXo2THZvM0J4?=
 =?utf-8?B?dmpIc25URE8ybjQzQy9TYmlLYjBYU2pTWTNKNUt4Q0dsdXgyVWFSSitlZnAx?=
 =?utf-8?B?dmlJUDhIYXd0d2prVXdLU2hqOWZrUUJ0MEUreFlyVVpDeEROTDlZdlJIdDR1?=
 =?utf-8?B?dm9FRWdMSWJTandFS1VvVW90K04vaHluQWZpenFrbndCUlZjdVZmU2lFenp3?=
 =?utf-8?B?YzAyTWZLdFE2K0NsNVNkQllLeU44dFRUalRMOUFBRUFjbkFONjFKeXVUcVlx?=
 =?utf-8?B?SG5DdnUwMStzbU1RMXl5YW5WMDJPNGtycWVvdTJDbUhuRGhIZGRFdlY1dEps?=
 =?utf-8?B?eEJhVnB2ejRZOHZDQUJGRzZpdUNxQXZsOEFpeHJ1a1Z0VTl6MVJ6Qkg2OUZy?=
 =?utf-8?B?SEdxL2Z1MUFRYmRQTnlva1NFUFZnSkk5SEhjTjBwV3lDY2Y3MGVYc3BQOVQ5?=
 =?utf-8?B?bk9sckNuWkhFRElzY2pSalZ0Yi8xWWdFYUNDb0QycEV3TzVYMFpXZzBzeWRK?=
 =?utf-8?B?Nm4zZmlKazZ2YjJ5K1Y2eHBVT2hRL0I1M2Ztbk9TSndYZ1NSeHAxNUFIV0h5?=
 =?utf-8?B?RkdXMS9vZWtGY3JzUkdKUy9HWEcxQmtTejlDZW1NeDRJQ3RTaVgxYStWYWE0?=
 =?utf-8?B?dGRnektyclZ5djdXUS9ZdXRFK1R6TkJmaGx6MHdJNG9aM0RJQVQ5VW5UU1RI?=
 =?utf-8?B?M1JidTl3ajlWK3NsMW9LN0pqbjNJK2puWFFKMzVNejJDMlllSkFPeXlZcnlJ?=
 =?utf-8?B?a1FCSWthbjlVRnNuZUdQb21nbnQ2TmZyVDZmR3JJSVhqOUVuREFTbHlnSkEr?=
 =?utf-8?B?bm9lbEpoM251OEJVL0dpSGsrbGtvS25hdDB0Njhqc0JnRTNUWGhYd2ppNXBZ?=
 =?utf-8?B?QjZsanB2NnhqR1JiU3FSVlJ3UlFNU0N5STFWQ2FQRVF6cGx4cXJ4T090Qzls?=
 =?utf-8?B?anltZnM4VC9idDVMcytRSHUwUEhwZmZrSDZiUTRtOFdiR0FOdnBQekVsU0w3?=
 =?utf-8?B?Vmo1cC9KakhQNzZPL1RzOWw2TDFhdnplRmF3RHIya25SZno1UUpFRk03bDRP?=
 =?utf-8?B?UUFMUUk4cjZTNTNSTVUwc05LN1NNY2Y0UkZxWGRMMmJ4SDVXVTNCT0c3OXZW?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC7F581456F4B049A0F05E136AB78A57@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cec8c6-bb70-4347-edfa-08dd36de3be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 10:03:47.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZTrUSJoSrOYnI6ME5thFSVCxu0+k0RXFeQAdZXVXhHMg2jqabwIAiN6RQWG3+kwOHLHBM6dpDAo1EaIglZMc9AwS15gTaFUhNdvUAI2wJWNY+kQ4H+4tqqGwagFUo6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7733

T24gMTcvMDEvMjAyNSAwOTo1NiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gVGhpcyBl
bWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2Ug
YmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3Ig
cmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4gT24gVGh1LCBKYW4gMTYsIDIwMjUgYXQg
MDk6NDc6MDFBTSArMDEwMCwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4gQnkgZGVmYXVsdCwg
cmZraWxsIHN0YXRlIGlzIHNldCB0byB1bmJsb2NrZWQuIFNvbWV0aW1lcywgd2Ugd2FudCB0byBi
b290DQo+PiBpbiBibG9ja2VkIHN0YXRlIGFuZCBsZXQgdGhlIGFwcGxpY2F0aW9uIHVuYmxvY2sg
dGhlIHJma2lsbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDYXRhbGluIFBvcGVzY3UgPGNhdGFs
aW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2
MjoNCj4+ICAgLSBjaGFuZ2UgImRlZmF1bHQtYmxvY2tlZCIgdHlwZSBmcm9tIGJvb2xlYW4gdG8g
ZmxhZw0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
cmZraWxsLWdwaW8ueWFtbCB8IDUgKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L3Jma2lsbC1ncGlvLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L3Jma2lsbC1ncGlvLnlhbWwNCj4+IGluZGV4IDk2MzBjODQ2NmZhYy4uNGE3MDZh
NDFhYjM4IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9yZmtpbGwtZ3Bpby55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L3Jma2lsbC1ncGlvLnlhbWwNCj4+IEBAIC0zMiw2ICszMiwxMCBAQCBwcm9w
ZXJ0aWVzOg0KPj4gICAgIHNodXRkb3duLWdwaW9zOg0KPj4gICAgICAgbWF4SXRlbXM6IDENCj4+
DQo+PiArICBkZWZhdWx0LWJsb2NrZWQ6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL2ZsYWcNCj4+ICsgICAgZGVzY3JpcHRpb246IGNvbmZpZ3VyZSByZmtp
bGwgc3RhdGUgYXMgYmxvY2tlZCBhdCBib290DQo+IEkgYW0gYXNzdW1pbmcgcmZraWxsIGRvZXMg
bm90IGhhdmUgdGhpcmQgc3RhdGUgcG9zc2libGUsIHNvIGl0IGlzIG9ubHkNCj4gb2ZmIG9yIG9u
Lg0KSW5kZWVkLCBvbmx5IG9uL29mZi4NCj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCg0KVGhhbmtzIQ0KDQpCUiwNCkNh
dGFsaW4NCg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPg0KDQo=

