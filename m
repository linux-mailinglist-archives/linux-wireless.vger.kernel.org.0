Return-Path: <linux-wireless+bounces-28876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD29C54096
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085014E3A84
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12372750E6;
	Wed, 12 Nov 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="HzYKJrIi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E702609CC
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973595; cv=none; b=JBLiWaAHPCXTSA5oscHzHuSAT45VoP6JOmGkXt4gx8IQKjoMKx7YhZsl7Vib40LFJxfQ+YooE5t7ZBromf5ZTjCvMqoeCxx8ySrHaaOAPz8jdgHi1so4iODC9YNSRQsxyvLm7KzdbtH7RfHDZQ4BuwKYlIlHY4Q1RljISEl0mCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973595; c=relaxed/simple;
	bh=FTPUx46PwW5YH4oFn8ERDhqp6Mi/zr69tlES8hfd7D8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CzN4Zbtvx2kfzMi+2f46mcfxFBPvqSGY40nCjqqwfrq0Z+sJwx469Bb0khA7vtrDpFvGhUduYh8SSOe9LijdOaPmMjwVZsEgguzkCkmQTtG1XObMQ/Fal/MrIiNz/lJll8rPvvIeBazYNVxT4vGjsw8HrMgO3I4ey2dTCROXOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=HzYKJrIi; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5C971280088;
	Wed, 12 Nov 2025 18:53:04 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E18F313C2B0;
	Wed, 12 Nov 2025 10:53:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E18F313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1762973582;
	bh=FTPUx46PwW5YH4oFn8ERDhqp6Mi/zr69tlES8hfd7D8=;
	h=Date:To:Cc:From:Subject:From;
	b=HzYKJrIi6Z3WGuU61dpBrzPpXt8EB3ajMCplTMmM5iAtRLJzf438LWGM/qDrhBEkR
	 kfLDMHNXkYk7H7H+dvV6zSU7/WyE6T1Iz//JYx4bRVDVprLGPW9iO5prUoaiojNcNF
	 94+IFRjja5dvVrl3yQhCsY1hGAXH/9bkxbaz8J3A=
Message-ID: <ce2b8d2c-dfa1-35bf-45e9-91e057740a1f@candelatech.com>
Date: Wed, 12 Nov 2025 10:53:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
From: Ben Greear <greearb@candelatech.com>
Subject: 6.18.0-rc5+ mtk7996 crash on stock kernel, in scanning code.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1762973585-jYhjqSw9bzD1
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1762973585;jYhjqSw9bzD1;<greearb@candelatech.com>;d07cbf78db220dce000d227a927b0a59
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello Felix & Lore,

Upstream un-modified kernel is crashing when we try to bring up lots of STA vdevs
on mtk7996.  This 'patch' below makes the problem go away.  mvif->wcid is 0x0
in some cases.  We had same patch back in our 6.15 + hacks + mtk owrt patches tree, so not
a new issue most likely.

We do not know why at this point.  Any ideas?

diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 5a875aac410f..01450c2f3a47 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -43,6 +43,15 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
         struct ieee80211_tx_info *info;
         struct sk_buff *skb;

+       if (WARN_ON_ONCE((unsigned long)(mvif) < 4000)) {
+               pr_err("scan-send-probe: mvif: %px\n", mvif);
+               return;
+       }
+       if (WARN_ON_ONCE((unsigned long)(mvif->wcid) < 4000)) {
+               pr_err("scan-send-probe: mvif->wcid: %px\n", mvif->wcid);
+               return;
+       }
+
         skb = ieee80211_probereq_get(phy->hw, vif->addr, ssid->ssid,
                                      ssid->ssid_len, req->ie_len);
         if (!skb)


25739 Nov 12 10:43:50 ct523c-a0af kernel: ------------[ cut here ]------------
  25740 Nov 12 10:43:50 ct523c-a0af kernel: WARNING: CPU: 3 PID: 71 at drivers/net/wireless/mediatek/mt76/scan.c:50 mt76_scan_work+0x41e/0x440 [mt76]
  25741 Nov 12 10:43:50 ct523c-a0af kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q 
garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep snd_hda_codec_intelhdmi intel_rapl_msr snd_hda_codec_hdmi              iTCO_wdt 
coretemp ee1004 intel_pmc_bxt iTCO_vendor_support intel_rapl_common snd_hda_codec_alc662 intel_uncore_frequency 
snd_hda_codec_realtek_lib intel_uncore_frequency_common snd_hda_codec_generic iwlmld mt7996e intel_tcc_cooling snd_hda_intel mt76_connac_lib         mt76 
x86_pkg_temp_thermal snd_intel_dspcfg snd_hda_codec intel_powerclamp pcspkr snd_hda_core mac80211 intel_wmi_thunderbolt iwlwifi                 snd_hwdep btusb 
snd_seq btbcm snd_seq_device btmtk btrtl btintel joydev bluetooth snd_pcm cfg80211 i2c_i801 snd_timer i2c_smbus bfq snd              i2c_mux soundcore 
intel_pmc_core mei_pxp mei_hdcp intel_pch_thermal pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry                  intel_vsec acpi_pad nfsd 
auth_rpcgss nfs_acl lockd grace nfs_localio sch_fq_codel sunrpc fuse zram raid1 dm_raid
  25742 Nov 12 10:43:50 ct523c-a0af kernel:  raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt 
drm_client_lib drm_display_helper drm_kms_helper cec rc_core igb ttm intel_oc_wdt agpgart i2c_algo_bit ixgbe mdio libie_fwlog dca drm hwmon          mei_wdt 
i2c_core video wmi [last unloaded: nfnetlink]
  25743 Nov 12 10:43:50 ct523c-a0af kernel: CPU: 3 UID: 0 PID: 71 Comm: kworker/u32:2 Tainted: G S      W           6.18.0-rc5+ #25 PREEMPT(full)
  25744 Nov 12 10:43:50 ct523c-a0af kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
  25745 Nov 12 10:43:50 ct523c-a0af kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
  25746 Nov 12 10:43:50 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work [mt76]
  25747 Nov 12 10:43:50 ct523c-a0af kernel: RIP: 0010:mt76_scan_work+0x41e/0x440 [mt76]
  25748 Nov 12 10:43:50 ct523c-a0af kernel: Code: fe ff ff 49 8b 3c 24 4c 89 ee e8 ed 62 43 00 e9 a0 fe ff ff 0f 0b 48 c7 c7 bf ff 17 a1 48 89 ee e8         07 
61 60 e0 e9 af fe ff ff <0f> 0b 48 c7 c7 80 06 18 a1 e8 f4 60 60 e0 e9 9c fe ff ff e8 3a c6
  25749 Nov 12 10:43:50 ct523c-a0af kernel: RSP: 0018:ffffc900002efd88 EFLAGS: 00010293
  25750 Nov 12 10:43:50 ct523c-a0af kernel: RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
  25751 Nov 12 10:43:50 ct523c-a0af kernel: RDX: ffff888193d4a2a8 RSI: 0000000000000000 RDI: ffffffffa0dcd9a7
  25752 Nov 12 10:43:50 ct523c-a0af kernel: RBP: ffff88811659f028 R08: 0000000000000000 R09: 0000000000000000
  25753 Nov 12 10:43:50 ct523c-a0af kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffff88812c8ec028
  25754 Nov 12 10:43:50 ct523c-a0af kernel: R13: 0000000000000000 R14: ffff88812cc62470 R15: ffff88813271ac30
  25755 Nov 12 10:43:50 ct523c-a0af kernel: FS:  0000000000000000(0000) GS:ffff8884da546000(0000) knlGS:0000000000000000
  25756 Nov 12 10:43:50 ct523c-a0af kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  25757 Nov 12 10:43:50 ct523c-a0af kernel: CR2: 0000000000422bcc CR3: 0000000002c52001 CR4: 00000000003706f0
  25758 Nov 12 10:43:50 ct523c-a0af kernel: Call Trace:
  25759 Nov 12 10:43:50 ct523c-a0af kernel:  <TASK>
  25760 Nov 12 10:43:50 ct523c-a0af kernel:  ? mt76_scan_work+0x137/0x440 [mt76]
  25761 Nov 12 10:43:50 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
  25762 Nov 12 10:43:50 ct523c-a0af kernel:  worker_thread+0x19a/0x340
  25763 Nov 12 10:43:50 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
  25764 Nov 12 10:43:50 ct523c-a0af kernel:  kthread+0x108/0x220
  25765 Nov 12 10:43:50 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
  25766 Nov 12 10:43:50 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
  25767 Nov 12 10:43:50 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
  25768 Nov 12 10:43:50 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
  25769 Nov 12 10:43:50 ct523c-a0af kernel:  </TASK>
  25770 Nov 12 10:43:50 ct523c-a0af kernel: irq event stamp: 1089214
  25771 Nov 12 10:43:50 ct523c-a0af kernel: hardirqs last  enabled at (1089220): [<ffffffff813d447e>] __up_console_sem+0x5e/0x70
  25772 Nov 12 10:43:50 ct523c-a0af kernel: hardirqs last disabled at (1089225): [<ffffffff813d4463>] __up_console_sem+0x43/0x70
  25773 Nov 12 10:43:50 ct523c-a0af kernel: softirqs last  enabled at (1088276): [<ffffffff81f2ad9c>] napi_pp_put_page+0xac/0xd0
  25774 Nov 12 10:43:50 ct523c-a0af kernel: softirqs last disabled at (1088284): [<ffffffffa0dcd9a7>] mt76_scan_work+0x137/0x440 [mt76]
  25775 Nov 12 10:43:50 ct523c-a0af kernel: ---[ end trace 0000000000000000 ]---
  25776 Nov 12 10:43:50 ct523c-a0af kernel: scan-send-probe: mvif->wcid: 0000000000000000

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


