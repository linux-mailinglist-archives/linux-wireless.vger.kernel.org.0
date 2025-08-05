Return-Path: <linux-wireless+bounces-26162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8EB1B95E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9483918A4909
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796721514F7;
	Tue,  5 Aug 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DCC5rwfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011041.outbound.protection.outlook.com [40.107.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8814849C;
	Tue,  5 Aug 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415082; cv=fail; b=sgDMGy+LQ9cc+WmPg5U0M+tBR7dCtM/re6p/NgBK6vdriRheC7nQoahafa1tA/uCXZ4vcrjBMBA8aAms061ukrO8RvMP8K0ajW3QLQYp1P5Tz9POXBhp4Bn6WJbCc1n1tF+uLYwTzY+zwj5r1CfKyk3AtrH0na+v2FY1cMATV4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415082; c=relaxed/simple;
	bh=g2cD34EPqh5wQlSnZU1MqOUUrZBb0HiFwx860RzEhGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWIGb4x/H9wuSY+HcRSpxUQw8QWzGeiHJJRxYerdCHqLd64qt4Zk3kDZ7Wl8EERDpTEbgz4/FGHz0PKCy2Bb6zUmdJCCQxI/82ycIGiUilc85l+qO5OX1mDfGDAd0ooGVOtsYy1sS9fhWL3pzqtut3RwPiKIh8VW8b2LrOcQhF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DCC5rwfm; arc=fail smtp.client-ip=40.107.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOL8gMSWXbHhX7Sz2TJH1oFntEG7OeWCYfTdNTebCOJpu47a5Nxq9xv72eRen2RvqScQuh1JYv6GHm/+yJCkQNl1IccQ/Lxm9ziD4LbuWXY6sxivhsrtZprZhpAAoLMTBhuMm9GwiEot2t3LsvGoyH671bnqHdk8njziWyiXXn+VNsiwTDlM/Vn05AebmnrLshgnLik1GyvFtRVKNkuc8OthEUtnY00RwMG22k0fx+aQjEyHH85ZWUZOnBEeLeX18mO4/jTMo6eGoqixjHdRgh9u4lAskve4EDceFpaGN6LJZgC/LOKgDgpq5HE5iVymDA4YaiKOK5j+zmh7X2p7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfg5MWpeC+W1OzKkRyyUPu6rHTulZLVWv0pSpKFwkKA=;
 b=Fl5budU4ahZ/w2PFFp27ED186I265aMdP7BZ+Qrlqq6bHBTzSYM1AxPHcjOImaUszi64quqd7FiSf8ND3Fr2VJx0Bvj10mBijee0c2CTrKkr5Uwh+NQFBTtbiI0L46TeHL8UWkfIAXcvS2Y4JJakSrt9OFpBdGdDiF5e3NmK9CcR7vWSXSqLIWIQ238MXyQYqBaG/suRmAL0ZYZg1Cpsjlk6ZiAoD+1fPU9Cy1AJGrYV/BzvaNE2AM9Ym38fyZ5RSvOsO5NnjL2h5gbvSXF/hhIf3sRe800762N6QlCadPZ455H7BUTHp6WFYLiWtsuZqWf5ghdQVOJyOZUMq76TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfg5MWpeC+W1OzKkRyyUPu6rHTulZLVWv0pSpKFwkKA=;
 b=DCC5rwfmv7T2T9SaVxfIxWA2s9keq+Y342VdWHr3Ax6v9OUSkV7AVWv6oPCdLS7noHPIy4K0OGQFJZiav6kJPUzKGQPFLcNcZkKuqtiAJW4Jg6nIwGElBuV3gEntlx5DwzoTEuKlwBOJ2KQ/B4KgqkWwDlchNuhTih23Oyz4HxKJzOLyaZcx7Xp8REcgKyUXOBIT0FK6dhNxTgpoIwk/zyMBwnOsk++P7GGkHMunoLXuZ2afR7RoJ4G4HAJOj6HWb4xDPb0Ex5ogyPakFHzStLjtCp7p/dPv88zpQwmb6jEyMg63ssT32/RsH6z5So3vA2OJ5tzNFHMcxRQcIUzrJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 17:31:17 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 17:31:16 +0000
Date: Wed, 6 Aug 2025 01:26:37 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Bing Zhao <bzhao@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, s.hauer@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: send world regulatory domain to driver
Message-ID: <aJI+zbuErHJtOBw0@nxpwireless-Inspiron-14-Plus-7440>
References: <20250804-fix-mwifiex-regulatory-domain-v1-1-e4715c770c4d@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-fix-mwifiex-regulatory-domain-v1-1-e4715c770c4d@pengutronix.de>
X-ClientProxiedBy: AM0PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::38) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|AS8PR04MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 030d2652-0202-4824-bed0-08ddd445e1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vabnhaeFF9OoMFu+AuQ1gdXPoJiDolClybqRyiQg4Iwjcjv8kKOyF7Oh5duv?=
 =?us-ascii?Q?YdYBTSMLopkFFsSFICjqIXNCbH617+240olqRRD5SRSHUJHCCxPdMi1aDi6Q?=
 =?us-ascii?Q?qcNcnVqLYTWQvWjYu39UIuadNTqRTAbwRbRDKRlKjDpGnXFHOoQEdgpzMVsR?=
 =?us-ascii?Q?HKvtIq1rrRsYRfZTKmaAPwyu/u+ubHcWTg3B/ZopH12Dp/nYx3Md1yGcu58k?=
 =?us-ascii?Q?AgEaFH/l/M9FgOM57FtE1jhtCFKnJgt2eXV399fEPiZ0/fyLpE3orOA6xqc7?=
 =?us-ascii?Q?8d15TyeH50fchoZp6tRwVpGRoDiovGkmv2VhozeoWMnopSTd7/qts4xH7p9x?=
 =?us-ascii?Q?x6vgsFyTwS1clibTC3mc5cpcJs6hoFjPERGMjYUkibPzzmfJHZJ62qvvPAci?=
 =?us-ascii?Q?VovEnqaQMhtbrg2mzPsFHTRL0GynFHiqkrOBI4G3maJ1FIdFO7k6pNuLoDjS?=
 =?us-ascii?Q?QCmUCUlMw5f78/BFqctw4M0ZyO8aDZcwYCJaNR8JXv+3GrAWedO1gerw1bZ8?=
 =?us-ascii?Q?htow4YFgv6csstG6qoV4OkzYfAy4BAuz38WebYfuGIm5QWP9n41yZZVl1gWp?=
 =?us-ascii?Q?j4KQAb/TZV16EE+BKyxdOdGmjJsiXgJbECfGsX79MG+EFaUaZgEKz0pTKQvf?=
 =?us-ascii?Q?Hf1WYPvBcttLIkKhcmUsIcPhGCgDnPllH/1DID/mA1PBx+d8K44Bp63ysHtY?=
 =?us-ascii?Q?CHuajEX1FkNKxJ89nE3x4V1OGwapyduHTXB4L7cq5fHAMXTin5C9BBAtprYN?=
 =?us-ascii?Q?ly8mchjE3UWmWtwDDMkumwSjgjynaTtKTYq4FuQoeK+aqzynr1qmhp1XtVJY?=
 =?us-ascii?Q?ZU4kZG3W+uqfjtuDWBhjzYm0n7zkzda3jf3EnxByE11x1FLymBDcJBLd4Xfo?=
 =?us-ascii?Q?itUmEpu5GY3eMSP5mpxdkSKElq+xMHden+nr9KFPgd9HoNaAtyQFTqjEguZx?=
 =?us-ascii?Q?bdN5RD7xZy0WhEySi8eNuIhNZszAsuFen5/3rEODwFKMzKxMDkJX+xLevG1R?=
 =?us-ascii?Q?8TGyDD8DsSS7U4AKgFzWFYo6WBLmq+L0AYXzRJDUEGmH/IMjcArro9q4EDQV?=
 =?us-ascii?Q?Guot701ybm+YmTyQyk7M5iaRJ+Qz79KSrZPDmcw0J+3pFXhRfXvc2EJUaf+2?=
 =?us-ascii?Q?RGN/ByLxOGIjyIcKJCWIZB/QB0+gRNZUH/24HrI0PncnhHqaCpjgkSK91IHC?=
 =?us-ascii?Q?XD7p6UJJqPYfmLE7lbikNe0jcsMDg3v6+sF5VL9tJfD90s0qR8/f1p7QLeRz?=
 =?us-ascii?Q?rvDOmLR6oO77Z/mBXo/+SMh/41UKc3mdzWk4Scl+lfzO1mB1ux5N9dYeK5Fx?=
 =?us-ascii?Q?JTyIncq5lC9baZvZrDAIZXP5Bi8KOYYJZvgtWISaXzDlUsrlUWu5Mjg9Yq6q?=
 =?us-ascii?Q?ZoexlxLYNNH6itgPj+7gJNpMeKyafIwrcmlLmxQGQ0IB1Za0llu+i/zkLUqR?=
 =?us-ascii?Q?1SgGgZ610vUsGk8kjQEv2FBOTp/UqQMjAZEsjrFqxodZVMsThUM7UQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzYZsavfR+E5XVwywubqAA378wf6r3c5MrLhJHGot/Ha4DS6eQrTPoSCt8Mr?=
 =?us-ascii?Q?UB/+TuNRRaiscazMjdOAYNiXq9styiLVMDUu+3d9+anWtZ5Zn5vR//KO2GLJ?=
 =?us-ascii?Q?9+BlHkfbhITHusT0iM3xyJOlAzpizaignRhgrLrCvEhox74BRYViGZlXa2h1?=
 =?us-ascii?Q?V4ej5v4KbKygaAy1cX6eP5b1pzuezjU7Hsbbb+AYp31285M8tvh1+kYWja3t?=
 =?us-ascii?Q?4Pz4pIL0M7HkNRASGYoz/106oybUdF4JVYaJqxnVMEY1rZHsfIh5n/ewt1eT?=
 =?us-ascii?Q?6omN9j58Uppk8n+5EU8TSGacz7tmroLno4ABZcerowkH9wO3zOLK/dOlmXcG?=
 =?us-ascii?Q?lbN/qgnc+7WiG009p4lVQAWfOkvnDHlYFdAaO/OtZtsGOVyN9dE1n2xVr+eW?=
 =?us-ascii?Q?aSsRv/vtgDmERvVBRq6uo+e1sVvldgOS/wW+vocvMCI3qOOqMQXY325g9ijL?=
 =?us-ascii?Q?pEHOSJAcbzkOCvIZI/zjVaInAVwlvDirOQ7Nlma69o/dI5XwZvbimywZq4TG?=
 =?us-ascii?Q?bSnj3PeH6DqBGbbwdTbBMRlEo4RWtFeAoEvkbMw5cirMH3+kWxh3Nr/ttPZf?=
 =?us-ascii?Q?/xiuYs/hBhNysrc6nWmzmbNeTwtklcAmrxBpy2k1VhehxARe30CNfKMzQESa?=
 =?us-ascii?Q?hQFHG5BrnwKuCFUFF0/e0gYW18unfuiSz6TsSDUjOAhQRgmFKeXpHQ8WZEGA?=
 =?us-ascii?Q?eWj6+t0t+I6r4f7PJKgg5PpCI6DxmA+mos8+VgrTQ+HOXK09OqKUggeAXTSf?=
 =?us-ascii?Q?B1Re5Ee1irLnKoy87eGVqRFoD89doFkBlo3u7erQ7apcfgiVRYVttVtxAyQs?=
 =?us-ascii?Q?cGZvqT1hWzZN2LUlUmKaG9/jZCNJCiPz9z6CevYsl+w8iUX5gNAIh4R5kyYZ?=
 =?us-ascii?Q?iESVSFvIhD7R+OaSIZpQnnUSaXTJ5Mb6rfMjVXLwkS+iJdIuptvMnBrDPDV7?=
 =?us-ascii?Q?vEYEGQAyjlLbiRQt46y3CWauAwW2akqMZm1zPxJKoWcfn+gug6CSHdghkhiP?=
 =?us-ascii?Q?O02HopEHavh7qpIxm3ofHd3/ojIjVq3JXvTDpMkHGYFycnS/Yzy6B7GwaZtP?=
 =?us-ascii?Q?avCn+4lyshb5FQLsnKgh5rnqLL8Rck86E7I89GlynCWSe7kgS548Yxqf9vFB?=
 =?us-ascii?Q?uJdQc6UTtie63xAHin1DCcMlsMPNd6kIIA62bLkSHJRaYhYL1j297mM6E7Av?=
 =?us-ascii?Q?ZQZFAUe5MGLDBAr8YqJbpvXg4Yq8TFrhK8VC0AhtpYlksWYZANECewp23Ngd?=
 =?us-ascii?Q?9XvVwJnMqvAoPcJ8Si1CZdrFaMh9FO9gVudPEdBOv+Lmr4A1YC4MHpXZxrSK?=
 =?us-ascii?Q?/cQofFxd6skAo9bBvaXSbKsOA3SXCsWkTZBBF0uGygPrD18MoFknhK6r+UYQ?=
 =?us-ascii?Q?mU/Vkzfv5wzAFz1AApXcRYLo4GSA9orBV2L4dDNobqyY1G9u+NhErxkOXZK2?=
 =?us-ascii?Q?dDt8/nw67zEC7OW7lNeD1bY6giteILyDXfEFgS+Dw64HgAWl4jp3PZO52doN?=
 =?us-ascii?Q?obf00s2Xt4iHy5/IB7tZQIgBRwNZ3nUT4wC9D784dGbljhiWFpsDKHy9tCfY?=
 =?us-ascii?Q?oMRLIqgCq+4LZemtuN9pnl36/3Ym+IKYBz40U8ak?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030d2652-0202-4824-bed0-08ddd445e1fc
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:31:16.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb3Qp9C08EJ2mGY2OxMGNW2VOkFq8O/UIV+btsmXCOtJOOuyE15nifvXbjuyMb/h9TPsvFOl0qNmn9wjKWQUsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8898

On Mon, Aug 04, 2025 at 04:16:59 PM +0200, Stefan Kerkmann wrote:
> The world regulatory domain is a restrictive subset of channel
> configurations which allows legal operation of the adapter all over the
> world. Changing to this domain should not be prevented.
> 
> Fixes: dd4a9ac05c8e1 ("mwifiex: send regulatory domain info to firmware only if alpha2 changed") changed
> Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.con>

Thanks for addressing this issue.

