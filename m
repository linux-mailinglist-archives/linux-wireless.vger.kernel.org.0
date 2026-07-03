Return-Path: <linux-wireless+bounces-38570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xh3XL2prR2oPYAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:57:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A46FFCC7
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=Dl6384Ez;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=WFOmS353;
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38570-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38570-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B73130764A1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFE36DA15;
	Fri,  3 Jul 2026 07:48:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7E36C5A1;
	Fri,  3 Jul 2026 07:48:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064916; cv=fail; b=s45+7s1JV97RM7QHNBrpti7RCqGhqwRM/CzwHbF+ctllSNGXEzmXTMV459nSBWv7KlBot1pT/EzYkPzLIDhoXCqV+F2+X05jRBQPJY04S5faj/HPLFeniUW2R2DJONI8fSBYu1A3zyv0bgqVhJL7SPTh8Nb1WrydAQPy2tncq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064916; c=relaxed/simple;
	bh=0S1natGwjC3xqfYz8IV/O3pIucCoXYv8O/YHDJ1pyaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gEu9jpbmtDDO25/cspA1Ukwc/GUh2zk7kv3BLafW0L09T5wKCF9YijH5WDPhJ8gS3uhYISCOjYHM/wDpDQz1COI+Xikm9edOIWjzXBR77GjEj2XU0BVSuaOr5AtAfrpcEBI6BTZmq6y3s3fFIQyZjC/QNzAr7FIJmnwraczwKDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Dl6384Ez; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=WFOmS353; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635u5qd2814422;
	Fri, 3 Jul 2026 09:48:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	Eeuzw7WplBIqV4/0PK2p5XHa/jCv8pPs9qap2+qWe8Q=; b=Dl6384Ez9hLPzhFB
	DqmBisE1Tzn0m+zYE/56eTwJv0P/PW5vLPRmwhKJVNWRJ4rd+TMmj6Y8cMFx1FbC
	yJdYKhGfeUO0dz7t1wL78QU3+Du85gAlfKcpHvw6C/DhmfZtSKQ3wyc7EEJX7YQl
	303A4ajH73zZYYfshm7AFnlQTsazz88zn6/IrHhFtFXDCX66YX38BlILd4cPX+fS
	2UjWcaYdNGM5Fcmo/gN8Fm3NqZNmk9yuYAGqhQ+O2q+t7wX6PJ72pwA0gnfrHxla
	TzTExdtAwe/XLgKC7Kegs2XLubxyz63zLl/BY0RnvHiWCZeQSN3/6OTvLxoP9fKZ
	sQRLNQ==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023131.outbound.protection.outlook.com [52.101.83.131])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f56sg264n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:48:23 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlHp2GGdbvj2O07ov5ve7TAghq0e3QLhl+LJsX2YWIilUHHPNhSPTpQZL9lhOKEexJK2gsNuQx0sqvtXf3l7aBYbJIg7zVt6MMFNrhNQBKVYJmFpluCrchfhf4j3/AGX1uM3AeNHC8R3qaDOAM/IZmoY0fVDh6OiFWnVQCdEJPOAfkMHT9y8+rdr79me9oDmZv2LWQM53qqPSRBO3HWiHwm2OLhRyNo1C63K68hBF9TRUJQzMBdlV9Sm+WyqwfG/7q3bKOkySOm2dI674DQ7QkZMaRll/mTXncdKdX+awkyQ6nh3FmllazKEyRwLOoewMp0vBLXyJRfyE0wt+dtYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eeuzw7WplBIqV4/0PK2p5XHa/jCv8pPs9qap2+qWe8Q=;
 b=rY4GAhx33MlPmRoWnXzq477ei7YJM8Mo1D9LhUD6nac/SCdEbaf9d4qa00i2fa1jvhSpD5OzNSoo5NfXE8Mm9YCRcL52jHAAvi5Xdlh6TXcRkA7ioT4YpMjqMI6TpOmw2QUnYuZew6o7/MJzMy2eye+ufAGZERDyyCbj0wjqgF+AkDLJHSwKuwkJu1c+/i/RpccpT8EX0Y1WYnSVYPnaolUMwdPzkNI9o4sUFXkQdfVi7OqYq4zSEgfo4tK9t5Ha4E2M9pDVHQy0uFQ1cBuWIIRqZdeUPYA//SXq731Jf3b7tydpPQHoVZhv7K+u3o7knsVskqSDsHgXv8ScZLl3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eeuzw7WplBIqV4/0PK2p5XHa/jCv8pPs9qap2+qWe8Q=;
 b=WFOmS353HEndcRJPXC8i3XD12BVb8XpX0dmjVLszdtPSBtEuBL2wtFsOO/CeA4X9JvcM3cq0Bg5Dj+/tXORo/tkOnyBGSQh+nVehBZyM/6O6Eudn1gwH+JKSc+hHMdqjfGJfYfel3IE2iKIQsGyrPet8SiGuW2eJ5JFmWqpL5ec=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by VI0P192MB3023.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 07:48:19 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:48:19 +0000
Date: Fri, 3 Jul 2026 09:48:15 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <akdpP27BE6kBEh1V@FUE-ALEWI-WINX>
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX>
 <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
 <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
 <akZUUhopfdxb3VTX@FUE-ALEWI-WINX>
 <980e1f5c-a845-4180-970d-02f6496f2956@oss.qualcomm.com>
 <akdYU_Lejd2FZeIN@FUE-ALEWI-WINX>
 <606bc37c-45ff-41d3-8f0f-942c3009c4b4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <606bc37c-45ff-41d3-8f0f-942c3009c4b4@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF000239C2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1b6) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|VI0P192MB3023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bae3aac-af64-465c-abd5-08ded8d772be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|3023799007|11063799006|18002099003|4143699003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	7Ro1BWBvOf7Q2zcpoi0OUJgOMNyq17MOH1Tk7lCESNKOdkbZLurCXpwEcLx77PoLvI2b7izt8hvLcJB/r8GIbvtQztTt1/CUHlxdscJqck4hLwa3VLJX5KyxW/3QG6kHoP6gThKneYBxqyTfwsxi8d7DAGaTyrMW1MPHV6zrgO3b7bgy7oKiOCu5VvN20HDNO5LfR08Mq8Z0+e0MPv4u8C9RCnCvg+PszBAiPmDMVuWM1AL/g2xp8dHD1GV7Dg4WwJU9CzzK5Ve8UA9ZEI0QAfjE/S23MxPw+ohVr3DjjHhmf6GuQgEVqU/Mq6dW0ZDiMiAuDXMd+Nt9meo+L9SOBSlOq18ZX945PgorKxo/h8mdGlIAfYAL8n4lMeJ6qttSM9EodVkH3UAUcAqpCwDsDgJ8CKIzMK5SWkH8OmUZud0Px5wPebJYj+711ZbnsJZVJOp+KySAYbksgUSpMO0Y5Wf1Oph1qgQbMJf6cVVNX+1W80FhZEY+7AivcPJNi84AWypI3rG+4JbnsdDs1YhCt4Uj0f4OhybOecVuDxVTBKwmWvN5Sm5dcfHlqk+t73tyuFJytmdNnB9lvtXJNcVrE38EmtxzSSX47bpofHI3hvEx7tpbbNuoFnNg/p9yIh3a607/Kx4UNvnMKUMNN5D+hEVBVgjeztBB1rr0JXRRLeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(11063799006)(18002099003)(4143699003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXpFL3hIQ1BLM2RuUERaUUp1L291T3pMVnBWaVFiYmw4MUIxcEhyUStjVXg1?=
 =?utf-8?B?bE1zVUZjaFJLd0J5TkZsY0xzQmRwRGppWmxTMDdIbnFOSDJSUzFoTUdkYnRk?=
 =?utf-8?B?a0xRUFFTOWxHZXF1OWNtS0s0Z2tPUlN4T3VaekxIVkVodWJiR3RUaDZ0ejkz?=
 =?utf-8?B?L3RVSldFT2VDN3dRT0x6bVo0UCt4YlMwanJXbGpXeEYwdDJWblcvNEZGSEpK?=
 =?utf-8?B?OXcreGtaR0NHcDhFcnVXQ09ubm8ydnUrc1dmc0dYSXRyaURiMWNUUGRhTkpN?=
 =?utf-8?B?WUpoSjdqa000TmxGekk3YWk1NzNTK0xla3pPeWZtWEl0YVB5YWNCWWFvdXk4?=
 =?utf-8?B?U2FveEthcEJYUm1sUzUzbWFEbmFpc2I5eVlnaDFNVnNqYkFzdXlHWGJ2dU05?=
 =?utf-8?B?Z281RHpSSThYU3c1N3JUZVVnTDZIUFM3c2NpcTlKaDJ5cFl5MThMclpoS3Jx?=
 =?utf-8?B?YkxteXFyd0Y1V0pFRGNMM25YMGdKaXZoTmZFZGRWc1NNZWNYck5jZVlXZDdj?=
 =?utf-8?B?Sy85K2wyNWNtZW1aNUJsRUFYNlhBOVhOVjBpb28wR29adDBOZldxa2lHOUd1?=
 =?utf-8?B?a0FkdWpnNFYzZVozTkY1RGdWc0FvU3Q2WC9SajRSamRUaDlva1pMZWhNVlVV?=
 =?utf-8?B?bjk0MERRdkdsTzlLdm9EZkxzMys0aGQwa0Q0cnlQdk92VFJ0bllnQmZDY2M1?=
 =?utf-8?B?U3Y2YmxEN0FSTUE4SHpkOUsvSnNUcGgvYzNaTDd3QjVQVC9zVmNHUTVYMit1?=
 =?utf-8?B?UEZ0Tlo4SWcwMmtjMjJFTUtKTjRtaUYyR1J5RHJoc3VwUG5mZ1ZnajFPZ0Rw?=
 =?utf-8?B?T3hzTUQwS1JBZThJVnlFQ0VMWHRKTUF1bUltbzFoU0lMSzcweTJxYzIrcURO?=
 =?utf-8?B?NncwTnJxMnBGUDlXVVdjV29lYllqR0tnTXhSSTBKNzBkWnA4UFZibGpCVGNr?=
 =?utf-8?B?OGZEclp3SjRVZks2Y01BdzlzQzE0YzQ1RURKZjIzS0NvT0Z2SDJ4VWdBWUE2?=
 =?utf-8?B?WWx6cW1HNmI3Y1dYcUVNTXl1dklUaGFscnMwU21GMEUwTHloRGZSQlZmcFVV?=
 =?utf-8?B?SHpDT2lzY2FqRkt2OEVackJvbnJwZG8yaW1SdUlqZGpqb0NvaEpSamh6TjZP?=
 =?utf-8?B?U3o4ZHkyOXAzeUtwbVFucjNjcHRaY1ErQTVDdFJWS090SkFOTTMvWWJBTlpB?=
 =?utf-8?B?RUh0NFk3ZkdiWTZ3Q2hwRVNQajE3L09CVlljL016bmRPNHdzNENLRVhqU3h4?=
 =?utf-8?B?cjVXWkpYVHoya2xJc2JJTjV3UlVzM0cveG5iVERvbnB0VENrSlJnVm5GWFVU?=
 =?utf-8?B?cDhZVXB1RDgyYTFMUGpWWkp5QkY4Qmg5dGYxYVFiZ09HNWk0M1JzZ3lFc2M5?=
 =?utf-8?B?c0RtelZFd3pHVTZuMXphTHRvQ3g5ZlZUT1Y0RTBJUTA4Y3BYR3JUWkdmanpY?=
 =?utf-8?B?dTBmbHZaMSttS08yMnNUdkt3K3BWUS9paVdSWUZtTTFhN3N5NmJ6dGFWSXY1?=
 =?utf-8?B?TnFRVGJNeHdCTVhxYm9sRVNzYXU5azh1U0tqbk91V0cxR1Exa2VHUi9DcGVo?=
 =?utf-8?B?N0FPcGErWFNPa0JKandRNkNMSWR0ZjVWZ0NydXRMTTRQdFRNT2QvTlMxUjNS?=
 =?utf-8?B?WWw0aXFSWjFsaFluM2hjWk84T0VncXNrSGJubnQwMW42djZGUmRYTithOFpa?=
 =?utf-8?B?WWNUYTdJaE1XbXVGWVFNOXo3T3doaWM2dHNLd1V4MlY0N2NvMnBtSmFvVDZM?=
 =?utf-8?B?cjNtQVc3UWRNMThnTDRzZVlNbTlGN29wKzJQTy9FOHQ4ckYvMGxvMys2THlx?=
 =?utf-8?B?OE1uNU5odWhsbVJqMExKKzZYczBBM0tFZ29OUUVXMFl0ZnpTeHdpaHlKNTA3?=
 =?utf-8?B?YkR3SDZ4Q2FrV25KMjJKem9sYWZhN25NaHBBbDA0eHlmaHN1UW9XWWtKYnps?=
 =?utf-8?B?djBJU1VacFl4Y3c0SVY4UzBFV2JDU3BEMzk0REIweHRUNWNxd2h2bVRIanpM?=
 =?utf-8?B?UHNEQTlJWWh0VHl4bzlXVFdweitxdUFYYWh6QXFqM1Jjc3N6YmZnY0NhRE1F?=
 =?utf-8?B?MUpnMVZZeFJ0QmV6NGdibWk1ek85QUt4b2lwWlRub0tBZmMvODdpSGkxUHB1?=
 =?utf-8?B?MUNzUjVVcC8rMXRzVklzL1ZnRHVUN25VcWpmVElDSVkzTXJCNGZ4WlJlY0wv?=
 =?utf-8?B?akdMWHM5K0ZlNmRnMFVpUjc2MlFBaDlpU2s5QXd4TWFVZ2JmSXpNK09QaGJr?=
 =?utf-8?B?UzBKaGRPZHIyYTQyR1BkY0hQeERsZ2JLYWQ2c01rcEFlY0RNd080aUNBamVi?=
 =?utf-8?B?dXAwNG14MVFVekZFWENoRVNOVmpLYWZXWC9TR25HU1d6dGwvOHVqdz09?=
X-Exchange-RoutingPolicyChecked:
	FbdoAgn5uttJXpA9KzuykiFzywQobG7q6dtyH2+591yPAbBIePps+cerYrxC83JBSvzoNTLSOUf0xPDLfLXtQhuGXBgPCCLl36hO8rDH9ofI8mpXbjJMg8VsfdWsS7jo3ICJ9zn63iE9XJTWBXK/mWUL2DY6/RBSUdJnbmXv3df1/cg08y//hlB8HihDY+2iUgHhXBhE1ANCYwpXJZQqSiE9OJEViRH1AD1t6FVPhjKdWb40eMf5dE+8Wr6oybcfmzxSN0ifpwLndlD0Hlsy58Z47rYQyI+yX+Z90/PnHoEMNU3BTQgcrEQ4FFkv5Edvkzw9zlgdrtQuBZ4efZsb7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AsM1eOcOu/LcJ1+N6yE1k4KsqNwN/bclC+uTGk20o5jgkvRiK4adFpUEY5RWnx6AzxUVXG+LZH49HrQqLrDBvVvutYy7jDrnhmWHCTEsLqv/7Q9kWNEqXDsUhrOMd6gcokqY8uas7TxKorNnmQRJot2zcn3YZ2JLS61X8TIwgW2AyoHsmANUqN6sn15z/MUyRbN3Eu3D2R2QXtPxJqzFHgBbRfugPT6Xr/HEPHIRQz9V+81w4JcaMDE25W87qulpecavlwcWY8uKqszXGb6IgUKzuOEbjdW8Lij75ljcFCepYBE6byHiuKnnobAgg68D1RFpdBJ/Hwr0bSKaduj6VAo2HhDGp59TmbESvQvwHOTKWvCO3bOo+JSTyOT1C5tHoFCO1O11U2HN8zkUm03CZftn2VmUKacbV4bs2WJJZqpIL+ZXTjkJOwjTZO+S9nKhSnYag2EP0gZxJwn3ImkLRAw2JWkeyKFRB0edaWPlihKwDTgXvMMcvBjrAL7WQWoMMbwELsBkdDoN7uM2oYX9lfnC8/HJdXi6TN03f6dTHMhXK0VE0fa1p7JPjgXYLk4rzxPYZzvJ8ArnMkvDNjYrjorpMft92e0QBWm7uutG1uRK090GtCrxFbxP+n6uQomy
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bae3aac-af64-465c-abd5-08ded8d772be
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:48:18.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY7Agg5HSp9/FGup6+cCohOJfEASgXNg7VYHDgBxV1n7RZy2W61qOqk7Js2E1Y2Rq1xvfrDUh2KUq6vCO3qgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB3023
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
X-OrganizationHeadersPreserved: VI0P192MB3023.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: 9reMAODPFf8DUQ1nm23mChp42vEJhoFe
X-Authority-Analysis: v=2.4 cv=OJoXGyaB c=1 sm=1 tr=0 ts=6a476947 cx=c_pps
 a=IaeKFcn9ZG3utCv+WzsRNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=Iwk81yimAAAA:8 a=SRXSuGLfWM0F02F4zgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PqBb7rsBcpu_OT3Qf5tX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX2WNQ2TcMxdtN
 Bf4+7P85mnjrehNndzsLnvHqLGJzM9BjZpQHnHQ7MhxUM56HSNXZfO+qFcocTtrmUSif8v7YNo4
 pUwlT8yEV8vdeqOb8wXjTIo2ls1V35zXjQ+G7hoCjxs9YNEblr8UjEPyYxyd1zy+j0Wu3IOWAKn
 ggovI2BbVYbh2IteTvy/RMU21hsow6Rr2fHFLaOoNhFBiU3SlV443YnSc2y5QvqxDItnNXdXuJd
 XZrG/qhD8T0UrgEEmJUwLXXKY6AxzUZzzRHIHu83lq+vmzr5R8NlpWKQfilFxuOU3b+xtWzOjKP
 K3o8rAHs9h/G29U0ZoiwUgzNL4OpKiJ8/w2s9A78nK6FFhdJtikSUdwDXH7IigqSiVPD7VDl3pE
 Q0VpA2fajPVbKx3U71tqUjjhgSPFMkR4ZYjdp0CHBZRG1k1pneLuGAL18vcgIlBNukPw52uN1jO
 TN87ze004yV/0IP9Slw==
X-Proofpoint-GUID: 9reMAODPFf8DUQ1nm23mChp42vEJhoFe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXxyrAYDehqQ1h
 OCe8WpJAqmaMYwOaY+qwMoIqJRqW6B7adTSljJWhGNHIf/26fy37O/Bpmetss8spMhxmLQj0yo5
 36gFfUtbcY1WpX+Z4Ng/WUDlOI51+0E=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38570-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,westermo.com:from_mime,westermo.com:dkim,beijerelectronicsab.onmicrosoft.com:dkim,FUE-ALEWI-WINX:mid];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 259A46FFCC7

On Fri, Jul 03, 2026 at 03:10:23PM +0800, Baochen Qiang wrote:
> 
> 
> On 7/3/2026 2:36 PM, Alexander Wilhelm wrote:
> > On Fri, Jul 03, 2026 at 12:04:10PM +0800, Baochen Qiang wrote:
> >>
> >>
> >> On 7/2/2026 8:06 PM, Alexander Wilhelm wrote:
> >>> On Thu, Jul 02, 2026 at 05:56:01PM +0800, Baochen Qiang wrote:
> >>>>
> >>>>
> >>>> On 7/2/2026 5:17 PM, Alexander Wilhelm wrote:
> >>>>> On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
> >>>>>> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
> >>>>>>>> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> >>>>>>>> CPU-native data types into an u8 array. On a big-endian architecture, this
> >>>>>>>> later results in a null‑pointer dereference. Convert the data to
> >>>>>>>
> >>>>>>> Alex, did you find a time to investigate the root cause of the null pointer?
> >>>>>
> >>>>> Hi Baochen,
> >>>>>
> >>>>> I am now running kernel v6.18.26, and it looks like the null-pointer issue is
> >>>>> gone. I only see the following log messages:
> >>>>>
> >>>>>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
> >>>>
> >>>> what is the actual mac addr reported from firmware in the PEER MAP event? My understanding
> >>>> is that, without this patch (if we really need it) we get a wrong mac addr, then in
> >>>> ath12k_dp_link_peer_map_event() we are more likely to fail the peer look up hence would
> >>>> create a new peer and wakeup the waiting thread. But the log here clearly indicates that
> >>>> the wait timeout, which does not make sense to me.
> >>
> >> I think I can understand the behavior here: even if wakeup happens, the waiter in
> >> ath12k_wait_for_dp_link_peer_common() checks the map result by calling
> >> ath12k_dp_link_peer_find_by_vdev_and_addr(). Since the mac addr of the newly created peer
> >> does not match, check failed. Finally we get timeout.
> >>
> >>>
> >>> I have now added the following debug output for `peer_map_ev` inside of
> >>> `ath12k_dp_htt_htc_t2h_msg_handler`:
> >>>
> >>>     /* DEBUG */
> >>>     switch (type) {
> >>>     case HTT_T2H_MSG_TYPE_PEER_MAP:
> >>>     case HTT_T2H_MSG_TYPE_PEER_MAP2:
> >>>     case HTT_T2H_MSG_TYPE_PEER_MAP3:
> >>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info: %08X\n", le32_to_cpu(resp->peer_map_ev.info));
> >>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.mac_addr_l32: %08X\n", le32_to_cpu(resp->peer_map_ev.mac_addr_l32));
> >>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info1: %08X\n", le32_to_cpu(resp->peer_map_ev.info1));
> >>>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info2: %08X\n", le32_to_cpu(resp->peer_map_ev.info2));
> >>>         break;
> >>>     default:
> >>>         break;
> >>>     }
> >>>
> >>> Here is the result:
> >>>
> >>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
> >>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
> >>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
> >>>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
> >>>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
> >>>     ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
> >>>     ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
> >>>     ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0
> >>>
> >>> Let me know if you see anything suspicious or if you need additional debug
> >>> information.
> >>
> >> I am not really sure about the final mac addr and vdev id passed to
> >> ath12k_dp_link_peer_map_event(), so can you also add print below?
> >>
> >> diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c
> >> b/drivers/net/wireless/ath/ath12k/dp_peer.c
> >> index 47d009a0d61f..3e8201d536a5 100644
> >> --- a/drivers/net/wireless/ath/ath12k/dp_peer.c
> >> +++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
> >> @@ -162,6 +162,9 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id,
> >> u16 peer_
> >>         struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
> >>         struct ath12k *ar;
> >>
> >> +       pr_info("peer map event: vdev_id %u peer_id %u mac_addr %pM ast_hash %u hw_peer_id
> >> %u\n",
> >> +               vdev_id, peer_id, mac_addr, ast_hash, hw_peer_id);
> >> +
> >>         spin_lock_bh(&dp->dp_lock);
> >>         peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
> >>         if (!peer) {
> > 
> > Sure, here is the output:
> > 
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
> >     peer map event: vdev_id 0 peer_id 2 mac_addr d902298bM ast_hash 5 hw_peer_id 757
> 
> what is d902298bM? are you using Linux? seems %pM is not properly formatted in your
> environment.

Sory. I got a typo while copy-and-paste. Here's the output:

    peer map event: vdev_id 0 peer_id 2 mac_addr c9:21:f0:04:0e:e0 ast_hash 5 hw_peer_id 757


Best regards
Alexander Wilhelm

