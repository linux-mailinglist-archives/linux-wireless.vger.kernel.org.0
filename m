Return-Path: <linux-wireless+bounces-19765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42602A4E485
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE29176CC8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E331262D2E;
	Tue,  4 Mar 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="PHDFBn9D";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="bYj4xbq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FB209F42;
	Tue,  4 Mar 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102366; cv=fail; b=dnLq38zxxm6Pdv0Fa0ag3YqXSlwck+bEGGaPkM1dIdUAYmZCHKx4rhQc0ytUikPFlmAgn7BBFucWrEEbzEPP/aev0TW0tEqrt17tBGQzpR+nDIpxlO/UQxKp3BLOIdfdfuYXs44zrBnPez0zUutgKipf3yMLouM3hOF/o2BV8ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102366; c=relaxed/simple;
	bh=HKQn4APwS/vmG+jXdk7RCpT+H0sqnvdsNSDfVWkwHus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqIKZEtYNoBEhQlPWs/8fS8kjgQlubQXV0nqtusrgmOAFoOJO8Dj5m2k2A8tltcExX7Zr4Q2B0Czz5+SKGTXGxjp/J7EEP5SYRRLux42AHswTxtbO+8xdlMDSfjnZEMrXoystinIo44ZGfzgdg5V1RsgVFxggTw8JiP0RStqR2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=PHDFBn9D; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=bYj4xbq5; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524BAL30032344;
	Tue, 4 Mar 2025 09:32:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=HKQn4APwS/vmG+jXdk7RCpT+H0sqnvdsNSDfVWkwHus=; b=PHDFBn9DGfgO
	UTWxhTDnkUmvYNS1Pd637QXoWgOO4rvec8XBKUdKVzgWZFx/CgPMPvMm5KHdFN+k
	CyzP4B3Nsq5ayhnhmSFbh39k6N+0zzeVWc7hD0ThpJec1AmSbHMJ2E58niX7XFpT
	4ZUm2qMC4yPvA+wIPYYhwHehd0BwXR7khFMzycubD+RnlmMamPpFfmKhKo+KGtdn
	y28ddOsq4yAwgMtVJ+ekPNstMiQyd6yb762XzCpQHdimrsugKUUkJuNyCzMl4sEz
	2HSN7fejmCeEac9qWEPqanTT4r/hmElHkMGU9dDrNEQpQc9Y8hKpekzlnxCZn867
	CVo+ZgY5hA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchhcuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:32:41 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLtSOkFJE4uoHQj/PTXjNLDPvkgnuscRJaDQRCO2qETcOCGi79PscRpwc8n9VTG+2t6zzyPuxJqqxlbQE86oCaCHJWxKGbmswJDD0SWsG2te2ZOCgCLY25udk4wkJLQ4aen+r17MHL7v/BJLIxDG0geqtFzx7+Mgwm8OmFFzETUGh6NUKPYfHQl6/QvvjNMJkyOfQwW2CS95QWQHLAtOKe64TiSDx5CjzDZjXJXeuYGaT7MQ/O8DulEZSy3DxiskKqI2eTjnOgCPe5vlpWrujs/Yoh1eYxzHiMhmXxoSFsMbFj0BLTJBtG40KxexB1A5JNw4vlEz4FlfKzbe8uiDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKQn4APwS/vmG+jXdk7RCpT+H0sqnvdsNSDfVWkwHus=;
 b=esel+vOnKKsD8dohstwiwXt1jiGiCY+RgE5Tyc/5VjPSHHnYgUWxkZ4nr2ohKaioBc1zSOVAuqQYmzD5pV2efxORhYcNJ1tkG3IAAkzudtVe6oa0VJ4BPoFoBLyThOhlFK1xeq8U05dxuthCg3Ie2/d87v5pwlFENXZflCgx/gqCwRvwT8/8qzzlakEA3ozJSL8X7Z+L8TgwF5vzCleTpOaRmwNir2JbqXdyhi8TsSNtD0N7qWe9/fLWB+4RAKGrqUPlkSR6Yfeoibshgo/97/Mb5vOljIPKUHe6wrGpwFbsGnyO+iClwrgzAjh15dJbvDb8naA1zH/adW5DCXsxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKQn4APwS/vmG+jXdk7RCpT+H0sqnvdsNSDfVWkwHus=;
 b=bYj4xbq5llFrtrg8dzEw01Q6xoeu9pCTZiiBnfxQ3RiYmq1GRJbx0MoPftOHu8/6hYD4piUhACEGCmA9SWNOsFeQgLungh8ceIdRr8xP0f1EAhtWOH6nSn5yqYBUNe5YxSNUhx2sqok2dikwOnfeSguVQfndyE1NQnSEJi1QFGg=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:32:39 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:39 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v3 5/5] wifi: wfx: allow to enable WoWLAN using NL80211
Date: Tue,  4 Mar 2025 16:32:24 +0100
Message-Id: <20250304153224.39083-6-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304153224.39083-1-jerome.pouiller@silabs.com>
References: <20250304153224.39083-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::11) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 24875544-bd23-4576-e076-08dd5b31cc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVJrNXhMa3duNkxmbmtNc1M2ZDRhTldyZW1CR3FJZkY0OU1SN3RwQmUzWUFC?=
 =?utf-8?B?MlMvMmN3ZGFhK2xXYUdQWFdiVnpEWi9HQzl0ZDZlNkFLaXp3aHdxQVJ4WHpy?=
 =?utf-8?B?MWJuRmZ5MUorL0o2RU1RYzBIZy9nck9FN0g1TDVJL0VTckVLcHQ1dmFNNVNv?=
 =?utf-8?B?RnpPWGVWbDRLVGV4dVFldzVybndRU0U3NzI1VUZqZXRVNjVyeUdZcUZEb1E3?=
 =?utf-8?B?UFRCbWV1SjhhNmEvRVgzSE1CQXpBVlNpZHYzRysrcDNCdlVkQ2FEMlJBQWpE?=
 =?utf-8?B?MitSWHpLemVGcFY3VkhFakNDajRKcVpVcFhaaHk1T00yRHNZSFV2Z25XUE50?=
 =?utf-8?B?YUcwTVV2cEMvcWo4Q3hZSTd0bSswWElodFllZmhnMkRtU2lOSldzVnJKVlJI?=
 =?utf-8?B?M0xnWThqUEEzRmxUR3BsR01BUnJTNHRMeldVVTJQb0xhdi9mbEp3VTBzclNL?=
 =?utf-8?B?NEx0UGdHZnpZVjBqdkJ1Ym55OHN0bGkzK09paGJPVjBmcFRMVDdadUI4aGcz?=
 =?utf-8?B?VDB0citiVHhZWVBKQjgvTDREMjVzUFBEYms3KzUyRitWQzZPcW5yTVRQNDFs?=
 =?utf-8?B?Tmd0VGFXekVPWFFxUjFzb3cwazRVWFNUK3Q4Tng3aFoyNmU4eDd3YVFqZDhI?=
 =?utf-8?B?T21iSldBY1pxbFI5VmhNSXBBZnhsUkJ5YzQzSmxDZWhLcndwVTZjYWZPS09U?=
 =?utf-8?B?SnlZT3c2b3VkK1UrMStBWDkxd3ljNVFrb1Bpc0tsUmJYNnFEcER1aGpocVlo?=
 =?utf-8?B?NlcvS2ZhTnQ5NU1Mb0dva0FJelFjV2tmSmMwS1RrM214YXl6Z1NuK3N3MTFG?=
 =?utf-8?B?Wko4UUhyQjNwTTVOZFJQNFI0TjFXdzdvTC80a01hQ2pPMUVuTDdFV3hzOU9n?=
 =?utf-8?B?dTRXU094SHZVOHIzcEdmU2VpRk51a3pvaEFTc09sVyt2YTc4V2pNNTdiZlpy?=
 =?utf-8?B?L3NoTXptanBSQUNOcUw3Q3c1cEJaSUhGR1J2OFBRTElERW1EYnVkS0E5N2gy?=
 =?utf-8?B?UHUwdlBJc1B4MDh3WXFZZFNNWSt4Tm1YNHNzTWhtOXJYbzZTZFlHdWJZVS8r?=
 =?utf-8?B?bThMVDE0VTZFOGRieVYyVEZVSkt3RmR1L2FmVUZNVTQzWVhla2tod00wZi9D?=
 =?utf-8?B?ZlQ5bjdsMU9kQXJLMjYxVk1NbGdNWWN1K1hFYzZBT3JLejJhSE1HUk0zeDJT?=
 =?utf-8?B?cHNFQ1BJMWtsc3E2bWlyaEhLZEZkSWRTYjY2aGxjNVdpaklZV014L3p2eU93?=
 =?utf-8?B?Nk5rT1d1d1dQalFvOEZHUXpQWTdQbGYyaDdVMWo3dUtqYURJUnovd3U5c2t4?=
 =?utf-8?B?clNLcVBGZjcxY0Z3WUtnMmdOeU91T0J2Zm1ORUVpamJFT0lqVk9Wdk1IbnJr?=
 =?utf-8?B?RU5ZdmxOVGsxdi9naUZJOWo4UGhNb050YVM1WnhHZ2NIMUk3SGhzeXZMcWM1?=
 =?utf-8?B?eVFXdGxKSWp1SmdhZnZhYzF3bXpXRHUvYzJVazhRSlBqTnFkVWtaaXZUMy9z?=
 =?utf-8?B?TmRNWlI5SGJ2WjI5VExWWDF6dTNhNTQ5RjFyaG9ZR1NndzExU3Vzc3EzRi9P?=
 =?utf-8?B?TExoZXo1bXVSdW4vMTJoNGY5bm9SK05wUEJJbGErTVUwR3pzOUJ0d3lxL05E?=
 =?utf-8?B?Ym56UnVDRm9wcFBndEpJZVpHaFlTQmkvRTZhY2NkZGF2bVNLM2ltVmlRRTR5?=
 =?utf-8?B?aGowdGlSNjd6NEtneFlvcXY2L3JDN0pjZDMvM3d5SWFxeVdTem5EYmZkQTdK?=
 =?utf-8?B?dDh1N0FyWmlEaGp4TSszVVp6TzhCdEFMS1ZsdjhBS3o0MEIzNFFJdzdkWUpU?=
 =?utf-8?B?RHYwT0ZDV2IwMXptT241ckJBSURLYmZWRmhkNllIWm0vT05ZY0VBYnBIeFhr?=
 =?utf-8?B?K0ZyOW1DbnBDSkh1M2wxQ0J5OW5RbjZwdXlVMkhoOW5VWEFIV3U3ZTBzNXJ2?=
 =?utf-8?Q?xMEdaQCnMrPsQcNf4qgPxlmRHSfPuSxg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3hiUlNWanFHVVIvNk9VZnQrMnlIODBFV1lwTkl5ZWFXbFpRN2I0cW9yYW5Z?=
 =?utf-8?B?a2Fsbk11SzBwaFRaak01SG82OVROY1ZlSmUxL3Rkc3BVMHIvRW9hdWFMZzI3?=
 =?utf-8?B?RzhWelNhYm9SVWUrM2tCdUxvRDhxZ2syak5JVU9teVAzdHdKSFZodDNzMkNL?=
 =?utf-8?B?aGxIeXBZUHNmTk5rM0R2eExnRWZZSUY3NWhhWStmYTFLdFJFa1dtZzYwSlpM?=
 =?utf-8?B?bnp6TjdHZXk4TVdHM3kzTlFaS3VqdGRBODBaMEF2SWRFNGtIamRyRlkwZTBa?=
 =?utf-8?B?UVhRanpPQmZ6aDdMbVp1REhDMis4Y3JZV0d2cnhMUnMxOXovRnNobncrNFVq?=
 =?utf-8?B?c1BBQkord3NKQzhGNG1kM3hObGJNSHdLcndKRE8yMVZJcWhINUZzcUthK1Br?=
 =?utf-8?B?TEJyVHo1QW5KS1lRZkM5b2xyQUs2RkVKTk0xNGJ1QUF2VEZuMnowSWVjL3Rm?=
 =?utf-8?B?K2hYM2grNEJIN1Jsdnh6cnFleHJUazEwdEFrbTdKVWl6VlA5TndPaUtBaVZN?=
 =?utf-8?B?aXBKZlRJamZuWU5NdElNS1R6aGl5M3lMVUd4dUZtRVZQbWNPaTBiZ1RrRjBy?=
 =?utf-8?B?c2ZBMlJEWUtaQW5iczhjV25pOXJBc2xZNFB0VXZIVmxVK1AzNTlXWVZ1aHFu?=
 =?utf-8?B?cDNWNndoWE9kY00vUlZVNWl6YW51QnNKaDhvL2szMDVhVEpDaFNiTVNtcFFv?=
 =?utf-8?B?U0tGL0ZvQ3hFb2NpVnBnc3plUFhzMng5M2NVcmxLSkM5Y3VFdmQ4b3E1Q1li?=
 =?utf-8?B?Tmd4Yk5Td0JES0lGRm5tNlRKeWpOVkh3SHZiZmxaaFV4OTNBbXdGZExHSFlL?=
 =?utf-8?B?SEJXZFo0Q3ViNlpUcURESFloekZ0TmNicmRvaTU3V2I0OTUyc3pSUThKMUNK?=
 =?utf-8?B?VTBRbmxYRXJ6Qlduc2FDaEhmZGRYand2dytrbE1DYmJWZXp5VTNUeHZSVTly?=
 =?utf-8?B?dWJoMFBBNkZJNU5aYmQ3bklzZS9uUnV4WGhhcnNQb1ZMUUVTWk1DRzVwUTFF?=
 =?utf-8?B?QTlySVRCVnp1MWJOa2ZFOG1MVitMYUhETmFvNk82Z2phT3puNzY5UldyWDB0?=
 =?utf-8?B?Y0RZbDdmMVdTQmhHQ2RSaStZL2xQYnlDL0lxbm9vRVdOUHVuSDIvaS8yejJ0?=
 =?utf-8?B?QklBUnFsRlZLTHNsSXNUdFBCZmdvNXVtRG1iYkFmRWwyNG9iTHJiREg2N0JP?=
 =?utf-8?B?YURGMVorTUhCVm9BUzh1THMydVJtRDYvOXVaODBWUXhOZTRHQlJmRXVualNL?=
 =?utf-8?B?MFFlTE13NHc0VEFWNThqWWlvaWdkY0hJSCsxM0pXRlRxakJTTlVnRFlDWms0?=
 =?utf-8?B?cHp6VWwrZmVnc2Z0MlZWTExINUl0K2pSUnNja2NORFRkSW4rM2RFbDhLWWg0?=
 =?utf-8?B?N2Vpd0NtS0VwYVhEOGREcHJ6M21xL3NnNTJYSGlybVEzSWNDeXJ6QTZjZ2J0?=
 =?utf-8?B?ZGd2Z0ppamFIUGJrS1VIdndSeW5YaDczQnlxZDZrakF5L1ZmQmtJY2VuMzY3?=
 =?utf-8?B?S3ZGN1FVc2w2VHlrNXhaMXZMYnhXZ1IyK0cyVjduSEU3YiswTkpDdHppelZW?=
 =?utf-8?B?emFCL3U1RjNUK2gycnprYUY1Vkh1cGlVclg3Z2ZObDRDYW43Ri9rbWd4ZUdV?=
 =?utf-8?B?d0dtbzJrSnlOUlFMK3lLeWdWT0pWeFJTcWovRGZkQmpDY3BGRnppWnZOVGR2?=
 =?utf-8?B?MGsrT08wd3p5NzZ1d2VqUzFRSlRJSWdaaEVxUktlUjN4RGlvYzhoWjd2RkNS?=
 =?utf-8?B?WGg2RUJCcGxTQWNlZWdlRzI4ZW1RYVFQSnZOejg2YWcwQlJna0ZValRmeDhu?=
 =?utf-8?B?SXdYbXhrR2VvWDcrcURROFJKZDdBWW9jaElOelB5K01tdEVkYjRKZm40S2VN?=
 =?utf-8?B?NVIzK2htZDF0UXYvelBxaDFINU1nYU95ZENzaFI0eUVNcm5qT0Y4Y2tIVlRJ?=
 =?utf-8?B?dFRLcHZLRm80dkVUb1MvLyt1bVJUUHQyamhGOUppN2pSL25HZURqcFdiU1Np?=
 =?utf-8?B?MFZldjdmWjFFMjFWbEovbjhOUUxkM3QzTW5wT1hpM0RpR3RaSldveVA4Q1pL?=
 =?utf-8?B?ZTU5ZHBWNFJrc2psTDZxWjhmUEdVeGp3K0dtcWVyL1YwS0lPUnJnMnpQVEJr?=
 =?utf-8?Q?cK6F5qCxnQeoAgr22i2x3Zwe0?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24875544-bd23-4576-e076-08dd5b31cc05
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:39.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z/B/xk4UIfb9P6d1m8ggjqpOxaJ2qy04lOg95cuN9otb5U+6yodHqEVaxaIlPUhZZGjMelVMQI2DPaYuoH1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c71d19 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=OlggIWMgOj6OOkBI_M4A:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-GUID: RbI5rGfH_qpDrhLhf_ndaT-rnZXHIXok
X-Proofpoint-ORIG-GUID: RbI5rGfH_qpDrhLhf_ndaT-rnZXHIXok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040126

SXQgaXMgcG9zc2libGUgdG8gdXNlIG5sODAyMTEgdG8gcmVxdWVzdCB0byB0aGUgZHJpdmVyIHRv
IGRvIGFsbG93IHRoZQpyZXF1aXJlZCBidXMgY29uZmlndXJhdGlvbiB0byB3YWtlLXVwIHRoZSBo
b3N0LgoKVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXF1aXJlZCBBUEkgZm9yIG5sODAyMTEu
CgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFi
cy5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaCAgICAgIHwg
IDEgKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgIDggKysr
KysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jICB8ICA4ICsr
KysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYyAgICAgfCAgMSAr
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jICAgICAgfCAxMCArKysrKysr
KysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICAgICAgfCAgMSArCiA2
IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1cy5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9idXMuaAppbmRleCBjY2FkZmRkNjg3M2MuLjc5ZWRhZWYyMDg4MSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaAorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L2J1cy5oCkBAIC0yOCw2ICsyOCw3IEBAIHN0cnVjdCB3ZnhfaHdi
dXNfb3BzIHsKIAl2b2lkICgqbG9jaykodm9pZCAqYnVzX3ByaXYpOwogCXZvaWQgKCp1bmxvY2sp
KHZvaWQgKmJ1c19wcml2KTsKIAlzaXplX3QgKCphbGlnbl9zaXplKSh2b2lkICpidXNfcHJpdiwg
c2l6ZV90IHNpemUpOworCXZvaWQgKCpzZXRfd2FrZXVwKSh2b2lkICpwcml2LCBib29sIGVuYWJs
ZWQpOwogfTsKIAogZXh0ZXJuIHN0cnVjdCBzZGlvX2RyaXZlciB3Znhfc2Rpb19kcml2ZXI7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMKaW5kZXggMjdjNWQ3ZjUz
NGE0Li5hYjA3OTNiOTkwOGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1
c19zZGlvLmMKQEAgLTE3Myw2ICsxNzMsMTMgQEAgc3RhdGljIHNpemVfdCB3Znhfc2Rpb19hbGln
bl9zaXplKHZvaWQgKnByaXYsIHNpemVfdCBzaXplKQogCXJldHVybiBzZGlvX2FsaWduX3NpemUo
YnVzLT5mdW5jLCBzaXplKTsKIH0KIAorc3RhdGljIHZvaWQgd2Z4X3NkaW9fc2V0X3dha2V1cCh2
b2lkICpwcml2LCBib29sIGVuYWJsZWQpCit7CisJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cyA9
IHByaXY7CisKKwlkZXZpY2Vfc2V0X3dha2V1cF9lbmFibGUoJmJ1cy0+ZnVuYy0+ZGV2LCBlbmFi
bGVkKTsKK30KKwogc3RhdGljIGNvbnN0IHN0cnVjdCB3ZnhfaHdidXNfb3BzIHdmeF9zZGlvX2h3
YnVzX29wcyA9IHsKIAkuY29weV9mcm9tX2lvICAgID0gd2Z4X3NkaW9fY29weV9mcm9tX2lvLAog
CS5jb3B5X3RvX2lvICAgICAgPSB3Znhfc2Rpb19jb3B5X3RvX2lvLApAQCAtMTgxLDYgKzE4OCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgd2Z4X2h3YnVzX29wcyB3Znhfc2Rpb19od2J1c19vcHMg
PSB7CiAJLmxvY2sgICAgICAgICAgICA9IHdmeF9zZGlvX2xvY2ssCiAJLnVubG9jayAgICAgICAg
ICA9IHdmeF9zZGlvX3VubG9jaywKIAkuYWxpZ25fc2l6ZSAgICAgID0gd2Z4X3NkaW9fYWxpZ25f
c2l6ZSwKKwkuc2V0X3dha2V1cCAgICAgID0gd2Z4X3NkaW9fc2V0X3dha2V1cCwKIH07CiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHdmeF9zZGlvX29mX21hdGNoW10gPSB7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCmluZGV4IDIwYjljMDE2YjQw
Yy4uNDVlZTE5ZTFlY2JmIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L2J1c19zcGkuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
cGkuYwpAQCAtMTgwLDYgKzE4MCwxMyBAQCBzdGF0aWMgc2l6ZV90IHdmeF9zcGlfYWxpZ25fc2l6
ZSh2b2lkICpwcml2LCBzaXplX3Qgc2l6ZSkKIAlyZXR1cm4gQUxJR04oc2l6ZSwgNCk7CiB9CiAK
K3N0YXRpYyB2b2lkIHdmeF9zcGlfc2V0X3dha2V1cCh2b2lkICpwcml2LCBib29sIGVuYWJsZWQp
Cit7CisJc3RydWN0IHdmeF9zcGlfcHJpdiAqYnVzID0gcHJpdjsKKworCWRldmljZV9zZXRfd2Fr
ZXVwX2VuYWJsZSgmYnVzLT5mdW5jLT5kZXYsIGVuYWJsZWQpOworfQorCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHdmeF9od2J1c19vcHMgd2Z4X3NwaV9od2J1c19vcHMgPSB7CiAJLmNvcHlfZnJvbV9p
byAgICA9IHdmeF9zcGlfY29weV9mcm9tX2lvLAogCS5jb3B5X3RvX2lvICAgICAgPSB3Znhfc3Bp
X2NvcHlfdG9faW8sCkBAIC0xODgsNiArMTk1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB3Znhf
aHdidXNfb3BzIHdmeF9zcGlfaHdidXNfb3BzID0gewogCS5sb2NrICAgICAgICAgICAgPSB3Znhf
c3BpX2xvY2ssCiAJLnVubG9jayAgICAgICAgICA9IHdmeF9zcGlfdW5sb2NrLAogCS5hbGlnbl9z
aXplICAgICAgPSB3Znhfc3BpX2FsaWduX3NpemUsCisJLnNldF93YWtldXAgICAgICA9IHdmeF9z
cGlfc2V0X3dha2V1cCwKIH07CiAKIHN0YXRpYyBpbnQgd2Z4X3NwaV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
bWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMKaW5kZXggNTU1
NzNkOTc1Y2Y5Li5hNjExMjhkZWJiYWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
bWFpbi5jCkBAIC0xNjIsNiArMTYyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
b3BzIHdmeF9vcHMgPSB7CiAjaWZkZWYgQ09ORklHX1BNCiAJLnN1c3BlbmQgICAgICAgICAgICAg
ICAgID0gd2Z4X3N1c3BlbmQsCiAJLnJlc3VtZSAgICAgICAgICAgICAgICAgID0gd2Z4X3Jlc3Vt
ZSwKKwkuc2V0X3dha2V1cCAgICAgICAgICAgICAgPSB3Znhfc2V0X3dha2V1cCwKICNlbmRpZgog
fTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKaW5kZXggOWUwNmY4YjhiOTBk
Li5lOTViOWRlZDE3ZDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAt
MTAsNiArMTAsNyBAQAogCiAjaW5jbHVkZSAic3RhLmgiCiAjaW5jbHVkZSAid2Z4LmgiCisjaW5j
bHVkZSAiYnVzLmgiCiAjaW5jbHVkZSAiZndpby5oIgogI2luY2x1ZGUgImJoLmgiCiAjaW5jbHVk
ZSAia2V5LmgiCkBAIC04MTYsNiArODE3LDE1IEBAIGludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3KQogewogCXJldHVybiAwOwogfQorCit2b2lkIHdmeF9zZXRfd2FrZXVwKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBib29sIGVuYWJsZWQpCit7CisJc3RydWN0IHdmeF9kZXYg
KndkZXYgPSBody0+cHJpdjsKKworCWlmIChlbmFibGVkKQorCQlkZXZfaW5mbyh3ZGV2LT5kZXYs
ICJzdXBwb3J0IGZvciBXb1dMQU4gaXMgZXhwZXJpbWVudGFsXG4iKTsKKwl3ZGV2LT5od2J1c19v
cHMtPnNldF93YWtldXAod2Rldi0+aHdidXNfcHJpdiwgZW5hYmxlZCk7Cit9CiAjZW5kaWYKIAog
aW50IHdmeF9zdGFydChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9z
aWxhYnMvd2Z4L3N0YS5oCmluZGV4IDcwY2NjOGNiN2VjNy4uODcwMmVlZDUyNjdmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKQEAgLTU4LDYgKzU4LDcgQEAgdm9pZCB3Znhf
dW5hc3NpZ25fdmlmX2NoYW5jdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYKIAkJCSAgICAgIHN0cnVjdCBpZWVlODAyMTFfY2hhbmN0eF9jb25mICpj
b25mKTsKIGludCB3Znhfc3VzcGVuZChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGNm
ZzgwMjExX3dvd2xhbiAqd293bGFuKTsKIGludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3KTsKK3ZvaWQgd2Z4X3NldF93YWtldXAoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIGJv
b2wgZW5hYmxlZCk7CiAKIC8qIEhhcmR3YXJlIEFQSSBDYWxsYmFja3MgKi8KIHZvaWQgd2Z4X2Nv
b2xpbmdfdGltZW91dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7Ci0tIAoyLjM5LjUK
Cg==

