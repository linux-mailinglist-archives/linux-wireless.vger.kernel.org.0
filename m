Return-Path: <linux-wireless+bounces-35089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBEfN9tx5mlgwgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:35:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 695AC432EBD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BDE3320AB2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43523A545E;
	Mon, 20 Apr 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TvbCL33V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F839EF24;
	Mon, 20 Apr 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705542; cv=fail; b=XzM76vQ3jQaPRIdlaam8TCBSmnXqyX5v7Dj1WIHvqi1N+Wt2O/Bdact2GFnnen7QmuHJ2u6lS0bQBzz3yAKZrZrdANFDJoK0/AHQ/erZko2ZtO1qrV3FxPK1y7ISJmGBW1gDfhdfIzZBHWNcPUq/ayL4By4bJBGyhkvSJhaAqfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705542; c=relaxed/simple;
	bh=zk94DVxXQajF7WUxKBY+0Y+o/avPNeYUdpHBwKnkDg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N/W0PQ5L+aEDm1Y2fZlXoUNvEZEislda58nDJg2ZE40JeJJ3kkrEObxcfvcdsfGb8+S2FjZvPEUZ8adf6MuM88HuCPL8KkbKIDT+4JBVPi2zdfMZlr23e7ipCZRSyiVK6RbVaMPzypDUymmmKQ5Oi6FYsyf712wENKgQmU9pe2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TvbCL33V; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imdJblyrCxlWP/7nCOzMLRA9Gudyxea99qIzGZWZ1aDR9Qn5MobT5fh3vRWieB+4XcghspD9RItNIFxGaK0pokjopGKmEM/2m+4zqWfGqjumakHBLuWpjbgUiNMk3022giJ6La1SyPLnyGKDTPuwwayMmONR12egp7GiUYNlO8NhoaNC164sW0NmeL8Z9l70KZd6D8upxlqOfaAEgwo8J32o3Xa1We7EL4u01VbBqn/s4ntjEP/tQ5+50A0uLg3oe/1j3TiZp8OC8NornKcZY9kPvPgcEfE9S7/6XwrsIITvQ07P8p36osMhEBBc3tD/Tmc1r0Q9wfjOvm8jj5rKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfFKrXSS9tiex6yhLS0QNx+g1lPvzCG0k+6kiieqWIc=;
 b=eYwPrqpUELy9tuyr38TyZtfkkg/xzlDWImeRo7fLoCHahQXY7Jdj+FeEafUBArzzRzw/s8iewY+Pe7TXYU5Z3R51bICYv+CrTeN1UQjlshElH8fPYSsO2U4CvD8U6sVw5jL/seKS5ANBRHMITXGXThwEntSzl+UAqV6CsoqGjN8XkiNVFF2KFp8UfoS3c9VAJMMqa0d2H18F0aAGtPfo/jI28teZLnGx5gQEm+3hx4CBjAtnSraPkcybmYwzSgcI86noIR2NmvMfHs7fOuAJv8u//h1eR4DSP5ANhJkwZxV1kEcUi3gEbuVkgMJr56WIyNHCbmBTlV6Ol+B6/AfcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfFKrXSS9tiex6yhLS0QNx+g1lPvzCG0k+6kiieqWIc=;
 b=TvbCL33V0Ix1mC/LaSB3OVB+KyHwsmANSPEvsgzYEwlwJZ7qPbBhqM8JdbyTY1IX+Uzs6tu77nn7hefIVMZV3Z87Za42WqMSW50e1ObW6r6zgipMsHU1LSGycUrsNSST82VFIcTUSs+0F+kYv7syfxlT7resewbelyM0hQ4dEVqgYG0t4Ok0sx+SL3W9jOPDu2q5WaC6je6ZkZM2HHg/wJbXilEquknAlhJfPHNv0mxZWCJB9CoSzhHLuHPy729WpEZhjDNmilSyx/aX0xokOWV2zT+/jsEQcHpBeXrYAxtVocw7ZRANYeJF0MwlOQCUaSNuE4zooUn+L5zG5VJZPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 17:18:51 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 17:18:50 +0000
Date: Mon, 20 Apr 2026 13:18:47 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [PATCH 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Message-ID: <aeZf98xjbxdHvZOS@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-3-ynorov@nvidia.com>
 <20260420112428.GF3102624@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420112428.GF3102624@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BN9PR03CA0534.namprd03.prod.outlook.com
 (2603:10b6:408:131::29) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: d91ab5b5-38fd-4657-3360-08de9f00e3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bnka/t5iWtLD1TH2lFaGW0uVMOMlt1n6H/gM4lfYDBSwKEDDTvUntUPVbmHRNKzqlI9EK76GXi4UXyzLfawy+wqFwGA1SKtUKUlaRIpGkw19VZFJfMyaGID/DlpE37tIZNVEMwhR7g4DsvRa7Hn1W4iTaJm3ZObd+PwCfPWGZG4mZyg9WaD9sDV3TDPsxd338oA7JXB4kuj2BfXGvPV6yDNZLw7S3t497mc8l7Zvhbk8JUNEBsh22EFQVT7HHP1XdC98v5/H9sUXjHTztC2kylTClIInrb/I0EInX/1H5VHO0U/FCqANrNOTygNOQ6R49pNJuPlPTOlHBajep0uUXEoZmcSi0ix8SeUoldEVgP9ehjmRTxGvVI24mMHdbgayCh4ZWR1qnFC6rqn2i41AerPWm8OaZOH1JtZVKdtAZ3J5RZed3UEL28pBSf77wI4iFiT+m4OQMpBDwfRdglC/dhxinNS3Pk6S3CpUl8yB9HGkLEY8h4v2awRiVjwElGvAlqOyCDtP4NrQxDbRx8/IoDYAVWOGN+wEAg5GsruwIKrvWNMFJg0331FKj4jfqJ+cYMUJp2WNHA6VoE5LH4JVl/JfsydNhN6OU9JrP7gFNkBl65QuKF9MdbaO8KoYENs2GCA595gUEN1uQxBVANYMaQzGEcu/8ybXxgoCjnp9SnmKahjN9oMdVHe9jIB9F42W2dUKEl+k2Ee0wNR+2GotQ/1DQfxstw9V0j8HwhwJIyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaGgMEXmLRwziiFusp0H4L32/47qS3h4g6Hkp5zuG2aLbdfRgam3ARIBxMeL?=
 =?us-ascii?Q?D/1upMoSC2oBnkN/Kv+w3mtVEE+6+Yh4liEywH6deo5zHxGvjxBPDjtGcQon?=
 =?us-ascii?Q?urk7UGXoPCp02ROjt++Z8s4o68Uhbz9jA06AXCBQCO+jN9Jwof5m40/aIX4v?=
 =?us-ascii?Q?9Xn5YWa2kzN1bJvF6Kh8UxPh2B2yZZWxTiC10wbPP8jbW9janLjH7cbe0Ydu?=
 =?us-ascii?Q?pk8gDhEhXAofGT3c4biN5e2npAsxIDLp12ai2z28caaVYY0HvjHnNY1Hx/Gy?=
 =?us-ascii?Q?vX5ji/N/qkHq1pTsBK0lA2iJYDrHvalpCiJ051qojSksnoGYqjZaGebrennX?=
 =?us-ascii?Q?rEJyvfSWReYPmSsAQJ9He99TG4/qP/LTLeAHtQncGSZ8y4gEFhLvKKJbQU3P?=
 =?us-ascii?Q?8SNs9bhQL0bGV7tnH2tZSZhOoNshUDri78RwD2W6PMBnWOj6IShxYWwahfhZ?=
 =?us-ascii?Q?XO0/rCj5yidNpynmlo+O5YqFR8jyjYZmonV2mGIcQ2O9MCwMn5dVP4kkCHSl?=
 =?us-ascii?Q?f2rlacz31ILKkTYn1sWHogUTcclFDiobtHpMsUKiBIQsSF4XR7v2LNHDdu78?=
 =?us-ascii?Q?c4wXRLChGb+0zK3CCB8SrMgPE5/lHn3DwdeQ/tr3uhhxzMrr8g18oGI0gZ6Q?=
 =?us-ascii?Q?XKeQZ6UwRDbwwAL5IF8Pat3rQ6Di8vbRLH72o8clkFB3Z5IgLeKVLPabZ5ec?=
 =?us-ascii?Q?nHTC4f9e90+/9I0z6UDDTFF3QLWVnmwO2W/SS+rrNx+HIP3fZn1pPuoiHGoL?=
 =?us-ascii?Q?BO+ZMgV1ygVXE0txPDNooGTM2VH3AopJItAudmPBvWSofczwPZCStqmcNck9?=
 =?us-ascii?Q?W+GoTueX9auMmDf3sJTFf2pYm7GwbklqeTJ97L7mf/GetEsIYCTLWyeuGFDT?=
 =?us-ascii?Q?vtCI5HBgaGBmzwiMyD+ecX3/9rXZUwTRkbLdLVoIoYq0CQt0HAbFlnigdVdG?=
 =?us-ascii?Q?vHUZXsmAlre7UYikqP0Q5YSNzY1mlT5D43y4LNl3iZPz1xVk6VfygAPL9EdR?=
 =?us-ascii?Q?lfqzuvKRC3IynMIwrRgc/GI9DzYoOrpmFMDB8yIjqEj/EAKS+3qs+lYoz2iD?=
 =?us-ascii?Q?FBFeaoUEhjKcL8Ia0v3VhX+eSAJ6h7kkegeeHtwQO9n0ygu4T6OgZ6FdxFaM?=
 =?us-ascii?Q?UuOFAW0rK4UMyYZmV4nALKwd6QaKGR4Gtoid5hJ2pSJ7Ju5dOp6qxhGdHQ3n?=
 =?us-ascii?Q?IvAGKKLfOtIYhcQpeUucaK6pd+bwM+lwoyPvq8Ddpq4et0PlveDpAIzeBqRB?=
 =?us-ascii?Q?wJX9Mpfck/sVhc9wOKzNbO75qNwaKNwS0zSi+o9hC8IuykotlQou2YLoqUvi?=
 =?us-ascii?Q?/xrCVZqGkxQ+T0Bnx12HGEmGvUlzY05Ezvj5yMeBJ6UCwUxXR9cvc49AT+nt?=
 =?us-ascii?Q?dYD63HYfe4tY9xr5BLICQ5ynGbf+/FlwMVNVIVBHNc2XCicbTuSbGXSggxG+?=
 =?us-ascii?Q?JhTda+F23umf8xQ+kw4uo0utr3XCjprljlleV7sGq5F8VThLSyjg64V5JYJn?=
 =?us-ascii?Q?RLhwO4vFctU8HekHyClFFp+STnKbDCrt9O96TdS9GY3VsW5HXfBB9gU15A4o?=
 =?us-ascii?Q?3Kz5Ri/OHGTWWuoJAY4UJXgVMYf/EYa3NQyxz/NieGH+JquifdRksj/DN4tN?=
 =?us-ascii?Q?YieZn1J7wDt26WdACaywDhrD7GufZG7Aggtp5j+0QB798nM2+wOldJp/t7WO?=
 =?us-ascii?Q?0XbQq/9GjytAIE+G2uJAyBqYoMv3/lBKrq5JA+b3SkDQsAh5mqrIITKwrVVX?=
 =?us-ascii?Q?K6KjGdhFkpxcICQflWS2xNHZtiWePStZ0DjQsa3FmY4eUpGkeGSS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91ab5b5-38fd-4657-3360-08de9f00e3b2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:18:50.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lM7ddb18+HP3bgScKNUdaza7OyI5IxZzsHl4ONriv0WDT1nOPLprqKsH1LMKi3OK/zyvny1cgLa+3rXOjzmfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35089-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 695AC432EBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 01:24:28PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2026 at 01:36:13PM -0400, Yury Norov wrote:
> > The EX_DATA register is laid out such that EX_DATA_IMM occupied MSB.
> > It's done to make sure that FIELD_GET() will sign-extend the IMM
> > field during extraction.
> > 
> > To enforce that, all EX_DATA masks are made signed integers. This
> > works, but relies on the particular implementation of FIELD_GET(),
> > i.e. masking then shifting, not vice versa; and the particular
> > placement of the fields in the register.
> 
> I don't think the order of the mask and shift matters in this case. If
> we were to first shift down and then mask, it would still work (after
> all, the mask would also need to be shifted and would also get sign
> extended, effectively ending up as -1).
 
FIELD_GET() doesn't require mask to be signed when a reg is signed, so
shifting mask may become zero-extended in an alternative implementation:

        (reg >> __bf_shf(mask)) & (mask >> __bf_shf(mask)

This all is hypothetical, anyways.

> But yes, this very much depends on the signed field being the topmost
> field and including the MSB.

This is the part I dislike mostly. This would look just like undefined
behavior for the API user: depending on fields placement or type of the
inputs, sometimes FIELD_GET() sign-extendeds the field, and sometimes
not. 

We could likely force FIELD_GET() to treat both reg and mask as unsigned
types, and state that explicitly in the documentation.

