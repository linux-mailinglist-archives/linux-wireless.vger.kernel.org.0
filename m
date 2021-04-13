Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC435DCDF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbhDMKxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 06:53:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbhDMKxr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAhqUY099489;
        Tue, 13 Apr 2021 10:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=NiPaCE4wftZ8SFTqhnouJhnKS8hnzCon5MDDIlsvTO0=;
 b=u6fktssQvjjVqDmderE0Mew6O713xF2hH24izu9y130K2AdOiexuGE3IRgS5WTOkAZJ6
 II15HHvjLZPKMwPvmjXSaVgzvS2VyGwSHWUcn6lDGMKmzKyPJ8xulDHlOkoZeYGLUAE9
 vpejidLmtRtXz9p9RE2BpfZO50Gz4x/ZYSM062LXwE0aIqLX7fQpJJ6MFDjLnx0bgHTU
 JpMwIQm1eACX4Y+dNLSyY/RhWJaUXe5+Vv3t9xchcZRntU+MFDufhQM8tuU1cF2nkcRq
 41kgfCgmiTt8SNLpYum667U1ggTlhPn/EtKr20bANl02uePbmgOubq3uFPlp+aE1yeeS BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erener-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:53:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DApe8q076821;
        Tue, 13 Apr 2021 10:53:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37unwymag3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:53:25 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13DArOd4012960;
        Tue, 13 Apr 2021 10:53:24 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 10:53:23 +0000
Date:   Tue, 13 Apr 2021 13:53:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] cfg80211: limit scan results cache size
Message-ID: <YHV4Hkq+D9iyEecx@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=904 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130075
X-Proofpoint-ORIG-GUID: dJFgZr2uTqHn7nkjk3e6PLwu5dA4W62V
X-Proofpoint-GUID: dJFgZr2uTqHn7nkjk3e6PLwu5dA4W62V
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 adultscore=0 mlxlogscore=859 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130074
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes Berg,

The patch 9853a55ef1bb: "cfg80211: limit scan results cache size"
from Nov 15, 2016, leads to the following static checker warning:

	net/wireless/scan.c:1754 cfg80211_bss_update()
	warn: '&new->hidden_list' not removed from list

net/wireless/scan.c
  1721                  memcpy(new, tmp, sizeof(*new));
  1722                  new->refcount = 1;
  1723                  INIT_LIST_HEAD(&new->hidden_list);
  1724                  INIT_LIST_HEAD(&new->pub.nontrans_list);
  1725  
  1726                  if (rcu_access_pointer(tmp->pub.proberesp_ies)) {
  1727                          hidden = rb_find_bss(rdev, tmp, BSS_CMP_HIDE_ZLEN);
  1728                          if (!hidden)
  1729                                  hidden = rb_find_bss(rdev, tmp,
  1730                                                       BSS_CMP_HIDE_NUL);
  1731                          if (hidden) {
  1732                                  new->pub.hidden_beacon_bss = &hidden->pub;
  1733                                  list_add(&new->hidden_list,
                                                 ^^^^^^^^^^^^^^^^^
  1734                                           &hidden->hidden_list);
                                                 ^^^^^^^^^^^^^^^^^^^^
"new" gets added to the list

  1735                                  hidden->refcount++;
                                        ^^^^^^^^^^^^^^^^^^^
  1736                                  rcu_assign_pointer(new->pub.beacon_ies,
  1737                                                     hidden->pub.beacon_ies);
  1738                          }
  1739                  } else {
  1740                          /*
  1741                           * Ok so we found a beacon, and don't have an entry. If
  1742                           * it's a beacon with hidden SSID, we might be in for an
  1743                           * expensive search for any probe responses that should
  1744                           * be grouped with this beacon for updates ...
  1745                           */
  1746                          if (!cfg80211_combine_bsses(rdev, new)) {
  1747                                  kfree(new);
  1748                                  goto drop;
  1749                          }
  1750                  }
  1751  
  1752                  if (rdev->bss_entries >= bss_entries_limit &&
  1753                      !cfg80211_bss_expire_oldest(rdev)) {
  1754                          kfree(new);
                                ^^^^^^^^^^
It seems like it's still on the list when we free "new" leading to a
use after free.

  1755                          goto drop;
  1756                  }

regards,
dan carpenter
