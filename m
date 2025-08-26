Return-Path: <linux-wireless+bounces-26610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5CB35568
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA027ACA7E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D342F998C;
	Tue, 26 Aug 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="jaZdadFG";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="E0jsa3p6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FD280A5A;
	Tue, 26 Aug 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192837; cv=fail; b=F7d+n/Eq0yL6Qu72wZ8EbgKWx2326gzbix3iXF8egr2e9VBPBj+Fx2YBOPu62i7ssrCStKT6Quf27bOcLDXgx8HUhlOr+BrH6AkrRK8hbt8c1xMMVHD8vvuw0w+abiw+h1kZPPp6pSgnHT+C1sgLTy7KF1OOmy9NPeczyroj6Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192837; c=relaxed/simple;
	bh=i3x0xhgOU1weDHPJBIq7LHLN8lSgoBy2v8OhllBI4MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spdM6ZSKw4obe530PKbEgZyELLbuokcBO+cza+y0URtAlZaRXOjOmgVRiu1UXuSHu2tP3skoFWSBqNACLJlHV6dAkHKRgHFiKOWqnqxZgdcoYqrs/4KYDxWEDfaZxTYuIkc2nYQScAxb/pz3KhFknCCHxAWx7hmQ3IxEG4AR/hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=jaZdadFG; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=E0jsa3p6; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57Q4seTo3423421;
	Tue, 26 Aug 2025 09:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	ggqR0X4h+tHFTx0oryfClbL/QLsiKrl2OGgv4kWQogo=; b=jaZdadFGHynls+sw
	4Eao8ZNXA36t61+0bpPCLNBpB+hD8wNOinsMcj3fAfv0mUPNFi7Z7ohSv/I1i5gP
	P6ihz3Q6Szxh65IA1YhluRjb+soDwZQDsVI4Ulenyoni7OZZC71UhC0sNxTY3ucr
	hivteUqMdwvkhzhR0RtPznOgudQEojacUMmjEvExoDVy6WjrYhQHal3Hqz3t8clR
	BS5Y6YSnUT/BafMVKvtiQsIBjXPmQ7x4yIYJzppqOn/a8OSXyCDLE2vfFLkwpBNU
	NWJRXR48DUIDzDm/giAteiF0/3Uxlx8Z/ns7PXEdrcPNINb0qChXVpwwhLIcsOFY
	NKnj2Q==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2106.outbound.protection.outlook.com [40.107.241.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q308ag97-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:20:16 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9Ug3BVl7tE2D9ZBTI0bFL7PQn1bCXnTYRiGa7qbA+jihdJ1nDgNZ7SyuWvuJF1UIo0axdSuDvJw1TTRAX6uA+d23cdWncIibzbCWFpq/Af7OR6LO8E/NxlE6WVQTFpw1CNDOW2dcJ7eFb2BBvO7AMAlnWea5D0Hktq3OQ2KKymHjJaNQY2xvLpnl2MFDAyzJqXu5lAMs2RDi6BwUigut/mMuLpcBes6TmSUzUenFTG0X52R2VePzmkk0ZZrdW+GiOI9WmFi1A/zTcrbrl8VnOGVHhlab+5QeHKm8/qFbBTeb1jbRHhoxEfX+TJu9rgxZrCf0ePlLw3vDy9DBojr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggqR0X4h+tHFTx0oryfClbL/QLsiKrl2OGgv4kWQogo=;
 b=WsCZQsadDHfBlBqnmlfet66y9DR7rhFCYKeLh3JXiDQkTQtHumaFoOMQUxdLNNj36x04LaeD1p/3Bdz+wSxF8wSAo/hfbcOI8oWCE9xnk2NT+IJDJ4tpDzD8cLD/jTdxigapzOVZauPWmFxm4UMC4XADpu1g1ivohuRH6MbQnzJlvMTrHGxQ7RGdprnEADSGsvK6z2lSd3hFLM1VhFt4AJI3gUOLm2J/wf2We3BzL12lW+I1qey3L+3OjWAz7P/d4jCcWSULpdDc2i5tz9jo/wtIDbYlj74O/H9hk0FVhXI2VwfFMWMiStEh/PPikxH3Ufi78PS5ep7MEKJJ4kqcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggqR0X4h+tHFTx0oryfClbL/QLsiKrl2OGgv4kWQogo=;
 b=E0jsa3p667oTSzHLs4GoKps4qD1x6Joco9b323d4VmDMcMVEdZPU7Ep/oJwzfpRwkCiKJ28q5B+bkgo8SSeXUZCwArtBVFlw1fF50sXGEGjXBunXvRbPWmLAsFSC4bExTI0Zm+fnjWmUpuT1Nrlkq4j+SHZJ4wu9KvndWudxLD0=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB3P192MB2107.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:20:13 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:20:13 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/4] soc: qcom: fix QMI encoding/decoding for basic elements
Date: Tue, 26 Aug 2025 09:20:05 +0200
Message-Id: <20250826072007.1395416-3-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
References: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB3P192MB2107:EE_
X-MS-Office365-Filtering-Correlation-Id: 926491b9-e1f3-4fe7-447c-08dde470ff91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qtSj9YTZPUDlAGuuk05k81Yl+8/7h6wCnRK6Vo9CBL7q1S8uP1GJn4DnCgAj?=
 =?us-ascii?Q?TjT+82PYth7xqlWyHtHA+fj4Hw4+ScM12zovGO/hX/lC31wLylatcVSCWRow?=
 =?us-ascii?Q?venXu/lq0JxVoitfr80ONpx4NuoDQ1K0P5SeXZXHsT1CKcW9/0laOZIIl+/0?=
 =?us-ascii?Q?NHu8kmMQtcGBO1JOknRb7TDxB/lwvKBObL8spVFp7+xykK3ewP2FlB9imB2c?=
 =?us-ascii?Q?3yIszxmxHvg/QPy4m4xq3nGO0pl+sBFghVmoFB5tvv1Coz90MY2tS07GjfHM?=
 =?us-ascii?Q?2DnwhmQNJIU7Rwvh/uL3/zB2i1tYBoSmGTZjKaD3na6efnSejNHJmwCnAQ5a?=
 =?us-ascii?Q?VgQgwC8Y9mOPDABoTgbfeabVQ2tSzRQTCfLmyNVT9oyg2qd5+U/ySffZYz0Z?=
 =?us-ascii?Q?7tsWMDlkzAOat0NgbesuTz1iqbrLri7oFa40vO3pYBG2SqikN+AG9lbYcMP8?=
 =?us-ascii?Q?Z6GO/fc3+xkiwRZq6tCiX63P32Wf1uiU1rbuRJPphPB9E+h1K9yl21XFzuM9?=
 =?us-ascii?Q?xBNFCvoNFGiOxFZFoC4GbsCL6L/+e11gUmsq4sD83bGj+J4S8+p2ruyKGyvR?=
 =?us-ascii?Q?TsxNYvoNzgVUrkVwSOjdl1sn/mPmNgfC2TFrKBmMHQ+k0DH54z/IBquLEmIv?=
 =?us-ascii?Q?4iMtpsRtIEOprG5gxpZ79+Wj1gRrn6rtDPAiiqo8LT4lVl/7lIiic986O7rk?=
 =?us-ascii?Q?+oKf+nW9Jv7h1lAD3wELvk8rO+4F9ehFP45SXsWtO30ceHD0y6cpvdhuqIAl?=
 =?us-ascii?Q?P/j5B2VM6G8fAwXye9WuSgjL6gEKveboDzOioFlCw2D+kiPe+tTQLiTxIQ67?=
 =?us-ascii?Q?x0HdqshVjeGX3V54hI73rgU9YugJ4l1uD3Q78e4Dwq6YK9px2OqOzyx/AfBh?=
 =?us-ascii?Q?fwfk/gyOyGJNKY+gbYgcEf3g0eshrcrWHp7GiRq2mf8siIQ825QibCqL6z4W?=
 =?us-ascii?Q?cZ61+bCuhri7BNiUt3g7YhBRgb+gPWNdpQnDhSHglc2Zj5/UVpi+s3Qu2DaY?=
 =?us-ascii?Q?clXPWUbHagPUcbrHwgxRxOC4sVlfb+tL2242oLLwiMcXTZHehJ3FnhMF8/Cm?=
 =?us-ascii?Q?9AAuRlOtZHe6O9wuZTClFvwVkMNvjhjGqN/mhctk941PZKwm+Jy4/4Dr6crR?=
 =?us-ascii?Q?g8O5Q991XMJlSau83WyEbACuh/DdL+UUKJ756sGBvXFgoCXH+anzhuAMeUTh?=
 =?us-ascii?Q?ME/TtuRkZ1khCB2I1cxEkU93srtgSD2m3EHH2vVDe6nxgy2t0r08xY0diU+D?=
 =?us-ascii?Q?uoFB9/e7V3mO9OaaG0RXBvoiA6tdg5dyKrSXPKQH02TzfYitED1K1QfJNzTl?=
 =?us-ascii?Q?BNevU56rarz9YVp2XLnk2eaIf8meEl41M3fkFbbK1i9Zv4fvyQ4qvKNk1ATO?=
 =?us-ascii?Q?voijhHmjUKw52s5WR/gnSwi8h5Eyfi7zBC9EEGdbyIvMLwbR4iVJ8eP4trNU?=
 =?us-ascii?Q?K6Ey2nO4qEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbHc/1YZvyRqIwMbUIxEKaZ/i/a7wukd2SWxMN7IrJp/elB8wHF+KeZHRE3n?=
 =?us-ascii?Q?cdDaUS+JdrOM1hyD9pturEmoUiN8LpGHfvqzmfJ0zaYaCS4zHB+b9ApI5rFb?=
 =?us-ascii?Q?0m/cnh3O8EyyH9B8VEFOloO12NlF3BZsgKGVIgU0iwyQSq30ENIBUpKK14bC?=
 =?us-ascii?Q?D1xzI+EY2/h+1qLYTtv9IP1TUeVeYNa2P1vbKmB8hUZU60g+1wboLjOJ3e8u?=
 =?us-ascii?Q?if5mWhT3GNhXLFyXWs8NRYg2sE7jsSQYUah5rjHpz1ZZYYpRAGxKAr4X6+Rl?=
 =?us-ascii?Q?ejhgvYFOadblP1TvobOg22r9tiAfZ0uUlGYATh2RyAhl4B+E/6ljfsljnBF7?=
 =?us-ascii?Q?NtiZBkoHxhKqy+MUJsdr09rGzhmsb4YuAEyq2lnQ+LuatT7Y9iuOIKHf4UTo?=
 =?us-ascii?Q?VubbkQL6q8EQGIpxasH46o7zJH/AKNVsqlq1/xMwdhnjS656eum6aRIHIi3O?=
 =?us-ascii?Q?TQ9NU/SBO7CZgTT2AgGeTlOO39+8aq1m3TLblrGkWZz8R0DfueE0EsDdbXip?=
 =?us-ascii?Q?C4sc0XUiUEMZoNJvRwpQT4kuvqRIdVxkJ/OXXSWewlT6LaVCf6+n7G+Tzjx+?=
 =?us-ascii?Q?1hPUiD5FNIAe+2TJ/9zbkmIKkD83/7DN2x2TYYzZrlvBrflgGcpCcf3q5ME9?=
 =?us-ascii?Q?yMNgXuBiZ4bd/xKzxrvB1gj6eDeKRIWcCyvXSuCliGVNLyXd6Szm3FVGchrQ?=
 =?us-ascii?Q?8gyjrg00sEzE8BXKui2iIGjaDNzdEu+WV1/kgOIP8VPp1vRliKMcbCeJ3G0m?=
 =?us-ascii?Q?CaFDYCPWZKUtUyHoYt/J9yNUZzCVh9KBPGo9T5OcdNdztvXKqBo6D89xK8dc?=
 =?us-ascii?Q?WpFh2goHMH2AxrV3+crvckpHzNwOWe4WDg+E0Xe9j78gF2JG8u4XY6rc5Ca5?=
 =?us-ascii?Q?z0LJgv9dcCGsK9vAoREJY56nCUhiyvcrKmut/+SLLuBg07xlHxWRNYG362ch?=
 =?us-ascii?Q?/30EJXg9qx5l9sPrJMuAiT0Ytd7mw2MTfo+J+X1K4+8AXMKqSgY+rb4gvOyK?=
 =?us-ascii?Q?Cc5ZvQUVr9WPHmCDpI+PWUbSCun5iEJLiKUr9Z5PNzy3hezIWD1EMYEcmcX+?=
 =?us-ascii?Q?eG7YVbdV4eom4FQhkXFDL7gwtPqDx3OsM14VNCqgQtIZEN1wx4lmSGNSxinw?=
 =?us-ascii?Q?gBEvZ8H9W+NbuJ0KtpEmFJAfrHLBuYt0xrbE7MDScYhAmf43M1swWb+3n+aG?=
 =?us-ascii?Q?Rhl3TM3qPTWeUCPhgV5w4ATkb4iBns74QMItDgkfuHWR6DQnRmGr79ptFXLG?=
 =?us-ascii?Q?/07Zy3JtDYqpWvp9t6i1M0WNub5LIY2OrJYkXJ50WOreiinybjB1B2doK1xK?=
 =?us-ascii?Q?QGi8GjKWb65bwo3xxaaN0Yi4SdkybwgBOkdGwSN2QolwpIZf0gLHaPtZbGrx?=
 =?us-ascii?Q?88cBXwkmoa0vgHOIxSGcGUkBvj5Ooyeu8EIzOmvQifQ6SjdSuwATYXtYoCK4?=
 =?us-ascii?Q?cXxI1+RGUoZ/hUX71IOpmOMh5euQWwYW2iX8i6mNnF6OTYf9cszq9ybeyMsa?=
 =?us-ascii?Q?nVXQf39NALTH3YjBY31oZQ0oZwqz41n+CBlbNJmYJSkFz7T9a30AV6YlOBsK?=
 =?us-ascii?Q?/gBvyanGp6SCH3oN6BnK94R1euhBEVY1M3lQey8b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JXCkXEFAxgl9UueaQKq5EqigXN5W52MYuNbd3YSz+Ove8PKkPhqBBN/ehLGUpGoAszqHGOsPlxxXVtf46S77hUvYWyi4pGxGPl9gTvlz17Qv/BXe/rcRwFppdAXxuH4ozTHR1/V0VL9zdkNUioB3ZZUISEFPtHWGOmFEfEH7LuB8LuXz27jGfi7/F0IN3h2fAouCQcett3w/nS4CV4oeg9q1KUNh2ShRzfpu2q8tiCoZuf9786XvqzArtJTIogU+MuSfAbEGINKze/IfdA75lwgGO3ru5yZuFRIwiS2ZTCXR3MvtmTH0wuMzzXcNrdAHAVhHLLViC0j0zGghg+0dMJ9Y1HmKLirsbHTk7TjfSE7fFfQESoDraNi7g505ML5qBcOrVlzFjn2hDGPfmvUMVrxF5ba1b99jMm0MzrGT/1TWov+6LUaTYsYJ1rj4ZNjD28nU5EoJQQwoNuDGNLtctXIxxRFqriruDwZOT9RPiLdqbYxxREz8F4IQnispfW52Z6Fm/dKpua1TxtxwrgZ0DZP+gQyEqdvyNZZ++IEyjXtrkInOWmxke6lW3FcuO7bArNoW5oGEYh0PXP3muYblhyBw5b59yc7/pABXJXPIFve04unPlfMWUeE4Qr/fLUmo
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926491b9-e1f3-4fe7-447c-08dde470ff91
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:20:13.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sbb0SRSa37xJC+0JmxF2c2SqwOsExVSo15gHu4leGkZNN44C7zsuCqlBcSXhDcAhO8QVviF2q3MgxXReGXmz8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P192MB2107
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
X-OrganizationHeadersPreserved: DB3P192MB2107.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: uLcIAUvK-ZilYEX68s4h_WSNGCcXg6pf
X-Proofpoint-ORIG-GUID: uLcIAUvK-ZilYEX68s4h_WSNGCcXg6pf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA2NCBTYWx0ZWRfX3Hw2LVlCQXfD
 reOjFw6nALpdIHHnDwy2KaGpTDvB3Iet4hk00gTLveWHgh9YL/yvOv6jpQryGqZRUy5JFJA+Fep
 3AY18rsmGjBvWznRMj0XpywEZ+9l4cqNzdZCZ0/z1PAaXa80Ak9BTsB6kL2zk+inq3W6Dj9P5J/
 gAsmchlKYMFTNO/qUQpcmzw3lo6n86QWqB4lDeaKDJvZzkUdQ//WyNvj1d6YTK8C9Z1GkA3bHmC
 /T9q6PvX7DoTIFwUEonIh3TSK17qDragnqG7z9DrpXkQ6fDriHM0AtPQCzu8lYDs709ny8HAB9Z
 SlBioIwZ948bUstnh7qwD8GjH5LiAiv+atdwANEJ7OXCdWzXntUySBm45umxhQ=
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=68ad6030 cx=c_pps
 a=K3gaILMeFwxk5q8MGe2HyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22

Extend the QMI byte encoding and decoding logic to support multiple basic
data type sizes (u8, u16, u32, u64) using existing macros for generic
access. Ensure correct handling of data sizes and proper byte order
conversion on big-endian platforms by consistently applying these macros
during encoding and decoding of basic elements.

Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 50 ++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index cb43531a8b66..d8575e92dbf6 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -36,18 +36,16 @@
 	*p_length |= ((u8)*p_src) << 8; \
 } while (0)
 
-#define QMI_ENCDEC_ENCODE_N_BYTES(p_dst, p_src, size) \
-do { \
-	memcpy(p_dst, p_src, size); \
-	p_dst = (u8 *)p_dst + size; \
-	p_src = (u8 *)p_src + size; \
+#define QMI_ENCDEC_ENCODE_N_BYTES(p_dst, p_src, type) do { \
+	*(type *)(p_dst) = QMI_ENCDEC_ENCODE(*(type *)(p_src), type); \
+	p_dst = (u8 *)(p_dst) + sizeof(type); \
+	p_src = (u8 *)(p_src) + sizeof(type); \
 } while (0)
 
-#define QMI_ENCDEC_DECODE_N_BYTES(p_dst, p_src, size) \
-do { \
-	memcpy(p_dst, p_src, size); \
-	p_dst = (u8 *)p_dst + size; \
-	p_src = (u8 *)p_src + size; \
+#define QMI_ENCDEC_DECODE_N_BYTES(p_dst, p_src, type) do { \
+	*(type *)(p_dst) = QMI_ENCDEC_DECODE(*(type *)(p_src), type); \
+	p_dst = (u8 *)(p_dst) + sizeof(type); \
+	p_src = (u8 *)(p_src) + sizeof(type); \
 } while (0)
 
 #define UPDATE_ENCODE_VARIABLES(temp_si, buf_dst, \
@@ -182,7 +180,21 @@ static int qmi_encode_basic_elem(void *buf_dst, const void *buf_src,
 	u32 i, rc = 0;
 
 	for (i = 0; i < elem_len; i++) {
-		QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, elem_size);
+		switch (elem_size) {
+		case sizeof(u8):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u8);
+			break;
+		case sizeof(u16):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u16);
+			break;
+		case sizeof(u32):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u32);
+			break;
+		case sizeof(u64):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u64);
+			break;
+		}
+
 		rc += elem_size;
 	}
 
@@ -465,7 +477,21 @@ static int qmi_decode_basic_elem(void *buf_dst, const void *buf_src,
 	u32 i, rc = 0;
 
 	for (i = 0; i < elem_len; i++) {
-		QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, elem_size);
+		switch (elem_size) {
+		case sizeof(u8):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u8);
+			break;
+		case sizeof(u16):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u16);
+			break;
+		case sizeof(u32):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u32);
+			break;
+		case sizeof(u64):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u64);
+			break;
+		}
+
 		rc += elem_size;
 	}
 
-- 
2.34.1


