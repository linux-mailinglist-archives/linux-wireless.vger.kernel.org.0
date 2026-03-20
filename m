Return-Path: <linux-wireless+bounces-33586-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CSaACEZvWnG6QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33586-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 10:53:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC72D84FA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F326830054F2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069D0389447;
	Fri, 20 Mar 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="JmR5pJbL";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="dnEVHYRb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722E2E4274;
	Fri, 20 Mar 2026 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000412; cv=fail; b=hs9uDuJvk3J9B+jbxNMCqQIOtoyFt37wxeH/8lI3KmfIdDE1g2iRVgS22My8qklre4XX2eywrrk6SnZunbIZy8WGhpIiKX1qOFKAWs9g42aVIESNnhXy2mzj8i/GQg99I4y7gBdmM/hoR3odfDn/IK6AJpwdOhBNhPYCJMG3+iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000412; c=relaxed/simple;
	bh=mCGHvkZZRokycEdkZuPWvwO31rGW8kN/nPD9XJUCj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HLlrhXwf4KPtur6eg+Lz1hdHSsyqCA16NW1VM8gpAJ4OFx7bANJnZfRhIrdCU0EspplL0Ra7Y3snKeMSZLMdyKAtg0o2tnUH4+he0W4fO5XcKN16fDCxITdKE4watMFg9XQvmPiNpXb4Bc7OmZSASOTezyLnzd2SMX98GHCHqxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=JmR5pJbL; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=dnEVHYRb; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K7wZUf2117773;
	Fri, 20 Mar 2026 10:53:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=JB1NFA8FsqGk+eW5Qxy50UHfereLAUxXdpucQmebh5A=; b=Jm
	R5pJbL1MsbZ+oOLLLO2fvyhgrYhRTWHWCxb+yCYiOM2kGzcaKn1p9vrdH1/xjihR
	oY34HRJYdIr0VZaFDL2C8cB9yTDAFspGCH/LLaBskVfCDf6H4/aVWPChlYP4WysF
	IQmJZMK5CD9YuHnEwWi7lvakb5spRVJFl96gVyRazHsBm1dhvAqCKe+A912LEjFk
	vKEh37EOxK3EDMY1E4jbgm4eKLOvw0a+cKOkmmDq9rSoOrUUISg73ldSsWzf177G
	E34gVEw+zrJJX5LxBuWl/Ct82i2SpTQMdIClORY6jzMrFOoBTTJhzAWAOSFPlG1r
	S4gXaaof0pkoGEuWmjUQ==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11023074.outbound.protection.outlook.com [40.107.162.74])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cy6wnb6da-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 10:53:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTP+MTIBHfjPGEKVfDhaiKBOLgNA/rwGdcPuRsAGsIp3OgDteC6lRgJsA3eOCBsbTPBri7AkBcSTkioFSKXK12sozmDxMrbCR7e9oOj4OF6xnnI7+A1YNp4YMU0jBWT4c/EiTjq1AXFPVMNqtv4ow+tJSpTdF4JTXZjc9+WOyvrW2ZHhQfQu78b5GU4WkdHML20esQ50O5StE+yMvjiQfvn6v/Cbj+0t0AAwd5Al6yjdeGwx1RCr/pbQQHiEW/1OSZ52fMW8O4wl6BxOV4npg8q8CuB3eGKqKmcIvKk7Y3Fk7fkLF8r+auCmbgNirB9cedvVWVQutrp7kiU4n970+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB1NFA8FsqGk+eW5Qxy50UHfereLAUxXdpucQmebh5A=;
 b=Mr6OtQw5UB2cScKH1iDNqY6BzTRGnnoZJFsGaEVx+aaxv7x3XTP9Odw1gssGbCH/zJwFYwYfZnBO12eVumUh+lUvbWzioXVTfcb9VGVimEATlsKkIs5SzMhqzJwATbBQjd54DlK3m4HnZM2TwhKqBtFhnTb3F7RIru8o+8+zD0mi/GRiZ0pDZ4vqJr4H7BBNiRzak4s6/YN0veTySwwbLxwxXVFTUe6UYHYuBFWaJRbb8KEfytIpfMTONbABeGp+p/y/IKZ+uZArM3QFNdw70QUnV3IGOeznIWz0hV01R0yC+GoNa7K4I4BDmZilivje48+t8W/E79EX8qcAQSe9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB1NFA8FsqGk+eW5Qxy50UHfereLAUxXdpucQmebh5A=;
 b=dnEVHYRb199ZSzahvY8XLfFNJKBd9ekbwnM4k4i/OJfn38iGinAEudca8oEuWYtEujzmUZPP8OVxjtYDD8505WeHfgerYoe+IwEKZau5pKAp36JlKO3chOtpHFqSZi2oEfXRjPgPGox5yaFoHMT7lxo2RVNPW2GyQw8MsLtjZHY=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by GV1P192MB2026.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 09:53:00 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 09:53:00 +0000
Date: Fri, 20 Mar 2026 10:52:54 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: ath12k: desc_va endianness problem
Message-ID: <ab0Y9v6BkH4HDrFr@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::18) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|GV1P192MB2026:EE_
X-MS-Office365-Filtering-Correlation-Id: 909125ec-cb50-430e-3e3a-08de86667893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KMr9skWPtu4p0dD/uVvLcjVOkyHRDlDWWiure0KvVbT1OoESnT8U23utjvOSYptoLG4ljlDOGSBOvJbrU+B3m29juzWsGDFRBvJCSgBpKKSSIYK+a2BQhm3dM5fk02cWLgBdSQ26RZh8sLbRcBiXezik2ITGEUvR6x2Z4SahWwKHjakGUSYNFuSEKmPcbXMGhQc3nFkVeF/iVvPkHEyk1TijCu0VdpCh5i4VCmc1CcMOVxvRYbKev/N2ast0/t1Bj6HCkR4/RDTWZXTS/2R5bPo+nCu3Ix3O4l5DHVlV1qRYxL+3bqPCcg8CWWHKe09Bax419m9LNYmyRKRcHdGm5zMQPu+3oUwQtKD0uohQ9bkMGpNFRQ1glmBu5ILLLi3wqGnjqTqikpx+Nqch02BrIBo2DpRCon04habnCw1E+acwpuWyiXNBMb21LJFwLqD7MWMaFgUTpOtj7KTgAXFX+XiwcnecXiXAJ8vNll5pjOXnv6lGT1p+E5TzXN7tK9ZdncGjw3VcHAQ/PLiCwMo8KMfeCThrj2m+PG7nOsbjVV+t2PXX0UEew6JJmv3gH9+y9ZXXOxW3rKDOUfm28vqCMlphIw9OYmkRHXAMpk+Vmjl7IrCi6YWyjLaB9iumwqI8sDV1Qw4+QGK6nQjr2vup34V4a4OrAQNfKCTrvQ5TayczCs5nwLm/g0iq3JEFQ/4hqnRmCqLVyQLOeDIaF6nngfIOoeROH1EPDAOHRiuQ6L0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIo3lezm6kqX7h0+YrUO5Zb+f78/3PWC4ndaTuO++kzi9VREKrz9Zi2wi4MV?=
 =?us-ascii?Q?J5RtjnMUETPhynvYBbmvP5/M9YH/GoAIv2mXd6RjFMVhAXCT98Ily4TGEqJh?=
 =?us-ascii?Q?UN33AXMyRLDFKAQ4GpY6Vt0uGkuRte6M0Vfd6IkjFQNxUmtzgtt4hKMwsENL?=
 =?us-ascii?Q?z/OKqNeAmcqOsy5YJq4ibdZn5qlW+ZEIXqpNyrFmXD46S7vx67QaayV7t3Lu?=
 =?us-ascii?Q?VxTuo54FuKLf9aakHaIIyg5lqGGvKvudBaXFPXweAbun4gnXWOkeZU8az4bF?=
 =?us-ascii?Q?NE291XRjexfGbtN3XJnIZ19q/zSy5mf0MiXcnYsZT3xGyrCF6U/MNdH0oUht?=
 =?us-ascii?Q?XTFDAJH17Af5QlFxYwd7gS5OW46aNmu5Vg0JYDl7et5PioTnw2Ek02ycOXKf?=
 =?us-ascii?Q?I4gwxlkLcc05mh6h+JYvOsyfpOpgO+1cqyZoaxM8vBZPQvEoFxTvVb0OcR17?=
 =?us-ascii?Q?ovxWY9fK/5shU9qzCGYCLZZC6UXcfOvbS5FQOd7mIbU1dCl8dqH0c0hw44vb?=
 =?us-ascii?Q?MeOABKFwXJ9LNbH243unUZkAUAg4vaiTWURPLgB7TS2XZfYFBBzaVoVT9Rai?=
 =?us-ascii?Q?KHwLGxnYwlUDDT2eIZrykuYhaSpZp77Ske4KmCokqtH0ymvRVUmqTJOMBZhJ?=
 =?us-ascii?Q?X0tnYbxE01r2RhNXLpP/AU+ykpc1d0YRgWUaHJP+M+3nb9nyV6RYaI+YLfsY?=
 =?us-ascii?Q?vssN/ppK+ktWtim2hQFT3Pn+JP1A2Q5t6wbwvjiEgc31JHQUKqlka1CnSF8Y?=
 =?us-ascii?Q?u2jtIW/lvd2jnmc5IZs87bwOWjj9TYmIzxezbmaBBxOf+XMBGoQxgHo+/POE?=
 =?us-ascii?Q?6D7iQKEu9a3LIb3fSdHjMDWFmiesx9OBTcC0t3Bnv9isfDTy1qWti0LCvXJ4?=
 =?us-ascii?Q?Pn1WwMC98HNurOxROOsaxSaTOT/Azto9rNXEmZ4rJBrcwMGqE256K5qWF488?=
 =?us-ascii?Q?3OGd2pkbHMnwj0NeUhnkIheUja+W5pSOur0DKfGAucYnGYeG3aahjhunN9re?=
 =?us-ascii?Q?1WI+6dO+K+KXKdmqczBfyPglEbLZhzsq/RzG+bJTxkOk6OegqBJL3Y/EI6H1?=
 =?us-ascii?Q?xVXqZKXradiMgZy7wE6/cC17P4ql+YkAzhegFfsAqyz79T/UeRMpAef9Uy17?=
 =?us-ascii?Q?TGCgSh+YFHafI7kUpT+FwWxP0cy7COTnR7be1JkNpfdGqugxrbYcfAMh9OhD?=
 =?us-ascii?Q?19XDLEog9zjXVFgW5LsVK6RCgKvWutk2NoeH4a4EBer0DVSgZLNf8MjDQ6p4?=
 =?us-ascii?Q?1NgMsEh5U5qUTkuRB1XV1voSzvkMngNeDdql4GxXkL2ZSgqBPum68k/TprqP?=
 =?us-ascii?Q?hFa6ewHA0SRdATnvKHquG84IRnc/lOZzQjFy4VPgVcz+0jMPU623+XFQBqjd?=
 =?us-ascii?Q?G/CwK0lQyiUwq0R0V2cYmr34ZyMsLlL92DhRW203atVl4JStgHDmZEszqddl?=
 =?us-ascii?Q?ZO9KdXpVbU6dWM/sYcv1pN1qw2HfLRKIpJ+eWCLya7jv/BukoMw+Z43PFRkb?=
 =?us-ascii?Q?ejESZwB1kiLJuj1KaDbAbAdzPt1ElnRu9EwzdERgDOln53coT1uwEas4AYhR?=
 =?us-ascii?Q?CX3qLA0gkJQWZTeIu0hrVuwcP3hkcreAFqq0Zr5xOiS2ddPbE4TaKaDAQRL2?=
 =?us-ascii?Q?zfRzhYN45vtfRg0e3aHgIlpCEFO45Q/alJw0pyliGVmwHww29Zkq+6Qy4n5T?=
 =?us-ascii?Q?eVvXk8kPydy2d8n4/WnYbkbZWBsvTtZKAa+ZVR24yJS6tJe4I0HO/PwRn59U?=
 =?us-ascii?Q?Z1ooXV3VWA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	ITr7oN1xYEHHXHmzvln+xGEwAt2RSeIh03v7BaLOgPxhaYNjBlZb61wVMySb0R8JMJIK37mGnP1vPrxtqCgKV6F+5ya6NRMDu2biXhl8hVPjC3ant4vyoozUAxSy3v/QtfbfatwHHWBCyfs/TgughU37M7JSTf+CVZe9pY0HfSsKCJgC5kgwleok1YBPXeYSmGGhjmgi7/Dqpy9xa5/FZphc1lINh+YAU6v+k1K9KKhFIG0DzTIQXK0A30Rx4kRMPJufW34CJFVg5pprgWOzp+NdiA+XRJSepKU04gyoax7+QbmtNkumcUx+W/6P1ix3EffxgNHUQafSwDWDJ9K1MA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iuLJzZHfPVRQvmCBgVi9bh6abVaa41yUuzb4uFG+zqcxTP73KdhpTPMdN/lMKvwbKQstU1RQeHP7nHkJZ19TwJsyfitoPN4iuJJKfX4f6uBGMZZ9rceVRFmuCVqCYaifpIqZ9z4/L5CCtcV5wxpJ+yMwwafyp1Fjg1HkXtC0IL7D/zsqkdLnQAR4p6Wl302AOX3dY2IylthQg0tz6rmB4aVYgBI6IIkFqBG5HjG92zGSuIpru0uKAwEC5EZYAqUjvA79bZXDHxc/MkOukXoWVNMHWfQXf/jrAQWYM3CU2RWAtvf3MFkHqY6CkhxnW05lMpgWy+SsCU8uNpaAB3TalwfzXJBslnu+hhpVFNOkW/gErXRLy7KMEvKos+qoDc0MVCRrrqEBPsvwaCcKQFUSrig23MU4N3MU+6v5HA4xpl2/M57TUtmItT6Ms3veKiOisiosJJnygWddfChnS3BBphC30cvxLA2y4fSES6AGy96FEwemipTIjKyhSKaK5VyIpbo3XAX8sD+bi+cfVXvQZPWimV6NvLM8EPzCeOMUfZmyVqTOOfr5o63hgV0b/iBEEoORxKczp0WfHZzF3Z8gd/0uydAReI2QpZkPXcjHc3r7rLMcdl6z55r/ZCBaIhLb
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909125ec-cb50-430e-3e3a-08de86667893
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:53:00.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQrXLy6tVJ4QJOs9mPWRjxxtaAdLYFO6cFjGDC8Lf6fBP3KfbnUZUcp1fUWzZWwVxL6D5jwnHmH4p8RenO+tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB2026
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GV1P192MB2026.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA3NiBTYWx0ZWRfX6/H9S83RFr8Z
 zOwBmYUSIkjCUlVRdeaI2WbRuQ5DE4G3hvB1GYVKKYF2iXs2TImbfXSpm23PJxPMDi0/acjUEwS
 YT3v7PSyl29mK38RTN9N3S6Hgtvmv+98eciaJyJ6dhoXnNRgHde6J5VzPGjS7c6HlCOgXrinD6h
 dNwBPp8FC9GoUS1EzTvmXN47illjxu25pMA7pHZs2jPK19y1oTEKiWdXQzX1crJbtnQIxLqORWt
 vsG7cTBBP1CUrMuYTxNtytmJMnzt3St2FADshyWV4/eYL/9ht/ngt0dCiwpae53BzASBjOGF1rj
 /RDvIV7/CTsfwaMAezpspKmSoDau9A9zeZsepTlMMFjSjhSw/h0eQYgcPIEPOYfOyMu3bSIk7+G
 x4Q0HuDFnguAOXtIQpyBnydnn+3ZbDfpnFCcZKkdJT2ot/ZDRsv9IZYlBdiSsWojQwFBHkoq2PX
 fScEsCNOPSBWPV61pcg==
X-Proofpoint-GUID: KGTLsspWP3R6293-s2hYBGwytoKy_MHa
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69bd18ff cx=c_pps
 a=f2ZEKNsoaTwn5Aod7QoaIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=m8CDmqB9fAMb-39ETFoA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: KGTLsspWP3R6293-s2hYBGwytoKy_MHa
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33586-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[beijerelectronicsab.onmicrosoft.com:dkim,root:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95DC72D84FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello ath12k developers,

I have another fix for the big endian platform, but unfortunately the data types
do not match here, so I need your support. The problem is the following: the
structs `hal_reo_dest_ring`, `hal_wbm_completion_ring`, and
`hal_wbm_release_ring_cc_rx` all define the members `buf_va_lo` and `buf_va_hi`
as `__le32`. At first glance this seems correct, because the entire structure
contains only little endian fields. The local variable `desc_va` in each
function (see patch below) is of type `u64`, so it makes sense that I would need
to convert from little endian to CPU endian. Unfortunately, this leads to the
following crashes, in `tx_completion` and `rx_process_wbm`, respectivally:


    Kernel attempted to read user page (40dcdf) - exploit attempt? (uid: 0)
    BUG: Unable to handle kernel data access on read at 0x0040dcdf
    Faulting instruction address: 0xe209290c
    Oops: Kernel access of bad area, sig: 11 [#1]
    BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
    Modules linked in: ath12k(O) mac80211(O) cfg80211(O) compat(O) ...
    CPU: 1 PID: 10200 Comm: jshn Tainted: G           O       6.6.73 #0
    Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
    NIP:  e209290c LR: e2092854 CTR: c08d3190
    REGS: dffe3d40 TRAP: 0300   Tainted: G           O        (6.6.73)
    MSR:  00029002 <CE,EE,ME>  CR: 44004804  XER: 00000000
    DEAR: 0040dcdf ESR: 00000000 
    GPR00: e2092854 dffe3e30 c328a500 e2092854 0040dcce 00000008 00070000 cf900000 
    GPR08: 00000000 cf900004 40000000 c8e52c4c c08d3190 1002801c 0fcf5000 c0ab85f8 
    GPR16: d0d1f7a0 c12a9080 00000001 df7b7f80 00000003 cf900000 e1bc0000 e1ccb988 
    GPR24: ffffffff c8ed0000 e1cc0220 00000000 c8ec0000 c8ec0000 c8ec0f50 c8ec0000 
    NIP [e209290c] ath12k_dp_tx_completion_handler+0x22c/0x720 [ath12k]
    LR [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k]
    Call Trace:
    [dffe3e30] [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k] (unreliable)
    [dffe3e80] [e208fe18] ath12k_dp_service_srng+0x58/0x380 [ath12k]
    [dffe3ed0] [e20a1490] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
    [dffe3f00] [c067404c] __napi_poll+0x4c/0x260
    [dffe3f30] [c06746f8] net_rx_action+0x188/0x340
    [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
    [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
    [d0f2fb70] [00000000] 0x0
    [d0f2fb90] [c003a7d0] irq_exit+0x70/0xa0
    [d0f2fba0] [c0000c84] ExternalInput+0x144/0x160
    --- interrupt: 500 at percpu_counter_add_batch+0x9c/0x150
    NIP:  c0425e8c LR: c01a5964 CTR: c01764e0
    REGS: d0f2fbb0 TRAP: 0500   Tainted: G           O        (6.6.73)
    MSR:  00029002 <CE,EE,ME>  CR: 48008802  XER: 20000000

    GPR00: c01a5a00 d0f2fca0 c328a500 c1db7300 dffc0f20 00000000 fffffffc 00021002 
    GPR08: 1e763000 e1091054 00000007 c12b0530 88002808 1002801c 0fcf5000 c0ab85f8 
    GPR16: d0d1f7a0 dffc0f20 00000000 000003fe 00000000 f92412bd 00000003 c9525480 
    GPR24: d0f2fd74 c8a501f8 c12b0530 00029002 00000007 00000000 0000000b c1db7300 
    NIP [c0425e8c] percpu_counter_add_batch+0x9c/0x150
    LR [c01a5964] unmap_page_range+0x484/0x820
    --- interrupt: 500
    [d0f2fca0] [00000001] 0x1 (unreliable)
    [d0f2fcd0] [c01a5a00] unmap_page_range+0x520/0x820
    [d0f2fd60] [c01a5d9c] unmap_vmas+0x9c/0xe0
    [d0f2fda0] [c01afef4] exit_mmap+0xb4/0x2a0
    [d0f2fe40] [c0031610] mmput+0x40/0x140
    [d0f2fe60] [c0038df4] do_exit+0x2b4/0x990
    [d0f2feb0] [c00396c4] do_group_exit+0x34/0xa0
    [d0f2fed0] [c0039748] sys_exit_group+0x18/0x20
    [d0f2fee0] [c000dbac] system_call_exception+0xac/0x1f0
    [d0f2ff00] [c00110e8] ret_from_syscall+0x0/0x28
    --- interrupt: c00 at 0xfded438
    NIP:  0fded438 LR: 0ff23958 CTR: 0fd94930
    REGS: d0f2ff10 TRAP: 0c00   Tainted: G           O        (6.6.73)
    MSR:  0002f902 <CE,EE,PR,FP,ME>  CR: 28002402  XER: 20000000

    GPR00: 000000ea bff93390 b0316520 00000000 113e8af0 113e8af0 00000000 00000000 
    GPR08: 00000000 00000000 00000000 ffffffff b02ccb04 1002801c 100a0000 bfbc4260 
    GPR16: 114974b0 00000000 114a4de0 00000000 b02cc900 00000001 00000000 00000001 
    GPR24: 0ff239a0 00000000 00000001 00000000 b030f52c fffff000 0ff23958 00000000 
    NIP [0fded438] 0xfded438
    LR [0ff23958] 0xff23958
    --- interrupt: c00
    Code: 512a421e 2e140000 512a463e 40f20008 555b9f3e 39350004 754a4000 7c804c2c 41c20224 7c87442c 2c040000 41c20230 <88a40011> 7fc3f378 83a40008 8a640010
    ---[ end trace 0000000000000000 ]---

    Kernel panic - not syncing: Fatal exception
    ---[ end Kernel panic - not syncing: Fatal exception ]---


    user@root:~# Kernel attempted to read user page (c011de) - exploit attempt? (uid: 0)
    BUG: Unable to handle kernel data access on read at 0x00c011de
    Faulting instruction address: 0xe1e3dc44
    Oops: Kernel access of bad area, sig: 11 [#1]
    BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
    Modules linked in: ...
    CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O       6.6.73 #0
    Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
    NIP:  e1e3dc44 LR: e1e3dc30 CTR: c08d40e0
    REGS: dffe3ce0 TRAP: 0300   Tainted: G           O        (6.6.73)
    MSR:  00029002 <CE,EE,ME>  CR: 44004402  XER: 00000000
    DEAR: 00c011de ESR: 00000000 
    GPR00: e1e33154 dffe3dd0 c1870000 00000000 cebe0000 00000000 00000000 00c011ce 
    GPR08: 00000001 00000000 00020000 c30a294c c08d40e0 00000000 00000001 00000000 
    GPR16: e1ce2668 c9270000 c9269a18 c92664d0 e1ce26dc 00000000 babababa dffe3df4 
    GPR24: 00000040 00000000 c9266480 dffe3dec dffe3e04 c9260000 00c011ce c9269a18 
    NIP [e1e3dc44] ath12k_dp_rx_process_wbm_err+0x124/0x600 [ath12k]
    LR [e1e3dc30] ath12k_dp_rx_process_wbm_err+0x110/0x600 [ath12k]
    Call Trace:
    [dffe3dd0] [c0ab8e30] 0xc0ab8e30 (unreliable)
    [dffe3e80] [e1e33154] ath12k_dp_service_srng+0x314/0x380 [ath12k]
    [dffe3ed0] [e1e44540] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
    [dffe3f00] [c0674c7c] __napi_poll+0x4c/0x260
    [dffe3f30] [c0675328] net_rx_action+0x188/0x340
    [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
    [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
    [c18c7e10] [c12b040c] 0xc12b040c
    [c18c7e30] [c003a7d0] irq_exit+0x70/0xa0
    [c18c7e40] [c0000c84] ExternalInput+0x144/0x160
    --- interrupt: 500 at arch_cpu_idle+0x24/0x50
    NIP:  c00071f4 LR: c00071f4 CTR: c000fe14
    REGS: c18c7e50 TRAP: 0500   Tainted: G           O        (6.6.73)
    MSR:  0002b002 <CE,EE,FP,ME>  CR: 84000402  XER: 00000000

    GPR00: c08cc978 c18c7f40 c1870000 00000005 00000001 40000000 c328becc c12b0530 
    GPR08: c12b0530 c000fe14 0098ca91 00154674 24000402 00000000 00000001 00000000 
    GPR16: 00000000 00000000 c00119a0 dffee5f0 00000001 00000000 ffffffff c1050254 
    GPR24: c12c0000 c0011970 c0011940 c12d0000 00000004 c12b040c c12b0000 00000001 
    NIP [c00071f4] arch_cpu_idle+0x24/0x50
    LR [c00071f4] arch_cpu_idle+0x24/0x50
    --- interrupt: 500
    [c18c7f40] [c0a367e0] 0xc0a367e0 (unreliable)
    [c18c7f50] [c08cc978] default_idle_call+0x38/0x58
    [c18c7f60] [c007b3b0] do_idle+0xf0/0x130
    [c18c7f80] [c007b580] cpu_startup_entry+0x30/0x40
    [c18c7fa0] [c001325c] start_secondary+0x48c/0x930
    [c18c7ff0] [c0002870] __secondary_start+0x90/0xdc
    Code: 7fa3eb78 4bfcba59 7c641b79 41c20144 38a10044 7fa3eb78 4bfcdb85 7c651b79 40c2026c 83c10058 2c1e0000 41c202d0 <813e0010> 7c09b000 41c20010 7e84a378
    ---[ end trace 0000000000000000 ]---

    Kernel panic - not syncing: Fatal exception
    ---[ end Kernel panic - not syncing: Fatal exception ]---


My fix, as shown in the patch below, is to remove the conversion. But then the
member variables `buf_va_lo` and `buf_va_hi` must be `u32`, which is obviously
wrong. Alternatively, `desc_va` must be `__le64`, but that is likely also
incorrect, because the address is simply dereferenced, and this clearly requires
CPU endianness. What I also do not fully understand is who actually fills these
addresses and at which stage this happens. I hope you can help clarify this so
that I can provide a correct patch for this issue afterward.


Best regards
Alexander Wilhelm
---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c  | 12 ++++++------
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c  |  4 ++--
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index e6a934d74e85..8df41ee12025 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -678,8 +678,8 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_dp *dp, int ring_id,
 		hw_link_id = le32_get_bits(desc->info0,
 					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
 
-		desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
-			   le32_to_cpu(desc->buf_va_lo));
+		desc_va = ((u64)desc->buf_va_hi << 32 |
+			   desc->buf_va_lo);
 		desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
 
 		device_id = hw_links[hw_link_id].device_id;
@@ -1275,8 +1275,8 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 	struct ath12k_rx_desc_info *desc_info;
 	u64 desc_va;
 
-	desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
-		   le32_to_cpu(desc->buf_va_lo));
+	desc_va = ((u64)desc->buf_va_hi << 32 |
+		   desc->buf_va_lo);
 	desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
 
 	/* retry manual desc retrieval */
@@ -1354,8 +1354,8 @@ static int ath12k_dp_h_msdu_buffer_type(struct ath12k_dp *dp,
 
 	dp->device_stats.reo_excep_msdu_buf_type++;
 
-	desc_va = (u64)le32_to_cpu(desc->buf_va_hi) << 32 |
-		  le32_to_cpu(desc->buf_va_lo);
+	desc_va = (u64)desc->buf_va_hi << 32 |
+		  desc->buf_va_lo;
 	desc_info = (struct ath12k_rx_desc_info *)(uintptr_t)desc_va;
 	if (!desc_info) {
 		u32 cookie;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 629084aa36d8..4794e15f0e45 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -871,8 +871,8 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_dp *dp, int ring_id)
 
 		if (le32_get_bits(tx_status->info0, HAL_WBM_COMPL_TX_INFO0_CC_DONE)) {
 			/* HW done cookie conversion */
-			desc_va = ((u64)le32_to_cpu(tx_status->buf_va_hi) << 32 |
-				   le32_to_cpu(tx_status->buf_va_lo));
+			desc_va = ((u64)tx_status->buf_va_hi << 32 |
+				   tx_status->buf_va_lo);
 			tx_desc = (struct ath12k_tx_desc_info *)((unsigned long)desc_va);
 		} else {
 			/* SW does cookie conversion to VA */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 49c693289709..31e41a3d0fc1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -398,8 +398,8 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_dp *dp, void *desc,
 		rel_info->cookie = le32_get_bits(wbm_cc_desc->info1,
 						 HAL_WBM_RELEASE_RX_CC_INFO1_COOKIE);
 
-		desc_va = ((u64)le32_to_cpu(wbm_cc_desc->buf_va_hi) << 32 |
-			   le32_to_cpu(wbm_cc_desc->buf_va_lo));
+		desc_va = ((u64)wbm_cc_desc->buf_va_hi << 32 |
+			   wbm_cc_desc->buf_va_lo);
 		rel_info->rx_desc =
 			(struct ath12k_rx_desc_info *)((unsigned long)desc_va);
 	}
-- 
2.43.0

