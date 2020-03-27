Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D8195120
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgC0GdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:13 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:59006 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgC0GdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:13 -0400
IronPort-SDR: YCnzREF+W4YEhT28cTn48xLs36W5F521o/AFxr9zz89U+ecKFqOsxkSv7S6+ezq6MD24IqyE2N
 cW02uSt6OzsMQwC+CQHneAaI54xO2QbA1FC2CAX4DBamI0vLnU09Tf5dkhgbby7MvjdGrQcCI7
 7VctFhwvYkiMH6ERkcq3PK+aZkxttTKyHf47U3MUYosrk5/1m3Go6CjcFfr7ppUbOikeNbMw7b
 B7zw0lcB1swnCTOsXliO0dRwTzC1XT1gESWnTMBff2xxDRmsLHCsuxwxEtC5pGKF7WRyCSvI3D
 nJY=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="68584130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 26 Mar 2020 23:33:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqa129X0/fTrh6aeB+m/2lamMzkpbjfPAS6aVOGVnRkKOqg6j3y39wMBFeJakk1JfuteeXHVKnbAmTuoMorzv8Ek12s9TJ7a6nKZ3BC+oj0TYSAzD2igXYOnw2smVk2U5fte4ZboWFR3j4ijUKTcwTaBmskyKGo9RI1St/+s81Is3nwVEBtYktiR50zTZU7DfD/tIZeE2BgBE+OkICiR98b5aDjg9ol3MzXLBDRzFfdSL7YPfTWWLiM+SJH2iw73WPxlPNntjmu+VXj7JC5WcIjR3KTLacWSui9ssTwGVJUac/hPk+TAvkka5gAAphMi/XITIOWX29qN6J3R0joOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uErN5nSFNsutrV0xpQ5x7+Lam5iJg/+VFpnX+lP4/Fo=;
 b=UHKZdKJWTqIrHoB/MXixSfTFk0w3zz94prHgPR7cNoB6A++hYoa+LB31yIZUrehME6o2zcReFyg0Tr90lO46sHhcZPZATpHdwS5he5H4cKZWl9MNyPhdtetOkr0DUuNHC7EynEgj8jOwtqjFwPQzAr3jvpCGjaG7qij+E1sIgOt2Mhb2PI740aEZyS3NtlYD7TvtsEtdMPuL3CfGTjQiuRlKeMHSQUscJak+SFQuacSry0cJC/dmfyeDaFOvwxv4pIFClTC21/5UuIDDmSK0Go7FLKe+ExbAxZl6ZRby6W3bD+n68o8JDY6BfkdL1hq0d9EpaQh+fAiWOZU0jPwfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uErN5nSFNsutrV0xpQ5x7+Lam5iJg/+VFpnX+lP4/Fo=;
 b=MI4KxTz9OOis/qStzsOp6UGwFRy2cs2UE1Va4inmF7wPLm/DQQojy++FLVrr+tOYkS6qMSwjeXwoDlM9YOT6RfDWAdBRrAk94m+go9u85lEoNIdhfTNkdRpc/qrOPqK0IiSg1/EYKJZqmemUzKI8E9/tnXt2TrIkEUy5Hg2qtJE=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:07 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 00/17] wilc1000: move out of staging
Thread-Topic: [PATCH v6 00/17] wilc1000: move out of staging
Thread-Index: AQHWBAGTqEr82liQgUqCj/rX8Gwo4A==
Date:   Fri, 27 Mar 2020 06:33:07 +0000
Message-ID: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c0f902e-0a81-4c07-cf64-08d7d218b624
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33976F824947A620BBA13482E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(966005)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAeMv++Ds1CLwEmKyGy8s3NNjD+/eaMbKAyMvC7BznhHHstUVKTfi0xw/wEhu1XvFVyTgzGsEK4QnJX6AfWoGFz0GJxcTROaljtKnHik9BsWODC2LrDize1p+BWbcfM5xJg0a9WrI6e/bvwA/GIlbZjwQoIktNWfvV+RBoHVcldMxuq+vmfJKQvShxS/MMBJJ5yMrPf+EiLFEdpPZeKIVuvL3B98CipLs0Fu/984Bqc9fZhBu2Fa+n5p0zeKR+iORHG9zJwAKe/3hG3oVQ8XKyULo1uXJ3F3bRRB6mKXtI9QvjKL17OeLiewnEQOG1DWxNoKNZ0S1+HbqTRvOys4tpRDeWZAc3bzCNUScXRGyCyHyh8ZLcMFyXbB2LBSYqQA7tFbOP+r4eWOgAv2FK88pUJWe8BbgoLSbvaU+Gk1lVGFN6eyTxB339VqiddK0/ZqTC6HBMI8dJaZ+HzLDD75cCKTPcL4gsK0Otfw47ehOTbhL0r5h0c+haZeNSvWeeVpqXg8oOGIqPEtfjkT9WU2IQ==
x-ms-exchange-antispam-messagedata: 7E0gboTlYE6ZrWXL0sjLMQjXUChkjQ9zHGalWwSGKKVKDPoAAkwSEBjv2c14jbSdiCx6dvFVQ8gnOGcWAezl6jYs9fBsB/bB66wapsq79uOJ07zgx28z4b3mkELm862vcxD+A9RIBhhHR8LBScdzGQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0f902e-0a81-4c07-cf64-08d7d218b624
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:07.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feCYb+y2s8JxuHmjq/i9PaiZHFjt87duvrRZ+i8PdsLpilSKkhTsF5Phzdehoy1Z8QabKvIOKvhO9UcNmYTrtF2s1mxIkDKDn9tY7CZBH5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
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
 .../wireless/microchip/wilc1000/cfg80211.c    | 1849 ++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.h    |   29 +
 drivers/net/wireless/microchip/wilc1000/fw.h  |  119 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 1959 +++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  214 ++
 drivers/net/wireless/microchip/wilc1000/mon.c |  260 +++
 .../net/wireless/microchip/wilc1000/netdev.c  |  934 ++++++++
 .../net/wireless/microchip/wilc1000/netdev.h  |  294 +++
 .../net/wireless/microchip/wilc1000/sdio.c    | 1023 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c |  945 ++++++++
 .../net/wireless/microchip/wilc1000/wlan.c    | 1238 +++++++++++
 .../net/wireless/microchip/wilc1000/wlan.h    |  397 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  413 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.h    |   54 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  803 +++++++
 drivers/staging/Kconfig                       |    2 -
 drivers/staging/Makefile                      |    1 -
 24 files changed, 10682 insertions(+), 3 deletions(-)
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

--=20
2.24.0=
