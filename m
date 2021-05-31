Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2863964D8
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhEaQN1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 12:13:27 -0400
Received: from mail.toke.dk ([45.145.95.4]:33253 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhEaQLY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 12:11:24 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2021 12:11:24 EDT
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1622477017; bh=jBXXI+hqJm1OCKP9ZN8J4oYczmBEmHUYjRvE/es4jZg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y1LGcLCYr1ughxjdeSTv7jwjHj995EySBcLa4Hda+gNqaP6VAXDITqd7q/r9xv/MC
         5Y9itvoKp342SJqgr1V9JIjyZ1xC6Mz3CDpLRP9e8i4PNGZJdak/u0X6U5Imcwiv1q
         BBrHYn2CYYlx7GSAEb78T1SJGxp3LF7LhX+XSB3OcV3UhQ+pfdIpOc55b4h6RwspHD
         zgWu1zWmmlT35A4hWg2NOtbDINrI5NAuDiM8oPL53vN6NWj7X1tVfqh0J2Vzs+MFV1
         748a1mwIRYSWwRxZDU90Fc8URgn9ZmuFN1lE+JPM2XasKwv6W33loWAnjiBQVYrn8b
         KBYAT7yBk3TKw==
To:     Tong Zhu <zhutong@amazon.com>, linux-wireless@vger.kernel.org,
        kvalo@qca.qualcomm.com, nbd@nbd.name
Cc:     zhutong@amazon.com
Subject: Re: ath9k: possible bug with AR93xx during background scanning
In-Reply-To: <20210518231612.GA29178@ucf43ac461c9a53.ant.amazon.com>
References: <20210518231612.GA29178@ucf43ac461c9a53.ant.amazon.com>
Date:   Mon, 31 May 2021 18:03:36 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r1hmdh5z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tong Zhu <zhutong@amazon.com> writes:

> Hello
>
> After moving to kernel 4.14 from 4.1, our station with an AR93xx pcie card began
> to see packet loss during background scanning. After inspecting the changes, I
> realized ath9k no longer pushes to stop traffic at VIF for off-channel scan after
> this change.
>
> 50f08edf98096a68f01ff4566b605a25bf8e42ce ath9k: Switch to using mac80211 intermediate software queues.
>
> Here is a snippet of a ftrace function sequence during a scan.
>
>     kworker/u4:0-28892 [001] .n.....  3082.957750: ieee80211_offchannel_stop_vifs <-ieee80211_scan_work
>   XX-XXXXXXXXXXd-489   [001] .....12  3082.971105: __ieee80211_subif_start_xmit <-ieee80211_subif_start_xmit
>   XX-XXXXXXXXXXd-489   [001] .....14  3082.971128: ath_tx_txqaddbuf <-ath_txq_schedule
>    irq/175-ath9k-189   [001] .....15  3082.998888: ath_tx_process_buffer <-ath_tx_edma_tasklet
>    irq/175-ath9k-189   [001] .....16  3082.998898: ath_tx_txqaddbuf <-ath_txq_schedule
>    irq/175-ath9k-189   [000] .....15  3083.011497: ath_tx_process_buffer <-ath_tx_edma_tasklet
>    irq/175-ath9k-189   [000] .....16  3083.011504: ath_tx_txqaddbuf <-ath_txq_schedule
>    irq/175-ath9k-189   [001] .....15  3083.022261: ath_tx_process_buffer <-ath_tx_edma_tasklet
>    irq/175-ath9k-189   [001] .....16  3083.022268: ath_tx_txqaddbuf <-ath_txq_schedule
>    irq/175-ath9k-189   [000] .....15  3083.034131: ath_tx_process_buffer <-ath_tx_edma_tasklet
>    irq/175-ath9k-189   [000] .....15  3083.034134: ath_tx_complete_buf <-ath_tx_process_buffer
>    irq/175-ath9k-189   [000] .....15  3083.034136: ath_tx_complete <-ath_tx_complete_buf
>     kworker/u4:0-28892 [001] .......  3083.083246: ieee80211_offchannel_return <-ieee80211_scan_work
>
> Between timestamp 3082.957750 and 3083.083246, the device went off channel. A packet
> came down and reached hardware queue. Hardware TX processing continued. It is a
> serious issue if PDUs are indeed sent out during off-channel.

I believe this was fixed by this commit:
21a5d4c3a45c ("mac80211: add stop/start logic for software TXQs")

which first appeared in kernel 4.20. It doesn't appear to have been
backported to 4.14, so I suppose it makes sense if you're seeing queues
not getting stopped on that kernel...

-Toke
