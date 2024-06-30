Return-Path: <linux-wireless+bounces-9724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32A991D0BE
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 11:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F8281D62
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647112D1ED;
	Sun, 30 Jun 2024 09:09:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835B41C6C;
	Sun, 30 Jun 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719738597; cv=fail; b=KEd7s7xEDTaLAh3bzKdQBYa9hMK89eKX3KpqHUORAKiQS9fT5C7J9z1bbH7uTB1c8xjf2vnaacT9Bwig1pwWbvwfS3GTGkfbiA/2r6oXd/D4pPiUYkkoqQxp1qRBrOyyDtIGS04VnPW83xbvJ7ZZMDMyqd0K0lS1F1X3lcdE3UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719738597; c=relaxed/simple;
	bh=iLrD+8PXYCzwZIE9U0Vvgl5eunFa+Ehh5Yr9EesSs2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yr7nzlebIlqqJtIGbCBnA6NtwCrBpUnKp31Dwuv0k2Gr4borENhdKQKlOWYAPYj3BygnvrW6xmM+dWG2drWYv+GSs1uLgjv4hI5yAlyiSAsFvDnOnUiQz88LRVct+chHDb/KsvOVl3ysNS2M7EJNoG9Z4S5HMJ+GmQEcrC7fgPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL7q3I/LNyh9jUxe+7sy8VYq0mIm4fKdlT9xahhGCSg9NWHGn/kq/VFmPPI6XRZKeyauhswsBr7/6uca16EYgw0xpWU1nm9+RO9SsajplHC8C0U9mQT8DNZP047MVo+NocY1cFAXXipveWxzAi9BHkxvpdt5XWHL/CwodRt69tP/61xgxQmJvLdlMkl+NGB1hZyxlhqwtWWAs0e6iptbXPN2/l2CojtlOoRMOYc34BCR/MiUyNxe1qpMe4Qxpv152Y5t6FMAIBeo7GlY+Y6SqSYUFIZAEwS2y+JSPGDVEG0EpIVxpcCUqS5UBz3QtKOYmTTLputWZZb3c3LcUW/F2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLrD+8PXYCzwZIE9U0Vvgl5eunFa+Ehh5Yr9EesSs2Q=;
 b=bUtR0Y5skO2U4eZfEL84CGfbrpkrlGU1g4/wIr1NuDGHUaqKL2J5VAHfXt+KUAkzaZqjUPmsSchNsmbVttYYGLpR7nW1uuQ8dSIaYdpgu3hPeOOhLpY7DM1noN/dUmZdlz1hU/1yaU5kPN2FGKLDn1V+XiLUXkpw1gyGPTi8qIvy3+GDlbyJcKj1xNcesYK2/irJ9FrJzyBTPQdIXH6jWiRoxcw5FsqSV/w4AJe1r1M10ubW9dr1JuJepsHoykrqpaaxAgDWWQ9wY3usMIqVyTi8k5Za/5gI5OpczArIbRfxxV4ymr5D6s/S/Y7cCPGsVidpvBknivVs0t1hhrL7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8545.apcprd03.prod.outlook.com (2603:1096:820:13e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 09:09:50 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 09:09:50 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Stefan Wahren <wahrenst@gmx.net>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "heiko@sntech.de"
	<heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
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
Subject: Re: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Topic: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Index: AQHaysA7C3v/Z5nX1k2k1WM+yxb95rHf/Y0AgAAE1Wo=
Date: Sun, 30 Jun 2024 09:09:50 +0000
Message-ID:
 <TYZPR03MB7001AC28827A86338BF2B77380D22@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-5-jacobe.zang@wesion.com>
 <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
In-Reply-To: <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|KL1PR03MB8545:EE_
x-ms-office365-filtering-correlation-id: 33a62a13-0d91-4b76-89dc-08dc98e46574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?o6X6MSxCJdnbZuXOgTOZ8vO2fnkq9j1S/K9E4vxP/fHiUrflZ6vH+ZS1PM?=
 =?iso-8859-1?Q?s9puaXPp6LSzqs/MRDdkzsnEPpcPCQfuPcAiSuuE0XMer5PEP1DHlsg6KO?=
 =?iso-8859-1?Q?03GeCO1IOtrdgJl8Sb4feeEC6LwpnolkJZZv1cXueMg5YJazBLG321axud?=
 =?iso-8859-1?Q?43BedD+jT8prd3x9wSYFugwtdy6eg3m87zDWo0ngOkPeKE1vHP3fUvfy8c?=
 =?iso-8859-1?Q?rmCBtjSEQKuVGBa3ZvwhTiA1alPn8LItTmo44bU1AXS48+aX00h+Y7sIs8?=
 =?iso-8859-1?Q?VotQa8CfshGEvIIU7015YPIuLcdnba1H/MGC9XISR4r5YURVsjbpiL977A?=
 =?iso-8859-1?Q?V3qw3v2VGShiF9V157d3wupwXewyCF2h1z6St3tTWDjTDm9SYGv80Z9mw2?=
 =?iso-8859-1?Q?JUrOzEgZvrkVIWlpCkJUElYHVTwx5xnOO6aYn/mDbtpoyHykb4tlr37/tv?=
 =?iso-8859-1?Q?KkeIjGU2ufSIaaYNNg6Gd0y4asmF2WyXa70ZR96FcN31JpJtl8mWT0Sc2D?=
 =?iso-8859-1?Q?nCyURxNzTG/6xHeRGvb3fmg3vtriiQQvljbC+OgrXEYydDlPL0kXN+zige?=
 =?iso-8859-1?Q?rFcnN5mwqgqAfrEFE3Y0opEYxJFVYmduv1p/GwXMXmjiYR9wEc7stZxrns?=
 =?iso-8859-1?Q?4bcbTw6heQnY7fL9O1waFxiE2qnxRjnkgnGV4NczBumaiGHGh4eHtaJUjn?=
 =?iso-8859-1?Q?llfeTZpYfDUgqzFSWXhPpnP89TwVWwmeTyin4z7Esu8IErNn9gPRwA1VG3?=
 =?iso-8859-1?Q?8OHLJdhq3DID5QzkvjHe2RHDukrhTfjtYUumEHBcZbpgUGlrf9rx4bAuCW?=
 =?iso-8859-1?Q?UD1J6G/B4t8Sq9xIqLtOgb1pF5XD7RiWgOUvmJdJyxCu6ZVXKenESCiC/s?=
 =?iso-8859-1?Q?brn/M9KCl9MraeUijyBzoBqMKbijGjTs6ixaZQg7jePydtrEWvBR2gVORr?=
 =?iso-8859-1?Q?B6Nbih5RGzVl+EAWzBm5qdlBNSIwRBwDqr2fAxHio3Hn/ZjN+t6sSt3jXL?=
 =?iso-8859-1?Q?HcigRQ4gThYNpXbbQN57JGUb21UP0nG0UZxOhTxk5xZ2EA4aYCz1jyKTfc?=
 =?iso-8859-1?Q?h7k2ub/fX14QGDBb60U8eAnODbuBtJ9X2BVjnaGKpR24QKZQW0Ru7X43TH?=
 =?iso-8859-1?Q?9rMTnALoFESC5a8Fbdcm0R0HFNNQQRV9zxzmrNDjUlu2SyPs1yf0EljjMY?=
 =?iso-8859-1?Q?snH4X4hT780sByWLbecfR4o0KlerOELGx/zHaqvW394U0Fap/QD5aiJ96F?=
 =?iso-8859-1?Q?7+pxDyApv7Z6CZQE1qTgD7sZqCdv+d50+GmQ1jxY+WSuXUOlhIUI0SQTmA?=
 =?iso-8859-1?Q?/CP/YU7RsUDlk+42IrxhbX8rjEX5ToDxiWifY1L26bprk5jEZw/RjUjs9h?=
 =?iso-8859-1?Q?WFsWUBQR0b0V1LKCSlmNvhwG7DFYV4Y09RwPbBnxdIq4K4I/0/4Ki2hlut?=
 =?iso-8859-1?Q?3hPsE7rjjdPLv3wO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HJgngX7hd1TcgeZrV3/BXZ6REs2rHIh7S+ImTKZbVwCmP0n30+ndl45RSU?=
 =?iso-8859-1?Q?5UD5/mBpp6kwKgOaHoRL5UZeDivyzspx7bZHEf5DQax4W0cSLTQuyC74Eg?=
 =?iso-8859-1?Q?3TLPzOVJw+50knVMFjAedZAAVwy9+XOX60EtDDUUMvnsrMgN6DkCoN/yo7?=
 =?iso-8859-1?Q?RBwL4VBNe5/h3/NAOOdC4ciKy9liGOrvyfS7YyW+iE1w3AO4/ensD/oQJG?=
 =?iso-8859-1?Q?cdepxnhjM2dk8ohDATfqSGWuAHqVZqff3CwftQDtKsDx32eID8iTjP7pNP?=
 =?iso-8859-1?Q?vGdK/QW8faF88t6KHH+KuTf7KkYkw/pEaiUlp4NZmbaZgNyEcmTb41pZSB?=
 =?iso-8859-1?Q?EAO/AwqN2qNWjqxr7rTY7Vtyj5rFKmqE1Dm385sC1SFCAROEhIEPOMjXNj?=
 =?iso-8859-1?Q?gxIgrmy/RlDKUGNjSGmWjQ5HmfacarBMgHv8T8pUZd/4JrpGGISg/aN0ST?=
 =?iso-8859-1?Q?E8/Hf4rhU3VCWuse5gfZ/pHLxudt5P3gY2JjYCq9VJZZQ//wSJqB9XbW57?=
 =?iso-8859-1?Q?xN9Hwf3LMVRUpYMFBBeNvg1Y3WBd6XcGaUA2b4uutD7Z5Pyto9lsL6nvRh?=
 =?iso-8859-1?Q?3ZKQRBDdn8zSZYEADettnntFYYnzMo9/FDNAlNKWzZel4Eeu2rhgW3vm0r?=
 =?iso-8859-1?Q?Z/AfOA+V09fJ1aXQ88fyAajHkAkDRN5wPFbsauzP/FAKZChWEJY3sK1Nao?=
 =?iso-8859-1?Q?dsWlxksMZvrbUWwAPZbvcFFbEA1C03zeMxYq/iDqSPX/5leMYHYankjVdZ?=
 =?iso-8859-1?Q?JLjSAQ27icqn9ms2KZp2oxo+lZ+yb5IE+QF99La+35QOuSmfep0W7b9uc2?=
 =?iso-8859-1?Q?BqZz8/IEqH0qnBPT8AAyFjEUXYNtPjyLcfJ6PWPaRUEJvE4XEj1+GHnjsT?=
 =?iso-8859-1?Q?jph/G7HgMEcbcAMILe1sRX+QChZgQeV4QHfzS+i7T6GetKiDeCkfaCfFwq?=
 =?iso-8859-1?Q?c91FIF6001ggdUm2ubVOV3E1DcwXsvM4quFJM9RBGp1zCGPPhBNqvH+PGE?=
 =?iso-8859-1?Q?A4a4VRiL8B3v05hbYc6ak7SGheS8oy5speC5vELn8CRJe8IGE3G4PcaVCG?=
 =?iso-8859-1?Q?c49OxgfRPcvThEJaSehZuiUoFewICe6vAat8TVFrDI636jiL/U73yF7yJD?=
 =?iso-8859-1?Q?y7qUYuEMoPX6WGMFUvAubF/k6VUVu32IOUji9HXdAtubamtULbCp/0MO6F?=
 =?iso-8859-1?Q?YT80sfZEjrpOh3zsGqHnzdYwUj381XqrAbeOUVJzksYcWWeCF+dYTVg0S2?=
 =?iso-8859-1?Q?vF8EgWnNJ+2/lqlW7zxJXLV3ou+wKifrAwQBKvllJwCg3O0f2uJVL7PBM2?=
 =?iso-8859-1?Q?0zI6b600F/JB6c5Vt4fAyXd4Lw8UkcEzjCm4lWYJTQyKcs5TjosuxjPr7/?=
 =?iso-8859-1?Q?eUhtJG90/EQ6Qa9zT38+QjLhY9euAJcixGk+Obasj7ZDLSIVERMG/pK+37?=
 =?iso-8859-1?Q?A3WsrztQmn47zs+cHBygeaYw48FBskdQ6SnOcdVqpJTXcUvto6TpgDobPA?=
 =?iso-8859-1?Q?gm7+LSuWQevrWIRPprUjY3lNkt+tQ/DWhB3VoYlc527f930DBimYkPPFzb?=
 =?iso-8859-1?Q?zMweHEranY7GkcW/8jYudO8FTX2a4XnjblxS4lSgPKR40H7vdDHFpqGcvH?=
 =?iso-8859-1?Q?yzQ9Op7KNf0cvVHQZuEQ0QkGkFNngPeaJ5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a62a13-0d91-4b76-89dc-08dc98e46574
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 09:09:50.1542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpSYPieq5q9Elsil23z4fJtutsZYDkYfpNA/RdXZ/hGXHZaeDbx6vr307nNQeArYFcKoax9ydCSYS9D7qOVswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8545

Hi Stefan,=0A=
=0A=
>> WiFi modules often require 32kHz clock to function. Add support to=0A=
>> enable the clock to PCIe driver.=0A=
> the low power clock is independent from the host interface like PCIe. So=
=0A=
> the clock handling should move to the common code. Sorry, not i cannot=0A=
> give a good suggestion, what's the best place for this.=0A=
=0A=
I think the clock is used by the PCIe device so enable it in this file. Als=
o I checked=0A=
use of clock which in spi[0] or sdio[0] device was enabled similarly to thi=
s.=0A=
=0A=
[0] https://lore.kernel.org/all/20210806081229.721731-4-claudiu.beznea@micr=
ochip.com/=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

