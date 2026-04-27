Return-Path: <linux-wireless+bounces-35413-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN/7OU3Y72koGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35413-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:42:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9047AC62
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0919B3080A77
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C838655C;
	Mon, 27 Apr 2026 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n7frwneL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915ED2F7478;
	Mon, 27 Apr 2026 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326100; cv=fail; b=J6hKd9jWDn03UywdTGLpEhmjjY4HU8HjEjJ6y/ZBq2aAGaWnPc5hq3gXm+T5YSq0p/xsx14eaGFD474Cy87FOtAAyGhkFmLLEzfVN00PGd/1ViWd5Se3xsHBxb5iAf1mF3y6ecvMh58yhOcuPem56JZv2ZoSlWx1Fg0UHBj1zh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326100; c=relaxed/simple;
	bh=CJ/w796/sId5bFX6fy91k8t8qwCwiSrNvgYIfTJMn2U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jv73alQOtpDxk1soMndgkAO1ul8sZxjKp06mzOARp4Cr+4iI5p8ouQNLf9OpVud5aE+Y5atAm54Ew/1nV7UdN04snk2K0ytCl6BaXLKdzVdNcZjN3+qSLAf4zw6Tx8tEpGgzGp+J7oFw3gh8nzQYeL5dFHQZ3RuBe37memYJ9Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n7frwneL; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVhVEN/HFekaAgxbjIRZlrY66V0u37QQ+9rSICwI3mphEb/Ad7rqFzhNJ0+mYeEU8ZBaXXOAqo0+deoDMBF3m8jA5yCh2+by3zE15uPPK11nVPo4K4DCNgCiNoyt3fNt7GyNi1VgnasO3y9FQsleR5V6fjsHvDs6DgPIkoMyoDUiFhy/LHjwReJUbqouU7znT1fCBdlt2C7wrkd40WzS9EXcv8DGzokzyqDvPlvHSWlZLUBY89YJlWiHlig3NeFAKGFJSXkvMcjGA3CosLyYHRzlrXXy09GnS01Jeg/11SX4jSVZo/mIaTusWViq+raCqdLWz1Ia+eHPZgWUPUHVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VI3prW45uS7UDhQzpJciRTUD/E5Q6YgdyWox644+tA=;
 b=iDfXh9oWJkjGbr7FP7VSR1OWAlvJNcOy2RL09nfYx89bxZNHAN65GL0X7b1+CdlDaah2u+L2uOuHDx29D6tIIdCrcZwE0CpVNqJAVWFO2fRHiG3G54iVY9wlGcm1sV1X/x20dDDapNSCTAvUUJ674HlI8hk3R/4VBwROJDafTBv6m4bzdLtTlqLzby6KgStjLQQ58ZOWOqxf+j8/wbeeYtW62eEy8pUz3W6Aehjj1rqUwyQLsH8k1h+GNCSJMVKspcaVX4sI07VepIQ9Ftmp66JLrSbwLDjz3WVFQCxk6imnzaAYWnlJurYqJEymcKnRnwxgHkaamEnRQa5C1vQ8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VI3prW45uS7UDhQzpJciRTUD/E5Q6YgdyWox644+tA=;
 b=n7frwneLOLCYuhcXPcXRLj8X5cCT/mUOY9x+FbAemmgnvyiPHx4IszsnHS1fxIlC6PGKqKw/Ji/ZSrsPqIwalA4PtHbYjChW/2Rz9hEo5NwDBAI6ZwrX37hpk7rcZFq1b1Z2ZI7+gxzsjJaIQC6m+ODGXr7ZbKMfItPwBjdw/+6WT9UL5K/FQAa39EKCN5ylpeqBUtBvIyMQL88nWF/glKuvEeUzw3BsSjT6rNU4HFpIjjxO2Lw/4BVLcS3z/B5zKhUlA/jEbn628do0xrzQ48MUokI+kcjkun91aW2Ri4EYKHPnXF0hzJCB2Pk10j5wgHJhgGsiYr7pWmKYgpHODw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:31 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:30 +0000
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
Subject: [PATCH v2 0/9] bitfield: add FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:17 -0400
Message-ID: <20260427214127.406067-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:408:143::23) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 788ccc81-2ce7-4434-34cd-08dea4a5be86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	w8hx4DZCHco2qx4/DOPjBLx5RwUHJOafn3wpYtw8LYC5UTN5SIUJZEG8gaJjJFaUBqfzuAmNS1Cs+GAgwwDW6enIwffsrPApnRVXx4mNUGmEM6VPfOLHOEFaIpdzFQC6wwNKCmpqhprJHQEusyzxoB/UTinF9U7igRGV9dMy8U1rK5nUz/4GPbaVUF8wh4aEww1HeiM8/mV14/O9MjAeg1j8tDpAZoXvE9UYsJAiZw1g51+uhM6nbRcmmPAmOrIrBZ/TQ9+w/t6wJjCbYIaVcHWlXeYy+34rZbjPh5nyzAKafLw5SlzUpnrnCYmAXg0C1ZkSuoHOkXV5HuXG6cVCziTCXVL6dwdpBqWUphKZiZjUNiU6Qvlu+XSu5K5i/6v6PFN1PMsc0sYpluujhmVTplfbyt5BhbbFxkN4zq3bK7S6Q8mhXoqkKDidyJMzIlqEaJf28zE4QkVfgeQWnFmoopPnakJHRsakqxpi4rrKcFt5Pcbg638ZIHtrKs3fT/htVtrNlHMNfjG/8XZ0NEfCGprivoIGb3pH4wqb+knHbvpmAoHW9IQQI/lo4LaXCzzJ9Qkpw011XqLhyX6pQZJqBXECySB/63XvdxmIW77Fo6PHPX1SWCR8GEUzggVMLOuf5vvWPJeeweZ+zfz0YagI179TaC6vSaDybVGv3NeYnZKU4F8hXKkVTM/0WRCV6vNZgWQ7sZcI+Ov7hCcFNc8GPMLtPuTiJ55er0shHDC/JgcUFd/o5SGWIfSPOkcy3nJHG02/KocGUye5GiIUxG293g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?moIcAq4YMbHuVN4v0/Gf0c5dbzNCPPvoJVhPJlsmS0dbcY7LOOIyvpG1DQyU?=
 =?us-ascii?Q?PRLQA9pPApZaFFTjfUl8lgsrc8igHDuMMcqHE20eGH+wgFFKpKfNqyTYLq63?=
 =?us-ascii?Q?jaM2kHRku+N9weKXX9GGZD9vW0V+aF6jzn9UGc6HFY/TTwctgCLN428WWK+R?=
 =?us-ascii?Q?itH7KUXCnS/Q0pRmkHjKSS+ypT5uYB2UXLuauXQpOvQWs+NrStbmqL33azky?=
 =?us-ascii?Q?8WvuDLsogXqpHwq0QXpb1yadCP7FyFsQBWM+d0kq7o58AfynRlhG/BJriUMy?=
 =?us-ascii?Q?7zBA4yTj1Cop+xWRMU6287cLxXvE0LYb/DhfVIdzyULntrTHuULOG8Mr5w2b?=
 =?us-ascii?Q?we8IjauFljMytJU2/uxWIZiE1HyKOYBtymsId7qIfEXw/1LQalIqM000VGpN?=
 =?us-ascii?Q?xgQZVMGL0b/qkLshLixLW9q5ljjnZOZGF6rn3+MEVzzYmFDu7crBk6YhuMyF?=
 =?us-ascii?Q?G62SF4ZePdk7k/0uCkboCKFe7VtPVKI5YxjvyzRZLb/Ys8aq2xgXAj6XT5Xa?=
 =?us-ascii?Q?n4ebc5G3ezc7piaIoHVSmdrhG7lndxAhR3pynZo301gZF8Lu0HF0bZLsmIEy?=
 =?us-ascii?Q?OfkIl6wouIDdjDxP2Tmzdt6Dl+64um2XCfnEI65nLbqlYOVfbSJlGq2cimKd?=
 =?us-ascii?Q?VNoKMT6y1FW6UvwyVsKgE4a52+jAfEoDUZX/5YTf0myEkoiE5Ycp9q51R04t?=
 =?us-ascii?Q?uXb1HwbOTOcC2DN9vB3q3aj/nw+X8VtJEsVesnBFUkHmQ2Dy2iuVDuHgmgu6?=
 =?us-ascii?Q?lUO4zJDReOf40kfF7TyQq+NExkdY6Dj/urevN2t28CPHrZqlrkNSiGJgkaWN?=
 =?us-ascii?Q?RSPk6RKpc8KX92Im0+YewVbcNFx04BbZF8BkeALNPdjnu+SgP35oi/y1Nu/d?=
 =?us-ascii?Q?TjUjJxeIsMgkNgj+eeoaaUsui8nbXrp1oz/15Qn4P6hozEWipqwEfC2ZBAW0?=
 =?us-ascii?Q?tVcmXGIFqvWYn2XS0dERbbEB1jmhndKE4rDKdZIGOdXFcXbS/LaJ9O5aP1Px?=
 =?us-ascii?Q?P+Rl7QQiW1dO5bIpV/X8ezYypzWGEBjN7Rcx69miyBvr/OUoq3wX3lKCTekp?=
 =?us-ascii?Q?+xA7OwcIQ7UPsP5+fNtOIWldA4gtnnjJhrRV8qP3qtlXGbzbNO43k076rsJ8?=
 =?us-ascii?Q?EeS663pOKmukLQ/flkFfzG53dJ9tY07KNtfFRpikXTOgGfq8rvN3liiJKoDh?=
 =?us-ascii?Q?vqvPiVjiWw8aXKbqXMarj4rYfry+WghiZTRTzN2fwUchtWDZoLLZoD+CEDFz?=
 =?us-ascii?Q?1b+o2bN0bCzXp2S8ZFpu1L7TKvluANc37H+MvgNipJfdXMGNSBAi+yQLs1P8?=
 =?us-ascii?Q?lGl1cTbRn7Ks13oHZFxGHe6YTs6V/t4usQu4YuW9ElBUiRGRO2rGkaDxi3/m?=
 =?us-ascii?Q?yE/OZMd1kItB/11eKPX91HP0aCQ53IUOez1e2MV01nTPoYdFHG2PoLl9NLmG?=
 =?us-ascii?Q?+54FUTgXh0jzbv9T6zpBgqq8xhpQVpI9VO10gprT3bXkOzLY+JDMyQGzqJbd?=
 =?us-ascii?Q?9iQyaW2WqGOWuPzymTN+zDbAm9fGK8pmPuC9m7X6pDEtu3ad7AzzdEdTS9KY?=
 =?us-ascii?Q?DnRGBBrFKx8OOVvy+ywesVdCaHTDEyfZ44JNDu38AkagtrzrpupYoWU4QfGw?=
 =?us-ascii?Q?V35kWuVaJ64NytO87vaY1VGGotisenK6dAtoVH5lePtTWJlx0+BLdpmeFHy6?=
 =?us-ascii?Q?Oa1jaAsqnKWydJnxIB9g22AgZNYe+LcLyNE6/TJZcNz96dmqBQHcvRgcmkLU?=
 =?us-ascii?Q?9IigapPGs3cdFmMdbIKVB5lnCbjffcaOFxNiB5TKCn4r5S7ElxjT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788ccc81-2ce7-4434-34cd-08dea4a5be86
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:30.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBx+sbaiozfGkjrGZALAeHrXVo9O5FVk9Db89K8tyeq36gjhLu84KgOLRxO3kkfvHRtBKlEPQhUclpGd9/BTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
X-Rspamd-Queue-Id: 5FD9047AC62
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
	TAGGED_FROM(0.00)[bounces-35413-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

Immutable branch:

https://github.com/norov/linux/pull/new/fgsv2

v1: https://lore.kernel.org/all/20260417173621.368914-1-ynorov@nvidia.com/
v2:
 - more examples of the new API and code generation (Andy, David);
 - fix #7 FIELD_GET() / FIELD_GET_SIGNED() typo (Ping-Ke);
 - re-indent the macro (Andy, Peter);

Yury Norov (9):
  bitfield: add FIELD_GET_SIGNED()
  x86/extable: switch to using FIELD_GET_SIGNED()
  iio: intel_dc_ti_adc: switch to using FIELD_GET_SIGNED()
  iio: magnetometer: yas530: switch to using FIELD_GET_SIGNED()
  iio: pressure: bmp280: switch to using FIELD_GET_SIGNED()
  iio: mcp9600: switch to using FIELD_GET_SIGNED()
  wifi: rtw89: switch to using FIELD_GET_SIGNED()
  rtc: rv3032: switch to using FIELD_GET_SIGNED()
  ptp: switch to using FIELD_GET_SIGNED()

 arch/x86/include/asm/extable_fixup_types.h       | 13 ++++---------
 arch/x86/mm/extable.c                            |  2 +-
 drivers/iio/adc/intel_dc_ti_adc.c                |  4 ++--
 drivers/iio/magnetometer/yamaha-yas530.c         | 12 ++++++------
 drivers/iio/pressure/bmp280-core.c               |  2 +-
 drivers/iio/temperature/mcp9600.c                |  2 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c    |  4 ++--
 .../net/wireless/realtek/rtw89/rtw8852b_common.c |  4 ++--
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c    |  4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c    |  4 ++--
 drivers/ptp/ptp_fc3.c                            |  4 ++--
 drivers/rtc/rtc-rv3032.c                         |  2 +-
 include/linux/bitfield.h                         | 16 ++++++++++++++++
 13 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.51.0


