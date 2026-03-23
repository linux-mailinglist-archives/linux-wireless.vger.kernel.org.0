Return-Path: <linux-wireless+bounces-33713-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC8HHG4iwWmTQwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33713-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:22:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9E2F1221
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12463012202
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3B386434;
	Mon, 23 Mar 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="1NnWscLB";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="qEV2qEr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EA36C59E;
	Mon, 23 Mar 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264835; cv=fail; b=i71PWiyWKBgTBefnaV9Lash2Mfg+AFDNyPvmmOyXyksK4uuEqUNKUPl0ut+aAmwCYiiwR9nvy0LfW0H/ccVILT5AcuuPCnAEa1Oqz4tjD/9iq047cO4iccDiwIA2PKtGJDUY+7CbY9WzTsQ8NqKQnKMyYd/hulsE0WOH38yBggw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264835; c=relaxed/simple;
	bh=Av476EVX6x3XmfunnntTggiAKhozpvku4mjxaH5q/wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MQywm3OCheIUFEsycWRnOpcod6c0CHKZL9K5VFoF3gTgV4lXMQAJDaUwfPp9LvjS5ttGXnGHKb4xyDHnLA2OWpy3DDZVw23tQeAFKI4fuIb2YK/7FeAj9+dk+9LVtEHZQEtxkDkSVLyttuDmbcv+JdXTbozN0PhUbyJCZlgD/Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=1NnWscLB; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=qEV2qEr4; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N5037F446826;
	Mon, 23 Mar 2026 12:20:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=i+Dhvsc1OWQ6VOGtE+cBZjqQ
	M1ZfMc3wqdf9zsUddMw=; b=1NnWscLBow8fpvDD19xCYsfOqycy6c9+7Hs5nQ/H
	fcQ/O7JctLjD94tVTFX6VlWphn9MwF0hSA/lgc1FC/JjL41VlZOWFdYFm9YUJOWO
	dO1Pi0nyBHlylJNisQzPsgA3rHeMqvW9Nx4J7Qi0D0y/a5+dsW5yBxrzB6SS6nhM
	F3UUNmGKoKs6g9pJaDPX2+rdRpaYnfbyq4d8FSQ2wy5ZdJr5ZVUiM+i0Qg5uFlaH
	cFEfd6hpByPZbSGuuv7asH4uBwyjwFCNRnz8BDpNbnxmNLYjiamm2lPU+U2D2kpk
	K+LAOawHDXZPbsjWqAEBvkGswKrAcYSEbdkv9hQ2tMuuAg==
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11020134.outbound.protection.outlook.com [52.101.69.134])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4d2p698hqw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:20:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HizO978zNK0/1mRE13q830qRdkJDu/OXDMYv/qN2XApXCuuGA5nksUNbEqxMyU7rhEzyWzrGjc0ymeMYlZ/6gHJgX+JUf6KyGZKiwEqVChYOUaGG2HgdEgYNsAkUHdz+zJNQb35FAECvufBGhitE/LXt0wTYOG18wrk0Rszi6LJpYbEpNDGgQrNotVK/qP4S+LooGlIDU5Aj4rf8tmidRRq+2oVKC6YwM07qK7Il2+0rHwfOODA7pikpCF0V0cBtx+vbGA/n7Jy0jwQFKL6Ew7DCQ4Yko6jE+AR9fSPBlxXwaDW0rNtzDs0kK9WSco4VaG8aM+Kanmy9lRlSOf7XGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Dhvsc1OWQ6VOGtE+cBZjqQM1ZfMc3wqdf9zsUddMw=;
 b=XcEUvPmQAKmw6SLLY6Y1UuLIje+w7pXWKzOQML9MuKiQcqwfI0XWMPTiDP3vXe4RH4K8AL8bY790vYp48Qf+8OuLgKaCAk3ldFD1mAjw1KVOyi98R1jfDQaSFTivoMA+BnCsI2vsRaNx4TDPjv5O946Ejj6HWVhPtSG1KXIaDFYlTKOk/uVdNDCVnRMKGGeymmc4gojg/uCHrCGKinzYvwhaaUJINV8k2cNq3oK6On6kpMeFzK2+xX0qoZLGsAJuVV1VZvcxwTphQ8pr4ORv1ragS6tdih6ZDvlMQTGYXwEYle4zaWph6w/TdumK85Vfs8URph5DbCheDbyZgZJgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Dhvsc1OWQ6VOGtE+cBZjqQM1ZfMc3wqdf9zsUddMw=;
 b=qEV2qEr4XM+InH3qepA12l3ztqQa88deanaOtg0z4cLLxhuxZuIDKEtFfoijSe0+E9OnSHw97XVgMV5QU/S52xxgggo6GtE2vu6FW5nf/YcI5RI2kHbUkY4HCpFU+o/Zwp88uW1vg/t5IxvTZ++RhBpMq3pHnLnRyReuhCBt9OY=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AM9P192MB0872.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:20:05 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 11:20:05 +0000
Date: Mon, 23 Mar 2026 12:20:02 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: desc_va endianness problem
Message-ID: <acEh4vckyl6bq29l@FUE-ALEWI-WINX>
References: <ab0Y9v6BkH4HDrFr@FUE-ALEWI-WINX>
 <d0db7062-f428-410d-a704-395d67bd4554@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0db7062-f428-410d-a704-395d67bd4554@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF00023994.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::185) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AM9P192MB0872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb0e7ca-118a-4a1b-88ad-08de88ce2279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S85IZhSXQ6vOVP0Lq9uvjjugf/lX373J0NMSNLFDG4z19zwbBYvcX8vdBUlqT1k/cIpXZ6v7kN8ksXTplDdlLSc2Kk9te/kKT9w5uTJbkj13mdn20lg50ydciUxbiwEuPAYykAkeF8pE8eyegbUImIS64oPULu4lS98aLN3v2YOGjwJE7ibBqsjcX9Fvx9/SVGdJYS2H/OvLuTI2LtsvMJh9RBNglw0mtm8uFaZtbmuFBWow5rKMkjA92/kJLjq6d7JPck8yGs018MlbTERj/1Ar6mYshvsdcdpfnr88Bb1olsp+zpP6sEYAy9Cm7oj7lOjcEp/1gtWzTdsxmskE8dcKz7TeJvoD2lQwpmWsC/d5dmYoMPYb9sx6kjNrZBh7SM8Pd4t9kCvx+sxumIzpf4sjSKMcHPpBotH2T/gZD97vjAtYegFwDFvnBQSlTMHTlW4RcCcRI4uKEblaeHHP6AXAcGuhf538/CS5xbt5+uXz88xYE+EJO+qdbUI/tOi9MnpSr5jlIZ4jee/fRT0URfCVyW0KrmvvIoo1/OU+do/sxIbq/QnVsznviwabAfW5Z3ExRLzNsc+DKZTWcltVoT+WSpANjzQhp0Rp4dzBbBne9ObnmiGekNHDbO6z13LIu4Eh+fMIUvkdkvWeHin4FdfCrUYxx9UpTwgNqmHyImweKEejawIZnf+ZH6dk8vW6mFYONfXSNhomYiOIQsx4Rtsci/1SFn+sS6BgYabGwdo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IR++l2UOT+qkO3/4pDMTW9yAYUw94SBMFKOSt3lnJRGDTvQb1om7TXDJB1+6?=
 =?us-ascii?Q?3QiObUZFqb7oqd5by4uk0p2o2mzoreOBuSgki6eORHalbbguA6Ijxa50F2y1?=
 =?us-ascii?Q?5G1J4lUq5FJBMfRB+mQB+Tcd3M5MGH17reoWYFFAodLfD/rsmTJT21BeTCye?=
 =?us-ascii?Q?aMuryCFRmKMgcrASZZZQ2/qiGTDKLKyvlDlUtfekML6g+nrx5kaN8fYoh2VY?=
 =?us-ascii?Q?qQMXXaGd8FL83Ib97IKX/P0Gp9R+UZ1hARWrz0zQ/gOem1bfuTVYHw0Oyf9H?=
 =?us-ascii?Q?3qkzT5CEsoLHV/UUC9hKBtN1lmsB/2ONJKzgJF5EsKQ5CBe+hbYXkjEk8BkN?=
 =?us-ascii?Q?Q1jvwhZy4vfsm/aAXjkmcdoif1j/1jvWzU4Odob5LwWzKzcOBq0dFFYFl9ib?=
 =?us-ascii?Q?mtK/KHFauDxRwx8v0+YgZi5wDHX2xKL+WTDcUMCktLw6V80X13awT3pGE7SA?=
 =?us-ascii?Q?jklIXgGEW5C88YbskYy0iYgxExtDTmNK+FGXpY01OHfmJkQ022wWv22S1nna?=
 =?us-ascii?Q?xeVq3vuD3vNI3wech9w+VPtNXR80QjnQt94v5LQuB2s4uwFVkxUSRkE+rT6W?=
 =?us-ascii?Q?z/I6zk6jlWqSB7D/W+Zd61XeBxnOpKjpps/TFG+yQ0S8BpPmzyIztmj6Bmoh?=
 =?us-ascii?Q?1xUjUWkl/WmFIUdW68kWieb5KQlhMv2JfYrirk2u00SZUwxHiOkP1xNGTEH3?=
 =?us-ascii?Q?Bd+dBmrEI7OGwXA+on0anMbqSLT9WR0NiRQb+t341h5gkecPb0fcrf63ErgN?=
 =?us-ascii?Q?KddxANpu3iLIMfGFMZ8lu/7WWKyby0ZGJ2FwDKATpLolo/UVSgAtaAJpo07B?=
 =?us-ascii?Q?ONaXQJNtKSNl1753KpWXWcm/cIoxzylE+4g6SN4y3I2Hxro0cnsVVwnBkfpG?=
 =?us-ascii?Q?66cVEGlE562ewN5L9B2XhYbNwA51Kln6ycHGHBVo2bj6NTf2nextl1XB4QQc?=
 =?us-ascii?Q?FgBv2ERqtxIa2spAgqBHX7YZY30eJaqyYVZWBIV7qV8xEPBEfoVphhDLvU0c?=
 =?us-ascii?Q?jrsO/11eVAjHXi4vmUPNYtjpZBrCb9Z46I6UyIbP0ZUWVCfYqgE7CxCClHVc?=
 =?us-ascii?Q?+kRfUsUg6qiFRg246v9l06q99Kn64j6LfyL6nG32Y0EZcLCi/Jr2oGAjhP26?=
 =?us-ascii?Q?MabrMdCloSgD5Cbp/rP/AhApvhYwLCOLV7JDv+AmehTArJuNvPsnRD68xElW?=
 =?us-ascii?Q?Bb+igocP1igh9aVtU+gLb+4T8bc43Rssch75kcoX8+G5xXJyTBYuefhQGWDN?=
 =?us-ascii?Q?ftKlDIa119tvpfe5DfZw3u/p1zb0eSjE/V2SNnTUjblzBunMiuwmW6jXj+/M?=
 =?us-ascii?Q?ZARhTX/T7rgheYUVgoSbSGWMg9OCoS7fUACJ/Yz/XOZtis6BCaHC6yllRVKU?=
 =?us-ascii?Q?s0Lrp3YXpUqtIHlwIA+gmrzYv261g/NB1bYfW8YwrNxTQYp4KpsE1F16ksxU?=
 =?us-ascii?Q?Jpse2q9K/Qw4XbGAXUUvh8v/RUPPuGGRD6NUqcw104as2FZSbdWYXJXOkNSV?=
 =?us-ascii?Q?m1OoivrKSsdn1O4F/Pjsom6ClkdX6R+l1vJdzMjrOIPcEXno9TxZWP3GZT+X?=
 =?us-ascii?Q?+NXgxyZNOfJl0BFE6UwILysuvtxZSS9F5XEV4hogEMYNx596ctRxx1rgoLAU?=
 =?us-ascii?Q?Lg04y6K2HYkuDMI8L/uCQnYWoESpsjEG5AZKRlMrm51SJJGT0duZw3NtEKlJ?=
 =?us-ascii?Q?9DoICYfnD1/4fnASgDZ0L7SdHZ0wvnIf5QcUzWHjENuS3d6wCI9Kk/HuVLXf?=
 =?us-ascii?Q?ieGO7c5OmQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	EvLkstRaQnSA4CDi/hogytGx2iBF52WRQ0uGRoAAOLYXeLxBXBUc7KsKdSQ/j5Lfbv0QNWLsgk+k9nrSQQVJGB5gFfkS065WYLbM30eaucuhX4ChMhCLNuo98fwKDgUow73tobdjayH9rt5hvQxXWHcPfgGdmMCIRz2HwSoePMFM241/9eOL35dcAwtEAMb74kZwPdyU9lZQfdwFCfPJeQ81fLpRd1v2ijb9LIn0q8yRUgpApUupDIznrBah3N1eT5HB1t2GDe/6BubGW0REbvIXpt2GCNsNlUK1IR1O884WGbD0JDJFsOlm7opOd2Z56GUzxCH/EkBGbgZzVMg0MA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sqzUpntKEspBS81ZJlO/DsawdRxIac8byX51wDNmig9VNc882L0tiuRkLCXVqKh5q7Txg4PbljLseWnTa1PQGOLA8Jjt5HimHQpMUQFc0yCEIKgDLwVovoOPQS9Z2+myN2W4Bn/b7ZJ8wcJja7j98bEfWmotCrOXIcMWQFlGSCcHlHSMiil/UY5f+4zfIKTKn6NIRUDzIbRcdGcIhH0C+TUHQy+9Y84gEYZt7zytk4SE0aUiCVYaSRh/Fm6BUNSoHBYnCTq88lTI0Q6pi4dQQbM3YxN57hbGKlFex8JgVEmMpFFUNF88bHDj2VDvhS+iCo0yfvmuxN8JSK6YFRRM7ZLfqkSYDwmz9mYlIPrD51r1MCFndQ5l4z9ub2ksBti7ANmqaD46zODd2JcjAKhrowJFfbymOcUKLCtr3FNAKfRus2KO9+vfQ6iu5HE3P28watX1v50zQkl0+Y3sqFmPMjTJ+2seLpfP/1WkwAZ7GrinSRg7q3h6/9BZPmo2RkDLBLnZIBuIzHzXex4rLaArgcrMh3Icx8+glYPVcHm0B3D+g2lgfvXK8mSiFOBEt2RF0XVxvHnjhjUaIUsK6Z+C2oCSE+OZAwLBkaovoUg6vxcNdSVaBhb/6khhdyYGF3y0
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb0e7ca-118a-4a1b-88ad-08de88ce2279
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:20:05.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVgZy98CcwS9wsbCZW1Op8s4PaOJiWmmfC5xYa4qf9rxJYss+t2hwuTyPkd2es5ZPNL6xxeEouG/utnWUtTdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0872
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
X-OrganizationHeadersPreserved: AM9P192MB0872.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: 7kRLN-1mJ65Eh4B1NjMPQtdYt_kIwBW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4NyBTYWx0ZWRfX11md874uhr1E
 2zMRj0iJ4qvfX+CYMhAHvgLEr3Yzuif6c7HqkmuLqx9AE+QNJEicKr5W2xbd5jzqb1qBVR5L/8k
 cl4eVb/0nRTl7vc1Ziuymlm+Xz1z3859vpq8vSaieRKuU4A+nzqa7+oXDmV6AFke/xpCiOdiw1I
 8lHz9j242PsPaoevwa7Sil2UIhXen+mresqBTE+EAB4h4qBR6fFkjD75fiOMP7YkusAi267v+hH
 eJRCf3j9g/2xsDJX1FZmYexdLh2kCp+g/JAca/K8qMrTWVsRfTWtYixucyAUqL7b4cUiB8Z9bfi
 eti8p5vwRhkeRyagv+d0urfGNQ1ysXxcsHXljCub/Ol5ut6EfjhR6XOYPMgHrslfhg3aH7Jd7IG
 Vp6Z1goyGfw7xdGGD2riNNm7q0yXYJnwzufY8UeSztDf/eYfWpkcVfTqMwcDD5wqTz2q+PBLXFC
 Bac75PB80RstRipHcQA==
X-Authority-Analysis: v=2.4 cv=K9Iv3iWI c=1 sm=1 tr=0 ts=69c121e8 cx=c_pps
 a=f0zd6TNSY3rBIns+TsgepA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=AFTvTRuWCIeG-qExZDUA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: 7kRLN-1mJ65Eh4B1NjMPQtdYt_kIwBW9
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33713-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17C9E2F1221
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 05:31:03PM +0800, Baochen Qiang wrote:
> 
> 
> On 3/20/2026 5:52 PM, Alexander Wilhelm wrote:
> > Hello ath12k developers,
> > 
> > I have another fix for the big endian platform, but unfortunately the data types
> > do not match here, so I need your support. The problem is the following: the
> > structs `hal_reo_dest_ring`, `hal_wbm_completion_ring`, and
> > `hal_wbm_release_ring_cc_rx` all define the members `buf_va_lo` and `buf_va_hi`
> > as `__le32`. At first glance this seems correct, because the entire structure
> > contains only little endian fields. The local variable `desc_va` in each
> > function (see patch below) is of type `u64`, so it makes sense that I would need
> > to convert from little endian to CPU endian. Unfortunately, this leads to the
> > following crashes, in `tx_completion` and `rx_process_wbm`, respectivally:
> > 
> > 
> >     Kernel attempted to read user page (40dcdf) - exploit attempt? (uid: 0)
> >     BUG: Unable to handle kernel data access on read at 0x0040dcdf
> >     Faulting instruction address: 0xe209290c
> >     Oops: Kernel access of bad area, sig: 11 [#1]
> >     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
> >     Modules linked in: ath12k(O) mac80211(O) cfg80211(O) compat(O) ...
> >     CPU: 1 PID: 10200 Comm: jshn Tainted: G           O       6.6.73 #0
> >     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
> >     NIP:  e209290c LR: e2092854 CTR: c08d3190
> >     REGS: dffe3d40 TRAP: 0300   Tainted: G           O        (6.6.73)
> >     MSR:  00029002 <CE,EE,ME>  CR: 44004804  XER: 00000000
> >     DEAR: 0040dcdf ESR: 00000000 
> >     GPR00: e2092854 dffe3e30 c328a500 e2092854 0040dcce 00000008 00070000 cf900000 
> >     GPR08: 00000000 cf900004 40000000 c8e52c4c c08d3190 1002801c 0fcf5000 c0ab85f8 
> >     GPR16: d0d1f7a0 c12a9080 00000001 df7b7f80 00000003 cf900000 e1bc0000 e1ccb988 
> >     GPR24: ffffffff c8ed0000 e1cc0220 00000000 c8ec0000 c8ec0000 c8ec0f50 c8ec0000 
> >     NIP [e209290c] ath12k_dp_tx_completion_handler+0x22c/0x720 [ath12k]
> >     LR [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k]
> >     Call Trace:
> >     [dffe3e30] [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k] (unreliable)
> >     [dffe3e80] [e208fe18] ath12k_dp_service_srng+0x58/0x380 [ath12k]
> >     [dffe3ed0] [e20a1490] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
> >     [dffe3f00] [c067404c] __napi_poll+0x4c/0x260
> >     [dffe3f30] [c06746f8] net_rx_action+0x188/0x340
> >     [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
> >     [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
> >     [d0f2fb70] [00000000] 0x0
> >     [d0f2fb90] [c003a7d0] irq_exit+0x70/0xa0
> >     [d0f2fba0] [c0000c84] ExternalInput+0x144/0x160
> >     --- interrupt: 500 at percpu_counter_add_batch+0x9c/0x150
> >     NIP:  c0425e8c LR: c01a5964 CTR: c01764e0
> >     REGS: d0f2fbb0 TRAP: 0500   Tainted: G           O        (6.6.73)
> >     MSR:  00029002 <CE,EE,ME>  CR: 48008802  XER: 20000000
> > 
> >     GPR00: c01a5a00 d0f2fca0 c328a500 c1db7300 dffc0f20 00000000 fffffffc 00021002 
> >     GPR08: 1e763000 e1091054 00000007 c12b0530 88002808 1002801c 0fcf5000 c0ab85f8 
> >     GPR16: d0d1f7a0 dffc0f20 00000000 000003fe 00000000 f92412bd 00000003 c9525480 
> >     GPR24: d0f2fd74 c8a501f8 c12b0530 00029002 00000007 00000000 0000000b c1db7300 
> >     NIP [c0425e8c] percpu_counter_add_batch+0x9c/0x150
> >     LR [c01a5964] unmap_page_range+0x484/0x820
> >     --- interrupt: 500
> >     [d0f2fca0] [00000001] 0x1 (unreliable)
> >     [d0f2fcd0] [c01a5a00] unmap_page_range+0x520/0x820
> >     [d0f2fd60] [c01a5d9c] unmap_vmas+0x9c/0xe0
> >     [d0f2fda0] [c01afef4] exit_mmap+0xb4/0x2a0
> >     [d0f2fe40] [c0031610] mmput+0x40/0x140
> >     [d0f2fe60] [c0038df4] do_exit+0x2b4/0x990
> >     [d0f2feb0] [c00396c4] do_group_exit+0x34/0xa0
> >     [d0f2fed0] [c0039748] sys_exit_group+0x18/0x20
> >     [d0f2fee0] [c000dbac] system_call_exception+0xac/0x1f0
> >     [d0f2ff00] [c00110e8] ret_from_syscall+0x0/0x28
> >     --- interrupt: c00 at 0xfded438
> >     NIP:  0fded438 LR: 0ff23958 CTR: 0fd94930
> >     REGS: d0f2ff10 TRAP: 0c00   Tainted: G           O        (6.6.73)
> >     MSR:  0002f902 <CE,EE,PR,FP,ME>  CR: 28002402  XER: 20000000
> > 
> >     GPR00: 000000ea bff93390 b0316520 00000000 113e8af0 113e8af0 00000000 00000000 
> >     GPR08: 00000000 00000000 00000000 ffffffff b02ccb04 1002801c 100a0000 bfbc4260 
> >     GPR16: 114974b0 00000000 114a4de0 00000000 b02cc900 00000001 00000000 00000001 
> >     GPR24: 0ff239a0 00000000 00000001 00000000 b030f52c fffff000 0ff23958 00000000 
> >     NIP [0fded438] 0xfded438
> >     LR [0ff23958] 0xff23958
> >     --- interrupt: c00
> >     Code: 512a421e 2e140000 512a463e 40f20008 555b9f3e 39350004 754a4000 7c804c2c 41c20224 7c87442c 2c040000 41c20230 <88a40011> 7fc3f378 83a40008 8a640010
> >     ---[ end trace 0000000000000000 ]---
> > 
> >     Kernel panic - not syncing: Fatal exception
> >     ---[ end Kernel panic - not syncing: Fatal exception ]---
> > 
> > 
> >     user@root:~# Kernel attempted to read user page (c011de) - exploit attempt? (uid: 0)
> >     BUG: Unable to handle kernel data access on read at 0x00c011de
> >     Faulting instruction address: 0xe1e3dc44
> >     Oops: Kernel access of bad area, sig: 11 [#1]
> >     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
> >     Modules linked in: ...
> >     CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O       6.6.73 #0
> >     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
> >     NIP:  e1e3dc44 LR: e1e3dc30 CTR: c08d40e0
> >     REGS: dffe3ce0 TRAP: 0300   Tainted: G           O        (6.6.73)
> >     MSR:  00029002 <CE,EE,ME>  CR: 44004402  XER: 00000000
> >     DEAR: 00c011de ESR: 00000000 
> >     GPR00: e1e33154 dffe3dd0 c1870000 00000000 cebe0000 00000000 00000000 00c011ce 
> >     GPR08: 00000001 00000000 00020000 c30a294c c08d40e0 00000000 00000001 00000000 
> >     GPR16: e1ce2668 c9270000 c9269a18 c92664d0 e1ce26dc 00000000 babababa dffe3df4 
> >     GPR24: 00000040 00000000 c9266480 dffe3dec dffe3e04 c9260000 00c011ce c9269a18 
> >     NIP [e1e3dc44] ath12k_dp_rx_process_wbm_err+0x124/0x600 [ath12k]
> >     LR [e1e3dc30] ath12k_dp_rx_process_wbm_err+0x110/0x600 [ath12k]
> >     Call Trace:
> >     [dffe3dd0] [c0ab8e30] 0xc0ab8e30 (unreliable)
> >     [dffe3e80] [e1e33154] ath12k_dp_service_srng+0x314/0x380 [ath12k]
> >     [dffe3ed0] [e1e44540] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
> >     [dffe3f00] [c0674c7c] __napi_poll+0x4c/0x260
> >     [dffe3f30] [c0675328] net_rx_action+0x188/0x340
> >     [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
> >     [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
> >     [c18c7e10] [c12b040c] 0xc12b040c
> >     [c18c7e30] [c003a7d0] irq_exit+0x70/0xa0
> >     [c18c7e40] [c0000c84] ExternalInput+0x144/0x160
> >     --- interrupt: 500 at arch_cpu_idle+0x24/0x50
> >     NIP:  c00071f4 LR: c00071f4 CTR: c000fe14
> >     REGS: c18c7e50 TRAP: 0500   Tainted: G           O        (6.6.73)
> >     MSR:  0002b002 <CE,EE,FP,ME>  CR: 84000402  XER: 00000000
> > 
> >     GPR00: c08cc978 c18c7f40 c1870000 00000005 00000001 40000000 c328becc c12b0530 
> >     GPR08: c12b0530 c000fe14 0098ca91 00154674 24000402 00000000 00000001 00000000 
> >     GPR16: 00000000 00000000 c00119a0 dffee5f0 00000001 00000000 ffffffff c1050254 
> >     GPR24: c12c0000 c0011970 c0011940 c12d0000 00000004 c12b040c c12b0000 00000001 
> >     NIP [c00071f4] arch_cpu_idle+0x24/0x50
> >     LR [c00071f4] arch_cpu_idle+0x24/0x50
> >     --- interrupt: 500
> >     [c18c7f40] [c0a367e0] 0xc0a367e0 (unreliable)
> >     [c18c7f50] [c08cc978] default_idle_call+0x38/0x58
> >     [c18c7f60] [c007b3b0] do_idle+0xf0/0x130
> >     [c18c7f80] [c007b580] cpu_startup_entry+0x30/0x40
> >     [c18c7fa0] [c001325c] start_secondary+0x48c/0x930
> >     [c18c7ff0] [c0002870] __secondary_start+0x90/0xdc
> >     Code: 7fa3eb78 4bfcba59 7c641b79 41c20144 38a10044 7fa3eb78 4bfcdb85 7c651b79 40c2026c 83c10058 2c1e0000 41c202d0 <813e0010> 7c09b000 41c20010 7e84a378
> >     ---[ end trace 0000000000000000 ]---
> > 
> >     Kernel panic - not syncing: Fatal exception
> >     ---[ end Kernel panic - not syncing: Fatal exception ]---
> > 
> > 
> > My fix, as shown in the patch below, is to remove the conversion. But then the
> > member variables `buf_va_lo` and `buf_va_hi` must be `u32`, which is obviously
> > wrong. Alternatively, `desc_va` must be `__le64`, but that is likely also
> > incorrect, because the address is simply dereferenced, and this clearly requires
> > CPU endianness. What I also do not fully understand is who actually fills these
> > addresses and at which stage this happens. I hope you can help clarify this so
> > that I can provide a correct patch for this issue afterward.
> > 
> > 
> 
> hmm, i am not sure here, but can you please try
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 1c82d927d27b..f142759a217b 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1246,7 +1246,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
> 
>                         /* Update descriptor VA in SPT */
>                         rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
> -                       *rx_desc_addr = &rx_descs[j];
> +                       *rx_desc_addr = (struct ath12k_rx_desc_info
> *)cpu_to_le64(&rx_descs[j]);
>                 }
>         }
> 
> @@ -1286,7 +1286,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
>                                 /* Update descriptor VA in SPT */
>                                 tx_desc_addr =
>                                         ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
> -                               *tx_desc_addr = &tx_descs[j];
> +                               *tx_desc_addr = (struct ath12k_tx_desc_info
> *)cpu_to_le64(&tx_descs[j]);
>                         }
>                 }
>                 spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
> 

Hi Baochen,

It actually worked, although the solution isn't entirely clean. Sparse
consequently complains with:

    dp.c:1249:42: warning: cast from restricted __le64
    dp.c:1289:50: warning: cast from restricted __le64

To be honest, I also don't quite understand why the struct pointer has to be in
little endian at this point. The function `ath12k_dp_cc_get_desc_addr_ptr`
returns an offset from the `vaddr` inside the `spt_info` struct, stored as a
`u64`. But dereferencing it suddenly treats it as little endian. Shouldn't
`vaddr` itself perhaps be a `__le64`?


Best regards
Alexander Wilhelm

