Return-Path: <linux-wireless+bounces-33669-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNH3LsFkwGmHHQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33669-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 22:53:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEA2EAEB4
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EB2B3002B79
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65359365A0F;
	Sun, 22 Mar 2026 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT1705183.onmicrosoft.com header.i=@NETORGFT1705183.onmicrosoft.com header.b="EI399i8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023083.outbound.protection.outlook.com [40.93.201.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51618050;
	Sun, 22 Mar 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216380; cv=fail; b=KxVAKLvBCJgkRbROnNcXuP2pv5RSpFwDa/3W9CU2Bo7PJZexe4lktUbuBeg0PZimGrRwrBXo3VG5b0tQdJdoLu1cFIq5xqpwJGQXLPi9b2wZTpnvo/TnktROHSqhvGRUkQ/Ft5eEcF4daxPX1qw9xpgMWup8nllmxyMsDzw2m5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216380; c=relaxed/simple;
	bh=NqUy6izrCzh7AfkxjiMfYiLcbeacCgSwy1SiWwWOYUA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=EjYGGbjURM+bUmh0kwjzy/GGtK7JICy3YtUdqTmUhVq4b/RK9DrUhlUFTQj94qWjFDnyfB9XN9I2v+d3IZyEoWh08ZOqneXROfvRqnlpDiRHoKISWmoKJyim6r2ghDAV8Mo2BcKjf5G49m5Xb+7kRZ6Z6qeiWKLinG3ibOqTp1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=borderelliptic.com; spf=pass smtp.mailfrom=borderelliptic.com; dkim=pass (1024-bit key) header.d=NETORGFT1705183.onmicrosoft.com header.i=@NETORGFT1705183.onmicrosoft.com header.b=EI399i8f; arc=fail smtp.client-ip=40.93.201.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=borderelliptic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=borderelliptic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d90ua+e/BeGPZiMPDUHqWVcGXDfSMPUQzFEqvR6D5jg3hZUSVEMiQC+aiK+7S17XYoETOrtw1rhOavAgeTzrPQkmsJBuioM24A9CDIOJXii7QC7xMamduGkMfPp/560WkuXSxM+xSORJcv3Cp5Uf8Tp6vVwUua02ncJTQJMS7dRzRV5euqaln+Am8pS+nAX/YSffYtsg787n3IrXIGOcAZylEzk5pZ2BO5DP8ctOkpgSyed3X9rAQE3BD483Ku0krH78aCJiPe6ccogsIMX9Grwa7+ZaOe1lM5N1Rzlix0JFONJGkIX4MMAA/X8P45ZCniCS1M8AVUH8R2k0LmKHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOlXis5N+XwibS9zstvtYr1yWetI8AWhsVKbMskV6eo=;
 b=MbJ3i9cRjsEz+zMe9kEMogyo4GkGdGwmFeqFP3Sq/rrchvWx/UYErCeHFw+Q+QApxJWMaB7Xj6r7Lc9coyQ+IC0AOUeSlE3RFqH/lDNMhSH0ufWwWkFfURkoxk98uoCLIGvps46gw0P9vj7mm0Tgo4ehW0+gImkalkzyUlVAEbwxQQ4T6NVoGTDJRNGZtdqdUy4/aroNRjNqOZ+ftwlfYN0ghLi9uJH/qJGcIqu6Ff2iMN4GlzawzPHyLQil7h2q9/qKBvzTNiGIFbegfX5uec+HqalRp4IM0L9rvz3NFJnC+os54T1JfJSjLq1YFCXK9Sdl0dKF94KrK53zNjROdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=borderelliptic.com; dmarc=pass action=none
 header.from=borderelliptic.com; dkim=pass header.d=borderelliptic.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT1705183.onmicrosoft.com;
 s=selector1-NETORGFT1705183-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOlXis5N+XwibS9zstvtYr1yWetI8AWhsVKbMskV6eo=;
 b=EI399i8fkWl3htpaGekMQG9MCQqfclYSiTYBcr0OSNGuJqsQ4O5Ac4m9DrUpG+J2IcHf86SLgRnViOEgL3aG+mPMxe7NFMus7xfm50es1Mmf6rur7Wdt1SlYTv7OxhjC1CTRIKwyUAZunH1BQx9TgvWiVkGyeiGYFJ1CgaMRoyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=borderelliptic.com;
Received: from BY5PR17MB3732.namprd17.prod.outlook.com (2603:10b6:a03:239::7)
 by DS0PR17MB6175.namprd17.prod.outlook.com (2603:10b6:8:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 21:52:55 +0000
Received: from BY5PR17MB3732.namprd17.prod.outlook.com
 ([fe80::816c:f79e:c7c0:459]) by BY5PR17MB3732.namprd17.prod.outlook.com
 ([fe80::816c:f79e:c7c0:459%5]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 21:52:55 +0000
Message-ID: <ce155d4e-2e01-46a2-b607-2d238644ef01@borderelliptic.com>
Date: Sun, 22 Mar 2026 17:52:54 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Brown <jonny@borderelliptic.com>
Subject: [RFC PATCH 0/1] wifi: iwlmvm: introduce iwl_mvm_has_gcmp_support()
 helper
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To BY5PR17MB3732.namprd17.prod.outlook.com
 (2603:10b6:a03:239::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR17MB3732:EE_|DS0PR17MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: e0295c4e-6d24-4c8a-e948-08de885d5fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ELkwPlcybtRPzN77hPmyb0dYQTAcyUtTzAD4OItBAppL8eCCKqSgPBOtJv4I/aoQdjbOzTNaVd05ArrhZ1SVcBeZwtMsGpVTLdqe9WqDLDLJQZ0bQprZYt2n2ndDEo61X6hvzcc1oDXw9JGJW5jaLPHkOpu6Uy2QA+y1zusvPV3aaMNxQrYJjx/HFIgz3VtAmJtffJiZLH2MEXAfVtAoWzDEwvPvCcUdPlUKrYRjIWHKXnuf//lTiFLQxGNmQI+1W3NR0Jq4vbqrBEAV4+052pv4ZxXlR4iRoc52MRHbbKLA55Xp+HAd4EWbRwlHJXLnHE+ToRF57iBbKlwc45suCRlrmkbYQv5hOHejfuX7EdxFtJ/9Qn/r+NKJJG2ly8tN+ZMMWtRplgso6eyqQnNtB5sKnJCYpHPg5Msup4M6taDXzbcUsdiW6gDiyRdnTrbZyort27EDD0uIhv2fwH9c5oWIAFNf87JVbGjoe61KbL8tpNeWDQn6mfb4Hab6p0iELD6EBuG/pY4pLMBzHTHpqmnZcMpZ/bE3I6nNpv381V53pVAj0gLT9+q0rzK3BJtK5mqknka+E++oznfNFDpsYB1L143UYV84+ZvLaKnN42ldq2yILIg9SCMjX3w9KGE3WojyPOSjcRt5jxkgef+2lVBdBLO/7QZ0pOH8LkwSjJQItGVSZZHYaTkjp1rWI/5GvXy16YMpJVEiCk1IUqe9XMQ+DGSD/Z36h5sk8UJ0rY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR17MB3732.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZXZUx2b3hxbXBmUFdBMGo2dURJdmFUK29UdTlOMmZBMWp3eThoMzhDdkFC?=
 =?utf-8?B?YXFGclZTOGpPV29PbjFXZ1hQQWpPWXR4T0ZFbWFoVGR4TURpbVE4dXNScnhj?=
 =?utf-8?B?dFBFRnQ2RjJmOFk4K0lldStYYkpHbnk0cUIzUzBadS8xekpXUHlJb1kzVDBM?=
 =?utf-8?B?ZUxjcHNHNVArWUgzSEJpeUs0VTFta2ozUjhNVVU3dEZ0MzM4NlpvUTRLbVFx?=
 =?utf-8?B?Yi9OUzVoKzlKcFBkSnpUeElwSWtWVG1ZZW5rQjlCQkNucGN0dEh5dHJUUkd6?=
 =?utf-8?B?QVU4bDI2NkhUZ21KU3lhVDVuKzNtV04rZXNNYkIvUExlUnZRbFhmb0tUbGJL?=
 =?utf-8?B?bVZtVG9GTGcvRkNUZERSWnFiQ1JvMG9aamV0VGM0eGFDTnJhVHpVWStYanhK?=
 =?utf-8?B?SzNDU1FZbGkrbU9MenRKaWl4SFdJT1ZIWlJCMitxQ1lLQ2E5ZDhpUE9jV2dt?=
 =?utf-8?B?TXdQV0ZlVVNiaGM2V0JRbjRvZkc0OC96UFV6OTJrbzZNM01FR0xPaDVwSGR4?=
 =?utf-8?B?YklPL1NLbWZrSEdsalFkMlgyV1ppOFFPdXJTWDJMcFp2N0JqSTRNWEwxVTlv?=
 =?utf-8?B?YjB0YWd0WGxuWlZldWlmOHF0b2NhV3hwRVA0K3lwc240NnZZY0c4Zkx3UFox?=
 =?utf-8?B?OWp4S3A2WE1mbWNmWTluVnpjcjgwaGRFckdlQlM2VCsxcGVib3o1MXVHVlNm?=
 =?utf-8?B?OUQzTTkyb1JqcDdsQ1NYb00wVTNDV1YxQk5BRXhNM0M5SVUvMXZ1aWtXWmIv?=
 =?utf-8?B?dU00clR1eEdhM0dWTmFHTncrYlpndHBmd0k2Y3BVUldETVV3dWN2RVVTNzMx?=
 =?utf-8?B?N2tnYnhRZkk5bHRHNzl1V1JvS2s3T2VlSUFZekVsTVFheFhKcCtrNFZHcW02?=
 =?utf-8?B?Mm9KSlh5ZE04N0ZzMFRIVGdkVUdNN2NoMC9ldUdtdmZIbXVtbEFNMDNZUDdv?=
 =?utf-8?B?K3h0TDJLaUJWV2pXeVZUWXVTYnROcGh5VDdtaUdYYlBrUFg3dUx5Nk5OZjRa?=
 =?utf-8?B?RHUrVUViNlJuRmF4eGl5aEpJTzVUbUlncyt2c2RlTktFNG1vYzh6OWk1MkxO?=
 =?utf-8?B?eVBHcFlDS1JLNEh1TWVpZm5YNldBKzhKQmwrVmNIUHArZzE2L2ptcDJuSTl5?=
 =?utf-8?B?VkFveTl6QU1CUnNrdjkwZkUwcUhoZ0g0WVMrVkg2bG5FQ2JGVE40K3pjZGlF?=
 =?utf-8?B?M3FMMXBXUWVmTTBPc0RpZ09ZZVNLYk9VbGlGSjdKSWx3eVNIa3hYRHI2eDFY?=
 =?utf-8?B?bmtOUXd5TDN6WjlnRklJYWFQU3hUNmpPOVJib21BRjJFSDJUTjJ4YmVtVHZa?=
 =?utf-8?B?MUI1eXdYQ0h2c3VQQXBQWGVyVGY0TCtlUUdScnBSeW5QOTRuWGI5VU9pNXJU?=
 =?utf-8?B?bXQzSkJmZHRzN1JKVWpBZzFmUTBiK1VmVmFac2FBdVpCQS9ZdjltM1BmaG1X?=
 =?utf-8?B?NjR1MjZCK1pqUkpnOGtRNXg2bkg3bUJpQUJtZmlMdjhsNDJhNExIVmU5K2pz?=
 =?utf-8?B?M1JocUJvQ2FIOUg2UEo3YnUzbDBZcFlOQmJqTGVkRkxNUmJ0eXVhWGpUeGxL?=
 =?utf-8?B?UFVqV2h2QUM4dFVDUk9QS2dvTHBTMzhGTklPdDV1SzlScFlWNmJ2dWR3aEEz?=
 =?utf-8?B?Q3BKY0dVTXhsN3NwZ0w0L3lkOWJoSW1RbDNRblQvdFhhU2J5cGZZM284MUN2?=
 =?utf-8?B?amdQNzJsTGp4QThsSTRaSUsrR0lVQUJycklpaWhlVUlsUVVNc3BqZjVIK3lG?=
 =?utf-8?B?blN0aXpwaTRTckh0bW5NYVEyYkI2WVY0ZUVsemF1Uk5uTFhCV0JsQTJPQUY4?=
 =?utf-8?B?WlNPS1hkanlCcDQxSXRaTDQwbWx1eExwbE16UERGaDhDcFBMdEk1UlZvNkVC?=
 =?utf-8?B?d1FMTHJwUHZkWDVoRE0vWFVYS2RSdkFPUURleW9Qd0gyYUNvNVc2Wmh6TU93?=
 =?utf-8?B?a2hNNGloOVN1aWlsa1dWYWhvc0F0QlJsQVRWdUY1OGl3L215Mjg3cUttdkpl?=
 =?utf-8?B?d2RnQWdKZXUvMzdiZnBzdjdsSGlnbUlrYXZNYXZxZWxKclFJVWhvWmRlUW1W?=
 =?utf-8?B?U1ZNUFFYWnZ1aktHRWJwZFFFNkVORXhsYnJyZTI2QnRNMFdZTzA3Ly9OcGlE?=
 =?utf-8?B?SXg4c3FVMG5Qcks1b0JlSVM1enVOU1h2cnN2SlhpNm1qSVduOHJWNEcyMUlZ?=
 =?utf-8?B?eFVJcFZYeitPcWMzWGJjcGFXR0FSSEhsQmZmdFdvVG9OZDNYMFo4Rno1Rytp?=
 =?utf-8?B?Q3VwYzh2VXRQZ0RscnlWTi9LVXdQNlJZNUs4S0F2dDRxdS80UzlTdHJOK1pR?=
 =?utf-8?B?TUZsWjMvU2E0ZktVZVpaZW1QSFRNMEFsOU5UUnBKcGlYWTB4alBlTnpUSm9J?=
 =?utf-8?Q?X0bJGwzG0VgUkXQAJCpYHyVJeIVjcnG5GGoPFC2t4HgFa?=
X-MS-Exchange-AntiSpam-MessageData-1: xuPYIecVxRfVyQ==
X-OriginatorOrg: borderelliptic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0295c4e-6d24-4c8a-e948-08de885d5fe9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR17MB3732.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 21:52:55.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a902ac00-4ea6-4f14-a7d1-5889052f0cd8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpKwxFFjyU6GILRTJhO309Rg3UZzCEkrXvdIUwOuew3p3srTRVuZRypKiLDaMWSkmL1o7AD9ovyu/3d/XM4TaMRWLip8msjmYClHg4LR/nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6175
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NETORGFT1705183.onmicrosoft.com:s=selector1-NETORGFT1705183-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NETORGFT1705183.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33669-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[borderelliptic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonny@borderelliptic.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NETORGFT1705183.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6FEA2EAEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 From a9fa945246619b35e1e1302aa05f9106d7207dc7 Mon Sep 17 00:00:00 2001
From: Jonathan Brown <jonny@borderelliptic.com>
Date: Sun, 22 Mar 2026 17:09:24 -0400
Subject: [RFC PATCH 0/1] wifi: iwlmvm: introduce 
iwl_mvm_has_gcmp_support() helper

Jonathan Brown (1):
   wifi: iwlmvm: introduce iwl_mvm_has_gcmp_support() helper

  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 11 +++++++++++
  2 files changed, 13 insertions(+), 2 deletions(-)

---
This patch introduces a named capability helper for GCMP cipher support
in the iwlmvm driver.

Background
----------
During review of cipher suite registration in iwl_mvm_mac_setup_register()
(mac80211.c), GCMP-128, GCMP-256, BIP-GMAC-128, and BIP-GMAC-256
registration is gated on iwl_mvm_has_new_rx_api(). That function tests for
IWL_UCODE_TLV_CAPA_MULTI_QUEUE_RX_SUPPORT (capability bit 68).

The relationship between multi-queue RX support and GCMP hardware offload
is architectural: GCMP requires per-MSDU PN checking, which depends on the
extended descriptor format introduced with the MQ RX path. On current
hardware this coupling is correct.

Problem
-------
Using iwl_mvm_has_new_rx_api() to gate GCMP registration conflates two
distinct capabilities under one function name. A reader of mac80211.c has
no indication from the call site that the condition is GCMP-specific.
If future hardware supports GCMP offload without the full MQ RX path,
cipher registration would be silently denied with no obvious point of
correction.

This patch
----------
Introduces iwl_mvm_has_gcmp_support() as a named wrapper around
iwl_mvm_has_new_rx_api() and uses it at both cipher registration sites
in iwl_mvm_mac_setup_register(). No behaviour change is intended or
introduced for any current hardware. The wrapper allows the underlying
condition to be updated independently of the MQ RX check if future
hardware warrants it.

Testing
-------
The patch was compiled against the wireless-next tree using Ubuntu
6.17.0-19-generic kernel headers. Compilation of mac80211.c succeeded
past both modified sites (lines 449 and 470) before failing at an
unrelated kzalloc_flex() call at line 4351 -- a symbol present in
wireless-next but absent from the installed headers. The patch changes
themselves compiled without error or warning.

Full module build requires a matching kernel build tree. A complete
compile-tested version can be provided if the approach is accepted.

The patch passes scripts/checkpatch.pl --strict with zero errors,
warnings, or checks.

RFC rationale
-------------
First submission from this contributor. Submitting as RFC to invite
feedback on the abstraction approach before requesting merge.


base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
-- 
2.43.0




