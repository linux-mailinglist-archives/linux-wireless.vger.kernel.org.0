Return-Path: <linux-wireless+bounces-12888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743C0979EE5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E41281C7E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F013CA9C;
	Mon, 16 Sep 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="Kg26IAC6";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="GLUgEEhm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0617C8D
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481087; cv=fail; b=d65xG8+cWIKS0MIVLBy+iZ6nWgwXacgQwA/RGFdPwitOt3fib6DxyoHNlbeLUW8m4VcsH6epOAFHcaxV+vLLnC+HOwAoifgFCOt7A3/0LyyFT9THpcKM2pSSIraOO9kUJUvPKiIZOAbyFXFzd4feHcAOsGSeOKiCdxJWpK2qb7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481087; c=relaxed/simple;
	bh=1NgUetmWGupJbH8UKr32AP3I1Jo17X5thIDTajuDJEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ViXHjDdRj+JQyAJplBtpR9jv4V+Mz1nKmSAc3McQrNYBixyO3yRWwQiTr0Ju+KiS5h7VkBECbUyd1PIFMxHJMNKpS5TZqgOnZqrq37/aO5ii++sqazAbmAWoioXtwuCT+EjIUTbeLyc4qt0fz0+CpGsP/Y5qz4Q3Vmf/g95j5rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Kg26IAC6; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=GLUgEEhm; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G9W3Pa012729;
	Mon, 16 Sep 2024 11:44:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=1NgUetmWGupJbH8UKr32AP3I1Jo17X5thIDTajuDJEQ=; b=Kg
	26IAC6YaItZi8VORBPIIRyQbUFGrsNQeOfdZD/8k4LsZ85KlzhQ/qumm6hP+8jfy
	B1cNiZAXrM86/squTxaajkXaG7omgsF4Ubxfv1fAD9RM6Nu0QxLo7NBHfcpq6D8D
	hQxzWiH7p1gFY/7bOssosUiJn4SMJnMV6v+JNQprHsfywn4qazObiCMaOS/NNSf0
	4vjYhPVVMKoQ0DmMkx9mLhcJp3VtzIReRw5g/lZs2uXU526h1bclh/PJMTkAVADL
	Nwn6+2Y/fCIVchiHWYxZoaG1R+R+2Z7+Z1vHH3yZc1ZVf9Kvyeo3MMxqKBFlsG+u
	wGNsq+pi9l0i2VbhOmfg==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 41mxuda48g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 11:44:26 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLQLX8rEHskXTNeaYJHnrKEG45JV8mAP9ijHtzrs0EusLlDC/C2sq12VEbiCY7ZiqQ2pmCtk/Aug10JdCe/E8WA4zPYM4qQfEC26gSZJ/0a+YBsPJ0XVc7oRFh/30KwarfbQa19gRFT26cZCpu97onMH0edOCJxbxaSle+KkE9Da29xm+xnfYp6uAS21ho73Xu3YibCl9NpyjmxCXGy3JY6pj19eu3WgaZ0Tn3d7ictf03MKFn9PQjVV8qObllKyorNp77yME7q4ahrFZkqsSu4CQJyuL+D7L9ysnKM8vEl5bSGMNx+zTboYebLJ7FnOKZjBOqGXH0zd9saoWZjP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NgUetmWGupJbH8UKr32AP3I1Jo17X5thIDTajuDJEQ=;
 b=dUbzrJnfenqtDYmzkm3O1JzOxOXdgpwbE1kJkN9w0oOAhDx9pmSsZuTK9u2TFdkV/ocegERtFCm47MZhwfs0qLOMoQ5oXMyQK4krHDGJpz14TWefBro/pdFHuF8r8yDEyLO48IV2q4XkyAfjwTt0l7qjeOAKtbm38E2sl2oEpx05weVwrNOZ4qnvyAmf37kcQ6Ll8ANM0CvFGKuPcKQYsrqBAs1f1/B119xsieFefIoBkZ4oFz05MAY4OYHaG97oiFQU1VrLkr2tywbcS/hzoQqexVA6VUbci5HQUGJp6vYmVgtIKvjZbC4lXGOvM5o1LTNro6bqWJiGeh5Sh7NVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NgUetmWGupJbH8UKr32AP3I1Jo17X5thIDTajuDJEQ=;
 b=GLUgEEhm2xEhnNyuTDgTWMSyOzw9h1AbESvyDv/DvyG2pkOBShFTIq5+bW1Iu1eiU//uir4cf67cwt6q3EcZSY2Wja91QzWm5MBZZk2k2vdcdqFBCv+neVAAkf9Uss6iOwDF5KQHW0ADpce/m8CaM4nF2IAdG9pIyp4E9+x3OS0=
Received: from AS8P192MB1238.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3cf::23)
 by AS4P192MB1839.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:51b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 09:44:23 +0000
Received: from AS8P192MB1238.EURP192.PROD.OUTLOOK.COM
 ([fe80::63f4:d454:dfd2:7971]) by AS8P192MB1238.EURP192.PROD.OUTLOOK.COM
 ([fe80::63f4:d454:dfd2:7971%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:44:23 +0000
Date: Mon, 16 Sep 2024 11:44:20 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: Missing event
Message-ID: <Zuf99G9733Ng41HE@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: GV2PEPF000045A4.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::40f) To AS8P192MB1238.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:3cf::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB1238:EE_|AS4P192MB1839:EE_
X-MS-Office365-Filtering-Correlation-Id: c34826b3-bed4-442e-0025-08dcd634252d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yiahiWMFkWZNK0z7IlH8Q4ZeuDLeWXJ307TqX4jJJWgdhIq6AN4DtKOpLaIL?=
 =?us-ascii?Q?+I1krNRGCXpqI7xr7v/j3eUQty8eSrezj3H6aLU7A8IbFtsANXBi3O9dobWo?=
 =?us-ascii?Q?kH/ZZGuPOAt7fdVvZQBe0WhtR2EbfXoOfiYaJGC2S+JaoK+hHtu/xxZqCsTW?=
 =?us-ascii?Q?dRsB2d8XOe//08dtYKtsyuUS1qGIHvEy9saPH05z4lKay9b+VVXKplxXUJIj?=
 =?us-ascii?Q?EnQ2APxUGViuDoF8PU36tg0FJGohx8VhbHXCxTIqI6om4Ez+mt3FvtVHWOYK?=
 =?us-ascii?Q?jxlrZAAQ7Wam8/789w1zLEPDXzegJGvFCiPGV4ZtUQYoL1eZAXqCrCEasiPL?=
 =?us-ascii?Q?LPkeXMGMhmPxUukCft7uaDeFYpmXTrACm/SmGcmdCT07Lk4FQiqjiAkYLhcK?=
 =?us-ascii?Q?5aKtxW2Z2V50HMiJFW6oM0FLozIp4SeL7bb9nMfHpEgkAs9sgdExjFxAKSLf?=
 =?us-ascii?Q?rMsFEYYoa9xLubcoSHNyoCGfwX6Ll93CuFDlALMp+1M0Yi28Y6fXvNqg/GDv?=
 =?us-ascii?Q?8NvMn/5FUU90QnkpLUzw1HVNhreu0Kj/n5KGHZJ7XFZUZRMKnCQDPAeHBhU/?=
 =?us-ascii?Q?994mcelZ8WnknX9AnmFQd4zlYe1ZbBBQ/kX76lM92ZjFNb63Og2c+VkDZDM8?=
 =?us-ascii?Q?AtkNTAsOnDG96ZpNElzi7KjFUR+janOCETAH/6MHG1fYW0qPKBHGWPtkLLCO?=
 =?us-ascii?Q?R+aUp2WL8BhKutLq7O+ypbjv3q+rGOKARLEa/2q7gFzaDF3TdBrjG/Q8YkNR?=
 =?us-ascii?Q?8x0rlY/qL3P5e2rPTslbu/pWFhZuxXhrTXHLIfoRMSOfmay9qfbz3kZ8Is5G?=
 =?us-ascii?Q?LWNprC/PGexqM5Gw5GDuIPLDtPZ89xnzPdgDDqPk0UqS057eAMmYF9kT84WB?=
 =?us-ascii?Q?qGFAsWGxtkEMospja0SXdaBhPYAK5e6QFHljJBN7EVzSPLyzSliT3IViqN81?=
 =?us-ascii?Q?0X7w8OOtUV7SGlfketaEXy/vRblkZMHnccPd96U7hmgos8BkUpa2tJXeocDl?=
 =?us-ascii?Q?JXOGSWTD5BxZClFPPeTOP62LqLMFdCHXmuuDsBfwyAfMBr80fM1r0OBIglvL?=
 =?us-ascii?Q?kruiOokkGZNyuB3l3XlbK1xjDSdBGJfHd+2M34HM8Dv9z0FyBpnsWlyJ55kZ?=
 =?us-ascii?Q?9EauUIQ00hFRTc8ZKB2TgwwidhjnAVt8pQWH7pK/ZA7K4Hs3vuFPXsTAk7P8?=
 =?us-ascii?Q?hTVG24V/TS8UTij9uCNVKClLfEeBzQnZj49yKWdqtkY/SoTFzy7VDZPfQGWH?=
 =?us-ascii?Q?peEHd8GtOOfYpFrgnOi4278rwsu8FWajR+fHUcxENQBAcD3jkhACd+cCwUYX?=
 =?us-ascii?Q?SdCf6hYCl8AlUHSHid4VShlqiz1CNHsRMmf+yNihoA8Jyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB1238.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JeN3TF9JVdwu6EeFSjGluj+DsQQEL2PH5eAWctRoCJOqrSOEBJtdXprkd8Sk?=
 =?us-ascii?Q?r+8OtdsyeIQbP8HkIJP2HpqmrhJxdit6GNRySrQ64QqAo+X8N/PM5qam+YQd?=
 =?us-ascii?Q?K3thZN3ETAwNCRYGHEa6ZXPmO9ATvdTgA69ZL5+2XUOmQfJp4wlGFg829p74?=
 =?us-ascii?Q?OUheRMHF2X/BLCxRTVtyLa4eY6W6TyjPqnh73eYCj25eA3ffz+1V7SCUM0kD?=
 =?us-ascii?Q?nhO1MngbwxwiicwNVzYDPJwyUxmgm5dYN7V3nIEAEB7uTr6z0XGnj26S1hXi?=
 =?us-ascii?Q?yISDFFqr/dSvuIEPJif/73atACzcfjXLEkj7xRcGYQdxltkgGlXiXmeT+JG9?=
 =?us-ascii?Q?CzHM7wAMAMfoj5nkKdDGlwR6sq0b2X5dgDyi/cln1pjl//2VWgTSMM9qx67D?=
 =?us-ascii?Q?AjBV2qpxVJXZnMW1YXSmudRGrouhewD2WXQDZLXgcLRwCFBIIcOXZdNbxG5N?=
 =?us-ascii?Q?x1yw1oRa+tjN3DlMEnxxSvfWVX/HCAIupup5vjF1PQHZ7TabG6gGAphHj6Sq?=
 =?us-ascii?Q?mymgqOve01p6/Vy0RkwOfz9MnxlXylAuEHuG1CSqYcAGVmqSRUgjlnnYcktn?=
 =?us-ascii?Q?d81J06aGDyR7v0x0jwX5ylhxEyEZi+7HHSBZNQj85S+WC9XZsGeMWYiT7Oly?=
 =?us-ascii?Q?vZIHxBZbbqBXCQlEGSxGJV1hrYx1jMf3XpxAu3PUizr3SMDdk3Wx+Me3GnKQ?=
 =?us-ascii?Q?4JyEctnKk/AUByrq0sQlXBYU7TWF/Jz7K8qa0Q38j0ANgIzwo5xbSFexSkIB?=
 =?us-ascii?Q?f3gTnIlr4iNDMg7sfZUhr9YAq3YEO4hq762G3WZcUiLph20NoJqVhmj9RhbU?=
 =?us-ascii?Q?Anlv0WWNcLa/vhDN441OZI3LNEaKJH8hJz/88sOMjfVs02SH07BXnpACwLkc?=
 =?us-ascii?Q?PVocvIWRQE4Cy4qAIGRCKmmmyh1Ee8aTUdFwM9kGsCVU4rA2eU5goQMyg9Ou?=
 =?us-ascii?Q?hj34UewEpiDnDjT7ROJwSOUiEWX0FEMs8//NByvQwnflAlZd5HpJxbCx5rNw?=
 =?us-ascii?Q?RX5TFZZAIJ9OgXkt2/Uu6HNNemeeT0mC79tvwwDIUDsEjW+Xt4e/QPLx0caT?=
 =?us-ascii?Q?H1K9kkp9q6A212CVijc0pDnVMFdpii2KNWNBvZJaByKbelumaON3tvcFvDfR?=
 =?us-ascii?Q?RA7L7tTNc2A65PdPfGlacZld9wGikaHYUun1PdYiZjjpqGswoF9Vnecbw6KW?=
 =?us-ascii?Q?gdtgM6790mcYf9edaGZGu3W8w6I17YKs6Z89aknRy6LFrokjLXi2C8kkZnkt?=
 =?us-ascii?Q?vVJcnOn8zB8X0Fapii4kM2GGOscOXVf10BHhnHVrasn2c2nj4GgIxt8EGsmo?=
 =?us-ascii?Q?JwiKjYLCkeoNt/gVtROzjBtnxFFvcJw5ei4Y8Abk8JeFsoisxivrcxaXd7a7?=
 =?us-ascii?Q?rlEEiewHnxv59j7XEP+7dtqVJX957435PZiXntAz7e6u0Hy1F+FmVvZZPMny?=
 =?us-ascii?Q?LTX2Yl1vX86OHNYQyXRZOGH3oD2FQd2xyPyeg3163HnoE/n8i0Rce/jpTQ1h?=
 =?us-ascii?Q?O9gkrExSK1Sy0UNKY4c07Hx2m4tDoFxDk7FamwIUbCk5/Cxm7OKNgbPUCpIp?=
 =?us-ascii?Q?2oQK9zsvLqJiOUMLxv0e/bHHHL1MHAvQZGMQ7Lbj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OJG95NXxiTQLHWNd3Mh1iRE7dqshrJePwUT+B3iAKQ2qgQxYt0AYS5o7Y+oLveTh76ivWPZrost1IKsb1lXWFf9tD1odjyVq8FJnx/cAADT1ezw+/iPAAjVQv3lYJfwSjvNMQMS4tgd5wB1JwsIeus5LZkmdm3hyRKaMcDuhAhA3tOzKXCmcO2YfjFIss0EqvqP2olg0j1otBjjpDmR9NeG0AySdnl7EAZMDFRsb3rxBRWMGgcaNaihSA7hwnaPLsHIExEJ2gBdCvV8YwdP/8URBT6A8KCAgZE3mTLNsGGdVApgd+ojm5byBHnD/NSTjF3T/gYyvvcger0OyaAXfQzdSN0bJxR7edhUUzuxQUmz8RuqJaSLXdpOAfMO1HhQyRQzqitpAn7kbPjpaM4SAP1cOVopmC8ZavNUILdaTT5JCTYqbC7a8mQuBMI2dCceALEyUuM1u0abgnRBetBHHUtFSzlEcJl+ajMfHoox/ENFsKghZPYQXg988jU0vXIuRPLBHcNjFH6InxmKsSyEkUUiQot03+JdfaeuGOBhKrFVYONCFUryA+irqsEeiNk2n0tZScpHdzlNyqCwEEqDfPdy//CzlD4yPi8WLZ1j8x5xUDFH3nkcFg08j2clCk05J
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34826b3-bed4-442e-0025-08dcd634252d
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB1238.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:44:23.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdH4kBZpMzDT3sqoSkFaCgz6Gl0RiGCdXwmxblpEdXXgZsWp9lQiCADrBhDAIYJQoa6XVJ1le0Wt94k4/K0rlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1839
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB1238.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AS4P192MB1839.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: iyqcthwLrGDgRdrZ8RZPNWniPewtYolA
X-Authority-Analysis: v=2.4 cv=a/Bi9lSF c=1 sm=1 tr=0 ts=66e7fdfa cx=c_pps a=ow5/roAxt+uy2znxgqYcZQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=EaEq8P2WXUwA:10 a=0HJ-WiGSmKEA:10 a=8gLI3H-aZtYA:10 a=Jx3i5r_97kg0vaAqGMsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: iyqcthwLrGDgRdrZ8RZPNWniPewtYolA

Dear 'iw' developers,

I have the following problem: I wish to monitor CAC events via 'iw event'
command. It works fine with radar detection and CAC completion, but I have never
received the 'CAC started' event. Since I'm using the 'iw-tiny' version from
OpenWRT I create a small patch to use the full 'iw' version, but it didn't help.
The OpenWRT also uses the 'libnl-tiny' and I wonder if there could be a problem.
On the other hand the 'hostapd' reports CAC starting events seen in logread.
Where do I need to looking for my problem? Why can it be possible to lose the
events somewhere?


Best regards
Alexander Wilhelm

