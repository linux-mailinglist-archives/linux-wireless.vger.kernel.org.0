Return-Path: <linux-wireless+bounces-34237-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJjzH8gezGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34237-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:21:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5E370846
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22EAB3065ABA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D43A4F4F;
	Tue, 31 Mar 2026 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="DCb8wqu0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012068.outbound.protection.outlook.com [52.103.35.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785593A6B6C
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984802; cv=fail; b=ZWvsRwEsRl64gwZWgS40Uk29nG30mkxoFew5bVlXJheLU2WJU/Nm0NOEdRqhluBu18Ooj5TmmJXfWvp/mITSlmqf5N2eVuKY/i39aIcyyYCZstYkjOYHOvLiqQpmJae7QAG1cXBx5i2dOsGJX6cl5S2sIFG8fC+M+rxW1HKdGzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984802; c=relaxed/simple;
	bh=7rnJD9x9dO2ol0T6tSVrU34zy3NolTRLhdVOBkhdySg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChPGgtEH8tICfBs7/82+lvBgCtndWvRRd9OdAIbjkEsazQC6rC7vt1BjPVW7nEgGjAKHs1jGr7d7loWgZr5AR/5T5Af/UGZ8dZUEDoJAUeOaEvI7pju6lwrhvgNuSZGHnZPTY073IBGzQe1PImkf3ukFA8dFSvVoEDdvP0q+5s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=DCb8wqu0; arc=fail smtp.client-ip=52.103.35.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDlISKRMCkjhjU+JUzwV2vtZmuES7ZvT+u8qRH0puV61YicPMciCgvjV4r0dfygWSIsTeonxXZHwzh9i4UzhLUl/ecrTKgG+7dh5GcI/rwUmHxF7sh8VPbZ0p6f13vtMLFxXe4DkjY5cTn79jGKUuS8RpfbZv9ZI6AhAz1NMvubQhLP7x4IYUDsx4Eq+e8lzq8SyFqmqFbjoStg//jsV4af2+dDAPTxmSK5i/HX3u1L+Qf4oIPP3qXj61IwijxmNls1aGP7bj518laklZCiyRd2oPPsIrmd9flCXJaWOrvg0Yewi3Q4/Xw4Lq8gkjYwSXq31kH5mAPzMQmimP+aAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k8q6pV8Qospd57V4p0+Xk99Wgy9vnnDUq0uvb3r7uk=;
 b=t6S9KZzjyiiNipGIAk7GG9z8onf1dRZ7VLZ6NAMwDd7YHPsv76AnGdjioIKmMPWzAjctYGeko+BOF9lR4C9rcaexDc7eMrGGnKQy58CcpdOPnkXc+lk447c6TX9ehdqKHEpWhxxgAWiW6kKAPkW4gmrEQIFRiLRQREbID816cl541SjsG1yjui2H9pjpUivgkiE2dJhpwUr4Vs+l/W6YTm9uc+iTFk355TMEVb0vWRJCT6X3LgiE7ONy/NYY22IKIjCGkvixiGPxW6FU4z1wrRj+kXjc6hgzdmOo5LDZ2XZli6YhFMC85PJBG2dAzSkVFT6f79aih9y8N9oFpFkFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k8q6pV8Qospd57V4p0+Xk99Wgy9vnnDUq0uvb3r7uk=;
 b=DCb8wqu0XyC883Jid7knIMi0q7fgcKTYpe3z8otCNkE4lcYvDn7XQcBLB+d3xYqGyNoXoHqLCVlIADSF/QFPRWByfBWBluQV4uApcsUSeGj/g6zWGpvToJUNW7s4HoApQzTbo4yEbOavG9JqW2TQ9/3iI3h/ZLVVDf2e/P38sjXiHPJFPiu7QnOx0U1LQhT/M+ZRv+MwDTYd8vHrL8Wz0a0F8nQwLgM89xdr+Dj+8S5s46FkyyX9kiQ52B2pSfpQ7wwUESsX/NYl2x0ZGTFse0QFWqd1qY4bOnafOGdiFlopc+WH6CeZaPm+C64FBS5ANLc8gMVlli1znrPJ3oX1RA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB2166.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.30; Tue, 31 Mar
 2026 19:19:30 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:19:52 +0000
Date: Tue, 31 Mar 2026 21:19:51 +0200
Message-ID:
 <GVYP280MB15183B3CE2058C65AF3A96939453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: chunkeey@gmail.com
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH v2 01/10] carl9170: mac80211: enable Short Guard Interval for 20 MHz (experimental)
In-Reply-To: <c5176f7e-6806-4c2f-a01e-8b30d0a965d3@gmail.com>
References: <AM7PPF5613FA0B662B9909BAEB554565F499444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <c5176f7e-6806-4c2f-a01e-8b30d0a965d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <71c3e00963dd71fe4b3166b2feb72108@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB2166:EE_
X-MS-Office365-Filtering-Correlation-Id: f83a0ad6-5d9b-4131-f868-08de8f5a7c02
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|23021999003|15080799012|461199028|6090799003|51005399006|5072599009|12121999013|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0Y3UDJWeEdoaWJERWdOTzg5WG1ENTlLUnFvcUdnRm83UGZFTG05a0dTdjRE?=
 =?utf-8?B?a2ZkMDRWcWg0eE9vbnhtYWUrY2xqbkdGZGdITWJCaExoNTRGZDRMQTNhVVVt?=
 =?utf-8?B?NXJ0YStzL2NXZXFQUkJQZ1V6UmFveHJ4U29iMWl1NlRqeGNIbWJHaXlscXdE?=
 =?utf-8?B?d3pUdk1aSVVRKzZKNVJTdER5akxDWU1ndFE2czBsL2orRTVIK0tlSVROWWVR?=
 =?utf-8?B?T1R5RnVQN1Z2cU5XTGZ2dFFGMXNGbUtNUVpyVkNLVDNubUdmYkdtWmZMVDJJ?=
 =?utf-8?B?R0VsbngrWXVvUkVjTWlGejRhOWJUSVdSamRwenpQSEZXdW0yak1TcVhiMXJS?=
 =?utf-8?B?Nmw5T3VRL3NjcSsyWVJ0NDdIZXAvSzdDeVJDUUR2WmhFVDllbFZZM3VONWMr?=
 =?utf-8?B?WVFSUHZVSHFRc3dra1pDNkd3a3BFWmRIdUVrMVpsLzJsYUw5NUd5dnZYbjNo?=
 =?utf-8?B?aHNESzZQU3N2TXhTeUx6U3hoRnVTUk9EWDV5UitpM2tEOTdmVjNEeGlSMkJJ?=
 =?utf-8?B?WjI5ZFJSOHFLRXoyNWlqaEM1c0UxeFoySXVIUVE4N3VRV3JhdFFnUlZCTExp?=
 =?utf-8?B?eTkra2l6L2dPdVQ0S0hROHNzNlhza2Vtb1RNM3B1VFlMR050OE1JTk8vUW53?=
 =?utf-8?B?YmR5eFhqTmI4ZTRUajkrVzJOTmRoOC9wOUsyVnpqbDJneXY4Z3BwTDVpcXE5?=
 =?utf-8?B?Z0lWYnZ6QXFSNHlRM2pEYTZiajBmRzlZUURVSGtHbXgxbDRiMERaQ1V0VzlF?=
 =?utf-8?B?VlhzNTBncnpKMVFVMjNwTVZNc3JUV3BTQTFzSjJmQlAvNnI0Zm1TZDRaTmVw?=
 =?utf-8?B?eXFzd0xWc2M0dnZiZmlvV3FDQzV2MEhrQ2J4eWtkcTc5QW5UR2ZJZnNwNnNO?=
 =?utf-8?B?eW8zQy9PRlhyVjB5NjdqSGRJbjZRcUMvU1BmSEpoK1UzWk1jRURFaGtsTzNy?=
 =?utf-8?B?d2lCVlEvek44blVESG9EZmtvbVBSWkhOTk8wbXQzOFViVmRhWVdsdTgyOGhH?=
 =?utf-8?B?V1ZTL1NpdWJENm50TEhOMjl5THhxR2pZOGZKWkpySCtaYzAxcTdjYzNGVWdp?=
 =?utf-8?B?Nzkvd3VsN3lZc2JqbEV5OG9DMVZ6N3g4WGo5QWF4ZVRxdExkNGZMdFJObU40?=
 =?utf-8?B?eG0yYm9PM0srdEVmZ01QakdKUG9WMDcyWFZzanRnUzRnUTRjSXluNE16a3BI?=
 =?utf-8?B?SndJcUxiTjRER3Y4U1VDYUQ0RVFSUEdBUG5wNDlZenpUVnA0QitRY0RPUnhY?=
 =?utf-8?B?RE1LdllKRjhDd0tKd1pZd2ZHeWdQeFo0OVZJQzVvWVFrbkh4S2EvSFh1ekFj?=
 =?utf-8?Q?eYv+zu9Ux3S52VhWo4C3ZadDiHhb9RvXRE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FzL3ExQlRaQUVQakhhUWxlYk5NV3N1S1U3eGh4YkxVNjFobncxYzNvdGZr?=
 =?utf-8?B?ZEdqVUdRVE83Zmx1UVVmbTUwRGpFQUNBQURpenZKbGk5VStCTnBYWTViOE81?=
 =?utf-8?B?S0dOVEFWNzkxM1BkdnhBMituT0hhR2dzM29NRFdBMDZTdC9pK3NLNVZrZWoz?=
 =?utf-8?B?VDdySjl3R3lvcnNLUXIwYnZiTmRqZHRHRTI2RmM5ZGtmSm1DWUpiZisrOXg5?=
 =?utf-8?B?dHc1ZzVuR3Q1THhoWWgrZ1FhTmhrK2Q0Z2UyZFJ1bHhOZkxmOTEzUmM3ZGpF?=
 =?utf-8?B?czlQUkVQNURHMzZBajk3Vjhjb1B3bytFc2t5MVZTRzJway9wYi9UbVhENWxB?=
 =?utf-8?B?UnZVVGRGVzNKSnRnZnZOWWZyVW01TlRqekFvbjJ2N0NEV1doU3g4Q3RnT2py?=
 =?utf-8?B?eE5RTHE3V09iTmpVTmpwTjlNTjZJS3pNRDdpWE50MW1xK2dlZG1qdFlMVW1N?=
 =?utf-8?B?bkhWV1FpVHVlY1VMWmI2c1E5byt1RDdyNzJaNkF2dFUyRzZFY1Z6MXp5WXlU?=
 =?utf-8?B?RmJLeGU2SlYzaDVScVNrOVFRMkRsNDNkbTgvbDNQaFJId05PSUNWY0V5cm96?=
 =?utf-8?B?bTBwakhhYzBZUjhTcW5ZUEhLc05JUjBnbkwvcVVheTkxNyt4djNKQ0RIM0Fa?=
 =?utf-8?B?alA3OTY1MEJaako0b29taDN2bHczV3FRZDM4aG1zWkRCZEJlYVoyNks4cSt6?=
 =?utf-8?B?UEJJN1d5bkNraFRLVHRCY01pVkdaa0RjS2RpcWtpaDhCOEEwd2d2TnNOTmdY?=
 =?utf-8?B?Y1lJNHcwcWlsV25iSmI0QXY5akM2ZGlQL0dTbXp6eG80VktmRlgwT1I1RXYr?=
 =?utf-8?B?RHUwdm9aaTkyQWUvdjhmR0l1R0tGSjJLQ3VzNzl5dkw5QXNmUU9Xb1owUkE4?=
 =?utf-8?B?Sk5NL2pYRXJwQjNPZXpNN1VXczlZTlRJSE9DeUJKZ29WK0cvWXpza043ZU81?=
 =?utf-8?B?VVFFWG50T0pWOXlqRHhPbUdRenp3SDBMaGVZRkUxYnp5WEJBY00vVGk0UGNG?=
 =?utf-8?B?RGFkRU55ZDFDUDgrQ1MwZ0NTcG1EQ0xPaXFYTTNvNCsrWkFnZnRxM2hwOVUv?=
 =?utf-8?B?YlFOdWNGd3grQ2VlbHROTzF5emxhU3lCSXl5ZlFJWWFBQWdGQTM3VmRQMGNF?=
 =?utf-8?B?dEhGRmlNUDVtWlRCVktaSm8vRkxjUXE4bk5JVEppdGVFdGdIT214anl3QXV0?=
 =?utf-8?B?cTN3aloxQkpJQXUwM0l4ZDZacVI0eXRSMWNRQllGM1JtY0VkZGNQRGNiVnBS?=
 =?utf-8?B?azVKWnhoZVIrb2NzVjRraytJV2Q4TGpUdXdQRGdYZis3N1BLcmRCNGlsZWI4?=
 =?utf-8?B?SUNxOWZzZHBiVGFWRWxxNWJqRkdyd2paTXR0U2dCUkkzdFhUZ1g0U0J6YUwr?=
 =?utf-8?B?c1pEam96ZEpNZzJsQy95OFlVaVpEc0w5bXQveEo5dEtNWmIvK2tDSVdndWZq?=
 =?utf-8?B?eHBveWhzSjNUbGhIZnQweE5qTWRGWVBieTZsWlhEWmw3OXEzbUhodi9sTEFV?=
 =?utf-8?B?M25BdDQzOGx4dXEva0FiUXdBV2Z5UG5RQ3BaNGpEOVZ0OUM1bjBvUExCMlhn?=
 =?utf-8?B?Ymp5anJpVDNURU9YaXdZcTVsR1cyMml3OWhYa3BGcE5QclljUFd1UUZFQmgz?=
 =?utf-8?B?cU5qUElSYnF5R3Z3UHZUdU56aTFtaUZEbkJ0V01qZ1U1RGdkSGRhWU5PRHh2?=
 =?utf-8?B?bTdWMWhldlZ6d20wSFZpN09ROUNVS1pXMzNGM202NnJ2cGtSMnNZcDEra1Ru?=
 =?utf-8?B?SEVPYk5uVVNBQ2I3aDBFTTNrWHovUmhseHpHSUE0ZGt0eDJVVkRRQ1hVSUNS?=
 =?utf-8?B?TG1HOWRVSEJHK2JEUm40WEFiTTc0enFoSldEbzMxVVg4YVVTS3cxT2FNZEFZ?=
 =?utf-8?Q?QG6X66PxQT0QQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f83a0ad6-5d9b-4131-f868-08de8f5a7c02
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:19:52.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB2166
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34237-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hotmail.de:email,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 21E5E370846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2: Gate SGI_20 behind a sgi_20 module parameter (default N) instead of
advertising it unconditionally.  This allows opt-in until broader hardware
validation is available, as requested.

---

The AR9170 hardware uses an OFDM baseband inherited from the AR9285/AR9287
family which supports 400 ns Guard Interval on both 20 MHz and 40 MHz
channels.  SGI_40 was already advertised; SGI_20 was not.

Enabling SGI_20 reduces the OFDM symbol duration from 800 ns to 400 ns
on 20 MHz channels, increasing the maximum PHY rate from 130 Mbps to
144.4 Mbps (MCS 15, 2SS).

The capability has been verified on Fritz!WLAN N (AR9170) hardware with
no stability issues over several weeks of operation.  It is gated behind
the sgi_20 module parameter (default N) to allow opt-in until broader
hardware validation is available.

The ath9k SGI_20 gate (AR_SREV_9287_11_OR_LATER / AR_SREV_9271) is a
MAC silicon revision check specific to the ath9k PCI driver and does not
apply to the AR9170's ZyDAS USB MAC.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index a7a9345..b1c3e88 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -54,6 +54,10 @@ int modparam_noht;
 module_param_named(noht, modparam_noht, int, 0444);
 MODULE_PARM_DESC(noht, "Disable MPDU aggregation.");

+static bool modparam_sgi_20;
+module_param_named(sgi_20, modparam_sgi_20, bool, 0444);
+MODULE_PARM_DESC(sgi_20, "Enable Short Guard Interval for 20 MHz (experimental).");
+
 #define RATE(_bitrate, _hw_rate, _txpidx, _flags) {	\
 	.bitrate	= (_bitrate),			\
 	.flags		= (_flags),			\
@@ -2116,6 +2120,13 @@ int carl9170_register(struct ar9170 *ar)
 	if (modparam_noht) {
 		carl9170_band_2GHz.ht_cap.ht_supported = false;
 		carl9170_band_5GHz.ht_cap.ht_supported = false;
 	}

+	if (modparam_sgi_20) {
+		carl9170_band_2GHz.ht_cap.cap |= IEEE80211_HT_CAP_SGI_20;
+		carl9170_band_5GHz.ht_cap.cap |= IEEE80211_HT_CAP_SGI_20;
+	}
+
 	for (i = 0; i < ar->fw.vif_num; i++) {

-- 
Regards,
Masi

