Return-Path: <linux-wireless+bounces-35640-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJX7IWlV8mnGpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35640-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 21:00:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 538914996F0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC23F3017D83
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8DA425CD4;
	Wed, 29 Apr 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZTRjbb4E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1C423160;
	Wed, 29 Apr 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489235; cv=fail; b=tkXOkaHp1JUreGCtP9Qyc3XVTxlmfHgGPxCk6hnafGuQiABBO4BqS4VoDzSnpMPWOKb6ms/Ej/C0UUfqvZKKai45w+C3alMnXkRr6bMO/wUZ3uycUD61ScK/GtElFG8d+ulTDIXydVQ+NEh9C2XVLexjzj57yDkdqOLgBDpv84w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489235; c=relaxed/simple;
	bh=RERLewO/GWaWj1NHuDkrkSRoAqEzwKjoGR9gLWfg9bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0ojA74Lx5/CWBw+N/H0QsWwHZ6u80Q2TkN9GiBBeOJiTmIPYNOnoa1eZiqCi5e9Z0Vy41MK8jTIOXT9Y/ftLjvqV8rtTehNECSf8Wn4iX8P+3QxOzC5qkDgxwZ29nwjt/e2v+Z+pJHJxMMA6BPZAzt4G79rXjjJm3QVffZE6QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZTRjbb4E; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSvyb8oSi/S/320i+XGtzJVpEX/2LjgMB5uKu3fI/dVoi1d5D+wzGGuBpxJ67i4mKKVpTjwU/94hFINemiq2lob2t3lgkkITxAOHGdPWajwVHMYq/O0k8RLQt2Tw4u08kTFXw7wPxAby0wdiJtNB9agBmIph6v6bpEzQFyHAydOH5Dh9PVZ6PnfOpY9Plo2TlxiVq9/0SOyzXrjYFqgpVwPulHOFGs93NIHd4vNmvZFzvWLfKAMaCCbag69j8uqvh4NNagsHrEhuJ2B8wdyCUuRWKmUEGu+f7hmpN7Ekq9kKauQDg66saa3ib7+1EKgatcdsbBi9M5h3yUNUF8FBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct2RTuZZmuKYWUl5C66fBdZQbzR+0rP7NnZBy8K6jq4=;
 b=kR8RD94YkmYD2WtB3F+cnrw2DssLs+IpfF1mJznHaNIFXVpmItwMNn8gwAAl+G2XcoFAJN6MzTg0AGzHHsbJCHbZZZFzYqDQyEJQOTNRNFJifBRv1rTLR1BbugEbZRvBFy5prkiDSApFvt1pS9eezFjRXQHUNhSSJjlDRRcpkphtFBVj+4YAFFQizOe7xyR5Vcudw0oo0aqRL5ywPzZYlYFprkvhMY9gYOhqfNoQOuQM40QaQth83W3FnjxxDicCr0qT/SFB9SGnX52EBrUyvW+4YwlWOvrjDBA2W+nzLR3m/3j9pG7ayx9sarFkTVt9qa6aebgmOkKsG59GSwMDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct2RTuZZmuKYWUl5C66fBdZQbzR+0rP7NnZBy8K6jq4=;
 b=ZTRjbb4Enm7ZShsE7xzzx0VqfGIWW3LJtTsnniBe9Uz4BdkBnHRcJLj8LyzHqE4Ko9zeywfJItpG2JhRqCHxmAGfX36lCu4JT03cj2s9BaHfwlaTApDQ6b/WaoHhpAEk6ZH9YIkzfk1H8Nuu0QXcAYyYY2XctX3pymZXf9gOL2eJu4ejOw3ChyH4o84W3RRxlmB7yxPdPzIQKTKpOp90sFeEbLcaOvu8uRjemc+41s9/8gN7dMrkYPdEG8NyLuaXsQrOlrh5U/n3ZOFMCIQ2nkGKhHVpXNVlu9U0XTX06+mnrc27VBvoBOWq35Cw17qyPoR7AG1QqJ0uFfIep96rvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 19:00:25 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 19:00:25 +0000
Date: Wed, 29 Apr 2026 15:00:21 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Laight <david.laight.linux@gmail.com>,
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
	Ben Collins <bcollins@watter.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 2/9] x86/extable: switch to using FIELD_GET_SIGNED()
Message-ID: <afJVRTqRthN7AD6Q@yury>
References: <20260427214127.406067-1-ynorov@nvidia.com>
 <20260427214127.406067-3-ynorov@nvidia.com>
 <20260428093905.GA1026330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428093905.GA1026330@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: c46d66e7-53d5-4f1c-26f0-08dea6219205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8iInPv1Y7rbc7ev09JPhcdcTH/Jpx1QDMJDExf5bW5QR/vvg0wROzv7iLl0pTwu50Lz4b2ATFfJoDQA/cTs3TtUaVcjTMj3yg4hbVJTaXwXwukxh7SWiSWDv2VEh46t15yuoxeFA/HczJP40+zk1gPvxQgc8Sq4/QT7ZyqCqFm3LBsIDZLDaAlZrpaymdIhVNBJvA/uDZxvo+uG/E+K81vEVbjfmg6e4qpwAq5qEDR6y/L95xPP3mjlU3HYpxtQnqswTbe28MyhZ3OYZW6EQeWfRrKLrYh2iFw2CuTyounnaG9ooobofZRtaja5qw6vQFDUQzq07YM12IT+mJn0mDxhFoMrDWUR4mtJwUCZC6zeuLLDb7CrDaR+VZHioAo2t8Bvf2kU3UuV7RrBl5yNbJ6pYbILtZodVfyw3ha5xplDr2rVoRCPy4azDoy6lVV6HMRwV+AfTEnDiQQRpR0Zul1ONtLkD2+6e/vMtu2t3JIM90x0YwmNwmpe7A4L47z1zxYie5hbJFIbcI3OhJU53drffcf3txee4jE+OBEECwsjnhYqJi1RQny5n4sF1ffCOWGDJgFHcwFjpcyL3c7YsGS+OHCy2tmSHn+V1TQuoRSS7PqPPKJnqIjKQCRtBgv3v0J5K49n7DL3DzEKbkIkhraefFlpWqgIIZiX44mvTa336Brsry6svSrQyxi2xp1IeWlW7pTaaZpcmvcg0972CQp7xJUFQ5QwzIfIpMbKVORc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ezrtmc3PquK5pH8kkr7OQXQeV2OTcHERBpFvR2dM2j7iTs+l2QvOUDVM9o8U?=
 =?us-ascii?Q?B207vvI3W3HNarNZEs8R+bzG56XlM7SnuV40w3PxKc5AUQx+tZWmccqL3FaB?=
 =?us-ascii?Q?XkfTQ4OZ7NcG64vA+LYXqS6OF6uDRqX59/ACulThpFJogH6huWuIsqKRp4D6?=
 =?us-ascii?Q?4KwpkgFas2B9GcPVZZpSGImxEe7R7Fdxt3AXP+clGJJ+glOODI+t3mErE2Pa?=
 =?us-ascii?Q?GoVY6X3hnBOEu216dYpzxspPq3cRT9gWu21Mi/mjbDNCeTtDKud0OibLOttr?=
 =?us-ascii?Q?SXdbMz94a5qF00T5PGHCStG1zvhTM9AWddmvQc95s4d9Gl125mME4Q1rh6jC?=
 =?us-ascii?Q?/blixtlntWibb4mpC135G72YK7Bykd8TA6rNwYuyw2Jejxl4LPXT6h61xGyf?=
 =?us-ascii?Q?zj78otiDQkkxrdqhAxt2lJme20/r350TQC+P07iVsJ/39nho0qIPVb486UEu?=
 =?us-ascii?Q?gz9vpNpbAj3JB5baTXNQUNALOp+TY96R6A6+hSR77D1O8EQPOrCBRNbDcK68?=
 =?us-ascii?Q?IZWb8bwAMdd2ObfV40mFvBq3ytCmg+o8ZvdZPlSG8EipRxag3OEx0Cf5hbDE?=
 =?us-ascii?Q?MEXEuz+bNE293qVYH50YisK+2zqu2MfBHrfKFILq5S6HDiaLuH0BgfM6ijJ+?=
 =?us-ascii?Q?9o1Hdya6wOX1ui07sLPrpLeJSmwRnU7Eb5y+Lkq46lmVnRKz0DbsxxvHyOsq?=
 =?us-ascii?Q?prFftlm5PwjPwg1dE1fdJ7SXU8kodOaPIFwM9mjTcHVKjkANif3iDcYNQyz/?=
 =?us-ascii?Q?9PcOfliMzcuNc/k5Fp9TpMx2Wia1oXh51Iawsg3faN/fnrQ8JYh/t7I2INW1?=
 =?us-ascii?Q?+iBH0+LT91oVDeEczNO0HIenef8kt8A81hhv8YH31anNBT5/tTZERQhLVOxQ?=
 =?us-ascii?Q?dcNl+odz1uOhNwsC11uneZ5O6Qw7mAtaM+1/cpYH3ViGq7EhnkalBzK+yIJg?=
 =?us-ascii?Q?URWTOIySPU+h/Z+Cw4gd1v4gNUHIsKaZw8LW3Qkf3g/VNfWMAhcCn8Xwmj6n?=
 =?us-ascii?Q?OT819pHi2mLh65q9/CdEST4CCtpCJNf6/64562A35poyoWJgqaxOGwg0mlEQ?=
 =?us-ascii?Q?E7my32mtfWNzFlsbfjuE7+AMqZrvm044roXOH16mGJyhoGyDZp97k2hNv7+P?=
 =?us-ascii?Q?2vU4+npzyChoG5qDESmfWd4LWLfhmaXOLICViFnuKOLkC9lOezhmw8iJOahr?=
 =?us-ascii?Q?SZllFUM3BrzFd/1D9jRWZuau3jZACS23xwYnfs/RPU4CMLq9yf4ZHchWWvj6?=
 =?us-ascii?Q?O9aKp8ovazqN0h7RIJggodSk7aoJ/ROnpEg3O7FFi7YHciFsfco4UVzUSQy1?=
 =?us-ascii?Q?nKYwE0SBZRwDi1nPXf54+6Qq49stWH8Xxz9c/xP3YJY476tV+9hV/AOtiwVg?=
 =?us-ascii?Q?vqR4fm2wWejC50WfcEbgH6PBVhm5e/jd1gTJ+xRif6UOzK6CW4bMPhyl7VNa?=
 =?us-ascii?Q?Z6ZgatW4VdCT7PKlgr3NTXZLQ8MMZiZKkEXNlk1YTBa5n8ON1L/3yYO7XY3P?=
 =?us-ascii?Q?DOnml2njdakrReS6LVT9dVSIpWNnyI5hKgAOcnlO5wyK6AKfkEhUedJglm75?=
 =?us-ascii?Q?JoT3Ek67k89SoNd2FDYAqZcvLMgZlaFdSH2H2bja0wRBgRB5N/Y/WD9hiWTv?=
 =?us-ascii?Q?awq3/7XP9z3ZeZi4LQ5+BrLcS8UQW6eXlORmuppoIDTTEjfOBs4BRnhF0CJc?=
 =?us-ascii?Q?ag1uaM6VqIS6hCTkIA9oN2eBfqfr04XruICQubXdtZnR8dOG2J4VHVZgEJLM?=
 =?us-ascii?Q?TgjswtaU+0fLDlsL8bLxmtMqgfnsILujk26Psao9aOXk34RjuMKG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46d66e7-53d5-4f1c-26f0-08dea6219205
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 19:00:24.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhudjZOJvhjk6sblo4TRQ/qDpUQmdFZ1BuB7sHV07A+C96vBXsPC1Tv54vKBLSsSla19fxr/G0S/7/KxPenn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
X-Rspamd-Queue-Id: 538914996F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35640-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,infradead.org:email]

On Tue, Apr 28, 2026 at 11:39:05AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 27, 2026 at 05:41:19PM -0400, Yury Norov wrote:
> > The EX_DATA register is laid out such that EX_DATA_IMM occupied MSB.
> > It's done to make sure that FIELD_GET() will sign-extend the IMM
> > field during extraction.
> > 
> > To enforce that, all EX_DATA masks are made signed integers. This
> > works, but relies on the particular implementation of FIELD_GET(),
> > i.e. masking then shifting, not vice versa; and the particular
> > placement of the fields in the register.
> > 
> > Switch to using the dedicated FIELD_GET_SIGNED(), and relax those
> > limitations.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Alright, thanks Peter and everyone. Now that all the patches except #9
are reviewed, I'm taking the series into bitmap-for-next.

Thanks,
Yury

