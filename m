Return-Path: <linux-wireless+bounces-34239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCLmEpgfzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:25:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBE3708D5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5E5E300A279
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BC38239F;
	Tue, 31 Mar 2026 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Xm2tCvFp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazolkn19012062.outbound.protection.outlook.com [52.103.34.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD28223DE9
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984859; cv=fail; b=IrCwfsxsUNWyG+msu5eV1LrN4XYS+uh8/+8l/vnQVKaoZxG1VC3pyNrWJxCCEDEfloVOArYyJlbkyf9GkDksca0FyXAPJ2bRVXqwdQw507Mok5NbSQXlIeoO9nFimAYYxnczTCmzBaRlmWYEFHObvcjphx6Wm3/lUoicADklrrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984859; c=relaxed/simple;
	bh=cL8u1p0RHYsd2GEMCXSkTgv5c0GKjWyJjjvDKlHgZBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1/suF1SBUwpOhKtteGqaTMR4Jm97JlFVvGrldoZvoABjQRhF1Iiu3TqNEG22wA2yDVjgu+GaLVHQ36Zh/D5Tn4TYnIxGQUM169LRsrYqVkCMsYuAxKvKWbuZnNFOoxJYPmG0V0iZtZjDmU7+GW4llvpsHEEov2ZCGwvsiGhA34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Xm2tCvFp; arc=fail smtp.client-ip=52.103.34.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzeZDl1yVMG+27O7UgL3PAjrJZHqRwaxV5mLtg27zrzwHbsnta88C5NoPf6lnEjmMXFFmsPuB5sCHwo2SmDP7S5Tyav0k1khcV5bSt0FPFk5EmstnYzeWXOoYbbqi3Q2fhRkrEZeKfR+LuwDXXQHjG6i/O+vcdyLv9VAXl6ZRiKxoeeYVR0Hx46OXJWm0BfnjNqTFo+w+7FMJkWnRd2WetOZ6CrbGgdjS4Nv26t9cBf4TEn5JK64z0GW1KID++Aes7xNBZ5qk1MYUfk5hFgTth7XlgaKjufzDOJeQR2dDJDgo3lUO/1QsA621ftOl5EXHg4oIsq+XFmeDXM+4z0oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tLSTatzcd8wgWkFlnxmchKfDfrDmkmfF3vgI/ELPLs=;
 b=xO1Nfm2sjHpUG4ZISJPrdJYG7o5b0mXCzO5pUiLcOOSPeSKtZrskYWIymHmKYjvPCVfTohdjbmMoHWaNt2lLshXWWMDGniNTvN4uWvDc0N6eUmi9EXmOfKEGocYGVEepPdyP4IvWxZcwNcEhWysFQ0S0VIcPYzcYUy/qA5oHLWBDkdM6pcdj8PTOCmmtY0lYONcHxjKmNEkHZ7jILHrkG7dYzr+rhPceg+55X8n1muangzSQv2s1/kFCnxU2lF9ntgUreBEcGX0qN1ViE/hSI5dye7LbEEEGhGnIPrNG9mUaw9u23srlHi01FpSbYmv1u0VF0XPTGp77ZcMbszdUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tLSTatzcd8wgWkFlnxmchKfDfrDmkmfF3vgI/ELPLs=;
 b=Xm2tCvFpbY1EvVLDZlV+6qyiCpQ7HFg/kKMNUhuGXW4K9MiOPLMYS/zXfKUbID9iz3p5YYbc2i918KZwrMYnjdIbv8Ox6fqFSYNoFArVC77PE40hcpdLLajyu9Yqm2XN7/Oc29HqgLHiJBJRLgZXF1W2Ul2av5jWWpmUXadHvPKJs6yZ8cUQthhlg/Xh0Q4DG5z9YBHcCN50uiS4WEbyAPVuVDKgtysTmgKfqDhvcfDUnHRIUB0LN0kRzUthvmNGqDgltE3fdzOC/CQuKN1sw2viQjV1B/mEl9MWPz8IPf4LJHglaurLYFjIiy8sgFMkeXVXdfYjQy9ZQnwXhQL5Tw==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB2166.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.30; Tue, 31 Mar
 2026 19:20:26 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:20:55 +0000
Date: Tue, 31 Mar 2026 21:20:53 +0200
Message-ID:
 <GVYP280MB1518D20F5B92383487F228A19453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: chunkeey@gmail.com
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH v2 07/10] carl9170: main: add exponential restart backoff
In-Reply-To: <a92b853c-fc20-4c6e-b587-ffa8f0f66ba4@gmail.com>
References: <AM7PPF5613FA0B6C3933233D4272D36007C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <a92b853c-fc20-4c6e-b587-ffa8f0f66ba4@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: ZR2P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::10) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <3af060750a4878be6a7a4f61ae83413d@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB2166:EE_
X-MS-Office365-Filtering-Correlation-Id: c87cdf49-c68d-4ff4-3000-08de8f5aa146
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|19110799012|23021999003|15080799012|461199028|6090799003|51005399006|5072599009|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU8zcjIvdERyaWxVWGliNkNQbWx2ZjBTdC9LSElsVXYzVzFSZnZrODBxeGhq?=
 =?utf-8?B?TFpyRXNyQldPWTdTM2xOQkZvUjY2OE1nNW5tbXZGYytWdlZWVmFHR1RuOWxz?=
 =?utf-8?B?Qm1GQ21COWw5UzJHbkRSa0NYdHF5M1UxZGQ4REo5ZmZkUllzQWdIUU9nandj?=
 =?utf-8?B?RWYzdndiTXk2YjV2RHZWdUJ0UFIvM2NSL1J3TWVScSsyTnZOMmpGMkFhZTdj?=
 =?utf-8?B?NU5hc1B3U3JZSUdYZjVQY2F4OUpmZDRBenY5NkpnN1N2VWhlRk9pcXBIRDlp?=
 =?utf-8?B?SytSQldkczdFd3NSWSs4dVlnSTVRa09BaTlBa0pJM3pKMW5CWnBSTDFMSlc0?=
 =?utf-8?B?aU9HNE80dTByQVY0YU42dHVjZndZeEs5QmlHZ0VZYkFmSkQvWjNjNTIyVHdR?=
 =?utf-8?B?dzZXUnppY0luWVBITnBRWXl4bDZSdS94R1FnSURkdEF5N1l2b1JqemEzUzBS?=
 =?utf-8?B?eS9uN3RpWXB3d0JSMXRFWTJvQk9VdjBLYXpkTXlGNWpJQ2tlS3oxMlQycTJw?=
 =?utf-8?B?L1psYWtDTXJLcnVqWTZ3SXlRNG9uY2pTQmhld0Z1Z0cxNnpybjJkWlhxclJH?=
 =?utf-8?B?QUVFS2xQZzlPRDFvMFlGamZlVWxUQTZlRGtURU94Q1hQaUg2b2tXQUJHOSt2?=
 =?utf-8?B?RnNHbjRDS090c0psMlVmY1B3QVBlSmZOUlFjTG9hRXBnRmluWVlVK24vVGlh?=
 =?utf-8?B?T1h2S0ZVK2dBajFtMXgrRW9qT2FoSG1MZnE2SkpNVzdjaWJWYmcxVlk0Sm5U?=
 =?utf-8?B?UGN2RXR1c0huam9TZzdsTXkrZW5vb0EwUEdtWkl4TW1KTFpINWF1RUVENmY4?=
 =?utf-8?B?VGQzejRiSjdTOFE0UjdsbnBmRjg3dnR6NVBCZTNDVW55aTRsWmxHaWhBNHk1?=
 =?utf-8?B?dVo3U0Exam5ReGFqcGlTZ2dkajY3ZGl4NklUbWxmYVdRTG95WEtFQXhwU1Fw?=
 =?utf-8?B?c3NCdjE1VWpLZkRhMERjbzR5S0p0MXFrcnUvVjVJSlNKN2lNLzlFMzk5a2Jz?=
 =?utf-8?B?NHRMSDUwKzBGUGdXSWNiSm9zNGsyVU92VmdSaGNrbUxta3I5VG9NNnN5eGhG?=
 =?utf-8?B?YjAzMGlMNjc5MGxFUFBoenB4OWxpWjFDYjRlOUk4cE15WVBvNDliN2FBZkVO?=
 =?utf-8?B?MmNPanpWOHpOQ2ZGcExxdWE2NkdPK0hGdDU0NXNCbGNTaEwrR1UyV0QzMXRW?=
 =?utf-8?B?WXhMMW9weDNEcHB6M3JYN1M4VitaYjFsanJEbkFuS2JGMENtTjltMENsTFBq?=
 =?utf-8?B?NDM0UjJ0R1YyNTBxbmpTeitBdFFTR3lWOUIwc01qZEZvVmtXYVlyK0w5SUVp?=
 =?utf-8?Q?jgbGZdzJYqSlv5kcgvLL1v6ozyXygPhxg2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldKbkdOeHl1R29iekE2dmU5VVQzdFFvdHdCV0V3MDVKWjhPRTREMW9oNFVT?=
 =?utf-8?B?dkplZlN1TVpkYmQ3RE82VHlpWVpnQVNXL2RwY3RWNFVJU2UzdHNqKzRteWJU?=
 =?utf-8?B?WmdDRzhHTnBVRldCWnlLYmMvKy9LanltU3NTTXFNRVN2Tk9oUUxzeThUSXFj?=
 =?utf-8?B?M244eXlXSDVlcFJGZEQxNlVCNEZOQzBYQ0xtblRIN3Q3Ykp2SXNPK2luVzkz?=
 =?utf-8?B?azE3YzhOblFMUDhhYlptMmt1SFpMandDNnVaWTFzK3oyaytZcEEzajVjLzdo?=
 =?utf-8?B?cHA0bENxWHQ1TGZqRG9JTVYwanJ0Y3dLUlRwL2lZeXdlS1g0WFdQREFCcjNi?=
 =?utf-8?B?N0dXYjlKdVY5TGh1UXJVc2xEVENpbFFGYU1XaGVCdmZNRWhpajZvQ2NvQWlt?=
 =?utf-8?B?NFdZNGJkSUtZcG45YndPWStUMlBETEo2RjZ4b2h2Y1hEc0pvVnEyWUxjUXd5?=
 =?utf-8?B?WjNzYTVYRStveVp1cUtsdHhPTWJmOXpaUkZxWEliTG41YXUvUG9WRUF3cEdP?=
 =?utf-8?B?RStWSnNlYnFjM1FrbjcwTGtRQVZueUptd1A4Q250eldYTk9yZjhKWkN0di9r?=
 =?utf-8?B?THA5aHNpNk1XSkRJWjE5SmVHNFgvUFphOXZuUk0zSGtMbmRFK1lrY21OVHRP?=
 =?utf-8?B?VUxEWTB2bHJ4UlZ0bW9HekUzWVNZTjJsNklHbkZWUFhCalpzbElrMjVGQTBk?=
 =?utf-8?B?blR6RTRyUWJUeDA1TUpMTWhHNk9mcmUrdWdFclVyWm1mK25nRDl3dVVDNTg5?=
 =?utf-8?B?Q0MrREpxVWQ0UUJHRW9VVmRqYnA0MlRBaWxlYVIvT1Q2NHRuTTRJb2ZURk4z?=
 =?utf-8?B?R0hlWFgwL1o0U2ZKL2xHcjVSL2pJZzFieUNzNGVJU3R6MkdaSmZSU2FhM0NX?=
 =?utf-8?B?aE8zcW9ycUtpZmdxaUt3anFJVE84RWhOU28yTk5yQzVxUjcxZVRZblVDMnlL?=
 =?utf-8?B?VDMrZ3JvaFFNRlMyUzJZaWZzckc0ZHZyY3R0dmk4UllyYVJTT1pIRFhYTmtX?=
 =?utf-8?B?dEJORlNlZlpPT3ROdGtDeUJ6Z3BNWEFqNkRQa1dGZXBoM3hqd3daOUJiY0lQ?=
 =?utf-8?B?M1k0cDYyS2VOeVhnZDFSVW51aXZiRzVzSWNRSk9JdHF4dUVtaXBxM3Zlei9L?=
 =?utf-8?B?MkY2d0cxblozWTh4c1BHK0NjT0pzemFoUG05VjczSFhOUnpIME5XNFd4RWVp?=
 =?utf-8?B?V3drUXN0ZkRLWVpTc2VKZ0Z1cnhqdXBUNVMwVno1dEZpRXBydFlJOW5HRUM0?=
 =?utf-8?B?a0t0dUdXYktPdFFPNk9nbWcwS3FIcVNUZk5FTGJyU3lpRU9hL09mS2xIdzU3?=
 =?utf-8?B?OGlTZGtXaWNZNGV4Znd6UEVRLzRnZWozeTY2dTRjWXdZMEhwZ0g3NndhZ0Rm?=
 =?utf-8?B?ZmJHbllLQ0ZmaXg0WWRZN2F5Qm5qTktOZklURW1HRlloTEhIejRYaEtKb2Qz?=
 =?utf-8?B?TnhVVmQ3UUdYa2U4S0dNd3NOdjd3dkNiYm9Cd2txVDF4TkVGOGVCZUx2bXhU?=
 =?utf-8?B?ZXo4UG1tZmhGeDUxVGg0eUx0M2FzVklnSk81RFJtT0tiSXFnQ1RrTFoxSytn?=
 =?utf-8?B?NXl1UzBFejdnRVRDM1h5UmxyaEd6cXZ3SldUdk5ZOGhZVHZpUWt2bWMzK1NO?=
 =?utf-8?B?eU1Ld0VOak4xeThncDNPSDBTVUlLWFlDcS9MbkY4YU1zN3hjeGptSVJzNWc2?=
 =?utf-8?B?Ryt0cWZRai94bkdOSmN3aVJET05EbVE2eERYQVhIbC9jUytCVWdxMDhQM1Ji?=
 =?utf-8?B?MjAwRzkxQzdHVWd5dmNBVTRtNThIeUV6M05HOHRHYTNOemtOQUliMXhxV0VQ?=
 =?utf-8?B?a1VTaGIxV0ZacjhCZG84N0wxSDRpUkpIejdQUzVGaGxpRDBabTFqK2s1NEk4?=
 =?utf-8?Q?E7aKl3LH9welD?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c87cdf49-c68d-4ff4-3000-08de8f5aa146
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:20:55.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB2166
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34239-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,hotmail.de:email,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 3EBBE3708D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2: Two fixes to the rx.c constants:

1. Remove CARL9170_FW_ERROR_WINDOW_MS: the constant was defined but never
   used in any expression.  Keeping unused preprocessor constants invites
   future confusion.

2. Fix CARL9170_FW_ERROR_THRESHOLD off-by-one: the original code used
   `> 3` (triggers on the 4th error).  The v1 patch changed this to
   `>= 3` which triggers one error earlier.  Set the threshold to 4 so
   that `>= CARL9170_FW_ERROR_THRESHOLD` is exactly equivalent to the
   original `> 3` behaviour.

The main.c backoff logic and carl9170.h struct fields are unchanged from v1.

---

When the AR9170 enters a bad state (firmware errors, command
timeouts, TX queue stalls), the driver can trigger rapid-fire
restarts that prevent the device from ever stabilizing.

Add exponential backoff to carl9170_restart(): if a restart
request arrives before the current backoff window has elapsed,
the request is throttled.  The backoff starts at 500 ms and
doubles on each restart, capping at 30 seconds.  A successful
restart resets the backoff to zero.

Additionally, use a named constant for the firmware error
threshold (CARL9170_FW_ERROR_THRESHOLD = 4) instead of a magic
number, preserving the original `> 3` trigger behaviour.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  2 ++
 drivers/net/wireless/ath/carl9170/main.c     | 34 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/carl9170/rx.c       |  3 ++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index a2ffa62..2eedb2f 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -301,6 +301,8 @@ struct ar9170 {
 	bool needs_full_reset;
 	bool force_usb_reset;
 	atomic_t pending_restarts;
+	unsigned long last_restart_jiffies;
+	unsigned int restart_backoff_ms;

 	/* interface mode settings */
 	struct list_head vif_list;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index dcedcb1..ebf9fa9 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -467,7 +467,8 @@ static void carl9170_restart_work(struct work_struct *work)
 static void carl9170_restart_work(struct work_struct *work)
 {
 	struct ar9170 *ar = container_of(work, struct ar9170,
 					 restart_work);
 	int err = -EIO;
+	unsigned long flags;

 	ar->usedkeys = 0;
@@ -492,6 +493,11 @@ static void carl9170_restart_work(struct work_struct *work)
 	if (!err && !ar->force_usb_reset) {
 		ar->restart_counter++;
 		atomic_set(&ar->pending_restarts, 0);
+		spin_lock_irqsave(&ar->state_lock, flags);
+		ar->restart_backoff_ms = 0;
+		spin_unlock_irqrestore(&ar->state_lock, flags);

 		ieee80211_restart_hw(ar->hw);
 	} else {
@@ -505,6 +510,12 @@ static void carl9170_restart_work(struct work_struct *work)
 	}
 }

+#define CARL9170_RESTART_BACKOFF_INIT_MS	500
+#define CARL9170_RESTART_BACKOFF_MAX_MS		30000
+
 void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
 {
+	unsigned long flags;
+
 	carl9170_set_state_when(ar, CARL9170_STARTED, CARL9170_IDLE);
@@ -519,6 +530,34 @@ void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
 		return;
 	}

+	/*
+	 * Exponential backoff: if restarts are happening too frequently,
+	 * increase the delay before accepting the next one.  This prevents
+	 * restart storms when the device is in a bad state.
+	 *
+	 * last_restart_jiffies and restart_backoff_ms are read-modify-written
+	 * under state_lock to prevent races on SMP.
+	 */
+	spin_lock_irqsave(&ar->state_lock, flags);
+	if (ar->last_restart_jiffies &&
+	    time_before(jiffies, ar->last_restart_jiffies +
+			msecs_to_jiffies(ar->restart_backoff_ms))) {
+		spin_unlock_irqrestore(&ar->state_lock, flags);
+		dev_warn(&ar->udev->dev,
+			 "restart (%d) throttled (backoff %u ms)\n",
+			 r, ar->restart_backoff_ms);
+		atomic_dec(&ar->pending_restarts);
+		return;
+	}
+
+	ar->last_restart_jiffies = jiffies;
+	if (ar->restart_backoff_ms == 0)
+		ar->restart_backoff_ms = CARL9170_RESTART_BACKOFF_INIT_MS;
+	else
+		ar->restart_backoff_ms = min(ar->restart_backoff_ms * 2,
+					     (unsigned int)
+					     CARL9170_RESTART_BACKOFF_MAX_MS);
+	spin_unlock_irqrestore(&ar->state_lock, flags);
+
 	ieee80211_stop_queues(ar->hw);

 	dev_err(&ar->udev->dev, "restart device (%d)\n", r);
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 414d499..bb909b5 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -46,6 +46,8 @@
 #include "hw.h"
 #include "cmd.h"

+#define CARL9170_FW_ERROR_THRESHOLD	4
+
 static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
 {
 	bool restart = false;
@@ -54,7 +56,7 @@ static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
 	if (len > 3) {
 		if (memcmp(buf, CARL9170_ERR_MAGIC, 3) == 0) {
 			ar->fw.err_counter++;
-			if (ar->fw.err_counter > 3) {
+			if (ar->fw.err_counter >= CARL9170_FW_ERROR_THRESHOLD) {
 				restart = true;
 				reason = CARL9170_RR_TOO_MANY_FIRMWARE_ERRORS;
 			}

-- 
Regards,
Masi

