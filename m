Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C0360F0B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhDOPch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 11:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhDOPcg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 11:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618500733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMNZy+N4SnjKW7ze0PbyTCq0o4l85QwtWyWHp1WKu5Y=;
        b=TI4S6FmakXZJM0HKV11tQQQEyYwoKysMTL+3Gl5tZEWm8erAqBragDWxl8ABrl6lbss2og
        ZQySgaxesYjSwy+ucG6ld+Ic9LMXid20+qFUuf0MCBfHuAEBYEOufN9eN8aGyxBhKEdVuk
        6ymJP+6nz/+YPOHfonnIg3Kl9IS8Hno=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-lhAjOgG6NEqGKQoMu8U1VQ-1; Thu, 15 Apr 2021 11:32:11 -0400
X-MC-Unique: lhAjOgG6NEqGKQoMu8U1VQ-1
Received: by mail-ed1-f72.google.com with SMTP id s4-20020a0564021644b0290384e9a246a7so1779489edx.7
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 08:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WMNZy+N4SnjKW7ze0PbyTCq0o4l85QwtWyWHp1WKu5Y=;
        b=NY91cyym9Rrmy/J5xTODWtAhYY6ORX4Z4O7Uomf6UBNvspnmJRZ/4MXDsGX1mi7Kok
         H6xjlG+96E7B6gE/XyAMzlh7YZerT/A7oY5dfGLekZgOaXdwtqW2IB3TV5Q8UL15BIdf
         P8d12eD5aEufXpQ4TQs5iyoUaY0julBa6B85KybtgqaSG4mo0j6wIA/dumhi6kQgWGgm
         OUakqm3//Y4w10VBDz75DcVxNnVe9WMm++yd7f/mZNsaz+A0l8qj5+ORlzLQaUCMpbkG
         kUPIVQNHo7iQ8N7EtF8hwCvax3YG+hdek26tkrwaSviQrRRxff8sRVTbAEV+T/Ow0Skj
         kV+Q==
X-Gm-Message-State: AOAM530ZWJQHg8HBh4ndFZkSXEF35k4Dnc2DDmUfekPCLLqD49TzRNkA
        Cr1n/P+wYuQGBOkZYFE+UMyvzsWoecHdxKy+TPMFbg/6dLW4okl778h+eTDQD3qVNdkIfsZuJBa
        MZ+Za99elSxPTUz24yi0GO6z46LI=
X-Received: by 2002:aa7:d599:: with SMTP id r25mr5027263edq.68.1618500730285;
        Thu, 15 Apr 2021 08:32:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSUAWU5/CJYnhZWagxoqxYpglkOJQcTF004Z/uLJw7wbgocrwSw7+6i1uOLikwhnO5XSL1CQ==
X-Received: by 2002:aa7:d599:: with SMTP id r25mr5027248edq.68.1618500730157;
        Thu, 15 Apr 2021 08:32:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f10sm2730955edd.29.2021.04.15.08.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:32:09 -0700 (PDT)
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
To:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luciano.coelho@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Chris Murphy <lists@colorremedies.com>
References: <20210415120447.4424-1-hdegoede@redhat.com>
 <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b679efa9-de92-d9c0-d003-ddb3f737ca32@redhat.com>
Date:   Thu, 15 Apr 2021 17:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 4/15/21 2:21 PM, Johannes Berg wrote:
> On Thu, 2021-04-15 at 14:04 +0200, Hans de Goede wrote:
>> This fixes the same locking problem fixed by commit 2800aadc18a6 ("iwlwifi:
>> Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()") but then for
>> the gen2 variant of enqueue_hcmd().
>>
>> It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs
>> disabled (e.g. from LED core). We can't enable BHs in such a situation.
>>
>> Turn the unconditional BH-enable/BH-disable code into
>> hardirq-disable/conditional-enable.
>>
>> This fixes the warning below.
> 
> I believe Jiri posted the same patch:
> 
> https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/

Ah yes that is the same patch. I did reference Jiri's patch
for fixing the same issue in iwl_pcie_enqueue_hcmd() in the commit
message, without knowing that Jiri had send a later patch which also fixes
this in  iwl_pcie_gen2_enqueue_hcmd().

Going with Jiri's patch is fine then, but it would be nice if we
can get a fix for this in place soon-ish, which I see has
already been discussed further down in this thread :)

Regards,

Hans

