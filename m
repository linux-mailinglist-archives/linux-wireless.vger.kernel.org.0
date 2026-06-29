Return-Path: <linux-wireless+bounces-38269-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wczIFnMrQmoj1QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38269-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:23:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8E6D7774
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=sciVKg8B;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=gFhXT4DI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38269-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38269-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C500300F9F7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3CD3E5EF6;
	Mon, 29 Jun 2026 08:12:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F853EB0F5;
	Mon, 29 Jun 2026 08:12:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720745; cv=fail; b=XdLd9jKyF0cU9AL6m2xB8BBuyNnYU0SCsBVqeeGzpdPhQ0juG0u9ytpWiCJHw3gEBMRhjIrZKZZUUUEYxFK5qVmuGu2HZsVyAXZHK7wwlezBA1ePDl1sKKaA6da6vW8k2JvCnOxJlYr+VYi0uw+exZbDnYrg4j6SWEtRzLmDNrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720745; c=relaxed/simple;
	bh=VRTAtJEVQeCvBV7SFcJ/Ah+mBcxvxUkTIxlTHVKHPCM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=XzzvzYcxNPCWGgo+DygCnyOTT6cfvHdmWH8Lr+bdmiDwVc3qi1eATKkDYh3AcQbzlBycvvoTqQOBjq0EntSr9JnCJyF2tyvvCBFXD6TL0KDjUFjpcibKUbSlmu8f4eA+h+tOfAmMErqkAcXwzPSZ6oCQwwEndVUGK2PzTg6Lo0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=sciVKg8B; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=gFhXT4DI; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6lEJa1652265;
	Mon, 29 Jun 2026 09:47:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=4dD+etMu7/ptF3iZpItfWS
	UeToV3J4b2XlvRBfOAiwA=; b=sciVKg8BkVQ1+cWu+BasbUpUr7LOPPDw+06fcf
	F439JSCNcYbtIiNK7Ry7VqbYR1j2lzzC79vR5H0yp7eMvybaSHaWC6TsSmAz5SXm
	MHYPF3IvlcSMWaRDXqbR6t7jJ/KSw1hTQyF60DttZRcYbuL2iRU5RuJsTpaCWiJm
	8rS31sTs/JunD8CsB8AZOL/Uwfm0mBnWLYPRYzyQDB66nhSDN3kRTJGFtF+CASBf
	gP7GBgYoYdggZ31rhXrQpWVyt2inoLEdgE+6iHWsj3MaiuSgpj8aQkSlEPLvQImZ
	0h0849+N+qTD/i2pA9Uh6qT/IEIpGiUaIuZFZ0XKjgkalBLA==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023086.outbound.protection.outlook.com [52.101.83.86])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22v9acmy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:47:04 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPQz4dzTk+ytOYncoiwYs8JcDkB6K124oZyANS5IU7dpA38rXcNl/qtoBBN18I+801zG/L3E8oOiPywc60T1STWdmjtWxll4I17dymb+muSjypedWlcacE5mASuPD45pwNkSDyCDqPSSItAE8B6BJF39ww7q45xGR8oUMvnv/5mzE/si26iG+mOyT/pWBg+6ap6oYgXO/U0v+qpeFyjVX+mKgfSBW/IhlmdO0GEyW3dZUayEB6wau+Pm4Tr+rF8erkN/E5soZLDPrFK7t/cjQrQql81kEUSB7B1jor9Xtbn+DWeNGM0hF8sls+J5XdMVHFH9s1maqrdKqHtcnAJQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dD+etMu7/ptF3iZpItfWSUeToV3J4b2XlvRBfOAiwA=;
 b=PL8x+mhY7sVCOUi30t47+VCsi5nGwYp+T0r4mv+PgLJXqfB0OwU6pqoiCMJ7iF5KWQjX37oGM1hMni/FnOsSQAepJUYGb76YZY8h4FjSAPDRazA5OcoGK4WfVRPVGK9XivReXvOYFoPL0sTRXi1a4AF6+2L7GAQqG1LGziKrvAOOPxJx5+yF4Gk2Y4XLZCDaZbQeexXYNqyTP7vlz6oMKw37T56k7OcTQiFg63TY5WbLMPSvgUvUh3eMNKm4oS+LmRcjABhjiFmMkRcZiiruQ7tnYGCOUsYDmmHelnTawpgyxYHsBhoehbTFh1amgYxEagSkMhXlAmSaiqisZQRlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dD+etMu7/ptF3iZpItfWSUeToV3J4b2XlvRBfOAiwA=;
 b=gFhXT4DImGFiEC5CzbmhW32Vi+OljB/razn1sqO/v2NNXOr69TbykU/ub24/K3yUxpZULGgmGizm0FH4FVqBPw76POm+dEZ+8u0tPR7/Mc6C75uLETFySeCDnGaUkuwfaqB4H8tXw83Ogh3CGrzu+qcF9157qDkyXw1z6VYsrrU=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by GV4P192MB3168.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Mon, 29 Jun
 2026 07:47:02 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:47:02 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Mon, 29 Jun 2026 09:46:53 +0200
Subject: [PATCH RESEND] wifi: ath12k: fix channel list copy on big endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
X-B4-Tracking: v=1; b=H4sIAOwiQmoC/4WNvQ6CMBSFX4Xc2Wu41WLi5ACrg46GAcutNIGWt
 AQlpO9u5QUcz/nOzwqBveEA52wFz7MJxtkkaJeB6hr7YjRt0iByUeQHOqE2H/wRyz32Jkyo3Li
 gYi1V04qjfhaQuqPnFNx2H3Cr7tW1hDr5XWo4v2x3M230z/JMSCiZWDZMSrby8uYwsR/cXrkB6
 hjjFyHwy1DFAAAA
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3PEPF0001DBC8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ba) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|GV4P192MB3168:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fb037c-db1e-43fb-7596-08ded5b29b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	610umX0hSIJ6X9utgoFBllxUOgkHCGIW8fssKFrVWyxBd6VexC/8zpEHfpAEoq77eZub34y5hC09h/hPokU/jYADFkkp3opLeALSxsbP1z89F2SYc4oRqROIt9+rQ97/ZzP9x4muVMn/LOXf/5Nq5lTzMN+LGIflMR4yRZ+Yrv18pA/PiJLb25UyVdXTEjS9vYQ/D2RJCZlp/c+Mbpx7WJpdLPizhJu8y0VfdJEOtzDRw5QsX4LecN6pmklvQHNP6Vw7bjO834uTeWRavGduk2oAZCF8puB27iMgKhlFtRmQYYXNeh6sHnSilOdACfe4x3u63tteog/sRI0+TSW5gH9wJPUQ5P4zRblFNImoFwZN/xEuhx5MrmZb3YGxaPCnGbRRVNRpLfec70ECgtZ2NfuEcTpWuRe7rVppMmdX89/NHKc76QzaMKxwv7s14qDbwv53VByLLd7vdhC49ufM/53wZUl98oQBTRyTT6c7fv5A9Jam/uT9D1/QZHeOhMAfTrKkBpg9VqAOmpp8Qy/ZudYEWJeMYUgLxc9ci39f/KlRZDlvNk8tkLqRPm1h9t3SXt5vPcpg96ZWG0+fbdGDtu+UgkXdtNwNcff75gOOyFbs3/kY91gRJx2DnWdQe50KlrYXUro0WtaMFylhcryty4YkJkiK+kVBR1Xa28V6Y6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVRtYmhIcmt2amRJVjB0MEJiMjZVbnZISjBqU0tkWitJb1FvUEpWVThkMXhz?=
 =?utf-8?B?ZmZFZjBKNFd5dXNueU9ZV2ZZYkdRVmx2YVpuWGsvTXBkWkNLcnpsaTFhckND?=
 =?utf-8?B?blF1MFk0RkdLV2V4M25TWjY1cWg4TWxsTWRXYlNPTGs1aUxSRmNlUmhxcDV2?=
 =?utf-8?B?WkV0OE00T21JZmxGOGxHVHdpMy9DeU94eW9RNW9PTzlFK3ZpNUQ4QlExRk41?=
 =?utf-8?B?aEpVQ2pJeDNpUkFoMm5NVFBUOGZxOVVROUVENVh1RzQ4bEJpZ0xtWnJZTkY3?=
 =?utf-8?B?WEVaaGdzU1V5RnFOM3N2eUN3amZ5Qm1ZTlZqN0tEUVpSVmphYkZBc2g0OHlF?=
 =?utf-8?B?VXZLSmtXb3c2a3BQNHJFSlhrZFhYNmlMcDJxdFBwcUNkc3pncFdiRzlkU3Zj?=
 =?utf-8?B?TUhNTmI5TlZ0dmJRQjhwb0w5SzRENk9qaEtYaWtVSCtjd1dzYmZvall3YklW?=
 =?utf-8?B?dWZiNXdtT3BmTWZUV3pNTmhUdGVyQU50Ry9LM0VDcXY1R05Yd1BaeGx1dEwr?=
 =?utf-8?B?ODMyYmF4andSRSs0aURuYzBJNXR4LzBTaVF0Vk4yYUtQMEZIWENHOGhWdlI3?=
 =?utf-8?B?eVpTMldPMFhnSmIvRzRuYjZ0OVZlSlA2djNCbDRjc2ZNQm1LV3RYdzJTZDZ1?=
 =?utf-8?B?L2w3cVpNK2l3MGpscldmUFRwWkpMZXlZZWRmTk56ay9BcXBvQzNTUVZTbGVp?=
 =?utf-8?B?anpua3MrR0l5RU5SaFp3aXc5eFppaTBuRENGT1lQQWRMTk1IVFhFaHJETFNL?=
 =?utf-8?B?YW1IYlhYODRBVU5wTmxETlNHU29Tc0xSbnB4NzE0RC9kM2IwZWd4YU9JTWNX?=
 =?utf-8?B?YmQvbkRJNGlzYnpPaWt3dkFJbVRpdVBWd2RCWU9Kc2JjTGw2ZUk1d05IbFBt?=
 =?utf-8?B?NThxM1l5Vitqeis2RFVjcEI0VUFxNTJoTjFiSXNxRW5wM29jZnMwQ2J4UDVV?=
 =?utf-8?B?TnlmNTE0SU1BL3Zvd1RxcHZPd0RiQmRNYzVnSFN1bDFxY3d2RGRiTGJpbFY2?=
 =?utf-8?B?UUFNTUJ2VEk2MWQ2YTlnY0tDSTJFVWs0QVNBZkxJZVZaOHlQS2RLaG95dGdq?=
 =?utf-8?B?eHc5VndpbWJNeElBMEVQS1dKUlZnWGRyZnJQd1Rhdm5BREF0SHo2NkJrY2lC?=
 =?utf-8?B?N3NoaEZZOW1jSG1xQk5xQVZ1MXc3SGNURWlpYm9yb2c3cDhRcDNDcXE1ai9N?=
 =?utf-8?B?VmJqOW5USG5uZHhDdTVZWU1ZS3FkaERENE5UaEpXaTZKWi83eHZPemFsZFhj?=
 =?utf-8?B?UDdsUE9vdyt3VlZ1alN6NDQwQ0dUdGdwcUtPTHp1REhwaWZUZjBiREZlamdR?=
 =?utf-8?B?K2xiTXJBOEZGb2dqU094TTZKc0dPTmZaaWlWSDBsdmxoM0xRWm1LeGxKSUdw?=
 =?utf-8?B?MHNtN3VQMUxxOWlJUFRwbVF3SVdEN1lGTjFCVzh1MERLRWt6akFkREYyVkNa?=
 =?utf-8?B?QlpUNVd5YWhXRUVnYzFZQ0RKOG0xOWJhdWdTM3lpWS9SQ3k2Y3JjcURXbS9x?=
 =?utf-8?B?TjhxRVNGREcrUlBVcDkrWlA4emN5Vng5bEhFZ3dzNGc1RytFRk1HUzBtbGtw?=
 =?utf-8?B?a3dTZ1Rzc2N5Und0U2xHcStyMTdXcllkYm81d2xMR1NsdUNwLzJRZStHemt5?=
 =?utf-8?B?eTR5VFhiR0M3Y21FbUh6LzdUdFlVMko3NDIxaWVzSzB0dFp5aVcyeWdVRGtL?=
 =?utf-8?B?NG5POFBvQ3NqK0h4RGxLRDY1anp2aWtsTG4ycklJQjZUYlFFa2JETUM4QTZL?=
 =?utf-8?B?eUNVQXZ5ZC91MFNLTWlSNWtmTXlWVmRjblhKSy9mcEZIV0E0c1VvZ1h2TzBT?=
 =?utf-8?B?TFJPWTFpdnNTNDgvQzlxMTFpRUwybGlWcjd1UmN5enE3SGxHczlZd0lnUlhs?=
 =?utf-8?B?U0ROSU14bThFMVBPc3lQSXp0amlNeGo1R1EwMmJEZ1llSlFULzBWdTdycEJF?=
 =?utf-8?B?SDFXL3NaMHg0Y2xzZDdWdnora3hvVTQ5YUdxZVJUSnNRNnVVR3EySTFTd011?=
 =?utf-8?B?VTdkdUcrMnJuc1N5RnEwMGViT2lYc0R4L2ZVdUQ2TGppbGttdk5HcUw2WFlh?=
 =?utf-8?B?Sk1oSE1HV2FrcEJSdURoTTlCRlJNQldmR0VuLzBRR2JkeUdpckRGYVErR0hQ?=
 =?utf-8?B?Y3ZJTzV1Z0pLbFFmdzhOeWJLVVBSUVZhSHlCcVM2RjYybFV5SlVFR2p5bVFp?=
 =?utf-8?B?a1NHM2hBMkVuTWFxNkVKcVVrdGM2OW1wU2NYNURuWDhPdXI1MkhsS0R2MDF5?=
 =?utf-8?B?cnNzaTZVYXZYZGRzNDZaY1BOR3gxUFFVdEE5eTdWSjVCUkROOGdwUkg4UXNn?=
 =?utf-8?B?eTZFOThLZmp2eVJadVVHMmJtTGQ1d05TL3FCQVRTNmJ2VlhCdWN1Zz09?=
X-Exchange-RoutingPolicyChecked:
	FW+54jl3Htzgm4a505LZBXxN3sWyDZdrAPH5y2m/swPztfHX5oU+yiRk2du6mU29Fr2d8v1hufkDN9WhY6J9gaeKy7X+EiWmLhBOQwZgx4kcXtJO664coP9J8TAbr4UMFlGA7KLU8JS5jFO5qCOCwHmk8KapXMNnfW/ctnVPPQauHJg94Hj2LQyXYWg21utuVe0YFKng1OHiiK+BGyBOF+UxcWIZHJf4M/I2peFvO0FbueD72jMS9H3NXr7EkJQXqFryRTGSgrqVB5fA1dMEcEKMJY9EfuFKkysgfSbBQhlzeS0E1p7MxAiGMe1V/xOB59iy+IfIZMt43Pb2+dlwCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XHzBf4LdQmv1hWndtYqw7lr/2UKmR0mOVrkee0zWpbRzi/Uyx+bOUKha5D5RWfb1i+go4ZsRZatephz7wtzGtYv7iymz8sZl6kBOxUgdNa/fQFdAcpRig+DZwgJGc4c2PWhACpEY2ni0KzasTTxctgPuM8drzv30P12ZTVnUGo/4v/Yi1pj2fEak7l/5SfZJEiT+bid93TsgbtgpKStmiSJe/z9+Y2YHKaDg4/A6ycppMo+31K2XF8gtx3wHvQWcYyNNTL7XEEJKQ7W29VoHCU+73wFVxI54FLYSmr2BOVyVP2EroTGtLX+F3FebShAgCAtSrGDZnsF1ocVX6JVgPB6znJSKmJxGBcu7Dwb3GBNvifF+KTGsnqzrzdp89kIjx+wdHFjuLkvu/XLiTJ9JX81r7VHTr7PR7tphaVjqArD1y79wrqrdvBej9KwkK1mosOr8KZW5b6rMmBBVWpjKH5KzkaVIthOLsRifJUhZhe5MOjKFjHbfYdlK7DXKtmIchHraqgBYDnW9xU/G/E/rRG8UmE0rhh/Vp2BRbv8oMphXZ0cqHyDY7UcTD8J/elpOUPhzbTv2bX1bYhJZgHDvJzI4g12J/mNt8i7Rx2a3rHG8soHYEKat4aLSplyPxlbY
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fb037c-db1e-43fb-7596-08ded5b29b79
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:47:02.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MweZUg8xETGHGG4FEdVBysLvq6U5RyqvoN8Vq2QGY2KkDv2X3fwrElq1XMqEI5lurO3Q6t7fA5hfsg8AqWEovQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P192MB3168
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
X-OrganizationHeadersPreserved: GV4P192MB3168.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX59ofqIkPMrDn
 pQVPnCTKuLtikmNUZVyK0mkBbYy04ArJ+SuBvQFxz22wmAg9oQ8TrLuCvK9QkYjsOMrK+NjbxA9
 JDSqUQnfOlZGxlXQEmFUAcqmncOo5N9HWLZ6LEQOAkahLOJmHGfmGeQA14/7eg2tsLb1ZXJLSY0
 KVFLmPFNC0lXsPtNOX1YJpHjdpPM6HbNFkgyD3s6kxocfwb0mxuB4vpBA3e+n4VLLXa830M49xG
 47OojIaP3ERtQJxgdRBsIkVugVxsdvZwqswh0FSp6RcZjFMgewrT76Tz4kEaLYxYNqCVpTuKymA
 tu2396TJSXXV470iiGsJBJeMMyISgESzexopKFrEya6gQ0qMk1ToHhNxHeqv5UaNmSSKOrKyUmJ
 U6tSm86GyO7E1sQXTxcobSZSQ11YzoqMO5aoP1NTKgzXFu+HbPxSnKcgDUs0g2hGKFW4z4hwsvt
 QRNoCRo4uKDTPlZW1vA==
X-Proofpoint-ORIG-GUID: rPurmBVjrZ5lfJIhvhrWnQPcS6p6jp_2
X-Proofpoint-GUID: rPurmBVjrZ5lfJIhvhrWnQPcS6p6jp_2
X-Authority-Analysis: v=2.4 cv=ZNznX37b c=1 sm=1 tr=0 ts=6a4222f8 cx=c_pps
 a=NDlXlHM6WrayTpZMBqf2Ew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfXyQlYiu1LdoHI
 LjC9GYsmB8cuBZqutIET7QIQIN1PQNawPqKwcP28ReJYd7/LpikkDyu9WZHd0kLAOxzBCi5OWSL
 S68TUaoC9cvW8ieIEgMTjrXJjUWHjjo=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38269-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:dkim,westermo.com:email,westermo.com:mid,westermo.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6B8E6D7774

The ath12k_wmi_scan_req_arg structure defines the channel list in
CPU-native order, while wmi_start_scan_cmd expects the values in
little-endian format. The simple memcpy causes the hardware scan to fail on
big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
values to support both architectures correctly.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..9e1d3c662852 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	struct wmi_tlv *tlv;
 	void *ptr;
 	int i, ret, len;
-	u32 *tmp_ptr, extraie_len_with_pad = 0;
+	__le32 *tmp_ptr;
+	u32 extraie_len_with_pad = 0;
 	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
 	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
 
@@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	tlv = ptr;
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
 	ptr += TLV_HDR_SIZE;
-	tmp_ptr = (u32 *)ptr;
+	tmp_ptr = (__le32 *)ptr;
 
-	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
+	for (i = 0; i < arg->num_chan; i++)
+		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
 
 	ptr += len;
 

---
base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
change-id: 20260317-fix-channel-list-copy-cef5cad24fb6

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


