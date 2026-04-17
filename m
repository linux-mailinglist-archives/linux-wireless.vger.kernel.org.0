Return-Path: <linux-wireless+bounces-34944-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKFlHvVv4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34944-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:37:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762441D904
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83515302D110
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AD3C3BE0;
	Fri, 17 Apr 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AGNn937F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573335CB6D;
	Fri, 17 Apr 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447404; cv=fail; b=fjHt2sRGtdEVfIvChF5ZnPZtFfyjZ8/IvKBZRGXgvCnP7BLfZ5yUy9EqB+YTywYUVnkpQvZZYeGCmNHrJv6Hv48Dz1btmvjEjyV5TJIlqkhMBDKdXmvTJfzjcBPpixExRyze7mfRT0vCUUGp/NrEHLCDezkx5p7RmC3P5O19xE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447404; c=relaxed/simple;
	bh=/VoQFCDSnHLLPkZZVwVUrRxw54wN/TYFMJLZXt92Sf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2K2QIvrlUX7ZNyo2XfdNw0uemsu3UiGK/Az4y+iS2PfcZl/NELxKUsDrMMzHM2zVpt7tpSjUNqHJKWZU2+Z6ZDiFB646l3e0uIdVtNxWEhNB0qIu1XaBzNLbmCZY7I5qlyccdRz9hsjqW7Rl/lsYWXHuBvBIgxYS31vA1MGZsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AGNn937F; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaF7IT944xdRLJu8iu/PvoxVh+ZRDA6RJ8So3H24toCGSrrTt/e32v56W4ezcamkfH8yMwVHbcYWDuMxltCys7rcNdVnDlR2WLN8fFMgLk62r6sx+0noM9icjMAdpQ7hpjF1PXCYKEOmbBrfOUOBzUMolm4ET1bhfBf7JrUNIC8W8fXCA4VjNe89EJWkJNn3wBZ33foVgkz0IVg+Uy9yOTkCian3wPlIjdUjBT50UJaZdipT7x2Wy+DfpjTZFC2kJtoRiGqacJLU3Anx7GPxt4+ZVERtgXgfLO7knSwo4goj/4XBtBJMQgbfY2Qx2it9EoCSroYkpt5RenvGHr4IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX2jkUAt9rHQ85ZED1KZkc4j2WmgNgcRxTLcGC7XQPQ=;
 b=K06NDGGNDeOhpDBTDXDnNtswbpQId4+Xzi/VST0naP5Ig139l16vZ30BLOjdo0Vg/jMg2T9EyIbpT6fHkx5SVd/71qLGeCVqrgYzu6dxg9P3CX6D64o1IsuAHniABehCptfm63C2meRbLjNZCui29PHyKnqILMNGMGoMQJhDEx2NhyC07NFZMGqaDGp3to6I78kY5XM7gD61VrUULD+a9xBBWwBaBhyA7T/TH9oNgoSjZ5PYWJgqcSfDPI1o+f6HWg5LrcowTARDDWAhcGUqLQDyuThxAyrZAZHiW95vMyl0vnUf0V/bWLXcrU7t9KiCKD9ckEtRK30psk1Qm1OZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX2jkUAt9rHQ85ZED1KZkc4j2WmgNgcRxTLcGC7XQPQ=;
 b=AGNn937FKL/OEsECIyg6ZSFWIWY92r+XmV0PO1mM0L569aDHLOikuTtsniQ2Ppw0borKfe6rgeGV7v62rpYiL3UyyL+I1zy3ClcteJXo7cGMMxVjw5ExM+Q33ACuuJt26iG01vSX8a9ULVQyg7+xjYWKw6XmdN7xcPV24h8irvNK8hPjwN4N20Hr7Zi7hR6lID8w2ieGJHkPOTD5fBU8sGkZuZ/DyJ/7KNWd/IKCsqVD1+SuogSOQx0C4v7LMBZJbbafaMw0XnLvyRmFIiTwS7WNmms4Z71TFVlb87NXj822wOVnC3nNniSf1oYp2VtYDB4aYXeHWjUGu2xeDxe5Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 17:36:28 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:28 +0000
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
Subject: [PATCH 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:13 -0400
Message-ID: <20260417173621.368914-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0627.namprd03.prod.outlook.com
 (2603:10b6:408:106::32) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ab7b3a-28b4-455e-cda7-08de9ca7db31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DdpRd0S5umUa3407c0xOBCStRTPdK4pFs1iNQ6obrZnGrL/ReoLwmc/gNhVhCoQDZN51Igs+4nYAwWmbKpzzYWNLq6jMM5TfB5FFF0V5yZuuC5lSZ/rx6snEwpAmFf4KbJ4w8VWqQs7vrn6Z55xK/gJliHH71k8kFVvHNnM5pf8R1cLfTgRGRw041TsZMvmF6K93Ig7uCpeFhTYVJcGhwG+r7HJg7xFhARjTal3qHzqdA/ETg+dc/FlB2EW12Q1GWi7CUFg7428yPHYfM2upjVqr9GbSFFNC34VdPx9PnKKTgsxzElhZII03UKd7YIPnlZ33kpCEEYBtRJRH6EAhTHe3FNZ8Opfp/jMJIUkql62IbCH+GWZfKY2xLBNnoppzp/Hw6kVZqL8uj4nPxPezcEFfdmKtdb7qq6V9Nz6fNSf7G/0FKK7zM2c40FzYe+0TWCQQC6xtP6WJvA1aR5CNiyW0vGXN0SrTgPQj+0T1lWE8edeFulUItzUbfl5rN+QK+81Lu6yJzdG/m94SMZwkQM2DgpiXolDqi74h8lrLvGihp87Lkp5XBFAO3nF1d+1vFoNNUU/ds3XUj0bokeTJ/IlGdHjy5XSvpVFl3MQkqukXUAOtBKHnNf62I4tToJjm832mLakHpW5xJBBQcYmbcNFwSGAWd8zVjM7wf6pdddohp/V+EylqAL3kY01wAVaE1M4zaiJ2SGW+ODJ0NbE9DCK+cagdSxaMcC9/KgRoJ4kDEseGA9EXbR6rLw+QJg63oa5GWJJHQI7m6YvmnOouKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eg1jGhzazsEambiRUa6XnAsLceOCD7Q9PCvh4+u1eFDjn+vR1CZkHN7iEWPl?=
 =?us-ascii?Q?cklwzFD1xFMR3bJ0l03MS9cNWKqwLdXzJkG04SNROgxCzBdajPZ0x1AtMCCc?=
 =?us-ascii?Q?KDLgEUK6hVe8OruoXh6I+DJosPXwUhWesHEBdeh7NTkz2DzFTU6t1u3FkmKp?=
 =?us-ascii?Q?vPy7pzaaitFen3pywy9u/rFCgaCj17BFkcNdTv7PQtUcOaT8KYq+9e8S7o4p?=
 =?us-ascii?Q?vdt107YgSfkYZhlWqpev3K1e7Dv4gKoImmLAeuULb2hM3bvbAUogCTLdGqx/?=
 =?us-ascii?Q?fwsqKnpB6faYUTCNCTh3VHZ2PKSUekioDhocGPTJrPhoz69Xk468aimykx7I?=
 =?us-ascii?Q?cBGeMK9/CyJByrKG/FOu+0mlh0gTLMKTYDMe/bIclewizp4s2eGXql4FsDiG?=
 =?us-ascii?Q?NDeTlN3WLij+e56K8lVbfyfxHkSrnyzZWRe4KHYEbxiuGCLHPqF2pUepH3q5?=
 =?us-ascii?Q?5a16CHW8eQjnym6OicoNw/ZOy0fX4wqyGX3OJwXDdj2FSi8bBilqThTKzObC?=
 =?us-ascii?Q?3hOOovMtieJw0K2Fb18Jy7y5g5hmKYWRJv+joAwZh2suNzy59a1Ax+Lyb//8?=
 =?us-ascii?Q?DqUIFYt0YhdgGarSy0AY2X7bOSiQY5GAODBwRvdnQyh3I/p4KAAeATpS268J?=
 =?us-ascii?Q?SdcKTmJp6+iy3iwKX851b/GchaBSi3Z7Fp2JqFFXuYT5ALwuXIgJ7K9QXsfY?=
 =?us-ascii?Q?FVrYJmlQtuRkM34n3mBGL5cYT3kVPCxcJsw1ZpLELs+5aZcVJuXGviYx5ZMl?=
 =?us-ascii?Q?rjelw87CX24buSr1N0++RzfuCUThIsQ3K8RPRq1oPeLNnMPH+31fKOC6iFgA?=
 =?us-ascii?Q?i8HVC8IIpIlF7eu3QUXTf3ruu/osaVC3+OujuHRzINv7FbAzHkstzZZJTZwv?=
 =?us-ascii?Q?W1maeI8Js5uUZg0OCRwHR0+/KefN7HkOSzh0YW+eCOLRztnkRKUcwG7Csobl?=
 =?us-ascii?Q?lVgLFpbX0bBvKaXJu6JtmEoQU7K6/2X6JwiS5XJ4qqOjNHzimpN1mzxIt3mW?=
 =?us-ascii?Q?Tac3Nxl4QAS26JVfuqeojU4W9+khdt7uFrLSR7lcCsUkXF/f19j/Z8zQcr98?=
 =?us-ascii?Q?uKh9J1uU9o5dvPvMT7+BZc7HBPsLsOe3zyd7ekctP0CBdvVKupNpEtCbXfvN?=
 =?us-ascii?Q?zhihV4QcXMBYqSfkcyOfHHZJ41QqOboWKy/gDG8kbQLu6l/uEtvj1GFRL6Sk?=
 =?us-ascii?Q?kgQQ5f/ymh/kBa5YDBTixjN3DwZEk7Ev1C1cgc0WMBDgVKlkAhZ/NY2P0B2t?=
 =?us-ascii?Q?Wu8Sg/ofstGNB2pDhS4Aue/7O2RWJB3O54N6raOhpdlX1o/ziCv1ngJWIW6F?=
 =?us-ascii?Q?xdyYCwZKJgnaGrZOg/jgvnxqufJYl3xhSrZibMeKz97eFNlkFG5RBPcybqz0?=
 =?us-ascii?Q?7X3IeJFlhn5E1I/epyRdTbelwthnf3Ats3N4KNcBCVglsWjR3mFxMUCvvzrQ?=
 =?us-ascii?Q?pYvWOcPat2a3i+8dBXMG2CnuUA0/+mtvdSdmQdRoW4KQ0kgtNO0tycEp4Dmh?=
 =?us-ascii?Q?8IOEIlqFOhOCTWEvUSnOYclNofzc677DjAMQ1mTKql2dACytACP5dQbGcRQw?=
 =?us-ascii?Q?XtX962i2MDtkUOoxgimvh/fp4FI7Zbr4modMgagkiF8sLRlvfkw7Ax8zHnk9?=
 =?us-ascii?Q?aNjLkgKgXuWcQc2mZ+hn/eayRSpK3BNUfg/T9Lb2opVcZBbWVecQuf1XA38z?=
 =?us-ascii?Q?Zt7No37ZwKckxCTlZKKqOfwyCTI9YVdwALB+DyxzUtN0TWyJ3WcKpuKFoMeG?=
 =?us-ascii?Q?h4dJW3kar64R8SQw2ZrybjE8l1KN6/pEfGW4h0aiQwO1pPcwjkq2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ab7b3a-28b4-455e-cda7-08de9ca7db31
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:28.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZQZzOs+b50p7HNT/YUb6i7AvX+go6b6XVSn5ACf1RgGnVPJIdEqwTOTRhiMHvxAjvmVALXiTedcfP0UuJV95w==
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
	TAGGED_FROM(0.00)[bounces-34944-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 0762441D904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 6b9ff1c6cafa..ae663cf88a3c 100644
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


