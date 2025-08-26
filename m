Return-Path: <linux-wireless+bounces-26612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26AEB35571
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091327B6F72
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C632FC89F;
	Tue, 26 Aug 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="qH5B/3i7";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="ohX/n/1Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B42FABFE;
	Tue, 26 Aug 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192841; cv=fail; b=o0+9cA7jbkEhTcTCuptycMbs7oct+E1woEUhJbKeNEQhB484lwcDnDrJtrwxEtKJ1xMq+x77pFrVKnM2TEfzI7N5IreRWWfsjPmwhc8A6QqmmDeYEOpKqsPjw/5XQrElI5NDvHteXWiTro+qXn9nN/MF50A7p74m2dfqST7/zdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192841; c=relaxed/simple;
	bh=JQ5e2DtsR3dfzEO21JTi0poH87pOFU44kVZEYZfRG/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvSeUngNvx6BFAxvL6qegiWi0rLSk0NzibszpGDEc8fO7OIfVFnYWJ94hn/3q2w82Niz7FUfI8gJH1XuakbeYRmHo+opmazGIW+G7n6DmilPJPbckO8CVzFAD8OyAwl8FUUuqXS/eSnZQ4XEb6tRnMn0LwCfPIZmelOHpsadq1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=qH5B/3i7; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=ohX/n/1Y; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57Q4seTq3423421;
	Tue, 26 Aug 2025 09:20:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	b6apTY0X0CBZxzkdcp9vHP833lniTA9I0F6DYKkgTuk=; b=qH5B/3i7ZloJ+hGC
	j28mIpjLpZQf74ZGDxa5j0vAxqoNw/vVLSPou3Yrht5ODEdmP/rOX7tBJ3Wn4w3+
	wU9SKC4VpmfstqJTzMPzYcrIWU1oIUcIMKYlRfIRhYVxB/mJaGFKa7Ihw7/FsOJN
	tDhUWya7dTetvOViEoheJEvf+UTmu/YqmYw7gUx+ZeQprldEotqrXCKxYD3Kjx+/
	9552T683hcqIm7CteCOw8s9fcW/vnWXv2CFapN0a5/9QrZhtXzMcPEBTkHB/XYwN
	2qqG3nwnAiCy5D0DKT+m7doaXcvhOpJB3kpIlUWY5FuBVVjMoX2l8uc2Dc666BIA
	iVTrNQ==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2106.outbound.protection.outlook.com [40.107.241.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q308ag97-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:20:18 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNmDR7Ke9tf9Dv3wUyjaLTJeSvfV9K0yCivDtBWdtSWHB3FzkfVmuxaZhicnXi7HSGVQoBkyX74CazxCbUVZ7EbnwRf1hn4pjPfBlxsuz4TzXVPxXqJnvkkP5aOhZqHd+Rfz7CYanVNzbzx8cE75zLP1fFyD81uLxn58kH+Y+FzMg0uOTSf9X3kUlRzK0kBLHF5EzmP8Q128YINe8WECXikDy9HvdjrbF4NhNe5g1RlUSzOOJ4ZKsxbhYp6eaJp7xyxSaIO6FL7GX90NcBu/6/mEb6won2D9bPczmyQmLVd0+uJ4GAFDQXOZSkz646rZYxoimPv+qH6jSP/MHh+Chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6apTY0X0CBZxzkdcp9vHP833lniTA9I0F6DYKkgTuk=;
 b=kzRxzNG/49C37GXzyOQRXiiHw1BLZq1F44GOH+G9Mm9O4lqoM/j2s4zdJ+JaHPAUzF8d80o+383amifXdYoD6+gOyF9LU3exEcQDJ15q8m7IHrnpTR+4ktwQRnKGwGlAxGqhuGGi41jsWjaaZ00GrlFONJejS42C/+iVAB0hcVQ09kAuiwvQOS+llQ6Yz3Ilu1/K54vWF8s3EtQD2GErICe8qaCYCdSHTnf6maIS3hlnImIhHr1/CV1pWBFizqIiaGR86GD92XXL/oGPTGuRGO6ThQavCYXYIxDQt6iPVOv9dwWX3UQHXUDbKvxOGiXTEfdRQf+jNEmo3gBWmxftsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6apTY0X0CBZxzkdcp9vHP833lniTA9I0F6DYKkgTuk=;
 b=ohX/n/1YOlJWNmIjZTkpkDKpyS16g7Uc0BMEWO0ksvl9kMEAWvBP5+GPlUnRSSQqhekmUa07cyz6G3rJV/R/8qBzC5C5oi+Jj+BQCjFHyMeKLS4dPZKCsHKDOkWUyppnlKNQkOfA+0NsjfRQsHOybpVAKS1TwQ5CnbEd4FK1kpQ=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB3P192MB2107.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:20:17 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:20:17 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] wifi: ath12k: enforce CPU-endian format for all QMI messages
Date: Tue, 26 Aug 2025 09:20:07 +0200
Message-Id: <20250826072007.1395416-5-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
References: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:7:15::15) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB3P192MB2107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca6c95f-e42f-4c07-39d8-08dde47101de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/0s47j92I8HsMtSvhqQVACWYqcAnfnSmLNuQ4UOtJX68mq+7gXJXl0zpE4F?=
 =?us-ascii?Q?bKD+7Ynp4gg90nMoJyELGGz1Dz9JJgOHXSpFkmrbao7avYnHmAA2zB3bcYuY?=
 =?us-ascii?Q?F0GlaRLln9k64sIe4ZbyD1UkWMpeU9uZxk/O3bo+4plD1Tyeu8NJE5jBemb7?=
 =?us-ascii?Q?5O5qnSe3bR9f6lnp+vc6mMN5NLyQZfp8AMr05iTE6WXpFJyOv0I+LxTmfNyb?=
 =?us-ascii?Q?dF/OQIzFyLjTdh/1j6OKStbZ6HcXs+nH2ber6hmwRPU7puWJEorY9J8euLSz?=
 =?us-ascii?Q?2yiAhmzCRt/ua/LbVLxMxaaTzWyW/0kgsOOIfM1nwEY37o7lRWjs25ku8xii?=
 =?us-ascii?Q?MbCabVBjcsQ70yvUsEQ5wP4FxCJHRf5sBisWSG6RW1wdb8BVB4UsF7Dv+SEW?=
 =?us-ascii?Q?x27zbqyaWF2PYLnp5CMWRgrfy9ztL7+LMeTJjan37kOeAoXrNJ2mBLyEbyin?=
 =?us-ascii?Q?6s4F2seiT3YAKw1787DN5T2+MB+xkMdiPyy/NbHL38Y7dq0L83UpZdUHUB5w?=
 =?us-ascii?Q?I80ghm8LRvnrAqYG920GJIBO5VDu46P3waKP03mnm4y40vJVezPqOIMnJWil?=
 =?us-ascii?Q?4ouudpV16Sgsg4LeKi6ghuDcIbLb2F+IlXuWavhm8mT9MeLAAPXBa7ltnyHn?=
 =?us-ascii?Q?qh/5tAvq34GgfOZzeNwgVQzQZr5FgeTX0/z8DGJmTSjlVQnuiiwSkCnjoSso?=
 =?us-ascii?Q?0tONMoM7Fa4VBfBCsJrZxX/fW2Vgog5ssnhu7USCWgohrDAPR8iGZen1ee3X?=
 =?us-ascii?Q?fsjLdovp2dk/2gvSe2XqIsKaOzh/HRLV88UzjrdHE3+ISnHymIHDQSBij4bd?=
 =?us-ascii?Q?ldWG2MVpulMZjLmQ62hH7nNwVft+b1MPc3AxC6CikAJIvNt2hh7Ljita/uQC?=
 =?us-ascii?Q?yAN26nB/ies1P8V6euITUzE/8YIpuY1uJ189KoAnKwFHF9AlkRT4XtoqUjlh?=
 =?us-ascii?Q?1jMCuJZprXfq6z2JVlhzHJtnbZynDyODtv285SGhtaBEAqzOOlLrZTz/Ov3a?=
 =?us-ascii?Q?edjSuqfyeLtCqPb22EJvJBarlG5uTrKjd1cTmHz9+Nv9K4Vp3Sy+74eWYtHf?=
 =?us-ascii?Q?5qdmYiNVwsHEwujqgnFEI24/GeZ7TJAWTBuYOh9yToobEOwohm36MQ0F/5N1?=
 =?us-ascii?Q?bDVVtSpXygE94wkX2ILJSGUYYPNIjsIgk+W7voOMY65jM/sXIFVm4MwOag2k?=
 =?us-ascii?Q?3/pgqqjN8unUnLG4bOfLj15iVfMLtXlwaT33fOxPyNWhiGyJKZtttTxboHSn?=
 =?us-ascii?Q?hKmGKIDVc+OeNwynyjP3PfVMlphqot3uKDgPbOxRpIes12YLb5DeM3zckSW2?=
 =?us-ascii?Q?wJNlfz1Y7jzQBMlh8bbOat/DtNODJQerGZUAtsdrkKPg0/s9rpJZVmmy33Y6?=
 =?us-ascii?Q?5GcmACMHiXV3tEhhpOAyHCxQ8UziBcSW35XWtqklZBNwjAoF2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?78paKInHCefBw5WSw+ml6ps5fvI/5R68OBODauWF64L0PjpIV6HZrdA0rqIp?=
 =?us-ascii?Q?WBGyXHdJ0xz+OEatDbGjIQ0VyNAXAYs033K7N1ZIBGs2xCvTFL9Cy/cd6RSl?=
 =?us-ascii?Q?YX2766p2Sq6GbcFs0WDuBy2gYRBKu2WEz3em96FUsM28txQL4qN5/kSA0Vaj?=
 =?us-ascii?Q?19ivQ7kIA2PDNsaidTXETnX0DpK5+Q0DwjdYx6u+fQePcBgyhmdsYtPQc00r?=
 =?us-ascii?Q?ptTFnQO1xZ8PAUIj7JwkLUP/WLeHfLVFah5hjrZ5x28G6UKR+jCXaJg2TT7J?=
 =?us-ascii?Q?178hEljVKfCWm0gPsuCUH2wGUxfYgUM1ix4vLFPWAZXXYFOxLGwyaKCSYgk1?=
 =?us-ascii?Q?4yXoBNliNC0b5BBXPtW5Hf/B4xBdUaZThdJnywGhT3rVE7OxPLqAwmZAc3HH?=
 =?us-ascii?Q?ZQ7YsfBs+NERQ6aWbjYZmbvdd8FzIgqKGM+kAJKBLF5Wz5Fqcgg7bdRTxaj2?=
 =?us-ascii?Q?0CvzxjhRm1bB4c4nLMloHEWDDQBSo6vENmRbTmf3WcaBSEoI1jZ8kEui9XMY?=
 =?us-ascii?Q?FTt1xsC0CI1GCnm0sChSo0As2bOurEL8vMKgWylOlF69rfwqWaPouEA+WwtY?=
 =?us-ascii?Q?fEE/P+7mNQjL1iwTqMLakHuDSz5aOIDy0IVTZtNFrsHjJYqv1zSkj07FcCqN?=
 =?us-ascii?Q?z61vcLizluA/sDMwaakAVTfPntjO3uIOnFKvLxJjfc68MY4LwgFptUrGnd3b?=
 =?us-ascii?Q?fpfSvSTTJ6GYMpKNSc2QF/5STxAz3tgolMpkjReWMb9Rs190MicdK7/eeGft?=
 =?us-ascii?Q?jUbPKkdRvTH5ansC7MVc83OBtrAwSdiXdNgit83HSlswkm7U2t3Lb2hVm16y?=
 =?us-ascii?Q?U+vTJihjB0ZQtmwBOp10sx1H1lr45Dov5Xq16oyiQPNMBolL4PT4ts7a6Wr4?=
 =?us-ascii?Q?/KylWowrcoSEdjYzzdnxI388AaAXmf7du1N7DUayLRuuDScQbW8jl/2Qp3G1?=
 =?us-ascii?Q?DM93p+0PGGOrQotPnb8/9QZtYCOISQGBvbc7boQiRm/0ojq4yz1JxiRzLjkP?=
 =?us-ascii?Q?LovzYrg9ZjgeRcaOx+Eyfl1kHfOPXa5tzlLJAOVzaorXdeqPZFlCcZSLbaV+?=
 =?us-ascii?Q?tUd2DRUyh4UgvNK9KsCMLLHAve8MbBlTuh/I3SpMQmDGubxJsjpjY3+Zut0Y?=
 =?us-ascii?Q?J1DjiJ7Txnwbv9r9UEYZoRnjuLYwbYBI+Zikkpby/RR1Q4Bxv1f2L2z3IVzj?=
 =?us-ascii?Q?Xw86dqM0O3tzWGfeXj5z4wyaN6GYUDtgF7OyJvXRKKGqpc6okRBfO46qzF0i?=
 =?us-ascii?Q?SH59NVeP7sDpD4TWFB17Nq86ttF86vFgK+h7Ym9qcakkJGlvi8qFJ3bTJ7GW?=
 =?us-ascii?Q?dVYYg5PygtysASWbXKaxBgwhuCoB8qlPuXGKxQRAf+RroqY1KdurBDNr6qcQ?=
 =?us-ascii?Q?IY5nTX+atXw7I5SxsqrbJqHFFj/SvS4ClYqCfRoLzsKhub89bd45bTtYJ1H0?=
 =?us-ascii?Q?12jfLyn4sYPSjPY7mv14jsUjo4UxfxL+Sr2Ie9Y1UnszBXEWIcoi6Kge9Oot?=
 =?us-ascii?Q?r+QIlz6XnPC8ltiB0eLYlgzUkLovJsoHTgFaRIb9OMezCfnYy6yPW4Va2n6l?=
 =?us-ascii?Q?qVR25fvSmKkkzHCrG8NKZDQVIOLxyCPPk3NtranJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jZHJGgK+HoX+dhwr4Q9mB1VKIIsAOGVoiYTziy9UTjl0iwfSY4Tp8Q67BADcuq1bqVQRN3Gll/hJXbeHlT4YeYjV06GKX2UbsWqlbRrsxPk+M13eiytG8aHhkxAXYOiK2p8GHnGa9Exaoh+GdmEuvYdjjYAKLnweBlAthEGHTV8W7hiXeVGjk9kq7L4GHyQqnPzTd29Ge8NXGgt0nCkpPJ5G6mvHcgq8Tk/UlxMHn36QYNYRpK78kTpdbrWvKeuYtOcQsjbO/nIpOOY5Sxo7dtNE7jJvP7Vx9IMcqH4vZ7Wl/tJqFUvmjHBZad48tK1n/AbsrWCmhg01tBTgxP6d0w0GUYFzIRqcjVn5EJwuOsWcI61DyV6ZNY7yd5I+ehHRXznfCvUL1dol1AEy09hWfwU++1gUmPjgleYqaUf9YKPucCwV3HPIIID85lfIPZyStDbXGObwO/tylap7/fBvrkkus7+nArljrcbkrRng1GqQSaJT4Ju9JhxyVezS0h+17MkuuxdZSLmJ1sv0TsidCPelwMJ3ZOKegUxlqdxOt4v+AONRu58opa2iErk9emFt+sHvUGwwUXWnh4bAiVLaOezchYv0D537r+grLc8w6rk1yUqO1AIISUYggRtJAhlW
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca6c95f-e42f-4c07-39d8-08dde47101de
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:20:17.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaxIgmLKGbhCCiq8Q3U5A++CuZ5Y7wDAigQ9D20/ISW5vkM9itp+qEz2QDqwC11ZQlR3fitIwn4GNzld8v3qsA==
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
X-Proofpoint-GUID: v_OKe5Y-TpRDH6Fqe6rH9oreIEaN0i9N
X-Proofpoint-ORIG-GUID: v_OKe5Y-TpRDH6Fqe6rH9oreIEaN0i9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA2NCBTYWx0ZWRfX+GEtT5V1U3WW
 a3sOA5n0aqw6+GcpJ4LSxleOZIwi6CNWFyvGPnOhWuqwF7EA4897r8v3zNRyPwN5qZJ1aHdog93
 BFv3ZvI1F9BTLLklTrIWPQmaLdS/JdG0815Qa+pkFbdbJxD+4vd72yu4sSmWz0DyFx/q1ugZQji
 KEfET20x9sEgfjATTDdfGB0GtF7ZUdpQQwV3VJSiGeu/mH5E3a+CWuRgzlvuidfRIh1JUaeV5Oa
 off+lufepAGRpQQg5RFryf66nGk/xSYrLbLa9vscKwHMEDxTp0ayI7oClRYYGryhYxbtjmkP8qs
 OP7nki9C404UG3nOPeIFVl/Ef+vflmQb23Zn6hEGLLPPtTwEmsBGshnZEOnitk=
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=68ad6032 cx=c_pps
 a=K3gaILMeFwxk5q8MGe2HyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=-n57fyUix78Y44btv20A:9 a=PZhj9NlD-CKO8hVp7yCs:22

Due to internal endianness handling within the QMI subsystem, all QMI
requests and responses must now be provided in CPU byte order. Replace all
QMI-related data types with CPU-endian types and add the necessary
conversions to ensure correct interpretation across architectures.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/qmi.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..36325e62aa24 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3307,20 +3307,28 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	/* This is number of CE configs */
 	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
 	for (pipe_num = 0; pipe_num < req->tgt_cfg_len ; pipe_num++) {
-		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
-		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
-		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
-		req->tgt_cfg[pipe_num].nbytes_max = ce_cfg[pipe_num].nbytes_max;
-		req->tgt_cfg[pipe_num].flags = ce_cfg[pipe_num].flags;
+		req->tgt_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(ce_cfg[pipe_num].pipenum);
+		req->tgt_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(ce_cfg[pipe_num].pipedir);
+		req->tgt_cfg[pipe_num].nentries =
+			__le32_to_cpu(ce_cfg[pipe_num].nentries);
+		req->tgt_cfg[pipe_num].nbytes_max =
+			__le32_to_cpu(ce_cfg[pipe_num].nbytes_max);
+		req->tgt_cfg[pipe_num].flags =
+			__le32_to_cpu(ce_cfg[pipe_num].flags);
 	}
 
 	req->svc_cfg_valid = 1;
 	/* This is number of Service/CE configs */
 	req->svc_cfg_len = ab->qmi.ce_cfg.svc_to_ce_map_len;
 	for (pipe_num = 0; pipe_num < req->svc_cfg_len; pipe_num++) {
-		req->svc_cfg[pipe_num].service_id = svc_cfg[pipe_num].service_id;
-		req->svc_cfg[pipe_num].pipe_dir = svc_cfg[pipe_num].pipedir;
-		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
+		req->svc_cfg[pipe_num].service_id =
+			__le32_to_cpu(svc_cfg[pipe_num].service_id);
+		req->svc_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(svc_cfg[pipe_num].pipedir);
+		req->svc_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(svc_cfg[pipe_num].pipenum);
 	}
 
 	/* set shadow v3 configuration */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abdaade3b542..4767d9a2e309 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -392,17 +392,17 @@ enum qmi_wlanfw_pipedir_enum_v01 {
 };
 
 struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01 {
-	__le32 pipe_num;
-	__le32 pipe_dir;
-	__le32 nentries;
-	__le32 nbytes_max;
-	__le32 flags;
+	u32 pipe_num;
+	u32 pipe_dir;
+	u32 nentries;
+	u32 nbytes_max;
+	u32 flags;
 };
 
 struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
-	__le32 service_id;
-	__le32 pipe_dir;
-	__le32 pipe_num;
+	u32 service_id;
+	u32 pipe_dir;
+	u32 pipe_num;
 };
 
 struct qmi_wlanfw_shadow_reg_cfg_s_v01 {
-- 
2.34.1


