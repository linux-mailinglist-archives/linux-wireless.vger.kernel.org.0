Return-Path: <linux-wireless+bounces-34236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AntEGYczGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:11:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7537065B
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3831F30A6900
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D0330B2D;
	Tue, 31 Mar 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Z4LzWfWj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012071.outbound.protection.outlook.com [52.103.35.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F606223DE9
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984000; cv=fail; b=E6yuyrTzYJVUeCujm6vYMhnA4XRmPNsLIqJEQ6Qb6WCjUVdCt+Yt4ZnJdsNVc3jbmEAazWPtxaVMkxAf4SGzEVTTsz7Ldw3sg5jymk3RZgk2n8x72RWd4NtRwzTP5yOoUx6GU1SNTT+OslxvZ2HqFigtvhSDAA0S83ouKDMakbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984000; c=relaxed/simple;
	bh=hkKzYX1IINPN4G0F17jYljTo3o5vLoj6A8i3UGXvjVw=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzbXTAjCCMJZXHWZtLI6NQ27YXyLw5/FMfQV84g/6qktVN2bpOTEGBEOVvuI/bxLH1UdF5Pea8J2pHHlhu27b+biK+2I3xPoqNXCv8n/lP+EmcBXuetoKnVvYtaHojwCeQZnlJmz9mwKhKOdVYh9LubN6wneQglnEYL4RPeOblk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Z4LzWfWj; arc=fail smtp.client-ip=52.103.35.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLr0BUP0Ak6n3Zbu+mB7hHoQ+NB+wW5929N68tU82cBZWRi7O6dQR8mbd9+Q7rbcqod0yhLUvE3YvjJlqvlEYMkF79bFQMuJcOQ2X9h26Srxsg+ZgXMOEIePokUaWZCqgHe70SCQ7gff6jY4uC0mKoRQ4Ld8E5S7PijQTvw0FtOAJVsS+D9zCbXPhkMBBdTHCxa6OrJSbAzZazvPovFR0GkyhVzfexD8Ks8Dx7VRP6VmneRZzddUZh+x75ltuImFQ8jNaG2Hn+PZQjAOdy5Eq4bkkevfZoEztTAY/bgYqgZ1kVS2BG//sQxCI7c7NiEZRMDV6ioZ2incrR1morNkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdUF9Q1bjkzosr5aVNT7V3IqcU4vgHrFIexq6+I0uT4=;
 b=NCqw+wHPNhnOE7bA58ZSfw9PFuuzg9Q6aQ8t8+3eCCp9708bNiw49nEPUJopBS/bdzuHoILV9yFqi+u04IM0oKNaqtN58PHd8Jk7r7GyPb6fO4l7UTj0JR+2U9p9rm++fQuYCXgu6inPechgZBq8zx562Hw9c9XRmj3lpIWN6fhpx/BIhLL1/q/DvmZj+So3+aHfDwD9LKJk0Y1kS/R9PByi4w6T9CRINh4fKKZarDGNx14N1Uh/DqoI4E7UjgjtyiPpWEDxtFUk7Fc5NKMpiiwGtS552fgIyStBscWzPRt8UV4Vb1hMhrP9McwGInKoOCcFryPeTBjbjE7DSm4u7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdUF9Q1bjkzosr5aVNT7V3IqcU4vgHrFIexq6+I0uT4=;
 b=Z4LzWfWjNjP2qGFZejSAxwS9M7xze5GYvWfxZp2dfC3NAXXoCCg/e2RYEuZ66UfmEPGLrvbfacUrmj4SXmOYRLsf/wpxz/EdfooVXmfJx3QvVVbMmH6d9W9NogzylnUMIEMcyxUPe0HMTA03+9zzQ/JNiC3Ekd2Srpc4XwPjx2akG917omrjTfDqfuxVh8nYOT2eFVruwA8P3bF/DrVfsfZ+7w9F0U1AIc94NAmHixE+PUsiAOjlbloc1Dlrfo+VPXArQXCg2vSTJFfEbyOJ8a0Az8QG6FCdxOvWiLl5xvWA1GPf6vlPcK2XokFcvxolPs3NUuUciwUUaG0LVK2ARA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:36 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:36 +0000
Date: Tue, 31 Mar 2026 21:06:34 +0200
Message-ID:
 <GVYP280MB1518721E1CB0DB7BC23F647E9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 15/16] carl9170: phy: warm BB reset and same-channel no-op
In-Reply-To: <950c999a-f1de-48e7-9fbf-94806825d31c@gmail.com>
References: <AM7PPF5613FA0B6D188CBDBAFC0CE13247A9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <950c999a-f1de-48e7-9fbf-94806825d31c@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::9) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <0645cb2ea0ee5c32251388ed451af030@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: 87768e25-dbe2-4015-ea7c-08de8f58a131
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|8060799015|19110799012|21061999006|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0WF83+hA3adGVOeRvSCxtocIircuEzVm/TYmvpl3oxNECsTXL+c3luQ/kIVg?=
 =?us-ascii?Q?0cJWFU5MupoX/shMwCS248B054IlK9LHMU2XWDay2qmT3Xb80Co+KZMXzGxx?=
 =?us-ascii?Q?a3RQeFPWeMcXfBWj1oPRT14ISGgxQU2gnBeNla3x4hInbRBuN325Yt6yQNLf?=
 =?us-ascii?Q?ba+GZeI/eNWC9wUG47p3SaVXMp1dgzKycxcWpBPozs/EsgSBeo3cTHX9iux8?=
 =?us-ascii?Q?GyNn7ugLpMVUWexLUuPRAp50LKmqnUHBivv02kHYYL4UstZPvI1ya2+tgXoC?=
 =?us-ascii?Q?WL+mj/gf4JsPrRQLttdgTHSuVxdDs3p1n/Su+pljHzx1Rap55SK5tEkrutp3?=
 =?us-ascii?Q?CPHBa8V+n4ad122xhUcX8J0zyBXgrePL6fAwHidtV4WQXLbfyRunJyMoQfBL?=
 =?us-ascii?Q?PyWOh0SSjNg9Ud9CPuEKgSmem2xFp7MvAx8boUhMx4dzBqmNpzWreJ7UT8kl?=
 =?us-ascii?Q?goeu2exkBJmTnEe9khnqvUhVRUdxUFNaGmKvIO7t0tALj89sHLdns1qeNW/n?=
 =?us-ascii?Q?CU7txqUxBo4jXq3WPAe54TllfX+lXfuipfzvkyHemw67+3QGBLuXfRIQ8QzH?=
 =?us-ascii?Q?vlA/y7CoqT2VJDDrfMRcCHCTxAddbQRrW9KWwMaYBgkESHSTTxU0Q4HMSueK?=
 =?us-ascii?Q?mbXIJ9tULbepaBoYvi8f303ljNdqNximvBNjIa4D52kNVvxWpU7jL+eMZ3lj?=
 =?us-ascii?Q?4KLQX2WZxbWL8TOLgyqOVumBptl2uWPk1sDOMLXX/zkbg6L4hp6aPQrorSi1?=
 =?us-ascii?Q?Z/Y8cWLjoCFMKlGhLN40zCbt07cK73riPeSaRAZvDyQDKKXftXIMgGIzwj1K?=
 =?us-ascii?Q?4I2HBGWJLkDe/OQlxArTSGYT3lFk4SO5ybQQP1OR2jAo7G2oRFP+t7hF/193?=
 =?us-ascii?Q?8g+Vx4897tMcnQBh/EMv+GrL2sdrQwvY/Tbz7/NgaPD77vEQnYpLCjLQgD3I?=
 =?us-ascii?Q?gry9YQNOkZk/ijiH9JKon6lRXOd4DvBNLq9sxTgDrP8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwLXcqvMEG8k9R6ypiVZ+ET0CMZId4t+a4xVE0p0FXd/qLDAkxwH8XGQPbVi?=
 =?us-ascii?Q?J2HI7Ue2fWNnrHXidbQNFEp9QOVKaqEXrz88RVDgmOVw3nxrMffOoUh05kHv?=
 =?us-ascii?Q?j12jgKv1PHhVhqQi4knTRqfcAo2uF1dcoQYtHqsLMEBkml6bZGL+ui5kISuG?=
 =?us-ascii?Q?yoHGvMSTXPB/8iNxFAw/j9k5en26hDihlDshPS964fihTl3m5c3eDSUyXG+d?=
 =?us-ascii?Q?sMLNrTUYhy3Crk1+KUnv3I7XwiupdHIaGU8RexPJh2n9dnpStbwyCudK7YO2?=
 =?us-ascii?Q?5zTZG5OoW50fuKb2fLXn6CXkJozPe96epTPTIfxLC/zNjDcE9vcCZms53Dkn?=
 =?us-ascii?Q?crXeihXsye1a0YLeKMPQe0kcrcl8lOehhR7ik2cwXRVG6+cklUX386zS/tf0?=
 =?us-ascii?Q?mRrOufIvGW/D9H2GRyZS4Ficu6iBDbKFf5qsgIrpywcMPvTfyOqEsMUFZIq5?=
 =?us-ascii?Q?Eiq/InFtp9w8UwxnFwVPK1SvjMNZG35hs3N5oECFmhp9yBKx5FAoXOJzCKTY?=
 =?us-ascii?Q?Mza5DENB0ChF6VooBfa9lNoN/za/S+jwb/afzn2s/5YkitBq3UDCE76RgsUS?=
 =?us-ascii?Q?qt+b2v8uPCYyTP/Us10kwOOaRmtFEo5zmrMwhVzPQMxD6RYMWxKfUAWBSp1N?=
 =?us-ascii?Q?yd6PsqHau8rpjSrlCZ5iIAdz8NWhGB15lzmFonCe2FX1ENOj0TGAmmy9d7sx?=
 =?us-ascii?Q?5REWQxlGEy/OCDR7W0HGYagAwEydwQO9p4nuonuvtvVg3aav/gPy5VsCPIjD?=
 =?us-ascii?Q?afX+QPiYTi7IGwFQ6aLCW3EVcAofc+IlHAioSL/CuQdy3irLRDOCUQxZfZuo?=
 =?us-ascii?Q?i6yhzT5yN6Eo7+NfG/ivVclQg48f73hvrM9RSZyQxSUVKs7c7Tnb9p1CzAfP?=
 =?us-ascii?Q?5aWAxi67t4agW1OLk1VDOFds4RIwMCVTj/Va3pk+vV+uJ17mCHkeEzamul4J?=
 =?us-ascii?Q?ztR1IX9AWA4dvKbcd1D5MIxT1rMn4CKT12rlcCt/dtgk0xGb7kBZMUCqyJPf?=
 =?us-ascii?Q?K4lLIlzjk/eTDPcxoSSrgM41tp6XBJTtaiODddhMvn3V/7Vr5lpLDTLqCC7D?=
 =?us-ascii?Q?BYDd8P/NTh3ZaVzkJvylkUoKMoMFXi8aFTZjX2NIu7h48c8uTR7wcHGJI2lZ?=
 =?us-ascii?Q?Jo1bgvEI33kYenYdKNxb31e93q3LvFe82g2X0t4ttbDAzKoCbbMwSDPVIhn3?=
 =?us-ascii?Q?Z94dw/6TnXK0us6icEzggRCJdSRNIAUcKFXhErrr8tYh6cVNPPbWMGh8xw7n?=
 =?us-ascii?Q?DmZFl4uaJOJHvtFYY34mIMI2E1beGm8biwoW4bvRZpAo3kG1PLtXQQIUgFju?=
 =?us-ascii?Q?Svvy6xAO+E4De6Eg4JED2kZKnrw2bBykUemGEbwdJLcRfZr2AAaDHfzgFlIn?=
 =?us-ascii?Q?evu7muU1D/5sSZhSxmI5vGtlIYHs?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 87768e25-dbe2-4015-ea7c-08de8f58a131
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:35.9999
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34236-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 9DA7537065B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christian,

I wanted to follow up on patch 15/16 from the [13/16] series sent on
2026-03-17 — I did not see a reply and want to make sure it was not
overlooked.

The patch covers three optimisations to carl9170_set_channel():

1. Same-channel no-op: skip the full baseband reset if the channel
   and bandwidth have not changed.  Reduces unnecessary RF_INIT
   command latency during survey updates that do not change channel.

2. Warm BB reset for same-band switches: when staying within the same
   band (2.4 GHz or 5 GHz) skip the full PHY cold reset and only
   reset the baseband.  Avoids the clock-domain re-lock step that
   causes AGC calibration timeouts on cross-band switches.

3. Skip AGC calibration on same-band channel change: use the existing
   calibration coefficients as starting point instead of re-running
   from scratch.

These were motivated by the cross-band scan stability work in patch
11/12 — reducing the cost of same-band channel changes makes the
driver more robust when scanning adjacent channels.

Happy to provide more context or testing data if useful.

-- 
Regards,
Masi Osmani

