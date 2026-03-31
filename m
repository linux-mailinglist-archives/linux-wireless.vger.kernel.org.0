Return-Path: <linux-wireless+bounces-34224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGJBHG0ZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF92370490
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C8E8305E9FC
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D838F24D;
	Tue, 31 Mar 2026 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="HcY5OcrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazolkn19012054.outbound.protection.outlook.com [52.103.34.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688C3A3839
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983496; cv=fail; b=jhcjm5dhc6xYE65he2vkJVBPy9DeeY78gefTxOtRBHl7SwXrP/L67rpS7uNzGiaOYHL+CGyjS/PecOMRAG4KFYgBZ5ybevr2/eGRiwvy3IIu6+gHyNdKVpS17vV6VxeJac2UHThMHiabfYq2lPA7QHmOBnnBzUyTGliw/Zdh4Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983496; c=relaxed/simple;
	bh=cIxFGjigWSRBiztWxYzk2nJ2ER+N/aPHloMWVnRwzOw=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFrWIcLTJXWpSnHBuYRTwJSdmdo2a24p5+dzn6iH4b6jVEoyleJ2ByzY7fCOVzK51jrNtKjn1MlkWCndtptFvqel7VUTGMWeCWp8VOJLcF3pTk4CE1yPA+cRoJZNMXhMqsdHRkW48oNQatSFRGzi6JBfZh9FeC8y9Vmbf053C64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=HcY5OcrY; arc=fail smtp.client-ip=52.103.34.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW8IB7VUHxM8Mk/KfscJ9V3FV0XEe6Y7gBazYljK+oJTuyrCkWCDhlVcyiuUBDqTf3Fl4gLn2t4CrNlEg1eac2eCYSLrmHBH6VI3hmFwVszg02F773wJkOmkoxyrzov4HFxZrTPVujb+fAls6+HdUMgwz6GPf9QaF+7+acAJpe/8P6AiRkyIJCBtBMtTOTEaOc2BX1vZgqwIeXtpFExAUu6mHM/KHMup9TtVMX1hQHomAPCpAZZzUhOgS4mCtcLLUO13UEbOs9sCWORzt32KlIu0eox4dcu7YCCFYLY27IpWBVyIOgCcuAXch5cVLRE72CFqSXlDvv++/56biyr9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SqtHe8HSJv9d0u/pk/1VPnHXyDnAxYeSUB0gv+/jkQ=;
 b=CaTLgsl3d3KggQsoQBNKqz0xMALw+bHTQH1bbH0ni6Lt/OlnFBruU7ytnVYwfESnZjvpk2/JJBj6SQKwefMsgdMGqWlBcX+PdcHwpP7UVsHBX74uF6+YGtEsPVp12eChnhkTQatxSM/r8eLlE+bEDiCGT9BTECg/+3UW3Yc7gPitKKjL256nGyayhNfgE2wDHhznKJXFJFi674HrIHJaAmCsDSTFj62bI4RT5as5NdIzBYOGc2SmQ4HHGZ3IC/tHzTVV6Y5ecwVddkFi+enCJgnRpfe5bh+wkMLf5BQdA5qnktVx5HemH2QK3vMn26Ro1ZK+Lryd2hmb3GD9jsAI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SqtHe8HSJv9d0u/pk/1VPnHXyDnAxYeSUB0gv+/jkQ=;
 b=HcY5OcrY/lYwEc3ZTcbjgwFrQFyNbWrDiA9zIg8V4P8Sy4P/YK2ydBbV+374MlxjFH5SbsId9PgQ27nUlxm1aBnxqoeV/j/x623nhc5Nu4ZzLHMnnwH9U3sXpWaVVLu1GKbHUCzwkqIeOd01E0ASzwHgF3PXXmE1wawNfLbhwhd/cV5EH8zwSG0oA3hRIYWGItJG8eKp3omOrGhurXo1MqJ7DmfMpefvTKk8q/8PU2XWd9+4G8nHya1RGQ718e+hQpEw6xTmVvCyLC7reOFKd4jyBhR1glyLJ+87UVGjEc4xnv4xdQB44TMFazNZ+8Ko9qDUWsf5D03ilCD+RCx2eQ==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:12 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:12 +0000
Date: Tue, 31 Mar 2026 20:58:10 +0200
Message-ID:
 <GVYP280MB1518D554111AA6F6BAB473929453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 14/16] carl9170: main: guard op_config and bss_info_changed against non-STARTED state
In-Reply-To: <4558729b-1248-476d-8262-56ddb228812a@gmail.com>
References: <AM7PPF5613FA0B6FDA6759CDCBE2421A8039441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <4558729b-1248-476d-8262-56ddb228812a@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::10) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <8e33796f0279675750323698eece14bc@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a81942-de6d-45d3-8881-08de8f5774f0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|461199028|8060799015|15080799012|51005399006|5072599009|10035399007|440099028|3412199025|4302099013|26121999003|1602099012|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSN22FCenHC+720RRJ2eMPAZl4t3FjcseoJaRz03vpR/E5Z2q4el0T6Xl7+1?=
 =?us-ascii?Q?luwmXciiWppdLW8B7+BhEeWiUHa4nqwyhCrLi58Y7c8uRPRNon6pxaQ58uwM?=
 =?us-ascii?Q?1xKPhsYpV1uRPLLuZwFr2eTtaWy7Gp3qZ3EJnt+fADhKb3SNsCSr553heEPk?=
 =?us-ascii?Q?JOQcydFc0irzEZ41GuuQSw7JS8EZfDwl1ZRecix6rmqMqk6brFCLEIaGlJ2+?=
 =?us-ascii?Q?yqXLU0lUh4Kt5f6EdiXzNzz58kkoez7ee9Tar8BYjaY9jfG9dTr26VHTEJ2s?=
 =?us-ascii?Q?TQklPuO6twJghhIyazs+L4+4qX8XF68/T6A9CwwGJOE5wMKQNzSCHSfGf9T5?=
 =?us-ascii?Q?1Upet+6e3+BF9LiPQ4AIiUv2wQY9Rxo10/zgFA26qRGzNqRG51ZEcCGhFuHn?=
 =?us-ascii?Q?M2QwCR353H7JSywlzAVU0nPxDI730TW3WN9qGKBhKqNGBc9EPs2rTcYhG1vR?=
 =?us-ascii?Q?mbcJq4AOVFxxTK9TCJ7PTuqfdMLLMIWs9CHWPAehJv/QD2ckJ8e2QOLCJyp6?=
 =?us-ascii?Q?Ejx3+Uv9Q61j52fvrBUWQaJgxFqr8B5VitEeOMjSiT8EzVqClDy+k31ZX4dA?=
 =?us-ascii?Q?HfoPOm9ZAewgNcaD6zhWZuteAlhvB6JMk3kdQn2TLwRcfk3XHb7zHlUndQkY?=
 =?us-ascii?Q?XcmGEInLGb5A1NWvnT0MUljkAHE21qpMy5Go4VVIx59dRlzA/eUK6E9sSucC?=
 =?us-ascii?Q?igIQoR3AdmQ2VWPlnD0WrOEJ32VW3k6qmNfACOxea6HNXqvgke2+L3ytwkpx?=
 =?us-ascii?Q?sjIGqm2sPeFtsKY7Mr2tSc1yY+X/84gqywbIzrmixJbt4dyYbevbJ7AKq7NS?=
 =?us-ascii?Q?ltiWC/701+sKFzpYJ9BM1TMn26tphrdSzHAoFspSVeNESoo2Wmjd2TwIbme5?=
 =?us-ascii?Q?lEnHqI0iL763CyUuP0f/iqrsdUVOSHUR+JpKsHMFXdk3XPTO+5rkCg1p5T+H?=
 =?us-ascii?Q?/aL0R1cB11TXMdmj+kqVcu7UaAHyTf1s+noX+loTWlNyLZNJjx5YwtCWuYoz?=
 =?us-ascii?Q?QpaytKOdDAiITdwulG7ElSQ2Yot9nsU9z3NQkuyzZSAuz2w6XGI8gBdrzfHV?=
 =?us-ascii?Q?n6qDgzU8?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3J9rB+/Zwa9rzsE6gEP90E/4XRD1/7Gjox86lIWAdV0LQcqwEnDVFmB1CJrn?=
 =?us-ascii?Q?/dew8HlK9SZuUpDDnKGuhmWVFqSoroxvGIlu11m+MDrmZjoDnZMrXksmJEan?=
 =?us-ascii?Q?5iIAcE/YRoNdIFkihSuQitvEvXGVa+L0KGZ2S4izjJ6NCMgJ/VWPyZbwLZuK?=
 =?us-ascii?Q?iR6T/9cHWLDVEbzmwkQ8NfRS+wuPUO3KIgAJWZB/ZuGIId0PivhGtIA7mTZi?=
 =?us-ascii?Q?u+S81+1a/758/TYoUpsUYVdNPG4NgIPAliYqjYDQja2knJim5sfFwHes/Kl2?=
 =?us-ascii?Q?djCrhAcgc0nZWz6qMkpAHPB5F55FO6Wu20eOnuHYtbzRA0P6Xgb0u9J66lvK?=
 =?us-ascii?Q?Xv5IPH5voXa9BdUJ/eZl9GTrR9K0VRe2QUbMPZBbrI7HeBwhkPSPm2Zu1kiD?=
 =?us-ascii?Q?8cPNvFRl4K7cSj7irUzHsG1OtwoLzww5ZwzJiW6Z3UwpKRmkfIXCQ+s0ss5r?=
 =?us-ascii?Q?nPQZVaGQpukJ9wCW1mBpcqP7/BHjS2m0RMTUrgph/Rex3dg33jxTpy4vRE+D?=
 =?us-ascii?Q?4is7Kq3Jy3ApdFrzoRD+4WazgERw+NTD4ZkaetT8nfX4u9eO8qWhETEDuQFq?=
 =?us-ascii?Q?t+ECT/DjS9eAfupI0YuzQr2plh04eVKVYWl4xwZnGkkDk10fBgXGosmernTF?=
 =?us-ascii?Q?PGetH1yg0fM+GsRUlNidIfXrdpqmrm1tqpSdJ4fxQHmPa6ex0ni81F8zrfk6?=
 =?us-ascii?Q?/Wrr8hwjj3p5bChssihtkiKJ1mOXAybkg8TzuEcfdC3EyjD/IRXH++HEpGoT?=
 =?us-ascii?Q?ZlXrUIRb7jQ9TNjz9MLCLcSSCC4chMGDSQ5RwTf0lPQ3lgUsQega9/IF8yRP?=
 =?us-ascii?Q?lkUAahyDsAI7S4wfl67Xu0uN9m8v8N/8+v8cfaqc6Vl9j+k03AMZmSKrSmcT?=
 =?us-ascii?Q?6Fd9qpBp8TZqLFwQimHTGqeAlY1gGgzbPFHdd35c/bkb1euY0fZRI6/sD0Ab?=
 =?us-ascii?Q?IGuFlYXjqjW28PnrMmLz63UIMVXEEm+rXbuQLUFgzbw2LVAPh6/a/+UaPYp5?=
 =?us-ascii?Q?6+oBS5ziyiSCbH9yQclzqXyMPyRtEAOOaeiMqbcLFAEA7fTBF3a3Xu616FYb?=
 =?us-ascii?Q?VG8rf6+xdRHtR3MlLQtmp0ePxtmjhV7rPf/GlztsQwKMhbY6knQnYzjWG5Ta?=
 =?us-ascii?Q?XtcX+eey6eADZ8B3rjk61gWLusoj6s1PoUveOvzbGLXvHM3Ou2goq7oEFGNf?=
 =?us-ascii?Q?h/7ZxNqRbt8F+PXvekSmd0ZW9WAI9wZ08XUazdXjw2N+iad5glXrW4TULPEf?=
 =?us-ascii?Q?o/Qf8uYxILSHGHsRDP5lyHNa1QAgAi9riEB8KaIbYrXTWf4K5Elf9veiXBWC?=
 =?us-ascii?Q?Eb5HTMEuuVifHtYaWbMLtKzyG41n1+NOQcyUNzPfAidFc+sctzy1zOmXAfHA?=
 =?us-ascii?Q?PGqzDrj3jvEJhMvwYa4YGyoQQiRe?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a81942-de6d-45d3-8881-08de8f5774f0
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:12.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0978
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34224-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EF92370490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 11:28 PM, Christian Lamparter wrote:
> Resources exhaustion? Kernel Panic? This does sound like an embedded device!
> Have you checked for leaks? ( https://docs.kernel.org/dev-tools/kmemleak.html )
> Can you please post such a panic?

Sorry for the misleading phrasing — "resource exhaustion" was wrong. What
actually happens is simpler:

During teardown/restart (state = IDLE), mac80211 calls carl9170_op_config()
and carl9170_op_bss_info_changed(), which attempt register writes. The
firmware is already dead, so each write fails with -EIO. On our hardware
(AR9170, which uses IS_ACCEPTING_CMD() = state >= IDLE) we see these in
dmesg for every restart cycle:

  ieee80211 phy31: writing reg 0x1c36f0 (val 0x2400) failed (-5)
  ieee80211 phy31: writing reg 0x1c36f0 (val 0x5000) failed (-5)

The "30+ cycles causing a panic" claim in the original commit message was
overstated — the -EIO flood did not cause the kernel panic directly. The
panic (hard freeze) was a separate mac80211 reconfig failure race described
in my reply to patch 13.

This patch still fixes a real problem: unnecessary -EIO writes and their
associated error log spam during every teardown cycle. The IS_STARTED()
guard makes the code correct and eliminates the noise, but it is a minor
improvement, not a critical fix.

Apologies for the overstated description. If you'd prefer, I can resend
with a corrected commit message.

-- 
Regards,
Masi Osmani

