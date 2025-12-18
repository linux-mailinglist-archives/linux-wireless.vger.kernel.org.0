Return-Path: <linux-wireless+bounces-29899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2764CCC050
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284813018F75
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F630C37A;
	Thu, 18 Dec 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="meESEUhF";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="skqGEQmk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EB331A57
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064528; cv=fail; b=EDRpFv3Tzgt0+F7PDN812MlKWjW7L7L5sIQ3VfkmjCtk7QFBrzitLHKp0g3Bc3WzrmoiXXEU4OvQI0NbITUJFY1pjn1X0HO13PKFnwp6vZHO34zXYBhigRnCgZYlKNVJeCogkCAWQ/MsRfNAb1bMsgswSyZclUFmVuhTqeNTKVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064528; c=relaxed/simple;
	bh=AXMJeo7o/eqnE8G8YgobRQ0/uKCLRwk5+hSB7WpCPWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WFuq/veT3Ds4oZ+g/eBnYZyQvVXE82EesMrryvbgEg3hPceIhlwEWK+a/pNm9Kssl38AGId2emIW1hL6cIbFYTlIPg21MvHVh3++wXxuQA0IMYRehQR4R6CxY+UjB60RSEHPSesR4lLX+OnVgDOD6g8co18AhYZc4g3TPoucBYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=meESEUhF; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=skqGEQmk; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI5tBUx863328;
	Thu, 18 Dec 2025 14:02:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	M+lPqTfavUsAAE5DQrbpUSCMFE5YcWfjE69dgzjpabs=; b=meESEUhF3E7AMUb9
	uAaSG4ch1jSU+rUARaEN+2Dg6WBOsCQmh8gq2SV0ES9fZSKeNjDo4YIosNHMKeAN
	Fa8gqdutD4qfFpUWQHznAVnTHu0l17hUqVM7ad3H9xT0R7PniwG/dSc/HWOM0FUj
	p4HqjlEkMN+VrLm5+w34gnm6pL5VfUFPBDNmylLgbQNLR0DuHkuCPFMJR99d2SIL
	d+cUaDYFQh0642bJyAepQnX0g7rBP7VkQss7g4ezdzr600IOsH71f7lpiyXEnxEM
	swuQwW4ooxblN79R4RXH7fV6+QrANgIPtjII93AIm6Egeuj0pj5qeoSLD/LYF26v
	2gOwdQ==
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11021092.outbound.protection.outlook.com [52.101.70.92])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4b41nc0p9c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:02:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XucEhvr9bwU56ZNIc/bf1vcQYrn3zoXaeCXKdvfOYXc0L1JJgG/gRddnJBl32zABZQTlNsFxSpSjBmrI/hRoZZkhBYErokvFA4y/3ID6jvULEHLPNwB2wc8aTXDLLtFoE7m/FbjT5bGNzzZrwsGOWkkDX9op7U6UpidA3RZxcStRpO7MSJ0UNiUd5s2S6Z8DTvW4XnuaHIwPex1C1BMxSCydeTJ+mPqEDUY5WmhG1aFTC2bMgISs15HlygIc+xU+oK3DXm2qyTpuJf0Y5ckF7R/ob701hP8iiUjb2OUGrw3Nw0XTb2azXDh0/mAorTvZBSY5iva/y1G2NRQm98wvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+lPqTfavUsAAE5DQrbpUSCMFE5YcWfjE69dgzjpabs=;
 b=rbbBq0klwyxHydeDPpVBrJrOpnhOoMhZ0sm1szjFIrxvknQkADQQRa5AC+jIwTdnQKNpnVBvfaFTD4StpSSmX2LrqAl/9s2zAr6xE2FCDmutmhRBu57Pd8UC0S16YKGw8eyyzs757w/RY8NsbefuRfVvYUlfAzGXkqDNgWQdl6XpFuO61sEVrJPFueESF3644/tT0p1e2KeWsfg7RJUvpnh5OsWWzDLu+AJ2YBl///LmAT1SD7j8pTARPIuHxv8FPpITSuwkhG2edvxNEIcHRAf3F9s35iudv4Mjgc8aice2WNXQROLBzHI7rrf9wpKgXdporF3n2l5lFApw88eUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+lPqTfavUsAAE5DQrbpUSCMFE5YcWfjE69dgzjpabs=;
 b=skqGEQmkGN8txw8kkB6OLW+MdKekpQTh/GcRYuVPn6XM8oOGutR9GJBO+lPqzwVuMn24h19ribUiRN0Fhq4ye8pzIAARJKYJ9/lyI13v9US5KlsfaVMyxx8FoUYPrLwhwCJDkXP3UnbOtO0V+cS5quWZnqJL/qzU9eQLZlVFFH4=
Received: from DB9P192MB3278.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5f5::11)
 by AM6P192MB2790.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:6bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 13:02:02 +0000
Received: from DB9P192MB3278.EURP192.PROD.OUTLOOK.COM
 ([fe80::7d4c:626:534f:2037]) by DB9P192MB3278.EURP192.PROD.OUTLOOK.COM
 ([fe80::7d4c:626:534f:2037%7]) with mapi id 15.20.9412.011; Thu, 18 Dec 2025
 13:02:01 +0000
Message-ID: <419f63fc-fc39-48f6-82b4-239e5d8af9e6@westermo.com>
Date: Thu, 18 Dec 2025 14:02:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath9k: fix: avoid updating TXDP while EDMA queue is
 active
To: linux-wireless@vger.kernel.org
Cc: toke@toke.dk, adrian@freebsd.org, qca-developer-program@qualcomm.com,
        Zefir Kurtisi <zefir.kurtisi@westermo.com>,
        Felix Fietkau <nbd@nbd.name>
References: <20251217182629.1144973-1-zefir.kurtisi@gmail.com>
Content-Language: en-US
From: Zefir Kurtisi <zefku@westermo.com>
In-Reply-To: <20251217182629.1144973-1-zefir.kurtisi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::12) To DB9P192MB3278.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5f5::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3278:EE_|AM6P192MB2790:EE_
X-MS-Office365-Filtering-Correlation-Id: a456dd93-8a8b-4a37-8bab-08de3e35a2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3pOeEpYRklCejFjNG5ZNC9nb1BtazJIbHg0alJiVmtCQWVLYnRFOHd4U2RN?=
 =?utf-8?B?c080VUIvNWtkZVdUTnE2RlZjdjFxUGgrRWR5ODdZWHEzcVhOcnhwa3hyOUFo?=
 =?utf-8?B?a3RVSkczSGNHSjVWei9aZzRaRkdlWjM0bEI2elFHR2JyMWVQL04zTnBMVkNn?=
 =?utf-8?B?dGU4Q2pYMks1N1hGMW1rSDZwZDVmbGFQU21pU2poZEZQTk1qSFovS3VKOGFR?=
 =?utf-8?B?clFNRzNQdE1tenIvVnpZeENLamhUZmFMMktWYWp4YUhsVjlib1IzMTJ2Y2l1?=
 =?utf-8?B?ZURaN0V0VUJZVXpueFp3UDBoVGNsQi9xNFo4M2VLczRHbVBWZVlaOFJENklL?=
 =?utf-8?B?R3IyUi9Id1JTclRlNVhNemNOcFFJRnk0ZDAvK1JCRDJkd3duSjVjY053d0s3?=
 =?utf-8?B?ZGRaN2R2R3NYRlpuRi9TYkJPeW5FRm91c1BIcVJuOXJaMHYzVjJ3eGwvSjBV?=
 =?utf-8?B?MmpKNFkyb2JtcCtJODJrN1lqQW84WlNlVHhmNEhpdkVHZE0rbG9aQ1pWcVow?=
 =?utf-8?B?M2l6VUhkY3lPcS9zMkZKQTcrSmk3K21YYWpabVB4RGpRVHVzcmFwcnl4SFp6?=
 =?utf-8?B?SW1RWHkxOXJpZTMvZWVOSnVtVWdzYnZPcG0zR0lxZThQTWVNMys4Z2o2TUl2?=
 =?utf-8?B?SXBMbTlHMUdBK0xjUG9aNjJuWnl6bk5WenFBdTkrMTFUVHBzYllidHN3UmRz?=
 =?utf-8?B?c3lkNFZna1VldjZqbG5XUXhjbis4ZUJ6ZThRWmV5bXNXeEd4blVBcVN1dTlN?=
 =?utf-8?B?Vm5OaVJWek1kTzFvVERXMUVWZ3BDVzMvQldLQ01aM1I1QUVOaklWMnN3RWV2?=
 =?utf-8?B?K2Vvam1jSlRjMlZ4SHhxNjhoNnZUaVpVVmxhZWZpa0IxRFJHTXgreWVXM3pu?=
 =?utf-8?B?M2FDbkkxQWtweXJkOVBnaTA3eXl1QXg5anVpSzF6b3I3M1NvSkJBM0VsSi9S?=
 =?utf-8?B?VmtDZ2JoU3ZjM2t4SG1NdnNFMlYzMlAvTkFaWUJQaDZnNk5ldk1MVnF6U1BO?=
 =?utf-8?B?blNVMnRLSSt2NlNyamVZdHI4bXpKeEwvTHdrQjZSK0xjMDlNUmJjTGFTN3J0?=
 =?utf-8?B?cVF2MW5UVUxCcmFReHNxWTdPcVV1dW9oMlN5UnUrcEdPQ2xnNDFYcTU3R1VY?=
 =?utf-8?B?c1pNbU55TzN3ekJISWRNN0hsZ2VqSG51M1BsMW41Y3dxZXd1TXVUbGx2c0E5?=
 =?utf-8?B?bTloWm04bzd5bXBnazB6OUdRNlNYY2FQL2dqTlRzcDZ4QTRwcmp6OFo1dkMr?=
 =?utf-8?B?di9BN1crV1dVcjFKaWhGLzA2NWR5d1ZseWJGNzBMbnhNRU42enRPL1haa0U2?=
 =?utf-8?B?Vk5wWGtzWkV2Um4wRkNJeVkzdUxueXZZbElKUzFPakp3WitUOWtGQ01pTVR6?=
 =?utf-8?B?eWgwYld3VU96Rmg4ZmQrdDlyV0Z5dnVFdWtOdjBNaVpvSUlVM1RzaHN2bTJn?=
 =?utf-8?B?STNPMFhjbUVoSFlRNS9VbHM4OVZ0RlJOalpBeVVYNW96Wlcxb0RXVTFFWTV4?=
 =?utf-8?B?MS9OOWM1TWhWL3YrMnpYMHVqZlFOUUpGeHBYZ2c4WTkzWVBjd2N1dFdQWTVa?=
 =?utf-8?B?Z3lGcURid3V5WlU1RWRtay9kYy84b2I4YmhhKzJabnRRM1ZMUWdqdHB0Rk1k?=
 =?utf-8?B?MXE2SlZxaU1KdytKNDhENzNscGgxaGhzTVoybVE1Y2NVSFlnMlRudVJ5WjV5?=
 =?utf-8?B?TXhPTHNQT1BEQllvSG5UZ2g4bEJrdzgwcEJOVlJjdEc5czFJKzRQQ0tPUDhX?=
 =?utf-8?B?MzhrU1RXNzJHZitZNERQejZ3SFdyZXZLYlBLcGkxaHVlRmhVVEJVYldiQ0x5?=
 =?utf-8?B?ZVNKaGtHQjFKcGRGMlBLb3JiSmZna3pjQkFGb0p2ajdrRmIrZ2dLNkhnYXMz?=
 =?utf-8?B?N3F0b1JMSmxRRWVoaHFwRmFqNXRkU0NCSlhyS3h0bmpRdnJDb3R3MGdHZWN5?=
 =?utf-8?Q?8X/oXit5uaGNdfu5Qm6+xDZfmQ31vfM6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3278.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3pVVzdwM1F0R09nSEhWWVprS3Z6UGwwN0ZCSDB6VFgzckxDNXA0c2F5OXpv?=
 =?utf-8?B?K2FRVkpRQXJTNDZYZXRoVnBsNGkwTjJCYXFMSG1ybmZTbEdkYUxrZVlKNkR3?=
 =?utf-8?B?ZjUzY2dQMXdLbTk0OFNyN3prbkdFb3NpMFk5R2FNTFh4TXhCQUFHN1g1VFY4?=
 =?utf-8?B?WEc5N3p5ZTBkd1NSbThsejFRWXVPS2EyL2o1bjhIbkQwSTBOYk5sZ3hCSWtN?=
 =?utf-8?B?b3JLelR4SVQzei9idmlzbzFUSHJ2NUdRVFg2eTVsOVB5N0FrWThUSmJDM25G?=
 =?utf-8?B?MlFPSFJZR0xnR2ZhU3V4RkZsaUdaZWxlMStVSllEaEhCbUFHcUIzMVJKeTV3?=
 =?utf-8?B?d3VYcG5FY0hjcWJmWEdlamZyVHZmVjBHbkszTUtZalhGditVazRhc2ZnNEx4?=
 =?utf-8?B?cU5GSk5tSHJ3ckFIb3JMNDlBL0tabG0rTGZva3RuQ3ZGVTA2bXN5UXVMSk5O?=
 =?utf-8?B?bklHSHFWUG9nRDZyTkIzVDhyU2dEMlRqb1hZSys1cDZ0RkgyeS8vbDRsWmdM?=
 =?utf-8?B?UEg0bkFuMnQyVm93Q1JNOGwxMzhXbEF2cTZkZ3U1UzBKdFIzYlNkdGhIYVln?=
 =?utf-8?B?RDhqMEFzNy9kL1g4R2tUM3AyTVhJU2I0OGhUVnEzVXV4cGowak82NTNMam1F?=
 =?utf-8?B?SmVTd3BqVUx4YmJ3TEUyMEwzY1UrN1l1RjdlbDF5ZUlURzh3NVlSSkE4UGJl?=
 =?utf-8?B?RWVvS3ZxekxCWHZnY0d3c1VLcmt3SjVOK2t4cFhjQSs3dklWMHZSRkNZODl6?=
 =?utf-8?B?b3ZSL1BUbklWV1VpTWJxdFRTOWhRMURDMmFrYzhQZ1BVYTg0Y1BsZTVjK0cv?=
 =?utf-8?B?cjFjbXZPSFJOUVlNZzFHTU95NW01eG9Hdi9hR3JKYStySWFvRVdnZ3JKYlVM?=
 =?utf-8?B?Q3BGYm5sMHgvLzk2cVQ1UCtjTVRhbXRxamhlNC9BWExzeHRJMDQ3V0NBTFBS?=
 =?utf-8?B?M3ZuVmZwc1BudDBwWThZQkdJUHQ1SUNBVWVvbCs0UnFsQ1NvNTRmVXM2N1l2?=
 =?utf-8?B?ZWQxa3FxYS85NklmWlRVdzdZNlV5YmNyOVpST3hobFVwUFZtL0pyU3F1Qndl?=
 =?utf-8?B?cytMTWkzM2VxUEhGNjk0SVVSaVdENHRJdFN0MjI3Uk5HVlNSVkdvcGpISkhJ?=
 =?utf-8?B?N3pQRGxrQlRGQTRQUzlkWEJsZ3REaXBSM0pnWHd6K1NVZndqWFpTK1pyYUFU?=
 =?utf-8?B?cG9Gdkk0TFA2OHZXNkEvaEVYZ2N6VWgzMGNjSkRnaXFnYk9jQ3ZFZzNrNFA5?=
 =?utf-8?B?S2ZUS0JUbFNOL3F1Zms1RnFTNlVQQkpNQjdhQ0MrcFU1elFrV0Z0VlVlQW5a?=
 =?utf-8?B?N1ZkK1lTclZObjJTQk1KUEdHOURCV1VjQ0l2UHRpZW0ySEVZQkxCKzNzclZx?=
 =?utf-8?B?MVhjMUl4VUlFUnZuOTZVOEU4cG5taXZsYUdiTU5WOGNEMmVyL21IZDhOWU9Q?=
 =?utf-8?B?Z2FGcEJ2aWNYdFpONk8xdTlwTzB4dk1TUUk5UlVQK00rVzhMK2xzd2s2QStk?=
 =?utf-8?B?Zk5HTjMrckFkOVhiL0luV1N1S09vb2lUTWs3N0FYandDemlhN2NKMnJ6WkhT?=
 =?utf-8?B?bDZXSlJYT28xV2F2a2ZrVVc5Q2NZZW5ucDRzbjgwaWROdnA4c0U3TXJLRXYw?=
 =?utf-8?B?SjFQSzhRKzh6VkZOL3NiRG9uNE1ma0ZCekRlVHhvYUhSbWRJcjl6RXlMRDlM?=
 =?utf-8?B?dnBWL3Bzako4TEs5Q1hTS0YrN2pGajdleUtnanBWbkhxOURlWmFUQWcrc0Vm?=
 =?utf-8?B?aWNnNGloTlF6Zy9JSDNLQ3RndFZsK0QyWUNFcWd0S3RqZ1A4U0kzUExTZi93?=
 =?utf-8?B?MjhKalF2c2dpODJ3N2ZZMjJpZVdaQlJCMzVURkMzZ1FtYTNMbjZsN0QwZHBJ?=
 =?utf-8?B?U2JPSGdubUdHK1hDbVNKZ3BOWFNwWWhKN0lQUVRQdkdOK05jMUZySWRsNGIy?=
 =?utf-8?B?YzloNndCdTJCaUpxRWpoK2QrT3Yrb3RjT2ZFbm9BcHZWd0dRMVpYNGJENU5y?=
 =?utf-8?B?aFhIdDR3V0hVUTc5b1lQQkdsSUhOZmZzR1ZyZHpscDlIZjNyQTJPSGF1WGg3?=
 =?utf-8?B?OFVsZEp5UktLM2tJZEVrVy9HS3pPOFVxRUd2OWVjcHJ6dFJWSys1WHB2TVFq?=
 =?utf-8?Q?tK8gK0WsBsET6tnll6qocyOPm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VNk7XkCXbykxTf4WYB6VC0HK9MCrBW/MPwmKQUsrkLYpuTPNgKjqnpT/3F9GqixfvmmfVhdUIym8/sOUh/3aVj/0dr8MXgv4Qf9cn0DBFzJdQ1P9UuJxWr+KsJe42Uky7VSIZETgVhDq9/l0NJhw8HB1yLQwORU+VdHLzxfLNK96GA7RXQm4eayQuLIcv8qzqkqWsatJ2S+Sc4FqhysSk09CEBCSAyJgeZum1FjIMYSZ81jVu9+r1No9WmNQNy1elXQBq6M1J/4ZxY/rhLizgNu405LpcvCqdOjn7GfRPbbedazD2+W1dniis7YmvJQvNlGQ8Ozn7BlG6hiMJoMrk1rV68X5RyPe1uztIYWb6RaHIbon9hNFc/I8Knf0CTTMJEpVNY/T292UZZaT5U7YKhM7wrfuk4t0PitxObkCyr5KpHOKuk0XMske/L0oQvFnEfj4qsU8LE1hQTmf+y50rVv22x04cvbsMfTgHmk+Bga1UYSDGbuP1kZY3fEshwHiTFlrbFrLy3llzjXRHpKcp4al5j7KXDLJLi58zfrjj/vZq7a2ixAFb6eXDVNVmQacDmLZ11w2KEnQSbt7UJEaNxNGGCCWO7Z3SOJn14I2trMzZbnCLkb8WtJ9Y5ALK7R9
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a456dd93-8a8b-4a37-8bab-08de3e35a2ac
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3278.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 13:02:01.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDFZKhqoYd+vU3KZPQ5qprCjNq921hdCmwpU0b0YnTnBvgEgi1FJXU42b2cKx0p0BX/c5mevJcpqPQJFmkHJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB2790
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3278.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 80.218.237.147
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AM6P192MB2790.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: I8VUjhPiTJ8ggt0_oKdWZJBiKUKnQYpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEwOCBTYWx0ZWRfXzUzcY9Yil22+
 m51ZAqWBKV2FOzwXbnbLg14tDNWrUDeJg7idqLbxCulgm5QBGO6bjTx0rnhQqcDQkvemTlbR402
 x76waTJxDT0KeapDuydaI2f3ud4vKe8vzJqJllII/eaikLW9kb0MaaN/ud+40GeQCfZLx2gBKAe
 f3+PNuDPgG8JwVGYOZT9B62nlAM9My30kRrQfWhxYtyJzuV1KHGIdbL0pTRVkHXRZimiGOA1oDC
 r/2u95ZTXeAEyt0zYLuxv86s+H69edxOHclAjXiv0LwiZKSTFj3EsiuGOs20RcuSaZTbiC37+mj
 XTB38d0p0gDda/5n4wt0s2UeCX7vCVjqN6zOvxLfcVUdeVPRuM1aM28xiHVdmMAQ2b4aCfk+oDS
 CB62O6RW4kBsBE6YnFIo6msMxHrARjcfoUF+HY4augG9ySBk6g+HGUXhdh53ncRCNVh9ecPtvor
 rmShqkTIfx3zKO2zDEA==
X-Authority-Analysis: v=2.4 cv=CpOys34D c=1 sm=1 tr=0 ts=6943fb4e cx=c_pps
 a=QN4MDeO/9LKGxpmifjbmOA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=cpTTntjW9XoIRVpTfXIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: I8VUjhPiTJ8ggt0_oKdWZJBiKUKnQYpS

On 12/17/25 19:26, Zefir Kurtisi wrote:
> From: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> 
> ath9k has a long-standing TX queue corruption issue on EDMA
> chipsets that can be triggered by bursts of TX requests.
> 
> In ath_tx_txqaddbuf(), when the FIFO at the head index is empty,
> the buffer is enqueued at the head and the descriptor is pushed
> to Q_TXDP via ath9k_hw_puttxbuf(). This is done unconditionally,
> without checking whether a previously programmed TXDP is still
> being processed by the QCU. If the QCU is busy, overwriting TXDP
> corrupts TX processing, causing frames to be accounted as sent
> while some never reach the air.
> 
> The issue was observed in the following setup:
>   * two APs and one STA on the same channel
>   * the STA sends directed probe requests to both APs
>     (36 Mbps, VO, NO_ACK)
>   * if the second probe request reaches ath9k_hw_puttxbuf()
>     within ~30 µs of the previous one, one frame is lost
> 
> The problem is highly timing-sensitive and can be masked by added
> latency (e.g. printk(), slower CPUs, or an artificial usleep()).
> 
> Fix this by checking for pending TX descriptors before touching
> Q_TXDP. As long as the QCU is busy, TXDP is left unchanged.
> 
> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> ---
>  drivers/net/wireless/ath/ath9k/xmit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
> index 75225c1..62b2249 100644
> --- a/drivers/net/wireless/ath/ath9k/xmit.c
> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> @@ -2422,7 +2422,8 @@ static void ath_tx_txqaddbuf(struct ath_softc *sc, struct ath_txq *txq,
>  	ath_dbg(common, QUEUE, "qnum: %d, txq depth: %d\n",
>  		txq->axq_qnum, txq->axq_depth);
>  
> -	if (edma && list_empty(&txq->txq_fifo[txq->txq_headidx])) {
> +	if (edma && list_empty(&txq->txq_fifo[txq->txq_headidx]) &&
> +	    !ath9k_hw_numtxpending(ah, txq->axq_qnum)) {
>  		list_splice_tail_init(head, &txq->txq_fifo[txq->txq_headidx]);
>  		INCR(txq->txq_headidx, ATH_TXFIFO_DEPTH);
>  		puttxbuf = true;

Ignore this one.

Discussed this with Felix and while it fixes the observed issue, it does this by
essentially disabling the TX fifo of EDMA chips, which is not what we want.


