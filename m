Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685FD2DD21F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLQN0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 08:26:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37016 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727160AbgLQN0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 08:26:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kptHz-003JCS-M9; Thu, 17 Dec 2020 15:25:52 +0200
Message-ID: <bd0157de19815f7e7d8f009539326fadfee61089.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 17 Dec 2020 15:25:50 +0200
In-Reply-To: <d70a4e97-48e0-a4a4-40c2-77a7557db2ce@samsung.com>
References: <20201129153055.1971298-1-luca@coelho.fi>
         <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
         <CGME20201216102006eucas1p18cede9af63b9ad4aed211ecf47c9aa8f@eucas1p1.samsung.com>
         <d70a4e97-48e0-a4a4-40c2-77a7557db2ce@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-16 at 11:20 +0100, Marek Szyprowski wrote:
> Hi Luca,

Hi Marek,


> On 29.11.2020 16:30, Luca Coelho wrote:
> > From: Ilan Peer <ilan.peer@intel.com>
> > 
> > When custom regulatory was set, only the channels setting was updated, but
> > the regulatory domain was not saved. Fix it by saving it.
> > 
> > Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> This patch landed recently in linux-next as commit beee24695157 
> ("cfg80211: Save the regulatory domain when setting custom regulatory"). 
> It triggers the following warning on all boards I have, which use 
> Broadcom chips. Here is an example from Raspberry Pi4:
> 
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip 
> BCM4345/6
> brcmfmac mmc1:0001:1: Direct firmware load for 
> brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt failed with error -2
> brcmfmac mmc1:0001:1: Falling back to sysfs fallback for: 
> brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip 
> BCM4345/6
> brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-11), 
> device may have limited channels available
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Mar  1 2015 
> 07:29:38 version 7.45.18 (r538002) FWID 01-6a2c8ad4
> Bluetooth: hci0: BCM: chip id 107
> Bluetooth: hci0: BCM: features 0x2f
> Bluetooth: hci0: BCM4345C0
> Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
> 
> =============================
> WARNING: suspicious RCU usage
> 5.10.0-next-20201215+ #9962 Not tainted
> -----------------------------
> net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by kworker/1:1/32:
>   #0: ffff000003405738 ((wq_completion)events){+.+.}-{0:0}, at: 
> process_one_work+0x200/0x728
>   #1: ffff80001321bdc0 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, 
> at: process_one_work+0x200/0x728
> 
> stack backtrace:
> CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.10.0-next-20201215+ #9962
> Hardware name: Raspberry Pi 4 Model B (DT)
> Workqueue: events request_firmware_work_func
> Call trace:
>   dump_backtrace+0x0/0x1d0
>   show_stack+0x14/0x60
>   dump_stack+0xf4/0x15c
>   lockdep_rcu_suspicious+0xd4/0xf8
>   get_wiphy_regdom+0x6c/0x70 [cfg80211]
>   wiphy_apply_custom_regulatory+0x80/0xc8 [cfg80211]
>   brcmf_cfg80211_attach+0xb44/0x1330 [brcmfmac]
>   brcmf_attach+0x174/0x4b8 [brcmfmac]
>   brcmf_sdio_firmware_callback+0x670/0x7c8 [brcmfmac]
>   brcmf_fw_request_done+0x7c/0x100 [brcmfmac]
>   request_firmware_work_func+0x4c/0xd8
>   process_one_work+0x2a8/0x728
>   worker_thread+0x48/0x460
>   kthread+0x134/0x160
>   ret_from_fork+0x10/0x18
> 
> Reverting this patch on top of linux next-20201215 hides this issue.

This is indeed an issue.  Now syzbot also reported it.  We currently
have an issue with our test machinery that is not enabling lockdep and
other lock checks...

We'll fix this asap.

--
Cheers,
Luca.

