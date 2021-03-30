Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2276434E389
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 10:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3Iwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 04:52:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhC3Iw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 04:52:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U8nimt113663;
        Tue, 30 Mar 2021 08:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CIdTUhxQ5sUljlJ3IEDY20xLXDmCvRKKNOWdV2vV90w=;
 b=LkEwy7b3uhZKwhWN4JyIrsM/oK9yvj7J6OaxyZJoJoiaX/kJijRbkgpucuogoY82rj+K
 AtbP/qHM/S2KWHIa9l67UlNz9ABKd7ygK998cJarzju43imw8xegJNYQhMgLBtgrufF8
 dfJ54bGHNrIKjJuPVY+IKQZ9PEi6yr+v7YmB708wZ8stlU9Pqq1XxoJ/4R2WMqRcGfQw
 UITM8vRjq8eHclRN1YREGPL03BqGzH3RV0zvm57fhUSsPchpZghRdXv8f71ubgt4L9HS
 wpUFqO9UqSx7/AjvkkomSGJywV2xNAt9nDkqIwZd8g8Rcxsec2v1oBK1lcX//bH8tWoW Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37hvnm6cwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 08:52:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12U8oZxR081352;
        Tue, 30 Mar 2021 08:52:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 37jefrwnnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 08:52:22 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12U8qKK3008311;
        Tue, 30 Mar 2021 08:52:20 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Mar 2021 01:52:19 -0700
Date:   Tue, 30 Mar 2021 11:52:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Ajay.Kathat@microchip.com, Claudiu.Beznea@microchip.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wilc1000: fix a loop timeout condition
Message-ID: <20210330085212.GA2088@kadam>
References: <YFS5gx/gi70zlIaO@mwanda>
 <cd087f6b-5f99-3bce-0015-ccf1a82625f2@microchip.com>
 <37239c87142346dcba616cc63c64294dc274983b.camel@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37239c87142346dcba616cc63c64294dc274983b.camel@egauge.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300062
X-Proofpoint-GUID: o26FZd8PJUsmuay_1To0ZsU9p_6XOfKp
X-Proofpoint-ORIG-GUID: o26FZd8PJUsmuay_1To0ZsU9p_6XOfKp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300062
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 29, 2021 at 12:47:15PM -0600, David Mosberger-Tang wrote:
> On Fri, 2021-03-19 at 16:09 +0000, Ajay.Kathat@microchip.com wrote:
> > On 19/03/21 8:17 pm, Dan Carpenter wrote:
> > > If the loop fails, the "while(trials--) {" loop will exit with "trials"
> > > set to -1.  The test for that expects it to end with "trials" set to 0
> > > so the warning message will not be printed.
> > > 
> > > Fix this by changing from a post-op to a pre-op.  This does mean that
> > > we only make 99 attempts instead of 100 but that's okay.
> > > 
> > > Fixes: f135a1571a05 ("wilc1000: Support chip sleep over SPI")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > Thanks Dan.
> 
> Good catch, but wouldn't it be better to fix the time-out check
> condition instead?  Something a long the lines of:
> 
> --- drivers/net/wireless/microchip/wilc1000/wlan.c~	2021-03-29 12:44:52.066039259 -0600
> +++ drivers/net/wireless/microchip/wilc1000/wlan.c	2021-03-29 12:40:29.176365116 -0600
> @@ -457,7 +457,7 @@
>  	u32 wakeup_reg, wakeup_bit;
>  	u32 to_host_from_fw_reg, to_host_from_fw_bit;
>  	u32 from_host_to_fw_reg, from_host_to_fw_bit;
> -	u32 trials = 100;
> +	int trials = 100;
>  	int ret;
>  
>  	if (wilc->io_type == WILC_HIF_SDIO) {
> @@ -483,7 +483,7 @@
>  		if ((reg & to_host_from_fw_bit) == 0)
>  			break;
>  	}
> -	if (!trials)
> +	if (trials < 0)
>  		pr_warn("FW not responding\n");
>  
>  	/* Clear bit 1 */
> 
> 
> This way, the loop could actually get executed the number of times
> indicated by the initialization of "trial" before issuing a warning
> message.

Those numbers are just made up...  It doesn't matter either way.

regards,
dan carpenter

