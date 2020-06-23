Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D90204FD2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgFWLAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:34 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33243 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732389AbgFWLAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910017; x=1624446017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VjH23gc3eRUT676f0kgNM8agxiSf56E44Tv6HpqlB78=;
  b=zgGW5lHXG5GfxmO5woVJWWp+JKBfOWKqR6PyvdIF/DZpNXNU/1k5j0rZ
   fGBfgPYaNk0fq5EbV5HVwkeNkOCfJy6pEmup6vJyhq3UyvGrOe4KuBCs4
   WWjrc1b3hp60R3F/j2PlG1TB1ZSxNzspVOHiGDPX7YN/INgTm2L/8rDA8
   cB4umnuHfCbIQpTmbKQF6T6BlwYsLQwcFlLczmz4hDcyccgU3A8LO4eOo
   wxb4yam9oSVB4anRNUjRajr85bXXX/25oEjQuM2Tujj2sJgo9fkywIk6Q
   7oa2ny43bfHSt+ZdCSQmPskztWHs3v2D/08UH1mvv6Lve0ijZM+lOeVNy
   w==;
IronPort-SDR: Ay5XfaU5YD0zov+IgOf9+YGHfZyZm8+nfX3xM1i12B4jQnzNAqf+8EF5vagqlnv8H7vs1tiZvf
 QWuDm715SLQn4hyS88CJrv2ejyk9Bm0k6AAbnbbcTKorSrt/KWvIAOH7oMXo0KmmWh6/eiTDl4
 GJcax5atFTlVYOWGaD/nuYGQMo5MPMvcWnqr2gqZPSDh3TrJvtYzSYF92FRApdKjdo1pjsbKZY
 /Edhz3LEhX4KMxSLdtAnrgwmK7zh0VB16HGc+kYbWb4zST+XebicIvKI6aa9JGG0UurJojz2V5
 F6U=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="84732781"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 04:00:17 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 04:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJDxEcxs2gRNWq9L3KmjbgELt2SL7cHZwI6eH9Mt0Evf++ahixa+sDOQFRmE+QM8A+N3Rx1CeIFEhI7tHba+JGm10yis/9AdjuHiqJml5ve5FRA77GeYzUX1deGLP7CzoIw1z/nzB4DcdUGO+7QSTPJgvyPnf52bX+V0muqbiIB3YcdDeestXb1C6Od7ZKVmnjTqjA6tonDAzGF2/JuHXFrrTHMs07ZiKxzwCcxv5f50LmTU8xrYecNLXLr0YOCbhxu1aOmwRTascqSmlUQxZy1JcKT1sp0Eiw9G/392breI9lHcGoY093PJD2AVXa/pgTaEaj2gnBfCUJCSbEea8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7yHVCr/Ep9FhqaViwfpyYJod0wMVy9Q1dLiNe4y6cY=;
 b=kAYVOsVb0kB8LtdwepV+fwZMP0c9zfoTbWmuf95HRLY+yU0pwreqOjTlK0uNdP/vaTbOchgoXUmQL2pPbA88JZyuoggIvDu6eLAWm4LdmzmlKwEzsk1hcLaPOdFcGrGLWFJx/2xDgqiDEZwf9VxfwigjcyVe2m7rfP8uYKuhH93smpBYDjfOkodKNzmzkNVSP/QbHX8o6etE1ozO+L8wcMiK7bz+mN0cau459AOucpHpRoAj+6wplgENsFmCFSuQG56/WuHErh+F8Ll0vhB95bKy2NNCP0vngTT1Rsji3c1DXAGYDEdDmHyZzWxr4k9B7savouAQhx6Qs1Rw6fYrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7yHVCr/Ep9FhqaViwfpyYJod0wMVy9Q1dLiNe4y6cY=;
 b=cWZ/arrU6qsTlfAP3uFOVL4t+npKMZEQxYOIEMwMrqXUVrkVoat/8Hb3I7Yt9bVHKhlBKpeSTDY2mHAaSEYYljt5+YAyeObT0kmgChIC2Gc1oAMuP9k6+2fYRy3cCRIQW+jsa8BUUPZCeKuTg43gTwQP3KEz8uGoggvyJaU5sf0=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:12 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:12 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 12/17] wilc1000: add wlan.h
Thread-Topic: [PATCH v7 12/17] wilc1000: add wlan.h
Thread-Index: AQHWSU13WpwRHvFrAEmYdpDjIjTHqg==
Date:   Tue, 23 Jun 2020 11:00:11 +0000
Message-ID: <20200623110000.31559-13-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: e477c45e-aa96-4b07-9af6-08d8176499fa
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB355185A8D4027429884D7249E3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y19ycDDUYrqgBBKLZX6bI2TvRlGljJlfxuAmHLJCXNvLXGD+oKenGkKntFEB3PhhC3DE84ZCMfYTHqpUOFfu9VQZ54xNyraAG/HdTlf8zwNEdZHW/eZigNQsmQxX98RvegBGdgj4ZA49x3LwQ6SSHSetEXxmuxgMR8NV4hjfe95m8NB5frqm/U2Rom9S7t8cFJ0N9fhT06T8yKPXSTuhRMcfDT26gm86EnM3mrVupP6a5QJNVVztHolCZn53n0MoMdf4N7peaiB7vJc715xZ5+Wmnlam8I2//3XgypEjvVAzFo6QF+6xsK0BWNacRS1yRMwqHJpD+ErFhxDGiEnq7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(30864003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 05+S58lX/7+W+CVEG7FAKjrkYQwUc/XJ2TlS4sFDbhOHe6nA50rna8jMGXqn1KczQrfxDbPoKe9+c6rn3QVI+IqfKkY05hr+s13D8znNul3tLJMuF5YcV91Cy3SlbyTu5I3UBpV5EOuuE9Gd3gq/vmD6zfHlsbN8q8aM0s/8mlu+YhMsDoUQQW2maeE9VdyakTyvhoNW7xyC05aKewoHpbd+YLPReCaoBMBNx7jNxf4S6ikhcaGzE31dJCtoDx/C+lS5vK/T1SkUQBGFrKT1aV/xlaT/nmT0lPu4XZcosPrredlyAdpPgX9aGmwYF5gS+wdf6d1TN0p28TOR08BrwwHMSzcauS7UmJA9bG9Mv0qLfhbUXUYf2GlykzPDuOyT2V+KrET7zenq/fSkADrlYd/VY9U+4sqz//TyIdl2958b+0/twSfdC0L87n9y89onYhpxTFNQjvM7vqipU52R8leQRaXaTYKINJhZOQN/jQjVrCkASq/TJu+puMz8c/24
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e477c45e-aa96-4b07-9af6-08d8176499fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:11.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmzU7wVB2GZ/ReCkik6Vvupq210woTDizstxGLh3ro9cjfOlrGYY6YMWsj2L40nW3dOhfhTa4ZwcAeAujQ8LWSDmCa0IOWc7Gs856kbY92s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/wlan.h' to
'drivers/net/wireless/microchip/wilc1000/wlan.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wlan.h    | 397 ++++++++++++++++++
 1 file changed, 397 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan.h

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
new file mode 100644
index 000000000000..7689569cd82f
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -0,0 +1,397 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_WLAN_H
+#define WILC_WLAN_H
+
+#include <linux/types.h>
+#include <linux/bitfield.h>
+
+/********************************************
+ *
+ *      Mac eth header length
+ *
+ ********************************************/
+#define MAX_MAC_HDR_LEN			26 /* QOS_MAC_HDR_LEN */
+#define SUB_MSDU_HEADER_LENGTH		14
+#define SNAP_HDR_LEN			8
+#define ETHERNET_HDR_LEN		14
+#define WORD_ALIGNMENT_PAD		0
+
+#define ETH_ETHERNET_HDR_OFFSET		(MAX_MAC_HDR_LEN + \
+					 SUB_MSDU_HEADER_LENGTH + \
+					 SNAP_HDR_LEN - \
+					 ETHERNET_HDR_LEN + \
+					 WORD_ALIGNMENT_PAD)
+
+#define HOST_HDR_OFFSET			4
+#define ETHERNET_HDR_LEN		14
+#define IP_HDR_LEN			20
+#define IP_HDR_OFFSET			ETHERNET_HDR_LEN
+#define UDP_HDR_OFFSET			(IP_HDR_LEN + IP_HDR_OFFSET)
+#define UDP_HDR_LEN			8
+#define UDP_DATA_OFFSET			(UDP_HDR_OFFSET + UDP_HDR_LEN)
+#define ETH_CONFIG_PKT_HDR_LEN		UDP_DATA_OFFSET
+
+#define ETH_CONFIG_PKT_HDR_OFFSET	(ETH_ETHERNET_HDR_OFFSET + \
+					 ETH_CONFIG_PKT_HDR_LEN)
+
+/********************************************
+ *
+ *      Register Defines
+ *
+ ********************************************/
+#define WILC_PERIPH_REG_BASE		0x1000
+#define WILC_CHANGING_VIR_IF		0x108c
+#define WILC_CHIPID			WILC_PERIPH_REG_BASE
+#define WILC_GLB_RESET_0		(WILC_PERIPH_REG_BASE + 0x400)
+#define WILC_PIN_MUX_0			(WILC_PERIPH_REG_BASE + 0x408)
+#define WILC_HOST_TX_CTRL		(WILC_PERIPH_REG_BASE + 0x6c)
+#define WILC_HOST_RX_CTRL_0		(WILC_PERIPH_REG_BASE + 0x70)
+#define WILC_HOST_RX_CTRL_1		(WILC_PERIPH_REG_BASE + 0x74)
+#define WILC_HOST_VMM_CTL		(WILC_PERIPH_REG_BASE + 0x78)
+#define WILC_HOST_RX_CTRL		(WILC_PERIPH_REG_BASE + 0x80)
+#define WILC_HOST_RX_EXTRA_SIZE		(WILC_PERIPH_REG_BASE + 0x84)
+#define WILC_HOST_TX_CTRL_1		(WILC_PERIPH_REG_BASE + 0x88)
+#define WILC_MISC			(WILC_PERIPH_REG_BASE + 0x428)
+#define WILC_INTR_REG_BASE		(WILC_PERIPH_REG_BASE + 0xa00)
+#define WILC_INTR_ENABLE		WILC_INTR_REG_BASE
+#define WILC_INTR2_ENABLE		(WILC_INTR_REG_BASE + 4)
+
+#define WILC_INTR_POLARITY		(WILC_INTR_REG_BASE + 0x10)
+#define WILC_INTR_TYPE			(WILC_INTR_REG_BASE + 0x20)
+#define WILC_INTR_CLEAR			(WILC_INTR_REG_BASE + 0x30)
+#define WILC_INTR_STATUS		(WILC_INTR_REG_BASE + 0x40)
+
+#define WILC_RF_REVISION_ID		0x13f4
+
+#define WILC_VMM_TBL_SIZE		64
+#define WILC_VMM_TX_TBL_BASE		0x150400
+#define WILC_VMM_RX_TBL_BASE		0x150500
+
+#define WILC_VMM_BASE			0x150000
+#define WILC_VMM_CORE_CTL		WILC_VMM_BASE
+#define WILC_VMM_TBL_CTL		(WILC_VMM_BASE + 0x4)
+#define WILC_VMM_TBL_ENTRY		(WILC_VMM_BASE + 0x8)
+#define WILC_VMM_TBL0_SIZE		(WILC_VMM_BASE + 0xc)
+#define WILC_VMM_TO_HOST_SIZE		(WILC_VMM_BASE + 0x10)
+#define WILC_VMM_CORE_CFG		(WILC_VMM_BASE + 0x14)
+#define WILC_VMM_TBL_ACTIVE		(WILC_VMM_BASE + 040)
+#define WILC_VMM_TBL_STATUS		(WILC_VMM_BASE + 0x44)
+
+#define WILC_SPI_REG_BASE		0xe800
+#define WILC_SPI_CTL			WILC_SPI_REG_BASE
+#define WILC_SPI_MASTER_DMA_ADDR	(WILC_SPI_REG_BASE + 0x4)
+#define WILC_SPI_MASTER_DMA_COUNT	(WILC_SPI_REG_BASE + 0x8)
+#define WILC_SPI_SLAVE_DMA_ADDR		(WILC_SPI_REG_BASE + 0xc)
+#define WILC_SPI_SLAVE_DMA_COUNT	(WILC_SPI_REG_BASE + 0x10)
+#define WILC_SPI_TX_MODE		(WILC_SPI_REG_BASE + 0x20)
+#define WILC_SPI_PROTOCOL_CONFIG	(WILC_SPI_REG_BASE + 0x24)
+#define WILC_SPI_INTR_CTL		(WILC_SPI_REG_BASE + 0x2c)
+#define WILC_SPI_INT_STATUS		(WILC_SPI_REG_BASE + 0x40)
+#define WILC_SPI_INT_CLEAR		(WILC_SPI_REG_BASE + 0x44)
+
+#define WILC_SPI_WAKEUP_REG		0x1
+#define WILC_SPI_WAKEUP_BIT		BIT(1)
+
+#define WILC_SPI_PROTOCOL_OFFSET	(WILC_SPI_PROTOCOL_CONFIG - \
+					 WILC_SPI_REG_BASE)
+
+#define WILC_SPI_CLOCKLESS_ADDR_LIMIT	0x30
+
+/* Functions IO enables bits */
+#define WILC_SDIO_CCCR_IO_EN_FUNC1	BIT(1)
+
+/* Function/Interrupt enables bits */
+#define WILC_SDIO_CCCR_IEN_MASTER	BIT(0)
+#define WILC_SDIO_CCCR_IEN_FUNC1	BIT(1)
+
+/* Abort CCCR register bits */
+#define WILC_SDIO_CCCR_ABORT_RESET	BIT(3)
+
+/* Vendor specific CCCR registers */
+#define WILC_SDIO_WAKEUP_REG		0xf0
+#define WILC_SDIO_WAKEUP_BIT		BIT(0)
+
+#define WILC_SDIO_CLK_STATUS_REG	0xf1
+#define WILC_SDIO_CLK_STATUS_BIT	BIT(0)
+
+#define WILC_SDIO_INTERRUPT_DATA_SZ_REG	0xf2 /* Read size (2 bytes) */
+
+#define WILC_SDIO_VMM_TBL_CTRL_REG	0xf6
+#define WILC_SDIO_IRQ_FLAG_REG		0xf7
+#define WILC_SDIO_IRQ_CLEAR_FLAG_REG	0xf8
+
+#define WILC_SDIO_HOST_TO_FW_REG	0xfa
+#define WILC_SDIO_HOST_TO_FW_BIT	BIT(0)
+
+#define WILC_SDIO_FW_TO_HOST_REG	0xfc
+#define WILC_SDIO_FW_TO_HOST_BIT	BIT(0)
+
+/* Function 1 specific FBR register */
+#define WILC_SDIO_FBR_CSA_REG		0x10C /* CSA pointer (3 bytes) */
+#define WILC_SDIO_FBR_DATA_REG		0x10F
+
+#define WILC_SDIO_F1_DATA_REG		0x0
+#define WILC_SDIO_EXT_IRQ_FLAG_REG	0x4
+
+#define WILC_AHB_DATA_MEM_BASE		0x30000
+#define WILC_AHB_SHARE_MEM_BASE		0xd0000
+
+#define WILC_VMM_TBL_RX_SHADOW_BASE	WILC_AHB_SHARE_MEM_BASE
+#define WILC_VMM_TBL_RX_SHADOW_SIZE	256
+
+#define WILC_FW_HOST_COMM		0x13c0
+#define WILC_GP_REG_0			0x149c
+#define WILC_GP_REG_1			0x14a0
+
+#define WILC_HAVE_SDIO_IRQ_GPIO		BIT(0)
+#define WILC_HAVE_USE_PMU		BIT(1)
+#define WILC_HAVE_SLEEP_CLK_SRC_RTC	BIT(2)
+#define WILC_HAVE_SLEEP_CLK_SRC_XO	BIT(3)
+#define WILC_HAVE_EXT_PA_INV_TX_RX	BIT(4)
+#define WILC_HAVE_LEGACY_RF_SETTINGS	BIT(5)
+#define WILC_HAVE_XTAL_24		BIT(6)
+#define WILC_HAVE_DISABLE_WILC_UART	BIT(7)
+#define WILC_HAVE_USE_IRQ_AS_HOST_WAKE	BIT(8)
+
+#define WILC_CORTUS_INTERRUPT_BASE	0x10A8
+#define WILC_CORTUS_INTERRUPT_1		(WILC_CORTUS_INTERRUPT_BASE + 0x4)
+#define WILC_CORTUS_INTERRUPT_2		(WILC_CORTUS_INTERRUPT_BASE + 0x8)
+
+/* tx control register 1 to 4 for RX */
+#define WILC_REG_4_TO_1_RX		0x1e1c
+
+/* tx control register 1 to 4 for TX Bank_0 */
+#define WILC_REG_4_TO_1_TX_BANK0	0x1e9c
+
+#define WILC_CORTUS_RESET_MUX_SEL	0x1118
+#define WILC_CORTUS_BOOT_REGISTER	0xc0000
+
+#define WILC_CORTUS_BOOT_FROM_IRAM	0x71
+
+#define WILC_1000_BASE_ID		0x100000
+
+#define WILC_1000_BASE_ID_2A		0x1002A0
+#define WILC_1000_BASE_ID_2A_REV1	(WILC_1000_BASE_ID_2A + 1)
+
+#define WILC_1000_BASE_ID_2B		0x1002B0
+#define WILC_1000_BASE_ID_2B_REV1	(WILC_1000_BASE_ID_2B + 1)
+#define WILC_1000_BASE_ID_2B_REV2	(WILC_1000_BASE_ID_2B + 2)
+
+#define WILC_CHIP_REV_FIELD		GENMASK(11, 0)
+
+/********************************************
+ *
+ *      Wlan Defines
+ *
+ ********************************************/
+#define WILC_CFG_PKT		1
+#define WILC_NET_PKT		0
+#define WILC_MGMT_PKT		2
+
+#define WILC_CFG_SET		1
+#define WILC_CFG_QUERY		0
+
+#define WILC_CFG_RSP		1
+#define WILC_CFG_RSP_STATUS	2
+#define WILC_CFG_RSP_SCAN	3
+
+#define WILC_ABORT_REQ_BIT		BIT(31)
+
+#define WILC_RX_BUFF_SIZE	(96 * 1024)
+#define WILC_TX_BUFF_SIZE	(64 * 1024)
+
+#define MODALIAS		"WILC_SPI"
+
+#define WILC_PKT_HDR_CONFIG_FIELD	BIT(31)
+#define WILC_PKT_HDR_OFFSET_FIELD	GENMASK(30, 22)
+#define WILC_PKT_HDR_TOTAL_LEN_FIELD	GENMASK(21, 11)
+#define WILC_PKT_HDR_LEN_FIELD		GENMASK(10, 0)
+
+#define WILC_INTERRUPT_DATA_SIZE	GENMASK(14, 0)
+
+#define WILC_VMM_BUFFER_SIZE		GENMASK(9, 0)
+
+#define WILC_VMM_HDR_TYPE		BIT(31)
+#define WILC_VMM_HDR_MGMT_FIELD		BIT(30)
+#define WILC_VMM_HDR_PKT_SIZE		GENMASK(29, 15)
+#define WILC_VMM_HDR_BUFF_SIZE		GENMASK(14, 0)
+
+#define WILC_VMM_ENTRY_COUNT		GENMASK(8, 3)
+#define WILC_VMM_ENTRY_AVAILABLE	BIT(2)
+/*******************************************/
+/*        E0 and later Interrupt flags.    */
+/*******************************************/
+/*******************************************/
+/*        E0 and later Interrupt flags.    */
+/*           IRQ Status word               */
+/* 15:0 =3D DMA count in words.              */
+/* 16: INT0 flag                           */
+/* 17: INT1 flag                           */
+/* 18: INT2 flag                           */
+/* 19: INT3 flag                           */
+/* 20: INT4 flag                           */
+/* 21: INT5 flag                           */
+/*******************************************/
+#define IRG_FLAGS_OFFSET	16
+#define IRQ_DMA_WD_CNT_MASK	GENMASK(IRG_FLAGS_OFFSET - 1, 0)
+#define INT_0			BIT(IRG_FLAGS_OFFSET)
+#define INT_1			BIT(IRG_FLAGS_OFFSET + 1)
+#define INT_2			BIT(IRG_FLAGS_OFFSET + 2)
+#define INT_3			BIT(IRG_FLAGS_OFFSET + 3)
+#define INT_4			BIT(IRG_FLAGS_OFFSET + 4)
+#define INT_5			BIT(IRG_FLAGS_OFFSET + 5)
+#define MAX_NUM_INT		5
+#define IRG_FLAGS_MASK		GENMASK(IRG_FLAGS_OFFSET + MAX_NUM_INT, \
+					IRG_FLAGS_OFFSET)
+
+/*******************************************/
+/*        E0 and later Interrupt flags.    */
+/*           IRQ Clear word                */
+/* 0: Clear INT0                           */
+/* 1: Clear INT1                           */
+/* 2: Clear INT2                           */
+/* 3: Clear INT3                           */
+/* 4: Clear INT4                           */
+/* 5: Clear INT5                           */
+/* 6: Select VMM table 1                   */
+/* 7: Select VMM table 2                   */
+/* 8: Enable VMM                           */
+/*******************************************/
+#define CLR_INT0		BIT(0)
+#define CLR_INT1		BIT(1)
+#define CLR_INT2		BIT(2)
+#define CLR_INT3		BIT(3)
+#define CLR_INT4		BIT(4)
+#define CLR_INT5		BIT(5)
+#define SEL_VMM_TBL0		BIT(6)
+#define SEL_VMM_TBL1		BIT(7)
+#define EN_VMM			BIT(8)
+
+#define DATA_INT_EXT		INT_0
+#define ALL_INT_EXT		DATA_INT_EXT
+#define NUM_INT_EXT		1
+#define UNHANDLED_IRQ_MASK	GENMASK(MAX_NUM_INT - 1, NUM_INT_EXT)
+
+#define DATA_INT_CLR		CLR_INT0
+
+#define ENABLE_RX_VMM		(SEL_VMM_TBL1 | EN_VMM)
+#define ENABLE_TX_VMM		(SEL_VMM_TBL0 | EN_VMM)
+/* time for expiring the completion of cfg packets */
+#define WILC_CFG_PKTS_TIMEOUT	msecs_to_jiffies(2000)
+
+#define IS_MANAGMEMENT		0x100
+#define IS_MANAGMEMENT_CALLBACK	0x080
+#define IS_MGMT_STATUS_SUCCES	0x040
+
+#define WILC_WID_TYPE		GENMASK(15, 12)
+#define WILC_VMM_ENTRY_FULL_RETRY	1
+/********************************************
+ *
+ *      Tx/Rx Queue Structure
+ *
+ ********************************************/
+
+struct txq_entry_t {
+	struct list_head list;
+	int type;
+	int ack_idx;
+	u8 *buffer;
+	int buffer_size;
+	void *priv;
+	int status;
+	struct wilc_vif *vif;
+	void (*tx_complete_func)(void *priv, int status);
+};
+
+struct rxq_entry_t {
+	struct list_head list;
+	u8 *buffer;
+	int buffer_size;
+};
+
+/********************************************
+ *
+ *      Host IF Structure
+ *
+ ********************************************/
+struct wilc;
+struct wilc_hif_func {
+	int (*hif_init)(struct wilc *wilc, bool resume);
+	int (*hif_deinit)(struct wilc *wilc);
+	int (*hif_read_reg)(struct wilc *wilc, u32 addr, u32 *data);
+	int (*hif_write_reg)(struct wilc *wilc, u32 addr, u32 data);
+	int (*hif_block_rx)(struct wilc *wilc, u32 addr, u8 *buf, u32 size);
+	int (*hif_block_tx)(struct wilc *wilc, u32 addr, u8 *buf, u32 size);
+	int (*hif_read_int)(struct wilc *wilc, u32 *int_status);
+	int (*hif_clear_int_ext)(struct wilc *wilc, u32 val);
+	int (*hif_read_size)(struct wilc *wilc, u32 *size);
+	int (*hif_block_tx_ext)(struct wilc *wilc, u32 addr, u8 *buf, u32 size);
+	int (*hif_block_rx_ext)(struct wilc *wilc, u32 addr, u8 *buf, u32 size);
+	int (*hif_sync_ext)(struct wilc *wilc, int nint);
+	int (*enable_interrupt)(struct wilc *nic);
+	void (*disable_interrupt)(struct wilc *nic);
+};
+
+#define WILC_MAX_CFG_FRAME_SIZE		1468
+
+struct tx_complete_data {
+	int size;
+	void *buff;
+	struct sk_buff *skb;
+};
+
+struct wilc_cfg_cmd_hdr {
+	u8 cmd_type;
+	u8 seq_no;
+	__le16 total_len;
+	__le32 driver_handler;
+};
+
+struct wilc_cfg_frame {
+	struct wilc_cfg_cmd_hdr hdr;
+	u8 frame[WILC_MAX_CFG_FRAME_SIZE];
+};
+
+struct wilc_cfg_rsp {
+	u8 type;
+	u8 seq_no;
+};
+
+struct wilc;
+struct wilc_vif;
+
+int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
+				u32 buffer_size);
+int wilc_wlan_start(struct wilc *wilc);
+int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif);
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buff=
er,
+			      u32 buffer_size,
+			      void (*tx_complete_fn)(void *, int));
+int wilc_wlan_handle_txq(struct wilc *wl, u32 *txq_count);
+void wilc_handle_isr(struct wilc *wilc);
+void wilc_wlan_cleanup(struct net_device *dev);
+int wilc_wlan_cfg_set(struct wilc_vif *vif, int start, u16 wid, u8 *buffer=
,
+		      u32 buffer_size, int commit, u32 drv_handler);
+int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, u16 wid, int commit=
,
+		      u32 drv_handler);
+int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buf=
fer,
+			       u32 buffer_size, void (*func)(void *, int));
+void wilc_enable_tcp_ack_filter(struct wilc_vif *vif, bool value);
+int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
+netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
+
+void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size);
+void host_wakeup_notify(struct wilc *wilc);
+void host_sleep_notify(struct wilc *wilc);
+void chip_allow_sleep(struct wilc *wilc);
+void chip_wakeup(struct wilc *wilc);
+int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
+			 u32 count);
+int wilc_wlan_init(struct net_device *dev);
+u32 wilc_get_chipid(struct wilc *wilc, bool update);
+#endif
--=20
2.24.0
