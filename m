Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06D711D534
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfLLSVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 13:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfLLSVk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 13:21:40 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BBED21556;
        Thu, 12 Dec 2019 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576174899;
        bh=i+dcJM/f6xnhJQ9i63A4Z9F3vQYpJTHOxEAe+lR+QTw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MofbQa+M16OKmySZ0fjGFEYYV9jhtP606xxBU8XZeCthREeFJ2ZFvZndPaRMTZ0yS
         Y7sL09uwIBUFXKNHGQRUIn+ga11ipL6aiwAEjGK+PNCdbl91we4M7SGVgBTUv/6jvN
         1iQloQW7HnVbigA/nfHwLT859Bgb0JBmoapSrp7Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05C5B3522757; Thu, 12 Dec 2019 10:21:39 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:21:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
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
Message-ID: <20191212182139.GA2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
 <20191210040741.2943-1-paulmck@kernel.org>
 <yq1a77zmt4a.fsf@oracle.com>
 <20191211035122.GC2889@paulmck-ThinkPad-P72>
 <20191211183738.GA5190@paulmck-ThinkPad-P72>
 <1911b7fa-c8d4-e34b-020d-3346a56f29d6@gmail.com>
 <20191211231239.GK2889@paulmck-ThinkPad-P72>
 <87mubxdh52.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mubxdh52.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 12, 2019 at 11:31:37AM +0200, Kalle Valo wrote:
> + linux-wireless
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Wed, Dec 11, 2019 at 08:09:11PM +0100, Matthias Brugger wrote:
> >> On 11/12/2019 19:37, Paul E. McKenney wrote:
> >>
> >> > --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> >> > @@ -281,8 +281,8 @@ void mt76_rx_aggr_stop(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno)
> >> >  {
> >> >  	struct mt76_rx_tid *tid = NULL;
> >> >  
> >> > -	rcu_swap_protected(wcid->aggr[tidno], tid,
> >> > -			   lockdep_is_held(&dev->mutex));
> >> > +	tid = rcu_swap_protected(wcid->aggr[tidno], tid,
> >> > +				 lockdep_is_held(&dev->mutex));
> >> 
> >> I suppose you meant: rcu_replace_pointer() here.
> >
> > Indeed I did, and thank you for catching this!  Bad patch day here.  :-/
> >
> > Update below...
> >
> > 							Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit ad5572b091429a45e863acaa6a36cf396d44f58d
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Dec 11 10:30:21 2019 -0800
> >
> >     wireless/mediatek: Replace rcu_swap_protected() with rcu_replace_pointer()
> >     
> >     This commit replaces the use of rcu_swap_protected() with the more
> >     intuitively appealing rcu_replace_pointer() as a step towards removing
> >     rcu_swap_protected().
> >     
> >     Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> >     Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >     Reported-by: "Martin K. Petersen" <martin.petersen@oracle.com>
> >     [ paulmck: Apply Matthias Brugger feedback. ]
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Reviewed-by: "Martin K. Petersen" <martin.petersen@oracle.com>
> >     Cc: Felix Fietkau <nbd@nbd.name>
> >     Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> >     Cc: Ryder Lee <ryder.lee@mediatek.com>
> >     Cc: Roy Luo <royluo@google.com>
> >     Cc: Kalle Valo <kvalo@codeaurora.org>
> >     Cc: "David S. Miller" <davem@davemloft.net>
> >     Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >     Cc: <linux-wireless@vger.kernel.org>
> >     Cc: <netdev@vger.kernel.org>
> >     Cc: <linux-arm-kernel@lists.infradead.org>
> >     Cc: <linux-mediatek@lists.infradead.org>
> 
> Via which tree is this supposed to go? If I should take this please
> resend to linux-wireless so that patchwork sees it, but if someone else
> is planning to take this:
> 
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

I have queued it just preceding the commit that remove rcu_swap_protected()
with your ack, thank you!

							Thanx, Paul
