Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE753771F5
	for <lists+linux-wireless@lfdr.de>; Sat,  8 May 2021 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhEHNFF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 May 2021 09:05:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47148 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhEHNFF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 May 2021 09:05:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 148D407U073051;
        Sat, 8 May 2021 13:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=B68G7C5Mo/ulKLEzdcTuGlR7RXV1F5cDdj4WlbKIQcE=;
 b=xJJSLS1MabHv78U6U/2w/TcE1Bwr7lp8iCUdPYJpbwhdc3a0442NCxe26TuWoK1lh3gZ
 awWl4iQWYyGnaQhR6M22vTg9e5TDE0A0V4D2SUbNblKlatP1G3NnZE58ZSU3YqhV1s6N
 uM2g/KZrbVQWw7uJxjc/NXOhDxlkr/Hdv8SMoPidREHru1nLuiUEkqG8AvBkGp+xIfs9
 WmD5GMhYQKMcrt7i8DcEUIfTmWuuLldJyI0ghgFMsGuwQBQyz9wflcR/e5/wp3TLwRcj
 kvpQY5bZ85m/c+HxX+e+qzpjYxFeolQu8KSWLefPbZ5dRGsO1/hC6HhrUhFQjpGK8aV7 wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38dg5b8h6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 13:03:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 148CxneB159013;
        Sat, 8 May 2021 13:03:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38dhyjv70t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 13:03:59 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 148D3wbP168130;
        Sat, 8 May 2021 13:03:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 38dhyjv70k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 13:03:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 148D3vhX010067;
        Sat, 8 May 2021 13:03:58 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 May 2021 06:03:57 -0700
Date:   Sat, 8 May 2021 16:03:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cfg80211: clean up variable use in
 cfg80211_parse_colocated_ap()
Message-ID: <YJaMNzZENkYFAYQX@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: 7zdN6WIKlVmDUPwwr7WNhLlsOExDKpLn
X-Proofpoint-ORIG-GUID: 7zdN6WIKlVmDUPwwr7WNhLlsOExDKpLn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9978 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105080096
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "ap_info->tbtt_info_len" and "length" variables are the same value
but it is confusing how the names are mixed up.  Let's use "length"
everywhere for consistency.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/wireless/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4f06c1825029..a3941b19b516 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -618,7 +618,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 
 		freq = ieee80211_channel_to_frequency(ap_info->channel, band);
 
-		if (end - pos < count * ap_info->tbtt_info_len)
+		if (end - pos < count * length)
 			break;
 
 		/*
@@ -630,7 +630,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 		if (band != NL80211_BAND_6GHZ ||
 		    (length != IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM &&
 		     length < IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM)) {
-			pos += count * ap_info->tbtt_info_len;
+			pos += count * length;
 			continue;
 		}
 
@@ -653,7 +653,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 				kfree(entry);
 			}
 
-			pos += ap_info->tbtt_info_len;
+			pos += length;
 		}
 	}
 
-- 
2.30.3
