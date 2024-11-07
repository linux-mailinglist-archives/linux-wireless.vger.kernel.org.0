Return-Path: <linux-wireless+bounces-15026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B484A9BFB73
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 02:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BA51C20902
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355A8F5E;
	Thu,  7 Nov 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2aqkiQML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211D2119;
	Thu,  7 Nov 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942928; cv=fail; b=vDri0dTKBU3TcSLNiqY8WPr7WwZWf/TCyQGsrTfrsNDaYp24Voyx+LSx3kSY9+uzuENKZhch7o+5ydj2wMz7paalyB1BUa3mDkIddxYQ5niOAx162oUrxRJ7DUcPRJo99Cjcb3zEeo5ZGOqXy3DLSHot4DzDw0t8m7ndwg1lywg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942928; c=relaxed/simple;
	bh=DikTkcEaXYMB2pAOAtq1yxXeJMfNuSAxHtQv37S82vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O4RCNE7N2CjY6e9asd/cP8zU5POz/1AizOtEUxTWPMUrEXNN2SFLHdv0I4FlvtFKf/Jv4W1ehkoR5yUMkr0eKR3dTlWPzVaqpYTnUDpGLeUAO1FbfekzUhCmKOVzmLaNbSmOB4AynN6w8bMX6jVfgS7SwUrEvYbTEqA7vXhK3Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2aqkiQML; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqcnrJ699iE3m1p4scirk7Pro8SbUoD9fpbIYzHH9pNG1u1lZo5wzT4x6ciwgqycfPZ9ocEKmiQkv3zCqTFPTBikFzAgJ7UvOyLrH7pdNlyGs97hgoyhmCYfr7Pmjm28lxQpzu3I5dYpEtuq037B5MW2vZMOSdw0Zk/4ba8wuoavqj270RQw6fzFrs+XD36/jIICf2F2Tm4r9e/V4hOUirgryQNRIrq8rT+r2ElWtvJwjefzgLTMY7JQj/Rq1XK3cFPtO0qBShyABBCl0No+hJvKjxprAEfARHzZwmWexZyQ3psT6UYdw1nv7xGT70mVSPWl4VkOFcfBOGXCy0DV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DikTkcEaXYMB2pAOAtq1yxXeJMfNuSAxHtQv37S82vw=;
 b=wEyDqJgD0WB3tgsy7StI+BPB68ZHTbjea/F329QsaKs/2mbuvbDBd0Fjvf6vmvuYRG95NMx/mQUM8Cw7SvVX/pJyn+zz3XmRorXZAyGGaEcwIi/khS3rGUj4Lj4/V4xXTthCcDXYsPMsVJ2av0gZAY2PTTP/uIq6P1tzDja5xHY+uc6GYsQ+gbuIdBi25Ekxxm2Ku0Uy8hf6MfSGqzNsoXSqUpM8UI4fhpzLhSTRNZqs17NqdBl2Ob33dgsRHY7i/9w6L7faDfOwISLygVpcw2wnBgrHQTbMuwJbipJ+TsE2/RIy9l08eLJXCnVv6AHz4J4PcaKVZaDYRH7c4NZqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DikTkcEaXYMB2pAOAtq1yxXeJMfNuSAxHtQv37S82vw=;
 b=2aqkiQMLqbyu4qrjyjvhSPpKf0nJfoE1MG+B8Osm+lEChR5o84mdghnW0Fg/IHkjcHTz8A6PgfE4fGfmB7W0vLQp9SGVl1KSWfGvtR7lQ2kDQEvbzZl6bWsF7sclb7vRPi2avwzhi+sBshkTencGRuQF0neQRiUONmXjZL/1QbOh28sFTOonvuPFGAp/XIssLrOvnlf9l5fXJP8dMDSDMVtdRXdvlUQOjxcvs1YjIp4lw2enAcUCKL18O5l5ZcIb0EYZcwBWW0WQfD6nY1RO8zxxcwcSy1gbMmaI9mZKzg3fsGruULYC0+CSZJrmAobLsxKPZG//oTOTsl4HKoVMhw==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 01:28:43 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:28:43 +0000
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
 AQHbJCM4zA3Iup70rEyd6/KmT4gyTLKSlkEAgAAreICAAS0qgIAAfQkAgAA1I4CAAA7EAIASZZyAgAQLDoA=
Date: Thu, 7 Nov 2024 01:28:43 +0000
Message-ID: <9888f605-ee68-4bd3-8d1d-aeef247d23d0@microchip.com>
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
 <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
 <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
 <9d20b408-72a4-49f0-aca6-108dfdd65f99@denx.de>
 <16e5c8d7-64ac-424e-9430-b683ae16a34e@denx.de>
In-Reply-To: <16e5c8d7-64ac-424e-9430-b683ae16a34e@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SN7PR11MB8282:EE_
x-ms-office365-filtering-correlation-id: da12ed39-3478-4d35-4338-08dcfecb847b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUpLYkI0aXNPTjE4RnF4TGJxU0hxZzFGQUJqRWhIK3RycTR3OFdMZFY2N3J3?=
 =?utf-8?B?M3ZndVRIRkJTcVJVNlRlT084UjNJSVg5cWhXMDlmcWJtVFpUZGMyZWt3M1ZR?=
 =?utf-8?B?RVk5Wm9iOGdMMzZHYnZqaU5Sb3dMNUlpdVZmYnRYbTB5SFJ3MXF1aVhXQVZv?=
 =?utf-8?B?dXBHajlRNXB1WStBMTRBVlRyMkRxbDR3aEhPSGJrQU85WjNrbkd3M0Z2N0Y3?=
 =?utf-8?B?VE1pVGhUWkRLd3U4cURwZGF4L1pjeDFNZDdYV2JaZ2VsTlBkbXpiNEJrcDNs?=
 =?utf-8?B?a3p3TG5EMlJ5aFlCaTdzT1c4aDB1T3F4VURKZlNjelZrUlZjTHE3WW1CVUZv?=
 =?utf-8?B?ckp0RjZSQVhTMkoxT295S0RCYVduLzRyNnBNSW5DMnpLWnFiRWwrYWZuS3dN?=
 =?utf-8?B?blM1OUtuZldGbURyb3l3UUpqcjF5bzZRdmttZE5jdjYxa1lhK1R1UEVpVWdW?=
 =?utf-8?B?L3ZXSTdjZFJBTlFUeFBOY2VQRUxrZk4rUTNjbWI3SG14OU9Vc21aQ0Fac1hH?=
 =?utf-8?B?b1dQUWdwaldMY1drSkNraDErczhWY2FzYnhCbjhqK1JuUWdNZUF1aUZaY2Uv?=
 =?utf-8?B?NHlReko0M040MDdKLzNHZGZsNlNwRkl2R2pJMFp3cVE5djlPbG5LQTJhYnpD?=
 =?utf-8?B?TkpCMTN2aHlYeXlSTjEreExRcXNpOWFCTnVWcXFZVUpUQ0lxY2pDK1hkYWto?=
 =?utf-8?B?KzVxMW51TkhDMy9RL0dnWmIxOVdkRVd4K2xPb1ZKVzd3cXdXTVpBVHJmRjl5?=
 =?utf-8?B?TlkvaE1JVG1udTQ2S3BTU1dmMjVjUFV5dk0yeUxCUWJoZ002ZEdDazd1d1VY?=
 =?utf-8?B?V045bkhPRGZsQWJpSmcwMER1cnlvMGhrdnZhRzIwL2c5eVRWdmZHK1RsRy9X?=
 =?utf-8?B?NU9LT0hiT1pnMlFlZ2Y5ZWFqZmhGSGo1d1RZUVYyMjNQajAxZTlCNHc1MTdL?=
 =?utf-8?B?UVdiQVBQRmQ0VHhvNi8wajV5VTBLYU41MXdMa1NNTFY2MTJ2TlNoTVBVVjB0?=
 =?utf-8?B?T2F5QVBtK2Rnck1pWlUrUXJjZXlySFR6RFBhUlZlSVVPekNzNWN1MWlEOE5X?=
 =?utf-8?B?THovWkpSdENNK3Z2L2VCcWtVQndJS1pYN0tCTi9paWx4Z0d4NDV1WERXNTMv?=
 =?utf-8?B?bWYrZHVRdVE4dm5mUk5uQXZmYzRURVR1ZTFydHhyOFlCQk5UVDRpTFV0dHor?=
 =?utf-8?B?TWdja1ZOVEFXNFR6TCtIRE50N0RwOU8zaklpcENvTHJVcmwveTE4TkJMbnpV?=
 =?utf-8?B?bDQ2eDNncjFGbW4vMzdVVGFBM2cwYnZzZUNFWTEvTW16Uktxc1lEWUw1cCsx?=
 =?utf-8?B?YnlCcFNqRzN6ckVKSnIvOUgwV0wxQnJENmdjb0tOdzE4VFFNTEtPUHFpemho?=
 =?utf-8?B?VlZReWNxMWtrYzdCM2tVb29GUi8vNU1qZVAvaHExYk5LU2llV1B4dURJYVor?=
 =?utf-8?B?UTJrU2VRSXBuVUpDQUNvYWdadU1SSTBOTk80UmMrd0lTSDNMWjFiSjZwK21p?=
 =?utf-8?B?K280OGZEZHBsYjhBdUJaK2xJRUt5bm5EOHVMOUpQK044MWRPSWUxOTcrWHdM?=
 =?utf-8?B?bGFVbEllcUd4NnM2SDFpYmcyNnlDWDNGSlJnZlF4TEg2SU9WTnpra1pkVTNE?=
 =?utf-8?B?UllNRzVYYzg5eThiVGpSaU92V2pjNHpya2FFUS9TK1V3Tk9JWWtwY2tSVVZS?=
 =?utf-8?B?SG5Ed1F0UHRBK2NyU3RXZFByV1VadTFWbDlWYlVZM1V1c0ZFY0xINWFyZkMz?=
 =?utf-8?B?eDU2bXlDTW0waTJMbVFnanMxSW1QZVZ6ZWlPV2dMNjdCcFpoNjlyNXdHQUV3?=
 =?utf-8?Q?AvrrNAWhbBbnGdKFirXDbEGfVN8cfaGJ6ZbqI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWdRbGRjVHVIdVI3QzBhYkEzS1o5ZUlLRnZiYkxzNmdHa3JVSyt1NUhUZGFD?=
 =?utf-8?B?VnR0K0pRYlpNVkcrWmxER1lOYThrQXpqM3BUNmRUVW5SdFh5bDNLQjVJOW1m?=
 =?utf-8?B?c01CM2tDWnJteDFCR1VzZzJRdUs3K0drNldGNlNzNjNNUklod1JSdTVXMk85?=
 =?utf-8?B?S2IwdFdJZk5pVHBFa2ZYWThSSFowVlVxNU1ielFsYWZNV0RUMkdSMUVSSlQx?=
 =?utf-8?B?bXRIalpHdE5FYjhWcHBtNkpWb0tsMnBxblZOdG5pcmp0dkpaTTB0QjZPdkpV?=
 =?utf-8?B?UmpHSGJVTWJFbmRzeEMxb1d4OXdISnNzc3pjajEwYTZBeXVocEUrRGdKbHlS?=
 =?utf-8?B?emgxakZhaGNZdWdLSmdRQjNhdTZCUGltUjNXYU1aWGdDa05BenN1bjZCK2Nj?=
 =?utf-8?B?Z3M0OHdTMkkyVjdZU0kzU2tNaUxnbVd1MnVqL0VxbWl4QWRrcDlxUHlqWjlZ?=
 =?utf-8?B?cmtvcXZlbzFJOHhQYms1ajFxNjhoeUFqOVJGV3lqSjZiMTFaakVRU240ZEEr?=
 =?utf-8?B?RzJBbjBiUWhzSncxY0Iwb2dNU2dFZkRrWk1GY2VBOXZEZUNvT2hCeWVPemt5?=
 =?utf-8?B?aFBLMElVNE1TcDdnT0huT0NBNUFaQXhTV2RDYmY3eHEyRUVJMEVmV1N1Q28y?=
 =?utf-8?B?R29DOVpLUEtxYjYwM3A4Mm5wZm1PbkNEVGVpa0tYdHVWeGVvb1d3dG5PYmpa?=
 =?utf-8?B?NFpBWjdjQ1FsQmJtUThZWUdMU1ZWaGNWYzdINnFzUVFrdjZ1dVk0YnVERk00?=
 =?utf-8?B?bTdXdzhWZ2hub3R0NkRtb0Q0U0M4emwxNkxSZHBXeDJHY09LcENNMWlUdkls?=
 =?utf-8?B?UGpRa2xoYmlUZXdiVWlxaFprZzh1UHV5WVU4SEgxUWpnRzlSaExPUDF3UVl3?=
 =?utf-8?B?VVpjb3R6NDZoR1BPRmpJTFM3bzJGVXVVaXRMR3dzVWU0ckI3L2xGVW0rdzVM?=
 =?utf-8?B?eWNEUzJEdC92OWVNRXYvamp3VTAranZ6YWZ3K0dBZy9GbFVYaVBNbERFWW9C?=
 =?utf-8?B?ZW5VZy8yanNlMnF3TEpaeld1cGRpbGp3NWpLL1NjcTNTVWRzOFphQzBZWnBo?=
 =?utf-8?B?OVhXdkFTejF2T2FON2Z2Ni8rNFRUNkt6bWF4MVhFRExjM2JyK0I0Q2JrdDY0?=
 =?utf-8?B?SGFaSEhLcWpWTUtiRXlRa0NFY3NkdktqNkhCaGR1SDBUcDgxVWE3bEkvUEdM?=
 =?utf-8?B?TE1ZME9SZ3BZM0U4NTVVdmtwV0wvRUkyTEdsRHlKSmtidVVTeC9GTVVVSWlH?=
 =?utf-8?B?YTFiNkxwdzBua1ZLRkpWQUZLeVVMZ05iRFZXOVo1TGNZdkpaRmgxL3Y0OFFH?=
 =?utf-8?B?czZHWnhETm43aGVpNjQvZjdtSkNGM1Z0aU5SdjB3amVJMG5oZVg3Uit6azdO?=
 =?utf-8?B?b2dUUVROeUF6b3B4L2xpQlJWbjNVc2ROTVhkckhzVW1vRWo2ckJqU21EMmNV?=
 =?utf-8?B?ZXozU3lwcHRjdFNRWGlWSnJudFpNckFPK1JLd0dCNjY1UFV0aHViMWgyRkto?=
 =?utf-8?B?WEVJZkRmMkt4SlJ6T2VCNVdIUlhnQURTTzdMMmdOWmpySEhVdm5GdmF0QjB6?=
 =?utf-8?B?MWY3RFpwUjRydE00WUNJMzFleWFkdnV4WmdaU1R4QzE4WFZFMTBIQXlLVG9r?=
 =?utf-8?B?STZMemlFdGVUcSs4TWgxbWhoYUdNUjVmY2xMUUNjc1JvN1Eyc0U2bDFUbDBN?=
 =?utf-8?B?c2hZOEV4NWJMWi9od2ZFL251Vk40NU9PWDM1QmE0TVpIVUZMM1h3bS96cEdo?=
 =?utf-8?B?Tzhhb1E4OUdHWnpwaFJJMW5idWFwZlRZWWVIZUhvWktyRFBHLzlVQ1pxbHVC?=
 =?utf-8?B?aURMTmFSZ0RmT1BjMVI3YUs4STloN2lzdkc2VHFieGliWTRscWJxTkxHdWVr?=
 =?utf-8?B?N09FaTFZK2FZR1g0NHREcklyZWRLbHgyUkNDRnAwQXkrQXRUNUdySFJIeFpr?=
 =?utf-8?B?dGRBa243Vjk3ODEwQ0RibGp4a3VRb04yOElXVkxYa1JWL2lEWGFtQUp2MWs3?=
 =?utf-8?B?UEtvK2I4eVBkQVMvVlBYa3dZV0pGcFk2V1JFN2E5NkdOSUtjRGszbm51T0Vh?=
 =?utf-8?B?S2ZmOUhCRzNCdXByTGg4YW1lZEtYbUd3RWZsUGxIeWNqN3JMWXp0cWovT1Np?=
 =?utf-8?Q?7Hq7aMeNDC8EOazZsxGB3G/FZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <711AC351ADB8F942AF1293000D9FBF19@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da12ed39-3478-4d35-4338-08dcfecb847b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 01:28:43.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMdgpBUI8g/OoeuJqmJ6lASK3ftTY1jWRgv8W9pJs6LrqsCO4PDI4T2fxnEm6BCq/vfd3A/Vcw11vmMslDcoERuu9ECtWFxA/nizZe/Hh/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282

SGkgTWFyZWssDQoNCk9uIDExLzQvMjQgMDQ6NDQsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEwLzIzLzI0IDg6NDcg
UE0sIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiANCj4gSGVsbG8gYWdhaW4sDQo+IA0KPj4+IElzIHBv
d2VyLXNhdmUgZW5hYmxlZCBkdXJpbmcgdGhlIHRlc3QuIFdpdGggUFMgZW5hYmxlZCwgVGhlIFNE
SU8NCj4+PiBjb21tYW5kcyBtYXkNCj4+PiBmYWlsIG1vbWVudGFyaWx5IGJ1dCBpdCBzaG91bGQg
cmVjb3Zlci4NCj4+DQo+PiBJdCBzZWVtcyBpdCBnZXRzIGVuYWJsZWQgYWZ0ZXIgZmlyc3QgaWZj
b25maWcgdXAsIHRoYXQncyBhIGdvb2QgaGludCwNCj4+IEknbGwgdHJ5IHRvIGRpc2FibGUgaXQg
YW5kIHNlZSBpZiB0aGF0IG1ha2VzIHRoZW0gZXJyb3JzIGdvIGF3YXkuIFRoYW5rcyENCj4+DQo+
PiBEbyB5b3UgaGF2ZSBhbnkgZGV0YWlscyBvbiBXSFkgd291bGQgc3VjaCBzcG9yYWRpYyBlcnJv
cnMgb2NjdXIgYW5kIGhvdw0KPj4gdG8gbWFrZSB0aG9zZSBnbyBhd2F5IGV2ZW4gd2l0aCBQUyBl
bmFibGVkID8NCj4gQ2FuIHlvdSBleHBsYWluIHdoeSBkb2VzIHVBUFNEIChpdyAuLi5zZXQgcG93
ZXJfc2F2ZSBvZmYpIGFkdmVyc2VseQ0KPiBhZmZlY3QgU0RJTyBidXMgc3RhYmlsaXR5ID8NCj4g
DQoNClNESU8gYnVzIGVycm9ycyBjYW4gb2NjdXIgZm9yIGRpZmZlcmVudCByZWFzb25zIGFuZCB0
aG9zZSBlcnJvcnMgY2FuIGJlIG9mDQpyZWNvdmVyYWJsZSBvciBub24tcmVjb3ZlcmFibGUgdHlw
ZS4gRm9ywqBub24tcmVjb3ZlcmFibGUgZmFpbHVyZXMgbGlrZQ0KZmlybXdhcmUgY3Jhc2hlcywg
dGhlIHJldHJ5IG1lY2hhbmlzbSBtYXkgbm90IGhlbHAgdG8gcmVzb2x2ZSB0aGUgaXNzdWUuIElm
DQp0aGUgZXJyb3IgaXMgcmVjb3ZlcmFibGUgdGhlbiBkcml2ZXIgc2hvdWxkIHdvcmsgd2l0aCBy
ZXRyeSBhdHRlbXB0cy4NCkkgdGhpbmsgeW91IGFyZSBvYnNlcnZpbmcgdGhlIGJ1cyBlcnJvcnMg
bWVzc2FnZXMgYW5kIGl0IGlzIHJlY292ZXJpbmcgYWZ0ZXINCnRoYXQuIElzIG15IHVuZGVyc3Rh
bmRpbmcgY29ycmVjdD8NCg0KV2l0aCB0aGUgcHJldmlvdXMgc2hhcmVkIHRlc3QgcHJvY2VkdXJl
LCB3aGljaCBtYWtlcyB0aGUgaW50ZXJmYWNlIHVwL2Rvd24NCmNvbnRpbnVvdXNseSwgdGhlIHN0
YXRpb24gbWF5IG5vdCBnbyBpbnRvIHRoZSBEb3plL0F3YWtlIHNlcXVlbmNlIHNpbmNlIHRoYXQN
Cm1vZGUgc3dpdGNoaW5nIGdldHMgYWN0aXZhdGVkIGFmdGVyIGNvbm5lY3Rpb24gd2l0aCBBUC4N
Cg0KDQo+IENhbiB5b3UgZXhwbGFpbiBob3cgdG8gcHJldmVudCB0aGF0IG9yIHNoYWxsIHdlIGRp
c2FibGUgdUFQU0QgYWx0b2dldGhlciA/DQoNCkNvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIHRl
c3QgcHJvY2VkdXJlIGFuZCBsb2dzLiBJIGFtIG9jY3VwaWVkIGF0IHRoZQ0KbW9tZW50IGJ1dCBJ
IHNoYWxsIG1ha2Ugc29tZSB0aW1lIHRvIGxvb2sgaW50byBpdCBhbmQgZ2V0IGEgYmV0dGVyIHVu
ZGVyc3RhbmRpbmcuDQoNClJlZ2FyZCwNCkFqYXkNCg==

