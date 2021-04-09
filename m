Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9529B35939D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 06:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhDIEM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 00:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDIEM6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 00:12:58 -0400
Received: from mout0.freenet.de (mout0.freenet.de [IPv6:2001:748:100:40::2:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D1CC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 21:12:46 -0700 (PDT)
Received: from [195.4.92.121] (helo=sub2.freenet.de)
        by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1lUiVd-0001Wa-I6
        for linux-wireless@vger.kernel.org; Fri, 09 Apr 2021 06:12:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JHA6A/F36lamzPysbdI0fNbCQKKGIMeiwQwm1dA+diY=; b=QrszmqZDLxT1rXeElFXxYdoTGo
        J1a8VxHhGJRQmSH7ge8aJN4MDDYvmMv/x8dDuo2VqtGk5nt/qS/Kmxb5zR/ywqjU2QlFTGLNyrDa6
        6C0v9CTCF/XdYkjHdTj/Bb2oJmV/nkiuGiQnVpX+zV+j7Xf+S/XmtTPZi+WnNcH3YsHN+OIjIp5S/
        eHreE5G1dLo7AQrzoS4lW76pu56GE0mcgZS+sdTLm8R04cqQ5OcXK21ux9/5KOidb+t9qG8JJXabq
        UW3yZcJaRQTThozNjJVXeDsEv8qFqvFQpWye7SEn6hhNeFnTvol3Sh/aed6nY/7NE1lwypPCzyKxb
        3ee7HkrA==;
Received: from p200300de57147b00505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5714:7b00:5054:ff:fe15:ac42]:41604 helo=mail.maya.org)
        by sub2.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1lUiVd-0001M0-FM
        for linux-wireless@vger.kernel.org; Fri, 09 Apr 2021 06:12:41 +0200
Received: internal info suppressed
To:     linux-wireless <linux-wireless@vger.kernel.org>
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
From:   =?UTF-8?Q?Klaus_M=c3=bcller?= <kmueller@justmail.de>
Subject: Re: Memory leak in rtw88-pci
Message-ID: <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
Date:   Fri, 9 Apr 2021 06:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:de:5714:7b00:5054:ff:fe15:ac42!41604
X-FNSign: v=2 s=C8720ACF85B14CA62219ADCDD530AD739BB697C5F76A14CBFE29658FDC9BC4F3
X-Scan-TS: Fri, 09 Apr 2021 06:12:41 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello all!

May I kindly bring up this reported problem again? Is there anybody working on 
this problem? Or did I miss the already existing fix?


Thanks
Klaus


On 26.03.21 at 17:30 Larry Finger wrote:
> Kmemleak shows the following leaks:
> 
> unreferenced object 0xffff888114146a00 (size 512):
>    comm "softirq", pid 0, jiffies 4294910753 (age 28.196s)
>    hex dump (first 32 bytes):
>      08 42 00 00 01 00 5e 00 08 42 00 00 01 00 5e 00  .B....^..B....^.
>      00 fb 84 1b 5e f7 6b 02 00 e0 01 00 5e 00 00 fb  ....^.k.....^...
>    backtrace:
>      [<0000000068bda00b>] kmalloc_reserve+0x2d/0x70
>      [<000000006234ee4e>] __alloc_skb+0x8c/0x250
>      [<00000000fd066823>] __netdev_alloc_skb+0x3f/0x150
>      [<000000002b8b6774>] rtw_pci_rx_napi.constprop.0+0x1c7/0x310 [rtw88_pci]
>      [<0000000071d79fc5>] rtw_pci_napi_poll+0x47/0xf0 [rtw88_pci]
>      [<000000005b3960c0>] __napi_poll+0x2a/0x160
>      [<00000000f87d43ad>] net_rx_action+0x234/0x280
>      [<0000000065ab9dcb>] __do_softirq+0xbf/0x285
>      [<000000002a7f930b>] do_softirq+0x61/0x80
>      [<0000000020308f21>] __local_bh_enable_ip+0x4b/0x50
>      [<00000000c4d6ca98>] rtw_pci_interrupt_threadfn+0xb2/0x1f0 [rtw88_pci]
>      [<0000000045d500ae>] irq_thread_fn+0x20/0x60
>      [<00000000d00af633>] irq_thread+0xa0/0x150
>      [<000000007c7898b7>] kthread+0x134/0x150
>      [<0000000083df94f0>] ret_from_fork+0x22/0x30
> 
> That address in rtw_pci_rx_napi points to the dev_alloc_skb() call in the 
> following snippit:
> 
>                  /* allocate a new skb for this frame,
>                   * discard the frame if none available
>                   */
>                  new_len = pkt_stat.pkt_len + pkt_offset;
> =====>          new = dev_alloc_skb(new_len);
>                  if (WARN_ONCE(!new, "rx routine starvation\n"))
>                          goto next_rp;
> 
>                  /* put the DMA data including rx_desc from phy to new skb */
>                  skb_put_data(new, skb->data, new_len);
> 
>                  if (pkt_stat.is_c2h) {
>                          rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, new);
>                  } else {
>                          /* remove rx_desc */
>                          skb_pull(new, pkt_offset);
> 
>                          rtw_rx_stats(rtwdev, pkt_stat.vif, new);
>                          memcpy(new->cb, &rx_status, sizeof(rx_status));
>                          ieee80211_rx_napi(rtwdev->hw, NULL, new, napi);
>                          rx_done++;
>                  }
> 
> Clearly, the allocated skb is never freed. These allocated blocks do not disappear 
> when the driver is unloaded, thus these reports are not false positives, but are 
> real memory leaks.
> 
> I followed the code in rtw_fw_c2h_cmd_rx_irqsafe() and determined that it is 
> freeing the skb, thus the problem is in the branch that calls ieee80211_rx_napi(); 
> however, as far as I can tell, this code matches other drivers.
> 
> Larry
> 

