Return-Path: <linux-wireless+bounces-27930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81364BCDF2A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778E319E039E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DED2FBE08;
	Fri, 10 Oct 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="PgOl4yQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2362F83A7;
	Fri, 10 Oct 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113374; cv=pass; b=BZ0BfbeZ85JJOUqre0C3J0//I/Lg1l6DdOLV+icHijEIdxnF5xO1NGP4g6sSOz2q+fVAbyKm2da/XxqkuJ/a60KfUR+HDHtyj4cEC5hTq26ht46GI81SrxUmxTD545aKUgHUswcwIks0Qa+rdqxyjuYGx9vz+nofSqoqnpnRr+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113374; c=relaxed/simple;
	bh=NJ79nuyZsplPwKJ7DXJvnAJD0tn3nUImoRljGVo1yHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1vELzAmQ7keAV6lur7lxA1v4J7CeKBOkTj+kunCBmhJ1wpRchCm6SFw/snMfK1RaFoxXJZbyYXMKf+d9GzXdIh3DnNqUBb6YN/07mhWElQN0xbkdXLfXkduJEkLLkvcIGpCaZGmgks/tkFALJFOx4Qu3btngnTvrn4z9oz1ks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=PgOl4yQo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760113354; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L2yw+ibYTnKJXa3g7B+onBUwilhQuljfq1bnZwfWOW7fK9hRcZftW+ladaVAA2JkxEWKWsZhNAELA28tspW1/5B7oPQ0LJAZG9XO05NpgHH3JF7wTvpw5scAj7kTY7quFgwGNL5G34IgrtCqLCeFxL/wVAR+7i92BW4YqapeCbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760113354; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A4+ydwSIz5c9X24Guu+ZeVLgAXOBs3OahByrrq6IBzU=; 
	b=lkahQ8LweiyY6JL6mYmorYB5j94IdkJ+bGNUIAFkrnZnh9hhZbKzNSxb8GJhkqVwz0UtCSN+r11yOuGmUsLEC7QeJqJVhL1Im/1luNLnVvDP9doiOalRYU6AAvjY+LBHhDKWIcOq2w4vBwbcdjNYQNHtKK9NV2VEpFIOgdDhx9U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760113354;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=A4+ydwSIz5c9X24Guu+ZeVLgAXOBs3OahByrrq6IBzU=;
	b=PgOl4yQob2nfK7Pi+Ui+jpHIiQeuttW3B49ah4tHMeXyVUqgx2BsGpVaSEsIV0kq
	OrP2v5zdKASqNplrOpEo5SajiWOkfd/CwLkd7wvriQiOd/N3D5xGbBQJwIBijTypJUd
	iYuGspKfn96BK16H38tZkiGgQ125eB+xX/kJ2TTQ=
Received: by mx.zohomail.com with SMTPS id 1760113351437380.070465019327;
	Fri, 10 Oct 2025 09:22:31 -0700 (PDT)
Message-ID: <7c3e9c5a-2f1f-44e7-9c99-2f0a173bd8eb@collabora.com>
Date: Fri, 10 Oct 2025 17:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 briannorris@chromium.org, johannes@sipsolutions.net, francesco@dolcini.it,
 tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de, brian.hsu@nxp.com
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
 <164050d7-e0db-4a67-bf47-6d88e80d78ab@collabora.com>
 <aOfcb3bwacg8RidH@nxpwireless-Inspiron-14-Plus-7440>
Content-Language: en-US
From: Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <aOfcb3bwacg8RidH@nxpwireless-Inspiron-14-Plus-7440>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 09/10/2025 17:01, Jeff Chen wrote:
> On Tue, Oct 07, 2025 at 05:49:59 PM +0100, Martyn Welch wrote:
>> This seems to be working well for me, at least for Wifi. I'd like to get
>> Bluetooth up as well. The bluetooth driver (btnxpuart) doesn't seem happy
>> loading the bluetooh firmware:
>>
>> [   35.930755] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
>> [   37.953107] Bluetooth: hci0: FW Download Complete: 396444 bytes
>> [   37.953167] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   39.277635] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   39.292011] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   39.310094] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   39.330273] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   39.351381] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   39.373112] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   41.353087] Bluetooth: hci0: Opcode 0x1002 failed: -110
>> [   41.358411] Bluetooth: hci0: command 0x1002 tx timeout
>>
>> I think the "combo" firmware needs to be loaded by the WiFi driver right? I
>> assume this isn't supported yet?
>>
>> Martyn
>>
> Hi Martyn,
> 
> Thanks for testing the nxpwifi driver. On our side, we haven’t seen issues
> with Bluetooth on the NXP i.MX93 EVK platform, regardless of whether the nxpwifi
> driver loads the Wi-Fi-only firmware or the combo firmware.
> 
>  From your logs, it looks like you're loading the Wi-Fi-only firmware
> (nxp/uartspi_n61x_v1.bin.se). If it were the combo firmware, the btnxpuart
> driver would skip loading the BT firmware entirely, since it would already
> be downloaded by the Wi-Fi driver.
> 

Yes, I'm currently using the wifi only firmware. If I'm not mistaken, 
that's the only firmware that the NXPWifi driver will currently use. It 
appears that it should be able to load `firmware_sdiouart`, but that 
doesn't appear to be set anywhere and thus it's not considered. I tried 
to rename the combo firmware to have the name used for the wifi only 
firmware, but that was failing for me (more about that in a moment).

> To help us reproduce and investigate further, could you please share:
> - Your test platform (SoC, board, etc.)

Custom board based on Renesas RZ-G2L, using Ezurio Sona NX611 M.2 1216 
module.

Kernel is 6.17 with an added custom DT, a few patches for other hardware 
and the NXPWifi patch series.

Both btnxpuart and nxpwifi are built as modules.

The firmware itself is what Ezurio provide in their Yocto layer:

$ md5sum *
6a9307d27c3bdb3bde800265056ab217  sd_w61x_v1.bin.se
8a28ec7f1b77dbde0ac7568d0426c669  sduart_nw61x_v1.bin.se
d38935f03dbe6da7a9ac3daf58e640bf  uartspi_n61x_v1.bin.se


Looking a bit deeper, if I try and load the combined firmware, the 
bluetooth modules attempts to load before the WiFi driver has had a 
chance to complete loading the firmware which is resulting in the 
firmware failing.

If I blacklist the btnxpuart module (and rename the combo firmware),
it loads:

[   45.781023] nxpwifi_sdio mmc1:0001:1: info: FW download over, size 
944916 bytes
[   45.884760] nxpwifi_sdio mmc1:0001:1: WLAN FW is active
[   45.913045] nxpwifi_sdio mmc1:0001:1: VDLL image: len=109800
[   45.913209] nxpwifi_sdio mmc1:0001:1: Firmware api version 15.1
[   46.023576] nxpwifi_sdio mmc1:0001:1: info: NXPWIFI VERSION: nxpwifi 
1.12 (18.99.3.p15.0)
[   46.023610] nxpwifi_sdio mmc1:0001:1: driver_version = nxpwifi 1.12 
(18.99.3.p15.0)


If I then try to manually load the bluetooth module I get a failure:

[  104.627753] Bluetooth: Core ver 2.22
[  104.628041] NET: Registered PF_BLUETOOTH protocol family
[  104.628053] Bluetooth: HCI device and connection manager initialized
[  104.632606] Bluetooth: HCI socket layer initialized
[  104.632646] Bluetooth: L2CAP socket layer initialized
[  104.632704] Bluetooth: SCO socket layer initialized
[  104.651019] btnxpuart serial0-0: supply vcc not found, using dummy 
regulator
[  105.245804] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  105.245841] Bluetooth: BNEP filters: protocol multicast
[  105.245866] Bluetooth: BNEP socket layer initialized
[  105.672560] Bluetooth: hci0: FW already running.
[  105.775233] Bluetooth: hci0: Frame reassembly failed (-84)
[  105.781369] Bluetooth: hci0: Frame reassembly failed (-84)
[  105.787899] Bluetooth: hci0: Frame reassembly failed (-84)
[  105.794313] Bluetooth: hci0: Frame reassembly failed (-84)
[  105.800861] Bluetooth: hci0: Frame reassembly failed (-84)
[  105.806457] Bluetooth: hci0: Frame reassembly failed (-84)
[  105.811925] ------------[ cut here ]------------
[  105.811929] Unbalanced enable for IRQ 38
[  105.811953] WARNING: CPU: 0 PID: 40 at kernel/irq/manage.c:753 
__enable_irq+0x54/0x90
[  105.811979] Modules linked in: bnep btnxpuart bluetooth ecdh_generic 
ecc snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nxpwifi_sdio 
nxpwifi joydev cfg80211 aes_ce_blk aes_ce_cipher polyval_ce ghash_ce 
snd_soc_tlv320aic3x_i2c snd_soc_simple_card snd_soc_rz_ssi 
snd_soc_tlv320aic3x snd_soc_simple_card_utils snd_soc_bt_sco gf128mul 
snd_soc_core snd_compress snd_pcm_dmaengine rzg2l_cru snd_pcm goodix_ts 
v4l2_fwnode v4l2_async rzg2l_thermal snd_timer optee snd ffa_core tee 
leds_gpio soundcore cpufreq_dt rfkill qrtr evdev ip6t_REJECT 
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables x_tables 
efi_pstore configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 cls_cgroup 
rzg2l_du_drm drm_display_helper panel_simple cec rc_core panfrost 
gpu_sched micrel vsp1 phy_package drm_client_lib ravb drm_shmem_helper 
rzg2l_mipi_dsi drm_dma_helper mdio_bitbang videobuf2_vmalloc 
drm_kms_helper of_mdio videobuf2_dma_contig videobuf2_memops fixed_phy 
videobuf2_v4l2
[  105.812215]  fwnode_mdio drm videodev libphy 
renesas_sdhi_internal_dmac renesas_sdhi_core reset_rzg2l_usbphy_ctrl 
mdio_bus rzg2l_wdt videobuf2_common tmio_mmc_core mc rcar_fcp i2c_riic 
pwm_rz_mtu3 fixed gpio_keys_polled pwm_bl
[  105.812270] CPU: 0 UID: 0 PID: 40 Comm: kworker/u4:2 Not tainted 
6.17.0+ #10 VOLUNTARY
[  105.812281] Hardware name: Custom Board (DT)
[  105.812288] Workqueue: events_unbound flush_to_ldisc
[  105.812305] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  105.812313] pc : __enable_irq+0x54/0x90
[  105.812321] lr : __enable_irq+0x54/0x90
[  105.812329] sp : ffff800080003db0
[  105.812332] x29: ffff800080003db0 x28: ffff00007fbcf140 x27: 
ffff00000ae212c0
[  105.812343] x26: ffff00007fbcf140 x25: ffff00007fbcf140 x24: 
0000000000000006
[  105.812352] x23: 00000000000000c0 x22: 0000000000000000 x21: 
00000000000000c0
[  105.812362] x20: 0000000000000026 x19: ffff000010ed3200 x18: 
00000000ffffffff
[  105.812371] x17: ffff7ffffe0a5000 x16: ffff800080000000 x15: 
ffff800081fefa4c
[  105.812380] x14: 0000000000000000 x13: 3833205152492072 x12: 
ffff800081c84a90
[  105.812390] x11: ffff800081c2cae8 x10: ffff800081c84ae8 x9 : 
ffff800080170a2c
[  105.812399] x8 : 0000000000000001 x7 : 0000000000017fe8 x6 : 
c0000000ffffefff
[  105.812408] x5 : ffff00007fbcb508 x4 : 0000000000000000 x3 : 
ffff7ffffe0a5000
[  105.812418] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff00000ae212c0
[  105.812428] Call trace:
[  105.812433]  __enable_irq+0x54/0x90 (P)
[  105.812444]  enable_irq+0x74/0xe8
[  105.812453]  sci_dma_rx_reenable_irq+0x70/0xe0
[  105.812465]  sci_dma_rx_timer_fn+0x234/0x3b0
[  105.812474]  __hrtimer_run_queues+0x130/0x2e0
[  105.812487]  hrtimer_interrupt+0x10c/0x2e0
[  105.812498]  arch_timer_handler_virt+0x34/0x60
[  105.812514]  handle_percpu_devid_irq+0x88/0x1b0
[  105.812525]  handle_irq_desc+0x3c/0x68
[  105.812534]  generic_handle_domain_irq+0x24/0x40
[  105.812542]  gic_handle_irq+0x54/0x140
[  105.812551]  call_on_irq_stack+0x30/0x48
[  105.812560]  do_interrupt_handler+0x88/0xa0
[  105.812569]  el1_interrupt+0x34/0x58
[  105.812583]  el1h_64_irq_handler+0x18/0x28
[  105.812590]  el1h_64_irq+0x6c/0x70
[  105.812598]  console_flush_all+0x2dc/0x3b8 (P)
[  105.812611]  console_unlock+0x8c/0x160
[  105.812621]  vprintk_emit+0x304/0x388
[  105.812631]  vprintk_default+0x40/0x58
[  105.812641]  vprintk+0x30/0x48
[  105.812651]  _printk+0x68/0xa0
[  105.812660]  bt_err+0x6c/0x9a8 [bluetooth]
[  105.812881]  btnxpuart_receive_buf+0x170/0x318 [btnxpuart]
[  105.812901]  ttyport_receive_buf+0x6c/0xe0
[  105.812916]  flush_to_ldisc+0xbc/0x1b0
[  105.812927]  process_one_work+0x178/0x3c8
[  105.812941]  worker_thread+0x208/0x400
[  105.812951]  kthread+0x120/0x220
[  105.812961]  ret_from_fork+0x10/0x20
[  105.812972] ---[ end trace 0000000000000000 ]---
[  105.815082] Bluetooth: hci0: Frame reassembly failed (-84)
[  107.816594] Bluetooth: hci0: Opcode 0x1002 failed: -110



> - Your test steps

At the moment, booting and checking to see if the hardware has probed.
If it has, ensure I can connect to my wifi network and ensure that I can 
pass a little bit of traffic.

> - The exact firmware version you're using

As above.

> Also, have you tried running Bluetooth in a BT-only scenario (without loading
> the Wi-Fi driver)? Does that work correctly?
> 

I hadn't. Just gave that a go and I seem to be getting the same failure 
(though :

$ sudo dmesg | grep hci0
[   40.859055] Bluetooth: hci0: ChipID: 7601, Version: 0
[   40.889487] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[   42.850682] Bluetooth: hci0: FW Download Complete: 396444 bytes
[   42.850736] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.222243] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.230226] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.237480] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.247567] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.254188] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.263459] Bluetooth: hci0: Frame reassembly failed (-84)
[   44.269814] Bluetooth: hci0: Frame reassembly failed (-84)
[   46.280494] Bluetooth: hci0: Opcode 0x1002 failed: -110
[   46.285835] Bluetooth: hci0: command 0x1002 tx timeout


Are there any BT patches that I'm missing?

Martyn

> Thanks,
> Jeff


