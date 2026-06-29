Return-Path: <linux-wireless+bounces-38266-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VezLMpUpQmqW1AkAu9opvQ
	(envelope-from <linux-wireless+bounces-38266-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:15:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC146D75BA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=YyZzvYId;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=lL0hvzFT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38266-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38266-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82B5C3003E9C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33AE3CFF6C;
	Mon, 29 Jun 2026 07:56:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C4370D5F;
	Mon, 29 Jun 2026 07:56:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719783; cv=fail; b=LAuX6rguUqe+Ymnh5lvPVbWilDCo4nUwcYyZH0VlgOgxJLcIjw27SOVbpDc6dbWqtcrIH4HPBzr+YZo3RlXwNZEDQZnm0zDBv5h5ryTTpysRESRSC++ern6jrU0vqkF792Oli+2WibRmkCBa35W586xLv68usXVrG5tavhoHSs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719783; c=relaxed/simple;
	bh=P56+bsfukgEdfmHriqGH+5MEbSH0ex/pz8Ez3VwG+VY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ciBkgJV04leyoz/UBnOl6sk2tVfyRC6JcZn6gwBzIMbnFy0V/apaRLfw7Wt9Bl2IjXoXUZ9D+BPO6ref/B1nwPDNU1ajbQShnzQ7f3SssOt9H+pDTku3fUEgGcwdSotgGPSEotjDzclnA8yCLYV4S+2UEuwDH3x5saglvejHgBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=YyZzvYId; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=lL0hvzFT; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6mMCE1653863;
	Mon, 29 Jun 2026 09:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=YQNwzfj5WlNvKefuBDaNKv
	SFFz/Ful/gKD2UrrMGEEs=; b=YyZzvYIdcuslBNrkyvXvyxCJgSJZgzeFz1SyHK
	desO+fS2O5vZEpK0Q6Yz+g66U/6QOF6vKVABDTb1g3PNylzmIChGRqLGSq3EM7fO
	z3wPyJhzAgC3Q3I3fvCm2JL5p6SyfgDOFgpOyEwTtWqWxwI0YZn5H8QxEiOZjvgg
	Uug1cop3bF9EtcH6veNgbbbFYqM9MFNg+I6oOKRnHatMuN373CZ17CC+6ddUlB1S
	3JqUrmGmO8vH6via298VpsCM/G7rtqoyAJcMzULCO1UQQAmt65Ac7S4f8u7yvdOs
	fjNdKbt4gV2Qjehf/DZ6HYnSoPYdAT6CB8iZz9oh10j2eRiQ==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023122.outbound.protection.outlook.com [40.107.159.122])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22v9acxv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:56:11 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8Hb9QOP1XgX+n0zEsjI3g3o1jFsY9IHXfPRrCgWoNXor45Qgh+tlFrJj6+Hf6S+PD5b513nYwwa2924P3JI2geMVmGDxHqleosvw1NfxjmKy+Sp2opOxkxHVw5YDB4oTrjo8mTVGN2k6Bxx//aRSLLjn6BLbY/NHXnAFrVxv3olxcGglTiBUJ0kO7IJ7cofgRtav20rqOGZAO/sh0PEG/xqsWT7hc0YRP6l184DxD19RIhYEzN3Q7wpAp4DHzbYY6SEpTCgvyyydNcc/FgWGETyTrniuTw+yWqXYK5GQGW3VBLwb3QVUeSG8H3YB8SnYi8PT5aRhvFpynQltzYSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQNwzfj5WlNvKefuBDaNKvSFFz/Ful/gKD2UrrMGEEs=;
 b=BEgmHvKYLGpsM8rW0MZS2H91jS5heBHxOBdcFj+lHQWCo8t9ZnAgxbNQK6Q8+03CeYTMz8FEb6z6kuzGALtlCIU4EkKLXmPCNgAyZnfeTD0F+A/GsXVHWbdp/1J4zcTv0XWF2RODY8dDir9d0zM5kQfKsdcKuEDs97rwog6RJQJjP70GYpYiSiIR2QZ1D4U+lIJ6EkZvkeN03QIdB8AfGnTyvtkiZoOC5ul7ZPXwubYRw1PQuOXfi5R0tBkOARQDpb9vm1wjYhVOAbdbSiW6ySPEYV60TaPwtJZsu67MXYP4x5x/XC/Vk68sIjD9fxUcyc3Ii1RUg0z0PP0HFWUpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQNwzfj5WlNvKefuBDaNKvSFFz/Ful/gKD2UrrMGEEs=;
 b=lL0hvzFTK2p2zg4bw0aYuNIutNtCxeYUi8PNhJiVjyZI8AIxppe3KxipAQO37wfSjWYd/yc+5Md0pvk0o+DD1XHRWZdm1W3pOfq+bVuZu55a8EGJlfnwxXJUAsCbEqxWZ84LzJxu3UnIGNPK8q7sCqETPOW/FGEIR+rdpA7che4=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AM8P192MB0961.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:56:10 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:56:10 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Mon, 29 Jun 2026 09:56:07 +0200
Subject: [PATCH RESEND] wifi: ath12k: fix SPT vaddr handling on big endian
 systems
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-fix-rx-tx-description-virtual-address-v1-1-ac1669eb43dd@westermo.com>
X-B4-Tracking: v=1; b=H4sIABYlQmoC/5WNwQ6CMBBEf8Xs2TUUQwmePMjVgx4Nh6bdShOhZ
 FsrhvDvNvyBx5nJm7dAIHYU4LRbgCm54PyYg9jvQPdqfBI6kzOURSmLY1mhdTPyjHFGQ0Gzm2I
 mMDmOb/VCZQxTCNgIWwkhm0LWAvLXxJTBzfOAW3tvrxfoct+7ED1/N30S2/qnKQkUaGtFkqyuG
 6XOHwqRePAH7Qfo1nX9ATK0M3zlAAAA
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3PEPF0001DC3E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2e5) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AM8P192MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d399d1-1847-49dd-906b-08ded5b3e225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ITcO/7G9lWqfBj/tIoYjn6T7s62i4T74rhwGOBs2RKpYNq6qSZJzPxXPxW8vyDaivHiUhKIAKDwHCVWD60+ZdkVzng1fkF9t0U9ieqdP1Yhkr3lAF7ldxBkQa1VMdWlL11+1OHA/XWdXSzyi7gPKG+Jn0TJegg02yZrVFf5hLIF9nXGQRC+RWpv7YtPyOSU0j8RCwlO/P4C+MbA7ZEQnQSFA4sbRJbATIBVORigcQDbOzoKMO19zUjrD7iOLotUg84ekGUFw7bYZtbNSuIaYOG0fojkdP/+rLwIsPS98TyFgoDYxkM3+FxQs93wFlraxbc2sVbxvUtN5LT/jyrQlUEKgcGma0LOYfdLXHj1N2ocXYa+A9o7uxagL2xOMElvqXoCu9OEEZheTH/7wF6XcRLIDDLB9In/h5OnqJOADWpUuRbJVWhJjq54SAGjzNliEJ3cKP14mAa/1xeAkHEVaf+euJeFBsU3k1EG98rUFlqz8s2VaAR6ypGvbajvxnMt5LprenUc6q3PyMx8DJwixekynRTRCzKZ3tJhwQMtkeNBfRUzeDKEzHbTXf3r+ZzZsbUerDUIz8rv7nRi9+bCXq2BxyeCJDQuKP3pZ1iGjGBngUMnOpykDyCbsqVvNMaaoe7VV9ycUFYOv3fdV28oQCIzt9KVPUI96PB+CCFlvQ7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJUakpFRFVJdkhPdUxJaG8xdm1DK2FaVVY4NGx6N0hvWEdUMEJ4MkE4NmFh?=
 =?utf-8?B?bkpDdWRtZ0k1VkNETjUvL3Y2TWUwb0g3RElpMjlrWTlSY0JNdWtsRU9DQm9r?=
 =?utf-8?B?c1B0YzI3Y3NsQ0c0L055OUplZmc1Q2RxVElLOUtWR3VMeWpDNWJueHZ1ZmNT?=
 =?utf-8?B?RzJRRXhFUnZMVmJUYlcvYk90VWxmU084SmtrWXoxbDBzQmFxTG5yajFabERR?=
 =?utf-8?B?aWVIVkV1ck1jVnFjRitpUEJLVGwyU3NnNGU3SFJaNnNSV3YvVzJQcDhRbzht?=
 =?utf-8?B?WUxjQzR6WUR5V2FXV2ZjZkFPaHpoZWNGd2xLUS9yV3NoQW5yQndiNmFvTE43?=
 =?utf-8?B?SmpUcDJuV1NvTXB6a1VOVGlkM0VnV29EcjNpNFZ3WFZKd3dCWnNZT0VWcDlp?=
 =?utf-8?B?SWwwQ0hmYlFrRlhTKzl3NUFiNWh1UjRQYW5kN2VYVzJEdS9VOURROGtnZFdo?=
 =?utf-8?B?NlN1amRzRW5IVjhQMGUvd2NyeUJGZ2dRdHF0bDVhRlorS2wyNmR5VXY2QjVx?=
 =?utf-8?B?K3N5QlppMTA0R1A5cFZyUC9OVlZ5eEJCbzBSN2tlelRzaTcweTlSZmU5S0g5?=
 =?utf-8?B?cXNjbDY0cXh6UHlMcWd4TEt1WlV2UGkyVlMvL05aMjdCQk0vU3BOM2dUN0Z4?=
 =?utf-8?B?ZDNaQlJ0b3ltSnZpQjIxQnZTOHJjUDBWdTIveWpIdjhhc1owZVJoL2pSa21z?=
 =?utf-8?B?eTZCSmkyTmNTVFN4dUM1Y3dJajZMazlmSFMxTmU0SWFXaG9IVVBaYVJqRFFX?=
 =?utf-8?B?MWdGTEV1YzdGMXNuSThUU2Z1YmRGeTE0NmJ2YkJxdENuT3YyUGsxVXErQ2lL?=
 =?utf-8?B?L2F4c3BjYmtFMEFXalFjTng2d0o0a1p6WnFKL3pRWnVsNWZ3YWN6alp0elcy?=
 =?utf-8?B?b25NeFN2TDFxNkJkVG5Xd3kveHFlNGdBSE84WlZBS1U4QU5rdVlabXA2VTFa?=
 =?utf-8?B?d2k2TkZ1SHYrejFpc0dnTndMbERQVjNkQytyMnRZTlFmTDJFZTZmMzlwd05x?=
 =?utf-8?B?akxOWnc4dGt1T1Qzd3prZU9WR25Ba2ZwTnpRS01od0ZoTVc4ZDJxSDFwY0VR?=
 =?utf-8?B?RVN6QXc1eGduem1naE9xaHU3cno0VEV6V2hQem13WlhBQ1hzRmJkbkk2NEt2?=
 =?utf-8?B?VVNVQ2s3bWdzaTJHTVF0aU4rT1pDWmxoRzgrVVFFaEt4WXhML3BGS0J3YW1D?=
 =?utf-8?B?anZSMmhxSVl1WFFPNGRTRmdUSmJXRnhVTzJ2eGd6L2RlYklhejJ3THV0Skly?=
 =?utf-8?B?dnVaQnhqU1hBbXRvUnFsYVQ1R3BJNWFhNWlBV29OajY3dmUyUFRPWVBvQnl4?=
 =?utf-8?B?czVoV1B5TXA2S2lnZlFPMDFRaHdzV0FiSE1vci94bTlFdkhKZkN0SmZrZWtx?=
 =?utf-8?B?UGtFUUxuQTVoOEFrYTNnYVlmcGQ2RzBpZngxNlFvV2M3cHlHd1dSUUZSMllG?=
 =?utf-8?B?V2hSb3A1dlZXWlBsMk1ZWW5qZXJyYkRGVktDQ0xTWjErVVNqM0psODFZVy80?=
 =?utf-8?B?TDd4M0pXK0FOVER1d09rSWxCZWg1b0pJT1laSEd6dWRpSXNYVzc5MUU2Sm5Z?=
 =?utf-8?B?QyszSzYvbnVQWWFvUmtBNG5xNVYrclhSdGJoMnA1T01WQ3h1aXh2b1orMXQ3?=
 =?utf-8?B?SzlNZCtEeWFiUktlR0ExZ2pQRGw1MDl2QzRUTm5CYUxpbWhMTWw3MjNLTDc4?=
 =?utf-8?B?eUxuTEcvME00b1luNWVEUzZiaExCSW90UEIvZ1prekFZeUc3Zk1sa2dWK1Jp?=
 =?utf-8?B?MTVnMC83WVh6cktOdmh4UGlHQmdxOW1IbmhrMDNpQTlna3hINWIrWWV5aCtj?=
 =?utf-8?B?ZzJacDBhYU5HSGtZV2QyK25nTkRjaE0rRlk1ZC9PcjE1dkNhdUVGa3RINGho?=
 =?utf-8?B?Zkh2YytuQmRjbmdyNzYzYjR6LzFxMS9DYWNHNk54L2hzMkJocDJjcFZESnNn?=
 =?utf-8?B?dFM1SENvRnMwamtXWk5GTU9Za0JpeDFtVzlPK3JHd0hESHhLZkpOa3prZVhs?=
 =?utf-8?B?SDBuY3d0STFSTis1akFYSWlMRE0yVG9BandtRzB1ZUVqUWZsUEU2OFhIS2xk?=
 =?utf-8?B?enVncjl3UFA1TDdwUmpNVTZzRWtMUEt2aHA2Uks4Sm1ZN2ZiU3o2VE9JTTJP?=
 =?utf-8?B?a0J0RXU2M054M2hKYW1BczUydXAveGtHM3N0NkJjcGJmUkRBSzZoeFhmMURl?=
 =?utf-8?B?eS9GZmQ4bGVPdmRnSngvN2tibFFqNFowUWNOWGxSa2NmODZOSkF6eStuVEFL?=
 =?utf-8?B?Qi93VjdhV3Vxd0wwNHB1M043dDFrM0RQZWZHb3JRbmpTcFBkMmVaWUJ6TG9v?=
 =?utf-8?B?K01kdEVNZmpqdU9rTXVTejd5NHBJUHZQeDVJNE9jT01LV25Lamg2Zz09?=
X-Exchange-RoutingPolicyChecked:
	LwZNfvPZ9jpZc8jqaBOQ42oGlUdyqlbZ80PKlsYsLByqwrnQsqMy0Har8ISfU515ATjAHTjMMJKh9byIv/29dlbWno0TYqPgGa67roOKgy2ffsjEd/OXm004dYZWHFU1vCsuOBXXx5UnqtXM/FXr5p8y34A4zaTGTfqbOK8OmoSqsz//16IiA9bDwSYw3YijsNy553FDWjQZvBhkwsTdFNn25nPo1FSzFQ7L0k8cQ5MEkJHvtzKw38qp3NJ+hHi62thbh8MRSfCjzNxUatkaZLh5mbtlcW914Olq+9tj+kNouONwdjWI4ULHJE8X99Inx1oP72/uaC63AqhoZrTOIA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iOkE16BtK1AuCSaiB0dkSBHAYbgqyt8jXSC6RLuLd8+zKLJy1G9FEiOWlWDIe5cv6nHH7bPjSznR8fsY4yGy2F+3Ks8pZQ0xephPQq/3Dz3INFM9ZUiU0/IKE4CJe229JIKFEk0OoVOqnKJOiG/U+woYSvNLEUxN9h+rzd8JiNy+UDB7MvcCKbnplDzLIvImP+HNBrcAK+AuUOXGP5bHYL7ZP18rGhn5O5j6OECSfaTJg9vOMscKP3maQLIpYqZfQFM9urpC17BLST1S3isIa72ljYReJXhF/iPuqDz5RzNRj6G9looMrMUgYymdqzZhmGAmK65LA7/3SSyVU5URpwjkdxlpNKyRmvMMJBGbDSOv+stukTvewDjprmV6Ujrb8d2ysSLiUObjGuAsTqxyt0JU5TVCyyQp0tBQCj0rGb67OcyW/Pz158ueUTDpGfpPtGntUTdnYDZJXVC2V8wpGURk7XkGX7wnzXrD+XqRPrNDYh0uErz128UkGSN5dcqZV0creR0Y4JA6JGmG95iX9xbRLVTEp4O1Dpt6NKIa/Bzs67qojczMwW6Nc5LhL5cylKFOtkB83QysUMmat7XQ/Ep/mDfMrxcsIs4RurDWYKruKGTU2C1kpKWhtAVZcL8S
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d399d1-1847-49dd-906b-08ded5b3e225
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:56:10.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOOhTIpOgQWrrQ7/9wUMdgkqFdzSz9xI0gr6lPufam70fp/+Ht4Hauc4W4v58u/CtN8nNdZ9Jc7oT4NdPUStWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0961
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
X-OrganizationHeadersPreserved: AM8P192MB0961.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX0UNp/qhajWy9
 AxJDZzq2UO/GiYtvbTYySaTuZOzbG7FEkOZsqzvJQ4E5xfRylztwjKjINkq/Y0wptO6p72kueb0
 bBAdkxSW93SxnfXui8wob5l6qFbDLw3OXPgHrMZ1Po9lrvC5kUmDMQu5qiLFK/mIa9jq9h4teZz
 hgu+pjVILYh4gWPBgfS9ELEBroNPrPloljInHG4f2qKE8S3fqyu77t05E9KXjbEb90tNe6ctEsx
 BxGkKix9Iz9Fz/r7Lo5IaoW2S/LoZWrXAv9uOJSHIseMdDuwI2KKzp8iBzCIpTKALXWhApiEZ0J
 C+8ByyUBX+NPKylYrEi4HJKUJVPDwcDPPLz9s0p7oPm8IpHCPW7S+WYAvJOkJ5o2PtqwxXsucTT
 wQX5m8kjFeHLjNqJO/OXJWcBr7vK4zcXEox4XquBXQa6pmusiIFt3d00ELNx+QIqolccyNBt0/n
 sJ7VptxRDOowPv2/AiQ==
X-Proofpoint-ORIG-GUID: w5KKxxzsQQdgpn1qOzhps5gF4cfEtwbJ
X-Proofpoint-GUID: w5KKxxzsQQdgpn1qOzhps5gF4cfEtwbJ
X-Authority-Analysis: v=2.4 cv=ZNznX37b c=1 sm=1 tr=0 ts=6a42251b cx=c_pps
 a=lYNdoJWGmYD59PotNB9brg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=6etL3lIvvOaedaUTNCsA:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX6lF5tjQstxrL
 UjLIKvHZFGvlXpLMcqwgrBSIOW/Gk6a8F7t13C5BslaHfw0r3yn4wdLMmgKv+1rJ0ekZI3BsKph
 K/BGsCPIQCvLteROe3y9Ar5gQmA3kWQ=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38266-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:alexander.wilhelm@westermo.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:dkim,westermo.com:email,westermo.com:mid,westermo.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BC146D75BA

SPT pages store descriptor addresses in their vaddr field as little endian
64 bit values. Treating these entries as native pointers produces invalid
addresses on big endian systems.

Convert vaddr to __le64 and update all access paths. Write descriptor
addresses as endian annotated 64 bit values and load them by converting
back to native pointers. Return __le64* instead of void* from the SPT
lookup and translate the stored value in the descriptor getters.

This ensures correct and consistent handling of descriptor addresses on big
endian systems, while little endian systems remain unaffected.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 26 ++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/dp.h |  2 +-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1c82d927d27b..2076ae65e9e7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1149,8 +1149,8 @@ static u32 ath12k_dp_cc_cookie_gen(u16 ppt_idx, u16 spt_idx)
 	return (u32)ppt_idx << ATH12K_CC_PPT_SHIFT | spt_idx;
 }
 
-static void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
-					    u16 ppt_idx, u16 spt_idx)
+static __le64 *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
+					      u16 ppt_idx, u16 spt_idx)
 {
 	return dp->spt_info[ppt_idx].vaddr + spt_idx;
 }
@@ -1158,8 +1158,9 @@ static void *ath12k_dp_cc_get_desc_addr_ptr(struct ath12k_dp *dp,
 struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 						  u32 cookie)
 {
-	struct ath12k_rx_desc_info **desc_addr_ptr;
 	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
+	__le64 *desc_addr_ptr;
+	uintptr_t desc_addr;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
@@ -1174,16 +1175,18 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 
 	ppt_idx = ppt_idx - dp->rx_ppt_base;
 	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, spt_idx);
+	desc_addr = (uintptr_t)le64_to_cpu(*desc_addr_ptr);
 
-	return *desc_addr_ptr;
+	return (struct ath12k_rx_desc_info *)desc_addr;
 }
 EXPORT_SYMBOL(ath12k_dp_get_rx_desc);
 
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 						  u32 cookie)
 {
-	struct ath12k_tx_desc_info **desc_addr_ptr;
 	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
+	__le64 *desc_addr_ptr;
+	uintptr_t desc_addr;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
@@ -1198,19 +1201,22 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 		return NULL;
 
 	desc_addr_ptr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, spt_idx);
+	desc_addr = (uintptr_t)le64_to_cpu(*desc_addr_ptr);
 
-	return *desc_addr_ptr;
+	return (struct ath12k_tx_desc_info *)desc_addr;
 }
 EXPORT_SYMBOL(ath12k_dp_get_tx_desc);
 
 static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	struct ath12k_rx_desc_info *rx_descs, **rx_desc_addr;
-	struct ath12k_tx_desc_info *tx_descs, **tx_desc_addr;
+	struct ath12k_rx_desc_info *rx_descs;
+	struct ath12k_tx_desc_info *tx_descs;
 	u32 num_rx_spt_pages = ATH12K_NUM_RX_SPT_PAGES(ab);
 	u32 i, j, pool_id, tx_spt_page;
 	u32 ppt_idx, cookie_ppt_idx;
+	__le64 *rx_desc_addr;
+	__le64 *tx_desc_addr;
 
 	spin_lock_bh(&dp->rx_desc_lock);
 
@@ -1246,7 +1252,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 
 			/* Update descriptor VA in SPT */
 			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
-			*rx_desc_addr = &rx_descs[j];
+			*rx_desc_addr = cpu_to_le64((u64)(uintptr_t)&rx_descs[j]);
 		}
 	}
 
@@ -1286,7 +1292,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 				/* Update descriptor VA in SPT */
 				tx_desc_addr =
 					ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
-				*tx_desc_addr = &tx_descs[j];
+				*tx_desc_addr = cpu_to_le64((u64)(uintptr_t)&tx_descs[j]);
 			}
 		}
 		spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..0d7fc2aea241 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -357,7 +357,7 @@ struct ath12k_tx_desc_params {
 
 struct ath12k_spt_info {
 	dma_addr_t paddr;
-	u64 *vaddr;
+	__le64 *vaddr;
 };
 
 struct ath12k_reo_queue_ref {

---
base-commit: 988707e4b5a73aa78f2fa260727c36fe725fa816
change-id: 20260325-fix-rx-tx-description-virtual-address-91f511690671

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


