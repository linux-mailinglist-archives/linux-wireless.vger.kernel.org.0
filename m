Return-Path: <linux-wireless+bounces-21633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE98A9192D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 12:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F297AF505
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875922A4E4;
	Thu, 17 Apr 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOet6Xr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567D19F13B;
	Thu, 17 Apr 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885270; cv=fail; b=kYfpCPBJL2eijJLzVKuN6mdEj3x/UecoGyQBLqJg1dfDl7+hxgO2WVK2Z6ERY9u7n5z7uNeEHnyLhQVluRETWc7oFnbwD3tuCgeu4vxOYc+cxWe0EXDtYC2M5z6SxADIVV6s/UHG2W/6yqEE4JWRSi8QrpmwzszL18aKKya84G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885270; c=relaxed/simple;
	bh=7KEAVl5t2mlVQGXeOa6eDGwVVWPdap0m8d21DrmUdaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FuQ+89lebSuVjeSXDOVeSClPEkaO8Slc1u0XXl83wHO4yHehIJvMHxhc9XQWQ37vRd9ZB0lY2wvSm0XzHFVA8wWng3QZGi3d/jAdYqCqt4dK9rB54aoTZhKoCmNSpkH315f6BBrrSPbgOZM9rfjnt7RTwadyZ+BSzT3DUPRjGxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOet6Xr0; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo8NqjfjrLQ2+Spq3XlzRxhKYdg6fUsRRb46pnwe3w3p0llTkxCRBWCS7ZCqcItGLKhcgUFr444tyTlwVkBY0WbqZtI6AQScVGnk+Hb5qTePXBDcqlma5a2xnSbyOD5GDNRdOr8mD7aw3T9JVjEgIq108lBIIoJ8nClxYzXauiVY0MIIPHnHvppNW8hII+F0/OzMjFL6uOR2YmWQ9AG1wQqIoaBwhl2dTq5FnlBoyt43/0hT3iYrJvpEkB0HVq1dUai97QMAe/Mv77H/NcsIQPtWo6aQlpSJ43mpO8viiObzEkEM7RVKczOVfUdHIto/Lb+If4MPD+LGa+ASmMFqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2xngkBXMZS2WMK2S/ertjFYhFM+rirnwNUjImnmIlk=;
 b=D8pPdubALiH4277yP7o7GvS3cGAB8Cf4OEJ4xZDgqC/3EeFpjv3paAyA8GMJyF08v8pcOU/mNP9FMdZXJDMWptHH2wle3SOV09drAkT/dj1dx5bXhC8EBodgaqo8DmF4IupWHp2MSxMiHvzjJkr4La4rvyud3HxEJ5bd5XBhkfI//Og5wwG3r1NUNwqjxLpafOffz5ZqUiv+fyJjqnZXNrR0oAhLdbpoQKGuls5qajSJKezmZviHi1TD2z4arqO/U/JWWBMmxXUJ5AA9d9FeSJFmauT5J/HxyZhcnplhSrRJwY7HkkBg2+2SFlnpDyhqYs6IWnUfR2o5CPcdEQJabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2xngkBXMZS2WMK2S/ertjFYhFM+rirnwNUjImnmIlk=;
 b=oOet6Xr0Ay5lphIjoerZf/e6H9e5svcHTtNmgbXK6ivd4XmvJ/L4Gb4TnVj3KQgCZIQTWXdwL38uCoYUPrGplizGJjOoXM8l4bWGlzZGnTRF4piN3X0G7ZdoboJLxlWZRge49zXnY2uqhLOzSyGrkBaOK/MB1gM+InB4L46JUjq7+y5uQOyUecBPH8mER89rayE5n5Y5H6g/WfHEqizpUIDvOwjSI29Yv/lFNI2X7jm6eAMY/S7/nZzf4JBMWcXpCKY2ivg9l4wbDajFbbLpWMigzPy7fKEa/uYZ9VYJFVLb2F7OKeBiVJuN/oJj6gHznRSUX5iU0B8Ok/UNq41m6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 17 Apr
 2025 10:21:05 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 10:21:05 +0000
Date: Thu, 17 Apr 2025 18:19:39 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH wireless-next v6 6/9] wifi: mwifiex: simplify
 mwifiex_setup_ht_caps()
Message-ID: <aADVuz/ctBmJNRU/@nxpwireless-Inspiron-14-Plus-7440>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
 <20250410-mwifiex-cleanup-1-v6-6-a6bbd4ac4d37@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-6-a6bbd4ac4d37@pengutronix.de>
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cd6179-1b5b-44fc-103e-08dd7d998fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ml7Z3inkVu+EATDfuCd9f4isrsetfnMFdkM3k2ghWn5RojHSAYDiwAnCSZEZ?=
 =?us-ascii?Q?+3zBSMGXf8NUZLNmVnHY3dTmyYot8BBCmmNe1Zx7USZdREWOCb+X6pTWvQSg?=
 =?us-ascii?Q?wyOX4D+P83mkrNQQUE4Vn0XQ9jRMQy6BcJKa67v3f4ymc+QIWET5aHJVqt83?=
 =?us-ascii?Q?vObbDwQvYpmE5ta2luzuqFnTsCRiQ1Z0KbNwfFXjxhD1V/afXPeqq57TbYMr?=
 =?us-ascii?Q?Mz0d6DcZ7zew35vXjr4BgzmIM87POAdP1Bb3Kb4HVdCRO1EJaZbHAHkqD2tp?=
 =?us-ascii?Q?gt/WBgBoD2oLOzqGsVxZ2coVMU/ERTnel7Pup2K4rUwjZCyrp5U2c7r+di4a?=
 =?us-ascii?Q?ZTozIcXZS7ztbgsP3uHbSSeeOfS0yZVGG/bUuas5r00FOEx7oGgrpZG8rmf5?=
 =?us-ascii?Q?Lq7qpFOZBhXEefi1h0aLmhKhc0W0TI4n7sYKCPKupBhGdbUZIuHfWfu9xXkg?=
 =?us-ascii?Q?fooZkjrT5bjnYRZkj/UEIW+sRqBqgmn3uDNUARiujfJkdyUVUzKrTNu+/SKc?=
 =?us-ascii?Q?eX+Iu2WSjJk3EfjyUCaelIR4e/ynrrf9Uv67k0lG914IVAykE2eGsY1plG/A?=
 =?us-ascii?Q?Tlon6uaX8+o7PPuEk1fVOG49/DBMTASEGajiupoOPRPeH8Iug84M7ym07aBF?=
 =?us-ascii?Q?4w0ntcqaqmnMjf1dPiAlfCg+wzYO/PY3qhVN4jKKeO5GTCdb+C49OAVDRhjZ?=
 =?us-ascii?Q?stt7igHCz/0AH3N/GWofCirPvQGQIGHVK4vKkMzxA6x0JFgWJ0Zr4SfmzPkZ?=
 =?us-ascii?Q?zDctRh7oDf8lE9DxwbwUZjawGKeb31vK+BPQxcwgrHct3IxxyL8hkB45tk8e?=
 =?us-ascii?Q?6SlUw5S5D4GOpAoxoM/lzpwiS0WTX0uPWloUtXOIaNQK1q/d9gCi1DnDsXP0?=
 =?us-ascii?Q?+jkachIEL0PXL3jpPrQFFeH7VTRI3qHvRme9rrkfzoWnvoAPNrFo8sBGKJ+X?=
 =?us-ascii?Q?zaqDBtRAlVsvAilD2eaCrIsaL88CX2jjPswbxgMenIaFlAktYgLOzkfl/FjN?=
 =?us-ascii?Q?EGLtmjnvQ6eibzW97yNh3fUSAgs/8vrQM1E7pMi5zliujQh/1Q6G9BQS2LOm?=
 =?us-ascii?Q?JcAmr5qt+fz6U93qXraTc5Co8EFdRbsFeJV/PMs4Rn/je6OL0CTXaqpryjbr?=
 =?us-ascii?Q?T+Td2hSh/IjzYKn0c7VEgiNqkC/wHQJWXRQEiiIF9593J0cbFIEzydlbFx/R?=
 =?us-ascii?Q?/UgNopAKZqOhVACEWAVipYWpcHFqhUNBcUXL+gagly/kYOtqvFcjC+GqeLcY?=
 =?us-ascii?Q?g6PMc1uZM3aQvRIGnwQDqXvFB93Vq9dJxXcx4Rj0qRDYG7koqnwKgdt/2imw?=
 =?us-ascii?Q?c+scw91+ch9S2lDXdmx9JVlacPfbvlmUlSxphQbIAbdGIzp1gG9qL1B6CDEz?=
 =?us-ascii?Q?cydR+BT6UME4YddItT8krI9GjiIv95/OZuPS/WV/BdL5qD1m/QC+Ugt3fYTg?=
 =?us-ascii?Q?11r1XCkeHcZNCmPbS+3wx8FZVstObm58/ipLPr4J4L3OZsaWGHHRkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xtO9nPl194pHcyt1JKEIk/6/As2hF/AR37bMYpS9UBWZeBu7bCY2W5PI6rj8?=
 =?us-ascii?Q?QRIbLL2UXNEZS7ZamdEI9hm3gMZ5r/WaHBTZA/Yg+ZEipeob1cOsjl0sm5pe?=
 =?us-ascii?Q?8o72x0BNx62LmARflNFEfRccgvzYlSH+1j8LAslmL/ppPWuOqzfMdr4G86v8?=
 =?us-ascii?Q?Z3WjvtcYUxoqe9AShRJKhYz4Xik61icv17yU+MbWPItLOIEA1OniLBGPJdDL?=
 =?us-ascii?Q?83/enTZb4QYtLkHkoktFL7kdswhP/VfAPjd0G3GQ8UjcyEghuaQ89AmKIl7n?=
 =?us-ascii?Q?Pw/u+U+t4UqhZPL+xrOG7ar5HKlOzFOPCzMcY9COZg4Ah2MCJaR0/zbnjKWk?=
 =?us-ascii?Q?0nmZSDY4CjLPs1xSmyBR/Wuxz3BmKU0yW5LcWc8Zh/OyosEUIAiaJ6GH35No?=
 =?us-ascii?Q?8HKbfonHJ+HwVDFdembTt97RwDAtoqc1qM4mMuIIEHH2XstoEFTyBACkxRSx?=
 =?us-ascii?Q?AVQUlK1odJcUs+bv5hvXOdIJ1aDCWlpfzKLdfUxeeVNZyQtQFW9aHSSFJnfx?=
 =?us-ascii?Q?bl7JC59tfx1zkCzwkQMkMIJZes8Y2lH4Hi5dGZS/ryDe0D5S7OMV3PDXfoxc?=
 =?us-ascii?Q?QFHHl4zSDX3W2fP2kMM5GYNoq32thE/DhBU4FR8b/PLVnLyLsOMHeuOEilGy?=
 =?us-ascii?Q?WL7NsNf5Nw9O6f0EdnUdo3beAT0DXEk7Zsuk0ZRWo2/zsYMPvL1Kl7300KKc?=
 =?us-ascii?Q?MZ76jpoON/BWlfoSZd6CB5JxApDVZtsJ9r3TFEtlu1nR4szHKzfAQKCSkKkY?=
 =?us-ascii?Q?nBkGnqCPotuLpRlZAxkxIvT38ygWge6hAx4BxRy+pNtGrn13Eg8uAtjF0zmM?=
 =?us-ascii?Q?lPbdZbKXck8HA5roBAT+7XsAW4tfXBtbXKWgK0cuLdyNssEIegh3MriQNvkx?=
 =?us-ascii?Q?mMYS48s4ZMTlVkdxnQtOsk8qQPBHO2/Ya6dQ9ZmmZp73x1J1BiXqeRPd8kjN?=
 =?us-ascii?Q?PSQNqE3PbJb7/IW9RKXYUslxsNd2ZoykHAdDR3xMpML9cK2jWlRJNCBiBKWk?=
 =?us-ascii?Q?7tCSyAf9+zcepnqdU94q2A22wN+8xobIqHGmFisOVrLmyLZyWh033kfTRWjp?=
 =?us-ascii?Q?/96UyvFsBr3uw3wBGPO8fbzJNO7BYI0VGuvJWQcpbhw+G53XKUrjoAS3gB3i?=
 =?us-ascii?Q?coGVLxbPQYLi4Cl8gchZ1Fq1f1/eW3FVyOEUFJNIs96V1GRomY3M55fG/LIB?=
 =?us-ascii?Q?N8TXqs/hAOuYzO+AdF2m6BgPAuJrUBGV008MVeNdDeX0Om9XQdpW1pkAjNgu?=
 =?us-ascii?Q?h+QXIGudxU3c2A2Js0tOuMein4i8g1y2dRFe2s+D1/1TYfg89whPqjuPyfkb?=
 =?us-ascii?Q?u5Dg0eL+XHb18uHLvaBOlOpgc6AakZ8QcKHDdqNSkI1UpoJF2OrGo2Yxw+y9?=
 =?us-ascii?Q?9w8D+Da23d72kVmFpgMkU+0uyNjk2+7QsIQXx1cereb4XWj09m8r6I8/CtKt?=
 =?us-ascii?Q?zYbj8i0g76mqWBoBOqYaIbDF/T1v/bZRS4Yroruo1inaMXBiLPzL3ITHh2Lu?=
 =?us-ascii?Q?hMeFnr1GZdkFbnrDR0VdNpONEtp3ESq8rJdAV+xsLwywzkAtW1bcriwx2VnO?=
 =?us-ascii?Q?9AN/MfJ1Zbhq1I0budZBWHAqygFlEIiFXyAusmPd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cd6179-1b5b-44fc-103e-08dd7d998fd0
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 10:21:05.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imus6EVJ/2X3mcOvDiOZbF5O2trjiGeNg3II2a5XmK12VhhnQjqCbvOraNTOLC9TzO+2f9jld7pd3P1q/zzCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690

On Thu, Apr 10, 2025 at 12:24:30 PM +0200, Sascha Hauer wrote:
> In mwifiex_setup_ht_caps() first a local struct ieee80211_mcs_info
> is initialized and afterwards copied over &ht_info->mcs. Simplify
> this by initializing &ht_info->mcs directly.
> 
> While at it call memset on the u8 rx_mask[] array instead of the struct
> which makes the intention clearer and we no longer have to assume the
> rx_mask array is the first member of struct ieee80211_mcs_info.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>

