Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63027759A8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfGYVbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:31:37 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41144 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfGYVbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:36 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: YLGpRBRJgTVK0jaRDYOWFduUMHJf2YM0odliuK40MLWC97+b59W+ondFfY/VxigMAhF4ulfNsI
 dzMFeJLHviEx/nb1mlBAGwGRKYitp8JgZw6SN9i9+RW1013NkxObWGkE+M1XAVga/8I6Eti7Do
 o/s5XcxbugbVCaKjhg4ZKGvCHDjkJLSNWdzYJLO2q5B6DBPXk1YF26baqRy0OqQnRkyst1lRHV
 yan0u7aomru4hyX2MaxJOkjP39zLfMkMwhMKKNwMtqVrvQottR3X/BXFMzhHe8vDAHywg3+Y2e
 5Gw=
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="42013687"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 14:31:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 14:31:34 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 14:31:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CepM/Rl7rsdO6Q4+vlWzyEqhDQ+RGfKY8llqxi3p+7gc4AR9nod4Bgi+iWt7A9Yle0R49S/hci/937XxMeO3Wuznullhyv7u7ti0M5xIwqzj8wjOiTcOnFx3I5UMAxqjpWffRyx/6F2Tf4ry03Dv1QQeIsplRYtWPhfHp99em8h7v41DwdXiBv//ip0PXiL9LqSMTiQUXOv/9ADBEWpRsKu1J5O3QdS72EjnYLohctOviD2darCW/1tt2/g/onBwLE4k/ra6xRTRbRVEiDyzFXhOVbND/cZ7myZoeRi2lMq8qbCYml4Kya6ha/F5I/dQJF7wuKrs36/RmKeWgtrn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWMYCJxFTPrnnCUe1JmVVDsNye3LXADjkqFYPgZjJ7A=;
 b=WeeKN5wKM8cmA5nZR9xI3wNEVp4aEchIeCXbfa/1hmT1Vw6zK/rrL9EAwolfT4oppmmsyxfYsAZQ09FLmjVfdYOCh59CEfNuubbybSI7nLPdOTjoR9Sx63m+Qi/GpsesuIJegCe3eGsl4qLy7PPFSmcB9Sy7Ay1dCDuxGfyDvP3oEHv7s70y32sKhZ4ZtXRQIuudReSPIHr1kPKuhzVxo/mCtq9hk2Njgy/m89VakVIynnQf2dDpggGZH/e3g/yuihBstE3O9LjcesNU9kdHz3oXm/Guhtk/Zuzd13bOyRRe3E+SqoQw3lygyRmdRTeV9uS4BiEXqie2OBxdlhTpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWMYCJxFTPrnnCUe1JmVVDsNye3LXADjkqFYPgZjJ7A=;
 b=tLTmeXtx0uMQVSU4gzgqniw3ePNhqZU4HCDTw6A5cmFoygGEMndA0o3qTF3hhGwzIfcsAd/ohIImxDgTw5qAYj7QNBaX6NlFEY6MsOt7togbOt6yeDp0X/Hl2JCDLiHWFjobDboGx88sfsuPFGFGQ1nC9qikR3LADFQ7z5l34ck=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 21:31:34 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 21:31:34 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH 2/6] staging: wilc1000: remove ip timeout timer
Thread-Topic: [PATCH 2/6] staging: wilc1000: remove ip timeout timer
Thread-Index: AQHVQzBUreyQ3c8XUEWXReu0mb6vuw==
Date:   Thu, 25 Jul 2019 21:31:34 +0000
Message-ID: <20190725213125.2810-3-adham.abozaeid@microchip.com>
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
x-ms-office365-filtering-correlation-id: ddaa7eab-63c7-49b9-e61e-08d711477732
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984B6EFDDFBC8849A93F6CC8DC10@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(11346002)(2616005)(476003)(102836004)(386003)(446003)(486006)(6916009)(2351001)(6506007)(66946007)(186003)(99286004)(2501003)(76176011)(26005)(316002)(52116002)(5660300002)(66446008)(256004)(305945005)(6486002)(25786009)(64756008)(66556008)(66476007)(53936002)(1076003)(107886003)(71200400001)(86362001)(71190400001)(4326008)(14444005)(68736007)(478600001)(8936002)(6116002)(6512007)(14454004)(50226002)(8676002)(5640700003)(81166006)(81156014)(3846002)(2906002)(6436002)(66066001)(54906003)(7736002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UQeO3oEbPVnDzGRmSiRsiqVIyfidPc1yPHnya+5q0dCLxs4KVYH8KfBv2cDkMYnjpvKNIwzSkJQ/CeP61u6SoZwO6OVMczul+vuUSwxkCslMQAOgZuXxW8xQN6hXbnwsBpH0plWuMxxKceDoecO8paNwwjZfGRtdiqPCAVzQ8V3Vlcl1tf7OpJRUWvfxn4UFgnpuWhlI0XM8zZe6kkI40RnGzZ7CFCZ36tF4izlEGng5tIZ2GYOLHxmNCgAQoHYlfzdyRb0GIyQ70oFTDHTmWLPFDbK9cvq0yRfFLH+26xtLirxmJQYGU/8z78CkFOv87XIpZlVdkWRWYLmAFwPgGuoXklS7kxl/hFNzOyDY1ss/AhCTI8F045DFhxwJx0Do9JaaTAl/y2mqmzY8bSSi8/nnp+iKTDWjae91zMhIxZY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa7eab-63c7-49b9-e61e-08d711477732
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:31:34.0192
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

during_ip_timer is not required after removing the code that disables
powersave while the ip is being obtained.
Its handler clear_during_ip is also removed

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_hif.c              |  2 --
 .../staging/wilc1000/wilc_wfi_cfgoperations.c    | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index 9345cabe3c93..9bd2d14ad610 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -684,8 +684,6 @@ static inline void host_int_parse_assoc_resp_info(struc=
t wilc_vif *vif,
 		hif_drv->hif_state =3D HOST_IF_CONNECTED;
=20
 		vif->obtaining_ip =3D true;
-		mod_timer(&vif->during_ip_timer,
-			  jiffies + msecs_to_jiffies(10000));
 	} else {
 		hif_drv->hif_state =3D HOST_IF_IDLE;
 	}
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index 736eedef23b6..5559f27c8e24 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -70,15 +70,6 @@ struct wilc_p2p_mgmt_data {
 static const u8 p2p_oui[] =3D {0x50, 0x6f, 0x9A, 0x09};
 static const u8 p2p_vendor_spec[] =3D {0xdd, 0x05, 0x00, 0x08, 0x40, 0x03}=
;
=20
-#define WILC_IP_TIMEOUT_MS		15000
-
-static void clear_during_ip(struct timer_list *t)
-{
-	struct wilc_vif *vif =3D from_timer(vif, t, during_ip_timer);
-
-	vif->obtaining_ip =3D false;
-}
-
 static void cfg_scan_result(enum scan_event scan_event,
 			    struct wilc_rcvd_net_info *info, void *user_void)
 {
@@ -1422,7 +1413,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 	priv->p2p.recv_random =3D 0x00;
 	priv->p2p.is_wilc_ie =3D false;
 	vif->obtaining_ip =3D false;
-	del_timer(&vif->during_ip_timer);
=20
 	switch (type) {
 	case NL80211_IFTYPE_STATION:
@@ -1470,8 +1460,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
=20
 	case NL80211_IFTYPE_P2P_GO:
 		vif->obtaining_ip =3D true;
-		mod_timer(&vif->during_ip_timer,
-			  jiffies + msecs_to_jiffies(WILC_IP_TIMEOUT_MS));
 		wilc_set_operation_mode(vif, WILC_AP_MODE);
 		dev->ieee80211_ptr->iftype =3D type;
 		priv->wdev.iftype =3D type;
@@ -1949,8 +1937,6 @@ int wilc_init_host_int(struct net_device *net)
 	struct wilc_vif *vif =3D netdev_priv(net);
 	struct wilc_priv *priv =3D &vif->priv;
=20
-	timer_setup(&vif->during_ip_timer, clear_during_ip, 0);
-
 	priv->p2p_listen_state =3D false;
=20
 	mutex_init(&priv->scan_req_lock);
@@ -1973,8 +1959,6 @@ void wilc_deinit_host_int(struct net_device *net)
 	mutex_destroy(&priv->scan_req_lock);
 	ret =3D wilc_deinit(vif);
=20
-	del_timer_sync(&vif->during_ip_timer);
-
 	if (ret)
 		netdev_err(net, "Error while deinitializing host interface\n");
 }
--=20
2.17.1

