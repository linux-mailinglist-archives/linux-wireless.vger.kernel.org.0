Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1880C195126
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0GdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:16 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49528 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgC0GdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:15 -0400
IronPort-SDR: Ixazq9udi/5O6sxSfWGsktiFpvf/AhkmJ/a3eFNJPjwNjOlkNlClfIggSTt6z8638mgXxXQVRD
 M0pQA779BPNzeJ4BRDavRIBj8gYVx5xJF1pi3ct04Gd4E3McAC8AqmEuntXMEQ7lW1Pg+XYAFV
 GR24QtGmblIZm/bvG5QeX8/E77rwPlYkRxEtfH41xxyxZAgZa7FrW1cKGYixKuM0dJc5lmEX3v
 lXjmorwtpL23+LBnWwE1gMq5w2jUEM7AICHKatVGw/X13Uq5cyK86GDKuzZbIe9aDj94klC2yJ
 UVA=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="70452357"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 23:33:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Daln3IJEa90w5rzCHaBcqkmk4sgT244CVSTctEwzkLChtcY7wwlwszdrUPSp01oTHHeoApaamM0l3o67xH82el62ED/YP93OHmGh+di+ipCgU3fN8sxecTbf4O7dUpuqUG6ttaU76NfacIbGdGZHjyVWOgCj3jkNQQDcl7vgsWHn9WfIcDJFYGtOkmCCtq+dpoKLyAW/xgYmoKFLmd/hUmWhQvV+4JOVhxd7s4f0F5p1KqnNn3CMvoYWBAxyMLFN06ST/4xCw8zUTt5ODf6vfayKeHhsoqY/rq3x3WFDou8PfrdzBwwR+YAYQIlABEimIcOlOEh89m1L1UAm3FlIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbxCkj5abFNCucs2nUZKiRYshSZA04f88nBzX9uxbqE=;
 b=iKHmMLvXlYKc+aezNRxr+WUeDnwTpXc9KawGiIiULdfdQOqWTmG+SzK57bCiOmjlxkXUSBGnkh+q/x+oh25IVZ+Un1gZ34c9EmiBxQXljP7xMtjEAnTnNuSarXQote2Scbt64/JfYodZUuhwV4NiBaeAOjdD65dM4lS67dMzQvbk2ZjWSyop/ZG6m3JecrtTLpxEfHZkKKTJprZoLu8/NfQHamSYinrswAfE2UTrBhkxiVgm02CgHKesXWvWInv7VyeevMPsSqfzZpKwm6j7W274ikjtJp7OZIVGlvjdTcIVzTNyQtbrNtTNF+nEQPZe+l8559SY+3+zgNJdxsT5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbxCkj5abFNCucs2nUZKiRYshSZA04f88nBzX9uxbqE=;
 b=eGmumKbx6hsX0udJsB/+3QjVMBLlC7bAIJm01274zrHea7ovScU9y2aZbmQkWR9TqWHYskBZXk2OmPQuTVWgvJhhv2v/ee1xJ8RDhXx3pcB2BpouCFqr6G7rAwhZ4Dqu1YsHnGMq0jv/Cenrp3vjV4qRIBU3I8wtW/f5p/MBez8=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:13 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:13 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 07/17] wilc1000: add cfg80211.h
Thread-Topic: [PATCH v6 07/17] wilc1000: add cfg80211.h
Thread-Index: AQHWBAGX9bZI6uyByEyCiII/Il0ciQ==
Date:   Fri, 27 Mar 2020 06:33:13 +0000
Message-ID: <20200327063302.20511-8-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 7831e4cf-5bd2-4d3a-558f-08d7d218b9e4
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33971E720FF7C15F05856929E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5C1oOFkZ8CHa+AjuMbk/gXLXYG1VHM78ceMZy9TlVnTx1IYayU0PFImnVFMXHA1xcj+KaW9lqRLXNXDSBKWARWhuMcKDIGSbN1vZ1kamRh0UHSpV5SM7+2lFZtT12O85KU3eo4+IndrOE/ahnL/uETQlTk31u28txN4H2ZbqyVmMu6hHlac+3gcW4tQlAEg3UDP5V/G4oiQst6/sR70zFMo1xs0lRICy/VYhBQwwXg/baCFTKgcD/tBl3OsWzJ1fHYzebmf/zAB1XegjyXkiT3oF6lqyZaDWVPa3IZITK8K6qnE4NoTGqYcffHhT43RAIgmbSPQsgaWcjtc3z/vsiAuwRwPm/jhTvi4HeiPotBtFS8WRitzdMA+5ZDtUfk0IcfDsYfHLQGmuvhFrM+oPP7ShxlIcegrE8b5tVI4jE1RhFFb73iidgBjzUIVF/csJ
x-ms-exchange-antispam-messagedata: T15HeAlxPVGrSwaNaxLzaabVm/2WGSF/7oy32LnyXrdNF/DF0VuPItLVmzgDU6wdsqvxahTrjsiPCs+kPPfT159+uXTdtMNmkebwd8WuP7Q8KWVR9f6TqqFVBKVvL0NwXBaSq/4EvKrxXgGr34PXug==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7831e4cf-5bd2-4d3a-558f-08d7d218b9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:13.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wy1guuazaA5GjMjosqTkN3csKkU8neWfj+dzqhF3wVobtQItdlL+ePcJIl3J5FnU8YsZ6JU4sFgQdur8Ve2G+oAKtiHSxm3Hi24U8ZvHpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
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
