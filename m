Return-Path: <linux-wireless+bounces-23070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C86AB9869
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48609E577A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CF224B12;
	Fri, 16 May 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="aM4G0NIz";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="QkodJu+B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC461A704B
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386875; cv=fail; b=GaNNVe68YNDtKhW3cYiOxxA47K2fKrMKUETrDPjhDY9XhGIe09UYBd0IGJfuUJDO6T+0j+DRo2W2M1tM1WWxIgekZKCd7vnXGq3BdWvmCUlrTiXvPlWkMsOi4+UI/zh3iRSSDw1FkjMH+WISLBmAcfAmnGVuyiQfLjD429FPwRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386875; c=relaxed/simple;
	bh=riD26Pg5h7qJhjKtacTXKppMd5hG5+SN4UrlVquyFSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCbkwstTIIZRp/AhLMwUaxTuksQtQRZcm/YPIjWf+q/Z3FZSI6vdpWTgUYkj5SahsE69DLGm6xiCexn67RdNkJ55ex9WXHs1afHTESCXjp7aVrXd7qBgn60YRCWyhLrUEZgVBlMIpwfl1VnjzoslELFB1NPZmUtyfQliZMeRC7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=aM4G0NIz; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=QkodJu+B; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5d2rW017633;
	Fri, 16 May 2025 11:14:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	8t931oEVJ4y4woOHT6PaUtuLaq18ujjH5uYcSRHZjeM=; b=aM4G0NIzv2V2OsXZ
	4U6cSjyefbAB6czTXXxvOrAUUETb8qW3OPcBx3sM0CsM2VIVRntiNFsHgor4ke8D
	dl/nEoV9jsDh44lxyOVqAAwwtP1CCMtsMBNoWRmXV1VtLNHGgiVT+gbTfxefJfPy
	FK6zqElXMch+Xj02XwJZuBIftbAVzgsjwog37Wmw5yo5Vy2eerXU27VBMoNPoiwG
	6lWsrVhPzoi6A4CZyuD9oJTLYa0uadruF9WcBa9mPOqWGGnj64UZ8c7h9H1koNgi
	rau7/Feq8Vhpz4nnjnU2mkMYCa/+wxRJkkCsVlS/+Zqz+8C0UWxOIkVvjrIwW/fK
	O23cyQ==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46hu5bfc8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 11:14:16 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLIrpZw78PIPzCExhyNTen+LBrmBEf6K/K5Oe1i5Opylb5D1X5kR/POYSyipgTFGLGrdlwIp9Pw5f+s0TGKn0NZ7PQi5BTSsW/n6nJdaEQ+9DvuqJg/VKZ06jxuraDPeobLBSaIvIdxBkxIvVgGmIIaB/5fatXeKuIBmC0oudKjGCIbXm6ONG2mUI6JhzWTYbyp46345KzRuUIdY+ePqVS5aPIUnHT18xQIudpH5VOQIgwto0hvONweLSQmrhQeCdudPad3JcGSEqq7BWca3NnOkBc6Xzfz5l/POJy36o9ggUxX+53SS6Q3ntDRKqf0aPOBnS59t0/1DPFf8TBewEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t931oEVJ4y4woOHT6PaUtuLaq18ujjH5uYcSRHZjeM=;
 b=tKYR9sFPs/zAYDEUZzSw5BVPFBX9yOiBR7OriJX7J5yQ5sVpdUgWCc8+RCpMdJvdRmskebNJEONXo/s/qjaGhR+/oaYViQ/wKh8+7cX/20DvS72fahU6tQmTSS5ZQeX16e/gM7nvWj36v7n3bttMxw/DDOa4Re9At0QbkEUFBuK9QaXVtERDEfFy8a6FBLXVAYeIhxm1E6wgs0X6sMOCSpxasrnHfPYpdeGimrSc0S21t9mOqj9clnKwjltQl5HaJAAjASp70loHBRq66dWu+SAyo/LkJE4WIoFufW6YHETCLuJLeP9FhSMoK0lld1JqKTYxKGVFF/TazzkRhXsg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t931oEVJ4y4woOHT6PaUtuLaq18ujjH5uYcSRHZjeM=;
 b=QkodJu+BrYSBdv3Oschjjj6dkJ1OS96lLh5RNZ7ZSwzN5FBRA8zjizFMpU/IB8jQkutU7PH79pJM6IAsJl3zZR8TFjWdWaoERcM82QvamSz0fvGIM2hky/HzccK24Of4kL/xlPkwID1Yvz20AmH1FwqMmqVeab1QRvgVFinoYUw=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by PR3P192MB0896.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 09:14:15 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:14:15 +0000
Date: Fri, 16 May 2025 11:14:09 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
Message-ID: <aCcB4XtVG8TZdaie@FUE-ALEWI-WINX>
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
 <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00007A7B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::606) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|PR3P192MB0896:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f56a381-7c27-4a88-a12a-08dd945a079b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em5JbGwrZm96NU5KRG14Uitha0Zpckd2cmQyUnEzWVFSTHZucG5jV21LUHlk?=
 =?utf-8?B?SjdsTlBzSExrMkxvc1Jvck14UGFBUDhFWEVxcE5PT3M5TEE0RGdGcS9MZTRn?=
 =?utf-8?B?WEZ3dmM2ZjdvSmdjUXplcDRlNW54WHYzRXJ2UHQ0Vk9rWEc5azBEUnFNclQr?=
 =?utf-8?B?QVpiMElObFRlTUYya0taTEtSM2U4bkVQS3FZNjN4OVFOVng4UDJvdTJaNzFU?=
 =?utf-8?B?dGdsWVN3Y3E4ak1NK3gzN1l6K1E2QTYweDJvdDRBSHJIam9yaEEwdFduV1dQ?=
 =?utf-8?B?bWVtcWlZeHA0aElsT2swVC9hcUF6aEVsSlRicks4Vm93aTVDdUlWeDJpcG9O?=
 =?utf-8?B?UHN3YXdzWEdmVndIcCt1cktPaEdQQWdBQzYvK0dUUXZyMC9hNitxdHBiMENw?=
 =?utf-8?B?L3IvaDh2LzVRWXZ5RW0vQVE5TlRQNlN6VUFhbWZkS3dKcnhxdWVVS2preEE3?=
 =?utf-8?B?dGo2Z3FxWjM1OVF5MnpnS3lXcFZNL1AzbDB3Y3hKcEF0dVlvcllXT09oTUVR?=
 =?utf-8?B?Z0xiTU5YQkgvRHNVNFFjYmJUcTVWMk9QT2tFZVoyUE5aSS9RRTVTWGtqL0FK?=
 =?utf-8?B?TTk3eEVvcDZ4NnZCT0JnR1ZBdVlWazNqTU95Nk5IOXdwVUp5aTcvVFZWT1N2?=
 =?utf-8?B?MUszTXp1NDd2bkdzeGxSU2ZJK0lTaWRtbTYvZ2drMTRrSSt6Z1B5L1Q3c0Fp?=
 =?utf-8?B?ODZJa1dWYTVnRlpTc3N0MzVVbmF5S3BHdmxUR1lPSnZPdEE2ZVNGNHYxQUdO?=
 =?utf-8?B?QlQ1b2NUeUxGK1lPN1dYd1ZCSDAyeXVHN3FnQ2xVM2dWcjk3K1hiWW1UK3RS?=
 =?utf-8?B?T2tkRlBIalQ2TkRkclIxSzBMWEcxNFk4Vnp5NU9vWTkwem5vTlZIcSs1SWow?=
 =?utf-8?B?ZE80U3ZMQWZ2SlhoWGp2d0F5cDFheXlnRE45MktqeGRtTU9QWE8rZzhlNjE1?=
 =?utf-8?B?dmFPOHJIK1ljSC9DUVptQ0kvSXkyQUltYmEwL0NuZUVwbU9wZENTd2lKS2t4?=
 =?utf-8?B?SHVZU0JLNGdGeE1pcEwwemVsbjBtcDlOZHQvS2ZqUE40cUE4NUQvMmd4T21Q?=
 =?utf-8?B?UCt1SE5BOVdVcFRYc214RWs4K1N3OXpmQmh5S3lza05yT214OFNQT1hxY3R1?=
 =?utf-8?B?elNGRHlEQUhXM1lNSG5TaUIrTG1VdENZZnRlNGlUMkxTZTRKWFdsb2pHQ21w?=
 =?utf-8?B?eVZxOEJjTHhKSk5TTlBLd1Q2Qm1tNlpESWYrQjdqSnhZYmFETnBOVVpYM2lh?=
 =?utf-8?B?WHFOdk5sRVl5S0orZHZRaHdEWkkwMTh1bWJnVysyTnU3OXk0c1J5TmRoRkxt?=
 =?utf-8?B?NUxMclc5WWtDWmZsYmZEcS9FZ3c2ZkxmcExXd2ZPVVg2TGlLWG5zRlNSbFJN?=
 =?utf-8?B?RkgvZUZ3aVMvbXp1YkJsQVlsNFpzaTgvUnlIa0JqUHphekh0cUJ5YnEzSVhE?=
 =?utf-8?B?RUxTUGlwMEJHRUNJWCtoSGZybXBqY2tDMzU3eTd2aDkraG1yenJlektMN1dV?=
 =?utf-8?B?V1dFYng3amY2TTRwZ2dNbFpFMFBOQ01QKytDaHFKV0pFTFNjd1VFcStPOGt4?=
 =?utf-8?B?NlVYWVZmdGEwUUVaSi96Uk8ycVhRQWdNUnRaUGhQbzZ6V2RWWEQ3Q1BBeHYr?=
 =?utf-8?B?Wm5sV08zT00vVW9WTitTdDNpUUgvRWgzRW5oRllIL3RHMS9SODFKTGRVZ1V2?=
 =?utf-8?B?aFFxVU9CODYxeUgyOFFYWEdkY2IyeVZpUVdrcGFWcnJoZUt5NDdYWnJ1TkdR?=
 =?utf-8?B?UURIMEpPNFRHL1oxUTljb3Jpc2lVeVFXOU9vY2FxSDNzWFRrV3BuTmlSUGlP?=
 =?utf-8?B?TzEwVWFDYVprcmFLQW1CU0ZZU2Z2MGVWWTJ6Zk8yM25DRDA5ek44d2g1NDhU?=
 =?utf-8?B?MVc3QkxaV1FtUWVzRzNKN0RIWFh4SDUyRDdKLzYzaEdlc0JrcUNmQ20yN25S?=
 =?utf-8?Q?thAY8gXN6Bs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpKRTRrRTQyTkdmSkI3Mjd1WU1RS3RpRjdmb3NYalpyWi93dnZORWNPYW12?=
 =?utf-8?B?Q0tpRnVOckVwNkp6WlpQL1BpSEk2RVBqelhxOFFMWjAxazJkbWRsSnBidk8z?=
 =?utf-8?B?VlVMUzA0alVHbm50RnVrZm1seWxxUGlNUksxdTdlNHNwTXhsRm1ma1FkQ01G?=
 =?utf-8?B?V2xUeEZnbXdqbnhrdkN5SEtzaVdCMDEzNUY5ZzQyK0hsL2czTVMvZjdoWURG?=
 =?utf-8?B?Zk1WWHo2SXdMMXdNMjRqYjM1QXdTbHRGaDFJZ0RvSm8xOExNc2ZLQmtUelBJ?=
 =?utf-8?B?YWFxbE43ZjhGZWlVZjl1N3RsYzFKNmhXaFYvakZrRDRCWDNpTXFwS0VkNTh2?=
 =?utf-8?B?aEJIT1dSbHhiZmprdEhoaWJQTm9BRVUzV2doZGpPWExUZk5QMFBrQmFteTh6?=
 =?utf-8?B?RVhQMzJOT1RCMDZjbFprb29icFhuQ3BDNXR2cDVabUo0TGZHMUN3d3BQL3Bj?=
 =?utf-8?B?V29ZY05qZmZ0enhvNVlESXVoNk5yaVFSYXpQWGRuZVU2VDcwczFZYndXWm96?=
 =?utf-8?B?VU9hVDJzYlhPNDNLOXNOTUs4V3dyU2lvSm9hVjc3Qm9BTEU1N0hvQVV3RTI0?=
 =?utf-8?B?VDJnTlVTc3ByeHkrSzJwMDgrZmNOUWVzWldEVkppd2wrZE9uSFNibVFRVGpU?=
 =?utf-8?B?aSt6bXVUY1RXc0hqOHZ4OXNLK1RVQy9TOUNPbzA2Wm5FeGs2YnhSdUlDRGtB?=
 =?utf-8?B?T3lpVkFpRytsK2dTRmxzQktQRVlyejZTUDJsekVBS2pLQzZSREZmTC9xOVlm?=
 =?utf-8?B?Q09BYVBVMThjYkNaRHF5NVMybzZ3MEtiakhzRDIzMklzSzQ5Z1JBK2RIcTV5?=
 =?utf-8?B?ZU5SVHpaUTJFZ3JUNnhxV0dKU25SQlp2aDFuejNjY0xQbDlsNVFnaHAxYWs2?=
 =?utf-8?B?clpBekpZWm8xUTdyWHoyWWxpVk4vTkdrd2JuRjlGVUhXZk5oNU9oRkhyeEFy?=
 =?utf-8?B?NGI4QS9BUjBxaEN2RHhFTWtYVHhIOGVGdHNyU0pRM2lsZks2VTF6UUd4Mm16?=
 =?utf-8?B?QUllU3drRnFtamlnanZjTHJsc0VZOFJ2SEhwZ1VpVHdqWGxwc2tmR1o3TXRv?=
 =?utf-8?B?MUk3aG1nSmxIWnNmOVl0dUlwaFpibHA4NUtIUktGaXpHeFJpc1pGS2tMd2NM?=
 =?utf-8?B?bnNZMzdqOExKQmRocUV3Mno2WnpQMlJQdEp0OHljdXF2R0lDV0EwTVM2dnBG?=
 =?utf-8?B?NkdQV2pEWTlYSzB6WWJJUTdQWmhuNUlWZHBuVEdiTmdGZ0VFV0RkS1ZpYWJY?=
 =?utf-8?B?bm1IZXQzTStNd0Rzc0RZNzhWTGlld1lYK2F3WUQvYU56SFpJVnVFTjNQVHRS?=
 =?utf-8?B?MGhrL1ZnOU8xL0wwSHdnYWRFYkZ1QWg1Q3h1NkRreUlqRlZFN0htc3pGaWR3?=
 =?utf-8?B?ekVTUGVmRnJGWlhlOFZaYmpOdGFxR09tVGNzQ2dBU0szdnplaGwxYzkyMnJq?=
 =?utf-8?B?bzZZWkUzYTczZk9FY0QzUzVGY0FtWGUvVXpldUZsdWxSK2M3UWxUNGNsb0NS?=
 =?utf-8?B?OGc3ZGNYR3crRjZDWGprZXpKUFFVaHRnNnM1OFc1WXV1LzduNVFNeUVLa2p0?=
 =?utf-8?B?MGplc3Vac3g1M0lDWkNWRlROVUQwYTJwTDcySjhScTJFTmVlVTJIU2RBU1Zo?=
 =?utf-8?B?R0RiUEhhVzZLenlneUhUeVBxemJ0WElFbTlURkl5K09FWHB4M2k1NWZYb3RY?=
 =?utf-8?B?QmdoUTZWay9HczhpbzFhUkV0Ymh5d3E4Y1BhUTJheEgyVVNtdy9uV1F3WlBE?=
 =?utf-8?B?Y2Mza3JTSnhVT1cvTEVZbjhKWHZQeFNlOWRNOUswRXRXRlMwVm11dXJWZjd6?=
 =?utf-8?B?ZEtpdm9OM0d5Y1J6eEI4VVNWU2dyc001REZ2UEQ5YnNpdkorYTVDVlMyUzdu?=
 =?utf-8?B?RUloWDVTdmxiaW1CeEhFcjgrVlpDdGxBbVRwbjV2S1p1L2tyZ1RwZldDZmhL?=
 =?utf-8?B?MlprYWg3OTlNWWtMK3kwNjVYOWQxRlhjNlpQTW42ZWE0Kzh2R0gzS2c1L2xp?=
 =?utf-8?B?RkhvdG5ERXFJWkdlV3Z3U2t5WnU0VUgwa1pVQ1gwSFppbG10OUV4VklLOWRR?=
 =?utf-8?B?N2RnNWZBRkRheVU4dlY2L21xQk40SjhlNjVGdEZVTFVQTHFFRUJEb2M2S085?=
 =?utf-8?Q?7Wl+NktSGHSgcoOzR9HAf3uKH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HSfaF1sjT+ddPqlCPKAooerluQiPY07LadnS2bNR78OV7XL5tTDNnLzkYOss1nGqCyYYh/w24iEzN78LXvg6WwmvTGdkFAwMn2So8GNaoQthn8KURhA57dYoAynly9uJI7/8bphSL9dg7X1PCSvjVj/lXAXZQU9dLdSSMhwjAl0XdVt6IpkuSPNhA9RD/W1EbKhRPHXdrQFwN8d0mxNwBihd+0mNWlT9h2bmyiLcqsLKTPr7EHBPtzcuSXzFmf3DasgD09Eg767kAOczu6j2/Ac4Ll3DvzMfEFL0Izqz9cMAexnLLFSRtXM1cKdbQ2k7P4LkD63Pg6C4ZNF/oMNwo+m5C5VnhKUXueY45KI4/f14u4DtMefwz4npfjCyyWUCT//NRucpMY1U0hetZDovxtqA8K/7ZXg31qpevr7OYuBei/Aup8XBD9DNhVW693EptqimoF0H5jgE/aN6NcNcZ0fTnydwyznFqiY6n3UnEZNeNRWRXiCRr1DA1mvkxPvDPCvvkAl/LRPMxjL+Z6KaUSLGnOu3x+pncOOGW9/iTkgkep34DNRTZTBtBE++jDnJSrEd+UO19apG8j2wTBeZHW8QuMlk7NrNMxSEIB1nuG3gJ+tKUVwwT++OiE+xOfDC
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f56a381-7c27-4a88-a12a-08dd945a079b
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:14:15.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QsgB0rwjQPCQjtw3WJU5T6tq0AMSYY52qNJ5KPfVbPynoQIbq4ji9LXBufFQKUm/GFnEBhffGD4SWPYaubeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0896
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PR3P192MB0896.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: 2IawQItnKFHP60FpCtTm9GSKVzSWt_-y
X-Proofpoint-GUID: 2IawQItnKFHP60FpCtTm9GSKVzSWt_-y
X-Authority-Analysis: v=2.4 cv=LINmQIW9 c=1 sm=1 tr=0 ts=682701e9 cx=c_pps a=6Hn8pli4REgfWvaJFfKueQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=EDG_nEDfII5wme-T6BkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA4NyBTYWx0ZWRfX5+oaHet4KPyu /+qnq72BsxbCNBxb47VhODnWtPYPZBO6KcO32MwyXdeCk6LXnNLTNiEPWgXugUCG9K8YELZTF7D GvFGuVwfjuuVHyF487hy6GZ5HU1aJWbo+sDHVv70cyoEAMqlqk9kysNqZantWyEc76DZAmSBj1D
 dnav68mqJXsTTnFGyi3EAjOx6U0O5f6wzQrpR3pDdx43UnlEIFQacrcbYr1A303mWQINahli4kV tV1bBMcuMbfAzeVCyDn3HMcJXqHWNR/3moOaHZY1L6M+SM/lrNaWXl0h7ho4Po5QGHkrta+C8Af eEdSxJbk8YI+VStn4kxZzM3TFMMCJuMlIMPTUTeNBBRNL1XGi8DfC7LB8PXPcpnIQiLMxF3XU2m
 CU6HDCRHkXBxnpM8f4iQ8YM8RY6W5CtNHN7eRuIOOVPHGtQJ0CJbnwfcew4CpxiDNpmtgYDU

Am Fri, May 16, 2025 at 04:15:40PM +0800 schrieb Chen-Yu Tsai:
> On Thu, May 8, 2025 at 1:25 AM Alexander Wilhelm
> <alexander.wilhelm@westermo.com> wrote:
> >
> > Hello devs,
> >
> > please correct me if I'm wrong. Since TPC is not used, the EU Rules dictates to
> > decrease the transmit power by 3 dBm on some sub-bands. For the most of the EU
> > countries the mW instead of dBm is used. Therefore they are halved (e.g for
> > Germany (DE) in commit 81d251dda3985e1088bd89f5d9f565e63ba5a30f). The problem is
> > that the values are then converted to dBm and rounded down and result in a wrong
> > supported value. Take a look at example (Germany again):
> >
> > country DE: DFS-ETSI
> >     (2400 - 2483.5 @ 40), (100 mW)
> >     (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> >     (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> >     (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> >     # short range devices (ETSI EN 300 440-1)
> >     (5725 - 5875 @ 80), (25 mW)
> >     # WiFi 6E
> >     (5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
> >     # 60 GHz band channels 1-4 (ETSI EN 302 567)
> >     (57000 - 66000 @ 2160), (40)
> >
> > For the frequencies 5250 - 5350 the power of 100 mW results it 20 dBm. Correct.
> > The frequencies 5470 - 5725 have a power of 500 mW. It results in 26 dBm. But I
> > believe 27 dBm are allowed. For the frequncies 5725 - 5875 the value of 25 mW is
> > also dictated. I'm not sure if I should expect 14 dBm, but I get 13 dBm.
> 
> Are you reading the converted numbers from the system, not the database
> text file?

From the system itself. I'm using the 'iw phy info' tool.

Regards
Alexander Wilhelm

> 
> > Is there inconsistencies between dBm/mW conversions? Please give me a feedback.
> 
> The conversions don't always produce round numbers, and since we can't let
> the system exceed the _actual_ limit, the values can only be rounded down.
> For example, 500 mW converts to roughly 26.9897 dBm. We can't use 27 dBm,
> since if the system outputs at 26.999 dBm, it would be in violation of
> the rules.
> 
> Or, if we understand 3 dBm reduction to be halving the power, we could
> fix up any rules that "have their base limit in mW and were converted to
> dBm to apply the reduction" be rewritten in mW with the numbers halved.
> That would require someone to go through the entries though. But if
> the rules are already written in mW, and what you observe is the kernel
> rounding down the numbers, then perhaps the kernel may need to support
> both units.
> 
> 
> Thanks
> ChenYu

