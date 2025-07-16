Return-Path: <linux-wireless+bounces-25529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC8B07045
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96FD1C21CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CF291C19;
	Wed, 16 Jul 2025 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="i4v/e/9G";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="ORaVUWkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD3289E3D;
	Wed, 16 Jul 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653958; cv=fail; b=pKyLWOwQMF72ZTiHrhGhM9G+tTtvbNsncSKN9Hop8dEjaY9cY/8AxeKLVrtElw1BPeHbGwVGfx3wRa2t8kwaLwSfyJMo8htMj7US3GIm2BxgmGg2ESKn2aTqihV+12cEHfrYW5j3Nz3bLn0t990jzGBU7vlCSBmRLgsX1QvqbXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653958; c=relaxed/simple;
	bh=rS+y5PznGmQxW4bOdJKOal/hdaGZTh+FfUs/qY7ZTnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C4xNhHbah0aTDwSHcOb+3jmLoBayoSjSxsL8PItIeCHiWNlvKljV388NYcEczlDQU+ChZIaQrufk8ufQcvFmwkvfHceodWrs9MHfSF4UTbhnolksNJTSt6C5QffuVK6mmtZ1W3pu66Kxqbc/0yNQ+D1p2zZijQ3SODr0aabMidE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=i4v/e/9G; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=ORaVUWkv; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6Yjas2293927;
	Wed, 16 Jul 2025 09:51:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	yPdyAA9BuUPchSBwCDrKsFSRt7xhFZ37PjVEbPDxe4U=; b=i4v/e/9G6jFGa+Pp
	icdeJdJLzGcE76hiA9yuVkpgD4CL3wIruvgKAvhV6FoAeXS+XAnhlL7moqIsC2/Z
	ugzcVQa+k6kJFK8Pu49L0nl7bT4ilWXgJBBovpDHlQbnPQ0yWSDQZl5j6F4NH9eR
	04vR/MxhN73j0q7oFHljQEOHy5eYU+KDwT5rSGL54hk6Skg/gQz9CYGLUDOZn9/1
	ore8IFg6uDZqS12PLeTHECDAdJ49hmcx88aDv9tYYL8dS6rxbiFlk1alpdQWCSEq
	O4TMMaf8keQ+BHAocxwBw0FBYPK+33CrcZyTOj6iAb/qNdG+IN/xJ8Md+sakJRIM
	CFXiQA==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2091.outbound.protection.outlook.com [40.107.249.91])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7n9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHTODWKI35T2vZHfJtY83/XFEIzHkZgolrFfp+2Unm0lya8ME4/JKfBq/OTtYIqDbnjmDZYKndSrz+HTWsPdBMt1eteY9qIPs1+TzYHUFc3i0o4/KtHhQl+Jtr25p1e+ve1D2lvYLnScT1jXFS/JQBdo1+05oHnwywcLgT+GxDLEnPXtxZsKUHIVDHEYeT1epND8cpayhpRrrdOz20n6NtU0PbU3TQKUCvXIymLO20UScCv5O0YdzlOKHUVbJQXIUOBoJrmb3MnAvHE8vBz08eYUXG6dgcjrmMD1jTmSVLVB5QcqvW4u04HX2nkjv7QVugBg5UqhWiZmpjliyDyCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPdyAA9BuUPchSBwCDrKsFSRt7xhFZ37PjVEbPDxe4U=;
 b=ERiz2gSTL9LCjXQrKGm3MQG6CL3YYRKmXhG6XAd6knGsdfxecRHjHo18g6yQdRZBxJ6FFvUP0yvsHgBP1Y+4ddkoLtuBQ1GPBp8xVhJHG7wTH9w64gf7RE9/XBRrjs0OZ1cmf6+wScRU5QAznPoMy+t+jQgdlubuwuLW4xYgwmPX92gOg5RdfEMinPJ3dnF3F91xoWOcU+ibvvsZchabIV+6yo6zpcRiwHz8TlQ3MvxNqGuFvnSTNYgd44SBuzak/q8AKVCDVvgYmw4oXQhF+PKnEEnCnKoJeQeIS+QpgfrWdGmuRRFaXRHw/tNbryQ8lNM9jRKo6rv3+ipg19M8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPdyAA9BuUPchSBwCDrKsFSRt7xhFZ37PjVEbPDxe4U=;
 b=ORaVUWkvaRbdwfhlsWUzF8YGoOb9IWurXd6OXa7wW7cc5B9KH/a1YpfH1qaXtnnLRV+A3POnFga+QbZ1LwcFvVECryw/ArasTeEASN0mqk3YSHxGJWZnrGl4Dd2co7q+ReH0u9RzSFdms3vykXUjR7jNwvYaW7bEEfn2SiJwMpo=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:13 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:13 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 03/11] wifi: ath12k: fix endianness handling in QMI firmware indication
Date: Wed, 16 Jul 2025 09:50:52 +0200
Message-Id: <20250716075100.1447352-4-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::36) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 78914ec0-7010-4eef-07ac-08ddc43d894e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6TuE8897c1AdjSmL3UTcUqmlBmmdaUWEpynzMuOaHeP3d5zbhaCrXnv3Q1Nl?=
 =?us-ascii?Q?ohaI4m+kYQbKyAMcHfAfJqattEd2xH7RsS6EA9z8YhR7smSbZb8AemmBEA2U?=
 =?us-ascii?Q?/bIN5B0WckopZYMPR1/A26bhQqPsfjGOTKtXJ5IiStrTvPhrrBGtmKxlROq/?=
 =?us-ascii?Q?+H4FtyNLpZ/eIz3WXpez2yK36587/ZVhAB/8CPeBPivzIZQqGhMV4BfI8djH?=
 =?us-ascii?Q?qo3zDV2ri45y4H7dCBuqSpFGBzabXzHngJoSuKjJsGKxqqzKKZJp5wD1TA47?=
 =?us-ascii?Q?ty6L2Va1BjgcYTKvoMe0kj+5HHvpyTyD3wBEXDJhuUpv5hLd08oo39rWp5jG?=
 =?us-ascii?Q?9HDjkQsCIvGWTWSu20YYvimVaWdptd+F/ikglC7Y6EfanKRpA49gwedF/ltX?=
 =?us-ascii?Q?X1QlFtxYIrhhlFfObSpD5n0pjDTej41cP7oU1f2XgYrbAxGoeLCMw3BfzhLN?=
 =?us-ascii?Q?c9yVNr5OXFID9rjceDQACqJVEBPlimpAG78783lGgZTKGeP9ZLGyiAEC8suY?=
 =?us-ascii?Q?d+60XU+uSZ/XYHhtkdlO2VODX+LR08KsFfSjpFFtjw4d+l0Q9M6MimjsYJDk?=
 =?us-ascii?Q?uzG13QCVLagT34sSu/3UfqkyiQIvkxrRdwVQvEHCaGORcJKqV7wcxfxQy7Kh?=
 =?us-ascii?Q?hG05txWdhucJMGA9aBJ8tzimzA6oPn+mn6UUsF8w72MdgBlGq3jJni8a33Q2?=
 =?us-ascii?Q?+u/0t7bYkaQmejUnHrtiBNDRg87n4ZEWRStPhpBBgaKvDfGgJUy0oqNbKTeN?=
 =?us-ascii?Q?hC5onY6W2EJ2Z7Px/1DIzQ8WipVZ/f9fh28sGMHjpPPa4k207745txmY1hFD?=
 =?us-ascii?Q?J2cmBED9buxbunTIQOXwWUAnJBM4PNDs5dbQmiLZDdZ+D0+mUuV/Nms1H994?=
 =?us-ascii?Q?/u8w6086wMpPgsCq88nETJu/xs5gRdyqYMkdNi2Ap5A+VV/i+N/F/iytD6b8?=
 =?us-ascii?Q?BG+ZqybXIeZBjFOpSG9rGYF5dyreLZ7o0aCrwK/9Qit8yB2dymRnA1h/YnpB?=
 =?us-ascii?Q?w5TAaySLttXL7EZUIphgeGB7woDua38PDQjB4VIJE6Y7/ex/xbvgTQ1br3wp?=
 =?us-ascii?Q?jzHTpkxmF8pOfsbhMoc8gRZwsP1PVRUGhYILoaVi1B61ultlvpJ/530kJceP?=
 =?us-ascii?Q?iZTC5f87Zp4zI301+T7jTx9Ua/SDiZ7vCNl5yIMfMDs1uhr5VbprRsyhTtMP?=
 =?us-ascii?Q?oVR7Qog3V3GCSnmWHjxKt8UEwi9Jw8AW32K5DiEER5Z93L1qAbYdGS/5C2CT?=
 =?us-ascii?Q?Af5Ui6ZehM2NtfHDeK0mTPwjoGwJrilUBmJg3YryWW/OyjlAop/CB5P3R6mW?=
 =?us-ascii?Q?EQz67W+cAepPpn0ChtJrrnPMssFPROolzYqcxjwRm9V+ZBwmMq4pDe6ELYNN?=
 =?us-ascii?Q?aQISksthUn6CvoPNNV1HxDDd2v3bmJU906az6I2+BkxFg/wgeUVdX7gKZ8Uq?=
 =?us-ascii?Q?Q6bJ3HdpaT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGa6buS9PClsYXmW+f8L6/b6r07k6iPH9iW11OP7kH9An6EhV84+2IjNqiK6?=
 =?us-ascii?Q?QN+bWm9tw/Rgm+wJwtXAIMED7O30CLbXFFep7RrJSMYEuKcL45hM4a3rlabD?=
 =?us-ascii?Q?ejJCPB3hAyBTCmiR1cBoRwPQPC1IYuYLas4jphJN6Jd19OS6jfkEHTXjCO1y?=
 =?us-ascii?Q?+mdDhAE8qrIp35K7SNcdWWPZ8pAjIeth0fMN0ZWsp+fgu+oDNv/o8otAMBEI?=
 =?us-ascii?Q?27VT61V7pZ4IjxBRnFaJ+AT09S+y2/rt/fB+VO1uZFEBQN6EZoaLLNK72F08?=
 =?us-ascii?Q?jBVR6UxwbSjPeToTZixqK9nm7gN/JnHsphhiwkUrNUyxN5o4muflYtv2eg1r?=
 =?us-ascii?Q?+qDTq3FDxN035EMltL2FbWjQJb50xIwZOduMfGNm6z+s3B7mUQs26DS0G+H+?=
 =?us-ascii?Q?Yn9LOWHfDIkVpzuUx9y4zfQ8173cmezHIDlmA0CF0bBQQgWLRXgDGJkk+t16?=
 =?us-ascii?Q?9aOc2Tz1PLHSR+bBpJvwHMvjLaaV4nakKhpQv9pfsD8ZZbHJenLt1fGyON/l?=
 =?us-ascii?Q?xLSYs6mysvmjDfpAW8+k58k4kuI5oY6ESsKtUVUelmv3AgbKMnmXNctJCaIv?=
 =?us-ascii?Q?peX0i+mFAigH6498Htn6hkZjYl/1gZeOM318M67cPaRFMMDd+TdwBa0I3j8V?=
 =?us-ascii?Q?4pdlZbDExUH8zrNvUstF21mc9ILGpHuke9lKAbnk8/cv0Oh25LOTtB6iriou?=
 =?us-ascii?Q?JmOs3+klJK+nlAWECyjGumBkts3MK7qgfywsoYWRZGvfvd9Xw0r8n9BvcV1N?=
 =?us-ascii?Q?mywFoUL+h/gTR/AglPdlasSAMHyE4unIBWfkF+OofMjnIWsyimNROLThNaJL?=
 =?us-ascii?Q?dp7RM6cc++0zfENS80KDnMw/lvMJKb8jg+i5GG38XCHK5mUejCe8BJqVbC1a?=
 =?us-ascii?Q?iEgrm4Lz9iZ3WcWcL44UmgnkVOti6vKuLkjOVY79sTokiZn1s4s+NQag6hkv?=
 =?us-ascii?Q?lAYIqyIla61bW+hPEUR67W0iszb4/zwYy7NkexA3N8kxImZN/9/mxqMT8KMq?=
 =?us-ascii?Q?sGNS2MIDFOuMYRcJ5KMDzqFFG63D8FYFgBl9fK3mMdiX2qElfwY2NyndfR8L?=
 =?us-ascii?Q?AE10ulHMjoflJZ2jKEGHxlgtIYhi+XPBX5C3Si1rNh3XbGrU9QDI1XQ9xNN/?=
 =?us-ascii?Q?JpR/FuWnP1LnuueVnZRyMrqJAVcxiY3/o25aUYqJ+n7fOhYQBvdXdMvZwSfM?=
 =?us-ascii?Q?P79RGUj2qN9GbS5A/enHAfdlo/FZTp1sQagUHp69y6P7UwKKer142ZcC3en9?=
 =?us-ascii?Q?kSFn7+BnJtoNoVJWKxUDZ6wyOdoKw/f/dJV9JC2YJJbXECjkEQJMBhkQzia+?=
 =?us-ascii?Q?8Zpl7dxjm770cMC7SQccqJJtCBNd/0y9FCrD2io+vb6+U4+7NShY1f7P/AXM?=
 =?us-ascii?Q?Y3sRH+G8Y0rs0RAc6tti9dlYYpmzT7LUZfklT33GguxGKDJgTCFqHeuplR1Z?=
 =?us-ascii?Q?ktmTtfHmf31ylgmpJOFb/wmg2ImBuRT6FDdLR1gbReFZgzJg5lfzQsA25Sh1?=
 =?us-ascii?Q?prJEd+ggLH3rvGnYia9jEi1yhIPHTkQ6EWgEbFfJXhREoxIEtIleuWQaPHDP?=
 =?us-ascii?Q?V5KXBIssMYHI6YhwoR3YqE+BlSiP3nmHjbUtHDFP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BDt0Yaos2CTqxbtwZSPbvZLXGGzdIXp0zda0lgA21ZXuQ7po8YO/NKK/tCtDDBTBbfy1KHEmae+TfTCeQYddYhl2091M7bS8twz6cD7ep7dhQynqD51YX9nuAfH0j/LQF7rrK3FWEx/tQPzdSE4wEug7lGzwu+XrHjmRc4GbDInx5LIVl56YgXbsHR7qxfpMqxhJ8fTaoJ4gHFUTaWxpWfC7qxWKW7FQlOcclnxvLZxyySmzBKp2ybQgp1203Cr5Pof1yWlR6BYAsLO1a05Feui85ZYeIFDJi5h72ZScEsoxjSMcr7v4Eva7yYj15amuT5CSzEtMQjp/J8DIEQowyX09JFhYf4HAd9oG81Fbh9Szg5UE51xJAxAcXVW892lmvh4BHUP1He9dzJGCZtXEIwgTWWI1dA6OkJGjXbpxxSBAjSjmGUNRR3zR0Sr2p82MM2XPhJubCW6iofuAeG+7qLwnFOHennjP34GMpIleK6mD6KI5V6Ev+jTHrmGzSCA4J5yp4Ybup69ssiN5mengfDcZkw0tsmNmq4fuKfVFicRwVZ9Cs+Lua1iiN2BjIC4fzl3v7UnJTBjJpiE+ITAD4MeMlNqbwzasxN3ZkxgEYu2+Q4pfHDhexaD9IZeANS/q
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78914ec0-7010-4eef-07ac-08ddc43d894e
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:13.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY0aVryP1EK7BBEzpO8fwVbSyr6hYtO3J9Fwwxf7byX1QsH0BcmZJUBnqpNOOThYCiVHYZrWyp5J6i/z/i66gA==
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfX+hmbzk/FkA/m
 PI3pqjgTsziGrN6eyiuFLxe+Uzj2LvtVOpn/xverksGxEhueVoiAd6yymg/9IG32vh2ZHCEYaiU
 +eHfWpzaBm9kGmjtnJgSc0BYD/nED0ac3p3N7hr+iZfyK9MVnZl1HnYZflFN6yYBBqaUSWceiv+
 7BeeqkdXlUz716QGdQHr4+lhZXhjynIkEu5N4GCWjdtEbgUw0h2qA75yQ2JNo0iYRZWst3yShKR
 DvFslUdimcHulllMl34JcWnB30A1a8ecm1e/00W7uSoTEzxAr2wU0N7wqeqiXdRWd/RDBS/JBW8
 QibuaWi1RxowBrlxZ/wId+GHd9l4h2zHstVwW7BvLeMn0yrnruyZmkjm7cqudRCAvKV61PIV+eX
 N6+99Jl9
X-Proofpoint-GUID: QGv9_JFaFqbJ57Srfu2qb1Am5spZN0Jt
X-Proofpoint-ORIG-GUID: QGv9_JFaFqbJ57Srfu2qb1Am5spZN0Jt
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759f3 cx=c_pps
 a=0G9U64zD6evOcb00SCSCzg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=qWzXJ5F36-o7dQhHifoA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI firmware indication request and response messages
and its associated structures as well. Add missing byte swaps wherever
these structures are accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 2973edd2735b..cf05c76cc112 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2315,7 +2315,7 @@ static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 	}
 
 	req->client_id_valid = 1;
-	req->client_id = QMI_WLANFW_CLIENT_ID;
+	req->client_id = cpu_to_le32(QMI_WLANFW_CLIENT_ID);
 	req->fw_ready_enable_valid = 1;
 	req->fw_ready_enable = 1;
 	req->request_mem_enable_valid = 1;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abe2fba25d13..026dc33a39d8 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -296,7 +296,7 @@ struct qmi_wlanfw_ind_register_req_msg_v01 {
 	u8 pin_connect_result_enable_valid;
 	u8 pin_connect_result_enable;
 	u8 client_id_valid;
-	u32 client_id;
+	__le32 client_id;
 	u8 request_mem_enable_valid;
 	u8 request_mem_enable;
 	u8 fw_mem_ready_enable_valid;
@@ -304,7 +304,7 @@ struct qmi_wlanfw_ind_register_req_msg_v01 {
 	u8 fw_init_done_enable_valid;
 	u8 fw_init_done_enable;
 	u8 rejuvenate_enable_valid;
-	u32 rejuvenate_enable;
+	__le32 rejuvenate_enable;
 	u8 xo_cal_enable_valid;
 	u8 xo_cal_enable;
 	u8 cal_done_enable_valid;
@@ -314,7 +314,7 @@ struct qmi_wlanfw_ind_register_req_msg_v01 {
 struct qmi_wlanfw_ind_register_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 	u8 fw_status_valid;
-	u64 fw_status;
+	__le64 fw_status;
 };
 
 #define QMI_WLANFW_REQUEST_MEM_IND_MSG_V01_MAX_LEN	1824
-- 
2.34.1


