Return-Path: <linux-wireless+bounces-34945-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE1uIQFw4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34945-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:38:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D33EB41D91D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4CC3026C10
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1463C8723;
	Fri, 17 Apr 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwK5jNU5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8533B38A2;
	Fri, 17 Apr 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447407; cv=fail; b=StAySBy+o67xkCQacB/o6Rj8A1QJ/Ho2pW2FH2xr/d4zfe6+TN1znsqayOIYlnNcxUQL/5Y4WM3HvYLRNydkGV1TK4jj+Ov3yNTXcbrDzJti8M9MIMHzWZTvb+FdbTy+lb/IuQVVuR98W4u2utevyW34ZadGySmv3NOy9QfFFVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447407; c=relaxed/simple;
	bh=7z+1KHy9Y/iTy2Xzfgol10SAt0V1h5SrdJJewT+KsIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bePt5bG0ICpYGu2sneKbfg6rYmOLeIoVxL+Mrz+jCj2rR6x1AuFBCTSHDWGpHM8iA2KkxGyk+NsagAtMsNz8eI9l84qhmdp8funDQOERD/d/awb1CnwCDMml3RZrTpZ7PngbzKRe9f907WqkutDzVIMC7Wpvv60q4ZG8mwHzKTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwK5jNU5; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPmbxZSE9hkAbd7x1yppwkzgUJSZM6AuKTcdYf2lnxrjHRAxWj5zMCgvDkrnuzi+L9tDhI1JkfudKldmS1s9e6Sen95GEy7r/BKO6o0sAUg9Yc/6dNp4zR0zyS1W+t8zl/iCo6qEf8krut48qMbMIs//iAXhvu6RbFmYozyFGpZXiLLGOm3nCCgqzTijav1ThqnCwKjYZDQgyqlZGkIihj6dmXO+I5AULQGS3E6aOCmhGht1VINdiooOe6bRuQA0RsHrriY6eeiT7YM4cgWRYZySg4Njz3U+4BEO5OamNGMdBaYIZRvI1XNcQkxyHtagpVZd4akSxNjNC/7AooY0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EYygj4M9LHw66maZ4/ZiTSf+VSj7TR0VgicTYIiKbY=;
 b=YPAy+4yA8OY49Ks8NIFiWvWJ+wNdfFpFrH35Cwkim9JCkzSgsR10Z7bxNy4BtihWmzFAsSnQiTElKsztt3XT9UpNeV41XMNDSuXS8jH4NCauE8w/tyX4rk5cW30HO/jVR70Q7NifyTnO0Frp5tLhROija2YpAzJq9DR5tY03V7jsPQgStRBnrGP4JZ5L6gVB2zAc8CMrDsHKoJLrbL46TVH8A8GPgbIK4oZ3gSFQJKs2Phy0af0DxnJWHrLn8MoN3T+o0NvwcsWGW1dLpTjyYtflxgFToSrU+s5TtIAxRc5jDEA4AeKmy7fcMIfE9GE8YgFwEJX/FvJH7dBtVg9clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EYygj4M9LHw66maZ4/ZiTSf+VSj7TR0VgicTYIiKbY=;
 b=VwK5jNU5P81hEORUFy1blw8Rccraz94Mcf14b3vNjsgIYBzP+Nr4yb4ra+E3iOTUfM+Ys18JK2m/s1/Kd5cE1Cfg8ETsykxnMYNBZ37CMY66aw24hs5PzAokECvbim73GyMwfn9xVQ8iAlexDc4WigyFUFNh6FkoiYTWhuv+hpYwEmE0BdE7e2F5YEHb8dwdfLIux6gUGO+XHzSPbjUSs34R5SdclcmVKg6mkK18taKrkVjoY4QKPBfWEuSap8TJaEOONgQbxDQXTmwa15cxHBs7iqAE2xVfU149VNJoEsHV7CigBVFF3PdjausV/7Pyx9clCssfAqgL1UStdxFbxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 17:36:34 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:34 +0000
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
Subject: [PATCH 5/9] iio: pressure: bmp280: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:16 -0400
Message-ID: <20260417173621.368914-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:408:f5::10) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 6193f444-0f23-4c66-215b-08de9ca7deaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nLy26YWIWj0HwOmkZsx3OYGbMYkOMyDG8fyoAHnwlNtBBABmJFjorFQ10DBcbG3ffvcX/VCnY72nShUPack9hK2kHh/YxX2Jopr2/btMc2ElIPc+95aps3fTjNBVOjN9vqIxP/9gB9O0dDpHZzJ5SUq01jagWntCt4CGwjpcXg4KKDit5EE20cKPDzmOiIwgmo4Px+6LNqK/5ETe28hfuMCLg6ZJpZVuBwuYw717n1XqEuseuO17VDjy8+avml/D+4ab9r/yK+S22dxYHWQiCCMnYO2WSGcXEblw/2dzJovFJFvjifD1XyItYRKALMRFQUsQ0tKqy1TtgBw0Ija1ujk5rzPrqG24l53+pM6kVpVetLmayYRuJyrXmFfyoZsaBV6iAbFGuY63UZb01G5bXrK3dIUymTqqrm1hP+w9Xqb9vOXvswBk8IIXo+TRpsqDPdTWkc1t3AdJfwk2CRQq0nZtt+wWujjPuVeJWJDrnb8Mi2pZOs1uP08NMwqGvlkCUajjeonWe6dmiARr/oynraJuo3hcBqjl/OsjvKc5Ed0W2zYY0Sa2HrPOeF/FS+XKe/j/0Yrkpni6xfmo8uFeWYEnc1B/1ewPt2cXc6QTdvUTZWzxOezFQugsxP0HkjN8xhDM9gVVOh2BlwEPbCVDFblTD0dhBGIVQu/QR2qPya28i/wj682aFyxDARoGTBKsF/FoMHINEOW4YQQ36/SoN80Y+w8w03NjdbFk98xZh23fekDg+nJjR0tAgepI1WnWAmmehDv7gLz3AynUW1C6yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eB9kkEVbt2SDlahfwZgF7Hf/4GdZOt9vnBCAmnQ5DUkJDdiFX01xdyrkAeZN?=
 =?us-ascii?Q?0c6Y0siqmfRqFf9d1U23edr23/lPNEP690xg4j75D/P4ULEv2Ao8pYFxayXL?=
 =?us-ascii?Q?URGBmCsWvuNHOABZGOc/S/MfJ60GQFoMTw2uh2sGxBLFFotRl3SZE8u+IRB5?=
 =?us-ascii?Q?M8x5kExeJwvyZgsLSG5b1TopHxpGrJg9YqbywRwtblA8r/Hz+x66Jf6lWeTv?=
 =?us-ascii?Q?MSl2diciLMKRJnFCIm9ndQkk9OT4I7hXGzFQKBHbJNhZ4SMEIstYfBuGzq1G?=
 =?us-ascii?Q?oKC0nLShOKG97L9PIBxNpvFzdIE7GVWRlPuWVwtn8Uw7DKOYvAZMs+3wQX+w?=
 =?us-ascii?Q?/xqg68mhQ5Qup9Tp1CarBhhK5/sCHlbW8g6tWNToyu3G9YyoAcAxS6tt+SMx?=
 =?us-ascii?Q?5KNFvj3cRwjEhuF+1uHDKhie2oRaM5NOPGYTW1ZslTiwB2yFRGQ/FOE0Q/Fw?=
 =?us-ascii?Q?N8te69RJr3olSw2BjPvLtZ/nI3/EVp00krkmrMi8DOqgn4qEomS+wC64Ygrm?=
 =?us-ascii?Q?eMOkRE8MWIVa9yZqNmBlRfLNwkkgaHkc2dA0dl3dUt7OwVn9Jbfk64X/3VK0?=
 =?us-ascii?Q?/nYX3l8u+QHx+IX0t0aM76OarHbOTOaPaceD6ccOSBJq9d7CEFPqEcPBbXEz?=
 =?us-ascii?Q?vx0XWaZEBh+3hBHnZKxNqNoU9zB7KLVSEWu3GRiOD/4SXftaiSPT9iG3nsFN?=
 =?us-ascii?Q?DXFV0gg2Qa14Gyf5r5BDFmw4ueo5X7qiFTD5h9RMUdE8OyeNQizB12idByQX?=
 =?us-ascii?Q?SQVOUyPB3JUzBjDvlA2gy0tMv5mqhob0ZWMMgiSHRXX1s/n3GNiGZmpVWOqV?=
 =?us-ascii?Q?THHL0TeXTk3b1NmskgHTwSVCNb/4UDPq5FD8Z8OIg8BnZExvZ6XhZzn9a5ND?=
 =?us-ascii?Q?qtH/7mGMBLTYA0Z09LAAPVlsqHBQsXe1Ja8DTXU2KkIQ1M7JkxVTbsJheJ2h?=
 =?us-ascii?Q?VYYSnLNgaTqxuN17AYjtMR/KtDZu3tlZ9V1kRrz2mBVi8DuvEBd8KhQ6wErB?=
 =?us-ascii?Q?8iPU67kwESOVkRpLWAcCnBrXQveEu8ndalGHhpOauXDy5RjRpfUrfA0BU+OY?=
 =?us-ascii?Q?gyjfibF9EYRfgyLVdW2iCiDNXljt6qg5TzinFABeo5j8Py3UXrUErggCW4cU?=
 =?us-ascii?Q?IsZozvorBxVF/T76YJN5rvPwTBlfP7CExRWbb7Vu1GtJFB1EPCHsYGu28JM7?=
 =?us-ascii?Q?gFoFKn9EWBOgY9batd6+V/WJjy58dV4elHR3t60SstTM3+jd5PGzhE+rFXDz?=
 =?us-ascii?Q?hYp6pvg0sFc84DV0+YQ5rU+Ttj4DdWRBBaHzcK1L+HMY1UQR4we+VfJI9deB?=
 =?us-ascii?Q?kUaUpfrKzmzuzpuHaz0Bw5RJ+mIDSQfy4mVY5YncktUDGigndXfV5gl0TPoR?=
 =?us-ascii?Q?4K1BXtM+Jhx5WFqIiGL6HKEJDlPnnau+9aP4sV7sg+qIOsarmJSVHVfLd3La?=
 =?us-ascii?Q?kcUGFd3a6SqMNtja59rgV2H72q3aJoZYCDold543KkacqgZ3TZLPeOc1TY6P?=
 =?us-ascii?Q?aJL7mWdF2Jj0XEaRGk+AZhNggEIQsESynQxRdAX+f2UqXfshGkmJRBKKZsEt?=
 =?us-ascii?Q?Hduxqxf7cEVvVoS6/FJz/kkEqVhBxdKorkL2RYjPJdtNEb7W1haPZIHCPNp0?=
 =?us-ascii?Q?JrRyyVGw1+8uzWHsx6pyFVPcUW463DhMH4CMjkE7Yqhu+j0TGEYOD7q9Toh3?=
 =?us-ascii?Q?O3ubpVcf/Zy8M+v5sgTA4RgHYSkpxlL2YqXYPH6/KLVwWNlt2ijqk6azBM4Y?=
 =?us-ascii?Q?rEaYPdAaQ3x756SyvfltaaPS7dk2XL59QBhsTDsULJt9US4LMmqx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6193f444-0f23-4c66-215b-08de9ca7deaf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:34.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bv5dNsj4HY0/gzDPdjlNDvsj2nykx9zkfbVHzjPxlA0wrC57D4IuEDDepvXVlUNoEf2OrqVYF3BM8CPrwNKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
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
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34945-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: D33EB41D91D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

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


