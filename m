Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF3BFCC1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 03:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfI0BjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 21:39:07 -0400
Received: from hz.preining.info ([95.216.25.247]:42730 "EHLO hz.preining.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfI0BjG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 21:39:06 -0400
X-Greylist: delayed 2046 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 21:39:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cl09kV01AzgoCLJw2K7xZ5KEVLK6dS5enLVqGXWm9cs=; b=RqAcgnX31xdoOiHJfNPnCYLFRG
        NXNXX7Q6yMetX9UNXNDI3gG+hPJOHStiz9dryxpcsXf02oGMC/PMe1+sWxBCpUBkE6VD7yYxm8TOb
        xnCdyYRMU70PPXYQAA2+MdPvmW8glqp5QAvIl++RAAVXJ5QeS9j8oOs2urBiIgnufv6XCNz5wO5Y9
        lgaBJTGXaFQZckhcpvzkXn1DvN98hExLEbv6k3Eyf9OZ0dQl0Sou98evngd0uVLjVNyyeNuydQ0v+
        GIG7RHrQc9qhGdRm+52Qlnd/9XoIp8E3TaS1xjej4mXmyG4fw0mdDv5Y2X7HOL9hAt7QbSm52mOAO
        vaIjAaOg==;
Received: from om126133241008.21.openmobile.ne.jp ([126.133.241.8] helo=burischnitzel.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1iDegr-0004UR-M6; Fri, 27 Sep 2019 01:04:58 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id 41101690249D; Fri, 27 Sep 2019 10:04:52 +0900 (JST)
Date:   Fri, 27 Sep 2019 10:04:52 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilw@linux.intel.com
Subject: IWL AC 8260, kernel 5.3.*, many kernel WARNING
Message-ID: <20190927010452.b576njhcvgowasf3@burischnitzel.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear all,

(please cc)

linux 5.3.1
Debian/sid
Thinkpad X260
iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
iwlwifi 0000:04:00.0: loaded firmware version 36.8fd77bb3.0 op_mode iwlmvm

since about 5.3.0 I get a lot of warnings in the syslog about iwlmvm.

It starts with
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Microcode SW error detected.  Restarting 0x82000000.
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Loaded firmware version: 36.8fd77bb3.0
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
....

after that
Sep 27 09:08:35 burischnitzel kernel: ieee80211 phy0: Hardware restart was requested
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW Error notification: seq 0x0030 service 0x00000005
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW Error notification: timestamp 0x000000000037F460
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
Sep 27 09:08:35 burischnitzel kernel: CPU: 0 PID: 525 Comm: kworker/0:1 Tainted: G        W  OE     5.3.1 #15
Sep 27 09:08:35 burischnitzel kernel: Hardware name: LENOVO 20F5CTO1WW/20F5CTO1WW, BIOS R02ET71W (1.44 ) 05/08/2019
Sep 27 09:08:35 burischnitzel kernel: Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel: Call Trace:
Sep 27 09:08:35 burischnitzel kernel:  dump_stack+0x46/0x60
Sep 27 09:08:35 burischnitzel kernel:  iwl_trans_pcie_send_hcmd+0x46e/0x490 [iwlwifi]
Sep 27 09:08:35 burischnitzel kernel:  ? wait_woken+0x70/0x70
Sep 27 09:08:35 burischnitzel kernel:  iwl_trans_send_cmd+0x57/0xb0 [iwlwifi]
Sep 27 09:08:35 burischnitzel kernel:  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel:  iwl_mvm_get_sar_geo_profile+0xae/0x130 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel:  ? iwl_mvm_get_regdomain+0x7f/0xc0 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel:  iwl_mvm_rx_chub_update_mcc+0xcd/0x110 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel:  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel:  process_one_work+0x1cf/0x370
Sep 27 09:08:35 burischnitzel kernel:  worker_thread+0x4a/0x3c0
Sep 27 09:08:35 burischnitzel kernel:  ? process_one_work+0x370/0x370
Sep 27 09:08:35 burischnitzel kernel:  kthread+0x118/0x130
Sep 27 09:08:35 burischnitzel kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Sep 27 09:08:35 burischnitzel kernel:  ret_from_fork+0x35/0x40
Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Failed to get geographic profile info -5
Sep 27 09:08:35 burischnitzel kernel: ------------[ cut here ]------------
Sep 27 09:08:35 burischnitzel kernel: WARNING: CPU: 0 PID: 525 at iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel: Modules linked in: xt_MASQUERADE(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(E) xt>
Sep 27 09:08:35 burischnitzel kernel:  libarc4(E) snd_hda_intel(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) iwlwifi(E) core>
Sep 27 09:08:35 burischnitzel kernel:  rtsx_pci_sdmmc(E) aes_x86_64(E) crypto_simd(E) mmc_core(E) cryptd(E) glue_helper(E) scs>
Sep 27 09:08:35 burischnitzel kernel: CPU: 0 PID: 525 Comm: kworker/0:1 Tainted: G        W  OE     5.3.1 #15
Sep 27 09:08:35 burischnitzel kernel: Hardware name: LENOVO 20F5CTO1WW/20F5CTO1WW, BIOS R02ET71W (1.44 ) 05/08/2019
Sep 27 09:08:35 burischnitzel kernel: Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel: RIP: 0010:iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel: Code: 48 c7 c7 68 8e d8 c0 e8 8a c3 74 d2 0f 0b 49 8b 47 10 44 8b a0 9c 00 00 00 e9 d2 0>
Sep 27 09:08:35 burischnitzel kernel: RSP: 0018:ffff9f524343fdf8 EFLAGS: 00010246
Sep 27 09:08:35 burischnitzel kernel: RAX: 0000000000000024 RBX: ffff8cea7f44b040 RCX: 0000000000000006
Sep 27 09:08:35 burischnitzel kernel: RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff8ced12216450
Sep 27 09:08:35 burischnitzel kernel: RBP: ffff8cecf7d81e38 R08: ffff9f524343fcad R09: 00000000000006fe
Sep 27 09:08:35 burischnitzel kernel: R10: 0000000000000008 R11: ffff9f524343fcad R12: ffff8cecf7d81e08
Sep 27 09:08:35 burischnitzel kernel: R13: ffff8cecf7d81e08 R14: ffff8cea72eb0540 R15: dead000000000100
Sep 27 09:08:35 burischnitzel kernel: FS:  0000000000000000(0000) GS:ffff8ced12200000(0000) knlGS:0000000000000000
Sep 27 09:08:35 burischnitzel kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 27 09:08:35 burischnitzel kernel: CR2: 000034b8490c9000 CR3: 000000035980a004 CR4: 00000000003606f0
Sep 27 09:08:35 burischnitzel kernel: Call Trace:
Sep 27 09:08:35 burischnitzel kernel:  iwl_mvm_async_handlers_wk+0xaa/0x140 [iwlmvm]
Sep 27 09:08:35 burischnitzel kernel:  process_one_work+0x1cf/0x370
Sep 27 09:08:35 burischnitzel kernel:  worker_thread+0x4a/0x3c0
Sep 27 09:08:35 burischnitzel kernel:  ? process_one_work+0x370/0x370
Sep 27 09:08:35 burischnitzel kernel:  kthread+0x118/0x130
Sep 27 09:08:35 burischnitzel kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Sep 27 09:08:35 burischnitzel kernel:  ret_from_fork+0x35/0x40
Sep 27 09:08:35 burischnitzel kernel: ---[ end trace 544d5d5df075debd ]---


This repeats a few times (2-4) and then it settles down.

WIFI works without any problems, though.

Best

Norbert

--
PREINING Norbert                               http://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
