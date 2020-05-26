Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A641E2357
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgEZNvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 09:51:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgEZNvA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 09:51:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QDmn4A125702;
        Tue, 26 May 2020 13:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rLDlQKBEIHrnN7J+s/D6Z8tjQiOaDK1huwzT3h6OJlg=;
 b=WsYabgce9/2oFmPNh4TH25fTbTiZi7pfda0t2AjCmHw8SWketeaN9vjNSZelR54w4iOI
 SJzj37sGnPo2ZiC5p1u2UMOmu9iWCQPN+cEGEtjTtUXNHmGFAt0bhL1iNGE1WXcTaqcW
 hPKwnoDwmwP8myVonXG9RMGU/rrfdPdRmpjpeZIKpGStmvk/MKT88RRd64fkpT4oCWFR
 jWaExWNRrPedqZuGFrPDzKhqPrErR2wEBGfYqQX4KaQGram0WHOHCnUuAqRz/QDVLZ/9
 fBkl5ZpWAgwqbv0xc4VW6puouyTD124s6A9JpIfHBmofLWujJCH/5b6pvb5DXaaSC9wO BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 318xe19yjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 13:50:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QDgqlV123191;
        Tue, 26 May 2020 13:50:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 317drxg5f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 13:50:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04QDos7M014143;
        Tue, 26 May 2020 13:50:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 06:50:53 -0700
Date:   Tue, 26 May 2020 16:50:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Fix vnt_tx_usb_header static checker
 warning
Message-ID: <20200526135048.GU30374@kadam>
References: <9818e564-81f6-a683-caa0-69423fded401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9818e564-81f6-a683-caa0-69423fded401@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 24, 2020 at 12:12:41AM +0100, Malcolm Priestley wrote:
> drivers/staging/vt6656/rxtx.c:729 vnt_beacon_xmit()
> warn: struct type mismatch 'vnt_beacon_buffer vs vnt_tx_usb_header'
> 
> Since the only part of vnt_beacon_buffer is used remove and
> replace it with vnt_tx_usb_header.
> 
> Fixes: 9deca1e3e2b6 ("staging: vt6656: vnt_beacon_xmit use extra_tx_headroom.")

It's not really a bug fix.  It's just a cleanup.  But whatever...

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks!

regards,
dan carpenter
