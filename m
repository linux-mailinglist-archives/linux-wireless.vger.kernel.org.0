Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DDF15D6DF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBNLwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:18 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:44336 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgBNLwS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:18 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: TBF+hzJdIOLvmtFgrepvVYmXswrQrdmRiTugeK6tdMgH8lIfdo+olP25Zd7ym4ebeP0m5rGjnO
 YgiFvSfRQYAhqahuBcQvd7bcFJGGYlsxnAXDZyskyWbmfNLVemNtEU6rvF15XSTvvxD5srAzJE
 J4vrc0228o2DLsWtQOeNocKAuyC+Dr/foG3lVa8mgHbHaHH+xHzeJ6pAnm0sGMvGMuRSlTaSEU
 RqlNpCG30tM6Tgr7ZV9OxdHuq4waaB9HxGtPdhwvMkHJGllUBjzyT2Hkz+iaKM0YdY9tZfe7su
 H9s=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="64197884"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrlfWRVHdecF4KOE5YddKOgrpXWnVVYlhRDZZ/k9goeA53rcLxOK+xBVuftjqqxADb5p2FjBAUsCZU2S1x5hv2Y/QrThOImgfEnc55pkLdIAL2iRRE+bvZnKCI9PmM7tsrcSe1Gl0wTuA/1yqp16rbqNuLRnkT1Y7UykwoKUcWiJs/atzF8v+NxJPy42LgaNdQG3ecbfxl4V16z3e3xPNRkhzw+v2tVKCi8DdPKLF94/9lc2ay/aOSVIYdZDdClIVWQkExacQn71StPak2zi+k0imengfMG1JaaYRn6Z6C8YkVrh5xiCC/RlRoEF5m8kb5FLhC+zXgFND6SDfn845Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4T5Y6SGXu1kugvEHjbw/UIMbc7W1MnLPH2atAaWFfo=;
 b=feFF3RQSOthyK9MwfA8qMaq+uGMQMnvGXY10pPIaGmDtIUDFWv57rGLslhe5qAL0KQRDSdOLUP/aR383mIC2U+6hhV47293eCQJ5+L7Od2MO/8S+KktDCTMW7WcA6LVtE1WZ86NJmz7K16ikhVLw7tdPN6q9I1RuxIcrmkOr7vl9Ug6cZu8PgDZvQXkfJgZKVsUE+Fuefo5TL/5WsiVCoACVWiYT3HASakHOjWB4dyv+RsmizIgB9farj5rTpRAuSoibLz/JiD5+hulCLWvRji0ffwbuPl6DOj0iHRPt1TmJeMVLBOP0E0Bky4yCF7JmxBJ4fDLzqDcRlJunX4a/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4T5Y6SGXu1kugvEHjbw/UIMbc7W1MnLPH2atAaWFfo=;
 b=EHRx8tuCvmes2sTCUlfC1HhhOCXQDab1yqz7H7X4Oq1bpFI/z6cYA0NLb6EuTEsfjsnZuglSjPutOzalHXNU6/RzcJoxrvspJVUzMKQS8qLrt6Uf08o69z/zbP+RBs+xDwmHLKWLHHDI40HZA5z8V/DFQ1f/uZ/uNf0+bQ/u9ro=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:15 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:15 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/8] staging: wilc1000: make use of FIELD_GET/_PREP macro
Thread-Topic: [PATCH 1/8] staging: wilc1000: make use of FIELD_GET/_PREP macro
Thread-Index: AQHV4y0zpLk4/0zZ5UOS9u/6UMd/gg==
Date:   Fri, 14 Feb 2020 11:52:15 +0000
Message-ID: <20200214172250.13026-2-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3db65d6-e1c1-4526-84db-08d7b14455df
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1652D5981F04450E368EAEA2E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30/jYRV4YLrTF+C60Jd4A9uboPzIEiKo9uUMuaYM96U3MoLS0oUA008bXDKMKeXvycqnl6R01n+wwZmEyDWKYi9iyOQPQ2yIA0kmUIM45JFqF+HbjIW0dRhJluN29cVfZPQ64spvJzctYRlYtocXqr9wdHzolI32FCGf1mTHn6RFDvwyInwV9N6A8Drlj4jaV/cPlw+ddltU52ps6L1FNV6rS0VQoFDAQtB6KEF9JA1u2vnfQZ8WtpcmmPun1DOuh4aYRVRZGBXbb5g8A56FIzBcsn3oX1kjproTJHlCL5Ok3TsZ93pEENSp2UKZJ7d7IOGoYX+OIujhIPyGWn+HVYSsgoYbH+/p2evCRbR4rwQJRozOd7+J+0jFiQJXID/AByiDo5lSdcELI1UaCZlxzdBsixR7rcke94BL9S4espVodZ/dppJ2MSQiU1tYNrul
x-ms-exchange-antispam-messagedata: hy1ZeMDE2b6aNSa9F5A06jdZwVtouTo2TW8kjjQNmjFDVaWyXu1p69i9D5O7yPD6prJK7B3qMKfEY4k/dF7rsnFjYGKUm1pTtMXkzKUHzAnoW3rqTir2vvuyPIQY2Wp/8R4j8V+Ayjzoj2o6k3bQgQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3db65d6-e1c1-4526-84db-08d7b14455df
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:15.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wk+07f2cBmFn/XaDD2uTzP7P59xsl2HnshCp39Y0u+KciudxAbjOA4TNyEnFceRs4jATGH1ryWG1KBn7g9ixNNPz2cOpTufBh6djexIaUAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Simplified the code by making use of FIELD_GET/_PREP bitfield macro.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/cfg80211.c |  2 +-
 drivers/staging/wilc1000/mon.c      |  2 +-
 drivers/staging/wilc1000/netdev.h   |  2 --
 drivers/staging/wilc1000/spi.c      |  2 +-
 drivers/staging/wilc1000/wlan.c     | 32 +++++++++++++++--------------
 drivers/staging/wilc1000/wlan.h     | 20 +++++++++++++++++-
 6 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000=
/cfg80211.c
index d9c7bed2e6fb..995b1f306807 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -988,7 +988,7 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u3=
2 size)
 	s32 freq;
=20
 	header =3D get_unaligned_le32(buff - HOST_HDR_OFFSET);
-	pkt_offset =3D GET_PKT_OFFSET(header);
+	pkt_offset =3D FIELD_GET(WILC_PKT_HDR_OFFSET_FIELD, header);
=20
 	if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
 		bool ack =3D false;
diff --git a/drivers/staging/wilc1000/mon.c b/drivers/staging/wilc1000/mon.=
c
index 48ac33f06f63..60331417bd98 100644
--- a/drivers/staging/wilc1000/mon.c
+++ b/drivers/staging/wilc1000/mon.c
@@ -40,7 +40,7 @@ void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *=
buff, u32 size)
 	 * The packet offset field contain info about what type of management
 	 * the frame we are dealing with and ack status
 	 */
-	pkt_offset =3D GET_PKT_OFFSET(header);
+	pkt_offset =3D FIELD_GET(WILC_PKT_HDR_OFFSET_FIELD, header);
=20
 	if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
 		/* hostapd callback mgmt frame */
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/n=
etdev.h
index c475e78e3a69..e3689e2a4abb 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -29,8 +29,6 @@
 #define TCP_ACK_FILTER_LINK_SPEED_THRESH	54
 #define DEFAULT_LINK_SPEED			72
=20
-#define GET_PKT_OFFSET(a) (((a) >> 22) & 0x1ff)
-
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
 	unsigned long tx_packets;
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 9a9f3624e158..300c5c832572 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -898,7 +898,7 @@ static int wilc_spi_read_size(struct wilc *wilc, u32 *s=
ize)
 	int ret;
=20
 	ret =3D spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE, size);
-	*size =3D *size & IRQ_DMA_WD_CNT_MASK;
+	*size =3D FIELD_GET(IRQ_DMA_WD_CNT_MASK, *size);
=20
 	return ret;
 }
diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index 601e4d1345d2..9dfabd1af4e7 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -568,8 +568,8 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 			ret =3D func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
 			if (ret)
 				break;
-			if ((reg >> 2) & 0x1) {
-				entries =3D ((reg >> 3) & 0x3f);
+			if (FIELD_GET(WILC_VMM_ENTRY_AVAILABLE, reg)) {
+				entries =3D FIELD_GET(WILC_VMM_ENTRY_COUNT, reg);
 				break;
 			}
 			release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
@@ -610,6 +610,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 	do {
 		u32 header, buffer_offset;
 		char *bssid;
+		u8 mgmt_ptk =3D 0;
=20
 		tqe =3D wilc_wlan_txq_remove_from_head(dev);
 		if (!tqe)
@@ -620,15 +621,16 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_=
count)
 			break;
=20
 		le32_to_cpus(&vmm_table[i]);
-		vmm_sz =3D (vmm_table[i] & 0x3ff);
+		vmm_sz =3D FIELD_GET(WILC_VMM_BUFFER_SIZE, vmm_table[i]);
 		vmm_sz *=3D 4;
-		header =3D (tqe->type << 31) |
-			 (tqe->buffer_size << 15) |
-			 vmm_sz;
+
 		if (tqe->type =3D=3D WILC_MGMT_PKT)
-			header |=3D BIT(30);
-		else
-			header &=3D ~BIT(30);
+			mgmt_ptk =3D 1;
+
+		header =3D (FIELD_PREP(WILC_VMM_HDR_TYPE, tqe->type) |
+			  FIELD_PREP(WILC_VMM_HDR_MGMT_FIELD, mgmt_ptk) |
+			  FIELD_PREP(WILC_VMM_HDR_PKT_SIZE, tqe->buffer_size) |
+			  FIELD_PREP(WILC_VMM_HDR_BUFF_SIZE, vmm_sz));
=20
 		cpu_to_le32s(&header);
 		memcpy(&txb[offset], &header, 4);
@@ -686,10 +688,10 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wil=
c, u8 *buffer, int size)
 		buff_ptr =3D buffer + offset;
 		header =3D get_unaligned_le32(buff_ptr);
=20
-		is_cfg_packet =3D (header >> 31) & 0x1;
-		pkt_offset =3D (header >> 22) & 0x1ff;
-		tp_len =3D (header >> 11) & 0x7ff;
-		pkt_len =3D header & 0x7ff;
+		is_cfg_packet =3D FIELD_GET(WILC_PKT_HDR_CONFIG_FIELD, header);
+		pkt_offset =3D FIELD_GET(WILC_PKT_HDR_OFFSET_FIELD, header);
+		tp_len =3D FIELD_GET(WILC_PKT_HDR_TOTAL_LEN_FIELD, header);
+		pkt_len =3D FIELD_GET(WILC_PKT_HDR_LEN_FIELD, header);
=20
 		if (pkt_len =3D=3D 0 || tp_len =3D=3D 0)
 			break;
@@ -758,11 +760,11 @@ static void wilc_wlan_handle_isr_ext(struct wilc *wil=
c, u32 int_status)
 	int ret =3D 0;
 	struct rxq_entry_t *rqe;
=20
-	size =3D (int_status & 0x7fff) << 2;
+	size =3D FIELD_GET(WILC_INTERRUPT_DATA_SIZE, int_status) << 2;
=20
 	while (!size && retries < 10) {
 		wilc->hif_func->hif_read_size(wilc, &size);
-		size =3D (size & 0x7fff) << 2;
+		size =3D FIELD_GET(WILC_INTERRUPT_DATA_SIZE, size) << 2;
 		retries++;
 	}
=20
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 8c4634262adb..d3e822c374eb 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -8,6 +8,7 @@
 #define WILC_WLAN_H
=20
 #include <linux/types.h>
+#include <linux/bitfield.h>
=20
 /********************************************
  *
@@ -135,6 +136,23 @@
=20
 #define MODALIAS		"WILC_SPI"
 #define GPIO_NUM		0x44
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
 /*******************************************/
 /*        E0 and later Interrupt flags.    */
 /*******************************************/
@@ -150,7 +168,7 @@
 /* 21: INT5 flag                           */
 /*******************************************/
 #define IRG_FLAGS_OFFSET	16
-#define IRQ_DMA_WD_CNT_MASK	((1ul << IRG_FLAGS_OFFSET) - 1)
+#define IRQ_DMA_WD_CNT_MASK	GENMASK(IRG_FLAGS_OFFSET - 1, 0)
 #define INT_0			BIT(IRG_FLAGS_OFFSET)
 #define INT_1			BIT(IRG_FLAGS_OFFSET + 1)
 #define INT_2			BIT(IRG_FLAGS_OFFSET + 2)
--=20
2.24.0
