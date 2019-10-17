Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BACEDB2CF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440501AbfJQQvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 12:51:43 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14783 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394432AbfJQQvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 12:51:43 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: uvn7lLkC7e3dMkjYVusv3qRWEGTc7Oa4l6HOVoH8wibRWPr/55UucKr18m0rQmLu5ayis6fI+a
 n1xVG1WXz/EoocnrbE63PMcJ6chk1t5rFl9Wj1RNSsGARlFW5umMGMYZ1DUueyWPfO1q7R5Hw6
 vSMqQxlThH5mq6mg1TExs0pf6KeLXApwUgg3F7s9WHlPD9C0l9Ofod5NXPIVETlRTfeUfJrCA/
 N9IcBcZHfkMeyti5xtuQUSqCwnkIDsLWyEgnVINV/MHjo/Hzwp3o/6eOwevruIStqVK615wzdD
 lug=
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="50501594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Oct 2019 09:51:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 09:51:19 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Oct 2019 09:51:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL+VBPNwo63Ym1bqBApDsK6++NE32lP3/i9Yp7TNpxPdUgwkKcZ/oZk/XnqsXMhp15HTJsrejLPCo4yACftl7wMVitmZtSou6ONOOaDYDwCe83iMe2B4dymibcU00Rh6q+RkZOL4U5QCG2Hr/kQfVwoMXxHFaMv5FT8XxnZOFfwaNDM43fvQDzgFl2o19VF+DmJCt5RZAYzlqtslf1etxLDFA1HBcCRyTC/l87sG/Hiy5eCpVMKapbgv75nM+uxyxXLiSUSIqvGRFZp10etGLPiSb/SgS0W1nBB1ryfGB1Q3BKi7qLguTuyilKIVUCA4dbj8R1/7/wtUrX3shqR2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBgVcD9J+4PoSSL9VBltVWz2IhrllOh5gqW6P7Q99rw=;
 b=SESaM67+Kj+sor7aBpeV41/VHmYGgLRMVdZpDlDdtxNfzPyNuqLOZtcuztVdBcVdYq1Z/nzeqaYdlQVo62jjeATA69BUVhwhOZtBT0UUF5hMB6V29PvJhOIWH84FFyKZllooIT1HuVwIJcLGoowEez/peABjUmiWjMaqXe3oynwzyrwEaGXbSBoMATXfBq8aV9mF6n0mYaHXp+MFjbhB7DLZgG9xLXiFRv52f+0RnwTMkKOjZ8NtCde+7GpCTtcD34PyalsvFJy3mua9oJQNMr3Np4OO1LX5G9+ymzw6+i5p2Vm8oYri8t/YBAJ4AGKlJXTlU2hTIeSCNG+RIH5/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBgVcD9J+4PoSSL9VBltVWz2IhrllOh5gqW6P7Q99rw=;
 b=Ph43YWXMRcm5XsodjKknjdxYCkPVF1FmpDPcUVgeJC3WzhVvyCCOyViLoeCw0j4YugLpRs0IGWQgSvpX5iSvLObVISEUQGt6h01l1/3xi5N089RECoLVqxeTV0YlVaKMRszLM+cfnRzmpSrysXSERkBVus/aLlw6ocvEHT0rLpE=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1550.namprd11.prod.outlook.com (10.172.53.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 17 Oct 2019 16:51:13 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20%12]) with mapi id 15.20.2347.024; Thu, 17 Oct
 2019 16:51:13 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: store bss object and use
 cfg80211_connect_bss()
Thread-Topic: [PATCH] staging: wilc1000: store bss object and use
 cfg80211_connect_bss()
Thread-Index: AQHVhQsVMd2NT3C/iUqvOe3blPViIg==
Date:   Thu, 17 Oct 2019 16:51:13 +0000
Message-ID: <20191017165105.27429-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49432f3c-9cc7-4c28-39ae-08d75322383a
x-ms-traffictypediagnostic: MWHPR11MB1550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1550969C06A2111A25CF57E38D6D0@MWHPR11MB1550.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(81166006)(36756003)(3846002)(7736002)(486006)(86362001)(2616005)(2501003)(476003)(50226002)(1076003)(66066001)(14454004)(6916009)(8936002)(5660300002)(6116002)(316002)(8676002)(478600001)(81156014)(14444005)(54906003)(305945005)(2906002)(6512007)(25786009)(256004)(66446008)(107886003)(386003)(99286004)(52116002)(2351001)(6506007)(64756008)(66556008)(66476007)(66946007)(4326008)(26005)(186003)(71200400001)(71190400001)(6486002)(5640700003)(6436002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1550;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1X9CM9L23bqU2ZMxLwT8+ydnJg/fA8f896efmDgipG4yIFBidgsZvfKfRxD+TkVJZwSmXLKUAtiJQJ0IpXH39Oh3kOuVHYl2a8cVYn5XwckekZoeup89q68qX7QVnXvw+nwD43e6f41rcyzkecsg+QBGEiErijJzq4ZiZ3nPr31EB1LzKYFXAySNGyulNUO6zetx1ToVhYLuYX2YMjLbmmPDS2pBy0Gr0rIjllE9NzXvb/oSWNVZb2bdwokSRHxfX+o2jHh6BDy2CeKzyzEb6HTSRVJk046aQ8cR5KbiEC8iK2Mk5+uyXUmb5XlIl8dSgIDDikDpy3BVqW5uKTJH6urdY5dLnmusGQOsJARxLAC0SFH+DNyz51/ob8+4zdG3DdmQXSaAcMX4dEBXYHymyf+pTO5dl6jsofiBNQVC/qc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49432f3c-9cc7-4c28-39ae-08d75322383a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 16:51:13.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bG3fRbMTx+OV8RxBYw8epoQIpxSXw4dr7LjfHOE9cGW2tJJKx+4z+lDMNXCm/dsgMa1hiS18YW50ZwaW+vyRuBL615+MNvr4Fa9Uka1b8tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1550
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

In a fast disconnect/connect sequence, cfg80211_connect_result() can
fail to find the bss object which the driver is connecting to. Detailed
sequence of events:
* Driver is connected in STA mode
* Disconnect request arrives from user space. Driver disconnects and
  calls cfg80211_disconnected() which adds new event to the
  cfg80211_wq worker thread
* Connect request arrives from user space. cfg80211_connect() stores
  ssid/ssid_len and calls rdev_connect()
* __cfg80211_disconnected() runs in worker thread and zero
  wdev->ssid_len
* Connect succeeds. Driver calls cfg80211_connect_result() which fails
  to find the bss because wdev->ssid_len is zero

To overcome this, upon connect request, store the bss object in the
driver and upon connect completion pass it to kernel using
cfg80211_connect_bss().

Ref: bcdd49b074d0 ("store bss object and use cfg80211_connect_bss()")

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 .../staging/wilc1000/wilc_wfi_cfgoperations.c | 20 +++++++++++++------
 drivers/staging/wilc1000/wilc_wfi_netdevice.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index cc56abc2fe37..6422f6f5eadb 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -137,6 +137,7 @@ static void cfg_connect_result(enum conn_event conn_dis=
conn_evt, u8 mac_status,
 	struct wilc *wl =3D vif->wilc;
 	struct host_if_drv *wfi_drv =3D priv->hif_drv;
 	struct wilc_conn_info *conn_info =3D &wfi_drv->conn_info;
+	struct wiphy *wiphy =3D dev->ieee80211_ptr->wiphy;
=20
 	vif->connecting =3D false;
=20
@@ -158,12 +159,16 @@ static void cfg_connect_result(enum conn_event conn_d=
isconn_evt, u8 mac_status,
 			memcpy(priv->associated_bss, conn_info->bssid,
 			       ETH_ALEN);
=20
-		cfg80211_connect_result(dev, conn_info->bssid,
-					conn_info->req_ies,
-					conn_info->req_ies_len,
-					conn_info->resp_ies,
-					conn_info->resp_ies_len, connect_status,
-					GFP_KERNEL);
+		cfg80211_ref_bss(wiphy, vif->bss);
+		cfg80211_connect_bss(dev, conn_info->bssid, vif->bss,
+				     conn_info->req_ies,
+				     conn_info->req_ies_len,
+				     conn_info->resp_ies,
+				     conn_info->resp_ies_len,
+				     connect_status, GFP_KERNEL,
+				     NL80211_TIMEOUT_UNSPECIFIED);
+
+		vif->bss =3D NULL;
 	} else if (conn_disconn_evt =3D=3D CONN_DISCONN_EVENT_DISCONN_NOTIF) {
 		u16 reason =3D 0;
=20
@@ -406,6 +411,7 @@ static int connect(struct wiphy *wiphy, struct net_devi=
ce *dev,
 		goto out_put_bss;
 	}
 	kfree(join_params);
+	vif->bss =3D bss;
 	cfg80211_put_bss(wiphy, bss);
 	return 0;
=20
@@ -451,6 +457,8 @@ static int disconnect(struct wiphy *wiphy, struct net_d=
evice *dev,
 		ret =3D -EINVAL;
 	}
=20
+	vif->bss =3D NULL;
+
 	return ret;
 }
=20
diff --git a/drivers/staging/wilc1000/wilc_wfi_netdevice.h b/drivers/stagin=
g/wilc1000/wilc_wfi_netdevice.h
index fa41b46eb245..d94a4808bdf9 100644
--- a/drivers/staging/wilc1000/wilc_wfi_netdevice.h
+++ b/drivers/staging/wilc1000/wilc_wfi_netdevice.h
@@ -209,6 +209,7 @@ struct wilc_vif {
 	bool connecting;
 	struct wilc_priv priv;
 	struct list_head list;
+	struct cfg80211_bss *bss;
 };
=20
 struct wilc {
--=20
2.17.1

