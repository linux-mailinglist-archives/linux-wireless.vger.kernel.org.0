Return-Path: <linux-wireless+bounces-25517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC43B06F82
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A41A60856
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B429993E;
	Wed, 16 Jul 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="mqRMGCxJ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="of5hD7Ue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78617298CB2;
	Wed, 16 Jul 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652299; cv=fail; b=RAnyR8s1bxU+Gm5FYvDwy12HK0DT1GOJM6pu1+xwid044U3whZ47OahYPgwomKqS7u5/VmX4tYKHlU7rXpyjxh8/2ZGbmRPW5mKDZ7rPmli0+QgI458prMd85j1nN8MayHjGmykpy/lcp2gr27X4tTa4dM4BDy4ibeJnR3IxABg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652299; c=relaxed/simple;
	bh=dFrXrL7siKpWo1YRHDVF+DLLN0Wg3e2/7mPqkRg74jo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZmjPC5dGHCAoDe7ui0HdfAaCJAEsLVINBv+9fyfC3vV3/H/VesYUVwP7xwb1URZcImmkmY4EbFoUv7FPl9MwKysqATgHnET6mpBY6eyQIsgD77eaMqHjfqLlaHO5/F9xZeVGQi0jXidKrLXweAG0bCGaouRJeOGfBCQHJbVPuBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=mqRMGCxJ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=of5hD7Ue; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6bfO31892067;
	Wed, 16 Jul 2025 09:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=YzaI96ShlJH+PVtvKAz5G4
	0BbTtCyBTwyrhZ7BFwnmM=; b=mqRMGCxJnV+yIqB5Q7CKrDojEz0zNdDE4BHPd6
	dP9Q8ItA55GbEWTQ+qb1wKT121wqE72XEN0q2/U4h/PGJjAqqSFjaYhXcnC3m1/D
	LV3fOi/OgsItJIHCo33wYRjCdTFi6uCDlSR/IDnQoXVl0wcNpi+DooIlDMFskToB
	Nmw8k6YxbRDUvEO+sy4gBV19SqcPxOQOuPoLGfcUvycksydInxdLHehANCptjv7I
	cCohlkcmdF8pMYpTfGVs1rnDRxsKqktQ+14mbVOh25kxRZbYucn81gyLU5eAyxum
	CE1KfeL+ZYiagw8FYwtV95uaJ3Dzj2Y905+uuKkdLY5WizFg==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2099.outbound.protection.outlook.com [40.107.249.99])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47w5js9rdt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:16 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fskp/Wewob1PNsGzqj+8WnAiI7s8mIjR1CFFXsj2pFu35qVjY+IDg3JkYUHobwSIow0LC12dhkItCGhnp9bhswiON7rjeZ2VLFXjpGjbb8yJ98lXZFNm0ZIdtpOu3IhBweFqe0TLmBKBaNZPZnBHUmITe5hmsoLSkiGB9houmy9j8c9UOHLxiirbISSLpyW97mSbBAx0v74W1kxnmDXEohZQ4ipWI6nIC8IP00eh0g1oemaacF5HJ7BD/BaW/Kn8Zorg9DX/QRZnXarYmlt0xX/EKVgEDycxQHNzOFeOrc/c7RAv75NfbuVUNg3gc1setESU0k/V645kHUUAGG2+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzaI96ShlJH+PVtvKAz5G40BbTtCyBTwyrhZ7BFwnmM=;
 b=JvQuHcu+hGQ+vDneiK2yncKcdy32/Sx++v74+0V0aSTEFD1QoprcRj34cYYiejd7e8SHf6iBUib54Yu63BtZsYwDr+pATwCnuU5gE5xp7atjIHWomo6a5n6ShLxkaSThld06FTc3EEso34o+3BJM+oVmMr2DQLQvsg4yzhC3yl5bwUkxaHUX4huvOVEoZv6ZbDvM8UPUVzPVT89EzUOArSBLq2G/TdetGAs18HUwVkn5XXszGovrb2ZDS8i9u5HhNidDk2bi6r15YApLlWnZh4Tdu10TOak+M0HJGhA3mZTgPyBQVUyvfRV7JhkDy0zm46a3Eg2L/HVZBx3sREfCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzaI96ShlJH+PVtvKAz5G40BbTtCyBTwyrhZ7BFwnmM=;
 b=of5hD7UeJqcRH3qbAKfFPSbDwZM8SdxWo7VWx2DUp/HTBrwjnWo5Qmpt2RYrd1ijmIQ99pvzqlWlrDA8+vJUwgXR878cFDhVT4Kk2i2UY4AKFRmOfGAPZUoEZ4JXrz1Sjgu+6iG6cru+pwsk13Dqieh9PNqV5FZgUsAN5qL04Rk=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:07 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:07 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 00/11] wifi: ath12k: Fix endianness handling in QMI
Date: Wed, 16 Jul 2025 09:50:49 +0200
Message-Id: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::31) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: ff861c83-ee70-4a28-7e96-08ddc43d85c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8umVH5B9kKCCwNRYU6mYcybbOCvR/ITPS0xDWXFji2Bka+k7uxch4tUZxE0v?=
 =?us-ascii?Q?ac6g4uAw/2Kjr7d8MuJkG+WjFZRIvK/mKvqC1M3AfjgZBEsjP1yEm+u0ucw2?=
 =?us-ascii?Q?0bQCAGgchLKO6oF4xWCSc8+z6L/hkABMDJebopElyKNe9JXW1XFyHxzm72Od?=
 =?us-ascii?Q?t+Rcv2yL0Am5HEZT+/ZAsiNS/CKejap07jhtFZZS1kMPbIbUZLjZwP0PVguG?=
 =?us-ascii?Q?iAFgcBXLq+rirlGR5vgcBJ/HVlEw+M6o0ivBgnit66uu5YZoc6B3PCMQU7vo?=
 =?us-ascii?Q?JIAeDNok/G7RniPtFTdnAnV8SiBXvxNBoGZEbinNx7Q0BRBM3FyUUgnkl00H?=
 =?us-ascii?Q?KRgWqg5VcHqRYoFf0HVk3cdqggZRLb54s7FclCDGzc7Kem1BNdfqcJryLC3e?=
 =?us-ascii?Q?ifNXJFpIOwUU6/9Fz5tNbiViIwS3hRTt54eNRc6UPH+tQL41hz8U9x90pRd2?=
 =?us-ascii?Q?evLPr2xe7kVXGrx/pEK9amJ+gQfijGTpoTDZirHiPw6PDoySeL1ANAjV2EnI?=
 =?us-ascii?Q?EZTM2QLBLHMfFgO4drKyfzxftLvq+mWjOh+XTsfLHmHjaG18dTpB8JVDm886?=
 =?us-ascii?Q?+HpMQFl8wz+eKjgKjY1+rkU+Fh2rsu1wJG6HrZEyD/P+nvHzAdzaYNQD7eWX?=
 =?us-ascii?Q?VmOE0qceFgOnYVGp/wGwHtQPuZ14BMmGk++/EC7MnROujuQUqm0bHytibian?=
 =?us-ascii?Q?HXVdj83fs6eF8PmbjCkXevfBkGs/1PY79lp06i5fX9QSZahZLmnnihnF1ZYX?=
 =?us-ascii?Q?47j1jWbUYveKq5cNRLjsiX2lRmOr2KHOiJScmHUL5ggYCzbrR5qwJdVlxxwm?=
 =?us-ascii?Q?jfyPgBTN4RuXVgKAP9EoDrshb6RexopAyh9zqq7Zvnnh8lldwCNcO4ZY4csi?=
 =?us-ascii?Q?BWsLi6fOn5I2uorP87w1cqLh2paW6UZt6+v+uGodtU9bE6RILOHS63IGurJv?=
 =?us-ascii?Q?lneu2necxJqk444SRfxMUAqt3UnfkntLMJCjiiZ0l3Ug1wG4ArQac+m4/g5A?=
 =?us-ascii?Q?1DPwVW/VF2VJJ/iZdLwXGNAFC3BaPAdA/0L1+ly3fBuW5RghnVfBp91Q9S8c?=
 =?us-ascii?Q?V+BOCSYxcszVj9P7JSCM2cnMM5dVXV/DR0DnZ+nXgXLoWn3BKTNLtxB7Pdi9?=
 =?us-ascii?Q?yNxVVQSdMi39JRPZLFGIc0FtYQIlIlS+DVhCwP667pffjK79OCaJdkuSCZvu?=
 =?us-ascii?Q?XiQLFPIQOC5l83puTPM0ivn2gPNvQibeJX+H7P754SSg0Z66Wfgm5aiJ9ldA?=
 =?us-ascii?Q?wLv0J/kbErQ/zfb0bBNVEq/+SZZcWdItsnah4Lf6u08XLJsubD+21SWIw2j2?=
 =?us-ascii?Q?e0NEBzPEIkrxqAynufWFhkbYimmqwbMomFqqr7aADeT5K8pzGEEkuIT2AMUM?=
 =?us-ascii?Q?bbbK1a8mEsuIYbSfSymXpKHM/cte+aqLdi0x2Z/KC7cSZbuz1RjRfT5coMrQ?=
 =?us-ascii?Q?oqm5ygz3B3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNUVE+FSBrVF/85QjDpN3/NnwWJxBbq0/C5YwTDnQSfpXSuvJZTAepqV3Bi7?=
 =?us-ascii?Q?Zu4Ku7L5qNe1KnDqY/7yLmOppcn0G3gp+hZecWqV8ezmKAT1I/GNCGtaP1Ao?=
 =?us-ascii?Q?mwke9d4037a2sSES6azHifWzhQnplrVONmWVjRuMPFyD3mIcb9JgMARrUZzS?=
 =?us-ascii?Q?v0elmnR0aeGnTdd2Y+Wwq0l0LjYPihSweXTwR5yX19SOWl/FkTlohmbOyHr5?=
 =?us-ascii?Q?HyF0qWhcoUX2H3X4m7zW+ohCzV3usvZ2mfK9JeSGhhce594C32LFejDE8OzI?=
 =?us-ascii?Q?4u/2E14TFZOs3fo0uCvsIa1eAtm0DVd4dIh+Wc3piQtFt3KKVI66/4WSMPAj?=
 =?us-ascii?Q?iiZoans0TCyHpOZA40xl6/VDqMNn0li1HFE4H9X7rkbocwnIS4ZLCAa2ntm/?=
 =?us-ascii?Q?BljYYf70uTrf8gwOlK0PKqAmD9QcrjMtVViqyhDnA9Ha+hm8xgH4dHTkjalN?=
 =?us-ascii?Q?by/fkGJ1CqNufUFVk21XDjHY48bYprHKMKKlPIlZ8p60r9XKqDK9QHICcgxC?=
 =?us-ascii?Q?UBnlupknNU1umpsMa7+JgWhK+TjZ643jatoa1Ke43mTRcj+zbhaqHOK9ITF2?=
 =?us-ascii?Q?IUsHmahSGDCEstHYjRyqYQl3RD5xTcjmXes5dFXBUVn17U+ulIX9TvMUDdaM?=
 =?us-ascii?Q?mRcE8e1F+TEh3ntyOdHqQgjcCqXeOe56VXKcxZLSGeUGruxqWgGI92c0V/ef?=
 =?us-ascii?Q?B7pyFFe5Qdg7rfqAPWrYD089isGm68t2s472z404oKyBOy3ZRySHfySSm9W8?=
 =?us-ascii?Q?nyOjnPCsjntpXYH8mg4DE1E4UMzgsWcfoX8KSvcUS1a6ZIpyuV+tCTt48x3Z?=
 =?us-ascii?Q?c6NmOduLascpJ1r9PJLr7fnvS1CJRUbCyy8+B99WMq/3FrRfmlkqvKbyi3cf?=
 =?us-ascii?Q?zg+B6smaDeqgW34xr30CzmZQTF8grO2Y8yMTUCXmo0PN8upxn1D8IHoGzHg7?=
 =?us-ascii?Q?o/EVGJviOVibOZo6gNsm5qkShOjtYX+Eu1fumqBZiS9P9SLRJ9MHe71uuo3V?=
 =?us-ascii?Q?BqXt0LCmu0md9FIgEnsIxSozNQHXJNBXRS7V2d4MhIyCl1kjLPcII+td98dF?=
 =?us-ascii?Q?aZHOEqYzUY6ESapTjxdVJjopV8QvBwaIl1DjguAG9E3D+ZojCSh/AjdGmfVN?=
 =?us-ascii?Q?ZwXSIJi7DDVKLUDWoMm/89xzg3E6wbSeu31R5cepNW9IvkZegsnzZSNbtfy5?=
 =?us-ascii?Q?P/+GiJPe1joti9uTm/aUCj6aqsjkVvLTgzZntKp4yqMyDAnKBxM3HZFoesrS?=
 =?us-ascii?Q?CktALvfpqCEa0ffRWUZN2aGIJ9VBAMsPmm3RGGOLYQI3cvxXzTrv/1YIjwvj?=
 =?us-ascii?Q?KaAh0sQzoE2Vtguj8cl22VJvPVZ098Bu1RolytzxG+C2JZbvKEAVsGXSjLXz?=
 =?us-ascii?Q?xYyZ/Txnw5uHvTzmt9tDQTzYUXtnAY6aJLLluiAaLgB/VqBWtuv5aallniSn?=
 =?us-ascii?Q?MswR2+9diXaD+pJMdrMLtPWOruG5wPHWw8FRmE5Jp1EQ66WyJYpVf/0GEuGB?=
 =?us-ascii?Q?cgO/VriheG7/QwHLWu5IsjX1+qZHGwPaCh6W3teUYlXC9mQPvGu/+XRAedae?=
 =?us-ascii?Q?Nr6RY9efSWnycr6icBqv0oP+3eMIiVMw05/+uFZ4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KKrzmitCP5SNTgyyQC3iB84BmE2b8K/L+TC4cdYKhM1k7y6lBGr6c5m0eoxOCIg3h5V9mRdZOkIYN5CahQdOa16sRjn6HvCuTAtcaRtOvxOKGw1qALdMf6+h/vF6xFeMnykTo5J10ycjThVIY0W+Tx+W6TlKKdJwklQ7UGIbP5tGCiMyXJZeBHtVt/ROswoEjxG8RoTAetFBmNapvzceEML5/n8nwzQt7mg+UHgPIRD796GDpODN+ShtGqn6Expo25Km8qEtf2PwdrtS4e2NOanVOC7Q839erw1NhHn/w0xUW4Fun9SyEvt0/NJb/FPkp+BN39hCrBSVnkCPPmPK/KpK7MJZUsI7MBZr+s8Q/mREB/Pr2G7RuibBXK3b02yg5OgJ5IiywY7enZFSdsaoV9U9Qfcnf1voBhWzgRPqNRV/hJh06HewH+gztYfWRrafjW53mh3Ey2Mh2dVYvuRn7YVZpJv8A1wFriXmyGvSoxQ8Z+qDEspkpCxVkKfaMAh5W4CLQWubPtntyQjauKLq9cZkBNcKSV9FO6DkJZM5vGbmnQ/14y8y60sKPyjY4tmbSiC0p7YZ16MnvREq16XGokweWoGvUc3QnzGf5OuH8ixKz3VDk4RGWcATid3dCxJG
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff861c83-ee70-4a28-7e96-08ddc43d85c2
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:07.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X297gvkXHGy6BYSYPNAz54lABoks0ofz50o0cjSaqL5lA+I6rpjqjuhqLGRPGX94kqYsNU8G9A5bk/M44H+bHg==
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
X-Proofpoint-ORIG-GUID: 20nJxlpTEc3nZWMRhvzXGpKtIwMB9bdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwMiBTYWx0ZWRfX/9vzDox3vf/K
 fbp+z3i0fUDR9KpQoZWaBG5CD2Uyenn1fe3tOsJcTmQVeeuUqLsnOlvuK4H98KEwYh8kEHa+lJS
 8/ugAlyRTl2jBYw1AFMifgjVhE6/ILaxGn7YKgGqde6LSCgoE6SOiEPNlYv/WdlDIoxhWhpIZ0p
 pvJOpVHKKq3IcSO2d8xonx2JNtmTQZlmNzlOHh8zXYrFiQsn2qSAZDBhw9y4SDyUy/4wXGcXVxE
 JM3sP1PoOTFLH8tGepMEvyRv1b1dqImLFBa+/5HMazzOuEHh5SBa2pmvfXG9wzDwZfDW9vLw58r
 0vGQug2PKcgqnJ/rsam8jL/NYFERahOeZ9JWqwAJlbULr78rjeFxR2c0EZ3Co16Mv6TWzVTMk1c
 MnFZMdPC
X-Proofpoint-GUID: 20nJxlpTEc3nZWMRhvzXGpKtIwMB9bdK
X-Authority-Analysis: v=2.4 cv=Nf3m13D4 c=1 sm=1 tr=0 ts=687759f4 cx=c_pps
 a=yiq0MvgY0icrkiP31sBlkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=Yd8HllbCdjvYV8kqp-4A:9

Fix endianness handling in QMI firmware transfer on big-endian
platforms. Without this fix, the firmware download fails due to
misinterpreted data structures exchanged between the host and the
wireless module.

The issue occurs during early bring-up on big endian systems, where QMI
messages are not correctly parsed by the driver, leading to failed
initialization sequences. Ensure all relevant fields are properly
converted between CPU and little-endian format in request and response
messages, as expected by the firmware. Attached logs showing the failure
before the fix:

    ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath12k_pci 0001:01:00.0: boot pci_mem 0xcd4148e9
    ath12k_pci 0001:01:00.0: pci probe 17cb:1109 17cb:1109
    ath12k_pci 0001:01:00.0: pci tcsr_soc_hw_version major 2 minor 0
    ath12k_pci 0001:01:00.0: request MSI one vector
    ath12k_pci 0001:01:00.0: MSI vectors: 1
    ath12k_pci 0001:01:00.0: msi base data is 0
    ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
    ath12k_pci 0001:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/firmware-2.bin size 15134776
    ath12k_pci 0001:01:00.0: found fw timestamp 1722934582
    ath12k_pci 0001:01:00.0: found m3 image ie (421880 B)
    ath12k_pci 0001:01:00.0: found fw image ie (7229440 B)
    ath12k_pci 0001:01:00.0: found dualmac fw image ie (7483392 B)
    ath12k_pci 0001:01:00.0: found firmware features ie (1 B)
    ath12k_pci 0001:01:00.0: features
    ath12k_pci 0001:01:00.0: using fw api 2
    ath12k_pci 0001:01:00.0: dualmac fw selected for board id: 1005
    ath12k_pci 0001:01:00.0: Assign MSI to user: MHI, num_vectors: 3, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: Number of assigned MSI for MHI is 3, base vector is 0
    ath12k_pci 0001:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: irq:18 group:0
    ath12k_pci 0001:01:00.0: irq:18 group:1
    ath12k_pci 0001:01:00.0: irq:18 group:2
    ath12k_pci 0001:01:00.0: irq:18 group:3
    ath12k_pci 0001:01:00.0: irq:18 group:4
    ath12k_pci 0001:01:00.0: irq:18 group:5
    ath12k_pci 0001:01:00.0: irq:18 group:6
    ath12k_pci 0001:01:00.0: irq:18 group:7
    ath12k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
    ath12k_pci 0001:01:00.0: cookie:0x0
    ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
    ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
    ath12k_pci 0001:01:00.0: soc reset cause:0
    ath12k_pci 0001:01:00.0: MHISTATUS 0xff04
    ath12k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
    ath12k_pci 0001:01:00.0: pci reg 0x3164 instance 0x11 read val 0x11
    ath12k_pci 0001:01:00.0: setting mhi state: INIT(0)
    ath12k_pci 0001:01:00.0: setting mhi state: POWER_ON(2)
    ath12k_pci 0001:01:00.0: mhi notify status reason UNKNOWN
    ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_MISSION_MODE
    ath12k_pci 0001:01:00.0: qmi wifi fw qmi service connected
    ath12k_pci 0001:01:00.0: phy capability resp valid 1 num_phy 2 valid 1 board_id 84934656 valid 1 single_chip_mlo_support 0
    ath12k_pci 0001:01:00.0: intra device MLO is disabled hence skip QMI MLO cap

Alexander Wilhelm (11):
  wifi: ath12k: fix endianness handling in QMI host capability request
  wifi: ath12k: fix endianness handling in QMI phy capability response
  wifi: ath12k: fix endianness handling in QMI firmware indication
  wifi: ath12k: fix endianness handling in QMI firmware memory indication
  wifi: ath12k: fix endianness handling in QMI respond firmware memory
  wifi: ath12k: fix endianness handling in QMI firmware capabilities
  wifi: ath12k: fix endianness handling in QMI bdf download
  wifi: ath12k: fix endianness handling in QMI firmware m3 info
  wifi: ath12k: fix endianness handling in QMI firmware wlan mode
  wifi: ath12k: fix endianness handling in QMI wlan configuration
  wifi: ath12k: fix endianness handling in QMI response

 drivers/net/wireless/ath/ath12k/qmi.c | 149 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/qmi.h | 106 +++++++++---------
 include/linux/soc/qcom/qmi.h          |   4 +-
 3 files changed, 136 insertions(+), 123 deletions(-)

-- 
2.34.1


