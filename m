Return-Path: <linux-wireless+bounces-34943-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBgVHtdv4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34943-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:37:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC341D8D9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE0D5301E951
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810AB3B2FD9;
	Fri, 17 Apr 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lqDUkyKe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA0364950;
	Fri, 17 Apr 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447398; cv=fail; b=SyARuMKSE0qkdJSDJSwCh8ovJRSNZRbCkp1PfnOy1qrK9eIQUMswPgJgSWz698x2r7NZsywyDpKBB9UM8kK1VJ9WwIGRJ54qSBcBZORaW9v9ziL1Hpn+dFIUD2pFd6XOLRYGfXCe2D7lWc6D4XVQXhjAz1M94sgqkyEWIBZ1Dl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447398; c=relaxed/simple;
	bh=W5h+QFCzwkz+eNS0pEocuHnxGU6N1TpxmtOg8hD0P7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJ6xPv1GZ1c1k1CVa5MEfCK49O5flwih852eGLJIipstKKfrnrHfpz1GiAo8PEmw1zVWHjwHU6IaojPfJEBRwhWWTh4ETODnlpIyIV/nMCP24GMAxNHLTwOUKWHZ03Bfi0PXJehgB8ASVKjUFeiMtNAv7HaclQkal2rEIa8N6mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lqDUkyKe; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcRn8lMonLNiCcC/9L0RypDs2Oull5oSjodTsj7SJ8e7AfmdYhzQZiWsXp+UPwnjdFaJi+xueqHtssmL2q2zpxuc1EiReEQI7NCULPCOtfWX98LcLjc69WhKWBKgtCi802/yjca7AGCvu6LTaOgoJaMy0J9AhXtAay6VxQw/cMT07Zb8r2Swvp4+fpy4M7JyPkscaq4iZ+EfEJTJpafAjgj1UvK/TwS0cTKLmM+fZjAPGCS7pt1JXG9ZSjtxKbs1J9KGvohdrL5rzvmr6tUUGtfbWEdLKm1itSmFJm8QPmSRJamKkmDVM75ItEoH+Q+3RP8XsB2eIRcMoivpIcu2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctnTpI2RNaqGdOP2b+kZbogh55OglPF3v2wXKLiOyIw=;
 b=kwNohjExNS6vbaiI9UhUDEsFBxhXDUtERZeP5Yur30dAKDfvwdJ++wNP50DnEMtTB4VAebO/cEs9NCd/Ul65eGtdXzqqM4T0znHpejrPJiSpXLdNc23NgxImx+8bTzdhZ+b86uHjoH3v/+PUWbNR2hN+Pa963hl+HH3A2MlRWbSTmPXJ4+0n2uAE6KLHWyD/t9cOvKqkQ5VV9YeQu4TiFY+bUYV7YEeh7DpDv5LT7wT5DtxGrX7RGFWeKkXPg2n7NA6za1q9z6QqtmrCp03MYQA76WDzHtP5m8QdG1VgYT0ZjdCuSlrXaeAveC4XEFuUVRoGioY52/bTX367Yi/1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctnTpI2RNaqGdOP2b+kZbogh55OglPF3v2wXKLiOyIw=;
 b=lqDUkyKeIPYkbRGx8ItjIrAj4HDf4BxtycHsk8GY1cOpba2g9oSMKNClyPYkoX0DVIpwLm7T5CvdzHfyg2AAmeqiI+oZK1vC+dtcVRidVXW9WWhcq75f5kGJdq5f7wAlXPIKJzJ7k79RBO8GIeqg6cg5VrrUwMRFmo1GopnG+YWte9VHWpU0pXJn6LFFqyH9mPunLTeePLLGl6nLCDvpuZEcq3uqzwvcFDqMaEQn86QR4WPFb7SxN7PhDFdJCI5tXuvXqaNTNV9gUm/VZL0qYa6d711W4JARwPkDuimxki4Zmo9+LwQQ2cZ9BItOqXwIb02IExUJQ8xI5YHw8/V3Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 17:36:26 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:26 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Ben Collins <bcollins@watter.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:12 -0400
Message-ID: <20260417173621.368914-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:408:eb::10) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b93e52-c9d7-4dff-c7f0-08de9ca7da02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1qJWme11EzZDQevNfEcBBBNlX1IIACg2kd9EOgpX7Wa93EQbfUVr2QTG39QaEeyNa8Vx233ur+6wnIPBobv6XSI6U5lt7jLz3fRWJWIsWtIhGmW+rWOIwiN3u1YsX/+q+RlcEg6A9H8vy1/hNanJJPV4kL36sJ8b3KAGHsoapD8k4zmP3GexYQ0I2YdvYpjpiJGLE2M80uThGufOxOklPG9b01ApMYdMPGTcSBGt2rR5BeoFu06NS+hdRdyWS4KN5Jzaf26Y/r2WndkM/PILWOSeTqniBj1aJM3k41Auw/rUAPTn0welxdRwbWGIIkA701JXvJJ0WhCaOqqWFA/IebiLyjx7zvnHTTs+N9SY0jlicY0vRjALFyXfHnfIcVsC7wwE30XWMLlboCUa2HMuy0Ou7xWx2XJuD1RxJMGNwMSGs7phNmgwiZGXaUo1F0wU3662FL8Z14OS3WIz+y2ktcs2apyJs1WEnOuftY1GitNWrgY9ybdW0z9HfWLTq1/SBRljFnAe0tqJZvK2OE1peeS73CEH3CWKzT+eXRfLcgEYyTqFCETrl916dFOIaEzhYqtaN2z5y7P3nkJJzPPfqq1ZE39MD6R+mYNiLgD6adL4F72xK0i/bVdjGvy9CI7quD22eXC93YR2kFvFiJ87gziUOcAQMA4IF/1KVfOKpc0g2DT+/33o7pNwMwmBinO4jVKJk8rXMQ1DAwbAiVcnUmupKABX4eNgThlDvJjJZMPqZYr+d4rfWmcKBRTycWgKv/T8GOCTR8AjPxRZxdueiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xReSLPDXjXFRqNQvZXSxqAGZ2l9OVIGGpi41Zx9ASj1FdUeggJBDvTr2z6Mk?=
 =?us-ascii?Q?W6/ds9q7zl7lO0DKzBCxfJN11iQOEbn/om+aCyb8xWH+bn8pw3hxdZWBPlyy?=
 =?us-ascii?Q?7GQXuIjbbiyzf/g/2h+SWxqIPy5NMYgeG3v4D90E+hz/Mb0Mavj9rOKnVlTu?=
 =?us-ascii?Q?zw1qGn9Yr23diXi7KreBNvEGFxYhHhB5Bd9uCJWvpJIS5t2bMNlU9Ye/MJzi?=
 =?us-ascii?Q?l52hUs6mdwjfA720Mg8zKcVx+BOU8oRc3ZuCfihskgDdJ1GlYkwtbg84t+Eu?=
 =?us-ascii?Q?4aleuFmPX9pxg8cukxVixJUF8PHfEeEKFweYllnHEO8Xyb1QzKhDIguKw/5C?=
 =?us-ascii?Q?08LIGnzDecZUSp+HdpBESgkikgJgqMKgFmvJXDtY1KI6dACDMpR7rMuLL/mI?=
 =?us-ascii?Q?AW86x69rtI8OKMhtNAbLHma7lx4ELIlmcTv5pKZ+cScGHqn6gp/wQ/qoefCi?=
 =?us-ascii?Q?cr9lKevYbXa3ZjiUQOPQv3WDuTR5xPb6w/gIBiSBkadxKEdhfMuM+5NRvILj?=
 =?us-ascii?Q?KknYo9qRvPfflqdh+Etj3255TgjECXMzdeBMMOatgcHd/XHFozIjt74rCS9x?=
 =?us-ascii?Q?0g0/qiQLTtQ3Nmd+QBp9QhVbcYhLV8BbRFVgGhYoUri+AbEGUOC1YAa4zI/L?=
 =?us-ascii?Q?F0ylbxAiOUDyEB83aL40Jzc+YFO/ZBxM6s3Ln0Qh1D7YCxxmK7kDm7hV8u2D?=
 =?us-ascii?Q?eWbS0WUUUCNdhnM8lhuRsjLhizZLxBBb+J78IcWzJTxzOGnWLsJdWuS/j/UB?=
 =?us-ascii?Q?WbXwFIBqA/OVUcutCuv6ir/raBJh3rY7MQrB6J5IO/gcfuSUNIml38wLPyzi?=
 =?us-ascii?Q?gsE55DqWyhu03iTbpkzFzJZiwE2hobA9gad1BiqJRS/pxNKJNYqxBJ371ziW?=
 =?us-ascii?Q?SCY5eaOlSS5wh4WKE3vXcYWDZViv8ZZgHUG+CR23n6NESlYhL8RcTmShlWDD?=
 =?us-ascii?Q?gxiL4mL68u28DS8umMCwXWcJzYiIp1qgI/PQk1pwlyy5JwrW/jK0qwyPeamf?=
 =?us-ascii?Q?Ox0Ukj6Y4+r2DWpiNK3AQzD3XBcUCJGG7mH1QPyugd4XWwF5/1c/H1XUJV0C?=
 =?us-ascii?Q?8IAVlh9012+V4oCJSSLEBm8AoaCbc2Ob+BUy34+sUhdnz2gw3Njnr9YDtBqS?=
 =?us-ascii?Q?Prnd5xZPi2BVpdedaabLiYsiWnCFS/9X6C0I3bECy1esUCJ18XhMw+Qcei7u?=
 =?us-ascii?Q?6wYHum59VLY8mUp3r6SbgxpTTzkVdB5G696+6zYZdWdOqg+bOM3hGZ8RQ3E3?=
 =?us-ascii?Q?BqXHx/62j1Yj2/WAq+ZXq4E133V9u0nIpjAW6L+waBBXG6vbT4+gqrxb2s0i?=
 =?us-ascii?Q?2sWdy5klHN65eDVNFgO0x2TUYDj2uAcvbOKTTffV0Y+JQigHRZyODQHo5rjC?=
 =?us-ascii?Q?36d3pKzJW4iUrUJjbEe7c8ZWQkxfYaiOa1w0PlE4XGz78gKRDCv68WttKbyT?=
 =?us-ascii?Q?HgTIwJkuHOSKQf4IiYOSS6pOz8kjqqtiAbu7VZo2BIpncFmJ1YYOOiMQZCpU?=
 =?us-ascii?Q?84xGHUyQzb6OpwucwHJOal/6gcyoaXDl8ZCIfuf7UJ6JU1OyYDaTTRrx7ZyR?=
 =?us-ascii?Q?ZLgDKGGEX6IW+QpwIN/j2SNFmN+49jv9G4s8AMJQJpkhLXrYFW8K7novjmg8?=
 =?us-ascii?Q?3FRgdzZIvLnKHOMiB5c8hHr62MLZi2tqWCRvmdrWTNpb6W68yPztzLBqM7EU?=
 =?us-ascii?Q?DpJF0cLoCC4M63HBomwcLARF4jX2PbfxH7tEIWB0MZRJPNf/B7JoLKerMDL/?=
 =?us-ascii?Q?YuNWrIkmrX2YeJjdzw8r9usC+0CEHEiLQylrULJICHPXddkkQy1z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b93e52-c9d7-4dff-c7f0-08de9ca7da02
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:26.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1+iT6ksODVlWJSSwv2UJ8r/LIC1ctrCy44eDZQ8DrwfQdDJKcsOIaTMOcAWLeEP7lynyjB3bOrXPW4hjFA0CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34943-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 22AC341D8D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bitfields are designed in assumption that fields contain unsigned
integer values, thus extracting the values from the field implies
zero-extending.

Some drivers need to sign-extend their fields, and currently do it like:

	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);

It's error-prone because it relies on user to provide the correct
index of the most significant bit and proper 32 vs 64 function flavor.

Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
convenient and compiles (on x86_64) to just a couple instructions:
shl and sar.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitfield.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 54aeeef1f0ec..35ef63972810 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -178,6 +178,22 @@
 		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
 
+/**
+ * FIELD_GET_SIGNED() - extract a signed bitfield element
+ * @mask: shifted mask defining the field's length and position
+ * @reg:  value of entire bitfield
+ *
+ * Returns the sign-extended field specified by @_mask from the
+ * bitfield passed in as @_reg by masking and shifting it down.
+ */
+#define FIELD_GET_SIGNED(mask, reg)					\
+	({								\
+		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\
+		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
+		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
+						__builtin_ctzll(mask))));\
+	})
+
 /**
  * FIELD_MODIFY() - modify a bitfield element
  * @_mask: shifted mask defining the field's length and position
-- 
2.51.0


