Return-Path: <linux-wireless+bounces-11088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58794A946
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94821F29CA4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F5282FB;
	Wed,  7 Aug 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftEhZWow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47921373;
	Wed,  7 Aug 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039370; cv=fail; b=X5kj+jHBbcfv86obl250Uj8Eed1756DtvVVvjfTF7eqM/hrfubxcuTwuQXAgNY53PyQOQXEXDW/RjiWEFNo3eOoQi5PTHpg+VrD3xJY9fWxTjCr0f6cqntUVSKylvmCVXuBDXIr5xhmt1m8pdaJ1QSi0+mHyH+SWYrZWoH21vaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039370; c=relaxed/simple;
	bh=7B0v1FsH31XC3Sp23T/foTUqi6RcWDJiLZe7JL7/ehU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czkTxKE7833TSgBh+kKvGzPlkEF+yxCdP50BiX4aIELMAw67Kb+sd8PYZ3X8bqSPXBZ7jsabMTaub8OlA4bFMAcVJjFRBZE44obEZeOR/y+DAbkHPZ3Db/1v9BeEbJ/YLwLXQ1LpY7N+XX15LL0euQg+XepeaolZIV89TaROcx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftEhZWow; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpFzWMTbnsH/yimFgi2AmG6pTn2mJnZzzmCdaSEnST2/STwGZxWndrxRBJAqlr/YicHYgFkCb30Bjp7E3vzqYKpPuK7LNairpbVoMTivZk028NZYLS1/IsaZKBZy0KtrQirl/pDyLy77ubWuIs1Qh1eqTSqGLO2/XG66tkK8r7btzKB4UKh7LBDc/xyK51+4RwiiSq6yWnQvrOwFk4awNZ9R5B1AompxQqZPJVqATnANRYRJ2BbdqiNKekvA09URA5KRH8zTf2KYmdWTFqX38GFo2QmQUd9gH06nNOj9m/4/I3yeQi8rKpSMFelPgmwNga5TCJZ/iU10AjCWWGxzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Peh/7w2Oh7vKEcCjmNJgmPeaaZKpdJmSM/cgGN7jNDg=;
 b=uepVQjS888IUrgaMOnSMa9rfA72x7G4Dy7lpC9SwyCOcg6QDlLWUfNUesBF7BWt1FSr7XP571H5Lby4afS05O5H1ZCOIG20Hd7nlGwBmqfP5cjoP7QWjO9KVF9tqxdFAso3tmNKPOiOOMMhWuUOp+s19lb8s/eFxSq8Wl828KdhcoG3gnFxRXT41exhap+KUSXmfaJ2fbNJEHRhmcG8f79UUd4NO8qEI15YNislxnRWTN0sloGD8D2GhOO7PqTj/Ce5M/Ag/O98GY5OK12ppEec/T8hfWhRx2tRqwyT5hV1T2RI7nBlcCiEkQ3EPWsZxTPp8yY3/5mWPT1voGCd7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Peh/7w2Oh7vKEcCjmNJgmPeaaZKpdJmSM/cgGN7jNDg=;
 b=ftEhZWow7mQB7i20d0Nr/t36+HQ74SiSYU0wSvylgrvbORNIyButpVPnJJWpxHP5qcgNOXmujAtAb6Vp/AMvWYDTyLeqQ7GXtkE29RGnESGJ4aNQ8E5JU3/H31RRH+JRLhqUjn/uqJ8s1iW3mNVSD2xIAelBrkRALh67bkz0K91cnzQUS+S3s2yh9y3vh8L0SD//eCkNsuXPHDxnapWcmbG3+sDXCuA6KjR8NVR1aH54eK1DVslsmNHGqk1BHD+oXMneWkU8K+gK5lBTCEh6Wv6ZlmF3K8MFG5Uouk7XESa2cn9ASaTTWpJP3hJ5pUzewdFIgP8Wu6qOtgzMD30Z+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 14:02:46 +0000
Received: from IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded]) by IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded%6]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 14:02:46 +0000
Date: Wed, 7 Aug 2024 17:02:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: hhorace <hhoracehsu@gmail.com>
Cc: gnault@redhat.com, johannes@sipsolutions.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvalo@kernel.org, horms@kernel.org
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix bug of mapping AF3x
 to  incorrect User Priority
Message-ID: <ZrN-fKJ-pJC0ItUI@shredder.mtl.com>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
 <20240807082205.1369-1-hhoracehsu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807082205.1369-1-hhoracehsu@gmail.com>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6163:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: a90041eb-b87c-4ba1-8a51-08dcb6e99d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcgypIf+FnlF9ZN4tFyar4LgLkuYGTrUReG2stjfpfdkt0ysh/6suUnPVsLv?=
 =?us-ascii?Q?pt0ANW3Kvikrjsafn/K5mZ60Y3RrMIu4V+KRcTWVsFtjyC82xO/X39zJeXVx?=
 =?us-ascii?Q?cagvRICXi4RzRtYEPICo+SzdkVrsE7R84SGDrv8IYy0jjCo3UrjjItk7HXGw?=
 =?us-ascii?Q?cIz3AvpJZ5T9hP8XGJ0emu+O5OF/GJDdcIPTTPq2wbATK2OiFDn2+z5Zks9Y?=
 =?us-ascii?Q?xmYAU1cFvpoUHoB2FoEnLaHW0Itt/dTqc/OUzjFMrOUezByz2vP3rFDWMGPQ?=
 =?us-ascii?Q?ezO265SKbKuA0SaOTocVkwoW/oaDTeoCinm9t1jhpl6SfHAYdRlkMFpkBYa1?=
 =?us-ascii?Q?Gxz+twb/cCxky96wPfpN8QDHLPctsW1iZ1GYVeZ07DZPNR1G10QTlldeoLkt?=
 =?us-ascii?Q?imzv9vADs59/CM0ghQQAJWgyUb9hRv5RSTlkmao/msXl/mZz4P2wmCapSHJX?=
 =?us-ascii?Q?OkSUHvP9X0hS8Rq+KI3hGMYvuEXLCBtXvUEDljaYkoQyXtGIqs3JEU89mNCY?=
 =?us-ascii?Q?A9a0Jya3P9e3T/gyoyaYv290ARxAfuD/f1KSnayb7iXapzvtsX+lCpuWkY7r?=
 =?us-ascii?Q?lbiqvOb1ID351s61jmQJmLxLsOs5Y6ou88HMvUShO96UwqGu7/rXxuGNIJna?=
 =?us-ascii?Q?lw6PfoZBJOMPznYhmqb1Mt0ADWDrK1eYUT5XJ6sJ+wAUDp/FWvV2yc8i+UrH?=
 =?us-ascii?Q?VQg/rjwl2Uj55Aa782KqxkikOuJ+ku9ShWN555xQzeUdyyb3TxMW6W8KA8bv?=
 =?us-ascii?Q?REoV6HZwJWveV0F36RulCjviEcPWGQexOfbGbCi+Xd/zjCocbpfoHpbu9BVM?=
 =?us-ascii?Q?vjei3dWrjfGwNKBHHfi/UiubKcDpc/gmhdcx+Lxhh6vdCX5i0RW2VOPGj4W3?=
 =?us-ascii?Q?Xqf8jHzeyM9+CBiJzbmwq8j0UP4rYytE9DFrJj4gmrY2W223YZcW/AjoQC0Q?=
 =?us-ascii?Q?ic2yTMC3vPj54cpfen7xVzH3a0DFKrBTchamLElOzFxV7q3mKBJX7hvZyk7Q?=
 =?us-ascii?Q?7cLC6pq76Az8KzibbPBsuEG3HA2rWbKOPGM4/NDkhx8i1p8AXLGGCQhe/dzI?=
 =?us-ascii?Q?QeyW5Fu96Mvh3qQCFImQ9XIFM1A0Q4WMht6lZYi4grTiw5/+k6zDT/Q1hwU1?=
 =?us-ascii?Q?OVracUTyeRzW7ER7uuJJNhOrHeWDd1BgLtopTJ52XX8QqNlbmO9Bk7CZf+1A?=
 =?us-ascii?Q?h2CQ1HSjvJEx6ibyfWI0jz2orYnUvt7W0+ce/WMvLSZoIs32peFZN9tAId/N?=
 =?us-ascii?Q?ZE8Oz7X4LB3SEWsZ+lbMurVvM4wCRCmYwFh/ucpwCo8Zku7PM9Bv/78R83Kx?=
 =?us-ascii?Q?hxgXP3aUVQHMhE8QfwtxEN6eWFDeFnzsEq5npWKBya5pSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlKvJcM6nsh99tH1eHE4AyRTcH8zX9V4QMmdA1thtoUcXKGsA9iS1m99Q6Om?=
 =?us-ascii?Q?QNFOok4BLrkiU4Pn8mQoTixTHEBL+85OANplxs+SMPJDDdGJOf8+29pEzD/c?=
 =?us-ascii?Q?5Xcqj6wTcTMs3grx4B4NuhwxxiM2xM0KMPA0Q24PPUV37LQTGy89QmLj58Nf?=
 =?us-ascii?Q?l04YNErLJmXgU934ex1dngrFfUZF345xoOX+IaE6BYxIFUZWdeewonl2fye4?=
 =?us-ascii?Q?g8QkH7DisLaMBpKMX02hKk9qIL7NltjoCWAxHMcSCntziudMi6m6jHpUtBrE?=
 =?us-ascii?Q?tqRNBBuPFlNOufZC0qBZ6hbjc8WSIiBiOARL9BUsohr0GhwDH531Zv0n0NbO?=
 =?us-ascii?Q?8v7FtHokJDIe9TR9otvH8GC7qmg1NZR2dR+cANRuENjhCRnT91uDDCbZgRt+?=
 =?us-ascii?Q?gZntG2P1iDH6mzzMbFaXGUt/HwGBMwRRcDUncuf+6+PqnEErgE9RoKv9pkpY?=
 =?us-ascii?Q?SpKFQcgBr3IkEyi+t3GL2Nyrmlrj8sldalmD/jC2a6IDHz8ZZxQfeI0Xqu8/?=
 =?us-ascii?Q?mA9QOEFX/UL8r6LgHL5GhopodKkAhhK2RJHB/4p2SHGvjA5aDEha+6t7dNP0?=
 =?us-ascii?Q?Fg3xxJFOctVhLtjFaOVnbNvRUqdnpvF23vALZM+pcu6HcrRWT8J3ysHoMGed?=
 =?us-ascii?Q?HH8ixALRSTnrBUFW6LPJygk+atSrMnm3O0ViWZFizmzhmT5jGsrg8Q/EQbg0?=
 =?us-ascii?Q?8xhMelzYMIwXFurpJkOFu6VsTvaoiQukICO2r7JUyUCUO4Ot7HKQz5Ve9orQ?=
 =?us-ascii?Q?yLL4AWKc+GHSdl0A7OmQRkajQtI2rykri0PEeFmbkmDBk2qSVwj1izoN2yTk?=
 =?us-ascii?Q?/2p+JVdu6RxaL5Qtt8zqcRBbgbOt5j63w4sKRxcpSOZA3EtBQxhGG7FvJTV3?=
 =?us-ascii?Q?/zVKJU6KDrgL0BtmKdguLOXOpzmrxjDYTupidtVu+lABrARphHElQF9+Ywxg?=
 =?us-ascii?Q?A95neE8dAuJGR6NXlwXCGJw2VU3pH7iUA/nojYAxoCDdz+p9HqECKW8JF/M3?=
 =?us-ascii?Q?GkEBt6fqAcvUAaRXXmVYC0XutKNgP2jyF/B1fU4MMNhiRTNmpblcPkls4AWc?=
 =?us-ascii?Q?XYOyiXous7VUawE5tZifYGZUubXFCVnf+dX/Ca/3HYR0588DvpAuG/Oi/r3N?=
 =?us-ascii?Q?KKyWz0sFweXNlpkciQFyG1wcy21xXtqGK5O9pJBrGFZFuhYGnyoKQKWQX8AK?=
 =?us-ascii?Q?Gr3/DHFwGMFrc2cwT/8+qVWia3wlWkvWuZmz0dAgdZwEN2se0rR9YV8Ku7xX?=
 =?us-ascii?Q?SIG58q7NePaG529BpKzgfH6SLAQQ9VLwuBAK5vksOfsNkmebF4NRAMfB+bA1?=
 =?us-ascii?Q?4CnYq21P02z//QdOPkS94AY5eD9zxW6kiQSC2ivYM86GiskY5s2yJ3P7fnrX?=
 =?us-ascii?Q?fbYsn/wEgSz3Kf+7aGm937MXjHm4RJO8Zhvv9ZaC8DkP+8QxpGl8j1kjtdFu?=
 =?us-ascii?Q?fN4LorOTzupkZrXbGlckhCuzOMMbwzZswpCqpUyztykuNYWagXy5D1BJ6iwo?=
 =?us-ascii?Q?5+dAaPxS05prtqo4Y1z0fws22vKjr4LQyyHANgyO5ATlKBt1y8YD6qUJ6mPb?=
 =?us-ascii?Q?FpIjzkEzoGijN11UTjQ1bx+4PY/KO+8BtI4Z8cGr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90041eb-b87c-4ba1-8a51-08dcb6e99d1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:02:46.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB/VjtPCtSyzIRsIdu+js1IrG+C7Q54rkgjRkqwZB47KaN2RinEjuaV5DVz84pQCyjZNVfMmzRl8iXEHDA/15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411

On Wed, Aug 07, 2024 at 04:22:05PM +0800, hhorace wrote:
> According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26),
> AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4
> and AC_VI (Video).
> 
> However, the original code remain the default three Most Significant
> Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> and AC_BE (Best Effort).
> 
> Fixes: 6fdb8b8781d5 ("wifi: cfg80211: Update the default DSCP-to-UP mapping")
> Signed-off-by: hhorace <hhoracehsu@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

