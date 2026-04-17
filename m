Return-Path: <linux-wireless+bounces-34947-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELc/MENw4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34947-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:39:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474B41D962
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CA9C305A424
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BF3CD8D5;
	Fri, 17 Apr 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5VsNlqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B893C7E1B;
	Fri, 17 Apr 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447415; cv=fail; b=PaODXXtp0Yp2gEL/vesX8teuLh+5vy1VIRnfF6ol2M2QLR3ToRRRNRCLew46m2DRLPJwpVac+v98TNz8e2vehHIDa3eOIDQMkZywvHhuQuP9+jGlStH3aq27nbf7xo+tZX8cHFaGfn3r1dm96bYQNXceDCRfyQjSB//3M77Dc3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447415; c=relaxed/simple;
	bh=lIRd/OeTkCekSIi42XXdwIun81mSYeBhX8ZWYT6kMo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKbbIKgjJF2XEy6NOeJUVpZes4kOtflu/+bPq7UUWzXOKVTXyjeRCFQ4hdsEhg6wGddK2PcAxEIYDXwwDL54a1v6GdaSH/2MeSl+I0PhdhRzacSu9J4vQaIP+uUJrMuolaeNa1OIFnmdbWd6L+dVUUj9go+FqYorDZORO1VQ1N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5VsNlqg; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGmORLqsk9ayD7+I+4/JNTuCS3E+Nn+RLXIXko90ObzmHf6amt+wfW0ooKcY2hWhfTnbbnWUsgd907goldGTJ79ryapci1RYJmmpb2no5IaSY7F7FsRLM5JHH2kCpOmQ1qd+4Vw696MHm7F0ntNXT3mBCtgcOEbduuAavqGo64CftbKojlSCvYBUbtUnJpr1/mKdetEHky3tsuHSHU5+H6hOmSE+EXiIEN1qZ/NFhU4I+/d3EGMgQ0t1nX+cAKzFBjfXkEm/vlra55utRh8SQedu6TKzwZOPDYI4fyqFHJ57irR4XEeMm9o8Vuhxp92G5ZkAl2x9q+nRXc61HTBihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O1p1ftmaTW/p0+ljX3Pd6DOkHBnEiGNl0MfLmHtaQs=;
 b=CbWpkuDFG+DiRIJJwwmaSdO5yZcHI+gEjjaxII3yyPszYakYNi4hk5m5a+coxwjI0ntw7EaKbah2KVRIneotZnM7+dZ1+z3v+Artne3VExZNrWJxp7XIM71Xlxz/2EBrogrjiz0218b8igpriHpRXRZ5+c3Hb6SbZXka1nE5NngU3O4h7Ld7T3pPlMSOvJ1GR0Re+BieFMeLTnjIUCTxFEvtUvAo+XKZp9tKpnYqrQroBqTFepFZBnqhhK0IIFZaHix3e/mfXEdtFTk/RENg7llBgqyF+wPWdAJDSHt0lsp9lnpZo6LUFNtypWux9c1lPKpPQOlwAqBHe6GTVgkn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O1p1ftmaTW/p0+ljX3Pd6DOkHBnEiGNl0MfLmHtaQs=;
 b=r5VsNlqg1OhmQe47EZ6SBh5AfEE2igxZg00FZNo6ebSXzZP1M6VdQ3xbSQHVCpzfd6oZwV7jq8Vi3zbac49A1dPd3iasPF3NWcQ+GW9WbuBin1ZqdgwSyiud/ZycaoTdvAUbNjvKcCA6sHGtyll/2p1TajQ0RdAbCyZFXq2CsE0BV6Vrd51uaokD1na27MdcuMpD94zBcu6bkNCdBQs6LdC8i/pDgp53gqvwYuzV7HUGp3NmMufuXNc9VP/ttCWFxUBw3iB4PgHjQd5Zgx65gJL8TFue06qrSQ8gDDEPDRGrO39oyO33uCxC5T7XbBBi0sq2sCW7J8PIop5ehqVuNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 17:36:36 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:36 +0000
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
Subject: [PATCH 6/9] iio: mcp9600: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:17 -0400
Message-ID: <20260417173621.368914-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:408:e1::13) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abbb85c-06ae-44b3-5b85-08de9ca7e017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8YofAuoCOC7zMZKWfaNWVZBGohDIBuZiKquzPdUhBcYSMvb6YXTqcxkz5vq1rTx94f/DSLRePJIBqWIXMiUFO/FD2cgh/FnmhDcrSEEEeFontm/9cx/kqHhNQupfYwxD43/CGBXIGwD1YrxFs8+EH6JNgvc+y9pDewzxXlhRmObV7FgCz3yzhk6VfjSci/rkjBfqsv+VT639rP1aJ91u0/wiJm9N258W183QqM/IT6/+dBCTCTSDBYIRdqGDIQxfnQVtMoBn+1n/7NicYl1E50CxFHjghI7ph5kfMm9G3MPhzCdrRqSfEGxHPSAuEhxW/hQvGKj3zPK+eur27Uli/7rNFK7XC/rnNKo9oqM51kTIwJeCWbKYT8YgRWStV4kcNvHc9SZgknGBeIQRNIQ1+ukGa8UZIEKXAS6tCT8cRx40Wvm2ZDHOU+1WpSvW/qldBT6n8kgDpKS8ibGG1Bfx5qcg4DEKnvpvMwKEPfwYPYnkQ8CP0d9r8badn5eWuMg5FH3cOtShQOiMmn6Vsh9gzzqrFqKHaBDxJ11H7BD1iT1nMWl4HDd4ka5G4KHC/YapWnKGZ/Qyam+75MtdLNU99OcKL337gsGOGv868VP9Ok+M5s/SQy6wyFM5OvnyWrNQR4rte1yJYCUYoLxdWjwd9R9qcB64mv6VpRx40QXXaF1Fxng2gO6Gjh8O0VVfyA2xDV5hFJZ6t8mdfqIb1/qPNkXAazd14WE0XwMCFcbrX5vbD/k2U9dpD4GPle+uyvk7YRzo67FHZOJTVQfRz8yy0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejZCUzNYOXM4RGhZODJzbU5sWFZPUVZ5c0ttNUNLemRSdHUzRWJPeXJPS253?=
 =?utf-8?B?WWprOHB1TW1zd3hUdVNwSkpMOHlRak5tRGl0ZkthaElBS1BFQkRqOG1kTGpk?=
 =?utf-8?B?bzdEc2FiSlVMS1lraXJubmRkeG05ZEhPUlduZE5NdVdzTk90RmhWY1drWHQ4?=
 =?utf-8?B?eHA5aUlXekd1dU96MHZkbHFCOS9ncy9ja2NCa28va3pFWWtOS0VyaHpFSmZL?=
 =?utf-8?B?ZEJab28xSzFwSUFPdU0rRHp4aXB4aEpFT2s2RlR6TThQdzdoOXhoaUNzbjRV?=
 =?utf-8?B?ZXl3amdEN3VFOW9SamJEcnZxTHRoSVZ1bEE3WUZ1QUEwc3cvdlc4MS81emJm?=
 =?utf-8?B?N3Rtekt6aFBpSzJiTFgwandOMkU0TE1pV0p3WWFXOW9ZOW40bnRvdFQ3azlW?=
 =?utf-8?B?QksyS1Rpd05WYUpYcHlma25xZ1dGMGFnU2hBZWVCWVZFL284cVVHckxVblhh?=
 =?utf-8?B?ZTZmekU0Y3ByMWhhWk5vSDZZZjRkUmlxeXZ0V0FGSXRPeC8rS0FZekRZN1Fo?=
 =?utf-8?B?THhFR2d3dGtMQVBnV0kvYVFFSDFtb2ROc1E4ZXA5bDhKTVlxc1lGT2pVdmM1?=
 =?utf-8?B?Y0MwRzJBZnQxcmZia0FLNS9TSGorY0o1L0pCZU1WT3JjOEVXNERxMU9DWG1D?=
 =?utf-8?B?WndRcnhFc1JWM0VKNW1TUDU0ZlJZdkpDRzZSMGUySGlkaWNjdkdPbGViOTV3?=
 =?utf-8?B?dlJLVnc3TU9HNlA2Q2N3RjZJZ0E4eWhCU1dYczhHZE1RbGhNQmtGRFRCUEFJ?=
 =?utf-8?B?SnpQT2ZRNkhtbzVGcXI2cldyRE5tRm5uZEtZcDJoNzRGak5WQk1zSVRVRUxX?=
 =?utf-8?B?SGloakVacTVUR0UwcjdOVTV0aWlzQ2RId2xTNENDVUpGRjNTRTE0T2pWd0d0?=
 =?utf-8?B?UEpoaEFsMHJBbk1DM3E4TWk2Q3ZaWXpLa2xlVE15VG1Ld0FSU2F2S0RUWlNI?=
 =?utf-8?B?UFNVaCttd1NacmViVWlVRWNDK29aWGhEYXRSZmYrdFhtM3ZiampaYTBvRFdo?=
 =?utf-8?B?QUx3WVIxRXNJTHlLSWZoUFpORHVFa1VTejdMZHBNUjBMMkFNOFQxWHZiKytp?=
 =?utf-8?B?MEp2SytkVWZlcVZCa3pmMm5lK0VsMFh4WDJHVUdXMnYrQ3c3ajVTREdnOVZY?=
 =?utf-8?B?MHh2eXl6RWYrRzBKemcwN3VPcnM4WllxNExQUUZTNlVBOSsyU3BxTTlhb1RO?=
 =?utf-8?B?VVgzc0psRmxyZlhod2tyZGJPUGkvUTlSeDR0NXhFWk8rR2NscGo0YjYrYXN1?=
 =?utf-8?B?cmkvNzlkWlA2bkVQRmV6cVduSzdXU08rS3VrZTlIS2p0MlhLWm44UGdBMFFh?=
 =?utf-8?B?bjBibUZ6OE9MbkpwRU5lWjBwRG1oZEl4NzFpVXcrOUZ5WlYyVjZWL3l6VnRS?=
 =?utf-8?B?QUdLRU9qRHArK2gwbDNNMUdMdWRDaU5Lc29kQUFyU3JMY29hZkpOdGNmbm4v?=
 =?utf-8?B?cTIxU2EzeHU2cHR1c1llRTlERlhHRWlyVkIyZUdtckZOaWFxT284c0swdnUy?=
 =?utf-8?B?ZTRObUo2T2xUM2dtczR6bXAzZ1REUURFRjNmRmNVc0VDbDJFblVkZ0JLcEpJ?=
 =?utf-8?B?d1ZER1k0ekthQUxTMGNvWHlEVnpZRWxyeVR1YzlveG5YeVV1enNCQXRLWEw5?=
 =?utf-8?B?T2NrdC9rQUY1S3hQSDhqSE9mem5PSkZaai82N0l4SkU4RllHc1ZUTlBNWEhh?=
 =?utf-8?B?ZkkybzliSldhTnlrMGlmcU1CM2tsTUJESDBXS2pYQWVJcnJQNkZJaFNaWWY5?=
 =?utf-8?B?YkR5V2VyKzhzSTFkQ0cvdnlFTm9sci9VUmJ6TlA4SW5SRGhMNTFVMS9UL01j?=
 =?utf-8?B?a0VqNGJ3ZDVKRHRrNEFRTHA1dXlSSnI3M3V4ZVB3UnpYQVhLdllJc3ZWc0RS?=
 =?utf-8?B?U2kwejAvdlpSWi9CK0FqMXU2S01HbDYrZUJ0VnlUVVY4T2dxQXlITFlvNTlD?=
 =?utf-8?B?YzBrZ1dGMnM3UjhucDBPMzh0Rnh1ZUlOQ3h0YkJ1ang0ekJtTlVwakFJUnMx?=
 =?utf-8?B?Y1E0UE5ZWmdnUklIeEY2WTU3RGxxL2xIcUFEQ3I0ZUltSE5lMndTb3RqZDFt?=
 =?utf-8?B?YVdhVUdIRTdzTmp6dmVXVUZpcDE5akRJUFFpWUlBY2ZWcmZ4ck5HbFJuWFFY?=
 =?utf-8?B?RGRsVjY0YkJrOWl2QTJxKzdQREVFdjB1bGtWdTFXbndCVDdiVzFiSTl6bDR2?=
 =?utf-8?B?dmM5MzNBTTZ1L0JYNnZwdnYyUTJxU0JsTE9EMG8vbHVlTzZwQlNZdkUyTk1s?=
 =?utf-8?B?aGh5NkN0Y1U5VW9KTUVwZXZxUjdwL0VkSUFtUHZwWkFoOXJIVkxleUsrUC93?=
 =?utf-8?B?dnFmeXVlWVFJTloyOEVhU2lXU2NjWjNMekVuZ0NjMXZHTlFDdE5vVHp1dXpB?=
 =?utf-8?Q?+UCrFTBGSo2TgTYUPAx0v+qW8FvuuzFgRt6qx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abbb85c-06ae-44b3-5b85-08de9ca7e017
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:36.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSsDjkePYBOOPIEO2RNl4EVFuZJHlbFZ2HEkHsJmkZee/9+SY9/iupz+pGw4sW50lH8s/bQrQQcafF4H4TROhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34947-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4474B41D962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/iio/temperature/mcp9600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index aa42c2b1a369..69baf654c9c0 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -297,7 +297,7 @@ static int mcp9600_read_thresh(struct iio_dev *indio_dev,
 		 * Temperature is stored in two’s complement format in
 		 * bits(15:2), LSB is 0.25 degree celsius.
 		 */
-		*val = sign_extend32(FIELD_GET(MCP9600_ALERT_LIMIT_MASK, ret), 13);
+		*val = FIELD_GET_SIGNED(MCP9600_ALERT_LIMIT_MASK, ret);
 		*val2 = 4;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_EV_INFO_HYSTERESIS:
-- 
2.51.0


