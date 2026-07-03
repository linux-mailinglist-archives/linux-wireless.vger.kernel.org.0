Return-Path: <linux-wireless+bounces-38556-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zbH9F+xOR2qeVwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38556-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 07:55:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7C6FEDFB
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 07:55:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=Ybpyi3jQ;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=dQ3k8HJV;
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38556-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38556-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A41B30DA7C2
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF536EA8D;
	Fri,  3 Jul 2026 05:50:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388D3655EA;
	Fri,  3 Jul 2026 05:50:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057809; cv=fail; b=IHMQuD5ENKa9q+QJS5siwY1XljAzlQ71ARxPRk8YkYWhrbYaMvmk5pFzi8CANGI9if2zGRvl/Y3oz1ZjW/jxruZ03a/zLyH/ZTMTC3VqfQf1G+gXFXJBYcf09OcyRkuL27LQba448y7xyc+v+w95nInZ5aIBURZxurJrN79CDEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057809; c=relaxed/simple;
	bh=HJwQZl+xmDr352TJoBNZGXstN3xEAIlaQM7rbx3vL/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i/xJ4I8ZZ6qOUTh06UKQkVr2pjyS370kTMSmXF8OqpZ4s0bcV+DFk2wERWf/RpHe/T8v0K0eADi4lVJQ9M4srlEECm8m+sX7fhlpxFkcQYhrLKKINJgjh2JY2rfD1slmtdkrby4f+ax5BR9nlgTDFMQIRhM1g1Pa+YisTRXIktQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Ybpyi3jQ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=dQ3k8HJV; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635RRpj2655792;
	Fri, 3 Jul 2026 07:49:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=6rfcIYskgwlNtgQBCxcdkGsP
	fI/NKHv6PyLngAsLJY8=; b=Ybpyi3jQrw9ZmwMprjsFiG4khwrUKPHOOs3+9RU2
	UAj37H0qrMPdO5fq9JZbM/sPh8UhtyW4T6hkDBuc85Gg/MYlghWRFvCLRNCVDkfv
	ZoYzNAOIMJ6rbkeUApMTEGpmxKKC3SH41DQa6pkZKm0SYm8zgHUyOaDGfyH45q32
	FzT3KBCw9nmZOZ4coyIm2HBiqGQE4hYDsABqNCvRMuJw0OPhEvwVbbmCdHLoQsS1
	zycPKSeCAKPz6xaPxQiquATS53DpR40h6AynjOsP1YCtN1QfyrptJPMadCUS2D+U
	M2Ng+ZG7pa1zSxlUZ7nGlDXrAbhvi9ooKnaiHtFe8fAPVA==
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11021122.outbound.protection.outlook.com [52.101.70.122])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f5sdmgvhd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:49:49 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1IM1DAL4o+HxKEVV74pMbMgamWGZTokYzigpeUIQOzUU1P3apMkRgXd7/U4LDy7EuTbvZkSmQBaiAsEV84yhunvQe5lehysguZjCUY+SXPDAPp04LuJFnayoybKtsN9/Iv5dZAwBdrK7aa4jT5azO37cgogg4o/WC9cCDtZ70a1jtN7udQ2pLRziiEeLGtln3lfqTNIT8vMcI2akoAfw0t4lZdzVeAiiZDPQnAISoWeX8o/MJyHrdtvfnprzxNJoALLX3C72rKl4hc6HCS1/+wbwb3x0S9jyV8ZwFjIfayC1Qcbh+F/8rhIx1kBe05qFnPJ/iS4n9Gz3ZPSCvvdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rfcIYskgwlNtgQBCxcdkGsPfI/NKHv6PyLngAsLJY8=;
 b=NYoEA0KbXzgnV/AYGZvJWeFz4QMWnAghNHwTY12baImrGu2zvUrHlOvb6ydo/lUOwYBVHDTbGeUnmVh5e7W6PhMTmHm+DudwVyUrQ3fqefutcI2BTvuceOaYRPO1enNXb+bEvQQH4FV1opqTqzBpkWTQz1uQ1fV/EJ0XQADbTUZPdTAoJaLiOvN9ELrmS17JD9j8vzgW/CqpHln949m4nOKLmZ3RLvJfe8HzfpkWPtH/bJmILvpU9E1bBqLXsOmsk/QJdISX5vGKHU/Pt7kuFQS2rlQXq9/fyBKJ6iZpKP09559Njg4WqsGhSsY8NOp58CCSTqCcE7rpOUwe9qReGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rfcIYskgwlNtgQBCxcdkGsPfI/NKHv6PyLngAsLJY8=;
 b=dQ3k8HJViSGyju8wMeNVBfwL7HzARgUDIlaQ4MKhTmWOT0PVAQepq2jE0uMCfOs+msvRy3th5N2RODeeKK6K2DUOzk2S0BcQ+W7bOx3gW6h6CCMmOg5ueGxmFk+OUXqIH6K6LmXeEbUux/hdvz8eGdcTyvr3etbdPJ50pdJK1Dg=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AMBP192MB2965.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:6ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 05:49:47 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 05:49:46 +0000
Date: Fri, 3 Jul 2026 07:49:41 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix channel list copy on big endian
Message-ID: <akdNdQPM2jdbMvgf@FUE-ALEWI-WINX>
References: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
 <8b29a6f4-0742-46f3-bc86-defa6e0faeae@oss.qualcomm.com>
 <akYk_pKRd7kR13IL@FUE-ALEWI-WINX>
 <akZXF0SI8jVky0Wj@FUE-ALEWI-WINX>
 <bf545855-6568-44ad-95eb-ac9c55827e89@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf545855-6568-44ad-95eb-ac9c55827e89@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF000239D2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1b1) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AMBP192MB2965:EE_
X-MS-Office365-Filtering-Correlation-Id: 902555d0-c0a0-47d5-a4fd-08ded8c6e3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xgnF16oqYSlQJ4gnmCVbVpB0S8UWqMNFEiIgQ2Jv2nD1Z+/ruhTDK3LMuGXrp4ihI+46p5ryTl3u7kgcN/KOjZVCC32whk+CFSQ50Mu9E7ByiTxrOkjvIfljxvJWgNQFscww7U6y/HpJQDFN0r3pvOCe0CITxUuxf5TYL66koymihof9pD3fvTjQ/qIjrjeUdaSEet498FpqRU4WtpybhBm6fdiO5WDZXEJWTlD5MovGjN/+wi4O7AEQeM5yNlsaO1CxmMr7wjSyi6oY3vOBoBJbhz4qq0eCEQyPOZHhGRqRZMio7rroSrr2cOZSj90MsKPtHEp8KeuuNV4dFrNUQ1JUFlv5BWGQ3JTkPROZ+u9FcBmXoZzLLolfIWhHu1KZFi7QBBUvmxBLpNSh31OY1yde3ShXju5d479HZSrSlbAlAmIwWx3OfdtRV91DhJhJAYaqT63LqcxJTi0DY3XIJTaBhVb7mS0TkiXGkrXtsHb+P29W8m28+yLze33ldgdWQp+brO8Ru2sdTnU5k7kS6U5ql1DFXEk5QqW7WTCJzDFPX1XxC+460O5o3qkdy1FUiV7YJzRWZWanjJczQzYy+xtsJzgpFmkKFyhnhh/jc/oDTKzpJy1fia21VIBt4OAUsaxHGyz+4Jt+ifrYmc8tqbZqn2dWKlajM96tnGFMu3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NcimbpxbuxvnDyb/UB7TnKK0YyHLW1pq7+1LFo1gFbYuKELcZr4rlCW1+U3C?=
 =?us-ascii?Q?iNV/Te0dvsnksVuGcK7z4v/fiC2HLbUzJzKT9kxWVlPAFZKUHPf3GyiqvfLW?=
 =?us-ascii?Q?6NwzGJMKZtG2X83Wdk7awOkZXll9OdwtnkngxIbE4ULPUltOys9MFnbkSoAH?=
 =?us-ascii?Q?Z7PwEV13YkDqFqIPg8F2AOEvaxcfMXtQXAzhxxQesHEfccY2NA0+q/QRT19b?=
 =?us-ascii?Q?owh6CKc/abexcawNj0tOND7bjzWyufuHmW/gAB1UvB+OJjUqGeNEMUx3eJsq?=
 =?us-ascii?Q?iKbbQ5vWKrP/7vgu53+Ma1BUJwCRkz4HFxXIyEdERIgCeEC4wcnFXDM7ymYu?=
 =?us-ascii?Q?zf0q9wOSNeDklzF3uysn+ArEDaavNVqmXIh6QVAiJMVsIEWupc15rgMQSeO/?=
 =?us-ascii?Q?IHVU9a65YFvZPhl7Ajii8K8PENzV8Wgf0gGJdpBTpXMV21JcrCkDn3BNQ8eS?=
 =?us-ascii?Q?2udoQ8LV/reJUeILCcWwY2thy+Mfa3/fK030nv0ni+xSYggmeTG5nkQrzuFZ?=
 =?us-ascii?Q?Sm2auKBpfL6eDY5YyKaDPVVKCFGHJF+T/u/Ux4+bIQ4yt7q7ih9xmsbog7XQ?=
 =?us-ascii?Q?/c2gGqaJ3oVLuHpPVr28Nv2KCUK/M3lR6YZTcIImnaFNCTNFp/jiiTTm5wNF?=
 =?us-ascii?Q?qdf1K1LWzRrihvy7vCuSF8bgiOoAXW6v1/dcI9Rl3b1VVeddkep8MtTkvOx0?=
 =?us-ascii?Q?hCeB3rFH6pwBTB2tGDtlP/CjBhtJ77M7D/3mPjVs0V3lwCRBj66hP7KYs9Ja?=
 =?us-ascii?Q?f+mpBHYJPFvTIxr9rHqkULYH6IB23VkDQYQMRJi+qXS94Oa0CFPnMKQepvV0?=
 =?us-ascii?Q?iLLr3xXd1dK3OjfYw6FljaAzUr2yc9Rj48f9skCKGkTucI7Rs7POWWlgOuGi?=
 =?us-ascii?Q?i2CHjPLbbz95i0YuDzBdac5QS+Nv1gueOQFq9Sod78UwSYnzUgOPi5qopnAe?=
 =?us-ascii?Q?oDuIrFrF+FuVlO2iDGQHwTmbhR3aSV2eL2jiOAaGa5LBHjvNzZvzmXOySOu7?=
 =?us-ascii?Q?aolDvdDfoNKXjRLTCjx5Qw9Q2zKgtIguvDwRnreVNa+6UIWU294yIYOmj/TG?=
 =?us-ascii?Q?S7qbB4HWhI5caSeZFEC0+GJYDLNLojZgV/tfhAHfazsfqbm9fT03Z/NPc15X?=
 =?us-ascii?Q?R8LLCzOfNkZf1D+0fSE/Bxd9ZHq5vp8726jsbqk//+7lTnPnuAxCQ5qPHirg?=
 =?us-ascii?Q?+7DGi6pTmScEmV7/kW4+3g0dM1aV4KpwDSY+qOmo8j0bLkZK0oT9x2B/LKY+?=
 =?us-ascii?Q?gBTNlE1vqrqVmvuzx1lM5UOJ61DpYlMthvlIiVGwTk6C2eLKBiQDWD/UPKJ/?=
 =?us-ascii?Q?q2HDW1ZWJ7Bq6QfrrCGxGa1AsXbdlCUguT7QXHUvyfaOL/v1bqDo7J6jNRPe?=
 =?us-ascii?Q?bLuPdjP3hclI7KoCA0CoPGch3iWkYUakbPqyEwoT1lDRb73mc0wFblEwF5FZ?=
 =?us-ascii?Q?oTJZH1yHNDgnAOezHQ9Gek92fCC7hi1qZzoW8vUssblh5bMUbe/EFiEi4WAG?=
 =?us-ascii?Q?ThE1rqbD/3ZqWvugeQwhi4JKeXBCfXmj1+3Ij3NzPzgk1H0QUifT/OG6hk7E?=
 =?us-ascii?Q?UQEScyxchBll3NW1ozSMC/q41L9EcpT7aTUI5+oICTiLdwnrRKFgSS+xyVu7?=
 =?us-ascii?Q?tz+JLiUpweJJ0Wqrjv1Z81qhypMxxwRomoO9jIW5TDhfQUEDXUZA03OHxMrQ?=
 =?us-ascii?Q?rT0qZY30M6B/raJgleOadx0s5LA32GfD4V78thzqlzqoPgIBVBi4nqkAjgBB?=
 =?us-ascii?Q?zSGK7C/fxg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	INA86UKNA0AL/qm1S2tli+4S5smQGLi26LwkJ0ZgTsixmrRzseTk2bqzR1zutMk1r4xnmEBCeFGlBlM7D3e6oywWFCvnlcwplYUegPpV6/5oX6jb3LCaopCB2/W8SMbpRFYB8j+80XE0nbUVBzyXiJlSHZ3pQ2g7WNu58dEfqRtfsb8NZwiKZSzTfdjGTQvlJB/re8zyCxNBb5/NilnyDu2LYMwDyav53hkUrFMon2YgyavYd76cqxgXQbEsjfsJgloGSVkG1imi2EZP56FbdpdJ0VupT51fFu7SpNhN9L8udtilvRQcTrfrfSWhMyBrUhxWju1Cqa7PuCYx+pEuhg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AuJZv1m/jWbpxsilHlRMB8QJnKk1b3GeyjADR36FAxAyYiBd2lR55eoOuij781SgQvZjIwl6UNDT8L3vhdSROuaBne5CUI0cLC5Io7HuYTj4oOK5ccE3dInr0Y1yYZ71cxzccsUWTrxjRf3KAFNumjBthvmxajxoD9xLzo1ekQZ99AVkqqAYfjdjXICENwgBjZb/ogFpx7p7NixszidA+W7z6HjM27QU1c6XHc6x7g55m2ff+zSAxGFzMOF4yWnzuwSygB11Msisz+euQmbHA60rZokiP3N0WuTvLgoXD2HgEM9Ap06VFln7BMika0rqs9Rrm6tTXX3gpUL9Il07kZdc/BDQi/VUDgS0D3UdKeUxNFN2ezoCaUtmLLjJuu2Zb/TaEi5kc5LP+c5B22tRLuS4PuQ4X/m/pYWChZpycOC8HluS0/XSNlZlNISP4y1uX/HOVNkfjaxd6Zy8cDuI7hIJxuApqyq4Ilv5buhjb+thLXMV3A95zUIYLw+N8PppQ3O0ALBaHLAcTGbPkAsQPxWa5W25eqqwD1fbhkOaeSOr7zXqdVm2+wKONca3waP64d3uSdYbmskvYCrEphIlCkxqj1fk6g984kpOPFYNbJMFfIgtrY9jsWM5Oxrpj1w/
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902555d0-c0a0-47d5-a4fd-08ded8c6e3a4
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:49:46.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38jVV9snpLSvRaeh80WR4QtLGL0YM229CiCUOvj5+A6l3T1quX5iC09nc2i2/MQ06B2wVEOiqUmWDamAVwMr9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP192MB2965
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
X-OrganizationHeadersPreserved: AMBP192MB2965.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1MiBTYWx0ZWRfXx3U7ZXbuqRtJ
 39e3YrMzahY4S492rqR/YI0x7ziRC9vWuNrVH4pMKFT+Ir4WjovP6bg5ufCu2TsBq4J4Trwo3hA
 BttGQ0N9bp6dLK77h0HUpS5iVP7ockuaEXIa4lDqsRJ/mLvmLqunsrO8FjkxblZEsn2fC9Lp6TY
 owVZpjkmootxoTt0sOc9VoS0vHsBRi55//GkFcyLQaXwSkyqqPyOchIIN5wmDw9wWEIvRsnP0A2
 KkT+HWzc4SOb0dqiy3F2JaiY+diyLgXWWQv2tE1c1BndbqEv1Pfn0vDsuMkDmdwqcpPRIuY3Ibi
 Nq+Zpl2uLXE3CoJUG/COVb0cJs1/lFyoSM8PIfkbRSnLliYR/POc+L+T68ULhFP1/NrJIybs7xS
 8PKu0fmsttxT+Jsy/V44Akizyh/SNgJ75TV0Hq43JJQ45ua0XgBXRQbQPA3ST5RRNw6C6Xobxs4
 VhKWp5RxgAojvLNizNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1MiBTYWx0ZWRfX9Oyz46q6sq00
 ZezyVZ2HtcZL8q3dQfoJOVqeuII/vbFlY3o8mW5OyBIn3D045xmNn/qOWT/FxyXu0T0HRc2tU6q
 ia9FkartY6G3hLUYAblDjD8pzwORXA8=
X-Authority-Analysis: v=2.4 cv=Ksl9H2WN c=1 sm=1 tr=0 ts=6a474d7d cx=c_pps
 a=cdfVznpogP+U0W1r1/jZoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=lZnTHJOgcgyeC-Kv-5cA:9 a=CjuIK1q_8ugA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: WIgKko_O0M9KV3l-e6JUiurC7uFv8RB7
X-Proofpoint-GUID: WIgKko_O0M9KV3l-e6JUiurC7uFv8RB7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38556-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,westermo.com:from_mime,westermo.com:email,westermo.com:dkim,beijerelectronicsab.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9B7C6FEDFB

On Fri, Jul 03, 2026 at 10:48:11AM +0800, Baochen Qiang wrote:
> 
> 
> On 7/2/2026 8:18 PM, Alexander Wilhelm wrote:
> > On Thu, Jul 02, 2026 at 10:44:46AM +0200, Alexander Wilhelm wrote:
> >> On Thu, Jul 02, 2026 at 04:27:44PM +0800, Baochen Qiang wrote:
> >>>
> >>>
> >>> On 6/29/2026 3:46 PM, Alexander Wilhelm wrote:
> >>>> The ath12k_wmi_scan_req_arg structure defines the channel list in
> >>>> CPU-native order, while wmi_start_scan_cmd expects the values in
> >>>> little-endian format. The simple memcpy causes the hardware scan to fail on
> >>>> big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
> >>>> values to support both architectures correctly.
> >>>>
> >>>> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> >>>> ---
> >>>>  drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
> >>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> >>>> index 65a05a9520ff..9e1d3c662852 100644
> >>>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> >>>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> >>>> @@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
> >>>>  	struct wmi_tlv *tlv;
> >>>>  	void *ptr;
> >>>>  	int i, ret, len;
> >>>> -	u32 *tmp_ptr, extraie_len_with_pad = 0;
> >>>> +	__le32 *tmp_ptr;
> >>>> +	u32 extraie_len_with_pad = 0;
> >>>>  	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
> >>>>  	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
> >>>>  
> >>>> @@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
> >>>>  	tlv = ptr;
> >>>>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
> >>>>  	ptr += TLV_HDR_SIZE;
> >>>> -	tmp_ptr = (u32 *)ptr;
> >>>> +	tmp_ptr = (__le32 *)ptr;
> >>>>  
> >>>> -	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
> >>>> +	for (i = 0; i < arg->num_chan; i++)
> >>>> +		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
> >>>>  
> >>>>  	ptr += len;
> >>>>  
> >>>>
> >>>
> >>> seems hint_s_ssid and hint_bssid at the last also need the endian conversion?
> > 
> > `hist_s_ssid` and `hint_bssid` are both structs within
> > `ath12k_wmi_scan_req_arg`, and the remaining member variables are also stored in
> > CPU order. Therefore, it seems wrong to me to perform byte swapping at this
> > point. What I actually need to swap is the data written through `ptr`, not the
> > structure members themselves. For that reason, I could also use the `__le32
> > *tmp_ptr` approach. What do you think about that?
> 
> Maybe I was not clear. I intended to mean the ptr:
> 
> @@ -2728,8 +2728,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>                 ptr += TLV_HDR_SIZE;
>                 s_ssid = ptr;
>                 for (i = 0; i < arg->num_hint_s_ssid; ++i) {
> -                       s_ssid->freq_flags = arg->hint_s_ssid[i].freq_flags;
> -                       s_ssid->short_ssid = arg->hint_s_ssid[i].short_ssid;
> +                       s_ssid->freq_flags = cpu_to_le32(arg->hint_s_ssid[i].freq_flags);
> +                       s_ssid->short_ssid = cpu_to_le32(arg->hint_s_ssid[i].short_ssid);

No, I understood what you meant. The issue is that the upper two lines will
trigger sparse warnings. The member variables `freq_flags` and `short_ssid` are
used on both the left-hand side and the right-hand side as members of the same
`struct ath12k_wmi_hint_short_ssid_arg`. I would keep these fields as `u32` and
use `tmp_ptr` on the left-hand side instead of `s_ssid` to keep things
consistent. Alternatively, I could introduce a separate structure specifically
for this use case.

>                         s_ssid++;
>                 }
>                 ptr += len;
> @@ -2743,7 +2743,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>                 hint_bssid = ptr;
>                 for (i = 0; i < arg->num_hint_bssid; ++i) {
>                         hint_bssid->freq_flags =
> -                               arg->hint_bssid[i].freq_flags;
> +                               cpu_to_le32(arg->hint_bssid[i].freq_flags);
>                         ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
>                                         &hint_bssid->bssid.addr[0]);
> 
> > 
> > One thing I am still unsure about is the use of `ether_addr_copy()`. Can I
> > simply copy the bytes as-is here, or does the address also need to be
> > byte-swapped? I could not find any place where this address is being populated,
> > so I am not sure what byte order it is expected to be in.
> 
> I think you are talking about ath12k_wmi_hint_bssid_arg::bssid, right? For now ath12k does
> not populate hint_bssid or hint_s_ssid members, so bssid always remain empty. But if we
> are going to populate it I think the address originates from userspace and there it is
> passed in byte steams, so byte-swapping not required I think.

Okay, sounds good. I'll keep the `memcpy()` at this location and prepare the
next patch version.


Best regards
Alexander Wilhelm

