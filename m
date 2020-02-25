Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD716BAE5
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgBYHlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:14 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:25139 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBYHlO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:14 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 5vdzYTiZdvadguZM5fMv1rFNMXmjPJVEs+4NBq696q2yQRuYb0sky8tFygi6UUjaIFWOH4/Gr5
 csMA/+4EsAD8Sto+wpXTOEYUC+8H/XbmXdlhajwNkp2Qb4ugXLbEXjPmdmfrYXcoAvNihZZ+rB
 KET6hvkHNT0C4+ZELdREh7zsY9MV5q3oUk6W65u8TLJL5i8UtUmH3jtznyXuhfdJeJRbuX48KB
 +ie3ypP8Af65vNP7yRbpz85/c3Qi3ad0i4t95rDv3yJYMeym3aLrPFPiAi1wp+AO3nCmx85R1/
 9KA=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="69675522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 00:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq1d3qHTc8FXmqm+qugXxgzbAVafRAib8WWxhDuWmnPUHod+xm9KjH2jy4fNSM4Mirgx5ioD6Hyqj2lliVJG4OrmFTg1ZoMRk8IFzDuRnOSkXZjXwmwJzBtNqWDAPp7or9S6Z1hzEgvGrUlFPRm5dAq6iNu1iXe+DmJzvOcFYAPdtGAOXrD/Yu0f4MmoaVFqrN9zDSJJORXwEsfCRUbC/xTAVh+kp81tkZXDepfsAXqm2J4AIxGFcZX55ryPgkK/EMu9vlfQOlvo1xYis45me4IOBNcqz3Eak8UvOgl0G1J7dtfRm0E9GoQgJuRCq1nHYtlXSB4nnjzpybDkTeIFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHzjluq+PV6amSEpl1qidttfwt/MwLbLId6ixyNdvsk=;
 b=Bn7C2bejT9BZuunZ/WtKusLKm74eFQ7qYKwq2AzDdQaWJc5Oa026osnTx6VykSXTzkZZDOA2iR3/XHEQcUxCFgdTXK0T6aUbzM9S0mgqMufZzBodxZaFlGcca03YD97hdb5Fj8mDq1sNbEEKdjJE/5rKCVEdflJ1WNAMtVmHXnvRH3Snxg+ojVJcSKtlUDUTRMSK0SbFAuDkbJV+FKCcRvOEKl+U3I7RWLfAYCGYo/4FAceZCdi0GD/tbkvJgeJb+kw3FSllbY62oMPQjStyjIed0Ez9ar8o+dC3AVhcsVeN1XRoKnEUJhqnrgTHzb0N4pj2qq35H/RpSrvaPZFd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHzjluq+PV6amSEpl1qidttfwt/MwLbLId6ixyNdvsk=;
 b=Y9HgTT2lstTeUChPO23256NaHjm6aAyGNE0Kheo0jYyZS1vNzhpg/cIC07wrKEG9tkXT/vRbbyrjtiZW4zQdzy7rv2Plw45Htpw073MR1h/eRGhRirWNYxkglRfiaRI6NRObKTSuuaDrPfc1lnTuKdiG0Hgd7j0Hu7w8Sqaz39E=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 07:41:10 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:10 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 00/18] wilc1000: move out of staging
Thread-Topic: [PATCH v3 00/18] wilc1000: move out of staging
Thread-Index: AQHV667y+zVJzO3Rq0qfZ397NNWe/Q==
Date:   Tue, 25 Feb 2020 07:41:09 +0000
Message-ID: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d53694b-17b6-4ed9-3647-08d7b9c614d2
x-ms-traffictypediagnostic: BN6PR11MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB18757E49FDCE4E2F205146F9E3ED0@BN6PR11MB1875.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(2906002)(2616005)(54906003)(86362001)(1076003)(966005)(66556008)(76116006)(66476007)(66946007)(91956017)(64756008)(36756003)(66446008)(186003)(8936002)(26005)(498600001)(81156014)(6512007)(5660300002)(71200400001)(4326008)(81166006)(107886003)(6916009)(8676002)(6506007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1875;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrN4Z3qOmVJh5agJ1Nf/ROx8Qjh3wb1eo+QVEGQRST/JXLU0doTW5gFowWTlWhUNaWdX020+pP1EOjbJGOEEqMM/yY/QjYxbO0mIBywCu+KYAb6B8XABKQU7dVvSbZKU4wcWJV3SESlO0hCFkFXCJiU4TMd/ObtTzLV4mNP8h5SzD5df4WZMG979pjEMW3p9FFzuNFWRUBzfuX93JXsukU917TfsvwIS/nR8o4tG2JsLJsGmkqhOmcv4S7bgTs4Ktq8KI3xu1RegYtdgugmhmEdb6FD8qTgFoPGbI1HPz2XyJklrnQ8ERzri73U64Oe3LNUcRpDvX1FzvAm7GxXhRX2YLopxjhbCRebUSw1n8q9qaEQAUGwVEYeaQNKIWJfWJ9JRxvKkJofcjwtfTcxRn1V5kC8meabe2QcbwT7fCbT6a2thwui+20UmpZRRX4GNvZbf8WjXhnF+6Earfsa+gDQy9cfgR2zHrZ/gqRvncCnvVayE8wUzcd/AoCEc9ZloVeH55v3LG7hEUvAqQ0kgLg==
x-ms-exchange-antispam-messagedata: d1uwdqBhY8B9sbrNpb5vASQWQGjoA2tcBTfHzxC3F2pJhXv9Go6Se4H8zYDq0ucaTlekmNB1WNM4poNjCE0yDqZzNY2zKsPB2GtVFm4aO9PFwg4LMGUrouevksm5s5t+4QXL8yA3lA4Z2nX4M9Xcxg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d53694b-17b6-4ed9-3647-08d7b9c614d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:09.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD4zpi/JApw3kw82MT+A/jpubr/O+gO96IWQBR6VhFDNAMSWjLtm+nd1DzRAafOPTTBcKwnQ1Q5LTBaIToWX03Tr+Tod/BQLGFjxb32IBeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1875
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This patch series is to review and move wilc1000 driver out of staging.
Most of the review comments received in [1] & [2] are addressed in the
latest code. Please review and provide your inputs.

[1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-ema=
il-ajay.kathat@microchip.com/
[2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-emai=
l-ajay.kathat@microchip.com/

Changes since v2:
  - use 'struct' to extract FW info from received commands.
  - make use of C style comments instead of C++.
  - remove use of bool type for firmware struct.
  - deleted unused code related to interrupt handling.
  - make use of RCU list to maintain interfaces list.
  - remove 'wilc_' prefix from file name.
  - added 'WILC_' prefix for header guard macro.
  - remove use of infinite loops(i.e. while(1)).
  - move firmware realted struct to a separate file.
  - refactor SPI command handling by using 'struct'.
  - use different functions to handle different SPI commands.
  - remove use of vendor specific IE for p2p handling.
  - refactor p2p related code to avoid use of buf pointer operation.
  - make use of FIELD_GET/PREP macro.
  - use #define instead of magic values.
  - use YAML schemes for DT binding documentation.
  - deleted unused code from spi.c and sdio.c.
  - added changes for few issues reported by smatch static code analyzer.

Changes since v1:
  - remove use of shadow buffer to keep scan result.
  - remove internal messaging flow to handle cfg80211_ops.
  - make use of cfg80211 provide API.
  - use 'struct' for packing firmware commands.
  - make use of kernel API's and Macro.
  - remove unnecessary log messages
  - supported dynamically add/remove interfaces.
  - cleanup and deleted around 3.3k lines of code.


Ajay Singh (18):
  wilc1000: add hif.h
  wilc1000: add hif.c
  wilc1000: add wlan_if.h
  wilc1000: add wlan_cfg.h
  wilc1000: add wlan_cfg.c
  wilc1000: add cfg80211.c
  wilc1000: add cfg80211.h
  wilc1000: add netdev.h
  wilc1000: add netdev.c
  wilc1000: add mon.c
  wilc1000: add spi.c
  wilc1000: add wlan.h
  wilc1000: add wlan.c
  wilc1000: add sdio.c
  wilc1000: add fw.h
  dt: bindings: net: add microchip,wilc1000,sdio.yaml
  dt: bindings: net: add microchip,wilc1000,spi.yaml
  wilc1000: add Makefile and Kconfig files for wilc1000 compilation

 .../net/wireless/microchip,wilc1000,sdio.yaml |   68 +
 .../net/wireless/microchip,wilc1000,spi.yaml  |   61 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/microchip/Kconfig        |   15 +
 drivers/net/wireless/microchip/Makefile       |    2 +
 .../net/wireless/microchip/wilc1000/Kconfig   |   42 +
 .../net/wireless/microchip/wilc1000/Makefile  |   14 +
 .../wireless/microchip/wilc1000/cfg80211.c    | 1852 ++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.h    |   29 +
 drivers/net/wireless/microchip/wilc1000/fw.h  |  119 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 1959 +++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  214 ++
 drivers/net/wireless/microchip/wilc1000/mon.c |  260 +++
 .../net/wireless/microchip/wilc1000/netdev.c  |  940 ++++++++
 .../net/wireless/microchip/wilc1000/netdev.h  |  295 +++
 .../net/wireless/microchip/wilc1000/sdio.c    | 1030 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c | 1001 +++++++++
 .../net/wireless/microchip/wilc1000/wlan.c    | 1240 +++++++++++
 .../net/wireless/microchip/wilc1000/wlan.h    |  398 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  413 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.h    |   54 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  803 +++++++
 drivers/staging/Kconfig                       |    2 -
 drivers/staging/Makefile                      |    1 -
 25 files changed, 10811 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000,sdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000,spi.yaml
 create mode 100644 drivers/net/wireless/microchip/Kconfig
 create mode 100644 drivers/net/wireless/microchip/Makefile
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Kconfig
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Makefile
 create mode 100644 drivers/net/wireless/microchip/wilc1000/cfg80211.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/cfg80211.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/fw.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/hif.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/hif.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/mon.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/netdev.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/netdev.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/sdio.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/spi.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan_if.h

--=20
2.24.0
