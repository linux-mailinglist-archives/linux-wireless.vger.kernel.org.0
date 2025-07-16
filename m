Return-Path: <linux-wireless+bounces-25526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9CB07033
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C1D50497E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6FB28EA70;
	Wed, 16 Jul 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="RQzWmoMY";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="hfHXmYBN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9728F533;
	Wed, 16 Jul 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653897; cv=fail; b=PLaYuq0D50XPITN2T0IoZD4NAJ8KZkB27PLaMIbjI2OssgslHf3qZJMMyW1K+c0ij7rhewNpIoVsDJUMN6DkgMyCYyE+N4SVEG8Fl4Q9HrXtg19r5YiJOHHRqzqOwoUsNboryVftnzLM4GCYnOn3IJiMcmRV659uneSJeR5IP/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653897; c=relaxed/simple;
	bh=L5fRPjpFkyuJHOnuudz1rB6Fd4r3iGTvmDPJWyU3Odo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjvP7RGPmEcBZML/09n3DBzmoWQFVqmajhnUKUBivdCCzJicSa6eM4I8XbsA+/sEoFHu0FjTEYUooRAbyQ/DHO4jdnSRkpjFLqOxUJ4FOWgIf9VIdQhXr6MoIqOV6aIKzj7pjjiBs9ty3//rBQYwDdKO9dWarm3fZRZTyXPnWJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=RQzWmoMY; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=hfHXmYBN; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6XnWA2292231;
	Wed, 16 Jul 2025 09:51:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	nEkmMF699rVALbJBpgYAWNIrWaqpJ/kyJY09PT68QY4=; b=RQzWmoMYmXUgKzYl
	nLbbxl8AZ3y2XLj7vT/8DvUUPLjoq/NpKpzYN619naU/5oj+6L+0LU7htFv0eQW7
	/HApSvwS9wE3XnCG2dmw2Aajc2Uf9W5RAJkcbKE5QmrIJrNI0AbH3eJnaqt44zW5
	TJikbsfHZ0QSS2e2k28LGuR6l23yniHG4dd1Lo4iFUn4E3dxno7agC+KNgqSVGv3
	dYt6XYjH9fkWy1V0F2m+R5s9EUmAAyTq0EvrZIMo9LpazA7ZAcgA12O4koAIntLt
	095yPDyzU+ebhMD5piC6urPe9zR+T0hLGNzWbk9ZAancvyUEizb2HaygS5ErMzlu
	00MB+Q==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2102.outbound.protection.outlook.com [40.107.249.102])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7n8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:12 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We2PXRsQZyjQOCjB1IEOsjIEl03YQ8GtWSkDN3MIhFiLwKHcCBoDL4fUrfGnUOgi0FYMGuqSC7oZR3nYdeXC34C+1F7DQT2P/u8DhteWZtF24h/jYBoOMFgxM62iZYFOLZAqrZo0CtKN8ER/CY/R8yZkZQEL9FYxqeggNBPW94QGU+xOyZbchDZKNc+cXbHbyaUk5qeGGyNw8F9oSTX3+/NT55WnWJWcdvwR9PD5gVQpi8Apii5jofsALTvDSvTZKjSAmYrNTIj6aA7kbMajKoQAtEyQN5GCk32W1/XBm+kOSaYYjbYtunV9QhOzJo9mh+gt47NSJCbaSsitzE/kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEkmMF699rVALbJBpgYAWNIrWaqpJ/kyJY09PT68QY4=;
 b=hp3B5pbbCpyvre4bNfHxQfuwWH6DiYoWYyCGnn/gTyNcMH38DrlwtZS6mlQG1TjKs12+S5EUyM+7E5UBnwToGdJZzpkJ8jnO6ue1+s4igYDdiqG4X+8ueWfuTL0Bv0tkeqIa0Cf3eVtSrzk7rxJh7ApFUTM3CoAc21z/hyv13PwEQpV7T463tWE78nkVxP0SFlulps/bbjfoUHABuKtLkEezCJ4MBs9JYaNwIHTM2w5BfcsJGvODVfskjR6XG8nxdlTCxfdpNEe+2+q6rDfiOmoyWQSi68Zlzz7Hze0NCk+amxsJYflYAXKoAZlvFDnj6hO6RIXAlrCLyyoNBeuUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEkmMF699rVALbJBpgYAWNIrWaqpJ/kyJY09PT68QY4=;
 b=hfHXmYBNF7qsF3qAwgMa6210Rqf1ugrqOctkxFrKI5rmy1aZYf/sW0r4lEh/FkUHYUo+lJiwLQBvdRLqWVvUDPLXssT3tK8yVl/sVQ+R9Pe0uZkK4lr6BpASDvRUp9ONWFKovPr+8/kH1Ccf1uTZCcreRArWl5rTT3TRgWE46g0=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:09 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:09 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 01/11] wifi: ath12k: fix endianness handling in QMI host capability request
Date: Wed, 16 Jul 2025 09:50:50 +0200
Message-Id: <20250716075100.1447352-2-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::43) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 82825dbb-74c4-4376-36b7-08ddc43d8713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6EFFpeCBIHp+48ar3JdRzBExds/y3yEmJ/ZvNQlgTkjaC3sJwFh+lOZEaCH?=
 =?us-ascii?Q?M0W7nRkzwx5w02Yqfl9f7NkA3AB1Cnun+gbw8gKNbEriIm9whPhzdZk6XUw3?=
 =?us-ascii?Q?do9cTFhd+u/gl81LWgeMw7OM0tQJ7s07XDHM2dUV5iqAQF69WprXodeRcdmU?=
 =?us-ascii?Q?SMl7gyubQPv5al4u8f5IUSPAjP0151qbKotDk0SKonfQvUuVtv8Xkw19BjJN?=
 =?us-ascii?Q?3OQMU8faeCB2MvnoSeD7UxEBtqL0A1Fqsrzq5y0B3brGd2cXDzsAAHymBsSW?=
 =?us-ascii?Q?XrJ7VSYhKbR4kC2jw7+bH+h12PIfZ1S0Y8deNcSoKabhD7a7TY4cO4dw7W5j?=
 =?us-ascii?Q?bRAOvkbziOOd8K5XSQPODDIMtNVL4kRorbUleEFuiAleoOFhZzeej7pPktmI?=
 =?us-ascii?Q?W+lHHLCHnUyiidTnCFYxjY9dPkkbj31DHT2kW5pCfkkYMRFrE2coF0CCLORP?=
 =?us-ascii?Q?BqIU2SknSpo353LsKwLG45U4/cZndXbxJgbOLuAQGhISVraC1gf6HchcC1Nf?=
 =?us-ascii?Q?GXO/Dt3eBOkGKex1KcNSLBJjluvWrb2baVscLLJQixQd0armdaQ3sV/LqwCQ?=
 =?us-ascii?Q?UgIGapvcs9LqlYdLN92dsJfWGd2XKlA+mFavvSzpCKfprUQBjnHHceMsalWy?=
 =?us-ascii?Q?KiytNBmpOuVOj4o1+j7gvgDx/lAhMUncvDHa1pLu3tTfHRlDdGV2P+qtEd8q?=
 =?us-ascii?Q?o/pggTEaV4MWuR6LOS/GiRFEFwuceH+ihe/6whciDbsmeuIOY9okg7td1H5J?=
 =?us-ascii?Q?hW4SgvkyuGMCzHoGSoy5sPZZBoOaom+WMEezvO7TxlHbek7Wxd/829Yzvofk?=
 =?us-ascii?Q?VzX9wDGvr3M6pIcq7ZTbKL/CTSGEadtzr0Z9ndMB0KPuDPS0FaEFIqa3KnPS?=
 =?us-ascii?Q?J2qsYyx38m886RVGpKqeR6sNf6FzaKKScqNMhRUrZ3s1crQUDZm2IrUNnY17?=
 =?us-ascii?Q?xzTN/z4sKx3bIDQ20kRp7tOAYL+7QAg/ADF4wZGn+0FZmnv1mS806O9+vcwX?=
 =?us-ascii?Q?0w4QU2sVg9U6mKjl/mqDn4P0OjP4tcU5E0NCx5VSDxzT22bL7WfAss2duFqH?=
 =?us-ascii?Q?z40KVgQ4DsaLNWPkVSfGHAS0g26ii6qgC8/xNgvg8Ux+Vij00Obp5XW0DYMm?=
 =?us-ascii?Q?YyxgdtMHItaXXdIvETeEe2IRNyaeiVowocDHo0dMnBudL5CUqiVEpR1DczED?=
 =?us-ascii?Q?fW6I3Up4dFpu7Q/lnJ6kPI1yuKVfH+qwGCisZK1CTX9gNMT3Z4sNFX2QF2ch?=
 =?us-ascii?Q?Trh/Xh+ALDCZQLeQeD2EyohX+s/une5dVN/5LNSHEpYnC06tkwgN8ffSf+qq?=
 =?us-ascii?Q?7ZnN6XQhXqdWN6/WLpYOSoW1wSnD9aCNVt9hqFligZ2dJKrY3JaqCFSVt3zo?=
 =?us-ascii?Q?6tvhjfocVP77gygi6oq6gZOVMSVLtDoTsGPsgC0diPZ4QSR7KaoR+7guGqjH?=
 =?us-ascii?Q?sO0nKKAUo/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skmOpJidFV0gSw5plWcMCQXMPU4AxC67f5sz17UwRsjcHf+yTCha6wqMjzLN?=
 =?us-ascii?Q?9d4sQWBxsZ46LYZ8yJiki0gGYMxCSAIkwLAbAZu1fizoDtVOQTaqaWowBeqo?=
 =?us-ascii?Q?4+OPc3Kyc/ovIPHJ+kHYnM03O0GZ6Z7Uji3+s1lHEKIuXk/dFlOdJNJo3jGv?=
 =?us-ascii?Q?LSatbEcgcLRAki/Xx7Tu+2vmGR+bvsUXK9FtpkFT4gVPkWVlOrDkW3w3kglt?=
 =?us-ascii?Q?BPeV3SkaTXcnol+4ZhG4SWoGRvXmtU7YW4w84mAppqZbEPhu1eBonFzPU2Ks?=
 =?us-ascii?Q?qkf1k3zz7MPSSGo7SHpxr6epBWsW7Da4sB5qPhOm5Vlt7qijfYo7Zkyq8wiW?=
 =?us-ascii?Q?l+4QFWvyxTn5lSjGIpFq3dy8QvcNVGRDdVJZ79PJFn5PK8eo+qtCL8aP5kZL?=
 =?us-ascii?Q?i7wuRjk9P1sYQHzl5+UCwXmhrOJxtQ9UU/FxL3MNZ/trPZHZH9THgOQCGCKL?=
 =?us-ascii?Q?MvZvJIGrCQBhKlWXyCRUWgyO6C6mhfO7Lld6NUfW3UUSsYjuTW5bV0QDATeE?=
 =?us-ascii?Q?sfQOp/AAh36Kb+ufoxOVNps8o3ojNV+paFxX7n9Wd8meJPpServA0begKxjZ?=
 =?us-ascii?Q?JKxOkKWuAWwWgLGstDv9TyxbYw9sV5zCL3Uv33N1UWmIc/+FNMEKpwGGgcsy?=
 =?us-ascii?Q?NC7KdM+VDmL+VAtLnp30Bdym/o8q+H4dL6MKVfWI+p9tIAouislF/BHXrfHz?=
 =?us-ascii?Q?STd9Qr18R2e49L2As9SRoEg7R/55CkoYeclcrYmOqK871Mh6tYcJqSi5z2F/?=
 =?us-ascii?Q?yKFi/JPD6qeMKdvY4mhLHK78StaKwH6lfWQbTyuWLNwQ1YeQmkiD7olxT8Sc?=
 =?us-ascii?Q?HLHqKXq7YLCspFOe4s3LWoU+ut9RmtxtKnqECJtV1N+cBnUqATifTIK0n6pq?=
 =?us-ascii?Q?Yx6wqP6CEQ1XP+G0InGMhu2aqQ/QJiTsnINoVNpa/2yhgFQ8AQfQv08tqGoj?=
 =?us-ascii?Q?ewcr/cD+p4hmd4FWsl3MFqaPu49x86RK1z0ueQOCZadxWYu+JgF7tsSEwXeh?=
 =?us-ascii?Q?K9aMdcMG9+Wx1SSO9SKzhz3ZhwZlZ6+UtaXFWc1wR9V7UXxCYrOv8hG9Nft8?=
 =?us-ascii?Q?dxu3A2Mxi7yvGh/7ev+0lUobGniDIUXcSd3kKSV3876yAvX0KjGU3Z5pMxtH?=
 =?us-ascii?Q?fhFuM3XhPFEoODgEHOLW3AuAlLrFLK88oo9XNRMd0cgGkHdt7EJ08zsdGXci?=
 =?us-ascii?Q?3ptPB+wuFFobFenaVgAiNj5UBXtgCtZuAZtT33FwNjKseYo/yF7IAIGaj1dp?=
 =?us-ascii?Q?aFqKmLePEmDCFzU5ZZlIgqeeeGMj/GXtco97nHjioGdMetLMlH1o/EN76Ocp?=
 =?us-ascii?Q?Cm2ptmJVyEWk5FjV8MTTk7hu7Df7TOIuH0Mamnm/RqIdBAUN0FuxI1lIckPJ?=
 =?us-ascii?Q?3WC5QdyHFgrcog+83FiMpKGT0RDIv4ewKokYHqqUN3AJwgp1z79QCAceBIO/?=
 =?us-ascii?Q?K3CU6NeGAssQewsKhmRDSC4NMfsqM/fxPusXRZHJlaOlZHzcWlySO9rjF7H2?=
 =?us-ascii?Q?ZburvVzOV1WCKlkGKuTFNPgYzBZNDNpovMlcIigUN55zgcw/M5iofh8Q4agE?=
 =?us-ascii?Q?DP7z+kioX8DAP464LB1NM2pluB5aAEe5PeYzRkgE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zw3e3QoqeAHEylteQBEF9AUNDav3SlU1Bc1FG3vLtjV7JA0NK3b91ZEA+20VObwqEMDcJizrxvjX0O/VAs94guK+191iGvlMfGNZSoHqW1mNI0TpcFJyChWGeoSmY/QU2EsZ6Bh5flC4ULYdjOo6XBslXvri59xParwYaVdT1B4np3eId3tLtAF2ni5bS+AWgiy42reMRUuW/V3dJ8bbw56+x9fcCGOJ3ef4UArDaSapyxVz26hnGAqKIxxbvEGLNyAU/lDJ66Bdk4vfkwxPhToZtNNowdQDBuSidj3Pry0g+GbTicfNKO46AUulTq3aXXcKnJDjcWHO9ZRLduOMYVqpEThbpYoWOJVO3FZVXS+qLd+ib0LLFFgvi2ZXSCTia5Gk0RZeqAGnPWpseSctjiusx1Du+6TegpTkaYK16Tx/YvqCQRddvkahezNZcPxnAYf3AzhnFVgMUV5WQgBdgA1/7Xbg8LZlHIEAHe4X6xOxwiVWbcmnJ4bZfdvS+egsGoZM/he/09YoHl+gJFZkGihT92KkAPGd/jnqDspPI6/ncBSVHfZLNqhefJR+IpFV8p/yJ46BSxrRwUaWLNh4hapumwQFvTxZc0BUdwhE7DliU8HSnBrD5PxWxr6XsTP2
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82825dbb-74c4-4376-36b7-08ddc43d8713
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:09.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFRnodXts+0ObbrVYrXyD3XxPg5oWuuJLSIWH7va2iikU64J/sLiBof8w8jnFmN2BREDRHEwkrYtb013nxudQA==
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfX6kqKbxTSYbC4
 6xZKeSG3ncMQJxAr3P+hvuJaqugMYAMZqOzlVqwlBz15eOTXeBMsW1CrfG2Fm6mKxcyIjYlx20Q
 lduCOe3memxMCYQvVxT4Cw/Nh9UegCFmG+KS0VTNFgiywGdO3j2JsQl/29RPTLkKwQCX8XEdXOF
 DALK2ggUGUpiS8zFWo5GclhVQ6PjOLpOObFkkLhXnaNAWTi6uUL0MVzbpWfRTy5pBQd8NFDMl+f
 +k4AR+iPBwzrLrherHV8hcUApPCK/Fw1fTUSbHW5EYref1RoLcJNniLrm8IqRdLTALeEVUPSOrW
 yYKthEWo6qbGb7x0J/99lNBSagqn644mNXJjL5p2rjd9PI4TZdjfB3xK7yAV2Q4YNxOTNpq+nFl
 5e4RF2oK
X-Proofpoint-GUID: bYcTCcbEQRr0x5DySYFSWaRxQH5_W-8u
X-Proofpoint-ORIG-GUID: bYcTCcbEQRr0x5DySYFSWaRxQH5_W-8u
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759f0 cx=c_pps
 a=lAFVUdC4KqDR+XbUfoMjaA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=g2gty-AKM3KxiX33rxwA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI host capability request message and its associated
structures. Add missing byte swaps wherever these structures are
accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c |  9 +++++----
 drivers/net/wireless/ath/ath12k/qmi.h | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..2287ed87dae8 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2073,14 +2073,14 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_capable_valid = 1;
 	req->mlo_capable = 1;
 	req->mlo_chip_id_valid = 1;
-	req->mlo_chip_id = ab->device_id;
+	req->mlo_chip_id = cpu_to_le16(ab->device_id);
 	req->mlo_group_id_valid = 1;
 	req->mlo_group_id = ag->id;
 	req->max_mlo_peer_valid = 1;
 	/* Max peer number generally won't change for the same device
 	 * but needs to be synced with host driver.
 	 */
-	req->max_mlo_peer = ab->hw_params->max_mlo_peer;
+	req->max_mlo_peer = cpu_to_le16(ab->hw_params->max_mlo_peer);
 	req->mlo_num_chips_valid = 1;
 	req->mlo_num_chips = ag->num_devices;
 
@@ -2164,7 +2164,7 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	int ret = 0;
 
 	req.num_clients_valid = 1;
-	req.num_clients = 1;
+	req.num_clients = cpu_to_le32(1);
 	req.mem_cfg_mode = ab->qmi.target_mem_mode;
 	req.mem_cfg_mode_valid = 1;
 	req.bdf_support_valid = 1;
@@ -2182,7 +2182,8 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 
 	if (ab->hw_params->qmi_cnss_feature_bitmap) {
 		req.feature_list_valid = 1;
-		req.feature_list = ab->hw_params->qmi_cnss_feature_bitmap;
+		req.feature_list =
+			cpu_to_le64(ab->hw_params->qmi_cnss_feature_bitmap);
 	}
 
 	/* BRINGUP: here we are piggybacking a lot of stuff using
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abdaade3b542..ed7808fe2b71 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -164,8 +164,8 @@ struct ath12k_qmi {
 #define QMI_WLANFW_MAX_HOST_DDR_RANGE_SIZE_V01		3
 
 struct qmi_wlanfw_host_ddr_range {
-	u64 start;
-	u64 size;
+	__le64 start;
+	__le64 size;
 };
 
 enum ath12k_qmi_target_mem {
@@ -205,12 +205,12 @@ enum ath12k_qmi_cnss_feature {
 
 struct qmi_wlanfw_host_cap_req_msg_v01 {
 	u8 num_clients_valid;
-	u32 num_clients;
+	__le32 num_clients;
 	u8 wake_msi_valid;
-	u32 wake_msi;
+	__le32 wake_msi;
 	u8 gpios_valid;
-	u32 gpios_len;
-	u32 gpios[QMI_WLFW_MAX_NUM_GPIO_V01];
+	__le32 gpios_len;
+	__le32 gpios[QMI_WLFW_MAX_NUM_GPIO_V01];
 	u8 nm_modem_valid;
 	u8 nm_modem;
 	u8 bdf_support_valid;
@@ -228,31 +228,31 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
 	u8 cal_done_valid;
 	u8 cal_done;
 	u8 mem_bucket_valid;
-	u32 mem_bucket;
+	__le32 mem_bucket;
 	u8 mem_cfg_mode_valid;
 	u8 mem_cfg_mode;
 	u8 cal_duration_valid;
-	u16 cal_duraiton;
+	__le16 cal_duraiton;
 	u8 platform_name_valid;
 	char platform_name[QMI_WLANFW_MAX_PLATFORM_NAME_LEN_V01 + 1];
 	u8 ddr_range_valid;
 	struct qmi_wlanfw_host_ddr_range ddr_range[QMI_WLANFW_MAX_HOST_DDR_RANGE_SIZE_V01];
 	u8 host_build_type_valid;
-	enum qmi_wlanfw_host_build_type host_build_type;
+	__le32 host_build_type;
 	u8 mlo_capable_valid;
 	u8 mlo_capable;
 	u8 mlo_chip_id_valid;
-	u16 mlo_chip_id;
+	__le16 mlo_chip_id;
 	u8 mlo_group_id_valid;
 	u8 mlo_group_id;
 	u8 max_mlo_peer_valid;
-	u16 max_mlo_peer;
+	__le16 max_mlo_peer;
 	u8 mlo_num_chips_valid;
 	u8 mlo_num_chips;
 	u8 mlo_chip_info_valid;
 	struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
 	u8 feature_list_valid;
-	u64 feature_list;
+	__le64 feature_list;
 
 };
 
-- 
2.34.1


