Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9C326E6A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhB0Rdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 12:33:47 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:51358 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhB0Ra3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 12:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=wc+RK5tGmY6FeIzTBNgzRNI0oDBWIJRtwAZQIRgUtTQ=;
        b=s4j60xmYCGwLc/6i/hQzpNbZyuX4fY/6MnLkowrig45AmzRcVoQZFwue5cYcO7aIKZyd
        rrUB/QhM3xKUoZBoL0Zyw+4K7X2jHf5KhTwwRdDadWb5237h+UmQODVCijC+nxDXYx3lDK
        WWoW0MMg4NHT2YwVlyn/W4NwjjhWTYji0=
Received: by filterdrecv-p3mdw1-7745b6f999-7qk4c with SMTP id filterdrecv-p3mdw1-7745b6f999-7qk4c-19-603A816A-12
        2021-02-27 17:29:14.413766753 +0000 UTC m=+918773.064330579
Received: from pearl.egauge.net (unknown)
        by ismtpd0019p1las1.sendgrid.net (SG) with ESMTP
        id kDsSDFThQAS8e12N_MxWqg
        Sat, 27 Feb 2021 17:29:14.204 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 6769B7002F9; Sat, 27 Feb 2021 10:29:13 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 1/4] wilc1000: Make SPI transfers work at 48MHz
Date:   Sat, 27 Feb 2021 17:29:14 +0000 (UTC)
Message-Id: <20210227172818.1711071-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224055135.1509200-1-davidm@egauge.net>
References: <20210224055135.1509200-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvD28VFlVK=2FSBvakiW?=
 =?us-ascii?Q?BfPEbAns3V3KtrMqegmhFVezLrH+4pyJpEtNe1P?=
 =?us-ascii?Q?1Oy4TLDWmX+NDU7VtOHzOLhfmWB2iCWeNOdGyR5?=
 =?us-ascii?Q?LWVFOAGch8ZTwCksYmgsuYP5v4hJi04ImaQH3ib?=
 =?us-ascii?Q?S3DMI2W1v7sscNV=2FZnf+NHcO8YP0nNflMPR5GKg?=
 =?us-ascii?Q?xFxUF3IlZWkEXGrRCu+iw=3D=3D?=
To:     linux-wireless@vger.kernel.org
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        davidm@egauge.net
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For CMD_SINGLE_READ and CMD_INTERNAL_READ, WILC may insert one or more
zero bytes between the command response and the DATA Start tag (0xf3).
This behavior appears to be undocumented in "ATWILC1000 USER GUIDE"
(https://tinyurl.com/4hhshdts) but we have observed 1-4 zero bytes
when the SPI bus operates at 48MHz and none when it operates at 1MHz.

This code is derived from the equivalent code of the wilc driver in
the linux-at91 repository.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 42 +++++++++++++------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index be732929322c..d11e365eeee2 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -11,6 +11,16 @@
 #include "netdev.h"
 #include "cfg80211.h"
 
+/*
+ * For CMD_SINGLE_READ and CMD_INTERNAL_READ, WILC may insert one or
+ * more zero bytes between the command response and the DATA Start tag
+ * (0xf3).  This behavior appears to be undocumented in "ATWILC1000
+ * USER GUIDE" (https://tinyurl.com/4hhshdts) but we have observed 1-4
+ * zero bytes when the SPI bus operates at 48MHz and none when it
+ * operates at 1MHz.
+ */
+#define WILC_SPI_RSP_HDR_EXTRA_DATA	8
+
 struct wilc_spi {
 	int crc_off;
 };
@@ -79,16 +89,15 @@ struct wilc_spi_cmd {
 } __packed;
 
 struct wilc_spi_read_rsp_data {
-	u8 rsp_cmd_type;
-	u8 status;
-	u8 resp_header;
-	u8 resp_data[4];
+	u8 header;
+	u8 data[4];
 	u8 crc[];
 } __packed;
 
 struct wilc_spi_rsp_data {
 	u8 rsp_cmd_type;
 	u8 status;
+	u8 data[];
 } __packed;
 
 static int wilc_bus_probe(struct spi_device *spi)
@@ -359,10 +368,11 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
 	u8 wb[32], rb[32];
-	int cmd_len, resp_len;
 	u8 crc[2];
+	int cmd_len, resp_len, i;
 	struct wilc_spi_cmd *c;
-	struct wilc_spi_read_rsp_data *r;
+	struct wilc_spi_read_rsp_data *r_data;
+	struct wilc_spi_rsp_data *r;
 
 	memset(wb, 0x0, sizeof(wb));
 	memset(rb, 0x0, sizeof(rb));
@@ -384,7 +394,8 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	}
 
 	cmd_len = offsetof(struct wilc_spi_cmd, u.simple_cmd.crc);
-	resp_len = sizeof(*r);
+	resp_len = sizeof(*r) + sizeof(*r_data) + WILC_SPI_RSP_HDR_EXTRA_DATA;
+
 	if (!spi_priv->crc_off) {
 		c->u.simple_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 		cmd_len += 1;
@@ -403,7 +414,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 		return -EINVAL;
 	}
 
-	r = (struct wilc_spi_read_rsp_data *)&rb[cmd_len];
+	r = (struct wilc_spi_rsp_data *)&rb[cmd_len];
 	if (r->rsp_cmd_type != cmd) {
 		dev_err(&spi->dev,
 			"Failed cmd response, cmd (%02x), resp (%02x)\n",
@@ -417,17 +428,22 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 		return -EINVAL;
 	}
 
-	if (WILC_GET_RESP_HDR_START(r->resp_header) != 0xf) {
-		dev_err(&spi->dev, "Error, data read response (%02x)\n",
-			r->resp_header);
+	for (i = 0; i < WILC_SPI_RSP_HDR_EXTRA_DATA; ++i)
+		if (WILC_GET_RESP_HDR_START(r->data[i]) == 0xf)
+			break;
+
+	if (i >= WILC_SPI_RSP_HDR_EXTRA_DATA) {
+		dev_err(&spi->dev, "Error, data start missing\n");
 		return -EINVAL;
 	}
 
+	r_data = (struct wilc_spi_read_rsp_data *)&r->data[i];
+
 	if (b)
-		memcpy(b, r->resp_data, 4);
+		memcpy(b, r_data->data, 4);
 
 	if (!spi_priv->crc_off)
-		memcpy(crc, r->crc, 2);
+		memcpy(crc, r_data->crc, 2);
 
 	return 0;
 }
-- 
2.25.1

