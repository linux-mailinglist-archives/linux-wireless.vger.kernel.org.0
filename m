Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5F8295112
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Oct 2020 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502923AbgJUQrK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438568AbgJUQrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 12:47:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A80C0613CE;
        Wed, 21 Oct 2020 09:47:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k68so2408698otk.10;
        Wed, 21 Oct 2020 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+WkBkIdLaCRaqxG6xfZz2RAN2hVh2XpJAxXOLqPNJ4=;
        b=TFOh1RTyJHyb0LgsVZa1j++Vzn+avRLXei082E4lyj9ewr2D+Ohbwb6bLBJn3wzUBn
         IF2SlX78sbL7QqVGoZ/XUKhZ/Br7oS/lAGWfPBv4AgwU1TtHrdALZAsNY6Xjbwz97QLA
         HE9sbomfj3pm6HwBEvCtkQ/6zQHXjN0gHV58pl1AB7iYZQwFM761y8xlABoaMmM+z0k9
         dmZKfEpQRRdmUB6Nf0aG3tDX3cuQSwnH51jnADP4pc66dgKEsD4GKd4RmB/2ZP0Tcjh+
         o/uDKWdkMweqiKy2lgbxr86303s4+KH9rXOFrahCI0PyjUEsrF+/4FXkNQBybrmyx0wn
         rVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+WkBkIdLaCRaqxG6xfZz2RAN2hVh2XpJAxXOLqPNJ4=;
        b=toHUF3pOPC0QzTVrWlbbprCyG5TZ4MDrujuzs/X1g80zmTeK102msG/v1bzPZfFYUs
         zCM6QjbxS334tdOZlkgB0LfADtHeW4scY1lYIz/Q9VI7VRGaDyzit3TSbgy46kYnh5mU
         ZH+Fg+ZuiaRJB57kjMNEpc6nAA+GpRCLG04pfY7VB+wISkMrTnZKnZqkzdN3lp/st1N8
         Frj+zYEQRfc5WTXAKRJhb/DhxXlNx1kA4CDUhR7tqUIHzj5/CRqlXdv5ZFbw3ZhKdMts
         M8ZSHKFQDMptdnR87Lu+8TcfKmlsWi+lI3i1X+shPPQ/ouaYCzfyigUGlLn/cYfyt7dd
         9COQ==
X-Gm-Message-State: AOAM531LjASDGVdNcbwblv1GmEmNQIMkol3Nkg3Xlw34XIn2HqObqUvH
        QFkn55qDkrCdh8tMpCwgTdl7Qkc1I9s=
X-Google-Smtp-Source: ABdhPJxU6yU7uac6nZR9F5QQLHvtEhGGYs8QjK6LmG6LQ9BvG6HvfjYQWbOKZe/vnpkaEKRZ65bpTA==
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3092149otq.113.1603298828760;
        Wed, 21 Oct 2020 09:47:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s189sm830582oig.46.2020.10.21.09.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 09:47:07 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] ssb: Fix error return in ssb_bus_scan()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201021073305.4400-1-jingxiangfeng@huawei.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <86de3c58-250e-9da7-1446-2e3bef7ea97a@lwfinger.net>
Date:   Wed, 21 Oct 2020 11:47:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201021073305.4400-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/21/20 2:33 AM, Jing Xiangfeng wrote:
> Fix to return error code -EINVAL from the error handling case instead
> of 0.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>   drivers/ssb/scan.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ssb/scan.c b/drivers/ssb/scan.c
> index f49ab1aa2149..4161e5d1f276 100644
> --- a/drivers/ssb/scan.c
> +++ b/drivers/ssb/scan.c
> @@ -325,6 +325,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
>   	if (bus->nr_devices > ARRAY_SIZE(bus->devices)) {
>   		pr_err("More than %d ssb cores found (%d)\n",
>   		       SSB_MAX_NR_CORES, bus->nr_devices);
> +		err = -EINVAL;
>   		goto err_unmap;
>   	}
>   	if (bus->bustype == SSB_BUSTYPE_SSB) {
> 

You misread the code. The current version is returning -ENOMEM, not 0 for this 
error. Returning -EINVAL could be regarded as as better value; however, this 
error is not likely to appear and it does not make much difference!

In any case, the commit message is wrong. NACK.

Larry

