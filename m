Return-Path: <linux-wireless+bounces-27764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E227BAFF92
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Oct 2025 12:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5542A2A4E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Oct 2025 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD661E9905;
	Wed,  1 Oct 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAFBr3cM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73A1A3165;
	Wed,  1 Oct 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313880; cv=fail; b=hgVpHrdyCJYq8GNovHPeSRqAamgRHv6ZgR/pF2cZdAHWseCyyC/CTJdVjQh9IPfvN7dnn7enf3S4zbuAUjjhWbraBh7yYcsbxBe6NiexQ2E/J2mm5BFqUkNvgpKmowTUAvMbQLTIjXSNPjY3RBV2ZeG6XM6E3caUTCs0uGx4APg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313880; c=relaxed/simple;
	bh=nrG9WHTwVsalwVpnnmgQxxFvBA7peFPREudz2SG4zSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VkEy1PjLvUv8ZpvRG1FjliSPZpMPt7qOz24Ds1Cy6HCNpuQiupSrzQUCV/UNZX74iMO/HEnFMvRRgCPrUnLVwsV6Zgu4g8UiPZQ7JoCaRfiCGlzXz42PYuGQSx8axfmRNJrTo/uyH9ObBBvjitcfdsnutXHxePsoZUHnUQTvifI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAFBr3cM; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgWJJnnAJkD4RjGDi8HDIH0m7/YJPuo+a7jbF5W4heBh4xWowExP0gsysLfQb5rxopPVd6Qmz3AuLlg7alfFkC8Km/z5wDJmAol59h7vRif+DZ9/ES/kYam2zTQWbDfKc0YIgKZTVinIYHEuPiU8lK/ReT6Ek2jrqvQICbgv7Uax6MBH4DNmeE13P2K4ROYmZ3Mjk/bgV6dxW9OIDH5MTm4UPOO2YJeAOucQYuGLXvwKwqS2fbS+SAcg5YQzsv9at9ILWVUhggtQVY1qOqkFjw7KBjgQaFBtRN6tZt6Pn7O/9XZg2IblNkpl0UJTB9MciW4oNhqSMsdAJaSw2Lk8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYnhGtSxEJaqTh1UukkQR1gYwtLmb2eP7GaHStGkQn4=;
 b=E09DaZI5X0IkTl+0rE+mY6mFySYIWNTw52yCft+zmsHnLj6nLwPr2ZNaYXDLjsn7SxCS9WdYgTXeB9O7hWXC8xEFB6NnJZ+910fHDU+Z9z8eju+o3lIXgNUBZAcinkYcNIHhIY59v3r3PSW5jF3nmjpv6z+1zYcXj+Ujc7Xx7TdoWf724hw/fDfWLmaElwB9DFafR4bvN5APup1uIku2iNwAaHh14oNLAjfF4ACwt+8JuEUF22j1ESIM11Q9LqPIH+PYspcEaVjw5vShDD66tLoObzRrRvTfBB21bq5pl/vNuqRIgHjJR8do8WD2MpPdOLgVWg+DwApU9z5vYTPTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYnhGtSxEJaqTh1UukkQR1gYwtLmb2eP7GaHStGkQn4=;
 b=CAFBr3cMM67Xv3WMLeQztXwy9JOlukIbpcpftMOqOuDqQlffdLiAYSKZQyXH1EdAFEixSRWEYoSY8K1BJ8+UoF2OcQP+dgY/PA2aOxWvNbiyx1e7z2dS0Y9Cp49ijdeFb6zRrM2B23/uPKBz7kLTK/v1ks6gfkA/pfMJJ1qLo7HIBd1gtMNZYBpGKEe7O53ZNDl5QOV8pv7bHNTHhbv+1c54IT9eZeBj4HV50va0GK7wSGT40XGRcf1eLu+s08557rejh8uC3QfsuAQ+EXxHZbr41+uUb1DBRzF8HluE/vYu1xilj0LzdlnXv0b4E7uDqvAAeAW1DYDyRRUvdQG29w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 10:17:55 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%6]) with mapi id 15.20.9182.009; Wed, 1 Oct 2025
 10:17:55 +0000
Date: Wed, 1 Oct 2025 18:17:32 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de,
	brian.hsu@nxp.com
Subject: Re: [PATCH v5 18/22] wifi: nxpwifi: add core files
Message-ID: <aNz/vOlApzVzMLZy@nxpwireless-Inspiron-14-Plus-7440>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
 <20250804154018.3563834-19-jeff.chen_1@nxp.com>
 <6b8ff5139bb9c361468840046b757dfa5ebe1aba.camel@sipsolutions.net>
 <aM2bmc49cJXDmcf3@nxpwireless-Inspiron-14-Plus-7440>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM2bmc49cJXDmcf3@nxpwireless-Inspiron-14-Plus-7440>
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|AM7PR04MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e97fee-7f2d-45b5-ecfd-08de00d3c975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mvf0sSHCw15N/hoOyTe4bmTv/LLSSiiDhRbc6Ou1ys6ERQHG53Tvr2ctLzs3?=
 =?us-ascii?Q?2Sd9vQ9X/jBjUU54WFSxBUWyJk7f2wJ0lSff69FIk67fQgOsNSP/93H5dh2K?=
 =?us-ascii?Q?PhLuULs0viSoVgy4aeL/IjNet2yuCu12CmEyHJXlA4Q9yO9h4ZIymOujqwof?=
 =?us-ascii?Q?iBHrWKdFbPv+0EvaAfWkjxP88jabW6c/tq5OO0kizoxQWW3LyrS6a/f0EumV?=
 =?us-ascii?Q?2I5RYnJ6XcLpXXPKlGwoUU4QBTDrmfujTrFLfJdf2ab6/Ix7D+myN3QRVo9G?=
 =?us-ascii?Q?o4xdMZfmwQ3LYStU8XVI7MYYA3XpHIAHU1Thq8Jiom4ZhBfv36kuqKeOul9N?=
 =?us-ascii?Q?5Ix3Lp3gtcSl1bLrz814H7eqdxovC22e61fTBR8XLBeTJX65/R9LtpJfaHXl?=
 =?us-ascii?Q?aBApdBgNtRzbtDsB8U+tlqZRLoE5EsHZ6cERqHUTetmocAQYlBvKB365brwq?=
 =?us-ascii?Q?Q1rZ0xZQ6BAYAS44gPPfghiXY3y8/U8LjBizk+zIFERl1xS4DwfN5qIB3IHN?=
 =?us-ascii?Q?o4bji9NufprvCvxI2LWTtCjaIG2zzyfOQvPXKNIIWxkSpR1xFvI3SslRagR0?=
 =?us-ascii?Q?6qY9Fn+R2hMnPbp3ixkrOoD/jN46a7/yxdIGIWOOCpZWwhV6d4CVElvcaiL2?=
 =?us-ascii?Q?j4s8SRk3AszGeZ/sokDO+oyM3LuZGiJBMhQJtTkH9UPXp9Bcae251S73+HFM?=
 =?us-ascii?Q?x7bV8Zps2d3ECMhiTv5xqIOZvpfz5uX9m0BP1XPzGcrZ3RqX97SmGuQ7Hyng?=
 =?us-ascii?Q?n0osW+IxW3W66AH5TEHDZVWwByi870RZ6nKBErYnPddSjeIOEK+2pwESJwUb?=
 =?us-ascii?Q?XtraIs1GZtwJOJmZerBKvZ6OP8BiqOSQUNkuL2q0xNifJePWxqZHqqMhs+Ue?=
 =?us-ascii?Q?QJGN8KLOJ/szlZM+CpEJE9WEanyJ94c7ylUmjKqWXiLt4rmY6VrzoB0m7FFo?=
 =?us-ascii?Q?0l5BGNYqVVwzT+UFkDUy5B50i71t0KZYZKqhDYGKnFtATuKOsLBMzsy9Mz7s?=
 =?us-ascii?Q?ipYH1wQrUU7N7Jw3I/JJ/d3vKmYHqvIszDrGBOO1ePUNNFAUxdupYFHgvfyC?=
 =?us-ascii?Q?kE92KXLAo/eq7X5Sck3PkdR+qXCn4gR6QlzHwv/y6wbv9IXhrt0EhRN7LLNa?=
 =?us-ascii?Q?TC4guE2ebS3MF9vNKMcYj7o7+a1jDET83XxTyhz99hQK8kjy2H7zDDr6ooXK?=
 =?us-ascii?Q?DlMDq1riEjjY0TVT/BXPR3vQ3JHBoLeflvhe7d2I37QWm1LXhlDJtSI1hGrf?=
 =?us-ascii?Q?ZK4Pbgr1mnL+Paz8IzWJFLu5qpyv1Vbqm+2oHXpvD+xggyAIH5YwdfoFTLgl?=
 =?us-ascii?Q?tUSVMxcgZ/xsjLIW3v6Zoxv5h4D8+SFr4mCFMfaurFR+2LOz2gugG27m0MMB?=
 =?us-ascii?Q?bi/Jlkwejjb7hIGtSSkQoC1wmsF7kflibGbs4k+T4HG//XgwVzwGOdeLntUX?=
 =?us-ascii?Q?3Kvui53qS8eH64GSN2J/tnmyGcFJr1gj8KiL49wjF6aPYo/+ByM5E6+QbRvU?=
 =?us-ascii?Q?GIb3RucAGxjWLY/o9zc65acBBN9pS7ec7YAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uw81qCb5QKlJRZy7X55Pd58UhgcHwIZxLdX52+nvb4tuYQ5EAde3eGZWEDkW?=
 =?us-ascii?Q?JdBVxCFlwJJrA5tvMOHFSfuQ20hPedWRHIf7ZuefrTRqFBnndPmKb/A1IdOQ?=
 =?us-ascii?Q?9MiBQXuHTPxcuP2i7hHmGw03DlFTm7izDBj5qZt1PnMcBs1krOueCmHRqClU?=
 =?us-ascii?Q?U3SkZOFlZaQUxxWqLJ2+Jkp1JqhxXn6DP/J/ehNHnk0qSVwfOTE25XAZZx60?=
 =?us-ascii?Q?lEkaCASiEfiqLP2sM95dNZyBsIkysY9TgS9s/fKuhwRX5kcXdUR0mgaDqZG1?=
 =?us-ascii?Q?uWzYT85s3Cwdvv3G8bhjBHL4qtbe7kMjXhE0r9w8WHRlkeF5hoD+JIuXSa6N?=
 =?us-ascii?Q?uma9uB/lGbIqobiAYtfoHCVvSwLh6IzRiv+JM6rRltIDoRdgdY/r0hQbUOr/?=
 =?us-ascii?Q?Y2Zs3deBcv15wEuOARL7jrNsK6yinyeqG3mPH3oPSHHl511h4jKmbCnk+2d3?=
 =?us-ascii?Q?QKoZQt4BUcxMspeDeRoV2/jK5Rig5ud0NSKCLzF+pfcRuq2Cp1pGALZbNa3f?=
 =?us-ascii?Q?EpzPI8URgAIYGVwSPNECYlzSzt3ta8ARtZMEcygTIDHZnsMuOtpjlQefVBr9?=
 =?us-ascii?Q?JL3hMtp0tE6661FxlaacPouOtwt0uVkeAVIsInhYX9CMu5Ftiodk5u+5S/Xs?=
 =?us-ascii?Q?zekRc7D50d/yfNuvvn4DQpLPk1NgzPtkwL8h5eLe4VjU3y5YPobl07jJvSHa?=
 =?us-ascii?Q?RcGnubQ7lBIJCQKkVfSZ9BF/HUYgifgfCT5y2DSELezgVBgOxNFRFi1VqG8t?=
 =?us-ascii?Q?fzZV57mbz7EL3/ILfdJXlydpS2qVhm0gVbgDdKVHokQhnwKHsynTIBh8+VZj?=
 =?us-ascii?Q?YINrBoVFzg/KCaT4IW8dBTyHXxyA5SFca4VseJbObwClan2xzKMGCWoPh/6m?=
 =?us-ascii?Q?BohOA0Yw0BqrhNjuUVJALufFFmiufOjgbe/UBPoArbKVhmQrjWJnlX4URFn4?=
 =?us-ascii?Q?nkwqMh1PTnyWZZ/DOSVCOjeSsD390i9Enc/FGOx+pCefd9NnHmW2pdbtAu8p?=
 =?us-ascii?Q?WQ/knbXerlxQ+DHsgjqahnw85k7N/cP4oLEtRwUfS2KF4E9uPYHTWqetQEjy?=
 =?us-ascii?Q?kOX2GhGDijMs8qkEMkgDxDiWwOdN0XYoFcU7QyKJPlaEAvujY/1Dd2UZvQtM?=
 =?us-ascii?Q?xhYIibb7DxnJCLzs0CMNCfg0OV4QmZ0O6OOIF5AbCIqMgiIOBdpI/sUCS/Dh?=
 =?us-ascii?Q?dCNlUasHX7UmUbEbCr5ry1M/f8lykmefPVWRaJtHcQ3lI4majhBe0//rzJYN?=
 =?us-ascii?Q?pG+th3bzKXPhfNMDYBjCqxUzo6UxQ5m3JseDsk6DISA/Vqr8p2WqsFjUqNzi?=
 =?us-ascii?Q?YZmf+UGXzw625XD3xmtRSnYjwnLxj7V8mOZZslU/b3euMLOaQB/dwTv2spY6?=
 =?us-ascii?Q?WVHzHUpAjDGpFZL13nopcYrtBW8OprVP4PTjQH0uCim1tdSuKaGfVSxxwlE7?=
 =?us-ascii?Q?kM1XsHD6bDdTvntbr1FGXRS6OGFUGbOdZug70yVQqMz2llUfSuM5G4GXTjtl?=
 =?us-ascii?Q?4ncQ92Cq50ciAWeb5vS8xe1MMPaWcl42U4WTDGbC/cQ8sezR786s65P9BiPE?=
 =?us-ascii?Q?D+UKkdVDhjRcOCczD3wlEzQLSFu3/zwHhDl86oGk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e97fee-7f2d-45b5-ecfd-08de00d3c975
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 10:17:55.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHq61aGfKnIP5uFNSlQiOz/AHYUpU8GO08gEzjGUI2MaB/b/UFG3t1Z4pBCVWG/4MBhn/ydtECABN0zNVmSTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951

On Sat, Sep 20, 2025 at 02:06:17 AM +0800, Jeff Chen wrote:
> On Thu, Sep 04, 2025 at 01:37:20 PM +0200, Johannes Berg wrote:
> > On Mon, 2025-08-04 at 23:40 +0800, Jeff Chen wrote:
> > > 
> > > +/* The main process.
> > > + *
> > > + * This function is the main procedure of the driver and handles various driver
> > > + * operations. It runs in a loop and provides the core functionalities.
> > > + *
> > > + * The main responsibilities of this function are -
> > > + *      - Ensure concurrency control
> > > + *      - Handle pending interrupts and call interrupt handlers
> > > + *      - Wake up the card if required
> > > + *      - Handle command responses and call response handlers
> > > + *      - Handle events and call event handlers
> > > + *      - Execute pending commands
> > > + *      - Transmit pending data packets
> > > + */
> > > +void nxpwifi_main_process(struct nxpwifi_adapter *adapter)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&adapter->main_proc_lock, flags);
> > > +
> > > +	/* Check if already processing */
> > > +	if (adapter->nxpwifi_processing || adapter->main_locked) {
> > > +		adapter->more_task_flag = true;
> > > +		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	adapter->nxpwifi_processing = true;
> > > +	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> > 
> > 
> > This makes me very nervous, it at least means it's super hard to
> > understand when this may or may not be running ... It's also the sort of
> > custom locking that's kind of frowned upon.

Hi Johannes, may I have your thoughts on the proposed plan to remove
custom locking and rely on workqueue.

thanks,
Jeff
 
> Hi Johannes,
> 
> Thanks for the detailed feedback. We agree this is hard to reason about.
> The use of "main_locked" and "more_task_flag" is a workaround to avoid
> reentrancy and race conditions between SDIO interrupt and workqueue execution.
> However, it introduces implicit state transitions that are difficult to follow.
> 
> > Could this not be with wiphy mutex and be very clear? Though maybe you
> > wouldn't want TX to go through that ... and maybe it can't since sdio
> > calls it? But that seems odd, why is it both a worker and called for
> > every interrupt? Should it even be a single function for those two
> > cases?
> > 
> > Also it sets more_task_flag when it's entered while already running, but
> > that's just weird? Should other work coming in really get processed by
> > the SDIO interrupt processing?
> > 
> > It seems to me this is one of those awful design things inherited by
> > mwifiex that just happens to work? Can you document it well? If so maybe
> > do that and that can say why it really needs to be this way. If not, you
> > should probably change it completely and redesign it from first
> > principles, i.e. figure out what it has to do and build it accordingly?
> 
> We plan to remove this custom locking and instead rely solely on the workqueue
> model. Specifically:
> 
> - SDIO interrupt will only queue "main_work", not call "nxpwifi_main_process()"
>   directly.
> - "nxpwifi_main_process()" will be the single consumer of all driver-side tasks.
> - Interrupt status will be latched and processed in "nxpwifi_main_process()" to
>   ensure no events are missed.
> 
> This change will eliminate the need for, "more_task_flag" and "main_proc_lock",
> reduce concurrency complexity.
> 
> To better reflect its actual purpose, the main_locked flag will be renamed to
> iface_changing. This flag is specifically used to prevent nxpwifi_main_process()
> from running while cfg80211_ops.change_virtual_intf() is executing.
> 
> To ensure proper synchronization, iface_changing is always set/unset under
> wiphy_lock(), which is held during change_virtual_intf(). In nxpwifi_main_process(),
> we only read iface_changing, so to make this safe, we also hold wiphy_lock() while
> reading it. This avoids races and makes the locking model clearer.
>  
> > The whole function is also everything and the kitchen sink, could use
> > some serious refactoring?
> > 
> > > +		if (adapter->delay_null_pkt && !adapter->cmd_sent &&
> > > +		    !adapter->curr_cmd && !is_command_pending(adapter) &&
> > > +		    (nxpwifi_wmm_lists_empty(adapter) &&
> > > +		     nxpwifi_bypass_txlist_empty(adapter) &&
> > > +		     skb_queue_empty(&adapter->tx_data_q))) {
> > > +			if (!nxpwifi_send_null_packet
> > > +			    (nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA),
> > > +			     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
> > > +			     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET)) {
> > > +				adapter->delay_null_pkt = false;
> > > +				adapter->ps_state = PS_STATE_SLEEP;
> > > +			}
> > > +			break;
> > > +		}
> > > +	} while (true);
> > 
> > 
> > Sao that ... those conditions are awful? If this were a separate
> > function at least you could write it in multiple lines with return
> > true/false there.
> 
> Absolutely agreed. The function is doing too much. We plan to refactor it into smaller,
> purpose-specific helpers.
> 
> > > +/* CFG802.11
> > 
> > (side note: there's really no such thing as "CFG802.11" FWIW, it was
> > always just called "cfg80211")
> > 
> > johannes
> > 
> 

