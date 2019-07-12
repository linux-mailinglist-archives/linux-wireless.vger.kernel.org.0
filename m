Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6085F66389
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfGLB6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:58:41 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:54865 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfGLB6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:58:41 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: xjQ84B7uhj8VLp4IFKlINZ4hHhGmFmlETwi5mqYrmA5gU3nO0K6oYRuigObZNao/N45iurCl0L
 tdjuJdktDWn0DVk48/mYtTR52QOtmcP9r7V+BYH8J8MlSEF0F6d54QCkEAFaR2Dc3OFeMe8Lpq
 108sFSrmx8pkFdPrav7cVQyGYEh8ivOzPkaKfs/L2jUEZOiqlq2TkFY6R1n7bB4SNlfgXLejo6
 Af2JisxYdZA1iVXd2vCwRDx8yGP4K9fRSr80jJ2sJ96/l0A1WdqZL96agiHSNsBNAvOfIxNLy+
 nKM=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="42430091"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:58:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:58:38 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jul 2019 18:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiQqk5e+jM4p7eMdELGfOuDmeUkWkxh4UKqImgVZEIxcu7pY1LRdLoPb8dBaXuuGScp6/vSHjF6aQU8b36CX6nRjHmoMEz6AXykyO7ss3SzK4zPMiI3f0WnF+a9nPePCmQtL6ujUOFZAnIaR+905bRIxvjbfHfWi77ZHad8l4Cf5Lj+M9hNgX/HRs3Ku46EXMPRBX8DYmGTYqwhRezrWz2+ulsn0HF4EaO7fqbHR7epDkJ8QYJ+8rwE7Hw2Yd2oIVxvNCxZREFMJX3xArrEZ5shMWwx8g/B48wiQV6vTUUMKGUbU+6bFIwr297HQyqq4jAitHuG+OygpJvvAtH2yvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvhMVRVvfrjUfXV+2lrfHzJhvmxBrCWNf7+7BED0qL0=;
 b=RJOIY5vbYU1SxpmKSHowErznp/LhzfELGAWj5jYgXGi0Cge13BlejY0ka6RaIWTQCM3FjM3RqN+2mKC/nlnhi6dDY3LFIbqX0VSy+antdVXpgZl1vZs+R1/zBehgxxCYtBzFp6Aam9vJLbsz2vWOHdQMbc7c3HkOU2xMBhzQ9hlOWB8bSCjQr0xcxGWLVZ3plqcj+in6RCS7oJp3UeSmTtMMlkTfIBPUmI1xzenkFaaclG0K5PkuYTx7DChvMIYYkdGlYGRa42koheB0edqk0whjsFcm7tvDmaOjDnzHpmwvXsI3Pl+gEmq0P/4CifVTx8DOk3WV6md6TaCuEL1sBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvhMVRVvfrjUfXV+2lrfHzJhvmxBrCWNf7+7BED0qL0=;
 b=uEeuasKGQszL7Y/YNOH7sz6cxYf1AdMCCamvHC2UeM2f5POv2QKOoweT3Zs7xxp8wMcaBwGtv/ucv/vhQgYXMA2mLCJRbU2Mupd0YG9kBNsfN1aLfiOBeJo/I5wX/jPbgzR2SDj74WKzh6Q8XZnk/ZlJeU9NcoxMT2Ey4jDvgko=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB4179.namprd11.prod.outlook.com (10.255.128.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:58:35 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:58:35 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 00/16] wilc1000: move out of staging
Thread-Topic: [PATCH v2 00/16] wilc1000: move out of staging
Thread-Index: AQHVOFVQsHBlq34Ej06nLHumi3+5Vw==
Date:   Fri, 12 Jul 2019 01:58:35 +0000
Message-ID: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c1569a6-9233-4034-13fb-08d7066c72b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB4179;
x-ms-traffictypediagnostic: BN6PR11MB4179:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB4179DAF57FB2E8A55056084AE3F20@BN6PR11MB4179.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(486006)(71190400001)(71200400001)(54906003)(102836004)(86362001)(316002)(966005)(36756003)(305945005)(6506007)(6916009)(99286004)(2616005)(478600001)(2351001)(476003)(78486014)(7736002)(68736007)(386003)(3846002)(66446008)(66476007)(8676002)(52116002)(8936002)(4326008)(66556008)(26005)(5660300002)(2906002)(50226002)(14454004)(66946007)(6116002)(6486002)(6436002)(6306002)(81166006)(186003)(6512007)(81156014)(66066001)(53936002)(256004)(25786009)(14444005)(107886003)(5640700003)(2501003)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4179;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jzoL9Bcd6VXlbH+NSSYnn/zd5Scfa9jRB40ubcHZZdWGUcXqL+pGBI7zrWGOWRcRLy6sTZNCfjurfRK1WkHZdzjQgP4EUY03InbLf01UtTptmdMficSUnKXJmlpf/ZgSyt0ullsKJEO30pmiod0GN5AL15NFQy4KZaAVAep0slP03cFp4sI3zz0MEeVKxo9lLTMed6Mu+4aaH2JUzgcj56dZnKnQ+AEN6n4EopN8mRhx1mn5x4GWt6jnQw1PYELoGqMqEWMhmiuQVjOn4/wT7rFK7V8kz9cVf1dZFQClWhZElu5SGP43yo5YFlcorgAW4j4SBm6x0zcy/3yBts2k8Hk/IYiuAkbPN/MdEHxXEDWPXsKAK6VqzfvpXJWUDrIKh2JIoe/DYgd2pjbzs5bWCs012zZQDnnWE9vPUus+qHk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1569a6-9233-4034-13fb-08d7066c72b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:58:35.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4179
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This patch series is to review and move wilc1000 driver out of staging.
Implemented the initial received review comments[1] and submitting the
driver again. During this cleanup deleted around 3.3k lines of code.

Below are the major items fixed in recent cleanup:
 - remove use of shadow buffer to keep scan result.
 - remove internal messaging flow to handle cfg80211_ops.
 - make use of cfg80211 provided API.
 - use structure for packing firmware commands.
 - make use of kernel provided API and macros.
 - remove unnecessary logs messages.

Please review and provide your inputs on pending items to mainline
this driver.

[1]. https://www.spinics.net/lists/linux-wireless/msg177877.html

 Changes since v1:
  - supported dynamically add/remove interfaces.
  - included the latest code from staging.

Ajay Singh (16):
  wilc1000: add wilc_hif.h
  wilc1000: add wilc_hif.c
  wilc1000: add wilc_wlan_if.h
  wilc1000: add wilc_wlan_cfg.h
  wilc1000: add wilc_wlan_cfg.c
  wilc1000: add wilc_wfi_netdevice.h
  wilc1000: add wilc_wfi_cfgoperations.h
  wilc1000: add wilc_wfi_cfgoperations.c
  wilc1000: add wilc_netdev.c
  wilc1000: add wilc_mon.c
  wilc1000: add wilc_spi.c
  wilc1000: add wilc_wlan.c
  wilc1000: add wilc_wlan.h
  wilc1000: add wilc_sdio.c
  wilc1000: updated DT device binding for wilc1000 device
  wilc1000: add Makefile and Kconfig files for wilc1000 compilation

 .../net/wireless}/microchip,wilc1000,sdio.txt      |    0
 .../net/wireless}/microchip,wilc1000,spi.txt       |    0
 drivers/net/wireless/Kconfig                       |    1 +
 drivers/net/wireless/Makefile                      |    1 +
 drivers/net/wireless/microchip/Kconfig             |   15 +
 drivers/net/wireless/microchip/Makefile            |    2 +
 drivers/net/wireless/microchip/wilc1000/Kconfig    |   42 +
 drivers/net/wireless/microchip/wilc1000/Makefile   |   14 +
 drivers/net/wireless/microchip/wilc1000/wilc_hif.c | 2089 ++++++++++++++++=
++++
 drivers/net/wireless/microchip/wilc1000/wilc_hif.h |  235 +++
 drivers/net/wireless/microchip/wilc1000/wilc_mon.c |  261 +++
 .../net/wireless/microchip/wilc1000/wilc_netdev.c  |  997 ++++++++++
 .../net/wireless/microchip/wilc1000/wilc_sdio.c    | 1139 +++++++++++
 drivers/net/wireless/microchip/wilc1000/wilc_spi.c | 1134 +++++++++++
 .../microchip/wilc1000/wilc_wfi_cfgoperations.c    | 1980 ++++++++++++++++=
+++
 .../microchip/wilc1000/wilc_wfi_cfgoperations.h    |   27 +
 .../microchip/wilc1000/wilc_wfi_netdevice.h        |  294 +++
 .../net/wireless/microchip/wilc1000/wilc_wlan.c    | 1354 +++++++++++++
 .../net/wireless/microchip/wilc1000/wilc_wlan.h    |  313 +++
 .../wireless/microchip/wilc1000/wilc_wlan_cfg.c    |  495 +++++
 .../wireless/microchip/wilc1000/wilc_wlan_cfg.h    |   54 +
 .../net/wireless/microchip/wilc1000/wilc_wlan_if.h |  803 ++++++++
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 24 files changed, 11250 insertions(+), 3 deletions(-)
 rename {drivers/staging/wilc1000 =3D> Documentation/devicetree/bindings/ne=
t/wireless}/microchip,wilc1000,sdio.txt (100%)
 rename {drivers/staging/wilc1000 =3D> Documentation/devicetree/bindings/ne=
t/wireless}/microchip,wilc1000,spi.txt (100%)
 create mode 100644 drivers/net/wireless/microchip/Kconfig
 create mode 100644 drivers/net/wireless/microchip/Makefile
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Kconfig
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Makefile
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_hif.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_hif.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_mon.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_netdev.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_sdio.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_spi.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgope=
rations.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgope=
rations.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wfi_netdev=
ice.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan_if.h

--=20
2.7.4

