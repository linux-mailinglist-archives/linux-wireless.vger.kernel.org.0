Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E082BCC1E8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJDRls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 13:41:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40867 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbfJDRlr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 13:41:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so3448862pll.7
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bY0SJ24zYmB1qxRe/Q9yCRjjg0+JodwNFvH6OcVVYCw=;
        b=sicFz1BRAhMUtJIJMcW1ia1g4NWklxMruezEw4HjgcsYAgDmWEQXFf5oXPU0BemfuM
         dxrLCV3VaLESV9EiaxhWSly7RWyH5zG6xSHFymtFIDSIxHuAUl3f6oLn7B6YorzaZnQT
         /TT4Sp5bcgdZljJfTXE0su9UGsqNCR1IN3s1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bY0SJ24zYmB1qxRe/Q9yCRjjg0+JodwNFvH6OcVVYCw=;
        b=IjGC1IgH9GV/he86Ri6yLgimJmAjZpZPMWc8s3mcTeSXwEediM7uouJ2UqC3hvOpAW
         k7EreV75ZKtbkhZYZdFpm80C1cumHj1hS0YyeESQ3gUYZStB7oQrv2qujeBdIEmNCHBp
         wlaOjq+Y4iUW4nDg3LNdR7kKJ6mpCai1TDrB3pdyk6JPFsNgTbYDNduLKOCujsIKQofS
         zWlQuzDAf+UxvXCiLi1vopeSycvK/qrG+RfJ0qfuCt3gC93kKyp9cn87xbmAtiZVMDXK
         l3UIBL5Oat9cCSyy6ppGsZJ2rVZbXv2wQgZcfJT6S/bZZ9G6kES7iq8/xCAWai7DT9ly
         XctQ==
X-Gm-Message-State: APjAAAXCpEOS2Y14vDCeP7GskScbrQCDKchuZRJFMXmEmcR3qbXXZbWh
        HSfALWzvo49wTzQXYd3BxD8T8k5vNIU=
X-Google-Smtp-Source: APXvYqyqnrnZguhYeaX4a/yjX7ErA+ZijtnbMVZ9qISQ66yq9QpzSmMhAXwK0HGS5cV1tWSaO4WBgA==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr16192086plf.329.1570210904614;
        Fri, 04 Oct 2019 10:41:44 -0700 (PDT)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id p17sm7389126pfn.50.2019.10.04.10.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:41:44 -0700 (PDT)
Subject: Re: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI
 domains
To:     Johannes Berg <johannes@sipsolutions.net>,
        Aaron Komisar <aaron.komisar@tandemg.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <02f58201-4b92-0a1e-d237-6838543a3513@eero.com>
 <1570090415-28671-1-git-send-email-aaron.komisar@tandemg.com>
 <164db03648d82e0bdf962d18508322ac71f1b66d.camel@sipsolutions.net>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <1245442d-bbf2-aa5a-bd87-17a317b5ed34@eero.com>
Date:   Fri, 4 Oct 2019 10:41:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <164db03648d82e0bdf962d18508322ac71f1b66d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/4/19 5:15 AM, Johannes Berg wrote:
> On Thu, 2019-10-03 at 08:13 +0000, Aaron Komisar wrote:
>
>>> The real reason of scan failure is because mac80211 checks if it's DFS
>>> channel, but it doesn't check if CAC is done or not.
>> The problem is that scan request is blocked in ETSI reg domains. In non-ETSI
>> reg domains the behavior is fine.
>>
>> cfg80211 blocks scan in non-ETSI reg domains and allows leaving the channel
>> in ETSI reg domains. I think that if we add a function in mac80211, which
>> checks if we can leave the operating channel this function should also take
>> into account the reg domain for completeness.
>>> So to solve the issue, the right approach should be "check if DFS
>>> channels and check if CAC is done".
>> We can't scan while CAC is in progress but why must we verify that CAC was done
>> in order to perform a scan operation?
> I agree that'd be weird - if CAC wasn't done we shouldn't be operating
> on that channel to start with?

Sorry to make you guys confused. I was thinking about something else.

So ignore my comment in previous email.


Thanks,

Peter

