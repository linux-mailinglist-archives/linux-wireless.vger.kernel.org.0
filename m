Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8751B397A66
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 21:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhFATG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 15:06:26 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21290 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 15:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1622574284; x=1654110284;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=wkZbi27AtrRxZMDmQ97Xu0SEXvYaRjua8e3iPd1u7cM=;
  b=ksQ9zKTGU/SUkWN5s619xsiwGtaVZKqBFP5RF8EKDLGh/w0zSvAxXKAD
   ZKyhGU73NxOdg9so7AKepSw3AunBmUJMcNctrVWwmzjeKIh3B79MWLdjo
   JVf052AXfQdM5W1k0RBZrsXb7DWm8TOagXDz2pj1hYpQlgMkaoK2RhsFB
   U=;
X-IronPort-AV: E=Sophos;i="5.83,240,1616457600"; 
   d="scan'208";a="112986220"
Subject: Re: ath9k: possible bug with AR93xx during background scanning
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 01 Jun 2021 19:04:44 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 600E0240B76;
        Tue,  1 Jun 2021 19:04:43 +0000 (UTC)
Received: from EX13D06UEA002.ant.amazon.com (10.43.61.198) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.200) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 1 Jun 2021 19:04:42 +0000
Received: from ucf43ac461c9a53.ant.amazon.com (10.43.162.93) by
 EX13D06UEA002.ant.amazon.com (10.43.61.198) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 1 Jun 2021 19:04:41 +0000
Date:   Tue, 1 Jun 2021 15:04:38 -0400
From:   Tong Zhu <zhutong@amazon.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        <linux-wireless@vger.kernel.org>
CC:     <zhutong@amazon.com>
Message-ID: <20210601190437.GA16991@ucf43ac461c9a53.ant.amazon.com>
References: <20210518231612.GA29178@ucf43ac461c9a53.ant.amazon.com>
 <87r1hmdh5z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1hmdh5z.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.43.162.93]
X-ClientProxiedBy: EX13D12UWC001.ant.amazon.com (10.43.162.78) To
 EX13D06UEA002.ant.amazon.com (10.43.61.198)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes, this commit would fix it. I am glad the community has taken care of this.

Thanks you.
-Tong

On Mon, May 31, 2021 at 06:03:36PM +0200, Toke Høiland-Jørgensen wrote:
> 
> 
> Tong Zhu <zhutong@amazon.com> writes:
> 
> > Hello
> >
> > After moving to kernel 4.14 from 4.1, our station with an AR93xx pcie card began
> > to see packet loss during background scanning. After inspecting the changes, I
> > realized ath9k no longer pushes to stop traffic at VIF for off-channel scan after
> > this change.
> >
> > 50f08edf98096a68f01ff4566b605a25bf8e42ce ath9k: Switch to using mac80211 intermediate software queues.
> >
> > Here is a snippet of a ftrace function sequence during a scan.
> >
> >     kworker/u4:0-28892 [001] .n.....  3082.957750: ieee80211_offchannel_stop_vifs <-ieee80211_scan_work
> >   XX-XXXXXXXXXXd-489   [001] .....12  3082.971105: __ieee80211_subif_start_xmit <-ieee80211_subif_start_xmit
> >   XX-XXXXXXXXXXd-489   [001] .....14  3082.971128: ath_tx_txqaddbuf <-ath_txq_schedule
> >    irq/175-ath9k-189   [001] .....15  3082.998888: ath_tx_process_buffer <-ath_tx_edma_tasklet
> >    irq/175-ath9k-189   [001] .....16  3082.998898: ath_tx_txqaddbuf <-ath_txq_schedule
> >    irq/175-ath9k-189   [000] .....15  3083.011497: ath_tx_process_buffer <-ath_tx_edma_tasklet
> >    irq/175-ath9k-189   [000] .....16  3083.011504: ath_tx_txqaddbuf <-ath_txq_schedule
> >    irq/175-ath9k-189   [001] .....15  3083.022261: ath_tx_process_buffer <-ath_tx_edma_tasklet
> >    irq/175-ath9k-189   [001] .....16  3083.022268: ath_tx_txqaddbuf <-ath_txq_schedule
> >    irq/175-ath9k-189   [000] .....15  3083.034131: ath_tx_process_buffer <-ath_tx_edma_tasklet
> >    irq/175-ath9k-189   [000] .....15  3083.034134: ath_tx_complete_buf <-ath_tx_process_buffer
> >    irq/175-ath9k-189   [000] .....15  3083.034136: ath_tx_complete <-ath_tx_complete_buf
> >     kworker/u4:0-28892 [001] .......  3083.083246: ieee80211_offchannel_return <-ieee80211_scan_work
> >
> > Between timestamp 3082.957750 and 3083.083246, the device went off channel. A packet
> > came down and reached hardware queue. Hardware TX processing continued. It is a
> > serious issue if PDUs are indeed sent out during off-channel.
> 
> I believe this was fixed by this commit:
> 21a5d4c3a45c ("mac80211: add stop/start logic for software TXQs")
> 
> which first appeared in kernel 4.20. It doesn't appear to have been
> backported to 4.14, so I suppose it makes sense if you're seeing queues
> not getting stopped on that kernel...
> 
> -Toke
