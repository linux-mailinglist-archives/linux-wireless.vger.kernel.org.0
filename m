Return-Path: <linux-wireless+bounces-25519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C0B06F89
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6EE1A61EA3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263B29C328;
	Wed, 16 Jul 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="QqblRVAM";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Ypd1zb47"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943728EA62;
	Wed, 16 Jul 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652301; cv=fail; b=f9+lsMsyzYAFueEEXYoGD8oYVu5HAtI/O9XBoO4siI0kKy8FTfd5t1GGyhu7Pyv9Vlse5WTbUmZglBaf42HgARJzwL0EdpoMHhlDPKid/5MOya5WwUUl7NWdjzOJRPX9K6cq2zdxr2S7BYji0saLsFk8OfuzLJ1KAcOiGfcwjJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652301; c=relaxed/simple;
	bh=HYqeyWBpq86jq4K30D8xqKsF8jyNdYBRq9CYXGvGmt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8aFQqumO8DZEHEOuxbQn7sy4TCvxiPnwOhy8p+xZBmsG4hZvuepO9ARL8kNzd3qFzN5anYANgMQBLBKWCTFVgYwbDRQhHWZPpTlmvDmnmC1anHL8CQx0e6ynhdYHGbnATfbTdnBfyL23vlBeYJAstKAjB2KksXuGaY9LjajpvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=QqblRVAM; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Ypd1zb47; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G609gP1830428;
	Wed, 16 Jul 2025 09:51:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	NXnfSApaA91YZhFCCdS9KBkFeZKXqvY6JtvBSd1jd4Y=; b=QqblRVAMkXbjtQ90
	1wA3hI7LDwoW2i0s4hmBMPjAq4cSC0U3Dj08qhi1G0LTdRHx2pTNONwjd67TOzXc
	WKlv04D56WzdpleQYqSDyh2yhQUgICjWg1PeV/MdnhNHDacWS7i4psQbJFIpZ5w0
	wEgAmQLuu14gcdyMV7jK8loitWD42Arc0Q2KRLSKc6+85HcmwlixErXJh/DuUSP1
	inUzRNl6mcUt26aV9vferE3IVNNYZeECUr9Zu3pdQ3nw5Mi9YcHxOQyo0Y+3j/cN
	3JmrMPOslTnljaB+KZHxaWJuLGiMQfZWUkDYhTKOwSSFuJAzdivyr+/CESURi51h
	KGR6QQ==
Received: from eur02-am0-obe.outbound.protection.outlook.com (mail-am0eur02on2091.outbound.protection.outlook.com [40.107.247.91])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47w5js9re9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:31 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhQQchvtebkuEDsnJ2LTJEl5uXQqvY/ccmu5JhdnFYHz0j2OunvcG/pNJaGlZL3jqhqcGuBbT1gymfp3dLOYYo6PrwjIBhVT6QFn903Rq8eM4Pw7yseIIihV1eqjju18lOG1i4/YPzCwikFJX5c4THm7di+cjjmuPK9WpKYLgUhnZIYjml8oNrK5Xd7XQ9O62pFvsCUFQKqBaJH7wd93bghSQQH/5kdF/lkhCCjI7Fvpl4ylz6SYfMsP6po+Id/78azTEx/Xs+ntStonTRn595w0SQAP9hnGFyLHELHoJImfFeiiBO/8DdBOZDjq4C9tptgQfqHu3gHr6lx2JS3W9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXnfSApaA91YZhFCCdS9KBkFeZKXqvY6JtvBSd1jd4Y=;
 b=cp081SAX73KADu+1Q1MvyX3LiaSSFm6Hv5sNaSeN1+ZQF9d3aXLnqmTRfOSRHubT43xWOUBLByyorgTTuFJosHhKdG+1xreuZ//wuky5iJFZTwTWK5BISyrNeyeq3haEdRAyAnvUYnw+4pXJKrbTWKvLS87PPcehczrf8ESUlncPqHGnEti3ZiYHsoSM/cHXdljdr4zlxLh46aIdxitqgFsZqCJhTZdO9tEX6DUkmPeFtOeYgNEWdkb46+CCuayHv2Ok0kEMOIU+Ri1NFs8w0U2skZ7c4VGIegfkUZCYQ3zIQe3nELUuFJ6tAsvKZUgYeb/7SAcK3rmU55vbp/PO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXnfSApaA91YZhFCCdS9KBkFeZKXqvY6JtvBSd1jd4Y=;
 b=Ypd1zb47gR/E0YahhpHO6d9sDt/TpT/9fGYc1T03cSTCgfl3XnoKNRzwMNKe0gQgDjThUAaThdbIo8eb5R7366uEJ3Ttihk8lLnvwsiEARX9AGmKiW2WlFrU3b62MT/7hOLYxpsSbOXJD7dAtEOHemRv3E7ypCVwCF0ytWAB2Zw=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:28 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:28 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 11/11] wifi: ath12k: fix endianness handling in QMI response
Date: Wed, 16 Jul 2025 09:51:00 +0200
Message-Id: <20250716075100.1447352-12-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0056.eurprd09.prod.outlook.com
 (2603:10a6:7:15::45) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: ac688b80-b945-4136-f710-08ddc43d9273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9IjZUPnp4Tv2dLoDv23gTM6XGDkL/XYvumYUpK0HTPE++4+vRYD2R6gnWb0I?=
 =?us-ascii?Q?BKs2cwSsuozebkG1UPB/gIpE+kzo0y+zc8jCOfmmy1NSlfrhG7zMzPggk2WY?=
 =?us-ascii?Q?pe6TXvXrSiPdyUyJr7lhWhPfanI+Eba4FgqMORuSZmKBFyHBtIEqBhWhptaj?=
 =?us-ascii?Q?J7dlL7Znjt57h2r7+NFjqlHE0qFODWjhEpLu856WIUczcTN9XBeGXdON0dO6?=
 =?us-ascii?Q?eJheSpyjDPOvVkh31iKVs8DDj6Sp0xA+tiH2GsH0PjBD02utJuZmCb3AQfYe?=
 =?us-ascii?Q?fUPSNhIRfsfJh3b+tx7b4TtuCyavpPlWIovJVzaWZy+cbkj4Goh9Z0I4g2IY?=
 =?us-ascii?Q?YF+ATmAFUJLYp7FyfKegp+4G9eXmoi06tci14CHZmO/t1GeqRM/MOUStawvC?=
 =?us-ascii?Q?8Lkoh6MaeJVXKSCRhbvRVpZ1D++5aBNAShKn2wxK5oM+hKoAdsHtJxAS+cZO?=
 =?us-ascii?Q?3GAdoOsmrZWA5pu8bNTid/K0h+oxNz6mzfRdloyKUxo7ppH/TgPAlH2eC7RV?=
 =?us-ascii?Q?jMbOB0GXU8toW/jwJXpHD4HtB4yNE087m1pXICAxy8cAkZCzHsFOrDkmnK7i?=
 =?us-ascii?Q?l/ct9hut6SpRdh485tqjD4RcO5XgByimyu4boXEgwxHePUy7giweRrnFbhr4?=
 =?us-ascii?Q?F8Nlb7bTLhi18SZe9jBMgvid/T0AymaaNK7yEqu8cb92VV0IxY5qT4XMpV2K?=
 =?us-ascii?Q?q6hlTr5Z210VnoGNKT8B/DKjx/bZh1SGc4eoG4j1swl7OcZkiFzPygloiqAF?=
 =?us-ascii?Q?PIKUmlIPTACTElOLzgPfxXIn+fIfz8dXRHR+NDMSWcvba8xR6IKkJ4afUpvU?=
 =?us-ascii?Q?VikeS8psuGjw3gDZ2y0TKhmNbAArjC1MiuGQtjiFjvDIBSaNH7hJ4bjkbR1s?=
 =?us-ascii?Q?7fW7SqCOlK1eP04vLj8oEmZb1otTk7mBWiSWVNxiKD7OXa5Wu9XXdds5Ywq0?=
 =?us-ascii?Q?pQh4KB+ASphTCgDeah9Qyh8YQviJ1E7V/GzaZKdoreQs1UVsZo7QH/OjWCH8?=
 =?us-ascii?Q?/xTxEuaRS0Uv8o2AzsEQqJLAr5zHQGo99GJFvB3UaPltf6t0leMbUTxybQMH?=
 =?us-ascii?Q?JVCXxZpwNA+R++gm+VWmbhH5Jz3PqGFQFRQwRXxRBKOqRjOB5GhV05yNCwg3?=
 =?us-ascii?Q?hwc+w2OnKobPM2aylvq2K5Pb81HzQick8Wsm8BtOZDJjw6Y03nezGr9w8oLX?=
 =?us-ascii?Q?X0ASRd1GtPWl3GCjxAmG/Gl5b7Y712H1GC3zmHXcS+RQ37mvNKXjZoWGKSTk?=
 =?us-ascii?Q?GRxcfVu068DgfGwScSaytQmZ7m6iPP6+rvpOJYBmwRxQ0YJZq+qHZSM7XVGF?=
 =?us-ascii?Q?OtD114cixbS8KP4LeCfm8SiJKY2vsGfn4oK9BbYZo8fZBpcGf4iAJU6pNp6l?=
 =?us-ascii?Q?IAtnDQ2K02PhMf+ivAM/fUJOkoWbex7/oYDdmCEOQhqj6j+vhAlAkv5uVGWV?=
 =?us-ascii?Q?XvMZhguoPo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJGo97l6IKcLllzXIkAyitkmhNSvMv7S0iokT6vcmuvcE8+GxM69jnsjHcBf?=
 =?us-ascii?Q?vFSWcA4XR6qhCnQtI0Kq0r3s1G6BTtRbaKWw6Zb0GIf4ALYsSpVzz7MrJZG0?=
 =?us-ascii?Q?wigho2joZad3EVCypjcyjYz8EVO1lU6F55Z8dj1FeCxlbwacWeGf/TBgsDDl?=
 =?us-ascii?Q?dBRWPEdnBtjrDuQcdXsJbYf/6+ZmiB6YwFpwCtrMEFre7gkPI2VLV4PpMafw?=
 =?us-ascii?Q?A3aQZskA+ptsdli/iPC44cxZ9UgOZZoCQiPq2eJcV23WByfzou4w5Du/BTOm?=
 =?us-ascii?Q?nIZWydgRiwdyi7CU7t67DvKW0+l+b6eAVshSxMKSZ4/SW/VO9nkzkC1r6gG2?=
 =?us-ascii?Q?uJxIMoTSCYT30YpjpuK3A1uizcDqTxgb6bia2hfHBwX7y0I8oJFgb+ZkNfiY?=
 =?us-ascii?Q?Z44pwxj8Trx3GIsxu2qyf3ortrlwsJyJvpNcpfSdGGZ5BVXcIxVRnIAsinU+?=
 =?us-ascii?Q?Vsb7/c8xVSiLfk8JYNZauAWqjd1b1Z07oWIDLaJPJyJhn4qiH0STNS2J1WGQ?=
 =?us-ascii?Q?eG1Uhg5uWFKFaJhRXcoRUZaID3mOP6NqWP8UzB2GDb7zKD76xhU+dkaV+V+o?=
 =?us-ascii?Q?e+ZR4UBYGxO7DNUHElDYtT7PW8cQHeYpSDdPrVI29fKGOUApS1O+J+3XjwKn?=
 =?us-ascii?Q?1RgYISHE2F453tb7Ufxo0wUpmjHfSm7NHZrrvs8sgdt8xje+5VSA2Mjz5PmP?=
 =?us-ascii?Q?Z5Yo6vi3WkaQuchgjzx+HrnmtnnUSSvnlWmo7wjWjOudDFSDI/MKATqw3Kjy?=
 =?us-ascii?Q?4dhzNVrVSiD/MsA6TKqv0fwtzMVee++jcmuQBCbDaPj6eFiaAbWbzx5hADv2?=
 =?us-ascii?Q?vuPmRA3DlfnZ+DbFeIKrIIy6IyEdo4pbBRlLWL2bRBhDUf2LR5q1KS3pjcKE?=
 =?us-ascii?Q?LUYCc0DtN846qVd+UqeeCrvdL8AMxJJJKpSlL4S1pJqxiTm+OdQJ7jtWvhfo?=
 =?us-ascii?Q?QOoLJcWZdKpPN/b+h5nuRFW01kWiv/LtpffuhIo0TkNJtvsCpXoffYtLYEAx?=
 =?us-ascii?Q?mj1Qd2QsR3NC8tIKTGa8TrTaWlpVJv1Qp41W0iay7rsRNBGXO2dDUminAaWz?=
 =?us-ascii?Q?CBCkRc77qCiXMH6qJUG1pgc/l1N0uki5tjAYShosJU3QdhzfyN7guFSFAiCm?=
 =?us-ascii?Q?eltdWmFMEDf0ZGRjnac/f392QOAoUlyZguMqhOhfI+QvqLxzLEB4ipO4FMWM?=
 =?us-ascii?Q?/Z+cJhlbtxPk/YZ5cdtvH9ZbdtywjYpoH4IbxUtMws8v/nBjhAPpEv0SGri/?=
 =?us-ascii?Q?pQ0j6iQ0xWTFpXAQ98IKoy/6NfDnF0Cm+brtNls/kAoYoK5igqmFQ7xkiHsV?=
 =?us-ascii?Q?uSjcZFYPrAvz2iIuFqZFfXKwc0OpzwH17nV3xrrZsyAzZaDo4RtZY49HZPnv?=
 =?us-ascii?Q?J4+qMb9wf5NLU54kBpIcmN+NuJICikGqyOiINILPmdup2cC3Gw0UCnJ25GmE?=
 =?us-ascii?Q?2ec7J6G5Mn5T798tIyOJQiffvGP97aGe7h5tsiCfAmRp8q0FG9RLKJOt2/T1?=
 =?us-ascii?Q?6LRAk9ktoOYCXc9oTKiVgC8Rx8cb3EvgqJ8c/E/F/TeowooWBnGEwmRAXU7+?=
 =?us-ascii?Q?VBtEtT53TsuJLzvtAV7V0dluUdHEa7LTfPfsoVej?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Da5byPgh3iDMPWV2Y+KPOc5e1Hz50D4lqihXdqODAjZNgpD5WUXS6mZGf/EZdh1RkKKJ/bMrUsj8UIjlzPiJD6jI6bzdq3qWLYjoZ3Sr+axS6WNdT5DgXL6zp5Br94d3G7DOGGLl49N0x+Bnjua+Eytasuh2/vUBlcnY3tZcHPGbuWRt4AzqSvnOfK6MzegAtIYVCkdhAjT7McHMn82PSh40rmpeg1sqwrQ6dwrk+08zg+mmRuHuikQrwoV9RWXdJVx8rYiCnP8Fbn2BHz7tqq2qmsFSj4bYHmcOBqlGRN6ZYca4cCGuB4b09+WfgPT8nx3YysXCfseBKN83dqO+7BrVJOrhC873nNq2FBhPwTxsl9zsAWXVR8YLDMnMr5p4UrIiRI+JVc8wxlfMNK8kXuXixE1OpV1mylVde8qW0Yi5Uit2I2oHpuCjXtGtpTL00+4huZl4ApwmoxP71MY34Jo+IaFKR7pjrVD6uiTXHrjMKbkr2cob+KbyRHWXqb1yykLB63mgN7LzASsjAfsI0YZoU/SGD4E+YEH0r55ZTZqIjp7H0aAfigdDFyLylNyEPGYkTI+Dx50Raot6yJF7HXsCCES6gzd0upLMNF1RYPW5HKVcDcpW2YIBHPySqTv
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac688b80-b945-4136-f710-08ddc43d9273
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:28.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63BzHeoX9zVrgbgNXgIn61aYSKTGRoKAVEU+Ikud+K7bb3QnOrR6g0StdE++DYqFUMbKY4uOZoln3Sq3dkGGqw==
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
X-Proofpoint-ORIG-GUID: chAkeyn6ax81cdxhkyNRyxezi_Ltucp8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwMiBTYWx0ZWRfXyO4nKgF3E0Z3
 tHS+evr4awmpTCWxcuRXUULNQ0Y+TBYzUOIeMa3FYdJj7Z+a28AJJvSLg04ojrWqeYRQvAzDKpn
 Ecf6EE/dYSc+IDPmyPZEY/V/knrWjjZGalfEzjQG6tLQrpwfCGjS6wxFRQv041J58Ahapcnsg6T
 qL+bVKPXERvR2dUo30Ja7o9X/SXTV1FV5pKiZ9qlcldBdRbhjBliPrJNSfzQT7J90J8dYSI+jNg
 BLbNwN04m80z5XGw1kWJNvSu0KrGeQjorNAtJMfPF3PTQjnOHxcPwgYKLIMwM2BBnUC1hLsZgPe
 YaYcxJ1s+oDRFqmYaE/aoiM97Hjbpt04FEhRejb6ESqKGsVou7rb2zR3+gF8mF95ornlxrB/uJw
 HIJOaNg0
X-Proofpoint-GUID: chAkeyn6ax81cdxhkyNRyxezi_Ltucp8
X-Authority-Analysis: v=2.4 cv=Nf3m13D4 c=1 sm=1 tr=0 ts=68775a03 cx=c_pps
 a=PXmiQ9rGVnKuowI7ZgNCog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=HarDYBM2GIbeBqPcLDsA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI response. Add missing byte swaps wherever this
structure is accessed or modified.

Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 49 ++++++++++++++++-----------
 include/linux/soc/qcom/qmi.h          |  4 +--
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 71cf6408c6fb..d421e7b3fc87 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2227,9 +2227,10 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "Host capability request failed, result: %d, err: %d\n",
-			    resp.resp.result, resp.resp.error);
+			    le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2264,7 +2265,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -2352,9 +2353,10 @@ static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp->resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "FW Ind register request failed, result: %d, err: %d\n",
-			    resp->resp.result, resp->resp.error);
+			    le16_to_cpu(resp->resp.result),
+			    le16_to_cpu(resp->resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2427,15 +2429,16 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		/* the error response is expected when
 		 * target_mem_delayed is true.
 		 */
-		if (delayed && resp.resp.error == 0)
+		if (delayed && le16_to_cpu(resp.resp.error) == 0)
 			goto out;
 
 		ath12k_warn(ab, "Respond mem req failed, result: %d, err: %d\n",
-			    resp.resp.result, resp.resp.error);
+			    le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2842,9 +2845,10 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "qmi targetcap req failed, result: %d, err: %d\n",
-			    resp.resp.result, resp.resp.error);
+			    le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2981,9 +2985,10 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 		if (ret < 0)
 			goto out;
 
-		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 			ath12k_warn(ab, "qmi BDF download failed, result: %d, err: %d\n",
-				    resp.resp.result, resp.resp.error);
+				    le16_to_cpu(resp.resp.result),
+				    le16_to_cpu(resp.resp.error));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3224,9 +3229,10 @@ int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "qmi M3 info request failed, result: %d, err: %d\n",
-			    resp.resp.result, resp.resp.error);
+			    le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3273,9 +3279,10 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 		goto out;
 	}
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "Mode request failed, mode: %d, result: %d err: %d\n",
-			    mode, resp.resp.result, resp.resp.error);
+			    mode, le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3360,9 +3367,10 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "qmi wlan config request failed, result: %d, err: %d\n",
-			    resp.resp.result, resp.resp.error);
+			    le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3404,9 +3412,10 @@ static int ath12k_qmi_wlanfw_wlan_ini_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+	if (le16_to_cpu(resp.resp.result) != QMI_RESULT_SUCCESS_V01) {
 		ath12k_warn(ab, "QMI wlan ini response failure: %d %d\n",
-			    resp.resp.result, resp.resp.error);
+			    le16_to_cpu(resp.resp.result),
+			    le16_to_cpu(resp.resp.error));
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index 469e02d2aa0d..a487b724abd2 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -98,8 +98,8 @@ struct qmi_elem_info {
  * @error:	error value, when @result is QMI_RESULT_FAILURE_V01
  */
 struct qmi_response_type_v01 {
-	u16 result;
-	u16 error;
+	__le16 result;
+	__le16 error;
 };
 
 extern const struct qmi_elem_info qmi_response_type_v01_ei[];
-- 
2.34.1


