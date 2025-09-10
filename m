Return-Path: <linux-wireless+bounces-27207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D6B511EE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1660D3B9FE6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03231194A;
	Wed, 10 Sep 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="sJ7Hf6dz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA14311942;
	Wed, 10 Sep 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494683; cv=none; b=t/jV8jhzuXg9nVseHTyXr9O7430lBQ3qgRowEc7UeFWFFDeb3+EwbkG0ui7QIsjCmEvd2rgf1XLiFOUPFzCIvpOQNFpPBrVYbvlRIlvOVuEVxVRf3H+xdSofRb40IDSVWmRuxkFXr6MOryrc1Se9Gtds8WaaoAqsqyQ28l4WSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494683; c=relaxed/simple;
	bh=iMTvDYPnxsIi5BxbLY0nLVNd+wqZTFqdrBbOlRU5mQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxqIFj8VPLHy3dmSZtPHj4bmLctj7IlgDaGy1evMKlEG2mrGaZ1EMsu/45lQPZdBiKf7UkY3nSuVMRsHYdA6Cd3MezE7trm+FMq3io5LJchpeILTveYQ/evfLXko4W8DF032tNz+eNrcmRbuEtj8nnm1b4te8dR9fmrqFps/YW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=sJ7Hf6dz; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1757494676; bh=iMTvDYPnxsIi5BxbLY0nLVNd+wqZTFqdrBbOlRU5mQ0=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=sJ7Hf6dz6iJfMGLdg4EyNcDEgF8vQZm9IjK97eNQFqOrF1vlmCwtME24W5WktJiWA
	 3f5bhFC5RB/yd7TTfqstimHq9061gOX+l20UzyCM1D9JZvaF32bX7i3Wjg9T73VMG4
	 kqQCCoCLn5I4+4HSnZbZdYzjLtBh4RtuAeXy50YQ=
Date: Wed, 10 Sep 2025 10:57:55 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] net: wireless: rtw89: Sleep while waiting for firmware
 init
Message-ID: <mcf6zmdhmqlg3xbar2yxa7bnvvnlxbttveug7k6u23tc6yigq6@exm5imy6aob4>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Ping-Ke Shih <pkshih@realtek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250909211255.1486851-1-megi@xff.cz>
 <4a3f6b40a0064de1acd80f4eeb1cdd0f@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a3f6b40a0064de1acd80f4eeb1cdd0f@realtek.com>

On Wed, Sep 10, 2025 at 12:37:54AM +0000, Ping-Ke Shih wrote:
> Ondřej Jirman <megi@xff.cz> wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > This avoids RCU stalls caused by waiting up to 400ms for firmware init.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> >  drivers/net/wireless/realtek/rtw89/fw.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> > index 16e59a4a486e..2c034b764a0a 100644
> > --- a/drivers/net/wireless/realtek/rtw89/fw.c
> > +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> > @@ -109,9 +109,9 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type
> >         u8 val;
> >         int ret;
> > 
> > -       ret = read_poll_timeout_atomic(mac->fwdl_get_status, val,
> > -                                      val == RTW89_FWDL_WCPU_FW_INIT_RDY,
> > -                                      1, FWDL_WAIT_CNT, false, rtwdev, type);
> > +       ret = read_poll_timeout(mac->fwdl_get_status, val,
> > +                               val == RTW89_FWDL_WCPU_FW_INIT_RDY,
> > +                               1, FWDL_WAIT_CNT, false, rtwdev, type);
> 
> As I know, sleeping while RCU lock is not allowed. Please share kernel log
> about the RCU stall and your perspective. 

My perspective is that busy looping via read_poll_timeout_atomic() on a CPU for
up to 400ms (FWDL_WAIT_CNT is 400_000) is not optimal and that rtw driver is for
some reason a major user of *_atomic version of read_poll function, which is
I guess fine if you just need to wait for a few microseconds, and want
a predictably timed exit from polling. But firmware load ready check doesn't
seem to be this case.

Does the driver really need exit from polling the moment firmware signals ready
status here (and similarly in many other places)?

More than 50% of uses of this function across all of kernel comes from rtw
driver:

  https://elixir.bootlin.com/linux/v6.16.5/C/ident/read_poll_timeout_atomic

My understanding is that in non-preemtible kernel this will prevent anything
from executing on said CPU for up to that amount of time, which is what the
kernel complains about (6.16.6):

[    8.028997] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 1-.... } 6 jiffies s: 709 root: 0x2/.
[    8.029819] rcu: blocking rcu_node structures (internal RCU debug):
[    8.030261] Sending NMI from CPU 3 to CPUs 1:
[    8.030280] NMI backtrace for cpu 1
[    8.030295] CPU: 1 UID: 0 PID: 366 Comm: hostapd Not tainted 6.16.6-00531-gefcc09919cb9 #17 VOLUNTARY
[    8.030304] Hardware name: Pine64 Quartz64 Model A (DT)
[    8.030307] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.030313] pc : arch_counter_get_cntpct+0x8/0x20
[    8.030326] lr : __delay+0x90/0xe8
[    8.030332] sp : ffff8000859c34a0
[    8.030334] x29: ffff8000859c34a0 x28: ffff0001074de180 x27: ffff000100117080
[    8.030342] x26: ffff0001042003c0 x25: ffff0001042024e8 x24: 0000000000000000
[    8.030347] x23: 0000000000000000 x22: ffffffffec859f81 x21: 00000000137a69df
[    8.030352] x20: 0000000000000018 x19: ffff800082af7158 x18: 00000000000007f4
[    8.030357] x17: 0000000800000000 x16: 41003d382021b000 x15: ffff000100f68088
[    8.030362] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000003d0
[    8.030367] x11: 0000000000000001 x10: ffff000100f680c8 x9 : 000000013c624a80
[    8.030372] x8 : ffff00013c624a90 x7 : 0000000000000000 x6 : 000000013c624a80
[    8.030377] x5 : ffff800080ddeae0 x4 : ffff00010420dff4 x3 : 00000000ffff41e0
[    8.030381] x2 : 0000000000000001 x1 : ffff8000859c34a0 x0 : 00000000137a69ed
[    8.030388] Call trace:
[    8.030390]  arch_counter_get_cntpct+0x8/0x20 (P)
[    8.030397]  __const_udelay+0x28/0x38
[    8.030402]  rtw89_fw_check_rdy+0x3c/0x134
[    8.030412]  rtw89_fw_download+0x1b4/0x1d0
[    8.030417]  rtw89_mac_partial_init+0xcc/0x158
[    8.030424]  rtw89_mac_init+0x40/0x16c
[    8.030429]  rtw89_core_start+0x14/0x268
[    8.030433]  rtw89_leave_ips+0x24/0xe8
[    8.030440]  rtw89_ops_add_interface+0x1c4/0x244
[    8.030445]  rtw89_ops_change_interface+0x84/0x120
[    8.030449]  drv_change_interface+0x58/0xd0
[    8.030457]  ieee80211_if_change_type+0x198/0x3c8
[    8.030465]  ieee80211_change_iface+0x38/0x20c
[    8.030471]  cfg80211_change_iface+0x170/0x2bc
[    8.030477]  nl80211_set_interface+0x248/0x274
[    8.030484]  genl_family_rcv_msg_doit+0xb8/0x110
[    8.030494]  genl_rcv_msg+0x1ac/0x244
[    8.030499]  netlink_rcv_skb+0x44/0xf8
[    8.030504]  genl_rcv+0x30/0x44
[    8.030509]  netlink_unicast+0x2d8/0x34c
[    8.030514]  netlink_sendmsg+0x170/0x3d8
[    8.030518]  __sock_sendmsg+0x48/0x54
[    8.030526]  ____sys_sendmsg+0x24c/0x264
[    8.030531]  ___sys_sendmsg+0x6c/0xb0
[    8.030536]  __sys_sendmsg+0x6c/0xb8
[    8.030540]  __arm64_sys_sendmsg+0x1c/0x24
[    8.030545]  invoke_syscall.constprop.0+0x3c/0xe4
[    8.030553]  el0_svc_common.constprop.0+0x34/0xcc
[    8.030559]  do_el0_svc+0x18/0x20
[    8.030564]  el0_svc+0x20/0x5c
[    8.030570]  el0t_64_sync_handler+0x104/0x130
[    8.030574]  el0t_64_sync+0x154/0x158

The kernel build has CONFIG_HZ_250=y so 6 jiffies is 24 ms. Not a lot, not
a small amount either.

I also get this on 6.17-rc5:

Seems to come from https://elixir.bootlin.com/linux/v6.16.5/source/drivers/net/wireless/realtek/rtw89/efuse.c#L174

Which is another place that seemingly doesn't need udelay() based polling,
because the function is only called from driver probe.

This time it stalled for combined time of 26+6 jiffies, which is 128ms. That's
a lot (probably a combined time of looping over all efuse addresses, while busy
polling for each access, without allowing the CPU to schedule other tasks).

[    1.038100] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 0-.... } 6 jiffies s: 105 root: 0x1/.
[    1.038898] rcu: blocking rcu_node structures (internal RCU debug):
[    1.039334] Sending NMI from CPU 2 to CPUs 0:
[    1.039343] NMI backtrace for cpu 0
[    1.039350] CPU: 0 UID: 0 PID: 126 Comm: irq/70-pcie-sys Not tainted 6.17.0-rc5-00531-g5cf2d75707fc #3 VOLUNTARY
[    1.039356] Hardware name: Pine64 Quartz64 Model A (DT)
[    1.039359] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.039364] pc : rtw89_pci_ops_read32+0x38/0x58
[    1.039373] lr : rtw89_dump_physical_efuse_map+0x27c/0x4ec
[    1.039380] sp : ffff80008402b890
[    1.039381] x29: ffff80008402b890 x28: fffffff7ff000000 x27: ffff000102f56800
[    1.039387] x26: 00000000000004c0 x25: 0000000000000060 x24: ffff000102f59000
[    1.039393] x23: 00000000000004c0 x22: ffff000102f59130 x21: 0000000000000130
[    1.039397] x20: 00000000000f3e3d x19: ffff000103c82020 x18: ffff800174645000
[    1.039402] x17: 0000000800000000 x16: 41003d382021b000 x15: ffff800082e4f410
[    1.039407] x14: ffff800082d5e3c0 x13: 00000000000000c0 x12: ffff0001f73a33c0
[    1.039412] x11: 00000000000000c0 x10: 00000000000009f0 x9 : ffff80008402b740
[    1.039416] x8 : ffff000102cb9a90 x7 : 0000000000000000 x6 : 0000000000000010
[    1.039421] x5 : 0000000000000000 x4 : ffff800080df72c0 x3 : 00000000ffff4030
[    1.039426] x2 : 0000000000003fff x1 : 0000000000000030 x0 : 0000000001300000
[    1.039432] Call trace:
[    1.039434]  rtw89_pci_ops_read32+0x38/0x58 (P)
[    1.039439]  rtw89_parse_efuse_map_ax+0xc4/0x258
[    1.039444]  rtw89_chip_info_setup+0xb0/0x308
[    1.039451]  rtw89_pci_probe+0x704/0xb80
[    1.039455]  local_pci_probe+0x38/0x90
[    1.039461]  pci_device_probe+0xa4/0x1a0
[    1.039466]  really_probe+0xbc/0x384
[    1.039472]  __driver_probe_device+0x78/0x148
[    1.039476]  driver_probe_device+0x3c/0x120
[    1.039481]  __device_attach_driver+0xb0/0x160
[    1.039485]  bus_for_each_drv+0x6c/0xb0
[    1.039490]  __device_attach+0x94/0x19c
[    1.039494]  device_initial_probe+0x10/0x18
[    1.039498]  pci_bus_add_device+0x84/0x138
[    1.039503]  pci_bus_add_devices+0x34/0x80
[    1.039506]  pci_bus_add_devices+0x60/0x80
[    1.039510]  pci_bus_add_devices+0x60/0x80
[    1.039513]  pci_bus_add_devices+0x60/0x80
[    1.039518]  pci_rescan_bus+0x2c/0x3c
[    1.039522]  rockchip_pcie_rc_sys_irq_thread+0xe4/0x118
[    1.039529]  irq_thread_fn+0x24/0xa0
[    1.039536]  irq_thread+0x178/0x2ec
[    1.039540]  kthread+0xe4/0x1a0
[    1.039545]  ret_from_fork+0x10/0x20
[    1.118092] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 0-.... } 26 jiffies s: 105 root: 0x1/.
[    1.118889] rcu: blocking rcu_node structures (internal RCU debug):
[    1.119323] Sending NMI from CPU 2 to CPUs 0:
[    1.119328] NMI backtrace for cpu 0
[    1.119333] CPU: 0 UID: 0 PID: 126 Comm: irq/70-pcie-sys Not tainted 6.17.0-rc5-00531-g5cf2d75707fc #3 VOLUNTARY
[    1.119339] Hardware name: Pine64 Quartz64 Model A (DT)
[    1.119341] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.119345] pc : arch_counter_get_cntpct+0x8/0x20
[    1.119352] lr : __delay+0x90/0xe8
[    1.119357] sp : ffff80008402b850
[    1.119359] x29: ffff80008402b850 x28: fffffff7ff000000 x27: ffff000102f56800
[    1.119365] x26: 00000000000004c0 x25: 0000000000000060 x24: ffff000102f59000
[    1.119370] x23: 00000000000004c0 x22: fffffffff662150b x21: 00000000099df455
[    1.119375] x20: 0000000000000018 x19: ffff800082b25228 x18: ffff800174645000
[    1.119379] x17: 0000000800000000 x16: 41003d382021b000 x15: ffff800082e4f410
[    1.119384] x14: ffff800082d5e3c0 x13: 00000000000000c0 x12: ffff0001f73a33c0
[    1.119389] x11: 00000000000000c0 x10: 00000000000009f0 x9 : ffff80008402b740
[    1.119394] x8 : ffff000102cb9a90 x7 : 0000000000000000 x6 : 0000000000000010
[    1.119398] x5 : 0000000000000000 x4 : ffff800080df72c0 x3 : 00000000ffff4030
[    1.119403] x2 : 0000000000000000 x1 : ffff80008402b850 x0 : 00000000099df455
[    1.119409] Call trace:
[    1.119410]  arch_counter_get_cntpct+0x8/0x20 (P)
[    1.119415]  __const_udelay+0x28/0x38
[    1.119419]  rtw89_dump_physical_efuse_map+0x264/0x4ec
[    1.119425]  rtw89_parse_efuse_map_ax+0xc4/0x258
[    1.119429]  rtw89_chip_info_setup+0xb0/0x308
[    1.119435]  rtw89_pci_probe+0x704/0xb80
[    1.119440]  local_pci_probe+0x38/0x90
[    1.119445]  pci_device_probe+0xa4/0x1a0
[    1.119449]  really_probe+0xbc/0x384
[    1.119455]  __driver_probe_device+0x78/0x148
[    1.119459]  driver_probe_device+0x3c/0x120
[    1.119463]  __device_attach_driver+0xb0/0x160
[    1.119467]  bus_for_each_drv+0x6c/0xb0
[    1.119472]  __device_attach+0x94/0x19c
[    1.119475]  device_initial_probe+0x10/0x18
[    1.119479]  pci_bus_add_device+0x84/0x138
[    1.119484]  pci_bus_add_devices+0x34/0x80
[    1.119487]  pci_bus_add_devices+0x60/0x80
[    1.119491]  pci_bus_add_devices+0x60/0x80
[    1.119495]  pci_bus_add_devices+0x60/0x80
[    1.119498]  pci_rescan_bus+0x2c/0x3c
[    1.119502]  rockchip_pcie_rc_sys_irq_thread+0xe4/0x118
[    1.119508]  irq_thread_fn+0x24/0xa0
[    1.119514]  irq_thread+0x178/0x2ec
[    1.119517]  kthread+0xe4/0x1a0
[    1.119522]  ret_from_fork+0x10/0x20
[    1.159225] mmc_host mmc0: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)

Thank you and regards,
	o.


> >         if (ret) {
> >                 switch (val) {
> >                 case RTW89_FWDL_CHECKSUM_FAIL:
> > --
> > 2.51.0
> > 
> 

