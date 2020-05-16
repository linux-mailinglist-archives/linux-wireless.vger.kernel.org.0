Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0B1D5F97
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 10:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgEPIRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 04:17:21 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:38882
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgEPIRU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 04:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+GdqpOPSRR7ezBKDgK++vugiueZlUIY97kKskDR9euTb/ZHujXVXF89hdNf9OxcT6xuScKp4Gj+HXtq3V9HPkLJdAYfzu6OM2uTWsi1mbtapb/7CBn62hJ71YDSAosLHzRR1L2IA4vV+gUGOHBJw/KofHnS7POgZtRudfoM1JcEBn1h+ZxEl+ZLpv9hrijolFswTwGUF54iceFbTqmw9qFwhAuTP2aSSTrO/x+doMSovLuMUFpOfiYZQnVKvQFHYrgCqq7GTiB9S0L7os/pFCeNEfcywAKAM1GWKuZh+Da5bkDYZszb0eSgQeZvWUQYtbhOVQ5mF6JNjOW7T0ER2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoIHbYVNRhSTZKy/3H1bk9U0yapx8IAlAuychXV9BKc=;
 b=DhIyWymPVcguH5a+hXgb+b+c5x2nFz1jnSbIupcHN4h+oQLVZDb0VjB4AbgD8tsYW+0RimCkg6o1UP5T9+OgWm3jiDSfTBbh8ZotX2SH6e9pMbdHrEwYHwk2V7unCPnvn6lM03+aMZWpvotGaldC5AczJdULL46WIbeD6uaiueb4G2kO1b+W7jcCJ9MpPp9ZoNZQ8O4vChsOWDz5QfLDmRvQm5tw5VHvKbe1AxIqQbQvSzx+yfwcbVt0NBQmr5zSkE3BUuuNkYc8TEQBOcUmc1RIKKqJtdiyXb72UAI4nTGRltAsNjVane3t3ZvciU9GhMLXtFlaTTg6hcE6l7d7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoIHbYVNRhSTZKy/3H1bk9U0yapx8IAlAuychXV9BKc=;
 b=P+RMnErTjFXPSb0kozDo55c4Ptu73/yTRjSEiD01DVmkHm6ZkTJEsua2s4wFAoP7jL3TvTNO0HPcNWHcx+lq+K2PrJsli7LAa//+bziytCl5EfMY1oVivLcS5U1xCNNV0sVbO+m9O/uCAd2mIUhGMsADj1GeB+m+JsnnHSde6r0=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB6253.eurprd04.prod.outlook.com (2603:10a6:803:f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Sat, 16 May
 2020 08:17:17 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 08:17:17 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        =?iso-8859-1?Q?Marek_Beh=FAn?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Topic: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Index: AQHWKrwXtO/N2oQua0+uJ10PPhSg4aiqXxHQ
Date:   Sat, 16 May 2020 08:17:17 +0000
Message-ID: <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200515132353.vfor7v4buzoddfmb@pali>
In-Reply-To: <20200515132353.vfor7v4buzoddfmb@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1c46a81-ffd5-419e-1b0c-08d7f9718c01
x-ms-traffictypediagnostic: VI1PR04MB6253:
x-microsoft-antispam-prvs: <VI1PR04MB625351D0B69455EE1D6136F58FBA0@VI1PR04MB6253.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3NwSc4HTvY4v+pP8o36PlO0uS75hO0j2K1OEu5feRPUjnAEPDsW2Gex38Q3AIJA2snOK7+tUZdiqAZQqxwPwSCg2fkozVpkVVrPp1EbBC0nlAdC6+gW2bAwBEs0/ocWNYKNxsc5AWhxYEEIk4/pKLG7My1gWt9HOwc2ZkhOyE/AsUoChw7DswUdPl5+v2fensyUXK9qjO3wvKtaVMp9AmQpAIT+UJVf7jRUkSLOYEXShSunbmTmKOTxiJZjY8Wld5rbnFc+xu8TKk5tMoLy8Ws6g6K3hOUUlZZlhghtMpydEiOsvbFGDykYiYrLoByxAtl/0pYNpcF2lD7rIGBUrmPafAXizzDf5MebEzWTmG+Hs5P4n6nhdW2OI6R6BwUbNi2jpZ7kjkpKMBBoYXaPYM7n606MTIxwHwsojh2mesWP5IWL8Fre1y9rXCXlyeGZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(33656002)(52536014)(558084003)(5660300002)(110136005)(66946007)(66446008)(76116006)(316002)(64756008)(478600001)(7696005)(66556008)(9686003)(66476007)(71200400001)(6506007)(44832011)(8676002)(26005)(86362001)(55016002)(8936002)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: u47TGSW8UY1vbT6c4CLgOLrvopsZk1HfRgEAh+Xcqok8wHmn0VKqrKE/1UUj+hNol8zItLSIj/Z/vmY0LT+EC4CTe8vMflUB/BixPgdePcBsW7y+prZNhXa26CI1nxJM6FhVQf0fFAP1Sc+VCAgXSgjl6yJtQPbZrUWSG8sHz9bbM57/wOXIuftD3npEJZQmo8MDbadQc4BHYezP4vA5n+R24WP9UelJ/+hsFFeTVLkFwbc31Tw0cvtr7adC7XTKuDgnz3+p9H5ACZHfuHrQJpQL27rfpX6gLx8iQrYDaZE+KBB+F/yPVg/k1WzhSQ6KCvK/Swte17n/nUrWWtajRl0UTAWeFYQtEQzGjxIXI5wHbo1+4pBkLLqKIXA/wc+pquloPIzrnuxSsT//xE0Vr5fwcIBhze5v6jjdzJs0EY0Dlq5/5uH2Gacu3s6bZ+WpbhqkqtpsUeHNXfuk1e0I+GnfikB1fPHvJXc7x8LJf6A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c46a81-ffd5-419e-1b0c-08d7f9718c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 08:17:17.0778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Mh1f9Zu46shyqcrnS0lt3egqu6mStuUPAFdd/dtg5dGENOyvwsM5SIkyVA/3RYg1olO6VkcuLkq75goOoDHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6253
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pali,

Thanks for this notice. We will try to push the new firmware and also, fix =
the naming problem.

Regards,
Ganapathi
