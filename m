Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062041817B2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 13:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgCKMTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 08:19:01 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31982 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgCKMTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 08:19:00 -0400
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
IronPort-SDR: r9a2iEBFXW++Me42a2whTnBYTDJ9PSgAFjXRrNd+B/BJcauJ9hD8QuZL5DOb1N1hj5l0CboVIv
 ghMM0dl6/rz7Gzq+swa6U04FjbOJ+MsmCFT7S0T+/sNEEs6MKkNQ+CyfYl79BT5ECq2A69Ou5C
 eeT+EOR6QwprdPXsBbq/CoJvhuEqsBm67SSWS0y3BLgiGLxwJFlpXnsSiqNyJYuNq6W7X9QlVE
 tZg9RKAltFZSrd2qsCG2SYOx+/oGmFwGHycRLXR+l10Q6LjCoiPFSTs4d3BRsHj0F4bILQZ/m9
 1IY=
X-IronPort-AV: E=Sophos;i="5.70,540,1574146800"; 
   d="scan'208";a="68440750"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2020 05:19:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Mar 2020 05:18:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Mar 2020 05:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejZcFHtO2nrUyXYU77hmTt0WeYCWDoQjEw2fzyyDSigm0wyOO7QT68AhKLVFyoHr8W/BIMI+A5eorrrEI4lKpy11ee5UIIAwGnRr5vjmgaMOQuSmPkM4BwVJi6vHZHa1y6PerfnjKDFHcF7RuU7NctWbTcUSACl9XZtPSsF1AaANve92MZqwssbhcCTHiA0Ufi+iA+jXd0NZMyuFV8pdZUMA0r0yceuSnnKXByd0caJbwgPuJ1odnzG2vpj+VMQEmVTtDQgfx6fabbuoIqcP87T5eil4Ys0DiHmlFtXg6kEo2CxErTZ9r0S0eacWXCDQYEHfB5iCIYPr0F3XY7U0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=TW0Ls0WNdwP1z53vWqO5Vd+TBRcpsHEIH1IlU0IwahaQEz3yGWgNCDdYb7IrDxAXwHvwy27EXjoc+4Pl5X226VIEbUOr+EwBk2j5wN6YkT2u5htmwdz17B00l32qG/fzSeefx/YCm9xY986CCgdnpS7k1pJOA/JrR51jJvPKHwEpSFq2PhbEbU8foQFse8bdIZqykiutEN1LxVlcFTeMYroV0BkPn/AKFNRyyd3/H+EROvyCq2Dfukjub/26RN+/zK73j0HPf8tu2NHLB7Jm9mH1XrvBnBiokCFLqkWMC7oeenohHid6pDUXZQTmyrsInqKcafW1+lntLlD0A93Vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=TcUHp+5UM8XwFU7LiQyvLp2/l7uFUeyYxiXy8wFZmt7LG7LVEykaJ+zd/66UMOx2LgPBEHiK6iPygPKqRh4HgA+zaT6G2sU6k7/umVWVosHIp9kKYk7epQBCyCmKKkWBGjUTXc0Wixk2CVqI8myERR9EVx+nBXSDl5+HRa7Bs/Q=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 12:18:56 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 12:18:56 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v5 10/17] wilc1000: add mon.c
Thread-Topic: [PATCH v5 10/17] wilc1000: add mon.c
Thread-Index: AQHV9582ufJnfv1GvUy6SfN2uksdWA==
Date:   Wed, 11 Mar 2020 12:18:47 +0000
Message-ID: <20200311121809.5610-11-ajay.kathat@microchip.com>
References: <20200311121809.5610-1-ajay.kathat@microchip.com>
In-Reply-To: <20200311121809.5610-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e610eaec-f34d-48ad-c0bb-08d7c5b65f0a
x-ms-traffictypediagnostic: BYAPR11MB2805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2805DF3D4FCE8534A9E35C98E3FC0@BYAPR11MB2805.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(478600001)(2906002)(71200400001)(8936002)(81166006)(81156014)(6666004)(316002)(5660300002)(54906003)(6506007)(1076003)(8676002)(6512007)(86362001)(36756003)(107886003)(4326008)(6486002)(76116006)(91956017)(66476007)(64756008)(66446008)(66946007)(66556008)(6916009)(2616005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2805;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wM6GELdp1obpytVFj6ezXVB6ryzCPwJUMO3NyX6JfH5Vuok0sBaDbpmuGpuPHQRF4S5E81JyGpuE9thDpRgK3JAVUEqGwaYUEzt82eQCyP5hH0rqrF/W+EdYbfbyCXQxJNADdmLvNuhlj7iUiKtF2A9sILzd0bwA1deI3jlWSczhBk1OYUMSqogEEHb0ruDvfLAoeBbFfRN9Nmb5cIhbAr7doqe9dGGc1lN5OcKOrtet0SC3rh64H9+9Fr7lMPKHo8wkYuHRjCgYIDcD/8dXiNUAKB6H4rtRNS5MNKdEuc9DseJL+Z1vynb7AnhmBZICIwgUh/4Uc5PE+ERS06AYs+/jexvdnLNs3HonNotUPf7h2cS99XgjZimv2q/wA9SQzgh4VRMUlovYxeG4rj00TB2QbXn8/WGaTGpKwbGylY+LvFOR2l5jP+ZXjaABbObj
x-ms-exchange-antispam-messagedata: h0IJAVkClOAvjK9IkVg4qpbRwI8TrVDkxcjKksqFQfSDcDxtPzgbBZP+fHF4MwNTl2ALZ7K3veiMK2ZU+fbAbVIbRoP/RtpvzYXynnwqb9IGam3q5Xww5pHoczzwjvszQxDcE6pkRrXYFIpu/cUXnQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e610eaec-f34d-48ad-c0bb-08d7c5b65f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 12:18:47.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HqgRwXWqhC5oINNKtyOU6gvb1BBtJBnbQi5oqg0kEGyAu+UOpRaPqpx5ip+QhVN/k7Ti3HHukUUWStsr5Jq/xseGJDsFLoDm8cCPWd/TIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
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
