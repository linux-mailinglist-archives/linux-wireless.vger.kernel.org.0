Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB53B11E248
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 11:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMKsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 05:48:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47412 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 05:48:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAfs7f188788;
        Fri, 13 Dec 2019 10:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=6fombity6vRabx38L1gCH2OYcT2XTyLSX3hFgxt0cMg=;
 b=CYsnnwyT0QH1kBMGP3Wvay1cfG2rog3Zvs4QafEko/YiTYToFdSXQosSIdqPbQdacsck
 A/xL5rEjb/ZgCkL+TPKYr8hFJuOCQlLKOjipaiYCwT8XISqiPIYLp4FEUKC5/Haj1+6s
 Rx0tj0VsdcZXvzJJ/eN2eYCbpgbdD/jpWC9CKif55CHptQvH/X3fB+cmjPPzT26qwRPx
 1PqHV+q2WeAvD82XT+bhTrXvUP6GfpVLkEySy4onNjdYsihJEpchWx6iy1Dc7j6eiCCt
 Le/NZteVW8yOtzUYJHiLnLL1cRFE/jDtS3SdOHHnJKeQVO+JD0l2l/VxEQ8eXGyuC+lf LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wr41qrebd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:48:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAklKe061121;
        Fri, 13 Dec 2019 10:48:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wumsbmf1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:48:09 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDAm372000410;
        Fri, 13 Dec 2019 10:48:05 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 02:48:03 -0800
Date:   Fri, 13 Dec 2019 13:47:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Anilkumar Kolli <akolli@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: delete a stray unlock in ath11k_dbg_htt_stats_req()
Message-ID: <20191213104754.2lwrq2qqokycjjbm@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=888
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=947 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130086
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The callers unlock this lock so this error path has a double unlock.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/debug_htt_stats.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
index 27b301bc1a1b..4b1b1ecd5eae 100644
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
@@ -4287,7 +4287,6 @@ int ath11k_dbg_htt_stats_req(struct ath11k *ar)
 	ret = ath11k_dp_tx_htt_h2t_ext_stats_req(ar, type, &cfg_params, cookie);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
-		mutex_unlock(&ar->conf_mutex);
 		return ret;
 	}
 
-- 
2.11.0

