Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0E275373
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Sep 2020 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWImR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Sep 2020 04:42:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45330 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWImR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Sep 2020 04:42:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N8ZTQF009571;
        Wed, 23 Sep 2020 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=p8KyuNUIaNrpx3GzkbnEYBlo5H6m56elmHHtXbxAnCw=;
 b=HGS3lI1CpSgWUY+EdBc1pfVCWaoGTx3Wc3Xyua/2lHnZxOBHXAZyGquhcmTY0APl3cxR
 SU4c6u2MAvg5c3VqLJyxI6z4yOhf6twiExxa3WwYpkyrGo3uKJwhllkciN8zKmgvQZX3
 jVP1kw/2E1Fb03H/+sAQxFZX35fgzktLre03IXFYnByyT8wTZmJfN0P8I/mv6ACb9Zmt
 v3rXtuIVxSyLh9GO8+deE2E9BXpXmruOpN6tj0Feh1ZGjIWd7RmEAlVpalsz9Rnyr/1W
 mwxFepFFJTDjk9pYcc6AoiaO0WQIk8S5NeZ8Ulg42Obmsw8H+zc4Zy5Cv+fKVhq5QrTV 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33qcptx1xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 08:42:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N8a6M1032721;
        Wed, 23 Sep 2020 08:42:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33r28uugy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 08:42:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08N8g97M006992;
        Wed, 23 Sep 2020 08:42:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 01:42:08 -0700
Date:   Wed, 23 Sep 2020 11:42:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] cfg80211: regulatory: remove a bogus initialization
Message-ID: <20200923084203.GC1454948@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230070
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The the __freq_reg_info() never returns NULL and the callers don't check
for NULL.  This initialization to set "reg_rule = NULL;" is just there
to make GCC happy but it's not required in current GCCs.

The problem is that Smatch sees the initialization and concludes that
this function can return NULL so it complains that the callers are not
checking for it.

Smatch used to be able to parse this correctly but we recently changed
the code from:

-       for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
+       for (bw = MHZ_TO_KHZ(bws[i]); bw >= min_bw; bw = MHZ_TO_KHZ(bws[i--])) {

Originally Smatch used to understand that this code always iterates
through the loop once, but the change from "MHZ_TO_KHZ(20)" to
"MHZ_TO_KHZ(bws[i])" is too complicated for Smatch.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Feel free to throw this patch into the bit bucket if you want...  I
don't feel strongly about it either way.  Just a piece of functional
art.


 net/wireless/reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6043a9d33d61..3dab859641e1 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1616,8 +1616,8 @@ static const struct ieee80211_reg_rule *
 __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 {
 	const struct ieee80211_regdomain *regd = reg_get_regdomain(wiphy);
-	const struct ieee80211_reg_rule *reg_rule = NULL;
 	const u32 bws[] = {0, 1, 2, 4, 5, 8, 10, 16, 20};
+	const struct ieee80211_reg_rule *reg_rule;
 	int i = ARRAY_SIZE(bws) - 1;
 	u32 bw;
 
-- 
2.28.0

