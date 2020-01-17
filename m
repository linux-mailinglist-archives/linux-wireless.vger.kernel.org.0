Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93814046B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 08:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAQHTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 02:19:33 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49126 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgAQHTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 02:19:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579245572; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MI1hlrhMQxBagcJTLL0JdjSgaIJMkdHEs0B8C+5T7Bw=;
 b=Y47PmsRiieSdlLRYjnHJRM1UxPyfg6eZrWKiDzGcXVaeiBaojrR95Hfv9QRChr4faKHP3wVh
 wj3XkFwPiCYvTRjzAIItbJbDdQitfWaGgB/kQcNkUIog1xGLCJJ8jdHBgcKaLkncClh+Opqf
 cswf1j85RO3pTRiU/NLfe3f3YVM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e215ffb.7f614ed6b068-smtp-out-n01;
 Fri, 17 Jan 2020 07:19:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2642C433A2; Fri, 17 Jan 2020 07:19:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFA8DC433CB;
        Fri, 17 Jan 2020 07:19:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Jan 2020 23:19:21 -0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <55ab2d64e78d51a9da587f276899e08b@codeaurora.org>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <CAMrEMU-UTtxJ-eMoNEBONXJCTpaZCcGc8Mu34wqQNXkpVz=gJA@mail.gmail.com>
 <55ab2d64e78d51a9da587f276899e08b@codeaurora.org>
Message-ID: <a1950ee2cb8dd9fc10e7d31bf18c9c95@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-10 02:29, Wen Gong wrote:
> On 2020-01-08 20:02, Justin Capella wrote:
>> I think this might break the "wedged" state.
>> 
>> Would simply not taking action unless STATE ON avoid the problems with
>> multiple calls to _restart? ie:
>> 
> 
> ath10k_core_restart is one part of the recovery process,
> after ath10k_core_restart, it has other things do in 
> mac80211/ath10k...,
> it need to make sure all the recovery 
> finished(ath10k_reconfig_complete),
> then the next recovery can start from ath10k_core_restart.

Here is some log for the 2 recovery run meanwhile and failed.
It means if 2 recovery run meanwhile, recovery will easy failed.

log steps:
1. simulate crash and then firmware crash and enter ath10k_core_restart 
with state=ATH10K_STATE_ON
2. it happened "exceeds length, start recovery" and queued the 2nd 
recovery
3. mac80211 start to recovery ath10k and state changed from 
ATH10K_STATE_RESTARTING to ATH10K_STATE_RESTARTED
4. enter ath10k_core_restart for 2nd recovery and state changed from 
ATH10K_STATE_RESTARTED to ATH10K_STATE_WEDGED
5. mac80211 start to drv_add_interface but failed because 
ath10k_htc_send return -ECOMM for ATH10K_STATE_WEDGED
6. mac80211 start to ieee80211_handle_reconfig_failure because 
drv_add_interface failed so the recovery failed.


kworker/0:1 13360 [000]  2889.292173:            ath10k:ath10k_log_err: 
ath10k_sdio mmc1:0001:1 firmware register dump:
kworker/u16:3 11486 [001]  2889.292686:           
ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 ath10k_core_restart => 
state :1
kworker/0:1 13360 [000]  2889.292760:           ath10k:ath10k_log_warn: 
ath10k_sdio mmc1:0001:1 payload length 57005 exceeds max htc length: 
4088
kworker/0:1 13360 [000]  2889.292805:           ath10k:ath10k_log_warn: 
ath10k_sdio mmc1:0001:1 exceeds length, start recovery
kworker/1:3 14712 [001]  2889.850142:            ath10k:ath10k_log_dbg: 
ath10k_sdio mmc1:0001:1 wmi tlv init
kworker/1:3 14712 [001]  2889.866953:            ath10k:ath10k_log_dbg: 
ath10k_sdio mmc1:0001:1 wmi tlv scan prob req oui
kworker/u16:3 11486 [001]  2889.888801:           
ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 ath10k_core_restart => 2 
state :3
kworker/u16:3 11486 [001]  2889.888808:           
ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 device is wedged, will 
not restart
kworker/1:3 14712 [001]  2889.889220:           ath10k:ath10k_log_warn: 
ath10k_sdio mmc1:0001:1 ath10k_add_interface => state :4
kworker/1:3 14712 [001]  2889.889229:            ath10k:ath10k_log_dbg: 
ath10k_sdio mmc1:0001:1 mac create vdev 0 map f
kworker/1:3 14712 [001]  2889.889240:            ath10k:ath10k_log_dbg: 
ath10k_sdio mmc1:0001:1 mac vdev create 0 (add interface) type 2 subtype 
0 bcnmode per-skb
kworker/1:3 14712 [001]  2889.889247:            ath10k:ath10k_log_dbg: 
ath10k_sdio mmc1:0001:1 wmi tlv vdev create
kworker/1:3 14712 [001]  2889.889252:            ath10k:ath10k_wmi_cmd: 
ath10k_sdio mmc1:0001:1 id 20481 len 28
kworker/1:3 14712 [001]  2889.889260:           ath10k:ath10k_log_warn: 
ath10k_sdio mmc1:0001:1 failed to create WMI vdev 0: -70

ieee80211_reconfig will ieee80211_handle_reconfig_failure because 
drv_add_interface failed.
so the recovery failed.

detail log for fail
[ 2889.410150] ieee80211 phy0: Hardware restart was requested
[ 2889.889281] drv_add_interface ret:-70
[ 2889.889310] ------------[ cut here ]------------
[ 2889.889547] WARNING: CPU: 1 PID: 14712 at 
/mnt/host/source/src/third_party/kernel/v4.19/net/mac80211/util.c:2072 
ieee80211_reconfig+0x189c/0x19a4 [mac80211]
[ 2889.889559] Modules linked in: rfcomm uinput cros_ec_rpmsg mtk_dip 
mtk_vcodec_enc mtk_seninf mtk_vcodec_dec mtk_mdp3 mtk_fd mtk_cam_isp 
mtk_vcodec_common videobuf2_dma_contig videobuf2_memops v4l2_mem2mem 
videobuf2_v4l2 videobuf2_common hci_uart btqca bluetooth 
hid_google_hammer ecdh_generic ov8856 dw9768 mtk_scp mtk_rpmsg ov02a10 
rpmsg_core v4l2_fwnode mtk_scp_ipi nf_nat_tftp nf_conntrack_tftp 
nf_nat_ftp nf_conntrack_ftp esp6 ah6 xfrm6_mode_tunnel 
xfrm6_mode_transport xfrm4_mode_tunnel xfrm4_mode_transport ip6t_REJECT 
ip6t_ipv6header ipt_MASQUERADE fuse iio_trig_sysfs cros_ec_sensors_ring 
cros_ec_light_prox cros_ec_sensors cros_ec_sensors_sync 
industrialio_triggered_buffer kfifo_buf cros_ec_sensors_core ath10k_sdio 
ath10k_core ath mac80211 lzo_rle lzo_compress zram cfg80211 ax88179_178a 
usbnet mii
[ 2889.889689]  joydev
[ 2889.889709] CPU: 1 PID: 14712 Comm: kworker/1:3 Tainted: G        W   
       4.19.95 #139
[ 2889.889720] Hardware name: MediaTek krane sku176 board (DT)
[ 2889.889776] Workqueue: events_freezable ieee80211_restart_work 
[mac80211]
[ 2889.889792] pstate: 60000005 (nZCv daif -PAN -UAO)
[ 2889.889849] pc : ieee80211_reconfig+0x189c/0x19a4 [mac80211]
[ 2889.889908] lr : ieee80211_reconfig+0x189c/0x19a4 [mac80211]
[ 2889.889918] sp : ffffff8012743cc0
[ 2889.889927] x29: ffffff8012743d40 x28: ffffffa381e11f40
[ 2889.889941] x27: ffffffa381ad4018 x26: 0000000000000000
[ 2889.889954] x25: 00000000ffffffba x24: 0000000000000004
[ 2889.889968] x23: ffffffe3b52a2210 x22: ffffffe3c3ae12b8
[ 2889.889981] x21: ffffffe3c3ae12b8 x20: ffffffe3b4e80900
[ 2889.889995] x19: ffffffe3c3ae0800 x18: 000000000003b900
[ 2889.890008] x17: 000000000000003c x16: ffffffa3815c1540
[ 2889.890021] x15: 0000000000000006 x14: ffff001000000600
[ 2889.890034] x13: 00000000002ae45c x12: 0000000000000000
[ 2889.890047] x11: 0000000000000001 x10: 0000000000000007
[ 2889.890061] x9 : c6cfad4ea7c13400 x8 : c6cfad4ea7c13400
[ 2889.890074] x7 : 0000000000000000 x6 : ffffffa381f6cd0c
[ 2889.890087] x5 : 0000000000000000 x4 : 0000000000000000
[ 2889.890100] x3 : 000000000003e2a1 x2 : fffffffffffff704
[ 2889.890113] x1 : 0000000000000000 x0 : 0000000000000024
[ 2889.890127] Call trace:
[ 2889.890185]  ieee80211_reconfig+0x189c/0x19a4 [mac80211]
[ 2889.890236]  ieee80211_restart_work+0xa0/0xd0 [mac80211]
[ 2889.890258]  process_one_work+0x210/0x418
[ 2889.890273]  worker_thread+0x234/0x3dc
[ 2889.890288]  kthread+0x120/0x130
[ 2889.890303]  ret_from_fork+0x10/0x18
[ 2889.890314] ---[ end trace d605ce58e22a44f2 ]---
[ 2889.898956] wlan0: deauthenticating from c4:04:15:3b:e0:38 by local 
choice (Reason: 3=DEAUTH_LEAVING)
[ 2889.898995] ------------[ cut here ]------------
[ 2889.899006] wlan0:  Failed check-sdata-in-driver check, flags: 0x0
[ 2889.899289] WARNING: CPU: 1 PID: 14712 at 
/mnt/host/source/src/third_party/kernel/v4.19/net/mac80211/driver-ops.h:19 
ieee80211_bss_info_change_notify+0x23c/0x24c [mac80211]
[ 2889.899303] Modules linked in: rfcomm uinput cros_ec_rpmsg mtk_dip 
mtk_vcodec_enc mtk_seninf mtk_vcodec_dec mtk_mdp3 mtk_fd mtk_cam_isp 
mtk_vcodec_common videobuf2_dma_contig videobuf2_memops v4l2_mem2mem 
videobuf2_v4l2 videobuf2_common hci_uart btqca bluetooth 
hid_google_hammer ecdh_generic ov8856 dw9768 mtk_scp mtk_rpmsg ov02a10 
rpmsg_core v4l2_fwnode mtk_scp_ipi nf_nat_tftp nf_conntrack_tftp 
nf_nat_ftp nf_conntrack_ftp esp6 ah6 xfrm6_mode_tunnel 
xfrm6_mode_transport xfrm4_mode_tunnel xfrm4_mode_transport ip6t_REJECT 
ip6t_ipv6header ipt_MASQUERADE fuse iio_trig_sysfs cros_ec_sensors_ring 
cros_ec_light_prox cros_ec_sensors cros_ec_sensors_sync 
industrialio_triggered_buffer kfifo_buf cros_ec_sensors_core ath10k_sdio 
ath10k_core ath mac80211 lzo_rle lzo_compress zram cfg80211 ax88179_178a 
usbnet mii
[ 2889.899438]  joydev
[ 2889.899475] CPU: 1 PID: 14712 Comm: kworker/1:3 Tainted: G        W   
       4.19.95 #139
[ 2889.899486] Hardware name: MediaTek krane sku176 board (DT)
[ 2889.899545] Workqueue: events_freezable ieee80211_restart_work 
[mac80211]
[ 2889.899561] pstate: 60000005 (nZCv daif -PAN -UAO)
[ 2889.899612] pc : ieee80211_bss_info_change_notify+0x23c/0x24c 
[mac80211]
[ 2889.899664] lr : ieee80211_bss_info_change_notify+0x23c/0x24c 
[mac80211]
[ 2889.899674] sp : ffffff8012743820
[ 2889.899686] x29: ffffff8012743860 x28: ffffffa381e11f40
[ 2889.899700] x27: ffffffa381ad4018 x26: 0000000000000000
[ 2889.899712] x25: 0000000000000000 x24: 00000000000000c0
[ 2889.899725] x23: 0000000000000003 x22: ffffff80127438fc
[ 2889.899738] x21: ffffffe3b4e80900 x20: 0000000000020000
[ 2889.899751] x19: ffffffe3c3ae0800 x18: 000000000003c500
[ 2889.899764] x17: 000000000000003c x16: ffffffa3815c1540
[ 2889.899776] x15: 0000000000000006 x14: ffff001000000600
[ 2889.899789] x13: 00000000002ae46e x12: 0000000000000000
[ 2889.899802] x11: 0000000000000000 x10: 0000000000000000
[ 2889.899814] x9 : c6cfad4ea7c13400 x8 : c6cfad4ea7c13400
[ 2889.899827] x7 : 0000000000000000 x6 : ffffffa381f6cd1e
[ 2889.899840] x5 : 0000000000000000 x4 : 0000000000000000
[ 2889.899857] x3 : 000000000003d73b x2 : ffffffe3fff05918
[ 2889.899870] x1 : ffffffe3ffefca08 x0 : 0000000000000036
[ 2889.899883] Call trace:
[ 2889.899935]  ieee80211_bss_info_change_notify+0x23c/0x24c [mac80211]
[ 2889.899996]  ieee80211_recalc_ps_vif+0x3c/0x48 [mac80211]
[ 2889.900060]  ieee80211_set_disassoc+0x84/0x43c [mac80211]
[ 2889.900142]  ieee80211_mgd_deauth+0x4e0/0x574 [mac80211]
[ 2889.900201]  ieee80211_deauth+0x24/0x30 [mac80211]
[ 2889.900285]  cfg80211_mlme_deauth+0x198/0x26c [cfg80211]
[ 2889.900337]  cfg80211_mlme_down+0x70/0x98 [cfg80211]
[ 2889.900393]  cfg80211_disconnect+0x214/0x250 [cfg80211]
[ 2889.900441]  __cfg80211_leave+0xc8/0x14c [cfg80211]
[ 2889.900489]  cfg80211_netdev_notifier_call+0x41c/0x668 [cfg80211]
[ 2889.900515]  raw_notifier_call_chain+0x48/0x70
[ 2889.900540]  call_netdevice_notifiers_info+0x40/0x74
[ 2889.900556]  __dev_close_many+0x6c/0x11c
[ 2889.900572]  dev_close_many+0x70/0x100
[ 2889.900587]  dev_close+0x4c/0x80
[ 2889.900636]  cfg80211_shutdown_all_interfaces+0x50/0xcc [cfg80211]
[ 2889.900697]  ieee80211_handle_reconfig_failure+0x90/0x9c [mac80211]
[ 2889.900761]  ieee80211_reconfig+0x18dc/0x19a4 [mac80211]
[ 2889.900815]  ieee80211_restart_work+0xa0/0xd0 [mac80211]
[ 2889.900835]  process_one_work+0x210/0x418
[ 2889.900855]  worker_thread+0x234/0x3dc
[ 2889.900871]  kthread+0x120/0x130
[ 2889.900890]  ret_from_fork+0x10/0x18
[ 2889.900905] ---[ end trace d605ce58e22a44f3 ]---
