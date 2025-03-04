Return-Path: <linux-wireless+bounces-19762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29B4A4E3FD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BFF4210C8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92EA27EC77;
	Tue,  4 Mar 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="ah7Wm/jv";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="QpKNz62P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23227E1C8;
	Tue,  4 Mar 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101802; cv=fail; b=oUjfVQFVFJtrS4VSw9L737lmkvvVxMMzXvBkugNn1PRz/R0p2qQEMIEKUEmMeFfl37HovPrF2SUf2alko9z6gABNI757EtF2RifuDos9GpFKboR/K/bv0nfBoJN4PJtW5+g5yijDjzqpQhqrt7LH4VvRJJFe3Y8Z0BUXaRkDJOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101802; c=relaxed/simple;
	bh=lTsSuUO7mKJO4R/z1HFiQ7nhnw1wSX/amLy7Xm0JtV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rquPqlpT0Q+ZtshId8fJBlUdxgA5PbUUa41LWaXWRj2BYAsrkzGuDxscoCN4Eg4zfJvg+7jbi2HBPm7C3RNYZZPGaZx20yQs2XS0fZSoX7/MOoiPnIHWJt3J52UUbTEZW2gBwCAX5Ce4LFnGrgm3qDv2fScr6ypFTjir/HejUXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=ah7Wm/jv; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=QpKNz62P; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524BF7fE031961;
	Tue, 4 Mar 2025 09:23:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=JhTp2m1YeujvBSz0ocXfX/yOClyQms/PsT7IwxVgzS0=; b=ah7Wm/jvlKDT
	aJFQpRJTly00IeNSFw19oWaaUj4bHNTjclXfJK75Ao6ZFDReFbStNLityt0aLBsG
	zquXxh/BTw2NP8kh68WTRbxeIZEp7uS6qrR1gzvVvhzArNfD8U6e2Jkwm1ttIMuQ
	j+DIcY95yaYfDZ78XiQgZh8o3/QD99GYfc/+B1K0qSkybrKrNL/7RWUahRWL87z3
	nQ07CdxoZQa8nq4Plaasic10OKys2bTrBr5FxERDgzMWlG/v42RNg2Rtr09YRlhi
	oScasFSETe4+qQzjjIEttjWrnPATR3ZKHygE53Tqu+n0MY5mh/jgYyRAi4js3df/
	TDSBbdu0kw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchhc40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:23:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7lHMaAMbmZ5Xe44388ZfRRb5cSHSiY0tk6GYMRG88pxv0RUWl53QuHfPuL24C5N8I9NNN8Yj16N5B5GTKSwy1GE6IVN+CzHCZfIzMKzA0Im5ht3bjS0sHqv9LHDabj/F/CnPkDoI0XHbKxRqpYOEXY7mMTGvEPSxYSkyc8+GjYS74KdWzCnAZwmjvxK4Mpfs83OVIRvIh9qTxV2cCvDGkN63Ufckwn6OhAodedlItvkfIldtyi/bNBFRlTY3Uy/23/xSQ3RjAbkBrqMEj+JTbYiagQvoSscDo9E9o0fyWfhYi60BB0+VFed6oq+aRTDiB26+wT7qg9C1bLw9b7dvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhTp2m1YeujvBSz0ocXfX/yOClyQms/PsT7IwxVgzS0=;
 b=SW2bxN8l8xQfgbiLEJidkeH/QQsy7F5fHrFzJALdzFQJDpdgDvsZnhl8pMRbdJaU9XiCT7TcPbjKwtt7SpM83FvNYctSoD+NVoCtgNpcy+6ZakDeyXqFjSJxdBXpmhtksAI1SwnOXsGrKb3+qp8wyyInsKCZl5ITJNiqlI735Mpv2139Ao2D/n/isS+/d5qwJcqAUF9N77jI0ushutuFUTkUEPQHxXwY9pNGFWmllm5lyntbtr2P+ez0ExIC7spvILYJo9xIvTc/Vrt0wka9ez7KfkQrWDrvjOb8Hy14RLjDS5yA9C38KPj/unvcjJe/anksG/LduHLKqnrh5ySbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhTp2m1YeujvBSz0ocXfX/yOClyQms/PsT7IwxVgzS0=;
 b=QpKNz62PuwylCIchPqUAPrCQ7RGQhE4+QttwXJnS7dSstTa2zsjZN2lnEqptCTv3l55kvv2EiQsd0N4SUP6p/JGcZ494FiEsNrcWTSYG9ly8emobstOQ7yxGgPYE4uTGcorzZS1jmfXoQ9edrYcgJ/M5EpSjHimwzX130iNMSsw=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:23:00 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:22:59 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
Date: Tue, 04 Mar 2025 16:22:55 +0100
Message-ID: <2018315.usQuhbGJ8B@nb0018864>
Organization: Silicon Labs
In-Reply-To: <f808c48596ae1929c62704c226fb109cc03bbd2a.camel@sipsolutions.net>
References:
 <20250302144731.117409-1-jerome.pouiller@silabs.com>
 <f808c48596ae1929c62704c226fb109cc03bbd2a.camel@sipsolutions.net>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0090.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::7) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SA0PR11MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 62da93b6-e174-473e-e94a-08dd5b3072ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?owN/QskRYQ3vAtq/vmC/t3LXiEQpNUodry6lDUCBj4MXrdCJRS4j2R+0kK?=
 =?iso-8859-1?Q?V1g3AvP+nx+pBXXUuKB9vfdPM+ZWCv6H01M32p1/3JV/Dc4sjWd2ZeLRJG?=
 =?iso-8859-1?Q?4MBv8Y9TzeCvsGIYVpG0fGS53RI9F3YpS0r1EK5CtkljM7bo6zWsGZwWhU?=
 =?iso-8859-1?Q?GaoxF2K76sdiEnRSMm/DxO+NaslqH2PHFfunwYZkDN4S9434VTyVyKS27L?=
 =?iso-8859-1?Q?r0rpTdoaVAM5IvNFsq3hMT99lwZugdIZSjuPKdnpKHZwNp8Npq41EAhAjc?=
 =?iso-8859-1?Q?WAU88hVOavtSTNiuFlVc35ckMUE3Uh9EDTyMkbibw0kTIRIjsUYix0Jxh6?=
 =?iso-8859-1?Q?8sE6iE0FtdklyktFITUjVxZE+UL7Ou/RmXAXF6+NhOsX9xMzXCVSTxTpvw?=
 =?iso-8859-1?Q?DnLhaFKD3GZ44/D+cW1gOyQ/Lnix2r0llkxgAgC/NKt71dOXemoAvKaaJI?=
 =?iso-8859-1?Q?cT3w/2XbAtiXp31NTLTU86aW25D5pbHSULqlOeOqXzQmCP8YtwYInwUfnk?=
 =?iso-8859-1?Q?0VxzpInl9JEQZPFx4AsKxsJpYp7Ywbbrp0iJcW+nuUXatsCmN2vRL2S0rY?=
 =?iso-8859-1?Q?pXtSLTORYI8/55YkonIRf9Hy83g5uVP6KIvzYa6vftCpZnh5gHNpw1PItJ?=
 =?iso-8859-1?Q?rRSk2n/sLOn5eBb1ohCceklxH3bWBdcLFVGb4XShcpKiefxVye3AJXccTn?=
 =?iso-8859-1?Q?J4R/sogI1UjnLJHPR5ULBrKeULhxKnjAJVIB4dTzQM4jsKgetqY/4UzAJv?=
 =?iso-8859-1?Q?pK2MmPVoRGspIWud77N5D7WoPnMs7iwTdHlGKCLGaNSfGlfozYaHxcAONQ?=
 =?iso-8859-1?Q?1z63JtQ+AAiCij0w4TEAKpZ/eiSuDvXix31RA+WvXTdkzUJuPZTPQF6zzn?=
 =?iso-8859-1?Q?/7Y0vFsaxBLkL/1sw6KI6rtJvftcOhpad4BynzliOgf4AhbypjYLq3BWHw?=
 =?iso-8859-1?Q?2/VsJF/ZpVHLegMFWoPdGpTAaJfOvnq4emI2H1zZqYvYuXjgv80UsluP5a?=
 =?iso-8859-1?Q?f2EYuH7aSOkBm31Da2nioJEa7UKp9hgcLrG69jifyDv+X1SepPVuxOYJsq?=
 =?iso-8859-1?Q?DBqSolKzy3F/XgVCZu0HdF/jLJUHjekLMwmllPsaJNwGGPYwz+0sZEWFBz?=
 =?iso-8859-1?Q?9SCBs6PseCeDf+w5eUUkAYERxiovvO7AKp8tqkzJ5jxBjpR8ltpuJDsQNe?=
 =?iso-8859-1?Q?/VU0MK9U7QikKPPifpqB71KkfrVGeITwzapSLTnjh/yDlW6ek9wPrlPFra?=
 =?iso-8859-1?Q?bmJqvx3DYMg82yjdfQX0CVcVLmX6NKCQvkpt4viMC086GWasdWb6J0kJN4?=
 =?iso-8859-1?Q?/X9Vqid9L2sHw/YgrKlq9AP3S3PJYhsYusRciYrrzIL6Uoc19Md0y2LaR/?=
 =?iso-8859-1?Q?3YP0Wq43sI3kVSJtElADZfbq3THSLhd0qaECrufBeAl/CdzFumZTE20XIj?=
 =?iso-8859-1?Q?qPYNjnjbgIwBwhUmZHNWRAZluune6gfuItEwLKXM3InOUzWx8l22TK+vcd?=
 =?iso-8859-1?Q?qWXNVEASBR3dMrk+dO0Zzg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PcQdR6OqvRr2sscNM4rNZp6nCsyl0PrTitmoiFHJo3jevQ44T36Hs24cTM?=
 =?iso-8859-1?Q?OOeBMnAubZEbY8VqxGxp+BwW5aIyoPYfvWLpPgA0+bqEeP1pz7HDmfMrLk?=
 =?iso-8859-1?Q?cHnLAppvTgoblte4PSq1nLrDhpAHkvxS82zGQiSLEF17oFk8vAwn6DJYwV?=
 =?iso-8859-1?Q?NMqtf8uxfFfu9fkgSzWsblf/r7ZIpGA6ZXCrkHxUsFgWmbcw9bwS31fAJE?=
 =?iso-8859-1?Q?uSSNiLD+PK8MXgCW5hSL6AFPpFWx+E5hqcKKgIK4HNQFjxHmhxMY8sxuTT?=
 =?iso-8859-1?Q?hTPG9QuY1JvdZBORxms9H+T+lNrdRvtyjs2pI/8gUkIIw1rN7LpeBsTxDq?=
 =?iso-8859-1?Q?hv8XZXTvF2XyT/t76RjNL3/6/rQi4Nc+3yHZGyKbPWWPvOH9E3J5WvMNyR?=
 =?iso-8859-1?Q?SC+k5IiUPZCFQwlU8Ss30gz/+m9LBBBWYTEWANxZOBELmy9SCZp0RVV0Rc?=
 =?iso-8859-1?Q?X2bhPo2JxJL7Cvdd5xgmHsY+eJdg+Ds9tEHbKWxTqCqG+6HZ67cr9G9E3T?=
 =?iso-8859-1?Q?PEo21CvFmHskUBsZVAagxzNjjvZiS7ubmapRzLqR4OtfGKkcSN1CZ2Y3eZ?=
 =?iso-8859-1?Q?EEQu3BFWW2PaprxiOZJiVYhuDi93jTGxDb0knMedP5gY7+Uj9H44+feuMP?=
 =?iso-8859-1?Q?CQEk7sy/Wz33RBUMbfDQ0DVsLB9+XC5UuUhfge4c2m5+06D+b3ueUZdLOB?=
 =?iso-8859-1?Q?PjM3/v7+A1sDMq2arX4n9braVxAYEwLs5EIs+LYxjSI4uiD1+Hn+g+4jaR?=
 =?iso-8859-1?Q?Bn9Y07W6JdHLHrmpLT+ME4f6eb1n1Z5VDGl/PzOIVmhS9hb7j8DnOiO4f7?=
 =?iso-8859-1?Q?LgERuPEiWowxbVpEWaNAPi4NUJbAlZ9iwhxkAmOjmoji8Gwes7p7nKZIyK?=
 =?iso-8859-1?Q?fCIt1kla9vxxerNL5LlWZOqkvxW7qQm7jKowOctQCvP5pa6Nsf1vwArcEj?=
 =?iso-8859-1?Q?0LR6/cX685Afi677AyyBo+ra+PZ0AJv1c72DEpitFPMRbPm9Rzg9pEpUQI?=
 =?iso-8859-1?Q?AL0/I3h/INplteGc5U8DLbfsK5aeu61s2v0nawNTKM1/imLPTqxAkSivRr?=
 =?iso-8859-1?Q?Di8y/As8VoQFmiMQ+ey1Hxwm/VFmRVuZ2iWtLGXVda2YnCLooiJe3m0qde?=
 =?iso-8859-1?Q?KkvudarFVrnM1EYyjlbZUcbvJFeNd1qm83ifOjoICxOaayAdxmyMoeIdts?=
 =?iso-8859-1?Q?QayLPvA7tek5z84oapsRNnTapuTyMhf0U+PQMgh9ZDtfV02d5+IOODxdkc?=
 =?iso-8859-1?Q?nXY76QcspHd6ujc/mJftfIvB0q11u+IKH+Lvcr9yOXfTzyNEd7zVoEFSSy?=
 =?iso-8859-1?Q?N7Hp1CC7Rznk/v4QPJmV/jiCYD1Y9AKPSJUjwwBlUSepBC82G00Wm3NsNV?=
 =?iso-8859-1?Q?YRnOwJSLsR8aVWZhuA2foObmIK3x4oOTVLm5b1vSY8pWWhrqGdc/AlBEwx?=
 =?iso-8859-1?Q?ga/dj6r4N+366cpMRwlQrDzKxU+mePUgDbUG/2Iv0fdlwCFUxMUW3SVUle?=
 =?iso-8859-1?Q?L6O3cBTYQbV11rx2Tld0yHFVAY1fZ3s/J2flm2lkPKPPUBQgWDFX8Is2Qq?=
 =?iso-8859-1?Q?OgKv1vcot6aKUGTO382oMS2IYgGY/9sB1uBWtm2zW/OsrAHIh79JjMYuL7?=
 =?iso-8859-1?Q?XHcYk5aPUsNlxclfTrwMxqYfdzMxMNS/Pj?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62da93b6-e174-473e-e94a-08dd5b3072ac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:22:59.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN3XJh31moju8WcKv0MZYtAkC9ywUBfuLWYO1YGsPTJbI/oKpzeubFB2h5D1pYwezNpP1OAlkp5+t/PoFJI7Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c71ad6 cx=c_pps a=Od4c/DwoOySOAFy+VEE6lQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=VwQbUJbxAAAA:8 a=_coXNeLep7at60qCJQUA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 5CiURea-NYM4cPlyNDlQl1wVe16C5jLj
X-Proofpoint-ORIG-GUID: 5CiURea-NYM4cPlyNDlQl1wVe16C5jLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 mlxlogscore=972 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040124

On Monday 3 March 2025 09:20:11 CET Johannes Berg wrote:
> On Sun, 2025-03-02 at 15:47 +0100, J=E9r=F4me Pouiller wrote:
> > This is the initial support for Wake-on-WLAN of Silicon WF200 chipset. =
This
> > version focus on the power management control. For now, the filtering
> > capabilities of the chip are not exposed. So any multicast frame (=3D a=
ny ARP
> > request) will wake up the host.
> >
> > I have this series of patches in my git tree for a while. I hesitated t=
o
> > send it because the code is based on a proof of concept and I don't hav=
e
> > access to the hardware anymore.
> >
> > Therefore, this feature is experimental. However, the only way to reach
> > this code is to run "iw phy phy0 wowlan enable" or explicitly enable it=
 in
> > /sys. So, I believe it makes sense to merged it in the stable tree. Thu=
s, I
> > hope some users will be able to report their success (or their failure)=
.
> >
> > v2:
> >   - Fix compilation issue reported by "kernel test robot"[1]. Member
> >     'wowlan' only exist if CONFIG_PM.
>=20
> You should probably check patchwork too - now that we're running some
> checks, a missing 'static' jumped out:
>=20
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-wi=
reless/list/?series=3D939353__;!!N30Cs7Jr!Ru1BMHVjq3TxTX0c6bA3EDM0EzKM7JcHy=
eEUJ3_-J4TFLsLpY-jDSudnehLp3DzQ4Nutky9oKreyyjRstvmwuPVT0tM$


Patchwork also reports two warnings that I am going to ignore:

  - "Target tree name not specified in the subject", I assume it
    is "wireless-next", but in the doubt I prefer to refrain.

  - Lines are larger then 80 columns. Checkpatch.pl now accepts up
    to 100 columns. I am not aware any local exception in net/, right?



--=20
J=E9r=F4me Pouiller



