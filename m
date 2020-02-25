Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5C16BAF9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgBYHlS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:18 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53447 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgBYHlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:17 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: fwRH4H6A6OS8I4ZJBZhJoK8SDjFvPZ4cTGkh2altVbrtG1nwPILMS2n+qOt69KyRCo9LbFTGu9
 t8lzWGhIghvkJjN0V2vhOcPxN9/srQXWKpwkqlowLpolaVlw5uxnxljsh6367IF3o/AoGBhVSJ
 rZrH3yW8VN8SBXzmEuNLc1oBnPIRDKWOYFwGyGyPmP+BlG9G9HHRAKsrD0Hv0bOrFg5tSQkoxl
 b55z0dtGPT2oMWFcucawGkEQVn01a4QVLu1XudIyLc907Sj1HlVlNoaEIGnnwRryVTWHhekdYS
 ZIg=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="66951686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 00:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFgJe1qsMND5YJdPY616j8NM7fyTKHE5MW91BHw9BDIp0DR6NJ93z5QBs1lPa8fAP7NPja8RqLv/cVc0U7lwe8doLKiLxi8n21LOMYaVLRqjpjnK9vlbOuEZnc1P3CHHW5IDjnO6Gu/UTlFag9I3PenpYVAC0nqY1iSP86WZzzU7jfbx0wJj4HIq8dgTyGnW7laWiHg7kw+EmEZfGDs3o1fPgjFd+4rzRsFXuxuQCTQkqMHSpPqxCDYwvbTbBfsdXg8XLB8ZdyEm5eTUaWcPz8JJn6TncbUl6X3yq+WTZKI4zEonXTywTYVZj9xt+XCqttQNYmXe74DwJd/yeemjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbxCkj5abFNCucs2nUZKiRYshSZA04f88nBzX9uxbqE=;
 b=c3LOCfCzn4kFDOnEoDb3k2C2Mtzah4NLS9wx6zYAxz6zi6M4+P9icSA6+J9HhU01oNtvgdNgMv8zvNfN0PKKhPezuNnAeWqtNY52wNoWqwmqqrL2N1t1K9WBu8tYSOHgAEm4jDLv9eIGDZsjXp4phlN+2x795C3aHUibb7k3dcIRH86Hiel0vUxJneKGYPY8xBwB8H7t/vtTW90dWF3kVJ3s/TKtuWzjuPIQw88Bqy+Z3qNw/zvIu8y3fQiXWOcweCUF8HTix6Zgd3Mxliep2PxJ97pbJHSasveuLEGDn9XCMIZ1xBK5FDgD1/+IzGQ8INeZTvDnot/E8vLrOv0WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbxCkj5abFNCucs2nUZKiRYshSZA04f88nBzX9uxbqE=;
 b=Qtp7AhRas7tiSNa+uyU9nj4BNHmVTifhVtpljpudocJcxJwQYzhxSm/fi6l6/jM79b3L8OUEz+0y1WFWf7qy0biR6LMexBGOJD5b/+jNWjOa5EPhQw9kV3yZOSvcVc9p5xLbs82F7l26AP+7glVc3Tf6oiV1Ab/lYqpXLIaBZUY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 07:41:14 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:14 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 07/18] wilc1000: add cfg80211.h
Thread-Topic: [PATCH v3 07/18] wilc1000: add cfg80211.h
Thread-Index: AQHV6670qbafgp6CzUy6elI7wYT/NA==
Date:   Tue, 25 Feb 2020 07:41:14 +0000
Message-ID: <20200225074105.7740-8-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7409b4a0-5fcf-4e84-d8fc-08d7b9c61788
x-ms-traffictypediagnostic: BN6PR11MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1875C3E695EBA7C355C6D302E3ED0@BN6PR11MB1875.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(2906002)(316002)(2616005)(54906003)(86362001)(1076003)(66556008)(76116006)(66476007)(66946007)(91956017)(64756008)(36756003)(66446008)(186003)(8936002)(26005)(81156014)(478600001)(6512007)(5660300002)(71200400001)(4326008)(81166006)(107886003)(6916009)(8676002)(6506007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1875;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSW2kOSSoaIEQ32X3Q1okFA0pFWp2JTsQfPPmkKQrM3Mb2Rcjc23UNDj2uO87gn6N+JcSLo/a/kSEPzCv+rwhFKg4/hx+7NHc2pCAmO2C78UvvvUzAPfW1hSTHbizbiEoEhGMulnEYxXB7USYVUe3DsNKBHr93A5Jk7maNXaWV+PMvlVw/eUDg3vvS/2llZ45ZGx0g5wzocDpGyLjlwXMkzo30Vf8K1mgNVbU2ifTN7NbDy05jKpXeuMMPsKyrAbr/P6eBipfEULvOqOGg0444BZ3CDGLMdS6MkZU8D3qc8D/Yon2ShyBTHIVq1XpaxAKektTXHjxB4UFFLdsBt03H/xzQVsJDmU/F+sC3rN+N1h/2dK1HWJTz0ordwyeHkQvovqb0V4FcZu7y1msc98jaRwpoRzJFAlpFD7+eZ5FA7uhLHYe2vXWY1SsBOEso29
x-ms-exchange-antispam-messagedata: OGhgJLw3Lhk7RR3PG8yUE/NpiGEadGC297WW6oZNkv6VZ3ERegLsdL6YfXCsNkohR1Glvo3NdTOqNIJO+0NdVUeiftR9lI0nxd2sx+/MpUU9pveqonBB7Dr3N7ewCxIvynlqeO5rpZPjgB/LEAG6xg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7409b4a0-5fcf-4e84-d8fc-08d7b9c61788
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:14.3913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xjyf3wPOqO/VaBTaLKzJYDZEjEPEXLVHSSc8ATN7Oo0zMONSJuIwUj9QTzkgEOdDzYZHEnD6CV3CR4yPn/1HocbVBYxA8t2bUP/WCzk0MQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1875
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/cfg80211.h' to
'drivers/net/wireless/microchip/wilc1000/cfg80211.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.h    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/cfg80211.h

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.h b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.h
new file mode 100644
index 000000000000..5e5d63f70df2
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_CFG80211_H
+#define WILC_CFG80211_H
+#include "netdev.h"
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
+struct wilc_vif *wilc_get_wl_to_vif(struct wilc *wl);
+void wlan_deinit_locks(struct wilc *wilc);
+#endif
--=20
2.24.0
