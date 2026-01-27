Return-Path: <linux-wireless+bounces-31218-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNHHNv+SeGmxrAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31218-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:27:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF4592C66
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08AD307DBE8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5933D4E3;
	Tue, 27 Jan 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVkp48ex";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mDfCrKUY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF352FD7BE;
	Tue, 27 Jan 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509350; cv=fail; b=uFMvDettvOkkxU+OYZqcUjtGGKdUlAexgiDGfuVhMGh9tvopC8GYji97aovb7sv3KCLuDwxb4/mQg80wfdMleQEvqFOABQlGl5l3kPq89f2JvQuP4bOajR9/mL5ZLHIDNBwtcBQ2uMb9za2qF3j3rHNn/E7euRwXMegcGUlSWrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509350; c=relaxed/simple;
	bh=F5H42SB6SDuJUu+3njHUb29zTM8rjL9G4AddRKBKn4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r/RaSE1g0GnNHyLjMBHfM+YHxTGLEmZYpLWSJwDAYSNuTJ5GZ8/bNJk2C1omVtAZ+Aq7csKLj491ILJvWIFxX7BESxzoMS7YKmSPkepo9KnQNyBpKnEO78c3RB08/dxdoPF1iwfBlXg8OgPdKjlIjmt3KM3TRaXauuonLRdmVck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SVkp48ex; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mDfCrKUY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R9tRqI324715;
	Tue, 27 Jan 2026 10:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=F5H42SB6SDuJUu+3nj
	HUb29zTM8rjL9G4AddRKBKn4s=; b=SVkp48exBqPG8XFrbJNag3eF97sqUYNDMR
	djlqku2BUIWGjorOz4g9BzzDafchLnA/NBlNHK8tjHqMUKJt0r6JhkoZ2lBpWBr9
	+FvfPLE0ZWvuWkm2cjjZVhAgl/s3tJ9CRbwl3otFAsQIcNjov+5R6g8QP/6xz/oS
	xkcgyDD8+xF/T0LA176BV6v2GHBq+V+rgC9nWx5s9hE4KW9KebBiZW1JNgnOPbD6
	8fCOX9wtHpL0L6A+DMaBrt9A9Zcn8ST2i/NbUH1X7b+m+bWp8qND5xiP0fni0dDO
	dJoUnNnVKQOKnzu+8ON+gOl/fA0uhMd8q1NiixljNbkP59UWvPSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2usce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 10:21:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RAD1wd001950;
	Tue, 27 Jan 2026 10:21:35 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhdr9s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 10:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xck3RXD8CA9Iuyz4qBuRl0Ta/YzkoIGdu0qw4uy6AbYUfYpIGI1LmxNKsFj3+gQPT1EtoB9DCQIH3raj5NKRo5kS+Eex6X/sUQ/n2IrE/pCd0hlEuBKC3RBc6EMyJBfoJJyVRzCyJrHdhEpSEWmHZO4oBGYU5nusUEIVv8zut/bvFnC9rGLQRPw82a+kmc/amrVkbO2bzVwEHsNDAdy1dT9OaU3Cko6LfIG2+gy49fv6CkN3QjNl54BSG9gp1HFPkpXouI+Oj+yWLjYYR8dGNIBl39bkOOfSRdn+yXghUZyim2FYIxdyTk5W7MW9bg5vgbAXHbO7hdUIZn3Xziyw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5H42SB6SDuJUu+3njHUb29zTM8rjL9G4AddRKBKn4s=;
 b=Vios3YinYA8gE5dJ71tW+bNezHZQPn6cPYIfz4k7Jew4FACWvr4vote4dBeB4vig7m1vl8cPkIGiVDESdeXQzQJ6Aulm2mcSupECs5axtZoiB86/ZoZU2azd/f8CxP3BU53efwugsbq0//IODSVJRLii0IxngEfCHbPmIn6FLEmIdxZR0Dv8vfZtCUj9YzmRg77l7OZYYFtHkS38T7kPdujjYGPhHfud5xH7zWKERLNBWdCkWRpKhjlG8Wj8+LG+/hd5WI+uo6f5Tao7uAVxsw93OIBVp8JZHhCbcuUKNqb5UOjCejYQn+JoMyKnexTM9PkReITDkNjdj9JhXtDl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5H42SB6SDuJUu+3njHUb29zTM8rjL9G4AddRKBKn4s=;
 b=mDfCrKUY9hWnHyYFaN0XWepkF2i2zymCQAXEHIH6RT7gh5PsUVM4e/znb1RR7iElOtW8u/nhvi727XSfgE9Fc5r4s7DKqkmAYA1luTvc0OqCt7gci2tBh8J7AdpTN1zXMmejJvD/OlK11bFJAS5jo8wEFhOQMhlTo0nHkZ101uI=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by MN6PR10MB8168.namprd10.prod.outlook.com (2603:10b6:208:500::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:21:31 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9%6]) with mapi id 15.20.9499.005; Tue, 27 Jan 2026
 10:21:30 +0000
Date: Tue, 27 Jan 2026 10:21:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
        Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
        kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev,
        rcu@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context
 analysis
Message-ID: <599729a5-da4c-473a-bd07-4459639c95c7@lucifer.local>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-7-elver@google.com>
 <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
 <CANpmjNNHmOzaCSc9hQJNuzNVHXA=LRgXB4Q69FNk6wBuuJGdAg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNHmOzaCSc9hQJNuzNVHXA=LRgXB4Q69FNk6wBuuJGdAg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|MN6PR10MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6d1f63-e031-474e-ae72-08de5d8dd6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/KN8W0B/VzVARbdg0cLl+/Jbd70KCs0Jw8I/VSYasAC6XgzwJZS0hBxQTYe?=
 =?us-ascii?Q?pQkWpibq5KvyYSlbc9z4mDs8fL1mUgXbkrslDtMRe60AfStUkHK9NxxVRenp?=
 =?us-ascii?Q?4L1WhoiKcVTAg/eoHLAzrpwV6QD6+6IKRcjWBQcgXhLSm3rMHTMdVBRanmno?=
 =?us-ascii?Q?dHvye+5BtdT3PcZ0LUgWPzapTnD2zPyCtne1QIY02LkVPzCmHOBivrsGd3Wi?=
 =?us-ascii?Q?f5u9kn1eG6o/f+0HBKq2LcwPOVl2wWvaoWFbKnvOQnR88c/JuFNG7VcoudpZ?=
 =?us-ascii?Q?HJsYbKmxKVzGeu4sULpJ1Iyn1OG7a+GQEyEfLK3dBkUclMZ5CrFbwznNG1dP?=
 =?us-ascii?Q?cH6YVLwt74MLBkg+EIrH5tLDTuIYsngxBTxDs8SpTSD7cqx8LsFJSYtWB/ep?=
 =?us-ascii?Q?NI0V8aeoYKcAKSwLxyiAGGhAmocQpfKE0J3WGxe9nKbj4yyDVpzEgD4JB9k1?=
 =?us-ascii?Q?cmrYM0TSa1kS6nqrghFYoI8Uv/KmItl0w59pxktSrrb4uH99F9o6YYx8qpAb?=
 =?us-ascii?Q?E6SWfxv19hTGboh5UYKlKkwm/UDVEjPsHQE1xWrlCjIzRXizyoo+eamGKeMt?=
 =?us-ascii?Q?mxDhI/JrhYd3GlPoLs/AMtfXZvvymQVwB7yyN+yLA6NAOkp7VsEmXdGaSjzf?=
 =?us-ascii?Q?26r+r8fvK88YHFG0Y3sr9gNm9lGwDFeiWLMNrwcxEua5Ammc2a87/VV71lmk?=
 =?us-ascii?Q?ONaAWd2vzc5YCNJ6ZnHMjDnVDm0GK1NlZRO6bx7IbGgxlY+gFbJQ9OXrkaxR?=
 =?us-ascii?Q?daeFvU1vyzQH0hlY2+Tm2z3VDEITeXkCO02izAL00psvPvLPitp6mDt0QL+i?=
 =?us-ascii?Q?M+xSapJlJE7NbN0znUMLTbAHR04tqh7Yy8eYF+9UxEA0qxbAdTTEfr2hT18C?=
 =?us-ascii?Q?iI2sax1H+YsAbiloEal0bfFOkee9f9b9cb5RZbVCbI1Lywsyl0d5cVFh9sEP?=
 =?us-ascii?Q?//+3A6LRqd66Y0pYR2XhmaNXfjYa1dy/AaQ4ul5FzEol4EsqbAUQv6jc9gcs?=
 =?us-ascii?Q?SCrHBwYe0Kv+C52sGSbXHrLyxZtPowDleL27TUJxVPn2R1cfil5j6egJrFwr?=
 =?us-ascii?Q?ll2kcfviySqkaiF+5nTRqUl0ZsduZVU7RGmj3gogN1MRqgdBssnt6or7ZsxV?=
 =?us-ascii?Q?ATX78pN89B6SDo5I2iA2kTFYd+7wydRV1425IepPHSCOBqs+nCTylfCq72e1?=
 =?us-ascii?Q?zN/rxBGa3jYnFGhBdJqvN3vp4UkSd+xnVyt7ZMtYa6uR5i6Aq02vKn0UGvRb?=
 =?us-ascii?Q?HtvIvCIHK47psPUuiLEFfbN0NHwHAF202UIdzhQcuQAiHBNv3gMsXh7ZKLJk?=
 =?us-ascii?Q?z2KIodcOx3Fy4bTs1auZkWyg4yI2IQP3HUxDVnfgY5ODjJ2VeRL7T78iSue8?=
 =?us-ascii?Q?VVud/hNO19hpvJvAZneiDdJBUqd9lpu6BN4v/D46uyAYe4E0wh1O2CoV1WH8?=
 =?us-ascii?Q?Vy6IMourIWgg4BXW64FpqHEOACQ2UKu4HHrGJJiJa+YPAsJzAGHyjaABQvwX?=
 =?us-ascii?Q?Nbp1U3sF8SYS4Ix7MdqZUwxxy/o8EddbjkG5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Za9BAMgAQJtgvYqu9iivQMQu+V6cW7waeo3EtNdmhqc5IuGpIOU6y0Ni3/jP?=
 =?us-ascii?Q?Yb4ZyPRyvzCIJHaQ6R8jZ8atYGo3ZSrEmB4eJ7ofEQWnzha34cmsv26hiFx8?=
 =?us-ascii?Q?lwyBGZTl2utT9mk9SSi6DtANAwKkmCKSOHx3BFhCzuR5Ft5/O3f1jzhTHAOr?=
 =?us-ascii?Q?wd7+z51yHPso0tOSafhLJ//P+H4C3r/5k2QAqjg9p8Raz3H1ZcMxdHpF7yDt?=
 =?us-ascii?Q?W5saYH/cafTewjwjEWchp1TmMJKa3Q0dtyFjgzd+/z2/9Cn6Zv8Uw9l4SH8D?=
 =?us-ascii?Q?F446sc3fYAKxOHPxeDiWWREM/WQDU202BTAMmfl7m14LSiz94OcZzoRxecu6?=
 =?us-ascii?Q?CQuTlER58ivNVFYzeDluzVQ+/8KvxgZ5eEvMEN5qeiyQyEt5bUfkhGjy46k7?=
 =?us-ascii?Q?1F0wyL4Boh1hbzN8BDOYMyp9mA/MmafkXiFM724eM7h5ENZqycKw8EOAq1pA?=
 =?us-ascii?Q?s9XsGOanIp9kI1YZx2qyCvksRYhlGkjg3HtucK7Xn9d8g7oM0vDdGwZelNLa?=
 =?us-ascii?Q?OIxkQPSsfzm2b8/HsRPtI5xPcpo9wvDvi6OAcPt7kpifxIV0cgPQLvdpV2F4?=
 =?us-ascii?Q?aUBm8dvDmuLzJezEuaJPf3edLV6mQTILYSlepWE4a+Dma9kRsM9vrt/pRUi0?=
 =?us-ascii?Q?ERs3W9JFzZ263/TN+n6QuuF1iTlmUngQ1hJmOLSybdXzMxdF9vssNVMfxVcd?=
 =?us-ascii?Q?IxNuBRBUilJM1on5fSMIcyFQqy1smf6jZWPmC/0m9LIbYQ87Q9iZQA6LpUiq?=
 =?us-ascii?Q?6rVn47Mthv82RXaL6ixTXFyEP8yVg408Je9SwdPELRrQfl5JBp0JANiP04SU?=
 =?us-ascii?Q?DNj9CsTLT1b9Tv0SbOw5BI1Vyhyhj2wbfe/qzv8IEjIME/bFWYQPMO4ie9pk?=
 =?us-ascii?Q?AlgqzLrc2VkjB7D+mFiy9uCQ4c11EteTLrQrqJSYZFgYvPJN94+FzmxvRvBa?=
 =?us-ascii?Q?PMTNGCreR6lpfPqnhUxH+WJvfA+An8clyEYl0DlJ6BB9vZdYAbHmTtOHSo/P?=
 =?us-ascii?Q?5IF60un/TK71rPdljRVImpsGSxoIEP7ZXqGbmS6nEvk7okjL8NcdwQTUmBKP?=
 =?us-ascii?Q?IddzM2lPbPFr5Hpa/CMYrOsuNAqgKv/ufhDX41Ka8aUlT/l0nsrVrWROyxCB?=
 =?us-ascii?Q?Uose3BmhnxQwHTazcJAR2ff9m2ysffB8No1sev0cKbvK28IYs5wUWUYkkH7x?=
 =?us-ascii?Q?f7QOGM0KF32pr3Px7PY4Qq8J158QxnG1vtzjnj5WKCeupK6z6BGnyRg6nCPX?=
 =?us-ascii?Q?Lj4hhOaS41L6MR/jz9qc3ESKT2w4hFDfw5ZBpLJ8d0vu+6hm43+AOIrCI/lB?=
 =?us-ascii?Q?JbQQRpm7bBxzjxaLLpDWkg8KQfi2BEEcvadYaOItrj5pq4Q3RAKZ6WAujeMO?=
 =?us-ascii?Q?9uujMYY45713GqJIK8cyL7cOZIZbx6MepcDB8IzVCEnS/2n4s55DwDgtiTYS?=
 =?us-ascii?Q?9b0SoDYUswAVVvAu0IiOdIFMwsw1nkAa0BNSKTS/YDI6pYHNV9ltCl9kETm/?=
 =?us-ascii?Q?8jhxw2KfvjVur0vKj4/LgPmmc4dXnZPzeKijj09p1BuU8cBY8CjTWQd6mjd8?=
 =?us-ascii?Q?A9Dm+6bN48czVmEzpRz7/XSUaoY7wxObj1ilg0kIMoik+nw5ea+a76Sl5jA6?=
 =?us-ascii?Q?EkMKyIierO6KGUNIbLApurv91T5CjUlVOF616Md654p955SRsU0JMWW6jo7c?=
 =?us-ascii?Q?njWb5HIHxJS50rF9FB7KnfuU2X2sLlhhDUP59b15RFRbIJQSG2FKS5xotRas?=
 =?us-ascii?Q?PypK1HKECeBN4ZBbD96H/1UWosxH7WQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BSU2e3QFIBy5TXIVZuVzWBiZ/kUY2hmTmNYXbHYf08/U3RXAFVDhAYXDC9jSNlqOWPm0s6ugUlahFas1a0LjXNIIpD5GGsYPrJ2qLbJ4bLKEzrkLlDjV4if77uSotjx6T/ATobS1FazjjgA8CLXfyKDFrq2mVM9SLjN2njqo244/ifotyHqnyPt8lORITwZAuAXX1hGcGkigh5SZ+Lq2NQ4HhNxYL141lik8k7YpQpPtw20dcg0E+1ieDJgk7yQArtYVbUenWd3g1BVs5dqtPqvtl2H+CLtbdqSuxu+TiuPAc4Q0FZFsdMTwhzAhd9XhpzXE96cSV1TqDoDkDgKAEmdsJJ4Fu7Z/UR0pgaWglREMnLdsI4fdJ17w14IOHSZdL28z0soPYFX0uKEOJAsTyRbxQUQ98+x82l1BpycnWBiyNJggrgHvcepEO1PizaELPdW74O0JjWWNQuu032D38tU6SZZZJNEGrkYXjYtXryTiaV+EixTv8W6Py3DK0m8ym2ERFyov9h4cAoyfPtELXfItJInSqzRT9yjcdTeyk57cwxueIu9lucEt1LflnTyaVhTvTJ6EftQjQET7bTtIayHPxQcFLfw9CsPGms74Dtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6d1f63-e031-474e-ae72-08de5d8dd6a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:21:30.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHiSXOwUl+kILM/2jzOnV+XuxoKm9mAKGqDfPSGWWqi0WRUQbJcHgm5dbxwTMHtQ3cPWRdGnlQVN8+lARdUBesXxVVL6ux/CLWVJMUCgU7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270084
X-Proofpoint-ORIG-GUID: 0mpK42smoVkGrNl8Ra4GuDxsj5klECIO
X-Proofpoint-GUID: 0mpK42smoVkGrNl8Ra4GuDxsj5klECIO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4NCBTYWx0ZWRfX5NTA4oDBEaLA
 Ktkq1sCslkUG/9wv2gBrLeaqcCMKL3PX1skD7eDmh90W1GlERIve5jVYJ+1HhCaPgaPKWAwkcVR
 q1fmCJI8CXeaY1RhSmMrdbUMi88mAAfA7DLMPeZZo4dopQ7mxG8m1G6YnBFGaiHtFF+x6buILtK
 pc+haAN2moIoEo3zVX/s3HmBh3GThUD7UG7JrlewDOjCcugT76NI7AKTBzgUOC3NOrWOWZDfMZ9
 J8B+ocp0/CR3M7z3FudW8kngVEj8vsIgRoeLFSrV45knF1Iw8TbduRIPedWfnkkpy4razYz9akC
 6mQ9Lxqqivetq0UShzFhFClBN4Y6yEyy6d4BwtY0F75cIHNLfgYuHxkfq6x4jN4KWs2jCEEanLV
 pO828Ylnhh2vtzjhSoOC+ak19oAxTNu/e8FMZEeTUZY7CPqIcb6/I7cGzF/RshYr31LX5t+ez4W
 KluWpQqZ47UrGuIVnXH3Zz9KpbhyjrVEh//CHWZE=
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=697891af b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=nYO3-bDRM2uWDnqorzEA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13644
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,davemloft.net,chrisli.org,google.com,arndb.de,acm.org,lst.de,linuxfoundation.org,gondor.apana.org.au,nvidia.com,intel.com,lwn.net,joshtriplett.org,nttdata.co.jp,arm.com,efficios.com,goodmis.org,i-love.sakura.ne.jp,linutronix.de,suug.ch,redhat.com,googlegroups.com,vger.kernel.org,kvack.org,lists.linux.dev,oracle.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31218-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7CF4592C66
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:17:24AM +0100, Marco Elver wrote:
> On Tue, 27 Jan 2026 at 11:14, Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > +cc Sid for awareness
> >
> > Hi,
> >
> > This patch breaks the radix tree and VMA userland tests. The next bots didn't
> > catch it but it seems now they're building the userland VMA tests
> > (e.g. https://lore.kernel.all/202601271308.b8d3fcb6-lkp@intel.com/) but maybe
> > not caught up to the issue this one caused (fails build in tools/testing/vma and
> > tools/testing/radix-tree).
> >
> > Anyway it's a really easy fix, just need to stub out __no_context_analysis in
> > the tools/include copy of compiler_types.h, fix-patch provided below.
> >
> > To avoid bisection hazard it'd be nice if it could be folded into this series
> > before this patch, but if we're too late in the cycle for that I can submit a
> > fix separately.
>
> Thanks, I saw. I have a more complete fix I'm about to send.

Great, thanks!

