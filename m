Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E9388302
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbhERXRu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 May 2021 19:17:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:9353 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhERXRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 May 2021 19:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1621379791; x=1652915791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vI2qNarsww2krLUYBeuBziqBH5EG5YwsW/JUT2eWBiY=;
  b=WHr1lGiDWQzbeCJp/Av/sPuzKujVUkSjQ5ZcLsR+XriZ1BQLNMwwvduL
   /yAKVhJAKczv2aLsImyNWlB/TkpyMDK5fhpkTW01uyhQchppjYxbdOO7p
   iDoc29xNGf/5BFVsDQIPQOr5Swnc3C3dTfNEgXswWlFCPdePvcD/U3odw
   I=;
X-IronPort-AV: E=Sophos;i="5.82,310,1613433600"; 
   d="scan'208";a="135589990"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 18 May 2021 23:16:31 +0000
Received: from EX13MTAUEE001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id C1708A17C3;
        Tue, 18 May 2021 23:16:30 +0000 (UTC)
Received: from EX13D06UEA002.ant.amazon.com (10.43.61.198) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 18 May 2021 23:16:28 +0000
Received: from ucf43ac461c9a53.ant.amazon.com (10.43.162.200) by
 EX13D06UEA002.ant.amazon.com (10.43.61.198) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 18 May 2021 23:16:27 +0000
Date:   Tue, 18 May 2021 19:16:24 -0400
From:   Tong Zhu <zhutong@amazon.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@qca.qualcomm.com>,
        <toke@toke.dk>, <nbd@nbd.name>
CC:     <zhutong@amazon.com>
Subject: ath9k: possible bug with AR93xx during background scanning
Message-ID: <20210518231612.GA29178@ucf43ac461c9a53.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D46UWB004.ant.amazon.com (10.43.161.204) To
 EX13D06UEA002.ant.amazon.com (10.43.61.198)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello

After moving to kernel 4.14 from 4.1, our station with an AR93xx pcie card began
to see packet loss during background scanning. After inspecting the changes, I
realized ath9k no longer pushes to stop traffic at VIF for off-channel scan after
this change.

50f08edf98096a68f01ff4566b605a25bf8e42ce ath9k: Switch to using mac80211 intermediate software queues.

Here is a snippet of a ftrace function sequence during a scan.

    kworker/u4:0-28892 [001] .n.....  3082.957750: ieee80211_offchannel_stop_vifs <-ieee80211_scan_work
  XX-XXXXXXXXXXd-489   [001] .....12  3082.971105: __ieee80211_subif_start_xmit <-ieee80211_subif_start_xmit
  XX-XXXXXXXXXXd-489   [001] .....14  3082.971128: ath_tx_txqaddbuf <-ath_txq_schedule
   irq/175-ath9k-189   [001] .....15  3082.998888: ath_tx_process_buffer <-ath_tx_edma_tasklet
   irq/175-ath9k-189   [001] .....16  3082.998898: ath_tx_txqaddbuf <-ath_txq_schedule
   irq/175-ath9k-189   [000] .....15  3083.011497: ath_tx_process_buffer <-ath_tx_edma_tasklet
   irq/175-ath9k-189   [000] .....16  3083.011504: ath_tx_txqaddbuf <-ath_txq_schedule
   irq/175-ath9k-189   [001] .....15  3083.022261: ath_tx_process_buffer <-ath_tx_edma_tasklet
   irq/175-ath9k-189   [001] .....16  3083.022268: ath_tx_txqaddbuf <-ath_txq_schedule
   irq/175-ath9k-189   [000] .....15  3083.034131: ath_tx_process_buffer <-ath_tx_edma_tasklet
   irq/175-ath9k-189   [000] .....15  3083.034134: ath_tx_complete_buf <-ath_tx_process_buffer
   irq/175-ath9k-189   [000] .....15  3083.034136: ath_tx_complete <-ath_tx_complete_buf
    kworker/u4:0-28892 [001] .......  3083.083246: ieee80211_offchannel_return <-ieee80211_scan_work

Between timestamp 3082.957750 and 3083.083246, the device went off channel. A packet
came down and reached hardware queue. Hardware TX processing continued. It is a
serious issue if PDUs are indeed sent out during off-channel.

Regards,
Tong

