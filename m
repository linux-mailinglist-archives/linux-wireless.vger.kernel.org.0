Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C21CD686
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgEKK2c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 06:28:32 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:19990
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbgEKK2b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 06:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhelPFzwet37cpeh2aUit3fGazEB2anNhB5Cj/ZiYnLYO7HVuQgIAihQBrWiPN6sbUAB+bl/LJVSM37ODhg8Mal6b+Wd7WKsWN6LJIsEmaxDSuF+Q6axvW1HbjdIsh0Ivo+HM4fUTNwib5ui7un8iVqpVoz8OZB6dzndVlElPsLiCCrB//AIZonX4xbfx2pXYRarnGtgUrHnUJlDtcU16s112Q0FHp7iFPjUR6/L7hFm6SXfqauaVuvhQ1BQ5LtAb/Edyim9zSKjKxWCqbvckPoR2FP2Pq5Xty2hgXvZD1Uxj57hJYSeuoy6GNT6Q9saL1VyNBHXa7nVA3jDKej6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjrCSk96OUbxLIkk/GfSd2qz/qCr22sxdd8iFpQ2Zjo=;
 b=CSGuTh+TFTYe8gN668ArrYhyBaqLjalKPwXV4fONFIHHoSBreQ/WFArbnVEWZIAxOK7Ybwn47qmZN9b8eN0GQ3wq8AzPg7z67LeZOKdUrjWSorZNRqSgzfgmM6DPLGha5I4X+9ZPN1tvwCV+/zKhQFNIMftDdZvoGRID0RxAAu5nZ77GaZEBtjK//QonIF12Dlw7XpNcBYHLXe3RLJRBA749c64QaC6T0MN0NAFnjmB0obauVnShs1JMtKoVyr0xjbrv1lCoIlBuQmilQI9m3114IICNDm490Sh4fwMG2H25VbLrpBsk/nLR1AsEBYNw4nikSZ2uPPIWYrWQngqY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjrCSk96OUbxLIkk/GfSd2qz/qCr22sxdd8iFpQ2Zjo=;
 b=cBd7AQdnFIU/Xpb3+ZRoEF043Oy4yedoQQhzkhgqPsT8Zl9HgBHwssCF47CGdbAevU+GVgmgfZB2yZRTj8OlHajByRjTI2QY7V+oEbTWI82i65cXRMSbPDvD0aygp8Y7d3gNUoiqjl9o8VGJbYGYvhnM3EKHEasdy33UiDcsLdY=
Received: from AM0PR01MB5857.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:159::28) by AM0PR01MB4740.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 10:28:27 +0000
Received: from AM0PR01MB5857.eurprd01.prod.exchangelabs.com
 ([fe80::581:eb6b:7fd:da2f]) by AM0PR01MB5857.eurprd01.prod.exchangelabs.com
 ([fe80::581:eb6b:7fd:da2f%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 10:28:27 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: QCA9984 and MU-MIMO
Thread-Topic: QCA9984 and MU-MIMO
Thread-Index: AdYnfE+zusqPz5p6RaGyHneXgzEmsA==
Date:   Mon, 11 May 2020 10:28:27 +0000
Message-ID: <AM0PR01MB5857C81C3797C8D8FCE8DC9E90A10@AM0PR01MB5857.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=acksys.fr;
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b85a3397-e04d-488c-e03c-08d7f5960af2
x-ms-traffictypediagnostic: AM0PR01MB4740:
x-microsoft-antispam-prvs: <AM0PR01MB47401F654D1DF3612B8BFA3390A10@AM0PR01MB4740.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcEUbhXeQphBob158XBZjIlH4ZI0YKzDFrejefAsIa1vqREy9S94T9dZcndmjLEUJMYy+ZYCKHhRUJG64mNEAbp1RVhHoHZCcjih6z4IEgWxTkjhfzTnYKR592dOreRb6TYs9diaC+aAaCVUklx+qHG+y9GrbE+ngE2C+3pxyAe2rKej4m54LP6POnJpo5HWMdaQoGmKonw74ehckT4Ji1d37G55NrkRmxPAgx9BG9a5iRCxq4pL4ZcoaS5v64LqsasW3OsPdUNPRA5eNjNOr/xmyXHIP9YQfBzUCwbjHQX2y7G/NDjPmzmHz8c+D6qmr+eI1TYqfFz/X0Dy7jpTLBMMDB6WzDBjf4TvMJ5dBVcRjPKB5Ue8m08ZO+2ceCl4lxKCR5svycF6y/mGBAKxZI3M620DjpbH3567zbN3DJkEibY7+zi1EIHskgbDPhBMOPQa0EOxHHvKIgB10EKzb5eh6/EF0vnoK7LXtQXsYQluFFORiE7/Vte2NC5V5nbcWp9enRvUBxV5LA9sn+fWog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR01MB5857.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(39830400003)(396003)(136003)(42606007)(33430700001)(508600001)(2906002)(71200400001)(55016002)(9686003)(8936002)(33440700001)(8676002)(86362001)(33656002)(64756008)(110136005)(76116006)(6506007)(4744005)(316002)(66556008)(26005)(66946007)(66476007)(5660300002)(186003)(52536014)(7696005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fCfzaostkk8DROMFzK8HiHWUjWlAbhfWD4ijbQQCBXY5USNIjhscUmojr3UziGhpdLw/W2kZSGfU59tHzY+jLcpp/u+czctrUHSOLK6cyHO7xGVHqWL2sNgS59Wv+RcGb1UV9KdNR11y9gmAMd0+XM5S16ZxkVDPB5Ox1dd0TDIDoBadqrNKET9cRwprMesPtc7uSnN0gmgEff6fgA1L46wPFJjYGuyaZdVVve6TnviMRFHFQLyS+a9QwTsh2sNpXozi1jHlt9lfOWNWGjN3KoUDGnDwlIbBHCjkzHwn1FbkA7mf6WaxmLmdD2NzxO3Jr6Wc+P727ibiBUfqNtSIkNkK5qVe9uyQ7asI21jNPoIFRfvPmPEb8U2+Tvj1xjKqiV6IEMX88UCiVPGsogD1gKtW/0OUfh53NmnNjOmVgQPy8kwtVkWuEiLmAvGLEcyaOn8HPmbcjk2inYiTpAwp2P+6S9BvIjl3fVck1qAb6/w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: b85a3397-e04d-488c-e03c-08d7f5960af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 10:28:27.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pE7sJgQySn8axAi0iNGWJZtpyBc+jadztMVSr9D5MTzbJHqzp8pFgO9UrfbOp87pjPJqX1vimzuRLKkkWT0QSgdpb6RZ8VHN5H14boiAtno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB4740
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

	I'm testing the MU-MIMO with QCA9984 chipset (WLE1216 from compex).
	My test platform use 3 products with the same wifi card and the same softw=
are. One product is an AP and the other are set in client.

	The mu-mimo doesn't work when I used my AP. If I used an AP from netgear t=
he mu-mimo work correctly. So the client side is correct.

	I analysed with wireshark to check the information in the frame.

	In the AP beacon the beamformer support bit is set
	In the station, the beamformee support bit is set.

	But the AP never send the null data packet (sounding frame) with mu-mimo r=
equest.

	I searched in the driver source code, and I didn't found the function in c=
harge of the transmitting of this frame.

	Who should send this frame, the driver or ath10k firmware?

	Thanks for your help.

	Regards.

Cedric Voncken.












