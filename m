Return-Path: <linux-wireless+bounces-19602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B44A4A08C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA75176CA5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D9170A11;
	Fri, 28 Feb 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="lP+9/y8c";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="KIpxY7Tt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA461A8F9E;
	Fri, 28 Feb 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764132; cv=fail; b=ssyBE9Zc0fIK3o4bR1siE+92j27k00UDNxFcjj94wM0SWxTJ2kxL36CNL1cmr4VNiOzbk0/55G+MB5ysr0UDzk8aUGPALPK3UQ9ELissaT1pDSm/HxP7RGHgrY/PoDvDRdfpA1cTweiFKbQzlDLEXf+sOSxsXvpDwPz+fVP4wPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764132; c=relaxed/simple;
	bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9IlssSKQP2bDDwwwg/n+18VMMWEcRgEEGY1pt1K8St6YQJBbErvHGMJkdLhJP2Y8uO2kA/xQsZWaCTdXJLEWeNllusiYa2nXtbQueL1F+ronn73U8P82GO4qAJ2DVrLQyqUdTsJNU4slTSKrF5dWujtaTmGIZOUybkCCRQFFZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=lP+9/y8c; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=KIpxY7Tt; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8EhYJ012718;
	Fri, 28 Feb 2025 11:15:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=; b=lP+9/y8cVI9t
	9vk6+T1gSwgGiM1sm5oHbMAHhv+BqbdiJo4TIXIimldZe3oGka5hxDsxcPb/Ueax
	j37I3Y6WYZEMoH5te29DDl+PEz1rtA4Dnk/bhKDHX+FxMNUhcKcAgBu7hVZ4KnUt
	MQ+mBMJP/+nLTavJovZyrOiRe4cMUH+xyW9bJWetAWKLIGUuRQZBeV1TnqrRYNev
	rTjCDnScwZxPTeUjMLYUnUpZrJJSrruBWJA/chSY24TMv8UkneAE4TV1/gXKYTKF
	HHTSYTIJvlryA1Df38z0Vy6XaZuH+2XbtGjen/NKy1DAGm+k/tYQkr3L+uydYKzD
	2XyK3Z75AQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4539fbrujd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:15:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqjwtyXsYMvLcYJlaY3a8HkSAI3QRKjZI9Rbq9jtMVYOqq6S3dIWWo12Ade7QFxvJRYKr9HfoQkqRZBaNl9YDenb7PCMWs4shkVAmkAIV6+0+IIpU6/X+la3W0P5RHfQe0hBuSXm8JOuSn8ZD/lpJj1K+J+pMJHRJGekZLpYhfw4cp9QI2646InwluAAhYmzuNdRZMKF7OLFoAJCEV43SKx2pKhWZF2XFtKR2iSBfURW2jzxrHz7gysh8tDP2zpGIrsXk8n0w20LdFlgwjf+0Mk+oWf3Q/ZWfoK1g5GCNvJoXm14Bb2Fc8j6yG42+575RBKbro/K7DbWikk0wM/EhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=;
 b=u2G79onUrASXtFt3k8o7ZS/MyAOU4mKoV79EtGCPR1vNuHQ/m05bP7lOEYNOEQO3NICcwK2FYjvOt7aoR5+TocR0UxnQ/jfFJFBCtcIW2KBW326Eu93cSDNK03Oka7smW8mIuGFewz1mIvxlkiKXcdbetwK9FeKDz03naORLdax6011lKrSgRCtJkvYb3oEIp+qAOZy8m5ylRM8D8+Fzuk0QcLdFm0u05J5yxvpZDxUpb7/fgikpWTd8WDY9+tvDtHuSKJ9NEwNwABB07I6eJkkpyRYZN77HHLFazbhURECF9JbPjQrQzuCrA0z2MlnNCMzFVtGdMdvQpPrVnFbNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=;
 b=KIpxY7TtTWMOS/xDkoGQebOe+dFLMKSJq1uZZLGpr8F5db+C8x+e3JneXg6fLCZXZgr10Fp0vya4h6Jiff4LVkFTtwFxmfUtYSNxs7rw0iXYbVm8qKA4KQxFaZERElgmc3NKS44OmjRGhCD3SuCKKZk/nMMShBwmRcnQ7sPUAZc=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:14:57 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:14:57 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH 4/5] wifi: wfx: allow SDIO device to wake up the host
Date: Fri, 28 Feb 2025 18:14:40 +0100
Message-Id: <20250228171441.109321-5-jerome.pouiller@silabs.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ2PR11MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 33633b8b-2499-41a1-c175-08dd581b6d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXpGd2h3K255Q0xicTY4MlZMQTJDcllDeVZRcmZrbllxRDdEa0VXSy8rNTY2?=
 =?utf-8?B?ZTJZOWRJZ09Nd3Q5QlgxYXozM0lHMnNBTFBDTm5aUFkrOUd5RkdqTVczZHB4?=
 =?utf-8?B?dHRSdzNQMVJCOG9ENm1FeTNyVjJDYXdVYVpaTGNhdjVIQjh1cHNialQzZmdk?=
 =?utf-8?B?aWZCZ21EOHpSdmxQR1pvaU02TktoaEZtbmw4b0FwSzlNWXpRbTR6TlpnTVFP?=
 =?utf-8?B?dEMxQmFxeFA5a3JzZXJNc3Z5NjJJcndkclEveUE4Rm1pdzdPeGdmaWtmM041?=
 =?utf-8?B?cktaNGlwOE12QXR1djNhMkUxd2JPV1Nhc0pMTzVDd3V4Ym5RYkNqaVVrTmlG?=
 =?utf-8?B?TkU2T2hzdjgwNGVhNUtOMjhxQVgyTnlEMGNFMUV4TlpkSHI4b1Q4VlpMNzV0?=
 =?utf-8?B?eTRmc28zNzhrR0Z2Q2tubXVPbnhuQ1A2RkdibzFiSGZ4RFQrc2VORmtCNWtt?=
 =?utf-8?B?ZnhnUHd5RS9QMWlGQUg1TXUzY0cxK3lFSVJMR0p5NWUzeWJvdEdYVzcvL0lu?=
 =?utf-8?B?RlRXNEpUOVFTY0wrTzNaV1ZpWHJyWUtWWVYxYmNYWHV5ckZITFkzbUVOOE1Y?=
 =?utf-8?B?eXN5VWZGY2ZlQ2ZWWGVGWUo0OXlmWnZyVC8xazlLbHRZUHRYUlRpRmlSdHRN?=
 =?utf-8?B?OU80Wk1ZN3JsOE55a3BvQzM5OS9UVEVjRTJ0a0REemxkSXQ4YlhoZGhJSzYx?=
 =?utf-8?B?SHJRTVh0dnlpM3pyYms0cCt0RWpXdDdTSy82bktydk4vTnpBVis0Ti96SjFN?=
 =?utf-8?B?OE9GYXZXRjNGNlpuanNLeFFiRUV2MzlXaVhCQ29UTzdLQnFQdWtSbGdPai92?=
 =?utf-8?B?T25tR3Rqai9JM04yM3NDUkpoYU0xYTh4NXkwcVFSOFdqdUpTY2FFWDhQSCtI?=
 =?utf-8?B?bTRHaDEyVGQyTWFIc2w2SXdGbk9LR0U3SFRlY004Qk1ZekozM1RmbHg1QUxt?=
 =?utf-8?B?LzNrV2VoUHZSeExzaFNPUTBENjFOWU1mc1ZGUXVDeDE1TVFuaUpndnFiYXhw?=
 =?utf-8?B?UjVJbmJmeGJzL2NxRGNIVnRiem1ZK2ZaWGwvdGlTbHc4YlFUMnJ6TFpHdjJH?=
 =?utf-8?B?UVZGbitYTEZGWVZTamZhUTNmU1NjWnU1ME1KcDZDNytWbUUwdytHY20xQzU0?=
 =?utf-8?B?T0UyRjRxYi9NSlJKODBNVUpQajkzT1J3NTBMRTdodHJRVVZlbFB1VTUwRHBN?=
 =?utf-8?B?UjMwSVhmR2dhendEYWpIUmk4eUorV2lFcml3TWtYUHUzbE52RTdLZHJhREZk?=
 =?utf-8?B?dTJrdkZrNUg1UlkrVFFLV2xDd0lKM1UxYkJFYnhLVldrREJDcHZ2UFFBczFw?=
 =?utf-8?B?WWVyenJ0b2ZqNUI3T0FKSmxuL2pValhmS1V4blNYcTFwbW1IdDVuRU5aMmZX?=
 =?utf-8?B?ZHc4SUVYRG5mS2NYVmswZFZ2SWNiS2lYcVNBdkowVC9XbjZ6UzVEY3pHblU3?=
 =?utf-8?B?Y0ZuaEZDYUtBVkpuNVFBQWdERTYrbnhUVVd6dVBtWEF0S1NSdEtpY2pveUNK?=
 =?utf-8?B?VktWRVBYbFdwY3pTbklReXFyVk0vTGZZeWxqaVJ0RWovaDhRNDlQZ1FEbFNW?=
 =?utf-8?B?a3FwZGRDRFhWc04rYzcvelU1NDcyaUlGbGFCR0M0NGVtK3ZQZHQrYzJnWERD?=
 =?utf-8?B?UmR3bHlHaHAwVGttWFJxekcvMmlHR1owUjhwaTVnT3VhTjVrd2xLQjhWNXlM?=
 =?utf-8?B?MUcyMW1ELzRJWWgwMUwrU1JWTnVuWUE2dm1XV0x4Q1BHYlBVak9id2daQUpw?=
 =?utf-8?B?ZHVvTUdXK3dXaFNjY1pWOHM5SCsyeGFUK2o0azlvU3doUlplcHZiZDhHVmU5?=
 =?utf-8?B?UUh4UzJYNVB4NDlyVWY0b2NKOXpJRmYvczhkYUYxOS84MUMxcmlkVGgyTUtr?=
 =?utf-8?B?S3ZuS3dVTkJZUDNXdnBjaVgwWHpYdGM3WitIdGdIUlMxdURWRGRvTXVMc3ZF?=
 =?utf-8?Q?gRHhb2PXfd82i+/qXfanyH4yb+EPmxTo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1VpS2J1enFsNmZHcUVvTlVnalFrUnJ4c2xzSHZNUFB4Mk5mUnU5NldEL3FY?=
 =?utf-8?B?MDJoREJkYVZtWGg4RVpxYTR2anZXRmd3SHErYzl5M0dYbCszSmt6cTN0QkVl?=
 =?utf-8?B?TmQwejJHeG43RmpjcnRXRkxvN1FhZ1gvMXZmczlxaTRTUHE0Tk5rYkN5UVhJ?=
 =?utf-8?B?djN6N20yQ2prNXBjbFNqV2RaVjN5S3RiaWZrS2hubEZ1NVJNWjE5TFJ2L1lE?=
 =?utf-8?B?Q3JodnBEaHk1ZEw4dnMrWjQvNzM4Yld1U25jWnZPM2JHTFBhMGltYTRuZVRI?=
 =?utf-8?B?VGhCV3JzN09VQldiWk9BMCs3aGVQRFJlYVJXUE82dWhROWxIRTh0S21vSUZ4?=
 =?utf-8?B?Y3pUVUkxWmxSQXM1S3pYblFtRGFhNzNTZEVKbjFneEVCZE1UM0NnN1hIRnpV?=
 =?utf-8?B?MER1bWJoMUFERWZyaFRMUVl1OXdQeW1DdFR2U0JzUFIvcmJpdVFXb21sR0Yx?=
 =?utf-8?B?YmNDZXZKMjVFQ0tzdGQyN1MrbnZTWnY1bzVHV20rVGM0VERMRHpMVEpDVUhl?=
 =?utf-8?B?cGdNUldJMzZrYjhoQkhGbkZrczdkV3B3a3p0Q0hKYmpxd2JuL01aOU9TaEts?=
 =?utf-8?B?TSttQWNFVVVZeHVjL0ROQ1JRWktXSmNPUEhpZ29DOXlRenZKNHFlZTdNcjlL?=
 =?utf-8?B?bHJrRStueURNMHQzK1p6azNWUlBveFFPMDlFOUx4ZHk0dFlGVlArYVdPQURC?=
 =?utf-8?B?UmUxbVdlM0FMcVQwbGZPVkJXWERxK2hqc0t4eHZWejVlVms2WDd1NnlDQTZI?=
 =?utf-8?B?Vi91Y1RHaWgwWFRFd200S3p4V3lVWkxEcG84dWVNajNVLzB2MVJrdk0vVkN1?=
 =?utf-8?B?RE40R2s0dC9FSittRXpiR3EwNVMxVUV6ZWl2blY4U3ZJSGMwd3NydlNxWXJH?=
 =?utf-8?B?TDh6ZFpsTEcxRzBla3oyU082NjNmdFcvdnBjaEtDQkk4SU1KNWdUVXBrMFU3?=
 =?utf-8?B?Q1g1Ykc3b3hHU0JibWhLaUhuOXdrdlV1ZnIvSHh3eDdHRk9xZnIvbDhSZ0hM?=
 =?utf-8?B?WlpCTGk4YVpobmVFZkErbXFLeGxlNHVnQmRReVV2NzNEVmlYNHpqZWpMek1h?=
 =?utf-8?B?cG16K09JZkxpSkFCQ3RFaDlGdUpyWmVZRWV5bjl0ajVCZFJPWjBDVWRQa3JV?=
 =?utf-8?B?aUtoQ0FOc2VmYkd1blRZWVk5Q2htVVhnS1JURCtoanNURTQ4RzdMS1FCcVJW?=
 =?utf-8?B?TmF5TzJhb01wdUV3OEo1UWZabjVSaHRtOFlxcWVIT3dxOTFOMWppZzRmWmRa?=
 =?utf-8?B?alpFSEZxdU9NeHNHTk9ERWFNWGlvVGRRTFRLVEJBTHVUQldmSmZIUFNCd2Vs?=
 =?utf-8?B?ZDNWMExqbHBzTzdtQVd3Q09CTGxnV2xqNEdYQVZQOHZOMVpqV3VodmUyUzhU?=
 =?utf-8?B?K2N3Y0I4cjVtaUlteW81K3hXUlFjOXVYZ1phUi9jM0lRSkhBMmQ3cWZsTzBC?=
 =?utf-8?B?TFNTbmVxeEhJWURGMHZpbDc3WmUxZzZ2ZWg1RTBvK2xvelh3cjQ0MDNRY2F0?=
 =?utf-8?B?dmtCRFpBYVlYWGRSNVczMVlXcmp5OEJRdkxpcS9JbFRjY1NBaE5ubzRreC9X?=
 =?utf-8?B?ekxyUVBTWnpNYk5pVGxabGRLa0w3RlFFZStobzBuUzZiZTVFTjBBWGNWTE9V?=
 =?utf-8?B?SFZwL0cxRmMyYWpXcTBIZ0w1Vjl0dGJRaGFpSFJJWVhNMVZEdm9JWU92TTJL?=
 =?utf-8?B?WGRuNWVLbzFoMTgyTCtNSDMvZzNNak9SeWRtODFac0hBTFJyNXduV2xmUWQ0?=
 =?utf-8?B?VGd0U2FXbXQ2NHhHNGcxb29NVnB3V1ZLbkJtSWovWm45R05kTGVNWnZOTW5q?=
 =?utf-8?B?SmpJUlZJWXFZQ1hoU3huYVR4L1QxRmJXZmZlRnZyTHg0RnJndW1iUWQrRXph?=
 =?utf-8?B?emVxdDk3MjMybWRMT3ZCTGVHREhuWHV1c0dZQ1MzakxtVzVyWm1rVTdUd2Vq?=
 =?utf-8?B?dGlmS1B5VzJlRlhiaUNzZzJwMWNUdXdTaUhIWlBKcGY5dmRPbFFFQUIydXVV?=
 =?utf-8?B?dFNXY2NYOVVKb2s3QlVFWmpTOTFaZjNFYWowZDQ5dThqeW8xaWxtTUl0UlJo?=
 =?utf-8?B?SDhwNmc2cVF4elhJaEdUaG9tcUJPNHU3SlMrSS9MUWNwZGxqN1ZTQTJGRWZD?=
 =?utf-8?Q?5IJst1HAgWo8A6EN9q6LfkWJm?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33633b8b-2499-41a1-c175-08dd581b6d1f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:14:57.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+2boAV+RHVO4MuAM/vnfoW9lMVeHsm21rq4CyPEhqTdGKXS0jBwje67oqiVWHH4WYxUCKKEJ1iWz5y8SBHB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-Proofpoint-GUID: RLp5xNZYsiTlVxi-bCFJEhN7TKBWlGIh
X-Authority-Analysis: v=2.4 cv=BptnwZX5 c=1 sm=1 tr=0 ts=67c1ef14 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=_bZ_Ugej2YiJM_EvIRMA:9 a=QEXdDO2ut3YA:10 a=CJgG61vzA6yyTBTLYZUp:22 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: RLp5xNZYsiTlVxi-bCFJEhN7TKBWlGIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=824 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280126

SWYgdGhlIGRldmljZSBpcyBjb25uZWN0ZWQgd2l0aCBTRElPIGJ1cywgaXQgY2FuIHdha2UgdXAg
dGhlIGhvc3QgdXNpbmcKZWl0aGVyIHRoZSBTRElPIGNvbnRyb2xsZXIgKHRoYXQgcmVxdWlyZXMg
TU1DX1BNX1dBS0VfU0RJT19JUlEKY2FwYWJpbGl0eSkgb3IgdGhlIG91dC1vZi1ib3VuZCBJUlEu
IFRoaXMgcGF0Y2ggYWxsb3dzIGJvdGguCgpPYnZpb3VzbHksIHRoZSBTRElPIGNvbnRyb2xsZXIg
bXVzdCBiZSBhYmxlIHRvIGtlZXAgdGhlIFNESU8gZGV2aWNlCnBvd2VyZWQgb24uCgpTaWduZWQt
b2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0t
LQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMKaW5kZXggZjI5MGVlY2RlNzcz
Li5iZDhlMWZmYjYxYmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
ZGlvLmMKQEAgLTE0LDYgKzE0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4KICNpbmNs
dWRlIDxsaW51eC9pcnEuaD4KICNpbmNsdWRlIDxsaW51eC9hbGlnbi5oPgorI2luY2x1ZGUgPGxp
bnV4L3BtLmg+CiAKICNpbmNsdWRlICJidXMuaCIKICNpbmNsdWRlICJ3ZnguaCIKQEAgLTE5MSw5
ICsxOTIsNDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NkaW9fb2Zf
bWF0Y2hbXSA9IHsKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCB3Znhfc2Rpb19vZl9tYXRj
aCk7CiAKK3N0YXRpYyBpbnQgd2Z4X3NkaW9fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCit7
CisJc3RydWN0IHNkaW9fZnVuYyAqZnVuYyA9IGRldl90b19zZGlvX2Z1bmMoZGV2KTsKKwlzdHJ1
Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzID0gc2Rpb19nZXRfZHJ2ZGF0YShmdW5jKTsKKwlpbnQgcmV0
OworCisJaWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKQorCQlyZXR1cm4gMDsKKworCWZsdXNo
X3dvcmsoJmJ1cy0+Y29yZS0+aGlmLmJoKTsKKwkvLyBFaXRoZXIgIndha2V1cC1zb3VyY2UiIGF0
dHJpYnV0ZSBvciBvdXQtb2YtYmFuZCBJUlEgaXMgcmVxdWlyZWQgZm9yIFdvV0xBTgorCWlmIChi
dXMtPm9mX2lycSkgeworCQlyZXQgPSBlbmFibGVfaXJxX3dha2UoYnVzLT5vZl9pcnEpOworCQlp
ZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwl9IGVsc2UgeworCQlyZXQgPSBzZGlvX3NldF9ob3N0
X3BtX2ZsYWdzKGZ1bmMsIE1NQ19QTV9XQUtFX1NESU9fSVJRKTsKKwkJaWYgKHJldCkKKwkJCXJl
dHVybiByZXQ7CisJfQorCXJldHVybiBzZGlvX3NldF9ob3N0X3BtX2ZsYWdzKGZ1bmMsIE1NQ19Q
TV9LRUVQX1BPV0VSKTsKK30KKworc3RhdGljIGludCB3Znhfc2Rpb19yZXN1bWUoc3RydWN0IGRl
dmljZSAqZGV2KQoreworCXN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBkZXZfdG9fc2Rpb19mdW5j
KGRldik7CisJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cyA9IHNkaW9fZ2V0X2RydmRhdGEoZnVu
Yyk7CisKKwlpZiAoIWRldmljZV9tYXlfd2FrZXVwKGRldikpCisJCXJldHVybiAwOworCWlmIChi
dXMtPm9mX2lycSkKKwkJcmV0dXJuIGRpc2FibGVfaXJxX3dha2UoYnVzLT5vZl9pcnEpOworCWVs
c2UKKwkJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUoc3RydWN0IHNk
aW9fZnVuYyAqZnVuYywgY29uc3Qgc3RydWN0IHNkaW9fZGV2aWNlX2lkICppZCkKIHsKIAljb25z
dCBzdHJ1Y3Qgd2Z4X3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKCZmdW5jLT5kZXYpOworCW1tY19wbV9mbGFnX3QgcG1fZmxhZyA9IHNkaW9fZ2V0X2hvc3Rf
cG1fY2FwcyhmdW5jKTsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZnVuYy0+ZGV2Lm9mX25v
ZGU7CiAJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1czsKIAlpbnQgcmV0OwpAQCAtMjM1LDYgKzI3
Myw5IEBAIHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUoc3RydWN0IHNkaW9fZnVuYyAqZnVuYywg
Y29uc3Qgc3RydWN0IHNkaW9fZGV2aWNlX2lkICppCiAJaWYgKHJldCkKIAkJZ290byBzZGlvX3Jl
bGVhc2U7CiAKKwlpZiAocG1fZmxhZyAmIE1NQ19QTV9LRUVQX1BPV0VSKQorCQlkZXZpY2Vfc2V0
X3dha2V1cF9jYXBhYmxlKCZmdW5jLT5kZXYsIHRydWUpOworCiAJcmV0dXJuIDA7CiAKIHNkaW9f
cmVsZWFzZToKQEAgLTI2MSw2ICszMDIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaW9fZGV2
aWNlX2lkIHdmeF9zZGlvX2lkc1tdID0gewogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUoc2Rpbywg
d2Z4X3NkaW9faWRzKTsKIAorREVGSU5FX1NJTVBMRV9ERVZfUE1fT1BTKHdmeF9zZGlvX3BtX29w
cywgd2Z4X3NkaW9fc3VzcGVuZCwgd2Z4X3NkaW9fcmVzdW1lKTsKKwogc3RydWN0IHNkaW9fZHJp
dmVyIHdmeF9zZGlvX2RyaXZlciA9IHsKIAkubmFtZSA9ICJ3Zngtc2RpbyIsCiAJLmlkX3RhYmxl
ID0gd2Z4X3NkaW9faWRzLApAQCAtMjY4LDUgKzMxMSw2IEBAIHN0cnVjdCBzZGlvX2RyaXZlciB3
Znhfc2Rpb19kcml2ZXIgPSB7CiAJLnJlbW92ZSA9IHdmeF9zZGlvX3JlbW92ZSwKIAkuZHJ2ID0g
ewogCQkub2ZfbWF0Y2hfdGFibGUgPSB3Znhfc2Rpb19vZl9tYXRjaCwKKwkJLnBtID0gJndmeF9z
ZGlvX3BtX29wcywKIAl9CiB9OwotLSAKMi4zOS41Cgo=

