Return-Path: <linux-wireless+bounces-34951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M13LEFx4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:43:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049141DA49
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AEB310EA65
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766253C555C;
	Fri, 17 Apr 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eGUb5th6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDB3CFF61;
	Fri, 17 Apr 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447445; cv=fail; b=KsHuRkAD9FX5gdi0HeiVqnlM7Pv6a77tlIDlKgGJB/mfq/gZVtv+/X8D7wHKW2FcC28h3xP3Pb0Imgp1BM+QN34V/Y5FMb4mQJ5U1MCJZ7TND6BGqjv8qPKkhTHtbS/2mHQ2zVKEjMMwAVbEc2XSdqQxf3RVMNr4xuIarO5iABM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447445; c=relaxed/simple;
	bh=klhIQzv4remmWRP7GbUeuT79RcUz1K1FRUqDJZsk8LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnPwiZPT1z6bfVdoWcbi+2KTpNPDtZCnlywlKzhUBY0bae0fiL/Mm3aBjKaMfA6Z6dmSHyUlcHDdYvHk/DgURUHktecyzHpfAynrrfwDVW+uMlcZGqc1DNuVcxCQEDcWc7V/b1mRVnRRSAfQADdQs+DXHIP4ZhKu5xSycWLZaWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eGUb5th6; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDfqxHeU/NpI3djDI0r5dDP953mA+z9/P9Ab58Kvopdnd3PE7Tv+8GkllggP4emAkYMR2h3OFteYBtVnEwV0scHRD4rkq2hixnvPo4/LSQf40sBsE/+DqeS7RuMFlpLzmRUG9YKnmBIe3kwxAnmzU1wGMADNQ2avg8ZcOU/uPoiD6ds5csowsvIN9UWTqWDNhNYv1UED3p0TDpfy1Mvye5mey55sc9Zd8zb/OYr69pn9GFq1U/nbfTSkJECFN8sqZAWzE8ZnugWaAJAWNzGzNkV8pBvOzEDP6ajsUCJMUhIIO863+BZJF02YgSjrRr2802+BWUbift382ypmmmbovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhEMlCS+gk5qzaIUTW6mjfmr6VnP9Ohc19O2DtAx8YA=;
 b=xgLo8vboRQIBziPDc9omBrwn+NDRVaRC17qHiUXECiT38kbVYzG182jbuLZKqX5v+mty2SeodewJuQ2CWIT4Fl75MteHQedYDC6r70JKB/kKwDOtjCTlXgeqrdfuz8pW6Li/fmNVDUAdYoywC5lEcPjDjbE+b0lms1DngsWZTWHUaiaxa261DEBPRUYDT34/wvpiDSl5QkKdu9R3rChqew8UpG80v7fKGJXuhuh1DbcKOC78OGD5cDolpGxJM/o4HzeKrCDwkYW86LfyfIk1FZBGkMEjUtBfm0cmQWrZShortqKP3VqC2l1PjfuEcm2Jp3jZps1nNitI8xWTnkRnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhEMlCS+gk5qzaIUTW6mjfmr6VnP9Ohc19O2DtAx8YA=;
 b=eGUb5th6B3uwQCQYmJJ0M8FjSIAF3HJD5wfwMqmLZt3avslT3Ohj5JwOQNEqkoiQJXhOZLD4AniQ5nZJjTzJk/rGoJ1ywNVPsCiscHzHJAbLjpoH4vpV5mT2A5Lphi2DmjqqX0CZshUw8qly/rQfgHdbXNPIYHsk2U7VRkbx3/I0G08cqy4f9U81OLJghyBXPUQl824dJRGhwH4a9Kt2E49j9ZG/rPlJ5Ufa3IePBDz5/Dxthz46+A5EQYdLR7+jUHaCZrD3MgbVYp6InzPk5arOsS/OV19OXW6y/EiEpZKWji+5Dez2EubolhxobaVfY2qUZyQvNtEEg4hiRDbLsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 17:36:44 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:44 +0000
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
Subject: [PATCH 9/9] ptp: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:20 -0400
Message-ID: <20260417173621.368914-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:408:eb::34) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: fb406505-549b-4b4c-1f67-08de9ca7e466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/XSEyl70NCxHKOiRQghe/f3RWb5MJayBBxw/NFGSNJohbomIgtZXU8RJhWHLPRw7s0Bi8FaOE4LA7wvCidmmFJjq4lf3JrbEhnsUG+D0yWlHo20y45qui5HR8m+nnchLxPUC7xbshLsJPRVQ0ua8pUf9m5bDGxYc4G2iuTNtKH4Pdjf681RcnCvtc58jCFCLKiFq6npiLMqcyi3FR7u/uIdxAbCkBDyBYKgobEImDF/h/xuh+uEamn3geNtY2YXSYmwdQ/du3hIVgD3/DmdcAvtaFZqq9/FJeRkwtlRlWcH+g5nNPQ3DzEnLRhIFOEiR/CqAzjI8KjGGs/n5IjZ3mIgTJfRXMKuHISK/pM2CzanVGnLDcTqyLQiu/j84UM9olOAFoIRpCectxbm3TgtLZIWXyUfPs2ihpLoMPXcXjzgb+1mAfSqDtTNw7vMrHGJ7qr1lwKlRNZCxLFVGv5QjN3pdUbQ2hkUtPw16VynbGgs4usJ4lhRKtoC9TRO4HzMPey8rfRF03iVfvhvZyzbLL4aL+ZeskAHtpVnqrcQHCIap8rl280aswUF/X7xsYutn80fqul6ZcZ4wSopkeRI/B6f96PjVhdVtiQXuFe/yWueedzi+6Z4P+8CyZCAOHCoEZpFRfkSNYY2gIuQ8VfNF8KWTxSCHxr2CA7mpqXe38zl+utXNoJqZYe68VvDAOZhgvT0OHd0iKrPBCj/VLVVG9QAeOqDzgqhacSLfv6TdUAporYDFpXEf7+511FNtb2lAG0AKhhzwUDqlmmO53jNawQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3kAiVrx20uhJO+OGHK61L6Qtz+5wpFSR14bFdQM67NuM5LZPy+sm82OfdfZr?=
 =?us-ascii?Q?bJfnRf0bfdhMn0mePzJ6kMHMqSAZpusSMk4EbIvtzQ8WgeHyTM+HtjE4tR4V?=
 =?us-ascii?Q?GEtyJwAqB3+7ddngGn2UmXdnBr2HOamtUvPPRyjIC154nlU9PZzj62n7xj/z?=
 =?us-ascii?Q?aAW6mle02q5QSYb/Nx9VRJFXmEXdfOFlEEKuADPSXg6j9XRlUCNrjSQ+WfNE?=
 =?us-ascii?Q?PSQIwzWxaiJE1VOgRGz2a+AG9JXb/PbsbIWuZhN0fknC+lEVfNgQvJ1BmJX7?=
 =?us-ascii?Q?PVMeiKYvR4X7u+VDJ67gavEwuwmb5Rj1BGbMVsz3QP46yb28Tkzn54nZ7JmJ?=
 =?us-ascii?Q?H9ygarYVCnd745IYWFo6T+dpIgd5yzSj1rgxPrAxNadHz+I0TfpNo8+MoCTZ?=
 =?us-ascii?Q?wlPws33QAQQQVHSaByRofStzhNQHefK2EPDfs4txBDYRvy3H2tis/GV5xfN2?=
 =?us-ascii?Q?saWdUimpiecW9EXdVHw4wd5Acgm/kHSjl9VGcBPx69G1jspFv71arFbxzqga?=
 =?us-ascii?Q?LBF/y0AKK8pJ81aG+H7nV559o3WV3qCMf8AiKGteGFxyMa7uOU26C8+CSOH0?=
 =?us-ascii?Q?QcCywVCakina1sAYFE2i/+XkS37OiLSGOp8MspZeJcJ0YMUq5mkec4u3V0WX?=
 =?us-ascii?Q?9nFywu4jMnTwz4AfRJjOA4RL5etowrRc3ozQAeK+iONc6SR89fDTxEZuA7Sz?=
 =?us-ascii?Q?P5uqeIUpDuwybQoPyc0ePlBXrdfdXDPCjqKa+qLx6Gp994RpVfdJNjH0vP6/?=
 =?us-ascii?Q?u4EWfgyK7WEifpgOOhntsYplYTsPCwGJXaW4FMp91U7WsifXAe8yOJ8YJJL2?=
 =?us-ascii?Q?KfGkgwgSCiEie9rKqOW7prDtzr0mujBzFZFoXRMV4ejmQjN311pPHJ+N43az?=
 =?us-ascii?Q?gej/x7lVKn1+wONFIS1j1hQSrpBBqZNgBTVV2+/cMZEo9aB0w4Nj1/S2M6dv?=
 =?us-ascii?Q?Wy1jDRkKxfb78mQTtAZ/c1Dqeqp/r4k5s7DaB8x6qeaT9ixNA98PkgMWwTCg?=
 =?us-ascii?Q?njjDuM55Q2SrBYHqnnEA1d/bXpPrECDUgN9OyJJDzxQGNuqsXnaT07a6+Lfx?=
 =?us-ascii?Q?m9Yn5M5y1YNUSprEeMfXLFkmxMsw44nYbVBdk+LkWRBMG1nUiHEngGzMnasy?=
 =?us-ascii?Q?GFO6El91SrBwEwxxsWuS5NhT2Wy84PKhZI2WEWyH7aK1joqlRW1Wo1LXJNTD?=
 =?us-ascii?Q?ejswEZazOKOkh54OII/556PUagjOpCxFLT6OJiUV1i+gdLAyzGUoH8ZVVdz8?=
 =?us-ascii?Q?tHh3gZh3BblxdiJTrktUEWpX6A3g1HXBaOn0RgTr8+ge8QbZrGLlKazJmVGx?=
 =?us-ascii?Q?uS2UQcDQfWcItb0nY4/TRco30jZ/NMS4Bsqgz7CVTA6e0Jd42oAgDhmgNYtU?=
 =?us-ascii?Q?wicvjnpS9cFi/gKQCQaIqveZpPjKfw+u164SLtqf2WvaBzqCRcHWYK/qp2+J?=
 =?us-ascii?Q?AuF7c02cn+7m66JNSr70fHuzByyAHUZ+Y81/LZhTwGviy626WzVsNlbkQDEd?=
 =?us-ascii?Q?aMycbA0fZkHOW490jDjOaPGdjc3Or0E7S3buOFLRx38+PXk7Ra6KHSBUbqXM?=
 =?us-ascii?Q?vJAz9+Ul4lHrdiyfq2JEvokjQHskI0g8UnvwW5eyByOL8vMRnilkVLjBkZiQ?=
 =?us-ascii?Q?thb5LLp1lZCsXBALsbhQyKZK54sa5KQO3Fi01HJQcCyZNrpvFAhrEcfbl+MN?=
 =?us-ascii?Q?DW9cSu+PMTpLHxWfzHs8eQeAejVUaHFx7DdsUeT+LugwQIIen1GC1Pit1OZc?=
 =?us-ascii?Q?6mCunoIhP1U0lpeu6gBzXrmp67hctyspxzw9TXIEELXWjSFBSm3C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb406505-549b-4b4c-1f67-08de9ca7e466
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:43.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pznCGRjTJVrqRfg8nUWwPlG5UjfgFAEkOrtbaNR66YISEna3OAHwDTglYLR68dxkaYooq6cF0cAP96rkITiu2A==
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
	TAGGED_FROM(0.00)[bounces-34951-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 6049141DA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


