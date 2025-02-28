Return-Path: <linux-wireless+bounces-19600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5CA4A083
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F74175EEB
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9C1F09B8;
	Fri, 28 Feb 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="gV0LaRUD";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="GN3LNT1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B68192D7E;
	Fri, 28 Feb 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764043; cv=fail; b=Z9R7YfLcjTS3Kg2mFLQXQ9kEnDzVukXpuqtfJPlkUM51nM25zNngvdfUGv0YG8Ochf24zCVMKD6iDPX+ssCoUW6jjcnZnMV8e6RbbTJIvEoIPi/+K+sxGCxRawo9dN7yo7vtlOVau7U2u/2oXqRotp5ksD7000ifhzJKSAPbkVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764043; c=relaxed/simple;
	bh=bmGveIe2+A7L6FdtmG0zIVOM5bn+zCu7MkXU1N+tzrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJs6pBqGyNct/+zv8mrSUi0ifEe6zF5ojznbKTHbRw1LRssMcoCYeFA0Z8s9ygc2pB889fTrIl5UElwOnMDaJxTDAcPaHWOLKycGGz7cnjKQ6Vtp0Co6oD3zWRLKJN+b5sQbzIthfZzuRm4Czpj9lkKmWbx5lXNuunDFyC4AgUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=gV0LaRUD; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=GN3LNT1M; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SDK2j1012530;
	Fri, 28 Feb 2025 11:15:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=bmGveIe2+A7L6FdtmG0zIVOM5bn+zCu7MkXU1N+tzrM=; b=gV0LaRUDKFvy
	oVVAKAL7lALSqI3MawjUW2X1aAxyT5FfKs7gGnR7huvlMC03yuv57hS0BbfHuX8G
	Z/sThFZonPZGa5f7zAnK03b6/Sf5mkgHFaGW5SyRP2ByEAK4m39WfvT8WZrE1vol
	WrVWh6sGAuGaAK5n4bZEneiWXq/fZzoyVhbFYt2/CXPwf+nRR1DV6NulSm1sJJJh
	B60Y4/1tFfJzkmOm/o6hxFECD+KbU3U0LYRuxhh0l/VCAb9aoe8zrytzrmVTuxmw
	mkyDJ9Y/NPNTxcurCLhs0eptWhiQvQMrCNlteCVIaojq0RGjs/Fr+J1n9cSoDl7a
	kOSIEpc2DA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4539fbruje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:15:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2ySYqp4CdI9eU8dU3UVnEoeb14cZp7E4IaDukrKZSYAHZLrilemshjL7IOwm+GghaWKWJOCM3T5dOXr4soEqgCD8u/HUUpewSBdRCZLLTWbycZerhqRxY0EDzJMoznaU2FIOwQH+kbajxQh2KQxamTejflEg6tPJP7vPGEGYseNT2eEpOspmfdwijMgA4QkbSGqTkCu75tmNaOKCnvqRy/lt/ra1S3ilhQXlfJRy59Upv3c7n2EB7l4a6Xv0r//LUs9Equ22q7oCG9yUnSi7A2lRpQSxztxHZtkwd53q9KleP1ogb5ZkQ7l2SjiP2NlZRNRUySRTIfwmqhUWiBaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmGveIe2+A7L6FdtmG0zIVOM5bn+zCu7MkXU1N+tzrM=;
 b=LBaCOhlQ8HqV3ZtKUByef45J4CkyDBZJj2CUUtiKZiWzIIiJviubOYTw3T/LQgYT17VI1tzMLuyWFC0VSNQj2XU/2hWwLczanPECuQrMu8GbZSBghPaRk4WrQSsdBSweMO3PC0LvUYTf/5M4em7n5qlcLqNuYToKbNiYfule48sk65zbrK2mSnF7wNFcKgyxDdk6cgyE7wQY4xCRCQX0kmbcNbQZ3/xzfMqorFmg/lL/FD7g45ax2BL3cJ/GKHzolWqB63oKx0LaiCHsKYgy6h4MyfWyrVuhqjTz3xh8aYN3v8yRyaEOb2ZiZPA6/wadaOZBIeIegBNZKCwXpkaT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmGveIe2+A7L6FdtmG0zIVOM5bn+zCu7MkXU1N+tzrM=;
 b=GN3LNT1MQJjVfAxc/D+MIObVX71scVaWMKojbN4Dt9bbJhia8n442s4cub8ILT3RIwk9pe2WuZ/DhtK86CgEwWkOO/hRsLm1BApq7WY8HvStzBH0c65bfdNhvMGqeNN9X40Sa22XTDBm8LSFobgUY4QiwpFrdu9ZbuylfDRkn/s=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:14:56 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:14:55 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH 2/5] wifi: wfx: declare support for WoWLAN
Date: Fri, 28 Feb 2025 18:14:38 +0100
Message-Id: <20250228171441.109321-3-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228171441.109321-1-jerome.pouiller@silabs.com>
References: <20250228171441.109321-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::12) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ0PR11MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 517affe0-d226-41d0-08f7-08dd581b6bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUlMRVRJdVA2c2wxb2laaG96REdQcVNDU1dkTUE2RzVFOURKRnVxQjhEbmVo?=
 =?utf-8?B?NDdCMFk2MjZIWG00S1NRbVozQWRCWXJYM01WNnRmbVA5bGtFblc0M3NBS2ps?=
 =?utf-8?B?YVo4TG9OL3BTR2h0aXQ2Qlg5MXZpVXhzcXN0b29DQngvaXk5MlhUdU8rd05v?=
 =?utf-8?B?K1ZKa0NwMENlR0ozdUtKZ0xyMVhvZnl4WlRTVjRtQmpDZ2NKSWtNUnlpY1oz?=
 =?utf-8?B?Z0JvN2d3b24xQ3gxZ2NoZU5YUGNldEFLam9CUEhvS2hUcVJTazBQWUxNaXR0?=
 =?utf-8?B?TWhFc2RCTThaa2lmQ0krQXVvZFh5MkdtbHpjc2s0b294OSs5RERlRWNCQ0J2?=
 =?utf-8?B?eHhMRjZGQU9ZNGYzSzBRQ1RYZ1dQNUluR3RjMXhqaGRkVXlJckZQYWtub09o?=
 =?utf-8?B?WlFGMkRJUXlqOElPSkl1SmFOck5GZTF3OTdIeTVoVzBTUUxudGlSRmZZYzRS?=
 =?utf-8?B?ZTZtZ1RNRDRsWTllRjIwZXpsc0xUVXQwOG5uZ3BoZS8ySmVKNm4yNkF5MEV5?=
 =?utf-8?B?OXhsMk15cjEzayt1bVIxN0hSZ1NoK0NnYlZoSm5FS1owUHlQK3ZadTc4NFZ0?=
 =?utf-8?B?OVhVTGdrRXZLWmFJaXJ6ME81dEdCWUNRL3VuRnA2Zzg2QVRoVFU5UGZhZ05k?=
 =?utf-8?B?ampZcXBIQVcvYXdVQ0lleVM0a0hjaTJXdExnR3YvekkxdW00MkgvSElIOW54?=
 =?utf-8?B?eDhmQ3FxWEZOcWVNL2pBckNNSXdwclZhcWc0YmdQRk9aSC9lR1NHc0haRWtP?=
 =?utf-8?B?cTk2aHFYa0VkZGtCV3F3dngzNWFYT1VBRjFoZ3ZlZVlickhzSmgvZUlPejJu?=
 =?utf-8?B?ZzdrUms5dWFSeWs3bUF5WDFiT0xsVnJ5UDlsOWxsRkIxVjZtWDRSeXdMWitu?=
 =?utf-8?B?OFRzVklJZUhNaXBIeTVKK1J6U3ZVbjdJNldLMkdKalBCMXpVSWNhVWNNMkd3?=
 =?utf-8?B?TFNjNUFoMTROL2liWXhMUGljelVsQ2xuMDN0UG1YQk5TZ3NEMHlYM3JyUWdv?=
 =?utf-8?B?dEdOZGQ5Qk8ycXZId0c5a0JDTFlNY2NKb0h3VzN1WXViK0V1TFFFdEMwdXpY?=
 =?utf-8?B?UHBlQ2VaaTREeWI3QXp2UGN0a21OTnVtSGhRR3RZR1hOSWFucDc3UWpZUEsv?=
 =?utf-8?B?b3dEeUZvZEgvODdFRGVyQVNhd2xRbzVLYndMT0g0M1FwT1NDKzVHdC8yd1F3?=
 =?utf-8?B?QXRzN2hEZk1HaUFZTERHSHFDUTE0eXRMOWsxSVd1S2FGaGZyVjh1czdyNXNG?=
 =?utf-8?B?MWVOTlU2R3lEelNqVG5YVTdqeTdpdmNkQm96VkJkTDk0WjNPaE53TTIwU0hw?=
 =?utf-8?B?d3kvL3JNTFdFR25IblNvUEZtMGw1bTJqTDljRC8zaGhrY0xQMmJGUWo4SWNP?=
 =?utf-8?B?cWw2djdlcHg2Zmd0ODkxU3UxemczWk1vWWIzTmR5Uk9rTmNMVFZPNnMzL1or?=
 =?utf-8?B?ckJpbGt2ZlFFOWVHcHQ5enpHVnlzUk1wd1U4LzY4V001WGNMWHhOY1VBcDh6?=
 =?utf-8?B?V2NtTDgwTHpVdXZNSXJJNGFXelVqdTd0eXlQK1JERmNWWWxISmxaTTNHNGZB?=
 =?utf-8?B?NUpUMEhNaFVyZDd1REJqQ1pPR2grZ3h2NWFwWVRsR1FNU3kxVGVZYUhraDF6?=
 =?utf-8?B?aVZDMFE3WU9QbEJpNVI0ME5FVU43T0xTNktsSnowSjhDRUxLemZLelZrSkMx?=
 =?utf-8?B?ajRiV08xQ0ZTUUJabzUyLzZhV0hiYnR0cVo2QXJaVWlGS2RuYTl2OXQwV3Yv?=
 =?utf-8?B?U2czZldGK1QxSCt3OGZ4QWtYN2FGQ2l4cXROTmZqK2RERzkyRktSRU03SU1n?=
 =?utf-8?B?OXV1SWVYVXNxd2h0ODd4LzNTSkRLa2ZXcUZ2WXlLcVBDa3dOaTFscWViaTY4?=
 =?utf-8?B?eXpXNUVMZmNsTHIxVTlKekJ5eEFBTDlyU2Vibit5RSs3OWttZ1BxYTdqRHFn?=
 =?utf-8?Q?VoJ6dy4zK7NVou+/xWnBd9fA9MlmwODk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTV5cGlsZ09YdDNGRWdUVWtaUVdwdFd3RGlEREM4V05jajRwTXBJQXpvTnMr?=
 =?utf-8?B?WFJPMThpdUczNGNQS1JXa3pOcEpHcTlaVEpzc0pyRmJSdkRqV3lZTmdsVDFk?=
 =?utf-8?B?bnFoeXJGR1d3RXk3dW9HenpXZC9YTFRGbGZxZm1GQWhyU3djekRoSzRoak9l?=
 =?utf-8?B?VG9uaHUva3QwZG9NakxTNlVob2c3WDFWNEhscDJLcUYzUjQyTWdpSnM5ZUNU?=
 =?utf-8?B?VWM2c1puQXh5Q0NsVG5PTGNOQ1ZmOWVJcExFdktlTXBrd1BMTGZWTTZCRXZl?=
 =?utf-8?B?M0M2MmU1S3IwbmNuTHVjZVdlZDVTSm9UYkpVb09EN1BJaFVaTEM3L2RqTGV2?=
 =?utf-8?B?ODlIZWVNQVpIYWczRHhETGFoTXY5TGV4ZHFBNjFldWxWdW9yNUJHejA2enRa?=
 =?utf-8?B?ZzBiS3UvYWtUZmpBTEZsTEJNcW55aGc4WGo4eVB2TmFqdXZlNXJVcUtwSTN0?=
 =?utf-8?B?dnliL1FqMTJod2hYUXhOSnQ4VkVDUUMzV1FFM1doK2xRVFgybEFrcUJRMGZy?=
 =?utf-8?B?K3l6TVcvOWFsMGxtbSs3SENaOGo1cHlTRW5pTTFOUUp0OEMrajVOOG95RmdK?=
 =?utf-8?B?Q2JSZEx1bTJZWWE5UkpWdUQ1czJBRXdWUVZqVDJCV3lVYko1Zzd6U0F6enR4?=
 =?utf-8?B?V0NoS29kOWJscStEOGthbkZkT3hsZ2E3TThTalhIMzJGL0ZSalF2MnRKTVFS?=
 =?utf-8?B?ZVUwd0tKc1pUZjB1RU55aTlpTGJVNHp6YklvUTJYK3JOOGR3U2NrNUFkNURK?=
 =?utf-8?B?WmdqUmhLT3I4UkcxR2pXMDlGSlhCUzRkYmZqYThKa0JtelZHcVpDQzdWTmo2?=
 =?utf-8?B?MHIyaWZrR2RaMXI2R0hKZlZOcjMvVlNRWVl4UWZkYXpWZGRPNG0vdDA5dnJF?=
 =?utf-8?B?VjlRVXl4UExhRWUvYVVoL1YvYmVqSWhwOGYveU8ybFVWeTlITldXenNOSU51?=
 =?utf-8?B?YVl3U1FCSG9INEhUVlpybFNuS1kyOFVIV2QzTnl4S0M1K0Q3elo1c1NLNnV1?=
 =?utf-8?B?NHVLS0krY2lKM00vVGx2REw3cnNlMnR0TUVwSzhBZWFRbUZVeTRTRmY4Vzdn?=
 =?utf-8?B?OENKcVZSQTFQZ0pkbVNLNHJuYWNTbnVmSEIzbTJIOStDUmlFTTNJMWJlZ1oz?=
 =?utf-8?B?K1RtOVVHVHJ2L2kxQmZFdGlHdW5EbGtBaWY1V2VQMTFZRGcxRkVqTDgrQ2Zw?=
 =?utf-8?B?U2xtY2h6NndrRk5yU3ZmR0xHVE52eTZYUWlReWkwWVN5OTBZS09aUWk4Vy9u?=
 =?utf-8?B?R01WbE1VOWJ1elE5cVBWVHI1YUpEc2tGYlhTUW1mRmNEeGVEdGdabUVsT2lG?=
 =?utf-8?B?TURITWpjakFFcmRCelAzSUhxREtiamc3SzVNaGVsbGFqMi9xSFRXYlE0QVdD?=
 =?utf-8?B?WFJ2M3o4QldrQlp1a212MzdQdVJlZlV1U3REZ3lxZldINnJ1N2JFSXRwZlpD?=
 =?utf-8?B?MkoxeDU4emgwV3BJY2RteU1BRDl1VmZabEZPSVMwQndoUzBCeHdCd2NuTTVi?=
 =?utf-8?B?ZUpMRzYzSWtZRXFLRmw5QTZoMEgzbTg2ME1hNmpER0FINWZucG9jZlhVVkI3?=
 =?utf-8?B?a2lta2xOblZUSmVSaW40VmJrMTFCVnJQZ00yaUZGNlF1SmZPVzZXdDJUM01a?=
 =?utf-8?B?SHNvWEFWWjl2dE1ad3hxLzBCNW9mQytodHZMRlRLRm0xUWQ5bHlQY21EdzBD?=
 =?utf-8?B?N2pGZmMwbzJSU01aeTRORktOUEhPb3ZabnVaQVRMOXhuS1Q5d3lqb20xSXJ4?=
 =?utf-8?B?Z0lJUzh0NFpTcWswV3BXeE1lWjdHUXVWR2VCZGdOaDRhRVdWQ0FJR0xiMFV6?=
 =?utf-8?B?OHN2dzJucUxRL3NpUlc0VjZlSGFpNUNlSkVBd2FtbDUyMGVRcm1WU3Y3M3oz?=
 =?utf-8?B?ZlhRUHpEQk9jWGwyVkFERFcrSWpZSEl4Z29pZDh3ZG42OTc2M0VOTFI5a2Fi?=
 =?utf-8?B?V3FadTRqLzlFYnYrVWtGSE9ZWGtWdUYwZ3NoL1RBai9TOEtHZ0ZoMXNBTVVY?=
 =?utf-8?B?TnMrRVpWN2RFQ3NSdEdqSk1ZS2hKZVZqMVkrMnpGN1FkVUMvQlRlVkJTYmhB?=
 =?utf-8?B?MXJHNVZoU1JNaXB0dEpVbjRoZ0pwVDM1bnJ0cVhlTFlPT0V2bTlueFROTmxL?=
 =?utf-8?Q?X/ANIkfZVVcJ1xExx03C6eqic?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517affe0-d226-41d0-08f7-08dd581b6bd6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:14:55.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1krz1Mis3ATFw/z2KtGhVBjIBAt3fU81880wkqja+SG2lf7ULKkIN5yU8w5YfwLUQKKwy+eLh5w99mJ2RTxKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
X-Proofpoint-GUID: xMPR8nn95QgI025OqS-IGgFr7fPcpepQ
X-Authority-Analysis: v=2.4 cv=BptnwZX5 c=1 sm=1 tr=0 ts=67c1ef16 cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=1DX1WFhz2VHbj9lhsL8A:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: xMPR8nn95QgI025OqS-IGgFr7fPcpepQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280126

V0YyMDAgaXMgYWJsZSB0byBrZWVwIHRoZSBjb25uZWN0aW9uIHdpdGggdGhlIEFQIGFsaXZlIHdo
aWxlIHRoZSBob3N0IGlzCmFzbGVlcC4gU28sIGxldCdzIGV4cG9zZSB0aGlzIGNhcGFiaWxpdHkg
dG8gdGhlIHVzZXIuCgpGb3Igbm93LCB3ZSBkb24ndCBwcm92aWRlIGFueSB3YXkgdG8gY29udHJv
bCB0aGUgZGV2aWNlIGZpbHRlcmluZwpmZWF0dXJlcy4gVGhlIHVzZXIgaGFzIHRvIGFsbG93IHdh
a2UtdXAgb24gYW55IHJlY2VpdmVkIHBhY2tldHMgYW5kIG9uCmRpc2Nvbm5lY3Rpb25zLgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jIHwgIDkgKysrKysr
KysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jICB8IDE1ICsrKysrKysr
KysrKysrKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuaCAgfCAgMiArKwog
MyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L21haW4uYwppbmRleCA2NDQ0MWM4YmM0NjAuLjgzZmQyNzhlNjE1ZSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMKKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMKQEAgLTEyMSw2ICsxMjEsMTAgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfaWZhY2VfY29tYmluYXRpb24gd2Z4X2lmYWNlX2NvbWJp
bmF0aW9uc1tdID0gewogCX0KIH07CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgd2lwaHlfd293bGFu
X3N1cHBvcnQgd2Z4X3dvd2xhbl9zdXBwb3J0ID0geworCS5mbGFncyA9IFdJUEhZX1dPV0xBTl9B
TlkgfCBXSVBIWV9XT1dMQU5fRElTQ09OTkVDVCwKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
aWVlZTgwMjExX29wcyB3Znhfb3BzID0gewogCS5zdGFydCAgICAgICAgICAgICAgICAgICA9IHdm
eF9zdGFydCwKIAkuc3RvcCAgICAgICAgICAgICAgICAgICAgPSB3Znhfc3RvcCwKQEAgLTE1Myw2
ICsxNTcsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIHdmeF9vcHMgPSB7
CiAJLnVuYXNzaWduX3ZpZl9jaGFuY3R4ICAgID0gd2Z4X3VuYXNzaWduX3ZpZl9jaGFuY3R4LAog
CS5yZW1haW5fb25fY2hhbm5lbCAgICAgICA9IHdmeF9yZW1haW5fb25fY2hhbm5lbCwKIAkuY2Fu
Y2VsX3JlbWFpbl9vbl9jaGFubmVsID0gd2Z4X2NhbmNlbF9yZW1haW5fb25fY2hhbm5lbCwKKyNp
ZmRlZiBDT05GSUdfUE0KKwkuc3VzcGVuZCAgICAgICAgICAgICAgICAgPSB3Znhfc3VzcGVuZCwK
KwkucmVzdW1lICAgICAgICAgICAgICAgICAgPSB3ZnhfcmVzdW1lLAorI2VuZGlmCiB9OwogCiBi
b29sIHdmeF9hcGlfb2xkZXJfdGhhbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IG1ham9yLCBp
bnQgbWlub3IpCkBAIC0yODksNiArMjk3LDcgQEAgc3RydWN0IHdmeF9kZXYgKndmeF9pbml0X2Nv
bW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGEKIAkJ
CQkJTkw4MDIxMV9QUk9CRV9SRVNQX09GRkxPQURfU1VQUE9SVF9QMlAgfAogCQkJCQlOTDgwMjEx
X1BST0JFX1JFU1BfT0ZGTE9BRF9TVVBQT1JUXzgwMjExVTsKIAlody0+d2lwaHktPmZlYXR1cmVz
IHw9IE5MODAyMTFfRkVBVFVSRV9BUF9TQ0FOOworCWh3LT53aXBoeS0+d293bGFuID0gJndmeF93
b3dsYW5fc3VwcG9ydDsKIAlody0+d2lwaHktPmZsYWdzIHw9IFdJUEhZX0ZMQUdfQVBfUFJPQkVf
UkVTUF9PRkZMT0FEOwogCWh3LT53aXBoeS0+ZmxhZ3MgfD0gV0lQSFlfRkxBR19BUF9VQVBTRDsK
IAlody0+d2lwaHktPm1heF9yZW1haW5fb25fY2hhbm5lbF9kdXJhdGlvbiA9IDUwMDA7CmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwppbmRleCA3YzA0ODEwZGJmM2QuLjllMDZmOGI4
YjkwZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCkBAIC04MDMsNiArODAz
LDIxIEBAIHZvaWQgd2Z4X3JlbW92ZV9pbnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcs
IHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpCiAJfQogfQogCisjaWZkZWYgQ09ORklHX1BNCitp
bnQgd2Z4X3N1c3BlbmQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBjZmc4MDIxMV93
b3dsYW4gKndvd2xhbikKK3sKKwkvKiBGSVhNRTogaGFyZHdhcmUgYWxzbyBzdXBwb3J0IFdJUEhZ
X1dPV0xBTl9NQUdJQ19QS1QgYW5kIG90aGVyIGZpbHRlcnMgKi8KKwlpZiAoIXdvd2xhbi0+YW55
IHx8ICF3b3dsYW4tPmRpc2Nvbm5lY3QpCisJCXJldHVybiAtRUlOVkFMOworCXJldHVybiAwOwor
fQorCitpbnQgd2Z4X3Jlc3VtZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykKK3sKKwlyZXR1cm4g
MDsKK30KKyNlbmRpZgorCiBpbnQgd2Z4X3N0YXJ0KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQog
ewogCXJldHVybiAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dm
eC9zdGEuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKaW5kZXggNzgx
N2M3YzZmM2RkLi43MGNjYzhjYjdlYzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93Zngvc3RhLmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9z
dGEuaApAQCAtNTYsNiArNTYsOCBAQCBpbnQgd2Z4X2Fzc2lnbl92aWZfY2hhbmN0eChzdHJ1Y3Qg
aWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIHZvaWQgd2Z4X3Vu
YXNzaWduX3ZpZl9jaGFuY3R4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgw
MjExX3ZpZiAqdmlmLAogCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV9ic3NfY29uZiAqbGlua19j
b25mLAogCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV9jaGFuY3R4X2NvbmYgKmNvbmYpOworaW50
IHdmeF9zdXNwZW5kKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgY2ZnODAyMTFfd293
bGFuICp3b3dsYW4pOworaW50IHdmeF9yZXN1bWUoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpOwog
CiAvKiBIYXJkd2FyZSBBUEkgQ2FsbGJhY2tzICovCiB2b2lkIHdmeF9jb29saW5nX3RpbWVvdXRf
d29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOwotLSAKMi4zOS41Cgo=

