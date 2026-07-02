Return-Path: <linux-wireless+bounces-38521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fvcjG2NXRmqiRAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:19:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AB6F7791
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=CmaM3t95;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=VqZvyAKV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38521-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38521-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CC53305D451
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC047DFBF;
	Thu,  2 Jul 2026 12:18:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AD47DF8F;
	Thu,  2 Jul 2026 12:18:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994731; cv=fail; b=NjiEhrSvJ6ZhL6NfSQI6EtEMJmFvkuIpVSbNcU3AkuTEgIb88zB5QD/EDbvFS0wxQRaWEFSHHghCypg91ZhjB7SrHOc5l6aQXvjRDh26Cb84ZL34oXzOZ9vUH6OXzXJ4+4QUAWx99BYO1ex4jpIJA6OY5KQ4XnvVYHa78vMtmWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994731; c=relaxed/simple;
	bh=g3XbSFHEKKs6fXxFVOj+4Zyzxc3PBwzYTu0tcTOVea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hLNtrEGQQKWPYYuWEDkFxXtOIpCZwCyOwwdTRWamx1qk3nLHtt7697n6QNvD4HWZC/hqQDzajRZPTbCgPecYCdP2dCBAESD4hPZMW+7JkBSzax8plpUPTndUR/FZFrFGXqIHP5852TZidZemjGc0kh5JQqZ3FC24nMmdiOOfhw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=CmaM3t95; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=VqZvyAKV; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624K2GM161476;
	Thu, 2 Jul 2026 14:18:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=w6vTJrsQFwdvycLC1FmNcjiW
	h/IFVc3XtvQL6ooeuYE=; b=CmaM3t95uDLMFlPKYazKUMp3EKrkfWZuRGe8QK11
	kZu7ZHp6pbdDcIIGm3xCtbSL8azyyUsg9JK9GtFXANFth0t7OgYsFMkxrwqo49zR
	EB9pQJTyA4iNQMujKXNmXIV4IUcpyuYwWQZfP03OOexgCxqnwsw5ri2CGZaaLMFH
	5Rd/ExpyCzPXaD2icwP4jp2UuaV5QrU2L6YvVxFYxXhVJN8OlKJSbodRBBa+QWWX
	c1ZPVyqmUXuitswUzI7W6MHMHMp8aFVgC+rje+tPftr4oW0X7yDR+TIWuXcVB/Kq
	U4+5B9w/2EK/c9yqIY0C+SfPRAkoFcJq5DkB/DrhDhOYcw==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023130.outbound.protection.outlook.com [52.101.83.130])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22v9ev66-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 14:18:39 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvnhOZ3WECvrymGeXcLLF9c22slRy/GoxUkYxCiwFdsstGyNoWSfY0Dq4FwZGHAl6WPk0Q2OjyEVRqSrql3b1dYDTMmqsI1puF8XdPQqZac/5rebQfueq2wauJ8/ppj7n+L5PWTCa0W5Ht6nvM7lhDkDMsH1tt34FvqLQsLOg90MfAOGc4iQaqeHL+azOT2ianOnuIsCfxfXJ0XHPIgRGjbHhskjAKhiFMYP8P15HvFL+xP7N2ChnHG8eYu81kmROmu4+qgb0erI+CmRvGPHdEAS6KKLTuEFY8TdRn5OHmPeH00KXV58g+Mbw6PsHUmo7/BD8Ef6kw20CXzYSwaa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6vTJrsQFwdvycLC1FmNcjiWh/IFVc3XtvQL6ooeuYE=;
 b=sfB1FxmRbilfuWWQyjvHCM7Xa5kEpQobHW0bTcp7t1Hcb7NrLBwU2PFYxeWNtOvz9uCTkXjuAN2hcmhdSXC3nNelAQA/6GJOe29aI+NmLqO8680zntuFv15CzRczF2vl4r9h+T/Qpfg76DaqFD5zvOCT/uO+YJAiNwa/Qxf2/3ck6yhZA4G2fSSaMrkbi1RWfo//8ngJMVgwZH0zmswHuJHVEmPKTioFrNLD0uUMPlL5HCuGWzmIm3CoQ6IcbnEi/EI34wIO/RSWhcmSbeM0J7orfQTDQRKHVhEeXmjy3ow9zXzV6qtf4qo6iFDKcfbiS+sKLLbmz70fNCjyPUJsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6vTJrsQFwdvycLC1FmNcjiWh/IFVc3XtvQL6ooeuYE=;
 b=VqZvyAKVUlPMx5+zrWXnkbndNUqMGj3YXX+ELXu2Dyts2aTPBOFlFPlHzuKC8GO29TqjNTGjLsupySdGqX2S8mywwrEcJJB2znDx4g8TD7O7bD3KGjivsOCBAIxyKWm9+gATLcrNMBviFRRlYtPbQ+hHL4m0ZFQFY4kzu3DqiEY=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by PR3P192MB0617.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 12:18:37 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:18:37 +0000
Date: Thu, 2 Jul 2026 14:18:31 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix channel list copy on big endian
Message-ID: <akZXF0SI8jVky0Wj@FUE-ALEWI-WINX>
References: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
 <8b29a6f4-0742-46f3-bc86-defa6e0faeae@oss.qualcomm.com>
 <akYk_pKRd7kR13IL@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYk_pKRd7kR13IL@FUE-ALEWI-WINX>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVZP280CA0028.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::9) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|PR3P192MB0617:EE_
X-MS-Office365-Filtering-Correlation-Id: f843316b-8a7d-45ca-70bb-08ded8340b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sl82oapNWefBgXfs03YfYRpnuWOqJUDs8QhUO5v3VzbldwaTg8klPsE8Tib9ye4bI8st14cuHMPHeY2URYiEX1YE/2iAOcabQ3aOx6jwQONKD0l82He3qxYK142vASE1Mjaluj7JS0Ql8VANvcVBpoNQHZXCzWHfXFxegl/Mr5AyGLOyIQv1g8HMConut1KhPDUnIhZJfebBychxXSGWixRWg9pC0e9le53RkQb+Fbli8ue1UPSbqQC3mQKlutYyhRIQ9Z+E7Ta57br12B7UvwgSgfBqn3xC0q3x4nnGgLa0SFid1sxw5LCKJNEEq1g99jDSgYUo1v71bX/fsdrxJKQW7PaeiS4krHe5CNizfFkQ/Gd8HMX49TeuImBD27P4h7FgLgV2DY7BiMMOJPMo012iOF8LmiVIYuan0jhTQ2zRgBf69CzJRVp97VslqUse9tg/Mchf8x/Huyub9SA33ZMJS6UUihYoJShzslTW+5khwdGnZGjMRta6KTnpDIrhN5TExdB0XuEVHZBCLz0qiDyKAdVz9M5cQoUwxC6gXR3P53jvgo97E/tEJGd+rnEWnGn5x7SsZds47GluS2tiko5My30NDbQjUqVg/HIsM+++zSp876sWI6PLV6xA2G4AR3+MsqXr30BsQeftVI8KNFu34OyjR6MGT84sDlY8nBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmCptVnG+RHU3PI9lSPuvj0iJ5tH4U1mGdumxNXwz1/dOcqkIJSWGCA2KtNq?=
 =?us-ascii?Q?9z28vORgFnYi3GBSJPY8Ymdc2hWFIp5KRjR7CQ9qRiMlutWih/GRcHoY7xKU?=
 =?us-ascii?Q?gKRMyXwvGeGH5Ar05CQGIQBsXwFTbXqndJ4vfDkn60WVtTg4UMyAyHPvUmlc?=
 =?us-ascii?Q?8lNWGy064VctnhKhw9VcuWVTcVVR7T2mMchox2cCJFDasQ6UDgorjawDpfaD?=
 =?us-ascii?Q?/DXG56HReSBKbEM/nf65Er3s3o/uB5TL8Dv0SXEPqO296wkGpzjfmZqFg8Pb?=
 =?us-ascii?Q?AuZH4iR28q1sbXq3GLwRzvwznoBtAcSvFJF022s3vsGmPjderDo9ZiPFscfR?=
 =?us-ascii?Q?kahYzX4Ng/2WkSehXUfzFwzQYpIA2+AR3F3ysfPAjEJ7T2q6EIL/jxOkFW4e?=
 =?us-ascii?Q?H03BOuFdyYY5WepAVRbDSAxtFewwYz3h8OXtbsqnOOkOrAHc12OxWdCm9n3e?=
 =?us-ascii?Q?7aE6hq5UtVh3hUSm5ivIbkIHbsplUUQNnKOae1MOCIRlKM4Xq8Dh+8SoXz4n?=
 =?us-ascii?Q?ck0zndXyc0tHFsebhRK1FSMAwAv04cd3vWFAEw5Nasm8Yv79kG8rFJg8Hdul?=
 =?us-ascii?Q?2PF8d041Y7r7/yvHnD3aJ/jqMM8YWDNRGzah9yBge5PZpg2INIS9isd2KjWw?=
 =?us-ascii?Q?IZrpa1Pyuc5LKqGLzfcG1Xn49n0zvubkeG1zMnXCAFIh/q9GA5vILky1BdN0?=
 =?us-ascii?Q?d2YY4/LOl7u8A+yf9mR8bpbFOWXeI1kvqHoAto6FeAFNhbvk1kcqmMI9fIVr?=
 =?us-ascii?Q?Eb8idd3H2Q5vhZR2BDTFYdmIE3MkDMPMEsQGcclDwSl29HrY1wQMGv3MSnfP?=
 =?us-ascii?Q?OTvGOdOw+XXNPsEFvo3GsHPlWBYecSamAUB2s64VfII4oz4tEQFvknxXDvsH?=
 =?us-ascii?Q?pWW//KrCI2CoxDF0uJjZTAz5Jf92KvU986i90BqAECXPa9LoDLaOjxhMFQOj?=
 =?us-ascii?Q?d6A6evAPS0XNWJ+QJEWrIxpLqrNDwMCvZA6JmZS0NuUpmh6G0Qg4SkPxI75z?=
 =?us-ascii?Q?DEJFfrmirf9ry4/OThTrB+cFJIVXYe+LiycB8pvv1pBuCsHxfxFIFAjQ0lqE?=
 =?us-ascii?Q?mco8P6HjriqtsunxfDEwoktLxjPek8e4dwQ9fEdeEwYyvFun47bHf7TX54A4?=
 =?us-ascii?Q?wiQLil/+oZsNTPr+Rnqial66H7l1L7h3CQOVxW7uMN9yK7VBga2CowZXIkq8?=
 =?us-ascii?Q?CFmPFFcXuWYWGWQX7EOgpcplGSBvcqpVmJRAlpw/USQ82TfvgyfgprVdsrwC?=
 =?us-ascii?Q?bM0ZQpY/kK9nquAASuHL/+HAFIy9eT+qhuxFhredMYlowxSa2DmfsFS3wYg1?=
 =?us-ascii?Q?FgoOG6r24r9VDKQD5o70XBDVhKD51epM27k82JU1lgMxR1UwZLzSGJJs4rZ3?=
 =?us-ascii?Q?6VcQDMAKh6FmC4J1uhM8QbIy7yCzlUdmKCZCAsi9Pzwm3Q+NoNxk7XV5Mm9d?=
 =?us-ascii?Q?N/UCnTQBrRFoZ0+X5JctVTjCvGfzsrPe3Y3eGorU7P6XDuX3vmRXjYRjq1sd?=
 =?us-ascii?Q?ACKaglVe95lOhmgL8ptkypsDqCUeRmX7tZQOghg4yLkmAoZbZKHDOzFpK1v8?=
 =?us-ascii?Q?UulW7RzMFB7NLHlh4hZ43I5yxPpaRzMPAEVA+ZunKtvDsFsQ9R6Umlh8aCzw?=
 =?us-ascii?Q?pCVr1pYRUEAC7AiE9LSCYMCrV9KmmVDNO8bvxhmouwKsxIjXt8qkxNyFhC0r?=
 =?us-ascii?Q?mpP4AJ6zlLh2J7vrzmNz2ZJUOlM9OnveSg6HGs0qE9n4d1JlSLoIjEPoNEE3?=
 =?us-ascii?Q?He41oxvLzw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	jA2aqnoehXOV7uIvJLlB8dQaoYbwK6wQkFwK4wGoU8f1fr52Ooo6ANM91VK79TTOKmNPRT9jnmLnSzI2+lF0lY82aeuUC7mNdwjWaqsRWQZt6CNMZHINdI56Aaa+/FmewHwM3I57TVNFEX99fi+6TdTCaY8jZt8S64MN2mGRqIvmI6GnhVvAi18SVWrM9N6JpmfsCj0CRaZK9jqxDvZ/zqA3L7ETZs9beJrsyJc4rU5T1dIr2Xa1kXVzzaQDT1Ak/26TjnCxSHEmU9dQabTeORv13Y3fjcwjvNGSjWniapACE1gP3ljyMQiDBi4V6H1fx6kwJ8OQZw6lLrossTKOyQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z6AJjicbDkg6NT+nVsIDrS90kdUtobgcE2S9dj28PdrTCwGnCOL/ZmRdLukbC6Wa9M6znvqkypcK4ejb1iNeElhGanNo4Iw9uynzGob4OXXhJleF0uzGOyboFEwkP47gtKAct4oZj9XP3Yd1MD3QMoFQlpVUO//e90skbIVN5NMmRMUyLVjMN+8s0IrBnsNjaYSI6qJeN1dzIcOJDYYhJWbiuVTmCxVVGkIxlpmxL2C/tWW6AH7B3+siBbO2s28BexOdZSftpvkMhljx1xvB19xtKtWMf7SVdyyxbJx4JJ+uGJ6iiySRbFkF7UsvVU/NUL9+jIUBJl53OV5qF1tvcjckErq4hKxImKGxxhB4xxW5T0A3Tjs21POzoJi6QPicGtGgGP1s2UTetnKIf+ALYVgWHH4S24tfsHDMCGGYZflEkxvjZUFsG9aDybQh3mSj+YSn9hN+9KP6d6YeedutmVD2X2AEwda3WWNwXBY9JYm/ujoi3qkBtS9Tv5HA9Rnybkol4VzL7pXfnzUHwNBN5jABvh/VGafNE17T8TFRxblSzos+UxTTnJvNz3j8LI17+lDp5liI8X2IO+aCIXTMoM54yDAh3Hs1pq8sbvWnL83m593lpxWPHxBjiBz1Kr3u
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f843316b-8a7d-45ca-70bb-08ded8340b2d
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:18:37.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/UvUxi9wZFoNGxGIyz1HZ2sxyrK9xQNMwrOLiXobgS2gqNAPg3YQGBGTCS4JQ/E3GcwxKKQtt/3b0/JR2WnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0617
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
X-OrganizationHeadersPreserved: PR3P192MB0617.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOSBTYWx0ZWRfXyoNs1gffK+EM
 bEacUF+UtJfIHvr+Ze9XWBq19DGQMHyZhqlmMvTnrTvUMkhkb2vZjuv+Y8lt8onhfdbW3SCbplm
 4lRlvekTm6OHIfpiOir4PiOnhVsstivdCup90DXT7v/Val4mHnEFeCXvp/y6GXFTqeOjmUVIrga
 W/0Uq41yeSoZ6n6JuAFVYmwC64kGqbrQGrsswLQQUUzBS13KYPMdval+jWThaS0deb2Lha9aV3B
 g/Wl3gzA3Kw51EN2gPh3LGday6oUPSJ0sCQUs+0kKyI3jWuDUcnDvAYcCxTCI66AZth8A7JSBiF
 vfnNla/JUNkfMBk4fvj+WO4CKb+h6MX0MGCRd84b8bdyBNcd8Ip1sBih2RyCTGXDDL8n3VzM0Wa
 BmdxHc36b5V2RMQW8ERi/h1z6CvfoyzAqFkqn0DjB69f7Ej5n65rK8cES+wJSLGL+EVOEebJNMJ
 rLvPFiOEdpxPnOOrA/g==
X-Proofpoint-ORIG-GUID: 48ilPXwSpvNhJK1_7oBK_Uz5dWz8-xtQ
X-Proofpoint-GUID: 48ilPXwSpvNhJK1_7oBK_Uz5dWz8-xtQ
X-Authority-Analysis: v=2.4 cv=ZNznX37b c=1 sm=1 tr=0 ts=6a46571f cx=c_pps
 a=/0AuqCiVn4bY04m8hGJ5ig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=lqbKV73mCznI71o3aJAA:9 a=CjuIK1q_8ugA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOSBTYWx0ZWRfX9xiaS0Bp3F0T
 wninPpWwzpTuvvmRadYQNvSjNr0nG2NoUMLJaUtuKTfCJZ4jy0AGoEJqL3GrrQGR63slQ1YtUd2
 CjL+OujZenEfayYmjXssiS4c15DhjDM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38521-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,westermo.com:dkim,westermo.com:email,westermo.com:from_mime,beijerelectronicsab.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,FUE-ALEWI-WINX:mid];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546AB6F7791

On Thu, Jul 02, 2026 at 10:44:46AM +0200, Alexander Wilhelm wrote:
> On Thu, Jul 02, 2026 at 04:27:44PM +0800, Baochen Qiang wrote:
> > 
> > 
> > On 6/29/2026 3:46 PM, Alexander Wilhelm wrote:
> > > The ath12k_wmi_scan_req_arg structure defines the channel list in
> > > CPU-native order, while wmi_start_scan_cmd expects the values in
> > > little-endian format. The simple memcpy causes the hardware scan to fail on
> > > big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
> > > values to support both architectures correctly.
> > > 
> > > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > > ---
> > >  drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> > > index 65a05a9520ff..9e1d3c662852 100644
> > > --- a/drivers/net/wireless/ath/ath12k/wmi.c
> > > +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> > > @@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
> > >  	struct wmi_tlv *tlv;
> > >  	void *ptr;
> > >  	int i, ret, len;
> > > -	u32 *tmp_ptr, extraie_len_with_pad = 0;
> > > +	__le32 *tmp_ptr;
> > > +	u32 extraie_len_with_pad = 0;
> > >  	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
> > >  	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
> > >  
> > > @@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
> > >  	tlv = ptr;
> > >  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
> > >  	ptr += TLV_HDR_SIZE;
> > > -	tmp_ptr = (u32 *)ptr;
> > > +	tmp_ptr = (__le32 *)ptr;
> > >  
> > > -	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
> > > +	for (i = 0; i < arg->num_chan; i++)
> > > +		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
> > >  
> > >  	ptr += len;
> > >  
> > > 
> > 
> > seems hint_s_ssid and hint_bssid at the last also need the endian conversion?

`hist_s_ssid` and `hint_bssid` are both structs within
`ath12k_wmi_scan_req_arg`, and the remaining member variables are also stored in
CPU order. Therefore, it seems wrong to me to perform byte swapping at this
point. What I actually need to swap is the data written through `ptr`, not the
structure members themselves. For that reason, I could also use the `__le32
*tmp_ptr` approach. What do you think about that?

One thing I am still unsure about is the use of `ether_addr_copy()`. Can I
simply copy the bytes as-is here, or does the address also need to be
byte-swapped? I could not find any place where this address is being populated,
so I am not sure what byte order it is expected to be in.


Best regards
Alexander Wilhelm

