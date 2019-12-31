Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E912D6B7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 07:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfLaGuh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 01:50:37 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:55507
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfLaGuh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 01:50:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0zPRFSD9WowFakzJ8Nw4IExrb3cX2FVqirpvYRgWaBOdD9kHuhKAsaUxPPyXo5tEAQr63RGSD9PbRIZoCjNDub7c5XB8DymC+Dcf9LFUYTlDh36XYyCSlHjtP/Lo5m70MQT53o92NY5VY8+ohFHm+D8urKrOFcgttJDV8r2ThkdPEA9l5NDRM7B9iPd/v87d+6+JfZrD3LpamJpYp0+p/2u+KF0kIV/13ykspizwjv3cfzPfuDreeQKtTevJWNjnFpsgiGd5bgYTwzbl5ezpeBQPbw4aPBEaatYgV4t00Cd0O3zoVrjFuA08EMTQXBwuf1K1E6q72BgTNYnRjgYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsblNSgR1iOUuZCUaj8n0UTeZ6z54pliUMfBas0Z8SY=;
 b=YsZ3yG4LZs7aztGjBrKPVZNHJ3bbdf+fkPC2Dx6Jm4ChPln7Oxwy5+l2cSTknbAyqKinJZhkZ6XrfYAVXq2y/TfRhmlCcnvLi2kyTSaIguhVDaFIi38FnxycAUQrIVjKOH/13DjscJP+9cvZX5Ypf3kzsivLm8udEbGKl+EU2LaDDZPT+kDC1tqN2NOhszuN/LB7NhlXiKDjip2nmngLnCEkILUPBDWqu64gR7TTu+glrmDHZaXuRLhvzHa6kzwzeMxe1QygCnoTyRBMErBUnwkCx92/ZuGi+K5gQt8vpEMsIW+JBuf4cIuYzwgcNHIHG/fWumAoNiXr2uznPgTIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsblNSgR1iOUuZCUaj8n0UTeZ6z54pliUMfBas0Z8SY=;
 b=mVZNbTqZcun64Q1zXyWyQbFvbuTG3e9HtLRpHdVvlmlnoUHA5rZLmzQi6t/DDW9Xlu42uRon1ZzrFun0k2P5F0MYe6rIwC9gE7OxDuHkAKGdtkYg6LGLFDqsbc+S7w7lLtvOQ930Qc7Es+kFX3/cc79y75bcdgJL1Nu2I8BQDME=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB3977.eurprd04.prod.outlook.com (52.135.129.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Tue, 31 Dec 2019 06:50:34 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff%7]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 06:50:34 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        James Cao <james.cao@nxp.com>, Josh Boyer <jwboyer@kernel.org>
Subject: pull-request mwifiex-firmware 2019-12-31
Thread-Topic: pull-request mwifiex-firmware 2019-12-31
Thread-Index: AQHVv6Zqpauc//SeX0WUrgYJIsJ97g==
Date:   Tue, 31 Dec 2019 06:50:33 +0000
Message-ID: <DB7PR04MB5242F3AB5904D80328C2E70E8F260@DB7PR04MB5242.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [92.121.64.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0e7cc9a-5a25-4ae6-5454-08d78dbdbc30
x-ms-traffictypediagnostic: DB7PR04MB3977:|DB7PR04MB3977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB3977F2F79003656610771E308F260@DB7PR04MB3977.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(8936002)(2906002)(478600001)(966005)(4001150100001)(9686003)(81156014)(81166006)(8676002)(44832011)(55016002)(71200400001)(52536014)(26005)(66446008)(6506007)(316002)(66476007)(186003)(66556008)(6916009)(86362001)(5660300002)(4744005)(76116006)(66946007)(64756008)(4326008)(54906003)(7696005)(91956017)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3977;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ONNNO+UfzYiJycyHye5k7qnS06VJMY7SVP7fs4dwK9j/sBqTducrw+wfdDtTBHpyBGcIGECs3YPAZaadlnh7UJELeagsjrq71oTe9iGWff8Gt8J6g+kr4nYkNImBGf3vOKvcFEy7ohrhjTEXsqHEByeZrRRYiUcchvEpp/ym1wNBYaMabS6m/MYWwT47D5BpzJ0wTM/lQ1FbP9oKLO2WYp0k8UR79heoqWiUeIe9DNTySyAas9ZkkpcTtx1gszRd97mVMnSDeTrBMhlhpDg2Y10Ika15rbxbb37jgvvkvZmiAzSZxNPk5tPcbHt8fTO3QlSLd8JwsA2J7DfZXMuIop1VG+nxPSFDumAzj7GHMsif7YvRqCYJCGsYfDx6vj0Mq/kJDjLlmP7vBpI2OqMNsV8eZdVxMblPrIOklZ9kQe4WMWWrC+2WBJmu0TTzWxwqOG5DmtiH2NUOisxDlYYAqFTMmprEPUNdOCjbFYac40=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e7cc9a-5a25-4ae6-5454-08d78dbdbc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 06:50:34.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bo8gn4EfT0npzmraCfhW0oxh0S9DuQZHnVC510zhOzmcXdIWkc9phrDLAPG/v3NkqXgsx6Hsmz6slrpS8FFs/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3977
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following changes since commit 6ae3652bbf4cc025afec3e15fc4bebc6fd29ee2b=
:=0A=
=0A=
  linux-firmware: update licence text for Marvell firmware (2019-06-08 12:1=
3:25 +0530)=0A=
=0A=
are available in the git repository at:=0A=
=0A=
  https://github.com/NXP/mwifiex-firmware.git master=0A=
=0A=
for you to fetch changes up to e65245cc861d0ed57eaf79519af440d1e66b75d6:=0A=
=0A=
  linux-firmware: add NXP firmware licence file (2019-12-31 12:14:50 +0530)=
=0A=
=0A=
----------------------------------------------------------------=0A=
Ganapathi Bhat (1):=0A=
      linux-firmware: add NXP firmware licence file=0A=
=0A=
 LICENCE.NXP | 22 ++++++++++++++++++++++=0A=
 WHENCE      |  4 ++--=0A=
 2 files changed, 24 insertions(+), 2 deletions(-)=0A=
 create mode 100644 LICENCE.NXP=
