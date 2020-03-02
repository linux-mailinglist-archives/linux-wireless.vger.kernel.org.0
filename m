Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400C8175FE7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCBQe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:34:56 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:11588 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCBQe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:34:56 -0500
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
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RMXnbUIwtibIIBbMOmF6KKr59gO5d2XBFyw+/BRF1AbyARUca6Kfr4ren3PvDapTTP/S//Dr2z
 K+B08mK3HHiv399g6E7yynQ2RA6ThbLkGrehFl86gnbY0FPXqalOacu2K4StPrfAPm3i9/2oTf
 4BWF2yNGGTB3NVDjEX6UX/CFF35Qq3lN/hBA7NsRDBv2/BgrH7j7cRdylYYc8fXuvGJG97yuAT
 +AnvhJ/TCU3VkLy/HyrgQ3TfbH2XVGo+TE/EC784WbfhNJammkl3GetugH7KV6DliXh9KqAnwg
 wgI=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="70445258"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 09:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTXCobAYXZdYa/VZuR3erlx/kkV/oarM4j7WzwemNoTaZAmIW5HO03ojGZ8ujkk31GuxoJrjDJJZVRzjc7NBj/pHTsYL//pUX0WJFSUsSRnpfgw9YqcGhm0zpnCbs+06NKRlhIy6vbYbNJ+PuL2cjtAJ/ZzfkUaE1SELed1aOpjA/7CsN52IRI1QXeHnEt5z+sz1HT0B/QNCCFrGjynlR4SfNXPPmQRzWBZoGq6aR2JgMwGSEZvS1s/wKqVuoipEsVD52+H//0yX4XsjojfkBoGk87JpDblVMa8/FI3+d25b60/x4QcAGIvaLgAUBj1eWp8r5YYt0s5a8VKnGhKNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=NnnQaGMvZ84broqSVqvDUQ9HiE++S+a9pWVdGnVB1aoE2D+fJ3zlRAeuPa5Di5VT9hNNYBrGFy+aEn3sJbQG40QkYLrWqnjFrZXrJHT9CMmV4v1wlpMU2PDBUANz1ARkFyZrljZIi9KcWsxOINTao8XzkXPo7ihacVaUA16/+a82ra+sy6nAIkkQzoyAGBtoKC7tbMMPYqI8RNq04vzr1fJmf2ayq7VRH/xaoTYXrd73VZkqaeyXhrbI10hEAatjPUtoLgUhbQLxd6c06VBhPb1fpNgahSsZ/jTBQxZcXYgokv9gx6V8E0ntuKYbCiewP1bteSXRvAYxOLLNcFN+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=p/N3K9kIC20dzt1ys27UxU9R7O7ihj/sSq0P2UxM4F6pixfJAH33Xw6att75P/gPWiDFQ/2500mN7+PjVBrcc/gGUgWTH/zYS9g8/BzE2GHKRwdhyD1zgdt0v3SA8OOGXTT1lc/rLFVNDpq7SvkwXculk3T0jH0Tdw+WnvKNUps=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:36 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:36 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 10/18] wilc1000: add mon.c
Thread-Topic: [PATCH v4 10/18] wilc1000: add mon.c
Thread-Index: AQHV8LB2sRoFViCP0k6/3OqqdxXOmg==
Date:   Mon, 2 Mar 2020 16:34:36 +0000
Message-ID: <20200302163414.4342-11-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0439f89e-a642-4d9f-8557-08d7bec798c5
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB40982CCF644CD2BC819814C6E3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIAtIMrtt6A5FCq0grOkdoXNCjyB30hZxJjxwfCtTCpfClR0hS/j1PS+h1Gphtx3COq1qwTajtKXHYCeT9zoErs3JVCsfHBrrf7xkDNzI5mmDMnVUvBKwuXVmM0CkKivRpXEzAPYmayOT0Qy5qvUKBA19P75xbEJMUYnHeUeyyKJPjPhuV++/GLiLV/v01Lp9ineFXo2hmFn+bgjR54hixzanqEiPu3adOQ3P4o5ZFZ25dda9ZeW0c7NxokXSPYKbtpvJgGQSPar+1owoMpxCzg2NsKvaLfrk16be8iKMOOEwoy4xWhy2b63Qm9YIBY+aO9jlOoXx3o0O04YkBoARoyGQW5joXpxyF3erUORw8SYH2YrbA40ExGU8QEy6hFZB+sJYbQC1YVwv/43w+mC83yChey8EzW39VRB7krQKii5XAnXLrhcntGVYKpN3I1s
x-ms-exchange-antispam-messagedata: pVQ9+bJyIYdvh/usKVg7ANGMyIubrx7xP0I+ok29XetWnO1bEKeht1CBlMqk/h7mtGratjEvyCvGPEaR4wmQMyDWizdbGh2ZjsFDIfXO1TfwTM30S9OsR8Dv4VrmbwnBsv4PxbRT/2jUpavcVUzSYg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0439f89e-a642-4d9f-8557-08d7bec798c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:36.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeOVO+hZkk0MHHiHOKjdfVKCizKzerMW2YfRwlKEEWrnDPI8I1DQqtqRKlEERsML4/1sYiJWDyz951np7DCK0IlgjPCEbbhNtAMpOxu6JzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
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
