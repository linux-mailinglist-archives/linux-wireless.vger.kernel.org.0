Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C716C66392
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfGLB7O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:14 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:58287 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfGLB7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:13 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: FPL5W2VOOVhr/L+Z2u5DGx0SN05kThCd3CYZyhsRo7ItXsegb8LUtbeiUp8L9PArFxIg9TU54j
 oJfXtXoRSvdjil0h9Yhn2HY1pgOVBcRH36+VDl5TIqViPGgbAiryHhOS0+7CsmcEdvsCRTbJnU
 YDFHoRcNJWW2B2Se8DTEsfbyroXNtIXAs+TMSN1WXKQYXVB4ADj4pHQhgLi8hZ02rvQ30A6RWt
 PDAA+j7UJasCulbKxNGNp6Ebd7cFwTyZCs7ZfNEjo4Oq+rJccMao1GTf2/NruNHOGcK9WOH/NC
 E0s=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="40317316"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtTiAbN8OhzmPdLUMQc4FuUm5XB0PGb0QK+49L0cwJxLn5o5FNmfLRi5zVWY4nSFWbztHwP1RZarbHkBcQgKe9D+Zr3qW8P7kQiRDcJS1x65O0Q9LDTlpecQU6+bokVEfyjo6VEkq3mpZCGRnnThvYqbQTh5lloKAXFLW/04hlGGWRUoyU5vNO+vPQ5XKo2fRTtfuwzkzZ9h5SygamLf2iZ/nNH8cYBogTh6QzRT7bGiDj2wWpJON7y6G2SNVZN67ifDLvZiBecCybZeGliIplY30VPxuZba3sCRfLb6BuCLd15LPYuu8eq0MPeZ7bF9NWRfzf+FObHP1knVGuX0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJbC7tyQZKUbtA4+sGrzekN+S9Xk5m7EGKvQEeMFt4Y=;
 b=DcC1k7vvJw+YYnkOzJ9zrNZuGIxoL+9XYryCQzB+wBAUx6GSSR1Ad2FA1fEHAvcNrC3XN6pGYrVJRMGrlOdQ5vT3dYHBDcSmDgoR4Z+NBBdZk1ccOsweYBZLdRabCskNU86DEKiKDv/QK/3BOXGx67nUPGdBJJHjNJLVKvwOXrAlHZY9bJ/1te3fGrlKoOytQhQolSFM0ObbUsfI2or8lcJ/K6v5SN7cx4NlDJlrGAzcQUxjUdwsrDS8K+CK/lSAiMqIVQYh3MEf4+sITtxcOaYj06rEcgeFTxYDwzY5yAJaKAF+bAUfEc/G+3MvSMxgDPPLiJo0R2M0NJHUANZ+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJbC7tyQZKUbtA4+sGrzekN+S9Xk5m7EGKvQEeMFt4Y=;
 b=Wx6etysDIlk9thEUFj0ZOeF9nuIn9J7tL+Acc6w0WoBIkjgXA+0yg9UA8aeB7QX5IvmPnZ/9epHnbvoophO+Bvp9b71BVdhZ/EODhVh8IKb3f1JsR8GNoQcuYBHhqmBBdxPqE4vBZZ7YISGgD3CfswAO+QoYlTKosAeTi+A9kZk=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:09 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:09 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 09/16] wilc1000: add wilc_netdev.c
Thread-Topic: [PATCH v2 09/16] wilc1000: add wilc_netdev.c
Thread-Index: AQHVOFVken/RoH7uPk21nD7tKVFzzQ==
Date:   Fri, 12 Jul 2019 01:59:09 +0000
Message-ID: <1562896697-8002-10-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1974e7f0-3635-4317-6ae0-08d7066c86f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB1425E486C31809D6C1CFD8D9E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:24;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(53946003)(5640700003)(107886003)(68736007)(99286004)(30864003)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y9EgC1yJeDY1+pUMUB39HVbE+98s8SjhJ72Kwlrv7EZDpKkrf+IV44idPn0hcOLVaywiMgXYxQC4+rTTI0oe2AEJCQ1lw3LjPM/YXgvXEL7iKjYvsXmnv9v7BtSL4wTgO4D+wzIf7crJXslJoM+g2imqT6YnIR4skPQo5eN15IIhNRYnjvA04y+40FLPoqQiO31xXoMuJk+PG1szTt+9ToFQdLi/FaJIdjmEd8aa2IK5FvjsZTDwrG4ITfW7fBjuaTU/cql6p3fNBBEh00WZrGIjqdBpRTEaIDKD+YtEeTwYFhToN4Q1fXzARgOp+9HbxDg0GXa+GuT9PTlJ43fAaQvsteCXET41lPGdnCcoe/MFkrUJxfMzTZarazltoho39jiMLvXfwtjQaw209c+2jo8tOEQ3RFbZhxw2tl3xous=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1974e7f0-3635-4317-6ae0-08d7066c86f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:09.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000/wilc_netdev.c' to
'drivers/net/wireless/microchip/wilc1000/wilc_netdev.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wilc_netdev.c  | 997 +++++++++++++++++=
++++
 1 file changed, 997 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_netdev.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_netdev.c b/driver=
s/net/wireless/microchip/wilc1000/wilc_netdev.c
new file mode 100644
index 0000000..565e2b5
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_netdev.c
@@ -0,0 +1,997 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/irq.h>
+#include <linux/kthread.h>
+#include <linux/firmware.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+
+#include "wilc_wfi_cfgoperations.h"
+
+#define WILC_MULTICAST_TABLE_SIZE	8
+
+static irqreturn_t isr_uh_routine(int irq, void *user_data)
+{
+	struct net_device *dev =3D user_data;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	if (wilc->close) {
+		netdev_err(dev, "Can't handle UH interrupt\n");
+		return IRQ_HANDLED;
+	}
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t isr_bh_routine(int irq, void *userdata)
+{
+	struct net_device *dev =3D userdata;
+	struct wilc_vif *vif =3D netdev_priv(userdata);
+	struct wilc *wilc =3D vif->wilc;
+
+	if (wilc->close) {
+		netdev_err(dev, "Can't handle BH interrupt\n");
+		return IRQ_HANDLED;
+	}
+
+	wilc_handle_isr(wilc);
+
+	return IRQ_HANDLED;
+}
+
+static int init_irq(struct net_device *dev)
+{
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wl =3D vif->wilc;
+
+	ret =3D gpiod_direction_input(wl->gpio_irq);
+	if (ret) {
+		netdev_err(dev, "could not obtain gpio for WILC_INTR\n");
+		return ret;
+	}
+
+	wl->dev_irq_num =3D gpiod_to_irq(wl->gpio_irq);
+
+	ret =3D request_threaded_irq(wl->dev_irq_num, isr_uh_routine,
+				   isr_bh_routine,
+				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				   "WILC_IRQ", dev);
+	if (ret < 0)
+		netdev_err(dev, "Failed to request IRQ\n");
+	else
+		netdev_dbg(dev, "IRQ request succeeded IRQ-NUM=3D %d\n",
+			   wl->dev_irq_num);
+
+	return ret;
+}
+
+static void deinit_irq(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	/* Deinitialize IRQ */
+	if (wilc->dev_irq_num)
+		free_irq(wilc->dev_irq_num, wilc);
+}
+
+void wilc_mac_indicate(struct wilc *wilc)
+{
+	s8 status;
+
+	wilc_wlan_cfg_get_val(wilc, WID_STATUS, &status, 1);
+	if (wilc->mac_status =3D=3D WILC_MAC_STATUS_INIT) {
+		wilc->mac_status =3D status;
+		complete(&wilc->sync_event);
+	} else {
+		wilc->mac_status =3D status;
+	}
+}
+
+static struct net_device *get_if_handler(struct wilc *wilc, u8 *mac_header=
)
+{
+	u8 *bssid, *bssid1;
+	int i =3D 0;
+	struct net_device *ndev =3D NULL;
+
+	bssid =3D mac_header + 10;
+	bssid1 =3D mac_header + 4;
+
+	mutex_lock(&wilc->vif_mutex);
+	for (i =3D 0; i < wilc->vif_num; i++) {
+		if (wilc->vif[i]->mode =3D=3D WILC_STATION_MODE)
+			if (ether_addr_equal_unaligned(bssid,
+						       wilc->vif[i]->bssid)) {
+				ndev =3D wilc->vif[i]->ndev;
+				goto out;
+			}
+		if (wilc->vif[i]->mode =3D=3D WILC_AP_MODE)
+			if (ether_addr_equal_unaligned(bssid1,
+						       wilc->vif[i]->bssid)) {
+				ndev =3D wilc->vif[i]->ndev;
+				goto out;
+			}
+	}
+out:
+	mutex_unlock(&wilc->vif_mutex);
+	return ndev;
+}
+
+void wilc_wlan_set_bssid(struct net_device *wilc_netdev, u8 *bssid, u8 mod=
e)
+{
+	struct wilc_vif *vif =3D netdev_priv(wilc_netdev);
+
+	if (bssid)
+		ether_addr_copy(vif->bssid, bssid);
+	else
+		eth_zero_addr(vif->bssid);
+
+	vif->mode =3D mode;
+}
+
+int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc)
+{
+	u8 i =3D 0;
+	u8 ret_val =3D 0;
+
+	for (i =3D 0; i < wilc->vif_num; i++)
+		if (!is_zero_ether_addr(wilc->vif[i]->bssid))
+			ret_val++;
+
+	return ret_val;
+}
+
+static int wilc_txq_task(void *vp)
+{
+	int ret;
+	u32 txq_count;
+	struct wilc *wl =3D vp;
+
+	complete(&wl->txq_thread_started);
+	while (1) {
+		wait_for_completion(&wl->txq_event);
+
+		if (wl->close) {
+			complete(&wl->txq_thread_started);
+
+			while (!kthread_should_stop())
+				schedule();
+			break;
+		}
+		do {
+			ret =3D wilc_wlan_handle_txq(wl, &txq_count);
+			if (txq_count < FLOW_CONTROL_LOWER_THRESHOLD) {
+				int i;
+				struct wilc_vif *ifc;
+
+				mutex_lock(&wl->vif_mutex);
+				for (i =3D 0; i < wl->vif_num; i++) {
+					ifc =3D wl->vif[i];
+					if (ifc->mac_opened && ifc->ndev)
+						netif_wake_queue(ifc->ndev);
+				}
+				mutex_unlock(&wl->vif_mutex);
+			}
+		} while (ret =3D=3D -ENOBUFS && !wl->close);
+	}
+	return 0;
+}
+
+static int wilc_wlan_get_firmware(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	int chip_id, ret =3D 0;
+	const struct firmware *wilc_firmware;
+	char *firmware;
+
+	chip_id =3D wilc_get_chipid(wilc, false);
+
+	if (chip_id < 0x1003a0)
+		firmware =3D FIRMWARE_1002;
+	else
+		firmware =3D FIRMWARE_1003;
+
+	netdev_info(dev, "loading firmware %s\n", firmware);
+
+	if (request_firmware(&wilc_firmware, firmware, wilc->dev) !=3D 0) {
+		netdev_err(dev, "%s - firmware not available\n", firmware);
+		ret =3D -1;
+		goto fail;
+	}
+	wilc->firmware =3D wilc_firmware;
+
+fail:
+
+	return ret;
+}
+
+static int wilc_start_firmware(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	int ret =3D 0;
+
+	ret =3D wilc_wlan_start(wilc);
+	if (ret < 0)
+		return ret;
+
+	if (!wait_for_completion_timeout(&wilc->sync_event,
+					 msecs_to_jiffies(5000)))
+		return -ETIME;
+
+	return 0;
+}
+
+static int wilc1000_firmware_download(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	int ret =3D 0;
+
+	if (!wilc->firmware) {
+		netdev_err(dev, "Firmware buffer is NULL\n");
+		return -ENOBUFS;
+	}
+
+	ret =3D wilc_wlan_firmware_download(wilc, wilc->firmware->data,
+					  wilc->firmware->size);
+	if (ret < 0)
+		return ret;
+
+	release_firmware(wilc->firmware);
+	wilc->firmware =3D NULL;
+
+	netdev_dbg(dev, "Download Succeeded\n");
+
+	return 0;
+}
+
+static int wilc_init_fw_config(struct net_device *dev, struct wilc_vif *vi=
f)
+{
+	struct wilc_priv *priv =3D &vif->priv;
+	struct host_if_drv *hif_drv;
+	u8 b;
+	u16 hw;
+	u32 w;
+
+	netdev_dbg(dev, "Start configuring Firmware\n");
+	hif_drv =3D (struct host_if_drv *)priv->hif_drv;
+	netdev_dbg(dev, "Host =3D %p\n", hif_drv);
+
+	w =3D vif->iftype;
+	cpu_to_le32s(&w);
+	if (!wilc_wlan_cfg_set(vif, 1, WID_SET_OPERATION_MODE, (u8 *)&w, 4,
+			       0, 0))
+		goto fail;
+
+	b =3D WILC_FW_BSS_TYPE_INFRA;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_BSS_TYPE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_TX_RATE_AUTO;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_CURRENT_TX_RATE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_OPER_MODE_G_MIXED_11B_2;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11G_OPERATING_MODE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_PREAMBLE_SHORT;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_PREAMBLE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_11N_PROT_AUTO;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_PROT_MECH, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_ACTIVE_SCAN;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_SCAN_TYPE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_SITE_SURVEY_OFF;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_SITE_SURVEY, &b, 1, 0, 0))
+		goto fail;
+
+	hw =3D 0xffff;
+	cpu_to_le16s(&hw);
+	if (!wilc_wlan_cfg_set(vif, 0, WID_RTS_THRESHOLD, (u8 *)&hw, 2, 0, 0))
+		goto fail;
+
+	hw =3D 2346;
+	cpu_to_le16s(&hw);
+	if (!wilc_wlan_cfg_set(vif, 0, WID_FRAG_THRESHOLD, (u8 *)&hw, 2, 0, 0))
+		goto fail;
+
+	b =3D 0;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_BCAST_SSID, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 1;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_QOS_ENABLE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_NO_POWERSAVE;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_POWER_MANAGEMENT, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_SEC_NO;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11I_MODE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_AUTH_OPEN_SYSTEM;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_AUTH_TYPE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 3;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_LISTEN_INTERVAL, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 3;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_DTIM_PERIOD, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_ACK_POLICY_NORMAL;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_ACK_POLICY, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 0;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_USER_CONTROL_ON_TX_POWER, &b, 1,
+			       0, 0))
+		goto fail;
+
+	b =3D 48;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_TX_POWER_LEVEL_11A, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 28;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_TX_POWER_LEVEL_11B, &b, 1, 0, 0))
+		goto fail;
+
+	hw =3D 100;
+	cpu_to_le16s(&hw);
+	if (!wilc_wlan_cfg_set(vif, 0, WID_BEACON_INTERVAL, (u8 *)&hw, 2, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_REKEY_POLICY_DISABLE;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_REKEY_POLICY, &b, 1, 0, 0))
+		goto fail;
+
+	w =3D 84600;
+	cpu_to_le32s(&w);
+	if (!wilc_wlan_cfg_set(vif, 0, WID_REKEY_PERIOD, (u8 *)&w, 4, 0, 0))
+		goto fail;
+
+	w =3D 500;
+	cpu_to_le32s(&w);
+	if (!wilc_wlan_cfg_set(vif, 0, WID_REKEY_PACKET_COUNT, (u8 *)&w, 4, 0,
+			       0))
+		goto fail;
+
+	b =3D 1;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_SHORT_SLOT_ALLOWED, &b, 1, 0,
+			       0))
+		goto fail;
+
+	b =3D WILC_FW_ERP_PROT_SELF_CTS;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_ERP_PROT_TYPE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 1;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_ENABLE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_11N_OP_MODE_HT_MIXED;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_OPERATING_MODE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 1;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_TXOP_PROT_DISABLE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D WILC_FW_OBBS_NONHT_DETECT_PROTECT_REPORT;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_OBSS_NONHT_DETECTION, &b, 1,
+			       0, 0))
+		goto fail;
+
+	b =3D WILC_FW_HT_PROT_RTS_CTS_NONHT;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_HT_PROT_TYPE, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 0;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_RIFS_PROT_ENABLE, &b, 1, 0,
+			       0))
+		goto fail;
+
+	b =3D 7;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_CURRENT_TX_MCS, &b, 1, 0, 0))
+		goto fail;
+
+	b =3D 1;
+	if (!wilc_wlan_cfg_set(vif, 0, WID_11N_IMMEDIATE_BA_ENABLED, &b, 1,
+			       1, 1))
+		goto fail;
+
+	return 0;
+
+fail:
+	return -1;
+}
+
+static void wlan_deinit_locks(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	mutex_destroy(&wilc->hif_cs);
+	mutex_destroy(&wilc->rxq_cs);
+	mutex_destroy(&wilc->cfg_cmd_lock);
+	mutex_destroy(&wilc->txq_add_to_head_cs);
+	mutex_destroy(&wilc->vif_mutex);
+}
+
+static void wlan_deinitialize_threads(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wl =3D vif->wilc;
+
+	wl->close =3D 1;
+
+	complete(&wl->txq_event);
+
+	if (wl->txq_thread) {
+		kthread_stop(wl->txq_thread);
+		wl->txq_thread =3D NULL;
+	}
+}
+
+static void wilc_wlan_deinitialize(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wl =3D vif->wilc;
+
+	if (!wl) {
+		netdev_err(dev, "wl is NULL\n");
+		return;
+	}
+
+	if (wl->initialized) {
+		netdev_info(dev, "Deinitializing wilc1000...\n");
+
+		if (!wl->dev_irq_num &&
+		    wl->hif_func->disable_interrupt) {
+			mutex_lock(&wl->hif_cs);
+			wl->hif_func->disable_interrupt(wl);
+			mutex_unlock(&wl->hif_cs);
+		}
+		complete(&wl->txq_event);
+
+		wlan_deinitialize_threads(dev);
+		deinit_irq(dev);
+
+		wilc_wlan_stop(wl);
+		wilc_wlan_cleanup(dev);
+		wlan_deinit_locks(dev);
+
+		wl->initialized =3D false;
+
+		netdev_dbg(dev, "wilc1000 deinitialization Done\n");
+	} else {
+		netdev_dbg(dev, "wilc1000 is not initialized\n");
+	}
+}
+
+static int wlan_initialize_threads(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	wilc->txq_thread =3D kthread_run(wilc_txq_task, (void *)wilc,
+				       "K_TXQ_TASK");
+	if (IS_ERR(wilc->txq_thread)) {
+		netdev_err(dev, "couldn't create TXQ thread\n");
+		wilc->close =3D 0;
+		return PTR_ERR(wilc->txq_thread);
+	}
+	wait_for_completion(&wilc->txq_thread_started);
+
+	return 0;
+}
+
+static int dev_state_ev_handler(struct notifier_block *this,
+				unsigned long event, void *ptr);
+static struct notifier_block g_dev_notifier =3D {
+	.notifier_call =3D dev_state_ev_handler
+};
+
+static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *v=
if)
+{
+	int ret =3D 0;
+	struct wilc *wl =3D vif->wilc;
+
+	if (!wl->initialized) {
+		wl->mac_status =3D WILC_MAC_STATUS_INIT;
+		wl->close =3D 0;
+
+		ret =3D wilc_wlan_init(dev);
+		if (ret < 0)
+			return -EIO;
+
+		ret =3D wlan_initialize_threads(dev);
+		if (ret < 0) {
+			ret =3D -EIO;
+			goto fail_wilc_wlan;
+		}
+
+		if (wl->gpio_irq && init_irq(dev)) {
+			ret =3D -EIO;
+			goto fail_threads;
+		}
+
+		if (!wl->dev_irq_num &&
+		    wl->hif_func->enable_interrupt &&
+		    wl->hif_func->enable_interrupt(wl)) {
+			ret =3D -EIO;
+			goto fail_irq_init;
+		}
+
+		if (wilc_wlan_get_firmware(dev)) {
+			ret =3D -EIO;
+			goto fail_irq_enable;
+		}
+
+		ret =3D wilc1000_firmware_download(dev);
+		if (ret < 0) {
+			ret =3D -EIO;
+			goto fail_irq_enable;
+		}
+
+		ret =3D wilc_start_firmware(dev);
+		if (ret < 0) {
+			ret =3D -EIO;
+			goto fail_irq_enable;
+		}
+
+		if (wilc_wlan_cfg_get(vif, 1, WID_FIRMWARE_VERSION, 1, 0)) {
+			int size;
+			char firmware_ver[20];
+
+			size =3D wilc_wlan_cfg_get_val(wl, WID_FIRMWARE_VERSION,
+						     firmware_ver,
+						     sizeof(firmware_ver));
+			firmware_ver[size] =3D '\0';
+			netdev_dbg(dev, "Firmware Ver =3D %s\n", firmware_ver);
+		}
+		ret =3D wilc_init_fw_config(dev, vif);
+
+		if (ret < 0) {
+			netdev_err(dev, "Failed to configure firmware\n");
+			ret =3D -EIO;
+			goto fail_fw_start;
+		}
+		register_inetaddr_notifier(&g_dev_notifier);
+		wl->initialized =3D true;
+		return 0;
+
+fail_fw_start:
+		wilc_wlan_stop(wl);
+
+fail_irq_enable:
+		if (!wl->dev_irq_num &&
+		    wl->hif_func->disable_interrupt)
+			wl->hif_func->disable_interrupt(wl);
+fail_irq_init:
+		if (wl->dev_irq_num)
+			deinit_irq(dev);
+fail_threads:
+		wlan_deinitialize_threads(dev);
+fail_wilc_wlan:
+		wilc_wlan_cleanup(dev);
+		netdev_err(dev, "WLAN initialization FAILED\n");
+	} else {
+		netdev_dbg(dev, "wilc1000 already initialized\n");
+	}
+	return ret;
+}
+
+static int mac_init_fn(struct net_device *ndev)
+{
+	netif_start_queue(ndev);
+	netif_stop_queue(ndev);
+
+	return 0;
+}
+
+static int wilc_mac_open(struct net_device *ndev)
+{
+	struct wilc_vif *vif =3D netdev_priv(ndev);
+	struct wilc *wl =3D vif->wilc;
+	struct wilc_priv *priv =3D wdev_priv(vif->ndev->ieee80211_ptr);
+	unsigned char mac_add[ETH_ALEN] =3D {0};
+	int ret =3D 0;
+
+	if (!wl || !wl->dev) {
+		netdev_err(ndev, "device not ready\n");
+		return -ENODEV;
+	}
+
+	netdev_dbg(ndev, "MAC OPEN[%p]\n", ndev);
+
+	ret =3D wilc_init_host_int(ndev);
+	if (ret < 0)
+		return ret;
+
+	ret =3D wilc_wlan_initialize(ndev, vif);
+	if (ret < 0) {
+		wilc_deinit_host_int(ndev);
+		return ret;
+	}
+
+	wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif), vif->iftype,
+				 vif->idx);
+	wilc_set_operation_mode(vif, vif->iftype);
+
+	wilc_get_mac_address(vif, mac_add);
+	netdev_dbg(ndev, "Mac address: %pM\n", mac_add);
+	ether_addr_copy(ndev->dev_addr, mac_add);
+
+	if (!is_valid_ether_addr(ndev->dev_addr)) {
+		netdev_err(ndev, "Wrong MAC address\n");
+		wilc_deinit_host_int(ndev);
+		wilc_wlan_deinitialize(ndev);
+		return -EINVAL;
+	}
+
+	wilc_mgmt_frame_register(vif->ndev->ieee80211_ptr->wiphy,
+				 vif->ndev->ieee80211_ptr,
+				 vif->frame_reg[0].type,
+				 vif->frame_reg[0].reg);
+	wilc_mgmt_frame_register(vif->ndev->ieee80211_ptr->wiphy,
+				 vif->ndev->ieee80211_ptr,
+				 vif->frame_reg[1].type,
+				 vif->frame_reg[1].reg);
+	netif_wake_queue(ndev);
+	wl->open_ifcs++;
+	priv->p2p.local_random =3D 0x01;
+	vif->mac_opened =3D 1;
+	return 0;
+}
+
+static struct net_device_stats *mac_stats(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+
+	return &vif->netstats;
+}
+
+static void wilc_set_multicast_list(struct net_device *dev)
+{
+	struct netdev_hw_addr *ha;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	int i;
+	u8 *mc_list;
+	u8 *cur_mc;
+
+	if (dev->flags & IFF_PROMISC)
+		return;
+
+	if (dev->flags & IFF_ALLMULTI ||
+	    dev->mc.count > WILC_MULTICAST_TABLE_SIZE) {
+		wilc_setup_multicast_filter(vif, 0, 0, NULL);
+		return;
+	}
+
+	if (dev->mc.count =3D=3D 0) {
+		wilc_setup_multicast_filter(vif, 1, 0, NULL);
+		return;
+	}
+
+	mc_list =3D kmalloc_array(dev->mc.count, ETH_ALEN, GFP_ATOMIC);
+	if (!mc_list)
+		return;
+
+	cur_mc =3D mc_list;
+	i =3D 0;
+	netdev_for_each_mc_addr(ha, dev) {
+		memcpy(cur_mc, ha->addr, ETH_ALEN);
+		netdev_dbg(dev, "Entry[%d]: %pM\n", i, cur_mc);
+		i++;
+		cur_mc +=3D ETH_ALEN;
+	}
+
+	if (wilc_setup_multicast_filter(vif, 1, dev->mc.count, mc_list))
+		kfree(mc_list);
+}
+
+static void wilc_tx_complete(void *priv, int status)
+{
+	struct tx_complete_data *pv_data =3D priv;
+
+	dev_kfree_skb(pv_data->skb);
+	kfree(pv_data);
+}
+
+netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct wilc_vif *vif =3D netdev_priv(ndev);
+	struct wilc *wilc =3D vif->wilc;
+	struct tx_complete_data *tx_data =3D NULL;
+	int queue_count;
+
+	if (skb->dev !=3D ndev) {
+		netdev_err(ndev, "Packet not destined to this device\n");
+		return 0;
+	}
+
+	tx_data =3D kmalloc(sizeof(*tx_data), GFP_ATOMIC);
+	if (!tx_data) {
+		dev_kfree_skb(skb);
+		netif_wake_queue(ndev);
+		return 0;
+	}
+
+	tx_data->buff =3D skb->data;
+	tx_data->size =3D skb->len;
+	tx_data->skb  =3D skb;
+
+	vif->netstats.tx_packets++;
+	vif->netstats.tx_bytes +=3D tx_data->size;
+	queue_count =3D wilc_wlan_txq_add_net_pkt(ndev, (void *)tx_data,
+						tx_data->buff, tx_data->size,
+						wilc_tx_complete);
+
+	if (queue_count > FLOW_CONTROL_UPPER_THRESHOLD) {
+		int i;
+
+		mutex_lock(&wilc->vif_mutex);
+		for (i =3D 0; i < wilc->vif_num; i++) {
+			if (wilc->vif[i]->mac_opened)
+				netif_stop_queue(wilc->vif[i]->ndev);
+		}
+		mutex_unlock(&wilc->vif_mutex);
+	}
+
+	return 0;
+}
+
+static int wilc_mac_close(struct net_device *ndev)
+{
+	struct wilc_vif *vif =3D netdev_priv(ndev);
+	struct wilc *wl =3D vif->wilc;
+
+	netdev_dbg(ndev, "Mac close\n");
+
+	if (wl->open_ifcs > 0)
+		wl->open_ifcs--;
+	else
+		return 0;
+
+	if (vif->ndev) {
+		netif_stop_queue(vif->ndev);
+
+		wilc_deinit_host_int(vif->ndev);
+	}
+
+	if (wl->open_ifcs =3D=3D 0) {
+		netdev_dbg(ndev, "Deinitializing wilc1000\n");
+		wl->close =3D 1;
+		unregister_inetaddr_notifier(&g_dev_notifier);
+		wilc_wlan_deinitialize(ndev);
+	}
+
+	vif->mac_opened =3D 0;
+
+	return 0;
+}
+
+void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
+		       u32 pkt_offset)
+{
+	unsigned int frame_len =3D 0;
+	int stats;
+	unsigned char *buff_to_send =3D NULL;
+	struct sk_buff *skb;
+	struct net_device *wilc_netdev;
+	struct wilc_vif *vif;
+
+	if (!wilc)
+		return;
+
+	wilc_netdev =3D get_if_handler(wilc, buff);
+	if (!wilc_netdev)
+		return;
+
+	buff +=3D pkt_offset;
+	vif =3D netdev_priv(wilc_netdev);
+
+	if (size > 0) {
+		frame_len =3D size;
+		buff_to_send =3D buff;
+
+		skb =3D dev_alloc_skb(frame_len);
+		if (!skb)
+			return;
+
+		skb->dev =3D wilc_netdev;
+
+		skb_put_data(skb, buff_to_send, frame_len);
+
+		skb->protocol =3D eth_type_trans(skb, wilc_netdev);
+		vif->netstats.rx_packets++;
+		vif->netstats.rx_bytes +=3D frame_len;
+		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
+		stats =3D netif_rx(skb);
+		netdev_dbg(wilc_netdev, "netif_rx ret value is: %d\n", stats);
+	}
+}
+
+void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size)
+{
+	int i =3D 0;
+	struct wilc_vif *vif;
+
+	mutex_lock(&wilc->vif_mutex);
+	for (i =3D 0; i < wilc->vif_num; i++) {
+		u16 type =3D le16_to_cpup((__le16 *)buff);
+
+		vif =3D netdev_priv(wilc->vif[i]->ndev);
+		if ((type =3D=3D vif->frame_reg[0].type && vif->frame_reg[0].reg) ||
+		    (type =3D=3D vif->frame_reg[1].type && vif->frame_reg[1].reg)) {
+			wilc_wfi_p2p_rx(vif, buff, size);
+			break;
+		}
+
+		if (vif->monitor_flag) {
+			wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
+			break;
+		}
+	}
+	mutex_unlock(&wilc->vif_mutex);
+}
+
+static const struct net_device_ops wilc_netdev_ops =3D {
+	.ndo_init =3D mac_init_fn,
+	.ndo_open =3D wilc_mac_open,
+	.ndo_stop =3D wilc_mac_close,
+	.ndo_start_xmit =3D wilc_mac_xmit,
+	.ndo_get_stats =3D mac_stats,
+	.ndo_set_rx_mode  =3D wilc_set_multicast_list,
+};
+
+static int dev_state_ev_handler(struct notifier_block *this,
+				unsigned long event, void *ptr)
+{
+	struct in_ifaddr *dev_iface =3D ptr;
+	struct wilc_priv *priv;
+	struct host_if_drv *hif_drv;
+	struct net_device *dev;
+	struct wilc_vif *vif;
+
+	if (!dev_iface || !dev_iface->ifa_dev || !dev_iface->ifa_dev->dev)
+		return NOTIFY_DONE;
+
+	dev  =3D (struct net_device *)dev_iface->ifa_dev->dev;
+	if (dev->netdev_ops !=3D &wilc_netdev_ops)
+		return NOTIFY_DONE;
+
+	if (!dev->ieee80211_ptr || !dev->ieee80211_ptr->wiphy)
+		return NOTIFY_DONE;
+
+	vif =3D netdev_priv(dev);
+	priv =3D &vif->priv;
+
+	hif_drv =3D (struct host_if_drv *)priv->hif_drv;
+
+	switch (event) {
+	case NETDEV_UP:
+		if (vif->iftype =3D=3D WILC_STATION_MODE ||
+		    vif->iftype =3D=3D WILC_CLIENT_MODE) {
+			hif_drv->ifc_up =3D 1;
+			vif->obtaining_ip =3D false;
+			del_timer(&vif->during_ip_timer);
+		}
+
+		if (vif->wilc->enable_ps)
+			wilc_set_power_mgmt(vif, 1, 0);
+
+		break;
+
+	case NETDEV_DOWN:
+		if (vif->iftype =3D=3D WILC_STATION_MODE ||
+		    vif->iftype =3D=3D WILC_CLIENT_MODE) {
+			hif_drv->ifc_up =3D 0;
+			vif->obtaining_ip =3D false;
+			wilc_set_power_mgmt(vif, 0, 0);
+		}
+
+		wilc_resolve_disconnect_aberration(vif);
+
+		break;
+
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+void wilc_netdev_cleanup(struct wilc *wilc)
+{
+	int i;
+
+	if (!wilc)
+		return;
+
+	if (wilc->firmware) {
+		release_firmware(wilc->firmware);
+		wilc->firmware =3D NULL;
+	}
+
+	for (i =3D 0; i < wilc->vif_num; i++) {
+		if (wilc->vif[i] && wilc->vif[i]->ndev)
+			unregister_netdev(wilc->vif[i]->ndev);
+	}
+
+	wilc_wfi_deinit_mon_interface(wilc, false);
+	flush_workqueue(wilc->hif_workqueue);
+	destroy_workqueue(wilc->hif_workqueue);
+	wilc_wlan_cfg_deinit(wilc);
+	kfree(wilc->bus_data);
+	wiphy_unregister(wilc->wiphy);
+	wiphy_free(wilc->wiphy);
+}
+EXPORT_SYMBOL_GPL(wilc_netdev_cleanup);
+
+struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
+				      int vif_type, enum nl80211_iftype type,
+				      bool rtnl_locked)
+{
+	struct net_device *ndev;
+	struct wilc_vif *vif;
+	int ret;
+
+	ndev =3D alloc_etherdev(sizeof(*vif));
+	if (!ndev)
+		return ERR_PTR(-ENOMEM);
+
+	vif =3D netdev_priv(ndev);
+	ndev->ieee80211_ptr =3D &vif->priv.wdev;
+	strcpy(ndev->name, name);
+	vif->wilc =3D wl;
+	vif->ndev =3D ndev;
+	ndev->ml_priv =3D vif;
+
+	ndev->netdev_ops =3D &wilc_netdev_ops;
+
+	SET_NETDEV_DEV(ndev, wiphy_dev(wl->wiphy));
+
+	vif->priv.wdev.wiphy =3D wl->wiphy;
+	vif->priv.wdev.netdev =3D ndev;
+	vif->priv.wdev.iftype =3D type;
+	vif->priv.dev =3D ndev;
+
+	if (rtnl_locked)
+		ret =3D register_netdevice(ndev);
+	else
+		ret =3D register_netdev(ndev);
+
+	if (ret) {
+		free_netdev(ndev);
+		return ERR_PTR(-EFAULT);
+	}
+
+	ndev->needs_free_netdev =3D true;
+	vif->iftype =3D vif_type;
+	vif->wilc->vif[wl->vif_num] =3D vif;
+	vif->idx =3D wl->vif_num;
+	wl->vif_num +=3D 1;
+	vif->mac_opened =3D 0;
+	return vif;
+}
+
+MODULE_LICENSE("GPL");
--=20
2.7.4

