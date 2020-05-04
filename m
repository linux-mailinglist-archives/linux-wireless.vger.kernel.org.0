Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944901C333E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgEDHBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 03:01:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46679 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgEDHBt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 03:01:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504070147euoutp02bc6b20bb4f16c7b02fe43d7593775cef~LwTCQuEFs1892918929euoutp02N
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 07:01:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504070147euoutp02bc6b20bb4f16c7b02fe43d7593775cef~LwTCQuEFs1892918929euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588575707;
        bh=KoAjdM3O8P+200ngHyLuPp9w/Dq466s0GNbOpr578TI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bqjnXebXHxbUJJcCca7riKJ3r0UY0NIbyduSMicNLObc6LIbS/3e4isB3zSnHbdLe
         TVkRmqFjSc+ZLJ4EaBbWsl1fv8Ae954BJW87Ix0IaxugvkXGJosNh1MqW4RsIfNQzk
         XeyuyW6Pqjjt04SN2NelXx2Hjk+0wQz/v8FENPdY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200504070147eucas1p268a50a132aa35326888bc96a4b36e65a~LwTCDch4r3061730617eucas1p2T;
        Mon,  4 May 2020 07:01:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 39.0B.61286.BDDBFAE5; Mon,  4
        May 2020 08:01:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200504070147eucas1p2284090e7f8a4afa10b94c2089170c12a~LwTBqtsXx0448704487eucas1p2p;
        Mon,  4 May 2020 07:01:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200504070147eusmtrp2ac38f8e48dde543f6bf12271e691c4a4~LwTBqH2Ua0141301413eusmtrp2W;
        Mon,  4 May 2020 07:01:47 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-b6-5eafbddbe8f3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.41.07950.BDDBFAE5; Mon,  4
        May 2020 08:01:47 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200504070146eusmtip2e38b228add8bc93b5256d9f8273da772~LwTBTwaqu0498004980eusmtip2D;
        Mon,  4 May 2020 07:01:46 +0000 (GMT)
Subject: Re: [PATCH 3/6] thermal: core: update polling after all trips
 handled
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, andrzej.p@collabora.com, luca@coelho.fi
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <918bfe45-511a-e527-7950-c19a64f29f40@samsung.com>
Date:   Mon, 4 May 2020 09:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200430063229.6182-4-rui.zhang@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87q3966PM1i2SMNi2eN7LBbzPsta
        fO49wmjxZsUddosZ52exWzx52MfmwObxcNdsNo8dd5cweize85LJ4861PWwenzfJBbBGcdmk
        pOZklqUW6dslcGVMf3OfsaCNp+LxV/kGxo+cXYycHBICJhIH5r9j62Lk4hASWMEosfLfPlYI
        5wujxPbDTYwgVUICnxklnhwq72LkAOvY22UBUbOcUWL+zVlQDW8ZJZ51PmIFaRAWCJB4uPAY
        E4gtIqAssejcVrBBzAJNjBLfjxWA2GwCVhIT21eBxXkF7CRO/n0M1ssioCLx4sl5ZhBbVCBC
        4tODw6wQNYISJ2c+YQGxOQUsJD4cPMgGMVNc4taT+UwQtrzE9rdzmEEOkhBYxy5xcPYXJog/
        XSSuvboPZQtLvDq+hR3ClpH4vxOkGayBUeJvxwuo7u2MEssn/2ODqLKWuHPuFxvI/8wCmhLr
        d+lDhB0lrszYzAYJFj6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq5knsCoNAvJ
        a7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZh0Tv87/mkH49dL
        SYcYBTgYlXh4H3xeFyfEmlhWXJl7iFGCg1lJhHdHy/o4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhi3PhL+clH3/ddsqdTg2B9Sx1W7qks1Glh1dDR+
        OfQumO9zQc/h16yvVpIfjjvk217KebRr7ibB9fJNj91rmb3uN+bxs2wL23e4wOGURdfxUOU6
        0XOJ54xnt5YEPpDdwa7FcP99w7PS5pwibQWpF1GHee4ZB15Jj1h6scrtqBCL0ZYa3S0u85VY
        ijMSDbWYi4oTAcR8qKk2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7q3966PM3i2msti2eN7LBbzPsta
        fO49wmjxZsUddosZ52exWzx52MfmwObxcNdsNo8dd5cweize85LJ4861PWwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVMf3OfsaCN
        p+LxV/kGxo+cXYwcHBICJhJ7uyy6GLk4hASWMkq8+LOBHSIuI3F8fVkXIyeQKSzx51oXG0TN
        a0aJxx93MYEkhAX8JBaef8EIYosIKEssOreVEaSIWaCJUeL585OsEB07GSUundnDBlLFJmAl
        MbF9FVgHr4CdxMm/j1lBbBYBFYkXT84zg9iiAhESh3fMgqoRlDg58wkLiM0pYCHx4eBBsDnM
        AuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVG
        esWJucWleel6yfm5mxiBcbbt2M8tOxi73gUfYhTgYFTi4X3weV2cEGtiWXFl7iFGCQ5mJRHe
        HS3r44R4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gC8kriDU0NzS0sDc2NzY3NLJTEeTsE
        DsYICaQnlqRmp6YWpBbB9DFxcEo1MFawMWSvqBCcPG3izHMfF2Yy3dzoP/Exyxzx7GpXP9mT
        Z8VCVlQua1TeeCbAlSl6cnmEX8CFbTJmrGW6LQeOWU3PUQ4I+jp12c2/s5wYXgtcjs4WnZG5
        bepJnvoLhgrKPZlHbNLL/iZGz2VNjDnibdR3oybk/txPt3gOJvassZbLWvEue+oTKSWW4oxE
        Qy3mouJEAP5dTBvJAgAA
X-CMS-MailID: 20200504070147eucas1p2284090e7f8a4afa10b94c2089170c12a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430062915eucas1p26bbffdc682312be36d9e1e355bde0fe0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430062915eucas1p26bbffdc682312be36d9e1e355bde0fe0
References: <20200430063229.6182-1-rui.zhang@intel.com>
        <CGME20200430062915eucas1p26bbffdc682312be36d9e1e355bde0fe0@eucas1p2.samsung.com>
        <20200430063229.6182-4-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/30/20 8:32 AM, Zhang Rui wrote:
> Move monitor_thermal_zone() from handle_thermal_trip() to
> thermal_zone_device_update() because updating the polling timers after all
> trips handled is sufficient.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/thermal/thermal_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index ac70545..04a16a9 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -430,11 +430,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  		handle_critical_trips(tz, trip, type);
>  	else
>  		handle_non_critical_trips(tz, trip);
> -	/*
> -	 * Alright, we handled this trip successfully.
> -	 * So, start monitoring again.
> -	 */
> -	monitor_thermal_zone(tz);
>  }
>  
>  static void update_temperature(struct thermal_zone_device *tz)
> @@ -529,6 +524,12 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>  
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
> +
> +	/*
> +	 * Alright, we handled all the trips successfully.
> +	 * So, start monitoring again.
> +	 */
> +	monitor_thermal_zone(tz);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>  


