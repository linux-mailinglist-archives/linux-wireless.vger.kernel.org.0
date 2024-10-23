Return-Path: <linux-wireless+bounces-14432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF99AD361
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 19:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BA01C21DEC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E121D0438;
	Wed, 23 Oct 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GvUm9A7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC281D0418;
	Wed, 23 Oct 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706101; cv=fail; b=imYT85Alq+jpqXagwS+JUQjWKwTczDOFR3Qw7ufb5eubWV/fI26YTNPQwWeMGCHkQ1uQNGzx/Cx8WVfF4tVO2JRweXioYJK+u/AiPY6TweIYv5dL/+LALCHU0V1380myOHTLLeq2I/hotBj5vLU4H9aOLdnrnK55O8Dq8jERsD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706101; c=relaxed/simple;
	bh=sJ68XZsEUi3d4MyoIBXrfUtb3xkQP/Zv7eNLqEqwUSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMgUAKVKUc4Pnok3vdX12GZXIE8khrqmI0q32WJqpt8+IsFnPOUiZDug3lfoz5S0npA8d1oBW4lLPAvSNuDzCNE/uqeCg++FAydfkjYxaITLg+1v8tFp1FRbbCorp7QSrCk0bmp5yG3LlozO0iLf+zU0CuVQnVSFy0sz3SzKIsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GvUm9A7t; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcLNA0tFbkE1AK1ZVPj+d+YoQajMvFyop+X+cLCtcBbwOJlPsgk+RCUbgHK/UA10vC2Lyl7uPoZG+w7vnWUA4EJzF+5iQXlIaBWnqhyZ0VaUJZVzRlQkHGEtslbr498OOq3A/fsMY6URFUH0ExctOptb8TWRi/WeNjE8YK3jcrAXbktqoLZd1BFqKrWT9X3VnwocrQslLkonrffiMSBEDPaDTTyQ/RsnfbLZcQHQnI2mYVh+HnrW7EJs5pojd3T8VMF70kMGcLGUVa8x+xLeECH8xbavbt1TfWB6NfjlgVFCi7hzNu3J5FPBIjKMkdjgXnUB7zWa7ooVInkqjICbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ68XZsEUi3d4MyoIBXrfUtb3xkQP/Zv7eNLqEqwUSc=;
 b=LNM/xpC+TM7UG8T14Ghn/lundEumBVKuuSbUu+2ocRnT9Pcs3Zvebb0lgG7lr3V9V55KzLeZ0Fbp5JFKRzMXgSrILTvrXaLak0qSqU6zRoRk+GJc1E+c+qnGgjOF3sRLSEdDjqPl6bSmTBM+1++8eE7VkfJJEayAvzPfkV4WZ83B72EN4Z89AN+9SJnO/u2j6iI5B7krCxJ/T0N8xjNpyQ0WuxDdfdrkKa+aO6JwxwxpPtkmI2I379sHIfQkSUknx0416fpwusxAlTP8/J3rnsHR4umW6uMNv/4g7QIH3JgnXmtE5xddoPzE5W0voXXJr9S4HRqZQmtyf+TOc1Cv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ68XZsEUi3d4MyoIBXrfUtb3xkQP/Zv7eNLqEqwUSc=;
 b=GvUm9A7tsUV3e28kauE9WUOIen8SVpdl0/Ff7k1VUF4u02JrR7o22YreqKIZor0UvfVZ5WowsmiwqYQr1+NZdunUfLpwGHDmvMAy+Ta/naU+X4mCCzAGhFYRlNAIVA9jWsmluAGdudCaTM/MNe36zCA+LwALDbZl51UwwS/Pfo/85um8xiOi3YVWKpsDuBd/p9sgY6bnDBO73zLOdEWwDO3DQyH14k/+8XWq7/0Z9Q54ruO9/MqsJouIgC6klsZiltw5lfjVaasb6DLltVBSUSJ5FHYYLnHVXAYJlExL7j/SEr30cACaU7GFQiT3qaPblK2zifH5NcrNxvbq3w3P/Q==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BL1PR11MB6026.namprd11.prod.outlook.com (2603:10b6:208:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 17:54:56 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 17:54:56 +0000
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
Thread-Index: AQHbJCM4zA3Iup70rEyd6/KmT4gyTLKSlkEAgAAreICAAS0qgIAAfQkAgAA1I4A=
Date: Wed, 23 Oct 2024 17:54:56 +0000
Message-ID: <880baad9-be3d-41b2-bea3-620f915ca397@microchip.com>
References: <20241022013855.284783-1-marex@denx.de>
 <c9e98811-15f5-427a-82f7-2e7fff4a9873@bootlin.com>
 <8e28ba76-ecfa-49b6-89b5-1edabb22129d@denx.de>
 <a4c8c489-c6b9-4a38-84ab-f08409baccff@microchip.com>
 <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
In-Reply-To: <5e2a5056-78ac-4be0-83ca-4aa55f524535@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|BL1PR11MB6026:EE_
x-ms-office365-filtering-correlation-id: 7345f8a6-bd1e-4f9c-f1e0-08dcf38bce34
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qkw4NmtTREhKeGpSRHpJaEdrM25sUE9UdmhmSnFKaS9ucnFERXBFVEtuU3Q2?=
 =?utf-8?B?NGtmKzQxZVkzNjkyYzNZUThubUoxSEtkOFVZZS9hN2F6S3F1MmZ0bG5CYmds?=
 =?utf-8?B?VHJJazBkbkhQd2JaN3hxNTZ1RlB5cFJXUHRyL2dVNnM3dXVHajhDdm5ENjZR?=
 =?utf-8?B?eXA5WWZKZyt4ZUYzSVl3aGFFZGhkbWFBT0NvbnMwdU9HLzZCV2xjYUZVWkRk?=
 =?utf-8?B?VzV5Ujk2VWt4R0JMYk5QTStQbEVUbEtTUWRnV3B0b2Fncm9qR2tHNXJlQUZp?=
 =?utf-8?B?SThZN1dCZEpRcjB6dTltR1NKSGJIeVM1UUU0aG5SSndmclZuUVZlMVJPejlM?=
 =?utf-8?B?Tkl2dkhNdTdmbXluQkg3cUUvNWI0VXE3NmNKUGErUHpzQ2RScHl6aHBDTlVq?=
 =?utf-8?B?akxxeURiOVNYam1wZlNONm96Q0ZNN2JFVTQxVStCTlIzTzJCbDVkSVg2ZFdq?=
 =?utf-8?B?NFJDRnV6a09tSkRFTlkyQXFwODdYbWpad2VBYk5OT1pvbndXRFkxenpRbkFy?=
 =?utf-8?B?T0xpR0lMZmEyc3o2RDlQQStma01sZS9DTVdJSnA2S2pvaGZiYm5ZZWhrZnZB?=
 =?utf-8?B?K1ZhVE9vVGVjNmE4QjkwcjV4OHN2TnRURzBGMWV5V0pkY2c5U2ZjZXo4ZGMw?=
 =?utf-8?B?cE9UdFhrRDByQVFHU2xjZXJUaDE3TWpWODJGek0yVFh0R1V2d0JHRlliRVhJ?=
 =?utf-8?B?SW9JWFdoSEUvY1hrUERUMWhVWjdRUXZrUjkrQ3JVeHpPSUgxTHdDaW9lYnhR?=
 =?utf-8?B?dlZFN2VDeUJydzhMMGMzTGFqaGdobVhNejNtaTJaUWlIaTVBSlQ2b0tSWFlv?=
 =?utf-8?B?WFh0K0Z4VDg2TC9IMHpmT3M3RnFobjVJbVA2Ni9qVXYxbXM0RFUveFR0OURD?=
 =?utf-8?B?VXJMNnRLeFFwWU5XTmRRZnE2Q0lySGZkaGhFSWFsYkNDQWo3cnY0Qys2SEJv?=
 =?utf-8?B?RklVYUVJS1NiOTFHRnV6WnZtKzBwM2hscXIwUzNlbHdGM29uWWlsd0NGeWp2?=
 =?utf-8?B?Uy9DSXRyTi8rQ3EwUWNjYm9WUVpVVUpTYUNaOVFiYklnaUJhNmwzell6aDVs?=
 =?utf-8?B?RFdSak1ZRWpEUTlpY1VMY0xjWkpIdm8zaHJTVDliZmk0TXNtR09aR2xaRU1m?=
 =?utf-8?B?MTJFQVhDNzZZNXJRRUZJUHF5U3F0ZlVDdmlRbWNwQTBSbjZkTFFubXlCUHdv?=
 =?utf-8?B?TW1HSlVZMmlkdWJYYk1kQ3Q0QUVIT1FDa0x5VlcxbVhWT0h5aHBiNjArM2VY?=
 =?utf-8?B?Tk9KbG5xNUVpbFNtQXllNVZOdC91eS84MTFjZmQrZ3BjZlFHVTRmNjIvZjlr?=
 =?utf-8?B?b2d1bEJyMGkrVndlcjdTMm1GaWZyU21TN1ZxeVZVMENsNlRaajJPb2tEeTR6?=
 =?utf-8?B?WVBRanBxU0FFc0cyYlRPck9XQTBObUJhRFVvWWJOazhBT0Z6U29pUWMzS2kx?=
 =?utf-8?B?VWNWWTVNUkpnNzFhTmRwZ3VFVTB4ejU5dlp2NktiK0xvbUs1Y1NMRXp4VWpG?=
 =?utf-8?B?S0dCdkdIZzdCZ1AvSmJZaFAxaTAyaWNNRWx2RWVvNGl5WldCQTNoWHFzOTlv?=
 =?utf-8?B?N2Y1MHpiZjM1cTZmRUdLTDY4TEcwYUQyMGxycG9sYXFIK1JhZ05PYTBtNkV1?=
 =?utf-8?B?SUxxWjNuRUdrUmdTZ1g2MTBYd0R1aFRWazkxMTJIVGJGcDViY3JxaXV0WEJl?=
 =?utf-8?B?TGR1a09QOThMamt3RTVJUnhkYTVPWVplSHkrcXdDQ1U4MlFWck5pK2puL1Uz?=
 =?utf-8?B?amlRaEY3NTAzRDg5ZDN6eElwTW85OWp5bXZ3cHNCeFpuOFVhanpFV3BDSUtr?=
 =?utf-8?Q?BtDTmIAcWmM/eiIchBFVg31rniC7dxFR7wQ5E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elFXUXZ2UktwVS85QmtScG5vWE5lT2hvMCtHY1JGWFdNTE82Q1Q5bjBMdFpD?=
 =?utf-8?B?YmFhZGdQV1dJOGxjb3dCTmNQOHNlMnIydE80K1pYSWIxRWFlNXNSM0VXWkN5?=
 =?utf-8?B?MExJRTkwQjU0RklsekRIMituT2E4SUpqb09QYTlYcDRrcVIvLzM1ZTdxRHF6?=
 =?utf-8?B?b3Fpd0wxNDduNEhLNmoydEgwYXpxZDV3ZGpOSGtQcURLY2dXdk15Zk51SC9H?=
 =?utf-8?B?OUNkeGtFZ0tmVmFVT09ma1hpYzZJclFuMWErdFc0aEJTb0dUR0JCYWY2bFNP?=
 =?utf-8?B?MXdtdFdQMkZNQzN4ODkzRHFkSGxTaWhpdTgxUGdFY3YrbDNmNElhcUYzTEZr?=
 =?utf-8?B?ai9DODl5MzBFTExPcGtFWXFXRittMkxWcGpJSitpRHhZcHZPQnFqVWpuT2ZO?=
 =?utf-8?B?S0tsRE9LRXNzak04Z2lCU0VuZk11aG5HNjRqaDUxYXlZMUNNb1M2UGtCQ0VP?=
 =?utf-8?B?SVFnTXRnR09iNDdFeGtBOGhWNG11Q1lERGdUeVNEZGtzUjV6QzN4WUR3S2gz?=
 =?utf-8?B?VmdoT3NhY2hjZ0RzM2crOWdOS294cWs3WThyWHRwaDJCU1lCSi9TdXdyRUNZ?=
 =?utf-8?B?MlphUWVCaktKTC9yMmxWcEFBUkcrWEptTkZXWW81SDkrUk9xNkdqblVEOEx1?=
 =?utf-8?B?Y3BBc3pITitNV3J2bjFIYWV0bENFbU5sYXBOQTVXS1VQVlMxSU91RlJoOWNj?=
 =?utf-8?B?RDFhdGovblBOQW1ZcEpzeGdLYnUyOUh6Q3FKLy9MVGVvWWVleGRmQk81VDhw?=
 =?utf-8?B?c1JPQXlHOEVGRnZORmZaVXJvVEZZbkM5bExLa0RBc1FHS2ZpTXVpZms2elR0?=
 =?utf-8?B?Yk9UYVlVMStaelRXUDk5cGhaWHMxMWprN0FPWjZ2M0lpY28zaXBFWHIxTWIv?=
 =?utf-8?B?UytQbGVhbXczUDFBNTBub3FvME0xbzFhTC8wN3ZEVFJ3Q3FVRmZwTC9pdS9s?=
 =?utf-8?B?djAvclN5U0xpaXNWeWwrem5IaTQ1V09XODk4R0FiL21aZDBWMFFRbmkyRmtG?=
 =?utf-8?B?Vnl4WFpET2dYK2dvdlBRTHNCcWtVUEpCckxVaTl5ektva1pRUXE2eVUwbTl6?=
 =?utf-8?B?R3JXZ0dCdHlNcUJuUktqYnFqN2Y0OHd4bkxudmRaM3RWWE1iVGM1M2dWblUr?=
 =?utf-8?B?ZzZvamNFTmdMSGQrbkJzd01Lam5NaUpFWXVGVkJUdmhteFRObTR4dTF0S0lI?=
 =?utf-8?B?R1lHbE96Tk5LODR5WXBiNzdsSjFmcUlGam1JOGJ5YUU5V0x6ZjVJNFhYWGgx?=
 =?utf-8?B?TE9KQW03SGJzRCtFZTA3cFhsdWlkc0ljdVNXU2c3aG1xUDdWNy9adUVFRWhH?=
 =?utf-8?B?T3hUU2w2dEl0ZWYzNnJjTEtuclBaQVg3UDRqR3ZZY2tybnZvUW9DZ0s4eHAw?=
 =?utf-8?B?OSt6bDJYdS9lSHZaUnc2bHE4M1c4TEM3enE2dS96MXJ5RFdqTlRsVm1VOEdK?=
 =?utf-8?B?N05KbVBMR1lsdW5vOXNvaHAyL1laRUFrWHZCTzAyRGc2Mm5wK29wMC9QMEl3?=
 =?utf-8?B?WUhKMHhlWWw1Wi84aStWVGJaSTNUdWdXL3haRGl6RDg5bjZVajhRcG5mR0tC?=
 =?utf-8?B?TVJpRDNiZU5PZjRXbkRVdXMrNytGRlBjbGxpeE01Y1JkbXRISlRHeE9VWmZG?=
 =?utf-8?B?M2QxK01RWnhFUVNscTA0TkdwcHRpeG4wZDJzdXBNRVBNci9pdzdveWdoNElD?=
 =?utf-8?B?azV6d0ljRm1qdWdVRmxvQVFwY3V2cFlyc0pzWnhQSWNyK0lwdyt1SXM1T3Vt?=
 =?utf-8?B?SmZEWmJWd0t2MC9GOGF2THN0UUt1TUxTNkpYSi9ZbEVSVFQyd0hSSE5naWNS?=
 =?utf-8?B?MThCWGtrbzhvSVp3OGRpM3hKUjFOcldpRm1WT21SOW1DWmR5bXJaWmVnWXJW?=
 =?utf-8?B?Z0RIUVhoY1JjZ1FBenpVUjJOSkMyRXdVL0NYbHp0dVdWZXVDYlg5K21rOCtB?=
 =?utf-8?B?dTM0SUxlRTMyd05DdlBBK2h0cWVaWjBWQWkxV1YvemhFQjBKTkpuSmUzMGJz?=
 =?utf-8?B?MXUreGtBSGtWQXdqZXlRQWxSYVgwSjQremlWdmdWZlVrdVYvRmtDZUdzYmta?=
 =?utf-8?B?Q092WUhJaUJjdzNpNUxIckF1Y3NJNGhhMkdSdDJhUnZVZWI0ZHJRcGRIODBn?=
 =?utf-8?Q?B09JK9qmNwmOYm/3pEj+m6fZS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92BFEF78595E20499A01E22FDF2DF3CB@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7345f8a6-bd1e-4f9c-f1e0-08dcf38bce34
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 17:54:56.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rp0gA5cULqmDtQGf5EoOMVQvNoyUFWS9yItrRodphgKtuygk5SnPEhXaUXD5qrb4+DK4FPsDwkREhbROEgqQqIf+PY07uZN2gXoqaYQW1/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6026

SGVsbG8gTWFyZWssDQoNCg0KT24gMTAvMjMvMjQgMDc6NDQsIE1hcmVrIFZhc3V0IHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEwLzIzLzI0
IDk6MTcgQU0sIEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IA0KPiBIZWxsbyBB
amF5LA0KPiANCj4+PiBXaGF0IEkgYW0gdHJ5aW5nIHRvIHNheSBpcyB0aGlzOg0KPj4+DQo+Pj4g
V2l0aCBjdXJyZW50IGNvZGUsIHRoaXMgY2FuIGhhcHBlbiwgd2hpY2ggaXMgbm90IGdvb2QsIGJl
Y2F1c2UgdHJhbnNmZXJzDQo+Pj4gZnJvbSBtdWx0aXBsZSB0aHJlYWRzIGNhbiBiZSBpbnRlcmxl
YXZlZCBhbmQgaW50ZXJmZXJlIHdpdGggZWFjaCBvdGhlcjoNCj4+DQo+PiBEaWQgeW91IG9ic2Vy
dmUgYW55IGJ1cyBmYWlsdXJlIGluIHlvdXIgdGVzdCBzZXR1cCB3aXRoIFNESU8uIElzIHRoZXJl
IGFueQ0KPj4gY29uZmlndXJlIHRvIHJlY3JlYXRlIGl0Lg0KPiANCj4gSSBhbSBvYnNlcnZpbmcg
c3BvcmFkaWMgY29tbWFuZCBhbmQgZGF0YSBDUkMgZXJyb3JzIG9uIFNUTTMyTVAxNTdGDQo+IHN5
c3RlbSB3aXRoIFNESU8gV0lMQzMwMDAuDQoNCkRvZXMgdGhpcyBwYXRjaCBoZWxwIHRvIHJlc29s
dmUgdGhlIENSQyBlcnJvcnM/DQoNCkRvIHlvdSBvYnNlcnZlIHRoZSBDUkMgZXJyb3JzIGR1cmlu
ZyB0aGUgYnVsayBkYXRhIHRyYW5zZmVyKGlQZXJmKSBvciBkb2VzIGl0DQpldmVuIGhhcHBlbiBk
dXJpbmcgdGhlIGJhc2ljIFdpRmkgb3BlcmF0aW9uIGxpa2Uoc2Nhbi9jb25uZWN0IG9yIGJhc2lj
IHBpbmcNCm9wZXJhdGlvbikuDQpJcyBwb3dlci1zYXZlIGVuYWJsZWQgZHVyaW5nIHRoZSB0ZXN0
LiBXaXRoIFBTIGVuYWJsZWQsIFRoZSBTRElPIGNvbW1hbmRzIG1heQ0KZmFpbCBtb21lbnRhcmls
eSBidXQgaXQgc2hvdWxkIHJlY292ZXIuDQoNCj4gDQo+PiBUaGUgU0RJTyB0cmFuc2ZlciBtYXkg
YXBwZWFyIHRvIGJlIHNwbGl0IGludG8gaW50byBtdWx0aXBsZSB0cmFuc2FjdGlvbiBidXQNCj4+
IHRoZXNlIGNhbGxzIHNob3VsZCBub3QgaW1wYWN0IGVhY2ggb3RoZXIgc2luY2UgbW9zdCBvZiB0
aGVtIGFyZSB1cGRhdGluZyB0aGUNCj4+IGRpZmZlcmVudCByZWdpc3RlcnMgZXhjZXB0IFdJTENf
U0RJT19GQlJfQ1NBX1JFRyByZWdpc3Rlciwgd2hpY2ggaXMgdXNlZCBmb3INCj4+IENTQSByZWFk
L3dyaXRlLiBJZiBuZWVkZWQsIHdpbGNfc2Rpb19zZXRfZnVuYzBfY3NhX2FkZHJlc3MoKSBjYW4g
YmUgbW9kaWZpZWQNCj4+IHRvIGNsdWIgdGhlIDN4IENNRDUyIGFuZCAxeCBDTUQ1MyBpbnRvIGEg
c2luZ2xlIHRyYW5zZmVyIEFQSS4NCj4+DQo+PiBJbiBteSBvcGluaW9uLCBJZiBzZGlvX2NsYWlt
X2hvc3QoKSBpcyBtb3ZlZCB0byBhY3F1aXJlX2J1cygpIEFQSSB0aGVuIHRoZQ0KPj4gU0RJTyBi
dXMgd2lsbCBiZSBjbGFpbWVkIGxvbmdlciB0aGFuIHJlcXVpcmVkIGVzcGVjaWFsbHkgaW4NCj4+
IHdpbGNfd2xhbl9oYW5kbGVfdHhxKCkgQVBJLiBJZGVhbGx5LCBjYWxsaW5nIHNkaW9fY2xhaW1f
aG9zdCgpIGNhbGwganVzdA0KPj4gYmVmb3JlIHRoZSB0cmFuc2ZlciBpcyBlbm91Z2ggYnV0IG5v
dyB0aGUgU0RJTyBJL08gYnVzIHdvdWxkIGJlIGNvbnRpbnVvdXNseQ0KPj4gYmxvY2tlZCBmb3Ig
bXVsdGlwbGUgaW5kZXBlbmRlbnQgU0RJTyB0cmFuc2FjdGlvbnMgdGhhdCBpcyBub3QgbmVjZXNz
YXJ5Lg0KPiANCj4gV2h5IHdvdWxkIHRoYXQgcG9zZSBhIHByb2JsZW0gPw0KDQp3aWxjX3dsYW5f
aGFuZGxlX3R4cSgpIHBlcmZvcm1zIG1hbnkgb3BlcmF0aW9ucyBvbiBkaWZmZXJlbnQgcmVnaXN0
ZXJzIHdoaWNoDQphcmUgbm90IHJlbGF0ZWQuIEl0IHdpbGwgYmxvY2sgdGhlIFNESU8gYnV4IGZv
ciBsb25nZXIuIE90aGVyd2lzZSB0aG9zZQ0KcmVnaXN0ZXJzIGFyZSBhbGxvd2VkIHRvIHVwZGF0
ZSBzZXBhcmF0ZWx5IGZyb20gdGhlIFdJTEMgU0Qgc2lkZS4NCg0KPiANCj4gSSBhbSBtb3JlIGNv
bmNlcm5lZCB0aGF0IGtzZGlvaXJxZCBjYW4gaW5zZXJ0IGEgY29tbWFuZCB0cmFuc2ZlciByaWdo
dA0KPiBpbiB0aGUgbWlkZGxlIG9mIENNRDUyL0NNRDUzIHJlZ2lzdGVyIHJlYWQgY29tcG9zaXRl
IHRyYW5zZmVyLCBiZWNhdXNlDQo+IHdoaWxlIGtzZGlvaXJxZCBkb2VzIHVzZSBwcm9wZXIgc2Rp
b19jbGFpbS9yZWxlYXNlX2hvc3QsIHRoaXMgZHJpdmVyDQo+IGRvZXMgaXQgcGVyLVNESU8tY29t
bWFuZCBpbnN0ZWFkIG9mIHBlciB0aGUgd2hvbGUgZS5nLiByZWdpc3RlciByZWFkDQo+ICJ0cmFu
c2FjdGlvbiIuDQo+IA0KDQpJIHRoaW5rLCB1c2luZyBzZGlvX2NsYWltL3JlbGVhc2UgZm9yIGVh
Y2gtU0RJTyBjb21tYW5kIHNob3VsZCBzdWZmaWNlIGJlY2F1c2UNCnRoZSBDTUQ1Mi9DTUQ1MyBt
b2RpZnkgdGhlIHNwZWNpZmljIHJlZ2lzdGVycyB0aGF0IGFyZSB1bnJlbGF0ZWQuIEVhY2gNCkNN
RDUyLzUzIHNob3VsZCB3b3JrIHByb3Blcmx5IGFuZCBpbmRlcGVuZGVudGx5IHByb3ZpZGVkIHRo
ZXkgYXJlIHByb3RlY3RlZA0Kd2l0aCBzZGlvX2NsYWltL3JlbGVhc2UuDQpBZGRpdGlvbmFsbHks
IHRoZXJlIGlzIG5vIFdJTEMgU0QgbW9kdWxlIGxpbWl0YXRpb24gcmVxdWlyaW5nIGEgc3RyaWN0
IG9yZGVyDQpmb3IgQ01ENTIvQ01ENTMsIGV4Y2VwdCBmb3IgQ2FyZCBTdG9yYWdlIEFyZWEgKENT
QSkgcmVhZC93cml0ZSBvcGVyYXRpb25zLg0KDQpGb3IgQ1NBIHJlYWQvd3JpdGUgb3BlcmF0aW9u
cywgd2hpY2ggYXJlIG5lY2Vzc2FyeSB0byByZWFkL3dyaXRlIGFueSBzcGVjaWZpYw0KYWRkcmVz
cyBmcm9tIHRoZSBjYXJkLCBtdWx0aXBsZSBDTUQ1MiBjb21tYW5kcyBhcmUgdXNlZCB0byBwYXNz
IHRoZSBkZXNpcmVkDQphZGRyZXNzIHRvIGJlIHJlYWQvd3JpdHRlbiB1c2luZyByZWdpc3RlcnMg
KDB4MTBjLCAweDEwZCwgMHgxMGUpLiBUaGVuLCBDTUQ1Mw0KaXMgdXNlZCB0byByZWFkL3dyaXRl
IHRvIGFkZHJlc3MgMHgxMGYgKENTQSBkYXRhIHdpbmRvdyByZWdpc3RlcikuIFRoaXMNCmNvbXBs
ZXRlIGNvbW1hbmQgc2VxdWVuY2UgaXMgcmVxdWlyZWQgZm9yIGEgc2luZ2xlIENTQSBhZGRyZXNz
IHJlYWQvd3JpdGUuDQpCYXNlZCBvbiB0aGlzIHJlcXVpcmVtZW50LCBDU0EgcmVhZC93cml0ZSBv
cGVyYXRpb25zIGNhbiBjYXVzZSBpc3N1ZXMgaWYgdGhleQ0KcnVuIGluIHBhcmFsbGVsIHdpdGgg
YW5vdGhlciBDU0EgcmVhZC93cml0ZSBvcGVyYXRpb24sIGJ1dCBub3Qgd2l0aCBvdGhlcg0KQ01E
NTIgYW5kIENNRDUzIGNvbW1hbmRzLg0KVGhlcmVmb3JlLCBvbmUgYXBwcm9hY2ggdG8gcmVzb2x2
ZSB0aGlzIGlzc3VlIGlzIHRvIGFkZCBzZGlvX2NsYWltL3JlbGVhc2UNCmFyb3VuZCB3aWxjX3Nk
aW9fc2V0X2Z1bmMwX2NzYV9hZGRyZXNzKCkuIFRoaXMgd2F5LCB0aGlzIGZ1bmN0aW9uIHdpbGwg
YmUNCnRyZWF0ZWQgYXMgYSBzaW5nbGUgb3BlcmF0aW9uIGFuZCBpdCB3aWxsIG9ubHkgbW9kaWZ5
IHRoZSByZXF1aXJlZCBjb21tYW5kIGZsb3cuDQoNCg0KUmVnYXJkcywNCkFqYXkNCg==

