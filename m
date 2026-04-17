Return-Path: <linux-wireless+bounces-34948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFPyKZtw4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:40:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB241D9AF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA85F3080C0A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35E3CF05F;
	Fri, 17 Apr 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9HcP/IY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507453557F3;
	Fri, 17 Apr 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447422; cv=fail; b=LHKen3JGV9jrRFW6flcUbl7mYUyJ4ddN6tZETeZxBXtmbx128NyL2CpSv9tshdOBQpJVwX2wL6kfWvtyGbr+ZW7RoYl26m4h2XgiV93BJvi94oeZ+wkFyFwtX9afL8glSigNnyoNwIq84LdW0ZA/1FCTgxbMuPBNj5+dA/nGSgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447422; c=relaxed/simple;
	bh=DM8UR0bjbAZEwve695hDukF2CoVFZy5PScQTZPgTIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tV7GmkjGub+6EOnSYe76LuiN+0d8sMvaemN9iD/gcyvGTEFifVfI4Nt4AogEMxi48pWOnyF3SwY/MqLpB5IJDedxSV/7XaUOJAey8lsdt/sysyVGomBHlGvPQI67etTAorB2e9kzFFfrUh30A7Df9L5OllDu7B2S16Vx6ieOn3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9HcP/IY; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEkE55VxJPlwjpfwThBj9Tja2FoLYMB2Z9svRzz7S/mQDl2+Pb1lKLeRNRz0CV4OqSQhoGoMeqA8XqN/z/eHpWibiUcI3uKp4qh3Vb6X7NWoGqgXi7hwGGT1QYopUd4/8xhAMClL/YFGDC9OgAGBEhfuYjsedJWtrpqoMnEzYKCWbDuEEILIlCpxOV/KBrA7QdZ965kVkVvmkeiiPJyyQRh6q1CiBokjNaYS2pG10srTTNUJx5MjI2xjQJvIkw2qbQrxRkiiOu6Gp8uVDN60cKyeDd3GlVLwPd2L3xJnFhAr4zD2lbo4WOMRawqnGB98kEBunJS1mNUSTz7Q8QQsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22M4qBZ9oDInOAVnCqCfjreAC0fLUyowY2sLA1HlN9M=;
 b=CVKZSrtRjupYSXOaSEv/tTFuUM6MoRT4N7gW828+LZGEIMWZ++NbLHOKBwLaSxfMCsGT6a3+u3hx3juaJj322x0QA6eXZc4ENPSkghfPGpMYd147hn5T6BiqQy7r3l5Er4B2WGhvtVk+6LVyQ1kuoNWm+urgQhQrwNTnQRwavphOZlGo2gl37hzTHxUZGLKDGQQ36BGO308tvqxLMt0v2e4F6UySyV/JGO11SfeJxpIW/539/ANeKoFkWCkBK6ef5g9SZ/bOzOjB7eoEDjZLRTAfRT948290HliK/hr/rKOvrAd6dNCT40XC/FdicmbOOPNj8bKoIuV9pILcHSYpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22M4qBZ9oDInOAVnCqCfjreAC0fLUyowY2sLA1HlN9M=;
 b=d9HcP/IYEdah4Mmmoj9b9NHfhz+wpg3I/WZHNCj8BMCYohJLSvV7RS3VoJSo9AYUmxE+hQCKI3xVGK/ZmEnVJioAwNvUzipPP2ymIf+rZ9XsAYm+CwXH08DTqhTj6vCBdZCPnTvfHn7IZ5p0GQJOcAMGfJnUuwIuKvW4NaMwIoC3JFPKRwKwEEKKRkhcdHJfWS3zI+aIpQy8JNvra5DJmIayb0sAdjoB14hY8bgO5Uui7zeezzn7UkYYG1l+SsIOXQ64mjS1ydnRGwzk32ZsqIMmsSePFPfQw+p8GbubmuQULYQomZkIZzh1OD8U5SiF2MxdW89m/xEH2yKeRTnXCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 17:36:32 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:32 +0000
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
Subject: [PATCH 4/9] iio: magnetometer: yas530: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:15 -0400
Message-ID: <20260417173621.368914-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0611.namprd03.prod.outlook.com
 (2603:10b6:408:106::16) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 385821d5-1f35-4326-cada-08de9ca7dd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lQVFJhqhxqSv5oZKxC7Vk39Nh3onr8ThXUv19UCswNJlsyVYaXwAS9cdYwepz53cADQDsR8KdhgvgI2D+wDv82cKvc0o8Ue6c9gb+Llqe1iaNk1+uW5HkmNjgVgKsV4xtgQu6c4iWmQMqKztBimWmC0aia3rjYVCy4jNVafasJTHHtuhZpKNlIZ7r5VmBGrcpWr1USANAwTFNsiVTIecZJkupTp3kNU6sYpL13oNrGOTfp9yMBtMJ4GS0PoJuviYbFx5RKw00rd5oqc6U/+Vkq2WQiOKOMC317A3eS/O+mdJX0g8EroFcKvosgya6deJY/KSjeOW9H0CdzKoJJU0r6pySKb4+W+jjO5LvETzdLYj0eNBKwEYvChVFu81ZTwvzoJTC/jjM51mu8uqioUp3lWD7c/VmNT8BqLJ4Aw09+TMU7BMNaik0+950JEUt8n9UJfFfeemp1LbbGrlLERh2J+azyblFiPVNtSD8Ex8y5fwKRWlU069krVChbbe81SbeQ5sIWTwkRP3TGF+UpaxWJPH4nyJF62/bE8X6mQFL6F13C/Y/aHW+ReecEJGLy9FJwLTSxIhTuZvzU1HMu2GD5ey4pT1EPDqGYNAfHcH5ERCBL6FG41UUtA5bR1AuFCpxFow3v2/A0+vace4plu+z8Ykq1cvi9/OSpfnE6AMdl0AB8nP2excTb49olrrXsGlzGnlnqpOAQviaIDOsKmatS5/1CAPCqsAViUkeH+IjF+vVLm772oNz70O7iNi6heEfQnSgVjtJPkV691HiNq0Dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ocZRjbC3rK85HGiMEYCXxAHbPYAP36gQuzMy18R+B0BrioOCXLztkgAuYjA?=
 =?us-ascii?Q?iozhS7Lb1+364BbWaRrUTUi9i6Lvthd4H9ayiXQV0sWJyrnaLnZ3rS+eXTcX?=
 =?us-ascii?Q?BNGsHF5qeQq1LcVNzZxWOW41T0AZtacZQXjXsozQTqBR7XV+YIy7+O99knKf?=
 =?us-ascii?Q?Ftn7U4BY9kgp0yg5HR+eJRO3KbNj7hCiQZum9u+60It3/WGpQBrwzZ4ohrkG?=
 =?us-ascii?Q?qjXgLdJ43RNFDbQDwCKZcRHGEhU3f2Un08SiUzsuEygVhOvHc16Es8F7YCpo?=
 =?us-ascii?Q?gGZ8rbn5TvZklhjyZ1pGjrjpi19yTKli+7ccL146nB87FKvpd5hSs0Co1A3U?=
 =?us-ascii?Q?HPmpqlo+bN6BzjoR0M8QjJppR7xNuZm5ZNuSBck6MMAe1kCINpvbVpYGqeg6?=
 =?us-ascii?Q?Tle2k2KnbWKOwsaJCtqhk+X0xFWJ9wZKsifdvDSUA0uHfIt52OZsYNlALzrp?=
 =?us-ascii?Q?UZ53QX1+4INAY6hfTAihHDIQkegOgWDktQLVSVIIReV7pV9P46uDT/Uq50uV?=
 =?us-ascii?Q?lPD9Fthx+p2yyU99zFnoNgTK6U3CoTBmPyKNzQ4gE0Ak5v7ztOA3K6xsU0xC?=
 =?us-ascii?Q?m91GwsiaVA8BONP8wfT3K2KVloKO6Sde5PMQH/Mhxxo/YRLVcUwWkADumuSh?=
 =?us-ascii?Q?k9Xbfepljhukw+W4MxWpN7gFw0yO2AjZ40uNQIzb/AjyFsQJMS+CFJixUl7E?=
 =?us-ascii?Q?ztfTkj/73FONxIVXoHRQIVVCgQFoa0rKzaxNbieDDWL+Pddi4vX+1wXtdAh4?=
 =?us-ascii?Q?G5Nz5A0UOszJ5bnV75VcPGK0vVYhwFi6O09jgth/Uba4ogGp2oXwBVm9tTQV?=
 =?us-ascii?Q?hYdSb9y/9z2+abCnsDtiRi9/PSw5fcbepExUOs6RNFQuKVapwq9Nd3BCLGA7?=
 =?us-ascii?Q?czzDX7htEgV0ZbcIxTH7SqxWJr5nCE+fhiqXbkwrPTyg81Jl+XfCi/dXcP1G?=
 =?us-ascii?Q?VF0/cHpTjnRqwIZTW5IMQMH55vK3oFqCsOpd8lx1zLespbocNlxGc5+z1DpO?=
 =?us-ascii?Q?oKQxRVhGSvQcxvjiO7OGmbsVs4WgDnedfQNUw1OK5qxI2CKroW/OXAdzFA2c?=
 =?us-ascii?Q?Q72+FPLt5KQALMS6YaK8WWxvPs/6buVl87D2n6gps7IGect/pGkplmLwRqm/?=
 =?us-ascii?Q?SgNOwQ2QM40/fweJCxrVVN7PjZa95w+nfopA9WRllEOcquzc9Jxy9SiUdSXk?=
 =?us-ascii?Q?55fzvnIojoF7tLN0mEUUwCFjijoK2in7I6UQ5Y2c/YtYNRGaibxlfr4BdNDa?=
 =?us-ascii?Q?NCFuSJi3YsOINBqZ8aehoWs97gy6wqzfmxvUhXJEVpi5xBKhqRPaoCyUpB7A?=
 =?us-ascii?Q?d+bgxntGQ5gLV4OGy3r1ZayAJwok64i5YM453etDR8DUreWH9SS2qnZWnK+k?=
 =?us-ascii?Q?c6k+cUhLv/DLEyr7QF5vsCRFX1PLVdd5sQF604E4lznxNPpWUYbFVf2ujPxG?=
 =?us-ascii?Q?B8GYdklBifvqeaxBUq19CzDIT2Ui3KIAWemPo+/ULzmm9cWhxKJNmX7cWRh3?=
 =?us-ascii?Q?xdryEs7xh+7b8Ep0YWy3Z/vox/dCAenFxomeAzp4GV9+IKwVKiF24Xup2PY8?=
 =?us-ascii?Q?ULcqM+wHaz7J4BROc2oE157QUFtLMR9JcrWOFqgUBdfG1zgXWJWP5hOyp4ff?=
 =?us-ascii?Q?HpbghS/CvV3iYgng4PkfmTzKDlNMqa9H8fzpYc5wlCJKax8BNaUpzuRbmDiv?=
 =?us-ascii?Q?yEeSwqxD8ksMjD9dperwqYuzQV6GbTiGlmPwna8w74iyNGrLbRNsJCmHNGXd?=
 =?us-ascii?Q?JxOgEeMVuGiu2B/X1NT6sN1W1J+9FEOUs8hA97Z2umHeLy6OMESl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385821d5-1f35-4326-cada-08de9ca7dd95
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:32.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNEVi+Raw4NWZTnyMAZ/9RqcbZXLQxbGhBk400xZm0lSAN8YpGopInE815AuNPkedcMs5UTh8A/rC+fnyncPdQ==
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
	TAGGED_FROM(0.00)[bounces-34948-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 32FB241D9AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index d49e37edcbed..6a80042602c6 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -859,9 +859,9 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->f[0] = FIELD_GET(GENMASK(22, 21), val);
 	c->f[1] = FIELD_GET(GENMASK(14, 13), val);
 	c->f[2] = FIELD_GET(GENMASK(6, 5), val);
-	c->r[0] = sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
-	c->r[1] = sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
-	c->r[2] = sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
+	c->r[0] = FIELD_GET_SIGNED(GENMASK(28, 23), val);
+	c->r[1] = FIELD_GET_SIGNED(GENMASK(20, 15), val);
+	c->r[2] = FIELD_GET_SIGNED(GENMASK(12, 7), val);
 
 	return 0;
 }
@@ -914,9 +914,9 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->f[0] = FIELD_GET(GENMASK(24, 23), val);
 	c->f[1] = FIELD_GET(GENMASK(16, 15), val);
 	c->f[2] = FIELD_GET(GENMASK(8, 7), val);
-	c->r[0] = sign_extend32(FIELD_GET(GENMASK(30, 25), val), 5);
-	c->r[1] = sign_extend32(FIELD_GET(GENMASK(22, 17), val), 5);
-	c->r[2] = sign_extend32(FIELD_GET(GENMASK(14, 7), val), 5);
+	c->r[0] = FIELD_GET_SIGNED(GENMASK(30, 25), val);
+	c->r[1] = FIELD_GET_SIGNED(GENMASK(22, 17), val);
+	c->r[2] = FIELD_GET_SIGNED(GENMASK(14, 7), val);
 
 	return 0;
 }
-- 
2.51.0


