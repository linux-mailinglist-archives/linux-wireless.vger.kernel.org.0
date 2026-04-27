Return-Path: <linux-wireless+bounces-35415-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HfbCTTY72koGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35415-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:42:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761247AC1A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1602930093A1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31483A16B9;
	Mon, 27 Apr 2026 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qESWIM2i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5384389118;
	Mon, 27 Apr 2026 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326115; cv=fail; b=ZRKOjBTMDEKXFy7NNm16pR5RsEoakpWkOkGOMJ9F0BiBhKgaNw2oyLzE++FLxVnrHKFBH1y1d7EL+pOoOozVYdrVWLnTLEo4DsUemEBLrLlqkHCt4qdOtR1Y3cRbn8KJLoZlTb8AnFsfe0YmKr8JLucSPqrgjATUT0AZuUVZCTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326115; c=relaxed/simple;
	bh=JgZUpkqORJEtYDfMecZvPdn5eWws1MP5JqxnU+z1rNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZRmkRmFFbv8T1u0BjX+lVa8oJc+SB3TYX7tlnmPGuEd3d2F2Ry7wWeA42EV8G62RA0rXVK0OE2eh9XB/FWPtG0Ll1RjJiQcRsfwAfU3BhTobbVdcQeiDNHxn5iaYg0CwSdb3Y41Dv+mE5Wl7RqddbkOCXL3POP3aLyFSTYtjnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qESWIM2i; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUe9CQyyz7hNX9m2/UoBVMnzstS47fy31TOJvEYGyG7t6HzLWnmTjixDOpZi6Db1bED1JUHsK+8nM7Or2xNkoJcIT6P2fMsNXNwFrJXh5S692uRBHn+BOMq6NV6cyaEmAYLKjI3mPO38sMLhscxjDwvFQ1srpIbKyPCq88z2abKG2p6WuzCN1v31OzHj1phvsVHCpuMO7QT1gXJqtnno8de9GmkI7ppjmAP4NNZbPoXWwWrr9C4+T7BZaGcQC3qPenxJwwWOedfwr26gmvoecwaZP7gerFg8LU04Ota5cBppW57UVAmQGa6y0o6M98ne9am6zNv4Ru/+sDCVPAE2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B7QScIRqTIpMKMAiKDKrhaAwGkL8Fxo+PAeS0sBbeA=;
 b=Nfz8h8BZcUwWNbIFggZHLY4gUWyH6p0pthoIcHLig2sIEb3tDTR3NUULOG8C7d7K7RnQb21fqz7maT6KIoBRU0lZSFb4bdlmVkgO7lTURzJhci5Qvw7h/zR/M3yUFc6y3Qt+LWr/yaaD9LRmte4nnompa8icGw1EGvwsFTCBKx/Drc32CKJvCOZuuNFEbxC0BfHQOtz6UewfaTLKkZHhhSj2DvcLe7H0GVVSsu0UQxm7SQrYoMgndxBZGQ/dDKShOgQh60sq1YR1AiAHRzJ8CsDahB6hDLGdV5QyK9RjWTRcsgWk99GAuSsOltZMKiZCAjreNPqy6SA1hyEzwuiS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B7QScIRqTIpMKMAiKDKrhaAwGkL8Fxo+PAeS0sBbeA=;
 b=qESWIM2iDxKtWj8kCS6BtHj4Tuu4IzdoNbE0So2Ay8/eTU2XhEngocELrYhjpTmrBp/b1A/zCwFQFOzBzKk99qFDaNBuujk39oLvUlTxzSo5rfQG2jXw9Xu/36WQNbXzWQRcwFaP/gqT4UR3pvTARnGOs3LmP9EH0clpKGRUdlFogeaK3x5Xsz/Z7XzFgi5qlCTp8oAr8U9hSZRibp+VVB5hdJ2S3fuOW/PymBmECuSM7XqLipi4ykGb1E26Ha84W3x9U0b6niehzH6R7jcP4T7HY6q0mBRo8O8RvamXFeqxG+yxr77fFWhnsDG57UJuCKJVuGYSJQ0bXc2lh1G7yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:48 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:48 +0000
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
Subject: [PATCH v2 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:19 -0400
Message-ID: <20260427214127.406067-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:408:f5::30) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3e0f26-b4ed-4e4f-1c70-08dea4a5c910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4kNZ/9jpAB1V5uFVHX7WgbVmNDQWfFlE0c1+j8RDyGbYc47l7CdrZjr6fraqZutKRjz3aYh5JqrEk6hkSFZq/GXvZMu1Pacns7ZL+qJSL7/CK0tWKrRkFro7a5DAVM3beC34CT8/vayTp9HP3Zdh5sqaP+mrDseyxh8VpPHxIL7TrR17N0yoNVgslgpAlFBEdth3L3Hl5n3bOuFW/JiLuuzMh34g5NV4Q/ThGBBrcGCZBVvn2v2claNF0WhFK4b3buJkMufdfHe4Xm2BBgontXvRWgz5iH/7ZnPl41kYMAQihMmqykXp8rQruH4+swHYcFABPl1KOaL4tOLPyfHNcE/czP9z83FS1sG63wSc2z+/hsqph7vGtpksC7LI0ky8KVAQAYB4mENiyoEJScx/ghwbW6dyN2yumOlA8R89cxyTj+mjF5OABPhTEQttfYQI6CSjLzlSofoW/9zQJxgyS1DkqnXYIJaCcd/WfVVI7Aun7EDYTivYok94hIkcUf7Y1QDZOu/dpraae6JoUtA7KcUQDbgSA8j184FYLE9HEAfqgkzculRjU1AjoPlVL9dx+f7btihbFhiBzz4rrxRFF4iA1/7LDFmrJLJaxDx9+qD8tTnkrhnTzhBzPg0T+UrCtNNojX8QA/j3OmgeWEWnBAQ8BGEi6rVquLcgX7OXO/FGlX3qEw5I7XRkv256NVeXkExD/aGHKaCuJ6+6K2934u7THMzGR6vRy1DWJitbnGst2Ea9vAIEtJVisL11i4V1+FzMZXhTFhDsarQH9hDlmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ap6tQTJwXZMX/+MofsBmCxRDGMeiT9mpDiOt4yPsG3yvboyhnS6YlcmTU7LT?=
 =?us-ascii?Q?QgJ9G2TKFe7psjoFfix4j3YQhU0HTfY/pyiLvpgjSHO7QhnvAz5WaeTWkgRh?=
 =?us-ascii?Q?7ek5+UxcfjEc0ge9kbaOEGdc5V7X330Z1BP+cMPRltBt66UGXeqv3hu0Ks81?=
 =?us-ascii?Q?csk+PbJVFAVnJfa19y4cTswBPmas97NLxxoJxPm4YKXXbcF1ONsBBctT/Tl1?=
 =?us-ascii?Q?7/RW/g/bQm8DXXR6LxV7+bdqa/lpAMJHdnIGa4a39oG7hdIgKb1/yyGs1lu1?=
 =?us-ascii?Q?9VbniQA2Fw9m4adGYf9I4ENLSyrHUjCWD8fvSe7JBKNR6wWTweuZ1ZrOsS5h?=
 =?us-ascii?Q?KadxZVcQEgysS6hKGKY7N9+pIGab4GqKkHo7Jv00GErkUcrA5aokpqbtxs2q?=
 =?us-ascii?Q?EaNcpE+ezguqccsuqDGLe5UnRWECaRsoiIylfwQmPPKLSvVaxcLXpki5aNJf?=
 =?us-ascii?Q?QpWqz9KKrLowykMfVJFGVfOp1bd7pik3UP0RoXzQQtuHJEDyQlUNkb2nnNvn?=
 =?us-ascii?Q?Kx+BmGmTrt4mugPC336GMmJbzYahALbw3fX/elVV4NCbjm0/AFLEydHzEPen?=
 =?us-ascii?Q?Gcm0M2FwPTw39rJb1GVJErQU8gURUpqZTvrOhcEm2Uvjd3ADpAGEGTnIjCg4?=
 =?us-ascii?Q?lKyGO2gAujSWmhNpt1txm5ytps3stX0JMgq9IWVXlCLt5ZmN4c0b4CGFsGnC?=
 =?us-ascii?Q?nGz+H/Fdj/QA4bHWMOvuof9YWk6MLaC3ZJ2Gq/wcyBY0GjSQe2bmviB1S7AO?=
 =?us-ascii?Q?JNCbRvttEh2bG7v9aYXdtdyOsGanCUJpIz1kuh8KnBzq0ESgU4T8hUxvQK4D?=
 =?us-ascii?Q?NcgvChazFACbDaRg0VHFsHM+5rU256/2pLnbKj5xLkpMjU7w/OJuebnYowEC?=
 =?us-ascii?Q?s3fxn5DWS4PueuAmdAUzBbzXcoNdvKV53sC5//QyLmEIha4YTjmlhGw1USm8?=
 =?us-ascii?Q?2PrzHJ28HWB6+bOW6tIEqPsQFD6EuHnp1htn9cQgPni8obGL2Jk0wwzHsyW9?=
 =?us-ascii?Q?fUkSdGpV/FNBRGI5QOR6fBDDP7DyUMqhlJSKlfKmA7m89urpkpR+bA0gd7RY?=
 =?us-ascii?Q?s5F976KU4YKm4JfFaBQtXnLYbl6B1//3cq6U/VVyGBSgPMvPlX5hJLe27tV9?=
 =?us-ascii?Q?26jkBx/iBanv1OD5/lM8PfdJ9ESFjy70oi0qNpwRvu1h0fMnLP2fUhDlbA5p?=
 =?us-ascii?Q?xDTxR+KijF2sCMCloCjskK8q9ikEmPrEjo7JOYxFUQ2iZQQ+eb7FFfDSnonJ?=
 =?us-ascii?Q?a7R9P9y/+hwkvvV15nrRYhIcvFb/btf4GW1pwGCJc0b6eca9YTUOTJSlwiY/?=
 =?us-ascii?Q?UUv3Fe7s1JKw0ddFkFK6yM4iTYyphCEi+KKxoBSjB5M752EXyitHgEj+dB72?=
 =?us-ascii?Q?v0zcjrVi2YfQNSUlpz14HI1S5h59qnHAE9p3UX2aHMWpqgsDUZmGa4AKxGuU?=
 =?us-ascii?Q?9CIvrmflxy7zgL8xelxkbIn0jPhVbIGm6lYxMCmCCs5IQu9AUra9xY27hE/d?=
 =?us-ascii?Q?USt0TysamSRATmnmgbgswFZr1i1W0WWOr4KBQzj4nJHzEx/D0clnlohEwV1n?=
 =?us-ascii?Q?5F9dzTNqYs7TBZs/ibvIlylYBiOgRY5FaXWwohePUCu1IloVU1gq2FAmMaeH?=
 =?us-ascii?Q?37LnQi9QxI9sy3WufWbRMjlC30+rppx/WjSQ4PdeRJ+zF4w5bx2PfCLRhc1h?=
 =?us-ascii?Q?OrJO+mbgag8dYIY3pG6r/kT9Husvn9c1lomNGsENUt9uHtC5gj6KyBpNFAbD?=
 =?us-ascii?Q?9uEH2xRXWf/SVbYKHoS6t64BPstmvD9Q3SJivHZ492Vz0fxgw3Hm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3e0f26-b4ed-4e4f-1c70-08dea4a5c910
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:48.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soxAmvf61Vjqzh2vvmEVGaCI6C1EOVPvv+sx1g1oJZDiz2GbdN94a4VLYvOqu0hc0XPWXL/KjQWpRoRaKzNisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: 2761247AC1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35415-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]

The EX_DATA register is laid out such that EX_DATA_IMM occupied MSB.
It's done to make sure that FIELD_GET() will sign-extend the IMM
field during extraction.

To enforce that, all EX_DATA masks are made signed integers. This
works, but relies on the particular implementation of FIELD_GET(),
i.e. masking then shifting, not vice versa; and the particular
placement of the fields in the register.

Switch to using the dedicated FIELD_GET_SIGNED(), and relax those
limitations.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/x86/include/asm/extable_fixup_types.h | 13 ++++---------
 arch/x86/mm/extable.c                      |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 906b0d5541e8..fd0cfb472103 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -2,15 +2,10 @@
 #ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
 #define _ASM_X86_EXTABLE_FIXUP_TYPES_H
 
-/*
- * Our IMM is signed, as such it must live at the top end of the word. Also,
- * since C99 hex constants are of ambiguous type, force cast the mask to 'int'
- * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
- */
-#define EX_DATA_TYPE_MASK		((int)0x000000FF)
-#define EX_DATA_REG_MASK		((int)0x00000F00)
-#define EX_DATA_FLAG_MASK		((int)0x0000F000)
-#define EX_DATA_IMM_MASK		((int)0xFFFF0000)
+#define EX_DATA_TYPE_MASK		(0x000000FF)
+#define EX_DATA_REG_MASK		(0x00000F00)
+#define EX_DATA_FLAG_MASK		(0x0000F000)
+#define EX_DATA_IMM_MASK		(0xFFFF0000)
 
 #define EX_DATA_REG_SHIFT		8
 #define EX_DATA_FLAG_SHIFT		12
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 6b9ff1c6cafa..ceb8d03191ab 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -322,7 +322,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 
 	type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
 	reg  = FIELD_GET(EX_DATA_REG_MASK,  e->data);
-	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
+	imm  = FIELD_GET_SIGNED(EX_DATA_IMM_MASK, e->data);
 
 	switch (type) {
 	case EX_TYPE_DEFAULT:
-- 
2.51.0


