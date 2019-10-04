Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53279CC4F1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfJDVkc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 17:40:32 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:16439 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJDVkc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 17:40:32 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ix5zck2JR0n2dqmQ2DXzGYuTuRhR+woEfu0rbtr3qpJVs3bP9gFR6cCy0N3ko9gKO+2fl9uTI6
 0Cu+LsScG7It9PQX/0THFnIec/YeuZ/403uOZHDTgCcvYj5XMIfCMEfHhQ3agWamEF4/jiCJum
 zBvcC4rT33/nD01f6314bVKHaIcDzRKIeREmJPW0ySbdAWT0kZ7Msfbh8vI7/401I6HArtxzbo
 eA6YRIJRMHvvtikhgoyZ71OBrKFtCmxjJ9Ed3ZGr+pYgJJwfqw5PrujHgpZAlrFexsEX2hR9jC
 +AA=
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="50260563"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2019 14:40:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Oct 2019 14:40:24 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 4 Oct 2019 14:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUFC0yaHE/bm0oHNWJcvSSwzUq+w9IX0h8YJhqGAmdOkQ0RKdGPZAgt6C7CPBHaxW4KrbzFzaMulsXudIUEdToLAB0aBzUyiYq6Ny/EZRFCok7bJZaS6lfUD1ONijlTFrY3PXkcTBZ6J5U5s4CglZuUQb7TbgQl+J8/LJLiOARlXgB6zGeGs5pOUhIEl++Lfe2i33A1kLbOKQies/4jcvCiWN+UbjpyP5ZX8s1Nk2/2HgXN8lGTql+wes7ppt7FtxQO8wpcQdLs8WGoR2rIq3CbCBC/s5mUCfJ4kqdJlavkgVo0VtyytD9wYg/PZ0ItUJ5hAi2A/1p/pUZQPZ8Iwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQQz62L/WkKoDMpk6+3WPWCmIs/VNeltumtvhyu8o0=;
 b=a5v/Ea5NDXbsCbLNlScs9W1lWgoxaQoM21Z5cxirTcyWw8zFPNITWk3HNcCWJPu5vKed/X1Zp3ELfqvKrugL2Wp2P7i4Nh5g2pjogvZ1TyNcnW5NvvLlRmV9aP440YF51AkVJQ/N5hDRRqwr3E6aFWapzqn30ONiHuuwyN6YLIBbcwwCU5oECt4gBzWcUrJsEwlLTNqMGBGi+7MNhPbd1F4it6vHrzW8dfAkmavfJ+AMKMxuuaMjtUGnpd5bTfRtl6Z5E51zYHL/x0zn0bMFxqkwGAXQ0FsMl4L01R09aw3QchtQgwHkWQfMxH+LShLwaY+zfgYJW1Vt30DHnSwNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQQz62L/WkKoDMpk6+3WPWCmIs/VNeltumtvhyu8o0=;
 b=rrZU7x35F+XRi5R2Xfkw+xs4+WNHJnhgtD+vYfKgi9+CkHTssi5weWyjCdmM6rRlp4rCzxSsJfPLtCIM2TcWJftnpact14LPL+h/DZPebaGc/8KJBrRq6RqOncgXwiQZXi2/GO6VugkSti0WijuZw6MjL3l//wENkvcHdvISQ9s=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1311.namprd11.prod.outlook.com (10.169.237.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 21:40:22 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20%12]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 21:40:22 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: don't use wdev while setting tx power
Thread-Topic: [PATCH] staging: wilc1000: don't use wdev while setting tx power
Thread-Index: AQHVevxTkXfcC9a39kuERO2U+5rK/Q==
Date:   Fri, 4 Oct 2019 21:40:22 +0000
Message-ID: <20191004214011.7623-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39)
 To MWHPR11MB1373.namprd11.prod.outlook.com (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fc5d446-d29b-43bb-290a-08d7491375b8
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1311C83ED14FE81E7E8B82898D9E0@MWHPR11MB1311.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(6506007)(36756003)(99286004)(2616005)(66066001)(71200400001)(2351001)(6436002)(6916009)(2501003)(107886003)(25786009)(86362001)(7736002)(386003)(50226002)(305945005)(256004)(4326008)(476003)(14444005)(486006)(71190400001)(186003)(26005)(14454004)(478600001)(102836004)(64756008)(1076003)(6486002)(66946007)(8936002)(66446008)(81166006)(3846002)(6116002)(316002)(5660300002)(66556008)(52116002)(66476007)(2906002)(8676002)(54906003)(81156014)(5640700003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1311;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BaJXJcVOkfO6m6jMUSmjIFluBwObsS+F0ZvdnWXFAqjMvDhIYEgjYvld0BPIeQmwC886FAIXdigxHfAg9YXOqtp62700zYwpTVneQgyd3nn6h9yDC4AMQ+hJ7h6lP4ZJpcA2qvdrG0jYF9NRWmnEKkxK9cot3xb+RrdudVkQYcehAq8WuJk2aqUUXhRO6GYnOfEDOtEI84xyxLBPK8x8gXskLo/cfnS5WGWNt+4Od2de321xUucX3KzR3biY7rXXD1Bg0qNlqlkhgnbNgYrtyKf900hjQuvGqjHDbwZmmMWTxBbMIF5cMRS2aV0m9U2TWpCMwHPf9zTzbelWqCG24bdcY4lZLt2qjORfKkYd7TPT1iQ9wgHL/YHSnGc0Q2Aj6BpeMDfvNVEIJRzk6rccQGRa6n2vTqj+rqQe4wAFEw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5d446-d29b-43bb-290a-08d7491375b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 21:40:22.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tm+LIffZScZRbCdJLXArIrFwBP0Sa9B0vYPELFCWjnA7sC9Fuqeoi4I/KJqE7DrfVzP2H/MXFKsew157ZH5JLwB9DMDUNmooZGkP9jDvY7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

WILC doesn't support per-vif tx power, and hence, wdev will always be
null in calls to set_tx_power.
Instead, wiphy should be used to execute the operation

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 .../staging/wilc1000/wilc_wfi_cfgoperations.c    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index 3882c90dc3fb..cc56abc2fe37 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1685,9 +1685,22 @@ static int set_tx_power(struct wiphy *wiphy, struct =
wireless_dev *wdev,
 			enum nl80211_tx_power_setting type, int mbm)
 {
 	int ret;
+	int srcu_idx;
 	s32 tx_power =3D MBM_TO_DBM(mbm);
-	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif;
=20
+	if (!wl->initialized)
+		return -EIO;
+
+	srcu_idx =3D srcu_read_lock(&wl->srcu);
+	vif =3D wilc_get_wl_to_vif(wl);
+	if (IS_ERR(vif)) {
+		srcu_read_unlock(&wl->srcu, srcu_idx);
+		return -EINVAL;
+	}
+
+	netdev_info(vif->ndev, "Setting tx power %d\n", tx_power);
 	if (tx_power < 0)
 		tx_power =3D 0;
 	else if (tx_power > 18)
@@ -1695,6 +1708,7 @@ static int set_tx_power(struct wiphy *wiphy, struct w=
ireless_dev *wdev,
 	ret =3D wilc_set_tx_power(vif, tx_power);
 	if (ret)
 		netdev_err(vif->ndev, "Failed to set tx power\n");
+	srcu_read_unlock(&wl->srcu, srcu_idx);
=20
 	return ret;
 }
--=20
2.17.1

