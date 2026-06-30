Return-Path: <linux-wireless+bounces-38365-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lLQrAiSxQ2r7fAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38365-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:05:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A76E3F9A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:05:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=N5zAYKuZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38365-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38365-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B37BA31FB1C1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FB0409E0A;
	Tue, 30 Jun 2026 11:38:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32541409613;
	Tue, 30 Jun 2026 11:38:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819514; cv=fail; b=jdxDU8FKvmk6zQ1kP0pq0+60ZsUttPaa1aeoolww1Hhf8Ax4/idKvrttdZvZZbFR5uEaRasdRgXQGX/7FbjvS/Ajid8LPwKcipoWaJeOD3vmoncv2DeWKiDrS6YTf01iZIIu3sGz8QWaABYZYq571AEHgyZ2sCqAwOPajO73qVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819514; c=relaxed/simple;
	bh=FI2yKY3xnC4fYFzsmgJyD9JenOb6HRse8BqxxP8B1dU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qClS/oGSp/HR4D2lDfPvxfvarSXio+A4Pog5jeEjQtixScNiunI71CsSsxM4CiQw/e9VVxogwNxRFE8j76gLzpTQy/fgFdyDqosYxew895D+cHCGXMeF3XBZA59E5CXvq/3jrgJdkeG5rzVCvEk5A5s8+W1WCBozOGLMGga3AZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=N5zAYKuZ; arc=fail smtp.client-ip=52.101.96.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ/B6LmTQ2tuoZ079pSucz/mGhieV1Ol+1p81OT6zIFh0TJ9526AxAXOYKlUG8UXFBHc19v8gS30J7nGeRQBbmFFbaqVccb6NwvBivSOlrSiekRrZBSPf4Y35iTFFPSLmDRluFiBfXJSCKTtBpotwEZ0jC6xazWjC6IVCULPqOY9r2RmpgBALW5v2dYPuhjdqiffdsuWBLx3zu3K6Ie25bSipE91/b6YFLaVFkwa/ydMnDkwgWqFIbfHJp1FFHP5OPYJcarKWd5znZgSTF2zWC0D4+GcnwSnzKXN/tqu91f8Duzbi4G1YC+wujZGMrX36XRfk7YnCB6LOivFXW8gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vopINuj3a6/fqJT+CP772K6tPFJ0XFu6MogeAObO0vg=;
 b=Td2QIcB9cEoBGU2faC+rXz9pIMHzzqyLAsjPghvvpKF65vf5lDGlpeKk5W43RPmNkY/BVL/z3cF3eJ9uHJG0DqGssjRh8Tv3OKnk4eQjF2OozGCLVZ4imgz0PAqX5ONXefbm1RlcyqKiTZO6B6h6RCtHemyqokiArpn3f2R3AyNnC9d417BXK02gyQ5uuBuNP2VOecAH2SqwuUbco4yND4sPaIts/IanZaTK02Zpli3w83XBuSNyoXL4tApYupSlAmiScZkWFYu9AkoFP46ofa0rpOAbZx3qamCw6zRnX3btIzlozPt4cVNJnWJGvoKyP72HJVAz517y8OcyW4coZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vopINuj3a6/fqJT+CP772K6tPFJ0XFu6MogeAObO0vg=;
 b=N5zAYKuZ/O3e6i1Usb6BUtPbUc1OXNF1l6nGFeB+yb9yY9TIHxz6/4TUjY+KELH3FduJpVXA7HCKl5h8u/se2g/X8V/CJIreqg6YsFOUAujazoT+qUAXmnOwp0jreAFqp5RJ7mRAHII6TNM6Ld7mYkceqPQq/F9wDqq20ER+uVA=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7243.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:38:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:38:24 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH 0/4] usb: fix UAF related to dynamic ID
Date: Tue, 30 Jun 2026 12:38:17 +0100
Message-Id: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmqQ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNL3dLipPiUyrz4zJT40sQ0XcsU0zQTQ1NjC/MUEyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgC+9Y4OcgAAAA==
X-Change-ID: 20260629-usb_dyn_id_uaf-9d5f415387d4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782819504; l=2258;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=FI2yKY3xnC4fYFzsmgJyD9JenOb6HRse8BqxxP8B1dU=;
 b=sUmzzjrbOb7ceBi1NtAP6vCpZAv3FCEOlsHuViGgwp0MJXRT1YjURsL9zhEYku9uYydHPuocK
 +7STE7RKv94APqYZ1yunO2hkaluPdpAeANsc2g+0ac7RleETNdtz9xO
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b506251-be99-4810-fc32-08ded69c1836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	S8i3cyeQpC8vE9psaO2ZSTgkZ25HP07ulMyl0fi1TmCdQYG5oatKqS0SYQNDsNLt1Tp2LqdZK20odn2jaY4qMNwpNx7HXBhysJ87RZh+AjqFuw2418CjKNRXpKXZu41YLw64tYIGwjjsqJkUWIw91hpSz/9vtn/xuPi34EyRSFPBJa5Cjl8rrJpHNWQUSguAiZc914ofYlXkyOoa2bd7Xs0/Du4EQ+l2m7dkkkmrROFlUpzVpI8ZA+y/4bcwr5VeCAxFFcjb0HHk6CTXRrPrXTvQOpPZ9NVBx0aEjwNG+CeK2yc2cdoKDG+Bp/Siu8jkUUi381hGxVW41BvU1Evo7Dbb0zcq/xuE/cSRxnMRw/i4QIjQsIA27eSt51gg2fdDtGY1jaYT50vaiCjY3qL5fDvLAAVFXxyaxJgTobc5GG6LQIHQPxJ422sO7GjdEHgrGupaJGhk1BUu6dYfLAEZa+0ygGg8F43rlRGCReUHMtj8Zldwag+iFRRPU5TMAppvESjO8fiKZRkFHuRVl6edrXJnXutGEYEZIj44QzVLlO5zrDVLCQIVFCMOshISHtso9TRZDNoE1s/l53Vf7qsHcFBVPLXbbGY6nbebZtsl9WOpH9r0ahw0qtil8WL2lDOLsGwY61nM/nfu6HRZVE5w3GVR6Y2Rwtu/Lve+6zftOBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZDOElrMnZDTUZUVGt0Q0FHQXA0cHZHd3F4VDJQUE91QlhDSjR2bHo4azY2?=
 =?utf-8?B?dTczMUlDRTh4SVZSWDhQZkpNWllROG5NNVNZTlNEK3NJU1Zjd0t0MExkdUkv?=
 =?utf-8?B?M3NxK0pYZTUzOUNYWmI4VE9TbDFQempYc3IxL1ZDY3RvLzZFendMRmdZT0U4?=
 =?utf-8?B?bW1DVGxld3dvRkFXVUFUOU1oUVRiejJ0eFBHeThoN2VIWEpvRnJ0anNYdC8x?=
 =?utf-8?B?MmN6RUxtNUgvM1hEaFloWW4yaUkvdmJ5eVEraDZBT1NGN3dhdjcwTjI5MUdH?=
 =?utf-8?B?RUlGWkFGZTBLRFlMRm9VQ2VCazNBb09mWXZUYWFTbzk5YTcxTU9ucjBickZ5?=
 =?utf-8?B?SHM2bkdkZnVIV3I4ODM3UkNYcnNYM2JrODdnNi92ajBNMmRFUEdTT2tWeGZS?=
 =?utf-8?B?MkJqR2s3bE95c0tyeEk1NXkxSmEraXhobG5ROGllTHRNUVZTUUNoRjNWUGl6?=
 =?utf-8?B?TjQzMEdxVTZteHovMzJtbndQUU9pMWR4elZPM1RsOGxZNEc2ZVM4TkprclRP?=
 =?utf-8?B?dVBqUVVwUy9iWEk3Uk1YbHVnTUdVL1FldUMwTVBaQXdwYVBlOHY0Zk5pQk9H?=
 =?utf-8?B?OGdxWXphc3NTbFNRVjNSbFYxbFo4djlGL05ZaE9XWDd0RXovbWhDcTh0REdn?=
 =?utf-8?B?SmNvcFlTbHluUmMzRG5ac0ZmMVl1SThHUTJtekwvSzVxTGg0T0dPT0g3QlNx?=
 =?utf-8?B?bG1ncnI3Rmg2ZkhyM2szTlc3MWdLcmYxSmoyY2JkZlVtNWdCRXRhMHJLOEh3?=
 =?utf-8?B?MmhYSjNLaXdaZjRqUHUxMlhHRWREMVp4WkN4ZFBFUlA2cjV5MjQ0WHFKQmhy?=
 =?utf-8?B?L2d2eTZ3ZnE1VFZESFVSUXoya0ZWWkhPTzdzdW54QVAwSE1ncGVhVGdXaUxW?=
 =?utf-8?B?Wi8xN1pHNmJ6VDVrZHZwcHA5L1VFMCs3WUh5MUxaeHF0OExjZVdEcVlHanpF?=
 =?utf-8?B?L1RPQW9NZTEyOGh6NU1ld2IzMmtRNlZSSFUwcm1XNmVWL2hseWwrbkFZdzVo?=
 =?utf-8?B?OUxZNnFXY2ZULzJDZnNid2xMWU9DQzJ0TnRtd21wblBWNUdUbzFWZ0JGM1VL?=
 =?utf-8?B?WkJubGswV0NORzVzbzc1R0REVzBSa0FvM3pVMW1sd0xreGVVQzNjTzU3aVBL?=
 =?utf-8?B?elQ2TWlrYVFyUXJ3NnhwWUhnVUM0M09sU3hjVEZOL0VnSGJPMUNMUGxaWFpj?=
 =?utf-8?B?Ym9VWmVnM052RHJEV3BEU1cxY1UzVld2b0MwWnowWG9VS2FmaHBGM2Fadk93?=
 =?utf-8?B?eVNyZXBMZTVCTjBvaUJxNkl6ZW01aTd0V0ljTlBJZEUwaW84bXRoeUczSy9N?=
 =?utf-8?B?YVRUWGEzKzVodHAzQmdoaE1mb1VyZENRb2Z0V1J1NHprN3YrZTBTQ0w1R3l3?=
 =?utf-8?B?KzV4K2pvWHpja0N1RkoxU0p6U1JCVUZJeHdqdzRpeStRaWNJcm1KYjZYM090?=
 =?utf-8?B?ejJDUGFtb2ZiNHRyL210aTR5R3ZrdUhqTXZVanVWZHRJQnhPVGVaRk5NUVJu?=
 =?utf-8?B?cHorOUw5L01wM0t3bW1JM0tuQzFtUEVPbytFU0tPRERUN25BdWRBc3ZoRmlV?=
 =?utf-8?B?K0ZJS0o1UTF0VFh4clkzZlYzRHk5ZWxXMUNYaXpYckJTb29DK2VHM1QyWGZu?=
 =?utf-8?B?MFdraGZKQ09XR1lpVWNQSVpsQ2Q3SyttcHo1RDhOdkkwTmQ2M3h3MjlZYUpY?=
 =?utf-8?B?Nzc2allsQVp4NGxFRmNkWUdoM3paRDdReG1JVUYwYUxwSnR3RmwxcUlBelEv?=
 =?utf-8?B?b1JWUFpDUXZPNUpOY3NYNlVuaFFYTnhtT3hCdXQrZ1VVWk9KY3Q0SEJ3NktS?=
 =?utf-8?B?Q3lmNFFlSGVYZHdvdXlRL1NFZlZacFNUSXV3bElEVjh0MStGblM5c3RtZUI1?=
 =?utf-8?B?aG9HTEljOFBvZ2xRRVRWRWFFOFBTVlorMzNKQm0remNNTERXdnExY0FLMHVo?=
 =?utf-8?B?UjRLNyttbnpuYU5YbmY1aDFUSnRvZGlXaHlUZ21jZm5venh3ZHhvN2J1SzdW?=
 =?utf-8?B?c1ljL0kzTk9tZlJ5a0hSK3VJTFA1WDRjUFRTeGVBNEQ2NExIdWRCeVR4Vk4z?=
 =?utf-8?B?SzFCQ3N2MXl3WHdNbnVwV0hQMDZETnBKK3E1eTVObXJRSFBiRCs5Z1psd3l0?=
 =?utf-8?B?QkNaVUZyWnpldUJuajJLcG5xSVVsbGRhQjlldktPYWJGeFFOMG1lWXNWaHVQ?=
 =?utf-8?B?UGlmd1ZURnBLVlJ0ekRWTjFoMVBzQ3IyUHZadDA2b2p0Y0RxSlYvejJIUDFJ?=
 =?utf-8?B?ZGhaTEpJdVBaUno0Y3FTWmFwUGN1NUZrSmVrVUM2STJ5UDJvb3M2QWhKczUy?=
 =?utf-8?B?SG4xekFIQVBlZlR1dU1ONFdVVWptVGNuclE5TjhwYmtUdmJVY0JRZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b506251-be99-4810-fc32-08ded69c1836
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:38:24.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO8CxGoVEdCTKvgdY9GqvtqBHHwIU/lxa2aWUvTSE/LUInTADe5IX300VDGRnzlaBPdItBm5u6nNRIySA87Pvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7243
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38365-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:gary@garyguo.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 791A76E3F9A

This is the USB version of the dynamic ID UAF fix similar to that of PCI
[1]. usb_match_dynamic_id returns a pointer to field of usb_dynid, which
can be freed when dynamic ID is removed via sysfs. Fix it by making a stack
copy of the ID.
    
There're 2 existing users which stores their usb_device_id argument in
probe callback. This is a bad pattern because nothing except driver_data
inside usb_device_id is what they want. Actual idProduct information can be
retrieved from usb_device instead. I've used the following coccinelle
script to find the cases where the argument is stored and converted them to
stop storing usb_device_id.

There's an additional user, spcp8x5, which also stores usb_device_id, but
is part of USB serial which doesn't support dyn ID removal. However, there
is no reason in keeping the usb_device_id for it anyway so it is also
converted.

@store@
identifier fn;
identifier id;
expression E;
parameter list[n] ps;
@@
  fn(ps, struct usb_device_id *id, ...)
  {
    ...
*   E = id
    ...
  }

@cast@
identifier fn;
identifier id;
parameter list[n] ps;
@@
  fn(ps, struct usb_device_id *id, ...)
  {
    ...
*   (void *)id
    ...
  }

@in_struct@
identifier s, fld;
@@
  struct s {
    ...
*   struct usb_device_id *fld;
    ...
  };

Link: https://lore.kernel.org/driver-core/20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net [1]

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Gary Guo (4):
      wifi: ath9k_htc: don't keep usb_device_id
      usb: usbtmc: don't keep usb_device_id
      usb: serial: spcp8x5: don't keep usb_device_id
      usb: fix UAF when probe runs concurrent to dyn ID removal

 drivers/net/wireless/ath/ath9k/hif_usb.c | 12 ++++++------
 drivers/net/wireless/ath/ath9k/hif_usb.h |  2 +-
 drivers/usb/class/usbtmc.c               |  2 --
 drivers/usb/core/driver.c                | 33 ++++++++++++++++----------------
 drivers/usb/serial/spcp8x5.c             |  6 +++---
 include/linux/usb.h                      |  3 ++-
 6 files changed, 29 insertions(+), 29 deletions(-)
---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260629-usb_dyn_id_uaf-9d5f415387d4

Best regards,
--  
Gary Guo <gary@garyguo.net>


