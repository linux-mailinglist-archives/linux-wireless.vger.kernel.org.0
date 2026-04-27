Return-Path: <linux-wireless+bounces-35417-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBLZHO3Y72l/GwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35417-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:45:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E947AD3C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0715630E9E0D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A753A1A4D;
	Mon, 27 Apr 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qonkoJav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748C3A0B36;
	Mon, 27 Apr 2026 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326119; cv=fail; b=COTwnEKddcvPg5iZ5ElZa5LF2jk4+fkqt4EHrUugxgEjT1Fj98WslmPx2hNEdjlCkJrNiwYrjmX4En9mWXGcAGl20slxv4LLhIYwB3UWeR0WhIG3rqgxuI1TqPi95jkfoL2Jrd8EUblbk7QG5AGnVz5Fqg/P1UHnfIg7kKFXoVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326119; c=relaxed/simple;
	bh=oLGJ2a1mpRCsHuGgG0vZULv9EJ78iNCksc8gNrlIk/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7CWNEcXbfg9NgvS+dr1A2yUT1x/Q97717PpWddn9Urz8o/4YC0mk4DGImkNHm2p/9/N8CCIXuFMbFsWzA4P+thqeYvd5GhGGA3C+NoTjfnzpb7dRiz0HyAiinAIz3rlDw8cNAmJyIDfwcaigStN8NQA+72VZIDv2Ujcwmh9IuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qonkoJav; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPvMHmT2dLVktKodYP2Mu7zrXWxUZAZ2IBvqXTcJF3qJ6/dYQ3g8AGrc894gDMa+iqc/7vWIG5orwBBMf+JiCSrZKp3GRDEoD/CJ5f6sbdowo5dv6ZaY7K3r16acS2Scu4KEN1TDP/wVbi7zjpCx2VdihzIzEFdaaLkeDL55+o0zPIoP8864/n17R9kzwsG2v7Ca++TSzSUsM6EZ6v1PC47SSIbofsYsc1XpcpsWPQB+TlbfXJco0lJrTFhhnCh/KoCDfxfcHf5aLqIEpfWwClakuad25nev/M6h2hqUHBjADukT9Gjm90knKmcEyGsBOtqeJIM2h183ohCs0GC+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEJ1t2D7Di6vMg2XXHh39R083x+S7XVB9xSaeRqObro=;
 b=D71E9/7ceHslgFhmp4EsFZ1AAYwc19YYobuZK3bydmupLl00f8aXXNyNxZcccSnl84pXV/37IAApTkaK3ANjBABU7cV58q2AtTnRMmjl7qabhNELr9f4/8GzVYZyFGcomxCzdLqzY7ZAltpuSrhfoSGBUNt2TVrlhKCrKhySy0SKWG5aqYHne09JHJqXfUbbD9WoPexUXsHef+k7FjikmrBYAQm+QO1cj92nl7rjqfNZFuV+n7Skl+0ePHV/yJrVTRfNCvVyrvOmfQfC13Ap3TajE+yo4qwtjDaFPS82T2elYwHbNp80fbA2v0yxpm6Jh7onzw+cM227mHVJ1YS7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEJ1t2D7Di6vMg2XXHh39R083x+S7XVB9xSaeRqObro=;
 b=qonkoJavGUTZ+HhqpsatwxelIhQHlOftuyXtGp0CEn79XN2Iym1jd++/CWznJUEJfp0qIXJwMJ+1R0YW5PniTitajcEemdubfjcYQcIsWjctzEhikbtbgrVDpx3zPvGg5BaS7lKNUq2MusExthCFrw47rCyjqk7qXuSHlxgZ/aV8DjUHU3ZPn/Cmah3tvxZRK9lryXW74u2uIdo+k9C2iNwkhk3S45N65WqKfSauvX9RL35ske5rUhcFcdV2U0mDOu1KJ69+MUyKU0mupNSbEqc0IgFdMV+CNY4YtH2TRb1KPZWVU8FBZGMFdV/oNXEZI8YiaXlLGP9J6iTBwnuRfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:53 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:53 +0000
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
Subject: [PATCH v2 4/9] iio: magnetometer: yas530: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:21 -0400
Message-ID: <20260427214127.406067-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:408:eb::10) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ad00bc-514e-44d4-4f5c-08dea4a5cbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KXImmwK4z4FO7e0AmYeKVP+lEijB4Ps/It4kb9SU92aWQXHvjPOt3nWWDiU1Eu82jclsKTe9jxXkLz7lrqyvRdnq7eSWaIdcQ3Jv3s3zVocm7mXC22wkyzQ3goUSQdC+baLRWXT0Kl/muJppnw4TZh+t06XBYB4kuqs/w/2X4EXTd7CMmkUE952qofdGZ506LmD6kGGmu04FZIDIo8yHY0oxwuiCyfxpgUAQYb4Ss7Za2rJXPdQn6+Mz45JCAzlk3zMB+FA58DDYoInp9kSlWLK9nhpR4TF4RWgMLqoLEdg0CPk1OKafNzc5zdLnG3X1x0ZKOoFNIzJGQHBjjPcqoaHWA+IGoH26+o6HpZXXQ9LFKYTupwVtS8efWa04WwazwtjiWfSxWzhXKaYMBcgiOfMhi27uiea3SkMvza7vxKFGjvGMTuuqwIDHMwTYJemtjqeWZuJOmPv5iJ2ztyWUTvouUzibTBxHUDlGKmfEhhqjBdr/4C/Z5ZuRXhWb+50eMuhQvS6elDUNh43hXma4jY/luOalTqfBk3zfuYkddT1WHt/bYMx1DaHIp/K0jkq4AHMAyN1vhSdVsvF10Su+HamckLMGoWpPt0SYIU4G4OPgmQoYT8dB0/JiEKwkl0kuvBhO0PpQ/KtwEctQ64qO1zdpyH3wiXta2/PwpFzU17PnOAItX2tYUKhqI0BKGNqYmerxeJQWPwL1QRgiB+xXgG1GvqL42/0gf/jLls5hVdZS42GBxC3zVVd0VPVWyVzARQXBobwmJ2D/YzM31WDpjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lT0bf22sRkl41bfYtAJz0bN06DIW5MXQQMKuYu30HI0iRoX9OkYgOf+Vc1Wn?=
 =?us-ascii?Q?8yRB8qqWWeXr5tH9faQtAXqonm8xc28BdeyCChFBCnqW+P1SbTds1HKxk8/y?=
 =?us-ascii?Q?qf0f7sV9PNw4rvJg2qvToqv6eMIQPk1mruSQiQIW6RDQ+WPnH/2G4hZO+WTr?=
 =?us-ascii?Q?j2wjOeCRufdqmVfaiFSUt6kvnN0oj2wzOkNTWt71jgc6sBZi44aFOgyd8ivn?=
 =?us-ascii?Q?k96NgMwJhICYG5x5Pilzd98i9CEUApLqe/a53suVD0hK6H0sh/EudhJBMPDY?=
 =?us-ascii?Q?5XUQd/dH1c1bObEUkw1rn5/lWEW5c6IgSYHc7J+WUOwCXFBmQrsCZuEiHoTx?=
 =?us-ascii?Q?R1HiDeu9COt2hQ849iGLS2y2dElwmGsCxiKWeMcSuKqNVSBKCdoQiukQIIl9?=
 =?us-ascii?Q?HPjqNvBSsXcIf9595TB6f6HmvqCrhLjOoRUfBp753u6+3BGp0x6hJh8pinh6?=
 =?us-ascii?Q?ECQEhEwHOYZJpvOWWMInzabrqqV0oOB+a7To7orfY1Uum0nuWIlY3O2psdhR?=
 =?us-ascii?Q?cvdYhXO1efnOajN8rTyt367utkEkW1RTDlD27zy7ZHDFXI9PRfl8Q3XbPBh/?=
 =?us-ascii?Q?Khb6VZfdoJlMbZlbla08RSSVjvtHCC8Ue7t0aK16/gfQKJnAzZ13TF6NrH60?=
 =?us-ascii?Q?qg4k8CYoZDaXDonbaYx9F+GFUnA9x1/lEZMw9JEonWpfTRryOKWUVLU8JlwP?=
 =?us-ascii?Q?8Qv44i7b88K8MZMzBLSN3doHmAJHRwY+p31CdOygdmDR4lwA8mJEWEDd6x/x?=
 =?us-ascii?Q?IAYv9W3OPjnbPvJCe8PskM7au5BToEsZ/NrwnpO67AS336X5QDJTKHXEFya5?=
 =?us-ascii?Q?OwMItiXOkHVSq8WBSyw01GG7utdgOkrvG55q5n870w2n3AEeFTlGRREgQcao?=
 =?us-ascii?Q?6ZDX7UrSydihQCPOWkarqUZEkei/A/7hAqF7Y59bW22CaqCGhi4shzY8TdSe?=
 =?us-ascii?Q?9/6LxKHcrtCNHIBnAn/OWul3NAUZBjfgAjTFAJVzO45U5q1nqPzj/lqFKZxg?=
 =?us-ascii?Q?f9YptcqV2/dEjV8dXAW575Q0C0J1Ys/o4QSGZ/ztJjSqMZ0XmPG981ooON+9?=
 =?us-ascii?Q?iGWZKwEk21ymQbMs0rnurHzZnNdeDiPnQW+jRSk4efUUuJrTrxIE4Nor13QU?=
 =?us-ascii?Q?q+XYclR+OiVBF5PYfYTdeCIFl4GZL8gxpX9Cr1D8EtQ12rfUSGmqiCnIlDp2?=
 =?us-ascii?Q?5lo9nVhGrH8KWDgKCOSXx3XpTbBm1qdtK8KRW1V0qv9HELmTWB5uZx2o40d9?=
 =?us-ascii?Q?J8Lxfy1dp0JK7q33dwFr5AAHfpFfoPh2JVGc4ux9o2heZDiP9Me0/+3/QiNV?=
 =?us-ascii?Q?LV5lnPAqeV6Mik+1P3Xe1+tDVnCkSgqMrlNipGp3q4T4FNSzD5qHnNgzohMu?=
 =?us-ascii?Q?M+yAilqL1HQfGXIrT3Z+UJ2/wQDIxL1qY34K1CbkpRV532b72pi5uuj1vMu+?=
 =?us-ascii?Q?obdfUF7OxMkhpKOWsOnWEH0tT2NWdlz2tTdC1BcCcWYrBx8iHPqRSHrJOlUw?=
 =?us-ascii?Q?rqOv8c6Z5DJOmHf4VZ1ELyL4rNz9INhcGEub4aEZH4b7zEk37m9K8QQXHBBH?=
 =?us-ascii?Q?wa1w+wf6Sr2n2YOWxPmQaOrzD8zvjGws0UvFvsFhWO6g/4ECP+ZqXXEg7MyH?=
 =?us-ascii?Q?RcChYhmoLhDVshBLHiAgBKVnzXIfbwxZw2iAIyZNAniggdaqvd+DgnNTH2Qd?=
 =?us-ascii?Q?il0ADIL9XsGYFEyWxbPicniQMTibuBYJilJiwWTd5hhaXrO7jCRc0eFleRR4?=
 =?us-ascii?Q?/M0ksqjac2OpxnhFYWJAml5wkkP50DSTtpu4ONxyynX0I0+3EJMf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ad00bc-514e-44d4-4f5c-08dea4a5cbc3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:52.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdK3cg7h4yNGm7EwCxPuvbzzP+jUOpdv5WBmuttKMhduVvRP1ao/bXqTEge7lyIYf1wJPxdLLW9fV05dbxXU6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: CE0E947AD3C
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
	TAGGED_FROM(0.00)[bounces-35417-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
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


