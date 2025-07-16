Return-Path: <linux-wireless+bounces-25518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952BDB06F86
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42D31A60963
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA629B206;
	Wed, 16 Jul 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="ZM4XbePd";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="tccd9IVH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3928EBF1;
	Wed, 16 Jul 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652300; cv=fail; b=Mp6ZJlpGFMBS+YMPlytwGTP4/yI9k4EQKF6OCmYuliRMfZ+JqlSmgvx23io46+D7IGVfqfPoC+kmULVsi7LIFN56Ttvme18Vt/tsehj5MHWGAARMB1b4je9aaXzplKrp6B7fX89AFxxE+w5EsFAsknpsfuZ7IET7biNu2qwSVFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652300; c=relaxed/simple;
	bh=7fZkc6l06OnE1WgL6qTSzUgTB77kNMPboIm4kRPdpwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCwL7WnLeU0SftQ2igmpb+R2g2Y5nEAcJnGxYKPvt5v75736ruSv6ZbE8qBQ/DrKyDLWemFuP2l/c3bu/ttFWJTYUCb9oSDLvA9j9KQmNF0hc8abyUcHvmIHRcr1ZdhMVP8iMXH9zyGkkGd+XYJfryWpwzdSdzWrqu84lAG+YzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=ZM4XbePd; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=tccd9IVH; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G5e2jU1798483;
	Wed, 16 Jul 2025 09:51:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	2C/PMcbm7oc5FZgFMkPW+lbEoI0LrxID4THbPhmko0Y=; b=ZM4XbePd3NXVA5Mv
	ySw/XSt83o3xW2uhUJ2zLD51dNktSyFIgI5W+L6msxm36eA8pJsD3bjZ1fSmgm1i
	hFhEOrUx7SNDPCOJblRJ3OAmZDDikoY/Oa79SeO9SG/5mk8n+hffkcrvZQcnJxin
	HxPkxjDfbUUNcczVD043uPvSOZ1m4W/1QCS8bSoHSXex2+T3oNyleWSkb+wFtFrr
	jWicW96vuzpVxYdYHjoUON2A3d8BVLAEmhK91IfaQJN975HFw/QphjoLl51AArMo
	0JarJbuZzl+iWLEQaivGbL9xxaDtKs+U+ZHG1Favfw9tUC6pk00b3Bs+frV1jO1C
	0rP/WQ==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2096.outbound.protection.outlook.com [40.107.249.96])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47w5js9rdw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:19 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV5yVXXGxBmuD3Q3972FS3hpw5iY/7tUlBD4MJOCP5gXb1YzPGuzci/6DGiKC3soykv5dI4w7nsFKpV3Qat/dqH5+sO28rxc/Q7cAJVLOXNuTiMUxs2TKLFabnSLoY93KVtQY/izxBBPiXYKV/e627c+zQZN2iQupyMalIqBunQ00Y0WC6RoBJPAVoh+n7DD/fDk07Q03g+Pa8XJc5sihzPd88ygKsk5DXgm3UcyX3LFqWj54sw0jqMPclFYeIixOo66cBI64TTNy9LD1x1+l/HG2U4x4Xnwhmd4yrDaUuD3ciWkCltNtHA1SVm6qChsxXm/mWDqA9HOXkte9WNl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C/PMcbm7oc5FZgFMkPW+lbEoI0LrxID4THbPhmko0Y=;
 b=FfLZe6RVD/jfYpeqyFyI92AVgVBs469ETv9saD20TvfJHQVr9FJEdV6rk63OvIVJ90qz4SwnRH4PO4WS4ueXhmvzRByxzX8YOjG3xcOts3PlOsyvC/GErIBzb7D3WmqMKpRtLnzQnGpBRkobF5IBoC6gzgCLPYvE7NKr7H+0tM+6rFvO2G3KGKFEZgSQ+vdRKTRbKo+rASUN1j+WASniqAoQiy8yhmOG+kGOrwQXdXbZJPowQasZvWajnec0188ad+SGMyBrNkXpnfxSF5kk55dDS2x76zuG9Kghr+OaF7jXejsIFljkW3W3smEnURDtAoMCRljo3iB7nWmHX+6H8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C/PMcbm7oc5FZgFMkPW+lbEoI0LrxID4THbPhmko0Y=;
 b=tccd9IVHLTta0EmLWOVSqDyNvBwhqmxB+wpq9PD0YM2pqgRrNglySE6hZPRQ9CQ/y9e39w6UmJKK58zmprtahCzpqSUsOrNOS3zR4c8+MmuwID65JzEHgBBE4jUWHsQarWwGYwGjauHgjdt2agRHB03pomhSyl3uxFHlMdg/uvY=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:17 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:17 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 05/11] wifi: ath12k: fix endianness handling in QMI respond firmware memory
Date: Wed, 16 Jul 2025 09:50:54 +0200
Message-Id: <20250716075100.1447352-6-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::38) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: ab57a618-d0eb-47bc-6c0b-08ddc43d8bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tNLJTEIMxbz4Wc+hmbVA8RsvMEZodZCu5PAtwq7EZqZvkD0c0cK9fk/mXtbA?=
 =?us-ascii?Q?psx70IoYJognYTJE8RV8+BhYZIBfExWYs1iPBEbO4AKHrYmtA18HdHg3SWsI?=
 =?us-ascii?Q?Fej6I2U3GQ+Ur8Tw8KKYdtWP0Zs5qm15c+hoCyuHe32rRdm7vAIEG8WXj7G6?=
 =?us-ascii?Q?Aey2w+Co+CFbfsuHJXolDKQUwbnVRCO6US8r8tb80P78GHtM4lsC56M1Tipl?=
 =?us-ascii?Q?5EIJkjZyHUGajAoi9goInuTFnalO1z3f3MFufmjivS7JOR11tXmvD4AI9+Uk?=
 =?us-ascii?Q?rY6rF7dkfNTJ3EKG7BLl6JESxIZB4A34jW7qe0oAVpCXgNfDi3N2sQ+ZsWPs?=
 =?us-ascii?Q?8BbuJbok52H+l4Q53uKgCrLe9Cj5tDXnnv3Kz0/vdLyVF5zag88SPLB3HdCw?=
 =?us-ascii?Q?2QrL0jpEqG/opUvHkT3EKb34NzGCH7PYWrjeDVjQnkJ4cWrTnqPXssHr41I9?=
 =?us-ascii?Q?ZTem3VVYzHNCrvwKzSYoXFhKlgD8dLqKKLXGna5cTyTyWDUQ5/El+rBtfSZo?=
 =?us-ascii?Q?vv7DkPfqWKsDF6PCFP1P1hpqnFFMR+m2epTFuahKH0qSmnBAj8jVwwMUSgox?=
 =?us-ascii?Q?l1c/kvKT2CKpf6N+MBiwjLP4eMD+TdDDkgrKiadHtZl2X6BnjrcsPjVMNKXu?=
 =?us-ascii?Q?uafogKOUCbmv6o92TcTaWeZnmNLYTOEIkjU8mH0ZC8bxzP5mDX2iH1lqQfej?=
 =?us-ascii?Q?Uoosp/Ff3TWe0ffbkgaYSrgYeDExEJ8hM+UnqHSWbvAph3xHFAMyVYR9BXn9?=
 =?us-ascii?Q?vIR6dnbR+rcsMJOjc9Til9bpuiGG7PiF5OwZkNoSYVWcj079msDcfJH6lISx?=
 =?us-ascii?Q?OQFMQMgEX5kqodcc4PT7xYX2PkIeU/E7vliupRhnGXInlMV7sQ1HkgKC1+wW?=
 =?us-ascii?Q?PAl8kOsBjuLXaRlTueJVIDg+rvtePp/nhIWRexY9vibXA9aMv2QCkkQjHOjW?=
 =?us-ascii?Q?bighoaKGc3v7ph5eZWyMXS0vGBrHixmLPjkeuQi/YYDV1Tsx+URAD9lCSxMw?=
 =?us-ascii?Q?rd+FKLtcEiFdSGWqJqL2UNOwedYZbgpH/6LXICeC8dmTNeIyNAFDxMqqr2w0?=
 =?us-ascii?Q?QpLOJLcL/nIOa3jmVeUuq4PUVrIPB9a+LuqWMVQq8sEty6gX7KM82gfLyQXt?=
 =?us-ascii?Q?o6SvXRYvGxAjTTjmc0bUe5sBdPfLKjN1nV/4nOIhnLAbDBbl69rdq8/RfAq4?=
 =?us-ascii?Q?1JhrxwPzs1G4iAkbE3x3ALyzUjSuvqf5s65pPy2TqAcf+OufzUdge4hJF4mP?=
 =?us-ascii?Q?5aC4tVJd9JyzA47VLgi+X/h7kSthWz7sLtYNg8AAeVwc1Ud11GIw2g0f/FOz?=
 =?us-ascii?Q?WCFay59bZaUti1WcIq4eONP6H3PDb3bXOx0kYgRUGV2xAx6BWapA2v+mYG8N?=
 =?us-ascii?Q?zvdIQ4xwJ1TQf5Bp87NOS7JEeHPbWtmWQjeqfr1hFqKWz40pZgsvC3n0cnq4?=
 =?us-ascii?Q?YbgHa929LZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgySvv3KnLxfzItZiT6HYcNvyZa2cb0ZC1y2LZIPBxsSnVynWiZiSvhErGp0?=
 =?us-ascii?Q?reyH3F5mA+xcevbuenIqUCs/E4dG2NgOsLhgSQN9HKW4YR1NyH8HkA8lDCAi?=
 =?us-ascii?Q?qKhzhKKdF5DtCnF7OsMxGsoeXh0s4+UBpBBucsZD5lqlp7s2SMr+pKagjoYU?=
 =?us-ascii?Q?JK5YOBuw3Mn/Lb4Uxl25usMR9SmjdZGpL4xAE/bKacaNI5WKyfRnrMkKYoMy?=
 =?us-ascii?Q?U5J2EU60RA9ibqNXzJEnKcP1P9ylvkBW0+VJAZbTOoFFtpma8+/r0+WLba7h?=
 =?us-ascii?Q?Jf1882JjyKqVt7+XqoR/Yra7lEcbZEnFTiRcei2h6dtPWQwbzQooh4yUaAd5?=
 =?us-ascii?Q?XbQGawR7KFXCNsvTka0RRqLwyMWE6BRNYhgT7WgmkUvsBQxqHCNAvUSlfqjR?=
 =?us-ascii?Q?zaqi7enLD09U/glFwx5NTX05DniyNkL9U9iEDEhftaDR6n/RppxITyXr2d5m?=
 =?us-ascii?Q?B45DIK9t6Agz/5fFSqmQFHYqYfEzcswHzDiCxFweRUV0p6pNFnUtpuFSWyOk?=
 =?us-ascii?Q?Bkupo52YHEzGcJnVJvWfS2wtYm1gzzi21fILT9YmbTEdYbCyKkyiS7br6HYB?=
 =?us-ascii?Q?6ErR99msRSdxHMZCh2eMn7h72C2iPxTCHdeVsdWOaNtVN2z4HeUqEQvJEHmc?=
 =?us-ascii?Q?4yQDU537E+Aan5Pvjw8YcoyxQxrvTNGjeOz+bp4XbETwaXosSEcL2RCLUFxh?=
 =?us-ascii?Q?wZJxB5MonWiLjOUUQJI7+poffBqODtbrdr24GH5MfMaAjSWeVM7hB+QrZp3u?=
 =?us-ascii?Q?QCFkFKwVWwNfo9qRqyBtKgrWTWDW1j2obDChUUAGbzchjaoQ1a/liHdrSNyh?=
 =?us-ascii?Q?YhOLMGMR0MdG6qrjghlwf0gG+uRMhu2W6AvQ41YTgG4uMgGhL9gKxnG6tCPg?=
 =?us-ascii?Q?nDcmu0nU9x6M7iymzOH9f+vB0lb8Lo/fJ8tpiE3C3kEn5f98mV8FQRcS7HyA?=
 =?us-ascii?Q?o6B2wHOqD6LsxmF6pckkDyGQ7IUNhvPFFox5G05p3DOhXzE2wfCUtsV/42ej?=
 =?us-ascii?Q?Oa3JyuFEscLFlQqFZxv7N6+3HaX69GKiITabdo3URguKoaxhxv5CoG3zawTi?=
 =?us-ascii?Q?DfgmC/aA5SO5CYHt7UmwGYjOnb5a+BnfCiZ8/iY4WqqoDsYn99oLZJd27oLS?=
 =?us-ascii?Q?1rQ8/rw89RKfvzbNxp+yvn6C2i0gu6YzAvxm4UW15boHbhQrXycMeX1lJtDK?=
 =?us-ascii?Q?l5j3Ls+vbXLULhyzEvFvC4JmlC3cNe7h6JXPg4EbEAbk7luLRoMr4RkIvFr2?=
 =?us-ascii?Q?QNgUGtFdCJD8t0CNoG4yHiQEoQfK33vgFufYOQ2wV7AYu1Z/3YJn2ybheaBa?=
 =?us-ascii?Q?2G/LLlh8lm+S2SAyRT90lY0WrtGWlFzFX7nD7TPHwzr7SOluzeXTw4+9uAbY?=
 =?us-ascii?Q?Qe0ira43qV+4QHFd9y7loWnaEbHc4JtcztDiCYlS7LAJ56NJiJlYHv5/8ri4?=
 =?us-ascii?Q?AYRzNdzqvvp+NFDCZtxivCsGwV8d5J62l3rshvIUjfQiSRiHVGR2qWxeJ16j?=
 =?us-ascii?Q?2QXcwFjZkKcbwHJW25LhJmosG54xKiFt+/damOMTPxhJ2Tl4gZ8l1xKwf309?=
 =?us-ascii?Q?TbgTe3TX+lqbLsf71PsAY8LreK/K5lRulS/USOgp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OOix4G/dKOy2Bhb3IS7y8rY39ZMoy9hNHaSpVkd1m7JRVB4d68Jwlntd/4zXwDdWe8yaHDZh7H8IXoy5TDGuQq1+jNmXxFOAVZSgPSuAapms9d4eGOQyPYC+lyheyjY3InbJhKOQqehro1Rqk+ZgnVPTQjBPeb+7DE9wgl1xpujPOBM8F6/3FEvzHfm1Jssz3Nq5XS3+P4NMmHQWpsz+QqKPs83EWrbO/K3LqHlk2VgmCHa6gPC2DQEZ0crtsVK9QKFe/afIsqvjt/8tEf5aTgAccmR7LwtT0HJ86cacPiSYjZuJMcphqNUjza0Trv2ZG69aKi5rIeP68czfFZ4rWfwFULTw/c1E5ztEkPowxCxPKf+PcFlaZq5+peBRhzaDuFxJSFRiR+w7+ta42iE1/1mNVW2Yl37qwW5q3JG+tlYU92N+hqh4czayUWUvtqZ3VGnFRNgOPQm/PiDcgESm5e1ER4xi+5I3eHjVg1AviXcyQaEl2tf8WJJgdogk9AAv4u/QoxcBCK+n4GSphNEuZ3kAaiJpsctvcQ+ZhoLZXOEw/Ystua7Wx10JUKPMopPj5z+dbg1Pe+I3rntdChonS/whEtmOfvgOORm9C5vzL3HCtbS5RiNDDPM7aC8PntO7
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab57a618-d0eb-47bc-6c0b-08ddc43d8bac
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:17.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlPAwu5gbFmQ3HV9i5CfdvrGiPLeepogoxCjbqA4+2IIvw+PwE7vRdHpba72jHWZJnLWhA0QZEmeNqRYUVFQSg==
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
X-Proofpoint-ORIG-GUID: s64YjhcnA65zgnQuIFQj5xjiQCOIQ7Uu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwMiBTYWx0ZWRfX002e4i6dLhPt
 9VmO3bV6xptq2ESuwS59rrHd8BcJ55TlFZlsRpmyteiFO1+oDSypBoN6JrubRGmrFN66GNLVmpQ
 lG6BNkHd2UIPn0BtBP0LB+C5Y+kgjgWs786frvCes10vTwoXw9aeMYHiKSPFVZIVqASkHh37g4f
 PWyYj9oQFV7TVZvkUEyzaOfHoMyngo0BLzFuCm3SiepBne+g17i4i1mNOEE8Cei/zLZtpn8wbwJ
 m6vRuFuACgK/m9v82vfzByhfeoYLL4zu0EkDCIRPUK0WPkVgzSXB7dkaupF9lRScQSQyi0rTdhN
 LKHfVJ6WejKAWfTg2AEx09/LM/3d/FZoBFm1uUQenB+HB48q/Jnh/ctfsNpO/lwbxTq8m0GkXc0
 gqYA90Xn
X-Proofpoint-GUID: s64YjhcnA65zgnQuIFQj5xjiQCOIQ7Uu
X-Authority-Analysis: v=2.4 cv=Nf3m13D4 c=1 sm=1 tr=0 ts=687759f7 cx=c_pps
 a=V8KhTt/GRB0a3AF56panpA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=qWzXJ5F36-o7dQhHifoA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI respond firmware memory request message and its
associated structures as well. Add missing byte swaps wherever these
structures are accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 10 +++++-----
 drivers/net/wireless/ath/ath12k/qmi.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 146e9e1c4834..2d00ea54e478 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2392,11 +2392,11 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 			   ab->qmi.mem_seg_count);
 	} else {
 		delayed = false;
-		req->mem_seg_len = ab->qmi.mem_seg_count;
-		for (i = 0; i < req->mem_seg_len ; i++) {
-			req->mem_seg[i].addr = ab->qmi.target_mem[i].paddr;
-			req->mem_seg[i].size = ab->qmi.target_mem[i].size;
-			req->mem_seg[i].type = ab->qmi.target_mem[i].type;
+		req->mem_seg_len = cpu_to_le32(ab->qmi.mem_seg_count);
+		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+			req->mem_seg[i].addr = cpu_to_le64(ab->qmi.target_mem[i].paddr);
+			req->mem_seg[i].size = cpu_to_le32(ab->qmi.target_mem[i].size);
+			req->mem_seg[i].type = cpu_to_le32(ab->qmi.target_mem[i].type);
 			ath12k_dbg(ab, ATH12K_DBG_QMI,
 				   "qmi req mem_seg[%d] %pad %u %u\n", i,
 				   &ab->qmi.target_mem[i].paddr,
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 92993c85cec9..bd715bca8f23 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -356,14 +356,14 @@ struct qmi_wlanfw_request_mem_ind_msg_v01 {
 };
 
 struct qmi_wlanfw_mem_seg_resp_s_v01 {
-	u64 addr;
-	u32 size;
-	enum qmi_wlanfw_mem_type_enum_v01 type;
+	__le64 addr;
+	__le32 size;
+	__le32 type;
 	u8 restore;
 };
 
 struct qmi_wlanfw_respond_mem_req_msg_v01 {
-	u32 mem_seg_len;
+	__le32 mem_seg_len;
 	struct qmi_wlanfw_mem_seg_resp_s_v01 mem_seg[ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
 };
 
-- 
2.34.1


