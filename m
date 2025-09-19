Return-Path: <linux-wireless+bounces-27525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F1B8ADB1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 20:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A101A03BE4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF824BD0C;
	Fri, 19 Sep 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bRO0GjA7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5B260588;
	Fri, 19 Sep 2025 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305199; cv=fail; b=sahzo1NSJQ/cm0RbJr3q1UhL1v0t95R+JRTdwtWjtwCiwM7qBKb0vt/Cz/KsTF3NVNdgJ2nLSJ8Z9qKMVgPb9OxkBQ5oAfuMaUg+/BerdnVrOFWYudIYUeZcBdGWzou6WYSNjtX3eX57wQ1Yu5s5saUGk9RPt3jKIW06K3yCTL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305199; c=relaxed/simple;
	bh=IEsY83foor8VRdcCEEblJSn6Bmfnmv4kve3zuow03/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HPWv4lK8XM2CYinL6G3JhvVPcH9LmM91LrjzTgrVLaLDZQz3svG0mxS2FoGVKl5hIw02rpBgyShWtSC2FJt6/efhepR8ftUd6XSa0xJlZCz0MK1MdqLH3g+6vLZi7d2cuR1M4cqu/AROmm27OIXexB19mLGmExW1AQkoMzmFGVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bRO0GjA7; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xphgLFS/Jm4BrOSruf+WAFxV8kZYKlTANcFhjeBDWEMTP4nYinSRb4mjxFgR9mHBOAx2PDprFw4vjDY6ch6AFyTjvkLmMQJamPaxj/MY+3UWIi5xfc+Gp18bXhiSsi6nc1gaqQZvbBw6ldjpqmvanJle/L4sf1720l+/0JKe7ktFPhyYh5NIAgIhxify1E/nSPGFlspNKHMgWCJzjlL0Idr1EcIDn2W9NPAFmtF6LIsbbzRjtWTWJwN74+8eRSNQnj0xXOM7lI8HHr0mJEjd5myKvtyR0n0XcP0QUe6QH20X2jXKvxeYmcgH9UI+PT33vhlyX4lCGqS/4TCMw5c2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8blYu8iTrOW/Oam3iE30DuCBWrrYmmURWdEYXFot3o=;
 b=PJExRxFevHD3WAZxtMQ60UQOyKTJK9rl9uD0Ptt9CSzTOZrbaOn6D7+S574qLrtMRUG8It6y6H/6ES/py9hIcPbdjlUzT1DAeB5eCRf4EMdxlx2kQf/3D+esWscVWEBzcdjIgpOIntNT3zMjeeYIIXQNWjHF5P5S8SeN4OndjS5mGlK5YWSKoaLrJKfmQgjd1vXMNm/RfOQV+7raQTJIAbYzyCy/epzP28CeoE4L2rbK/F8Lj0WWu9b/Jf7Kc3W9+f7N0hm1TsPSV9Dql4gNDfI4uo1GSLv9yMyTe6y4RbLjS4jFtl7jkEAFc0TbRMO1RcIBgO6ObASyMYsOqBaukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8blYu8iTrOW/Oam3iE30DuCBWrrYmmURWdEYXFot3o=;
 b=bRO0GjA7LZ9mWRDs43q2GWqO+CTeJWEx8iVehyrPqeEHlZmJOU8lWLPV34KWawAEzdCybaKZnEeYZQ++//NiM1RoNs1SneEx7wAfR7eSRqAaOjsiTsziXOjdTXnQhdfBPdLWo4/LWouaMv1z8r4IHPgR82CLzj90gUZpi8DLLHbCCThLNLu1Hrta/3Tda6w/P8ktK7LGz94/XffYbKI7LAEsskL6I4t5vG8egF6+RyRN0noMA11CBTACAqkf8mCbntjZy9Cl9DIqCT14db5JAkNiZhdxTcm4pcvOZPJ/xwTy7it0Y2hI04AarjXjZPZ5JjaoSE6geBqJrj5+bzwhmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10844.eurprd04.prod.outlook.com (2603:10a6:102:493::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 18:06:33 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 18:06:33 +0000
Date: Sat, 20 Sep 2025 02:06:17 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de,
	brian.hsu@nxp.com
Subject: Re: [PATCH v5 18/22] wifi: nxpwifi: add core files
Message-ID: <aM2bmc49cJXDmcf3@nxpwireless-Inspiron-14-Plus-7440>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
 <20250804154018.3563834-19-jeff.chen_1@nxp.com>
 <6b8ff5139bb9c361468840046b757dfa5ebe1aba.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8ff5139bb9c361468840046b757dfa5ebe1aba.camel@sipsolutions.net>
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efb5b0d-b976-40fc-c5ef-08ddf7a743ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73dQNaYXXxha53WP5Lc5w/krg3Jl3bSgDw7T/Co4seQbyx4dVhevsLCs9HjN?=
 =?us-ascii?Q?I4TJaGGFv+Mep8aSiiFfAHo0HkVYtSBZf/eN3QzdW53e/s0yqpftqa00F8LR?=
 =?us-ascii?Q?G/Q7tuEDIq0D6VZgNQp+3P0sOXsDwNueNw9QqDiZ3T3DYICAJ0GlTd9BpvD4?=
 =?us-ascii?Q?2TjVwtdpMWLdD2wMac2VhRWMxTb+ESOl7mz7PAKUSehPOhcJDbc+tvRW2Wx9?=
 =?us-ascii?Q?GIIZhi2nBx3mBsLAHT1BzQt0RxAvcoKxwhp3rnRSfPSPRIUmeI6jVaqaAMA8?=
 =?us-ascii?Q?uj4l7ULx/EasU6VBJNzMcBfo1GMfq1uzwao8gvqmobaxnqCeIKIbNQaTQ5Eo?=
 =?us-ascii?Q?rbMFDYLQbrCX3z9DouFc4cxfVdXxD2JzjFhYwAwZts4t2K0wHU5dc9NW7/t/?=
 =?us-ascii?Q?ctwjInfN8R4YWngpVt4YzOgSXh2KO300r7W/BGzyRnKKHwWJOHKGQm26fTeU?=
 =?us-ascii?Q?JG7AtxbUqTCS0VLFekI1eTxzVHqAQifYWqpuOB8S3nGT9McaX1ojRxG1kxCZ?=
 =?us-ascii?Q?YrBMR5bv+d3f0GM1YBADEELY2b2rL175pyNJ8/k0wqLaK15q07oKGxsPENJi?=
 =?us-ascii?Q?57wABAOMXtqwZOw2uUxJkuXTtx4zMnwl15wlVAm1gkG2RZEJNkVqRljPQYNM?=
 =?us-ascii?Q?L34SxQhIBsvah5wx1PX+niMUBkSBivn/HXRLElEbllwUhPnVLm68yys32vik?=
 =?us-ascii?Q?NkAz/U+wUy4UOErMm3KTqMbHn7iccPG68vvsLyFx0dyOSMT8CEXYfaqFn/+r?=
 =?us-ascii?Q?Qyt6L/CMEWkOTVqQCJ1yT6vPbZKUc/E86Ix1pn+1Ptx3RVC9fpQuABJH/ivo?=
 =?us-ascii?Q?8UF22KiM3IncqY+wWSDm9ajUGW8LJntALjtAvgYwqz3+YsNiZTlwR+E93RxH?=
 =?us-ascii?Q?lS9xZGMtn5VgJo+e5ZYG8tY4SDqWyh3qTtnpPUaOp9EgUVo+oT5tLo1k/8RQ?=
 =?us-ascii?Q?rnKpQAYMpx6nbrA5GA1luKRDAzf9Gr3HdmaQp5hxx3JZWntV0Wfvdoei9LKl?=
 =?us-ascii?Q?8nllkZEE83vDYCQb/ND0p3TbFLp/m8/3n2a/XgfyTFeP2NQ4qZjTjkIqCmoX?=
 =?us-ascii?Q?e5Oohh3grE/fhb21W1TwGbGTzJPJ9Mitp5jKu0efnvZl6O8ZKsi6gYUamdwl?=
 =?us-ascii?Q?rr/PcdnfkuSW0xWCZdm7RqMYrwXzZ1gCGxAbuNuMQKwglNCMhEFSqXDFCr3A?=
 =?us-ascii?Q?7uFlmbTcAXI+k4hlyIfUxD5xblsL3e9GK1J/tR1BemsLJk8W7l2lFUF6cEdi?=
 =?us-ascii?Q?2CXh0nHliIiZTQ5qFAAbXtOO6JB46eLi6NmCvEFqbcnpW6Ld1JwCXzjgJcgS?=
 =?us-ascii?Q?bBwTMf0MN4R3cqPN2s/cilwBYyXoWJlMSnhV7fxjIehRfiDCxqVejKETOIBw?=
 =?us-ascii?Q?OwFROTD/JMZxASoK5ddcQBXau4JuCrxhcHwEEYhW1nP34Tu973eGdbbg1frp?=
 =?us-ascii?Q?7/nx8Rju5gdT4CLgs3ICdKUkS9q8isJxx93DV3PsdwZLAeC+e/3y6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYp/7SzgHWPUT9FkSqyPu/axNGSz2TkR/9AlBnQmISnFdoX+3GvolfGoUysY?=
 =?us-ascii?Q?lVKDYGgtll+YiznlGM/qKRc6yEDbi3G/pPrNVKhs3hQocxGx7OxECeVXBOPN?=
 =?us-ascii?Q?tH++vIcNOa82p9bOalJqscLuxhFDCl+J3547AdADZ33DTZ+0KakS4fkb0TaF?=
 =?us-ascii?Q?X4OMur0ST9AM/NVSDR8x49klns8ngLIAbZK9z4B4PbvoA/UTuDECNkpQtZkc?=
 =?us-ascii?Q?W9m8qqCCK4cN07v/A0cF2vMYT4VSKKuYnh5C6jtPRsWe+3p+zOqaY+a/RFtA?=
 =?us-ascii?Q?lUdQRSYdeE4mOcKpzIzwHixt+mU5xhaPVrLD+OdyJtk/VZvxj1fh4633qrTY?=
 =?us-ascii?Q?U8Vq8C/X2bT2LYxptAyatZWsZdibxNLHiGWR3H4Jf5NWh2W9b/8LyzDbIy4x?=
 =?us-ascii?Q?yOJU3RpFOUynNQF/3KZldNXHrCSiIVKAv0oxjHoOAN622xKimHe69WpEFXw+?=
 =?us-ascii?Q?ceNbifjZFGJDDRBo3BO9bDBh22MNtPywf7cOTaD5sxvsQHYKRBbkVm+KtQtl?=
 =?us-ascii?Q?hissxIYcDAVIHKBTnEk2pXPV5loBgrZxa3ZvLwOkS+sNUzhHPkiAl5fCuig7?=
 =?us-ascii?Q?po9JdDWKN2NKmSpM/33Z4m/EI670mAaNri8Bj56ilbaSUesSkDxkzva3QCvi?=
 =?us-ascii?Q?YZrQ62Vhhvl/N9V8xOC6KSg+5K+5PKjLVwaTPffaX6qlSpi1+WZ6++dWjkNe?=
 =?us-ascii?Q?GznJN5Ndqm5k6VZyLNPNPpNPeNqamS116J7jNBjHDIOF7oXYMBRl7bTuTfZR?=
 =?us-ascii?Q?MTaktukaqJCz4UVdUfdLVOmKjP53sFcMZ5H8ZgPZiCLyoZ6wvE/+VlJ8oP8x?=
 =?us-ascii?Q?YRQ00XR1qL2+0Q7vqw7iwnLSOGDWUTnbc+/X4yq8mLNdp+4svnv/eDY7tvZG?=
 =?us-ascii?Q?cIkjsWJmmAAeIidKX8SBdm0cvqdj37gZ/U6Bmsyykv1Ao3a1o2tlH0Jhtbx/?=
 =?us-ascii?Q?bV/8IoFXQR0DN8xhcz8DWbT/1K6vGWAVuxlxGPpAJUNkcizH9cZr5hL9RKGR?=
 =?us-ascii?Q?A2MxSjURE+lB3PL7EUOBlNeQAbf7gr8fs+6NwhcNZo2bGmLRo2QpVow39xbI?=
 =?us-ascii?Q?4FUV1jbQbFT5ShxVTZUf5eroKiJ98PrssZoMr9/NpxRNY8kggAp3I/pbK8Fa?=
 =?us-ascii?Q?5qeYIHUuFj04mRa9XmgmNx5xsAREf+qy/UZNTi/vEDdDsZljL5udq1UEGLAQ?=
 =?us-ascii?Q?lw2nf1se9KgfL8HvFFNgQC7RovDlPrEthrs7909FazhH15ecwRT2rdWU1A//?=
 =?us-ascii?Q?E5i9pNQIsz6PEQLNAtBVoeoseujY5WJq0Uf7zMxc+cgh7IPtBqy5RScKyVT5?=
 =?us-ascii?Q?T272WRWHCi/oYZvVJTHAKJF9jP+ng8COv5KoIVlkwtE40tEaH1AYPKTdudBA?=
 =?us-ascii?Q?mL7g3dOQFo7knHpt3y+RPGZMnY1hSYAQaIxMszx+R33wRlVHcIU3bgKbHszq?=
 =?us-ascii?Q?JPmEUeOWPmPvf+KpvaDrpgWXPAo3/C5E9QK5ykTGVcrRp5djSXtja7fGtnL0?=
 =?us-ascii?Q?JTC4ZSu0Irt3LwP21wEUpzIvFt4P3WdkXrpuanCyrNN0+D436l/ItGbBJnNy?=
 =?us-ascii?Q?qilRyrv6y+vD7Gu4IcpMr8wFuAs0evsqPhbOkLDw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efb5b0d-b976-40fc-c5ef-08ddf7a743ce
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:06:33.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21jbUr8mf7YFQwJxMggPV64VkWj7rZW0xNN1WUyIxJkGQYiCicieM62qjEt1ARDFkR6P3w9Uy1nHITtcIyTN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10844

On Thu, Sep 04, 2025 at 01:37:20 PM +0200, Johannes Berg wrote:
> On Mon, 2025-08-04 at 23:40 +0800, Jeff Chen wrote:
> > 
> > +/* The main process.
> > + *
> > + * This function is the main procedure of the driver and handles various driver
> > + * operations. It runs in a loop and provides the core functionalities.
> > + *
> > + * The main responsibilities of this function are -
> > + *      - Ensure concurrency control
> > + *      - Handle pending interrupts and call interrupt handlers
> > + *      - Wake up the card if required
> > + *      - Handle command responses and call response handlers
> > + *      - Handle events and call event handlers
> > + *      - Execute pending commands
> > + *      - Transmit pending data packets
> > + */
> > +void nxpwifi_main_process(struct nxpwifi_adapter *adapter)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&adapter->main_proc_lock, flags);
> > +
> > +	/* Check if already processing */
> > +	if (adapter->nxpwifi_processing || adapter->main_locked) {
> > +		adapter->more_task_flag = true;
> > +		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> > +		return;
> > +	}
> > +
> > +	adapter->nxpwifi_processing = true;
> > +	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> 
> 
> This makes me very nervous, it at least means it's super hard to
> understand when this may or may not be running ... It's also the sort of
> custom locking that's kind of frowned upon.

Hi Johannes,

Thanks for the detailed feedback. We agree this is hard to reason about.
The use of "main_locked" and "more_task_flag" is a workaround to avoid
reentrancy and race conditions between SDIO interrupt and workqueue execution.
However, it introduces implicit state transitions that are difficult to follow.

> Could this not be with wiphy mutex and be very clear? Though maybe you
> wouldn't want TX to go through that ... and maybe it can't since sdio
> calls it? But that seems odd, why is it both a worker and called for
> every interrupt? Should it even be a single function for those two
> cases?
> 
> Also it sets more_task_flag when it's entered while already running, but
> that's just weird? Should other work coming in really get processed by
> the SDIO interrupt processing?
> 
> It seems to me this is one of those awful design things inherited by
> mwifiex that just happens to work? Can you document it well? If so maybe
> do that and that can say why it really needs to be this way. If not, you
> should probably change it completely and redesign it from first
> principles, i.e. figure out what it has to do and build it accordingly?

We plan to remove this custom locking and instead rely solely on the workqueue
model. Specifically:

- SDIO interrupt will only queue "main_work", not call "nxpwifi_main_process()"
  directly.
- "nxpwifi_main_process()" will be the single consumer of all driver-side tasks.
- Interrupt status will be latched and processed in "nxpwifi_main_process()" to
  ensure no events are missed.

This change will eliminate the need for, "more_task_flag" and "main_proc_lock",
reduce concurrency complexity.

To better reflect its actual purpose, the main_locked flag will be renamed to
iface_changing. This flag is specifically used to prevent nxpwifi_main_process()
from running while cfg80211_ops.change_virtual_intf() is executing.

To ensure proper synchronization, iface_changing is always set/unset under
wiphy_lock(), which is held during change_virtual_intf(). In nxpwifi_main_process(),
we only read iface_changing, so to make this safe, we also hold wiphy_lock() while
reading it. This avoids races and makes the locking model clearer.
 
> The whole function is also everything and the kitchen sink, could use
> some serious refactoring?
> 
> > +		if (adapter->delay_null_pkt && !adapter->cmd_sent &&
> > +		    !adapter->curr_cmd && !is_command_pending(adapter) &&
> > +		    (nxpwifi_wmm_lists_empty(adapter) &&
> > +		     nxpwifi_bypass_txlist_empty(adapter) &&
> > +		     skb_queue_empty(&adapter->tx_data_q))) {
> > +			if (!nxpwifi_send_null_packet
> > +			    (nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA),
> > +			     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
> > +			     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET)) {
> > +				adapter->delay_null_pkt = false;
> > +				adapter->ps_state = PS_STATE_SLEEP;
> > +			}
> > +			break;
> > +		}
> > +	} while (true);
> 
> 
> Sao that ... those conditions are awful? If this were a separate
> function at least you could write it in multiple lines with return
> true/false there.

Absolutely agreed. The function is doing too much. We plan to refactor it into smaller,
purpose-specific helpers.

> > +/* CFG802.11
> 
> (side note: there's really no such thing as "CFG802.11" FWIW, it was
> always just called "cfg80211")
> 
> johannes
> 

