Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84FF1BF6E1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD3Ldw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726784AbgD3Ldw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 07:33:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B7C035494;
        Thu, 30 Apr 2020 04:33:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 117552A2686
Subject: Re: [PATCH 2/6] thermal: core: delete thermal_notify_framework()
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "luca@coelho.fi" <luca@coelho.fi>
References: <20200430063229.6182-1-rui.zhang@intel.com>
 <20200430063229.6182-3-rui.zhang@intel.com>
 <f6d7dcae-ccf1-eee1-2ac1-eaa8472e2f87@collabora.com>
 <744357E9AAD1214791ACBA4B0B90926377CFB787@SHSMSX108.ccr.corp.intel.com>
 <c2ca43e3-8da9-3abf-4c70-e5104821bce9@collabora.com>
Message-ID: <5ae152f8-9721-6fcd-0e87-fd71e32561a8@collabora.com>
Date:   Thu, 30 Apr 2020 13:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c2ca43e3-8da9-3abf-4c70-e5104821bce9@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

W dniu 30.04.2020 o 13:32, Andrzej Pietrasiewicz pisze:
> Hi Rui,
> 
> W dniu 30.04.2020 o 10:58, Zhang, Rui pisze:
>>
>>> -----Original Message-----
>>> From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>>> Sent: Thursday, April 30, 2020 4:47 PM
>>> To: Zhang, Rui <rui.zhang@intel.com>; linux-pm@vger.kernel.org
>>> Cc: linux-wireless@vger.kernel.org; daniel.lezcano@linaro.org;
>>> b.zolnierkie@samsung.com; luca@coelho.fi
>>> Subject: Re: [PATCH 2/6] thermal: core: delete thermal_notify_framework()
>>> Importance: High
>>>
>>> Hi Rui,
>>>
>>> Thanks for the series,
>>>
>>> W dniu 30.04.2020 o 08:32, Zhang Rui pisze:
>>>> Delete thermal_notify_framework() as there is no user of it.
>>>>
>>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> <snip>
> 
>> Can you please try this patch and confirm the polling timers are 
>> queued/cancelled as expected?
>>
> 
> Yes, they are. I'm testing on an x86 machine with drivers/acpi/thermal.c.

I should've said x86_64.

> 
> Tested-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> 

