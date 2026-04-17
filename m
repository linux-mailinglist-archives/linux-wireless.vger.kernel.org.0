Return-Path: <linux-wireless+bounces-34961-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3pFP6h4mmv8QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34961-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 23:11:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B541E9EB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 23:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDDA53095467
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8E345CAA;
	Fri, 17 Apr 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DgEzk/xQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304C3290A6;
	Fri, 17 Apr 2026 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460186; cv=fail; b=YTsm7PYPOvqNhiPMpLT0Gh80YMexE2b4viLgaeX4X+ftQfnOXW4Fm4d8KNuFg+9xjibhW6tB9mBsw5LNHuubUAyk74JAg7RkG2NW/RAr34my614ri6BASuYp3aMiILczwRvBy1HBSMwzIYfhsT2khhz91sJ+KEiCf7/lVjRpzys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460186; c=relaxed/simple;
	bh=YY5k99HU0mWpCbQ2bSTT+xIXRGwfyGEtj7FPtFTgQWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EOQolwqubTbChWtqCm6DVekrNYTXhhfISJncuHYO1+iR8zSyALmxnaxSZtpXo6JHj3YJO2yzQI/aaVbHtuNkZHJ/sWVcHDiR1lLswHc5PYGLbVLU77aVILioKcSee5NlZzJpVi6anH36ygjbbO7V9CF1U29AMl5vD6MSX4ZxSfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DgEzk/xQ; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stwRWK25YCGF100Uv6D75KZ7yfbvhi6jgDCx/pcLneC1FvMtMkBkvyTMtwvKxII4CPEM3g9yVP0gRRL0Ghc3OpmEMq6CkrkyaZPd0lwYPED5o80M1OOfzVMuOc2ENb8yX8qgLCCztIj6enql45d3ChJtrZYbjNgGSzu4/mqhxgbVmnWFX9KYA7L7IEqTwG/gVrkaaL00s+wcpaYBYMLBi1jWBcdbT9EAWb84fsEqpDwxWIt+6lbYD0scG6s9KYNvqnXc3uIQgjvJceA0e3g8teCbePeQUME17+bFEA4pK7cDjh5szmvlF9eW8KcCWwkWOnfXTUT0v2wo/3laFlxb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHvPdN616B8CpixxuCmke86CzFx2S874uSUuj5XtshA=;
 b=WyIo9pGPOPzkut0qOvrsNc5nwj8a11jCMurDpV2UzOlCDMlsHaA8uJN27ciwOF8jkPXTQAvKX3AQbrVCW53RnKhb4UGl3thTgN4ddrJFGmKrs8TNu132Y3GlXwh26OVBYDjT2OE7JgBppIcdbnIVJcwtzkBmsSJMO5WilFIiRRAcIblh5nQT+Js/cWx++WcEN4LfaxYhDopzAwln8FWpD6e8MzMZhkfTi0kmACMt1I5KOVPJiSSGWAdZsCxqYdOA/rHgDk7NEIHRL+OkN+SY1JMfQ28S2MbRmGU/UQz1QnbDt9CF91U7D4sBbeKbhY/8U6+uNpOHp3O7skeNH+G2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHvPdN616B8CpixxuCmke86CzFx2S874uSUuj5XtshA=;
 b=DgEzk/xQjvCY+Asmvz46M5t5Tl4uidUqIZHenh4uh8Jo0h2f9DnthWclkpLt9islEbeLxYFN88aR2hGYdxLB8hHDwJ/7poFQ0yHnDtkCZA29nZFmchJEhrlCaf0ffjOAYBT8O/iA9KpR5db353JV5TMmG5V7jfg35cOSfpXCVPHqQ03ZaKN4Aanv/t3Kkc3uQ2jxe/QYgN4op2Er7sfLpWyT6FB8ej2FSuq1fnwzJWFFVtuNoKtaZlITIWIoBKeylGCYAlMcK6Fjossde6qGtNRizUjhlCBUu/bgHlFqxfTeyZY5/FZxsh5zeKX9ZNpA/N/L/emo7Y/lONazp8rZ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.48; Fri, 17 Apr
 2026 21:09:37 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:09:37 +0000
Date: Fri, 17 Apr 2026 17:09:35 -0400
From: Yury Norov <ynorov@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeKhj3W4ycqY5wPb@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-2-ynorov@nvidia.com>
 <20260417204355.37fd960d@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417204355.37fd960d@pumpkin>
X-ClientProxiedBy: BN9PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:408:f4::14) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be48ee0-159a-4382-2ea2-08de9cc5a1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RLr2SCxaFJPSMZ6dB59LzyU2eXiCGefLp9XzzZD5dwGcygxn4RqKEYdWMg6RV4IDbLRt8Vuj+oePnbEuZbUOrfb0m9A4hb/8gxfJ3Htog2tTC0/eEA286o331LbiGh9fPqI9ySj7eGLKD/77KmZaZXHt4G0FJdj54iYP3AEV1yc7//0KLcyM+pIbbMUj+SbJVqf2Jo+LFTRtPfMf/NGwrZr0F50tzbUMSftdvmpzGu6gX0EuqR3MMmQosnwT/M3QP383t7RiLAxt+jAN5N6ca8VUO7BoYbP0oQV9xH1PvE7Ozj1prvSGzQUSQQpTADOP1S1xQSm60WhoAgYPbKsnsg7R6V+MLEPsrcjxnWebD3dPIfCyFj9YqlCnq+QdjZ339GLNclvkGIZY5p+IcbRCGT4cmvlYvmEcy1iusO5x8OP0YnEqERxS8V0rE2tWUbONOZfTAL1/5Lg0IAa1zmXhzaIivlkOwuQuVcEemJDr8SJpUN5CFQfVuX5IkXxFE5dNOczS/+LxQMH6X4plP+n/aPoQycL4ZsjvZbr2Ft57Jd9OsuSTVV/P7qgwCQ/Jz3GTAW9MK2C6bngz+CB6O8MUj6UdoHG94iDhM3b/lvnYvdd6PvEP58hIi3i0c4wfqrtlEZVWhbeMLZn8l8lChCx/Rjybkd1R0qgZZ81rNQLPrP92pFvSDdWu2T9s3EXqTO8a5SA1zL5igAK5Mg5iw/S1LHayw4zpw91IJMLbZ31vmro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgJdau4ntgtKZsDJuKpWMEYFaDsEd8oYD73nYnRk2eR6h4hBJlEQf6qQOtow?=
 =?us-ascii?Q?3km5Qd+n4sVvxWKggzs1qjTcBLZpXbC2DYEtXZMXe4y2Yps9lAeACHbNind1?=
 =?us-ascii?Q?m5gH7VsSgjGtLLeYfKHZ9G/AgD9wIdBKNXFVAdwZaCxmuXvg32qgqQyCEHwD?=
 =?us-ascii?Q?7BkytXX6IC5bA7K3o8565y4p0oXypNfu8ITpCVEigrez90yEYsZSi22CC1An?=
 =?us-ascii?Q?DayeMJyepdjTzTH72AKwwStH37gh9DUBmybo+nrAvy/ZwsRzmk8DLmpEtKtO?=
 =?us-ascii?Q?6gJuoq2yQlqddwKjffMadqX8753MNXbmrYrW1nZ9GuGGCgb8a+3hTeTEyogA?=
 =?us-ascii?Q?vXc8TOlseW1phkbJL43bSKtvb8ePdehMzlAmO9PQ0qr0mZd8LCpqTUAKj124?=
 =?us-ascii?Q?veLP8Et36swzDhgR8AO1m1aNujzKFGjsiPPADOGqJbU1qLBh4/LPbRJP3gb6?=
 =?us-ascii?Q?96FCBxOJHrEuJ/6/CxkXsosY+4ZPf8Ey/z1epRuGL20LODAJGyFQHnx7otBm?=
 =?us-ascii?Q?XKiYX4u7/efQHOCwsBC6V9ekmGC0/RTLWNwLBzBgI+GjS7gxghTB6XzoOSpN?=
 =?us-ascii?Q?jw+6Hc001jT0GGgmNg5/+/hg7y6++YxOkAu8VkL9MOZ67rUy0zMU2GUif+96?=
 =?us-ascii?Q?Qcx09pthyrQYZgpZYxFXf4DtN8qfMjEUGsesv7309x5FHKb/BDmV9AEyp4Zj?=
 =?us-ascii?Q?26R1eEQbbVWvVQ3hskN9HH+vqSV1v3eG8n1v/3AAC+EDk89c0ckkCbkdAE8U?=
 =?us-ascii?Q?3xNxbrEqmwyXidBWEi8N7VQVphbdlx6Fgw+GlzltRA69ZhHx4JDNw0TSpQw1?=
 =?us-ascii?Q?rGjRyCkWDxs5pzQDz76J/HUmd94XrWkPk3wr8owGYRZCvWvDGRbUpNNjUm3C?=
 =?us-ascii?Q?EY88sO7q/uABA6MNPqNwJBNIG4I4HtAiT0ibzsifVGfrk5zLMEFaq9ol9iAv?=
 =?us-ascii?Q?GMiIxWWOycUG4zsQuIBTPrHyTxfOHv29TxtTHJqCWeaN4O1kqGnozMR3UWpd?=
 =?us-ascii?Q?H7yFyMRE+XQXWgFGNkXS+4vN04iYGAABW19751FwpUgcpJngJMObiEGaJvQr?=
 =?us-ascii?Q?lqe61+XR9t/q7w6D8i5B1/lc5bCS/uTOHTs7y7+NIWyU6Mmgf3LXkSvmsxLD?=
 =?us-ascii?Q?RrOhf54G1bLt8pEdwo0FbUSAvL22cE5AipLtrSnq0RBY58WoJTdXvWxa5jIf?=
 =?us-ascii?Q?dgDfaaABoUAB6YAO1UYfhLtxkLkt5u9hfRkKuljhpioqdkF2Iq2d5uZEU+ax?=
 =?us-ascii?Q?IB3FZzgPKvFHRthS0+MHE7eymR/ePYJaRhfjobtMcYfXTXc2C+EuO7LptlJB?=
 =?us-ascii?Q?af/5nx8ZEOggtz8MD9/3i1ef1bqDQK5l2Aa8++BH6K41WJWWzMln4kb7cYEb?=
 =?us-ascii?Q?oMOA8vufq8b9ppmhq5AohfD3G0LB4VeTz50PGKNW3vgi9sDL6wyLVE8eqYuO?=
 =?us-ascii?Q?v6JGwseLzU28hlBghV0pFmOIIQV5EvW1dz+U0jnoJcCkUHk4f+aHUDT0LfEy?=
 =?us-ascii?Q?uyxjze7WfBg08oJU0s6ALjTJAbWl31i4FsUDmBIrIUyur6vpAidg+vRvI71x?=
 =?us-ascii?Q?mHdC2h269KjLD9ledBeWv+jd/AWgsMFh1Jw/1DjNzdnGL82r8Hh5K5hR7Oj5?=
 =?us-ascii?Q?3lpbP6V5KYNlA1LnQUnqpxKZQCUme8ssHA42rITQbwv5LyolLW+zLxoI2lAV?=
 =?us-ascii?Q?hUQKyhWYrVP6y7BN7QiiLcgIVc1KkO3vCwmRQtHS65GVCAFwGxGwsJjS3mbo?=
 =?us-ascii?Q?ny2IkX0+XSd/gxDX3zG9cDaLwgmfxbUSdZT0KU04ZtdbPI6gLlRL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be48ee0-159a-4382-2ea2-08de9cc5a1f5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:09:37.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TV0Bi+ee/xAZAiV7ZIelQMjv09RIg7Ul8NeBwWcRnfll05I3RsgqzfHXKAsPVBpEFj71Wn00PhrGMAIQf0FzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34961-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,godbolt.org:url,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: AD3B541E9EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 08:43:55PM +0100, David Laight wrote:
> On Fri, 17 Apr 2026 13:36:12 -0400
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
> > index of the most significant bit and proper 32 vs 64 function flavor.
> > 
> > Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
> > convenient and compiles (on x86_64) to just a couple instructions:
> > shl and sar.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  include/linux/bitfield.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > index 54aeeef1f0ec..35ef63972810 100644
> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -178,6 +178,22 @@
> >  		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
> >  	})
> >  
> > +/**
> > + * FIELD_GET_SIGNED() - extract a signed bitfield element
> > + * @mask: shifted mask defining the field's length and position
> > + * @reg:  value of entire bitfield
> > + *
> > + * Returns the sign-extended field specified by @_mask from the
> > + * bitfield passed in as @_reg by masking and shifting it down.
> > + */
> > +#define FIELD_GET_SIGNED(mask, reg)					\
> > +	({								\
> > +		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\
> > +		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
> > +		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
> > +						__builtin_ctzll(mask))));\
> 
> Have you looked at what that generates on a typical 32bit architecture?

Yes, for arm32:

  #define FIELD_GET_SIGNED(mask, reg)                           \
      ((long long)(reg) <<                                      \
         __builtin_clzll(mask) >> (__builtin_clzll(mask) +      \
          __builtin_ctzll(mask)))
  
  long long foo(long long reg)
  {
         return FIELD_GET_SIGNED(0x00f00000ULL, reg);
  }

generates:

  foo(long long):
        lsls    r1, r0, #8
        asrs    r0, r1, #28
        asrs    r1, r1, #31
        bx      lr

Just as good as x86_64.

https://godbolt.org/z/eMnKrnocq
 
> It really a bad idea to use __signed_scalar_typeof() on anything that isn't
> a simple variable.
> The bloat from all this when 'mask' is an expansion of GENMASK() is horrid.
> Indeed both signed_scalar_typeof() and unsigned_scalar_typeof() should
> really not be used - there are generally much better ways.

David, it's not the first time you're throwing "bad idea, horrid bloat,
really not be used"-like rant with absolutely no evidence that people
do something wrong. Today I became another random victim of your style
of communication, and I don't think there's any benefit to tolerate it
for me or anybody else.

I encourage you to change your attitude, and use professional and
specific communication style in the kernel mailing list.

Starting from now, I'm not a free tester for your ideas anymore. If
you think that my patch is wrong, please prove it yourself. If you
think that 32-bit or whatever code generation is bad - please send
an example. If you believe that your implementation is any better -
please bother yourself to convince me.

I will continue receiving patches from you in my tree, but if your
patch is claimed to improve code generation, performance of any sort,
or similar things, and doesn't provide any numbers - I'll not waste
my time on it.

Thanks,
Yury

> In this case you can just write:
> 	({
> 		auto _mask = mask;
> 		unsigned int __sl = __builtin_clzll(_mask);
> 		unsigned int __sr = __sl + __builtin_ctzll(_mask);
> 		__builtin_chose_expr(sizeof(_mask) <= 4,
> 			(int)(reg) << __sl - 32 >> __sr - 32,
> 			((long long)(reg) << __sl >> __sr)
> 	})
> and let the compiler do any more integer promotions (etc).
> 
> I'm also not convinced that the checks __BF_FIELD_CHECK() does
> on 'reg' are in any sense worth the effort.
> 
> I have tried some simpler alternatives, eg:
> 	!__builtin_constant_p(reg) && statically_true((reg & mask) == 0)
> however that throws up some false positives due to some of weird ways
> people have used FIELD_GET() where it is nothing like the simplest
> (or most obvious) way to do things.
> That might have been the code that split a 32bit value into bytes
> in a printf with:
> 	FIELD_GET(GENMASK(7, 0), val), FIELD_GET(GENMASK(15, 8), val),
> 	FIELD_GET(GENMASK(23, 16), val), FIELD_GET(GENMASK(31, 24), val),
> 
> 	David
> 
> > +	})
> > +
> >  /**
> >   * FIELD_MODIFY() - modify a bitfield element
> >   * @_mask: shifted mask defining the field's length and position

