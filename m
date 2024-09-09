Return-Path: <linux-wireless+bounces-12682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70459971F8F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801871C21702
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692913BC38;
	Mon,  9 Sep 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F6AmO6cO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035C136E37;
	Mon,  9 Sep 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900718; cv=fail; b=fDCJzRnkhREiRvGelrc0+Q9NGd/PLksglyNQM8Xs2FnttnAJgaKIyc0dSiUIFWNk7mxjLgOsb0ss5r1W1dOj67kUgGjz6ZpeadKdcjgnblnvjD+KVza8mnwNr/YkN5UigSOiygTCZBbf/Xnbs7yeh/sWo558vRCnaXz6/gze9g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900718; c=relaxed/simple;
	bh=N5qAGSKfYju52e7U3K9buMS3buaNEmHkq9ibenDIPbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJDmv8FaY9nGIDDKKj8IvVOj9nGX5AYKuaR8bFO0XpQU2vs9ksAthjIHBkFS7eRV9rwxlQU9pawLorzeSDFm/6ho4FPnc8CUh/Q6VN8HLt7Zk4mvejZK3yG5XaItaXOHkWt4whpPDbzQQtjVfzpSYvE5pexXzWXJ39D5/aZl324=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F6AmO6cO; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9FvB8lE/MwkGiTujFDAwFgc4vVE8o6ACeXQs7kiYajSMgFJukgfCR257nETH0/mOt8TT50OtQHMhqrVY+0GCbrvRjO8nJackU24dhWDQsgfubhkaKnx6gJ5mxtdYXoPCZLoM63Qd/5T2jXU9Xofp2AZVJ5AEGutEaM7z49ZhC/pcH9Nn+bbKOUG5sZsZWlA6y8sGxS/uzQD+63Y6tQpETJzRkXLSUL/k11JDmU16f9oR5HIb7Uo0iSU1ssAeHEXfvz9dLDEqkVcHCs54jUSDMCkTmlxR4dQ+aX1RoVWJzK5M+pZNWs9ZZwJTo3jtKWm8ofWV3K9G0oujE2SakeT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5qAGSKfYju52e7U3K9buMS3buaNEmHkq9ibenDIPbg=;
 b=QUiS9Ect4iMXxmMGrzsIZ/IjFSn0o0n7S8tmGCnicNVcT1CS/WPRLbWjj0W65IPeW/9YA6Lmx2yWbstmz+Yd5jP8o5WtZEfr0+oDfi1S4hZU//ifU3cYw2mVvS9Dh0CApAqHfVCEw374S651HHXoRTTDY29Bke8gD0VcbM5B7MgXJPSEoHoqahF7ZWDn5sAV4vJDx1bSSZcXaAFVpcJuSUilsXwxeYuxsjby3GfS5IAUAlf2Mvw9HIMC7YhhIhim9Yw9m4PdBE7lth5lFZVtaV56POGPwWCzAhVAn8IMYh8NhWfEojKrA9yaJjHdjnwWHiT6Ra+Hms11NvAyn53rDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5qAGSKfYju52e7U3K9buMS3buaNEmHkq9ibenDIPbg=;
 b=F6AmO6cOGC5L4GZznmyNIaAXNLEPMHi9DjmA7ZdtmIPXGOvltb/Mx/QWv9ODDwIJKKswBqYXkdm1pMSrSyqBlcHf6mVAPKzQKr+Hliq77WY3hMrr4ODu/C9wIcE6mo/3WugM6jc2r3BsLVvF74JCR/HjNM+ibBOpnR2Np5ADmXk54a1pFamTmUqBLRAFWDsr1O3Mq9ks0sSwsjHYj7E6cmoKHo10jcfvGxYaSYovoqvTREiMGhrs56WglQVbAkosPNaP6zZMionSTOE+N0fyGSXiE3E/ZI9OVACTGhbDKDBqGHoEL83p03xcGqmd6Nk2vxKVLn03tcP0lmYsM3wleA==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM4PR11MB7326.namprd11.prod.outlook.com (2603:10b6:8:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 16:51:35 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%3]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 16:51:35 +0000
From: <Ajay.Kathat@microchip.com>
To: <kvalo@kernel.org>, <marex@denx.de>
CC: <linux-wireless@vger.kernel.org>, <davem@davemloft.net>,
	<alexis.lothore@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<conor+dt@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<krzk+dt@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
Thread-Topic: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
Thread-Index: AQHa+azJa5h7B/I79U613XwevJ3iqLJPQ+i/gAB5zAA=
Date: Mon, 9 Sep 2024 16:51:35 +0000
Message-ID: <7205210d-8bf8-41ba-9462-38e619027a45@microchip.com>
References: <20240829004510.178016-1-marex@denx.de>
 <20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
In-Reply-To: <87ed5tgofh.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DM4PR11MB7326:EE_
x-ms-office365-filtering-correlation-id: e42a3029-30ad-4548-b5ac-08dcd0efaa5e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEpBN1Y3azVKWUoyM3BvT3hEdzNKODJNeDVHNTRlNjJvWGgrbEV3eldteHJE?=
 =?utf-8?B?d2FWRkkwWkcrTkVoRzFaM2MzT1lsSXNwV2Yzbm9jdC92M2c3TitMNWZQUDRv?=
 =?utf-8?B?bi9NUDdIWlFSTEF0d3J0SXlRK3E2bEZHZEZLVG8ybFNTZkpBbENONlNQeXFo?=
 =?utf-8?B?RnZnMHpxNlo4RE5KMjJJci9adGo3aXdqZTIrYlZ4RWsxTHJXQWVzZSs2bjR6?=
 =?utf-8?B?RGM0Y3hGeFl6a0oza0wxWDlpYTRCNDFZc3gyeXFHejdtL1pjODlkdWxZNmFr?=
 =?utf-8?B?bUZKTUJpVWZ1aGhFNFg5R1ZmVmJVSmdYdURqeGRxdUliZGhEZFJ3UTUrTmNQ?=
 =?utf-8?B?dmdaVXVUSmJSOHNDdW1jWDh4UjlYckF2R3hlQlRIMGVSZVd1RlIrVGJYR2lQ?=
 =?utf-8?B?Ny9KTXQ1QnM3SHA3N3lWbFUwZ3J1RE5BM3N0cU1jT3Fxdmk3M1pTMzJVRmc4?=
 =?utf-8?B?aGVUMWE0YW9nMFkrWThHNjlnT1hqTEZpSCtNU21hRlVMbVljNVcyWTk4V1dv?=
 =?utf-8?B?TWJrMmllSHdoT21Tdmh4dHlPR29tSWJNTis2U1NCd2xEL0lBNE1WS2d4YThm?=
 =?utf-8?B?bFRrMVRkTWNFRzBjMnUzS0lKRGUxWTkwU1B1R2FYMjMxVkwrQlZZVlpPZjVP?=
 =?utf-8?B?dUt2b2l2TzhhdHJVbHJaa2k1MlNpZEdCMkM4UnByOTJyZWFvR0x3V3QveUFC?=
 =?utf-8?B?Wnp1V05HZUxoemMyamdNbENBZDdkd3lJUnFubHJRVUEwL1FFOFBBT0V5ZVI0?=
 =?utf-8?B?K1JEWk1sWHdxU2syWnVxVEtCUFJmcU1WYVV0cnIwcHQ4aUh4VERVOVVYc3pp?=
 =?utf-8?B?OFJiTjZoRXhXb1AyQzdOS2pRTWpPSi90cXFRNjNGR0tGeGJMRU9tRmlqdEJz?=
 =?utf-8?B?NURuS1lNZEdLQW81UWxPMVZ1dk5nS21PNm93cERuMUJIcHV4cjZzeHNydzV6?=
 =?utf-8?B?L0EwaTJsbHVpQ096M1ZrR2gyTkdyQnR0OVNqZUVJV3VXQXJRTTZKaTJPVkVu?=
 =?utf-8?B?MlNFMXJxbUhyc2EyOFBIOEJCUlJ2dTNsYjd1R3lKWjFmZ0s2U01OdWhkakJ5?=
 =?utf-8?B?eHUvU3RYUkxuUnBYNmJQc2ZMZ2ZMSkZEc3ZCai9DUHZtU09RTkM4SHJOTWg1?=
 =?utf-8?B?WVcwV1pHQmRYUHpzUE1vU1h2bWF5Tkd1cGNtQkVuTy9UeCtsR1pHdVRXQ1F5?=
 =?utf-8?B?NnRyWnE5aXhwMWhPQ0xqT2dORlJJZXVKcWt4NkFqWG9abFVXVkNxd0tWZEhm?=
 =?utf-8?B?bUxSTUhVdmZOL0x5cCsrQ3k2aDE0UFlyMFlWU0dGWnFMQ2pwY2RUcXd1QkUz?=
 =?utf-8?B?dVlBTG9pdVJhVVVhMFA1MkhWNWJsZVhyZWcrMUlOdzFMTzBmNVdSUlhod1VK?=
 =?utf-8?B?MTNSSktlYStqNVRwckw1L002WEowUHpvK2U1OS92RklaYUljSUMyYnpaY0pN?=
 =?utf-8?B?Z0Zibjd1NnNMaHVDRXdyQnE5TWpOSU0ydisvbHEzQjk0UVc3eGpwK0lXSkVo?=
 =?utf-8?B?UVEwbkxIZ3NtYW12dWNRVVBoa2xXaVFhZkQ5SnpRcmVJZmVqVU5Rc3l5ZGww?=
 =?utf-8?B?ZUF1dmhYWUFsenpVWTk2a3d0Z2VvNm5aeG4xNDVmZnFuSE9ZQkRCSUJEQTVQ?=
 =?utf-8?B?OW9pMHJlbjB3dmU0cFpSbXBvYWRDYS9qT0xidTZyQi84S1FlMHFkVThQU2o0?=
 =?utf-8?B?ZTJhZ3ZkdHFUNWtNMnlndjRMTHpEc3R1ZGV2Z0RYYzZyT2Zwb2orcDhQTHNs?=
 =?utf-8?B?SnFiRndzY2VWOSswbFhrN2JnZThqQVU4SDdqSjQwc3FmT1BLNnlDeDNVQzlJ?=
 =?utf-8?B?QkNJZW5qQ0J5OG91eU5oUkpRZXRvL2VFQkVmcGNEVlk1L3NIMkg5Qm1ubjdk?=
 =?utf-8?B?SUpFTXdMa1ZiNUVpYUNlMzl2eHdIeVVWMlByRTA1SkJvanc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlNiMEptb3h0M0JLaFhGY2R2MXpZRmgvS2dvbGI4L0owSmJGcmdTcmIyTlV3?=
 =?utf-8?B?MDU4YllQWDBERWRycTltVlZWWWtJUGVkTW9RbCtlWDZ1UXZQeXFobjJ4aUpW?=
 =?utf-8?B?ODFlYWl4Mk1wY1VJbEd2Y0FZc0czZGp5cnFObWRUN0xremY3UU5aQ2w2emkx?=
 =?utf-8?B?N1FleEtRUEdLcmJJRExuVXoxbU5GUGJ0UzljNXVDVm9aSFdEY1g4emJEYkpp?=
 =?utf-8?B?Sk0yWWNVMWoxYUprY0t5b05kVDFuaVFLZHdRZTNucThDUTBrMGRJZWMvZUNQ?=
 =?utf-8?B?MGE5dzlkbHF6azRIbHczMDBXUmlTK3ozMnZlc0FIelgyc3RYblV6S2QvdnVx?=
 =?utf-8?B?UVlKK3lWMjhCTm00aWs2dnl0Q3hHd1hZZ2F5QURvSnBDdGRoUXRHZWV2RzY5?=
 =?utf-8?B?UjVzUGpac2J0dFErWDJWTGFGdDdxSDdMMHhNSzNTQlpyOUpESThJNnpYNkFS?=
 =?utf-8?B?Z1F1YmJrbExUbWZXMklRMFlabmk4MWJWVm5jQ21TSGx3TkhoSDFaV0ZtRVNz?=
 =?utf-8?B?Zm9jeUVhenN1aFk1VG9jOE4zK1BVTStZYUNRSlZaR1VMLzBMeXlveXFvQzQw?=
 =?utf-8?B?TlhyaFlVbExCRGd5UVdxVS9RTEtpQm5DY3lzTFQrblFJZEt3NjkvanBYWUhD?=
 =?utf-8?B?dnNYcHhVVkpiZU1RVndHMzhHWkNvNUdGN1NYYXNGMlJLVUhqNHFObG1EeWov?=
 =?utf-8?B?OVVwUEIzUnpkYzVObE5VTktmWWZKU2RqSk1MbzNvQ2UxS0pYdERpSFkzbk4z?=
 =?utf-8?B?M28rZThQaENVQzFhY3V1cU1KeG1Sb0xVQkJSY1ZEaHFoRFQ4elBhSTVta0Er?=
 =?utf-8?B?UkdkZ1EvcURMR1gwdmJhOER5NnpjeWFScjdsTlRNVnM3TW9vWnArWks2U1FH?=
 =?utf-8?B?bjhNZmU0UnV0dUh3RVduTmlmc2c3SFVJK2tTSXdvRHJZOVNEUDhPVlowN2Nv?=
 =?utf-8?B?MCtCQ21jKzNpSlNucnpqc1Q2dUdzNENiVnY2dnZxZHpVL09nWGhheXpQQVpi?=
 =?utf-8?B?QlZpdWZHSWdxTlhxbjBPQjgxWnhGUEVIN3dpSGs2M2lzMVRSY21aNEpiR2VN?=
 =?utf-8?B?QW5HeUJlNVR0S21Cb3BDSEFHcmhCZzBYZmhpTmJsVUdlQ3lnZU1NTGZGcCty?=
 =?utf-8?B?RlhQMnR6U3oyTzNyUE1WL2VsZGJqVHBzOC9uZElLMEtPYlV1UlVNYm9yMHFv?=
 =?utf-8?B?K0tkc2dIR3FCWDZ6eUJUcDdzWStQWGczdU8wTzE5WHpqOHdxL2Q4T2JvZ2Rk?=
 =?utf-8?B?U1lwSGdMMVlUYXljdHVrZXdqcjMvQ2xoZGVoNU1rTHNhTXBBSW52NmxLNmpn?=
 =?utf-8?B?WVFKY1lHWFY4UEdXcjZUZWdNT054ZXZXdmxRR1A1RTQ3R3F3OU9oNVNwNHlG?=
 =?utf-8?B?bTRxZnBQK2xlVkh2R2o4T0FrclIrd3h4Y25GN29TWkdJdVp4NVRiZTR4ZVZn?=
 =?utf-8?B?THovemxCTlloaVVnUXlabHE0cFQ2cTNISGFhYWlvUkppVzhxVGZNeUwrTEli?=
 =?utf-8?B?VzVKblNiNWxidjhHcklrajlmdlAyNmQ1akpPSlpaRFBpaEhra2tGV0V3MElt?=
 =?utf-8?B?Z0hPNVd0bGQ2ZEowb1V3c1pVZTV3TmFyd1ZiQVp2ajNaRlNRTVBPUnBlVUZt?=
 =?utf-8?B?Zkt1dml2Qnd3RHhmaFM4aEVwK1pqM2kxNGtEYWpCa0orMWRjT3hPSlhjRXBj?=
 =?utf-8?B?YlJBK0h1L0l2c2I0ZFQ1blhIMEhHaDlvblp6RlliT1lLNlFoWkx2aSt2c05x?=
 =?utf-8?B?eElPcGY5bkJhMmhFYnM5d2ZxT1J4Mm9uMHpVandTN1RvRUhXdmV3amhFRHI5?=
 =?utf-8?B?R2FOTzM1TVRVVFJPK3FycHVQc0xRMmZXZ3FoVk94RUcyL3NkaWRVa2Uyb21W?=
 =?utf-8?B?UXVFMlFOUnloK0tFamFWV3ZIQks0WWNUUHhDV2FvQmVTVGFJdUU0TlFpY0Iy?=
 =?utf-8?B?YzFSeHlnbm5kTXlNVmRZRGtScjhXOXNsMld2SC9FbG5YZHFPYzNHeEtRTUpw?=
 =?utf-8?B?KzUyQ3RaaFRJQXdMVkhGVzZBaHcyMjNGeE9IaGFWUTVUK3NtL1dPeUJoY1JY?=
 =?utf-8?B?TzlSSEs2OEZTZnF3SnhPTXVCWVJSNlRVNVp3dnVqMWttMitENGl2V0pBeDJy?=
 =?utf-8?Q?LDRXVSSEfZAMKIMMcMm0EGAka?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A2395CFF6F844EB680EA6A5118561A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42a3029-30ad-4548-b5ac-08dcd0efaa5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 16:51:35.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y77HfzfwdFmHczlUDWdkTKSwFrvy+Xu9C5d21sabU7gs0/OY8TjkaVLc5B2mBggjoko03fcLKnD0Ugo1MDSCyuVdYfmJnniwzfTAAxUDkJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7326

T24gOS85LzI0IDAyOjM1LCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPiB3cml0ZXM6
DQo+IA0KPj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+
DQo+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIFdJTEMzMDAwIGNoaXAuIFRoZSBjaGlwIGlzIHNpbWls
YXIgdG8gV0lMQzEwMDAsDQo+PiBleGNlcHQgdGhhdCB0aGUgcmVnaXN0ZXIgbGF5b3V0IGlzIHNs
aWdodGx5IGRpZmZlcmVudCBhbmQgaXQgZG9lcw0KPj4gbm90IHN1cHBvcnQgV1BBMy9TQUUuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiANCj4g
Wy4uLl0NCj4gDQo+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEw
MDAvY2ZnODAyMTEuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL2NmZzgwMjExLmMNCj4+IEBAIC0zMTMsNiArMzEzLDEzIEBAIHN0YXRpYyBpbnQgY29u
bmVjdChzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPj4NCj4+
ICAgICAgIHZpZi0+Y29ubmVjdGluZyA9IHRydWU7DQo+Pg0KPj4gKyAgICAgaWYgKHNtZS0+YXV0
aF90eXBlID09IE5MODAyMTFfQVVUSFRZUEVfU0FFICYmDQo+PiArICAgICAgICAgaXNfd2lsYzMw
MDAodmlmLT53aWxjLT5jaGlwaWQpKSB7DQo+PiArICAgICAgICAgICAgIG5ldGRldl9lcnIoZGV2
LCAiV0lMQzMwMDA6IFdQQTMgbm90IHN1cHBvcnRlZFxuIik7DQo+PiArICAgICAgICAgICAgIHJl
dCA9IC1FT1BOT1RTVVBQOw0KPj4gKyAgICAgICAgICAgICBnb3RvIG91dF9lcnJvcjsNCj4+ICsg
ICAgIH0NCj4gDQo+IFRoaXMgbG9va3Mgd3JvbmcuIElmIHdpbGMzMDAwIGRvZXNuJ3Qgc3VwcG9y
dCBTQUUgeW91IHNob3VsZG4ndA0KPiBhZHZlcnRpc2UgTkw4MDIxMV9GRUFUVVJFX1NBRSB0byB1
c2VyIHNwYWNlLiBJIHRoaW5rIHRoZSBjaGVjayBmb3INCj4gd2lsYzMwMDAgc2hvdWxkIGJlIGlu
IHdpbGNfY3JlYXRlX3dpcGh5KCk6DQo+IA0KDQpBY3R1YWxseSwgdGhlIGNoaXAgSUQgaXMgbm90
IGF2YWlsYWJsZSB3aGVuIHdpbGNfY3JlYXRlX3dpcGh5KCkgaXMgY2FsbGVkIGJ1dA0KaXMgc2V0
IGxhdGVyIGluIHRoZSBkZXZpY2UgcHJvYmUgZnVuY3Rpb24uIFRoZXJlZm9yZSwgYWRkaW5nIHRo
ZQ0KJ2lzX3dpbGMzMDAwKHZpZi0+d2lsYy0+Y2hpcGlkKScgY29uZGl0aW9uIG1heSBub3Qgd29y
ayBhcyBleHBlY3RlZC4NCkFsc28sIEkgdGhpbmsgdGhlcmUgaXMgbm8gQVBJIHRvIGNoYW5nZSAi
d2lwaHktPmZlYXR1cmVzIiBhZnRlciB3aXBoeSBpcw0KcmVnaXN0ZXJlZCB0byBzZXQgaXQgbGF0
ZXIgd2hlbiBjaGlwIElEIGluZm9ybWF0aW9uIGlzIGF2YWlsYWJsZS4NCg0KRG9lcyBpdCBtYWtl
IHNlbnNlIHRvIGFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIgZm9yIGRldmljZSB0eXBlKHdpbGMxMDAw
IG9yDQp3aWxjMzAwMCkgdG8gYWRkcmVzcyBkZXZpY2Utc3BlY2lmaWMgZmVhdHVyaXphdGlvbi4N
Cg0KPiBpZiAoIWlzX3dpbGMzMDAwKHZpZi0+d2lsYy0+Y2hpcGlkKSkNCj4gICAgICAgICB3aXBo
eS0+ZmVhdHVyZXMgfD0gTkw4MDIxMV9GRUFUVVJFX1NBRTsNCj4gDQo+IC0tDQo+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9saXN0Lw0KPiANCj4g
aHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0
aW9uL3N1Ym1pdHRpbmdwYXRjaGVzDQoNCg==

