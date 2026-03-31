Return-Path: <linux-wireless+bounces-34235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKUGImEczGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:11:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA7370654
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC7A30E0598
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E40223DE9;
	Tue, 31 Mar 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="jSSVIBlP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011027.outbound.protection.outlook.com [52.103.34.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89038CFE7
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983992; cv=fail; b=AZ7mhwgyNcwleSEd2iXxip5QqqG6J53Du97pbvn6lQG0an/a8lejqOZsebRpvZQbrkndVGVlmxHD92j9C3V7FGY3NqxJRxX90XFPUwLk1pAcqd1X5w/4SABP8E6Va/umbK5YMwNIQNW+zMWgCDLBYLzCBw9CV5kzT2MK3rJACjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983992; c=relaxed/simple;
	bh=v/R3s8Rd+owd1SAagH81B8vrU6+EMNkPjBgV8ewYo88=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+kjWzu/GAYcb+UEOhFI9Iw5H3BeNZJL5WFBF7ZLx/k5oVm6U/qPrVfFsYz625RBJwa1+ciXzW3lmUQMMUbRBYelo9xdzyFmOJ+sSTrtlp7nFGlw1RrC80PT9x7ZEYRsTSmZIzBzrHvPf8p8QvICSYtMml8K+XKj9bvdjlbZ7Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=jSSVIBlP; arc=fail smtp.client-ip=52.103.34.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZxMjxHeNquSLh0hzZlecTN5BHDysrNPBQgdZqzytgNaHJBFEWskGBEO4ppVZ2gvA40rxpaOgo86lhiFFAksjbwt+6RrmlkBdfhKOxMZC1ixbzakK3QHvjEkn3XOLNvUs0UuCv+ROOpdsj63gI1iukakyY16QyzksWmTIwNp5myHuzyzb3pjULxxL3n+pm5tTfQlDKZtMtSG6aE05Pl0JpZl60rFeyWObzYfvtW3/ArPzJ1dpxJuVDwjrFasyUmB14QeSd2jc+El2XGioSctiF0EzsgVmnHi56IOcK2PddgjoCILHbgqkf3/2WJNy5cjEXW1Bhn4FwHz8LUOXXaqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUPXr7HuJp+O2J6PoYTDYbR1fD6FgexGlbaXzp1pV5Y=;
 b=t+0vMva7s4XdWndzW8GFejv/z5N4KXkmkw23cRTETyIHmNAuxRQ9UofE3/GUhvjGS65sdsdDGgZRuw/UTXTI+qt3R7qeHxwddSC2HCAo+EKBXlYWqFSC/l50Qx6XhBSRrkVNpo5N7nOrFnwC/orliTPKpBdfWpjUjTRuC+w8deN8CPyr7wQbQztefo8ub4MBXwGzM6Gp6dUgn7lR00731vDxD+dMB7r8Te5ymGsPBVgShNfMchOSd6PchwjhL9s9bn71Iq3WRu5J/nHs235c5/x13dGhjy8pcTj1SJSt54UzGu+OE9X6PYcT796qh4DmBLOntxGRIYaIWB+BIRK/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUPXr7HuJp+O2J6PoYTDYbR1fD6FgexGlbaXzp1pV5Y=;
 b=jSSVIBlPfI9CVu+3h/vPZ8IZfdjGeq1Q/xAyhgAJJRi50GykhB8e3u5kUCDFSzdQnhpelh0sWEWsOiowcorMTpMNEBuBiZSgtTpaUWNgkhfYEiF5nmTv369ux8ZGl51ZiD48TulDtmcLqUQlMLPY3/DQto+UyobnZvJvNFew6IJEYbcgAe5WYBSjiKKUAEjY/ZW3IzYVNfY1s5TnIYyoN3c1wF7GtOeZMhxRj20GHB48BUIC/mYoy//cloTnsMawBOZOwI4eMgD5c9yMvXjz99CGKkt5Ztk7Znf3TzPwU0oevtrHuuZR7ZVIgVF2RMWC7r9fEkBlsTuvQ4g13vnmBQ==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:29 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:29 +0000
Date: Tue, 31 Mar 2026 21:06:27 +0200
Message-ID:
 <GVYP280MB1518592D46CFE978D85E56CE9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 10/10] carl9170: phy: add periodic runtime IQ calibration
In-Reply-To: <41a9b095-ee6c-4f91-b8d3-f15468ea7589@gmail.com>
References: <AM7PPF5613FA0B6567EFD98F8FD6FE6511E9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <41a9b095-ee6c-4f91-b8d3-f15468ea7589@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <48e095be1498c07b6dd70cc6baa5bc1f@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecfc1d7-b975-4e7b-42a0-08de8f589d41
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|8060799015|19110799012|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	vIaop49ejnwTN4l1NUjqodRyB4C9xHlTDPZ67tKo083xXRpA5pVSJz7XtDd0UV5nS+ttTYNo6UoAPtwfIPZz4wdR2zz7e85HP+5orn83lsM3cQqpLzYPFG+k5u63t5McVWNBTa9lOO3Ze6vO9p6bT8wlAS7R2TJK84GP4plFg3pPtgzmbIDt2T/mn730tXRrPFbXFj6wECAewyxxZw7yYygLp2apZw/QRvSBLf6bkUtcRXgE6XU92QZ9imPlMpDMdT2QRLHIyT4DanbhL/P7m7bH4Jhf1eT2M+eLbOzXYJ99bzJVJQxEAmhnxnkO2DONO2Dlcw3MW6NCD1CdOPSs7k2sSZrt0TrGy71MjSEnrO/P96rOWJXWu3aCr8rNWl1f5I4/t+6ohIF97plDZtS6NBMHEzEESQWYp83TFkNyCGZqdWVgWoxhKsUpkqRdjUPX3OWSlyYNvcOZE6SBFmQvRhwY/gS9HGVHCBOM6LEs4flFvW8bOduoXjN0ktWGnRp1kkPqO4/1218vyBtayFwrOKsl0MHyq+uEr20qsjhUXL+HnhdupWV+XJdVp7ToKmNc0XED6EndOOrV4wSU34gHhFv+RqJdWWEtOos6e8JdB2gMGdGgaQxRtdFIBqvhbcGIsKImlmidcb+KlaVprPOirrgI2ZTUjxMahqAEAZ3kXqjd+jUWxulFCDdSj/zewYak71z7mJrfg8OxbscMrwDB4K6hgtqIRpcjvwRpQ0VLvz2japMjjws139QwkT4AX5tFRqlfPOOm5bh8E9pUG93D/4q5gA517AMDActl3ZyLLHFo4JAcXh7fF+iwBPv5q4+29Ibog5k6DcD+jGK09vA3MzHR4PRaorWhDMmPtcuP8u0Ana0XS7qxdsin7uqQirIJMoLDBMg1dICIGeJx0EHZRyc3yJ6uiqqrfwi4EqhXfJjh5CwNmrd4lfJ9ja5q3Pzj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ZV18vZgMrwQ7nk6Xun36MZbDRbh624gYzgIl9ECn5SM/Wl3UwLcVhb32Dx3?=
 =?us-ascii?Q?zah+04m9iHiq1UZv3uV5WtW6Dbf67hIyY0OyKmCW/UnuPS79GCDwVtat+Ukd?=
 =?us-ascii?Q?ddYF8mEHyH7X7r4cyAllClyl0akO2+lwBvoGZTaQ5MR1cKn2aB8dosoHl10r?=
 =?us-ascii?Q?G6JLQYEXRR9ZpuS0HiqR1nQHZsO4F/JtXKjchHdOBYgs00PayE4wtaW1KuoR?=
 =?us-ascii?Q?twpC9utmoaWPufbT9sWF4XtZ45TylX1khwx5unAGFCHFi+SBDU8ZYlYsYo2S?=
 =?us-ascii?Q?y9hwToOj1iGkHJ/iJ6MMq7p681EFq2CVMcMIoB/RuJT3BcyoLU8Y9A1BJ+TG?=
 =?us-ascii?Q?heCwW6LKakFJA65Ke4aCWisONhtEiMEkaJOMlciiMzKrk3Xe8dvqJq9em2ih?=
 =?us-ascii?Q?MUIgcodnCb262K618dlO5OUpHRP8usZ0EJ+RapBbY8K2GvYfECiYhEBqNkug?=
 =?us-ascii?Q?dJioSb1hmRotsGkZieS+I8L0nybcoIM+i3Ro0R6adayYislqJU19qYMlactr?=
 =?us-ascii?Q?v1tnHIQ10efmDcUMw7vQvt8AEH4E5v5YJmrscOjv+53wgeAvYYfmSDeJfcck?=
 =?us-ascii?Q?sQ11En4krsoELfsWcJ5mrx0Ld5B0cx2UJchwNH1yNx7gNZUyGFW96BJbH6TV?=
 =?us-ascii?Q?P3Pp6+Cj+mnbZkSwxYhhrY9z2lE6Hhc98lkXxdcCU0LHY+ryqGfE1/7x5Ncj?=
 =?us-ascii?Q?YDLjRamq9GFz1K1P79gjiv4cUUyZJFt7iK+7bgNtL3SUFrKWi2IeeG74Rw5i?=
 =?us-ascii?Q?ZQVKBOBCNCar2+xcv67/dcCq4rlKzo/eQDCywnWhPsZf2fX/RhC+TajGXAO7?=
 =?us-ascii?Q?qPgKcwqCrebUu2MG8NmdTF65B1zPVLreIRa1B94XaFCg8CQ3sPCj/5R2bPY+?=
 =?us-ascii?Q?oIqFCL2TYbATkuf2Dz9vnZuA/hWN9H5oT8Z7Mb1740u2QViJJ/MA3kkqQfvb?=
 =?us-ascii?Q?ehtfqKsih9Ma0P7ov1R3wf594bEw+mq3OKCneM9b14kreD8H0I7uMEga3yNd?=
 =?us-ascii?Q?p7FRrSVQqdAMlI+mr9af/6BbdeLOjTVMlrIny9estxafoIeTgSjaPA7A1CPw?=
 =?us-ascii?Q?0cx+rGl7FmV03Z4ywHR+sCyv7bZmwiqvHPAxsVKzqrbsYQNcbdHnzaPpZlRM?=
 =?us-ascii?Q?AfO8RrCiVnrCJn9SJSqjo8XFdi3umwoVxJ6Vek9mtVyebUNJARpA4tVwcay0?=
 =?us-ascii?Q?Gutd+1Rw4FGzE7FFFXSTTwiZKRv5Qbh72TUnkLqP6B49hcKgMqUyFUZBs2zi?=
 =?us-ascii?Q?dHUEjQ2h5a4Ys1McsT3KvWdl8g2HzBOaBh8RJI/N82B0xOkjsE9puCsvCe0F?=
 =?us-ascii?Q?0R16U8m7DhDp5CyFLFH9SdiF/a7+mcaBAgXExs4H6R+fLHt08GVBX2QyGUYe?=
 =?us-ascii?Q?3gxj9TAyBMRmcrxM4U9zB/Fx8t2+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecfc1d7-b975-4e7b-42a0-08de8f589d41
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:29.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2028
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34235-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 2ADA7370654
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 9:29 PM, Christian Lamparter wrote:
> This makes it look like we need to read back the results after the
> calibration and put them into AR_PHY_TIMING_CTRL4's IQCORR_Q_Q and
> IQCORR_Q_I ... At least that's what ath9k with the ar9002_calib
> seems to be doing in ar9002_hw_iqcalibrate().
>
> In other words: Do you have some credible information that just
> setting AR9170_PHY_TIMING_CTRL4_DO_IQCAL is enough?

No, I do not.  That is an honest answer.

The current patch only sets DO_IQCAL and assumes the hardware
auto-applies the correction coefficients.  I found DO_IQCAL in the
OTUS HalPlus headers but did not find the full readback sequence in
the OTUS source.  I assumed the AR9170 handled the result application
internally — but as you correctly point out, ath9k's ar9002_calib
explicitly reads AR_PHY_IQCAL_RES_PWR_MEAS_I/Q and
AR_PHY_IQCAL_RES_IQ_CORR_MEAS and writes them back to the IQCORR
correction registers.

Without the readback the patch may have no effect, or worse, leave
stale correction coefficients in place after a spurious DO_IQCAL
trigger.

I see two options:
1. Add the full readback sequence from ar9002_hw_iqcalibrate() adapted
   for the AR9170 register addresses from the OTUS headers, and send v2
2. Drop this patch entirely until I can confirm the hardware behaviour

I lean toward option 2 for now — "interesting but unverified" is not
a good basis for a kernel patch.  Happy to revisit if someone with
an AR9170 and a proper RF test setup can validate the full sequence.

-- 
Regards,
Masi Osmani

