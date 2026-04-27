Return-Path: <linux-wireless+bounces-35418-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOjcGjnY72koGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35418-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:42:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191F47AC38
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F804300D340
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630FF37F009;
	Mon, 27 Apr 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lBvbNaaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710B39891F;
	Mon, 27 Apr 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326134; cv=fail; b=ozHFEQiIqYscRjdOWd2wUvcVGrRfQjF5e6RBhDed90lpqBaxVzzUsVAJ88EZjUFbtDB2n9cCc12O3UgtyDprv8eUpYuL/LC6sdndvSraWWVqTFTT6DBHXfn9ZMWeTG+DUzDfoJzywFV1Dq7UiWoOXhHM6iWP+m8RDdrEPSy6RAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326134; c=relaxed/simple;
	bh=9lqe4s463F4muQgCa7LdzEAYWNBJnYP2672T1SP2vDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMawirl87ONIuBtqdoLoXtWFQRMgPLjKAAIFLf/zM3NCOy9OGsT4vIGmbqIFhCTAOPfLSy7CIk2NTX24JnAMvKC/PT2CgRKJp8UKiBE+dylsqXTmkLcdd+WlGPkZrbg2uknlwQaS2wTj/GBJVxG9mGgK1piJe+697wofGztyHA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lBvbNaaj; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkIqlZuRjjjfZoc8xdxkmlAJdrdOD+bOpgD/r3tjhRXae1VZWBQUAdR38XGAdyUWjbRpXR+271LXQ14kBBNM3pMaoURXmhxkyebXyGJiWKYa2uedqkysvcLaIFqduQxnhl9YaAou3AXmqk1LaEmvUtUIvrC/ytjq+E+z+/r9CbuTA4BZq01Pe8JDxPa7BWN/tH+Mwz9meGzg+lY4t2vGD0s2aZKL914T8BHheHky1+a8U5W+ANL2r2ed6LA9nvKpavqoeDLekJ/U1hnpOxB0LBuCvhASYXwMvxBz14nXFRh+cz/+SqUl8lwHTDoNdIm8CvlQi/me+Q4nPZd+AHqCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXsyt/jN1qIhzpJR9HUljNX26+MNijJ11fwLmG3bRTQ=;
 b=fuVCLw1R/Rvpl3Vqj4R2oR8cLTFrB5rssTNVwxt9PxurhIPml1W3vw6Jh2Ijv84qJk8iYaJV+FrLFu8ez8cz5bfcwx3vkdVwLJsH5wTnaPxMQxPZjWuhvHTDJkYIYvkphXoAcP3Ol1eKr2FKd84Ky7KVkIgX6iGiccoEwxqpZoovZoMY5BOSuauhU/a9l+xOkUJvzFy3d4BSVSxyus8q+MAUcQIyHTEF7KqvHjavqG/yhoQstuZTXKfz+T1mGiICiriUaML/qOco+AVhJeFl7PSJ7UDqDHhaB64Zxqa1OCX2+Q3aBMFLoy9dz7opdB/MDd/lG3+lvMXgdQIuRqV8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXsyt/jN1qIhzpJR9HUljNX26+MNijJ11fwLmG3bRTQ=;
 b=lBvbNaajzvmVZ/f6HF2nxbCr9oDG2mSbdhHN+cG9YPetjoQm32dJdSNTpxT7zkRFUCeTjckhxIlrHy1DOY5rN0qUflEjWdB40/nhGOTr6fGa4gNARZs8o966WSEcFHkBQRjGScF0jEQMipFtcznUHrDALHGZOWRnTK627Ps3j1/t9yNrMvVBuE9ky/moXVNmba9mAM6gcCVYY039VbxDAQV24QO72snNsuhamO7HRzdrZuliKpxOwODkmAvR2Mz2cyIDSlR27ZnCD/71EQ4tPU5YccPT/D/0g7ppcilqxK9grGhmA5xbyJKsvHeyWf8NrQ0Sh7aYZGi/Rq9qhmy+8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:55 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:55 +0000
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
Subject: [PATCH v2 5/9] iio: pressure: bmp280: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:22 -0400
Message-ID: <20260427214127.406067-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:408:f5::9) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcb4f55-c68b-4189-a15c-08dea4a5cd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fwVF02dLBFs91NF+4leIV3Vv8syH7LXHCDTI5msfXZSzV+sVcP0blCUfTxv0tYJnfVOQ5moLDZyps3UvcecpFt7XWRtOMn2UdXHApFgMmYytO4WWJ6nV2mhdHmwp6SlUIfYx+BNR3JbZRivBQmpfBFnRh4g9Rb1BKr3xRXS0N+LF6h2XLsmelDv7AH4thvfDMg2WCIs5L4HH//NrMNFSUawRhTB/U3nvlx2y8c4QO1LsrA9k9O2le8mzGK8arSiP43RoJS+GeXapNxBqgsDpGMu79K4HZMLgdqQR63JgDMCjYhGQ/clTMxkEFIjxbA5v68BMGIBnK+Gqou+xlx2FrGWEURZjAR4I/C/dR5y7ExrKz40l/7C4JvajKUBH8cXJGP7kADDV3pW3bV1HFhEI3NZeqkUD6PW5ELHqRmSEYcp/x6SH2fru5INvvDRqS0KMMWSmbRyAJu5Fdlr5kyCKKIq+574Fxth8TIwe24DQrx0ifJU7x8QioZ/EUDFBdHmcv7IunSKfEDN9ezXPahANJk9pSKiwOHcwBlqg/d6IoFyJUvM/FoG2mypQLZymkMepqh+9rHHgX0DMNxrrrvgK2J9qxq78VLtsEoKQLAwEIzK07ia7O6gYI63j86XVoQJ5MyIRrL76UtBqeISZ5OErGKIWAZk2CfWFHa5UBrg5QipIWmy1Eo2Bdvejv6q5D2Txt5nRk8YgxRgiXqeD/DfhWyoyCeKLSWnQ3GxmhIWgsGYXf7Cvng8tEvqjRhp6Q7KcwqYkKJ04XWZvdjOBo+5ndw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GP6V2BjYGikt3vQIZ2Y+cKFm/DWGw9++g2VDXIQhBNqHqmGzRnGaHstmBFJv?=
 =?us-ascii?Q?fyfn060dAp4E9HIz1Rfq47L99af2Wq3O/kVJv43HgMczE9r7c5fLgBWW2Z+D?=
 =?us-ascii?Q?VQH22S4NlqI//BGHdqVyNMxopgecqfYvENT3Tjxc4qtb1bav7VY/0lLeWs6T?=
 =?us-ascii?Q?ieWtUruL09+GbtlpHLL+EnlkgjrOAeKk4FruO0Lg8ObqBwrPIoqGJ080yFzv?=
 =?us-ascii?Q?waw/7D4rZd1WjE0wjOYTHl4GN7dEZKNIJZnpNH8+btBgzbuzJAjlWvv1HFfE?=
 =?us-ascii?Q?syreAELpAsRHZcOuV6hSvR4Gxk+ohc9IN6vgW9pDsq0AKqcHzScgOowSKPGq?=
 =?us-ascii?Q?DFV04G89t8+nQWgOv8YE7RgmzV7cUB6zXoo0ObKHxnNGUMKlAJP536AurP1E?=
 =?us-ascii?Q?AVumA04RXDGRdPEF5OldRNl4SVgZrCde01y087TFjoiSbiUmgnhLr9X6KCnF?=
 =?us-ascii?Q?aalYth8Af4iNQNy4Vi8CceJTav8DTvVPrZodyB3a6biLYI8QNLUFF2xDYECH?=
 =?us-ascii?Q?K8JABhe806gzh5Ntll9n251JAlg4MJcyA+hx397NmaA3576jrVD4k/bB7vsE?=
 =?us-ascii?Q?4V8sur9XksoHwonQrDwTJpNz13Aq338l6hBhnKu6lecYMs0vZiwWbO2hCvuU?=
 =?us-ascii?Q?xI5CrFxJk4SjmD0tPBKcpmM0EhoNN9dIlQsRFpyUMKgpm6b1FfUmgaeAKMkG?=
 =?us-ascii?Q?E2stWVci/0Lp0nU7P21AK7VzVajyO3t8o+5AEgRqYf3Nss7ol88g5Q0rdPED?=
 =?us-ascii?Q?g7r8t697nuVVMkNQLJKftsSqT4e8OFoSVYdNws2sx/R1/6a/qEuTdS4PeSol?=
 =?us-ascii?Q?r1JZjgjmWwRp6SqnM649ixAWmMlqwqfhZut7dmOGo7e6e0Yvw2gx3UYvxxh1?=
 =?us-ascii?Q?EgB7eFNmQr8PAq0hvNg3cUfsCi9Tw6nXYYBu2xnZKh+doNHUYVYQjj7jq0oE?=
 =?us-ascii?Q?qYKhmKfGLxa+iplLnoBHBcdlQAkjPKs7o0xUDZ1kSe8slASsdSKxhSFWIinG?=
 =?us-ascii?Q?+OXSQLKnjAkEGr+PQrLqV4akwgGFA96mfOzjE8IjPX0/IjBW8fTPiuKrf2hP?=
 =?us-ascii?Q?Tod22J5jfiqKHHuzEmAac46OqMJo/4noiRG7aJIIooRexKci9IFqaI1ZlYuf?=
 =?us-ascii?Q?SvjChdj4U6lD4TvvEJ6CkIHBcB/tWvRT1SE0NdDLW2nGvtFcWH+K9bFk/BEt?=
 =?us-ascii?Q?cYnav0dX8bKwALIZQ6SeefkAmugpLYesk+RMP6oW1Pr252IEjb4XlpK4Xsd+?=
 =?us-ascii?Q?vBJw3H5eAyiBLUz+lLXi6cGzJM9lTt0yTWPc+axXEzttPl1AOhOhYZQFAKvd?=
 =?us-ascii?Q?jHiT+D1BWhvJg1e0DNaVtobWUhGTS9TdvMH6SSUqPLU2aHO1Hnq/0cuHGdxG?=
 =?us-ascii?Q?DBwzuVSOEAhl8/VU9XWQ133jDlpTKrZJpSDWy/uqG25hOicb2iKDK/xWXIOL?=
 =?us-ascii?Q?t/nubVdpF8IbDmdP5tQZC1XuuXxdLRhRTrdaIKSgyQxiLRJ7/89jI4ljqJ5s?=
 =?us-ascii?Q?lkeQlSLbTFLu2Zon3R/0b+52R6pn8Kdw4Jn1q7uEQmX1zKRloQyimNOTqqLz?=
 =?us-ascii?Q?M07Q7twPykrQPtoDBganruwbU70nZmSVHKfHGZHhqSXJ14TnYMcBYypZXPMv?=
 =?us-ascii?Q?mTjvkdLvxkUyIM/0siHJxsZA7Oa1R4jsbzO8DChiAwxml8HBGaI+C7Y8ahn1?=
 =?us-ascii?Q?Rb5NUJP37uXMhDuRV88ZGWA8BTo+i/OBdfEi9kpNi7xZl1gwlMVSOjv6I+gM?=
 =?us-ascii?Q?xpLhA2p40LxNMoWWoCASPYHTvFwHtQEz9W5b4K43R+TCcPAZVkMz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcb4f55-c68b-4189-a15c-08dea4a5cd05
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:55.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeozLTFRHOi+Y7kEy+Ze9V9Vq9tWn+AVqqjaojMJ74AglrAxnWgurHkTS0BuMaJL7FiKICc5HBRGZ/laXt7wXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: 1191F47AC38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35418-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d983ce9c0b99..f722aea16e0e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -392,7 +392,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW, tmp_1);
 	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
 	tmp_3 = get_unaligned_le16(&data->bme280_humid_cal_buf[H5]);
-	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, tmp_3), 11);
+	calib->H5 = FIELD_GET_SIGNED(BME280_COMP_H5_MASK, tmp_3);
 	calib->H6 = data->bme280_humid_cal_buf[H6];
 
 	return 0;
-- 
2.51.0


