Return-Path: <linux-wireless+bounces-35421-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFT4FYTZ72mvGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35421-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:47:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE2A47AE33
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBB0312F39E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616F3A75A9;
	Mon, 27 Apr 2026 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LS8JnAcH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA1242D6A;
	Mon, 27 Apr 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326143; cv=fail; b=PNXBJmbkEJi8ZXHqJMJWHprRdm5k7f3o7h3pxGykcZ53Ulw3DH4Qooo/QaYuOiMfXutw3MJZjLwnj5euyGytP5NE3vAqbFYzPP95ITjgcI7GpBQ7U6UnJ/Ey03btsCHVVeL+5wEZyIUdAqYJZW8ATf5mKabJihMALP+ngi21y9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326143; c=relaxed/simple;
	bh=3+RdxaChtlgx3enDvepKS2v43zsaM7kJetaA4Pxc/SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LTP7E1XEPJSXk6HIFn649vYDoZ2wJjTdhp2OGm7NOyzfg5cZqDcB2pF3U7zVSFbMXmchS9lf/fROWN7tUoC3fXATEuRqMoeWiwUhjToxMG0cHDEXl355j24kxczSZD+y9bS7Ed/j+NVeichVUKhWhhewF7U5F+DQRIe9O666M0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LS8JnAcH; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDf5CayQFqGRXz4nca+oserDm6C3olIqD0UIXExsToM+uIzeRLQ1K3EKS6VD2qoEEa2Jdz18Jzh+tMQGSnsiEPcApCasRQUWUqgwqB2nIeL7ZT7Q1oSISMf0XwihyKhtyDkBGpx/32rMQCBd6FPKf3Q6jVjllndix54ObldoOh5lAY/wV4Vcty4j7/ydNzAUYdTKkwHlZBdkWSSeCdicgAV+ebF7TYHywOhyd4TlflDN1ummOOl1XbRbSisYvHyVIZXibm9ML6R9ChvtpxFne0upM6zQBnj4dSZ2ThIQ4MIeeCBh92hW0KE1lGqbGyIVWlvV8apbKQKjWmeZ93qx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxEiKWv1V1a4Y7+76ZS2LesUQISOVuKu8tCOpUR15tE=;
 b=qsYmzKPqxbbB4yarLEWxszeItX45sYr/WTs09kj9jXsRAG4cBsctqdcrZbPJJoY3i3RAoZt3YP1Bp9AYLRJ3H9Y5CFQ7Sl6BBoP2RudJPhkPvSSy09Ra0/c9TunDxjjNtg0fdIq96h1slt4kVnbCtoMVB8tMePeo49j+TOZC8CpscjXF334f+lCPtT+DsoPsQBp4rjfVWARhspRxkUSLX0izdhBNGgw0Z5SU0wN2MJlf/nlw+T+iUuYLCACp2hZ/tIYnoriWI1rysuyLolcOoDDWXl+KyIa++0MMQP+2paxGdn1sBvMEPz+09rNaMcUfTbci9c9hzbiuOnPFRbm2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxEiKWv1V1a4Y7+76ZS2LesUQISOVuKu8tCOpUR15tE=;
 b=LS8JnAcHAHGB7Sb6qQ+aqW2vPzFfouTAz7XkSbijqRe9tzO8jCxgivAXA0SfeULNiHjOrs+V5a68jG4iBcn5n3gCAS4uN2MJPl2SEQOiLiDJAVLV0gtAfX9zfwAqxLYT7ge2qJeNNAz5DQUAgpWh82Lf8ib4GycM4yU6ERgeZlUhQOkEROGIbF9cX/9ku0AwYQDJUjxc0Hi7QpuY1tYhl+isFh2Gp/FOrln/7ksg7dPpeEpyDC+4W5uAXm5LNod5fb8IQOzegQ8Kg3yWIzKmyqLpslieKDglNwBl67RNyOOkd6htiA/z9GV1PViNqJmZh4RCMW73pklb36yU1z9Z/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:42:03 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:42:03 +0000
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
Subject: [PATCH v2 8/9] rtc: rv3032: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:25 -0400
Message-ID: <20260427214127.406067-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0703.namprd03.prod.outlook.com
 (2603:10b6:408:ef::18) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cdd0af-c743-4a0c-db57-08dea4a5d1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Cmze7IbhsMyXaC3wvLRFom7smE++ED/2d/wpC1AqAnfJwYHZLNzILP+ZTuOmUg73yW0sQeyEUyWImzFalyNHKJ2CyOidZAiOcfFzuBSRAlLJXALF00J1+JchjbHS9t5IQusbpakoTyOP9VjbEcd7uwiIpyuss3VgWO2ueXFDhUP4LG34GdPHZTPa6nz69TiYIIS9nPDCc872mMgjfqhrVu9Z9SbXrup3Dib0TGCk3aIpk3v34/Evr5ZNlRhdA0CYmzLjAK9TEKU9xnjXI8rW7tEAndue9j+9gGExwQdzaxyoZum1DsJcOZqGHC5gnTRK3FTGC10gzWEyWjcDQZ90gH06dIW6bApZNpHyuoQdPIXCYfaRIdNUOyaBrIS99Dlxheve4c+RZWCUkYLkOACHuN81BpY6EDygLip5NPNkJfxZfKYfxSnl2buI6vGYalZDwevpDd7Mg4/SBOGqoxe1LjWBzqEXrprHalqc+DQo+h4AQW7lMI5bc+JQvJ9PqelX/gI6/ZGB9iIJ8ZvDEzovUHIH7j+CdgKyvJwSc4zpp7KxoaAV+OAY0ZcUVe6wzPlAjnIru3gGdy+am3HoonE7VKWA6aPo43XIPL+MGTEPo+jnSP3hYvoH8Q5PwaXcV4yJ6OBiD08tVVO/1xDO6yWQTr/KHnt3X8KGeFePA4Ca7Ugw69782FxP4JlSEWyPxhYwakEtLoWIEzxdpMSdKVr4Rxr0bjkrd7cwMa6w1K5PP3vDhUSdsu4C+5ZJqvWboR2Deg5bzDc+O6AWqfLYSHavIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCwcFUCPstnDn4fHRh+gfMqMNQ6RuA08jYnXUqtu707TGNWrr3Wg+eAECgeJ?=
 =?us-ascii?Q?ZhQKpG7xe8VSzu21QZyoKcEEXDV50Iqvo29Doa0iRNfSJ834xSVCvDddgsWa?=
 =?us-ascii?Q?uL1eK/1sqxcMYNap9jG4DGzY9uBRfgkQSLNcealEyXezCyFSlKNjz1cHFTgg?=
 =?us-ascii?Q?jGOCGUzQ/oB6IX/7YCyDJcU6OvCW59+eJQOZBAcgN5Vwsfy2k5vuHuDfAVav?=
 =?us-ascii?Q?D7M3jlijFDlVHyngeUGv8BuJNpVm+r5i9oTC7gqJMwpm0iVhj3hRZdhIDN86?=
 =?us-ascii?Q?T2YAdIqXIVcm4KjfqETP8p4g1mofBaWj7SYkLkbLW8eAn05MxKsuptTnuA09?=
 =?us-ascii?Q?XVSFRwCiuGKYZPmK+eXPbAwZ3xEeZOxR5zC2jYUOHZkf8+LqYEAC1VXuL0of?=
 =?us-ascii?Q?OV+6/8tnyiRB2EXtXBC9mFjHOJB1kgBZK+zBWytTebihMTFsPZCDa4SStRMx?=
 =?us-ascii?Q?wIDp3/wSii5VWQctTnHG8v6rdw9D3cKDL4HVSXitO45NRMnNJ1hqinlHIEM9?=
 =?us-ascii?Q?lCdzuEcn99wwZQ70CGKefiNnOxp+PDe/rlWpyyQ5KmVRcHl0to2seZJse2jp?=
 =?us-ascii?Q?4ztP4R45GEK5AaCp8ihTvQpbxORqTWK/olRBTLLtp4hsjldxhdePhCzVc75E?=
 =?us-ascii?Q?4UppA8NytnmBVSBUdtP2CuxCP2mdJQ/uSdkAQWINL62n57F4fe4j4uBNSxvF?=
 =?us-ascii?Q?JOBBrPxkc0BBBKVVjh+RczPePU3oWRckShWu7NNyIBNYYBZ5xgAJoXu1oyqb?=
 =?us-ascii?Q?FliZsqhSUwP/kKvMhQoPXaQwibXKiyw1r5koK5ANzBj1g4WReNLKf04flkKA?=
 =?us-ascii?Q?3hvYnqKXUe0Ra8hQDkePjjB2PWX3zBzf9EL0inQhJbNdlcw4BlY/ZJuWKirR?=
 =?us-ascii?Q?OR0ljawZETvOIvBcOMwFWtsdT1i0RKhVErbDkiPxNsisCwqGzqcVkEdpeU9v?=
 =?us-ascii?Q?BwJmeZsl2sLUHylh6dIdZdq+S3OX7Nh1Lh1jwxSUwdQiFhD2s+ENsGPPxj94?=
 =?us-ascii?Q?FHWxQdI+dlV2kJXG+yqdkA/xO7QUerHeRbWGxASMVk1M3yjZI9nifewyACRF?=
 =?us-ascii?Q?4qyXrIIf+v068ut1CuFFU0RsPqDGvDYmwdTg/SmtG8wMHKTFJmIWp18Y+t3p?=
 =?us-ascii?Q?kEfKb3sNJ8c+ozl6pD0DqeuDz2wX79fnuwud7E1yb4nlGEuH/mp8DVBUUoCO?=
 =?us-ascii?Q?HiN7nallIYo9B4bNu+S7P0nMMJmPnhzg4oajGUGLrEKbM3PxPnHahblHmKgM?=
 =?us-ascii?Q?2P2JBvDe+aU7Ay3rcov8/GJAz4k9x31PF16FI2Lp9hWrUPh7k7AczVk4bWVa?=
 =?us-ascii?Q?56/imCbC7Q3PFIe1ib5wzwRnD6eOvrZG8pTFZBaPiai30fwUJ3QBztohLJDW?=
 =?us-ascii?Q?11DLWeJqb5hKM076C2Zuf24zmKUweYhtWgLsG9SlkRarf/kzmsjoxAlEfFVe?=
 =?us-ascii?Q?+35kCUVkFisILzXucWQtqpv+rdkEnivgWFni9vvwat42UDCCdLw+mIpmasJL?=
 =?us-ascii?Q?rj3KccErgw/NCesMYI+XaWMkeIpl+rCWu1llojEKu/ppYPibGHGWErCk5Gxh?=
 =?us-ascii?Q?FaiksvqAcmo55IjnJrtby7cazqzjZmWNEsExYhUnw/01Z3c1Rvm6zlVWlHNw?=
 =?us-ascii?Q?xYPipKT519KLe5Kos9EvXYlWnUQvpD1IFrjI8FoW3CW7T/s9kkxxWk6mTkcc?=
 =?us-ascii?Q?B6LtDl+hdJgQtTg54rTaQTOc+bDiVQRaz22i8CfpWVkLx7+iYj6PwJz+OxTY?=
 =?us-ascii?Q?YhATPu445JQ/j3J53s9h9xn/SrCmYosQwjwYPncfaS/0x+JQhElq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cdd0af-c743-4a0c-db57-08dea4a5d1e3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:42:03.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3yERB3EATyizhBKk6OJfLa9NwWNSQpYb/8pBalHfWaSyGiixgUw+ejUBaRSnq05lYdEUo8W4clonQmkozVQwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: EBE2A47AE33
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
	TAGGED_FROM(0.00)[bounces-35421-lists,linux-wireless=lfdr.de];
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


