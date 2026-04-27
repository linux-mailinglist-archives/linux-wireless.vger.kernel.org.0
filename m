Return-Path: <linux-wireless+bounces-35414-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLxYI33Y72koGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35414-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:43:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9C47ACA4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A8E530ABD5C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592838A717;
	Mon, 27 Apr 2026 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ey1tjxvj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BF37C939;
	Mon, 27 Apr 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326113; cv=fail; b=KeHsh3Qcc5B+3UvmwySorqtXfnwvihaUCVAT3tovM6fU2gTKGm6OHk1H773MrPdHLSbk2R9gyrTi7Xd+/+HqlDaKyq4SpWCKwCHPpXhUX2UByVxlPU0ho4FreE2GT5Gem2jlame9sY7f0cuu1NPDmEmzgRn0wPbAqQkhlmVbDhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326113; c=relaxed/simple;
	bh=djiLW62A+9+XHsg6ekXJjvdMvy7fp7CTHANd+skRqhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WrfasYnKoYGU3wI3iF7hbb26mQQvLOJn+LVEv8l4JTU+KNer61iB4KwD75oNbj6z0B9Y83ydmCpZrMTLuiumHzhv/O214LmxYffpwk3fZ9HogsaXr+z5Y868jd4RWQAwnsOQWhsVQp/dtd2seCCiGniv9u3oIPr1YNqyrU48chA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ey1tjxvj; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeJjnRGfETn4MvVW57obZD25CK1dZPGpAyFvDQFTqGe+r3/5RBoewBhlUqJ5cA0l4MAaquUITtJf/gY1smbXbo+HLlfnidC+H88j9irv+cCPTC+wK2U7f2TH9NUsgRo2wTZ3FPzVS5FCvsKNxSompuJjUqkiFYuWRiHGpNUOK1xIpH4a554UVoOmT37EIBsLrQ6TznN8EhlLXPFTDOuLF+lb3VR5WNgiR2QN8lLBLsArRpGsSAawqBXBZrzf/101Sg/EXthvdXSVi7EkIy4oHVfyETrZwOj8xSnNOK949FSh25MAg/lKyaZBd4W88klxODyrMhwtF5XSscv7djWO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF86IjnLk7u6qiOLwmi5ggjeNCS4nXYc5WQ5CMAQ2Jk=;
 b=luVd6ZCcTVJ9+wdQQQuFgZxUa4MAOWJc206GATMOBc76qE7rGuj7sMR9YFvtA6DHY3S7qwPgI8qWl8eHSVr/ZT5cDEvElw43OXe/W6bZRtOhGx0WDacGHkfee14ddYuo507HS1HSQG8WuO4Lfy9/uE6HG3ZLJgdxGMrS8udATkG9Y+ZUIQdJN0x1FMJIXODMyM00YPrK9x28XLGWsaCDMckaC2kTM9Vjg1cYEt7qUH8POfeDhMNO3nmgeNwduxJvOKyuB4kNuo4wDr/VG4lVYxmKMJWxsZAcqYb3aIXGULOFx0O3tk6BrxXEfdivemiBbON9s3p1cWULo7gmHsA3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF86IjnLk7u6qiOLwmi5ggjeNCS4nXYc5WQ5CMAQ2Jk=;
 b=ey1tjxvjHWQiS+vTWg0tf1e643NLldxgoDUZNxjP71/sC0tBrq5s/g6VxZft2qTaGD2LU2Wv3JSLunrSyCp/l1wqD/fPsnp/0EzTtInf0WQmdxBh9+9HgIj8eBV63jFDQ7LS+LlSMuH3GPx8xr/vOxEKMUzHaSoCYDN5QdptCWtkWkj7PLMYVhFzn7THAIfgrbhzPq2pCF8DTa3A6G/9ADNGNRaSzbbqpK4dzMzFmc85PAARvh79A0815KNhGFWvYmfFaXGRyBjwey0Fcs1SUfwSv3BFNWk+6c7Zpn1BUf0X3y5ur+Rh4Wbwjvw3XLQq2JZFlmHCWN4erStZrQthTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:46 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:45 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Laight <david.laight.linux@gmail.com>,
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
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 1/9] bitfield: add FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:18 -0400
Message-ID: <20260427214127.406067-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:408:fd::32) To DS7PR12MB8290.namprd12.prod.outlook.com
 (2603:10b6:8:d8::15)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dc1d92-cfdd-483a-2fd0-08dea4a5c736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	h77wBTyfXpAko00N2CmGlWRdJ9kLR8x1mHhEKT9aGsbGGG3EQX240nAGxcCKHJmyd43qBxBTZ/+9/prS/3X1B/0pSlIDizzJAxkjZnYEUKNXEuJGK3irPXCHekI3Mz3sTyinNFmJj5W7hfUjKeWiKdIVpoMQyKW/LJIBMMeFCqRt0vbRjKQnIopHq8VBejRRJ08azrhuKJbXkJrr7rrdsK0HZ3lA3AKOHUyNV9VLzU2YmGmWZJUsF53GtWHIgVWya8bMTiF4iHuh/0CkqT6fHUq8y9wNfxStH6ZJc6suU3seFWF0zQTbfSa09XFsTyAWKskaiB9abLR4Aqxa/x+uv8PZDuYoefRcBmqs3fEfCH7jKRSsAfNbj6xRiRe64N634JiNgQPwGGvy7nlUjZP5Bnex+i+tOM3fGBbCtsuv8lIayuBfJapfYrYPHxaH1bVqXObbGgdeyqvQmsnn/Xuy6Lijb9fUgOSEdn81Ajpn79QilwYu7d6Vfabj7kohTZZkHu035yl5nngQuxoihkDQulCz5zvy59wTQ5hGPeTGRC1EzdDLdAmn/BgX7bp6DbC7GCtEoOjAWvRqCjdXAnt6ZQTZNqfb4hcc42lxjhlMhx+Y6Jq9HX25Vgm9BAQJMOKq7wIOSABGyHp7EzXAWV9HmL1ag4Ge54B2IApVMz/BzgCw3gxcyfalNCbsCvDHTlDR9/XhJzxgar3n7o/XybRahB4yp2zdhTJXS6tINNzm9DwyL36fukagalCRv19j+dJswgFKV14BBG7E8Fugpi+8wQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVALzdwk70NZrxvyQWrvj45+MRNCVUc7DjMjFjnQtyKu6n4qIGQz32j/gIe7?=
 =?us-ascii?Q?woVt++3j8FRiUt98ivtAQOHA7wAiKTjl1rPSZi0rfn4cdqqBxI+/6jDeRGlD?=
 =?us-ascii?Q?UZ5Od7Hp9MCVJt4FCzRpzJnM5gFuq2I/guMMkOV9GguFHdJbhZNUPQMFrH+l?=
 =?us-ascii?Q?iNS9mGGsm2qTCJEgz0tjG/eq+/cjhp29c/819ULS7V7ikYUW4N5j4aMe68ho?=
 =?us-ascii?Q?4U5ALmebSwTvPvhtOglubRI2xXDEUHDdZHPkuy3IOSasRPS5KflQfAgq2/CK?=
 =?us-ascii?Q?Z4BUWfhCxCz0DMBaLCpooUgwv+BoNDIjaZxhgCr8UoSIGQe9zPF7A8DL5pj6?=
 =?us-ascii?Q?wj2zadgbsHDiPHjZrrKcKS3XuJNtZz6SrmXwYWfUL6QDSW4BlYTY0rOD2zB5?=
 =?us-ascii?Q?GFvP7HqJ9tHv3elIiVmfv4Nq92qWZf1UwCGt4NMf7M05h9NhaqePlf8a+e0h?=
 =?us-ascii?Q?TnlB864bICpSc7Qn0OalgmErrvAKQU14e7qo99V3kfEjWl+5nk8EZAMU7kzh?=
 =?us-ascii?Q?i5rJ/Sg6L59zDEfljhdo9NXJX+GLVW9jgufLQTu+/XCa/hGQD1T+y2ZeaFUZ?=
 =?us-ascii?Q?rMfn7mRUYVOl5t0FgWY+FRhwMP74MjJgngmKiEL5kyoU4HnJdsMuEgocR6Dj?=
 =?us-ascii?Q?GT3UoodmoHRmBSft+1CBmMI5oMsGnPqq5oj10dPZpmVlsVux/8lffFFh/sPa?=
 =?us-ascii?Q?4h8XFf4dEbEKs6d9x45vnRLk8EMxsO9LOfI15Udg3kjTg73wr5YSTWnCRyQa?=
 =?us-ascii?Q?F45IpacpJa6DDWM6qen+ygfccCiBIOJ06Kxe5HWogSumltTk22ZxtkzzCSPs?=
 =?us-ascii?Q?rsbaehzkeyneZ+d9juJY6mK6EB3zhagLoW62kbfgh+tY2MiHOA/nyrof2jO7?=
 =?us-ascii?Q?CxH/6KxdtwkwGWFbgmblPMvAGQnUnMQl8XWzdcH6jXTo1E1NYfr5JVP3Xn0L?=
 =?us-ascii?Q?Jy8b0DX+cYGOmp0YmCiTt+QwvDVUS69g40+lBtkc5wvdJN4XiKIRQ73OGula?=
 =?us-ascii?Q?sm3Xt/skMSx6jskG3s6/9W+gRQLP9Iz6xHU1uvpyCMhRZDttgJcCPurlYfdn?=
 =?us-ascii?Q?ZG+yT1MTwPgI2FbYDlyB3T4iGYQdINV4kylUXFkz9hqCJg11ouVBAhP4cjQi?=
 =?us-ascii?Q?nYxEi5C+fxBDZUbzBGoy6r9mp69Dkjo8HEkZXKZVt90w8YntAEtcvoBeVkST?=
 =?us-ascii?Q?5Zl0Awv6zkdXBeyASc4Pu9bFqaV7LUnpg22bhxVLzoI3VyyzmQtS1obkJQ4e?=
 =?us-ascii?Q?1sHiTFfVgUVKTQEhGmYdooHj/x6zDXru6W7Q42ETcb0+CtD9Xcy/Ys010Nh0?=
 =?us-ascii?Q?/V2fnRptOuHN2LLfhdoaFEnNo1eOB9Hsw6UyolZFp2/WtSYdNgoAh9ZY+kU8?=
 =?us-ascii?Q?V34GiQn5gGa9EcRTlnSGDuXVSPqtvJ1qak7Olp5OrUwu1LBzNjexyNDyttuc?=
 =?us-ascii?Q?wDrRznGFs/EWBc95XRMI6E0KY2kQRbYqMsdXTUeanX/+tcPYkw79Xj2RF+HW?=
 =?us-ascii?Q?2yonfL0CTerNeBNTu/jL7dWLbRBq0lxU5Sr4hsNhjGXnyUapjxNlZSXq/C9z?=
 =?us-ascii?Q?ZwatzTLzNGSKSEAIkPSBFoECpNDkt+oJo3lod5LaprMncJxaV1OEYv2SyYIb?=
 =?us-ascii?Q?a6AD7stCj8Fume9JfMHeFNtHbjOadw/4WatiuGwp4i8lRDmreW3O/gJdz1uf?=
 =?us-ascii?Q?3NEdf4CJL9S/T0wcHQbJ8bYk+6IMOvDdIQVqYdA13qhiCsCN9UObY/eSNISg?=
 =?us-ascii?Q?s7mX8+LfCyEL11ROUzLKVxv24yKM/jS6FuMbVVwjrbhsjzZ1m7Gu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dc1d92-cfdd-483a-2fd0-08dea4a5c736
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:45.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtginAblZ4qsYaPt8R0D+8pQWviedceo0YGFcI7ONgObNlmdsofNqYU5zj8QU+2MT11J89x8hZedpxwtrv8IDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: 39F9C47ACA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35414-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]

The bitfields are designed in assumption that fields contain unsigned
integer values, thus extracting the values from the field implies
zero-extending.

Some drivers need to sign-extend their fields, and currently do it like:

	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);

It's error-prone because it relies on user to provide the correct
index of the most significant bit and proper 32 vs 64 function flavor.

Thus, introduce a FIELD_GET_SIGNED(). With the new API, the above
snippet turns into the more convenient:

	dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
	dc_im += FIELD_GET_SIGNED(0xfff, tmp);

It compiles (on x86_64) into just a couple instructions: shl and sar.
When the mask includes MSB, the '<< __builtin_clzll(mask)' part becomes
a NOP, and the compiler only emits a single sar:

   long long foo(long long reg)
  {
    10:   f3 0f 1e fa             endbr64
          return FIELD_GET_SIGNED(GENMASK_ULL(63, 60), reg);
    14:   48 89 f8                mov    %rdi,%rax
    17:   48 c1 f8 3c             sar    $0x3c,%rax
  }

32-bit code generation is equally well. On arm32:

  long long foo(long long reg)
  {
         return FIELD_GET_SIGNED(0x00f00000ULL, reg);
  }

generates:

  foo(long long):
        lsls    r1, r0, #8
        asrs    r0, r1, #28
        asrs    r1, r1, #31
        bx      lr

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitfield.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 54aeeef1f0ec..cd44013281c7 100644
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
+		 ((__signed_scalar_typeof(mask))			\
+		  (((long long)(reg) << __builtin_clzll(mask)) >>	\
+		   (__builtin_clzll(mask) + __builtin_ctzll(mask))));	\
+	})
+
 /**
  * FIELD_MODIFY() - modify a bitfield element
  * @_mask: shifted mask defining the field's length and position
-- 
2.51.0


