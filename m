Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38780226D0D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgGTRYn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 13:24:43 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:62201 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgGTRYm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 13:24:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595265881; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BVPCNxXvhF+XJsYssOAzH5RlCmnajngO8wv+vF3zF/E=;
 b=CPbu896d3C5nKtesPk+5gC7yTWYOHcBb5ObHqukE78PX4TbfXZJnghFbeWemrQkJ1cJqW7mL
 2cKjafxOmlSmGcYCy1/R70O+UdmEEhgcvFbs0Jul7nCkEpY24Ww2DPLtO5hIvhJUXdP+Gd8W
 Bmp4HyTbQ0MZcfzztrDpyznNIuY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f15d3438e9b2c49c6ead739 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 17:24:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2CF94C433C6; Mon, 20 Jul 2020 17:24:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEB63C433C6;
        Mon, 20 Jul 2020 17:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEB63C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.8] ath10k: Fix NULL pointer dereference in AHB device
 probe
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200714205802.17688-1-hauke@hauke-m.de>
References: <20200714205802.17688-1-hauke@hauke-m.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     mkenna@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200720172419.2CF94C433C6@smtp.codeaurora.org>
Date:   Mon, 20 Jul 2020 17:24:19 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hauke Mehrtens <hauke@hauke-m.de> wrote:

> This fixes a NULL pointer dereference in the probe path for AHB devices.
> There attr parameter in the ath10k_ce_alloc_pipe() function is not
> initialized, but accessed. This function is called by
> ath10k_pci_setup_resource() which is called by ath10k_ahb_probe().
> 
> The struct ath10k_pci is also used for AHB devices and not only for PCI
> devices.
> 
> The initialization of the new members of struct ath10k_pci is moved to
> ath10k_pci_setup_resource() which is used by the PCI and the AHB code.
> 
> This also fixes a use after free bug in ath10k_pci_remove() when ar_pci
> is accessed after ath10k_core_destroy() was called, which calls
> ieee80211_free_hw() and frees this memory.
> 
> This fixes the following bug seen with backports-5.8-rc2 on OpenWrt on a
> IPQ4019 device:
> 
> [   11.117462] 8<--- cut here ---
> [   11.117494] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [   11.119510] pgd = f377fd58
> [   11.127657] [00000000] *pgd=8e9a0835, *pte=00000000, *ppte=00000000
> [   11.130206] Internal error: Oops: 17 [#1] SMP ARM
> [   11.136339] Modules linked in: ath10k_pci(+) ath10k_core ath xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQUERADE xt_FLOWOFFLOAD pppox ppp_generic nf_nat nf_flow_table_hw nf_flow_table nf_conntrack_rtcache nf_conntrack mac80211 ipt_REJECT cfg80211 xt_time xt_tcpudp xt_multiport xt_mark xt_mac xt_limit xt_comment xt_TCPMSS xt_LOG slhc nf_reject_ipv4 nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter ip_tables crc_ccitt compat nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_qcom gpio_button_hotplug
> [   11.174355] CPU: 2 PID: 257 Comm: kmodloader Not tainted 5.4.51 #0
> [   11.196585] Hardware name: Generic DT based system
> [   11.202746] PC is at ath10k_ce_alloc_pipe+0x58/0x180 [ath10k_core]
> [   11.207459] LR is at ath10k_pci_alloc_pipes+0x94/0xc8 [ath10k_pci]
> [   11.213600] pc : [<bf2c96cc>]    lr : [<bf2fbf98>]    psr: 80000013
> [   11.219760] sp : cea0dc90  ip : cf4001f0  fp : 00000001
> [   11.225923] r10: 00000000  r9 : 00000018  r8 : ce4963b4
> [   11.231133] r7 : 00000000  r6 : ce491ea0  r5 : 00000000  r4 : ce4963b4
> [   11.236342] r3 : 0004a000  r2 : 0004a000  r1 : bf2d0d70  r0 : 00000006
> [   11.242942] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   11.249452] Control: 10c5387d  Table: 8e9c006a  DAC: 00000051
> [   11.256656] Process kmodloader (pid: 257, stack limit = 0xaba286ca)
> [   11.262386] Stack: (0xcea0dc90 to 0xcea0e000)
> [   11.268462] dc80:                                     00000000 ce49629c ce491ea0 ce4963bc
> [   11.272984] dca0: ce495ea0 bf2fbf98 00000002 ce4963a8 ce495ea0 00000000 ce491ea0 cf95d800
> [   11.281142] dcc0: cf95d810 cf95d810 00000001 bf2fc854 00000000 cf95d800 bf300748 ce495ea0
> [   11.289304] dce0: ce491ea0 d1300000 cf95d800 bf2fde8c 00000000 00000001 ce49cea0 00000000
> [   11.297462] dd00: 00000000 00000000 bf3010a0 cf95d810 bf3010a0 c0b61580 00000000 00000000
> [   11.305624] dd20: bf3010a0 0000000b c0b04e48 c06110c8 c0b61588 cf95d810 c0b61580 c060f740
> [   11.313781] dd40: cf95d810 00000000 bf3010a0 00000000 00000000 ce49d2a4 bf301100 c060fc90
> [   11.321943] dd60: 00000000 bf3010a0 cf95d810 c060fcf0 cf95d810 bf3010a0 c060fc98 c060dca4
> [   11.330101] dd80: cf809d58 cf952cb4 bf3010a0 ce967900 c0b1f2c8 c060ec28 bf3007b8 bf301038
> [   11.338263] dda0: bf3010a0 bf3010a0 c0b2d4d4 ffffe000 bf304000 c0610278 c0b04e48 c0b2d4d4
> [   11.346422] ddc0: ffffe000 bf2fe2b4 c0b04e48 bf30403c c0b04e48 c0302764 8040003f 00000001
> [   11.354582] dde0: 38e38e39 ce513580 c0b2cb50 cf801e00 cffbc6ac ce513600 cf801e00 cffbc6ac
> [   11.362740] de00: 8040003e ce49d280 00000001 c0428d54 00000001 cf801e00 cffbc6ac ce513580
> [   11.370900] de20: ce49d280 0e391998 bf301100 ce49d340 d12d2000 ce49d280 00000001 c0398c2c
> [   11.379061] de40: 00000001 cea0df34 cea0df34 00000001 d12d2000 c039ae48 bf30110c 00007fff
> [   11.387221] de60: bf301100 c0398044 cf804028 bf301148 c0397674 bf30126c c08ee5c0 c08ee70c
> [   11.395380] de80: bf30110c c0b04e48 c08ee518 00000000 c08ee570 c0b04e48 ce513600 fffff000
> [   11.403540] dea0: 00000001 ce513580 0000000d 0000000d 00000000 00000000 00000000 00000000
> [   11.411698] dec0: 00000000 00000000 6e72656b 00006c65 00000000 00000000 00000000 00000000
> [   11.419858] dee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   11.428018] df00: 00000000 0e391998 00000000 0000c610 d12de610 00000000 0062c620 ffffe000
> [   11.436180] df20: 000129d1 00000051 00000000 c039b228 00000000 d12d7afd d12d8e80 d12d2000
> [   11.444337] df40: 0000c610 d12de0e8 d12ddfa8 d12dab74 00009000 00009570 00003a2c 00009cae
> [   11.452498] df60: 00000000 00000000 00000000 00003a1c 0000001e 0000001f 00000018 00000000
> [   11.460656] df80: 00000010 00000000 00000000 00000000 00000003 00000080 c0301204 cea0c000
> [   11.468817] dfa0: 00000080 c0301000 00000000 00000000 00620010 0000c610 000129d1 00000014
> [   11.476975] dfc0: 00000000 00000000 00000003 00000080 0000c610 00000000 b6fc1d20 00000000
> [   11.485137] dfe0: bef0ad14 bef0acf8 00011e14 b6f74c94 60000010 00620010 00000000 00000000
> [   11.493390] [<bf2c96cc>] (ath10k_ce_alloc_pipe [ath10k_core]) from [<bf2fbf98>] (ath10k_pci_alloc_pipes+0x94/0xc8 [ath10k_pci])
> [   11.501498] [<bf2fbf98>] (ath10k_pci_alloc_pipes [ath10k_pci]) from [<bf2fc854>] (ath10k_pci_setup_resource+0xb8/0xf0 [ath10k_pci])
> [   11.512773] [<bf2fc854>] (ath10k_pci_setup_resource [ath10k_pci]) from [<bf2fde8c>] (ath10k_ahb_probe+0x32c/0x670 [ath10k_pci])
> [   11.524566] [<bf2fde8c>] (ath10k_ahb_probe [ath10k_pci]) from [<c06110c8>] (platform_drv_probe+0x34/0x70)
> [   11.536016] [<c06110c8>] (platform_drv_probe) from [<c060f740>] (really_probe+0x1f0/0x358)
> [   11.545729] [<c060f740>] (really_probe) from [<c060fc90>] (device_driver_attach+0x58/0x60)
> [   11.553886] [<c060fc90>] (device_driver_attach) from [<c060fcf0>] (__driver_attach+0x58/0xcc)
> [   11.562134] [<c060fcf0>] (__driver_attach) from [<c060dca4>] (bus_for_each_dev+0x68/0x8c)
> [   11.570731] [<c060dca4>] (bus_for_each_dev) from [<c060ec28>] (bus_add_driver+0x1c8/0x1d8)
> [   11.578886] [<c060ec28>] (bus_add_driver) from [<c0610278>] (driver_register+0x74/0x108)
> [   11.587060] [<c0610278>] (driver_register) from [<bf2fe2b4>] (ath10k_ahb_init+0x18/0x38 [ath10k_pci])
> [   11.595320] [<bf2fe2b4>] (ath10k_ahb_init [ath10k_pci]) from [<bf30403c>] (init_module+0x3c/0x1000 [ath10k_pci])
> [   11.604432] [<bf30403c>] (init_module [ath10k_pci]) from [<c0302764>] (do_one_initcall+0x84/0x1d8)
> [   11.614657] [<c0302764>] (do_one_initcall) from [<c0398c2c>] (do_init_module+0x5c/0x228)
> [   11.623421] [<c0398c2c>] (do_init_module) from [<c039ae48>] (load_module+0x1fc8/0x224c)
> [   11.631663] [<c039ae48>] (load_module) from [<c039b228>] (sys_init_module+0x15c/0x17c)
> [   11.639390] [<c039b228>] (sys_init_module) from [<c0301000>] (ret_fast_syscall+0x0/0x54)
> [   11.647370] Exception stack(0xcea0dfa8 to 0xcea0dff0)
> [   11.655615] dfa0:                   00000000 00000000 00620010 0000c610 000129d1 00000014
> [   11.660569] dfc0: 00000000 00000000 00000003 00000080 0000c610 00000000 b6fc1d20 00000000
> [   11.668725] dfe0: bef0ad14 bef0acf8 00011e14 b6f74c94
> [   11.676886] Code: e1c321d4 e0433002 e0232397 e5843014 (e5953000)
> [   11.681958] ---[ end trace 8f35917de2e76854 ]---
> 
> Fixes: 521fc37be3d8 ("ath10k: Avoid override CE5 configuration for QCA99X0 chipsets")
> Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de> [ipq40xx/ map-ac2200]
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Patch applied to wireless-drivers.git, thanks.

1cfd3426ef98 ath10k: Fix NULL pointer dereference in AHB device probe

-- 
https://patchwork.kernel.org/patch/11663789/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

