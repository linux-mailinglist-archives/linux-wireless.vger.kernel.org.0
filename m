Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14296204FC7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgFWLAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:19 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41143 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732225AbgFWLAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910010; x=1624446010;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=C6ya2PMiTtO56OFsKp49/joV4heCTQP46Xl7P+/G8X8=;
  b=Wu648Fecwu4qkwsZvqvdCLaSfbTy8WMnwWmW53qbV4gbbtmmOm7YWC+7
   04HTAnyZQX9VnNJ0lPzIpOtjMv0Lq+07nEw8zOvtAy3tLb+I1si9XK7BX
   9/R8qFajz8JaYlpt8B2yOvcCAaelMMytXW0ToZ37XIGefOPTWvcCTOQoL
   IfzEwYJ7FRJVGcBW/nfXHEGbudKrCifCyS/3ZAtoHr3IbKZtYdkNsELG6
   hfBrCHxpS4ws3loplTV1LZH9Tys2QtMTkjOx5rU6la7B+F/J1U7eoaz8I
   yYs6icisuvxOljOrJIbfeUgltohWw4A6+hvpD2wSLyj6CzMlitSMiUSG+
   g==;
IronPort-SDR: o3gbW2DgdreRE47VMkwwa7+2O0+2MEQtXn3awlJFcDRO4Z3tSLtixUzQ7ei48SJWw3svtlo45l
 msGn373WAtAiFx2Cw0IO+Yh7Wm53/Sx3th1VCoGWNu60s/6xXltYH8k8ieqJv9RyI3OyBr6180
 xQH4k0to4f09HnFOXa7Tl1beQVdYbRJ6ReJE839gYlnJKU3qpNJGJKmqZdZByvQW6Y5D/YX9ic
 vGoYFcQZ8lodaCN1K/Sn0KsiBjQlCCW3FI3CW/yBE9HirHwDaf6PZBL4+lY+0XpuqafpaPgJDy
 Hek=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="80543428"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 03:59:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 23 Jun 2020 04:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQkxda1Ezo1L0MfKXqM0qCIedsJLUo4nDxlEG9qaIatjsplsz+ugsN83XJeVq162b+FvN4j3W+Ui6XV5e46jpbGyrql0GvMnaqooebJMjdcNO9Fq0/YhSzVVMdTAwe3LKwXXj8kyvJlVPeFsw9jVvTupFB8sOOfrCSWwG8ndjeFjjWyajhbY4u91gQjEz/LNhg5zF3errl88gVYuAhA0fhamt228TywMIHxbAHGVH+POPz2pwmrUmkV3uxjPhBZN8IzIJOBQ1+HKQApHzFqGh7cwLiO4G87dLQi1KKVdcqU1JSsRwd5EKeSmXTsJkMqT9Az05ky1ma9Da6NwKFGoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSI1Bl5yWwhGrY3eTO1MqGoPS4RxwkZb4xhzwpzD19Q=;
 b=VDtnOUzc/EfXJda9e3vTb6gSoX0LhyBSkaTu3DZzeEXhQ+tX76fzcfC4cVmOb+pIDfCJPrYum+RTdaGsvdhLY4o9DeiF37UhUCZnU1eqyqa+FKZdef5Fq2bE/tvpw5MOfFZ8yl/5dwkilWBtpUipQpb72LVKn3nuq7qUrVwWNzMHWSI8OMYUnrh9vbjOirLU9/949W8patoJDZuzz+kRWwgeT8z4YYRO4swVDuszhqfo1dVcZbMrSQNu/7F8Jhnsdt5jLF/SsEy1/UMVu1k8dLmWS2FxQvJE9iZcF+i7P+Ul2q4v/LScT1Q38BCmpSg61weMmN0Nea4Uph7EoL4gcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSI1Bl5yWwhGrY3eTO1MqGoPS4RxwkZb4xhzwpzD19Q=;
 b=EYRryd9WM3booXCsiKAvnXczGwFDb4BM1AQ2tOW8Nak4CkPNcviw3kCwvyEDHTXusyzRB0DWK1d02d1uvbLXvhdjsspMpPXo9/4TLLitRv+OMO4ikTSm6WmwWddUUlFD8qeXSJlD0P4G6r/5TJKiDihTM25Pl7JkWvu+m1hxWuA=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:04 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:04 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 00/17] wilc1000: move out of staging
Thread-Topic: [PATCH v7 00/17] wilc1000: move out of staging
Thread-Index: AQHWSU1z8nHvJKTVrkqyNvSWLHZdHw==
Date:   Tue, 23 Jun 2020 11:00:04 +0000
Message-ID: <20200623110000.31559-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.200.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c510a70-65ff-434e-33d5-08d81764959f
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3551109AC849C74507A43CB4E3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80AkjuHH447HUShH+Iyi62XPDSQe6T2bB398AcbG3lO4ZeA4VaWEnuWvDo6bAzkK5qc4S990WeFqhYciy5epQRLeJ6QWDluBrl1POxHqxVdcUpXJNOvDQWlaEUkTXV3z2+KmhfkSMx8neq/hMIPT4AkBW+o0XyelpiJxjxAKUXXnK/cNiFzXp3lm4Gftm6CwX1WdPUvDMMHF5nqSuDnSimIxw6AdXacumN/P4ry5Poe6zusQ4hKO6kK9EWnU7OxRDpg0PaHnkhU9g+9WfwIB8CsjWNv1MzAR9jljFctmnIJ/d6W+a6uELCDb/fN+dtmEGcDcZZt53Q6cLrsaG0HquU5i80oLHOhoqu9jEQw9vBSpxZQTBzdp6gp8L8dvUk6vjpt3T58uHGh18sXyqkT0rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(966005)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4IHqfBZrkYoaFxAgxakLjmqhcVuAqqzoGeVY4rkTc387wy3ZdVOcLbc2qh2f8yyf6A0ZiIK9/H+iIPfAz+ESY1z7dpfAljrUAeydd6EPlCS3wEBK5z6ox6EpuuhTBauCV1PQpGSx50pZGQP2YLMc4dv8EOiNiTYobQCeFpK4Oo32VEUqb0rh0zgnB4RB/F5pw/wfByD1YgSlHuUUPgT6oymGgZwywZ0vGZyTCb0fPIAdDcI0bCbJQGPZ4lhuFsqb7/YXpffFuDi8Q9LEApnbpfgmW2D59q5iegmbbfSQwgQkD4IajxBcSRJNt0so+RMBq5dn1W3DwqtTuK0W8ssNscujtKbVDMtZIYcv/DNSkmFdECRT8ll9qStAkG44IEvPz1didsDNrlY/JJ8tqsTkLUa2IxhHE2pi/fyKvPoVNsdYQMuEBzvdxImH4350bIz0pOxMc0SOgJb3DHKtqIYx5k2Pw1uP/iJwTP18p2yjaTRSEjBDBu560Qp1eBDFyUYO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c510a70-65ff-434e-33d5-08d81764959f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:04.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPZXuWBQFnAlndQupk/0+sduPZbyii7dySFu3e8dmnqUc+anelwKoMDWokxhKa5tPc+00PLkJTxIYVLz/VJ1JDf9xg6HZm74xcDko6U5rtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This patch series is to review and move wilc1000 driver out of staging.
Most of the review comments received in [1] & [2] are addressed in the
latest code.
Please review and provide your inputs.

[1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-ema=
il-ajay.kathat@microchip.com/
[2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-emai=
l-ajay.kathat@microchip.com/

Changes since v6:
 - added Reviewed-by tag received for DT binding document patch earlier.
   * https://lore.kernel.org/linux-wireless/20200405013235.GA24105@bogus
 - merged latest driver and included --base commit as suggested.

Changes since v5:
 - handle DT binding review comments suggested in below link:
  * https://lore.kernel.org/driverdev-devel/20200320175920.GA31641@bogus
 - merged latest driver from staging which contains few cleanup patches
   and changes to use crc7 from existing library instead of having
   private implementation.

Changes since v4:
  - merged wilc1000 SDIO and SPI DT binding into a single file.
  - handle DT binding review comments suggested in below links:
    * https://lore.kernel.org/linux-wireless/20200303015558.GA6876@bogus
    * https://lore.kernel.org/linux-wireless/20200306144400.4269-2-ajay.kat=
hat@microchip.com

Changes since v3:
  - handle few Smatch static checker reported issues.
  - use flexible-array member instead of zero-length array.

Changes since v2:
  - use 'struct' to extract FW info from received commands.
  - make use of C style comments instead of C++.
  - remove use of bool type for firmware struct.
  - deleted unused code related to interrupt handling.
  - make use of RCU list to maintain interfaces list.
  - remove 'wilc_' prefix from file name.
  - added 'WILC_' prefix for header guard macro.
  - remove use of infinite loops(i.e. while(1)).
  - move firmware related struct to a separate file.
  - refactor SPI command handling by using 'struct'.
  - use different functions to handle different SPI commands.
  - cleanup spi.c and sdio.c by removing unused code.
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

Ajay Singh (17):
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
  dt: bindings: net: add microchip,wilc1000.yaml
  wilc1000: add Makefile and Kconfig files for wilc1000 compilation

 .../net/wireless/microchip,wilc1000.yaml      |   71 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/microchip/Kconfig        |   15 +
 drivers/net/wireless/microchip/Makefile       |    2 +
 .../net/wireless/microchip/wilc1000/Kconfig   |   47 +
 .../net/wireless/microchip/wilc1000/Makefile  |   14 +
 .../wireless/microchip/wilc1000/cfg80211.c    | 1846 ++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.h    |   30 +
 drivers/net/wireless/microchip/wilc1000/fw.h  |  119 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 1961 +++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  214 ++
 drivers/net/wireless/microchip/wilc1000/mon.c |  260 +++
 .../net/wireless/microchip/wilc1000/netdev.c  |  931 ++++++++
 .../net/wireless/microchip/wilc1000/netdev.h  |  287 +++
 .../net/wireless/microchip/wilc1000/sdio.c    | 1023 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c |  945 ++++++++
 .../net/wireless/microchip/wilc1000/wlan.c    | 1238 +++++++++++
 .../net/wireless/microchip/wilc1000/wlan.h    |  397 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  413 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.h    |   54 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  803 +++++++
 drivers/staging/Kconfig                       |    2 -
 drivers/staging/Makefile                      |    1 -
 24 files changed, 10672 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000.yaml
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


base-commit: a15a20acc980342c97d804c5fae1cfc0cd7712a9
--=20
2.24.0
