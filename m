Return-Path: <linux-wireless+bounces-34950-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP8uBA9x4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34950-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:42:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CD41DA29
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF24830D4D95
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96F3D0916;
	Fri, 17 Apr 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIkA8ZGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418733CCFC3;
	Fri, 17 Apr 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447437; cv=fail; b=EmorethpkWgwFe+ElNv80E+vvYqRJQA//uZbtNI7mPDUADJkX4hclyoHCdv4jF/IRuWnqz8FNRnnD3lg0CS5dkR3vD3DaIRjUiLtVGmCRaspydKAyobNRV9F1fk3hL1FyVi6Ym87YFvThyAfwDB/MCIzGQEApD+2nABf5PsbnyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447437; c=relaxed/simple;
	bh=3+RdxaChtlgx3enDvepKS2v43zsaM7kJetaA4Pxc/SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DymNE6sELLythv2E7nQvgWWVssAomf8M7Sy07Rzyc45mGU54tgJOkftqDSs9oIMToQuyv2mzBKJk6aPSDK1Ws7JAlzzgSGHtkjGnGcCZ7Cebf7h5AWUcMJr9kSPjBqylu8al+2sei8XTUYDAiWlKHZ9vPJwraKP7HBB42ddhBSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIkA8ZGF; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eem3LbuDf6BRjY2ipcJKt6EmkdATeUWj0Jm22gPvQXw8da4fyq4vzuGUXxAJ9tugNwgK8GXqWlnoaV222o4KbEo9dmszckV+ioSQjTIrhGxwsoWY6a5ZFR4Ap35ZuFEFZpMz03INngW+ulKG/dsoUWdIPLT0b+K8p0XOoqWwDdNC6aoCjfRlCo8tTD72sSU7DuTCs5JOPGKScIMSmsseLGT6tIBSxe1YdLzZGg5VQf6fbA8GfTYXpbMM0xktMuP1Ymfxd626coNImhB0OSYzN+fWr9lQDSutI/sa3jK6HFbOA+jWN9DVFj+ocJrBd4K8ABoAI5NypKypFj0sY3pERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxEiKWv1V1a4Y7+76ZS2LesUQISOVuKu8tCOpUR15tE=;
 b=qmAD6uZoow/BBM0IRQKLYwZI3YvzYkB+v5CIfCGLaG5xm7+EOSHUCvgbC5ZEHl4L6HWW9x48k7r/PMd2uTeOWlqTvViR8P/4ng0+/ZHuZi3CHfMbColwZMpSTw70KFN719Jn3jyNQ3rSOdx1kC8OUsTkAmPCmYal6WoqwMSp2DYeUsRiwxHD77ZDk98lX+tIDfZnmubNVDBi3PA7XvkwBgO/2oNt/B5m7pQrtmtjaaK05/LPvBlX0fDi4oPSTTguCFeaXkheb9n7lRMT+5FHX7KEu/0qsjzDt1ZEKncKdC2Mzp6W80bfyRFABpym3/Et5sIlpgPM9d5GDYDdzO14wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxEiKWv1V1a4Y7+76ZS2LesUQISOVuKu8tCOpUR15tE=;
 b=rIkA8ZGFtO7rbisJJvgbefdVbP1qvRFc8G9Ai2BIEkbEylrutzLzvFDD6GlpO3vTRDDrJvHkEuTKraInxF0RuK+TUXy76wdOAM7cxpUjVhP+Jc/Evst+DrdbwJ+FdayvV+GNicbq8xcBjgy58n+IcWSpIpT7L6/cWDl3yQJzc4ROPmXTPYQtqlak+dIROTiv8bxAnVTV0Up/oWjxPvX5UjjWYBwmajQKKrvHJ9BDB4xKHZpJqn//f362XiU9cS5N2d46fvXL5+16D8WqQIluJh0H0kE0Gzb2OUaPB0zfLV4eVlsEdAxN1J1IZiBvNXNzb3bh45iodQgK0R6C09H21g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 17:36:42 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:42 +0000
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
Subject: [PATCH 8/9] rtc: rv3032: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:19 -0400
Message-ID: <20260417173621.368914-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:408:eb::13) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 6276ac26-f037-401b-0664-08de9ca7e348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CNFqXHECLHfduBQbRHg8YCC5KbnknTgjuaQ1LJr8cqnR3sZ/wtLNNmyz5zJ5BWDsPP7O5P6wQokUgA5mHag7geXPIvP737XugnfLgryvrUxqKO0NsPpohYa/26QNLYFveD3uF55ThATPzcYMlZG2O0jFQbFZY6NrDsMDOIjRyooEV3nIXB/THwYqRUk/s4tyGscyt6mkJXf9msEgjHgHNJZrrbKTRfHMxTa27u0znER/zKlwWJFy3P1M5toxm//7BiKd00EI5irgcHdvJ3RUtyMrhXLlUBF3h2mM+r8ePmaHvHFpc4SFigaYRY9o54jwqLKDZoTiCEccDAMhaRY5J8cixetY5BGjrSpCTL0YZO4POGh+VaXH2kbRsUWMpCfon6IM/XwiSUNd2VTnoFM4bcEO/3NQ2E9x0VrXDukdUPBBE1FJ5sUpfyqZv3r3r10jlDraDReWwMWflkEllAoMf6oQnjf8aS4Q9ci7ie3MHrJZwRGFrojGrtfhv2bYT+huOE5xzm57QSObtPFjbu2i6LJHn7bBpa52G2ueOeFtbcsMDJvdY1+6kl7Rzq02PKBnl9QxcL5/5hDrIouIufRPUMMpjtmULtdxhES+r0mvEVQkz3VAXEdILd/r2IqWNKjoGf+vVim2Ta9leHb2e9rOFE58mQTBozJ6RCyQMBcs8ip2GjUmO0nxx2tgL2QoyFiOivZidQio9HizEJdRzIVk54dSJ0e4dQYvDfxW4M1nim3DuNELrhKFOFeSBeLHCAaPnxtMUQWy9jbg+9tpknBp6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UhIDds58dyrm38AJetnRHqq6liRvMCVGg3Atsdjb1LpKv+6nVOS8ujktfiO/?=
 =?us-ascii?Q?T49koLRaW6imGSLVmRI9YDhuLpXxGOSvQvibQiSRKBBpd+0AOwviqcNi5qpY?=
 =?us-ascii?Q?zx0g2bn6EsDA4oH60QotXBEZJWNhqnDpAHldyXrtXm+z2AnJPQerkpseXcnM?=
 =?us-ascii?Q?gOm2ko9rm7GtqGtWVtnLBsN2Gr6wLYYBwneZsyuW+cy+hFtmc8xFzQSlf7ng?=
 =?us-ascii?Q?9W2+SWxmNLZEm9b5B4QvVnkDGIOPqNl/G2fxV3D9XzDoB1g2EjzkuGDbZa1t?=
 =?us-ascii?Q?WU/D38KYWBRzpHipAPOsmpxbaSWsPOktjlH4VhHz/QpVl7/1ki7EsZMzJToc?=
 =?us-ascii?Q?fVQtWtolnyMykYKrp+/xV4iY6bFmCs4Sgv1qTnk1N2e0swu0CXdfiXdXPi4N?=
 =?us-ascii?Q?glKab9csQSJ+PEiEas2KYxddggFPGqT4v2lZowdC6GcYCDT0fEInlo3Vdu3+?=
 =?us-ascii?Q?+ov8pegtKst/2e9bV7x4QB3vIVm3IKeXJ0ErZ9xaf8gKJPIezOVDKVCyMm5R?=
 =?us-ascii?Q?fztcl/SnZsfIr9MEuOrSkg4ZYzBAcP4RdOZZskajA9Sv/H651v1rXx8P3uqj?=
 =?us-ascii?Q?jjZek/nHV75ssMeWChjVhi16V6t4lngOS8F/QXDxMv/Q4Ur4/eR8ZQr7Xg8E?=
 =?us-ascii?Q?jTbH3q5WFqWBavPuylMcCo2DUb0kttC12c/U6v6kgFmnkmI73UB29ch3lZ2m?=
 =?us-ascii?Q?ceXRTmGpW230QjX5i/G6x6TOZfZyr7RGKGXLT9soGz4OzUCZ1r/yTEgqzTXJ?=
 =?us-ascii?Q?EUDi/4YKt4s067UQx4wMiv/WGicigwBiP7SgAHFIniPvLb2+tLzJL1Jc7iM8?=
 =?us-ascii?Q?8KfFI1rnrXjfWzTEvr2wRqxHGSwxzaL5wITJK4A35imK6mRZruUz6GVdZ65i?=
 =?us-ascii?Q?s0rTLb0xSnKWjudvYFYnvU9eOMW8XP7K+BRAHZBMC0Rk4vqRf03MS3sLQpkO?=
 =?us-ascii?Q?IE4bu0Rd2KqbXo+PzZS+Nr2Wx0IfKIrz0or+6e6aOsDXKJ9NJqngvMem1Us1?=
 =?us-ascii?Q?RPAluHugLs2n9HFOYbrGaRbLS4LFOiZkb8snIU1KbgcRycyNi8YmimGHrrld?=
 =?us-ascii?Q?Li0dQoND3n08tPrMGHQUsPK/UxwaPLN+JL4ZAjRJDMII2SbK5qeyhRiL0O4u?=
 =?us-ascii?Q?IR7xf7d/4qTnsWalldlik3n3nB47yY/DktUcPwct6xMfBmJ2qb8QedO2x++7?=
 =?us-ascii?Q?cgjROGfHkBJA3K07muaAKwYfnIBLYxjk8pw6Z2xfX70YGzL/FBk7N5mDCO1K?=
 =?us-ascii?Q?hcxdXVkDcNYTOQZTu8cmzIDWf5j+XsNHYBjaY/eMggWdVRmytuYXJu5cUDHt?=
 =?us-ascii?Q?aXq5SSljDM0NqnXmOEVCWHqSbmxB4mquvV5q5hCWHgzDBvFoypC+JKSbto1S?=
 =?us-ascii?Q?B8pU4QTMFxvfNiTOVJI9Sp52T9irx7+hru/TdETx4B0eTSQL/SAS31UsPrBi?=
 =?us-ascii?Q?+sri+2fksfuNFTgasdcrtVi6YOHCPDn50ZZ0kuJ86F8eZMoWiZGejaxzpezJ?=
 =?us-ascii?Q?jP6j5NBSPPRqANQM+ZVUbG4s/6+edhPBb+07SaFZ8doMhLBwMtCtOBKf+TLL?=
 =?us-ascii?Q?RTtY90xcs8T0L5LKBi4bcURqWwSEexrYYB03UzPNIcXUyQ49/VTDKopDPjjw?=
 =?us-ascii?Q?FBA+H79ndevr3LDGjnGTrA6YUUZghgvfkNhsgakH93taNAgo4YRMPWlJ1mVn?=
 =?us-ascii?Q?FWeQYXMwWiXKvp4myc90FU+1nr7Zv/zeAZ6I3Bvnrbxc0v8pIQdtX44D+8xk?=
 =?us-ascii?Q?F6Y7L2ZuwwruHqgZ25FTE/s7fc/EJ3yklX/6LY4KcZoZwjkD4ibz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6276ac26-f037-401b-0664-08de9ca7e348
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:42.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbXY80E7iRM1TzvEVPlY4k0fz1GDuPQ1BhmOqL+PyS9+dDPm22OPmHurqFOmqjHa0wgf3d8eiYlr7gp1H+mbrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
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
	TAGGED_FROM(0.00)[bounces-34950-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 5C1CD41DA29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/rtc/rtc-rv3032.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index 6c09da7738e1..6bafdec637ae 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -376,7 +376,7 @@ static int rv3032_read_offset(struct device *dev, long *offset)
 	if (ret < 0)
 		return ret;
 
-	steps = sign_extend32(FIELD_GET(RV3032_OFFSET_MSK, value), 5);
+	steps = FIELD_GET_SIGNED(RV3032_OFFSET_MSK, value);
 
 	*offset = DIV_ROUND_CLOSEST(steps * OFFSET_STEP_PPT, 1000);
 
-- 
2.51.0


