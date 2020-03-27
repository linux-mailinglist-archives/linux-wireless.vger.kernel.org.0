Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672451957B5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 14:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgC0NDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 09:03:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33324 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0NDu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 09:03:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so10148467ljm.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2020 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR1iNuna2S8gJdE6t0uOFvhMRja4fXIHzbkhNNfpyB8=;
        b=npmgDk9PGZPczLBEvNdUZOkLm883PguCjobO/4/yFzVzFwkW5PKFlTUMZ7dx14z9XC
         vygYL5NigptIc39+41jRvKB2q7b9T/J242o2UyUtP6GtwOS3nkgErklomRx93RW8SgAL
         Vun17FxKcMQorfALyJrBD5T7Cz7qP+ackFWwSfNKlSmWYT4G6/Vus9riPy5pMfeloFaC
         Q7DFIkzKeWZQ1QDyHI33E+QLu/nEjsYHKRiVEeqDBdzUUeeZcotmwFgdGGkDnN+T7J01
         Y28hLimSQDVDO+tMvVnlb0CovyWi6mIYAt7xUyC5ydob6VT7qubXihMIBqKBRTYpeMqN
         /vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR1iNuna2S8gJdE6t0uOFvhMRja4fXIHzbkhNNfpyB8=;
        b=O8Y45VSI8LE7T8AsOa67Jw+FLc5IS9OwHj1D2uqij9xSAB4/H432w6xBly1L/foS2W
         ybXuqXmfQdboQfsIe7mn4T/x9SvB3ivFIpnOMsP1lxj8BulaHpVQXrRu06CO6k1nq1xq
         +JVTkCxA/7nItdoyaBUl4hdoueLrIq+K2c7QgwNC+t4Q3lbUwJumLm8I5tlxRA761rxC
         KR4bR246ZRoqgSB//QL7TPbqZtpRY9E0xTlKfgq4H/wa6Wb05zd8eglhexMgKVDXgL+O
         T/v5jDnlW+LdRSTifHmeqAroHM6YJzeGVJEpd5QAARkXidtQeSq6WQADnDc298nC9GlG
         Hc0Q==
X-Gm-Message-State: ANhLgQ06hwsQVGh++H1RVU8TidN4yySavBoMvCxmlZo4CFcxy9RljL0i
        GQ7djQziTVnBpvp/gZiBjbE=
X-Google-Smtp-Source: APiQypI7DVFWmttHYPoi9pRIo5Dg1x1CCrdQ4WFz+hwWFQoAuF2qJEmRxdGANFycQlSESZCN66fo0A==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr8621198ljp.282.1585314226712;
        Fri, 27 Mar 2020 06:03:46 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id h9sm2637284ljk.96.2020.03.27.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:03:41 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 5.6+] brcmfmac: add stub for monitor interface xmit
Date:   Fri, 27 Mar 2020 14:03:07 +0100
Message-Id: <20200327130307.26477-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

According to the struct net_device_ops documentation .ndo_start_xmit is
"Required; cannot be NULL.". Missing it may crash kernel easily:

[  341.216709] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[  341.224836] pgd = 26088755
[  341.227544] [00000000] *pgd=00000000
[  341.231135] Internal error: Oops: 80000007 [#1] SMP ARM
[  341.236367] Modules linked in: pppoe ppp_async iptable_nat brcmfmac xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQU
[  341.304689] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.24 #0
[  341.310621] Hardware name: BCM5301X
[  341.314116] PC is at 0x0
[  341.316664] LR is at dev_hard_start_xmit+0x8c/0x11c
[  341.321546] pc : [<00000000>]    lr : [<c0469fa8>]    psr: 60000113
[  341.327821] sp : c0801c30  ip : c610cf00  fp : c08048e4
[  341.333051] r10: c073a63a  r9 : c08044dc  r8 : c6c04e00
[  341.338283] r7 : 00000000  r6 : c60f5000  r5 : 00000000  r4 : c6a9c3c0
[  341.344820] r3 : 00000000  r2 : bf25a13c  r1 : c60f5000  r0 : c6a9c3c0
[  341.351358] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  341.358504] Control: 10c5387d  Table: 0611c04a  DAC: 00000051
[  341.364257] Process swapper/0 (pid: 0, stack limit = 0xc68ed0ca)
[  341.370271] Stack: (0xc0801c30 to 0xc0802000)
[  341.374633] 1c20:                                     c6e7d480 c0802d00 c60f5050 c0801c6c
[  341.382825] 1c40: c60f5000 c6a9c3c0 c6f90000 c6f9005c c6c04e00 c60f5000 00000000 c6f9005c
[  341.391015] 1c60: 00000000 c04a033c 00f90200 00000010 c6a9c3c0 c6a9c3c0 c6f90000 00000000
[  341.399205] 1c80: 00000000 00000000 00000000 c046a7ac c6f9005c 00000001 fffffff4 00000000
[  341.407395] 1ca0: c6f90200 00000000 c60f5000 c0479550 00000000 c6f90200 c6a9c3c0 16000000
[  341.415586] 1cc0: 0000001c 6f4ad52f c6197040 b6df9387 36000000 c0520404 c073a80c c6a9c3c0
[  341.423777] 1ce0: 00000000 c6d643c0 c6a9c3c0 c0800024 00000001 00000001 c6d643c8 c6a9c3c0
[  341.431967] 1d00: c081b9c0 c7abca80 c610c840 c081b9c0 0000001c 00400000 c6bc5e6c c0522fb4
[  341.440157] 1d20: c6d64400 00000004 c6bc5e0a 00000000 c60f5000 c7abca80 c081b9c0 c0522f54
[  341.448348] 1d40: c6a9c3c0 c7abca80 c0803e48 c0549c94 c610c828 0000000a c0801d74 00000003
[  341.456538] 1d60: c6ec8f0a 00000000 c60f5000 c7abca80 c081b9c0 c0548520 0000000a 00000000
[  341.464728] 1d80: 00000000 003a0000 00000000 00000000 00000000 00000000 00000000 00000000
[  341.472919] 1da0: 000002ff 00000000 00000000 16000000 00000000 00000000 00000000 00000000
[  341.481110] 1dc0: 00000000 0000008f 00000000 00000000 00000000 2d132a69 c6bc5e40 00000000
[  341.489300] 1de0: c6bc5e40 c6a9c3c0 00000000 c6ec8e50 00000001 c054b070 00000001 00000000
[  341.497490] 1e00: c0807200 c6bc5e00 00000000 ffffe000 00000100 c054aea4 00000000 00000000
[  341.505681] 1e20: 00000122 00400000 c0802d00 c0172e80 6f56a70e ffffffff 6f56a70e c7eb9cc0
[  341.513871] 1e40: c7eb82c0 00000000 c0801e60 c017309c 00000000 00000000 07780000 c07382c0
[  341.522061] 1e60: 00000000 c7eb9cc0 c0739cc0 c0803f74 c0801e70 c0801e70 c0801ea4 c013d380
[  341.530253] 1e80: 00000000 000000a0 00000001 c0802084 c0802080 40000001 ffffe000 00000100
[  341.538443] 1ea0: c0802080 c01021e8 c8803100 10c5387d 00000000 c07341f0 c0739880 0000000a
[  341.546633] 1ec0: c0734180 00001017 c0802d00 c062aa98 00200002 c062aa60 c8803100 c073984c
[  341.554823] 1ee0: 00000000 00000001 00000000 c7810000 c8803100 10c5387d 00000000 c011c188
[  341.563014] 1f00: c073984c c015f0f8 c0804244 c0815ae4 c880210c c8802100 c0801f40 c037c584
[  341.571204] 1f20: c01035f8 60000013 ffffffff c0801f74 c080afd4 c0800000 10c5387d c0101a8c
[  341.579395] 1f40: 00000000 004ac9dc c7eba4b4 c010ee60 ffffe000 c0803e68 c0803ea8 00000001
[  341.587587] 1f60: c080afd4 c062ca20 10c5387d 00000000 00000000 c0801f90 c01035f4 c01035f8
[  341.595776] 1f80: 60000013 ffffffff 00000051 00000000 ffffe000 c013ff50 000000ce c0803e40
[  341.603967] 1fa0: c082216c 00000000 00000001 c072ba38 10c5387d c0140214 c0822184 c0700df8
[  341.612157] 1fc0: ffffffff ffffffff 00000000 c070058c c072ba38 2d162e71 00000000 c0700330
[  341.620348] 1fe0: 00000051 10c0387d 000000ff 00a521d0 413fc090 00000000 00000000 00000000
[  341.628558] [<c0469fa8>] (dev_hard_start_xmit) from [<c04a033c>] (sch_direct_xmit+0xe4/0x2bc)
[  341.637106] [<c04a033c>] (sch_direct_xmit) from [<c046a7ac>] (__dev_queue_xmit+0x6a4/0x72c)
[  341.645481] [<c046a7ac>] (__dev_queue_xmit) from [<c0520404>] (ip6_finish_output2+0x18c/0x434)
[  341.654112] [<c0520404>] (ip6_finish_output2) from [<c0522fb4>] (ip6_output+0x5c/0xd0)
[  341.662053] [<c0522fb4>] (ip6_output) from [<c0549c94>] (mld_sendpack+0x1a0/0x1a8)
[  341.669640] [<c0549c94>] (mld_sendpack) from [<c054b070>] (mld_ifc_timer_expire+0x1cc/0x2e4)
[  341.678111] [<c054b070>] (mld_ifc_timer_expire) from [<c0172e80>] (call_timer_fn.constprop.3+0x24/0x98)
[  341.687527] [<c0172e80>] (call_timer_fn.constprop.3) from [<c017309c>] (run_timer_softirq+0x1a8/0x1e4)
[  341.696860] [<c017309c>] (run_timer_softirq) from [<c01021e8>] (__do_softirq+0x120/0x2b0)
[  341.705066] [<c01021e8>] (__do_softirq) from [<c011c188>] (irq_exit+0x78/0x84)
[  341.712317] [<c011c188>] (irq_exit) from [<c015f0f8>] (__handle_domain_irq+0x60/0xb4)
[  341.720179] [<c015f0f8>] (__handle_domain_irq) from [<c037c584>] (gic_handle_irq+0x4c/0x90)
[  341.728549] [<c037c584>] (gic_handle_irq) from [<c0101a8c>] (__irq_svc+0x6c/0x90)

Fixes: 20f2c5fa3af0 ("brcmfmac: add initial support for monitor mode")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This fixes bug introduced in 5.6-rc1. If it's too late for 5.6 this can
go to 5.7 and get into stable/linux.git later.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 23627c953a5e..436f501be937 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -729,9 +729,18 @@ static int brcmf_net_mon_stop(struct net_device *ndev)
 	return err;
 }
 
+static netdev_tx_t brcmf_net_mon_start_xmit(struct sk_buff *skb,
+					    struct net_device *ndev)
+{
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
 static const struct net_device_ops brcmf_netdev_ops_mon = {
 	.ndo_open = brcmf_net_mon_open,
 	.ndo_stop = brcmf_net_mon_stop,
+	.ndo_start_xmit = brcmf_net_mon_start_xmit,
 };
 
 int brcmf_net_mon_attach(struct brcmf_if *ifp)
-- 
2.25.1

