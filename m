Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C60516BB10
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgBYHlk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:40 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61731 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgBYHlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:40 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 2+nx0anamAiQX0DIpu+eVaysLnnY/BtTPVAypQPOwOp2jshvHVoI1Hlo0ppJIzkx+rUM/utLLE
 xBOy93/QBJj91x/TiOQB4WBXOph3bObUr+brmhf2dF/Fmj9akzDcHwEMz1QM+apcj5/vraymXs
 lxG8yKsjHreZ7vnjest7KntV5a9gXRNcsracMWjw2xtkSfB9SEbBaOGMDrTu4wJ2YxBy5AY0fQ
 fm0nWEsFhhlt8UvxZ7nBe87q5Nqd58s/926Xk2JptobWWTn1MiAsQbiZPTL9ZaFR3D290Tjh2h
 NSY=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="66616055"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 00:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoX5mA1JGSqBk/E3aqo6IvTHmA9bEpybnAaaifwD6CK5NO2TPomMpKGJNyCNhtKZefWkUSKNAuyI6+p+ODo/y4iX9RnlEUPyGfZsy7b+plx5CntCdPBvPeVOWYXW7vvgtzF3otCEsX0JPejbE8Y8ohCJPm0gfJEFMdqG+FhoBUk4OieUCoM2ppPXW7KnNEJiLrP4CV5GNLZEjfeipVhbZ1W9sRL9uzkBPzKLZjV+dLPfhGOVQSzN7NgqkhXJ1kyzz+agax6h/QBqRCNA58wnLBIWwmxPaIucnaMCYW0uOGJXa9Qx7sDUmeKRdt5jzkB4m4afQEz2ai9RmVTDRfI0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ3cg/rd41M024njyz8CsLkIsD0Zv9pkdOQge4UvJTI=;
 b=GG14khbBIfm8OtaAiTh/7F4yDxcCkHBrp7uq70yZs/qMQUbIZ2bA6FZSYr0JI5NHRpfrZn3SzB9v1hxAtvv+xIXY+1pfq5x4C3b4wdWQCxe9oEC5tLaht2TMbsUtwHkEC0kXDTH0XOwZWk/fh1GDO6RD4Qp1uWdAWaO7bYKH9BEnvLJGWOJ4b1nhzrpIat603j28lcAx0KEFgqK3uy862v7UU1Hu/bKsyNISccdoSXTbIi1THcS/bjJj+N7Q6tDtmwd3rHvFcVBQNSINuwImqiyBP4BVABHbZv70C0nhoLq294fb+XnKf/eB+InSSy+j1dqCgA83c/YmrD30eKcgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ3cg/rd41M024njyz8CsLkIsD0Zv9pkdOQge4UvJTI=;
 b=ke9wFTAK+jJWHoYRdrela8DOhHsQIvsLjqnZ4wJAQ2GWa3pZ0Tql62+o8tmeAWBrNP1c/F65vFLQDkFDqM212cDqMAyYsv4n3ew+EmdcqWVuFUXhCaEYGp4NLjBnZMjxflNAg5FKbw5XtaAl+EmnFXhIGYvPEi1Zb5XRWi+AFB4=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 07:41:15 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:15 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 09/18] wilc1000: add netdev.c
Thread-Topic: [PATCH v3 09/18] wilc1000: add netdev.c
Thread-Index: AQHV6671hff8+YG/t0+whqel75SJnQ==
Date:   Tue, 25 Feb 2020 07:41:15 +0000
Message-ID: <20200225074105.7740-10-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c64f2968-f1ec-490d-e5a9-08d7b9c61842
x-ms-traffictypediagnostic: BN6PR11MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1875C39C2AF34AF8C6AC2FC3E3ED0@BN6PR11MB1875.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:47;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(2906002)(316002)(2616005)(54906003)(86362001)(1076003)(66556008)(30864003)(76116006)(66476007)(66946007)(91956017)(64756008)(36756003)(66446008)(186003)(8936002)(26005)(81156014)(478600001)(6512007)(5660300002)(71200400001)(4326008)(81166006)(107886003)(6916009)(8676002)(6506007)(6486002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1875;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQ17Wdvx2aeRMCe+kLyP8l06uPoQVBGnzzrT/XMhEynWTdyQnTplWOp9Ir71+CNuc646MvkCGIUvuwgdGjSxCnWx3Ox1QIJ3kiBrbrStB9CQ7vOWt3siTzyeuMTNphHlvyKw9neEIaaHQZdmTw/YxAONUoIDS/D1fmiNhSaaz2U/jcQoT0LR3mauP75fSnaEuKhghlE4kTH4DHXQPbv1fQafM1x5ccPtmy+5OR3grQSxpNgORPS0oRwYDlwdUglQPAkeBPrUtKkJCu92bCRwKNBVh3STmfYH2i7Kq7T5mmys6fIIRpMRBrMHZ6Euw4QoFPwa4Lq49IZOsWM7IjUOc4BEnogIodIDv1sRPEGji2DFKAErq7IwY7XGQ6zfJEAHSKIAiUdQjRSLbr3BCB6TOnf6b5nC3IQZXnRkIW2n6UZllixXjI935eSoQ4/wNRvp
x-ms-exchange-antispam-messagedata: 6TT7OYcLkMp7yw7iIPSx0b9prbmtgyj2QPELLi+0OVgM6JigGK0iJFn2OJUIYKmJBVpNtgiDp3KtLqyEgxOx3bhHib+93MxpW/rLapdq3bmEShmkaNpSOTeFv3vzo+OjHYCFj2spJhqxrZAp65e2gw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c64f2968-f1ec-490d-e5a9-08d7b9c61842
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:15.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxYptqJT5RWzEsbvpTGyxN0krWcMUNumTYZtBMv2kvzVoCe0FA8KesjXXprPivo3waE4l58rtoQMYeIS6RC0h4UoEtLklRgAaSSzCtO6ZlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1875
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/netdev.c' to
'drivers/net/wireless/microchip/wilc1000/netdev.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 940 ++++++++++++++++++
 1 file changed, 940 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/netdev.c

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
new file mode 100644
index 000000000000..045f5cdfdca0
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -0,0 +1,940 @@
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
+#include "cfg80211.h"
+#include "wlan_cfg.h"
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
+				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
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
+	struct net_device *ndev =3D NULL;
+	struct wilc_vif *vif;
+	struct ieee80211_hdr *h =3D (struct ieee80211_hdr *)mac_header;
+
+	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		if (vif->mode =3D=3D WILC_STATION_MODE)
+			if (ether_addr_equal_unaligned(h->addr2, vif->bssid)) {
+				ndev =3D vif->ndev;
+				goto out;
+			}
+		if (vif->mode =3D=3D WILC_AP_MODE)
+			if (ether_addr_equal_unaligned(h->addr1, vif->bssid)) {
+				ndev =3D vif->ndev;
+				goto out;
+			}
+	}
+out:
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
+	int srcu_idx;
+	u8 ret_val =3D 0;
+	struct wilc_vif *vif;
+
+	srcu_idx =3D srcu_read_lock(&wilc->srcu);
+	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		if (!is_zero_ether_addr(vif->bssid))
+			ret_val++;
+	}
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
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
+				int srcu_idx;
+				struct wilc_vif *ifc;
+
+				srcu_idx =3D srcu_read_lock(&wl->srcu);
+				list_for_each_entry_rcu(ifc, &wl->vif_list,
+							list) {
+					if (ifc->mac_opened && ifc->ndev)
+						netif_wake_queue(ifc->ndev);
+				}
+				srcu_read_unlock(&wl->srcu, srcu_idx);
+			}
+		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
+	}
+	return 0;
+}
+
+static int wilc_wlan_get_firmware(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	int chip_id;
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
+		return -EINVAL;
+	}
+	wilc->firmware =3D wilc_firmware;
+
+	return 0;
+}
+
+static int wilc_start_firmware(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	int ret =3D 0;
+
+	ret =3D wilc_wlan_start(wilc);
+	if (ret)
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
+	if (ret)
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
+	return -EINVAL;
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
+		wilc_wlan_stop(wl, vif);
+		wilc_wlan_cleanup(dev);
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
+		if (ret)
+			return ret;
+
+		ret =3D wlan_initialize_threads(dev);
+		if (ret)
+			goto fail_wilc_wlan;
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
+		ret =3D wilc_wlan_get_firmware(dev);
+		if (ret)
+			goto fail_irq_enable;
+
+		ret =3D wilc1000_firmware_download(dev);
+		if (ret)
+			goto fail_irq_enable;
+
+		ret =3D wilc_start_firmware(dev);
+		if (ret)
+			goto fail_irq_enable;
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
+
+		ret =3D wilc_init_fw_config(dev, vif);
+		if (ret) {
+			netdev_err(dev, "Failed to configure firmware\n");
+			goto fail_fw_start;
+		}
+		wl->initialized =3D true;
+		return 0;
+
+fail_fw_start:
+		wilc_wlan_stop(wl, vif);
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
+	if (ret)
+		return ret;
+
+	ret =3D wilc_wlan_initialize(ndev, vif);
+	if (ret) {
+		wilc_deinit_host_int(ndev);
+		return ret;
+	}
+
+	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
+				vif->idx);
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
+		int srcu_idx;
+		struct wilc_vif *vif;
+
+		srcu_idx =3D srcu_read_lock(&wilc->srcu);
+		list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+			if (vif->mac_opened)
+				netif_stop_queue(vif->ndev);
+		}
+		srcu_read_unlock(&wilc->srcu, srcu_idx);
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
+	int srcu_idx;
+	struct wilc_vif *vif;
+
+	srcu_idx =3D srcu_read_lock(&wilc->srcu);
+	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		u16 type =3D le16_to_cpup((__le16 *)buff);
+
+		if (vif->priv.p2p_listen_state &&
+		    ((type =3D=3D vif->frame_reg[0].type && vif->frame_reg[0].reg) ||
+		     (type =3D=3D vif->frame_reg[1].type && vif->frame_reg[1].reg)))
+			wilc_wfi_p2p_rx(vif, buff, size);
+
+		if (vif->monitor_flag)
+			wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
+	}
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
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
+void wilc_netdev_cleanup(struct wilc *wilc)
+{
+	struct wilc_vif *vif;
+	int srcu_idx, ifc_cnt =3D 0;
+
+	if (!wilc)
+		return;
+
+	if (wilc->firmware) {
+		release_firmware(wilc->firmware);
+		wilc->firmware =3D NULL;
+	}
+
+	srcu_idx =3D srcu_read_lock(&wilc->srcu);
+	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		if (vif->ndev)
+			unregister_netdev(vif->ndev);
+	}
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
+
+	wilc_wfi_deinit_mon_interface(wilc, false);
+	flush_workqueue(wilc->hif_workqueue);
+	destroy_workqueue(wilc->hif_workqueue);
+
+	while (ifc_cnt < WILC_NUM_CONCURRENT_IFC) {
+		mutex_lock(&wilc->vif_mutex);
+		if (wilc->vif_num <=3D 0) {
+			mutex_unlock(&wilc->vif_mutex);
+			break;
+		}
+		vif =3D wilc_get_wl_to_vif(wilc);
+		if (!IS_ERR(vif))
+			list_del_rcu(&vif->list);
+
+		wilc->vif_num--;
+		mutex_unlock(&wilc->vif_mutex);
+		synchronize_srcu(&wilc->srcu);
+		ifc_cnt++;
+	}
+
+	wilc_wlan_cfg_deinit(wilc);
+	wlan_deinit_locks(wilc);
+	kfree(wilc->bus_data);
+	wiphy_unregister(wilc->wiphy);
+	wiphy_free(wilc->wiphy);
+}
+EXPORT_SYMBOL_GPL(wilc_netdev_cleanup);
+
+static u8 wilc_get_available_idx(struct wilc *wl)
+{
+	int idx =3D 0;
+	struct wilc_vif *vif;
+	int srcu_idx;
+
+	srcu_idx =3D srcu_read_lock(&wl->srcu);
+	list_for_each_entry_rcu(vif, &wl->vif_list, list) {
+		if (vif->idx =3D=3D 0)
+			idx =3D 1;
+		else
+			idx =3D 0;
+	}
+	srcu_read_unlock(&wl->srcu, srcu_idx);
+	return idx;
+}
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
+	vif->idx =3D wilc_get_available_idx(wl);
+	vif->mac_opened =3D 0;
+	mutex_lock(&wl->vif_mutex);
+	list_add_tail_rcu(&vif->list, &wl->vif_list);
+	wl->vif_num +=3D 1;
+	mutex_unlock(&wl->vif_mutex);
+	synchronize_srcu(&wl->srcu);
+
+	return vif;
+}
+
+MODULE_LICENSE("GPL");
--=20
2.24.0
