Return-Path: <linux-wireless+bounces-38271-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rkWF1cuQmqP1QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38271-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:35:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C16926D7899
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:35:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b="OI3/p/Wr";
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=DQMxICav;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38271-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38271-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C607130068F5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C553D649C;
	Mon, 29 Jun 2026 08:35:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589E3F6613
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:35:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722131; cv=fail; b=nREVFGpPc93n6T/lnwLj85Iu0m/5Tdsuv02Xx2JnRarjfLjLBI5ClGAcrhBIx9wouMfbMbi6qzC305+zVEyhmaGXxE0gZ81tvQwB0b2anTI+kSqM67XJAivm0RwlLmalNe/OBmcyRLdj1iRc4e+OSxP9Fle4YNsICFU6Mg+76Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722131; c=relaxed/simple;
	bh=hoRzvfAwBbV1BKLqwJNwRVN4iuPdM8F8ZF8Zi51r6Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bh0Sfo4TUqVZoqFBrhFps+ks/iiJPVIr+qNBrNh1LABzy9/m7RzZovoHTZpRyTuF+HIDH9B9Qnch64C6moXFMKwXky6gNgSAozxNq9khjWvKobJOCu/pL5g++vZptx9bDp6LIZ7ancC6sTNcrX3tLAxsIZ7KRgFnjPFddv1iRvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=OI3/p/Wr; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=DQMxICav; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6o9121720244;
	Mon, 29 Jun 2026 10:35:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	XSR9oz33wrzfP57RQ6m+LfSeucfHd6ACCfAJzqPReiQ=; b=OI3/p/WrijHkZ/a+
	spcT77DtbuRlTMOG2kWk9oBl7QplbZsq06wvHnb0gTd7QsAB7iqtRf9YD17dFxMV
	utTBOW8qaMHNKshvDVvGPL/mXDuX89fKOw17GhiEOomcrO2WcUVvB3m1gFgRqGcn
	C/KROAaVZhZSCr1GlOoKW8j1IRbSfmrzP0fQOm4vG8LPGm20/+P1++Xv9hz7Z4VV
	81sswcPtjeN9tfcWP+9qgFF2uDNLdVxHSbYGjVdKx9u+8vPGDi+98BxWtKZgkSvX
	dd1J6syNMYPBU+XLdXVJTJUJdxUL6yoK+rMm+zIFXJs64GTJ/AsJYdt/HLv35xX4
	uAOrhQ==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020081.outbound.protection.outlook.com [52.101.84.81])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22h0t9fp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 10:35:19 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjZUTRR6oGEnp9/h2l7b1nNeIPZFX2zvs/xrKu+ligj8F8iMXSQf9ojKb4O9yUacKWYK5qPcwf05d7tW9BphRMF/z1mjiF3hgN4jTkQvsqA+z4CINf+QCOh8ASHUDKI5VOhO/BTowOt8+leBIHblT4fTeWhnfGHPnNjXkafp5VTbptIJiQqbu0Rpp5KKrqImEQ9I3z9FYAwLjAz5GkTwnrqH+lsH4FzQ1laxXEO2lB/OcSjzctQwa3RkkJJ/KL5U4VPFLFE9QRBOXvJfeIrB/x5tq6FjjP9cufmXnKU69VfHSDrgDJdXCGpcP/3pG3fieCMbMb8MSN2/Rt5VZhGv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSR9oz33wrzfP57RQ6m+LfSeucfHd6ACCfAJzqPReiQ=;
 b=iuEnm7EtF3ydR39hfwwmbr3giU3V8h3lWtu7TD9VGBy+3dFp2D/td7yZcVab5ukWH98Huz0UUiMoA354GJWdlob0mupKrdWaK0IESD5tBBgEannh1ZDafcJfNCgpP+Ta35EqN/htIu/RkuegMDcc2jzecxiXzZ9CDM+rIuiEN8wowULi+FNtW3RP+4uoJ5JGHvTum/Od4WqHiOWOt4W17x4V3eMYyT1upH6qgTgVvfhbk1rBqJLVye1ypAdCNKfnGOAwW5t7xG2mSNJfvJVAj5/1fqFNW6uW2h/sEDe3zvOJZGPqc38+bH/cyNbF7S1RucGSm3567tZD636GjMEo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSR9oz33wrzfP57RQ6m+LfSeucfHd6ACCfAJzqPReiQ=;
 b=DQMxICavKOXWapcC/YV7piKua2vT+BQg5jdsICz9EM3DIykySGuQ53tDUhXHy+NJfdcEIOzPWEwok/NaTFd58rixOolFj0bTlhY+X9z74baMSuPg2o9Jl1Kbz7QwMpTiB/iyfmThOBop4dr//IpTmvAvxP/S7fVZ8WqaHWkZMic=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AS2P192MB2034.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:545::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:35:17 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:35:16 +0000
Date: Mon, 29 Jun 2026 10:35:10 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: ath11k: BigEndian platform support?
Message-ID: <akIuPiYGXDbDWLGZ@FUE-ALEWI-WINX>
References: <68290980-5bfb-c88c-be78-954f9591c135@westermo.com>
 <87cz0y96j1.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cz0y96j1.fsf@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF0005F6FB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::25b) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AS2P192MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf80884-9c41-487b-b775-08ded5b9585b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YfVICsBFp+X9dc+tOYAXS2bW2Z3/tY9hb+kK/N2Jl9EB3B3y0b5fGfT+iF+Q6Wyflmm3zfhtI+gTB3axZcwDI6Y5S9LD/Rj4SYZ/JUGv8bqarw5OTvoeF67Fvci5l0DF4EWjnuPf3U/9R3cSDaRf8S76vWd0qA0AUbIaID/VFovoUT0MWZZNlNO2X2kkhjXA5YaPrZZ4Ym5pG9pMt7XhNEbqTQgk6BvdQvSH23cwH4HS0nEQj2o2oWPsMlIxBTMOIjIvO6qsn0siNOmHxyEt08CpvpIX65EmUdnjtvOO4qCNxCgHaoFyFHFsCqCjlWcKEZnMT11WhwQVNeMcTERne/W2MJucmloLSgian2XzI/NQosR+0mww0hW9qhuoyyHzxvB4AxXV4iYtWOl5PITmfQkPSpLk68cg0mxUmVcwwqpQGSYKusWs4PGBU83tG645yhCkQ6BJV7gluN3bxViic1LbHb9dq52F+Iv0ZMJ5RzmdqJ0FlZuwW3BE10HLb5NNr7R4EO9zsre69klOWXafxebxDIhSkJfWMbsNrfgHUHDkcarf6viF5JebB14yUgq4s9kjaUznbEQIjxQvYNGAcq/i7jyOnsTuAWauMGbNg9VHdYMGAbWVjIgzsgKDI1lxguV0Hm6I8EdhLoBAPrCU+xjGO21D7J8tc0FAIEz5G2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUd6dFJ5ZVk3SUMwWEoxQWZqQTMxWEFJbHV2QjVLaEhWQTU5MTZ0SjVtSmNn?=
 =?utf-8?B?MzQ4VmpFSjlUWU9iVDc4UkNFbXdZZUdtT0dFMm5WYlN2Q0tRTGZnT1dydUZa?=
 =?utf-8?B?QjJXUXoyakNidHFCSzFEYnExMStMaVhNalNsWWMrOER4ZjE3WEVzTE0wbGdJ?=
 =?utf-8?B?eEMrZW15TXcyNElNc2V2NlBQSmZNR0tkc3lEbG5mVmxIY0krcE5kUHE3bHkw?=
 =?utf-8?B?SHlQcnd1TnlQLzVyQTNBQ3c3UXFhSGhKajRLcmJqR2h5WFNiNktDaCs2Yjdn?=
 =?utf-8?B?TkNHZWY4OG5lSnVCb1AxQ0t6ZnFZT2NXakIrUTQ2ZVpMUEhYcmtnOUx4cDhu?=
 =?utf-8?B?WERsd2xSTSt0R2RSc3pKUkszbWZnN0hmMmd6dmdwYnd2RHNvZnFkNW9US3hu?=
 =?utf-8?B?dGQrdUpWYTNhZDkycEkreTJqRkxWR2hKcGk5RmEyTkdCNHY5Q3hDekFuMy9l?=
 =?utf-8?B?cWdiUEFEUDViODdIYU9idlFGN0taVnJZRnJET24vWFhEazdzVGZ2MmsxQVNt?=
 =?utf-8?B?Sk5ZTGlNZ3o1aXhqVXBCa3ppOXRFYUJBQ1ZuWUh6WFBBejBQeGw5cHBSN0d0?=
 =?utf-8?B?SUxUYnhhSjljekk1K1RkQmRpTVBqcFFaU0FvTUlKbUM3dlFDQWtvQTkycnJ0?=
 =?utf-8?B?S0tCbDNzbUZVUkFoT3gwRjNjS3VZV3c1RXp4emFic1U0b211UXY1RGNnQkNr?=
 =?utf-8?B?eWo0Ym5EbVRCeEVBSS9NcVVtNkNaWEhHMitoOHFvY0pENloxY2JKQTJHejFy?=
 =?utf-8?B?QUhCQVFtVmNiOHJIZFBXZFM0b2Y5MncrTVNJWjU1ZnBnMTBhZGJuZUZtWjZq?=
 =?utf-8?B?N0kzeWxOL2VVUFdudUxyZFdLVXNZRVF6MDIwOVI5T3dIaXZacG4wNVZZbVdN?=
 =?utf-8?B?ZE91WDhXaGljUG9RMjJDUXJOTUVJN0RYSCtaTFhXODZoVjNnUGZNZ1FGY3V4?=
 =?utf-8?B?SzAxcVhqM1AwK3g4U2hGYytmWWF3SGpRYXlPSXdiSVFqQ2NBeSs4WGZtZlk0?=
 =?utf-8?B?L2xJTmNPRjdYUERKa0Y3WGVSaEp3OUV2NksvV1BhSDFIWkJsY1pvMmhTeUox?=
 =?utf-8?B?cDVpemUwVE5iK1MxVkNtcDhkTENFazgwWm1GTTNJdXVSNHVwdkxyeDZBdll4?=
 =?utf-8?B?Tzd1N0czZXRkSW40clhKWkJQWE1vTWdNTk1UV0pLTER2R09JN2FzNDFzSkZM?=
 =?utf-8?B?eFUzM0RnTWdjaXN0T0JuNGlodWNBU0hJUUdidzRIbHR2N01WNk1FN0RxNmph?=
 =?utf-8?B?STFDYzBiRGprcHVBZkIzVzFGOE4rWXZlRWtYK0syYmJ2UlVRMldja0craVpN?=
 =?utf-8?B?TjEvaXpqNmtGNmZPcUNpOGFJZlFxL0xWR29PcVdlRXNyVnVWTE5UY0ZVbnRW?=
 =?utf-8?B?eFlyMlhRQmhUWjJxZzRQNDMwTUZUOTI0WHRqZmo5TXJJbWhTc01XQ2RHQVEr?=
 =?utf-8?B?VGc5UWhMWnFKeUZUZEVMUkg1NXFscXR4ay93VUlrZys4SjBEK3pkSFAvdTYr?=
 =?utf-8?B?VGlKZERORmxxR1pWbk5uN1lGcldxVWI0M1pZYkVURHFtU2ZZWmllNlQrVW5h?=
 =?utf-8?B?a29XQmMrSnFlYlpqc0xtZlFKK0FnR1NFODZJZHhRdzFPbHRrSXZPRm56a3A2?=
 =?utf-8?B?UG53bWtPMnlRNFBjVnAzRXBsSXlZME5OcWF5Zzk1VWJFSktUcWMycFUrd1lw?=
 =?utf-8?B?UVE3ZjFPeGE2b2IzTnFFQ2I4WjRwaWQ4OTk0ckhFLzV0Z2I5RE9ENUljN0s1?=
 =?utf-8?B?dmJrdFVWb0JZdTlXeWFIVDU4dXZtL2FwcDI0Qmg2bzhPVW1uRHZzaGNveE4w?=
 =?utf-8?B?RDA4bVlyc0RlSWhpcE41MEhSeE8rZm0vRjZwMURmaWZ5aHBxdjVpQmdQcks5?=
 =?utf-8?B?dkxMSFlIZW1GTGMvb21QNm5qbEErS1o0UHZPcStBbTUzQWNRekQvdnJmcmFk?=
 =?utf-8?B?Zi94UUJxTDREa2dHMlN0RVorSmVIRlJOaUhoVEsxWXI1S2I4MUs1Y2xpS0dL?=
 =?utf-8?B?bXRsS0RhbCtXNUlzbU03ZE5JMHFiaUlZaUZFUDNIdWVyZjNQV21ISTM1SHBO?=
 =?utf-8?B?UzlaYW9VMEZ6NVBsSlk0b002NHN1UCs1cmxxMHdVd1FSQzlxeWxra1dMMDZ3?=
 =?utf-8?B?b2ptZFVmd1pqSzdYQ1dsZlBpem8rUEVadWZrbGxxcERxMFFYb1ZWdVFEbFhy?=
 =?utf-8?B?bE0va2o3S1hNQVVqaW1PL2xVWlgvOXBuRGxORkZkcWkwMXFUR001dFV1V3NC?=
 =?utf-8?B?TFRCenpybzIrQlU5TnpkQzhLNUltYUVPNXZkclFmSUJhZlFzWDhTdlFzOW1R?=
 =?utf-8?B?N2NqVldmbGliL2ZjVVV6L3ZyejZ0VkU0MWxiMUlPTFV4WWZQOGcvdz09?=
X-Exchange-RoutingPolicyChecked:
	OD4bScNuW7LvxAh25o6WNOWDbTo3351NME8Swz7O7t4uCLDpQgD/Il4rQ9a6SKSWokUnsm1QT37FU5beFPKrSgMuexeJmQD5Ae8b40A3rJnriEy49vq2VSBgdbxaziF05CXOmacfqMBoIHwq98CJzrfvwsp4L/8isZJrfYZ8K6/M/95HSKCpjs4JICFaJNGhTR9IyC2NmEsAKaHk/E2TxTu3xnrYjwqjOr/J9xv09WrX0wUAX/DYCt4r2hZ5r36FezG9fshOnpltvbTGdkHeOLlbs3znTP8IFMh+7IwHYQavqzrEbMIL5T7qFauQfyvUJ9M16Z4BIaInvddzMybWuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LRE6SS/w0pMDHgv6HmkpX42Xmgeftwqd5na3rwD9RdrtLcmKG4PSsKfT4Lmgvx5yY3e9vUStiaPzMK6ZTGjOfZx7gH8L7S2adPw3hhLx7YdrVGZFBgjG0tMjAf0TEdgqhXXMPGMAtio+uqxqINsdzSX2szn3Ep+zaIXxzIapnEnVCbGCCOlaa6dXx3GlW8IGXXEWTMdEZDN+Jp+llOoK6GLF1uTilcMGTD2Js+MeesPDiYyiEzGJM0wxg4JEZjBY/s1GiNZAvq0EQnvQnFYKZenxnKHfrX8UXVl185HhZnF+0RviwFtrclQ1JHYoGpPbb90al03SOUrc/cqwD57iYBTq7N7N+undf0QuGR2Db5lP/KQNpnlh9ZWy3fg00nJ0KiA9NLiiRvHalhcl+a0zbYRAwGVYFh8D2gjaTcZzWcTsg9PfcBNiFb/8BPSn3ns6CWRxYR4RCHSVJbZjJQ/otYYZR5k0UpSLrnhYJH1i99qh293SxSsVq/H1cgba+URQHezItPBF5lu4pvkEoHnLmjyV/OZjaFgf0QNQ4CSKngf8DByCcQ6yzz/kVuwhuBzMWXeVWiFNrRTNt6aeKVqSyBz6CdQD173Dc7n0/HKvL+y2zfMT1debk5m7ty5YaPV3
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf80884-9c41-487b-b775-08ded5b9585b
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:35:16.2368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR8KxYrqEi9K0sogGk1xTF+l0xBSuvnWHWnaTJcC4GfeIKsY8yfNpqXr3nT0OlXEFrpLiqEPnyKhvSXYqEt2iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2034
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
X-OrganizationHeadersPreserved: AS2P192MB2034.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: JbjugaRk58VKn2diJ9h5GRrXZ_EvLGgJ
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a422e47 cx=c_pps
 a=ftZSLPtEb78rP1Exs/vLAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=N9GNhs4bAAAA:8 a=CXqghErFcBrKDzaj8lkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX6Qj0jsIxu4pa
 hJ6zn7IHpkX7r583F6SSuEDUFoKFPFSLcFzLsMD7TSxFgWF3C9cpyWXU4Ota14h+kN8XnPagfOE
 nJf1890X2wPjYjUMqUH5Ni6WCUIjK2U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX7dw6HxY+c1o+
 v+wnFXBN7mpRySI6JsqgETPnAVvwRZMds6hT1wIesASfo2oJ72IFbEXs70C5Hy0mt13fVNSPT7c
 3VLyQc+PdrR2jyGfxIdnrGmmuCj5oMud1F90T6RqVva/uQZvSWYKFCc7ziB1pi//1wKK8mfZDDe
 xueTaRwYJQTnzbb3jcLbgrdhTX19eH6tICly/UlpRbtt9JjsBQRjXrlD35gfPGzZEHAzFdpkrnQ
 amiruro0T3nre8qmY/281Cfpvf37yOhxnFFgx+PGhNIPBhVQaSIA8E/Nifm6pxQcBmhN49Gt7ri
 KC63DILHoLuRAH/jcvBDAIby1cFVFNdcODHRLulEqP0uQ6g9gYtxiy8aEOk/Ee0DGxBEzyxd/DS
 c0D8UdxRLkQtrFVWeR/BAbb3udNyleZQLalA94A2kIJdmU7y4BZ4DtXB73ArN1CQoa+5CEIv/OW
 s2RVAXg77iAZ8r3Xa+w==
X-Proofpoint-ORIG-GUID: JbjugaRk58VKn2diJ9h5GRrXZ_EvLGgJ
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38271-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,FUE-ALEWI-WINX:mid,westermo.com:dkim,westermo.com:email,westermo.com:from_mime];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C16926D7899

On Tue, Jul 11, 2023 at 11:49:54AM +0300, Kalle Valo wrote:
> Alexander Wilhelm <alexander.wilhelm@westermo.com> writes:
> 
> > I am trying to get the QCN9074 module to work on a BigEndian PowerPC
> > platform. My question would be, has anyone done it yet? If not, what
> > kind of effort would you estimate for porting or are there any
> > firmware limitations?
> 
> This is a good question. The short answer is that it _might_ work with
> QCN9074 but AFAIK nobody has tested it and I'm not really optimistic.
> 
> The long answer is that the big endian support in ath11k is implemented
> in a weird way which I regret big time. The idea is that the firmware
> does the translation instead of ath11k driver with this flag:
> 
> /* Host software's Copy Engine configuration. */
> #ifdef __BIG_ENDIAN
> #define CE_ATTR_FLAGS CE_ATTR_BYTE_SWAP_DATA
> #else
> #define CE_ATTR_FLAGS 0
> #endif
> 
> But later I was told that not all firmware branches actually support
> this feature, sigh. To my knowledge QCA6390 and WCN6855 firmwares do not
> support this CE_ATTR_BYTE_SWAP_DATA but I'm hoping QCN9074 firmware
> would support it. Grep for BIG_ENDIAN to see more big endian specific
> changes.
> 
> In ath12k the endian support was implemented in a proper way using
> __le32 type family and cpu_to_le32() & co macros, but it's also
> untested. It's on my todo list to convert ath11k to do the same but no
> idea when I'm able to work on it. Patches very welcome.
> 
> Do let me know if you test ath11k on big endian, I'm very curious to
> know the results.

Hello Jeff and the `ath` developers,

there are still a number of pending patch requests from my side for `ath12k`
addressing various big endian issues. I assume there may still be gaps that I
did not uncover during my testing. Nevertheless, `ath12k` is now running stable
for me in both AP and STA modes, so I have started to look into `ath11k`.

While working on `ath11k`, I noticed that the firmware swap handling is not
applied consistently. As a result, the driver does not work correctly on big
endian platforms. Based on discussions with Kalle Valo, there is also a risk
that the swap behavior may differ depending on the firmware version in use. To
achieve a stable `ath11k` implementation, Kalle suggested disabling the
firmware-side swapping entirely and restructuring `ath11k` to follow the
`ath12k` approach, by handling endianness exclusively in the driver.

I now have `ath11k` running on a big endian platform and would like to upstream
the corresponding patches to reduce local maintenance. However, the patch set is
quite large (~10k lines), which makes review difficult. My initial idea was to
split the changes into smaller pieces and submit them incrementally. The
challenge is that disabling firmware swapping without simultaneously applying
the full driver-side changes would effectively introduce a regression. Given
that `ath11k` does not currently work on big endian systems anyway, this
“practical regression” might be acceptable, but I would like to hear your
opinion on that.

As an alternative upstreaming approach, I could also imagine sending the patches
via a separate branch, so that the full set of changes can be reviewed and
integrated in a more controlled way. I would appreciate your guidance on how to
best approach upstreaming in this situation, and what would be acceptable from a
reviewer’s perspective before I start sending patches. Additionally, I noticed
that `ath12k` has introduced the `ath12k-ng` branch to separate out Wi-Fi 7
parts and prepare for future Wi-Fi 8 functionality. Since `ath12k` originally
evolved from `ath11k`, are there any plans to consolidate the two, or will
`ath11k` continue as a separate codebase going forward?


Best regards
Alexander Wilhelm

