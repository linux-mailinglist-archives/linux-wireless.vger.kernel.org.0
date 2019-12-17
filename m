Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C28122FC3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 16:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLQPJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 10:09:10 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:57356 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQPJJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 10:09:09 -0500
Received: from [192.168.1.47] (unknown [50.34.171.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7DF3013C2B8;
        Tue, 17 Dec 2019 07:09:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7DF3013C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576595345;
        bh=x0Ce8VbMivkZjR5QKnOUlMinCHJEP48+vJkv8E2aJjY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=mzbiuZ7G8uBvBqHKz05q+kStNUtyr+wjyXLG4AaOh0xgz95PqqdWrz/5HyBRrwUn0
         NsPx4APp8A4V/kaIymj7TlzuNeTBExw1zeF+SkyS9YcYxFCcM8hrwLdWn/1wuj1ozI
         ta3qHFIBLggqfU+MO4UgGEkSO6o+W8+pem4CfyGk=
Subject: Re: [RFC] mac80211: Fix setting txpower to zero.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20191213230334.27631-1-greearb@candelatech.com>
 <9ff2afcfb6590e92d8e73656e657414ec2c71b3d.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <d54cc6e5-45b5-5c15-47e2-6bec8aad73aa@candelatech.com>
Date:   Tue, 17 Dec 2019 07:09:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <9ff2afcfb6590e92d8e73656e657414ec2c71b3d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 12/16/2019 11:57 PM, Johannes Berg wrote:
> On Fri, 2019-12-13 at 15:03 -0800, greearb@candelatech.com wrote:
>>
>> So, instead initialize the txpower to -1 in mac80211, and let drivers know that
>> means the power has not been set and so should be ignored.
>
> Technically (or maybe just physically?), even -1 is a sort of valid TX
> power.
>
> I know all of this is pretty messed up, but wouldn't it make more sense
> to go with some kind of tx_power_valid bit, or perhaps something that
> certainly will never make sense like MIN_INT instead of -1?

I'm fine with using MIN_INT instead of -1 as the 'not-set' special value.

Certainly -1 dbm txpower can be legit, though not on the chipsets I am familiar
with as far as I can tell.

I'll redo the patch with MIN_INT later today.  I think that will be a lot less
change than adding a new flag that needs to be propagated to the drivers and stored
by drivers and such.

Thanks,
Ben

>
> johannes
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
