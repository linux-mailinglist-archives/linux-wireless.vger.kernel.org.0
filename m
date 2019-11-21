Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD510539A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUNyE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 08:54:04 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:55068 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbfKUNyE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 08:54:04 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALDpChd015561
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 06:53:59 -0700
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2050.outbound.protection.outlook.com [104.47.41.50])
        by mx0b-00183b01.pphosted.com with ESMTP id 2waewa52d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 06:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIbgwR/9sv9ieUrMqyKHu+/5Nu72qYdtA6pTweLyOlO0xg5RTN/7RW/yZfdXvTlXtAvhB0ACZYIecuyZkSBRcnGqiMuQyrBEtWhfERAovWT34YcjaEDySGJgcMomPX5+9z7FTBlx/Kd4CGEpBJS7fWE4q27Xkj7Qebs56yS3dZVCS3GkDAeYvQWaIK2prOdlWE2PF0Z8GGE5kdDAKOs2tImaioWtD54otviVA2IM6WhNk1XfJQ1xgzox3hTogEYilOEIRrn/c0jXFZ3CyoGtHWDYgSNTHQzEoAOcq75Z13AbcWTI3Np9WXvu8I6J9mvKKBacDkd30GNtUdEonLqJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDpxYNCt+lt3Sfm4qBpFTe7XdoRoa5bnkKkJaypf3zw=;
 b=SumYePSXzWeeKzodgG8g8FctCneHk8hBOQMaA+pphiJkaYWFTcj0XxYINyWq0zoQKoIm/7fRbVC8yt8OJeGOsGjWJvh5zcbbiZyFDK7DYL9w9ahKKwYY3EAaXzLFCDuO7xS0nA77hl8cLeUaZw2SDH7iPsEat0tRPQFH7VavoGRVI01HkDQpEEuYGBTX4IEN5IFvMPagR1bH6SK2YoceG/SqKfHSthrEzbrTvDqvmeZZJA1oFS0WVEM8h31Qq+3QpNCkH7N1nVPg4N0T9IXK1s1BEcR/rDOyNZmhjlfn+biKH6Cbbbs3BH+V6irkjw56diHqLs0+tz1VJ50/BzgF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDpxYNCt+lt3Sfm4qBpFTe7XdoRoa5bnkKkJaypf3zw=;
 b=MkJR9CAf2Iugp8mK2YkKvhkHX7o9FixizFwA/SfEHa8dInoh8iO9mQsb4xnB5C8cG7blNB/ITO1TuOulMNQEgz10LmGkebmNGUMKj09mRsz2KFTOHFOqcPtb93iUWCKl3bQu1HGBz2eQMYQOCeSF/z3lsa9a6l3chZC/LOyIQ/U=
Received: from BN6PR05MB3188.namprd05.prod.outlook.com (10.172.147.11) by
 BN6PR05MB2818.namprd05.prod.outlook.com (10.168.253.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.9; Thu, 21 Nov 2019 13:53:57 +0000
Received: from BN6PR05MB3188.namprd05.prod.outlook.com
 ([fe80::5922:c40b:d810:f110]) by BN6PR05MB3188.namprd05.prod.outlook.com
 ([fe80::5922:c40b:d810:f110%10]) with mapi id 15.20.2474.015; Thu, 21 Nov
 2019 13:53:56 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4270.namprd05.prod.outlook.com (52.135.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 13:53:33 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:53:33 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 1/2] qtnfmac: prepare for the next chip revision
Thread-Topic: [PATCH 1/2] qtnfmac: prepare for the next chip revision
Thread-Index: AQHVoHMQAtV2PIKxq0GlIpsyRuBieQ==
Date:   Thu, 21 Nov 2019 13:53:33 +0000
Message-ID: <20191121135324.21715-2-sergey.matyukevich.os@quantenna.com>
References: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:a03:60::32) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd405970-4114-4b76-0f5d-08d76e8a3251
x-ms-traffictypediagnostic: SN6PR05MB4270:|BN6PR05MB2818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB4270F70AA0B5649E3C6EA349A34E0@SN6PR05MB4270.namprd05.prod.outlook.com>
x-moderation-data: 11/21/2019 1:53:53 PM
x-ms-oob-tlc-oobclassifiers: OLM:70;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(376002)(346002)(189003)(199004)(446003)(5660300002)(64756008)(256004)(6486002)(52116002)(8936002)(4326008)(76176011)(6116002)(99286004)(3846002)(1076003)(66446008)(305945005)(316002)(66946007)(50226002)(478600001)(66476007)(66556008)(36756003)(54906003)(6916009)(5024004)(436003)(11346002)(107886003)(66066001)(14444005)(2616005)(2906002)(81156014)(8676002)(6506007)(14454004)(6512007)(6436002)(103116003)(5640700003)(186003)(2351001)(86362001)(26005)(81166006)(2501003)(71190400001)(71200400001)(386003)(102836004)(7736002)(30864003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR05MB2818;H:BN6PR05MB3188.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0DCWAgg4/ERYyehIwMituM6+x+cVpx34ZGMxnrZSL4JiNNlJ6dDQHqvV/FX/hH6e0N/dQbjHVWGNpdOFaR6vMazgZ45k6MJGwc37iYrw90BXjo6RT9Cx4TqlAfO5a4AIyVsujixa3+b0y87ZpdiWKogmk0FNs0bSMC9kG/PqlMi1c3CMEUnNf3AsMlYHopd3IHtlOLzSWWX+3sfHQxP0i1SgDPWVa79rYQAD0PxAzzpTiQxoQWZLOxW9ICYY8+T/wc0uaIupxr6+9fcP62Y3/2wu4PbYaebbHG708/0lXfRObUEwaqPEq3Gz7haT64makefj7VVecgutHZn9g0N9+Vyv9/F3TrPhJ7dIiGAshZ8bot9gFvGtUdfDR4seccsWSIitXewHqfTzoWijzRPiZziftym0GBg/fzIsyrp7oN+4JCn6WlAzry5i03WlQXd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd405970-4114-4b76-0f5d-08d76e8a3251
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7lB+0MTcLUspgcW4cY7ZJEFnWWmRpgRtYxr698t1PrCfV/77zPtxEmP8I/L4JYbsKUToVF2Hwh+Vj8QTacd3dV0kU8bwasrICu7Pt0OfVJkJP/euPk8/uETaAbrsYm1nFbTyvOcU8SC6OJq9ebNJeI8KtiZyVV5k++2799jayAIPy/ecD2gDTpZ1JgE/RfBVa+qma9iDbm3WGFJZR7rUEsRBgeovFaFCV/ryJcwWwE=
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 13:53:56.7897
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2818
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911210126
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Data path operations may differ between chip revisions. Extract such
operations and settings and into a separate structure in order to
support multiple QSR10G chips revisions with single module.
Remove data path counters specific to a single chip revision.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/bus.h       |   3 +-
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |   3 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 356 +++++++++++++----=
----
 3 files changed, 220 insertions(+), 142 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wir=
eless/quantenna/qtnfmac/bus.h
index 87d048df09d1..b8e1049e7e21 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -52,8 +52,7 @@ struct qtnf_bus_ops {
 struct qtnf_bus {
 	struct device *dev;
 	enum qtnf_fw_state fw_state;
-	u32 chip;
-	u32 chiprev;
+	u32 chipid;
 	struct qtnf_bus_ops *bus_ops;
 	struct qtnf_wmac *mac[QTNF_MAX_MAC];
 	struct qtnf_qlink_transport trans;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/n=
et/wireless/quantenna/qtnfmac/pcie/pcie.c
index 5337e67092ca..1a1896c4c042 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -335,10 +335,11 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
 	if (!bus)
 		return -ENOMEM;
=20
+	bus->fw_state =3D QTNF_FW_STATE_DETACHED;
+	bus->chipid =3D chipid;
 	pcie_priv =3D get_bus_priv(bus);
 	pci_set_drvdata(pdev, bus);
 	bus->dev =3D &pdev->dev;
-	bus->fw_state =3D QTNF_FW_STATE_DETACHED;
 	pcie_priv->pdev =3D pdev;
 	pcie_priv->tx_stopped =3D 0;
 	pcie_priv->flashboot =3D flashboot;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 8e0d8018208a..32506f700cca 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -23,9 +23,6 @@
 #include "shm_ipc.h"
 #include "debug.h"
=20
-#define PEARL_TX_BD_SIZE_DEFAULT	32
-#define PEARL_RX_BD_SIZE_DEFAULT	256
-
 struct qtnf_pearl_bda {
 	__le16 bda_len;
 	__le16 bda_version;
@@ -73,8 +70,28 @@ struct qtnf_pearl_fw_hdr {
 	__le32 crc;
 } __packed;
=20
+struct qtnf_pcie_pearl_state;
+
+struct qtnf_pcie_pearl_hdp_ops {
+	u16 hdp_rx_bd_size_default;
+	u16 hdp_tx_bd_size_default;
+	int (*hdp_alloc_bd_table)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_init)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_hhbm_init)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_set_queues)(struct qtnf_pcie_pearl_state *ps,
+			       unsigned int tx_bd_size,
+			       unsigned int rx_bd_size);
+	void (*hdp_rbd_attach)(struct qtnf_pcie_pearl_state *ps, u16 index,
+			       dma_addr_t paddr);
+	u32 (*hdp_get_tx_done_index)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_tx_hw_push)(struct qtnf_pcie_pearl_state *ps, int index,
+			       dma_addr_t paddr);
+
+};
+
 struct qtnf_pcie_pearl_state {
 	struct qtnf_pcie_bus_priv base;
+	const struct qtnf_pcie_pearl_hdp_ops *hdp_ops;
=20
 	/* lock for irq configuration changes */
 	spinlock_t irq_lock;
@@ -97,6 +114,180 @@ struct qtnf_pcie_pearl_state {
 	u32 pcie_irq_uf_count;
 };
=20
+/* HDP common ops */
+
+static void hdp_set_queues_common(struct qtnf_pcie_pearl_state *ps,
+				  unsigned int tx_bd_size,
+				  unsigned int rx_bd_size)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+
+	if (tx_bd_size =3D=3D 0) {
+		tx_bd_size =3D ps->hdp_ops->hdp_tx_bd_size_default;
+	} else if (!is_power_of_2(tx_bd_size)) {
+		pr_warn("invalid tx_bd_size value %u, use default %u\n",
+			tx_bd_size, ps->hdp_ops->hdp_tx_bd_size_default);
+		tx_bd_size =3D ps->hdp_ops->hdp_tx_bd_size_default;
+	}
+
+	if (rx_bd_size =3D=3D 0) {
+		rx_bd_size =3D ps->hdp_ops->hdp_rx_bd_size_default;
+	} else if (!is_power_of_2(rx_bd_size)) {
+		pr_warn("invalid rx_bd_size value %u, use default %u\n",
+			tx_bd_size, ps->hdp_ops->hdp_rx_bd_size_default);
+		rx_bd_size =3D ps->hdp_ops->hdp_rx_bd_size_default;
+	}
+
+	priv->tx_bd_num =3D tx_bd_size;
+	priv->rx_bd_num =3D rx_bd_size;
+}
+
+/* HDP ops: rev B */
+
+static int hdp_alloc_bd_table_rev_b(struct qtnf_pcie_pearl_state *ps)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	dma_addr_t paddr;
+	void *vaddr;
+	int len;
+
+	len =3D priv->tx_bd_num * sizeof(struct qtnf_pearl_tx_bd) +
+		priv->rx_bd_num * sizeof(struct qtnf_pearl_rx_bd);
+
+	vaddr =3D dmam_alloc_coherent(&priv->pdev->dev, len, &paddr, GFP_KERNEL);
+	if (!vaddr)
+		return -ENOMEM;
+
+	/* tx bd */
+
+	ps->bd_table_vaddr =3D vaddr;
+	ps->bd_table_paddr =3D paddr;
+	ps->bd_table_len =3D len;
+
+	ps->tx_bd_vbase =3D vaddr;
+	ps->tx_bd_pbase =3D paddr;
+
+	pr_debug("TX descriptor table: vaddr=3D0x%p paddr=3D%pad\n", vaddr, &padd=
r);
+
+	/* rx bd */
+
+	vaddr =3D ((struct qtnf_pearl_tx_bd *)vaddr) + priv->tx_bd_num;
+	paddr +=3D priv->tx_bd_num * sizeof(struct qtnf_pearl_tx_bd);
+
+	ps->rx_bd_vbase =3D vaddr;
+	ps->rx_bd_pbase =3D paddr;
+
+	pr_debug("RX descriptor table: vaddr=3D0x%p paddr=3D%pad\n", vaddr, &padd=
r);
+
+	return 0;
+}
+
+static void hdp_rbd_attach_rev_b(struct qtnf_pcie_pearl_state *ps, u16 ind=
ex,
+				 dma_addr_t paddr)
+{
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(paddr),
+	       PCIE_HDP_HHBM_BUF_PTR_H(ps->pcie_reg_base));
+#endif
+	writel(QTN_HOST_LO32(paddr),
+	       PCIE_HDP_HHBM_BUF_PTR(ps->pcie_reg_base));
+
+	writel(index, PCIE_HDP_TX_HOST_Q_WR_PTR(ps->pcie_reg_base));
+}
+
+static void hdp_hhbm_init_rev_b(struct qtnf_pcie_pearl_state *ps)
+{
+	u32 val;
+
+	val =3D readl(PCIE_HHBM_CONFIG(ps->pcie_reg_base));
+	val |=3D HHBM_CONFIG_SOFT_RESET;
+	writel(val, PCIE_HHBM_CONFIG(ps->pcie_reg_base));
+	usleep_range(50, 100);
+	val &=3D ~HHBM_CONFIG_SOFT_RESET;
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	val |=3D HHBM_64BIT;
+#endif
+	writel(val, PCIE_HHBM_CONFIG(ps->pcie_reg_base));
+	writel(ps->base.rx_bd_num, PCIE_HHBM_Q_LIMIT_REG(ps->pcie_reg_base));
+}
+
+static void hdp_init_rev_b(struct qtnf_pcie_pearl_state *ps)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(ps->rx_bd_pbase),
+	       PCIE_HDP_TX_HOST_Q_BASE_H(ps->pcie_reg_base));
+#endif
+	writel(QTN_HOST_LO32(ps->rx_bd_pbase),
+	       PCIE_HDP_TX_HOST_Q_BASE_L(ps->pcie_reg_base));
+	writel(priv->rx_bd_num | (sizeof(struct qtnf_pearl_rx_bd)) << 16,
+	       PCIE_HDP_TX_HOST_Q_SZ_CTRL(ps->pcie_reg_base));
+}
+
+static void hdp_set_queues_rev_b(struct qtnf_pcie_pearl_state *ps,
+				 unsigned int tx_bd_size,
+				 unsigned int rx_bd_size)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	u32 val;
+
+	hdp_set_queues_common(ps, tx_bd_size, rx_bd_size);
+
+	val =3D tx_bd_size * sizeof(struct qtnf_pearl_tx_bd);
+	if (val > PCIE_HHBM_MAX_SIZE) {
+		pr_warn("invalid tx_bd_size value %u, use default %u\n",
+			tx_bd_size, ps->hdp_ops->hdp_tx_bd_size_default);
+		tx_bd_size =3D ps->hdp_ops->hdp_tx_bd_size_default;
+	}
+
+	val =3D rx_bd_size * sizeof(dma_addr_t);
+	if (val > PCIE_HHBM_MAX_SIZE) {
+		pr_warn("invalid rx_bd_size value %u, use default %u\n",
+			tx_bd_size, ps->hdp_ops->hdp_rx_bd_size_default);
+		rx_bd_size =3D ps->hdp_ops->hdp_rx_bd_size_default;
+	}
+
+	priv->tx_bd_num =3D tx_bd_size;
+	priv->rx_bd_num =3D rx_bd_size;
+}
+
+static u32 hdp_get_tx_done_index_rev_b(struct qtnf_pcie_pearl_state *ps)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	u32 v;
+
+	v =3D readl(PCIE_HDP_RX0DMA_CNT(ps->pcie_reg_base))
+		& (priv->tx_bd_num - 1);
+
+	return v;
+}
+
+static void hdp_tx_hw_push_rev_b(struct qtnf_pcie_pearl_state *ps, int ind=
ex,
+				 dma_addr_t paddr)
+{
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(paddr),
+	       PCIE_HDP_HOST_WR_DESC0_H(ps->pcie_reg_base));
+#endif
+	writel(QTN_HOST_LO32(paddr),
+	       PCIE_HDP_HOST_WR_DESC0(ps->pcie_reg_base));
+}
+
+static const struct qtnf_pcie_pearl_hdp_ops hdp_ops_rev_b =3D {
+	.hdp_tx_bd_size_default =3D 32,
+	.hdp_rx_bd_size_default =3D 256,
+	.hdp_alloc_bd_table =3D hdp_alloc_bd_table_rev_b,
+	.hdp_init =3D hdp_init_rev_b,
+	.hdp_hhbm_init =3D hdp_hhbm_init_rev_b,
+	.hdp_set_queues =3D hdp_set_queues_rev_b,
+	.hdp_rbd_attach =3D hdp_rbd_attach_rev_b,
+	.hdp_get_tx_done_index =3D hdp_get_tx_done_index_rev_b,
+	.hdp_tx_hw_push =3D hdp_tx_hw_push_rev_b,
+};
+
+/* common */
+
 static inline void qtnf_init_hdp_irqs(struct qtnf_pcie_pearl_state *ps)
 {
 	unsigned long flags;
@@ -229,56 +420,6 @@ static int qtnf_poll_state(__le32 __iomem *reg, u32 st=
ate, u32 delay_in_ms)
 	return 0;
 }
=20
-static int pearl_alloc_bd_table(struct qtnf_pcie_pearl_state *ps)
-{
-	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
-	dma_addr_t paddr;
-	void *vaddr;
-	int len;
-
-	len =3D priv->tx_bd_num * sizeof(struct qtnf_pearl_tx_bd) +
-		priv->rx_bd_num * sizeof(struct qtnf_pearl_rx_bd);
-
-	vaddr =3D dmam_alloc_coherent(&priv->pdev->dev, len, &paddr, GFP_KERNEL);
-	if (!vaddr)
-		return -ENOMEM;
-
-	/* tx bd */
-
-	ps->bd_table_vaddr =3D vaddr;
-	ps->bd_table_paddr =3D paddr;
-	ps->bd_table_len =3D len;
-
-	ps->tx_bd_vbase =3D vaddr;
-	ps->tx_bd_pbase =3D paddr;
-
-	pr_debug("TX descriptor table: vaddr=3D0x%p paddr=3D%pad\n", vaddr, &padd=
r);
-
-	priv->tx_bd_r_index =3D 0;
-	priv->tx_bd_w_index =3D 0;
-
-	/* rx bd */
-
-	vaddr =3D ((struct qtnf_pearl_tx_bd *)vaddr) + priv->tx_bd_num;
-	paddr +=3D priv->tx_bd_num * sizeof(struct qtnf_pearl_tx_bd);
-
-	ps->rx_bd_vbase =3D vaddr;
-	ps->rx_bd_pbase =3D paddr;
-
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	writel(QTN_HOST_HI32(paddr),
-	       PCIE_HDP_TX_HOST_Q_BASE_H(ps->pcie_reg_base));
-#endif
-	writel(QTN_HOST_LO32(paddr),
-	       PCIE_HDP_TX_HOST_Q_BASE_L(ps->pcie_reg_base));
-	writel(priv->rx_bd_num | (sizeof(struct qtnf_pearl_rx_bd)) << 16,
-	       PCIE_HDP_TX_HOST_Q_SZ_CTRL(ps->pcie_reg_base));
-
-	pr_debug("RX descriptor table: vaddr=3D0x%p paddr=3D%pad\n", vaddr, &padd=
r);
-
-	return 0;
-}
-
 static int pearl_skb2rbd_attach(struct qtnf_pcie_pearl_state *ps, u16 inde=
x)
 {
 	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
@@ -312,14 +453,8 @@ static int pearl_skb2rbd_attach(struct qtnf_pcie_pearl=
_state *ps, u16 index)
 	/* sync up all descriptor updates */
 	wmb();
=20
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	writel(QTN_HOST_HI32(paddr),
-	       PCIE_HDP_HHBM_BUF_PTR_H(ps->pcie_reg_base));
-#endif
-	writel(QTN_HOST_LO32(paddr),
-	       PCIE_HDP_HHBM_BUF_PTR(ps->pcie_reg_base));
+	ps->hdp_ops->hdp_rbd_attach(ps, index, paddr);
=20
-	writel(index, PCIE_HDP_TX_HOST_Q_WR_PTR(ps->pcie_reg_base));
 	return 0;
 }
=20
@@ -379,66 +514,15 @@ static void qtnf_pearl_free_xfer_buffers(struct qtnf_=
pcie_pearl_state *ps)
 	}
 }
=20
-static int pearl_hhbm_init(struct qtnf_pcie_pearl_state *ps)
-{
-	u32 val;
-
-	val =3D readl(PCIE_HHBM_CONFIG(ps->pcie_reg_base));
-	val |=3D HHBM_CONFIG_SOFT_RESET;
-	writel(val, PCIE_HHBM_CONFIG(ps->pcie_reg_base));
-	usleep_range(50, 100);
-	val &=3D ~HHBM_CONFIG_SOFT_RESET;
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	val |=3D HHBM_64BIT;
-#endif
-	writel(val, PCIE_HHBM_CONFIG(ps->pcie_reg_base));
-	writel(ps->base.rx_bd_num, PCIE_HHBM_Q_LIMIT_REG(ps->pcie_reg_base));
-
-	return 0;
-}
-
 static int qtnf_pcie_pearl_init_xfer(struct qtnf_pcie_pearl_state *ps,
 				     unsigned int tx_bd_size,
 				     unsigned int rx_bd_size)
 {
 	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
 	int ret;
-	u32 val;
=20
-	if (tx_bd_size =3D=3D 0)
-		tx_bd_size =3D PEARL_TX_BD_SIZE_DEFAULT;
-
-	val =3D tx_bd_size * sizeof(struct qtnf_pearl_tx_bd);
-
-	if (!is_power_of_2(tx_bd_size) || val > PCIE_HHBM_MAX_SIZE) {
-		pr_warn("invalid tx_bd_size value %u, use default %u\n",
-			tx_bd_size, PEARL_TX_BD_SIZE_DEFAULT);
-		priv->tx_bd_num =3D PEARL_TX_BD_SIZE_DEFAULT;
-	} else {
-		priv->tx_bd_num =3D tx_bd_size;
-	}
-
-	if (rx_bd_size =3D=3D 0)
-		rx_bd_size =3D PEARL_RX_BD_SIZE_DEFAULT;
-
-	val =3D rx_bd_size * sizeof(dma_addr_t);
-
-	if (!is_power_of_2(rx_bd_size) || val > PCIE_HHBM_MAX_SIZE) {
-		pr_warn("invalid rx_bd_size value %u, use default %u\n",
-			rx_bd_size, PEARL_RX_BD_SIZE_DEFAULT);
-		priv->rx_bd_num =3D PEARL_RX_BD_SIZE_DEFAULT;
-	} else {
-		priv->rx_bd_num =3D rx_bd_size;
-	}
-
-	priv->rx_bd_w_index =3D 0;
-	priv->rx_bd_r_index =3D 0;
-
-	ret =3D pearl_hhbm_init(ps);
-	if (ret) {
-		pr_err("failed to init h/w queues\n");
-		return ret;
-	}
+	ps->hdp_ops->hdp_set_queues(ps, tx_bd_size, rx_bd_size);
+	ps->hdp_ops->hdp_hhbm_init(ps);
=20
 	ret =3D qtnf_pcie_alloc_skb_array(priv);
 	if (ret) {
@@ -446,7 +530,7 @@ static int qtnf_pcie_pearl_init_xfer(struct qtnf_pcie_p=
earl_state *ps,
 		return ret;
 	}
=20
-	ret =3D pearl_alloc_bd_table(ps);
+	ret =3D ps->hdp_ops->hdp_alloc_bd_table(ps);
 	if (ret) {
 		pr_err("failed to allocate bd table\n");
 		return ret;
@@ -458,6 +542,8 @@ static int qtnf_pcie_pearl_init_xfer(struct qtnf_pcie_p=
earl_state *ps,
 		return ret;
 	}
=20
+	ps->hdp_ops->hdp_init(ps);
+
 	return ret;
 }
=20
@@ -474,9 +560,7 @@ static void qtnf_pearl_data_tx_reclaim(struct qtnf_pcie=
_pearl_state *ps)
=20
 	spin_lock_irqsave(&priv->tx_reclaim_lock, flags);
=20
-	tx_done_index =3D readl(PCIE_HDP_RX0DMA_CNT(ps->pcie_reg_base))
-			& (priv->tx_bd_num - 1);
-
+	tx_done_index =3D ps->hdp_ops->hdp_get_tx_done_index(ps);
 	i =3D priv->tx_bd_r_index;
=20
 	while (CIRC_CNT(tx_done_index, i, priv->tx_bd_num)) {
@@ -580,18 +664,13 @@ static int qtnf_pcie_skb_send(struct qtnf_bus *bus, s=
truct sk_buff *skb)
 	/* write new TX descriptor to PCIE_RX_FIFO on EP */
 	txbd_paddr =3D ps->tx_bd_pbase + i * sizeof(struct qtnf_pearl_tx_bd);
=20
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	writel(QTN_HOST_HI32(txbd_paddr),
-	       PCIE_HDP_HOST_WR_DESC0_H(ps->pcie_reg_base));
-#endif
-	writel(QTN_HOST_LO32(txbd_paddr),
-	       PCIE_HDP_HOST_WR_DESC0(ps->pcie_reg_base));
-
 	if (++i >=3D priv->tx_bd_num)
 		i =3D 0;
=20
 	priv->tx_bd_w_index =3D i;
=20
+	ps->hdp_ops->hdp_tx_hw_push(ps, i, txbd_paddr);
+
 tx_done:
 	if (ret && skb) {
 		pr_err_ratelimited("drop skb\n");
@@ -739,7 +818,7 @@ static int qtnf_pcie_pearl_rx_poll(struct napi_struct *=
napi, int budget)
 			consume =3D 0;
 		}
=20
-		if (skb && (skb_tailroom(skb) <  psize)) {
+		if (skb && (skb_tailroom(skb) < psize)) {
 			pr_err("skip packet with invalid length: %u > %u\n",
 			       psize, skb_tailroom(skb));
 			consume =3D 0;
@@ -777,7 +856,7 @@ static int qtnf_pcie_pearl_rx_poll(struct napi_struct *=
napi, int budget)
=20
 		priv->rx_bd_r_index =3D r_idx;
=20
-		/* repalce processed buffer by a new one */
+		/* replace processed buffer by a new one */
 		w_idx =3D priv->rx_bd_w_index;
 		while (CIRC_SPACE(priv->rx_bd_w_index, priv->rx_bd_r_index,
 				  priv->rx_bd_num) > 0) {
@@ -884,22 +963,10 @@ static int qtnf_dbg_hdp_stats(struct seq_file *s, voi=
d *data)
 	seq_printf(s, "tx_reclaim_req(%u)\n", priv->tx_reclaim_req);
=20
 	seq_printf(s, "tx_bd_r_index(%u)\n", priv->tx_bd_r_index);
-	seq_printf(s, "tx_bd_p_index(%u)\n",
-		   readl(PCIE_HDP_RX0DMA_CNT(ps->pcie_reg_base))
-			& (priv->tx_bd_num - 1));
 	seq_printf(s, "tx_bd_w_index(%u)\n", priv->tx_bd_w_index);
-	seq_printf(s, "tx queue len(%u)\n",
-		   CIRC_CNT(priv->tx_bd_w_index, priv->tx_bd_r_index,
-			    priv->tx_bd_num));
=20
 	seq_printf(s, "rx_bd_r_index(%u)\n", priv->rx_bd_r_index);
-	seq_printf(s, "rx_bd_p_index(%u)\n",
-		   readl(PCIE_HDP_TX0DMA_CNT(ps->pcie_reg_base))
-			& (priv->rx_bd_num - 1));
 	seq_printf(s, "rx_bd_w_index(%u)\n", priv->rx_bd_w_index);
-	seq_printf(s, "rx alloc queue len(%u)\n",
-		   CIRC_SPACE(priv->rx_bd_w_index, priv->rx_bd_r_index,
-			      priv->rx_bd_num));
=20
 	return 0;
 }
@@ -1108,7 +1175,8 @@ static u64 qtnf_pearl_dma_mask_get(void)
 #endif
 }
=20
-static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus, unsigned int tx_bd_=
size,
+static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus,
+				 unsigned int tx_bd_size,
 				 unsigned int rx_bd_size)
 {
 	struct qtnf_shm_ipc_int ipc_int;
@@ -1120,6 +1188,16 @@ static int qtnf_pcie_pearl_probe(struct qtnf_bus *bu=
s, unsigned int tx_bd_size,
 	spin_lock_init(&ps->irq_lock);
 	INIT_WORK(&bus->fw_work, qtnf_pearl_fw_work_handler);
=20
+	switch (bus->chipid) {
+	case QTN_CHIP_ID_PEARL:
+	case QTN_CHIP_ID_PEARL_B:
+		ps->hdp_ops =3D &hdp_ops_rev_b;
+		break;
+	default:
+		pr_err("unsupported PEARL chip ID 0x%x\n", bus->chipid);
+		return -ENOTSUPP;
+	}
+
 	ps->pcie_reg_base =3D ps->base.dmareg_bar;
 	ps->bda =3D ps->base.epmem_bar;
 	writel(ps->base.msi_enabled, &ps->bda->bda_rc_msi_enabled);
--=20
2.11.0

