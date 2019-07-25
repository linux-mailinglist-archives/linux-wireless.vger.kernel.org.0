Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E505759AD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGYVbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:31:41 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33037 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfGYVbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:39 -0400
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
IronPort-SDR: sprf7Gb3d3IUq3RzH2mkjRXW+FUJxI1+uszcQfHNkJmdsvzQ/Ejx6qsHMBxVwsfeclOjvX4E75
 ZIYQ6MstidbKT5xBgsq3yNoQVjvnIsRIc50kzP2gTxCGfmyhbV1UK1C+WLEB0kHABgcGU46SSC
 73/hU4AAOoPeDH8bgfVNwMrj3XNNFAwaqENTyPHtdzi0C+fi8OvpdB0IJOQyFoJMZDsrogdopO
 4fk3DHwKajtYqPYxgqoHm8zdtXpeaK0Okik6JlJtndu3fEO1kKny/wbjvCu3aJop+eyQWHOAe6
 wxM=
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="44200131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 14:31:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 14:31:38 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 14:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2Tu/E5QxhJwHhFoHDIsSPe06L4NY85gW1RdMYFYILWSt+P0r5yFrqaq6s4enBIFkJKoAcQ/nccUqoDsjYfspLuXaqtg6v4oTqTYozaB+4pLYkQ0Gg+iNLw+4jovKgkBtFNXDFls8RJRvJjpqevljwHqcFlOlPGcXTijk/uBL3ZGBQ2Ij0kH3/NVmpj9VT6ahyn4MQjg/FK5nzltzEF2ANsN4jQn/Gw9fH3GEhOgzuI9DaLNKXm0dsJek4bZtKjZUu4yC3qQCF8AqEBY4tu+yvRLZAHCRSZLQOz7oQVRJWt2MgA/9gp6yC3EtxDAss5KOaGdLZk7oKwSg3X6eRPLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdhnouhEKMMu+QZRhJg7pnlQ60ZuJ2/baK6CduWk0I8=;
 b=Dvimo7xnCkPhAlKEZIacwDWKob2dxc8LylHBFwdMQXaJsvkZHf0nFCoXZ1/cDMkFUHDVaGTjrcM9YXZpQ0G0ymM1hUL3xkztGrp1qUvpREaUOUTfBEX6mpy5rTXk6yXxD3MVWiFRmTIMYKKHsl1YlR8DLDbAmHYaooT1tQ4IERShkUt6CDCoxjc/vUQVf6bODKmkuAOi4gKFHl+462lpnBCmWzvj7NXGSPrg2dyFZQX+Rbrt0GWeq8+M+bzIfVKbuTskL3TjC2yW0NnJGJGhwaKfueNdrzJOvOLo0Oplk+bHJW/yDrJA0wM76YrCSxw5ii4edJNxO9rmw0Jj5UOdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdhnouhEKMMu+QZRhJg7pnlQ60ZuJ2/baK6CduWk0I8=;
 b=iuOLSJt8raKf9qDdZF9iaDCqxTmeRXNHHACC/mgZB+sFk2l34+X0GMIpAyGgfjX7zrFCbHoCIyRIXvzUXhiNkIgHCAVbudCX9uZIQ3LTy0O+/+ByoekyxRWNSGgbYPx1Wwl3aRmJg6+AI8x9xp7Lrgnw8sHOuVBKmNowul0Drzg=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 21:31:37 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 21:31:37 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH 6/6] staging: wilc1000: remove manual sleep mode
Thread-Topic: [PATCH 6/6] staging: wilc1000: remove manual sleep mode
Thread-Index: AQHVQzBXBZBvQVoDpUOfPHfWOT1C6w==
Date:   Thu, 25 Jul 2019 21:31:37 +0000
Message-ID: <20190725213125.2810-7-adham.abozaeid@microchip.com>
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
x-ms-office365-filtering-correlation-id: bddb9c8d-073a-4fe6-672d-08d71147795f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB19844D59956F8DAD744891A18DC10@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(11346002)(2616005)(476003)(102836004)(386003)(446003)(486006)(6916009)(2351001)(6506007)(66946007)(186003)(99286004)(2501003)(76176011)(26005)(316002)(52116002)(5660300002)(66446008)(256004)(305945005)(6486002)(25786009)(64756008)(66556008)(66476007)(53936002)(1076003)(107886003)(71200400001)(86362001)(71190400001)(4326008)(14444005)(68736007)(478600001)(8936002)(6116002)(6512007)(14454004)(50226002)(8676002)(5640700003)(81166006)(81156014)(3846002)(2906002)(6436002)(66066001)(54906003)(7736002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpyNn/sicTMkfORwNIc7t0/lWMJwjHzOQpO0ZCl3/8Rp/z8hxFRdOlN/Jyn/sNu4Anq/VcwZsXCH51eoPbF5Rqexcz3X1GSKlXdvXRJypZsZ4Aju2NXu5ncrL+BBwbNzevhMF4EwIrQPHKToWJCBJ91xhwiznCX+bz7AcgVcyeWhPagbjl58AtL5iPQrGAf/lD/oX8Dggq8sCd6qSXZHTovARKkXfLmaw0E+tQe2nvwdmNcLIee2iTArvFGtE4tt/uF3ZjOR1reg/UlckM3LzIlkJJwpFCGSz6BxfecTekoj+pT8dVlvU4MeHJDb1VQGsFvTkuF9aukaOldF3HOZ5ahHzQh+pXSgieAy3CD/OfglNhGeaie2grNqac87YdMNBbpoFG1mJ3BeBUJt6dVjnTw0eQIVAzDiWpkr6WNM4gE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bddb9c8d-073a-4fe6-672d-08d71147795f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:31:37.5392
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

manual sleep mode was used to put the wilc1000 chip in sleep while in
disconnected state. This is taken care of in the firmware

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_hif.c  |  4 ----
 drivers/staging/wilc1000/wilc_sdio.c |  4 +---
 drivers/staging/wilc1000/wilc_wlan.c | 14 --------------
 drivers/staging/wilc1000/wilc_wlan.h |  2 --
 4 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index 75a6931aa147..f8646ea3b0c4 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -1056,13 +1056,9 @@ static void handle_scan_timer(struct work_struct *wo=
rk)
 static void handle_scan_complete(struct work_struct *work)
 {
 	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
-	struct wilc *wilc =3D msg->vif->wilc;
=20
 	del_timer(&msg->vif->hif_drv->scan_timer);
=20
-	if (!wilc_wlan_get_num_conn_ifcs(wilc))
-		wilc_chip_sleep_manually(wilc);
-
 	handle_scan_done(msg->vif, SCAN_EVENT_DONE);
=20
 	kfree(msg);
diff --git a/drivers/staging/wilc1000/wilc_sdio.c b/drivers/staging/wilc100=
0/wilc_sdio.c
index 4c1c81fed11f..2f9aa36e0114 100644
--- a/drivers/staging/wilc1000/wilc_sdio.c
+++ b/drivers/staging/wilc1000/wilc_sdio.c
@@ -193,9 +193,7 @@ static int wilc_sdio_suspend(struct device *dev)
 	dev_info(dev, "sdio suspend\n");
 	chip_wakeup(wilc);
=20
-	if (!wilc->suspend_event) {
-		wilc_chip_sleep_manually(wilc);
-	} else {
+	if (wilc->suspend_event) {
 		host_sleep_notify(wilc);
 		chip_allow_sleep(wilc);
 	}
diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc100=
0/wilc_wlan.c
index 2cbdbf0090e4..8caa3f4bcdd7 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -455,20 +455,6 @@ void chip_wakeup(struct wilc *wilc)
 }
 EXPORT_SYMBOL_GPL(chip_wakeup);
=20
-void wilc_chip_sleep_manually(struct wilc *wilc)
-{
-	if (wilc->chip_ps_state !=3D WILC_CHIP_WAKEDUP)
-		return;
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
-
-	chip_allow_sleep(wilc);
-	wilc->hif_func->hif_write_reg(wilc, 0x10a8, 1);
-
-	wilc->chip_ps_state =3D WILC_CHIP_SLEEPING_MANUAL;
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
-}
-EXPORT_SYMBOL_GPL(wilc_chip_sleep_manually);
-
 void host_wakeup_notify(struct wilc *wilc)
 {
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc100=
0/wilc_wlan.h
index b70014142686..802f11807659 100644
--- a/drivers/staging/wilc1000/wilc_wlan.h
+++ b/drivers/staging/wilc1000/wilc_wlan.h
@@ -293,8 +293,6 @@ int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, =
u16 wid, int commit,
 		      u32 drv_handler);
 int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buf=
fer,
 			       u32 buffer_size, void (*func)(void *, int));
-void wilc_chip_sleep_manually(struct wilc *wilc);
-
 void wilc_enable_tcp_ack_filter(struct wilc_vif *vif, bool value);
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
--=20
2.17.1

