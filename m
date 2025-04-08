Return-Path: <linux-wireless+bounces-21231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98DBA7F32D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 05:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D1C3AE92B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5306025F786;
	Tue,  8 Apr 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="GyjoTfW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B974A1E;
	Tue,  8 Apr 2025 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744083002; cv=fail; b=Tomo1dv0FGCFpQDc6pX8rByZxlr/zHyLCZnlYtuScZs/1X+BlNBzQpT96aZTMQQY528pjP3edWhNs5R3/gDkW1UtY4pp4RMSjN4qGGSiTTV2jXSYsBtN3r4UaL/9Lvag8O3XxyRChB3HIFkMJArEWbJucKxgDJqUWKEZJVBQImE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744083002; c=relaxed/simple;
	bh=voM97n65/Wf4zFrwAJ7A1uQQSJsiC1g0INTio54kqaM=;
	h=Message-ID:Date:Subject:To:Cc:From:Content-Type:MIME-Version; b=oq/bDB15cDxlf/YDVv3fjsrP53jpG6AhxPB2ZjRXTidwgjTiTN9uBA1TZcvIkeKHqsbhOf/5w9dHm2MXXTxeEW4U2NF2NtZC02aNRBMielPYpYvwI/J/1WMrt9akTMwPCgFWS3Zf4WdvUyzORCveKD1S+MeBizMOEsFaNHQFBdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=GyjoTfW7; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLxfExbRnlpDR7jWZ591jzvgiT4y0ni0BnNtu4pIfBiSk5UytISWwuaxIkMDztqu0NoI+TLgJ11pStNvD/I6+09W2cQ8eVXdZkWBRv6Rms4L4MEOTr77U2pIAvBkHztclI0T20zbHoroJbg2ILbBJNEATb27e6ePlrak8CAIQ9AiMzNwDLrafBYg/4ABxRbeJIHmzLZGqY38pAaKx/jxigxc07X/ORNDM04+YU9a3QU/fnvm52CQpeX3t30inhNBfw+ApWLJtRW3HWbSSlrp65vE03KHja1oEehQictcIkcHQsYQghsz9GtrNmEUZD/bgO5lVsCh/XKqYbOhUe+bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edQuTrgNpsYbsWpN6x7iJvAqkygVQwmFoSs3S/K8uC8=;
 b=Co/+c8JEWKnCqFgsxfHtWB5bRWGMMNFs47OlXTUTFcnZF+UvjuwsxHafLgL08mKGFdP9wiezy/qNLqu99vtNYzSYFi+LiVzPYpoIo/JSpqzKcdpIkUw6+yFeK0AZxMGNHWq2/a5FQfUdQJOXkWzKZ1hVjfNG/lh7CTHShGk4em2b8TzRvmdbBd5b05fjvd4ZlqksCYgzvfjIVNGjpzJ1EzbCdojCzNRzpDSiDcPcnswPZDKuou6h16EWOh/P1U1N6JnkcMSlaf+uvuIcM0VNFf2P1rJJYiEaNwKVmqxSrcyN6aO2QzxY0pQrzPgvTBOabb1KdNmWrggyk9SFccIW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edQuTrgNpsYbsWpN6x7iJvAqkygVQwmFoSs3S/K8uC8=;
 b=GyjoTfW7xuKHRvLex5CoNtEzl+XaSjPvhRRB2mmvnRoAuVjUdXqyady+Q0bKXSjFZT493u4otDu8lTX5ZR0Ye4ba7bxrSGMhiLwUTQSTw7lKF61pJeJaJNVZY2nFmcs9B8OiMJqYp1dK665G15b8TeIX7XCMSWYbPTHl0/DqTodekNVnc+K3bnYdGPOpBGwSUewj1P0st/MbFsCa77RbvNhNTA/RmrMDvJCdfZoj1cfE8jEdAg56z5K6Mqrhoex5pRk4jfch6HQXgsQ5z9e4PCqD65r4eA9E0oKZspOZnIgFbldrNcn8g0aqy2vN9wSGNLa11MSKO3b0Xtnf44n+GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com (2603:10a6:10:1f0::11)
 by PR3PR07MB8131.eurprd07.prod.outlook.com (2603:10a6:102:172::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 03:29:42 +0000
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5]) by DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5%2]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:29:42 +0000
Message-ID: <b7651a17-afeb-4abd-ae23-29a85a2f6412@nokia-sbell.com>
Date: Tue, 8 Apr 2025 11:29:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] RE: [RFC -v1] wifi: rtw88: sdio: Tx status for
 management frames
To: Ping-Ke Shih <pkshih@realtek.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Zhen XIN <zhen.xin@nokia-sbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To DBBPR07MB7481.eurprd07.prod.outlook.com
 (2603:10a6:10:1f0::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR07MB7481:EE_|PR3PR07MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 09619ba0-89f7-4bb9-2722-08dd764d99b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEtkeFRYK0QzZ2cwOW1VVHBxNkwzOTZpaEhiK3lqN1ZESm1PdytuVG1kS2py?=
 =?utf-8?B?VE53a3c2azFYRUFZci9ueDdGTWxOSDdGc0xQc2s0TlJhYjVKZXVwVE9Uc1hp?=
 =?utf-8?B?N0VpQzFtMVVkaVhGdCt4N0xTVERMSU50Mk9vWTl3c3MvR05QcTdxcDhmMFpS?=
 =?utf-8?B?TGhzSDhMSjAxd3oyRmQraDZtR2ZnRkJKOHVBSU5zYzRJem14YTRydWxCVnhl?=
 =?utf-8?B?R1lHayt5TU9idGtMOEo2eHZMTjkyTnF3QmF2UFRqOXBOd3pyR1FTQzJiRThH?=
 =?utf-8?B?VUZhcE14ZG15WkRnRzViVElMdUlMOXhlYjA1Vk5QVmE4MEMyRzVCSFQ0eHZ2?=
 =?utf-8?B?SDE1UTlheTN0TGphdklJNmJoM3RKZjhRN0ovUkRkQkc2aHNwT3JiTW1nWmtZ?=
 =?utf-8?B?V0VmNFYrMVZ2TktGcGJYSndlVHJ0bFhmdjN1MmNJS0VIUzYva3pDczJTa1Fk?=
 =?utf-8?B?RThCenFSUDF3YklZenBBd29oWm4xRnFFcFk1Qlg0SERBNHJuNkZNbXRxd2pz?=
 =?utf-8?B?UkxJUFNUUFFRNDFJS3FCdytrSE5XSXVZbTJxVVhRMXM4WVRpRllSbjdmcHhn?=
 =?utf-8?B?ZU9aemZ2aHpjRWNjdHNNVHNjN05ybHNwdlpFWEt3SUFScWxBcXd4aTVPY3kr?=
 =?utf-8?B?ckZueUJzYml1TE14K1o4NGMwcVcxZ1lYWGRnb3JHLy9ZRmRzdzQ5anNVaE1O?=
 =?utf-8?B?WDljN09NSjRiZ3NLSE9hTUIvQzhTNlJRWVlFTUFRM1JRdlNHRXViQ2VuVUh4?=
 =?utf-8?B?aGppN1lKdU9Jd0xQME4wQnA4SG1uYU14aXpSOVFqVStTcHAreGUwMXR2Wlg4?=
 =?utf-8?B?bEVNSXpwYmo0czN1OHVxbkhWTEZKS2J3UWpxVHEzZ0t4OW1ONXpBY25sQWFr?=
 =?utf-8?B?RUtxK2RiOGxUTXNKamNWL1RiaE52bmwreTN2aFRlZzNaTjk2RnhMT0tSNEFu?=
 =?utf-8?B?Qnl3YTRORzhlT05LeGtFUkhaWElEN21MV0czV0RwdFJTY2JRSUhyS2ZYUHFD?=
 =?utf-8?B?bWJQZTZGeHo5UlhCRjYrNnFydDVVeGJZZndlVitRY292ZkRXcmlKSVJmSm9C?=
 =?utf-8?B?dDc4WGwxTHB2dGZ1UE1QRm5PRjEvZ3FDMmtqaHMxOEZ2c0RaakMyb0VRbklt?=
 =?utf-8?B?ek5xTnRGRmsxVTR0a28vb2hkK2NxWmIyTUpQQysvUEo3R1dPTytqcEJ5bGxk?=
 =?utf-8?B?MWVnZWtvMGQrcmVycDhZN3dYMHdHeHFzRHB6dzc3M2tndEhmZ0MxRkc2ZGZv?=
 =?utf-8?B?M2E3L09pWUcxRmpvSk5vT3NGTXluNnJNTEhGRXR1VGxtdnVubHZPQlFpYkpx?=
 =?utf-8?B?eVFtR1FUZ0FmZEFDSU1ybkRuVXRvTDZsUFdOVlVML2hpelNOKzZjRDJzQ3U3?=
 =?utf-8?B?Y3djU1Z6Q0xwQVNVR0R5UW4rK0tGeDFWYW43MmduRWtEeFZpZEF1Y0ZlL3hQ?=
 =?utf-8?B?NHFLNjJMVCtaS3JMZzdFMnhsa0Z6WGdsTVpYRDFRTjRMVmVTRERQbWRUd2dP?=
 =?utf-8?B?OFpUZU53dmNySUlGVGdKVXo2cTcyS29WUmhBdHNLaStlU2JSRmpkU20yaWlj?=
 =?utf-8?B?K3VpVzNJc3FEL3EwTTJWSk9nQ0NjOE9aY2pzaWFQc1pGd1N3WDdsTjE1WHVy?=
 =?utf-8?B?QkZXMmZxbU9sd0VSdVBTZ244U2pnWjhUTEl2bDF6Uk1EVHJ2NmFYN0w3VXVm?=
 =?utf-8?B?QTlMdUljdWt5Smg3a3FBYm1xUGE0bUxqc2NyMnFCTW81LzNBbDRkQW5rQUZ6?=
 =?utf-8?B?dmRrYmg5YlF0YnFaWHFSV2xTZStUL21MZldpZ0dXYkdIZDk2Sk9MYjZHbEZj?=
 =?utf-8?B?NHpuM0R1ZzFVYnJ6OWFwNitOOHZTVFYzUmhnZjFrUXNkZVF2NG90SmsxUHRj?=
 =?utf-8?B?VE16OFNuQmcwKzdMOVNJbUxoZmovejZBZVZFeHZmTURwR2NPYjVwMzV1TUkr?=
 =?utf-8?Q?anOGQjfvxi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR07MB7481.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnhuclQ5YUF4b2FGREpXMWZOL1VKeEhRRGJTZTJGRVZBek5oNUpCZDZ2d2pL?=
 =?utf-8?B?Q2dNenJveEVZdGkrTWNVd08vbUw2YUdNd2xweHNpb1BRSG81dUV0RWlxd0hP?=
 =?utf-8?B?MjhKa3VvNURrbER6TDZuV2RFOWZGL0lMQ0tqQk5tQ05FMzhndjE0V01EaGRV?=
 =?utf-8?B?aG9jbzZNS2o0R01kVHpYc0hKbnB3T2hpNVdSWDhyYmhiUTZ3RVI0N3ZpaE1F?=
 =?utf-8?B?Yk0zK1pBM3R3c0dodFl0dVcwMFQyR0xnRnQrZWNYYnVReW1pVjdia0ZqOGZS?=
 =?utf-8?B?TDZUOVVZVlM3Q08wckVQckdReG4xKzJQM1pnNkJ5WkdJcUtxZzhVY0xxd2Uy?=
 =?utf-8?B?U0R6WjVHNFNVRTZDY2xNSkowbDhuNTQ1ME5iMFZvdzc0QmV6andSMXRqbjIy?=
 =?utf-8?B?R1NNUVBQaDh2Q3JzRzZiWnY1NTBBY2ovS2lyK2hEaTJtMGRtRXlNRjNHb2Jx?=
 =?utf-8?B?M1dmZFZpTmFIYk9sa2dCTjFZS3MzQy9ndjRHMEZDS1RxNFZBczN5WmFsRXd5?=
 =?utf-8?B?OGxDazlGdGlLTlhiN3pERTlNY0hEL0pmaFhRaVhjbHFXenpoTFNuRnlSbnAv?=
 =?utf-8?B?cm1hdGRJd3hmVzZBNTNSMW9LcDdZL3pKVjNDaVdUZm9aYndnQUtKWUQ2bWJZ?=
 =?utf-8?B?Qlh6bHJvejRQbzM1azNSUG9sUUZmUHplMUZnQmhuUVJaYkNUSXhQZCtmTDFM?=
 =?utf-8?B?Zkh1VGFLMG9Tcyt5Z28zdVR1cTl4U2NtM2UxcHBDZmZWUU5YamMzNjc4c2J0?=
 =?utf-8?B?SEdEUEdxclI2WWlmSmpyKzVhY2Z3VWlFQ0YvZEpZbG95TWdLMmxIODQ3ajJC?=
 =?utf-8?B?dVdEaFZXVkY0Y1FvcStCdEg2ZTVjTnJwdDdNTVB0K0xXUHNQR09wTnUrbE1s?=
 =?utf-8?B?ZDdGc3JZcWdRK1hzVHdwb3hXeWF0UExTSnMvSG1kRmQ4Yy9RcVBOOVMyMVgr?=
 =?utf-8?B?UnBmOVRmd1ZucE45U0pLc1FxUHFlU3QweG43NWVxcW9IMy9zcU5YQndCelhI?=
 =?utf-8?B?WElQeVJPTW9MVE5UeFpJTzlxdGdCY2VXTm40bGpmUWVENExoNVlEeDZWdU9q?=
 =?utf-8?B?Z0pSSXFkZ2kzSWxtZWd5RTNGTG5ZUUdKZkRjYkdrV0gzb0VDdVpVQmIxQU1D?=
 =?utf-8?B?Z0YwQXdNTUtCc2NKaUdteWltcW91NXRUcHJlYW94d29BRG9yeE5zd3VDYXFE?=
 =?utf-8?B?RXJEZEpiY0RRanRtWWVna1hIUTZ6YTBPU01RbDNKM2FSVXZGc2JYL0RNWjNN?=
 =?utf-8?B?Z1N2dTBramRVTkhEUmp4Wi96L2R4R2FKcmlITFlnbS9rblBiQ1c5QTI3OHZj?=
 =?utf-8?B?WlI5bFFURzZ2TDdOcEpGNkt2N0lsbGtkWnlaNUlOUWRVdnpTMFZPdHYwQXFM?=
 =?utf-8?B?L0xzL0lvYnBYc0pvakZXSWNNZXg5RHBzOURJMzFVeVROdmRwZXBLeU1RTTVT?=
 =?utf-8?B?bkgzYWJxYkZnNEdQOWRPSnR1NVd4UTBKeHdUUER1cGVIMnROZHI4VHl3Q3dH?=
 =?utf-8?B?by9OU2U4Y1FzaUo2S0JlMkVCK2JVS1JQZmFIMlM1c2FSczR0VnJQYWVUbFhD?=
 =?utf-8?B?NVFSSXpKVVdVV0J2eDJ4dFM5YmdUMm9lY29XeVJ6THdRc0pJbDh6QjBJcEhp?=
 =?utf-8?B?b0VBQmVEOHJhZ1gzSUl2NEVhS0VveUlMamdpUEkyWTF2NUZUajRLZWJsYXF2?=
 =?utf-8?B?MzdsUVNsS3VITC9YaWNUZm9VOExrZWhEQmVYZ0dxekFXdnkrZklucnFLR00r?=
 =?utf-8?B?MFcrNXlnUWM4Q1BaVXZRVlpJakVKWUpoRmVFQXdtLzlvRG90OFMrRzFpb2FT?=
 =?utf-8?B?SzZnVFUwc2x5Q0V3UHlUdmxiUjcwVVVUcXFKRDFFU2hNeFNRaWFGQzZqWElG?=
 =?utf-8?B?dlJETVJ4RzNpRWdha3g1THN4S1Rnak9EanJ3M29zN0RjSm9zMXJaVE1PY0t5?=
 =?utf-8?B?eUpQUGlCdDBPQUZ3b3d3SHRKYk8zeHlncjNmS1d6eXpBUFF5M0dxU0pCemZC?=
 =?utf-8?B?NVBiWjFMZnlKYlhoSE8zMnArRFdIQnJJRjFlcUNwR29DS2crcHRMTHAwTzFD?=
 =?utf-8?B?L21tT2w1RkZrbnoyVEVGdXA4VWV0SGRXd0F5MHRFdm5Cbm9XYVF1Y3hDYk9V?=
 =?utf-8?B?MmlpbXl1ZmdXSWlURVBXLzZVZk45M05vK2dvb0JsRnQwSXRLbnpkUGE0TzJh?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09619ba0-89f7-4bb9-2722-08dd764d99b0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR07MB7481.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:29:42.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qD4QYZZ5gHBOzpdXn3b4FnxCRWmt2o935QNoLQv7Wh04C+zd3VeJzvOAWrvc14ys3A+EEeHfvNWalL7Z1ctznBNpU0uWSdArVnFaM1l9NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8131


On 1/1/1970 8:00 AM, Ping-Ke Shih wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>>> @@ -1195,7 +1195,7 @@ static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
>>>>          skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
>>>>
>>>>          /* enqueue to wait for tx report */
>>>> -       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
>>>> +       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS && queue
>>>> + <= RTW_TX_QUEUE_VO) {
>>> Is this because you have seen "failed to get tx report"?
>>> Have you tried to increasing RTW_TX_PROBE_TIMEOUT?
>>>
>>> If it still can't get TX report, we might take this workaround with
>>> comments to mention why we need it. Or a local variable with proper
>>> naming to point out this, like
>>>
>>>          bool queue_has_no_tx_report = queue > RTW_TX_QUEUE_VO;
>>>
>>>
>>> By the way, USB behavior is very like to SDIO, but TX report seems to work well.
>> On my RTL8822CS I can confirm your thought:
>> I don't notice any extra "failed to get tx report" messages regardless
>> of whether I have "&& queue <= RTW_TX_QUEUE_VO" or not.
>>
> This workaround might need an chip attribute to enable then.
> Not sure if people in the GitHub thread have experiments on all supported SDIO WiFi chips.

On my RTL8723DS, without condition"&& queue <= RTW_TX_QUEUE_VO", there 
are messages in the console:

[ 23.298425] rtw_8723ds mmc2:0001:1: failed to get tx report from firmware

Ever after I doubled the RTW_TX_PROBE_TIMEOUT (500 * 2), there messages 
were still there, and AP mode didn't work:

root@OpenWrt:~# iw dev phy0-ap0 station dump Station 04:ea:56:2f:6f:07 
(on phy0-ap0) inactive time: 480 ms ... authorized: no authenticated: 
yes associated: yes

Seems tx status report didn't reach hostapd.


