Return-Path: <linux-wireless+bounces-34238-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL8BAswezGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34238-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:21:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37E37084E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A13193066712
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA553A4F49;
	Tue, 31 Mar 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="IKssrvCn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011032.outbound.protection.outlook.com [52.103.34.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51184223DE9
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984816; cv=fail; b=Y9c10na/yc1gk6sWaadjtfNbSOG5bi9/faaXM34xR/Ls/rZEt+lMuuB1W8uEh4tWD8MntmX9Gp8R/SZrRZ5Gyq//DsEezhp+BZOdJem3ZJI3DncrOYg6tm7T2Cc6SWvyua80lwQvEJH4cTQtjIciP13suKziZqRlAd4h/bbD/W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984816; c=relaxed/simple;
	bh=V7Au8UnkTR2rNZGgBSETrBma9Q6g7+O3J2DTQiptpRI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekR/O20uNVRTleCxc1nCjkqJFd9gZ5VMnSGeT9oxvMiiInGij/2qgZ9CukLA2t4PfCCk1WeYNgzuaEUCm/vH+oVvachQtpn61nl2G/3DgQlSU7ouaYn61olbpWZBkvwhpkHhAofjwUUyriCLykHqZeF2hJMqj/W1cbGjkkbZI6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=IKssrvCn; arc=fail smtp.client-ip=52.103.34.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD66VpS/r5MFA/yTwQ6+jg8Cvvl8jOrCvNR91ZHdN5ijA7GafBi+zwuhvbPmvphRlCnoL2J1krRk+DVJr0PAiUkrUIUpYPWnpcAIED2ZdeF3Yev6uCfuYaAnxT47B2O+Yio5nqHnilec+o3e1WW3RQOrCU/X+OKf6nUMlMSjTtsc7XqHJLYZpVq9bKSMxVWZR0IZAhzcUqoLDgg7t+MS2WwVfivBsJuL8D0U8YcSjqUAdy34lcmmJioBfsten+EpkrdVrWo8RUhV7zy/xYwCYC5Qcz4PPQ04TwHvFVgrhj6LT5iljByhF9uyQlIECV8I5n6aSHMf91k+lBA+IK1aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHZcqwxD4F7r8p7es+pREkKW2AwlqZ38rWM72s7WgGA=;
 b=uhKI/RYZ3XgVIGo7nmNBTG9DzLCPno/ndjCnCVvntYjdNKZb8VBFQbbshH0kklFLNu4Pk4luXamWDPUfkqDyYN5+t5QVbZ0H9yp6IY+9VasxtfNDORcYqAgs1Nh9UNZ0ag481iGFN2rvWxktjsBiGCFwkLju/zm1s7UJGe6qdcRg/yAJbQdZ2uRpE2KOhiQl8IIOWQhG1VnxHq5nUrhr4g6fjRvvSsCAP7Zt5JxlCAHs/Z8F4zYskLF3/jY4torznJqKwlK0C99SpB0wizAicSxfN4u7NGuQAHXZyeh3HJ3e5obOMEgoP7aMrnU9BvbxlV/yL2uAZ4Ou8SZUCGX2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHZcqwxD4F7r8p7es+pREkKW2AwlqZ38rWM72s7WgGA=;
 b=IKssrvCnSM5DlSG2U8zPSjt7vnLz+2kBxS3biCjRP4XpCYKVCocUP+odM1qESrEfQYAbv0m9DPpufIJxXG7BUtm5vt+dwRL+KvccY/HPp52JFMXtJ/4YsWEzffEk8d+eBTsBvK/6LeL2DwgmIn0wucH516+Jc/+gZt+6fkbrY5Czhha0KmjgrmlI930vcFapvDgnBd5kdjZWuRbXBkzKaO2K/DJ0cBildaKRXWAwTFgnjBQP9DG1Y338As7YEkPamOGQ2Y4VPD+wUU/bmk0t+fIUzAOCUM80B3mNM64asoqtW3Zwi/hAq7KjEvog3HftMvHza2k2mRweN1J8/pFyTw==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB2166.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.30; Tue, 31 Mar
 2026 19:19:44 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:20:12 +0000
Date: Tue, 31 Mar 2026 21:20:11 +0200
Message-ID:
 <GVYP280MB1518A978D93AF079C44F20D79453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: chunkeey@gmail.com
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH v2 04/10] carl9170: rx: remove stale TODO comment in carl9170_rx_mac_status
In-Reply-To: <ad72370b-b5ea-4cc5-98b0-701ffbe15290@gmail.com>
References: <AM7PPF5613FA0B6AC8119FB64246940D3899444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <ad72370b-b5ea-4cc5-98b0-701ffbe15290@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <82aefa40fa18365177e207f24f9e46ab@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB2166:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2cd7c6-6f77-4b9e-854a-08de8f5a87ee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|19110799012|23021999003|15080799012|461199028|6090799003|51005399006|5072599009|440099028|3412199025|26121999003|13041999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T281akM3Wlh4WGhZR1krT2VBUXA2OTNXZ0l1Q3B2VldINTgzT3pINi9oTVdq?=
 =?utf-8?B?WitsVzRoS3J6eG1Ic2hGWmo4U3p1L3IzQ2Y5dHpROEx6Vi9wQTREcWVpeXQy?=
 =?utf-8?B?R25McHZMWk5FZzB0Y1JZc0NycXFnbnhEMU96OG5WV2l1emNuMFJ1b0FubCtS?=
 =?utf-8?B?Vy91WSswSzRQYUZySGE5YzJVQVFJeUc4eEhtQ2poT2xIVGNESWpoSG43cGIv?=
 =?utf-8?B?VWMrcVZyUy9VSlJDUkpMeXc1b2JpZjVsUG13TnJWeGNXZDE0YUdKclVkOTd2?=
 =?utf-8?B?aTBsQ2poL2dpQ24yN21lTmc1TnFIVWttb0NucnNWRnUyL3N2eFZJOWkvOXZk?=
 =?utf-8?B?Sk1wUTh1UUlnWmMrejVTRnBNaGsybFBDUDJaTlg3cWRvSUJ6UmtOOUVCSllZ?=
 =?utf-8?B?QWxVbWFqMmVXcFE3d3FUWGRyS0xnQzAyUldKSitMUUJ4aTRUMHQ3V2VtM1h1?=
 =?utf-8?B?UkJYdTVqSnZLZEUzUnZmTlVjbkk5MXFRK1Zrd1ZsRU5OY2FicytSKzRvOG51?=
 =?utf-8?B?YVl2OGxFWHhNWjlkbS9tTWxPbWFuRzdWQjFucUZBZFZTOFEyV3ZQMVU4WFEr?=
 =?utf-8?B?R1FvMHdtTTV3clZHdHZpY1RMZGVUQ0dOaHN2bHQ3MzArOGtZcTV4Wmk4eUFZ?=
 =?utf-8?B?cG1LV0psUEdKZFQ4K01OWUFwRUNJWnA3bHZ0S0Nia0EzbzJCalQ5aGFWTjJT?=
 =?utf-8?B?cEs3OEdGeEIzdXJpYmo2NXNoU05zMS9pY2FEK1Nad0wwVnphNVBwOHNHOGpS?=
 =?utf-8?B?Q1p0eVdFb085SjZSbi9UbVh2NVp1Uko2ZXZJajBlRGVGOFNMcnZnR3hablor?=
 =?utf-8?B?aEdsOUFEY3NhQm1SUTMxYkdpeG5MNmdBK1lHTVl4b3k1OUZPb0UzeUVMREs5?=
 =?utf-8?B?Sm5vMFdYQjNKQVRxVUF0TzlRMllYaHBZeTUxaFFMeFgzUVRWZXZYbytoSHZL?=
 =?utf-8?B?QzRPcnk0WVhibVRybGg2ZFNnS0RQZkZrWWZIWE5wT0FyVHNQemk4U2tGQWJq?=
 =?utf-8?B?RUZEZnJaNW9yVUZSYTh4RHRCUWpXRXJLVjBwMERXcml0THBIZ2dJZmVkT0FN?=
 =?utf-8?B?Q283K3JBOVp3Zm92dW1PV3Ftb1daVWpkSlYyOHoyUzJ6YjNydDQ0WkVseTFK?=
 =?utf-8?B?QzAxVVk2cnYwMUd4MDBDbDA1QThzdGxic1grcGZVTlFyZUorNHJ1dStkWHUr?=
 =?utf-8?B?SmM2L0tYbCtmd1QzWUtkVll2RThJK293emYwZ3lhNmpRajdaRmppd2R4cExt?=
 =?utf-8?B?ZDBHTHl6bEc1SFV0cGJMWXdzV3FxemhodzA4VGZJTmc1Z3JJQlpZYzF4Z0Rj?=
 =?utf-8?B?dTg3R2tvQXZ4SzE3RmtsSDl6OHltMXVvbWR6YVhXdkc5K2g1WFlwMTJOcnBh?=
 =?utf-8?Q?dCeZOVkPbBu1Ea426QZNKvc8E4UWZ7IQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmxPRHNoUXN2UXExREovODQycTM3dlU4QTVXL2U4SkpQVHkwS2hGbU9vdDFz?=
 =?utf-8?B?SEJ3a1ExYlh6c3FVZHI3elRnQk1JY3hDSkdZNWxrVVZJNmpCZHlsZGZGZGg2?=
 =?utf-8?B?M3FCK0VPV2xsY2dKZGtYOXdYaGVudTJ6aHVTbjZMa1c5RDl1ZjRQVHBkTmVX?=
 =?utf-8?B?K2xuMnRISnVyOHBvd3k2UVdXdVdqRm80TEZVMHhJOHFkTk5DYWpLa1V3eW5X?=
 =?utf-8?B?Vy8wYXlVVDEwMUpiTVJZOEx0eEt0NXZVVjdmeTRWLzZzL09Ga21zeWxYeGU2?=
 =?utf-8?B?WVhqaHprQ0NJbnZTS0JaTkxiTGQzUldlZTZiTVQyUmhCV2JqYUtSdUJUMXBM?=
 =?utf-8?B?YzBpNEIxck9aNXFVRHkwR3pERmFHVUpwcmsxUzFYMFNYU0Jucndvdlpra2RK?=
 =?utf-8?B?MnpCaGdXK0tqOXdNZHhkbWF4NzRMWUd4bkdXNUxkZ2FjMG1qWHN5ZWI0NFQ4?=
 =?utf-8?B?eVlZd25uZ1FvV2taVFJYT0cxL0VjY0tLcEZNbU1IdFhvYXJHUHBkcjRla29D?=
 =?utf-8?B?MVN4U0ZLbDR3TWhZeXQxWVN5ZlU5bFgycFpzbUdpeVBIL1IrMFgzTmI5STNQ?=
 =?utf-8?B?Z0FQd0Viem1aNU9hb1k1WTl2N2hTWjMyQndvbktneCtSTFV4S1VyS3FxcUhS?=
 =?utf-8?B?bDRrSWkzV2w4ZEJkUXZ6VjJBQzZSTTlyT2xCbWRJcWVzeUV5SjArb1Y4N0tU?=
 =?utf-8?B?U3M4VW5YMER4Y3RyK0syUG5zVTFmZjd0Wkh0MFhwVUUwczhyMElGREx1OU9N?=
 =?utf-8?B?VHZwVEpiMHhPZVkzS0IxeHh1ZCtoY3l5VXZtendkU2RkcklKUXM4RXJkakJM?=
 =?utf-8?B?QTNEeGp3U2tGM21sUUZXTGxzYnEzTW5uUkd0RXg4Z0EyeGIxa0tsYzVVYkgy?=
 =?utf-8?B?SU0wYnZweFF5dlhsb29mejY2a2dTV1ZxSHVEbmU0NkpxcUhGNm0wV2xDMU1E?=
 =?utf-8?B?SWpQT1lOTjQxSGF5cGhBRDRBSHRuTVZFbkRpSE03Y24wZ1U5NFhhM0FReGRY?=
 =?utf-8?B?cWc3Q3hEalFjMytlalpONTgzY1JYSzN1Q0VlUDcrQncveGRRcFdxZjd1Qm0w?=
 =?utf-8?B?bDhWR050aGJvb2xhN1UvNWMzY2IyOFdjWE53OXFSaDhXZ1VjRGhHdnNWSDl4?=
 =?utf-8?B?MGRFVytoVC9oeE00OXhESTJlTS9GMU02MHZXSXdRNzJDempoUUhWdHQ3U2xZ?=
 =?utf-8?B?VE9BcTgrTnhwdVhxSncvcWl1aGJoVzFhakc0cHZhUnVvMEc0bzcwYTdoMmdR?=
 =?utf-8?B?ckpZQjBVeC9YcGI0N1ViY3EycXlMaUQ1Sm9OOFBuLzFSSmtDWnIxdHo1WnV0?=
 =?utf-8?B?SFNtcEsvdlEwNVJUYlFpRTFsRkIyeTJUbmQ1S2x2d3RBekM4cVVhUTR4YXRO?=
 =?utf-8?B?WWFIUVVIdnRTUVZidG85RVdzYUM3MEkyMXM2d1NHTTdNeW1nK1VJb1YrRGFl?=
 =?utf-8?B?ckRsN21VNVFkd2NGbENMMVR0SG5kRGlJMCtGRFd1YVppZFpuS1g5UThBYmFa?=
 =?utf-8?B?U2tzUDR2a0c0ZXpITnQwYVE4NkxCMUE4STBkcU1nQTVVQTE3Uk5SalNYWTV0?=
 =?utf-8?B?K0hwTUJ6Y2pXUWtoS0VDL2dXZ2QrRyszWmtCTGdvbUpOOWdiK1VsMUZSWVRj?=
 =?utf-8?B?aGJWYndlTmZEeWwxSWk2OER0UFF0Wjd5L1hsekZmNEcwQUZpb2tNQU40RVBY?=
 =?utf-8?B?bnpvSllHRFM0WTdOTEVMSGQwYkwvdVd2WS9ZM1RRKzFtclM4MmRiL0tpczFQ?=
 =?utf-8?B?T3R5cGFnY0d1MXVMYWdOT3lURFhLdFM1TldTNkNseXk4NEx2cFlhaGZ5SW9G?=
 =?utf-8?B?a2hTQmhMVVVsd0QvYUY3WXAwWkR1cURzZ25CYytseXdZUSs0NjIxbjJ4VTE0?=
 =?utf-8?Q?ZqElygX8GO5J5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2cd7c6-6f77-4b9e-854a-08de8f5a87ee
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:20:12.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB2166
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34238-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,hotmail.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA37E37084E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2: Drop the ar->rx_dropped++ addition entirely.  The caller
carl9170_rx_untie_data() already increments rx_dropped at the drop: label
for every frame that carl9170_rx_mac_status() rejects with a non-zero
return code, so adding it here would double-count.  The patch now simply
removes the stale TODO comment.

---

The TODO asked to update netdevice RX dropped statistics for frames
dropped due to unrecognised MAC error flags.  The rx_dropped counter
is already incremented by the caller carl9170_rx_untie_data() at the
drop: label for all frames that carl9170_rx_mac_status() rejects with
a non-zero return code.  Remove the stale comment.

Wiring ar->rx_dropped into netdev stats (get_stats) is handled by a
separate bugfix patch.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430..c664014 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -340,8 +340,6 @@ static int carl9170_rx_mac_status(struct ar9170 *ar,

 	/* drop any other error frames */
 	if (unlikely(error)) {
-		/* TODO: update netdevice's RX dropped/errors statistics */
-
 		if (net_ratelimit())
 			wiphy_dbg(ar->hw->wiphy, "received frame with "
 			       "suspicious error code (%#x).\n", error);

-- 
Regards,
Masi

