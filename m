Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31145195142
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC0GdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49549 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgC0GdV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:21 -0400
IronPort-SDR: GWLORkpRNg8JvhVGg2j+y9ithG5/iD5ee8qWaC4/mb2ea/hGqBBKf4OETM3PngLi5GuKoPmNh+
 NSEjxSqqyRhEJ1B22UToPvW3T9Yyr7O9deJLXqo9MMEyhqON4FvWYlZwVkedOVvvx+M5HhJhtA
 z99J+i+r0kikmoCv7g+AV33a1j2kIpLwBInulpmLN9qU/1Ivv00185zpoG0bq4BLd1KzXzFt9e
 caKEQ8GwpBOeGbJpAB5osXUO/EpBHJpagv5GpmxipPVtHnCUhUE1EUZP2INJXS92gF4ZtPfMAT
 +UM=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="70452392"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 23:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc80cIhUQ15kez23wAteXd+2szU1tkLcOR3ARaVAVxdz4P1yGWM6NIn+qON+FFTK1ODF6eRj79c3DJdbM9bMm31DvkyP2SskiFWODsd5NqyQmj8slGRb54joZ3e4u0TELxHOv27NJTjEjiGvcM7KJfjxd7z8ZjPkBJJ0lDBbfrs23KtJIywwE5ZLwRy9bxLzn/58wQN6VUau08482i7n67RXv/vxuD2ekhVpzF77uToZqvH5bzPhhKTK2FZTEx+hEMs/vdf1RlgOMHjyv6fsAXxHSx12bg5ltMiFztoFrKpKy3A9IlnsDT7UcvvR5zZlmv83eYfje5G8YR1Q/sN9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=NjeS7VoqSUJGP3bmdY2jTap34PXs9EZCiH0DO5VGyWQQvh/j9MjiR6pcsrmQd2sVoyZi9EVula6fdAgxg1EmCze63Re9GQgxyoDcTBuNBV95ZgPgl7p0Eg6ON6mt5fgbAXpQbj3ui44JnxRwOQuOGfx1GrOWaK6JKh21u+D4mZVPILIe2GRu4fjZls4Tq5xkWW0+qOTvCEnh+cbNVvaqvW/U5KYw5c325ugKNEjmmQ+epMdocZCj+ZIp4AqFxWaxSUKPIUmEVThLgcDD/VZuqZn6GG4UJWosJ1oXdVq2Ad5AqQzEt8h3o0RB1l+XUaMqSfpDIoudvcYBTUFzX7kc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=KaYli0IZIHcGXDhOy4eKSs3dFUBaT864v8RfeSJ74Uxw+JwCmmhQLIFqWlKfztpCSIFFx9cFIBKUtfdyAwOpG4WSN8RKueAkPgp97HiXsU+yif7BJiB4yywVcjuFgfNJg2UKjhvkji3PYmZuNqOaVo8T43XufVw8O+Du6BrmWl8=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:16 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:16 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 10/17] wilc1000: add mon.c
Thread-Topic: [PATCH v6 10/17] wilc1000: add mon.c
Thread-Index: AQHWBAGY4N5mV/CQVkSRaQsrxWNLlw==
Date:   Fri, 27 Mar 2020 06:33:15 +0000
Message-ID: <20200327063302.20511-11-ajay.kathat@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1753efba-0e76-4546-3ac3-08d7d218bb55
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3397AEB0256EEED94EA7FDA2E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zq3ig5Jf/N9Hkp04tT/tuJoBkxbzGkSDJJyBv9A/dZHWriyxoaXq5O/lHhl0/PXLNs6+LtIBxNw10vf4hhape2a5B86pEbYHcm7FuZXro2jdcB8oX97Sq83EDjE6+t82V3eWuasuRk2y3UhIeYqoRoplhZbhDJ2+SSvShXLZRySl6nUNqLzpo2aLvdSPYEY+4fe5qrWFeRaICtj/wdni4dS32Lhzvb2nWYsy2fsZVGM4b/oRsYCTtY/0A75RJizkHbgmiAcc0VLr7dcS+jMydQcq/q9nKWFswQRJej4H1Duh1zoFzJVK9FD0EzdEAt/gYfzl5CqxPdl661AWY4/E/7j8rsO/a4PFpVhoXHuLjIbsvovuhzwAwXW+E5atEflrfDOshtMaoVSYUaqlo8yQJkl4RgKQdj7EySsK6AN9+r5zAKf9Y2dbi805gKSmdcZf
x-ms-exchange-antispam-messagedata: lX7PSSF16sPDih0XVTxej1y4JuSbkXLRSXTe/84s0VuX1JKT816kqTqePrnKEyRLaUZ3bU7ht8E7SJKBI3t1MHgY81VF5wM7W8/68ZnfM06NIg0OcUIAhsdYIsbIToTfeKvrzIDCtHURf561pgoXEA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1753efba-0e76-4546-3ac3-08d7d218bb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:15.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4XWZLLOv7kVAt7juFzDeAjt2bKYP+EqWaLlmNGZ5gTqEUnWflQmxhBxGpzqk17hmsYDEovYRiYxayI+wm2sg728nRMu5xBfsTjxQ2+OgAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/mon.c' to
'drivers/net/wireless/microchip/wilc1000/mon.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/mon.c | 260 ++++++++++++++++++
 1 file changed, 260 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/mon.c

diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wi=
reless/microchip/wilc1000/mon.c
new file mode 100644
index 000000000000..60331417bd98
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include "cfg80211.h"
+
+struct wilc_wfi_radiotap_hdr {
+	struct ieee80211_radiotap_header hdr;
+	u8 rate;
+} __packed;
+
+struct wilc_wfi_radiotap_cb_hdr {
+	struct ieee80211_radiotap_header hdr;
+	u8 rate;
+	u8 dump;
+	u16 tx_flags;
+} __packed;
+
+#define TX_RADIOTAP_PRESENT ((1 << IEEE80211_RADIOTAP_RATE) |	\
+			     (1 << IEEE80211_RADIOTAP_TX_FLAGS))
+
+void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size)
+{
+	u32 header, pkt_offset;
+	struct sk_buff *skb =3D NULL;
+	struct wilc_wfi_radiotap_hdr *hdr;
+	struct wilc_wfi_radiotap_cb_hdr *cb_hdr;
+
+	if (!mon_dev)
+		return;
+
+	if (!netif_running(mon_dev))
+		return;
+
+	/* Get WILC header */
+	header =3D get_unaligned_le32(buff - HOST_HDR_OFFSET);
+	/*
+	 * The packet offset field contain info about what type of management
+	 * the frame we are dealing with and ack status
+	 */
+	pkt_offset =3D FIELD_GET(WILC_PKT_HDR_OFFSET_FIELD, header);
+
+	if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
+		/* hostapd callback mgmt frame */
+
+		skb =3D dev_alloc_skb(size + sizeof(*cb_hdr));
+		if (!skb)
+			return;
+
+		skb_put_data(skb, buff, size);
+
+		cb_hdr =3D skb_push(skb, sizeof(*cb_hdr));
+		memset(cb_hdr, 0, sizeof(*cb_hdr));
+
+		cb_hdr->hdr.it_version =3D 0; /* PKTHDR_RADIOTAP_VERSION; */
+
+		cb_hdr->hdr.it_len =3D cpu_to_le16(sizeof(*cb_hdr));
+
+		cb_hdr->hdr.it_present =3D cpu_to_le32(TX_RADIOTAP_PRESENT);
+
+		cb_hdr->rate =3D 5;
+
+		if (pkt_offset & IS_MGMT_STATUS_SUCCES)	{
+			/* success */
+			cb_hdr->tx_flags =3D IEEE80211_RADIOTAP_F_TX_RTS;
+		} else {
+			cb_hdr->tx_flags =3D IEEE80211_RADIOTAP_F_TX_FAIL;
+		}
+
+	} else {
+		skb =3D dev_alloc_skb(size + sizeof(*hdr));
+
+		if (!skb)
+			return;
+
+		skb_put_data(skb, buff, size);
+		hdr =3D skb_push(skb, sizeof(*hdr));
+		memset(hdr, 0, sizeof(struct wilc_wfi_radiotap_hdr));
+		hdr->hdr.it_version =3D 0; /* PKTHDR_RADIOTAP_VERSION; */
+		hdr->hdr.it_len =3D cpu_to_le16(sizeof(*hdr));
+		hdr->hdr.it_present =3D cpu_to_le32
+				(1 << IEEE80211_RADIOTAP_RATE);
+		hdr->rate =3D 5;
+	}
+
+	skb->dev =3D mon_dev;
+	skb_reset_mac_header(skb);
+	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
+	skb->pkt_type =3D PACKET_OTHERHOST;
+	skb->protocol =3D htons(ETH_P_802_2);
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	netif_rx(skb);
+}
+
+struct tx_complete_mon_data {
+	int size;
+	void *buff;
+};
+
+static void mgmt_tx_complete(void *priv, int status)
+{
+	struct tx_complete_mon_data *pv_data =3D priv;
+	/*
+	 * in case of fully hosting mode, the freeing will be done
+	 * in response to the cfg packet
+	 */
+	kfree(pv_data->buff);
+
+	kfree(pv_data);
+}
+
+static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, size_t len)
+{
+	struct tx_complete_mon_data *mgmt_tx =3D NULL;
+
+	if (!dev)
+		return -EFAULT;
+
+	netif_stop_queue(dev);
+	mgmt_tx =3D kmalloc(sizeof(*mgmt_tx), GFP_ATOMIC);
+	if (!mgmt_tx)
+		return -ENOMEM;
+
+	mgmt_tx->buff =3D kmemdup(buf, len, GFP_ATOMIC);
+	if (!mgmt_tx->buff) {
+		kfree(mgmt_tx);
+		return -ENOMEM;
+	}
+
+	mgmt_tx->size =3D len;
+
+	wilc_wlan_txq_add_mgmt_pkt(dev, mgmt_tx, mgmt_tx->buff, mgmt_tx->size,
+				   mgmt_tx_complete);
+
+	netif_wake_queue(dev);
+	return 0;
+}
+
+static netdev_tx_t wilc_wfi_mon_xmit(struct sk_buff *skb,
+				     struct net_device *dev)
+{
+	u32 rtap_len, ret =3D 0;
+	struct wilc_wfi_mon_priv  *mon_priv;
+	struct sk_buff *skb2;
+	struct wilc_wfi_radiotap_cb_hdr *cb_hdr;
+	u8 srcadd[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+
+	mon_priv =3D netdev_priv(dev);
+	if (!mon_priv)
+		return -EFAULT;
+
+	rtap_len =3D ieee80211_get_radiotap_len(skb->data);
+	if (skb->len < rtap_len)
+		return -1;
+
+	skb_pull(skb, rtap_len);
+
+	if (skb->data[0] =3D=3D 0xc0 && is_broadcast_ether_addr(&skb->data[4])) {
+		skb2 =3D dev_alloc_skb(skb->len + sizeof(*cb_hdr));
+		if (!skb2)
+			return -ENOMEM;
+
+		skb_put_data(skb2, skb->data, skb->len);
+
+		cb_hdr =3D skb_push(skb2, sizeof(*cb_hdr));
+		memset(cb_hdr, 0, sizeof(struct wilc_wfi_radiotap_cb_hdr));
+
+		cb_hdr->hdr.it_version =3D 0; /* PKTHDR_RADIOTAP_VERSION; */
+
+		cb_hdr->hdr.it_len =3D cpu_to_le16(sizeof(*cb_hdr));
+
+		cb_hdr->hdr.it_present =3D cpu_to_le32(TX_RADIOTAP_PRESENT);
+
+		cb_hdr->rate =3D 5;
+		cb_hdr->tx_flags =3D 0x0004;
+
+		skb2->dev =3D dev;
+		skb_reset_mac_header(skb2);
+		skb2->ip_summed =3D CHECKSUM_UNNECESSARY;
+		skb2->pkt_type =3D PACKET_OTHERHOST;
+		skb2->protocol =3D htons(ETH_P_802_2);
+		memset(skb2->cb, 0, sizeof(skb2->cb));
+
+		netif_rx(skb2);
+
+		return 0;
+	}
+	skb->dev =3D mon_priv->real_ndev;
+
+	ether_addr_copy(srcadd, &skb->data[10]);
+	ether_addr_copy(bssid, &skb->data[16]);
+	/*
+	 * Identify if data or mgmt packet, if source address and bssid
+	 * fields are equal send it to mgmt frames handler
+	 */
+	if (!(memcmp(srcadd, bssid, 6))) {
+		ret =3D mon_mgmt_tx(mon_priv->real_ndev, skb->data, skb->len);
+		if (ret)
+			netdev_err(dev, "fail to mgmt tx\n");
+		dev_kfree_skb(skb);
+	} else {
+		ret =3D wilc_mac_xmit(skb, mon_priv->real_ndev);
+	}
+
+	return ret;
+}
+
+static const struct net_device_ops wilc_wfi_netdev_ops =3D {
+	.ndo_start_xmit         =3D wilc_wfi_mon_xmit,
+
+};
+
+struct net_device *wilc_wfi_init_mon_interface(struct wilc *wl,
+					       const char *name,
+					       struct net_device *real_dev)
+{
+	struct wilc_wfi_mon_priv *priv;
+
+	/* If monitor interface is already initialized, return it */
+	if (wl->monitor_dev)
+		return wl->monitor_dev;
+
+	wl->monitor_dev =3D alloc_etherdev(sizeof(struct wilc_wfi_mon_priv));
+	if (!wl->monitor_dev)
+		return NULL;
+
+	wl->monitor_dev->type =3D ARPHRD_IEEE80211_RADIOTAP;
+	strncpy(wl->monitor_dev->name, name, IFNAMSIZ);
+	wl->monitor_dev->name[IFNAMSIZ - 1] =3D 0;
+	wl->monitor_dev->netdev_ops =3D &wilc_wfi_netdev_ops;
+	wl->monitor_dev->needs_free_netdev =3D true;
+
+	if (register_netdevice(wl->monitor_dev)) {
+		netdev_err(real_dev, "register_netdevice failed\n");
+		return NULL;
+	}
+	priv =3D netdev_priv(wl->monitor_dev);
+	if (!priv)
+		return NULL;
+
+	priv->real_ndev =3D real_dev;
+
+	return wl->monitor_dev;
+}
+
+void wilc_wfi_deinit_mon_interface(struct wilc *wl, bool rtnl_locked)
+{
+	if (!wl->monitor_dev)
+		return;
+
+	if (rtnl_locked)
+		unregister_netdevice(wl->monitor_dev);
+	else
+		unregister_netdev(wl->monitor_dev);
+	wl->monitor_dev =3D NULL;
+}
--=20
2.24.0
