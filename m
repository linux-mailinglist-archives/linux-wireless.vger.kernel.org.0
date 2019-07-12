Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F506638D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfGLB64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:58:56 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24921 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfGLB64 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:58:56 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: YHt1mGotWOkPhtm2TLbcAdnsXgqwdFQ03ZWwEIrFsD0jSvVCUPG0O0accWFXCJdoTVo/XjE9z3
 cNAsH9XR8cJq9t8vMk4XCMY+//pHYhphK1xNIjL6FRJGolrZb+k6Kp26nwziHmxNg6l7Vn5svg
 KErOI8NRNcplJ5KlVa3h51Wr+aOjq6gEmhnYutUEfRvv4a+SmZnS5hl17xzga0Q+5S6YdzjACJ
 gfL784u0B8RHdtk1RT+M4dzt7j4DOpFAX11aE2zKu0J5cEY9nbzNUfigQteHVkzvOy9y+qx1Hj
 g0U=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="37967430"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:58:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:58:55 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+y0dpBcigteltzEYagRTiaX+sMu08yvvM86tpBB4YiygBJF619+uSP6TFLvRvdx0MOu+950DHuyMesGDsTzLhk4xnizocXFTPAxBRRm+qbV9wD3Ef5GuhmL2hLIlfjayBx9cSbCPAZOCAXid4GKZtXXZeN2T7q1m4u8zU9JLgmiW7ke/Seiwwtz9xB64Z7E5uQNv6rMULr9d/fa/DIexUA8Nudq2eyOATBzAZz84o3j7FUo4BdVPtVXqzoSjsZYTSEygsH8W+Rg2hTXoE/h5yEij0AKy6ixBoqeF8C/G5vvAQpq7SWauu4/pHugQ5T1FCXLaqdnpD4NfPJ488rBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5CpKD6G3M7XeOE3iaPJckONPahvTJqhpLcUJDKotQQ=;
 b=RE76zapI7rASYqp3iUdtppE0/i4H8i/VMUicTawN1+18Ocs57KKp1C8oVJH8s+71bJPfhh6WE4hPSvZTMNmnQToNIjF79h5YmCGfPZGgBftj//Zyo6N/0OHuQ9qDUxcjfublwEaYA7nAYmkul6SNsDB8dNLZ/tQxY23sdb0fCGcUjJ0aAGbbMr9JwkMjZgVVGHc93bv6mp6eIrdfq3muAdpoSXay5++yxMsGcIa6jDe1e7M/vVsqYzIhvYeG2mdf9v+6NxMHxuBQf3c9J1uZtSeXnB19uDWEp0l26CrcMuIezXCY486rYkwNzamUCWHAK6f7cSewjCcNOkFdiCGMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5CpKD6G3M7XeOE3iaPJckONPahvTJqhpLcUJDKotQQ=;
 b=EmYlzmgjhfzn1wuQu5s9buFKjJBEuAYaPaHMOHuGU4gLYZKzCDLxnyujz4UPsOLOPROTZkH7eou/aozk94V3wSbHCiXjhUtyuP9L8tVgMKzu/j3xu9GLD+KpGTM6S/4tNSOjdQIM1JMyf0L2kdp3NO2yT8Nz9LjcB0vWbjV9gVM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:58:51 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:58:50 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 04/16] wilc1000: add wilc_wlan_cfg.h
Thread-Topic: [PATCH v2 04/16] wilc1000: add wilc_wlan_cfg.h
Thread-Index: AQHVOFVZPCocQnDY302lUH9+Jn8gcA==
Date:   Fri, 12 Jul 2019 01:58:50 +0000
Message-ID: <1562896697-8002-5-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: fedc17fd-aa36-4ef2-94aa-08d7066c7c17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB14252E97645D0CF93007586BE3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(3846002)(8936002)(305945005)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sYsROyMfrPzRS4HweaLPsnp2+vLVmHW06N5PqgPULZIJXoWKcubUIZzcfFZepNLt+IJvKY9Ez8u570UL8QbV+PPPhyS3zMvw/8M2GiDFil7XnnkYSCMvNoq/2nLGYPmT6N403pnhuUhn17R6wFAmAT5fT6H3ILEmcCQ+h/5RR+x5pJ4oml7Kq8xg9YZ7VcBEDyNJuCXcokoq665fnwI4JWQH1bU6AmhLmdsd3FsSYxxVKbHG+o0rU98PcXmblllEZoA6Nc7YrzXgqYHOJQqKZj1PfgM27hfw0U1aJwh3XTrL490itPoMIUmmou8lkCUiV6YZeQtPSbtJKzTVEn70eWZqe3MF5qJP6ESGERVwJ4mygkr/xbFbA1GFSdZaUhdvZUvi+EK+iudguCu1X72o+zmwH1kXKUOoQ3qhOm5reVA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fedc17fd-aa36-4ef2-94aa-08d7066c7c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:58:50.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000/wilc_wlan_cfg.h' to
'/drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/wilc_wlan_cfg.h    | 54 ++++++++++++++++++=
++++
 1 file changed, 54 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.h

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.h b/driv=
ers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.h
new file mode 100644
index 0000000..e5ca6ce
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_WLAN_CFG_H
+#define WILC_WLAN_CFG_H
+
+struct wilc_cfg_byte {
+	u16 id;
+	u8 val;
+};
+
+struct wilc_cfg_hword {
+	u16 id;
+	u16 val;
+};
+
+struct wilc_cfg_word {
+	u16 id;
+	u32 val;
+};
+
+struct wilc_cfg_str {
+	u16 id;
+	u8 *str;
+};
+
+struct wilc_cfg_str_vals {
+	u8 mac_address[7];
+	u8 firmware_version[129];
+	u8 assoc_rsp[256];
+};
+
+struct wilc_cfg {
+	struct wilc_cfg_byte *b;
+	struct wilc_cfg_hword *hw;
+	struct wilc_cfg_word *w;
+	struct wilc_cfg_str *s;
+	struct wilc_cfg_str_vals *str_vals;
+};
+
+struct wilc;
+int wilc_wlan_cfg_set_wid(u8 *frame, u32 offset, u16 id, u8 *buf, int size=
);
+int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id);
+int wilc_wlan_cfg_get_wid_value(struct wilc *wl, u16 wid, u8 *buffer,
+				u32 buffer_size);
+void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 *frame, int size,
+			       struct wilc_cfg_rsp *rsp);
+int wilc_wlan_cfg_init(struct wilc *wl);
+void wilc_wlan_cfg_deinit(struct wilc *wl);
+
+#endif
--=20
2.7.4

