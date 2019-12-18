Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34306123F21
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 06:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLRF3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 00:29:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfLRF3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 00:29:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI5F1cc014132;
        Wed, 18 Dec 2019 05:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zJTs4wkULJS+a90GrfbPGPpqSA2lLPv3IbJQu22kaxc=;
 b=T/iqncc02AxcwFXTyn20lWBtPJO/UXWHlqz6WZqXzpjsH6sEKZA054U0fpH6Qthy3DOD
 USLvF8alc3h1ZpoHd5dNrpPQPMM466nJDgcDV7LwgZ3/dqnJfrmaLtSSOgt6g8yLAE4I
 V9DKLlnBomA6+iZEo3svlKJJWDVqKjtB4i1JQmR0EiisJkh8B/K52e8j1xjoYy6REnF1
 LFxEmuIm+mgMdz+2Hgtc+qVNMd1I94GriZDV2lqeUVtFlHuMmirgCGxfQQybL3MPhklj
 VKFDbvJ8XelKyMBqJkkxQIljDh9Fp2JV3EU1j3KzUi/z3O4BquWG6VdXjb+luIv+uB30 nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wvq5uke0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 05:29:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI5K44h144475;
        Wed, 18 Dec 2019 05:27:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wxm4wv80s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 05:27:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBI5RSRh023838;
        Wed, 18 Dec 2019 05:27:28 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 21:27:27 -0800
Date:   Wed, 18 Dec 2019 08:27:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] mmc: core: Re-work HW reset for SDIO cards
Message-ID: <20191218052721.GC2524@kadam>
References: <20191213185050.m6iku7defq44syrl@kili.mountain>
 <CAPDyKFoKvhGDuQ+C0Sp2N3==CXiMWfpcrT28+dQ2+Nq_UPaXYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoKvhGDuQ+C0Sp2N3==CXiMWfpcrT28+dQ2+Nq_UPaXYQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180041
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 17, 2019 at 08:54:47AM +0100, Ulf Hansson wrote:
> + Kalle
> 
> On Fri, 13 Dec 2019 at 19:51, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Ulf Hansson,
> >
> > The patch 2ac55d5e5ec9: "mmc: core: Re-work HW reset for SDIO cards"
> > from Oct 17, 2019, leads to the following static checker warning:
> >
> >         drivers/net/wireless/ath/ath10k/sdio.c:1521 ath10k_sdio_hif_power_down()
> >         warn: 'ret' can be either negative or positive
> 
> Thanks for reporting!
> 
> >
> > drivers/net/wireless/ath/ath10k/sdio.c
> >   1495  static void ath10k_sdio_hif_power_down(struct ath10k *ar)
> >   1496  {
> >   1497          struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> >   1498          int ret;
> >   1499
> >   1500          if (ar_sdio->is_disabled)
> >   1501                  return;
> >   1502
> >   1503          ath10k_dbg(ar, ATH10K_DBG_BOOT, "sdio power off\n");
> >   1504
> >   1505          /* Disable the card */
> >   1506          sdio_claim_host(ar_sdio->func);
> >   1507
> >   1508          ret = sdio_disable_func(ar_sdio->func);
> >   1509          if (ret) {
> >   1510                  ath10k_warn(ar, "unable to disable sdio function: %d\n", ret);
> >   1511                  sdio_release_host(ar_sdio->func);
> >   1512                  return;
> >   1513          }
> >   1514
> >   1515          ret = mmc_hw_reset(ar_sdio->func->card->host);
> >   1516          if (ret)
> >
> > It used to be that mmc_hw_reset() return negative error codes or zero
> > but now it returns 1 on certain success paths.
> 
> Correct.
> 
> I was actually looking into this while changing the behaviour of
> mmc_hw_reset(). However I decided to leave this as is.
> 
> The main reason is, that mmc_hw_reset() is not going to power down the
> card. It's hard power cycle, so I am kind of surprised that is being
> used at all in this path. This in combination of expecting the value
> from mmc_hw_reset() to never be 1 here, seemed like a good idea to
> preserve the logging of the warning message.
> 
> To silent the static checker tool from warning, we could check
> explicitly for "1". Is that something you want me to do?

I feel like checking for 1 would be more readable for humans as well.

Or we could just leave it as-is.  I'm not likely to ever publish this
static checker warning.

regards,
dan carpenter

