Return-Path: <linux-wireless+bounces-26042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B98B14E4C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A69954574D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA917A30F;
	Tue, 29 Jul 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="zUy4Nq8v";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="voXKTIKU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721ACA4B
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795279; cv=fail; b=id5H5pKkdrolZdfg+UW+RI0t+CRyskIU1kj4ygvVny/on5Yoog0Im29+5PJuZmu1Y/jXQIYlnwngrxnnu77MFXs7C/8A+Gjhh9ORlj4Ypwd4A+MGeitfgy1LO9y6jbL6hUkqs7a4IZ+122toJReG1dir1zGHBcZIiCKIBPOYYOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795279; c=relaxed/simple;
	bh=gcc0EL2X+SujngsAcm65ylBnTtGthI6ttonZvZwT/vA=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sjJPNgyCqkRw8N7SxDee3mYXlYG7U9BLc4mzHsU9Po5rIykOhuwtc3XAFlFYEIOVwJU/4DHbhdnuT+G1L4qkw4frDGEGIdTQD/gXXvFbQ0zg5C9q6i3+eunOqeQ/4jOFbMPjdGaV4Mj1xDu6lxoTiUjgwCYiitlOc7eTU+IJ/d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=zUy4Nq8v; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=voXKTIKU; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56T5ibqJ3531570;
	Tue, 29 Jul 2025 15:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=PXKW9Lu5PeYoQ+707ZnJKnM6K6AOBq1UJRVvxD1apus=; b=zU
	y4Nq8vvNIHj6wHzB29gaugEHhB/h4IJ3v34Em94Jl1n8hZdPIa09Tkz8zLLhAPez
	7mB2eynyIdWgVaEDW6R89sJ8mbuMUm2JauOmMRbLLnGCFbdotpoA7pqO5a/PLT8F
	UxnZsHfKxzrkzWPhzQ33fdHy8vr3TpcKpE4fQ1tay+N4WnyN/OxQCHizPlB3TL2N
	JsL+mqrwoupCdVZBnM/HSwBNTe+hay4E+xlsaZhTzOzH5NS8AMiJkYMDhfe021iV
	LHYrt6iaCryDiE0Y5oVofoyVMzcLu1I6KcgNiFHPZykzaqE8tvtklwR+O9vJqO3h
	/VRlvPCi2JcCTkT0mdkQ==
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03on2108.outbound.protection.outlook.com [40.107.105.108])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 484k10tsff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 15:04:05 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhkU8XQ+C/+65YmX+63j2J9RcUPztLtFc+smVnAbDJ2nqciadtNIRJFSx4uWW9vyA6xoKWPDsI4Br+TqN+A2r780DgeZyTaBfctZOMGJtfXzavucvC61te45TpD8XE5f3/k11rK+pJJW/GNQEnBupI4PrMA/Wvr3yLTCZYcekeQjG2HgBTh9/brjbP5tDEUdP4au1qyS6Fj26W8dQmo1vS2QglF9kfooiZN04RuHSo8Plj3embPxdX2B2C6M4YMzYlm+o7LQrNsqWzf3YYnpEZ+/iRgr/rrxJSapORuvx8IaLQyYHucE7vC+IvfCM4PjJnxLMeqCWj/lowvR4ImJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXKW9Lu5PeYoQ+707ZnJKnM6K6AOBq1UJRVvxD1apus=;
 b=jWK9TGXiSTshZaMa1EKO65t+jbgNB4AIWt7e/BuCfAu1vqDC5OheBx95M5+HVu8hdUy4ozJJgVsKeHrCvQBF2iWMlkOGloL3eDaGhzgGp4mtlUIZmesTAqFBconLN1KHnKK6F+EteJ1UiVcHu06+W8BJ711xyZPkuZaDIQ+PmsiVz3kfDDmx4/+36Rt4pkrUXVdKBBLXyDZiELpza5xSgyRA9SrzYX2WbU61aDtKY6VUEqmb5w3FFGriuoqhyH2Mkx6kUAmFIquHJHk9eA/kEukISo+K9M3fnVDtWiRyZLMiVT6fT+QpgqaxzAbd7jCZJZOAYxXXE+3Xfe7wGb+R6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXKW9Lu5PeYoQ+707ZnJKnM6K6AOBq1UJRVvxD1apus=;
 b=voXKTIKUBNWVIPRrNcrIRG+QxMe1uGEqy7qTk4loiRxzZTDqBc56CrPXp0O2l68yfy3fizLRKBKdXmXFDMf/YKXGHaGp1eUfqhWx8N0ocpwoKmJR7La1qomQXtQgaeam8xeYJcLKDTNmI6kByxvhj6t0S3N2FVJJ8erhdW43Fmk=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by BESP192MB2979.EURP192.PROD.OUTLOOK.COM (2603:10a6:b10:f3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 13:04:03 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 13:04:02 +0000
Date: Tue, 29 Jul 2025 15:03:57 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Missing BEACON_LOSS event
Message-ID: <aIjGvT+yQkZf8/Xs@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::17) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|BESP192MB2979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db7ca19-2ff5-4733-142d-08ddcea06440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WChF4K9TEL62z21k3lr4f39xmBOLJtKiURMgQtFPw+vjz0VNKDmnhdd37EhA?=
 =?us-ascii?Q?z77KJ2VUbztyv6XWs8Plyr2pL65Ioyo18pS6aW9KYmvvZvXK8jCaUMAMihEG?=
 =?us-ascii?Q?yPZRJEBzw0RnBnKGirA7p8lLQuAIKfL73M9ejL1a+pHM14YKBKPghLawcYFf?=
 =?us-ascii?Q?oifZODNHkM/V0nNMSi6+2vfkZGewaQF2Nh9JOghc85G44ysO6Nibb40v7oy7?=
 =?us-ascii?Q?J/keaNRpxacr1zE1B/HXXjhvTfW0ImFmkbiFrh6i2UGzI3aiISVc9zMh5m/w?=
 =?us-ascii?Q?f9ZgnApcHJ38C2c6oG1BtIXCLh9jDZmG8d4We80RPbZdYcQ9OWruU0sFjiIg?=
 =?us-ascii?Q?OcesFK3DMBdSPmG9vtiqaq8DX9f1A/lTEpxcUjViGXZACeElvImF82bY/+m8?=
 =?us-ascii?Q?XLOCgbvZVeyiKGXj4cW13FwmP9A/HhqZ3asDVvcbFUw+az+qcYwyDNtz+NfI?=
 =?us-ascii?Q?zuvqMerdVpEsisz3ZMLZFPA4BMa+46H0yEBHenqaNTscQaO7OiaLRpSEk4QW?=
 =?us-ascii?Q?sFwITK+Im5ZZJ9SrY6E7rKgqpHHfBrcKbtZFbejtAwXgrZZX6TImJzWa/L65?=
 =?us-ascii?Q?I5Jgr3O1uPM32CgS06jiGDOdg1wMtV9fp1vXWHxnnLGE827+NEQ5S2LUI430?=
 =?us-ascii?Q?Wzx1cMtEMB5xpRogD1kkCCgl2PU1FLV6qdTtlJoTJxqq/zx05EwejgCw9Scw?=
 =?us-ascii?Q?zaamtjzrCCyPzwR20UEZI6ncpTRhCuz4+hDmfGViKNau3Ag26KGi+f++LSFt?=
 =?us-ascii?Q?aP2dFUYJnr/rVeAlUHaXRHEtyqNyUZhAcOPQAVRI7KjYL7QcaC/qsVCC7QQJ?=
 =?us-ascii?Q?xtwDAL+WU6MjdzBxaX5UrIliAAqwJn8etWBXpn/86AG5drqahuqWOzErqWhc?=
 =?us-ascii?Q?yNWry6Mw+dPofYXK391WDUhxhUUBwiAFXxAlDiiV+zSrVjUgZvsHCX/Xjmna?=
 =?us-ascii?Q?BRKZ4qcHbAu8G7DcT5P37b1Y51tyY+4c+pENStQMFY5r5EmqVm5Csf6cdVse?=
 =?us-ascii?Q?OQYMNjWyQnJHoWy0G8Hv3a7iA7LQhTacx+lZ9detQHNaipKKRsuVw67iOSH0?=
 =?us-ascii?Q?zcjY7oWybYzIbq0yHgPvDIyEYTCXxTgZvSrF5ohEunj2ORjiuklxeeRGuVyi?=
 =?us-ascii?Q?eQ2jHlDa2rGjqiKA43TVgVz+GXXadyUdTdUuBjiwuuvsDbRHw6INAvPxjKSq?=
 =?us-ascii?Q?+z1zaRXqTFFpkQLbR92xTB46nEf4i0l3N1lT/Ae8eEdV+6YSM/y8WKwaWCcz?=
 =?us-ascii?Q?TYLtoiDdBWERiUsQfErI6HRPUGEP0Ds06JPgcjG87w/z/lJFVKBEthMC/GZH?=
 =?us-ascii?Q?o3oRDXkpzPUgwpmeTuYFazHFbThmJi9rsXvg6Ru0rKvOT6fSlH5NErdSE5YJ?=
 =?us-ascii?Q?EotH3fxgoxSEXH+dT5DT5Ea/JIZqcK3B6XsFIa0MUczkcJKmWZlBjPfGzxaO?=
 =?us-ascii?Q?QDdMd6Yh6nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGs5HB3brspwB/PHvHobf67HK3PnYFVuDuuQJUbF1sy7qkUZVRZACAxuSXHq?=
 =?us-ascii?Q?wFgeDKUSsgRLNTdBxE1GzxGB/R6R090yZurwJ59gLxWqMgS/Fk8DS5d3aSdS?=
 =?us-ascii?Q?PiLybSIRx1occ/AvFwZONKrTt4iC7wt73ZNszTyQk9UOZaACTucga7SrKoXr?=
 =?us-ascii?Q?5xEwjpEODG7q8P4meqsAsrGRKnO2QpWBfHsKA5eI25W/rhKdoqHl6MCHUIrG?=
 =?us-ascii?Q?nasIDNC+MumI3YbWAP7DPzMFRgqq4IqbdAzHflPRtF5cSSkUgZq9uchGFLHh?=
 =?us-ascii?Q?JbxOcAlM5rsIdknaRna+Zmn31HAOHho1mCciac8xpgDUXgwk7OrvHrmAsihB?=
 =?us-ascii?Q?OticmoEacOssS9KJNbzjQrZjXtDxGGJvOUWPwYPWAMlaXIFF6vI/qJ7laQeS?=
 =?us-ascii?Q?QgOMpKt7ULtL3MDX5Zc67du1Ty/YfnstiENDAL18dZZQmg8mIhXgqXdJAsMf?=
 =?us-ascii?Q?JB3FArakA7RMecyFBOy+RjcHoCKff2+s7oFIbmArE2pd0ZkqOxjXOmgAllc+?=
 =?us-ascii?Q?UMedMHFnsArG3R6mqgZCo+prQljOdHqwBmkKvEEMKLP2CcDdPpkw/wGj0a66?=
 =?us-ascii?Q?tiSmmbi6U9Cp93LCc8G+vj+jTkh8vKCSm3njiukzjN5UK706a9Cf2o/+L1iq?=
 =?us-ascii?Q?5byqc4GsbnOzG2rPAX4hvcOFQsGW1ogPhoQFMHZ6WgddYzcGfrd0QhTr3dRh?=
 =?us-ascii?Q?XTqboO7L5UDphvM8WiHOv/NB8Vpt9lUx1CQl1PeOaQLozM4L21YYxSwDhXuJ?=
 =?us-ascii?Q?uRWL+pi/BRsRY2wD+UOokjU95+JeQapxsQSb303eROusBB4uMey4gv/P1woM?=
 =?us-ascii?Q?2FyrARfP+UY8fMi1+439DKBkjZW2YLr/trIQnKAhZcD+lPrTSgG/9+fvPGq+?=
 =?us-ascii?Q?ECTv+pv8wJUic60xx6V4WShp3sFj01UiXcPn7IKl8nBI3LDKGHNWcLV2jG0X?=
 =?us-ascii?Q?F/ek3b3fioQOKn5HWwOt0rUm/oMG+tmL4au1OFtgh2w6oW3xTdt+2FQcAyMk?=
 =?us-ascii?Q?NqbpT27PRUG/NKU5ulcnzRzhMXej6xXn+mqlXKh+dusjvsZGZ9H5kA9r/Omf?=
 =?us-ascii?Q?i5oI/mO9SELPGKiww1x43Yp+MeW4xSb2Tg7u7ag2RiA2LJJ0ChMHrypDj5wb?=
 =?us-ascii?Q?sDvkoQhBpwqkjiZLrPJM8mHlaLOS8slPk1xUn3Sivr9zM4DdIvcQ/wzefWQb?=
 =?us-ascii?Q?QhBaLz14BeaZ7Fa7yARLsCaA1KJPdQR8IoHAP/0pKsnIpca7PbdjsJ9aCghO?=
 =?us-ascii?Q?6L+gx+ZAJTvW8ik1qAkX4o5/86xmuiHFCnbkw9MzTevV0dBZk68n0JcmXh+V?=
 =?us-ascii?Q?fyR5xTCjFR/evbzUoqj2j00aKRMZYNoJA7+N3hsbkrudjHo9PwVbiwbN+SS/?=
 =?us-ascii?Q?3acXHaa8F5Jrrg5uCky3dXBlD2TAghCVMiw0X1mQaaw+NKhpksy4HFz//qAU?=
 =?us-ascii?Q?uHPc+dad4kwnHj6l4T+eT2s0mDdaQzmNg8MNZdXLNSszEwqm7HG32R3mq+ZU?=
 =?us-ascii?Q?myWqtm+F8q8w4bBryyA600L4f/gm+oFfXEt7mXV5sDoHq8uTcK46UeFv5xs0?=
 =?us-ascii?Q?2O3fFcUXQR4t16qSD/QSbZ3sjdE71/awWblz1Y3a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q2guGzLau7rqjOAY17HHW6IzxCu/40GHbrcJ2SgLCR1SyDqUGTbjS86mGhWHqRp0VdxIiJyC0sLMWf3M/dEemrmiKwjtQ6Vuvc0Kq7WatVBVxxZDGZR8E8mq7FWsIQDOGoD7p25KVr/I75NArEWE6YU5+s6SypTJqVZJQJ0AUXiObGlR06pPs5e39zbr84WQKcNLrWr5a9Dt9BGzBkIez+SyZwWjA7AHaN6J8wTrXFx4+dFji+0Ub7286XJPcsfRE8D1Giw2G9VEntR4dbWeeEm8zfPnV7b7um8wpdd4CYp6XkYJm4QawPgLC9zmIvQ9OYNIwAmxSEwjNYphghruHyHpnieoCSrrV6jWo1DP/xWQhFR0KdicylHHzg3ju6nNQF80Up4e06ZKIYUm1Ych9XGOh/JJ7ea9vH4qWl6xMwbrRudTvA8H+DEU+XyDYp6E9rC8WtnA4/MsTY5pLn8v9mtkkrDavcqtF7UX5mgHmr2d2qFp335QaDHxw3ClFLabi+mmnPKRf0zCXozdsFQx5AFQHGDuv3xjvj/EJlpGmrk+6F99WPTVG+azkf13HyeJ04rXJ5mkcdNq8fRKUZpuGlDfa6DvwBlTd34HrM9NG3sQlWQl12B6mR4ZDwujWY/E
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db7ca19-2ff5-4733-142d-08ddcea06440
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:04:02.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsTBK5tp9DhI46+xzv8BuJ1Mu68nEnPCH41wPx4ox4HVegBYCfbRZjuo5wygC3lX7sndMcs8zCWJD83thQpukQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP192MB2979
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
X-OrganizationHeadersPreserved: BESP192MB2979.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=VqwjA/2n c=1 sm=1 tr=0 ts=6888c6c5 cx=c_pps
 a=1UqH5OoN4Xn9YX5XMDOJDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=8gLI3H-aZtYA:10
 a=NVTPNgu7vbDRLQVt67YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NfZs9VimVCont4wOl1LrOifffK4LFNxj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwMSBTYWx0ZWRfX5blibreP3dAC
 XzETWhzdkSbTht3jtaZBqVFwYm5fAUJfpGvrmE43FCbnUBUKDjJV2WNXBItiD7Zdyp4HPL80HmS
 bV3NNSubLGPM54ygWo+hjML83PoMhhh5Dw+9doZsSWCbccseYI3FU7TgHLaunWl6hJ6rkWR3c4a
 zH2wGhal/M9hKJH7fhYmSwAnscrkiXft0d0AAmpgRXUiuFfYb7qgDvN8WWRLDjjhlTShEfT0A2A
 XPOP7E7c6XO6Ts9bqzi1gnve3bijqqqBdfsY9gZkfRFAnQHk6gQ0pD8UY4+Jqt3qU6xJPcj9qMw
 +j7IFLiNF+XKSS6jJsPxyEB+IJMM6AdQBQWmZeMt2mldNUCb8wsZT/lW3FMaYAZeO3yPZxs9ONp
 qKR7D4PQ
X-Proofpoint-ORIG-GUID: NfZs9VimVCont4wOl1LrOifffK4LFNxj

Hello devs,

can someone help with the following issue?

I'm using a QCN9074-based device in STA mode, connected to an access point. When
the AP is powered off (without sending a deauthentication frame), the client
remains indefinitely associated. There is no disconnect, no beacon loss event,
and the RSSI remains stuck at the last known value.

Here is what I see in the logs:

    daemon.debug wpa_supplicant[6960]: nl80211: Drv Event 64 (NL80211_CMD_NOTIFY_CQM) received for wlan0
    daemon.debug wpa_supplicant[6960]: nl80211: Packet loss event for 04:f0:21:bd:63:1f (num_packets 10)
    daemon.debug wpa_supplicant[6960]: wlan0: Event STATION_LOW_ACK (32) received

As a comparison, with an ath10k-based device, I get the expected disconnect sequence:

    daemon.debug wpa_supplicant[5859]: nl80211: Drv Event 64 (NL80211_CMD_NOTIFY_CQM) received for wlan0
    daemon.debug wpa_supplicant[5859]: nl80211: Beacon loss event
    daemon.debug wpa_supplicant[5859]: wlan0: Event BEACON_LOSS (53) received
    daemon.notice wpa_supplicant[5859]: wlan0: CTRL-EVENT-BEACON-LOSS
    daemon.debug wpa_supplicant[5859]: RTM_NEWLINK: ifi_index=13 ifname=wlan0 operstate=33554432 linkmode=16777216 ifi_family=0 ifi_flags=0x1003 ([UP])
    daemon.notice netifd: Network device 'wlan0' link is down
    daemon.notice netifd: Interface 'wlan' has link connectivity loss
    daemon.debug wpa_supplicant[5859]: nl80211: Drv Event 20 (NL80211_CMD_DEL_STATION) received for wlan0
    daemon.debug wpa_supplicant[5859]: nl80211: Delete station 04:f0:21:bd:63:1f
    daemon.debug wpa_supplicant[5859]: nl80211: Drv Event 39 (NL80211_CMD_DEAUTHENTICATE) received for wlan0
    daemon.debug wpa_supplicant[5859]: nl80211: Deauthenticate event
    daemon.debug wpa_supplicant[5859]: wlan0: Event DEAUTH (11) received
    daemon.debug wpa_supplicant[5859]: wlan0: Deauthentication notification
    daemon.debug wpa_supplicant[5859]: wlan0:  * reason 4 (DISASSOC_DUE_TO_INACTIVITY) locally_generated=1
    daemon.debug wpa_supplicant[5859]: wlan0:  * address 04:f0:21:bd:63:1f
    daemon.debug wpa_supplicant[5859]: Deauthentication frame IE(s) - hexdump(len=0): [NULL]
    daemon.notice wpa_supplicant[5859]: wlan0: CTRL-EVENT-DISCONNECTED bssid=04:f0:21:bd:63:1f reason=4 locally_generated=1

From what I can tell, the function `ath11k_mac_handle_beacon_miss()` exists and
is wired up via `ath11k_roam_event()`, but the firmware never seems to send
`WMI_ROAM_EVENTID`, so the handler is never triggered.

Is this expected behavior? Does the firmware need to be configured differently
to enable beacon miss detection in STA mode? Or is this a known limitation? Any
help or clarification would be appreciated.


Best regards
Alexander Wilhelm

