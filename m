Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78952779E96
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Aug 2023 11:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHLJf0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Aug 2023 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLJfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Aug 2023 05:35:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF459213B;
        Sat, 12 Aug 2023 02:35:26 -0700 (PDT)
Received: from [192.168.151.20] ([217.224.112.34]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBlpC-1qehik3llc-00CEAb; Sat, 12 Aug 2023 11:35:11 +0200
Message-ID: <f8d103d5-9378-f42c-7d1a-0bda143d656e@online.de>
Date:   Sat, 12 Aug 2023 11:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wifi: nl80211: avoid NULL-ptr deref after
 cfg80211_cqm_rssi_update
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
 <eb944f1f-8d7c-5057-35f2-34812907e4d1@online.de>
 <55a6644c62e7c955d6dacd9a10f945a199f47277.camel@sipsolutions.net>
From:   Max Schulze <max.schulze@online.de>
In-Reply-To: <55a6644c62e7c955d6dacd9a10f945a199f47277.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SctWYNZKMiEBia5fI4aX9g0YImk1yAqd9wnmAVzHppkN/cbLBCE
 8xIZzsYKeRupEYoMfDhOAMP6gI3VL4aKcCENIKuJxsNLz/9vzV1wqxJGMUPl8J6KPTLNevL
 g/EzgbHbaUniLj7/ei6vQWQ2YWH3o1PGpZxQAq0jOTDoxSNL/5nUMoKTxfXs39NO274HXUB
 nO7QNx5O8pg/7cQdau9fQ==
UI-OutboundReport: notjunk:1;M01:P0:PDCZtYgO6+A=;XClgg2O32vNwW54NjKsLRb06+g9
 QMa3HtOHWCE9RrchaYp4jXAItUPAZ20s50Hr0mRxw6d6S9fOkMDsO3s4qOLWdtkb2fSQYJkuY
 CqDx8CFFlv9Z8NqMe3iUqsgP+1C0KCrczL5bSjVWadsPJ4Phsv9+kkXbwxHb/RncK5ZjjDkdE
 SuJIZNkBNShsJzpbf3Vf7MyDzoZ7J+8nPnMpH9H2wjWQOenvsJUgaC6ZVLH0wvJepa56RtC/g
 5OneRbucslaraWKZwcC0sCtiiSXcxnkNHXBnWJgu7YlzEcM098nZBLEjrZSYJ58VjvSemZCT7
 kFukPg//tiaxJN39DS50idoe2Gkzb1Zcp24fTegCfQT0/3cY2jKX91LOksVmtk8OUvZV95sT8
 ZNycSQP1KTmE/amvd+HLRi+pjbR9tB74eSHHicYVINYXfT5zeRtHZZHKymz6kB//9PrXX0AJW
 ySfwu5P+AbWh82DvueCEUDmB5oQGG9YV+XsR8TuN4KM1o+Wwyp9317lTXf9PY/S30mrzObX+q
 ZAOhIftWM8UWtpB6aNvZlRK5Ht7zmL8BWv0TOo6EfGrKx0FalVvq86dH87WJhJDWuGtwDkGZf
 FcmjcCFlVa2NrsMlF1gr9hPQXUudwxvYn6tBhdDddWxCeC0Vdi5eyUV3gcR0quAwLiFbHUww5
 4/4GB1cz0zAUf1ZsOusuHBTEtlSrurYzECllXOw+II6SPA971Tc3pAQaeACeyrEBjFBDgWZNc
 zJDWuZ5TAwxDcYWF2VJLr2uC2xsbaOvM0n0iIET19OGEqH9J9QmZfDa39DFlAx0LA4knT2bNR
 Y3X7KtkEM16hn6JrSn5jCHBiWmIFHpWNrbmIwI+/fKdwbal4dI6ByfNavuo64l9UOgYMkv+Ze
 JomCzSns1+ziSTESeor8NnezjyuGzmVw5tQM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Am 11.08.23 um 11:54 schrieb Johannes Berg:
> On Fri, 2023-08-11 at 09:30 +0200, Max Schulze wrote:
>> In cfg80211_cqm_rssi_notify, when calling cfg80211_cqm_rssi_update, this might free
>> the wdev->cqm_config . Check for this when it returns.
> 
> That doesn't seem right? How does cfg80211_cqm_rssi_update() free it?
> 


You are probably right, that it doesn't. I amended the original bug report where I have a trace of the free and it is not a descendant of _rssi_update().



>> This has been observed on brcmfmac, when a RSSI event is generated just right
>> after disconnecting from AP. Then probing for STA details returns nothing, as
>> evidenced i.e. by
>> "ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52".
> 
> I think the issue then isn't that this frees it but rather than a free
> of it races with the reporting?


I do not understand what you mean. I think there is a race, yes, somewhere else it get's freed, and when we access it, there is the null-ptr-deref.
The GET STA INFO failed is just the expected answer from the chip, because it currently is not associated with any station.


> 
>> --- a/net/wireless/nl80211.c
>> +++ b/net/wireless/nl80211.c
>> @@ -19088,7 +19088,7 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
>>  
>>  		cfg80211_cqm_rssi_update(rdev, dev);
>>  
>> -		if (rssi_level == 0)
>> +		if (rssi_level == 0 && wdev->cqm_config)
>>  			rssi_level = wdev->cqm_config->last_rssi_event_value;
>>
> 
> But if it's a race, then this isn't actually going to really fix the
> issue, rather it just makes it (much) less likely.
> 

You have been right with your prediction. It made it around ~15x less likely but I have recorded a trace. It just has the null-ptr somewhere else.

> Since we can probably neither lock the wdev here nor require calls to
> this function with wdev lock held, it looks like we need to protect the
> pointer with RCU instead?
> 

I do not know how to do that and need help.

Max

[this is with my patch some lines above, no more crashes in _rssi_notify, but now somewhere else ].

13:15:03: brcmfmac: brcmf_is_linkdown Processing link down
13:15:03: brcmfmac: brcmf_notify_connect_status Linkdown
13:15:03: brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr xx:xx:xx:xx:00:50
13:15:03: brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0
13:15:03: brcmutil: event payload, len=12
13:15:03: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00              ............
13:15:03: brcmfmac: brcmf_notify_rssi LOW rssi=0
13:15:03: brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=rssi_event, len=16
13:15:03: Unable to handle kernel NULL pointer dereference at virtual address 000000000000000c
13:15:03: brcmutil: data
13:15:03: Mem abort info:
13:15:03: 00000000: 00 00 00 00 03 00 00 7f 00 00 00 00 00 00 00 00  ................
13:15:03:   ESR = 0x0000000096000005
13:15:03:   EC = 0x25: DABT (current EL), IL = 32 bits
13:15:03:   SET = 0, FnV = 0
13:15:03:   EA = 0, S1PTW = 0
13:15:03:   FSC = 0x05: level 1 translation fault
13:15:03: Data abort info:
13:15:03:   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
13:15:03:   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
13:15:03:   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
13:15:03: user pgtable: 4k pages, 39-bit VAs, pgdp=00000000456cf000
13:15:03: [000000000000000c] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
13:15:03: Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
13:15:03: Modules linked in: brcmfmac_wcc vc4 brcmfmac snd_soc_hdmi_codec snd_soc_core snd_pcm_dmaengine snd_pcm cfg80211 rpivid_hevc(C) bcm2835_isp(C) snd_timer bcm2835_mmal_vchiq(C) snd videobuf2_dma_contig videobuf2_memops v4l2_mem2mem xt_tcpudp rtc_pcf85063 nft_compat regmap_i2c nf_tables videobuf2_v4l2 v3d videodev drm_display_helper drm_shmem_helper nfnetlink drm_dma_helper gpu_sched i2c_mux_pinctrl i2c_mux gpio_keys drm_kms_helper raspberrypi_hwmon rfkill hid_microsoft joydev i2c_brcmstb ff_memless brcmutil i2c_bcm2835 videobuf2_common vc_sm_cma(C) mc cec nvmem_rmem uio_pdrv_genirq uio drm fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
13:15:04: CPU: 1 PID: 57 Comm: kworker/1:2 Tainted: G         C         6.5.0-rc5-v8-g963e8f68ce3b #4
13:15:04: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
13:15:04: Workqueue: events brcmf_fweh_event_worker [brcmfmac]
13:15:04: pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
13:15:04: pc : cfg80211_cqm_rssi_update (/home/r/linux/net/wireless/nl80211.c:12838) cfg80211
13:15:04: lr : cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19088) cfg80211
13:15:04: sp : ffffffc08060baf0
13:15:04: x29: ffffffc08060baf0 x28: ffffff8052b798f0 x27: ffffff8052b798a0
13:15:04: x26: ffffff8055d4c8c0 x25: ffffff8055d4ca68 x24: ffffff8055d4c3c0
13:15:04: x23: ffffff8044a52008 x22: 0000000000000000 x21: ffffff8055d4c000
13:15:04: x20: ffffff8044a63000 x19: ffffff8044a52008 x18: 00000000fffffffe
13:15:04: x17: 2e2e2e2e2e202020 x16: ffffffddb73c9498 x15: 0000000000000020
13:15:04: x14: 0000000000000000 x13: 303d697373722057 x12: 4f4c20697373725f
13:15:04: x11: fffffffffffe39f8 x10: ffffff804018c700 x9 : ffffffdd39d20660
13:15:04: x8 : 000000005108ccd0 x7 : 0000000000000000 x6 : 000000005108ccd0
13:15:04: x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
13:15:04: x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000004
13:15:04: Call trace:
13:15:04: cfg80211_cqm_rssi_update (/home/r/linux/net/wireless/nl80211.c:12838) cfg80211
13:15:04: cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19088) cfg80211
13:15:04: brcmf_notify_rssi (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6651) brcmfmac
13:15:04: brcmf_fweh_call_event_handler (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:116) brcmfmac
13:15:04: brcmf_fweh_event_worker (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:268) brcmfmac
13:15:04: process_one_work (/home/r/linux/./arch/arm64/include/asm/jump_label.h:21 /home/r/linux/./include/linux/jump_label.h:207 /home/r/linux/./include/trace/events/workqueue.h:108 /home/r/linux/kernel/workqueue.c:2602) 
13:15:04: worker_thread (/home/r/linux/./include/linux/list.h:292 /home/r/linux/kernel/workqueue.c:2749) 
13:15:04: kthread (/home/r/linux/kernel/kthread.c:389) 
13:15:04: ret_from_fork (/home/r/linux/arch/arm64/kernel/entry.S:854) 
13:15:04: Code: f941b264 0a020062 93407c45 8b22c883 (b9400c63)
All code
========
   0:	f941b264 	ldr	x4, [x19, #864]
   4:	0a020062 	and	w2, w3, w2
   8:	93407c45 	sxtw	x5, w2
   c:	8b22c883 	add	x3, x4, w2, sxtw #2
  10:*	b9400c63 	ldr	w3, [x3, #12]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	b9400c63 	ldr	w3, [x3, #12]
13:15:04: ---[ end trace 0000000000000000 ]---
13:15:04: brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=qtxpower, len=4, err=0
13:15:04: brcmutil: data
