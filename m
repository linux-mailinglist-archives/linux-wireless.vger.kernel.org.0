Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D22DE94B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgLRSvO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 13:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLRSvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 13:51:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B0C06138C;
        Fri, 18 Dec 2020 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nJyO2qR4GdRxx3I4G9kHv+IahinLZjL5hGQ7wDVeL1E=; b=W0PoEzI4cR3akjxSb/z2Jy82xk
        GaItgrEdvZXIteqnsU4Qlygp8B5eY30vYh1WsHvPRfX/uC+SAH9n9dKzVn2vZH7/zEInyO3M9sMXx
        aluaBedSqLTupYwUm/cB3KJ4wykLiK0xz/Bee7ytmdQNskKRC1IDQlVc3bbitHrTy/uEV6hT+1lA/
        jznmxv/MjWOFlTG4jVIwYzeJ5lsGBBoxMrrD4ioVV1tcpJgXmmivqiLJ2A60jtHGu4MXIv/ZEWpHD
        rPBSWFSx1+CT1JGVRGnQIQsTrrRoBOpsfW7Z56bHhU/qmZFw5nwdnl6Zjo62CDzn+bUpgQqCWDA8Y
        CYRTq/6A==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqKph-00051z-SE; Fri, 18 Dec 2020 18:50:30 +0000
Subject: Re: [PATCH -next] net: wireless/mediatek/mt7915: fix MESH ifdef block
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20201218173202.23159-1-rdunlap@infradead.org>
 <87eejnrluw.fsf@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <488abe6b-3893-557a-8324-1be9b75657ce@infradead.org>
Date:   Fri, 18 Dec 2020 10:50:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87eejnrluw.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/18/20 10:48 AM, Kalle Valo wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Fix a build error when CONFIG_MAC80211_MESH is not enabled:
>>
>> ../drivers/net/wireless/mediatek/mt76/mt7915/init.c:47:2: error: expected expression before '}' token
>>   }, {
>>   ^
>>
>> Fixes: af901eb4ab80 ("mt76: mt7915: get rid of dbdc debugfs knob")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Shayne Chen <shayne.chen@mediatek.com>
>> Cc: Ryder Lee <ryder.lee@mediatek.com>
>> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
>> Cc: Felix Fietkau <nbd@nbd.name>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: Kalle Valo <kvalo@codeaurora.org>
> 
> Thanks, but why -next? I would rather queue this to wireless-drivers for
> v5.11 as af901eb4ab80 is in Linu's tree now.
> 

Sorry, I found the build error in linux-next.
My bad for not checking mainline.

Shall I resend it?

thanks.
-- 
~Randy

