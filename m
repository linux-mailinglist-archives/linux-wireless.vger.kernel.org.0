Return-Path: <linux-wireless+bounces-25524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73238B07001
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F517AA299
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7128EA70;
	Wed, 16 Jul 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="RtJdE10a";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="gWpHUWVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22A28C5BD;
	Wed, 16 Jul 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653657; cv=fail; b=dxFcnL3raXXG70PxmBtFe5/CJy8yeC7iOOoeoLFdprwxd/A8m3exBoi77YWvF4teVv2PBjRXf0nCIPmrahdzaoIMPrD1m6GhHXkWrcfK1hJ3Ao0jAWsu0yw+qwYTYuTjWpCWBE0Kqf+q+disWRTMASjQEolsHcgyRF6QQwQte9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653657; c=relaxed/simple;
	bh=m+tld8a5RV7YSIagMxEV+rm0QVjDyAT8NFa6DyPWV5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YcysEuwf+Y752QhsTP+ANis5BFHT9lJaYX/e+WH66uT+tTI1qSUCS3fzfTvgnThHFyP2ka2DRqWNU54Ci9EtyteiQ+gSa07rjhFCrTf+0m1OYDvXzB9ooFmiDp2j2kW4V4ypOE7yoYUDk3f5H/CWE+c5R3Io5jTxILCRdcbF6WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=RtJdE10a; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=gWpHUWVd; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6VsLY2289289;
	Wed, 16 Jul 2025 09:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	ecLprBiEVCA4tUnONjuUXYtOxpW+pihpAieT6ENxTZU=; b=RtJdE10aDTo56xJ1
	Ao5nHQ28s9QDImvhph0CoKdD7115FSwu8tcwWViRYnICAp5BI04DnOh+7AqlLoD9
	LFYIKZBo1UwCCmOO6W+hmtskUxaIiRapubghATqKqIRYFcfDr0NKapgyNgR/Tjuz
	QNN9K7R+6Y+vk0jvS9qNZbp4jYNAvywhPqjIaWhkwnx/CzjZrAnGsavdArPZy2om
	/oW/GPE6RkB2ZUpq6D2O106FJM3RhZD9XnVwa35y7kU5L3OJuc3CBrM4KNy2ilVy
	5ER8oLhSYXJtYFcTLs2up3E8agtyfitukpEpFLj4koA5pUV+TdEvrITGkNv/ebMG
	seQhAg==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2114.outbound.protection.outlook.com [40.107.104.114])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7nd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:22 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnWQL2pah/OBLHolHzLv2FqPuMGDb5IE6Ub4vwM8ZX/9n6RGMlLcNv0v5oo2G4VuFI2wiKc9ZOqNe76DqfudcB1vbc1kVW2d9Wmd8OpBW4lNTlMuk0ZjInuFiFgU4ZliW1QucCkTRhjzJuaGXasSNcoDSWBq8JqpE506k4tiKsiwTpWMVBCGiJEC1SoA8DZOauSGTteJDmI2tMPnab9iIbL/FcSFDHVaw0ZbIftyvm5V9Kb1YlnOrHQmkDMAU1MbFI2VyqPJDwKbqgNIoCgSEiclZ2WYk63hIwBZv5ijQ0/HkBkwjKxG+uMdGNx/RBhtGfQCuK7lzsZ5NvP+7+WdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecLprBiEVCA4tUnONjuUXYtOxpW+pihpAieT6ENxTZU=;
 b=Ih86LN+eVR2ggIi/QWj6G2fOvfVTv+//DtxL6QiP44Tk6+rOnWe1pqH9IqENj54QvJutUaohP71KJEbTFxSNjVoczuLNMs2dGSthXrT2dL7mOvzp9iGkdpWgfb65Q3vupLzmdvuQrPW4uwenA7kAMyRYXDkpeKS64ZYVeNC0AJQsJxxYTNJYmm88j7n0nTRPVpFsNGxkhYzLNOqKnZr6UK2wRvMlwrt42abksgAPCPNUGHWMwIEpIPTGXDtzcNpHzsV7KAPbowwhF6cGd1JQImiqkawjNjPmIW1ShU0siTYNLvMOWrwUgQFPtWbss/JXCGsssLUNzGqCAJ99GXS9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecLprBiEVCA4tUnONjuUXYtOxpW+pihpAieT6ENxTZU=;
 b=gWpHUWVdZMpX2egsIeGjPjInxL84/zPcwFi5GRpcUebGAkb8fdREYY7+9tOlCcaJ18Rvz2kf4GwscIoZ6ZaTRLfw+TcxmpS494m3vu1KxLUVgZZDOM9rsX8TbyNBzO2RvaHRepgnLW76amz6pixGmcyBe7xsH8CkNLH6URPcreM=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:19 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:19 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 06/11] wifi: ath12k: fix endianness handling in QMI firmware capabilities
Date: Wed, 16 Jul 2025 09:50:55 +0200
Message-Id: <20250716075100.1447352-7-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0060.eurprd09.prod.outlook.com
 (2603:10a6:7:15::49) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c0850d-c3fb-4af0-15c3-08ddc43d8cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XS7jhLG8hEt/TsswOjyguav42mZrcTZ6KFyBOwRtbx2Dzqr66EDntCaCohN/?=
 =?us-ascii?Q?nJQpCBYrnMVo6LzEjWTTwv2hgkHHyrAtBufeTB4TDStsiy33qKqpE8thYA/M?=
 =?us-ascii?Q?xsH633a6srRwEBWVhaVJJMTmHSQvq5CE4IS/XN1cLAlpNXZLqXgJXkWJuMuM?=
 =?us-ascii?Q?du8RH3xX7Y8V+HB6piwsl1FyIwXLeIo2B1PE5wt0bb/8b0j7/0l9q6V22p87?=
 =?us-ascii?Q?0qC7YzpNJj7yVabCj3TIkv4nD2uD418YBWAYcXdQeOO5w0mbOFpL9fjcG7c0?=
 =?us-ascii?Q?hTdhO1ZwslWZ+ZbsnQFxNrJdI6UkkP4xwBpZ8wVXpzZqwl8TOfdMyjKWbtTt?=
 =?us-ascii?Q?9vSDJ4+K/MovojLWAmais5HhO9nL2FYhwFja5aTbQE2wath7cWdtK70zzNa8?=
 =?us-ascii?Q?zsBYbAAFYa8LLalTKGyZUFUmDVZeELBMCcBeH0wZmbGxbc3oupwhZbBwlLSk?=
 =?us-ascii?Q?IGz8OeqVjSvkgqDdyH6GwRdnCfTMZGZx3tM1Kic+MwCGLJpeP7EzopIob8Su?=
 =?us-ascii?Q?LOcK0AWtdDUCMIYxFQKTmZzQpSR7cilGfa5gtDJi4Py7ueQE8EZyF7/7tkdb?=
 =?us-ascii?Q?eN2BdJScc41TUxmuxvp7ML5G9wVsale39uwXeMCTPvQVmqTpWYl9TnMrrkbJ?=
 =?us-ascii?Q?QyGbgPVoRuaBUsxRLop8XZcpyFbKKayZbhW8bD9vagh5NZBkH54Rh3lyY9ph?=
 =?us-ascii?Q?9DDgCzWlex4NsYlKpC3M0dILF8nn4P4DyrfayGWzFizz9vYth9ELLvjb+hGW?=
 =?us-ascii?Q?X4hqditan3oaWCMC+XdALSkmIWeGdX6q4Syqo93v7An1/WLUAo5UkS7Te8Q/?=
 =?us-ascii?Q?HhBJ3Y+4itOP0y1u21rKSCm0dQV1DcBPp6TlSOPaMQZmEGwMhwePrS+pTPHy?=
 =?us-ascii?Q?5r5KWMkIhmmnidAcDr93CeVU5cwqXybH6kbqjRKWCbREoQF6ILxOsrRubSBx?=
 =?us-ascii?Q?xWaF3ouTNSJ8TRShvzHX6DiEgDEzBeRbzUWHnKc2ho/Fa2JUE3dMgIJ/YgaG?=
 =?us-ascii?Q?j36oC4ZX6oFqAq3fKz/LGbrCml9WaH0+X+G06o9/l8tYm7IPQK7apBphscJ4?=
 =?us-ascii?Q?9lDpyFvk4y0yi9gmNilSBQ2oE53FwLEx32cm4dVY2ZqL2Tue4mJFOesUZTQM?=
 =?us-ascii?Q?RkewAzSp3/vIwefWbIIo9gTcjS53EBWIyTcHBCV1y8BXqGOFm0yTbKkQSHPO?=
 =?us-ascii?Q?dkOGWrsQJGhueH/vJVvHlfQgkaQLgBvSMEWFRcD3MKJUURHYArVwxcF+ggcy?=
 =?us-ascii?Q?FFNp+Qg3hBhfE4o1/CXbnDLDiHKLx5FVoz8AvkgnwClkczK4jm6aQWvLVlaP?=
 =?us-ascii?Q?FISIy8Fu5zg7va9rP158aWz3yKvQSDm+W75Z9J3XRhDSxOsz6yVqmRBE0eNm?=
 =?us-ascii?Q?nLtrA/dDxg94xbbgqacyzup9lqZJgjgiNT4Y3vvhGBaf2cU+006u7BbE8w0z?=
 =?us-ascii?Q?HAu26oFbBvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/D8M1Cln3djfFhsAy98HItq0MoOefYFKP4c4Vzesb40hQ6Y/z97FiuoukfE?=
 =?us-ascii?Q?fTwWGBd7rQRlf3Ojb4SvM0yczR9ijBdG+BRhijql72GtJaOkBEOfTNWJsXQm?=
 =?us-ascii?Q?+mfSABmNWqIydB/rDUaDn0gR2rPFnxbp/Nm3GR370iofGwnsdMJn+q2WHkOc?=
 =?us-ascii?Q?WjB+JnCtjbpm+0DI+JsOh7UGtKoaZX+2+4U5b1eYrdRl+5l/HJ3I6GuKyD21?=
 =?us-ascii?Q?PJ41MwMGsCbNWYrJxw59hRpSN1tVjOWc5Xw3eF4Y0yZfndnLjju1QXUAFO0P?=
 =?us-ascii?Q?LIhKigNwYcyMVvZYDz76mA77dDnH9VL1e+NdqqblJk4XMkNGJX1gBEBX7WSe?=
 =?us-ascii?Q?OzIeqbqplhUfZSipzCde5UZNG+DdQq742uBvA8Jr6dqYq9ThQ2yZpANPGkWD?=
 =?us-ascii?Q?R6emu6vRYwTgsSpPM3NGPPJTi5RpJLMuF8PRjWOomJG1DLnDa9YqIQdCHcO6?=
 =?us-ascii?Q?TqcPH8ryskQM8XX+Ei6TzaE130OuEMED1s6TWO2YuOXtVygtRpcfqtivbcUj?=
 =?us-ascii?Q?GMOc25U4Rk8MqwO6AaTTHrtAdgHBKmRDuhR/SbnX1IQYgdj2rlx5BGH04t93?=
 =?us-ascii?Q?mIQxD/Wk9FEj5c1rG2S5/pHJY0phDqSjgnei9ixv2MpoXiGH1JCsHL7EeU1i?=
 =?us-ascii?Q?cXV133CZxfQwb2FaEqJBRk5Q86hV9ElSKSSoUuW4HyiAL0EnUad7J/xRU3kn?=
 =?us-ascii?Q?6q52TO+uRE9WgAC99lsHsQS8XnwyQ05PbzHSUR6SQAm2SUTB1OCZqkZXpjjc?=
 =?us-ascii?Q?384gEydPgWNl9bEUPsPirF0FQK2/w9v6yUvQFKHss6Cq0cBpWoJBwecqDCL3?=
 =?us-ascii?Q?9dye5rHdFXvxRHQhLfQBUoMhrP6k5MREUL8RJ0G7hfPXlrFoIfSyXk4rSKnM?=
 =?us-ascii?Q?pGP7mqJQIOokZZy8YPgO9lPHWglhk8G2xkyJ7xgGopg6yadDmiAOHjmm3T4/?=
 =?us-ascii?Q?P0uHiA3qZ1CS4RS6icFaOXo8VDnqDrxJrva4QEE6enUzpX6EazoOj9Z30pVj?=
 =?us-ascii?Q?FPYtHqfQ73RHMcpKSbvkpl16Hul+mk/t5mD9C5IqdN54JgSlIsI/vv8HF5zw?=
 =?us-ascii?Q?9K3Z+GVDToqwRWU/4D1x3PNuqPQRGnl54dV5reG6yWuymd90vIT3XJrFzvUI?=
 =?us-ascii?Q?5yaDr+Z2pIk8OXZrKbMYPmVGuEzMTVomXZaksNUtYs7+w84LbHT1bJ/VnEB7?=
 =?us-ascii?Q?bsiUpawzzKSxTxFgzKW725hmzrvD9d2tCVintSvM6Eq3dWA01qfiwne4lYX2?=
 =?us-ascii?Q?SrblWo7rKT0NvnkohO+8PIEBEGQyaFaiUq4ZsXKSM6gmNSwH5TrDO7NsdPsH?=
 =?us-ascii?Q?ggv0MtozjuD12/WlACqQkANCHakYnUAg6VJmdpXp9adVjcY9W+ZzGsl0eLbT?=
 =?us-ascii?Q?Q4ORVbusqt2Q0dyNBIwRPwrYhtHTlELlUlJHhgZHoFuS8acVs3Loa4pdZ8Au?=
 =?us-ascii?Q?Q2ZsN5tn9uTJHoJ0+43FlQyL5u5apHOe/o6+NK8IMZnCq7OPB0R8jXVssusy?=
 =?us-ascii?Q?6/dQcoSdiQ1aYG/U66+tg0G1hTQUma7oA0FcII/6KBi9wBJC0GNzZyje4VKs?=
 =?us-ascii?Q?0RAIzTMfD3qUiFCL9dnjSBTzqd0FLIMWH8xdskYn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oUsydy8H1+3DPFw+WKN2rHu8qS4jfIHhDvuJTg/5t/1Kknirwp2t1Y72TdIz5jvdzdn9PQP6RUs1UxC9OoapN7oSKElYB3ErJXawJ32saRsyjBs91591a9rmNFC8M0bcDmapEJ65euRb0Jcw1xYVatXj2VavqEMlH4jgbP4LxheZqlxqm6JCtgadr1fOxk2bwf7HXuLUEkL0JngW1Zy76LAQ3LsJs8fTz2vxUGBo34NBfUFtQtdHBM+M/SRBdl0xWDco/pnJPlrcDx6d+EuqdGN2wsVV33/6ZtoEj3Ip2A3ml/Si5T83O1FMuytro9MJeGqn+jKc1OhlA9RCRvVyVTJRU/lq5yxzvnSN02xWvqOGteZJGkHgo4HX2qJ4iPFGS9L8C+zEVInxbMdIpr57hyTHavZHZjWZlkXNEjyGVahuz0PDhgnPSI1k8v7w5e13NBbUjnkoFPa44cu7ppHMpKm2o3GoYFBzYcbzIh/8HpkFAAidjCU2WrMOlJKwbGMGSG6NSRihp7V1GOBoOnyqeL3WAUofeNP03U1kGTmecMqmU6iDyq0eeZzpTPGTwBDQEonNRNgo4kec4isaPovvTwQOkXEdSvqoEXt2zI++95/rS7NLRMdeun/DW2iw/4Kk
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c0850d-c3fb-4af0-15c3-08ddc43d8cdd
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:19.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4S/IWYK+dWB5n5E2Xm7AV7PZhRtvQIbZCgEH5hri4b0INMZg9oDqxN2WTstmfFetqORvOhIMP2+YIU4kP3YTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1853
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GVXP192MB1853.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfXxPoq1pRMPW25
 xXWzM5pvYoszQfCM6o+A0RNmVSQ6jIVQpacsejlVRUOL1mBH/Ewlat5wbrrw+Nzb5ZbLMrUX/zr
 IPPdkU6n4u5/FPGBp1rV6VktVTlwKRSoS5UEONIb92sCGXdUYztybujurEVo974v3SOCaNfPcvA
 o6Y8GmBTSmZJw79waFETiPNRRpv9K665M3oIqq2gkwuBG0tfhToGW9zXeTw5feSpiI96TadWcub
 bZY6gFlESPi8pcymKCfcqfDoCLDKhBAeBuKBKx2FTt5jyZeExX+TVBhUNje9u9v61RHBiMbVKiV
 EGrgeDBrXBwLpgvsky5U180uk8APolQlYNYc7L2MZTxl872Hw++WMFCDv8x8qcBS3Sd1jOx116B
 MPLHtD8q
X-Proofpoint-GUID: 241-NLk55mt9Ue4Hek9oCXSv-I4KA2Lu
X-Proofpoint-ORIG-GUID: 241-NLk55mt9Ue4Hek9oCXSv-I4KA2Lu
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759fa cx=c_pps
 a=0c3FZvCe35elBS0vCCollQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=Fcvcvy57vIv4vxiygTkA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI firmware capabilities response message and its
associated structures as well. Add missing byte swaps wherever these
structures are accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/qmi.h | 26 +++++++++++++-------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 2d00ea54e478..0bcfb9281d01 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2850,20 +2850,20 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	}
 
 	if (resp.chip_info_valid) {
-		ab->qmi.target.chip_id = resp.chip_info.chip_id;
-		ab->qmi.target.chip_family = resp.chip_info.chip_family;
+		ab->qmi.target.chip_id = le32_to_cpu(resp.chip_info.chip_id);
+		ab->qmi.target.chip_family = le32_to_cpu(resp.chip_info.chip_family);
 	}
 
 	if (resp.board_info_valid)
-		ab->qmi.target.board_id = resp.board_info.board_id;
+		ab->qmi.target.board_id = le32_to_cpu(resp.board_info.board_id);
 	else
 		ab->qmi.target.board_id = board_id;
 
 	if (resp.soc_info_valid)
-		ab->qmi.target.soc_id = resp.soc_info.soc_id;
+		ab->qmi.target.soc_id = le32_to_cpu(resp.soc_info.soc_id);
 
 	if (resp.fw_version_info_valid) {
-		ab->qmi.target.fw_version = resp.fw_version_info.fw_version;
+		ab->qmi.target.fw_version = le32_to_cpu(resp.fw_version_info.fw_version);
 		strscpy(ab->qmi.target.fw_build_timestamp,
 			resp.fw_version_info.fw_build_timestamp,
 			sizeof(ab->qmi.target.fw_build_timestamp));
@@ -2876,9 +2876,9 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	if (resp.dev_mem_info_valid) {
 		for (i = 0; i < ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01; i++) {
 			ab->qmi.dev_mem[i].start =
-				resp.dev_mem[i].start;
+				le64_to_cpu(resp.dev_mem[i].start);
 			ab->qmi.dev_mem[i].size =
-				resp.dev_mem[i].size;
+				le64_to_cpu(resp.dev_mem[i].size);
 			ath12k_dbg(ab, ATH12K_DBG_QMI,
 				   "devmem [%d] start 0x%llx size %llu\n", i,
 				   ab->qmi.dev_mem[i].start,
@@ -2887,7 +2887,7 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	}
 
 	if (resp.eeprom_caldata_read_timeout_valid) {
-		ab->qmi.target.eeprom_caldata = resp.eeprom_caldata_read_timeout;
+		ab->qmi.target.eeprom_caldata = le32_to_cpu(resp.eeprom_caldata_read_timeout);
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi cal data supported from eeprom\n");
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index bd715bca8f23..114324157e84 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -421,26 +421,26 @@ struct qmi_wlanfw_memory_region_info_s_v01 {
 };
 
 struct qmi_wlanfw_rf_chip_info_s_v01 {
-	u32 chip_id;
-	u32 chip_family;
+	__le32 chip_id;
+	__le32 chip_family;
 };
 
 struct qmi_wlanfw_rf_board_info_s_v01 {
-	u32 board_id;
+	__le32 board_id;
 };
 
 struct qmi_wlanfw_soc_info_s_v01 {
-	u32 soc_id;
+	__le32 soc_id;
 };
 
 struct qmi_wlanfw_fw_version_info_s_v01 {
-	u32 fw_version;
+	__le32 fw_version;
 	char fw_build_timestamp[ATH12K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01 + 1];
 };
 
 struct qmi_wlanfw_dev_mem_info_s_v01 {
-	u64 start;
-	u64 size;
+	__le64 start;
+	__le64 size;
 };
 
 enum qmi_wlanfw_cal_temp_id_enum_v01 {
@@ -475,17 +475,17 @@ struct qmi_wlanfw_cap_resp_msg_v01 {
 	u8 num_macs_valid;
 	u8 num_macs;
 	u8 voltage_mv_valid;
-	u32 voltage_mv;
+	__le32 voltage_mv;
 	u8 time_freq_hz_valid;
-	u32 time_freq_hz;
+	__le32 time_freq_hz;
 	u8 otp_version_valid;
-	u32 otp_version;
+	__le32 otp_version;
 	u8 eeprom_caldata_read_timeout_valid;
-	u32 eeprom_caldata_read_timeout;
+	__le32 eeprom_caldata_read_timeout;
 	u8 fw_caps_valid;
-	u64 fw_caps;
+	__le64 fw_caps;
 	u8 rd_card_chain_cap_valid;
-	enum qmi_wlanfw_rd_card_chain_cap_v01 rd_card_chain_cap;
+	__le32 rd_card_chain_cap;
 	u8 dev_mem_info_valid;
 	struct qmi_wlanfw_dev_mem_info_s_v01 dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
 };
-- 
2.34.1


