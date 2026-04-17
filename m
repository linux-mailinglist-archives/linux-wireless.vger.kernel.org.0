Return-Path: <linux-wireless+bounces-34956-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH+QNHCI4mk97AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34956-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:22:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4441E359
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51FC030BF948
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B763ACA42;
	Fri, 17 Apr 2026 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSp/DMkn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AD355049;
	Fri, 17 Apr 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453706; cv=fail; b=d0+OPfHtOsoOIj2o2L5D4isKWr+SLqKr9tJyq9bPnEEhlmM0WkHDkS7KDlvKYzdw1/z1xbQtBWFEEuHfvQXK8VkVSvcw1h4aRAnZGKNAMexanXDv7p3A3JDehnekZd4yNmX5izTDJjHU6+YU2mnePJ+eR14wf8HTeyebQ72eXko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453706; c=relaxed/simple;
	bh=pDnZ4uTkXBUgiWIEVxnmXLru2lOHWrfSsX5FOB1hc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/SiXHJlBEmWSu8Px1gqIYuEqTLqfRI1/zFoDA7jc95eJGO1y7jaLaTKB4pJ/i8bhrNfJGQtX8G4BM1+47vAe6OONA1Wko9GQmKsBHi1tTJ5iFhQvAu37hSGu1NDqv8r55gRMXcAh4je5UwdW9k6GYnwLv0UHTiQghWgR70mP+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSp/DMkn; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Taqm+1GLE0euJQh6NfJd2iOKufBm3zpC0mgqG0/MU6/SlmAhzL5yOYLD6VAJqdFRArR4dW3mCr5UzBPSLQkf+5edo8UDl9fBaf0WpYg0XqWgE0jCcL0CCeOkwQooGweTft2uAZ3qAYFbpmu4antuGp5GgWEHadOZa/YbMToMrnE/EP/TMk4IZ0DFZiqYMUx87S7Qr97B5c3Z56rnCr1P9M6bOmmyHxIMaTk98DN9I+ScTEESGGZ4XmeLH15P4zEZu2b2KKqwy2jnt/DW/QSdUepzGjJs6wEYYlbSAm3+nwlRr/zsZwx4j9no77DWBZ1In0hxYlspgHqGXTaJJymvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcQMtHY3PSRN2aoLeY/yzyOt8TxpTlLXsOD+GS5yY3M=;
 b=Bhc2c/zuKh5UEKYvBFr/ok9kSIN0cXBJ90njuwBG8QWh6b28vOTWFqx+nPo8hi4i519QTvwc973xTQllCbfIji4ckwiQISLpGtOWZDLgSMP3dHyorusDUs65g2ku6xJ7mPYDJwAkwfoko1D4BVqh18XTM9oJ/w4W8xoZIFnk+HfngHQ7cqyWV/ns2owKRtpNNMp6mxRpY8E3g7I8jbSzj3k9WoFXO3tEOU+Qde/ebLD3bH7n2v/xU8lmjU6X8r+0ZrK67sN7VcTavR5VULyu1OaRZS05PsawgNFKyW9ClPBPe/J7bsEsxkVl47kznpZzrInYduJJ3qK2lsZ+OdLr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcQMtHY3PSRN2aoLeY/yzyOt8TxpTlLXsOD+GS5yY3M=;
 b=sSp/DMkn7vFEckLCG+YV+ksAyEAts5jGdlFA+URikatXoxeU7YGajaX2alUeirZPjM6wKO71iOYRRTqXQaM7MvFN1d/hCPG7p48099AoP9hAX56lGS5mffoseSzovXfb8s58DXf3a8gAuCxyXevePT6CJLVFaZXyt5SnHsNy49fuAN8Xm5vDNTSVkdHb5SmJubKGSttO7I+HyjaxJSYf9ynhpsCe9PrcfpJRCag9xDF6rOncjXu+TK1DrKI+4xr9Eqxkta2ni9tfAqZjdm5jQ9vkAEeXwa766Ix5QmRctbv0SeOU1jDaG5aTte1A77dA+LYASk6n1mdbAZ/mwCKfhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 19:21:42 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 19:21:41 +0000
Date: Fri, 17 Apr 2026 15:21:39 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH 0/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeKIQ2D3bjEMXskB@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <aeJ6hnZSbo2DrLpi@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeJ6hnZSbo2DrLpi@ashevche-desk.local>
X-ClientProxiedBy: BN9PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:408:fc::32) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d447593-d8ac-41d9-44fb-08de9cb68e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jYwD8NENaarZK6KJ/e1Hb3OT/hKCkDWw4eR5C9LNNh1fNZ26XHBHWikWLbucVRtPf8p45xsg2gVkbOlo4PLXvckg9VhxZPD5lqDnTlj6zqQNhBcLdIhmv+6g7UJV2s6ncLon9oSt5/uC7WxjwlhRDNk7od1u0r0VlRczo1fJ86CUYj4IpxPJieu3tKiQphSd2SELoqrx/wYwAspJFREI4sfKaEmhRQ2fnJLv8kY/YOzHCSuZBckIFp1+qpp2bN7PnJw2GmaI1i/IdLxcLFkZnPpY/gftP3rQGZIer1TzaVuV35gMjgEQiJW13uLwLGMSuMQqEDoSODms0Qydb5dhl5K3TypT4aEQCZSblU+W2g6CvvqM2ltrYvn/pNSCyoOmH1yUL8RzJX5pu7eLNSc2dPQXk0LVbz1I3xkKzUi0usx35JA1JrY/OSVxeTGOfEM94QS8o+X7GTZU1kIE7HMmoqMaveKBHdS58cWO9zu67QVccmbVkY3uhX643KL5O/JRAc0jTApkieiRy+zCyMo8YUDQwGv0hlHIr5wkex6lUojnFD9Tw+qvt2nUeCkXw4xtzedoQVhCGZy6Kd6fAaCWeqWfL0kU0b583axWqQjHLDExjU5wF7OvD635OH0H0+QY80uOfkwpiZ5Ci8eKCeh4mifMqRTYeKsTUBxHt5BUk6+aR4f+pFS/TMmCxMUjqOTzSqgyCnbyO/OqvvensNT+zwFpWeTdYMmXFlTzyq6jhNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1PJ/1EF6spCTg/rA8BMEsXHE6tAk1bWhhzB++Z3LQuAoqJ373/nUNUsAzQ1?=
 =?us-ascii?Q?9VkjXTrImh7R1KXWQbkZGj7ifPh5j4+V+/kByLsL3YCBJszKpVZwln5r4cCx?=
 =?us-ascii?Q?MSbD1LgZe+zXpj7U609xB9pOrx0QCfZd+APFxZUX5twi7JSSwPlpArLA/mMz?=
 =?us-ascii?Q?Hp9e/pWrQ/Kf7NwfgCOeIgfoN1e2CaVms4OGEQnUqcfD2TXhY8LqWBjFQfoO?=
 =?us-ascii?Q?hgzYn+aSkcXcoZbUBVpwRbmL5jM/9NDNLXLMKyPTknNe/uYgqMX2wC7ylw1d?=
 =?us-ascii?Q?z22rKhdyS92tyILQ3sYbCuqY0xvrSM4iF05s2/Ek4/yY+b23sQKFnsJb5pv0?=
 =?us-ascii?Q?ETte4rLhi6o4b8U0tkmQiTm57DhOWdU2Kupl51PsR0OQ5GGgIc1B/OeB2rIN?=
 =?us-ascii?Q?aamSWd7AQEDT9bZgtzzsRv63PWjZw7e4DwTd1IjtLYGd9qZUfD0YjCMnOAuo?=
 =?us-ascii?Q?2vrgTCcI438HdisBTgEbh5yDNFnpyhMsnRGgCpww/Z1dPUpUt/pe6QJ4kPgN?=
 =?us-ascii?Q?+doL9qX93kWvl0w37ofWTXDSLnUQk6DJAYL+O+vQ6CEtbbwtrzs3HD3mMpRW?=
 =?us-ascii?Q?XEnek8Sp2V5op7anQpr8BvTnOyl7NOOIqjQZfnHQNBVSW8bXS0LXf8HixRCB?=
 =?us-ascii?Q?mlzjahckM9WAN81aZU/8xZBrOAuDQoLXRAAiQz8KhiIcvLt1+BkW5Aa/29tF?=
 =?us-ascii?Q?3zu2lSkfJH3laKeU98znpr/Nf3o/yh8qPyH186ERoLvOM6F8LRT8OzGyfTPh?=
 =?us-ascii?Q?ZEw3XfAnzaInSoIkkUdQeKtyeQM5sgDFaO+I6kdH32/bFg5sXpQNjLCbvFiu?=
 =?us-ascii?Q?eEtcgkHULdSUqIzb57nBuamq8p6o7P91IBGKk+lyaVy5ErG3gNIeXjOHgsa/?=
 =?us-ascii?Q?rPKk41ayZa2I920NPBqGKlebCjaPBg3U4+E1h8wDJIcDC0blBo4k/rcu7J55?=
 =?us-ascii?Q?PiwJ/S7TxMmOetMErRHeQEy4viPPSIf1SIBUckQ8TXTYGXmG/CIgZk8aHMHm?=
 =?us-ascii?Q?UCHXSDxh1gemIbDw1ewrZXTY6plIPAyTC67d3JPc/IZ/1HVvU41XuY5isrT1?=
 =?us-ascii?Q?7ifj3A6tTejSQgCRS1ZUfD9evYYP8xjqa/IX6mwJJlqFmbxRTta6RRhPsIkl?=
 =?us-ascii?Q?e5TPa1pt0vYPJK8FXC798VeWLMLk21qmctZmqIMeILoPQbigwup3UX8HtfsH?=
 =?us-ascii?Q?OGDExS1fPuNfoI2/SQy4m6bhcJ939NfG6sP9TTtN5IWxyaIuNdqVf1yJ403Z?=
 =?us-ascii?Q?lr+hEkCSw4bvCGnyATpE4SIe6L9lnt6tu6Z0HANJJ4FWMWhsb2Gi1n1PjqFW?=
 =?us-ascii?Q?KbkxQ34EiNLaeOjaelRgn3GvgGjdNb0MGo8+xoAfBTSd0WCCs6M5Pf+XlhAs?=
 =?us-ascii?Q?5bxNmd2SlLowUTe/oUkbqkHjYZ9Mn3oFXcU0oUjgAb1WTfRE+DhrQcBffoWn?=
 =?us-ascii?Q?irk3Tp9J4d4A+eBmOvXu9iF4mamX+J7yJuVRvnnvduD7jQXb2scCylTcWJOD?=
 =?us-ascii?Q?kOVMTqgbVG8TUvu7uihIeA452vjvl9o4fUMMDQQhHY6xdwn3D8aVcG0TVRAF?=
 =?us-ascii?Q?wHMQgc1PIsmI3vr5e2aNmYXJFbN8aTjslipytZDdt6wu+DDdOkElsPLRC6Mw?=
 =?us-ascii?Q?GQMacHCmk4WO2WJyldlMwTWFShjc+1j1cc5AwxQS09C2o6UXeff+eW1dOgwN?=
 =?us-ascii?Q?ki4usyxiacctc84bfFja+EH9Q0mkaOt54RMpj5hpgAGp7mtcafpFhiYyMPzZ?=
 =?us-ascii?Q?hr4ajGEkjx3IO2jjwPiAo0w5lSpCmAWCnTSvMkIn904q0EqUyAJE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d447593-d8ac-41d9-44fb-08de9cb68e2d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 19:21:41.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pROpNIe/Llw0c/w0rf6ySASWlx42VjquzYEcSbGxTRVAGQRZYZk7THt0manyt1JS7K007vzxwDZ0Uitg4jhZlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34956-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63F4441E359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 09:23:02PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 17, 2026 at 01:36:11PM -0400, Yury Norov wrote:
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
> 
> Here the example is missing.

This series is full of examples... I'll add one here if you prefer, if
it comes to v2.
 
> Nevertheless, I looked at the implementation a bit and wondering how would it
> work for 64-bit mask of say GENMASK_ULL(63, 60)? Wouldn't it give an overflow?

In that case, the '<< __builtin_clzll(mask)' part becomes a NOP, and
the compiler only emits a single sar:

   long long foo(long long reg)
  {
    10:   f3 0f 1e fa             endbr64
          return FIELD_GET_SIGNED(GENMASK_ULL(63, 60), reg);
    14:   48 89 f8                mov    %rdi,%rax
    17:   48 c1 f8 3c             sar    $0x3c,%rax
  }

Just tested it with a real kernel build with gcc-15.2, and it works as
intended.

