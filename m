Return-Path: <linux-wireless+bounces-23731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11020ACEA6A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278E33A7668
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59117132122;
	Thu,  5 Jun 2025 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="v2g90GYf";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="dRdV5Cy1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344F2114
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106021; cv=fail; b=AhM9pd6Ai2O0L9OTTpzHeXQEs/3Qz502BY/YgL58DA9LNzbaGN6K8XvEUy3pB6E6ncI2EzzFc7aEN/XYRFhyNCrtsQM/Tw7m+4KvOtoii4wCGp9MmmMXcsEYugkrdcSG4tsIK1e42DloToahV2gOQo+QHb2u7NJJyjSulIWZds4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106021; c=relaxed/simple;
	bh=dOlAmL6OMRCwTJeVu8iVqNbPFwhjF6HJtWtZVHZroLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R9577j1rD8kyOJmOfGqnpnEscdy5nFbet9RlejDjTWx6hVqO58QkzCxaKbFLDCaeyaAWRGpAyItJyblw6IzYUgzaXhfYS/hMyeA6pKTyWgT3lXqFDH6jOWurooxoC3HC+wJ/8nj5DE8JcAfjJMsqX61Bto76jVoDZPdygr6LRsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=v2g90GYf; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=dRdV5Cy1; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5554Dj7S031649;
	Thu, 5 Jun 2025 08:23:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=Y1Poc+gzKd0fno8hnRARucW0
	LAq05peb3gGh0QuMAug=; b=v2g90GYfHAspme3dJS29Ib9bhsM3Q+ZgIIsLxW7b
	xr+i8KgT6xqCBjcrnNQjDx3IEozqu9g04scmXwjraMRZJmfeUWMGs53U4EEYPBBD
	KvJZbzJdToGr04D0fkV1bcOBzStkZn+fTCsAONav0ykmfprolmJkqJi7q87laIZz
	EZNdg09CWiZ941ifPpTkcRDbWDikTCmnDKVvxxfKSHGNtWe63ayhDB5z0vlAdqhL
	lVOnbA25J1bcjcmVAGwJWecakpKwsSnhYcbTLyP/STgHIzEniSewV0/gJZZrRPoV
	ZNiCHlwF0LEZAPqhGhx6Hi6T7+y8vnQ9//x9K5BMYPFn+g==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2111.outbound.protection.outlook.com [40.107.241.111])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 471kn3aeta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 08:23:55 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lllikeX0wnYMmRHP2iVhJQU4mIy8psWUYLgEx55bRl4bI5SH8cg9JNdRKUXWQ+1c1I8z5/YIUemnLd3Ypmw6fA+9fS5bhOnU4mUq5RmNi/TxrwBtU7OlaD+ueRUMSE0T4FZFLlE6sIdjIap9sWB1aFygOYI0fCpoPInwOchtpUuDcjl+J6wq/elHwxBmWPqoNeYJCvxgGldS6qGGRkM2SNIFrOlvMN9neyp235nwJKwWSfdL2Ouq0JicxAoSYVDDTy84VPBrFvwEGATe/nckvWqKFmoT3RJM9Gh7ll13WQdNSM5N5QGD9zb6HfJAoarBE6WtXUtiGFrlZA//3wUHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Poc+gzKd0fno8hnRARucW0LAq05peb3gGh0QuMAug=;
 b=mQGC2loGBTibfV6G+vhiA9kcXPSWLQ4ZaosuLGH1UvO4GzIZ3t9PAjSKJOz1j5UMNMKrg4puEU9LPQBsSzKr7ePl1kGBSmU2dijT641Bo/sJ8mwC1cyYC7Ff5NjtP5GpI+1jLGYkSjDqBB/ydx4VpFM4ZW7WGgq8dlaukWhPSz4DIBGgajfwe4z7H0zUyUfONin0IMImctj7uzRBqnUx3cIHrDKam+v6hA64MoBxF4sIzKYG/8xWW4BpFPWLhCZGKvgMRdX4cGujn7P/zjkjwf0v0NvF3Jkl4YazTJx2ODthH9MpjhSfWZytR/dG+pOVV+BAwFHyOggRavGctc7sYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Poc+gzKd0fno8hnRARucW0LAq05peb3gGh0QuMAug=;
 b=dRdV5Cy1VhpFLtvKxGMVK7MBLlbob7S8BgF/GAd57IWWXG+s9xm0XblIRgC/3a8HURgs0UnS/KvBBMi7Y7q+OS2ZjPMUIyfJHqrKkxCubKVQrjDRwtEhLexkCI2sfAIWPt0oWlg8j0CtRo1AVaMwbwCysSQUywWz5jXeQDa5LOQ=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GV1P192MB1690.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 06:23:51 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 06:23:51 +0000
Date: Thu, 5 Jun 2025 08:23:40 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org
Subject: Re: ath12k: big endian bringup
Message-ID: <aEE37D3hvlJmcN5E@FUE-ALEWI-WINX>
References: <aD8HK4Iagc99skN5@FUE-ALEWI-WINX>
 <ae1215c7-5ea6-447c-8c07-5667e13dae89@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1215c7-5ea6-447c-8c07-5667e13dae89@oss.qualcomm.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVZP280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::7) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GV1P192MB1690:EE_
X-MS-Office365-Filtering-Correlation-Id: 752b05ef-f30a-4665-26f7-08dda3f989b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3rqALoYYi3jtlwEZbU67eTRJEqOvYwwrbMsz0V0d2Ya22SZdiTEZpqe2ex7?=
 =?us-ascii?Q?5jRj8PmXTeYPN+KutZNnE+UNkmwp+rvi6JIThC4R91cZUHVYVL7sxM4gALlg?=
 =?us-ascii?Q?W5LZSpUGUMYmkIOQDtyiRxFREaw6WBKV5CXkjK5BsSLtizH7Em+jwyGNqB3F?=
 =?us-ascii?Q?Sozx7N8qb69p1Vi452+EC5Dl10s821DOGkjqWLYq04kZFbPoAepTqQ5cSnSg?=
 =?us-ascii?Q?4XLGuEUjV1iaEa9zPX5lYmkMcF/TWvMgrB7b6x1NGhdwhy8aG2q066cls1fn?=
 =?us-ascii?Q?xSviS9TcxFJPk1jt1nz0RWOCSQlHK1LVhzKNwf/NXrmJJUCoFBQPOAs2sQwH?=
 =?us-ascii?Q?hHi6ZOMqwUmk1S/bZdk5XJMdSJ+/hQd41jQogvrU+u6Q9yheIGZjGv1p9QFS?=
 =?us-ascii?Q?EF0Vy4xkN99gXDWiHIrr1kvMvX2dtNhkECck9qgLFAl5KVgKHNRTZYBy0k68?=
 =?us-ascii?Q?cJJpieKTpAxqbzeO+l9ZuxdoKAe3/K5Zg2/6d6rFKJajQKKdaBeE0/9S/8yY?=
 =?us-ascii?Q?wCaHZUBL7oJFUfXTUiNqi1yifxwiiuZKyDZm4GgxYCXOC6A+UsaBZpVL7g2b?=
 =?us-ascii?Q?KYFXorklj9edIPGB51lNU8iuqV8Own2ADzkQ57O0SmSReL/sjetqrOsirzgo?=
 =?us-ascii?Q?hJoaEgghKr8YJITCXORTPGuQpmChdAPUp5Rnsz06SzOGjsU8/QZQ5z1cZ7ke?=
 =?us-ascii?Q?XLA9ABSZB17U40gsg9P2elpsbSjNUxK8SB9PyQPN3A8/c9HuqCJ/SCcl5ilA?=
 =?us-ascii?Q?zPAnY0wtp5LCrJBtC8cAcCI4FMDfmi+4seXnV11wl9UKUdANCwY2vIHUlBpp?=
 =?us-ascii?Q?WP4PCNOutzuh0vn9FXr1ERkREw6FLbEQldmn0CJrupTEGaMYA3cFaHu2SF9Q?=
 =?us-ascii?Q?4Mo6KM4l8JCS00d2WZer8MPxSaKILQVJnaNwtIGWT+/sfabfioq9jKaXVpld?=
 =?us-ascii?Q?KTwIt2qQdHWm/rFaIUtVnsGmQeJrVRPwl17uHeec7lXI8Q4f6YYLsrx6R0DT?=
 =?us-ascii?Q?tcRKbwr/dRh+R8tTTj0/ICiFOXG90WnGaC/9iKR327U6z9+WL3NIIaslBrGF?=
 =?us-ascii?Q?wmfEYCGh2cm858nRodhVDV5dxDVDmV8nzMANFwqVyS12NVJVvZXmo0+q6GU1?=
 =?us-ascii?Q?Piz23lN4s7YdIGHalqONh1F5508LBIZBp/WRkx9QeZ1Ek8UdumvGyJ7LWq0G?=
 =?us-ascii?Q?Tpvak/a2F+FZFFe+kRybJIffWa76d4HN7Ri4VX4k7MkReYBDSioHB7eZPOQE?=
 =?us-ascii?Q?E31Avxg7zgpIJgR3HUAY6lsm+FWCefTb6ES7SR0L2cJkWstv483U2rixgmq3?=
 =?us-ascii?Q?vEt4M50FCh2BW1btj0fxCFYnS07dvJkH6UsnUSmyRPEuI4PrjqAu4O2ocry/?=
 =?us-ascii?Q?mwh/akJgdFZBt5A1H3pEIeRimz+mxBCkSsaNv/Q3tChDIJUMeOhIKmWRIhNh?=
 =?us-ascii?Q?HUATkWeHI8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ihJ7IdGYPzzf4sbhPLgcX2tWKFf3MYc1CIG2Q+84Br2eBorcIUWu/dUCY9wY?=
 =?us-ascii?Q?7MMlcPIXnWgVkKzpl40/2KezN3VZtu89fDgGxWhSzab3Lvsmi/z87ezeOSOm?=
 =?us-ascii?Q?4KGs1OBDilLb6UDfzr0M/rJed1grs3QyBGnsZuP+PzmQ1DVVST/rXqxANKch?=
 =?us-ascii?Q?7lo2RqkgIDTbqnp52oC+OV/mGVecNviC62wWnKrNrtL9ozMru0Ojrzl2fxpe?=
 =?us-ascii?Q?FRlc9tx7+EpMtP157bsNhrVUboICmYg4FOASGAel3k4BXo+4i2dr3YDfTnrn?=
 =?us-ascii?Q?YTaAC5/uS74PzX7LhTCWuPWKNHmpKtU/DQ5wSLR3pMkQV+A4ejihoWKqzlAz?=
 =?us-ascii?Q?IaTh2iT0fbXaashLVZ5Q9PYtByzL/mVqbjRSPb3+ktCLM2Fi+aECx4yFYWX/?=
 =?us-ascii?Q?UOB68oCViOhAypfgna4dT09ItaiXyCg/2JUYZYFHKSLpz9Hgz0Qpic4ap411?=
 =?us-ascii?Q?HdQFRx57/DP1frQntaem+eaKePa+rMD/WET9vTRG3Q6U2bBGA+KNOFhyxWIm?=
 =?us-ascii?Q?oM8om09sAMIurPdWONcCM4er3iAy8vb6DZA6EQatzmwRvoU7sslDvfgVR8zn?=
 =?us-ascii?Q?G4hcyzy4PZsMT7NrqkSGVrlakWsQUkewNdTtwzzZzUG2pPdq2Kuw7y3qdK1e?=
 =?us-ascii?Q?ncsvWA8QahXW7NCBD8GxKDNI1fhQ92/6APygM+ZeU/z1yWk9WmiERA1SWqft?=
 =?us-ascii?Q?kJ3hOtz9/MYDi/7k6O0UkAaQKx+FKe8eB+HLBbMV4aY5ASMV6SEF/HxwJ7TM?=
 =?us-ascii?Q?6ULUDRNUS+t25QOAYAh+0WPXyyxddISTxCwMpo8ZHPYxUJxwCqAv+yVspdS2?=
 =?us-ascii?Q?gdrXhUNu7jcIGuIc5AjVM6Ut3ySTjUAJD+MdIhhRvEtCl88sSWINKdhrcS8+?=
 =?us-ascii?Q?ynPyQVt9fpAKYwcLue/OWYIAYIjfhG32277/s6IS7vjnFd6jUf+VVYfBXsbI?=
 =?us-ascii?Q?l5mZh54FOGgUC1W56wScXJ9T4ODAyT5PzbRLFzFcVxSMGhyaYkhaFrNt9Zqe?=
 =?us-ascii?Q?59jcOHKD9bdmlb/JwbogeUMi4Jdd2U05fkQP48d9SbXKSFf3zJbJif0OYEWD?=
 =?us-ascii?Q?m4MCet3TMJTYof291QwG7uG7OlQ/h+RhhJKQZ7OD+Ew8t5gy5QijhQGHlHRs?=
 =?us-ascii?Q?5WtTDILh+pCHC/p3941JaVTRbblamBHaTRSebiIL0foMlALRSDWURV9qlEiF?=
 =?us-ascii?Q?pDkogT9qtXkxjm4x/DPMR9IUPvFsx/SXXH+73YZXfx2u9XZzaSJm2LmCbkdX?=
 =?us-ascii?Q?3zxBTYG5NIcppAVHwx9z/gM276ZG60tMGjLGKztXvDTjZyBsLKuzX5Yk6V7q?=
 =?us-ascii?Q?lUjPpY0Qm/cQtyAYo/Pn367XVtNo2JOUCN7xmH0XbetPIQx5k9wOkl9jC6FA?=
 =?us-ascii?Q?iArzsCoTPKjt/FOcJarAuRJMpJUEtCwvTfMryzKB50RLUhxpwdLavfyv+h8e?=
 =?us-ascii?Q?f3Vb+D6dwMYsEE/s4HukNeyT6atP4qqu9oafcxsHPwVlZY84SbqdkpYxAkC7?=
 =?us-ascii?Q?hhQr9aZazkJ2OD5BK7QZb0iWNkdnqcAUFG+dwUmJml17w/sglFSLTD2eYIL1?=
 =?us-ascii?Q?+5uzcNaRJcmL5jdbmuJRwvLpECxvnie8eUJb086D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4JgYoyPzbXq+n0eUHTQ9w2cvvUoNDRITEXqcX/4ifm5Kx/xGo64N4KeR0r8Gxw65kYEhZjOYA+aerArDlX3d/ilfWq5YnmX7/60C4hiU/5ntdcV4LVx7/dNMObDkPbL4NF7nNkDkd6/PkcuD+F34OX0QoYYkoWlr9RBjT51sf6UhjC6zmlq8uqxfDAbbeOAaBdkFjN6RjBKTC1yG/OoCzIxJhabOR7q57ET6EaL4tnQnZ1i1dbzMcRi5vE9EhUzm3ncfxb8cYpJoLsob9zgBi8JhHl/VbA2s/0HmeNMlgt0VSyDRIqzr2cEHCD5NOADBMtXOlbUbAIiVxxT/2oaLhkn3Yt2XVLIZt3Jf119weqLbUCbQ5sfGU9m7WOm7Si8yaQvqHzlUTNmeRlzoRlQTLwD6Fr5TBgDb3B7rOT/2U7gxjXOyE7mzSzpBWHOIZZX9xOlx3slq2LuXm/6kubyFgKiRkbdCxEM3S+qJFpma6Ty0dABpZlH3AeQUQpQfqvFn3Pidf5V6Rf6jO9ERkoLA3PCF+7p5IP/evNva5rLsAGPsaM7uSdhia+UQu711ZP2Nmr/txilGG2ZrMomewEJjzXWqNBpwPA0KZ2T+vvnXAjq5BoYTJvyNegei7lUYp2z6
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b05ef-f30a-4665-26f7-08dda3f989b6
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 06:23:51.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgN/mlRv2yXWDhqOipYbfpPe69KcVRB+xfmkms7gPihg2tWZ53Ai44lU2bD78pszYx9C58sbNvG0AsvzJU9pMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1690
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
X-OrganizationHeadersPreserved: GV1P192MB1690.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=IrYecK/g c=1 sm=1 tr=0 ts=684137fb cx=c_pps a=Ai8SrW5E0xaLXO3EKqmJtQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=8gLI3H-aZtYA:10 a=VhEJW8w1d6CAEVDqSv0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NaWgfvEdYS5YYXeDHjr4Z9wsSl7L4avS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA1NSBTYWx0ZWRfX9fPHTIGxBFMy CQ9RkyFbLSygKv0ZqySgFvtJdEPD6ztRb0cTmeIToCURfJ1OcmbC4j+jcqz1GoVrLVfzqIKIDEl CrwdDtHDhoNowZ9fNEpbltzaAP2hV8JsPTmbUcH+4bnKsqLeWZjhmo07PyIbW0TNneOjHcF9UiT
 uexNFkHchqdwEQYs3OirKv6J9ZxzqMa+zMDB4U3bYAXiRrh8foN/YKUObYqBnI2zJI7RLMIGg70 4yVzvknzVMZg44RfNhw3ePRhCki7YnD5h/jfPeXqa5h1XBdE7BE3m+nY+m/+B1MdoR7a8awg4Yq vWajUz4hHYrUfILE1NJ316slLECPiB9tXlbDMqJBBVXsLhQp+jvF74lPgfBLYA+5OJ0G5sov03q
 4EAG2nuPrVOwAHUyOzXJhz9B0w48FBV9ubBn4e/Uh1HuA7oCTS1lHWBWafJel8xWI1GBhKm2
X-Proofpoint-ORIG-GUID: NaWgfvEdYS5YYXeDHjr4Z9wsSl7L4avS

Am Wed, Jun 04, 2025 at 10:30:40AM -0700 schrieb Jeff Johnson:
> On 6/3/2025 7:31 AM, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I need help to bring up the QCN9274 with ath12k driver on big endian PowerPC
> > platform. I've already found some issues and fixed the MHI start procedure [1]
> > and QMI conversion [2]. Furthermore I added some endianness fixes on 'qmi.c'
> > file and could successfully transfer the firmware and boardfile to the wireless
> > module. But the firmware does not start properly.
> > 
> > I'm trying to analyze the error and don't fully understand what is happening.
> > While 'ath12k_htc_connect_service' I expect a successful response from
> > 'ath12k_htc_send', but the connection then is timeout. It seems that I should
> > receive a message with length of 20 and at least I get one. But then the driver
> > remains endless in the 'ath12k_ce_recv_process_cb' and I always get a message of
> > length 0 from the 'ath12k_hal_ce_dst_status_get_length' until RCU stall happens.
> > 
> > More interesting is the 'CE_ATTR_BYTE_SWAP_DATA' from ath11k, that is still used
> > in ath12k code, but HAL structures now are swapped in driver itself at the same
> > time. Is that correct?
> 
> That does NOT sound correct.
> What happens if you unconditionally keep the BYTE_SWAP flag disabled?

Hi Jeff,

I tried to do so, but nothing changed. I will verify whether big endian platform
sets the 'CE_ATTR_BYTE_SWAP_DATA' bit inside of 'attr_flags' at all.

    ath12k_pci 0002:01:00.0: rx ce pipe 1 len 20
    ath12k_pci 0002:01:00.0: Target ready! transmit resources: 4 size:4096
    ath12k_pci 0002:01:00.0: boot htc service HTT Data does not allocate target credits
    ath12k_pci 0002:01:00.0: Service connect timeout
    ath12k_pci 0002:01:00.0: failed to connect to HTT: -110

But I found the problem for the above log in HAL. I set the '__le32' type for
the 'ht_addr' and 'hp_addr' from 'struct hal_srng.dst_ring' and 'struct
hal_srng.src_ring'. Now I am one step further and have some capabilities issue.
By the way, maybe you can help me here. The function
'ath12k_pull_mac_phy_cap_svc_ready_ext' differs now from the respective one in
ath11k to overcome the endianness problem. But the following lines are
questionable:

    cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_2g);
    cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_2g_ext);

The same for 5G and 6G frequency bands. But it seems that the usespace requires
here '__le16' instead of '__le32' ones. Can you verify that? Or maybe I
misunderstood something.


Best regards
Alexander Wilhelm

