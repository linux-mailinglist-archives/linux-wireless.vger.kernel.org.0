Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F312A3531
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfH3Krs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:47:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33118 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3Krr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:47:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so6526429wrr.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T+aEAr4O1NoEtb/COJvgCNqlBdRR6P2losTKMLOd3M4=;
        b=WqUI++46kD2tPWCsw6jvCxJXTCbYmXr1pYk3T6VXRBQfbrvT24W2zvqLLqlqrvJvU6
         84kov8iVfZJyF6UjQGdDvOGCDZp7dlelPn8n5QLaAQkihkz+7L9X80jBr7Hvk0kYzRWb
         egL1OZ2QnlKFM8FRVvfE95zSrppw1OivU2UlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T+aEAr4O1NoEtb/COJvgCNqlBdRR6P2losTKMLOd3M4=;
        b=Q3fu57QZ5uPVsZtOTWHS/ETC47JZg47OQH5zL+nqEoRmn6FBZq9MgKYdZc3upRdu9q
         g/IQWsJQaYZ+VaR/sMEroZgiAlAQ8JgV5PgNqN2o+Nmyd4YVEum0IRjAYi7VRfKu+xOs
         k0ca+T/l9YmjQyolDSkkPCfLYLBJeIv8HNyNDujadE9PxSF0pAtIe6iTGijE46dus9sQ
         lAOMgqWMQPCd7smxYH3w0mS6GpAtGMlARroDsZeJlf1yKIXO7LMJniH4N62xSyf3sr5q
         /BpCDZ16JB7ZMRowDVhCtrJiTvqHCuLgvwD4FP+glCFoTGwUeWjmluTs7LbDCPuN3uiB
         NjZw==
X-Gm-Message-State: APjAAAWEOffJBI9+6o8Z0x20vbaRcDI1YSiBMapT/nP1kBopmGHeYqBX
        l8Bk8pFrEKtaZJzkbJF/+q178A==
X-Google-Smtp-Source: APXvYqznno9hVIVtf42bpLC6uGxTO0cYb4qVHarreixnKQ+KLI5LdxVrxfVkaHli65UF1W7mVWDElQ==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr18349655wri.258.1567162066042;
        Fri, 30 Aug 2019 03:47:46 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id a141sm17819190wmd.0.2019.08.30.03.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 03:47:45 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: Convert 6 GHz channel frequency to channel
 number
To:     Johannes Berg <johannes@sipsolutions.net>,
        Amar Singhal <asinghal@codeaurora.org>, jouni@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
References: <1567117290-19295-1-git-send-email-asinghal@codeaurora.org>
 <420dcc9c0023791b72dba2d776045fc0b025597a.camel@sipsolutions.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <b9520a71-2571-4334-65b8-8707159406aa@broadcom.com>
Date:   Fri, 30 Aug 2019 12:47:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <420dcc9c0023791b72dba2d776045fc0b025597a.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/2019 12:32 PM, Johannes Berg wrote:
> On Thu, 2019-08-29 at 15:21 -0700, Amar Singhal wrote:
>> Enhance function ieee80211_frequency_to_channel by adding 6 GHz
>> channels.
> 
> Wait, this is already supported, no? Just implemented slightly
> differently?

It is Johannes, but I was unaware as well. Did you forget to email that 
it was applied or is there some automated stuff that failed on you? ;-)

Regards,
Arend
