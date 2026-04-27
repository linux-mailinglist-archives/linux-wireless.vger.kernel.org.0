Return-Path: <linux-wireless+bounces-35422-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HtuFIvZ72mvGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35422-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:47:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15EB47AE3A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E4E3137C36
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90093AB291;
	Mon, 27 Apr 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKej7/26"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907E3A75B7;
	Mon, 27 Apr 2026 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326144; cv=fail; b=b0crcHanRuGcTaS2rk1MrmY4edd57y+w8GcNqJ7VKOdy2MBzqXD4ckyuGzGOhXMiO5WbCyebufLadAOOM33ntzXLYn40vQ0vkS6L/aWv9roJY4DniwsI2hbphTMlB+ZV/6wYdDaICCmZCyNgQBZOJ9I50PP72UsJb5HZ4ptXfU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326144; c=relaxed/simple;
	bh=klhIQzv4remmWRP7GbUeuT79RcUz1K1FRUqDJZsk8LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/ZX4GQeJoUvEBRukHaFdhfWAsPzZuHBmEVMRzHTVhpIj/YJOAl8Sk86NOtYj6NKxOTVYNazKEtAClk/VSArB3w1qI3evGCahYMGxNyrKmd3UUdGAzClS2CiTgQc2Py+WW4TbTpOz2RxppckEdNCGoxULm51ouI5AzXZfMFke7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKej7/26; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AssupH0S+bKH4JtGZCtx0wpe/eLhKFbr7fCT+M5aE6Ysrl3VyXPxQIARtpRYda93ZMyc5/YeRlRJ1HUEvW0n9OpzM7Dod/o0KuvKtY+o00Uxod7+uHVygxhbGTO9GGfOSEmxw2h+kyNBzuDmoaitnHYdLDb/pJFubEtisAD+pCR6eSjpF4HCa94hrCIERJzMogPRknprQu7Ex5WdHjW5QBvNfF5Aw3en4RwHbaGkyyMA5/YoR7axpa56iCu2OpeValJVnN5pJASpXns/xWQHPTq5gQwuJhqsl8NS7Gf8kLLNL8GgfvuviY+ARspOcHE50h0oTzckavfQDrPH4RTZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhEMlCS+gk5qzaIUTW6mjfmr6VnP9Ohc19O2DtAx8YA=;
 b=TiK5WGWUhBVICEzETfY5xKJ9YbNO22+q5pM1ROSWlP/SbnxhCzeR1TKUGOOJivkRzE4QFzQNANDzfdSq3imeTQ1MQm6YyeECYzNHfFkMgxyoexa/J0aGehT+aZEmvkkljqLpR467pK+l+dNECvqWOLTkiccwALx9lgZ+rYRB1VS5E/9HkY5WDxWu9+xABqGBhOxcKIarkyv2RDY9u9srVXvtLLV9RoWXXmz3KR/EECHSA/9dnW2QR4EczIqgOzhbD7kuSRdc7L7+cRDB8JLCx/1HUOyW8f1eYI9ySCaU8gpc9MBNemsmI7zZjJlboyKzGNnUu4ppEcX4WLdrx8m0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhEMlCS+gk5qzaIUTW6mjfmr6VnP9Ohc19O2DtAx8YA=;
 b=bKej7/269vED6UQwMi+TlVF/E/abfRK0y67L9qVFv5gTF2WxCVGthg2x0fn2ZH4vX2mnvB+ex3SRoJ1TnaRUIREPo1Xymq5TOpaff7dB2ZDTcnrL2DTi8mg0WH23F1A8869jOUBpXGt0j0Gj6eEky5/uQB3ALUgpZO2LIQNhSDNID8bl6X2FZjG4JSt5r3fvtZmkCbarVod1waQtm5GgMIMXGh2ziFAwNGkYrEIVCztCYRWmohstQloocBdOwJzEzZfBS39j9Zhsa0c0Om8JhxXkmC3hXT5o4I+ApuqQV7NldKfZk3Y1BAEQdPLwvVV2zGc4akZA9x9T0RhtLLoqbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:42:06 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:42:05 +0000
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
Subject: [PATCH v2 9/9] ptp: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:26 -0400
Message-ID: <20260427214127.406067-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0548.namprd03.prod.outlook.com
 (2603:10b6:408:138::13) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: ced701be-80e4-4701-f10d-08dea4a5d34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UpcHuupd9rTpQWlQonfjFHvVSc8x2JV8fktSK8HuZgZqbZiUGQL79gOHmznAQtaWjkEfe3rCmu6I9+lfYIXIk05fjeXX8bjbt+93fV7PkzTmm6TCc+eSEVwYCywE0WJRULUTv1CeiHhzae6G7w9Y6TJmGikKX0FOPhGdtKEKgdNnUBuLZY7MvWBv1OiXQTdI+SIyWoCfEglXGwTMxZyNCO2fx6eB3K1yu0CGA3/uLnVQjBzvjvEP47C3qVVKp1apyVzyBC/gUh6ivuUfuQ4b/F5lspIKCJFulJEPK/T6KHRz52C7thapCF9zxC7FdyUHFFk3yJW4+qx4veknErYGLQQmpfm424MTSriMUO8n6rBPwW3Q/CyTSNd5zOEksNg6mcetVDTAItEO56nTVkDkGCPJuytvSOz1S3lNo6wwisz73tVON4AgsRaxAuowra938qnT0LFOSrjc95lvJt289vu7NNIzK2f9UKZbhRFqZk8eQnNT0ZOsie/cOl0+8mxiuRbpNUY4TKkfj+QcKv+hAuzZvYz6EUx2hU5iDd+uR+tx+mXmSNp7/PuOMMj0LZUHL6ks4RtR4q/LgOuMOoVkaIuL7XF5O29K2AwtNmunndaPNQy6v53owOn4oJIQl+lZNKXN1529L5Z9ruv5unFTUKoH9Y1xKJvR+TrGQqI5CX/3MbKn2F8agr6mbeg1vS0uWHeQFdHW4pl2NYUtMf1HyB11jTcPUPL42xH9XhlXXDnfErBUSZ2InkZSYEXaX8Yud2R8OU2UbK1CTkXbBHBEeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O/kokQ8FiCtYOoUSRmVrGAyld+whJ9lNuq1WuG5e0K+QLQYYIVwlRSAequ6z?=
 =?us-ascii?Q?o2j8FBF5OTHACMWAsSs3ZOZlGegK0aKdRF5/vPN53kNeWm2hpgEekLypr/HI?=
 =?us-ascii?Q?K0ypZJnpYy/LsUCYqJilnUV8lVj8V1LwdM3xGKScT//L9dWOCBH2QnSJ3InW?=
 =?us-ascii?Q?ODTMuo0jxRFW2r6h5WlU/3JMj1kx4rhwKJBKIyWW0DpV4JcBTwXeOQfINLKL?=
 =?us-ascii?Q?KBo/lK6+TiBLdzbgCiaH/7jlsPOtSYTvxwVEjna1s9dAuRTgiVDByKnVd1sA?=
 =?us-ascii?Q?nrGwp/JoFNQjzJB67+41r/VF7/Bwv0eaLPOvHko8ERjAjpUJTvWnKYU37r7y?=
 =?us-ascii?Q?ZKfbQCGlqkjTU9D8b8XbPcrp7kkPoqgGPWJIM2I7S12KbXWrZllBmQJqOQiK?=
 =?us-ascii?Q?g23ab/NHL19rm+ETuptuVAYFx7t7sf8bl7HvUXtXC7D1YBrGNHjJsJjkdl9m?=
 =?us-ascii?Q?SGW98Mun78/YLN+w5+D86tTwor4fd88FpyL5K/pTOSj016PsykIl8ujuwT79?=
 =?us-ascii?Q?pboAUwaGisuzydXOqGIVUQGF5oqK9yZ8nqeAcll5DqNKgNZOwdJOxQq3ZFy0?=
 =?us-ascii?Q?IEDvrh5NM1L8nEYH/6GSMehFoWiXAxxD+lKIZ69BGXhiFOdD/1x4bCoOIfC/?=
 =?us-ascii?Q?adWCTF8sbJ4rh8C7BoCMDCtAg3zQOF1dZynqsIcGJyi1n7DHdQe+et8Jz8mF?=
 =?us-ascii?Q?XrSn95fZunYUZPs3o5BDEDo4RKT8NkorMQJlPwLP/9CvW/jH9jo4sMTxrbtH?=
 =?us-ascii?Q?Bcxap3M1tzJ2R3EQMctxrkxdeMOPozA5QRk00F/e7oy67tUAJegsVBfq1rlI?=
 =?us-ascii?Q?+lNvG0P5jnXyWns6mXEuoVT2Hv/YTmoE6j/6VfnLeecYdU17psbvFiPYvNGf?=
 =?us-ascii?Q?5ZMyhGtC3gj4oXrnEDorW60bCENqhuoL1y+eOaqkb+G+yBqZ5E6rF+rDJsDe?=
 =?us-ascii?Q?Sk+18UQJlYqpJ8rUCv8Q8aIvAgLEBnN/COOwrLxfx/788bnRNIx4X6utEBgW?=
 =?us-ascii?Q?PgXR9DEuGhsQ3zYCe99j1IKCEItERHpAQakhPAX1e58X30TrP+WoWP5opM86?=
 =?us-ascii?Q?TzHmg0tY2E1eYxJNfR7uxrsdJpJZvrUqc9pJpHSyTcXBVdAf/mjkXVRyyohy?=
 =?us-ascii?Q?x3bBd7d3FhOIDVZIOGfI5ST7X8FlwSwLOA79LHQK+UyDl2VuR6oJEIAt4q/H?=
 =?us-ascii?Q?UKUdnMt++CMwWVdI1QROytDu0/rPAlw0819ShzFC4NxsXA+h6nI0wnRVUXEM?=
 =?us-ascii?Q?mcvyN67yGR932EowbR/i3OAAnmmspVkp7AKFMRKy8sOG1rMwNse9bMG8T3TE?=
 =?us-ascii?Q?tuFMsHoYmofc68Xnt6pl+l62ERs2cPrE3E5YFMAkSlkfn25PJW9pNEad9vuf?=
 =?us-ascii?Q?wqJ0yYND92Id6qPTQsDZRglXc93yS7Os7dZkVayhBzFCcFfpX+LxosaQ6RAi?=
 =?us-ascii?Q?kOoXRphLOIAhRwrG1TGK+sGJdLLKbpL45VCW5W7TnmngsHeH6Z49/iuCDGU9?=
 =?us-ascii?Q?MqGqasU7g1hZMd77KJyrSZvSxlhJh+1EjMdWRO8npmaqBdEFcPuJDU8Qz4EE?=
 =?us-ascii?Q?0tH/QrUbuXVtjJjswDlYsuxdU3raC+AwsGVzcAgSYkNMDLt++zzb/txqp3H9?=
 =?us-ascii?Q?tX1/jdGNVcXJc/mKUCDykvA8MIm8I5RBYQEEOCXyJ7GXFafZZRMxTt1ZDN/j?=
 =?us-ascii?Q?VmapkC5BtwmmFyMOAkwdRE30jES2AtpSs8U6+V/YaB5uozvL2DNfX1eD7saE?=
 =?us-ascii?Q?xAZLy8bVReuv5oDXeb6WZtMMjRqXgm6OdEcRjo/i7bbqtfchaeOu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced701be-80e4-4701-f10d-08dea4a5d34e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:42:05.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+kEhbL6Atkk8mN4bWyp0cFWJpzUnGJ5BtVEYInC4Bl65X5/SJ2LqSntEd2mzHG3dbOOi7elMzT1QS9sLrTKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: C15EB47AE3A
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
	TAGGED_FROM(0.00)[bounces-35422-lists,linux-wireless=lfdr.de];
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

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/ptp/ptp_fc3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
index 70002500170e..f0e000428a3f 100644
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -55,8 +55,8 @@ static s64 tdc_meas2offset(struct idtfc3 *idtfc3, u64 meas_read)
 {
 	s64 coarse, fine;
 
-	fine = sign_extend64(FIELD_GET(FINE_MEAS_MASK, meas_read), 12);
-	coarse = sign_extend64(FIELD_GET(COARSE_MEAS_MASK, meas_read), (39 - 13));
+	fine = FIELD_GET_SIGNED(FINE_MEAS_MASK, meas_read);
+	coarse = FIELD_GET_SIGNED(COARSE_MEAS_MASK, meas_read);
 
 	fine = div64_s64(fine * NSEC_PER_SEC, idtfc3->tdc_apll_freq * 62LL);
 	coarse = div64_s64(coarse * NSEC_PER_SEC, idtfc3->time_ref_freq);
-- 
2.51.0


