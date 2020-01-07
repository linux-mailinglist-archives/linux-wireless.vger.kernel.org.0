Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBB132349
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 11:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGKMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 05:12:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 05:12:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007A4FOS166501;
        Tue, 7 Jan 2020 10:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=DLv+b7ZVrbu2SgqAQqNsz7OGVxrBKRABq9OIlUAWxW8=;
 b=oUxauMSIisoEmpCFK8BIkdzKrIeU2M33fZ0SstWKTR/9fNsaPVcUBwf9P3JeO+qYDGZE
 SfXiw0+2TMLUAf9wI0G/syMkQcrRyGVu6NM8tgeZBLJiLIidx83ataXCN3wPEv/1eYWe
 4Shz9d2AwJcdxCA9RG3rDAzBEUPBJK3+R9cojmE+jjTyH5g5KRVsrthK9RIlhoN1bDEm
 H2sEgGGyOgZ5hTHqJMsuoKKXuKnuU0QTyVj3xixMVx+7qsCDgtYMytBOI3c7MVqdPGgG
 0dHFLjDS1I20hIYpbOff6rFnxjSWkrbKAVKDlnG7FYBwohw2nkDm6E04hGaLCMCaI8P+ vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xaj4tvkyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 10:12:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007A8OCK094410;
        Tue, 7 Jan 2020 10:12:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xcpcpwyqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 10:12:03 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007ABxBN013714;
        Tue, 7 Jan 2020 10:12:00 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 02:11:58 -0800
Date:   Tue, 7 Jan 2020 13:11:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     john@phrozen.org
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mac80211: add 802.11 encapsulation offloading support
Message-ID: <20200107101152.t2rl7l5nd2evsiyb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=768
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=818 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070084
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello John Crispin,

The patch 50ff477a8639: "mac80211: add 802.11 encapsulation
offloading support" from Nov 25, 2019, leads to the following static
checker warning:

	net/mac80211/status.c:1227 ieee80211_tx_status_8023()
	warn: 'sta' can also be NULL

net/mac80211/status.c
  1201  void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
  1202                                struct ieee80211_vif *vif,
  1203                                struct sk_buff *skb)
  1204  {
  1205          struct ieee80211_local *local = hw_to_local(hw);
  1206          struct ieee80211_sub_if_data *sdata;
  1207          struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  1208          struct sta_info *sta;
  1209          int retry_count;
  1210          int rates_idx;
  1211          bool acked;
  1212  
  1213          sdata = vif_to_sdata(vif);
  1214  
  1215          acked = info->flags & IEEE80211_TX_STAT_ACK;
  1216          rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
  1217  
  1218          rcu_read_lock();
  1219  
  1220          if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
                                                        ^^^^

This can be NULL for NL80211_IFTYPE_MESH_POINT (possibly that doesn't
matter here, I don't know the code).

  1221                  goto counters_update;
  1222  
  1223          if (IS_ERR(sta))
  1224                  goto counters_update;
  1225  
  1226          if (!acked)
  1227                  sta->status_stats.retry_failed++;
  1228  
  1229          if (rates_idx != -1)
  1230                  sta->tx_stats.last_rate = info->status.rates[rates_idx];
                        ^^^^^^^^^^^^^^^^^^^^^^^
Smatch warning.

  1231  
  1232          sta->status_stats.retry_count += retry_count;
  1233  

regards,
dan carpenter
