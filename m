Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086B77CB5E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjHOK4r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjHOK4p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 06:56:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BC198C
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 03:56:43 -0700 (PDT)
Received: from [192.168.179.5] ([37.24.11.236]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZTyo-1qJAep2z6U-00WWKL; Tue, 15 Aug 2023 12:56:37 +0200
Message-ID: <3857b8d4-ba9d-7544-98c3-876b80a69bb4@online.de>
Date:   Tue, 15 Aug 2023 12:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH] wifi: cfg80211: fix cqm_config access race
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <20230813151828.ef56f5624c62.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
From:   Max Schulze <max.schulze@online.de>
In-Reply-To: <20230813151828.ef56f5624c62.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FtElOq7w0fJJMOQnZFuZwb8kNq8DznOSbUvY4U1wmxdOBxiistM
 50oALCAsgjnyd3K1wTOW2YMiN8JdvW/SUEP9+mZAwIp3OZwdzpOYqTEdbLlitBIpK5cgSbW
 g5s34z+1J2zk7cpAiJOdM3wtSr+HAfygfGIc9MbhtO+OkpWXwLqLxLKxeOEN4EPEmGZ2sWM
 Fwojm5j3taiopYWw6XLPA==
UI-OutboundReport: notjunk:1;M01:P0:Lmmai291UrY=;rkj+Q171B6Jb/xaa1Ev+2Gbmyqs
 FwCpshixh6cZKAWpA+GYE9ljifh1OXtOGlNAs7/d9tryPLpevn9qTx8ncrgUIa08UjXIVZDw8
 o5wmaHfhVi5RM6W+Lz7BSDiMsFjBkF8cut6z1a65vOcQbukorHxamI12exYLJl6GZ9K+IG1vh
 A1QMGPYPVSv3E9aRrnatN/hau31cEJPebvB8eKK/vg3eMPcll843bLvMlEc3OtRfp9QYxNQam
 74+P4ePAHE0saQ04yL26MrouwSE5iduHApIdaUV7YV5xupnwKMOQXjgIeWS07Oxf1kIiKIhVQ
 aa9BWvaqo5gxaB0nDjomL16JxxeHtSNIPgHES39QfAidi8BVi71U1fYAE8milsJimBupFdZwU
 YJH/G7HXno1RTJjrH7CX0a6tgssXjdQOAN+P8dyxXo8085wDMn+WxgaagmsI0KvzUtmAiXz0r
 kbxovPdzoLALhe+rQCk7KRA0XduPXBuRZIzwZAvWdoce1hR8xPqzOGi0PJ2y4ubVTaAWW70Ev
 tdt0e0Bmi+qXSINRKpuZkelC+H/mpCfPHALvOwcBucgugcIvyIeGrjJ1BF2dRBBbQsc1Ave+K
 yMsHMs2OUcgfbJN+Gc0abmvNT4u27bMQ9NjGFtp/XRNTZbpm9wMJZPG877JjkZewIAHx38SiC
 NuGl6KtYpTi1udly8ZP2YL/Qzom6bWcwyG879BbNH9LAlfyzo3piP7oIAXsfEjYxvj2JPCaUc
 3Pz0kB9uDerWSgTOJokg97tNE9tIksSVeItQsvBovTEAhXYPpqRaLdxWyuRtdUB7jSONLpGwI
 L5uoPuHBzsct+mHwI9bcSLhZf81s+X6aLPpgPBkJTWxRxWB5uJptfMRLEWAqAjOv8bNLTWqHg
 plptszCSoR8qKfA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

thanks for your patch.

While it works well in my lab setting, it crashes within minutes in the field. 

While the crashes look slightly different ("Unable to handle kernel pagign request"... descendant of is_swiotlb_active...) I think the notice beforehand is much more interesting: do you understand it?

: ------------[ cut here ]------------
: Voluntary context switch within RCU read-side critical section!
: WARNING: CPU: 0 PID: 319 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch+0x484/0x550
: Modules linked in: ov9281 rtc_pcf85063 regmap_i2c brcmfmac brcmutil v3d gpu_sched drm_shmem_helper cfg80211 gpio_keys i2c_mux_pinctrl i2c_mux vc4 rfkill raspberrypi_hwmon bcm2835_codec(C) bcm2835_v4l2(C) bcm2835_isp(C) bcm2835_unicam snd_soc_hdmi_codec v4l2_dv_timings bcm2835_mmal_vchiq(C) drm_display_helper rpivid_hevc(C) v4l2_fwnode v4l2_mem2mem videobuf2_vmalloc cec v4l2_async videobuf2_dma_contig i2c_brcmstb videobuf2_memops drm_dma_helper videobuf2_v4l2 i2c_bcm2835 drm_kms_helper snd_soc_core videobuf2_common videodev vc_sm_cma(C) snd_bcm2835(C) snd_compress snd_pcm_dmaengine snd_pcm snd_timer mc snd syscopyarea sysfillrect sysimgblt fb_sys_fops uio_pdrv_genirq nvmem_rmem uio drm drm_panel_orientation_quirks fuse backlight ip_tables x_tables ipv6
: CPU: 0 PID: 319 Comm: kworker/0:3 Tainted: G         C 6.1.45-v8-ged6bf58272ec #2
: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
: Workqueue: events brcmf_fweh_event_worker [brcmfmac]
: pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
: pc : rcu_note_context_switch+0x484/0x550
: lr : rcu_note_context_switch+0x484/0x550
: sp : ffffffc008d337c0
: x29: ffffffc008d337c0 x28: ffffff804765be00 x27: 000000000000001b
: x26: 0000000000000001 x25: 0000000000000000 x24: ffffff804765be00
: x23: ffffff804765be00 x22: 0000000000000000 x21: 0000000000000000
: x20: ffffffdcc58f4f00 x19: ffffff807fb5ff00 x18: 00000000fffffffc
: x17: 2e2e2e2e2e202020 x16: ffffffdcc53b9bb0 x15: 0000000000000020
: x14: ffffffdcc5c65358 x13: 216e6f6974636573 x12: 206c616369746972
: x11: 00000000000021c8 x10: 0000000000002180 x9 : ffffffdcc48fc5c4
: x8 : ffffffdcc5c0c788 x7 : ffffffdcc5c64788 x6 : 0000000000005538
: x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000027
: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff804765be00
: Call trace:
:  rcu_note_context_switch+0x484/0x550
:  __schedule+0xc0/0xa10
:  schedule+0x60/0x100
:  schedule_timeout+0xa0/0x1c0
:  brcmf_sdio_bus_txctl+0xcc/0x1f4 [brcmfmac]
:  brcmf_proto_bcdc_msg+0xd4/0xf0 [brcmfmac]
:  brcmf_proto_bcdc_set_dcmd+0x88/0x124 [brcmfmac]
:  brcmf_fil_cmd_data+0x84/0x180 [brcmfmac]
:  brcmf_fil_iovar_data_set+0x11c/0x160 [brcmfmac]
:  brcmf_cfg80211_set_cqm_rssi_range_config+0xe4/0x130 [brcmfmac]
:  cfg80211_cqm_rssi_update+0x120/0x3f0 [cfg80211]
:  cfg80211_cqm_rssi_notify+0x78/0x1b4 [cfg80211]
:  brcmf_notify_rssi+0x10c/0x1b0 [brcmfmac]
:  brcmf_fweh_call_event_handler+0x40/0xa0 [brcmfmac]
:  brcmf_fweh_event_worker+0x1e4/0x4e0 [brcmfmac]
:  process_one_work+0x1dc/0x450
:  worker_thread+0x154/0x450
:  kthread+0x104/0x110
:  ret_from_fork+0x10/0x20
: ---[ end trace 0000000000000000 ]--- 
