Return-Path: <linux-wireless+bounces-11656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5F95838A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17A71C23AB7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EED18C932;
	Tue, 20 Aug 2024 10:04:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F718E355;
	Tue, 20 Aug 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148299; cv=fail; b=Qil1DWYZsoTNoflxuQ2/MUmAgfmhL0VJqmxLAHl4jZXrzcXfntUf2nkwSCzGLUirCKAog86tYWyV+cZiyebA+r1I5YkDGKMraFk4SZEgPHMkaj2RTF1ekxjz/BQqFrxKQBOKVPFsL57+nqHWYqabQJitE04E+2h1lq7NHNxmqPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148299; c=relaxed/simple;
	bh=5Vw9fLHA1SVCn960v0l/3HZXX2tR3Dw3mLf/iYRE+LM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPXb1eyRytbs8NbHldmVA5cExWyq4NklO9ji7rbcbWu4folD2Wa/yY4PqWmsspNhSfl7cHgSYfPDuUcNXNTwS5vqmHI1bSWxnYEfkhd/DbrGhGps4ecXBg7aOqy8PD0e4LaGxp1BU2H+hPvRSwCMlH+y4ZIXena0viKG6Y2KKAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNBdXOo6mH4hi7iqzdA/bziRRKB6ljcfxGZCm+pQmISUoZWbmcIs4ImzpU4MQIRK7y4tzNzfMC9swqFAoMpvEeZXbX7M+L34Lp4aSg9MhLO4DGDlMc0CsKsJSloO+WpIxeGnqvkF+aiAYU9X93sxoUhRO588mjSeL2B6NBZNjsVixFvFJZOQzWLDFfY+y6gzauYLf1u0KLBfjeCQK61LRXuTVRa68T7oEgCvPJfwgTy20Eh9bjcVUj1Qe7sqmqUgd0OCZersN3KPErJuh9AcmE4FscgjKmnBEXo7P0pMrTBvh0i+zWrZafC5XPFUpe6gmdAe5ADgVWXS238NQENq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqNZcVRTT+NxfN+IUoUpG6cHEGTUzMoOn7f727ZX5HI=;
 b=Sl6WtIZ0YhGPsEsY+OXtrLMtP+rd6pqmep4vLwHtIbh2ntQVgcwBENmeBf9R0sB7iaLKdrGHSkbgK5Yi/eRj6jIMQxmwl8A3rR5uUk5llDKEykYbe5X18+sGPcjRztgw6F5To8mGcc1gX14eWFsF/V1bqKMhb08X6MTTCl4NHIg+Ph9R3lNL2mZwRUD3a2PmyH4cZvQZa6mAGyjqfdshQVcTKZCO47drvhqPOc+G7xa9l8aVeVJoFQxpduJOLBzxd54h6/YN8waj0uC+xko357EatUiUHZ5nWu+eaTWx65xHytkttB66VJL6qD3NBBNfuu2yFfe3l1s+ZAFCS0OcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8064.apcprd03.prod.outlook.com (2603:1096:101:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:04:52 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:04:52 +0000
Message-ID: <9f1b9b00-00c6-4bd9-b255-aa59a00f826c@wesion.com>
Date: Tue, 20 Aug 2024 18:04:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/4] Add AP6275P wireless support
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: bhelgaas@google.com, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, christophe.jaillet@wanadoo.fr,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 duoming@zju.edu.cn, edumazet@google.com, gregkh@linuxfoundation.org,
 krzk+dt@kernel.org, kuba@kernel.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, megi@xff.cz,
 minipli@grsecurity.net, netdev@vger.kernel.org, pabeni@redhat.com,
 robh@kernel.org, saikrishnag@marvell.com, stern@rowland.harvard.edu,
 yajun.deng@linux.dev
References: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
 <67d67f15-4631-44ba-bc05-c8da6a1af1bf@broadcom.com>
 <xc5226th2sifhop3gnwnziok4lfl5s6yqbxq6wx4vygnuf4via@4475aaonnmaz>
 <7c2c6d22-399b-42e7-8ac7-098f036e9e81@broadcom.com>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <7c2c6d22-399b-42e7-8ac7-098f036e9e81@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: cba42de5-0b8d-4305-9e04-08dcc0ff88d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzAwRHMzZ2NKWGRrRXVpQ0k1MUZEL0wyNmVHUzYwSzVEb3pCWDdnZ3JzSlBz?=
 =?utf-8?B?WHd0YTRZeVp6Z0c4Umw4ZUNCdEt3cXFuZU52clNaZVdYaVI5M1V3ZXhRNEVm?=
 =?utf-8?B?M0NtUnNMQkhzSFFwNEJlcUwzeHBhdFUxTzBGL1dXVG1xN3hpZHM4amZRVzRa?=
 =?utf-8?B?ZEovOWF6U2lMTVNFSUVMcVl0bDRKZWJYRjhZbmRmblZNaFRnVVpnNEJ3RGtG?=
 =?utf-8?B?Y3B5ZnIvVWlQTFREOFVqT0ZBSkt3RDlILzhiSVdRVWkySnVPeVYrU0lvZU5I?=
 =?utf-8?B?MUk0ZU4xdHFFakJvV0lRUHVNckVEMlVpSm5QWkk4UVgva0xsZmpFMmVqQ2Jy?=
 =?utf-8?B?d1RqRFhuaTh1U1NBSk4xcE9qTWNkTHVyTnh2d2owZTNxRURFdHk5RjRNTEYv?=
 =?utf-8?B?YVFSMXcvc1FHc1RGdm9TWDllc3YrY09oeXhCcDZBVDNzMWpKL3dYYldnZkZw?=
 =?utf-8?B?N2dsQi8yVGRFL2RKZmhxTFNSb3poQklOZ3Z4L3IvSTNEOWhaT0ZuRzB4SG54?=
 =?utf-8?B?QUU4TTkraEd0bUg1aWtzMTM2NkVTVmNPR0ZCSThQeTRsamdRTk1EbHEvNjE1?=
 =?utf-8?B?SXU4QWw3cDV4Y3ZNRlJaWVY5bXZ4alJwWFZGUzhFOHFWbEV2cVdFVWRvM2xG?=
 =?utf-8?B?U0pSOVZsbnhKUXVkWEkwbzJyL3VQeXFUY1JGOXdGR21za011V0phVVlkZU1l?=
 =?utf-8?B?aDFvQmF2ZkxMZlBuMmhUMzZWVVAzR0JuVzVPcDhUSFNhdkJjeTFEOEM1bzJj?=
 =?utf-8?B?UHRYWUkvTlF3czZKL2RSUjI2STlzTG00L1FhbWdzV2pxZHo1b3BSNDRYdDlJ?=
 =?utf-8?B?eERoT1JtSDA0VEhmTHpIb1ZBZkpreCthUElmTjhVY1pHaUtyZm5lTE9iYkVO?=
 =?utf-8?B?WHlrcGM3K05HYWc2dUlya1l2TGc1WURmK0luR0xxMkVxblM1dC9OTE5iT3J4?=
 =?utf-8?B?QUtUaXY2RmJRQW9IVG0rcTNuMkFDd3VnVmVqWVZWSmJkS05SOVVGNUc0WVBl?=
 =?utf-8?B?N0srVFcvODQ1SDFZUUl0UnliYk4wZVRBUmc1SkkwWFhFYUNyb3JCYXdBNnJF?=
 =?utf-8?B?NFR6bUw2M1RyZmRtM05Ja05GQkk3eC95dTNNbVVtU0oyMFB5UnJ4TnZHVWdk?=
 =?utf-8?B?d3E1TjBtUkV5ak82ME1iYUJuNkdrL1hDaC9LQnB3S1VLMTJLQWVkUUR3VTQ4?=
 =?utf-8?B?aS9NTG52WDB0bk4rS2R0NksxZERhSHY1enZvMW1RUmdrOC8yZXV1cnVRTldT?=
 =?utf-8?B?U3MyNlhsZ3Q4Q05aRnhnRnJoQURZbE0vR3NYTWEyd1daZHBwUmNRNmZYWXBM?=
 =?utf-8?B?UTVyMmdGMWJwUlM5QnM5WnZscitybU5zeEJENStaam5MQllEUjA3MExQZDJG?=
 =?utf-8?B?aTFRQmhDQ1A3OVhkbURwcmhzS1pYRU5hbTBKV1MvbjBtcHlCd2s0U2RUOENO?=
 =?utf-8?B?d0ZDaUlPOFk5MkVzbSt6dDNUVlRENzhYcThmVkpEb0M0Ny9KRHRqNzk0eUN2?=
 =?utf-8?B?ck5MRFVMc2pOblBRVjh3T1d0eVgzTXpCSjBxME8vSUhwWlQxZCtpNklsQlRD?=
 =?utf-8?B?ZGlZeE9KbUpsa3lNV2kzYk95ekVrZWV2NjlXbStVTDJzOFg0NkF5bGZWSm01?=
 =?utf-8?B?SEYyL0cxVnpsNkpNUjNsOFFTbHArQlVZU29UVjdEODFIQkZscmZsRWdoUjE1?=
 =?utf-8?B?QkZLU0tocW9sR2tRckZwQTRhZHZscWpGQ2R4Zk9ndVRZNE9RZTBYM0NNSVUz?=
 =?utf-8?Q?8oXUjvNnABSTKdtiJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVPSVNqd1hSOSt6andaR3VIVm5zMk1pVzlFVEhiV1VyQTNyY29KNU45NjRk?=
 =?utf-8?B?eE9mdVBEQ2ZDZ3VyV3lsR1dLUlF6dE1pTEdZWVNEUjl1WXJLajBjNDgvRmFl?=
 =?utf-8?B?ekhVMDFkY2M1cmw1V1Z3bjhkbDE4NFY0bU5ZV0JmVVlOSVl6WXFIMUpvS28v?=
 =?utf-8?B?UytNWjZPOFRvQi8wS1RLTkl3UFlZbVdQeFE5eGxEeVpOcHBSeXhvZHN5MTda?=
 =?utf-8?B?dE9qZ3o1QkpOVWI0Y3MxM0I0Y0ZPWVd3ZFh6V0FCNnVRSkRoZW03by9jdEFs?=
 =?utf-8?B?eDM4aWZNUWI3NkxFUWNrT3IyKzA4cGh2Wk16VWI5YytOWW15MEVKN0FkQ3p6?=
 =?utf-8?B?V2ExWGtSVmF0aHlZNWNPN09jMDN2Mnp5d1RiZmFwTVJleEVYSGQ0TCt4MExs?=
 =?utf-8?B?QmdZeU9FdHlsbkxzY1F3a1JpVVk1NGZZN0N5WlhlUjk2RzBldlk3elE0Q3hH?=
 =?utf-8?B?YmRTYjNzMGtQKzZpeHY5NStIbEVLWkFCNkxCdzNKdTcwNE1Wd01EN3ZJZmx4?=
 =?utf-8?B?eURRdjUrc1llZjRZWmNDaFRTSDcwVmhud2hlZTZUTDk2SDdSc2VsR1Vtd2VB?=
 =?utf-8?B?ekprNGdPLzlxemRwWHQ4S2R0OHM3T2FVMytCRlNWUTR1RDFQamFnemRrWlZo?=
 =?utf-8?B?RHRLcVdvRVppd3UvRFpmK1hIaE5HcGNMbEJXdXphdG5CajJwUFlHOTRMYmtq?=
 =?utf-8?B?YWEyNlRLamlmWnRIRlVyeTdwVlBkajRHaHZ1Y09KMmRxNnh1aGo2M09SSWpi?=
 =?utf-8?B?VHk0SnNKc01OVElJeFIzVVBFbVpmcGlqOG1rQzV2ZmIxT2hRdFJMSFBTajNW?=
 =?utf-8?B?ckluclo1OVpJOVVqSmlZS3hLVVdkdGV2cHF6QW5qOUFTd1dVMWc4bEhqT0pW?=
 =?utf-8?B?ekF5SU1PUzl0b1g1RkIvWnJiUkdMS2EybVVtWEI2NEZTMFJ5SGpYczVZdXlC?=
 =?utf-8?B?UGxGbXZiZ1pkNXNIZkpxL2s1L0lFd0lVcWN2OHA0YThodXJBYzIwakIwemI0?=
 =?utf-8?B?VnUrWlpXUlRuNDRhUE1LVjNIekxhZmI0OTV4RERZQ28zUzFhZWFjRUJ3R3pq?=
 =?utf-8?B?bGd2Wlc1MlpjOG9hVUl4Q21Mby9DeHdRdVlIZDJsa2U5cEFneE1Dc2hmQ3lq?=
 =?utf-8?B?SUxzSzFDSkJ3NUNSbElZVm5Cdnh5MUUwQlBWQVJHVXk1Z0Ztbjl4OUg3aGs4?=
 =?utf-8?B?ZTVwaENsaWZiQ04xNXFMdW1YeGozL1FibTFNcUJCWVNZemtOa29vdXF6SDcv?=
 =?utf-8?B?dHpJOE1hb2hhTHJ1WFBZaC9TVTRzV29XUE1IUnVyK1dGb2hqV0FOTzZVWURp?=
 =?utf-8?B?S0oyc25SZnh3T1oxcXpyVlNBa1o1eFE3WDVENllzL243UnB6bGZDd242cGxu?=
 =?utf-8?B?NllYNDdwaHJUY0dteDh6SWQ0dUd2MkNXeXFZQkg0SWdBOEVSNDdnTFArdEZ4?=
 =?utf-8?B?Zlg5MjRtL3NqcTYrVnJkeTVFRFpuNnJLeFhyeW1LNERDZEV1djVqajZLRlB1?=
 =?utf-8?B?d0xLYjRRK1F6UFFhZldJUHhWdkR2TENNK1lvZFN1MUpBYUs1SWpwQ2xSendX?=
 =?utf-8?B?WkJlMDBETWVJSlhhRXBTRTZtb3U5ai9KK1JRUFJ4aVBIbG1zSDd2clBnY05N?=
 =?utf-8?B?aUVSaUpCSmFOdFUxbE1Kb0Q2UkREMiszQVJsVHFNdjA3ajBRbTZ3bmhoazAr?=
 =?utf-8?B?TVdhUFJNYU9UbDNqTVVGdEdkbmljUXFoTCtDUlBQWnA2SFdTOHNvVFZpclVH?=
 =?utf-8?B?ZUM0OWdmVHBaQXlSN0VpNmJJSEJaMzlrUTlGdTlLWW5jb3ppRWYvSEFJc1NP?=
 =?utf-8?B?WXlnVVdZQkF0UHkvalY0V3YyQmx6ZWIwWEIwM3hhQjlSa0YwTkd4VTR0Z3li?=
 =?utf-8?B?NDdyWW1lMno5MHNpcFY4TzQ5cTRIZXdlck51c2Z0V2kwSVhqZ0VJWXBPS01o?=
 =?utf-8?B?Wmg2RDhxcmk4NU1XcDVUV2xPbVB3bkM2N1BuL3hhcHlBeTVYaEpZVWxvK1F5?=
 =?utf-8?B?a1l3dVQwOVB5RldLSWVDSHJ5L21QZElQd202dmQ4RGhLUnR6SmRtNVpuY0VK?=
 =?utf-8?B?Y0hRaTNvakFNL1pUTUVPSk5mSWJ5M25YVTZNUEtzdyt2cWcwMHkwdWdmUnRp?=
 =?utf-8?B?SU0ycjR3ZVhVM2ZmR3o2bTFiOFJsZ2psTis1ZGRER0lhUkZGQVI0UmVobitM?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba42de5-0b8d-4305-9e04-08dcc0ff88d6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:04:52.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0V2wzC01OPpBr5oaRUVaROMc1MHX6J+W5uHE/ySpUndweIFFc2ULxsB46aO31Fo1vBM60zuQszJ7nsUTsJakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8064



On 2024/8/20 17:53, Arend van Spriel wrote:
> On 8/19/2024 10:33 PM, Sebastian Reichel wrote:
>> Hello,
>>
>> On Mon, Aug 19, 2024 at 09:35:12PM GMT, Arend van Spriel wrote:
>>> On 8/19/2024 6:42 PM, Sebastian Reichel wrote:
>>>> I tested this on RK3588 EVB1 and the driver is working fine. The DT
>>>> bindings are not correct, though:
>>>>
>>>> linux/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: wifi@0,0:
>>>> compatible: 'oneOf' conditional failed, one must be fixed:
>>>>
>>>> ['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
>>>> 'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0- 
>>>> fmac',
>>>> 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac',
>>>> 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac',
>>>> 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac',
>>>> 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac',
>>>> 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac',
>>>> 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac',
>>>> 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
>>>> from schema $id: http://devicetree.org/schemas/net/wireless/ 
>>>> brcm,bcm4329-fmac.yaml#
>>>>
>>>> It's easy to see the problem in the binding. It does not expect a
>>>> fallback string after the PCI ID based compatible. Either the
>>>> pci14e4,449d entry must be added to the first enum in the binding,
>>>> which has the fallback compatible, or the fallback compatible
>>>> should not be added to DTS.
>>>
>>> Never understood why we ended up with such a large list. When the 
>>> binding
>>> was introduced there was one compatible, ie. brcm,bcm4329-fmac. People
>>> wanted all the other flavors because it described a specific wifi 
>>> chip and
>>> no other reason whatsoever. The PCI ID based compatible do obfuscate 
>>> that
>>> info so those are even less useful in my opinion.
>>>
>>>> If the fallback compatible is missing in DTS, the compatible check in
>>>> brcmf_of_probe() fails and the lpo clock is not requested resulting
>>>> in the firmware startup failing. So that would require further
>>>> driver changes.
>>>
>>> Right. The text based bindings file in 5.12 kernel clearly says:
>>>
>>> Required properties:
>>>
>>>   - compatible : Should be "brcm,bcm4329-fmac".
>>>
>>> In 5.13 kernel this was replaced by the json-schema yaml file. The 
>>> PCI ID
>>> based enum which was added later does also list brcm,bcm4329-fmac so why
>>> does that not work for the compatible list ['pci14e4,449d',
>>> 'brcm,bcm4329-fmac']? Looking at the compatible property in yaml which I
>>> stripped a bit for brevity:
>>>
>>> properties:
>>>    compatible:
>>>      oneOf:
>>>        - items:
>>>            - enum:
>>>                - brcm,bcm43143-fmac
>>>                - brcm,bcm4329-fmac
>>>                - infineon,cyw43439-fmac
>>>            - const: brcm,bcm4329-fmac
>>>        - enum:
>>>            - brcm,bcm4329-fmac
>>>            - pci14e4,43dc  # BCM4355
>>>            - pci14e4,4464  # BCM4364
>>>            - pci14e4,4488  # BCM4377
>>>            - pci14e4,4425  # BCM4378
>>>            - pci14e4,4433  # BCM4387
>>>
>>> So how should I read this. Searching for some sort of syntax 
>>> description I
>>> found [1] which has an example schema with description that has a 
>>> similarly
>>> complicated compatible property. From that I think the above should be
>>> changed to:
>>>
>>>   properties:
>>>     compatible:
>>>       oneOf:
>>>         - items:
>>>             - enum:
>>>                 - brcm,bcm43143-fmac
>>> -              - brcm,bcm4329-fmac
>>>                 - infineon,cyw43439-fmac
>>>             - const: brcm,bcm4329-fmac
>>> +      - items:
>>>             - enum:
>>> -              - brcm,bcm4329-fmac
>>>                 - pci14e4,43dc  # BCM4355
>>>                 - pci14e4,4464  # BCM4364
>>>                 - pci14e4,4488  # BCM4377
>>>                 - pci14e4,4425  # BCM4378
>>>                 - pci14e4,4433  # BCM4387
>>> +          - const: brcm,bcm4329-fmac
>>> +      - const: brcm,bcm4329-fmac
>>>
>>> This poses a constraint in which the last string in the compatible 
>>> list is
>>> always 'brcm,bcm4329-fmac' even if it is the only string. At least 
>>> that is
>>> my understanding so if my understanding is wrong feel free to correct 
>>> me on
>>> this.
>>>
>>> [1] https://docs.kernel.org/devicetree/bindings/writing-schema.html
>>
>> Your proposed change should work as you describe. But it will result
>> in DT check errors for some Apple devices, which followed the
>> current binding and do not have the "brcm,bcm4329-fmac" fallback
>> compatible:
>>
>> $ git grep -E "(pci14e4,43dc)|(pci14e4,4464)|(pci14e4,4488)| 
>> (pci14e4,4425)|(pci14e4,4433)" arch/
>> arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:           compatible = 
>> "pci14e4,4425";
>> arch/arm64/boot/dts/apple/t8112-j413.dts:            compatible = 
>> "pci14e4,4433";
>> arch/arm64/boot/dts/apple/t8112-j493.dts:            compatible = 
>> "pci14e4,4425";
> 
>> I guess patch 3/4 from this series will also introduce some
>> regressions for these devices by moving the check. What is the
>> purpose of the compatible check in brcmf_of_probe() in the first
>> place? Can it just be dropped?
>>
>> I see it was introduced 10 years ago in 61f663dfc1a09, probably to
>> avoid a spurious error message for systems not having the IRQ
>> described in DT? The current code exits quietly when none of the
>> optional resources are defined.
> 
> It was introduced simply because the compatible property has a meaning 
> that goes beyond informational. It is a claim that the properties of the 
> node comply to the bindings specification. I would really want to keep 
> the sanity check event though all properties are optional. The 
> constraint keeps the compatible matching in the driver relatively simple.
> 

I see;-)

-- 
Best Regards
Jacobe

