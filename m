Return-Path: <linux-wireless+bounces-25072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A2AFE05D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F20A171B81
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AD26CE15;
	Wed,  9 Jul 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Zerq3+Ei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013046.outbound.protection.outlook.com [40.107.44.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD8283FE6;
	Wed,  9 Jul 2025 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043365; cv=fail; b=b6GarDBU9e3LIITtwwdcivVR3vIaVKuZoFCuHFWjnLZs7SONLohNN6wPG8nGxUPuEEOdYhPUnZ8lF1Lm9aI4IP2BPJxK/ZYQFwnK/4QPLLB4RwrSlvKtrKJsWb8SvIIEqqHf+0en+dnBDMB4JcOs9M95ZrlJ7Laaf0l2Ug+bxSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043365; c=relaxed/simple;
	bh=v4qWSjtrdlzDlwfl2LYcSRuCycJ0d4fNrg8J59M+gng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/lKKtLQkLRF8xGgH2bzo+mfOwIz46CRQYTpRiHHssbPvwGb0PIZ6z6eCI7kkfcqtJAb8gNKrHohmGUkvt/XfCR15hzx05l8d77nFOlHDIk+PRVjfWIiUz7j4/oU2Wj/SvIy89sk0jmMqXa7tAfLTUsb1naZJWAM0wZu4KkOrEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Zerq3+Ei; arc=fail smtp.client-ip=40.107.44.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyEvO0lN1gtfVAmIkT+JKLcjfTky6QtoSqPEu4Hc19PPBzCtFQAKF1Ah3oJZRt3BOF8PxQY5IcGslCT2Gpmwukjmsugp/iP5795iSX7nBJQVFVxGgMPnB66aT5EmotBogTxU9SUFg6djVG+tCdjbvLv2SkAwSuE0PtuSJu0uQ2BWUIEyJShujVyWTIO2+26y6E3kdN1vR+Oqg4KndLpRjN0rxI1dEGo461C0xeXbmSmURifPyDeyOUJi/ORkWZ/nOP9fytTnsKz4sBkrSdqi/x8gBuTPa3JU2qfe95lLqLOKl25V5mL+U+U9DbEh9IXFGbhkkGNpI0nhNRU4cVzBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoIHMagL7NYI3NP7n6I4tVcjPEvXk3J8aPebkBuMpO0=;
 b=h7l9KnOHDMz+kTReXMxZkKYqP0k7mRLqxD9CLnS12jEv4i9U0A1xCR9yy0hIBvgBzStvkn7FlbcUZZ+NlvsdtK4a+4EzEoFJV3wJydy4mJbFRI8MGEwlVteJ47nJUmCCNgFcKBNuJZKvjraezAzXiViJei+w7ogZVTpTCn13kT5YICdUroymkrOAxq6Xyr5e1qgs87EDe7WnnjZmnzVkyuMsq95vX8iKfQTLRvuHxEIXtQi7SnVR+9kYCU2R5jV11u7fot35UssjJ281u61qojwFrZ2qQ45vVscq4crb2OGP3K2x8TERW3R3TQyBF40ShIRgIn2Dqzpfr3Wpk06Ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoIHMagL7NYI3NP7n6I4tVcjPEvXk3J8aPebkBuMpO0=;
 b=Zerq3+Eii7SE76FrsFvMrT9fZGSxO0jOJxzWU6zNbb0ATVK2pq6TJN8TawyYQ8Efu9Q2hwpU4YqSHHu95Gjm0tF/V+dkZiyVtu13hhahXq7fD1tgP94FEolYCMwdIFaLix2VqLhMI11dhpa769KeYxC8x5Jb8OabBwOYL9/0rz5mEwBfzIEXBrVCeYHftTnW1vRP/zdyTNyeL47tODJKR0xSzaOQFPoeakDqPqs1ICz/0dQuhJZB6iDUAlcZ8O1BtlL7KSWTQfKnvureWtR1Jek8y/ozIhW1t+ugYi59AZ/4P4isLV6sWJhQKJlx5m9Q69/oYkRQTlTQWgLdmNAI2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB5247.apcprd06.prod.outlook.com (2603:1096:101:77::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 06:42:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 06:42:37 +0000
Message-ID: <1c94956e-4105-4a01-9f47-6abd18a97ec9@vivo.com>
Date: Wed, 9 Jul 2025 14:42:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] wifi: mwifiex: Use max() to improve code
Content-Language: en-US
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Johannes Berg <johannes.berg@intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>,
 David Lin <yu-hao.lin@nxp.com>, Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "open list:MARVELL MWIFIEX WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
 <20250709022210.304030-11-rongqianfeng@vivo.com>
 <aG4BUWM8o8S7bR9p@nxpwireless-Inspiron-14-Plus-7440>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aG4BUWM8o8S7bR9p@nxpwireless-Inspiron-14-Plus-7440>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c57b6d7-513a-4b47-e619-08ddbeb3cb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1IxcEs2NkVSS0FUSHhvdWpFR3BwNktsWTZtQXVYSDRVUXlhd01OcUVlb1BF?=
 =?utf-8?B?Qi9iQmRBKzF1SzJlbU9zWDdhRzA4RlE0azNjb1o1NU9oVU51VUloU1EvYlZG?=
 =?utf-8?B?eDI2MEc2UEhKUVFkNldkWlFLbWhvUUg1c1J1UzdRYytlTTVzSFJzc2JoWG53?=
 =?utf-8?B?MXIxaGxQZzdUQzhyeVRzbHdQY3BWdlp0d3ZWdE1vdVRnc1FrQUFJUnFGNXlN?=
 =?utf-8?B?YjhBS2dvMWhtekZweEl0anFFOHh4bHBOcVdVaXJlV1UvcEJvNEx0bzEyUEFm?=
 =?utf-8?B?Z0ZOK0loVVd3V0dEcXpFN0ZZQlRxT3k5L3BQWkd4WGVPbnAzODF6OTk3cm83?=
 =?utf-8?B?WG5OLzNLVEU3Q0xVQWJoMVQzV1hlUnFwVXl5NUlSOWkvKzFEMnhSY1lvRTRS?=
 =?utf-8?B?Y01ENkYyRTBnVzk5NWF6WG5MVkJJWnV1akUvUjZmbU9FSTFReFYrZWFkUnZs?=
 =?utf-8?B?bEVmQUMwNFFYUTFBWngzMmVVTlIvMmRVOE44cjFIK0YyendxL3lNZVhJWEs2?=
 =?utf-8?B?VW52clpGMGhNRVQrTjd0MjJEeHllSEJvb1JFSHdlM1R0QXg5ODdpRDNmVUFI?=
 =?utf-8?B?TzI1S3N5QWRYQnR3NjZ0dHRtTnoveXFpTTJuNlQrQXNIQmYweW91Q002VFVL?=
 =?utf-8?B?NUN3Q0cvaG1rcVFuMmRZOTF2VGFNWERNNDBxMDRrZ1g4UCtNUnR0Q3YwMWZw?=
 =?utf-8?B?dndWcS93YnJPWUgxTHJ5S2kzOE5qQVZMTFl0Ykd5djdJbnRDVzdvbnRVdVRE?=
 =?utf-8?B?QmVicys0eG5qQnBsbXZrOGNGSXBsVkoya0lBdEY2bWtCTDh0QUpXc2laOTh3?=
 =?utf-8?B?aElmN2lGREQwQWh1ZncwaXk0aHRDdStpaGJQSjlOL29KNTZCdjhhSElhc05m?=
 =?utf-8?B?ejM5YzRvYzRsOWFYRmx0WmNUNDdnRmtrc3VqL29BZXhLUlpwQmhZL0tUT0Zh?=
 =?utf-8?B?TEw3dGRjc3BXMDVZWjZ3S29BSDB3c1Nyci9jY3VIZTFaVEJITmwyV0Y1Qzl1?=
 =?utf-8?B?dERUQ1J2VFU3QnZ0bmhjZmRyQ2szM0JrVGpzak9kY29wS0NRazBxb1ArcFlZ?=
 =?utf-8?B?R0JlOCs3RW1VL1JMc0hKcmRKYS9BKzFieDgwZUxpOCtyRUJBRXdrTGZqNEkz?=
 =?utf-8?B?TzFRR25oWENPdnc1V01KRWtXWmUxNzJ2Q3lMZVNyOStVU1F2ZEhQNmxKd1dx?=
 =?utf-8?B?R3lHalJmM0RmRGladHFMWGE5dEZtS0tjU2IzT3JpakRneENuZ3RlVEUycW9S?=
 =?utf-8?B?SzJNNVZtamVyUXZSTWtielZIUDd6enVpL0x4U2YvWHp3Y1Z1OFBrNVhRTExq?=
 =?utf-8?B?ai81ZkRlOGJOTXhNWnBsVDNKaVViR0doWTc5dVhCaEl6aHpEbWRzTDYvZ0Zu?=
 =?utf-8?B?Tm5ndVhucnBnUXBJc21wZ20zVFZ3b3lrbkQwQlQ1WExMdjdmVzZuaEFVYng5?=
 =?utf-8?B?b0tSU0s3Q3JGbjZra2xPWHpyZkFqR2FNemdRSXVPb2oxaDFzL1VONGNSNG9r?=
 =?utf-8?B?dUpmTXJmWUhBaU9ycm5XNVVISjJVdzYyUEtiSm9SSEZoaEpuWFdqd3hCc0xx?=
 =?utf-8?B?UTZjMmpDUWw4QXZ6WXhyanZGSkFGSHBkWWdqbEF1bDhGYjg1K3BVM1lqS3RL?=
 =?utf-8?B?dDJiNTl6bEIyRVY0UnVMY3JBU2prdDFoRGNuYkJTMHpiV1Z0ekNGSHBVK3NF?=
 =?utf-8?B?c3lqZ2RFYnh2a0xBS2xQVjNzNGJhbW9VU1AxWU80NW4vV2h3SFRLU2tzbVgv?=
 =?utf-8?B?eUR4TmdCOENrWjZBbWVrcG91TEk1NzRHTGVuWTlsL2tpZ0FDLzRkeVQwWWN1?=
 =?utf-8?B?VFc3cnJISGxSN1diakx1UkE0eVpET2Z1QzBJajQxQWZ6bTNRZys1cVpXeCto?=
 =?utf-8?B?VXdpTDhlNnVNSjNPS1NLRFl5RU83cHdNb1lhQzA3N2F6cGhkVE5LRkVhL29P?=
 =?utf-8?Q?B7Z5nQXyRZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TktNSThVOC9Ea2dTWjQ4OTJxNG01ZnFhRkg1U05OSGE4SitkcmE5YjhKcFBl?=
 =?utf-8?B?SXRIOWl0NkU2aG54RzUxMVJHVEpIWUZYYytlckI4NHhEV3JNQ25vRHlPQVhU?=
 =?utf-8?B?U09IQ2R3OE9USDRQV2V5VnczK3pwYS83TGdScEtHWmM2aWcyVWVoVEFBMUlT?=
 =?utf-8?B?ZEgxc0wxamdhZElBTCtoVThRZlM1NmdEbGxhWEtGSTNCdExUMEFKY2VxUzhj?=
 =?utf-8?B?VFZIOVdER2ZGQVZUWDhGUE1JQjdWUDBMWEZmMWQ2TGZ6SWM5RDN0cFR5dWk1?=
 =?utf-8?B?UWhCQmJHOTViTHVsUUZRcnlnYSt1REU2TDQyckJGRHVkcDg2UUZIUDVGSkx5?=
 =?utf-8?B?WHA2NGJSRFhpeTZtSnlFaGxxZDFiVXQ0dDhFR3BjVi9UalFJc1ZBOE9YZzJT?=
 =?utf-8?B?NHJwcGlwelRVRUEvYnhscFRmeXJYd0crKzVlUzhtWXMyRlMwTWZ4ZmpRS05w?=
 =?utf-8?B?ek9Yd3NCcUwvemNmbWNxVkl0c3FNbDg0VnpCRDJqcWdTNCtzRjhsM2c3Unpx?=
 =?utf-8?B?Z1VBZWVPbTV4SFZKek5IUkhBaURHeTQ0UmhBWUpKRVI0M2ErYW9WWlBjUmY5?=
 =?utf-8?B?YXRrT0YrU2txTi9PV1M3SlNtSXM2emczeTBKZ3lFT0lVYmNxaUI3ZVozNGJS?=
 =?utf-8?B?eHk1eFYxSmJ6SXhwNzlpNUtOTExWYjV3TDhyR20zeGdZRkxoRnRqTTQxcUZ3?=
 =?utf-8?B?dlNDQTU1Z3dnKzJ6SGJhRTBYWCtlT1FxZ3p3R1YzUmN3WHB6cG9PUVVidEp5?=
 =?utf-8?B?aHpqTjdGdDk0M3piSmlINWZoY0Qyckh4WU1ObFhkUTJDVTlMaFJzaThyNWk2?=
 =?utf-8?B?NEVhQytuMWJTY0I3dEg1RGdmZzRSanVpanJENXhDaXdVZnp1ZTFoOFFxK2Fj?=
 =?utf-8?B?ZWRnN2YrRnhnVDVpd00veUwvNnJMZGtBa3Z2WmZ2TWVFcXd6ZmNjWVppME11?=
 =?utf-8?B?NDB1Q05zTHp1U094SE1WMXNCM2hPWmJ4MHVEbEJqTGYyak9xRlJaK1N3VjdU?=
 =?utf-8?B?Y0wzY1FIV2VjbVdMNmRvN0hTR3NxNStxZjQ5Z05sdVJJeG9USmUrZnE5V2kv?=
 =?utf-8?B?RURRanI3a2RQN01MbnVTUTJHUFI5aXVxV29mYWEvRnRGVUI1YjlHT1JqblJV?=
 =?utf-8?B?YmxEY2JDc3JkVzg3NnhoeE0yKy8weTN6M3hzUU95b3dSRHBncFllVkwzTERP?=
 =?utf-8?B?T0t1Q01WWEwzTWxNVlprVC92c3pQejVEamlEUjdtN0VnaE1oSGJuWTZaa1lJ?=
 =?utf-8?B?QzE1UUZSb01ONkw4dG91UFNML2M3cjBhR1NHUXdSREdXQVhtVXg4SWw3NEtO?=
 =?utf-8?B?M2pTY2JHaXhDUEFoc1ZpY2g4SGxzd2RUT3V1dkJ0cGhHTWtWd2FYdVpVejBS?=
 =?utf-8?B?T0ozQktYQlA5SCsrakJ3ZkRUd00wMStmWjdsRHhlOC9Nd1BYZENZcFo0U2wz?=
 =?utf-8?B?WHBSdDZBQWY3dnF0aVh0L1RGRDNaS0ZNUkpuY21mV1dmYnlUb1F4QVc2ZjJO?=
 =?utf-8?B?RzVLQ2svbmp1OFBENXUyZTZyOHlaQUQrZUN2eCszTlZjZnZ1K050TVhZMmFH?=
 =?utf-8?B?QnU4U3pMQkRtZEhxbHJhZ2oyUXAyeUJHbUtHRlpwQzAwUUVPUzgvV1JBZHA5?=
 =?utf-8?B?b2hXTi9TZFd0UVhXVE1Ya3lYeEE0UUI5SzRIZTQ3VklnR2p2cndiM21rSEhT?=
 =?utf-8?B?V3BaK1ZQUEJXdDhITUJETVo3UTEyV2JRYlJRbG5FYUtkRU9FNzFNbisxa29J?=
 =?utf-8?B?aFFjSEFtUExJWUxhUERVN2tpR3ptdlFCbklXeGRUUEM1cmxhN29yZ3V6NU9a?=
 =?utf-8?B?ZFNEWDM1S2FpU09ZTm5sSnphcnV0NVJneXorakpVaHZCOTRsc2tvTXl6eU1Q?=
 =?utf-8?B?U2hOcWFpMXEwWkFSSnlrR1B1bmJMcjcvbUoxWURNaEVHelI2ZDhJbUxLdGVq?=
 =?utf-8?B?MDZ1R09sUkROcG9WL1ZrczZqbTN4WVZ3cWt2emUrdElEZzB1amNtTFp1RDh0?=
 =?utf-8?B?QzRieVFJbmFiem5hNnFtU2hhbjZIWGFzVW14NUtGcklKVzZ3cTNUTk5sd085?=
 =?utf-8?B?QTJ5MlFLSjhtd2ZmcDFYZ1hvOEc4bVY2a2lBRG45RzFFTzJwaXFtYkRXRmJ6?=
 =?utf-8?Q?SJF30IzU+99m8UxVPFx0IGhK2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c57b6d7-513a-4b47-e619-08ddbeb3cb16
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:42:37.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kXHtugPWRWsRw06x3Yjxfkqb5mBS7z1ZrA3YxQZm7Y6l5Jpaq0WBap3y8Qo1PKAFrY+U5Yo9mgbhuW+cBsdnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5247

在 2025/7/9 13:42, Jeff Chen 写道:
> -     if (adapter->max_sta_conn > adapter->max_p2p_conn)
> -             wiphy->max_ap_assoc_sta = adapter->max_sta_conn;
> -     else
> -             wiphy->max_ap_assoc_sta = adapter->max_p2p_conn;
> +     wiphy->max_ap_assoc_sta = max(adapter->max_sta_conn,
> +                                   adapter->max_p2p_conn);
> adapter->max_sta_conn and adapter->max_p2p_conn are u8, and wiphy->max_ap_assoc_sta is u16.
> To ensure type safety and maintainability, I recommend using max_t() with typeof():
> wiphy->max_ap_assoc_sta = max_t(typeof(wiphy->max_ap_assoc_sta),
>                                  adapter->max_sta_conn,
>                                  adapter->max_p2p_conn);
>
Thanks for taking the time to reply.
I will try to do this in the next version.

Best regards,
Qianfeng
>

