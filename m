Return-Path: <linux-wireless+bounces-33847-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLz2CUnrw2kAvAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33847-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:03:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 641453265D2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D885930AF111
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92D3DB63D;
	Wed, 25 Mar 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mITBucTH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848253DB629;
	Wed, 25 Mar 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446461; cv=fail; b=ipC6DyM3hZj4eP8m4OO1+ckaKE/CxrXzJGmrH66XF0bBDXeXd73PrkOEAiw5rZqMT/peBSZoYCC9gH+TnxTbNMxTol+76aJTlQMsJVylOmnYJTkqQgcSRwvOv1uZcQhS9XZhqBAYh7GpqOvhrbRhsey5XdzRLlZpO/V/AXGaIWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446461; c=relaxed/simple;
	bh=rKadq3qjmK7RhWYGLIQ0MpIWRDNmZBcYYQ8GpklwvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iumjrWZn/FYmaZBVrdBxUOA1KVpl2jsIuBTjxQFHU0Xq1jWo8mT2WUGOLbP0oIdDTcKjABC95kuFJ1/X4YAj5vQW0mnWp1QIQ2STjVUA/4ThajC/OW/1WnaycUjNNyjhC9V23af21c7U8w9BOIsuBmrZAiyBaIW9uRBZ/m978KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mITBucTH; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgrScTlScd0I44gi7qs1IL4MxfNGGf2oVbDkf+KbnLbXUR4uwRPNcUWc7mhGPANTU/KW3tnuRaLo+4UQDZWKxH2L4a5t35GubH1VtuXg6klsQxDTvPmZYSi9Jx4at5cvkvZjNYX/aIrEzFlc7oGsXvGC68xvqS2xoS9ykeym8dkyfliCbkxixJytDL35iR8XOF5pe3YHsm0rIRjHM3hwLeMsIopGmoCdVOijI785keFBmpVVSAV7p+HThWGl6dYLRooUuagsbAECi1x3cgevXxawXlJ8XmR6Rk+fXHJPJeJyvJtU32g+feGPj+CuK7GbuYOL9sqPJ6+y9kP8GD+peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jls07QZMHZBaZSKk+Cm+2n6m2wqZaLkCt6j2Ewi5f/o=;
 b=W7bHaYJm16s8Act46ZbNL2md1UK0IAZNsntjH1fBtRqbb787ztUUyjb5QB+gTLC1pddQ5fULF2oawRNTHWWJILPjMFay4o7T8FXEjDDOcXNYZ4ZZ6gTOW2DPxBwfMtJbDoWQ+rorBZ79ix9xkXA+77Vh27BT/viaDiBCYORep0M+aIUAvbFScB1//RxtsnhTwwIj/dIKdQfzGPm4B5j7/0IVQUNNSvM50QuTcOCC3s9IcxN0NnHMspD9k+yaJJwBRxshQrvxQDjpT9WFRnSr9WAVkL7BD2ApQcRBkIUo76U5WqFnroInruR03ZQ0XvsU8XaVjbku+4slil+8SJnatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jls07QZMHZBaZSKk+Cm+2n6m2wqZaLkCt6j2Ewi5f/o=;
 b=mITBucTHjvCSjXA01v75VQxXsiJEMfgasmmlq2TBe2DCXMp46xUydRONqrKnk5lmqtBhwO2ZSGCwKZnQMKKMITdKUmoJBwExl1WmQyzNh6Vg9CKZRVMYmij/JT6zzMFznQueMUu8yahHtvIRCGh9+4OM89pHSS7BCBZ++If4dcXqktJeo0vVZ18DVobdLW2YKtNGaKckNZmx/1YiMmPxqu0jH/ZiT3qmhz/8CEeTKWxWHAgHjSSiMDLraJHbZb+VSU+jc8nkKueFyGxO9suojdsr9cjAW1aaR4N3fSQF1ccOucBks09ZKksAZrHLCy1NCJf7dKPqBMWOh/d3UlirbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by FRRPR04MB12571.eurprd04.prod.outlook.com (2603:10a6:d10:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 13:47:30 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 13:47:17 +0000
Date: Wed, 25 Mar 2026 21:45:15 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v10 00/21] wifi: nxpwifi: create nxpwifi to support
Message-ID: <acPm666IO+nso5to@nxpwireless-Inspiron-14-Plus-7440>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
 <9b0144261da2ce7f5ef0a533928732cc43459e40.camel@sipsolutions.net>
 <abDh2mBYTqbhKz/H@nxpwireless-Inspiron-14-Plus-7440>
 <8ebc201c976f11cce4802e9e34c1f479ee190ac8.camel@sipsolutions.net>
 <abJ/qONShVDAuyhI@nxpwireless-Inspiron-14-Plus-7440>
 <075c9a062664609a81a722883ee17e7c728b08bc.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <075c9a062664609a81a722883ee17e7c728b08bc.camel@sipsolutions.net>
X-ClientProxiedBy: AS9PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:20b:497::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|FRRPR04MB12571:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b4d111-b413-461a-037a-08de8a750769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	IfO+ZiX8H00PtodHaMQEHWBHQVCb8ligLKvWJu9AZYpVlS8hkhMuf8HrfVnSjBC5/aTewQyGw7FUGM2WuY1cUpMVUQs1NADDU353L48qJYxyg7aBNStScOlgeDFJLa3O69FpnDeGiYQgWKVeERH7xMbWAkALUr6H/3mzvC4m4d23dsK3AqShRWVRJEA3Tits1GJZ00NCTAPRyDI5y7IYurePWHL5vNOaD6gaZwF3YFgaK4DSX1H1qvD63Nzv5y13gRLGHhyaRf8g498mpK+M9QdTYOwTGBxjqp4O4LCoTgyr6nw48k/Tj75dB0o0j5sAgY84/DTo7LhWld0+byuPD0wbyp5uubEMTi4npGVJfDNMs5kOpWFEoSnNn3wm2GgTMtFnB0ESwU0u57bPhnYwlI0J5RSCuIP/CfSdFiIqUa+530qjKs6npIEbsfGVSwHr9a/2T3BMJa7uckogvg0g9mGhjW+3XaUfN7D0/4OikXPC8j+ekV6LQgQjMdGxFJpVhpBWZUQ13xOPxTqnaEMNsZ6jt4NLZs9GTOFEFhHJoWiSOf4mKIlJ01a6bjwrA3/o+Vj1gdwDIFkz9bHkFyDW+xH0KCG4F+eETU6e7mR3xiCib0vWFUgzkeXSZZ3LJnJnIs4RPCatD5nPSS7eaxYv0zDbpvPXzDlS5dd9zCAw++VJIPByub+AvSqAxO1f53iCMbUy5/Qu/RTWgMLGXXJ5GqTcdslbEa3ZswdfpLOdqEmyNV9EFgY4BJ4FrZ9mgh6k/yxCM9ULLco+mVsUO74HUtpcfzZfkn2v1YC37+f8wC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHh6Y0VybTY5Wks1eUtTUHhzVXJ6VWI5VUxzRnE0OEkwV0kxc0xPZ0pGY3VH?=
 =?utf-8?B?SmNYTXRXSjRuM3U3WC9hc0lRS3dPYUhFWW9rdC9FQWI3ZnJDTW9qNCtKWmZm?=
 =?utf-8?B?eVc4RHBTOW9hakdTa3ZQS2ZrSG83RVQxTGJmTlh5cVNDckJDVUdreG9RYXU4?=
 =?utf-8?B?OVNJb3d1dURVZTA5VUFwQ2RyNVJmMVI0c28xdlpLTFF6cm9EbjhXMVZFQlNy?=
 =?utf-8?B?ZXEwSWplbXFjQjRLTHFJQVZFakZrUnQvNkJMREtIakxLVFkvdWdOZ0lxNmZC?=
 =?utf-8?B?YzJDUHlvRUZKMTgwS29HZStFYnA0b292cjBFNVg2YTR2T2J5QXJCM042RUNw?=
 =?utf-8?B?em1yQXYyR25oWVd5VXROMWM3RWtGOE9GeFVXR3NGZ20xMmNwMlF4d0dOSTJt?=
 =?utf-8?B?QVFGYjRocnc3Tzh5SDFCYXhac1g3a1Z2dENGcWpvNjBiTHJkLzBoTUNZZ0M4?=
 =?utf-8?B?YnR3d1Y0dGxqNUM0TjBibitsb2cwRVBTWkZkYy92cUFLMGU5dnM2Y3d3MUtS?=
 =?utf-8?B?UkR6UnpVZUZwTG8vWjNndUMrQ0VwYzNlOFRIVVJPRXFsY29qTjdibnl1TnZh?=
 =?utf-8?B?ZXJxWDcwVEN2WVVJRHo2R3hFcWxucWd6ajdveVdXcFNKTzBYVFlyRkN5QmZ3?=
 =?utf-8?B?MWwyN2F5YzVvd3FmWG9qMTAwUXc1VmhjZW9uTUlpQ0RJdStKZ1IxQUFITHNq?=
 =?utf-8?B?enhaeFZCN3BNNHZhaU9CMHh2elhVTEpmdjR0Z0tGWEhjWkp4SWtsbFBHcjNp?=
 =?utf-8?B?R0RSRUdUeXFXaS9naUNCcFA2OUxDV3dHcjV0VVhrdHNMSTFDSUt4a2xVMHhT?=
 =?utf-8?B?cWE3cENxd3djNSszdWdCdEJIQVovZFpxRWRMa2hnOE92V3BXOVltVVY1QXc0?=
 =?utf-8?B?VTZ4M3ZvcFFtV3ovR05GVHRhaUJ5TDFPdHRSMWo2cGNHU1dlZkZxRk1HSDRt?=
 =?utf-8?B?WjRUb1ZoZWQ1cHNUdEs4bndOdWZJdEhPOE52aHliQXFLNFl1cXdpcWRka2lI?=
 =?utf-8?B?UThINlpNSHc1djZzVVpXZTB5cG13RW5oL2NnY1ZUVERvYTg5cUhiYk5XRUlW?=
 =?utf-8?B?WHU0WVZjd0pTbmU0YkYxdDVDQVYyaVRpVlRJMHV4MmNNUzZ6NlpGbFNHajlK?=
 =?utf-8?B?SFJ6SkJhWUsrYTNaMi9FY1ZTU1hzZ0Q0U1BGWmJuUlV3ZlVxTlppczVmL3VP?=
 =?utf-8?B?bE9LczdEWVVveDdsVW1kcGlyYVpBNjIxZEQyZEV1NUdPUThYSGpScnorTlNm?=
 =?utf-8?B?MTZUdkQ3M2w5amhsTTh5Q01Kdi9DUlN5bWszSGpsbXN6OElVaFM5WGVwQXZ0?=
 =?utf-8?B?aTN5ZGNZeXphNzZFVVFOUUw0ZVRacGlldmc2NGViTlVpQnA4RTdJeVdhZmh0?=
 =?utf-8?B?b1dob0JpcVB1UVY1SGdLb0x1WUlabFBGcHV5cGdqR2hHeEdxeG54K1hZT3hH?=
 =?utf-8?B?eE9oTk4xRnBCMGozVlk3dFVQSW1KMDZ2c2lxdzB2aEg4UGdwOUpPZkdmUStq?=
 =?utf-8?B?N25ERnAzcENBeitWNFF5bVpQVURUcGJ5S2RBbWQxTzRkSjFoTEwwNER0OC82?=
 =?utf-8?B?ZmZUL3lDSTR5MWlRZTZTanJTbkkrajdIQ1RWRXQ2UVVZREFYZjExbWlMaVlh?=
 =?utf-8?B?TmJ6bUxycVhVS2tXZmp6UDlnUzRoOHpJWjJoM0JRTUFQOG9ZeDJ1dHZLUTIz?=
 =?utf-8?B?ZGRmT3M3ekM1Z05UWUFaZFdtNHNiWHoxazRpdmpONmhzbVlZc3BxUk0xQ05L?=
 =?utf-8?B?MXRSMUpsV2FFOHpwM0xuWUs4aU93RkNWMWZzVHJxeE5mSFlKSVMxNEhJZ1pU?=
 =?utf-8?B?cmgwWUZZaG1lT0pVZUFkSFhUVlpQRHdGU01MU2k4bFVzWjFhSGNYci9xUUtz?=
 =?utf-8?B?Z0gyYnZxbUEzbWw5emNaVkMvK1VrbTc0ajJIcEN6bExxTFRTdU5ZS0xhQ2FU?=
 =?utf-8?B?d1VCa3RNWkxwcDFtN2RWVnFVR2pHKytuTGVxNEw4VHVMemRQWkxJNjJIM2M5?=
 =?utf-8?B?Zks3WE9zaGc4eUtGNWNwNDlMVEJlTGhWbG9kT2NyVUZtYWc5Rjk5Slo1ZE1O?=
 =?utf-8?B?NGh5TXcwQlBoQUVZMU9LallXSWdoNGZWSXd3M3NWRHVQT0N0Rlh5aFBoaDJp?=
 =?utf-8?B?ZG5sNTRwMURCV3krTTRJVWhjNlh1UzZ4M1BtdXMwNmNLeFRzVlp0aVAxWkdo?=
 =?utf-8?B?MTdIODU2RGU1ZjJ6VmpCMDcyT2NNNFJpbkRyNW53elVjbTRWZHdJeEhBaHdN?=
 =?utf-8?B?eTJDSWFCaGIyN2ZPVjRvczYrck5HTk5tMUZ0NkJ2eXVWbWoweVAxOU9hSXMy?=
 =?utf-8?B?d1ZZWkVWTFJITTB1VzZpUEptbUlUeHhZdWEwaHQvZmd2NHEwNDdSZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b4d111-b413-461a-037a-08de8a750769
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:47:17.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Hh4GGxeyTSc0zS4AMWRdS3Am3dBqWeW0UZzVyaYY2l/Y+ozZaAJIoJnM5e9BfNCYs7qfEv8UIIM0DkPwh4F2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12571
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33847-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 641453265D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:13:07 AM +0100, Johannes Berg wrote:
> On Thu, 2026-03-12 at 16:56 +0800, Jeff Chen wrote:
> > 
> > Right, understood. The IW61x SDIO IDs currently appear only in linux-next, not in wireless-next,
> > and the patchwork build logs confirm the build failure is exactly due to these IDs being
> > undefined.
> > 
> > For v11, I’ll add a small temporary patch with local fallback #defines (guarded with #ifndef) so
> > that wireless-next can build independently without relying on any cross-tree merges. I’ll drop
> > that patch once the IDs reach mainline.
> 
> That seems kind of ugly too.
> 
> Ulf, do you rebase mmc.git's next branch?
> 
> For whatever reason, Jeff sent you the requisite IDs for the driver
> rather than putting them into the same patchset and getting your ACK,
> and you have it as commit c0b68bc25efe ("mmc: sdio: add NXP vendor and
> IW61x device IDs").
> 
> It _looks_ like that's in your next branch only, not mux or fixes (but
> I'm getting slightly confused by the branch structure), perhaps there's
> a chance you could drop that?
> 
> Or maybe the less bad option would be to just have that commit twice in
> both trees? I'm nott a fan of a local define that we have to clean up
> later...
> 
> johannes
> 

Hi Johannes,

Ulf prefers not to rebase or drop the SDIO ID patch from the mmc tree,
and his suggestion is for me to include an identical copy of that patch
in the nxpwifi series for wireless-next, so that the driver can build
independently during review. Since the change is trivial, he expects git
to resolve the duplication automatically when the wireless and mmc trees
are merged.
Would this approach be acceptable for wireless-next?

For reference, please see Ulf’s feedback here:

https://patchwork.kernel.org/project/linux-mmc/patch/20260113031517.244714-1-jeff.chen_1@nxp.com/

thanks,
Jeff

