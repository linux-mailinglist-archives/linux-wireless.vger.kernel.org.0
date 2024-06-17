Return-Path: <linux-wireless+bounces-9050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACD90A5D0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D0B2782C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AFA17F36D;
	Mon, 17 Jun 2024 06:30:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD44DA1F;
	Mon, 17 Jun 2024 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605823; cv=fail; b=sxTpQi3JKVw7TwBcKTDIXWWgxL5dfSxS9gOS+clRAfjW/rLl6dUXhocdHeQhc4cja9Bt4JxCQU1HnnNgMljNFb+OdGmuu0o1VEiPWrdQo+rWn75WUXsfj7l2zvUxT6VUNcLzlZEDMOKKUoslw2Ft/UlfUPAUEVPNfwwB2imcOzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605823; c=relaxed/simple;
	bh=B3n1UV86aRJvlfT2Ha9MjIMrVu7wtgdBKEob+Sy5rCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQ6faSu5qlU95yIvJvjmBYpDZpwNuB+c3SG5731djr4QYCvoFYR39jzF5l2rij2DICFYU77/nI+E7W9e9YhyR9yvGSdrGFo2YxW5npB4xN3gtQXHkikWxeWOMB35qUafTkr7biVAy1poOnr7lJpelXv+vbh91E7IGonsMmlyuiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYHLD+xqLXPPDoBFXGf/NFkdXosXiYt2Rqsfif/ZVz5cXciTi3RByECR5LY9eVEkcoMp6ISQXGoYy6gWbhYBSNqZ/LOmA1B28ogJFu0ImsZgU9UYERqtg+w/lnCSfgDrEnNLExaY/9/K0oq5Nssx4j3ym+80SL4BeLnejcQmo9iq4ASE2IMkudvy+GP63qpnv3KabVOs4KNgvTYlHneJEHQwqvbSpBsKZfYbn9wb2zYbtNTkBeqQM5ET4k8w3UBAVFKgdZMRod6b1ZmGzae5ZbMqfTiB3kbVx1Nna6Iclo9I7PsM5Q+wrGGiN6ycOCrTEKkbQr1gxnO0Zw+LDCgzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3n1UV86aRJvlfT2Ha9MjIMrVu7wtgdBKEob+Sy5rCc=;
 b=GDyeJemBJDvjVrbGhyA2JKFcZhIzcx0Zr5GzCeZ/twxhGkwrOOWTrA11ETtQvZpdzT/eEQ6sNSFzkCE9X6fwoeaJaqBAqblqr6PIcKBQ++UrTGZ6eNBs5iSxNDGus8iRHPZ4TKM7FWuJCfuNKpIN7LozdsEjnp5XIVp76FDnwTmXSfaQdnQ8QTOkNLZmaXFvJebMnYM7uW0ChzFYGaKa9gjP1RO7XKnd0HesjiSpdrjhqKGzw/Bi3BQdMwUBeimu3U/BOi0bCLV5x1UAzvhqHVMjJnG2yYCsLjiE6wE/YgKMijXC0ySQhPlwdxcQRxJ/2Rx/E1bMLUMcgbYXw3QmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7728.apcprd03.prod.outlook.com (2603:1096:101:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 06:30:15 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 06:30:15 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Nick Xie <nick@khadas.com>, "arend@broadcom.com" <arend@broadcom.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: net: wireless: BCM4329 binding: add
 pci14e4,449d
Thread-Topic: [PATCH v1] dt-bindings: net: wireless: BCM4329 binding: add
 pci14e4,449d
Thread-Index: AQHawGAwKfgdJrUz80SR/3Lp8iKvprHLe7OAgAABBk4=
Date: Mon, 17 Jun 2024 06:30:14 +0000
Message-ID:
 <TYZPR03MB70014E22C5CD2BA3452F31D880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617024341.3106240-1-jacobe.zang@wesion.com>
 <bbd04c56-451a-4a5f-938c-2ce4ccec7253@kernel.org>
In-Reply-To: <bbd04c56-451a-4a5f-938c-2ce4ccec7253@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEYPR03MB7728:EE_
x-ms-office365-filtering-correlation-id: 23fbf06f-ee49-45cb-7bb3-08dc8e96f2d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wbMBjaFsMjRfnI2CIlI0t+1nmNstZyiO9lS1U3PNN8WUbMo/qJSFgK3bgr?=
 =?iso-8859-1?Q?rBdI9mv5krbsCuhayEmOAMiCNxxtyHG6g3Z8ryAqIWw+T7r/flCg8wbNh9?=
 =?iso-8859-1?Q?gw5JpcLf800tuXxslnSofu/OD8KXGx4XgPX1XQ5rAjX358UHqyh1+Pacyk?=
 =?iso-8859-1?Q?nyoP1VDgyKUqo0jrxL+aCxI1ZJIwgbRDT+H2+ap9ujW5WlQaGpu2HuPsfG?=
 =?iso-8859-1?Q?QAjYHTGXSmOv+Y0RWh2ExshHk31/iTlJr9xMf9fNGbkX2YPRhlT+GuQmv4?=
 =?iso-8859-1?Q?mI4r1bUhGPSA3knW39GHmtkAvfPeuoTUe9WRBhdfLMCkE+du1hpjM3hhBX?=
 =?iso-8859-1?Q?9CfOhUUPZGYRxU240d6pmI+YmXqoadMSBv3YaxoySpCPnC0yvr70lLnb9l?=
 =?iso-8859-1?Q?gFrpemBekk1WKzlhmj+1fmbq8dZq0vxfuVgzT5WbLqv/rSJrTbzkJkJzp6?=
 =?iso-8859-1?Q?mhl3uH0mXg2Ob0QhNsbjf6DXIofsDYuemqnVSiAXQhxUZPdVCPh8ig6s2i?=
 =?iso-8859-1?Q?ATIi4jpb6UOZ0Q8v45MZJSlgB/EAiMlLWFcEHDhIquTqMa/Qu/eb3rP4Lf?=
 =?iso-8859-1?Q?AF/jrIr1MSIpt6uTB+ZI/OkgI2hHZTZOjXT+1gC8Emj1Y24mxxDfVcIqvu?=
 =?iso-8859-1?Q?wS4CgKwCnAHfPMnNGe+dGALpqcmkUNxKT+xT2ULP6XT9xAvpaYeIJFo0ID?=
 =?iso-8859-1?Q?kXPK4S82fCF3ZHKI9enSfZKK9moepolBmF8S2or1dHdmeP1KfASh6J0wVY?=
 =?iso-8859-1?Q?449WuSSNtL4RI2+H/wZGxc/XTrdFXKMeB2hJx3cgMOrgwSvd0FH6bDaon3?=
 =?iso-8859-1?Q?NI71rqlir2C/lg3DBo8ntkD4AJ3KbwgLfx4GzY37VyjeVzJvxQAeMTMNx8?=
 =?iso-8859-1?Q?z3I7Vq9VjkA4H4xl1QJxYRCPilwLn+CtBoeun1V5UNgzB+4C6P2FfytCRV?=
 =?iso-8859-1?Q?k/i682ePARqBJ78bG3de9ane4qpqEidzTyKHp5ahOy93FR4l4zX155Pqk+?=
 =?iso-8859-1?Q?0nuZhvAtvQHjRZKspFXOKmziPZnBiTqZWK3GRVZSjm5L/eAf7YBYaEAu2/?=
 =?iso-8859-1?Q?5XtyuDBP4xCXjES7B1nUiMFgluITmZ8YO5sL4nDeHt/Zq7givY7yWuTnXG?=
 =?iso-8859-1?Q?fAx6VCdUI1ajYHbKb1Dyum4Dig+tz9asDOvPSl3C3ETWaQbp8bFto3pr0B?=
 =?iso-8859-1?Q?0GyYzxy0svUBixIijgyjgrw8UQdVdpThHdRTXrhmtJ/hMvk07nmc6ghUNG?=
 =?iso-8859-1?Q?nicoQd3JNBuA+017mnkRPvbeYipV9ZXV8KQVMKI2/i2IKiPYRoIPSU2W1q?=
 =?iso-8859-1?Q?xA9yE4KJaDnkk4FeuanY01e12G6CULFxRqRmR+m5DxFXnd7iXLxBRpZsSE?=
 =?iso-8859-1?Q?oRYEzcJplMpSGYJkQ35X2jqr3GGfo4E0jX8naTQ+LPZvao5OQUBUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LAj7KxfRotoVgENEW2Cpoc0bBDJ5MtaZ/uXsHQrzG3sk7pYd6IpP8RgmFj?=
 =?iso-8859-1?Q?onNZSA5anV1iVzNPcBjtfnd3buRPQAd3x2W7Zhfa9ZQ2xhw11U6d3cV3GO?=
 =?iso-8859-1?Q?DiPaUzW4TxNx5ezpGo/BEl8T69/d+288R2mMPIdS0pXtwjlqr8sbTHUxGm?=
 =?iso-8859-1?Q?b8U21iBDVBt/B3RYjXPF4HCZHf1m0KThyQsia6/qSiN2cwU8fYnyEPDZVL?=
 =?iso-8859-1?Q?fPHUsJpphJiPfYGOMGjkffoNEUNc54ezREm5a+Oi+sH56Azwtmk30446SG?=
 =?iso-8859-1?Q?thVmo4TwMXta4+sHtPLMBtR0oivSbHL7K0CQZtpUlOKFEDyfp2lsPcz+wv?=
 =?iso-8859-1?Q?VuKqJqjiOAwfw5GBOIDuZeXGXGKWnZP7UlwzeeNHi1QvWYY+oDFyeneIY9?=
 =?iso-8859-1?Q?CB1gOIfR/O2udb+Z/2fCJDlcZSTIxF4coqP5Kqxazwjy1Ggn5an3dzEXco?=
 =?iso-8859-1?Q?4pfHbPppHvnS5xX3kN3GO+Ug005HbN2jo7DpaDHLps/gC3WH8LiKFI8Edd?=
 =?iso-8859-1?Q?sZFGlpIFkI035aE9EATVv2unIZaYUFvglhL/QnmEYXgUrnRgt/lSfG2PBW?=
 =?iso-8859-1?Q?etf4sMwbY3OqoymYNG7QsjzakVJO0YTcLk39Ap139j+c9mvvOpyIannV6S?=
 =?iso-8859-1?Q?CfuPVAUaw9y0g95U1zxiYHS+xkiogV0Bp6fLzY1FNMDZOirpV+sRMdYNsa?=
 =?iso-8859-1?Q?m8t8yMB2nlF8waSe+pYnYY12dqZurKAoXu85rbWAzV3MCql8mBB7DQyAsq?=
 =?iso-8859-1?Q?pY/yHUztWMkIamO4LRNQCHzF7v4aJ+ZxmR6IWK+iF2N9LdVtM7wg+D8NTR?=
 =?iso-8859-1?Q?wCqmKkubGR+dZ/5SfogQ+tmllKEzjlLnQe4WQ7Dn4HrkE/5qrbEi5TepiJ?=
 =?iso-8859-1?Q?N32Hhf0TPyUFMenRJi/+e2XMHDfv7qgdoVYJ8j5I69XQTcvIgjlB0YGES9?=
 =?iso-8859-1?Q?/64rIBAtL278m9ZpwigxeEHXdO+LKjyms1fEpMHUuA0ylpBVUrmQiydtSp?=
 =?iso-8859-1?Q?jUPSn6Y+xo0Q4Pz2RoM+H1UbbZdxroSdL0BfVTdKsK9/7/Alz7ykRBpNef?=
 =?iso-8859-1?Q?49/IxWYYEfzyXfSVbU8bVzJTK4WSsSmnyPGI1n8OSvC2rExWhCfKMlFQDA?=
 =?iso-8859-1?Q?D3CfUXOrzhm4Wjyp9r6B3AwQcqHPxOQ5BAnrv/CpIxkHhwZ2gemmBRM5Kp?=
 =?iso-8859-1?Q?zKEsFfb/bVPFnw6ISB7Xu0p8Re3nm7BJ8RhqFMQXa9YO/EYv7wJpj5aqg6?=
 =?iso-8859-1?Q?QbRfr6aCKoYPAUvx6fkI6i60taF3suZbgdVjr4zGxDWw2q1xCw/++UeOUj?=
 =?iso-8859-1?Q?LnTBnGqa/KX/Bhwma9+/fLjZS172yPjGIdC37rQleGn0TTkrXJ2mWBalqn?=
 =?iso-8859-1?Q?bxOI7aeoLf5FoGc1niF2AokrmxgG3qKjPhIFMlpeXhR/IRUss2rQnQyPUR?=
 =?iso-8859-1?Q?mRr5/5dGM8BPI9pyAu6H6iMhL0UVmENftj4RxceRu3rVzfC9TZLyYszGvH?=
 =?iso-8859-1?Q?OfPShvByPmVGkQlk5QUXbruf6DmXuOVgUXvn79+ubMZoj5S5C9sq9rpLTS?=
 =?iso-8859-1?Q?Mcn0Kv1i79EQrpyVlpATsHgRHELpUHfGhOnIM+/7awFY9zdDxI6OHsjqmx?=
 =?iso-8859-1?Q?Wy6OBhqPAg3WfkAqKe28aA40ICmikDMbwT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fbf06f-ee49-45cb-7bb3-08dc8e96f2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 06:30:14.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIt9D9B4ygYj213r4ky+Unkq9ZCJcAdDB1Dvh1LddstxgrX5rZY+RGtOgh1T4ngjhWAuOahu60hnwBRENLYc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7728

> You do not add prefix here. Drop unrelated parts of commit msg.=0A=
=0A=
OK, I will remove unrelated parts. The reason why I added it is that when I=
 do ./script/checkpatch.pl the patch, it said the compatible is not documen=
t.=0A=
=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

