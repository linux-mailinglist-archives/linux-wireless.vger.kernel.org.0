Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B18243B55
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHMOPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 10:15:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMOP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 10:15:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DEDiDW057560;
        Thu, 13 Aug 2020 14:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=KI1ql7KlybptHZpBvB0+SNJ7mHBXWyhKeS0xGV+durI=;
 b=iQg/5tAlboQ5dXfRgMz//2QHM15wR3IeqUNImmZc3zUVYQMWXcFg3JarIkX5rPXtxg6c
 m+3pVtKaAIT0i8i7ZlO1X40hPZWt8WyYkr+ClpYN/z95Q7NlN2wIJ3lg81EbgtmkWDkA
 6hIK6Uu+Yqko90QKH0+5nkH37HvT5hZl1dD/G8aDS9UBZbtPBA4ohhqhFvFZnTkdLRdu
 PETxqwPErYVj/EiQ/2rFbK3UUK/xWmfBsy2Tg4hPMt3HOMVdXI9r0EAgWcDDS85bieEX
 7DYFPw54VjaAniO1KDzRa1sLOYHmN4yyMViKQT6B8nzAJpltf/nOLJK4uEREyJWVtygv Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32sm0n0wfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 14:15:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DE7c76175642;
        Thu, 13 Aug 2020 14:13:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32t5mru8tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 14:13:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07DEDMT7028637;
        Thu, 13 Aug 2020 14:13:22 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 14:13:21 +0000
Date:   Thu, 13 Aug 2020 17:13:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Jouni Malinen <jouni@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath6kl: prevent potential array overflow in
 ath6kl_add_new_sta()
Message-ID: <20200813141315.GB457408@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130107
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The value for "aid" comes from skb->data so Smatch marks it as
untrusted.  If it's invalid then it can result in an out of bounds array
access in ath6kl_add_new_sta().

Fixes: 572e27c00c9d ("ath6kl: Fix AP mode connect event parsing and TIM updates")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath6kl/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index 5e7ea838a921..814131a0680a 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -430,6 +430,9 @@ void ath6kl_connect_ap_mode_sta(struct ath6kl_vif *vif, u16 aid, u8 *mac_addr,
 
 	ath6kl_dbg(ATH6KL_DBG_TRC, "new station %pM aid=%d\n", mac_addr, aid);
 
+	if (aid < 1 || aid > AP_MAX_NUM_STA)
+		return;
+
 	if (assoc_req_len > sizeof(struct ieee80211_hdr_3addr)) {
 		struct ieee80211_mgmt *mgmt =
 			(struct ieee80211_mgmt *) assoc_info;
-- 
2.28.0

