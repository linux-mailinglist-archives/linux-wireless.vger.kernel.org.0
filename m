Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935CC178B9C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgCDHna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 02:43:30 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5244 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgCDHna (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 02:43:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0247euEU022873;
        Wed, 4 Mar 2020 02:43:26 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52a6t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 02:43:26 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0247hP7r026691
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 02:43:25 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 4 Mar 2020
 02:43:24 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 02:43:24 -0500
Received: from analog.ad.analog.com ([10.48.65.180])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0247hLKZ014964;
        Wed, 4 Mar 2020 02:43:22 -0500
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-wireless@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <ajay.kathat@microchip.com>, <adham.abozaeid@microchip.com>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH v2] staging: wilc1000: spi: Use new structure for SPI transfer delays
Date:   Wed, 4 Mar 2020 09:43:19 +0200
Message-ID: <20200304074319.22107-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227145054.24567-1-sergiu.cuciurean@analog.com>
References: <20200227145054.24567-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040059
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In a recent change to the SPI subsystem in commit <bebcfd272df6>
("spi: introduce `delay` field for `spi_transfer` +
spi_transfer_delay_exec()"), a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current
`delay_usecs` with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---

Changelog v1->v2:
*Removed footnote from the commit description

 drivers/staging/wilc1000/spi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.c
index 11653ac118cd..a3779d967a24 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -228,7 +228,10 @@ static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 len)
 		struct spi_transfer tr = {
 			.tx_buf = b,
 			.len = len,
-			.delay_usecs = 0,
+			.delay = {
+				.value = 0,
+				.unit = SPI_DELAY_UNIT_USECS
+			},
 		};
 		char *r_buffer = kzalloc(len, GFP_KERNEL);
 
@@ -269,7 +272,10 @@ static int wilc_spi_rx(struct wilc *wilc, u8 *rb, u32 rlen)
 		struct spi_transfer tr = {
 			.rx_buf = rb,
 			.len = rlen,
-			.delay_usecs = 0,
+			.delay = {
+				.value = 0,
+				.unit = SPI_DELAY_UNIT_USECS
+			},
 
 		};
 		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
@@ -311,7 +317,10 @@ static int wilc_spi_tx_rx(struct wilc *wilc, u8 *wb, u8 *rb, u32 rlen)
 			.tx_buf = wb,
 			.len = rlen,
 			.bits_per_word = 8,
-			.delay_usecs = 0,
+			.delay = {
+				.value = 0,
+				.unit = SPI_DELAY_UNIT_USECS
+			},
 
 		};
 
-- 
2.17.1

