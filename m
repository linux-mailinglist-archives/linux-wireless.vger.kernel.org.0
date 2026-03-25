Return-Path: <linux-wireless+bounces-33843-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IQhK6fgw2kgugQAu9opvQ
	(envelope-from <linux-wireless+bounces-33843-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:18:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5F325928
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F5D30021F3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD91CEAA3;
	Wed, 25 Mar 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="ry1yO7DP";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="0yf6vJDO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9F337B97;
	Wed, 25 Mar 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443747; cv=fail; b=ohMWXhsbfnn7E8RanWRjNnNliVQejLVG3E+tendMk9Nb2TteBu9VzgtnSHIr7K6Jy3X0v06hZKlIabOPf5H87A9Vjj8+4bAgaRqovPZAChq9fBeBONxRh4ntKiNVGHT0PsnUY0EvQRRcda9uqT5Qej3A9PK66f0IoQNpJmZvVBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443747; c=relaxed/simple;
	bh=P56+bsfukgEdfmHriqGH+5MEbSH0ex/pz8Ez3VwG+VY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=PT9huvyw5VXQJozv4N02gi7QCjsfit6X8+ki4pyZYVspjIh31kQociiyAtJGYy6SpKvqzkVcQFA5V7XDduoX94G1wFPT10jPStj4h65xbCXaVmE8vF6wLtaQ7jJg5Fo/x3R6waDmQHcAL1ld2XLNcGhG1fNywbKyCKWC7zMobcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=ry1yO7DP; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=0yf6vJDO; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P5Z1VM1053938;
	Wed, 25 Mar 2026 14:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=YQNwzfj5WlNvKefuBDaNKv
	SFFz/Ful/gKD2UrrMGEEs=; b=ry1yO7DP12NYDox2ayjCk5IWbtrh+OuTcrxpKI
	5CkPY1DGmZB8KJ/jqfW9SJMYdHfkBtX143fsupIRrrsUAVDZryJZaT9Rdw7t8uWp
	w3Jth+giSDcEYlFDgwzOL0W16/a6ZJPE+pvhysJeHnyaHvz293KVHpZOaOIZKBpj
	PloIlyYy5P8lsa/lCMXm+K9GvujmoEFA6mrnoXpgKpUZAZ0DtCloP1BheOc0mI4U
	PoaUEO2WbCxK5sqQFj+GGd1SoX+wVSObx/IR9Kr5RtROx4pyDQFCPB7fn1StpsQA
	1JdU2S2jXlne94S80hDknLZLDIjJ50GbGQaDpY3Y9si3IHsg==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023125.outbound.protection.outlook.com [40.107.159.125])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4d1gjdc8w9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 14:01:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNlK4Dr6AcqsCGxrzeJz+YYd+tpNuo+gGyylQeILGnIyDHawZ4rxz/OisCGUpm9qIaRYxnxaLtKeLnv+lPCfKRAG2JasgdRUlmb3xUiepB1uocf2NTx08f8DpFJco67HklWvnxAGFn4yiYqBmdIXTQ5ERaqylitzdzDi3GlhMjuuATVxDMsUvFcTGe6J54VklbeBD0SNy+ml93zodkidNhPLerS0VHOaNmxPM+pUhH0cO33sYUX9ppQZFEJICBRrL0cCmrhIYBQlkkJLOY6JF6d5rN3+ZMPl1qvZwj/bgcHiLFBFS4rY0d0bNTNG+PldBiB0DR4ukdbBzNzjzMsV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQNwzfj5WlNvKefuBDaNKvSFFz/Ful/gKD2UrrMGEEs=;
 b=ZTK+9+gh7eUayYG1gODWP8Dxu6wOUsYlklxpOsp5ixrITQxBNyRNIZPjpqSQ6+Jfq4OCqfZG4hTy0zxNIWCmKMP5AMmYE1yIZ1dJqVvbpP92sYr1jYPVk5LT/2jI09U6oUCCp2fEZwqLuUj3dZegLuFB5OclGU4XFJ4r88PkIvlQ0rOsZ4l9rP22ICKuWI5kKfeGllBt/mgWYU3AA9jCqgIGo5UPHFAEoLiny2uuc+ZtBTQUfRR/JDKsvm83XlFvsYfy5qs9jTD+SdV1OMLDB7SEQvUKnqN2BjrKznJki7poqqJhlKzyR1ET5jUE91+SJgPz+a0Xx3erhWH6sth0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQNwzfj5WlNvKefuBDaNKvSFFz/Ful/gKD2UrrMGEEs=;
 b=0yf6vJDOY2jgrphoyTjGo/mNg0keRaxFjO7J3Yf/FSTG/vc+M9bON011tEmneOZlfwpqAkIqcUe/xnzgCkVFPIhv4G81qlXqN4JK4Q+VFnFtq/7WAH4hsSQP5cMqwjM1EfY2CDlhxHeIgMJXIMYs7u3ljoCU/5dBaoTjyN7TLng=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DB9P192MB1986.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 13:01:56 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 13:01:55 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Wed, 25 Mar 2026 14:01:48 +0100
Subject: [PATCH] wifi: ath12k: fix SPT vaddr handling on big endian systems
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-fix-rx-tx-description-virtual-address-v1-1-f7ae6efc79aa@westermo.com>
X-B4-Tracking: v=1; b=H4sIALvcw2kC/x2NQQqDQAwAvyI5N7BZcYv9SulhcaMGipVkKwvi3
 xt6nMPMnGCswgaP7gTlQ0w+mwPdOpjWvC2MUpwhhphCHwecpaE2rA0L26SyVzfwEK3f/MZcirI
 ZjjQPRGkM6U7grV3Zxf/n+bquHwJTdIR3AAAA
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3PEPF000167EF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::66a) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DB9P192MB1986:EE_
X-MS-Office365-Filtering-Correlation-Id: b0343321-2ec6-4bae-9923-08de8a6eb0af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u5U8G9ZAo+vHptrz0eiXg6DBwduc3QR99//xFwcyCxULxXmfCE2+OJJCRuu4sN+3Cg8aO4sYEACEXd8Bgvy2vkgxF2EQHxFb7jVx/Ol9GBU9mx1U1Ce+HbCPY+89bFwE7opHYvCpLMby5a9+7qapV5ui8YAqwUpjjcxg0PioHDLGJ5sxK3Ojnvdv6xJnTCFEMCM/NINGM9Iz+1D4JrvqsfAgcnzadGfjQKaPbxORFua4uGetrhn3h04s2mkSFaB4uh74LPiMHb2yzY3xykZN1OFSMSoBroSpNQe3oUCGe3ipbM1ANQgv1vRqTDZQNvxzl0FGowc2t3nbmkdup1BNXQ4F5jikaziqavbauqvMHa5nR30f6Z9El8xyDGPQ6vKaAOHud18UE/6HDF9axXASLgwqzSFPt+hwQ+bnZFuboD2UnTlbI5asFYNAIcrPzri8+GuMt4yIbqCTbsa5o5rqtekSTznlaqvEtRWk9AaJMtBFSwMAJEX1e/dx06oo5iVlyz9I9ByXJZtlFosQcqTIg1NXP0meVCHPQuYgTKBfU/VCu38UrueUpelZAEQHODTyo3zR1MOCfUGeD8moWVhNSb1GOnp9trDJLis6kXD5Gk9y+a46Q5nmsS+omXkdit+u+ANEIb3/vjAVdvKFw+VlGOqN8cgmWOH5z0dr4Iq3T73JdbeS1/MBFvnt9exzE2GnR7X8p4mRfJzSaUlAbK45F+kY4CdD2b0WVxq0CSOQ5KU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cndOTVdjL1JDMk83K1dEdU41T2daWnRTNmJ4dXNpUzlaRkVDWkp2UGd6R0RS?=
 =?utf-8?B?QlJPZ1AyNURXUTl6WHFhVk5pYS8vU0xPbVZVY0M4U1psQzFsNkdRRU01UVJZ?=
 =?utf-8?B?Y2lBcXE1QkY5NGRoQlNQWk9YMjh3UzNVUVpQNzUyYmh1c3hDWXM1RWdNT3Vk?=
 =?utf-8?B?ODZYTVFsd0h2aUtOTTB3Y0o0bm9aakxrYS9xT01DYUFtU1Y0d3Z3RGJFQnBz?=
 =?utf-8?B?bnlvcEUrczJvcEhIN0tSVllNTURJeGZYOUlVbUQvelJ5UjRRc3ZIdmU0L1l0?=
 =?utf-8?B?cUJTQ1ZJcUV4K2lpZ2xWNzlDSjI3WU8vZTNjT3A0SWZ3SUlTZllWZFJvaDZN?=
 =?utf-8?B?eDBvUGlIblFKLzNKUVlTd0NNMFJPT0ZLL0FpSnVhR3lXN2paQzE2WndnN1p6?=
 =?utf-8?B?cUFMNDVXYk45bVd3SWd6MUlEVHY5U0o3TC9lNFJKQ05xOUtlOUhYK0s3VDNo?=
 =?utf-8?B?RW9SdVN2c2hYVjlyR2Zndkpqb25nM1dJdmVxU0xSVlVpMkFwTC8wbGVzajFF?=
 =?utf-8?B?UjMwdHl2NWlWRngxNVZCUjBkcjVkM3poY29jZWhCZWtEVWRua0JqekFQR3dr?=
 =?utf-8?B?R0U2K3lWRmMrcmp3VXU2aFFIZ1RIWFQ4WGxqc0hQU0ZCcUIrYklRUWczMHN4?=
 =?utf-8?B?Tk5icVFLdk1HdER6WWtTbE05UWwrWDBBZzR0cEVzOW4wanJkN2FRQ2NTVjc3?=
 =?utf-8?B?QXEyT3dFclp2NkRFRXJjK1BnM2RmTi81K0czUUI3UUdETkd4SWFYYncxcnVM?=
 =?utf-8?B?ZnI1MEVIcmF1VXlRajNVRHRaU3hrNG5uQldyaXgwR0lTZTNPUk9xN1hvNWRn?=
 =?utf-8?B?dXZEWm4vZnI4UTdkZk9wa1NRT3RWWHlYRVZpOHM2andkays4WTJOTm83QzlL?=
 =?utf-8?B?amxEYnFhaHBRU25Ubm5vUm5vSitvTHUwNTdWSFprT2tKK2NIODlLaG5QUXRW?=
 =?utf-8?B?RThQMVZzR3d2akE4YWd2SGlDYnFybXFlZkwwc0lKa0l4T2FpSHhORnRkRzQx?=
 =?utf-8?B?dlU0eTZ4ZUh0RGEwK0g5dlhINlJKUG5pRlkwcVU4cUhWMS9kelpOMmxBaWhF?=
 =?utf-8?B?bUFwb0VhZ294WUNTTzNQZ2hQWXR6WnJPR0NyT25WakxrQ1IwZ2JBUE00eFZY?=
 =?utf-8?B?Y0FhSlA1YzBBQmp0QUd2dHlBQ0crK3dlOVJ3eFZ2cHp4aktnYmNhaDBMUjE3?=
 =?utf-8?B?K3M0Q2ZtNFUwalNJMFFlU3c3QTNtb2RQb0N3RHVKVXVBRUM0RkZqSDRhYklj?=
 =?utf-8?B?d3ZtYVFyYXJsSzAyL2ZXY3RwTnZqZTBQWGhLZmlhY0kreVBIQUpqVldSU2xI?=
 =?utf-8?B?ZE4rMlN1U2ZIdWdOK2E5NFlWTitGamdGVlNXeVI5UTdKWUhPMXRlRkFPRFZ3?=
 =?utf-8?B?RDFlOHBvb0tyQ2ZHTTNZR3VyMTBaZjdpemJ5ZUhjNzZXUjVyVUR5OG5HWWNQ?=
 =?utf-8?B?Y0hyZjRrNmVhdXlwVXkxMVd3SjZKUzNTbTZwLzljalVQZEUzUG51WHMxVUdF?=
 =?utf-8?B?NnlJUUFqZE1YUFlmQjAydjZGMXNTV0kwVlFrY24yRGM5djZ2NEZwV3JFSWlr?=
 =?utf-8?B?azdKb2pUN05Ec2U0R045VGRiaHZyOUNicVBPY3VOUEloQnpkc1RoWmQ3OXIy?=
 =?utf-8?B?eS9XNFNheU5vdjZzYW9hL3A4a0pzSE5VQTVVQkpMdkNaSnZVaXplbGFxQmlH?=
 =?utf-8?B?M1lJODVqT3RjT3NUeldlUGEzeG5teDRKTmt2b29IS2UwMW9JN3Rhd1Z0ZWtr?=
 =?utf-8?B?MmZhckxFZStkSEcwcDN1dXcyV25nZ25uVFgwaHdUZ3E0MnFCRDVRRWpQTHRG?=
 =?utf-8?B?QldSVTJWVk5zdzZRNUgwaXhnMW5MbmNvVTBlVVJuNEV5d2ptSkFyWElNcVdw?=
 =?utf-8?B?Z1ZyYXdURnJGaFJEeGw0aXBKMWVNc1dVL3JES2lQK2lOdUdVNG5LblEzTEJS?=
 =?utf-8?B?TUl0c3ZqUnFjeE51U0ZrRTdjZldxUXJYRFhBSnNLZnR1YXZVQ2Q1THBnaXky?=
 =?utf-8?B?TU9hazRjSVordTAvWklDbDZKckhHNG1QanVjcWN6YlpyUVdJL2hwdklya1Uw?=
 =?utf-8?B?a2dUR1MwbE5iVlVKS2N2M1p0OWhhbmJqdlJQYWFqRnNlc3JvT1VKZTJpaE9v?=
 =?utf-8?B?Y2tKeFBSWWdENzN4ay9tcHIrZE1OdnNlNlBFVncvS2dQbjFybEc3QTRNd044?=
 =?utf-8?B?L0prN04zaGNLZVU4RTcyYTRXQ2JxTGg3aUVRWlhNVXpUeU1DVW1vYXZMalNi?=
 =?utf-8?B?SUdIZjI1alk1RHFIOGZ5bjAyNGFyRi8yL0E2RmRkdEx0VmIyZmZHTml2RXdB?=
 =?utf-8?B?Tnczdk00MS8yb3h0RVRaSVhkYWdNYlh5RlFVdWVFVzY5dndZNVZ5dz09?=
X-Exchange-RoutingPolicyChecked:
	kEHW3IkfGBTyWOEZBDBP110DIo8+GHHtyfr1QHozYGdhfX5eDj9zmqw+PnbiKH4ym24RE1iJXRgvrulN9BFNSqn7VSHWDsb1bVRGyIfqFQEen8Wz5awD12GdC++tFGrgblnXcdXCU9LN4jmTvgCqeFZyMddwHnjudmh3oLXjKdNitSUq4OMutPJ+G7qz2g0PVRRrJFw0ZuLFwphfYg47w7B7oiVg4xD87ranWIkiePUe7rxtqwsybH3wnY1NFGQSuDvssvbS5rpOyLuUr3VDA/XetXl3EbqHN7Q/AAM9xTq/5jvWvEosbC3LsgHYabG2KfYSNnjbvnCbn/RXCBVM1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lgDOsKaKaw8TYfBiGjXmzVfXhDz5Oy5x79MDZ3w5Rd4cNoG7pNRhMbZr+ZWTFakpnHm0r2P5drjQmX7OxGx4Exb9sBMoj9m+cDEcVDt8MxS7H2aUwyvQx0khXoyuIfGyj+Fzldjs5CjVW74XbjPXNsyf0+PtxdExvmKmwWIMAWD2KUt4/QaEE1JIXDKs31Szv6Wkfsodt9c2CKoA8selFs4oJUorqBvAuq2HxbZy7bMlf8Dt3jZ17Rx9kgToBmZM9EhNdwbChEoZtxzEBbf4+9UtT7YXf99/v0HDxkhFeiaNu6qxElJtXRFeAWQqc/RGrw/xH+VnWzX9E/ewHV+QHr8kq4G+/cjSoI7deX3LunO3yATTOEiKFdqlVp0jl8wE3G+TzebAsGTny8ntXXtYhFXryjGFzPzD7TbLEXwSMnoZu9ngnfz5UjzU3+7BHHOGHH3Xs5xVhZY/6a2IhupUE1Cudv0SZXDeIoAYoD3XJ9gWoU4nkeEBVLqVQs+EU83v7WkWc6Ow77PJrwV19EfIjYqps5OVGirpRGMB+jJoH0eTTcYL/oeFOX6OktKhKG/f+3oW6D8NdgHWikEYdiR6Okhu+Tf5CNKOQuaEnsHTgobHb9WjwbQr7+4W4Jle4gy4
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0343321-2ec6-4bae-9923-08de8a6eb0af
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:01:54.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V47msKf8FYyM0j6vbCpffqC2F7CLaWUhfHNzHGJzprW0uJm0deDfh5F+QpgCA1F61igwo5s8Rv5XMOf2XSA1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1986
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
X-OrganizationHeadersPreserved: DB9P192MB1986.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5MyBTYWx0ZWRfXzMfAWSa9Sqpd
 CnQh2mOSAh+9toyzeqLbrWJbTsHIii0FQNiB9u6EudEA8Xd27H+e21i5s55v5XSRGMQu8Za9KFf
 TEom8XBSaqfnLDhWqQGr2WXRhGGkQwRd3V197MzjSiHLWNPIbaENc1qUX8wf6zYjBblTv0YVChW
 30UpXOkI+A/cSSUTAck0ITdghd/E0aXUu1QrIK/UT3FbaC35JZF8Voc0ImrH9+lJQQGfMfhHJCe
 1pR0l+pD732B4BFUkzgv16HTRoReyGERdZmAeLO3J+E9S9udYiOB1LcMcfUHZAa6w3jeC9y2J3I
 MfrYD0x47ADAArCl9jIFdAE08hZ0IKLxDPYEBIIY8EsOLhJ1r5rSL8vxI9p4me5yMV/1jGlcD73
 fgfYtJoRmnYO8ySkZPlIPriepgiPMv7zZMk76hWZv06/HDqZlT5QdnJc7Y+RImvVmmJSA19ctFb
 LRzPEENOWds2J54aHcw==
X-Authority-Analysis: v=2.4 cv=G6YR0tk5 c=1 sm=1 tr=0 ts=69c3dcc6 cx=c_pps
 a=WXeEQXMksgkumZV83Sx8Mg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=6etL3lIvvOaedaUTNCsA:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: cduTFSahI45o9r3q0kX8B_9o9nqyXV3H
X-Proofpoint-ORIG-GUID: cduTFSahI45o9r3q0kX8B_9o9nqyXV3H
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33843-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,westermo.com:dkim,westermo.com:email,westermo.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 20D5F325928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SPT pages store descriptor addresses in their vaddr field as little endian
64 bit values. Treating these entries as native pointers produces invalid
addresses on big endian systems.

Convert vaddr to __le64 and update all access paths. Write descriptor
addresses as endian annotated 64 bit values and load them by converting
back to native pointers. Return __le64* instead of void* from the SPT
lookup and translate the stored value in the descriptor getters.

This ensures correct and consistent handling of descriptor addresses on big
endian systems, while little endian systems remain unaffected.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 26 ++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/dp.h |  2 +-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1c82d927d27b..2076ae65e9e7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1149,8 +1149,8 @@ static u32 ath12k_dp_cc_cookie_gen(u16 ppt_idx, u16 spt_idx)
 	return (u32)ppt_idx << ATH12K_CC_PPT_SHIFT | spt_idx;
 }
 
-static void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
-					    u16 ppt_idx, u16 spt_idx)
+static __le64 *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
+					      u16 ppt_idx, u16 spt_idx)
 {
 	return dp->spt_info[ppt_idx].vaddr + spt_idx;
 }
@@ -1158,8 +1158,9 @@ static void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
 struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 						  u32 cookie)
 {
-	struct ath12k_rx_desc_info **desc_addr_ptr;
 	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
+	__le64 *desc_addr_ptr;
+	uintptr_t desc_addr;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
@@ -1174,16 +1175,18 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 
 	ppt_idx = ppt_idx - dp->rx_ppt_base;
 	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, spt_idx);
+	desc_addr = (uintptr_t)le64_to_cpu(*desc_addr_ptr);
 
-	return *desc_addr_ptr;
+	return (struct ath12k_rx_desc_info *)desc_addr;
 }
 EXPORT_SYMBOL(ath12k_dp_get_rx_desc);
 
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 						  u32 cookie)
 {
-	struct ath12k_tx_desc_info **desc_addr_ptr;
 	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
+	__le64 *desc_addr_ptr;
+	uintptr_t desc_addr;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
@@ -1198,19 +1201,22 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 		return NULL;
 
 	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, spt_idx);
+	desc_addr = (uintptr_t)le64_to_cpu(*desc_addr_ptr);
 
-	return *desc_addr_ptr;
+	return (struct ath12k_tx_desc_info *)desc_addr;
 }
 EXPORT_SYMBOL(ath12k_dp_get_tx_desc);
 
 static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	struct ath12k_rx_desc_info *rx_descs, **rx_desc_addr;
-	struct ath12k_tx_desc_info *tx_descs, **tx_desc_addr;
+	struct ath12k_rx_desc_info *rx_descs;
+	struct ath12k_tx_desc_info *tx_descs;
 	u32 num_rx_spt_pages = ATH12K_NUM_RX_SPT_PAGES(ab);
 	u32 i, j, pool_id, tx_spt_page;
 	u32 ppt_idx, cookie_ppt_idx;
+	__le64 *rx_desc_addr;
+	__le64 *tx_desc_addr;
 
 	spin_lock_bh(&dp->rx_desc_lock);
 
@@ -1246,7 +1252,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 
 			/* Update descriptor VA in SPT */
 			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
-			*rx_desc_addr = &rx_descs[j];
+			*rx_desc_addr = cpu_to_le64((u64)(uintptr_t)&rx_descs[j]);
 		}
 	}
 
@@ -1286,7 +1292,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 				/* Update descriptor VA in SPT */
 				tx_desc_addr =
 					ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
-				*tx_desc_addr = &tx_descs[j];
+				*tx_desc_addr = cpu_to_le64((u64)(uintptr_t)&tx_descs[j]);
 			}
 		}
 		spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..0d7fc2aea241 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -357,7 +357,7 @@ struct ath12k_tx_desc_params {
 
 struct ath12k_spt_info {
 	dma_addr_t paddr;
-	u64 *vaddr;
+	__le64 *vaddr;
 };
 
 struct ath12k_reo_queue_ref {

---
base-commit: 988707e4b5a73aa78f2fa260727c36fe725fa816
change-id: 20260325-fix-rx-tx-description-virtual-address-91f511690671

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


