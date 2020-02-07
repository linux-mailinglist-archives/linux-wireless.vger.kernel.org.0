Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81A155D35
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGRzj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 12:55:39 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:58900 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGRzj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 12:55:39 -0500
Received: from [10.0.0.63] (unknown [118.127.122.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D6DA5137584;
        Fri,  7 Feb 2020 09:55:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D6DA5137584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1581098138;
        bh=q/qo+ngcEhYyy9KNlTdgjqz89hXR04YUHcN5OuoRKq4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=R6qUYw1+0YYG6VVkz9Hm7GfZJ1F5Q95O/KHawwPPRpDvvbhojtW3cQUMvU14/AYey
         zK1Ksu4PhFVzaDE1R1jAo9kuRN1ggErOjXLDlPXOHFO6BfcmetxJvJJqH3grOhksfu
         nh21fmDlcDixNvwK5Z5gNkuHri54m5m3qHNdHvr4=
Message-ID: <5E3DA498.20505@candelatech.com>
Date:   Fri, 07 Feb 2020 09:55:36 -0800
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mac80211: Fix setting txpower to zero.
References: <20191217183057.24586-1-greearb@candelatech.com>         (sfid-20191217_193103_026347_235EB2CE) <27b64bd26e7d8c13d22a3a9b950eb3db16b630a2.camel@sipsolutions.net>
In-Reply-To: <27b64bd26e7d8c13d22a3a9b950eb3db16b630a2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02/07/2020 04:03 AM, Johannes Berg wrote:
> On Tue, 2019-12-17 at 10:30 -0800, greearb@candelatech.com wrote:
>>
>>   drivers/net/wireless/ath/ath10k/mac.c | 3 ++-
>>   drivers/net/wireless/ath/ath9k/main.c | 3 +++
>>   drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
>
> All these driver changes worry me a bit - wouldn't that affect other
> drivers as well?
>
> johannes
>

The goal was to NOT adversely affect the drivers when the default (not-set)
value changed.

I changed the name of the variable and then touched every driver that used it
as a way of making sure that I found everything in the tree.

Hopefully that found everything...  I did not specifically test ath9k, only ath10k
driver with this change.

(I then changed the variable name back before submitting the patch).

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

