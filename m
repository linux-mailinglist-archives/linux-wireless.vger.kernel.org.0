Return-Path: <linux-wireless+bounces-31215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFr+Gv6ReGmirAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:22:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0092B71
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD313038ACC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608792FD1A1;
	Tue, 27 Jan 2026 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7u1vndw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o1f71PmE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA02ED860;
	Tue, 27 Jan 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508945; cv=fail; b=Dwh9IfnFpAcyehy9H0Xfijs4nLaUfq/ZdmQtqwivTysGzPqkKwKyBSHj7k5a+LoBg1mGw9j5LZk/12+2f1RZJZ5w0DYsE4U/vATZP3ZZ+zZge8XDLusICFXtTymYY3q4j+GCPcVf08uJf4/CDiRNOcooXkGVYW4ehIci5dizO6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508945; c=relaxed/simple;
	bh=DyolQRJfvqWEmju265a6NG5cJpOg2R9DrP8t2bE6R70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vA68DTfNEvZhVyeKy1HZHdNn2dQc9TXvhvQw4bMwncijTDPqlGmq1WhK/85SJ7SCsUtASqAl6acCzCPY3TUibxJNzzUFeaUfaG97QuTc5AkZsBSF2vcGWT8Ezg627IXp4FBTeWoWKdC6n1G0Tfhls73VtY0RxzeU5kIk0ekvQlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7u1vndw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o1f71PmE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R2xaMk3025479;
	Tue, 27 Jan 2026 10:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z1J6pmii58u3ly2fi3
	5pL6zr+JHMg7mSwl3MydzUc80=; b=a7u1vndwnlWofozI7SJCt6lpOId4GG8Ca/
	mxxC5DyQ7BTePGPGslvqaFVHQ6eggpLI89Yfrq01fMPZ1yxhCRmUGzQmsK9ZNzQI
	2gCnO+LraVZFMF2xYTp8ufA7vyDAnoUOer0yaTg2wpPvinnvEJCmCwFcumnx0+uO
	mPx3qvhfBweSjIp6LOWt4X8Hh6xJKugp1VNm9wPp6nK5JsbTpaAIWdK6Cm6S9+yt
	vdWZ9RnOEOfk3oi+QiMNUOSBiv90m+JaOv2F3+yc4O3QKzzo3gx4Q2CGKKkSdtVA
	DmfebuSViM7eype4+euPR1MIWk63TE5Kpoz+nBcaFUI7ZqhZmfYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2us48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 10:14:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8eA9d036182;
	Tue, 27 Jan 2026 10:14:30 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhnfpym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 10:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCcaFbIFWTxKdVjKyEfSYMNsmPWDKfg+FBGV+F31SVMLaYY+ZLfBz8ZdBKYDK5nZpaA+G8VyvNfsu43mlk+NUXeY3dJIrx93xigw7Dpl6W2iA47sHMjGW0e27+3npn4ERiZ3FevXc8jDtrkZxMLqJUrjS0RsRc1nXd3qTLHOQHjMFjBP+c+OGCN3zxI9nKr6urpQ+/gRT22gv9d2TE5SNU0uej1qsTzfUSoPLWyArONuBtuvDQStu6fpDff2AMAlpErBCBorbmZas5pIkRpCg8cb6YD6uPifhzSb93uG6mYZwcRV0zleljDRpV9pgqdoj3f6EcsZ6qjgfpn3EbVSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1J6pmii58u3ly2fi35pL6zr+JHMg7mSwl3MydzUc80=;
 b=EVmW5kh1HgAxDi4t0kSQiJQlkbmWA6CAmhhOKDoE8ek9mFuRYfiRRmK4R3X/qbqB34Ak+3C1uCIDgBDgZnkZLqLEyx+30ZiR+6N2Z266DXQG91RdK5HQdog/8zSUrdYoY+8Vjb1KWzyr4VvzEFfPxrr4W7JexlLYnEUwQkLnVM4IvtNy29ZFVf5UGAk+GjSp4FKrQR3mZcSKPgIWhyUlE7wq34k5YKnrCao6Ag2m1PqeKYkN1DlsgVfP4HWo3yBbxogLL1noQSvJki+KxT268aalrsG3QBVQ7B5dlEVcQQzEW0gCBlW/VNEOuaFL9jA00OyX8AzoJKuTid1wZvZEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1J6pmii58u3ly2fi35pL6zr+JHMg7mSwl3MydzUc80=;
 b=o1f71PmER+ycXaYhgb2CB7Fso5lrWpTohyxOTXsObpQV7yv3PQt2rK4CcfiCsQMKZIiXK9Hi7QTrKisPrpt3Xp7KkTUw4nWk4rv7RmxShFgmry20b1w8Ud8NmRIrSY4lIxMshv/+vCKa2x2ngeb7JLrYdb0Nx10SbO4bIz4f3oo=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:14:26 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9%6]) with mapi id 15.20.9499.005; Tue, 27 Jan 2026
 10:14:26 +0000
Date: Tue, 27 Jan 2026 10:14:23 +0000
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
Message-ID: <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-7-elver@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219154418.3592607-7-elver@google.com>
X-ClientProxiedBy: LO4P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::13) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7068dd1b-4733-42af-ac2a-08de5d8cd96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiopfydLSTEEtI2zLFWz8l51qp36QAUDsLNam7Ic08XQUzTe4GBbEeMHmx6d?=
 =?us-ascii?Q?LuNTrXsx/BiO965m30LdkN1/Msc1+XtzDqB086POx9WUUCRJ8WYeRQibLEUx?=
 =?us-ascii?Q?QdurrBNkOam8bUn4V0a/iGwzv14sZBCZkjqNtA1fJbTAj1bGtO+cz8NxXNXU?=
 =?us-ascii?Q?gFTliW6Rjkvml18CNMPxvrnAuxLasZxs8j8scyTwqCalMwf3RatoShqMhelt?=
 =?us-ascii?Q?9zBQJwJQ78jbsV+NxfV68vAH+aNfUqJL0h/bEtAdw6NtlcMAkX+KqF6Mzey1?=
 =?us-ascii?Q?H+qbckDAxABICdBuXUKSpJ9SmZNAbjkDazsnNWVwoLDB6RoY64NWS9qZJ+Nx?=
 =?us-ascii?Q?DJ3+WdC2UmRo78IJqq426PuO0y+Hes5lJeORa5lLE6hknNm0OQ/qsHOnEkHs?=
 =?us-ascii?Q?2gdRU0ZoJh42QPwnCWGa+Jl18LTOasvn9vAISfTnhMJXV3xgoINbfcT63N/0?=
 =?us-ascii?Q?gPWTSMDq08yG6BIu56KiEZS18Yz57KRwaYT4XJAupg1nW/WDgWqC5V36GynJ?=
 =?us-ascii?Q?bLHE7Hp36XH2LU57YnTkFcFkj03qmLvN0UW9dvvB81DjYzIEciEtNaHpc+c6?=
 =?us-ascii?Q?gMyGSmpry3mAnekineO356duUfeOZAKEOdZzECxeLbR1Gk6JQL2hDhcTFwEQ?=
 =?us-ascii?Q?qa02UrRnm3pN8e6KG0qh4D1uws1mqJeTa6AOWGzOs4Yn5TD1QfPNsI7dICsK?=
 =?us-ascii?Q?S5EgLkBWblQsDDmFgDZ8o1FnMKb+fpPVYFnhdgErj6T6ai1kDhAhUt4lKDY8?=
 =?us-ascii?Q?5opu4Lks4+96grlx+vWGdl+hqM8F60RBpUtevBDKn8yJEwnXofJmeqCXGmup?=
 =?us-ascii?Q?bOOs2ogCa2Txjpi4qZP8FnNwKi5eKGuT+UY3PnTPGo/bSMIIMDhiL44fu4VA?=
 =?us-ascii?Q?APR4NhfSvQFx1ztCS5hXfY4vEUVDzXCJtzpwtENcH5Ixnp8kf+YoGUFBcC91?=
 =?us-ascii?Q?ks4wjtp/DkktjmMalXZ64uF8Z8Mx+bWQaYjK0ziVQF1jz1t086nk0Mi5mmu2?=
 =?us-ascii?Q?hQyIxDrCINBgVQCkQYMnoInLebCzXMOV3XtQV+mfrarTx9CWmSmemdQWeK8E?=
 =?us-ascii?Q?PX7oO/ka9rNDbJqQrkQ/P0X3c94lDABslyQQaDGwalNX7y31xWOQAuyUj3zR?=
 =?us-ascii?Q?U4Ap5880DC0iAoEh01en4TBEtYHFEAcJT/l8XWTLuwHGAu0K0h2W302nnmMp?=
 =?us-ascii?Q?zQPKgS5YXUVk6+LE6nrx2L3SAWjQy2K9Uit1hvZmvj+hYMmy8fMgIo6u/XPL?=
 =?us-ascii?Q?pj+MknGb9IlSsKKtOn644OfLrTNXJrJYtoDS+iGOblIY4WsoMaKAl8bvIntS?=
 =?us-ascii?Q?gOZPLcXoDRL47kpyltvd6W0Ytzr5sbA/GssEMWg212pe+lfvVcg38sjvT6vw?=
 =?us-ascii?Q?CnhXXK3VuRMORIwrSFEo1uUDKMBL/tbRU1JQPnLCNhVBTgXvhWVP+PNs6JdL?=
 =?us-ascii?Q?RSaNVFsAV9VY6i/FfmBYVCFNc7U0+LolcFRVUus7EYdQQryXXvjx0dY4Fy8B?=
 =?us-ascii?Q?n00RoxPtEIm5C0MEVWSSKDz4d/NErLhs8H8o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9aD1hMaUn2rNtrGTC2VOuY9P2glWY9Q5KQLAbphnDuISn6Vqxp30UkTXzm1?=
 =?us-ascii?Q?E7fMO/vBHxJvD2SHZ50FW6dn3ASlTG3yRNxQ2cRmNGAnn2oa0vE3MeboZDhG?=
 =?us-ascii?Q?khIwIje2id3WVaEs5KNmZ0Sqz6f2TOTdwGnWB99ReNWhxadKihtCpcCkF26k?=
 =?us-ascii?Q?WCZyjm7iwUgmG7+7yy0l3s9aIxX/6UjBleyFa8aY4ZkgUpex4/denvLz/XMX?=
 =?us-ascii?Q?95wdN6KNVCUFTpmWl4mCH+ckR7uwG4UZOIl05XBd/aphSJkzNbXaK9KPwLQ5?=
 =?us-ascii?Q?HQK6PSVkc0YQWcEljJSKYXV2spPvhKxmGj5ZhZOGwP1JjvOV5eglQBq3l58j?=
 =?us-ascii?Q?hxCAUvbOlBpZsTF/VxCgjmryh6OWSSg2CCYC+d97kmQPsMfNHaEMmxy/CVHB?=
 =?us-ascii?Q?TIJXRtIUV48pBvfr0Qm0JiByjTLNKd7VxsE+Juzk8/Yg/qglKVuioXcJ1lfy?=
 =?us-ascii?Q?zd+lAQChQiXAGzpxErLnOXoamskGcb6NGxO+E9ooBnHky2Op89mTvwgHcD17?=
 =?us-ascii?Q?b0vCBXfsrUPX4A9n9wcEjRVVQysXgfsVinuWoF2XfuohTzjFnmEI43ZxPMtV?=
 =?us-ascii?Q?A8yj3NZGNq8AnvRPdDru9rUGztxlc2rp29WHsquum0ZsmHL2O6oqeBfG6h3w?=
 =?us-ascii?Q?4dPGRU2vpX34AKCsWC78LwSZ/7BawAOKYU7DBw+DHnUiIq52FKTRGxr2SVBF?=
 =?us-ascii?Q?XtZDf+6HOMTHCFcjVQJ7axbAwSB17v6Z6rwutg8u+aqxxmBa1EVhcIgmhhIO?=
 =?us-ascii?Q?ylhBd09IBcznX4ZhSre+E8XawAfvL16yOaB8xvsXIqjKCqWIVR0RR3diFIL0?=
 =?us-ascii?Q?Qk2SRkb7r1eO8vVF4dZcEO9w/S6poGhsEY3j8P/H6CnD6Ct15KcOmfkPRAai?=
 =?us-ascii?Q?5m+yPRmWB+5qnxqRgCQaiTG9Tbbf0My541zSNN/c0Gd9GQnv/U7pdofdUhyd?=
 =?us-ascii?Q?mHnCW0JbrW1XkXxKYW+FlnVkHT4d34y3AX/l5Vrug9YliTeNlC5vMj5XQ3si?=
 =?us-ascii?Q?W8ILPC3CQiyWGZNnCaKu2PEY2iNhvAabo3C+Pqpz22kTjrzhl7/DEEUa4UQC?=
 =?us-ascii?Q?gYC28ZGPnElZm9CfHi0Ybq+kQDpcYJSFFHC68/KRFGO4bE9/ypr7KzeFo7Ew?=
 =?us-ascii?Q?Z5aPYhwvYq7uaKqrLwHV2ajHnzjpkkab4I7XL99RFNTtkpYdcrh+oD0B58Ka?=
 =?us-ascii?Q?2CGUJtKNvenLdhs2Wyran/X2I428M4GNa8TK46gNSvUVfJXrhEL78O1AcAoF?=
 =?us-ascii?Q?jjjgDsgbpJCG9UbgXT88BURuSQyRb00kzbT19NYW+OTW0wbtmgGQwt3GGu9s?=
 =?us-ascii?Q?uzytySvE7Pl2ELwI5Blq3hnPyfE/jjTUDb+kvUJrC9XkP5mskSe+eXfb0lZP?=
 =?us-ascii?Q?w+YGoJs9eDNuEoB3ir6NRCtjRKJ7zITVad1IFBNonaoCtzyoikIZcdL+3gha?=
 =?us-ascii?Q?felok/Ug06N1zDyT2SUw8E9s2buFkHKEfCRBhBwXelfbv8QVyybz73mI/mG6?=
 =?us-ascii?Q?UjBdJ0NsH4QyEAgfeupcKmpt2qqH2iNiSw1H8NDXm8AxAYS1HaHM28KVdABZ?=
 =?us-ascii?Q?/zVW1HL9iBL/MJoE3MydWL2VcK8vGf9QHY427/nzwJ3yNdLFl5G+MNf3YgnJ?=
 =?us-ascii?Q?Mr5XmmBEgKnPCnq/dNbO6w7MiMbKZ1IUrJztlOEakRvur1qaIJiAPsGpkU+Q?=
 =?us-ascii?Q?vDueJTEXOpNOXJlOrlZc+drmKekjyhhwfkJIpVExuFl46ntiDSHmMiBc5/b0?=
 =?us-ascii?Q?bBCHD6lxkToOIJvXmcwGtAsaKt1C6HM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kiWQT1lADjxeL9t0f7OQ7pK9q38lVNpBdLOVeqde2AJ+W3pYO7xHJFoTcWBOVNT3qChgVUxa0T9t+1cencS7uGtd+ZvJKkJtj/zDjm+QFCT+iFwfUMZ1JXCYIjRmY7RWzaLpjW4qa6GM6TEXor7NgxDX+/mYmq8fXMcs8LTXDLQFDE5Z8IkWJsT24uUWJGYv4ZSREekYM6/g5jDWRaGeEfOPBNlGW8MsL3fkUBGMfpr6JTJgIpPyY8cnv34KKpwkyrHp+Y3m4t+S4ODl22EQXGF44D/M1guWfbdg5/h+7A0HwGuHeWvpH0U5pUGnyZQakxZzVHFAYoK4o7JjIiGKLp/89fw25Np6r7kzBbpnikqhu0j7T2IoAzCWw/bP1NBpJjk4vYw8mAoF2+Uxj/0T3pfa3eSEp8IB3WHfc3zXTOHH2GeaWjJcFVkSddiYqTfTSGVLOA4+uYMSQ8A6xfNPyLdLtFU6P00iTB0H8RDsfu6hObejAulLQDWWP1Rt8OTFGpKA30SmaK/OuRTqEasFv1wyxNrwnzVHFFuYGYdTujf7hyF1JQq9pFRW0h3e43iQMnjx/zffYfAoAUzRWAuzOIPomoURNtIBZKKwYU+TcNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7068dd1b-4733-42af-ac2a-08de5d8cd96f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:14:26.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuKOc5JvYAUcIBvlqALxaFezaLEwNn80eIUj45vhO5illkh9H9ob50LpIp2xGWfJ/MaEv8WBhVJwdSDi+jPVdnSOZDe77hfet4N1kWxskW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270083
X-Proofpoint-ORIG-GUID: He4WiiGlgFPczglRfGwPLFY3NIOY12lk
X-Proofpoint-GUID: He4WiiGlgFPczglRfGwPLFY3NIOY12lk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4MyBTYWx0ZWRfX/TecSLFTCZIz
 f6Qzi2F3KPwlp7PoXf1GqFkSbI56uFzTRWUVcAAHnuC5gnY+qT7ynK+pSIw0pfNR82RnBEK/7Mg
 q6w26DAdnXbodC5l++Ixyp74Yz+eCe9GH8Uia2qglokS2y+UZdIlzARQY8u8HYEi5jkT7ap6zIA
 Pi4oIqmQwSHJQX3S0ZwAiOhkbOmrWlZE/qQTlVdlLr3guIo3URiQGQDT58ziDxXk6iYgT5BgoMe
 21OLDTknYTnbFNf9+nEpeNlNRn5HmckpXsxasxKLCYnnixLVq/iLujHf/+/KJM4bIKpSrA/9sJv
 k5ffUoXUVFMfIuWMj0dwjGp7jr92HbaHLzR7s/9m+LtksFnfBkgUmMYZKD/WfbSm63V9QJI44tQ
 NmOtTKuiWSvbv9SHeaUl+hnnYDHhCAHK+XFY+2fb0ZMeI5Wrs/4dn1KZnscskdSKkm+T9iVAmLT
 yJLB+N7BlH2FUUFprFe58D3W2bul6SvidhlYVJT4=
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=69789007 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=8dcgpvhtuFq2USLAdigA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12104
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31215-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 16A0092B71
X-Rspamd-Action: no action

+cc Sid for awareness

Hi,

This patch breaks the radix tree and VMA userland tests. The next bots didn't
catch it but it seems now they're building the userland VMA tests
(e.g. https://lore.kernel.all/202601271308.b8d3fcb6-lkp@intel.com/) but maybe
not caught up to the issue this one caused (fails build in tools/testing/vma and
tools/testing/radix-tree).

Anyway it's a really easy fix, just need to stub out __no_context_analysis in
the tools/include copy of compiler_types.h, fix-patch provided below.

To avoid bisection hazard it'd be nice if it could be folded into this series
before this patch, but if we're too late in the cycle for that I can submit a
fix separately.

Thanks, Lorenzo

----8<----
From cc2390dbefed156757f001e8c3a500a6f8aa1244 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 27 Jan 2026 10:10:55 +0000
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/compiler_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index 949b2cdd3412..ca60d491d4e8 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -60,4 +60,6 @@
 			__scalar_type_to_expr_cases(long long),	\
 			default: (x)))

+#define __no_context_analysis
+
 #endif /* __LINUX_COMPILER_TYPES_H */
--
2.52.0

