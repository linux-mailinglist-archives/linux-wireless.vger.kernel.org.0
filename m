Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED764204FD7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbgFWLAm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:42 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41168 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732398AbgFWLAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910018; x=1624446018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3DdQqgsw3PaDaPY1lffS1SdJjLu0Z363tP/wFlDQ2B4=;
  b=MXBTOdIUmKjBccj4GcMeRAA7UNkCzNflvcI8BGQmKyh+CoR7Z9098pAa
   2M97UnlWEnhDKrLE/bdD+1eny7pPJRovk56HrfN+NNXsJcE5q+uxIDKB2
   c9WQYRdoo/wMBLZyPFBFzNtQIyA4Qg0l7YaNd2zKOEqkDvFI17C1Gdx6o
   Gb3RNHmFEK29tYKh4zK1e2fg1R7VTQswJoTeHs0jUAYlJyszSYE57dnr9
   YXt/hjaAuxBUiYskim48kmafKtUTvasjaJpS5cuuWlpztGdcIU0bsEdJf
   RFfBwbV+QOeydi/m5k+JvrPt62S71WwMx5tjvr+dho5Mfwl8K+pSjKUcP
   g==;
IronPort-SDR: 7Yl+1/H1yTq8JfUML4y5iwca0KiSQCSuyzUOb5O/LcMb1JuNPVWttsIS/bRWhfmWMfrLmxlkME
 gai0+B0BAPkbGX8R/FZ+bF08OLt2hq6yjJVAJ8OsPQoC/38cRAg+Ur71v9v7YKrLD+yLVJwmfN
 oTv9Iv5lc3GWTDgtewMCIBBzQLR/8y3PZ+aFFGwB5DHC0Q8JJJ79AC1WCkqSZyI1UKa1xEbW4B
 FoRnfIbS/m/SoZJKNxENtRQyvHZTpL/7vXayJMCcKihsn7WfMmWSW7C/Wa+IK8oYi1XuZeRegU
 Gp8=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="80543432"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 03:59:58 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 23 Jun 2020 04:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZgum5WuLMWj1oMaj/CyrClsXJsG14XMVUSAQa3oOHrgG5rem3nfRQOf9wtzSrY2j55NUkxnmiHm2FRF64MGfbWRl+2fg9ErQL6oGS9CgKvdrPPoJSkojk/mHgp/PR1xhMPXoUyEKKOtIk0Oi1EVQIQTKiLz2s+w09G+G5F1MVfr41iOlMT7a6vM3bWT2I6p+udNYAPQV+Vu1fKoHzrTHBM58kfoELlGjXsK9vL55X2vAqXis6UY8QfJh72quKFqhpAnRRqQ5lg4I6GVZWaZo8CmntzYD0CyjLoMcXg8F3Uhbtg/6rfsHt1IPs77RqyiRe58mjfHkcUXbmR5nOmMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bXSTxRijsaoa/s/BnBdXUvXfjVH6AfnCf0owu6UlE=;
 b=EPh89Y9/AhwXdrI2kFmCsuiRHtwAR9sbKrwPEXT8kQ1wIPzsDK2Hfr6MgYDDH4fi/KalZRmopNCE+WHEnduDKzLs9u4AnaAoKU0g3fFCTmZGA/6wqQH7PXp7JLEDlFixlgXEOBgNG/4eWCisFeIo7nPfe+9BIWTV3f2dDufkaDzrZ5MiofCmNe5kNknS4dSDK3UCqBu9l5wQMpckmysuXO8brgX9uNp3t47CpN7TjR8UJVTF3S9MPQzAKOaG10KyqiJYzc6PiwIDXF0JgwJ0ay/FxWUV/IGiFY7Caa3icLS8L0dWO8keR1fkiOyp92zLcRHd4kjFqW89k9m2HqfB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bXSTxRijsaoa/s/BnBdXUvXfjVH6AfnCf0owu6UlE=;
 b=TWdPue9tSmPFIeH1w89T/cLjUPHGyoa06DJT8ENAsLlXBBz8JqxbqlWdPOQHLkvBsxvSVDT4acrOhcnJS4+0iCrz1jvvlTvhhsxOVyJYXgYZJWxgifDYMKaur7RVoSj5sbfGTaMcEbuVzWryeI88RBziM9kQ+xCFG6+fw4cDabs=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:07 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 04/17] wilc1000: add wlan_cfg.h
Thread-Topic: [PATCH v7 04/17] wilc1000: add wlan_cfg.h
Thread-Index: AQHWSU10gM5n1w//+UepUiCrEA41EQ==
Date:   Tue, 23 Jun 2020 11:00:07 +0000
Message-ID: <20200623110000.31559-5-ajay.kathat@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 14f6d116-9485-4bbe-8446-08d817649741
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB355180BFB5B79F7384718845E3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9J2Rba/ea5zDS6ICzAaijGlhLFUOq1BSV5UvJZZDLmSUmlolOGPOIplxgXZiAo9jfr9BV28kQ8EZ4yOIIPlLVnyha9mqT6vKih1znv990prs9nVE2DXq3Q4VUnTawv2VPIQQiInlobCfBSwcTvotufv2J9ymt0hLxSc54KyBuNg38H7LypyzwIVMF+ejYVUgFb/lQ4k6RVMrpEAEwGgW9iZ6GGFaGDDpO85ywxx8gY5Ac+FHzRmi1ztAzRdQsL3UxVFic+Fr/BSyc50KcpP2ZntkqfMJE6oajmvRuO6f/b06OBlinvc/PRWynEOJs+x6QK8qg4dAHhZIREa74UvzaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4VdUN8MtBDRR9TaR4gg1ceL/KebFqHzJGeSbzM2T2iucsJk3twTjcwEE90P9kISPpgOxOZsfqA0khiojGZ8dId4nlxJNXnVSuaf/5Wls5FKomZVrRqfrdpyxGc4GwMkV9fEz9qq8agiZnnm+574BaBEYNw924WoWK2Z2T7kLynlfL9vdjm7r1mIU0z6baBAnsTkUBdnGR+DPXUnKtUGRqK2ch7dufeVCmontqGUPS18mBuDCYtUPFkboErjV0iFv4qxUeEYAyZmYyk+HVziFFI3oR1B2+gBHE621vUy2AMRBSltvPhuwmwtQAklyG8VUVN1jXD1xOJ1NvZ4cxao37NYx2YLzM/jB9Dca4DQr/u0DCFmVFOPqtolUzMTj29VjDvRwc3AGhgqdv+PpTxO8t4EPwlcK6AlG5OF8KHRAlLU0T+kQScytBKAFZgkgAQi72Mo/eoHqTkbHs0lREpOHGK5QVjKRKx9q134qCes+HapMwopRhnCo1Ypcoxydx1U2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f6d116-9485-4bbe-8446-08d817649741
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:07.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvjyguGka3OVxqQ/vW81icvt25FrE1Ea3afQ+1v+SpVfXCjjt6Lp+hqNK+Y+n/1CFWXDtNXP7jmLdsE/LduJURIB25gIMEDxLd1fEGH3b8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
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
