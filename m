Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482A0204FCE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgFWLA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:28 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33237 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbgFWLAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910017; x=1624446017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLr6ccjkyOyWHx/FXXEjry7bMXTgbgdBcXipaFW2rVo=;
  b=GMYqNVMJ3NzhwcyNgPIpm78Mif9ugtg2rfLzJe08ZhGSDe2KLi+35l4q
   vmyWmgzhPmeYJK9xFzd0RdADXQupSF2Nx4ChjQzS2ghJhXF5Xc2FeIXLy
   6kNLW73+3lqQuFvILeo57KEZNt4Xif15EWacG+pXi41q2P4tFIvB+4u6C
   0mazI1a2Px8WRQdQcSRkdFJnsB61/mPvLp/fzcWkcTo53M65euelp0t7S
   RoWyt6Ontub4uYNhRoOpuweH5bNB7Po79Pzp8BXVsKK19BN2vB0MXaOFg
   yJBM3sWIqd5OGiR+CKOsjsnreUxqhUkT43xBwUlwm+bseIteP8qChz/Dx
   Q==;
IronPort-SDR: oZZ7dOZvxvugphOKVYi2pwI+5oEyfeyR1SHI3aknaBs+tPnB/CJPwM3fUffpATGL4CyE8fFN7s
 NOt0W1Ns1PZ8678sF81HQEDBFUKOHMuZ9V+58i7QhMKHGkleA6ZRPJizkpnurfEELoMflVa46g
 3mS4lJdc8Ppabl4gZT6VX2vWj1irrV2NrOeLuUG4kXMDjeodniyQQllaQKUOCw86MiwJ55Evuv
 4yW7ikHUTXNgTo2J/vzaj2VwWmCijwHy/ghxRaoAF2PXQ0lFpkCJt/bNLrMVhXyk43ms/rs96P
 UxU=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="84732772"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 04:00:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 04:00:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc/XDTCHPZWz2oRyJrIOQVo/O4fsXgE03AXkIOLtpHL32jHlLLtM1FCu3+Lr8NQDFqT7Rg49tA4P3t6406NqLmE1vHFLp07pCxB6RUNOBpjt1S9TudhbiLAZr/2wPVhlgSqyX+NtEoy6PjdqFTytbEkapbMOSLx/jppHzPzzunVqYCLu8mVVI1jQgbiIya57jAu1AdNaTgIGZreEyh+BowDy03TR9/WqJx+Px5/zSskM1rjD81r6c+bZN6X4SifTyuLoZdS/Ivs8OdsYlkCuwH0sEbuUAT7/Ko7hzZcyp/pCl04wZGMQXq9OnaL2gI77t+tYL/t4mXEO8M8rpwJ9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=PD9k9xRlYOluHmTh92p1q0h2xRQaGQU2vPnwxmd1wp0LySzPHAOQZ1XhSqdHUGZz8QbLMh3/sTd5kCVqgP7ILiIkoKlhzKu1kpNcpEOKJ9BvCK3CFLcM9+HWcMvfTeIa9k5QwcIAqnWBhJ8CPOIe4j5djQ3gcKg74KDObumIJWJd8qoSrLPBU/CGfZMizVb4OnY+fjhiV1JM8NqtoPx0ZV2LmgnMsE0Ox+ul2qVqe/0vkUBokDWbUjoiIx0ZSfukpGhcWr1/CqOmPm3YQ314fOZmjFSvmY5mT3/ZyYvImyDMRc2k4mJ5HqS1xoSLfFl62cw0KEE9lPvyWUOA55GdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1CWqNU1H9hc2J0CBVPk5OE7X4CykPUWsjTvFVtm6i4=;
 b=FChB2dsGE3M86g0a5HOIGkGg5Kj+iNSxbD+VqKC+xxs4SoAFjS/me58iAOLLlYCuS5YZHthNrJhKJahN5XsbgQ1FCZC/wQcZhVVtB7LrGYwrDAul2mpjrsFfIMdzTb6lHGMHj4UFrdIK7cY8Gb+2Me42MwCYDddHQACouQljbV4=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:10 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:10 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 10/17] wilc1000: add mon.c
Thread-Topic: [PATCH v7 10/17] wilc1000: add mon.c
Thread-Index: AQHWSU12OmMqvS2czk2I+YTu+oooRg==
Date:   Tue, 23 Jun 2020 11:00:10 +0000
Message-ID: <20200623110000.31559-11-ajay.kathat@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.200.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d37eeeb-540f-4251-ca32-08d81764993f
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB35513AB1DDF0B7C86AC6984FE3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MXpcf5BVCVGP/o0GJJzT4ehC+kM/h/Do+hhNH8eNS1XXdS2Ac14kiIi1uA/NY2qIzRnOAxYyYnwiiYbHcz4Jf7rndokPv7NFV8A5k1qAey1QVr5YTwFP05sEx/vDS334oIZuMgYLfQfD7dDf0vEjr1YIAgZeQptL1KQtBbZzuqa0CoZaDnkwFAqBGdpL9L3b/1/LlyZUwF1QcXhaJmflqi9BUgWHf0Y8DjIJH5CtxZvJQr6QC4rQuQEtlbqL2U1mhX45aG9ape1MK7lh4dDobbnGKW97Y0idnfFXGIo1mR2/W5QWHX0ae7m/A83H0+AMzg4/aH1tN3VTm7h9iIsOMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8dtjkLNSwZU3Dj96TAIP09QG00b/st4lw8dIBQqTMXPl52ZG2hKkH6yWcAGaL+khrZFtR2mJqNPcZd4FdO0ovVEG2wkWRJkWYjB7N3Z2ZR5AZFyIE/Fhc2UyszIu8ZFLR4fPra3Y9ab8ckpzBTOoEgjMTO0I1vSqz0ZqXZeIpbC5DTSfpFTmrZc01orkf9+8tQw6/yvVGAKeHA/DfwAIqyjVW5sZyNU1qpXA8srzQUgYuwLb8/FocAKPM896ReFScEjkmru2bYFtgKlcZMzHbriUSOj6eQ/YJqC9pjfv2xTIG+nl9mIc6XoMLl6Px4afyHSpPKxy+TO1JxlSRWYcM17xUiMQ8u1Q0efcRyAOrk8AUNPc9RrqucnZkVjC2/nAaGaHYvaO8pUIKCkcjqQMRLcn7OsfFNx2KGy82hPYwy/osNOlUhb5SCqsHB2vtUSHjcSeQP+RDsDBUsuwZvxuwLy7DRjAiniB0yryOfP/mO7DgtgSxfxe88+xkxj3cG47
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d37eeeb-540f-4251-ca32-08d81764993f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:10.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01www6y1nB/b94br+mKk6THuR9g+q8COmJXq3ZA83+BzcxUaBCJ4tpOFJLTumKt74xeuu6sWsgAebTRfh/WAJ6dUSvRYEKxTr55b7NkDGzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
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
