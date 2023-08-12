Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743E6779E88
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Aug 2023 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHLJY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Aug 2023 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLJY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Aug 2023 05:24:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8691BE6;
        Sat, 12 Aug 2023 02:24:25 -0700 (PDT)
Received: from [192.168.151.20] ([217.224.112.34]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbc2-1qEArt0VeW-00L14a; Sat, 12 Aug 2023 11:23:53 +0200
Message-ID: <f6cb4b81-e574-5562-0394-88798ef3cd31@online.de>
Date:   Sat, 12 Aug 2023 11:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
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
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        johannes@sipsolutions.net
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
In-Reply-To: <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Tf9S75SrkoTx9fgLQqpCqbvp+JEvsueVB21Au4GgoL9PMH4sthl
 ckrUa60SFXQj/kQI/MCzynyW26Bt40lcBnMLhQ6nvzMSQ7PZl6D5sGH5nBQSocASQsNIcmj
 eIGougxssfSmaXMjTZUjIgs/7WYwDO2xY6BSxcE8QkT4JlKvtYBlimULD/Ds4bM/ClxsObP
 dsma3z2N1cG5vNjnQLovg==
UI-OutboundReport: notjunk:1;M01:P0:88HNXA7p2/U=;NqEbqDB5LFsV36lcTGYtREYru3/
 hmdWIgGZQ/cwNV9aPuHQIXWI9vUGvlzCjdRyUi3LHIbh9O2+7A8rFbJijcBchfjrRiKGW6Gag
 4PNHPy/wsGkIlcc5Si+2T3wGGpiOYkekKqMajEJdwCH2Hk1aTs+nB6LVdHrPycyTiof23qrKi
 wl4Z+oyOw8p1oKNe2/nKwW74jgSWAUfh8ZglT9j8ymWvW0qRG9uuI1FNn9uAyb7heZ3DMW80G
 1tSm/cXTz+W3PQ8g04CUK+MNpv8tSlBNyWCg4EH7RNZV1KK2ihVNBeMweQBM4SDwmQmojKsUb
 l4fQW3HuE6fIHo5Y5+0Qa0lREEA9KVZ7NnnTs52wjCyTbpyWAuOrgqZdJbzF7/ru1v4Ab+OHq
 +iGd32KOhETXAbJ7tgEN/4wgi4y7XK9SwgioaPtfk+s+Gg70c2H79VAyDpgS6gbibQuSj1T8n
 uLGEqcG5uL4tWVodaz+CM8KhQm10zVUSsVGPmhNfPqvWqOwp927R9WLwYZAVQIr988p3hmonk
 sk3qtPi6tUq3roo250DOreZwMo+Kug6/wHcLBUushTlAK+OXiEpXRWgiynMm4shqWuHA5fCOS
 RvvlTFjdJXUNxiMCU8HPRQlDMtMulZFkbkFGXnVLZHwoqQDe7VeR+z/uc0jJHThG3lVlVcsi3
 nNGfPzysqMChy/hXIUEb1JukbUaIIXj1h6jHYT/HvBk6pqsa2AZRUl8moL2W4HGOSunyYqb7+
 3TSdf0Vtl3VMoL/b/wUzM08XwXf36X1NNkbQ9c/uT5V+b4fK5iaf1ZU4hTBGUwRnyIwSQL4Gp
 TTqCMPcNs1sCLRhXCJGxB09/djoad77VI6OdXjgL6H4xuk2g0PLFkGS8B1JDY6PadQWtlfK0A
 lBkGv9IVOEn0lQ/fy1aP8iNflb5A18Ku0ndI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes pointed out that I have no clear link demonstrating that cfg80211_cqm_config_free is being called from cfg80211_cqm_rssi_notify.

Fair enough. So I compiled with

>  void cfg80211_cqm_config_free(struct wireless_dev *wdev)
>  {
> +       pr_err("someone freeing the cqm_config");
> +       dump_stack();
>         kfree(wdev->cqm_config);
>         wdev->cqm_config = NULL;
>  }


And get the attached output.

Now I am out of ideas. This to me clearly looks like some kind of race. Freeing the cqm as part of netlink_sendmsg?

Maybe cfg80211_cqm_rssi_notify could just exit() when there currently is no station connected and thus avoid the null-ptr deref?



brcmfmac: brcmf_fil_cmd_data_set ifidx=0, cmd=52, len=12
brcmutil: data
00000000: 03 00 00 00 34 2c c4 3a 74 1f 37 da              ....4,.:t.7.
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=ffffff8040227240
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=ffffff8040226340
brcmfmac: brcmf_fweh_event_worker event LINK (16) ifidx 0 bsscfg 0 addr xx:xx:xx:xx:74:1f
brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 2
brcmutil: event payload, len=0
brcmfmac: brcmf_is_linkdown Processing link down
brcmfmac: brcmf_notify_connect_status Linkdown
brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr xx:xx:xx:xx:00:50
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
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=country, len=12, err=0
brcmutil: data
00000000: 44 45 00 00 00 00 00 00 44 45 00 41              DE......DE.A
cfg80211: someone freeing the cqm_config
CPU: 0 PID: 335 Comm: wpa_supplicant Tainted: G         C         6.5.0-rc5-v8-gd9595c9a4f6d-dirty #7
Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
Call trace:
dump_backtrace (/home/r/linux/arch/arm64/kernel/stacktrace.c:235) 
show_stack (/home/r/linux/arch/arm64/kernel/stacktrace.c:242) 
dump_stack_lvl (/home/r/linux/lib/dump_stack.c:107) 
dump_stack (/home/r/linux/lib/dump_stack.c:114) 
cfg80211_cqm_config_free (/home/r/linux/net/wireless/core.c:1188) cfg80211
nl80211_set_cqm (/home/r/linux/net/wireless/core.h:239 /home/r/linux/net/wireless/nl80211.c:12883 /home/r/linux/net/wireless/nl80211.c:12955) cfg80211
genl_family_rcv_msg_doit.isra.0 (/home/r/linux/net/netlink/genetlink.c:970) 
genl_rcv_msg (/home/r/linux/net/netlink/genetlink.c:1050 /home/r/linux/net/netlink/genetlink.c:1067) 
netlink_rcv_skb (/home/r/linux/net/netlink/af_netlink.c:2549) 
genl_rcv (/home/r/linux/net/netlink/genetlink.c:1079) 
netlink_unicast (/home/r/linux/net/netlink/af_netlink.c:1340 /home/r/linux/net/netlink/af_netlink.c:1365) 
netlink_sendmsg (/home/r/linux/net/netlink/af_netlink.c:1914) 
sock_sendmsg (/home/r/linux/net/socket.c:725 /home/r/linux/net/socket.c:748) 
____sys_sendmsg (/home/r/linux/net/socket.c:2494) 
___sys_sendmsg (/home/r/linux/net/socket.c:2548) 
__sys_sendmsg (/home/r/linux/./include/linux/file.h:32 /home/r/linux/net/socket.c:2579) 
__arm64_sys_sendmsg (/home/r/linux/net/socket.c:2584) 
invoke_syscall (/home/r/linux/arch/arm64/kernel/syscall.c:38 /home/r/linux/arch/arm64/kernel/syscall.c:52) 
el0_svc_common.constprop.0 (/home/r/linux/./include/linux/thread_info.h:127 /home/r/linux/arch/arm64/kernel/syscall.c:147) 
do_el0_svc (/home/r/linux/arch/arm64/kernel/syscall.c:189) 
el0_svc (/home/r/linux/arch/arm64/kernel/entry-common.c:133 /home/r/linux/arch/arm64/kernel/entry-common.c:144 /home/r/linux/arch/arm64/kernel/entry-common.c:648) 
el0t_64_sync_handler (/home/r/linux/arch/arm64/kernel/entry-common.c:666) 
el0t_64_sync (/home/r/linux/arch/arm64/kernel/entry.S:591) 
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
Read of size 4 at addr 0000000000000004 by task kworker/0:2/38
Aug 12 09:28:20 hlcm4 kernel:
CPU: 0 PID: 38 Comm: kworker/0:2 Tainted: G         C         6.5.0-rc5-v8-gd9595c9a4f6d-dirty #7
Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
Workqueue: events brcmf_fweh_event_worker [brcmfmac]
Call trace:
dump_backtrace (/home/r/linux/arch/arm64/kernel/stacktrace.c:235) 
show_stack (/home/r/linux/arch/arm64/kernel/stacktrace.c:242) 
dump_stack_lvl (/home/r/linux/lib/dump_stack.c:107) 
kasan_report (/home/r/linux/mm/kasan/report.c:590) 
__asan_load4 (/home/r/linux/mm/kasan/generic.c:259) 
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
 user pgtable: 4k pages, 39-bit VAs, pgdp=000000004c5c2000
 brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=rssi_event, len=16
 [0000000000000004] pgd=0000000000000000
 brcmutil: data
 , p4d=0000000000000000, pud=0000000000000000
 00000000: 00 00 00 00 03 00 00 7f 00 00 00 00 00 00 00 00  ................

 Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
 Modules linked in: brcmfmac_wcc brcmfmac cfg80211 rpivid_hevc(C) bcm2835_isp(C) rtc_pcf85063 bcm2835_mmal_vchiq(C) regmap_i2c xt_tcpudp nft_compat videobuf2_dma_contig v3d videobuf2_memops nf_tables v4l2_mem2mem videobuf2_v4l2 videodev nfnetlink drm_shmem_helper gpu_sched i2c_mux_pinctrl gpio_keys i2c_mux hid_microsoft raspberrypi_hwmon videobuf2_common joydev ff_memless rfkill brcmutil i2c_brcmstb i2c_bcm2835 vc_sm_cma(C) mc uio_pdrv_genirq nvmem_rmem uio drm fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
 CPU: 0 PID: 38 Comm: kworker/0:2 Tainted: G    B    C         6.5.0-rc5-v8-gd9595c9a4f6d-dirty #7
 Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
 Workqueue: events brcmf_fweh_event_worker [brcmfmac]
 pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
 lr : cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
 sp : ffffffc0805c7a10
 x29: ffffffc0805c7a10 x28: 0000000000000001 x27: ffffff804743a368
 x26: ffffff80428883c0 x25: 1ffffff8100b8f4e x24: ffffff804c1496d0
 x23: 0000000000000cc0 x22: 0000000000000000 x21: ffffff804743a008
 x20: 0000000000000000 x19: ffffff804c0ac000 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
 x14: 0000000000000000 x13: 746e696174206c65 x12: ffffffbde8d1dc29
 x11: 1ffffffde8d1dc28 x10: ffffffbde8d1dc28 x9 : dfffffc000000000
 x8 : 00000042172e23d8 x7 : ffffffef468ee147 x6 : 0000000000000001
 x5 : ffffffef468ee140 x4 : ffffffbde8d1dc29 x3 : ffffffef440c0924
 x2 : 0000000000000000 x1 : ffffff8040b6a0c0 x0 : 0000000000000001
 Call trace:
 cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211
 brcmf_notify_rssi (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6651) brcmfmac
 brcmf_fweh_call_event_handler (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:109) brcmfmac
 brcmf_fweh_event_worker (/home/r/linux/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:268) brcmfmac
 process_one_work (/home/r/linux/./arch/arm64/include/asm/jump_label.h:21 /home/r/linux/./include/linux/jump_label.h:207 /home/r/linux/./include/trace/events/workqueue.h:108 /home/r/linux/kernel/workqueue.c:2602) 
 worker_thread (/home/r/linux/./include/linux/list.h:292 /home/r/linux/kernel/workqueue.c:2749) 
 kthread (/home/r/linux/kernel/kthread.c:389) 
 ret_from_fork (/home/r/linux/arch/arm64/kernel/entry.S:854) 
 Code: 9401bd4d f941b2b4 91001280 9401bd44 (b9400694)
All code
========
   0:	9401bd4d 	bl	0x6f534
   4:	f941b2b4 	ldr	x20, [x21, #864]
   8:	91001280 	add	x0, x20, #0x4
   c:	9401bd44 	bl	0x6f51c
  10:*	b9400694 	ldr	w20, [x20, #4]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	b9400694 	ldr	w20, [x20, #4]
 ---[ end trace 0000000000000000 ]---
 brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=qtxpower, len=4, err=0
 brcmutil: data
 00000000: 7f 00 00 00                                      ....
 brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=mcast_list, len=22
