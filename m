Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC17D4A0EE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFRMgl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 08:36:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49952 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRMgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 08:36:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A85EA607C3; Tue, 18 Jun 2019 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560861399;
        bh=NAtodRoBeIbNy6jPxMqoBYKdd20Vl3FfelqW9RWdgC8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ilcyqi0SVUhWPsTrjuA41j1vM5dvjJ5TUN6b/aCr6i1OhglKff4cG2Kqf93eoqSIi
         YBbI44dP3IRxGpGGMEN43y31ScXcSHvF3taKmYpCehB9o1kdl9E1+flJDYgRqhXk4E
         O07iQxGUn94DLMkUzx6ZmlKsYtkZf0krKFac8EV8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 842F4602A7;
        Tue, 18 Jun 2019 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560861399;
        bh=NAtodRoBeIbNy6jPxMqoBYKdd20Vl3FfelqW9RWdgC8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ilcyqi0SVUhWPsTrjuA41j1vM5dvjJ5TUN6b/aCr6i1OhglKff4cG2Kqf93eoqSIi
         YBbI44dP3IRxGpGGMEN43y31ScXcSHvF3taKmYpCehB9o1kdl9E1+flJDYgRqhXk4E
         O07iQxGUn94DLMkUzx6ZmlKsYtkZf0krKFac8EV8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 842F4602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: fix sparse warnings: warning: dubious: x & !y
References: <d8a003eda05150fb21842d7755fe8081b86cf6df.1560851052.git.lorenzo@kernel.org>
        <87imt3t7t1.fsf@purkki.adurom.net>
        <20190618121641.GA20044@localhost.localdomain>
Date:   Tue, 18 Jun 2019 15:36:36 +0300
In-Reply-To: <20190618121641.GA20044@localhost.localdomain> (Lorenzo
        Bianconi's message of "Tue, 18 Jun 2019 14:16:42 +0200")
Message-ID: <871rzr9ijv.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(I think you accidentally dropped linux-wireless, adding it back)

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Fix following sparse warnings in mt7603/mac.c and mt76x02_mac.c
>> >
>> > drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:113:17: warning: dubious: x & !y
>> > drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:145:16: warning: dubious: x & !y
>> > drivers/net/wireless/mediatek/mt76/mt7603/mac.c:730:9: warning: dubious: x & !y
>> > drivers/net/wireless/mediatek/mt76/mt7603/mac.c:790:15: warning: dubious: x & !y
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 6 ++++--
>> >  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 7 +++++--
>> >  2 files changed, 9 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
>> > index ab5141701997..62e0a7f4716a 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
>> > @@ -709,6 +709,7 @@ int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
>> >  {
>> >  	enum mt7603_cipher_type cipher;
>> >  	u32 addr = mt7603_wtbl3_addr(wcid);
>> > +	bool key_set = !!key;
>> >  	u8 key_data[32];
>> >  	int key_len = sizeof(key_data);
>> >  
>> > @@ -727,7 +728,7 @@ int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
>> >  	mt76_rmw_field(dev, addr + 2 * 4, MT_WTBL1_W2_KEY_TYPE, cipher);
>> >  	if (key)
>> >  		mt76_rmw_field(dev, addr, MT_WTBL1_W0_KEY_IDX, key->keyidx);
>> > -	mt76_rmw_field(dev, addr, MT_WTBL1_W0_RX_KEY_VALID, !!key);
>> > +	mt76_rmw_field(dev, addr, MT_WTBL1_W0_RX_KEY_VALID, key_set);
>> 
>> I'm not seeing you really _fixing_ anything here, you are just working
>> around a sparse warning by adding an extra variable. I'm having a hard
>> time to see the benefit from that, it's just an unnecessary variable.
>
> Hi Kalle,
>
> right, they are just false positive, I posted this patch since they are
> annoying and sometimes sparse spots real bugs so I think it would be better to
> remove 'noise' sources.

Sure, sparse is very useful. I run it for every ath10k and ath11k patch
and it has found a lot of valid issues.

> Anyway we can drop this patch, I did not come up with a better
> solution :)

I was lazy and I added a filter to my ath11k-check to skip this warning.
It would be nice report this to sparse developers, as we already have
two drivers suffering of the same problem.

-- 
Kalle Valo
