Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F848AC6B2
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2019 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405957AbfIGNEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Sep 2019 09:04:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbfIGNEo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Sep 2019 09:04:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87D4fcH073862;
        Sat, 7 Sep 2019 13:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=uRthtHpoVWuAHwxZjkWAa2K2TroMtq+YoapP0IHbxYA=;
 b=JzG0ZR/v++Ro7yOcai+afbSufjGghDcimE/nMJhQo42E2CrknIeHwK5rb/LEnrQUc5/V
 cZ24vmI9YuQxVQQEn0uH1R5fbk67rWtFqgZ2Ut4UoofysB3JKSAKltmzzrK6fEGwDCH5
 zh/pgkhfCypR6541tgL2DjJfn9mMUkKb3Yydnow6NgeZJ1r9XRnv3/FRBVf8YT4TZUec
 tKRvZzsDXaR3HMbFhdUYvjVoZ8cgox9K2wTrRVK9FCV+/hNn239mMRf5lT2q4Jl1orpM
 roGOAGbbfpg+UiESGypTTSMBjhC897ySfxrIYug3srw7EUKBq02941oAj4lVSEG3qEHV xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2uvd2680b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 13:04:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87Cw3km004522;
        Sat, 7 Sep 2019 13:02:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2uv3wj99y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 13:02:40 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x87D2eBg031247;
        Sat, 7 Sep 2019 13:02:40 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Sep 2019 06:02:39 -0700
Date:   Sat, 7 Sep 2019 16:02:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     masashi.honma@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds
Message-ID: <20190907130234.GA32057@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909070140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=857 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909070141
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Masashi Honma,

The patch 1222a1601488: "nl80211: Fix possible Spectre-v1 for CQM
RSSI thresholds" from Sep 25, 2018, leads to the following static
checker warning:

	net/wireless/nl80211.c:10820 cfg80211_cqm_rssi_update()
	warn: disabling speculation after use: 'i'

net/wireless/nl80211.c
 10804          last = wdev->cqm_config->last_rssi_event_value;
 10805          hyst = wdev->cqm_config->rssi_hyst;
 10806          n = wdev->cqm_config->n_rssi_thresholds;
 10807  
 10808          for (i = 0; i < n; i++)
 10809                  if (last < wdev->cqm_config->rssi_thresholds[i])
                                                     ^^^^^^^^^^^^^^^^^^
We've already used "i" as an index.

 10810                          break;
 10811  
 10812          low_index = i - 1;
 10813          if (low_index >= 0) {
 10814                  low_index = array_index_nospec(low_index, n);
                                    ^^^^^^^^^^^^^^^^^^

 10815                  low = wdev->cqm_config->rssi_thresholds[low_index] - hyst;
 10816          } else {
 10817                  low = S32_MIN;
 10818          }
 10819          if (i < n) {
 10820                  i = array_index_nospec(i, n);
                            ^^^^^^^^^^^^^^^^^^
So this seems like closing the barn door after the horses have left.

 10821                  high = wdev->cqm_config->rssi_thresholds[i] + hyst - 1;
 10822          } else {
 10823                  high = S32_MAX;
 10824          }

regards,
dan carpenter
