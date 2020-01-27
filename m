Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3E149F45
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 08:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgA0HhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 02:37:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39220 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgA0HhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 02:37:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R7XH7s190077;
        Mon, 27 Jan 2020 07:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=X3ojtfLSfpA0FQl3LMsuSvyXF8jAUJKrBVss7jDXLFM=;
 b=VTLJ3y3r6NPnBdUk/xbIqFRh83KziIr4YhtfhBxL3Y7nGGrRE7JlTDjCOB1fPRA6mv8F
 KRpfR0ieatvs1E7yK3agsuRIhpTh1BuXwTkjXprq7k8jWpydG42L0hT+5GzG5KHq6IFb
 rVOVzSHfrTKqOsikvaDkkChbzVvh1FEJVKmJtjhbwuKjFYcz2e4v4cb81+5ly0uPS++0
 SinBGDhfnLDlDzl86abOTRFeLjAuwuHf8+6OcmeTS/lJSeP+h9VGx/PAy5VQa1/uxdqm
 dgjbwijvRd4jpi3HBf0xpGwqn5zvXonVkMrPYSiOdpL6sMu/0IKs5nnfAQAB5hY++oV/ qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xreaqwfa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 07:37:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R7XWNV110982;
        Mon, 27 Jan 2020 07:37:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xrytpfa61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 07:37:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00R7bCwR028665;
        Mon, 27 Jan 2020 07:37:12 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jan 2020 23:37:11 -0800
Date:   Mon, 27 Jan 2020 10:37:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        Adham.Abozaeid@microchip.com
Subject: Re: [PATCH 1/2] staging: wilc1000: return zero on success and
 non-zero on function failure
Message-ID: <20200127073701.GP1847@kadam>
References: <20200123182129.4053-1-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123182129.4053-1-ajay.kathat@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270064
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jan 23, 2020 at 12:50:47PM +0000, Ajay.Kathat@microchip.com wrote:
> @@ -384,19 +378,18 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 addr, u32 data)
>  		cmd.address = addr;
>  		cmd.data = data;
>  		ret = wilc_sdio_cmd52(wilc, &cmd);
> -		if (ret) {
> +		if (ret)
>  			dev_err(&func->dev,
>  				"Failed cmd 52, read reg (%08x) ...\n", addr);
> -			goto fail;
> -		}

Please don't resend, but try to avoid this sort of anti-pattern in the
future.  You're treating the last failure condition in the function as
special.  In this case it's particularly difficult to read because we
are far from the bottom of the function, but even if we were right at
the bottom, I would try to avoid it.

I am extreme enough that I would avoid even things like:

	ret = frob();
	if (ret)
		printf("ret failed\n");
	return ret;

Instead I would write:

	ret = frob();
	if (ret) {
		printf("ret failed\n");
		return ret;
	}
	return 0;

It's just nice to have the error path at indent level 2 and the
success path at indent level 1.  And the other thing that I like is the
BIG BOLD "return 0;" at the end of the function.  Some functions return
positive numbers on success so if I see "return result;" then I have to
look back a few lines to see if "result" can be positive.

The other anti-pattern which people often do is success handling
(instead of error handling) for the last error condition in a function.

	ret = one();
	if (ret)
		return ret;
	ret = two();
	if (ret)
		return ret;
	ret = three();
	if (!ret)
		ret = four();
	return ret;

Never never do that.  :P

Anyway, don't resend.  It's just food for thought.

regards,
dan carpenter

>  	} else {
>  		struct sdio_cmd53 cmd;
>  
>  		/**
>  		 *      set the AHB address
>  		 **/
> -		if (!wilc_sdio_set_func0_csa_address(wilc, addr))
> -			goto fail;
> +		ret = wilc_sdio_set_func0_csa_address(wilc, addr);
> +		if (ret)
> +			return ret;
>  
>  		cmd.read_write = 1;
>  		cmd.function = 0;
> @@ -407,18 +400,12 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 addr, u32 data)
>  		cmd.buffer = (u8 *)&data;
>  		cmd.block_size = sdio_priv->block_size;
>  		ret = wilc_sdio_cmd53(wilc, &cmd);
> -		if (ret) {
> +		if (ret)
>  			dev_err(&func->dev,
>  				"Failed cmd53, write reg (%08x)...\n", addr);
> -			goto fail;
> -		}
>  	}
>  
> -	return 1;
> -
> -fail:
> -
> -	return 0;
> +	return ret;
>  }

