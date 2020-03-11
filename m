Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8741817A1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgCKMSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 08:18:47 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26273 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgCKMSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 08:18:46 -0400
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
IronPort-SDR: XexWsn5dctibh1mkLIHiRs5JV2cD3sQU3yFIBRLTXts2fJowVI4UQh9Ef76jwXyUpUexyOz+jH
 Fx6XytNpeWvW9LYdV0IkGsDv/8id847EWyveyz3/3HIJsMNa7Dp+ZVYHw7qjRQANNwujPJSpce
 QblD+69nkWb+ub8Wo+CyWfV9IAmGmUatBINaXhFuEPnE4O9SQGscbkriiSf7F7mAga8SvLU922
 Qu4/WJtbqvhZ/Dwr77ewnEytG8fwFtA6lqbLhn7+IyQjhBHOSAE6F+GWQ1H7VTW9+ySXRvkrzg
 Hzk=
X-IronPort-AV: E=Sophos;i="5.70,540,1574146800"; 
   d="scan'208";a="5254833"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2020 05:18:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Mar 2020 05:18:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Mar 2020 05:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alC8loJkr87ty0Mg47xKLYvpd3enZpkFy8+KihQLZgsxewwzQ+GWG/ZjKx8LkwwPEEyn9ITXdfwM/R0qDGwxf0Bx5C3gEZt4g47w5u9CszxVr59tqcrfTCtxvHXoFqNiSrmi9fpkPlusBGBqywHbDqLGiiLiPmAsSyHLevXbB1c5MBb+RdMcLgju0AMyWQB4r8ZirlPmUrQLRFfnER6nwqj/Iqjj6LtEhQMK0kfeBs1tISnNw2aFTRK3avE8TUDR/8yLWKWqjHtVWDE9ywI09ch1hDvW8bN/kP86awHxPMe8ObaSErHm/Ez7AEjmSWlxpRFvbKcZrqrwzOi3lKaXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bXSTxRijsaoa/s/BnBdXUvXfjVH6AfnCf0owu6UlE=;
 b=A7tXr7nDffHc0sVecTDx/6TIXG0vqZLTfVWuCRB1K66TvpTXPgM3Hy1hrzfzivz3WPO8rP9i2LtruVFXttU48D+AQv+raHgTIwHChTkm9wyhBmKDf2kcx9QzYGtJxfZRXrSt45najYdXbF04avz+VlE9KPRX6ENZ2RgZeAhpsIL8WM5F30nZvK9tiaRXmVTZ570GM16XsfJsJqL/GzQTIVeI+BQHkXAjG+MVxAWM5BIlGbnv2Avd6BTrJ5AbWHePsvkY6JGDeqbnR2ia2hGJoMvHnnNkyxGv13t54rQ9920Z08shlTUnG0OiqedRTZTpEk63aBZTtTKvte19gpy0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bXSTxRijsaoa/s/BnBdXUvXfjVH6AfnCf0owu6UlE=;
 b=VO1J+4FnY4qErein529iWjYBrzgyHp5mk3fpXz3tYSw/2qUxOQkHBCuhc746hAporMX5K2X6N64Iut3YLm3UqxJta7gFpU5N7cRWvOTmWlMR1lETAZYV6KYLBYv76QOxJOZ3s7tDIQ1EdydcFp1E1zmo9crurec45sQYeyCfmxM=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 12:18:43 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 12:18:43 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v5 04/17] wilc1000: add wlan_cfg.h
Thread-Topic: [PATCH v5 04/17] wilc1000: add wlan_cfg.h
Thread-Index: AQHV9580B9W9KY7qCE+Vu2FbWsQL0g==
Date:   Wed, 11 Mar 2020 12:18:43 +0000
Message-ID: <20200311121809.5610-5-ajay.kathat@microchip.com>
References: <20200311121809.5610-1-ajay.kathat@microchip.com>
In-Reply-To: <20200311121809.5610-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ada170d-2a15-403a-e3f7-08d7c5b65773
x-ms-traffictypediagnostic: BYAPR11MB2805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2805A078415D265BC7C0FB5FE3FC0@BYAPR11MB2805.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(478600001)(2906002)(71200400001)(8936002)(81166006)(81156014)(316002)(5660300002)(54906003)(6506007)(1076003)(8676002)(6512007)(86362001)(36756003)(107886003)(4326008)(6486002)(76116006)(91956017)(66476007)(64756008)(66446008)(66946007)(66556008)(6916009)(2616005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2805;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIEtjD3+xAm+hAGRVlXBn39yVJAQ3kqDT7BcBpkncTGFIcgs4pmyhakYj1DpnHZNWjh3z/pJS3dxjqzWvimplMZc9KwMxYZkSvxmt4A/JkrE6X3F21hz+/e8yenEyuVmy3pdTuJm+mvUydKbjmYfiRS9GFqaH442vH9ddX6tcpPM4HgLzFYtUAkG1DVJd2sOP8N0HSQL2i8Km6WRpg3ynKefcPyqzbl6fE1wcLtP39OFLz1eirE5zYj+L74i/2iBk8QsHRe3cMkm3AJfyezRJ2X8antPDRYH3xX/n0duRb0oLrDA252Th2G3IiSpauTHjlYYCvlJNw3W0mKWr7ktjD+EgMx4GR1KPyqvvkXu9bUT+QFwyjb7050tlrAmIjj5RQm11v7g0HEJxPGnq4czV89XUcD7S7f1xiPTEIql+Jkl4BF5YYWOBLClTZ2VpMxk
x-ms-exchange-antispam-messagedata: BD4IKEfKxtkm3rzCCz5XTpdoCW/t2EnQ3MFw+b3Nar8OuFmsA0ktoEn17AeQoktd80WjgXl2HJL8+R57fjO8UvViYbYJK6Vf6W7hklu0wgv70tG7SpxNS0ZQkxxSA1bmb5sg9iyI/yyAE0alTXnPKQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ada170d-2a15-403a-e3f7-08d7c5b65773
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 12:18:43.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iqi4hcmHQWgxGqnXRwwXTtKmxJ1jP4tZKxoxy0auxdfZedvQ6waEUzwHDQ8PdM6UWpP+5pcVfjQGyAxLmpdZax+JdAeEPCAR8rSQ54S86B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
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
