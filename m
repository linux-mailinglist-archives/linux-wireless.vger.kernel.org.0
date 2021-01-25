Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B3430232E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 10:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAYJQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 04:16:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56940 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAYJQQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 04:16:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10P90ciQ003663;
        Mon, 25 Jan 2021 09:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=s4UQoUYdGXbOqePnHvQDScCm3fndqxB1l13jBqgkpu4=;
 b=zl8Kf6HspIPqDJK/bZvwJrYvH7M1RFiWKE5kDTRYyyoBdg52pzwuG2vlxiZVl5pZW+UA
 2XpGcdo7Fe58LZMG7On9tEYsv9M3bGPWYml6PhxABgWBTCnuAcIrs9bQwwTKp0/zhflE
 00oIpku14zrD6imp3mdJRes3Mf2LVTgg83tvZY4pDGmZYohK6BaCj0vj9JcX8YMo3FJa
 RPIgX5oiYBlIOpEK3CM7jnVF2BpHcjbCS1Yw531Kw/Y3wOnkbBs81sTXcPo7KGE0oNS2
 tPWQDwfZUxDpSqmno+BRsyLgmI6ddMzQfFjs5ahKVcHPWKyKSVFcERGDRX2Onf1QWg4Q Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkc6g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 09:08:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10P910E2156233;
        Mon, 25 Jan 2021 09:08:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 368wckadmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 09:08:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10P980jX002301;
        Mon, 25 Jan 2021 09:08:00 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jan 2021 01:07:59 -0800
Date:   Mon, 25 Jan 2021 12:07:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] cfg80211: avoid holding the RTNL when calling the driver
Message-ID: <YA6KarkWBBT78rgd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9874 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=982 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250054
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9874 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=923
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250054
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes Berg,

This is a semi-automatic email about new static checker warnings.

The patch 791daf8fc49a: "cfg80211: avoid holding the RTNL when 
calling the driver" from Jan 19, 2021, leads to the following Smatch 
complaint:

    net/wireless/nl80211.c:3242 nl80211_set_wiphy()
    error: we previously assumed 'rdev' could be null (see line 3222)

net/wireless/nl80211.c
  3221	
  3222		if (rdev)
                    ^^^^
The patch adds a NULL dereference

  3223			mutex_lock(&rdev->wiphy.mtx);
  3224		rtnl_unlock();
  3225	
  3226		/*
  3227		 * end workaround code, by now the rdev is available
  3228		 * and locked, and wdev may or may not be NULL.
  3229		 */
  3230	
  3231		if (info->attrs[NL80211_ATTR_WIPHY_NAME])
  3232			result = cfg80211_dev_rename(
  3233				rdev, nla_data(info->attrs[NL80211_ATTR_WIPHY_NAME]));
  3234	
  3235		if (result)
  3236			goto out;
  3237	
  3238		if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
  3239			struct ieee80211_txq_params txq_params;
  3240			struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
  3241	
  3242			if (!rdev->ops->set_txq_params) {
                             ^^^^^^
But it's not checked here.

  3243				result = -EOPNOTSUPP;
  3244				goto out;

regards,
dan carpenter
