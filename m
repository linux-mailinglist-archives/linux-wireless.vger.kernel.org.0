Return-Path: <linux-wireless+bounces-24749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7FAF0976
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 05:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB71189B00D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF791C07C3;
	Wed,  2 Jul 2025 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQ5ljBmy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69D1C6B4;
	Wed,  2 Jul 2025 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428540; cv=fail; b=TLYY33H3W357SDTy1en1uNhAwR7xXnnZfu/Q9smwIXvTs2WNe6HCGSbHZGlVR8AZNcHfmc3aUu2QabwGf0JtCvNu3LM/8C8cT/ABSczNGKXsd1rRhqAqCRVcdNdwMOH8DxdWDkfOqGRbjij9yviCQZjT1m5q9UjZkojIS9i94cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428540; c=relaxed/simple;
	bh=X0MGcppM5VrnldDCRhg3BSbJtharLJDUmcLgn+zBAoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DKJfYfmkOOKpcwwcgwc08kgatPOT1L+LJG1eDS8nGkTB0kGcmJTNipbGecR6aEoNblGmWp6iSFsuagCHDDnPDHcJ2hNP7oqoHtiSmZYVZdHotmBmVeaV6/cjQwK5sw1nKBpfKUXcbfIgllKDuLf9rcsh23bLdwp3uvKt9ELMzcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CQ5ljBmy; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6n4aMsIj/tBUTI6sYErgyXm+vz4ADDdksEfdzCr9+NWq/1yGN344xerBYHivp2JOWM1C/a9WpPvIrIgXxpbFepPUl+PpJKeLSAhNgCEyOzl4kKB6u4JB+vPSIiD1PHi6Si4AE6smjxQ486QCZpvXj9WEkYPNb0zBXS2MFMoE6kNsDumothd95ElZwD5aTqhFkcVk3lRQ/f6hlpcX0ztpgrOJGpnr3SN3CiuoktNjy8jIv4s14hHcDKgp2l4H/YiOCHND8bN4z+c410nBtYJItrs1C75eF7WTv6Of0P4OZzROC612BP2ekCDrfN0HWSTbG5IqfDm38ZAuKo4UzBCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23lEs/xZgR5+eNg1+3cmn8nYgxfdpgizVMnMwssRPhk=;
 b=h64JSdQf0o+fAxAPlVIWWFNH1hmQF+vD7hnHLQoogCHAqiX/3DVwOuSPpJ1hG9mZLl2eu8HwPDJUCU/S2h7kLiFMV6MG94AJV9nL3eRsEUoQduXE6LB8zATCkE1umRcLpy0eYjm3BVdDWTKJHvWT+yIQX4sq2gebyrrBhIykt+dU8e69vUJa88RJP8uJpU3Q3bY73aRbwjf3gcOwoV5dcdgOP5waNPf1KKFb2XqtHVGVMSBXqk3uJ7wRP0YzjuIuGAGbXOpW7YhkjIGGIVwjyHHmooYn49FGSxQZEsLdJpeVP5Rwdw2gUHN+3D1m7bxVASpvkDGx6OL+wvPPn8Ok/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23lEs/xZgR5+eNg1+3cmn8nYgxfdpgizVMnMwssRPhk=;
 b=CQ5ljBmyNGKFnjYQInEFgXuRpE4KNsXgsaRoYHJxTDEMJyUPmCXLyUABYc296q9lDdNOb1aqN6VMI1yl3PWMRUlQorHFc7FJ9ND7o7mRntN0RTzrpRCZCkFbZLv6y9Ws61ZfRMe/1mfERPtLUvjkCIvROTOUopP7CxRxGii/DKohRea+k+gK3uN+ew8TpwuMsG9Hvkk+MLhUQhbsSntGFO0Xbqg9dwmK41XlmINKNTYH+RxLP3FkTzHcv2lnSVJMsO9MRw83usm1XYybs8m4XY3/U3ZKOPBXCz6V6CMIDJM1miX40SQ611QLMZucQ7TP6XY4rAaplsJ1dcG4udUO/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com (2603:10a6:10:8a::17)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 03:55:34 +0000
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391]) by DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 03:55:33 +0000
Date: Wed, 2 Jul 2025 11:52:00 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v1] wifi: mwifiex: discard erroneous disassoc
 frames on STA interface
Message-ID: <aGSs4H1EqH3WngWx@nxpwireless-Inspiron-14-Plus-7440>
References: <20250701142643.658990-1-ivitro@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701142643.658990-1-ivitro@gmail.com>
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To DB7PR04MB5497.eurprd04.prod.outlook.com
 (2603:10a6:10:8a::17)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5497:EE_|PR3PR04MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: e7becd65-cd69-40f8-2b24-08ddb91c4b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gnxyb+bLMrTeGvc+YxXhpRc0HOrlTrOPybe3bKKM083r0xODyGsKUgBlX7rM?=
 =?us-ascii?Q?4q044Md7xlGhkhEsB5mADfj9FPlHJxuk3BD8lqkib497TSgTAPpVq+f2EWeU?=
 =?us-ascii?Q?+R6c7F3Cdx6MZweyZhxq3GvYol9ylIX4qMHDBm3J1oPu7gzx2zvbIbzfIF28?=
 =?us-ascii?Q?cdYksoRnoRJVQop0+C2nGv38ph3oSRuRvtxWypjF2IrdC7PVlmpQTUJrjqrG?=
 =?us-ascii?Q?o/eWWDHK0T08nMuUvq9Fyd0/OoMD72MDbc3mU9CiEcQsMZnkD1uC1VdmreMc?=
 =?us-ascii?Q?eSbzwSa6ZRPMlqRUPJfI/lfyGV6d4/jRG3o0tQdNl2LtYekzJcOwSJkUP2HY?=
 =?us-ascii?Q?XOqaTRGLNQdkAS+1rEfXmigx7Ehkzfh9qbQUKETUMcypmRgpPz59FC1okdzp?=
 =?us-ascii?Q?/F85JFbvuTtdlNHwO/+7eKcEuncMSgEHx5hUx1g2SUJcksLCm3/MvTT6g/Pb?=
 =?us-ascii?Q?qvqhhIneT8Fp/EksMG7ZORmTqEHvVW3Bvz5fHPEycQYITrI/a11hWpFR0gjz?=
 =?us-ascii?Q?FmAWgUjhY+pFMlva3bIeohDRGxuIOFXTBbIasCjNh1bQYWIPvxCeCvXSPvRO?=
 =?us-ascii?Q?Y+3gZEwHMUlekRqXe3HXtcm69m98usvO07X8Ut9zYrznPR+kqfnpef2Pmk5l?=
 =?us-ascii?Q?mBQjTaa0ixNbpvF4XH8jy8bxurE/RMHtWZ51JPKgA5HogHhumCdzoZNt3zQ9?=
 =?us-ascii?Q?mPBXvfuXZzPICoNjkKkghTaD+pm1Hysz+qJrCwrpGYlU+kpQ/o+iBrEvrW5v?=
 =?us-ascii?Q?Xp8azxY/519XRnlU2DDOrb7O0Syv90hHvqzZVhj1munIepALNIG9QjKji1mu?=
 =?us-ascii?Q?xZ6d91Sg9hjvzLGzLE4AThOXdyBGPOBptljbCrg2o+ejeMBoY9V1YCO4tgyb?=
 =?us-ascii?Q?VC954rz0efIdxA+DFwEilQyVHFf711suwU5N3WJzKSYCNMeM9ITzoGeCYYHi?=
 =?us-ascii?Q?T1rumExy5VKor6hsToZ2VSp77IwOBVBgsjuVRzB91O/61Yd7rk68t2IzUvjb?=
 =?us-ascii?Q?+Cb38Tm8lJwmdlf4U8AIA4xefK/w/IOVbIQFQdsZ0s9FqRFelt9/sYGc2gD2?=
 =?us-ascii?Q?w3Oj83h//LgPvpWFWR5+g0Ckp1NdBOA5v8S2k7+Gb7jfGnrxvExqgd6wbHri?=
 =?us-ascii?Q?qEWRLGXiKGfwE1EZFXptP2eSBAbxt9gh7qk46VjmdYTEduQ6gAOQ5vh2WHJp?=
 =?us-ascii?Q?M3CtASZXz26/6Qvt5MflJ1pQtATWxY22r9ll7CJyrA31fehPsYiD/xzO7ihC?=
 =?us-ascii?Q?5gCE1aNNh1w8xmBWlznxIxPQsKqjAohmz4hbhKkekKdDV5CN6sr9chcw5JwZ?=
 =?us-ascii?Q?PUzMWXwxB6aSMzn90wMMJW934ym3oE4AtAnhFLJlho6JGuaOgE26XWYLVQPQ?=
 =?us-ascii?Q?HQ9GFzrZu1rnLcV4HLSAiGiKC/LAn6zAYUOa47Sr06qvTXoWcpW7GGEHf285?=
 =?us-ascii?Q?soOdh6FDeYzzU2oRiZPUc/xZGUAMKgRk7l41O8GTuqU7PyeAv+lUWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qRXvN2iVoU9/Bu4DHbO5Uef5k3KOB+0yiFxgnJljfVvWLhaDms+OB8NuOQ65?=
 =?us-ascii?Q?P88o2eGyWAsPum35vFgZPw7RTspjDtReuM6eTQaHpK/J3Zqis/9dSPw8QO6K?=
 =?us-ascii?Q?liTjLx7aVsIJ1I1B5iHBYIDNFwj7hJN/p9V7nK76pR4rEk6T2VVFcmlc3z20?=
 =?us-ascii?Q?BD3nQk+wpkfZM7tPTR4jx/Mk0h2LFBH0mcErWBZ6Hp2GyuHx447jkcIK2vci?=
 =?us-ascii?Q?3fhO+s5h9O604J8Cc+BV2lB9NGjraaP5H8QUIeSLoY0/0eI4UvDsOXU/h0SN?=
 =?us-ascii?Q?TVTVNdd13L0dE5yNf5UcAD8kbR9pVCOifqqlML9lbzjvsnItuZqPNrr2G5oC?=
 =?us-ascii?Q?ON7yWt2NbopZ7uIupea63UC777QpRGAACjfoX1YYOzvTj7sB0EL4wtk/Ysbm?=
 =?us-ascii?Q?D128Zc5jW4dv4BQf5O0Rb2BtqHxH3NFlZ7nYoGcOBHQ9nZfA/LssLVpwMpHy?=
 =?us-ascii?Q?M3u+56tDiu904SrYgMff/VgISo/30KFGUanF57IfThYuZqbOweYNlk3l/byh?=
 =?us-ascii?Q?5faicg54mxzKUPaiRbk8cNR2w2olBpySfGAC0pWucDVuwVGq7C8no4gYQOjB?=
 =?us-ascii?Q?5X68INByKzJoSxG8ydsNI2LLnhmVyArJIVbyuCBRk1MUHwqyVio5Z9X98NSC?=
 =?us-ascii?Q?RtWI8ePdBFTGYKX/w+a4VA3Cm7gUUu6AGIUDYY9pHAfsbWC5PgVXk1RdoO4s?=
 =?us-ascii?Q?TIG6ELzplqyy6xLx3dSXugKMUpvGN89I4MdsHhRFKvzxkXDHqMxAvMFrm6lL?=
 =?us-ascii?Q?F4Pjt0mD95zgo8TPNQtEV1waH0BJOr56BKLwj/NQ06ZdRaCSGVTo4vYrXWJh?=
 =?us-ascii?Q?8eu7OrbQd8WN6kLlEgGtsNjvu02ujWz6/gJxwhH+n1QT8vWYT4XjVPcIaKyq?=
 =?us-ascii?Q?z7dIVCnCBkoTZ0k+/61omH9iE+je0QGX+vAdgm8qeRc9KQaiLRNWIJzb5eoy?=
 =?us-ascii?Q?jVWmFVzimfj2hmUsmqKOG5pdkQJUI0M3cbruDlQnfjLvoWzgIjkiZfMNN+n3?=
 =?us-ascii?Q?95vIWdmWqhMg8EdVqmQMEFmCvUzan6q0NvYZ0wekydjVhYM95qR09j7E9auP?=
 =?us-ascii?Q?0pHiWTWsw/d32emW6kme3v2HxPIdLgdiGKZSFWOgTY6J/jGl/7JciJKiwSjt?=
 =?us-ascii?Q?Wl8Be1UYbCvVGoNujm1bUYbTpduEG1wiSGNTuFk2u6TIm1/jX6jmC5OfkeZo?=
 =?us-ascii?Q?F+ETQYlUvuAvnyxLJdNUFudO6dxl+W9D8+FznhTUH7L5yG70OzQD+OrhFvl7?=
 =?us-ascii?Q?+O4P6TOM+TYhQYeigGYR1OC7mtjHLwp4eY6X/Pcjm0+jgp7Ub8iuK6x9E2UP?=
 =?us-ascii?Q?Y+SdCp9uFrji4VJFGG1smM65f/8XxPM/YUVPf8M9ipzL0wU+dSr0GU5EtzcI?=
 =?us-ascii?Q?EhbIpQiq03adbFmuKs6ELgexyVTFUh0W+D3nnNjTXfHuDFJixDECIp1vLhGK?=
 =?us-ascii?Q?60SV8OsUuUurgH1ZsOWPYKEVcS8zpj4mYBwrXpKnZQJXziLSMb8hYfGGEWXW?=
 =?us-ascii?Q?9YurJjCeiTKv1JaXYwz8+/oYXFXCPuOsvLm0RzA24raf35Ly5X+t66JZxL+0?=
 =?us-ascii?Q?jLSqd5p7RH37K/qAqFJPrgv7Haw8tl0SOh5cn86a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7becd65-cd69-40f8-2b24-08ddb91c4b4b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:55:33.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTU/sljqMInM7LH6chI+vEziV9IBEhdTk6MSdjbhtaYYONHV0bENsHWVXjiSdc1f9PyBUaVb8J/E5NGrfsUo4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404

On Tue, Jul 01, 2025 at 03:26:43 PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> When operating in concurrent STA/AP mode with host MLME enabled,
> the firmware incorrectly sends disassociation frames to the STA
> interface when clients disconnect from the AP interface.
> This causes kernel warnings as the STA interface processes
> disconnect events that don't apply to it:
> 
> [ 1303.240540] WARNING: CPU: 0 PID: 513 at net/wireless/mlme.c:141 cfg80211_process_disassoc+0x78/0xec [cfg80211]
> [ 1303.250861] Modules linked in: 8021q garp stp mrp llc rfcomm bnep btnxpuart nls_iso8859_1 nls_cp437 onboard_us
> [ 1303.327651] CPU: 0 UID: 0 PID: 513 Comm: kworker/u9:2 Not tainted 6.16.0-rc1+ #3 PREEMPT
> [ 1303.335937] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
> [ 1303.343588] Workqueue: MWIFIEX_RX_WORK_QUEUE mwifiex_rx_work_queue [mwifiex]
> [ 1303.350856] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1303.357904] pc : cfg80211_process_disassoc+0x78/0xec [cfg80211]
> [ 1303.364065] lr : cfg80211_process_disassoc+0x70/0xec [cfg80211]
> [ 1303.370221] sp : ffff800083053be0
> [ 1303.373590] x29: ffff800083053be0 x28: 0000000000000000 x27: 0000000000000000
> [ 1303.380855] x26: 0000000000000000 x25: 00000000ffffffff x24: ffff000002c5b8ae
> [ 1303.388120] x23: ffff000002c5b884 x22: 0000000000000001 x21: 0000000000000008
> [ 1303.395382] x20: ffff000002c5b8ae x19: ffff0000064dd408 x18: 0000000000000006
> [ 1303.402646] x17: 3a36333a61623a30 x16: 32206d6f72662063 x15: ffff800080bfe048
> [ 1303.409910] x14: ffff000003625300 x13: 0000000000000001 x12: 0000000000000000
> [ 1303.417173] x11: 0000000000000002 x10: ffff000003958600 x9 : ffff000003625300
> [ 1303.424434] x8 : ffff00003fd9ef40 x7 : ffff0000039fc280 x6 : 0000000000000002
> [ 1303.431695] x5 : ffff0000038976d4 x4 : 0000000000000000 x3 : 0000000000003186
> [ 1303.438956] x2 : 000000004836ba20 x1 : 0000000000006986 x0 : 00000000d00479de
> [ 1303.446221] Call trace:
> [ 1303.448722]  cfg80211_process_disassoc+0x78/0xec [cfg80211] (P)
> [ 1303.454894]  cfg80211_rx_mlme_mgmt+0x64/0xf8 [cfg80211]
> [ 1303.460362]  mwifiex_process_mgmt_packet+0x1ec/0x460 [mwifiex]
> [ 1303.466380]  mwifiex_process_sta_rx_packet+0x1bc/0x2a0 [mwifiex]
> [ 1303.472573]  mwifiex_handle_rx_packet+0xb4/0x13c [mwifiex]
> [ 1303.478243]  mwifiex_rx_work_queue+0x158/0x198 [mwifiex]
> [ 1303.483734]  process_one_work+0x14c/0x28c
> [ 1303.487845]  worker_thread+0x2cc/0x3d4
> [ 1303.491680]  kthread+0x12c/0x208
> [ 1303.495014]  ret_from_fork+0x10/0x20
> 
> Add validation in the STA receive path to verify that disassoc/deauth
> frames originate from the connected AP. Frames that fail this check
> are discarded early, preventing them from reaching the MLME layer and
> triggering WARN_ON().
> 
> This filtering logic is similar with that used in the
> ieee80211_rx_mgmt_disassoc() function in mac80211, which drops
> disassoc frames that don't match the current BSSID
> (!ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)), ensuring
> only relevant frames are processed.
> 
> Tested on:
> - 8997 with FW 16.68.1.p197
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.con>

