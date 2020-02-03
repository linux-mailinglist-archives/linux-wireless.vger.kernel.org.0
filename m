Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE66C150384
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgBCJmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 04:42:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49532 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgBCJmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 04:42:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0139c6mU121618;
        Mon, 3 Feb 2020 09:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Ld1gAObiFV0beMeBZXaX5X98rEt4HUzLbBGH42xu++w=;
 b=eV6AYyz/ZskmkUPXJxJAbI0R3M85dblg141+2SvTBQF5S968XiYRm3no9+Kv9hvh+UHV
 tXMCedDPVcYObqOKnRwc4Ct/794DY5+38oOYy1fziApkU0PC4TP8+TJegn9gt9xEoEcu
 k18CcJAqEVKgeixjF3I5V8eLNODDrRrpUov0+Jt1JRV3FBjKxcc89RF1PickH4EqSrRW
 9XYADVZ7Llmaizx2dsN7xOujD5RRhiweDUew6uerR9aM8L5GtRYtaGxjGfbxxY9uxBhq
 b5vyzc+IQCQDb7CAF75IY1Mbilte08lijKajd95ZKd+Q32nLwKhm1F1Mtmn919wp4TzO sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xw19q6hm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 09:42:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0139cLmk082290;
        Mon, 3 Feb 2020 09:42:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xwjt3gs7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 09:42:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0139gTDO022979;
        Mon, 3 Feb 2020 09:42:29 GMT
Received: from kadam (/41.210.143.134)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 01:42:29 -0800
Date:   Mon, 3 Feb 2020 12:42:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vt6656: fix sign of rx_dbm to
 bb_pre_ed_rssi.
Message-ID: <20200203094222.GM1778@kadam>
References: <9b3b92d6-3672-00be-d0b5-ccd222236ba9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3b92d6-3672-00be-d0b5-ccd222236ba9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030076
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Feb 02, 2020 at 12:27:25PM +0000, Malcolm Priestley wrote:
> bb_pre_ed_rssi is an u8 rx_dm always returns negative signed
> values add minus operator to always yield positive.
> 
> fixes issue where rx sensitivity is always set to maximum because
> the unsigned numbers were always greater then 100.
> 
> Cc: stable <stable@vger.kernel.org>

Can you add a Fixes tag for stable kernels?

Fixes: 63b9907f58f1 ("staging: vt6656: mac80211 conversion: create rx function.")

Otherwise we don't backport it far enough and then it becomes an
actively exploited Android vulnerability and Google writes an article
about it.  Then everyone gets annoyed with us and shakes their head
because OpenBSD never has Android vulnerabilities etc...

> Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
> ---
>  drivers/staging/vt6656/dpc.c | 2 +-

It appears that the vt6655 driver has the same issue.

regards,
dan carpenter

