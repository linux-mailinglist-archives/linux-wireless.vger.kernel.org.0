Return-Path: <linux-wireless+bounces-15331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B19CF56E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DBD1F21EC1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232EC1D9346;
	Fri, 15 Nov 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YGwTijab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2317E010;
	Fri, 15 Nov 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701054; cv=fail; b=bEqtZ2/vTU1NeJ78lrcVBxTz0xzLnRxNcwS5B8MkV+DBMGJ0IgEaCtQSe15PgvWe/Ucq6eMxPtuQe+XCc8TFu9thEjgdkZerPNDPoqnjzjq07WRK4tMvoiCwIvRbpocYr5yLLBio87yvyNKqBQuzdBdONowyG070WI+H0G3eYzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701054; c=relaxed/simple;
	bh=ARnuAO+yDMIt1r/en2loBk5LYbzQXvH8i9pkZFSj6SY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrZhoY4JbdBYCPj8rwPyYgOKEKG8HltJrVNDCi/uMG5w9hE5z5h7GrX0sBNzdvUUd7vM6BZWiykl365Rvjg8bVzyfJyhN7nJXziaE+qbuYFOTfQhMVtPaJ+qybroUbaF8uhO2I5Qg/URXfUI5dVot9Vi7qxRREP8O/gCejQbPic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YGwTijab; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo24M7Zm64j0NHqLrrcG5igiTw8npZ4bbfSfXscCffb9l9AU2wAxKnqCRxlkmx1DJEu4LI9M7zBAR3MtBS4MYwLlwP2YfW5NSP5/uS6ipBbWKUW0aVBVI9oNZDIm3hAGa2eNxfK78SKiyMIfWGgwsF/hMXQR8KBJBF6zGTxNiZaR5n2//DScbL39XzQqfeNZ/K3OGzW8LQNCiK/HhSEoHK8Z1b8XZKEofeaz5dL1yJO2II4ramj3ka/bVfY5sgB1ar2vnig9k8lYG/BmENvdpkO+Uo1fWvkUpvyX1g05xEeRpOfDR9zJEIwpAXsgFYwjd7BZHZKRJWM06YqI0CHolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARnuAO+yDMIt1r/en2loBk5LYbzQXvH8i9pkZFSj6SY=;
 b=PbIDF9dhKh0mc8W9Vzlz7hsFFVRTaLzHgwKA2FnANCCV05bS0hgU10y05rOisUgkdJ7iqddZNMoKsls7kbFWYvHFEhITj88Uwco7dAocTZRNKNRAMxe/n7LvBS/zT4CqJxtLRjLj/Vnht0t5fBnnm4kvHBR5uzKr6dQGUZdYOpMjDGHPvUoWdfQUtiDGGuRuknP4P2vws7HWR8OHondHKoLoHy5JRuB+KrjN7f6D++lOen3hxjWk+kvbY24C+cl6u4u0sDUpu65s2CMMOCaaYgnhFbD0Nayuq/d3ZOMYfIqtJqBmBBV9G2EIvu1zRxNmFKS9h/su2828DsfvjiV5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARnuAO+yDMIt1r/en2loBk5LYbzQXvH8i9pkZFSj6SY=;
 b=YGwTijab0R5P2Lsvoh+/FgJp3Ut5IwjddvRnP4VfJmH/E6O4aizRWx5AiUlu4W/OQmDXbI4xIVSzalAqiv2ng+Ta0H9QgBHbantS6rvPV+WBMNSneDznMFyBC39LAgpHb5FRSAjw4eup2sYp+QkPW3jRuibmcH5K8npHjBFe+rDYQu5JAR0mbIOOWkxuVGoyiAqOTO3x3MSuyzLy6w7VvHGe939vmBksb7lcWQaeHWul7P9g5u+CZdAJmuZv+WkF67/qI35R7vWU9GgpL+5zPwP2wdzFHvGrvCN4aYzHr2ef+HSG8/xKCf+6ytaZasBKmg3wOCnnvehOz5VldzqDkQ==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 20:04:04 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%4]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 20:04:03 +0000
From: <Ajay.Kathat@microchip.com>
To: <marex@denx.de>, <alexis.lothore@bootlin.com>,
	<linux-wireless@vger.kernel.org>
CC: <davem@davemloft.net>, <adham.abozaeid@microchip.com>,
	<claudiu.beznea@tuxon.dev>, <conor+dt@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kvalo@kernel.org>, <krzk+dt@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
Thread-Topic: [PATCH] wifi: wilc1000: Rework bus locking
Thread-Index:
 AQHbJCM4zA3Iup70rEyd6/KmT4gyTLKSlkEAgAAreICAAS0qgIAAfQkAgAA1I4CAAA7EAIASZZyAgAQLDoCAAPZJgIAMd6EAgABcW4A=
Date: Fri, 15 Nov 2024 20:04:03 +0000
Message-ID: <b61b5b11-b078-4cf5-bb40-7c3ff8ffa972@microchip.com>
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
 <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
 <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
 <9d20b408-72a4-49f0-aca6-108dfdd65f99@denx.de>
 <16e5c8d7-64ac-424e-9430-b683ae16a34e@denx.de>
 <9888f605-ee68-4bd3-8d1d-aeef247d23d0@microchip.com>
 <fcdfa93a-2db4-49ad-8947-ca43be329250@denx.de>
 <260a505e-53ec-4f1d-94fe-2b71af48f1b7@denx.de>
In-Reply-To: <260a505e-53ec-4f1d-94fe-2b71af48f1b7@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|MN2PR11MB4536:EE_
x-ms-office365-filtering-correlation-id: 54690ae8-58a7-47f7-ac31-08dd05b0a783
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b21LZFJpREF3emZ1b3lTZFpwaU1SWC9UL3pPNGNQNEJyendLREx6R1Rjdmdi?=
 =?utf-8?B?T1NJbUZUbE5za2xvOFFwYkZxMmxwWTNsSTVHRUJlQ08wZjd3R3hNVEFWaDFT?=
 =?utf-8?B?ayttODU0cGZ6RkZvQ1RwanRGbW9LSkxaQWpEN2lkSmU1QjVxMTBnT3ZnNC8y?=
 =?utf-8?B?VHJGM1hmLzg5RFhJdG9nTVR0alliYVVBakg1endEeGRwYTJoTXQ2VWEvQkY2?=
 =?utf-8?B?enF0VGRvbnczbHNCM1pWcDBlTTBKWGVFQlBpT3RTRjd5b1dLTEZoZ3F2K3My?=
 =?utf-8?B?N2RadERmR2MvVmNBYWR0TmI2cWpmUjQ0MGl1WHZlQUpFd0ZNa0FJbWRlbGp6?=
 =?utf-8?B?Y1hOckZzVnM2NllubnNlR3p3L2NBalhkSnhQTHkxUmdKUmpmcGhaODFWQVN5?=
 =?utf-8?B?UVhYcDg2MnRBMHFJZkdHRFIwcm1udUdDZWVqdHZXdW80dnNBL1BubkFrS00w?=
 =?utf-8?B?bVM0VENOZnBEUjVya04rdXFFT0Mwb1R6elhsVTd0b0k0RHlxai9od0VGRkdF?=
 =?utf-8?B?MzVMaXhpZjZzT05MTktwYUNhMCs3dGI0Nzdhb1N5MmUyTGErV1VlZ0lOVld6?=
 =?utf-8?B?T3VyVEU2UWNhSlo5QmVwRVpGVjdJb1A3YktmbGZmUGQvaXY3c0RjM0tOMXBs?=
 =?utf-8?B?dytWYkVOdE9UT25lVW1yTGgxODZUbjZmRWVxa0Y4SU1pMlFPV25HZkU2eGJx?=
 =?utf-8?B?N3JYbXpHdjhlNFZQOUJVRllXN0NnYzkrR3pRTXgrcFp3WlJqcjNTaVVCcXRI?=
 =?utf-8?B?aTNkRVVtbXNXMDRKV2lOZGlMMG1YWXkzcllTNDZZR1JHaXJmYUk3bm90bVN1?=
 =?utf-8?B?Sm9JME5Sako5NFFpSDdvU1ZLSldPWU1tZVpXc2o3aEthMDBhRytwbDRsQ0Nz?=
 =?utf-8?B?bmJtb2JleHdHNzJTNFY1V2E2KzRWeHIzeDg3RWRuN29sRWxTd0txdWZZekZo?=
 =?utf-8?B?L2lmMXF6OHo0aU03Z0RjRkVPanllR2NZamo3Mnd1bUx6RGhPTm9qUTdFVWpk?=
 =?utf-8?B?WDAydkEyWDUzREZKRFBDbXBXSDhjeXNqSHBlVys1SnNOUlBoSkhQNkV2Wm10?=
 =?utf-8?B?dEM2ZngrSkhFREhzODlwc0NtNEJualZnL3AzaTJnVGlMeUVkVElqVTdzZkE0?=
 =?utf-8?B?aVZva3c0Wllsb0RZVDRuSHJCUXcxSjZuMTRrbnkxMStRSitQQml3M081WjZt?=
 =?utf-8?B?QzVhMWowZEFnZStuMHVER0VlaTJaT0lBWmQ4OFFydi82aTZNUVJLa0JEVzJ2?=
 =?utf-8?B?RTJCcitXUys5dnZZTWJQRWdzRnF1T1RJbkxDUTBkUFRpTWpqV0tYOHM1RTZr?=
 =?utf-8?B?MXVFOGVqWFd5RWdEYmFQdjBLaGFTMVA1UG1uUGxPODMzV2pKS2sxeVEreWlP?=
 =?utf-8?B?Z3pGV0xTZDRXeS9yakpwc3hlZVByb0JhNGc1b2ZBY0Z0NVpGdUFFd1RZZDIy?=
 =?utf-8?B?Yk9waG5LN0EwZUl6T0VsZWl2SWN0K1FFZU1XTlFSOVhiTkFaRXpiUU55eDJP?=
 =?utf-8?B?d2ZoNk51L2JlUm9ZT1M3VjdZdzhtMG5LUXlhWW4xQktCajl4OTFGVTZCYzVK?=
 =?utf-8?B?NFVKbkFNTjlEbzlOVzhBQTJoZWgyYXI1WTBDbWhyUlg3bi9aWkhnaVVVcUp4?=
 =?utf-8?B?TzF6UWNXYURtQjhXcjZBNXc2cmc4S3pYRnhiZFZRWFVGY1F5ZC9QK09LS2RT?=
 =?utf-8?B?YWtBdm4vcDFmU0ZCSGFRQUFJeTFmUnlhQ3NLQVkweVFNTVgzTlIxSVlCeWJB?=
 =?utf-8?B?b3RSb1ZuZ3RGYzNuK0JBbWpDcGhXdVhENjRUVmdYTTZUQ2g4Sm5tTmIrOHUw?=
 =?utf-8?Q?7BDOeaHB3N4okAnJlgoY3Y+0K6SU5zqj0bg+c=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXd3RVZXS3BhaHArcHJRMWlDRXdSTXRxRDVRTHlud2tQUldGbVZ3d1d1VE0v?=
 =?utf-8?B?VUU4WDhobU9GeDRka2pTOVlCdExoRS9pSnVXL1VLZlRJSlh4LzNLNTVsdWlr?=
 =?utf-8?B?NVkxOEZzNm1IZ0xVZnB1L2NmV2pQTDMwY2E3NEsxd1ltaDVxZDRIMm1JY2Ji?=
 =?utf-8?B?OFdnQmM3RVliZWE1cDV6TXE0Yml6K2N1RENwRERDUUtpYXhWTCtPU3Q2bnEx?=
 =?utf-8?B?bmxnZUNTeHFwMmU1SHI1YStwRzcwMUt6M3JoKzJXRHVoVzJLRzVuUFRYbDZJ?=
 =?utf-8?B?SFdub04xaEQ5RjAzVWI5Q21GTXNCUHJPTmx0b20yTzYzNzdiTElNODFxWEVB?=
 =?utf-8?B?Ni82N245NERLL2EvQXZNYUMwS1pGWWZ2NGc5MURuQTI2K0FuS0FQWEorUGF4?=
 =?utf-8?B?WVUvMEZrWitmUFNDbHRPemhxc2Q3ajFsVi9LeEtueUtoOFFIaVd3anNGWmV0?=
 =?utf-8?B?YitQY2VoaGNENG9RWWU4VytNRDdxTUJRN2U5VEN6eHp1Uk9zZmJHeGw1Y01t?=
 =?utf-8?B?UzluU2EwZ3F2ZlMvUlNDcTJiMUVnTHMzNUsyRE5UbUdrdFRJL1FBbWNkMFQy?=
 =?utf-8?B?V1JtQ2hLOVFZSEpQREcweUcvN2E3U0VJTWZZeUFDUFdaeXBqSWNQb09IdkxY?=
 =?utf-8?B?V1BpemVGckR0SjVUcUZOZ1hCN1Q0dld5VVg5eUdFSkFvaXJTZFNPQnpVTFBv?=
 =?utf-8?B?aTFtVHMwWDJNb2ZsWFhiUHJUU3c0U3phQk1wL3k1cFJzZUVYU2xsOHlaYTFL?=
 =?utf-8?B?aE5QS1IraGI4UUt1VUhreXJGOWVqdWpmdk4wekZNV2lHVVFmeFBrMkVHeDJr?=
 =?utf-8?B?Zjh4Ry83MGl1ekJzWkdNZ3pnNEFmSEdTcFZZVzVQelhLV0dXUmtSSnZZMytk?=
 =?utf-8?B?TXZuMWFFcndSRmpCTEdTMTZCOU4vNlZrSGZvQjFIWXYrRmk0MDE0S3ZzVWgv?=
 =?utf-8?B?WHdjckFrTjh0NStQcDY3TG1laTdDbVlQMmRIb0ZsY1pVdE8yd1ZEN2RPbTd5?=
 =?utf-8?B?UnBHSlZmVElMUGh6RFVEeTlGalBLRXI0ZTdTSlFPaTIyMDBMaW83VDVYQlJj?=
 =?utf-8?B?cmVqQnIwUEtoVUU5ZlMybWlOV28xeVhkdVFST3FKY0pISSt6amJHTDRmRU1T?=
 =?utf-8?B?bEJxVWlhYW9yOTczdzhheTlTSWU0bjk5M3g2UDJnZnFPdzIzMXN6S3BXTWJ5?=
 =?utf-8?B?VkNQTVpqenRodnVibmhnTFo2WVY1VE80bFkvSWV6bDFUczVZZmEvNUlpa0x5?=
 =?utf-8?B?RGo0cFo1UHNWZ2ZWRURETWpleWJKc2IxRXhqenhQamI5MElpTHhiZ0NnL0N2?=
 =?utf-8?B?UlpXYlllVGZHc3F6SkNkcDZJSWVMaW9MQWxGK2xKZ1VFTnpjcmFQTGI2T2E0?=
 =?utf-8?B?VXBPVWExWFNsbTJsUERxN0QwYnZEajhDYkJkejl4L2xvWDhndmtsUlF5QmFO?=
 =?utf-8?B?SW5TNWJpWWNsM09icjN1bHAwSWk2QTlZRlpvOU9oSGd0QkpYdHZKVy9kMTBB?=
 =?utf-8?B?aFRCNkpzb1VxQWFOUStxZFYwanNMY0xyV0RxVENuWE9WdVNid1M0aUF6YlBU?=
 =?utf-8?B?SHhrSkpMSXl4NWswOFBEdkIrZnZrL1hZTjZkSDBIY2w3ZzRoMzR6NjBIaTRt?=
 =?utf-8?B?U2dXSE52ZkdiRXNBaldtNHd0QUVrTzg5NUZCL1RTZVIyVnZBa3VvQ2RGTi9W?=
 =?utf-8?B?ckVxYk04VEo5M3E2U1ZrY21OSFJSU3g0SG1pQkJRd2VMK0M0dVBWaW5XcDJO?=
 =?utf-8?B?dk1HVHhEd2Ewc25MYjNEZ25td0xWVFNTeW5DNHJ4dEl2ZW5ia3RUZ2RxMzkx?=
 =?utf-8?B?M0N3aERFbDVjUjk2ZWVRQVU5MVJzcitmaHZRMnc5YWJkYVNUNk5DZFN3dHFi?=
 =?utf-8?B?NlNDNVNWOGl2TVkxclpDMWVNbThWOUJ3MWJ1aDBFRjYrd0wxdEdYOVd0aGtx?=
 =?utf-8?B?ZHIvbjZycEwwTHlGNWp6ODVDdi9zS2FreUU5ekhTR1RGK21OT1JkRzB3SkpB?=
 =?utf-8?B?Zlh6cGp0cTZsbFNSWXVUMUtFdk94NVJsUXh4Nzd0WUswMEttdkQveUJQM08v?=
 =?utf-8?B?Q0E3SitrK3dvc3c0YmZXSHhtTitwbFBvNWU0ZWJPSmdaMGU4RFNjenRhUndv?=
 =?utf-8?Q?t1JisfXg5OFw79+1rTnEBLuVx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAEA02C7223A7D4F97DD119DE052880B@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54690ae8-58a7-47f7-ac31-08dd05b0a783
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 20:04:03.9148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMHVHWX/RJB3ounngqBIsKMf8BvLRwS3E41/4NOAxo60+xLbOywBjVbVZSQigLV+6f6jkGk0rzpTy1+L7W9aEMp9h7oIgFCZTmX/LcTGdnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536

SGkgTWFyZWssDQoNCk9uIDExLzE1LzI0IDA3OjMzLCBNYXJlayBWYXN1dCB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMS83LzI0IDU6MTAg
UE0sIE1hcmVrIFZhc3V0IHdyb3RlOg0KPj4gT24gMTEvNy8yNCAyOjI4IEFNLCBBamF5LkthdGhh
dEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IEhpIE1hcmVrLA0KPj4NCj4+IEhlbGxvIEFqYXks
DQo+Pg0KPj4+IE9uIDExLzQvMjQgMDQ6NDQsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPj4+PiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPj4+PiBrbm93IHRoZQ0KPj4+PiBjb250ZW50IGlzIHNhZmUNCj4+Pj4NCj4+Pj4gT24g
MTAvMjMvMjQgODo0NyBQTSwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+Pj4+DQo+Pj4+IEhlbGxvIGFn
YWluLA0KPj4+Pg0KPj4+Pj4+IElzIHBvd2VyLXNhdmUgZW5hYmxlZCBkdXJpbmcgdGhlIHRlc3Qu
IFdpdGggUFMgZW5hYmxlZCwgVGhlIFNESU8NCj4+Pj4+PiBjb21tYW5kcyBtYXkNCj4+Pj4+PiBm
YWlsIG1vbWVudGFyaWx5IGJ1dCBpdCBzaG91bGQgcmVjb3Zlci4NCj4+Pj4+DQo+Pj4+PiBJdCBz
ZWVtcyBpdCBnZXRzIGVuYWJsZWQgYWZ0ZXIgZmlyc3QgaWZjb25maWcgdXAsIHRoYXQncyBhIGdv
b2QgaGludCwNCj4+Pj4+IEknbGwgdHJ5IHRvIGRpc2FibGUgaXQgYW5kIHNlZSBpZiB0aGF0IG1h
a2VzIHRoZW0gZXJyb3JzIGdvIGF3YXkuDQo+Pj4+PiBUaGFua3MhDQo+Pj4+Pg0KPj4+Pj4gRG8g
eW91IGhhdmUgYW55IGRldGFpbHMgb24gV0hZIHdvdWxkIHN1Y2ggc3BvcmFkaWMgZXJyb3JzIG9j
Y3VyIGFuZCBob3cNCj4+Pj4+IHRvIG1ha2UgdGhvc2UgZ28gYXdheSBldmVuIHdpdGggUFMgZW5h
YmxlZCA/DQo+Pj4+IENhbiB5b3UgZXhwbGFpbiB3aHkgZG9lcyB1QVBTRCAoaXcgLi4uc2V0IHBv
d2VyX3NhdmUgb2ZmKSBhZHZlcnNlbHkNCj4+Pj4gYWZmZWN0IFNESU8gYnVzIHN0YWJpbGl0eSA/
DQo+Pj4+DQo+Pj4NCj4+PiBTRElPIGJ1cyBlcnJvcnMgY2FuIG9jY3VyIGZvciBkaWZmZXJlbnQg
cmVhc29ucyBhbmQgdGhvc2UgZXJyb3JzIGNhbg0KPj4+IGJlIG9mDQo+Pj4gcmVjb3ZlcmFibGUg
b3Igbm9uLXJlY292ZXJhYmxlIHR5cGUuIEZvciBub24tcmVjb3ZlcmFibGUgZmFpbHVyZXMgbGlr
ZQ0KPj4+IGZpcm13YXJlIGNyYXNoZXMsIHRoZSByZXRyeSBtZWNoYW5pc20gbWF5IG5vdCBoZWxw
IHRvIHJlc29sdmUgdGhlDQo+Pj4gaXNzdWUuIElmDQo+Pj4gdGhlIGVycm9yIGlzIHJlY292ZXJh
YmxlIHRoZW4gZHJpdmVyIHNob3VsZCB3b3JrIHdpdGggcmV0cnkgYXR0ZW1wdHMuDQo+Pj4gSSB0
aGluayB5b3UgYXJlIG9ic2VydmluZyB0aGUgYnVzIGVycm9ycyBtZXNzYWdlcyBhbmQgaXQgaXMg
cmVjb3ZlcmluZw0KPj4+IGFmdGVyDQo+Pj4gdGhhdC4gSXMgbXkgdW5kZXJzdGFuZGluZyBjb3Jy
ZWN0Pw0KPj4NCj4+IEkgZG9uJ3Qga25vdy4gSXMgdGhlcmUgYW55IHdheSB0byBtYWtlIHRoZSBX
SUxDIGZpcm13YXJlIHByb2R1Y2UgZGVidWcNCj4+IG91dHB1dCAsIHNvIHdlIGNhbiBmaWd1cmUg
b3V0IHdoYXQgaXMgZ29pbmcgb24gIm9uIHRoZSBvdGhlciBzaWRlIiA/DQo+Pg0KPj4gQXJlIHlv
dSBhYmxlIHRvIHByb3ZpZGUgbWUgKG1heWJlIG9mZi1saXN0KSBzb21lIGRlYnVnIGZpcm13YXJl
IGJ1aWxkID8NCj4+IChvciBjYW4gSSBnZXQgZmlybXdhcmUgc291cmNlcyBhbmQgYnVpbGQgYW5k
IGRlYnVnIG15IG93biBXSUxDIGZpcm13YXJlDQo+PiBvbiB0aGUgQ29ydHVzIENQVT8pDQo+Pg0K
Pj4+IFdpdGggdGhlIHByZXZpb3VzIHNoYXJlZCB0ZXN0IHByb2NlZHVyZSwgd2hpY2ggbWFrZXMg
dGhlIGludGVyZmFjZSB1cC8NCj4+PiBkb3duDQo+Pj4gY29udGludW91c2x5LCB0aGUgc3RhdGlv
biBtYXkgbm90IGdvIGludG8gdGhlIERvemUvQXdha2Ugc2VxdWVuY2UNCj4+PiBzaW5jZSB0aGF0
DQo+Pj4gbW9kZSBzd2l0Y2hpbmcgZ2V0cyBhY3RpdmF0ZWQgYWZ0ZXIgY29ubmVjdGlvbiB3aXRo
IEFQLg0KPj4NCj4+IFdoYXQgZG9lcyB0aGlzIG1lYW4gPyBJIGNhbiB0cmlnZ2VyIHRoZSBTRElP
IGVycm9ycyBldmVuIHdpdGhvdXQgYmVpbmcNCj4+IGNvbm5lY3RlZCB0byBhbnkgQVAgLCBzbyB0
aGlzIGlzIHNvbWV0aGluZyBiZXR3ZWVuIHRoZSBXSUxDIGFuZCB0aGUgU0RJTw0KPj4gaG9zdCwg
dGhlIHJhZGlvIGlzIGxpa2VseSBub3QgaW52b2x2ZWQgLCByaWdodCA/DQo+Pg0KPj4+PiBDYW4g
eW91IGV4cGxhaW4gaG93IHRvIHByZXZlbnQgdGhhdCBvciBzaGFsbCB3ZSBkaXNhYmxlIHVBUFNE
DQo+Pj4+IGFsdG9nZXRoZXIgPw0KPj4+DQo+Pj4gQ291bGQgeW91IHBsZWFzZSBzaGFyZSB0aGUg
dGVzdCBwcm9jZWR1cmUgYW5kIGxvZ3MuIEkgYW0gb2NjdXBpZWQgYXQgdGhlDQo+Pj4gbW9tZW50
IGJ1dCBJIHNoYWxsIG1ha2Ugc29tZSB0aW1lIHRvIGxvb2sgaW50byBpdCBhbmQgZ2V0IGEgYmV0
dGVyDQo+Pj4gdW5kZXJzdGFuZGluZy4NCj4+DQo+PiBUaGUgc2ltcGxlc3QgdGVzdCBwcm9jZWR1
cmUgaXMgdGhpczoNCj4+DQo+PiAkIHdoaWxlIHRydWUgOyBkbyBpZmNvbmZpZyB3bGFuMCB1cCA7
IGlmY29uZmlnIHdsYW4wIGRvd24gOyBkb25lDQo+Pg0KPj4gQXMgZm9yIHRoZSBsb2dzLCBNTUNJ
IGNvbnRyb2xsZXIgc3BvcmFkaWNhbGx5IHJlcG9ydHMgZWl0aGVyIENvbW1hbmQgb3INCj4+IERh
dGEgQ1JDIGVycm9yLCBzbyBsaWtlbHkgdGhlIFNESU8gcmVzcG9uc2UgKGZyb20gV0lMQyB0byBI
b3N0KSBpcw0KPj4gY29ycnVwdGVkLg0KPiANCj4gQXJlIHRoZXJlIGFueSBuZXdzID8NCg0KSSBk
aWQgdGVzdCB0aGUgc2FtZSBwcm9jZWR1cmUgaW4gbXkgc2V0dXAsIGJ1dCBJIGNvdWxkbid0IHJl
cHJvZHVjZSB0aGlzIGlzc3VlDQpldmVuIGFmdGVyIHJ1bm5pbmcgaXQgZm9yIGEgbG9uZyBkdXJh
dGlvbi4gSW4gbXkgdGVzdCBzZXR1cCwgSSB1c2VkIHRoZQ0Kc2FtYTVkMjctc29tMS1lazEgaG9z
dCBhbmQgd2lsYzMwMDAgZmlybXdhcmUgdmVyc2lvbiAxNi4zLg0KDQpJIHRoaW5rIHRoaXMgaXNz
dWUgY291bGQgYmUgcmVsYXRlZCB0byB0aGUgaG9zdCBNTUNJIGNvbnRyb2xsZXIgZHJpdmVyLg0K
Tm9ybWFsbHksIHRoZSB3aWxjIFNESU8gYnVzIGZhaWx1cmVzIGFyZSBjYXB0dXJlZCBieSBkcml2
ZXIgbG9ncyB3aXRoIGFuIGVycm9yDQpjb2RlIChlLmcuLCB0aW1lb3V0KSwgYnV0IGlmIHRoZSBN
TUNJIGNvbnRyb2xsZXIgaXMgb3V0cHV0dGluZyB0aGUgd2FybmluZw0KbWVzc2FnZSwgdGhlbiB0
aGUgZXJyb3IgY291bGQgYmUgcmVsYXRlZCB0byBpdC4gRG9lcyB0aGUgTU1DSSBjb250cm9sbGVy
IGVycm9yDQpwb2ludCB0byBhbnkgc3BlY2lmaWMgZnVuY3Rpb24/IFdoaWNoIGhvc3Qgd2FzIHVz
ZWQgdG8gdGVzdCB0aGlzIHNjZW5hcmlvLCBhbmQNCmlzIGl0IHBvc3NpYmxlIHRvIHRlc3Qgd2l0
aCBkaWZmZXJlbnQgaG9zdCBvciBkaWZmZXJlbnQgY29uZmlndXJhdGlvbiBvbiB0aGUNCnNhbWUg
aG9zdCwgbGlrZSBkaXNhYmxpbmcgcG93ZXIgc2F2ZSBvbiB0aGUgaG9zdD8NCg0KDQpSZWdhcmRz
LA0KQWpheQ0KDQpSZWdhcmRzLA0KQWpheQ0KDQo=

