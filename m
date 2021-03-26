Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517E534AC8A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCZQbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZQar (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 12:30:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BACC0613AA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 09:30:46 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so5755833otr.4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=z5OoTelM4wqs1gRexldu0VXqjDJNTNOTZ2CWwLGRXyw=;
        b=e6PKW/rJWvRb5az0RknODcpHffOhD6uFdYeY5rWm9pQPuKGeQRVIiT/mI+Mu4noVq4
         VyhYYjVlydXc3KRANY4KaRxaNaVV6KfrrYF/qAD2ibnUejJVEyBIZf25b4lcLqI+S5ut
         gJ4M8ljvzoVlZaRmg/fSvkKDAJPkjfftnmZgmYGYjLhvGfkgTyT8gV5E4BYThAVLyDYN
         qB3qJ8paCm+6SmltzMO9a67bEhjFBUSv5PyIte4fT3/josC6cU3sfoKWgOIEqkPxRXW/
         yIr2DnMUXy/tVeQ+SxdOu6ucnb1wERfKa3Hwps1tIS3+IUSPk4fJcOVMTBBGo5wALmd6
         OHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=z5OoTelM4wqs1gRexldu0VXqjDJNTNOTZ2CWwLGRXyw=;
        b=IB7Ei8oOYbL7GoYDGjmzsOdWpGUSOkdKQS2AaMMYJw4TgIsi0xH5Iv/gl3H9bQM44e
         WTLoFVNAKUuwyyLMy8sKYWLo6C1wrlolHTyqC/hLZgHa8Z9oHpU52lD3Jyv/MIAwG2+k
         3J6MycS7x5fZ8/R0Vf0LqS1x2G8ud/mzL3qLe6oC+yANo35bSFvZcVy5FC+qjMt/bSJD
         nYIBEWYLcebVChptDSqOglD6Cb7xzTki4fRtR7gWSbPiaFwONqVEvsqgIq02r+QJlzy/
         xh2k9yzZfCY0uA+O+HLwVXz9Kd4mL2p08gundoB0ei5VtoLYfmoAYT99mJoG5w3O+VWW
         dgyg==
X-Gm-Message-State: AOAM5324518hwEUo4LjtwNtO0Z3rS11K9WuGlVyS9KfMvQ4rymZp+FA3
        CTVLfkk+49lPmEFLS8CEwHew8E6TVe0=
X-Google-Smtp-Source: ABdhPJwnSLTJkaL1IzacAkbadro4Q0R11B7cgpQ8t83n7KoADoO3M8pojNKNzgjbY3J18COjeB7zKA==
X-Received: by 2002:a9d:761a:: with SMTP id k26mr11963746otl.193.1616776245780;
        Fri, 26 Mar 2021 09:30:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m129sm1827517oif.34.2021.03.26.09.30.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 09:30:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Memory leak in rtw88-pci
To:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
Date:   Fri, 26 Mar 2021 11:30:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kmemleak shows the following leaks:

unreferenced object 0xffff888114146a00 (size 512):
   comm "softirq", pid 0, jiffies 4294910753 (age 28.196s)
   hex dump (first 32 bytes):
     08 42 00 00 01 00 5e 00 08 42 00 00 01 00 5e 00  .B....^..B....^.
     00 fb 84 1b 5e f7 6b 02 00 e0 01 00 5e 00 00 fb  ....^.k.....^...
   backtrace:
     [<0000000068bda00b>] kmalloc_reserve+0x2d/0x70
     [<000000006234ee4e>] __alloc_skb+0x8c/0x250
     [<00000000fd066823>] __netdev_alloc_skb+0x3f/0x150
     [<000000002b8b6774>] rtw_pci_rx_napi.constprop.0+0x1c7/0x310 [rtw88_pci]
     [<0000000071d79fc5>] rtw_pci_napi_poll+0x47/0xf0 [rtw88_pci]
     [<000000005b3960c0>] __napi_poll+0x2a/0x160
     [<00000000f87d43ad>] net_rx_action+0x234/0x280
     [<0000000065ab9dcb>] __do_softirq+0xbf/0x285
     [<000000002a7f930b>] do_softirq+0x61/0x80
     [<0000000020308f21>] __local_bh_enable_ip+0x4b/0x50
     [<00000000c4d6ca98>] rtw_pci_interrupt_threadfn+0xb2/0x1f0 [rtw88_pci]
     [<0000000045d500ae>] irq_thread_fn+0x20/0x60
     [<00000000d00af633>] irq_thread+0xa0/0x150
     [<000000007c7898b7>] kthread+0x134/0x150
     [<0000000083df94f0>] ret_from_fork+0x22/0x30

That address in rtw_pci_rx_napi points to the dev_alloc_skb() call in the 
following snippit:

                 /* allocate a new skb for this frame,
                  * discard the frame if none available
                  */
                 new_len = pkt_stat.pkt_len + pkt_offset;
=====>          new = dev_alloc_skb(new_len);
                 if (WARN_ONCE(!new, "rx routine starvation\n"))
                         goto next_rp;

                 /* put the DMA data including rx_desc from phy to new skb */
                 skb_put_data(new, skb->data, new_len);

                 if (pkt_stat.is_c2h) {
                         rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, new);
                 } else {
                         /* remove rx_desc */
                         skb_pull(new, pkt_offset);

                         rtw_rx_stats(rtwdev, pkt_stat.vif, new);
                         memcpy(new->cb, &rx_status, sizeof(rx_status));
                         ieee80211_rx_napi(rtwdev->hw, NULL, new, napi);
                         rx_done++;
                 }

Clearly, the allocated skb is never freed. These allocated blocks do not 
disappear when the driver is unloaded, thus these reports are not false 
positives, but are real memory leaks.

I followed the code in rtw_fw_c2h_cmd_rx_irqsafe() and determined that it is 
freeing the skb, thus the problem is in the branch that calls 
ieee80211_rx_napi(); however, as far as I can tell, this code matches other drivers.

Larry

