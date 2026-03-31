Return-Path: <linux-wireless+bounces-34244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDLqDDQnzGkmQgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:57:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF2370E70
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD221307411D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B804D39021F;
	Tue, 31 Mar 2026 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="vGCcvAhB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011036.outbound.protection.outlook.com [52.103.34.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F947371D04
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986735; cv=fail; b=o1DXNVThfbfOrgnbKeJFHSD7V1BIXJmIfnBb5AuH8uZqqdYKeRtvbKGzdHU7+5ZPEZkbiMfkF9u4Ep8rFy+TR7Q6Uy7p5FhccGxoMK/UX55i0aXwL01FDfnPG2T45G5PzKkLR+3B03oSnAHzWqrvbnTvAyXydG3Ste2IadbrDyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986735; c=relaxed/simple;
	bh=fTw93zKLbn+EBeSSElkP64Iw2LCdY/e2nuewk7FvDac=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=Y5mOgt1ZrLC9CfpEkG3JNIMBLZtApjbCJP7uo5CpqrIkGufQK97TxD+eVQqP8owLKEL91iKeIIpYNPTqu78j9q1QP3ejVYpJaCt5EqRMIwEUC3osm+zscXRzNgLzqt5WIhyRxPzqQVYVmL8sYcVPG8DZLRr8a5DyPRcCrv+3p1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=vGCcvAhB; arc=fail smtp.client-ip=52.103.34.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y86c2Y4ZE4zawe984/FHtYy6AeYFJWXLldfwxmR6YuS9jav5Zf7evUZybCTNaZyAszEHL/CIR6vbCWjFREkmYASkakKU3Ej7VlRM7MiIA5PSG13HIgrYBqiGjRVCrsS00yhbmwv1f8Eyn6Y0i5thK2Jlg80nsTLyi60+MfrJRusFDhczRuLndX7quChKhv5cuaWDOUwnOSxdUyywq/OSvvwbcV/N94donisxfnBrxh24lrLDfImUTi81gXHBvm+YhB1CvZXRHTtNM7rI7cEgHhqV2Quj9UxP2RfdY83rXVGdE3jLuiCDe2WAzHMONKZLvCHs6wWenCIjxpeBP1jEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6X40F6wLY6FC6SH3nUp09vkaA7tDj/80q4VW3AfZRI=;
 b=k15flKmbYqLQ34S5zNEiRKLgNGuTMiqu5YtwSZAmW3zoE8+f3xpnb9VahsdDhDeBRSsg1poNAyE6Wyt6ztcB+3StcxhOFNNiCzvG1D4XXCUsFovdy8scpBnNqN+qcQ4j9OtPCsSXCTfFrAP72zOV2P5sYrZtvhGJ0xUZvj13xb6GI6RAMHRhKwBZnxBCFfR6o1c9lbpUFkWvoOaH+VPN0wTFyIqP2YvrzPrg3TXip9Ss1MIbNILoooT4Ue5SepLz5i3a2sN/a7FLJpd53w/Nf+8WL/KRYDEWG3GLnjUXwLw8bPcIbdbnqGiCG2+fFi5uGkQ8ebzBT/4ol5JDrwHfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6X40F6wLY6FC6SH3nUp09vkaA7tDj/80q4VW3AfZRI=;
 b=vGCcvAhB0jt2sC5/zIuOXmeOiPN2UITIIA8BSHEJKt2W9G27cQfJR0RjzC03M4MZ18e7m7rrSS0QW/kP4funprUKnWjyk8DZv6PjoSkvJIRPn1/J24QyXUi1s4w+zHWqQZZrGz7mS3YS0oTOG276rp/O19H+frK/yqCmSkGtTCrvu+c+UdgTAucEx7J93dECcNYRcslsz5ePpIbv8rVaKYwQtJmzEGo592emF9cogIyBXeLtZLwmyhe3XudUKc5L6L1udC+E1enA+SduHfHo5CQaMlgvgnNM30aI05E/lygXXpmEoy+xWTyIvt/woTdCPaD2xF+SvDCOGGzWeEzykg==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV3P280MB0433.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:52:12 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:52:11 +0000
Message-ID:
 <GVYP280MB15183AA20A65C0C5C03D09699453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH] carl9170: main: track sw_scan state and suppress transient channel-change errors
Date: Tue, 31 Mar 2026 12:03:00 +0200
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <6845136b3a0015760b4fa24c170614c0@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV3P280MB0433:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bc2674-4fee-4406-b86e-08de8f5effe5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|23021999003|5072599009|51005399006|6090799003|41001999006|5062599005|8060799015|15080799012|461199028|3412199025|440099028|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RBNWsyZHBOSFNlbi94OXUwOUpRY2NYUDBRUkhadUdJU01lZUF6WHVyanZ0?=
 =?utf-8?B?MWRPM1VHZitYSUt3bThsS0VjNXlDb0Q0aUwyVm1JZjlIdXkxR2VtY3h2ZEVi?=
 =?utf-8?B?d2NNdUlnWXZzR1FuclFpM3VjU0VRTXZ0cmdTYU44MlFYUHJCVkFJd2FmcGRH?=
 =?utf-8?B?Q1hNbFNUV3BCc1ZOMUwyTXBiOHNMU3dmMHFGWkQ0NGRSK0FjN1dFMEs3WUV2?=
 =?utf-8?B?SW5mdEExaUVlWjFaUlRwYWFhWklmalY4dUVDN2wrbHVkUk56Q2M4Y1E3UVdE?=
 =?utf-8?B?UzE2OTh2UVpPd0VTNXNiQko1bmtqNWhGeVJQMzVIaThBcGVnbTIxcWd3SmlY?=
 =?utf-8?B?cEhCaFhOb29JNk42Y0w0cEJqQmVnaGp2N3dGTmlyRFBURk9CRG1IYVdZZW9m?=
 =?utf-8?B?cnE0TEljTGdCYk81aEtNRzRwN1BaZ3ZnNTR2RksxeGROdkk1dmlGSVIwdFVP?=
 =?utf-8?B?S0tDZFhucytBaGJrYnBmZmNjSEhRb0k1eDdlMEVTT3BjazhMbUZyM1RDbmJr?=
 =?utf-8?B?TWtyNDBQOTJDZEVxdWwvbThyUjczZXA1dmt5WlM0aDhrNnJyVVZSUTY0U0pR?=
 =?utf-8?B?bUFyNzIxUVpWTjBCT2VpVzY2S1BkZVZ2eW5zbTZNWTZGNGwxbmVmY2FlQ3Fs?=
 =?utf-8?B?TXg1SlVReDR3YjRDTWxraHlpTXkzbEtocjBtOURCOHdjcTloMit3eHluUTlQ?=
 =?utf-8?B?S1A2b3o1Sk14YTQzOTQ1L1BtT09uOTdDVkFFa2RLcnZVVDNmVW1iK3lXNTh1?=
 =?utf-8?B?NmtqMEpMMHBqeTVqMnFIN1EyREF2L3UrbWlRbU1jWVpQOG9sWXo0VEtiWHFJ?=
 =?utf-8?B?TnY2aXhYQmhsNWNDSG9Sa0swZGtKQ0FMaEhpbWM0bVFlL2hSeitGdzVpc1ZG?=
 =?utf-8?B?K1FzTkllQ09JSDk5Z1Z2UGFiUzlZREwzM1ZyRi9YeHduTEt6L0RFcnZHTEgy?=
 =?utf-8?B?eHlObzF0UmJ0cXROa3FsWDVXL1ZzakFreW9BcW1QaWNZRUpWaDVGZ0xTcnRN?=
 =?utf-8?B?VDNReS84bmRpd3pmWnFHR0lGTlk4NjNJb3RYaU84OVVCMlNsVUtuSUNqTDBZ?=
 =?utf-8?B?a0w2KzNleUtTSVlSWGZZcWgwWXJUcDhaUXVkSzlTNStoaTRSSnJwZ2xNL0NX?=
 =?utf-8?B?d0I4amxSMk5sa3YrNUR4Smk1WktIbSs0RHpuNk5YSGZOajQ4b0hiODIzOUpv?=
 =?utf-8?B?dnZuUGFoUUtsa09TbHJvWXRxOXY3UE15NU1HVHNzd244NnhpV01TS0YzSXQy?=
 =?utf-8?B?b0hZTGpPczVvUWlHOEFPVys0akVBd2FFOTZZbERDZi9tQTJlOGZrcUZQY1Yy?=
 =?utf-8?B?M0ZyVld3WmR6T2hFUlI4K1Z6SWl1TkZQRWM4S3paTVZsNUdQVTY3ZEN2eThY?=
 =?utf-8?B?Q3hVVFdhUHpKTnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnBmTlNTSlRHZFNZOXo5R1Y1VTdFWmhOYmdBNUNQSXc5SzU0aDEyZkNqS3la?=
 =?utf-8?B?bVBBb2Jibk15bkltVUY0QVhlc2crN3owVTF1VXk1RUFDQXAvQnlJS2dIbUZL?=
 =?utf-8?B?cFhEOHJweDlRVDZkUTY2dHZVM3NtYkg3YzVlK1poTVB0TUJRQWtGSEQ3ZTJh?=
 =?utf-8?B?ZnFvY055eFc3TTVBdlh5VmZ0aGM5NWpRYm5DdFY0SVFabEVuNVdEeUlXdkhy?=
 =?utf-8?B?QU8vZ2l5WnBxK1BNZElrUG9RcmI0OVYzZ1Nyd1cyZTJmYlJDd2VOM1BadTRp?=
 =?utf-8?B?NW9FR1d3NklsVE5HR0o3UzNsUTBhb2xRRTBqY0NJWi9Ub3F2ZEZ6TTd2ZEYr?=
 =?utf-8?B?TEhBb3FDeVhjYWY4RVFMd1Fsd2tTSnp0VG1EYXRpdU1ubitXMEpGMHJuUEg5?=
 =?utf-8?B?aFZTR2p5YityM08xRXZvTUpoUVl4bXgybmRoRWFPd1c2MXBERHBzTTE4d0dV?=
 =?utf-8?B?ZXRsbzJaS3FyU1NOU2NseTVkZzdvWHZpbkpSVm14UnF3d0pxOGp5cUNZSkFp?=
 =?utf-8?B?VWRybVlKSzJTQlZoOVErOGdRODZFdDlGRll0L0pVMWxRcHVjdXBNWkJBWFVn?=
 =?utf-8?B?YW5NVUdyaGI0RzNKTjBtUlloc3hleEFsd3ZFWGg0dzY2Zm9lMzhOcjgzZkJ6?=
 =?utf-8?B?L0kyV3BFTGtUYm9NQTMxcjJXa0w1UXBRemw2NmJzS1cyeGVKQjFHUWVaeCtM?=
 =?utf-8?B?dzVNRzB3b1dsWEUyWXpDR1B6dHEvK29wYnVNZ3h4NHlDZTNLWGZHUnlMbFhk?=
 =?utf-8?B?OG53cWxRcjduQ2cxYzg4WWZEZWRGYnV5bm5zZXBTbWkyWlBqSndFVnhDSlFy?=
 =?utf-8?B?ZlpHanpqTHFYTERIQ2JYYUd0L2Z2ajBTQWhpQXBOdjJWbndCQnZFa0VTUkly?=
 =?utf-8?B?L3pVVUFHV2ttazFsSmhkdm9qdmdkdWc2bndZak9taDhvTjlKVzRwRDRpYUI1?=
 =?utf-8?B?MnNlZUhzN2k3dmc3czJPQVdHaE1mNXBFUEk4ck8xY2FNd3cyUkxxTE5ES1Bn?=
 =?utf-8?B?Q3hsM2QrR3JvNzNGYjZnNFlWME1pZnhWVW0va2xDSFVYSDd5T1hkK1Z6RnN2?=
 =?utf-8?B?b2ZXZnBLNWxOMm1yUWpQZmpmMGxJL05UVEQxazlNamhjVC9vRWVnY2hRN1B4?=
 =?utf-8?B?bTlQc1YyNjJWQTgzV2tEaW92YVl0QlV6K21QSTBZY0syZDlSR2dQUThLYnNT?=
 =?utf-8?B?eW1DK2ZoRG5lTXlSRVEzcHUxSjFlUFlubXUrekhOVGJUT2IvUnNydEdQMUo1?=
 =?utf-8?B?aVhXR2FDVkthK3lndW9EWnF0M25VaFU4QTBtYXBxd2I3ODd5QXNrcXdxMXVn?=
 =?utf-8?B?ZDJWTnhHT2Y1WW02M2U5RDhTRnd5VGhmTktlRXF3cWpOVlc2a2RPUnRmOTls?=
 =?utf-8?B?U2RweUJKMzRBR0ZBQ3dPZGJmV2FqTEkrRFdtVnlWcDMzcDF1REo5Zk5aVUF3?=
 =?utf-8?B?aUUvdmkzVWdQRG1lZWlsdlBzTnZtVzIrT0RzL1F1RVVHbUc3N0Y1UVBvRGtY?=
 =?utf-8?B?M3RQNkd4L3RBVkdiaUZpZEFlWmtjc2dHYUJwZXBmcUhnSXBMYnM4UTllUyty?=
 =?utf-8?B?WUNBR0VNMkh2TndZT1ZGd05NczUwUDRIVWtrbUZGWmxjVXBicHgrSWFlKzJr?=
 =?utf-8?B?eE9xSkFlNjFtcjI0SSt0VHJZTUlWQU9pRnZ3NVZJZUJHS09FU1VHRVJoOVhI?=
 =?utf-8?B?b2NqSERGbjVjOGZ2YzZ3OFRoWFFORTFGREhmaUNTKzdLZS85SkVjRnFZMVh5?=
 =?utf-8?B?ZEhFenRVdFVKVGtJN2VZbWxUalNFdjFrODl5dTRNYmhodk54RkhTZVR0bGtj?=
 =?utf-8?B?bUVRTlpHWVZRWkxMZlQ0VjkxWGJpbnhQNHpjUFV4VmdUdXYwVVU5cVlUVEth?=
 =?utf-8?Q?fEB2FGmzTRe/E?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bc2674-4fee-4406-b86e-08de8f5effe5
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:52:11.8021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0433
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34244-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,hotmail.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86AF2370E70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During mac80211 software scan, carl9170_set_channel() can return -EIO
if the firmware is busy (TX queue draining, AGC calibration timeout).
This error propagates back to mac80211 via carl9170_op_config(), which
then aborts the entire scan rather than advancing to the next channel.

Add sw_scan_start/sw_scan_complete callbacks to track the scanning
state in a new 'bool scanning' field in struct ar9170.  When a channel
change fails during an active scan, log the failure at wiphy_dbg level
and return 0 so mac80211 advances to the next scan channel instead of
aborting.  Channel-change failures outside of a scan continue to
propagate the error normally.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
 drivers/net/wireless/ath/carl9170/main.c     | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)

--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -335,6 +335,7 @@
 	/* PHY */
 	struct ieee80211_channel *channel;
 	unsigned int num_channels;
+	bool scanning;
 	int noise[4];
 	unsigned int chan_fail;
 	unsigned int total_chan_fail;
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -989,8 +989,16 @@

 		err = carl9170_set_channel(ar, hw->conf.chandef.chan,
 					   channel_type);
-		if (err)
+		if (err) {
+			if (ar->scanning) {
+				wiphy_dbg(ar->hw->wiphy,
+					  "scan: skip channel %d MHz, change failed (%d)\n",
+					  hw->conf.chandef.chan->center_freq,
+					  err);
+				err = 0;
+			}
 			goto out;
+		}

 		err = carl9170_update_survey(ar, false, true);
 		if (err)
@@ -1016,6 +1024,27 @@
 	return err;
 }

+static void carl9170_op_sw_scan_start(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      const u8 *mac_addr)
+{
+	struct ar9170 *ar = hw->priv;
+
+	mutex_lock(&ar->mutex);
+	ar->scanning = true;
+	mutex_unlock(&ar->mutex);
+}
+
+static void carl9170_op_sw_scan_complete(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif)
+{
+	struct ar9170 *ar = hw->priv;
+
+	mutex_lock(&ar->mutex);
+	ar->scanning = false;
+	mutex_unlock(&ar->mutex);
+}
+
 static u64 carl9170_op_prepare_multicast(struct ieee80211_hw *hw,
 					 struct netdev_hw_addr_list *mc_list)
 {
@@ -1836,6 +1865,8 @@
 	.add_interface		= carl9170_op_add_interface,
 	.remove_interface	= carl9170_op_remove_interface,
 	.config			= carl9170_op_config,
+	.sw_scan_start		= carl9170_op_sw_scan_start,
+	.sw_scan_complete	= carl9170_op_sw_scan_complete,
 	.prepare_multicast	= carl9170_op_prepare_multicast,
 	.configure_filter	= carl9170_op_configure_filter,
 	.conf_tx		= carl9170_op_conf_tx,

--
Regards,
Masi Osmani

