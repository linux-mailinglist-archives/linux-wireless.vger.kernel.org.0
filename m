Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF212BA964
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgKTLof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 06:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKTLof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 06:44:35 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16485C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 03:44:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 1so9542754wme.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pL6SzjdumWaAGGjXZoxVBdBkUuZKceENRGmtg8Anv2Y=;
        b=gEoUm+U9jPkNzALpjJB3iU+pfk5dhmotTQWF6cLiCDtB5sGQXmR/BkHw6BgkW4hpHe
         InmTMyve0LaIDHl4PMjteg5Io9t7HxTsMkACE+Ngv8sZqHcKzG2QSM+BQuzN2OgBwSuw
         iK4eheNrg0EH29kzriC4Jsl7x6gvQnPD+RIOt6a3erpA7EFXy/FjSP/77zRme30ddUdU
         z6kvjIIJno0UTKsdSC1K60SUXw9yh29l83wzCcJS0NLqnJCOQm3xQWq+P+jbWbnlSoHW
         da6Yq48vAogg4Kd6YABVQZu6mjj0VfklrHZWB1Cn34Au8pgp8tn3Pl/66b1QAmR9PKrt
         J3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pL6SzjdumWaAGGjXZoxVBdBkUuZKceENRGmtg8Anv2Y=;
        b=Hz2BpLRyltfv7vG5idq+g4Y98lup6c/QlSy9jexuKTAKh2ataBTd7/v+7l639ShBi3
         +L82tcKf41yaEXLNoGcB/xSnd+7wf9dy69KniJNSGnkMTL76jl9ah2vVkiUBlJBnJBzH
         sy8tK09FzYeNKU58kRG8uBnEWp+zXMxGi5i8xvA9JhWaZuTxQZgqlP17I5G2I3exrNEJ
         aFQrjViwUdRpTy1z8oVZ07PuTMe7vbgPivb65cuiQfA2LzdlZN8bdQDYAZPf/oyNZ8o4
         R+RLbtre3JI1V7QrPqR1XRFQoqEV2b3HuhyrvBll4erQgNPZD2SJwbHoK28f4HhCkh8o
         FYAQ==
X-Gm-Message-State: AOAM530Ps9oolx7ddXb7wU43ggmF6Z7W5gc6czGstSNO/OPEEoOmwOSr
        30k7ia5qtwgW8s7XT4z0OtMJPQ==
X-Google-Smtp-Source: ABdhPJwK820EAYs9reGE/pnkpRnaKACuwZwShx/2+DCWA5BWcPafKG/vRMdVumgMLu5SeLHpp5xriw==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr9110140wmg.153.1605872673844;
        Fri, 20 Nov 2020 03:44:33 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b14sm4500956wrs.46.2020.11.20.03.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 03:44:33 -0800 (PST)
Subject: Re: [PATCH] wcn36xx: Don't run scan_init multiple times
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>
References: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
 <CAMZdPi_tixQ_+uZELCjMh75QtC8RADTCU0ipiS-B6X4OTCbJ5A@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <4d4d6565-1178-38f1-3033-fce77b23aeb5@linaro.org>
Date:   Fri, 20 Nov 2020 11:45:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi_tixQ_+uZELCjMh75QtC8RADTCU0ipiS-B6X4OTCbJ5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/11/2020 08:12, Loic Poulain wrote:
> On Fri, 20 Nov 2020 at 03:13, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> Run scan_init only once. There's no need to run this command multiple times
>> if it has already been run once.
>>
>> The software scan algorithm can end up repeatedly calling scan_init on each
>> loop resulting in between four and eight milliseconds of lost time on each
>> callout.
>>
>> Subtract the overhead now.
> 
> This command defines parameters like the BSSID we want to inform,
> etc... So this can change depending on the scan is done while
> connected or not. 

So you're saying a scan is started and our connection state toggles from 
non-connected to connected.

Possible I guess.

> Moreover in the connected case, the scans are
> interleaved with normal data listening period, and AFAIU, init/stop
> scan allow to submit a null data packet with PS/non-PS bit when
> mac80211 leaves the operating channel to scanning another one (so that
> AP does no submit packet to it). So at first glance, this patch would
> break that, right?

I agree with that logic, and actually looking at downstream - we see 
that downstream doesn't set the notification byte before starting a scan 
on a new channel

connected:
[   63.475897] BOD WDI_SendMsg/23794 message = 0x04 version = 0x01 len 
0x00000030 // WLAN_HAL_INIT_SCAN_REQ
[   63.475902] SMD <<< 00000000: 04 00 01 00 30 00 00 00 02 00 00 00 00 
00 00 00 00 00 00 00 00 ff ff ff c8 9f 7a 21 c0 ff ff ff
[   63.475907] SMD <<< 00000020: d4 2e 7c 00 c0 ff ff ff 00 54 93 6d c0 
22 22 00
[   63.478242] SMD >>> 00000000: 05 00 00 00 0c 00 00 00 00 00 00 00

type=04 00 version=01 00 length=30 00 00 00
mode=02 00 00 00
bssid=00 000 00 00 00 00
notify=00
...

which I accept is actually a bug downstream, conceptually at any rate.

I need to ensure a scan isn't in process when we go into suspend but, 
there's no reason to skip the scan_init() command for that.

flagging != skipping

Let's forget this one.

---
bod
