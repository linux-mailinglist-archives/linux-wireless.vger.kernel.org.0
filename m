Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C825F1C3341
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEDHCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 03:02:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46813 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgEDHCS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 03:02:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504070216euoutp02e7ff49dafe256fed788768c8b6d48310~LwTczV5Zs1892718927euoutp02a
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 07:02:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504070216euoutp02e7ff49dafe256fed788768c8b6d48310~LwTczV5Zs1892718927euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588575736;
        bh=nzVXZzP1APaCfvjagjz60f9wcVrTAiVB9Q0JV5WUk70=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RGugT+algbCYzCUKQiqGyRn8D/PwAq1FXxQXjl43aWEsQAluMOU/4q1ZzuvgLAobf
         INGVF1JDI1Vp5uNEmgNUalHsrlB7gr0Dz6xrK3w9E4BSqT/cRdpX5IGCqhOOIKD2op
         pLMyOvQ/7V9v4Uj0RptiOcujrmlQ9FvVEeAhzMyQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200504070216eucas1p1336fa8012cf17fcc932b32e15c9874f0~LwTcj3Qwi1265012650eucas1p1C;
        Mon,  4 May 2020 07:02:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.7B.60679.8FDBFAE5; Mon,  4
        May 2020 08:02:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200504070215eucas1p1e06b3860b1a8cf18e27ae7e0ca07164b~LwTcTKXnq1245112451eucas1p1p;
        Mon,  4 May 2020 07:02:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200504070215eusmtrp172848af3350bc6ae36314bbc40e36d3b~LwTcShYbd1658016580eusmtrp12;
        Mon,  4 May 2020 07:02:15 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-38-5eafbdf8a51c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.C4.08375.7FDBFAE5; Mon,  4
        May 2020 08:02:15 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200504070215eusmtip1d3e608fe0c79dbddc18e8a4c11a3eac4~LwTb8e0Br1935219352eusmtip1H;
        Mon,  4 May 2020 07:02:15 +0000 (GMT)
Subject: Re: [PATCH 4/6] thermal: core: stop polling timer for disabled
 thermal zone
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, andrzej.p@collabora.com, luca@coelho.fi
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0c39db18-f048-8166-fde1-0f869ba5c12c@samsung.com>
Date:   Mon, 4 May 2020 09:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200430063229.6182-5-rui.zhang@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7o/9q6PM9h2k8Vi2eN7LBbzPsta
        fO49wmjxZsUddosZ52exWzx52MfmwObxcNdsNo8dd5cweize85LJ4861PWwenzfJBbBGcdmk
        pOZklqUW6dslcGWc+LeIueAQZ8XKZScZGxgfsHcxcnJICJhI3H11j7GLkYtDSGAFo8TKVw0s
        EM4XRom+hafYIJzPjBLfds9lhmk5PmMyO0RiOaNE76JFUP1vGSUuH97CBlIlLBAmsXbTGSYQ
        W0RAWWLRua2MIDazQBOjxPdjBSA2m4CVxMT2VWBxXgE7iScLloEdxSKgIvHlzVawXlGBCIlP
        Dw6zQtQISpyc+YQFxOYUsJB4vngFG8RMcYlbT+YzQdjyEtvfzmEGOUhCYBO7xKn1C1khznaR
        uHJuISOELSzx6vgWaAjISJye3MMC0bCOUeJvxwuo7u2MEssn/2ODqLKWuHPuF5DNAbRCU2L9
        Ln2IsKPElJtL2UHCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrEhmUb2GDWdu1cyTyBUWkW
        ktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMw9Zz+d/zLDsZd
        f5IOMQpwMCrx8D74vC5OiDWxrLgy9xCjBAezkgjvjpb1cUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUw1j9NZ3VyZnvYsjzeaXde8OGjquWKH3IKhC5G
        NlWFScmU+Gv4sah88/N/8oXfTGPDubrdrCdyn2VmLX8w7+jUacYv9PaYXj9W3VHUHOLkNvnK
        /qbeemn3LX8UmfOXK9a8DHHN39r3prlB5ULd/8CSWWL2+tetXi2VcBDdmjHn5uq0dR/viP9R
        YinOSDTUYi4qTgQAmHLJGDkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7rf966PMzi2ytBi2eN7LBbzPsta
        fO49wmjxZsUddosZ52exWzx52MfmwObxcNdsNo8dd5cweize85LJ4861PWwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWc+LeIueAQ
        Z8XKZScZGxgfsHcxcnJICJhIHJ8xGcjm4hASWMoosWfDPNYuRg6ghIzE8fVlEDXCEn+udbFB
        1LxmlFhz5j4jSEJYIExi7aYzTCC2iICyxKJzWxlBipgFmhglnj8/yQrRsZNRon/ZBmaQKjYB
        K4mJ7avAunkF7CSeLFgGdgaLgIrElzdbwSaJCkRIHN4xC6pGUOLkzCcsIDangIXE88Ur2EBs
        ZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9Nxi
        Q73ixNzi0rx0veT83E2MwFjbduzn5h2MlzYGH2IU4GBU4uF98HldnBBrYllxZe4hRgkOZiUR
        3h0t6+OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YBvJK4g1NDc0tLA3Njc2NzSyUxHk7
        BA7GCAmkJ5akZqemFqQWwfQxcXBKNTD2aRpPD+fNsUzfvmbPp6BVwisDcpa+W30l/fP/xW0e
        W40rNS9MmNh7oEvCNoCrf+7qUuWo/z1+29wEfaNdLOce2/z6lZn2qrc375YELVt+YJP6iXkG
        btxayZ6/d3E+atb3SpmtanT74WTdyWI1ZbWflc84L5cVjJT+kVsxKfj4nCPrn7zfUrVXiaU4
        I9FQi7moOBEAQ22PussCAAA=
X-CMS-MailID: 20200504070215eucas1p1e06b3860b1a8cf18e27ae7e0ca07164b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430062919eucas1p1b5b5fa7cf5832290c455c442f9349fd1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430062919eucas1p1b5b5fa7cf5832290c455c442f9349fd1
References: <20200430063229.6182-1-rui.zhang@intel.com>
        <CGME20200430062919eucas1p1b5b5fa7cf5832290c455c442f9349fd1@eucas1p1.samsung.com>
        <20200430063229.6182-5-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/30/20 8:32 AM, Zhang Rui wrote:
> For a disabled thermal zone, thermal_zone_device_update() should do
> nothing but cancelling the polling timer.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 04a16a9..5f7a867 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -508,7 +508,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>  	int count;
>  
>  	if (should_stop_polling(tz))
> -		return;
> +		goto update_polling;
>  
>  	if (atomic_read(&in_suspend))
>  		return;
> @@ -525,6 +525,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
>  
> +update_polling:
>  	/*
>  	 * Alright, we handled all the trips successfully.
>  	 * So, start monitoring again.
> 

