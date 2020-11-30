Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928392C81D4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgK3KKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 05:10:40 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:39158 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgK3KKk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606731016; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=f8diyhYWMT8oV24q8V9jTUA4JjCXjEO832RX6yX0Se4=;
 b=MsJCt3JyX1E7wGU/idkfkKw/roGXKWVLVJeqwLKBDbMHTyoZm89lrVeWb5fGT+ypqJhrA/dW
 hfJbaUaXvQmBYBu2w9GX8p1bOlDvEDmkyxASXj29Y1ukEOxfNgw4ulPe7MtXk2kTIG+e3lQg
 ZviVawJXAV5ahqjAX5QpSkTCP/c=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fc4c502a5a29b56a1260893 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Nov 2020 10:10:10
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6E3FC43461; Mon, 30 Nov 2020 10:10:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 332EDC433ED;
        Mon, 30 Nov 2020 10:10:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 18:10:10 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>
Subject: Re: [PATCH v2 1/3] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CA+ASDXMRPRPD0XFJeHTRv3Bc13VFehkyDoYHQfaA0cP-STDOLg@mail.gmail.com>
References: <20201120085312.4355-1-cjhuang@codeaurora.org>
 <20201120085312.4355-2-cjhuang@codeaurora.org>
 <CA+ASDXMRPRPD0XFJeHTRv3Bc13VFehkyDoYHQfaA0cP-STDOLg@mail.gmail.com>
Message-ID: <8f0121e9996bad2266a928279e7eb26a@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-21 10:42, Brian Norris wrote:
> On Fri, Nov 20, 2020 at 12:53 AM Carl Huang <cjhuang@codeaurora.org> 
> wrote:
>> 
>> NL80211_CMD_SET_SAR_SPECS is added to configure SAR from
>> user space. NL80211_ATTR_SAR_SPEC is used to pass the SAR
>> power specification when used with NL80211_CMD_SET_SAR_SPECS.
>> 
>> Wireless driver needs to register SAR type, supported frequency
>> ranges to wiphy, so user space can query it. The index in
>> frequency range is used to specify which sub band the power
>> limitation applies to. The SAR type is for compatibility, so later
>> other SAR mechanism can be implemented without breaking the user
>> space SAR applications.
>> 
>> Normal process is user space quries the SAR capability, and
>> gets the index of supported frequency ranges and associates the
>> power limitation with this index and sends to kernel.
>> 
>> Here is an example of message send to kernel:
>> 8c 00 00 00 08 00 01 00 00 00 00 00 38 00 2b 81
>> 08 00 01 00 00 00 00 00 2c 00 02 80 14 00 00 80
>> 08 00 02 00 00 00 00 00 08 00 01 00 38 00 00 00
>> 14 00 01 80 08 00 02 00 01 00 00 00 08 00 01 00
>> 48 00 00 00
>> 
>> NL80211_CMD_SET_SAR_SPECS:  0x8c
>> NL80211_ATTR_WIPHY:     0x01(phy idx is 0)
>> NL80211_ATTR_SAR_SPEC:  0x812b (NLA_NESTED)
>> NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
>> NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
>> freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
>> freq range 1 power: 0x48 in 0.25dbm unit (18dbm)
>> 
>> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> 
> I think the API is reasonably clear and usable. I'm a little skeptical
> that the complexity related to indexes is absolutely necessary [1],
> but at least you make clear what should happen in the case of missing
> indexes (treated as "max"). But you've addressed my concerns, I think:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> I haven't done the most thorough review on the implementation pieces
> (and ath10k), but I at least wanted to put my thoughts out there.
> 
> Thanks,
> Brian
> 
> [1] By the way, you aren't checking for duplicates; so users could
> pass the same index many times, and it's not clear from the API
> definition what should happen. It seems the current implementation is
> that you'll just use the last value provided.
Thanks for the comments.
It's right the last value is used.
I can describe it more clearly if V3 is needed.
