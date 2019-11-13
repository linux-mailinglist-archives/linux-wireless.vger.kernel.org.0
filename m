Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB042FAF51
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfKMLHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:32 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:63394 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727736AbfKMLHc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:32 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xADB6RLN011870
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:31 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by m0059812.ppops.net with ESMTP id 2w7pst45e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZQJe/P7R0iT92ta3U0weM8T0xXbod97L2ZCmeYLMbzKupA3GCJWD/rapS+PRENuJXGpsMPD/eszqVuOGJjpOM9chPXjuF7kh0mMoxHEP+HFaUcL3TV4t3kl5kdISraC0VGK7nYpRKbTXlxOK2kAb6O20lIgvNDN9LP+sHIsUtzrCP/MeI9+MY3ZH/u2kERXK9UEUA5Y/J5PWAjcS+eZQ7dSt3wLeDkMWt/h71ugbg4TPaqbTNFz6WAmBz05uzwqQo/jgOpsf2xH8sZeD4JG4LMb5tuhrea8+V/rAFiEOIyrLILCkhMOzf8MJeGqwc3q3bvB99YmpL0/1ex6+bJR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffX+tlSZuG/n1ByofijnjCptoFClPY9QfK4cHjdCQpM=;
 b=CE349Mteexm9MVhdDa6nvmpNtbF3AI7mJWMk8E9321WwFcPUCZxBSMS+jYVixSHwUslWumcWeZtexpq+EgV1/uXZte+Rz/LedRMD363+C4vZKylGGKXVeHi3E7LSjkZuuoEa9mFnwe1JIvWPbfoaHtN/k8JR+/2cgZYoBfPEgSFwB/ywhRVjfD7HD7dRpoDJs8y5OLp8K2g/RhHXJPBvxTxuNSOfMT9KcFcGLedtk3+VKRqgDiOoycJu5hJw2s1dNZtGMBgR29znOyGeHAcclUeg5858O7mE5sjjUVx66Yw8TIlGtfS5alZwvP57pya+E+/1GZIUhJlfhl25iECORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffX+tlSZuG/n1ByofijnjCptoFClPY9QfK4cHjdCQpM=;
 b=llnOmDZd6MXI0bn52QD+wk0TkvoOMhAC+2NfIM0Hue/9SxptTObRlEax1ErriKcCgxWH1K/mI7RI8gNETAW9pujY73RcNP591uiFmGajM1ny7wjZcY5SMm0EFrQv9Klb31BnTagBUUKXW4l8MvpOB8v7QWueGRkdZqj7c1UgXxs=
Received: from BN7PR05MB4211.namprd05.prod.outlook.com (52.132.6.160) by
 BN7PR05MB4404.namprd05.prod.outlook.com (52.133.220.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.16; Wed, 13 Nov 2019 11:07:29 +0000
Received: from BN7PR05MB4211.namprd05.prod.outlook.com
 ([fe80::248c:f458:3b48:d65e]) by BN7PR05MB4211.namprd05.prod.outlook.com
 ([fe80::248c:f458:3b48:d65e%6]) with mapi id 15.20.2451.018; Wed, 13 Nov 2019
 11:07:29 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5295.namprd05.prod.outlook.com (52.135.109.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:54 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:54 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 4/7] qtnfmac: modify Rx descriptors queue setup
Thread-Topic: [PATCH 4/7] qtnfmac: modify Rx descriptors queue setup
Thread-Index: AQHVmhJ0spEq1MUuyUe1jBucSSdR4w==
Date:   Wed, 13 Nov 2019 11:06:53 +0000
Message-ID: <20191113110639.9226-5-sergey.matyukevich.os@quantenna.com>
References: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6d65416-6349-4de0-4203-08d768299728
x-ms-traffictypediagnostic: SN6PR05MB5295:|BN7PR05MB4404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB529567BFB0FDD3FF8A75FCCAA3760@SN6PR05MB5295.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:27 AM
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39850400004)(189003)(199004)(102836004)(103116003)(66946007)(305945005)(107886003)(66476007)(2501003)(486006)(436003)(76176011)(66556008)(64756008)(99286004)(6512007)(52116002)(478600001)(2351001)(8936002)(256004)(14444005)(66446008)(8676002)(86362001)(71190400001)(71200400001)(7736002)(25786009)(66066001)(50226002)(6916009)(4326008)(81166006)(81156014)(5640700003)(6436002)(6506007)(11346002)(6486002)(3846002)(316002)(5660300002)(26005)(186003)(2616005)(446003)(54906003)(1076003)(6116002)(2906002)(386003)(476003)(14454004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4404;H:BN7PR05MB4211.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIx4E5KOm5iAC+yKU7mqzi66DxkvpIBHww240T8iuNb08yQO1c1py1tuw6SEnY0im2Za6yKQteeM3zb8Dxh/9AE/jNCMW2AMAVHvM+AppLnOr79HcBy5eQu4QAPBPeP+eMsJg5kqPc4jXXc3mkG9q1PjWhzApGJbDgUxVmlHN95wsXoI7jPQGuH3wJYV8f4igHysnZDs627J41gNH+jGomI+RmmxG5/itbcUyWdxRWIE00d8Ctd/FnrkS90rdzPpZCnyv+rEqgtGrp5QRnkTm7phtr0YfqakBbT3Uci5wzR3Clh+8Kaz2aCPmGY3fcrx0gGuCroP/ndGzLeWb2l9imKIH1HQ6fJZw8Cb/QEvpYEjqLJiyms67yw0cRdhejVJ9cm7gA5MjnVpaZBt1CA2b9dwYasUsib5BEs5QiQ2k2TlhC0J2dko9roi2q7XozS0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d65416-6349-4de0-4203-08d768299728
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeWDlu/GuYpZJ4yidOzwUmbuCScnHiNvNQGHtW+KR6bkH29iIk53AcdgvMihoa5O7YN/9mOXRxlbwDoWpOg3hcXVYl9Dn9yE0wQ3OgFIp2nD6Iuh53F7bgR96p7mYSj+At7BEz+a+IkUlgDU4o0YODoZTh//lw5qQmvvvBXsEbCUAy15OmZYlQEDuc5XityZqXB+mxM+szI89S26AUCTW3hknF5ZYYPy0VYJAQqqyF0=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:29.3717
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4404
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rx descriptors queue length is hardware specific. Current common default
value is no more than an accident. So move Rx descriptor queue setup to
platform PCIe backend in the same way as it is already done for Tx.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |  5 ++-
 .../wireless/quantenna/qtnfmac/pcie/pcie_priv.h    |  3 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 36 ++++++++++++------=
----
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   | 20 ++++++++++--
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/n=
et/wireless/quantenna/qtnfmac/pcie/pcie.c
index 4824be0c6231..3360b836fc44 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -33,7 +33,7 @@ static unsigned int tx_bd_size_param;
 module_param(tx_bd_size_param, uint, 0644);
 MODULE_PARM_DESC(tx_bd_size_param, "Tx descriptors queue size");
=20
-static unsigned int rx_bd_size_param =3D 256;
+static unsigned int rx_bd_size_param;
 module_param(rx_bd_size_param, uint, 0644);
 MODULE_PARM_DESC(rx_bd_size_param, "Rx descriptors queue size");
=20
@@ -341,7 +341,6 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
 	bus->fw_state =3D QTNF_FW_STATE_DETACHED;
 	pcie_priv->pdev =3D pdev;
 	pcie_priv->tx_stopped =3D 0;
-	pcie_priv->rx_bd_num =3D rx_bd_size_param;
 	pcie_priv->flashboot =3D flashboot;
=20
 	if (fw_blksize_param > QTN_PCIE_MAX_FW_BUFSZ)
@@ -381,7 +380,7 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
 	pcie_priv->epmem_bar =3D epmem_bar;
 	pci_save_state(pdev);
=20
-	ret =3D pcie_priv->probe_cb(bus, tx_bd_size_param);
+	ret =3D pcie_priv->probe_cb(bus, tx_bd_size_param, rx_bd_size_param);
 	if (ret)
 		goto error;
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h b/driv=
ers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
index 5e8b9cb68419..8bc4300518d0 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
@@ -23,7 +23,8 @@
 struct qtnf_pcie_bus_priv {
 	struct pci_dev *pdev;
=20
-	int (*probe_cb)(struct qtnf_bus *bus, unsigned int tx_bd_size);
+	int (*probe_cb)(struct qtnf_bus *bus, unsigned int tx_bd_size,
+			unsigned int rx_bd_size);
 	void (*remove_cb)(struct qtnf_bus *bus);
 	int (*suspend_cb)(struct qtnf_bus *bus);
 	int (*resume_cb)(struct qtnf_bus *bus);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 5ec1c9bc1612..a501a1fd5332 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -24,6 +24,7 @@
 #include "debug.h"
=20
 #define PEARL_TX_BD_SIZE_DEFAULT	32
+#define PEARL_RX_BD_SIZE_DEFAULT	256
=20
 struct qtnf_pearl_bda {
 	__le16 bda_len;
@@ -397,7 +398,8 @@ static int pearl_hhbm_init(struct qtnf_pcie_pearl_state=
 *ps)
 }
=20
 static int qtnf_pcie_pearl_init_xfer(struct qtnf_pcie_pearl_state *ps,
-				     unsigned int tx_bd_size)
+				     unsigned int tx_bd_size,
+				     unsigned int rx_bd_size)
 {
 	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
 	int ret;
@@ -409,28 +411,29 @@ static int qtnf_pcie_pearl_init_xfer(struct qtnf_pcie=
_pearl_state *ps,
 	val =3D tx_bd_size * sizeof(struct qtnf_pearl_tx_bd);
=20
 	if (!is_power_of_2(tx_bd_size) || val > PCIE_HHBM_MAX_SIZE) {
-		pr_warn("bad tx_bd_size value %u\n", tx_bd_size);
+		pr_warn("invalid tx_bd_size value %u, use default %u\n",
+			tx_bd_size, PEARL_TX_BD_SIZE_DEFAULT);
 		priv->tx_bd_num =3D PEARL_TX_BD_SIZE_DEFAULT;
 	} else {
 		priv->tx_bd_num =3D tx_bd_size;
 	}
=20
-	priv->rx_bd_w_index =3D 0;
-	priv->rx_bd_r_index =3D 0;
+	if (rx_bd_size =3D=3D 0)
+		rx_bd_size =3D PEARL_RX_BD_SIZE_DEFAULT;
=20
-	if (!priv->rx_bd_num || !is_power_of_2(priv->rx_bd_num)) {
-		pr_err("rx_bd_size_param %u is not power of two\n",
-		       priv->rx_bd_num);
-		return -EINVAL;
-	}
+	val =3D rx_bd_size * sizeof(dma_addr_t);
=20
-	val =3D priv->rx_bd_num * sizeof(dma_addr_t);
-	if (val > PCIE_HHBM_MAX_SIZE) {
-		pr_err("rx_bd_size_param %u is too large\n",
-		       priv->rx_bd_num);
-		return -EINVAL;
+	if (!is_power_of_2(rx_bd_size) || val > PCIE_HHBM_MAX_SIZE) {
+		pr_warn("invalid rx_bd_size value %u, use default %u\n",
+			rx_bd_size, PEARL_RX_BD_SIZE_DEFAULT);
+		priv->rx_bd_num =3D PEARL_RX_BD_SIZE_DEFAULT;
+	} else {
+		priv->rx_bd_num =3D rx_bd_size;
 	}
=20
+	priv->rx_bd_w_index =3D 0;
+	priv->rx_bd_r_index =3D 0;
+
 	ret =3D pearl_hhbm_init(ps);
 	if (ret) {
 		pr_err("failed to init h/w queues\n");
@@ -1064,7 +1067,8 @@ static u64 qtnf_pearl_dma_mask_get(void)
 #endif
 }
=20
-static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus, unsigned int tx_bd_=
size)
+static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus, unsigned int tx_bd_=
size,
+				 unsigned int rx_bd_size)
 {
 	struct qtnf_shm_ipc_int ipc_int;
 	struct qtnf_pcie_pearl_state *ps =3D get_bus_priv(bus);
@@ -1079,7 +1083,7 @@ static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus=
, unsigned int tx_bd_size)
 	ps->bda =3D ps->base.epmem_bar;
 	writel(ps->base.msi_enabled, &ps->bda->bda_rc_msi_enabled);
=20
-	ret =3D qtnf_pcie_pearl_init_xfer(ps, tx_bd_size);
+	ret =3D qtnf_pcie_pearl_init_xfer(ps, tx_bd_size, rx_bd_size);
 	if (ret) {
 		pr_err("PCIE xfer init failed\n");
 		return ret;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index 1f91088e3dff..ef255fb57405 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -23,6 +23,7 @@
 #include "debug.h"
=20
 #define TOPAZ_TX_BD_SIZE_DEFAULT	128
+#define TOPAZ_RX_BD_SIZE_DEFAULT	256
=20
 struct qtnf_topaz_tx_bd {
 	__le32 addr;
@@ -331,7 +332,8 @@ static void qtnf_topaz_free_xfer_buffers(struct qtnf_pc=
ie_topaz_state *ts)
 }
=20
 static int qtnf_pcie_topaz_init_xfer(struct qtnf_pcie_topaz_state *ts,
-				     unsigned int tx_bd_size)
+				     unsigned int tx_bd_size,
+				     unsigned int rx_bd_size)
 {
 	struct qtnf_topaz_bda __iomem *bda =3D ts->bda;
 	struct qtnf_pcie_bus_priv *priv =3D &ts->base;
@@ -349,6 +351,17 @@ static int qtnf_pcie_topaz_init_xfer(struct qtnf_pcie_=
topaz_state *ts,
=20
 	priv->tx_bd_num =3D tx_bd_size;
 	qtnf_non_posted_write(priv->tx_bd_num, &bda->bda_rc_tx_bd_num);
+
+	if (rx_bd_size =3D=3D 0)
+		rx_bd_size =3D TOPAZ_RX_BD_SIZE_DEFAULT;
+
+	if (rx_bd_size > TOPAZ_RX_BD_SIZE_DEFAULT) {
+		pr_warn("RX BD queue cannot exceed %d\n",
+			TOPAZ_RX_BD_SIZE_DEFAULT);
+		rx_bd_size =3D TOPAZ_RX_BD_SIZE_DEFAULT;
+	}
+
+	priv->rx_bd_num =3D rx_bd_size;
 	qtnf_non_posted_write(priv->rx_bd_num, &bda->bda_rc_rx_bd_num);
=20
 	priv->rx_bd_w_index =3D 0;
@@ -1111,7 +1124,8 @@ static u64 qtnf_topaz_dma_mask_get(void)
 	return DMA_BIT_MASK(32);
 }
=20
-static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus, unsigned int tx_bd_=
num)
+static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus,
+				 unsigned int tx_bd_num, unsigned int rx_bd_num)
 {
 	struct qtnf_pcie_topaz_state *ts =3D get_bus_priv(bus);
 	struct pci_dev *pdev =3D ts->base.pdev;
@@ -1145,7 +1159,7 @@ static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus=
, unsigned int tx_bd_num)
 		return ret;
 	}
=20
-	ret =3D qtnf_pcie_topaz_init_xfer(ts, tx_bd_num);
+	ret =3D qtnf_pcie_topaz_init_xfer(ts, tx_bd_num, rx_bd_num);
 	if (ret) {
 		pr_err("PCIE xfer init failed\n");
 		return ret;
--=20
2.11.0

