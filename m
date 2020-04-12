Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC421A5E15
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgDLKnF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 06:43:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37884 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLKnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 06:43:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so98183wrx.4
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zHfsef7NHUN0aINqdzpeYG8qDWLWrG7Wr0QIj1l+iLU=;
        b=nYr0zOas+ZRTqLQGPyx8BKYp93cBUJF5t+lQORq/dfYUmw79gIuaR/Abf0+69puZ9X
         0uixok0+9ZLUj6lNAHAZ7jqbNEvqPw+7H54GoH+5uQKrA5/VjGVFEFWhobD3kbivlCOS
         atOg5R2PNsrQti8BQuIyBUBY5YN4Wy8JuiPFjJ/PFIAATe9IEn5tw/pgv99qNCdo8gbf
         RrqSFWpXDafJZO7j5F4km6ReWKqmoeohoCIhRjmsZtWlfI3ezZwiFqwJo1kQq2Bw6h2t
         AV2ebdF2k+NJXXXyzheOtjJRJ+OrNSFQIZZgQAyurBpmWpvAoKqgs+ezmvQWsZP98LLc
         bsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zHfsef7NHUN0aINqdzpeYG8qDWLWrG7Wr0QIj1l+iLU=;
        b=CAfCmfEA38nGpqI9MKti0/pBmj71wtRXD+GIFwuGXvoG8CcbFgvDmBB6PG+AQesx2F
         953D0n4mVX8fiN3EKHSuBjlVr5p4TVOClLQOuR1z8lWy6uAh5Hp2im0rKzXG+XAnRwPF
         Ev9HBmJUmtusQX6g7oVFy8sYbgthz/0C0nTUZ11/Ra5PDEm4f2UmlcRG8+RvHVjUwO+A
         s9phLtBk62VPYUx5ChA0aIMtLFkOZjyqjg1CnvQXtOhQ8W6TvSVgJCCZdOFfXcOqzq+K
         cKRqWPUJQFvDpb0ijuDe1o+cW11eQBSk//hT/XUSdNbxLxROYPHU6bemhLRwE/3RLl7c
         E3KA==
X-Gm-Message-State: AGi0PubXvjxgmW1AZGqc42o9JD+IS2OyzSkC62twttFVNRlSYk7ExKAK
        BFA5SWor+aLUuLlp6K7a7FpEXojk
X-Google-Smtp-Source: APiQypKRcNn24/GguPRfgqku0YvYN2F7TxyHgvuDLoowFwMbgPbEdN61mrCsLn3ZTMdr9cELnXiIpg==
X-Received: by 2002:adf:97d9:: with SMTP id t25mr2681428wrb.157.1586688183445;
        Sun, 12 Apr 2020 03:43:03 -0700 (PDT)
Received: from [192.168.43.18] (92.40.249.57.threembb.co.uk. [92.40.249.57])
        by smtp.gmail.com with ESMTPSA id z16sm11222025wrl.0.2020.04.12.03.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 03:43:02 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH v2] staging: vt6656: formulate rspinf values into tables
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <addca9e1-9ea2-59ee-dec9-3afb3c731c2e@gmail.com>
Date:   Sun, 12 Apr 2020 11:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Four tables can be extracted from RSPINF_A_* based on BB_TYPE_11A or
else being GB rates.

Preamble short or long tables from fixed size len of 14 for RSPINF_B rates.

Remove function vnt_calculate_ofdm_rate and replace with the tables
calling RSPINF_A and RSPINF_B separately.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
v1 has error in vnt_rspinf_a_table.

 drivers/staging/vt6656/card.c | 196 +++++++---------------------------
 1 file changed, 40 insertions(+), 156 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 82c775bd20d2..dedb343f3ef3 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -74,99 +74,25 @@ void vnt_set_channel(struct vnt_private *priv, u32 connection_channel)
 			   (u8)(connection_channel | 0x80));
 }
 
-/*
- * Description: Calculate TxRate and RsvTime fields for RSPINF in OFDM mode.
- *
- * Parameters:
- * In:
- *	rate	- Tx Rate
- *	bb_type	- Tx Packet type
- * Out:
- *	tx_rate	- pointer to RSPINF TxRate field
- *	rsv_time- pointer to RSPINF RsvTime field
- *
- * Return Value: none
- *
- */
-static void vnt_calculate_ofdm_rate(u16 rate, u8 bb_type,
-				    u8 *tx_rate, u8 *rsv_time)
-{
-	switch (rate) {
-	case RATE_6M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x9b;
-			*rsv_time = 24;
-		} else {
-			*tx_rate = 0x8b;
-			*rsv_time = 30;
-		}
-		break;
-	case RATE_9M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x9f;
-			*rsv_time = 16;
-		} else {
-			*tx_rate = 0x8f;
-			*rsv_time = 22;
-		}
-		break;
-	case RATE_12M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x9a;
-			*rsv_time = 12;
-		} else {
-			*tx_rate = 0x8a;
-			*rsv_time = 18;
-		}
-		break;
-	case RATE_18M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x9e;
-			*rsv_time = 8;
-		} else {
-			*tx_rate = 0x8e;
-			*rsv_time = 14;
-		}
-		break;
-	case RATE_36M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x9d;
-			*rsv_time = 4;
-		} else {
-			*tx_rate = 0x8d;
-			*rsv_time = 10;
-		}
-		break;
-	case RATE_48M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x98;
-			*rsv_time = 4;
-		} else {
-			*tx_rate = 0x88;
-			*rsv_time = 10;
-		}
-		break;
-	case RATE_54M:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x9c;
-			*rsv_time = 4;
-		} else {
-			*tx_rate = 0x8c;
-			*rsv_time = 10;
-		}
-		break;
-	case RATE_24M:
-	default:
-		if (bb_type == BB_TYPE_11A) {
-			*tx_rate = 0x99;
-			*rsv_time = 8;
-		} else {
-			*tx_rate = 0x89;
-			*rsv_time = 14;
-		}
-		break;
-	}
-}
+static const u8 vnt_rspinf_b_short_table[] = {
+	0x70, 0x00, 0x00, 0x00, 0x38, 0x00, 0x09, 0x00,
+	0x15, 0x00, 0x0a, 0x00, 0x0b, 0x00, 0x0b, 0x80
+};
+
+static const u8 vnt_rspinf_b_long_table[] = {
+	0x70, 0x00, 0x00, 0x00, 0x38, 0x00, 0x01, 0x00,
+	0x15, 0x00, 0x02, 0x00, 0x0b, 0x00, 0x03, 0x80
+};
+
+static const u8 vnt_rspinf_a_table[] = {
+	0x9b, 0x18, 0x9f, 0x10, 0x9a, 0x0a, 0x9e, 0x08, 0x99,
+	0x08, 0x9d, 0x04, 0x98, 0x04, 0x9c, 0x04, 0x9c, 0x04
+};
+
+static const u8 vnt_rspinf_gb_table[] = {
+	0x8b, 0x1e, 0x8f, 0x16, 0x8a, 0x12, 0x8e, 0x0e, 0x89,
+	0x0e, 0x8d, 0x0a, 0x88, 0x0a, 0x8c, 0x0a, 0x8c, 0x0a
+};
 
 /*
  * Description: Set RSPINF
@@ -183,74 +109,32 @@ static void vnt_calculate_ofdm_rate(u16 rate, u8 bb_type,
 
 void vnt_set_rspinf(struct vnt_private *priv, u8 bb_type)
 {
-	struct vnt_phy_field phy[4];
-	u8 tx_rate[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0}; /* For OFDM */
-	u8 rsv_time[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
-	u8 data[34];
-	int i;
-
-	/*RSPINF_b_1*/
-	vnt_get_phy_field(priv, 14, RATE_1M, PK_TYPE_11B, &phy[0]);
-
-	/*RSPINF_b_2*/
-	vnt_get_phy_field(priv, 14, RATE_2M, PK_TYPE_11B, &phy[1]);
-
-	/*RSPINF_b_5*/
-	vnt_get_phy_field(priv, 14, RATE_5M, PK_TYPE_11B, &phy[2]);
-
-	/*RSPINF_b_11*/
-	vnt_get_phy_field(priv, 14, RATE_11M, PK_TYPE_11B, &phy[3]);
-
-	/*RSPINF_a_6*/
-	vnt_calculate_ofdm_rate(RATE_6M, bb_type, &tx_rate[0], &rsv_time[0]);
+	const u8 *data;
+	u16 len;
 
-	/*RSPINF_a_9*/
-	vnt_calculate_ofdm_rate(RATE_9M, bb_type, &tx_rate[1], &rsv_time[1]);
-
-	/*RSPINF_a_12*/
-	vnt_calculate_ofdm_rate(RATE_12M, bb_type, &tx_rate[2], &rsv_time[2]);
-
-	/*RSPINF_a_18*/
-	vnt_calculate_ofdm_rate(RATE_18M, bb_type, &tx_rate[3], &rsv_time[3]);
-
-	/*RSPINF_a_24*/
-	vnt_calculate_ofdm_rate(RATE_24M, bb_type, &tx_rate[4], &rsv_time[4]);
-
-	/*RSPINF_a_36*/
-	vnt_calculate_ofdm_rate(RATE_36M, bb_type, &tx_rate[5], &rsv_time[5]);
-
-	/*RSPINF_a_48*/
-	vnt_calculate_ofdm_rate(RATE_48M, bb_type, &tx_rate[6], &rsv_time[6]);
-
-	/*RSPINF_a_54*/
-	vnt_calculate_ofdm_rate(RATE_54M, bb_type, &tx_rate[7], &rsv_time[7]);
-
-	/*RSPINF_a_72*/
-	vnt_calculate_ofdm_rate(RATE_54M, bb_type, &tx_rate[8], &rsv_time[8]);
-
-	put_unaligned(phy[0].len, (u16 *)&data[0]);
-	data[2] = phy[0].signal;
-	data[3] = phy[0].service;
-
-	put_unaligned(phy[1].len, (u16 *)&data[4]);
-	data[6] = phy[1].signal;
-	data[7] = phy[1].service;
-
-	put_unaligned(phy[2].len, (u16 *)&data[8]);
-	data[10] = phy[2].signal;
-	data[11] = phy[2].service;
+	if (priv->preamble_type) {
+		data = vnt_rspinf_b_short_table;
+		len = ARRAY_SIZE(vnt_rspinf_b_short_table);
+	} else {
+		data = vnt_rspinf_b_long_table;
+		len = ARRAY_SIZE(vnt_rspinf_b_long_table);
+	}
 
-	put_unaligned(phy[3].len, (u16 *)&data[12]);
-	data[14] = phy[3].signal;
-	data[15] = phy[3].service;
+	 /* RSPINF_b_1 to RSPINF_b_11 */
+	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_B_1,
+			MESSAGE_REQUEST_MACREG, len, data);
 
-	for (i = 0; i < 9; i++) {
-		data[16 + i * 2] = tx_rate[i];
-		data[16 + i * 2 + 1] = rsv_time[i];
+	if (bb_type == BB_TYPE_11A) {
+		data = vnt_rspinf_a_table;
+		len = ARRAY_SIZE(vnt_rspinf_a_table);
+	} else {
+		data = vnt_rspinf_gb_table;
+		len = ARRAY_SIZE(vnt_rspinf_gb_table);
 	}
 
-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_B_1,
-			MESSAGE_REQUEST_MACREG, 34, &data[0]);
+	/* RSPINF_a_6 to RSPINF_a_72 */
+	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_A_6,
+			MESSAGE_REQUEST_MACREG, len, data);
 }
 
 /*
-- 
2.25.1
