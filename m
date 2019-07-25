Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE14759A9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGYVbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:31:37 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33037 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfGYVbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:36 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 5bjQweDBhsocOYUPZYdFQNykH07wcs54gS6gsTQ/oteK66mQWBfZSF3DjMVuWUMy9RwTkK2xRg
 SlacBWkZ7/CTQAJ/XIx0A82YntMf02mUOPVfvClSO4AYEuo5nLPEAHoyJDeuLtaNcaE+4W4hrx
 NXaD10bwk6XqLpwoZLGtgky5TCCUhAYzPpAxAtORUnRTwDOOaH1/UeCRjxEoPl9jczcQ7BYf+r
 YRb2t65zqSJTIlDVKBMEcFNZFObsUlTONbcCAoMwaRPze7ZV2UQA64LWk1Pa6lCAFAYVI5IeAb
 Fzs=
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="44200122"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 14:31:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 14:31:35 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 14:31:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpS8UlLRQdSEWgfQi8P2S00Kv+X1GvSwrK+GZCA/fXiHTd9pqUMx3H9YH/oP3XkfWHuiFW3fo0RRFG3zNhbZ3xCaO+/RULDGJxgBjxB0e5alVmh8jNaW77QGDvqdnTvA8/sngvF5XY0jnfjwJZgEvNDv0AHS1uLoNZGluOwJO7c7utzZ0qwIdB+3mCgsZAcMWOp4lIbiN8sNfW+E5mujadbNzck3YG8s3GK+4TwHzX2GEl4jge5Lkht4OwexAfu182li1hjsuPAuPztnHbj7ef5jEG7IrpjePqt4URiePCC8YnSVwftMCsa2uswnAhDlN/UjWnAtvYcyJG1xiJgTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzcjPC/RMgzop2flOKh6Gk4eAY//7OsClvCTHWN/WQA=;
 b=XPBtQCQ2ap2hTlyqRHe+LQL/Gwx2k/9SphdEWH04venjJuURQotNeSt31pfbTwUErFwjAbsH4g9n0QLZXsU4SKOXuiakE1WNN/w928bbriPOhDr/nJYzzeQGQ9WRBPGHZ6tmr094df6kC8gQMH1EFL4hLwgQj5roxy8obwWT2Fz0YtKqae3SPh9c8zs2AeAfMBGkWt0377ZMHnVJCC+nhphsyvFOLnqYFt6DD9wa8zADCFLprLFlgazNzCyFTo4OtWzFk4sv9pxLW32VMjBiymfKt/cLpYPXp3YNLJk0D9qqOKg+c9/GLRXZJ1pKWYQky8jXGZsPJHb+7VJjwAzvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzcjPC/RMgzop2flOKh6Gk4eAY//7OsClvCTHWN/WQA=;
 b=O90IhoKtx0Vx73C9GGVffP6sSRw+IZa3S0audBS3vY0oVBhfVR40pGCaX5W0QEHBcsAf/CuvadYOJJtV9UimlSOQNPMu+LSk2Jpf6B2YcZ5rz5rRv2tTNVvuT7jWc0fDx0YbH8te7B8Po56G65dz8YTpZWZ+bF/Yg/ywp6FCc7M=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 21:31:33 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 21:31:33 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH 1/6] staging: wilc1000: remove inetaddr notifier
Thread-Topic: [PATCH 1/6] staging: wilc1000: remove inetaddr notifier
Thread-Index: AQHVQzBU0zTEWOi4RkieztXudbrD3A==
Date:   Thu, 25 Jul 2019 21:31:33 +0000
Message-ID: <20190725213125.2810-2-adham.abozaeid@microchip.com>
References: <20190725213125.2810-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190725213125.2810-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: MWHPR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:300:ee::26) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56101320-b9d6-4958-1a70-08d7114776af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984863B5862F1542AAE84668DC10@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(11346002)(2616005)(476003)(102836004)(386003)(446003)(486006)(6916009)(2351001)(6506007)(66946007)(186003)(99286004)(2501003)(76176011)(26005)(316002)(52116002)(5660300002)(66446008)(256004)(305945005)(6486002)(25786009)(64756008)(66556008)(66476007)(53936002)(1076003)(107886003)(71200400001)(86362001)(71190400001)(4326008)(14444005)(68736007)(478600001)(8936002)(6116002)(6512007)(14454004)(50226002)(8676002)(5640700003)(81166006)(81156014)(3846002)(2906002)(6436002)(66066001)(54906003)(7736002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hRMtkGFBdFGjppuTMwXE77ndFeil0TMfCugMTCpea68IBAjzNevgqICgsCSIiJWDViLs+oVrxJ5CVLCbY9jSwK40IBr+ZgS2rMGXLye/qi+Y6koFR/wp8rfB85FcOCwc4tDqZA0N18WJ/NtQtVZuMtTBjimBmm879UmnSce5qg34/psTiXpzTSo0awPumyZ/8aMp3CEePolIRRnIBCjgXiIHmtfv5AUEOG6L7R8JLK8BEbzKzbozpwE422JkwWU+C6fpz5ZLwBEvNIe/tkWhnyQjoPVaXLNv3iWPl5Z9pXTVBYwZAS4Zj3DOXVHZlHYmFedhocEIsdGGdlDaMEpy0A0tTNawL6i3EN8paOquFWRAu+k1oQVcEl2e7pzSjZQFp3mVX0xUF+UxsDopzaLT75l2GS6uCWwyqM7ZBIK/l5E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56101320-b9d6-4958-1a70-08d7114776af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:31:33.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

Driver registers an inetaddr notifier to disable powersave while the ip
address is being obtained which should be controlled only by cfg80211.

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_netdev.c | 65 --------------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1=
000/wilc_netdev.c
index 8d8b7e4399f7..68129a0ba55f 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -504,12 +504,6 @@ static int wlan_initialize_threads(struct net_device *=
dev)
 	return 0;
 }
=20
-static int dev_state_ev_handler(struct notifier_block *this,
-				unsigned long event, void *ptr);
-static struct notifier_block g_dev_notifier =3D {
-	.notifier_call =3D dev_state_ev_handler
-};
-
 static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *v=
if)
 {
 	int ret =3D 0;
@@ -575,7 +569,6 @@ static int wilc_wlan_initialize(struct net_device *dev,=
 struct wilc_vif *vif)
 			ret =3D -EIO;
 			goto fail_fw_start;
 		}
-		register_inetaddr_notifier(&g_dev_notifier);
 		wl->initialized =3D true;
 		return 0;
=20
@@ -781,7 +774,6 @@ static int wilc_mac_close(struct net_device *ndev)
 	if (wl->open_ifcs =3D=3D 0) {
 		netdev_dbg(ndev, "Deinitializing wilc1000\n");
 		wl->close =3D 1;
-		unregister_inetaddr_notifier(&g_dev_notifier);
 		wilc_wlan_deinitialize(ndev);
 	}
=20
@@ -864,63 +856,6 @@ static const struct net_device_ops wilc_netdev_ops =3D=
 {
 	.ndo_set_rx_mode  =3D wilc_set_multicast_list,
 };
=20
-static int dev_state_ev_handler(struct notifier_block *this,
-				unsigned long event, void *ptr)
-{
-	struct in_ifaddr *dev_iface =3D ptr;
-	struct wilc_priv *priv;
-	struct host_if_drv *hif_drv;
-	struct net_device *dev;
-	struct wilc_vif *vif;
-
-	if (!dev_iface || !dev_iface->ifa_dev || !dev_iface->ifa_dev->dev)
-		return NOTIFY_DONE;
-
-	dev  =3D (struct net_device *)dev_iface->ifa_dev->dev;
-	if (dev->netdev_ops !=3D &wilc_netdev_ops)
-		return NOTIFY_DONE;
-
-	if (!dev->ieee80211_ptr || !dev->ieee80211_ptr->wiphy)
-		return NOTIFY_DONE;
-
-	vif =3D netdev_priv(dev);
-	priv =3D &vif->priv;
-
-	hif_drv =3D (struct host_if_drv *)priv->hif_drv;
-
-	switch (event) {
-	case NETDEV_UP:
-		if (vif->iftype =3D=3D WILC_STATION_MODE ||
-		    vif->iftype =3D=3D WILC_CLIENT_MODE) {
-			hif_drv->ifc_up =3D 1;
-			vif->obtaining_ip =3D false;
-			del_timer(&vif->during_ip_timer);
-		}
-
-		if (vif->wilc->enable_ps)
-			wilc_set_power_mgmt(vif, 1, 0);
-
-		break;
-
-	case NETDEV_DOWN:
-		if (vif->iftype =3D=3D WILC_STATION_MODE ||
-		    vif->iftype =3D=3D WILC_CLIENT_MODE) {
-			hif_drv->ifc_up =3D 0;
-			vif->obtaining_ip =3D false;
-			wilc_set_power_mgmt(vif, 0, 0);
-		}
-
-		wilc_resolve_disconnect_aberration(vif);
-
-		break;
-
-	default:
-		break;
-	}
-
-	return NOTIFY_DONE;
-}
-
 void wilc_netdev_cleanup(struct wilc *wilc)
 {
 	int i;
--=20
2.17.1

