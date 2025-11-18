Return-Path: <linux-wireless+bounces-29086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A798FC689FB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AAEB32A3EC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6192F2609;
	Tue, 18 Nov 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="fHQVnVWW";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="xPqp2+HY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252302D5C6E;
	Tue, 18 Nov 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459212; cv=fail; b=JsEnKnfLGeUdnU2RAtWVXHM43ayxvEzlBpXF60hNbqqRLQfSY70V4caiLM8y41DNzWQ3ivC/gRy6gj2Y94uSg5/xmeWvyGF5hvtS3xLmPT/GX9y7/XpJS5icv2Agd4341VFg63efO94qJwIY2L5NEhq2pEwKpcYpUup3niUk6pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459212; c=relaxed/simple;
	bh=i9zAIGieELJHpGG296xZgmInwmGcjSVXF6wNkb4yiKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qCQNqXACcvNMx863Z6LiDIPhfI7ti6/DSUW857aOT0u1c1nxsvyw3Pqv/x096m16EAjfx2ounMD4h4tnuwWqzlyTJozyPmbKJcrBCt9vcHnIwgMvWyteJGzE9jeVeU884TN23TidqE/RSFOStt1pasQkTM/62ibp1zpC+kZOyGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=fHQVnVWW; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=xPqp2+HY; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6KBOp1492802;
	Tue, 18 Nov 2025 10:46:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=A8Yzzp1FW3PVrPfmnj5d3yVr
	LWD+bemQ7F+kn3KWPog=; b=fHQVnVWW4nM9pg65fnJfrQFWvxttrv5eprR2myS1
	1o31+qS7mU3xi/zLy1l6DUBrQnTdJ7ns43M73ejKHOwlfHfliuzpUYA/Y3aw51oB
	nF3kfBtrTXffk9VLW7WHdxDnZpj5+KTSeiecWUyByZhOhUeV5chqbXtRt8wuQQ0U
	d9U79P1QB2G5abFyMsX6P+1B/W0Jly5iBE1YH6ECTH9NMOXQTrByctE1t34p0qMc
	NO0bhkQ2X330RVfFlq/9p2KLbPQWyWZd7WeOXBkG9XSJqjOwG/YJ9RiPYiaQSSPl
	5ngWqKDaeijxFyXtPc0nYGFb6UdTZImg5UKVO/6cALkJaw==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023076.outbound.protection.outlook.com [52.101.83.76])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4aeed52sad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 10:46:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sde6PbwZPH1LrO7cxLj+3MCGXVwvLw+DqBgR3irJLjlcSHYqCy/fYjR1ymqS5S2z7s4lK58OOMCkA9dSbaY6Ykull1oqVhZd6F/zQ9x3UqnyAbzTpvwhGXZdIHfNH3eWXCYp1y2fG0PrtMlDEuzLH3BJMMKhNA4z0DFZjC4V0wUS+Pz9IY8QHDAwdypVMttdw7WOOrZjLUgoZwOjxnQpvypbTIfuj490xK89M+uC4PkCnWenkTP4icu6rO1TeDimTy4o6UHyrPuuezkBBD95rjLOSw2mX6qlMRYHhyLW4PksAGJ85VjaRkAL2QJ+4J+drNo3YYXtfh7zkBQ7VSI3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8Yzzp1FW3PVrPfmnj5d3yVrLWD+bemQ7F+kn3KWPog=;
 b=gO/puz8nt8ztlego8RfA4XOY1D8JsGFixqpx19+Q99P/Q051D52O0hmB19VMorXfMOeqVRsyBCvkg0TjbB3iBs/RCMejpxU13r67+Suc+HxhtNt/+OgIdpaXlFdlHKhtr5BZG06ku2oHC9+4Io5cMFA2S2a8PYeCrG8t49X6/WXrVmBtaPTamqn1iabtrHWd9Hrc/aVNYl0eLJE4Xd1R22RIVEGM88bVP3ejdCSSDxUH6c9KhAZWZphRaT8BDeg24Mx19qjDQ/3GNoIdcTQms3sW84qIz38CmfJ5Q1uKV/5NRkJCy8Yn0QSCk9Au6uw5cqFgXzD7m2PtWMuzxDXeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8Yzzp1FW3PVrPfmnj5d3yVrLWD+bemQ7F+kn3KWPog=;
 b=xPqp2+HYIehG9KsJKwUTVrvlJD4UreRpb6cnqnqRq8HpNDdbAaboH54wssqZcjIggWS/VArFpxd3N8HACvv0Mw21uHt0A7xSfIdEvwPVL1aAGmU2Nh0UNGfnILZ2U4i/m27PtvbpgtXW0+7XIddkT/2nBFC4blWxPOS7wndQ5CQ=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by GV2P192MB1966.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 09:46:25 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 09:46:25 +0000
Date: Tue, 18 Nov 2025 10:46:19 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
Message-ID: <aRxAa8OYCZqEx7Da@FUE-ALEWI-WINX>
References: <20251118072123.19355-1-alexander.wilhelm@westermo.com>
 <5a308d21-d463-4d6f-b5d3-95a0c2ede2c1@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a308d21-d463-4d6f-b5d3-95a0c2ede2c1@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF0004F086.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::632) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|GV2P192MB1966:EE_
X-MS-Office365-Filtering-Correlation-Id: 881fb3a7-b827-4038-0242-08de268756d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMkG7r3GscPWTOg6SSXdcFhPpDpUqiP5/psLUN7Lq1wPtpaP/gKZXEQb7CCr?=
 =?us-ascii?Q?qP0KT8v/m+LugZ2BUyAd0h7nT4+HN4P+pirfNakAX63W4FbZXNPbS1W8TUto?=
 =?us-ascii?Q?CNi4V6UUsE+2JYByTl/tMuSWIUz90mzP4czD8hUA8ZxMP59i2vWWlOujy0Zu?=
 =?us-ascii?Q?LDe9cZv3LH7OzvQ1isVrSM2F5qSnetTgecM7oGg7KHRorAf4OBjZmCOEhRpq?=
 =?us-ascii?Q?16ZAMhTAXlACK3O8rZf4srprmTUZ4GUZH60icg92t97A8KM1xvKhmoPaJGde?=
 =?us-ascii?Q?FrBfU4COrkoGjGumkHciC5US2giQEoK4lMBaI2sI+l7uUHDr30nLbXy3oUMv?=
 =?us-ascii?Q?2csWn/XaTTZB9MPyaODW13Ozhq0JAt+fo5n6WydNGryu59HQQrnkeyiJjoGU?=
 =?us-ascii?Q?9mbD5vQup1u5auMCmAXb/UHZebDW6q/xZoCXiptSxKSKDu6W/2yzI8LA98zw?=
 =?us-ascii?Q?E6vn9LYwqJEuDF5K+QEaMH8lHWE+r+XDHUOqUkJNvJWj4EdcBrD5mGMlxtdA?=
 =?us-ascii?Q?h62If7Kr5zXhzI1pZhKvQxIVAcK1XfVhNxO7TSmerfaqABPHy5Flp/sN7Y30?=
 =?us-ascii?Q?6WYxUR9+4tUSbdXWpUHLvVYTlxCYlZI13vp4LHdOnWM686gOfVwYc/bUA9Ev?=
 =?us-ascii?Q?y0+faaGP9z14EmeY8Kxpa/Wk9tSszhI/W2acvdqk2Cwr/RQGivP4lsIFOJoM?=
 =?us-ascii?Q?nJAP3am1BLDU78dLVPea1yoUc/FuNVR6ZgLRl7WU01g9wXOhT7tHBiW6Hur3?=
 =?us-ascii?Q?Md/sEtQAxmz4Jl+hnNxt1W5SCn21z7DY6xaF49Hw/BX+IXNU2n+R7r4qw3WC?=
 =?us-ascii?Q?y8KZF4Mv1EHEWTdEDJyyg44637kzDvjJVo+CKqyVfrGj9BbigD9BPP3xlYUU?=
 =?us-ascii?Q?84cEC06lLwMI5VW/C0pZ1qlY/aYKcMrHBSrQpngHMSkfi1E3By5RO3svpMvP?=
 =?us-ascii?Q?+pJ4TOH1DjjioORCXNpzGw8ETHomISfnI9Y5dZ3RGUz1/Ti8lUNCfL/8gr17?=
 =?us-ascii?Q?CctKYJEcZvI4SUBNrw2dxs8i87Jzid05eQVDF8+zPeX0lSf1nAh1Dc8BLk4r?=
 =?us-ascii?Q?uAgGQb4bru/Zvkxk8TebLgvLEYop9UupQOn76hixFzRavDoT93nyIdIaHzUf?=
 =?us-ascii?Q?bxj18pnqdJGM4rk1aI2oHq2oybTqc/SghU1diVPEUDiaV1GAkelGf7/9Qb3b?=
 =?us-ascii?Q?SicD7Q+qGhgkyGpKb3m57Zvf0QK4KAaV8ZaXAhe0TKqOYDfD5HOu5lFMeuPv?=
 =?us-ascii?Q?AAkB2wTIbWhCGTztTlGEIi9kPw9dm+FViPTThEzKQQS02XmpkcVe6vC09tA+?=
 =?us-ascii?Q?hjTUmnwbWqQKCRWbm2Uus41JmtRVqoMxVkICE11y96sF06ysBlpNe40T6EiB?=
 =?us-ascii?Q?espNmEJgRjzfAg4Q2ABtGkBcLcFuCifuPcXT7XbUrB95J7qUiEHAdahij+Pw?=
 =?us-ascii?Q?dwD041KFQ/jMCLyzkmyosiO9ZPeCVsRq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ib785pjkSpMMB2XguO0JzUZqFgn1SmEQCXp3523Niegto5q9LBaBMWEPPgS5?=
 =?us-ascii?Q?UXfIlyiZlcS0ut/UHJAwc+0uOxdCNwlVaCj0ygzrmmRVM3oel3MZc3VBTcyV?=
 =?us-ascii?Q?wW6gT/k1ReAxmNm8FTSwjH2P0obDuHjxQ74cFfaIL51FLtyz0Q0d4GT2Ku+r?=
 =?us-ascii?Q?lSXcRhEZFuvtljy/Euckl8F3DUaRFoJ/wvO7Ar7RZ5fvwb/wNkjfm0Rui/wy?=
 =?us-ascii?Q?ejD8R2ql+/R9ICa3wFqCw27nMxtph0I5LUIRwMOE/wuu+KDv8bLuNQnxHKx6?=
 =?us-ascii?Q?vDT5UI3GtsgtbAC+V5gMlStbHA0aspan85FlTm4Y2BDd87Xbip7CimrbaUWb?=
 =?us-ascii?Q?5ZGilYW3Ymogz+rgcMmSLgqj4Tadr4t612G/JPYXGbERJ91LrTJ0V5x3dicq?=
 =?us-ascii?Q?Bn6+QgcWETt/ttlbQb8mXjO/YB2BLesyIsUfZtd8q+BFBNwV1D5H0oFqdoff?=
 =?us-ascii?Q?67mQIvUW/yvMOcoUOkfmlUeEihI6GhwF6P7UEs8Fsh11f4yuERUaEH7Wo1B7?=
 =?us-ascii?Q?5rS1ZOToZbuQuuXaAFK9XKzbwBcT93rAig2vm9rEvJoHvv6MsjCfrEdMzcfN?=
 =?us-ascii?Q?Z42njBBU+B683bBCAfNHGTzcHiTScm5mkiDfUIqNnv5TKoJXZn49AFPSjGOE?=
 =?us-ascii?Q?nQZlmwd8sMGFHGd1b0Iew+oIQBiiazC9uEwZnBvBdmsBgQv9nbxHYRSB6Moq?=
 =?us-ascii?Q?lmleeDGewhnXGxfZ3IfyhRSUplCJ2SE6uL2ORxKtIfNBj4QYZ5GI9LR9gOs5?=
 =?us-ascii?Q?k/X6yy4zWAVPfk38NPSVgcbt9iGIRdShhuUTf+TXqBXwavF2pSIXoPGxSJqj?=
 =?us-ascii?Q?qpF4hw8KvXdGhLCrxIaRCmMKl5kP8xTA/O7p/bupMuPhmf5BcvNb/nWnMYLh?=
 =?us-ascii?Q?9QqbXxniNrzmgbY143ZFuDg7ZiBhfSDhL0pTdIGTYm763HL+ZNWkziViD+D0?=
 =?us-ascii?Q?QHW6L+Rj1VjzITzHF+JDaj/7AkU1Z/JNCymoZ/GD1TjG2TThFBUM1K5zcVFI?=
 =?us-ascii?Q?hX625yY1xIjbMuTwcYnOSDGzzDPCph8ob0AiCC78BNJP5VEJluUHbTpan81h?=
 =?us-ascii?Q?Q9ddv14384jjbQrq+c0jbWn9j5/qT7/2mLJRwU3++0V57YOfaurZKBwX+x0n?=
 =?us-ascii?Q?nBYxDFptAUT5PGEvkEPdl6lCueKUEhZ9AZ6TjDBIr9jXNgHoBrawZkbDRHP5?=
 =?us-ascii?Q?VYVXL7lDnwcJc0Wr7IXjTIHMUf6UuQvEi9TvqTYNdNZSoFFHaV9edSBTBve3?=
 =?us-ascii?Q?zMyfD9f0mz9TqUjOpQN7k2+xDdroV4RmShJVcKPYWGZQcDtrTTBXmW/xbFAC?=
 =?us-ascii?Q?HeflEMnP+FUaD0biyUmLT4PGNqNiXYo/iBbRVbehFN5Q2MDuBVpwDCdgOZ0W?=
 =?us-ascii?Q?Hf/AAbECVJdl0U7zzcxc3SNYTHIJLPQttMUSfgO/VMNnO9fMCkJmLV7OSjLU?=
 =?us-ascii?Q?Da+hHe64z8KKovxddYaC76rg2bNUtSTdiHWeAdj3aUOE1LiMjPo4djaa+MJk?=
 =?us-ascii?Q?B5fc2jEyqwjqP4r+pUCdrMka2lUeBvNoB7FEDAmU17efOneedR7cJ3UkbtuO?=
 =?us-ascii?Q?goqX/aHMVVPLy/I8VDFi3dpQiLSqg+rbZxdOdEFk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MqWJr3TrVTg1Pg5g1h8DhUlX14XPtjokvC/xQZUPqhE6h6tvYklLO2WhPXOhh9lVa+PagL3hB483iveuaL9fxse5g5UIfkgpJmGOM4L0ipDftHU+f47wdFenp617UH9acBmaDFxb42bt4LL5eAxyxHJqazXTh0u34hYGq0pRanKVTc56bRbFiuWANohR8z2RSNUc2HceLIDdfQPSmrNL+APbIufLxfXlXx+yHaIlZlO7Y0IRhMJJu2CeAbfAM0BeyfJmKVs5uUAY64ekXNJYDZVz5auZxOYCxF46Wk8hJZ3J0OJugCvsJ/UG/pyWEG4lreOkMskYTc+a5/ebvPA0sb+8p7B28Q79QFaXloCELxv9dvrHlXa9I6b7lFKjjGWBNzULbrw3rhBkFLhZhsTr9gANG7+jJ4dckxY7OaX5twt/MUaIjKEE17McxuuhcOK0K2RI+dZvFdvUdimYza+O5oI6VFUhkWXys7Xy6ddQPwWrAtM8GA6JWKpGndie9QSIlisGcmEfEvfQVSbwQnn7hx7D7zhNNLb1vEIdyJoybpJd9SYMnkQqqUId29haGJHRstVEJ4ny0VGCuhFBuGYZbHOYPjTHXSQ8PciNVrFD/v0IcC6tSEE9oxVOkl3RdfVT
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881fb3a7-b827-4038-0242-08de268756d6
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:46:25.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMH3QdVDaISleMyuFrzkINRydU90PGbdsq6KXSeaxn0wq07gFjQgLnF5CWKLVO1AMqTW3o7HGriIShEZMM7lTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1966
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GV2P192MB1966.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=dr/Wylg4 c=1 sm=1 tr=0 ts=691c4075 cx=c_pps
 a=8CgWxaQS7RS7qE/f3n7Fpg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=65p1ccFE3Hf02clXqFMA:9
 a=CjuIK1q_8ugA:10 a=PZhj9NlD-CKO8hVp7yCs:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EFWIzE254QbJF4iXWmSs_ypbpdAa0fS3
X-Proofpoint-ORIG-GUID: EFWIzE254QbJF4iXWmSs_ypbpdAa0fS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA3NyBTYWx0ZWRfX2WKlu0CYe3lP
 N73dS/vQ/iuDlynxC42IXQcNpu50CLJC7FPetby+Kh340SGGBPBiT4jm5oGDK9MJMx0cBnLTp9o
 tp12cYLbCnw2KHkjsZSrH/wJ0etNTsPpJAvLhJdbRzTLznMPHxD2UC2Mxm1cpjAP0Vd3CPE4DMo
 7nJyBpRbI5MISn4AOO04hx/zz9YAjlR2SkYMZSDSmIXoaSQpNC2V2a2rY+ViV0v+qTQJaUTQyXc
 u50HKpklMperooQweNU5JiSIpufJpfFkDeAgWoF2ZFTI/uhny4SX+I2f/URlVGZQyfomXrnV7sJ
 vYLI8QPDjj4eeF4GvioU4vHzvw+i161MZBiH8g3OKqJthAf3D6ByxDfekSG/6EPXToT4p4pMHHt
 0p5nD7dQkgAAtLgxo3ibm71TVXx02w==

On Tue, Nov 18, 2025 at 05:35:09PM +0800, Baochen Qiang wrote:
> 
> 
> On 11/18/2025 3:21 PM, Alexander Wilhelm wrote:
> > The SRNG head and tail ring pointers are stored in device memory as
> > little-endian values. On big-endian systems, direct dereferencing of these
> > pointers leads to incorrect values being read or written, causing ring
> > management issues and potentially breaking data flow.
> > 
> > This patch ensures all accesses to SRNG ring pointers use the appropriate
> > endianness conversions. This affects both read and write paths for source
> > and destination rings, as well as debug output. The changes guarantee
> > correct operation on both little- and big-endian architectures.
> > 
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
> >  1 file changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> > index 6406fcf5d69f..bd4d1de9eb1a 100644
> > --- a/drivers/net/wireless/ath/ath12k/hal.c
> > +++ b/drivers/net/wireless/ath/ath12k/hal.c
> > @@ -2007,7 +2007,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
> >  	tp = srng->u.dst_ring.tp;
> >  
> >  	if (sync_hw_ptr) {
> > -		hp = *srng->u.dst_ring.hp_addr;
> > +		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
> 
> should we also need to change its type to '__le32 *'?

I saw that in the 'wifi: ath12k: fix endianness handling while accessing wmi
service bit' patch where '__le32' was used? Which one should I preferably use?
I'll change that in the next version.


Best regards
Alexander Wilhelm

