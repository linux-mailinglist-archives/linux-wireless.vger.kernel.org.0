Return-Path: <linux-wireless+bounces-34946-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONMyIXNw4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34946-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:40:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD341D983
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AC8C30C20AC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF03537F1;
	Fri, 17 Apr 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e1cV71Xr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C33C197C;
	Fri, 17 Apr 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447412; cv=fail; b=qoK+RMIdMrAu22gE5FLtBBOZEnHnqOwh27pRS5Px9xJEuShBoIp2QqlTuDrrPWi3oTGkF8nTlBcqeJVSI0kAlH+pJ4X1BRm4yJU+1VI9nSbLNFQFM3Xpz7YQ5lTyvZMIOgT3pOCRs7IpwjkZwApbiRnMbKI3fC8f65/m5SBvH0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447412; c=relaxed/simple;
	bh=mtnIZOfmdYyPw4T8zp33nCm8rHajTyImAip6hkTIyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaAubPyKnsIISXsAr75mMJXDge3JN09FxEK0XpRE89PWzGbpKHND/tPFujMaW5uQXMBBJT+cEC1M17B07g/dpULo3l+GVsfcrsSnnnqywHJW5dmKBKvlRz2ItDb/Qyk/ypNv7cy2fev9RV1VlCXHg557KvyC6aQKdG9TeuQdY8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e1cV71Xr; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Juj0AnFc3TJn+R2pl4VMZW65KQ3SzobtFP9+1xRjtqp4A00rI0MHd+8rgjbKdN6F4XXXzuJ/4+VxLi9C91gDMWt5GuRYfibkQ6NxR7Fh8oHBi8WYhDLHrm0y7NWHoW7MWnxUzLBtYL9qYTKMJLkx4V60vTt5CPdXm82LWcOaXA0Svm0ADUwF/+SqqnrdH4p+fIXhMEUAa85sN913XmzNaabbuYEs9WyiWdkJsh91k62zTB1gc+DjxcqccSgVALGrZeeNrcqlJs5flRTRkn8pYbYtMRMsqIh7xTgRrhm9TATlGWyGvc2WbiymlDqKfBOrtPCwqqsxBThr+6JHi/ODwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX66ds+GXe8H3R9JZBOgwtS82h/MOG0WXmk01Zy/dds=;
 b=wL7C4WF4Z2fSlJIe3XvxglpJRdfdSeJi7g7t6zQW3D9Tog0qLq8dLAckihNP0lsXoNTgpovGeUDcmwb36Q0Ak40wfYBJEgPgEltyP8KrOVg4Upx2A0bFuu5jAXmhQ4rlf3iGgtil5PLMjMkyLRC6niJZwizh+fp3b8JKz1meIUchKy3z7+RL9MjwYKbqV6QxtBfCpr8PaTSFEf9APf6clFwRb6H7qsNcaV50N+6hkW0J9xcJ2NX0jlDvoAZ/HTpFJW5BnFJ+NNFbf+QMSc5k5DZ51/cnFnhitr6tRx1XPEDrCJzPJsjfxKwfZLCijWPseSBujK2lFdhBZKweWLr/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX66ds+GXe8H3R9JZBOgwtS82h/MOG0WXmk01Zy/dds=;
 b=e1cV71XrJmV3c0Xb25JLymhvCiPMAXHL4iO8XGmzcFBrjUiY4mM0bP9Oi7duSI8TRLwliaPvyhUFjI35pLdLzmLzqYq4M6NiucySfjlWzcNMX0YQLWnvh6Fu3Pi21WHxyOOGNFdxXcmGgU+5HVeodOoT3Ilbp2xhi4D9CHhPHEve7PJBqgBcxbH9nZVW0A65kVxKWmIvMbzPNQWB8WX4zCsYzf/VVp/6YcqSNLjDhZFq1DU6sjCqe+UHoEMFrdC86Cj7CGRrI6wZ5ZQEglgVGVz6UsIi7Zir5bWo7qxe+U8vtimgAriCIDfIC1CxjK6Jmm1v2bpxMLKg14u+/jaDIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 17:36:30 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:30 +0000
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
Subject: [PATCH 3/9] iio: intel_dc_ti_adc: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:14 -0400
Message-ID: <20260417173621.368914-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:408:ed::10) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: dabbc255-7380-44c4-533c-08de9ca7dc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/IWSpImMZiFwMNEvHpVPLDNGxUZPjwGR+/S2X1Zl8MXNilC1FxBPsHRz3dOaRelXt9dpAif+FeOULFCfjqwt4+ZDfU+qahtnM7LnxCtmIROTpGncbbpLyrYBtEvVJr/SXmwzGNNj8zRBtkSrLp7gT5aXtgQJ8we/sU/uqYPgmuu0X8eRjQ/g0Zngo1k6P3iAXkMU0BEOM4XTjeLgrNtETAs14S1Kpega6OC7y60uJ3zofIQjh2JPoul02IH4zAwlKc8zPaRKCowMUW2EOm9rwlFlxmF2jbd6enlA/SNFOOy2m9y3gABqmWplSBgBk3A0SLBTsL0QLERs/J8BkWi3igDO446F8Nk/z4xllvrFfJFjpDlATEhT/Bd6POmpFyMO57NmPfSl4w55t2vseG4l2hsLAkkYo329ECCaSoW1/SuwvA3PF3ygC26a/PZDx8TyYiGpUXcrCaAFTSgONdmKSZJDDhSrktWx18N2IjWY3LIIXcHgvVJBJJpJw3JPJRL1esA4PK4QsTgeqJUpGHCvXtTNWyw44mcgjAMAGRrzrXPHqRmwo3LwCefTapI1UX5ob9txcpAoU9v8D3mUy/PrdWL7DztC0S1zw195JXPftP91yT6lBgWnpteZ3yW6G8ll37ndCfobmJy6gZgd9SrbiSWYHQPkNILFfLSTnJb/u1OLlc+ffranBa+UuEgNJzXN/XFPGM6F9QmhGGTuQMQX8u3K1/Y03dXtJ3iJCAdRxT9+Fto13+GyjyqK2RJuzKcazULzR8kCZU1aRr2V0uZOYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tDxfJrv8N33PUcXjIFgLb+9jFRLJ3GjiYEkszEtu5gMPy+NDTdmR+9soC8z?=
 =?us-ascii?Q?QkHDF3x/bUuv1lakDtjXV2MUA6+Cz3c4OOrd19vySj/RWGM4E/xI+pBdkPyE?=
 =?us-ascii?Q?989yNf+tXYb38XoJDSgz08oWsjRbCFxq2UN5nplQIUOnbyLvlSipeca+BMPX?=
 =?us-ascii?Q?MYDzbgRh9B3Zva2qfqTU5Z8iDwTwXzSK6Y8QyaGjHn9gXxccqu1a3v8VQx1i?=
 =?us-ascii?Q?VM62cHtYsG1Mis2wWZ+lUT7HUd0s6bGUPLnjkjY81bKqfZH8RyBDkWq9MAK4?=
 =?us-ascii?Q?APnDK8bdBxJfUsOZ+qAkgeC7oYfSs7JcLrBsjA0rQaCvzUnxXoFPndUGK2Ep?=
 =?us-ascii?Q?T8GnItAaR/WBfDcLZXpP68PjOZpJ3DB0Y1aEUKukIInciTHzQluL3vt60kUX?=
 =?us-ascii?Q?yoTXjiX57Pij9+dnKZmJZltXyLxbHziOZ98dcFbcWPS6qFiNZrOCY4m7FLZU?=
 =?us-ascii?Q?8CrnnD+LQEe1B+VuZKKtFjY5+0HRpmz52+MF5BYUjLNUwiJLJTQsKoNtWZxE?=
 =?us-ascii?Q?4foes7aE9Kd1cJ92g0G9mZ0hvLtmDQjdPpx9xLtiVFt6RC5upCuofVp7+nXk?=
 =?us-ascii?Q?6xrKpDzcQTD88hJmZX0uElTbiZ4vH9UjwB8IxrugjHdHv8J5T8uUPj/BDbkM?=
 =?us-ascii?Q?M918g0n1aYO2zTtEmlJw70N0tBdyGL2YhMaKhJxqFTZsDWDVKLkJ3uwguiLC?=
 =?us-ascii?Q?pmGr52/6UOz4hGO6gD+VCwCSyqmbCYIPORdJLV2GvI/jzwiGHdjg/nc26yuQ?=
 =?us-ascii?Q?BaES1WxDmZLtd4LmFEpCn1MFnaB1xB7JaLmpOuqmV9a86sOmchxF7nSVOvlr?=
 =?us-ascii?Q?fyAILxKG35lBD6IT7ErWT/rEdwJ6abKUuJm1Uk2vRzn2yFhfmLR/DDJXzdxb?=
 =?us-ascii?Q?tHcQbBncbQDFllJAz8nfE73LoLuaVFFcSZXNGvAb6dO3Ru7AfnMyYMLzAB2d?=
 =?us-ascii?Q?giblrgdO0pfLQzzw6ry4Ocohiyec96+Achg0L4Q5SXtG2B5JubxM642QUbUb?=
 =?us-ascii?Q?hSVDyJ+Ni4XieDPlCtDKKw0Y3TpGo/Qh9n8ZsbUCTNKrJ+oBsrJbGmlXN6Dl?=
 =?us-ascii?Q?v5oJgigdKn/PJbUVKN2P3DP68p2MMZZNHEzE1QaWaWxU47wpIoBz7uwTr5HT?=
 =?us-ascii?Q?yAwl2upbwmCZDA+MVqiZ9KU3mwbfdRJf7tbv++BhJP0QEWxKWq+Utv8Kk+55?=
 =?us-ascii?Q?TPTMyJqIoQl9kaXdVWyd7p0N56sIfNWslHGbOnGPaeMQ9P87P4pan5WzTCuR?=
 =?us-ascii?Q?A+u0LCjGJj4N8cC155ACEJ5s+rRTmMxBjv0T5Rnf+eXHjHWaXmnjoxcB1sXd?=
 =?us-ascii?Q?a4ydelRdca5E7xxKXQjU94RWeRiYGxCiAEcj0r9qysvKD68jhtKyqOC+yW9K?=
 =?us-ascii?Q?9ymevs5CSTMbmLNdyjDWWeZzkuk8owhmasis9kt5k0zXHED4qLhZe6bCMZMH?=
 =?us-ascii?Q?j/QRvYONnONWIvvSCYtXZ7cyxc8YUM0YJluuCwbLp9rF58rC5hOk02YH/BKa?=
 =?us-ascii?Q?9/bk865OfeSixZDq4fErtio0OKpt/KyQ2DE8XFEc5pIm00s97JZgVCSnj5vL?=
 =?us-ascii?Q?uZtT7YKCqxedJjoKup6frdp8bgFYT5RLqwV2MeB2vsvEOYx3R/ivLJVnhUO9?=
 =?us-ascii?Q?qvwNXzb1L6s3cjbhDdq7puqRsCmWZ0fhXFIUfJbqv3l5Cg+evrHb4rhfO2kg?=
 =?us-ascii?Q?F9NGGtvy8uv+nJpx/Bi1KbtmvgSjOxfeeHMdHejgThtQUn9qinJa3/X0iFE3?=
 =?us-ascii?Q?Asi3i9ffNa/AghB9Gowfe3+gni09OyDe2nUIxlZge2gb4C1gbouT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabbc255-7380-44c4-533c-08de9ca7dc6b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:30.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZguWWBS2yfP3vIBE4p4/vVjcVfDZrSrKsG8z/W0pNFxyZHiNe2kjiihRtsC98911L+TfDmr4HdXWGF6VKH7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34946-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 37DD341D983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't provide the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/iio/adc/intel_dc_ti_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
index 0fe34f1c338e..b5afad713e2d 100644
--- a/drivers/iio/adc/intel_dc_ti_adc.c
+++ b/drivers/iio/adc/intel_dc_ti_adc.c
@@ -290,8 +290,8 @@ static int dc_ti_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	info->vbat_zse = sign_extend32(FIELD_GET(DC_TI_VBAT_ZSE, val), 3);
-	info->vbat_ge = sign_extend32(FIELD_GET(DC_TI_VBAT_GE, val), 3);
+	info->vbat_zse = FIELD_GET_SIGNED(DC_TI_VBAT_ZSE, val);
+	info->vbat_ge = FIELD_GET_SIGNED(DC_TI_VBAT_GE, val);
 
 	dev_dbg(dev, "vbat-zse %d vbat-ge %d\n", info->vbat_zse, info->vbat_ge);
 
-- 
2.51.0


