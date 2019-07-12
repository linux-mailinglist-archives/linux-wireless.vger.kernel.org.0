Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD166393
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfGLB7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:17 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:22954 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfGLB7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:17 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: SdkL/OzUzSV0zdwHd8mqs3vcwdE2AhavQCKF6GZXIh7YID7dZv79D1n1HEfb9Xhd33kJFBD8+P
 vhhAHfUm1PglYWq9V1qzn1uQPJ9cRr36FHC1qnNPpHO0nTGHSMuNCYwLyFfbXSlUZ4omKaYwhI
 cl9OvAfdEngxTgJKQMJK3NCvzaASfUcVcf4GOiXU6o/3SjIGJWkM08LHq8m6U9/cP0f5GiDdvf
 g8A6a91Egu+bAyIofiwYGdcR7pR4vR4GC9lm2L1W5aMxVTotKflxmSxXLCwiQLjuho7tUldErY
 shQ=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="41020095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jul 2019 18:59:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dicw04hLPiMKkc0XuUlZlCp7cNHbq6TI7ovnkRxh5K4GS+wn7usQ9usrAizTsHNHrcCAPi3Bn5vLfMpQFjGRMMBzRIBkZZPLbaFJ02mDpWEyLN86fvUCOkMs4qT94YjQc4yS3j5nOHNNhD21nLx63+XAgjJfLNoX+MBzH+lDWpIIK0u6r/0detXInfJO5a9xFBWbC9hxSB4pswW0za2yvP3hyP+3kVwRB8ycrWDdotzFJrll2Bbaare34yS6/cKM2AbUDkSpB4LWIvR9ftGRbkR9HHZ6HczsmjaH9NbXybzvLptbsBtHlUgwXz6LuTU14DULPPdvD+gW6FvCsxgSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ectkOoKOqPvm+jCE0ubcA4XG0YQ7VAaCicsYnjmO5F8=;
 b=XCLdM/kiVOH60Dy+7sggv2agMmL4uUZ9QvNDYcv3VnrU55ZNTGKyUeRPaqinFPZRz0kOqaz90hIK0Ynl+n2TH1z5dLwWEtVqIt7VLkc3SSy14Mztt+JjyPaCEoUmEe5i4uJ1v13GYlUdlLCb4H1Ni9lgvCR8niTc1Fj2d7HIshyikmrS8jdXQCAu/3+ch6+bK66ByeGBtRO+4o3Gba4eu/Bq2scabEbPJUJ4NcpIGdYa/5P4MhbAABb1DBI9eC0nO0/UDeMyz2pgoDVrt1N36OSxDF8gfKSXDX4IsdvRdenpNenBGHRAJ5Nu/zf8LdLmwpgJgyyLvxMIrBMbmmJPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ectkOoKOqPvm+jCE0ubcA4XG0YQ7VAaCicsYnjmO5F8=;
 b=e1SJV97rR2TMcJAoCzrJeR1uv6QdZpJ4sxGsirO4QKUszr9RFotLdDDOG+t9mXpLueWQMs+6a6FDoet+/1qim88/Mo5N7/HBI4uwlk5DzZTz6Ai6zngo6mqd6XtRlV5t/DhQLKjHV0dO7K7UuqGPN0JFLKoqal5/Tph0mnGP690=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:12 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:12 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 10/16] wilc1000: add wilc_mon.c
Thread-Topic: [PATCH v2 10/16] wilc1000: add wilc_mon.c
Thread-Index: AQHVOFVmYzbC50/EVUWS3xxp6XF2iA==
Date:   Fri, 12 Jul 2019 01:59:12 +0000
Message-ID: <1562896697-8002-11-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 55a22090-116d-4e20-fe67-08d7066c8933
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB142588BB8597C723D3390F28E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(60444003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GW1U2kIRnSjjwpheuuMY/fgiPZ079DYkbCLlUcz2IA7XIXbeqxmtVTzI/82NxIS5WW068BddODQIJgvg5mnx6FnZ1+BjxlVrLcFd1hFyr6xJMIJjxcakoN51IO+cjLvMRBYusEbWW4HOBonA8lCER72VzZhIqqGdk9JL57xm1P8AwytDrZpf07KBLfT7uurqpOqkKAMnsCnTgKy6yYEixryuZJJglaCypQX+YpKra01XU5eHbq5cOfQFIvPT0zVuKUx6n1EYoJLapBTtvQx2wcYE1i9Gh/vmYr+cMTLW6pZvPLNy490TytCiamDm6+WaggoaYQAuurmxEvC7xgKGN7xDhFCOsWlKgSZ/nt7qRMfnAaWsP5TX/aBw2HP5AP0keLgYCSSIGxNsVrvevtx1NK45JKpxP8s1gksj2Bury9U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a22090-116d-4e20-fe67-08d7066c8933
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:12.8172
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

Moved '/driver/staging/wilc1000/wilc_mon.c' to
'drivers/net/wireless/microchip/wilc1000/wilc_mon.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wilc_mon.c | 261 +++++++++++++++++=
++++
 1 file changed, 261 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_mon.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_mon.c b/drivers/n=
et/wireless/microchip/wilc1000/wilc_mon.c
new file mode 100644
index 0000000..7d7933d4
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_mon.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include "wilc_wfi_cfgoperations.h"
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
+	memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
+	le32_to_cpus(&header);
+	/*
+	 * The packet offset field contain info about what type of management
+	 * the frame we are dealing with and ack status
+	 */
+	pkt_offset =3D GET_PKT_OFFSET(header);
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
+	/*If monitor interface is already initialized, return it*/
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
2.7.4

