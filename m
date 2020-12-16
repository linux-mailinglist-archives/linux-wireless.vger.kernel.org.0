Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388962DBE89
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 11:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgLPKVH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 05:21:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40151 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLPKVG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 05:21:06 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201216102014euoutp017f3fe38c4491fe670abc825b87975d5b~RKy0amWs31373213732euoutp019
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 10:20:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201216102014euoutp017f3fe38c4491fe670abc825b87975d5b~RKy0amWs31373213732euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608114014;
        bh=1Gx8vzp7rQbU9DJ60jVDyMJ+0S1JLQN22GV+2dToTE0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SQ6iqjbaDX7JsaDQy9yYcGShqN2D57TbRFJZneY9CYfrcgnQu80K6TAkCKb5kIiLu
         ak3L1BaPEu+tudxEx9n41o7EfYhOcwKdRtiBCy0s7m1TPvsDr0Rz/ez3VYSLrtoiWR
         w+0jJNdiZ6XpHZSvlg58H10Z1JWIslYr1WhgU02I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201216102007eucas1p28e806d403639dfba0eb6b579d60c3317~RKytpSAbg3146031460eucas1p25;
        Wed, 16 Dec 2020 10:20:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.C7.44805.75FD9DF5; Wed, 16
        Dec 2020 10:20:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201216102006eucas1p18cede9af63b9ad4aed211ecf47c9aa8f~RKytD2tRu3172331723eucas1p1B;
        Wed, 16 Dec 2020 10:20:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201216102006eusmtrp256682a12f234a72019d95a45faa59e98~RKytCj4W-1650616506eusmtrp2x;
        Wed, 16 Dec 2020 10:20:06 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-10-5fd9df579188
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.83.16282.65FD9DF5; Wed, 16
        Dec 2020 10:20:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201216102006eusmtip1fa9e10922d1d9d7d0b7c3a4630b505bf~RKysvtuBS1993719937eusmtip1G;
        Wed, 16 Dec 2020 10:20:06 +0000 (GMT)
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d70a4e97-48e0-a4a4-40c2-77a7557db2ce@samsung.com>
Date:   Wed, 16 Dec 2020 11:20:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzned3w+zfjDZad4rL4uOETi8WbFXfY
        LWacn8XuwOzxcNdsNo/+3m0sHp83yQUwR3HZpKTmZJalFunbJXBl9P/8zlRwT6ri6IlbTA2M
        /8S6GDk5JARMJL40r2bvYuTiEBJYwSixavJnRgjnC6PEs//zmCCcz4wSy55sY4ZpubP+BStE
        YjmjxLeT79ggnI+MEv/vL2YDqRIWSJBoW/kYrENEwFridutEdhCbWUBJ4tGy+2A2m4ChRNfb
        LrB6XgE7iXn37oHVswioSuzZ8YoFxBYVSJJY3/UDqkZQ4uTMJ2BxToFUiTMHp0HNlJdo3jqb
        GcIWl7j1ZD7Y2RICazkkHrReYYU420Xi5eUlLBC2sMSr41vYIWwZif87YRqaGSUenlvLDuH0
        MEpcbprBCFFlLXHn3C+gMziAVmhKrN+lDxF2lLj/cxc7SFhCgE/ixltBiCP4JCZtm84MEeaV
        6GgTgqhWk5h1fB3c2oMXLjFPYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5NTy02ykst1ytO
        zC0uzUvXS87P3cQITCWn/x3/soNx+auPeocYmTgYDzFKcDArifAmHLgZL8SbklhZlVqUH19U
        mpNafIhRmoNFSZw3acuaeCGB9MSS1OzU1ILUIpgsEwenVANTIr/nqU7Xss1v3zL+f8gsls0+
        +dHvrdcefxALX51qZeOsw1TkOrNTXKE9SXyRid36DqH21UsCnirxvlid7f+Ykf2WoFiN46mW
        ilkrk06oppod6+AwrvBkzkste/DM4u708sDYjOkH/zTM5tUzk2e6H7B1ikC15dEjK7VsN/6a
        4mCVqDhnKbcug8XtiIz/p+7P2LTBOFbrYPQDdd3eqti9i6/5/FSddkdNc2trjOMt5e33Yttr
        t9q+vDXTO/npHe615vfmbmziFV2wrL36683ulfbVDw5ebGfcus8mJMwiNiVBzvfW/7VTOdZe
        OKMuFHL+8JTQ/+9/vuz5vPtO/dcmuxCVrEgH6+Aq3jdmXfVKLMUZiYZazEXFiQBunFiIlAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7ph92/GGzzdo2HxccMnFos3K+6w
        W8w4P4vdgdnj4a7ZbB79vdtYPD5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DL6P/5nangnlTF0RO3mBoY/4l1MXJySAiYSNxZ/4K1i5GL
        Q0hgKaPE7L997BAJGYmT0xpYIWxhiT/Xutggit4zStyfPA0sISyQING28jEziC0iYC1xu3Ui
        WDOzgJLEo2X32SEaJjBKNH3ezQaSYBMwlOh62wVm8wrYScy7dw+smUVAVWLPjlcsXYwcHKIC
        SRJnTwtClAhKnJz5hAXE5hRIlThzcBrUfDOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfss
        JC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmDkbDv2c8sOxpWvPuodYmTi
        YDzEKMHBrCTCm3DgZrwQb0piZVVqUX58UWlOavEhRlOgdyYyS4km5wNjN68k3tDMwNTQxMzS
        wNTSzFhJnNfkyJp4IYH0xJLU7NTUgtQimD4mDk6pBqaoppAl52wW+6y7ZZInf+7Vqhojxvl6
        W61T1/Oqdcpuyk1i/10UEWe6pqmmxHf/c/c/MwL45IR1C33uVd7t3Zqw6VLkGgPf0CMLhW3v
        X/Had8T7dn1VuHVVyBmJ+C37NBq3J35n2reqRHbWseczOf395QNqjd77X+vVn7c45cm1zecX
        WCo8ev31VZyjn3cOe6T6GckjNy6dyutcvjdpRsEZ9rey9892/TSb9mxHrVjNilM3zpVUT5RO
        ZL68a5o5i/CH+XJGl6R7mrq5+rWnXD544nD8//db8pZq+/YxPC4XdLI78L7WXWPzdrNvzv2d
        FocEjXVz49xc+ie7ut6VmXfsQlHtkVypYJP5PXcXSiuxFGckGmoxFxUnAgCWhllNJQMAAA==
X-CMS-MailID: 20201216102006eucas1p18cede9af63b9ad4aed211ecf47c9aa8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201216102006eucas1p18cede9af63b9ad4aed211ecf47c9aa8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201216102006eucas1p18cede9af63b9ad4aed211ecf47c9aa8f
References: <20201129153055.1971298-1-luca@coelho.fi>
        <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
        <CGME20201216102006eucas1p18cede9af63b9ad4aed211ecf47c9aa8f@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luca,

On 29.11.2020 16:30, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
>
> When custom regulatory was set, only the channels setting was updated, but
> the regulatory domain was not saved. Fix it by saving it.
>
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

This patch landed recently in linux-next as commit beee24695157 
("cfg80211: Save the regulatory domain when setting custom regulatory"). 
It triggers the following warning on all boards I have, which use 
Broadcom chips. Here is an example from Raspberry Pi4:

cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip 
BCM4345/6
brcmfmac mmc1:0001:1: Direct firmware load for 
brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt failed with error -2
brcmfmac mmc1:0001:1: Falling back to sysfs fallback for: 
brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt
brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip 
BCM4345/6
brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-11), 
device may have limited channels available
brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Mar  1 2015 
07:29:38 version 7.45.18 (r538002) FWID 01-6a2c8ad4
Bluetooth: hci0: BCM: chip id 107
Bluetooth: hci0: BCM: features 0x2f
Bluetooth: hci0: BCM4345C0
Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch

=============================
WARNING: suspicious RCU usage
5.10.0-next-20201215+ #9962 Not tainted
-----------------------------
net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by kworker/1:1/32:
  #0: ffff000003405738 ((wq_completion)events){+.+.}-{0:0}, at: 
process_one_work+0x200/0x728
  #1: ffff80001321bdc0 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, 
at: process_one_work+0x200/0x728

stack backtrace:
CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.10.0-next-20201215+ #9962
Hardware name: Raspberry Pi 4 Model B (DT)
Workqueue: events request_firmware_work_func
Call trace:
  dump_backtrace+0x0/0x1d0
  show_stack+0x14/0x60
  dump_stack+0xf4/0x15c
  lockdep_rcu_suspicious+0xd4/0xf8
  get_wiphy_regdom+0x6c/0x70 [cfg80211]
  wiphy_apply_custom_regulatory+0x80/0xc8 [cfg80211]
  brcmf_cfg80211_attach+0xb44/0x1330 [brcmfmac]
  brcmf_attach+0x174/0x4b8 [brcmfmac]
  brcmf_sdio_firmware_callback+0x670/0x7c8 [brcmfmac]
  brcmf_fw_request_done+0x7c/0x100 [brcmfmac]
  request_firmware_work_func+0x4c/0xd8
  process_one_work+0x2a8/0x728
  worker_thread+0x48/0x460
  kthread+0x134/0x160
  ret_from_fork+0x10/0x18

Reverting this patch on top of linux next-20201215 hides this issue.

I compiled kernel for arm64 with defconfig with some additional options 
(I left only those that might be relevant to this issue):

./scripts/config --set-val CMA_SIZE_MBYTES 96 -e PROVE_LOCKING -e 
DEBUG_ATOMIC_SLEEP -e COMPILE_TEST -e PM_DEBUG -e PM_ADVANCED_DEBUG -e 
CONFIG_BRCMFMAC_PCIE

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

