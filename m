Return-Path: <linux-wireless+bounces-17572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D961BA12CD3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 21:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223CF188975C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73551D9A60;
	Wed, 15 Jan 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dIkExxss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40801D6DC9
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973764; cv=fail; b=cRJxhbbPoXoiup1dJhC4hxluzEz/L2hxt0bl+pl3U58IUQV1wZRNUoQf8A+RLz4Tov7Met4OdTOCGI4g3Inc6YguLvkVxr8KyTKqOgd9j3hBnmJYa/kNAzrJVfJYBlG0gMPkdKU9F+c1pEMvBJlkI71oOSjLGY4WvkKKnGL9GM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973764; c=relaxed/simple;
	bh=GmFWrwsylnGA+AYBCPA+SwaCajz0nIAoH8YHcmSG0Zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVqEUPV/0bXslfu1kBpJHAvw51gttr3kf1AmjjNfpE1Qa/v97zxotHFBm5biNvUQKC772kfgV9RcXzbSYOGkM35CPhhrThnHXyBeagKMVhaM6ecw3T1KYneRDWpsa5HiwynilwZaZvS75TJfgQkW1yCMFXLQOyTTW/ei/IeU5f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dIkExxss; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVoi8LvuUeSCIuJtQwXVyjJNWKhLzoV9lV/93439faIT8En1Gyr7Qzdbm+H7XySJwEUygrZvyYSAEYFNqDabXlVYs3ffyyP7xj1gMuYIFox2wkdrlrnjwQsRI9wm0yfJt3nkkax0gMuLd0qGu1cSlAet1Z2Gs/iquivHSJd87lZqgJ3EwqVuQoMMyQI68OSpxovTxDO563sBXowJNhLq4IzkrdtG9A5pi71mqRGJQKm5f6eWlmeAoeCjgwz4nDlHtyw4WRpjYXVCndMe9BkaelGUrMUBd/kF7apsyGAZa6Oc3igvDKGyZjE6Y9v4Jg+s2SluZx8sQBiaqpiO80LtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmFWrwsylnGA+AYBCPA+SwaCajz0nIAoH8YHcmSG0Zg=;
 b=oOOUNwlzHwXjaDsj0baBzNyWiwvGkEDSgx3q6IL6efzvEVV8KLiJEv7YW7Aktb3HekpaR88k4TZ91WIOvhsOoJIAMWsxLXoY+fFuxrEBc0IPxDegMaTPlcgMjNAobmjyJV0yMyTnDE3ANXJWy2XB1/Cpkyp0BKpYiejfcfC7KI/rL5bHjTteUhU/PGwTAJEqAqkMXhmhoK06xT2M4axJreWDEp1Uzfd/u+d8Li5vaudOyXb1Lyz4MPaqbSesz6JLw0XvImh7TqaQ1gDX4pmSl5DMNuZhOsvgFVsjUTPFpmhcP6f1Fie5A+oiaPjNFJl4s0SCfH4rxeWZU585iRvm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmFWrwsylnGA+AYBCPA+SwaCajz0nIAoH8YHcmSG0Zg=;
 b=dIkExxssI4NIvhZjf67kdfzenav95tln9P/6pnRqDPZaPebDpZPcf8K+t6nPJDPFJk7iQV1t2t3/LN14K34ox7ki2KeyLZ8OLgskHqifds6/WPQKIxtJbAFa56JhLLt65uNs5TQWYFx/0DUGD7H+h1mnEehc3i1/6pW91f7BQ4RiYJUDRvhU2ND63f6ozczi0rui9Qwe+6ft9VvL0S49pp/eaSqSe1y2nd754BBZ7wy8hKVf6bmisIq8+cnJiiWh2ocdvoJo4G/1Dg7kB+M++HtHTxgb75ZH3pzbC3N+44t+/ufTpL2+yT7Rgb4Frx43W42N96yCUZx+ESqsnQmZDw==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 20:42:39 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 20:42:38 +0000
From: <Ajay.Kathat@microchip.com>
To: <dmitry.baryshkov@linaro.org>
CC: <linux-firmware@kernel.org>, <linux-wireless@vger.kernel.org>,
	<kvalo@kernel.org>, <alexis.lothore@bootlin.com>, <marex@denx.de>,
	<Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Thread-Topic: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Thread-Index: AQHbZ3GKYuBJrtYZzkyipv/0jszdjrMYOPoAgAAUJwA=
Date: Wed, 15 Jan 2025 20:42:38 +0000
Message-ID: <8e893af6-4219-4059-ae32-26a42f6f075d@microchip.com>
References: <20250115171751.7308-1-ajay.kathat@microchip.com>
 <ismsffcidddb3dqr54mdhzsxrwpqfvsauq77fmuzsekhnxyeb6@3imjhwdg34fx>
In-Reply-To: <ismsffcidddb3dqr54mdhzsxrwpqfvsauq77fmuzsekhnxyeb6@3imjhwdg34fx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CY5PR11MB6438:EE_
x-ms-office365-filtering-correlation-id: 3158d3fb-1b39-4b02-9289-08dd35a52635
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejVINlRITU5BVjBGbG1DcE50c0o1VUw0UHdtTkFhYk96M3ZSMVhFa05uOEhq?=
 =?utf-8?B?cUlTQ0xTd29wUDViaWhJN1ZRRnh0bEVaY0tPZXlneCszUmlqeUVna3RZcHYr?=
 =?utf-8?B?NldYaXJXTlJlREtaUGQwZFhVTVNDOGd5dXdrUXRPL1oxeHAxV082VG93UVlI?=
 =?utf-8?B?eHJiMGF4cDlGbXVjL1RrUkdKUjYwZDBlWkZUWEdjNmxhU0pld1N3RW9aZkRI?=
 =?utf-8?B?MFJVclNLRFdoWGw2RkcxUXVQV3BYOFBaMmhlQ2QzQ2pHTDlld3lFMTFOcVc5?=
 =?utf-8?B?bDA0cnZyTUdSVTJlZGs2UUJkbDVzVStlNkwrVXBjSGl2cXZseTFWanp6eHdV?=
 =?utf-8?B?Y2FVU3F0TEJyVFp6UWgyQ1BPRjhHdmlta2c0MVZwNHpTcTY5WENMVk1Nb2hn?=
 =?utf-8?B?RVlpYWY5NjdtWFR0T3UrS1Rlem1iQ1VwQ0x6eEV2V2Q0NEVGNHpNdGhOR3BH?=
 =?utf-8?B?d2R6QVplYjJHNE5GMUxPK2hzeENHSDZ6YXFhYUpLMG9TcGNRbzhkaVFjMVA3?=
 =?utf-8?B?WkpQRC9EZEo1ZDNpVFFvU2VtVmRhQkVibXkyd0VLSEVXR1gzaUJmUm5JT09C?=
 =?utf-8?B?MzlBK1VXRnNza2tGSm5FRDIvdEszclBXQVdWamNtVmMwc3JRVGJYaERtM015?=
 =?utf-8?B?TG13SC9QVmE3MUlXRDZWKzJwZUl1WC9DSVZJci9XcWtqOC9mUnRBR29hc0lU?=
 =?utf-8?B?TGVJQVVwOFVLQzRFOEwxL0JBTkF1ZExFNDJ3Q0NDd2ZhamE0dit3aFlIUDYy?=
 =?utf-8?B?aUltckttMHNqd1NWTE4yYUlIQjF0M2xxb1dOOTNCQlBycWJvWXdBdC9ySjRq?=
 =?utf-8?B?a2JjdHhVQ0hBUXE5Zm56RjlRemdVamVUOWJtL2dhVjQ2ZG5mUzNlRTBRZHNZ?=
 =?utf-8?B?NkN5ejc3MjIwcDlRQXRMRDZEcEM2UWdZTEUyZzN3eVlKR053RTlmRU92cVhT?=
 =?utf-8?B?dzVVVTF5QVR0WTRJRTVVVFU4Uk5tbjc5U2FYVFJaTHNvM3ZuTVBrVjhqVEN1?=
 =?utf-8?B?NlNiOHZwZmNNTnZpZEFBZ3l1emJYOU1WT0pKTzkxZ3pPRlRLbFF3ekFwSFJR?=
 =?utf-8?B?LzJIeGxsbzhZOEFHc25CYzlseUY2WUR5eXl6VElMSDU0MkRyTmZQSGhmSHht?=
 =?utf-8?B?MzFrYmRaMDRWK2pkMEVhZy9aak5ZbERNTjFtWmwyUzJIMlFZNmVKQXBrNGdX?=
 =?utf-8?B?WGc2TDhuK2p6QVZNdDkvb01VUlBVMnNpMGRzd2xWa1hDeWk5S29uTktXMGVO?=
 =?utf-8?B?ZWx2NkJjaTFOT2FYd1U0bHNBRnBqU1ZvUnIzeFdFSTFaTlB5SDA5TXB2R0x6?=
 =?utf-8?B?eXZiWk9vWEt0djFzdFlWbnBsWkdaUElENHArYzdTY3krMEtuWUxuZU1NcFF2?=
 =?utf-8?B?QStoMEJSZDB0U0J2Zks3RnZpaGc5cUR3M2RmZXBERS9jVkpXWjVVbjBmaUN2?=
 =?utf-8?B?TDdXSjIxdTZaeHJ3eXZLUndrNWpodTVZeWF1ajhJOGtlNko0U3p0L2hBRzJL?=
 =?utf-8?B?MklEKzBPM1NMbUEzZFFkQVNZd1ZyL3dCdHpFZU9kVzhaQWRxTHR2bUd0dUpS?=
 =?utf-8?B?d3Yya29yV3habG8vcVoxTVRPSmV0M05EMzBUVkh5ZWd0aEZWb1FEZkdXTUR2?=
 =?utf-8?B?ak8yYzNkd0kwUzd6a3F6TEpmVE10TlNXVzlKallWL3BodktTKzF5bkJzdGdH?=
 =?utf-8?B?RERHYXJseTJlT1A3RWs1Zms5amVUb2p6c3N1bDVYeE9tNHQvNk8xWDB5S0ta?=
 =?utf-8?B?L2JONTZJdFdCRWJ4MmNldXUwV3JNbzdmOE5oZDFzZnM1c1FnL090bU5RK3N0?=
 =?utf-8?B?V0xFU1VsOGI2SFVFZG5ndnpmL2V2RmRIYS9qV3lucXl0MEI4RW5RSGxLenBD?=
 =?utf-8?B?ZWlJZHFpY0FCNGh2Vzdubm5aUzJ3ZzJjbXp2dzhLWjFuS0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkVFZ01RSitPcjhWZW1HV1ljU3J5Ui9ZZWduaFdhZU8rbzJmT2ttbkREYkVm?=
 =?utf-8?B?SGNFMVZFc2tSMTArcjdsQXM5VWwzbTl3MnJRUy9KUHA2QnRWZnJwWUx5ZnNS?=
 =?utf-8?B?OXRKS2tOYjdQMldZbGpSZjNVWUQ3bjZNalRpc0hyeldGd0QrT2J2SWRzRS9k?=
 =?utf-8?B?V2lyS3VHb2JXbkJodkE1ZURZaXN2cks4bkFTNWhKV1VwNGtTY3dVR1Y3ZGhm?=
 =?utf-8?B?OERBdjRLeWc2VEVDMDVDNzFXT0pSZGVwN0hTNkFoMkJ0cUF3RkZnUHBUeXRh?=
 =?utf-8?B?OUpJWjhVVXZ0TVViby9nY1d2c2NubzIyTDY1NVFyeGpaaXdpaHVJUUdzRGtL?=
 =?utf-8?B?T3ZMUlY4V1AvbkppRVBpMVM4c1l1aVNyWC85RHg2Q0xsNHZMc09oT0RWYzZF?=
 =?utf-8?B?eWRlYVZrQXorTnBIMGRkbTR2NWFnbDhIQTdNV29HU2YydzRnV2dCQXFVVEVB?=
 =?utf-8?B?U3RaOFNxc0ZTeVdWVWY1elZVWGdXSmxGVW9QZWVuNWVCekFoYXBkL0p5U0ZE?=
 =?utf-8?B?eHd5QzNtdlhlTUdoY0FnU3dDT2Q3NWZjWWxWN2dWSitBN29HNDlsS3JjZFZJ?=
 =?utf-8?B?TENnUkhMeW5yWE8vSzNNOUdvemkyVzBVOU9SS1MyWFFIdjRQWVQ5Z1UzWW1H?=
 =?utf-8?B?M09zN0hKeDRXcXJwaWhuaHVkdzNaMjQvdmdhK1JQS29sVDFpbGlGZnRTdXpX?=
 =?utf-8?B?TjUrZWZxckdtWUF2ai9wUmc0SFc0Q211TkNpNkdUZUhaZ0Jkd1dLNWRYT2lY?=
 =?utf-8?B?N1NmanVZaHMxWnlkckl0bENURWNGaEc0TEt1T0tWVUR5bDBZeHk5dkd1bnNt?=
 =?utf-8?B?cHl3alN1dk1JRHg1Rzl3aWpyMUdBNGxMMnAzR09iRndZR29Pcm01bjBLZ2Fu?=
 =?utf-8?B?T01JUWlDL29FeVFzdHNVNkZOUUprODR3cVJ4bkNyVy9Mb1NkaXJuNndQcHgx?=
 =?utf-8?B?c3daY0F6aTBTaDNmRDZlRm9vRTlBUDF5RWo3bkEvaDBKQ29DcnVtUFBjSUVv?=
 =?utf-8?B?OHoyMFVCMk9TaHlLL1FzS3ZidDZ2VmdhWnRPOVcwRERwVnI3YW9JRStjWWlq?=
 =?utf-8?B?TSt0TVFCRVFRaVdXcTNjbDhnTDNENCtWVnlCQkNtRzZpM2RHTklIWFRNdlNs?=
 =?utf-8?B?RXhKNjZBQ2VFalVxdkxpckc0MENzOGlBSVp1eXFybHpEQklEYklSeWZobWhk?=
 =?utf-8?B?bE9FN1IrNDdHL2FLSEJEbUdvV1QxcEhIREZxdUV5cVY1V1VsM3YyTFYwdUN4?=
 =?utf-8?B?Zy9EekRrM0pUQjFya0dwWnNOLzRtZkR4WjZYT2ZpSWlaa1ViNHN4aDVVZ3d3?=
 =?utf-8?B?YWlDblFpbEhBTG9FdUFpWWJVc1MxRFFIb3IzNU45dFgrZE1nRExzWHREaWo0?=
 =?utf-8?B?ODU2QnhoblY5U1k3d014NDlXUTZ5d3E3QWNjdDBzM3hIdXBRWFRUMEpyN3k1?=
 =?utf-8?B?R3lWTDJ5Y1JJMG9kYXpZc3UzZFd1dHgvWTcvTlAvL0NUM1Z4QXVwZEwvVzhn?=
 =?utf-8?B?NU5FeVd2TjBQYWtUUi9ULytQNUJnVE96dklqeUNHUDBFMjFkWXhnN01QK2Qv?=
 =?utf-8?B?cktaQTUvblV3YXlnOW44M3N5bnlOTVZvVmlkT2REVzBBSTRMQTdXcEt6K0gw?=
 =?utf-8?B?TUI5aytDUjZjQWFkTENseXZjckVqTk5qc1NDajlKSnVHYklCQ2pOSTU3enFk?=
 =?utf-8?B?OEM2NjhvNlVmdHpHc0V4K1NRd3ByWUd2bEFVd0x0WXVwV2R0d2JUSWZVMlAz?=
 =?utf-8?B?bnpiWDQycWRnZXFtbFNBcHhlTUs5d3ZpdGxsd0E1TzlUWlY3bEtuTTJhY1Ex?=
 =?utf-8?B?UWtzUjhFVUxoSmlNd1BxaHlGanRyMVdqcVZSQVRZeHMvenMwWnhURFZjVm5L?=
 =?utf-8?B?OU1iaC9NdCtZZmVnby9BdUtmaFNZZXdEeHJ5azk1NFgwdFA5a3JDOTgyWlpq?=
 =?utf-8?B?Wkl4Yy82R3dkVjgyWTM3WWh4alB6Z0dtRjRQbi9SSWdBM1RoNmRTNElhZ3Ez?=
 =?utf-8?B?bVFVWGVCcDBZb1NQZDJMK1p3V215L1VpV2R6M01jaHJzSE9OaEVzZDZXaXBp?=
 =?utf-8?B?aVpubzh6U0RSWXNNUmxiYVE1VWRaWWo5cUN1ZjBGS3lURWpMWHVQczFMdXYw?=
 =?utf-8?Q?pUvx2g2vfVB2iqcz4sKV0D+fz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <868AFB84F603A24E942E62FAD26FC1C2@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3158d3fb-1b39-4b02-9289-08dd35a52635
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 20:42:38.3232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRSDI0grpinbIJoY7reXmOFbhkUvIuettUla+zxz9SMBLh6WwL5dAL3VnIWc4diQM/pUh1P2AWjjTcjAST8ChtbPlua8O2k/NW3J4Sm4gjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438

T24gMS8xNS8yNSAxMjozMCwgRG1pdHJ5IEJhcnlzaGtvdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEphbiAxNSwgMjAyNSBhdCAwNTox
ODo0OVBNICswMDAwLCBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gVGhpcyBj
b21taXQgYWRkcyBXTEFOIGZpcm13YXJlIGZvciB3aWxjMzAwMCB3aGljaCBpcyBzdXBwb3J0ZWQg
aW4gbWFpbmxpbmUNCj4+IExpbnV4IHdpdGggY29tbWl0IFsxXS4NCj4+DQo+PiBGVyB2ZXJzaW9u
OiAxNi4xLjINCj4+DQo+PiAxLiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMD9pZD1lMTQwOGMxMTVlZjliDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIFdI
RU5DRSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKysrLS0NCj4+ICBhdG1lbC93
aWxjMzAwMF93aWZpX2Zpcm13YXJlLTEuYmluIHwgQmluIDAgLT4gMTQwNzEyIGJ5dGVzDQo+PiAg
MiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+PiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGF0bWVsL3dpbGMzMDAwX3dpZmlfZmlybXdhcmUtMS5iaW4NCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvV0hFTkNFIGIvV0hFTkNFDQo+PiBpbmRleCA5MjBkNjA5My4uMzg0MmJl
ZDcgMTAwNjQ0DQo+PiAtLS0gYS9XSEVOQ0UNCj4+ICsrKyBiL1dIRU5DRQ0KPj4gQEAgLTU3MTIs
MTQgKzU3MTIsMTUgQEAgTGljZW5jZTogUmVkaXN0cmlidXRhYmxlLiBTZWUgTElDRU5DRS5udmlk
aWEgZm9yIGRldGFpbHMNCj4+DQo+PiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+PiAtRHJpdmVy
OiB3aWxjMTAwMCAtIEF0bWVsIDgwMi4xMW4gV0xBTiBkcml2ZXIgZm9yIFdJTEMxMDAwDQo+PiAr
RHJpdmVyOiB3aWxjMTAwMCAtIEF0bWVsIDgwMi4xMW4gV0xBTiBkcml2ZXIgZm9yIFdJTEMxMDAw
ICYgV0lMQzMwMDANCj4+DQo+PiAgRmlsZTogYXRtZWwvd2lsYzEwMDBfZncuYmluDQo+PiAgRmls
ZTogYXRtZWwvd2lsYzEwMDBfYXBfZncuYmluDQo+PiAgRmlsZTogYXRtZWwvd2lsYzEwMDBfcDJw
X2Z3LmJpbg0KPj4gIEZpbGU6IGF0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUuYmluDQo+PiAg
RmlsZTogYXRtZWwvd2lsYzEwMDBfd2lmaV9maXJtd2FyZS0xLmJpbg0KPj4gLVZlcnNpb246IDE2
LjANCj4gDQo+IFdoeT8gWW91IGhhdmVuJ3QgdXBkYXRlZCBvbGQgZmlybXdhcmUsIHNvIGl0IHNo
b3VsZCBzdGlsbCBiZSAxNi4wDQoNClRoZSBvbGQgd2lsYzEwMCBmaXJtd2FyZSB3YXMgMTYuMS4y
IHRoYXQgZ290IHVwZGF0ZWQgaW4gY29tbWl0IFsxXS4NCkkgbWlzc2VkIHRvIGluY2x1ZGUgdGhl
IHZlcnNpb24gbnVtYmVyIHVwZGF0ZSBpbiB0aGUgV0hFTkNFIGZpbGUgd2hlbg0KcHJldmlvdXMg
d2lsYzEwMDAgZmlybXdhcmUgcGF0Y2ggd2FzIGNyZWF0ZWQuDQoNCldpdGggdGhpcyBwYXRjaCwg
ZmlybXdhcmUgdmVyc2lvbiB2MTYuMS4yIHdpbGwgYmUgYXZhaWxhYmxlIGZvciBib3RoDQp3aWxj
MTAwMCBhbmQgd2lsYzMwMDAuDQoNCjEuDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9maXJtd2FyZS9saW51eC1maXJtd2FyZS5naXQvY29tbWl0L2F0bWVs
P2lkPWNlYmFmZDM4NDY5ZDFjYjU3ZDk3MDExYjM3ZDIxYjI0MWVkOWExNTYNCg0KUmVnYXJkcywN
CkFqYXkNCg==

