Return-Path: <linux-wireless+bounces-15816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A09DFC69
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 09:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7C7283A54
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E961F9AA7;
	Mon,  2 Dec 2024 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r/6eqt0Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011034.outbound.protection.outlook.com [52.103.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FC1D6DD8;
	Mon,  2 Dec 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129370; cv=fail; b=if6cM3SxE0mEa+cmQhEDz1TrETJDXzl4JEATZY9mzpzUzCKhtenRJwVswJM3brlN3SIm77/UdUgAgaQTXkGpghjlKyanWbdbO8EOnru3ZnQ5/JdgfpuxCRckBKMtx+XkWPsD3+n+Hr/P7WhmT1UOeE+ol/5dLl3dxL5jpcpRt0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129370; c=relaxed/simple;
	bh=pcVsEzPWMau22bnDqZizAl1MDVmjJdo1bS9WJEEDdCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6y11NQcI/iZDzHTVfJPFRG8H+yQdI0v28+F5QHUGtrGHesBWBAzAOUOhXba9L9FtF1OGJtjNBogaZCfnoqAyz7k3jt6fuhns4iWJcAq9FBC3bdvuaH9hAe3UGqN9cLu22bTSGF3WPDZgWRtstkVuL2WbpCMyQKbx455pgXV5IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r/6eqt0Y; arc=fail smtp.client-ip=52.103.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDtjGFUjOnWs3IbxMoJUplCiGvvR3yYqvJKQzYHADuMqr14UagDh/1Ip2zw28WBwGtA4Pqhu6CmwJMNraJZ796eRak1HG8ZeWMsmVFCCn1s8wqXzGNIuttLTX16qA8b6Z1jPijcFHQXws7LjQpYMNGhESQ5Gw5U11WL2f1UT6IK+x2gw4RABWxO5FBYNIU8IzX3ojO5F8Rm8xSLWhYoSjORvmva2Kwb69TCZAZonni6AGuyAr0tvtsJvEURWAXmMTv7Kzi2u3HRxcWVbu7UpDm+lR6xZuCm/81zv/GmxQ2rqK+itvVKeCNhHyxNP/bzXzCkDB3Novt7c79fgKBNo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcVsEzPWMau22bnDqZizAl1MDVmjJdo1bS9WJEEDdCE=;
 b=abwRrXa2PSHlSDIgY3hTPIkbP3jP5H91z5/569/6zEPOoG0f3Kic02/fJq/9VMdiL5uhBFQ52ogAEyXJjtuIOAkb6CA1Q1mghlPh1JXn1L63mnaa0PGGBUWd2reTTgnp1pPbipjpMRxs+rQxUl0kGRvw7PTBB7U0hVW9AcdLa0P1NplOV1W5CuL6Be1FFPPpM2acRSPMJg8/gEqeb+8ysw4vUm045r8VlwKZ/NPbTKW2jOGjBZbK38XXCcrDO+g2w+sJr5mJEUXhOrN6moszS5/Tga/exomUGHS9784vLVCBpGnwSFlXwrU3IHMGUnBDTSD33vZrNGO0SCyL5oMiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcVsEzPWMau22bnDqZizAl1MDVmjJdo1bS9WJEEDdCE=;
 b=r/6eqt0YI85KejYn32Bs125PDkXLFAYAsBcVL7hDydElUG2HwR+62ooKT9YiQ1LhCokhclKA8vKZG9v0+eYjXKeeTBBx2cp+4IuCKXr0RTRPRawQUKZRvi91oXSjT5QpJrL02bHouNR7By4J+7L6V5a9c6uKA1b1DRqjraAYtG/QasS/1mGSqsOyjuIcXrrZsxu1GaqYx1XNhmdwjHxdn9L4jp7hWPH7gTEMZCKqdf3H4Qht6y3NDBz7BiOZQZL9zACC97jx4eekCtx0x48aJgWZdH83Z4TTa6DDmZFMS0hhuvgmwKgaJw75nRwFtOtKe4jAKhH7z4oP2dYKGEA8gQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS9PR01MB12575.jpnprd01.prod.outlook.com (2603:1096:604:2fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 08:49:22 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 08:49:22 +0000
From: Qu Shengyu <wiagn233@outlook.com>
To: Felix Fietkau <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"ryder.lee@mediatek.com" <ryder.lee@mediatek.com>, "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>, "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "miriam.rachel.korenblit@intel.com"
	<miriam.rachel.korenblit@intel.com>, "money.wang@mediatek.com"
	<money.wang@mediatek.com>, "StanleyYP.Wang@mediatek.com"
	<StanleyYP.Wang@mediatek.com>, "meichia.chiu@mediatek.com"
	<meichia.chiu@mediatek.com>, "chui-hao.chiu@mediatek.com"
	<chui-hao.chiu@mediatek.com>, "johannes.berg@intel.com"
	<johannes.berg@intel.com>, "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
	"sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
	"allen.ye@mediatek.com" <allen.ye@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: Bo Jiao <bo.jiao@mediatek.com>, Qu Shengyu <wiagn233@outlook.com>
Subject: Re: [PATCH v6] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Topic: [PATCH v6] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Index: AQHa5zUf+1rZc22m80y9WRc+4mGdXLJJUMgAgAT4yACAhRYw3w==
Date: Mon, 2 Dec 2024 08:49:22 +0000
Message-ID:
 <TYCPR01MB8437833F5213A2AEBF808FE098352@TYCPR01MB8437.jpnprd01.prod.outlook.com>
References:
 <TY3P286MB26111E4DB0841A176DF8E44E98BE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <49a385d0-9ffc-468f-b7de-83abfa1e18f0@nbd.name>
 <TYCPR01MB843742DF3BB41BAC3B97C3C998982@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB843742DF3BB41BAC3B97C3C998982@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8437:EE_|OS9PR01MB12575:EE_
x-ms-office365-filtering-correlation-id: eec4b875-068b-43b1-3276-08dd12ae37c1
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|7092599003|6072599003|15080799006|8062599003|19110799003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?enprb2JXRkJmRFhxTStzTEQrMHk2VUlHa09jeVpvK1JMbnlmQnZvLzVmbE0x?=
 =?utf-8?B?M0Via1hHOGoxVEhGSUt3OWFmWXlzNnVGczYwUmdzdm95N2hmbzNHeDk4WHI5?=
 =?utf-8?B?M1V6UlJqalo0NmRtaUwvSXpWVE41dEpMams0VkdweUxBQlRDK1pjYlBGSlAz?=
 =?utf-8?B?QnVDYlJ2NW9DV04rS05jb05IQ1FNNStEN1lkeFJ6UGpSL08xTVpmVkZCMDBU?=
 =?utf-8?B?VDdzTTEzSUxIUGc3b0xrL1RaMmx0RDFFRW5IQ3dOSzNnWUVVb3c5azdiRFZY?=
 =?utf-8?B?Z203QnlHWDlIdnZQUFpGWDFQb1JZT2Q5Sk9LWGJqOHd0dUdaYkZUNWNkSzRG?=
 =?utf-8?B?SFZCU0x1dTd2ckg0R3lDa2ZSQVN3TFlRZHlabHRuZmFaTjU4N1R0QmI1MG9q?=
 =?utf-8?B?RGlmRWxTRlVRUzVoWkh1ZDBmWkhPdE1kbloydzBJQzJ3Ri94RnB0NGJNdTRY?=
 =?utf-8?B?OW1keUtmWDFyUWJoS0NMTTZteThadXp0THNyQ0tReEdIWEpHckxldTNocy9Q?=
 =?utf-8?B?OENLNmZLR3dtcEUxWnl2Rk50ZG1kT3o3N25yK2VmNDc4ZTVBRTBBQ1RrRkQ3?=
 =?utf-8?B?bGVMTE1TaGRIajd2Q216L2xlMTlLc1ZobWVNeitWUENnek12bGVOeEZjMkQ4?=
 =?utf-8?B?K3liRDNQUDEvcllPZWcrc0E1UWs4TG8wdUM4VFlOQWxDZzRheFRFbnNSbXFW?=
 =?utf-8?B?NTNiREgrSHhya096WDZRQUIyc3R6SEY0RzFSb0N2akRnNGZ0WXpjdVgzRnhs?=
 =?utf-8?B?QXBEQ0tBd1RYNW5LbjJSMkNCZ3F5bGpqY1Rab0dWbWNoOE1ZVHlCYTFzZ3VG?=
 =?utf-8?B?WGMrdDlkdTRvL2FtR1NSNjBwNTRDQW8yaldSa2ZQQlJoNm9TeWJLd3NqcFZI?=
 =?utf-8?B?UlE0ZnZ2Z2FCNGEySENqZWFQVVN2Z3lJN2JhbzdsQU1CRmdnb2o3c2VHSnBN?=
 =?utf-8?B?VnJaRyt1UmM0aHNhUG0xZTZQaUpJbGcyMHF4WHkya3l3OXpsc1ZETmFNcFlX?=
 =?utf-8?B?TEppVGN3N25RT3kxMHV5RkdWOTgrdlA3Ynhja1BuWEEwTkE5bVpvT1c5aE5V?=
 =?utf-8?B?Y0lXQ3NyN1dvZzFvdUIvNGw0bmdqSXRMQnQyNW1KakVsdlZyZ3VpMUF5RW54?=
 =?utf-8?B?bEhWTFEyMlNxODZlS1owbjRNQ3dWbDdKM3BaOTR0TWszL2lWRGlPTzdKdzhY?=
 =?utf-8?B?a1BudnRHUnhZZjlxbG5mQWtzTjNIcmpmeFpsVHMvUldlQTZ6Q2h0R25oempG?=
 =?utf-8?B?LzRYb3pZYUw2OENEWlRoR2VNd3QzZFFjOGl2eUtDZmZsVno4WUV6dnV5Wmxh?=
 =?utf-8?B?WGFJUTRLZVJrdkliSVB1eElMZGl6RjdlYWJXOG04bktLTFNIaGJ3RXBISlJm?=
 =?utf-8?B?aEZoT0puVVhKL0lpRjFJN1hpTE0xUjhtb2tnekFra3pleXhuazVad1dPREJs?=
 =?utf-8?B?bnllWGY3a05xVzFwMUltSk5KUXR1enIrUi80a0ZpSkwvNFl1TTZGNXNqOWdS?=
 =?utf-8?Q?jvfKOk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUg0RzhlTDlHZnFqbGtIVmszYkRtNXE2NmIyeVRFcTJiNnVxS0NGOE1RRTcw?=
 =?utf-8?B?UFNBZnJ0cmxZaGpITFJrb3IwbmcrK28vK1NZak5Xemh2QlBjWm95akcvZ2Ux?=
 =?utf-8?B?ckFOU1U2K1h6OVl0Q0ZnNjdxUEY1MEFlT0Z5bXNMU1J5NGtkb0E0Qk83Wi8z?=
 =?utf-8?B?UU40L21HbVdyazErLzFCc3dqeEdDRkp6K09TZ2F2Mm1EQjFmS2JGUmMvMk1k?=
 =?utf-8?B?elBVbnRmUk5tZ1JTTFV1N1c1K0JxQzRxNFF4T0dBNTJ3MWtZY0o4R1lFd28w?=
 =?utf-8?B?RVNBZCtJMTRLUTNjQXNyaVE4Ujl0aFRXZ1U2bWs4Tit4MFZUQlhKcGl2by92?=
 =?utf-8?B?dlJDUUFpWlg4cEFlTHFZbUdYckFldnVicmNXUWVxaVBnSVpFOGlYSDdmeEJU?=
 =?utf-8?B?MGh3SXdKeExCZGNGRzlraXZlZ1BXMHgzWUsreE53cXdobXBxSkxyaUxoaWV6?=
 =?utf-8?B?cVZyWVlBVk1RcTF6L1EwUmI3bkVRWVRESklNUEYvZ3Q4aTllelQ1SnA5MmEr?=
 =?utf-8?B?ZXFWM3loalpsakFxdDNhK2J4Tmh5NTdvelBxMzY4QUx5UStReUVJWHZDa0lD?=
 =?utf-8?B?bDhlSWJYeVlVZ0EwZ0cvM25Wb2JUOGZJbkNSK3lVeXp2eGE0dCsyYTVIaVdj?=
 =?utf-8?B?bFprb1FzVGRXWS9XQXRZNUZBM1ZGemxad1lpanZzSS9MU29LUlJHN0pXZmI0?=
 =?utf-8?B?aEorT24ra29ZUUVycmRSSnpWb1FsSy9qc3lYa0N2d21hZWNOZ1FVbVUxQk45?=
 =?utf-8?B?RGt0dFhSd1p5TXMrMlRWYUhUK1p1UTJFT292K0xUMjlybGYwV20vSEtHaEQ3?=
 =?utf-8?B?SmJicnl6emFvNDlSenNaSUM1SURwcnZ1dkFSbVZLblZZUkc0eVVaTjE4ZXRx?=
 =?utf-8?B?V3YrbGk2dXBFaEFmZlRoZzhNQXBYREhCNThYWUFHL2tGRlhBQjRVdTVwdHJw?=
 =?utf-8?B?YS9KVDVIOW0zTVZtZndFalFaWUg3VUdNVldCZGRncXRIWWFIcGY5bi9YcmpP?=
 =?utf-8?B?ZE85ZWpWamhnbDJwdnVBMC9EYXlvSzduQU5vRWdtTTBhQlViTmhkcGIwQWFR?=
 =?utf-8?B?SmtiNW56WFNGclQ5QXVVSlkySmdlUHVjU2tKQkh5TWdUOGR6RUhkZytxVU9s?=
 =?utf-8?B?SXFtZHBIZ1AyOUlrT1kySFlhcHdBK0dSUURuSFE3bHJicXJ4b3JZdnh5b2hB?=
 =?utf-8?B?Q3hHQ0RUdjkra2REaHlacUNzaVlZdXdLenRJNXVWSFFaeUtOclBDd3hXdGpZ?=
 =?utf-8?B?RVZvQXQwWk5xYXl0aFNUR2dlb3dkVmlTVjZFME54WmhvdWdnQWFvQUxpbjhj?=
 =?utf-8?B?YUNJQW8xUVZLc2txK3pyWEg0WkRiUUpDTFBiZ1RQYXhvSy9pQWF1Qm50ZFlU?=
 =?utf-8?B?anVGdHBabHE3dG9KTXphMXh4bXRxWGpaakFhL0xpeiszVHJBZ056TG9HNEl5?=
 =?utf-8?B?cUoyZXVXMDZUZjRWalRBWngrYTZrb0FLVmJqemZvTGNXVjdOeGI5ZVF1OU9a?=
 =?utf-8?B?NzJSTjlvUTNzU0ZZbnZKVWNMOTQvRVBrOURBQ3ZvUlh6anpVU0JuVGprSi94?=
 =?utf-8?B?NWNvYzhzT1NndUUrTmlibUlCRk82VUp1djhqUHo1VkRXNGRWQ0hhQmYveVJm?=
 =?utf-8?B?SGFxZjFoV0FNSWlkY2o4Sk9DSGJoTmpDdk4rMVJNbEF5elhuYVZBY3dqdUJP?=
 =?utf-8?B?T1AvYTNaYXFTOHNNWHIxblI1Wm5NLzZTbTZzdFJRU3FlcG5QOTRDNmpPMUgx?=
 =?utf-8?Q?AO2TWCpDZ/KubNxNFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eec4b875-068b-43b1-3276-08dd12ae37c1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 08:49:22.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12575

SGVsbG8gRmVsaXgsDQoNClNvcnJ5IHRvIGJvdGhlciBidXQgYW55IHVwZGF0ZXMgb24gdGhpcz8g
SSByZW1lbWJlciB0aGF0IHlvdeKAmXZlIGFncmVlZCB0byB0YWtlIG92ZXIgdGhpcyBwYXRjaCBv
biBJUkMuDQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0KPiDlnKggMjAyNOW5tDnmnIg55pel
77yMMDA6MjfvvIxTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT4g5YaZ6YGT77yaDQo+
IA0KPiDvu78NCj4+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tYWluLmMNCj4+PiBpbmRleCAwNDkyMjNkZjliZWIxLi5kYzRkODdlMDA0YTBm
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L21haW4uYw0KPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21haW4uYw0KPj4+IEBAIC03NDUsOCArNzQ1LDE1IEBAIGludCBtdDc5MTVfbWFjX3N0
YV9hZGQoc3RydWN0IG10NzZfZGV2ICptZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0K
Pj4+ICAgICAgIGJvb2wgZXh0X3BoeSA9IG12aWYtPnBoeSAhPSAmZGV2LT5waHk7DQo+Pj4gICAg
ICAgaW50IHJldCwgaWR4Ow0KPj4+ICAgICAgIHUzMiBhZGRyOw0KPj4+ICsgICAgdTggZmxhZ3Mg
PSBNVDc2X1dFRF9ERUZBVUxUOw0KPj4+IC0gICAgaWR4ID0gbXQ3Nl93Y2lkX2FsbG9jKGRldi0+
bXQ3Ni53Y2lkX21hc2ssIE1UNzkxNV9XVEJMX1NUQSk7DQo+Pj4gKyAgICBpZiAobXRrX3dlZF9k
ZXZpY2VfYWN0aXZlKCZkZXYtPm10NzYubW1pby53ZWQpICYmDQo+Pj4gKyAgICAgICAgIWlzX210
NzkxNSgmZGV2LT5tdDc2KSkgew0KPj4+ICsgICAgICAgIGZsYWdzID0gdGVzdF9iaXQoTVRfV0NJ
RF9GTEFHXzRBRERSLCAmbXN0YS0+d2NpZC5mbGFncykgPw0KPj4+ICsgICAgICAgICAgICAgICBN
VDc2X1dFRF9XRFNfQUNUSVZFIDogTVQ3Nl9XRURfQUNUSVZFOw0KPj4+ICsgICAgfQ0KPj4+ICsN
Cj4+PiArICAgIGlkeCA9IF9fbXQ3Nl93Y2lkX2FsbG9jKG1kZXYtPndjaWRfbWFzaywgTVQ3OTE1
X1dUQkxfU1RBLCBmbGFncyk7DQo+Pj4gICAgICAgaWYgKGlkeCA8IDApDQo+Pj4gICAgICAgICAg
IHJldHVybiAtRU5PU1BDOw0KPj4gSSdkIHByZWZlciB0byByZXBsYWNlIHRoZSBtdDc2X3djaWRf
YWxsb2MgZmxhZ3MgYXJndW1lbnQgd2l0aCBhbiBleHBsaWNpdCBzdGFydCBvZmZzZXQgYXJndW1l
bnQuDQo+IA0KPiBIaSBGZWxpeCwNCj4gDQo+IEknbSBub3QgcmVhbGx5IGZhbWlsaWFyIHdpdGgg
bXQ3NiBjb2RlLCBqdXN0IGEgZW50aHVzaWFzdCB0aGF0IHdhbnRzIHRvDQo+IG1ha2UgV0RTK1dF
RCB3b3JraW5nLiBTbyBJJ20gbm90IHN1cmUgaG93IHRvIGRvIHRoaXMgY29ycmVjdGx5Li4uIE1h
eWJlDQo+IGl0J3MgYmV0dGVyIGZvciB5b3UgdG8gdGFrZSBvdmVyIHRoaXMgcGF0Y2gsIHNvcnJ5
Lg0KPiANCj4+PiBAQCAtMTIwMSwxMiArMTIwOCwyNyBAQCBzdGF0aWMgdm9pZCBtdDc5MTVfc3Rh
X3NldF80YWRkcihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCj4+PiAgIHsNCj4+PiAgICAgICBz
dHJ1Y3QgbXQ3OTE1X2RldiAqZGV2ID0gbXQ3OTE1X2h3X2Rldihodyk7DQo+Pj4gICAgICAgc3Ry
dWN0IG10NzkxNV9zdGEgKm1zdGEgPSAoc3RydWN0IG10NzkxNV9zdGEgKilzdGEtPmRydl9wcml2
Ow0KPj4+ICsgICAgaW50IG1pbiA9IE1UNzZfV0VEX1dEU19NSU4sIG1heCA9IE1UNzZfV0VEX1dE
U19NQVg7DQo+Pj4gICAgICAgaWYgKGVuYWJsZWQpDQo+Pj4gICAgICAgICAgIHNldF9iaXQoTVRf
V0NJRF9GTEFHXzRBRERSLCAmbXN0YS0+d2NpZC5mbGFncyk7DQo+Pj4gICAgICAgZWxzZQ0KPj4+
ICAgICAgICAgICBjbGVhcl9iaXQoTVRfV0NJRF9GTEFHXzRBRERSLCAmbXN0YS0+d2NpZC5mbGFn
cyk7DQo+Pj4gKyAgICBpZiAobXRrX3dlZF9kZXZpY2VfYWN0aXZlKCZkZXYtPm10NzYubW1pby53
ZWQpICYmDQo+Pj4gKyAgICAgICAgIWlzX210NzkxNSgmZGV2LT5tdDc2KSAmJg0KPj4+ICsgICAg
ICAgIChtc3RhLT53Y2lkLmlkeCA8IG1pbiB8fCBtc3RhLT53Y2lkLmlkeCA+IG1heCAtIDEpKSB7
DQo+Pj4gKyAgICAgICAgc3RydWN0IGllZWU4MDIxMV9zdGEgKnByZV9zdGE7DQo+Pj4gKw0KPj4+
ICsgICAgICAgIHByZV9zdGEgPSBremFsbG9jKHNpemVvZigqc3RhKSArIHNpemVvZigqbXN0YSks
IEdGUF9LRVJORUwpOw0KPj4+ICsgICAgICAgIG10NzZfc3RhX3ByZV9yY3VfcmVtb3ZlKGh3LCB2
aWYsIHN0YSk7DQo+Pj4gKyAgICAgICAgbWVtbW92ZShwcmVfc3RhLCBzdGEsIHNpemVvZigqc3Rh
KSArIHNpemVvZigqbXN0YSkpOw0KPj4+ICsgICAgICAgIG10NzkxNV9zdGFfYWRkKGh3LCB2aWYs
IHN0YSk7DQo+Pj4gKyAgICAgICAgc3luY2hyb25pemVfcmN1KCk7DQo+Pj4gKyAgICAgICAgbXQ3
OTE1X3N0YV9yZW1vdmUoaHcsIHZpZiwgcHJlX3N0YSk7DQo+Pj4gKyAgICAgICAga2ZyZWUocHJl
X3N0YSk7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICAgICAgIG10NzZfY29ubmFjX21jdV93dGJs
X3VwZGF0ZV9oZHJfdHJhbnMoJmRldi0+bXQ3NiwgdmlmLCBzdGEpOw0KPj4+ICAgfQ0KPj4+IA0K
Pj4gSW4gb3JkZXIgdG8gdXBkYXRlIHRoZSBjb2RlIGJhc2VkIG9uIG15IGxhdGVzdCBjaGFuZ2Vz
IGFuZCB0byBmaXggcG90ZW50aWFsIHJhY2UgY29uZGl0aW9ucyBvbiB0eC9yeCBwYWNrZXRzIGR1
cmluZyB0aGUgdHJhbnNpdGlvbiwgcGxlYXNlIGNoYW5nZSB0byB0aGlzIG9yZGVyOg0KPj4gMS4g
Y29weSB0aGUgc3RhDQo+PiAyLiBhbGxvY2F0ZSBhIG5ldyB3Y2lkDQo+PiAzLiBjaGFuZ2UgdGhl
IHdjaWQgaW5kZXggaW4gdGhlIGNvcGllZCBzdGEgdG8gdGhlIG5ld2x5IGFsbG9jYXRlZCB3Y2lk
DQo+PiA0LiBjYWxsIG1jdSBmdW5jdGlvbnMgb24gdGhlIGR1cGxpY2F0ZSBzdGEgZm9yIGNyZWF0
aW5nIHRoZSBuZXcgc3RhIGVudHJ5Lg0KPj4gNS4gdXNlIHJjdV9hc3NpZ25fcG9pbnRlciB0byBw
b2ludCBkZXYtPndjaWRbbmV3X2lkeF0gYXQgJm1zdGEtPndjaWQNCj4+IDYuIHN3YXAgd2NpZCBp
bmRleCBiZXR3ZWVuIHJlYWwgc3RhIGFuZCBkdXBsaWNhdGVkIHN0YQ0KPj4gNy4gcmN1X2Fzc2ln
bl9wb2ludGVyKGRldi0+d2NpZFtvcmlnX2lkeF0sIE5VTEwpDQo+PiA4LiBzeW5jaHJvbml6ZV9y
Y3UoKQ0KPj4gOS4gY2FsbCBtY3UgZnVuY3Rpb25zIHRvIGRlbGV0ZSB0aGUgZHVwbGljYXRlIHN0
YSdzIGVudHJ5IChwb2ludHMgdG8gb2xkIHdjaWQgYWZ0ZXIgdGhlIHN3YXApDQo+PiAxMC4gZnJl
ZSB0aGUgZHVwbGljYXRlZCBzdGENCj4gDQo+IE5vdywgdGhlIG10NzkxNV9zdGFfc2V0XzRhZGRy
IGZ1bmN0aW9uIGxvb2tzIGxpa2UgdGhpcyhfX210NzZfd2NpZF9hbGxvYw0KPiBub3QgbW9kaWZp
ZWQpLCBkbyB5b3UgdGhpbmsgaXQncyBhY2NlcHRhYmxlPw0KPiANCj4gc3RhdGljIHZvaWQgbXQ3
OTE1X3N0YV9zZXRfNGFkZHIoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQo+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiAgICAgICAgICAgICAgICAgc3RydWN0
IGllZWU4MDIxMV9zdGEgKnN0YSwNCj4gICAgICAgICAgICAgICAgIGJvb2wgZW5hYmxlZCkNCj4g
ew0KPiAgICBzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2ID0gbXQ3OTE1X2h3X2Rldihodyk7DQo+ICAg
IHN0cnVjdCBtdDc5MTVfc3RhICptc3RhID0gKHN0cnVjdCBtdDc5MTVfc3RhICopc3RhLT5kcnZf
cHJpdjsNCj4gICAgaW50IG1pbiA9IE1UNzZfV0VEX1dEU19NSU4sIG1heCA9IE1UNzZfV0VEX1dE
U19NQVg7DQo+ICAgIHN0cnVjdCBpZWVlODAyMTFfc3RhICpwcmVfc3RhOw0KPiAgICB1OCBmbGFn
cyA9IE1UNzZfV0VEX0RFRkFVTFQ7DQo+ICAgIGludCB0ZW1wX2lkeDsNCj4gDQo+ICAgIGlmIChl
bmFibGVkKQ0KPiAgICAgICAgc2V0X2JpdChNVF9XQ0lEX0ZMQUdfNEFERFIsICZtc3RhLT53Y2lk
LmZsYWdzKTsNCj4gICAgZWxzZQ0KPiAgICAgICAgY2xlYXJfYml0KE1UX1dDSURfRkxBR180QURE
UiwgJm1zdGEtPndjaWQuZmxhZ3MpOw0KPiANCj4gICAgaWYgKCFtc3RhLT53Y2lkLnN0YSkNCj4g
ICAgICAgIHJldHVybjsNCj4gDQo+ICAgIGlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUoJmRldi0+
bXQ3Ni5tbWlvLndlZCkgJiYNCj4gICAgICAgICFpc19tdDc5MTUoJmRldi0+bXQ3NikgJiYNCj4g
ICAgICAgIChtc3RhLT53Y2lkLmlkeCA8IG1pbiB8fCBtc3RhLT53Y2lkLmlkeCA+IG1heCAtIDEp
KSB7DQo+ICAgICAgICBwcmVfc3RhID0ga3phbGxvYyhzaXplb2YoKnN0YSkgKyBzaXplb2YoKm1z
dGEpLCBHRlBfS0VSTkVMKTsNCj4gICAgICAgIG1lbW1vdmUocHJlX3N0YSwgc3RhLCBzaXplb2Yo
KnN0YSkgKyBzaXplb2YoKm1zdGEpKTsNCj4gICAgICAgIGlmIChtdGtfd2VkX2RldmljZV9hY3Rp
dmUoJmRldi0+bXQ3Ni5tbWlvLndlZCkgJiYNCj4gICAgICAgICAgICAhaXNfbXQ3OTE1KCZkZXYt
Pm10NzYpKSB7DQo+ICAgICAgICAgICAgZmxhZ3MgPSB0ZXN0X2JpdChNVF9XQ0lEX0ZMQUdfNEFE
RFIsICZtc3RhLT53Y2lkLmZsYWdzKSA/DQo+ICAgICAgICAgICAgICAgIE1UNzZfV0VEX1dEU19B
Q1RJVkUgOiBNVDc2X1dFRF9BQ1RJVkU7DQo+ICAgICAgICB9DQo+IA0KPiAgICAgICAgdGVtcF9p
ZHggPSBfX210NzZfd2NpZF9hbGxvYyhtZGV2LT53Y2lkX21hc2ssIE1UNzkxNV9XVEJMX1NUQSwg
ZmxhZ3MpOw0KPiAgICAgICAgKChzdHJ1Y3QgbXQ3OTE1X3N0YSAqKXByZV9zdGEtPmRydl9wcml2
KS0+d2NpZC5pZHggPSB0ZW1wX2lkeDsNCj4gICAgICAgIG10NzkxNV9zdGFfYWRkKGh3LCB2aWYs
IHByZV9zdGEpOw0KPiAgICAgICAgcmN1X2Fzc2lnbl9wb2ludGVyKGRldi0+bXQ3Ni53Y2lkW3Rl
bXBfaWR4XSwgJm1zdGEtPndjaWQpOw0KPiAgICAgICAgdGVtcF9pZHggPSBtc3RhLT53Y2lkLmlk
eDsNCj4gICAgICAgIG1zdGEtPndjaWQuaWR4ID0gKChzdHJ1Y3QgbXQ3OTE1X3N0YSAqKXByZV9z
dGEtPmRydl9wcml2KS0+d2NpZC5pZHg7DQo+ICAgICAgICAoKHN0cnVjdCBtdDc5MTVfc3RhICop
cHJlX3N0YS0+ZHJ2X3ByaXYpLT53Y2lkLmlkeCA9IHRlbXBfaWR4Ow0KPiAgICAgICAgcmN1X2Fz
c2lnbl9wb2ludGVyKGRldi0+bXQ3Ni53Y2lkW3RlbXBfaWR4XSwgTlVMTCk7DQo+ICAgICAgICBz
eW5jaHJvbml6ZV9yY3UoKTsNCj4gICAgICAgIG10NzkxNV9zdGFfcmVtb3ZlKGh3LCB2aWYsIHBy
ZV9zdGEpOw0KPiAgICAgICAga2ZyZWUocHJlX3N0YSk7DQo+ICAgIH0NCj4gDQo+ICAgIG10NzZf
Y29ubmFjX21jdV93dGJsX3VwZGF0ZV9oZHJfdHJhbnMoJmRldi0+bXQ3NiwgdmlmLCBzdGEpOw0K
PiB9DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFNoZW5neXUNCj4gDQo+PiBUaGlzIHNob3VsZCBh
bGxvdyBtZ210IHR4L3J4IHRvIHdvcmsgd2hpbGUgdGhlIHN0YSBpcyBiZWluZyBtaWdyYXRlZCB0
byB0aGUgbmV3IHdjaWQgZW50cnkuDQo+PiAtIEZlbGl4DQo+IDxPcGVuUEdQXzB4RTM1MjBDQzkx
OTI5QzhFNy5hc2M+DQo=

