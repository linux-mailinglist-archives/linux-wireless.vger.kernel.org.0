Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF1100053
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKRI1K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:27:10 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:43296 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbfKRI1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:27:09 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8Ku74011085
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:07 -0700
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2055.outbound.protection.outlook.com [104.47.33.55])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wacguuxqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crY7DZEiSCuRYFWjBsb/LLOblr0wizB+g9S3E1swtios+eO7EhBewJUmtvy91Y+P2LmUOHWMtyx/hMbTw+A4C8cEH7yxTsiLe0oFE4hIZz3fugU6HqJV+wWPZnPa0K7CGpHYkIfjydWmUC0JIrcTNRLCInEaspX9mYQ8FXsyGcidM1+1eG84DWO7+NqN4sgSDhTpv9YeZtidLnQzWDPdLqt/+L3oALR0rtuNbZALoIUBUpM8T6tHuKMc61Wvvldy/3AXVR7667mgED0hpcmaK5cUlfy9rkXFJfk1pG0/cyr4voNZHOz4dfUf5of5RqtBDweVBGxVkZS9RVMqFg7h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV0/t9xiXFPzko9FTw8FhJ3Hx0pphJPfN99MKIP52zs=;
 b=PTY8NYSMZKNLpr4KKh/YBBy8YpXUZ4k5MWZoOY8sYloxADysrNV7R1UGOO+wZ1t42zpMAEIe4IdSYStOZBlQRaqmdrOtz/GH1M7avnIqKHJKePktYH+p9OZSyScaagRINF5R0nVWtKwgHZUQo4xOQgGtD1SwCWJ8H9ZnWJK3EF06HId9g1+x7qmLh4YqA0sHZsnjNV/Od3D1uVT2e8h2YVmgf7jlRI5svm+h7xFcnAFbsq0fNvjmNwQT71kEWPep4EM4Ifk3VI5FVx4O4owBNhSr3+a0jIwkChW48UhaAU/S3zqu8r52sLnHsnlZYGkpAS5WHcksMpvxj02zAgGm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV0/t9xiXFPzko9FTw8FhJ3Hx0pphJPfN99MKIP52zs=;
 b=m+B/DjZlV0oQ/j1Iu2IYVbeqQKADXEGnxyYDlSCSq6kQ70qRMJUTzGFYzd+1ng5Q3TcKUgiiK9T+D9LmvXBBsrSHrUWlju9C4IkXK8O4JDKQFvLdlSdprl4+5ru8LMT/GWL2G4HyruMxdXcvWEjhzd0Ih84F2udhNoTGqsI9fTA=
Received: from BYAPR05MB5624.namprd05.prod.outlook.com (20.177.186.205) by
 BYAPR05MB4408.namprd05.prod.outlook.com (20.176.250.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Mon, 18 Nov 2019 08:27:05 +0000
Received: from BYAPR05MB5624.namprd05.prod.outlook.com
 ([fe80::7904:4402:567b:e628]) by BYAPR05MB5624.namprd05.prod.outlook.com
 ([fe80::7904:4402:567b:e628%6]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:27:05 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:09 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:08 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 3/7] qtnfmac: add interface ID to each packet
Thread-Topic: [PATCH 3/7] qtnfmac: add interface ID to each packet
Thread-Index: AQHVneloCPLSMiIVkUO4dYO7a4s6EQ==
Date:   Mon, 18 Nov 2019 08:23:08 +0000
Message-ID: <20191118082255.6032-4-sergey.matyukevich.os@quantenna.com>
References: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b8b1669-5235-4076-fe8f-08d76c008afd
x-ms-traffictypediagnostic: SN6PR05MB6320:|BYAPR05MB4408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB63209D42B3CF7DF6CD6BAD39A34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:27:02 AM
x-ms-oob-tlc-oobclassifiers: OLM:201;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39840400004)(189003)(199004)(478600001)(76176011)(6436002)(6512007)(5640700003)(52116002)(66946007)(102836004)(107886003)(386003)(14444005)(5024004)(6506007)(256004)(4326008)(50226002)(71190400001)(71200400001)(66066001)(2906002)(3846002)(103116003)(6116002)(2501003)(6486002)(86362001)(81166006)(81156014)(8936002)(8676002)(36756003)(66476007)(436003)(305945005)(11346002)(446003)(2616005)(486006)(2351001)(54906003)(476003)(6916009)(7736002)(1076003)(316002)(5660300002)(26005)(25786009)(186003)(14454004)(64756008)(66446008)(66556008)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4408;H:BYAPR05MB5624.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCF3kJHT+ppOv4oqEheCFN/JdkXOAvUlWbKIzIisNrKilGVVWuFDHQDFCrqAB1Km2WDslFjKXl3qHCE08qknnlAp2p5PSHOcrxcmQDphmq27UR473IH1eGW0Q6AuxGt7vmylX6jhefqzDMMU1Yk0sFg2MswZDeju0QSUan6k5XEAgKhOvMROahACSxxtT/KwsSyhVNBToqdQrEkupHFkc22ILwsp9s4BJvieUm8tNdW0CN02sHETOQPadzyEbuj3O1lNpFGe2rCnvDf8CwSMyLE8YLK/pSU6GAvKgQXxr5Tg0riLgOWf7CUMMyyZAO03iBRFOYIwNWx6j7t8IuANexUiNznLrPL/EBIdXg3WysW4zNrIhwc0mWTG66n++J7QZLRO4hfQbiNlb5d9oN0FQyakEhox0BlQ3gLDBHtWebiEzyibhLhioM1GarSElfbK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b1669-5235-4076-fe8f-08d76c008afd
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bN1h3zAQIxzv9CKrdvsy1/Mq16hz03sRmh+PhY6uP4d6yf4p9qHj3G587oQQ8D6YBwVNgvSA9plHU98oTLnffYsQyXU10imwlQ8UHsiITxn6QZvHwk7Wd7/Uxy5axZ9OrUSBh17P7jDn5X6/xJ7Mw1YTARoaczF838Sondzdgy6JG/rmAsLDdSGcnvBY3RLdIFGEc2oISUHf7MSLVSa6SHki4gpzMmSY+u8Xye4HLg8=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:27:05.7620
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180075
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Add interface ID information to the tail of each transmitted packet
so that firmware can know to which interface the packet belongs to.
This is only needed if device supports HW switch capability.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/bus.h       | 21 ++++++++--
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 19 ++++-----
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 47 ++++++++++++++++++=
++--
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |  5 ++-
 4 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wir=
eless/quantenna/qtnfmac/bus.h
index 4c6eca344a09..49372d42e471 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -12,6 +12,16 @@
=20
 #define QTNF_MAX_MAC		3
=20
+#define HBM_FRAME_META_MAGIC_PATTERN_S	0xAB
+#define HBM_FRAME_META_MAGIC_PATTERN_E	0xBA
+
+struct qtnf_frame_meta_info {
+	u8 magic_s;
+	u8 ifidx;
+	u8 macid;
+	u8 magic_e;
+} __packed;
+
 enum qtnf_fw_state {
 	QTNF_FW_STATE_DETACHED,
 	QTNF_FW_STATE_BOOT_DONE,
@@ -31,8 +41,10 @@ struct qtnf_bus_ops {
 	int (*control_tx)(struct qtnf_bus *, struct sk_buff *);
=20
 	/* data xfer methods */
-	int (*data_tx)(struct qtnf_bus *, struct sk_buff *);
+	int (*data_tx)(struct qtnf_bus *bus, struct sk_buff *skb,
+		       unsigned int macid, unsigned int vifid);
 	void (*data_tx_timeout)(struct qtnf_bus *, struct net_device *);
+	void (*data_tx_use_meta_set)(struct qtnf_bus *bus, bool use_meta);
 	void (*data_rx_start)(struct qtnf_bus *);
 	void (*data_rx_stop)(struct qtnf_bus *);
 };
@@ -42,7 +54,7 @@ struct qtnf_bus {
 	enum qtnf_fw_state fw_state;
 	u32 chip;
 	u32 chiprev;
-	const struct qtnf_bus_ops *bus_ops;
+	struct qtnf_bus_ops *bus_ops;
 	struct qtnf_wmac *mac[QTNF_MAX_MAC];
 	struct qtnf_qlink_transport trans;
 	struct qtnf_hw_info hw_info;
@@ -100,9 +112,10 @@ static inline void qtnf_bus_stop(struct qtnf_bus *bus)
 	bus->bus_ops->stop(bus);
 }
=20
-static inline int qtnf_bus_data_tx(struct qtnf_bus *bus, struct sk_buff *s=
kb)
+static inline int qtnf_bus_data_tx(struct qtnf_bus *bus, struct sk_buff *s=
kb,
+				   unsigned int macid, unsigned int vifid)
 {
-	return bus->bus_ops->data_tx(bus, skb);
+	return bus->bus_ops->data_tx(bus, skb, macid, vifid);
 }
=20
 static inline void
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 3ba19a966c7f..7300ab407cd6 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -22,13 +22,6 @@ MODULE_PARM_DESC(slave_radar, "set 0 to disable radar de=
tection in slave mode");
=20
 static struct dentry *qtnf_debugfs_dir;
=20
-struct qtnf_frame_meta_info {
-	u8 magic_s;
-	u8 ifidx;
-	u8 macid;
-	u8 magic_e;
-} __packed;
-
 struct qtnf_wmac *qtnf_core_get_mac(const struct qtnf_bus *bus, u8 macid)
 {
 	struct qtnf_wmac *mac =3D NULL;
@@ -121,7 +114,7 @@ qtnf_netdev_hard_start_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
 		return NETDEV_TX_OK;
 	}
=20
-	return qtnf_bus_data_tx(mac->bus, skb);
+	return qtnf_bus_data_tx(mac->bus, skb, mac->macid, vif->vifid);
 }
=20
 /* Netdev handler for getting stats.
@@ -481,6 +474,9 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct =
qtnf_vif *vif,
 	dev->tx_queue_len =3D 100;
 	dev->ethtool_ops =3D &qtnf_ethtool_ops;
=20
+	if (mac->bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE)
+		dev->needed_tailroom =3D sizeof(struct qtnf_frame_meta_info);
+
 	qdev_vif =3D netdev_priv(dev);
 	*((void **)qdev_vif) =3D vif;
=20
@@ -723,6 +719,10 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
=20
+	if ((bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) &&
+	    bus->bus_ops->data_tx_use_meta_set)
+		bus->bus_ops->data_tx_use_meta_set(bus, true);
+
 	if (bus->hw_info.num_mac > QTNF_MAX_MAC) {
 		pr_err("no support for number of MACs=3D%u\n",
 		       bus->hw_info.num_mac);
@@ -790,7 +790,8 @@ EXPORT_SYMBOL_GPL(qtnf_core_detach);
=20
 static inline int qtnf_is_frame_meta_magic_valid(struct qtnf_frame_meta_in=
fo *m)
 {
-	return m->magic_s =3D=3D 0xAB && m->magic_e =3D=3D 0xBA;
+	return m->magic_s =3D=3D HBM_FRAME_META_MAGIC_PATTERN_S &&
+		m->magic_e =3D=3D HBM_FRAME_META_MAGIC_PATTERN_E;
 }
=20
 struct net_device *qtnf_classify_skb(struct qtnf_bus *bus, struct sk_buff =
*skb)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index a501a1fd5332..8e0d8018208a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -532,7 +532,7 @@ static int qtnf_tx_queue_ready(struct qtnf_pcie_pearl_s=
tate *ps)
 	return 1;
 }
=20
-static int qtnf_pcie_data_tx(struct qtnf_bus *bus, struct sk_buff *skb)
+static int qtnf_pcie_skb_send(struct qtnf_bus *bus, struct sk_buff *skb)
 {
 	struct qtnf_pcie_pearl_state *ps =3D get_bus_priv(bus);
 	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
@@ -608,6 +608,38 @@ static int qtnf_pcie_data_tx(struct qtnf_bus *bus, str=
uct sk_buff *skb)
 	return NETDEV_TX_OK;
 }
=20
+static int qtnf_pcie_data_tx(struct qtnf_bus *bus, struct sk_buff *skb,
+			     unsigned int macid, unsigned int vifid)
+{
+	return qtnf_pcie_skb_send(bus, skb);
+}
+
+static int qtnf_pcie_data_tx_meta(struct qtnf_bus *bus, struct sk_buff *sk=
b,
+				  unsigned int macid, unsigned int vifid)
+{
+	struct qtnf_frame_meta_info *meta;
+	int tail_need =3D sizeof(*meta) - skb_tailroom(skb);
+	int ret;
+
+	if (tail_need > 0 && pskb_expand_head(skb, 0, tail_need, GFP_ATOMIC)) {
+		skb->dev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	meta =3D skb_put(skb, sizeof(*meta));
+	meta->magic_s =3D HBM_FRAME_META_MAGIC_PATTERN_S;
+	meta->magic_e =3D HBM_FRAME_META_MAGIC_PATTERN_E;
+	meta->macid =3D macid;
+	meta->ifidx =3D vifid;
+
+	ret =3D qtnf_pcie_skb_send(bus, skb);
+	if (unlikely(ret =3D=3D NETDEV_TX_BUSY))
+		__skb_trim(skb, skb->len - sizeof(*meta));
+
+	return ret;
+}
+
 static irqreturn_t qtnf_pcie_pearl_interrupt(int irq, void *data)
 {
 	struct qtnf_bus *bus =3D (struct qtnf_bus *)data;
@@ -796,13 +828,22 @@ static void qtnf_pcie_data_rx_stop(struct qtnf_bus *b=
us)
 	qtnf_disable_hdp_irqs(ps);
 }
=20
-static const struct qtnf_bus_ops qtnf_pcie_pearl_bus_ops =3D {
+static void qtnf_pearl_tx_use_meta_info_set(struct qtnf_bus *bus, bool use=
_meta)
+{
+	if (use_meta)
+		bus->bus_ops->data_tx =3D qtnf_pcie_data_tx_meta;
+	else
+		bus->bus_ops->data_tx =3D qtnf_pcie_data_tx;
+}
+
+static struct qtnf_bus_ops qtnf_pcie_pearl_bus_ops =3D {
 	/* control path methods */
 	.control_tx	=3D qtnf_pcie_control_tx,
=20
 	/* data path methods */
 	.data_tx		=3D qtnf_pcie_data_tx,
 	.data_tx_timeout	=3D qtnf_pcie_data_tx_timeout,
+	.data_tx_use_meta_set	=3D qtnf_pearl_tx_use_meta_info_set,
 	.data_rx_start		=3D qtnf_pcie_data_rx_start,
 	.data_rx_stop		=3D qtnf_pcie_data_rx_stop,
 };
@@ -905,7 +946,7 @@ static int qtnf_ep_fw_send(struct pci_dev *pdev, uint32=
_t size,
 	memcpy(pdata, pblk, len);
 	hdr->crc =3D cpu_to_le32(~crc32(0, pdata, len));
=20
-	ret =3D qtnf_pcie_data_tx(bus, skb);
+	ret =3D qtnf_pcie_skb_send(bus, skb);
=20
 	return (ret =3D=3D NETDEV_TX_OK) ? len : 0;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index a0587472736f..dbf3c5fd751f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -497,7 +497,8 @@ static int qtnf_tx_queue_ready(struct qtnf_pcie_topaz_s=
tate *ts)
 	return 1;
 }
=20
-static int qtnf_pcie_data_tx(struct qtnf_bus *bus, struct sk_buff *skb)
+static int qtnf_pcie_data_tx(struct qtnf_bus *bus, struct sk_buff *skb,
+			     unsigned int macid, unsigned int vifid)
 {
 	struct qtnf_pcie_topaz_state *ts =3D (void *)get_bus_priv(bus);
 	struct qtnf_pcie_bus_priv *priv =3D &ts->base;
@@ -740,7 +741,7 @@ static void qtnf_pcie_data_rx_stop(struct qtnf_bus *bus=
)
 	napi_disable(&bus->mux_napi);
 }
=20
-static const struct qtnf_bus_ops qtnf_pcie_topaz_bus_ops =3D {
+static struct qtnf_bus_ops qtnf_pcie_topaz_bus_ops =3D {
 	/* control path methods */
 	.control_tx	=3D qtnf_pcie_control_tx,
=20
--=20
2.11.0

