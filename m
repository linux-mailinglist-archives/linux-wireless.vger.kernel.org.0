Return-Path: <linux-wireless+bounces-38493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xMM/MaEmRmr9KgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:51:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EFA6F4F95
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:51:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=GHz75q+2;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=UzsWCWco;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38493-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38493-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CC563080B39
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA96429810;
	Thu,  2 Jul 2026 08:42:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3B43DA40;
	Thu,  2 Jul 2026 08:42:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981727; cv=fail; b=eSaWqV0oGcz+LnmbiK3+1rTavpa+phCzEidm6OMP1mXIXwDhO4UK6Duu2nFGCGLXZIt73MtLMYhVF9m7m8JJStFkVbwwBzkbHDFX3hNP949vm+cPaVGmUlCY7xL37NdPR7KYIoTbJnRAfEiG6LhEOD/QkyYakS3D3mNK2SbFkcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981727; c=relaxed/simple;
	bh=A6BgUFGbbSKiB+dts31ouUEIrBnZ0krt/hEzOCYG7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d3rNfEKms4cgT+tN04BPBQP6UOEWlbhK76psrdu0YY5TPIm4dA99ZgHpl0wfSJyEoLz42aXWr85F5MKMRNl8fPkt8vOUqguDHXixbAThoVh2o3lYwzOhoSVYYAMEf5/PIgt3fcClE9LvbLGA0SelMQrt+ibwVUafasYfdiMlDOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=GHz75q+2; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=UzsWCWco; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6625PJRi367617;
	Thu, 2 Jul 2026 10:41:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	DD6mJTLWoEAnGdhYrnn5yE2eWuZFffMuo2pM0LTxLz8=; b=GHz75q+2Jh3ns6ub
	0HCMhYna7m6VJPrBLakjhzPoXUH9cEstSrUxytEV/bZ7zhcU41m5dDGntSMpyXxK
	UChPbZ4JqH5Wr670PARV9PctKOZoh7VTq1bfC+mGtd5fQnXajotq2ZEuhzeJM6gI
	FL2HgcGuWlqU0Z3oTUI1jMsnmQZxqGWQN1DiNuIu7bLPqGJIekhCbEU8+M6+viaT
	XPn5jBYo6EGBqok1o4lb0r6U64dYcfMt9SZiEjAm7be1i06+Tig3DZXCV9AV+sYs
	JLSuRKH42JmLUkdD9V3Vi1+/e8u1ggy7fdQTBbtRuhs74x5OXJAYO+63KlNb0J46
	pSlFzA==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11023080.outbound.protection.outlook.com [40.107.162.80])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f56sg0vxb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 10:41:30 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjIj7PUdh8WfqTu+6FuZ1hENadx/W0eCNB3XZNbcy7RxrcGBCkOA0Td71epfrGrsoSBaKPOrK0yym5avL9oWsBUYuHSj2UJgtALqqqlrm2Qtpr+lJI7OYouFXsdZrLLoL3Ppq6FGeUxBjhhn4TNREajT2GSMYOQvmHE+l1mwufOU/3OOFA7hk3KwCQc+ZmFnJAfkaKDLm7hgG1pRyD938/RoU58ZomMcJ69WM1SF15qLAHVdlevAGuLbIvRJEwdTDtsOos8Ceyx/oM22pof+YuGhg4k8kozv9g3Co28uI5CiqRRY6NDnHLATB0EXlZQQcSeIzbMyje/bHPQDhNRFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD6mJTLWoEAnGdhYrnn5yE2eWuZFffMuo2pM0LTxLz8=;
 b=VupJ9BQNefWJb1s7nluGvgg7FRUtri3wuSDFiQmMTFeIlRly4dBiKSumQpmjhIr+5rF28HS1UGWP1M1co5cwXlwQtlFqoijfJ6KvnO7/dwpWrKN7vkl+w3SuY5L5kwSSkjU5yBQQBxXKp5NyEpSGITyD6VOxtr0WxgKvUS7LM03a9sS+OsCC+qN9ZrLAzTknnVRH/OOiy6lj7dw3h5HWukwO39mQ9l1H0vGbEKX8uV31j6BbPHk34eCBtA9TW22ccugIZtPiRlyzH7wN34EA+Hg+gkl1NNs7hS++KrRaRSsbl/1r+C7sxnuHuVHHOBohgtfIiM74m6aMdq970gCbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD6mJTLWoEAnGdhYrnn5yE2eWuZFffMuo2pM0LTxLz8=;
 b=UzsWCWcow/D5M1MPoSUbccE4stkFVq7gck4e9irob7K1ndHmGFYZVhvnEA16ZceEdGLZQ00D/0jVXyIcFz86l6YfnxKlR9Gc/SpyEZIujzBX37SQ23jqWuPVJoQ8jx7nOFVyKa/pfx+f1yV6vyaQytS7HmY6FUyoWbSchQ7OeKY=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DB8P192MB0567.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:41:28 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:41:28 +0000
Date: Thu, 2 Jul 2026 10:41:25 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX>
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF00023A06.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::207) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DB8P192MB0567:EE_
X-MS-Office365-Filtering-Correlation-Id: 72eea55a-d107-48b9-d7ef-08ded815b562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	i1w7dhFssR+0IHYhVHF4fXIfN1HwJa5BusJfv1plMrnemCbbnuzVpxnuh1ICLHvmlK9242VwyRyjhRpL+Sndp3c47Z8ye/l9bY6gvWPWvnDfFJIwzdbhc/gy8JUR1jesRpEOkNya6lL118E9go8yYkRy+xQ3Ucsu1cnufoJBOigoU6Eef2Y+qD4lEZOqYGdv9js1guP28QxGP3Ro/Rtf8qgI0sDWLyhvj4q231rX5WtaylB/2EPVfUMyMS9+9WPzLe7jba29J+iVem8sGr+Pz93DytRj5Bjsiy878fx5SeaHxChi9fP08IakdsE14yJS/C5sTiNqtQ840AXhn/cjvt4fjQjNuqmOWtqc/O8qMycLhSYXhdT788xOWUTCIIdrRk+SzXGov/MU45ZZNwGjldvF/NBv8+laOU+SOhzRyTQji7O/WBAtOVf5v7/lduhh6GSdxi0r1rlkfEpjo8JnJgP2uBFBUPxBI1OjnfNOcd3zxKIk1jSR7IB5gLHlkC36R1pDgsM4UfcNVxP4ngPGirIPrKfTmsQ7PVdkgyy553DqFvuIGS4+14/z/tZBkZDUYQY3vSlYxmolumQPS8ZJl5ORzTusKOf+dmS8Evd+tVrZA0WA67memZutuPc6wLEL0Y3gSl/7+tEXbxc2pGx8FxCBxR7OZ3wuf7Q7TMeoC+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzdjWWtkdzdpVFNEOXNsbC9qdThwK0FIWVZ6c29lZnYwSHBlVzkxUVJqNDNt?=
 =?utf-8?B?RFZlaXdTWnZ1cHFoTHlhalF3RlNaZjVSbzNSTkZyS1NyZXBPeHRqK05oU1Rp?=
 =?utf-8?B?ZTgxWjNIQWxDS0ZFb2xyUmtKMzd2LzN1UGtrQk9NbVhwa3lDb3BVSkd1U1NN?=
 =?utf-8?B?RUovQ1ZkdkFQZGp2elBEU3FoNzBIUk9zVFF5WWc4d3dGdTJoU3BJVjhUMUdp?=
 =?utf-8?B?d20yV1VnU2RYRjdmb3p6T2RVSHk2WTFYQkhKc0dSMWNBQ1dCK0ZIakdYMGNV?=
 =?utf-8?B?TnQzWGg1Z3ZqZXBWb1FLUmdTTFN6MWIwTTRBZWVwR3pVLytJeUo0U0ZsWEZE?=
 =?utf-8?B?YXNna281d0ZJR2VoaVNQL2V3WHRaTkUvRERoa1UzNDh0RmQxMmZvUHNnS0NS?=
 =?utf-8?B?Q0JWTitETGtvTkRBL3A2NFpsNys2QXRkRENRbEw1Rk12a0ZyV3hzNTh3SzFM?=
 =?utf-8?B?akxwdjdJcmp6RU91TFhRMzk4N2tDQ3VzRVVMZ0craVZ1TXZHMVRQUmZJQVpB?=
 =?utf-8?B?cWZHZkhLR3RGK1JoS2ZkQXFvR3ZCOGlwUUJIaXBNUmJPMS9QU0lWSGFsRWsy?=
 =?utf-8?B?Zk44dUxyYjF4MG1tTlQrZkRNd3JCdGJ5VE1Hd2hpVXhpT25yMDQyckp3NUVw?=
 =?utf-8?B?Qnp1RVpJbUNmVWZnZHdKMGd4aStaV0hPVlVRR2tBMEZOcDc3TmF6QTkyK2Vy?=
 =?utf-8?B?Y09TK1poVXZjR1c5RWt0dnRSVmRIUmFFSE5OVzB2S2VQVXFQZWJua0ZiY2Jj?=
 =?utf-8?B?N3J6N0RBK1JFc2tjNW93R1hVOWZZazRGdlJPdXNnSm5ubWFUci9UMm9nVWhM?=
 =?utf-8?B?NTY1eHFic0dIVnVlbmw0WG9UQkN5TU42WVFIY3VrU0xPN1ZNelNaNmdHUHRU?=
 =?utf-8?B?ejMwa3ovY20zTGxEQzJTNm1mbXg4aSsxRlNVS0dBYWxGS0tkQVZXOXlLbm4z?=
 =?utf-8?B?QjlyL2t5SDNZZm0xZXcwSmdTcWhqdnE3TG9ldkgrZEdOdlJLU2FGTGd1MjVB?=
 =?utf-8?B?dWNZcjNBRUJ3Y0JvWkZvOW5hKytiS3VqZDVjV3k0YjVRWGhTNU1HTlF0RFha?=
 =?utf-8?B?ZXpjUkZoMzFmcTJWdHlhbXJIWG9yeGRUNzJOOUIzU1BROEd3eVk2VVRzMFh4?=
 =?utf-8?B?dGRZQnVuQlJWNW9MOFFzWkorQzhKMWxCbjBsNEYwdjhOVkdmQTVaeXp4SVh1?=
 =?utf-8?B?c0N2WXZPNmtteWltcjJibVdIejdwa1ZJbkw4Q3NqWVB6SWxLT1g2cllJUE1x?=
 =?utf-8?B?eHdFZzZORGU0b1VySFlzTEJzZHRqM29Zck9oc2hzcUxQbzJrM3E2d1JhbUo5?=
 =?utf-8?B?ODhkV0xsaXRnUkF6U2hVNGlRTkRFVG1XcmJkdWFuUWx2S2huUWJKTUhFQ1JL?=
 =?utf-8?B?Tk9QVnRVaXBhRS9tUU85WEtWSXFsY3I1Wkh0WUs2OVkvRzBlbk03QmRhNUR5?=
 =?utf-8?B?ajN3WVEzeTJqbTRwenphUmk5SjBsc1VoakFkamUvTCs4Y2FYR3IzV3d1V2hz?=
 =?utf-8?B?YnliWm95dDV6WXMvbHFkQ3RSVzc5blI0L2U2ZzdrN3ZmY3ZtbytJN3R1OERs?=
 =?utf-8?B?Ny9QTWdabzVxVHU3ODlJVFFSMXJzN0s1d1NwMEFSWTlyMjhpTFRMOXVtQ3ZC?=
 =?utf-8?B?emtsKzFna3dFcXVZb3YwYUcxdXdURUFGcWp3bk5VY1NkU3JrWHVIbFRONHpn?=
 =?utf-8?B?OENLUFgraGNSZ0dnRUxjM0Q0bG5FelZzMmZWSTB3TDhIcVg0cU9FOEVhZjhm?=
 =?utf-8?B?WW9mMW1EQ0t0TGZ2aGNJOW9VMlZzNktDQ1RSZlppbXl0ZVBIYmR1K2lLMkNr?=
 =?utf-8?B?MGI3MEhEbVo0QlpQTC9CSnpTZHZoVnNtTkRWVG1nNW1YRWl5QkJTcWxpM1Qz?=
 =?utf-8?B?SGVFZXpDaGxPNDBvVnhKNUIzdmlhUk5Bc3hlcHpMc1VXVFQ2YklkQ0lhaXJX?=
 =?utf-8?B?VlJ0c2RyNjRjT2pzblNYTUFUOUwyK1RJVjBUUlNRUGlTUHRYcit2OHVmdk0y?=
 =?utf-8?B?MkY5a2xZUEMxOXRpYXdkbTJUdXh0WDFFdkp0Rmp1TnBtVlhJUGkyVzY1Yksz?=
 =?utf-8?B?ZlE1TXlzeG40VzdvbmhUWmE3elVWYmwzTUlxOWxTUHBTNkFUV1p6M3VhNzZL?=
 =?utf-8?B?RjlaMjRUaXNxQ3c5VVJFL1lmengzRFcveWhibVZxYXZycjViUXJ6c2pLUVlG?=
 =?utf-8?B?citwdXJqYk1lK3psS1dGdkN5VktveC8vL0lQNzg4Smg0dzlsWXhzYUNGUzVm?=
 =?utf-8?B?eFJncWx2QzJ4WkQ4U1AzQ2UyajBZdTZFc3lEZ2QvY3ZFZ0Q4eGYvenE0OFMw?=
 =?utf-8?B?S2tTWFNnbzRMdDNlOW1rUnEwWjNGeitFb1VGZXhGeTFSaTExSFZKQT09?=
X-Exchange-RoutingPolicyChecked:
	Sj2lCMuQzhD5zcXEhJsFK3ODKsqfkymJq9z3Vd0tCo3LWUPmOI38DkLydU2m+UxFVPiw5FLEl95jjrz5PFr7YFKG0svSTrr9O6QkMSfk+SfJeI+7/kmcgrT87e1ntOSCvKrk29G/PYt6m24chjyXW4sS0lS7htin+Dp5MdvEAHHxmKwawW4INDBGNDc5AU79AOZ5U+7zZJQzE0ogXld1ZTBzQHl0jkxudjps9Om6cG01NbvDB9Z+0jNYEELVHTIxviu3+TwsF04U1BM9SVGhKKjLH46QWgpnrwDtEW3QbRVMkV1J6Po1Si/T/tCPgEadIz3HKG4gah6Rx2oFdU23Qg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i7AkZdTyjzr8asyNVqYXElhwePeF94RIKC/wkA9X4kpuYA23nDvrt5z0GMBXz0LcSGczRkMQ+kKkHm84VmujlVWeCxVSM8AxzgEZBTl0+3BXO+mN92cXiC93p76vy9xnXwCs04wEXD/dKHDvaERcE0FP7/W91xTKd2Mwfw25F4XO/EpQ9A+uQejpRNnhW1MHBvfW9lAEhYhRQU7YRiT8avhRwjm80loWQDqH86laZ8ccf4PRz/7koumkSmg8SVV4PgePRbLVAUAnRz3RoWcznUmtzIVHYDFk4c9zhrx4jXkpmuxBZxID608Xl6mM2F4GmkPnUunp38RFAAl9JdO0FVuXoykchTcI4n5u66YYukm2HScA6H9DsfaxsRM3b/IxvRpoZIb5l/hiigHtX1/unKJf8ZHsznoRLPmb3Z3rwv/EfIkjExHTzgLS9aaEUU83IbdxtyPIEvfPwL4Bp0PMG7JAxkZDNXR9j3iBMKgypAhRuCH4VKsLiXm5jMgz8XEuf9B1Zse8Qi/TOdsmsrCi91uzCzhIEG9XClAQ0Q1FlQl0nB/L5IQLJdWuGXQH3UTbuE3rj/+Ff8a9mK1emdW21zPWxiJowkkPbB0afFfwd+vacgcTAnZqnTBLtbSbQQc+
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eea55a-d107-48b9-d7ef-08ded815b562
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:41:28.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sa7P76rA96KXROcyp8aCYHtyfeyQ8Ua48Qz5GGJhL/ysiCTCMcz9ZNeE5N6v+K9bTJDVrsXRo8faUQEOZVh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P192MB0567
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
X-OrganizationHeadersPreserved: DB8P192MB0567.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: 05HbiEzG0Or98W3QZibc6N14lYWV-0J7
X-Authority-Analysis: v=2.4 cv=OJoXGyaB c=1 sm=1 tr=0 ts=6a46243a cx=c_pps
 a=zd0CiqMXNVdXxFuv96ExhQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=kFR9s1XqmY8H0OOOTT0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MSBTYWx0ZWRfX+DB2Ey+5MZON
 RUKkvxzH5M4Bzm6R5FD0FmZ3BRE0em6lHaFPaCAGed040k2MH3xeXVvC3UHdVoOanCKWI/NKDHH
 SwXrwuP2rs1LRXekQFzIVGiEq2pLXI9RyhhxyXSdhOSW9mZbooyQSILDvoE6XGa4bKgfq6eXmZc
 LLt0PnXVUI24azIvxtPYLeuqg4gRSsqE4Tg9hgMhYvA/RLauV7wf+9BVpAQOwIcKyZiZayyC5Fp
 e9a42gVFqi2/Vu+h/55IP8bcQ9q/xHprlBglIfK/V/XsbCrdwYZ7orxHozFJZBoyuIornTySW7O
 7JCm8y6xzrhvewrzAbFe1MpZ7q2KEkY/HHiNnWS1VOsrKjLrD3KNIjjutWMzj2x1XzfcHws5sam
 fQuMvYI7y7QSlKkxnJ5MUVvT+Gk8gv/I5Gtz7laRSOa+d88E9ZVLJ2njf0Df/ZEQTREIlKog9Rk
 5SJ5nZoZNITMV6j76XQ==
X-Proofpoint-GUID: 05HbiEzG0Or98W3QZibc6N14lYWV-0J7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MSBTYWx0ZWRfX85nF3iuQC4ga
 mdomDZHKWX1xaW/203No9N/GR5hf1pY1FiSGKMA04pcdY2FcEq6NHIML8N6FEgmKIlPw70qFhcX
 b7CCHA8bBT4lW6uhUAWEBz9IHdRxbj8=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38493-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,westermo.com:dkim,westermo.com:from_mime,FUE-ALEWI-WINX:mid];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33EFA6F4F95

On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
> 
> 
> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
> > The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> > CPU-native data types into an u8 array. On a big-endian architecture, this
> > later results in a null‑pointer dereference. Convert the data to
> 
> Alex, did you find a time to investigate the root cause of the null pointer?

Sorry, I haven't had a chance to look into it yet. However, it's on my to-do
list. I will try to reproduce the issue again as soon as possible.


Best regards
Alexander Wilhelm

