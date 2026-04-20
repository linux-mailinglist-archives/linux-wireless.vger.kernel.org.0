Return-Path: <linux-wireless+bounces-35096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MEvCqRv5mmBwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:25:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABA432CE1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFE4A307EDCE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0C3A6F17;
	Mon, 20 Apr 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDcXlw83"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE3612E3;
	Mon, 20 Apr 2026 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707708; cv=fail; b=G66ILxDsef5t/79JhcesIW8h8rpRQIbtItOGoYW6HOvhwcgvKHil7YZIjfQlEq51Eg+ysjFJU7B5uY+4xKPLhNGfGdSJ8uwG1gASBXBd4rDkmbCKLL4aBULsqcNDRSQjAWGoln2mcjrVDJ8o+nM/LlKvFoRSw70bgSCcOx5oIXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707708; c=relaxed/simple;
	bh=PbyzC4uTmY/CXzBM8PL+HK9S09luCuvf8cqhiWG7r4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZWV/tYx3bK+9KgbUdNbZbt+UMUuYSbtZQADWGxfh83l9YFsWgk2gMyysYOa6hiUYxQ77ngKh7eTkm9zOdkLBPnYEba2syOVrKjBq8HcZHQAdvpzGSlpzhz3KX+vL+Oh7o0JhOGibvq9xBGz9XT6mUqnG7NdCVJRs6XMTtgwqKAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDcXlw83; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxsTCmDmjnlrloD3kF2uMt6gkgFzuPQJHtg6HlBs9AOt3BYPalxjfGWC3Ys6KPeAXtlze57H0uRBGYlUlItflDRH0wbmmxC2dVqF23fhBAG7aAwcsBxFgcwwgEt1iV629HojWXTqRE5y/1RQQofndef1nWNaKe46iIHD4CB33Yj04GNCEdwR6hD0nWX392YYw4qhOajEXl04sd+zECBoIAUQNeN2HkZ0ln/Aa42AHub3+pdAX5nUB4S/a57t5wRPlrXCGmPt4qtLH1XZW3tHCz03iSgY36pSzQaUtaOnfpeoVGWeSMbuxZ1Vsg1LsGXIMQ9KdnoxwM0kSI8iYh149A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnJiOWIuhtNcLl6qzYIKPvPf+cek8vOqfmOOXtbXFqw=;
 b=tSLPFmmPk3A8H/Cq8R07N5vxt/caYEATxQg0KwlbrONXz716MoaaN9DAbKMQy4Nq+TGhFieXA25uWY0krckM0ET6xl+rqpLI/ZC4Br7vXNoTvEMIAjUO75s9pOcjCNR7ZFCJl9xUjlODXwFcBsP74nhP+zILN/P3xZ7Tgp1Gd35XGluzLcoiwodVtayMo9weLopSCmOx+wgcxx8UZE72Qpdup9OgnRCdTYwKQ/puQnYkeYcRczf3JcluMQmtSkAkz/w9si4mMkie8GVf13ffz0+7jMcYHFi5VFENzLkW8OXRgBmo6gXfsNRbO0VGjsr/Zn/Itj2Gq91+0ypM1Rrl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnJiOWIuhtNcLl6qzYIKPvPf+cek8vOqfmOOXtbXFqw=;
 b=IDcXlw83bggk4dilma/5X88NFTuUsPy2KkjT8fC7+oflm8gksO9Xm8O8KkH9nMoZRGs5PPp35tA10uY2nC70SQC2I0MYMP6ZCcpJquNMev4nX/BO6BjFLIdpyk0idGqNsbXpLQ712DTDQbSweHhSMA/q+YI+05XDtfhsVr7m9fN3i9CVC0Boodvc5s5iAiDbkJcl87hbpliDJFCbT138mhiHqUHeefYgiRZlgM9UXB03/Ykm3ekMXLoWZM66IwWhkQFu0me5IPhyMevautAa5m5KqEaBSNxYa8bPl85Xj8VXdrLf1dpHzUsFR2M+OTKc7AWuqF6s63CnPMHOkXwzJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 17:55:00 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 17:55:00 +0000
Date: Mon, 20 Apr 2026 13:54:57 -0400
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
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeZocbNjbvzMZO8b@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-2-ynorov@nvidia.com>
 <20260420111940.GE3102624@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420111940.GE3102624@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BN9PR03CA0777.namprd03.prod.outlook.com
 (2603:10b6:408:13a::32) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 757bf9c5-3e53-4f96-18d6-08de9f05f101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	py/mWeCgLHO37l2SNasqlGnmWdpioTjKp2rUwTyI2GTU5oIvmnFiy8dvXoISPLlHzPS8GlBchKLW2qfhMWmcSw2ixvNid7XwuZWPEQ0R1iQP6MaNxe+DvXs6+8C2TCXpS8XUDDSe9yMB/Sa36Zl11XHUml8tp/rh5Ph3HgPx0jyWr2iS8viXGasqJXXD/+24Ig25+HnsJlNCylWfCQnWu86A0PwWZXqT0gsf5rWq3ps3JEnTlnlrBbwb+EfWfFL0YhNSur2iaeE8Pe++Yx6JMrBrki3dUYfBtq73+AhUypIIU+5Rv1m9bNoyff3BkdLRPnUV6lD2l7fQ53rhWlJsJ4ZaLWf76JOQlI+bepb7UixhT2M5OyK9/U/pLOwPzCmE/+svvS8rVEtRe6Nuu+B2huz0LCZYzxrL2CYgRUnnTJYfxwMzDAcGfwgGMu+lWKNdIe/alCTwVdHLqc+nh8CzFRG07IlHBA8c4vAkFt3o1Dc+G4WYQY9J62kEF/efEw2Ofvzkf4id+4NUDaMLKEdNksmHU4VwkrColYBe9UmatVDqY+eNUICEtcDCmZ/Lm7fdALFlSr994UHpYQXdky/+KQff60ndNQ7MHQ+jmPecZFl1fniTy3o80Efcjc43rk0sN20z/QdGFBu8jal2WhJaTjdT3tcVF66mDM5mGAkAinFASbEe2Tq03IGVKVGr4wuXFIYwKFd2nwwuZ4OiQzxDxUhta2rvSD32H2Bl38mwrGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHwJFZ5TtBao77wuWSrGy3a1I98HwauB0CHUwUML2lp3J1rciU74jGs3bOFs?=
 =?us-ascii?Q?yuivJzNLZ7yHKB3zKiak0LIJbLHzZQFytsP/hEXryzxk96PVdgEMv9VGZ9DC?=
 =?us-ascii?Q?cINHp89C/PMFCFnLl0rOeJQDTRheM33/EEabe3QcLPKuCo4b9qiKtfMuNIjE?=
 =?us-ascii?Q?Tt23DJs60qZ0nh5+c65v6cJMc7+di7rEaIzCD3Of2tIXfQCEzycZUhDXCQxx?=
 =?us-ascii?Q?rkfU1t7sbwFu8D+sihCs54LizirPAO05ZT93BZ4fXUcsuZoRs9aBsvAph6Aw?=
 =?us-ascii?Q?xj30mSkxFBzXiR34P7bpEmNJuAdK3dNCrBd/WT+wuESKzx3CTJUFbNs7l0kj?=
 =?us-ascii?Q?a6Cv1R2LLWLRRrwrPrMS19wnrmAuegRmoHQ5lCQ0rOEk/k1kM5O44mqjr+5o?=
 =?us-ascii?Q?AdyN3WKtbKU0tflZUhhtS9+DVE7O4fMJl+7xlF4wlBNhlIYbAraynjf8xlix?=
 =?us-ascii?Q?q3yxHhAHfQIqrUZ6FyT2mpNvPeagaHOhzqIT5eA49L1CXv6b/gmnS1nJYZkS?=
 =?us-ascii?Q?pxLZl9jPaFogVnqg0ZSJ7dQzDY8drRuaLDUC/V1Sq2Ol1+WAhS5pFKFRlPir?=
 =?us-ascii?Q?dYTT1QvA7uDvdbWp2AgXpVUDO4vBgDWDeRfJ1wtwrOtiC1CFcopZqWnLJXWk?=
 =?us-ascii?Q?ej1ko2HDxsD37eGmynWgo4U5uJ698WB+P8QVxbuCFp65SktST8hmQg6OqSj3?=
 =?us-ascii?Q?MsGZiLFApAAHDiW/UYvlNNC8MFallGP+fehowQAkSzfSIu1jL7+rsU/H1JPm?=
 =?us-ascii?Q?s11ku+Lel3HodbQ5/TjrdGDxNG3vQV44aZPLUuEJRq6ciw2RSoKNrnW6I0X5?=
 =?us-ascii?Q?IU/JYDh79UqaT9nBkdmCGo8POsqsFYoCyoV/p3IqC2ES9Q4mAblMYnXoFPQ4?=
 =?us-ascii?Q?QS3I0GRNdgTQCZET4WtM1JlfzWcc74yEf5uOioikGDz2BJVzcpP5zxBP1dkb?=
 =?us-ascii?Q?HHKsV+lPhlT+zgzWZwfsJHPQAIeLJCoM+NwGxBlT4AfoyX+bQXDYkb0PTprr?=
 =?us-ascii?Q?76TKl1VWcSYokUCLAyIhlc5h3Jy1AoHdsooNpt6BVUWadnz/AAoxgDc3BWRq?=
 =?us-ascii?Q?x3pS/EoQDywy8HrdPUeSFI4KJJsZl0h69OLgM8M/Q8sShGtpO5LLKlL0IqW5?=
 =?us-ascii?Q?Lgw/8Unm7q8bV14ugzNFCL76tziLU+hojm532OaHlHuIXGGWCoJAdkZjM2ii?=
 =?us-ascii?Q?l+Xf5XY3CmAB1juJXaaHFJ0Ol86+Qy3jDSsW69kHRHbDXjeNcyCOfhc/Z8x/?=
 =?us-ascii?Q?FQczWzE8hqLU7RfS5Vuro+J5Q04LpxX/3nuic0Ye6YNfamzqjn4re8BEMBhC?=
 =?us-ascii?Q?aVCglEmCoadzLJJUBWwfpyYNo8vRuEbmvBXxdhn6yeuxeAeAUM/0IIbmGVZK?=
 =?us-ascii?Q?2WvtAj+XgIiGy5xGt9p6P5V+c4iNYu2Nu802ts5CMv1UD5W8WQDaMnsl/lgf?=
 =?us-ascii?Q?3se0uLXdNNCWXXLJO0s3ZCp8ofgJITDBtPDop0q2rJrQfGxYkOQIrZsEnolO?=
 =?us-ascii?Q?usV6FjRqGFnswJ0XvhqebFBVisw036LxjMr7kb8esTndTsdLqw3PBabYITHv?=
 =?us-ascii?Q?Xu4sLFXzvAYmQNycgkzleWK2RyUMki0B9JVEj3aut59iWpM+oT06w6X6/jIf?=
 =?us-ascii?Q?Yk9/W1MeZp4FUzdVF3bhufNp+w8ANQJxOB6F47Cqsz83jeYXWuOyKSYqOf+e?=
 =?us-ascii?Q?dw8cRSmY95+44x6FVHnrEGXNW9RxacPHUbSnZZTkAxOkhCGX1jhoYXSDzVyZ?=
 =?us-ascii?Q?r8TZZuGbgub+JMwmLuNdrnvbLoiAkfWS73yNWlBqoZz5raVXQp2+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757bf9c5-3e53-4f96-18d6-08de9f05f101
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:55:00.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRF5JMAbfqelYiSL29Lh/qYmW4kLW3nOsgmrCfKcf5gOGHVBrkVEi31veRSjTemNVYtB27MfKINzdpC2L2rcEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35096-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 76ABA432CE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 01:19:40PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2026 at 01:36:12PM -0400, Yury Norov wrote:
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
> > +	})
> 
> IIRC clz is count-leading-zeros and ctz is count-trailing-zeros. Most of
> the other FIELD things use __bf_shf() which is defined in terms of ffs -
> 1 (which is another way of writing ctz).
> 
> So how about you start by redefining __bf_shf() in ctz, and then add
> another helper for the clz and write the thing something like:
> 
> 	((long long)(reg) << __bf_clz(mask)) >> (__bf_clz(mask) + __bf_shf(mask));

So...

I like the shorter form, but whatever we add in the bitfield.h - we'll
have to support it.

For example, __bf_shf() wasn't intended to be used outsize of the
header, thus double underscored. But there's over 100 external users
now. And to make it worse, it's broken for GCC 14 and earlier:

https://lore.kernel.org/all/20260409-field-prep-fix-v1-1-f0e9ae64f63c@imgtec.com/

So needs to get fixed.

The bitfield.h has two __bf macros: __bf_shf() and __bf_cast_unsigned().
They are thin wrappers, but after all do something with the corresponding
builtins output. The __bf_cls() would be a pure renaming. I'm OK with
that, but some people don't:

https://lore.kernel.org/all/20260303182845.250bb2de@kernel.org/

That's why I didn't make FIELD_GET_SIGNED() implementation looking nicer.
If you strongly prefer the shorter version, I can do that in v2.
 
> Also, since the order of the shifts is rather important, I think it
> makes sense to add this extra pair of (), even when not strictly needed,
> just to make it easier to read.

Sure, will do.

