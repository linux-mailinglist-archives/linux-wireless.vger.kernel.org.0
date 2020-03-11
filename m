Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8818179D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 13:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgCKMSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 08:18:46 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26273 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgCKMSp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 08:18:45 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rZCZpCZXBetH4feJSv6WkXSENj6HsSCal8z31pTALSxpa5N1Ws616sVPOdQrM0UQe+E0mrIKGP
 6wz64bPl/ALPXmVMTa5WKbPCKg1gLVwKYGBlzL3ipD3iTjvU6fGr7JFFOIoRZqlfiZkMORVJjj
 quhQ3AeksmAiMz8rUwUPt4jYt5iyi35Bx3Jx2BBclZwZRANEGzaT/rs689EoTiuD91J9RZxaGQ
 pUU9mZF2P2A/369LjJRy3ozFQtET0wNRrzy+hIVeN7dEdQ80UBbFFaLPKdLCRmMOTYWwI8Pzxj
 4Zs=
X-IronPort-AV: E=Sophos;i="5.70,540,1574146800"; 
   d="scan'208";a="5254831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2020 05:18:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Mar 2020 05:18:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Mar 2020 05:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHw7cW03pINQXBptjFXBY/JkVTCC5NgU/WJrZf1qizBpSMAqu467eY420Xk1nb1qL5kg6UHRkX7VJuTO3l74rPyVTuNpSeIrMxVq1D0cNafCbDa8uhPjgtoIcnm/xSo28aOyeryfiC9TQo/PWe77nZ+kSDZ2iXZJxkEdJCxv3iowtYWm6oERndIqRXbf7jMzYgS6lVctjoT4MVqWamRpASKb5ZZD39qzBj4ialm6K9ipdYpWhB/izWCYqVgNBMG+El67fsfOVpL3zYUfz3fKLGMcjBwPXZT081lV3TCsfbckpSkpqSLXFGaZcrKqkSJhXbG+coqO5R1mkg/3EtmMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDvsFxJLCnCIUOOtZOx/3581ihF9dnWJ6NbD6L0oyxw=;
 b=ieF0QVC6AkzHjnF3q6mZaZ8NEf/jD3QHXB/ud7Ukly9uVBbpYe8AQtSAKGlYUuATO9DPRX7EzUGQZ8gwcuEFMb7WuwoVrGh17Y49dWe/1xkUCgmLSolQKZM8X29yKxg3Vbt96v6rdDEXcf21YO/8wtt/cV2MqgAN6FJiffLIBKk7mjPyt5obAxvZU++KzapXtx9w4nsUkbbzh8WxCc5m8gFpPBlF4e7bW5HF7hUxgBHR1huAVyqEpRfeTpzqW3VVp99XKnTrc4qAotNDaALwz2T2LeZ2UJ3v6csAli9dPrlZ35vN7bMh13+GU+LVFz9XFnCBNH9RnHSCvU0uKyjcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDvsFxJLCnCIUOOtZOx/3581ihF9dnWJ6NbD6L0oyxw=;
 b=uSnwCeKurtRA2LhAgc3hLBf0xV4i9sTmVejFOjoSXPawPjLScmDrCDbxH0MHNm5dVLvb2gyMV0jB2Wl/grCargCzcGiwTCnWW3ubv9fvUYA5iyEe6sga2+oMKA7pK/zxQrpNAKGpVCwexW/duosRmHTdfZnV3az0tGx2s1MS5SE=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 12:18:40 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 12:18:40 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v5 00/17] wilc1000: move out of staging
Thread-Topic: [PATCH v5 00/17] wilc1000: move out of staging
Thread-Index: AQHV958yeak5o2ESX0m1/C56HtBz6w==
Date:   Wed, 11 Mar 2020 12:18:39 +0000
Message-ID: <20200311121809.5610-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c3c4e1b-f4f7-416f-7ca3-08d7c5b65536
x-ms-traffictypediagnostic: BYAPR11MB2805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB28057F0A303ABB9F5BF5EC24E3FC0@BYAPR11MB2805.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(478600001)(966005)(2906002)(71200400001)(8936002)(81166006)(81156014)(316002)(5660300002)(54906003)(6506007)(1076003)(8676002)(6512007)(86362001)(36756003)(107886003)(4326008)(6486002)(76116006)(91956017)(66476007)(64756008)(66446008)(66946007)(66556008)(6916009)(2616005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2805;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAAS3Cjd5wrI5h2eU4FBSGrT5ncalbRqPN8V3dM4HKMo6kkonSBX+J3QnSQjL+cLkCIQBmeY7J/HFwogjskIx2hhr7JkR6dSwTiiBpzG/Ksd0ZjV1ivnQioHuK7/wAkdJ4cG5CQzfqtkOs+9eO/LSIfiRJ4oumnr+xgDpjktRuq4+kCzaiQVQVs/BqtF9TNgGbLE0Y+wbP9HUViM+OJ2DLn82wc7Z0LpHBaR4HIMQvpAQwLOz2uit2rf8+e6iR0xrcqDm3ovQAszZuqlhJX+9U0BnztfrvTInhteYpDs/3azO+N0alwEO2TmoZBwq8HDd/O8FrLMGIW+TL46YVZZ2AnkDe8Rm6NjzpJMb25jXiI2ovO/xs8rYOOwZLZHS8D1sfwRl4SIKqRTnpxq/oSkzjYm2zEla5fQ4sBqtUMlP6W2cgdVK084ssXkyrg7skj9qoBVt9nZHmoDScvII7tyY/MKbqzwlXV7JvbaFNaAk8FXPRRlKRSWRfzz2S8dOBREMxTF6BdaHC4wNtlyrs7R7A==
x-ms-exchange-antispam-messagedata: H7wqY7b7q0jDuR2QdBSqQtnQn+jccw2rCp/tR/pKXwp35lm0XIjBfStoBB+AdGxjGs7CBmQW5OMcfK1Iay+Nm2/zz4qJzXtydIOxCerW09P8EaU/ea6qfcifYf+O1eX/03zsfK899Mx6V8betvmZuQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3c4e1b-f4f7-416f-7ca3-08d7c5b65536
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 12:18:39.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Apoc0bCQhlOdgelK89IjVABAwzALAP5rGMw68dEUm73bP/ZiUTGzej/jPf0AvoTvIvn5OLh81nUx9F1G+XXdeLlYh0kh4kEdKlQBPea5biw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
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

 .../net/wireless/microchip,wilc1000.yaml      |   72 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/microchip/Kconfig        |   15 +
 drivers/net/wireless/microchip/Makefile       |    2 +
 .../net/wireless/microchip/wilc1000/Kconfig   |   42 +
 .../net/wireless/microchip/wilc1000/Makefile  |   14 +
 .../wireless/microchip/wilc1000/cfg80211.c    | 1850 ++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.h    |   29 +
 drivers/net/wireless/microchip/wilc1000/fw.h  |  119 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 1959 +++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  214 ++
 drivers/net/wireless/microchip/wilc1000/mon.c |  260 +++
 .../net/wireless/microchip/wilc1000/netdev.c  |  932 ++++++++
 .../net/wireless/microchip/wilc1000/netdev.h  |  294 +++
 .../net/wireless/microchip/wilc1000/sdio.c    | 1023 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c |  988 +++++++++
 .../net/wireless/microchip/wilc1000/wlan.c    | 1238 +++++++++++
 .../net/wireless/microchip/wilc1000/wlan.h    |  397 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  413 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.h    |   54 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  803 +++++++
 drivers/staging/Kconfig                       |    2 -
 drivers/staging/Makefile                      |    1 -
 24 files changed, 10720 insertions(+), 3 deletions(-)
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
