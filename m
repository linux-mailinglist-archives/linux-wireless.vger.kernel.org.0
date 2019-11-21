Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27B110539B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUNyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 08:54:06 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:45504 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbfKUNyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 08:54:05 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALDoQVa004659
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 06:54:01 -0700
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wacgv4yhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 06:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcVLLU7WSBzyysdhV+wRuS/q6CfIApRaLAD2yaFxDjuQDONgIddFevf5EmBJFI9Ll5Iwp7HmU/mTagwSEjQf2oFPMSP3euS91dMFFRX9o6IPx7041qFjyEChtltk3D1Lmn7aZIJ5JctROXVQZCtrR7vIsIJDkebvVV7E/w5XwlRt8Fnqho8uePT8h5Ljpg0pOux3bMDmNm/buw4JCvwwiyI9cbJDhGHt0EMfgOs489lGbnaKSKPFl2bfT42oN6uho068ZcHkFfs+Wz1OM+Dahm4rh8j6HCciyAsNnoQwRnAuVcV+qm1/fg3jfvn9UbAY4j/wo4Tzu3iyrOtgbhO0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRVjIFGxFOD5HADf7q4EfTLYZZaNEyy95ohfhE+pHk=;
 b=iItshGqTEABH/1Mi4vTZ0Xc5KuEXFpeZhgqJwc2900ovKdC0E0uBEqv5sBrjM4BBljG1wKspYb59d7k/P84hFQO7qpjssvotpM2rmPN2fp79tdS6MtrkvCNKNHbuUliUHV4sIRwomo8iZ+bX8LpvJVG34a74kQ/cHXeXbL6Dw+YNLK0IdPABoWgeJcXDVzNkGLuT/PVMM+LAnAKrJ32H0Ur3dzYn1Emxf+ZGo4ZDsmvWvP8LaUuls+yWbnYB1MPxIWcTVyGL9nrpKlXMD3lAirTiOtfbZWmRl0RkmDeNTnkqvQ+cXrlDC1g/8g/h4yn+vFqMy+GxdlODJFn3LA73ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRVjIFGxFOD5HADf7q4EfTLYZZaNEyy95ohfhE+pHk=;
 b=dLW2p1vGBbgGZ8qxtLcDMPU/rkUSbD1X3L0UrgdOMkgi8JJHY1GZGG4ddRdZNRPF/ICyOIWvUOqvaLKyspSiTcc9Vfr2CzUwHcLBhiUzSZArXueZfxYrbB/U+cSisCD0XymjtVEhntdDX21mfCtvKFJywFp4to5UJpDpBjWkRM0=
Received: from SN4PR0501MB3855.namprd05.prod.outlook.com (10.167.139.160) by
 SN4PR0501MB3790.namprd05.prod.outlook.com (10.167.142.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.10; Thu, 21 Nov 2019 13:53:59 +0000
Received: from SN4PR0501MB3855.namprd05.prod.outlook.com
 ([fe80::f4f6:8d67:626e:5e0d]) by SN4PR0501MB3855.namprd05.prod.outlook.com
 ([fe80::f4f6:8d67:626e:5e0d%7]) with mapi id 15.20.2474.015; Thu, 21 Nov 2019
 13:53:58 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4270.namprd05.prod.outlook.com (52.135.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 13:53:35 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:53:35 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g chip
Thread-Topic: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g
 chip
Thread-Index: AQHVoHMR0ukm5y7dAE2j+TmxTB5e3A==
Date:   Thu, 21 Nov 2019 13:53:35 +0000
Message-ID: <20191121135324.21715-3-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 090f7a25-1854-487c-b82a-08d76e8a33cb
x-ms-traffictypediagnostic: SN6PR05MB4270:|SN4PR0501MB3790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB4270CD8422347D33A2F7CA47A34E0@SN6PR05MB4270.namprd05.prod.outlook.com>
x-moderation-data: 11/21/2019 1:53:56 PM
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39840400004)(136003)(396003)(199004)(189003)(8676002)(6436002)(6486002)(478600001)(103116003)(4326008)(6916009)(14454004)(6512007)(5640700003)(107886003)(25786009)(81156014)(446003)(11346002)(3846002)(2616005)(26005)(186003)(386003)(6506007)(102836004)(436003)(2501003)(2906002)(6116002)(81166006)(7736002)(36756003)(50226002)(2351001)(305945005)(8936002)(76176011)(52116002)(66066001)(71200400001)(71190400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(1076003)(30864003)(66946007)(5024004)(99286004)(54906003)(316002)(256004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0501MB3790;H:SN4PR0501MB3855.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //BcUVzrVkYm6c2mh7jl7JmEmFRg2AIeHshQVjQL4KJCetnlFmLNUM1nOKpWVNNDgo2FYrRZa7jwUpKMsYG1EEF5bmqzsplZW3qsFLXGarBHVHzfylQQakLwdGeRu7g0me2m/YgyirUJVW5WPWujK+tFHX2OO1CrV7g3riJmyvwV3T976MVJBMwkeXxnlc1OEQ9FtaOHA5pTyMYZwhY7MuZcgu4p8uWYCT1a61dWAd8S9CUJWgMPlQ3Q8HUzkn+X66oZSdJUamfVHb6kvHIY04DOatnQEPukOkhS34U89u24OgcWevauUHzlK4hO2wPInn2dRQAPYGnsggrHQ/R99tJwaCK5t7pArsrsJVP2X6K4+A5FpJ/VPrzgzB8VaRaVQL4A4o6eIUzk8Qc7WG2i4XDRIEM2zniluTkYRzPrX/Yx9/XiQer4TKxOCZD/1MSc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090f7a25-1854-487c-b82a-08d76e8a33cb
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZZbkbSPB0dBmUrq9bCwXat4dvbycUg02V1QcX9fA2Ma4EXlBr4aADiPlT0ChpthBknfTNPKQgKMePDpOw+URxkZoxpuWSrRmA6cK3PoWf/+fncL7unEUGcRhWBzR9B9uOwfahVIOO1DBsl2Wn3OQHGM5evKI6oukdsDzEKvaJXLviQDYgdKSQ/Q4BzM8rlsXHZCbNJIzcItpoh1QlaqufBdNREWz4Tuyf7dpOblVQE=
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 13:53:58.8185
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0501MB3790
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for the new minor revision of QSR10g chip. Major changes from
the driver perspective include PCIe data path modifications. Setup is now
more complicated, but finally more things have been offloaded to hardware.
As a result, less driver boilerplate operations are needed after Tx/Rx
descriptors queues have been configured. Besides, restrictions on
descriptors queue lengths have been relaxed.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |   1 +
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 273 +++++++++++++++++=
++--
 .../quantenna/qtnfmac/pcie/pearl_pcie_ipc.h        |   3 +
 .../quantenna/qtnfmac/pcie/pearl_pcie_regs.h       |  33 ++-
 .../net/wireless/quantenna/qtnfmac/qtn_hw_ids.h    |   1 +
 drivers/net/wireless/quantenna/qtnfmac/util.c      |   2 +
 6 files changed, 297 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/n=
et/wireless/quantenna/qtnfmac/pcie/pcie.c
index 1a1896c4c042..45bb84007bd5 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -322,6 +322,7 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
 	case QTN_CHIP_ID_PEARL:
 	case QTN_CHIP_ID_PEARL_B:
 	case QTN_CHIP_ID_PEARL_C:
+	case QTN_CHIP_ID_PEARL_C1:
 		bus =3D qtnf_pcie_pearl_alloc(pdev);
 		break;
 	case QTN_CHIP_ID_TOPAZ:
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 32506f700cca..7b01fa7fab1c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -57,8 +57,6 @@ struct qtnf_pearl_rx_bd {
 	__le32 addr_h;
 	__le32 info;
 	__le32 info_h;
-	__le32 next_ptr;
-	__le32 next_ptr_h;
 } __packed;
=20
 struct qtnf_pearl_fw_hdr {
@@ -78,12 +76,15 @@ struct qtnf_pcie_pearl_hdp_ops {
 	int (*hdp_alloc_bd_table)(struct qtnf_pcie_pearl_state *ps);
 	void (*hdp_init)(struct qtnf_pcie_pearl_state *ps);
 	void (*hdp_hhbm_init)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_enable)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_disable)(struct qtnf_pcie_pearl_state *ps);
 	void (*hdp_set_queues)(struct qtnf_pcie_pearl_state *ps,
 			       unsigned int tx_bd_size,
 			       unsigned int rx_bd_size);
 	void (*hdp_rbd_attach)(struct qtnf_pcie_pearl_state *ps, u16 index,
 			       dma_addr_t paddr);
 	u32 (*hdp_get_tx_done_index)(struct qtnf_pcie_pearl_state *ps);
+	void (*hdp_tx_done_wrap)(struct qtnf_pcie_pearl_state *ps);
 	void (*hdp_tx_hw_push)(struct qtnf_pcie_pearl_state *ps, int index,
 			       dma_addr_t paddr);
=20
@@ -105,8 +106,19 @@ struct qtnf_pcie_pearl_state {
 	struct qtnf_pearl_rx_bd *rx_bd_vbase;
 	dma_addr_t rx_bd_pbase;
=20
+	dma_addr_t rx_dma_cnt_paddr;
+	void *rx_dma_cnt_vaddr;
+
+	dma_addr_t tx_dma_cnt_paddr;
+	void *tx_dma_cnt_vaddr;
+
 	dma_addr_t bd_table_paddr;
 	void *bd_table_vaddr;
+
+	u32 tx_bd_ack_wrap;
+	u16 rx_bd_h_index;
+	u16 tx_bd_h_index;
+
 	u32 bd_table_len;
 	u32 pcie_irq_mask;
 	u32 pcie_irq_rx_count;
@@ -280,12 +292,234 @@ static const struct qtnf_pcie_pearl_hdp_ops hdp_ops_=
rev_b =3D {
 	.hdp_alloc_bd_table =3D hdp_alloc_bd_table_rev_b,
 	.hdp_init =3D hdp_init_rev_b,
 	.hdp_hhbm_init =3D hdp_hhbm_init_rev_b,
+	.hdp_enable =3D NULL,
+	.hdp_disable =3D NULL,
 	.hdp_set_queues =3D hdp_set_queues_rev_b,
 	.hdp_rbd_attach =3D hdp_rbd_attach_rev_b,
 	.hdp_get_tx_done_index =3D hdp_get_tx_done_index_rev_b,
+	.hdp_tx_done_wrap =3D NULL,
 	.hdp_tx_hw_push =3D hdp_tx_hw_push_rev_b,
 };
=20
+/* HDP ops: rev C */
+
+static int hdp_alloc_bd_table_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	dma_addr_t paddr;
+	void *vaddr;
+	int len;
+
+	len =3D priv->tx_bd_num * sizeof(struct qtnf_pearl_tx_bd) +
+		priv->rx_bd_num * sizeof(struct qtnf_pearl_rx_bd) +
+		2 * QTN_HDP_DMA_PTR_SIZE;
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
+	/* dma completion counters */
+
+	vaddr =3D ((struct qtnf_pearl_rx_bd *)vaddr) + priv->rx_bd_num;
+	paddr +=3D priv->rx_bd_num * sizeof(struct qtnf_pearl_rx_bd);
+
+	ps->rx_dma_cnt_vaddr =3D vaddr;
+	ps->rx_dma_cnt_paddr =3D paddr;
+
+	vaddr +=3D QTN_HDP_DMA_PTR_SIZE;
+	paddr +=3D QTN_HDP_DMA_PTR_SIZE;
+
+	ps->tx_dma_cnt_vaddr =3D vaddr;
+	ps->tx_dma_cnt_paddr =3D paddr;
+
+	return 0;
+}
+
+static void hdp_rbd_attach_rev_c(struct qtnf_pcie_pearl_state *ps, u16 ind=
ex,
+				 dma_addr_t paddr)
+{
+	u16 ihw;
+
+	ihw =3D index | (ps->rx_bd_h_index & QTN_HDP_BD_WRAP);
+	if (ihw < ps->rx_bd_h_index)
+		ihw ^=3D QTN_HDP_BD_WRAP;
+
+	writel(ihw | ((ihw ^ QTN_HDP_BD_WRAP) << 16),
+	       PCIE_HDP_TX0_DESC_Q_WR_PTR(ps->pcie_reg_base));
+
+	ps->rx_bd_h_index =3D ihw;
+}
+
+static void hdp_hhbm_init_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	u32 val;
+
+	val =3D readl(PCIE_HHBM_CONFIG(ps->pcie_reg_base));
+	val |=3D HHBM_CONFIG_SOFT_RESET;
+	writel(val, PCIE_HHBM_CONFIG(ps->pcie_reg_base));
+	usleep_range(50, 100);
+}
+
+static void hdp_init_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	int mrrs =3D pcie_get_readrq(priv->pdev);
+	int mps =3D pcie_get_mps(priv->pdev);
+	u32 val;
+
+	val =3D readl(PCIE_HDP_AXI_MASTER_CTRL(ps->pcie_reg_base));
+
+	if (mrrs > PCIE_HDP_AXI_BURST32_SIZE)
+		val |=3D PCIE_HDP_AXI_EN_BURST32_READ;
+	else
+		val &=3D ~PCIE_HDP_AXI_EN_BURST32_READ;
+
+	if (mps > PCIE_HDP_AXI_BURST32_SIZE)
+		val |=3D PCIE_HDP_AXI_EN_BURST32_WRITE;
+	else
+		val &=3D ~PCIE_HDP_AXI_EN_BURST32_WRITE;
+
+	writel(val, PCIE_HDP_AXI_MASTER_CTRL(ps->pcie_reg_base));
+
+	/* HDP Tx init */
+
+	writel(PCIE_HDP_RXDMA_INTERLEAVE | PCIE_HDP_RXDMA_NEW |
+	       PCIE_HDP_RXDMA_WPTR, PCIE_HDP_RXDMA_CTRL(ps->pcie_reg_base));
+	writel(PCIE_HDP_TXDMA_NEW, PCIE_HDP_TX_DMA_CTRL(ps->pcie_reg_base));
+
+	writel(QTN_HOST_LO32(ps->tx_bd_pbase),
+	       PCIE_HDP_RX2_DESC_BASE_ADDR(ps->pcie_reg_base));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(ps->tx_bd_pbase),
+	       PCIE_HDP_RX2_DESC_BASE_ADDR_H(ps->pcie_reg_base));
+#endif
+
+	writel(priv->tx_bd_num | (sizeof(struct qtnf_pearl_tx_bd) << 16),
+	       PCIE_HDP_RX2_DESC_Q_CTRL(ps->pcie_reg_base));
+
+	writel(QTN_HOST_LO32(ps->tx_dma_cnt_paddr),
+	       PCIE_HDP_RX2_DEV_PTR_ADDR(ps->pcie_reg_base));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(ps->tx_dma_cnt_paddr),
+	       PCIE_HDP_RX2_DEV_PTR_ADDR_H(ps->pcie_reg_base));
+#endif
+	writel(ps->tx_bd_h_index,
+	       PCIE_HDP_RX2_DESC_Q_WR_PTR(ps->pcie_reg_base));
+
+	/* HDP Rx init */
+
+	writel(QTN_HOST_LO32(ps->rx_bd_pbase),
+	       PCIE_HDP_TX0_DESC_BASE_ADDR(ps->pcie_reg_base));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(ps->rx_bd_pbase),
+	       PCIE_HDP_TX0_DESC_BASE_ADDR_H(ps->pcie_reg_base));
+#endif
+	writel(priv->rx_bd_num | (sizeof(struct qtnf_pearl_rx_bd) << 16),
+	       PCIE_HDP_TX0_DESC_Q_CTRL(ps->pcie_reg_base));
+
+	writel(QTN_HOST_LO32(ps->rx_dma_cnt_paddr),
+	       PCIE_HDP_TX0_DEV_PTR_ADDR(ps->pcie_reg_base));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	writel(QTN_HOST_HI32(ps->rx_dma_cnt_paddr),
+	       PCIE_HDP_TX0_DEV_PTR_ADDR_H(ps->pcie_reg_base));
+#endif
+}
+
+static u32 hdp_get_tx_done_index_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	u32 v;
+
+	v =3D le32_to_cpu(*((__le32 *)ps->tx_dma_cnt_vaddr)) &
+		(priv->tx_bd_num - 1);
+
+	return v;
+}
+
+static void hdp_tx_done_wrap_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	ps->tx_bd_ack_wrap ^=3D (QTN_HDP_BD_WRAP << 16);
+}
+
+static void hdp_tx_hw_push_rev_c(struct qtnf_pcie_pearl_state *ps, int ind=
ex,
+				 dma_addr_t paddr)
+{
+	struct qtnf_pcie_bus_priv *priv =3D &ps->base;
+	u32 ihw;
+
+	ihw =3D index | (ps->tx_bd_h_index & QTN_HDP_BD_WRAP);
+
+	if (ihw < ps->tx_bd_h_index)
+		ihw ^=3D QTN_HDP_BD_WRAP;
+
+	writel(ihw | (priv->tx_bd_r_index << 16) | ps->tx_bd_ack_wrap,
+	       PCIE_HDP_RX2_DESC_Q_WR_PTR(ps->pcie_reg_base));
+
+	ps->tx_bd_h_index =3D ihw;
+}
+
+static void hdp_enable_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	u32 val;
+
+	val =3D readl(PCIE_HDP_RX2_DESC_Q_CTRL(ps->pcie_reg_base));
+	val |=3D PCIE_HDP_DESC_FETCH_EN;
+	writel(val, PCIE_HDP_RX2_DESC_Q_CTRL(ps->pcie_reg_base));
+
+	val =3D readl(PCIE_HDP_TX0_DESC_Q_CTRL(ps->pcie_reg_base));
+	val |=3D PCIE_HDP_DESC_FETCH_EN;
+	writel(val, PCIE_HDP_TX0_DESC_Q_CTRL(ps->pcie_reg_base));
+}
+
+static void hdp_disable_rev_c(struct qtnf_pcie_pearl_state *ps)
+{
+	u32 val;
+
+	val =3D readl(PCIE_HDP_RX2_DESC_Q_CTRL(ps->pcie_reg_base));
+	val &=3D ~PCIE_HDP_DESC_FETCH_EN;
+	writel(val, PCIE_HDP_RX2_DESC_Q_CTRL(ps->pcie_reg_base));
+
+	val =3D readl(PCIE_HDP_TX0_DESC_Q_CTRL(ps->pcie_reg_base));
+	val &=3D ~PCIE_HDP_DESC_FETCH_EN;
+	writel(val, PCIE_HDP_TX0_DESC_Q_CTRL(ps->pcie_reg_base));
+}
+
+static const struct qtnf_pcie_pearl_hdp_ops hdp_ops_rev_c =3D {
+	.hdp_rx_bd_size_default =3D 512,
+	.hdp_tx_bd_size_default =3D 512,
+	.hdp_alloc_bd_table =3D hdp_alloc_bd_table_rev_c,
+	.hdp_init =3D hdp_init_rev_c,
+	.hdp_hhbm_init =3D hdp_hhbm_init_rev_c,
+	.hdp_enable =3D hdp_enable_rev_c,
+	.hdp_disable =3D hdp_disable_rev_c,
+	.hdp_set_queues =3D hdp_set_queues_common,
+	.hdp_rbd_attach =3D hdp_rbd_attach_rev_c,
+	.hdp_get_tx_done_index =3D hdp_get_tx_done_index_rev_c,
+	.hdp_tx_done_wrap =3D hdp_tx_done_wrap_rev_c,
+	.hdp_tx_hw_push =3D hdp_tx_hw_push_rev_c,
+};
+
 /* common */
=20
 static inline void qtnf_init_hdp_irqs(struct qtnf_pcie_pearl_state *ps)
@@ -586,8 +820,11 @@ static void qtnf_pearl_data_tx_reclaim(struct qtnf_pci=
e_pearl_state *ps)
 		priv->tx_skb[i] =3D NULL;
 		count++;
=20
-		if (++i >=3D priv->tx_bd_num)
+		if (++i >=3D priv->tx_bd_num) {
+			if (ps->hdp_ops->hdp_tx_done_wrap)
+				ps->hdp_ops->hdp_tx_done_wrap(ps);
 			i =3D 0;
+		}
 	}
=20
 	priv->tx_reclaim_done +=3D count;
@@ -727,11 +964,17 @@ static irqreturn_t qtnf_pcie_pearl_interrupt(int irq,=
 void *data)
 	u32 status;
=20
 	priv->pcie_irq_count++;
-	status =3D readl(PCIE_HDP_INT_STATUS(ps->pcie_reg_base));
=20
 	qtnf_shm_ipc_irq_handler(&priv->shm_ipc_ep_in);
 	qtnf_shm_ipc_irq_handler(&priv->shm_ipc_ep_out);
=20
+	writel(0x0, PCIE_HDP_INT_EN(ps->pcie_reg_base));
+	status =3D readl(PCIE_HDP_INT_STATUS(ps->pcie_reg_base));
+	writel(status & ps->pcie_irq_mask,
+	       PCIE_HDP_INT_STATUS(ps->pcie_reg_base));
+	writel(ps->pcie_irq_mask & (~status),
+	       PCIE_HDP_INT_EN(ps->pcie_reg_base));
+
 	if (!(status & ps->pcie_irq_mask))
 		goto irq_done;
=20
@@ -744,20 +987,13 @@ static irqreturn_t qtnf_pcie_pearl_interrupt(int irq,=
 void *data)
 	if (status & PCIE_HDP_INT_HHBM_UF)
 		ps->pcie_irq_uf_count++;
=20
-	if (status & PCIE_HDP_INT_RX_BITS) {
-		qtnf_dis_rxdone_irq(ps);
+	if (status & PCIE_HDP_INT_RX_BITS)
 		napi_schedule(&bus->mux_napi);
-	}
=20
-	if (status & PCIE_HDP_INT_TX_BITS) {
-		qtnf_dis_txdone_irq(ps);
+	if (status & PCIE_HDP_INT_TX_BITS)
 		tasklet_hi_schedule(&priv->reclaim_tq);
-	}
=20
 irq_done:
-	/* H/W workaround: clean all bits, not only enabled */
-	qtnf_non_posted_write(~0U, PCIE_HDP_INT_STATUS(ps->pcie_reg_base));
-
 	if (!priv->msi_enabled)
 		qtnf_deassert_intx(ps);
=20
@@ -896,6 +1132,8 @@ static void qtnf_pcie_data_rx_start(struct qtnf_bus *b=
us)
 	struct qtnf_pcie_pearl_state *ps =3D (void *)get_bus_priv(bus);
=20
 	qtnf_enable_hdp_irqs(ps);
+	if (ps->hdp_ops->hdp_enable)
+		ps->hdp_ops->hdp_enable(ps);
 	napi_enable(&bus->mux_napi);
 }
=20
@@ -904,6 +1142,8 @@ static void qtnf_pcie_data_rx_stop(struct qtnf_bus *bu=
s)
 	struct qtnf_pcie_pearl_state *ps =3D (void *)get_bus_priv(bus);
=20
 	napi_disable(&bus->mux_napi);
+	if (ps->hdp_ops->hdp_disable)
+		ps->hdp_ops->hdp_disable(ps);
 	qtnf_disable_hdp_irqs(ps);
 }
=20
@@ -1124,7 +1364,8 @@ static void qtnf_pearl_fw_work_handler(struct work_st=
ruct *work)
=20
 	} else {
 		pr_info("starting firmware upload: %s\n", fwname);
-
+		if (ps->hdp_ops->hdp_enable)
+			ps->hdp_ops->hdp_enable(ps);
 		ret =3D qtnf_ep_fw_load(ps, fw->data, fw->size);
 		release_firmware(fw);
 		if (ret) {
@@ -1193,6 +1434,10 @@ static int qtnf_pcie_pearl_probe(struct qtnf_bus *bu=
s,
 	case QTN_CHIP_ID_PEARL_B:
 		ps->hdp_ops =3D &hdp_ops_rev_b;
 		break;
+	case QTN_CHIP_ID_PEARL_C:
+	case QTN_CHIP_ID_PEARL_C1:
+		ps->hdp_ops =3D &hdp_ops_rev_c;
+		break;
 	default:
 		pr_err("unsupported PEARL chip ID 0x%x\n", bus->chipid);
 		return -ENOTSUPP;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_ipc.h b=
/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_ipc.h
index 634480fe6a64..42a67d66d9e8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_ipc.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_ipc.h
@@ -61,6 +61,9 @@
=20
 #define QTN_ENET_ADDR_LENGTH	6
=20
+#define QTN_HDP_BD_WRAP		0x8000
+#define QTN_HDP_DMA_PTR_SIZE	(4 * sizeof(u64))
+
 #define QTN_TXDONE_MASK		((u32)0x80000000)
 #define QTN_GET_LEN(x)		((x) & 0xFFFF)
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_regs.h =
b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_regs.h
index 6e9a5c61d46f..945d27b36852 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_regs.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie_regs.h
@@ -4,7 +4,7 @@
 #ifndef __PEARL_PCIE_H
 #define __PEARL_PCIE_H
=20
-/* Pearl PCIe HDP registers */
+/* Pearl rev B PCIe HDP registers */
 #define PCIE_HDP_CTRL(base)			((base) + 0x2c00)
 #define PCIE_HDP_AXI_CTRL(base)			((base) + 0x2c04)
 #define PCIE_HDP_HOST_WR_DESC0(base)		((base) + 0x2c10)
@@ -60,7 +60,6 @@
 #define PCIE_HDP_RX3DMA_CNT(base)		((base) + 0x2d1c)
 #define PCIE_HDP_TX0DMA_CNT(base)		((base) + 0x2d20)
 #define PCIE_HDP_TX1DMA_CNT(base)		((base) + 0x2d24)
-#define PCIE_HDP_RXDMA_CTRL(base)		((base) + 0x2d28)
 #define PCIE_HDP_TX_HOST_Q_SZ_CTRL(base)	((base) + 0x2d2c)
 #define PCIE_HDP_TX_HOST_Q_BASE_L(base)		((base) + 0x2d30)
 #define PCIE_HDP_TX_HOST_Q_BASE_H(base)		((base) + 0x2d34)
@@ -68,6 +67,36 @@
 #define PCIE_HDP_TX_HOST_Q_RD_PTR(base)		((base) + 0x2d3c)
 #define PCIE_HDP_TX_HOST_Q_STS(base)		((base) + 0x2d40)
=20
+#define PCIE_HDP_TX_DMA_CTRL(base)		((base) + 0x2dcc)
+#define PCIE_HDP_TXDMA_NEW			(BIT(8))
+
+#define PCIE_HDP_RXDMA_CTRL(base)		((base) + 0x2d28)
+#define PCIE_HDP_RXDMA_WPTR			(BIT(27))
+#define PCIE_HDP_RXDMA_NEW			(BIT(29))
+#define PCIE_HDP_RXDMA_INTERLEAVE		(BIT(30))
+
+/* Pearl rev C PCIe HDP registers */
+#define PCIE_HDP_TX0_DEV_PTR_ADDR(base)		((base) + 0x2db0)
+#define PCIE_HDP_TX0_DEV_PTR_ADDR_H(base)	((base) + 0x2db4)
+#define PCIE_HDP_TX0_DESC_Q_WR_PTR(base)	((base) + 0x2da4)
+#define PCIE_HDP_TX0_DESC_BASE_ADDR(base)	((base) + 0x2dac)
+#define PCIE_HDP_TX0_DESC_BASE_ADDR_H(base)	((base) + 0x2da8)
+
+#define PCIE_HDP_RX2_DESC_BASE_ADDR(base)	((base) + 0x2c20)
+#define PCIE_HDP_RX2_DESC_BASE_ADDR_H(base)	((base) + 0x2c24)
+#define PCIE_HDP_RX2_DESC_Q_WR_PTR(base)	((base) + 0x2d84)
+#define PCIE_HDP_RX2_DEV_PTR_ADDR(base)		((base) + 0x2dd8)
+#define PCIE_HDP_RX2_DEV_PTR_ADDR_H(base)	((base) + 0x2ddc)
+
+#define PCIE_HDP_TX0_DESC_Q_CTRL(base)		((base) + 0x2da0)
+#define PCIE_HDP_RX2_DESC_Q_CTRL(base)		((base) + 0x2d80)
+#define PCIE_HDP_DESC_FETCH_EN			(BIT(31))
+
+#define PCIE_HDP_AXI_MASTER_CTRL(base)		((base) + 0x2de0)
+#define PCIE_HDP_AXI_EN_BURST32_READ		(BIT(3) | BIT(7))
+#define PCIE_HDP_AXI_EN_BURST32_WRITE		BIT(11)
+#define PCIE_HDP_AXI_BURST32_SIZE		(32 * 8)
+
 /* Pearl PCIe HBM pool registers */
 #define PCIE_HHBM_CSR_REG(base)			((base) + 0x2e00)
 #define PCIE_HHBM_Q_BASE_REG(base)		((base) + 0x2e04)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h b/drivers/=
net/wireless/quantenna/qtnfmac/qtn_hw_ids.h
index 82d879950b62..d962126602cd 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h
@@ -18,6 +18,7 @@
 #define QTN_CHIP_ID_PEARL		0x50
 #define QTN_CHIP_ID_PEARL_B		0x60
 #define QTN_CHIP_ID_PEARL_C		0x70
+#define QTN_CHIP_ID_PEARL_C1		0x80
=20
 /* FW names */
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/util.c b/drivers/net/wi=
reless/quantenna/qtnfmac/util.c
index cda6f5f3f38a..afad12ce3ba5 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/util.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/util.c
@@ -116,6 +116,8 @@ const char *qtnf_chipid_to_string(unsigned long chip_id=
)
 		return "Pearl revB";
 	case QTN_CHIP_ID_PEARL_C:
 		return "Pearl revC";
+	case QTN_CHIP_ID_PEARL_C1:
+		return "Pearl revC1";
 	default:
 		return "unknown";
 	}
--=20
2.11.0

