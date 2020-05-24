Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76B31E00E0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEXRPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgEXRPb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 13:15:31 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0300C061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CTj1R6lBjgxVhAnmTBqgS+0siPBn+xRDNyywk4E/on4=; b=CPDWhWNQSf2LRJyIlk3rec2SXj
        dM4AzkgV9CZ9bwCvjebW1LcMggNmLdk0ZKoxtQ7PN1eFp1A9olPkgUqXSdJltKuwBqOrSKKizf4LM
        oOPLyjjcihBcsFiq+zjyvEtuNBMIyPud2XkP8OU3HLxNzp99Db5FZ/OcvME1lmRTqb14=;
Received: from p5b206c3b.dip0.t-ipconnect.de ([91.32.108.59] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jcuDh-0001ho-Oe; Sun, 24 May 2020 19:15:29 +0200
Subject: Re: [PATCH] mt76: only iterate over initialized rx queues
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
References: <20200524130746.98760-1-nbd@nbd.name>
 <20200524134500.GA33803@localhost.localdomain>
 <a8e42710-0d04-845f-db4b-ab0bf6509a7c@nbd.name>
 <20200524161300.GA3032@localhost.localdomain>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <88f94882-e000-5747-263e-d54e1416950f@nbd.name>
Date:   Sun, 24 May 2020 19:15:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524161300.GA3032@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-24 18:13, Lorenzo Bianconi wrote:
>> On 2020-05-24 15:45, Lorenzo Bianconi wrote:
>> >> Fixes the following reported crash:
>> >> 
>> >> [    2.361127] BUG: spinlock bad magic on CPU#0, modprobe/456
>> >> [    2.361583]  lock: 0xffffa1287525b3b8, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>> >> [    2.362250] CPU: 0 PID: 456 Comm: modprobe Not tainted 4.14.177 #5
>> >> [    2.362751] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.75.0 06/17/2019
>> >> [    2.363343] Call Trace:
>> >> [    2.363552]  dump_stack+0x97/0xdb
>> >> [    2.363826]  ? spin_bug+0xa6/0xb3
>> >> [    2.364096]  do_raw_spin_lock+0x6a/0x9a
>> >> [    2.364417]  mt76_dma_rx_fill+0x44/0x1de [mt76]
>> >> [    2.364787]  ? mt76_dma_kick_queue+0x18/0x18 [mt76]
>> >> [    2.365184]  mt76_dma_init+0x53/0x85 [mt76]
>> >> [    2.365532]  mt7615_dma_init+0x3d7/0x546 [mt7615e]
>> >> [    2.365928]  mt7615_register_device+0xe6/0x1a0 [mt7615e]
>> >> [    2.366364]  mt7615_mmio_probe+0x14b/0x171 [mt7615e]
>> >> [    2.366771]  mt7615_pci_probe+0x118/0x13b [mt7615e]
>> >> [    2.367169]  pci_device_probe+0xaf/0x13d
>> >> [    2.367491]  driver_probe_device+0x284/0x2ca
>> >> [    2.367840]  __driver_attach+0x7a/0x9e
>> >> [    2.368146]  ? driver_attach+0x1f/0x1f
>> >> [    2.368451]  bus_for_each_dev+0xa0/0xdb
>> >> [    2.368765]  bus_add_driver+0x132/0x204
>> >> [    2.369078]  driver_register+0x8e/0xcd
>> >> [    2.369384]  do_one_initcall+0x160/0x257
>> >> [    2.369706]  ? 0xffffffffc0240000
>> >> [    2.369980]  do_init_module+0x60/0x1bb
>> >> [    2.370286]  load_module+0x18c2/0x1a2b
>> >> [    2.370596]  ? kernel_read_file+0x141/0x1b9
>> >> [    2.370937]  ? kernel_read_file_from_fd+0x46/0x71
>> >> [    2.371320]  SyS_finit_module+0xcc/0xf0
>> >> [    2.371636]  do_syscall_64+0x6b/0xf7
>> >> [    2.371930]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>> >> [    2.372344] RIP: 0033:0x7da218ae4199
>> >> [    2.372637] RSP: 002b:00007fffd0608398 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>> >> [    2.373252] RAX: ffffffffffffffda RBX: 00005a705449df90 RCX: 00007da218ae4199
>> >> [    2.373833] RDX: 0000000000000000 RSI: 00005a7052e73bd8 RDI: 0000000000000006
>> >> [    2.374411] RBP: 00007fffd06083e0 R08: 0000000000000000 R09: 00005a705449d540
>> >> [    2.374989] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
>> >> [    2.375569] R13: 00005a705449def0 R14: 00005a7052e73bd8 R15: 0000000000000000
>> >> 
>> >> Reported-by: Sean Wang <sean.wang@mediatek.com>
>> >> Fixes: d3377b78cec6 ("mt76: add HE phy modes and hardware queue")
>> >> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> > 
>> > Just a couple of nitpicks inline, for the rest:
>> > 
>> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > 
>> >> ---
>> >>  drivers/net/wireless/mediatek/mt76/debugfs.c      | 2 +-
>> >>  drivers/net/wireless/mediatek/mt76/dma.c          | 4 ++--
>> >>  drivers/net/wireless/mediatek/mt76/mt76.h         | 4 ++++
>> >>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c   | 3 ++-
>> >>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 3 ++-
>> >>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c   | 8 +++++---
>> >>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 3 ++-
>> >>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c   | 3 ++-
>> >>  8 files changed, 20 insertions(+), 10 deletions(-)
>> >> 
>> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
>> >> index afb1ccf61b74..78378dcf430a 100644
>> >> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
>> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
>> >> @@ -671,6 +671,10 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
>> >>  #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
>> >>  #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
>> >>  
>> >> +#define mt76_for_each_q_rx(dev, i)	\
>> >> +	for (i = 0; i < ARRAY_SIZE((dev)->q_rx) && \
>> >> +		    (dev)->q_rx[i].desc; i++)
> 
> reviewing the patch I guess this will not work for usb code since we do not
> allocate q_rx[].desc pointer there. I guess we can use q_rx[].ndesc instead
Thanks, I will send v2 with that change included.

- Felix
