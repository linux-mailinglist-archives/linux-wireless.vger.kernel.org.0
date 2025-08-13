Return-Path: <linux-wireless+bounces-26352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B2B241F1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 08:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFD51893DC0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15A2D29DF;
	Wed, 13 Aug 2025 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ej+EBIMB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012068.outbound.protection.outlook.com [52.101.126.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB12C08CC;
	Wed, 13 Aug 2025 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067982; cv=fail; b=nUm8lzOCkZJjt240cY6MnGmnfALWI1oYYjs+GYsja4jtjS8YJONCMM1vl4twjRCNCJpuuFL5sheS15c9abrxsfWW6Jrx8M2iT8iGDo+4C6UXUyOl82De4eKj7GnXbjpRpWBZpfRBhqU/9PcvV/rnXND9sOMR1/1+DnSBGcFWZXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067982; c=relaxed/simple;
	bh=KDNf7ZbbfFT7ADTiUUtfDVlgINaGoEthMwyJNdzDuHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=akb3X22FQyhU1j+YziofUStu38mCmEj/os26GKhcJchm5ycQQHMbc56LAayDwIPDz8m/IT9V8FmnCxlR6YkDj0Sjcp1oZicIiFdZR6NhKFGbP5IylsLXO6IiW8Rp1I0DqxFIE5pJdQ4sbB4X83SGH2QD2bzDp5mq9nByTSExBlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ej+EBIMB; arc=fail smtp.client-ip=52.101.126.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTbs98nLdL/5WoZbi20w3RcaXrlwZ0o9lVa7XNvZh1SLOzA1xhPVyZCCDSCbGpCBed1DsviZs3NzjN9wZsTTqgMxwF/aXfwhZkKMETLMquNo2NG1t4gYZt2vfispRMJJKuFpEoeSWQVBGqh0l4bmSQHtB5D9QRUvz3lLqQ32VQzPOt6DZiTI+2PGILsCykWtpqvdLmvecYAzylCS+6WI0RN3PLUl5Xs60OBooJHcPJvTa0AizJFP7LDY/RgJd9Ojm0gy7TWVrauOG//8jpQTeL74bzJXAFCEM4cWdBYKhFIMS5oF+tEtRlFRWQbqITUAZfYnBHB71SLPcLqQt1DKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPhidvFK6cFhIn7hIA6TBv66cPxBACTo2TWFgzuRGSo=;
 b=ghoRRuxEjwc4CHVD5ELZWz6Pa8nC7MA9UZpTy4pBmTOmE0CyIuqgiOaIZhmC5RNdKWhf0fr0mY277yCtzzVpX/ab32Ou9ZLL6vF5e/GUntVCj7C/OwOxZGrsMPrzbBziJkMy8aoGzVnteLFYafdeZMro+BlY7GBDYpYoZYvRJpZ2pw6HKxrN85IgPcw4O4nF7/9ba2z4SCCqE4rZr3+7iTtbNH6ilyq9p5YnSWiz24+CzJa1Dsl1Cd6X85wXnCw+9sM5q5ngIWMUYk9SpC55hAEyqmjpEOTrQ6SfxVaWXhJOFlTYGOoIE6H8E2aPmfRqi/0E3xyI21thEAFQD4yYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPhidvFK6cFhIn7hIA6TBv66cPxBACTo2TWFgzuRGSo=;
 b=ej+EBIMBe80TJctswz1YKkjxFgQfTjDCp0hNgAi8VDEAdcr0w7WfThuYlg3hJ3r4J9dhgqwfB7Jn6p/YE/hdC0vvdwkTVV1lcvGsVyRX0hu4TKHrdhhJUTWgA7G0qPzP2ZIomb8qohefIiUFf/6f8GmVypmv/3DDQzjf8uMqY44x/mknXuQ8nYNStSNrOpX1+j9ecsjcgqt84hmWwp59gDEMmoeiQfHNg82Q4lSomyTYZthWh50fVNDnJPCU9DgVWFjYpiPYlhnWkZu+B5WRCWEufBzy2FcKOw1dgthEbaBRp0Zzr3nhfpSKwyzpkbuTsjHfuh5SrWreDwoBikn2PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYUPR06MB6080.apcprd06.prod.outlook.com (2603:1096:400:344::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Wed, 13 Aug 2025 06:52:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 06:52:55 +0000
Message-ID: <c330d0f3-d3cd-4981-8bb5-3ff5761647dc@vivo.com>
Date: Wed, 13 Aug 2025 14:52:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Johannes Berg <johannes.berg@intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 "open list:MARVELL MWIFIEX WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
 <e66eb22f-5565-4f33-b523-f93dc81a1210@vivo.com>
 <aJtQS-Tpzw90Hqtl@stanley.mountain>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aJtQS-Tpzw90Hqtl@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYUPR06MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: dc082e3a-ff46-4e51-8f49-08ddda360818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzd5MjdUbFlkUnV2U0dCZ1FLNEFoaTd6SXdIM2Q5N3BJdmNhaElxdDRWNkd2?=
 =?utf-8?B?NHZGTVlTWEJLc0RSKzBXaCtzVnpZMUFVL0YvV3Q5NjFYWVVoYU1UZTBiVVlx?=
 =?utf-8?B?RjJhRFJ1QlJsUUxETUlXc0Y4QXJnaFBwTFA5cU01WURqd09WdW9QcXpXSVZl?=
 =?utf-8?B?TUdZRDR1aEJyWW85UWN5eFAxMTdBWm45Y3BsaU5ZMU55RVB2NFVsN21iUzlM?=
 =?utf-8?B?RVZUWWF2QnNVUHJjSUxDMTVMU2R3YnM2cE5aWHVpNTdqcUxjNlZVOVUzYjhh?=
 =?utf-8?B?MVl6ZUJjM2NHaEo4M0R3U3JyNGlyUCs2SDhEZkErRkhBUVRyTk40ODh6dDlD?=
 =?utf-8?B?S1ArRks2LzRTNWhYdWtkUm5jZWxIaWFodHlYWS9yZC84d3YzQzEwdFFQWkM2?=
 =?utf-8?B?NjZUNmZSL3hGK0t6aFpRSnNOU202T1VYQ3l2b3hBeVdHSVpoai9iaHBwU3R1?=
 =?utf-8?B?NHBBVklRcU9tYWRpU1V1VFpxcEllbWlsU0F6TFJWbXY2Q3BiQTI0Y0djNzdk?=
 =?utf-8?B?RjFPNEgzWUtuZlZrK1F2TjJOd0p3YndDemVOblhpZzBLOUNHVWxPTHovQ2Vy?=
 =?utf-8?B?cVZjclFmWlFmdS96RTVNdUwwZ25JUCs2RkZIcUZxTDh3UDdvMThSelNaQzZE?=
 =?utf-8?B?Q0pHanhMVXp4OTZ5NHlUcVo4eVgvTXRSWVJDUkZkVDZFZ1ZCcGkxQnN2ems5?=
 =?utf-8?B?V3hVMm16dUt5bWxjL2ZQSnNXRUs0czVoNjJFTXI1bm1qbWtDVHhGaTN2bGdG?=
 =?utf-8?B?RWZsVmNENGRDN0VVM3Q0Z0FKZVFPREYvRVVsMDdudkhEWk9ldUtZWEt4SVVm?=
 =?utf-8?B?RWtuaDdkSjNRa1FFWWFGK3lGRWVSZWdCODAxL1YyeUlDblRpQXMydmpvdGVZ?=
 =?utf-8?B?UEhhZTBaZElFaGYweDFYbjFrKyszTzIyTUFkRjg4RzdNb1R2OU1EZy9CTFhM?=
 =?utf-8?B?RWI3UDdTb1ZFZ09jK2tEMnRKQzlKaVFnRHRkMHNYM3M5UUM2ckJjUzFmcDhK?=
 =?utf-8?B?QjVwQWVVU1EwQ0s4UU1yWm9DeFFJZXhPTVQ0bWl6dVN1dTBRNEMyaW1ySEd4?=
 =?utf-8?B?RWRRZXZjbElqV2lqQjFlTDhjRkc2YU9JM1I4WjhSUEFpNHh6RGo3UWdUcS9y?=
 =?utf-8?B?dmlTZXNEUExnMEU3QlR6UGo4L3QwcjVqVjNHcnd1WnhhR0g4T29CN3hieTA1?=
 =?utf-8?B?ZGNXazRxSkc3QnhJT1VxNW9RNVpDOGU2N2dETlhTdE5lMXRIS3VvSlRKNlg2?=
 =?utf-8?B?YjQ5SzJrMk1qblpmMTVhaGdsRkpLNGRJaXN5cmt2ZitNL0JHZ2F1akdlbEZU?=
 =?utf-8?B?WWRrWVgydnhsbE9DY2N3Y2pJcGJIbmliWHZJTisvTWhSZFZFM0pESjNXeGlV?=
 =?utf-8?B?dEpSOTNER0NrR2pjcUpkKyt6aHp6RlNQN0xZZHZIYzM0SS83QlB3Tm1tSGJ1?=
 =?utf-8?B?TGw3RGlaWUV3RnUzY1g0d3pXQmpRUUxVODd4M2lsMTZ6NWgrempUS3lsYWJu?=
 =?utf-8?B?WEMyaHM2SC93cDloTTNGaUNnaTV4UW94M0I5dDNoZUdxTStLNTJJcGdEaTN0?=
 =?utf-8?B?cXgyN1dacEtDTi92cThMZ2xEWnRQNFAvUnV1TGNoU2Y0UTJobTdKdlY1bi9Y?=
 =?utf-8?B?K0c1Q2tLUkFpRFYwakt4b1B4RHQrYVlUbWlrRXEwbDVISlFJZ01ySkdBM1Ns?=
 =?utf-8?B?Vk9LbFIySkR3N0svQnpjNGZoVnc0VXJ5ODdLZ2dvMER6Y1FFNlhraDhCYVd5?=
 =?utf-8?B?MENwT0J3V0c4ZzQvb0dROVhYSHJNTmdNNXpxeERzWW92VEcyUk5yN1BkMzNT?=
 =?utf-8?B?YzhZRXA5YVU4VXNJT0JLY3ZEdEx4bjRsVVVvR2UyUXprZThIcU1IMFJMVlFT?=
 =?utf-8?B?YjN6TW1zaFpJdlI3RVNLTnh4Yldrbkk4TE4zOHkrZ1hUdGxFR3ZXS0VBaWRV?=
 =?utf-8?Q?zjlSTJVXZPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE16NXpyaEoyblhDbVV0MXdYS0tzb3RwVUdHZkgrbkxSSVdYeTRkTkhtVWo0?=
 =?utf-8?B?TjFIRGdhUlJzUFhLb3lBY2M4bklKMFdCWkExazNWWlBEMjBhMjBiNGpwT2Vu?=
 =?utf-8?B?MHBYajh0SkdmMFBoR09Ca1AxTmxqbTNUcmxLQUZtcHlKSW1ocTBOc1RWVklj?=
 =?utf-8?B?RGNQbE1WelFHc204OERsMXZDcVROWm45YkVmVXBlUnIwcU1iUFcrZ0tZMXd1?=
 =?utf-8?B?Z1RuOXNaRjNzOU1yY3RoeGU0bVJHcGFCY3k5ZEp6R3RsZ0pWU2RIeXlmcStG?=
 =?utf-8?B?dWwxM2JkSVF5ek1rTHJsZHMzYm9PeVE3ZG1qZW1od3ZlV2FtU1dmclJRbkd6?=
 =?utf-8?B?cklYeC9DcDNLS2lsU3F1TExPT213NmpXeDF3b25tQVFIOW4zR0t4dGI1U0dE?=
 =?utf-8?B?TlRHdUNiVHpmSjJlUEkvRHJsdzlTMEwva1BhZUdPRTdWL0NDUHFtKzUvRGxr?=
 =?utf-8?B?Wjc5N09SS0NWUUxibUtLSWpJdGN3STJrbDkrNmJjS3VQQmR5QzMwckNPcG5W?=
 =?utf-8?B?M1diSVd6cWlETndoeXF1NkxGcUIwcjRpRGpxV0xicWIySlFyWGRjZzRraWhK?=
 =?utf-8?B?eE5DcUZMd1E1bkZVamJHZWhMVTdSNDUrd1RCekJMQ1J3bHVhemNQWWJjalVN?=
 =?utf-8?B?NjJRQkJCckF1QytFU0JTb1RoL2l1STRhSG91bmtTc2ViQXBjamV5dU1KSDBT?=
 =?utf-8?B?Z3lvZmNIQ0o1UldjQk1rM1NOSUNlY256YlhxQk9RQWFYcnlobFVFeXRoUFdC?=
 =?utf-8?B?UkdoeitBcms0bWhab0orVkJUT3lzNUNUTHEzOVZKSEQvNGJmcVY3SnRaZ2tZ?=
 =?utf-8?B?TmxKdlByZGdhejJMNmJEa1FCV0lqSmM2dWtjR2FlTXdlcmpFTGtFODBkbkgy?=
 =?utf-8?B?YUEzL3RzRDUxcW1FLzh2YzlGYkFBQWhUVVVHdjdRUGRJU3lhbkFSZmo1SU9P?=
 =?utf-8?B?c1dGT3NFZVpPWFJLUTRWRjZIR1N5SG01eWhEQmgzZnlPYi96MDdGN3ZRdnpy?=
 =?utf-8?B?WjI0VkYwUThQSE1SWnNrclZxTElNd0xwTTQ4M0dqSU9VZkc3QW5qWVh1SzRL?=
 =?utf-8?B?NDgyS1lVMEdELzR3N0hSL0pRellreFQrZFc0S3dTWWtUa2dNMytmazJsQ2xW?=
 =?utf-8?B?aytBQUNrWGx2Zlp1Q3JOZng4c2JKTUQySWlnZGlTMGRMbEsxbnU5UHNUdDRM?=
 =?utf-8?B?RkROUCtQRkI5OHQyb1I5VHFnWjh4SDFjZENpNjZqbmd1ejkwL2xDMUpuUzd3?=
 =?utf-8?B?MjRjRXYyTEE0OTlDamhPeE9vNHU3Uy9OL3VMRTUwSzZuazhIaFhtN25zdWFQ?=
 =?utf-8?B?N1dqTlJZNy96Y29NYnE0VUtlN2hLWWZYU3BNd202TFlIbnRseE91WFFIb2c5?=
 =?utf-8?B?bWlMcVIxNlNYbTlOT1AwZFUvZXg1K3gyTDgrNU0zNkd5WWNRTUQ2cDNNY0dh?=
 =?utf-8?B?Z2p5OVBPd3JubXkrWUpnRWpYMm1KRC9SL0tVdUNBck1VSnQ1Rml1SVhnRms1?=
 =?utf-8?B?L1dNVjBpaXc4TWwyNVFFaVFmMVkyWEczZTVlRnpOR05FV25VenpGZTBsRldK?=
 =?utf-8?B?bllObmhMcWpEZm4wblRKS2gwdzVYWTUyOTZrUGt3NUVDemZaMzd0R0VQdmN4?=
 =?utf-8?B?aUFYaXc0S2k0SUQrVk13dE1nVzd1UFBiVzVPc2trdkxjTFVWM2ZkUHY5bllY?=
 =?utf-8?B?OTg3K1E2NlNkV2dFRGZCaE5OeU9NYTRDd1I3b1lIZ1JwSlJwTlpxUU5pTjY0?=
 =?utf-8?B?bWgwTjAxRUVydVFVSzVXdUp1WjRqdGtoRHVZbi9kZXBORUZ1MktseFVlVHdj?=
 =?utf-8?B?SjNhRU9Ja0t1UFdtKytTQzlBY05URDVzME9UOXlPWWdBa2Q1L1p6bldlSFVH?=
 =?utf-8?B?Y3B0dDYwblB0bmhnbmtETCtQU2Y0bkY5bVdlSUlsZ0EzaGhmM1VBSEUrZUMw?=
 =?utf-8?B?SUxydHNBVjNZTDVMYk9CdlBHK3pzeFV0ZEVEaWtidmdVU2Z1SnRvSUFLN2dS?=
 =?utf-8?B?bjRIdGxkNU5KVWlGdVQvTlJvR2VENzh0emZMNVYrTnF4bDVlNnkxZWJTZEpY?=
 =?utf-8?B?WlRMQWFmWCs4aXp5aWN3UFY2YnBWTVJ4Q3VFLzFWN1UrbWRuQTFXNU1rRkgz?=
 =?utf-8?Q?CjxNv/9dl95ITF1Z7Uk19wRZN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc082e3a-ff46-4e51-8f49-08ddda360818
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:52:55.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbASnqMTr0fYXUTUZRbb+8o0+77tC34y8jtnjyiWrGfA/FB9/1evfhjWEsmWVZ4juRmcVXwWSLucNzTpteZDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6080


在 2025/8/12 22:31, Dan Carpenter 写道:
> On Tue, Aug 12, 2025 at 10:13:43PM +0800, Qianfeng Rong wrote:
>> 在 2025/8/12 21:48, Dan Carpenter 写道:
>>> On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
>>>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>>>> simplify the code.
>>>>
>>>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>>>> ---
>>>>    drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>>>> index 3498743d5ec0..fb4183ff02a9 100644
>>>> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>>>> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>>>> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
>>>>    	 * additional active scan request for hidden SSIDs on passive channels.
>>>>    	 */
>>>>    	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
>>>> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
>>>> -						 adapter->num_in_chan_stats));
>>>> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
>>>> +					    sizeof(*adapter->chan_stats));
>>> n_channels_bg is 14
>>> n_channels_a is either 0 or 31 depending on if we're using BAND_A.
>>> sizeof(*adapter->chan_stats) is 10.
>>>
>>> So we're either allocating 280 or 900 bytes, which is quite small.  We
>>> should just use kmalloc_array() instead of vmalloc_array().
>> Switching to kmalloc_array() requires changing vfree() to kfree(),
>> but I couldn't locate the memory release code.
> It's not hard to locate with a bit of looking.  ;)
Yes, I did find it. ;)
>>    This modification
>> likely requires deep familiarity with the codebase.  Also, for
>> variable-sized allocations, kvmalloc_array() is preferable, but
>> requires kvfree() for proper memory release.
> Don't use kvmalloc_array().  The rules are:
> 1) small amounts of memory: kmalloc()
> 2) possibly large ammounts of memory up to 2GB: kvmalloc()
> 3) definitely large ammounts of memory or larger than 2GB: vmalloc()
Allocations under 8 pages should use kmalloc() for efficiency.  For
allocations exceeding 8 pages, kvmalloc() or vmalloc() is preferable
(of course, non-contiguous physical memory can be used) since
kernel memory management defines PAGE_ALLOC_COSTLY_ORDER = 3
(indicating 8 pages), beyond which contiguous physical memory
allocation becomes unreliable and costly.
>
> There are also places where the memory needs to be contiguous and for
> those situations kvmalloc() and vmalloc() can't be used.
>
> Here we're allocating less than a PAGE so the appropriate thing is
> kmalloc_array().
>
> I'm looking at this some more and these statistics are updated in
> mwifiex_update_chan_statistics() and not necessarily all of them
> are updated.  But they're used in mwifiex_cfg80211_dump_survey()
> when potentially the memory is still uninitialized.
>
> I really think we should zero this memory, so lets allocate it
> with kcalloc().
I agree with you, I will try to do this in the next version.
>
> regards,
> dan carpenter
>

