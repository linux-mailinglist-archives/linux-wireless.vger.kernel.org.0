Return-Path: <linux-wireless+bounces-12120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3917962180
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9C5282573
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035815B119;
	Wed, 28 Aug 2024 07:41:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B515AAC1;
	Wed, 28 Aug 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830881; cv=fail; b=fJ8vpXtISzuLEA/Xek3pBv/XiCFmnIa5ymC5Y/etj+ci+FBxErebD/NNCL7LqZrB93v5OQ40jYoxFWyv7WrVJPqUBzxxfl/5uLoSsyGOo3TSOUdGvUv0/xRo9g1b3LHz7I35gzyIuVxDifzRdW08SeBiqMFJD0iMu+w0mpkborw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830881; c=relaxed/simple;
	bh=fFKqfRCCt9hv8l+BGLOj4f9IVlAZh40IH2KQTOj8BBE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MZIb8kO1j9u1Tc3IbmXYY5fH4vJe4o7ewhZsiTCOuZAv7B7czi1L+y+9c2PuGOsSGzDjiHKNZjCVsrEsLDQoKZD5Ar1NL+4zFnQsAZ00MBiasLKnSTC+3yBCDPk5eM/lSzNoJM1+cY96y2geRh+/ny0XA8Mco5I3gU3urOCT3BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQu16Av7Ku6y44XKFa4gd1uyUkjJIVRZbWxZs0KO0j0v34IJiHKgS7oTLtJ6STARRF6O5caGHGj2XmVtSVxFX0J6PiHoqYX1QEEnumUQYRkrnz15h+7QOnmfyJx0ZuEC6nxYBysszpR+mW4jU1ix9zmQ493ZtvraHVXMo+1VUaQBr9QN/xSLy7UJyQZd9VpF67PU5cv+NMr26CiNkyh2bcUFblaQiQOLEhp0Su6s+xMzhqxKggVNNt9ZmCeiLP7sJZR0gKKkVeN15hlwuXv5EPSAjqsMsFnXRy76Pp2FvxxUlaN/i18auxOcgnCsB6YOHm4+vKuYwxzJec8yZDHtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma1tEF9rizPRqq5WfhGPcqyQ59WJdEPBYyfRJkmKx8E=;
 b=B1wZ22+S0ETs/6J4Iw+S2QtjLUeaU+KMtO4g9GGyyAm8BjQrglZrnD9KHQRCB+MPgKiho/+9vAtqE5C6rZk75k3lbkJa09GeTCKdhc+1bG4HgxZFM4SmgJFtdWAc5c3rI4qXvb74ueU9tpX1oeMoqovDUmOFfcjGHkx2NUv0OohoqlgacY3uRoOyqWccy2DA/22Wwz161MRlvf0FNg9HhCk0KnpqdQ4T7DNgn7HQlnRfbblYQlFQ3SIIuEbLrmgPtQsCQpHjgDP0g55+eOOSQ8D05J+FD8eAE92OevEPr6Ss2mj/7tJ5QEqey21JpnTipvG1/kS8idO69WMVC9++Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:41:11 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:41:10 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 0/5] Add AP6276P wireless support
Date: Wed, 28 Aug 2024 15:40:47 +0800
Message-Id: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/UzmYC/x2M3QpAQBQGX0Xn2habhFeRi/35cGot7SmUvLvN5
 UzNPCRIDKGheCjhZOE9Zqh1WZBbTVyg2GdButJN1elOXZwQIKI2wzFwhLLOWdP7tsdsKXdHwsz
 3Px2n9/0A1PUsumQAAAA=
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724830868; l=4070;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=fFKqfRCCt9hv8l+BGLOj4f9IVlAZh40IH2KQTOj8BBE=;
 b=RtaUYiC7725FzYZPerG58//3/wkDadYEKeBdyDbizU39cgseesNspBEsyIcSLVS8dt0SYoAIM
 Or4LTSEnTz8AVO1TGgE3xnRInQL1WbM23BPUB2Qnl5xofClz/Pcu45T
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 17049843-790d-4eeb-c288-08dcc734c93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFlIekJLRWk0NmwweDN4SVNhakZiWGRxMHVjckZyTzVQcWJ2a2Q5bnRWRHpw?=
 =?utf-8?B?T0hKUTF5UUNCbGM4WFBrQkRCVGVtaWwrS1dTUXlzRyt4RzMxRnNHSHRhbjVL?=
 =?utf-8?B?NlB3KytuejAwSjVlMjJhNklvL2tSUzJnV21WQVRGTnF6L0U3alU0YldyTFVp?=
 =?utf-8?B?NmdaRWFqeDJkL1NHcDJyVE05UXpkdy9mSDRkUXE4UjVxWDN1SzlmKzRYWmY2?=
 =?utf-8?B?enJpR1h1UmtJdFltK2JiWUxGSzIwdkhtd21LZDhzeFJrVFhwbkFzTjlFK3lS?=
 =?utf-8?B?Z0ZTUTk0NURBQ0dMdWxFZTk1bkFXMWN3SHJMNjJESStONTNMNVhyaFZDNTBN?=
 =?utf-8?B?QTBLQ3g1WTUxYTZ1ZzBzcmE1U1NnY25JcDBEcnozai9ERkhCNWlXQVlxeGVt?=
 =?utf-8?B?Z3Q3NER5ZC8yb1NDNEVWd0pTMVUwbjhQeEg2cFlpbXZHTjlFaXdYV05zODJ4?=
 =?utf-8?B?cFNtNDhmU0k4Q1cwTUF5R3FYdHVNL05jMDBZM0ZrZlY3WE5JL0ljUEJuOXpw?=
 =?utf-8?B?YmsySjd6QzlaMnNxV3FXSUpCbTJNTVhwdmE4M2VuWElkM2JqYzJkeDBUaVBT?=
 =?utf-8?B?QVZlQUk3d1d5WDU3cnBZRGZVd1VoTkpJenA2dzgrVzV3bTBwM2x1Z3dlYjMz?=
 =?utf-8?B?R2pGQXpBa0puU1VqNDAvKzlkYUVwWGdLcFFkbWlVcm5WM3M4SmphMXQvTmtQ?=
 =?utf-8?B?b3QwSGJJdXlzUitWQWNiZTFhaFp1Q0xHTk5nU0xMTnBMcWd5UDk5QWhrb3ZZ?=
 =?utf-8?B?ektpMXVsMzFzN3IzQnBaNzhKZnVVeWNNUkt5Ky91bFQzNHZBQkFFbkpnNVQw?=
 =?utf-8?B?SmljU3NESnpjWC9Tb3VYa0NlcGRUbjIvV01kMzhER3ljQXRIWFBvd21nc2xU?=
 =?utf-8?B?cmZkZnYzTG9kS2h5ejdSYSt5a2lZVTVtMkN0NTZFNkJyODdjYi91YmtrRktD?=
 =?utf-8?B?bWRFZWVOQ3pLRkRiM2ozdyt2MktFdkhoa0k2RzVTM3dNRk9nZ29QWnNrbmNa?=
 =?utf-8?B?Mmw1RGMxc1FrYm1lbjlEQ0VkaUZZbmQ3QWY4NGhuOWY3SDBlZG0wTUhidTFL?=
 =?utf-8?B?SCtBdVYxRlNMcjdtUGd6UWdUSTU5NHZpSzBranR1L2EraGt6aXhjWGhwYkpG?=
 =?utf-8?B?dEZWRXNuWVdPRU9BOWJ0OVJ6ek4wV3VPV1FtQ2F6ekdHeUpkQXB0MHl5MmR2?=
 =?utf-8?B?NmRlODhoNE9CdFF3UUl2MUhMMVFsTG5JSXhTZTM5Sjdmd1NzNTdlaEVKa3R0?=
 =?utf-8?B?MDg5S2tLR0xsQ3dobjkvc2dzOHJKdmNkNTJQaGdvN3p5UkxXVUQzOGtWaDE2?=
 =?utf-8?B?NU52emZPTHduRWZZbk51cTVzV3E1MVNqNkxSVFJNTTl5bHRwZ3NTS1hiRjlI?=
 =?utf-8?B?Q1RKS0xFQk5KWXFVUnAzMlFmeW9zdEkvNzR2YXZCdHZKdGYvWnlEamZXbG4y?=
 =?utf-8?B?NTFDb2d0SllSU3FvcFRVdFBlLzVWc25VM3pYY0RpcE9FQ004L1E5S3luem9n?=
 =?utf-8?B?T0xaL2pMRTBQc2cxcWJLTThydzJlS3Z1VzhyYmZPQ2VGRUNYc2Jtb1ZOMlVL?=
 =?utf-8?B?aEJtaEpKVHVPTTd0NmNDckMzdWVRSlpoYXZvSjJ5L2NOcUpkNzUwK2dWWnJH?=
 =?utf-8?B?cXNRUWxxWFkyMnkwcFdwTk90YWJ5QVVGRzh1ME5tbzhSN3ZXSFVUenluNTlI?=
 =?utf-8?B?ZmkxTUJWekhIMlBCam5wOHFVL2k1ajZYNFVFZDhISUdac25ua3V0dkhpV1BB?=
 =?utf-8?B?bHdFaUpJVWwwMmJIaFF2YkNRL3BvZjh4VXp4ams1aFpSSjE3T0ZoWllGZGUv?=
 =?utf-8?B?RVZWUk5sQ3gvSTNtdHRlYmRPamlhNFI3ZGxsOHJmVlZIVjFsZEZ6Y0YwSURy?=
 =?utf-8?B?ZUpDK2NtVkdHRnlMMjNwWnlDL3UwcGQrTmR3TUIrSDVvZzFSZlZkb00wdENt?=
 =?utf-8?Q?Oj4fNzxKLSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHRSem83TWdBd0N6V2ZRdVJoRTYvbHI5SDdnWEg0all0SDBpcHQ5SzZtbmVW?=
 =?utf-8?B?UFFPdWluWDA0QXNSakNFS2J0Y1lCQ1ZxcDF1MkVCTkR4bVgyWEs4OFcrRWVy?=
 =?utf-8?B?TmZkNktIYnZMVFZEVVJ1TmVtUG9pWXRyT1lHMzFQRGNaRnlEaDIwbUtoaVVY?=
 =?utf-8?B?d1Q5L1EydFpLaDYwQ01CME1TSXgyd1I0V0xIZnNLOE12YWxyWmw2RkJRcnhG?=
 =?utf-8?B?RWJkaXh1aktTS0ZzUys1RjNhRVZZZ1hFKzFHK0ovdHFiZzE1YmsxckpxY3Rs?=
 =?utf-8?B?OEZFcXZGMzhPUElYUmVLM0k4VDliU1Erd21PMnRMbUU3OWY1YWd6VWYwQ0cr?=
 =?utf-8?B?aDNUblJaNGFyeTFnVWwxQ0ZId3kwR2lSTDNpNmtLQ2lseThmdTdPM3Axc3lW?=
 =?utf-8?B?SzZRbEJudUNmK0JFT3owT0tMZmYyM1MzazlWeDdLMTRMMmlldW82VEV2aVhs?=
 =?utf-8?B?d1k2OThxZHhSeDgyVit1NGxhemVCdGF5UDBMazZlYmp6YUhpQU9ldWtVd0wx?=
 =?utf-8?B?UTZTVjM4YjA5cjExeUhXQ2cxMFBNVzRCYWVOL095YTBtUG5mTGhhVlFQSnFy?=
 =?utf-8?B?L0syVzVSVkp2RnBPK3dUejFHaWx0aG1JSm12WXJmMGJnRjNpNE01cmhSM0Uv?=
 =?utf-8?B?alVvbnRhUFlRK1FsM3pZa0hrZkM3MnVqNC9rNnNNK0RVWEFhTVFqamw5SGRk?=
 =?utf-8?B?cUZ6WU1OWW10NjNCNHZDdWczTUs3eVhnOXJRSjVDQVRJZXA4RDdVb2lmc293?=
 =?utf-8?B?K0xZRjVxbHV5dm1QRFpRbXJBcnRkaGhnYkN1SUNGbmFiM2xoSVNMSmR2MThk?=
 =?utf-8?B?MUxPRUN5dHZaWkVFVyt2djRMc2FBNDRKYmVLNEQ4U3pwck5ZUjlwTzNVZTd6?=
 =?utf-8?B?TkFneS9nR05MWUVPMlBlTGk2L2tjc2pBMUVYd0FkRUtyRHZlUTY2Sjh1a0E5?=
 =?utf-8?B?WXh2WW1mZC9zQWVDK0wxeVZ6aHJib1VrRFljRHBieTJPWi9CbmhvQ1VQZWda?=
 =?utf-8?B?WENVVzNUeTdla051N1dLK3BkaHBxVDM1RkFWVWprd0tzdU94T1EzeTRFd2ln?=
 =?utf-8?B?SGtzZU9vVXZzeWtuNE9wZVIwRVVIT1Y4Qk9vakVWaTJwbDhSUU9pYzREeS9V?=
 =?utf-8?B?ZEIvNWt6Ukx2WTBCRm1pcm92MzBvWEZnanJOa0U2S3daK1lEWEpJMmZTdExh?=
 =?utf-8?B?UmJNVWNlK25VcnhXY3ZpM2RwTnJtQis0NjJtdmx1RTVibTNKZGkvVURXTGdX?=
 =?utf-8?B?SW1oTkIzL3VjRUVpT3JxaWNWL3hkVnBYRFZjaGpMamxTTFVKLytvb2d2SlZi?=
 =?utf-8?B?eTVUQ2tqL3ZNV1VSRDhtd3lvSWhUR2FIK2ExREVXVU1BaU5CVkxjKzBEbWk3?=
 =?utf-8?B?REpRWElWK0NUTHAwY3REUzlreFlJM1NBZUJqeWZyWElBdm5uSDBpMmtzc29E?=
 =?utf-8?B?RXF0SDVYemlyOGRiUVZoRWJMSFZlZHlEamNqUDU1VndoNXl2VFU2ZTlrelVJ?=
 =?utf-8?B?c09GQnZDMmY5RUVmNzhnVG81MExpandwRW1LTm50MjBsMTJnVk1pMFE3OXNt?=
 =?utf-8?B?NitjSDkyZEZUN2puK09JdG9KS2pSck9Fb1lxSDZQaEdvWi91RytrV1ZJU2VY?=
 =?utf-8?B?U0hYaTdobWQvVnc2Q1ovN21tellHSy82eHJLcjF6SzJqTVVyMGYwSlNiMGxH?=
 =?utf-8?B?VHlTU21Bc2lsYzBablJZNTRaVEE2bUFqSi9YSXpyTGxydlIxR3lwcHJvZVV1?=
 =?utf-8?B?blRPNXBTaVF3ZkJmeXRzbzlVMmZVMzRtdEZtb3huMGkwSG9Cb0Rzbll4M2gx?=
 =?utf-8?B?dEQxZTBpaTAvckM5SzZhSnlxVXcvQUR0WmVOWDBoeXdkdHdGK0tTT1hoNnky?=
 =?utf-8?B?TTdNVTNvV2w1L1AxUkJrc1luNHQwd3NtTW9hSy9qOWlZeFlldCtnMUpTUGRp?=
 =?utf-8?B?Yk5ZWmRIemdKMXFZMWEzZC9XMHVjMHJiWHFhRHl1Tkk3ZnJHME8wZldqWFo2?=
 =?utf-8?B?d2p1MXlUMGhMRU1EOEF6YXhDU0dHc0VYM2lOOEVUdFc0WUZxZFgzblVtMGlF?=
 =?utf-8?B?alh6Nk9wU0c1N1pEODNLNHFyVjZWR1IrdnVZbFdQUmdmS09SQUlkRS9xcEsv?=
 =?utf-8?B?U1FlR1VJcER2RGtTV09NMStveDF1T1dWVElHVmpZWjBGYkdncXMrQzZQL0M0?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17049843-790d-4eeb-c288-08dcc734c93a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:41:10.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYYH6yAtyULiUUFhhxNxIVrx8r7VsWYlrVYCl5LHD8weI2ZyHb8WfEaoqkhcP4mMCoZ1e6H6ZL9PkzScAZFilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v12:
 - Add "brcm,bcm4329-fmac" as fallback compatible for PCI ID based devices.

 - Link to v11: https://lore.kernel.org/all/20240816020635.1273911-1-jacobe.zang@wesion.com/

Changes in v11:
 - Retain interrupt check in of.c
 - Split DTS and submit separately 

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

---
Jacobe Zang (5):
      dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
      dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
      dt-bindings: net: wireless: brcm4329-fmac: change properties enum structure
      wifi: brcmfmac: Add optional lpo clock enable support
      wifi: brcmfmac: add flag for random seed during firmware download

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   | 27 +++++++----
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 29 ++++++++----
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++--
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 55 ++++++++++++++++++----
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 20 +++++---
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 ++
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
 9 files changed, 113 insertions(+), 39 deletions(-)
---
base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
change-id: 20240828-wireless-mainline-bccba9d69efb

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>


