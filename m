Return-Path: <linux-wireless+bounces-31117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E1vI7aWc2lgxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:41:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A577E40
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 868DF30747A6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C422F1FE3;
	Fri, 23 Jan 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iFbR40Lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9342D46D0;
	Fri, 23 Jan 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182774; cv=fail; b=L1tLMTgpF0T94f1xRZTzSqC+guwEIHM5b7GWMOKr6U5J3yYeS6MogGebeCQeOzN8npfm3/HTSS/BdbJA28s5QEHZnjV+mxb10W574FoRRTY9ecPtVn5BKnm9UFAMkB3h+rnFLwr++TpnDApaa2//mE508uW/DKNrecVXebZho00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182774; c=relaxed/simple;
	bh=1GYlST/oDNq16NA3tj+WVKEq6P01oieFAsYEzkf711E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e92tY5kc2uBkLU1DBFRFCAM3FMB4jS128c16gflj1U9EwGvCGg7FuGfH82Pp5o5DV39IiWAxeqXimU49iioN7LRNa9wQD8Fm7gPwm3uO3U2eXIMbA9etTNh4fQDaCvXU/BVjW+B5ZHOvPYRnifQQqP1j3JbaCfU9WheQSJdOsF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iFbR40Lt; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCK6WOCxulK4k9bVmzsxay6dB5G28LihM1OsZ+fycVsPTlrENIXu+vfgpQyAqMy1XVfBpOmxlIGtsPFQTP/1FVw7lpoGeP0xXRXjCEbGv8aGBEWQwz0kQvfeKZJZ9RBkzJX36M9SnjIS1WJji9SE3yx4i671d4WH4wPBfoDk2LPJ+AVf7Cq3BqWyzz6icPKkH3OaootCkx3jNYhEH8l0gQNJXhElhFYMKWBXyIi2HjB8KlJ0n2yi/mTcEkvuUkWJqSE2uSvmUvABbVl2jnQBc9YHjkQfE/y0NZp4+/RZJQmtFOUbSjq0kImqOGJBPbdZB0eqDPIcpy+UnQftn4YBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2/xid6hxCeuo6271eEuMo3hXhf68xVJSxB5eMQwAkc=;
 b=me3oPk39gb9eha0du5Jb1aiOt395fNtxEpHckLV3tCsG1wkh0OrLgiQ75ke/oYD5G9sBDb7XeNQ4IqgZToXb5YvuULiqMbOTJbcO1zXZzLoKhOr83GctNSk815XFMiSJU6ar0xqCSIuekoK2AYs+2jYS5ziokyp2GHdaMMhs4bCoHkaWqJMkQ/5mCdAOusMeJu6BD3M0ygpeDoCDdTpOKRjz3oG4W89LxROfFLUfSZoDySJ7aJfEHa4cKxSBrM5uTEdKybjB2xyQ2jEsZwgFrjhnUgTWBJ1U2U/hOpEmVddkd7j3z+fgKQniKOpQ5/c1IZDJqBAJHb/rHRwDjgL5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2/xid6hxCeuo6271eEuMo3hXhf68xVJSxB5eMQwAkc=;
 b=iFbR40Ltfb/ysKhqvynKr4ZHMZ1k33Ay723K3Z9AiwuIKbtTmRaGQWWGCGUwIv4ReFRDKSfsW/sGDxQqxkoLZLpvsadHXrrTGEeW13dcqA0NfPgf6wDjYQJNV7B3GZ2Virj/FRW0AvkQm2V1O8xaGWJXmJhYipBmWj/2vYiJVFFAIQpufLvc5+qq3tFYzmvVX6JOR9WSIk0+MQAHanI0MVDZfJhUjd6/CgiwyKQ7GRFcVvb4V8E6nYDUwRDCZvcFOQLp4Ie5dG8DdblLz+sF6s7jE83NwaNyigQnX4hMOU6KovHOsfC1ShO3DTU0aYGn+D4rPeBr0lSSZnN7QnTv9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by VI0PR04MB10161.eurprd04.prod.outlook.com (2603:10a6:800:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:39:28 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:39:27 +0000
Date: Fri, 23 Jan 2026 23:38:43 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: briannorris@chromium.org, francesco@dolcini.it,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] wireless: mwifiex: Fix memory leak in
 mwifiex_11n_aggregate_pkt()
Message-ID: <aXOWA8RW3Bz62jMa@nxpwireless-Inspiron-14-Plus-7440>
References: <20260119092625.1349934-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119092625.1349934-1-zilin@seu.edu.cn>
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|VI0PR04MB10161:EE_
X-MS-Office365-Filtering-Correlation-Id: 535fc970-dd7f-4af4-4e5d-08de5a959770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vuZmjhZ/BE0j82UYITMM2SSnGNvNQ4+xzVbKfQ3m9DTlOi7Cmu9izd+QoC0j?=
 =?us-ascii?Q?7+83+C5lT/uy9VyPtw27brjeZWBGN7pJSaWaDM5Xs1xmNvSz36CFguDvBFWH?=
 =?us-ascii?Q?tBaG31QTXCUGZWxLBz/rXO1W3BokG6JRyZucyF2LQm8uLoj6zZSoKzBRp+ba?=
 =?us-ascii?Q?SiqoGNXh1rwjyzv9ynv8ctP8ipWD0FPnYSpvSiPvohSibC/RMlcuQlMEBjPt?=
 =?us-ascii?Q?somrskzhQt9LLNTFclEmf5CJ5SLFUwlX4Ly09tJnzYMod9dZY1Ck1eEUrQFU?=
 =?us-ascii?Q?Vs3fuWMJo7UXM5shHy8qhTgA2feqQoWOLDIguVXqSMGE79IBhZIpEKRQAOfA?=
 =?us-ascii?Q?cnS/cdH62fQYC9/HvASlk5Y6a+olVlCiFikkL3nr4rUTy7UMhcEqr46kifDs?=
 =?us-ascii?Q?rTx4GsmFEyoKUzVi8JHKcrbiTWUFhQeLGheQYmySGo5mtqEr3oNuFGVPQOXn?=
 =?us-ascii?Q?RIQknlZr0BLQy7WeZTMY69xT/alb/xLnDkOEQnlSRbyhpki1pXp0fhKFPY+Y?=
 =?us-ascii?Q?sjYDfThjFvkA1PIeUcEYv2GxbTFfVy17PrBDbcqA7UyanFgArYajHKd48msU?=
 =?us-ascii?Q?Rd65NzBYTy/61V4Zpsy0NCDNGLAiYPnVaAExr7MaAKJ/hp0Au7+3OzQgCHST?=
 =?us-ascii?Q?jNcXSYMKwdMYgoD/zkBUonGEVqWoOA451UQJCOp3H373HLW70dYCO+Jc4w5q?=
 =?us-ascii?Q?yGLLS+T34wjmVdqoF1maYpQplNOOw1GrWwC3xs1H3VMDHZNZzGF/TMHJol3p?=
 =?us-ascii?Q?4KL7fyPwNI/OAt40eX3x2ziTsU1X86NZC4Gn7Z0nNxNQZGJpOxCvJkx8U0J5?=
 =?us-ascii?Q?5uq78La9V2PlTVBW9OpQ8iabjmJVSAa22qBdwGQUizqnbcJfKFXxYji02Yrb?=
 =?us-ascii?Q?A2ZEtP6hpF35eCNqFJZIpon23kI710WjeIX+9v7oVjaFhrSAWcTtxsyLeQTo?=
 =?us-ascii?Q?WOMGXMylk/MQRYlhs3BJnLnu4WSgHTbgCXHXSYXWLOex07WfUlgJGat22Loi?=
 =?us-ascii?Q?4A5oyiLu0eHThY5D+WdexDTxOJO766cGGiBSXvt2QVZgxBgnpDmcplUNjgJO?=
 =?us-ascii?Q?dgrMsuZrzXphDpKK6aa3+wfXqjscskPY+LYypnxu+9VItVIkTVz+/wrx5ske?=
 =?us-ascii?Q?srB8Rnu2KvMeuLq0/1n4VSOi82FjNZYp4E22YBUf34uDPH9ekhq6djJy7OFE?=
 =?us-ascii?Q?BWu5Df8nz6IivMO79+UuKfvbXMTmDpCCx1MbfFL3nc5ts30roHfR1BbO7bGa?=
 =?us-ascii?Q?mpiTytPAofCccLDZrcB9yTBK/MKN6/2kRZ3oQgBg6qul55vPEWewisIYSYgf?=
 =?us-ascii?Q?cEXz/Dqspgh/YZPKKMGxiIBukBFiIUcFxvL2JQijcjjXDwBUdyz1dOXq1PAZ?=
 =?us-ascii?Q?lkB3fsydqUZtgUZa0N6c7OZJqqp0uQHSrq9PuGvCGZv74z+NBsmFPQsxb/xD?=
 =?us-ascii?Q?z9RRy+97dOxZli/YlwvPTC/j1xejpvV5LqvTEW/nyL1hwggYWZ2lm9db5gfj?=
 =?us-ascii?Q?bL3xlooHmeLMlrNSvSYHIFUCh3x5pcDgpV22+hfl3Gov7gpZA4Z/DcFXpirU?=
 =?us-ascii?Q?0eHfSrxmLGYyFkPh00zpzQTgG3/iVleXPuKLR6hX1lGpf3WruiaNfQqf16zl?=
 =?us-ascii?Q?T0EPe84NeNhIVNFbIjR6ZS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5sUYeQuPZYaLkowI2vDa1o42p4/yoPmtE9iwKpj0ty5EOqtRiBUu77gV2gA?=
 =?us-ascii?Q?0v76ZyiGgdLABHS5ZqtzNI3GIL/OPhK84H09Szoei0pIuE7xAD04fuFMVa2w?=
 =?us-ascii?Q?J9IztwHUv1j3CwQPGgVIYx5IPhXJmEgXaPXpCjxWpR/mbtop3E6h/KiT4OuC?=
 =?us-ascii?Q?YKsyiBiI8DJxqASRdohVWi3IioF/X0gp3aOixdO/1guShMimH/nzwHDHOvBg?=
 =?us-ascii?Q?RyB0iqQFZ5KoeK3YDpKsFwSpH+9Vi8yo1R1UUgQNlxy5/sPNBCWU7AOlB+e+?=
 =?us-ascii?Q?WRn6tTa0tIsq9d5T9+u/gFn0IwPeevjSzaQvTZzNGrX7GHIXLlTbRCIk53qz?=
 =?us-ascii?Q?9Aj/BbZYmJ65yc6YQCnpNhWlP5ovC11ZLU+6CzWefCUSu77k1AasvNRFmQ58?=
 =?us-ascii?Q?bzroQkZ3p4Ib9SGyrqqtp+ZYdYOlfwIgmswD4NJpMGbb2tdG+V7i241S+WqX?=
 =?us-ascii?Q?9b1qUghWCUR2Xf9Ik+UQg6wlKF4bBOftUfZqwtJwFHa5EXkeV7Ik7nLE88m9?=
 =?us-ascii?Q?B+4d2tXyAyRH70fGB0dJh6nb5YMbXyZAidF6vbQiqhpgNxL87gRTWF9G/+sJ?=
 =?us-ascii?Q?IEX6m/c+OCoG93v9Ed1XZx2fHOst47WbcGpecEfMfGj4LdY1fkZFHvfBUFW1?=
 =?us-ascii?Q?CZ7S9LTp2bTIiDR11rXbuDHsoJ5tm1uTdiGi6Q8Lg3KpTNGnpUyV25bp6P6t?=
 =?us-ascii?Q?YVBHLpQpuAZkyrD9JgJrZ7Z5nOR4WIyFynXU74VBvRTlnUd0kYbCZxy0Bw+L?=
 =?us-ascii?Q?zcI/UVRP4vQJ+ICR1ccvBCVNRrDS73YK9LtHNPBx1WK3+N0QTcjYCODaGwhS?=
 =?us-ascii?Q?0QV/Gj2U9nTIYuiaItf0Sb6Ac4CwT3NSOPkFDSVYJ5DB3lbO/dfdT3KyYVTf?=
 =?us-ascii?Q?bl2zSTfwqozS/8IdaIJH+vZaMGqf8PaKG9yk5qcbZRM+rHeMfBHH+Pk0q5SZ?=
 =?us-ascii?Q?8Qw4Ya/5q1AslXMsDxmjSU8kwJjP9bvkdnHw7M6OcdqIhIa/P/YzsXICrA/T?=
 =?us-ascii?Q?MwuZxwbWsYddMZzb8bQ9Q58vL9TZts1OLEjGCh5f/zlprNb5BL6jazO+g7eS?=
 =?us-ascii?Q?LIbu6X1ZQbsvC75lpr8QdoIb6WAkmOfa2zl05kqLPLdLITknHNMtd9eoLUW0?=
 =?us-ascii?Q?NYi9GFeHMo0qFJ/BltlP7KTaJjij9YP6eLRvnQdTyBc0oaiUm/5kCOoxRhPV?=
 =?us-ascii?Q?x8XZik9oiVixnz8bSNp7mx+CrSF9BMDmm1yeL0g2ilomrmoz7b3b8wa9BVtw?=
 =?us-ascii?Q?TS+jATd6WcnOpUlHvTVSWzqqEycM4CVWU6PKgt3YoBYU1zCzWDDgyMjfro4q?=
 =?us-ascii?Q?euKBhTioGKrnn5JLnaqo8hodi0Xjkhgj9uX9s3p79dujJKxKPnrC7KvxODk7?=
 =?us-ascii?Q?8yVjFYOqYN8lmFOxj66pR3JqqP3168R4PMJrKTl1zuI0PCf48GOXIxgueVGC?=
 =?us-ascii?Q?ZZP/f9a+jVSVRe+HAedmIuBLNnh8HvW32TI/4izXSBda6ql7ukykP9Y0wcqY?=
 =?us-ascii?Q?VXHVPz5CuOr537KVxOqcIhq9L/JTxEhKltvLuqPQbiB4FeR5j2drYlIAL4J8?=
 =?us-ascii?Q?1iuBL6oGPNjOJhjLSSEwGHRmpCZxldJ89VJZ5rqxvtJznIQ2jvHb/f0ppACX?=
 =?us-ascii?Q?ttMQCatfBqVmbii43htjb/HrcBvoVhzkdszUwdbssCeq2nwJht1UiHcip5c5?=
 =?us-ascii?Q?y2HDWIH6UZnfQfJ++DVpANceYfFkWGBLNbrECDt5rEInUxKRv0MZULFMkl3B?=
 =?us-ascii?Q?io2FjgmFjg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535fc970-dd7f-4af4-4e5d-08de5a959770
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:39:27.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EmXLuJpbzg4OQrL2HbGRcRmMfKXd2ONOi9o+NRqduedGZ6CNGj8o9n29UyZKl+jaPvxuKo3IY23vawL0PRX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31117-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email]
X-Rspamd-Queue-Id: DA0A577E40
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 09:26:25 AM +0000, Zilin Guan wrote:
> In mwifiex_11n_aggregate_pkt(), skb_aggr is allocated via
> mwifiex_alloc_dma_align_buf(). If mwifiex_is_ralist_valid() returns false,
> the function currently returns -1 immediately without freeing the
> previously allocated skb_aggr, causing a memory leak.
> 
> Since skb_aggr has not yet been queued via skb_queue_tail(), no other
> references to this memory exist. Therefore, it has to be freed locally
> before returning the error.
> 
> Fix this by calling mwifiex_write_data_complete() to free skb_aggr before
> returning the error status.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/net/wireless/marvell/mwifiex/11n_aggr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
> index 34b4b34276d6..042b1fe5f0d6 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
> @@ -203,6 +203,7 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
>  
>  		if (!mwifiex_is_ralist_valid(priv, pra_list, ptrindex)) {
>  			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
> +			mwifiex_write_data_complete(adapter, skb_aggr, 1, -1);
>  			return -1;
>  		}
>  
> -- 
> 2.34.1
> 
> 

Hi Zilin,

Patch looks good to me.

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>

