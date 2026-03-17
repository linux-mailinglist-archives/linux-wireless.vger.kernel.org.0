Return-Path: <linux-wireless+bounces-33349-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN6OKYk5uWlYvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33349-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:22:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D92A8A8C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2D723020A6D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057C372EE2;
	Tue, 17 Mar 2026 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="Y2ythEgA";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="kFnwt3pk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC223C51D;
	Tue, 17 Mar 2026 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746565; cv=fail; b=EnaeWQRyOXjYe9OySV8Ktv2uZhOQzyqaM5BissSFo/eIiK24JgXbBJYbGKjvMwjOji2FgICpnt06mFDF6GERucg3vhG3vZepx2cV6f4L8/JTAL5lTm+u6XSptPBfbAm9ooeaPcURPbiayweL5hXqpQjmDBAoOPVYDXTFWhfHsRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746565; c=relaxed/simple;
	bh=TmRoWKRid5Kxj/ppgbu8u5M5xTUFvu2PYTAJtOeTwgA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=tK8VzxKmQyQX9nhkpyXmTG8NMLHt6U9oaMBMCsWliqZ9kFQpbRUYUoBqNdRzjR0JtRYFrCFGGCpcTwLrokWLjGGET2BsreWW7wbubFshVZ3HaKqMnGrCCEBy2gvVEyq0zlNxnslnRMy181xRXneZzoGF3jY6Y7hjzrOPRj3AP0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Y2ythEgA; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=kFnwt3pk; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H6Dn9q3032592;
	Tue, 17 Mar 2026 12:22:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=ieyHzbQD9Vp9GularB+qcG
	1quJHbMo/DANoSoG3ZfuE=; b=Y2ythEgAfYeNxt+DxrCky83zED/w5SbssKY/Zl
	nkKVoytbzCJcGORG3uSPPvJfJ6gr2nppuY1ROc4rFMWda+A7/z+ungHQwF1avo1+
	lMq4b69xPoQU17GHmnYYFV5rRWszMYD/zErpfI+w3JcuhKKEIeXeUqF07sCKMFkz
	5Vs1CZGpCmJnt6v9kpxmyhgI36/UegQeAjUbu1sGgQ0Vqe0WwseYBMzNKnOgybcC
	RnDJWLG0lup+A+5AB0jWubwmBflttTYkx+HSb48/4Fr9MBMwZ+HzDeItDNFGHbcG
	HRWEmtw88PxIHsLurVQsdGDZCDEVy/hOsmTt/I7jGx1ySpUQ==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020139.outbound.protection.outlook.com [52.101.84.139])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cxnkj0uyw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:22:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/t8iWhW1BploP/KSJsr/Hp8/qRD13WoKNjPOuC/IsxeRiGSKk0HEfIldCK72hj0VTwN6y7i+G1xLs0MYbhx9/hdCRLSv6Y4N6pJPVw09LN2mAZlZgO5o82R0bPKkC6qLBqYjP7hxVeA32QX88JgOPDyecfiKmAW55DNNYwUdwmvMjRhv9UqN4pGXEAwKANt4oWOaBmADH/pPK9WFO+YRg5VnAiOf7bMJaJY6WwRSrkwxIEAVRJQcukNkQcEnA4amv530TA9X0UG6F1Bd6e8OMPc6iNj+N7i+PabczBqBQyEIUdaL+NweWcxwJAU6h9J4Yfh6OL4fAoNjAu0gZD+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieyHzbQD9Vp9GularB+qcG1quJHbMo/DANoSoG3ZfuE=;
 b=FA9PgCpAmIAHZvO7T628fErMOnAF8nG7Jcpsma64FtybgDzBS5qdxBTfAm0SbvqWlrGbj5LqYFKy+Z4E4tmusrqaTPbu/g4bePdgCVX+qmHPOuL5Sb3MvDkOiNSYHOHoQGt0wDb9ZUZajQ96iCNghSFbRb/EOPF6aP2KCAIZC8+BdegDCNteqaopKAWpX+fK7U2SkgGJrYLjtr0XAge0MCC+QF+WWN9/7vM5VugpOY701sXjwhYDa9QydmCJndkINo1QtvCEz/b1RY+VTrbNRvP+mwVzAY8Vn70EJiYf19IbWyoZeOrM7wfPCriehwuA/YTpWOBaUdgaMto7WnueSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieyHzbQD9Vp9GularB+qcG1quJHbMo/DANoSoG3ZfuE=;
 b=kFnwt3pkRU7H3jOSBSldPfSbV7fCFlxQ01haeNEiJTiaoCJlyWeifSgq/GUK/YcYennF49yNTwvYEbf4wonjDPcAT8sDfWQZpB5dvIOL0zb76LGo0TiUnQloHsgDrWIopxYaGYTpTZC2KI3qmcYJ4DzgGPrvHNmSfLg7s/QAnCc=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by PR3P192MB0894.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 11:22:34 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 11:22:34 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Tue, 17 Mar 2026 12:22:05 +0100
Subject: [PATCH] wifi: ath12k: fix MAC address copy on big endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-fix-mac-addr-copy-on-big-endian-v1-1-b7b6c49cb07f@westermo.com>
X-B4-Tracking: v=1; b=H4sIAFw5uWkC/x2NwQrCMBAFf6Xs2QdJDVb8leJhTTZ1D92UBIpS+
 u8Gj3OYmYOaVJVGj+GgKrs2LdbBXwaKb7ZFoKkzjW68uaufkPWDlSM4pYpYti+K4aULxJKyIXs
 OWTg4fw/UK1uVrvwP8/M8f1AMRIRxAAAA
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::34) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|PR3P192MB0894:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c36a800-8562-498a-e192-08de84177ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YbuIdD/meqmunpDtU0cbFR60PW5ET3vNRIY6ZrgA2NYtZHA500PsBMHOkTDg/veiASLUhk2w4h7yGf5gFcGYh1nhrATMPyxuU4QQzTVqFqc9FTnDsL8n3e9iWzJL/TI5a9i7P1r9IXmZDCDBACgDK/gLxZizZJ436tmBqxkStDSRwNl7HiypobskJwdITZR5GKu+nPE+oT4JCFtfoe+xX1UYz3abp7x2SrOGOPneL5mdzNSzGEF2EqPsAUGBKkav4x5Yvv0TygqTcLda5hR+ECXdeKx5HPsLf/+mIdXjXw1ewqKjLLvzCAReNZCydhwURhbnOvzO1g/x58QRQOygbMXTYvoIxwnp1XdkrwoGUXhssXnM6a74jbqpaDvYZ3tExN7sB6L4SGBZvraYzCmOiKzbpxJoUU4AC7kSTmXUSyPHgIzBQLNNn51E0MdiRP99vQCZ5heYDvtVeQnar0/Ao5sFetq5zaN9T+e2O42WIZ4cIMubaANcvW7p6N8C1vcKlpJsG7Ti3k0tw0uQP7uubvJVLxB8td+0FXK7CgApoSx6fFO4Ga3MV5TwANfu1QV+UkR5KbG02x8FNtTQM4kz/j9j35TPGw/ucXhNYUojcQBFVRDVWzY1cr783yY+ljcj0vGBmkRM8bc0kPntWvjBqBVQzTWZmgW+WUbuap0vtCjAApVEMkqbu/4L5eLf+K2UT2fkSwaFbDvDBPM6osSk5UZ3Gkdo59xBKRj2r4HbJiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0pmeUUyY1l5dHh4ekhOcnBxWmtHUXJpVUxaTFVKbmFnaUJFTitHbXk3SnV2?=
 =?utf-8?B?R3FIVzBQYW1GWndMRTIzTnpaUHZFTjlteGRJTURFR0dzZ3VOK1BHMExMcWli?=
 =?utf-8?B?aHdYcWt0bktkVy81SndsTUJSK3habTNBeXRHbk9acDZ3Wi9DVmR2cFBaV0NF?=
 =?utf-8?B?dStVeWxiV1pyZjc5aVdQdTJtbVNqS0RRdTRES1lIVUN4QnJOU212Zjl0LzJi?=
 =?utf-8?B?d0Q0VVZDVDBtcldQcTNKYlhjdlIzOE56SmpmZ0NpVFpFc1RCbktKd0swTE1w?=
 =?utf-8?B?VU5veTJzbDhMTWVLM1NqSDZDVEoyV09meDAyQm03M3pxL0pvdUw4aDRRd2J6?=
 =?utf-8?B?ZUtoK3RlRkV3SWQ4by9UTy9QZ09Oa2JjeEFQTjExMUZTQmhLMDBMcUY3SmxT?=
 =?utf-8?B?ZFl3cDF1SHlSM0xGZkI2OGpiR2NJdW05NXFtOWtUTVpmSDFHWUJoWCthbDU4?=
 =?utf-8?B?VGZpL0J1RlpVL2ZTMEp4cFdpSk15cTJQV2VHKy92dmVBUGdsRGUzaUhhYVBx?=
 =?utf-8?B?aVhKK0ZiOWhCY2htWTFtSkhBTjBPa1FDcEZmVFY1Tm93bzBBdTM0TnNHTnBm?=
 =?utf-8?B?ZlBJZGhyOXEwM1M1YVRUYjlNMmhONXBNb1EyRzRuSzA0bUFQczJaRXcxQzlJ?=
 =?utf-8?B?a1U0VnVHODZMM00rRnc3eFlMTnowMWJYdWdySnk2VjNtZndOeERPcUF5bWt6?=
 =?utf-8?B?a1dYWDIwcTRQc00vYW5GVWNmSWZVdk5FWHQreWVvbmRuQVFPenR4SkFlYm1B?=
 =?utf-8?B?NUduMUhId0h6N3RhUlpmang4ZnlWWVo4N1lEQ0lTZ083UlVodDIzb3BWSnJ4?=
 =?utf-8?B?TUZKbHpOUTlwYW1VYnhnZFc1WnpuT3phTG9vZDJ4TWtrTjBlT3NHKzkyOUNW?=
 =?utf-8?B?dzhVSVMzTWZxTklTRGNpcytyVHIrcDMzTWY4M3NKOThlZXYwdHBrV29KVGcv?=
 =?utf-8?B?WFNhZGhERk5sL3BCZmtLRENadkpkN3BrcFRtWWJsMkNIT0JTY29vVUZpN1pl?=
 =?utf-8?B?MFREcU9DWnBLSnkzeE1JK3NidjA4TDZlbnp3Vjk0MGcwekF5Vjk2Vkw0TXBD?=
 =?utf-8?B?TlZ1RDNVSHVKTU85RTdJNmRMMnhNdCs2bVljMWxjR3ZxeDdmVHNIc2dEM1Rz?=
 =?utf-8?B?V1dRNzJuaXJJYmRjdHR0Y2wwWStIVWkwam5tb1puSklQek15d2ovUzFGQ2lH?=
 =?utf-8?B?NG1KalRPRFJHb0lCV1JoakhZaUFiRzBOSzZaTTBHbWFFTE1ia2k1WVkyTXox?=
 =?utf-8?B?YmRDTnducDF5eXBBVE0rS2FGNDVhT1duMFMyYlhHNTQvOFhvaGtWQUkyR3Vn?=
 =?utf-8?B?Qk1NK0lVOU9VMzc5WEorak5CWTZod0IwWXVqb2RJUndkNmk1a3ZXZE1ycXRw?=
 =?utf-8?B?SE54MlRYYzJqbHB0Skd6UnNYVGdCK2pnbGlJVlhNSmI1N2xTK3FxVlY0cWZi?=
 =?utf-8?B?S3RQeHh2cktONmU3OEZXTGNxWWYwVDFEeHFJOGJWV3dqclJvVk1DTDlBeWtS?=
 =?utf-8?B?S2FhYk5DMUo0VUd5QUhjbmw5bVgzQytpMWRvK1hnL3BMUGhuVUJLUnp6M0s4?=
 =?utf-8?B?OGk2ZnNXb0w5RkZOQnlkYlJ1Q29YYldnZ1hUMWdpUk5hZmtNYTNXSXR2c2tP?=
 =?utf-8?B?VWVZTFZKbUdQTU5xYm92UStpSWM2bE9BTlkxYWt5NVVUcmJMNllBZ0JiZWNP?=
 =?utf-8?B?MEcrMlRkei91QlNLMVFBbkpDTWZROGJXWVVTUEZ6S2p5UCt2WE9KWkFDWk1v?=
 =?utf-8?B?T2E4ckxZZzQxMVhaU0tJSzdiOFNSTGgxbzkydnhET09kRlFDT2xiQWlsWnhy?=
 =?utf-8?B?clRYbzZRSjBCT0Y4WXRJcTdXVDRFNzEvQmN0NVRmM3IrVkJ6Qzlqc05yalZX?=
 =?utf-8?B?cmg3UTBDTmdweldVRXlKblBhdTN0UW91UnFIV0wvRDE1NXNoNVErVlN5ODhP?=
 =?utf-8?B?VEp3UnQ0Q1V5bXdSTXI5QzJiWkI3bkFuR2xwQ2NqZ01oSnFpTlRudG1nRkMr?=
 =?utf-8?B?SWEvbVdHQ0FoaXlyNHhyTS9TOVZNNGdUa0tIbUVRNXV4NStjaVpDaGVabzI2?=
 =?utf-8?B?ZTdESzdqQ1BrZEtERzV6VllIekhWQldWalB3YlBiWkVTMG9rYzFneUhmcmVW?=
 =?utf-8?B?T0VFTmI5ZTlOVzJxaTFIWExrQzl4c1JsQm9ZSTU0bW5DRU1KY253RFhDcVlZ?=
 =?utf-8?B?eFNPaEVmWFJiaWlXbmM1dGNkbjJtOXFYR1JwazVzbUtJbDRMd0xxeEIrSllY?=
 =?utf-8?B?Z09MQ1BXd3lmaUtSWGY2QUZVSVVYM0tiY2taWTdDbjBtMFlvT2ptZWNlOHg5?=
 =?utf-8?B?ZDZvTmY4Y2JlMDdORVdSUjJ1UmFRYmNvaGx6U1pqVUcrdGozNkVCUT09?=
X-Exchange-RoutingPolicyChecked:
	ATEZus2HXmEHEVOo7cBRPGEQ+gu6dn0+oD8Tb3OFJ5KWLjY/VdPsDTYPROoOj1G3EC43A2Qr4zcP6AgtR39uRJzTaKco3pCErzSS6czJR2F0KeakPujy8CqcNjrX38qaRgyPoKuFkU4oGue6v56nv7qz0vGEwd7hbXlxg3aCg9IY0CXqI2SA5GA36NvcERWTKBPaucCtldygu//wMdPLHaCt/uN8+NH4LW6XhIXu7lmrkQqZxRs1b7+n/KHd9NjIt3jdf1dhpWPXoXiA3v/am4PxF2WinNxIH5Hucd1fTWFj/oKgVFqbFJKT+w9stxRcYa/h74Jk0NtlnKVvSvXPtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r5nmnve90rL1h6SxTNQdrDfu9HCSO5C1/CRPEUhVGC7QznHMutKkCscLQxATtN4+5dgbU5jB7UTIsDBlNr9kVjh1uf/z5wJAJo9sfF9ujvSdS6lUkpZ5XlaS1CG6ZTq1QzSudU1jdHEXr4hMa+2ohQB89NW4a694ZR/RcWIhtLoiol0jvLTvQ/VCyFyJgoG41/RTwGy8kvnETtyL1LnWez10y9IJ9uGj++nAOZio1R8ZEB5I6j9+ptvLFubxE5qhuJi95kT4vZ3a6YyCz56ndgzNSR0/AoraVB2uiulAVYx9Uyk7hXaJpLhQaE2BCHQ7aSI+cIHnss0dBhFhGEnla8ZnREWB30lPSJp3tkSYUe6MGrvLu79V+5ZpzBJ1ZkRqZWrXjQ/ZAPiAj0hRU5/xRBowlpNamP4w+4LZ8HEEoBRbxMyOrqn41bz32x+1y/34w7rKbNVI4/VkjLBRgcxQ21a+vaqi4x5XdYEFTn7hbFMBTlxPH0+WlClyTS09VWc9z0Cfboyvl3wVMqwA3jWHoPvsAbxbQRJ6z6Eh1gU2BvGHHigWAfvBqmn5QPIOMRU9+Zb6K+1kHBJna3yawZ1fwiGJCbyTz79e6mxlkG546fqDgQa5cg+qsmxAVmcGzGAC
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c36a800-8562-498a-e192-08de84177ca7
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:22:34.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL66YzAfgDsyeNhI6yfUzZcyfROC8BQEg4X1RNoCv4KCiYSv567zgn9RL3Dwt08QflsB2rd1a9jF5d5cvHhngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0894
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
X-OrganizationHeadersPreserved: PR3P192MB0894.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PO8COPqC c=1 sm=1 tr=0 ts=69b9397b cx=c_pps
 a=Ct3+nv1AAFb6OC/XyZwqoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: gI8kQGoXBkzbyOykJowcReK7e-NeVcup
X-Proofpoint-ORIG-GUID: gI8kQGoXBkzbyOykJowcReK7e-NeVcup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwMCBTYWx0ZWRfXw+AJKkIsDc7b
 tXT99v6rMFoUkAsddoEYI+bOAk3kOGxLlQbMs7oyOOSmg2UKt3VGTEt1cfkB6NOU3ICxtsPcnh6
 /8qZlKFZ8fsXGo3gtEzv0UXkBZnFg8H2BVcoHqeTfiWuS+6r2oQglLp/4V7QGyxcoOdbj/mDPvZ
 +6xXWMcxrEKFyOMjwqjdJxTZ9dMyW/0IGHAMNc6RVj8cEmJlnmxEfWI6PYtPHDYAbax7cY/M18i
 74E1wCsj8j96O5NQkNx0gOHlo0ZecbA2hwLT2iEfBh5W1EW9jiVgItCn0GRFV9YzC3rIWItTiQQ
 /+FT/j13Jp04xmNiufR8Ilf1uwjq9T9niWeJRItEBNrNHBSzA9ycs7TRaV2iWy8tPcys9YcZdWU
 V882IOg1VOIAuvDYCrG4lnQlaIESAZQAGnnyLX6Lfy3QkXm9ISAnQgVtrKmoVNbghSpCTrwfLiJ
 Ct1jd4lyw0cP5ERQrpQ==
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33349-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,westermo.com:dkim,westermo.com:email,westermo.com:mid,beijerelectronicsab.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C6D92A8A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ath12k_dp_get_mac_addr function performs a simple memcpy from a
CPU-native data types into an u8 array. On a big-endian architecture, this
later results in a null‑pointer dereference. Convert the data to
little‑endian first, then copy it into the target array.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..50957915dbf4 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -647,8 +647,11 @@ int ath12k_dp_arch_rx_tid_delete_handler(struct ath12k_dp *dp,
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 {
-	memcpy(addr, &addr_l32, 4);
-	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
+	__le32 le_addr_l32 = cpu_to_le32(addr_l32);
+	__le16 le_addr_h16 = cpu_to_le16(addr_h16);
+
+	memcpy(addr, &le_addr_l32, 4);
+	memcpy(addr + 4, &le_addr_h16, ETH_ALEN - 4);
 }
 
 static inline struct ath12k_dp *

---
base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
change-id: 20260317-fix-mac-addr-copy-on-big-endian-f1a4fea40184

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


