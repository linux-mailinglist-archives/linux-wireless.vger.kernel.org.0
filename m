Return-Path: <linux-wireless+bounces-25516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDCFB06F80
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8561A60869
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E06029992A;
	Wed, 16 Jul 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="z5dDIjdM";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="ia2w+wn5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857D298CA3;
	Wed, 16 Jul 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652299; cv=fail; b=e705O1/N5ltVCh12Q8GuwjKjeZ9+YUxHrpzBQdl+6H/lk1haHQpNznR4rznC+qa6Al47vDUMB9Fe7O36KH7MBnqiTPxbzi0qoOWiT47Vd3dwa6LK/90cDn3IJ4AvjA8Oi5+YCZW+eu2Tu5fRbxsQKRw3FeBEDvB8cxHe4qQWm2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652299; c=relaxed/simple;
	bh=HteYkjgGa8F4V79/iaYbEix3IHxDkj/HM+xieo2JsZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8Ehp5dt8iwwIoFFoFzbSp6Kn5LYMVvvscklYt+TyWBxv2+mo9WfVdW71h0EdgwZX+RVVVgrZ7J6U6qXEfXbQnD0e8oc3QNyzavI5J5WpZUF8At3R+IxtqEGfB504NQgQwaYdeSUYX/Axqe0XZOzGdqFR2Hsk6cJCPF5mziomjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=z5dDIjdM; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=ia2w+wn5; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6bfO41892067;
	Wed, 16 Jul 2025 09:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	0iIjpjSz0dQXtwsERtQOohmNc3JV5+eMXGjRIHFQJdU=; b=z5dDIjdMfTUa9Xad
	nIRZrW7+PSl3RfEydttNNqB/rQnMCv5rT+Enkg0M3VSgRfT/vCtfHZvkDoyrZLD+
	BMHmnshMBypJQydJytrhRGESaFvn2QgdGBiwn+SIMC++F36bH/ENQ9scewGL0Fdc
	+cOnqfe8WPSJKJbAlySVVGCY7SaW0vLmz+XNzc++CtV028W3UZWDrScTvrYb7Jkg
	KYnDnqo9ls4qrcbY2EV5q/4NtZ7O+H1dsR8ZcJqupqd3XLtIeEptq8qgKyJEDEZM
	zSSJHBxaTqz62ZbBsUSjUoZ1MOUptrw70vqkQaYkz6ifz+CGdvo7/1XPvFDFkVyO
	DX6KFg==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2099.outbound.protection.outlook.com [40.107.249.99])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47w5js9rdt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:17 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p83IDASxEAIt9eWNP06tvu8QBa3vK/HdVvGD57sa3/vO6Dus3NrWAqA9vuiDj+hGeQ3PQcYHygdh614ymehZ4ja7VPixvCDjRDdFjImlblutfljtuVyxV2kB3GuXlI5T05IMfmd3DYvNFAc2ZDHwuogCtjI4wpSuV9VXnX9Ti9WuyvwZVJibkis8IhONnuZsEh0qb4ZeZBaXz/e8qLoG6FKrjODk8PVDeoXpd280ht6L4Le1y5z0GJsw/CpVw7vOaqJTfiwmVjufIc4wppRX1csOggEhOHifY0crPqHfv2foIvAdTDmiitvre/HCwq1SgRGbHPhA/CzN3SXMVK/YBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iIjpjSz0dQXtwsERtQOohmNc3JV5+eMXGjRIHFQJdU=;
 b=IS8ac6LVip0HPgNean3KjHBEAqMvVBjpd75O6ffmCVK1hp0Ob/3RnloPc1sZAIofs+EeCcC7WuIgCjxZhOX7Bpz5UM9BtqqjrznFBMY28mzN2sSnMwi9HblmKZ1eYg0r6UdZ/cvIYrpbXtRIgDG6E9yfL8jyribtgba6SflVdjBliUtwy4nWGKUvGmUhSca1shIgCd8HyXT1UpyqKVV0XIOVncMusntDDMHJFzLjquapRgsb8cjEbDNTzWHMulZYIHOBGlmVm2MLNKBwowVkj0eo6sq8bSVrV2BlaEa+p0uNDvSPvtIAwUr6LXgZSQZlLNbaml+hmjqNkOV0KRioBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIjpjSz0dQXtwsERtQOohmNc3JV5+eMXGjRIHFQJdU=;
 b=ia2w+wn5udCRSMfdh05UOO+4bwmccWQ9cFTRZSW8/lLZ/QZEkobKk57lJnPe23+9S4HXBRVggRw0NV8eLKR08bTlFsrWU9J6B53xncxvzHuhV5zCOunLTxQ8bt7YyxO7AEBbourhBR6hbHXpUvGjzSabDEmWNh+rYQZhRX7s3kE=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:15 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:15 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 04/11] wifi: ath12k: fix endianness handling in QMI firmware memory indication
Date: Wed, 16 Jul 2025 09:50:53 +0200
Message-Id: <20250716075100.1447352-5-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::34) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 692a462f-ebf9-4f23-a7c0-08ddc43d8a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBwrbdRqHRZTRERvL2E7taMPFfSjTxEm6XJ70pzGoDRIintFcLeft+TUdz10?=
 =?us-ascii?Q?ycry1vR7Pg63XmmO2bBpyFKWaQbHiGUrCf1KlLmcowKHFDN9oS4pQTcaTGn8?=
 =?us-ascii?Q?N9dniVz9WKGry7WHyPpmysvDDT8QPRGhNZbiB+aDgzkyfODCp2+MR9ibCWDa?=
 =?us-ascii?Q?PWe0BQagTIT9M3oO7KYOOqrKczwXCwVdYC8Mqd/Ncf8mHWLM+qCnnLzdUw48?=
 =?us-ascii?Q?ogbSPDlyHCWs+cpM/+SIwiNTH8k1zIBvjvSNes0OnqgjLM7mzqsumUoEJ6e+?=
 =?us-ascii?Q?zqRE0RD/oy+yFkotDMNFtS6J5qB7NdXiaHvM+sWf6Jmm13q0akU6BKgSP7yF?=
 =?us-ascii?Q?Re4dXnLvtU+d1fcUA0xuxN0KHJKt/e/ebIuLzDB6dCKLdJ/T5FTLdckVcW/z?=
 =?us-ascii?Q?KZOehPmmbbLjK7A9ysqdQIrk7+YznTiSgSrxxWmlDyDgAVDIg/o/KijnrpN6?=
 =?us-ascii?Q?eyYzwNtuyqQkG8UFTM/n0fKOEDvb+SvrdPTfldyVY/IXwKyZofguOeIUNtoz?=
 =?us-ascii?Q?XKAtNFxPokDyR6UBAAcwV8DZAyM8xvBuTK2ee28se3uCxuF5mXN7Wq1ioSKa?=
 =?us-ascii?Q?BL30WqQyX8puvOieUVNQ2EeS72ObQfZIO/sLWZwEytzjwKGtHUcZWsOkcXat?=
 =?us-ascii?Q?qI/UpXquPvwdUfS0lr0nh9LhOMRBrY+hgpwaB+TFqiF2Ch85Qkz/9agDF5/w?=
 =?us-ascii?Q?Uni6mxdCvU+AlAjf/Z/uAn7pFRd9w6Q+OAAzUUxoE23Cc6YlfLyoTVEufYex?=
 =?us-ascii?Q?zseYlCHG9OFnSI8/DTZk6UOsGnbXiHHHDFnR5gYXvz//K3bttwBG+58lr/Zb?=
 =?us-ascii?Q?mJlQoUPS+Fnn8pawAs6tyvbsmYw8pthT7pIfSutvAaBa3KyySNaTSqFZALzN?=
 =?us-ascii?Q?KTpAsngRo3VQK7FZ9ewchogILyUk4Y5LxISmIxORy2OjEqIjuaQ5GvtbCJ6T?=
 =?us-ascii?Q?n3o9hw3Qry0qWMJvEbdxwUIFMIQmDrecypJKSnbQyLdXx2EQLpW2IN4rCveS?=
 =?us-ascii?Q?0Z4whPF3DjloeQ8+unmdPs9TcD6E8X7IhaqyIxL19qo6C0eNwRmkGWxhhuur?=
 =?us-ascii?Q?m+CUsLgsNkk+eyycsihLrULtW1qsMNohvT3BVAulPu65qRQt3RX5ftq9mvoY?=
 =?us-ascii?Q?ZqLn4cBDGeoxRzhPLeBeHwY88r3tKIjJjXzaU7eSMdiYQ9sJMgg7tr1KLJv6?=
 =?us-ascii?Q?HfxVQVYC/YB9xivfFl5DZDFdZfeH7czh+eGpHRdwmt9YDY/1BQ2II8/uUnlS?=
 =?us-ascii?Q?LaPcRUkQ1M/m/0vaCqJkccq/UBDLWz9ueSWS3isla7EjobUfcNmENNzfoEbc?=
 =?us-ascii?Q?2YpIU3cF2t1vQs3nF6BDRAjCLTYg1vLVt+W0yChyHKmquUZP46Y3gb2OsvLg?=
 =?us-ascii?Q?OukP5Hq/gakF+yHwo4jo+Ze8pncOJaoDmbpMms6yv88c6jpB9k5In9ujVj2O?=
 =?us-ascii?Q?FCtWftaeekk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4mSYQh8Bdr6YambQr4L0VAUt6un8GOt+a1nJ4++ZT8p0uHrFMQWvvNum72K5?=
 =?us-ascii?Q?4uNKwvItrEzUL4mRdX+HeOwbJjToFKu0OX1CTXEli9LN/G8bJsYRBFEdoApk?=
 =?us-ascii?Q?o1dYJuO045uxQv68eLnRxcSyCrTAl9Emhnwu9wJHCZ1W+F1SXGlJ3SMXIvIv?=
 =?us-ascii?Q?E/6sPRuhQz55brbjiSwZW6jlI8xWZJb9XJUbWe+KPBPxR5ihnVyTb4yYmh6K?=
 =?us-ascii?Q?i26nylnFFyOLVHmZoxX1f2t68VSgMCISD6L+A5RDshmdYP0WX7q3Lw2flhZn?=
 =?us-ascii?Q?IJd3xYsjcGE5XinGv8rpU1gg732RPAwEejIvMliz2Q399IhdcNMJ4ImtzNNY?=
 =?us-ascii?Q?PCFvGA/sGLJT+7OLEsj9vwFmAK3+738qSlq28k/lG+You0cmhO1m3znfr+rd?=
 =?us-ascii?Q?o7KO79+uGiuPaU99jXDGo0uwWHQlv0whgp4urctc3toa//WsbBDbRzFn9y88?=
 =?us-ascii?Q?8x78EB0wjk10j+ypXAeyMBdfrrg/RO1jpxCec0hupJPHi0sGK5Ls/KXNJ0Qm?=
 =?us-ascii?Q?3rkPsexkeezDCWV4+jN7RCGPZEMVS3Can17yUukqabAEiKFTMxGP6aZJtald?=
 =?us-ascii?Q?V7u1jB8LlpKBENTrzm9CHj0sPt4j7c69Ua08rDby6fdSqIfLk1aqEMMMshqE?=
 =?us-ascii?Q?1A8rOOSKfYPGmw1c8ONk2ZoWs4hUP/Gyq+OiWqEJAG+pY/NNpx13Wdm4FAfE?=
 =?us-ascii?Q?QIkf8rguBvhVxjhGnUjs8P2aIFkbIwsHtze3RN/bbckZOnlah/nlT6x/OEQh?=
 =?us-ascii?Q?EG4w3sk+BwZ0AySSU5Wjv65VyjwfhSQpxLaNIw9ZaS0vKwcYrVZJ3xzATlcW?=
 =?us-ascii?Q?tB/1qkX1Cu+r9OfHbRyvYShaPSvzcqn1a3pJzK/1bqxOEeFTujTp9fIZGTxq?=
 =?us-ascii?Q?NdwewC5dSUttplKt+SVjUo6QRXqN7kdnHcvQY8J8FFPeZy4C6PDjQ1gNWx31?=
 =?us-ascii?Q?zDyeO9+I38iXKEoHDAwKP5COkXYQP0WiAoqiMnP0YnCt3hiogT3hEttW5pvn?=
 =?us-ascii?Q?dC5codMDSRpviiI+1M9Vd1Ka4lZsN/Sv/DLPdvGsmbcukapEH5iAdqtmWnJd?=
 =?us-ascii?Q?gapUWdgGzzlzy/y02gpypc6JGgL9aGlqHI1yBQqklekBgraXQhmf7RLCxgGi?=
 =?us-ascii?Q?yFbDlyNm7Wv4oiSvziCBpr1m+o0It0Oz3vxafeyWbWtCrqoYB2xwbrZ2l0LK?=
 =?us-ascii?Q?CZ/xkfwjOsp+c1u6qw9Tnxvk5dG7QPaGFcT4FUwzLJlfL4H7iY1QtC5dFC2e?=
 =?us-ascii?Q?/ybneSx4l+iGz/ulJP1CaPdYuXQhU2ApejDHQ6lWVNjpQYBfvdE6R4EQD/9W?=
 =?us-ascii?Q?eQ1x7pgv8QiLY92iTInwrLGqbY98AM91Qp+y3xqHw2t5RHGDWwFnD3B/pDoQ?=
 =?us-ascii?Q?BN0sIqIpTp0IPosEaTvaZ7oZ+fkR3jdb0zx3O4S4hX8DNxGuUAtoVzIPx5dg?=
 =?us-ascii?Q?NmhGExb9E5QerSje+cifZySOBCTf/d4L70lqvJGjHl9ugQeav/Z5tVtQv93K?=
 =?us-ascii?Q?Iq+5CM/XpPvcogiR1CUrbCUBK/e1K4ox+JY3UL//M5Xn7873uCL2PFfXWNME?=
 =?us-ascii?Q?uMow/cJz01j2uuMKzxIy7KfE5yhBEF8TaGhUchYS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WFd+0KJK4Tyn84AlZbLNhMeiBfwj4NoU/eGX9s3cs76VQ1CfrAK4ZuwCT5Nx2pI4bvgMNRrMjdNhz9XpHbNOyeJ8dZXzWGO60Tagewhps7QjcptK1ZHL6arSOQT1hxejy5SCerpqZoObgrsuS6C0mvikvxmeBZMmupVPtq0WVBjcPGGsDp2qcsrUlV6eljr90qJO/Op7IVuY3tHcTDkqTUSCJ2PL8Ycyfo2hJV1Xj2SEhkNiyE4AwgR0tMZNK6xotJ3pn1PBDo1gp+Wl6cjZokI4dbduNIMRJs5vkJ/xYI0cW7cZ4U6m267w3NA5KEl2VLUCYooB+RZlbhbMKSb05qyVPtgTpwMWLdrkIj4DcnR2gnYUJ+iEBDjDBbnM3Rxz60i556MupmEc4w4B1OdEyv/GbKvH9RlLF9sYu9m6SDkDCXne2OeK+r93eNifYCrQeeRAahf2I1SJ87z7zRe8HCsj6AwATtHhxqWZTfPQ7wyUM5T5S+MRwdM2UAmMDNJNDCFxe+yrfcJm0LhHkb3/UUHXlKXua6bq2y7FHIhlrlMjHU70rZsLWK1Uj+RydSesUrOM6blsqHlIRE0FrWaFoN87XoUImtxB/nG04bmPARPuemSqeko6rXwPWA2aG2zT
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692a462f-ebf9-4f23-a7c0-08ddc43d8a74
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:15.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1js3kk1YY9EXiP40+H+e35GmDtHkvBUUB68Fa/QiX7LCrwarrYDM7Cd3i8JYx8dw+6Se9YrSC4wWhXoxTUgXAg==
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
X-Proofpoint-ORIG-GUID: t4rFCK4MhERY7N5Xo37AiX3w8V-zUBnq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwMiBTYWx0ZWRfX2c5F5fpPfPjb
 /WbxHSb3VzqN0/44JyNHzFJsEC/fPSdaEophf4yjyQ5bRtgtPx5bL+Q2HD2MDSn6i+uw9I9axUc
 vy73qJqX1elzBqi8pHm/NuDu7tC5C891m569h3ypVRu1fB4nUz61uUeDKwIMJS353Smv7Z98E3g
 hBMWmMc5DI1EkLfOZxbVnSG8uGcRkehMg5w4GQTIJ+11tX43esBv5YSYd0rFaKYC4B9bGw6M624
 APGkhD/U6hNNuh8KXIicplIaWdNW1kdvWTlFVsdyYes+ioDNkbyFZpn2bQ4EqyQoTNS73eTZwzn
 uUdqWXDv4byH8PfS9+s/SD2ORqmBnFqalSGG42jw2K13rQYoM5hf3/9LwdNzaMCar9mFbcGDPyk
 JA+PA/D0
X-Proofpoint-GUID: t4rFCK4MhERY7N5Xo37AiX3w8V-zUBnq
X-Authority-Analysis: v=2.4 cv=Nf3m13D4 c=1 sm=1 tr=0 ts=687759f5 cx=c_pps
 a=yiq0MvgY0icrkiP31sBlkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=qWzXJ5F36-o7dQhHifoA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI firmware memory indication request message and its
associated structures as well. Add missing byte swaps wherever these
structures are accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 15 ++++++++-------
 drivers/net/wireless/ath/ath12k/qmi.h | 12 ++++++------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index cf05c76cc112..146e9e1c4834 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3637,18 +3637,19 @@ static void ath12k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 
 	ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi firmware request memory request\n");
 
-	if (msg->mem_seg_len == 0 ||
-	    msg->mem_seg_len > ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01)
+	if (le32_to_cpu(msg->mem_seg_len) == 0 ||
+	    le32_to_cpu(msg->mem_seg_len) > ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01)
 		ath12k_warn(ab, "Invalid memory segment length: %u\n",
-			    msg->mem_seg_len);
+			    le32_to_cpu(msg->mem_seg_len));
 
-	ab->qmi.mem_seg_count = msg->mem_seg_len;
+	ab->qmi.mem_seg_count = le32_to_cpu(msg->mem_seg_len);
 
 	for (i = 0; i < qmi->mem_seg_count ; i++) {
-		ab->qmi.target_mem[i].type = msg->mem_seg[i].type;
-		ab->qmi.target_mem[i].size = msg->mem_seg[i].size;
+		ab->qmi.target_mem[i].type = le32_to_cpu(msg->mem_seg[i].type);
+		ab->qmi.target_mem[i].size = le32_to_cpu(msg->mem_seg[i].size);
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi mem seg type %d size %d\n",
-			   msg->mem_seg[i].type, msg->mem_seg[i].size);
+			   le32_to_cpu(msg->mem_seg[i].type),
+			   le32_to_cpu(msg->mem_seg[i].size));
 	}
 
 	if (test_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags)) {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 026dc33a39d8..92993c85cec9 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -327,8 +327,8 @@ struct qmi_wlanfw_ind_register_resp_msg_v01 {
 #define QMI_WLANFW_MAX_STR_LEN_V01                      16
 
 struct qmi_wlanfw_mem_cfg_s_v01 {
-	u64 offset;
-	u32 size;
+	__le64 offset;
+	__le32 size;
 	u8 secure_flag;
 };
 
@@ -344,14 +344,14 @@ enum qmi_wlanfw_mem_type_enum_v01 {
 };
 
 struct qmi_wlanfw_mem_seg_s_v01 {
-	u32 size;
-	enum qmi_wlanfw_mem_type_enum_v01 type;
-	u32 mem_cfg_len;
+	__le32 size;
+	__le32 type;
+	__le32 mem_cfg_len;
 	struct qmi_wlanfw_mem_cfg_s_v01 mem_cfg[QMI_WLANFW_MAX_NUM_MEM_CFG_V01];
 };
 
 struct qmi_wlanfw_request_mem_ind_msg_v01 {
-	u32 mem_seg_len;
+	__le32 mem_seg_len;
 	struct qmi_wlanfw_mem_seg_s_v01 mem_seg[ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
 };
 
-- 
2.34.1


