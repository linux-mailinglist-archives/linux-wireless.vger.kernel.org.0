Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9852911E260
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 11:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMKwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 05:52:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 05:52:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAfull188831;
        Fri, 13 Dec 2019 10:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=dXEdpypodhBlP/vqrAtRivCCvWtwlODh88xSBnwgeEg=;
 b=mpIF3MqGfD6ULN6nqPZQRfJW5r9YTj7T2BWVPFWOdjYX2XFg7lcLCKopy4ZK67uWoiBH
 /S61tL9bL6vUpmpVcno7mKHQ5qkDsCGRNjjBEvjOpp7MGtsjq8HIyyaWiuz1v6YEhKMT
 xgx2maH1OXSV9K7beG01+QAr9v0hEDXxulPEZrUyu4ngFhSZ/ITS0NiXdcrecpieY7+d
 IYje35e7XOrW5EcE9lSpL/S/w/W/WWMcgc0LRPjr0DTwp+SJfFZzeCJq6quWaZQJ4i3y
 VcGyDFOGpyzSvPcvEtdGHw6XHWhITUoOPiNEAJE0IvdEZS8W27iZk0dZH7qWUmqHVObs 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wr41qreuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:52:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAjlW8131395;
        Fri, 13 Dec 2019 10:52:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wumu69gvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:52:26 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDAqPwd021396;
        Fri, 13 Dec 2019 10:52:25 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 02:52:25 -0800
Date:   Fri, 13 Dec 2019 13:52:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: remove an unneeded NULL check
Message-ID: <20191213105219.qbpng7eut5zgty2p@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130086
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The list iterator is always non-NULL so it doesn't need to be checked.
I also removed the unnecessary initializer because the list iterator is
always initialized.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1b3b65c0038c..3a3dc7680622 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1225,12 +1225,12 @@ static
 struct htt_ppdu_stats_info *ath11k_dp_htt_get_ppdu_desc(struct ath11k *ar,
 							u32 ppdu_id)
 {
-	struct htt_ppdu_stats_info *ppdu_info = NULL;
+	struct htt_ppdu_stats_info *ppdu_info;
 
 	spin_lock_bh(&ar->data_lock);
 	if (!list_empty(&ar->ppdu_stats_info)) {
 		list_for_each_entry(ppdu_info, &ar->ppdu_stats_info, list) {
-			if (ppdu_info && ppdu_info->ppdu_id == ppdu_id) {
+			if (ppdu_info->ppdu_id == ppdu_id) {
 				spin_unlock_bh(&ar->data_lock);
 				return ppdu_info;
 			}
-- 
2.11.0

