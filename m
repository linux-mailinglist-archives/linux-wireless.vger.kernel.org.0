Return-Path: <linux-wireless+bounces-13404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA16C98CEC1
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F28D1C21172
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D082A13C90F;
	Wed,  2 Oct 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKA2F1a5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3218EFF8
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857815; cv=none; b=JvsJlepI1sLDFZrTb3kdyyWjF9fmLuGbJxvhPFdLpmtoB0VgqhtQf/UtnF1J915aS0iNpezfBGAgTHCq//8ts501uWHvHaP0WuiWcARC+CkE7OHpS0DBWMY8ywozriAq9AtA+QXKmSfnnwL0ssO/IZjIwlfVd8gIr40zhmL1m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857815; c=relaxed/simple;
	bh=pEGlYcQbqyk2VHKnurmKFtJTjJEuKXhjhOXTWHlprjo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NbJurYWSVQmJdEtqiuvQiwLh2PaYt0cNb8cojVzY/CfX+Lslp84xvTOYQv1zqFoaxVXk20WZhsgX/QkRopYxF6qtvvQQGUdLMJcrOMKaCt2lCi9bdx4ddj8ZTSRhyTQlL7hYny8sUegZoLwYLy1Rm4RHSmN7sozHE1bQnhiOO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKA2F1a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E1FC4CEC5;
	Wed,  2 Oct 2024 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727857815;
	bh=pEGlYcQbqyk2VHKnurmKFtJTjJEuKXhjhOXTWHlprjo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oKA2F1a5QaMu8y1NVuGPXcJU5YHmrLGFsSu5jqBGbxvZuJj5mUPFd/fmzpsxVgrYV
	 x6kxS5GrPdHDIRWDceQQCCBN82Y4EUMmLJi5ET81KSBXLhVWurT7LBnSPRqTcK6go4
	 Bzlvs2WHx5gJ+kz9/caYk0r/ldlJXly0exa0YlnQcehCVt+/VYhT6DiwfJurzA7b54
	 gts+Qu2tlpgYYDbuvy/7hNxyY+gO3T6fQN8LoeuWvKWH3CrQFGLsRimBYYMKFTy1MD
	 4T+P3nscN6W4bAB+1ZlX50AA9EwJI29ou0gTuLCfMDD85gAhFo/GY0jZp5yIMiZOd+
	 ev8Ibu7dmgtJg==
From: Kalle Valo <kvalo@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] iwlegacy: Clear stale interrupts before resuming device
References: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
	<20241001200745.8276-1-ville.syrjala@linux.intel.com>
	<20241002064952.GA15679@wp.pl> <87frpf6iin.fsf@kernel.org>
Date: Wed, 02 Oct 2024 11:30:12 +0300
In-Reply-To: <87frpf6iin.fsf@kernel.org> (Kalle Valo's message of "Wed, 02 Oct
	2024 11:01:04 +0300")
Message-ID: <87bk027vqj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> Stanislaw Gruszka <stf_xl@wp.pl> writes:
>
>> On Tue, Oct 01, 2024 at 11:07:45PM +0300, Ville Syrjala wrote:
>>
>>> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>>>=20
>>> iwl4965 fails upon resume from hibernation on my laptop. The reason
>>> seems to be a stale interrupt which isn't being cleared out before
>>> interrupts are enabled. We end up with a race beween the resume
>>> trying to bring things back up, and the restart work (queued form
>>> the interrupt handler) trying to bring things down. Eventually
>>> the whole thing blows up.
>>>=20
>>> Fix the problem by clearing out any stale interrupts before
>>> interrupts get enabled during resume.
>>>=20
>>> Here's a debug log of the indicent:
>>> [   12.042589] ieee80211 phy0: il_isr ISR inta 0x00000080, enabled 0xaa=
00008b, fh 0x00000000
>>> [   12.042625] ieee80211 phy0: il4965_irq_tasklet inta 0x00000080, enab=
led 0x00000000, fh 0x00000000
>>> [   12.042651] iwl4965 0000:10:00.0: RF_KILL bit toggled to enable radi=
o.
>>> [   12.042653] iwl4965 0000:10:00.0: On demand firmware reload
>>> [ 12.042690] ieee80211 phy0: il4965_irq_tasklet End inta 0x00000000,
>>> enabled 0xaa00008b, fh 0x00000000, flags 0x00000282
>>> [   12.052207] ieee80211 phy0: il4965_mac_start enter
>>> [   12.052212] ieee80211 phy0: il_prep_station Add STA to driver ID 31:=
 ff:ff:ff:ff:ff:ff
>>> [   12.052244] ieee80211 phy0: il4965_set_hw_ready hardware  ready
>>> [   12.052324] ieee80211 phy0: il_apm_init Init card's basic functions
>>> [   12.052348] ieee80211 phy0: il_apm_init L1 Enabled; Disabling L0S
>>> [   12.055727] ieee80211 phy0: il4965_load_bsm Begin load bsm
>>> [   12.056140] ieee80211 phy0: il4965_verify_bsm Begin verify bsm
>>> [   12.058642] ieee80211 phy0: il4965_verify_bsm BSM bootstrap uCode im=
age OK
>>> [   12.058721] ieee80211 phy0: il4965_load_bsm BSM write complete, poll=
 1 iterations
>>> [   12.058734] ieee80211 phy0: __il4965_up iwl4965 is coming up
>>> [   12.058737] ieee80211 phy0: il4965_mac_start Start UP work done.
>>> [   12.058757] ieee80211 phy0: __il4965_down iwl4965 is going down
>>> [   12.058761] ieee80211 phy0: il_scan_cancel_timeout Scan cancel timeo=
ut
>>> [   12.058762] ieee80211 phy0: il_do_scan_abort Not performing scan to =
abort
>>> [   12.058765] ieee80211 phy0: il_clear_ucode_stations Clearing ucode s=
tations in driver
>>> [   12.058767] ieee80211 phy0: il_clear_ucode_stations No active statio=
ns found to be cleared
>>> [   12.058819] ieee80211 phy0: _il_apm_stop Stop card, put in low power=
 state
>>> [   12.058827] ieee80211 phy0: _il_apm_stop_master stop master
>>> [   12.058864] ieee80211 phy0: il4965_clear_free_frames 0 frames on pre=
-allocated heap on clear.
>>> [   12.058869] ieee80211 phy0: Hardware restart was requested
>>> [   16.132299] iwl4965 0000:10:00.0: START_ALIVE timeout after 4000ms.
>>> [   16.132303] ------------[ cut here ]------------
>>> [ 16.132304] Hardware became unavailable upon resume. This could be
>>> a software issue prior to suspend or a hardware issue.
>>> [   16.132338] WARNING: CPU: 0 PID: 181 at net/mac80211/util.c:1826 iee=
e80211_reconfig+0x8f/0x14b0 [mac80211]
>>> [ 16.132390] Modules linked in: ctr ccm sch_fq_codel xt_tcpudp
>>> xt_multiport xt_state iptable_filter iptable_nat nf_nat nf_conntrack
>>> nf_defrag_ipv4 ip_tables x_tables binfmt_misc joydev mousedev btusb
>>> btrtl btintel btbcm bluetooth ecdh_generic ecc iTCO_wdt i2c_dev
>>> iwl4965 iwlegacy coretemp snd_hda_codec_analog pcspkr psmouse
>>> mac80211 snd_hda_codec_generic libarc4 sdhci_pci cqhci
>>> sha256_generic sdhci libsha256 firewire_ohci snd_hda_intel
>>> snd_intel_dspcfg mmc_core snd_hda_codec snd_hwdep firewire_core
>>> led_class iosf_mbi snd_hda_core uhci_hcd lpc_ich crc_itu_t cfg80211
>>> ehci_pci ehci_hcd snd_pcm usbcore mfd_core rfkill snd_timer snd
>>> usb_common soundcore video parport_pc parport intel_agp wmi
>>> intel_gtt backlight e1000e agpgart evdev
>>> [   16.132456] CPU: 0 UID: 0 PID: 181 Comm: kworker/u8:6 Not tainted 6.=
11.0-cl+ #143
>>> [   16.132460] Hardware name: Hewlett-Packard HP Compaq 6910p/30BE, BIO=
S 68MCU Ver. F.19 07/06/2010
>>> [   16.132463] Workqueue: async async_run_entry_fn
>>> [   16.132469] RIP: 0010:ieee80211_reconfig+0x8f/0x14b0 [mac80211]
>>> [ 16.132501] Code: da 02 00 00 c6 83 ad 05 00 00 00 48 89 df e8 98
>>> 1b fc ff 85 c0 41 89 c7 0f 84 e9 02 00 00 48 c7 c7 a0 e6 48 a0 e8 d1
>>> 77 c4 e0 <0f> 0b eb 2d 84 c0 0f 85 8b 01 00 00 c6 87 ad 05 00 00 00
>>> e8 69 1b
>>> [   16.132504] RSP: 0018:ffffc9000029fcf0 EFLAGS: 00010282
>>> [   16.132507] RAX: 0000000000000000 RBX: ffff8880072008e0 RCX: 0000000=
000000001
>>> [   16.132509] RDX: ffffffff81f21a18 RSI: 0000000000000086 RDI: 0000000=
000000001
>>> [   16.132510] RBP: ffff8880072003c0 R08: 0000000000000000 R09: 0000000=
000000003
>>> [   16.132512] R10: 0000000000000000 R11: ffff88807e5b0000 R12: 0000000=
000000001
>>> [   16.132514] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
0ffffff92
>>> [   16.132515] FS:  0000000000000000(0000) GS:ffff88807c200000(0000) kn=
lGS:0000000000000000
>>> [   16.132517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   16.132519] CR2: 000055dd43786c08 CR3: 000000000978f000 CR4: 0000000=
0000006f0
>>> [   16.132521] Call Trace:
>>> [   16.132525]  <TASK>
>>> [   16.132526]  ? __warn+0x77/0x120
>>> [   16.132532]  ? ieee80211_reconfig+0x8f/0x14b0 [mac80211]
>>> [   16.132564]  ? report_bug+0x15c/0x190
>>> [   16.132568]  ? handle_bug+0x36/0x70
>>> [   16.132571]  ? exc_invalid_op+0x13/0x60
>>> [   16.132573]  ? asm_exc_invalid_op+0x16/0x20
>>> [   16.132579]  ? ieee80211_reconfig+0x8f/0x14b0 [mac80211]
>>> [   16.132611]  ? snd_hdac_bus_init_cmd_io+0x24/0x200 [snd_hda_core]
>>> [   16.132617]  ? pick_eevdf+0x133/0x1c0
>>> [   16.132622]  ? check_preempt_wakeup_fair+0x70/0x90
>>> [   16.132626]  ? wakeup_preempt+0x4a/0x60
>>> [   16.132628]  ? ttwu_do_activate.isra.0+0x5a/0x190
>>> [   16.132632]  wiphy_resume+0x79/0x1a0 [cfg80211]
>>> [   16.132675]  ? wiphy_suspend+0x2a0/0x2a0 [cfg80211]
>>> [   16.132697]  dpm_run_callback+0x75/0x1b0
>>> [   16.132703]  device_resume+0x97/0x200
>>> [   16.132707]  async_resume+0x14/0x20
>>> [   16.132711]  async_run_entry_fn+0x1b/0xa0
>>> [   16.132714]  process_one_work+0x13d/0x350
>>> [   16.132718]  worker_thread+0x2be/0x3d0
>>> [   16.132722]  ? cancel_delayed_work_sync+0x70/0x70
>>> [   16.132725]  kthread+0xc0/0xf0
>>> [   16.132729]  ? kthread_park+0x80/0x80
>>> [   16.132732]  ret_from_fork+0x28/0x40
>>> [   16.132735]  ? kthread_park+0x80/0x80
>>> [   16.132738]  ret_from_fork_asm+0x11/0x20
>>> [   16.132741]  </TASK>
>>> [   16.132742] ---[ end trace 0000000000000000 ]---
>>> [   16.132930] ------------[ cut here ]------------
>>> [   16.132932] WARNING: CPU: 0 PID: 181 at net/mac80211/driver-ops.c:41=
 drv_stop+0xe7/0xf0 [mac80211]
>>> [ 16.132957] Modules linked in: ctr ccm sch_fq_codel xt_tcpudp
>>> xt_multiport xt_state iptable_filter iptable_nat nf_nat nf_conntrack
>>> nf_defrag_ipv4 ip_tables x_tables binfmt_misc joydev mousedev btusb
>>> btrtl btintel btbcm bluetooth ecdh_generic ecc iTCO_wdt i2c_dev
>>> iwl4965 iwlegacy coretemp snd_hda_codec_analog pcspkr psmouse
>>> mac80211 snd_hda_codec_generic libarc4 sdhci_pci cqhci
>>> sha256_generic sdhci libsha256 firewire_ohci snd_hda_intel
>>> snd_intel_dspcfg mmc_core snd_hda_codec snd_hwdep firewire_core
>>> led_class iosf_mbi snd_hda_core uhci_hcd lpc_ich crc_itu_t cfg80211
>>> ehci_pci ehci_hcd snd_pcm usbcore mfd_core rfkill snd_timer snd
>>> usb_common soundcore video parport_pc parport intel_agp wmi
>>> intel_gtt backlight e1000e agpgart evdev
>>> [   16.133014] CPU: 0 UID: 0 PID: 181 Comm: kworker/u8:6 Tainted: G    =
    W          6.11.0-cl+ #143
>>> [   16.133018] Tainted: [W]=3DWARN
>>> [   16.133019] Hardware name: Hewlett-Packard HP Compaq 6910p/30BE, BIO=
S 68MCU Ver. F.19 07/06/2010
>>> [   16.133021] Workqueue: async async_run_entry_fn
>>> [   16.133025] RIP: 0010:drv_stop+0xe7/0xf0 [mac80211]
>>> [ 16.133048] Code: 48 85 c0 74 0e 48 8b 78 08 89 ea 48 89 de e8 e0
>>> 87 04 00 65 ff 0d d1 de c4 5f 0f 85 42 ff ff ff e8 be 52 c2 e0 e9 38
>>> ff ff ff <0f> 0b 5b 5d c3 0f 1f 40 00 41 54 49 89 fc 55 53 48 89 f3
>>> 2e 2e 2e
>>> [   16.133050] RSP: 0018:ffffc9000029fc50 EFLAGS: 00010246
>>> [   16.133053] RAX: 0000000000000000 RBX: ffff8880072008e0 RCX: ffff888=
00377f6c0
>>> [   16.133054] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888=
0072008e0
>>> [   16.133056] RBP: 0000000000000000 R08: ffffffff81f238d8 R09: 0000000=
000000000
>>> [   16.133058] R10: ffff8880080520f0 R11: 0000000000000000 R12: ffff888=
008051c60
>>> [   16.133060] R13: ffff8880072008e0 R14: 0000000000000000 R15: ffff888=
0072011d8
>>> [   16.133061] FS:  0000000000000000(0000) GS:ffff88807c200000(0000) kn=
lGS:0000000000000000
>>> [   16.133063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   16.133065] CR2: 000055dd43786c08 CR3: 000000000978f000 CR4: 0000000=
0000006f0
>>> [   16.133067] Call Trace:
>>> [   16.133069]  <TASK>
>>> [   16.133070]  ? __warn+0x77/0x120
>>> [   16.133075]  ? drv_stop+0xe7/0xf0 [mac80211]
>>> [   16.133098]  ? report_bug+0x15c/0x190
>>> [   16.133100]  ? handle_bug+0x36/0x70
>>> [   16.133103]  ? exc_invalid_op+0x13/0x60
>>> [   16.133105]  ? asm_exc_invalid_op+0x16/0x20
>>> [   16.133109]  ? drv_stop+0xe7/0xf0 [mac80211]
>>> [   16.133132]  ieee80211_do_stop+0x55a/0x810 [mac80211]
>>> [   16.133161]  ? fq_codel_reset+0xa5/0xc0 [sch_fq_codel]
>>> [   16.133164]  ieee80211_stop+0x4f/0x180 [mac80211]
>>> [   16.133192]  __dev_close_many+0xa2/0x120
>>> [   16.133195]  dev_close_many+0x90/0x150
>>> [   16.133198]  dev_close+0x5d/0x80
>>> [   16.133200]  cfg80211_shutdown_all_interfaces+0x40/0xe0 [cfg80211]
>>> [   16.133223]  wiphy_resume+0xb2/0x1a0 [cfg80211]
>>> [   16.133247]  ? wiphy_suspend+0x2a0/0x2a0 [cfg80211]
>>> [   16.133269]  dpm_run_callback+0x75/0x1b0
>>> [   16.133273]  device_resume+0x97/0x200
>>> [   16.133277]  async_resume+0x14/0x20
>>> [   16.133280]  async_run_entry_fn+0x1b/0xa0
>>> [   16.133283]  process_one_work+0x13d/0x350
>>> [   16.133287]  worker_thread+0x2be/0x3d0
>>> [   16.133290]  ? cancel_delayed_work_sync+0x70/0x70
>>> [   16.133294]  kthread+0xc0/0xf0
>>> [   16.133296]  ? kthread_park+0x80/0x80
>>> [   16.133299]  ret_from_fork+0x28/0x40
>>> [   16.133302]  ? kthread_park+0x80/0x80
>>> [   16.133304]  ret_from_fork_asm+0x11/0x20
>>> [   16.133307]  </TASK>
>>> [   16.133308] ---[ end trace 0000000000000000 ]---
>>> [   16.133335] ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume [cf=
g80211] returns -110
>>> [   16.133360] ieee80211 phy0: PM: failed to restore async: error -110
>>>=20
>>> v2: Clear only in il_pci_resume() instead of il_enable_interrupts()
>>>     to miminize changes to runtime behaviour
>
> In wireless we don't include the list of changes so I'll remove this.
>
>>> Cc: stable@vger.kernel.org
>>> Cc: Stanislaw Gruszka <stf_xl@wp.pl>
>>> Cc: Kalle Valo <kvalo@kernel.org>
>>> Cc: linux-wireless@vger.kernel.org
>>> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>>
>> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
>
> Is this a regression? Should there be a Fixes tag? I can add that, no
> need to resend.

Noticed now Ville's reply to v1, looks like this is not a regression so
I'm not addding a Fixes tag. But I'll queue this to wireless tree.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

