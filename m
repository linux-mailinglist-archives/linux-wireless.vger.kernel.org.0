Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8967949C135
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 03:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiAZCVF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 21:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiAZCVD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 21:21:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF3C06161C
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 18:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=0KbU5keQI76IYVBsTt4J8IrjTDjijrG7TN4X690BajA=; b=snMZYlz8LfglXb5eRjS9Ri53Im
        Zh9kQVKT7bxrAs5tZtgOwT5vJ6TRVhH7BqAI/gGjvXZqMJdITajGZ/DzR7FuiWOTpDMkEh9Tpds1T
        hirK+NHhtyckPs0P9mtEJChCd4q2yd30o8RQ2RolLITg/6MsYpWKsv4eZAvu4E6NQIlV3i2a6LEwz
        BHvHStQPh/oknV83jWE4rcOQ7KGX7zTRgwKpPBf1hrWISkbiqpBcr947ze85gt/Zg00hgmsqIgD2+
        RZFK8zki+IkyrWJgCADCWkDzz+qFvOZfrBiD7db974jSV+bQQELGUx2bdeaZXJSxaDQlKG6PzyyTt
        Jls0pWiQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCXve-003cEA-SY; Wed, 26 Jan 2022 02:20:59 +0000
Message-ID: <0ee64c55-1326-addb-7c9c-c922373f78c0@infradead.org>
Date:   Tue, 25 Jan 2022 18:20:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: iwlwifi problems, maybe firmware related?
Content-Language: en-US
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
References: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
 <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/25/22 15:58, Ben Greear wrote:
> On 1/25/22 3:08 PM, Randy Dunlap wrote:
>> Hi,
>>
>> When I boot 5.16 or 5.17-rc1, I get messages like:
>>
>> iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
>> iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
>> iwlwifi 0000:00:14.3: loaded firmware version 67.8f59b80b.0 QuZ-a0-hr-b0-67.ucode op_mode iwlmvm
> 
> We see nothing but crashes with the version 67 firmware.  Remove that
> from your /lib/firmware/ dir (and make sure version 66 or lower is there),
> and reboot and it should work again.

Well. Yes, that does make things work for me.

It's odd, though, that openSUSE Tumbleweed with kernel "Linux version 5.16.1-1-default"
(whatever that is) also works with no problems.

Thanks for your help.

-- 
~Randy
