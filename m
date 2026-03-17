Return-Path: <linux-wireless+bounces-33332-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGBKKIsbuWm+qwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33332-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:14:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 083382A64F6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2695C3033A97
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01CE35836F;
	Tue, 17 Mar 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="KYPStONd";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="NIRDIeal"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24E355F41
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738655; cv=fail; b=fK7aKAjz2DVzVEPB91H/SmhcvkJyD6a7GUydTBn5oe3mJXCwVZr+zJXnaNSUBTgA/DmzwFC6zZhJp1mHA/g6486LyFKtCBgm+e3BbSxnfcL5ufz8RBmodK6sSHnYIBl+J4UW5ymkWEPo3RQnfO3wbNPc1f6OyyEYsnw2etW9blU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738655; c=relaxed/simple;
	bh=LFxZlvWVBc3yo7oM+fUIfc1HejjVIWKxvcfJwnTPMHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BW/KTqCbxriTmgpbiQlB+pIr97CuZykRWdmDzR48NYB9TRqDosgTbZq0JVDq6m9Ig56kX+YGeN41YkMQG01VVJ+O9G8j4XNGyDhNo1AtJF7I4TIwdm65qjG3dGBPWi7b1P4/5pRpNIAT9N1mNgKxeaxDyAxdwkkdWHSCbp+iq5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=KYPStONd; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=NIRDIeal; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H4TM102801223;
	Tue, 17 Mar 2026 10:10:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=enfWM90Ypi2ZIKNfChY8ge
	h3hZ2xF88XOaLEHcxgnDw=; b=KYPStONdmxwZ/l+RF+AGB5wussjCC6ryurbfam
	Z7NzuVb9KaFV3i1Kg4ZZSt+o37U2OrMSdCLAwIbIPFYsW+y0PEBFyLuowdsB6oqr
	FCeXmWV7Ob4dL6WbmctqsVuuj3blovy9v/d+uSbPeGaDzMNwh/djn6V4ggeDI/cb
	v7vUbRbksYJMeH6ymKOKfYma58X4Qvwuqm/3vz0QmSoalpYhIG7Yyg15aLhXISUO
	LRSUFENPf/EqRrU/6M7he7RGYeHsP99ZNJiwl/rL2/eDHHK6kprnuxOFtPMV+bXV
	ht1oSmmQ7MnlfSOQPRksEPoYaRebsL0+xRc9BOlXy3VlyY8Q==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023092.outbound.protection.outlook.com [52.101.83.92])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cw4kfjdf5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:10:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxvVM69D/mRVIHMbZKlDSUAa+5zEB1WZk932qDJL0Q4U6T0ucJIAe9cvIfAicsGZ9MMCJFPVb/P1N1REzkS5qTr0HNKKtPrFtjJOEqgFcFMRHLGpQSTDEOqUJGerfANB2B0GjOrZGhC/DywnnOZRkd6jJU9lZibhIIbBfuKGKUDypxw+ERfFm13xr/hml39FD1iPmeGuf/wPt4iXwLBLZNkk44wNb3F49BpyehlIP9Uo14weky/0M+ehYILXBcNwuG2WmVU9U/sfsv7ofjFJI0RVeB7X6OSpvbVWzDBpsbmUt04Dajo+3H0fmkGwxkuwRjEZzTLaq5XBq9YS0zqfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enfWM90Ypi2ZIKNfChY8geh3hZ2xF88XOaLEHcxgnDw=;
 b=M/fc/KJP9Ap6347qSG58ai+VoRywPzrBhStZgcV+V90IB0rG3kXdzk9PtgT2zGZiLAyOAl/SI3f2PNTyry3j0/paBhreibRvrsRUrbtjg9ge6JaSfgnUjwHeNEo6SpXnitgB5zbZXQdXSk4b38WLUD3iILInvKbQItZnNFsLqIAEQzxyPgB3WHOH77oOawjtJOqQckktVCcSseVchn/PKtG+uEvcdgI1GQ3uAuB59iTaCMK3WrRWMCy8bS+Ad5EUwMvTF9pASEI5w3I3cUVvj27lj/+QDc3hvXFbYIQOqUBEwC3MJeE8BLZ+8SJ84+3SiPjHRLmyzG8HM9uqWW/bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enfWM90Ypi2ZIKNfChY8geh3hZ2xF88XOaLEHcxgnDw=;
 b=NIRDIealbirVRmgviu0ERRX+ViRrvY10TNfX9az2sGgA7B7T9yf0esHjMwyYMt8y7ksXYdWZOuUcHm4Yb7Ow/Zbzx8VkNJfZR/H8Fw8qqPjHacvrwJ4yDWlpOHJL+drj8+RSR3ZX6rvLkywPBu4CSgR0E5INUjoE6fHYLJd6tIU=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DU2PPF9A909934E.EURP192.PROD.OUTLOOK.COM (2603:10a6:18:3::99c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 09:10:27 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 09:10:27 +0000
Date: Tue, 17 Mar 2026 10:10:24 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: ath11k: trigger frame types
Message-ID: <abkagJGwXuaSQAYD@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF000239D7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::16e) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DU2PPF9A909934E:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc96486-2ad0-4db2-ccfd-08de8405079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3DOir7vkhqn5xn+7ELZnwx6lmhXQ31p5XhhyK4wFQgp8THvT0bUQjWu917Kw8SYxfsYJwxVUA1SMM8L2FeWU28iZE95JGwAwvyCGwobF5MCl/ISZ2ZKtaDDY3qb1LWwyDvS07SDVT3bnJRpXUSZdGYuUO+HFNdKY51agzT3k9SEvzwERGeqGly4ZVvldlzudPx6sGB45kFZ0c/KHBx9hR1B10yn69iOLv3rNfR+Ky7+ABT/igpggSemHzmfr54nswatGDlksdA0xP+2/1EXVdV6uKD3USOKf2El8LaOPUU047qOLJuDT/cUvwKub8MK45fhw8nI7XXNnGpY6/w3HP5PBIu92EvM78QWf8NGJ54DFp8Epdnhq7RtjtXuDm90SSCnXdKCJY9JlJLGFEI8z2mJnwVwsC2/SSwEYXt1eJBAWhbDH6kRE4ypWq4UuU0gfYuucY68lEvWCihmtrk4bVrrqhZWG9k/U5ozznL4u6mbLjf9JoJkyYuuVXXDyAcRPHWnY9s1y4Jv6BOA1DwDWf/H7CwowyAPmS/jKLRUXW8aRS5i8SYFXvE0u8zxZXC/DbbmwmWF7roxP3EhPE1CfBjQX+LNJpbkyTd6dV22ZDMyhWJ9Q9UUSae76A2Y/23HgNDlO2Sq5waDkQJinZyPxWs4TurjfkAXHLKeVfqtj9eZVbADnVEt95Iz9zMRjpa4yNTCWrlPMt/c2NRrvfMV4Hm/KQETBKqB/u7FJ0y7DcXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTBKbHRsS0xyL1UyajhDY1dxMUhzRjkwOEprM3l2L0hvUExYRTcyUUwzODBj?=
 =?utf-8?B?cXJOMzZuSWY4aVZxdWhiUHlNQlJ4amdITndvUWpnK09IcmlkMlRjM0tkOGtI?=
 =?utf-8?B?R2VidWJ5aGV6azU3ZUFyVlBSbXpTcXZVVEJ5emx0Y1g4M2FlNks3dnRXOWdD?=
 =?utf-8?B?MnExSDBOYUcxdk5maG9VOW5PWHZIVUdvaEsxTDZZWFFwR211djdWbm53VkRY?=
 =?utf-8?B?YTJwMmNrdmwyaTR1a2o1WnpIcjFmV2FqVlFxUDhBMzFpMzV0YVVneFlibEVI?=
 =?utf-8?B?cFl3Y3I1ZkgvS0wxRi9TWitYVHVrem5pSDdlK1UzQ1o4S0pURnlRYjRsczls?=
 =?utf-8?B?eGpUU25lZERoc3gzenVaRVJwQzNUNGRSRWZBUHdqWkVZUlZhOW9ScElFRng1?=
 =?utf-8?B?Z291b0QwNjduVmlXKys3dVFBQWpFS1RsWi9GK0ZwR210SzhaU2RzVTE2aTAv?=
 =?utf-8?B?cm5wbEMySHNPelZpSjRuQVMrMlFkL21MS3h2Sm5Fak1Ka0hvWk5nMVFzMkNh?=
 =?utf-8?B?MWpNT3NlcVowd2QxZmd3KzVtN2dNOGY3YjhzQVZERHMwNzRvN0FLSmVxdG1R?=
 =?utf-8?B?UkF6am9wN2t6cGtpYVkwODRSUVNvV3ZPYzdWOHlrU29JQnpteWlJQWZrSHJs?=
 =?utf-8?B?V2VaMG0xR1NzZXlYWnlEbktlTXE1MnI0MXZTb29MMEFZMjBxNEJkZDJObnp4?=
 =?utf-8?B?NGVRVTVaVFd1N1RxTDFsQURPc0huOHRvTVYwbHN6K0V6ZTNQR1UwazFpZ0Ew?=
 =?utf-8?B?S1gwdnBOaWxDTzlQZk1sYzNZeU1CeWs4enc1NkEzNlNQTWtFUXJ6c3JxNXRP?=
 =?utf-8?B?QjI3Sk5KR0pxa1ZnLzFUOHRPbmJvbGJHRlVlT2x2WVh3V1BYQ0ZxdGhRUDFI?=
 =?utf-8?B?dmVVd0NsbnlDSkt0QitvVU4yZHBUSWVQck9zUlE5b0ZpK0ptNXdndlpTNHNY?=
 =?utf-8?B?SzhMZ05WbEhWanB1bm9YWGRscG96dThLais3Zk04dEloeDJxY3hSUE8zN0xP?=
 =?utf-8?B?eEhvSWV3aEQwVER6a1NsY2VEakZTTndsT0VCTUgxU2Robm1sZm9JR0Z6R01Q?=
 =?utf-8?B?bFJtWlpWSGxCdXpDRHZWR3EzWGU1emxRcjdXdE9sakducVdNenZPckZXdDd2?=
 =?utf-8?B?ZDBpVmMvdjUxQXdDSkVQMkRab25Da3hHREhSdll0ek1QWERRWFNYQzZMU3o1?=
 =?utf-8?B?bndXU1ZRK0N4MERwaENBeHduajBzY05zbXEvVVlHQ0liSHMyYXRZVTlHOGpz?=
 =?utf-8?B?ZXUzZFZORWUyR0NGY25ENURyYjAzOTBqaUhtVlRwUDByS3ZGK1dMcjN3alhx?=
 =?utf-8?B?NDFLcVdMMnBqeUhVQzErQVJFZyt4SElhNXRVOUNEMHQxU25XdDdkVitSUU55?=
 =?utf-8?B?NTBITXhsVG1EVEVMQ200QTRWdDdtNVZaWG92QzRIOGVMRDdCQUhuMk44UUIx?=
 =?utf-8?B?bVZGZ01zTTE2STVLUTZWVXlJMElQZlhsTzhmMTRMZ3JWTlhmUXVvQUx2R1FT?=
 =?utf-8?B?c3JsRmNxSG9jNUxReEEzRUc5MEFub1lVbzNxWFpBd3IxdStITEtjODNQVVFh?=
 =?utf-8?B?Ukxydk1ZK3RPNTVBeFg1bnFpZEoybGxSQ21LenZxeUZGQnNrdk10eVNhQmR0?=
 =?utf-8?B?MWozVHAzR1RMczRwVnpCRTAyUXFFYmFqNEtVcW5lSmMvK29xcmFhTU1Td3R4?=
 =?utf-8?B?bUUwSS8yY1pTengrVm5zcHI0cTVJSktPR2xZUGN5M0FzNjdiTDZvVDhhOXFN?=
 =?utf-8?B?ZkdLc08vNW03QW9ZenlYTzE3SCtKQ2JMcTRPKzZabzRPTXAyc08wOVhXRXdW?=
 =?utf-8?B?a0dYRHNuekZQQS90OE9KV2kxTHowdjVVdmx6a01oMzkvZkZnWTN4UVdVZktl?=
 =?utf-8?B?a2hRaEZwYWZ2SEN2M25FRkt2aXFERWwycy9Ic09FNk5HWVVwZzJWK1ZqeTh5?=
 =?utf-8?B?dDV5R1FyU2oxRDF6blVGaGJsWmJYZktxeG5zSkI5VUE2ek81VmU0ck5NZWFl?=
 =?utf-8?B?NDVIclpLdVlkY3lzbll5RVQrWGYyYnk5b0pUQmFxV09veDY0QVhFUUNpcHY1?=
 =?utf-8?B?anVIQkVqU1EzaDJKMkJ4QTFHdDFUaFpHNDI2ODRYaVZ2TjRYWGJXcUlIa29t?=
 =?utf-8?B?dlJXc0Q0U013MmRCbXRKTzNjOXRlNGFucE1vRVlHM2xQTFhzMEErMWpPY1ox?=
 =?utf-8?B?NEdvdmZ6TUQ1ejVEWXpxajBFWkM3VmpCK2l4VjN0d3MzYVZCc1pBc1dIdDJC?=
 =?utf-8?B?bU5ISmpSTWdSVGN5YzY4d3FPbzFiZzZTdERvc1RGYXNuQWpYQVR5aXk3TmxL?=
 =?utf-8?B?dmRWNWY3K2k4cFF5c1pJOGhYK3pKYkFnUGVtM0RxUlF4Qk5WMHFQdz09?=
X-Exchange-RoutingPolicyChecked:
	lPc81h6peQy3JWagVfljJIb3yLET6Dx0fAYMHoInDCKjeZrnMCfJgoUPp0ULmrGA/Je4KO14fcxTp3MT7o1XOQ0fI7CqpIEOidLMcLAN5Q52ofPjoV3QckiqOY5thyT8kuRVXw79MhJZbcKxf1O58Eo7Qp+4R/PG/kz+eNo5zD9Idnpg1EN88s6QctzDAX3ybxjtedcK9kB3eS7R0Mcp3ANfdCC5HwZOxjDNpM9pHPUvOZcJYY1+EaH/Ed/KCB9higzTDgzof+v8OtrhPL9mjoz8jkOhqoF9a24exNh+km9BIwLgjoCAa8NBUSyA25brAd6OpnZIQFlFCU4ubW6fnA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6byBPfprrr5W4fQq7DTLGkpXDsOyMRfcVlAlmiCYPLJt9vDUuEmK0DYyKx4WYVe8HtMDRtMJV9HQUzdpTKv3NK7jWgx2m0Qd1DRHlrj+JOqLl+XB8d8C61YgC5fXhQNU02Ov7Vsd12kJkkpU4Iwi3YzkoIu90FcLNbti8X6pgjhBMT8JpY28exUCiVZ8YV5nE3AWKMsIbmaeBWZ0Nod+z1EPVVITfMfVSHud1COqI9grUvyFko5WK/aN+9PMT0pw6xWsfkixAHe9kcv/90SLhJMLGtMTRdXifVrdWjkk8tRtGuZMOmEeO+vAoM6z/18n/1rrdXog1y+ahkC/j1TIERsh2TKZIOzHITMoDTvl4V0PH+Xrhhs8DlJVEQQMp0FER2gRxkxLT7DkhLH0NWRqS8LvV1lmotBeUoGkTg+izeaErTPlliE0A1bhTeXccmdjAij0YTp0XDj3WWwHtJgffuyYZL+l6RE4Hh4rJsL4ngdc6bxHscnswrKitTHJ41FM5j8Hgw3BdXWix7GTYEbjILxiKX0zyWdd9cXaq5BX7YcVBAlwQLDBiNkZSBVlXE5M7h5wFnrbCj3nKF07PjWZuhC7nqt5IKmqlboJpdsZQ44x+0uBqGTz7sjyD/4akie3
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc96486-2ad0-4db2-ccfd-08de8405079e
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:10:27.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgN0xartO6pnIYQN8b5eeWQColmgwAaZP+/0peKppEYzt2+qdq3O1i47TSwgbFusd03/SKDbmx35HfMgb9Z2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPF9A909934E
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
X-OrganizationHeadersPreserved: DU2PPF9A909934E.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: vjdeFr3NHR2-CZRmfpVk68w95s674Hxr
X-Authority-Analysis: v=2.4 cv=Pb7yRyhd c=1 sm=1 tr=0 ts=69b91a85 cx=c_pps
 a=WkcVPXYg+doJPrcbFpP2tw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=725LRFWF8pg9NxRzndkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vjdeFr3NHR2-CZRmfpVk68w95s674Hxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4MCBTYWx0ZWRfX3+93oGNzAk++
 BSOzdVB8mdGre0whlpnbKOdrug9qdZ+4vmmBoZQI4g/JM6m10GnqBJc2NvWd072PHZ+Co1ZW6Ix
 dl5heZGwr19sNVR8frQBi0EaEs6RO53Kw1XQxPzgTfmuzvJK87dFiLq9ciY0owQucUfCkVDDLEZ
 vttJnUoqPvLpLyN8rfHSXZTZ9wej5pKkv9Kg5Oq41Cf+oFDMJ7z2LZFh3gBazsZhFqMJkjl7cAp
 82lu92HhYKujwMrEersYfh9//E5ECnKl+qdw9ZusJJQ5P71yQ/QZ+EjC5gYN/eyGe+3IF58quic
 MTDMUTBRgMn4dLXUwBQCthej5VzGwWKx2cXVY0QNHZs89SgZ1BduI6TgnkBVSCMw0/Ek3pK4NGf
 +wTriNlX17VOBGD87Mt2UGDkkzf1AULd+XsxFWCcy5yBrrfliKXHjkWY6Cxp3faxuO2JVJF4pg/
 AQGKAu5sqV8FHIgz0sg==
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33332-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 083382A64F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello wireless devs,

I am currently learning about the topic of “Trigger Frames” and analyzing
the packets I captured with Wireshark. I am using the QCN9074 with the
`ath11k` driver and set up an AP with HE80, to which two clients (STA1 and
STA2) are connected. When I analyze the packets, I can see BSRP and MU‑BAR
trigger frames. What is interesting, however, is the output of htt_stats:

    $ echo 12 > htt_stats_type
    $ cat htt_stats
    HTT_TX_SELFGEN_CMN_STATS_TLV:
    mac_id = 0
    su_bar = 238
    rts = 0
    cts2self = 0
    qos_null = 0
    delayed_bar_1 = 0
    delayed_bar_2 = 0
    delayed_bar_3 = 0
    delayed_bar_4 = 0
    delayed_bar_5 = 0
    delayed_bar_6 = 0
    delayed_bar_7 = 0

    HTT_TX_SELFGEN_AC_STATS_TLV:
    ac_su_ndpa = 0
    ac_su_ndp = 0
    ac_mu_mimo_ndpa = 0
    ac_mu_mimo_ndp = 0
    ac_mu_mimo_brpoll_1 = 0
    ac_mu_mimo_brpoll_2 = 0
    ac_mu_mimo_brpoll_3 = 0

    HTT_TX_SELFGEN_AX_STATS_TLV:
    ax_su_ndpa = 234
    ax_su_ndp = 234
    ax_mu_mimo_ndpa = 0
    ax_mu_mimo_ndp = 0
    ax_mu_mimo_brpoll_1 = 0
    ax_mu_mimo_brpoll_2 = 0
    ax_mu_mimo_brpoll_3 = 0
    ax_mu_mimo_brpoll_4 = 0
    ax_mu_mimo_brpoll_5 = 0
    ax_mu_mimo_brpoll_6 = 0
    ax_mu_mimo_brpoll_7 = 0
    ax_basic_trigger = 0
    ax_ulmumimo_trigger = 0
    ax_bsr_trigger = 0
    ax_mu_bar_trigger = 0
    ax_mu_rts_trigger = 0

    HTT_TX_SELFGEN_AC_ERR_STATS_TLV:
    ac_su_ndp_err = 0
    ac_su_ndpa_err = 0
    ac_mu_mimo_ndpa_err = 0
    ac_mu_mimo_ndp_err = 0
    ac_mu_mimo_brp1_err = 0
    ac_mu_mimo_brp2_err = 0
    ac_mu_mimo_brp3_err = 0

    HTT_TX_SELFGEN_AX_ERR_STATS_TLV:
    ax_su_ndp_err = 97
    ax_su_ndpa_err = 0
    ax_mu_mimo_ndpa_err = 0
    ax_mu_mimo_ndp_err = 0
    ax_mu_mimo_brp1_err = 0
    ax_mu_mimo_brp2_err = 0
    ax_mu_mimo_brp3_err = 0
    ax_mu_mimo_brp4_err = 0
    ax_mu_mimo_brp5_err = 0
    ax_mu_mimo_brp6_err = 0
    ax_mu_mimo_brp7_err = 0
    ax_basic_trigger_err = 0
    ax_ulmumimo_trigger_err = 0
    ax_bsr_trigger_err = 45
    ax_mu_bar_trigger_err = 238
    ax_mu_rts_trigger_err = 0

I am wondering why the error counter keeps increasing even though the
packets are there. Maybe I am simply misinterpreting the firmware
statistics here.

It is quite difficult for me to set up an environment where I can reliably
receive specific trigger frames. Is there any way in `ath11k`, or in the
firmware via WMI commands, to force certain trigger frames or restrict the
use of specific ones?


Best regards
Alexander Wilhelm

