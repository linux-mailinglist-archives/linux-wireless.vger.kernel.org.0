Return-Path: <linux-wireless+bounces-23056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF6AB95AC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313A5501353
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 05:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478B21C9F1;
	Fri, 16 May 2025 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="VrzIdmCT";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="YsrkVzCx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC64288DA
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374722; cv=fail; b=YuouDrxtHGme3mfBiqAQ8Dz+o5m2Z7y/maMNmFJmD3v6UggmRJG56l8fzJk+ux+wteir2W2/0/t+z4WKOcXKiDwjlRTTq6+U746Ttt+SvWrhwG9rch+Z6aUsi6mb6n+3A2bmbcvSpTg/Ei6Q903ZTlRKRDAHzrdykXHFTEjZhxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374722; c=relaxed/simple;
	bh=ibP27B+puKf5ULrx9qpBGo4S1SLtUiB07RgNj0S0STk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q95Muzwls1C7YOakH+oZoMcYWbIErZ2JouBCQo79gx03YKeibjM/CIYVdZa2JjwHBpx4ynI+xSkIduR/6WbvzHu0o4x0n8i6oaS/7GuD/F36M/qBomj8Uyl4vi/40zFAK5XZwW6OK3LBLIvahjb9WqR4lh32ehHDPei+4zNz1AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=VrzIdmCT; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=YsrkVzCx; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5Lnx4023127;
	Fri, 16 May 2025 07:51:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=up6ZGmVYFI2lBV7JSfT51yP6
	HfuQJjbAtRl6Kve/WnM=; b=VrzIdmCTaJAyytoSTT5gmcHpxog3Rj9Ct7ztvV+G
	2Ffi3kAZ1NohatgszBQp0/BgYBVmiqvrYIDyqRbqIzYAe+txz93c9MGO7d3rGtN3
	XRZuAz9k1QOLWrkrETH5tCibRuTRnHV4SxQ+++QBxyO4X6+KsBeP2q//MQqlGkTE
	UBbzXss+3PUgJ0DlsvmsJl5WkFzwE6Kv/FC/qSK+DXfhPFhBZqwXr7+X2ZnqEwPD
	8odhfzqWkrS+7e4GGxYEt71Nh6FhtuclYuhwPwVN6UgOEdJ4tN6PWPRbXbG2OTw4
	jIg3KV3xjGwbB9ozVv7VJPGw8khq12VUfeUhO0NJGzdg7A==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46htt46kry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 07:51:41 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzWun2HD1Llp9Ur3V58hEzgzM1r2Der8NuGDIjna0yvOhw3CyQxyiLsGK5078hVMAzolFSPwt5j0LBEnswwy1Gry/LMJGxwgXgtKkIljyjHtEtNHDOoKa6V6opyoZBM55ySXB82V/MA6DRBfW3aQEfxCkvNB2UBigRr7ZJWz/zTDb5hS7vQQgho+Bq87jeLRRfLXhfxZUbNrZcjIS/cSb5v0WgMQa4xXWjjTp1adRAiM8zujGUofXcFFGNPtbAowKK8H71r9cATOItbOcKwbtp7UrXbjUptcMG698Sd6FSGQPvUB7AXABA9cprneqgg4xcIwkPa8L4g09Lge9reaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up6ZGmVYFI2lBV7JSfT51yP6HfuQJjbAtRl6Kve/WnM=;
 b=YeWBw2d9rUF9q40s7oK9PHfEFY0u63fs9j0muA63aUkXe9IfrgooBqHkMpH5TynRglV50vks3A0G8cROmarQloWA8nrg8L66ZukCE/Dr6TyT4TSLJS+6Nj66FPQ8izRuPnSiglXOGM/eYbHGq4Tbw8PGp2MiFAlFvP3W4WD4hGAi3OACkrE1//enRPbcu2NhGc49REXLRUMAkv9eXgtEX2kpRxPN2zusA7RBpixvtvuqZTthuhJJ6pK0DSiv6RRUe8Vq8Lj9rtsdSAfhEgwd/WRzRQOejCVROsD5KuTb4GylQae1qlHaOa1u+bLF3g9Le/rnPgpzP8CTRIcsOUR9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up6ZGmVYFI2lBV7JSfT51yP6HfuQJjbAtRl6Kve/WnM=;
 b=YsrkVzCxPGVyWqgwQKoj4pDCxqqTQjSmWoww+kW3yv5ut6l2s7NnhE4GxNmx4l9kuurrO+V2FpCKD2RSjC8r8JsNDesymM/ctbrf2Sf3W4Ls+nzRoH2LP8jaFOy9I/QdmGRudtEla0Rqi+3Nn5zk5Zy0wyBCPknB0ULQ0cZD5Jk=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by AS8P192MB1678.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:509::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 05:51:40 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 05:51:39 +0000
Date: Fri, 16 May 2025 07:51:34 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: Question about TX power
Message-ID: <aCbSZl8d8sMeObIv@FUE-ALEWI-WINX>
References: <aB3AK83USvOdTvDv@FUE-ALEWI-WINX>
 <73b2bd16-66aa-405c-acda-237d56be63dd@dd-wrt.com>
 <aB3uKfu3frLyJ/2c@FUE-ALEWI-WINX>
 <592e4722-d7e1-4202-897f-e2a522074fe6@dd-wrt.com>
 <aCG2q2vNcLe4z/ff@FUE-ALEWI-WINX>
 <2cf0a878-1ced-43e4-b8bc-f0dff9c56dd9@dd-wrt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf0a878-1ced-43e4-b8bc-f0dff9c56dd9@dd-wrt.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00002E54.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::2c) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|AS8P192MB1678:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4e1192-bfd1-45a9-45f6-08dd943dba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uRTEr/jyrk27oZjt12EDyObDanLr8dUfMvjLnDoop5w+jprA1e41qQZEvJ6A?=
 =?us-ascii?Q?ktX+DNegsgHa5gV+rVvuWK30PJHFjV1wd4vX+ysyN2HxMNqeLvtJiKz2bwRM?=
 =?us-ascii?Q?siQTK+Sxe2vru72pgfJJpoYnFVDkSQNoU0ys4UJ5HGEBGtZqp2UjPdJQn3Q5?=
 =?us-ascii?Q?3+h3Irt6C6RA5Qp112IVWeGzdewyFqKSLY1FBogRv/1Efj4D5eTlzCk9QLz+?=
 =?us-ascii?Q?Y1uFv+qkf5MFY5yDX2mSb4mI5ILCbGegTdQL7/BssiAWApv4pb6FUI/Fz7l5?=
 =?us-ascii?Q?ldENNV1ELk1V3E8qTjllQBJhyfFEttFszzdozcrROPFuqYFcHRgjrVEUQPqD?=
 =?us-ascii?Q?SWAtG47HQcjB5vMuUbjQuXmEz63LYwc0znuE1Ct/wrPFKn7+wPp7C1YHfNAV?=
 =?us-ascii?Q?1aIi+fNUJE+fIJtGoXpi/zyMbkF53UU7qrCK1xTQOMUit9v52N4JAPVpgbVl?=
 =?us-ascii?Q?B9E37RzxxzRWAsr5BEd2iOyaYbuMRHqx7WoM6DbjSI/zSnwkh+sVq9USTnuZ?=
 =?us-ascii?Q?KlCDpnkQjcxevGMdb6g5zzJqS2l1MoHvCP+l+AOorgcJXriWzdF342/LrO51?=
 =?us-ascii?Q?HIwOPHbR11KS0tgW+VwVsJ3qE9RKi+X1wzKO+oV8PFdUIJc93xVSPU24qnnd?=
 =?us-ascii?Q?V9Mb9l2/Cj+yiKf65zbUVYDw9e6UfTf3CcpSRGbfmwAIv99ZofLFQZ0DfQHh?=
 =?us-ascii?Q?CpQXUjO5Ys9tLH8dCQhxbVVvGSPXkNSddUbJWdt6D3ixQhI7vcGyfNtyoLWG?=
 =?us-ascii?Q?cx0g5pW8GwdQ/1qlMA2tZ0aGY7SP2/Kw9DJ3t8braK3ZmeSUcTivhwt1ivUp?=
 =?us-ascii?Q?1T17OikKRteeEeGTA2uKuf21IREBTssuUADmAqxdsZgSrC35FuOVzKpe/zS1?=
 =?us-ascii?Q?RPGmm1NyJAoy/PvBlVCY6mOaj+jjki1DqbxaKjrzOuWm3y7y6KpQWPAIUcHK?=
 =?us-ascii?Q?NtqEKmfywzbcrY3HlD3n+r7ijo7/a56PRv+DNj94vCXD451UJFj8m0McWlAF?=
 =?us-ascii?Q?NVr+iZptokn28BWGytj1b+C2DjeBWos6pf1iRuoql4P/3VNkZ7Y3Wbieu1fg?=
 =?us-ascii?Q?fNX6MYRZBw3oof+zkIJntQT+9UEonUtbZFLmg/54FmbcWuMae5YSydn1h8dy?=
 =?us-ascii?Q?RdYF9IaOQVjaC1+j5MyP/4SIV1NZRFK5SjEtj8a9+Yf2Pt1i8LJuPKqR4gwD?=
 =?us-ascii?Q?+leQPWO2nouf/dBmpxZVlY1eWdyVxA+4MEJISXG+IX3HrnOUwGt1mjGbrhTx?=
 =?us-ascii?Q?K2xc5e/RLwlqKpZ5CZc0HMy/XXm2PIfq/Blez3wZpVCX+rOjLlqcJmGSRtQ3?=
 =?us-ascii?Q?Re7scsd1CpUyVlU8fyujwdh2Sc9+otKK68MnWch34GASY8jT1Pklx0XvTJ+f?=
 =?us-ascii?Q?FPsjH4rv7vDNyG9ikgsjus9RoAxjUPNnAue395V6T4jsib+ll0StwyWAL+vD?=
 =?us-ascii?Q?EjAJp4QsU1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqM7wBACzm0+zQ4Z87khVc07n4yY/Gk9omyMSTjiQnG9NVBowO/PKCUOsjzQ?=
 =?us-ascii?Q?qX/Em9I+l+LRXusCSfDOwx5L/rq7ga/LSImYc8gqh51uQXYq7XsXI00H5r6d?=
 =?us-ascii?Q?GxhHHPnMSZiPyiF61AWtVWRouhXAYmcjwIq+yeB0mr0ac2J6GLFLY+2HVu1m?=
 =?us-ascii?Q?TO55/yDBjoUYp0P1uuYwDyxNsAvmUVDjL6wmZwGqUCe/DHsHkdxI161ybwE0?=
 =?us-ascii?Q?P4QU6gyVhGKW5ek8IkZc+u3dcQ0dHs67e7S7UbOXgIn94YexUP2LuNqGVQmD?=
 =?us-ascii?Q?8By9isF61oJsnD8Dq2Pk/vJxt4vKOGaSp4VEso5P0ZdHkcj8oKjggjuatTs3?=
 =?us-ascii?Q?oDY9FopuKYQVpR5TqN9zQ0Qvs7yxTKyqb7DjwmvlLA8Q/CXp9+4dDvd4wcC7?=
 =?us-ascii?Q?hlxNBHD5CpBr9e4nPz594a0xsofxqD+Yg/g1LbNJdr4CPBVUR1PfsN025ngb?=
 =?us-ascii?Q?3sgAS4TU/7vkmenHZy6fLYloPUGCQPP2LUMNdPssfUGsNtmpjBEHUP1xrYH4?=
 =?us-ascii?Q?JdRBrOTHXjvvE4yzxJVpFjW/tV6gwNVhl192/yTicccsqHkDr1QGFkfncNJ6?=
 =?us-ascii?Q?vg3dgy5IKt7k0rXK6X48KoQMf6dL9+k42pHjS3Ul4VG1MJS+WpWJUpXTMjgH?=
 =?us-ascii?Q?zkxT0f3MOKI3FU3/PFD1pygC3a+/OoQCjA9PQ+TfQEq3+XG2gY5POrpbTTbd?=
 =?us-ascii?Q?ic/d26y4jbB0gseyzIfxDqX854u7Va6ziQIDIuKwaBxJqphJ6YHcwD+9bqNI?=
 =?us-ascii?Q?ePOhgyLVy6PKlLI0yz/MCjK8NLZxQY/tvtN652x7FS9cwX1wSVFfpobzyJMR?=
 =?us-ascii?Q?d981uOoxmq7hQrylhAxPSZuP0UPWBISTp720ZWfxFwfyEgkRyzivPljlKrE2?=
 =?us-ascii?Q?FK9ho06vPTT5bpE2bPCoMRoaYCHAZJfuPU/08SjTUTqR+2ATkd1xutK3jYel?=
 =?us-ascii?Q?/lELpUuQAIDQsOt0drPFhRg6RryZsfLNWCF4KO1zsKXErw9Or8PqBhPkZ/r0?=
 =?us-ascii?Q?cOonUvccHBBGwgSfz3UVJ8Vwgp2hwV5SuTegmEVLCCdaeni58371ty94HLBv?=
 =?us-ascii?Q?SkZg+9qJNd6r/sJCHkDbItooLyynWDqwUNWAzF8FXroHh9mu2hEqL4PhpXM2?=
 =?us-ascii?Q?VzMjuhspQXGacPE7mX9ZhZA85tUiFEyGJy9DIBODLDqoqypxJtxDIRX+DrM3?=
 =?us-ascii?Q?GUuHRRpznqHABcUJEYuHsTW4nhiDGZ96/ck1Pg5zDo0bsLE+ET7ubV/DpR3y?=
 =?us-ascii?Q?sIMHrMEnMDZFhWzNd8T44GX53v2vyzCTjgUpyweB19QzuKXIFHuZS4Scrdvm?=
 =?us-ascii?Q?5biZxg1Ksqkn1lxJ905RwTVr1x5/knVSUnKYYwCEVtj4VnwmvryB19rgeotv?=
 =?us-ascii?Q?9SveF25/sIMNyCN1v9/Vni3n7J+85wEEGTfAEcdr1xYDNjMOOQoZTcAdkQLI?=
 =?us-ascii?Q?08y0bUQcl8u/YRPOcX0hwdVdOCW6LfyTyVJXpooP/w96oW8s24JMh2T+Ihck?=
 =?us-ascii?Q?SQWSDu0323Nq0ok1Vxx6kEc2SQ4vuyWev3n/RuEz45uKCUp8plj2SlhGjdQ0?=
 =?us-ascii?Q?4szdyI+ISbp/4OZDz+Pty7ZJwEhK5Bnm1LPd4WbW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rX35pcrfqlbrhkTogKNqPxj1BWnA8WkFDRmM91e2D5S+7Zni3jgFVL86ljHkt2h9d0JacvscCqQ+CB+h9k/EEFuAp38EHuvEAgqHn8TW9uIpSlkgzT6BIK3XDmcBEKaTV2RSHqZftsBqfWhpJBghNbNDRPfuFKaf29+p9qd+MqYIt1/EN1vUEMGrvKl1h+cBH+v5eld8Nf/LzeAuPRuKMBSQBMIxo3H9vIPN9G6mUaGYUmpA3sgzFxTWfIkaIkwzkPvur4YWDZFpywlwov+74wLnUZVMTKCxV+5ml1gS1hpC2Exk1/eeWlI6R5WdIi1+6phJ3tpGwPxrBZs7IsXsAMtJ+eIvjclaKx7EaSquWP5y2b8WRxWnaJ3WRMXITghU2s0Q+SiAMgul6HfHwBjOUZLg93QAYbAzm8pDk2bD456oxfka19sHgNwgbN47u+2YkK6fdtz9je2oAMWnN4diDIIRQXLiieLPRZoIYDhPYFnS1ferf1qAmUsYqXJGg4SXuNplduYeml4AlQzjKxKIHulCh22OaiM88EqfR9CF44oFUQ2h6Zposmq+cpZPFbUNiFlKY2+8CePp7RbFLw3OdvNaUNwa9c9+ybzQQSe6TKguvRnQvlKz0sPp/uYodYFo
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4e1192-bfd1-45a9-45f6-08dd943dba5f
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:51:39.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+pXNFOZDgiMAFnBa8f3xGr5IguaDZQTH6xHCbVVLXMmzsgPtSCfXqDkE/jjKf4yHtvKHiq4+b3XV6OAHCsicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1678
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
X-OrganizationHeadersPreserved: AS8P192MB1678.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: j4ZM50JgGlSotsIoaxVQIWWU3fqWL9ub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA1MyBTYWx0ZWRfX9EyOG9Q6aSNh 7J97kjsdAhYpTQvr70766UYu0AxBwrhdDEYMMWD2EzthFzXZwu65DNC24FzlqYZCTgSxcqbj/eV wAcmbUOav6ersp4CY53K+Qo9CCgSUe1FLWNN4wZM8sSe/kbV4ni5sBHNO/Sl3mWVV2IQhYlEoaK
 WD6H1UCE/dPtlL0nA7SSTEoQ+dgI0b18Lxgmn9J94gjhZDCHIm4bi3e2gzqtFUrPSvKu3CIhVU8 9xHMAF7pwvU7GJkDPSLYhWmyZOF94vr1ezvVtWEH1GarORDI2YayebosyUbwgcQF7neaD+0n+qK iHB7bRRZrPfQuj7kPP8AiLjIPCDFQIVLX5U8axCcN/CjXiDSEcqZvb6UcNewrGM7Z3YcyRmlLvz
 XPpRBo2xpGQGAcYFzmpLMJdPFvu9hAgwqdX54PfMNEGzSm4+hohkn38ydNKRdJ8b8TAJBzA5
X-Proofpoint-ORIG-GUID: j4ZM50JgGlSotsIoaxVQIWWU3fqWL9ub
X-Authority-Analysis: v=2.4 cv=SJtCVPvH c=1 sm=1 tr=0 ts=6826d26d cx=c_pps a=py/jgptSVLV3EdsN+h8ZCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=8gLI3H-aZtYA:10 a=8kpjOw-0qs19d-2X8ZgA:9 a=CjuIK1q_8ugA:10

Am Thu, May 15, 2025 at 08:03:41PM +0200 schrieb Sebastian Gottschall:
> 
> Am 12.05.2025 um 10:51 schrieb Alexander Wilhelm:
> > Am Fri, May 09, 2025 at 03:49:55PM +0200 schrieb Sebastian Gottschall:
> > > Am 09.05.2025 um 13:59 schrieb Alexander Wilhelm:
> > > > Am Fri, May 09, 2025 at 12:54:47PM +0200 schrieb Sebastian Gottschall:
> > > > > Am 09.05.2025 um 10:43 schrieb Alexander Wilhelm:
> > > > > > Hello devs,
> > > > > > 
> > > > > > I'd like to understand how TX power setting works on ath11k devices. For example
> > > > > > when I'm using channel 36 for ETSI based regulatory domain, I can set up to 23
> > > > > > dBm. But then I get only 20 dBm as a result. On different channels and/or
> > > > > > regulatory domains I get different reductions. I tried to follow the source
> > > > > > code. As far as I understood is that 'ath11k_mac_txpower_recalc' sets the
> > > > > > correct values and 'ath11k_mac_op_get_txpower' return the different one.
> > > > > > 
> > > > > > My question is where this reduction offset is encoded. Is it in the module's
> > > > > > firmware or is it part of the boardfile? Thank you in advance.
> > > > > > 
> > > > > > 
> > > > > > Best regards
> > > > > > Alexander Wilhelm
> > > > > the boardfile contains chipset specific calibration data which also defines
> > > > > the hardware power limits (more specific data also included in the on board
> > > > > calibration flash of the device or if its a router, in flash memory of the
> > > > > router itself. in addition it includes a regulatory database which is used
> > > > > by the firmware for managing the total power. you have also to consider that
> > > > > the 23dbm are specified without antenna gain.
> > > > > so if the antenna gain is 3 dbm, you get 20 dbm in total. this antenna gain
> > > > > may again be specified in the boardfile.
> > > > > so you will not find your answers in any sourcecode. its all encoded in
> > > > > binary data.
> > > > > 
> > > > > Sebastian
> > > > > 
> > > > Alright, thank you Sebastian. Since I'm not using any calibration data on my
> > > > router/AP device, all data come from the boardfile. I've also understood that
> > > > the power limit reduction is related to antenna gain. I'll ask the radio module
> > > > manufacturer to create another boardfile for me that matches the required
> > > > antenna gain for my router/AP device.
> > > my answer might be not accurate here. which chipset we are talking about for
> > > ath11k?
> > I'm using QCN9074 chipset.
> okay. then we are at least talking about a common chipset i was talking
> about.
> whats the vendor and exact name of that device? i have some sorts of
> boardfiles from vendors collected.

I'm using Compex WLE3000HX for mPCIe. I've some sorts of boarfiles collected as
well. But my intention is to fully understand how antenna gain is encoded and
what do I need to request from the module manufacturer. For example I though
that antenna gain is only a constant value, but now I see it changes from
channel to channel. I also need to understand if the firmware uses TPC with
ath11k, then I could use higher transmission powers on TPC channels.

Best regards
Alexander Wilhelm

