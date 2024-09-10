Return-Path: <linux-wireless+bounces-12747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC3972FA5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846CAB2685E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8A18C039;
	Tue, 10 Sep 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="RAa1y33D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2129.outbound.protection.outlook.com [40.107.94.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD2184101;
	Tue, 10 Sep 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962005; cv=fail; b=SM+48mhtHfn381O1nVd7jqXzbHUG42ZKmaGJIjSeESp5wLfbiAY3Nvqlw6O/WhZN3xKDBUBR2cXHcUWAJYejFaHuoJQjzuZt7XbHFCiLDurVGCikImLfs5VOHZfJy+migHGtQ2h8Jm5QB6VYEXUJH5MIoOBAQktELID0KADhTAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962005; c=relaxed/simple;
	bh=aRrGsiKg0uojT4GHZN/rO9yZoPvouoE3c2c63s70IxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=udaIWjVfl0Ope6Is/obgPZPtmTzXWIh70vXQwP50DoRehtQD3Gr6Q1KdsKwF2pZvXkUj+Ugz6ya0EQptVkHmDyw91dfA+CS+dGTS3nSfentQBJRieS4vDDCSfLUeT53Lpa4QzDVLvtYIVSeo1kZyd5MCqycgvf8JWIqtwNqccGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=RAa1y33D; arc=fail smtp.client-ip=40.107.94.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsqsvnLrEK0kkBD8Wv8t6dYiF9EMef2iqzG7uVve38Moav91DrzW8BvJtxpT+kM+tHIchNHQ66tr/CotH5GpCUFUJvWlnnFMiVGgtD9xqBd/eweLY6UIE+QRK+tOixK+bu3q/hZLrNa24SzipAkYU1ou50/Og3pnF/H2zRnSCxGrD2yIgGbPqZba1AHDNlY+FGqV/+VjRDEzPisp9PAHBSNpILa4EROI8C3nSCIoy4QKwMrN2NiytINfIQNGJkRzYpetj2Vv5yJ5qOFLtrVwMJIwfUCXoNsip4Z6BSmEkSMXEIHU+pDdmz2emcQ+VpO2YuAZ68j0vNkSSPPB30pIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9CTWQN3noY/IQ6xr5lJV8GmCNTc4yhyPjTK7DvUi9Y=;
 b=iWEXN7iplH22AWqccWQVbXuHqXyLa3CrndLGLF1e/3htEAk0rPvohEQRB+bKjAc+bu4TOKgYwv9XbsonKB4AHO6IFFER0WS8Cf9XJS6l+UmF8QRy5qaMMdd+GKG2utMyXHra0o8LtpPhk5osHHq0vemjMGV5dkZ/AT/CHAbrMLz9e+PQy43Q459+wi538C5oWGzHsu2iMg24SjKcslaNWfuVQhYZWlxL/lyY4ELk8cvAAOmsd8uKfj4FceF9fwtTnNOeUIr5yUrA2aznknw0zVIKrqkvt9naGRyTQkpSBolZFbdTx1kpFkIMfTkwmjzN4RtWlW8ns0LCQectvF36Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9CTWQN3noY/IQ6xr5lJV8GmCNTc4yhyPjTK7DvUi9Y=;
 b=RAa1y33D4niRCEUbsyH2NbEoqKkcDO1f8Fo5yDH5xB7ZTVpGp+9k4ILuylORXwWJC4Z+8yI7RpgEHHFL/AgmymAkDCnUB/GT7TUyPzMqlicVWqNcEgngv+VnsLNQMQwHFfFJJWfvo0/tkjLfEJOwBJ6tRpBuhEcIQO85pg1lhMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MW4PR13MB5578.namprd13.prod.outlook.com (2603:10b6:303:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 09:53:21 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 09:53:20 +0000
Date: Tue, 10 Sep 2024 11:53:04 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	stefan@datenfreihafen.org, alex.aring@gmail.com,
	miquel.raynal@bootlin.com, chunkeey@googlemail.com,
	kvalo@kernel.org, briannorris@chromium.org, francesco@dolcini.it,
	set_pte_at@outlook.com, damien.lemoal@opensource.wdc.com,
	mpe@ellerman.id.au, horms@kernel.org, yinjun.zhang@corigine.com,
	fei.qin@corigine.com, johannes.berg@intel.com,
	ryno.swart@corigine.com, krzysztof.kozlowski@linaro.org,
	leitao@debian.org, liuxuenetmail@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
	linux-wpan@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] nfp: Use IRQF_NO_AUTOEN flag in request_irq()
Message-ID: <ZuAXAFNp0Th9ymkb@LouisNoVo>
References: <20240909133034.1296930-1-ruanjinjie@huawei.com>
 <20240909133034.1296930-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909133034.1296930-4-ruanjinjie@huawei.com>
X-ClientProxiedBy: JNAP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::11)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MW4PR13MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 546edb6a-f48c-4ca6-a0bc-08dcd17e6701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?du9A0wM9LcFvAAdfQSj653DpgaGeMnaKbZ+r6pEUxbIccMOlK+UWR7MGVfKa?=
 =?us-ascii?Q?pcPCYluqdra/4rWfI1aSJ5gpp688/QZgILBjsDtTKqISXNDs1e1FNfy0c6j+?=
 =?us-ascii?Q?M8SJve8QMWvPgV60aohAHLltunqwJL4RN9GGoKx/BCZcHd7X0ruymAW5/+AQ?=
 =?us-ascii?Q?a7vhnaY9RqSWAD72cOPHyRtKeku1tKkzuQtonArQfc7mg9fviSBIgxjiDDUN?=
 =?us-ascii?Q?m3C5WeL1+2L2GEZrT3Qca2XxNVuYBcJ0jTkHVsj7OOJbvLi+RD9qLUS2BZgU?=
 =?us-ascii?Q?o7ylfG2GIaHJAGMSk6s7Z3cGuLj8wYrWOTP9J7M827yVbVR6ZBkHUqCisOSX?=
 =?us-ascii?Q?Ha9rkU2cLrZijSgxojD4n/GDorxqpB4GhALCPl4x+XkD+/gaaDQLFZCCobOH?=
 =?us-ascii?Q?bi9EG1yKt1a/JVgfXwx704Kf2vL1kJexqiJbM+ZejHTU4kOGp4Y5ySiuVyEs?=
 =?us-ascii?Q?rCT6Voy8rOMBrG3p6jMHJ1VOSpnMKcXdiqchz6IxM5r8rgW8m9Fo5CRTdtJl?=
 =?us-ascii?Q?Kxy79+h9+aX+HQ1PO1CIbXAMd2hL5UyYgREIiLoRORz2+tbM/YUKgSgSP52F?=
 =?us-ascii?Q?h+WMNluzKrtTuynrb401B6b6FAaRlYlxBVdSrdT7lnYIRtf5FPVvt236M+w6?=
 =?us-ascii?Q?Qxbe52qbJtqr4FNTBfipEldeKFi3xNa2fLkcNkuhtHZHTDyfnFjs8y/RuVrp?=
 =?us-ascii?Q?1+HR/fe0O001jJYP6aDkL3u2DS8qoQFQTpG2e3BHwVgKVJrirVwj3yprSg8R?=
 =?us-ascii?Q?tNuH4+cGdjNZaswOUXKlwNTv8abqlXiIbKnwQyeQtM2rpcPu4pYH6qTvE1FR?=
 =?us-ascii?Q?yZILX+kf1o/0GXDg3ORBMRNUjDkYwP2Q1WUg8+2spwVcrh9/oOt4EU4pBXhy?=
 =?us-ascii?Q?LtbRR5YSKrHVFrLrZMWjeO4Cf7keDX+HpUYmrY7zgPY2zuKvo6DnxyoHjSN/?=
 =?us-ascii?Q?x1Azc1z0dFHpAqoXnJva/nezB/sdqTlYx6uDu7uGEBIRZTwN8K9PXijRa9hr?=
 =?us-ascii?Q?HzvYtLtEPfbo7f1dAowDLneUkqbHLOcSOnZxfeMuL+t/dQiogOn65pZXSStg?=
 =?us-ascii?Q?/FgoNNZ669Ao7E91FlK9dkoCAel3T3l1NzGdUzKFJZTgLe5CQuuRGh7NcTWa?=
 =?us-ascii?Q?4Hb9sC8UcX0lmpNzxkqnvmwZi6PIVMoRL0Uf4erQ8YtgXurbvEx49IQzXrGX?=
 =?us-ascii?Q?n0EFxvcDcSVKD8NW0BiS/N4k7OHsi0hC0sGgQGnAOB9e/dTTNdvCGsnbjYIs?=
 =?us-ascii?Q?JEvVVlymaHRSNOtIJ0fCsyZYWaCcQ6so9QLaixLSbS4y0DH0ITsidXUF5qBp?=
 =?us-ascii?Q?X0noyDUID+gIKWoF1W3D/v1oID0L+wTk4I066tODKwnT9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EgootFrPMU9Bt7ncDY6NDFhOlUDgbb1rrAS6KhDP7ulfYZ6qdn39QVojcLah?=
 =?us-ascii?Q?oMI2cb71e8Uvyr4i0BPZn5Dlqfb/d/SyqDUiF11+rQcPn6CghXlCXXzwF4z3?=
 =?us-ascii?Q?Dy2ML4nwhIj2C/F3vMnpFPP63fj8xeilm6XHivUuMoKEG9vkcTo4j822+O5N?=
 =?us-ascii?Q?VNemYVtf04KjowQgmT3br+GtWF8eeJj0xcvCZF0yrzkqhRhDOfNN3X5abbPG?=
 =?us-ascii?Q?Gm4DS76HEiImacfaiyyvSme3xaSf4TIsGQQZT8ffGvc0+Ovc/Y19ZFBp1IdD?=
 =?us-ascii?Q?7Dlpe+i0sVwFvbgmvdRuviCFuF/jfv3PuXd7l0k7LAltMEaR5b1eoMVc1bwy?=
 =?us-ascii?Q?/WLSe81cCRfyu/9GUQsBMaIpeaiXvzmgsK+yY+Imfc+prHVVHlpT5wev8IBr?=
 =?us-ascii?Q?JcfFLNUKHS5TcMx1nHGN9Cq6CIZFtm6BodoDKU2hkx078ur2RA0JtspTm1Yf?=
 =?us-ascii?Q?PQjClAiPM8bX0AFqjl3zUFJ5Wx6VQc/HJScXgNrSdjnOWGv9t827TB5p9lmC?=
 =?us-ascii?Q?x9UFt+VTt3HUMVlvBcw8LJtghcPh64ZMuCuH472m9cAtHUio/J7tEHR/zTC7?=
 =?us-ascii?Q?HwGl99HEdv2V/3muUnY3hdm6hnRolysWiNQQkk30Ixk/+ws88RggPVaL/om1?=
 =?us-ascii?Q?66W+H856LNBa4YLjcVNyZWEUCJbavs8syGhPwNeVs44ZiQlut6VQnGuPihTv?=
 =?us-ascii?Q?+HDDvCfPoE7OxQzOfnrJZK4/TQphGmeY7HKW1VqB0whvzWu0UzpFkpE17R9H?=
 =?us-ascii?Q?y0/AS4McMw5DbOSACZexKzjhORsTLmJdDYMuT3/HNOyyJZmbJF+6GIlvqiyv?=
 =?us-ascii?Q?oeNwcoD3yOhYnMTCcjI27KtAffg9CMoqMGWdglJFlM7tC9AiL96gWWMXdjsZ?=
 =?us-ascii?Q?Bvn0VcJ69tfH4Jz9Zr9pzJfODrByKqI8V2/H84k3Cz8xD867UzncMxY2pPoT?=
 =?us-ascii?Q?k4akQXTC+Qxi7V83qtYu6Cq1gTItsKNsiOTOGqg2aopmj9/dBy1q7Mm9AwtH?=
 =?us-ascii?Q?4rAzVm62AYOdvycba6TvdP9snBDO+NbXX4JQ0jlRwHwFd1TX6YgnIi8dvX2w?=
 =?us-ascii?Q?AyQKYCWUCJ98PPn2VQzTUitRESpSQt2rib9nnha1xT5tbCfa+KOMFbnGcTPN?=
 =?us-ascii?Q?je8OLHsLWVgPBgIoYApUs9ANXso9eIaABYqmzei+8mNJHyB3qK4M/FX9sVq9?=
 =?us-ascii?Q?LeAj3BcS2NBlG5JrNjOExSoU0N0kmKWyQu49F4CanXa9Cxmuu9YRjTJZtJrV?=
 =?us-ascii?Q?d0O36MGgMUA3RdI1K9bjWY2NbTlt4lm4MHDVj/y0ppH16ZCVCxTX0E4FqiVq?=
 =?us-ascii?Q?uSCAysLc7wvHMFH7VFuy4bASLFfqFFF5GjC1OSaBChqlQfdEG5ODDKVMRiKz?=
 =?us-ascii?Q?AU4Zta2P0cNQHVrwodbmqtjCDRGxGDSSjJypIM6ZJacEgd8eok4BK7g/+OAH?=
 =?us-ascii?Q?p6/phJky6AoHWU0FcG6KajeOwIU+Ox3zf1kGim+801jD1RsRCcPwofopLxUh?=
 =?us-ascii?Q?zJiuF9En3C7Ln/l/Sn5CJ5BCbySy8os5Byb5Hnhb4+P9YGla1TaMbRmt/ZEv?=
 =?us-ascii?Q?2l71GVommrO1WLF8c2BHab0s/dNCBwF24QAR9Ya53fpK6SEGyGkdZln3p9m9?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546edb6a-f48c-4ca6-a0bc-08dcd17e6701
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:53:20.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RmqeliFVXcxs2h7nkYoX9ysr7ipRjzKjjRTwf1+mMOlLWKR1I+8PuBlBToP7SgoYqXWPB63riydKWrd75qz4DyWD5S9WYn4S4Aq4CYqgeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5578

On Mon, Sep 09, 2024 at 09:30:30PM +0800, Jinjie Ruan wrote:
> [Some people who received this message don't often get email from ruanjinjie@huawei.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
Hi, thanks for propagating this. For the nfp driver:

Signed-off-by: Louis Peens <louis.peens@corigine.com>

