Return-Path: <linux-wireless+bounces-26402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF3B27E74
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075DFAA25A6
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17893002A3;
	Fri, 15 Aug 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="xL2LBW3x";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="YzrEy+OA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0062FF163;
	Fri, 15 Aug 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254217; cv=fail; b=aI9sb7kpKk6upEmQEA1xWqxmZeQmhCHL76qomP7wLqfYOEG+lNHPJG2zk1Zg3666IFy+Miy2SSIphQLz/SeqM3RDD8WxRgjBocaoBDMeXI4gV39JETjX5SoRyfNc5wQCUvexesq3VX4p2hoIpOkvtFshvXwTcOPbVsmaK7M6nD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254217; c=relaxed/simple;
	bh=Ey0wOv1s6P2fAEavwAj5KJThWDe+RKDrJFzlkaP2Q5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJHXTb4XS1jcUweu07x4Lre5RGQOT7yUqnzdgnpyZRgSrKFxIyX8Ivv9q3ZfK4qZjcYXf1rskzTDGs+LeG49dMtDs1F+Kk/lIZq+CH1ntifcB48Z660n61wFf9GlppdgKc5uqrYjo4qMDO3YVn1YtMjaK12qoDJljCVBL7o7Cx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=xL2LBW3x; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=YzrEy+OA; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F6B9sL2761813;
	Fri, 15 Aug 2025 12:26:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	Ey0wOv1s6P2fAEavwAj5KJThWDe+RKDrJFzlkaP2Q5g=; b=xL2LBW3x9FUwLQxt
	1cYw++JKgZKq70Baf6UrjbAi6rtf/rTBocyzutrfzIKmNjVxDxtMcRRZYwmD2i67
	/7EUSL9ADdH47Lb8pj2b96oV2CCHJMBr3PJxI0mde/WTnFZJopyaD0Z7dKpfqeGP
	ObE3Tgp84H2L7XEoXY2vqh4tLgKDqlH3TIAeEskBK14v+78zy9IXrN7LtUP+9Gcn
	NsFbySPTa3luAGrkuD959UhLKPGDtGaXwN15UQkd5OURn7XnDrGptl1QRz8qNqwB
	T+YBLL7ykLXXmQG2H0Nkw8hOJ+CupKL7k8RC3oD1JvC5vd59YtX/Dvqu7I6zKZIQ
	hyPCaA==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48hhu3grab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 12:26:52 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpHa9g3WbQPHms/56RkrxBtbsW4sJ1QfGlHQpPgbXBEGI1Wdku2YOLiV8gOQNCirXuAkChLpkfouhjN20Cy1OuXHY+0C9La3uMcqKOR1QsGQ/Ji41t2rw+41YLj4apQn1VfQya5ESew9/UkLld3Z0wJe0H2VyIpNeAMwLis+4TWoqzo3bwxcKo31lX+EYrjzvlQrEwx9/kARfyUzJYrqTgszSAZyrYuc2KnSpgDARCVJb5916J+NfCRK7YBRr/zeyHF6xdtTXxiJOmBIVvN3+quZzNlKvL8tzS60dvGibHeaejRr3twcO5xc+oh4U9CSEwnzpMt5ua5/Y7vBRk47pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey0wOv1s6P2fAEavwAj5KJThWDe+RKDrJFzlkaP2Q5g=;
 b=Q5cEcCmAt4aUFYsQVu0qOIQAu+Klt3FrO9ET8s+Jw7d+LUQc+m2rgvEAZRzZur5ppC5ce0R33AQ8A5Xu7XzFikQ8OZrrv24bAR92orOWH2P99iSZFHIUQ3g+LB39Hm+1qR9l65S2OeMK7YlJeWe2vJr05hzccPJfqFXBLoeh4ocGBk/uIeTyCAHV1QPI/kBPKVpT76Qk7uBSuPMQlsDCA8yFiYBNuaFiSHgu48xiYb7jFu09GZTcA2qOrD7DsMIZFgIe5HCJS36aE/qBpqfPbHEvG/eV8aea6qEVLIDPYRLzrkwqra1msX7CpMGsd8Mze64b4qE7xfYVIrEdefu2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey0wOv1s6P2fAEavwAj5KJThWDe+RKDrJFzlkaP2Q5g=;
 b=YzrEy+OACBgE2AgMtIhQqgyDWSJyuzgj6gH1X6fvXaFVW8NjrDWUscSKwevpPSHTxbbY6VoRo4mZmzZsFMHE6+hDiPfLFDV/abzqYUA3UJkECUzXfFOvoSP4jqacqjXxzbu7orgv6D5b3f266S1HX1R59p6ZVmtJvpmkO1GohAE=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by GV1P192MB1690.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 10:26:47 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 10:26:47 +0000
Date: Fri, 15 Aug 2025 12:26:42 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: REO status on PPC does not work
Message-ID: <aJ8LYj+NGaX8cwge@FUE-ALEWI-WINX>
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <573c76a8-c2a0-4b9c-b5a8-762b8d094b81@dd-wrt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <573c76a8-c2a0-4b9c-b5a8-762b8d094b81@dd-wrt.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVX0EPF00011B58.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:10) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|GV1P192MB1690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad89195-ff17-40b3-52fc-08dddbe63d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUliUkFBSGJCWHBBZHp6aXlXSU5uY0Fya0l6SHIxVTRiaFREMklHMklMajZh?=
 =?utf-8?B?TlNDVjQ4RU5oSE1HTzRDV3d6LzZQY3VMQ09Kb3E1SzJXTlRYSVI3VXh3U0l2?=
 =?utf-8?B?eWxPYXNteUcvY2lCeEI1dzMyR3dBNmpxUmVFZzZTclFaWk5LODVuSGJEM0RO?=
 =?utf-8?B?S0pnRER4TmZlakg3b2FaZ2RPTFBUOElMTVZDNHNpeDI0QkNaWFk0Y1RhNFdr?=
 =?utf-8?B?eXcwUnN0R0Q2NGJxU2hhdmpSK2FnRlA0WGhyRW1kTXFLUTlwL2JQeTlUckV1?=
 =?utf-8?B?ODZvNWNzc045TTVMUHY1ak8zL1Z4NjhRNlVwWHFjTGxKU0tJOFVKc01LYnZT?=
 =?utf-8?B?N0VlbHNvZ2tZZVFMU01GY2JuaWNkb3lnbFo2VExjcHg4ODN2b2tKemtGeTBM?=
 =?utf-8?B?RUVvNjVtVkFGU1JjaFFwY1o5S2tiZjFDNFQ1c2R6N1IvY0RwczVBUUUvOVJ3?=
 =?utf-8?B?U3ZtRUlpb1IvQlQ2THphS1Z3U3BkTnkxOHdCNVlXaTdveXQ4MWcwSTVTTG9Q?=
 =?utf-8?B?eXBxTmxiK25sV1V2bXpmVGlMSzhWaXFpaUVTZjAyZFlEQlNmcm1QeW55MDFa?=
 =?utf-8?B?OW5tZGx3dDU0d2dPTzl0Q3FNSVhoeDBYcDIwL0JKcVl4enFDNFJZVlFkYXps?=
 =?utf-8?B?UE4zRFFYMERMWUpqQWtGSTIwS2F3MGJTcis2WjM3NEg1Yzl4dXNYTDdkU0xx?=
 =?utf-8?B?bUdVV3JQbTIvQTE0YTN4RmZRL0h6YXY0V0k1OG0zOTkvR0tiV0QxR3c1aEpq?=
 =?utf-8?B?U0NFZDkrN2xPV3RvcHdXamFqTUpJVmpIQ21QaWNnWVRjR0ppVU9ERmdnaytL?=
 =?utf-8?B?WUxSaTFHbmZGOGp6TnpCdEJQeTNHcnFhMWtzL3F4aUNXQUM0ZWxVM1BIUks1?=
 =?utf-8?B?dS9nM2Q3emhlTTFRYXdVZzRKL3owRHdHUitUOSswTUZFOVZFYXRTd3JuTjJk?=
 =?utf-8?B?RmJNWmszQ2Q0ZGtaWmY0OHVBbEs3TnFZRG9iVWxoa0NtRzZvTmNuV04zMmZQ?=
 =?utf-8?B?SmRWQm1ubVRxZFZ0VzRXbWwzbjFZWDZIa1BhWExBU3JwU28rYlpSRWxyb2pF?=
 =?utf-8?B?OTlJRmJHOEkxWDYwVDZMMktKcGJxNzJOQ0ZMZzUzaHNtNUpEZGpVZk9MbVlV?=
 =?utf-8?B?SEtoMGR0MldoSVhBYkR3OVl3R1QweHlydE9BdUdOZVVtampTWXNOT0gxSnJi?=
 =?utf-8?B?Z29rOS9LZGNzZ08rL3AwdURBZkJSNHd4clVVSE8zUjE3ME4vVmJYbEE3bXkw?=
 =?utf-8?B?d2pneTcyRkNBektJbjFVY3BKeUdsZzdhYk9jSngwbU1BVXJtV3hBalA0cS9Z?=
 =?utf-8?B?Wk9xRW5EQzN5dDU5L2FIbEU2a25yd3JmZ1BSTWFkSDd5RXdnN3JXeUpWQ1Na?=
 =?utf-8?B?RTR0RVpEZkpFYzY1STRSZkljZCtCaHdDSkhvenoxb0V2c3Rzdk1WU2xmaUFV?=
 =?utf-8?B?dDdYL2J6L2FORDVGYWM3Z0E5N2hJdDFtZWxrNGlleDJhNGlLUitCZ3RvR3E3?=
 =?utf-8?B?ekc5b0d0dWtQU3FoSVRDc1FMd0w4WHcrTE05WC85WEUyUi83UWZiU0xnZXor?=
 =?utf-8?B?b0VpZnZiMS9YbUdvbG1XbU54VGRLRklBWFlCWmVuNHI3Rlo0M2NRVVJvck9h?=
 =?utf-8?B?VWNmVFF3R0cvaG04MWt5TVp1aEJzMXFreXU2ODZ4dW1MRzZ6SldlTzQyQy9R?=
 =?utf-8?B?UXdNUC9xNFIveFord2kyelZLQTVnekxJSWwzdDNQNzFPZFpOZmN3ZWluRzhO?=
 =?utf-8?B?Q1dIM08xME11MEpXQ0l3SFk4ZERzNm1SdFdYY3lXcFd4UEFobDRWSmNXVzkv?=
 =?utf-8?Q?ovj+BwE8N1knRTwaUP0tEWM5hdhsrU5PpD2Zg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtpK1hQYU0zTEVFQmZ1ZkRiQVZFd1I5VGxSWFRERXVvbWwyVHluYUxzZVdQ?=
 =?utf-8?B?UU1kRkg0L1psWmFnaVlld2VlWkVSQjZ0KzlPUzFoV20vNm16M3FpSjBwVzhv?=
 =?utf-8?B?dWh6MUxEMlZKa1NCQUgwUXhibkxFU0tSZXdZTVRPRlJVeExQS1JrSWlYeHFF?=
 =?utf-8?B?MG10dEhDTktzOWVqNzZaSmt0bk95UTBMUExEY3BJbFNTcGxwbE9vem5kYXlJ?=
 =?utf-8?B?cG1DU20rcjJ0Sk9ROUozMjZRTVJOTnZRT0dydUZ1NGx4VDBmRlRQcHlEVGly?=
 =?utf-8?B?ZUkvMTJpd0lpc1F5UXV1c2g5TDMwdEU2eUp3Z1lncEJ5Z1RFU0d2a3dMOWlW?=
 =?utf-8?B?djZnWWhwYVNQVU01ZDBxYUY2VEU4eUw1aFJidlEyVkYvV24rZUF3TnJLd05w?=
 =?utf-8?B?U05Cb0Vwa0J3RFJsVjhPRlBJNnU1endZejFzRGllNHVTOFRyYnVvSHdTT0Jt?=
 =?utf-8?B?RmJoR2xTUnAvUmNIUC9VamVKUExtNmJJVEFEblgzbDVuNFhSbkdMNW1iUWJu?=
 =?utf-8?B?ZXRJcnBaTXVXSEtzTXNjWUFpVGtkNSsrSlRGZmRWNEt0ZWdnQmhGZXhLWnpD?=
 =?utf-8?B?WTkrQ1pQYXMyMEd1NStjWjBKYnhiZC9qYVFIYWJGcTYrMWN3Qk1xcWMrOWR0?=
 =?utf-8?B?cXltSHV2ZzZtRzJXVHdRNTRTdnlMeUdCMlIxNHA4b2lzNnhJNkcwSmFHK1RC?=
 =?utf-8?B?UzZsQUkrNmZUVUdGYi8zT2FHZE1IVERCdWZOaXdpcHRuSi9NdUpzb0hmOVFJ?=
 =?utf-8?B?dG56SGZBdFZvdU5obHQ4MlRjazdIQjJlRzJSK1lUZ2NyM0labmIyeTJxaEd1?=
 =?utf-8?B?Y0ZIbTV0UHpUUlZxWmFhSmNUWkRWSGkyQ0MzODJaVEJLU1huQ0Y3cHZRQWlu?=
 =?utf-8?B?YVkvdXovWXhmTnhrQ3VXb09ITy9PQk5xdndXWWlnYXVkNkR4bzdQMmh1WUNC?=
 =?utf-8?B?cVpUdUh2cWhkRDl6S25QNXc5Z0RseE5GZ0g0cUxNOW52OTBodytoSERNR2hH?=
 =?utf-8?B?dmRhOVFNcFh3QnZtUzlNaWp2TjN0WmFXaEtPcTJvM2xqaE1MUjl0RTR4OFRj?=
 =?utf-8?B?L1VmaTI4M3BkbTJ3VllISWVJRFhBaS94QnZqMGU2bVp6b2RTdjk1RkhZMkww?=
 =?utf-8?B?QWZLMnhYSlEvbkJiMmE5WE9IWXM3empXV0dJN1BWUWQwOGxYRFpYVXUwblhX?=
 =?utf-8?B?SUxHM09PQlZTeWdGcWdZOWl1S2IwelVJMGVUWEFIZ3k2MDdXWHZZY1lGWVV2?=
 =?utf-8?B?SlBxSUc1SE96dW5FekhCcSsvbVdlcGh0VDhXRzVVcnZmSWZhUWNGZFluckcx?=
 =?utf-8?B?V29qamY5a2R6NWJpd2hsNFBrNk9Rd2ExUUFNa3NpQlRuOUJYdHlXQmlLc084?=
 =?utf-8?B?ZEUrbSt0U3doRHB5SVNpWE9nTHBZM2ZJUTRpK2FkdlpkLzJJa1ZPRFBNVlIx?=
 =?utf-8?B?bTBPZzF2NzQrdmFqNGhWSWYyTlVuVDlFTWc0MUoxSHIwSUVyU1JWcitJL1By?=
 =?utf-8?B?cTVWdytIaUtTY3QvdXVrU0JFTDdqeVlMcUU2czg3OWZ4VjJnZjU4NDY4VEZD?=
 =?utf-8?B?TUFML0NkVnk4NVhjSVpOdGNZUnpwbExOZHUwaUtpQ1kzblppMGRmaEpFV3Nh?=
 =?utf-8?B?VzkzcFNCMzZPMEF2eTRpUDlqOGxselpudFpuSDh3MlpGWWdkaWxQa3M2bnlL?=
 =?utf-8?B?WlV6WjQ1bHQ5cjRYYnkzeVJJWTZ1c3phVHZmT2Fnd2N0dzlBem5ZL1pNRHZa?=
 =?utf-8?B?N25VcDdJbk90VXRZd2g5cUZHVmxuZHZzbjdVWUFsdmpnOVV3SXU5OXprU2E1?=
 =?utf-8?B?elE5YVZXdDF3TzI2TStWMndRMEpYbzBQKzNWZ2x4NnlET25JYXdnU0IxN0hO?=
 =?utf-8?B?Vkgwak1rNmFTVTA5Tzhqa1NRUEVwYVZrYmRCVzc1OEwwZ2JGZjFpQUo5YmdO?=
 =?utf-8?B?MFdxbG1YSTR0OUVuS0ttL2kzY0Y1N0NIaXlibnlZenYrb21aeFVRTHcvVHRh?=
 =?utf-8?B?bVFsS0ZqWFhDMXFVWFRUZ09kUHNMaTdiUkRoTG9VcmJTbFdpeHd5NkdzckhI?=
 =?utf-8?B?MEM4VnF5bS9PMkRBZlRlQUVpUWo2d2RpVnJKRWQ5K0t0M3FVMDU1YTJ5LytS?=
 =?utf-8?Q?fWO0qZZivLTqkVElJysrbQtlQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9N/L7ihWthW/pgOjGIhzIHWSEWZF2TcN45ymPYjrtevAowD202jyE6D/uNFVF/RI53zzSBq2t9s3TF2Fx4b3DMXlONrbTZbgUUcOfcbhYZD1lbShBIoEncCgmOAVS1lgYgMFZMAztcmm9tzzNfSBMYcz143aOzOu6vvB8ZGVWn3IkLKp3e+OpZHngwC4lUWMZqteJhDXLJKgF+1LqSNOnSR3K0DTxRLmg7dHd7E8dnfZzE/ASOzdupqd1v842KWedXm7QHs+d2zNNoC4wCzpllHK97spOC2mtL6AD6DMI7LVmaQ14HuWsQjH9c0vlf5JRruAMhw+cxn/LbRRWFfhZEzkjudqSJqsML5HiKhM4olPI8StpGfJ02TTa4QHMNXwSalRRyVqDRSc0HdAVlPhz7mSU6VlHLITfFrUzR0oGJtnQ7sdb3RAO8avBclkVvLHs7zoSBlyjZp+3jhio9392jOyMPXw0GGrwLMUt5aUz5heHZVgPtGBJaCPHEjsmNoVA7Dx8juE106oamk/Ei/aOUAq+N8yRKf02wMAot3xfGo/h1woHZAVOGsRCkymvqFvX7qHNQxsdcJmMaAEPfhTr2u+xE6w2QRnCQ9uixkuOEu5Q36FL05kJgG1Eg5WG6sl
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad89195-ff17-40b3-52fc-08dddbe63d6e
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:26:47.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChyDfvtQqcIBxNPafwrZKGMiHPbJ6JOzJqnY3/NKjPmbog+6eprHqTgUid5eXLczF7Fy2aRXD9zrVgM9bVm1cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1690
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GV1P192MB1690.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=ceOLbnDM c=1 sm=1 tr=0 ts=689f0b6d cx=c_pps
 a=CeP2k4s9lNYdkD5mONEFZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8 a=G99aCo74uQcgOcfKJaIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: JaXaNIoltaDE5rasJORzaquSvrJAQa0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA4NCBTYWx0ZWRfX0GLN8cTeDUUv
 +59J2Wa8bkVSz9OPQIoOYQwdumh/eyL6lJDJUqQjhoGPOz3XRUtsQYGCiOJKZmoYiTzOMQvIds3
 93E+cy16emdYMt/v54vXCA35vwJPDXVJ1YEanCI0qaoCpmr5orXKOLglOZ2svP4P7lfv5pET7J1
 G28E+a8KWi5fE9yV6M+sBk4CTfry83x6Ad+f6m7Z5+X902V3DP73WWNN7jaeKNaASXfPk7KnZNY
 uloy4mUVA/2qM7WkWaJqy4lX9jwHSb0ev5vc9zZMUJT3V6yBVf7xDKVpOmjNBLK4wo2IJ8Kh/j/
 ivNzRvyOGLZboSBdsiTaNLODE4EKpmuX8u0/shcrezzS3NmQ/1mbkQaNXnsxOtRHMBrjwTi15Cd
 mziZw3DJP2bg6+YGY7tjSgFOAhn/EA==
X-Proofpoint-ORIG-GUID: JaXaNIoltaDE5rasJORzaquSvrJAQa0P

Am Fri, Aug 15, 2025 at 11:55:14AM +0200 schrieb Sebastian Gottschall:
> i played already with big endian platforms and ath11k (not ath12k) for
> months. there is also a problem with the dma descriptors. the firmware
> simply doesnt support big endian with host communication at the end even if
> there is a endian flag for the firmware.  dont get into this rabit hole. (i
> worked 3 months on it and gave up)
> at the end (i was working on a cavium octeon platform at that time) i just
> switched the kernel boot to little endian which is possible on many ppc
> platforms too.

The 'ath11k' driver works a bit differently. The endian swap is implemented in
the firmware and was never properly tested. My investigations show that the
firmware does not handle the swap consistently. According to 'kvalo', different
firmware versions treat the swap differently. See [1].

With 'ath12k', the situation looks better. Unfortunately, there are still some
memcpys from u32 to u8 or similar. Also, reading from DMA memory is not swapped.
I already have ath12k running, I get ping responses and can transmit data.
However, not in all modes, and there are still some bugs I’m trying to iron out.


Best regards
Alexander Wilhelm

---
[1] https://lore.kernel.org/ath11k/68290980-5bfb-c88c-be78-954f9591c135@westermo.com/T/#u

