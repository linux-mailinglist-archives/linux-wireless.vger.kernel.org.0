Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CEDB74B4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfISIEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 04:04:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfISIEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 04:04:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 701356141C; Thu, 19 Sep 2019 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568880250;
        bh=v81AAN/4fGy4vxfKKmCU4QkX73pgYLMSvEz9benzOec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GjsaAo/vnYpu67vXZoW77i33KBqwcyq3HSk6gu6WYwVr4oNfzP9IW6EVfCT/11Q5e
         blCQYV7PgqyXl9f6hiTpQ0u+1REyxEq2ov/SywUhn2Zgr7/UTQAfzrXDNXmiQTuyoI
         qiGCWKiGN9dnI5od1e5EuSrO0HnZvQ5SrRMFmboI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F07CF6016D;
        Thu, 19 Sep 2019 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568880247;
        bh=v81AAN/4fGy4vxfKKmCU4QkX73pgYLMSvEz9benzOec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WcPDO8eOlP+saWLywmJGjJGIAjLPPDuiZ/RKWjEvAxiDUqw9FZqQWckXcfMfzDPWU
         hHwIfj0v7B0Br1GZn1/RxcWc8Mx/ba8OhlSpotm8lym0SBqJ396jUDikYrKikIQaRR
         lPbzvhO9EIyETnqIuGybNW9k38e/b6FuVqC0hero=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Sep 2019 13:34:06 +0530
From:   Balaji Pothunoori <bpothuno@codeaurora.org>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, johannes@sipsolutions.net,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 3/3] ath10k: add support for controlling tx power to a
 station
In-Reply-To: <20190919002100.GA28186@localhost>
References: <1553856587-21611-1-git-send-email-bpothuno@codeaurora.org>
 <20190402223709.GB8910@localhost> <871rwdbu1p.fsf@kamboji.qca.qualcomm.com>
 <20190919002100.GA28186@localhost>
Message-ID: <7fbdeb414ce3b03c57fb6fa86cdf8dc5@codeaurora.org>
X-Sender: bpothuno@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-19 05:51, Bob Copeland wrote:
> On Wed, Sep 18, 2019 at 04:41:54PM +0300, Kalle Valo wrote:
>> Bob Copeland <me@bobcopeland.com> writes:
>> > - on A, changed the global tx power limit to 1 dBm
>> >   -> result: signal level dropped to ~ -95 dBm
>> >
>> > Reading the description above, now I'm wondering if the txpower is
>> > max(sta-power,global-power)?  If so, that seems a bit unintuitive to me,
>> > or at least isn't what I hoped for.  I'd prefer to have per-sta power
>> > setting override the global power.
>> 
>> Balaji, please reply to Bob's questions. I missed this thread while
>> applying v5, sorry Bob.
> 
> Just to follow-up, I ran more experiments since writing the above
> email and it didn't look like it was doing max() either -- at least
> on my hardware/firmware combo it had no effect at all that I could 
> tell.
> 

For QCA9984 allowed tx power range values from 6 to 23,
Same info mentioned in : https://patchwork.kernel.org/patch/10968517/

> I did verify that the wmi update went through to the firmware.
> 
> I can't remember now, but I may have been testing mesh mode in case
> that makes a difference.

We gave fix for tx power configuration in firmware 10.4-3.9.0.2-00046 .

Can you try with that ?


Regards,
Balaji.
