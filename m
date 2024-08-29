Return-Path: <linux-wireless+bounces-12197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09A9637ED
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 03:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A11B214F6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 01:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB23DDA1;
	Thu, 29 Aug 2024 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f/Ymwvuu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0C8814
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895928; cv=fail; b=sUwKQvdKWaUHI9xB1tgkl6b0mlAnQ9IQil0w22eXrTuzMz1/24KVDZgYBK13Ev5R0i18AXD+oRXxRqHgc1H8xP+7IpWdCPgd/KU/K/Ofi3sZ2UHQdOZTTxPV7Cc5ZNtpSuU1u84p8PN+X3OXzUqBD8Ax4LyyCmTVRD0MKkOxCjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895928; c=relaxed/simple;
	bh=82lA6aBY3A/OPemHdZBb/Vl3GI8V6cU5BkxwwUxu7OU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tct9zu/hO+KnSQDan79YI1TUJCQfGJbKiuPR6HV0xIXfY9p2ral/3ZtzanBn/UG/fj5XVaF5b0XBDvKX0GuFkwEu8yl6QXrL60lduIozI7VeHi34AaS5syPk0EAuQMD2yJ+S8pWeYvynL/EXhg+LfS8twwGvK1ZZC8IjgSBHHUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f/Ymwvuu; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC34mdLtwhDeZT94g3XLJwb2PTabX/RH+EwqrVOcbp1GmB9svRI97h4Y7aCqC01qVMXFmsyC0rugQbAKwwvq6QIYQTgBP1kr6cJHzpuU0LeXv1gN5zjkEVkn2UsjxFHlp1xGL4xTY0Cac0a9gFXZyVQPIvVgyKw8VHC7xYESR7yEflhWp0W8FeQ52RbzoXwKIoyS6sstaX3lRcjWFW5DFTNhAWExGnauFuaIqYfvQC97/Xcgvfc1JcHYhFrS8V/2007Q6QDG82lbCFQweImGZWkTIsUAPapYy1xbmhywc9C6sPPuPWGZI4RWK0PWMvuTtzkOP203lPpAFCQdcuv+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82lA6aBY3A/OPemHdZBb/Vl3GI8V6cU5BkxwwUxu7OU=;
 b=R9SUzBwJg2l/ZLvR2O9yiPMgCNHNm/2mAd9Ik4H/t2kbnI2qnGKIilVQD6IEtwkddBTsq/t5kysOKmkHPwGe1QpC5GNA3E80P/CAtg8pLCg2dTlKt1sWdcIuzy54uw/hSqedrOgoCjw3ATVSleFgvIsH2hHLbV9OROX0DNW93gXCdVtoUZE4tngEu1//4txfENMH/MpV/ytuuw8fIBT6OFQ5Z3eBXpHThoIqBewRHeu9AHri5qwH/6AzKWLmXjDTcBBkgcbiMUvJziz9L7eOWMp7VqxBTg+yLcujdtUVFiN4TVrvcrNoq1mrJJWcwGCLRuBZ3mxjMcd7FJzcIe4UAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82lA6aBY3A/OPemHdZBb/Vl3GI8V6cU5BkxwwUxu7OU=;
 b=f/Ymwvuu+3k49mSPIwZFlAEA+h1JzoX0pwEJoHMmhdJDoD5RneUbm9aZ8L8uiSLShnSStuVvJhwTH69IY22xc6DCYywx+sZ1+dS+Q2rPo+Ke6gFjZRwEwSz8+fgwWyDChMdVqMBBvDAvCIfHD+U71TebotFR02vsxrNjpFXxusQZzbg8mfgjiRBEHgX8Nbpv4i+3TZoPUt4WNbBra5neawqOJ9RMMZQBx90abzGtpsSTzWKhnY97LnB8X1uHIQhzND7T/khsFwUlH6nb7sjly1nP2cI35OvesEARZMq20bGTpACT52MAHDqoUvT1rm9vI1piuzUtfwQcHjEEcOTTSg==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 01:45:23 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%2]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:45:23 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <marex@denx.de>,
	<linux-wireless@vger.kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
Thread-Topic: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
Thread-Index: AQHa8/lbON6r1hV5EkW52mJu7NaXnrI65e6AgABbhoCAARI4gIABLp2A
Date: Thu, 29 Aug 2024 01:45:23 +0000
Message-ID: <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
In-Reply-To: <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DM6PR11MB4547:EE_
x-ms-office365-filtering-correlation-id: 2a5e6f39-c785-4a1c-e8eb-08dcc7cc3fb5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGU5Nk1XZ3l0MnhBZ1R1SCtYdzlaZW9KRGpqSHNlZUswQXQyYjBCSFV5clFZ?=
 =?utf-8?B?VkhTVFcrM3hQYzBhNXVGWmVXN0k2L3RDdFBPQ05GZXV0VWd0akdwYldQMGNj?=
 =?utf-8?B?THlmVklMamx0aTBFdlA4OEtwTFg0WWhJVzg4amk0bjF2aTY3ZnB3VGJYcHJx?=
 =?utf-8?B?aDRCY3dDakhHSWc2R1hMWkhoWEdQNFU1Sk9VMU5PSWM3Vm0xeE8yWWFLQ2xo?=
 =?utf-8?B?TDF1SmE4MURlTXhZcjM4WmgzbURpc3ByT2pTNWIwd3lMSnBvcmtYbUtVVmlE?=
 =?utf-8?B?WDR2M3g4aEx6OFN0TUtDc0FOeTBFNWRTdVFlU0xYTHhValpydVpxZE1rNFRy?=
 =?utf-8?B?TWdDSVFhTHNNYitVUlRNSExJVXp1b1dya1hLQmtvNVdyM2JKV1V2Sm03SmRP?=
 =?utf-8?B?c2pWT1BjUEwwd00zUVdNbSs2SHZGaW1PdnJLZzhJQk4wdkt0dmZFRkdwSTZ4?=
 =?utf-8?B?NnNhcWV6ZzlDZ0ZBamp0aG1KYmxkTXZ2R2IvVGd5TGNuZUl3MU54Vk5BU1VY?=
 =?utf-8?B?NTdudnRCUUk2QWgreWdFMnk2TjZUNkxsTThFK2RncGxjOEFWYnJvb3JhZ3J2?=
 =?utf-8?B?RlgxSjduOUc5aURpMnNodlBaZzBDVGNHOXJkNmRzTHE0ZG1TeVNIWWp4YXdQ?=
 =?utf-8?B?YkdFODRyc3FWbWpwUjZVR2FFRWlZK05kM3NKZld6eCtCTmpUYUIwcU5jMjds?=
 =?utf-8?B?OG1WdUVHMXUrWmJkMElucjN6cnRJYTBTQlhLQkVGdkNSbkxBTysxTmJXMHQv?=
 =?utf-8?B?KzlLQnRVbXlYdlFkL2tORjNYYjVqaWdSaTNnejB1N2d4K1ZkQXZISzFITEJt?=
 =?utf-8?B?K3haYVJWb0MvU29OKy84cSt5OGtaNzF5OTRDaGNMUjRFZ2t4OWNZd0srTnBE?=
 =?utf-8?B?a2V2Rm1jMXZRTTNUdjlHT25rYUM5RGFnYmxzTVc1Ti9JSE1YWkZWR2IwZ0Zx?=
 =?utf-8?B?YW5VUEJZS1p1b0s5b0hGdTBlS3FGVkpTWlRuTlIwSjY0Z0ZBQUQ5cjFMM1o2?=
 =?utf-8?B?aDNyaGNlU1VjOXNVTzNRTmtWaFE4K21CdC9EVFJGVjNTU3FlQU1sZEdlSitW?=
 =?utf-8?B?RjUwemxNb3Y2bW8xWklTdVFVRkxxNVlrUTZiR0pQYTR3bkgvWGl5akNrS2p3?=
 =?utf-8?B?b2Q4VTZTRGk4dFM0b0JLZXM1RkN0STlTNGlISWlMdW1JVjh1V3pYS2ZoZ2R0?=
 =?utf-8?B?Z1E3UWI3clk2enFiODFvWkE3N213cTJWUVVtRnZlWDJrb1p5MitNVXY1RWdV?=
 =?utf-8?B?TDJLbzZ3ZG81Ry9LK0VkVlpoLzhQTTVMMEZuZHFRditEbGJxc1hEc1hNZkR1?=
 =?utf-8?B?bVVSTHdueVBwbTk1L29heDZ2UStrNzZ3OUc1Rmx6QkpaTzMzeG1VdXhHMmNP?=
 =?utf-8?B?cmpUbGRhMXBpV1lEbTRxNzExUDlFYlpmSkt6NlNvVXN5S1JXRlJiQm5HZnhH?=
 =?utf-8?B?YmZ1NEI4UzZCKys5aWhYRzZhblV1cWhJZVRXeGpUVGh2VXJGVTJkTFc4VXc1?=
 =?utf-8?B?NStsdmtLUVEvTnFFNUFkbm5kTk53VCtkU0NZZzJaZFY4WXpiMGJNcjlHc3Z3?=
 =?utf-8?B?dUh2YmlHZlFYNGdXZGNSV082VzNlUVpsZThpQm5RUUp3cW1qMVN0b1pGY0U2?=
 =?utf-8?B?V0QvVFJSREhkUDVXVU5TME1oUFRpalgzcW92Z1p3bDV6NkpteDk1Ty81RTRH?=
 =?utf-8?B?T3hndnVVNWpJVXNoT3E0a0h4RmpUQmJnMUVERkpGM3pGcDFOYytWVkM1dWJy?=
 =?utf-8?B?TWJGRzVmVWF6ZytjS2o3U0pWKzNLamNoOWFGUWNaVXQ1dExvSnk5SDNSQWFw?=
 =?utf-8?B?aEtPTzBBQUZ1b2tldnZjUExKTTFIK2MvZ1FjREtvOTBiVk4rWlhBQVZzblho?=
 =?utf-8?B?YUlNTDJwMjNhcmQvZWFQMGFEMVFHTDg0ZlNQSnFIV1pTU3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWpJYTFjYlVpOEhGMzJVNmJVaGxXeHZ5YVBaNW5YQU03ZmZjV09NMTBMR2t1?=
 =?utf-8?B?Mm9jMXJuTGpYaDhuZVJCcC8wRE84K3p0aXdpelFidWRGYjloQWRuMG1rbjR2?=
 =?utf-8?B?WGxJUEF2SGZUeXFQUnNXSno0MnF6dUVZdDY0Y0tHWmdrMEtKL1hBOWFqN1ph?=
 =?utf-8?B?UDlJUHFaTXdIdHpMM2E3RnhITHJSZWFEcDUyM2NaMytURE0rN0FJd3BxV3lw?=
 =?utf-8?B?UUwzMGJGVzRoUDkyYnkydGRhZCtWbHk5UEpKM3I1YWtjaVowbUV5bzdZTllZ?=
 =?utf-8?B?UEVzRWtMZkVObG9jRzVhcHA4MGFUc0dodFlmMEduTituQjgzbjFBZGdwNWxo?=
 =?utf-8?B?aFdhQ3Y3ZmNFcFQ3NmVHMWlTTkJFSTJ5QTFxaGh4OXlWQjhNRWhqNG5QUGRM?=
 =?utf-8?B?YUNoZjFBU09nV2RxWkJwV2Z2cElrVk10RGx4aVhQMERGZ1JxQzk5ekFkVTFU?=
 =?utf-8?B?bXk3U3dVRkNsNDFaN0xiWUJDZDRROFhmeGkxcWVpaEVoQ2p0Z01DL3NXaWhP?=
 =?utf-8?B?Sks1UXBZRDgwWDJlakM5NFFIU2hNSlgreVUrNUFYWmx1NWo2bm1PUGdVQlJn?=
 =?utf-8?B?UVk5SWJ1TlZCdDRxNnNzUVViMjk5NXc2a2MwVHc4YjI1dUxFUEt6VHkzTEtB?=
 =?utf-8?B?Y3MxVEZOVHdSd3JGcjgrYUpUSm5nR1JaTlNOQmRabWJiS2dTRnk1V3Zhamln?=
 =?utf-8?B?RGpPT0hiT2xiNk9YNndrb3J6S0VHb3ZkZDRUaGNWZXpQZDQ0WjJCeC9lMElW?=
 =?utf-8?B?b0RDTEpYNU9zeUpoUTlIRGNCa0lObEExNTd6dTlDT2k0Zk1rWUNaQ21yQUtn?=
 =?utf-8?B?UEpNMDZMaEtjeVAzbm84WGMrRm9pVDFlMkhTTzY0VVJhbnhNM1pKV1VWWXhL?=
 =?utf-8?B?NitnaGNuVFJJMnVGMm0wdDJxL1FjM2loSXh2TEVGTXptalFaa2wzaktvMFQv?=
 =?utf-8?B?SXk4NHMvbEVBZkp1Qkl3bE5lZnZBQ2cwTkx2Q1NyRXFLS1l0UlN5NEFQQmRp?=
 =?utf-8?B?MGZRWS8rMnlwbzlCdVhFQVNkL3BSVzBIYUJqTzA5empzYk9wcDUxUkk5VzZU?=
 =?utf-8?B?bEpndEl6eW5icW9GczljM0h0ZXVnRHJEM3lnek1Tc2hlMUNya01USTd1WDVN?=
 =?utf-8?B?ZWJ6cCtXQW9CZFV1amxoOXVMWjk5ak5pOXJhdWI2STl5K1Uvd1VZWlhiTUFB?=
 =?utf-8?B?R1Q5U3h3T2d0MXIwSERlWWUxTlFDR0R0djIvZGY2UUZTK0RpTHk1ZkxFTWVJ?=
 =?utf-8?B?MVp0MTBhU3RmbGdKekhheGx3WCt6dnFOa0NOcXhxa3NreU1YcnNGUmdqUmU5?=
 =?utf-8?B?bFlUUWRZcUZFcm01QmtlVW9COVNIR1JvNVZoazIzZVVBcG5CdEdVdGZENEdo?=
 =?utf-8?B?eXd0dVRLQXpXcFZZZ2xZMkNUeHJnZXlvd0ZHeElDc3NpMktndmdGc1o3NUln?=
 =?utf-8?B?UDdNdlhLRzhnRnFadzhHSUxSQnFQWVlFdjREc3NscHlTc2tJUllEb043ODdS?=
 =?utf-8?B?enNlajdOUXhLSnRJMWJTSzlQRlRES2lEM2JCN0swd1pGT2FlQld4VGh5QmpU?=
 =?utf-8?B?WXVTVFN0V2FVVFB6Vk9PY25rMzY0M1g0OFBneTdXVzRneXJVbUIyaHAxOVNC?=
 =?utf-8?B?MWdMNm5ESkJxd1N4MTd3T0lzcDc1ZnZ6QnlCZVZqYWFsVWh0UGNLa3ZnOGlG?=
 =?utf-8?B?ZS9KMXYxemh1QTZCSE5hYkt4bEhRcC9ZK1M0clR1dWtjZFZ0Nkcyc3ZKRUZp?=
 =?utf-8?B?cjJXZlFNTnBPSFJzWVZuVEFCcm5TVmZkWCtDUkdabk53dFdOamg4WnZ3NXJo?=
 =?utf-8?B?K0wzanRLY3VMNTVLMGs0aGhPR1F2UlczZmVBMXhveDRiMTBoallrblFOZnBM?=
 =?utf-8?B?cC9EZVRWOEkwREJKZmJHUHVEZEFhbmRydXVhaE1jaDVBSGRpOUI1bGx2cmlq?=
 =?utf-8?B?S1NnQWdsLzZ2VkJrbDkyQklKSng0VVRqNlFoVHdZUHhzMnlwWUVISWNnMXM0?=
 =?utf-8?B?R3dnZDlmRjF2ZXFZUlNRSG45T1pFZ3FOeGxwcDRTUEI5djJjVklnckUrUzdY?=
 =?utf-8?B?RVVRNW1yZ05oMFVOUGF1SzlJTHhOaXFMWjlMcHhncmp6S0dRSTJVWW1xR1Jo?=
 =?utf-8?Q?O5iDDMSaeW1TD4vfHwp7vILgq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF169CCC12F4C6448F4829ED394CC5FF@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5e6f39-c785-4a1c-e8eb-08dcc7cc3fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 01:45:23.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qgn4HLSkn7KmJE4cOpSAZ5bqzbDpZRdmVNlFQLJnEufDrdee/GYMsndjVje27OlDrkuR4eh83/66hBPmwb2RT8r0PD4qnWuOKnbe1DUmIow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547

SGksDQoNCk9uIDgvMjgvMjQgMDA6NDIsIEFsZXhpcyBMb3Rob3LDqSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA4LzI3LzI0IDE3OjIwLCBNYXJl
ayBWYXN1dCB3cm90ZToNCj4+IE9uIDgvMjcvMjQgMTE6NTMgQU0sIEFsZXhpcyBMb3Rob3LDqSB3
cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+PiAtICAgIHJldHVybiAwOw0KPj4+PiArICAgIHJl
dHVybiBzZGlvX3NldF9ob3N0X3BtX2ZsYWdzKGZ1bmMsIE1NQ19QTV9LRUVQX1BPV0VSKTsNCj4+
Pj4gICB9DQo+Pj4NCj4+PiBUaGlzIGNoYW5nZSBicmVha3Mgc3VzcGVuZC9yZXN1bWUgb24gbXkg
d2lsYzEwMDAgc2V0dXAgKHNhbWE1ZDIgd2xzb20gZXZrICsNCj4+PiB3aWxjMTAwMCBzZCk6DQo+
Pj4NCj4+PiAjIGVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZQ0KPj4+IFBNOiBzdXNwZW5kIGVu
dHJ5IChkZWVwKQ0KPj4+IEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDU1IHNlY29uZHMNCj4+PiBGcmVl
emluZyB1c2VyIHNwYWNlIHByb2Nlc3Nlcw0KPj4+IEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vz
c2VzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAxOCBzZWNvbmRzKQ0KPj4+IE9PTSBraWxsZXIgZGlz
YWJsZWQuDQo+Pj4gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcw0KPj4+IEZyZWV6
aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFwc2VkIDAuMDA2IHNl
Y29uZHMpDQo+Pj4gd2lsYzEwMDBfc2RpbyBtbWMwOjAwMDE6MTogc2RpbyBzdXNwZW5kDQo+Pj4g
d2lsYzEwMDBfc2RpbyBtbWMwOjAwMDE6MTogUE06IGRwbV9ydW5fY2FsbGJhY2soKTogcG1fZ2Vu
ZXJpY19zdXNwZW5kIHJldHVybnMgLTIyDQo+Pj4gd2lsYzEwMDBfc2RpbyBtbWMwOjAwMDE6MTog
UE06IGZhaWxlZCB0byBzdXNwZW5kIGFzeW5jOiBlcnJvciAtMjINCj4+PiBQTTogU29tZSBkZXZp
Y2VzIGZhaWxlZCB0byBzdXNwZW5kLCBvciBlYXJseSB3YWtlIGV2ZW50IGRldGVjdGVkDQo+Pj4g
T09NIGtpbGxlciBlbmFibGVkLg0KPj4+IFJlc3RhcnRpbmcgdGFza3MgLi4uIGRvbmUuDQo+Pj4g
cmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uDQo+Pj4gUE06IHN1c3Bl
bmQgZXhpdA0KPj4+IHNoOiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudA0KPj4+DQo+Pj4g
QnV0IEkgaGF2ZSB0byBkaWcgbW9yZSB0byByZWFsbHkgdW5kZXJzdGFuZCB0aGUgcm9vdCBjYXVz
ZS4NCj4+DQo+PiBEb2VzIHlvdXIgTU1DIGNvbnRyb2xsZXIgc3RydWN0IG1tY19ob3N0IHNldCAu
cG1fY2FwcyB8PSBNTUNfUE1fS0VFUF9QT1dFUiA/DQo+PiBNYXliZSB0aGF0J3MgdGhlIHByb2Js
ZW0sIHRoYXQgdGhlIGNvbnRyb2xsZXIgZG9lcyBub3Qgc2V0IHRoZXNlIFBNIGNhcHMgPw0KPiAN
Cj4gSXQgbG9va3MgbGlrZSB5b3UgYXJlIHJpZ2h0LCBteSBzZG1tYyBjb250cm9sbGVyIHdhcyBt
aXNzaW5nIHNvbWUNCj4ga2VlcC1wb3dlci1pbi1zdXNwZW5kIGZsYWcgaW4gbXkgZGV2aWNlIHRy
ZWUsIHByZXZlbnRpbmcgeW91ciBjaGFuZ2UgdG8gd29yayBvbg0KPiBteSBwbGF0Zm9ybS4gU28g
aXQgYmVoYXZlcyBjb3JyZWN0bHkgZm9yIG1lIHdpdGggYm90aCB3aWxjMTAwMC93aWxjMzAwMCwg
dGhhbmtzLg0KPiANCj4gTG9va3Mgb2sgZm9yIG1lLCBidXQgb3RoZXJzIG1heSBoYXZlIGEgbW9y
ZSBpbmZvcm1lZCBvcGluaW9uIHRoYW4gbWUgYWJvdXQgdGhlDQo+IGltcGFjdCBvZiB0aGlzIGNo
YW5nZS4NCj4gDQoNCldoZW4gdGhlIGhvc3Qgc3VzcGVuZCBpcyB0cmlnZ2VyZWQsIHRoZSBXSUxD
IHBvd2VyIGNvbnN1bXB0aW9uIHNob3VsZCBiZQ0KcmVkdWNlZCBzaW5jZSBpdCBpcyBjb250cm9s
bGVkIHZpYSBjaGlwX2FsbG93X3NsZWVwKCkgc2VxdWVuY2Ugd2hpY2ggaXMNCmlycmVzcGVjdGl2
ZSBvZiBNTUNfUE1fS0VFUF9QT1dFUiBmbGFnIHN0YXRlIG9mIHRoZSBob3N0LiBTbyBJJ20gbm90
IHN1cmUgd2h5DQp0aGVyZSB3YXMgbm8gZGlmZmVyZW5jZSBvYnNlcnZlZCBpbiBNYXJlaydzIHNl
dHVwLiBJdCBtYXkgYmUgdGhhdCB3aGVuIHRoZQ0KcG93ZXIgY29uc3VtcHRpb24gd2FzIG1lYXN1
cmVkLHRoZSBXSUxDIHN1c3BlbmQgc3RhdGUgaXMgbm90IGVuYWJsZWQgYmVjYXVzZQ0Kb2YgTU1D
IGNvbnRyb2xsZXIgcG1fY2FwcyBpbiB0aGUgdGVzdCBzZXR1cC4NCg0KSSB0aGluayBpdCBpcyBi
ZXR0ZXIgdG8gaGF2ZSBhIGdlbmVyaWMgcGF0Y2ggZm9yIGFueSBob3N0IHdoaWNoIGhhcw0KTU1D
X1BNX0tFRVBfUE9XRVIgY2FwYWJpbGl0aWVzIGRlZmluZWQgb3Igbm90LiBXaXRoIHByb3Bvc2Vk
IHBhdGNoLCBkcml2ZXINCndpbGwgbm90IGFsbG93IHRoZSBob3N0IHRvIGdvIGludG8gdGhlIHN1
c3BlbmQgc3RhdGUgd2hlbiBNTUNfUE1fS0VFUF9QT1dFUiBpcw0Kbm90IHNldCBpbiBQTSBjYXBz
LiBJIHRoaW5rLCBzZGlvX3NldF9ob3N0X3BtX2ZsYWdzKCkgc2hvdWxkIG9ubHkgYmUgY2FsbGVk
IGlmDQpNTUNfUE1fS0VFUF9QT1dFUiBpcyBkZWZpbmVkIGluIHRoZSBob3N0Lg0KDQpBY3R1YWxs
eSwgV0lMQyBjYW4gc3VwcG9ydCBzdXNwZW5kIG1vZGUgd2l0aCBvciB3aXRob3V0IHRoaXMgaG9z
dA0KY2FwYWJpbGl0aWVzLiBGb3IgU0RJTywgdGhlIGhvc3QgY2FuIGJlIHdha2UtdXAgdXNpbmcg
dGhlIGV4dGVybmFsIElSUSBHUElPDQoodXNlcyBvdXQtb2YtYmFuZCwgaW5zdGVhZCBvZiBpbi1i
YW5kIGludGVycnVwdCkgb24gV0lMQy4NCg0KVG8gdGVzdCB3YWtlLW9uLXdsYW4od293bGFuKSBp
biBzdXNwZW5kIG1vZGUsIHRoZSBJUlEgcGluIGZyb20gV0lMQyBzaG91bGQgYmUNCmNvbm5lY3Rl
ZCB3aXRoIHRoZSBob3N0IHRoYXQgd2lsbCBoZWxwIHRvIGludGVycnVwdC93YWtlIHRoZSBob3N0
IHdoZW4gYW55DQpXaUZpIHBhY2tldCBhcnJpdmVzLiBXaXRob3V0ICd3b3dsYW4nIGVuYWJsZWQg
aW4gc3VzcGVuZCBtb2RlLCB0aGUgaG9zdCBzaG91bGQNCmJlIGFsbG93ZWQgdG8gZ28gaW50byBz
dXNwZW5kIG1vZGUgYnV0IGl0IGNhbid0IGJlIHdha2UtdXAgYnkgV2lGaSBwYWNrZXRzLg0KQWxs
IHRoZSBwYWNrZXRzIHdpbGwgYmUgZHJvcHBlZCBpbiB0aGUgZmlybXdhcmUgaW4gc3VzcGVuZCBz
dGF0ZS4NCg0KV0lMQyBzdXBwb3J0cyBvbmx5IEFOWSBvcHRpb24gZm9yIHdvd2xhbi4gU28sIGFm
dGVyIGNvbm5lY3RpbmcgdGhlIElSUSBsaW5lDQp3aXRoIGhvc3QsIHRoZSBiZWxvdyBjb21tYW5k
cyBjYW4gYmUgdXNlZCB0byB0ZXN0ICJ3b3dsYW4iIGluIHN1c3BlbmQgc3RhdGUuDQoNCg0KIyAg
aXcgcGh5IDxwaHluYW1lPiB3b3dsYW4gZW5hYmxlIGFueQ0KIyAgZWNobyBtZW0gPiAvc3lzL3Bv
d2VyL3N0YXRlDQoNCg0KUmVnYXJkcywNCkFqYXkNCg0KDQo=

