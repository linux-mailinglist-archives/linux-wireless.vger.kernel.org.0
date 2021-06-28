Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1003B5C2A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 12:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhF1KNT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 06:13:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12184 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232488AbhF1KNT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 06:13:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SA0rxE011832;
        Mon, 28 Jun 2021 10:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=8K2/mn/ipDVay3vovLydRb1iXkFbzJvo9qqGheQXPck=;
 b=oSxdBogBJcfo072yWIZvdB2t/fsdwcvd9jml9NftaKV571FhUUAgWVEnUw0ZWRmbS+ji
 SvIYlr8J0Ur/7weqNE12uGsNE6ITrdjIOzsZeM41po6cQ9jrzmn2YfxvMDqsC0iD7OUD
 5beNrjMIZzfJ3T+xICMy/vTtBcn6wIHu2CAuvpE0jIx/m3gEwrPbmQRnKg3JmjDkTnVG
 dZ2eRfi7z+VEu9k5GKoKwiEd57ga9Is1WXUzEAXoHDsBp0zqhNDKeasjEvYS4eYizvEz
 Mq8ed9R/WY7jljLJD7OLLTfi+T9QsXcqaSJa8P+QuJ9NZ0zdAFgtii5n81wm5cMW9Uxb 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3gnug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:10:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SA9xmQ062775;
        Mon, 28 Jun 2021 10:10:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 39dt9ch4h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:10:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15SAAmOA066596;
        Mon, 28 Jun 2021 10:10:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 39dt9ch4gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:10:48 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15SAAlwd024525;
        Mon, 28 Jun 2021 10:10:47 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jun 2021 03:10:47 -0700
Date:   Mon, 28 Jun 2021 13:10:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mac80211: remove unnecessary NULL check in
 ieee80211_register_hw()
Message-ID: <YNmgHi7Rh3SISdog@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: ED0HYzW2xa4bYuvy-KB-79H1XS3hthJg
X-Proofpoint-ORIG-GUID: ED0HYzW2xa4bYuvy-KB-79H1XS3hthJg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The address "&sband->iftype_data[i]" points to an array at the end of
struct.  It can't be NULL and so the check can be removed.

Fixes: bac2fd3d7534 ("mac80211: remove use of ieee80211_get_he_sta_cap()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This patch doesn't really *fix* anything of course.  I just added the
Fixes tag to help reviewers.

 net/mac80211/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 05f4c3c72619..ac0653b58f5f 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1018,7 +1018,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 			iftd = &sband->iftype_data[i];
 
-			supp_he = supp_he || (iftd && iftd->he_cap.has_he);
+			supp_he = supp_he || iftd->he_cap.has_he;
 		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
-- 
2.30.2

