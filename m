Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EECF146869
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2020 13:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWMuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jan 2020 07:50:54 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35263 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWMuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jan 2020 07:50:54 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0eeL+rWl+0q4eUPkEEAe7TsdKnGw7MDuu7EnLo2hK5KX+d7uJ0h3ZU/K+YDuMdlnL4biBXHjuE
 btzRvFWotfhw7WX0hl83KRA6HDOw19p4MgmmN1md8SdxVnnlcl0H7ej0szK0yzYxQVd6tBSCW8
 VsxoxGrN78OJYw3KAqECCbpOdp3Wo7OqCPo6Eb3ysHxqX6H5o43F1d25f4qSwUbjBuIwEXyGan
 qRNC8CUW351Wl1kqtSN1eoXjKaLqZb86u7CVOdJ6h82HYN1M5wsVAZ/rrn4mps5FTNfjwfY8ga
 F4w=
X-IronPort-AV: E=Sophos;i="5.70,353,1574146800"; 
   d="scan'208";a="65725542"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 05:50:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 05:50:52 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jan 2020 05:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StEpnUPkOPu7N4Hh/BJNZA8jwrZjwIBO1KB4pHHv4FQ72M+PvzhZnuHn8W1M0M7wKTFakEM/YO94Fa1RbK01zqvbKbIxqTH4E/DwT8HkO1mgCGDTNYbkyoeSVk0K4S33FfNo9aoA80jbkpLr/GS8nt+gkQLkcgWLMYam0QCBkix3rYEv6zQToOfwUOi0sT4OHtwEeW1f7pWpe6o3+ikgJHyJYHVLJuheRDFmkoFHcs59BszZKf2huk7dz2vYA+O9gTYPhJh14AfElZr7w6nLRog4XhiUt+dDXKGfSoczJxXntve65aCdt7r+WHs2gHZFw3+uUNIdwlEGK3d8hAtJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P/np4wgG4C6hjSQBwpdjYBqxlJMLFE8j1paJgaNcuE=;
 b=bKKPHwIpY+USq7Zw2+dkiKXDHBNSkRodlIQfk8zXA4J/X+GniidAJ4U+ZM/DwEya6oQyM8UBnJAihGLi8Ww9TQ1Vh4OpccAAW1Yr1lOk0jHyvHbqtuHihEvmNIqlJQMRqWzC4gWdPhNS/d6e7+VerTtIbiQdmCWoNbj0ENg96AqAd+oL5rebTYNicps2MDeNP/ZlcRaKjn3IcIWm19Z/I0QtXSolXs5sWYha2Q7RrZmV4bNnwTn1kuG2UWlMrYwlGD1mQ/cEwR/25XTjoG3JwOA3Bq2ZE8fu+9ydAzjLich4kO8v8o8t4xNuIekSGyh2hh/p/V/DVnIHF/YgoNOTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P/np4wgG4C6hjSQBwpdjYBqxlJMLFE8j1paJgaNcuE=;
 b=L7o0BX/nk6NZij9GU8qLjL43ki3E+9lku32hFiWCISmVSJaWTx7B/5/cXoRiRpFvuEHaHb9qA0g57ff5/9SXKpcX88901rxoYO+Nt7uEec2ML+hYheh7lEcz7txzOZTd02r380nkAk9ocQP/kMRA3HsanXThxW7OgzkEGleifXY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1507.namprd11.prod.outlook.com (10.172.20.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 12:50:48 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61%3]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 12:50:48 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/2] staging: wilc1000: return zero on success and non-zero on
 function failure
Thread-Topic: [PATCH 1/2] staging: wilc1000: return zero on success and
 non-zero on function failure
Thread-Index: AQHV0eu8bTZ/RdN5BkGJQfFUn4Ja4g==
Date:   Thu, 23 Jan 2020 12:50:47 +0000
Message-ID: <20200123182129.4053-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff1edeb-bdbc-4a9f-cf2c-08d7a002dea5
x-ms-traffictypediagnostic: BN6PR11MB1507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1507FE94B84A7EBA9C7064FEE30F0@BN6PR11MB1507.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(26005)(30864003)(5660300002)(36756003)(2906002)(107886003)(4326008)(6916009)(54906003)(6486002)(186003)(478600001)(316002)(86362001)(6506007)(81156014)(8676002)(71200400001)(66556008)(76116006)(91956017)(2616005)(66446008)(66946007)(66476007)(64756008)(6512007)(966005)(81166006)(8936002)(1076003)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1507;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aLzc6Nc9hjV+Hi4CSJ1GYrIY96YMN4Kq2PEHUZg24++OWZ+j1rCpuO4YiooqjpFvJCofZ5hS1NSLVBwlXZcsddyoVInxYXL1TZsjwzH2L1/IGSaHJXKbWW05m672tvXMUolZf7wbO7nOpVQDotag7gVByZzFNHCxJCLfo2TSMCaxi4qzKKabuINs+I7zx+JbUVBV2JJp0pZHpa1OJvufWG/EPMFczn8JVaFnz5p1C2QtF57RH2a7dMTAZ86RxzaPcwqAsfghwEPbSCg/xvDLHMG/S02INXBNtFQViNyDnQEDXlNSjxrbk6TFlRzCZm5RIpe41zDmzKrmDmqwUjVFY85hFdMNJTsTYqGRM+lWPtvp3F4ZQqUxK/Acr9AWIC3h5whRvZdmn4fVhiXURfYiNCiqFr+Fbp3iJewIKigwI5IgI9Z73+jd+aiBxsK/oYpOTPflrCLQt60Vx7Ukd5ZVUpyNWg0DnLqpy1RZxQ6p9mSlNQtuUig/Rf28RY0bTYCbTf+PvTBbVm8QdFBQrLNxJQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff1edeb-bdbc-4a9f-cf2c-08d7a002dea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 12:50:47.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccEJW6Y54QsXGgBrwWeXkNZ6AZT0Gh2lZmHcH0M86FJrRvUEPkZ/FcCls4hyc3MOB1e90kskYqcjcx+/GsiB2BWSEkla1TGzUl68u+s94go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1507
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Some of the HIF layer API's return zero for failure and non-zero for
success condition. Now, modified the functions to return zero for success
and non-zero for failure as its recommended approach suggested in [1].

1. https://lore.kernel.org/driverdev-devel/20191113183322.a54mh2w6dulklgsd@=
kili.mountain/

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/netdev.c |  45 +++-----
 drivers/staging/wilc1000/sdio.c   | 178 +++++++++++++-----------------
 drivers/staging/wilc1000/spi.c    | 138 ++++++++++++-----------
 drivers/staging/wilc1000/wlan.c   |  75 +++++++------
 4 files changed, 197 insertions(+), 239 deletions(-)

diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/n=
etdev.c
index 960dbc8d5173..0f48e74aa3ea 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -183,7 +183,7 @@ static int wilc_wlan_get_firmware(struct net_device *de=
v)
 {
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc *wilc =3D vif->wilc;
-	int chip_id, ret =3D 0;
+	int chip_id;
 	const struct firmware *wilc_firmware;
 	char *firmware;
=20
@@ -198,14 +198,11 @@ static int wilc_wlan_get_firmware(struct net_device *=
dev)
=20
 	if (request_firmware(&wilc_firmware, firmware, wilc->dev) !=3D 0) {
 		netdev_err(dev, "%s - firmware not available\n", firmware);
-		ret =3D -1;
-		goto fail;
+		return -EINVAL;
 	}
 	wilc->firmware =3D wilc_firmware;
=20
-fail:
-
-	return ret;
+	return 0;
 }
=20
 static int wilc_start_firmware(struct net_device *dev)
@@ -215,7 +212,7 @@ static int wilc_start_firmware(struct net_device *dev)
 	int ret =3D 0;
=20
 	ret =3D wilc_wlan_start(wilc);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	if (!wait_for_completion_timeout(&wilc->sync_event,
@@ -238,7 +235,7 @@ static int wilc1000_firmware_download(struct net_device=
 *dev)
=20
 	ret =3D wilc_wlan_firmware_download(wilc, wilc->firmware->data,
 					  wilc->firmware->size);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	release_firmware(wilc->firmware);
@@ -417,7 +414,7 @@ static int wilc_init_fw_config(struct net_device *dev, =
struct wilc_vif *vif)
 	return 0;
=20
 fail:
-	return -1;
+	return -EINVAL;
 }
=20
 static void wlan_deinitialize_threads(struct net_device *dev)
@@ -497,14 +494,12 @@ static int wilc_wlan_initialize(struct net_device *de=
v, struct wilc_vif *vif)
 		wl->close =3D 0;
=20
 		ret =3D wilc_wlan_init(dev);
-		if (ret < 0)
-			return -EIO;
+		if (ret)
+			return ret;
=20
 		ret =3D wlan_initialize_threads(dev);
-		if (ret < 0) {
-			ret =3D -EIO;
+		if (ret)
 			goto fail_wilc_wlan;
-		}
=20
 		if (wl->gpio_irq && init_irq(dev)) {
 			ret =3D -EIO;
@@ -518,22 +513,17 @@ static int wilc_wlan_initialize(struct net_device *de=
v, struct wilc_vif *vif)
 			goto fail_irq_init;
 		}
=20
-		if (wilc_wlan_get_firmware(dev)) {
-			ret =3D -EIO;
+		ret =3D wilc_wlan_get_firmware(dev);
+		if (ret)
 			goto fail_irq_enable;
-		}
=20
 		ret =3D wilc1000_firmware_download(dev);
-		if (ret < 0) {
-			ret =3D -EIO;
+		if (ret)
 			goto fail_irq_enable;
-		}
=20
 		ret =3D wilc_start_firmware(dev);
-		if (ret < 0) {
-			ret =3D -EIO;
+		if (ret)
 			goto fail_irq_enable;
-		}
=20
 		if (wilc_wlan_cfg_get(vif, 1, WID_FIRMWARE_VERSION, 1, 0)) {
 			int size;
@@ -545,11 +535,10 @@ static int wilc_wlan_initialize(struct net_device *de=
v, struct wilc_vif *vif)
 			firmware_ver[size] =3D '\0';
 			netdev_dbg(dev, "Firmware Ver =3D %s\n", firmware_ver);
 		}
-		ret =3D wilc_init_fw_config(dev, vif);
=20
-		if (ret < 0) {
+		ret =3D wilc_init_fw_config(dev, vif);
+		if (ret) {
 			netdev_err(dev, "Failed to configure firmware\n");
-			ret =3D -EIO;
 			goto fail_fw_start;
 		}
 		wl->initialized =3D true;
@@ -600,11 +589,11 @@ static int wilc_mac_open(struct net_device *ndev)
 	netdev_dbg(ndev, "MAC OPEN[%p]\n", ndev);
=20
 	ret =3D wilc_init_host_int(ndev);
-	if (ret < 0)
+	if (ret)
 		return ret;
=20
 	ret =3D wilc_wlan_initialize(ndev, vif);
-	if (ret < 0) {
+	if (ret) {
 		wilc_deinit_host_int(ndev);
 		return ret;
 	}
diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 319e039380b0..ca99335687c4 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -273,7 +273,7 @@ static int wilc_sdio_set_func0_csa_address(struct wilc =
*wilc, u32 adr)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x10c data...\n");
-		goto fail;
+		return ret;
 	}
=20
 	cmd.address =3D 0x10d;
@@ -281,7 +281,7 @@ static int wilc_sdio_set_func0_csa_address(struct wilc =
*wilc, u32 adr)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x10d data...\n");
-		goto fail;
+		return ret;
 	}
=20
 	cmd.address =3D 0x10e;
@@ -289,11 +289,9 @@ static int wilc_sdio_set_func0_csa_address(struct wilc=
 *wilc, u32 adr)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x10e data...\n");
-		goto fail;
+		return ret;
 	}
=20
-	return 1;
-fail:
 	return 0;
 }
=20
@@ -311,7 +309,7 @@ static int wilc_sdio_set_func0_block_size(struct wilc *=
wilc, u32 block_size)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x10 data...\n");
-		goto fail;
+		return ret;
 	}
=20
 	cmd.address =3D 0x11;
@@ -319,11 +317,9 @@ static int wilc_sdio_set_func0_block_size(struct wilc =
*wilc, u32 block_size)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x11 data...\n");
-		goto fail;
+		return ret;
 	}
=20
-	return 1;
-fail:
 	return 0;
 }
=20
@@ -347,18 +343,16 @@ static int wilc_sdio_set_func1_block_size(struct wilc=
 *wilc, u32 block_size)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x110 data...\n");
-		goto fail;
+		return ret;
 	}
 	cmd.address =3D 0x111;
 	cmd.data =3D (u8)(block_size >> 8);
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Failed cmd52, set 0x111 data...\n");
-		goto fail;
+		return ret;
 	}
=20
-	return 1;
-fail:
 	return 0;
 }
=20
@@ -384,19 +378,18 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32=
 addr, u32 data)
 		cmd.address =3D addr;
 		cmd.data =3D data;
 		ret =3D wilc_sdio_cmd52(wilc, &cmd);
-		if (ret) {
+		if (ret)
 			dev_err(&func->dev,
 				"Failed cmd 52, read reg (%08x) ...\n", addr);
-			goto fail;
-		}
 	} else {
 		struct sdio_cmd53 cmd;
=20
 		/**
 		 *      set the AHB address
 		 **/
-		if (!wilc_sdio_set_func0_csa_address(wilc, addr))
-			goto fail;
+		ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+		if (ret)
+			return ret;
=20
 		cmd.read_write =3D 1;
 		cmd.function =3D 0;
@@ -407,18 +400,12 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32=
 addr, u32 data)
 		cmd.buffer =3D (u8 *)&data;
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
-		if (ret) {
+		if (ret)
 			dev_err(&func->dev,
 				"Failed cmd53, write reg (%08x)...\n", addr);
-			goto fail;
-		}
 	}
=20
-	return 1;
-
-fail:
-
-	return 0;
+	return ret;
 }
=20
 static int wilc_sdio_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
@@ -470,14 +457,15 @@ static int wilc_sdio_write(struct wilc *wilc, u32 add=
r, u8 *buf, u32 size)
 		cmd.buffer =3D buf;
 		cmd.block_size =3D block_size;
 		if (addr > 0) {
-			if (!wilc_sdio_set_func0_csa_address(wilc, addr))
-				goto fail;
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
 		}
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret) {
 			dev_err(&func->dev,
 				"Failed cmd53 [%x], block send...\n", addr);
-			goto fail;
+			return ret;
 		}
 		if (addr > 0)
 			addr +=3D nblk * block_size;
@@ -493,21 +481,18 @@ static int wilc_sdio_write(struct wilc *wilc, u32 add=
r, u8 *buf, u32 size)
 		cmd.block_size =3D block_size;
=20
 		if (addr > 0) {
-			if (!wilc_sdio_set_func0_csa_address(wilc, addr))
-				goto fail;
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
 		}
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret) {
 			dev_err(&func->dev,
 				"Failed cmd53 [%x], bytes send...\n", addr);
-			goto fail;
+			return ret;
 		}
 	}
=20
-	return 1;
-
-fail:
-
 	return 0;
 }
=20
@@ -528,14 +513,15 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 =
addr, u32 *data)
 		if (ret) {
 			dev_err(&func->dev,
 				"Failed cmd 52, read reg (%08x) ...\n", addr);
-			goto fail;
+			return ret;
 		}
 		*data =3D cmd.data;
 	} else {
 		struct sdio_cmd53 cmd;
=20
-		if (!wilc_sdio_set_func0_csa_address(wilc, addr))
-			goto fail;
+		ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+		if (ret)
+			return ret;
=20
 		cmd.read_write =3D 0;
 		cmd.function =3D 0;
@@ -550,16 +536,11 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 =
addr, u32 *data)
 		if (ret) {
 			dev_err(&func->dev,
 				"Failed cmd53, read reg (%08x)...\n", addr);
-			goto fail;
+			return ret;
 		}
 	}
=20
 	le32_to_cpus(data);
-
-	return 1;
-
-fail:
-
 	return 0;
 }
=20
@@ -612,14 +593,15 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr=
, u8 *buf, u32 size)
 		cmd.buffer =3D buf;
 		cmd.block_size =3D block_size;
 		if (addr > 0) {
-			if (!wilc_sdio_set_func0_csa_address(wilc, addr))
-				goto fail;
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
 		}
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret) {
 			dev_err(&func->dev,
 				"Failed cmd53 [%x], block read...\n", addr);
-			goto fail;
+			return ret;
 		}
 		if (addr > 0)
 			addr +=3D nblk * block_size;
@@ -635,21 +617,18 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr=
, u8 *buf, u32 size)
 		cmd.block_size =3D block_size;
=20
 		if (addr > 0) {
-			if (!wilc_sdio_set_func0_csa_address(wilc, addr))
-				goto fail;
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
 		}
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret) {
 			dev_err(&func->dev,
 				"Failed cmd53 [%x], bytes read...\n", addr);
-			goto fail;
+			return ret;
 		}
 	}
=20
-	return 1;
-
-fail:
-
 	return 0;
 }
=20
@@ -661,7 +640,7 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, =
u8 *buf, u32 size)
=20
 static int wilc_sdio_deinit(struct wilc *wilc)
 {
-	return 1;
+	return 0;
 }
=20
 static int wilc_sdio_init(struct wilc *wilc, bool resume)
@@ -686,15 +665,16 @@ static int wilc_sdio_init(struct wilc *wilc, bool res=
ume)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, enable csa...\n");
-		goto fail;
+		return ret;
 	}
=20
 	/**
 	 *      function 0 block size
 	 **/
-	if (!wilc_sdio_set_func0_block_size(wilc, WILC_SDIO_BLOCK_SIZE)) {
+	ret =3D wilc_sdio_set_func0_block_size(wilc, WILC_SDIO_BLOCK_SIZE);
+	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, set func 0 block size...\n");
-		goto fail;
+		return ret;
 	}
 	sdio_priv->block_size =3D WILC_SDIO_BLOCK_SIZE;
=20
@@ -710,7 +690,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	if (ret) {
 		dev_err(&func->dev,
 			"Fail cmd 52, set IOE register...\n");
-		goto fail;
+		return ret;
 	}
=20
 	/**
@@ -727,7 +707,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 		if (ret) {
 			dev_err(&func->dev,
 				"Fail cmd 52, get IOR register...\n");
-			goto fail;
+			return ret;
 		}
 		if (cmd.data =3D=3D 0x2)
 			break;
@@ -735,15 +715,16 @@ static int wilc_sdio_init(struct wilc *wilc, bool res=
ume)
=20
 	if (loop <=3D 0) {
 		dev_err(&func->dev, "Fail func 1 is not ready...\n");
-		goto fail;
+		return -EINVAL;
 	}
=20
 	/**
 	 *      func 1 is ready, set func 1 block size
 	 **/
-	if (!wilc_sdio_set_func1_block_size(wilc, WILC_SDIO_BLOCK_SIZE)) {
+	ret =3D wilc_sdio_set_func1_block_size(wilc, WILC_SDIO_BLOCK_SIZE);
+	if (ret) {
 		dev_err(&func->dev, "Fail set func 1 block size...\n");
-		goto fail;
+		return ret;
 	}
=20
 	/**
@@ -757,16 +738,17 @@ static int wilc_sdio_init(struct wilc *wilc, bool res=
ume)
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, set IEN register...\n");
-		goto fail;
+		return ret;
 	}
=20
 	/**
 	 *      make sure can read back chip id correctly
 	 **/
 	if (!resume) {
-		if (!wilc_sdio_read_reg(wilc, 0x1000, &chipid)) {
+		ret =3D wilc_sdio_read_reg(wilc, 0x1000, &chipid);
+		if (ret) {
 			dev_err(&func->dev, "Fail cmd read chip id...\n");
-			goto fail;
+			return ret;
 		}
 		dev_err(&func->dev, "chipid (%08x)\n", chipid);
 		if ((chipid & 0xfff) > 0x2a0)
@@ -777,10 +759,6 @@ static int wilc_sdio_init(struct wilc *wilc, bool resu=
me)
 			 sdio_priv->has_thrpt_enh3);
 	}
=20
-	return 1;
-
-fail:
-
 	return 0;
 }
=20
@@ -806,7 +784,7 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *=
size)
 	tmp |=3D (cmd.data << 8);
=20
 	*size =3D tmp;
-	return 1;
+	return 0;
 }
=20
 static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
@@ -865,7 +843,7 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *i=
nt_status)
=20
 	*int_status =3D tmp;
=20
-	return 1;
+	return 0;
 }
=20
 static int wilc_sdio_clear_int_ext(struct wilc *wilc, u32 val)
@@ -909,10 +887,10 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 				dev_err(&func->dev,
 					"Failed cmd52, set 0xf8 data (%d) ...\n",
 					__LINE__);
-				goto fail;
+				return ret;
 			}
 		}
-		return 1;
+		return 0;
 	}
 	if (sdio_priv->irq_gpio) {
 		/* has_thrpt_enh2 uses register 0xf8 to clear interrupts. */
@@ -926,7 +904,6 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc, u=
32 val)
 		if (flags) {
 			int i;
=20
-			ret =3D 1;
 			for (i =3D 0; i < sdio_priv->nint; i++) {
 				if (flags & 1) {
 					struct sdio_cmd52 cmd;
@@ -942,15 +919,12 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 						dev_err(&func->dev,
 							"Failed cmd52, set 0xf8 data (%d) ...\n",
 							__LINE__);
-						goto fail;
+						return ret;
 					}
 				}
-				if (!ret)
-					break;
 				flags >>=3D 1;
 			}
-			if (!ret)
-				goto fail;
+
 			for (i =3D sdio_priv->nint; i < MAX_NUM_INT; i++) {
 				if (flags & 1)
 					dev_err(&func->dev,
@@ -985,11 +959,9 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc, =
u32 val)
 			dev_err(&func->dev,
 				"Failed cmd52, set 0xf6 data (%d) ...\n",
 				__LINE__);
-			goto fail;
+			return ret;
 		}
 	}
-	return 1;
-fail:
 	return 0;
 }
=20
@@ -1001,12 +973,12 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int=
 nint)
=20
 	if (nint > MAX_NUM_INT) {
 		dev_err(&func->dev, "Too many interrupts (%d)...\n", nint);
-		return 0;
+		return -EINVAL;
 	}
 	if (nint > MAX_NUN_INT_THRPT_ENH2) {
 		dev_err(&func->dev,
 			"Cannot support more than 5 interrupts when has_thrpt_enh2=3D1.\n");
-		return 0;
+		return -EINVAL;
 	}
=20
 	sdio_priv->nint =3D nint;
@@ -1014,15 +986,15 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int=
 nint)
 	/**
 	 *      Disable power sequencer
 	 **/
-	if (!wilc_sdio_read_reg(wilc, WILC_MISC, &reg)) {
+	if (wilc_sdio_read_reg(wilc, WILC_MISC, &reg)) {
 		dev_err(&func->dev, "Failed read misc reg...\n");
-		return 0;
+		return -EINVAL;
 	}
=20
 	reg &=3D ~BIT(8);
-	if (!wilc_sdio_write_reg(wilc, WILC_MISC, reg)) {
+	if (wilc_sdio_write_reg(wilc, WILC_MISC, reg)) {
 		dev_err(&func->dev, "Failed write misc reg...\n");
-		return 0;
+		return -EINVAL;
 	}
=20
 	if (sdio_priv->irq_gpio) {
@@ -1033,59 +1005,59 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, in=
t nint)
 		 *      interrupt pin mux select
 		 **/
 		ret =3D wilc_sdio_read_reg(wilc, WILC_PIN_MUX_0, &reg);
-		if (!ret) {
+		if (ret) {
 			dev_err(&func->dev, "Failed read reg (%08x)...\n",
 				WILC_PIN_MUX_0);
-			return 0;
+			return ret;
 		}
 		reg |=3D BIT(8);
 		ret =3D wilc_sdio_write_reg(wilc, WILC_PIN_MUX_0, reg);
-		if (!ret) {
+		if (ret) {
 			dev_err(&func->dev, "Failed write reg (%08x)...\n",
 				WILC_PIN_MUX_0);
-			return 0;
+			return ret;
 		}
=20
 		/**
 		 *      interrupt enable
 		 **/
 		ret =3D wilc_sdio_read_reg(wilc, WILC_INTR_ENABLE, &reg);
-		if (!ret) {
+		if (ret) {
 			dev_err(&func->dev, "Failed read reg (%08x)...\n",
 				WILC_INTR_ENABLE);
-			return 0;
+			return ret;
 		}
=20
 		for (i =3D 0; (i < 5) && (nint > 0); i++, nint--)
 			reg |=3D BIT((27 + i));
 		ret =3D wilc_sdio_write_reg(wilc, WILC_INTR_ENABLE, reg);
-		if (!ret) {
+		if (ret) {
 			dev_err(&func->dev, "Failed write reg (%08x)...\n",
 				WILC_INTR_ENABLE);
-			return 0;
+			return ret;
 		}
 		if (nint) {
 			ret =3D wilc_sdio_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
-			if (!ret) {
+			if (ret) {
 				dev_err(&func->dev,
 					"Failed read reg (%08x)...\n",
 					WILC_INTR2_ENABLE);
-				return 0;
+				return ret;
 			}
=20
 			for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
 				reg |=3D BIT(i);
=20
 			ret =3D wilc_sdio_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
-			if (!ret) {
+			if (ret) {
 				dev_err(&func->dev,
 					"Failed write reg (%08x)...\n",
 					WILC_INTR2_ENABLE);
-				return 0;
+				return ret;
 			}
 		}
 	}
-	return 1;
+	return 0;
 }
=20
 /* Global sdio HIF function table */
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 4b883a933b44..3ffc7b4fddf6 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -88,11 +88,6 @@ static u8 crc7(u8 crc, const u8 *buffer, u32 len)
 #define CMD_SINGLE_READ				0xca
 #define CMD_RESET				0xcf
=20
-#define N_OK					1
-#define N_FAIL					0
-#define N_RESET					-1
-#define N_RETRY					-2
-
 #define DATA_PKT_SZ_256				256
 #define DATA_PKT_SZ_512				512
 #define DATA_PKT_SZ_1K				1024
@@ -299,7 +294,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 	u32 len2;
 	u8 rsp;
 	int len =3D 0;
-	int result =3D N_OK;
+	int result =3D 0;
 	int retry;
 	u8 crc[2];
=20
@@ -387,11 +382,11 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd=
, u32 adr, u8 *b, u32 sz,
 		break;
=20
 	default:
-		result =3D N_FAIL;
+		result =3D -EINVAL;
 		break;
 	}
=20
-	if (result !=3D N_OK)
+	if (result)
 		return result;
=20
 	if (!spi_priv->crc_off)
@@ -424,7 +419,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 	if (len2 > ARRAY_SIZE(wb)) {
 		dev_err(&spi->dev, "spi buffer size too small (%d) (%zu)\n",
 			len2, ARRAY_SIZE(wb));
-		return N_FAIL;
+		return -EINVAL;
 	}
 	/* zero spi write buffers. */
 	for (wix =3D len; wix < len2; wix++)
@@ -433,7 +428,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
=20
 	if (wilc_spi_tx_rx(wilc, wb, rb, len2)) {
 		dev_err(&spi->dev, "Failed cmd write, bus error...\n");
-		return N_FAIL;
+		return -EINVAL;
 	}
=20
 	/*
@@ -448,7 +443,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 		dev_err(&spi->dev,
 			"Failed cmd response, cmd (%02x), resp (%02x)\n",
 			cmd, rsp);
-		return N_FAIL;
+		return -EINVAL;
 	}
=20
 	/*
@@ -458,7 +453,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 	if (rsp !=3D 0x00) {
 		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
 			rsp);
-		return N_FAIL;
+		return -EINVAL;
 	}
=20
 	if (cmd =3D=3D CMD_INTERNAL_READ || cmd =3D=3D CMD_SINGLE_READ ||
@@ -485,7 +480,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 		if (retry <=3D 0) {
 			dev_err(&spi->dev,
 				"Error, data read response (%02x)\n", rsp);
-			return N_RESET;
+			return -EAGAIN;
 		}
 	}
=20
@@ -501,7 +496,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 		} else {
 			dev_err(&spi->dev,
 				"buffer overrun when reading data.\n");
-			return N_FAIL;
+			return -EINVAL;
 		}
=20
 		if (!spi_priv->crc_off) {
@@ -514,7 +509,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 			} else {
 				dev_err(&spi->dev,
 					"buffer overrun when reading crc.\n");
-				return N_FAIL;
+				return -EINVAL;
 			}
 		}
 	} else if ((cmd =3D=3D CMD_DMA_READ) || (cmd =3D=3D CMD_DMA_EXT_READ)) {
@@ -540,7 +535,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 			if (wilc_spi_rx(wilc, &b[ix], nbytes)) {
 				dev_err(&spi->dev,
 					"Failed block read, bus err\n");
-				return N_FAIL;
+				return -EINVAL;
 			}
=20
 			/*
@@ -549,7 +544,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 			if (!spi_priv->crc_off && wilc_spi_rx(wilc, crc, 2)) {
 				dev_err(&spi->dev,
 					"Failed block crc read, bus err\n");
-				return N_FAIL;
+				return -EINVAL;
 			}
=20
 			ix +=3D nbytes;
@@ -581,14 +576,14 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd=
, u32 adr, u8 *b, u32 sz,
 				if (wilc_spi_rx(wilc, &rsp, 1)) {
 					dev_err(&spi->dev,
 						"Failed resp read, bus err\n");
-					result =3D N_FAIL;
+					result =3D -EINVAL;
 					break;
 				}
 				if (((rsp >> 4) & 0xf) =3D=3D 0xf)
 					break;
 			} while (retry--);
=20
-			if (result =3D=3D N_FAIL)
+			if (result)
 				break;
=20
 			/*
@@ -597,7 +592,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 			if (wilc_spi_rx(wilc, &b[ix], nbytes)) {
 				dev_err(&spi->dev,
 					"Failed block read, bus err\n");
-				result =3D N_FAIL;
+				result =3D -EINVAL;
 				break;
 			}
=20
@@ -607,7 +602,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz,
 			if (!spi_priv->crc_off && wilc_spi_rx(wilc, crc, 2)) {
 				dev_err(&spi->dev,
 					"Failed block crc read, bus err\n");
-				result =3D N_FAIL;
+				result =3D -EINVAL;
 				break;
 			}
=20
@@ -623,7 +618,7 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32=
 sz)
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv =3D wilc->bus_data;
 	int ix, nbytes;
-	int result =3D 1;
+	int result =3D 0;
 	u8 cmd, order, crc[2] =3D {0};
=20
 	/*
@@ -651,7 +646,7 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32=
 sz)
 		if (wilc_spi_tx(wilc, &cmd, 1)) {
 			dev_err(&spi->dev,
 				"Failed data block cmd write, bus error...\n");
-			result =3D N_FAIL;
+			result =3D -EINVAL;
 			break;
 		}
=20
@@ -661,7 +656,7 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32=
 sz)
 		if (wilc_spi_tx(wilc, &b[ix], nbytes)) {
 			dev_err(&spi->dev,
 				"Failed data block write, bus error...\n");
-			result =3D N_FAIL;
+			result =3D -EINVAL;
 			break;
 		}
=20
@@ -671,7 +666,7 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32=
 sz)
 		if (!spi_priv->crc_off) {
 			if (wilc_spi_tx(wilc, crc, 2)) {
 				dev_err(&spi->dev, "Failed data block crc write, bus error...\n");
-				result =3D N_FAIL;
+				result =3D -EINVAL;
 				break;
 			}
 		}
@@ -700,7 +695,7 @@ static int spi_internal_write(struct wilc *wilc, u32 ad=
r, u32 dat)
 	cpu_to_le32s(&dat);
 	result =3D spi_cmd_complete(wilc, CMD_INTERNAL_WRITE, adr, (u8 *)&dat, 4,
 				  0);
-	if (result !=3D N_OK)
+	if (result)
 		dev_err(&spi->dev, "Failed internal write cmd...\n");
=20
 	return result;
@@ -713,14 +708,14 @@ static int spi_internal_read(struct wilc *wilc, u32 a=
dr, u32 *data)
=20
 	result =3D spi_cmd_complete(wilc, CMD_INTERNAL_READ, adr, (u8 *)data, 4,
 				  0);
-	if (result !=3D N_OK) {
+	if (result) {
 		dev_err(&spi->dev, "Failed internal read cmd...\n");
-		return 0;
+		return result;
 	}
=20
 	le32_to_cpus(data);
=20
-	return 1;
+	return result;
 }
=20
 /********************************************
@@ -744,7 +739,7 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 ad=
dr, u32 data)
 	}
=20
 	result =3D spi_cmd_complete(wilc, cmd, addr, (u8 *)&data, 4, clockless);
-	if (result !=3D N_OK)
+	if (result)
 		dev_err(&spi->dev, "Failed cmd, write reg (%08x)...\n", addr);
=20
 	return result;
@@ -759,23 +754,23 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr=
, u8 *buf, u32 size)
 	 * has to be greated than 4
 	 */
 	if (size <=3D 4)
-		return 0;
+		return -EINVAL;
=20
 	result =3D spi_cmd_complete(wilc, CMD_DMA_EXT_WRITE, addr, NULL, size, 0)=
;
-	if (result !=3D N_OK) {
+	if (result) {
 		dev_err(&spi->dev,
 			"Failed cmd, write block (%08x)...\n", addr);
-		return 0;
+		return result;
 	}
=20
 	/*
 	 * Data
 	 */
 	result =3D spi_data_write(wilc, buf, size);
-	if (result !=3D N_OK)
+	if (result)
 		dev_err(&spi->dev, "Failed block data write...\n");
=20
-	return 1;
+	return result;
 }
=20
 static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
@@ -792,14 +787,14 @@ static int wilc_spi_read_reg(struct wilc *wilc, u32 a=
ddr, u32 *data)
 	}
=20
 	result =3D spi_cmd_complete(wilc, cmd, addr, (u8 *)data, 4, clockless);
-	if (result !=3D N_OK) {
+	if (result) {
 		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
-		return 0;
+		return result;
 	}
=20
 	le32_to_cpus(data);
=20
-	return 1;
+	return 0;
 }
=20
 static int wilc_spi_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
@@ -808,15 +803,13 @@ static int wilc_spi_read(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 	int result;
=20
 	if (size <=3D 4)
-		return 0;
+		return -EINVAL;
=20
 	result =3D spi_cmd_complete(wilc, CMD_DMA_EXT_READ, addr, buf, size, 0);
-	if (result !=3D N_OK) {
+	if (result)
 		dev_err(&spi->dev, "Failed cmd, read block (%08x)...\n", addr);
-		return 0;
-	}
=20
-	return 1;
+	return result;
 }
=20
 /********************************************
@@ -830,7 +823,7 @@ static int wilc_spi_deinit(struct wilc *wilc)
 	/*
 	 * TODO:
 	 */
-	return 1;
+	return 0;
 }
=20
 static int wilc_spi_init(struct wilc *wilc, bool resume)
@@ -840,13 +833,14 @@ static int wilc_spi_init(struct wilc *wilc, bool resu=
me)
 	u32 reg;
 	u32 chipid;
 	static int isinit;
+	int ret;
=20
 	if (isinit) {
-		if (!wilc_spi_read_reg(wilc, 0x1000, &chipid)) {
+		ret =3D wilc_spi_read_reg(wilc, 0x1000, &chipid);
+		if (ret)
 			dev_err(&spi->dev, "Fail cmd read chip id...\n");
-			return 0;
-		}
-		return 1;
+
+		return ret;
 	}
=20
 	/*
@@ -858,7 +852,8 @@ static int wilc_spi_init(struct wilc *wilc, bool resume=
)
 	 * way to reset
 	 */
 	/* the SPI to it's initial value. */
-	if (!spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg)) {
+	ret =3D spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
+	if (ret) {
 		/*
 		 * Read failed. Try with CRC off. This might happen when module
 		 * is removed but chip isn't reset
@@ -866,24 +861,26 @@ static int wilc_spi_init(struct wilc *wilc, bool resu=
me)
 		spi_priv->crc_off =3D 1;
 		dev_err(&spi->dev,
 			"Failed read with CRC on, retrying with CRC off\n");
-		if (!spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg)) {
+		ret =3D spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
+		if (ret) {
 			/*
 			 * Read failed with both CRC on and off,
 			 * something went bad
 			 */
 			dev_err(&spi->dev, "Failed internal read protocol\n");
-			return 0;
+			return ret;
 		}
 	}
 	if (spi_priv->crc_off =3D=3D 0) {
 		reg &=3D ~0xc; /* disable crc checking */
 		reg &=3D ~0x70;
 		reg |=3D (0x5 << 4);
-		if (!spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg)) {
+		ret =3D spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg);
+		if (ret) {
 			dev_err(&spi->dev,
 				"[wilc spi %d]: Failed internal write reg\n",
 				__LINE__);
-			return 0;
+			return ret;
 		}
 		spi_priv->crc_off =3D 1;
 	}
@@ -891,14 +888,15 @@ static int wilc_spi_init(struct wilc *wilc, bool resu=
me)
 	/*
 	 * make sure can read back chip id correctly
 	 */
-	if (!wilc_spi_read_reg(wilc, 0x1000, &chipid)) {
+	ret =3D wilc_spi_read_reg(wilc, 0x1000, &chipid);
+	if (ret) {
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
-		return 0;
+		return ret;
 	}
=20
 	isinit =3D 1;
=20
-	return 1;
+	return 0;
 }
=20
 static int wilc_spi_read_size(struct wilc *wilc, u32 *size)
@@ -930,7 +928,7 @@ static int wilc_spi_sync_ext(struct wilc *wilc, int nin=
t)
=20
 	if (nint > MAX_NUM_INT) {
 		dev_err(&spi->dev, "Too many interrupts (%d)...\n", nint);
-		return 0;
+		return -EINVAL;
 	}
=20
 	spi_priv->nint =3D nint;
@@ -939,58 +937,58 @@ static int wilc_spi_sync_ext(struct wilc *wilc, int n=
int)
 	 * interrupt pin mux select
 	 */
 	ret =3D wilc_spi_read_reg(wilc, WILC_PIN_MUX_0, &reg);
-	if (!ret) {
+	if (ret) {
 		dev_err(&spi->dev, "Failed read reg (%08x)...\n",
 			WILC_PIN_MUX_0);
-		return 0;
+		return ret;
 	}
 	reg |=3D BIT(8);
 	ret =3D wilc_spi_write_reg(wilc, WILC_PIN_MUX_0, reg);
-	if (!ret) {
+	if (ret) {
 		dev_err(&spi->dev, "Failed write reg (%08x)...\n",
 			WILC_PIN_MUX_0);
-		return 0;
+		return ret;
 	}
=20
 	/*
 	 * interrupt enable
 	 */
 	ret =3D wilc_spi_read_reg(wilc, WILC_INTR_ENABLE, &reg);
-	if (!ret) {
+	if (ret) {
 		dev_err(&spi->dev, "Failed read reg (%08x)...\n",
 			WILC_INTR_ENABLE);
-		return 0;
+		return ret;
 	}
=20
 	for (i =3D 0; (i < 5) && (nint > 0); i++, nint--)
 		reg |=3D (BIT((27 + i)));
=20
 	ret =3D wilc_spi_write_reg(wilc, WILC_INTR_ENABLE, reg);
-	if (!ret) {
+	if (ret) {
 		dev_err(&spi->dev, "Failed write reg (%08x)...\n",
 			WILC_INTR_ENABLE);
-		return 0;
+		return ret;
 	}
 	if (nint) {
 		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
-		if (!ret) {
+		if (ret) {
 			dev_err(&spi->dev, "Failed read reg (%08x)...\n",
 				WILC_INTR2_ENABLE);
-			return 0;
+			return ret;
 		}
=20
 		for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
 			reg |=3D BIT(i);
=20
 		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
-		if (!ret) {
+		if (ret) {
 			dev_err(&spi->dev, "Failed write reg (%08x)...\n",
 				WILC_INTR2_ENABLE);
-			return 0;
+			return ret;
 		}
 	}
=20
-	return 1;
+	return 0;
 }
=20
 /* Global spi HIF function table */
diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index c32af7076012..b904eda42806 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -534,7 +534,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 	func =3D wilc->hif_func;
 	do {
 		ret =3D func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
-		if (!ret)
+		if (ret)
 			break;
=20
 		if ((reg & 0x1) =3D=3D 0)
@@ -548,7 +548,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 		}
 	} while (!wilc->quit);
=20
-	if (!ret)
+	if (ret)
 		goto out_release_bus;
=20
 	timeout =3D 200;
@@ -557,16 +557,16 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_=
count)
 					 WILC_VMM_TBL_RX_SHADOW_BASE,
 					 (u8 *)vmm_table,
 					 ((i + 1) * 4));
-		if (!ret)
+		if (ret)
 			break;
=20
 		ret =3D func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x2);
-		if (!ret)
+		if (ret)
 			break;
=20
 		do {
 			ret =3D func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
-			if (!ret)
+			if (ret)
 				break;
 			if ((reg >> 2) & 0x1) {
 				entries =3D ((reg >> 3) & 0x3f);
@@ -579,19 +579,19 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_=
count)
 			break;
 		}
=20
-		if (!ret)
+		if (ret)
 			break;
=20
 		if (entries =3D=3D 0) {
 			ret =3D func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
-			if (!ret)
+			if (ret)
 				break;
 			reg &=3D ~BIT(0);
 			ret =3D func->hif_write_reg(wilc, WILC_HOST_TX_CTRL, reg);
 		}
 	} while (0);
=20
-	if (!ret)
+	if (ret)
 		goto out_release_bus;
=20
 	if (entries =3D=3D 0) {
@@ -654,7 +654,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
=20
 	ret =3D func->hif_clear_int_ext(wilc, ENABLE_TX_VMM);
-	if (!ret)
+	if (ret)
 		goto out_release_bus;
=20
 	ret =3D func->hif_block_tx_ext(wilc, 0, txb, offset);
@@ -771,7 +771,7 @@ static void wilc_wlan_handle_isr_ext(struct wilc *wilc,=
 u32 int_status)
=20
 	wilc->hif_func->hif_clear_int_ext(wilc, DATA_INT_CLR | ENABLE_RX_VMM);
 	ret =3D wilc->hif_func->hif_block_rx_ext(wilc, 0, buffer, size);
-	if (!ret)
+	if (ret)
 		return;
=20
 	offset +=3D size;
@@ -832,7 +832,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, cons=
t u8 *buffer,
 			memcpy(dma_buffer, &buffer[offset], size2);
 			ret =3D wilc->hif_func->hif_block_tx(wilc, addr,
 							   dma_buffer, size2);
-			if (!ret)
+			if (ret)
 				break;
=20
 			addr +=3D size2;
@@ -841,17 +841,15 @@ int wilc_wlan_firmware_download(struct wilc *wilc, co=
nst u8 *buffer,
 		}
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
=20
-		if (!ret) {
-			ret =3D -EIO;
+		if (ret)
 			goto fail;
-		}
 	} while (offset < buffer_size);
=20
 fail:
=20
 	kfree(dma_buffer);
=20
-	return (ret < 0) ? ret : 0;
+	return ret;
 }
=20
 int wilc_wlan_start(struct wilc *wilc)
@@ -868,26 +866,26 @@ int wilc_wlan_start(struct wilc *wilc)
 	}
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
 	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_VMM_CORE_CFG, reg);
-	if (!ret) {
+	if (ret) {
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
-		return -EIO;
+		return ret;
 	}
 	reg =3D 0;
 	if (wilc->io_type =3D=3D WILC_HIF_SDIO && wilc->dev_irq_num)
 		reg |=3D WILC_HAVE_SDIO_IRQ_GPIO;
=20
 	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_1, reg);
-	if (!ret) {
+	if (ret) {
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
-		return -EIO;
+		return ret;
 	}
=20
 	wilc->hif_func->hif_sync_ext(wilc, NUM_INT_EXT);
=20
 	ret =3D wilc->hif_func->hif_read_reg(wilc, 0x1000, &chipid);
-	if (!ret) {
+	if (ret) {
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
-		return -EIO;
+		return ret;
 	}
=20
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
@@ -902,7 +900,7 @@ int wilc_wlan_start(struct wilc *wilc)
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
=20
-	return (ret < 0) ? ret : 0;
+	return ret;
 }
=20
 int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
@@ -913,33 +911,33 @@ int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif=
 *vif)
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
=20
 	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
-	if (!ret) {
+	if (ret) {
 		netdev_err(vif->ndev, "Error while reading reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return -EIO;
+		return ret;
 	}
=20
 	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
 					(reg | WILC_ABORT_REQ_BIT));
-	if (!ret) {
+	if (ret) {
 		netdev_err(vif->ndev, "Error while writing reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return -EIO;
+		return ret;
 	}
=20
 	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_FW_HOST_COMM, &reg);
-	if (!ret) {
+	if (ret) {
 		netdev_err(vif->ndev, "Error while reading reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return -EIO;
+		return ret;
 	}
 	reg =3D BIT(0);
=20
 	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_FW_HOST_COMM, reg);
-	if (!ret) {
+	if (ret) {
 		netdev_err(vif->ndev, "Error while writing reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return -EIO;
+		return ret;
 	}
=20
 	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
@@ -1112,10 +1110,11 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 m=
ode, struct wid *wids,
 	return ret;
 }
=20
-static u32 init_chip(struct net_device *dev)
+static int init_chip(struct net_device *dev)
 {
 	u32 chipid;
-	u32 reg, ret =3D 0;
+	u32 reg;
+	int ret =3D 0;
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc *wilc =3D vif->wilc;
=20
@@ -1125,18 +1124,18 @@ static u32 init_chip(struct net_device *dev)
=20
 	if ((chipid & 0xfff) !=3D 0xa0) {
 		ret =3D wilc->hif_func->hif_read_reg(wilc, 0x1118, &reg);
-		if (!ret) {
+		if (ret) {
 			netdev_err(dev, "fail read reg 0x1118\n");
 			goto release;
 		}
 		reg |=3D BIT(0);
 		ret =3D wilc->hif_func->hif_write_reg(wilc, 0x1118, reg);
-		if (!ret) {
+		if (ret) {
 			netdev_err(dev, "fail write reg 0x1118\n");
 			goto release;
 		}
 		ret =3D wilc->hif_func->hif_write_reg(wilc, 0xc0000, 0x71);
-		if (!ret) {
+		if (ret) {
 			netdev_err(dev, "fail write reg 0xc0000\n");
 			goto release;
 		}
@@ -1186,7 +1185,7 @@ int wilc_wlan_init(struct net_device *dev)
=20
 	wilc->quit =3D 0;
=20
-	if (!wilc->hif_func->hif_init(wilc, false)) {
+	if (wilc->hif_func->hif_init(wilc, false)) {
 		ret =3D -EIO;
 		goto fail;
 	}
@@ -1207,12 +1206,12 @@ int wilc_wlan_init(struct net_device *dev)
 		goto fail;
 	}
=20
-	if (!init_chip(dev)) {
+	if (init_chip(dev)) {
 		ret =3D -EIO;
 		goto fail;
 	}
=20
-	return 1;
+	return 0;
=20
 fail:
=20
--=20
2.24.0
