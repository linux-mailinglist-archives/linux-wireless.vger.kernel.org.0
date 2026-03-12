Return-Path: <linux-wireless+bounces-34246-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEL4HEcyzGmwRAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34246-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:44:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB63713BB
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A14E0306CF52
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140473A542A;
	Tue, 31 Mar 2026 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="D/n0RxiQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011033.outbound.protection.outlook.com [52.103.34.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341724728F
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989498; cv=fail; b=UpYABTL6bqNrkLzr7+zCVa/13Fou8D2MgxOLicreyuOdbEYMP9b4DwMjznJck1CKfKADpySIikUE5RLXpyBj4Drvn7rTKHmEo0o13aIzOljPwT8BpzLcmRsNXRvEZj8RZOxwwd29HHzPwJowmmWgj81TiD7Oy80fLJH9SReLLdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989498; c=relaxed/simple;
	bh=PN3qZ0tLjeaILYSGrg3h7YWyIJtmCQ+uEZsOgSoK0xk=;
	h=Message-ID:From:Date:Subject:To:Cc:Content-Type:MIME-Version; b=a3J2WDOohszy/ZNpsLBEgUYXF1r8j6VRzr9DYI1R1gcbn2AYJwKSqfna3VJGcENM9zXu8fHPh5WuRgWDzzOMNRuNILKN+GS4DaHfODtkKIORw7nU9LFeTglLStz3XiOIsbIfw2OjT/uEBIyp9l2AyBIp2iBYyxLyVpVERZkrC5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=D/n0RxiQ; arc=fail smtp.client-ip=52.103.34.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fomL+/q4En1UkR4545iKSFaQB6CeO0oj/hxncwgMjdh9Ct0Y6B7yv/Q/DyVyeLb+hdtQhFc+EEQuSE5wsdMIJwi56nfhXn0lcj5FZlJxUx7s/b0qmuITqWzsJdjEdfKPYyKEDKyUbEe+ERAkQCoVSx8DFAa+JfOaqpM//zflMatoAMFcPoY1pATy3hv4dnG6k3MS/fVbvndS9VRekW7ob6nQKUrjquHylvX2t5DWNhcfkBvtAcDQJNDsQrqJPeN3GjNkmharAH7H9KfDYbwxi+ouN2snYZFgzPVEBOBSb13RB4lggcq6YAAeaOBC5HgEqe1zhod+RRC7tjnbe9N82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFbhoS8rkKP9Vxzssnq8FsSVLHGn/DJawS/aw/ElJRc=;
 b=M7SD3qWiPY2ld22MPecOsiYYVma5lYHWUEouGCgVBhaheCyAyjdp3GbmXGdlkGpih+q7pTaHnjUkcCOXmnIgePfzOy7vXLuNz/XU+bOfW2VxY56esGrlgOPzoqg5Nkf7IQ7P9rNGDWeffXmRe7vQh7bcx75eJPvG3G9UNLpgqTe6fc+TAhV/YlLkOVNdbJAiAM1WR4Gngd0R67FaEgLShsTKeU9Urj9bWp54mM5M1wRd14pQsyrzS/hzPFlXaKt76LRIYWLHUklUjbxMaGdCigYbEpT0B0m0HEkrVVKj5fKBWKuSWn8Ogj2KiPSsZs3XOcDnUaRIXIjCJd55G7fS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFbhoS8rkKP9Vxzssnq8FsSVLHGn/DJawS/aw/ElJRc=;
 b=D/n0RxiQPanEcoRt3MttpWeSdi/wy+pNzaSdNNAVFkB2tGqMTruVQ10Fi02F3BQS4iz1LDskbwTwYhz+Vsh6T7WfxKjIbU5y4hy8MmCJDCWbfY7jriBtguhkZIe01fDcHLymFoBQVmKeg1ntpffC6hknN4FRKnlCNzok6OkeyL2UY4q7eB91Pi0IZf0iiu/5GtDmgASYiJUG6Bfr8Jh6ELPd04YyoI/Bd5nmW4OVxtguZdv4q/0Gg/eFiKcTm3iEF6rYksWjRbsn6qV6IkLOPf0l5gEMAn5KTAIFBvAPI0z8eAs8EcqfSic8MJJRIzzCIfmx/j4roY2zmTT9mm1LHg==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0851.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 20:38:13 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 20:38:13 +0000
Message-ID:
 <GVYP280MB151838ED650B504461FCD56C9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
Date: Thu, 12 Mar 2026 02:03:43 +0100
Subject: [PATCH v2 01/16] carl9170: mac80211: enable Short Guard Interval for
 20 MHz (experimental)
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
    ath9k-devel@qca.qualcomm.com
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <6aa78391efe8f7a63fed880add06e0d8@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9625cf17-7669-4c1d-de2e-08de8f656df8
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFrYYoNnnwxejuezs5MQ3rPaZEgdfl4JixiRFe4i4TAQQxI1TxCIrDKO8CP/YgN8bMEhb4hzJpbEZcPRZeLk+sLU1SfH+SO5/HLQCHjJjq/a84KyODzy9xM8G3JUjJm2w1e4gNAnt5fByfOK2hd5vtHKynm6C7TdwZhNBQY7JT2H3KhMSZKeKHzfFMM0lRqnT0IkkowTTFPBv+SPXsHxCtHkFOD2Dldjlyw01Olt/pkA8ExHIjGEDdOomQojcVWNMh5PGjpwrNFsXcUKtvXsfDmERuFKpCofNmrQoPSPch3KrTMzlOGblG5Ts491NHKgvQ4bVI1770dJPEGZni3svDJX8m1Mee/xQtlC8DjPyCZEB9wT7cn1Lda7QWASzlpjeT39mBcAWB20Bp8oDBkKl1npP7q8G1+3d93cSwD9zLK9m3GEwbqLJP2oO6KhbwfewFQLiej05sIUWcLOD67fwdpOK6i3MS3mV+j5KExjjKRqbIGn1Ige9EfITZyPPxwNwn1cTUS+RVxdgGW+8eEkK3jMs4HsaKlJyfl/IZLfIbFDzCeTkB7Y7eeGa8h3b9vZ6evKPov+nEgbcGvQtlBPMqR6LMbjG56QZMy+FGSh/6vKzb3ms80O+mqF0a0BV5KiQlNipUqSlMglmOYKTZJInHuUaEPF3ktxSaj2dKEojuD+GXHQm1KRYaigGJcK26eCXvrdS9ZeM30OZbhi4O9FFdMANIuCCq25bfJhcykHEg3Q94tN4uaB6UdH
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|23021999003|12121999013|5072599009|5062599005|19110799012|15080799012|461199028|26121999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xjfmSSUzdYrbOzvWVJV6nOkMwfmv4u1z+TTD8EOTSQKTGst8/urWc10ph2PC?=
 =?us-ascii?Q?lMYNqJm+oplDyxrTc4foqZPqfWPM6rlvhCWDrNAkE1WpTnL1gkYUFN418CwZ?=
 =?us-ascii?Q?mCyAudLAz8Q4flcuGPZb29mdM7kI5Z09mS7H62OlSxakaBKCdvg8/Ha6C9bh?=
 =?us-ascii?Q?9LWetReEc+hN9erxx8NGw/wEVKtPZfVFmnjJsIJGV0PNS6RgWQ1Q7aDC2FRZ?=
 =?us-ascii?Q?hC/3RKwRj7OlmTaz9ciSjhA4WXNFylVZz1LS76KMdUCpSxic4yU3MCekd6pe?=
 =?us-ascii?Q?s01HavjmNc6nRvapf7GaKooCn4Vxjh509tihMYXM3USzDnNkw0y6/NNVECeo?=
 =?us-ascii?Q?TKPIvPASzmM/az02NvWFGPLuZGKaxu+jmNqcDpZwVskdhkGCAFv+HMDYdmHS?=
 =?us-ascii?Q?X+0XrqDMRJ81ilc7//SrgQNUL5cZvjUKlnkJbOr5CiSsAz3AULBnxULxtLNZ?=
 =?us-ascii?Q?5B10F8jGxNcRU3GjpwJDtnVjj2tjVtgQpY3wJXkzaIK6XJZfRHTJ8Qe9YnMM?=
 =?us-ascii?Q?mLBXrGkPPATontoraABQRbvSZj0TmxEg/gl1ZrAx+AXMt/DSdrUUfsZSX2PF?=
 =?us-ascii?Q?GuL2lMeKMuP+x1tuyG6nOcbpoS0T1oXEwbUqtPrE+c4d5FTS91W0pf7GLUac?=
 =?us-ascii?Q?mqsebXGWQp5xflzXPvxuEFyW5XIaxotqcYJ7/5wOAyxtA7ay6Cgsf86enVIe?=
 =?us-ascii?Q?q9IAVUNG+9X1nb7dp9HCSil/rZTGUI6uSTZcxd3Bywe+OBskhFlX7gbCOVjo?=
 =?us-ascii?Q?qtAB1/wiameN79tujxuutxlaphZNKufhJGeY0GHMmnqEF6rK2ytFnyI1+5OW?=
 =?us-ascii?Q?i3VujIhsycATOVLUkjHiKE+d56q5o6DzuS99kJbD7+0eDhMqfQVjy7hQ8aFo?=
 =?us-ascii?Q?v81qzyOQpqIH3uMyq2pDFzyNQyB7GaxjiFT+dHOcBjl7GIb1U6zGCP4TArIS?=
 =?us-ascii?Q?2hnhTVq9bEs1vDL8oEGQYc+u/k5hW8hoFOmPbeJCNCjaP5FvBLiuOqSQh27P?=
 =?us-ascii?Q?Jzr0?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31OFAowDSpHkwKpWWrNyL9gNZhnGnlLiVDGxXpmdHggjSYmyKCfwvBXIjVIp?=
 =?us-ascii?Q?bqqCwD4fxERccuAHW9C8reWYVnWzj7A6ZleCwVhtLtzyCSJWsGLnpSKcXmGl?=
 =?us-ascii?Q?8DGtot0qU4Iv6lH/D+lTw01FxtP47XjlEJQmcjqGzkXxsbEQBs9dCyKppDjP?=
 =?us-ascii?Q?JV9TfPvzqle3VTJIQYYUIcSwSqm5C44xN14bl/GUKCi5ft8RScPFfsxLbb6X?=
 =?us-ascii?Q?sC28R0nqo4JYG6blCBHhgdhtTR7zmvxABNz4K9dppqox4kjpZr7t9+jHqiUf?=
 =?us-ascii?Q?sj9XkSWxzAXLy9Jia2nT0jM1UejblErhEHJ3iBoRhb7dnN4xYJxdxbPa4ZOp?=
 =?us-ascii?Q?3D2wJikmTQ0AV33qIcwkJ0lnhJt/RK207BNYmLICYLIK1KOU/XiWnPTWmyEk?=
 =?us-ascii?Q?JZOkDRtuX1T5x6sMXjbc0SE5t1x6YIO3Eyhv17RD/0CIQWOvKTAmn/I+bV1T?=
 =?us-ascii?Q?Xz4KcBrKy+7bFxQkvdch3KHXJjUL2jUbUp0e16RMCcGzS7Pikky2gh0Ipfnn?=
 =?us-ascii?Q?P7yXjkYdwJ5GwSRw9tZ1N17byXvVCZ6dadhUUcVAd1mMJar//KmOTFYThDVR?=
 =?us-ascii?Q?wmOqa2eTd95dPExTjNv/kSmg9BWzvKJxpcOSIRUIw84AV4JrLhueTm6/7Mak?=
 =?us-ascii?Q?7Epd4MocedXNMMXRetFGt8HDvGhUnUWRm/lK7e3z4h5kEg3pMqjgUPsFBTNW?=
 =?us-ascii?Q?LWfspLiGx9qJjz5/nT0pnlWuoxjDonGkQLtCHK/FInI6cOxI9ADEfkz/QbZt?=
 =?us-ascii?Q?j6rIf1odxpeBCMYYBsUBTi6EkNNfS8wfrbjAAryf2vzv4PHHUxQ9UFgc+a6Y?=
 =?us-ascii?Q?9AyZuJQ+shQrGPTYk1JT8sJB9qfOGbkh9aUQ1+5zfz7Mkzh294q+RjQHIKuT?=
 =?us-ascii?Q?F9vhIr3k7s9cKlDb7zv9ugCX7xYE/eX3lW2YuUm4BVJxrLWJk6WHHQv5mA0S?=
 =?us-ascii?Q?lOFCj+VLmlYM3oiSieVdifqafCmi1IkEgA2kLqXWKC6CnPQD7DZs/sH41Xa/?=
 =?us-ascii?Q?7dU/yXR7IYtVbb/oPXG1jnfKkhvcZt/4T+SBYHxH6eI+2K/Q4ja0RV5E/Rg2?=
 =?us-ascii?Q?uWgprl3b0j+Cw9JvDIHhHkVaY3bnJXwnXZyQQF3HiLoMF2krlIMxIp8Afdus?=
 =?us-ascii?Q?nqfL2d7j9qQKvk0jO8yK78WtL2Pb7kBP6J+5EzbvcXWgOgm05ho1ZYfpWwUd?=
 =?us-ascii?Q?VdNcrqUtL9RMJQSTTvlbZoWN8YDNoQcEbAm9/83ThNUNG9AEUg+ocDWqvEZL?=
 =?us-ascii?Q?W9JpzpzT6amfklvPXmEJtTkz36lctgG6lC6i2p1llmB7pSkB2d0B8sexBOoz?=
 =?us-ascii?Q?ZqkmP3YBrriVetYPtyrRIHjmUzF31xxTS9tRLVm0nVCJsbu8RWO1GfMe0Keh?=
 =?us-ascii?Q?XVxp0Ww8uYf8nAf6Lz9dUmG+rMgJ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9625cf17-7669-4c1d-de2e-08de8f656df8
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:38:13.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0851
X-Spamd-Result: default: False [4.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	DATE_IN_PAST(1.00)[475];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34246-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,hotmail.de:email]
X-Rspamd-Queue-Id: E6BB63713BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v2:
  - Move IEEE80211_HT_CAP_SGI_20 from the static CARL9170_HT_CAP macro
    to a module_param (modparam_sgi_20, bool, 0444) with conditional
    dynamic setting.  The AR9170 uses a ZyDAS MAC with no silicon
    revision register — cannot gate the capability at compile time as
    ath9k does with AR_SREV_9287_11_OR_LATER.  Approach mirrors
    modparam_noht already used in main.c.

 drivers/net/wireless/ath/carl9170/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index af632418f..41a9f931f 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -55,6 +55,10 @@ int modparam_noht;
 module_param_named(noht, modparam_noht, int, 0444);
 MODULE_PARM_DESC(noht, "Disable MPDU aggregation.");

+static bool modparam_sgi_20;
+module_param_named(sgi_20, modparam_sgi_20, bool, 0444);
+MODULE_PARM_DESC(sgi_20, "Enable Short Guard Interval for 20 MHz (experimental).");
+
 #define RATE(_bitrate, _hw_rate, _txpidx, _flags) {	\
 	.bitrate	= (_bitrate),			\
 	.flags		= (_flags),			\
@@ -1972,6 +1976,11 @@ int carl9170_register(struct ar9170 *ar)
 		carl9170_band_5GHz.ht_cap.ht_supported = false;
 	}

+	if (modparam_sgi_20) {
+		carl9170_band_2GHz.ht_cap.cap |= IEEE80211_HT_CAP_SGI_20;
+		carl9170_band_5GHz.ht_cap.cap |= IEEE80211_HT_CAP_SGI_20;
+	}
+
 	for (i = 0; i < ar->fw.vif_num; i++) {
 		ar->vif_priv[i].id = i;
 		ar->vif_priv[i].vif = NULL;
--
2.53.0


