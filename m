Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80C109D9B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 13:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKZMMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 07:12:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfKZMMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 07:12:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8pDw116272;
        Tue, 26 Nov 2019 12:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=/mBMxIIlBQ+XFxgJu+74RNcnTy1AckJgoUjuyVpyT6M=;
 b=UVaFVpmuP55to/4hV4BOtz3AZvc5zUuB3/8JIbNJ3e06RElBJFpqC+Tx1TL3KyhLoQ/k
 u3zhfsAW/k12OWQV+IEYJ5JpEacsTWx5zZTSllioxe0ChSgcQMI9QcbRcMIC8DIvsQbi
 upraQTttR8lYgFES0JQfCJ9468zZzLIJwYtrWzrk90D9PNKBuupuh11p5E/NtF8Jhks8
 DC58PlwnmpFUGrYu+Fe6ujIIzOHsGlQhWHDDOr9pQVDZdGs9lgMSCaxccJnAMbLDcNPk
 UZTOBbusz+/m5gcHzW7aYZS/RCLeKsz8lPg4yjiR0XGZ9He+Mvbe+ZpVSGWszAse1HON sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wev6u6d8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:11:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8Rtb089382;
        Tue, 26 Nov 2019 12:09:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wgvfjddd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:09:52 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQC9pAO018135;
        Tue, 26 Nov 2019 12:09:51 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 04:09:49 -0800
Date:   Tue, 26 Nov 2019 15:09:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Toke H??iland-J??rgensen <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mac80211: airtime: Fix an off by one in
 ieee80211_calc_rx_airtime()
Message-ID: <20191126120910.ftr4t7me3by32aiz@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9r7ysg0.fsf@toke.dk>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260110
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code was copied from mt76 and inherited an off by one bug from
there.  The > should be >= so that we don't read one element beyond
the end of the array.

Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from mt76")
Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/mac80211/airtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 63cb0028b02d..9fc2968856c0 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -442,7 +442,7 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			return 0;
 
 		sband = hw->wiphy->bands[status->band];
-		if (!sband || status->rate_idx > sband->n_bitrates)
+		if (!sband || status->rate_idx >= sband->n_bitrates)
 			return 0;
 
 		rate = &sband->bitrates[status->rate_idx];
-- 
2.11.0

