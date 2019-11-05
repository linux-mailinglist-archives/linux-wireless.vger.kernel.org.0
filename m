Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2AEFA12
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbfKEJva (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:51:30 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:28018 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfKEJv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:51:29 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: gPfNh8ZdzXOFWXV3YbmQ2P+UGDJYrpQQG9UO8K+NpvhSfyQpu68oZ4QVoz+IKB88b0TUVeAqe5
 BWW+DTI0EWBdk+PbQ/Cr2lA6VZwNOAZKBOioiJ2CsyBWCg2kTK4UAL4Z42i+u+FUWp4SDJh6cf
 oZCjUiL0ycvzZrRluCWcRyWbOOrfNUFBToSKOzFwx/cI54EF9aGTRt1cEUccADtvU02Xptq+Me
 sq0NZc0HXAK0jQ4uBDmQnIsNQ6vrprqgvlOb4FQ/L3nvhY3ND0AT1EAyJtNWj1ROTUEHkrFYl2
 qZ8=
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="55347241"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2019 02:51:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 02:51:26 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 02:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyQOWQRvk81ignzAtxA1z9tW1+FmG7rABEtVkhnNPHSE3smHU6xcMEqdkdpDGegbs27nUdHe0D400nJm3K0bM5ei7gA5A34GjT2L+Gya9FqQpJqPXYY4tL/pqbt91p5lCmEr8bVCY1UMA0RMBDFIQ4lIEZrBOfHjEhJtAk271NRyUXTV+peO7dudHb6xMGYl+/IB3eBDFXkm6FxXIJOmUZhh5DC2G6z3XoNYQHbWTcsWaekLriMPmEtwnUfaBWxgr9Ed0G10bshUbsE1mUHKBNcUj6Zbz14TbR/bzWyidLuPV5e2M2WWXNgfbthKhQfMhLX9LhAVHwJ9TZcbiUclUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yhP/NQ/8npXThIcJJm91MPp1VKEfEOSw64Somi19Yc=;
 b=dZ7TbCHUbyfHCMm3Nl+BP0zZh/qJVejiOhRHb4k372jZWSj3NLhYxE5R3nrAacZvMgErs5jxx4UIkENDSgb8g1VUCmEkRP7S6xhKpvjBVJIkUmtWxB/F2teua5SmQZnt/+tpcsRQh1kRiKUn67ll8aSwGnItTIjrzICBFk5JYrhgYVqke1HpbXKw1psCalmuTBVwujLNK2e9r0Lr8udabhBwMKeH7x+DpHyvTU746GOoYR5LkudjaMMpodhYlEJKYWv214MvRe+p5zJVAvGT8v3qmY0zo7HkAdRdCZyFBsYdxijoYUdFCsEzpHTsBhpcOIim/K8h9Bh1Fqctj3QkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yhP/NQ/8npXThIcJJm91MPp1VKEfEOSw64Somi19Yc=;
 b=CmGtOGEZqXoFkwVasCx24lNDWLSVOzIX8dHu52PnaeRWjwjWsRVF8zOUISsMyG5PBxejCVfPYML6ZDmkWP17LXJF0Kru8c+X2NyhRR9D9NJKLzXYDaQ/Q9b4+CHsPl1wgY9IV03Dt5y2ZTGDcDOmV/99DsFRNhiIN/mUJyyC0A0=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1972.namprd11.prod.outlook.com (10.175.100.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:51:25 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:51:25 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/6] staging: wilc1000: remove 'wilc_' prefix from filenames
Thread-Topic: [PATCH 2/6] staging: wilc1000: remove 'wilc_' prefix from
 filenames
Thread-Index: AQHVk76WK1y3uclfH0CgV2CVly4LJg==
Date:   Tue, 5 Nov 2019 09:51:25 +0000
Message-ID: <20191105095058.24223-3-ajay.kathat@microchip.com>
References: <20191105095058.24223-1-ajay.kathat@microchip.com>
In-Reply-To: <20191105095058.24223-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a67ee5b0-98cc-4bfc-d225-08d761d5b8a0
x-ms-traffictypediagnostic: BN6PR11MB1972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1972C0BE03A5C0644696B306E37E0@BN6PR11MB1972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(6436002)(2616005)(36756003)(71190400001)(486006)(186003)(86362001)(76176011)(386003)(14454004)(5640700003)(52116002)(2501003)(6512007)(64756008)(99286004)(6916009)(66446008)(66476007)(66946007)(66556008)(71200400001)(2351001)(26005)(316002)(8936002)(8676002)(50226002)(81166006)(81156014)(102836004)(6506007)(5660300002)(11346002)(1076003)(476003)(107886003)(54906003)(446003)(478600001)(25786009)(2906002)(7736002)(305945005)(4326008)(6116002)(3846002)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1972;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9N2C6LZ2OcxFeyACQ7ag0chJfXNAy1HxzZ5Llp92NAWpGk4yHfacN0YfWLU2OlsHOoapdVN5rErBZWoxj9K9kcxW2nkf7MwjbhV5Hpr9/gVDvicVSUohaIyfJrIpu/NIfpUvqxDWkViPLjqQxY1Z8a1Vbe5KWxhQnofvIz9C3IMCPuRBcvxwBJeZQbz5HEkxxqv9ATw5BhJ37Expke+j6bz/JIgsgv0wb3GUxvIn/TiRz3yL73pvkmldFNQxWJ3s0JKEANyRxMjlpaxuHIhet5Sat3WRelRj2TGaBo+En/3ibOJ6afwXXGeDYq9UXYMN03kGT+PjoE7x3sXaiLx3i7MJwcANn/9QfCrvLDmnYC4bn1PEKY6UCR3MwFF7vGTlKryb7ob2WiHlocovYc7MwnmnjKzjGol8Wmqz8qXw+p6ozDuZxJhd3hhrfoqjGXA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a67ee5b0-98cc-4bfc-d225-08d761d5b8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:51:25.3937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ancbhmeaXYIFLDvQzrrY8qiThEH1x6KoKT3lY2P00T4MJ8VeqGfZCT9IhLcidZimUiQ0f5i69kIRFBLaraZ5GarQmCHbWZnRIVUFLwKp2Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1972
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove 'wilc_' prefix from filenames, the driver is already present
inside the 'wilc1000' directory so no need to add 'wilc_' in
filenames.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/Makefile                         | 8 ++++----
 .../wilc1000/{wilc_wfi_cfgoperations.c =3D> cfg80211.c}     | 2 +-
 .../wilc1000/{wilc_wfi_cfgoperations.h =3D> cfg80211.h}     | 2 +-
 drivers/staging/wilc1000/{wilc_hif.c =3D> hif.c}            | 2 +-
 drivers/staging/wilc1000/{wilc_hif.h =3D> hif.h}            | 2 +-
 drivers/staging/wilc1000/{wilc_mon.c =3D> mon.c}            | 2 +-
 drivers/staging/wilc1000/{wilc_netdev.c =3D> netdev.c}      | 4 ++--
 .../staging/wilc1000/{wilc_wfi_netdevice.h =3D> netdev.h}   | 6 +++---
 drivers/staging/wilc1000/{wilc_sdio.c =3D> sdio.c}          | 4 ++--
 drivers/staging/wilc1000/{wilc_spi.c =3D> spi.c}            | 4 ++--
 drivers/staging/wilc1000/{wilc_wlan.c =3D> wlan.c}          | 4 ++--
 drivers/staging/wilc1000/{wilc_wlan.h =3D> wlan.h}          | 0
 drivers/staging/wilc1000/{wilc_wlan_cfg.c =3D> wlan_cfg.c}  | 8 ++++----
 drivers/staging/wilc1000/{wilc_wlan_cfg.h =3D> wlan_cfg.h}  | 0
 drivers/staging/wilc1000/{wilc_wlan_if.h =3D> wlan_if.h}    | 0
 15 files changed, 24 insertions(+), 24 deletions(-)
 rename drivers/staging/wilc1000/{wilc_wfi_cfgoperations.c =3D> cfg80211.c}=
 (99%)
 rename drivers/staging/wilc1000/{wilc_wfi_cfgoperations.h =3D> cfg80211.h}=
 (97%)
 rename drivers/staging/wilc1000/{wilc_hif.c =3D> hif.c} (99%)
 rename drivers/staging/wilc1000/{wilc_hif.h =3D> hif.h} (99%)
 rename drivers/staging/wilc1000/{wilc_mon.c =3D> mon.c} (99%)
 rename drivers/staging/wilc1000/{wilc_netdev.c =3D> netdev.c} (99%)
 rename drivers/staging/wilc1000/{wilc_wfi_netdevice.h =3D> netdev.h} (98%)
 rename drivers/staging/wilc1000/{wilc_sdio.c =3D> sdio.c} (99%)
 rename drivers/staging/wilc1000/{wilc_spi.c =3D> spi.c} (99%)
 rename drivers/staging/wilc1000/{wilc_wlan.c =3D> wlan.c} (99%)
 rename drivers/staging/wilc1000/{wilc_wlan.h =3D> wlan.h} (100%)
 rename drivers/staging/wilc1000/{wilc_wlan_cfg.c =3D> wlan_cfg.c} (98%)
 rename drivers/staging/wilc1000/{wilc_wlan_cfg.h =3D> wlan_cfg.h} (100%)
 rename drivers/staging/wilc1000/{wilc_wlan_if.h =3D> wlan_if.h} (100%)

diff --git a/drivers/staging/wilc1000/Makefile b/drivers/staging/wilc1000/M=
akefile
index a5a8e806b98e..a3305a0a888a 100644
--- a/drivers/staging/wilc1000/Makefile
+++ b/drivers/staging/wilc1000/Makefile
@@ -4,11 +4,11 @@ obj-$(CONFIG_WILC1000) +=3D wilc1000.o
 ccflags-y +=3D -DFIRMWARE_1002=3D\"atmel/wilc1002_firmware.bin\" \
 		-DFIRMWARE_1003=3D\"atmel/wilc1003_firmware.bin\"
=20
-wilc1000-objs :=3D wilc_wfi_cfgoperations.o wilc_netdev.o wilc_mon.o \
-			wilc_hif.o wilc_wlan_cfg.o wilc_wlan.o
+wilc1000-objs :=3D cfg80211.o netdev.o mon.o \
+			hif.o wlan_cfg.o wlan.o
=20
 obj-$(CONFIG_WILC1000_SDIO) +=3D wilc1000-sdio.o
-wilc1000-sdio-objs +=3D wilc_sdio.o
+wilc1000-sdio-objs +=3D sdio.o
=20
 obj-$(CONFIG_WILC1000_SPI) +=3D wilc1000-spi.o
-wilc1000-spi-objs +=3D wilc_spi.o
+wilc1000-spi-objs +=3D spi.o
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/cfg80211.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
rename to drivers/staging/wilc1000/cfg80211.c
index 66328ac85adc..4863e516ff13 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -4,7 +4,7 @@
  * All rights reserved.
  */
=20
-#include "wilc_wfi_cfgoperations.h"
+#include "cfg80211.h"
=20
 #define FRAME_TYPE_ID			0
 #define ACTION_CAT_ID			24
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.h b/drivers/st=
aging/wilc1000/cfg80211.h
similarity index 97%
rename from drivers/staging/wilc1000/wilc_wfi_cfgoperations.h
rename to drivers/staging/wilc1000/cfg80211.h
index 7206b6162a8c..05c910baf095 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.h
+++ b/drivers/staging/wilc1000/cfg80211.h
@@ -6,7 +6,7 @@
=20
 #ifndef NM_WFI_CFGOPERATIONS
 #define NM_WFI_CFGOPERATIONS
-#include "wilc_wfi_netdevice.h"
+#include "netdev.h"
=20
 struct wiphy *wilc_cfg_alloc(void);
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type=
,
diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/hif.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_hif.c
rename to drivers/staging/wilc1000/hif.c
index 59eb7600619b..25f035c02b10 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -4,7 +4,7 @@
  * All rights reserved.
  */
=20
-#include "wilc_wfi_netdevice.h"
+#include "netdev.h"
=20
 #define WILC_HIF_SCAN_TIMEOUT_MS                5000
 #define WILC_HIF_CONNECT_TIMEOUT_MS             9500
diff --git a/drivers/staging/wilc1000/wilc_hif.h b/drivers/staging/wilc1000=
/hif.h
similarity index 99%
rename from drivers/staging/wilc1000/wilc_hif.h
rename to drivers/staging/wilc1000/hif.h
index ac5fe57f872b..2defe58ab194 100644
--- a/drivers/staging/wilc1000/wilc_hif.h
+++ b/drivers/staging/wilc1000/hif.h
@@ -7,7 +7,7 @@
 #ifndef HOST_INT_H
 #define HOST_INT_H
 #include <linux/ieee80211.h>
-#include "wilc_wlan_if.h"
+#include "wlan_if.h"
=20
 enum {
 	WILC_IDLE_MODE =3D 0x0,
diff --git a/drivers/staging/wilc1000/wilc_mon.c b/drivers/staging/wilc1000=
/mon.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_mon.c
rename to drivers/staging/wilc1000/mon.c
index d6f14f69ad64..853fe3056a53 100644
--- a/drivers/staging/wilc1000/wilc_mon.c
+++ b/drivers/staging/wilc1000/mon.c
@@ -4,7 +4,7 @@
  * All rights reserved.
  */
=20
-#include "wilc_wfi_cfgoperations.h"
+#include "cfg80211.h"
=20
 struct wilc_wfi_radiotap_hdr {
 	struct ieee80211_radiotap_header hdr;
diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1=
000/netdev.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_netdev.c
rename to drivers/staging/wilc1000/netdev.c
index 2bc7e5427fa8..d2c0b0f7cf63 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -10,8 +10,8 @@
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
=20
-#include "wilc_wfi_cfgoperations.h"
-#include "wilc_wlan_cfg.h"
+#include "cfg80211.h"
+#include "wlan_cfg.h"
=20
 #define WILC_MULTICAST_TABLE_SIZE	8
=20
diff --git a/drivers/staging/wilc1000/wilc_wfi_netdevice.h b/drivers/stagin=
g/wilc1000/netdev.h
similarity index 98%
rename from drivers/staging/wilc1000/wilc_wfi_netdevice.h
rename to drivers/staging/wilc1000/netdev.h
index d94a4808bdf9..8bc62ce4f2f7 100644
--- a/drivers/staging/wilc1000/wilc_wfi_netdevice.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -14,9 +14,9 @@
 #include <linux/if_arp.h>
 #include <linux/gpio/consumer.h>
=20
-#include "wilc_hif.h"
-#include "wilc_wlan.h"
-#include "wilc_wlan_cfg.h"
+#include "hif.h"
+#include "wlan.h"
+#include "wlan_cfg.h"
=20
 #define FLOW_CONTROL_LOWER_THRESHOLD		128
 #define FLOW_CONTROL_UPPER_THRESHOLD		256
diff --git a/drivers/staging/wilc1000/wilc_sdio.c b/drivers/staging/wilc100=
0/sdio.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_sdio.c
rename to drivers/staging/wilc1000/sdio.c
index c787c5da8f2b..319e039380b0 100644
--- a/drivers/staging/wilc1000/wilc_sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -8,8 +8,8 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/host.h>
=20
-#include "wilc_wfi_netdevice.h"
-#include "wilc_wfi_cfgoperations.h"
+#include "netdev.h"
+#include "cfg80211.h"
=20
 #define SDIO_MODALIAS "wilc1000_sdio"
=20
diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000=
/spi.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_spi.c
rename to drivers/staging/wilc1000/spi.c
index 166455a969bf..55f8757325f0 100644
--- a/drivers/staging/wilc1000/wilc_spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -7,8 +7,8 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
=20
-#include "wilc_wfi_netdevice.h"
-#include "wilc_wfi_cfgoperations.h"
+#include "netdev.h"
+#include "cfg80211.h"
=20
 struct wilc_spi {
 	int crc_off;
diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc100=
0/wlan.c
similarity index 99%
rename from drivers/staging/wilc1000/wilc_wlan.c
rename to drivers/staging/wilc1000/wlan.c
index 771d8cb68dc1..d3de76126b78 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -6,8 +6,8 @@
=20
 #include <linux/if_ether.h>
 #include <linux/ip.h>
-#include "wilc_wfi_cfgoperations.h"
-#include "wilc_wlan_cfg.h"
+#include "cfg80211.h"
+#include "wlan_cfg.h"
=20
 static inline bool is_wilc1000(u32 id)
 {
diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc100=
0/wlan.h
similarity index 100%
rename from drivers/staging/wilc1000/wilc_wlan.h
rename to drivers/staging/wilc1000/wlan.h
diff --git a/drivers/staging/wilc1000/wilc_wlan_cfg.c b/drivers/staging/wil=
c1000/wlan_cfg.c
similarity index 98%
rename from drivers/staging/wilc1000/wilc_wlan_cfg.c
rename to drivers/staging/wilc1000/wlan_cfg.c
index 3f53807cee0f..904f84077ff7 100644
--- a/drivers/staging/wilc1000/wilc_wlan_cfg.c
+++ b/drivers/staging/wilc1000/wlan_cfg.c
@@ -4,10 +4,10 @@
  * All rights reserved.
  */
=20
-#include "wilc_wlan_if.h"
-#include "wilc_wlan.h"
-#include "wilc_wlan_cfg.h"
-#include "wilc_wfi_netdevice.h"
+#include "wlan_if.h"
+#include "wlan.h"
+#include "wlan_cfg.h"
+#include "netdev.h"
=20
 enum cfg_cmd_type {
 	CFG_BYTE_CMD	=3D 0,
diff --git a/drivers/staging/wilc1000/wilc_wlan_cfg.h b/drivers/staging/wil=
c1000/wlan_cfg.h
similarity index 100%
rename from drivers/staging/wilc1000/wilc_wlan_cfg.h
rename to drivers/staging/wilc1000/wlan_cfg.h
diff --git a/drivers/staging/wilc1000/wilc_wlan_if.h b/drivers/staging/wilc=
1000/wlan_if.h
similarity index 100%
rename from drivers/staging/wilc1000/wilc_wlan_if.h
rename to drivers/staging/wilc1000/wlan_if.h
--=20
2.22.0

