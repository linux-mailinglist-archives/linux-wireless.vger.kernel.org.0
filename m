Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3282AD18B0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 21:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfJITXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 15:23:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38184 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfJITXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 15:23:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so3670241ljj.5;
        Wed, 09 Oct 2019 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RjL6aeL+yB6TH6pYK3+ft/SKEqM4F474X+76FvzFX/g=;
        b=Ik6w0eB4orUeDmq8LzqH6DyV81I9I0LFBNRL/z8AXi1llhQHVMkjypPACqPElc8x2w
         c1XL6l/C0CqtG3jX05+8AxX8rnssUQd1VoUCj24+Ct3GjN5TsrCzWucUlQh6DRpSj5lH
         FB40Tz7KDlJbFV9STZQFwyIvooqAMLNbzVZ3EIGcY679sKOpzgclbMI0njxkHLbOlYJ0
         ZiewZi34+U4d4ul8HZXU8X9ULOuNKrDBtdsWPQSAmRCGe7JXPSF7ZuCjjbrlPmCOvOid
         ztgamoWlb6Hg0euNJ4cPFxtCk4ZAh83hbkcBJxDXE6OrLnynPhHtHzIA/Zs/6O9vnUu7
         8acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RjL6aeL+yB6TH6pYK3+ft/SKEqM4F474X+76FvzFX/g=;
        b=tUYRUnyx+XHTBrUccSR2sueoPDKXtwsjdEuM7giKabqBaqqymcFmJfpQToy1gyB9sv
         FfVHlw5Qrw0dE7wB86NtUytQ+fYFfl2xC9SnQoDo2V+Lif18bKI7q4ovDtII/EnrOiGZ
         4MNjLH3B9BA0pC0mfew9zkI3PQbdtCQPHFODTwF4kZZNf9tFgsHC1wk4Ry13hh9krc6r
         tYaINQ+mpJ4sIDxjVtM31+BxpIvPlF1/ow5MyPrBS6Q2viOR4UEFtujjx1f2YyWm0YK0
         ktBbZBM8UHm/0Ge9coX/zItUvXsIcLHJNIaHEgxpK6h6P0tLMmZvHWU5nFt3JAN++etJ
         DvRw==
X-Gm-Message-State: APjAAAWyTjKRf4UXHQiks5tr3/SmtCfG2FT05V0jyWDFo6OWIr9GL4qE
        RWEvK/IZwz7cX6w2XXscIDMzNjaJrYQ=
X-Google-Smtp-Source: APXvYqwAzAWlJ8momOLfd+IzLb8ETNR8DVUq0T2CQK01RB20qrbuF6Dp9LG7GLIhlUwcidi59JcwIA==
X-Received: by 2002:a2e:6101:: with SMTP id v1mr3434522ljb.132.1570649012345;
        Wed, 09 Oct 2019 12:23:32 -0700 (PDT)
Received: from [192.168.1.244] (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id 77sm648652ljj.84.2019.10.09.12.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 12:23:31 -0700 (PDT)
Subject: Re: [PATCH 2/2] ath10k: switch to ieee80211_tx_dequeue_ni
To:     Peter Oh <peter.oh@eero.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190617200140.6189-1-erik.stromdahl@gmail.com>
 <20190617200140.6189-2-erik.stromdahl@gmail.com>
 <87eezw660r.fsf@kamboji.qca.qualcomm.com>
 <19f8023a-1943-9bf5-9a59-a7643f7692bf@eero.com>
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
Message-ID: <fd43b218-7dc7-22dd-664b-46c55c3dd94e@gmail.com>
Date:   Wed, 9 Oct 2019 21:23:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <19f8023a-1943-9bf5-9a59-a7643f7692bf@eero.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/1/19 7:13 PM, Peter Oh wrote:
> 
> On 10/1/19 4:48 AM, Kalle Valo wrote:
>> Erik Stromdahl <erik.stromdahl@gmail.com> writes:
>>
>>> Since ath10k_mac_tx_push_txq() can be called from process context, we
>>> must explicitly disable softirqs before the call into mac80211.
>>>
>>> By calling ieee80211_tx_dequeue_ni() instead of ieee80211_tx_dequeue()
>>> we make sure softirqs are always disabled even in the case when
>>> ath10k_mac_tx_push_txq() is called from process context.
>>>
>>> Calling ieee80211_tx_dequeue_ni() with softirq's already disabled
>>> (e.g., from softirq context) should be safe as the local_bh_disable()
>>> and local_bh_enable() functions (called from ieee80211_tx_dequeue_ni)
>>> are fully reentrant.
>>>
>>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
>> I already applied this, but I still want to check _why_ you are changing
>> this? Is it that you want to call ath10k_mac_tx_push_pending() from a
>> workqueue in sdio.c in a future patch, or what? Because at the moment me
>> and Johannes were not able to find where this is called in process
>> context.
>>
SDIO irqs are threaded irqs (at least on my iMX6 board) and hence process context.
I will see if I can find a trace that shows the call chain more exactly.


> It seems Johannes wants to fix it in mac80211.
> 
> [PATCH v2] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
> 
> Drivers typically expect this, as it's the case for almost all cases
> where this is called (i.e. from the TX path). Also, the code in mac80211
> itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
> uses this_cpu_ptr() without additional protection.
> 
