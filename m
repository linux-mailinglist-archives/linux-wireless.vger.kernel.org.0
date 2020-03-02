Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C95175FD7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCBQem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:34:42 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42797 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBQel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:34:41 -0500
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
IronPort-SDR: xvBBwmd4CeHMpB0AZq55Vh/UlaoYifk5bkBpVriqLSpJ7xJiPJxJ4r9XUliVDS5YwXdUqjIN5k
 qJ2ITOYsN7fWPmkzuvQIMtqODejoc+bPcrWgap+py4/Q4KACEolXL5uYN8ix7YrdfxDNgjJ8P7
 GbOH/qPwO7RjaejsNy+wUgJhricMqFfwx14JdjOHYe3u18Sh4slIrG8gAoPqO5NJpL+0Zo93vn
 Ul1kIUlzTbmd4h6qsAEFsXCHDYo6ftmSuJwzo40XrYRJigK5axjMoe1udmZYJ6FwSBUc4S/iCv
 HYI=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="68544153"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGJBBu35Cg6nvfdGZT/OOBWiviwT/m+FqP9HZjhoxgcRpXUaPp08fva7n8PZif/vNph9k8WBgXBvj/fcldx4WN+zcniH8tzRRp4EJSogw6vIqRAD6Wj0KGptslAYDLMRPEUypadRkcQb1Gd3Kf1sZrDn7gd5+v7SGnkkPG3hYEVp5O9u0gs6mG9zJvpcZl/nhW59xUw1d0xCDGIaEDueMst5y2gUKsCXwQt0S5lG4jly15EfmyqB7hJunS6M7h90o1MorJnosVUgNwiHhITrWHoXQiTlnQRvwv0rcFF8c/XkPLRwNovUwl2PiC9NeBUoNe/ajosFn/Wlks+lx65vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbxCkj5abFNCucs2nUZKiRYshSZA04f88nBzX9uxbqE=;
 b=b7oWJ14SDY89613i/YFT+cF/x8f7vObwNfB+ovzVuo8x/d3sXlG2f5pREZ3enCrtD0ltIf+Lr0Z2rvJWecl9SsVBH4eydcXzkRJ5BombgNNMzUgw6OcLex+7SNHGwUT2c6jr1TxQa4iAxiltNRD3jxzwWgdqotPQiqCNmLMXY+kTQlNjAJ64cTo2Pd0cpnM2hCdspW/COYftr2d9W7ybrgl2Gcp0dU/hbuhEdnm33GKWgosKixD8aqHAmp4D38kJz9jB8t25Ua5yBZJ7hTrJBfqAuHn9Ze8GJlm17vY0XGcneCSSmsWvF2gaD+BWpdSgvQESISDsQ56QnHIHItHirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbxCkj5abFNCucs2nUZKiRYshSZA04f88nBzX9uxbqE=;
 b=GcYJ65TpmEwmJ4F0UDiCwt1Cvshu4LQyLeAgeHMToYBjy6UKtOuzfw75tzhetsbX5g/uW7my2IvflMeeoV5iNN47n37RzK7FyxfPuLorLL89f+u2EU0xTIcQQ4jW5O0D9CLy/jxJ09QJN0MJTzf8bik9I1H3Tl250xf3AdpsdT8=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:34 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:34 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 07/18] wilc1000: add cfg80211.h
Thread-Topic: [PATCH v4 07/18] wilc1000: add cfg80211.h
Thread-Index: AQHV8LB053gFLTjDgEyxwAX2B+lf8A==
Date:   Mon, 2 Mar 2020 16:34:34 +0000
Message-ID: <20200302163414.4342-8-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70013e2d-f13e-4bf9-5f72-08d7bec7978d
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4098BF485EEE1DE9193B1382E3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1RNK2q7Qlp0dgPr/1vf7L9obHyMrlxs1e8aPFDm1JHw0Z1qQ3jB8rIslIAMOIO7i7c/OQvfh4hQKcVS6dmPuZjkTLE7+Sz8omkLuBAbRw1N6EZxPt9QSMWP8F4LjWKkNC3aNob57Yy3DqG79Fa9HSYHq5szPKkrtfZ4yf9Reqs200zh4mhru/0mixC2LGV/uS4xLxNc8UOC8Pn+Uy+OVbRgYYkBT7t/4u3824u0Aa23/f8JQ+ZCTdTibagx83FsW5Q/iS5sQxEqCboMgxNZSTH8/0AtG2T9ngN7V6ddN4w/Z6H5IjeXjZvjf0gmzPtyV44BVUhieUkibiynoSoWhuEgoXEtFPRdprB5jAzWzELtoV0+6s+kgvh2f6UawiEg6G630KfkoCnPEhnYYVlUFBnnNZO62+wHrO5jgPFz6l+upo0ll0uhwwNGTKuTKB/8q
x-ms-exchange-antispam-messagedata: DILmJVavatZ8KeLc0WQ+p5ZS9Nyn6zGlF7znko7/S2uxnSIAEZBjac8QlUzBrAPW6PNEyXQysjb89hJuLGTLm83xythrcyQoGwWXZ+j8xPTwR9YKU0jTK+dlsoiF13mUDdWs7PpWtvAo9icAYZ09Qw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70013e2d-f13e-4bf9-5f72-08d7bec7978d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:34.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y49WEYxxpYbicIP/YdaKZaahHTYd/wCzRg6OrbayeRPI9Zs3ZbnbVMMW7GjOkw15jy1vNpCQZgwsBWdchGdoU/wjVC1gWyCe4xvyjxyXdjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
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
