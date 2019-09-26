Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA76BF5A7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfIZPPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 11:15:00 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:41096 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfIZPPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 11:15:00 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: xrvtcmV5L0v9IE0mDujeSUlgvnHpoSXplMeXtGjaXNGOdxZeVE+eID0ni/mDhTUbn8Q/EMla/C
 JWsUlGhCL5L3N7RA3WILmiQ/jggsT2GjfDVoH/aTOg5IWFZeBwU6zNYkt3apCv7bG9Fb/v1O8G
 mue6DGR0YjFVvg0jrLOBNs2MYb2u05zWKNP3Q7x1xXWEROnYR40BHO6sIY+enOSvGBXCH0kAne
 z50Q30Lxxt9/4PeUJrA0Gmaq3vqRVCJx5wCPo4sCDmlSsQBL4F8+2MAWeafEgHk/oYreHmM5Fy
 q4I=
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="50692220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2019 08:14:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Sep 2019 08:14:58 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 26 Sep 2019 08:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9Ot0TarenazcIrnUfdbwPpohCNdnzzbFS2MdW3aGgF4D27Wr/ScG971xHOdZDROhqbbTrPiHiMFTZGSXXUKxZNsyQvvpxMUKnKjacxhvVqhBCqvRdrh0Ieu2QvMPXVJ7nz2dxhETN6MK1JW76hsgu8TfV2l0bDUHuk6J3d5QaaPYblgYasyCj3v7H8We0u5dA0U8h3lOR+t/nkCaSWOzySIJ2N88ed0m5spggOgPZpKrnF7uS/T0OFpGzIdnndXZt7ieGPPdXXr6G5ijJ10jJYbQf286BU0x3339PeNWOyZFjfLp/m/isY7pNnZaopKVybLVzdLWxd62/ld/S1ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gdbbEeJfO2Mz1DOLmPDmtqC/UoNvnkUY1rG0fPGQB8=;
 b=Xb4p4vVXE9Fa+S3dr+0KvbrL65oREhwtv0kVV/9IxVgb9D9/1+k859CbkpWSfhd2MnSP+07+8uPVjFSQNkaFRdrb3pa/pwCw5R++RUu/S4ghGIPqMWnOIJA4y4EotwMrdHag9ZYH/6t20fq7HWvfKxSgu2fPn1cdvf1FhZuvuPk3JCqOpR7jps047umAqFNv54MYgRthx+86/4BdHln0qUzl0QE5zj1Dnhwznp8wF/iRQ5b548ALcANtGZgfJx2belr7NdZnbwlxa/FqpLBZY4J86R0SzmLTv+xo/oV6kMYz3mUpaP8GOG7weGsLgAqM/C7vvRlfrh1v1CbfGZr67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gdbbEeJfO2Mz1DOLmPDmtqC/UoNvnkUY1rG0fPGQB8=;
 b=jS1IqjOQv3MIt+k1/EAt8eVXp6H4+LjtiGNep+bPEMLp64OJw1NVa7aiAvRl2XCHS6Kq6K9c3CSkyVnCZL7IdjHqJW0FFmqGx7cx+TS9i4k2H36o7vfTA11qfbwwi6Mjoq45dKWGjql2tvNtaBZRaIOYAurUdEk8RWxiG0YA4Ms=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1860.namprd11.prod.outlook.com (10.175.99.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 15:14:57 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::8d48:6075:7cc9:7d43]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::8d48:6075:7cc9:7d43%6]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 15:14:57 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/3] staging: wilc1000: move wlan_deinit_locks() in
 wilc_netdev_cleanup()
Thread-Topic: [PATCH 2/3] staging: wilc1000: move wlan_deinit_locks() in
 wilc_netdev_cleanup()
Thread-Index: AQHVdH0otF1e+/X00EeWQj23bMMGHQ==
Date:   Thu, 26 Sep 2019 15:14:56 +0000
Message-ID: <20190926151436.27819-2-ajay.kathat@microchip.com>
References: <20190926151436.27819-1-ajay.kathat@microchip.com>
In-Reply-To: <20190926151436.27819-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::31) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.19.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fe6bc85-e230-44b1-203d-08d742944a70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR11MB1860;
x-ms-traffictypediagnostic: BN6PR11MB1860:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB18607B9433BBBBEEE05104C5E3860@BN6PR11MB1860.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:233;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(476003)(71200400001)(5660300002)(316002)(99286004)(186003)(2351001)(26005)(1076003)(66476007)(66946007)(6506007)(14454004)(66556008)(2501003)(86362001)(478600001)(102836004)(76176011)(66446008)(52116002)(64756008)(2906002)(386003)(36756003)(50226002)(81166006)(6436002)(6116002)(3846002)(4326008)(8936002)(25786009)(486006)(305945005)(7736002)(66066001)(8676002)(5640700003)(6512007)(81156014)(107886003)(6916009)(256004)(6486002)(14444005)(2616005)(71190400001)(54906003)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1860;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ix3aqomGwCMao/fGEqzGddTQ7gRiHj/U2/Hk62ZHS6PBgSEP18if9p6lrFgcfy7pZ/PjMNZ81VfjzK2+0rjmv4NmQwpznxmryXrBTadUz66VtHGm3C4mCXEv+HrhECmsQQu7kmUGZNrPUKFwkL5Z63QXj84K/okZq47HcJ+E/3cjQ64AyN3lmZ+wHrAMZAx6GmGvI1GDhw3mT36atfVc4a8Fqm859p+X4XGIK3LBFVAaDjD/MMsiM+8RnhaZTEHnZtJHVsYA9cdQiB+pkkW0oNYiSco0JAgUb8zDwGZ+Du2gVOhVXhEuwQch9BhuMHIWhbAQSptsxpm/UGxLBQv+LwVTSQlibrl1K9ojd8IevSdEgU9Zq7p56Fzor3BLfXlGBbFaA5XZLIegn7UheiMmBEnVMZtfjG39sjc8iTuHVw8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe6bc85-e230-44b1-203d-08d742944a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 15:14:56.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+qAcXIjfhlIT/f4s456XrqFpzuSFj/yOk8cFq/7ZMIrIIYXVrt1/VYCxt2Z/ya2SU4ndFbJEhnqCmmTKmPyhtL2lme3t3UfdcG2/+7BOo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1860
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Move deinitialization of lock during the module remove and the
initialization of lock wilc_cfg80211_init(). This to ensure locks are
available during module load and gets free during unload.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wilc_netdev.c            | 14 +-------------
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 14 ++++++++++++--
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.h |  1 +
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1=
000/wilc_netdev.c
index 508acb8bb089..d931fb2b2745 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -424,18 +424,6 @@ static int wilc_init_fw_config(struct net_device *dev,=
 struct wilc_vif *vif)
 	return -1;
 }
=20
-static void wlan_deinit_locks(struct net_device *dev)
-{
-	struct wilc_vif *vif =3D netdev_priv(dev);
-	struct wilc *wilc =3D vif->wilc;
-
-	mutex_destroy(&wilc->hif_cs);
-	mutex_destroy(&wilc->rxq_cs);
-	mutex_destroy(&wilc->cfg_cmd_lock);
-	mutex_destroy(&wilc->txq_add_to_head_cs);
-	mutex_destroy(&wilc->vif_mutex);
-}
-
 static void wlan_deinitialize_threads(struct net_device *dev)
 {
 	struct wilc_vif *vif =3D netdev_priv(dev);
@@ -477,7 +465,6 @@ static void wilc_wlan_deinitialize(struct net_device *d=
ev)
=20
 		wilc_wlan_stop(wl, vif);
 		wilc_wlan_cleanup(dev);
-		wlan_deinit_locks(dev);
=20
 		wl->initialized =3D false;
=20
@@ -875,6 +862,7 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 	flush_workqueue(wilc->hif_workqueue);
 	destroy_workqueue(wilc->hif_workqueue);
 	wilc_wlan_cfg_deinit(wilc);
+	wlan_deinit_locks(wilc);
 	kfree(wilc->bus_data);
 	wiphy_unregister(wilc->wiphy);
 	wiphy_free(wilc->wiphy);
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index a1ca700e045a..549b1d078198 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1802,6 +1802,15 @@ static void wlan_init_locks(struct wilc *wl)
 	init_completion(&wl->txq_thread_started);
 }
=20
+void wlan_deinit_locks(struct wilc *wilc)
+{
+	mutex_destroy(&wilc->hif_cs);
+	mutex_destroy(&wilc->rxq_cs);
+	mutex_destroy(&wilc->cfg_cmd_lock);
+	mutex_destroy(&wilc->txq_add_to_head_cs);
+	mutex_destroy(&wilc->vif_mutex);
+}
+
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type=
,
 		       const struct wilc_hif_func *ops)
 {
@@ -1813,6 +1822,8 @@ int wilc_cfg80211_init(struct wilc **wilc, struct dev=
ice *dev, int io_type,
 	if (!wl)
 		return -EINVAL;
=20
+	wlan_init_locks(wl);
+
 	ret =3D wilc_wlan_cfg_init(wl);
 	if (ret)
 		goto free_wl;
@@ -1836,8 +1847,6 @@ int wilc_cfg80211_init(struct wilc **wilc, struct dev=
ice *dev, int io_type,
 		goto free_hq;
 	}
=20
-	wlan_init_locks(wl);
-
 	return 0;
=20
 free_hq:
@@ -1847,6 +1856,7 @@ int wilc_cfg80211_init(struct wilc **wilc, struct dev=
ice *dev, int io_type,
 	wilc_wlan_cfg_deinit(wl);
=20
 free_wl:
+	wlan_deinit_locks(wl);
 	wiphy_unregister(wl->wiphy);
 	wiphy_free(wl->wiphy);
 	return ret;
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.h b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.h
index 234faaabdb82..d802f884e525 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.h
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.h
@@ -24,4 +24,5 @@ struct net_device *wilc_wfi_init_mon_interface(struct wil=
c *wl,
 void wilc_mgmt_frame_register(struct wiphy *wiphy, struct wireless_dev *wd=
ev,
 			      u16 frame_type, bool reg);
 struct wilc_vif *wilc_get_interface(struct wilc *wl);
+void wlan_deinit_locks(struct wilc *wilc);
 #endif
--=20
2.22.0

