Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279C3195124
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgC0GdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:15 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:41337 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgC0GdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:14 -0400
IronPort-SDR: fN9wVBfFOkeQubRTabmwW3rGnNwlXyYARIZDskx4MeCe4MvZlwzpGwYdzHQecRrgUsCSZKzGgP
 BPy6g+0DYE5HM+66E/ub+jzid2nX4TVgKSa4WmIZkwqBOTKWTNe280JBipv2mTi5PjQfIZeUXV
 JM47TCtMpqSQFgzMcGBQ4ZxNP806Fas5Yj1FIORWi4hEOtDcupWpIlwc2bS7Hyl++x1GSV6mBt
 lKTgcj9iWLHK2cCzeBk8N1wd+EVKLdEkwAp3LZ0iXm0QPHIxuvpfFZQAYXTeJr5LWlvD7mVtch
 IhM=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="7177542"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 26 Mar 2020 23:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N865T4RGWuPqdqhWAPWTnBfI1qnXU8braCBqsPTiZDEVOp1XkBS23H67Ju8WEA9AOVHJ78BnhYta0ihV5VRtPXvRPK3WEBTLhxRA0MSByonFCuKrGYToP8FJ431CWvpMkybL5cBzGlpGagJ/2jAlaJIyZIM/+j9lj23gq+YrVfvZYal6LZNx8LMObjV+VCQtu/ozAWAFJNYL9V5jb/9xF4ij8gHASdO4zFibKakejj+ukdt8ReZdnJunKGJkGCc6S8vYKORZ6pbOWH93LV6dQf62hLbBlAg1x/zVWGKMCj8t6A11OzzEGvyzyZcS1JP9U4qqLjdFXvQGME6nfJkPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bXSTxRijsaoa/s/BnBdXUvXfjVH6AfnCf0owu6UlE=;
 b=hwvjJK+5wG9k1alOEpg4uti5EMqKcHVvNax2YQbYsxYmwkfecn4GvEymlS62+uxpECCbzxahoUT3/tjDIDJIaC3agdjrfLU3BTMuTbEKrshNmx4MTO5Q0u/mLHwHp1novOF3L8FXVKvV0U29NicJf3nthNgBa6wBrzQVXLFOwo/dJTBO+qyAhjA+VafRYTBc/PXSFFtoYvMDIiGM1VNDLRVlzESlcCMi8FPOtdKT6FqhfaoooTE+WhxwSA6DEALyzRXRcKiWgvUhGNv1gbCSm8DxeEDQ6sZqDt4Bm/N8sDs83k6p7MozwJnUPsfGbez1bfuRHTixr94Tfu+YRLQXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bXSTxRijsaoa/s/BnBdXUvXfjVH6AfnCf0owu6UlE=;
 b=hThRgynjAZ9AYARvEzIhSnJDRi8yY8Y2oCApG6ZF5kMhoYCnyhU4j7+BcCuFXHtN/9WwtIYnJmCsrD3OmN0OcnzhpN/SkC3IHSOZ2HVxtnqEc9YIAXxrXu9kOGwzMYvEt62PQ839/e8bBqYKCTBzDYSR1hKYnyML+VYGFGk1+5g=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:11 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:11 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 04/17] wilc1000: add wlan_cfg.h
Thread-Topic: [PATCH v6 04/17] wilc1000: add wlan_cfg.h
Thread-Index: AQHWBAGVgZApztLeGEiCdOSTh0+myw==
Date:   Fri, 27 Mar 2020 06:33:10 +0000
Message-ID: <20200327063302.20511-5-ajay.kathat@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 788de2c0-1707-4618-a585-08d7d218b864
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3397F17F25D7B01841BC6B90E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eX10ZxWZcwgjE3IDnHPTHQ4Vr+oxrKemtjoPtftQzkAAHjegmzr7/GMFCzrCtNJrgCeMzdHk645byjYrlzrqXyho92VKZUY2mteFzLw9BBm2O1tMCwnDaDVV135r/BY876ZhR/wv2GVMzscP2ADhxNP0jKPg6R0sSdqgOmbMMl6auPEaNFagQYLvXFWbGWJosIcHCwiL4wmk2LnSWuCcGARIgNcl/FV7Gg+Y3q/j32yxON0WPcxC3CCtLZxd48O9FJHjwErnzs9sr+SZc/digB1TDlN0WXtRZ00xN7RhDKqdWrN5BsIVRHkFisernqEGlsQ4fvwls5dVRjoK+2unHSoiLwD0SbNf5+Th3Eu/5koh08OHgWcqFmGSLEyBtZ85L1XdOgs1UH/iWupOu/zUcMsy8o4ZcbERRxQXQmqXmltdEcx7tqK8pZheoFf+MbYX
x-ms-exchange-antispam-messagedata: ipm6D4ukPgPyKJKiHQIo8xd80qKIyQctRqe++gipIqtWSo5/rMRRsPYn6Cr5JaYkWwqpGP8dM9HZiEF5sIjHZzkxhm7kC+QZdxzDkrhqzU0lXyPth5XStzoyLOvVIpExVEonZO+UC/8VTB2jEZl+gw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 788de2c0-1707-4618-a585-08d7d218b864
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:10.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VL4Uedzk3Q7yTvOekHybtB0rw17fCCCKheqFXWHCM/y865QZv5MSymtUDMph1/PkNCWzXZgv0HB4zPj06tLcH8PNRU8F2dVNSd9NEDWXIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/wlan_cfg.h' to
'drivers/net/wireless/microchip/wilc1000/wlan_cfg.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/wlan_cfg.h    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.h
new file mode 100644
index 000000000000..614c5673f232
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
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
+int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer,
+			  u32 buffer_size);
+void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 *frame, int size,
+			       struct wilc_cfg_rsp *rsp);
+int wilc_wlan_cfg_init(struct wilc *wl);
+void wilc_wlan_cfg_deinit(struct wilc *wl);
+
+#endif
--=20
2.24.0
