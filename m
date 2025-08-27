Return-Path: <linux-wireless+bounces-26669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38467B377B3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 04:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA0D2A5138
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2942272E41;
	Wed, 27 Aug 2025 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TPNrXvwq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012071.outbound.protection.outlook.com [52.101.126.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003327707;
	Wed, 27 Aug 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261508; cv=fail; b=MbCiYNfkc5VeKGAm0Mj7pXdg9lha7VHEfNA17KCnJaHZuI0XL2/7jhoTSNfb8OSXd5tbVz8Yc1FAVyA9hmlzCqFvPjLUDq0dtvtMSCcsEw5L680d7ShY8ioga4Z+TslvFpy4cPUwLhRlGvDOqhQFgiGvFTsCkWK7G3Sfmo00uEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261508; c=relaxed/simple;
	bh=8WhjwfxgBLXHThRk5HtI27hdliNQP3CXRdwdrZczYU8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VDPcAn7zoOkCPgvYsG0M02mBrozsY2EwVMXsKDbwyeM4WmBmWHV9nv5yZGnCAz88BtGrUOgEX0vpJX9EHkb8zjv2jENRVVFFduy8UMa5YBqqtSvbdrtyuDrRcafHtJpm+JI/Sm5ivtxYWJ12V/pNCeiOi+cf4FuBhv7SnvALRVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TPNrXvwq; arc=fail smtp.client-ip=52.101.126.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/K0L674fMhWwVFIlEfnHGKyL+yE1OQ1p80y/ObPtuxnlFcsXj8c3/L7hw9nrpYmNW27R6IzwQNun+ugJyskOjSBTFOER3rRlsuBOLCorYJXkkwhxUwiekjjaiJRAV63yxHGHOyGWTmPojlYeqcc8pRXlp9NiAvmPmfiTCQE6iHDdmfkXqy7LZ3VRmcgBmxsbgymxtj2mnHIzYhARNstsEF09SdFqDXPXVDEHK3MLFgH2KoOyv3Z9bIyDoi0W6Ql1fOLd4yogWt9FaN71cGQxalq6wkrAkHmoHcisXboWS/9oBlDAqjFDXTnCQEpDfBvi6sA7aIc+4aEvbsxyJJu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcWon4ONIg0lkqF0a46OcEowY4k+AgVFCuIU3+Ab7tE=;
 b=aSSZYxCv0WK4mHB8p8mDCD2oXX2kHh8p1/fXCwmTPzb5AtnUqw8ANtrp66nu+/RzAmUCSJmgTlZLS5G4kSOh/T8LNt+AdWQ1ftHMGYmAIsLXu9lE4TPJhkq8TdeYebUsNy0XWDrTA+l6cSqCJUVJdtSBmOKKyoDut2W0qh1AvUoMBUhC5MiLYI/tLr09Xe73MRQnPD8lKR9JyRwQzZFg6cBAiaPYOJ4BAIu3lk692qQg2tE2SHN1vEFXcIk6M/8TLcjD5sal5CD5ZVeKOSGY5qHgEmhKhCmgUpdeY7efmAv+V5mX6AavuXLUvEp9DN4gCfehbhcqLVgwaO9/ifIYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcWon4ONIg0lkqF0a46OcEowY4k+AgVFCuIU3+Ab7tE=;
 b=TPNrXvwqOtvdBydykQAgLQ5mSDnhtOfD7WHorEj29Gr974p7nZshfjwbhjF5cBvFIH8E/3xS6YQqO2AGir6hUQUYLqw/L/iJqxZUNfYzy00KGY5EJXLgSiErYSdCFTVln2JTI7JH5PP3PgoqWKYZqgqTP9UjXv4vNZw9VYXyFqzD8GG3x4cboxLYQciqE3rR1rzAzCn5Xdl2420UeUjEq73DiqtUUZZ33PG0nfhaCmVsEGayOtoZlbop9NBpvjBqDpXD5iPpl8YtqaTvEVE8pnI3kP1Sc68VqHl99mOVLdCMj6Qbg0mStHlVepH3fLM/vK+zNbJLNqN98QDmryGxzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SI6PR06MB7147.apcprd06.prod.outlook.com (2603:1096:4:24c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Wed, 27 Aug 2025 02:25:01 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 02:25:01 +0000
Message-ID: <3e38b927-ea3a-409c-93b6-32f86fe68110@vivo.com>
Date: Wed, 27 Aug 2025 10:24:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw89: use int type to store negative error codes
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250826132905.501755-1-rongqianfeng@vivo.com>
 <b1f89b89906a4573bb8a916ed33763b5@realtek.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <b1f89b89906a4573bb8a916ed33763b5@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SI6PR06MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a76757-bed1-4a9a-d019-08dde510ec9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z01qUTdEM3Q5S3RKTmJPMThvVHFBUEZPT3hQeFJNdWJvbFArenZiaWsydDdR?=
 =?utf-8?B?c0lJWHdmQzRON0NQcHZkMkYxOFp2U0ZocENqR3dqT3ZNdVluQ0tvaHQ4bHZP?=
 =?utf-8?B?WDl3eDh2TDU0bzhuSThITXVBa2s3THB0WldCQ2QzQVUzNE1KK3lRVHo3bGtw?=
 =?utf-8?B?dEVLSWFyUzVmZ25wY3dka21ZUG5VV1FOREpPaG1IQ1pyQlRiT2F4SDMvNy9E?=
 =?utf-8?B?UXZIeVZXd3J6NFByQ2FaOWJsWUE2Y044SlpaR3FZaDdTdDdWZlg0eUJIOWhZ?=
 =?utf-8?B?OWVJY2xqOXdBclBJSUFSZWNYcHhHajdvSXNhWW1DUDh2SldPZUUxTjZFY2Nw?=
 =?utf-8?B?bFFjZkJWaEpDamlManNuQWg2aDFKNGIxTnUwVmtzZlhnUEhReFkwQWlSUzE2?=
 =?utf-8?B?ZS9mTENaM1FQdWZLajZCL2xvSTh0YUxMMDZXSXpvTTZkZVJkdXk5UDhKS0Q0?=
 =?utf-8?B?bVVjR2hEWlREUktTajlQUnd6QktBRytEZ2c2NjZibG9wazdaMG51TGpiT3Rw?=
 =?utf-8?B?L3RaN2xFYTYxdW1ESUdyZG5LV0Nuek9JSnBhZkxRd05nRllJTjNZRDFINmk3?=
 =?utf-8?B?TWZHV3UvSWpGNFQ2QVNPWlVqZVFGUWZlZnFFUmRWSms5cE1McWdrZkhXUCsv?=
 =?utf-8?B?RWNqNmZoekNJaTIrbHlRWVJhTzN5SEJZZTU0Y1dEUVRHcm05Q0JpUzdHd25i?=
 =?utf-8?B?dFlYaE95bnM1Q05Ld2hCRFhQaVhYdmptWCs0eVRwanloNllKdjhZUVM1cGdO?=
 =?utf-8?B?TEV4VUhoRzl2WFdsbGdMb2tJYitvc3IxWCt1aWdaUUw3djhRYXNPTDFGQ2gy?=
 =?utf-8?B?enRqUldjY3B0RGpHR016d2pXWjhBV0ZDZHgzR0ZSdVVyakdpb0p1TUZsSnJl?=
 =?utf-8?B?K1dGTXdsanE5VHZmYnEwYmh1M2JkbUFvbkhSUDVlaG0xSDlUb21Id1U0UHdR?=
 =?utf-8?B?Q25vTjVSQVljZ2N2MnNETFphTmZROEZYczNxZGV3UURjYzErd1Y4dUl2Z3U5?=
 =?utf-8?B?QUw1RWU2M3l2aitsWXJGd0VDeVhLY1JSSTBKcjZXbDBkTXgvSmVQSWpzaHlr?=
 =?utf-8?B?U2k0bi9JaEs2MUY1SlRWZTZ3TzJDYlFqY2NGRnM5TU1vaTAyR2tpeTI1UGRw?=
 =?utf-8?B?T09FRmlnNTJiRjBnMlZFRGJVNVlLSHpUN0xaNldIR0VzTmhxalF1a1N0dzZR?=
 =?utf-8?B?QWV0Vm5QWGNBVFUwNTk1bHJpQzg2cEUxWkd3STFVVG9YWkk2OFN2S1FUUHlY?=
 =?utf-8?B?M29PUWxwdGs4SFJpdGdpODhQbmZQVE8rVnp4TzR3SXl4ZmptQW5xUm1VNmYr?=
 =?utf-8?B?dlFmWDNCa0QxVy82WHN0azMweXRqR2FpNEIwMGtZSmVPZWZhZDI4NkR6OG9K?=
 =?utf-8?B?QmdXNXY3eDhpUEo4dW8yaHI4ZVRjSUZna2lTdzNlK2RuL3F2bFJnNno5MGcx?=
 =?utf-8?B?aWJ6T2ZYMU5IdUcyZ0c3S2E3TEtvL2FRQnJFenR6L09oNVZST2VwWm1xRXND?=
 =?utf-8?B?YTB3czE0NXNYVUpIMVVyTUJ4RGdjcWc5ZDBXYmlaMHo3RDB1cDk1RXpTU1B6?=
 =?utf-8?B?eTk1aWNySzNmS3pzTnE2RGIyWVFscUFWcFZ1REJwaDNZUVpacmEydk1EUkU1?=
 =?utf-8?B?dmpSUkhiQURpM0o4N1F6S2EvS3pRbCs5K3hxVDBUSTl4VjBLdmh4RTl5MFlD?=
 =?utf-8?B?b3orSjZwOVZ1dXA4bkN2cXVadldzbjJJYUptS1NVcXlkMG1NdzZBZy92emtH?=
 =?utf-8?B?aWdWbVR4ekNmTVVrVU5aZGs3VjhxK0ttWERBcWZjd1M2T05sOWU0NitYY1FT?=
 =?utf-8?B?dHhTeFRSbFd4UzlaZ3N6RkZQdzA2OUZGM3ppNjVLdE1UelhEY1d0V2ZneTYw?=
 =?utf-8?B?bTVIYk12QTRDVjBLMWVHWjl6dDVzYmMzbGhFZVdsQjc3ck9JaXRQM243MTVy?=
 =?utf-8?Q?aMU3CE8EbMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkc4bVcxSytPVyttNDZLVCsrNmJkNHI3cFJPUU9VTkNXWXJWTEVtSjYvSlJj?=
 =?utf-8?B?eUJuV0VQNlMrMFJCTnlxb2Nuck40ZU56amlaK1ZEYk1wL0tpeVIxYStGQjRp?=
 =?utf-8?B?eVVlbTJxMHFQalAycXB2Y3dKendLWDdaanFpRFJqUFJ4cVdsN0NodTJQUm1o?=
 =?utf-8?B?ajZEVFd0WlVWSjhZdjh0cDNBSVdGakZObkdRd3c3NmpxbHRCa2NvWXVSMEZB?=
 =?utf-8?B?a0k3QUxGdGpzYlBrM2lGSVJhTVU2eUR5UWZHTS9IQUlFNHpQc3RySG9uRXlP?=
 =?utf-8?B?RUl1YWdlRVZod1hyNXhsWG8xUkhWZE1YVHRTSHBMNDB0aWRvUjZhOGlyWm1C?=
 =?utf-8?B?bkJwN2E2WHVDd3Q0ZEdjWlRkUTFFMThvNDZadnFOMGhKa09jZ2lBOGwyN2dh?=
 =?utf-8?B?TjRjN3VzRmFSS0lCNlAzUFJxSVYzN2tMMWNOeGQ3QmhSbElMcXI4UTh3eWph?=
 =?utf-8?B?eFRIM0puOEgvMGZIWFpFMU1YL29DWFZ4UnIxTU5tWEdML2RPSVpSR2FFeXJM?=
 =?utf-8?B?aTNTK3NKZ0IxNnVaNG1QQ0dQcmtHa1J1TTVrc08yd2hLVnNMYm5PbkhCY3lQ?=
 =?utf-8?B?WWNkcXZCWjkyRkJTbDNybmFieUZmRnZKdmt4bEFKVXRQU2NhMEVxZWhDQU53?=
 =?utf-8?B?L0xDZTFWczZzU3BUeEtPZ01JQnpoY0RCSXpIUjkyNUx2a2tVT1FrQ3cwdVFl?=
 =?utf-8?B?TmFUbThLRzZ2MmtDRW90RVBHUURxK0ZqT1VZdmJvRGQ0bm1QKytyUU5VVXF1?=
 =?utf-8?B?d2xTdnErQWVFbzNpa1lTZDB1SXR1TVo4cWVURWhwNjR3Y2l0MkZkOUI4RUxU?=
 =?utf-8?B?SndEZnB0K1MwYVFBWThWbkN3RW8rdVhkTkFnb2JDLzdHWEtwQzMzTmh3dlF6?=
 =?utf-8?B?YU5yWTkvTHBNWnVKaEYxemFUb2lqak0yWCtQTTFqd2MyemtEa3dyQTl6LzV0?=
 =?utf-8?B?c2FZQXo3YnZiQ2tRK1BOVVJqcHRBTzFDRUdNbzBzYjl6YXlobSs1MW5UKzE4?=
 =?utf-8?B?ZkY5NE94QUVJMGIyc0U3MU96WFUzc3l3VURXbDRLUnAxa0xEN1VET1lVNEJP?=
 =?utf-8?B?b0dCdVNXQk9WWjMrS2VYTXo4NFUrWEFrMmFBZitmOFhua0F5Qk56TE9EdU1S?=
 =?utf-8?B?eitPT1pHc1pTQWJ5S0YvQnJ2RktlWGNGbldWMzk4M01sY3BodEJzS2Yvd3lo?=
 =?utf-8?B?SnNpaEh4M2hOMXFLUEJIYzgxNXRTdmNBZklXazZhQTNTVG1GQ0hTTGhIUmYx?=
 =?utf-8?B?anFjVFNyQWtIVjlIU3dFeFBvcWMzd3k0UVBGclk0OStNSXJQaXhaUllORUY0?=
 =?utf-8?B?emF3NnpING44RXBJdWRTblhyZTBRZlZOQkhUWmdRVUlBWTBlZjZLVHZmRHRZ?=
 =?utf-8?B?T1lTRlgySVQ0U25VRk5rVFFCTWNEYWJqemN5alJkTWF2YTBJV2pXajl0R3Fj?=
 =?utf-8?B?cnNyR0JMejNKYjhnUGdRdkt6YjNKV0VtN21Ra2dCcngrMWRvNCs5Vks2WCt5?=
 =?utf-8?B?SGNvY24zY0hhdE92RGpHMEY3dzNqaDBDckZVbG5QZEpWN2tia1k0Uno2VlhN?=
 =?utf-8?B?dTZVM2F3R1VFc3FSSmdPYk53VGFCMENsclZLOUNsSlBLd0Z4ckFNYTFmNi94?=
 =?utf-8?B?V2hEdnl3S1JveGN2N2Zlekx6clpHZTErdStCaDUrSXFJR0R4aitFY0JMbzZk?=
 =?utf-8?B?NW1oSXZQQlBhNWhqNVAwc3I0UllSVzNPWDlRNWNkUVpHYktSbVgvUzk0QUh6?=
 =?utf-8?B?cUZ0LytXU0N0em9yNU5ONFJMazBBRDFNMHJJVVRNb3J6WVVoT0ZsVUVabThZ?=
 =?utf-8?B?c1RZb3gxOU5RUjV6SkoyQXZqTHA3eVltZHROTDI1Q3V4UE1SWDFxVTJSQisy?=
 =?utf-8?B?bXlhUWtzc1BUYWhyYUtZZHJjUHJHRDVPMFpZY3prZlVLbUsyMzZlU1Jqdlhy?=
 =?utf-8?B?NndUYnhtUUVNZEFzVTVaRkdZdENyNzR6VmpsM1VLc241UUhpWVRFdWVPNjZV?=
 =?utf-8?B?WGF1S05kS0tWZUVEaTFUa05aTFRRV244M1JiaFoyWkdBS3UyMGdPQmhxZHg4?=
 =?utf-8?B?QkNtbUJaU1RORkpzNDMrL050RzBtcFUxMWZXcGZjUnRrVDY2N3c4SlpmTkdN?=
 =?utf-8?Q?OdUVYTW3aUf5D9zN7lkgfmJ6A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a76757-bed1-4a9a-d019-08dde510ec9f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:25:00.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PNMIW1QRHvQ65xjIBJR8M2tbyZW1EblcurALnUV3kk1B67VDMKQWeS0dk7sgowBijVPqAEGPwGn/mTmhXY9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7147


在 2025/8/27 8:42, Ping-Ke Shih 写道:
> Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>> The 'ret' variable stores returns from other functions, which return
>> either zero on success or negative error codes on failure.  Storing
>> error codes in u32 (an unsigned type) causes no runtime issues but is
>> stylistically inconsistent and very ugly.  Change 'ret' from u32 to
>> int - this has no runtime impact.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/net/wireless/realtek/rtw89/fw.c  |  7 ++++---
>>   drivers/net/wireless/realtek/rtw89/mac.c | 16 ++++++++--------
>>   drivers/net/wireless/realtek/rtw89/pci.c |  4 ++--
>>   3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
>> index 16e59a4a486e..01d53f7c142d 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
>> @@ -1537,7 +1537,7 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
>>          struct rtw89_fw_hdr *fw_hdr;
>>          struct sk_buff *skb;
>>          u32 truncated;
>> -       u32 ret = 0;
>> +       int ret = 0;
> Initializer is not necessary, by the way.
>
>>          skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
>>          if (!skb) {
>> @@ -6826,7 +6826,8 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
>>          const struct rtw89_chip_info *chip = rtwdev->chip;
>>          struct rtw89_fw_info *fw_info = &rtwdev->fw;
>>          const u32 *c2h_reg = chip->c2h_regs;
>> -       u32 ret, timeout;
>> +       u32 timeout;
>> +       int ret;
>>          u8 i, val;
> Keep it in reverse X'mas tree order.
>
>>          info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
>> @@ -6865,7 +6866,7 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
>>                       struct rtw89_mac_h2c_info *h2c_info,
>>                       struct rtw89_mac_c2h_info *c2h_info)
>>   {
>> -       u32 ret;
>> +       int ret;
>>
>>          if (h2c_info && h2c_info->id != RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE)
>>                  lockdep_assert_wiphy(rtwdev->hw->wiphy);
> [...]
>
>> @@ -3105,7 +3105,7 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
>>   static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
>>                                    u16 tx_en_u16, u16 mask_u16)
>>   {
>> -       u32 ret;
>> +       int ret;
> Please move below to be reverse X'mas tree order.
>
>>          struct rtw89_mac_c2h_info c2h_info = {0};
>>          struct rtw89_mac_h2c_info h2c_info = {0};
>>          struct rtw89_h2creg_sch_tx_en *sch_tx_en = &h2c_info.u.sch_tx_en;
> (move here)
>
> [...]
>
>> @@ -4158,7 +4158,7 @@ static int rtw89_pci_lv1rst_stop_dma_ax(struct rtw89_dev *rtwdev)
>>
>>   static int rtw89_pci_lv1rst_start_dma_ax(struct rtw89_dev *rtwdev)
>>   {
>> -       u32 ret;
>> +       int ret;
>>
>>          if (rtwdev->chip->chip_id == RTL8852C)
>>                  return 0;
>
> The last statement of this function is 'return ret;', but actually it can
> just be 'return 0;'. Please change it by the way.

Thanks for taking the time to reply. All your suggestions will be 
modified in v2.

Best regards, Qianfeng


