Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06AE34201C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 15:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhCSOsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 10:48:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51150 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCSOrs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 10:47:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEYTH8095508;
        Fri, 19 Mar 2021 14:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=JChT7AsGvWINfn++T16VORoBC+JSYP8GYElETVZxNiw=;
 b=uTwJRfvQ0o3697PJXr97tGM7g1nF0zu1Wjlhl248QGN7HP6htAcveldt0ZJ2Ienz0orG
 96mmCzodtKUD7r8fKswFGHXpawPqyPHlj9hCy4ZZdHSzl+i77uOlMLZ+DPpE4ByJL9+r
 Ts9ojPoEOMLghrMSncUHoZlh9X4cAuXaFFFi7cY3ly3VacHBVtiS0og3rbaqT7gAhCgl
 OFJpA9A3oG4CaxbizrRDKAQ2WnAX7SaosC1Bn6mrl4c3887HuuYP23AGu77nBgMgHbRY
 EEgGEM6Cd8393nIM2hdWsBqIWplAAA2yIl9tsTnKR7PKgGbDRkez/ItEQzZPeGssfSl1 LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4em061a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 14:47:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEaEZK067300;
        Fri, 19 Mar 2021 14:47:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3797b4bk11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 14:47:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12JEldpZ022310;
        Fri, 19 Mar 2021 14:47:40 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Mar 2021 07:47:38 -0700
Date:   Fri, 19 Mar 2021 17:47:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Mosberger-Tang <davidm@egauge.net>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wilc1000: fix a loop timeout condition
Message-ID: <YFS5gx/gi70zlIaO@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190106
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the loop fails, the "while(trials--) {" loop will exit with "trials"
set to -1.  The test for that expects it to end with "trials" set to 0
so the warning message will not be printed.

Fix this by changing from a post-op to a pre-op.  This does mean that
we only make 99 attempts instead of 100 but that's okay.

Fixes: f135a1571a05 ("wilc1000: Support chip sleep over SPI")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index d4a90c490084..2030fc7f53ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -575,7 +575,7 @@ void chip_allow_sleep(struct wilc *wilc)
 		to_host_from_fw_bit = WILC_SPI_FW_TO_HOST_BIT;
 	}
 
-	while (trials--) {
+	while (--trials) {
 		ret = hif_func->hif_read_reg(wilc, to_host_from_fw_reg, &reg);
 		if (ret)
 			return;
-- 
2.30.2

