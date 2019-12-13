Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74C411EABB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfLMSvJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 13:51:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54602 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfLMSvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 13:51:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIiSiO187214;
        Fri, 13 Dec 2019 18:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=OHdV8pT7zAW4ljzAh7kGrjCK8SyrDdk1D8mSHJct65s=;
 b=by25lE7Pa3vr6Wr3ZMDaPNxZkoKmR1Uh67/9Uf0F+sxbN1bNqn2E4CPKEp0J/LoA+aVa
 FhjFN50tBY0WK/R8yqv0GBpJIfwDSPyPwg3b7+d4glAJsPLnOKBy4z/EMcOOMbfoyPRs
 +C7W1SRIQhWXv2u0Jtn1iJSxB9NV0Y0kfFBwLeuGBESBIqqLAyCi0HbYhBXWgW1rtwXA
 sdNUj9EJWOE1JmHv4nzljOtu9TlOExPQxnKOyfiyHcEKw7TBQsp3n5a4vs2QD7dsFOJI
 /bYc86Y5eAX6SzdzMpWYzuuFPXkv3GfXjsN7W9IWtYt/13+kp4jsmOaE3dyZCo68Q06H ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qts65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:51:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDImZEr013240;
        Fri, 13 Dec 2019 18:50:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wvdwq9f79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:50:59 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDIowPB029384;
        Fri, 13 Dec 2019 18:50:58 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 10:50:57 -0800
Date:   Fri, 13 Dec 2019 21:50:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ulf.hansson@linaro.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] mmc: core: Re-work HW reset for SDIO cards
Message-ID: <20191213185050.m6iku7defq44syrl@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=689
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=751 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130145
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ulf Hansson,

The patch 2ac55d5e5ec9: "mmc: core: Re-work HW reset for SDIO cards"
from Oct 17, 2019, leads to the following static checker warning:

	drivers/net/wireless/ath/ath10k/sdio.c:1521 ath10k_sdio_hif_power_down()
	warn: 'ret' can be either negative or positive

drivers/net/wireless/ath/ath10k/sdio.c
  1495  static void ath10k_sdio_hif_power_down(struct ath10k *ar)
  1496  {
  1497          struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
  1498          int ret;
  1499  
  1500          if (ar_sdio->is_disabled)
  1501                  return;
  1502  
  1503          ath10k_dbg(ar, ATH10K_DBG_BOOT, "sdio power off\n");
  1504  
  1505          /* Disable the card */
  1506          sdio_claim_host(ar_sdio->func);
  1507  
  1508          ret = sdio_disable_func(ar_sdio->func);
  1509          if (ret) {
  1510                  ath10k_warn(ar, "unable to disable sdio function: %d\n", ret);
  1511                  sdio_release_host(ar_sdio->func);
  1512                  return;
  1513          }
  1514  
  1515          ret = mmc_hw_reset(ar_sdio->func->card->host);
  1516          if (ret)

It used to be that mmc_hw_reset() return negative error codes or zero
but now it returns 1 on certain success paths.

  1517                  ath10k_warn(ar, "unable to reset sdio: %d\n", ret);
  1518  
  1519          sdio_release_host(ar_sdio->func);
  1520  
  1521          ar_sdio->is_disabled = true;
  1522  }


regards,
dan carpenter
