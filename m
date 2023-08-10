Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019DB777309
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHJIfE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHJIfD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 04:35:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D41BFA;
        Thu, 10 Aug 2023 01:35:00 -0700 (PDT)
Received: from [192.168.151.20] ([79.229.37.11]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mw8gc-1pc3az2ojc-00s3sv; Thu, 10 Aug 2023 10:34:45 +0200
Message-ID: <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
Date:   Thu, 10 Aug 2023 10:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: BCM43455: brcmf_notify_rssi / cfg80211_cqm_rssi_notify : Unable
 to handle kernel NULL pointer dereference (RSSI notification after station
 disconnect?)
Content-Language: en-US
From:   Max Schulze <max.schulze@online.de>
To:     Arend van Spriel <aspriel@gmail.com>,
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
In-Reply-To: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:04Z8zWOCBNtTpSYgpbJWvHmbBdhi9qCfIshMW4AC+cpRInkePHh
 Hi6ruIRr03JtioPghk2RZ1lQeK0zjBcqAG8T7+X2uf7WvfN1B2Y1165UMFrdSNMWZBaJUoj
 N10lc6Gi4bNjkTYKMt3qVQYPVVsA6/QmubKNLV5grZv+VdeKu506jbiS6AM9/4iDFqP/Bnn
 JWEibu/Z6F5pP0QOAhkPw==
UI-OutboundReport: notjunk:1;M01:P0:EKjTu79vNGA=;nRmMiLg5aw2RRJfOBvupKmHcqs+
 bxgD6uMhmfen2qjx+sD7RdtmqMQKiBQ/FjvHpqSkOHlT0zuqnD6IDzdo2DsM+KERNEweySUC5
 UgxZG3l2gf8+zxqKkkN0KwG0qwGV3yU1tqZUKq0lnRHkko/FsDeECm5Mo/LmjONgNWU7vmht/
 mP5K838Xuiqlm6r+Fh+TCmyq7ELDnZ3TQaVQknmx/zk4jYYKJlzY+vlE2XnvS5bjg3QWa+w4A
 QhWKijMqwUEyHzLh3q7uWWgtlADNlH9epnPkf3Z0dpoYceFFG0Mb8NmmO0sN5ovkUIpQt5DBP
 uzolo9Cl3Cr666/LMYNIOlxqkZNkhO/P31q+vHRG/PAdINIe/zk5HglXREoBnRPnxLJZLK0f9
 roGBixXVHIf0OpSUzHGRdn7zYgmE96Cqe0i8pTRZ0eHXr90+XX/y0IJgGidc5IqeBOJxMsjkF
 INxkRvJTykHou4e4XwyaP2IwqDizkf6a1GEFX/6jMu4kA7fStLKA4a3dKYVI64EWH+pAOrONG
 cQD5Z/0uhNlXWR7nI920zenCWVwPqcuEtBQ+swjuVse3AhhmpPxnWD4xxFJ9uWFb6Wx/Ro30d
 T2owh6UIRYaGlyWBcBb7eMonrMRgNVDcJ4D7Vje2SqBq2X2gpPrfmFz3A60cGAnrdZlduIFDH
 Uq0yrKQqK6ASY3mOpTbmtgL/H59APqmq58fEo/MgBLTSwSun9Zlbnrcd/P9Mc67oOC83E+98g
 8U+3ktQGNQMUCigqNYJI66PJMIbke6EmyLYVH3j3rqtYSAsnALGe3U2gQDXfK//aphsJlwZwG
 9J5z0kzAqhQ2Uuk5zBFBT6qZWIXizTD/T7KWTLM1I//3vSUzghxqMUrM3pNoeLQgQQqSc2pAf
 i8y1io9nVhN9c9DSHUZR023mCiQz8t7lGENA=
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have reproduced this on linux 6.5.0-rc5 with more debug info and source line pointers.

I get the impression that the firmware generates a rssi notification, even after it has disconnected from the AP.

Looking into the
> BUG: KASAN: null-ptr-deref in cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211

with source context:

net/wireless/nl80211.c
  19069 void cfg80211_cqm_rssi_notify(struct net_device *dev,
  ...
  19082 
  19083         if (wdev->cqm_config) {
  19084                 wdev->cqm_config->last_rssi_event_value = rssi_level;
  19085 
  19086                 cfg80211_cqm_rssi_update(rdev, dev);
  19087 
  19088                 if (rssi_level == 0)
  19089                         rssi_level = wdev->cqm_config->last_rssi_event_value;
  19090         }
  19091 

it looks like the cfg80211_cqm_rssi_update would unset the ->cqm_config, as the firmware is telling us, that there is (currently) no station

> brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_NOTFOUND (-30)
> brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=tdls_sta_info, len=296, err=-52

> brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_BADADDR (-21)
> brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=sta_info, len=296, err=-52

> ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52


And then we have the null pointer at

 
   19088                 if (rssi_level == 0)
   19089  -->                    rssi_level = wdev->cqm_config->last_rssi_event_value;
   19090         }

So my suggestion would be to do 

   19088                 if (rssi_level == 0 && wdev->cqm_config) // config has not been deleted / station deleted in the meantime
   19089                         rssi_level = wdev->cqm_config->last_rssi_event_value;
   19090         }


Any opinions?


Best,

Max


(nota: the interleaved brcmdata in between the KASAN report are original)

wpa_supplicant[332]: wlan0: CTRL-EVENT-DISCONNECTED bssid=XX:XX:XX:XX:74:1f reason=3 locally_generated=1
systemd[1]: Stopping User Manager for UID 1000...
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=0000000017163222
brcmfmac: brcmf_fweh_event_worker event LINK (16) ifidx 0 bsscfg 0 addr xx:xx:xx:xx:74:1f
brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 2
brcmutil: event payload, len=0
brcmfmac: brcmf_is_linkdown Processing link down
brcmfmac: brcmf_notify_connect_status Linkdown
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000dcf7c0c0
brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr 00:00:xx:xx:00:50
brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0
brcmutil: event payload, len=12
00000000: 00 00 00 00 00 00 00 00 00 00 00 00              ............
brcmfmac: brcmf_notify_rssi LOW rssi=0
brcmfmac: brcmf_cfg80211_del_key key index (0)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_cfg80211_del_key key index (1)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_cfg80211_del_key key index (2)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_cfg80211_del_key key index (3)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_cfg80211_del_key key index (4)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_cfg80211_del_key key index (5)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_NOTFOUND (-30)
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=tdls_sta_info, len=296, err=-52
brcmutil: data
00000000: 34 2c c4 3a 74 1f 00 00 00 00 00 00 00 00 00 00  4,.:t...........
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_BADADDR (-21)
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=sta_info, len=296, err=-52
brcmutil: data
00000000: 34 2c c4 3a 74 1f 00 00 00 00 00 00 00 00 00 00  4,.:t...........
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52
==================================================================
BUG: KASAN: null-ptr-deref in cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
Read of size 4 at addr 0000000000000004 by task kworker/1:2/126
 kernel:
CPU: 1 PID: 126 Comm: kworker/1:2 Tainted: G         C         6.5.0-rc5-v8-g1af52ad6a306 #2
Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
Workqueue: events brcmf_fweh_event_worker [brcmfmac]
Call trace:
dump_backtrace (/home/r/linux/arch/arm64/kernel/stacktrace.c:235) 
show_stack (/home/r/linux/arch/arm64/kernel/stacktrace.c:242) 
dump_stack_lvl (/home/r/linux/lib/dump_stack.c:107) 
kasan_report (/home/r/linux/mm/kasan/report.c:590) 
__asan_load4 (/home/r/linux/mm/kasan/generic.c:259) 
brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=rssi_event, len=16
brcmutil: data
00000000: 00 00 00 00 03 00 00 7f 00 00 00 00 00 00 00 00  ................
cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
brcmf_notify_rssi (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6651) brcmfmac
brcmf_fweh_call_event_handler (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:109) brcmfmac
brcmf_fweh_event_worker (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:268) brcmfmac
process_one_work (/home/r/linux/./arch/arm64/include/asm/jump_label.h:21 /home/r/linux/./include/linux/jump_label.h:207 /home/r/linux/./include/trace/events/workqueue.h:108 /home/r/linux/kernel/workqueue.c:2602) 
worker_thread (/home/r/linux/./include/linux/list.h:292 /home/r/linux/kernel/workqueue.c:2749) 
kthread (/home/r/linux/kernel/kthread.c:389) 
ret_from_fork (/home/r/linux/arch/arm64/kernel/entry.S:854) 
==================================================================
Disabling lock debugging due to kernel taint
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 39-bit VAs, pgdp=000000004848b000
[0000000000000004] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in: brcmfmac_wcc vc4 brcmfmac snd_soc_hdmi_codec cfg80211 snd_soc_core snd_pcm_dmaengine rtc_pcf85063 snd_pcm regmap_i2c snd_timer rpivid_hevc(C) snd xt_tcpudp nft_compat bcm2835_isp(C) nf_tables drm_display_helper bcm2835_mmal_vchiq(C) videobuf2_dma_contig v3d drm_dma_helper videobuf2_memops v4l2_mem2mem videobuf2_v4l2 videodev nfnetlink drm_shmem_helper drm_kms_helper gpu_sched i2c_mux_pinctrl gpio_keys raspberrypi_hwmon i2c_mux i2c_brcmstb rfkill joydev hid_microsoft videobuf2_common ff_memless brcmutil i2c_bcm2835 mc vc_sm_cma(C) cec nvmem_rmem uio_pdrv_genirq uio drm fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
CPU: 1 PID: 126 Comm: kworker/1:2 Tainted: G    B    C         6.5.0-rc5-v8-g1af52ad6a306 #2
Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
Workqueue: events brcmf_fweh_event_worker [brcmfmac]
pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
lr : cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
sp : ffffffc0808f7a10
x29: ffffffc0808f7a10 x28: ffffff80432d0a68 x27: ffffff804b1d4368
x26: ffffff80432d03c0 x25: 1ffffff81011ef4e x24: ffffff8049b6fbc0
x23: 0000000000000cc0 x22: 0000000000000000 x21: ffffff804b1d4008
x20: 0000000000000000 x19: ffffff8048096000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 746e696174206c65 x12: ffffffbcc23e1e29
x11: 1ffffffcc23e1e28 x10: ffffffbcc23e1e28 x9 : dfffffc000000000
x8 : 000000433dc1e1d8 x7 : ffffffe611f0f147 x6 : 0000000000000001
x5 : ffffffe611f0f140 x4 : ffffffbcc23e1e29 x3 : ffffffe60f6c0924
x2 : 0000000000000000 x1 : ffffff80469f4000 x0 : 0000000000000001
Call trace:
cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
brcmf_notify_rssi (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6651) brcmfmac
brcmf_fweh_call_event_handler (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:109) brcmfmac
brcmf_fweh_event_worker (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:268) brcmfmac
process_one_work (/home/r/linux/./arch/arm64/include/asm/jump_label.h:21 /home/r/linux/./include/linux/jump_label.h:207 /home/r/linux/./include/trace/events/workqueue.h:108 /home/r/linux/kernel/workqueue.c:2602) 
worker_thread (/home/r/linux/./include/linux/list.h:292 /home/r/linux/kernel/workqueue.c:2749) 
kthread (/home/r/linux/kernel/kthread.c:389) 
ret_from_fork (/home/r/linux/arch/arm64/kernel/entry.S:854) 
Code: 9401bd51 f941b2b4 91001280 9401bd48 (b9400694)
All code
========
   0:	9401bd51 	bl	0x6f544
   4:	f941b2b4 	ldr	x20, [x21, #864]
   8:	91001280 	add	x0, x20, #0x4
   c:	9401bd48 	bl	0x6f52c
  10:*	b9400694 	ldr	w20, [x20, #4]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	b9400694 	ldr	w20, [x20, #4]
---[ end trace 0000000000000000 ]---
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=country, len=12, err=0
brcmutil: data
00000000: 44 45 00 00 00 00 00 00 44 45 00 41              DE......DE.A
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=0000000068d7cc22
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=qtxpower, len=4, err=0

