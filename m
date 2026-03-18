Return-Path: <linux-wireless+bounces-33376-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN0SMbFWumm8UQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33376-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:39:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B922B7156
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1610C30439D2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64229368279;
	Wed, 18 Mar 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="rmVp0QTj";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="vdW1hndw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971635CB6B;
	Wed, 18 Mar 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819451; cv=fail; b=f0QfB1EBbS3eVvJbW6BhQye6tieTXSNdZWHpRfB2ooi10y2+De+ZUX1t0SRpU2d7gQxH8NMgLH+SreKgjeIaM36/4qH4v61NJUcLmgV090YCJrRXDwEIOU1ukXAUHOAaLaR9cmOoOY0J8zLP/qvIVcJbzZn3KiTJuDXVNrMMLdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819451; c=relaxed/simple;
	bh=MT4KAcuKQbMvcYtQTM5NULCFc+Yte8u+El+A0qLSo5c=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Zfft5XA7IcFbcm0AcvOw0Cet8HuVB8idha+ndDR9RUk6tBi1sOYugdjXu16xc7PveXNWoLgJOKizjH6hut4i36FVCJ0lLjxyW/tfqRvyC3kj37WUfn/uUGE78UsdBa+sfZrvLQQMUP/XuZAg/9t8Jrdm5PgqTvVywWYrbeBw4lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=rmVp0QTj; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=vdW1hndw; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I5pKFB1089681;
	Wed, 18 Mar 2026 08:37:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=t8Xved9iNvQxEQeBAzcZxT
	m4lk4vFUEJdzDTnBUTwcE=; b=rmVp0QTjDv/5rVe/tqWc1Pxr2tQL1wJVxoB5gI
	55HaOmwmFW3dzsvPyTsBbYEpcCtpwSKdaAqJJJE5ecvdffPrh16AAqK9KvAgEQwb
	d4+fQh0PyOyGYacmw8wa2lRQ+dkzKHU97T1FPOuQAg6V+g4Af4+dJoBEUC5AOn5n
	otE1d+TEupqoPN8rhg2Ei15B0wDObHEE6Pbu6iOfPmK2XCKL6dsqfIhrd6X3oLrR
	ymoEO3+tRvSCRKJDZJJwU+uwzbqPDXDwrlp57EFWngiVWvdb6zmePqCRlrKVDd7x
	c+bu2ju+MNS4BT9ycZF6WyKkR9XECrF46UsyJBr9yx6dTqow==
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11023140.outbound.protection.outlook.com [52.101.72.140])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cy6wn8ry4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:37:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qonhKiiZ0uAMbVE44QwxOoeBqnyd0HqvqFIF1H4Fbp6vqdtVNdJxH91vJBqCiwjEvEN5lTJ4y2MUo/qZpfIK3ML426mRUh1NAc9WoCTgmFmtoix0Hfozag8JcNTFHVIzZnOi4fYJKyCMOclRvuU3cN/wkIOsOlnWPCQj+FjR/rFihEOMiMLNUFNiWFeh7AqcbPk0LhyDKZQqRUS+yjDDDZ1XrMWEjmBE5cfgS+8FJxXk2+S50ut42FJBmvMeKWmLwQOzJS3mT0/suvfd1cTXigv/E97cn+JUo7ePmNTwutV+EbD469zHbVqa4HgsVWyBMyMdyHh1QMj4qByYC4ncGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8Xved9iNvQxEQeBAzcZxTm4lk4vFUEJdzDTnBUTwcE=;
 b=x984H0SnfbTHSVglizRRnfCUSB8ob08oolUB1NPc5nQl6tOFxFHReMJyZGGUWbFO/w4U2rNtI5gl1vKiq5SRIWEURs+5siOnj4fW8C9ka6+DD73uhHzsNS9xkTObabHn6KTMVvqzUJvSt15Ya3FwSLyoEj5Xh7OvAFIGKufKMl1qes0aYEjUWv3Ot4EdcGwlmYqX0svYbJ5JcrlFP/yLRYyHXObKpqGJ9NrBKzcQzdOD0ogm4StbRiEEA3rpSYyO2HZAHgJi5S6V5JlgqmtlbTr7KHhsRYZCdkk9cm28ZDkydeFZJ12ptEd2QLkIRclYRkyCnjBNsK4PZXnIw5ekEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Xved9iNvQxEQeBAzcZxTm4lk4vFUEJdzDTnBUTwcE=;
 b=vdW1hndwIu+Fd4KIqFY7d+KNN9N8GySjqHsJfxpeU6099caYUbECEMvQ6KSmB9f1RnUTNz5tLzghwRWWhYt7H18Sw1EipqkIxAm00ywctRVPxoXXYo6nyFIjVthmvlkMtzEWsUf5+uT9130xC3ejUTiGXrQpTSFKfTjSNAN1cEY=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by PA1P192MB3116.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:506::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 07:37:15 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:37:15 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Wed, 18 Mar 2026 08:37:09 +0100
Subject: [PATCH v2] wifi: ath12k: fix HE/EHT capability handling on big
 endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-fix-he-eht-capabilities-on-big-endian-v2-1-804f6cc52c39@westermo.com>
X-B4-Tracking: v=1; b=H4sIACRWumkC/5WNSw6DIBRFt2IY9zWCH6qj7qNxAPiUl1QwQGwb4
 95L3UGH5yb3nJ1FDISR9cXOAm4UybsM4lIwY5WbEWjMzEQp2rLiEiZ6g0VAm8CoVWl6UsoC8A4
 0zYBuJOVg7GpuajG1DTYsu9aA+Xh2HkNmSzH58DmzG/+t/xY2DhxQ6q6SuhKyvd1fGBOGxV+NX
 9hwHMcXJ/qpu90AAAA=
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|PA1P192MB3116:EE_
X-MS-Office365-Filtering-Correlation-Id: 009cebbd-9e25-4c28-1908-08de84c12d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	KY/jwIWG8QCCWqWEo0D6E4Y7sJDHpAi4B+9pHASysNyvHFEEGtH4UdoS1qBZwS69cdkatzZBW8vm50/4xlxAY6mbAePkBTDQ0M8wzScQD1a6AKUsDHdjAwz2TtDArfzcrQWgwPInTFBN/+7GigWL2pkynaltwrNTPezDW/DpIbuSIx17iajBkHNqtFlDaxJtTuvx+fEen6t2wa076UIoMbB5BO5a2oxbUIuISDQPpyyJ2+8B5gz/nqtoEmb+nPi1N6FwKivkC9qjJQVnX+PC61cBNWZAmVdb2aa6Mw3Z6jYfrh0aoBheHCzv/zwdyNi3U8+hPO389zJK+casYRXgnhRm/5LwSxepnsBjLC0TE/jTr7bix2SN7+l2lwy6J5g9H+1mcfPg73zsoZINxh+gZeToh6qb9LBePOBlCZoEdmzMjeWKNhPX1mQb0LRcjlPZZXbgAT1jLT2u8FmARkeNGzuC9hbJrDBE+eRy9L7vOVnkLlYnc8G/D1KosYuXNZ+T1T0jAH4vmpSnPlnIu/LyY0WO87kmCffpee1Bcrvl+0OMgFMwCh7rvi+1ILOpCYVMV4Pa4MSKUFItfL6UOgqgQcnd2Udh1IBc4bR+6espAJQnZe08Ons0KTAnCzzdiyaD7C4dzvAfbxm+VkfhCdXL+RKJWkVkYOHAsr7/s0H5v6a7uFEkBw8PEartdNz9SRZtzHhXTLe8l4yVJ2b2ie+9np7vQesgf33Rmc1RVtBMT1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(18092099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW9lSnQ2MGlIZ25VemI3anlZcUNmcTVqNjRNSmVldEs0eEoxUjExVTNkNmtZ?=
 =?utf-8?B?UTBHVHRMWERTOEwrcSt1U0NiTFkvdWpNenNsRitCZTJTclNaL014RlBRM1U2?=
 =?utf-8?B?NURSZ2pHRU9SalR6QlRiWHd6ZlJaZmZTU2VHaFZDUVMvT2puZks0U0FycjFI?=
 =?utf-8?B?QXZjQUZIWFVsaXVyMDdsYlduSW0wVTV6UHFmQjdrQkRVMjJOQ0JKQXU0VnA2?=
 =?utf-8?B?OU1LL1FxOVZCMzVXMHIvbFFoaGlQdnJpYTRiaWM2bkpEUlZIMlNwOU52ek14?=
 =?utf-8?B?a1orV0dXSG8xbEc3ejBnUS9pc09rNU1iYlplbU9MVTVzV2ErRDNYQ1E0dmVM?=
 =?utf-8?B?bXRBOVdVaThzbDhnTVFGZGJnczZKUzNuU24wb1MzZjlUNHF5Yjl4WStNYml1?=
 =?utf-8?B?aXJreVBJb05iOUQ0b05OZFVSdXZ5OHFyVnd3WWhTRlRZSkVmRDNMM1NCRTNs?=
 =?utf-8?B?b0lHamVtYXM0ZjBWcDBleklzZm5LeTF0Q0h1djlFWEhqaUlOSDJ5bEJMdWlH?=
 =?utf-8?B?R2wybkx2bFByaDdIMnQ5a0JhWk9KZW9aa1dDbEU4Y0VoTUZIR01wRTVod3pW?=
 =?utf-8?B?SkY1bWpRWHpxNUQxM29FaWtOMmczNFM2Vll2VW1lUUdGZG50c0dhYjgxcG13?=
 =?utf-8?B?YnBHMVZuaVl3RURFekZOZ3JlR2ROSjY4NGd3cTU5Sk9tMDErVml6SE5VY3ZQ?=
 =?utf-8?B?TG5HUzhTOTJLSmMxTzZNUGZldE84TDhBK0E5WGxYZm9Na05STCtXaisrZmoy?=
 =?utf-8?B?Q2pNSE8zL05aZkdnd0JlSUtzUkp5K2VPck1OYlZYUzJmak53QjlRUmFyTzhn?=
 =?utf-8?B?WjRTU1J6UHlmNlFyb0ZwMDJNcFFmVnBaQkdMWUs2MTlPaFFJVlpjSjlSdDNB?=
 =?utf-8?B?Q09FTEJ5RmdaZjFPbzdqUTUrUG90YUhDZ1g3NXdmVUFmMGkzMDdFWTM4R2Np?=
 =?utf-8?B?aEZ0bkthOGFzRm5IQXZTRWZhUW5jSGRpWjlIbkZCNm0wYUlYeVFiYTF2RnEr?=
 =?utf-8?B?K3dGSDFOUWpDQ0FEaDNtaU5oWEExVUMwNHlXeE0yVVRiZVRHOWVTUnROVis1?=
 =?utf-8?B?TVJhU0NpTC9leVNxaDZQMlVwZjdwb3c1THYxWkRXRGFOL3pxNFRQbXJKaURM?=
 =?utf-8?B?cG8yaHcwZHpuZHN6UTl1NTMyYm5vQ0dGd0JMV08zVDBuMmI1bzN5RmdEZkdk?=
 =?utf-8?B?Nm9HYVpIYzNmaUpDUXgwZEd4SExRYnluWisyRXBjSmorZEU2anJDWXVQcDVK?=
 =?utf-8?B?UTNsRldNaDRsbHgyZHRIWlROUmI4dW9FN0wvbTdVbkpTSkJyVTYzOUxjbzdC?=
 =?utf-8?B?WFMwOGdNNXg0MDUyMjhZVHI2RTMvdldFclVLUnVFRXFZemM1WGZqTjM3UmNz?=
 =?utf-8?B?ZzV3azRkSUxwNXBFTU1YaDZodG5kc1FCYmkzbmJ0ZC9XTENsRHp2bUVJSW5J?=
 =?utf-8?B?MTdSeVNHN09XZ3BwZ2ZhM2VseGg5N3B0bzhRZ1paaVZ2czhQRWNTRVN4STBz?=
 =?utf-8?B?R0lobDI0NVV4dk1INWJCdGxISDk4OWVreVF0S1RENWc0OUZPT01MSG9zc1Aw?=
 =?utf-8?B?MWhZM1NJbzJ2R0dweEFicUJPcTNEcHJKcFEwSlF5U241TlpoWUlVSHdWak11?=
 =?utf-8?B?UXNKdlh0M3JxcGdXL2hubjFvVU8zRDgrdVdJZUk2cElGT3pRYktpK0gvM0dU?=
 =?utf-8?B?THVrWDdWNzkwL1pyeTBmNHlsSUNRRGM1R2dBL3k4SGdvM3pqNlJJQ21jYXIx?=
 =?utf-8?B?eE5hbkVjcFZEeExYWmdwRzMzaFh2dVZTMEdWQ1Z5eWlabWdhRUE5MTE3QTZV?=
 =?utf-8?B?ZzNaTktIcUNROXlhZmFzS0RFVnhtclBuemgvSjhXWnJFNVQrNW1TTVV2eHdQ?=
 =?utf-8?B?YTBsa0ovRkZyRnRXc3IyN3owVER0RkVINEtkbVRGNVBZNSsxb2szaDVGQjR3?=
 =?utf-8?B?c1d0WVNUNUMvNjNkcXFZc044UHk2TGxSR1hoTWFRSHFnYXVDdTZjMUx5M3dN?=
 =?utf-8?B?THRwQlJXbjBkK1RxNUFyMzE4T0Y1Tlc0S3NWUnNsZ0N2VnE5ZG5MdjV1NzU5?=
 =?utf-8?B?MVpUbGc0YlhveWtNQS96OENEZTVWakxuQnFRSVhDUFhzNDZqYnRhejlrQzd1?=
 =?utf-8?B?SldnU2lHc24yMHpmb0ZITkRidFJZTFV4bEJNQ2RUZEcwb3BReGx3YVFSbWtz?=
 =?utf-8?B?MmJjQmlDaDdKWGpDQjVHejhQSW5UYS9XNVltWHBKQ2d2OCtiQlhnQ2t0cmZ4?=
 =?utf-8?B?aG44YS9kMlFLbm9QMFNwbkFqY0VTR2FSMEo5ckptRVJjUmltbWh5OGdoMTRr?=
 =?utf-8?B?MEpHVnJicys4L3dhajhHNTgwOWNyYkxsM2hOYWNqVllWaFV6cXhuQT09?=
X-Exchange-RoutingPolicyChecked:
	KAaDa6ngIMRs/0meSfLCSGazE2+QpcePDKy9adR74m0bBRIwkXAojVi9q6Q9yapODBQlUc/1Hy+UBoYy5/D/kuMkswJYe0cpvDtbmxPHPH0+1AnLXR/Tsy8PXKhrUcCOjKVa13UX6PR2enixPO9fNf02jf7GaA3xBovRU7zFzZzkZmuLuHlmiSNjtIcJEsdW78pWy43mExXWfKmuIxXLcQVR3Du/PKPPX/ep64x5Pxx2tGH+kKyHqEVFGXWvJRczzKBYLDU58S66YKgvIxclzqK9cN6rgsSM+w0eSw7AdJX2ola7B74134wONaK4Oub3bg1Lh6G5WlAQ9ZWy15OuMQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BE7fZvCVR9aYHRePtgsY65271ZhmIER3PJi2lQzVtPxwKvBwbH0uOSzLkl22Pb/oiQA0M9axbNR0GX8kXGZvf6kCTlz53U13gPJTXMo+LfUBwiPnrpwe+c615x0A4y9yPN/xE0c1H8eHLphDKrTL19aZWuVQYMlnBX9Z5MdpcPbtDXilBekkX3oAcH731oPfvsLYvoIRpuUcpiK0NigTrJ5IFw+EXoq7iBkodX3r0sojJ1eQKSPrQuJvscqi7uwIaiKu4BQN7fON5o4Yy9zMNpXhkcrh8O0UwRkfULrY2Y9Rm3q2gUXdj/EYUQHrKTCRgDCtrBN8ZVAIVAOPOg98UYR9AeglB5mDUsCbie2XB8K3e2rlCBhJtsd0t6tT4B8Q8EAzIYrqXR0qfn6QE6cMukifLJScfimKayXa+qZYpU/RUJKeiFlx7hXqAR9crkTVlG+Mm68AJbtsVzgj8BJ2lXxBnZTZBTLWsupXg/F5ZUHm+LcNyddrMGrLokGDe7uLeJWLpq/ZrRkBEn2BZSSo+80m5DKMGn0Hmx5akb4kkGd/naZ0efuq/h8x+0zvTV5dOKk5WWkVZEFxKZWkZGH6u6l+FI5JVBTg+W2E4gKON+7BKsRqzBQVOE0k1bB8HZPK
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009cebbd-9e25-4c28-1908-08de84c12d23
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:37:15.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nysf5XVaRZQ+vfhAadYvzhZ8Ht9LSjzDAwKoRh+g616K24uhqWi6HEXmZtmlcCasb3rUF15KyuqfkCovaIbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P192MB3116
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
X-OrganizationHeadersPreserved: PA1P192MB3116.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2MyBTYWx0ZWRfX+wnQeaDImZGx
 IrDqb7kaHmzzLZvnaK7am6yQwbMxebSOqSImYJWdi/2/j4yZv7NdUBP5N5cb1jaDaUpiHEYMw/D
 n3B9w4yx0EARL5d/YSoflF1dOQhRT08nadLy2QgbmNx2O0K/xKiK8uMADxFVlWh1fuq8Iy+rNYV
 E7Vtu70kDamCnUEsZqN+mm4CDQ2RJOa+BfFf+4iuQOF4e9vyaZ79Y7c9zdNhCjUWl6VcAVhJYzB
 7ZwPTHv8077fNv69Sfq7I3eKpyHBWyirZ5ZLCzQjAZNoJV1+TStrLtzNp0T/q5yCvoBlddoYIIg
 wiqEbPSPGFgIGxXWvaJGBhAebpKF+SbM1QZ7AA4/hQ1F+lDUijxARIlSH8PMOtJyYnvp0eNCyy5
 aSzbwXFr3hz7D0HIdl4chQPm3Hoc+R9DMbkgMSV7K8qjF/Od7pt02Tv5ItiHkqz2gxts3cT6/5f
 fQ/68AWmYQB9LdGc35A==
X-Proofpoint-GUID: XKmCrETyWMRC23XFii13ME18TENS4XLo
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69ba562d cx=c_pps
 a=tRsWMqnSfznE2b7oc6joZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8 a=P6DDrAdFcA6Gy848D_IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: XKmCrETyWMRC23XFii13ME18TENS4XLo
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33376-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,westermo.com:dkim,westermo.com:email,westermo.com:mid];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E1B922B7156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver uses u32 data types for the HE/EHT capabilities in
CPU‑native order. However, the ieee80211.h header defines these fields as
u8 arrays. This causes the ieee80211 registration failure on big‑endian
platforms, as shown in the following log:

    ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath12k_pci 0001:01:00.0: MSI vectors: 1
    ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
    ath12k_pci 0001:01:00.0: qmi dma allocation failed (29360128 B type 1), will try later with small size
    ath12k_pci 0001:01:00.0: memory type 10 not supported
    ath12k_pci 0001:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x1005 soc_id 0x401a2200
    ath12k_pci 0001:01:00.0: fw_version 0x111300d6 fw_build_timestamp 2024-08-06 08:43 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
    ath12k_pci 0001:01:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
    ath12k_pci 0001:01:00.0: Invalid module id 2
    ath12k_pci 0001:01:00.0: failed to parse tlv -22
    ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
    ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22
    ath12k_pci 0001:01:00.0: failed to create pdev core: -22
    ath12k_pci 0001:01:00.0: qmi failed set mode request, mode: 4, err = -110
    ath12k_pci 0001:01:00.0: qmi failed to send wlan mode off

Use the __le32 data type for the HE/EHT capabilities instead and avoid
swapping, so that both platform endiannesses are supported.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
Changes in v2:
- Rebase on latest ath master
- Fix endianness in extra_mcs_supported bool in debugfs
- Link to v1: https://lore.kernel.org/r/20260317-fix-he-eht-capabilities-on-big-endian-v1-1-e7b937b32768@westermo.com
---
 drivers/net/wireless/ath/ath12k/core.h    |  8 ++---
 drivers/net/wireless/ath/ath12k/debugfs.c |  4 +--
 drivers/net/wireless/ath/ath12k/wmi.c     | 58 +++++++++++++++----------------
 drivers/net/wireless/ath/ath12k/wmi.h     |  4 +--
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..8481015dcda6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -788,13 +788,13 @@ struct ath12k_band_cap {
 	u32 phy_id;
 	u32 max_bw_supported;
 	u32 ht_cap_info;
-	u32 he_cap_info[2];
+	__le32 he_cap_info[2];
 	u32 he_mcs;
-	u32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
+	__le32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
 	struct ath12k_wmi_ppe_threshold_arg he_ppet;
 	u16 he_6ghz_capa;
-	u32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
-	u32 eht_cap_phy_info[WMI_MAX_EHTCAP_PHY_SIZE];
+	__le32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
+	__le32 eht_cap_phy_info[WMI_MAX_EHTCAP_PHY_SIZE];
 	u32 eht_mcs_20_only;
 	u32 eht_mcs_80;
 	u32 eht_mcs_160;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 358031fa14eb..f71ac5853cda 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -410,8 +410,8 @@ static bool ath12k_he_supports_extra_mcs(struct ath12k *ar, int freq)
 	else
 		cap_band = &cap->band[NL80211_BAND_6GHZ];
 
-	extra_mcs_supported = u32_get_bits(cap_band->he_cap_info[1],
-					   HE_EXTRA_MCS_SUPPORT);
+	extra_mcs_supported = le32_get_bits(cap_band->he_cap_info[1],
+					    HE_EXTRA_MCS_SUPPORT);
 	return extra_mcs_supported;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..f5cd1eb27685 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -487,12 +487,11 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
 		cap_band->max_bw_supported = le32_to_cpu(mac_caps->max_bw_supported_2g);
 		cap_band->ht_cap_info = le32_to_cpu(mac_caps->ht_cap_info_2g);
-		cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_2g);
-		cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_2g_ext);
+		cap_band->he_cap_info[0] = mac_caps->he_cap_info_2g;
+		cap_band->he_cap_info[1] = mac_caps->he_cap_info_2g_ext;
 		cap_band->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_2g);
-		for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-			cap_band->he_cap_phy_info[i] =
-				le32_to_cpu(mac_caps->he_cap_phy_info_2g[i]);
+		memcpy(&cap_band->he_cap_phy_info, &mac_caps->he_cap_phy_info_2g,
+		       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet2g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet2g.ru_info);
@@ -508,12 +507,11 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->max_bw_supported =
 			le32_to_cpu(mac_caps->max_bw_supported_5g);
 		cap_band->ht_cap_info = le32_to_cpu(mac_caps->ht_cap_info_5g);
-		cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_5g);
-		cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_5g_ext);
+		cap_band->he_cap_info[0] = mac_caps->he_cap_info_5g;
+		cap_band->he_cap_info[1] = mac_caps->he_cap_info_5g_ext;
 		cap_band->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
-		for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-			cap_band->he_cap_phy_info[i] =
-				le32_to_cpu(mac_caps->he_cap_phy_info_5g[i]);
+		memcpy(&cap_band->he_cap_phy_info, &mac_caps->he_cap_phy_info_5g,
+		       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet5g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet5g.ru_info);
@@ -526,12 +524,11 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->max_bw_supported =
 			le32_to_cpu(mac_caps->max_bw_supported_5g);
 		cap_band->ht_cap_info = le32_to_cpu(mac_caps->ht_cap_info_5g);
-		cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_5g);
-		cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_5g_ext);
+		cap_band->he_cap_info[0] = mac_caps->he_cap_info_5g;
+		cap_band->he_cap_info[1] = mac_caps->he_cap_info_5g_ext;
 		cap_band->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
-		for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-			cap_band->he_cap_phy_info[i] =
-				le32_to_cpu(mac_caps->he_cap_phy_info_5g[i]);
+		memcpy(&cap_band->he_cap_phy_info, &mac_caps->he_cap_phy_info_5g,
+		       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet5g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet5g.ru_info);
@@ -2226,14 +2223,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	cmd->peer_phymode = cpu_to_le32(arg->peer_phymode);
 
 	/* Update 11ax capabilities */
-	cmd->peer_he_cap_info = cpu_to_le32(arg->peer_he_cap_macinfo[0]);
-	cmd->peer_he_cap_info_ext = cpu_to_le32(arg->peer_he_cap_macinfo[1]);
+	cmd->peer_he_cap_info = arg->peer_he_cap_macinfo[0];
+	cmd->peer_he_cap_info_ext = arg->peer_he_cap_macinfo[1];
 	cmd->peer_he_cap_info_internal = cpu_to_le32(arg->peer_he_cap_macinfo_internal);
 	cmd->peer_he_caps_6ghz = cpu_to_le32(arg->peer_he_caps_6ghz);
 	cmd->peer_he_ops = cpu_to_le32(arg->peer_he_ops);
-	for (i = 0; i < WMI_MAX_HECAP_PHY_SIZE; i++)
-		cmd->peer_he_cap_phy[i] =
-			cpu_to_le32(arg->peer_he_cap_phyinfo[i]);
+	memcpy(cmd->peer_he_cap_phy, arg->peer_he_cap_phyinfo,
+	       sizeof(u32) * WMI_MAX_HECAP_PHY_SIZE);
 	cmd->peer_ppet.numss_m1 = cpu_to_le32(arg->peer_ppet.numss_m1);
 	cmd->peer_ppet.ru_info = cpu_to_le32(arg->peer_ppet.ru_bit_mask);
 	for (i = 0; i < WMI_MAX_NUM_SS; i++)
@@ -5034,17 +5030,17 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 	u8 i;
 
 	if (band == NL80211_BAND_6GHZ)
-		support_320mhz = cap_band->eht_cap_phy_info[0] &
-					IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		support_320mhz = le32_to_cpu(cap_band->eht_cap_phy_info[0]) &
+				 IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 
-	for (i = 0; i < WMI_MAX_EHTCAP_MAC_SIZE; i++)
-		cap_band->eht_cap_mac_info[i] = le32_to_cpu(cap_mac_info[i]);
+	memcpy(cap_band->eht_cap_mac_info, cap_mac_info,
+	       sizeof(u32) * WMI_MAX_EHTCAP_MAC_SIZE);
 
-	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
-		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
+	memcpy(cap_band->eht_cap_phy_info, cap_phy_info,
+	       sizeof(u32) * WMI_MAX_EHTCAP_PHY_SIZE);
 
 	if (band == NL80211_BAND_6GHZ)
-		cap_band->eht_cap_phy_info[0] |= support_320mhz;
+		cap_band->eht_cap_phy_info[0] |= cpu_to_le32(support_320mhz);
 
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
@@ -5132,10 +5128,12 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 
 	if (ab->hw_params->single_pdev_only) {
 		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
-			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
-					 IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+			support_320mhz =
+				le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
+				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 			cap_band = &ab->pdevs[0].cap.band[NL80211_BAND_6GHZ];
-			cap_band->eht_cap_phy_info[0] |= support_320mhz;
+			cap_band->eht_cap_phy_info[0] |=
+				cpu_to_le32(support_320mhz);
 		}
 
 		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 5ba9b7d3a888..ea680a1a5464 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3911,11 +3911,11 @@ struct ath12k_wmi_peer_assoc_arg {
 	u8 peer_mac[ETH_ALEN];
 
 	bool he_flag;
-	u32 peer_he_cap_macinfo[2];
+	__le32 peer_he_cap_macinfo[2];
 	u32 peer_he_cap_macinfo_internal;
 	u32 peer_he_caps_6ghz;
 	u32 peer_he_ops;
-	u32 peer_he_cap_phyinfo[WMI_HOST_MAX_HECAP_PHY_SIZE];
+	__le32 peer_he_cap_phyinfo[WMI_HOST_MAX_HECAP_PHY_SIZE];
 	u32 peer_he_mcs_count;
 	u32 peer_he_rx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
 	u32 peer_he_tx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];

---
base-commit: e77fa9aaf082d1774b205275c5bffac5a5d1dcb3
change-id: 20260317-fix-he-eht-capabilities-on-big-endian-d941c42f65e5

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


