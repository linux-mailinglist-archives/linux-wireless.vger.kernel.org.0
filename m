Return-Path: <linux-wireless+bounces-38520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O25OCrlWRmpvRAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:16:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3286F76E9
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:16:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=G9+QZRzL;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=bxfUYfnP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38520-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38520-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 429063031926
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145C49251A;
	Thu,  2 Jul 2026 12:07:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AA48C8A1;
	Thu,  2 Jul 2026 12:07:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994024; cv=fail; b=ZGfWPryklBzEbKqUprnwEKnzCFlgWpS3+90xp+53a6X6KWD71AuObG3B6ycfE+qrK9VtxEUakwymvTy6PBbuYu63mX8mFVFHX1wFG4Yr3tWuyMYIw78mBy/VTxBTnbpD4daijI/bu0jcxJgTDKHjjCiTz2AcKO65TTMTaLQnUAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994024; c=relaxed/simple;
	bh=CfWYSQ7WSZtjrX0QzrHeFGNrBnUf//PrQRf9UYKQeQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qulHfdI+W+bafrnQxDoor1Qb1/pPkEyDLu2Am5+sEJSQgs17dQgOqyB61rrIWWL43g2ULkdE7fF27/y25yECUT6K/jyr5j1IcTiX5rSHZ1xqcetsgpW/vh4dOdGZ7jAuxxRccMDTq0V3OebCoPP6B0hjbpAW7W4B9Is5oPySjAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=G9+QZRzL; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=bxfUYfnP; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6625ItQP258513;
	Thu, 2 Jul 2026 14:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	OGZwzupnHL49uzDfcMTDFzlsMmcGDNhOMpwDEdgHmu0=; b=G9+QZRzLK38ynsZ0
	7sOhavPSrRVkoo1kOzj6lXNbsm1tSGvqrqaOjMoK2v1bEBXZQYl8kfa8O1w37HAB
	voYf7RtrYgIJ53oh0IpkToB5CVorqdhis2vWGSTzLbWT0TkJpf56yxTf1y67nRBK
	ztWawtOSYcoH+cz7zr+nFdjVLdAYvDycIZdq8PugJiijGJpFM1ilJ0tnftoxrhks
	YGmftzBFdrDxn7S1BmFXbRY/AKaxCIlAQSrjvF4rZA/6jboEQwy9C4Dzaap/w+df
	B2PckeW9VETX0CkwVhWKd+oVT/fkg9U9yf5qwcRGe3iY7bOxlyBFKDAGlOCx9teY
	TBtTsw==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11023076.outbound.protection.outlook.com [40.107.162.76])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22v9eutx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 14:06:50 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYkARxwEjBZpQ0HziJPZ3TxGPMlbziFbFhucUKyXv7NM1/O6pDa22bRs7sr2CWwQhC844o+oDv6K313q88N6YfZSgu685EqRWCzBfgNWV6QdOr+Z5J1Xxp4dP70lL47ppweUehdJG7vfo0SwK2HESrqjIWHU8phkonPHtIyE9vay/MgaPVhfUy3fgqdRWrxupen6TvOo/HbP1rleFJh8mPZj+p+0QiZ73n7meDujYa08TqLahgXkCY0D94aZHcZEhqVxMzjuj3nWSOvpujtvf34hCMxZ7disF+cXIbSSWn7jYSd/AoFhLxM7yrKMKiFb9PT+n+EuMuYxXKguaqFk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGZwzupnHL49uzDfcMTDFzlsMmcGDNhOMpwDEdgHmu0=;
 b=hP5efSd2/3YWHqrMMABvheND4CVZ3qgV7+Slw/o2BAB0PwAgLsbDjgSkR5syi4wxqJhymipIIWlp/a/37a/MaU4daYMCS93rh/v3D6XFi6grXeDtWPmuElN13pnGYT0F6iywFZ8DJn7gIDAJnghwNucldyvlK8BJ65wQgf8oQV/KBzR6CtX5S5SSYpybiB+W4OQVS8FajOe1z895RqaIBNzemU5zvlOZkwNMFZCioJmBwgvIzH2NaDUlQwatP//kIf1+HKbbgEvcA8YWufo+BtjQliYA7FPYmbjm/PQ1OQWptVyZIzhmAzDcdvlZKuhNAn9ViBCpzg+mzzjTyhRNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGZwzupnHL49uzDfcMTDFzlsMmcGDNhOMpwDEdgHmu0=;
 b=bxfUYfnPn+DxJ8dUQDM/BeE9h0a7+uHKJUi06C4g12eLO3vIPVxI3Ig2cnLd4UGVZ0NaN+q+H2jU1Ds66iJmumeFqnU9n0GJio5vb7CxD7LshYYGvGj9dHcLh/Wfnw7GonTVj6jlLv7GQUgPE7SMzCfHoGkubGu9hTA+L3Qkh9o=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DBAP192MB0987.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 12:06:48 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:06:48 +0000
Date: Thu, 2 Jul 2026 14:06:42 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <akZUUhopfdxb3VTX@FUE-ALEWI-WINX>
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX>
 <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
 <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DBAP192MB0987:EE_
X-MS-Office365-Filtering-Correlation-Id: e013e012-2efa-4249-8a5d-08ded832646e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|11063799006|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/ToAj2EWB+bWxhDRrQkTR2kHRpzJ54KE0WMBNFv9q8BxC4XZ+3uq1Y6WreLobHqK3BSwedrknzuA7YRaTh/kdd3owq/ugDkysFG/Mja5h96mQTF2bqIDCNzJE3MskjtiIo1eUWCg+cN7KbiWraNxkXSIdzB8aVdAdnsmYfiqse+DFsrwSymTllNfZSeNdk9ksC7YiVeDTVJjpivk9zVY7h7zH8Ldf57h3Jhhwvh93vd+99yf56GpWJHpo/gvaX0DYSAz/bG3U64jUMNv2NPv7negARQvOLDHJfJKtM9c2n2COT7RQk5QkYvdJNiLTFXYxIzJwBe/1Jb5LSNFuzE5wmBfwACovULTDuQUy/I/Wr7NY9TGvX9U6JmRzOoxaD/l8nUNBUHKbbIyXN52iYYw9ZnZlpbw3tWbX2kTmbVP9A9tmPYfZllFbMj/bPUSXvvifRoUDOlJ28hNLnD8of8MRDN6vPaWMgjuRAoWMR4Ux6TMbLVgSM1WOIlpy6Y/uZ7BD8tGN36rahbaLNHkAHtwpPUbfJpLt9yCF02hqOt9J4HGagJmClQU5SbIjIGvwCjDcz+RV0pmN5GECrW3HMsL2wMMjVXUWLsu99ad/n78mFZnJb0VNywyH9gTHZeaDzDNwaQFIBdvTzH/p5B5hAVdYaA7nLZ6QFoC2GztmfiWbzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjhIMUVHOEUreXBVRmR5NkJQeS94T254TDNaNDduKzRYQUY1b1FVa1RyMHVX?=
 =?utf-8?B?RXpwRERiWW1nN0xlY2xERCtvR2hXNGNLMTFGQU5sZjZiTjBrK1lJNkJVNmYv?=
 =?utf-8?B?R3VYaFNHOTJvSHRhcXFUZDNWTjhFWW5IdGphU09KOWs3aFZZT3l2OWk0bjlK?=
 =?utf-8?B?UUQ3UEJjTm5oTVhqUWNPTDFSRmFLOUhxTmpxM1hrNlVtREZuNFBaNENRbCtH?=
 =?utf-8?B?dU4rUTZxSHRIYUpxZmpHRXVEWm90dWNlNmJFYjlxUmZBb0dESkNzUWxzYytp?=
 =?utf-8?B?QzBBdVg5NEpWTi9Uc05JTTcvcnI3dUZEdUVBMjMvUmhoZitFdzZXT2l4a1Fl?=
 =?utf-8?B?ZHdyTEM5UldEKzB0VkVjNEJ4VlhuZE00cXI1K2RUaUU2QUY5cHRxZU9RQU9L?=
 =?utf-8?B?dURJKzU3UFR1L2w2YTdaNlVuNlI5NG03d21KUUVsaGU3dThVUmZXdDRKWnJT?=
 =?utf-8?B?QzZMSzZjaEJ6SWZvM2ZXS0V3VUNZNG5tQ29FSWdkeTdwWjJNOXkxM3ArU3F5?=
 =?utf-8?B?RXgxd3dpOWdpM3hIOTY2eTAwOFdBQ0loR01WVE81K3pCMUF6UVFOVDVjLzVr?=
 =?utf-8?B?eGxsMG5xNE1RQjhnNW9hQThSS09pUncwdTR6TktvRjEyVjZvcmZ3R1FVZDkx?=
 =?utf-8?B?a2lhRjhjc2g5bEd2TUtyOEpDMm1JQ1JnZktVQ2JZUWoxK3BLZGFnc1FXRTZS?=
 =?utf-8?B?RHhQMEZ1ZnN3YldZRmpwdi9qQXdlWGtTaGQ0eHdQSjZST0paZWtLeGpJMTFo?=
 =?utf-8?B?d1R0SkFsS3RDZmo4WVZ3U3Q2RGRVbWYzcG14R2lZNk1uM2ZUUnpKc3Z2ZzF6?=
 =?utf-8?B?YUF0d29jQzBnQ3hDcVpZVmpxSXllRTZiclhOMU5CeitKSG1sV1JlZnliVCtw?=
 =?utf-8?B?eGI3MlpUWmNIQitqNE5qRjNDelJvZ3h3MStCSHVrQnZUTkx3N2FPRThBaCtz?=
 =?utf-8?B?Vk1yQWNERGdBaUVUSDZZeVpzVGY3RFEvUzZlM3ZFZ2tGN1k4NFNKVGdJT3d2?=
 =?utf-8?B?YjhpM0FEY01QQmVRSlhGR3VxZDJhU1lyQmJRbmxGM2FJaEFUSWpadlFmaVpt?=
 =?utf-8?B?ZXZVa0pwcFhvdzNDTExmL2lra0hHQlZaalZWczIrcXo2Tm1PcW5Id3FPNUxl?=
 =?utf-8?B?UEpjd3Ryd2t0dkVsSndCWTlkY25QVVQzVWplZDYrTG1HSTdLc3Y0RXBXd29U?=
 =?utf-8?B?UHRIV0JEbUdIRWpZQm1ha2x2bE9Td2hXcmRqWk83ZVI0WDNacGtjclY3SlUr?=
 =?utf-8?B?dEhpcFFDL2QyTVZteFBUOXBLV1NPR2pUdXJUd2tRNnkwb1hCdWxXREtHUG5N?=
 =?utf-8?B?aVNaYmYzU3Y5SmR4MmdZUk5qMld0VGVnR0d1dmR5bThSVU1KSnBxUzZQbnE4?=
 =?utf-8?B?ZlVwMlpMZjNic2gwcDlNU0xzeXRtb3l0NW9tcEk0YTVCTU9FV3h3clBSRXV5?=
 =?utf-8?B?SGs3U1BYSVBPKzhOTFE3Z3dTcXFCMTdmR0k2RHZQNk5wQ29HT2N1Nyt2akNr?=
 =?utf-8?B?dnY0cTFHZnpzUGNOUU1xa2hWSWhyUnIrTDcwSHp4MTZvc3hPekpRcjNLUGRQ?=
 =?utf-8?B?aUtGWm5BMFB5WlFXSzhmRWdVV0ptM0JpcGJ3TFZRTnNURVBrbzJlODE3TjlL?=
 =?utf-8?B?YXI0WmppOC9Kb0YveFR4SGhINUNXYm95dlNTc1NndzV3MFA4Sk5XWEUrWWhE?=
 =?utf-8?B?SlF3dmllU0NScEpET2xTeEdIY0hIWlZlRmx2K2RsS1pJZi9hZ2xDTkRWeEx5?=
 =?utf-8?B?aVpEczAzQ2t4Z1NEbThGaXVTS0I0VFlaSHJFNHNNSUcxMVNjTndvQmdIVE9h?=
 =?utf-8?B?a09iMVB1WDJtTURUclhtSEpnWFB1SDduSk9aajdXbjEyYWdZY1FrK0ZtVGdh?=
 =?utf-8?B?VXpPYXdZcDVVaFNvdzlVc1ZwUzFaOTl4MTJTaWwyajhkc2MxcTQ2bVYyZWZG?=
 =?utf-8?B?S2hmQVg5MXowZC9rejJnOXJKcHllQ1dSVkxidFJ6M0w2YmZydjJybmpwb0hV?=
 =?utf-8?B?MmpnWlpmakQyYjJWYlJObys1dmNmQUZqTERlOEdEVWRLb2pBUEZESzJIanN6?=
 =?utf-8?B?VlE5cDhxamNvaXY4djFJbjcwTDlMY0JLZWd5RGp0UUVHajZUMi9uY3Bic1Ri?=
 =?utf-8?B?d1pKdzVZRlZPdnl2dW44Q0FLbVhJUExNUUliRTV5bld6Vk80N00xUlFpSmxP?=
 =?utf-8?B?Qm5VaWkxV0JlYTdYOVdNa3FROE1mMzFmaXNFcFR1dWZOMnh2SUNrT1N0aXd6?=
 =?utf-8?B?ZjNYanEzSmhkY3FFbVdNVmNPY3g3di9UcnpaZWVuN0tucnZ6NkZ2YzYvWVpE?=
 =?utf-8?B?MW1jYk5NbjRMcVpPNitqQjZZUmhWZnBvRkM2bXVpaWVSMkMwREJsQT09?=
X-Exchange-RoutingPolicyChecked:
	NXZsRf74Vaef/nedBZRDLJqpFXjgIqw9zbAnrUzwPFo/qrQwcVWjR1YzYFvIi/xHfzh0MZRYWyhiDYSOde9ly21gWyYHncpWV0jwS/t/1yVi6Ffw2+UxE2XnNbgsPToS4o0MFYqhj09zwenkl97/0Jg+4ks2WSnbQtLPt3gPmsk7dA+g7UCwV0l4EO2gcB3swGiTgKPADMnDaUIudzF3BIZ+RaDMdzCqnnsCIQ4FI7GCAooVBjnE/xRKq7XhOUtaObwSTh/5V5LCU541hBNrhphv/D64g2yNoLIoYoyNeX5KAd+dSrCXBQm9V0pfh159OSbSmmomGnV7NnvOuKBisw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o04nbxVgWlQASkM1+o6XObIcGZ0G4WAAYvyslMyv08JTyXk4Swbc3vIVu2RXpI7Ehh5gvuFtTjF/FQKoavVsmaK3EV3WiPfW32ESQs1N6k4L9p+ob/lBGIeHH/el7sA7iwfwzeiKTEoL8h4iLbvO937C5nFJdn3K9KwUX14uZJhdQF53f3Jz9Abkx4+Dy8M2+28dktK+uZ+REHyIL3ou95s9TMr+vxaYX6Tv399XgWI2m8hZgRr/4oEyhkvCtNHOxDFfYJa9dc2qbbmhy0Yts1cBNj9fjTIsYrpesy++TrGESAGv2/tFT4IcHG/ONePWqwiouqedztOCHdjELjS4e941oteD8m7ywrcVswBefWudEzEay+aHAJqTI854NT3AeH656y1YLw7oTQx7wQd15q55xEL10/ymD25fUL4ZoePdpBjfzZqgrBoM1cAD0z9kijWT5pQor+wyAK0XZuFMx/kcfnfrgM2mOGIUASnw8no5UuY9dNc/ya7UY8qHEYyzJE8Y+1n3OZXJTSOdpb36dYy0dVgoXJbmyB9YkvXVAnNHoQUJmwxARR8qjT7Xy9E0gwJK0tmT54mtxTxq6ucVJqTjdas7TRxGRSBOO1VeWkNsmzeOliEw0aW490qMQmDc
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e013e012-2efa-4249-8a5d-08ded832646e
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:06:48.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ2WpSgU4X1FS02oqKraT/nP9BBTagzYsPeVBhExDku6HUbH9OgDwSQsjBjIf4Ixq9F0Ft+BJTHA3Lgy7cAXWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0987
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
X-OrganizationHeadersPreserved: DBAP192MB0987.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyNyBTYWx0ZWRfX2K3X6n8KIxL6
 koY6GXfa6KuuRm6kymbAODs2mSa0OBOPlPUV13wZdyaCgWRKVCuAKOUcJN3CPvVThaQ+K1xjJGO
 DFu9+67VpH5BV8R+cKgAlfb/pp1xziKRBiQe0Wiparu6e91KmrQj3EcfgluT6dc1u5+UZimfYNO
 DXdHZj/l+zmmfBkoxdvGi9ncgZ6B5YxVLdq2EhXcgrjd4ekKPCGYkmtNcSe8OwqhpEX25TD/TQo
 CSFAkhg4cZv/FrnIy5WZrDVZ9yffZVJOoxEQxFf3+YKIr4GzZgWwU7HLYADg0g477kZ0nnbJKvR
 95y47UT+fXwSc5+PlLyYm4MVxf0Aaxv6YKEiB5Yp5t9SVt3AtBx9zL3ss1oo0Nr+pi5Thh2E/R6
 VwvRAY18bUMJIBsz8ixuetw/u3oKSBKG9LeSnv9caisJyL55cZJikO4sVBARiZcVeHHl8N2reE3
 0dldRzIjTHzsnlO/KdQ==
X-Proofpoint-ORIG-GUID: hLw04RXbcMKFf1blOU6GvLPSgn1zPIy8
X-Proofpoint-GUID: hLw04RXbcMKFf1blOU6GvLPSgn1zPIy8
X-Authority-Analysis: v=2.4 cv=ZNznX37b c=1 sm=1 tr=0 ts=6a46545a cx=c_pps
 a=fKTngyASzP3QrjBp+3MnwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=Iwk81yimAAAA:8 a=hnNVPWx1YPXXdjplIVYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PqBb7rsBcpu_OT3Qf5tX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyNyBTYWx0ZWRfX2ju8Bmve1Gb8
 J2UGmSrsd4as2dwEBYaGFuBW8KaewGIfN7w9sYxZPRiezNtETZm4EI4mYRhtiPJGlaEXW3mu1XN
 oKBOIbPWpgJLMlyXG3sf8sbiy/PA4ag=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38520-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,FUE-ALEWI-WINX:mid,beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:dkim,westermo.com:from_mime];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA3286F76E9

On Thu, Jul 02, 2026 at 05:56:01PM +0800, Baochen Qiang wrote:
> 
> 
> On 7/2/2026 5:17 PM, Alexander Wilhelm wrote:
> > On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
> >> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
> >>>
> >>>
> >>> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
> >>>> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> >>>> CPU-native data types into an u8 array. On a big-endian architecture, this
> >>>> later results in a null‑pointer dereference. Convert the data to
> >>>
> >>> Alex, did you find a time to investigate the root cause of the null pointer?
> > 
> > Hi Baochen,
> > 
> > I am now running kernel v6.18.26, and it looks like the null-pointer issue is
> > gone. I only see the following log messages:
> > 
> >     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
> 
> what is the actual mac addr reported from firmware in the PEER MAP event? My understanding
> is that, without this patch (if we really need it) we get a wrong mac addr, then in
> ath12k_dp_link_peer_map_event() we are more likely to fail the peer look up hence would
> create a new peer and wakeup the waiting thread. But the log here clearly indicates that
> the wait timeout, which does not make sense to me.

I have now added the following debug output for `peer_map_ev` inside of
`ath12k_dp_htt_htc_t2h_msg_handler`:

    /* DEBUG */
    switch (type) {
    case HTT_T2H_MSG_TYPE_PEER_MAP:
    case HTT_T2H_MSG_TYPE_PEER_MAP2:
    case HTT_T2H_MSG_TYPE_PEER_MAP3:
        ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info: %08X\n", le32_to_cpu(resp->peer_map_ev.info));
        ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.mac_addr_l32: %08X\n", le32_to_cpu(resp->peer_map_ev.mac_addr_l32));
        ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info1: %08X\n", le32_to_cpu(resp->peer_map_ev.info1));
        ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info2: %08X\n", le32_to_cpu(resp->peer_map_ev.info2));
        break;
    default:
        break;
    }

Here is the result:

    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
    ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
    ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
    ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
    ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0

Let me know if you see anything suspicious or if you need additional debug
information.


Best regards
Alexander Wilhelm

