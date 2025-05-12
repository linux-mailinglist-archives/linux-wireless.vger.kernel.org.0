Return-Path: <linux-wireless+bounces-22866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD644AB3241
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB8168586
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D82E645;
	Mon, 12 May 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="OUiNscCc";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="i0b9r2fO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73D1804A
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039948; cv=fail; b=h2xioiHzDOJo+Jc2B0EgX+MXJagQRf+R6cJ9/oW4IlXhUaevEwqbpG+xXL+eDclnjFuygFf7bxKsk8MbN5/qoWwLfChtBK6YcvKjLEco4y57uznrYYwZ1BC9bN+ySRfhJb/zfl/KNHQdDXHMOCV9b77t6hHRcLdCurASvNLRS+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039948; c=relaxed/simple;
	bh=YxAoBUca2hln6T4r16agTYTapBvJ5DFsr9SQUvqxCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c4MO92XcjbsqpoVZhVX94YHqx7knV75Ipo39tAy6zJFgwVkeyOGXGoyq/KVTTaf2bhOEH3D6owLIpWmPFQDv/jYT7aeB2Mca7509X3QdKxoscsZY1cjCnglRSehfJJYF13Q57MuNlyRTd9AhSvukBGYG56uamJYcEoZG6/lnhRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=OUiNscCc; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=i0b9r2fO; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8ij9g013537;
	Mon, 12 May 2025 10:52:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=HN7pAlydeFopXedxnd9rv5R9
	EjaaDr8DPmD8IHqtBlk=; b=OUiNscCcKL+URu9X35NZk/mstttiKS54wDE6h+dD
	wWa41KAxCZDPsgQJmYmmRI2BtXH6UbM4eC3tZBi0jbcCobKqSiD9k0e8pUDU9W8j
	hwWJj8bPYxD75m5CgtZE8zQU4n9jwBKMP5WCWrhvgHUnZlKuaTDcj7lY+GBwKd20
	AtMxZYp2CsliOCmKzVR4XOXLmNZY9EJ95dLzkBo7XJNpGn9qPYdPAKLqyew3SiZP
	gH/fNq+uqG2eCQPb1SkF7RsbfF60MgdLMqFRNiOWqsFAKhaSnvf5w8xU1Zw8DWSj
	Bfr1Ng6UPMfBXDWrFmKfegXCU7y2OSZmRyX5OcNOKLkksw==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46hu5ba47p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 10:52:02 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnAohX6W/Sd3AzJGXLEu8U/dJD1EpOQ7lKjZAktz7rNFrSCxPPOwuiVX1WbU0iSAYUBDVwILgJb56QHQA4h1WpTP4oaGPkvgrpQNJ43V72dhyQ3D+XClb9RG3cKfwI4p7ha8fzOs8WrPoxIJ11kIxGPOkaKCAbSVP744H4dNv93fqV4cDgc9PopD0WQzjhSyUIDsVQGpFSDmLs1d//wYDVVqDtazA2vcnmh8TEAgV+Py/Iqp/goMrtrQBHZu/QCwyK3fcT/twqpMPuj+pf+lOkafqTEnZCL545/jWUMyOTWvTPxavlEhuVMiIvASnzvPVaUuSSUyUiHhnC+GDXf1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN7pAlydeFopXedxnd9rv5R9EjaaDr8DPmD8IHqtBlk=;
 b=U730F16nO+kaKI8GFfN/3ydP7Mj6hmXk0vd7bBmO/UOpYvXSucTxadse1JXP7lVxh7mzKdHkd7kPE4DK37K0vSPjSMXoJltEmTWFrZY5zddEx+c5RqaPE5jcLQcM0FpG55G0tp25+/cjp7PnOTx/X2Rk+zZHKD9voLDCGnA+LZOuCP0vGRx8yy9egzjJRlQgku1VupuFCmx+lDfb5iZqA4PWd81qe/tEqMk2s6PfNe0w0h9AkCN+HkZzQ8JsqLqe/dkkibeuV/iEbc/AuaGkiRH20RcaVHVACpTIPJEpsHLoFQvqhVf0pSoEIVglu4xP09ctzGvdC82qKCTTTfYqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN7pAlydeFopXedxnd9rv5R9EjaaDr8DPmD8IHqtBlk=;
 b=i0b9r2fO5RDJdX/fTiNEtZc40grJeMLjLVyf1sHQi6oAaZBxRaxIttY/aq0aqM0n+icRFV7YKwaC3NdhncIhQcgc6cZ0eyzEGYAUV9PoGIA1Y1ntqrmWPk0xGjmvxHOKAbZHNWKf6bEVeoEMzsCmmK7eKpHlgNk2LYcwmAwROIM=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by DU0P192MB1596.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 08:52:00 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 08:51:58 +0000
Date: Mon, 12 May 2025 10:51:55 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: Question about TX power
Message-ID: <aCG2q2vNcLe4z/ff@FUE-ALEWI-WINX>
References: <aB3AK83USvOdTvDv@FUE-ALEWI-WINX>
 <73b2bd16-66aa-405c-acda-237d56be63dd@dd-wrt.com>
 <aB3uKfu3frLyJ/2c@FUE-ALEWI-WINX>
 <592e4722-d7e1-4202-897f-e2a522074fe6@dd-wrt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592e4722-d7e1-4202-897f-e2a522074fe6@dd-wrt.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVX0EPF00014AEA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30c) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|DU0P192MB1596:EE_
X-MS-Office365-Filtering-Correlation-Id: 194d479a-9553-4c41-462b-08dd91324140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdRY2FIBFaLB+GqSHQvWnJSqgids1v/RWPXoP+D0ih3DcdqzwGdlhpPBhx8n?=
 =?us-ascii?Q?QYe79uB7DaK48J3JIXuDLIKwEdoX4H1MvP+/q7Cmk7A4bbCtBjzvVQvzFjwP?=
 =?us-ascii?Q?FIYWV2kuvl0ShRYYWBL40NgkXtB1RnfXOx4LnAA1XdMG/0WPFRf0R4GLejnr?=
 =?us-ascii?Q?ipfIjtF4Q8YHZZij1Jm6pChntL5izHeJctbfmUtvxAsi2zZH6W4rHiaC9+pZ?=
 =?us-ascii?Q?j75dT0zxVdTViHH9QKykh9ZBJsjHyU59RyxSKdyR5SSHWauXbM8Xhw086V/s?=
 =?us-ascii?Q?H7xjWpu5g27WOl/SLlyo4jc72qnV335/vdeGU6PcpA+d0OgHIxZl3KE/QNuk?=
 =?us-ascii?Q?kp9BCEhhYo1Mz2t3rNBddzf/2UPh7KNH2X9jRZpl+kR0FHiSJvavGDhvtCQs?=
 =?us-ascii?Q?cGHxQ7tVAJwHo/0N0/msp4fjipYmsKhjJ9E8JfSteH8VHnanbbXA3NjIvUTq?=
 =?us-ascii?Q?8Hf2/ZjJcgfn/u5vpN2nuo/EQz97b/ub/gZn/2wJQjL5Sps1xvij7Q1D3bI8?=
 =?us-ascii?Q?d98PH9zpanIFR8tbEYfZAjzJSn5Q4CbXkoxq0g0EwqDlx5LRuFnbESzAPGWK?=
 =?us-ascii?Q?NtwWL8dMtFBwDuwrUpmZYNuTcveoV8F47jFVpRYjcSDpnVGaaHHOYUo+NdjE?=
 =?us-ascii?Q?qpcAWMTYzrj7wSLx2klOYGEs59aze0VaKv25I3paw/M9eSA23+oDw8wf4k74?=
 =?us-ascii?Q?fhrIs30XfiHlsC/Ux3OOC7seJqsTCGnB4Tl2eZwoQJ0HVJUbR56YPG999lo2?=
 =?us-ascii?Q?X4CD1Blsz2myS6V2XZGNM+hNl+IlIHuTr0ZhZZ2IgnEfxIb2wKi9+8UzDZdZ?=
 =?us-ascii?Q?qZOals6IaWEfGqiUhF9domsAb0D3AFnoQpK79Vh6+hbODwzYHaBPsQhpQm3t?=
 =?us-ascii?Q?HU4Y+aTi8C10cFVzPkm4l1XEIVpj/1lYwa4u7NMeJdkLvH5nAl3srLNhqmF3?=
 =?us-ascii?Q?oDc0S4BShBzdDZCAEK4cthpdi4l/I+ocj1erdy/ibBN0n0HTSJ+cQk2z3FRB?=
 =?us-ascii?Q?NgZI69PA7QSN3ml4ovt46BKFt8GZY2HPCkgAuySHQ1SUUqI43nLhZA3JvVMi?=
 =?us-ascii?Q?XmdOPSkBq3qsJspvXqhi/nojQHz37Hu51lgj/1KCgchm3XCsfR/cKPW3O7MF?=
 =?us-ascii?Q?ecfQUW2gC+IaelmndXa9SzDGYmlnn3k/U1hrQoMHtcxpRg0LzvhF+cN3IwVW?=
 =?us-ascii?Q?Vya8Rk7XHbZew03FwqlESXf9RMADPLCeBbJaPSNbSDlvGtiv4Ya4HKy3CsEa?=
 =?us-ascii?Q?oYFY46aBksiZqdeDNNzlbGUPWQg8X2LaDXogEV55R7Zqb9EVbu8znuDtBkwc?=
 =?us-ascii?Q?ZadjFl1aftJKiqkINIXbvIcnTe2bOMLAWj8LinmAvlS9rkClE8lRuyOQj4S1?=
 =?us-ascii?Q?lxTs1Y2oBwqoLsGbskyYpQDMG8BzXPG2uI+y6xZeRielysZmNizpc070SpKK?=
 =?us-ascii?Q?1fqN5JD4clk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bVW1I9W9b1OuXjIOBZ2blzELwJ7PfyHyBqlKB+nKClqRL9Ol1SCHnenUt9gP?=
 =?us-ascii?Q?T99v1+02T1mLZNyk5+IXA8Il19WXPkS3m0sYOh9DVDtoPV3e9ZDdNk3kZWOf?=
 =?us-ascii?Q?IYarIYJcgl2zkd80xyN7qFDdesp4/3TNSyVck3RUYl7Tv4k3FJFXz8u0rPBp?=
 =?us-ascii?Q?I5z7cC7kI4cFju5PY04qA80aqF20a35mkT85l1+QAzSBq1qLojrDB9Irq7xf?=
 =?us-ascii?Q?DdfZVMNY99KGWOz5fabvaeCiWMfhfJtoN3TCjDksT4WaZ8m2fQ8FID9301HY?=
 =?us-ascii?Q?x+jY2uX2djnAWrONBZXIO73h7pq1Q8QfrDZ8j1nlS+31h7MyYLXn+BwI8rze?=
 =?us-ascii?Q?FLQRy/FzaiHoXSH5upg6NlJQfLY2TZ1dGD2D2GNS3+O3mmzzn1cEpSoZ4RZa?=
 =?us-ascii?Q?14MZqxHrAhOn0SOq30pKT/jVSwQ1y5LJD5HVE5cHnP2mRWN3IF+Cjpt1MbgT?=
 =?us-ascii?Q?lXpeHwRybFkusGgAkEjqTn2f0bW01qHVQbuMXt2u9Wr/oWNxViCvgPJT7Asu?=
 =?us-ascii?Q?mNohVEQAN2S5iCYs5iLWoHWUAXxKm8DxmhcMKB6jpx/VpeAN5/wi5HC09AGx?=
 =?us-ascii?Q?UIDO0J8LwMghj9CspBoxqrOCevoT1RGFHkL9iaX0PnEPyeBlHAeR1e2bASPL?=
 =?us-ascii?Q?K0snLhRDwpTX3e9wNZ0GwP+UlQmU2CLjcqpObqBIrMblosd2Hog/isL3Mehp?=
 =?us-ascii?Q?HG9ILRl259G27hDAh3E4lPbhtFp/SprLykFVbGYMIGO6yRzUMrj6q9uVvHhE?=
 =?us-ascii?Q?nlCUAI+j1+jEhfTffe/bO68xFWzklUYJtBxy+W4RUFnoHUkM4E4KvmOsfBdT?=
 =?us-ascii?Q?TvlywNja9Sw8P+g169Tey8D4OM8IrtjOCRs14DC+ncFRvLciVUOM779asy/5?=
 =?us-ascii?Q?+Ys7cv19j2GX2/7foMNSKmZZn9xWgGblIXI9a6AzkCUJD15v+YeolhLyYDC6?=
 =?us-ascii?Q?rYueiqqqwY/NwSK1kw5KGHRYYoCoBsImWmWBTxFI1uMjqOcVVqfI476TPcxE?=
 =?us-ascii?Q?D4MIZH2yTPyNfLDtbMTPpW4ydX1+5ZATg99rO7dN5gVnbV8xy2mZDE7SUdFz?=
 =?us-ascii?Q?1dBqNjvDEhpOT1r59eBlJmbLs8uVm16hzuWIzxTcDooguSNJSLCsnvy/QGtq?=
 =?us-ascii?Q?ifGwcuzWPEm9tvEdrtvGfUCNKLZKwejMBU5QGorVO90my76jIEGoTehDxOh+?=
 =?us-ascii?Q?DTSDnpZ4VqgsBDSbhVy6bURliN25Wh9dTMh3CdopEJ6ksfLxHUjBGummulSl?=
 =?us-ascii?Q?A77U8ZkxbqciFz4vSgUucaW+JkTh+wND5Mk0XpRkpFImYIO3oN8THOxbfX9x?=
 =?us-ascii?Q?UvfWnAlVAWepCOjmsQzQOwX6TSdMp8/Bh1Oeb1u54LpVst0m1GNsQE99B6fJ?=
 =?us-ascii?Q?H1ibLTsOuyuk8V4oeWfvSOE1jDXX0SKEc2OTkCSbYudiTzwT65K2B/5mMpav?=
 =?us-ascii?Q?LGH+D06SRACNtWgKA2lDv1qD+qrvMkxFhd2Sjg1a0rHTrScIahdoKY7a8QIm?=
 =?us-ascii?Q?aFrdjilfdCUqS1BrAFaph1tSfrGPqEqhBh3G2QklarSkGJZM5Yib3wRDbu1w?=
 =?us-ascii?Q?wvxzxp0/6pWnCejVolQk7hz+ARWGwKS2wgdH4WNz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6a265ThO4pFZq2r22yZRArlyWJAdyCiw81FKkGt6/9sQpSGh8qD5AnAbdQw1w8u832q0zcvKDSWVup+WwlBBZPwRrSzBy7XJsXHNOdj/hCanETHu1DaqfIQKepynkpQwD+TcYm9Vy5dttguIXgxki4i1ZT+CMKKkD+ceSE1Jz+xpNFa9fQqudu0wfzxq9eS6ZxRUASGHIQ2VAjWRl9LP1B+AtX33YY4Vz2w1CCxdNK8jwXQUHtNsaSAWNWV+eqCn0dM0UgdjuumCO1d4/vN5Vd/cc7We7TurV5aEmDdelbqiZOXalw06WeFzMdTlvbMQGc8Dpu3mjJIF1EtIhwlc4RGA4T/8tOuBSIPiffXjEmIWVfub8YDFkm9KpzEV2i867155y431r36J6FUp65sR9wkmdt3K0+btxAWoOoJT6yuUmlJJiPiqTpfH3q12jdpUnBeMxvRBd2eOQ5GD7BbcxVJUofhRpcsURShuvImW7tOCvp495AW/O5mHiRGsAqQPUraJCeDULGSghET4z4dM+jn+LpSk9EL5SwN5jZ1DY8eQ1Vuwc02bwY5aYI74vB/Y+DA6kJ3z8qp/WONA3AJys5xyAZBweG515DPsM7rIebKQc+t45mB+opg4aaTUAcq5
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194d479a-9553-4c41-462b-08dd91324140
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 08:51:58.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQpwW8Jq9R0LI76GRKobQscqUdOtsfeqyUqc72X3fT07bUMOdMYLy+sIF6joy5aghTbHEN0J+csj52I17BbgoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1596
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
X-OrganizationHeadersPreserved: DU0P192MB1596.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: oln3Qo6_FCEo8O6AyDV9ZQVoFHUn-MCU
X-Proofpoint-GUID: oln3Qo6_FCEo8O6AyDV9ZQVoFHUn-MCU
X-Authority-Analysis: v=2.4 cv=LINmQIW9 c=1 sm=1 tr=0 ts=6821b6b2 cx=c_pps a=D21qXYjmxBfra4Dx/gklFw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=8gLI3H-aZtYA:10 a=VUIrYGzTNGiYhJFzIU8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5MyBTYWx0ZWRfX72SSdpLTvyr4 qS6vJ7QSD/KOo666RfA6+GBvy0O9Viy7je/jb7lERzcY9W7ZMrKzVSuvIDm6SnfYIFfyd3Llmpm uPJ6oIUZJvdAqCjEOw5FoCUXRv1Tt9Elu0+BHIIEsEXuLDiJz6swb21fx6LqtPXfghUbq6p9eye
 XbNrGvAeyOv0iUx6VfQW/2NDaDU1zFK/6zs1uOKtGDZipOCoqnABUFhYG9jLdYMg8ggYyu582PV +Us9fISAlXxgsHzBJNsD+5csCyW1iB1cZev1Sc1z4Evom/JuDG0eBDElkOz5D4vouwgfnB6BSmS 6Et0Sv5F38ZwGdog9A0rtDuxES0N5kU5LOfY5uHqWLIjYUY5y9+pOfNcGE0hb9BPpx1kHA/yGGd
 v6GWWUlShI0XMPQdF3M0LhT2cboZN5l8K1Mm2kD7E0tNv9SnqXQ7KzKETWhiOuk0CjbOTUZm

Am Fri, May 09, 2025 at 03:49:55PM +0200 schrieb Sebastian Gottschall:
> 
> Am 09.05.2025 um 13:59 schrieb Alexander Wilhelm:
> > Am Fri, May 09, 2025 at 12:54:47PM +0200 schrieb Sebastian Gottschall:
> > > Am 09.05.2025 um 10:43 schrieb Alexander Wilhelm:
> > > > Hello devs,
> > > > 
> > > > I'd like to understand how TX power setting works on ath11k devices. For example
> > > > when I'm using channel 36 for ETSI based regulatory domain, I can set up to 23
> > > > dBm. But then I get only 20 dBm as a result. On different channels and/or
> > > > regulatory domains I get different reductions. I tried to follow the source
> > > > code. As far as I understood is that 'ath11k_mac_txpower_recalc' sets the
> > > > correct values and 'ath11k_mac_op_get_txpower' return the different one.
> > > > 
> > > > My question is where this reduction offset is encoded. Is it in the module's
> > > > firmware or is it part of the boardfile? Thank you in advance.
> > > > 
> > > > 
> > > > Best regards
> > > > Alexander Wilhelm
> > > the boardfile contains chipset specific calibration data which also defines
> > > the hardware power limits (more specific data also included in the on board
> > > calibration flash of the device or if its a router, in flash memory of the
> > > router itself. in addition it includes a regulatory database which is used
> > > by the firmware for managing the total power. you have also to consider that
> > > the 23dbm are specified without antenna gain.
> > > so if the antenna gain is 3 dbm, you get 20 dbm in total. this antenna gain
> > > may again be specified in the boardfile.
> > > so you will not find your answers in any sourcecode. its all encoded in
> > > binary data.
> > > 
> > > Sebastian
> > > 
> > Alright, thank you Sebastian. Since I'm not using any calibration data on my
> > router/AP device, all data come from the boardfile. I've also understood that
> > the power limit reduction is related to antenna gain. I'll ask the radio module
> > manufacturer to create another boardfile for me that matches the required
> > antenna gain for my router/AP device.
> my answer might be not accurate here. which chipset we are talking about for
> ath11k?

I'm using QCN9074 chipset.

> > 
> > Best regards
> > Alexander Wilhelm
> > 

