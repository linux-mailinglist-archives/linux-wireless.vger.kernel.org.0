Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4F11C92F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfLLJbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 04:31:51 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:41288
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbfLLJbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 04:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576143110;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=ouHOZDTa38m5jgpyZx3jdMkeE7fUnBl8O7DVe4NkPvE=;
        b=orVCi63Vpb1W5B9pveeaKRneucbmsxYWUWkWss7t4zCuPzY7kOzZYGZWNR8xDtpN
        XW1HyMoDFVljKG+lwfoO04QxbOSn5tPYjGalAgoKXmJz1tapQ64Ns6Heobjzc86pIys
        sKAKJPoybvJg96BQsLP8UMmUrTb+fFDHWo5OQ+q0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576143110;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=ouHOZDTa38m5jgpyZx3jdMkeE7fUnBl8O7DVe4NkPvE=;
        b=EkhBYcXbw3n7Oo1ti/zaKHchNxNq0iWu14baaS1ReddjBmH5IXnCScucy43YVjjZ
        CNXzKvMQzSr38r4OO7wU5N+PohWfuLInB19LFpve+gtcdGOnFdM44+pqUK1NvWcH56c
        YR6xjL8SZ7fGnIqQDfixbvh8wVW5QwVX1M8EqN4I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7A08C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH tip/core/rcu 01/12] rcu: Remove rcu_swap_protected()
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
        <20191210040741.2943-1-paulmck@kernel.org>
        <yq1a77zmt4a.fsf@oracle.com>
        <20191211035122.GC2889@paulmck-ThinkPad-P72>
        <20191211183738.GA5190@paulmck-ThinkPad-P72>
        <1911b7fa-c8d4-e34b-020d-3346a56f29d6@gmail.com>
        <20191211231239.GK2889@paulmck-ThinkPad-P72>
Date:   Thu, 12 Dec 2019 09:31:50 +0000
In-Reply-To: <20191211231239.GK2889@paulmck-ThinkPad-P72> (Paul E. McKenney's
        message of "Wed, 11 Dec 2019 15:12:39 -0800")
Message-ID: <0101016ef9734051-f84be83c-272b-4fc7-9cbd-f2c18eebd00f-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.12-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Dec 11, 2019 at 08:09:11PM +0100, Matthias Brugger wrote:
>> On 11/12/2019 19:37, Paul E. McKenney wrote:
>>
>> > --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
>> > @@ -281,8 +281,8 @@ void mt76_rx_aggr_stop(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno)
>> >  {
>> >  	struct mt76_rx_tid *tid = NULL;
>> >  
>> > -	rcu_swap_protected(wcid->aggr[tidno], tid,
>> > -			   lockdep_is_held(&dev->mutex));
>> > +	tid = rcu_swap_protected(wcid->aggr[tidno], tid,
>> > +				 lockdep_is_held(&dev->mutex));
>> 
>> I suppose you meant: rcu_replace_pointer() here.
>
> Indeed I did, and thank you for catching this!  Bad patch day here.  :-/
>
> Update below...
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit ad5572b091429a45e863acaa6a36cf396d44f58d
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Dec 11 10:30:21 2019 -0800
>
>     wireless/mediatek: Replace rcu_swap_protected() with rcu_replace_pointer()
>     
>     This commit replaces the use of rcu_swap_protected() with the more
>     intuitively appealing rcu_replace_pointer() as a step towards removing
>     rcu_swap_protected().
>     
>     Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
>     Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>     Reported-by: "Martin K. Petersen" <martin.petersen@oracle.com>
>     [ paulmck: Apply Matthias Brugger feedback. ]
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Reviewed-by: "Martin K. Petersen" <martin.petersen@oracle.com>
>     Cc: Felix Fietkau <nbd@nbd.name>
>     Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
>     Cc: Ryder Lee <ryder.lee@mediatek.com>
>     Cc: Roy Luo <royluo@google.com>
>     Cc: Kalle Valo <kvalo@codeaurora.org>
>     Cc: "David S. Miller" <davem@davemloft.net>
>     Cc: Matthias Brugger <matthias.bgg@gmail.com>
>     Cc: <linux-wireless@vger.kernel.org>
>     Cc: <netdev@vger.kernel.org>
>     Cc: <linux-arm-kernel@lists.infradead.org>
>     Cc: <linux-mediatek@lists.infradead.org>

Via which tree is this supposed to go? If I should take this please
resend to linux-wireless so that patchwork sees it, but if someone else
is planning to take this:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
