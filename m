Return-Path: <linux-wireless+bounces-38268-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PtFvFxsqQmrO1AkAu9opvQ
	(envelope-from <linux-wireless+bounces-38268-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:17:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7AB6D7640
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:17:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=LnIkU+qY;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=RyNKBBHa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38268-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38268-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83EDD30683E9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECEB1DB13A;
	Mon, 29 Jun 2026 08:00:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C83E3D86;
	Mon, 29 Jun 2026 07:59:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720002; cv=fail; b=ojYDlQgtw8DfwkVt4IYZjCgCBzaf4VbrNEHLzLlwdoPmGjNnAmRGwxPe/1uCHmQSsgf5ODRu+TsgML2GgbRufUoEsyGc5KZZE4NShk7q2pNTW+Q7n0jAdOCAVGygsTnihgs6QLfX5yJbz/9R2gicp4a+ahNv8xzlU4gglZjRHkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720002; c=relaxed/simple;
	bh=MT4KAcuKQbMvcYtQTM5NULCFc+Yte8u+El+A0qLSo5c=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Fx3OVShIkf6Shrz3sB2sj8MI5BhstT8eMIZJ7JGJ8cbIvx4WK+Mu/hmB7Na9vNGfxfIv1x0MFm7IuSCf3XtZxaxqcOYe8KZ9bV0VYqpRrTQrl/auZkSenx+ROzz+Sbpob/4pOipIiTiHvFyy92SLX5crqMnoo34U02VSKPyifWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=LnIkU+qY; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=RyNKBBHa; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6o9X81720245;
	Mon, 29 Jun 2026 09:52:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=t8Xved9iNvQxEQeBAzcZxT
	m4lk4vFUEJdzDTnBUTwcE=; b=LnIkU+qYEruhvqePhhlq9aJaKHO++uh27W6Wmd
	5kdMnbYTEG5NM/m+0xHwkBWcZr9QT67abEXEgBkjHaXCkDm4PAnghMuqnlacM9j8
	xKMgMDIICiErskyC9bKG2L9DfhZXFwugojQEfZeGcRsT9ceekTzd0saH/Am6j36x
	oTTkPKoLDC64a8svtsVK6n9C+Kvx8ArH9txm8Lv4bxxJQb/PAaGSD+LI7EMhzke/
	MmL5sM/PHcQ1K0Gb7+HIdTD9bP8+jYHviAb6+/6T+E+oB2KEpTocVVs/g68+Qjl0
	zYdgqZAYg8KXEohqLC+8OW5v5D1u27h9VrbtNfoZjuWkue+w==
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11023110.outbound.protection.outlook.com [52.101.72.110])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22h0t84k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:52:42 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZmeiJWVqssdWN20Hj5i8Ea7M0jsro3NQ3zfcTw4um5TS8fudSndNCLtm4rlpewN76pA+/TdjGUbM4LBsWlHPJig4esEPOpmdTojQr6/j0i8dHS2aNPCQwI88twjIw6V28oj0gWETmH9KSVPmG3yoDYdl/lB+7jpQKbD8dkpRB+EQFtnvlfoiGPsQeAQsRoNKn+sMhYXtJEAv7cUpXR25Rti1GCW80E+nSJN6qlKBWoKshVPeZRbdLKNBhGYrb3VPw0qzC2W9WrQDl4/71HKHk7Vn6Apy1BBXSpRoOJtqTrdlPBoz2L1xVxqE4bT7pwDgKsaeBBIO+aOR1t9FbF7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8Xved9iNvQxEQeBAzcZxTm4lk4vFUEJdzDTnBUTwcE=;
 b=edbTf8quFdQaRUjZ3DZ/IN0uQFcNDfMeBBwWkP3MjdoEQt4n40sKAqRDleEFd1KOtE0ndn+Za5j+ctjbM5RFaROMEbs0Afn6RYX3QM0u5xStRQIpy4CGe6pSdrjz1vUeszmNN6T9crVm0ZwgT473xwu/ob2ejxgzFU1oJNWZgOl6TYf+XdQoRWgvGSVBM0KiNqIfJmRrVDSPLESSIGtZc1T2EOSPiTSxKImjMe9p1CaKOPaEHXhhYrJ/HRuqORU7p+Iu+JeSDcFXPCIhTRgEP3SPt/tVGop0pdcBbRAFUqLxiiO7VuArxMurUCCk8JXDNxtajxU+L/bqH2k/cjkHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Xved9iNvQxEQeBAzcZxTm4lk4vFUEJdzDTnBUTwcE=;
 b=RyNKBBHah6rZapnTbaUg9kIQR1Y2LrgLNYcheC0QRSyig8YhheK6Mtm3CNIJvszmrkdrXNcbfngm4hexPEsDznj3K3pCi0vRioPNx91sxrjf27PcDVhJagoMk0JEsTnWwNEXlOKDNEH+0TF/TUT+N8xYAuEfELXO2jasLwr2VdU=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by PA3P192MB3013.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:52:41 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:52:40 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Mon, 29 Jun 2026 09:52:36 +0200
Subject: [PATCH RESEND] wifi: ath12k: fix HE/EHT capability handling on big
 endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-fix-he-eht-capabilities-on-big-endian-v1-1-47026f59b8b2@westermo.com>
X-B4-Tracking: v=1; b=H4sIAEMkQmoC/5XNPQ+CMBCA4b9COnuGlm8nB1kddDQOtBxyibSkb
 VBD+O82TMZJx7vLPe/MHFpCx3bRzCxO5MjoMPBNxFTf6BsCtWFmIhZ5nPACOnpCj4C9B9WMjaQ
 7+QCA0SDpBqhbajS0VcpVKro8w4wFa7QYHtfOhZ3qc308sGvY9+S8sa81P/H1+mdp4sABC1klh
 UxEkZf7BzqPdjBbZYY1MolPuPwVFgEu47TLlcqESqoveFmWN5kJmuw+AQAA
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV2PEPF000239DA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::178) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|PA3P192MB3013:EE_
X-MS-Office365-Filtering-Correlation-Id: 84041a16-5bc1-4536-979c-08ded5b3653a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18092099006|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	8HEM81sydojQwqjimVmh7Ri8E3H0IB4I9bZ1nnMwJTIJfXllQGKyYkhG3Hm4yscibEtY1725ucX5j2ZdMWb9JKZp+ekcswrE707Wk+7nr4xa3xOt6j9XO8DGN+BRYRIyh2PTNuSNrlDzpt1Ycf43c7V8/VWn8AQBmlTTqma4GAhiVzQ5fwgxnFtcE8SBLQoJnDwvdwzkns9vvLFWiToHyDNrrJO24gyzBWIBgaUdW9LDgADT6V/OgI3+bUeJBNXisPe4zi6IJO3zwCiDBrnLbCfwLB7QFZ1gA+/+fOwoqHBK1/L2d5kuG+alijegcqU1s5E8E26H4e1t0wUANBNvxyJk1IQOgXrrugZFcVYG2kJsdyIJbjofJ1TwgCrZStvnlAF3H10kEuALbaq3GYqo30TioXRlczSDObtLKB5mKmcnHUARyxV+2cr4tWQHoviGYqjUr+rKb8slpUldmjqZqJU8rK9bH35oppBrhWXi3pDu6aD2cyenxdRNu+dAD4s6oZENV5LaYI4zCVRBYZ19rzs0O2HUL11TmubQnCiICGup5bCUAgwOl5p9rUWbwWqyAF0tU1K6/PeKsWui/jd6ATrJm4FoEYVLNzWeRe/HSXrHIJ9/bDOiwQpV3JoSUEwWUA4aeXYerpoPr9QcWBt9VbNeUcjdNVATYlMi6KaUjG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18092099006)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzNKVEc1MWdwTkdRSUF0U3VQYmRNT2sxSDFTZUJJVGNxcXFpb2lpaXY2algr?=
 =?utf-8?B?Sk5FREErU0VScCsyL01vK3lyeWZoYUZRUzhsTmJPRjRFSFBxQ1AwaDZZL2o1?=
 =?utf-8?B?RG5DZXpCV1JyU2dkeU5qajZJcFpwQ2Y0S2ptVHdMWUZrVXJ2dXJYN2lRQmoy?=
 =?utf-8?B?RkNFbmFNa01XalhmdFI3RGs2dk1aWXRjbUc5UHBCdkN2OU5NNUh2bVVLeU5j?=
 =?utf-8?B?cms2Y29Bcm5RVi9RQ0R3bkRGQVMxWlEzT3YzbzB0NmxVK0M2UVdvbjRNZkd6?=
 =?utf-8?B?Z203TGVxb2YxTWJqL2prM3o4UEVFUElZVEMweHRnN1o5bVlEKzNEalRLRzd6?=
 =?utf-8?B?Q1lhQkNwemJUbDZEdDVXUTVFbis0T3BjSTd4bkZneWk5TFdVWnpNaUhWYzdD?=
 =?utf-8?B?NS9ISllhUmp0TnRqME5NMG9rNjg2enhneGpJaVkxazJ2VCt6c243TEtKQ1Rl?=
 =?utf-8?B?RERJa1BlSFpaTDhTUjEyaWtsOGZmcHBZc2ZBS2xZNjh1WS93cTZCQjdDelpz?=
 =?utf-8?B?Q2svSHpRQmYvRmIvaXM5TGZCNWRhK1E4N0N2dS9RdVJnb29hdkpqOUVvZEd0?=
 =?utf-8?B?WDdoVWU4WEIvdDBhKzNMeWtnMXN5SGVJK1NzcEhUMitISVMrOWprNExpeWdz?=
 =?utf-8?B?aHRyN2ltODBCa21LVkswWllrYUk0Tk1OT1gxdExvL3Y2UndKcm5kUm5WS0VJ?=
 =?utf-8?B?VkYwSHBLZ2NyZ3ZWQ1ZyMzg1QWNnVE9xS0p4M2tZWFJVaG5Qb0V4bkd3dit3?=
 =?utf-8?B?Z3pjMm8rNU5sUU1ONjlMUXJ6MDE1Z2NEY1V5YnM4ZiswWFVaMEQvNUtrZTFC?=
 =?utf-8?B?cXNVUGxCZ29rbWNWK241ODFNWnBMNUQvTkJnZ1FZaWJNNEdnWkRIYnpOSzht?=
 =?utf-8?B?bHVNbG4za2VZenRHNTE5bWpXYUp5dVlsUUR4bWV5bUVrSnMzOS9DSmJmMDBH?=
 =?utf-8?B?OFI5dUFXMVp4aTRCL3puZDZiRkVoNklWOWlFWG9xRnZjdEdaaklYNVNxdWZJ?=
 =?utf-8?B?SjJUTDNtWGtyL0FOeXBBNC8rRTNZMS85TFJMdDEybzFrcXo2N0VhM0NJSW9E?=
 =?utf-8?B?SlhLM2RnT1hiZU13MHJqNkJrS1pzdURObTFJTmFvUXZxL1ZiMlBoTXJkSGR5?=
 =?utf-8?B?b2wrMXNGTXlHTVBWUW9GdG9lclNSZDg4NVNVUWh5T0M5VkdpOWNmTjdxSEM2?=
 =?utf-8?B?ekhOdndNSWFZYlcyYWY3MGJpSnBOMU5vblJtbEZyYjJXRUhoRCt4TDlwUXRQ?=
 =?utf-8?B?NjRoUUxDUG5zMXl3eit5TEovVFNKZHMvQUxqUmJhSUFVV2pxSHFGUE5BaGN2?=
 =?utf-8?B?ak5CRG5YdkFnVXBNUVVTWkJLd3R2aXB1Nzg4b3QxdmxRbkxMQW1PSUpkVENh?=
 =?utf-8?B?U3Bad0tpNTlMMy9QYlVKa1IvV21kU1ZUUFFMSzdKZFB0YUxzQ1pwWHkvZlEz?=
 =?utf-8?B?eVA1OHFMS3JDR09RejNBeFR4eHlRTjB2cG9WUTd0a2JiUkRRVlVZY05zbEkw?=
 =?utf-8?B?ekpmUVRrSlVUcjM1RUEzMWR3eUx1TlhKM2VqNVM5dXdWcGJ3RHZzSXZlUEYx?=
 =?utf-8?B?YlNDYmFvREpvN2p6NHJYb3lCZkhubGtMUnZZcCtxY2dFZ25ZOUw5VE56QlBE?=
 =?utf-8?B?c1NiT29WdlJoNDJzeHo5WExUb1BFaWRIRjhBdk8wQlRJUXRpS2FmbTQ2aHps?=
 =?utf-8?B?MGZLc21PSDlWUEdwKzJBV1BpKy9Lc3pXWnhZSmE5QnlhZzlxS0M3cEl4MGpq?=
 =?utf-8?B?enh5dWRNTTlMbFZwR28wczdabVl4bjZ3Zm93M0pVV0xMLzltWnArNW5NNTh0?=
 =?utf-8?B?THBjaFhoWllpeGVrZWNqQlQ0OWVmS3YyMXJKMmlJelcvajk3TFRxSEJtaGd0?=
 =?utf-8?B?b3hOWjVMSUlsRDdUVzZVc1pWVUlJK0cyUnd4czY4N2hkMzl0L0E3blZ6S2dw?=
 =?utf-8?B?Z2NQeUNlc1pxOEwyL3NwbElDLzc1NmlVQXBYR3ZNNGtIbEw4SnoxblVwSHZ5?=
 =?utf-8?B?SHlzT0gvSURPR2QzWjRBL0xnYTA1S3p1bmFub3FCQjlBU1c0aVo5dmtUbXd2?=
 =?utf-8?B?OWJhcC9wUWk3MTJHLzZWbUt2WHVBa3RtUW5zbXRtM3l1VkZ2bzdtaEIwYTlE?=
 =?utf-8?B?Ny9xZkMwaWVSN0J2Tlk0azUyZkdlVnJtQnQ2UFB5N1p5YlhTTnNXUjZ0NUsv?=
 =?utf-8?B?ZDdWRGcxSUxHUFhVRlZuU3g1RDFtMmhXUkVSNHBJNytjNWMwN05rTUlFQUFo?=
 =?utf-8?B?V09zQ2UwQVJIdEtScU83K1ZKajl2dld3bTAxU01IRmo0VUc5M0VBb0VuUXl6?=
 =?utf-8?B?VkJIeUNqVVR2dTBQdUI0d3NnWm9lUDFzVmpnZG41d01Ea2tQSkQwUT09?=
X-Exchange-RoutingPolicyChecked:
	pc4AKOIFVYnP5BgXgAdTxpscpDMvc/P6dLb0+KY8cXbajzheqDqv0JiGZnTjsokFfMop9SDOy3aE8Ml3ezjP5Eg/p/c6+5Icyql3RpZ0gKpzGHKY8bY8odW8ewyVsTxHJaB99GkXjkCCenwSSLbOEdvVosCp+qB0ZZ6BqKffwXF4mUPSZP/bG04xQ25yxSJpQXmsAvJnl0oOR/nfVCjZhHSgkeXDW7rYY0Ow7wogVdOmF7UVtyBH9UYpUftII0thjrXxeRyCH/RUEqDnsToQ9oaPb9kCEAqQZ/6HH5ILvZI+DvEA9YnYwFzMZUQibUp821Zhf2V1TqRCzTCXzecXzQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etGub1fRra4APNxX89ScREZTcPIiNyWhT5UZBWo9XQZsfHtF47oNHmMUn9ASaWrac6wtxM9qZRt96c3UmFeAVuVXi3EpLHYs+yPD4hXpe9wHTa0d5109ZJCfC1MpAUXFyRumDZfLAZQOj7CA/tyBwQwIMJgwpV9exJGavBsKzU8+DOJIqbCw54qQpp3fDwhLosUkH85RtFteJKrMQQjBtU1l8ZPCjO0ad6qfQ3P6K9iohkeXznhkJCKAY9/G2izv0TYdQCp6urin2pNW6Kugc7ybhIyXLVm12A6xpOrQrs4AfYsjtZAvIJffDPdhdFQ2yTWzwKatwQLJ2IT4SWPT6asQuohh5kIM3ZWuCembQFfvKwwbncKMzUArj+MO1NmNh+nXjS6Dow3hid6VE98lkAVft5JuACRTI3q7nzCS2EM3hWtDiz2ZTFRnhP27q+s6kodU7LLmF25CcrLeqEwks3gI1n3/7gd8+u0w+gXU8wPo5xP6LKlm71HaPBDGaJRYulhSqKELuJmNHKCe5A0XoDf06NCAhljbGY3A7O5ia8GogBa8Nr/LxQMomyt44Df2l3AxIGGScyLc9O21IHx5lnsq3WmLRrMEsfZneroixCdg+iyTw4ErxUDG2aZNrfXA
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84041a16-5bc1-4536-979c-08ded5b3653a
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:52:40.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+bSPzmjMcYSOuxILLc/S70SNBF53bW9oQ7OUA4gtSrhZOw6RKeociEu0pkGq8cH2US5jKvsVtt03Rh9bLftnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P192MB3013
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
X-OrganizationHeadersPreserved: PA3P192MB3013.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: gI-N58B5jIodl2OKJFQgrygPFGnZVqT_
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a42244a cx=c_pps
 a=GOCvCvAqFs6MniXVvcVIMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8 a=P6DDrAdFcA6Gy848D_IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX+jusGR3E4L/h
 IxZpcRy2GbY9mF6+4z0MhHknn+X+lIOgOVi3yDh4wvTCCtDYPjbkIds1PqtAXRGo8prAshxlOVL
 8kPFVOs0rS0d2Z6axdogk/JDSaieE44=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX/x2g4EzQhpU8
 /OMsHkjw/YWrFnFuil8tg+gHHBG3nvMGDQVj+CU3W79TlUAC818v4FMLDzsQROE3D3rqffXYZDO
 wUur3UfbAODG3qLuNGlWPWwAkw4iPYZqXvXASnBs26INO2M+g1woYvd+Q+mHQ518/MDP+iakSlW
 nIypCxXDiEWG28YWT07VFOt/pO6v35FwaJPs0rS/YgMqZUsDKXlIZlAf5XY9Hsp9HOG2DD0Wh0A
 APnY2/+yXJE4NjN1fGtu378jjElD+/Iifl1nuYyKwFlrDANv2bM0JHNOmyjE/1WeEGGHv3NM6dD
 XgLaBHnvZEvNp8Up7UBqmXvcfu/xnyTLk1yb8W3cAaOpxyr9c25xzNfpv/BkGCQ6Q6nZlpKw4CU
 jrAfkNFPh1JXBbNU7+4amqxVwE6jx2TIxFH4HX9a5+YG8GVbtHSUg8C0/rHSqBnFrQ0BQoPKzBi
 8KtP8Q5Vi3AEQlwHJgw==
X-Proofpoint-ORIG-GUID: gI-N58B5jIodl2OKJFQgrygPFGnZVqT_
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38268-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,westermo.com:dkim,westermo.com:email,westermo.com:mid,westermo.com:from_mime,vger.kernel.org:from_smtp,beijerelectronicsab.onmicrosoft.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD7AB6D7640

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


