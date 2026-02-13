Return-Path: <linux-wireless+bounces-31810-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJqZIwjzjmk5GAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31810-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:46:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9166134A1E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3DB305B0AA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D234BA44;
	Fri, 13 Feb 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="SGHeeIss";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="CGnVMzgW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B6272E56;
	Fri, 13 Feb 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976005; cv=fail; b=qVJMypDkB4BpSzPbfWwdmmY2UVyaxFEpM4Y8kIaoiqSqxuIFo9Z86YOONkM7/K+vu0jna+r0z7kAC6YFQYr4fxBUPa7sa/YyVp7Q315pwL0vlS0cNxQ1MrVgJRk8Z6heIi3udpuqd7pKqG5Dct2iwprBsJYidUr/RYBTyRAwgM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976005; c=relaxed/simple;
	bh=JZOY8g6Ya5y7m+VKnNcCYL357cGgBNrnVOIto6/wggY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RTlefoM4exsVtMS6sdhsg1ZC6fXHt8odEWKbZBJYc2Aii0lTqLHa/tR+WbBZn/lMM4D5ZYpH1/cYmuq6p+VEzfrXnPLKxYbAqTDIRrpjCzwJ0+CB7tjPQtAc7OdYSQD9FiZSY502KCtRhBnwA3REVZ3Tg2GOQqPzXYbPrbdy4Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=SGHeeIss; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=CGnVMzgW; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7N83S2102274;
	Fri, 13 Feb 2026 10:46:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	vVf1h0fCjphp2snuAEAvC4+OWPUg8rUkvhBASOmHMZI=; b=SGHeeIss1sD41EkO
	bXzofHbnS3ylrU1AAmxHuIzyDZ2Csd8sCCGKp7Cl+JTRncszf+EEgXRqfm94RYEf
	uEIqQFvE4e0m4lCsGyDFm3QWoy6EjYxXY3ME7Z7lMM0UdBwsidlScdZoUyQN71f0
	c8EgVitwprYKJAAFE4y9tKjFfh4Iy9XnaXqqYSCWNI0WXgZRsIZ6e7OnSSsvm05D
	qPyVVBV3vAupMuBvhtzA/kqq3OtKWQDAa0yNVTISDJXraLCz3yeYkiJOQfR/ybxs
	nPqfpMT3bPkfDCcKQ5Hmdh8kzAStl8XhN1ECww/rWNkSYs3jF0OZ7ksV3V/Z0wyY
	82tr0Q==
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11020079.outbound.protection.outlook.com [52.101.69.79])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4c6asvdddg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 10:46:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGHBetXqTEwj0rljFkCkLc6pw1K5w6TtrLRsOqsIH/m+u5uei5iNJhyhv+JK/83YqQt8JBEDidN8QrL9HYe5vzbtDqKZSAJ8JbDWwdwPsk08oRvZOhVDRsIjgrTT8Gt5PCAyH2lvTNVVKaQ0MPwchLp2WS+BFWTjDBnJzXN8jPi9NtLpXzEJtLfcpSTyFgeCRPEy2E6cuSR/4iysw/NgdpU1oAVEf9Ewumb6RRmVknF4+t6/3ZvMcCjwlzTAuAykPhv9UlSV4jCatnmFM/eJJcGnab+cx47jgVq85pORxHfTMo6msxuN2nE+LcpmsnKX/p5Vr0+XGF+GKEAs4anF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVf1h0fCjphp2snuAEAvC4+OWPUg8rUkvhBASOmHMZI=;
 b=pw8Iti3FaKeUBbLEJDDVLKf1/cvNRo4gSFP3oKZ9W4CgZwTSgr95EnGnhMfxW9A5y+fD4X8lRy8nlZIslBVE3+vhAK+Rdp4SoWpY6A4J+CvXU3oIS7HDUilNvOq9aAAdGO1QOGuILNJshERQMk7/z7EgTg3E4lxw5wrFO+5GywugJIHUYEehLiioP0HuOmP1UUxZClcSe2MXoXzfHFDgAfT4XOf3H6vslEIXW4kIhOG4vxqeM/7ZgynO7l7kL3+yjeIdTOii4m35bsYvokOzuErEfjQsgqbXFRfYjDTtNZJzC9yy1/xhbN88o67ITSAJlhbPkewIHoWLH7lg9K2fRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVf1h0fCjphp2snuAEAvC4+OWPUg8rUkvhBASOmHMZI=;
 b=CGnVMzgWYJe6Moe5jKtTfeEiixeNeW105DidKCgFvC2Z7CYhXeyugMPjPXRrjYRJyurja8xa/IX9y6dnapmhdPhwmXZD/bz8qJtKBeIRnIdxydXv0wcJ+6ozolww9LNHrstcpdiq84ymGLA/Clwanv557FDzi4wNSWUa/143z4c=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI2P192MB3124.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:46:32 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:46:31 +0000
Date: Fri, 13 Feb 2026 10:46:27 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Alex Gavin <a_gavin@icloud.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: wifi: mac80211: question about 20/40 coex support
Message-ID: <aY7y84VZW465W_zr@FUE-ALEWI-WINX>
References: <aY7NLLnOCXS8L31z@FUE-ALEWI-WINX>
 <a3fd0a27-f09f-4950-919d-1b4ba2dcb16a@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3fd0a27-f09f-4950-919d-1b4ba2dcb16a@icloud.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF00014AF5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::319) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI2P192MB3124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdf9a40-a2d2-4169-5174-08de6ae4c4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU5md3J6NFZVSEY1M3I5Ryt4Yzh4ZkRMNllCMm14dTlWdmR1aVdDemc3cDZt?=
 =?utf-8?B?cmhFNjltU1REK0tiRWt0eWg0NjkxNWsvYVhYZHp0Nzd4SUJRMmdjZEdJQXBI?=
 =?utf-8?B?a3JLQ0xxcHlreWs5TTlqMEhya3VVWDU1Zk5iSTk3SloxMkhoRUlTUHBPMnVJ?=
 =?utf-8?B?TUVjWnpQUU9YbW1xSUN4TnJxVytlV042VjhYTkQzWDhxTVJ5WVZuUjl0MTZn?=
 =?utf-8?B?b1dWZEpJOGYwY0xmcHQ1V1o1Q0w5MmFIMTh5bUVxeUswZUxxY0pPM0FhNExp?=
 =?utf-8?B?VzhUVVJHcWhwbXVBenloYzVwNm1TcVlJVXNxcnBORTU1WmdkOW9pZzdnTjdx?=
 =?utf-8?B?VVpaMDRxYTFmVWxJQjlPZU85cklob1d5cHd2QUJhY2hTanNaME1kYWQ3aHVY?=
 =?utf-8?B?ZExTV29ZREdBV2ZWZlBON0Q1RVQ0SUwxbGU0UTdQVVFDTVdnY05QNmNYbTha?=
 =?utf-8?B?SVB5dUNlNmJzS1gwVy9WUUpQTEJLQ2o3N1dyUk9CQ21LMFlERThsTkJuczVx?=
 =?utf-8?B?Nndsem13YVhnT29ySi9WKzVJWEJWUVM4NmNqQ3ZTM2R3Znp5SzV1ODhPcGxz?=
 =?utf-8?B?d0pKWXVMR0ZZNG8vYmFCSloxaWRBczBKRDhFQUhBZ3NKVEdKNk94dHc2SzV1?=
 =?utf-8?B?R1ZuTHpqT2l1cTVYRlNBQk5EVUFVUjNKYUFKZ0hScUtSS3dXTVI1OHJTa2dw?=
 =?utf-8?B?YlBtZmNUcGx4anp3UWtsSmVBeVlkRWZjZm8ySWVwY0dnVWx1NW9CeEEyVUtH?=
 =?utf-8?B?MGJxbkxpbHNKbHBjZ2RGYzRUeHRCRnlidEhQUVR0cEdSMWkvYzlta0J3cE9H?=
 =?utf-8?B?VmhkekduREo0bmt3bzRqNTVSK2EzaC9VTG42R3NWMjRyNEYySzFtQjBmVVNa?=
 =?utf-8?B?ekpTSUE4Wm1yendaL1VubUU4R2x0NkdZbzVRMFpYaDVCU2RQeVZJYTZZaFI5?=
 =?utf-8?B?WmZwRVpBNnhKNUYybkpnSVRCamNaNzVlTTI5a1Evd0VFeHlTZEF0cmt1NklO?=
 =?utf-8?B?VVdxVnozMVhRV2FTaFIzMlA1SFUyL2pEQmoxcXJQWUtFZGVhWEZxS2ljczZN?=
 =?utf-8?B?L2V3VWhVWHZyeWUwT1FDU09UeTh5OHRSdEtXUEZ5cmQ0R29VM2RQMWJ6M3pm?=
 =?utf-8?B?T3pRdi8yeVFTZ1dvYXNEcWNlZHZNdEkxNllZN014dDlMa202WUVtZjdlUGJr?=
 =?utf-8?B?Q05YbkVhY3YvQlZNQW9ONURuUVZrdERnUFJSQytwdlRBeVNuV0tadEdQTzNx?=
 =?utf-8?B?d2RCNlVPakFBWEtTSEhVdDI1QThQRktpd3dsM0JYSHdVOXJFa1pTU3pLMWYr?=
 =?utf-8?B?T2Y4RXR3T091MXhUUGtOUGZBeDJLYXBla3czaWJkZ3FSNEZ3aVlVVyt1WnZj?=
 =?utf-8?B?a3EvMDA1R3U2NmlXdnlqbDhvemNYY25tOGNHd1IrNnNiak1RT282S0tGSE1j?=
 =?utf-8?B?WUlldHlDSDgyWjFqcGo2ZnovVGY4Y1JBQ0hLcHlwK201SmRrbTVaL2t3YzUr?=
 =?utf-8?B?ZCtiSzUxdkgzRyt5djRUcENFV3ZINmpXRTJpelFnbDdxN3ErWi8wbVVOMVg1?=
 =?utf-8?B?Lzg1UkZndFF6UGJkTkc0cU9JM3lLdUpxZWFUd1I3NzRkdUxGMEF0dVRRMmdG?=
 =?utf-8?B?MkloRXZoREVFdG5BMlVyY1JFd1VGcUNweUl5b2VDVkQvODJOcVdHS1ZjN1RD?=
 =?utf-8?B?K1l4RFA0akF3ditGM3lzT0FOcUFXZUZ0bmY0RlNZSXNxU0Z1cUxKWkV6akx1?=
 =?utf-8?B?MVE1RVk2a0o1cEdleVRST3VMeUg0aXNxR0RkbnlXWURKY0NiUGtIRFU0b0lI?=
 =?utf-8?B?OUkzUDcrUm5GUFNYNWl1SUFSSUpXbzZhVHlPYVFXL1kzekVMbm0vRmIrNXhq?=
 =?utf-8?B?NWdneHNtQ3pSd0RTZ1Z2VkRCakZXUHhjbFYwWXQ3OUQ3bEpXMzg0U2lteEwy?=
 =?utf-8?B?clFPMjdQTjAxWFJsQzBDeGFUV0ZUYlR6VzV1ODk4bjhhUks2MGxLZytGR0h4?=
 =?utf-8?B?dElKUDI5T3J1akJkRThMVS9pRG9FTTQ5K3NqNG9BYXFnUEJzeEUySlZZeEpR?=
 =?utf-8?B?eTc3c3oycXBkRThpUHZvMTlZNFNNOFEyNjdaVUpzRWFpYm1sbDh5RGFaK2Zs?=
 =?utf-8?Q?oePU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnpPclROUzN0QXVRTDFsdEpkV2lFWGpna0phWTlrbERKK1g5dk5XRnBkNlF2?=
 =?utf-8?B?QjAwZUFMMTlEMkt3MkFaQmJrRVF5YUxrYThQcTlJNlQ2MFJTOC9pTVZObmtR?=
 =?utf-8?B?NFZYSnlYdnlRcENsUnRXd2VWNWdKT3NmTzZaYWtUVE55SFJlYTY0eE9DSVZp?=
 =?utf-8?B?SXhTK2ZtZTBjak1peTBydXJObWlnUWxWMk9zclB1VFRVUG9SVjJhRGIrbmgw?=
 =?utf-8?B?RUtPR3ROY1U2dTQ5clV2a05Rekpia2VEa0JuWnJDYmJpVGJvMU42VWdXRUYz?=
 =?utf-8?B?MkZIV0d2TlZJSFV1cFRIZHp4K0JrUUNwbnRCRGpNV2tMYkh1aWJkVXEyUytJ?=
 =?utf-8?B?U1p1S1kwZEZzeGliQzU5Z1JSRXJ1R1pXTGYzL3o5QUY5TlkyblVmdXN1MDRL?=
 =?utf-8?B?d2tKdXpVaWhEUzNlRHJsaHNWVnlVaUxuS1kxSllWZ0Mwdk9pb0o5RkhpMS9Q?=
 =?utf-8?B?RklYTk8ydGxXMHpHVmhGZjNLdDM0enVwWnBWbm5CTUp4NGlTeTlodElNcjZ1?=
 =?utf-8?B?aGFRYjd5Q0hBTlVrczhZdWZnN0MwNklRYW1BbHhzV2FkKzUwTEZQaGtTYkpX?=
 =?utf-8?B?Y2NNZjBSUUJaRERHRkQ4a1NUZkZ3b05kcE9vQytYcDE3eFJLQ2d4U2gwNkl5?=
 =?utf-8?B?YkZZeUNGNjlDTzYrdnVzZGxxbXNWdWdzeWRoZ2NKWnk0WCtzOXRzOWlQT1RE?=
 =?utf-8?B?M0MySzArSDlrQStGY0FvK012UTdZZTRDMTJ0Wjd0K0ZhRXVIZ1JVMExxRDIw?=
 =?utf-8?B?YWVBSE5xdVVtSTJhK1ZiRUNmMmRJeHJPUEx0d0pxYXRsaEJxdUl5emZOeUI4?=
 =?utf-8?B?NUo1Mm5BRXAweTdCc3NDT3hQVDJ0TTlNdXkyTkNiR1FxYU5WbEpwSGxZaXNU?=
 =?utf-8?B?cmU0U2VaWHAxM042cUFHa1hWUGdIenFCMGN1ZjZRM2p3SzgvTURkS2habTNu?=
 =?utf-8?B?VGJwbkdDeGRVMVZOWGFMSWl1MzgwblE3VWZaWk53SFd0Z1NmNGI0U08rT2po?=
 =?utf-8?B?U0JoSXljeEpQZ0hUdlhGV3NQT2Ztdmk5YTN6VjFXVTYvclBtWGJ2UFRhZXc1?=
 =?utf-8?B?a1JURFhZR2dxVUJWTUJzYnZRS2dnUWsveDNaMm9xMlFDMW9mMkR6N2xnVGU2?=
 =?utf-8?B?NGdLTXFIRWR4bW5lL1psVkNKWVJqc1NUUjBwclNCSytjQ0x4cTQySDdvMllQ?=
 =?utf-8?B?bXhqWWcraHltME1XNWxJSTF6Z2VlV1J5WldEOGllQkhPQk0vUlE1L0JHclo4?=
 =?utf-8?B?d2haVXJsbGE5c2dEKzQvNnlkekN6MEdweGhhbkRTdDY3K2tyaHRMNWNRbmVK?=
 =?utf-8?B?dngwSWJaOFh4RzRuMzl6aFl1QVVnaUkyajUwdGhpVVNOWHJkU3FzRjJSbmdk?=
 =?utf-8?B?ZzhvUEtzK2RIMTNDeW1kT2lQNUFmdnJIQTlqTWRTR0xzRGVCbVhNWTMzNVpH?=
 =?utf-8?B?K1U5a0ZhUlpoS3FJTjBuRU9Od2pRVDA0T3E0cndiTHBBWEFHR202UFJGOEgv?=
 =?utf-8?B?bmRwdUJrek8rTkNCMW9aeTQwQ1FoUWkwU1BianU3bWNUTHdNMHJxNmlTWVpY?=
 =?utf-8?B?Tlo1ODZLYUFyVjVvN01qNm9yM2FWbnZYRHRVTTBvRDRZTEtSQzVEdU1uUEhk?=
 =?utf-8?B?Y3hhcEEybWNnRUg2ZTE3WWREbHhxSG4vT3NKbzJPaWcrSFNzVVg3NWhxeTFq?=
 =?utf-8?B?ZTBmOVcyY3NVRGJjVGZyQmxKMndjZnRBY0tMWm9IVDg1Y2J1ZWJva1hOWFRj?=
 =?utf-8?B?aFZMWEtIRkRoZm5pNTY1Sncva0FLenRhKzZVYk1NUlJUQkFSb2hObk56ZnZO?=
 =?utf-8?B?SU9TMERCc1BSSCtCUTJsenpYc3FaVnNwem9lSjRtVDNQcFVYbkhxWStBYldq?=
 =?utf-8?B?b212ZXdWZzk3RjN2VGovRGZ2RHNCTHA0aHBJMmUwR09mTTk0bVFyUDlxeEly?=
 =?utf-8?B?eWJVY0tpUmdIWUpNMmM3T3p2M0JtNDBoa3VjNDBaeEkwMW1FbXVNb3VaSzUr?=
 =?utf-8?B?WVRjb1IwZHA0TFc5dmZlSEF0R1NHc2hXNkhtdjUzNXdpWEsxSjV0UnREU3Vw?=
 =?utf-8?B?aXpSNk4vbGRZNnlDK3lPUG82QlhQcHBGQUZhQ3dVbVhFSkVaMTZCOFlmTGFZ?=
 =?utf-8?B?WVVjeXZBdDdEOVVLY3pKaldFeGlkUkZHS3Fsdjk5bkgzK1dQWlRGclNUdUI2?=
 =?utf-8?B?eE02ZEtLMjhmYXlwWHowS0VNcVBzWGZVRGtEU3FDM2NRcStNcUloTHFyOWRy?=
 =?utf-8?B?cEI5UVZESWVKSDNuWXdOUEdYSWtNaEZhOXR4WmxCcm5IemJwS3pKalJmTVhr?=
 =?utf-8?B?UjJMZDVBSklWdzRCMTVQOHNVMTROQ1NkamFKNlpuYUxiZnJTMUlyUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C54gM2omdNxmWRYd59cefjamSO+EQIaCbqs/eYNRtBD+4HQRAPSWBZtjXRQGHjyUENS8v8AmiYstp29HAHCM6kUgN6/dheSPaFbk0G76FU0c2uF7gte6ovTd1ZhnldYpOjRLASwLqKt55rNqWEn2UcBieB4O8zV2p4kqpZZFZSJoCQpnbUZAjLYtjxuro832Ls48Eh+PP1WMyNxAtv9b6kI3BIth8DppEzA9rUoeHXeD6PSOqQJrtDYB2MhS9ha74G9zRPToXSltufa0VZ2UPki36CMvnGybZtnymRKdvifCi7S4SCrBJ2vM/xAxnOC7/Gg6d1xIg233YlimCjuPcOPdt72VSTMfI2IouPhsGLKpVXL4rnhD4MrcDyipqdzHRUw+DCXNnFCTiTVEvlFe8IgySQ+W3zoMH8VIVz4aRTz5aYgnvHObsE87aRM8Lg5Riy4rYy5n0nXOAOX3jzd2Rhrl6XY9675PzZoIVB2LV2nYQbObVKhET+vZvwPi2xVn1flqg/1L9gRCtxU5Pr+gGBdYrGJNON9/uROqIaRm8Svade13w6w/6QzRMLTEh8Gjikh1owuGJINmkaYBCLOYJUIpAepJuT7Nt6w0Ir/kKw+5gIowqIK0y71SM1JAB4HD
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdf9a40-a2d2-4169-5174-08de6ae4c4ad
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:46:31.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxLSBpwlQSbM80We+7vXxJEvl6BWE/GUq8wxSGh/ps34mF5+VI+6pdrb8eLikIbmZYouMPY07sQenZUcufBjkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P192MB3124
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
X-OrganizationHeadersPreserved: VI2P192MB3124.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: eSpo2tw2xlZsbZByTom2TSPsPveCrbEU
X-Proofpoint-ORIG-GUID: eSpo2tw2xlZsbZByTom2TSPsPveCrbEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NSBTYWx0ZWRfX8roO4c1lYs6U
 RH6hIjkOCvz+yEZ/n3SjHQ8ECu3O+JkTkv1+IFiTyA308oRS82oxntK+ehpBEO1vxeHw6NoUmFk
 Zi0TKOPJ9SJrX2FYXNIY8kRMSweATFUs/KC3xg0+1BmqQSTw8o6Lt6PWpyqXOaLnhcv+jlrExoK
 s98pIRr3L5XHYgTgOy3YxpFYp2bqBKFgzHVxUIN9r769EuApni0m4yukLF/2Hmppe0lhNDkoiol
 ETz9v9gY16HqPK+lvPIUKkwuhm0gdNvDmDfY9KwoivqVG/IGU5XmfxBD7CqGIcaNowo9gQcewv0
 EQq7pODMbGK8LP+BkYpD7Tn8i1EbWhZkzWHwa688QWp7m9GUMampRthauKbdRajgesLZZn1C4pt
 vegAx+YJCBo9UG8ODRMOtfUGqAp6V5UaSihsbhgNTymjlamhTHMV5U05NPl0IpUxp5vcl8hAaBZ
 /4xNxdBd+j8osvfPpLg==
X-Authority-Analysis: v=2.4 cv=J+inLQnS c=1 sm=1 tr=0 ts=698ef2fa cx=c_pps
 a=rLet0NO1Vy5TTuje2zMcmA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=IJ9QT1cfHbmz9b9oiCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31810-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E9166134A1E
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:14:16AM -0800, Alex Gavin wrote:
> On 2/12/26 23:05, Alexander Wilhelm wrote:
> > 
> > Hello wireless devs,
> > 
> > I am analyzing a wireless management frame taken from the beacon of an
> > access point, and in this frame the `20/40 Coexistence Management Support`
> > bit is set to 0, indicating that the feature is not supported. See frame
> > below:
> > 
> >     Frame 2: 217 bytes on wire (1736 bits), 217 bytes captured (1736 bits)
> >     Radiotap Header v0, Length 26
> >     802.11 radio information
> >     IEEE 802.11 Beacon frame, Flags: ........
> >     IEEE 802.11 Wireless Management
> >         Fixed parameters (12 bytes)
> >         Tagged parameters (155 bytes)
> >             Tag: SSID parameter set: "SSID"
> >             Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
> >             Tag: DS Parameter set: Current Channel: 6
> >             Tag: Traffic Indication Map (TIM): DTIM 0 of 2 bitmap
> >             Tag: Country Information: Country Code DE, Environment All
> >             Tag: ERP Information
> >             Tag: QBSS Load Element 802.11e CCA Version
> >             Tag: Supported Operating Classes
> >             Tag: HT Capabilities (802.11n D1.10)
> >             Tag: HT Information (802.11n D1.10)
> >             Tag: Extended Capabilities (10 octets)
> >                 Tag Number: Extended Capabilities (127)
> >                 Tag length: 10
> >                 Extended Capabilities: 0x04 (octet 1)
> >                     .... ...0 = 20/40 BSS Coexistence Management Support: Not supported
> >                     .... ..0. = General Link (GLK): 0x0
> >                     .... .1.. = Extended Channel Switching: Supported
> >                     .... 0... = GLK-GCR: 0x0
> >                     ...0 .... = PSMP Capability: Not supported
> >                     ..0. .... = Reserved: 0x0
> >                     .0.. .... = S-PSMP Support: Not supported
> >                     0... .... = Event: Not supported
> >                 Extended Capabilities: 0x00 (octet 2)
> >                 Extended Capabilities: 0x00 (octet 3)
> >                 Extended Capabilities: 0x02 (octet 4)
> >                 Extended Capabilities: 0x00 (octet 5)
> >                 Extended Capabilities: 0x00 (octet 6)
> >                 Extended Capabilities: 0x01 (octet 7)
> >                 Extended Capabilities: 0x0040 (octets 8 & 9)
> >                 Extended Capabilities: 0x40 (octet 10)
> >             Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
> > 
> > I reviewed several driver implementations, and none of them seem to
> > advertise this capability. I also could not find any definition for this
> > bit in `include/linux/ieee80211.h`, unlike many other capability bits that
> > are defined (e.g. `WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING` or
> > `WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT`). From what I can see, none of the
> > `mac80211`‑based drivers appear to support this feature, is that correct?
> > 
> > Additionally, I want to confirm whether my understanding of the feature is
> > accurate: the 20/40 Coexistence mechanism implements the “good neighbor”
> > policy, meaning that an AP using a 40 MHz channel in the 2.4 GHz band must
> > fall back to 20 MHz when it detects an overlapping BSS (OBSS). Is that
> > right?
> > 
> > Any clarification would be greatly appreciated.
> > 
> > 
> > Best regards
> > Alexander Wilhelm
> > 
> 
> From my understanding, this is implemented in userspace (i.e. hostapd), at least in upstream code.

I've alredy seen the code in `hostapd` that implements a fallback to 20
MHz. But that implementation is based only on scan results, not on 20/40
coexistence feautre. Here the snippet from `ieee80211n_check_scan`
function:

    [...]
    if (iface->current_mode->mode == HOSTAPD_MODE_IEEE80211A)
            oper40 = ieee80211n_check_40mhz_5g(iface, scan_res);
    else
            oper40 = ieee80211n_check_40mhz_2g4(iface, scan_res);
    wpa_scan_results_free(scan_res);

    iface->secondary_ch = iface->conf->secondary_channel;
    if (!oper40) {
            wpa_printf(MSG_INFO, "20/40 MHz operation not permitted on "
                       "channel pri=%d sec=%d based on overlapping BSSes",
                       iface->conf->channel,
                       iface->conf->channel +
                       iface->conf->secondary_channel * 4);
            iface->conf->secondary_channel = 0;
            if (iface->drv_flags & WPA_DRIVER_FLAGS_HT_2040_COEX) {
                    /*
                     * TODO: Could consider scheduling another scan to check
                     * if channel width can be changed if no coex reports
                     * are received from associating stations.
                     */
            }
    }
    [...]

> In hostapd, the '20/40 BSS Coexistence Management Support' bit you reference is set in the
> 'hostapd_ext_capab_byte()' function in 'src/ap/ieee802_11_shared.c' when 'obss_interval' is set in
> the AP config file.
> 
> For more information on the 'obss_interval' config item see the following from the hostapd config
> reference here [1]:
> 
> # If set non-zero, require stations to perform scans of overlapping
> # channels to test for stations which would be affected by 40 MHz traffic.
> # This parameter sets the interval in seconds between these scans. Setting this
> # to non-zero allows 2.4 GHz band AP to move dynamically to a 40 MHz channel if
> # no co-existence issues with neighboring devices are found.
> #obss_interval=0

Great, I found the the configuration in my `hostapd` version and the code
that implements the handling of this kind of management frames. I'll give
the configuration option a try.

> The following sections from the 802.11 standard may be helpful to understand this topic in more
> depth, although I'm sure there's information online that may be easier to digest:
> 
> - 9.4.2.58 20/40 BSS Coexistence element
> - 9.4.2.54.2 HT Capability Information field
> - 11.15.12 Switching between 40 MHz and 20 MHz
> 
> From 11.15.12:
> 
> TE-B: On any of the channels of the channel set defined in Clause 18, reception of a 20/40 BSS
> Coexistence Management, Beacon, Probe Request, or Probe Response frame that contains a value of 1 in
> a Forty MHz Intolerant field and that has the Address 1 field equal to the receiving STA’s address
> or to a group address, with no further addressing qualifications.

Thank you for the support, Alex. The information helps me a lot.


Best regards
Alexander Wilhelm

