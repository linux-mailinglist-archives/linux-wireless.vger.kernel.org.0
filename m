Return-Path: <linux-wireless+bounces-38568-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TBOhHB5nR2oOXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38568-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:39:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E196FFA15
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:39:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=BOdNjAU9;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=FGvvVG6n;
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38568-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38568-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EF5C303F49A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DE369D6E;
	Fri,  3 Jul 2026 07:36:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE9369999;
	Fri,  3 Jul 2026 07:36:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064164; cv=fail; b=L1xK6N/sKihDunVl1P7oaXLHuwQ/PN+/pBoXRpJ86T9MeODi0x/mQ5K3hOqZdJ7D0Gis1++/wUiVLMo80rejTmSSno4Xm5oz02Z9yDQLjIFXwyOJrnXnmDlprkicUsT5X5olJPlXpadYtRVrKhElIKmgk+io3G7lURIFF8Vf+9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064164; c=relaxed/simple;
	bh=t8jIcpJLPug/ufna8tAtlhKVB3GYuROPxuJI14p+HgU=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=dTg3fT0Os0egotOQXTwV7VvLKcvIa+OByhYw9ZxBB77aYCJVzCo6qqblbjMT0IOHIx0F/aaHztFvLjkC5sxeEFW1XhVr4XVysLYXuL3itfDjXRGob09mBkwGFtjEwWiA+QY6qgIq+HUqtFrOy0T+hepn/tAOHGZZr4UaXPKH/FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=BOdNjAU9; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=FGvvVG6n; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635sC372698465;
	Fri, 3 Jul 2026 09:35:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=gDOR9eKf+jbmDM5kESmRbD
	z5rMllmJPY3Fo+G/ZPnqs=; b=BOdNjAU9EEJnmyLQWYOUPYGd41d1Km0A16fga/
	d4uMFLkGhHCtJtwjNrnLi3jNgC5vKHe2toiAgEAbzfqOra2bMbmI2bQaKgy/jIwv
	+uc9409vLQLubpRot5NsJi6XTyXb/isb0z9W3P8PKiS0ZrN5Jq+EHIuL4O/Ks50M
	H9aK59P8n86wCHLNGheE2vrEZPGAcEymq3EcN0bPyNmdg07RoBJVDcurPgmXVQUx
	upF0S/dDZ4L1m5UgOdw7FKa83E995AMCr9MUrGziltE4HRoLPg+JxmswGfRR9Nvy
	1oSKOPs0DFRVPaM+kkWNg6GDVX7yJv7d1eoAImluaUapafgA==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023095.outbound.protection.outlook.com [52.101.83.95])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f5sdmgykw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:35:51 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPVsuCQxQ2dW3JryM3wHm+uqFFeHz7V18brWHxUgbQ5Gug9bvtXsEatI4q/Hwl3HLRhzzHWdOxNaHokFP+h//5xUEhwwJu9wpjmOMgPv/odjkgD4WGGXS7vfpib00zcYWOU+7vmMMpo9VUbicLWsi7JNkrZhzpoNxz3urlNl10j4HPoTY/zPvSK6prh+sbXGxKxATaRDEuAaUCa/Llv6GX+xn+iH0c3cOzrZMgWFK7Zhchqdy3y0OgAZjOnqucL7fm0eNG4idxpxb31i0MZwZEozr+xt9IoV8sh8ayCVKgKQI7dEpsxYHSq3Tp7/gpDDoicKReqeebb1VaSeS13cjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDOR9eKf+jbmDM5kESmRbDz5rMllmJPY3Fo+G/ZPnqs=;
 b=Zng7KfCn6Gue0bxupLJwVL7JG1fLk47Tk1pUeBmqOK7U5HOGzKO3xqYhRXyTp1FsEW+m+EZ3uEJjV1Pw88y8xQ/3mn3BSNv/sGO8/Tt27T0DAm7gaYgIOTPzf+6vCG6pY+59zY7eKZ3ylGYTOcEdN31ywjEW19oNPYp8LDsK8BKbZCXLIIMweLq1YV7iq2zro8IwfmHcbwp3KHMaO/Rsrlb9GU1F0FIwZF6V32AcxkZDuOvqz0hSNox8cRgGySUybcDN72I+oR6zxRJTK1eQgTOxJv3p+TfCzZxTMsgxiUxAK+kC9w6Pfs8wG5pMXcksfxyCXlWxGFYTY3aTPQeY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDOR9eKf+jbmDM5kESmRbDz5rMllmJPY3Fo+G/ZPnqs=;
 b=FGvvVG6nQjR78nPc69yp52XjelqZXd4QWtkUOrY/fwdBL3kjT1wa0qpK09ucL2XZpyVXkDKNdirYG8EgvL9WH6yiwYoRGoG9nhGgzYLCkutwGg+6Dn5cTiUUlnbVWN6aA4ERPwWYMMjNFj4/0tcSly+3A3zixlNZwmzZgIK8F8Q=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by VI6PPF3F74B22B3.EURP192.PROD.OUTLOOK.COM (2603:10a6:808:1::20d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 07:35:48 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:35:48 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Fri, 03 Jul 2026 09:35:38 +0200
Subject: [PATCH v2] wifi: ath12k: fix scan command endianness on big endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-fix-channel-list-copy-v2-1-372c39306d79@westermo.com>
X-B4-Tracking: v=1; b=H4sIAElmR2oC/4WNQQ6CMBBFr0K6dgyttCgr72FYlOkgTYCSllQJ4
 e4Wdm50+Wb+f39lgbylwKpsZZ6iDdaNCcQpY9jp8UlgTWImcqHyCy+htW/YPyP10NswA7ppAaR
 WojaiaBvFUnfylIKH91En7lLS+eWYiXy//jNGDhwkcZKaOEoj7y8KM/nBndEN+8YhUOL2U6Cbq
 1BYKFPit6Detu0D0Zinxv4AAAA=
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3PEPF000167FC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::679) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|VI6PPF3F74B22B3:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d9d470-4334-4c17-1e79-08ded8d5b332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	2xmK3KwS5LTm0KGSTqii6yg/0qyfeY0mw/+UDBOCx7o/7lfG+m5l4NzLZa9Nk4KTWTOR8EdnbS5ng/NvnObjCt1asUtdiE+Biey9/Yl+7atneeAVr6iMavSfNDOTFhaJfDqrZMBCiIE6Cmc4RK5yIdKB3t9JT/ojgWa5jbUwpg/A8CYMdvzU1SKcVOsjzYtp/QBxxhQLx7uSQr6/EotgapoO8LMUvUzirWLnuob21EkVe38sOzetJUswIr/WmsL81MvhN1nq0jO/tRnTz3VaGMmkLzC9DwCoX80RkJCB/6M6B6fxWrn+p3QFqTgg3NKjZqNlo8xn7UszTn+oxHWcwQUgoUlQ9NwOtq3IJUbPzadci8qAOMpvdHgfrClVf2xhpcNaSro1HpNZelyPJJuAedPORCAiywt1BCtX0CbPLp4NSRbW6C/cpVblzWUjwdjiZmMpMYtVD7BBo5CASrY9pNqvNkfPNZLrkX3e5gMjkstv9R65pzYdkCBfi991MAC2cTLdoAM68KsJtAQorzncK0tWYz2R/NIvcCYAvUJ6K0G+q5xfO4k59oOUsUlDsoO2erVlUv4XQ7hYVM1fuDLbL7o78EvTta9f1MQ26OeGpWeJBoazHGZlHPhZ3V5uGf4RCx21M8g+dDQBpBieB+hxizV5tGtU7tdSqDSF03ftZ/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2RHUXVDaS9jU3EzMnRxUTNqV01peE54YmlBMUlORXZ3Vmd1Zk1SbUs2TjVn?=
 =?utf-8?B?ejdtMFhKUVdIZHJUYkVMWHdQUjQ0V0Jnb3FycXRYSXl6QUlaQzUxTHFlVWVP?=
 =?utf-8?B?S2VsbkF4K08xSGJGdy9mMlQrVXpZZGNIaFFoWW91NXhyRlFudWNPeWl6NzdH?=
 =?utf-8?B?Yy9KUHp3MmFaT3FhVHBKMTBFcEhBR3ZzaSt0bnVNTUoxMUxPRnE2a3d4WWs2?=
 =?utf-8?B?Q29uT0s5TGt3VWxqUG9GNjhTd2xyaU44WjlWQTcvRWhpdTNQTExySUQ0cVNJ?=
 =?utf-8?B?RXlaY3lsV2dNK1ErZlJGTCtkS1JBT2JsTjZRczhzOGw0UHRJc1NTNWs2NTc3?=
 =?utf-8?B?blNmZnNDK2ppSy8wQk56WlY0V0FTM2huMEcxaEgyRnpYemQzSFc3Q2hQNUxX?=
 =?utf-8?B?R0FwekRGcXpIMVFnL3M5V2YxTjJPb3J1QkhOb1loUWFzL0lOTm5JMG5zQlhP?=
 =?utf-8?B?RVZES2Y3VVVGcTE0WmdjQXJhUElxYUhEVlVrZE5pVUkwYnhZYjhmQy9sTExX?=
 =?utf-8?B?azdOck9qZGJFNDhxS2Rhb3JIRGRjQWFrb3QzZ0tWbG1odjVQMkFsYU9TaE1I?=
 =?utf-8?B?azd4M01yRnROTHZLeVZLZFppcVlmUDNDVGFKUzU1SmphSU9MMkcvdDIvOUdU?=
 =?utf-8?B?T0c5M3hIdHZ3ZUltZjhXVTNCc1JMUUU0ZVVmTVNxT2g0OElYTDZEWTFUaHdG?=
 =?utf-8?B?SFpQTm5vNE1NcFBzd0tzK1N0M0JSU2NOVVdlVjU2MDhJYUQzRDNxUHBHaXZ6?=
 =?utf-8?B?NVd5TWVSU1VSOTJNOXNrQ0YzYlFwUDRwcElGcFBPSGJLN1JVWkJHQXJBcWFx?=
 =?utf-8?B?d0NWMzF5bW9vS0Q5SUVNSlRqWGpSVFFsVWZldDNlMDRHZVhxY2VCTzc4b3VG?=
 =?utf-8?B?ZEx0KzE3L3prZnVvZkVaTzhiY1lRcTMzUWZCR2dMYU9yYk5FY1E4WTI5OG1z?=
 =?utf-8?B?M3FVdkNPblZBVzJ3VGYrdTNwVnc2N2RIdTd5bDlMa3lVRzFHUjhSYmxoSVNP?=
 =?utf-8?B?Q2RaWk4xRjlneXlCSnlwUFhNcXdCQVFEbS9TRWJWUjdXK0J4SlZuWUdmcGZ4?=
 =?utf-8?B?bGZCcS9Rdnp0ZnhnL1c5enFFSFh1RTkwNUNFSExWZnBTVVZEVGM2NnYvR1R6?=
 =?utf-8?B?THorYkhLcHlPUzZuZUNaekgyaFdHZXFONlF4dy9OZlJ2SW5xbjZkTjFwM0hH?=
 =?utf-8?B?VklLRGxLVENsVUhXZWdwR1ptME1tVkVEbVNXWHpGVlF6MlU0RmJObjlKVGp3?=
 =?utf-8?B?S3E3c3NIemI3WnBoSG8vT0xSMXlyRUFqVFNaTXZWSFFKWW1qbzBWZkI1NkFa?=
 =?utf-8?B?YWNLRHE3K3ZVNXlBZlUvWS81dCtCZnpKUEZyaE9DOW15SkxOOFFtK3lESFhW?=
 =?utf-8?B?Y1M3SkNIb21aRUgxWUZoMFNySXpQY1ZReWFYWmx2enFFSWZURzZFdzkxNmc3?=
 =?utf-8?B?a3RueVVGZnA2TXpuVGN2RWpQWXBNTUhKbjUyNWlvSFkvL1VwaXpTQTdncVJh?=
 =?utf-8?B?eENOTW13QjhGcHRKOStlZ3RKZXZrUkdZK0owTGt5KzNKNWFrSFRnblorR1Qw?=
 =?utf-8?B?OWtTZ0pZUU4zYm9PREJ2eXpBclp2TVBsUWpqdy9wT3Z3dGNERHNnc3pCNmFD?=
 =?utf-8?B?alh3NUp3cEhWMk52UXJUZXFBMStlZHJxU05zZHpuY0VIZ1RnT3pOSzNvNEVP?=
 =?utf-8?B?SXI5SmlWWWw4Zk1FbXhkTGg3d2lJdnFsVUNkM1BLVGROcXU4NnViUnB0ZURX?=
 =?utf-8?B?UE9vU1cxUWxZM3R4QUhDalB4UDJBQks5ajhYLzQrYlMrZGhLVVZtdEdvQnE5?=
 =?utf-8?B?NkI5Rm5UeUVCRktyTzgrVkhJTlM2UWQvQjRsODZvUkErL2JFVzU3MmVDU09p?=
 =?utf-8?B?dmpkMTFQOHlGUm1rWDh3WmFIUmFNMllHVVB4UWFmMytNYm42MW9yNi9hdXlZ?=
 =?utf-8?B?YmprS2FFS05kV255TU9FOXdEcnpxbHRhYWI3YjdPNmNtOVk4ZXBVazNsMnZF?=
 =?utf-8?B?SjAzZmhJa25OeWt4cUgwWHEzcDhRT0dKMzUyMk14cmpIcjRpNWpSbVlDQ25W?=
 =?utf-8?B?ajB0R3JXODJpREpCQzNmM3ZWRG1taWtlVVEzeDUza3d1amhmZ3haSTAwa1Va?=
 =?utf-8?B?dE1oaktORnNoWFFsRWZPVG95T1NPOUhHdXgvSStuZHd3dnhBaHpGS2NiWHVS?=
 =?utf-8?B?RzF3NlFDQjRqYkdiZGJuRzdobWVra1BSa1dsS2RVcENmRkZQU3FMV2I4ZVZh?=
 =?utf-8?B?VjQ2L0lvVUx5bURvTFpTL0ovUERzcXBrSlhjSmx3ajdTY1pwTi8wamFPVXpP?=
 =?utf-8?B?LzIwbmRHSHZUbmloRHI3UkpSVFhHYmQ0eUFoT0lLV00wRk5xa1dqQT09?=
X-Exchange-RoutingPolicyChecked:
	JyY+Z1fd2fm2G/xmoJCpeQ06EU07vRVNUWKnUYu3q1EZ6iZGEh/vKZO4Y4C7PKqTmGftAfki5Y7PkrodQxeKd/YfsECJlt+tw6h2rzzBGeYnEAaeKnI05G1KO3DqDEjfviuocXoygqSyXTG1SdXCJ0YsUAb15RviaPtRW5QYUvRXwf9xF1bIhb+FkhMSiDUrr8LSDYYOkriYOyMyzfQpQC2enu5rcwlbhK7XpkED29hxBHiVvCgCt+nXe6LS7i1vGhIPHZmOvy2B+WKLB8T1/AKYO07Z7d1e4Xok7ooI7IxaAOpJyEgsn8ssKoaifz6+R4693QWT604RiQWyv9wOxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9bOrHc6tDXe6y3a2UlB+jAXfTNb0uYoJM63+l+1DkToJbcvjXGkNpThhtG/TKg/uTznpgHKZGFudYmlRkmEBrWxevPqfYjSxucmIe0z5UnjTq8z+9tc21Z0Xp3xY0XZLubTSR4OGJlN6gyOF/WYj36re9VqSt+hxPV45U291BNgj1O2Wp6J18dN6sn+4lATsYSvheipKHvFOXoPfW0hm8HO/ONLP/8/CneVQ9wzJf44ZzJgttSfFH/wia5kJL/W0T8ejFawIjHxpBjqltEvee/4Mr6xgAkixks+QrRhOd0pm9+hw6brVqp12YzzGWRc7KHdSXtBWp4Dcz1sI2l8e7kdpLwh+jG66EfiAZJdfGqO2Ch0KFF1whALPWXUXLzdFM9di/9JiyTXKWqhsZ2RSoG9cxOyqETfZ7d0h33CgdezQ8UisepJOmX5yksfeKfKTZZ/xUoTS7G7kgxkNBnRzTBZFPTt2+XWLknDy7mmXRWzUiSjro+LMGvxTUxjFQKdlZxadlyHa06tjILZh3dpo3R5jpfnzhfrhQKfclvcW077W+EPSAlaQYmx3sM7f5hNZcOENbhY43ucJfgSE6bn2pwCws15tqFqtaOTYwrE4n2YqonBQgFGwfmirrZLI/BvI
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d9d470-4334-4c17-1e79-08ded8d5b332
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:35:48.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ro6EQGITcIpRrn/v1n9RV6ay9uvbff6nxlrveyVxWUfJZ5DRt864BbNgcW5hd3+5E3KoHDxkaU5QEsnZV74vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF3F74B22B3
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
X-OrganizationHeadersPreserved: VI6PPF3F74B22B3.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MCBTYWx0ZWRfXwymJoOsE5OMv
 n0gBl5KDdd/yNTSqLCEEq3YN2kZr71JDV7zj2z1F3HOjbcCPYuoDglLWDghvtHj80r33wfSVQy3
 zTFaMmc0g5JBDvlBJkOWzTeXhZMkEKsV8oEYM9TaVbt8twJFK2djbUrX0L1vFdzrwAG002HfjZD
 gqWGeAmxvi2GdclHhSxDj3pKdlEhZNg9UO0NJKVFly/IuLdYTc57FxD6dGUirOt5u10V1oqDGpH
 j4LAmjlmCE+Nb8tRACMHL2JZOeR44UyyKUphh6a+L6IJ+8w2p7bNj4iQexqEL1u0O6PsZiILcrb
 YjpLp90csM3VTS80iuq2RlbXHrhi/0r+0gq0JOZd6lH6tF7tMUdMcXGlKfUooddtby12RFB4rJL
 5dKakGR/d+HypuuwHiW2lLIyZPcz22bI537VRWI9DyowuwxiJLCtqENRtcAggYN0n8TCmVpxPsZ
 nAWnMaVj0APICuDgumw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MCBTYWx0ZWRfXy0HIj8qDCWde
 hPuQF6BC2rnOOUTVKoVlF7Ucy0mn8jAcIfEUF5Ekyi2voNTl+K3Ol81rC0ph93XjLcEZIwH9/VJ
 0s9t6LrgC8vP03ftF31oXjiNX/NPYyM=
X-Authority-Analysis: v=2.4 cv=Ksl9H2WN c=1 sm=1 tr=0 ts=6a476657 cx=c_pps
 a=0tufTOWx4Ht2FHFjGAyoIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8 a=QLqChi36ONLLHGj4kj0A:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: ZROmbPHLK4nbsFnFvOErMJw4Qt6FH2X2
X-Proofpoint-GUID: ZROmbPHLK4nbsFnFvOErMJw4Qt6FH2X2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38568-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:from_mime,westermo.com:email,westermo.com:mid,westermo.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06E196FFA15

ath12k_wmi_scan_req_arg stores scan parameters in CPU-native byte order,
while ath12k_wmi_send_scan_start_cmd() writes them into a WMI command
buffer whose contents must be in little-endian format. The existing code
copies the channel list and writes s_ssid and hint_bssid related values to
the command buffer without endian conversion. As a result, scan requests
contain invalid parameters on big-endian systems and fail.

Convert the channel list as well as the s_ssid and hint_bssid related
values to little-endian before writing them to the WMI command buffer. This
preserves the existing behaviour on little-endian systems while fixing scan
requests on big-endian architectures.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
Changes in v2:
- Rebase on latest ath/master
- Use additional __le32 conversion for s_ssid and hint_bssid related values
- Reword commit message and description
- Link to v1: https://lore.kernel.org/r/20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com
---
 drivers/net/wireless/ath/ath12k/wmi.c | 20 ++++++++++++--------
 drivers/net/wireless/ath/ath12k/wmi.h | 10 ++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ad739bffcf88..4dab6eee80a1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2637,9 +2637,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	struct wmi_tlv *tlv;
 	void *ptr;
 	int i, ret, len;
-	u32 *tmp_ptr, extraie_len_with_pad = 0;
-	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
-	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
+	__le32 *tmp_ptr;
+	u32 extraie_len_with_pad = 0;
+	struct ath12k_wmi_hint_short_ssid_params *s_ssid = NULL;
+	struct ath12k_wmi_hint_bssid_params *hint_bssid = NULL;
 
 	len = sizeof(*cmd);
 
@@ -2722,9 +2723,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	tlv = ptr;
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
 	ptr += TLV_HDR_SIZE;
-	tmp_ptr = (u32 *)ptr;
+	tmp_ptr = (__le32 *)ptr;
 
-	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
+	for (i = 0; i < arg->num_chan; i++)
+		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
 
 	ptr += len;
 
@@ -2780,8 +2782,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 		ptr += TLV_HDR_SIZE;
 		s_ssid = ptr;
 		for (i = 0; i < arg->num_hint_s_ssid; ++i) {
-			s_ssid->freq_flags = arg->hint_s_ssid[i].freq_flags;
-			s_ssid->short_ssid = arg->hint_s_ssid[i].short_ssid;
+			s_ssid->freq_flags =
+				cpu_to_le32(arg->hint_s_ssid[i].freq_flags);
+			s_ssid->short_ssid =
+				cpu_to_le32(arg->hint_s_ssid[i].short_ssid);
 			s_ssid++;
 		}
 		ptr += len;
@@ -2795,7 +2799,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 		hint_bssid = ptr;
 		for (i = 0; i < arg->num_hint_bssid; ++i) {
 			hint_bssid->freq_flags =
-				arg->hint_bssid[i].freq_flags;
+				cpu_to_le32(arg->hint_bssid[i].freq_flags);
 			ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
 					&hint_bssid->bssid.addr[0]);
 			hint_bssid++;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 51f3426e1fcd..52e6068d9a64 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3556,6 +3556,16 @@ struct ath12k_wmi_hint_bssid_arg {
 	struct ath12k_wmi_mac_addr_params bssid;
 };
 
+struct ath12k_wmi_hint_short_ssid_params {
+	__le32 freq_flags;
+	__le32 short_ssid;
+};
+
+struct ath12k_wmi_hint_bssid_params {
+	__le32 freq_flags;
+	struct ath12k_wmi_mac_addr_params bssid;
+};
+
 struct ath12k_wmi_scan_req_arg {
 	u32 scan_id;
 	u32 scan_req_id;

---
base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
change-id: 20260317-fix-channel-list-copy-cef5cad24fb6

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


