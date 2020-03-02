Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2902175FD1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCBQeb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:34:31 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42759 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCBQea (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:34:30 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Nz5odoGjW2OcsB0ks0cPNucTYMyEmnv+oq3ZKMZKqvQ6dCcfudKSHoJ/HSwQbMUbKkJ7LgejdK
 FigOtdEy+HCozL8sVUh4P6WQgkBzACMUrE97jiGdU/7Pe0Iq13ull90ZfYlM10NbLQeuZamJed
 xoLABgwDBksfPMBDQWH9bnaURXWleBsn39mYzEDoODeAV4Af+i+2+F/qJquCcaM83LTYuX6uFs
 ZZcJH0t7zlBHhLZ/m0ZSY8mOCkKwguRBi4Gc++pPfQ9mOSGQ1drj+lMiABucJOTVMDqmI5lCzK
 k9w=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="68544081"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:34:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl9gr/3wZn45lBIQHr0BmdwrraJTLMNya1ysvPNTnqn/KXu0EVve20nqM4YnwJyQt/eDo3P1tJsimTLb7Kr1gcLQ3nnAyOIEht5vjsfz7akKkhGccvKqzvokQ2KT1NgAk5wPqXV27Qvg05oaI9eZLi4gnhL6GtcYmaEjKNVAqh7eNBTfW1f5d5R+An+Y5QgGSX52l3pkDh0ZkgXZcmmaeOe88P/mqdmC/hKBm/3y0x0UI7wZURnTu1dMA4JIbUiVr1NUk7ot01UxWcih6By3Id+pxq64Eo07/+/0ov0Z4AlDGgtXKnDzwhVMcxOWJ2s7/Y+aQotvemKVoQF0CWlrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODzEyhPCr9tYsmgeXCxFHbDI2CsKwkPRjGj+r4z9Qco=;
 b=Ybe28dGvr8EcepH0Cz9RJbirFgyKybjA9wUxFJfIf/euBVvCRrofJxSJWe6K2VdtVpjNIR/QC/JJErLb9nHNQ2caZ9fs321XuQ//B86q9SPMl7mDPbbosi8Ci0srwSogaXrbqBg/hZTNPJ7oNdE0DtqzRNOih51hTDrN/2ZDqkduAfHWhpVzB6xeNsVWr9VG0lKvxh0CKqnMQzHcrgqRwjmGIRCbGV4KLOHhYa6su48VUzYhwnQucMRScCfd7xUJXQOQUy44AMmZ9P4Gl39gufJp6Rs6RfQuR8v6ypls/9P9olRY/rNDHugzZwRyVLF/xzkU8q+vLI7Xbt+vpjL2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODzEyhPCr9tYsmgeXCxFHbDI2CsKwkPRjGj+r4z9Qco=;
 b=IrlobAsu4m5RJP1feN4ZvE7AjW0AARG4go01bdgr+Fc+K2CAYEuFnCMPtltu+Tph48eaVywTeXck5vmO2F2vLuEjOyBrBCnTZEpEDxmLYJ/qPLlClGXbbW85jsuPP01B8F0ZBWgRNyC6/aUHNLk4TWJXAJDwJAaR0bmSMtiQ0AQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1411.namprd11.prod.outlook.com (2603:10b6:404:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 16:34:26 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 00/18] wilc1000: move out of staging
Thread-Topic: [PATCH v4 00/18] wilc1000: move out of staging
Thread-Index: AQHV8LBvFAm3KgI7802xfJDNTqJQFw==
Date:   Mon, 2 Mar 2020 16:34:25 +0000
Message-ID: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d9366a-391b-4900-bf7c-08d7bec7927c
x-ms-traffictypediagnostic: BN6PR11MB1411:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1411B4B9C8E4CA7A26A8BA79E3E70@BN6PR11MB1411.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(26005)(186003)(8936002)(2616005)(6916009)(316002)(478600001)(36756003)(54906003)(2906002)(966005)(86362001)(8676002)(6486002)(81166006)(81156014)(6512007)(71200400001)(6506007)(1076003)(107886003)(66476007)(66946007)(4326008)(5660300002)(76116006)(91956017)(66556008)(64756008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1411;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sgubRMWPG+KY0A+7HFlW5EhglYqej+23M3ul8k48H/5GlhmQPj44Mxz5u4RUB3owyWmDJg3auNwZXVqnWIexs2jWg7e1OWa5DFio3U+Y/Fkuir3zJZoQ8Xy1wJ/XUvR0eMWkmaRR6Qts72oxxcycVdzu21e53DLpx4QRd1M/LYpWfRfYXlqnRwkG+pEbiBcOQBMWlYDOQwNph7SRvHUUwK0ALZ1nWWQPErmWWGXDAfBA4vkKtp1IrKBLAxxW85g0EHVaHp8GR4x63uPI6kcgXRTNmt9dE07mgW4rWFfyJ85iaDV/gqNeUVkwP5bP1N0/Wa60c/BTekBvm0KwnLeNlCIJLSS6rzMvwlV5Qs+fBV15FCyOBhOAnY0pQ8rG79RvqSjvS3xVJkxr/2EFKPtyyZcyjHHND7kU/ACVONV3KFYGsFR0mQy7LGyGHQSKwjDRWf0uqnQ4yS7YGNj6YaBYbX+akJ+1BEBrANoW/2PXkBYSwbkOShD9q6VO0NBjinZILQ4YDvo6/r7xMioYbmGKJg==
x-ms-exchange-antispam-messagedata: x+YOXOyxMMIgpKml+S03kz1h/8mCDzxoGcvAY1LuO6HSMWf0HR4+682Oefgm+zwBA9FvaDPEhULMZEFG6MpVyROH9oz9RzXUOB0XEEtzBztS7sdzXKdviHNXOwMX8LyuEEBpV0bpVx3OVQ3Yab22Rw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d9366a-391b-4900-bf7c-08d7bec7927c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:25.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9I71GrnvHPdQlMPWICV7/ZFP1XNbqqqt5A/cI2CtOvy92GsA+arX8YIZVUpd6tie/x38V6dlAlgKeJItvwKDJLcLcMPgETcBbF4zhsmVUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1411
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
  - move firmware realted struct to a separate file.
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
 .../wireless/microchip/wilc1000/cfg80211.c    | 1850 ++++++++++++++++
 .../wireless/microchip/wilc1000/cfg80211.h    |   29 +
 drivers/net/wireless/microchip/wilc1000/fw.h  |  119 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 1959 +++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  214 ++
 drivers/net/wireless/microchip/wilc1000/mon.c |  260 +++
 .../net/wireless/microchip/wilc1000/netdev.c  |  940 ++++++++
 .../net/wireless/microchip/wilc1000/netdev.h  |  295 +++
 .../net/wireless/microchip/wilc1000/sdio.c    | 1030 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c | 1001 +++++++++
 .../net/wireless/microchip/wilc1000/wlan.c    | 1238 +++++++++++
 .../net/wireless/microchip/wilc1000/wlan.h    |  398 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  413 ++++
 .../wireless/microchip/wilc1000/wlan_cfg.h    |   54 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  803 +++++++
 drivers/staging/Kconfig                       |    2 -
 drivers/staging/Makefile                      |    1 -
 25 files changed, 10807 insertions(+), 3 deletions(-)
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
