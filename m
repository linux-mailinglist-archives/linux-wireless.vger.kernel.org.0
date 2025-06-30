Return-Path: <linux-wireless+bounces-24662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF3EAED7E3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 10:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4A61700F8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB823B628;
	Mon, 30 Jun 2025 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="MnIxZ4hE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021086.outbound.protection.outlook.com [52.101.70.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077152253AB;
	Mon, 30 Jun 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273688; cv=fail; b=gFkyxJFCWG2SsTLIFwNPOFgP9ZSiQtmuxj2F/lI2PTxu/hfrmBnLidAnbO7F6ydx6NA5wJEKRf7yNADdqmqejXryT0yQdLE0zS6d8q1EDjesLdGvvkqK6ygsxfZsKRPqVOf8MSfoLuPk1yA3eLsKQmKQe2jOMYSEgdrg3I4tLfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273688; c=relaxed/simple;
	bh=QrO1F3GZWn76r4qFtWlLvJY43EzUw71BlSJJjcCRz0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dxiswy5M8nmHgxy3JRkkBQ/sr7zC/o9AC1QZqtlHwSIo6Tv2FRBGBblU0LMr7+Sxdo4hAZxjXikOM2XkuwK0s7RMcVzchCpqZ9vzCvz8ro2RGefOH4hVqcdhXcJDmvcbrd6+2Gh/9BYB31+Dx9Fqhjed9WCjDWh4PYMK9s9Q19k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=MnIxZ4hE; arc=fail smtp.client-ip=52.101.70.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFTOlMrDdVmX4BCo+a3m/Gy+68VjwplO3AwAlgi9fHM0WQj2+927mn1ykUKEcHp3aE8r7arAg+HFdnliNWq4uHLwdC+0dNS+GGgtU8sYLgOfCSGUmWk/Looj6Wx50IRTXBOIGz3nexIChJd1ZDlalAFPKDondL2b2kfqLMpxfhh/RHKpnZW3Dp2zch8KcNlZJXIOHH149Y4LfyWd5Wugns149HYtED//D8svpzL/xFAbfVmKi3D1UQfikL+dMvgNazIVClLPSH9IUlbyVMiSbcybJkbzlifGXkCDa/E+STXd97jRD7mSHw4q8ncOVAGou2Y5iZrGga74QNwYsFHErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrO1F3GZWn76r4qFtWlLvJY43EzUw71BlSJJjcCRz0c=;
 b=BbR3oMqPDXHEXeT5L6EM/zbRfrL74Rjgpq5yuPYwI5c3p9OqQSskaqUeRXfUo7Txb1Fkn/o4sy7uSDM6XhheIJiSiXRpf0LFajye/mnPKGdqAc0cXtiA1PTZU1uM34kIIJp/bFNdLxcVoBf2/wG+QGMKkweJcEqgEMyzVTsuA+zlDjhxqBg8CMjv3c/TL4IAtGNFfrdnPVzT2rOFqEKYi9TrfY+J9psRyjclO/citFPW8c6ndFU3S9aqdG22fDVEPxR7bQu2lGDkMeMJ5fPVASVpdsnSKS40nmJhNQbliHvRgcQzXEVx9dghuNqPSeb4M3D5XrvW+a4AMjzufarg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrO1F3GZWn76r4qFtWlLvJY43EzUw71BlSJJjcCRz0c=;
 b=MnIxZ4hEtZwwO1dFoIOhcGzzir4aKXiIT6bLUbF2PKTo6hUITIVXSXCKpd8AfVMnR7TzCPmxUTetqT722bVeWMBMR84ZM/g7fUBzjDQLialimljsIsMDjMdhnNN6CrGOW/3c0xGJIJA+pR5Ve5b0xMiIqO1D7/brPg9jt6S8VFQ=
Received: from PA4PR02MB8169.eurprd02.prod.outlook.com (2603:10a6:102:272::8)
 by GVXPR02MB10781.eurprd02.prod.outlook.com (2603:10a6:150:158::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 08:54:37 +0000
Received: from PA4PR02MB8169.eurprd02.prod.outlook.com
 ([fe80::f600:6ace:3615:4b7b]) by PA4PR02MB8169.eurprd02.prod.outlook.com
 ([fe80::f600:6ace:3615:4b7b%3]) with mapi id 15.20.8857.026; Mon, 30 Jun 2025
 08:54:37 +0000
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martijn de
 Gouw <martijn.de.gouw@prodrive-technologies.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 ti,rx-gain-reduction-db option
Thread-Topic: [PATCH v3 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 ti,rx-gain-reduction-db option
Thread-Index: AQHb5qRktPPCv2BaaUajYzoHlemwtrQWl+kAgATI74CAAAp3oA==
Date: Mon, 30 Jun 2025 08:54:37 +0000
Message-ID:
 <PA4PR02MB8169B60435DC350BF0AD49E1BD46A@PA4PR02MB8169.eurprd02.prod.outlook.com>
References: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
 <20250626141242.3749958-2-paul.geurts@prodrive-technologies.com>
 <20250627-helpful-venomous-tanuki-3bca5f@krzk-bin>
 <20a1e8cb-17d1-4d69-a859-7d18746d6b64@kernel.org>
In-Reply-To: <20a1e8cb-17d1-4d69-a859-7d18746d6b64@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR02MB8169:EE_|GVXPR02MB10781:EE_
x-ms-office365-filtering-correlation-id: 9cd2df1b-7147-4fc4-7581-08ddb7b3be3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzZCQVpDZzU4VzZqY2c5c1p3ODhOWVVHdmg1dkk4SlN6a0FDZStUY3V2TmtL?=
 =?utf-8?B?Vzg3NTFXNVRmblBORWo5bVkxTGl0QzA0ZzVJamRORmI3Q2NoeTVnMGZKeDlh?=
 =?utf-8?B?SlpCOW5qQmQreThBSHdSOVpMaHc2MXArblFkbUY4MFlCQmhZMlJBbzI2eXFo?=
 =?utf-8?B?dGtqRUt6TUlGZTdXZW1sWWpYcm90L3ZzWjhqOEFsdlBlR3pLeFluNFgyS2d6?=
 =?utf-8?B?NDA0bjdocEphZTdhNUpYRitnYUNuY0FNUGtpV3U1UHZNckVlUjk0TmpENnJF?=
 =?utf-8?B?Ry9sWWNtMDg5VmFpdHZDWEM2WGh1YW14RnBGZWk2clFMQjE1UExjdU9Xc1Rn?=
 =?utf-8?B?bndZcmJjODdZRUlLc29VUDF0U2RSQ3VsZEJHTVhEbmZJSVMrS0VxbHd6UXRO?=
 =?utf-8?B?ZzVrUStWTndjQkp2R2haSmlubVV4cUhxOUZGMERheFhkQU5pZXp5aVFyMHFL?=
 =?utf-8?B?NHlHTlZSRGtKMGpBcmgwUkI4c29Gczc5Z09GNU5EalZ3RllWZXpOMzF5enhn?=
 =?utf-8?B?WHdkN3hOSkNyRktvNnYvVGtrblJoQVduUkdnYmUzNWFPTndkOUN4enJnUytp?=
 =?utf-8?B?SzZxSnNPZTM2TzRERnBwRUhTWExZdVJJa2M5bHduOHlCcTRMdENUZHJaTGVO?=
 =?utf-8?B?cnl4bDRVc09IQWt1UkUyd2RleHJUWXN3a3dSNyt2elZjMk94K0htMUlxaWk0?=
 =?utf-8?B?dDZ4MGsxdCszZXZybVE3aXEvSCs1ZTlyT1ZUdWloOHoyOHQzaGpVbWQwMW8v?=
 =?utf-8?B?NzlGWW5iUXNhcUttTU9MRE9jUWhySnVXTG1FbmUxWUVqL0ZKcmxUbmQyVW1j?=
 =?utf-8?B?cXQzYnJ2U0U0bitIMVZtRnVQV3diWWlKZ0NQeDRPbm1hT1dJNDRWOGJqME9X?=
 =?utf-8?B?UVNZTGhzbWNNeGlWeGtTNXhncWNBREtTN05Wbk53YW04YjNUVy9sNkxTQ21L?=
 =?utf-8?B?aVBDcGNtS1BJcTJlSVdLRVRXWEgxRElhNVJpbDhDQ1ZoU3c3YVVyaFpzelVk?=
 =?utf-8?B?TmNxR0ZLcjgvNktuOXBKdVhndnZaOVVZOGErOEFGNmJEZFVOZkhtQkZQMmQ1?=
 =?utf-8?B?Q3RyUDNYNXk0VWpaT2pJcUFSTlQyMC9rdzJYU3BGa1RYZnVnM09MQkg5UGRR?=
 =?utf-8?B?d3BoenErTEplQUNKOU53ZmRvUXZGbjBpUlFoL2ZJSVFPRHBUTmZEQXJ2NFRx?=
 =?utf-8?B?SkZoSWtHMTZGRXJPalE5dmRLc0twa0lLUk94Y3hhZlJQWSthNnpwVDdPZkZ4?=
 =?utf-8?B?L3BuTWdqT2o3Y3o3SDlMV3J0VDdJdXZNWGk3Z1M4dzh5R3ZUMWs1VVV4TSty?=
 =?utf-8?B?ZE4vd2FyZjd4VmxLS3pnd3BQWGdXN1dia0FOcmlBbWFrSDREZXFmNG56T2J0?=
 =?utf-8?B?QVBEQ3lhU1BGMmpsZVlGMlRUSW9qTHMyLzNhYUEzWWZUUFJCQnVRR09UQnBK?=
 =?utf-8?B?SlEwNHlLb1p2MkRsSk1UbTdjbGFxTllmTDBBZ3B4aFl3Nk5hRWEvR2NNL1pq?=
 =?utf-8?B?Z0NlV0ozL2FuUWZOdE5QTzc3TlEyY0t5RmRSYkR4dytXbXdUdmtqVkhpOXl6?=
 =?utf-8?B?MFVVb21PRkErL2J5aXl0TDBNQnRRaytOcko5V2F2NXJtUXB1L3pSM2UxbTFj?=
 =?utf-8?B?cFNYNjdqRUNrWGdDWlNoTDZ0ZlVRekJlNDFoMXIwQU1rc2FkT1A2MlZ5cm9h?=
 =?utf-8?B?QmIvRGw3SDhqUk5LV3c4OGxrV2V3NnNYYlN5WG9DVVc3Sy9BL01BeVVlb1I3?=
 =?utf-8?B?VVZPV00xUGR0MkM4bXE5L3RCdEx5NzJaSE5OYlU1aUgvZ2lxdmdpZVA3WGtE?=
 =?utf-8?B?eTdiWkxWdU04ZGNLNFhRSXFFVVUyem5xWnk5Z0VscEpQR00yUHE5ak9PQUsy?=
 =?utf-8?B?QnpvN0JlVHMrQi84UWNoVGNtSVFqSllqUjNRSFcrWTBib2xSZHhEbklnWHRo?=
 =?utf-8?B?QnRoTHl4em8vdGlVRjRhSjZ6Z1dQNWpMRnNzeFJtLzVyY1RaeWRlMjNVRWo0?=
 =?utf-8?B?TjM0cDFnNm1RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR02MB8169.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0hlQ2xGbDBIbkFiQmZUUWVKU1RtemYrbFYxRzNUaHBlZzczVm56d0RhSmQ5?=
 =?utf-8?B?R0VaTEF3bWdwb3BHMHN6bFlBeHd6bHB3dG9UeXU5YmpxRUFmd203cHJNa0w0?=
 =?utf-8?B?ZWo4QjQ3RzdUMkdadXdoR2czanJ0aS9xb1Z2azZWWFdXSDlNc1NuOG16WkVF?=
 =?utf-8?B?VTBVRFBUOWZ5a0RLUGFsSEVUMWpucklsYjZKbFZVT0RUdXVaVGNaMERGc0hv?=
 =?utf-8?B?S21PdXByTjRqeG5FTS8wbXBBMXY4d0JGWHh4dGhmWTFKS2FSeXV4SGxKTDBT?=
 =?utf-8?B?bmx4YWNQS29QS3RkbGpES29PRldyVlJ6cFV0LzVnZXhpNm5KV1pCeU1UalVB?=
 =?utf-8?B?YTR4TmdRdGg5dUVBSHhYMzBiZjArMzhiTzIvVzkxakxsVDNvTHNFbU1oVHho?=
 =?utf-8?B?R0dtQllIS2k3Ylc3aGE4Y1QrNGVQQ2FhRngwc1h1TTBza3ZGazZ0alEzTnR4?=
 =?utf-8?B?OTkzZGE2Rjdud2lYcVloeE5ITXNPL2Nab2kxVi9jZWtZaWMveHhEZ0ZjenY3?=
 =?utf-8?B?YWpTZ0lLR3NPcUVqdzBwVnRxNUFRaFg5YjJMbXNFMGlCS3lINzdBcGpiU2RL?=
 =?utf-8?B?Sk1TUFpUZnNjRHRzaW04c2dJWjZLbXdQb3l4UEZPMWVSVlpTRm1pZGIvZk45?=
 =?utf-8?B?RHUwRjdORGpRM2N6dDl5T0tTdEZJVDJhU0JteTRrcjhNTjhkUzBKaVdSc0pN?=
 =?utf-8?B?b2w1NEZnNzNjMWoySnVxanpUR1dybUw0cDZCMk1mamxVWEk5b21DU1lNT3A0?=
 =?utf-8?B?Z09PaFQ4bmVlY3pBd2h4ejNtTHFvK3Jsb09XU3FkdkhYQXJUM1dEckxiYVZJ?=
 =?utf-8?B?eTNmdCtQdTN3dHVIY0F5cG9xeHF1ZHFCWlYxSjZ1NjVtQnhyVFpiYUtTOEFr?=
 =?utf-8?B?eVdEYktKdVF3dWR1akU4RU40Y3hNc2pWMzFaV3p2WFZmMkVOTlZmUDF2ellr?=
 =?utf-8?B?TVlwMGNHYnp1RUdDZy9qUjhzdlBUdlU4dlB2MzFCQ1FPcFV6Q1VSVnV3Tnls?=
 =?utf-8?B?bndaVUJBRW93d1RVTDZVODhSS3QwNWszT1VsYk1IZndidmVROUJPWkRWOGNL?=
 =?utf-8?B?Q0t6bHhkSDJmOXRINUJzMUZkeGVkdTBYTzk2WENUVFBkZ213cHo4Q01YaEpz?=
 =?utf-8?B?eHVoZEJBSHJRVi8xNlN5MGJsOXFiNVRXaTJzNUdaSFgxcEFjTmhHc2VkaDZB?=
 =?utf-8?B?R0d0djJKTndrd05uZUo1OXJnK1JmNUs5TWVjRmxXL3NpaERRaUtEOTRIQTJp?=
 =?utf-8?B?T2JwNHpJSkZEcHRrTFdSek9zU1hkUm9PNUp4RXVmZFNwUWpXRjg0M2lvRWkx?=
 =?utf-8?B?cnlhM2pOWFV6eFpiOUVjY3kzanl6T1FHYzE0bUx1UCtVWXhvSTRxamNDY2Vw?=
 =?utf-8?B?WXYzdEJtZzlsUDJmbVpLcUc3QzhaenF3VkRnTCszYzZtUXd4OFIrQUNIYnJB?=
 =?utf-8?B?YVRVVWJUNStmK0U1cG9QdGsvZDcxbVpnbjJpUjQrSHF6Y3R6TnFUcC9aRXpz?=
 =?utf-8?B?Tzd0N2t1ZzAvblFIVUI3UnpPZFpZdlFwc2prSFJCYlJOenJlaVdDYTJDbUlp?=
 =?utf-8?B?bjJ3U0dqUXJWaG0xVlRPVFFjQjFnNURmUlpXTGE4eCtiTWc2K0ZMVjZ0L0R3?=
 =?utf-8?B?TW00akREUFF3UUIvN3dMb3R2aTUrNG52L0txOHBjYXNqTkY3aHZsMmgwbW1W?=
 =?utf-8?B?KytkTENRYjJwOGtPK2s0VWMwK0VwQVdwOGNPaDJibk50NjlTbTZ5VXVXSExr?=
 =?utf-8?B?K1B5YVpVQzR2WEFKb21vYjJ0aGtQUmpwS0dFWHVsd1JPcXVQZk9ZRFlBSFVB?=
 =?utf-8?B?dG9iUlErQ1lybzdEbEowaWpvQlNjSXpocThmZFJCN3VpTE9jRzVVSFRoYXNq?=
 =?utf-8?B?SmRISzh2VTBab2s1dWJpOUR4RS85Q2JyeXM1K2xuQ3RGK1RIakFVZ1NwS2x5?=
 =?utf-8?B?TFlHeEFwMlNKOFZLMENrYkxVclRpVXVqN2lhMUhWbUNVNkFEN2t5OEFiRm9k?=
 =?utf-8?B?cElMN3NzY1NnV09YTlpZU3Mvb1plTmxQclFlWS9DUmVVdWkwb3pmZzFkbHBz?=
 =?utf-8?B?TS9DLytFb29VQ3lIMGE4Q1Q0ZXJoNDVya2d3NFRXaXdnQVdvd2Q3NE90Rjl5?=
 =?utf-8?B?VXIyZjRjaWdLTFdGbkVwTW9iNStxYVlCcGNQd2h1eVNUeUFPbnBGbXVtOXlx?=
 =?utf-8?Q?zs/8YG7LtsD7R678XayclaA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR02MB8169.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd2df1b-7147-4fc4-7581-08ddb7b3be3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 08:54:37.5111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYE/PU1lBd6pU3ZMaP/PSRhaCIo4GUKpLrnawlY032GzV0+X0uuRpMnir6os5uVEKjrYmkqtnseI7eTOHVG4xUYN1DIsi1k8V08OyQSepR0UGvI/rkFnYTDi6bHGRE3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10781

PiBPbiAyNy8wNi8yMDI1IDA5OjEwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gT24g
VGh1LCBKdW4gMjYsIDIwMjUgYXQgMDQ6MTI6NDFQTSArMDIwMCwgUGF1bCBHZXVydHMgd3JvdGU6
DQo+Pj4gQWRkIG9wdGlvbiB0byByZWR1Y2UgdGhlIFJYIGFudGVubmEgZ2FpbiB0byBiZSBhYmxl
IHRvIHJlZHVjZSB0aGUgDQo+Pj4gc2Vuc2l0aXZpdHkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBQYXVsIEdldXJ0cyA8cGF1bC5nZXVydHNAcHJvZHJpdmUtdGVjaG5vbG9naWVzLmNvbT4NCj4+
PiAtLS0NCj4+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9uZmMvdGks
dHJmNzk3MGEueWFtbCB8IDcgDQo+Pj4gKysrKysrKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IA0KPj4+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9uZmMvdGksdHJmNzk3MGEueWFtbCANCj4+PiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbmZjL3RpLHRyZjc5NzBhLnlhbWwNCj4+
PiBpbmRleCBkMDMzMmViNzZhZDIuLjVmNDliZDlhYzVlNiAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L25mYy90aSx0cmY3OTcwYS55YW1sDQo+
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9uZmMvdGksdHJm
Nzk3MGEueWFtbA0KPj4+IEBAIC01NSw2ICs1NSwxMiBAQCBwcm9wZXJ0aWVzOg0KPj4+ICAgICAg
ZGVzY3JpcHRpb246IHwNCj4+PiAgICAgICAgUmVndWxhdG9yIGZvciBzdXBwbHkgdm9sdGFnZSB0
byBWSU4gcGluDQo+Pj4gIA0KPj4+ICsgIHRpLHJ4LWdhaW4tcmVkdWN0aW9uLWRiOg0KPj4gDQo+
PiBJJ2xsIGFkZCBkYiB1bml0IHRvIHRoZSBkdHNjaGVtYS4NCj4+IA0KPj4gUmV2aWV3ZWQtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4N
Cj4gQlRXLCBJIGZvdW5kIHlvdXIgcGF0Y2hzZXQgb25seSB2aWEgcGF0Y2h3b3JrLCBiZWNhdXNl
IEdtYWlsIGZsYWdnZWQgeW91ciBlbnRpcmUgdjMgYW5kIG90aGVycyBhcyBzcGFtLiBZb3UgbWln
aHQgbmVlZCB0byBjaGVjayB5b3VyIFNNVFAgc2V0dXAuIEkgc2VlIERNQVJDIGZhaWx1cmUgZnJv
bSBnb29nbGUgaW4gdGhlIGhlYWRlcnM6DQo+DQo+IEF1dGhlbnRpY2F0aW9uLVJlc3VsdHM6IG14
Lmdvb2dsZS5jb207DQo+ICAgICAgIHNwZj1wYXNzIChnb29nbGUuY29tOiBkb21haW4gb2YNCj4g
c3JzMD1tM24xPXpqPXByb2RyaXZlLXRlY2hub2xvZ2llcy5jb209cGF1bC5nZXVydHNAa2VybmVs
Lm9yZyBkZXNpZ25hdGVzIDE0Ny4uLi4uLi4uIGFzIHBlcm1pdHRlZCBzZW5kZXIpIHNtdHAubWFp
bGZyb209IlNSUzA9bTNuMT1aSj1wcm9kcml2ZS10ZWNobm9sb2dpZXMuY29tPXBhdWwuZ2V1cnRz
QGtlcm5lbC5vcmciOw0KPiAgICAgICAgZG1hcmM9ZmFpbCAocD1SRUpFQ1Qgc3A9UkVKRUNUIGRp
cz1RVUFSQU5USU5FKSBoZWFkZXIuZnJvbT1wcm9kcml2ZS10ZWNobm9sb2dpZXMuY29tDQo+DQo+
DQo+IE1heWJlIHlvdSBzZW50IHZpYSBrZXJuZWwub3JnIHNvbWV0aGluZyB3aXRoIGRpZmZlcmVu
dCBhZGRyZXNzPyBBY3R1YWxseSB0aGlzIGxvb2tzIGxpa2UgdGhhdCAtIHlvdXIgRnJvbSBkb2Vz
IG5vdCBtYXRjaCBrZXJuZWwub3JnIGF0IGFsbC4NCj4gUnVsZXMgYXJlIHF1aXRlIHN0cmljdCBy
ZWNlbnRseSBhbmQgZm9yIGV4YW1wbGUgeW91IGNhbm5vdCB1c2Ugbm9uLWtlcm5lbC5vcmcgU01U
UCBzZXJ2ZXIgZm9yIGtlcm5lbC5vcmcgYWNjb3VudHMgKHNlZSBrZXJuZWwgdXNlcnMgd2lraSku
DQo+IA0KPiBBbnl3YXksIGxpa2VseSBhbnkgb3RoZXIgZnV0dXJlIHBhdGNoZXMgb3Igc3VjaCBw
YXRjaGVzIHRvIG90aGVyIHBlb3BsZSB0byBlbmQgdXAgaW4gc3BhbSBhcyB3ZWxsLg0KDQpUaGFu
a3MgZm9yIHRoZSBoZWFkcyB1cCEgSSdsbCBjb250YWN0IG91ciBJVCBkZXB0LiB0byBsb29rIGlu
dG8gdGhhdC4gQW5kIHRoYW5rcyBmb3IgdGhlIHJldmlldyENCg0KPg0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQpQYXVsDQo=

