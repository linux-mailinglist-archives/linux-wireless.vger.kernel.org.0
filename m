Return-Path: <linux-wireless+bounces-33458-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLoJNbivu2k8mgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33458-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:11:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C82C7B1D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E0B301CFA0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FBD3A75B0;
	Thu, 19 Mar 2026 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="EpdD9XMg";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="wxc8a/Fw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE03A6EF9;
	Thu, 19 Mar 2026 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907675; cv=fail; b=ChY1HVaFC2l2nLPHcYIMGYD9lczk4e+IbISJzdTJhyF0mA0mYKHu6cJyJEtwaDZgltDkCc2vc+DSTmIe56rY0eKyAq+Ts2BX30nHjexH1ry8KJJHYXRFXU3JqRYovyk1b/9BqKqDCSUnva2K43oQlOMdsNwRUVkzON64hYtGmoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907675; c=relaxed/simple;
	bh=m7BYui9K6Hqr0wEBGMxjRqMkILa8TUpCsE0RHW1p1VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hM/wPjVNFc3dZPFUPKeEuwenuH4vs7OXUVr1t1pdNmmsUPtXeeYL9NRaHobhYjPHRjlWhB3EULiCijEsDyp74T4bTq7VQwKv1VzamFzySvXB7D5ZjNmWYNEpVBSOMW9wyfVVdx5zVUbXERLeyDjfZg2eH+1IoMw9HJ1VjaknFwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=EpdD9XMg; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=wxc8a/Fw; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J508NL3726730;
	Thu, 19 Mar 2026 09:07:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	Gsy+wpCyZV20FuwPp5BO59iJt5JnN+KygL2gkO4aPDg=; b=EpdD9XMgY1TX5krE
	SOY1pOeG2vq/VNFsr6w1KpiknblxPCpfX2OigFGy3XYj5rADKIiv+a/0Yhx051AA
	GWCDtuaBVm4+ktnpsq9amGGpj9QRdb3MaRLpRQgpI2WMwshKMiHRfXT4zeoxKlc8
	pP/pkyyGQoqE83c1bLV2wPboL92mxlARLoIYCwFR/hLxHMZvE1Wzzd1pJiaAHHsM
	3Htg56TC/NwJF8QzWmm0cNvJb2TiN4mXD9fXyVwbLOaR/1dPGLWhwUnErjTVcvVv
	tJ1m6U8uY9SSRYNY0j2BET1/pGNXaOj0KrlXQfrIFhPGNWhSU63HDudWgWxIzYIe
	A/cKIA==
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11021126.outbound.protection.outlook.com [52.101.70.126])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cxnkj312v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 09:07:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTaIgUL0j/RgSi7acK2SIB+JlkcdFP5Cwo0MfYWmkVNPggyn/J7OqFF+XmgOZ7I54JvGQCtgZX+i+PuTzExCIVWiPNvdmaE5zjzWBtAfguMYM7zcx8Emem6gfHKXOhLiE2YoJiW5MOs3ghj04grETRuzO4Nb0Y7NjOFXNQQ+tq6sqTClYMA4b/mq9dI8lcqTbWjnG/6MiLKMFjmVJPyE5HKapoamlPLW6fI8RnpRUkF/tyWwvrBLofyI2Bwvph2jn/oOZIU7QIkDUetQnqWURIqP3dcaYdpx9lTFEVeZIFgZALOEKVZSr2Lw4ZWWGu9T45g4HpurdmZaAmKGGlNNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsy+wpCyZV20FuwPp5BO59iJt5JnN+KygL2gkO4aPDg=;
 b=Y2tOPKajJZISJflzH92AdhnoLBZpUQVP5i1wbDbNfhUucvdNkNVNxVqDKRV4/eOsn0Huzjp2XtIrz1apK9sONQAxEirI8z3yYS710+i7rRl8IunOgjMDO7NyOmB7qqFiJ9U537X6dfejithbjQKKYJokjxGbFlD9fRFNjilgAqob1EMs0oIqnHsNuietnrsUEkpG1rFH8/WDRV98JR8IyhZlY4KVsKOo3Ng0ja3Km3nVowxmkIB0NFo5Mc7eBZLHKtIV29sSPlp9m/uNTRcmPdojb/uwVMEPFImvnVW06s0T+fdm2eGvY7C5nD0+wmoyTwgytOG2DRuzaetqq5esuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsy+wpCyZV20FuwPp5BO59iJt5JnN+KygL2gkO4aPDg=;
 b=wxc8a/FwviQQlCALkFBKmvb6YVFMA9wpV57fulSt5mA1B6bUSbi3IOM3Nvbu8BzMqg2tPU2joFyFvF1ni952bSKljChV09uvF60gyHjjOXHgzf/MuIZ7NpZ1dWsmmpYX8PPmG2Iy/OYEzcUm4d8ypgSxT86fSPq6LNlgyWhSQPQ=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by GVXP192MB3337.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:335::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:07:26 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:07:26 +0000
Date: Thu, 19 Mar 2026 09:07:23 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <abuuu5XX8MwhV1Bu@FUE-ALEWI-WINX>
References: <20260317-fix-mac-addr-copy-on-big-endian-v1-1-b7b6c49cb07f@westermo.com>
 <44549364-7187-4b1a-b1fe-5bf6e309ec16@oss.qualcomm.com>
 <abufS5-aJhi63zs5@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abufS5-aJhi63zs5@FUE-ALEWI-WINX>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF0001DBB8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6f0) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|GVXP192MB3337:EE_
X-MS-Office365-Filtering-Correlation-Id: 50397aa3-a7b4-4cce-ef40-08de858e8ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yVU2Ccl2ib05LsTr+AXpOddSZPY0h/4dfuqs2t9jEZhI/Gy0JPyrp6n72V+Xii7WHIkyDFqZnQPnlV9xZGHRrP++3A96xZ4wplKFSLJn2j9w+7uvAe1fhj30ZsmZEKCpU/eovdTziC2BGjTiCw3/zzY9nMEaIz243qGgr4qIkjueeI//8QdZ+LhmQuSRAG+yH04jXl5vpd+mSGAkpzeJHOy6LsMzE4Okvy0Ri0LtikKqfA8eh2PKsyVA2J3V+9HnLV6+JwkOqkGS4JoILgdOeQLFPgXnf14vrx2AbjAihaaQl+xBd6S1bBLDLZhL89wTXCFOmgkyztmzmeeOQNJ/rD90ALsJ/l28AUIkXU4mmtVCAhjheY2SAMvxetbWm5AGSJxqBzUltVtoONPB9DUa3Hd8vfjtSaAcmJewVjHb2w3IevuYRg2XCnMU6yCVIXNgQSHKNGoSGEmvucffrJm/+XR1SEZ2NL8QwmEmncOjdZwV4tzHm9N9E3rVVoMaOKf0sDEsaMfwrs02YA2BycjC6kXYFFvekbjhflaYNSEl8bRg1f/Te0QV6rRA13+BhrOdIU0pnbd6qXUtIEpEOWKrPAEFu9P0kJZZorimjbVNHM0iEBpUkas+xm7ZX3XWPdHL7Ajek0KcYIJIuirFxlZTGmIO4+LW+GptOpgfKSE0nJgLDH3yYhWMz3kRQpxsFu4tPVcfKRT0aM6am3voXPkE+2GkmkmW+RJBc+teZGAd+3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdUcVI2bkYrbGFLS1NWaUpJc2J1QUJpK0N5THB2ZEtmQVdOeUs0OTNKZlo0?=
 =?utf-8?B?TzBVcFY1bWowZTFXSHJ2VUwzTjNxOG9MaEdSczRFY2hLWGVzMkI5Y241OTB4?=
 =?utf-8?B?TXc1eHNKZ3dkR0Q4NGNqWXlTSHNydGhwU2FIcko1UUN6VFZVYUNDVi9WZHo5?=
 =?utf-8?B?VnFsSmk5WGZueTF2STRCYjkwYlFselA3TldQYVBuSTduUHd2WWduYnI4bXZR?=
 =?utf-8?B?ZElMYUd4Q0xFOHQ1cXVpQnlrRjZRaEF4UUQ0blFELzZTOHYyRkJkOFN6WUVI?=
 =?utf-8?B?N3VrY1NSWThpRDVNYkdMWHlxSXFBRGV6ajB6VS90RHNkblB5NDVGQkJYMm83?=
 =?utf-8?B?TG4vci8wZ2pUNWR4dGM2WG1ob0VqK1RYb2ttTWF3dkFMRkFSaTU4WkJDUFNX?=
 =?utf-8?B?NGtkOEdJelYyUUJEbnlqSWFRWVd5MWc3bFVJdUdNZXNiQWZIaUZVWGpGQlNn?=
 =?utf-8?B?U3I0OWtycDEwQSt6RkVOd3BFa1ZrM3dnNDl4QVNjeWdLTEFvM2oxYW16akF2?=
 =?utf-8?B?eGhMY1pQVEFKcjl1dGh4MDdvNSt3cGg0b3prTTljR0Fldkc4QUNIbVlQb1NM?=
 =?utf-8?B?bXZLSDZ2ZVpKcjBYNzk0VU03ODVJNlRiajJEWFZWNkYwSDgxYVRKSnliMW9R?=
 =?utf-8?B?YzNQVEZ2VFBCUXlBYm5qeitIMmdNR1NwNzkvNkxJdklLbFFwTWpPZ040eFIr?=
 =?utf-8?B?NGxpWnFJZXcyQWErUzFPNzVEOG5ycHhpY29SMW5qWUdqOGREL1cyWmVHWkNa?=
 =?utf-8?B?SDR1bEM5b1Z0cWJNVTFkaEdGZkZ1UkRXYm83amVSK2RJQUZyZndoME5xNGNw?=
 =?utf-8?B?R01GRHYvRTBtM2lSZzA4UlJDOVAybGtNSjEra1k0Tkd4TU1McWgzWGJPZXRz?=
 =?utf-8?B?dlYvdDBrNGpCVGxhVHJtZkN0TUUxY2N5Q3NBcDBlWDFJT2MzTHBvWGF4VFhw?=
 =?utf-8?B?SEtKUzY3dE1hdHR4NXR3cThPZjVsM0lGaUQxWm1DRXoyQk8rUnVwbEpINHJz?=
 =?utf-8?B?dDdtSDRJOFlQNmNDVVNmR1NPM1NMYklGRmxKUU5BMDJIZFg0ekJIUGNENFBW?=
 =?utf-8?B?OGxwRklJemdLTG16VGJTbkRWVklXSkdOVjkwN3pVeTZjVTZyVURrSklrdlBv?=
 =?utf-8?B?VFpzS0FrOTRiOGl6TEw2VWFzWEF4R2RaNHo0dFptZUQySG8xcmd2QW9EcTZV?=
 =?utf-8?B?NlBQR1FVZGh1NGVoWGZtK3RQY0RaeDdVMVVsWWZPem1FaWIybWRhUVJsTjhy?=
 =?utf-8?B?RnArNVVTQUJrQklzQzR1ZUNsWlU0a1FxUkdQVUY1ZldRWmtaTHlCcmFmeFUy?=
 =?utf-8?B?MU42M3pmdlM4cjE5czUyTmUzY0RjcEdsOW92V2hCeDNDeDVxaDNqSm1YWks2?=
 =?utf-8?B?Y1FzaGk1YzhVa09VVmRVVy85ZVhpbjN0bm1tQ09JSERBTDVYM3dOMHF3Mnor?=
 =?utf-8?B?a0JaanFLdjVoanBuWExQcmxNeDVnTncvUHdNZ3hMd1p5TnVJa1pQYnVpa2dG?=
 =?utf-8?B?Z2ZqRjZsSTBrY1k2WTJVSWxGQXR3RFpEODgxQmIwejk5SzAzamFsQXdBRk5C?=
 =?utf-8?B?dmhqNDQzcGlybis0RVA3TjBsL0dGNENUVStuNk5qYUpVK3Z1Q2llcDZ6b3NS?=
 =?utf-8?B?d0cvZGYrQ3dhZTM2WmgwOEp3LzhjbGNSa0g3Yk5tNXo4L1B6NHJGaE05MmxK?=
 =?utf-8?B?Tkl3bloweGZHVzdsdXZHdEU3eVNyOWNJbWdxSk9kdW0xSnhwbEkrTTdqNVJ1?=
 =?utf-8?B?aVpvY0lVR284bk5KSXBhVjFKRG9JWEo2YW9adXdxVGl0cGs5b1BDM2RKU0dv?=
 =?utf-8?B?Z1dsZkRvdHlqTnJ0Y1dhV2dCeDkycG9NVktKbVFvOXBKenlKRE1EY2tMckhE?=
 =?utf-8?B?NlduYnpYU3pYc2ZUL3o0RmhxM1lteHpWbXYzQnpRc0VyTjQvUnZoMTR0elJG?=
 =?utf-8?B?RUtRaTM4S2dNQ0NPWWI2YTBqTDRsQUlJYkRObFl2UUs1QjVtdUs0Z1VrdHFJ?=
 =?utf-8?B?OThIYlJ1ZWhSZGF0K0Q3QWpFaFB5dVFqU3BkckMrY0NDdlhmb2hnVFc1a1Yx?=
 =?utf-8?B?bVE0QkZXRGc0WFlHVXJmSmlaQTJrUGx2WWxWdHRPQ2xlM0VGS05aeGJ5Q0x6?=
 =?utf-8?B?WTlQazVhQ0g1Y2lrRW1JZnpxQ1VPd3lNeFlrZXFGNFdoYm5BcnI1L2NBK3JC?=
 =?utf-8?B?bGdFd3VKZUhnTlREQWNPb1JnNFAwSW1NR0xIdzhoWS9QM05jN2dPQkJHZDFo?=
 =?utf-8?B?YmNtc3pFbmdXa2JwcTRySXRvRjF1TnBoUnU5bG9CRCtNMVdhYWZ2SFU1UGJC?=
 =?utf-8?B?UzBoeUluMWFUZ0NYeHRuOThFUURuLzRzZmFmbnJZSGJIYnVtTDZ1dz09?=
X-Exchange-RoutingPolicyChecked:
	bE/SgN3VXefRm9Lj0nej6i7TQn9kG/lem+MgpDjUfJXmjMnMtSSucsLC6Xo4Zcb7rolCNebpqVwHAFcxIgoIN50yIdUw18TNc4ycU2IaypyqH0yfyN8xDmzPbReFi15jnZqHkGO9ZBh3u5eHBpCebqmJ2pgo2eADyUrYJCf+8veCRi4VxhTXFU7xGSHN17ifpOL31VJw21oORQoD9Me6rs0bp6JuuMjtO9BpECbbrcmDYee/F+8/Xlg+OP/Sid2VgvTC7fnrgyXxsdnGoYB2K9b+dh7H6sv6L3xA3qrEUpN/NyiO53+L4ZDbJ4I3H/2cx1PCmIwOSHsHCvMB7hTkRw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RB+neth4ymWuoZ1+gFsCbngYefTq1qZaPROAaCq2J3zexE9LBCvMxuTerMhXrPr91Ctz1XsYLgyzZZXMhnBJ3dbHDR7+4v/o8oVFbXuRgNnyuQzZewBAf9OTxYA2Chi2Tz/sRH4DI9hDDwtyxZBTJm4fJklr5wDG1kYE/szheiK1rv/AsDAP8basurcm2vJ3PtsyechNZqUfFWQDm0JurYl+1l2KiVWpxdq9gm9YmxMkN3WtAHDRH625nJF9/zfzoFj+QjpW4K48XyPaYwuNdlTDfF0eH9wPivZgV4ThfnWD+4f4l4UL1CckdbgqCpqxijunjfd/OH9b7YSw8CKsYJVF7hw6eUsVPkSXQefFsvov0lFHSCbYp92vGJu8Cb/j04WHwfVbAD05GCvMxkt29+c1606HYdV0/1Pl0B5Ba5f2uJiQaaIv2t5Y8uv/+MOCQNCQT2YWskvndKLHhYPUwsBn4Valk3yJdEwGRQyt9Qml362AjTFGo9LYjE21usX1+iWRaFTUoUnisD6Pe1qZSgdKjw1zs4nvMZhuumQSo2bBHnvm2ssmeD/R/Csg/M+1imeL4PTa+kD6t1hLGJYz+DreT6gIpz0CWVpqLaBqqnpc1aCE7it8WDK8jmO6XinM
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50397aa3-a7b4-4cce-ef40-08de858e8ed3
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:07:26.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sazvdxy/4049MAXGAlOQsXmNxIMFtWjy+QOrRA7NO0Qx3mFW7udwXgxWKcLoPXxCVBwx2Uo5FAckv9varzAo8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB3337
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
X-OrganizationHeadersPreserved: GVXP192MB3337.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PO8COPqC c=1 sm=1 tr=0 ts=69bbaec1 cx=c_pps
 a=ad3FQc2+b8yQdOhNbPUQ+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=COCK9XGAbcT1FYSOh4MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4lW4ti93woRBVpTRZvJAhUovMVst5fF0
X-Proofpoint-ORIG-GUID: 4lW4ti93woRBVpTRZvJAhUovMVst5fF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA2MyBTYWx0ZWRfXxXBLkl4YmtRo
 9pkgsntsXK6rrPc23kv6HTWRbl9a4BDCcRQnTzuhtYaiENxjLZI0jJZFWPD/SCqp17gPHbSUSZV
 DNwMlfkR1wyY3/9pcoVgD/Xx6Ppfqz/ScYSUOjelYQGiN7ZrFs8H+Ov8CB5aeBxHPWLLHpI58Dl
 497VN62GKYZO2VYZF9ZBntX78VTPUWNbn5h3spMJDmwAn7F4itthpNeiyb6S83n0uqnd/+6+qsz
 5Xp5JtD7kbgvk0+vRD4gAVysYNlrA9jNpz0G0XY2B9OtsIea+zuAj76wIS2pGPTnYeulbgLAe0/
 ZYs3DZmoehyhWkOs9DT+wsUPlk29eQ5aZvgVsCF9brcUUVpgud90/lfK2KRpRo8Jendx4L9k+yv
 ajnYHiwhezgDc9ortpma7Zzo9Rb1u4cTNF9pSWRYCc2+PEy6nC2tjVqXgLggAaikndxtk8KbNfd
 +pIRha9iap0nq41uJCQ==
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33458-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,host:email,beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 341C82C7B1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 08:01:31AM +0100, Alexander Wilhelm wrote:
> On Thu, Mar 19, 2026 at 11:00:22AM +0800, Baochen Qiang wrote:
> > 
> > 
> > On 3/17/2026 7:22 PM, Alexander Wilhelm wrote:
> > > The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> > > CPU-native data types into an u8 array. On a big-endian architecture, this
> > > later results in a null‑pointer dereference. Convert the data to
> > 
> > curious how could this happen? how matter the endian, it is just six bytes which are not a
> > pointer hence can not be dereferenced, no?
> 
> You are right, the wrong shuffling of the MAC address on big-endian platform
> itself does not immediately cause the null-pointer dereference. But later in the
> code execution this address is used, which does lead to a null pointer. The
> execution do not handle the error and continues despite the null pointer, so
> this may be an additional bug. I need some time to find the exact location
> again, but here are the logs that show the triggered null-pointer dereference:
> 
>     user@host:~# hostapd /mnt/custom/hostapd.conf
>     Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
>     BUG: Kernel NULL pointer dereference on read at 0x00000008
>     Faulting instruction address: 0xe2077f38
>     Oops: Kernel access of bad area, sig: 11 [#1]
>     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
>     Modules linked in: ath12k(O) mac80211(O) cfg80211(O) compat(O) ...
>     CPU: 1 PID: 8455 Comm: hostapd Tainted: G           O       6.6.73 #0
>     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
>     NIP:  e2077f38 LR: e2077e74 CTR: c00833f0
>     REGS: d0e7bac0 TRAP: 0300   Tainted: G           O        (6.6.73)
>     MSR:  0002b002 <CE,EE,FP,ME>  CR: 28004484  XER: 00000000
>     DEAR: 00000008 ESR: 00000000
>     GPR00: e2077e74 d0e7bbb0 c1dc4a00 00000000 0002b002 00000058 0934edc0 001c0000 
>     GPR08: d0e7bb58 00000000 c9370948 00000000 c00833f0 035012ac 00000000 04e04690 
>     GPR16: 00000000 00000000 00000000 bf9d2070 00000000 03493d36 04e04660 c9349600 
>     GPR24: 00000000 00000000 00000000 c8b1d1f8 c8b1d248 d09917c0 c8b1d614 0000000e 
>     NIP [e2077f38] ath12k_mac_11d_scan_stop+0x1c98/0x31d0 [ath12k]
>     LR [e2077e74] ath12k_mac_11d_scan_stop+0x1bd4/0x31d0 [ath12k]
>     Call Trace:
>     [d0e7bbb0] [e2077e74] ath12k_mac_11d_scan_stop+0x1bd4/0x31d0 [ath12k] (unreliable)
>     [d0e7bc10] [e20793b4] ath12k_mac_11d_scan_stop+0x3114/0x31d0 [ath12k]
>     [d0e7bc40] [e1f5b41c] ieee80211_do_open+0x13c/0x8b0 [mac80211]
>     [d0e7bc70] [e1f5bb40] ieee80211_do_open+0x860/0x8b0 [mac80211]
>     [d0e7bc90] [c0675318] __dev_open+0x108/0x1c0
>     [d0e7bcc0] [c06758ac] __dev_change_flags+0x1dc/0x270
>     [d0e7bd00] [c067596c] dev_change_flags+0x2c/0x90
>     [d0e7bd20] [c0774838] devinet_ioctl+0x2c8/0x990
>     [d0e7bd80] [c0776f60] inet_ioctl+0x1a0/0x270
>     [d0e7be00] [c0639750] sock_ioctl+0xa0/0x580
>     [d0e7be60] [c02042c4] sys_ioctl+0x4e4/0xc90
>     [d0e7bee0] [c000dbac] system_call_exception+0xac/0x1f0
>     [d0e7bf00] [c00110e8] ret_from_syscall+0x0/0x28
>     --- interrupt: c00 at 0x2ad109c
>     NIP:  02ad109c LR: 02bc3958 CTR: c0249eb0
>     REGS: d0e7bf10 TRAP: 0c00   Tainted: G           O        (6.6.73)
>     MSR:  0002d002 <CE,EE,PR,ME>  CR: 88004400  XER: 20000000
> 
>     GPR00: 00000036 bf9d1c60 98425520 00000007 00008914 bf9d1ca0 00000002 bf9d1c98 
>     GPR08: 00000007 033b3d68 04e062c0 d0e7bf00 22002800 035012ac 00000000 04e04690 
>     GPR16: 00000000 00000000 00000000 bf9d2070 00000000 03493d36 04e04660 00000000 
>     GPR24: 00000000 bf9d1cf0 04e0af40 00000001 bf9d1ca0 00000007 02bc3958 00000000 
>     NIP [02ad109c] 0x2ad109c
>     LR [02bc3958] 0x2bc3958
>     --- interrupt: c00
>    Code: 4bfeee39 77e91000 40c200fc 77e92000 41c20018 813b0000 28090003 41c207fc 28090002 41c20834 833e001c 835c0140 <81390008> 2c1a0000 80690000 40c2031c
>     ---[ end trace 0000000000000000 ]---
> 
>     Kernel panic - not syncing: Fatal exception
>     ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> 
> Best regards
> Alexander Wilhelm

Unfortunately, I currently don’t have the device available to test ath12k on
big‑endian now. Nevertheless, I tried to reproduce the same issue on ath11k.
Interestingly, I don’t even reach the null pointer dereference step. Already
when starting the device, I get the following error message:

    user@host-A:~# ip link set wlan0 up
    RTNETLINK answers: Connection timed out

When I have access to the device again, I can investigate the null-pointer issue
in more detail. Until then, you have the logs above, maybe they already help.


Best regards
Alexander Wilhelm

