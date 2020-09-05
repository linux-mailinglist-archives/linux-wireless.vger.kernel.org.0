Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1D25E796
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgIEMuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 08:50:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45710 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIEMuV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 08:50:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085CnJL3046039;
        Sat, 5 Sep 2020 12:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5IK9hoWjNqBk1UoUzZ4OO2Lky+eXMaVBbLFcJ10EuVo=;
 b=BI/JzoUUDKUfeTMI9nUllS/HeERa8sCWhRYMUUkAZhHAfb0XmpZ+9ymUydLj4s2+Yach
 5Tp7zzlq/CvJDBCZ8WH386a/Csh7tLogSKF4Oe+JmD1gx6ohnl6n/097uz4SHMJTcocK
 TqAcXk8HI+KhtwtkNEvyvsCGR/atXY4C67YlKbxtXm/UZ/MotUQUJA8GRIWQF0ztmFJf
 eQDpjqS7bbbrYN3oB7n03wki/lQmWpXL2D40RhcEF0XHpiY7RoUgl2wbuZm1Jh1fR0ey
 1vELVfUvUJDvLpLteGecBhI9eku+Sx9L3zu/KlCmbJczdvdc4ld2qrovjoGwYOh6Xxq+ Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33c23qh77g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 05 Sep 2020 12:50:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085CjxcU003387;
        Sat, 5 Sep 2020 12:48:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33bysqqhe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Sep 2020 12:48:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 085Cm4W5016364;
        Sat, 5 Sep 2020 12:48:04 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Sep 2020 05:48:04 -0700
Date:   Sat, 5 Sep 2020 15:47:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8723ae: Delete a stray tab
Message-ID: <20200905124758.GB183976@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009050122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050123
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This line is indented too far.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
index 16c6007861ff..53af0d209b11 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
@@ -435,7 +435,7 @@ static void rtl8723e_dm_bt_set_fw_tdma_ctrl(struct ieee80211_hw *hw,
 		if (TDMA_1ANT == ant_num) {
 			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex], TDMA_1ANT\n");
-				h2c_parameter[0] |= BIT(1);
+			h2c_parameter[0] |= BIT(1);
 		} else if (TDMA_2ANT == ant_num) {
 			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex], TDMA_2ANT\n");
-- 
2.28.0

