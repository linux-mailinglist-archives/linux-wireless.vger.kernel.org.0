Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A098D66390
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfGLB7E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:04 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58274 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfGLB7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:03 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ARDC2VQ5YiTRTDVnSrWM5uZcStU/o1Ezw94Ylb4/eml4MHyYwVKVX8/EBgXi/+X5YWo2cMBXax
 EpdFqWpscW1XzZeRoxTet4SO02uhMbNyjHfMnRNrJwkx0RgB4RDjruMhY7kZnmJTOElgLiPRns
 B+rdJCcCRxsvQ6LhX++Y6gDp3Cwuhh8Re7Hn3Dfe6ihkiV4S+PPuD6plDVaDyRKFW6TSAm4q1N
 pmjqc+jR3Xt6stNlk7HXW4d5UIMGns0rc6YNJx0+0h380ceu8JmS9G/WupfLuYtXzSfFujUf2S
 i9o=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="40317304"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:02 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbb5ZR15BdRz0FuwvuJ0uN5FI4tos1TGPyuCvakQJ2IgNAYBtQxTpmP0O8RNmROoWTwXJd9oQCjxYBapaIzZpo2BxrwFWq9iEmOu4inv54Gq/n8oKOwiD9xTrjSuR5lSNrPufIDFL0j2DnozSZT0CDS/aTSAQ1F1bPpmEloqr4EJRwBGXYVXGyY8qptukvP6GSbbARIWELQKS5HW6LdYzUfV1Z6XlkqmMbz5yFF/vKeWEWsGhSO87eMWaKtH0LY8hh+QJsDVi+bzk6MtGSEeXTk8AjR76KB1BBBiufIq5v3hsGMdeZ/Y5nuYT6+OJr9AObn99iu+A+ibpeIfrVVUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG/UGMNuyOM80nWPcpVlzRJdR5Vwp4QxWzL2rRuXVwQ=;
 b=m+lPNZIN1BPs4G09UiKhGP0uCkPdKwlGGMKrPxgHLvu1COY2na9yarDGRC7oG8L0i2pnXpH33tbzw79C6T3dI510rxI3LcwTcNQiQUC5DB6D1NOi6ZhTUbL8VRTKwvqUmAG1BWaQT7fDRvbAKgKS2hNNiFV9LkFzhkpSn2zmMdSLFlByGCVm4niPomG7bjQBbRknpltS5d1goma5mXUzykJjvfyVqEnq9eiIPw73c0oO3GYHwaCegoiAzSON9THegcaoplHW4i3MM/U4JuJ2xBStE1ZMo+2SHUGcr/4jScqjkGouLB4wiaqd+/O5oBGU6IYdFnZL5OQOE3H2UJlI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG/UGMNuyOM80nWPcpVlzRJdR5Vwp4QxWzL2rRuXVwQ=;
 b=Aw8Mf46PLc5yjAAT7cVR1YZQxcyapb3AiIUI4Ihuwh6CnInaAuIoEFqGxqG/3eM0Kxe+vrg/3ogMyPNC2rk86E2wN1q71RY/Tz15DUbugwsPxUobXJKOSqknFLNWXKB2EL8SD7694MwKRProMJwW8ncyPzOoo7pWX/ixxXNHUnk=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:01 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:01 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 07/16] wilc1000: add wilc_wfi_cfgoperations.h
Thread-Topic: [PATCH v2 07/16] wilc1000: add wilc_wfi_cfgoperations.h
Thread-Index: AQHVOFVgM4bxEMw1IEGy4wV3FaGQpw==
Date:   Fri, 12 Jul 2019 01:59:01 +0000
Message-ID: <1562896697-8002-8-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 6232cc71-abc7-4cfd-e5ca-08d7066c826d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB1425B078FC64D3C4DEED77DBE3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xGbix1v4FQWyzZI0mDWT6TNaPQ2U8wJz6fUnehKux7cvbygy/gRHyFsyfeekO7pLHOwP964Tz/U2HOUjEwwpwAegln/SCqYeq5ZKmzAhPlo1LArbKLvvWo2P90pVKojccaSLKFB2jPXm+8LYP2u9ck4v1x+nr9MzG9mE0d9bNm8qGEatrvg/fKTxKdub7XMmYQyABprWn9/zcCmn0iVXAO4KB2gBhL8PK7wnQAcuC30CysST7T/pKnaAbh/qtN//eD+MLM/nkpnG7qA+64SknAMDzkRmkFrhb6V5WUO8cJfeF9uNQoOT93Tq9RboS4rKp0rX294zFs4BTWr6Hf2AYbm2QQO3w3++cFXcOnSLIfo+Ox9a+l5SDyPbWbeLjnxeMItaAIo11IMwZ2Eqg3LXk5I85lAEOCdoN8qbARtaDIA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6232cc71-abc7-4cfd-e5ca-08d7066c826d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:01.2568
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

Moved '/driver/staging/wilc1000/wilc_wfi_cfgoperations.h' to
'drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../microchip/wilc1000/wilc_wfi_cfgoperations.h    | 27 ++++++++++++++++++=
++++
 1 file changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgope=
rations.h

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations=
.h b/drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations.h
new file mode 100644
index 0000000..234faaa
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef NM_WFI_CFGOPERATIONS
+#define NM_WFI_CFGOPERATIONS
+#include "wilc_wfi_netdevice.h"
+
+struct wiphy *wilc_cfg_alloc(void);
+int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type=
,
+		       const struct wilc_hif_func *ops);
+struct wilc *wilc_create_wiphy(struct device *dev);
+void wilc_deinit_host_int(struct net_device *net);
+int wilc_init_host_int(struct net_device *net);
+void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size);
+struct wilc_vif *wilc_netdev_interface(struct wilc *wl, const char *name,
+				       enum nl80211_iftype type);
+void wilc_wfi_deinit_mon_interface(struct wilc *wl, bool rtnl_locked);
+struct net_device *wilc_wfi_init_mon_interface(struct wilc *wl,
+					       const char *name,
+					       struct net_device *real_dev);
+void wilc_mgmt_frame_register(struct wiphy *wiphy, struct wireless_dev *wd=
ev,
+			      u16 frame_type, bool reg);
+struct wilc_vif *wilc_get_interface(struct wilc *wl);
+#endif
--=20
2.7.4

