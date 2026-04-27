Return-Path: <linux-wireless+bounces-35416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAZUMLvY72l/GwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:44:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D147AD07
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064E530D378B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BAD3A5E7C;
	Mon, 27 Apr 2026 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUrrEeMV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32203A1A38;
	Mon, 27 Apr 2026 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326118; cv=fail; b=rKSaiNSB9Dvrb7Qyyln5HHmHcO2ZhHCx8PoptHFaMvnNwHYPqgLbcu9uoicVk3e02tzbvs+FL07zayhJx6cPjCzwDaR0Q4L/SGZjOiLoroH8A5Cqv5esJxRoRRCLCCFD/nhCLv9B2dOTm1gvn608l864p/t1jbeVCi1oOGOBrP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326118; c=relaxed/simple;
	bh=OGauGFrFwsbMvkpucrRq5bHoJWBG6JyQpgOL87nuGog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PbBwIuU9kc19tHKUDZbG5s4wv8/M+dnwn66jbTuQ494YP6GN0sKL3Ve9SdHV9iHi0ohdPW/iBPIsfe40QOTQLiRSyJuP/0S5lNgT7nI14I2qQWQdtlwk2jQKD+wakXDHXyWd6Vm4LoBG7DXHLVMVZJFcOd7o7O11gco1/K4qavo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUrrEeMV; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9gSJscSM6bWyucUYrw5g91c8oMiqCzzU9WrFTQ9/PbF3mT6Xz1DNYjnYLFkwgufPZ12nmJ1xSM/c6/XqRuI3m0kpBjoBVHhullpx0dP7pJFXD+QUjOLFWAVgDcJUXGMVJQQoFKv5D+1yIDnJ+v63osgfmp2kwap2bLjHMqkpzTfTIOHT3W7RV0o56ZwOTelKtcy1JQkRWPWkM6mZQLCETEpzjfvePLSiHv5kH58igxrLGdBOZdqcNO+isjYWQlpiat/8aTpFC4WXLEoPN7zdvTQs6tozG8jLovkMId1TeOicp+lMcGyE0d22OFgVxk5uAFwKLbjVtJogqLJ+WIInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu9qYdnyxhQydpo73rWHpYD/2ko9Ex64kwBwjZoAH9Q=;
 b=SKZgeAiHlBD6IV6R89CuHWM64CiUwEJk3iu+ULUq5gTMYV0wg9yrNfWVILLjPOPfWcxlFl6qjxmXaAFrY4SH47DQkSpEEthN4RG2m2azZ3FcPLs8GgKZvG8mi1FEv2K6AmMbLeuAqmmKvm1kUN0flc8qaelco01Ebtet6lgbLhcBqjiZqKmuH7s0RlpRB7S3HFHmj5lswFIAU/3TUyQZX9scCmh9+I1DfSBJBIZFD12TYIUZyVcjy3ZlZ4eHCG8DomeO9aD8yyai/uIvE6lQfzGXdEXILb9a1I617yoJfYLo4UIdMXpLWk3TKwjft5y9/5ZO6daXilhxJDJsqFysfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu9qYdnyxhQydpo73rWHpYD/2ko9Ex64kwBwjZoAH9Q=;
 b=QUrrEeMVLvqYd8ZJmp0Gsuh2QF+uvTn10nljXcRLWjsOBgp3YP7EI/4EyIwosBzEDaEzS95ruWzR+vGINnsRyXEb8h83BfM9ByWV5ExUQuJ4Fgug9YpEZXY7Pru3wlEuLpBgHrJv2jX+aVSOhxLQFTy+HftN/MV+r7SzShWer+Q89jGr9FsslPJuLA/5Unge/ls9jE6eglQ+nRg6dATcNdEWDa5iCdAAus6BFVbAFHahgq+CLnTzuvC580b2C6DN9gk/tANlltHU8ETk/2fq7qQ+tBB4EdGN4EDWA0gx1Uf8Q9CNAOQoinFUS044EEZTPkmlcWh7CWx4TaJ+9AQ0/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:51 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:50 +0000
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
Subject: [PATCH v2 3/9] iio: intel_dc_ti_adc: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:20 -0400
Message-ID: <20260427214127.406067-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::29) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdc7c79-e92f-46f8-c540-08dea4a5ca77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JzctzgQgbBtmP7fa8G+7UZJH2OZkQ3ZuSoosilH8Tkg129AA7p60WuhHNkJfSqQfxTQubvuoLVQu2prHeJSgTYsYDpJpYByV/nI/gw7OHRE01gNPm71tqoBMWtYLZ6lKpjOs581Y9jXGg+lPfCOcNEHEJoMfvKUe06SeRxU75rsE5Efp2yOuljpEralJC4TxIYMRrN9kBSmFScy95ysMfiyE2QxsCE6x4VB/mO76L3qfYuuAcJukpdsTPXkb8omNqk0ZwePPW+XYi+iH8pFXrpNtsqzCfbV6u+2NjtgJyGNi4rRLDQ+vJkdyrRI0jaX/kBTnmQhtc7d+KRXtBiiRRCEnM1Jxhl7tgTubhBdqynkUqksdKXyYd+joRJPt4NXE7Lxev2DtWSKyjjak3osOdrHbX8y0MbXLhxotJcTwFO3yjyji+NTh9Lw6fSJ4OaktVow+oM/k4J0XcsptQxhSzaKcA0okW9KYwvexqDKO6zqPqmMkh6AGFFRIMgkh1E/oXU/kh56InA4y3kgtPoSH9CYO6h7/58J81xh/sDqQLUkxxPWz6zBjYV6uSa1oYi1/jOxjpcPoZ1+WJYCuZmHbZ8kFXcQtMqyRUueCLVwh67aiU8D1Q4bLukvic5T6yYwLBujLx71q8gsFeQl77HVInwzBW8DGlKgWzlwVEwL3wtDW+lMmLCirVqgOuJHZLQALvz5R6xYDp6spSeM61enaxWe+nIkvdNPdkmD+kw0irC3vTlQMCMhbmhcPd2PT5e4TMFX65d64d4H03LN3Wsw3cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pUCoFxQfh7bVVtJS+k3cFSurB6E90Wse2QBCEdYB7PgP8fvZUMNLhM+M7Nl?=
 =?us-ascii?Q?/QUwZA1aQlJRbf47j9P4nGt0ymw1WDDd7EpyE8lKWj/nQ6ty6nRrhff/0TKE?=
 =?us-ascii?Q?B6q/sPnJrkgWU9tVroG9S9AA9yAELFaO1K3hzVWqRlsmiNhyyMpcu2ZUkrF8?=
 =?us-ascii?Q?M0dRBzDWyOhJf7Nb9IqA/uc5Pt1oHtj0rNBOOuI8NiJhfDuQMWI8Y72KLIIX?=
 =?us-ascii?Q?biOWEAvpsuU1MAHarIod8nAQJs2F15XFggFuu/+K5yExlhyl/oY+nk4SNp51?=
 =?us-ascii?Q?mxJnL/P2jVdMjmRjTcrdPZ3aVaWbEZHndBBbbV3zeSkAeBgnBU8s3NrdBvaf?=
 =?us-ascii?Q?b6Bc7U0N1i/z9jeQW6RStAFVCMiDCnJqGv3935ulqqu898AG0jHrA0JO6WMu?=
 =?us-ascii?Q?rVl0M+W34j2Lxm+pr2F/HXg0QgMBqFDP7azysNdtTFyDIkdFtiCdLR8fGoJz?=
 =?us-ascii?Q?PB2Q7Sy1X1LeTHp0Zf2sOWeL9lt9e11R3hjkwaOuofJpxuDBGQfRtjrF4m6F?=
 =?us-ascii?Q?SvTCNy2HmF6x+IWIbk8SApgIZ/hCPJ1w3C95ngWwXlrhSP4aIHQu/sg2ERK/?=
 =?us-ascii?Q?A+VpHB8iAt/8wwSHX/tyvtgLkviqs5BnPDoVF2cjDsn+HqGe6EBZYlKovUD0?=
 =?us-ascii?Q?eNGI3dizatp9uHgDu2NX4uSekUsQDF17n+w7SuEodrHGbbAsQgnBoKWsL+G3?=
 =?us-ascii?Q?wAYo3eCPHknstfiQ/5PJ3Fv6A6cGvSjjn4PLFdE0PSGJlCGQoym1EaAMnvOG?=
 =?us-ascii?Q?ng2j0Y3MhK6HCc5mSMt0K8qIAOHYFB+dNUwV919i6Vg1UaDqATgQ2QU5KHPM?=
 =?us-ascii?Q?PYPgSBFBUEyBnq6f3He/AdOqhV021F0Egv3gQiaYWbCeUylpauQIQwTcUql1?=
 =?us-ascii?Q?fvAqY+VfIE/4HLhbFeNjSq4gdY5hviimX7cnCl4o9VsC42eCDT1BKnXp/Gm+?=
 =?us-ascii?Q?iNzSXI5yMRN1j7Yl5n60P4bPLj0DLjvSFAU3r0mQKNhj6HGQvKgyGIxH4v7K?=
 =?us-ascii?Q?GGq/8kSOoesOYQ63BHmTs/7WmRFGyxOS894MMTW1MaQG+H2DrWyY7Wdzq79M?=
 =?us-ascii?Q?tqTX3KMXL/GvJZ94Ia6QRe3wYy6OywKd/JSBpaATjwJDtVZUE3DDoDguiwQ/?=
 =?us-ascii?Q?sbePPaHZwYWVcNTHedvqfgyno0j6a2VmMoJzTpbIFiJVdk9JwSYDTOR8UNiG?=
 =?us-ascii?Q?4rNUhtRgvNi5eWJzJwJ9ae0GTtBLN02jRbwpwlzLXo7/S8fkAiWSEL0gJtRg?=
 =?us-ascii?Q?ePev8Ds1xEuWaiYQMzyXa8nHdrrZ+VER6GJXAd4y71Hd4xGJlbumCK6mSprX?=
 =?us-ascii?Q?eZBk+P5l8IoT2/4WDhv0ECZJLcqy2J5ok94sWrd+el55RqTEIYj8mB91honP?=
 =?us-ascii?Q?YHQQGkGz9Rc2/42M50L28FjtphKM2mHE1Am9cuFEDazNzXAd7v4/70QUhdln?=
 =?us-ascii?Q?+u6F7o9lLq0hG+b21hqYSYQ5oxHSjoFzgwtrvdD5w7WDhpdaxuC4kXhGO0ua?=
 =?us-ascii?Q?x3Ju0UoHu5nuDidfh8+JieKJDVt6O8kp6uTNM3HhsqHaciVonAQCZzg+TBmU?=
 =?us-ascii?Q?iNTvGarQcGNU2zjq5Y2L9OsHea3N6kUMqH6y7HBXwoyAUSCP+8uIjdxjhGxh?=
 =?us-ascii?Q?7L4paKsYSsgNudY5ZTskSbUXxdPfu3mM/WrZgzjDuztayAZUd/TMsDXd8dcO?=
 =?us-ascii?Q?WOKfKhRnPgi+NeiWAyAWKsFbVO4u2kRF1oluT5EKozf/TpNQZigqQwTIzl9T?=
 =?us-ascii?Q?DLRYnzNJduKTrSPmk0tflBs9EBdAJ3VlOPqxwIobQ5emcTtqY5ZM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdc7c79-e92f-46f8-c540-08dea4a5ca77
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:50.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eSt8RcKWufIOd0hr4PZ6DJ5Sp0g/8w2zm3fwoztBtGuR3WV1335J13UL1chyB4OcWgjjrxHRGufHSPjA44DkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: 298D147AD07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35416-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't provide the fields length explicitly.

Acked-by: Jonathan Cameron <jic23@kernel.org>
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


