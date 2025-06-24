Return-Path: <linux-wireless+bounces-24417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FAAE60AA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EDA189FEF3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D127AC31;
	Tue, 24 Jun 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="IZ3w0e7E";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="OztBtAsN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DEA27AC28
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756816; cv=fail; b=cg5CygEZoX/SY9D+jEITpSFGf4l8sUAxAZgG29S+vLRU9N9OgbKbDrKQ+zIuLLdXMFvJi3mp2cTqP1o/4f1iNBqKuWB8RF5nzdkQHCyEJe1ZG54k6PxDyMJjABqQhK95UhNa+nsdDp8H7zmEKy5jAlclqZn/KIn0LwIu13JD60I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756816; c=relaxed/simple;
	bh=5sr9mOBPR0I+sX7Pi7DvK5kyfr9Ix5/YZH0WpkGBSpw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cRpBmv6Zk/nqOpSnEnRoCVZkfS9buzIo+lQkH6GQ0kBw8p+nexp3i8MaeeiyvNSgLdNflSSvBw8CwMmN7OJI/AEc/LKcDtECKxJwy29hdhM7Wi3AupaW/xYMP9ciQbMY4GApOrAMge5i5WSv4PI8Nxz/F4VDzpsQ92kkG04mqPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=IZ3w0e7E; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=OztBtAsN; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 55O4jZjd3542480;
	Tue, 24 Jun 2025 10:45:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=5sr9mOBPR0I+sX7Pi7DvK5
	kyfr9Ix5/YZH0WpkGBSpw=; b=IZ3w0e7ENwYyM2/bK5RFM11mCjR72YkH7jw8Mf
	Sa5jM5VLzd2Y7HTL9IisRHpqdNna16xCj75oQYeXfh1l/+lfNjBP6dZDSBYPZGFj
	Qi/ow0MQka5UA4T5NBKb4Y1ACW18RKvDWOEMrG6QLtp+uJCA6lxd6s+TK1T/sWym
	WqhPipKcdcEGp7EgWQPtyqXDnPoC6BtOngdoRYqIM+AGcWiWpDiwbOJZuloJDn1i
	frAJsAZCSD1AJ3wDlEGbNFrtcJsA2R8rnTpyDsxou7xOCSDbdBW8ttVCGJ9S+pJS
	Yaw/zJjz5HQ+jmXCgN4quIz80d0JJzIQdgVhyk5mhWw/tYIg==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47dgr1ttde-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:45:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpxeIF4+9iS2pmbyg+3RzgxIaDe52ZdiFj4yVcgst+PLe16sHDAwXPu0cuQMkAgvazZfMTJo58QqCjcRJ81OIyg3pBSnfqWOrMPdgUvSuYjGefMiDEIu812es4NbKPzJvCjPC5KMUmBgqMRnwH+lXy+bIr//qe9pEyphhohuTfocWOwW626PTP0pR4A3YPyI07JzUhl/zuUhFSd4LFNjfxXdK/raxabSyZ9Ybik1CHEP5hkzBjIvIDP7G4QWJsr2sgbS6OLC+NAFsj+iTD9KbPD/loPVpkWpaOAgJUVomYMrt0o5Yal77K1i35NNe8nhQiH3plhj1NlZMwTmozBEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sr9mOBPR0I+sX7Pi7DvK5kyfr9Ix5/YZH0WpkGBSpw=;
 b=GvVFAbHFWcTDxDEhSkFKOWE93FkdoeTklBqTNceEs+qkI74mX7a93uSm1Nzglpu1RR8G/Z/yvGY1g5X+P1G6+PMMNTkRVe7xJb++K3ZNTKt4z3U3iXSQFzfqRpLKlnQIovVilh/9Iwcs9SrlK5csjdub2yb0PMNmtO/X7f2WLtOhAqRTWdsl1E7THxApi+nZWOIbONpYThxUkMC3tZEGlJV8TX1ZtjTcLkmy3Ij/48fjT1W8ab0TWhB012Lm+WiOx1jrSdo9Gp4iE4bihoydRcsy4uwJJ18uCWaQgHyYj2G6spMiHKpXVA+iPfsgyhfHzz0wvtngD7IxpeDrbMngSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sr9mOBPR0I+sX7Pi7DvK5kyfr9Ix5/YZH0WpkGBSpw=;
 b=OztBtAsNan6G/nzUgSwT/ZqY39xQRqLdU6hyV6gSO4uS83im2TqlINR7xMTsGJzxmPBCM+G70KUIgiV7kutnZNeOdoBulNpb6cwZ6+BYIL2PQaYs2Xp1cOTQdkxYgtoywlFXgpIolEjfFfDv74PZiTNuGHXajxCs/EJjMpEX3sk=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by AS8P192MB2115.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 08:45:10 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8880.013; Tue, 24 Jun 2025
 08:45:10 +0000
Date: Tue, 24 Jun 2025 10:45:01 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: TPC on wireless
Message-ID: <aFpljc2EmLcw4qTJ@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVZP280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::14) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|AS8P192MB2115:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a44412-5bd1-4694-1a09-08ddb2fb6dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkV2MGxmcFE3USt4ZmkvQ3BPU21mL05mL1g1aUtiWmFwVDFVSFcyMTR4QUR1?=
 =?utf-8?B?RkN6WFlMekY2QTJLOWVvUzZCTXVNTEJSbVBRSFJYaVE5YnE5WWxaanhPMGhp?=
 =?utf-8?B?V2E2UFBQS2hPeUkzOU5paVNHM2wyMTlHTzRtMGhVaWI0bWFseFJVQlY2Wkdq?=
 =?utf-8?B?OGh4aERoQ2dPaE15YUljanF6SE1jQnkvU0NHTzhvdlBYL08wS0R1cExTUnBS?=
 =?utf-8?B?cEhRMU92REl4bytITHRWbG16Mkg1K1l1eHRHd1JqUUVZM2xUNmtBOHlicDU3?=
 =?utf-8?B?dnRIZHdkandpTDZwbVZSSm5ZKzY3Ykhic2tSUEF4K1dUaDlmNkpyVEVDRDhR?=
 =?utf-8?B?dG1Nb0lXUVpKRC9GcXFHdE1QcWZEdVczdWRnRzBRMDgvQzljWmx3K2pSTEJB?=
 =?utf-8?B?cFBZeFlYZVJDQnJIZzFiNmk1YjRCNnd6VXJWQWtDajljSEMreGdtb21ETE1j?=
 =?utf-8?B?ZUVLYXJGUW42VjAwWG8zMGlPRU9XSXhPVFNmQ2dudXRBdGNhbG9xN2Y0Q1Fp?=
 =?utf-8?B?TEkwcnZrNG1PbGVTSWloM0s5WDlEQVVSWkZpTEl1c010R1lwQzFiUnRqMjFY?=
 =?utf-8?B?dDNsaVlSS0ZKenBLSWs3OTlyUjVraFVORVFQOU02dUlaaXMrQml0SUZqalRX?=
 =?utf-8?B?VDRtVWN6YXg2L2o4R080SktUd1QrVFo2SGJ5czBhQkpmZU1ORFZtZGhCOWMx?=
 =?utf-8?B?WjFPeEJ5VWtGamdZWkdkTllGclZ5QVU0alpGSk9vb0laMDcwTm1PMkczeXBZ?=
 =?utf-8?B?V0t1bHkzNXFBZXNmVTBFdGxDTmdQUnpFVkliOEthV05hQ0NXTUFuS0RjVHBY?=
 =?utf-8?B?YUd4QzlVeUJXSUw3ekoxRExhbTVQemhESmI3MXkrTTV4TG5oVnVlMXpSKzA4?=
 =?utf-8?B?TmxpSWdVT3N1UlBJeWU0UkhUOGxrbE9XYUpQNTYyM3lxeFc0SGtTM0IxeWhG?=
 =?utf-8?B?aVdzTUZsOHRDaEdNdGZweFRHWUhzZFp2eXBqNExYMEZmNEFjeEhWK2taVE9V?=
 =?utf-8?B?dUN6c1QyU2RSS1V1UHZEQS9EVUZrUWg0cHBWaUQ2R2FTK01PZThiRGlmOTdR?=
 =?utf-8?B?S0lWSUoyZStYWTc5ZmVWWjhtYTRMUzNSL0prMHhZTWhPTjJiL2ZWSnlGTTNH?=
 =?utf-8?B?WXhjb2liT2VPNzg5dXlqNmRHdnpnalY0aVlnUGZEUzk2cXJLWm5GWUxNNFJD?=
 =?utf-8?B?clhIbFVUbUpmYWVsSjJvcVBQcnF2VnBjejdPV3hxTVVxR2k5eDJJUENSazFB?=
 =?utf-8?B?QXdMRXQzK0VvYS8xRmZwQVVJc29mb3MxVmVuQVdoRk1NU3BheUtOWjBJVm83?=
 =?utf-8?B?NjVEL2pmQ3hVQlBQV2JsclJGYmlSWnYrTjA1UDlUanBhUFlzSVB6cFdIbW8x?=
 =?utf-8?B?QVJEZndDSnp0am85VEd6alByUFhRUlZ3QmR3U2JNd1VOUlZEdlJYa29UNjU5?=
 =?utf-8?B?aW8zbHFsVFVNMjdxWUh3eDFNZHBqajJPTk0xNjRSS2RGZWdiNXNFZzZOdUdD?=
 =?utf-8?B?ZFhWYUM5MVk4dkJGbzlVNkcxZnh0UmYyYUoxcUQwczlRaVhiaHB0TTZ1VEJL?=
 =?utf-8?B?bktNOWw0WWhpSHFQNDVZUUsxY0x6aGRiNXp6VEQ5M2VzcG83Uzh0ZVVOcjgw?=
 =?utf-8?B?cGd6NWd4YWkxTlM3ckE4ZEdNYW9udXhHd0dmVzI2TWZSZnQ1RUlNaTQ0Wllm?=
 =?utf-8?B?Qkw1T0RDcVBoSm40ai9INzAvN2VYRm5mR2k5NE1GVEJuS1BUeGlJczdCY3RU?=
 =?utf-8?B?d2c3SkhhbmhiQWxkOTBQSlNlZG5WTHFKajh2V0hQbGxwNmRka3JXbHR3QmV4?=
 =?utf-8?B?U1NLQXhMSUx4VERlSVJHWnZsLzJ5a245VDBiZEZtOFZQS1NDeno3WllTNEdC?=
 =?utf-8?B?aGtGNzFweGE0YnJMOGZGNGo4YUZLNCtDUi9VZWUzdm85UXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0gxMUQwS0JUYW80RDZLWVpoTU9ReTkvVmYxOFhtYWMrRjZCQkZKaWFPS2Rl?=
 =?utf-8?B?dWYvSWtVY09RVVl3MnY3QWt5N1VYZnBadWFHNS9CZms5NWRYZmZvVGZ5ekJ0?=
 =?utf-8?B?MlNZRG8rREZscG9OWmtHUjc4czIxYmpoTExIcG8vRFRaV2xCZDh5b0dMUEVL?=
 =?utf-8?B?TWhPYmNIZ3B6SUhyeG0wMytsMmg4enFsUHl3aEdWaTBZcFpoR21XU1lvc012?=
 =?utf-8?B?ZER4aUVjaGdWNTZaWm02WmdwcDh0OTVmdnFKRXMrMzRBUzdYVDVsME45TW9m?=
 =?utf-8?B?bUxNMzY0MEYrcGRaMm9sdHJJa3RUNU95dXhXRnJMT0F2YXMyZ1RPQW5xSVFT?=
 =?utf-8?B?RjR4UFl0YjR6cFozOTdvQ3F4N0xaRlZZSFo4dE1pSU1pVy9yZm1tdHJINjdw?=
 =?utf-8?B?MkF2Y0UxYVZ4L29zTlNxR2xiT3lFTmUvR1RJdHIxZ0tuUk9DTHNXZzR3VDQy?=
 =?utf-8?B?cEVJL21LQVNhNjFiZWp5M0tvUzFmMzRRd1VFalpTNHF0TVByalNsZzE4Vkxp?=
 =?utf-8?B?cDRnVHFuR1FudUVZQmVJeFMrN1cyV0tITG50MHBUcEFmZmgwZVZwQ1ZUQlNO?=
 =?utf-8?B?ZFd1N3dNL290RWNQeUliajdpbUNwbUZ6ajMzNWEvZ09jK3lmSEVLN1c0NGpk?=
 =?utf-8?B?Q25BMEx5aWtsUnM0d1NhSk1NVWRPOUhsYjJLQ1gybkhVOS9JeHc5MDAyNFJh?=
 =?utf-8?B?NlprK3VvYmorTDhaMTRtQVpsN3lyZkp4MjEyNkVSQWFxSFNza2hWaTJpYWpR?=
 =?utf-8?B?a3I2UjI4YWN3M3FCVW1FYjBrUENrRHZ2WUxRcnNKZEJMdFRFV1ozT0tVWnRU?=
 =?utf-8?B?SFlGRzdxYXBHaG9WdzdybzFVZzJER3dCWTJkUktoang2dGhhK01OZ01xaTdF?=
 =?utf-8?B?UjNjNmdBeHZxRW8ySnNnVS90eVpVa1JFTlpUeFdrd05Pc2k2TExZQlFDKzUw?=
 =?utf-8?B?V1pnL3g3bmI3dStRVTl2Z0I5ajVTbmZpOTdjZGZvbFRiNThONHEvUDJSQUps?=
 =?utf-8?B?RnVXSEFrQXBKUmFVQjF5TVZyTmtWSFJEc2FVQitpQURJRm5qMnZ1VUVJdG1s?=
 =?utf-8?B?YlM4bk1HZ3VEY3VRU2xaQWVMdWRsc0NvMjVZbmdXb2lyNGZ3TmptTE50TTA3?=
 =?utf-8?B?bEZ5d1F5aVYxOWtNZ1I4NmYyb09hQmszc3kyTE5PR0VDZGY3NW5aKzVXZVhI?=
 =?utf-8?B?Zk44TklGQ2NXM1lIRUxuVWdIczBBSVNLZEFxUlphRnB1Q3gwNWxVcTd6MXdN?=
 =?utf-8?B?NUFSclZCU1JTUVI3Z2thc1V4MVBkNkpnbVRYZWtzUm5UV1dyY2RQVEJ4WklM?=
 =?utf-8?B?YjdPRXhvY2JJTmZtVGpFbWE3WW5KZ3NaOGpGOFAzV0d3KzlYbFFIY00xQWRH?=
 =?utf-8?B?VGVobUNGd1dnS3I1bHBYODRiZ0FLbnNyOEpFU091SXdBSElOQVVPQklXV0FY?=
 =?utf-8?B?eDh1NWpaajM1Q0wrZlV4L0hLVEpQU1JJemt1RllZOENSUkRPR0xwTFJPL2JI?=
 =?utf-8?B?TUEvWmZ1UUZsa0JIZitsOGphSDZWdXhQRkthTzZ1M1A2NWRwTlBQMlplMThD?=
 =?utf-8?B?cDZQZnVZanROMUlKRFljYU9uTzl4L1pIRE5EUGxGTExyOTZGdlkwclplczly?=
 =?utf-8?B?cW5rbU5qWWgwQTV0S0xycmlqRy9kbk5YdjVBL1JZU1hHU2Z3T0NVeVZmVVlU?=
 =?utf-8?B?K3pSSVpKV0YycU1zUmxsdHV4anoxcVpmaXFnM1pGS1lUeVljWTZCSHN3RmMy?=
 =?utf-8?B?ckppeTNkMm9ZWWlkS2ZQMnd2eFhSMmpJSmFjMGw0anIrWnhhK050THFoSlZx?=
 =?utf-8?B?NHo0eUU2dGs4cW1VT0Vta0pEbzRnVnRubmVPdG8vM3krTTd4Rm5QMDhZbFdJ?=
 =?utf-8?B?cWMyeTdyWXB6RUsxc3h5YjVYQXBYUG5BdG0xd3VxUXpNVFNZMHdsVGdPWW1M?=
 =?utf-8?B?OThidkZMTTl5cDBOcjJmUkphclR0K0FFcmFKNTZCNy8rSmV3eTl4UGdWOEJP?=
 =?utf-8?B?bWx4VnhYdW5tZG91RHJaeEg2ZWtxdHVzdWF3b3Q1Y2JuSG1sTU9MM1NPMjhV?=
 =?utf-8?B?clp4SUdKTHN5OFlrcG9RTURJaDNRbW8wV2dRd2o3Ym9MLzkrc3I0OTEvWVJR?=
 =?utf-8?Q?U7UH/YxSnxt8g15GggeahKNFt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wv2m5BmHiWoRS7C+id0TBboQnKxqx5r38F68dlIKzoES1vimPK3aECTkK6sIn7yq66REUHuwMZkiK5G0nxBXqHf53Dn7pPiwAFYbQUsGIRnf7dY6XsxCVWLiXFbu+WxK70hj+Eqp6ZWByc8NWkoZRKB1UlIICce/3liwfmS43cZPhAtjDGt9a0nIfnlrI9DfpmRdHeZ03A8gz4uHVe548CMvtEO33JoJeX1cCVGwI8zIHliZtZW23F1SAR3jMJASLI595jP+4alBWuxpcHPdIBkVahOJWA0ZCmkzg+of6Dhwhhi/r82cPN3G4FqF6k6vsUQjOfx16/5SA95MeTDH6qu7PJziBSk85m6s3V+Z8yIO4kz8z5tYO3H+Ww7vR7EVW/xlgIG2fkkzB9PcVqQkbPs5TzrCNbhDOy5S0WwMIe7+FRt4uG1g3Kwkpo+1KLHRvon1qtT1gpP8MIW+vnq8qStJM2DSITBDwFiror3vNdWlRFqyIenl4HAtPz/P0URUJ65Joo6VREeGnki8IA3RnON5k0ho45RKZfGsBuUI99qUTBm+mYRZ7g6VsV1qJjjWUW8IpI7LdhoIjz+gmBLX5OR7c5vp9IGJy8o8uNi3P0vZ65d2KAuWxi6rINzBuTZ7
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a44412-5bd1-4694-1a09-08ddb2fb6dc3
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:10.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C51Vl2XNqVvInOzb03KN3+h1kAlSU6rWCi7ga2yNrA911WdqmMVjNh16EbGd8erE/rN5z3IdAww1RVhg0+Iqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2115
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
X-OrganizationHeadersPreserved: AS8P192MB2115.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE1NyBTYWx0ZWRfXw/v69ZLYrF/1
 KXFcn/2sSpyV6CZ+xDeQSkP87zNodPwNBK+qoNCxnubxvU22D/cPoZzOlMD2TbTbW49K8uKxnnM
 PAMxTkb0jie3v0DShl+YL1RSyv5fJ7J1IaPTVVXIiQTOA0bzlqLUoczD17Hd/Oz0MFC98q1YP2M
 Bii0g4jWzEP3dYBvSdNNifZ7Mh30++DC9WHgdn/TwCPcqV+Hy9WyNxNndml/SNebc8ytyHo/kdf
 j0+Itk8H/4tuEz7Hes+EpZ05Pwb6XCFG/ssdWc6z/4Wcsqvhj7DQHOzF2dtE1Po5DFelgt8bXFx
 eikgjeFEE6ipJEsilIrVXP/U0WHzPuC/f9gALO9g/t0oPiPwz9n1YVeZN1TuACdfDrRaNZBW7mi
 EkcHHWRQ
X-Proofpoint-ORIG-GUID: FCL-pZHXrIHuVTefvglPUMyqjMM-iWsu
X-Authority-Analysis: v=2.4 cv=PZ3/hjhd c=1 sm=1 tr=0 ts=685a6599 cx=c_pps
 a=vihr1PdiOZTOpcAzHihgkA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=8gLI3H-aZtYA:10 a=VEQytgjgKMnIPCMKPqEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FCL-pZHXrIHuVTefvglPUMyqjMM-iWsu

I'm currently trying to deepen my understanding of how Transmit Power Control
(TPC) functions, if at all, in conjunction with ath drivers and firmware. From
what I’ve gathered so far, TPC is intended to dynamically adjust transmit power
based on environmental conditions. While exploring the ath10k driver source
code, I came across the tpc_stats tables. However, these appear to be static,
which raises some questions.

According to the ETSI standard, and the corresponding regulatory frameworks
derived from it, higher transmit power levels are permissible if TPC is
supported. I’m interested in increasing the transmit power settings in the
regulatory database, but I’m unsure how to verify whether TPC is actually
implemented and active in the driver or firmware.

Is there a way to confirm this? Could there be limitations tied to specific
firmware versions or other constraints I should be aware of? I’d greatly
appreciate any insights or experiences you could share on this topic.


Best regards
Alexander Wilhelm

