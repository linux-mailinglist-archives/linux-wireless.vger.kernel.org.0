Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DA36C52B3
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCVRk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCVRkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:40:55 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139715F6C5;
        Wed, 22 Mar 2023 10:40:50 -0700 (PDT)
Received: from [IPV6:2a02:8428:2a4:1a01:f89e:1673:1a35:a89c] (unknown [IPv6:2a02:8428:2a4:1a01:f89e:1673:1a35:a89c])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 35B8119F57C;
        Wed, 22 Mar 2023 18:40:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1679506847;
        bh=ZLySjh6t81HhbtN2+C2divJSSHBwsdJMIKhcneYTMAM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=reYZIEx6Yxupf0uoxOi+sKYyZ/QXO4JQVlaBVld+kJ3AgBXc3SAY/Qr5xVp0Yc+0s
         3nxBHnVmqdTU+0yFY0bXAwv2lK3/xf7NX/nUKU7P/7nyxOtHLfeprBROKa6rrrhpPZ
         +vdTBpFq2N73WUUziWHtU0A8GKVU2QG+suzWlAyOUwWNHPSDTMfFRWeTqlc94mtj3H
         WX0Zh8HNblkgixQZAwzSnLtE2kIlmI/89xIRvnxHCz2fCG2Wy2KifDGrNJmf51cV3T
         fy60SpZ++IOmOSFtgeh4m6IJeU8DjDBhIx1pkQZEoAeKRHRjtdQwoMx/oLIvPCkty2
         YDOmHdHpGWSlA==
Message-ID: <31dea9bf-63ef-c6db-b206-8afac960fd10@free.fr>
Date:   Wed, 22 Mar 2023 18:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: fr, en-US
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
 <a215e398-2c49-19d2-0730-5e8c51df1ed9@free.fr>
 <CA+8PC_du5dMwkmAshG2mM9TdeJft5aeAbEdDp0_q3Rxdvpq4MQ@mail.gmail.com>
 <f14407f1-e16f-0074-6e29-c597754ae617@free.fr>
 <CA+8PC_dFTvv9VtY9jBWLLwSoQzGxQd57zWMsnN6amddop4Yw-g@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CA+8PC_dFTvv9VtY9jBWLLwSoQzGxQd57zWMsnN6amddop4Yw-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/03/2023 18:21, Franky Lin wrote:

> On Wed, Mar 8, 2023 at 4:48 AM Marc Gonzalez wrote:
>>
>> On 08/03/2023 00:15, Franky Lin wrote:
>>
>>> On Tue, Mar 7, 2023 at 6:40 AM Marc Gonzalez wrote:
>>>
>>>> Through the SDIO bus, the WiFi chip reports 0xaae7 (i.e. 43751)
>>>> hence the /sys/bus/sdio/devices output above.
>>>>
>>>> sdio_read_func_cis() -> sdio_read_cis() which sets
>>>> func->vendor/func->device to 2d0/aae7
>>>>
>>>>
>>>> But when brcmf_chip_recognition() calls ci->ops->read32()
>>>> i.e. brcmf_sdio_buscore_read32()
>>>> [ vs brcmf_sdiod_readl() in brcmf_sdio_probe_attach() ]
>>>>
>>>> [    1.177283] brcmfmac: F1 signature read @0x18000000=0x1042aae8
>>>> [    1.182912] found AXI chip: BCM43752/2
>>>> [    1.186384] BCM43752/2: chip=aae8 rev=2 type=1
>>>>
>>>> Here it reports 0xaae8 (i.e. 43752)
>>>>
>>>> Why the discrepancy?
>>>> Can it cause issues?
>>>> (Sometimes, the whole SDIO bus doesn't probe at boot.
>>>> I am still investigating these intermittent problems.)
>>>>
>>>> Should I use 43751 or 43752 firmware...?
>>>
>>> This question should be answered by the Cypress/Infineon folks but
>>> unfortunately they have been quiet for a long time. In general we use
>>> the id read from 0x18000000 to decide which firmware to load. But be
>>> aware that the rev also matters. There are some examples in
>>> brcmf_sdio_fwnames table that the different firmware name can be
>>> derived from the same chip common id but different rev.
>>>
>>> However sdio device enumeration happens before firmware download so
>>> the intermittent problem you are facing probably is not related to
>>> firmware version.
>>
>> When the host sends the equivalent of an "identify yourself" message
>> on the SDIO bus, doesn't the reply come from the WiFi device?
>> Why would the device reply 0xaae7 instead of 0xaae8?
>>
>> In other words, who is replying 0xaae7?
> 
> The enumeration response is done by the HW sdio core on the chip.
> No software involved.

Hello Franky et al,

I have made some progress understanding some issues.
But I remain baffled by many others :(

At my disposal, two S905X2 boards with SDIO-based brcm modules
(according to the labels on the boards) :

Board A embeds "AP6398SR3"  which identifies as
	x vendor=2d0 dev=4359 over sdio_read_cis
	x brcmfmac: F1 signature read @0x18000000=0x17294359
	x brcmfmac: BCM4359/9: chip=4359 rev=9

Board B embeds "AP6398SR32" which identifies as
	x vendor=2d0 dev=aae7 over sdio_read_cis
	x F1 signature read @0x18000000=0x1042aae8
	x brcmfmac: BCM43752/2: chip=aae8 rev=2

(I still do not understand why AP6398SR32 on board B
identifies as AAE7 on the SDIO bus, but as AAE8 via MMIO.
That does not make sense to me.)

On board A, WiFi module probes correctly with the default timing.
On board B, WiFi module requires waiting 10 ms more,
otherwise mmc_send_io_op_cond() (which sends CMD5) times out,
and the mmc core assumes that there is no card in the "slot".

Using the same firmware files in mainline that vendor's kernel uses,
WiFi on board A works as expected.
WiFi on board B logs a scan error (-52) every second,
and eventually panics the kernel.

NB: using the vendor's kernel, both modules work as expected.


[ 1033.293100] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1033.293130] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1034.304785] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1034.304811] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1035.316452] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1035.316480] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1036.328251] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1036.328289] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1037.340004] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1037.340030] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1038.351667] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1038.351692] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1039.363331] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1039.363357] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1040.374874] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1040.374900] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1041.386538] ieee80211 phy0: brcmf_run_escan: error (-52)
[ 1041.386563] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)
[ 1042.398166] SError Interrupt on CPU1, code 0x00000000bf000000 -- SError
[ 1042.398175] CPU: 1 PID: 61 Comm: kworker/u9:0 Not tainted 6.2.0-rc8 #431
[ 1042.398181] Hardware name: SEI Robotics SEI510 (DT)
[ 1042.398184] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker
[ 1042.398201] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1042.398206] pc : brcmf_sdio_dataworker+0x2090/0x23d0
[ 1042.398213] lr : brcmf_sdio_dataworker+0x1fe8/0x23d0
[ 1042.398219] sp : ffff80000a1d3c60
[ 1042.398220] x29: ffff80000a1d3c70 x28: 0000000000000000 x27: ffff8000088ac558
[ 1042.398227] x26: ffff800009ed1ab0 x25: ffff000004108000 x24: ffff80000b4f1000
[ 1042.398233] x23: ffff800009f25b68 x22: 00000000000000a8 x21: 00000000000000e2
[ 1042.398238] x20: 000000000000000c x19: ffff000000b3a000 x18: 0000000000000000
[ 1042.398244] x17: 0000000000000000 x16: 0000000000000000 x15: d099d095d090d08c
[ 1042.398250] x14: 0000000000002912 x13: ffff000067b5c400 x12: ffff000067b8db00
[ 1042.398256] x11: ffff000067b8db00 x10: 0000000000000000 x9 : 0000000000000000
[ 1042.398262] x8 : 000000000000005a x7 : ffff800009cc3400 x6 : 0000000000000200
[ 1042.398268] x5 : 0000000000002a10 x4 : 00000000000000d6 x3 : 0000000000000200
[ 1042.398273] x2 : 0000000000000002 x1 : 0000000000000008 x0 : ffff000000b39800
[ 1042.398280] Kernel panic - not syncing: Asynchronous SError Interrupt
[ 1042.398283] CPU: 1 PID: 61 Comm: kworker/u9:0 Not tainted 6.2.0-rc8 #431
[ 1042.398287] Hardware name: SEI Robotics SEI510 (DT)
[ 1042.398289] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker
[ 1042.398296] Call trace:
[ 1042.398298]  dump_backtrace.part.0+0xe0/0xf0
[ 1042.398307]  show_stack+0x18/0x30
[ 1042.398313]  dump_stack_lvl+0x68/0x84
[ 1042.398320]  dump_stack+0x18/0x34
[ 1042.398324]  panic+0x184/0x344
[ 1042.398330]  nmi_panic+0xac/0xb0
[ 1042.398335]  arm64_serror_panic+0x6c/0x80
[ 1042.398339]  do_serror+0x58/0x60
[ 1042.398343]  el1h_64_error_handler+0x30/0x50
[ 1042.398348]  el1h_64_error+0x64/0x68
[ 1042.398352]  brcmf_sdio_dataworker+0x2090/0x23d0
[ 1042.398357]  process_one_work+0x1cc/0x320
[ 1042.398363]  worker_thread+0x14c/0x450
[ 1042.398367]  kthread+0xfc/0x100
[ 1042.398371]  ret_from_fork+0x10/0x20
[ 1042.398378] SMP: stopping secondary CPUs
[ 1042.398383] Kernel Offset: 0x80000 from 0xffff800008000000
[ 1042.398385] PHYS_OFFSET: 0x0
[ 1042.398387] CPU features: 0x00000,01200100,0000420b
[ 1042.398390] Memory Limit: none
[ 1042.608339] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---


Has anyone seen a similar panic on a SDIO-based WiFi module?


I was wondering:
Has anyone evaluated an X2/X3 meson board with a PCIe (not SIO) WiFi module?
Neil told PCIe is expected to be less CPU-intensive.

Has anyone evaluated an SDIO-based board that doesn't require the
amlogic,dram-access-quirk?

Regards

