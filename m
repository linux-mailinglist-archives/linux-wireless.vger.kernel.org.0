Return-Path: <linux-wireless+bounces-10608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48D93EFBD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4471C21EBD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613413B286;
	Mon, 29 Jul 2024 08:19:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1B328B6;
	Mon, 29 Jul 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241197; cv=fail; b=sdl0IDHlsF/gnosK9HxRmOtEGLkkP/63BsMyqCTMJgcXQTQjKyVxixNbLeSThf1IqlJwkU+1JaH4pLk2KgFu3KhhYdVh30JYO1Jn1g9MsH90sIMhIjlGOT2e1OdrjxkwAmmAOKfDIUj1WJjL9eqRT+ezittGOiy27Fzl417Zb9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241197; c=relaxed/simple;
	bh=ynvL4yYDJGvadQp1Si5+3bWDGjniikfdq2bUYxBcvxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htDF7fFORTIqR9Ndj/5PeUNxIHiZO66KvVvA7UPTZI2md9JxlFB0cUf8HfiKt5JP2WuHZC2QEh6lpHiAxgVXVZ7sK58DgqkOTuTshtrf42ZPalUnfEYLYHaE0yIEpvnoylTbt+w8wvypkodHaPOxxxA2gyESeR3wwJASDAYRqrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXzNay+aWAJhwJz2z/1T68cn75hff0Evecg6wkB46wWRMjJha835tUbd2eYjpcIjVVsCckoas3xNlFOyhUm0UtN6YG+T5RU//uNm8iVC/xYQWwFiyqSFXUKvGTh0gEf34OwyYDEky6bqTpsxImkg18uqZl+2uMqS75P3p+6lwiuFBCt9HBgfQEVIt9uybhPFHL/vNZ/5T4CCEgycMwB2bngt2X0Ee6sms6d3hECO1tqEeKZI6+u7fnbhvUAp6oJIt3C+pQR2ox9gl5xGxkJ+rZDmbQOH47kmPmPArpUk86nbaUBSlVjaiQXA5jQM0c6i3IqnQyEMlgOuFYLsiEiY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynvL4yYDJGvadQp1Si5+3bWDGjniikfdq2bUYxBcvxc=;
 b=TlcBpNKuD1F6HU2KQpo8l3Trt8KoSyoMVaZI2lsnaWAjcbkLeB01bE4qeqAo9wI/cXNaKdNX+h7+ufHeRYJ58t9YtkgELLx83WkiRXWMFXAOU3s0XvVsfMtf/xLvlF9u3Y5lDMbFHW7bHuojU7WlzeXyegFQ/QmESpBun7WXbWBW+9QuNPZp93YhuS7WORMzcaoopJOm+9jb2X79SEekrM/pS08iHyxqelOPjiSJC9ilSRdAzFeBFYGQ9NtVkwWm65qZgp9AWoOaaq9uVrUfANewtU55yqyIUheyEhtwkCqCEtBJ+fIwJIrKoQNDaXZ0Nx/cQn9Je9tu78ICbXE03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7927.apcprd03.prod.outlook.com (2603:1096:990:34::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 08:19:50 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 08:19:50 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "efectn@protonmail.com" <efectn@protonmail.com>, "dsimic@manjaro.org"
	<dsimic@manjaro.org>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arend@broadcom.com" <arend@broadcom.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
	<megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Subject: Re: [PATCH v4 5/5] wifi: brcmfmac: add flag for random seed during
 firmware download
Thread-Topic: [PATCH v4 5/5] wifi: brcmfmac: add flag for random seed during
 firmware download
Thread-Index: AQHa4YUri4oXxg65yUKyQCOpF8AgybINWuIAgAABicc=
Date: Mon, 29 Jul 2024 08:19:50 +0000
Message-ID:
 <TYZPR03MB7001E3C50010694E5F12756080B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
 <20240729070102.3770318-6-jacobe.zang@wesion.com>
 <1c1fe7ec-1d6b-46ce-a90d-29ca6be01109@broadcom.com>
In-Reply-To: <1c1fe7ec-1d6b-46ce-a90d-29ca6be01109@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|JH0PR03MB7927:EE_
x-ms-office365-filtering-correlation-id: 0df7d244-8bfc-4cd8-8a43-08dcafa737a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?m/BHa7FY3RAEL/E9MOcp6fNWJ0Cg8ZUTacSThmS4hf8AefmSD3DPivLowd?=
 =?iso-8859-1?Q?uQmkeqTvSx2J+tczYqZTghN8DOL946k6kC39zyBPKrTa8O3D+VxZjNnRR1?=
 =?iso-8859-1?Q?BMLUffTbxNt/GjzSVLX87axfB/NNy2ZcIbl0pVjWskn17w+1cdUeX0Jic+?=
 =?iso-8859-1?Q?/zrQtFXcqpMBXQtTjBftboCFulD+l69pwvt2dv49llWdm6rmecaQv9eden?=
 =?iso-8859-1?Q?pCs/5fMZqLiVojYlUiJQfzzPKSQQra/EXAhroziBITdbNR0WOhEbbGYeVB?=
 =?iso-8859-1?Q?xO5xphlNCEQ8uZh7eEiE6e1qOu8ljbTPSADtfeXQrxTtTCUkomNa2RsfoM?=
 =?iso-8859-1?Q?NwpcflO4rj3VvxwlQP03s+D8L5hEPVF0T1u8roZFNciH37PU30dWKC/mzp?=
 =?iso-8859-1?Q?pq3UZ13jbhwkEjTqRowIl5WcdoZ+fLppPaM8gfnHkrBOKlTdGnprLT0OwK?=
 =?iso-8859-1?Q?G2qkRGsC6DeG3wtkAirkVFG54B/N7bJ3IeDZnAaEY11AkdQQnpc5lNGg5z?=
 =?iso-8859-1?Q?grqTKnOdiv8UEfW2peDttqdZmBiTsFHt1Eyh7jztxV30iSw/Qk7R02AK5H?=
 =?iso-8859-1?Q?syeAZChLV797ZwkIf6HuyDfs5Vr/Rpf3r8zHtdj8K22KEBrsDMMUpChRU8?=
 =?iso-8859-1?Q?saxFufuK+qtbzbTrk+CYFA4/ysuzdpibLqhMp2yGfH61cWQS6+/TUW97qE?=
 =?iso-8859-1?Q?w+SbzI4QTZLFFt5CvahIVom0A3Vxy2e37Y5vQH+4GWKyIj4nHfoSXq9dxS?=
 =?iso-8859-1?Q?oyGespf9ZtiNC6HwMkUGUA/6eSR8zDQITCnynvtDdbJVHT9zLsxiayBd1r?=
 =?iso-8859-1?Q?lkR968PH3wgUIlaTZcXd2b3Eeis1cticK9npt5rIopqTa6gkfltPGNrkOD?=
 =?iso-8859-1?Q?RXPbCDQjte7GAUyvfXLb5NZpW4iup2BrdNIDTKeFs7QNLnWWaVPpNXTBJf?=
 =?iso-8859-1?Q?IUj1dHSsaKTQrx7/Q8Fd3/omXjJhzLgtxND2cKfynghdb4jgVAQecXm+Dr?=
 =?iso-8859-1?Q?72++irmFktyQYFU2BnDZc29nP8fVP0QUsTm3jjlkxt4kRmYMNiU3X08KJL?=
 =?iso-8859-1?Q?9P21LqT8ehZoh6p+MvJlq/WeoQ+R3ZvTK7BTojlH4ydZ+rJqnZQ/yMXSPi?=
 =?iso-8859-1?Q?XFpp/giKhGa+iPEiWi8967mNMxev1+5JuY4euBVbhGLCXvqViyUunJBXxj?=
 =?iso-8859-1?Q?1tSE6nwZGAsoUhyhb27jANbHsJHDFMkOs60WssHF80IsM0Sp9CDSozLkbq?=
 =?iso-8859-1?Q?6X8vPpMyEdGveQy/atWXlhqPKftkuiQd0mpWUSanlEPReTTN0WszMB4jKr?=
 =?iso-8859-1?Q?qrfoK4VyZZ/ruh/REUWRenYDBNTQPGBFozy98qM04WYSaTO524ceiFi2ux?=
 =?iso-8859-1?Q?SQ/RMa7XZ9PjaW0Wk+HMKR4f5cs+wiZ/fibdauv6ucUi5qXpNtMaFSsvjM?=
 =?iso-8859-1?Q?0efz0aOeLkOKPt0tdrOhDBGN84NkVAbZD4X9pDBxbfDVZkAQa4jD2fLgeL?=
 =?iso-8859-1?Q?Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xzBe1DKibPWhZ0UXkLTibtV2sx0tije927iCvlS2k215oh77zLtQ6Mn86W?=
 =?iso-8859-1?Q?3n+bJT2i205fr13aLjOr8m0JmGl+pFgwCkwowrJtUWPyGtKZ/byFBP78Kd?=
 =?iso-8859-1?Q?eXz3hR7sdcfUMwUATinb18xI/a9jX8CTy+JtJw4KqyZ1zX2EjuA+U+h1vI?=
 =?iso-8859-1?Q?KZYgPQi0vMhlg+Fa+LFTWR8G7xXK/HJN0NBDX82LShNVZeBuIkwnddn7bA?=
 =?iso-8859-1?Q?gPiJXoUNyXjSpQxDKptOhcq6DESnmRaAIJf8zwXKI1WSkQD6mh3SmWo5NZ?=
 =?iso-8859-1?Q?rx1Nm0rtXWR+NsMozfOqziAajzaZZjd1gkQjbu2s/RWTcKqKNdL8QyBp7S?=
 =?iso-8859-1?Q?Y5eTrS+xAg361bdF0kCGo70yktFZM8mNk28mHcrgwk6fpC+8iePUXDP+JO?=
 =?iso-8859-1?Q?lWnrpz3nwA6SDUGqzQDIZZpxZU+HN2tNUeVamghDwufhaw2s7ALQ5Uer/d?=
 =?iso-8859-1?Q?MdRAhJWSoLbwUy5SjdIev0scbavrZ99KF7nH7qT0fRmADCkYBBGbjgevMn?=
 =?iso-8859-1?Q?GF8kkOTrsc6m1UUaz5JNOF4f45y+FsEg7Zz44c88YCJ2p7f+tQTDfKAGhu?=
 =?iso-8859-1?Q?bPcwIHBnZh1cGKqGX2TYADYPGzZ2ZGhWAsHLAey/XRITtZ7oh8c5gwtbvm?=
 =?iso-8859-1?Q?RA4evTnXAHjH8Lqm2/C1rGdjP2m/yhFwwhoOKDhYgEq6FaZm8JHtA8pHao?=
 =?iso-8859-1?Q?uqnpANAmfMseIC794o+TgI3PAaUy++DFoy45rJLckhGUu77PnfknhL7ys7?=
 =?iso-8859-1?Q?cHAhtAU3PXepXbv4ufIPRZXz8xaU1BAQYoMU0u4K0qFfmTXrpECUBmafHE?=
 =?iso-8859-1?Q?3Co5plLnaYKt79CWFof/5nQH7FDMqNjFzAmkggmuf6+UvuScvBgP+kUHWS?=
 =?iso-8859-1?Q?HTO0KoGNoW1J6Ql/AidHbdPUsKuUqu80UtHBhbxyUNeNessPG9I+9xN+8d?=
 =?iso-8859-1?Q?9hx7oMaUP+Em9oTSuQjCOKFOEPrn9INRcLmPEiFww4ce2odlm2TMAwwvue?=
 =?iso-8859-1?Q?pRbAqAHwd4HcYnbwFepFtXsYtG6xElsgzE37fg7jGS/Hk5Wm+5Mo3pXNBk?=
 =?iso-8859-1?Q?Prjs1Nt4HnIkTAOOA8Z9myR0EwpAj0kwfVKuyNtepc6ye7ja7KSqQ3zZti?=
 =?iso-8859-1?Q?ea5QDEaU7h7rs7ORpOMsN82SzdT4LqXB6eWT0R9s30GjY+5IlhYLjkcH2Y?=
 =?iso-8859-1?Q?dz6f+UpbMR9m21YN8ooARQLnS2F7aDw6UU36uHWM9IdYOvfX2/dsSCUBp9?=
 =?iso-8859-1?Q?gnAPrjhT1Wiqhx4bNBTsPPc1xmc8w/Ug+oCYjkkLnU5AKg5Vyp4ANpzyvX?=
 =?iso-8859-1?Q?e23dbVNF+LxXod25riOq27jRlDAgXQG4Ev6DHDQW+emNAGcslxker0cGHo?=
 =?iso-8859-1?Q?x+Lsf9D1gYi8UUc47shHCKLrXXyesaGlqD7FEoiQOyB7oz1DF5MwbHgpDn?=
 =?iso-8859-1?Q?LSQ2eGufIDL5lcLYJ9RrcHETgpnidnQJdwH4cn6qO1h9FTb/kKwuMTVDlM?=
 =?iso-8859-1?Q?VosLhhFHxIdD/TksrwDZbEvdkt/CuAKXw37B9DDief2yrL0X5rh3OqZ/n4?=
 =?iso-8859-1?Q?GEDgyeOJkXqyAi1PHEqyqO5cW1IaybztRS0Ydd7e/S1wCoUv6AmO/uLsc7?=
 =?iso-8859-1?Q?Ee0wW3Ohg7agz4ClpbCFp5AxY/fgZQWoH8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df7d244-8bfc-4cd8-8a43-08dcafa737a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 08:19:50.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mA6jmNQ9+lxFto4+P6SWc9yOu3lr1JXbqOzw3kvwKkxJaLugzRLdiZuQvMN0g/Zes5jc4UP68w9EF3oUX2ma2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7927

>> Providing the random seed to firmware was tied to the fact that the=0A=
>> device has a valid OTP, which worked for some Apple chips. However,=0A=
>> it turns out the BCM43752 device also needs the random seed in order=0A=
>> to get firmware running. Suspect it is simply tied to the firmware=0A=
>> branch used for the device. Introducing a mechanism to allow setting=0A=
>> it for a device through the device table.=0A=
>=0A=
> Not exactly what I meant by using my patch "as is". I would have kept=0A=
> the two patches separate, but it is not a deal breaker for me.=0A=
=0A=
Oh..so the correct approach should be for me to split this commit separatel=
y?=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

