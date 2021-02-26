Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4432694D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 22:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZVQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 16:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhBZVQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 16:16:54 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDEAC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 13:16:14 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id g27so9750070iox.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aEkqz2u+mz0t/VSEBaPY0HHIl5fJzCg4LIHOIOyh/9w=;
        b=XkvlS/0/K8mzVYjc2SkwA1orhL7/IIKO+AlU1wIH6Yw7SKfNfEllTE0zHUERYgRN1k
         alNACxacCD+FKU0qObNNT7n59QnH5+Nx0ATyOZeMJ3PkOqD2hSLHgr8UnENQgyenn06d
         eG8mFZceeK++R9zJ1tRuh4KGxdyJyJZMKp1hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aEkqz2u+mz0t/VSEBaPY0HHIl5fJzCg4LIHOIOyh/9w=;
        b=nsU0E4T4oBBgBakT582I46V4D5p4y50WhHn36pXDCY6QIUthF5MHH8kM33+u0uc8oa
         LXQTUmuH4gVjY57DKkOZvq7hhRPHGJFa99Wq+bNHjC0bfR8lkvJOHlPa3thOFZTkveNg
         +oZNFlQbOADltVz01PlndXb2/+oPGZQWp0hGy5AMhb4sh4f/zlPlnPb2yfL+BTToz01m
         pYFniCf4YZr8iD+tLKUdlM+AjUJB7WbDJz2zTC75K8Np6HsD9GLp70KKzTbDGQOLQzP/
         LMJTg70fwY1aW2wdf98Newx9PwQAjOxcAd4lttXdSN+26sklsULUWE8iyQuvA8tEb/xN
         Vh7Q==
X-Gm-Message-State: AOAM533tQWWT+4T7+ipI57Cyt74GsmYYUGPX46ugg0pXdaoWvlYm5D4E
        htmerOq7Zcavpy5D3INQXFZprw==
X-Google-Smtp-Source: ABdhPJya4CVD+12xGI84DX9yRpBbPixLWbm2kpiFEPOxywzbJ0rPRLUtdkh2MXAsoQVrNpOXNqNePg==
X-Received: by 2002:a05:6602:1799:: with SMTP id y25mr4200492iox.55.1614374173505;
        Fri, 26 Feb 2021 13:16:13 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v8sm5223997ilg.21.2021.02.26.13.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:16:13 -0800 (PST)
Subject: Re: [PATCH v2 1/3] lockdep: add lockdep_assert_not_held()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1614355914.git.skhan@linuxfoundation.org>
 <a40d18bba5a52662ac8fc556e1fce3752ea08472.1614355914.git.skhan@linuxfoundation.org>
 <YDli+H48Ft3F6k9/@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0ee409b7-b0d5-43c2-c247-b0482c392dea@linuxfoundation.org>
Date:   Fri, 26 Feb 2021 14:16:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDli+H48Ft3F6k9/@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/26/21 2:07 PM, Peter Zijlstra wrote:
> On Fri, Feb 26, 2021 at 10:52:13AM -0700, Shuah Khan wrote:
>> +		/* avoid false negative lockdep_assert_not_held()
>> +		 * and lockdep_assert_held()
>> +		 */
> 
> That's a coding style fail.
> 

Checkpatch didn't complain. What's your preference? Does the
following work for you?

/*
  * avoid false negative lockdep_assert_not_held()
  * and lockdep_assert_held()
  */

thanks,
-- Shuah
