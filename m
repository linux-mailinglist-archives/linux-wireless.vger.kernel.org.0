Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1891D163C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 15:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgEMNpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 09:45:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47402 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbgEMNpU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 09:45:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDghdm185943;
        Wed, 13 May 2020 13:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8ks0wjUZV9bVhyL+/TmpTcLUBdA9CWNF+/NnWKfcOnc=;
 b=oIw7RhmC1BX9l27pVlFIpWXUn/kvwXgkYg2GaJQ7QeRuFmZks3/hCBCbJKjUG7tWCZ9V
 X2qgGASjnsvGSBhTv1WDPtdDjClRBjgOAljJDLtoLe5UxOaM+OLPERs0NfGZ2rzP5vsr
 oeGOKK/2yJTeg13AG14TXXeG53I358hKRUxkBTW0M3w0kdW09sw/N/N3ggRqO8CiJJkg
 i0HoxxuJrjSsqoA/nFm9+hs9ZohXonLJM2MsDEJ6sO0efvcu7KAuP+kPOPRWRwsrBhuJ
 tY6bvSTM81A4b5c6uxLLmFqxOGDATeMc7uCim7Pxfpu9Od/JKSa6ZdyLvDJ27mu6jmbS AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3100yfv8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 13:44:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDgXgQ071389;
        Wed, 13 May 2020 13:44:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3100ym43ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 13:44:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DDirpG019788;
        Wed, 13 May 2020 13:44:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 06:44:53 -0700
Date:   Wed, 13 May 2020 16:44:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()
Message-ID: <20200513134446.GC3041@kadam>
References: <20200513093951.GD347693@mwanda>
 <ba9452bd2cff4888b76fd17ef85a274b@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9452bd2cff4888b76fd17ef85a274b@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=783 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=2
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=2 spamscore=0 impostorscore=0
 mlxlogscore=813 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130122
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 01:38:09PM +0000, Walter Harms wrote:
> IMHO _rtl_usb_transmit() should not free() either
> it should return -1.
> The only caller is rtl_usb_tx() where we need a check:
> 
> if ( _rtl_usb_transmit()  < 0)
>   goto err_free;
> 
> but i am confused, rtl_usb_tx() is returning NETDEV_TX_OK in an error case ?
> 
> err_free:
>      dev_kfree_skb_any(skb);
>       return NETDEV_TX_OK;

This is a pretty typical pattern in networking.  For convenience we are
pretending that the transmit always succeeds and that the packet was
lost somewhere in the network.  The TCP layer will ask for a resend.

regards,
dan carpenter


