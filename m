Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4810C88261
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405999AbfHISZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 14:25:30 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:32511 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfHISZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 14:25:29 -0400
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
IronPort-SDR: YLSeIwpPtC3aylDhvqWiivptpX529iYzseb0UOWHHL+A0lyPvBOU4JiFp/AVVDKEiSzSFV6Y9/
 Utn276ZR5/fXjQCwb6fWkxA01VEp0/y65y0j6o/CItnSuJQblsF6oNClhjqj7GekQrS5eB5seC
 RoHbqgKwA1Bu6agiYOr588zV1NgAUe20K1Z/QX+YhH8r5qeDk98vffi+K/+ElH89LNQLJM89rA
 3kf8ShiHEqZl8m45g+e9btf/F97D+riF7U4KPow32g9RsRSkL5B+wGrGNEB8B+6sCJfxz28anw
 SgE=
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="43782626"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2019 11:25:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Aug 2019 11:25:21 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 9 Aug 2019 11:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJLmzcGIgunfrVgQpdYkk3SBgR1lz7hjnyVgd/WPhCxjdCr4NYF008xiyJ/KtaVgNkU886S4DpUUC1cJ75CC+0M9wdvY6bmsmLn6yUD71xOO10S1TSy75jUQl1KZGCi8yOC4GvPE9P6bqlaIsypObmOHxYuoElS+79LnJ29U/jHBNAwCnfNqfrJRBGj0ExM7P58RvXihhmNkBukVFcS8BVyFrL63sy/2BQIMD440N4l7JSO7iAFPj31Gsg3bsWVha7TNXVzQJtde5LzrkZJzD/vmpp41VUgqoL2T7ZiRYpSc5TvIS9HQiFApUkhhVbrQ3ThnuE9yt9hBFyG8ryrQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0CMDwSPJGXQdTy7k+l3/4GrUS6umQJYvASxOlX27QM=;
 b=HG8XNqz74JTjH3PgEHoZxtmWx9UbpF7eaMWF9nTswuNrQS8qXTg42pk95Ozb8A7nW7yycTGwUkre5AMLHKrFUIPyZtT7aXptgGg8isDpO4WcoI8CSvJ4AyemrApL/ZqzniNe6tZiS7iDPa2JTqrjs6lk7JckMk0g6OIpiuJGy+7iUekhAXliM/gQGxfbIBiAmUWFzXqfa3FUKO/emOD6mbZFPuC51FWrR5iZn3ZNPW4IL0FzjIkRQSzwTSxiOdkij90OMokmvuwErEBzAddaNFEOoQnwnQWtOMqQ6j1jFoZXW/tY/slGc4qfyx8b2sLlr9hphMmXn250uatQGHfQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0CMDwSPJGXQdTy7k+l3/4GrUS6umQJYvASxOlX27QM=;
 b=U71lyPAyg92+2Ac92qO1L1Q84GNezRyjZbvvlbONcXYjzf7Bz/i8qF9Id6Or119tN2u7DTV69URcv4WLdRF6FA++bU8BSbGMnADaT24Mrq/SqTo3fgR/IoGaGy+PJZw2AgHo7DCRfJer4979Z4BdDLGC3AfMgfoy4NnpQGGsYMc=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1950.namprd11.prod.outlook.com (10.175.55.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 18:25:19 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336%2]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 18:25:18 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH v2 1/2] staging: wilc1000: Don't reset WILC CPU disgracefully
Thread-Topic: [PATCH v2 1/2] staging: wilc1000: Don't reset WILC CPU
 disgracefully
Thread-Index: AQHVTt/MTyR+QJ6tRkSb4F3LsSrinQ==
Date:   Fri, 9 Aug 2019 18:25:18 +0000
Message-ID: <20190809182510.22443-2-adham.abozaeid@microchip.com>
References: <20190809182510.22443-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190809182510.22443-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::48) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af80c39a-f610-4608-d5b1-08d71cf6ee70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1950;
x-ms-traffictypediagnostic: MWHPR11MB1950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB195072D1ABE61F682F7F32D58DD60@MWHPR11MB1950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(43544003)(199004)(189003)(5660300002)(6486002)(71200400001)(5640700003)(186003)(6436002)(26005)(66066001)(2351001)(107886003)(6512007)(53936002)(50226002)(1076003)(54906003)(7736002)(2906002)(86362001)(386003)(2501003)(71190400001)(305945005)(8676002)(6506007)(14454004)(11346002)(2616005)(476003)(14444005)(446003)(256004)(99286004)(6116002)(3846002)(486006)(64756008)(76176011)(66556008)(66946007)(52116002)(66446008)(66476007)(81156014)(81166006)(6916009)(8936002)(4326008)(316002)(25786009)(102836004)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1950;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cpPLHmAlI+mBEpOQ9cvGBs5E7t+Nu677pE6zbN7NZbfW6FLXbBmUGj4bbsxEQt3+/Q87b79DV+EYCYcjYKF1jBhJXMCwjkCYT/zIuqFT9eORVngL32Wq4CAu3p5TNYgSRIuGvVoawv+K3nTzXHVVhQAR+feV81/AoSa+a0++cft/FWlznx3vW/ziS+8JN65a2iyksFAVCy9YVS5YoioRSUkerr+vP6zh8q+bls7bi3GPI8qWPESa+6gm2J+rlc9pxMcgBl5CxWj+HDplhAYuH6fS4/rKcz78DaHS09QMV4isvAkiW2xCUj4et25tvPSKPckfVy8WShtE/tbzaelzWKoXxi+mdIkksUVquPhpXs19PNbRUhIQhxLMmk0tt1CaCgzH9nyxGdk71eZQXEz54A9F7qFmfdKiQItzsHh83uI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af80c39a-f610-4608-d5b1-08d71cf6ee70
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 18:25:18.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: da0js8ZRfnUtvsViaFtGz0LcmeQXipPSA/rdu8tF69XjWoAbCG1n7qGes+uH2Vmc91JOn7gEgJzKgRlsW1irMTZNQWF4vq7dTwZ9MqjH6V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1950
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

Send abort request to WILC from wilc_wlan_stop instead of resetting the
CPU.
The abort request was being sent from wilc_wlan_cleanup after the CPU
was reset which wasn't the correct order. The abort request handler
in the chip will take care of resetting the CPU.

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_netdev.c |  4 +-
 drivers/staging/wilc1000/wilc_wlan.c   | 75 +++++++-------------------
 drivers/staging/wilc1000/wilc_wlan.h   |  5 +-
 3 files changed, 24 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1=
000/wilc_netdev.c
index 57510400f243..cd11c35adcfe 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -475,7 +475,7 @@ static void wilc_wlan_deinitialize(struct net_device *d=
ev)
 		wlan_deinitialize_threads(dev);
 		deinit_irq(dev);
=20
-		wilc_wlan_stop(wl);
+		wilc_wlan_stop(wl, vif);
 		wilc_wlan_cleanup(dev);
 		wlan_deinit_locks(dev);
=20
@@ -573,7 +573,7 @@ static int wilc_wlan_initialize(struct net_device *dev,=
 struct wilc_vif *vif)
 		return 0;
=20
 fail_fw_start:
-		wilc_wlan_stop(wl);
+		wilc_wlan_stop(wl, vif);
=20
 fail_irq_enable:
 		if (!wl->dev_irq_num &&
diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc100=
0/wilc_wlan.c
index d4ca6467485c..3d902b499a34 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -968,60 +968,42 @@ int wilc_wlan_start(struct wilc *wilc)
 	return (ret < 0) ? ret : 0;
 }
=20
-int wilc_wlan_stop(struct wilc *wilc)
+int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
 {
 	u32 reg =3D 0;
 	int ret;
-	u8 timeout =3D 10;
=20
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
=20
-	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
 	if (!ret) {
+		netdev_err(vif->ndev, "Error while reading reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 		return ret;
 	}
=20
-	reg &=3D ~BIT(10);
-	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
+					(reg | WILC_ABORT_REQ_BIT));
 	if (!ret) {
+		netdev_err(vif->ndev, "Error while writing reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 		return ret;
 	}
=20
-	do {
-		ret =3D wilc->hif_func->hif_read_reg(wilc,
-						   WILC_GLB_RESET_0, &reg);
-		if (!ret) {
-			release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-			return ret;
-		}
-
-		if ((reg & BIT(10))) {
-			reg &=3D ~BIT(10);
-			ret =3D wilc->hif_func->hif_write_reg(wilc,
-							    WILC_GLB_RESET_0,
-							    reg);
-			timeout--;
-		} else {
-			ret =3D wilc->hif_func->hif_read_reg(wilc,
-							   WILC_GLB_RESET_0,
-							   &reg);
-			if (!ret) {
-				release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-				return ret;
-			}
-			break;
-		}
-
-	} while (timeout);
-	reg =3D (BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(8) | BIT(9) | BIT(26) |
-	       BIT(29) | BIT(30) | BIT(31));
-
-	wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
-	reg =3D (u32)~BIT(10);
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_FW_HOST_COMM, &reg);
+	if (!ret) {
+		netdev_err(vif->ndev, "Error while reading reg\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+	reg =3D BIT(0);
=20
-	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_FW_HOST_COMM, reg);
+	if (!ret) {
+		netdev_err(vif->ndev, "Error while writing reg\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
=20
 	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
=20
@@ -1032,8 +1014,6 @@ void wilc_wlan_cleanup(struct net_device *dev)
 {
 	struct txq_entry_t *tqe;
 	struct rxq_entry_t *rqe;
-	u32 reg =3D 0;
-	int ret;
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc *wilc =3D vif->wilc;
=20
@@ -1058,23 +1038,6 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	wilc->rx_buffer =3D NULL;
 	kfree(wilc->tx_buffer);
 	wilc->tx_buffer =3D NULL;
-
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
-
-	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
-	if (!ret) {
-		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return;
-	}
-
-	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
-					(reg | ABORT_INT));
-	if (!ret) {
-		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return;
-	}
-
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 	wilc->hif_func->hif_deinit(NULL);
 }
=20
diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc100=
0/wilc_wlan.h
index 802f11807659..f566d040bb72 100644
--- a/drivers/staging/wilc1000/wilc_wlan.h
+++ b/drivers/staging/wilc1000/wilc_wlan.h
@@ -98,6 +98,7 @@
 #define WILC_VMM_TBL_RX_SHADOW_BASE	WILC_AHB_SHARE_MEM_BASE
 #define WILC_VMM_TBL_RX_SHADOW_SIZE	256
=20
+#define WILC_FW_HOST_COMM		0x13c0
 #define WILC_GP_REG_0			0x149c
 #define WILC_GP_REG_1			0x14a0
=20
@@ -129,7 +130,7 @@
=20
 #define WILC_PLL_TO_SDIO	4
 #define WILC_PLL_TO_SPI		2
-#define ABORT_INT		BIT(31)
+#define WILC_ABORT_REQ_BIT		BIT(31)
=20
 #define WILC_RX_BUFF_SIZE	(96 * 1024)
 #define WILC_TX_BUFF_SIZE	(64 * 1024)
@@ -280,7 +281,7 @@ struct wilc_vif;
 int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
-int wilc_wlan_stop(struct wilc *wilc);
+int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif);
 int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buff=
er,
 			      u32 buffer_size,
 			      void (*tx_complete_fn)(void *, int));
--=20
2.17.1

