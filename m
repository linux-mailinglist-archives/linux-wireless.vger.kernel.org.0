Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CF2649B6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgIJQ1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgIJQ13 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFEC061757
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 09:27:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so7420024wrt.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6jX1SztxefZgI8OZLv3RaaIt0sxQUUF2EX+VWttKvM8=;
        b=jNKRtJT65nf8EVz+xjvl4eoAT0DUAFLkPc2vjaokXG4lHC5ir002M1je6XmrOWEY+u
         6rVBpKUNkGkZkik14qVNxV/WoYsXT6HFBvDBcoPYX6SvkmpiGseWCqkoC2Bdnl961EBS
         RXMmjvoz5a+bGSu42bTDEtmqMQiBB8Y3f/nRp7LYeyNaznq+LW4Wu7k50IyPIEfoafwR
         e9G0DFQcLAhTeMtKWNImQQOE7zODSgpgzdht478WRO5scwxo4rJ4ztMTJhTsmHTqdjhF
         yEiebQLQ4BHbgfb+CGX/7hI1WPdtDi+HNlNktUPxnTGF/KsVC//6d0BxZLBzETrzDOzm
         Yr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jX1SztxefZgI8OZLv3RaaIt0sxQUUF2EX+VWttKvM8=;
        b=eR9hUdMIMq5XMChowgNsqWB/T73ZCEz1ZSnuPgB6Cz9rWwdj4fgTE0At4wwks25ILl
         jtrHAovGFvAQoKi+t0wefGQQvg3e3tPxKga08twtIsL88ZbVMawFhkuNwPwfP7JEi5od
         s0reOrlCBv3DokG/tKCdt+N03Eb6ugZLlhWpQjcxcDg/2xEsT9ls88z8Sy/xfB0c5BY2
         glT0Ng8M2I226U1KkBkoT05ghA5M6Kt9PTc47suNxkx3YNvqhkTNotzxgYqNhcdZeAu3
         2tn1SmqxMFmXyRgR8xPzIOAPlgIoKoYnG8kqkpEVtr+NrKhr3MDMZcsoStqkDpnMtJAC
         leZQ==
X-Gm-Message-State: AOAM531wvPVfekALbhzSuIYyOr2gJruiq9d3Zr6EpuxyUzYxXUM7zPMf
        lsUflbf5eI+0ymBojSiSziAa4LfrKjOP1A==
X-Google-Smtp-Source: ABdhPJwVKfqq97UKB4TNvTjrZVkMVRSHKB3qzB+fZj7nE+ThEHspe1UpEaR5aHXGLlC0K4Vz1awPeQ==
X-Received: by 2002:adf:b602:: with SMTP id f2mr9599420wre.186.1599755246645;
        Thu, 10 Sep 2020 09:27:26 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t188sm4527970wmf.41.2020.09.10.09.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 09:27:26 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] wcn36xx: Miscellaneous updates
To:     Kalle Valo <kvalo@codeaurora.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
References: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
 <84a86a12-62d2-cc94-95b3-34b360ad4255@nexus-software.ie>
 <0101017478d3b3af-e0300995-fa17-44ef-b4c2-286469dfeb87-000000@us-west-2.amazonses.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <4db0eee5-12cd-83c6-2550-7200b269c610@linaro.org>
Date:   Thu, 10 Sep 2020 17:28:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0101017478d3b3af-e0300995-fa17-44ef-b4c2-286469dfeb87-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/09/2020 17:22, Kalle Valo wrote:
> I think vger has been slow the last few days, just give it time. At
> least I have not yet noticed any mails gone missing.

OK.


> When I said to split the huge patchset into smaller patchsets I didn't
> mean that you still send_all_  of them at the_same_  time, and_every_
> time you change something. This is even worse than submitting one huge
> patchset. The easiest way is to send one patchset first, wait for few
> days (ideally wait for me to apply it) and then send a new one.

Ah. Sorry about that.

I have until the end of the month with the hardware I'm working with, 
then I'll have to switch to some other platform.

I'll wait for you ;)

