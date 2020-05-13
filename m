Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A611D0A82
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgEMIIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 04:08:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 04:08:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D876Ma052232;
        Wed, 13 May 2020 08:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Pim3IyZEqDINjfDwlBqdtARzuZVxKAN42pmXSwBLfzc=;
 b=fqxicfpJPqKPb1RSyJQloP3G7RhXuxG/kifLy0qlydEukyx8rJ4TSthyDlPvFsbnSWrf
 w+A9UYSpPQHiEQxF5CGlH4Y+uIGIVEEY0iaOnhWD9yXRkpYWamm5mxpzkDt8rKgptTAw
 V9TCLDqGVFCi6fsCmfBmUQ+PBOQAQ+aVTNNvADN0wpCD6Is9dnJxwx9IGA9FHdGMK7wb
 +j703FTqToS13eDX27Rj4cgG96GLAZpYnKMfAfN3ihuxzZLyvOcfBsmhSGwVFhpOSt1F
 RtFcwGc1D5xvNny7jusDSnEw7HiCbxICBeQUIHIsypKPpjz5DkWbC7FSL2qW6X1qOyS/ JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3100xwap3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 08:08:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D881FK161746;
        Wed, 13 May 2020 08:08:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3100ye32gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 08:08:07 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04D884Gv003480;
        Wed, 13 May 2020 08:08:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 01:08:04 -0700
Date:   Wed, 13 May 2020 11:07:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: vt6656: vnt_get_rtscts_duration_le use
 ieee80211_rts_duration
Message-ID: <20200513080758.GB2078@kadam>
References: <377a4cc3-cfe3-91aa-cf71-1063f311426a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377a4cc3-cfe3-91aa-cf71-1063f311426a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130075
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 05, 2020 at 10:13:54PM +0100, Malcolm Priestley wrote:
> diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
> index 6724b213a723..48fe16c27d3f 100644
> --- a/drivers/staging/vt6656/rxtx.c
> +++ b/drivers/staging/vt6656/rxtx.c
> @@ -285,28 +285,18 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
>  					 u8 dur_type, u8 pkt_type, u16 rate)
>  {
>  	struct vnt_private *priv = context->priv;
> -	u32 cts_time = 0, dur_time = 0;
> +	u32 dur_time = 0;
>  	u32 frame_length = context->frame_len;
>  	u8 need_ack = context->need_ack;
> +	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(context->skb);
>  
>  	switch (dur_type) {
> +	/* fall through */
>  	case RTSDUR_BB:
>  	case RTSDUR_BA:

This fall through annotation shouldn't be necessary.  It's not preceded
by a case statement.  Also you don't need /* fall through */ for empty
case statements.  In other words you only need it for stuff like this:

	case FOO:
	case BAR:
		frob();
		frob();
		/* fall through */
	case BAZ:

regards,
dan carpenter

