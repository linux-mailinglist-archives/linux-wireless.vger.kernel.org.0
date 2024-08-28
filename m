Return-Path: <linux-wireless+bounces-12143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945DF9622BA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B60828678A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01698167296;
	Wed, 28 Aug 2024 08:49:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAB165EF2;
	Wed, 28 Aug 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834995; cv=fail; b=iuC43Jo4korALpEmMWdm6djqt19yJBOnGrAHAnTPk6jrpr+hGjo4B5QxrWMxpS369DBD+8Va28Jft/PJhGs+fcVu4/2clA09IVLTrosNJ7pBBmlcIUTuR5NEBhI2SowIBgXLPra5mCTm/6e1DGPunwPV+5sHgq93uGvIO34qXBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834995; c=relaxed/simple;
	bh=JsL/vIHDMaqpLADA0x3lqz9mV0Y31bnYSpXIcUwpmVE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qmxm66MH1MReBlBUQrSjxE+tajCYjqKjHQ7ue3pkn0ThcIaDs38nP0JceqZXuw8wtKy87/+sRKo42XF6Cae6vtK16KBqrmp0G7moUeN6jx4PNyquS8Sp8ciR//VcLhQ7eNljGZMOUqlFZ+f674kGKFFfsKutMYy8cvb8kLKd2mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWAGNd5izRcyBJSkojGdlE01YYA2rxU01l4HJKK7otK2Q0FjZTWX3a0R2TeJ9/WQ4CUtBWTdKJaNy7IPFp57dJgidTfg+TsLAlmM1h8YLYXmJOxlK8SXbT7k5zQ1jLR0dGd5qjBAEPVU0YbA4mXqKTPrNZat3yZLDhkF6c2zxNChLexnBAT6R3KJueEKMVhEupu+7f/tH7s3T2OMNgLoorx4CwdHF7/pj3Ht+LiOabgY3D6NtORtZ/TVljAteLtVIAImAObo2cS05DD8yKmOFhpqSMI893nEyYSAB/sCsNohTZ2CbJpf5H46hMDN68kNWfnkYwShBi92eAPzerhlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BGfZQm1BRaHSCcvnV1BQzz9wLf/fFARUUlFVnsNLzg=;
 b=cllrVgIFpFRx6hdo7L6z1mKmnVwqNr7rQuyHbafkaA0RhttbAIEiHgcnJvKt7x8ns8dhaGOSp3RGGuMhdodWweLZt/GRdyCrWSkxbig3KkKsUSOeLvlTHJVW4on+HK7iRWQbGkE80pQGJUX53oqD+TwmFkWYqLylD1VykLr06SpxnwZPAXJm73ckfjim+ucqgdjJ0UHGXDDFksqXEpdc9wxgI7Dnvnbrax0Wjlbf/QtZnnq+F+yYrGo1oCSEGcvAmw4wjRrNYyhp62d4PJLJZn5cD1u+3WOVTxA3rMWPdpwGiib6mRxz6n3RYMxThVxZKNMPb8XkU17p9B69wxETog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:49:49 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:49:49 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:49:24 +0800
Subject: [PATCH v13 3/5] dt-bindings: net: wireless: brcm4329-fmac: change
 properties enum structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v13-3-9998b19cfe7e@wesion.com>
References: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834980; l=1920;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=JsL/vIHDMaqpLADA0x3lqz9mV0Y31bnYSpXIcUwpmVE=;
 b=loZ7uTArZbRC7ZMmPU6cTt+dveIhxiIgJUW7Uw2f5Hrm2MYjAzHd4oMzx0R1Gbl5SJW750HnW
 VsY3m2kz18ODmRvWUYKuM4eo7FYXKq/WELEE9nq484K1XoN/vnKaN9/
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: ee58e8a7-4a1d-4d25-db23-08dcc73e5fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlNkMHg4NThXeVAvWkdQSFdXK1Bkei95alYwNlZibXNWd3NNSTVYQmJ1SFpR?=
 =?utf-8?B?dW92R3VyOGVMQUc1K1FORlFBb1Y4VksyTWttZnNmbHNIOFd0MUJDOWV5d0Nw?=
 =?utf-8?B?aVNiY2Rob2lQb0RZL2tVUGZpUnRPNkIxWDhza3piY1FMYlBDMUF0VzJTVTky?=
 =?utf-8?B?VW9aQ1YrMjcvNzZwOXhjZ1hwN2lxZU4xNEpwVXpYZmpxS3BEQzVaSEw4Q1pq?=
 =?utf-8?B?SThlbFBhb0VVSVZLdnBUazRhekpoUCtZQ215U2NKZEdHWXUwNmRWbm5pRE1B?=
 =?utf-8?B?ZnVhYWxrQUlrc0pVaFhJRGhRa3hJazRTWTFRclpKQi9NUWFneE5jWXFTS1pm?=
 =?utf-8?B?ajhLM2JhSHBUZEtmSk5kNllvazFuSUJIZGJNVk9pNWpSWG9LSnhRTDJFQmpt?=
 =?utf-8?B?amI1bk45VjlUdnVqQ3BoWXdjSnlwMERMN0x2SWtvZ21PZmtnbUdHaUUyZk80?=
 =?utf-8?B?SEpibXpNaWUxbFlDcU5PNU02RGVrVUZtVGJYalFwL2R3TlJkMFJEL0ZmREI0?=
 =?utf-8?B?R21tdDFQdWE4T1hMZ1QxQ1RxdFFWTXRuNGlLWXZnVzVtUVFwR1lRTHNYeEN4?=
 =?utf-8?B?MFgxUzFNVzBSTUpVRnUxZzBKcktQbFJzZEpobjBvSjYvUHJpYTl2bUV6UWQ1?=
 =?utf-8?B?WXZTUDVKZGEwdUg0UVFPbTdNSGMzWFp6YUJjNXM2SHpaQ2xJVC9mbkM4MCtT?=
 =?utf-8?B?bUV0U0NnYUJ0Z3JyR2xONi9MMjVBcXNkcW51clRqbHBITjRrazJoampWQmlY?=
 =?utf-8?B?M29jQXYwSW5iQzRFMnVuL1dyaVBiWTkwS1ZsQnUrQnM4bFZETHBNWXFUQzhl?=
 =?utf-8?B?d0NBNGQwZjN4dmt1aTYwQnNvcmIvM2RWZW1Hb2hJUmFFNDZXb2tTeXFkMW0v?=
 =?utf-8?B?Nm84SWlOeDUrWHdPL3BhVUt0NDlOWU9EOHRTWWFTQVhNNHl6aSt2c0hmdFAw?=
 =?utf-8?B?VkE0djV5R0VObVdKOTF5NE5ydXB0YUFGWkpoRHhHQ3FVNTkxY25TRndESnkr?=
 =?utf-8?B?OFJINGhRdmF6bzNvT3NqNUJnY2gwM2xLZVJHOEtZR01RSHFld2d2YytweUti?=
 =?utf-8?B?SzRYRjdCWDFKenFkcEswaCtVb1lValp3TzUrNTk2ODllUW1FZDR6ZGViWHFm?=
 =?utf-8?B?QklVYU91dXEwU2c5TytCcklJMXNoWWtNdmV3VE1NOWYrOHJwWTBHdUFHcE9D?=
 =?utf-8?B?SllxVTZRd0pRZTU0SDZpN2hSckVEM1VPa0t6TERXS083bFh6TXpLS3lHWjFT?=
 =?utf-8?B?eXpRQzVGTGg1YXUyeERYc2pkR3VPZXZXMEQxSFpWU091TWYvVG5VQzc0b2Fp?=
 =?utf-8?B?T2VJY2ZjUS9MNnhhTGVyekY2VndMWEk1RU8rd3EyNW5Ha3NYaERnYUN5UUFP?=
 =?utf-8?B?ZEtzOXZhUFZjQlowZVV1K2NlTkEwdXFKS3dWakNJTllHbUZxVkxWcFhJOXdx?=
 =?utf-8?B?cFdTYk9LYVNBY3lCTFZvNE11dGZURWlMVGVhdUFvMitQd2ZhR2dWcHg4b3RT?=
 =?utf-8?B?M1VLbnR4NndEVVBMblh0MlBoTGp6Rm5mdUpDT2h4UWxqWDZNbEhMc3lpUlVP?=
 =?utf-8?B?K3B5Z0ZGcEEwYW15Tit6OFVycEFYV2dYNERFZkFHNnB3b0VyMWY5cFdlUjkw?=
 =?utf-8?B?clJueWVyWXYvRXNvcnRhMEUxT0diWHBUTVRMQ1cwK0tkbG5hTG9va29kMjhp?=
 =?utf-8?B?YUVaeWNsZytmQVNBUmhqTU91bjhJa2hRYnBNSVVGZ095Y1JDY0Q4ZVZ2TmFB?=
 =?utf-8?B?OURlaHcySmI2bCt1cDQ2em1GQlcvbWh1d2hjbk1Cbjk1TjFBS2F5bEsxUGpG?=
 =?utf-8?B?STJjbGx5VTBHb2plN083bWpDOGhLaGxiV0VqS0Y2T0tTUm4rT2hVWWIwbC9W?=
 =?utf-8?B?anVWd3hjeXBxUDBra0pLVlJ0QXNXL05lOE9qZXhPS01vUWhnWmtjd2FUcE5a?=
 =?utf-8?Q?nzmdgcUsh1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V09BbmFjaUVzbzVaQVpiTTlacFRzVDE1SXYxTmQvYzdWZXNkbGJ0ZzRJcjV4?=
 =?utf-8?B?TFFBM2FSUlM1eFQ3emU1ZDlnNGREL29ZZDl1MFdaUmF0R3k4Mi9ZdHh5ajhK?=
 =?utf-8?B?ZzV6NG5lcnRtWGNKd0xKWTdrUEQwWERxalJEQ3VYNEVrb3NFR2NOVjNCWDJJ?=
 =?utf-8?B?OHc5R0NMUlU4eFd6N1c1Zy9ENUd1TStYKy9UMGY1TDhLamFqSFVHS1hGL1pw?=
 =?utf-8?B?RjVkTlpwUDNlVk9OMy9IZEE5SWQrdUN0K0hWYzZsVFQ2dEFUSTMycHlmc1Uw?=
 =?utf-8?B?RGVnRGQvNUoyM3NHNTRhVWZWakJtQzAvZDEva0s2V3RBamtIdjRlTjNzZzNB?=
 =?utf-8?B?cU9XZGFCOXk1ckpNMnhiRVVzaWhyN1k4ZlhhYTAxaXJrdjlPSytkSEV5K3F2?=
 =?utf-8?B?Rks0Qm9yQTVTbnUyZUlVNGdmU3Vzam5INGdZMTRkU08zMElWVWtvbWlINTVy?=
 =?utf-8?B?KzlsemdqTWxGdlFOM3VKNEdNL1IxVFI5ckFQeE51ckV6VUZneDg1a1UzT2s3?=
 =?utf-8?B?T2hqNm1nVGdEcmFTSFN3Y0lWUjJ4NjdjS1RhakFkZ3M3bnRqM284L1V5UHA4?=
 =?utf-8?B?cGJQOGhYVkpoTTFpL3V1dTBYRmMwUkNNbzVBMHpYaGJ5N21PN0Noc0Z6QWhS?=
 =?utf-8?B?S29scHdTbGxwN2NNZHc5MnoyL3RHYTNqeHhHaWx1VVhOZE4rRk9wdWpuYTFn?=
 =?utf-8?B?R0h2dDhPNjhRUEpITkszdUQ1Rk1WVHJnbWtNVUEwTitxbUNaRWhGc3FhbUVM?=
 =?utf-8?B?cEJQMEl2UENaNTdJTE4ybDJqR0FrWGxPd1Jza1Y2OEpna2RuZm03K3VNVFVw?=
 =?utf-8?B?VUdoc3FoTlhvUWk5RlM2UENCSnFkcE9VK0tkTmg1NFZ3N0t4TTAvUm02SVlq?=
 =?utf-8?B?T3lyNmRia0lVTHRGdzBGU1FhbGVUS3RuUVZGTC9qT2tsbkxVeEtBNUJjendL?=
 =?utf-8?B?WW16T09uWURycXZRb3F3NFV3emFWY0dXbExhRVVVbUxJNkhsaW80RE95MjlL?=
 =?utf-8?B?aFRxQ0pIVllBWDdVRWpvOGZUMEo3aEdSMklWWHNrdGRLYnZiUTd5UGJzS3JU?=
 =?utf-8?B?UzNwVWlNMEFvNlh6V0hmend4eDRISHh5WGRYdzFrcXU1ZEpqMzlSVUt0ekdT?=
 =?utf-8?B?QnFRVXBvSFFxVXFmSTdZZnZpOUNnMzlpdktOL253Zi9tSytTeVM4QTJBRDFs?=
 =?utf-8?B?eml3UEFOOHVtRHlvQ0x6bWQ2VENEN2kwZVRoRUxBVExObUVCQ2V3bkQ4Z2pD?=
 =?utf-8?B?dEZzZGZwU1FiZU0wT1laYTRvd0FWMGN4RnZoQkJxV2dnbjNhdVZ5bHpPNmdM?=
 =?utf-8?B?YUkwTVIybkVuZnQ1L0VsQXlBeEUwbVBadDNsSS80cHY4bkZBclR0M3NOeGpX?=
 =?utf-8?B?VTJ5NVNKR2s0NU5OTFo3OUpHbmdjMGhVZ0JvRVNyTEFTMU9Nem51TGViQU55?=
 =?utf-8?B?L05QR0tKU20veWcxYU1sTG9hejdTMTdoc3phQ21QNC9FWHFCOTNUNWk0OGtu?=
 =?utf-8?B?TTA4cDJPcVhUZXJxdDdodEFDTGc0YkgrQ0ZNRVg2OGFCS2NON2ZFSG5VTXZV?=
 =?utf-8?B?Q1BsV3lvWDBYWWs4aFcyRm45NXEwOWJBalZqRyt2b1RmeXFnQkJDaHR1QUVr?=
 =?utf-8?B?MU9KNTJFS2x2SFQ3REpqL3NrMS9CS04vR2lhV3VRdDdoQnE5bmtXUUhqKzBV?=
 =?utf-8?B?ZHZwUCsvWkVRRmFkeEVDTWQrUk53TUQzRWhDd2Frb2dIWDh0UWkvR1FoSDgr?=
 =?utf-8?B?NHVBWHFUTnRudUJ6ZE9JekIrUU10QUhVc2NTQlhzYmhtZU41a2dYc0I3OWU0?=
 =?utf-8?B?cUhwUE9UK0NPeGVEM25NQm0rQy9paUlJVWw5ek1PeVBjdEdKSG0xUmFydEpk?=
 =?utf-8?B?cUR3c0U1WEw0Y2FSRnB1ZEhkSlJPUExnYWRiRXpsOWZjaTBJNU1Cay9UMlRJ?=
 =?utf-8?B?N3BCTGtQRXV3bUFhYnV6THdPdndyeGVNUVlzckIvU2NzVmpna2VXUmxwbnNk?=
 =?utf-8?B?bG1NTmNRNmVIbFhvZ05MRUNhZHY1d3VSQm5Idnd1OWtJOStMUjF0STdjRm1H?=
 =?utf-8?B?dHVLWGNwaWtNN0NmekVoQ1NGT3kyUVJ3N045VmxBTDZjYmx1U2VwTDFOeGNy?=
 =?utf-8?Q?AgtRcUxGj/aC+AlhiRsGOD9mB?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee58e8a7-4a1d-4d25-db23-08dcc73e5fe3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:49.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGZEmDm4WxEq5qzqKj4QtIKDp1svyZntRRowX5rUhM3K8CvVqh6qZp1Bbl33NBtx9/aW/CQsZnTpyhBI0fnKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

Add "brcm,bcm4329-fmac" as fallback compatible for wireless devices that
used PCI ID based compatible. So that can pass the compatible check in
driver.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml     | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index a3607d55ef367..4870caed5f75e 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -27,7 +27,6 @@ properties:
               - brcm,bcm4341b0-fmac
               - brcm,bcm4341b4-fmac
               - brcm,bcm4341b5-fmac
-              - brcm,bcm4329-fmac
               - brcm,bcm4330-fmac
               - brcm,bcm4334-fmac
               - brcm,bcm43340-fmac
@@ -46,14 +45,17 @@ properties:
               - cypress,cyw43012-fmac
               - infineon,cyw43439-fmac
           - const: brcm,bcm4329-fmac
-      - enum:
-          - brcm,bcm4329-fmac
-          - pci14e4,43dc  # BCM4355
-          - pci14e4,4464  # BCM4364
-          - pci14e4,4488  # BCM4377
-          - pci14e4,4425  # BCM4378
-          - pci14e4,4433  # BCM4387
-          - pci14e4,449d  # BCM43752
+      - items:
+          - enum:
+              - brcm,bcm4329-fmac
+              - pci14e4,43dc  # BCM4355
+              - pci14e4,4464  # BCM4364
+              - pci14e4,4488  # BCM4377
+              - pci14e4,4425  # BCM4378
+              - pci14e4,4433  # BCM4387
+              - pci14e4,449d  # BCM43752
+          - const: brcm,bcm4329-fmac
+      - const: brcm,bcm4329-fmac
 
   reg:
     description: SDIO function number for the device (for most cases

-- 
2.34.1


