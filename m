Return-Path: <linux-wireless+bounces-35283-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAnHLv2b62naPAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35283-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 18:36:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2447646155B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC5B300A8D2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9243CF050;
	Fri, 24 Apr 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxGZRanX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE541D86FF;
	Fri, 24 Apr 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048570; cv=fail; b=i3ce28oNwhDYwdIZMU9TreII7Nze9hBGHUjjJPb1djsR38xHvMCon2u1jAWhfNlP3M3YxCc+yYPr29Ivu5rp7uFHztnwvsyPRRTj0VVDpuXb3ysqKX0UUweYn/zIpVhFQKK1kG2X6//ls3XKkUovwOMSLU17PXEr/k0+7kq9Meg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048570; c=relaxed/simple;
	bh=rtqEgDEg0wYwmodn5b0xuw/f/sCyQK8PHl0fepZNzgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f8ISj7QxofR7Y55jsfnJf6Jv8UoP20ymVIKpPr37KadLIYXWRssQfM70LHezeuVL7gX2suWCrXDpy/zgbl35/AXEB3eEyNQsnzzGLCKhIrXAXzI5981yQUSffEx+301qOL6EgSus8iDEaD7Rj/1ijos/j7/IlCMYBXFBiS0Da6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxGZRanX; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkfpVRbVolm4i05TrER/BLNlsDVryYRPpMKMDAahdSWV75HIVh61JbOdtfTHNqrmGhYr338UDKJLpfFvC/DoqyuDlOzTgBVPMwaaQ76ZVh4B/uAwfZD4Qb1/ugp0cKFZTaOCjmDsAkWwN15qaOpjBQjNaEqGgU7ziSdWl4SuEcGdE7Guy/Q6jJgO6+HmFzO1BLOXV/21ds5IfUk64dx33453Ie37Pe7nMzaJLnUfeWR5pA9742uXEywgVs+ylxGOFeKOrsGro5LSFS1WuoZSHecOTJf08rCBI3SbHG9QKFlUWvthuh79yn7soNdQPLUnnoK9K+q+4QrnI3RNE+RJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLYvFsjOjEovp7bvMElUOz+ZB8S9t/ziyB2zy0jC6Gs=;
 b=YYFhNqItJu3HnpFmPJ69oBqsTzS7XeLZllZ4Voppwgw7D719kXBz9VDhHMS5EfLhrmqFeTy+XJzOwLPaL4cd5+N916QeoSE7DtKNoGYy0hEbus3j5FQ/dttjXjlmKM1o0mnq0v1xzXDMKsLXdSLMZal+Q5rd+8DKXHbZKzp7lqSM6mCertdABElV1Tz55JtqmBQj5uVVoWtokxYnicQqM+O4Jk7/W+C+uJ3/BTfIN80NVnDFIhb4g3x5lD9QrFz08+buCGeZT2AukQBtMbHuQkWE7LGqDA+dOIuaRX085ImYpoxEPr6oPIr/3TpD8kuv/azGAVjRRjmSLjRJt2r8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLYvFsjOjEovp7bvMElUOz+ZB8S9t/ziyB2zy0jC6Gs=;
 b=VxGZRanXZlsiTU39hQwFKZYhNopwhVYB7XYhdfDtDg9gM1OQdbaPxWLUM4lroUBN+39SVyw1y3x22/zZnDxy4ng3BOWd4CHy97KuNWjZuRU6rHxsOok4QHiLFMi8dsc6d2RVqQdhgjMEMw68dpTlhnQvKX/Ysl7xkYG1XkGE217l0mGOepcJ7CdPQ/J+PwrFOArVxmr4qayuHz0EQKdANn8pb1SYOQDfoS/oI1bSIZ6lNdg7n8NDnarkPcAKK+mnHXuy/ntSu8I/LwgC9UDPCrAhwS9150Y2SODtMijaTJ0KYbWR1YW1YXoNwK3zahBbk3ktMZQmKv4gT2P5D7XmuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 16:35:54 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 16:35:54 +0000
Date: Fri, 24 Apr 2026 12:35:51 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Johannes Berg <johannes@sipsolutions.net>
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
Message-ID: <aeub59FBHbCy-KKP@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-2-ynorov@nvidia.com>
 <6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: e61c90e6-18e9-4ecf-6232-08dea21f8dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pVPX/RD1af2OYm5bbSUuNF05wTwzeAAQmEh7/xfDV1uF+LVqzfU7SsatxFuuRGCixTe5tX5NojRUGSCeo3AGwbfJwRZqeRQ60XpffuSJ3ORlHhyTbB+Nhedm5Un+w0onWDkHYIv0lOXxAHdSWImpCjBK5k4tPw1BPbVu3jiOKb0qhmn2BThd5iIWKzQ03FpJSDqBTcLm2pcD0qQftuSF7gMlG6JPKUzeHSA2IAkAhTNtNvx4xtY2VPO43FLTQiJoJTZGIkirZXhcXEjBH7V2VZOsZ7xBTpztDQ2X4mDuz59a1XoKrxpi601sL5NTn0xk8SRT196OkH8/Ip29nqnLtC39Rgd//6k13+vIwNq2lXW0lkqxlMZ4R1/Ylx02ZOIs3j+YJCwi82ND+bbUSrT2EtnlEz+vPDnq5UvxZbAWboszLkb3bxNijQUFl6cnRFrRtQTZEqqN27Krl7+3Fu9eComq6sAytxT3KyDIsCUv4T8mLwht2z6IKW0wweNfg148mbJ2001v32oXcQmMpjyPzjvjQQ7byfmyZHRNnlTgmukzByy+hmTMHD2Tu3tMQQBABm5FXEjiwtAZfWRaZrpzPiu7QxyZzSsS8Bjhx2WUq04CGKSGzIidNtiGvs4EhhdEyL/94jzvhKL1xs7rOtv9yuHzpkP2hmb3tty+oq43m3f5NUw357Y7axS0B6yVkeXwzchg6DTKzPLfwP7rx6r0k1HUw/1N8aJ6TqXPyacpFeY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nFLMKUjX2yOzEvqSqBbH1OqzmUS02hIV/5qGip7hSPsG/ERP8GR819HfBWCU?=
 =?us-ascii?Q?yBZ0ZjcL42WztSfqg3rs8LyK+ua2uuB57y6+XbN+YTNgp9L4NcbBhRxdVJq2?=
 =?us-ascii?Q?QPW170OAJbEDfKwQJEExVfG0ezQ5m24chx8zcaycdt6WbD6dPpRgUdHi1Kk6?=
 =?us-ascii?Q?6f9tLrRspROfKCTfV8m0LqXsNLyomTAOFFoOJc0UKt7Q2rit/fWebHLztRLV?=
 =?us-ascii?Q?ZX4PXdap93h9QoUM1KurUMLK3OgFRoF/EZFi/sRYh2LS6E7hXrrTt0NuxFK3?=
 =?us-ascii?Q?YnrZ3gUQN3JUt+36S4TlSP3pAQhQN/8xc+qp7KbEnqNfSuZFwpgvyxjV12lE?=
 =?us-ascii?Q?XfQKvE5ziijGEvdYQ8TMeaZdyLufuDOhZnDGrfVM90fYX3t6C/O3GgmE0VZg?=
 =?us-ascii?Q?NAQk8GcJdPFXGfDqGBVzlS9L2GLfk4yqYgVHusXYOHIb5Xs7V+3bNSp77o3Y?=
 =?us-ascii?Q?Y0vvmgicLET0ljGDtsSJDIXItwl6N+lvNYlsRpig7Q0e6w/6YEGOvspLMx4t?=
 =?us-ascii?Q?+ggmM0qTFOYEK5SV2uOcUOmKOC+w7iZoM0r4uG+ZC2tfCu4ivClcwyN92PdI?=
 =?us-ascii?Q?mZ9MOLVCu2v/nEBRqll1gwfehfFLSvrx3MliTHP3cTHGZjUQEpLLGIc7rnD4?=
 =?us-ascii?Q?03voRVzGvB8zy7TJnVqjSrkXMxp9WA/I6ZVCdNknb1r/D5ZrRuapP9678Hf9?=
 =?us-ascii?Q?6QfsdkphmfMByl5sd9ECKh/OpHTj0LVBP9miEOsBI45IxfIOjajbO6Y2xMhS?=
 =?us-ascii?Q?qal5CR/nExX+mXYeqG0rZ6cfwm/JplzTO81nRv4Mx16sK0+GVqW8bZodybiC?=
 =?us-ascii?Q?AidMawU/Xxk4dKdJ92r1/E0VWStzGEYFF9GsrMKPZCF04uUYxIm0zLeYrHN2?=
 =?us-ascii?Q?4u/LHW6epFcYWoCHiYKwt7E/ueyP3Ixo4qlx/tfUmwP2JvTwkmKN0QKV7L7K?=
 =?us-ascii?Q?tlRhQ8mBLptbzlSU28Fti5KSwvPK/3h5o8XeMUTN0v+lk8r9nMIvo81yw1lf?=
 =?us-ascii?Q?VYSDYdzmdqgze1MD4LOjPCu7Pz3TEyCF8c/J5pn/Gqus0IDSTC3dy3ZbSIuJ?=
 =?us-ascii?Q?G8IX40xUiGXoSdcfEKpSYV/Jf7l6J/0Pou/B7yD9lf2R6KjUGV88Bz+xSWFr?=
 =?us-ascii?Q?X7jiMH+DyOgEx7pjSvbETgKvzm++ar1a7MtZNF0MdrsqIwwapbbxNpAQqJ0S?=
 =?us-ascii?Q?SQvQQS2ydYD9bwiA4sJGh7GZT0Q0e051HK+F7/ct3XA125JxaceNFdFL6rgI?=
 =?us-ascii?Q?9SOeJatjQSBF0iP+sT5epuRcbvRpS8mAZzaljVhUASViaT7Of0UrTlOKlVkz?=
 =?us-ascii?Q?cnX4OjoVe+5icw3RVWLiGIU8AccX+SOcTvaqBexGBYHUor0VyTGRrltoCpQp?=
 =?us-ascii?Q?150svoKWAdiBudOUb5Pf0OEm6QlTFcmxQgw5CXr5yhIZ8Hkr4zcfssUGUSd8?=
 =?us-ascii?Q?loXw5tTHYEF2iRF2vj3ti9ozDrQtW3kCb+l6IG5AAoiE+rOpU96ebsy7xZPg?=
 =?us-ascii?Q?ax9L5cIOZmzf3cIMXF8NuKbHv06/suuSUpooIwyiOpbC60YfCHNyI0rY+cfE?=
 =?us-ascii?Q?l/Ix/NaLPzATOqIDLF0tf3fYSjV2CNsvIq5LmZAsAdA3F1SJfMkGNsI7gYEu?=
 =?us-ascii?Q?qdNsoYS6iPFMso5px/XSEnjiaEL6drLfMgyV3fg/cjiiTYnkPXptffILcS+I?=
 =?us-ascii?Q?gBfj5rxW/kff98mcA0G+SoRCbz3zonU6Pe03iN0jXr7izkQ7VEsoyRQuBgA7?=
 =?us-ascii?Q?YXAI+MS3+eNnY0XVaKRahbB/HXGrQyi6jAQalg4Cy3UIz4Ktkl6V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61c90e6-18e9-4ecf-6232-08dea21f8dc6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:35:54.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypME0rP2986j0Y6zp56pi7eCy3SeNOj2/ZdSQrU29fssNEbsDJPNZC9MKlf3chL3K5wWEcTdM35YCCr5ichnHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639
X-Rspamd-Queue-Id: 2447646155B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35283-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

On Mon, Apr 20, 2026 at 10:43:08AM +0200, Johannes Berg wrote:
> On Fri, 2026-04-17 at 13:36 -0400, Yury Norov wrote:
> > The bitfields are designed in assumption that fields contain unsigned
> > integer values, thus extracting the values from the field implies
> > zero-extending.
> > 
> > Some drivers need to sign-extend their fields, and currently do it like:
> > 
> > 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> 
> That's indeed pretty awful...
> 
> 
> > +#define FIELD_GET_SIGNED(mask, reg)					\
> > 
> 
> [...]
> 
> I (personally) tend to prefer the "__MAKE_OP" versions (*_get_bits()
> etc.), in particular because WiFi and firmware interfaces deal a lot
> with fixed endian fields.

I don't like that __MAKE_OP magic because whatever it generates is not
greppable. And because we disable strict type checks for kernel, but
this API claims to typecheck the parameters for the user. So, the
following compiles well:

        u64 val = 0;
        ret = le16_get_bits(val, GENMASK(15, 10));

I don't like autogeneration in general. We generate, for example,
be32_get_bits(), but never use it. We don't even know the level of
the bloat.
 
> Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> be especially useful for le32_get_bits_signed() for example, to have the
> endian conversion built-in unlike FIELD_GET_SIGNED().

Maybe this:

        FIELD_GET_SIGNED(mask, le32_to_cpu(reg))

Thanks,
Yury

