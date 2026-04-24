Return-Path: <linux-wireless+bounces-35281-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOzRLFWR62lGOgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35281-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 17:50:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A461460FFB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 440643020A65
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B6E372690;
	Fri, 24 Apr 2026 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zf2iNEWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C634752D;
	Fri, 24 Apr 2026 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045819; cv=fail; b=ojzToXfo5u3qcCvoJWB3mp6K5zs1hRs1PIGDmDGurLVAOCWPoM1SWLvpIr5p3756QDHGffr3rO5tNuw0C4e2QSP+bxmk12y07ExEAtdnxSbsUhQYveYPpJS6EN5Z1287Z1gS/JtTsj57uu/ane2jmiWQBapukErHmLdeosIvfzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045819; c=relaxed/simple;
	bh=4SwFeVDrMrDEPhg+Pv2NUAcMQiZBMWUlY4FH8TQf3Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UrszgXE9ShVAPwUxwbLS1rWA7C24aox9m1qYC6GRqB76ZUEZ82IzUO0zL0n/lWc69F6FS6mcOuc5pyQQngkZL87d6Fe5mA/JTLGYKeHoTGnGCZgw045sAvfz24snTsTok38QxmoePLGP7LJ2mO0xISewGiu/egBuatNdsQflODQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zf2iNEWJ; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXHvintndVGh7SOrzPsS+g3y9VXRNsBhDvwxCfb3R1Et1w9wg6LSuoMBMiUtMTxFYW01AHLdKLYEkOFShWv1+wyOgXVon5hoZjw7xR1Zh6Qf4AxSDQDj0XWRmT+Tlc32T/2EI6Y1pDNn8NbODWt5THMRhxZT8Z3SYatdDoZ1ktiX8N3wr8nGhJYreUyx6ZhJIaDkLanLjBXwIQ4AaDCq4wA0gnti52rhd4dV8eLabvQxUAAVYpmRJsc6NptZjZQzJaGeYVYojWnlWdZx5JRD9Cm8c9rjUtsyWDs7/hoFuniNKaUJLOL/CDPasyZSnhnQXKET6Z0ew7qyishYgohm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wltxVI/e7H6RNN8uqDmUfNU6ngytttCHXv6hlW0A67M=;
 b=EXBQvjzC9PDtcrOFw6YvWaXDmhN8V15t/h0AlrRllHkDPVrnDteHS2JP4udNXG6XvT6O745+Pg6uLV6Ks6qZN/32HD1GmDz/Txgj/jv8y87PG8AhBFCgYmIQjEajfvGt6iy128HqzaDEqSe9R9rdDAMpE0lptEvL1CyrmppCLY+jvzvDCyvzTs9RRB1NozRk627ABsIgUWQ0w7+hyYIhpuZkvHxqO3ZAiGyWVX/Q3HBzsY0rB/7J2LH4HF58RvDJmdePWp2A8D1ZoHgbOXFS+Wa4Whp6vFL160bEBht2yRt6z6sqXFkTHXERZt0SxGpRudYNWRCgvyjbJFrkiNzYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wltxVI/e7H6RNN8uqDmUfNU6ngytttCHXv6hlW0A67M=;
 b=Zf2iNEWJ4TJ7yFjppUdUsUDlca/whnvYZSY0phb1Qy8eNCPxZIRbgD9zJKCbvbqN90d8D1dBkc5cBmSbwBn5hdWFlPpx/JjsArn+xZCLwD6sHH7K4trJxVfo5ChTX46sVQHMZzg6LNH1KiydaInrLNB/zt33MvXItwmMLSQa1rTl3MoFg5mSoTHPy7QBANE2YZxG2THo/vtVIzPmIs9wFRjxOUf3kPcNjRTXwwxI+n8V54n1xJxWdbc3fuflUmi5xARsqo6xzTpUp79QOQ/iarPhCrFt+wKjwmknz9Qj04LepTGcLpDuZe2IPkV2mVrPjSmRkGoe39h4S3sHV4VmEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 15:50:13 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 15:50:13 +0000
Date: Fri, 24 Apr 2026 11:50:10 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Ben Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeuRMiws8zCdkGXX@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260424130927.349ad3ae@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424130927.349ad3ae@jic23-huawei>
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 2594ba65-cc19-4e93-c1bd-08dea2192be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H38jSwjsaKZj/z0L+WwisHJiG9Lhpdvcb5yAY57PksPLvhve6MZEMheO5bfreN6a0pFMRQXSnv36S/EpHZ+gknUqcpdIDYdNbEsLoA79ona+Qa8WkBNtdaaKrrktbKk2MUgjSCpl2lAAIsKovicV3ZZHVPyMRxxoQbw1j2mJldllivkx2N9pG5SaOgjbJmekZsMs3uIIvdQQSqz5J/jTKKzrxD5U1pDBpuORFOp5rvssDSNwzQOAj7XaJs4IuDcV2+dk9cE1kutmUgKjV2jzQUoSFKLDO3HIYIvZjFJLd2mLLej6SRdb30dw07JGVeJ9pk9OcFWJtqxwgb7doQOVwH4cEWjPkApyQZg2Kvn1zUEY2nHITQVxo9LDTP9ODqBrNhWrY2gT8YxP8suIUJ5VNEiEEP+q1mYCszNr7No+WByVqElAw6qKEoQ1ysspDNCAkgzFFqtEZOTN6Hk1HiYOKdNP3YyMiLO9PRvk37qRUp7QbD/MFHoLraW9BC40G82jLsu+myR9k0BGQP1Qo+E3YR9zr/upTJq1YucrXAy2+Pb0QgccjjTkfdihCfmqDJxoGYzzlZT6BPIKkml95GM4+1BQOQ/qZSSTmFhFMA5EPH6DtM0bYkW/9JEM3lHnAFU2++pqinShwAi0bX5LGYaO8KXKFrTjSPe0/oDYfw5OZfJtNj2fViRpuTc3tiupHH9lZXVmjobRBBjCvxBIOP9hofqO355giRID5WieAUUXFqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pN/xJq2+cUNLCBYNmfNq6x/beR/b3Ibt6Rx1ee8olLh+mkszFQrF0NRCiRuS?=
 =?us-ascii?Q?QJViQYbK3mN8wxuuyqzWnRHk4RZFI6ebozPQlBkrA/Y7mM4TzXg1wbcjAsni?=
 =?us-ascii?Q?xAIjOWY9jg2CzvCrUJKyrjYVBWVgyeGPJ1d6hLp5/I/WPtDA1maLWFLNr5RT?=
 =?us-ascii?Q?4KV22dE74PCLlyYZBLYtPsABJLriyFXdAKnSILRkbpG81WBmhsEhw2TfgpOZ?=
 =?us-ascii?Q?RJkjmVmp4hCYsT0NTPbuPnziY706R3lLK7vYWl456tQtSY0i+JEPsgrD3s9X?=
 =?us-ascii?Q?/VerzRllEs7Mx830iha/cshewJzQdGmoSG9up5MWJ1grQN+ae/S1o1NTJPJF?=
 =?us-ascii?Q?MGE188V6afmv96WbK5Zd9RRVQEtlWFp0I7nl8geX9t6BLCqQdWZbXQXMryqq?=
 =?us-ascii?Q?VsyHa6QRPDWHdGQ4UmnNFKltCkzygU+ERKXhxO72/lDZLvntsspNfp4jsCIb?=
 =?us-ascii?Q?NweA/Dp1pdDdx7VpnTxJ3ClqYyh7jka7Vkr7qyMUVNss//WImeYG9MKgh8bR?=
 =?us-ascii?Q?jPkhaUb3UKJQCW0v7dldgSB6GtLtv/kGcrNlZ2Ghf4NUQYU41ag0qq1D/I3z?=
 =?us-ascii?Q?OV506nR0Ahh0KLzEMyOsZpeasNADGVCnbbJEyYM236INm2YCbIdgDp/TH0az?=
 =?us-ascii?Q?d3UwWiaSCFyqm61J5GgB6ZUhXRyVl84I6TzmqNStGOWUKY+7T++iWTv1YRpU?=
 =?us-ascii?Q?o/QEtViO5EqSwsb5YVaKTneqTJqVeeQFmc3klxU0xzSw8s8AtvgVVNZjOc4o?=
 =?us-ascii?Q?3lMMKzwMY21OpWpl4Lx1tMZD56G/+zUJqXsrk6c1BAFKFjw04rBDp+DrEp1w?=
 =?us-ascii?Q?ACxkaAC+z5eG5u3t9x0LNcc66XQZ97KbzOEmQCOaR7X0Iy21XABYh05+/KRu?=
 =?us-ascii?Q?PN6sCsn4fYjE94eliq0E03Wduxi1U17FxrJwJJy/2+UYty9T8usOW0NzHMvk?=
 =?us-ascii?Q?RToB5ovTfUuqBNREAHVbqZ8OJ2+SEjEkMo1dSn4KH+FkcsMJposMGTQy32+J?=
 =?us-ascii?Q?PnJXUpkx5BSDd1mL+5bim4EwvK+ugY7Oo0R/d8RbYjmf3WtPwEqYorayDLDA?=
 =?us-ascii?Q?Kh8KmEzr7+Z3WNNILEE1Ofk9jJPtuQ/gyy8kjz+xwVe3UMTo8NGgxadwQ+WB?=
 =?us-ascii?Q?dxfUuimIP6nLas05PDg2tqKlAGaxvasYBSwbYhjAPPDeJF2O3cWE0NDGeBYb?=
 =?us-ascii?Q?HHFPTefVnYM0/inomKmtyXhnuGavyAYBDldvBcKk+gwNAdZ93JZ/wye74JbP?=
 =?us-ascii?Q?252qDTf5t1UQhDdtQ9xaui9cUlckxWW4MAKnCETtm7hFrZbelM0q+YsyMSm4?=
 =?us-ascii?Q?mY9w8r+if5Ha1xR5bjXeYdB3cTWnMQlHbMdiE4gIJNfGzzsH4a1Idl/kBQTj?=
 =?us-ascii?Q?GiyPEtXwSv+TToqIj+Ur7ggItM2S4vXgpmqbQenojS1uNleXGAq/Fyl1aruj?=
 =?us-ascii?Q?RVyiLriQe8U7YO1894prgWlkQU/8NYZALzUa8H/bgKBpT3eEj5Wz9NFK3U/Y?=
 =?us-ascii?Q?mcb3AipCis4WL4j3aOxnr3fWAoIIAtNxaBhpK9oV/r95Zfq3p7lhDiU0MWmO?=
 =?us-ascii?Q?2no2BjlsyLrvJrM0wisfi0cFSDQg1quhBl3qh+6Q00UM298ZbISxvDYD5cK/?=
 =?us-ascii?Q?peszfj7I9Hni7hZjcjCF+ecoh02rVR6yFW7R1dZL1wB2+gbWOQM0T1YUj6hu?=
 =?us-ascii?Q?j0IZl0GyR6vkcjTGJStd6oMVXLYEsXypN+KK9/WTvGAgVdm4GWqNMJLLHEqc?=
 =?us-ascii?Q?PUkRU4Y9k/ZoPhyEbKMTCV8bVRXmQg+xkeX/ALDAFvCq64Cau/SC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2594ba65-cc19-4e93-c1bd-08dea2192be5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 15:50:12.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc8RpdInEUsWPjOBbt8oWY7Vv06+ngm+EeSGAiqqcYAROkDOdauLgoxTwy0sVB1318yBfTURUDV+DCwwl3Xtqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
X-Rspamd-Queue-Id: 5A461460FFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35281-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email]

On Fri, Apr 24, 2026 at 01:09:27PM +0100, Jonathan Cameron wrote:
> On Fri, 17 Apr 2026 13:36:11 -0400
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > The bitfields are designed in assumption that fields contain unsigned
> > integer values, thus extracting the values from the field implies
> > zero-extending.
> > 
> > Some drivers need to sign-extend their fields, and currently do it like:
> > 
> > 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > 
> > It's error-prone because it relies on user to provide the correct
> > index of the most significant bit.
> > 
> > This series adds a signed version of FIELD_GET(), which is the more
> > convenient and compiles (on x86_64) to just a couple instructions:
> > shl and sar.
> > 
> > Patch #1 adds FIELD_GET_SIGNED(), and the rest of the series applies it
> > tree-wide.
> > 
> 
> Just a quick heads up that I'm beginning to assume that this series
> will land in some form.  If it does can we do it as an immutable branch
> as I'm suggesting it gets used in some other patches in that should land
> in the new cycle.

I'm going to submit v2 soon, as seemingly the discussion is boiled
down, and then will likely merge it with my tree. I'll create an
immutable branch for you before the end of day.

Thanks,
Yury

