Return-Path: <linux-wireless+bounces-22166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACD3AA0097
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 05:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4291669BF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98AA1F76A5;
	Tue, 29 Apr 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+SgpbtH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AA1EEE0;
	Tue, 29 Apr 2025 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897592; cv=fail; b=bpaxMuUCxH0UfP6HWWjvZPBvoIcTCmyp5OeYpJrh4PVGl+HijnYMdPCPdjMOlMm3TFZFiHa6dfOWaCXssvAr100AybLAyl+r2Yqd2hS3v0Wvb/4hFzmdH/pUo89lEl/zxju4F5Mb3omBFp5hF0pb81LPgz+JYmuLRYEhiPxbL5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897592; c=relaxed/simple;
	bh=p0xYcCdFI9Dz4BshH7iYog8AcXgYNa3E9kkQYi6hZMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWnopZRVjfzk6TyijnWsyEHh1T7VZu9DuQ8C1Sa30xFP9Dsuc263J2Ym3tXZm/aZD0hnuidxPASgj5IXCPXCgy1L+/hzGnWzKWsnfkiq+l9C1hrBd1v/6nIll1Kv6nYGSjbOp1Knqzy19qBqx3l7gzDgexvcnoOaE9ba+tl+kkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L+SgpbtH; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l04GB3S+qgwvKOjOI4KJb+yqG/hbViYj8wpvAMraak6Wh0ql8LTAwYeTYxPPQI51j13acJMx6wJv3xE7tYxKY/VAun2krgSjGwyUNZPYXfbHwZaLmrQfhj/2q0uw8UgvhO+MYzS7rCBorp9ZPNsbOco3Yvlsxo0aZ4jio7k6OQoTTFP7wAry1/vrcl7hk4MuomLVnSTqysTz5HVCwKJmNZNwFEeBvRJDby+25sKD2xFWCwqIcsaUdzasgLPx7Vz5OeOz1onuc0I87RD/3jyrQze4w73EhsKAPz+uCFvd6/acY2o9OBYmxt3xVstVm4VSnl64oU/AGQ+ARUSLBtfmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORZwiBTYPXHZ4OV77h2E1EC7tOGA3mGuNbqd2K2QmcA=;
 b=d7Xmu0AYINQgESfojU+mkiUvOdjV1myLgC89tixv+OiBj2CYOXGvjCB/+qCZvO+Tv3VEhrU57x5d/TvYw7l/f6XniXN81nFSc1nOvzwS0k8J2pT/lwo6m9YIujdh2/IBNrDkbzwnjIFSYzA+rpK3aVhF3RB43lkX9HWZZQdhEMJ1jWQHjEfuCe/TLpJCds9CvQNPTsxgdmmKJHKvsAf4rdild+uVFAWZu7kAJyJhVMfgXMGC05dtPjez9KPgiyS/XsHgFV5Ql71cUpRGAx5Pp6a9mz1LRwDZfmrI5lT21D2cCvNsMSUSLZInxGuv3k6LUOAMyseH1UBqc3iXws8m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORZwiBTYPXHZ4OV77h2E1EC7tOGA3mGuNbqd2K2QmcA=;
 b=L+SgpbtHEFbQtmFzdU7igz5Ut8geZJdSPELmfOltY7wkbiflC/Lzcx7FW9AKQhLaOr9gra2w4I6OOb1y269OjDR4TSkXhquTkF7cGkkQGacuYuBQ0m75bTHq9Ckr04m5T2Jp/hs6MbRSjK4ptyrH4hGZlaaTqYcDhmmYS+0AeXJI7aRODzQisWCjDl9RWrD7YZYH8JHcXTnQFcl8ijWElxYQ0FPcoG6YNpDEJqdzDcwgOzJqFWnlrXCe97gFSeUOYrP89CaT95LmTjnnCmSIY1TF4mP2ODMRCvrseYOZbsYzZg+cmvnf9vhcKwbBwwHZ+OJeGVuth9Mv3bWKfHV3Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 03:33:08 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 03:33:08 +0000
Date: Tue, 29 Apr 2025 11:31:21 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: Use "scan_plans->iterations" for bgscan
 repeat count
Message-ID: <aBBICUmBvpL9rmV/@nxpwireless-Inspiron-14-Plus-7440>
References: <20250416155425.4070888-1-jeff.chen_1@nxp.com>
 <aAbm9W3yAxMc_C1l@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAbm9W3yAxMc_C1l@google.com>
X-ClientProxiedBy: AM9P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::35) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 56276147-5b84-414d-0cd7-08dd86ce8f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fQGw34lKVUSY4AqiVj63dJwuBBDFteSdzu++qgtPjg9CrRGGyuTPN7qmG6+6?=
 =?us-ascii?Q?T4lWmtTIlSqH6Mp2TOUs4kb+tAq6Mpb5NICmrU27lBG93W7ZTdfPge+gTG5F?=
 =?us-ascii?Q?zFUE7FrobOSN+umu1VRn1YEs1cL1x5s6Z3cyuS0tVvU/jy9c5UV6CscqZY6f?=
 =?us-ascii?Q?v0EC732o4glbnzrO3utsjV/FMANAKMxtrZiE81UMMTbygODOcU1t1ngAbTUi?=
 =?us-ascii?Q?I7sbiQOK9/n/GqgbTkQfm1VVC3lFMCAHWO2VA6su/OSLRVHT5WQit9glfiJj?=
 =?us-ascii?Q?OuTl+2LX7O76est71G0GrdOM9J9zKWL74Q/877beqNRRx+RalU0tjA03hVwS?=
 =?us-ascii?Q?kbMSx4+g8VJ5BJVru8NT9R07e5T9KsRXknJxsGhTnwegM7i5rFXnRgFs0YAB?=
 =?us-ascii?Q?utCvXvRrE6CyUlkdmuxcCk/7LZEC9r1uD7gOrU7Kt8OeuLXWOl8ybG7xVJJd?=
 =?us-ascii?Q?JpCsbta0hlAHOJIsJXlYOZLSPBzGWGUU+jA+fzAWyNg3rzTgMecHOJK6SwSX?=
 =?us-ascii?Q?z8GWCH+UblMsls/DPD7mZSikV2ISIKRwci3+2eJLqJzGwVfX4hxdvvTA5xdc?=
 =?us-ascii?Q?TwN2/DnocDlYlFOKV5DmiuaOoIZIcm5FwsTIihYnGxAXmI+Ph/or7OOUEkgb?=
 =?us-ascii?Q?+kSa/NXQKQ1OIH5m++BSrbQZeTJrDG8iSgVK9q3LWGyq0nW9P1P1by+lZVSh?=
 =?us-ascii?Q?cK+oNmLz/j2/35WscHQzxit0dWETdZexeaYtQ53awakQyNQd4MQS78XTJpTH?=
 =?us-ascii?Q?7dI/WrvbvZoYyTI8M2+PrVb1qpvc0l0/os0225WXr2s2h/5CCFDXy5nOEBWN?=
 =?us-ascii?Q?5KujM7Ii/nyRGTkZee3BmHT3J7IDws98oBHQDX2IBZe/nJhLVRoO38zjF3IR?=
 =?us-ascii?Q?tDlTj89O8CkMQPpbYwtteAdAFgmJ8xsRqw1Qa6I+wzeCZJnR4UwgDT4vby9n?=
 =?us-ascii?Q?4BQSSLOWMl70WyS9odXlH6hOzEZzz0YieylNGm8nsTZ70ZpRhm+mGwqHwHA0?=
 =?us-ascii?Q?K0RVk6+fwd6ng8RTNETdmGdTI9ynfahn9bX1OQHknA0DRpWlA8YyC6vyuIL5?=
 =?us-ascii?Q?6STtKoZy2wE/tcYC/08FU6SDUrduu/xCIhci+7NgygYUlU4JczNk/Pj3bUko?=
 =?us-ascii?Q?CEMwdld4WRoYFrykh/wdukeUsqt50FSz00YJ0l0rbgyXg1Ov6/F2inGIsA01?=
 =?us-ascii?Q?rbpk/l3y5uGz5azqy6aPn0J3Cn+m5oapiCfjxVtN+5OUw80wbDpkbAreH/pz?=
 =?us-ascii?Q?VXfw47SAjcmXyBCroVSn+XHUsRM1CEOB9kU6gpERn9huf82iBHCjinB6BCeX?=
 =?us-ascii?Q?jCnlan6V6/EenT0M0wQOmH2oydjX3L8aln5TQCE93PkA17Cgu8EQwEYf1P+I?=
 =?us-ascii?Q?E1fyanJAdVRJiHArq3IfD/c0QSGWVfFuYm2DX2R8ktQSV0uo6vIjp/79Fc99?=
 =?us-ascii?Q?FmcD/7xSrMq7gEccgKK/4HH44h1mTpIkRRdjKuh8fdM6OXL0Cst5PDq03YKq?=
 =?us-ascii?Q?DrBJRvYa5ta+kAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVcGFl6ep1i/LQN20rabqNN1CH0RZ+ps15lfNHYscTwTQAbdJf5zfBaJlyvb?=
 =?us-ascii?Q?G/gN4G/JOnJWG91HHg/OU+0PveKaN2D6oiGw5rf6JPlF7XFQQ9VPVTkcpxfT?=
 =?us-ascii?Q?lGAgc6uJm3ER0Xv7jJB4Pq3YOOVXKtyfoN3pPi8ZuFUdtcwAa9OrlFrsS7sa?=
 =?us-ascii?Q?t1tZ3z1mrAY0CBwvjSZaeZ5YivfGPM5oKRGGMRXT07THXVnCBLe40ko+qt2L?=
 =?us-ascii?Q?+Quov2mX+E5XajFfCfPdr//Ytj3iHVcFjMDQEjWcgWt5RajEWPXV2qDfSc/A?=
 =?us-ascii?Q?nTUb2E6/UmDaEM+VMzm5/gaGTiT9om2YdUBoxjPh7T/ZQAtcwcSJ3T7jCj6p?=
 =?us-ascii?Q?kn7Nwm7rZSKZNn5j8LcyxIpLWKvongv+VhoAW8M2MzO+wOVzvctaWyRfZ/2S?=
 =?us-ascii?Q?6glzuzcV8Rpf3iTfeOS9gNfvfq+MHKKYE3umYLgyMJvD0i/YaZ0gFZdYcJ2a?=
 =?us-ascii?Q?iv7TZYor50PJnWMyXgIbSZjgJ3k2Vt03LICw1y8PRhwTCw3kaAhqgCDiH87s?=
 =?us-ascii?Q?wW3Yg8Z4BE8Q9lxE9gHerhM2EHcktxdUedcutJAeyQvesZma0h2RP1otAdbn?=
 =?us-ascii?Q?HXmW8IipyhwsGnXcASWYh/sOAK3r6cJwFEfLO0MQZ+bzZnayKsgmZPw6wzm/?=
 =?us-ascii?Q?xkSOaocV6pyxl9oMUjfUJ1YluC14wCSPuXXLNFgklT0HFikcxcTbTU6IFW8s?=
 =?us-ascii?Q?z3PFJU0+iTkMM49asu+MHhpLHsY86JlJ+z/hBqM+WguQMaBME9zOkxrEDH4X?=
 =?us-ascii?Q?o2L95mfg04OtYT4nkC0ssHxHSwSUgiwV3nts+yvZ6ftx42A7Zw7YpPFvaNyM?=
 =?us-ascii?Q?4kHgEEn/5f+EDjjJyns3D4m7ekPg9/u6FPsWEHNqIDm6QbMizxqAAyxh78MV?=
 =?us-ascii?Q?GRucae3YBhdqAJSMXORzZdGXZO9iUPZXTtZxq7HHBrckE2EyFMwEb2Oyh2D+?=
 =?us-ascii?Q?vQWr0UV4tOt+H8oylQQLtpcxI14zbtS5aPBMvVql05zumzjegW7GhWDqQTdB?=
 =?us-ascii?Q?zykS7o7jKgBsW62dnYsklENKFGLtQdDKsGkEEu6JKOVgw07HB9uz1WBILoar?=
 =?us-ascii?Q?qDfnhPWWZceZ11prsDQ1Dnpj0cD1VN76vdYseVBNGLD7Knp8rKK6E166uKyc?=
 =?us-ascii?Q?hNH+XShi5OdFoqIm8DJ+a8XHAXXRrDhgyc4SFdNksGWp0jYkg6/p2B9gqdjg?=
 =?us-ascii?Q?o/BVi6yKoIN/2mSuCEHiW35nhYF2ZFdfQd3Vtz/sWN0zN8pDNyPAqg8S6ZrA?=
 =?us-ascii?Q?QlBFuZzL3UngHxyLZVJMIK623j/aP+Iz6lmrCCFsOCAzxwnsSV4AZxgXH+TH?=
 =?us-ascii?Q?op/p7JmGFq8+aVdXDcneEJ+p8INeEHpSOeaRTFZ5z7O4WJSfGjgN2amkg3Jq?=
 =?us-ascii?Q?xZ5WSGTHj1ZglCWU+CZgs0JSOMi0xEM8qF3mEucMEoRd3yv8WPK3eD7TRiHh?=
 =?us-ascii?Q?OJbcGc8zvsBNvjy2GqNpACLI2TwQmi+RoQZOm3qE1dHYu7XqS2sl7Op1QvY5?=
 =?us-ascii?Q?s47ysi4WixhKwVJYTLCPPv1X6iNfm1iw5DlCjasEdMtKUXvr7pztXqDQFfWz?=
 =?us-ascii?Q?0ETWMCN1RnSdF9FZ2+9Zu1PsAZxaQ8OQm+UKgQfM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56276147-5b84-414d-0cd7-08dd86ce8f28
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 03:33:08.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8hA9ZQRTkxr+nHpdMhXbfOFhQvlw5TwoiW2/QS4SMk6L1ztU3E42Go0Yku6zqv6j0LMG8BoWHJxTIdGiZcPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

On Mon, Apr 21, 2025 at 05:46:45 PM -0700, Brian Norris wrote:
> On Wed, Apr 16, 2025 at 11:54:25PM +0800, Jeff Chen wrote:
> > Updated the "mwifiex_cfg80211_sched_scan_start" function to assign
> > "bgscan_cfg->repeat_count" based on "scan_plans->iterations"
> > provided in the sched_scan settings instead of the default
> > "MWIFIEX_BGSCAN_REPEAT_COUNT". This change ensures that the repeat
> > count aligns with the iterations specified in the schedule scan
> > plans.
> > 
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index a099fdaafa45..be28c841c299 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -2833,7 +2833,7 @@ mwifiex_cfg80211_sched_scan_start(struct wiphy *wiphy,
> >  				request->scan_plans->interval :
> >  				MWIFIEX_BGSCAN_INTERVAL;
> >  
> > -	bgscan_cfg->repeat_count = MWIFIEX_BGSCAN_REPEAT_COUNT;
> 
> Drop the MWIFIEX_BGSCAN_REPEAT_COUNT definition from main.h, now that
> it's unused.

Thanks, I'll remove the MWIFIEX_BGSCAN_REPEAT_COUNT definition, as it's
no longer needed.

> 
> > +	bgscan_cfg->repeat_count = request->scan_plans->iterations;
> 
> Are you sure you want to take the provided value as-is? For one, the
> request field is 32 bits wide, and your FW interface is 16 bits, so we
> definitely to make some size checks at a minimum.

You're right about the size mismatch. I'll add proper size checks to
ensure that the value fits within the firmware interface constraints.
 
> It seems like we should be setting wiphy->max_sched_scan_plan_iterations
> somewhere...

I'll also set "wiphy->max_sched_scan_plan_iterations" accordingly.

 
> Additionaly, what about the described behavior for 0 in cfg80211.h?
> 
>  * @iterations: number of scan iterations in this scan plan. Zero means
>  *      infinite loop.
>  *      The last scan plan will always have this parameter set to zero,
>  *      all other scan plans will have a finite number of iterations.
> 
> Is that how FW treats a value of 0? Or is there some other sentinel
> value?

Yes, in the firmware, "0" also means infinite loop.

 
> And, why did we have "6" here previously? Is that an important default?
> Or was it just a guess, and it's really OK to just have 0 (infinite)
> default? This could be a user-noticeable change, but maybe that's OK.
> You should at least acknowledge how and why this will change things in
> real terms.

As for the previous default value, I couldn't find any specific discussion
on this in the relevant mailing lists,
https://lore.kernel.org/linux-wireless/1452677217-21439-2-git-send-email-akarwar@marvell.com/
Even in our downstream driver implementation, we don't set a default value;
instead, we rely on "scan_plans->iterations".
 
> All in all, it feels like you haven't given me much reasoning to say,
> "yes, this is correct and a good idea."
> 
> Brian
> 

Thanks for your valuable feedback.

Jeff

