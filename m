Return-Path: <linux-wireless+bounces-33192-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HK4CdzAs2lQagAAu9opvQ
	(envelope-from <linux-wireless+bounces-33192-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:46:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C31527EF09
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93EE2306A81C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECDC14A;
	Fri, 13 Mar 2026 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="YucQ9zD1";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="VDMzbDO+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6251E1DEC;
	Fri, 13 Mar 2026 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387929; cv=fail; b=JciAnX2cL7fDZXMPijJMx+RT1hXlrCNREYGDixtU3dR45y1jRjfCv8rNt0vJUSQqciKzcQmulFH3fOo1kT0IUgel+eB4LCA5Q+Wp3jVsP7HIfCx7nf5OvkFdvCnrMgYKWzWXV88dZ9ZAGq6PXVE3IMvExhBqiEN0dKNZYq7ipjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387929; c=relaxed/simple;
	bh=eYUeam7lPLyX1/tHCx5ZssUCz/Bhf2uoiZ9va6EdrG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfO4gMG5bwMRLddBSEahWeJZnacV30irDZsmypOWVQ0PrqASz+usCj1FGuOoSDOOOZmdEMdroqlv/s7VwqsahECjQKxwaQ8GZE+l3rhh7s6Rl6Bvpan+dW3YlJnAnliED+RGil9hfAGCr5rte4dNS8Yzt0px+RqELSpbgtW4izA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=YucQ9zD1; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=VDMzbDO+; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5L9FC1897837;
	Fri, 13 Mar 2026 08:45:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	J34h4cQQWSjQJ48RzPTLXMsXD//wK8sNfgQGeBtTctQ=; b=YucQ9zD1Aqmfqe38
	7jesZZCtEiul8NnSWw4oIzThwX0XbWSoqtD7Mm8WBNw0WN7OnhjT3ah1KXGatl4J
	sw/C9eMRAQoa66Lst+pFxyxLiXi5vuyQSdrXFEno61+WMW86I/YVqLlmrThRGeXl
	DV7hhW44SIXRJa93lkc2IMRaQZ4i187kQ+W+DISQE355gLzYDn/wt6zCDitvxp/J
	Oj4xn+/VjDENMdFgGE+TIKe20Mkvf4PlJvUWs4kgMO0N97ftPiQIrycNDDyQEYn6
	W/MOGZKMyl5eFjM7/7rOH6lKsTuYY++bLUtc2AEK7dg/SaQEklvA92PwtM9JJmdo
	pS/9Cw==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023114.outbound.protection.outlook.com [52.101.83.114])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cty3gj7cv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 08:45:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeWh+1uqfUD/LkUZ4IQ6Dh5XfRDnuQqDAtTKhP1g7qwqLHLxu4lTc65MCDB5y1j0+SL/tGM5gtb2NZyOZpcofwyXcUtirjHB8Yh+P1gqIf/b6qBz2MaXywraWJAlFm7F/TWSAQCEWb8/stbHRiaWzMwcwdDchfsmrVFMnZZ3R0gfhZ+feydSPCjJv7Vm0Ittd8uKimbMDpe4BISgPPTaBYhw7egMyjzPQ19cP+7Nc41AusOzZafKrIYNYyItSgpePaLsGNkesyiVfrUcYnL8w0iWBJ6i4itFmcDufZYLVW24RG+ECQgdSI4A7386N9CQwh39wS5iHgzAQfHNHu4PRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J34h4cQQWSjQJ48RzPTLXMsXD//wK8sNfgQGeBtTctQ=;
 b=l/LDfDDmkHuL4+Dpy6YrM5Wqne4cYToIHOF9Wvl2d+L0llepx50xLHmO3MqSMME/G+sGO7Y7m8xxsq1j3WpTGKADUYU9z/It3YYSHPA+ombXv84q6JRSPDpdXKy2F2KvKxMEV/3KtGRTzL2ynGV70JKSlbTmPM84M6sDyJXL+99EN0npVsP7qupAlb2X/AGK32E6lqCCnT98BEPaCZ8ElqWnZoo6i8r3hzDKfyT47n2a5bBYmEjxcJP8roVosvDzSGovJkVR4iXMipiNhy5ZNdmyOSmlJMFTmtUmNWd8CWs9g7kNYuUgWzJqfzb76pRI8dgs3u7Vr8XIdprGo2qIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J34h4cQQWSjQJ48RzPTLXMsXD//wK8sNfgQGeBtTctQ=;
 b=VDMzbDO+o/cFmuC58XHmQ4LqEKikMdVeDIf93URf/hG9gkCxdmb9MgO5J4xxDe+Tgny56OHaEwKg8PNcThHyeGz31u3VUH8YKxG2F5ifDNle0F9/cTPUy5efVv+zj3KeG9EPWMfjDZhP/LoJiEp8Lw56aG58NHeak6p09u4n1X8=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DU0P192MB2911.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 07:45:14 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 07:45:14 +0000
Date: Fri, 13 Mar 2026 08:45:10 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: handling of HE and EHT capabilities
Message-ID: <abPAhlKhDlKw9Lae@FUE-ALEWI-WINX>
References: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
 <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
 <abKbLNK0YrT6dr96@FUE-ALEWI-WINX>
 <40b4b959b2ea5afd55381e6ae2d0c1908456734c.camel@sipsolutions.net>
 <e8960517faf04ed4f1bf331e23a95c477113309f.camel@sipsolutions.net>
 <abK42BnlaPi9J9YC@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abK42BnlaPi9J9YC@FUE-ALEWI-WINX>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::14) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DU0P192MB2911:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f33046-f330-4a34-8d8b-08de80d4760d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m1GQL4j7JJEeUXjFDxjtexNPRfYZhIkxmIZLADyehqUJo5bzlwxXK3nrM0CzqlVviPPeONwuxHif1SXd8sPB9kOq/VlNX8sVjcZxb6dXkrqIjfHqyjFjMTXjH3Drd2bbfushF9V+H4Lq+JgIXuHl2BhysVbzt7RAnDGt4bGW0diPCXUYqssg1/MHWOFXOzT5iYhbNCwPu/ItKqWHC4qdkTjnZ/FBWxxpyeQUqcnkHPE+usf3FHF5w3ZQmKWQdgS2a3E38tQr6NezM9comVQG/7wootj3MH5YckxoliTFsSiRuDc4ur8DWkGGfQqBe+9NqglFuGGh0FD7IlzyFWniSoje+hKr0l7WrYBsWlMflt56AdWZkmKaMfRrT/G072L0nsqPU+c2p4Eqz4GukYAtN2YrBS89VFAZpQtwrqLEpNC61E4k5gDo/OzfsNYrDDdjxHwMq/dZdh6Y8XUJmuGVj6lPu/IWM2iTWEyjuaqu6Y5zUrPfMBBxcUZjJcpWNM568h65Sol09fNj1SaCLtYC2xF6zumEi+MAx4eYTShSRLtJdC57/0VvJpnUTCiyWh4H61X9guYOabm4wEzO9ScC3Sk/Mnlkus+90JzPzQ8LkOLPmq7Kna8H16A6t6vlbfqEcfzc94Xm3Mdo7ZK54zzEPc7zSyE5s1taxmDpy81ioi+XteXHMpgPT4GOxIJIFUJ7DLF0gVbj9ZoEb0j1pqfiqo6jMLcXh1r4gLrIjMjWQag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRLYUh1VGRBblR6TG1NcUxHTnZIZmt6aExyVU5QcE1wYVlqZkF2TFEyOThs?=
 =?utf-8?B?UUZnQVJCcWtIUHZHVDB4UjVuSDFKME00cHZvTVpQUjAwTzRXOHJ4Ym5JbHFY?=
 =?utf-8?B?MGhXN2xTMUJ3dlp5WEcxdVZXQWZvdVJ0SkZHMFdDOUl5SHY0a0g2VVFleWNF?=
 =?utf-8?B?amRiV3lYalM3OFNLRGFYRXFZWUMxekxwM21ZSkZyelNwLzF3dThibDNrUnA4?=
 =?utf-8?B?L3pwcTJUS3I5ZzBNUjNUUWk4SEllcThMeDRzTjE1SWpIWUxZckNxR3ZmbG5y?=
 =?utf-8?B?anArYk9IMS9aS1NHODhEM2pDWkQ2eitiMXRMZ01ZaFZTWG4wV3dNWUoyNE9C?=
 =?utf-8?B?YXEwQTIvdUtlbTk2VUtlVVd4cGw5ZWM1WFB1emtXcXpkeHZhcWd4R1JXNUNr?=
 =?utf-8?B?S2VlK2F6ZndpSVNhNFRyRXI2aEIzU0FRRFIwYk93TmVhcHI0ZXVzWkxpYkdF?=
 =?utf-8?B?V2dVQThTRHFZVjZ0MXNlUkErV0JFRmE5OEFud2lNYm1Cei9wRnRCSGI5TjJC?=
 =?utf-8?B?K29KUXYyZElNSkpZK3ZIWDF5MjlXYjVzS1ZDYk5HMVJqNDBwZktTaUNwOHFz?=
 =?utf-8?B?Q1JtWHlaN2VmNmtvMnhiY05LVm5hdHhndTV2RkkwK3RQcmFQRWs3MEh0RjIv?=
 =?utf-8?B?SnVBdW1wTXZTZG9tMDFhYWx2V2ZDbURMRFpIaDdJMnZxWEh0TDhpaDFrN0Y3?=
 =?utf-8?B?TnJmMVZzZWlSZXBwTVBjM04yR3FoYTNMR2h4bjlkNnJKZzYySmd1aVJWSWhz?=
 =?utf-8?B?dnhyYnlVN00yYnIvYmpiM0lDUXdpd0JOM1FVUzBaLzNFUmNjbFc5UW1rdUFl?=
 =?utf-8?B?YmNMRTh1VnhMTS84VjFiYzhyMkJ3WE9kenNSVFNTdEU2L1BHamtMdVpXZCtF?=
 =?utf-8?B?Ylo1aFhadFFrZW8vZGtieHVaSWhUbURXQ1Q3cUlROWJDcERkQVNLc1hUMjUz?=
 =?utf-8?B?NkhpUDdPMXllbG1NcGRKVkM1ZzJlRVBpN1hOaVlhWXRGN1VEYmx5Yzl1L3Vl?=
 =?utf-8?B?ZWNZZWJPUk5LL3JEQjRPY2JCZFBSbkRlZXR3MzFBTVBhUk1neFJYbFF1ZVh0?=
 =?utf-8?B?WmJkeDBmbno1TXgrN2ZwaDNjY3QvZnI2aXlRS2VBVWFKVmdFQnc0b1B5WUdv?=
 =?utf-8?B?bkFJZG0vcFRDZHEwTzFTTFhWL0d4TnpCMXRHZVVVQlBPMC9tRDd3V3QxdzhW?=
 =?utf-8?B?Mkx1R0FiUklSKzFJemhXdzdHeGFMVlVIeWlaK3R1bVc2MXQwLzdyN3RiRkpG?=
 =?utf-8?B?OXJGNjVkNzI3eGFZdEtTNmh6aEs4RXI5OG9mS1JaWHlBdkxmVmJMdkw4emND?=
 =?utf-8?B?U1dzcUtVTllFZktnVmR2MjZibG80dThoR2MzSmNRRjRMZjVsVEliYWdJT1dF?=
 =?utf-8?B?Q0pqVEpWdks0WTdYNERGKzRRWUg5YWNkYzVSdlhBZnZwS3lhcVBaRnF2dEF4?=
 =?utf-8?B?bnh1RXF1TGlYcmVFMWJJUXNWNnpKOStvKzhldVB6RTZmVzc0K2VZN2taQkll?=
 =?utf-8?B?ejhsTzNtTy9tckxiWnBuMUFBQThPV2w4YmV0QUF1d1ErTHVuVjh4R09TSkdl?=
 =?utf-8?B?dmxJRzJnVmgxaXR4eUVobEJ4cGYyTU5mekk2UFZ3UlFBLzhlckM5MUhBWGky?=
 =?utf-8?B?bnJZeWJyZ0NXa1FNM1puSFpNVmFXU3ZMcGlZNVpHUGdnYkNjT2RycTZQeU1t?=
 =?utf-8?B?K1UxTzAzMUFIdXV5cVJ4SU9HZVhYbExtelZnRVZBclV4TmQyaGVMYU0xM0Nm?=
 =?utf-8?B?ZXAwbXRVRS9IM1hKR2E2dEsvSmIwTmJ0SFpRWThJamV5cjhEekpQY3JKV2ZF?=
 =?utf-8?B?RWMyRkRrZzZyUjRRdUtBaEJ5eVY1Y21NaitkRXFvcVpGYkhzMlY1R0d4cGlV?=
 =?utf-8?B?S3B5TDJ6Z3J0Wk9rS2w2d0JROUdTZ1hlYXJoUTloeGJwaC9LRHMxK0xiN2lk?=
 =?utf-8?B?M2JKVGphb0lXc0xlKzVzRnB3Y3pyM3YzYjJJbEIxQjZnZy82blpvVDNQSWxO?=
 =?utf-8?B?RmxabTY2Zk0vSUNGdHlmUkgvaDlPak5SdzNtdzNyQ0lkd2pUa0daMjRXUFJx?=
 =?utf-8?B?UGZCYWwvbXdxM3I5ekFyZDB3dVVhZDBPcjR6WCtyZ0VxTEFGcDZFSWhyZm5T?=
 =?utf-8?B?TThsaGp6aVlneE1YSXk5UWtNd2dpMlVBNDNxcWl5UFladjgwNGMrd1QwTVZL?=
 =?utf-8?B?c3VnQ1dHZXhOZytPQWNqeWVVbmp5anJiVm1aNCswMVdWSTE5MU0rKzFheWgv?=
 =?utf-8?B?QTNhQWg1RFNleU5UZVZjTDh1QjBWMlhRRUNqWmpoK1NXdUR5K25qUkhlRzdE?=
 =?utf-8?B?SFkxSTBaRjBWcDJ2WUY0OUNjQnhLSU1GQlQvWitVeEltZ2pxUDVzQT09?=
X-Exchange-RoutingPolicyChecked:
	pU9TghwIhf5JT2uwQGvrKtkDfdWBGCqPOOs+J6e4U7LNtg+YfzNKRciKRyfH+Aa30+C7Gm6790OXw91FSYzbBipXlAVY2C2+HYXdMnfKIxPmJdDQng9Y1RtPCryIIsLHuGNGI9LCuyxDQ6ydSlYyJDfVUKZGqaDx+1Oxr15Kjj5lB46QR0qmjyZsTSkyvGuLJhRAwDhWH6h2iEmGQXBuXqW4ryHwaUKutY2Qnejf7jq+4hgj8olXbE8XpZbU6HBkrA4Iw1uxXKU//bR5JLL/aQBTN7BLjI/X0T75dp1Va3SELrx716BVwk5zEVvjeGYFiZLFR7K1xym9pLQnRb6ATA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nBpiN5gJmlukDzV/uut8bXbBUj63q9vOvH+WEPhDvWSVVQa/5zbqGrFaOXXrJuUY2Ybd4yVgr2OnnPfLqqIaP/1o1dQ78Oo1yxSLTNnIuYYeV82+EvDsUqBaDhgrIhPD6cj1ceBBcZjODWCCauwKgrV9eXEL7bmz5P77SJC0Cuh5UA6xWNmHeXMacDfNyJzw/gXny2qvEysdk0/cUITHrJTSPxQHVZGlYByNZwWHiRBwHzxZlgfGYw3D8/+3F69rO1ptWNEpck6LFIi8pqoGHwygq7LlLqshs+oSBVebTOl5OkcIfPJPEMy11nTCJwlgpQUGt1s9SYvYd3FMvAaUYKHaUxWKF9HZzfWkzKUD1ZI70RixNLE69Mx9/468UTsA/hHIB7wZidHyV/YeCJssyM/0w+w0LZfUG1lQfLGBw7qyvIu/aPuAwUbuZu/HFqcSJPjq1v4PZgkHcJ7eqP26Gfl76aBukVPif5IXXaTWJwUnbrw5o8CSG2T7m93tdK2W9/OO1xFuzGSSrprTO0nox1X6pd0Z5aDAqZMc4f10uUJdcY5owmmNobWtisB9wmlH9POooy4GThA83uke6UTP84Mch5wchynw+kYmn/e1HM3YbGzJndvmsNW0BEZfNt+0
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f33046-f330-4a34-8d8b-08de80d4760d
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 07:45:14.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxOTtieVGOv6McxMHHSC2rDLIjunNqINs1/a+/kQLQa2smsWQ4aSH9Lr0ynztMulgLFksnYAQbdliEDwzGtDAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB2911
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: DU0P192MB2911.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: haPJyJjbynWfKVvGWR3b50wcj9wLcngd
X-Proofpoint-ORIG-GUID: haPJyJjbynWfKVvGWR3b50wcj9wLcngd
X-Authority-Analysis: v=2.4 cv=MIhtWcZl c=1 sm=1 tr=0 ts=69b3c08b cx=c_pps
 a=agQq9Svy/vbm9iDlfKSo3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=fSAVAXivJbsCzAbITaAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1OCBTYWx0ZWRfX7EruZR9izfRP
 iYu9xLXCrN1kd8jVmNhwD4OjgiWEB8+LNs/Wbv6Fpo0ppkOG7VnnF5EIVhX/8odyWMRBWgkR/Ub
 z7Fq8XValcjOERJo1TLXTZzB3L5GvXBRiwdf1D0cN8P5yRVBPayxMlREfU1PNi83b2LNYcj7gBX
 ADG1v0c/4ge2AJJzjuMH6hxkoX1USM6BFNNjoeRnnQgx+Pfn16G1NBViP9iDpMvjH7gs3nIM0nc
 L+M4t88HyVnRo1PMKEn0ZE/KC4P10o1tgi0LNyn7LTG7JtNaqFsLdCj0inG0KD0tNvBPmTTIGCc
 qoaQOBwNbivAQ+OWHjNUfzyKQkU3ufaqo4VJU5xKB9+xGnRD58/G69e0vEg3F8MI2bEyhB6bZu4
 s0Bh61XW/pytmnF/IydEZta+AumuTPIJ2mVlJJgd9P+mqLThGqMIF5BZFXLzDp2kgtKVHjn3KJp
 TG5G5Ne6m2/TRwReiSg==
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33192-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[beijerelectronicsab.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,westermo.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C31527EF09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:00:21PM +0100, Alexander Wilhelm wrote:
> On Thu, Mar 12, 2026 at 01:10:21PM +0100, Johannes Berg wrote:
> > Wait ...
> > 
> > > > I don’t see this in the function. For example, the MAC capabilities are a
> > > > `u16 *` in CPU endianness, which is simply memcpy’d from the parsed
> > > > `NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC`. Later, they are treated as `u16 *`,
> > > > as shown in the following code:
> > > > 
> > > >     printf("%s\t\tHE MAC Capabilities (0x", pre);
> > > >     for (i = 0; i < 3; i++)
> > > >         printf("%04x", mac_cap[i]);
> > > >     printf("):\n");
> > 
> > That's incorrect for sure. But iw code now actually reads
> > 
> >         printf("%s\t\tHE MAC Capabilities (0x", pre);
> >         for (i = 0; i < 3; i++)
> >                 printf("%04x", le16toh(mac_cap[i]));
> >         printf("):\n");
> > 
> > 
> > which is correct. HE PHY capabilities are printed as
> > 
> >         printf("%s\t\tHE PHY Capabilities: (0x", pre);
> >         for (i = 0; i < 11; i++)
> >                 printf("%02x", ((__u8 *)phy_cap)[i + 1]);
> > 
> > in my version of the code, and it seems to me the +1 is incorrect either
> > way?
> > 
> > >         printf("%s\t\tEHT MAC Capabilities (0x", pre);
> > >         for (i = 0; i < 2; i++)
> > >                 printf("%02x", mac_cap[i]);
> > 
> > This was also correct, not incorrect as I stated, since mac_cap is u8 *,
> > and EHT PHY capabilities are cast to u8 * first.
> > 
> > Maybe your iw is just really old?
> 
> Sorry, my fault. I'm using `OpenWrt v24.10.5` with `iw` version 6.9. The
> latest master has the `le16toh` implemented. With my `ath12k` fix the PHY
> capabilities and the respecitve descriptions are fine now. But I still
> cannot get MAC capabilities correct. I'll analyze it further.

Hi Johannes,

I finally have `ath12k` running with the correct capabilities. The latest
`iw` version also performs the byte swaps correctly, except for the HE MAC
capabilities output. There, each 2‑byte pair is swapped between big‑endian
and little‑endian platforms. I’m sending a patch to make this consistent
across all architectures. Thank you for the support.


Best regards
Alexander Wilhelm

