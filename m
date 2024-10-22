Return-Path: <linux-wireless+bounces-14310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051E9AA0A7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CA02838F3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4785199EA2;
	Tue, 22 Oct 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="Tsk4jwIb";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="BCrVlr/u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D61199254
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594627; cv=fail; b=NnkSMfsz58pYLT6YzjKtusxhN37u0UUxFlM+4sbcTy/6FeAr7YPOdbYXmidYa/bJr12Ivd9GzDqY9Gv04iKgjC3/kEess0pvoVAAw89GIt3ZPaJ8SqctPwiiGG68FJS9bkQppQkDDwoWpSW0RU1/xqg9TYLr2TyH9WaRgBPGkAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594627; c=relaxed/simple;
	bh=wzW1kbFKYhFkvpDsqw5yBnSF3v1qpUo+2axeNe+JrrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cL5r1p7IbS4ow0ej9GXj/JtxyUsyInV6aG7F9UbpEpAYP8VPH4XxQk/x6LZ/46/M1R7iXLstSp8o6vSuF7EtvjLhSNEYfzjGHnRhb1THhzYEQOzW7w/gUW2UZojHgXnAFQjM6+iFHu1vkmLe1F+ZYvclHZAz16CTrSspJM9drwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=Tsk4jwIb; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=BCrVlr/u; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8NxOE015824;
	Tue, 22 Oct 2024 05:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=b2BgCYcIcCKZi/j01AWsXF/igcZVcEmICfmsKU6yDdQ=; b=Tsk4jwIboEi3
	5P1Tm9wA0zP0lfhl1WmEE2lp5lpY6Du9CTzx3n3IO70u8Cdb8kKu9U8DrcNs8cXU
	dJ76hVWnFHksO5IfYnov5KnRL53D7Fto4N+Jpmv2yqUwM17kuP+Hct4ASThKfk0X
	+3MrNySuKMQEb4gNs6DhYJa9V3jKvmEKJWtyef32fvjxfZkyeNoRRAM7zKPstQ6V
	6Z2xr1uOqHhKe47Zp/lWPsFYRE/rjscxSKagqkKkfQUyld7+D5NOS75QlIKhf0zm
	1BmKmRAhwYb0HCj80jCnJAnprC1y6u6hkwP9NWeutjQmocd7ZYnc5AQvD34AZP7c
	iJbg2Hb8Nw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 42c6qcdc5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 05:15:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGvmqsl8Wud5bMmHhgekcfNci8gvpAecaagiNOn8QRBpg56SZRkHF+yvOcVDWsY72mLvIU/6SoKjngkzzg0fPPDCb3qwkQWTXYshdpZU2/WLADVh8UQzLeCukIWBUJiN53IUNcVn/ETjxccg0uAvrN/z/mbfif5ZQaizHYpRvB0LEhS/M0nE1md0aw6yVPjtRImxmwXIvyNcIVWTSL2OExSKdwrmz+cWFNTpzFQsCNrFcROpjdmrtX9xOKpzUFUl5rcoUzqAdnaCAQsnvseDKxoi7/tac4zDMgygSwRv8OPzBpfLRyGCKaRSclQvrT/v/8tvpBlv7xi0PqvJTkerJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2BgCYcIcCKZi/j01AWsXF/igcZVcEmICfmsKU6yDdQ=;
 b=UPxHcwRtMu8tfBlEIxKWYMncgpr1pAv4bmJkNvdF610SLZwzRsMh0tEaZb+n92McGG+B++l0hksIwNtBev4Bwz7WvJSVSbKuPjIJLrAa2C+qi1TXiDNwmejb+S83M/IcI2tGJJdfO0lT5Z7GBP6mK1Te4ZkiCGTeP4UPsG7y6M03Ry11Cy/xniiFh5NzmcLBi21Y49MCMUue+BSIdeyKQ7ue/jE5sivJNCspsxlaYajLdhVviSbKJIhI+2YelWPh18RpqOsy2vspEgIwsnviv5Af4NLc7NuG1h5gh7V3ZwOvbpZSxrdXpQo1EnR8rsXh3ZAPtmDwBhfrU2oN/qlbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2BgCYcIcCKZi/j01AWsXF/igcZVcEmICfmsKU6yDdQ=;
 b=BCrVlr/u0iSZcPzCbtXpa+Z/TTiTZmXA/bvgvgDEJohUsXbLqBkTVwRRmpRWpXMik7IVaYGdyBN7Mgr7ve/jHrzGWkMLbv2UexJn57jw/QTbzxAejsoW5mUlvytwhLPs3fLmOgCfIODsQh29LZwEtl3fWYe7AG5wXbBYKFfIN/0=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 10:15:30 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 10:15:29 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: kvalo@kernel.org, gregkh@linuxfoundation.org,
        linux-wireless@vger.kernel.org, Yuan Can <yuancan@huawei.com>
Subject: Re: [PATCH] wifi: wfx: Fix error handling in wfx_core_init()
Date: Tue, 22 Oct 2024 12:15:23 +0200
Message-ID: <3950964.R56niFO833@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20241022090453.84679-1-yuancan@huawei.com>
References: <20241022090453.84679-1-yuancan@huawei.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SA1P222CA0061.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::14) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6298eb-0b2a-4ded-d72c-08dcf2827482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Y9hQj5FJ6yECezFHmdsy7GAZ/4tc3P3mPigukudGIDbxZa94PVxvpihZjH?=
 =?iso-8859-1?Q?NSYZ173dpxmKRWyDTls7TkbazmhRxYCS3oypM92nJ8dUbWC4cVsugnuK3A?=
 =?iso-8859-1?Q?dITuKHFQaps4nllCJFdZLEb0jMkYpCf6SSoGzligaZS3JzobxUKpg7v7qn?=
 =?iso-8859-1?Q?Dbb6ewOKlIfjM8jXSmNuvoONlyOCqYsKioWMH6/lWDUGuEqhcrUb0zS7C6?=
 =?iso-8859-1?Q?n4VA5pskd/Fa1NnVhnL5eZ1Z2nsxLn+FwEfKqHq69tqLfjhqiEBY07y3tY?=
 =?iso-8859-1?Q?pvwS25zIKJvbbYf2stWa0DFmGsQu+1rkpD8Ha9ndbef/tExvKDsBweHK4X?=
 =?iso-8859-1?Q?HEH/Z7t+ex44eJFnNjaR3tl6S0rZD0BMLsmBlWFa5k3ANwPH/Xy+Uy9Bx/?=
 =?iso-8859-1?Q?Id/it8rytaelzgcM0hlPyaqkQns3gN4ppSdjUPm9zWK37O2SnE67IDd1Ew?=
 =?iso-8859-1?Q?JPYvJ3pZnP4vbtibAM+cJvcHSgzSAB6efK9x7nkDMrqVZadnACm4hRne4S?=
 =?iso-8859-1?Q?ecTEzxq2qJL7LU3EpUYgIKT9nvB12BrBtFCZvYMOQrgzUq7m1ER3EuisXh?=
 =?iso-8859-1?Q?KvYOVHHvbzA2n8xxmlSIIMH2ovQC4nlhh3mlNk9IU4SWhZdje83wymDPcO?=
 =?iso-8859-1?Q?2f4DF16ZxYQ/NBjYJsT0ewayeLtaWdCUek/SOxbjU8JncfI6R49//uIIqx?=
 =?iso-8859-1?Q?ys2pNXmpn7MPgO6uTNKt9/RURsCrkAaWDBV4NDXBmt2PJoT96MwUKk43q9?=
 =?iso-8859-1?Q?tNUI8yNEkKvc9nhhjKnIERMVklt1JSzgwoFr2lmXvN42BB6Rn/OQI9QrH4?=
 =?iso-8859-1?Q?yiCeojqS216tutUdzpoSDh8Hy37tYT5Msqt7RgfSVAxxJk16Wc+tbUmjyi?=
 =?iso-8859-1?Q?jU5FcLwr/v8oDM9ao7XHEKDRoA+/bmihdbYWNaTsmsq0CkgrEkqyHmWWAc?=
 =?iso-8859-1?Q?Lvbs/PNO18T9qdJVuiW8lcnvwUUJnDgiOlluVxZSa2CE5LRED54PmLEhL/?=
 =?iso-8859-1?Q?CiCAObmlA0UL/WsPuKthw8GwYArtJX2bdQ24dtcoRdDFGVlixGsMgl4LlB?=
 =?iso-8859-1?Q?GBzkS34P6mlIRFODWNlB4qTPLW+kfRf4qxYFD/+Slt/vS7PeDt7nakMEtj?=
 =?iso-8859-1?Q?qP4WReOAem69ZePR9wTCGjF//i6QUSXHE3l9FP6mH5ZVmWcwUyxsNuoqJi?=
 =?iso-8859-1?Q?3KZ0IhVkNNUA8EX5/RsUViCsS//NpA3DDxOwaL8kZLnJKF/huRh/oe9fi7?=
 =?iso-8859-1?Q?VzyoYvYbOkFumx8eFQl8bsHQagl1VSMUyZU4dO3fMrE/Gt1JuaZtrvjLoB?=
 =?iso-8859-1?Q?AbtBhRq8ANBw803XHI8knoHajrUzhCPQymtE98VDzqnO3Y9Nu66cK/BUr6?=
 =?iso-8859-1?Q?NAhQM9+H8+Wr9nWumtf3R157H5beEn6XUblwXlQwyQm7yXDAJPYss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HxcNVc94L0SmedjcepNi0roblz4eZQj18NMLRf3sP99RgUiNA0ljUQeIgp?=
 =?iso-8859-1?Q?dtAmH1NP6qhO+y7n30ljeSM7Hfjak2a8vzr2BI9KZfBQT4Rcuwp5tJFarD?=
 =?iso-8859-1?Q?WKOhjxYNzTbvCZSL6EjNet5m0FmP338Raf9D1rbxrY+LRjOkpwMBXgae4b?=
 =?iso-8859-1?Q?XyIBlpCwvX5lL1TUc3EshqT/v65ogtjO7QwUbrvzfBOtECBFFDamB19EUL?=
 =?iso-8859-1?Q?Ts+9H3UF4/ucb7WhKEWqOYAu+ZglbQEG0FWZ6tVm1IFWHyW4KMbduJ1Cj3?=
 =?iso-8859-1?Q?eFVvvmjbgbea9uBPQ9rii1kMC8qOFJ8aD8sUmtsO8X6PnCDc0Lk0cxc/PE?=
 =?iso-8859-1?Q?pugGmcZtEZwsNqXCspeY+PVPsXO0q2k5YzU8Xtn/znMIsRUPsCbxe+rrt8?=
 =?iso-8859-1?Q?eyOHg7NBFaJP5XsFrymQUsN+W7pXJWBwRBLoB81+nAyGbksA46aZuvv/bd?=
 =?iso-8859-1?Q?OHd7tqRyatb8f/XeMUmUa3NEa1ckZNRBhp6IWZObBh6Uz8VRIjL3JzztaA?=
 =?iso-8859-1?Q?jBYGoYolbmXxAHqUWv8FJnID1UqVuLSWpuToiUZby+4iPTl3ZTOL1i2/68?=
 =?iso-8859-1?Q?OrsL/w2LfX4ODvgfGmGSjV2SFDaGJLCjztm54+4V4SnUQzEt6/D3ZYHXoc?=
 =?iso-8859-1?Q?DnmL47qTSYz0d+L/eEKC0HFnDC8tOP6GCZlME6hilmImQ6OJEuOfG9u2IZ?=
 =?iso-8859-1?Q?6LtIfHN5guCd5Fu+g7Emp4ej1AAwr4EXJSnuTDczUA0PMBHQXAArfb9AMD?=
 =?iso-8859-1?Q?ioA8/Y1EipzxEacVyT7+HxgSFOv6ZU9MxdRBJJk732yTZtlK4ROsGIcdIj?=
 =?iso-8859-1?Q?dpLOnLjVMK+E+JFMzvp0DZvpau72G3RueEaEEFKRTQobtlKQTEAZgwuWOs?=
 =?iso-8859-1?Q?BEsSRQF8WGlx4vVdRxGWAqWa/zItMHYURDIR5FITMJNpPttt0INkXxZ79I?=
 =?iso-8859-1?Q?7XDyONHu4ut6tDH0Pc+tw8RIsGSj5+r51kIDlZpBH5HdwUTV/4hbBo39om?=
 =?iso-8859-1?Q?Div2K/BUN8ttmuwA1KuswlvoadTjyh9QPQs3tG49KGw6lOp03pzbKwesfr?=
 =?iso-8859-1?Q?e20Fb7nBqOwTaKYWSbjE3Q+n5DMDsXASlIt6AAv2GDLFb1xXHOGvoYRDUF?=
 =?iso-8859-1?Q?0nhUYT8p/fdV17eSJt7+1Uj4eXaFlR5m0KL3pHB6zXW1advLh7BAiY3cKp?=
 =?iso-8859-1?Q?c74L9t7ZsbIiKJ1H8vE9mzCBi7YQgQGCGU/hiUUo1TCoyVFM16fJ9UOQvZ?=
 =?iso-8859-1?Q?itRI+RLpFiPzHImjZTUCzm6dv6kALR6gXN4nhwQ5NvyD4DETwP6pCMzOi9?=
 =?iso-8859-1?Q?yNMupHbDDhYcJi7/VhRz9SmhK/LsErHr55D3qczpl9ZgOlbKnXbYsfxGBW?=
 =?iso-8859-1?Q?zyuL5FMf3pVhVI5+kzZQgDZofyt1s2ld98WmCBndTlynx4+YK6cdlxiFIR?=
 =?iso-8859-1?Q?NwRmS8XJ1rTLMmrISmuR5zDSIr2l2ekG8a54wfWkdewtR2npYColRfsmYT?=
 =?iso-8859-1?Q?aPHY8/524YRbe43wGwOmRqdEYQLucONEA1w80c6QdXXYiwINElSTScxM1b?=
 =?iso-8859-1?Q?lccdSLOzLQ8qcMk4csDJYavmZY8E1L68V8N4eFpaG0c8/d5mtT1ixGEXV4?=
 =?iso-8859-1?Q?kFJMY7dMJV28X9b91xGNgD9GO5p9dW8a1u?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6298eb-0b2a-4ded-d72c-08dcf2827482
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:15:29.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCXov25pZ4yb7YoLkSyOKBeKQ207grPdJHIgJtZitj32b7dpjBfv4wh+zpeeBJUhh8NFBXow2w7CYiyEsidnow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-Proofpoint-GUID: hgHU0oII_ZCqmAyMwYn3oerD0GbSy4-h
X-Proofpoint-ORIG-GUID: hgHU0oII_ZCqmAyMwYn3oerD0GbSy4-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_09,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2409260000
 definitions=main-2410220066

On Tuesday 22 October 2024 11:04:53 CEST Yuan Can wrote:
> The wfx_core_init() returns without checking the retval from
> sdio_register_driver().
> If the sdio_register_driver() failed, the module failed to install,
> leaving the wfx_spi_driver not unregistered.
>=20
> Fixes: a7a91ca5a23d ("staging: wfx: add infrastructure for new driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/net/wireless/silabs/wfx/main.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index e7198520bdff..64441c8bc460 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -480,10 +480,23 @@ static int __init wfx_core_init(void)
>  {
>         int ret =3D 0;
>=20
> -       if (IS_ENABLED(CONFIG_SPI))
> +       if (IS_ENABLED(CONFIG_SPI)) {
>                 ret =3D spi_register_driver(&wfx_spi_driver);
> -       if (IS_ENABLED(CONFIG_MMC) && !ret)
> +               if (ret)
> +                       goto out;
> +       }
> +       if (IS_ENABLED(CONFIG_MMC)) {
>                 ret =3D sdio_register_driver(&wfx_sdio_driver);
> +               if (ret)
> +                       goto unregister_spi;
> +       }
> +
> +       return 0;
> +
> +unregister_spi:
> +       if (IS_ENABLED(CONFIG_SPI))
> +               spi_unregister_driver(&wfx_spi_driver);
> +out:
>         return ret;
>  }
>  module_init(wfx_core_init);


Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller



