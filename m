Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7D3A4B08
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 00:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFKXAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 19:00:21 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:36501 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKXAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 19:00:20 -0400
Received: by mail-pl1-f181.google.com with SMTP id x10so3560130plg.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jun 2021 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LeY8R1sHhvlC1CZbjN6MN0DRcMl2VfASbiuDD427Lks=;
        b=Nw9ANqTTklaVJhJ6xW6wSXyVyo1LixVFLojrKWFfqa+jdl3h/BXH3fUVMEo49fi+Dt
         MQwt3cWPlxQ/RPowst0H5oHsMq0yIVGbCkFcGaSEd8PUKd4YY898SnyEcNJgM+QFujHZ
         qWBuJ1vjeSTz2f3/GUXWCjy2mX7Ye7LvEfCdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LeY8R1sHhvlC1CZbjN6MN0DRcMl2VfASbiuDD427Lks=;
        b=NVCC25TVquMYkOtDTFTiuEJ8P5fDifRaCB4OfNJDHIzjFiKfu3QGW/etSDqeiAbvws
         zbAWQ/6ify/P4ZfnF2SM37f4V7e25cpSKCcMmL60FeQRdHvmHnQI9KRYCyIjFrRmrGm3
         YxU8WdFsvzWmGmmA4E/v/4m9LaWZpWiSs4VAXzN9uA4qSyAkyVSoY1yyGdiDWOMWPQ2S
         RPkQxci8BlMG+6fplIl0kMzH3YLruQiDjzZPZW6cWLMFbSVzbPG9nVz3ZNMEYuoh7J/R
         E5JGdBAs7VPc8UJGjnSe3RD2yPI0YXOsYTJOQmrpO2Lr7ykt5pWilmh5BJl3g/Nl/FJ9
         Tmlw==
X-Gm-Message-State: AOAM530ewE1+Mi9AwavM6vfbpo/nEqaQjvY8Jyv5h71CSjOMZIhrMJqC
        EfEGWdB8KDurfp0rsTNqqDEBTKFGZrCj2g==
X-Google-Smtp-Source: ABdhPJyPRG4J3aH6mifcvKGBZZunlZU3cSC4/1VIrPiMB86PduxLd+MTaKUUNrY2Gu6NcQOa6iU/aA==
X-Received: by 2002:a17:902:ced1:b029:115:3e22:1eb4 with SMTP id d17-20020a170902ced1b02901153e221eb4mr5992888plg.19.1623452242153;
        Fri, 11 Jun 2021 15:57:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a053:7c1f:32fb:81d0])
        by smtp.gmail.com with ESMTPSA id n69sm6179473pfd.132.2021.06.11.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 15:57:21 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:57:19 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, steventing@realtek.com
Subject: Re: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate
Message-ID: <YMPqT8VH5alHQXXA@google.com>
References: <20210422030413.9738-1-pkshih@realtek.com>
 <20210422030413.9738-2-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422030413.9738-2-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 22, 2021 at 11:04:13AM +0800, Ping-Ke Shih wrote:
> From: Yu-Yen Ting <steventing@realtek.com>
> 
> The management frame with high rate e.g. 24M may not be transmitted
> smoothly in long range environment.
> Add a debugfs to force to use the lowest basic rate
> in order to debug the reachability of transmitting management frame.
> 
> obtain current setting
> cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> 
> force lowest rate:
> echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> 
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I believe some initial objection to this was because it was unclear if
this is for "production" use (e.g., recommending distros to play with
this) or for debugging. I'll admit, I requested the feature for patch 1,
because I've seen that for those networks where people *do* configure
odd Basic Rates, they intend for stations to follow those, and not use
the lowest (and most airtime-hogging) rates.

And I can say, I don't see why distributions should be turning that back
off. If the Basic Rates setting is wrong, then the that's up to the
network admin to fix.

All that is to say: I agree that this patch is purely for debugging, as
stated, and that it belongs in debugfs. I also maintain a distribution,
and I don't plan on using this beyond debugging.

Therefore:

Reviewed-by: Brian Norris <briannorris@chromium.org>

BTW, if we have clear guidelines on debugfs, module parameters, etc.,
maybe those should be going on the wiki? I know this came up before:

https://lore.kernel.org/linux-wireless/87d09u7tyr.fsf@codeaurora.org/

At this point, I'm willing to write such guidelines, if I get an ack
from the relevant folks (I guess that's just Kalle?). It probably
belongs somewhere in this tree:

https://wireless.wiki.kernel.org/en/developers/documentation

similar to this:
https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
except it's not really an nl80211 thing. Suggestions welcome.

Side note: it could really use some cleanup -- like this page:
https://wireless.wiki.kernel.org/en/developers/process

Brian
